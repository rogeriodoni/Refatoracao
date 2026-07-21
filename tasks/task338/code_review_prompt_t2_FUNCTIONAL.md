# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRIFF.Container1): Top original=8 vs migrado 'lbl_4c_Label1' Top=257 (diff=249px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRIFF.Container1): Left original=4 vs migrado 'lbl_4c_Label1' Left=168 (diff=164px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRIFF.Container1): Top original=3 vs migrado 'lbl_4c_Label2' Top=161 (diff=158px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRIFF.Container1): Left original=4 vs migrado 'lbl_4c_Label2' Left=143 (diff=139px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRIFF.Container1): Top original=21 vs migrado 'lbl_4c_Label3' Top=194 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRIFF.Container1): Left original=4 vs migrado 'lbl_4c_Label3' Left=288 (diff=284px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRIFF.Container1): Top original=39 vs migrado 'lbl_4c_Label4' Top=226 (diff=187px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRIFF.Container1): Left original=4 vs migrado 'lbl_4c_Label4' Left=288 (diff=284px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTFH.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1015 linhas total):

*-- Linhas 32 a 264:
32:     this_cRetValores     = ""
33: 
34:     *==========================================================================
35:     PROCEDURE Init
36:     *==========================================================================
37:     LPARAMETERS par_cIP, par_nInicio, par_nValor, par_cCupom, par_cCaixa, ;
38:                 par_nIdent, par_cPos, par_nParcelas, par_cFuncoes, ;
39:                 par_cBanco, par_cAgencia, par_cConta, par_cNumeroCheque, ;
40:                 par_cDtCheque, par_cCPF, par_cTipoPessoa, par_cCupomNV, ;
41:                 par_cAgenciaDV, par_cContaDV, par_cChequeDV, par_cPraca, ;
42:                 par_cPesquisa, par_cCMC7, par_cTeste
43: 
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTFHBO")
49:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
50:                 MsgErro("Erro ao criar SIGPRTFHBO.", "Erro")
51:                 loc_lSucesso = .F.
52:             ENDIF
53: 
54:             *-- Repassa todos os parametros da transacao ao BO
55:             THIS.this_oBusinessObject.CarregarParametros( ;
56:                 IIF(VARTYPE(par_cIP)          = "C", par_cIP,          ""), ;
57:                 IIF(VARTYPE(par_nInicio)       = "N", par_nInicio,       0), ;
58:                 IIF(VARTYPE(par_nValor)        = "N", par_nValor,        0), ;
59:                 IIF(VARTYPE(par_cCupom)        = "C", par_cCupom,        ""), ;
60:                 IIF(VARTYPE(par_cCaixa)        = "C", par_cCaixa,        ""), ;
61:                 IIF(VARTYPE(par_nIdent)        = "N", par_nIdent,        0), ;
62:                 IIF(VARTYPE(par_cPos)          = "C", par_cPos,          ""), ;
63:                 IIF(VARTYPE(par_nParcelas)     = "N", par_nParcelas,     0), ;
64:                 IIF(VARTYPE(par_cFuncoes)      = "C", par_cFuncoes,      ""), ;
65:                 IIF(VARTYPE(par_cBanco)        = "C", par_cBanco,        ""), ;
66:                 IIF(VARTYPE(par_cAgencia)      = "C", par_cAgencia,      ""), ;
67:                 IIF(VARTYPE(par_cConta)        = "C", par_cConta,        ""), ;
68:                 IIF(VARTYPE(par_cNumeroCheque) = "C", par_cNumeroCheque, ""), ;
69:                 IIF(VARTYPE(par_cDtCheque)     = "C", par_cDtCheque,     ""), ;
70:                 IIF(VARTYPE(par_cCPF)          = "C", par_cCPF,          ""), ;
71:                 IIF(VARTYPE(par_cTipoPessoa)   = "C", par_cTipoPessoa,   "F"), ;
72:                 IIF(VARTYPE(par_cCupomNV)      = "C", par_cCupomNV,      ""), ;
73:                 IIF(VARTYPE(par_cAgenciaDV)    = "C", par_cAgenciaDV,    ""), ;
74:                 IIF(VARTYPE(par_cContaDV)      = "C", par_cContaDV,      ""), ;
75:                 IIF(VARTYPE(par_cChequeDV)     = "C", par_cChequeDV,     ""), ;
76:                 IIF(VARTYPE(par_cPraca)        = "C", par_cPraca,        ""), ;
77:                 IIF(VARTYPE(par_cPesquisa)     = "C", par_cPesquisa,     ""), ;
78:                 IIF(VARTYPE(par_cCMC7)         = "C", par_cCMC7,         "") ;
79:             )
80: 
81:             loc_lSucesso = DODEFAULT()
82:             IF loc_lSucesso
83:                 THIS.PopularCamposDoBO()
84:             ENDIF
85: 
86:         CATCH TO loc_oErro
87:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
88:                 "Erro ao inicializar FormSIGPRTFH")
89:             loc_lSucesso = .F.
90:         ENDTRY
91: 
92:         RETURN loc_lSucesso
93:     ENDPROC
94: 
95:     *==========================================================================
96:     PROTECTED PROCEDURE InicializarForm
97:     *==========================================================================
98:         LOCAL loc_lSucesso, loc_oErro
99: 
100:         loc_lSucesso = .F.
101:         TRY
102:             THIS.ConfigurarPageFrame()
103:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
104:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
105:             THIS.ConfigurarBotaoCancela()
106:             THIS.ConfigurarCorpoForm()
107:             THIS.ConfigurarCamposForm()
108:             THIS.ConfigurarContainerStatus()
109:             THIS.TornarControlesVisiveis(THIS)
110:             loc_lSucesso = .T.
111:         CATCH TO loc_oErro
112:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
113:                 " PROC=" + loc_oErro.Procedure, "Erro InicializarForm SIGPRTFH")
114:             loc_lSucesso = .F.
115:         ENDTRY
116: 
117:         RETURN loc_lSucesso
118:     ENDPROC
119: 
120:     *==========================================================================
121:     * ConfigurarPageFrame
122:     * Form OPERACIONAL (SiTef Consulta Cheque) usa layout customizado 467x350
123:     * sem PageFrame - controles diretos no Form. Este metodo cria o cabecalho
124:     * cinza superior (cnt_4c_Cabecalho + lbl_4c_Sombra + lbl_4c_Titulo) que eh
125:     * a estrutura visual base do form.
126:     *==========================================================================
127:     PROTECTED PROCEDURE ConfigurarPageFrame
128:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH THIS.cnt_4c_Cabecalho
130:             .Top         = 1
131:             .Left        = 1
132:             .Width       = THIS.Width
133:             .Height      = 80
134:             .BackStyle   = 1
135:             .BackColor   = RGB(100,100,100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
141:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
142:             .Top      = 18
143:             .Left     = 10
144:             .Width    = THIS.cnt_4c_Cabecalho.Width - 20
145:             .Height   = 40
146:             .AutoSize = .F.
147:             .BackStyle = 0
148:             .FontName  = "Tahoma"
149:             .FontSize  = 18
150:             .FontBold  = .T.
151:             .ForeColor = RGB(0,0,0)
152:             .WordWrap  = .T.
153:             .Caption   = "SiTef - Consulta de Cheque"
154:         ENDWITH
155: 
156:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
157:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
158:             .Top      = 17
159:             .Left     = 10
160:             .Width    = THIS.cnt_4c_Cabecalho.Width - 20
161:             .Height   = 46
162:             .AutoSize = .F.
163:             .BackStyle = 0
164:             .FontName  = "Tahoma"
165:             .FontSize  = 18
166:             .FontBold  = .T.
167:             .ForeColor = RGB(255,255,255)
168:             .WordWrap  = .T.
169:             .Caption   = "SiTef - Consulta de Cheque"
170:         ENDWITH
171:     ENDPROC
172: 
173:     *==========================================================================
174:     * ConfigurarBotaoCancela
175:     * Botao CANCELA: unico controle focalizavel (todos os txt_ tem Enabled=.F.)
176:     * O GotFocus dispara automaticamente ao abrir o form e inicia o loop SiTef.
177:     *==========================================================================
178:     PROTECTED PROCEDURE ConfigurarBotaoCancela
179:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
180:         WITH THIS.cmd_4c_Cancela
181:             .Top           = -1
182:             .Left          = 387
183:             .Width         = 75
184:             .Height        = 75
185:             .FontBold      = .T.
186:             .FontItalic    = .T.
187:             .FontName      = "Tahoma"
188:             .FontSize      = 8
189:             .ForeColor     = RGB(90,90,90)
190:             .BackColor     = RGB(255,255,255)
191:             .Picture       = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
192:             .Themes        = .T.
193:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
194:             .SpecialEffect = 0
195:             .PicturePosition = 13
196:             .WordWrap      = .T.
197:             .Cancel        = .T.
198:             .Caption       = "<Esc> \<Sair"
199:         ENDWITH
200: 
201:         BINDEVENT(THIS.cmd_4c_Cancela, "GotFocus", THIS, "CmdCancelaGotFocus")
202:         BINDEVENT(THIS.cmd_4c_Cancela, "Click",    THIS, "CmdCancelaClick")
203:     ENDPROC
204: 
205:     *==========================================================================
206:     * ConfigurarCorpoForm
207:     * Painel visual (Shape2) que delimita a area de dados do cheque
208:     *==========================================================================
209:     PROTECTED PROCEDURE ConfigurarCorpoForm
210:         THIS.AddObject("shp_4c_Painel", "Shape")
211:         WITH THIS.shp_4c_Painel
212:             .Top           = 84
213:             .Left          = 0
214:             .Width         = 466
215:             .Height        = 202
216:             .SpecialEffect = 0
217:         ENDWITH
218:     ENDPROC
219: 
220:     *==========================================================================
221:     * ConfigurarContainerStatus
222:     * Container1 do legado: exibe mensagens de status durante a consulta SiTef
223:     *==========================================================================
224:     PROTECTED PROCEDURE ConfigurarContainerStatus
225:         THIS.AddObject("cnt_4c_Status", "Container")
226:         WITH THIS.cnt_4c_Status
227:             .Top           = 288
228:             .Left          = 37
229:             .Width         = 393
230:             .Height        = 58
231:             .SpecialEffect = 0
232:             .BackStyle     = 1
233:             .BackColor     = RGB(255,255,255)
234:             .Visible     = .T.
235:         ENDWITH
236: 
237:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status1", "Label")
238:         WITH THIS.cnt_4c_Status.lbl_4c_Status1
239:             .Top       = 8
240:             .Left      = 4
241:             .Width     = 383
242:             .Height    = 43
243:             .AutoSize  = .F.
244:             .Alignment = 2
245:             .FontBold  = .T.
246:             .FontName  = "Tahoma"
247:             .FontSize  = 8
248:             .ForeColor = RGB(90,90,90)
249:             .BackStyle = 0
250:             .Caption   = "Aguarde Consulta de Cheque"
251:         ENDWITH
252: 
253:         THIS.cnt_4c_Status.AddObject("lbl_4c_Status2", "Label")
254:         WITH THIS.cnt_4c_Status.lbl_4c_Status2
255:             .Top       = 3
256:             .Left      = 4
257:             .Width     = 383
258:             .Height    = 20
259:             .AutoSize  = .F.
260:             .Alignment = 2
261:             .FontBold  = .T.
262:             .FontName  = "Tahoma"
263:             .FontSize  = 8
264:             .ForeColor = RGB(90,90,90)

*-- Linhas 304 a 406:
304:     * Disparado automaticamente ao abrir o form (todos os txt_ tem Enabled=.F.,
305:     * CANCELA eh o unico controle focalizavel). Executa a consulta SiTef.
306:     *==========================================================================
307:     PROCEDURE CmdCancelaGotFocus
308:         LOCAL loc_lSucesso, loc_oErro
309: 
310:         loc_lSucesso = .F.
311:         TRY
312:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
313:                 THIS.this_oBusinessObject.CarregarDLL()
314: 
315:                 THIS.AtualizarStatus( ;
316:                     "Aguarde...", ;
317:                     "Consultando cheque no SiTef", ;
318:                     "", ;
319:                     "")
320: 
321:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
322: 
323:                 THIS.ExibirResultadoConsulta(loc_lSucesso)
324:             ENDIF
325:         CATCH TO loc_oErro
326:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
327:                 "Erro ConsultaSiTef")
328:         ENDTRY
329:         *-- Nao fecha o form aqui: usuario precisa ler o resultado antes de clicar Sair.
330:         *-- CmdCancelaClick (botao fisico / ESC) faz THIS.Release().
331:     ENDPROC
332: 
333:     *==========================================================================
334:     PROCEDURE CmdCancelaClick
335:     *==========================================================================
336:         IF LASTKEY() = 13
337:             RETURN
338:         ENDIF
339:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
340:             THIS.this_oBusinessObject.this_lAbandona = .T.
341:         ENDIF
342:         THIS.Release()
343:     ENDPROC
344: 
345:     *==========================================================================
346:     * AtualizarStatus - Atualiza as mensagens do container de status
347:     *==========================================================================
348:     PROCEDURE AtualizarStatus(par_cLinha1, par_cLinha2, par_cLinha3, par_cLinha4)
349:         IF VARTYPE(THIS.cnt_4c_Status) # "O"
350:             RETURN
351:         ENDIF
352:         WITH THIS.cnt_4c_Status
353:             .lbl_4c_Status2.Caption = IIF(VARTYPE(par_cLinha1) = "C", par_cLinha1, "")
354:             .lbl_4c_Status3.Caption = IIF(VARTYPE(par_cLinha2) = "C", par_cLinha2, "")
355:             .lbl_4c_Status4.Caption = IIF(VARTYPE(par_cLinha3) = "C", par_cLinha3, "")
356:             .Visible     = .T.
357:         ENDWITH
358:         THIS.cnt_4c_Status.Refresh()
359:     ENDPROC
360: 
361:     *==========================================================================
362:     * ConfigurarCamposForm
363:     * Adiciona labels e textboxes de exibicao dos dados do cheque consultado.
364:     * Todos os TextBox sao Enabled=.F. (somente leitura; dados vem via parametro).
365:     *==========================================================================
366:     PROTECTED PROCEDURE ConfigurarCamposForm
367:         *-- Praca de Compensacao
368:         THIS.AddObject("lbl_4c_Label5", "Label")
369:         WITH THIS.lbl_4c_Label5
370:             .Top       = 97
371:             .Left      = 64
372:             .Width     = 132
373:             .Height    = 15
374:             .AutoSize  = .T.
375:             .FontBold  = .T.
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .ForeColor = RGB(90,90,90)
379:             .BackStyle = 0
380:             .Caption   = "Praca de Compesacao :"
381:         ENDWITH
382: 
383:         THIS.AddObject("txt_4c_Praca", "TextBox")
384:         WITH THIS.txt_4c_Praca
385:             .Top                = 94
386:             .Left               = 198
387:             .Width              = 32
388:             .Height             = 23
389:             .Alignment          = 3
390:             .FontBold           = .T.
391:             .FontName           = "Tahoma"
392:             .FontSize           = 8
393:             .Enabled            = .F.
394:             .DisabledForeColor  = RGB(0,0,0)
395:             .Value              = ""
396:         ENDWITH
397: 
398:         *-- Banco
399:         THIS.AddObject("lbl_4c_Label8", "Label")
400:         WITH THIS.lbl_4c_Label8
401:             .Top       = 129
402:             .Left      = 154
403:             .Width     = 42
404:             .Height    = 15
405:             .AutoSize  = .T.
406:             .FontBold  = .T.

