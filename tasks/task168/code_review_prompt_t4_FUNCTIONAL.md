# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1091 linhas total):

*-- Linhas 10 a 245:
10: *   CODE   -> arquitetura em camadas (FormBase / SIGPRCPRBO), sufixo _4c_
11: *
12: * Heranca DataSession:
13: *   DataSession=2 no form; InicializarForm copia DataSessionId do form pai,
14: *   tornando cursor_4c_TmpEnc (criado pelo pai) visivel nesta sessao.
15: *==============================================================================
16: 
17: DEFINE CLASS FormSIGPRCPR AS FormBase
18: 
19:     *-- Dimensoes e propriedades visuais (SCX legado 800x400 escalado para 1000x600)
20:     Width        = 1000
21:     Height       = 600
22:     AutoCenter   = .T.
23:     TitleBar     = 0
24:     ShowWindow = 1
25:     WindowType = 1
26:     ControlBox   = .F.
27:     Closable     = .F.
28:     MaxButton    = .F.
29:     MinButton    = .F.
30:     ClipControls = .F.
31:     BorderStyle  = 2
32:     DataSession  = 2
33: 
34:     *-- Business Object
35:     this_oBusinessObject = .NULL.
36: 
37:     *-- Referencia ao form pai (para herdar datasession e habilitar ao fechar)
38:     this_oFormPai        = .NULL.
39: 
40:     *-- Data de referencia recebida do form pai
41:     this_dData           = {}
42: 
43:     *-- SigKey da sessao (CrSigCdPac.SigKeys do form pai)
44:     this_cSigKey         = ""
45: 
46:     *-- Parametros de configuracao vindos de crSigCdPam do form pai
47:     this_cDopeCit        = ""
48:     this_cDopTransf      = ""
49:     this_cGruConfs       = ""
50:     this_cConConfs       = ""
51:     this_cGruReservs     = ""
52:     this_cConReservs     = ""
53:     this_cGrupoEsts      = ""
54:     this_cContaEsts      = ""
55: 
56:     *-- Estado interno da grade (Grade.Visible inicia .F. no legado)
57:     this_lGradeVisivel   = .F.
58: 
59:     *--------------------------------------------------------------------------
60:     * Init - Captura form pai ANTES de DODEFAULT para que InicializarForm
61:     * encontre this_oFormPai ao ser chamado por FormBase.Init
62:     *--------------------------------------------------------------------------
63:     PROCEDURE Init(par_oFormPai)
64:         IF TYPE("par_oFormPai") = "O"
65:             THIS.this_oFormPai = par_oFormPai
66: 
67:             *-- Data do form pai
68:             IF PEMSTATUS(par_oFormPai, "txt_4c_Data", 5)
69:                 THIS.this_dData = par_oFormPai.txt_4c_Data.Value
70:             ENDIF
71: 
72:             *-- SigKey do form pai
73:             IF PEMSTATUS(par_oFormPai, "this_cSigKey", 5)
74:                 THIS.this_cSigKey = par_oFormPai.this_cSigKey
75:             ENDIF
76: 
77:             *-- Parametros de configuracao do form pai
78:             IF PEMSTATUS(par_oFormPai, "this_cDopeCit", 5)
79:                 THIS.this_cDopeCit    = par_oFormPai.this_cDopeCit
80:                 THIS.this_cDopTransf  = par_oFormPai.this_cDopTransf
81:                 THIS.this_cGruConfs   = par_oFormPai.this_cGruConfs
82:                 THIS.this_cConConfs   = par_oFormPai.this_cConConfs
83:                 THIS.this_cGruReservs = par_oFormPai.this_cGruReservs
84:                 THIS.this_cConReservs = par_oFormPai.this_cConReservs
85:                 THIS.this_cGrupoEsts  = par_oFormPai.this_cGrupoEsts
86:                 THIS.this_cContaEsts  = par_oFormPai.this_cContaEsts
87:             ENDIF
88:         ENDIF
89: 
90:         RETURN DODEFAULT()
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
95:     * Herda datasession do pai, cria cursores, configura form e monta layout
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE InicializarForm()
98:         LOCAL loc_lSucesso, loc_oErro
99:         loc_lSucesso = .F.
100: 
101:         TRY
102:             *-- Herdar datasession do form pai para acessar cursor_4c_TmpEnc
103:             *-- (equivalente ao legado: DataSessionId = ParentForm.DataSessionId)
104:             IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
105:                 THIS.DataSessionId = THIS.this_oFormPai.DataSessionId
106:             ENDIF
107: 
108:             *-- Caption com acentos via CHR
109:             THIS.Caption = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
110: 
111:             *-- Imagem de fundo (equivalente ao legado new_background.jpg)
112:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
113: 
114:             *-- Criar Business Object e propagar parametros
115:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
116: 
117:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
118:                 MsgErro("Erro ao criar SIGPRCPRBO", "Erro")
119:                 loc_lSucesso = .F.
120:             ENDIF
121: 
122:             *-- Propagar parametros de configuracao para o BO
123:             THIS.PropagararParametrosBO()
124: 
125:             *-- Criar cursor de trabalho cursor_4c_TmpBaixa
126:             THIS.CriarCursorTmpBaixa()
127: 
128:             *-- Construcao do layout do form
129:             THIS.LockScreen = .T.
130:             THIS.ConfigurarCabecalho()
131:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
132:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
133:             THIS.ConfigurarPageFrame()
134:             THIS.ConfigurarPaginaLista()
135:             THIS.ConfigurarPaginaDados()
136:             THIS.TornarControlesVisiveis(THIS)
137:             THIS.LockScreen = .F.
138: 
139:             *-- Carregar dados SE nao estiver em modo de validacao de UI
140:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
141:                 THIS.CarregarBaixas()
142:             ENDIF
143: 
144:             loc_lSucesso = .T.
145: 
146:         CATCH TO loc_oErro
147:             THIS.LockScreen = .F.
148:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
149:         ENDTRY
150: 
151:         RETURN loc_lSucesso
152:     ENDPROC
153: 
154:     *--------------------------------------------------------------------------
155:     * PropagararParametrosBO - Transfere parametros de configuracao para o BO
156:     *--------------------------------------------------------------------------
157:     PROTECTED PROCEDURE PropagararParametrosBO()
158:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
159:             RETURN
160:         ENDIF
161: 
162:         THIS.this_oBusinessObject.this_dData       = THIS.this_dData
163:         THIS.this_oBusinessObject.this_cSigKey     = THIS.this_cSigKey
164:         THIS.this_oBusinessObject.this_cDopeCit    = THIS.this_cDopeCit
165:         THIS.this_oBusinessObject.this_cDopTransf  = THIS.this_cDopTransf
166:         THIS.this_oBusinessObject.this_cGruConfs   = THIS.this_cGruConfs
167:         THIS.this_oBusinessObject.this_cConConfs   = THIS.this_cConConfs
168:         THIS.this_oBusinessObject.this_cGruReservs = THIS.this_cGruReservs
169:         THIS.this_oBusinessObject.this_cConReservs = THIS.this_cConReservs
170:         THIS.this_oBusinessObject.this_cGrupoEsts  = THIS.this_cGrupoEsts
171:         THIS.this_oBusinessObject.this_cContaEsts  = THIS.this_cContaEsts
172:     ENDPROC
173: 
174:     *--------------------------------------------------------------------------
175:     * CriarCursorTmpBaixa - Cria cursor local de trabalho para as etiquetas
176:     * cursor_4c_TmpEnc deve ja existir (criado pelo form pai na datasession compartilhada)
177:     *--------------------------------------------------------------------------
178:     PROTECTED PROCEDURE CriarCursorTmpBaixa()
179:         IF USED("cursor_4c_TmpBaixa")
180:             TABLEREVERT(.T., "cursor_4c_TmpBaixa")
181:             USE IN cursor_4c_TmpBaixa
182:         ENDIF
183: 
184:         SET NULL ON
185:         CREATE CURSOR cursor_4c_TmpBaixa ;
186:             (CodBarra C(20) NULL, ;
187:              CPros    C(14) NULL, ;
188:              Dopes    C(20) NULL, ;
189:              Numes    N(6,0) NULL, ;
190:              Qtde     N(12,3) NULL, ;
191:              QtdeLido N(12,3) NULL, ;
192:              Nops     N(6,0) NULL, ;
193:              Grupods  C(10) NULL, ;
194:              Contads  C(10) NULL)
195:         SET NULL OFF
196: 
197:         INDEX ON CodBarra           TAG CodBarra
198:         INDEX ON ALLTRIM(Grupods) + ALLTRIM(Contads) TAG GruConta
199:     ENDPROC
200: 
201:     *--------------------------------------------------------------------------
202:     * ConfigurarCabecalho - Cria container cinza do header (equivalente cntSombra)
203:     * Width = 1000 (escala de 800 do legado)
204:     *--------------------------------------------------------------------------
205:     PROTECTED PROCEDURE ConfigurarCabecalho()
206:         LOCAL loc_oCab
207: 
208:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
209:         loc_oCab = THIS.cnt_4c_Cabecalho
210: 
211:         WITH loc_oCab
212:             .Top         = 0
213:             .Left        = 0
214:             .Width       = THIS.Width
215:             .Height      = 80
216:             .BackStyle   = 1
217:             .BackColor   = RGB(100, 100, 100)
218:             .BorderWidth = 0
219:             .Visible     = .T.
220: 
221:             .AddObject("lbl_4c_Sombra", "Label")
222:             WITH .lbl_4c_Sombra
223:                 .AutoSize      = .F.
224:                 .Top           = 18
225:                 .Left          = 10
226:                 .Width         = loc_oCab.Width
227:                 .Height        = 40
228:                 .FontBold      = .T.
229:                 .FontName      = "Tahoma"
230:                 .FontSize      = 18
231:                 .FontUnderline = .F.
232:                 .WordWrap      = .T.
233:                 .Alignment     = 0
234:                 .BackStyle     = 0
235:                 .ForeColor     = RGB(0, 0, 0)
236:                 .Caption       = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
237:             ENDWITH
238: 
239:             .AddObject("lbl_4c_Titulo", "Label")
240:             WITH .lbl_4c_Titulo
241:                 .AutoSize  = .F.
242:                 .Top       = 17
243:                 .Left      = 10
244:                 .Width     = loc_oCab.Width
245:                 .Height    = 46

