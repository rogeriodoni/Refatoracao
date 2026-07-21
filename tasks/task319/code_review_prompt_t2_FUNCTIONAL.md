# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'optArquivo' (parent: SIGPRPDF): Left original=420 vs migrado 'obj_4c_OptArquivo' Left=5 (diff=415px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1068 linhas total):

*-- Linhas 2 a 168:
2: * Formsigprpdf.prg - Dialogo: Geracao de PDF e E-mail
3: * Equivalente ao SIGPRPDF.SCX do legado
4: * Tipo: OPERACIONAL (dialogo modal auxiliar - chamado por forms de impressao)
5: * Uso: loForm = CREATEOBJECT("Formsigprpdf", oFormPai, cAssunto)
6: *      loForm.Show()
7: * Resultado: oFormPai.pcArqEmail = caminho do arquivo gerado
8: *            oFormPai.oEmail     = objeto CUSTOM com dados do email (se email selecionado)
9: *==============================================================================
10: DEFINE CLASS Formsigprpdf AS FormBase
11: 
12:     *-- Referencia ao form pai (passada via Init)
13:     this_oParentForm = .NULL.
14: 
15:     *-- Assunto inicial do email (passado via Init)
16:     this_cAssunto = ""
17: 
18:     *-- Diretorio fiscal para salvar arquivos (de go_4c_Sistema.DirFiscais)
19:     this_cDiretorio = ""
20: 
21:     *-- Altura base do form sem a secao de email expandida
22:     this_nAlturaBase = 175
23: 
24:     *-- Propriedades visuais (PILAR 1: identico ao legado SIGPRPDF.SCX)
25:     Width       = 800
26:     Height      = 360
27:     AutoCenter  = .T.
28:     BorderStyle = 2
29:     ShowWindow = 1
30:     ControlBox  = .F.
31:     MaxButton   = .F.
32:     MinButton   = .F.
33:     TitleBar    = 0
34:     WindowType  = 1
35:     Caption     = "Geracao de PDF e E-mail"
36: 
37:     *--------------------------------------------------------------------------
38:     * Init - Recebe referencia ao form pai e assunto do email
39:     * Parametros armazenados ANTES de DODEFAULT (que chama InicializarForm)
40:     *--------------------------------------------------------------------------
41:     PROCEDURE Init(par_oParentForm, par_cAssunto)
42:         THIS.this_oParentForm = par_oParentForm
43:         THIS.this_cAssunto    = IIF(TYPE("par_cAssunto") = "C", par_cAssunto, "")
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Conecta datasession, cria todos os controles
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lSucesso, loc_oErro
52: 
53:         loc_lSucesso = .F.
54: 
55:         TRY
56:             *-- Compartilhar datasession com form pai (exige acesso aos cursores dele)
57:             IF VARTYPE(THIS.this_oParentForm) = "O"
58:                 SET DATASESSION TO THIS.this_oParentForm.DataSessionId
59:             ENDIF
60: 
61:             *-- Instanciar BO
62:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")
63:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
64:                 *-- Diretorio fiscal
65:                 IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
66:                     THIS.this_cDiretorio = ALLTRIM(NVL(go_4c_Sistema.DirFiscais, ""))
67:                 ENDIF
68:                 THIS.this_oBusinessObject.this_cDiretorio = THIS.this_cDiretorio
69: 
70:                 *-- Aparencia base do form
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 *-- Criar controles do form
74:                 THIS.ConfigurarCabecalho()
75:                 THIS.ConfigurarOpcaoArquivo()
76:                 THIS.ConfigurarAreaArquivo()
77:                 THIS.ConfigurarBotoesAcao()
78:                 THIS.ConfigurarSecaoEmail()
79: 
80:                 *-- Carregar dados de email da empresa via BO
81:                 THIS.this_oBusinessObject.CarregarEmailEmpresa()
82: 
83:                 *-- Preencher valores iniciais nos controles
84:                 THIS.InicializarValores()
85: 
86:                 *-- Tornar controles visiveis (email section permanece oculta)
87:                 THIS.TornarControlesVisiveis(THIS)
88: 
89:                 *-- Bindar eventos dos botoes e controles
90:                 BINDEVENT(THIS.cmd_4c_CmdGetFile,    "Click", THIS, "CmdGetFileClick")
91:                 BINDEVENT(THIS.chk_4c_Chk_EMAIL,     "Click", THIS, "ChkEmailClick")
92:                 BINDEVENT(THIS.obj_4c_OptArquivo,    "Click", THIS, "OptArquivoClick")
93:                 BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF,  "Click", THIS, "CmdGerarPDFClick")
94:                 BINDEVENT(THIS.cmd_4c_Cmd_SAIR,      "Click", THIS, "CmdSairClick")
95:                 BINDEVENT(THIS.cmd_4c_BtnPastasA,    "Click", THIS, "BtnPastasAClick")
96: 
97:                 loc_lSucesso = .T.
98:             ELSE
99:                 MsgErro("Falha ao criar sigprpdfBO.", "Erro")
100:             ENDIF
101: 
102:         CATCH TO loc_oErro
103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
104:                 " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
105:             loc_lSucesso = .F.
106:         ENDTRY
107: 
108:         RETURN loc_lSucesso
109:     ENDPROC
110: 
111:     *--------------------------------------------------------------------------
112:     * ConfigurarPageFrame - Aparencia base do form (sem PageFrame - dialogo plano)
113:     *--------------------------------------------------------------------------
114:     PROTECTED PROCEDURE ConfigurarPageFrame()
115:         THIS.FontName   = "Tahoma"
116:         THIS.FontSize   = 8
117:         THIS.ShowTips   = .T.
118:         THIS.Caption    = "Gera" + CHR(231) + CHR(227) + "o de PDF e E-mail"
119: 
120:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
121:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
122:         ENDIF
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     * ConfigurarCabecalho - Container escuro com titulo do dialogo
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE ConfigurarCabecalho()
129:         LOCAL loc_oCab, loc_oErro
130: 
131:         TRY
132:             THIS.AddObject("cnt_4c_Sombra", "Container")
133:             WITH THIS.cnt_4c_Sombra
134:                 .Top        = 0
135:                 .Left       = 0
136:                 .Width      = 1100
137:                 .Height     = 80
138:                 .BorderWidth = 0
139:                 .BackStyle  = 1
140:                 .BackColor  = RGB(100, 100, 100)
141:                 .Visible    = .T.
142:             ENDWITH
143: 
144:             loc_oCab = THIS.cnt_4c_Sombra
145: 
146:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
147:             WITH loc_oCab.lbl_4c_LblSombra
148:                 .Top       = 18
149:                 .Left      = 10
150:                 .Width     = 769
151:                 .Height    = 40
152:                 .AutoSize  = .F.
153:                 .FontBold  = .T.
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 18
156:                 .BackStyle = 0
157:                 .ForeColor = RGB(0, 0, 0)
158:                 .WordWrap  = .T.
159:                 .Alignment = 0
160:                 .Caption   = THIS.Caption
161:                 .Visible   = .T.
162:             ENDWITH
163: 
164:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
165:             WITH loc_oCab.lbl_4c_LblTitulo
166:                 .Top       = 17
167:                 .Left      = 10
168:                 .Width     = 769