*-- Linhas 636 a 681:
636: 
637:     *==========================================================================
638:     * PopularCamposDoBO - Preenche os campos de exibicao com dados do BO
639:     * Chamado apos InicializarForm (via DODEFAULT no Init)
640:     *==========================================================================
641:     PROCEDURE PopularCamposDoBO()
642:         LOCAL loc_oBo
643: 
644:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
645:             RETURN
646:         ENDIF
647:         loc_oBo = THIS.this_oBusinessObject
648: 
649:         IF VARTYPE(THIS.txt_4c_Praca) = "O"
650:             THIS.txt_4c_Praca.Value = loc_oBo.this_cPraca
651:         ENDIF
652:         IF VARTYPE(THIS.txt_4c_Banco) = "O"
653:             THIS.txt_4c_Banco.Value = loc_oBo.this_cBanco
654:         ENDIF
655:         IF VARTYPE(THIS.txt_4c_Agencia) = "O"
656:             THIS.txt_4c_Agencia.Value = loc_oBo.this_cAgencia
657:         ENDIF
658:         IF VARTYPE(THIS.txt_4c_DvAgencia) = "O"
659:             THIS.txt_4c_DvAgencia.Value = loc_oBo.this_cAgenciaDV
660:         ENDIF
661:         IF VARTYPE(THIS.txt_4c_Conta) = "O"
662:             THIS.txt_4c_Conta.Value = loc_oBo.this_cConta
663:         ENDIF
664:         IF VARTYPE(THIS.txt_4c_DvConta) = "O"
665:             THIS.txt_4c_DvConta.Value = loc_oBo.this_cContaDV
666:         ENDIF
667:         IF VARTYPE(THIS.txt_4c_Cheque) = "O"
668:             THIS.txt_4c_Cheque.Value = loc_oBo.this_cNumeroCheque
669:         ENDIF
670:         IF VARTYPE(THIS.txt_4c_DvCheque) = "O"
671:             THIS.txt_4c_DvCheque.Value = loc_oBo.this_cChequeDV
672:         ENDIF
673:         IF VARTYPE(THIS.txt_4c_Cpf) = "O"
674:             THIS.txt_4c_Cpf.Value = loc_oBo.this_cCPF
675:         ENDIF
676: 
677:         *-- Caption do label CPF vs CGC baseado no tipo de pessoa
678:         IF VARTYPE(THIS.lbl_4c_Label1) = "O"
679:             THIS.lbl_4c_Label1.Caption = IIF(loc_oBo.this_cTipoPessoa = "F", "CPF :", "CGC :")
680:         ENDIF
681: 