*-- Linhas 273 a 316:
273:     * PageFrame ocupa area abaixo do cabecalho (Top=80) ate o rodape do form.
274:     * Tabs=.F. porque o SCX legado nao possui abas visiveis.
275:     *--------------------------------------------------------------------------
276:     PROTECTED PROCEDURE ConfigurarPageFrame()
277:         LOCAL loc_oPgf
278: 
279:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
280:         loc_oPgf = THIS.pgf_4c_Paginas
281: 
282:         WITH loc_oPgf
283:             .PageCount = 2
284:             .Top       = 80
285:             .Left      = 0
286:             .Width     = THIS.Width
287:             .Height    = THIS.Height - 80
288:             .TabIndex  = 1
289:             .Tabs      = .F.
290:             .BorderWidth = 0
291:         ENDWITH
292: 
293:         loc_oPgf.Page1.Caption = "Lista"
294:         loc_oPgf.Page2.Caption = "Dados"
295: 
296:         *-- Containers principais da Page1 (serao populados nas fases seguintes)
297:         loc_oPgf.Page1.AddObject("cnt_4c_Botoes", "Container")
298:         WITH loc_oPgf.Page1.cnt_4c_Botoes
299:             .Top         = 3
300:             .Left        =  542
301:             .Width       = 300
302:             .Height      = 40
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         loc_oPgf.Page1.AddObject("cnt_4c_BotoesAcao", "Container")
309:         WITH loc_oPgf.Page1.cnt_4c_BotoesAcao
310:             .Top         = 3
311:             .Left        = 725
312:             .Width       = 90
313:             .Height      = 40
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.

