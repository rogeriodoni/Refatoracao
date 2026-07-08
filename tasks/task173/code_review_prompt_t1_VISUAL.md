# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [LAYOUT-POSITION] Controle 'btnSelecionar' (parent: SIGPRDSC): Left original=744 vs migrado 'cmd_4c_BtnSelecionar' Left=925 (diff=181px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnSair' (parent: SIGPRDSC): Left original=725 vs migrado 'cmd_4c_BtnSair' Left=925 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnAtualizar' (parent: SIGPRDSC): Left original=650 vs migrado 'cmd_4c_BtnAtualizar' Left=850 (diff=200px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1299 linhas total):

*-- Linhas 49 a 57:
49:             SET CENTURY ON
50: 
51:             *-- Caption com acentos via CHR() (literal acentuado proibido em .prg)
52:             THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
53: 
54:             *-- Criar Business Object
55:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
56:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
57:                 MsgErro("Falha ao criar SigPrDscBO", "Erro")

*-- Linhas 84 a 93:
84: 
85:             *-- Configurar controles visuais
86:             THIS.ConfigurarCabecalho()
87:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89:             THIS.ConfigurarPaginaLista()
90:             THIS.ConfigurarPaginaDados()
91:             THIS.VincularEventos()
92: 
93:             THIS.TornarControlesVisiveis()

*-- Linhas 111 a 119:
111:         LOCAL loc_cImgFundo
112: 
113:         *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
114:         THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"
115: 
116:         *-- Imagem de fundo do framework (new_background.jpg)
117:         loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
118:         IF FILE(loc_cImgFundo)
119:             THIS.Picture = loc_cImgFundo

*-- Linhas 145 a 191:
145: 
146:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
147:         WITH THIS.cnt_4c_Cabecalho
148:             .Top         = 0
149:             .Left        = 0
150:             .Width       = THIS.Width
151:             .Height      = 80
152:             .BorderWidth = 0
153:             .BackStyle   = 1
154:             .BackColor   = RGB(100,100,100)
155:             .Visible     = .T.
156:             .AddObject("lbl_4c_Sombra", "Label")
157:             WITH .lbl_4c_Sombra
158:                 .AutoSize      = .F.
159:                 .FontBold      = .T.
160:                 .FontName      = "Tahoma"
161:                 .FontSize      = 18
162:                 .FontUnderline = .F.
163:                 .WordWrap      = .T.
164:                 .Alignment     = 0
165:                 .BackStyle     = 0
166:                 .Caption       = loc_cCaption
167:                 .Height        = 40
168:                 .Left          = 10
169:                 .Top           = 18
170:                 .Width         = THIS.Width
171:                 .ForeColor     = RGB(0,0,0)
172:                 .Visible       = .T.
173:             ENDWITH
174:             .AddObject("lbl_4c_Titulo", "Label")
175:             WITH .lbl_4c_Titulo
176:                 .AutoSize   = .F.
177:                 .FontBold   = .T.
178:                 .FontName   = "Tahoma"
179:                 .FontSize   = 18
180:                 .WordWrap   = .T.
181:                 .Alignment  = 0
182:                 .BackStyle  = 0
183:                 .Caption    = loc_cCaption
184:                 .Height     = 46
185:                 .Left       = 10
186:                 .Top        = 17
187:                 .Width      = THIS.Width
188:                 .ForeColor  = RGB(255,255,255)
189:                 .Visible    = .T.
190:             ENDWITH
191:         ENDWITH

