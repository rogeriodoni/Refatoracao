# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPR): Top original=110 vs migrado 'lbl_4c_Label2' Top=48 (diff=62px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPR): Left original=133 vs migrado 'lbl_4c_Label2' Left=12 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Txt_Leitura' (parent: SIGPRCPR): Top original=359 vs migrado 'lbl_4c_Txt_Leitura' Top=455 (diff=96px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Txt_Leitura' (parent: SIGPRCPR): Left original=133 vs migrado 'lbl_4c_Txt_Leitura' Left=12 (diff=121px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1088 linhas total):

*-- Linhas 10 a 243:
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
131:             THIS.ConfigurarPageFrame()
132:             THIS.ConfigurarPaginaLista()
133:             THIS.ConfigurarPaginaDados()
134:             THIS.TornarControlesVisiveis(THIS)
135:             THIS.LockScreen = .F.
136: 
137:             *-- Carregar dados SE nao estiver em modo de validacao de UI
138:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
139:                 THIS.CarregarBaixas()
140:             ENDIF
141: 
142:             loc_lSucesso = .T.
143: 
144:         CATCH TO loc_oErro
145:             THIS.LockScreen = .F.
146:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
147:         ENDTRY
148: 
149:         RETURN loc_lSucesso
150:     ENDPROC
151: 
152:     *--------------------------------------------------------------------------
153:     * PropagararParametrosBO - Transfere parametros de configuracao para o BO
154:     *--------------------------------------------------------------------------
155:     PROTECTED PROCEDURE PropagararParametrosBO()
156:         IF VARTYPE(THIS.this_oBusinessObject) # "O"
157:             RETURN
158:         ENDIF
159: 
160:         THIS.this_oBusinessObject.this_dData       = THIS.this_dData
161:         THIS.this_oBusinessObject.this_cSigKey     = THIS.this_cSigKey
162:         THIS.this_oBusinessObject.this_cDopeCit    = THIS.this_cDopeCit
163:         THIS.this_oBusinessObject.this_cDopTransf  = THIS.this_cDopTransf
164:         THIS.this_oBusinessObject.this_cGruConfs   = THIS.this_cGruConfs
165:         THIS.this_oBusinessObject.this_cConConfs   = THIS.this_cConConfs
166:         THIS.this_oBusinessObject.this_cGruReservs = THIS.this_cGruReservs
167:         THIS.this_oBusinessObject.this_cConReservs = THIS.this_cConReservs
168:         THIS.this_oBusinessObject.this_cGrupoEsts  = THIS.this_cGrupoEsts
169:         THIS.this_oBusinessObject.this_cContaEsts  = THIS.this_cContaEsts
170:     ENDPROC
171: 
172:     *--------------------------------------------------------------------------
173:     * CriarCursorTmpBaixa - Cria cursor local de trabalho para as etiquetas
174:     * cursor_4c_TmpEnc deve ja existir (criado pelo form pai na datasession compartilhada)
175:     *--------------------------------------------------------------------------
176:     PROTECTED PROCEDURE CriarCursorTmpBaixa()
177:         IF USED("cursor_4c_TmpBaixa")
178:             TABLEREVERT(.T., "cursor_4c_TmpBaixa")
179:             USE IN cursor_4c_TmpBaixa
180:         ENDIF
181: 
182:         SET NULL ON
183:         CREATE CURSOR cursor_4c_TmpBaixa ;
184:             (CodBarra C(20) NULL, ;
185:              CPros    C(14) NULL, ;
186:              Dopes    C(20) NULL, ;
187:              Numes    N(6,0) NULL, ;
188:              Qtde     N(12,3) NULL, ;
189:              QtdeLido N(12,3) NULL, ;
190:              Nops     N(6,0) NULL, ;
191:              Grupods  C(10) NULL, ;
192:              Contads  C(10) NULL)
193:         SET NULL OFF
194: 
195:         INDEX ON CodBarra           TAG CodBarra
196:         INDEX ON ALLTRIM(Grupods) + ALLTRIM(Contads) TAG GruConta
197:     ENDPROC
198: 
199:     *--------------------------------------------------------------------------
200:     * ConfigurarCabecalho - Cria container cinza do header (equivalente cntSombra)
201:     * Width = 1000 (escala de 800 do legado)
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarCabecalho()
204:         LOCAL loc_oCab
205: 
206:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
207:         loc_oCab = THIS.cnt_4c_Cabecalho
208: 
209:         WITH loc_oCab
210:             .Top         = 0
211:             .Left        = 0
212:             .Width       = THIS.Width
213:             .Height      = 80
214:             .BackStyle   = 1
215:             .BackColor   = RGB(100, 100, 100)
216:             .BorderWidth = 0
217: 
218:             .AddObject("lbl_4c_Sombra", "Label")
219:             WITH .lbl_4c_Sombra
220:                 .AutoSize      = .F.
221:                 .Top           = 18
222:                 .Left          = 10
223:                 .Width         = loc_oCab.Width
224:                 .Height        = 40
225:                 .FontBold      = .T.
226:                 .FontName      = "Tahoma"
227:                 .FontSize      = 18
228:                 .FontUnderline = .F.
229:                 .WordWrap      = .T.
230:                 .Alignment     = 0
231:                 .BackStyle     = 0
232:                 .ForeColor     = RGB(0, 0, 0)
233:                 .Caption       = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
234:             ENDWITH
235: 
236:             .AddObject("lbl_4c_Titulo", "Label")
237:             WITH .lbl_4c_Titulo
238:                 .AutoSize  = .F.
239:                 .Top       = 17
240:                 .Left      = 10
241:                 .Width     = loc_oCab.Width
242:                 .Height    = 46
243:                 .FontBold  = .T.