*-- Linhas 324 a 459:
324:     * CarregarBaixas - Chama BO para carregar etiquetas em cursor_4c_TmpBaixa
325:     * cursor_4c_TmpEnc deve estar populado pelo form pai na datasession
326:     *--------------------------------------------------------------------------
327:     PROTECTED PROCEDURE CarregarBaixas()
328:         LOCAL loc_lSucesso, loc_oErro
329:         loc_lSucesso = .F.
330: 
331:         TRY
332:             IF !USED("cursor_4c_TmpEnc")
333:                 MsgAviso("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado. " + ;
334:                          "O form pai deve criar este cursor antes de abrir este formul" + ;
335:                          CHR(225) + "rio.", "Aviso")
336:                 loc_lSucesso = .F.
337:             ENDIF
338: 
339:             loc_lSucesso = THIS.this_oBusinessObject.CarregarBaixas()
340: 
341:             IF loc_lSucesso
342:                 THIS.AtualizarGrade()
343:             ENDIF
344: 
345:         CATCH TO loc_oErro
346:             MsgErro(loc_oErro.Message, "Erro CarregarBaixas")
347:         ENDTRY
348: 
349:         RETURN loc_lSucesso
350:     ENDPROC
351: 
352:     *--------------------------------------------------------------------------
353:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
354:     * SKIP: Grade (Visible=.F. inicial, controlado por CarregarBaixas)
355:     *        txt_4c_Leitura e lbl_4c_Txt_Leitura (Visible=.F. inicial)
356:     *--------------------------------------------------------------------------
357:     PROCEDURE TornarControlesVisiveis(par_oContainer)
358:         LOCAL loc_i, loc_oControl
359: 
360:         FOR loc_i = 1 TO par_oContainer.ControlCount
361:             loc_oControl = par_oContainer.Controls(loc_i)
362: 
363:             IF VARTYPE(loc_oControl) = "O"
364:                 *-- Containers/controles que devem permanecer ocultos inicialmente
365:                 IF INLIST(UPPER(loc_oControl.Name), ;
366:                           "GRD_4C_DADOS", ;
367:                           "TXT_4C_LEITURA", ;
368:                           "LBL_4C_TXT_LEITURA", ;
369:                           "CNT_4C_CABECALHO")
370:                     *-- Recursao nos filhos mesmo com LOOP (filhos ficam .T.)
371:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
372:                         THIS.TornarControlesVisiveis(loc_oControl)
373:                     ENDIF
374:                     LOOP
375:                 ENDIF
376: 
377:                 loc_oControl.Visible = .T.
378: 
379:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
380:                     THIS.TornarControlesVisiveis(loc_oControl)
381:                 ENDIF
382:             ENDIF
383:         ENDFOR
384:     ENDPROC
385: 
386:     *--------------------------------------------------------------------------
387:     * Destroy - Libera recursos, habilita form pai e chama DODEFAULT
388:     *--------------------------------------------------------------------------
389:     PROCEDURE Destroy()
390:         LOCAL loc_oErro
391: 
392:         TRY
393:             *-- Liberar cursores locais
394:             IF USED("cursor_4c_TmpBaixa")
395:                 USE IN cursor_4c_TmpBaixa
396:             ENDIF
397: 
398:             *-- Liberar BO
399:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
400:                 THIS.this_oBusinessObject = .NULL.
401:             ENDIF
402: 
403:             *-- Habilitar form pai (equivalente ao legado ParentForm.Enabled = .T.)
404:             IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
405:                 THIS.this_oFormPai.Enabled = .T.
406:             ENDIF
407: 
408:         CATCH TO loc_oErro
409:             MsgErro(loc_oErro.Message, "Erro Destroy")
410:         ENDTRY
411: 
412:         DODEFAULT()
413:     ENDPROC
414: 
415:     *--------------------------------------------------------------------------
416:     * ConfigurarPaginaLista - Popula Page1 com controles operacionais:
417:     * botoes de acao, campo Data, Grid de etiquetas, campo de leitura de codigo
418:     *--------------------------------------------------------------------------
419:     PROTECTED PROCEDURE ConfigurarPaginaLista()
420:         LOCAL loc_oPagina, loc_oCntBotoes, loc_oCntBotoesAcao, loc_oGrd, loc_oErro
421: 
422:         TRY
423:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
424: 
425:             *-- Redimensionar e popular cnt_4c_Botoes (Conf.Auto + Ok)
426:             loc_oCntBotoes = loc_oPagina.cnt_4c_Botoes
427:             WITH loc_oCntBotoes
428:                 .Left   = 720
429:                 .Width  = 165
430:                 .Height = 85
431: 
432:                 .AddObject("cmd_4c_Conferencia", "CommandButton")
433:                 WITH .cmd_4c_Conferencia
434:                     .Top             = 5
435:                     .Left            = 5
436:                     .Width           = 75
437:                     .Height          = 75
438:                     .FontBold        = .T.
439:                     .FontItalic      = .T.
440:                     .FontName        = "Tahoma"
441:                     .FontSize        = 8
442:                     .ForeColor       = RGB(90, 90, 90)
443:                     .BackColor       = RGB(255, 255, 255)
444:                     .Caption         = "Conf. Auto"
445:                     .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
446:                     .Themes          = .F.
447:                     .SpecialEffect   = 0
448:                     .PicturePosition = 13
449:                     .MousePointer    = 15
450:                     .WordWrap        = .T.
451:                     .AutoSize        = .F.
452:                     .Visible         = .F.
453:                 ENDWITH
454: 
455:                 .AddObject("cmd_4c_Ok", "CommandButton")
456:                 WITH .cmd_4c_Ok
457:                     .Top             = 5
458:                     .Left            = 85
459:                     .Width           = 75