*-- Linhas 185 a 234:
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     * ConfigurarOpcaoArquivo - OptionGroup PDF / Excel
189:     *--------------------------------------------------------------------------
190:     PROTECTED PROCEDURE ConfigurarOpcaoArquivo()
191:         LOCAL loc_oErro
192: 
193:         TRY
194:             THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
195:             WITH THIS.obj_4c_OptArquivo
196:                 .Top         = -2
197:                 .Left        = 420
198:                 .Width       = 161
199:                 .Height      = 85
200:                 .TabIndex    = 1
201:                 .Themes      = .T.
202:                 .ButtonCount = 2
203:                 .Value       = 1
204:                 .Visible     = .T.
205: 
206:                 WITH .Buttons(1)
207:                     .Caption    = "PDF"
208:                     .Height     = 75
209:                     .Left       = 5
210:                     .Top        = 5
211:                     .Width      = 75
212:                     .Style      = 1
213:                     .FontBold   = .T.
214:                     .FontItalic = .T.
215:                     .ForeColor  = RGB(90, 90, 90)
216:                     .BackColor  = RGB(255, 255, 255)
217:                     .BackStyle  = 0
218:                     .Picture    = gc_4c_CaminhoIcones + "pdf_60.png"
219:                 ENDWITH
220: 
221:                 WITH .Buttons(2)
222:                     .Caption    = "Excel"
223:                     .Height     = 75
224:                     .Left       = 81
225:                     .Top        = 5
226:                     .Width      = 75
227:                     .Style      = 1
228:                     .FontBold   = .T.
229:                     .FontItalic = .T.
230:                     .FontName   = "Tahoma"
231:                     .FontSize   = 8
232:                     .ForeColor  = RGB(90, 90, 90)
233:                     .BackColor  = RGB(255, 255, 255)
234:                     .BackStyle  = 0

*-- Linhas 244 a 287:
244:     *--------------------------------------------------------------------------
245:     * ConfigurarAreaArquivo - Label "Salvar em:", TextBox nome arquivo e botoes
246:     *--------------------------------------------------------------------------
247:     PROTECTED PROCEDURE ConfigurarAreaArquivo()
248:         LOCAL loc_oErro
249: 
250:         TRY
251:             THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
252:             WITH THIS.lbl_4c_Lbl_SalvarEm
253:                 .Top       = 109
254:                 .Left      = 150
255:                 .Width     = 53
256:                 .Height    = 15
257:                 .AutoSize  = .T.
258:                 .FontName  = "Tahoma"
259:                 .FontSize  = 8
260:                 .BackStyle = 0
261:                 .ForeColor = RGB(90, 90, 90)
262:                 .Caption   = "Salvar em:"
263:                 .TabIndex  = 4
264:                 .Visible   = .T.
265:             ENDWITH
266: 
267:             THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
268:             WITH THIS.txt_4c_TxtNomeArqSaida
269:                 .Top               = 105
270:                 .Left              = 205
271:                 .Width             = 383
272:                 .Height            = 23
273:                 .FontName          = "Tahoma"
274:                 .FontSize          = 8
275:                 .ReadOnly          = .T.
276:                 .SpecialEffect     = 1
277:                 .BorderColor       = RGB(100, 100, 100)
278:                 .DisabledBackColor = RGB(255, 255, 255)
279:                 .Value             = ""
280:                 .TabIndex          = 5
281:                 .Visible           = .T.
282:             ENDWITH
283: 
284:             THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
285:             WITH THIS.cmd_4c_CmdGetFile
286:                 .Top        = 104
287:                 .Left       = 589