*-- Linhas 197 a 269:
197:         LOCAL loc_cIcones
198:         loc_cIcones = gc_4c_CaminhoIcones
199: 
200:         *-- Botao Atualizar: original Left=650 em 800px -> escala 1.25 -> 850 em 1000px
201:         *-- Inicia desabilitado; habilitado apos usuario Selecionar produtos
202:         THIS.AddObject("cmd_4c_BtnAtualizar", "CommandButton")
203:         WITH THIS.cmd_4c_BtnAtualizar
204:             .Top             = 3
205:             .Left            = 850
206:             .Height          = 75
207:             .Width           = 75
208:             .Picture         = loc_cIcones + "geral_relogio_60.jpg"
209:             .DisabledPicture = loc_cIcones + "geral_relogio_60.jpg"
210:             .Caption         = "\<Atualizar"
211:             .Themes          = .T.
212:             .Enabled         = .F.
213:             .FontName        = "Tahoma"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontSize        = 8
217:             .ForeColor       = RGB(90,90,90)
218:             .BackColor       = RGB(255,255,255)
219:             .SpecialEffect   = 0
220:             .PicturePosition = 13
221:             .MousePointer    = 15
222:             .WordWrap        = .T.
223:             .Visible         = .T.
224:         ENDWITH
225: 
226:         *-- Botao Encerrar (Cancel=.T. mapeia tecla ESC): original Left=725 em 800px -> 925 em 1000px
227:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
228:         WITH THIS.cmd_4c_BtnSair
229:             .Top             = 3
230:             .Left            = 925
231:             .Height          = 75
232:             .Width           = 75
233:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
234:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
235:             .Cancel          = .T.
236:             .Caption         = "Encerrar"
237:             .Themes          = .T.
238:             .FontName        = "Tahoma"
239:             .FontBold        = .T.
240:             .FontItalic      = .T.
241:             .FontSize        = 8
242:             .ForeColor       = RGB(90,90,90)
243:             .BackColor       = RGB(255,255,255)
244:             .SpecialEffect   = 0
245:             .PicturePosition = 13
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .Visible         = .T.
249:         ENDWITH
250: 
251:         *-- Botao Selecionar: original Left=744, Top=116 -> Left=925, Top=116
252:         *-- Icone-only (Caption=""): Themes=.T. obrigatorio para renderizar Picture
253:         THIS.AddObject("cmd_4c_BtnSelecionar", "CommandButton")
254:         WITH THIS.cmd_4c_BtnSelecionar
255:             .Top             = 116
256:             .Left            = 925
257:             .Height          = 40
258:             .Width           = 75
259:             .Picture         = loc_cIcones + "geral_procura_60.jpg"
260:             .DisabledPicture = loc_cIcones + "geral_procura_60.jpg"
261:             .Caption         = ""
262:             .ToolTipText     = "Selecionar"
263:             .Themes          = .T.
264:             .FontName        = "Tahoma"
265:             .FontBold        = .T.
266:             .FontItalic      = .T.
267:             .FontSize        = 8
268:             .ForeColor       = RGB(90,90,90)
269:             .BackColor       = RGB(255,255,255)

*-- Linhas 329 a 344:
329:     PROTECTED PROCEDURE ConfigurarFiltros()
330:     *==========================================================================
331:         *-- Label "Produtos de :" - original Left=155, Top=138, escala 1.25
332:         THIS.AddObject("lbl_4c_ProdutosDe", "Label")
333:         WITH THIS.lbl_4c_ProdutosDe
334:             .AutoSize  = .F.
335:             .Width     = 90
336:             .Height    = 20
337:             .Left      = 194
338:             .Top       = 140
339:             .Caption   = "Produtos de :"
340:             .FontBold  = .T.
341:             .FontName  = "Tahoma"
342:             .FontSize  = 8
343:             .ForeColor = RGB(90,90,90)
344:             .BackStyle = 0