*-- Linhas 648 a 1091:
648:                 .Column5.Header1.Alignment = 2
649:             ENDWITH
650: 
651:             *-- BINDEVENTs (metodos PUBLIC por default em DEFINE CLASS)
652:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia, "Click", THIS, "CmdConferenciaClick")
653:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
654:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
655:             BINDEVENT(loc_oPagina.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
656: 
657:         CATCH TO loc_oErro
658:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * AlternarPagina - Alterna a pagina ativa do PageFrame
664:     *--------------------------------------------------------------------------
665:     PROCEDURE AlternarPagina(par_nPagina)
666:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
667:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
668:         ENDIF
669:     ENDPROC
670: 
671:     *--------------------------------------------------------------------------
672:     * AtualizarGrade - Atualiza visibilidade dos controles conforme registros em
673:     * cursor_4c_TmpBaixa (equivalente ao bloco final do legado carregabars)
674:     *--------------------------------------------------------------------------
675:     PROCEDURE AtualizarGrade()
676:         LOCAL loc_lTemDados, loc_oPagina, loc_oErro
677: 
678:         TRY
679:             IF !USED("cursor_4c_TmpBaixa")
680:                 RETURN
681:             ENDIF
682: 
683:             SELECT cursor_4c_TmpBaixa
684:             GO TOP
685:             loc_lTemDados = !EOF()
686: 
687:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
688: 
689:             loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
690:             loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
691:             loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
692:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
693:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
694: 
695:             IF loc_lTemDados
696:                 loc_oPagina.grd_4c_Dados.Refresh()
697:                 loc_oPagina.txt_4c_Leitura.SetFocus()
698:             ELSE
699:                 MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
700:                          CHR(231) + CHR(227) + "o!!!", "Aviso")
701:             ENDIF
702: 
703:         CATCH TO loc_oErro
704:             MsgErro(loc_oErro.Message, "Erro AtualizarGrade")
705:         ENDTRY
706:     ENDPROC
707: 
708:     *--------------------------------------------------------------------------
709:     * CmdConferenciaClick - Conf. Auto: marca todas etiquetas como lidas e
710:     * atualiza grid (equivalente ao legado Conferencia.Click)
711:     *--------------------------------------------------------------------------
712:     PROCEDURE CmdConferenciaClick()
713:         LOCAL loc_oErro
714: 
715:         TRY
716:             THIS.this_oBusinessObject.MarcarTodasLidas()
717:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
718:         CATCH TO loc_oErro
719:             MsgErro(loc_oErro.Message, "Erro CmdConferenciaClick")
720:         ENDTRY
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * CmdOkClick - Confirma conferencia, grava movimentacoes e encerra form
725:     * (equivalente ao legado Ok.Click)
726:     *--------------------------------------------------------------------------
727:     PROCEDURE CmdOkClick()
728:         LOCAL loc_lSucesso, loc_oErro
729: 
730:         TRY
731:             IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
732:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
733:                 RETURN
734:             ENDIF
735: 
736:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarConferencia()
737: 
738:             IF loc_lSucesso
739:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
740:                     THIS.this_oFormPai.Enabled = .T.
741:                 ENDIF
742:                 THIS.Release()
743:             ENDIF
744: 
745:         CATCH TO loc_oErro
746:             MsgErro(loc_oErro.Message, "Erro CmdOkClick")
747:         ENDTRY
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * CmdSairClick - Habilita form pai e fecha este form
752:     * (equivalente ao legado Sair.Click)
753:     *--------------------------------------------------------------------------
754:     PROCEDURE CmdSairClick()
755:         IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
756:             THIS.this_oFormPai.Enabled = .T.
757:         ENDIF
758:         THIS.Release()
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * ConfigurarPaginaDados - Configura Page2 do PageFrame
763:     * Este form OPERACIONAL nao possui controles interativos em Page2.
764:     * O layout completo (campo Data, grid, leitura de codigo) esta em Page1.
765:     * Page2 recebe apenas a imagem de fundo para consistencia visual do sistema.
766:     *--------------------------------------------------------------------------
767:     PROTECTED PROCEDURE ConfigurarPaginaDados()
768:         LOCAL loc_oPagina, loc_oErro
769: 
770:         TRY
771:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
772:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
773:         CATCH TO loc_oErro
774:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
775:         ENDTRY
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * TxtLeituraKeyPress - Processa leitura de codigo de barras
780:     * Simula Valid do legado via KeyPress (ENTER=13 ou TAB=9)
781:     * BINDEVENT "Valid" nao funciona em TextBox no VFP9
782:     *--------------------------------------------------------------------------
783:     PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
784:         LOCAL loc_oTxt, loc_oGrd, loc_cCodBarra, loc_oErro
785: 
786:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
787:             RETURN
788:         ENDIF
789: 
790:         TRY
791:             loc_oTxt      = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
792:             loc_oGrd      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
793:             loc_cCodBarra = ALLTRIM(TRANSFORM(loc_oTxt.Value))
794: 
795:             IF !EMPTY(loc_cCodBarra) AND loc_cCodBarra <> "0"
796:                 THIS.this_oBusinessObject.RegistrarLeitura(loc_cCodBarra)
797: 
798:                 *-- Posicionar cursor no registro lido para atualizar highlighting
799:                 IF USED("cursor_4c_TmpBaixa")
800:                     SELECT cursor_4c_TmpBaixa
801:                     SET ORDER TO TAG CodBarra
802:                     SEEK loc_cCodBarra
803:                 ENDIF
804:             ENDIF
805: 
806:             loc_oTxt.Value = 0
807:             loc_oGrd.Refresh()
808:             loc_oTxt.SetFocus()
809: 
810:         CATCH TO loc_oErro
811:             MsgErro(loc_oErro.Message, "Erro TxtLeituraKeyPress")
812:         ENDTRY
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     * BtnIncluirClick - Inicia nova leitura de codigo de barras
817:     * Form OPERACIONAL: "Incluir" = adicionar nova leitura (foco no reader)
818:     *--------------------------------------------------------------------------
819:     PROCEDURE BtnIncluirClick()
820:         LOCAL loc_oTxt, loc_oErro
821: 
822:         TRY
823:             loc_oTxt = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
824:             loc_oTxt.Value = 0
825:             loc_oTxt.SetFocus()
826:         CATCH TO loc_oErro
827:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
828:         ENDTRY
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     * BtnAlterarClick - Marca todas etiquetas como conferidas (Conf. Auto)
833:     * Form OPERACIONAL: "Alterar" = alterar estado de todas para conferido
834:     *--------------------------------------------------------------------------
835:     PROCEDURE BtnAlterarClick()
836:         LOCAL loc_oErro
837: 
838:         TRY
839:             IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
840:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para conferir.", "Aviso")
841:                 RETURN
842:             ENDIF
843: 
844:             THIS.this_oBusinessObject.MarcarTodasLidas()
845:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
846:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * BtnVisualizarClick - Atualiza visualizacao da grade
854:     * Form OPERACIONAL: "Visualizar" = refresh grade e reposicionar
855:     *--------------------------------------------------------------------------
856:     PROCEDURE BtnVisualizarClick()
857:         LOCAL loc_oGrd, loc_oErro
858: 
859:         TRY
860:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
861: 
862:             IF USED("cursor_4c_TmpBaixa")
863:                 SELECT cursor_4c_TmpBaixa
864:                 GO TOP
865:             ENDIF
866: 
867:             loc_oGrd.Refresh()
868:             loc_oGrd.SetFocus()
869:         CATCH TO loc_oErro
870:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
871:         ENDTRY
872:     ENDPROC
873: 
874:     *--------------------------------------------------------------------------
875:     * BtnExcluirClick - Limpa leituras da etiqueta corrente do grid
876:     * Form OPERACIONAL: "Excluir" = zerar QtdeLido do registro corrente
877:     *--------------------------------------------------------------------------
878:     PROCEDURE BtnExcluirClick()
879:         LOCAL loc_oErro
880: 
881:         TRY
882:             IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
883:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para excluir leitura.", "Aviso")
884:                 RETURN
885:             ENDIF
886: 
887:             SELECT cursor_4c_TmpBaixa
888: 
889:             IF EOF() OR BOF()
890:                 MsgAviso("Selecione uma etiqueta na grade para excluir a leitura.", "Aviso")
891:                 RETURN
892:             ENDIF
893: 
894:             IF NVL(cursor_4c_TmpBaixa.QtdeLido, 0) = 0
895:                 MsgAviso("Esta etiqueta ainda n" + CHR(227) + "o foi lida.", "Aviso")
896:                 RETURN
897:             ENDIF
898: 
899:             IF !MsgConfirma("Confirma limpar a leitura desta etiqueta?", "Confirmar")
900:                 RETURN
901:             ENDIF
902: 
903:             REPLACE QtdeLido WITH 0 IN cursor_4c_TmpBaixa
904: 
905:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
906:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
909:         ENDTRY
910:     ENDPROC
911: 
912:     *--------------------------------------------------------------------------
913:     * BtnBuscarClick - Recarrega etiquetas (refresh completo das baixas)
914:     * Form OPERACIONAL: "Buscar" = reprocessar etiquetas do cursor_4c_TmpEnc
915:     *--------------------------------------------------------------------------
916:     PROCEDURE BtnBuscarClick()
917:         LOCAL loc_oErro
918: 
919:         TRY
920:             THIS.CarregarBaixas()
921:         CATCH TO loc_oErro
922:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
923:         ENDTRY
924:     ENDPROC
925: 
926:     *--------------------------------------------------------------------------
927:     * BtnEncerrarClick - Habilita form pai e fecha este form
928:     * Form OPERACIONAL: equivalente ao botao Encerrar/Sair
929:     *--------------------------------------------------------------------------
930:     PROCEDURE BtnEncerrarClick()
931:         THIS.CmdSairClick()
932:     ENDPROC
933: 
934:     *--------------------------------------------------------------------------
935:     * BtnSalvarClick - Confirma a conferencia das etiquetas e fecha form
936:     * Form OPERACIONAL: equivalente ao botao Ok
937:     *--------------------------------------------------------------------------
938:     PROCEDURE BtnSalvarClick()
939:         THIS.CmdOkClick()
940:     ENDPROC
941: 
942:     *--------------------------------------------------------------------------
943:     * BtnCancelarClick - Cancela leitura atual (limpa campo de codigo de barras)
944:     * Form OPERACIONAL: "Cancelar" = reiniciar leitura sem perder dados da grade
945:     *--------------------------------------------------------------------------
946:     PROCEDURE BtnCancelarClick()
947:         LOCAL loc_oErro
948: 
949:         TRY
950:             THIS.LimparCampos()
951:         CATCH TO loc_oErro
952:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
953:         ENDTRY
954:     ENDPROC
955: 
956:     *--------------------------------------------------------------------------
957:     * FormParaBO - Transfere valores atuais do form para o BO
958:     * Form OPERACIONAL: sincroniza data e propaga parametros de configuracao
959:     *--------------------------------------------------------------------------
960:     PROCEDURE FormParaBO()
961:         LOCAL loc_oErro
962: 
963:         TRY
964:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
965:                 RETURN
966:             ENDIF
967: 
968:             *-- Capturar data atual do campo (pode ter sido alterada pelo pai)
969:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
970:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
971:                     THIS.this_dData = THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value
972:                 ENDIF
973:             ENDIF
974: 
975:             *-- Propagar todos os parametros de configuracao para o BO
976:             THIS.PropagararParametrosBO()
977: 
978:         CATCH TO loc_oErro
979:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
980:         ENDTRY
981:     ENDPROC
982: 
983:     *--------------------------------------------------------------------------
984:     * BOParaForm - Transfere valores do BO para os controles do form
985:     * Form OPERACIONAL: atualiza campo de data com valor do BO
986:     *--------------------------------------------------------------------------
987:     PROCEDURE BOParaForm()
988:         LOCAL loc_oErro
989: 
990:         TRY
991:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
992:                 RETURN
993:             ENDIF
994: 
995:             *-- Sincronizar campo de data com valor do BO
996:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
997:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
998:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
999:                 ENDIF
1000:             ENDIF
1001: 
1002:         CATCH TO loc_oErro
1003:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1004:         ENDTRY
1005:     ENDPROC
1006: 
1007:     *--------------------------------------------------------------------------
1008:     * HabilitarCampos - Habilita/desabilita controles conforme presenca de dados
1009:     * Form OPERACIONAL: campo de leitura e botoes Ok/Conf.Auto ativam so com dados
1010:     *--------------------------------------------------------------------------
1011:     PROCEDURE HabilitarCampos()
1012:         LOCAL loc_lTemDados, loc_oPagina, loc_oErro
1013: 
1014:         TRY
1015:             loc_lTemDados = USED("cursor_4c_TmpBaixa") AND RECCOUNT("cursor_4c_TmpBaixa") > 0
1016: 
1017:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1018:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1019: 
1020:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
1021:                     loc_oPagina.txt_4c_Leitura.Enabled  = loc_lTemDados
1022:                     loc_oPagina.txt_4c_Leitura.Visible  = loc_lTemDados
1023:                 ENDIF
1024: 
1025:                 IF PEMSTATUS(loc_oPagina, "lbl_4c_Txt_Leitura", 5)
1026:                     loc_oPagina.lbl_4c_Txt_Leitura.Visible = loc_lTemDados
1027:                 ENDIF
1028: 
1029:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1030:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Ok", 5)
1031:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible = loc_lTemDados
1032:                     ENDIF
1033:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Conferencia", 5)
1034:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
1035:                     ENDIF
1036:                 ENDIF
1037: 
1038:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1039:                     loc_oPagina.grd_4c_Dados.Visible = loc_lTemDados
1040:                     IF loc_lTemDados
1041:                         loc_oPagina.grd_4c_Dados.Refresh()
1042:                     ENDIF
1043:                 ENDIF
1044:             ENDIF
1045: 
1046:         CATCH TO loc_oErro
1047:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1048:         ENDTRY
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * LimparCampos - Limpa campo de leitura de codigo de barras
1053:     * Form OPERACIONAL: reinicia leitura sem alterar dados da grade
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE LimparCampos()
1056:         LOCAL loc_oPagina, loc_oErro
1057: 
1058:         TRY
1059:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1060:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1061: 
1062:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
1063:                     loc_oPagina.txt_4c_Leitura.Value = 0
1064:                     IF loc_oPagina.txt_4c_Leitura.Visible
1065:                         loc_oPagina.txt_4c_Leitura.SetFocus()
1066:                     ENDIF
1067:                 ENDIF
1068:             ENDIF
1069: 
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
1072:         ENDTRY
1073:     ENDPROC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * CarregarLista - Wrapper sobre CarregarBaixas para conformidade com FormBase
1077:     * Form OPERACIONAL: reprocessa etiquetas do cursor_4c_TmpEnc
1078:     *--------------------------------------------------------------------------
1079:     PROCEDURE CarregarLista()
1080:         RETURN THIS.CarregarBaixas()
1081:     ENDPROC
1082: 
1083:     *--------------------------------------------------------------------------
1084:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme estado dos dados
1085:     * Form OPERACIONAL: delega para AtualizarGrade que gerencia visibilidade
1086:     *--------------------------------------------------------------------------
1087:     PROCEDURE AjustarBotoesPorModo()
1088:         THIS.AtualizarGrade()
1089:     ENDPROC
1090: 
1091: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Herda de: BusinessBase
* Tabela principal: SigOpEtq (etiquetas de producao)
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Chave e tabela principal
    this_cTabela      = "SigOpEtq"
    this_cCampoChave  = "CBars"

    *-- Data de referencia (Get_Data do form pai)
    this_dData        = {}

    *-- Chave unica da sessao (CrSigCdPac.SigKeys)
    this_cSigKey      = ""

    *-- Parametros vindos de crSigCdPam
    this_cDopeCit     = ""
    this_cDopTransf   = ""
    this_cGruConfs    = ""
    this_cConConfs    = ""
    this_cGruReservs  = ""
    this_cConReservs  = ""
    this_cGrupoEsts   = ""
    this_cContaEsts   = ""

    *-- Campos do cursor cursor_4c_TmpBaixa (linha corrente)
    this_cCodBarra    = ""
    this_cCPros       = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nQtde        = 0
    this_nQtdeLido    = 0
    this_nNops        = 0
    this_cGrupods     = ""
    this_cContads     = ""

    *-- Estado interno
    this_lGradeVisivel = .F.
    this_nSeqContador  = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            DODEFAULT()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades this_
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodBarra  = TratarNulo(CodBarra,  "C")
                THIS.this_cCPros     = TratarNulo(CPros,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_nQtde      = TratarNulo(Qtde,      "N")
                THIS.this_nQtdeLido  = TratarNulo(QtdeLido,  "N")
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_cGrupods   = TratarNulo(Grupods,   "C")
                THIS.this_cContads   = TratarNulo(Contads,   "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBaixas - Carrega etiquetas de producao em cursor_4c_TmpBaixa
    * Equivalente ao legado carregabars.
    * Pre-requisito: cursor_4c_TmpEnc deve existir (Dopps C, Numps N)
    * cursor_4c_TmpBaixa deve existir com tags CodBarra e GruConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBaixas()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL
        LOCAL loc_cDopps, loc_nNumps, loc_cChave
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_cGruReservs, loc_cConReservs
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_cDopeCit
        LOCAL loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs
        LOCAL loc_nNops, loc_cEmpos, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtEti, loc_nQtCit, loc_nBaixa, loc_nPendente, loc_nPVal
        LOCAL loc_llBaixa, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_cEmpDopNumsCit

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_TmpEnc")
                MsgErro("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar TmpBaixa
            SELECT cursor_4c_TmpBaixa
            ZAP

            loc_cGruConfs   = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs   = ALLTRIM(THIS.this_cConConfs)
            loc_cGruReservs = ALLTRIM(THIS.this_cGruReservs)
            loc_cConReservs = ALLTRIM(THIS.this_cConReservs)
            loc_cGrupoEsts  = ALLTRIM(THIS.this_cGrupoEsts)
            loc_cContaEsts  = ALLTRIM(THIS.this_cContaEsts)
            loc_cDopeCit    = ALLTRIM(THIS.this_cDopeCit)

            SELECT cursor_4c_TmpEnc
            GO TOP

            SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                loc_cDopps = ALLTRIM(cursor_4c_TmpEnc.Dopps)
                loc_nNumps = cursor_4c_TmpEnc.Numps
                loc_cChave = go_4c_Sistema.cCodEmpresa + loc_cDopps + STR(loc_nNumps, 6)

                *-- Buscar etiquetas desta OS
                loc_cSQL = "SELECT e.CBars, e.CPros, e.DopeOs, e.NumeOs, e.Qtds, e.Nops, " + ;
                           "e.Empos, e.CodCors, e.CodTams, e.Grupos, e.Contas " + ;
                           "FROM SigOpEtq e " + ;
                           "WHERE e.EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtqBx") > 0
                    SELECT cursor_4c_SigOpEtqBx
                    SCAN
                        *-- Verificar se etiqueta pertence ao grupo/conta de conferencia
                        IF ALLTRIM(cursor_4c_SigOpEtqBx.Grupos) + ALLTRIM(cursor_4c_SigOpEtqBx.Contas) <> ;
                           loc_cGruConfs + loc_cConConfs
                            LOOP
                        ENDIF

                        loc_cCBars   = ALLTRIM(cursor_4c_SigOpEtqBx.CBars)
                        loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtqBx.CPros)
                        loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtqBx.DopeOs)
                        loc_nNumeOs  = cursor_4c_SigOpEtqBx.NumeOs
                        loc_nNops    = cursor_4c_SigOpEtqBx.Nops
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqBx.Empos)
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqBx.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqBx.CodTams)
                        loc_nQtEti   = cursor_4c_SigOpEtqBx.Qtds
                        loc_nQtCit   = 0

                        *-- Buscar movimento origem para determinar grupos/contas
                        loc_cSQL = "SELECT TOP 1 m.Dopes, m.Grupoos, m.Contaos, m.Grupods, m.Contads " + ;
                                   "FROM SigMvCab m " + ;
                                   "WHERE m.EmpDopNums = " + EscaparSQL(loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCabBx") > 0
                            SELECT cursor_4c_MvCabBx
                            IF !EOF()
                                *-- Verificar tipo de operacao (Globalizas/Servicos)
                                loc_cSQL = "SELECT TOP 1 Globalizas, Servicos FROM SigCdOpe " + ;
                                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_MvCabBx.Dopes))

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeBx") > 0
                                    SELECT cursor_4c_SigCdOpeBx
                                    IF !EOF() AND (NVL(cursor_4c_SigCdOpeBx.Globalizas, 0) = 1 OR ;
                                                   NVL(cursor_4c_SigCdOpeBx.Servicos, 0) = 1)
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupoos)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contaos)
                                    ELSE
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                    ENDIF
                                    IF USED("cursor_4c_SigCdOpeBx")
                                        USE IN cursor_4c_SigCdOpeBx
                                    ENDIF
                                ELSE
                                    loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                    loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                ENDIF

                                *-- Aplicar override de GruReservs/ConReservs
                                loc_cGrupo = IIF(EMPTY(loc_cGruReservs), loc_cTGrupo, loc_cGruReservs)
                                loc_cConta = IIF(EMPTY(loc_cConReservs), loc_cTConta, loc_cConReservs)

                                *-- Processar operacao de citacao (DopeCit) se configurada
                                IF !EMPTY(loc_cDopeCit)
                                    loc_cEmpDopNumsCit = loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)
                                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCit") > 0
                                        SELECT cursor_4c_ChkCit
                                        IF !EOF() AND NVL(cursor_4c_ChkCit.nExiste, 0) > 0
                                            loc_nBaixa = loc_nQtEti

                                                *-- Baixar SigMvItn (itens simples por produto)
                                                loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds " + ;
                                                           "FROM SigMvItn " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCit") > 0
                                                    SELECT cursor_4c_ItnCit
                                                    GO TOP
                                                    SCAN WHILE !EOF("cursor_4c_ItnCit") AND loc_nBaixa > 0
                                                        IF (cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas) <> 0
                                                            loc_nPendente = cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal  = loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nPVal  = loc_nPendente
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItnCit.QtBaixas + loc_nPVal = cursor_4c_ItnCit.Qtds, 1, 0)
                                                            loc_cSQL = "UPDATE SigMvItn " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + ", " + ;
                                                                       "DtAlts = GETDATE() " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItn")
                                                            IF USED("cursor_4c_UpdItn")
                                                                USE IN cursor_4c_UpdItn
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItnCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItnCit")
                                                        USE IN cursor_4c_ItnCit
                                                    ENDIF
                                                ENDIF
                                                *-- Baixar SigMvIts (itens com cor/tamanho)
                                                loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                                           "FROM SigMvIts " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                                           " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                                           " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItsCit") > 0
                                                    SELECT cursor_4c_ItsCit
                                                    SCAN WHILE !EOF("cursor_4c_ItsCit") AND loc_nBaixa > 0
                                                        loc_nPendente = cursor_4c_ItsCit.Qtds - cursor_4c_ItsCit.QtBaixas
                                                        IF loc_nPendente <> 0
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal = loc_nBaixa
                                                            ELSE
                                                                loc_nPVal = loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItsCit.QtBaixas + loc_nPVal = cursor_4c_ItsCit.Qtds, 1, 0)

                                                            loc_cSQL = "UPDATE SigMvIts " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + " " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdIts")
                                                            IF USED("cursor_4c_UpdIts")
                                                                USE IN cursor_4c_UpdIts
                                                            ENDIF

                                                            *-- Atualizar SigMvItn correspondente ao item
                                                            loc_cSQL = "SELECT cIdChaves FROM SigMvItn " + ;
                                                                       "WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.EmpDopNums)) + ;
                                                                       " AND CItens = " + TRANSFORM(cursor_4c_ItsCit.CItens)
                                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCorr") > 0
                                                                SELECT cursor_4c_ItnCorr
                                                                IF !EOF()
                                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                                               "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                               "DtAlts = GETDATE() " + ;
                                                                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCorr.cIdChaves))
                                                                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItnC")
                                                                    IF USED("cursor_4c_UpdItnC")
                                                                        USE IN cursor_4c_UpdItnC
                                                                    ENDIF
                                                                ENDIF
                                                                IF USED("cursor_4c_ItnCorr")
                                                                    USE IN cursor_4c_ItnCorr
                                                                ENDIF
                                                            ENDIF

                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItsCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItsCit")
                                                        USE IN cursor_4c_ItsCit
                                                    ENDIF
                                                ENDIF

                                            loc_nQtCit = loc_nQtEti - loc_nBaixa
                                        ENDIF
                                        IF USED("cursor_4c_ChkCit")
                                            USE IN cursor_4c_ChkCit
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- Calcular quantidade que vai para TmpBaixa
                                loc_nQtEti = cursor_4c_SigOpEtqBx.Qtds - loc_nQtCit

                                *-- Inserir na TmpBaixa (quantidade principal -> grupo/conta destino)
                                IF loc_nQtEti <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtEti, 0, loc_nNops, loc_cGrupo, loc_cConta)
                                ENDIF

                                *-- Inserir na TmpBaixa (quantidade citacao -> grupo/conta estoque)
                                IF loc_nQtCit <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtCit, 0, loc_nNops, loc_cGrupoEsts, loc_cContaEsts)
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_MvCabBx")
                                USE IN cursor_4c_MvCabBx
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpEtqBx
                    ENDSCAN

                    IF USED("cursor_4c_SigOpEtqBx")
                        USE IN cursor_4c_SigOpEtqBx
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpEnc
            ENDSCAN

            *-- Posicionar no inicio da TmpBaixa
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLeitura - Marca codigo de barras como lido na cursor_4c_TmpBaixa
    * Equivalente ao legado Get_Leitura.Valid
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLeitura(par_cCodBarra)
        LOCAL loc_lSucesso, loc_oErro, loc_cCodBarra

        loc_lSucesso = .F.
        loc_cCodBarra = ALLTRIM(par_cCodBarra)

        TRY
            IF EMPTY(loc_cCodBarra) OR !USED("cursor_4c_TmpBaixa")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_TmpBaixa
            SET ORDER TO TAG CodBarra

            IF SEEK(loc_cCodBarra)
                IF cursor_4c_TmpBaixa.QtdeLido = 0
                    REPLACE QtdeLido WITH cursor_4c_TmpBaixa.Qtde IN cursor_4c_TmpBaixa
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLidas - Marca todas etiquetas como lidas (Conferencia Auto)
    * Equivalente ao legado Conferencia.Click
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLidas()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG CodBarra
                REPLACE ALL QtdeLido WITH Qtde IN cursor_4c_TmpBaixa
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConferencia - Processa confirmacao da conferencia (equivalente Ok.Click)
    * Cria SigMvCab + SigMvItn + SigMvHst e atualiza SigOpEtq para cada item lido
    * Pre-requisito: this_cDopTransf, this_cGruConfs, this_cConConfs, this_cSigKey devem estar setados
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_llTaOk
        LOCAL loc_cSQL, loc_nNume, loc_cDopTransf
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_nItem, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads, loc_cEmpDopNums
        LOCAL loc_cCPros, loc_cCodBarra, loc_nQtdeLido
        LOCAL loc_cDPros, loc_cCUnis
        LOCAL loc_cEmposItm, loc_cCodCors2, loc_cCodTams2

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cDopTransf = ALLTRIM(THIS.this_cDopTransf)
            loc_cGruConfs  = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs  = ALLTRIM(THIS.this_cConConfs)

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trans")
            IF USED("cursor_4c_Trans")
                USE IN cursor_4c_Trans
            ENDIF

            loc_llTaOk = .T.

            *-- Obter grupos/contas distintos com itens lidos
            SELECT DISTINCT Grupods, Contads FROM cursor_4c_TmpBaixa ;
                WHERE QtdeLido <> 0 ;
                INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            GO TOP

            SCAN WHILE !EOF("cursor_4c_xCabec") AND loc_llTaOk
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                *-- Gerar numero unico do movimento
                loc_nNume      = THIS.GerarChaveUnica(go_4c_Sistema.cCodEmpresa + loc_cDopTransf)
                loc_cEmpDopNums = go_4c_Sistema.cCodEmpresa + loc_cDopTransf + STR(loc_nNume, 6)

                *-- Inserir cabecalho SigMvCab
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                           "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cIdChaves, DtAlts, EmpGopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                           EscaparSQL(loc_cDopTransf) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(THIS.GerarMascara(loc_nNume)) + ", " + ;
                           "GETDATE(), GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cGruConfs) + ", " + ;
                           EscaparSQL(loc_cConConfs) + ", " + ;
                           EscaparSQL(loc_cGrupods) + ", " + ;
                           EscaparSQL(loc_cContads) + ", " + ;
                           EscaparSQL(loc_cEmpDopNums) + ", " + ;
                           EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResCab") < 1
                    MsgErro("Falha ao inserir SigMvCab!", "Erro")
                    loc_llTaOk = .F.
                    EXIT
                ENDIF
                IF USED("cursor_4c_ResCab")
                    USE IN cursor_4c_ResCab
                ENDIF

                *-- Iterar itens deste grupo/conta
                loc_nItem = 0
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                      FOR QtdeLido <> 0

                    loc_nItem     = loc_nItem + 1
                    loc_cCPros    = ALLTRIM(cursor_4c_TmpBaixa.CPros)
                    loc_cCodBarra = ALLTRIM(cursor_4c_TmpBaixa.CodBarra)
                    loc_nQtdeLido = cursor_4c_TmpBaixa.QtdeLido

                    *-- Buscar dados do produto (descricao e unidade)
                    loc_cDPros = ""
                    loc_cCUnis = ""
                    loc_cSQL = "SELECT DPros, CUnis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProItm") > 0
                        SELECT cursor_4c_ProItm
                        IF !EOF()
                            loc_cDPros = ALLTRIM(DPros)
                            loc_cCUnis = ALLTRIM(CUnis)
                        ENDIF
                        IF USED("cursor_4c_ProItm")
                            USE IN cursor_4c_ProItm
                        ENDIF
                    ENDIF

                    *-- Buscar dados da etiqueta (cor, tamanho, empresa origem)
                    loc_cCodCors2 = ""
                    loc_cCodTams2 = ""
                    loc_cEmposItm = go_4c_Sistema.cCodEmpresa
                    loc_cSQL = "SELECT CodCors, CodTams, Empos FROM SigOpEtq WHERE CBars = " + EscaparSQL(loc_cCodBarra)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtqItm") > 0
                        SELECT cursor_4c_EtqItm
                        IF !EOF()
                            loc_cCodCors2 = ALLTRIM(CodCors)
                            loc_cCodTams2 = ALLTRIM(CodTams)
                            loc_cEmposItm = ALLTRIM(Empos)
                        ENDIF
                        IF USED("cursor_4c_EtqItm")
                            USE IN cursor_4c_EtqItm
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_TmpBaixa

                    *-- Inserir item SigMvItn
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(CItens, Emps, Dopes, Numes, CPros, Qtds, CUnis, DPros, Opers, " + ;
                               "CodBarras, EmpDopNums, cIdChaves, DtAlts) " + ;
                               "VALUES (" + ;
                               TRANSFORM(loc_nItem) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               EscaparSQL(loc_cCUnis) + ", " + ;
                               EscaparSQL(loc_cDPros) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                               "GETDATE())"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResItn") < 1
                        MsgErro("Falha ao inserir SigMvItn!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResItn")
                        USE IN cursor_4c_ResItn
                    ENDIF

                    *-- Historico de saida do grupo conferencia (S)
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cGruConfs) + ", " + ;
                               EscaparSQL(loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGruConfs + loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstS") < 1
                        MsgErro("Falha ao inserir SigMvHst (S)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstS")
                        USE IN cursor_4c_ResHstS
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGruConfs, loc_cConConfs, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Historico de entrada no grupo destino (E)
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'E', " + ;
                               EscaparSQL(loc_cGrupods) + ", " + ;
                               EscaparSQL(loc_cContads) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGrupods + loc_cContads) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstE") < 1
                        MsgErro("Falha ao inserir SigMvHst (E)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstE")
                        USE IN cursor_4c_ResHstE
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGrupods, loc_cContads, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Atualizar SigOpEtq com grupo/conta destino
                    loc_cSQL = "UPDATE SigOpEtq " + ;
                               "SET Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = GETDATE() " + ;
                               "WHERE CBars = " + EscaparSQL(loc_cCodBarra)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResEtq") < 1
                        MsgErro("Falha ao atualizar SigOpEtq!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResEtq")
                        USE IN cursor_4c_ResEtq
                    ENDIF

                    SELECT cursor_4c_TmpBaixa
                ENDSCAN

                IF !loc_llTaOk
                    EXIT
                ENDIF

                SELECT cursor_4c_xCabec
            ENDSCAN

            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF

            *-- Confirmar ou reverter transacao
            IF loc_llTaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
                THIS.RegistrarAuditoria("CONFERENCIA")
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
            IF USED("cursor_4c_TransR")
                USE IN cursor_4c_TransR
            ENDIF
            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Processa a conferencia das etiquetas (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarConferencia()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Registra leitura de codigo de barras (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cCodBarra)
        LOCAL loc_cCodBarra
        loc_cCodBarra = IIF(PCOUNT() > 0, par_cCodBarra, THIS.this_cCodBarra)
        RETURN THIS.RegistrarLeitura(loc_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Audit")
            IF USED("cursor_4c_Audit")
                USE IN cursor_4c_Audit
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera numero sequencial unico por prefixo
    * Prefixo de movimento (Emps+Dopes, >8 chars): usa MAX(Numes)+1 de SigMvCab
    * Prefixo curto (data YYYYMMDD ou HISTBAR): usa contador interno this_nSeqContador
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica(par_cPrefixo)
        LOCAL loc_nChave, loc_cSQL, loc_cPref, loc_oErro

        loc_nChave = 1
        loc_cPref  = ALLTRIM(par_cPrefixo)

        TRY
            IF LEN(loc_cPref) > 8
                *-- Prefixo de movimento: Emps + Dopes
                loc_cSQL = "SELECT ISNULL(MAX(Numes), 0) + 1 AS Proximo " + ;
                           "FROM SigMvCab " + ;
                           "WHERE LEFT(EmpDopNums, " + TRANSFORM(LEN(loc_cPref)) + ") = " + EscaparSQL(loc_cPref)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqMv") > 0
                    SELECT cursor_4c_SeqMv
                    IF !EOF()
                        loc_nChave = NVL(cursor_4c_SeqMv.Proximo, 1)
                    ENDIF
                    IF USED("cursor_4c_SeqMv")
                        USE IN cursor_4c_SeqMv
                    ENDIF
                ENDIF
            ELSE
                *-- Prefixo curto (data ou HISTBAR): contador interno da sessao
                THIS.this_nSeqContador = THIS.this_nSeqContador + 1
                loc_nChave = THIS.this_nSeqContador
            ENDIF

        CATCH TO loc_oErro
            THIS.this_nSeqContador = THIS.this_nSeqContador + 1
            loc_nChave = THIS.this_nSeqContador
        ENDTRY

        RETURN loc_nChave
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera string ID unico para cIdChaves
    * Equivalente ao legado fUniqueIds()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIdUnico()
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1
        RETURN SYS(2015) + TRANSFORM(THIS.this_nSeqContador, "@L 99999")
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMascara - Formata numero como string mascarada
    * Equivalente ao legado fGerMascara()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarMascara(par_nNumero)
        RETURN ALLTRIM(TRANSFORM(par_nNumero, "@L 999999"))
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularPositivo - Recalcula posicao de estoque via stored procedure
    * Equivalente ao legado fRecalculaP por registro (SigOpClP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularPositivo(par_cEmps, par_cGrupos, par_cEstos, par_cCPros, par_cCodCors, par_cCodTams)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClP " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@Grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ", " + ;
                       "@Estos = " + EscaparSQL(ALLTRIM(par_cEstos)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ", " + ;
                       "@CodCors = " + EscaparSQL(ALLTRIM(par_cCodCors)) + ", " + ;
                       "@CodTams = " + EscaparSQL(ALLTRIM(par_cCodTams))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecP")
            IF USED("cursor_4c_ResRecP")
                USE IN cursor_4c_ResRecP
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular posi" + CHR(231) + CHR(227) + "o de estoque: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularCusto - Recalcula custo do produto via stored procedure
    * Equivalente ao legado fRecalculaC por registro (SigOpClC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularCusto(par_cEmps, par_cCPros)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClC " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecC")
            IF USED("cursor_4c_ResRecC")
                USE IN cursor_4c_ResRecC
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular custo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

