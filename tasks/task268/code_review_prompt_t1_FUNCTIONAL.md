# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CONTAINER-TOGGLE] Container 'CNT_4C_COPIA' eh flutuante (Visible=.F. toggled por botao) mas TornarControlesVisiveis NAO o filtra. Adicionar verificacao INLIST/IF para pular este container no loop.
- [BINDEVENT-PARAMS] Handler 'EmpOsLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE EmpOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'QmaxsLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE QmaxsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'GradeICol5LostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE GradeICol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'St' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtde.Máx.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tam.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGPRCOM.Pagina.Dados): Top original=100 vs migrado 'obj_4c_Opc_situacao' Top=5 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGPRCOM.Pagina.Dados): Left original=555 vs migrado 'obj_4c_Opc_situacao' Left=5 (diff=550px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2444 linhas total):

*-- Linhas 8 a 52:
8: *   Page2 (Dados) - Campos do produto + gradei (SigCdMax) para edicao de maximos
9: *
10: * CHAMADA EXTERNA:
11: *   CREATEOBJECT("Formsigprcom")                          -> modo normal (lista)
12: *   CREATEOBJECT("Formsigprcom", cCPros, "", cEsc, ...)  -> modo externo (produto fixo)
13: *==============================================================================
14: 
15: DEFINE CLASS Formsigprcom AS FormBase
16: 
17:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
18:     Height       = 675
19:     Width        = 1000
20:     Caption      = "Estoque Maximo"
21:     AutoCenter   = .T.
22:     ShowWindow   = 1
23:     WindowType   = 1
24:     ControlBox   = .F.
25:     Closable     = .F.
26:     MaxButton    = .F.
27:     TitleBar     = 0
28:     ClipControls = .F.
29:     Themes       = .F.
30:     BorderStyle  = 2
31:     FontName     = "Tahoma"
32:     ForeColor    = RGB(90, 90, 90)
33:     DataSession  = 2
34: 
35:     *-- Business Object e estado
36:     this_oBusinessObject = .NULL.
37:     this_cMensagemErro   = ""
38:     this_cModoAtual      = "LISTA"
39: 
40:     *-- Propriedades de chamada externa (equivalentes as propriedades legadas pProduto/pcExterno)
41:     this_cPProduto  = ""   && c" + CHR(243) + "digo do produto quando chamado externamente
42:     this_cPExterno  = ""   && identificador do chamador externo (pcEsc)
43:     this_cPCPros    = ""   && c" + CHR(243) + "digo do produto padded (14 chars)
44:     this_cPDPros    = ""   && descri" + CHR(231) + CHR(227) + "o do produto
45:     this_cPCGrus    = ""   && c" + CHR(243) + "digo do grupo
46:     this_cPIFors    = ""   && c" + CHR(243) + "digo do fornecedor
47:     this_cPReffs    = ""   && refer" + CHR(234) + "ncia do produto
48:     this_lPCancelar = .F.  && indica" + CHR(231) + CHR(227) + "o de cancelamento
49: 
50:     *-- Propriedades de controle de varia" + CHR(231) + CHR(245) + "es do produto
51:     this_lTemCor    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de cor
52:     this_lTemTam    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de tamanho

*-- Linhas 61 a 146:
61:     *--------------------------------------------------------------------------
62:     * Init - Inicializa form; suporta chamada externa com par" + CHR(226) + "metros de produto
63:     *--------------------------------------------------------------------------
64:     PROCEDURE Init()
65:         LOCAL loc_lSucesso
66:         loc_lSucesso = .F.
67: 
68:         LPARAMETERS par_cAcesso, par_cPcForm, par_cPcEsc, par_cPDPros, par_cPCGrus, par_cPIFors, par_cPReffs
69: 
70:         TRY
71:             *-- Capturar par" + CHR(226) + "metros de chamada externa ANTES de DODEFAULT
72:             IF TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
73:                 THIS.this_cPProduto = ALLTRIM(par_cAcesso)
74:                 THIS.this_cPCPros   = PADR(ALLTRIM(par_cAcesso), 14)
75:             ENDIF
76: 
77:             IF TYPE("par_cPcEsc") = "C" AND !EMPTY(par_cPcEsc) ;
78:                AND TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
79:                 THIS.this_cPExterno = par_cPcEsc
80:                 THIS.this_cPDPros   = TratarNulo(par_cPDPros, "C")
81:                 THIS.this_cPCGrus   = TratarNulo(par_cPCGrus, "C")
82:                 THIS.this_cPIFors   = TratarNulo(par_cPIFors, "C")
83:                 THIS.this_cPReffs   = TratarNulo(par_cPReffs, "C")
84:             ENDIF
85: 
86:             *-- DODEFAULT() chama FormBase.Init() que chama THIS.InicializarForm()
87:             loc_lSucesso = DODEFAULT()
88: 
89:         CATCH TO loc_oErro
90:             MsgErro("Erro em Formsigprcom.Init: " + loc_oErro.Message, "Erro")
91:             loc_lSucesso = .F.
92:         ENDTRY
93: 
94:         RETURN loc_lSucesso
95:     ENDPROC
96: 
97:     *--------------------------------------------------------------------------
98:     * InicializarForm - Configura" + CHR(231) + CHR(227) + "o inicial do formulario
99:     * Chamado automaticamente por FormBase.Init() via DODEFAULT()
100:     *--------------------------------------------------------------------------
101:     PROTECTED PROCEDURE InicializarForm()
102:         LOCAL loc_lSucesso
103:         loc_lSucesso = .F.
104: 
105:         TRY
106:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")
107: 
108:             IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ISNULL(THIS.this_oBusinessObject)
109:                 MostrarErro("Erro ao criar Business Object sigprcomBO", "Erro Cr" + CHR(237) + "tico")
110:             ELSE
111:                 *-- Corrigir Caption com acento (CHR nao pode ser usado em DEFINE CLASS)
112:                 THIS.Caption = "Estoque M" + CHR(225) + "ximo"
113: 
114:                 THIS.ConfigurarPageFrame()
115:                 THIS.ConfigurarPaginaLista()
116:                 THIS.ConfigurarPaginaDados()
117: 
118:                 *-- Propagar Caption para labels do cabe" + CHR(231) + "alho
119:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
120:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
121: 
122:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
123:                     *-- Modo externo: produto j" + CHR(225) + " definido, ir direto para Page2
124:                     IF !EMPTY(THIS.this_cPCPros)
125:                         THIS.this_cPCEscolha = "ALTERAR"
126:                         THIS.this_cModoAtual  = "DADOS"
127:                         THIS.pgf_4c_Paginas.Visible    = .T.
128:                         THIS.pgf_4c_Paginas.ActivePage = 2
129:                         *-- Fases 5-8 completam carga dos dados do produto no Dados
130:                     ELSE
131:                         *-- Modo normal: listar produtos na Page1
132:                         IF !THIS.CarregarLista()
133:                             *-- Falha ao carregar nao impede abertura
134:                         ENDIF
135:                         THIS.pgf_4c_Paginas.Visible    = .T.
136:                         THIS.pgf_4c_Paginas.ActivePage = 1
137:                         THIS.this_cModoAtual = "LISTA"
138:                     ENDIF
139:                 ELSE
140:                     THIS.pgf_4c_Paginas.Visible    = .T.
141:                     THIS.pgf_4c_Paginas.ActivePage = 1
142:                 ENDIF
143: 
144:                 loc_lSucesso = .T.
145:             ENDIF
146: 

*-- Linhas 157 a 239:
157:     * ConfigurarPageFrame - Configura PageFrame principal
158:     * PageFrame.Top=-29 para ocultar abas; controles compensam +29 no Top
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarPageFrame()
161:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
162: 
163:         WITH THIS.pgf_4c_Paginas
164:             .Top       = -29
165:             .Left      = 0
166:             .Width     = 1003
167:             .Height    = 704   && 675 (form.Height) + 29 (compensacao abas)
168:             .PageCount = 2
169:             .Tabs      = .F.
170:             .Visible   = .F.
171:         ENDWITH
172: 
173:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
174:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
175:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
176: 
177:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
178:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
179:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------
183:     * ConfigurarPaginaLista - Configura Page1 (Lista de produtos)
184:     * Fase 3: containers principais; Fase 4 adiciona grid e bot" + CHR(245) + "es CRUD
185:     *--------------------------------------------------------------------------
186:     PROTECTED PROCEDURE ConfigurarPaginaLista()
187:         LOCAL loc_oPagina
188:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
189: 
190:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
191:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
192: 
193:         *-- Cabe" + CHR(231) + "alho (equivalente ao cntSombra do legado)
194:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
195:         WITH loc_oPagina.cnt_4c_Cabecalho
196:             .Top         = 1 + 29   && compensacao PageFrame (cntSombra.Top=1)
197:             .Left        = -1
198:             .Width       = 1008
199:             .Height      = 80
200:             .BackColor   = RGB(100, 100, 100)
201:             .BorderWidth = 0
202:             .Visible     = .T.
203:         ENDWITH
204: 
205:         *-- Label sombra (offset 2px para efeito de sombra)
206:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
207:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
208:             .AutoSize  = .F.
209:             .Top       = 15
210:             .Left      = 12
211:             .Width     = 980
212:             .Height    = 40
213:             .Caption   = THIS.Caption
214:             .FontName  = "Tahoma"
215:             .FontSize  = 16
216:             .FontBold  = .T.
217:             .ForeColor = RGB(0, 0, 0)
218:             .BackStyle = 0
219:             .Visible   = .T.
220:         ENDWITH
221: 
222:         *-- Label titulo (branco sobre fundo escuro)
223:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
224:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
225:             .AutoSize  = .F.
226:             .Top       = 18
227:             .Left      = 10
228:             .Width     = 980
229:             .Height    = 46
230:             .Caption   = THIS.Caption
231:             .FontName  = "Tahoma"
232:             .FontSize  = 16
233:             .FontBold  = .T.
234:             .ForeColor = RGB(255, 255, 255)
235:             .BackStyle = 0
236:             .Visible   = .T.
237:         ENDWITH
238: 
239:         *-- Container de bot" + CHR(245) + "es CRUD (equivalente ao Grupo_op do legado)