*-- Linhas 350 a 376:
350:         WITH THIS.txt_4c_CProsI
351:             .FontName      = "Tahoma"
352:             .FontSize      = 8
353:             .Left          = 291
354:             .Top           = 135
355:             .Width         = 135
356:             .Height        = 24
357:             .MaxLength     = 14
358:             .Value         = ""
359:             .SelectOnEntry = .T.
360:             .Visible       = .T.
361:         ENDWITH
362: 
363:         *-- Label "ate" - original Left=345, Top=138
364:         THIS.AddObject("lbl_4c_Ate", "Label")
365:         WITH THIS.lbl_4c_Ate
366:             .AutoSize  = .F.
367:             .Width     = 30
368:             .Height    = 20
369:             .Left      = 431
370:             .Top       = 140
371:             .Caption   = "at" + CHR(233)
372:             .FontBold  = .T.
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .ForeColor = RGB(90,90,90)
376:             .BackStyle = 0

*-- Linhas 382 a 408:
382:         WITH THIS.txt_4c_CProsF
383:             .FontName      = "Tahoma"
384:             .FontSize      = 8
385:             .Left          = 463
386:             .Top           = 135
387:             .Width         = 135
388:             .Height        = 24
389:             .MaxLength     = 14
390:             .Value         = ""
391:             .SelectOnEntry = .T.
392:             .Visible       = .T.
393:         ENDWITH
394: 
395:         *-- Label "Grupo de Produto :" - original Left=505, Top=138
396:         THIS.AddObject("lbl_4c_Grupo", "Label")
397:         WITH THIS.lbl_4c_Grupo
398:             .AutoSize  = .F.
399:             .Width     = 130
400:             .Height    = 20
401:             .Left      = 631
402:             .Top       = 140
403:             .Caption   = "Grupo de Produto :"
404:             .FontBold  = .T.
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .ForeColor = RGB(90,90,90)
408:             .BackStyle = 0

*-- Linhas 414 a 423:
414:         WITH THIS.txt_4c_CGrus
415:             .FontName      = "Tahoma"
416:             .FontSize      = 8
417:             .Left          = 768
418:             .Top           = 135
419:             .Width         = 39
420:             .Height        = 24
421:             .MaxLength     = 3
422:             .Value         = ""
423:             .SelectOnEntry = .T.

*-- Linhas 430 a 439:
430:     *==========================================================================
431:         THIS.AddObject("grd_4c_Dados", "Grid")
432:         WITH THIS.grd_4c_Dados
433:             .Top                = 164
434:             .Left               = 19
435:             .Width              = 961
436:             .Height             = 343
437:             .ColumnCount        = 3
438:             .FontSize           = 8
439:             .FontName           = "Verdana"

*-- Linhas 460 a 494:
460:                 .ControlSource = "cursor_4c_Produtos.CPros"
461:                 .ReadOnly      = .T.
462:                 WITH .Header1
463:                     .Caption   = "C" + CHR(243) + "digo"
464:                     .FontName  = "Tahoma"
465:                     .FontSize  = 8
466:                     .Alignment = 2
467:                 ENDWITH
468:             ENDWITH
469: 
470:             WITH .Column2
471:                 .Width         = 363
472:                 .FontSize      = 8
473:                 .ControlSource = "cursor_4c_Produtos.Portugues"
474:                 .ReadOnly      = .T.
475:                 WITH .Header1
476:                     .Caption   = "Portugu" + CHR(234) + "s"
477:                     .FontName  = "Tahoma"
478:                     .FontSize  = 8
479:                     .Alignment = 2
480:                 ENDWITH
481:             ENDWITH
482: 
483:             WITH .Column3
484:                 .Width         = 427
485:                 .FontSize      = 8
486:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
487:                 .ReadOnly      = .T.
488:                 WITH .Header1
489:                     .Caption   = "Traduzido"
490:                     .FontName  = "Tahoma"
491:                     .FontSize  = 8
492:                     .Alignment = 2
493:                 ENDWITH
494:             ENDWITH