*-- Linhas 328 a 371:
328:     *--------------------------------------------------------------------------
329:     * ConfigurarBotoesAcao - Checkbox Email, botao Gravar/Enviar e Encerrar
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
332:         LOCAL loc_oErro
333: 
334:         TRY
335:             THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
336:             WITH THIS.chk_4c_Chk_EMAIL
337:                 .Top        = 3
338:                 .Left       = 575
339:                 .Width      = 75
340:                 .Height     = 75
341:                 .FontBold   = .T.
342:                 .FontItalic = .T.
343:                 .FontName   = "Comic Sans MS"
344:                 .FontSize   = 8
345:                 .Caption    = "Email"
346:                 .Style      = 1
347:                 .Value      = 0
348:                 .Alignment  = 0
349:                 .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
350:                 .ForeColor  = RGB(90, 90, 90)
351:                 .BackColor  = RGB(255, 255, 255)
352:                 .Themes     = .F.
353:                 .TabIndex   = 2
354:                 .Visible    = .T.
355:             ENDWITH
356: 
357:             THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
358:             WITH THIS.cmd_4c_Cmd_GerarPDF
359:                 .Top             = 3
360:                 .Left            = 650
361:                 .Width           = 75
362:                 .Height          = 75
363:                 .FontBold        = .T.
364:                 .FontItalic      = .T.
365:                 .FontName        = "Comic Sans MS"
366:                 .FontSize        = 8
367:                 .Caption         = "   Gravar"
368:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
369:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
370:                 .PicturePosition = 13
371:                 .Alignment       = 6

*-- Linhas 407 a 450:
407:     *--------------------------------------------------------------------------
408:     * ConfigurarSecaoEmail - Container expandivel com campos de email (inicial: oculto)
409:     *--------------------------------------------------------------------------
410:     PROTECTED PROCEDURE ConfigurarSecaoEmail()
411:         LOCAL loc_oCtn, loc_oErro
412: 
413:         TRY
414:             THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
415:             WITH THIS.cnt_4c_CtnSaida_Email
416:                 .Top        = 148
417:                 .Left       = 155
418:                 .Width      = 480
419:                 .Height     = 185
420:                 .BackStyle  = 0
421:                 .BorderWidth = 0
422:                 .TabIndex   = 7
423:                 .Visible    = .F.
424:             ENDWITH
425: 
426:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
427: 
428:             loc_oCtn.AddObject("lbl_4c_Label1", "Label")
429:             WITH loc_oCtn.lbl_4c_Label1
430:                 .Top       = 8
431:                 .Left      = 47
432:                 .Width     = 19
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .FontName  = "Tahoma"
436:                 .FontSize  = 8
437:                 .BackStyle = 0
438:                 .ForeColor = RGB(90, 90, 90)
439:                 .Caption   = "De:"
440:                 .TabIndex  = 1
441:                 .Visible   = .T.
442:             ENDWITH
443: 
444:             loc_oCtn.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
445:             WITH loc_oCtn.txt_4c_TxtEmail_EnviarDE
446:                 .Top               = 5
447:                 .Left              = 68
448:                 .Width             = 404
449:                 .Height            = 23
450:                 .FontName          = "Tahoma"

*-- Linhas 593 a 636:
593:     *--------------------------------------------------------------------------
594:     * InicializarValores - Define valores iniciais apos criacao dos controles
595:     *--------------------------------------------------------------------------
596:     PROTECTED PROCEDURE InicializarValores()
597:         LOCAL loc_lPdfDisponivel, loc_cExt, loc_oErro
598: 
599:         TRY
600:             *-- Verificar disponibilidade do PDFCreator via registry
601:             loc_lPdfDisponivel = .F.
602:             TRY
603:                 loc_lPdfDisponivel = !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreator.clsPDFCreator\")) OR ;
604:                                      !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreatorBeta.JobQueue\"))
605:             CATCH
606:                 loc_lPdfDisponivel = .F.
607:             ENDTRY
608: 
609:             THIS.obj_4c_OptArquivo.Buttons(1).Enabled = loc_lPdfDisponivel
610:             THIS.obj_4c_OptArquivo.Value = IIF(loc_lPdfDisponivel, 1, 2)
611: 
612:             *-- Nome do arquivo inicial conforme tipo selecionado (igual ao OptArquivoClick)
613:             IF THIS.obj_4c_OptArquivo.Value = 1
614:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
615:             ELSE
616:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
617:             ENDIF
618: 
619:             *-- Preencher "Para:" com contaemail do form pai (se disponivel)
620:             IF VARTYPE(THIS.this_oParentForm) = "O"
621:                 IF PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
622:                     THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value = ;
623:                         ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
624:                 ENDIF
625:             ENDIF
626: 
627:             *-- Assunto inicial
628:             THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value = THIS.this_cAssunto
629: 
630:             *-- Email De (da empresa, carregado pelo BO)
631:             THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_EnviarDE.Value = ;
632:                 THIS.this_oBusinessObject.this_cEmailEmpresaDe
633: 
634:             *-- Calcular altura base e recolher secao de email
635:             THIS.this_nAlturaBase = THIS.Height - THIS.cnt_4c_CtnSaida_Email.Height
636:             THIS.Height = THIS.this_nAlturaBase