*-- Linhas 287 a 308:
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         *-- Container de c" + CHR(243) + "pia entre empresas (cntCopia - inicia oculto)
291:         *-- Top=161 + 29=190 (compensacao PageFrame)
292:         loc_oPagina.AddObject("cnt_4c_Copia", "Container")
293:         WITH loc_oPagina.cnt_4c_Copia
294:             .Top           = 161 + 29   && 190
295:             .Left          = 256
296:             .Width         = 486
297:             .Height        = 373
298:             .SpecialEffect = 0
299:             .BackColor     = RGB(255, 255, 255)
300:             .BackStyle     = 1
301:             .Visible       = .F.    && Inicia oculto - aparece ao clicar "Copiar Produto"
302:             .BorderWidth   = 1
303:         ENDWITH
304: 
305:         *-- ===== BOTOES CRUD dentro de cnt_4c_Botoes (Lefts: 5,80,155,230,305) =====
306:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
308:             .Top             = 5

*-- Linhas 469 a 650:
469:             .Column4.Width = 100
470:             .Column5.Width = 165
471:             .Column6.Width = 50
472:         ENDWITH
473: 
474:         *-- ===== Conteudo do painel de copia (cnt_4c_Copia) =====
475:         *-- Labels de identificacao das empresas
476:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Lbl_empresa", "Label")
477:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Lbl_empresa
478:             .Top       = 35
479:             .Left      = 35
480:             .Width     = 87
481:             .Height    = 17
482:             .Caption   = "Empresa Origem :"
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .ForeColor = RGB(90, 90, 90)
486:             .BackStyle = 0
487:             .AutoSize  = .F.
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label2", "Label")
492:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label2
493:             .Top       = 60
494:             .Left      = 33
495:             .Width     = 89
496:             .Height    = 17
497:             .Caption   = "Empresa Destino :"
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .ForeColor = RGB(90, 90, 90)
501:             .BackStyle = 0
502:             .AutoSize  = .F.
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label1", "Label")
507:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label1
508:             .Top       = 85
509:             .Left      = 35
510:             .Width     = 85
511:             .Height    = 17
512:             .Caption   = "Procura Produto :"
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .ForeColor = RGB(90, 90, 90)
516:             .BackStyle = 0
517:             .AutoSize  = .F.
518:             .Visible   = .T.
519:         ENDWITH
520: 
521:         *-- TextBoxes de filtro da copia
522:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpOs", "TextBox")
523:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs
524:             .Top       = 31
525:             .Left      = 124
526:             .Width     = 31
527:             .Height    = 23
528:             .InputMask = "XXX"
529:             .Value     = ""
530:             .MaxLength = 3
531:             .FontName  = "Tahoma"
532:             .FontSize  = 8
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpDs", "TextBox")
537:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs
538:             .Top       = 56
539:             .Left      = 124
540:             .Width     = 31
541:             .Height    = 23
542:             .InputMask = "XXX"
543:             .Value     = ""
544:             .MaxLength = 3
545:             .Enabled   = .F.
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_Produto", "TextBox")
552:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_Produto
553:             .Top       = 81
554:             .Left      = 124
555:             .Width     = 108
556:             .Height    = 23
557:             .Value     = ""
558:             .FontName  = "Tahoma"
559:             .FontSize  = 8
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         *-- Botoes de acao do painel de copia
564:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdProcessa", "CommandButton")
565:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa
566:             .Top             = 3
567:             .Left            = 256
568:             .Width           = 75
569:             .Height          = 75
570:             .Caption         = "\<Processar"
571:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
572:             .PicturePosition = 13
573:             .FontName        = "Comic Sans MS"
574:             .FontSize        = 8
575:             .FontBold        = .T.
576:             .FontItalic      = .T.
577:             .ForeColor       = RGB(90, 90, 90)
578:             .BackColor       = RGB(255, 255, 255)
579:             .Themes          = .F.
580:             .SpecialEffect   = 0
581:             .WordWrap        = .T.
582:             .MousePointer    = 15
583:             .Visible         = .T.
584:         ENDWITH
585: 
586:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdCopiar", "CommandButton")
587:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar
588:             .Top             = 3
589:             .Left            = 332
590:             .Width           = 75
591:             .Height          = 75
592:             .Caption         = "Confirma"
593:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
594:             .PicturePosition = 13
595:             .FontName        = "Comic Sans MS"
596:             .FontSize        = 8
597:             .FontBold        = .T.
598:             .FontItalic      = .T.
599:             .ForeColor       = RGB(90, 90, 90)
600:             .BackColor       = RGB(255, 255, 255)
601:             .Themes          = .F.
602:             .SpecialEffect   = 0
603:             .WordWrap        = .T.
604:             .MousePointer    = 15
605:             .Visible         = .T.
606:         ENDWITH
607: 
608:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdSair", "CommandButton")
609:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair
610:             .Top             = 3
611:             .Left            = 407
612:             .Width           = 75
613:             .Height          = 75
614:             .Caption         = "Encerrar"
615:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
616:             .PicturePosition = 13
617:             .FontName        = "Comic Sans MS"
618:             .FontSize        = 8
619:             .FontBold        = .T.
620:             .FontItalic      = .T.
621:             .ForeColor       = RGB(90, 90, 90)
622:             .BackColor       = RGB(255, 255, 255)
623:             .Themes          = .F.
624:             .SpecialEffect   = 0
625:             .WordWrap        = .T.
626:             .MousePointer    = 15
627:             .Visible         = .T.
628:         ENDWITH
629: 
630:         *-- Grid de itens da copia (GrdItens - 6 colunas)
631:         *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
632:         loc_oPagina.cnt_4c_Copia.AddObject("grd_4c_DadosCopia", "Grid")
633:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
634:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.ColumnCount  = 6
635:         WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
636:             .Top              = 131
637:             .Left             = 27
638:             .Width            = 403
639:             .Height           = 184
640:             .FontName         = "Tahoma"
641:             .FontSize         = 8
642:             .BackColor        = RGB(255, 255, 255)
643:             .GridLineColor    = RGB(238, 238, 238)
644:             .HighlightStyle   = 2
645:             .DeleteMark       = .F.
646:             .RecordMark       = .F.
647:             .RowHeight        = 16
648:             .ScrollBars       = 2
649:             .GridLines        = 3
650:             .Visible          = .T.

