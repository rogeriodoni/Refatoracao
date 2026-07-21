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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1069 linhas total):

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
230:                     .FontName   = "Comic Sans MS"
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

*-- Linhas 642 a 1069:
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
655:                 IF UPPER(loc_oCtrl.Name) = "CNT_4C_CTNSAIDA_EMAIL"
656:                     *-- Secao email permanece oculta; tornar filhos visiveis para
657:                     *-- que aparecam corretamente quando o container for mostrado
658:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
659:                         THIS.TornarControlesVisiveis(loc_oCtrl)
660:                     ENDIF
661:                     LOOP
662:                 ENDIF
663: 
664:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
665:                     loc_oCtrl.Visible = .T.
666:                 ENDIF
667: 
668:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
669:                     THIS.TornarControlesVisiveis(loc_oCtrl)
670:                 ENDIF
671:             ENDIF
672:         ENDFOR
673:     ENDPROC
674: 
675:     *--------------------------------------------------------------------------
676:     * CmdGetFileClick - Abre dialogo de selecao de arquivo PDF ou XLS
677:     *--------------------------------------------------------------------------
678:     PROCEDURE CmdGetFileClick()
679:         LOCAL loc_cTpArq, loc_cArqSaida, loc_oErro
680: 
681:         TRY
682:             loc_cTpArq    = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
683:             loc_cArqSaida = GETFILE(loc_cTpArq, "Arquivo:", "Selecionar", 0, "Selecione o arquivo")
684: 
685:             IF !EMPTY(loc_cArqSaida)
686:                 loc_cArqSaida = THIS.this_oBusinessObject.ResolverExtensao(loc_cArqSaida, THIS.obj_4c_OptArquivo.Value)
687:                 THIS.txt_4c_TxtNomeArqSaida.Value = ALLTRIM(loc_cArqSaida)
688:             ENDIF
689: 
690:         CATCH TO loc_oErro
691:             MsgErro(loc_oErro.Message, "Erro")
692:         ENDTRY
693:     ENDPROC
694: 
695:     *--------------------------------------------------------------------------
696:     * ChkEmailClick - Expande/contrai form mostrando/ocultando secao de email
697:     *--------------------------------------------------------------------------
698:     PROCEDURE ChkEmailClick()
699:         LOCAL loc_oErro
700: 
701:         TRY
702:             THIS.LockScreen = .T.
703: 
704:             IF THIS.chk_4c_Chk_EMAIL.Value = 1
705:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "Enviar Email"
706:                 THIS.Height = THIS.this_nAlturaBase + THIS.cnt_4c_CtnSaida_Email.Height
707:                 THIS.cnt_4c_CtnSaida_Email.Visible = .T.
708:             ELSE
709:                 THIS.cmd_4c_Cmd_GerarPDF.Caption = "\<Gravar"
710:                 THIS.Height = THIS.this_nAlturaBase
711:                 THIS.cnt_4c_CtnSaida_Email.Visible = .F.
712:             ENDIF
713: 
714:             THIS.Refresh()
715:             THIS.LockScreen = .F.
716: 
717:         CATCH TO loc_oErro
718:             THIS.LockScreen = .F.
719:             MsgErro(loc_oErro.Message, "Erro")
720:         ENDTRY
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * OptArquivoClick - Atualiza nome do arquivo conforme tipo PDF/XLS selecionado
725:     *--------------------------------------------------------------------------
726:     PROCEDURE OptArquivoClick()
727:         LOCAL loc_oErro
728: 
729:         TRY
730:             IF THIS.obj_4c_OptArquivo.Value = 1
731:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
732:             ELSE
733:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
734:             ENDIF
735: 
736:         CATCH TO loc_oErro
737:             MsgErro(loc_oErro.Message, "Erro")
738:         ENDTRY
739:     ENDPROC
740: 
741:     *--------------------------------------------------------------------------
742:     * CmdGerarPDFClick - Acao principal: gravar arquivo ou preparar envio de email
743:     *--------------------------------------------------------------------------
744:     PROCEDURE CmdGerarPDFClick()
745:         LOCAL loc_cArquivo, loc_oEmail, loc_lEnviarEmail, loc_lResultado, loc_lContinuar, loc_oErro
746: 
747:         loc_lContinuar = .T.
748: 
749:         TRY
750:             loc_cArquivo = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
751: 
752:             IF EMPTY(loc_cArquivo)
753:                 MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
754:                 THIS.cmd_4c_CmdGetFile.SetFocus()
755:                 loc_lContinuar = .F.
756:             ENDIF
757: 
758:             IF loc_lContinuar
759:                 loc_lEnviarEmail = (THIS.chk_4c_Chk_EMAIL.Value = 1)
760: 
761:                 IF loc_lEnviarEmail
762:                     *-- Modo email: coletar dados do form para o BO validar
763:                     THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
764:                     THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
765:                     THIS.this_oBusinessObject.this_cEmailPara    = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value, ""))
766:                     THIS.this_oBusinessObject.this_cEmailCC      = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_CC.Value,         ""))
767:                     THIS.this_oBusinessObject.this_cEmailAssunto = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value,    ""))
768:                     THIS.this_oBusinessObject.this_cEmailCorpo   = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_EdtEmail_Corpo.Value,      ""))
769: 
770:                     loc_lResultado = THIS.this_oBusinessObject.Atualizar()
771: 
772:                     IF loc_lResultado
773:                         *-- Dados de email da empresa precisam estar carregados (cursor_4c_EmailEmp)
774:                         IF USED("cursor_4c_EmailEmp") AND RECCOUNT("cursor_4c_EmailEmp") > 0
775:                             loc_oEmail = THIS.this_oBusinessObject.MontarObjetoEmail( ;
776:                                 THIS.this_oBusinessObject.this_cArquivoSaida)
777: 
778:                             IF VARTYPE(THIS.this_oParentForm) = "O" AND VARTYPE(loc_oEmail) = "O"
779:                                 THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
780:                                 THIS.this_oParentForm.oEmail     = loc_oEmail
781:                             ENDIF
782:                         ELSE
783:                             IF VARTYPE(THIS.this_oParentForm) = "O"
784:                                 THIS.this_oParentForm.lPrintPDFCreator = .F.
785:                             ENDIF
786:                             MsgAviso("Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. " + ;
787:                                      "Favor enviar novamente.", "Aten" + CHR(231) + CHR(227) + "o")
788:                         ENDIF
789: 
790:                         THIS.Release()
791:                     ENDIF
792:                 ELSE
793:                     *-- Modo gravar: apenas definir arquivo no form pai
794:                     THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
795:                     THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
796: 
797:                     loc_lResultado = THIS.this_oBusinessObject.Inserir()
798: 
799:                     IF loc_lResultado
800:                         IF VARTYPE(THIS.this_oParentForm) = "O"
801:                             THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
802:                         ENDIF
803:                         THIS.Release()
804:                     ENDIF
805:                 ENDIF
806:             ENDIF
807: 
808:         CATCH TO loc_oErro
809:             MsgErro(loc_oErro.Message, "Erro ao gravar/enviar")
810:         ENDTRY
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * CmdSairClick - Cancela: limpa pcArqEmail e oEmail no form pai e fecha
815:     *--------------------------------------------------------------------------
816:     PROCEDURE CmdSairClick()
817:         LOCAL loc_oErro
818: 
819:         TRY
820:             IF VARTYPE(THIS.this_oParentForm) = "O"
821:                 THIS.this_oParentForm.pcArqEmail = ""
822:                 THIS.this_oParentForm.oEmail     = .NULL.
823:             ENDIF
824:             THIS.Release()
825: 
826:         CATCH TO loc_oErro
827:             MsgErro(loc_oErro.Message, "Erro")
828:         ENDTRY
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     * BtnPastasAClick - Abre diretorio fiscal no Windows Explorer
833:     *--------------------------------------------------------------------------
834:     PROCEDURE BtnPastasAClick()
835:         LOCAL loc_oErro
836: 
837:         TRY
838:             THIS.this_oBusinessObject.AbrirPasta(THIS.this_cDiretorio)
839: 
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message, "Erro")
842:         ENDTRY
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * ConfigurarPaginaLista - N/A (dialogo plano sem PageFrame/Grid)
847:     * Formsigprpdf eh um dialogo modal de 1 tela - sem Page1/Grid de lista.
848:     *--------------------------------------------------------------------------
849:     PROTECTED PROCEDURE ConfigurarPaginaLista()
850:         RETURN
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * ConfigurarPaginaDados - N/A (dialogo plano sem Page2)
855:     * Todos os controles sao criados diretamente em InicializarForm.
856:     *--------------------------------------------------------------------------
857:     PROTECTED PROCEDURE ConfigurarPaginaDados()
858:         RETURN
859:     ENDPROC
860: 
861:     *--------------------------------------------------------------------------
862:     * AlternarPagina - N/A (dialogo plano sem paginas para alternar)
863:     *--------------------------------------------------------------------------
864:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
865:         RETURN
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * BtnIncluirClick - N/A para dialogo OPERACIONAL de PDF/Email
870:     * Este form nao eh um cadastro CRUD (SIGPRPDF.SCX legado nao tem esse botao).
871:     * A acao equivalente de "gravar arquivo novo" eh feita por CmdGerarPDFClick,
872:     * que chama this_oBusinessObject.Inserir para persistir os dados de saida.
873:     *--------------------------------------------------------------------------
874:     PROCEDURE BtnIncluirClick()
875:         THIS.CmdGerarPDFClick()
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * BtnAlterarClick - N/A para dialogo OPERACIONAL de PDF/Email
880:     * SIGPRPDF.SCX legado nao possui operacao de alteracao (dialogo one-shot).
881:     * A acao equivalente de "reenviar/regravar" eh feita por CmdGerarPDFClick,
882:     * que decide entre Inserir (gravar) e Atualizar (enviar email).
883:     *--------------------------------------------------------------------------
884:     PROCEDURE BtnAlterarClick()
885:         THIS.CmdGerarPDFClick()
886:     ENDPROC
887: 
888:     *--------------------------------------------------------------------------
889:     * BtnVisualizarClick - N/A para dialogo OPERACIONAL de PDF/Email
890:     * SIGPRPDF.SCX legado nao possui operacao de visualizacao (nao ha registros
891:     * persistidos). A acao equivalente de "ver a pasta destino" eh BtnPastasAClick,
892:     * que abre o diretorio fiscal onde os PDFs/XLS sao salvos.
893:     *--------------------------------------------------------------------------
894:     PROCEDURE BtnVisualizarClick()
895:         THIS.BtnPastasAClick()
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * BtnExcluirClick - N/A para dialogo OPERACIONAL de PDF/Email
900:     * SIGPRPDF.SCX legado nao possui operacao de exclusao (dialogo modal one-shot).
901:     * A acao equivalente de "cancelar/descartar" eh CmdSairClick, que limpa
902:     * pcArqEmail/oEmail no form pai e fecha o dialogo sem gravar.
903:     *--------------------------------------------------------------------------
904:     PROCEDURE BtnExcluirClick()
905:         THIS.CmdSairClick()
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * BtnSalvarClick - Delega para a acao principal do dialogo (Gravar/Enviar).
910:     * SIGPRPDF.SCX legado usa Cmd_GerarPDF (nao ha botao "Salvar" separado).
911:     * Mantido para compatibilidade com a interface CRUD do pipeline.
912:     *--------------------------------------------------------------------------
913:     PROCEDURE BtnSalvarClick()
914:         THIS.CmdGerarPDFClick()
915:     ENDPROC
916: 
917:     *--------------------------------------------------------------------------
918:     * BtnCancelarClick - Delega para o cancelamento do dialogo (Cmd_SAIR).
919:     * SIGPRPDF.SCX legado nao tem botao "Cancelar" separado; sair equivale a
920:     * cancelar (limpa pcArqEmail/oEmail do form pai).
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnCancelarClick()
923:         THIS.CmdSairClick()
924:     ENDPROC
925: 
926:     *--------------------------------------------------------------------------
927:     * FormParaBO - Copia valores dos controles do form para as propriedades do BO.
928:     * Chamado antes de invocar Inserir/Atualizar no BO (via CmdGerarPDFClick).
929:     *--------------------------------------------------------------------------
930:     PROTECTED PROCEDURE FormParaBO()
931:         LOCAL loc_oCtn, loc_oErro
932: 
933:         TRY
934:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
935:                 RETURN
936:             ENDIF
937: 
938:             THIS.this_oBusinessObject.this_cDiretorio    = THIS.this_cDiretorio
939:             THIS.this_oBusinessObject.this_cArquivoSaida = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
940:             THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
941:             THIS.this_oBusinessObject.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)
942: 
943:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
944:             THIS.this_oBusinessObject.this_cEmailEmpresaDe = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value, ""))
945:             THIS.this_oBusinessObject.this_cEmailPara      = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value, ""))
946:             THIS.this_oBusinessObject.this_cEmailCC        = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_CC.Value, ""))
947:             THIS.this_oBusinessObject.this_cEmailAssunto   = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_Assunto.Value, ""))
948:             THIS.this_oBusinessObject.this_cEmailCorpo     = ALLTRIM(NVL(loc_oCtn.obj_4c_EdtEmail_Corpo.Value, ""))
949: 
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
952:         ENDTRY
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * BOParaForm - Copia propriedades do BO para os controles do form.
957:     * Chamado apos CarregarEmailEmpresa para propagar dados da empresa.
958:     *--------------------------------------------------------------------------
959:     PROTECTED PROCEDURE BOParaForm()
960:         LOCAL loc_oCtn, loc_oErro
961: 
962:         TRY
963:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
964:                 RETURN
965:             ENDIF
966: 
967:             THIS.this_cDiretorio = THIS.this_oBusinessObject.this_cDiretorio
968: 
969:             IF THIS.obj_4c_OptArquivo.Value = 1
970:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
971:             ELSE
972:                 THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
973:             ENDIF
974: 
975:             loc_oCtn = THIS.cnt_4c_CtnSaida_Email
976:             loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value = THIS.this_oBusinessObject.this_cEmailEmpresaDe
977:             loc_oCtn.txt_4c_TxtEmail_Assunto.Value  = THIS.this_cAssunto
978: 
979:             IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
980:                 loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
981:             ENDIF
982: 
983:         CATCH TO loc_oErro
984:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
985:         ENDTRY
986:     ENDPROC
987: 
988:     *--------------------------------------------------------------------------
989:     * CarregarLista - N/A para dialogo OPERACIONAL de PDF/Email (sem grid).
990:     * SIGPRPDF.SCX legado eh um dialogo modal one-shot sem lista de registros.
991:     * A acao equivalente de "carregar dados iniciais" eh CarregarEmailEmpresa
992:     * no BO, que popula as configuracoes de email da empresa em SigCdEmp.
993:     *--------------------------------------------------------------------------
994:     PROCEDURE CarregarLista()
995:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
996:             THIS.this_oBusinessObject.CarregarEmailEmpresa()
997:             THIS.BOParaForm()
998:         ENDIF
999:     ENDPROC
1000: 
1001:     *--------------------------------------------------------------------------
1002:     * HabilitarCampos - Ajusta enabled dos controles conforme o modo do dialogo.
1003:     * par_lHabilitar: .T. habilita edicao, .F. bloqueia (durante processamento).
1004:     *--------------------------------------------------------------------------
1005:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1006:         LOCAL loc_lEnabled, loc_oCtn
1007: 
1008:         loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1009: 
1010:         THIS.obj_4c_OptArquivo.Enabled     = loc_lEnabled
1011:         THIS.cmd_4c_CmdGetFile.Enabled     = loc_lEnabled
1012:         THIS.chk_4c_Chk_EMAIL.Enabled      = loc_lEnabled
1013:         THIS.cmd_4c_Cmd_GerarPDF.Enabled   = loc_lEnabled
1014:         THIS.cmd_4c_BtnPastasA.Enabled     = loc_lEnabled
1015: 
1016:         loc_oCtn = THIS.cnt_4c_CtnSaida_Email
1017:         loc_oCtn.obj_4c_TxtEmail_EnviarPara.Enabled = loc_lEnabled
1018:         loc_oCtn.obj_4c_TxtEmail_CC.Enabled         = loc_lEnabled
1019:         loc_oCtn.txt_4c_TxtEmail_Assunto.Enabled    = loc_lEnabled
1020:         loc_oCtn.obj_4c_EdtEmail_Corpo.Enabled      = loc_lEnabled
1021:     ENDPROC
1022: 
1023:     *--------------------------------------------------------------------------
1024:     * LimparCampos - Reseta valores dos controles editaveis do form.
1025:     *--------------------------------------------------------------------------
1026:     PROTECTED PROCEDURE LimparCampos()
1027:         LOCAL loc_oCtn
1028: 
1029:         THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
1030:         THIS.obj_4c_OptArquivo.Value      = 1
1031:         THIS.chk_4c_Chk_EMAIL.Value       = 0
1032: 
1033:         loc_oCtn = THIS.cnt_4c_CtnSaida_Email
1034:         loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ""
1035:         loc_oCtn.obj_4c_TxtEmail_CC.Value         = ""
1036:         loc_oCtn.txt_4c_TxtEmail_Assunto.Value    = THIS.this_cAssunto
1037:         loc_oCtn.obj_4c_EdtEmail_Corpo.Value      = ""
1038:         loc_oCtn.Visible = .F.
1039:         THIS.Height = THIS.this_nAlturaBase
1040:     ENDPROC
1041: 
1042:     *--------------------------------------------------------------------------
1043:     * AjustarBotoesPorModo - N/A: dialogo OPERACIONAL nao tem modos CRUD.
1044:     * SIGPRPDF opera em modo unico (dialogo modal de gravar/enviar).
1045:     * Mantido para compatibilidade com a interface do pipeline.
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1048:         RETURN
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * Destroy - Libera BINDEVENTS e BO
1053:     *--------------------------------------------------------------------------
1054:     PROCEDURE Destroy()
1055:         LOCAL loc_oErro
1056: 
1057:         TRY
1058:             UNBINDEVENTS(THIS)
1059:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1060:                 THIS.this_oBusinessObject = .NULL.
1061:             ENDIF
1062:         CATCH TO loc_oErro
1063:             MsgErro(loc_oErro.Message, "Erro Destroy")
1064:         ENDTRY
1065: 
1066:         DODEFAULT()
1067:     ENDPROC
1068: 
1069: ENDDEFINE


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