*-- Linhas 694 a 737:
694:     * Detecta codigos Serasa e exibe descricao em 3 linhas (vermelho)
695:     * par_lSucesso - .T. se consulta completou com aprovacao
696:     *==========================================================================
697:     PROCEDURE ExibirResultadoConsulta(par_lSucesso)
698:         LOCAL loc_oBo, loc_cRetorno
699:         LOCAL loc_lnSrSearch, loc_lnSrIdx
700:         LOCAL loc_cLinha1, loc_cLinha2, loc_cLinha3
701: 
702:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
703:             RETURN
704:         ENDIF
705:         IF VARTYPE(THIS.cnt_4c_Status) # "O"
706:             RETURN
707:         ENDIF
708: 
709:         loc_oBo     = THIS.this_oBusinessObject
710:         loc_cRetorno = ALLTRIM(loc_oBo.this_cRetornoCheque)
711: 
712:         IF par_lSucesso
713:             THIS.this_cRetValores = loc_cRetorno
714:             WITH THIS.cnt_4c_Status
715:                 .lbl_4c_Status1.Visible   = .T.
716:                 .lbl_4c_Status1.ForeColor = RGB(0,120,0)
717:                 .lbl_4c_Status1.FontSize  = 16
718:                 .lbl_4c_Status1.Caption   = loc_cRetorno
719:                 .lbl_4c_Status2.Visible   = .F.
720:                 .lbl_4c_Status3.Visible   = .F.
721:                 .lbl_4c_Status4.Visible   = .F.
722:             ENDWITH
723:         ELSE
724:             THIS.this_cRetValores = ""
725: 
726:             *-- Verificar se o retorno contem codigo Serasa (2 primeiros chars)
727:             loc_lnSrIdx = 0
728:             IF LEN(loc_cRetorno) >= 2
729:                 FOR loc_lnSrSearch = 1 TO 8
730:                     IF loc_oBo.ObterCodigoSerasa(loc_lnSrSearch) = SUBSTR(loc_cRetorno, 1, 2)
731:                         loc_lnSrIdx = loc_lnSrSearch
732:                         EXIT
733:                     ENDIF
734:                 NEXT
735:             ENDIF
736: 
737:             IF loc_lnSrIdx = 0

*-- Linhas 771 a 1015:
771:     *==========================================================================
772:     * ConfigurarPaginaLista - N/A (form OPERACIONAL de dialogo SiTef, sem PageFrame)
773:     * FormSIGPRTFH eh um dialogo modal 467x350 de consulta de cheque via CliSiTef32I.DLL,
774:     * sem Page1/Grid/Botoes CRUD. Todo o layout eh construido em InicializarForm() por
775:     * ConfigurarPageFrame (cabecalho), ConfigurarBotaoCancela, ConfigurarCorpoForm,
776:     * ConfigurarCamposForm e ConfigurarContainerStatus. Nao existe lista de registros.
777:     * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
778:     *==========================================================================
779:     PROTECTED PROCEDURE ConfigurarPaginaLista()
780:         *-- Sem-operacao: form nao possui PageFrame nem grid de lista.
781:         *-- Ver InicializarForm() e ConfigurarCamposForm() para o layout real.
782:         RETURN
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * AlternarPagina - N/A (form OPERACIONAL de dialogo SiTef, sem PageFrame)
787:     * FormSIGPRTFH nao alterna entre paginas; sempre exibe o mesmo layout durante
788:     * a consulta SiTef (cabecalho + campos do cheque + container de status).
789:     * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
790:     *==========================================================================
791:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
792:         *-- Sem-operacao: dialogo nao possui paginas para alternar.
793:         RETURN
794:     ENDPROC
795: 
796:     *==========================================================================
797:     * ConfigurarPaginaDados - N/A (form OPERACIONAL de dialogo SiTef, sem Page2)
798:     * FormSIGPRTFH e um dialogo modal 467x350 de consulta de cheque via
799:     * CliSiTef32I.DLL, sem PageFrame nem separacao Lista/Dados. Todos os campos
800:     * de exibicao (Praca, Banco, Agencia, Conta, Cheque, CPF + respectivos DVs)
801:     * sao construidos como controles diretos no form em ConfigurarCamposForm().
802:     * Metodo mantido para conformidade com o contrato da pipeline (Fase 5).
803:     *==========================================================================
804:     PROTECTED PROCEDURE ConfigurarPaginaDados()
805:         *-- Sem-operacao: form nao possui Page2/Dados.
806:         *-- Ver ConfigurarCamposForm() para os campos de exibicao do cheque.
807:         RETURN
808:     ENDPROC
809: 
810:     *==========================================================================
811:     * BtnIncluirClick - N/A (form de dialogo SiTef, sem operacao CRUD)
812:     * FormSIGPRTFH e um dialogo modal de consulta de cheque via CliSiTef32I.DLL.
813:     * Nao ha Incluir/Alterar/Visualizar/Excluir: a unica operacao e a consulta SiTef
814:     * disparada automaticamente pelo GotFocus do botao CANCELA ao abrir o form.
815:     * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
816:     *==========================================================================
817:     PROCEDURE BtnIncluirClick()
818:         *-- Sem-operacao: dialogo SiTef nao suporta inclusao de registros.
819:         *-- Ver CmdCancelaGotFocus() para o fluxo real de consulta.
820:         RETURN
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * BtnAlterarClick - N/A (form de dialogo SiTef, sem operacao CRUD)
825:     * Ver BtnIncluirClick acima para explicacao completa.
826:     * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
827:     *==========================================================================
828:     PROCEDURE BtnAlterarClick()
829:         *-- Sem-operacao: dialogo SiTef nao suporta alteracao de registros.
830:         RETURN
831:     ENDPROC
832: 
833:     *==========================================================================
834:     * BtnVisualizarClick - N/A (form de dialogo SiTef, sem operacao CRUD)
835:     * Ver BtnIncluirClick acima para explicacao completa.
836:     * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
837:     *==========================================================================
838:     PROCEDURE BtnVisualizarClick()
839:         *-- Sem-operacao: dialogo SiTef nao suporta visualizacao de registros CRUD.
840:         *-- O resultado da consulta e exibido automaticamente em ExibirResultadoConsulta().
841:         RETURN
842:     ENDPROC
843: 
844:     *==========================================================================
845:     * BtnExcluirClick - N/A (form de dialogo SiTef, sem operacao CRUD)
846:     * Ver BtnIncluirClick acima para explicacao completa.
847:     * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
848:     *==========================================================================
849:     PROCEDURE BtnExcluirClick()
850:         *-- Sem-operacao: dialogo SiTef nao suporta exclusao de registros.
851:         RETURN
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * BtnEncerrarClick - Fecha o dialogo SiTef (equivale ao SAIDA.Click do legado)
856:     * Apenas LASTKEY()=13 (Enter) eh bloqueado para evitar fechamento inadvertido
857:     *==========================================================================
858:     PROCEDURE BtnEncerrarClick()
859:         IF LASTKEY() = 13
860:             RETURN
861:         ENDIF
862:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
863:             THIS.this_oBusinessObject.this_lAbandona = .T.
864:         ENDIF
865:         THIS.Release()
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * BtnBuscarClick - N/A (dialogo SiTef sem busca de registros)
870:     * A unica acao do dialogo e a consulta SiTef executada automaticamente
871:     * pelo GotFocus do cmd_4c_Cancela ao abrir o form.
872:     *==========================================================================
873:     PROCEDURE BtnBuscarClick()
874:         RETURN
875:     ENDPROC
876: 
877:     *==========================================================================
878:     * BtnSalvarClick - N/A (dialogo SiTef sem persistencia em banco de dados)
879:     * O "salvar" equivalente e a gravacao dos arquivos IntPos.001/IntPos.STS
880:     * realizada internamente por SIGPRTFHBO.MontaRetorno / RetornoFalha.
881:     *==========================================================================
882:     PROCEDURE BtnSalvarClick()
883:         RETURN
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * BtnCancelarClick - Abandona a transacao SiTef e fecha o dialogo
888:     * Mesmo comportamento do cmd_4c_Cancela: sinaliza abandono ao BO e fecha.
889:     *==========================================================================
890:     PROCEDURE BtnCancelarClick()
891:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
892:             THIS.this_oBusinessObject.this_lAbandona = .T.
893:         ENDIF
894:         THIS.Release()
895:     ENDPROC
896: 
897:     *==========================================================================
898:     * CarregarLista - N/A (dialogo SiTef sem lista de registros)
899:     * Nao ha grid ou lista neste form. Os dados do cheque sao exibidos via
900:     * PopularCamposDoBO() apos a consulta SiTef.
901:     *==========================================================================
902:     PROCEDURE CarregarLista()
903:         RETURN .T.
904:     ENDPROC
905: 
906:     *==========================================================================
907:     * FormParaBO - N/A (dialogo SiTef sem campos editaveis pelo usuario)
908:     * Os parametros da transacao sao passados diretamente via Init (lparameters)
909:     * e repassados ao BO via CarregarParametros() no prorio Init do form.
910:     * Nao ha campos de entrada que precisem ser sincronizados com o BO.
911:     *==========================================================================
912:     PROCEDURE FormParaBO()
913:         RETURN .T.
914:     ENDPROC
915: 
916:     *==========================================================================
917:     * BOParaForm - Popula campos de exibicao com dados do BO
918:     * Delega a PopularCamposDoBO() que atualiza todos os TextBox de exibicao.
919:     *==========================================================================
920:     PROCEDURE BOParaForm()
921:         THIS.PopularCamposDoBO()
922:         RETURN .T.
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * HabilitarCampos - N/A (todos os campos sao Enabled=.F. - somente leitura)
927:     * FormSIGPRTFH exibe dados do cheque sem permitir edicao pelo usuario.
928:     * Os campos sao preenchidos via parametros ao abrir o form.
929:     *==========================================================================
930:     PROCEDURE HabilitarCampos(par_lHabilitar)
931:         RETURN
932:     ENDPROC
933: 
934:     *==========================================================================
935:     * LimparCampos - Limpa os campos de exibicao (reseta para estado inicial)
936:     * Usado internamente se for necessario reinicializar o dialogo.
937:     *==========================================================================
938:     PROCEDURE LimparCampos()
939:         IF VARTYPE(THIS.txt_4c_Praca) = "O"
940:             THIS.txt_4c_Praca.Value = ""
941:         ENDIF
942:         IF VARTYPE(THIS.txt_4c_Banco) = "O"
943:             THIS.txt_4c_Banco.Value = ""
944:         ENDIF
945:         IF VARTYPE(THIS.txt_4c_Agencia) = "O"
946:             THIS.txt_4c_Agencia.Value = ""
947:         ENDIF
948:         IF VARTYPE(THIS.txt_4c_DvAgencia) = "O"
949:             THIS.txt_4c_DvAgencia.Value = ""
950:         ENDIF
951:         IF VARTYPE(THIS.txt_4c_Conta) = "O"
952:             THIS.txt_4c_Conta.Value = ""
953:         ENDIF
954:         IF VARTYPE(THIS.txt_4c_DvConta) = "O"
955:             THIS.txt_4c_DvConta.Value = ""
956:         ENDIF
957:         IF VARTYPE(THIS.txt_4c_Cheque) = "O"
958:             THIS.txt_4c_Cheque.Value = ""
959:         ENDIF
960:         IF VARTYPE(THIS.txt_4c_DvCheque) = "O"
961:             THIS.txt_4c_DvCheque.Value = ""
962:         ENDIF
963:         IF VARTYPE(THIS.txt_4c_Cpf) = "O"
964:             THIS.txt_4c_Cpf.Value = ""
965:         ENDIF
966:         IF VARTYPE(THIS.cnt_4c_Status) = "O"
967:             WITH THIS.cnt_4c_Status
968:                 .lbl_4c_Status1.Caption = "Aguarde Consulta de Cheque"
969:                 .lbl_4c_Status2.Caption = ""
970:                 .lbl_4c_Status3.Caption = ""
971:                 .lbl_4c_Status4.Caption = ""
972:                 .Visible     = .T.
973:             ENDWITH
974:         ENDIF
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * AjustarBotoesPorModo - N/A (dialogo SiTef sem modos CRUD)
979:     * FormSIGPRTFH tem apenas um modo operacional: consulta de cheque.
980:     * O unico botao focalizavel (cmd_4c_Cancela) permanece habilitado o tempo todo.
981:     *==========================================================================
982:     PROCEDURE AjustarBotoesPorModo()
983:         RETURN
984:     ENDPROC
985: 
986:     *==========================================================================
987:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
988:     *==========================================================================
989:         LOCAL loc_i, loc_oControl
990: 
991:         FOR loc_i = 1 TO par_oContainer.ControlCount
992:             loc_oControl = par_oContainer.Controls(loc_i)
993:             IF VARTYPE(loc_oControl) = "O"
994:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
995:                    loc_oControl.ControlCount > 0
996:                     THIS.TornarControlesVisiveis(loc_oControl)
997:                 ENDIF
998:                 IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
999:                     LOOP
1000:                 ENDIF
1001:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1002:                     loc_oControl.Visible = .T.
1003:                 ENDIF
1004:             ENDIF
1005:         NEXT
1006:     ENDPROC
1007: 
1008:     *==========================================================================
1009:     PROCEDURE Destroy
1010:     *==========================================================================
1011:         THIS.this_oBusinessObject = .NULL.
1012:         DODEFAULT()
1013:     ENDPROC
1014: 
1015: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRTFHBO.prg):
*==============================================================================
* SIGPRTFHBO.prg - Business Object para Consulta de Cheque SiTef
* Legado: SIGPRTFH.SCX (SIGPRIFF)
* Tipo: OPERACIONAL - Integracao SiTef via CliSiTef32I.DLL
*==============================================================================