*-- Linhas 270 a 313:
270:     * PageFrame ocupa area abaixo do cabecalho (Top=80) ate o rodape do form.
271:     * Tabs=.F. porque o SCX legado nao possui abas visiveis.
272:     *--------------------------------------------------------------------------
273:     PROTECTED PROCEDURE ConfigurarPageFrame()
274:         LOCAL loc_oPgf
275: 
276:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
277:         loc_oPgf = THIS.pgf_4c_Paginas
278: 
279:         WITH loc_oPgf
280:             .PageCount = 2
281:             .Top       = 80
282:             .Left      = 0
283:             .Width     = THIS.Width
284:             .Height    = THIS.Height - 80
285:             .TabIndex  = 1
286:             .Tabs      = .F.
287:             .BorderWidth = 0
288:         ENDWITH
289: 
290:         loc_oPgf.Page1.Caption = "Lista"
291:         loc_oPgf.Page2.Caption = "Dados"
292: 
293:         *-- Containers principais da Page1 (serao populados nas fases seguintes)
294:         loc_oPgf.Page1.AddObject("cnt_4c_Botoes", "Container")
295:         WITH loc_oPgf.Page1.cnt_4c_Botoes
296:             .Top         = 3
297:             .Left        =  542
298:             .Width       = 300
299:             .Height      = 40
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         loc_oPgf.Page1.AddObject("cnt_4c_BotoesAcao", "Container")
306:         WITH loc_oPgf.Page1.cnt_4c_BotoesAcao
307:             .Top         = 3
308:             .Left        = 725
309:             .Width       = 90
310:             .Height      = 40
311:             .BackStyle   = 0
312:             .BorderWidth = 0
313:             .Visible     = .T.