*-- Linhas 504 a 526:
504:         BINDEVENT(THIS.txt_4c_CProsI,        "DblClick", THIS, "TxtCProsIDblClick")
505:         BINDEVENT(THIS.txt_4c_CProsF,        "KeyPress", THIS, "TxtCProsFKeyPress")
506:         BINDEVENT(THIS.txt_4c_CProsF,        "DblClick", THIS, "TxtCProsFDblClick")
507:         BINDEVENT(THIS.txt_4c_CGrus,         "KeyPress", THIS, "TxtCGrusKeyPress")
508:         BINDEVENT(THIS.txt_4c_CGrus,         "DblClick", THIS, "TxtCGrusDblClick")
509:         BINDEVENT(THIS.cmd_4c_BtnSelecionar, "Click",    THIS, "BtnSelecionarClick")
510:         BINDEVENT(THIS.cmd_4c_BtnAtualizar,  "Click",    THIS, "BtnAtualizarClick")
511:         BINDEVENT(THIS.cmd_4c_BtnSair,       "Click",    THIS, "BtnSairClick")
512:     ENDPROC
513: 
514:     *==========================================================================
515:     PROCEDURE TxtCProsIKeyPress
516:     *==========================================================================
517:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
518:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
519:             RETURN
520:         ENDIF
521:         THIS.AbrirBuscaProduto("CProsI")
522:     ENDPROC
523: 
524:     *==========================================================================
525:     PROCEDURE TxtCProsFKeyPress
526:     *==========================================================================

*-- Linhas 815 a 835:
815:     ENDPROC
816: 
817:     *==========================================================================
818:     PROCEDURE BtnSelecionarClick()
819:     *==========================================================================
820:         THIS.cmd_4c_BtnAtualizar.Enabled = .F.
821: 
822:         IF EMPTY(THIS.txt_4c_CProsI.Value) AND ;
823:            EMPTY(THIS.txt_4c_CProsF.Value) AND ;
824:            EMPTY(THIS.txt_4c_CGrus.Value)
825:             MsgAviso("Nenhum filtro foi informado.", ;
826:                      "Aten" + CHR(231) + CHR(227) + "o")
827:             THIS.txt_4c_CProsI.SetFocus
828:             RETURN
829:         ENDIF
830: 
831:         IF !EMPTY(THIS.txt_4c_CProsI.Value) AND EMPTY(THIS.txt_4c_CProsF.Value)
832:             THIS.txt_4c_CProsF.Value = THIS.txt_4c_CProsI.Value
833:             THIS.txt_4c_CProsF.Refresh
834:         ENDIF
835: 

*-- Linhas 876 a 896:
876:         IF USED("cursor_4c_Produtos")
877:             ZAP IN cursor_4c_Produtos
878:         ENDIF
879: 
880:         THIS.AtualizarEstadoFiltros()
881:         THIS.cmd_4c_BtnAtualizar.Enabled = .F.
882:         THIS.txt_4c_CProsI.SetFocus
883:     ENDPROC
884: 
885:     *==========================================================================
886:     PROCEDURE BtnAlterarClick()
887:     *  OPERACIONAL: a "alteracao" das descricoes eh persistida via Atualizar
888:     *  (Gravacao). Delega para o botao Atualizar quando ha dados carregados.
889:     *==========================================================================
890:         IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
891:             MsgAviso("Selecione produtos com o bot" + CHR(227) + "o Selecionar " + ;
892:                      "antes de alterar as descri" + CHR(231) + CHR(245) + "es.", ;
893:                      "Aten" + CHR(231) + CHR(227) + "o")
894:             RETURN
895:         ENDIF
896: 

*-- Linhas 919 a 939:
919:         IF MsgConfirma("Descartar as altera" + CHR(231) + CHR(245) + "es pendentes " + ;
920:                        "e limpar a lista de produtos?", ;
921:                        "Confirma" + CHR(231) + CHR(227) + "o")
922:             ZAP IN cursor_4c_Produtos
923:             THIS.grd_4c_Dados.Refresh
924:             THIS.cmd_4c_BtnAtualizar.Enabled = .F.
925:         ENDIF
926:     ENDPROC
927: 
928:     *==========================================================================
929:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
930:     *  Compatibilidade de API: form OPERACIONAL usa layout flat (sem PageFrame)
931:     *==========================================================================
932:         RETURN
933:     ENDPROC
934: 
935:     *==========================================================================
936:     PROCEDURE BtnBuscarClick()
937:     *  Compatibilidade de API: delega para BtnSelecionarClick (selecionar produtos)
938:     *==========================================================================
939:         THIS.BtnSelecionarClick()