*-- Linhas 665 a 878:
665:             .Column5.Header1.Caption = "Cor"
666:             .Column6.Header1.Caption = "Departamento"
667:         ENDWITH
668: 
669:         *-- CheckBox na Column1 do grd_4c_DadosCopia
670:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.AddObject("chk_4c_Check1", "CheckBox")
671:         WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.chk_4c_Check1
672:             .Caption = ""
673:             .FontName = "Tahoma"
674:             .FontSize = 8
675:             .Visible  = .T.
676:         ENDWITH
677:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.CurrentControl = "chk_4c_Check1"
678: 
679:         *-- Botoes Marcar/Desmarcar (standalone com icone - Themes=.T. obrigatorio)
680:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Marcar", "CommandButton")
681:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar
682:             .Top             = 234
683:             .Left            = 434
684:             .Width           = 40
685:             .Height          = 40
686:             .Caption         = ""
687:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
688:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
689:             .PicturePosition = 13
690:             .Themes          = .T.
691:             .SpecialEffect   = 0
692:             .ToolTipText     = "Selecionar todos"
693:             .MousePointer    = 15
694:             .Visible         = .T.
695:         ENDWITH
696: 
697:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Desmarcar", "CommandButton")
698:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar
699:             .Top             = 274
700:             .Left            = 434
701:             .Width           = 40
702:             .Height          = 40
703:             .Caption         = ""
704:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
705:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
706:             .PicturePosition = 13
707:             .Themes          = .T.
708:             .SpecialEffect   = 0
709:             .ToolTipText     = "Desmarcar todos"
710:             .MousePointer    = 15
711:             .Visible         = .T.
712:         ENDWITH
713: 
714:         *-- Labels de legenda de cores (Vermelho/Azul/Preto)
715:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label3", "Label")
716:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label3
717:             .Top       = 317
718:             .Left      = 40
719:             .Width     = 74
720:             .Height    = 15
721:             .Caption   = "Vermelho : "
722:             .ForeColor = RGB(255, 0, 0)
723:             .FontName  = "Tahoma"
724:             .FontSize  = 8
725:             .FontBold  = .T.
726:             .BackStyle = 0
727:             .AutoSize  = .F.
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label4", "Label")
732:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label4
733:             .Top       = 317
734:             .Left      = 118
735:             .Width     = 250
736:             .Height    = 15
737:             .Caption   = "Produtos existem na Origem e no Destino."
738:             .ForeColor = RGB(90, 90, 90)
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .BackStyle = 0
742:             .AutoSize  = .F.
743:             .Visible   = .T.
744:         ENDWITH
745: 
746:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label6", "Label")
747:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label6
748:             .Top       = 333
749:             .Left      = 45
750:             .Width     = 70
751:             .Height    = 15
752:             .Caption   = "Azul : "
753:             .ForeColor = RGB(0, 0, 255)
754:             .FontName  = "Tahoma"
755:             .FontSize  = 8
756:             .FontBold  = .T.
757:             .BackStyle = 0
758:             .AutoSize  = .F.
759:             .Visible   = .T.
760:         ENDWITH
761: 
762:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label5", "Label")
763:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label5
764:             .Top       = 333
765:             .Left      = 118
766:             .Width     = 274
767:             .Height    = 15
768:             .Caption   = "Produtos existem no Destino mas n" + CHR(227) + "o existem na Origem"
769:             .ForeColor = RGB(90, 90, 90)
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .BackStyle = 0
773:             .AutoSize  = .F.
774:             .Visible   = .T.
775:         ENDWITH
776: 
777:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label7", "Label")
778:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label7
779:             .Top       = 349
780:             .Left      = 45
781:             .Width     = 70
782:             .Height    = 15
783:             .Caption   = "Preto : "
784:             .ForeColor = RGB(0, 0, 0)
785:             .FontName  = "Tahoma"
786:             .FontSize  = 8
787:             .FontBold  = .T.
788:             .BackStyle = 0
789:             .AutoSize  = .F.
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label8", "Label")
794:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label8
795:             .Top       = 349
796:             .Left      = 118
797:             .Width     = 274
798:             .Height    = 15
799:             .Caption   = "Produtos existem na Origem mas n" + CHR(227) + "o existem no Destino"
800:             .ForeColor = RGB(90, 90, 90)
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .BackStyle = 0
804:             .AutoSize  = .F.
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         THIS.TornarControlesVisiveis(loc_oPagina)
809: 
810:         *-- IMPORTANTE: manter cnt_4c_Copia oculto apos TornarControlesVisiveis
811:         loc_oPagina.cnt_4c_Copia.Visible = .F.
812: 
813:         *-- ===== BINDEVENTs dos botoes CRUD (Page1) =====
814:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,    "Click", THIS, "BtnIncluirClick")
815:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
816:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
817:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
818:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
819:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
820:         BINDEVENT(loc_oPagina.cmd_4c_BtnCopiar,                "Click", THIS, "BtnCopiarClick")
821: 
822:         *-- BINDEVENTs dos botoes do painel de copia
823:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarCopiaClick")
824:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar,   "Click", THIS, "BtnConfirmarCopiaClick")
825:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair,     "Click", THIS, "BtnSairCopiaClick")
826:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar,      "Click", THIS, "BtnMarcarCopiaClick")
827:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar,   "Click", THIS, "BtnDesmarcarCopiaClick")
828: 
829:         *-- BINDEVENT para LostFocus de EmpOs (habilita EmpDs quando preenchido)
830:         BINDEVENT(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOsLostFocus")
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * ConfigurarPaginaDados - Configura Page2 (Dados do produto + grade de maximos)
835:     * Fase 5: botoes acao + labels + textboxes produto/grupo + optiongroup situacao
836:     * Fase 6: textboxes fornecedor/ref + botao excluir + gradei
837:     *--------------------------------------------------------------------------
838:     PROTECTED PROCEDURE ConfigurarPaginaDados()
839:         LOCAL loc_oPagina
840:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
841: 
842:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
843:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
844: 
845:         *-- Container de botoes de acao (Confirmar/Cancelar)
846:         *-- Grupo_Salva.Left=843, Grupo_Salva.Top=-3 + 29 = 26
847:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
848:         WITH loc_oPagina.cnt_4c_BotoesAcao
849:             .Top         = -3 + 29   && 26
850:             .Left        = 843
851:             .Width       = 160
852:             .Height      = 85
853:             .BackStyle   = 0
854:             .BorderWidth = 0
855:             .Visible     = .T.
856:         ENDWITH
857: 
858:         *-- Botao Confirmar (salva maximos e volta para lista)
859:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
860:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
861:             .Top             = 5
862:             .Left            = 5
863:             .Width           = 75
864:             .Height          = 75
865:             .Caption         = "Confirmar"
866:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
867:             .PicturePosition = 13
868:             .FontName        = "Comic Sans MS"
869:             .FontSize        = 8
870:             .FontBold        = .T.
871:             .FontItalic      = .T.
872:             .ForeColor       = RGB(90, 90, 90)
873:             .BackColor       = RGB(255, 255, 255)
874:             .Themes          = .F.
875:             .SpecialEffect   = 0
876:             .WordWrap        = .T.
877:             .MousePointer    = 15
878:             .Visible         = .T.

*-- Linhas 1046 a 1091:
1046:             .Visible   = .T.
1047:         ENDWITH
1048: 
1049:         *-- ===== OPTIONGROUP Situacao (Opc_situacao) - somente leitura (When=.F. no legado) =====
1050:         *-- top=100+29=129, left=555, width=117, height=25; ButtonCount=2 (1=Ativo, 2=Inativo)
1051:         loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1052:         WITH loc_oPagina.obj_4c_Opc_situacao
1053:             .Top         = 100 + 29
1054:             .Left        = 555
1055:             .Width       = 117
1056:             .Height      = 25
1057:             .ButtonCount = 2
1058:             .BackStyle   = 0
1059:             .BorderStyle = 0
1060:             .Value       = 1
1061:             .Visible     = .T.
1062:             WITH .Buttons(1)
1063:                 .Caption   = "Ativo"
1064:                 .Left      = 5
1065:                 .Top       = 5
1066:                 .Width     = 50
1067:                 .AutoSize  = .T.
1068:                 .ForeColor = RGB(90, 90, 90)
1069:                 .Themes    = .F.
1070:             ENDWITH
1071:             WITH .Buttons(2)
1072:                 .Caption   = "Inativo"
1073:                 .Left      = 58
1074:                 .Top       = 5
1075:                 .Width     = 55
1076:                 .AutoSize  = .T.
1077:                 .FontName  = "Tahoma"
1078:                 .FontSize  = 8
1079:                 .ForeColor = RGB(90, 90, 90)
1080:                 .Themes    = .F.
1081:             ENDWITH
1082:         ENDWITH
1083: 
1084:         *-- ===== TEXTBOXES - FORNECEDOR/REFERENCIA (Fase 6) =====
1085:         *-- txt_4c_Ifor: codigo do fornecedor - somente leitura (top=130+29=159)
1086:         loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
1087:         WITH loc_oPagina.txt_4c_Ifor
1088:             .Top       = 130 + 29
1089:             .Left      = 309
1090:             .Width     = 80
1091:             .Height    = 23

*-- Linhas 1256 a 1321:
1256:             ENDWITH
1257:         ENDWITH
1258: 
1259:         THIS.TornarControlesVisiveis(loc_oPagina)
1260: 
1261:         *-- BINDEVENTs dos botoes de Page2
1262:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1263:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1264: 
1265:         *-- BINDEVENT para busca de produto via F4
1266:         BINDEVENT(loc_oPagina.txt_4c__produto, "KeyPress", THIS, "ProdutoKeyPress")
1267: 
1268:         *-- BINDEVENTs da grade de maximos (Fase 6)
1269:         BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir,             "Click",             THIS, "BtnExcluirGradeClick")
1270:         BINDEVENT(loc_oPagina.grd_4c_Gradei,                 "AfterRowColChange", THIS, "GradeIAfterRowColChange")
1271:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column2.Text1,   "KeyPress",         THIS, "QmaxsLostFocus")
1272:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column3.Text1,   "KeyPress",          THIS, "TamKeyPress")
1273:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column4.Text1,   "KeyPress",          THIS, "CorKeyPress")
1274:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",          THIS, "DptKeyPress")
1275:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",         THIS, "GradeICol5LostFocus")
1276:     ENDPROC
1277: 
1278:     *--------------------------------------------------------------------------
1279:     * CarregarLista - Carrega cursor de produtos na Page1 e configura grid
1280:     *--------------------------------------------------------------------------
1281:     PROCEDURE CarregarLista()
1282:         LOCAL loc_lResultado, loc_oGrid
1283:         loc_lResultado = .F.
1284: 
1285:         TRY
1286:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1287:                 loc_lResultado = .T.
1288:             ELSE
1289:                 IF THIS.this_oBusinessObject.Buscar("")
1290:                     IF USED("cursor_4c_Dados")
1291:                         GO TOP IN cursor_4c_Dados
1292: 
1293:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1294: 
1295:                         *-- RecordSource FORA de WITH (Problema 36 - garante colunas existentes)
1296:                         loc_oGrid.ColumnCount = 6
1297:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1298: 
1299:                         *-- ControlSource de cada coluna
1300:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1301:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1302:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
1303:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ifors"
1304:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
1305:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.situas"
1306: 
1307:                         *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
1308:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1309:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1310:                         loc_oGrid.Column3.Header1.Caption = "Grupo"
1311:                         loc_oGrid.Column4.Header1.Caption = "Fornecedor"
1312:                         loc_oGrid.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
1313:                         loc_oGrid.Column6.Header1.Caption = "St"
1314: 
1315:                         THIS.FormatarGridLista(loc_oGrid)
1316:                         loc_lResultado = .T.
1317:                     ENDIF
1318:                 ENDIF
1319:             ENDIF
1320: 
1321:         CATCH TO loc_oErro