*-- Linhas 321 a 455:
321:     * CarregarBaixas - Chama BO para carregar etiquetas em cursor_4c_TmpBaixa
322:     * cursor_4c_TmpEnc deve estar populado pelo form pai na datasession
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE CarregarBaixas()
325:         LOCAL loc_lSucesso, loc_oErro
326:         loc_lSucesso = .F.
327: 
328:         TRY
329:             IF !USED("cursor_4c_TmpEnc")
330:                 MsgAviso("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado. " + ;
331:                          "O form pai deve criar este cursor antes de abrir este formul" + ;
332:                          CHR(225) + "rio.", "Aviso")
333:                 loc_lSucesso = .F.
334:             ENDIF
335: 
336:             loc_lSucesso = THIS.this_oBusinessObject.CarregarBaixas()
337: 
338:             IF loc_lSucesso
339:                 THIS.AtualizarGrade()
340:             ENDIF
341: 
342:         CATCH TO loc_oErro
343:             MsgErro(loc_oErro.Message, "Erro CarregarBaixas")
344:         ENDTRY
345: 
346:         RETURN loc_lSucesso
347:     ENDPROC
348: 
349:     *--------------------------------------------------------------------------
350:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
351:     * SKIP: Grade (Visible=.F. inicial, controlado por CarregarBaixas)
352:     *        txt_4c_Leitura e lbl_4c_Txt_Leitura (Visible=.F. inicial)
353:     *--------------------------------------------------------------------------
354:     PROCEDURE TornarControlesVisiveis(par_oContainer)
355:         LOCAL loc_i, loc_oControl
356: 
357:         FOR loc_i = 1 TO par_oContainer.ControlCount
358:             loc_oControl = par_oContainer.Controls(loc_i)
359: 
360:             IF VARTYPE(loc_oControl) = "O"
361:                 *-- Containers/controles que devem permanecer ocultos inicialmente
362:                 IF INLIST(UPPER(loc_oControl.Name), ;
363:                           "GRD_4C_DADOS", ;
364:                           "TXT_4C_LEITURA", ;
365:                           "LBL_4C_TXT_LEITURA")
366:                     *-- Recursao nos filhos mesmo com LOOP (filhos ficam .T.)
367:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
368:                         THIS.TornarControlesVisiveis(loc_oControl)
369:                     ENDIF
370:                     LOOP
371:                 ENDIF
372: 
373:                 loc_oControl.Visible = .T.
374: 
375:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
376:                     THIS.TornarControlesVisiveis(loc_oControl)
377:                 ENDIF
378:             ENDIF
379:         ENDFOR
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * Destroy - Libera recursos, habilita form pai e chama DODEFAULT
384:     *--------------------------------------------------------------------------
385:     PROCEDURE Destroy()
386:         LOCAL loc_oErro
387: 
388:         TRY
389:             *-- Liberar cursores locais
390:             IF USED("cursor_4c_TmpBaixa")
391:                 USE IN cursor_4c_TmpBaixa
392:             ENDIF
393: 
394:             *-- Liberar BO
395:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
396:                 THIS.this_oBusinessObject = .NULL.
397:             ENDIF
398: 
399:             *-- Habilitar form pai (equivalente ao legado ParentForm.Enabled = .T.)
400:             IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
401:                 THIS.this_oFormPai.Enabled = .T.
402:             ENDIF
403: 
404:         CATCH TO loc_oErro
405:             MsgErro(loc_oErro.Message, "Erro Destroy")
406:         ENDTRY
407: 
408:         DODEFAULT()
409:     ENDPROC
410: 
411:     *--------------------------------------------------------------------------
412:     * ConfigurarPaginaLista - Popula Page1 com controles operacionais:
413:     * botoes de acao, campo Data, Grid de etiquetas, campo de leitura de codigo
414:     *--------------------------------------------------------------------------
415:     PROTECTED PROCEDURE ConfigurarPaginaLista()
416:         LOCAL loc_oPagina, loc_oCntBotoes, loc_oCntBotoesAcao, loc_oGrd, loc_oErro
417: 
418:         TRY
419:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
420: 
421:             *-- Redimensionar e popular cnt_4c_Botoes (Conf.Auto + Ok)
422:             loc_oCntBotoes = loc_oPagina.cnt_4c_Botoes
423:             WITH loc_oCntBotoes
424:                 .Left   = 720
425:                 .Width  = 165
426:                 .Height = 85
427: 
428:                 .AddObject("cmd_4c_Conferencia", "CommandButton")
429:                 WITH .cmd_4c_Conferencia
430:                     .Top             = 5
431:                     .Left            = 5
432:                     .Width           = 75
433:                     .Height          = 75
434:                     .FontBold        = .T.
435:                     .FontItalic      = .T.
436:                     .FontName        = "Comic Sans MS"
437:                     .FontSize        = 8
438:                     .ForeColor       = RGB(90, 90, 90)
439:                     .BackColor       = RGB(255, 255, 255)
440:                     .Caption         = "Conf. Auto"
441:                     .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
442:                     .Themes          = .F.
443:                     .SpecialEffect   = 0
444:                     .PicturePosition = 13
445:                     .MousePointer    = 15
446:                     .WordWrap        = .T.
447:                     .AutoSize        = .F.
448:                     .Visible         = .F.
449:                 ENDWITH
450: 
451:                 .AddObject("cmd_4c_Ok", "CommandButton")
452:                 WITH .cmd_4c_Ok
453:                     .Top             = 5
454:                     .Left            = 85
455:                     .Width           = 75