DEFINE CLASS SIGPRTFHBO AS BusinessBase

    *-- Parametros de configuracao SiTef
    this_cIP              = ""   && IP do servidor SiTef
    this_nInicio          = 0    && Modalidade SiTef (IniciaFuncaoSiTefInterativo)
    this_nIdent           = 0    && Identificador da transacao
    this_cPos             = ""   && Terminal POS
    this_cCaixa           = ""   && Operador/caixa

    *-- Dados do cheque
    this_cPraca           = ""   && Praca de compensacao
    this_cBanco           = ""   && Codigo do banco
    this_cAgencia         = ""   && Agencia
    this_cAgenciaDV       = ""   && Digito verificador da agencia
    this_cConta           = ""   && Conta corrente
    this_cContaDV         = ""   && Digito verificador da conta
    this_cNumeroCheque    = ""   && Numero do cheque
    this_cChequeDV        = ""   && Digito verificador do cheque
    this_cCMC7            = ""   && Codigo CMC7 do cheque

    *-- Dados do portador
    this_cCPF             = ""   && CPF ou CGC do portador
    this_cTipoPessoa      = ""   && Tipo de pessoa: 'F'=Fisica / 'J'=Juridica
    this_cDtCheque        = ""   && Data do cheque (string DDMMAAAA)

    *-- Dados da transacao
    this_nValor           = 0    && Valor do pagamento
    this_nParcelas        = 0    && Numero de parcelas
    this_cCupom           = ""   && Numero do cupom fiscal
    this_cCupomNV         = ""   && Cupom nao-eletronico
    this_cFuncoes         = ""   && Funcoes adicionais (lista separada por virgula)
    this_cPesquisa        = ""   && Tipo de pesquisa pre-definida

    *-- Retorno e controle
    this_cRetornoCheque   = ""   && Codigo/mensagem de retorno da consulta
    this_lAbandona        = .F.  && Indica se usuario cancelou a operacao

    *-- Dados internos da transacao SiTef (preenchidos durante ExecutarConsulta)
    this_cTipTransacao    = ""   && Tipo de transacao (TipoCampo 100)
    this_cDataHoraTEF     = ""   && Data/hora TEF (TipoCampo 105)
    this_cCupomTEF        = ""   && Cupom TEF (TipoCampo 121)
    this_cCartao          = ""   && Tipo de cartao (TipoCampo 132)
    this_cNSU             = ""   && NSU (TipoCampo 134)
    this_cAutorizacao     = ""   && Autorizacao (TipoCampo 135)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        this_cTabela      = ""
        this_cCampoChave  = ""
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        *-- Chave sintetica: identificador da transacao SiTef (nao ha tabela)
        IF THIS.this_nIdent > 0
            RETURN ALLTRIM(STR(THIS.this_nIdent, 10))
        ENDIF
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia dados de cursor para propriedades do BO
    * Form OPERACIONAL sem tabela persistente. Se um cursor for fornecido com
    * parametros de transacao, popula as propriedades correspondentes.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        IF VARTYPE(par_cAliasCursor) # "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        *-- Parametros de configuracao SiTef
        IF TYPE(par_cAliasCursor + ".IP") # "U"
            THIS.this_cIP = TratarNulo(EVALUATE(par_cAliasCursor + ".IP"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Inicio") # "U"
            THIS.this_nInicio = TratarNulo(EVALUATE(par_cAliasCursor + ".Inicio"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Ident") # "U"
            THIS.this_nIdent = TratarNulo(EVALUATE(par_cAliasCursor + ".Ident"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Pos") # "U"
            THIS.this_cPos = TratarNulo(EVALUATE(par_cAliasCursor + ".Pos"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Caixa") # "U"
            THIS.this_cCaixa = TratarNulo(EVALUATE(par_cAliasCursor + ".Caixa"), "C")
        ENDIF

        *-- Dados do cheque
        IF TYPE(par_cAliasCursor + ".Praca") # "U"
            THIS.this_cPraca = TratarNulo(EVALUATE(par_cAliasCursor + ".Praca"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Banco") # "U"
            THIS.this_cBanco = TratarNulo(EVALUATE(par_cAliasCursor + ".Banco"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Agencia") # "U"
            THIS.this_cAgencia = TratarNulo(EVALUATE(par_cAliasCursor + ".Agencia"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".AgenciaDV") # "U"
            THIS.this_cAgenciaDV = TratarNulo(EVALUATE(par_cAliasCursor + ".AgenciaDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") # "U"
            THIS.this_cConta = TratarNulo(EVALUATE(par_cAliasCursor + ".Conta"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".ContaDV") # "U"
            THIS.this_cContaDV = TratarNulo(EVALUATE(par_cAliasCursor + ".ContaDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".NumeroCheque") # "U"
            THIS.this_cNumeroCheque = TratarNulo(EVALUATE(par_cAliasCursor + ".NumeroCheque"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".ChequeDV") # "U"
            THIS.this_cChequeDV = TratarNulo(EVALUATE(par_cAliasCursor + ".ChequeDV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".CMC7") # "U"
            THIS.this_cCMC7 = TratarNulo(EVALUATE(par_cAliasCursor + ".CMC7"), "C")
        ENDIF

        *-- Dados do portador
        IF TYPE(par_cAliasCursor + ".CPF") # "U"
            THIS.this_cCPF = TratarNulo(EVALUATE(par_cAliasCursor + ".CPF"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".TipoPessoa") # "U"
            THIS.this_cTipoPessoa = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoPessoa"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DtCheque") # "U"
            THIS.this_cDtCheque = TratarNulo(EVALUATE(par_cAliasCursor + ".DtCheque"), "C")
        ENDIF

        *-- Dados da transacao
        IF TYPE(par_cAliasCursor + ".Valor") # "U"
            THIS.this_nValor = TratarNulo(EVALUATE(par_cAliasCursor + ".Valor"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Parcelas") # "U"
            THIS.this_nParcelas = TratarNulo(EVALUATE(par_cAliasCursor + ".Parcelas"), "N")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Cupom") # "U"
            THIS.this_cCupom = TratarNulo(EVALUATE(par_cAliasCursor + ".Cupom"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".CupomNV") # "U"
            THIS.this_cCupomNV = TratarNulo(EVALUATE(par_cAliasCursor + ".CupomNV"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Funcoes") # "U"
            THIS.this_cFuncoes = TratarNulo(EVALUATE(par_cAliasCursor + ".Funcoes"), "C")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Pesquisa") # "U"
            THIS.this_cPesquisa = TratarNulo(EVALUATE(par_cAliasCursor + ".Pesquisa"), "C")
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Executa consulta de cheque via SiTef (equivale a "gravar" no
    * fluxo do form OPERACIONAL). Sem tabela persistente: o "insert" e a
    * emissao dos arquivos de retorno IntPos.001 / IntPos.STS para o PDV.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Valida parametros minimos antes de disparar a transacao SiTef
            IF EMPTY(THIS.this_cIP)
                THIS.this_cMensagemErro = "IP do servidor SiTef nao informado."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND EMPTY(THIS.this_cPos)
                THIS.this_cMensagemErro = "Terminal POS nao informado."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND THIS.this_nIdent <= 0
                THIS.this_cMensagemErro = "Identificador de transa" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido."
                loc_lSucesso = .F.
            ENDIF
            IF loc_lSucesso AND THIS.this_nValor <= 0
                THIS.this_cMensagemErro = "Valor da transa" + CHR(231) + CHR(227) + "o deve ser maior que zero."
                loc_lSucesso = .F.
            ENDIF

            *-- Executa o loop SiTef
            IF loc_lSucesso
                loc_lSucesso = THIS.ExecutarConsulta()
                IF !loc_lSucesso
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Falha na consulta SiTef: " + ALLTRIM(THIS.this_cRetornoCheque)
                    ENDIF
                    *-- Emite arquivo de falha para o PDV
                    THIS.RetornoFalha(THIS.this_cMensagemErro, THIS.this_nValor)
                ELSE
                    *-- Emite arquivo de sucesso com dados retornados pelo SiTef
                    THIS.MontaRetorno(THIS.this_cTipTransacao, THIS.this_cDataHoraTEF, ;
                        THIS.this_cCupomTEF, THIS.this_cCartao, THIS.this_cNSU, ;
                        THIS.this_cAutorizacao, "0", THIS.this_nValor, ;
                        THIS.this_cRetornoCheque)
                    *-- Registra auditoria da consulta (ObterChavePrimaria usa this_nIdent)
                    THIS.RegistrarAuditoria("CONSULTA_CHEQUE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir SiTef: " + loc_oErro.Message + ;
                " LN=" + TRANSFORM(loc_oErro.LineNo)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Reexecuta a consulta SiTef mantendo o mesmo Ident
    * (permite ao PDV reprocessar uma transacao com dados atualizados).
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF THIS.this_nIdent <= 0
                THIS.this_cMensagemErro = "Identificador de transa" + CHR(231) + CHR(227) + ;
                    "o inv" + CHR(225) + "lido para reprocessamento."
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                loc_lSucesso = THIS.ExecutarConsulta()
                IF !loc_lSucesso
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Falha ao reprocessar consulta SiTef: " + ;
                            ALLTRIM(THIS.this_cRetornoCheque)
                    ENDIF
                    THIS.RetornoFalha(THIS.this_cMensagemErro, THIS.this_nValor)
                ELSE
                    THIS.MontaRetorno(THIS.this_cTipTransacao, THIS.this_cDataHoraTEF, ;
                        THIS.this_cCupomTEF, THIS.this_cCartao, THIS.this_cNSU, ;
                        THIS.this_cAutorizacao, "0", THIS.this_nValor, ;
                        THIS.this_cRetornoCheque)
                    THIS.RegistrarAuditoria("REPROCESSA_CHEQUE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar SiTef: " + loc_oErro.Message + ;
                " LN=" + TRANSFORM(loc_oErro.LineNo)
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo SiTef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetornos)
        DO CASE
        CASE par_nRetornos = -1
            THIS.this_cRetornoCheque = "Modulo Nao Iniciado"
        CASE par_nRetornos = -2
            THIS.this_cRetornoCheque = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario"
        CASE par_nRetornos = -3
            THIS.this_cRetornoCheque = "Fornecida uma Modalidade Invalida"
        CASE par_nRetornos = -4
            THIS.this_cRetornoCheque = "Falta Memoria para Rodar a Fun" + CHR(231) + CHR(227) + "o"
        CASE par_nRetornos = -5
            THIS.this_cRetornoCheque = "Sem Comunica" + CHR(231) + CHR(227) + "o com o SiTef"
        ENDCASE
    ENDPROC

    *==========================================================================
    * RetornoFalha - Gera arquivo de retorno de falha para o PDV integrador
    * par_lcMensagem - Mensagem de erro
    * par_lnValPago  - Valor pago (0 em caso de falha)
    *==========================================================================
    PROCEDURE RetornoFalha(par_lcMensagem, par_lnValPago)
        LOCAL loc_lcMensagem, loc_lsValPago, loc_lSucesso

        loc_lSucesso = .T.
        TRY
            loc_lcMensagem = IIF(EMPTY(par_lcMensagem), ;
                "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
                par_lcMensagem)

            loc_lsValPago = STRTRAN(ALLTRIM(TRANSFORM(par_lnValPago, "99999999999.99")), ".", ",")

            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_lsValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + loc_lcMensagem)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            IF FILE("C:\client\Resp\IntPos.001")
                COPY TO "C:\client\Resp\IntPos.001" SDF
            ENDIF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            IF FILE("C:\client\Resp\IntPos.STS")
                COPY TO "C:\client\Resp\IntPos.STS" SDF
            ENDIF

            USE IN crSiTef

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro SiTef RetornoFalha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontaRetorno - Gera arquivos de retorno para o PDV integrador
    * par_lsTipTran  - Tipo de transacao
    * par_lsDataHora - Data/hora da transacao
    * par_lsCupom    - Cupom TEF
    * par_lsCartao   - Tipo de cartao
    * par_lsNsu      - NSU
    * par_lsAutoriza - Autorizacao
    * par_lsFinaliza - Finalizacao
    * par_lnValPago  - Valor pago
    * par_lsMenRet   - Mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_lsTipTran, par_lsDataHora, par_lsCupom, par_lsCartao, ;
                           par_lsNsu, par_lsAutoriza, par_lsFinaliza, par_lnValPago, par_lsMenRet)
        LOCAL loc_lsValPago, loc_laCartao, loc_lsCupomTemp, loc_lsPos, loc_lnLinha
        LOCAL loc_lSucesso

        loc_lSucesso = .T.
        TRY
            loc_lsValPago = STRTRAN(ALLTRIM(TRANSFORM(par_lnValPago, "99999999999.99")), ".", ",")

            DIMENSION loc_laCartao[11]
            loc_laCartao[1]  = "Outro, nao definido"
            loc_laCartao[2]  = "Visa"
            loc_laCartao[3]  = "Mastercard"
            loc_laCartao[4]  = "Diners"
            loc_laCartao[5]  = "American Express"
            loc_laCartao[6]  = "Sollo"
            loc_laCartao[7]  = "Sidecard (Redecard)"
            loc_laCartao[8]  = "Private Label (Redecard)"
            loc_laCartao[9]  = "Redeshop"
            loc_laCartao[10] = ""
            loc_laCartao[11] = "Fininvest"

            IF VAL(par_lsCartao) > 10 OR VAL(par_lsCartao) < 0
                par_lsCartao = "0"
            ENDIF

            CREATE CURSOR crSiTef (tef c(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_lsValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(par_lsCartao) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_lsTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_lsNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_lsAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
                SUBSTR(par_lsDataHora, 7, 2) + SUBSTR(par_lsDataHora, 5, 2) + SUBSTR(par_lsDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
                SUBSTR(par_lsDataHora, 7, 2) + SUBSTR(par_lsDataHora, 5, 2) + SUBSTR(par_lsDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_lsDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_lsFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_lsDataHora, 9, 6))

            loc_lsCupomTemp = par_lsCupom
            loc_lsPos       = 1
            loc_lnLinha     = 1
            DO WHILE loc_lsPos <> 0
                loc_lsPos = AT(CHR(10), loc_lsCupomTemp)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_lnLinha, "@L 999") + " = " + ;
                    IIF(loc_lsPos <> 0, SUBSTR(loc_lsCupomTemp, 1, loc_lsPos - 1), loc_lsCupomTemp))
                loc_lsCupomTemp = SUBSTR(loc_lsCupomTemp, loc_lsPos + 1)
                loc_lnLinha     = loc_lnLinha + 1
            ENDDO

            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_lnLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_lsMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            IF FILE("C:\client\Resp\IntPos.001")
                COPY TO "C:\client\Resp\IntPos.001" SDF
            ENDIF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + ALLTRIM(STR(THIS.this_nIdent, 10)))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            IF FILE("C:\client\Resp\IntPos.STS")
                COPY TO "C:\client\Resp\IntPos.STS" SDF
            ENDIF

            USE IN crSiTef

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro SiTef MontaRetorno")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Popula propriedades do BO com os parametros recebidos
    * Chamado pelo Form antes de exibir (substitui init parametrizado do legado)
    *==========================================================================
    PROCEDURE CarregarParametros(par_cIP, par_nInicio, par_nValor, par_cCupom, ;
                                  par_cCaixa, par_nIdent, par_cPos, par_nParcelas, ;
                                  par_cFuncoes, par_cBanco, par_cAgencia, par_cConta, ;
                                  par_cNumeroCheque, par_cDtCheque, par_cCPF, ;
                                  par_cTipoPessoa, par_cCupomNV, par_cAgenciaDV, ;
                                  par_cContaDV, par_cChequeDV, par_cPraca, ;
                                  par_cPesquisa, par_cCMC7)
        THIS.this_cIP             = IIF(VARTYPE(par_cIP)          = "C", par_cIP,          "")
        THIS.this_nInicio         = IIF(VARTYPE(par_nInicio)       = "N", par_nInicio,       0)
        THIS.this_nValor          = IIF(VARTYPE(par_nValor)        = "N", par_nValor,        0)
        THIS.this_cCupom          = IIF(VARTYPE(par_cCupom)        = "C", par_cCupom,        "")
        THIS.this_cCaixa          = IIF(VARTYPE(par_cCaixa)        = "C", par_cCaixa,        "")
        THIS.this_nIdent          = IIF(VARTYPE(par_nIdent)        = "N", par_nIdent,        0)
        THIS.this_cPos            = IIF(VARTYPE(par_cPos)          = "C", par_cPos,          "")
        THIS.this_nParcelas       = IIF(VARTYPE(par_nParcelas)     = "N", par_nParcelas,     0)
        THIS.this_cFuncoes        = IIF(VARTYPE(par_cFuncoes)      = "C", par_cFuncoes,      "")
        THIS.this_cBanco          = IIF(VARTYPE(par_cBanco)        = "C", par_cBanco,        "")
        THIS.this_cAgencia        = IIF(VARTYPE(par_cAgencia)      = "C", par_cAgencia,      "")
        THIS.this_cConta          = IIF(VARTYPE(par_cConta)        = "C", par_cConta,        "")
        THIS.this_cNumeroCheque   = IIF(VARTYPE(par_cNumeroCheque) = "C", par_cNumeroCheque, "")
        THIS.this_cDtCheque       = IIF(VARTYPE(par_cDtCheque)     = "C", par_cDtCheque,     "")
        THIS.this_cCPF            = IIF(VARTYPE(par_cCPF)          = "C", par_cCPF,          "")
        THIS.this_cTipoPessoa     = IIF(VARTYPE(par_cTipoPessoa)   = "C", par_cTipoPessoa,   "F")
        THIS.this_cCupomNV        = IIF(VARTYPE(par_cCupomNV)      = "C", par_cCupomNV,      "")
        THIS.this_cAgenciaDV      = IIF(VARTYPE(par_cAgenciaDV)    = "C", par_cAgenciaDV,    "")
        THIS.this_cContaDV        = IIF(VARTYPE(par_cContaDV)      = "C", par_cContaDV,      "")
        THIS.this_cChequeDV       = IIF(VARTYPE(par_cChequeDV)     = "C", par_cChequeDV,     "")
        THIS.this_cPraca          = IIF(VARTYPE(par_cPraca)        = "C", par_cPraca,        "")
        THIS.this_cPesquisa       = IIF(VARTYPE(par_cPesquisa)     = "C", par_cPesquisa,     "")
        THIS.this_cCMC7           = IIF(VARTYPE(par_cCMC7)         = "C", par_cCMC7,         "")

        THIS.this_cRetornoCheque  = ""
        THIS.this_lAbandona       = .F.
        THIS.this_cTipTransacao   = ""
        THIS.this_cDataHoraTEF    = ""
        THIS.this_cCupomTEF       = ""
        THIS.this_cCartao         = ""
        THIS.this_cNSU            = ""
        THIS.this_cAutorizacao    = ""
    ENDPROC

    *==========================================================================
    * ObterRetornoSerasa - Retorna texto descritivo para codigo Serasa
    * par_nIndice - Indice (1..8) do array RetSerasa
    * par_nLinha  - Linha (1..3) da descricao
    *==========================================================================
    FUNCTION ObterRetornoSerasa(par_nIndice, par_nLinha)
        LOCAL loc_laRetSerasa

        DIMENSION loc_laRetSerasa[8, 3]
        loc_laRetSerasa[1, 1] = ""
        loc_laRetSerasa[1, 2] = "Aprovado"
        loc_laRetSerasa[1, 3] = ""

        loc_laRetSerasa[2, 1] = "Banco Nao Existe ou"
        loc_laRetSerasa[2, 2] = "Nao Trabalha com Conta Corrente ou"
        loc_laRetSerasa[2, 3] = "Esta em Processo de Liquidacao"

        loc_laRetSerasa[3, 1] = "Pagamento de Compra com Cheque Pre"
        loc_laRetSerasa[3, 2] = "por Cliente Nao Cadastrado no "
        loc_laRetSerasa[3, 3] = "Estabelecimento"

        loc_laRetSerasa[4, 1] = ""
        loc_laRetSerasa[4, 2] = "Realizar Consulta Analitica"
        loc_laRetSerasa[4, 3] = ""

        loc_laRetSerasa[5, 1] = ""
        loc_laRetSerasa[5, 2] = "Falha no Processo de Consulta"
        loc_laRetSerasa[5, 3] = ""

        loc_laRetSerasa[6, 1] = "Excedido Limite para Pagamento"
        loc_laRetSerasa[6, 2] = "de Compras com Cheque Pre-Datados"
        loc_laRetSerasa[6, 3] = "Determinado pelo Estabelecimento"

        loc_laRetSerasa[7, 1] = ""
        loc_laRetSerasa[7, 2] = "Cheque Maior que o Limite de Compra"
        loc_laRetSerasa[7, 3] = ""

        loc_laRetSerasa[8, 1] = "Cliente Cadastrado Alem do Prazo"
        loc_laRetSerasa[8, 2] = "Definido pelo Estabelecimento para"
        loc_laRetSerasa[8, 3] = "Validade do Cartao provisorio"

        IF par_nIndice >= 1 AND par_nIndice <= 8 AND par_nLinha >= 1 AND par_nLinha <= 3
            RETURN loc_laRetSerasa[par_nIndice, par_nLinha]
        ENDIF

        RETURN ""
    ENDFUNC

    *==========================================================================
    * ObterCodigoSerasa - Retorna o codigo Serasa por indice (1..8)
    *==========================================================================
    FUNCTION ObterCodigoSerasa(par_nIndice)
        LOCAL loc_laCodSerasa

        DIMENSION loc_laCodSerasa[8]
        loc_laCodSerasa[1] = "00"
        loc_laCodSerasa[2] = "19"
        loc_laCodSerasa[3] = "56"
        loc_laCodSerasa[4] = "57"
        loc_laCodSerasa[5] = "60"
        loc_laCodSerasa[6] = "61"
        loc_laCodSerasa[7] = "65"
        loc_laCodSerasa[8] = "76"

        IF par_nIndice >= 1 AND par_nIndice <= 8
            RETURN loc_laCodSerasa[par_nIndice]
        ENDIF

        RETURN ""
    ENDFUNC

    *==========================================================================
    * CarregarDLL - Declara as funcoes da DLL CliSiTef32I para uso em runtime
    * Deve ser chamado pelo Form antes de ExecutarConsulta (equivale ao Load original)
    *==========================================================================
    PROCEDURE CarregarDLL()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, ;
                Integer @lnMaximo, String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            IF !("already" $ LOWER(loc_oErro.Message))
                MsgErro(loc_oErro.Message, "Erro ao carregar DLL SiTef")
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Loop interativo de consulta de cheque via SiTef DLL
    * Equivale ao CANCELA.GotFocus do legado (logica principal da integracao)
    * Popula this_cRetornoCheque e campos de retorno da transacao
    * Retorna .T. se consulta completou; .F. se abortou por erro/cancelamento
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_lAbortou
        LOCAL loc_lsIdTerminal, loc_lnValPago
        LOCAL loc_lsMensagem, loc_lMRet
        LOCAL loc_lnNumParcs, loc_lsValores, loc_lsDatas, loc_lcTitulo
        LOCAL loc_lnPos, loc_lnCarSen, loc_lnTipo, loc_lnCard, loc_lsOpcaoC
        LOCAL loc_lsMensagem1
        LOCAL loc_lnStts, loc_lnProximoComando, loc_lnTipoCampo, loc_lnTamanhoMin
        LOCAL loc_lnTamanhoMax, loc_lcBuffer, loc_lnResultado
        LOCAL loc_lcData, loc_lcHora
        LOCAL loc_lnFuncoesDim, loc_lnCommaCount, loc_lnFPOS, loc_lnSrSearch, loc_lnSrIdx
        LOCAL loc_lLpTipo, loc_lTipoDados, loc_lEscolhas, loc_lValores, loc_lcDDCHQ
        LOCAL loc_oErro

        loc_lSucesso = .T.
        loc_lAbortou = .F.

        TRY
            *-- Parse das funcoes adicionais (separa string "1,2,3" em array)
            IF !EMPTY(THIS.this_cFuncoes)
                loc_lnCommaCount = OCCURS(",", THIS.this_cFuncoes)
                loc_lnFuncoesDim = loc_lnCommaCount + 1
                DIMENSION loc_laFuncoes[loc_lnFuncoesDim]
                FOR loc_lnFPOS = 1 TO loc_lnCommaCount
                    loc_laFuncoes[loc_lnFPOS] = SUBSTR(THIS.this_cFuncoes, ;
                        IIF(loc_lnFPOS = 1, 1, AT(",", THIS.this_cFuncoes, loc_lnFPOS) + 1), 1)
                NEXT
                loc_laFuncoes[loc_lnFuncoesDim] = SUBSTR(THIS.this_cFuncoes, LEN(THIS.this_cFuncoes), 1)
            ELSE
                loc_lnFuncoesDim = 1
                DIMENSION loc_laFuncoes[1]
                loc_laFuncoes[1] = ""
                THIS.this_cFuncoes = ""
            ENDIF

            loc_lsIdTerminal = "00000" + go_4c_Sistema.cCodEmpresa
            loc_lnValPago    = ALLTRIM(STRTRAN(TRANSFORM(THIS.this_nValor, "999999999.99"), ".", ","))

            *-- Configurar terminal SiTef
            IF ConfiguraIntSiTefInterativo(THIS.this_cIP, loc_lsIdTerminal, THIS.this_cPos, 0) <> 0
                DO SigTfSup WITH "P", "Sem comunicacao com SiTef", "", "", "", "", ;
                    "", "", "", loc_lnValPago, "", THIS.this_nIdent
                loc_lAbortou = .T.
            ENDIF

            *-- Iniciar funcao SiTef
            IF !loc_lAbortou
                loc_lcData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
                loc_lcHora = STRTRAN(TIME(), ":", "")
                IF IniciaFuncaoSiTefInterativo(THIS.this_nInicio, loc_lnValPago, ;
                        THIS.this_cCupom, loc_lcData, loc_lcHora, THIS.this_cCaixa, "") <> 10000
                    DO SigTfSup WITH "P", "Sem comunicacao com SiTef", "", "", "", "", ;
                        "", "", "", loc_lnValPago, "", THIS.this_nIdent
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *-- Loop principal de interacao com a DLL SiTef
            IF !loc_lAbortou
                loc_lnStts           = 10000
                loc_lnProximoComando = 0
                loc_lnTipoCampo      = 0
                loc_lnTamanhoMin     = 0
                loc_lnTamanhoMax     = 0
                loc_lcBuffer         = SPACE(2000)
                loc_lnResultado      = 0
                loc_lsMensagem       = ""
                loc_lnNumParcs       = ALLTRIM(STR(THIS.this_nParcelas))
                loc_lsValores        = "0,00"
                loc_lsDatas          = ""
                loc_lcTitulo         = ""
                loc_lnPos            = 1
                loc_lnCarSen         = 1
                loc_lnTipo           = 1
                loc_lnCard           = 1
                loc_lsOpcaoC         = "0"
                loc_lsMensagem1      = ""

                DO WHILE loc_lnStts = 10000
                    loc_lnStts = ContinuaFuncaoSiTefInterativo( ;
                        @loc_lnProximoComando, @loc_lnTipoCampo, ;
                        @loc_lnTamanhoMin, @loc_lnTamanhoMax, ;
                        @loc_lcBuffer, LEN(ALLTRIM(loc_lcBuffer)), loc_lnResultado)
                    loc_lnResultado = 0

                    IF loc_lnStts = -2
                        loc_lsMensagem = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario"
                        EXIT
                    ENDIF
                    IF loc_lnStts <> 10000
                        loc_lsMensagem = ALLTRIM(loc_lcBuffer)
                        EXIT
                    ENDIF

                    IF loc_lnStts = 10000
                        IF !EMPTY(loc_lsMensagem)
                            THIS.this_cRetornoCheque = loc_lsMensagem
                            IF !EMPTY(THIS.this_cBanco)
                                THIS.this_cRetornoCheque = "00" + ALLTRIM(loc_lsMensagem)
                            ENDIF
                            loc_lsMensagem = ""
                        ENDIF

                        *-- Comando 21: pesquisa pre-definida (funcao "1")
                        IF loc_lnProximoComando = 21 AND THIS.this_cFuncoes = "1"
                            IF loc_lnTipo = 1
                                loc_lcBuffer    = "1" + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnTipo      = 2
                                LOOP
                            ENDIF
                            IF loc_lnTipo = 2
                                IF EMPTY(THIS.this_cPesquisa)
                                    DO FORM SigCqTef TO loc_lsOpcaoC
                                ELSE
                                    loc_lsOpcaoC = THIS.this_cPesquisa
                                ENDIF
                                IF loc_lsOpcaoC = "0"
                                    DO FORM SigTfDss WITH ;
                                        "Erro na Transa" + CHR(231) + CHR(227) + "o", ;
                                        "", "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                        "", "", "VM", 0, 0
                                    loc_lAbortou = .T.
                                    EXIT
                                ENDIF
                                loc_lcBuffer    = loc_lsOpcaoC + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnTipo      = 3
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 30: dados do portador (funcao "1")
                        IF loc_lnProximoComando = 30 AND THIS.this_cFuncoes = "1"
                            IF loc_lnCard = 1
                                loc_lcBuffer    = IIF(THIS.this_cTipoPessoa = "F", "0", "1") + REPLICATE(CHR(0), 1999)
                                loc_lnResultado = 1000
                                loc_lnCard      = 2
                                LOOP
                            ENDIF
                            IF loc_lnCard = 2
                                loc_lcBuffer    = THIS.this_cCPF + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cCPF))
                                loc_lnResultado = 1000
                                loc_lnCard      = 3
                                LOOP
                            ENDIF
                            IF loc_lnCard = 3
                                loc_lcBuffer    = THIS.this_cDtCheque + REPLICATE(CHR(0), 1992)
                                loc_lnResultado = 1000
                                loc_lnCard      = 4
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 31: dados do cheque via CMC7 ou campos (funcao "1")
                        IF loc_lnProximoComando = 31 AND THIS.this_cFuncoes = "1"
                            IF EMPTY(THIS.this_cCMC7)
                                loc_lcBuffer = "0:" + THIS.this_cPraca + THIS.this_cBanco + ;
                                    THIS.this_cAgencia + THIS.this_cAgenciaDV + ;
                                    PADR(THIS.this_cConta, 10) + THIS.this_cContaDV + ;
                                    THIS.this_cNumeroCheque + THIS.this_cChequeDV
                            ELSE
                                loc_lcBuffer = "1:" + THIS.this_cCMC7
                            ENDIF
                            loc_lcBuffer = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                            LOOP
                        ENDIF

                        *-- Comando 31 + tipo 517: data do cheque via dialog SIGCHTEF
                        IF loc_lnProximoComando = 31 AND loc_lnTipoCampo = 517
                            loc_lcDDCHQ  = ""
                            DO FORM SIGCHTEF TO loc_lcDDCHQ
                            loc_lcBuffer = loc_lcDDCHQ + REPLICATE(CHR(0), 2000 - LEN(loc_lcDDCHQ))
                            LOOP
                        ENDIF

                        *-- Comandos de entrada interativa (30, 21, 34, 20, 31)
                        IF loc_lnProximoComando = 30 OR loc_lnProximoComando = 21 OR ;
                           loc_lnProximoComando = 34 OR loc_lnProximoComando = 20 OR ;
                           loc_lnProximoComando = 31

                            IF loc_lnProximoComando = 21
                                loc_lLpTipo = "M"
                            ELSE
                                loc_lLpTipo = "N"
                            ENDIF
                            IF loc_lnProximoComando = 30 OR loc_lnProximoComando = 34 OR ;
                               loc_lnProximoComando = 20
                                loc_lcTitulo = ALLTRIM(loc_lcBuffer)
                            ENDIF

                            IF !EMPTY(THIS.this_cFuncoes) AND loc_lnPos <= loc_lnFuncoesDim
                                loc_lcBuffer    = loc_laFuncoes[loc_lnPos]
                                loc_lcBuffer    = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                                loc_lnResultado = 1000
                                loc_lnPos       = loc_lnPos + 1
                                LOOP
                            ELSE
                                IF loc_lnProximoComando = 30 AND ;
                                   (loc_lnTipoCampo = 505 OR loc_lnTipoCampo = 511) AND ;
                                   THIS.this_nParcelas <> 0
                                    loc_lcBuffer        = ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")) + ;
                                        REPLICATE(CHR(0), 1998)
                                    THIS.this_nParcelas = 0
                                    loc_lnResultado     = 1000
                                    LOOP
                                ENDIF

                                loc_lTipoDados = ""
                                IF loc_lnTipoCampo = 504 OR loc_lnTipoCampo = 506 OR ;
                                   loc_lnTipoCampo = 515 OR "DDMMAAAA" $ loc_lcBuffer
                                    loc_lTipoDados = "D"
                                ENDIF
                                IF loc_lnTipoCampo = 130
                                    loc_lTipoDados = "V"
                                ENDIF
                                IF loc_lnProximoComando = 20
                                    loc_lEscolhas = "0:Sim;1:N" + CHR(227) + "o;"
                                    loc_lcTitulo  = ALLTRIM(loc_lcBuffer)
                                    loc_lLpTipo   = "M"
                                ELSE
                                    loc_lEscolhas = ALLTRIM(loc_lcBuffer)
                                ENDIF

                                loc_lValores = ""
                                DO FORM FormSIGPRTFH WITH loc_lEscolhas, loc_lLpTipo, loc_lcTitulo, ;
                                    loc_lnTamanhoMin, loc_lnTamanhoMax, loc_lTipoDados TO loc_lValores

                                IF loc_lnProximoComando = 30 AND ;
                                   (loc_lnTipoCampo = 505 OR loc_lnTipoCampo = 511)
                                    loc_lnNumParcs = loc_lValores
                                ENDIF
                                IF EMPTY(loc_lValores) OR ISNULL(loc_lValores)
                                    DO SigTfSup WITH "P", ;
                                        "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
                                        "", "", "", "", "", "", "", loc_lnValPago, "", THIS.this_nIdent
                                    loc_lAbortou = .T.
                                    EXIT
                                ENDIF
                                IF loc_lnTipoCampo = 504 OR loc_lnTipoCampo = 506 OR ;
                                   loc_lnTipoCampo = 515 OR "DDMMAAAA" $ loc_lcBuffer
                                    loc_lValores = DTOC(loc_lValores)
                                    loc_lsDatas  = loc_lValores
                                    loc_lValores = SUBSTR(loc_lValores, 1, 2) + ;
                                        SUBSTR(loc_lValores, 4, 2) + SUBSTR(loc_lValores, 7, 4)
                                ENDIF
                                IF loc_lnTipoCampo = 130
                                    loc_lValores  = STRTRAN(ALLTRIM(TRANSFORM(loc_lValores, "99999999.99")), ".", ",")
                                    loc_lsValores = loc_lValores
                                ENDIF
                                loc_lcBuffer = ALLTRIM(loc_lValores)
                                loc_lcBuffer = loc_lcBuffer + REPLICATE(CHR(0), 2000 - LEN(loc_lcBuffer))
                                loc_lcTitulo = ""
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Comando 23: aguardar passe/insercao de cartao ou senha
                        IF loc_lnProximoComando = 23
                            IF loc_lnCarSen = 1
                                WAIT WINDOW "Passe ou Insira o Cart" + CHR(227) + "o" NOWAIT
                            ELSE
                                WAIT WINDOW "Digite a Senha" NOWAIT
                            ENDIF
                            LOOP
                        ENDIF
                        IF loc_lnProximoComando = 13
                            WAIT CLEAR
                            loc_lnCarSen = 2
                        ENDIF
                        IF loc_lnProximoComando = 4
                            loc_lcTitulo = ALLTRIM(loc_lcBuffer)
                        ENDIF
                        IF loc_lnProximoComando = 3
                            loc_lMRet = ALLTRIM(loc_lcBuffer)
                        ENDIF
                        IF loc_lnProximoComando = 22
                            loc_lsMensagem = ALLTRIM(STRTRAN(loc_lcBuffer, CHR(0), ""))
                            LOOP
                        ENDIF

                        *-- Capturar campos de retorno da transacao SiTef
                        IF loc_lnTipoCampo = 100
                            THIS.this_cTipTransacao = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 105
                            THIS.this_cDataHoraTEF = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 121
                            THIS.this_cCupomTEF = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 132
                            THIS.this_cCartao = loc_lcBuffer
                        ENDIF
                        IF loc_lnTipoCampo = 134
                            THIS.this_cNSU = ALLTRIM(STR(VAL(loc_lcBuffer)))
                        ENDIF
                        IF loc_lnTipoCampo = 135
                            THIS.this_cAutorizacao = loc_lcBuffer
                        ENDIF
                        IF loc_lsOpcaoC = "4" AND loc_lnStts <> 0
                            loc_lsMensagem1 = ALLTRIM(loc_lcBuffer)
                        ENDIF

                        IF loc_lnProximoComando <> 30 AND loc_lnProximoComando <> 21 AND ;
                           loc_lnProximoComando <> 34 AND loc_lnProximoComando <> 20 AND ;
                           loc_lnProximoComando <> 31
                            loc_lcBuffer = SPACE(2000)
                        ENDIF
                    ENDIF
                ENDDO

                *-- Processar resultado final: verificar codigo Serasa
                IF !loc_lAbortou AND loc_lnStts <> 1000 AND loc_lnStts <> 0
                    loc_lnSrIdx = 0
                    FOR loc_lnSrSearch = 1 TO 8
                        IF THIS.ObterCodigoSerasa(loc_lnSrSearch) = SUBSTR(loc_lcBuffer, 1, 2)
                            loc_lnSrIdx = loc_lnSrSearch
                            EXIT
                        ENDIF
                    NEXT
                    IF loc_lnSrIdx = 0
                        THIS.this_cRetornoCheque = ALLTRIM(loc_lcBuffer)
                    ELSE
                        THIS.this_cRetornoCheque = SUBSTR(loc_lcBuffer, 1, 2) + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 1) + " " + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 2) + " " + ;
                            THIS.ObterRetornoSerasa(loc_lnSrIdx, 3)
                    ENDIF
                ENDIF

                IF loc_lAbortou
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExecutarConsulta SiTef")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