*-- Linhas 1327 a 1833:
1327:     ENDPROC
1328: 
1329:     *--------------------------------------------------------------------------
1330:     * TornarControlesVisiveis - Torna todos os controles de um container visiveis
1331:     * Itera recursivamente Pages e Controls
1332:     *--------------------------------------------------------------------------
1333:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1334:         LOCAL loc_nI, loc_oObjeto, loc_nP
1335: 
1336:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1337:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1338: 
1339:             IF VARTYPE(loc_oObjeto) = "O"
1340:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1341:                     loc_oObjeto.Visible = .T.
1342:                 ENDIF
1343: 
1344:                 *-- Tratar PageFrame: iterar Pages
1345:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1346:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1347:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1348:                     ENDFOR
1349:                 ENDIF
1350: 
1351:                 *-- Tratar containers com ControlCount
1352:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1353:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1354:                 ENDIF
1355:             ENDIF
1356:         ENDFOR
1357:     ENDPROC
1358: 
1359:     *--------------------------------------------------------------------------
1360:     * FormatarGridLista - Formata visual do grid da lista de produtos
1361:     *--------------------------------------------------------------------------
1362:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1363:         WITH par_oGrid
1364:             .FontName = "Tahoma"
1365:             .FontSize = 8
1366:         ENDWITH
1367:     ENDPROC
1368: 
1369:     *--------------------------------------------------------------------------
1370:     * Destroy - Libera recursos
1371:     *--------------------------------------------------------------------------
1372:     PROCEDURE Destroy()
1373:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1374:             THIS.this_oBusinessObject = .NULL.
1375:         ENDIF
1376: 
1377:         IF USED("cursor_4c_Dados")
1378:             USE IN cursor_4c_Dados
1379:         ENDIF
1380: 
1381:         IF USED("cursor_4c_Max")
1382:             USE IN cursor_4c_Max
1383:         ENDIF
1384: 
1385:         IF USED("cursor_4c_Copia")
1386:             USE IN cursor_4c_Copia
1387:         ENDIF
1388: 
1389:         DODEFAULT()
1390:     ENDPROC
1391: 
1392:     *--------------------------------------------------------------------------
1393:     * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
1394:     *--------------------------------------------------------------------------
1395:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1396:         TRY
1397:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1398:             IF par_nPagina = 1
1399:                 THIS.this_cModoAtual = "LISTA"
1400:             ELSE
1401:                 THIS.this_cModoAtual = "DADOS"
1402:                 THIS.AjustarCamposPorModo()
1403:             ENDIF
1404:         CATCH TO loc_oErro
1405:             MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *--------------------------------------------------------------------------
1410:     * BtnIncluirClick - Navega para Page2 em modo INSERIR
1411:     *--------------------------------------------------------------------------
1412:     PROCEDURE BtnIncluirClick()
1413:         TRY
1414:             THIS.this_cPCEscolha = "INSERIR"
1415:             THIS.LimparCampos()
1416:             THIS.CarregarGradeMaximos("")
1417:             THIS.AlternarPagina(2)
1418:         CATCH TO loc_oErro
1419:             MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message, "Erro")
1420:         ENDTRY
1421:     ENDPROC
1422: 
1423:     *--------------------------------------------------------------------------
1424:     * BtnVisualizarClick - Visualiza produto selecionado em Page2
1425:     *--------------------------------------------------------------------------
1426:     PROCEDURE BtnVisualizarClick()
1427:         LOCAL loc_lResultado, loc_cCpros
1428:         loc_lResultado = .F.
1429:         loc_cCpros     = ""
1430: 
1431:         TRY
1432:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1433:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1434:                 IF EMPTY(loc_cCpros)
1435:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1436:                 ELSE
1437:                     THIS.this_cPCPros    = PADR(loc_cCpros, 14)
1438:                     THIS.this_cPCEscolha = "CONSULTAR"
1439:                     THIS.CarregarInfoProduto(loc_cCpros)
1440:                     THIS.AlternarPagina(2)
1441:                     loc_lResultado = .T.
1442:                 ENDIF
1443:             ELSE
1444:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1445:             ENDIF
1446:         CATCH TO loc_oErro
1447:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1448:         ENDTRY
1449: 
1450:         RETURN loc_lResultado
1451:     ENDPROC
1452: 
1453:     *--------------------------------------------------------------------------
1454:     * BtnAlterarClick - Abre produto selecionado para edicao em Page2
1455:     *--------------------------------------------------------------------------
1456:     PROCEDURE BtnAlterarClick()
1457:         LOCAL loc_lResultado, loc_cCpros
1458:         loc_lResultado = .F.
1459:         loc_cCpros     = ""
1460: 
1461:         TRY
1462:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1463:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1464:                 IF EMPTY(loc_cCpros)
1465:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1466:                 ELSE
1467:                     THIS.this_cPCPros    = PADR(loc_cCpros, 14)
1468:                     THIS.this_cPCEscolha = "ALTERAR"
1469:                     THIS.CarregarInfoProduto(loc_cCpros)
1470:                     THIS.AlternarPagina(2)
1471:                     loc_lResultado = .T.
1472:                 ENDIF
1473:             ELSE
1474:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1475:             ENDIF
1476:         CATCH TO loc_oErro
1477:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message, "Erro")
1478:         ENDTRY
1479: 
1480:         RETURN loc_lResultado
1481:     ENDPROC
1482: 
1483:     *--------------------------------------------------------------------------
1484:     * BtnExcluirClick - Exclui todos os maximos do produto selecionado
1485:     *--------------------------------------------------------------------------
1486:     PROCEDURE BtnExcluirClick()
1487:         LOCAL loc_lResultado, loc_cCpros, loc_nResult
1488:         loc_lResultado = .F.
1489:         loc_cCpros     = ""
1490:         loc_nResult    = 0
1491: 
1492:         TRY
1493:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1494:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1495:                 IF EMPTY(loc_cCpros)
1496:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1497:                 ELSE
1498:                     IF MsgConfirma("Excluir todos os m" + CHR(225) + "ximos do produto " + loc_cCpros + "?", ;
1499:                             "Confirmar Exclus" + CHR(227) + "o")
1500:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1501:                             "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(PADR(loc_cCpros, 14)))
1502:                         IF loc_nResult > 0
1503:                             MsgInfo("M" + CHR(225) + "ximos exclu" + CHR(237) + "dos com sucesso.", "Sucesso")
1504:                             THIS.CarregarLista()
1505:                             loc_lResultado = .T.
1506:                         ELSE
1507:                             MsgErro("Erro ao excluir m" + CHR(225) + "ximos do produto.", "Erro")
1508:                         ENDIF
1509:                     ENDIF
1510:                 ENDIF
1511:             ELSE
1512:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1513:             ENDIF
1514:         CATCH TO loc_oErro
1515:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message, "Erro")
1516:         ENDTRY
1517: 
1518:         RETURN loc_lResultado
1519:     ENDPROC
1520: 
1521:     *--------------------------------------------------------------------------
1522:     * BtnBuscarClick - Navega para Page2 em modo PROCURAR
1523:     *--------------------------------------------------------------------------
1524:     PROCEDURE BtnBuscarClick()
1525:         TRY
1526:             THIS.this_cPCEscolha = "PROCURAR"
1527:             THIS.AlternarPagina(2)
1528:         CATCH TO loc_oErro
1529:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")
1530:         ENDTRY
1531:     ENDPROC
1532: 
1533:     *--------------------------------------------------------------------------
1534:     * BtnEncerrarClick - Fecha o formulario
1535:     *--------------------------------------------------------------------------
1536:     PROCEDURE BtnEncerrarClick()
1537:         TRY
1538:             THIS.Release()
1539:         CATCH TO loc_oErro
1540:             MsgErro("Erro em BtnEncerrarClick: " + loc_oErro.Message, "Erro")
1541:         ENDTRY
1542:     ENDPROC
1543: 
1544:     *--------------------------------------------------------------------------
1545:     * LimparCampos - Limpa campos de Page2 (primeira metade; Fase 6 completa restante)
1546:     *--------------------------------------------------------------------------
1547:     PROTECTED PROCEDURE LimparCampos()
1548:         LOCAL loc_oPagina
1549:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1550: 
1551:         TRY
1552:             loc_oPagina.txt_4c__produto.Value       = ""
1553:             loc_oPagina.txt_4c_Dpro.Value           = ""
1554:             loc_oPagina.txt_4c_Cgru.Value           = ""
1555:             loc_oPagina.txt_4c_Dgru.Value           = ""
1556:             loc_oPagina.obj_4c_Opc_situacao.Value   = 1
1557: 
1558:             loc_oPagina.txt_4c_Ifor.Value           = ""
1559:             loc_oPagina.txt_4c_Dfor.Value           = ""
1560:             loc_oPagina.txt_4c_Refs.Value           = ""
1561:             loc_oPagina.grd_4c_Gradei.RecordSource  = ""
1562: 
1563:             IF USED("cursor_4c_Max")
1564:                 USE IN cursor_4c_Max
1565:             ENDIF
1566: 
1567:             THIS.this_cPCPros    = ""
1568:             THIS.this_nTipoEstos = 0
1569:             THIS.this_lTemTam    = .F.
1570:             THIS.this_lTemCor    = .F.
1571:         CATCH TO loc_oErro
1572:             MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
1573:         ENDTRY
1574:     ENDPROC
1575: 
1576:     *--------------------------------------------------------------------------
1577:     * BtnCopiarClick - Exibe painel de copia entre empresas
1578:     *--------------------------------------------------------------------------
1579:     PROCEDURE BtnCopiarClick()
1580:         LOCAL loc_oPagina
1581:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1582: 
1583:         TRY
1584:             IF !THIS.this_lAcCopiar
1585:                 MsgAviso("Voc" + CHR(234) + " n" + CHR(227) + "o tem permiss" + CHR(227) + "o para copiar entre empresas.", "Acesso Negado")
1586:             ELSE
1587:                 loc_oPagina.grd_4c_Lista.Visible     = .F.
1588:                 loc_oPagina.cnt_4c_Botoes.Visible    = .F.
1589:                 loc_oPagina.cnt_4c_Saida.Visible     = .F.
1590:                 loc_oPagina.cmd_4c_BtnCopiar.Visible = .F.
1591: 
1592:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value   = ""
1593:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1594:                 loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value = ""
1595:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1596: 
1597:                 IF USED("cursor_4c_Copia")
1598:                     USE IN cursor_4c_Copia
1599:                 ENDIF
1600:                 loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
1601: 
1602:                 loc_oPagina.cnt_4c_Copia.Visible = .T.
1603:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.SetFocus()
1604:             ENDIF
1605:         CATCH TO loc_oErro
1606:             MsgErro("Erro em BtnCopiarClick: " + loc_oErro.Message, "Erro")
1607:         ENDTRY
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * EmpOsLostFocus - Habilita txt_4c_EmpDs quando EmpOs estiver preenchida
1612:     *--------------------------------------------------------------------------
1613:     PROCEDURE EmpOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1614:         LOCAL loc_oPagina, loc_cEmpOs
1615:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1616:         loc_cEmpOs  = ""
1617: 
1618:         TRY
1619:             loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1620:             IF EMPTY(loc_cEmpOs)
1621:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1622:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1623:             ELSE
1624:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .T.
1625:             ENDIF
1626:         CATCH TO loc_oErro
1627:             MsgErro("Erro em EmpOsLostFocus: " + loc_oErro.Message, "Erro")
1628:         ENDTRY
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * BtnProcessarCopiaClick - Processa e exibe itens disponiveis para copia
1633:     *--------------------------------------------------------------------------
1634:     PROCEDURE BtnProcessarCopiaClick()
1635:         LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs, loc_cProduto, loc_oGrid
1636:         loc_lResultado = .F.
1637:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1638:         loc_cEmpOs     = ""
1639:         loc_cEmpDs     = ""
1640:         loc_cProduto   = ""
1641: 
1642:         TRY
1643:             loc_cEmpOs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1644:             loc_cEmpDs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
1645:             loc_cProduto = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value)
1646: 
1647:             IF EMPTY(loc_cEmpOs)
1648:                 MsgAviso("Informe a Empresa Origem.", "Aten" + CHR(231) + CHR(227) + "o")
1649:             ELSE
1650:                 IF EMPTY(loc_cEmpDs)
1651:                     MsgAviso("Informe a Empresa Destino.", "Aten" + CHR(231) + CHR(227) + "o")
1652:                 ELSE
1653:                     IF THIS.this_oBusinessObject.CarregarCopiaParaCursor(PADR(loc_cProduto, 14), PADR(loc_cEmpOs, 3), PADR(loc_cEmpDs, 3))
1654:                         IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1655:                             loc_oGrid = loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
1656: 
1657:                             *-- RecordSource FORA de WITH (Problema 36)
1658:                             loc_oGrid.ColumnCount = 6
1659:                             loc_oGrid.RecordSource = "cursor_4c_Copia"
1660:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Copia.marcas"
1661:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Copia.cpros"
1662:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1663:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Copia.codtams"
1664:                             loc_oGrid.Column5.ControlSource = "cursor_4c_Copia.codcores"
1665:                             loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"
1666: 
1667:                             *-- Headers: re-setar apos RecordSource (VFP9 reseta)
1668:                             loc_oGrid.Column1.Header1.Caption = ""
1669:                             loc_oGrid.Column2.Header1.Caption = "Produto"
1670:                             loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1671:                             loc_oGrid.Column4.Header1.Caption = "Tam"
1672:                             loc_oGrid.Column5.Header1.Caption = "Cor"
1673:                             loc_oGrid.Column6.Header1.Caption = "Departamento"
1674: 
1675:                             GO TOP IN cursor_4c_Copia
1676:                             loc_lResultado = .T.
1677:                         ELSE
1678:                             MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")
1679:                         ENDIF
1680:                     ELSE
1681:                         MsgErro("Erro ao carregar dados: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1682:                     ENDIF
1683:                 ENDIF
1684:             ENDIF
1685:         CATCH TO loc_oErro
1686:             MsgErro("Erro em BtnProcessarCopiaClick: " + loc_oErro.Message, "Erro")
1687:         ENDTRY
1688: 
1689:         RETURN loc_lResultado
1690:     ENDPROC
1691: 
1692:     *--------------------------------------------------------------------------
1693:     * BtnConfirmarCopiaClick - Confirma e executa a copia entre empresas
1694:     *--------------------------------------------------------------------------
1695:     PROCEDURE BtnConfirmarCopiaClick()
1696:         LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs
1697:         loc_lResultado = .F.
1698:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1699:         loc_cEmpOs     = ""
1700:         loc_cEmpDs     = ""
1701: 
1702:         TRY
1703:             loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1704:             loc_cEmpDs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
1705: 
1706:             IF !USED("cursor_4c_Copia") OR RECCOUNT("cursor_4c_Copia") = 0
1707:                 MsgAviso("Processe os dados antes de confirmar a c" + CHR(243) + "pia.", "Aten" + CHR(231) + CHR(227) + "o")
1708:             ELSE
1709:                 IF MsgConfirma("Confirmar c" + CHR(243) + "pia dos m" + CHR(225) + "ximos de " + ;
1710:                         loc_cEmpOs + " para " + loc_cEmpDs + "?", "Confirmar C" + CHR(243) + "pia")
1711:                     IF THIS.this_oBusinessObject.CopiarMaxEntreEmpresas(PADR(loc_cEmpDs, 3), "cursor_4c_Copia")
1712:                         MsgInfo("C" + CHR(243) + "pia realizada com sucesso.", "Sucesso")
1713:                         THIS.BtnSairCopiaClick()
1714:                         loc_lResultado = .T.
1715:                     ELSE
1716:                         MsgErro("Erro ao copiar m" + CHR(225) + "ximos: " + ;
1717:                             THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1718:                     ENDIF
1719:                 ENDIF
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro("Erro em BtnConfirmarCopiaClick: " + loc_oErro.Message, "Erro")
1723:         ENDTRY
1724: 
1725:         RETURN loc_lResultado
1726:     ENDPROC
1727: 
1728:     *--------------------------------------------------------------------------
1729:     * BtnSairCopiaClick - Fecha painel de copia e restaura controles principais
1730:     *--------------------------------------------------------------------------
1731:     PROCEDURE BtnSairCopiaClick()
1732:         LOCAL loc_oPagina
1733:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1734: 
1735:         TRY
1736:             loc_oPagina.cnt_4c_Copia.Visible     = .F.
1737:             loc_oPagina.grd_4c_Lista.Visible      = .T.
1738:             loc_oPagina.cnt_4c_Botoes.Visible     = .T.
1739:             loc_oPagina.cnt_4c_Saida.Visible      = .T.
1740:             loc_oPagina.cmd_4c_BtnCopiar.Visible  = .T.
1741: 
1742:             IF USED("cursor_4c_Copia")
1743:                 USE IN cursor_4c_Copia
1744:             ENDIF
1745:         CATCH TO loc_oErro
1746:             MsgErro("Erro em BtnSairCopiaClick: " + loc_oErro.Message, "Erro")
1747:         ENDTRY
1748:     ENDPROC
1749: 
1750:     *--------------------------------------------------------------------------
1751:     * BtnMarcarCopiaClick - Marca todos os itens para copia
1752:     *--------------------------------------------------------------------------
1753:     PROCEDURE BtnMarcarCopiaClick()
1754:         TRY
1755:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1756:                 REPLACE ALL marcas WITH 1 IN cursor_4c_Copia
1757:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1758:             ENDIF
1759:         CATCH TO loc_oErro
1760:             MsgErro("Erro em BtnMarcarCopiaClick: " + loc_oErro.Message, "Erro")
1761:         ENDTRY
1762:     ENDPROC
1763: 
1764:     *--------------------------------------------------------------------------
1765:     * BtnDesmarcarCopiaClick - Desmarca todos os itens da copia
1766:     *--------------------------------------------------------------------------
1767:     PROCEDURE BtnDesmarcarCopiaClick()
1768:         TRY
1769:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1770:                 REPLACE ALL marcas WITH 0 IN cursor_4c_Copia
1771:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             MsgErro("Erro em BtnDesmarcarCopiaClick: " + loc_oErro.Message, "Erro")
1775:         ENDTRY
1776:     ENDPROC
1777: 
1778:     *--------------------------------------------------------------------------
1779:     * BtnSalvarClick - Confirma e salva os maximos do produto (Grupo_Salva.Confirmar)
1780:     * Logica: valida produto, limpa linhas vazias do cursor, salva via BO
1781:     *--------------------------------------------------------------------------
1782:     PROCEDURE BtnSalvarClick()
1783:         LOCAL loc_lResultado, loc_oPagina, loc_cCpros
1784:         loc_lResultado = .F.
1785:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1786:         loc_cCpros     = ""
1787: 
1788:         TRY
1789:             loc_cCpros = ALLTRIM(loc_oPagina.txt_4c__produto.Value)
1790: 
1791:             IF INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
1792:                 IF THIS.this_cPCEscolha = "INSERIR" AND EMPTY(loc_cCpros)
1793:                     MsgAviso("Produto inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
1794:                     loc_oPagina.txt_4c__produto.SetFocus()
1795:                 ELSE
1796:                     *-- Remover linhas com empresa vazia do cursor de maximos (limpeza antes de salvar)
1797:                     IF USED("cursor_4c_Max") AND RECCOUNT("cursor_4c_Max") > 0
1798:                         SELECT cursor_4c_Max
1799:                         GO TOP
1800:                         SCAN
1801:                             IF EMPTY(ALLTRIM(cursor_4c_Max.emps))
1802:                                 DELETE IN cursor_4c_Max
1803:                             ENDIF
1804:                         ENDSCAN
1805:                     ENDIF
1806: 
1807:                     IF THIS.this_oBusinessObject.SalvarGradeMax(PADR(loc_cCpros, 14))
1808:                         MsgInfo("M" + CHR(225) + "ximos salvos com sucesso.", "Sucesso")
1809:                         IF !EMPTY(THIS.this_cPExterno)
1810:                             THIS.Release()
1811:                         ELSE
1812:                             THIS.AlternarPagina(1)
1813:                             THIS.CarregarLista()
1814:                         ENDIF
1815:                         loc_lResultado = .T.
1816:                     ELSE
1817:                         MsgErro("Erro ao salvar m" + CHR(225) + "ximos: " + ;
1818:                             THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1819:                     ENDIF
1820:                 ENDIF
1821:             ELSE
1822:                 *-- Modo CONSULTAR/PROCURAR: apenas navegar de volta
1823:                 IF !EMPTY(THIS.this_cPExterno)
1824:                     THIS.Release()
1825:                 ELSE
1826:                     THIS.AlternarPagina(1)
1827:                     THIS.CarregarLista()
1828:                 ENDIF
1829:                 loc_lResultado = .T.
1830:             ENDIF
1831: 
1832:         CATCH TO loc_oErro
1833:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message, "Erro")

*-- Linhas 1839 a 1947:
1839:     *--------------------------------------------------------------------------
1840:     * BtnCancelarClick - Cancela edicao e volta para lista
1841:     *--------------------------------------------------------------------------
1842:     PROCEDURE BtnCancelarClick()
1843:         TRY
1844:             THIS.this_lPCancelar = .T.
1845:             IF !EMPTY(THIS.this_cPExterno)
1846:                 THIS.Release()
1847:             ELSE
1848:                 THIS.AlternarPagina(1)
1849:                 THIS.CarregarLista()
1850:             ENDIF
1851:         CATCH TO loc_oErro
1852:             MsgErro("Erro em BtnCancelarClick: " + loc_oErro.Message, "Erro")
1853:         ENDTRY
1854:     ENDPROC
1855: 
1856:     *--------------------------------------------------------------------------
1857:     * ProdutoKeyPress - Handler de teclado para txt_4c__produto
1858:     * F4 (115): abre FormBuscaAuxiliar para busca de produto na SigCdPro
1859:     *--------------------------------------------------------------------------
1860:     PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1861:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCpros
1862:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1863:         loc_cCpros  = ""
1864: 
1865:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1866:             RETURN
1867:         ENDIF
1868: 
1869:         IF par_nKeyCode = 115   && F4
1870:             TRY
1871:                 loc_cValor = ALLTRIM(loc_oPagina.txt_4c__produto.Value)
1872: 
1873:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1874:                     "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValor, "Produtos")
1875: 
1876:                 IF VARTYPE(loc_oBusca) = "O"
1877:                     IF !loc_oBusca.this_lAchouRegistro
1878:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1879:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1880:                         loc_oBusca.Show()
1881:                     ENDIF
1882: 
1883:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1884:                         loc_cCpros = ALLTRIM(cursor_4c_BuscaProd.cpros)
1885:                         loc_oPagina.txt_4c__produto.Value = loc_cCpros
1886:                         THIS.this_cPCPros = PADR(loc_cCpros, 14)
1887:                         THIS.CarregarInfoProduto(loc_cCpros)
1888:                     ENDIF
1889: 
1890:                     loc_oBusca.Release()
1891:                 ENDIF
1892: 
1893:                 IF USED("cursor_4c_BuscaProd")
1894:                     USE IN cursor_4c_BuscaProd
1895:                 ENDIF
1896:             CATCH TO loc_oErro
1897:                 MsgErro("Erro ao buscar produto: " + loc_oErro.Message, "Erro")
1898:             ENDTRY
1899:         ENDIF
1900:     ENDPROC
1901: 
1902:     *--------------------------------------------------------------------------
1903:     * CarregarInfoProduto - Carrega dados do produto na Page2
1904:     * Popula: cpros, dpros, cgrus, dgrus, situas, tiposestos (Fase 5)
1905:     *         ifors, rclis, reffs serao populados na Fase 6
1906:     *--------------------------------------------------------------------------
1907:     PROTECTED PROCEDURE CarregarInfoProduto(par_cCpros)
1908:         LOCAL loc_lResultado, loc_oPagina, loc_cSQL, loc_nResult
1909:         loc_lResultado = .F.
1910:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1911: 
1912:         IF EMPTY(ALLTRIM(par_cCpros))
1913:             RETURN .F.
1914:         ENDIF
1915: 
1916:         TRY
1917:             loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus," + ;
1918:                        " p.ifors, c.Rclis AS rclis, p.reffs, p.Situas, p.varias" + ;
1919:                        " FROM SigCdPro p" + ;
1920:                        " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
1921:                        " LEFT JOIN SigCdCli c ON c.Iclis = p.ifors" + ;
1922:                        " WHERE p.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
1923: 
1924:             IF USED("cursor_4c_ProdInfo")
1925:                 USE IN cursor_4c_ProdInfo
1926:             ENDIF
1927: 
1928:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")
1929: 
1930:             IF loc_nResult > 0 AND USED("cursor_4c_ProdInfo") AND RECCOUNT("cursor_4c_ProdInfo") > 0
1931:                 SELECT cursor_4c_ProdInfo
1932:                 GO TOP
1933: 
1934:                 loc_oPagina.txt_4c__produto.Value = ALLTRIM(cursor_4c_ProdInfo.cpros)
1935:                 loc_oPagina.txt_4c_Dpro.Value     = ALLTRIM(cursor_4c_ProdInfo.dpros)
1936:                 loc_oPagina.txt_4c_Cgru.Value     = ALLTRIM(cursor_4c_ProdInfo.cgrus)
1937:                 loc_oPagina.txt_4c_Dgru.Value     = TratarNulo(cursor_4c_ProdInfo.dgrus, "C")
1938: 
1939:                 THIS.this_nTipoEstos = NVL(cursor_4c_ProdInfo.varias, 0)
1940:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 1, 3)
1941:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 3)
1942: 
1943:                 loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(cursor_4c_ProdInfo.Situas, 1) = 2, 2, 1)
1944: 
1945:                 loc_oPagina.txt_4c_Ifor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.ifors, "C"))
1946:                 loc_oPagina.txt_4c_Dfor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.rclis, "C"))
1947:                 loc_oPagina.txt_4c_Refs.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.reffs, "C"))