*-- Linhas 642 a 1068:
642:     ENDPROC
643: 
644:     *--------------------------------------------------------------------------
645:     * TornarControlesVisiveis - Torna visiveis todos os controles exceto secao email
646:     * cnt_4c_CtnSaida_Email inicia oculto; seus filhos ficam visiveis internamente
647:     *--------------------------------------------------------------------------
648:     PROCEDURE TornarControlesVisiveis(par_oContainer)
649:         LOCAL loc_i, loc_oCtrl
650: 
651:         FOR loc_i = 1 TO par_oContainer.ControlCount
652:             loc_oCtrl = par_oContainer.Controls(loc_i)
653: 
654:             IF VARTYPE(loc_oCtrl) = "O"
655:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CTNSAIDA_EMAIL", "CNT_4C_SOMBRA")
656:                     *-- Containers intencionalmente ocultos: recursao nos filhos sem forcar Visible=.T.
657:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
658:                         THIS.TornarControlesVisiveis(loc_oCtrl)
659:                     ENDIF
660:                     LOOP
661:                 ENDIF
662: 
663:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
664:                     loc_oCtrl.Visible = .T.
665:                 ENDIF
666: 
667:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
668:                     THIS.TornarControlesVisiveis(loc_oCtrl)
669:                 ENDIF
670:             ENDIF
671:         ENDFOR
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * CmdGetFileClick - Abre dialogo de selecao de arquivo PDF ou XLS
676:     *--------------------------------------------------------------------------
677:     PROCEDURE CmdGetFileClick()
678:         LOCAL loc_cTpArq, loc_cArqSaida, loc_oErro
679: 
680:         TRY
681:             loc_cTpArq    = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
682:             loc_cArqSaida = GETFILE(loc_cTpArq, "Arquivo:", "Selecionar", 0, "Selecione o arquivo")
683: 
684:             IF !EMPTY(loc_cArqSaida)
685:                 loc_cArqSaida = THIS.this_oBusinessObject.ResolverExtensao(loc_cArqSaida, THIS.obj_4c_OptArquivo.Value)
686:                 THIS.txt_4c_TxtNomeArqSaida.Value = ALLTRIM(loc_cArqSaida)
687:             ENDIF
688: 
689:         CATCH TO loc_oErro
690:             MsgErro(loc_oErro.Message, "Erro")
691:         ENDTRY
692:     ENDPROC
693: 
694:     *--------------------------------------------------------------------------
695:     * ChkEmailClick - Expande/contrai form mostrando/ocultando secao de email
696:     *--------------------------------------------------------------------------
697:     PROCEDURE ChkEmailClick()
698:         LOCAL loc_oErro
699: 
700:         TRY
701:             THIS.LockScreen = .T.
702: 
703:             IF THIS.chk_4c_Chk_EMAIL.Value = 1
704:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "Enviar Email"
705:                 THIS.Height = THIS.this_nAlturaBase + THIS.cnt_4c_CtnSaida_Email.Height
706:                 THIS.cnt_4c_CtnSaida_Email.Visible = .T.
707:             ELSE
708:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "\<Gravar"
709:                 THIS.Height = THIS.this_nAlturaBase
710:                 THIS.cnt_4c_CtnSaida_Email.Visible = .F.
711:             ENDIF
712: 
713:             THIS.Refresh()
714:             THIS.LockScreen = .F.
715: 
716:         CATCH TO loc_oErro
717:             THIS.LockScreen = .F.
718:             MsgErro(loc_oErro.Message, "Erro")
719:         ENDTRY
720:     ENDPROC
721: 
722:     *--------------------------------------------------------------------------
723:     * OptArquivoClick - Atualiza nome do arquivo conforme tipo PDF/XLS selecionado
724:     *--------------------------------------------------------------------------
725:     PROCEDURE OptArquivoClick()
726:         LOCAL loc_oErro
727: 
728:         TRY
729:             IF THIS.obj_4c_OptArquivo.Value = 1
730:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
731:             ELSE
732:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
733:             ENDIF
734: 
735:         CATCH TO loc_oErro
736:             MsgErro(loc_oErro.Message, "Erro")
737:         ENDTRY
738:     ENDPROC
739: 
740:     *--------------------------------------------------------------------------
741:     * CmdGerarPDFClick - Acao principal: gravar arquivo ou preparar envio de email
742:     *--------------------------------------------------------------------------
743:     PROCEDURE CmdGerarPDFClick()
744:         LOCAL loc_cArquivo, loc_oEmail, loc_lEnviarEmail, loc_lResultado, loc_lContinuar, loc_oErro
745: 
746:         loc_lContinuar = .T.
747: 
748:         TRY
749:             loc_cArquivo = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
750: 
751:             IF EMPTY(loc_cArquivo)
752:                 MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
753:                 THIS.cmd_4c_CmdGetFile.SetFocus()
754:                 loc_lContinuar = .F.
755:             ENDIF
756: 
757:             IF loc_lContinuar
758:                 loc_lEnviarEmail = (THIS.chk_4c_Chk_EMAIL.Value = 1)
759: 
760:                 IF loc_lEnviarEmail
761:                     *-- Modo email: coletar dados do form para o BO validar
762:                     THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
763:                     THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
764:                     THIS.this_oBusinessObject.this_cEmailPara    = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value, ""))
765:                     THIS.this_oBusinessObject.this_cEmailCC      = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_CC.Value,         ""))
766:                     THIS.this_oBusinessObject.this_cEmailAssunto = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value,    ""))
767:                     THIS.this_oBusinessObject.this_cEmailCorpo   = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_EdtEmail_Corpo.Value,      ""))
768: 
769:                     loc_lResultado = THIS.this_oBusinessObject.Atualizar()
770: 
771:                     IF loc_lResultado
772:                         *-- Dados de email da empresa precisam estar carregados (cursor_4c_EmailEmp)
773:                         IF USED("cursor_4c_EmailEmp") AND RECCOUNT("cursor_4c_EmailEmp") > 0
774:                             loc_oEmail = THIS.this_oBusinessObject.MontarObjetoEmail( ;
775:                                 THIS.this_oBusinessObject.this_cArquivoSaida)
776: 
777:                             IF VARTYPE(THIS.this_oParentForm) = "O" AND VARTYPE(loc_oEmail) = "O"
778:                                 THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
779:                                 THIS.this_oParentForm.oEmail     = loc_oEmail
780:                             ENDIF
781:                         ELSE
782:                             IF VARTYPE(THIS.this_oParentForm) = "O"
783:                                 THIS.this_oParentForm.lPrintPDFCreator = .F.
784:                             ENDIF
785:                             MsgAviso("Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. " + ;
786:                                      "Favor enviar novamente.", "Aten" + CHR(231) + CHR(227) + "o")
787:                         ENDIF
788: 
789:                         THIS.Release()
790:                     ENDIF
791:                 ELSE
792:                     *-- Modo gravar: apenas definir arquivo no form pai
793:                     THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
794:                     THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
795: 
796:                     loc_lResultado = THIS.this_oBusinessObject.Inserir()
797: 
798:                     IF loc_lResultado
799:                         IF VARTYPE(THIS.this_oParentForm) = "O"
800:                             THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
801:                         ENDIF
802:                         THIS.Release()
803:                     ENDIF
804:                 ENDIF
805:             ENDIF
806: 
807:         CATCH TO loc_oErro
808:             MsgErro(loc_oErro.Message, "Erro ao gravar/enviar")
809:         ENDTRY
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * CmdSairClick - Cancela: limpa pcArqEmail e oEmail no form pai e fecha
814:     *--------------------------------------------------------------------------
815:     PROCEDURE CmdSairClick()
816:         LOCAL loc_oErro
817: 
818:         TRY
819:             IF VARTYPE(THIS.this_oParentForm) = "O"
820:                 THIS.this_oParentForm.pcArqEmail = ""
821:                 THIS.this_oParentForm.oEmail     = .NULL.
822:             ENDIF
823:             THIS.Release()
824: 
825:         CATCH TO loc_oErro
826:             MsgErro(loc_oErro.Message, "Erro")
827:         ENDTRY
828:     ENDPROC
829: 
830:     *--------------------------------------------------------------------------
831:     * BtnPastasAClick - Abre diretorio fiscal no Windows Explorer
832:     *--------------------------------------------------------------------------
833:     PROCEDURE BtnPastasAClick()
834:         LOCAL loc_oErro
835: 
836:         TRY
837:             THIS.this_oBusinessObject.AbrirPasta(THIS.this_cDiretorio)
838: 
839:         CATCH TO loc_oErro
840:             MsgErro(loc_oErro.Message, "Erro")
841:         ENDTRY
842:     ENDPROC
843: 
844:     *--------------------------------------------------------------------------
845:     * ConfigurarPaginaLista - N/A (dialogo plano sem PageFrame/Grid)
846:     * Formsigprpdf eh um dialogo modal de 1 tela - sem Page1/Grid de lista.
847:     *--------------------------------------------------------------------------
848:     PROTECTED PROCEDURE ConfigurarPaginaLista()
849:         RETURN
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * ConfigurarPaginaDados - N/A (dialogo plano sem Page2)
854:     * Todos os controles sao criados diretamente em InicializarForm.
855:     *--------------------------------------------------------------------------
856:     PROTECTED PROCEDURE ConfigurarPaginaDados()
857:         RETURN
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * AlternarPagina - N/A (dialogo plano sem paginas para alternar)
862:     *--------------------------------------------------------------------------
863:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
864:         RETURN
865:     ENDPROC
866: 
867:     *--------------------------------------------------------------------------
868:     * BtnIncluirClick - N/A para dialogo OPERACIONAL de PDF/Email
869:     * Este form nao eh um cadastro CRUD (SIGPRPDF.SCX legado nao tem esse botao).
870:     * A acao equivalente de "gravar arquivo novo" eh feita por CmdGerarPDFClick,
871:     * que chama this_oBusinessObject.Inserir para persistir os dados de saida.
872:     *--------------------------------------------------------------------------
873:     PROCEDURE BtnIncluirClick()
874:         THIS.CmdGerarPDFClick()
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * BtnAlterarClick - N/A para dialogo OPERACIONAL de PDF/Email
879:     * SIGPRPDF.SCX legado nao possui operacao de alteracao (dialogo one-shot).
880:     * A acao equivalente de "reenviar/regravar" eh feita por CmdGerarPDFClick,
881:     * que decide entre Inserir (gravar) e Atualizar (enviar email).
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnAlterarClick()
884:         THIS.CmdGerarPDFClick()
885:     ENDPROC
886: 
887:     *--------------------------------------------------------------------------
888:     * BtnVisualizarClick - N/A para dialogo OPERACIONAL de PDF/Email
889:     * SIGPRPDF.SCX legado nao possui operacao de visualizacao (nao ha registros
890:     * persistidos). A acao equivalente de "ver a pasta destino" eh BtnPastasAClick,
891:     * que abre o diretorio fiscal onde os PDFs/XLS sao salvos.
892:     *--------------------------------------------------------------------------
893:     PROCEDURE BtnVisualizarClick()
894:         THIS.BtnPastasAClick()
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * BtnExcluirClick - N/A para dialogo OPERACIONAL de PDF/Email
899:     * SIGPRPDF.SCX legado nao possui operacao de exclusao (dialogo modal one-shot).
900:     * A acao equivalente de "cancelar/descartar" eh CmdSairClick, que limpa
901:     * pcArqEmail/oEmail no form pai e fecha o dialogo sem gravar.
902:     *--------------------------------------------------------------------------
903:     PROCEDURE BtnExcluirClick()
904:         THIS.CmdSairClick()
905:     ENDPROC
906: 
907:     *--------------------------------------------------------------------------
908:     * BtnSalvarClick - Delega para a acao principal do dialogo (Gravar/Enviar).
909:     * SIGPRPDF.SCX legado usa Cmd_GerarPDF (nao ha botao "Salvar" separado).
910:     * Mantido para compatibilidade com a interface CRUD do pipeline.
911:     *--------------------------------------------------------------------------
912:     PROCEDURE BtnSalvarClick()
913:         THIS.CmdGerarPDFClick()
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * BtnCancelarClick - Delega para o cancelamento do dialogo (Cmd_SAIR).
918:     * SIGPRPDF.SCX legado nao tem botao "Cancelar" separado; sair equivale a
919:     * cancelar (limpa pcArqEmail/oEmail do form pai).
920:     *--------------------------------------------------------------------------
921:     PROCEDURE BtnCancelarClick()
922:         THIS.CmdSairClick()
923:     ENDPROC
924: 
925:     *--------------------------------------------------------------------------
926:     * FormParaBO - Copia valores dos controles do form para as propriedades do BO.
927:     * Chamado antes de invocar Inserir/Atualizar no BO (via CmdGerarPDFClick).
928:     *--------------------------------------------------------------------------
929:     PROTECTED PROCEDURE FormParaBO()
930:         LOCAL loc_oCtn, loc_oErro
931: 
932:         TRY
933:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
934:                 RETURN
935:             ENDIF
936: 
937:             THIS.this_oBusinessObject.this_cDiretorio    = THIS.this_cDiretorio
938:             THIS.this_oBusinessObject.this_cArquivoSaida = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
939:             THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
940:             THIS.this_oBusinessObject.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)
941: 
942:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
943:             THIS.this_oBusinessObject.this_cEmailEmpresaDe = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value, ""))
944:             THIS.this_oBusinessObject.this_cEmailPara      = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value, ""))
945:             THIS.this_oBusinessObject.this_cEmailCC        = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_CC.Value, ""))
946:             THIS.this_oBusinessObject.this_cEmailAssunto   = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_Assunto.Value, ""))
947:             THIS.this_oBusinessObject.this_cEmailCorpo     = ALLTRIM(NVL(loc_oCtn.obj_4c_EdtEmail_Corpo.Value, ""))
948: 
949:         CATCH TO loc_oErro
950:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
951:         ENDTRY
952:     ENDPROC
953: 
954:     *--------------------------------------------------------------------------
955:     * BOParaForm - Copia propriedades do BO para os controles do form.
956:     * Chamado apos CarregarEmailEmpresa para propagar dados da empresa.
957:     *--------------------------------------------------------------------------
958:     PROTECTED PROCEDURE BOParaForm()
959:         LOCAL loc_oCtn, loc_oErro
960: 
961:         TRY
962:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
963:                 RETURN
964:             ENDIF
965: 
966:             THIS.this_cDiretorio = THIS.this_oBusinessObject.this_cDiretorio
967: 
968:             IF THIS.obj_4c_OptArquivo.Value = 1
969:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
970:             ELSE
971:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
972:             ENDIF
973: 
974:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
975:             loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value = THIS.this_oBusinessObject.this_cEmailEmpresaDe
976:             loc_oCtn.txt_4c_TxtEmail_Assunto.Value  = THIS.this_cAssunto
977: 
978:             IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
979:                 loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
980:             ENDIF
981: 
982:         CATCH TO loc_oErro
983:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
984:         ENDTRY
985:     ENDPROC
986: 
987:     *--------------------------------------------------------------------------
988:     * CarregarLista - N/A para dialogo OPERACIONAL de PDF/Email (sem grid).
989:     * SIGPRPDF.SCX legado eh um dialogo modal one-shot sem lista de registros.
990:     * A acao equivalente de "carregar dados iniciais" eh CarregarEmailEmpresa
991:     * no BO, que popula as configuracoes de email da empresa em SigCdEmp.
992:     *--------------------------------------------------------------------------
993:     PROCEDURE CarregarLista()
994:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
995:             THIS.this_oBusinessObject.CarregarEmailEmpresa()
996:             THIS.BOParaForm()
997:         ENDIF
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     * HabilitarCampos - Ajusta enabled dos controles conforme o modo do dialogo.
1002:     * par_lHabilitar: .T. habilita edicao, .F. bloqueia (durante processamento).
1003:     *--------------------------------------------------------------------------
1004:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1005:         LOCAL loc_lEnabled, loc_oCtn
1006: 
1007:         loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1008: 
1009:         THIS.obj_4c_OptArquivo.Enabled     = loc_lEnabled
1010:         THIS.cmd_4c_CmdGetFile.Enabled     = loc_lEnabled
1011:         THIS.chk_4c_Chk_EMAIL.Enabled      = loc_lEnabled
1012:         THIS.cmd_4c_Cmd_GerarPDF.Enabled   = loc_lEnabled
1013:         THIS.cmd_4c_BtnPastasA.Enabled     = loc_lEnabled
1014: 
1015:         loc_oCtn = THIS.cnt_4c_CtnSaida_Email
1016:         loc_oCtn.obj_4c_TxtEmail_EnviarPara.Enabled = loc_lEnabled
1017:         loc_oCtn.obj_4c_TxtEmail_CC.Enabled         = loc_lEnabled
1018:         loc_oCtn.txt_4c_TxtEmail_Assunto.Enabled    = loc_lEnabled
1019:         loc_oCtn.obj_4c_EdtEmail_Corpo.Enabled      = loc_lEnabled
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * LimparCampos - Reseta valores dos controles editaveis do form.
1024:     *--------------------------------------------------------------------------
1025:     PROTECTED PROCEDURE LimparCampos()
1026:         LOCAL loc_oCtn
1027: 
1028:         THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
1029:         THIS.obj_4c_OptArquivo.Value      = 1
1030:         THIS.chk_4c_Chk_EMAIL.Value       = 0
1031: 
1032:         loc_oCtn = THIS.cnt_4c_CtnSaida_Email
1033:         loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ""
1034:         loc_oCtn.obj_4c_TxtEmail_CC.Value         = ""
1035:         loc_oCtn.txt_4c_TxtEmail_Assunto.Value    = THIS.this_cAssunto
1036:         loc_oCtn.obj_4c_EdtEmail_Corpo.Value      = ""
1037:         loc_oCtn.Visible = .F.
1038:         THIS.Height = THIS.this_nAlturaBase
1039:     ENDPROC
1040: 
1041:     *--------------------------------------------------------------------------
1042:     * AjustarBotoesPorModo - N/A: dialogo OPERACIONAL nao tem modos CRUD.
1043:     * SIGPRPDF opera em modo unico (dialogo modal de gravar/enviar).
1044:     * Mantido para compatibilidade com a interface do pipeline.
1045:     *--------------------------------------------------------------------------
1046:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1047:         RETURN
1048:     ENDPROC
1049: 
1050:     *--------------------------------------------------------------------------
1051:     * Destroy - Libera BINDEVENTS e BO
1052:     *--------------------------------------------------------------------------
1053:     PROCEDURE Destroy()
1054:         LOCAL loc_oErro
1055: 
1056:         TRY
1057:             UNBINDEVENTS(THIS)
1058:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1059:                 THIS.this_oBusinessObject = .NULL.
1060:             ENDIF
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message, "Erro Destroy")
1063:         ENDTRY
1064: 
1065:         DODEFAULT()
1066:     ENDPROC
1067: 
1068: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* sigprpdfBO.prg - Business Object: Gera????o de PDF/XLS e E-mail
* Herda de: BusinessBase
* Tipo: OPERACIONAL (auxiliar modal - sem CRUD)
* Tabela: SigCdEmp (somente leitura para config. de email)
*==============================================================================
DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela de CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Diretorio e arquivo de saida
    this_cDiretorio     = ""
    this_cArquivoSaida  = ""
    this_nTipoArquivo   = 1

    *-- Disponibilidade do PDFCreator (verificado via registry)
    this_lPdfDisponivel = .F.

    *-- Dados de email da empresa (vindos de SigCdEmp)
    this_cEmailEmpresaDe = ""
    this_cSmtpServidor   = ""
    this_cSmtpSenha      = ""
    this_cSmtpPasta      = ""
    this_nSmtpPorta      = 0

    *-- Dados do email a enviar
    this_lEnviarEmail   = .F.
    this_cEmailPara     = ""
    this_cEmailCC       = ""
    this_cEmailAssunto  = ""
    this_cEmailCorpo    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = ""
        this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmailEmpresa()
    *-- Busca configuracoes de email da empresa em SigCdEmp
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, pastas, PadPortas " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_EmailEmp")
                USE IN cursor_4c_EmailEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmailEmp") < 1
                MsgErro("Falha ao carregar dados de email da empresa.", "Erro")
            ELSE
                IF RECCOUNT("cursor_4c_EmailEmp") > 0
                    SELECT cursor_4c_EmailEmp
                    THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
                    THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
                    THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
                    THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas,    ""))
                    THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaSalvar()
    *-- Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cArquivoSaida)
            MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaEmail()
    *-- Valida campos obrigatorios do email antes de enviar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cEmailEmpresaDe)
            MsgAviso("O campo 'DE:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND EMPTY(THIS.this_cEmailPara)
            MsgAviso("O campo 'PARA:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MontarObjetoEmail(par_cArquivoAnexo)
    *-- Monta e retorna objeto CUSTOM com dados do email para o form pai usar
    *-- par_cArquivoAnexo: caminho completo do arquivo a ser anexado
    *-- Retorna objeto CUSTOM ou .NULL. em caso de erro
    *--------------------------------------------------------------------------
        LOCAL loc_oEmail, loc_oErro

        loc_oEmail = .NULL.

        TRY
            IF !THIS.ValidarParaEmail()
                loc_lResultado = .NULL.
            ENDIF

            loc_oEmail = CREATEOBJECT("CUSTOM")

            loc_oEmail.AddProperty("cSmtpServer",    THIS.this_cSmtpServidor)
            loc_oEmail.AddProperty("nSmtpServerPort", THIS.this_nSmtpPorta)
            loc_oEmail.AddProperty("cSendUserName",  THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cSendPassWord",  THIS.this_cSmtpSenha)
            loc_oEmail.AddProperty("cFrom",          THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cTO",            THIS.this_cEmailPara)
            loc_oEmail.AddProperty("cCC",            THIS.this_cEmailCC)
            loc_oEmail.AddProperty("cAssunto",       THIS.this_cEmailAssunto)
            loc_oEmail.AddProperty("cCorpo",         THIS.this_cEmailCorpo)
            loc_oEmail.AddProperty("cAnexo",         par_cArquivoAnexo)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oEmail = .NULL.
        ENDTRY

        RETURN loc_oEmail
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ResolverExtensao(par_cCaminho, par_nTipoArquivo)
    *-- Garante que o caminho tem a extensao correta (.pdf ou .xls)
    *-- par_cCaminho: caminho do arquivo (pode estar sem extensao)
    *-- par_nTipoArquivo: 1=PDF, 2=XLS
    *-- Retorna: caminho com extensao correta
    *--------------------------------------------------------------------------
        LOCAL loc_cExt, loc_cCaminho

        loc_cExt    = IIF(par_nTipoArquivo = 1, "PDF", "XLS")
        loc_cCaminho = ALLTRIM(par_cCaminho)

        IF !EMPTY(loc_cCaminho)
            IF !(UPPER(JUSTEXT(loc_cCaminho)) $ loc_cExt)
                loc_cCaminho = FORCEEXT(loc_cCaminho, LEFT(loc_cExt, 3))
            ENDIF
        ENDIF

        RETURN loc_cCaminho
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Carrega config de email da empresa a partir do cursor (TmpEmpMail/cursor_4c_EmailEmp)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
            THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
            THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
            THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas, ""))
            THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Form auxiliar sem tabela de CRUD - sem chave primaria
    *--------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *-- Compatibilidade BusinessBase.Salvar() - delega para ValidarParaSalvar
    *--------------------------------------------------------------------------
        RETURN THIS.ValidarParaSalvar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AbrirPasta(par_cDiretorio)
    *-- Abre o diretorio no Windows Explorer
    *--------------------------------------------------------------------------
        LOCAL loc_oApp, loc_oErro

        TRY
            IF !EMPTY(par_cDiretorio)
                IF !DIRECTORY(par_cDiretorio)
                    MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oApp = CREATEOBJECT("Shell.Application")
                    loc_oApp.Open(par_cDiretorio)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Modo GRAVAR: prepara arquivo de saida SEM envio de email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Inserir" representa
    *-- a acao de gerar o arquivo de saida (PDF/XLS) pela primeira vez.
    *-- Valida os dados, resolve extensao do arquivo e marca envio de email
    *-- como .F. para que o form pai use apenas o caminho do arquivo.
    *-- Retorna: .T. sucesso, .F. falha (ver ObterMensagemErro em BusinessBase)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                THIS.this_lEnviarEmail = .F.
                THIS.this_cEmailPara    = ""
                THIS.this_cEmailCC      = ""
                THIS.this_cEmailAssunto = ""
                THIS.this_cEmailCorpo   = ""

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar arquivo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Modo ENVIAR EMAIL: prepara arquivo de saida COM anexo em email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Atualizar" representa
    *-- a acao de re-gerar/atualizar o arquivo com envio por email anexado.
    *-- Valida arquivo E dados de email antes de sinalizar sucesso.
    *-- Retorna: .T. sucesso, .F. falha
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                IF !THIS.ValidarParaEmail()
                    loc_lResultado = .F.
                ELSE
                    THIS.this_lEnviarEmail = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar envio de email")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