*-- Linhas 959 a 979:
959:     *==========================================================================
960:         IF USED("cursor_4c_Produtos")
961:             ZAP IN cursor_4c_Produtos
962:         ENDIF
963:         THIS.LimparCampos()
964:         THIS.cmd_4c_BtnAtualizar.Enabled = .F.
965:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
966:             THIS.grd_4c_Dados.Refresh
967:         ENDIF
968:     ENDPROC
969: 
970:     *==========================================================================
971:     PROCEDURE FormParaBO()
972:     *  Transfere valores dos campos de filtro para as propriedades do BO
973:     *==========================================================================
974:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
975:             RETURN
976:         ENDIF
977:         THIS.this_oBusinessObject.this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
978:         THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
979:         THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)

*-- Linhas 1040 a 1060:
1040:     *==========================================================================
1041:         LOCAL loc_lTemProdutos
1042:         loc_lTemProdutos = USED("cursor_4c_Produtos") AND ;
1043:                            RECCOUNT("cursor_4c_Produtos") > 0
1044: 
1045:         THIS.cmd_4c_BtnAtualizar.Enabled = loc_lTemProdutos
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     PROTECTED PROCEDURE Processamento()
1050:     *  Monta descricoes de produtos usando SigCdGrp + SigCdCor e traduz com SigCdDic
1051:     *==========================================================================
1052:         LOCAL loc_cSQL, loc_cGru, loc_cPrI, loc_cPrF
1053:         LOCAL loc_cPro, loc_cDes, loc_cIng, loc_cIni, loc_nGrD
1054:         LOCAL loc_oProg, loc_nRecs, loc_oErro
1055: 
1056:         ZAP IN cursor_4c_Produtos
1057: 
1058:         loc_cGru = ALLTRIM(THIS.txt_4c_CGrus.Value)
1059:         loc_cPrI = PADR(ALLTRIM(THIS.txt_4c_CProsI.Value), 14)
1060:         loc_cPrF = PADR(ALLTRIM(THIS.txt_4c_CProsF.Value), 14)

*-- Linhas 1106 a 1114:
1106:             loc_nGrD = 0
1107: 
1108:             IF VARTYPE(loc_oProg) = "O"
1109:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1110:                 loc_oProg.Update(.T.)
1111:             ENDIF
1112: 
1113:             IF !EMPTY(loc_cPro)
1114:                 *-- Busca descricao do grupo e cor do produto

*-- Linhas 1183 a 1203:
1183:         ENDIF
1184: 
1185:         SELECT cursor_4c_Produtos
1186:         GO TOP
1187:         IF !EOF("cursor_4c_Produtos")
1188:             THIS.cmd_4c_BtnAtualizar.Enabled = .T.
1189:         ENDIF
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     PROTECTED PROCEDURE Gravacao()
1194:     *  Grava descricoes: UPDATE SigCdPro + DELETE SigPrPrt por produto
1195:     *==========================================================================
1196:         LOCAL loc_lOk, loc_cPro, loc_cSQL, loc_oProg, loc_nRecs
1197:         LOCAL loc_nResult, loc_oErro
1198:         loc_lOk = .T.
1199: 
1200:         SELECT cursor_4c_Produtos
1201:         loc_nRecs = RECCOUNT("cursor_4c_Produtos")
1202: 
1203:         IF loc_nRecs = 0