*-- Linhas 1966 a 2036:
1966:     *--------------------------------------------------------------------------
1967:     * AjustarCamposPorModo - Habilita/desabilita campos e grade conforme modo
1968:     *--------------------------------------------------------------------------
1969:     PROCEDURE AjustarCamposPorModo()
1970:         LOCAL loc_oPagina, loc_lEditar
1971:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1972:         loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
1973: 
1974:         TRY
1975:             *-- Produto editavel apenas em INSERIR
1976:             loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR")
1977:             loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR", ;
1978:                 RGB(255, 255, 255), RGB(220, 220, 220))
1979: 
1980:             *-- Grade editavel em INSERIR/ALTERAR; botao excluir visivel idem
1981:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
1982:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
1983: 
1984:             *-- Colunas de variacao somente se produto tem a caracteristica
1985:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
1986:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
1987:         CATCH TO loc_oErro
1988:             MsgErro("Erro em AjustarCamposPorModo: " + loc_oErro.Message, "Erro")
1989:         ENDTRY
1990:     ENDPROC
1991: 
1992:     *--------------------------------------------------------------------------
1993:     * CarregarGradeMaximos - Carrega cursor_4c_Max e vincula a grd_4c_Gradei
1994:     * par_cCpros vazio = modo INSERIR (cursor vazio)
1995:     *--------------------------------------------------------------------------
1996:     PROTECTED PROCEDURE CarregarGradeMaximos(par_cCpros)
1997:         LOCAL loc_lResultado, loc_oPagina, loc_oGrid
1998:         loc_lResultado = .F.
1999:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
2000: 
2001:         TRY
2002:             IF !EMPTY(ALLTRIM(par_cCpros))
2003:                 IF THIS.this_oBusinessObject.CarregarMaxPorProduto(par_cCpros)
2004:                     loc_lResultado = .T.
2005:                 ELSE
2006:                     THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
2007:                 ENDIF
2008:             ELSE
2009:                 *-- Modo INSERIR: criar cursor vazio editavel
2010:                 IF USED("cursor_4c_Max")
2011:                     USE IN cursor_4c_Max
2012:                 ENDIF
2013:                 SET NULL ON
2014:                 CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
2015:                     codtams C(4), codcores C(4), deptos C(10), ordems C(1))
2016:                 SET NULL OFF
2017:                 loc_lResultado = .T.
2018:             ENDIF
2019: 
2020:             IF loc_lResultado AND USED("cursor_4c_Max")
2021:                 loc_oGrid = loc_oPagina.grd_4c_Gradei
2022: 
2023:                 *-- RecordSource e ControlSources FORA de WITH (Problema 36)
2024:                 loc_oGrid.ColumnCount = 5
2025:                 loc_oGrid.RecordSource               = "cursor_4c_Max"
2026:                 loc_oGrid.Column1.ControlSource      = "cursor_4c_Max.emps"
2027:                 loc_oGrid.Column2.ControlSource      = "cursor_4c_Max.qmaxs"
2028:                 loc_oGrid.Column3.ControlSource      = "cursor_4c_Max.codtams"
2029:                 loc_oGrid.Column4.ControlSource      = "cursor_4c_Max.codcores"
2030:                 loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"
2031: 
2032:                 *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
2033:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
2034:                 loc_oGrid.Column2.Header1.Caption = "Qtde.M" + CHR(225) + "x."
2035:                 loc_oGrid.Column3.Header1.Caption = "Tam."
2036:                 loc_oGrid.Column4.Header1.Caption = "Cor"