*-- Linhas 645 a 1088:
645:                 .Column5.Header1.Alignment = 2
646:             ENDWITH
647: 
648:             *-- BINDEVENTs (metodos PUBLIC por default em DEFINE CLASS)
649:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia, "Click", THIS, "CmdConferenciaClick")
650:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
651:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
652:             BINDEVENT(loc_oPagina.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
653: 
654:         CATCH TO loc_oErro
655:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
656:         ENDTRY
657:     ENDPROC
658: 
659:     *--------------------------------------------------------------------------
660:     * AlternarPagina - Alterna a pagina ativa do PageFrame
661:     *--------------------------------------------------------------------------
662:     PROCEDURE AlternarPagina(par_nPagina)
663:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
664:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
665:         ENDIF
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * AtualizarGrade - Atualiza visibilidade dos controles conforme registros em
670:     * cursor_4c_TmpBaixa (equivalente ao bloco final do legado carregabars)
671:     *--------------------------------------------------------------------------
672:     PROCEDURE AtualizarGrade()
673:         LOCAL loc_lTemDados, loc_oPagina, loc_oErro
674: 
675:         TRY
676:             IF !USED("cursor_4c_TmpBaixa")
677:                 RETURN
678:             ENDIF
679: 
680:             SELECT cursor_4c_TmpBaixa
681:             GO TOP
682:             loc_lTemDados = !EOF()
683: 
684:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
685: 
686:             loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
687:             loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
688:             loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
689:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
690:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
691: 
692:             IF loc_lTemDados
693:                 loc_oPagina.grd_4c_Dados.Refresh()
694:                 loc_oPagina.txt_4c_Leitura.SetFocus()
695:             ELSE
696:                 MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
697:                          CHR(231) + CHR(227) + "o!!!", "Aviso")
698:             ENDIF
699: 
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "Erro AtualizarGrade")
702:         ENDTRY
703:     ENDPROC
704: 
705:     *--------------------------------------------------------------------------
706:     * CmdConferenciaClick - Conf. Auto: marca todas etiquetas como lidas e
707:     * atualiza grid (equivalente ao legado Conferencia.Click)
708:     *--------------------------------------------------------------------------
709:     PROCEDURE CmdConferenciaClick()
710:         LOCAL loc_oErro
711: 
712:         TRY
713:             THIS.this_oBusinessObject.MarcarTodasLidas()
714:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
715:         CATCH TO loc_oErro
716:             MsgErro(loc_oErro.Message, "Erro CmdConferenciaClick")
717:         ENDTRY
718:     ENDPROC
719: 
720:     *--------------------------------------------------------------------------
721:     * CmdOkClick - Confirma conferencia, grava movimentacoes e encerra form
722:     * (equivalente ao legado Ok.Click)
723:     *--------------------------------------------------------------------------
724:     PROCEDURE CmdOkClick()
725:         LOCAL loc_lSucesso, loc_oErro
726: 
727:         TRY
728:             IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
729:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
730:                 RETURN
731:             ENDIF
732: 
733:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarConferencia()
734: 
735:             IF loc_lSucesso
736:                 IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
737:                     THIS.this_oFormPai.Enabled = .T.
738:                 ENDIF
739:                 THIS.Release()
740:             ENDIF
741: 
742:         CATCH TO loc_oErro
743:             MsgErro(loc_oErro.Message, "Erro CmdOkClick")
744:         ENDTRY
745:     ENDPROC
746: 
747:     *--------------------------------------------------------------------------
748:     * CmdSairClick - Habilita form pai e fecha este form
749:     * (equivalente ao legado Sair.Click)
750:     *--------------------------------------------------------------------------
751:     PROCEDURE CmdSairClick()
752:         IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
753:             THIS.this_oFormPai.Enabled = .T.
754:         ENDIF
755:         THIS.Release()
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * ConfigurarPaginaDados - Configura Page2 do PageFrame
760:     * Este form OPERACIONAL nao possui controles interativos em Page2.
761:     * O layout completo (campo Data, grid, leitura de codigo) esta em Page1.
762:     * Page2 recebe apenas a imagem de fundo para consistencia visual do sistema.
763:     *--------------------------------------------------------------------------
764:     PROTECTED PROCEDURE ConfigurarPaginaDados()
765:         LOCAL loc_oPagina, loc_oErro
766: 
767:         TRY
768:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
769:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
770:         CATCH TO loc_oErro
771:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
772:         ENDTRY
773:     ENDPROC
774: 
775:     *--------------------------------------------------------------------------
776:     * TxtLeituraKeyPress - Processa leitura de codigo de barras
777:     * Simula Valid do legado via KeyPress (ENTER=13 ou TAB=9)
778:     * BINDEVENT "Valid" nao funciona em TextBox no VFP9
779:     *--------------------------------------------------------------------------
780:     PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
781:         LOCAL loc_oTxt, loc_oGrd, loc_cCodBarra, loc_oErro
782: 
783:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
784:             RETURN
785:         ENDIF
786: 
787:         TRY
788:             loc_oTxt      = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
789:             loc_oGrd      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
790:             loc_cCodBarra = ALLTRIM(TRANSFORM(loc_oTxt.Value))
791: 
792:             IF !EMPTY(loc_cCodBarra) AND loc_cCodBarra <> "0"
793:                 THIS.this_oBusinessObject.RegistrarLeitura(loc_cCodBarra)
794: 
795:                 *-- Posicionar cursor no registro lido para atualizar highlighting
796:                 IF USED("cursor_4c_TmpBaixa")
797:                     SELECT cursor_4c_TmpBaixa
798:                     SET ORDER TO TAG CodBarra
799:                     SEEK loc_cCodBarra
800:                 ENDIF
801:             ENDIF
802: 
803:             loc_oTxt.Value = 0
804:             loc_oGrd.Refresh()
805:             loc_oTxt.SetFocus()
806: 
807:         CATCH TO loc_oErro
808:             MsgErro(loc_oErro.Message, "Erro TxtLeituraKeyPress")
809:         ENDTRY
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * BtnIncluirClick - Inicia nova leitura de codigo de barras
814:     * Form OPERACIONAL: "Incluir" = adicionar nova leitura (foco no reader)
815:     *--------------------------------------------------------------------------
816:     PROCEDURE BtnIncluirClick()
817:         LOCAL loc_oTxt, loc_oErro
818: 
819:         TRY
820:             loc_oTxt = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
821:             loc_oTxt.Value = 0
822:             loc_oTxt.SetFocus()
823:         CATCH TO loc_oErro
824:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
825:         ENDTRY
826:     ENDPROC
827: 
828:     *--------------------------------------------------------------------------
829:     * BtnAlterarClick - Marca todas etiquetas como conferidas (Conf. Auto)
830:     * Form OPERACIONAL: "Alterar" = alterar estado de todas para conferido
831:     *--------------------------------------------------------------------------
832:     PROCEDURE BtnAlterarClick()
833:         LOCAL loc_oErro
834: 
835:         TRY
836:             IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
837:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para conferir.", "Aviso")
838:                 RETURN
839:             ENDIF
840: 
841:             THIS.this_oBusinessObject.MarcarTodasLidas()
842:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
843:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
844:         CATCH TO loc_oErro
845:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
846:         ENDTRY
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * BtnVisualizarClick - Atualiza visualizacao da grade
851:     * Form OPERACIONAL: "Visualizar" = refresh grade e reposicionar
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnVisualizarClick()
854:         LOCAL loc_oGrd, loc_oErro
855: 
856:         TRY
857:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
858: 
859:             IF USED("cursor_4c_TmpBaixa")
860:                 SELECT cursor_4c_TmpBaixa
861:                 GO TOP
862:             ENDIF
863: 
864:             loc_oGrd.Refresh()
865:             loc_oGrd.SetFocus()
866:         CATCH TO loc_oErro
867:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * BtnExcluirClick - Limpa leituras da etiqueta corrente do grid
873:     * Form OPERACIONAL: "Excluir" = zerar QtdeLido do registro corrente
874:     *--------------------------------------------------------------------------
875:     PROCEDURE BtnExcluirClick()
876:         LOCAL loc_oErro
877: 
878:         TRY
879:             IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
880:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para excluir leitura.", "Aviso")
881:                 RETURN
882:             ENDIF
883: 
884:             SELECT cursor_4c_TmpBaixa
885: 
886:             IF EOF() OR BOF()
887:                 MsgAviso("Selecione uma etiqueta na grade para excluir a leitura.", "Aviso")
888:                 RETURN
889:             ENDIF
890: 
891:             IF NVL(cursor_4c_TmpBaixa.QtdeLido, 0) = 0
892:                 MsgAviso("Esta etiqueta ainda n" + CHR(227) + "o foi lida.", "Aviso")
893:                 RETURN
894:             ENDIF
895: 
896:             IF !MsgConfirma("Confirma limpar a leitura desta etiqueta?", "Confirmar")
897:                 RETURN
898:             ENDIF
899: 
900:             REPLACE QtdeLido WITH 0 IN cursor_4c_TmpBaixa
901: 
902:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
903:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
904:         CATCH TO loc_oErro
905:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
906:         ENDTRY
907:     ENDPROC
908: 
909:     *--------------------------------------------------------------------------
910:     * BtnBuscarClick - Recarrega etiquetas (refresh completo das baixas)
911:     * Form OPERACIONAL: "Buscar" = reprocessar etiquetas do cursor_4c_TmpEnc
912:     *--------------------------------------------------------------------------
913:     PROCEDURE BtnBuscarClick()
914:         LOCAL loc_oErro
915: 
916:         TRY
917:             THIS.CarregarBaixas()
918:         CATCH TO loc_oErro
919:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * BtnEncerrarClick - Habilita form pai e fecha este form
925:     * Form OPERACIONAL: equivalente ao botao Encerrar/Sair
926:     *--------------------------------------------------------------------------
927:     PROCEDURE BtnEncerrarClick()
928:         THIS.CmdSairClick()
929:     ENDPROC
930: 
931:     *--------------------------------------------------------------------------
932:     * BtnSalvarClick - Confirma a conferencia das etiquetas e fecha form
933:     * Form OPERACIONAL: equivalente ao botao Ok
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnSalvarClick()
936:         THIS.CmdOkClick()
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * BtnCancelarClick - Cancela leitura atual (limpa campo de codigo de barras)
941:     * Form OPERACIONAL: "Cancelar" = reiniciar leitura sem perder dados da grade
942:     *--------------------------------------------------------------------------
943:     PROCEDURE BtnCancelarClick()
944:         LOCAL loc_oErro
945: 
946:         TRY
947:             THIS.LimparCampos()
948:         CATCH TO loc_oErro
949:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
950:         ENDTRY
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * FormParaBO - Transfere valores atuais do form para o BO
955:     * Form OPERACIONAL: sincroniza data e propaga parametros de configuracao
956:     *--------------------------------------------------------------------------
957:     PROCEDURE FormParaBO()
958:         LOCAL loc_oErro
959: 
960:         TRY
961:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
962:                 RETURN
963:             ENDIF
964: 
965:             *-- Capturar data atual do campo (pode ter sido alterada pelo pai)
966:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
967:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
968:                     THIS.this_dData = THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value
969:                 ENDIF
970:             ENDIF
971: 
972:             *-- Propagar todos os parametros de configuracao para o BO
973:             THIS.PropagararParametrosBO()
974: 
975:         CATCH TO loc_oErro
976:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     * BOParaForm - Transfere valores do BO para os controles do form
982:     * Form OPERACIONAL: atualiza campo de data com valor do BO
983:     *--------------------------------------------------------------------------
984:     PROCEDURE BOParaForm()
985:         LOCAL loc_oErro
986: 
987:         TRY
988:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
989:                 RETURN
990:             ENDIF
991: 
992:             *-- Sincronizar campo de data com valor do BO
993:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
994:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
995:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
996:                 ENDIF
997:             ENDIF
998: 
999:         CATCH TO loc_oErro
1000:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
1001:         ENDTRY
1002:     ENDPROC
1003: 
1004:     *--------------------------------------------------------------------------
1005:     * HabilitarCampos - Habilita/desabilita controles conforme presenca de dados
1006:     * Form OPERACIONAL: campo de leitura e botoes Ok/Conf.Auto ativam so com dados
1007:     *--------------------------------------------------------------------------
1008:     PROCEDURE HabilitarCampos()
1009:         LOCAL loc_lTemDados, loc_oPagina, loc_oErro
1010: 
1011:         TRY
1012:             loc_lTemDados = USED("cursor_4c_TmpBaixa") AND RECCOUNT("cursor_4c_TmpBaixa") > 0
1013: 
1014:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1015:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1016: 
1017:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
1018:                     loc_oPagina.txt_4c_Leitura.Enabled  = loc_lTemDados
1019:                     loc_oPagina.txt_4c_Leitura.Visible  = loc_lTemDados
1020:                 ENDIF
1021: 
1022:                 IF PEMSTATUS(loc_oPagina, "lbl_4c_Txt_Leitura", 5)
1023:                     loc_oPagina.lbl_4c_Txt_Leitura.Visible = loc_lTemDados
1024:                 ENDIF
1025: 
1026:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1027:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Ok", 5)
1028:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible = loc_lTemDados
1029:                     ENDIF
1030:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Conferencia", 5)
1031:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
1032:                     ENDIF
1033:                 ENDIF
1034: 
1035:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1036:                     loc_oPagina.grd_4c_Dados.Visible = loc_lTemDados
1037:                     IF loc_lTemDados
1038:                         loc_oPagina.grd_4c_Dados.Refresh()
1039:                     ENDIF
1040:                 ENDIF
1041:             ENDIF
1042: 
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1045:         ENDTRY
1046:     ENDPROC
1047: 
1048:     *--------------------------------------------------------------------------
1049:     * LimparCampos - Limpa campo de leitura de codigo de barras
1050:     * Form OPERACIONAL: reinicia leitura sem alterar dados da grade
1051:     *--------------------------------------------------------------------------
1052:     PROCEDURE LimparCampos()
1053:         LOCAL loc_oPagina, loc_oErro
1054: 
1055:         TRY
1056:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
1057:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1058: 
1059:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
1060:                     loc_oPagina.txt_4c_Leitura.Value = 0
1061:                     IF loc_oPagina.txt_4c_Leitura.Visible
1062:                         loc_oPagina.txt_4c_Leitura.SetFocus()
1063:                     ENDIF
1064:                 ENDIF
1065:             ENDIF
1066: 
1067:         CATCH TO loc_oErro
1068:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
1069:         ENDTRY
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     * CarregarLista - Wrapper sobre CarregarBaixas para conformidade com FormBase
1074:     * Form OPERACIONAL: reprocessa etiquetas do cursor_4c_TmpEnc
1075:     *--------------------------------------------------------------------------
1076:     PROCEDURE CarregarLista()
1077:         RETURN THIS.CarregarBaixas()
1078:     ENDPROC
1079: 
1080:     *--------------------------------------------------------------------------
1081:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme estado dos dados
1082:     * Form OPERACIONAL: delega para AtualizarGrade que gerencia visibilidade
1083:     *--------------------------------------------------------------------------
1084:     PROCEDURE AjustarBotoesPorModo()
1085:         THIS.AtualizarGrade()
1086:     ENDPROC
1087: 
1088: ENDDEFINE


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
        LOCAL loc_nTipoEstos, loc_cEmpDopNumsCit

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

                                *-- Verificar tipo de estoque pelo grupo do produto
                                loc_nTipoEstos = 1
                                loc_cSQL = "SELECT p.CGrus FROM SigCdPro p WHERE p.CPros = " + EscaparSQL(loc_cCPros)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProBx") > 0
                                    SELECT cursor_4c_SigCdProBx
                                    IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        loc_cSQL = "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
                                                   EscaparSQL(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdGrpBx") > 0
                                            SELECT cursor_4c_SigCdGrpBx
                                            IF !EOF()
                                                loc_nTipoEstos = NVL(cursor_4c_SigCdGrpBx.TipoEstos, 1)
                                                IF !INLIST(loc_nTipoEstos, 2, 3, 4)
                                                    loc_nTipoEstos = 1
                                                ENDIF
                                            ENDIF
                                            IF USED("cursor_4c_SigCdGrpBx")
                                                USE IN cursor_4c_SigCdGrpBx
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdProBx")
                                        USE IN cursor_4c_SigCdProBx
                                    ENDIF
                                ENDIF

                                *-- Override grupo/conta pelo cliente destino
                                loc_cSQL = "SELECT GruProds, ConProds FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cTConta)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCliBx") > 0
                                    SELECT cursor_4c_SigCdCliBx
                                    IF !EOF()
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.GruProds))
                                            loc_cGrupo = ALLTRIM(cursor_4c_SigCdCliBx.GruProds)
                                        ENDIF
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.ConProds))
                                            loc_cConta = ALLTRIM(cursor_4c_SigCdCliBx.ConProds)
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdCliBx")
                                        USE IN cursor_4c_SigCdCliBx
                                    ENDIF
                                ENDIF

                                *-- Processar operacao de citacao (DopeCit) se configurada
                                IF !EMPTY(loc_cDopeCit)
                                    loc_cEmpDopNumsCit = loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)
                                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCit") > 0
                                        SELECT cursor_4c_ChkCit
                                        IF !EOF() AND NVL(cursor_4c_ChkCit.nExiste, 0) > 0
                                            loc_nBaixa = loc_nQtEti

                                            IF loc_nTipoEstos = 1
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
                                            ELSE
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
                           "WHERE Emps + Dopes = " + EscaparSQL(loc_cPref)
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