*-- Linhas 1222 a 1230:
1222:             loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1223: 
1224:             IF VARTYPE(loc_oProg) = "O"
1225:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1226:                 loc_oProg.Update(.T.)
1227:             ENDIF
1228: 
1229:             *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
1230:             loc_cSQL = "UPDATE SigCdPro " + ;


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SIGPRDSCBO.PRG - Business Object para Montagem de Descricao de Produtos
* Tabela principal: SigCdPro
* Form operacional: processa descricoes/traducoes de produtos em lote
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *-- Filtros de selecao
    this_cCProsI     = ""   && Codigo produto inicial (filtro intervalo)
    this_cCProsF     = ""   && Codigo produto final (filtro intervalo)
    this_cCGrus      = ""   && Codigo grupo de produto (filtro alternativo)

    *-- Propriedades do produto corrente (linha selecionada na grade)
    this_cCPros      = ""   && Codigo do produto (CPros)
    this_cDPros      = ""   && Descricao do produto (DPros)
    this_cCGrusProd  = ""   && Grupo do produto (CGrus)
    this_cCodCors    = ""   && Codigo da cor (CodCors)
    this_cPortugues  = ""   && Descricao montada em Portugues
    this_cTraduzido  = ""   && Descricao traduzida (Ingles)
    this_cDscCompras = ""   && Descricao para compras (DscCompras)
    this_cObsCompras = ""   && Observacao para compras (ObsCompras)

    *--------------------------------------------------------------------------
    * INIT - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT("SigCdPro")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCPros      = TratarNulo(CPros,      "C")
                THIS.this_cDPros      = TratarNulo(DPros,      "C")
                THIS.this_cCGrusProd  = TratarNulo(CGrus,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cDscCompras = TratarNulo(DscCompras, "C")
                THIS.this_cObsCompras = TratarNulo(ObsCompras, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Seleciona produtos conforme filtros para a grade
    * Popula cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lResultado, loc_cSQL, loc_cFiltro, loc_cPrI, loc_cPrF, loc_cGru
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT CPros, '' AS Portugues, '' AS Traduzido, " + ;
                       "ISNULL(DscCompras,'') AS DscCompras, " + ;
                       "ISNULL(ObsCompras,'') AS ObsCompras " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar produtos"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Produtos")
                TABLEREVERT(.T., "cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ;
                (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
                 DscCompras M(4) NULL, ObsCompras M(4) NULL)
            SET NULL OFF

            IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
                SELECT cursor_4c_Produtos
                APPEND FROM DBF("cursor_4c_ProdutosTemp")
            ENDIF

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDescricoes - Monta descricoes em Portugues e traduz para Ingles
    * Usa crSigCdDic (dicionario) e SigCdGrp/SigCdCor para montar descricao
    * Popula colunas Portugues/Traduzido de cursor_4c_Produtos
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDescricoes()
        LOCAL loc_lResultado, loc_cSQL, loc_cPro, loc_cDes, loc_cIng
        LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cFiltro
        LOCAL loc_cDGrus, loc_cDescs, loc_nMontaGrDs
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "a.CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "a.CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                       "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                       "FROM SigCdPro a " + ;
                       "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                       "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY a.CPros"

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfoTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar informa" + CHR(231) + CHR(245) + "es dos produtos"
                loc_lResultado = .F.
            ENDIF

            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            ZAP

            SELECT cursor_4c_ProdInfoTemp
            GO TOP
            DO WHILE !EOF("cursor_4c_ProdInfoTemp")
                loc_cPro    = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.CPros,   ""))
                loc_cDGrus  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.DGrus,   ""))
                loc_cDescs  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.Descs,   ""))
                loc_nMontaGrDs = NVL(cursor_4c_ProdInfoTemp.MontaGrDs, 0)

                IF !EMPTY(loc_cPro)
                    *-- Monta descricao base: Grupo + Cor
                    loc_cDes = ALLTRIM(loc_cDGrus + " " + loc_cDescs)

                    IF !EMPTY(loc_cDes)
                        *-- Aplica dicionario de traducao
                        loc_cIng = loc_cDes
                        IF USED("cursor_4c_Dicionario")
                            SELECT cursor_4c_Dicionario
                            GO TOP
                            DO WHILE !EOF("cursor_4c_Dicionario")
                                loc_cIng = STRTRAN(loc_cIng, ;
                                    ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                    ALLTRIM(cursor_4c_Dicionario.Traducao))
                                SKIP IN cursor_4c_Dicionario
                            ENDDO
                        ENDIF

                        *-- Limpa caracteres especiais para SQL
                        loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                        loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                        SELECT cursor_4c_Produtos
                        INSERT INTO cursor_4c_Produtos ;
                            (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                            VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
                    ENDIF
                ENDIF

                SKIP IN cursor_4c_ProdInfoTemp
            ENDDO

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDicionario - Carrega SigCdDic (Ingles) em cursor_4c_Dicionario
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDicionario()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"

            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                THIS.this_cMensagemErro = "Falha ao carregar dicion" + CHR(225) + "rio"
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - Atualiza SigCdPro e limpa SigPrPrt em lote
    * Percorre cursor_4c_Produtos e faz UPDATE em cada produto
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes(par_oProgressBar)
        LOCAL loc_lResultado, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_cPortugues, loc_cTraduzido, loc_cDscCompras, loc_cObsCompras
        loc_lResultado = .F.
        loc_lOks = .T.

        TRY
            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            DO WHILE !EOF("cursor_4c_Produtos") AND loc_lOks
                loc_cPro         = ALLTRIM(NVL(cursor_4c_Produtos.CPros,       ""))
                loc_cPortugues   = ALLTRIM(NVL(cursor_4c_Produtos.Portugues,   ""))
                loc_cTraduzido   = ALLTRIM(NVL(cursor_4c_Produtos.Traduzido,   ""))
                loc_cDscCompras  = ALLTRIM(NVL(cursor_4c_Produtos.DscCompras,  ""))
                loc_cObsCompras  = ALLTRIM(NVL(cursor_4c_Produtos.ObsCompras,  ""))

                IF VARTYPE(par_oProgressBar) = "O"
                    par_oProgressBar.SubTitulo.Caption = "Produto : " + loc_cPro
                    par_oProgressBar.Update(.T.)
                ENDIF

                *-- UPDATE SigCdPro
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(loc_cDscCompras) + ", " + ;
                           "ObsCompras = " + EscaparSQL(loc_cObsCompras) + ", " + ;
                           "DPros = '" + PADR(loc_cPortugues, 40) + "' " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar produto " + loc_cPro
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE SigPrPrt
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt para " + loc_cPro
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SKIP IN cursor_4c_Produtos
                ELSE
                    EXIT
                ENDIF
            ENDDO

            loc_lResultado = loc_lOks
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (CPros)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCPros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel: form operacional nao cria produtos novos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza descricoes de um produto individual em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCPros)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdPro " + ;
                       "SET DscCompras = " + EscaparSQL(THIS.this_cDscCompras) + ", " + ;
                       "ObsCompras = " + EscaparSQL(THIS.this_cObsCompras) + ", " + ;
                       "DPros = '" + PADR(ALLTRIM(THIS.this_cPortugues), 40) + "' " + ;
                       "WHERE CPros = '" + ALLTRIM(THIS.this_cCPros) + "'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Falha ao atualizar produto " + ALLTRIM(THIS.this_cCPros)
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria("A")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cCProsI     = ""
        THIS.this_cCProsF     = ""
        THIS.this_cCGrus      = ""
        THIS.this_cCPros      = ""
        THIS.this_cDPros      = ""
        THIS.this_cCGrusProd  = ""
        THIS.this_cCodCors    = ""
        THIS.this_cPortugues  = ""
        THIS.this_cTraduzido  = ""
        THIS.this_cDscCompras = ""
        THIS.this_cObsCompras = ""
        THIS.this_cMensagemErro = ""
    ENDPROC

ENDDEFINE