*-- Linhas 2055 a 2444:
2055:     *--------------------------------------------------------------------------
2056:     * GradeINovaLinha - Insere linha vazia no cursor_4c_Max e posiciona grade
2057:     *--------------------------------------------------------------------------
2058:     PROCEDURE GradeINovaLinha()
2059:         LOCAL loc_cEmps
2060:         loc_cEmps = ""
2061: 
2062:         TRY
2063:             IF !USED("cursor_4c_Max")
2064:                 RETURN
2065:             ENDIF
2066: 
2067:             loc_cEmps = IIF(!EMPTY(ALLTRIM(go_4c_Sistema.cCodEmpresa)), ;
2068:                 PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3), SPACE(3))
2069: 
2070:             INSERT INTO cursor_4c_Max ;
2071:                 (cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems) ;
2072:                 VALUES (SPACE(20), loc_cEmps, 0, SPACE(4), SPACE(4), SPACE(10), SPACE(1))
2073: 
2074:             GO BOTTOM IN cursor_4c_Max
2075:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2076:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.SetFocus()
2077:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.DoScroll(2)
2078:         CATCH TO loc_oErro
2079:             MsgErro("Erro em GradeINovaLinha: " + loc_oErro.Message, "Erro")
2080:         ENDTRY
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     * GradeIAfterRowColChange - Ajusta colunas de variacao; adiciona linha ao final
2085:     *--------------------------------------------------------------------------
2086:     PROCEDURE GradeIAfterRowColChange(par_nColIndex)
2087:         TRY
2088:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
2089:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
2090: 
2091:             IF USED("cursor_4c_Max") AND INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
2092:                 SELECT cursor_4c_Max
2093:                 IF EOF()
2094:                     THIS.GradeINovaLinha()
2095:                 ENDIF
2096:             ENDIF
2097:         CATCH TO loc_oErro
2098:             MsgErro("Erro em GradeIAfterRowColChange: " + loc_oErro.Message, "Erro")
2099:         ENDTRY
2100:     ENDPROC
2101: 
2102:     *--------------------------------------------------------------------------
2103:     * QmaxsLostFocus - Valida quantidade maxima (nao pode ser negativa)
2104:     *--------------------------------------------------------------------------
2105:     PROCEDURE QmaxsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2106:         TRY
2107:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2108:                 SELECT cursor_4c_Max
2109:                 IF NVL(cursor_4c_Max.qmaxs, 0) < 0
2110:                     REPLACE cursor_4c_Max.qmaxs WITH 0
2111:                 ENDIF
2112:             ENDIF
2113:         CATCH TO loc_oErro
2114:             MsgErro("Erro em QmaxsLostFocus: " + loc_oErro.Message, "Erro")
2115:         ENDTRY
2116:     ENDPROC
2117: 
2118:     *--------------------------------------------------------------------------
2119:     * TamKeyPress - F4 abre lookup SigCdTam para coluna de tamanho
2120:     *--------------------------------------------------------------------------
2121:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2122:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2123:             RETURN
2124:         ENDIF
2125:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2126:             THIS.AbrirLookupTamanho()
2127:         ENDIF
2128:     ENDPROC
2129: 
2130:     *--------------------------------------------------------------------------
2131:     * AbrirLookupTamanho - FormBuscaAuxiliar para SigCdTam (ctams/dtams)
2132:     *--------------------------------------------------------------------------
2133:     PROCEDURE AbrirLookupTamanho()
2134:         LOCAL loc_oBusca, loc_cValor
2135:         loc_cValor = ""
2136: 
2137:         TRY
2138:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2139:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codtams, "C"))
2140:             ENDIF
2141: 
2142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2143:                 "SigCdTam", "cursor_4c_BuscaTam", "ctams", loc_cValor, "Tamanhos")
2144: 
2145:             IF VARTYPE(loc_oBusca) = "O"
2146:                 IF !loc_oBusca.this_lAchouRegistro
2147:                     loc_oBusca.mAddColuna("ctams", "", "C" + CHR(243) + "digo")
2148:                     loc_oBusca.mAddColuna("dtams", "", "Descri" + CHR(231) + CHR(227) + "o")
2149:                     loc_oBusca.Show()
2150:                 ENDIF
2151: 
2152:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2153:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2154:                         SELECT cursor_4c_Max
2155:                         REPLACE codtams WITH PADR(ALLTRIM(cursor_4c_BuscaTam.ctams), 4)
2156:                     ENDIF
2157:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2158:                 ENDIF
2159: 
2160:                 loc_oBusca.Release()
2161:             ENDIF
2162: 
2163:             IF USED("cursor_4c_BuscaTam")
2164:                 USE IN cursor_4c_BuscaTam
2165:             ENDIF
2166:         CATCH TO loc_oErro
2167:             MsgErro("Erro ao buscar tamanho: " + loc_oErro.Message, "Erro")
2168:         ENDTRY
2169:     ENDPROC
2170: 
2171:     *--------------------------------------------------------------------------
2172:     * CorKeyPress - F4 abre lookup SigCdCor para coluna de cor
2173:     *--------------------------------------------------------------------------
2174:     PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2175:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2176:             RETURN
2177:         ENDIF
2178:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2179:             THIS.AbrirLookupCor()
2180:         ENDIF
2181:     ENDPROC
2182: 
2183:     *--------------------------------------------------------------------------
2184:     * AbrirLookupCor - FormBuscaAuxiliar para SigCdCor (ccors/dcors)
2185:     *--------------------------------------------------------------------------
2186:     PROCEDURE AbrirLookupCor()
2187:         LOCAL loc_oBusca, loc_cValor
2188:         loc_cValor = ""
2189: 
2190:         TRY
2191:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2192:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codcores, "C"))
2193:             ENDIF
2194: 
2195:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2196:                 "SigCdCor", "cursor_4c_BuscaCor", "ccors", loc_cValor, "Cores")
2197: 
2198:             IF VARTYPE(loc_oBusca) = "O"
2199:                 IF !loc_oBusca.this_lAchouRegistro
2200:                     loc_oBusca.mAddColuna("ccors", "", "C" + CHR(243) + "digo")
2201:                     loc_oBusca.mAddColuna("dcors", "", "Descri" + CHR(231) + CHR(227) + "o")
2202:                     loc_oBusca.Show()
2203:                 ENDIF
2204: 
2205:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2206:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2207:                         SELECT cursor_4c_Max
2208:                         REPLACE codcores WITH PADR(ALLTRIM(cursor_4c_BuscaCor.ccors), 4)
2209:                     ENDIF
2210:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2211:                 ENDIF
2212: 
2213:                 loc_oBusca.Release()
2214:             ENDIF
2215: 
2216:             IF USED("cursor_4c_BuscaCor")
2217:                 USE IN cursor_4c_BuscaCor
2218:             ENDIF
2219:         CATCH TO loc_oErro
2220:             MsgErro("Erro ao buscar cor: " + loc_oErro.Message, "Erro")
2221:         ENDTRY
2222:     ENDPROC
2223: 
2224:     *--------------------------------------------------------------------------
2225:     * DptKeyPress - F4 abre lookup SigCdDpt para coluna de departamento
2226:     *--------------------------------------------------------------------------
2227:     PROCEDURE DptKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2228:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2229:             RETURN
2230:         ENDIF
2231:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2232:             THIS.AbrirLookupDepto()
2233:         ENDIF
2234:     ENDPROC
2235: 
2236:     *--------------------------------------------------------------------------
2237:     * AbrirLookupDepto - FormBuscaAuxiliar para SigCdDpt (codigos/descricaos)
2238:     *--------------------------------------------------------------------------
2239:     PROCEDURE AbrirLookupDepto()
2240:         LOCAL loc_oBusca, loc_cValor
2241:         loc_cValor = ""
2242: 
2243:         TRY
2244:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2245:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.deptos, "C"))
2246:             ENDIF
2247: 
2248:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2249:                 "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValor, "Departamentos")
2250: 
2251:             IF VARTYPE(loc_oBusca) = "O"
2252:                 IF !loc_oBusca.this_lAchouRegistro
2253:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2254:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2255:                     loc_oBusca.Show()
2256:                 ENDIF
2257: 
2258:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2259:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2260:                         SELECT cursor_4c_Max
2261:                         REPLACE deptos WITH PADR(ALLTRIM(cursor_4c_BuscaDpt.codigos), 10)
2262:                     ENDIF
2263:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2264:                 ENDIF
2265: 
2266:                 loc_oBusca.Release()
2267:             ENDIF
2268: 
2269:             IF USED("cursor_4c_BuscaDpt")
2270:                 USE IN cursor_4c_BuscaDpt
2271:             ENDIF
2272:         CATCH TO loc_oErro
2273:             MsgErro("Erro ao buscar departamento: " + loc_oErro.Message, "Erro")
2274:         ENDTRY
2275:     ENDPROC
2276: 
2277:     *--------------------------------------------------------------------------
2278:     * GradeICol5LostFocus - Refresh da grade ao sair da coluna departamento
2279:     *--------------------------------------------------------------------------
2280:     PROCEDURE GradeICol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2281:         TRY
2282:             IF USED("cursor_4c_Max")
2283:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2284:             ENDIF
2285:         CATCH TO loc_oErro
2286:             MsgErro("Erro em GradeICol5LostFocus: " + loc_oErro.Message, "Erro")
2287:         ENDTRY
2288:     ENDPROC
2289: 
2290:     *--------------------------------------------------------------------------
2291:     * BtnExcluirGradeClick - Exclui todas as linhas da empresa corrente no cursor
2292:     *--------------------------------------------------------------------------
2293:     PROCEDURE BtnExcluirGradeClick()
2294:         LOCAL loc_cEmps
2295:         loc_cEmps = ""
2296: 
2297:         TRY
2298:             IF !USED("cursor_4c_Max") OR RECCOUNT("cursor_4c_Max") = 0
2299:                 RETURN
2300:             ENDIF
2301: 
2302:             IF !MsgConfirma("Excluir todos os m" + CHR(225) + "ximos desta empresa?", ;
2303:                     "Confirmar Exclus" + CHR(227) + "o")
2304:                 RETURN
2305:             ENDIF
2306: 
2307:             SELECT cursor_4c_Max
2308:             IF !EOF() AND !BOF()
2309:                 loc_cEmps = ALLTRIM(TratarNulo(cursor_4c_Max.emps, "C"))
2310:             ENDIF
2311: 
2312:             IF EMPTY(loc_cEmps)
2313:                 loc_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2314:             ENDIF
2315: 
2316:             SELECT cursor_4c_Max
2317:             GO TOP
2318:             SCAN
2319:                 IF ALLTRIM(cursor_4c_Max.emps) = loc_cEmps
2320:                     DELETE
2321:                 ENDIF
2322:             ENDSCAN
2323:             PACK
2324: 
2325:             IF RECCOUNT("cursor_4c_Max") = 0
2326:                 THIS.GradeINovaLinha()
2327:             ENDIF
2328: 
2329:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2330:         CATCH TO loc_oErro
2331:             MsgErro("Erro em BtnExcluirGradeClick: " + loc_oErro.Message, "Erro")
2332:         ENDTRY
2333:     ENDPROC
2334: 
2335:     *--------------------------------------------------------------------------
2336:     * FormParaBO - Transfere valores do Form para o Business Object
2337:     * Campos de display (dpros, dgrus, rclis) sao read-only; apenas cpros e
2338:     * derivados sao transferidos porque o BO os usa em SalvarGradeMax
2339:     *--------------------------------------------------------------------------
2340:     PROTECTED PROCEDURE FormParaBO()
2341:         LOCAL loc_oPagina
2342:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2343: 
2344:         TRY
2345:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2346:                 THIS.this_oBusinessObject.this_cCPros  = PADR(ALLTRIM(loc_oPagina.txt_4c__produto.Value), 14)
2347:                 THIS.this_oBusinessObject.this_cDPros  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
2348:                 THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(loc_oPagina.txt_4c_Cgru.Value)
2349:                 THIS.this_oBusinessObject.this_cDGrus  = ALLTRIM(loc_oPagina.txt_4c_Dgru.Value)
2350:                 THIS.this_oBusinessObject.this_cIFors  = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
2351:                 THIS.this_oBusinessObject.this_cRClis  = ALLTRIM(loc_oPagina.txt_4c_Dfor.Value)
2352:                 THIS.this_oBusinessObject.this_cReffs  = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
2353:                 THIS.this_oBusinessObject.this_nSituas = loc_oPagina.obj_4c_Opc_situacao.Value
2354:             ENDIF
2355:         CATCH TO loc_oErro
2356:             MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
2357:         ENDTRY
2358:     ENDPROC
2359: 
2360:     *--------------------------------------------------------------------------
2361:     * BOParaForm - Transfere valores do Business Object para o Form
2362:     * Popula campos de display da Page2 a partir das propriedades do BO
2363:     *--------------------------------------------------------------------------
2364:     PROTECTED PROCEDURE BOParaForm()
2365:         LOCAL loc_oPagina
2366:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2367: 
2368:         TRY
2369:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2370:                 loc_oPagina.txt_4c__produto.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCPros)
2371:                 loc_oPagina.txt_4c_Dpro.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDPros)
2372:                 loc_oPagina.txt_4c_Cgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cCGrus)
2373:                 loc_oPagina.txt_4c_Dgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDGrus)
2374:                 loc_oPagina.txt_4c_Ifor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cIFors)
2375:                 loc_oPagina.txt_4c_Dfor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cRClis)
2376:                 loc_oPagina.txt_4c_Refs.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cReffs)
2377:                 loc_oPagina.obj_4c_Opc_situacao.Value   = IIF(THIS.this_oBusinessObject.this_nSituas = 2, 2, 1)
2378: 
2379:                 THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
2380:                 THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
2381:                 THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
2382:             ENDIF
2383:         CATCH TO loc_oErro
2384:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
2385:         ENDTRY
2386:     ENDPROC
2387: 
2388:     *--------------------------------------------------------------------------
2389:     * HabilitarCampos - Habilita ou desabilita controles editaveis da Page2
2390:     * par_lHabilitar=.T. habilita conforme modo; .F. bloqueia tudo (VISUALIZAR)
2391:     *--------------------------------------------------------------------------
2392:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2393:         LOCAL loc_oPagina, loc_lEditar
2394:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2395:         loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR") AND par_lHabilitar
2396: 
2397:         TRY
2398:             *-- Produto: editavel apenas em INSERIR
2399:             loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar)
2400:             loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar, ;
2401:                 RGB(255, 255, 255), RGB(220, 220, 220))
2402: 
2403:             *-- Grade: editavel apenas em INSERIR/ALTERAR
2404:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
2405:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
2406: 
2407:             *-- Colunas de variacao: habilitadas conforme caracteristica do produto
2408:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam OR !loc_lEditar
2409:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor OR !loc_lEditar
2410: 
2411:             *-- Botoes de acao Page2
2412:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
2413:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
2414:         CATCH TO loc_oErro
2415:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
2416:         ENDTRY
2417:     ENDPROC
2418: 
2419:     *--------------------------------------------------------------------------
2420:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1 (lista)
2421:     * Chamado apos CarregarLista para refletir se ha registros selecionaveis
2422:     *--------------------------------------------------------------------------
2423:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2424:         LOCAL loc_oPg1, loc_lTemSelecao
2425:         loc_oPg1        = THIS.pgf_4c_Paginas.Page1
2426:         loc_lTemSelecao = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2427: 
2428:         TRY
2429:             WITH loc_oPg1.cnt_4c_Botoes
2430:                 .cmd_4c_Inserir.Enabled    = .T.
2431:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
2432:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
2433:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
2434:                 .cmd_4c_Buscar.Enabled     = .T.
2435:                 .Visible     = .T.
2436:             ENDWITH
2437: 
2438:             loc_oPg1.cmd_4c_BtnCopiar.Enabled = THIS.this_lAcCopiar
2439:         CATCH TO loc_oErro
2440:             MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
2441:         ENDTRY
2442:     ENDPROC
2443: 
2444: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " AND d.deptos = o.deptos" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

