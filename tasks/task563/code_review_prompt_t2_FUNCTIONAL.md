# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1333 linhas total):

*-- Linhas 22 a 150:
22: * 7/8, junto com Processamento()/LimparTela() - nesta fase os campos apenas
23: * existem e aceitam digitacao livre.
24: *
25: * FASE 7/8 - LimparTela() (transcricao direta do PROCEDURE limpatela legado)
26: * e Processamento() (delega ao motor SIGMVCMVBO.ProcessarLancamentos, que
27: * implementa o PROCEDURE processamento + fazcontra legado - geracao dos
28: * pares de lancamento D/C em SigMvCcr a partir do custo das operacoes
29: * financeiras marcadas, com conversao de moeda). O BO ja reporta sucesso/
30: * erro/aviso em cada caminho (regra #20 CLAUDE.md); o form so trata o aviso
31: * das operacoes que pedem visualizacao de titulos (VisTit = 1; a tela
32: * SigMvTi2 do legado esta fora do acervo desta migracao).
33: *==============================================================================
34: 
35: DEFINE CLASS FormSIGMVCMV AS FormBase
36: 
37:     *-- Propriedades visuais (copiadas EXATAS do original SIGMVCMV.SCX)
38:     Height       = 323
39:     Width        = 800
40:     AutoCenter   = .T.
41:     TitleBar     = 0
42:     ShowWindow   = 1
43:     WindowType   = 1
44:     ControlBox   = .F.
45:     Closable     = .F.
46:     BorderStyle  = 2
47:     FontName     = "Tahoma"
48:     FontSize     = 8
49:     Caption      = "Processamento para o Lan" + CHR(231) + "amentos de Centro de Custos n" + CHR(227) + "o lan" + CHR(231) + "ados"
50: 
51:     *==========================================================================
52:     * Init - apenas DODEFAULT (FormBase.Init ja chama InicializarForm)
53:     *==========================================================================
54:     PROCEDURE Init()
55:         RETURN DODEFAULT()
56:     ENDPROC
57: 
58:     *==========================================================================
59:     * InicializarForm - cria o Business Object, valida a conexao e monta a
60:     * estrutura visual base (cabecalho). Grid, botoes e campos de filtro sao
61:     * adicionados nas fases seguintes.
62:     *==========================================================================
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
65:         loc_lSucesso = .F.
66:         loc_lProsseguir = .T.
67: 
68:         TRY
69:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
70: 
71:             THIS.this_oBusinessObject = CREATEOBJECT("SIGMVCMVBO")
72: 
73:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
74:                 IF gnConnHandle <= 0
75:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
76:                         "o com Servidor de Banco de Dados.", ;
77:                         "Conex" + CHR(227) + "o")
78:                     loc_lProsseguir = .F.
79:                 ENDIF
80:             ENDIF
81: 
82:             IF loc_lProsseguir
83:                 THIS.CriarCursorOperacoes()
84:                 THIS.ConfigurarPageFrame()
85:                 THIS.ConfigurarBotoesAcao()
86:                 THIS.ConfigurarCamposPeriodoMoeda()
87:                 THIS.ConfigurarCamposEmpresaOperacao()
88:                 THIS.ConfigurarBotoesGrade()
89:                 THIS.ConfigurarGrid()
90:                 THIS.CarregarLista()
91:                 THIS.TornarControlesVisiveis()
92:                 THIS.AjustarBotoesPorModo()
93:                 loc_lSucesso = .T.
94:             ENDIF
95:         CATCH TO loc_oErro
96:             MsgErro(loc_oErro.Message + CHR(13) + ;
97:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
98:                 "Procedure: " + loc_oErro.Procedure, ;
99:                 "Erro InicializarForm")
100:         ENDTRY
101: 
102:         RETURN loc_lSucesso
103:     ENDPROC
104: 
105:     *==========================================================================
106:     * ConfigurarPageFrame - Monta o cabecalho cinza (cntSombra do legado).
107:     * Form OPERACIONAL sem PageFrame Lista/Dados: o cabecalho e um container
108:     * direto no form, equivalente ao SIGMVCMV.cntSombra original.
109:     *==========================================================================
110:     PROTECTED PROCEDURE ConfigurarPageFrame()
111:         LOCAL loc_oErro
112: 
113:         TRY
114:             THIS.AddObject("cnt_4c_Sombra", "Container")
115:             WITH THIS.cnt_4c_Sombra
116:                 .Top         = 0
117:                 .Left        = 0
118:                 .Width       = THIS.Width
119:                 .Height      = 80
120:                 .BackColor   = RGB(100, 100, 100)
121:                 .BackStyle   = 1
122:                 .BorderWidth = 0
123: 
124:                 .AddObject("lbl_4c_LblSombra", "Label")
125:                 WITH .lbl_4c_LblSombra
126:                     .Top       = 18
127:                     .Left      = 10
128:                     .Width     = THIS.Width
129:                     .Height    = 40
130:                     .FontBold  = .T.
131:                     .FontName  = "Tahoma"
132:                     .FontSize  = 18
133:                     .AutoSize  = .F.
134:                     .WordWrap  = .T.
135:                     .Alignment = 0
136:                     .BackStyle = 0
137:                     .ForeColor = RGB(0, 0, 0)
138:                     .Caption   = THIS.Caption
139:                 ENDWITH
140: 
141:                 .AddObject("lbl_4c_LblTitulo", "Label")
142:                 WITH .lbl_4c_LblTitulo
143:                     .Top       = 17
144:                     .Left      = 10
145:                     .Width     = THIS.Width
146:                     .Height    = 46
147:                     .FontBold  = .T.
148:                     .FontName  = "Tahoma"
149:                     .FontSize  = 18
150:                     .AutoSize  = .F.

*-- Linhas 161 a 347:
161:         CATCH TO loc_oErro
162:             MsgErro(loc_oErro.Message + CHR(13) + ;
163:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
164:                 "Procedure: " + loc_oErro.Procedure, ;
165:                 "Erro ConfigurarPageFrame")
166:         ENDTRY
167:     ENDPROC
168: 
169:     *==========================================================================
170:     * TornarControlesVisiveis - Torna visiveis os controles criados via
171:     * AddObject (que nascem com Visible = .F. por padrao)
172:     *==========================================================================
173:     PROTECTED PROCEDURE TornarControlesVisiveis()
174:         LOCAL loc_oErro
175: 
176:         TRY
177:             THIS.TornarVisivelRecursivo(THIS)
178:         CATCH TO loc_oErro
179:             MsgErro(loc_oErro.Message + CHR(13) + ;
180:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
181:                 "Procedure: " + loc_oErro.Procedure, ;
182:                 "Erro TornarControlesVisiveis")
183:         ENDTRY
184:     ENDPROC
185: 
186:     *==========================================================================
187:     * TornarVisivelRecursivo - Percorre o container recursivamente
188:     *==========================================================================
189:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
190:         LOCAL loc_nI, loc_oCtrl
191: 
192:         FOR loc_nI = 1 TO par_oContainer.ControlCount
193:             loc_oCtrl = par_oContainer.Controls(loc_nI)
194:             IF VARTYPE(loc_oCtrl) = "O"
195:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
196:                     loc_oCtrl.Visible = .T.
197:                 ENDIF
198:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
199:                     THIS.TornarVisivelRecursivo(loc_oCtrl)
200:                 ENDIF
201:             ENDIF
202:         ENDFOR
203:     ENDPROC
204: 
205:     *==========================================================================
206:     * CriarCursorOperacoes - Cria o cursor de trabalho da grade de selecao de
207:     * operacoes (espelha "Create Cursor csOperacaos (Marcas l(1), Operacaos
208:     * c(20), VisTit n(1))" + "Index on Operacaos Tag Operacaos" do PROCEDURE
209:     * Load do legado). Estrutura fixa, reaproveitada em todas as fases
210:     * seguintes que popularem o cursor - a ORDEM dos campos NUNCA muda.
211:     *==========================================================================
212:     PROTECTED PROCEDURE CriarCursorOperacoes()
213:         LOCAL loc_cCursor
214:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
215: 
216:         IF USED(loc_cCursor)
217:             USE IN (loc_cCursor)
218:         ENDIF
219: 
220:         CREATE CURSOR (loc_cCursor) (Marcas L(1), Operacaos C(20), VisTit N(1))
221:         SELECT (loc_cCursor)
222:         INDEX ON Operacaos TAG Operacaos
223:     ENDPROC
224: 
225:     *==========================================================================
226:     * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar,
227:     * posicionados diretamente no form (fora de container), EXATAMENTE como
228:     * no SIGMVCMV.SCX original (Shape1/Processa/Cancela).
229:     *==========================================================================
230:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
231:         THIS.AddObject("shp_4c_Shape1", "Shape")
232:         WITH THIS.shp_4c_Shape1
233:             .Top           = -2
234:             .Left          = 644
235:             .Height        = 37
236:             .Width         = 52
237:             .BackStyle     = 0
238:             .BorderStyle   = 0
239:             .SpecialEffect = 1
240:             .BorderColor   = RGB(136, 189, 188)
241:             .Visible       = .T.
242:         ENDWITH
243: 
244:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
245:         WITH THIS.cmd_4c_Processa
246:             .Top             = 3
247:             .Left            = 649
248:             .Height          = 75
249:             .Width           = 75
250:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
251:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
252:             .Caption         = "\<Processar"
253:             .FontName        = "Tahoma"
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .FontSize        = 8
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .T.
260:             .SpecialEffect   = 0
261:             .PicturePosition = 13
262:             .MousePointer    = 15
263:             .WordWrap        = .T.
264:             .AutoSize        = .F.
265:             .TabIndex        = 14
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
269: 
270:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
271:         WITH THIS.cmd_4c_Cancela
272:             .Top             = 3
273:             .Left            = 724
274:             .Height          = 75
275:             .Width           = 75
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
277:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
278:             .Cancel          = .T.
279:             .Caption         = "Encerrar"
280:             .FontName        = "Tahoma"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .T.
287:             .SpecialEffect   = 0
288:             .PicturePosition = 13
289:             .MousePointer    = 15
290:             .WordWrap        = .T.
291:             .AutoSize        = .F.
292:             .TabIndex        = 15
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
296:     ENDPROC
297: 
298:     *==========================================================================
299:     * ConfigurarCamposPeriodoMoeda - Primeira metade dos campos de filtro
300:     * (Fase 5/8): grupo Periodo (getDtInicial/getDtFinal/Say1/Say6) e grupo
301:     * Moeda para Conversao (get_cd_moeda/lbl_moeda/get_ds_moeda). Controles
302:     * direto no form (sem container/PageFrame), posicoes EXATAS do SCX
303:     * original - form OPERACIONAL nao usa a compensacao de +29 do PageFrame
304:     * de forms CRUD. Handlers de Valid/lookup (fwBuscaExt de moeda) sao
305:     * implementados na Fase 7/8, junto com Processamento()/LimparTela().
306:     *==========================================================================
307:     PROTECTED PROCEDURE ConfigurarCamposPeriodoMoeda()
308:         *-- Say1 "Periodo :"
309:         THIS.AddObject("lbl_4c_Label1", "Label")
310:         WITH THIS.lbl_4c_Label1
311:             .Top       = 92
312:             .Left      = 99
313:             .Width     = 60
314:             .Height    = 17
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8
317:             .Alignment = 0
318:             .BackStyle = 0
319:             .ForeColor = RGB(90, 90, 90)
320:             .Caption   = "Per" + CHR(237) + "odo :"
321:             .TabIndex  = 1
322:             .Visible   = .T.
323:         ENDWITH
324: 
325:         *-- getDtInicial
326:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
327:         WITH THIS.txt_4c_DtInicial
328:             .Top           = 88
329:             .Left          = 154
330:             .Width         = 80
331:             .Height        = 23
332:             .FontName      = "Tahoma"
333:             .FontSize      = 8
334:             .SpecialEffect = 1
335:             .BorderColor   = RGB(36, 84, 155)
336:             .Value         = {}
337:             .TabIndex      = 2
338:             .Visible       = .T.
339:         ENDWITH
340: 
341:         *-- Say6 "ate"
342:         THIS.AddObject("lbl_4c_Label6", "Label")
343:         WITH THIS.lbl_4c_Label6
344:             .Top       = 92
345:             .Left      = 242
346:             .Width     = 25
347:             .Height    = 17

*-- Linhas 425 a 481:
425: 
426:         *-- Lookup de moeda (F4/Enter/Tab) - espelha o Valid original de
427:         *-- get_cd_moeda/get_ds_moeda (fwBuscaExt por CMOES/DMOES em SigCdMoe)
428:         BINDEVENT(THIS.txt_4c__cd_moeda, "KeyPress", THIS, "ValidarMoeda")
429:         BINDEVENT(THIS.txt_4c__ds_moeda, "KeyPress", THIS, "ValidarMoedaDesc")
430:     ENDPROC
431: 
432:     *==========================================================================
433:     * ConfigurarCamposEmpresaOperacao - Segunda metade dos campos de filtro
434:     * (Fase 6/8): grupo Empresa (lbl_empresa/getEmpresa/getDEmpresa) e o
435:     * label lbl_operacao ("Operacao :") que antecede a grade de selecao.
436:     * Posicoes EXATAS do SIGMVCMV.SCX original. O legado usa fAcessoEmpresa()
437:     * (funcao global Fortyus NAO portada) para os Valid de getEmpresa/
438:     * getDEmpresa - substituido pelo lookup canonico em SigCdEmp (cemps/
439:     * razas), implementado em ValidarEmpresa/ValidarDEmpresa/AbrirBuscaEmpresa.
440:     *==========================================================================
441:     PROTECTED PROCEDURE ConfigurarCamposEmpresaOperacao()
442:         *-- lbl_empresa "Empresa :"
443:         THIS.AddObject("lbl_4c_Lbl_empresa", "Label")
444:         WITH THIS.lbl_4c_Lbl_empresa
445:             .Top       = 118
446:             .Left      = 94
447:             .Width     = 50
448:             .Height    = 17
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .Alignment = 0
452:             .BackStyle = 0
453:             .ForeColor = RGB(90, 90, 90)
454:             .Caption   = "Empresa :"
455:             .TabIndex  = 5
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- getEmpresa (codigo da empresa, lookup em SigCdEmp.cemps)
460:         THIS.AddObject("txt_4c_Empresa", "TextBox")
461:         WITH THIS.txt_4c_Empresa
462:             .Top           = 113
463:             .Left          = 154
464:             .Width         = 31
465:             .Height        = 23
466:             .FontName      = "Tahoma"
467:             .FontSize      = 8
468:             .MaxLength     = 3
469:             .Format        = "K!"
470:             .SpecialEffect = 1
471:             .BorderColor   = RGB(36, 84, 155)
472:             .Value         = ""
473:             .TabIndex      = 6
474:             .Visible       = .T.
475:         ENDWITH
476: 
477:         *-- getDEmpresa (razao social da empresa, preenchida pelo lookup)
478:         THIS.AddObject("txt_4c_DEmpresa", "TextBox")
479:         WITH THIS.txt_4c_DEmpresa
480:             .Top           = 113
481:             .Left          = 187

*-- Linhas 491 a 617:
491:             .Visible       = .T.
492:         ENDWITH
493: 
494:         BINDEVENT(THIS.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresa")
495:         BINDEVENT(THIS.txt_4c_DEmpresa, "KeyPress", THIS, "ValidarDEmpresa")
496: 
497:         *-- lbl_operacao "Operacao :" (antecede a grade de selecao)
498:         THIS.AddObject("lbl_4c_Lbl_operacao", "Label")
499:         WITH THIS.lbl_4c_Lbl_operacao
500:             .Top       = 167
501:             .Left      = 88
502:             .Width     = 56
503:             .Height    = 17
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .Alignment = 0
507:             .BackStyle = 0
508:             .ForeColor = RGB(90, 90, 90)
509:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
510:             .TabIndex  = 11
511:             .Visible   = .T.
512:         ENDWITH
513:     ENDPROC
514: 
515:     *==========================================================================
516:     * ConfigurarBotoesGrade - CommandGroup "Selecionar/Desmarcar" ao lado da
517:     * grade (espelha cmdBtnGrade.Command1=btnMarcaTudo / Command2=btnDesmarcar
518:     * do legado).
519:     *==========================================================================
520:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
521:         THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
522:         WITH THIS.obj_4c_CmdBtnGrade
523:             .Top         = 193
524:             .Left        = 406
525:             .Width       = 43
526:             .Height      = 91
527:             .ButtonCount = 2
528:             .BackStyle   = 0
529:             .BorderStyle = 0
530:             .Themes      = .F.
531:             .Value       = 1
532:             .TabIndex    = 13
533: 
534:             WITH .Buttons(1)
535:                 .Top         = -1
536:                 .Left        = -1
537:                 .Height      = 45
538:                 .Width       = 45
539:                 .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
540:                 .Caption     = ""
541:                 .ToolTipText = "Selecionar"
542:                 .ForeColor   = RGB(36, 84, 155)
543:                 .BackColor   = RGB(255, 255, 255)
544:                 .Themes      = .F.
545:                 .TabIndex    = 1
546:             ENDWITH
547: 
548:             WITH .Buttons(2)
549:                 .Top         = 45
550:                 .Left        = -1
551:                 .Height      = 45
552:                 .Width       = 45
553:                 .FontName    = "Verdana"
554:                 .FontSize    = 8
555:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
556:                 .Caption     = ""
557:                 .ToolTipText = "Desmarcar"
558:                 .ForeColor   = RGB(36, 84, 155)
559:                 .BackColor   = RGB(255, 255, 255)
560:                 .Themes      = .F.
561:                 .TabIndex    = 2
562:             ENDWITH
563: 
564:             .Visible = .T.
565:         ENDWITH
566: 
567:         BINDEVENT(THIS.obj_4c_CmdBtnGrade, "Click", THIS, "CmdBtnGradeClick")
568:     ENDPROC
569: 
570:     *==========================================================================
571:     * ConfigurarGrid - Grade de selecao de operacoes (espelha o With
572:     * Thisform.grdOperacaos do PROCEDURE Init original). ColumnCount=3 e
573:     * RecordSource sao setados ANTES das propriedades de Column1/Column2,
574:     * exatamente na ordem do legado - evita o reset de Width/CurrentControl
575:     * que uma reatribuicao POSTERIOR de RecordSource causaria.
576:     *==========================================================================
577:     PROTECTED PROCEDURE ConfigurarGrid()
578:         LOCAL loc_cCursor
579:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
580: 
581:         THIS.AddObject("grd_4c_Dados", "Grid")
582:         THIS.grd_4c_Dados.ColumnCount  = 3
583:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
584: 
585:         WITH THIS.grd_4c_Dados
586:             .HeaderHeight      = 0
587:             .DeleteMark        = .F.
588:             .RecordMark        = .F.
589:             .ReadOnly          = .F.
590:             .Top               = 165
591:             .Left              = 154
592:             .Width             = 247
593:             .Height            = 148
594:             .FontName          = "Tahoma"
595:             .FontSize          = 8
596:             .RowHeight         = 18
597:             .ScrollBars        = 2
598:             .GridLineColor     = RGB(238, 238, 238)
599:             .AllowHeaderSizing = .F.
600:             .AllowRowSizing    = .F.
601:             .TabIndex          = 12
602: 
603:             .Column1.Width        = 15
604:             .Column1.ControlSource = loc_cCursor + ".Marcas"
605:             .Column1.FontName     = "Courier New"
606:             .Column1.Movable      = .F.
607:             .Column1.Resizable    = .F.
608: 
609:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
610:             WITH .Column1.chk_4c_Check1
611:                 .Top       = 9
612:                 .Left      = 2
613:                 .Height    = 17
614:                 .Width     = 22
615:                 .FontName  = "Tahoma"
616:                 .Alignment = 0
617:                 .Caption   = ""

*-- Linhas 635 a 702:
635:             .Visible = .T.
636:         ENDWITH
637: 
638:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "ChkMarcasClick")
639:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "ChkMarcasKeyPress")
640:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
641:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "ChkMarcasMouseUp")
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * CarregarLista - PUBLIC (o harness de teste chama direto no oForm, e o
646:     * metodo tambem e' acionado pela propria tela). Popula a grade de selecao de
647:     * operacoes, espelhando o bloco do PROCEDURE Init legado:
648:     *
649:     *   Select crSigOpFin
650:     *   Scan
651:     *       Insert Into csOperacaos (Marcas, Operacaos, VisTit) ;
652:     *           Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
653:     *   Endscan
654:     *   Select csOperacaos
655:     *   Go Top
656:     *
657:     * Todas as linhas nascem MARCADAS (.T.), exatamente como no legado - o
658:     * usuario desmarca o que nao quer processar. O cursor da grade e' ZAPado
659:     * (nunca fechado/recriado): fechar quebraria o RecordSource do grid e
660:     * resetaria Column.Width/CurrentControl/Sparse ja configurados.
661:     *==========================================================================
662:     PROCEDURE CarregarLista()
663:         LOCAL loc_cCursor, loc_cOrigem, loc_nArea, loc_cDopes, loc_nVisTit, loc_oErro
664: 
665:         TRY
666:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
667:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
668:             loc_nArea   = SELECT()
669: 
670:             IF !USED(loc_cCursor)
671:                 THIS.CriarCursorOperacoes()
672:             ENDIF
673: 
674:             SELECT (loc_cCursor)
675:             ZAP
676: 
677:             *-- Sem conexao (modo de validacao de UI) a grade fica vazia, mas
678:             *-- o form abre normalmente - nao ha SQL para executar
679:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
680:                     AND THIS.this_oBusinessObject.CarregarOperacoes() ;
681:                     AND USED(loc_cOrigem)
682: 
683:                 SELECT (loc_cOrigem)
684:                 GO TOP
685:                 DO WHILE !EOF(loc_cOrigem)
686:                     loc_cDopes  = EVALUATE(loc_cOrigem + ".Dopes")
687:                     loc_nVisTit = NVL(EVALUATE(loc_cOrigem + ".VisTit"), 0)
688: 
689:                     INSERT INTO (loc_cCursor) (Marcas, Operacaos, VisTit) ;
690:                         VALUES (.T., loc_cDopes, loc_nVisTit)
691: 
692:                     SELECT (loc_cOrigem)
693:                     SKIP
694:                 ENDDO
695:             ENDIF
696: 
697:             *-- Popular o cursor NAO repinta a grade: o legado sempre fecha com
698:             *-- "Select csOperacaos / Go Top" + Refresh (regra #21 CLAUDE.md)
699:             SELECT (loc_cCursor)
700:             GO TOP
701:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
702:                 THIS.grd_4c_Dados.Refresh()

*-- Linhas 708 a 1333:
708:         CATCH TO loc_oErro
709:             MsgErro(loc_oErro.Message + CHR(13) + ;
710:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
711:                 "Procedure: " + loc_oErro.Procedure, ;
712:                 "Erro CarregarLista")
713:         ENDTRY
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * ChkMarcasClick / ChkMarcasKeyPress / ChkMarcasMouseDown / ChkMarcasMouseUp
718:     * PUBLIC (BINDEVENT exige metodo publico - regra #3 CLAUDE.md). Espelham
719:     * SIGMVCMV.grdOperacaos.Column1.Check1 do legado: o toggle acontece no
720:     * KeyPress (Enter/Espaco) e no MouseDown; Click e MouseUp apenas suprimem
721:     * o comportamento nativo (NoDefault) para nao alternar em duplicidade.
722:     * NAO transcrito: o ramo "If nKeyCode = 9 -> ThisForm.opt_nr_tipo.Option1.
723:     * SetFocus" do KeyPress legado - opt_nr_tipo nao existe neste form (nao
724:     * consta na arvore de objetos do SIGMVCMV.SCX), e' codigo morto herdado
725:     * de copy-paste de outro form; reproduzi-lo quebraria com "Property
726:     * OPT_NR_TIPO is not found" ao pressionar Tab.
727:     *==========================================================================
728:     PROCEDURE ChkMarcasClick()
729:         NODEFAULT
730:     ENDPROC
731: 
732:     PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
733:         LOCAL loc_cCursor, loc_nAreaAnterior
734: 
735:         IF INLIST(par_nKeyCode, 13, 32)
736:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
737:             IF USED(loc_cCursor)
738:                 loc_nAreaAnterior = SELECT()
739:                 SELECT (loc_cCursor)
740:                 IF !EOF()
741:                     REPLACE Marcas WITH !Marcas
742:                     THIS.grd_4c_Dados.Refresh()
743:                 ENDIF
744:                 SELECT (loc_nAreaAnterior)
745:             ENDIF
746:             NODEFAULT
747:         ENDIF
748:     ENDPROC
749: 
750:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
751:         LOCAL loc_cCursor, loc_nAreaAnterior
752: 
753:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
754:         IF USED(loc_cCursor)
755:             loc_nAreaAnterior = SELECT()
756:             SELECT (loc_cCursor)
757:             IF !EOF()
758:                 REPLACE Marcas WITH !Marcas
759:                 THIS.grd_4c_Dados.Refresh()
760:             ENDIF
761:             SELECT (loc_nAreaAnterior)
762:         ENDIF
763:         NODEFAULT
764:     ENDPROC
765: 
766:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
767:         NODEFAULT
768:     ENDPROC
769: 
770:     *==========================================================================
771:     * CmdBtnGradeClick - PUBLIC (BINDEVENT). Marca/desmarca TODAS as linhas
772:     * da grade (espelha SIGMVCMV.cmdBtnGrade.Click: Value=1 -> btnMarcaTudo,
773:     * Value=2 -> btnDesmarcar).
774:     *==========================================================================
775:     PROCEDURE CmdBtnGradeClick()
776:         LOCAL loc_cCursor, loc_nAreaAnterior
777: 
778:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
779:         IF !USED(loc_cCursor)
780:             RETURN
781:         ENDIF
782: 
783:         loc_nAreaAnterior = SELECT()
784:         SELECT (loc_cCursor)
785: 
786:         DO CASE
787:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1
788:                 REPLACE ALL Marcas WITH .T.
789:                 GO TOP
790:                 THIS.grd_4c_Dados.Refresh()
791:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2
792:                 REPLACE ALL Marcas WITH .F.
793:                 GO TOP
794:                 THIS.grd_4c_Dados.Refresh()
795:         ENDCASE
796: 
797:         SELECT (loc_nAreaAnterior)
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * BtnCancelarClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Cancela.Click
802:     * ("Thisform.Release").
803:     *==========================================================================
804:     PROCEDURE BtnCancelarClick()
805:         THIS.Release()
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * BtnProcessaClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Processa.Click:
810:     * valida periodo informado + pelo menos uma operacao marcada + confirma,
811:     * depois delega para THIS.Processamento() e limpa a tela com
812:     * THIS.LimparTela(), na MESMA ordem do legado ("=ThisForm.Processamento()"
813:     * seguido de "=ThisForm.Limpatela()").
814:     *
815:     * FASE 8/8: a tela e' TRAVADA (HabilitarCampos(.F.)) durante o lote e
816:     * destravada logo apos - o processamento percorre todas as operacoes
817:     * marcadas gravando pares D/C em SigMvCcr e, sem o travamento, o usuario
818:     * consegue acionar Processar/marcar a grade no meio da gravacao. O
819:     * destravamento nao depende do resultado: Processamento() trata o proprio
820:     * erro no CATCH e nunca propaga, entao a linha seguinte sempre executa.
821:     *==========================================================================
822:     PROCEDURE BtnProcessaClick()
823:         LOCAL loc_cCursor, loc_lConfirmou
824: 
825:         IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
826:             MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", "Aten" + CHR(231) + CHR(227) + "o")
827:             THIS.txt_4c_DtInicial.SetFocus()
828:             RETURN
829:         ENDIF
830: 
831:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
832:         IF !USED(loc_cCursor)
833:             RETURN
834:         ENDIF
835: 
836:         SELECT (loc_cCursor)
837:         LOCATE FOR Marcas = .T.
838:         IF !FOUND()
839:             MsgAviso("Selecione uma Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
840:             THIS.grd_4c_Dados.Column1.SetFocus()
841:             RETURN
842:         ENDIF
843: 
844:         loc_lConfirmou = MsgConfirma("Confirma o Processamento?", "Aten" + CHR(231) + CHR(227) + "o")
845:         IF !loc_lConfirmou
846:             RETURN
847:         ENDIF
848: 
849:         THIS.HabilitarCampos(.F.)
850:         THIS.Processamento()
851:         THIS.HabilitarCampos(.T.)
852: 
853:         THIS.LimparTela()
854: 
855:         *-- HabilitarCampos(.T.) reabilita tudo sem olhar a grade; este
856:         *-- AjustarBotoesPorModo devolve o estado REAL (grade vazia volta a
857:         *-- desabilitar Processar/Marcar). A grade NAO e' recarregada: no
858:         *-- legado csOperacaos e' montado UMA vez no Init (lista de operacoes
859:         *-- financeiras do cadastro, que o processamento nao altera), e
860:         *-- recarregar aqui remarcaria tudo com .T., jogando fora a selecao
861:         *-- que o usuario acabou de fazer.
862:         THIS.AjustarBotoesPorModo()
863:     ENDPROC
864: 
865:     *==========================================================================
866:     * LimparTela - PUBLIC (chamado por BtnProcessaClick e pelo harness de
867:     * teste). Espelha o PROCEDURE limpatela do legado: limpa os campos de
868:     * filtro (periodo, moeda, empresa) apos o processamento.
869:     *==========================================================================
870:     PROCEDURE LimparTela()
871:         LOCAL loc_oBO
872: 
873:         *-- Os seis filtros vivem no BO (fonte unica): zerar la' e deixar
874:         *-- BOParaForm escrever na tela reproduz exatamente o legado, que
875:         *-- atribui "" / Ctod('') aos seis campos e chama Refresh em cada um.
876:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
877:             loc_oBO = THIS.this_oBusinessObject
878:             loc_oBO.this_dDataInicial = {}
879:             loc_oBO.this_dDataFinal   = {}
880:             loc_oBO.this_cCdMoeda     = ""
881:             loc_oBO.this_cDsMoeda     = ""
882:             loc_oBO.this_cCdEmpresa   = ""
883:             loc_oBO.this_cDsEmpresa   = ""
884:         ENDIF
885: 
886:         THIS.BOParaForm()
887:     ENDPROC
888: 
889:     *==========================================================================
890:     * Processamento - PUBLIC (chamado por BtnProcessaClick e pelo harness de
891:     * teste). Delega a geracao dos lancamentos D/C ao BO
892:     * (SIGMVCMVBO.ProcessarLancamentos) - que ja exibe MsgInfo/MsgErro/
893:     * MsgAviso em cada caminho de sucesso/falha (regra #20 CLAUDE.md: BO ja
894:     * reporta, o form nao precisa de ELSE duplicando a mensagem). So resta
895:     * ao form avisar sobre as operacoes que pedem visualizacao de titulos
896:     * (VisTit = 1): a tela SigMvTi2 do legado esta fora do acervo desta
897:     * migracao (ver SIGMVCMVBO.ContarOperacoesVisTit).
898:     *==========================================================================
899:     PROCEDURE Processamento()
900:         LOCAL loc_lSucesso, loc_oErro
901: 
902:         TRY
903:             *-- FormParaBO transfere os seis filtros da tela para o BO e
904:             *-- valida o periodo; sem ele o lote rodaria com os valores da
905:             *-- execucao anterior (o form OPERACIONAL nao fecha entre um
906:             *-- processamento e outro).
907:             IF THIS.FormParaBO()
908:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarLancamentos( ;
909:                     THIS.this_oBusinessObject.this_dDataInicial, ;
910:                     THIS.this_oBusinessObject.this_dDataFinal, ;
911:                     THIS.this_oBusinessObject.this_cCdEmpresa, ;
912:                     THIS.this_oBusinessObject.this_cCdMoeda)
913:             ENDIF
914: 
915:             IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdVisTit > 0
916:                 MsgAviso("Existem " + ALLTRIM(STR(THIS.this_oBusinessObject.this_nQtdVisTit)) + ;
917:                     " opera" + CHR(231) + CHR(245) + "o(" + CHR(245) + "es) marcada(s) que exige(m) " + ;
918:                     "visualiza" + CHR(231) + CHR(227) + "o de t" + CHR(237) + "tulos - tela ainda " + ;
919:                     "n" + CHR(227) + "o migrada (SigMvTi2). Consulte os t" + CHR(237) + "tulos " + ;
920:                     "diretamente no m" + CHR(243) + "dulo financeiro.", "Aten" + CHR(231) + CHR(227) + "o")
921:             ENDIF
922:         CATCH TO loc_oErro
923:             MsgErro(loc_oErro.Message + CHR(13) + ;
924:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
925:                 "Procedure: " + loc_oErro.Procedure, ;
926:                 "Erro Processamento")
927:         ENDTRY
928:     ENDPROC
929: 
930:     *==========================================================================
931:     * ValidarMoeda - PUBLIC (BINDEVENT KeyPress em txt_4c__cd_moeda). Espelha
932:     * o Valid original de get_cd_moeda: campo vazio limpa a descricao; digitado
933:     * tenta match exato em SigCdMoe.cmoes e, sem achar, delega para
934:     * AbrirBuscaMoeda (fwBuscaExt do legado ja mostrava o picker sempre que
935:     * nao achava registro exato).
936:     *==========================================================================
937:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
938:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
939: 
940:         IF !INLIST(par_nKeyCode, 13, 9, 115)
941:             RETURN
942:         ENDIF
943: 
944:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__cd_moeda.Value))
945: 
946:         IF EMPTY(loc_cValor)
947:             THIS.txt_4c__ds_moeda.Value = ""
948:             THIS.txt_4c__ds_moeda.Refresh()
949:             RETURN
950:         ENDIF
951: 
952:         IF USED("cursor_4c_LkpMoeda")
953:             USE IN cursor_4c_LkpMoeda
954:         ENDIF
955: 
956:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
957:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
958: 
959:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
960:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
961:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
962:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
963:             USE IN cursor_4c_LkpMoeda
964:         ELSE
965:             IF USED("cursor_4c_LkpMoeda")
966:                 USE IN cursor_4c_LkpMoeda
967:             ENDIF
968:             THIS.AbrirBuscaMoeda(loc_cValor)
969:         ENDIF
970: 
971:         THIS.txt_4c__cd_moeda.Refresh()
972:         THIS.txt_4c__ds_moeda.Refresh()
973:     ENDPROC
974: 
975:     *==========================================================================
976:     * ValidarMoedaDesc - PUBLIC (BINDEVENT KeyPress em txt_4c__ds_moeda).
977:     * Espelha o Valid original de get_ds_moeda: campo vazio limpa o codigo;
978:     * digitado tenta match exato em SigCdMoe.dmoes e, sem achar, delega para
979:     * AbrirBuscaMoeda.
980:     *==========================================================================
981:     PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
982:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
983: 
984:         IF !INLIST(par_nKeyCode, 13, 9, 115)
985:             RETURN
986:         ENDIF
987: 
988:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__ds_moeda.Value))
989: 
990:         IF EMPTY(loc_cValor)
991:             THIS.txt_4c__cd_moeda.Value = ""
992:             THIS.txt_4c__cd_moeda.Refresh()
993:             RETURN
994:         ENDIF
995: 
996:         IF USED("cursor_4c_LkpMoeda")
997:             USE IN cursor_4c_LkpMoeda
998:         ENDIF
999: 
1000:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes = " + EscaparSQL(loc_cValor)
1001:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
1002: 
1003:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
1004:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
1005:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
1006:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
1007:             USE IN cursor_4c_LkpMoeda
1008:         ELSE
1009:             IF USED("cursor_4c_LkpMoeda")
1010:                 USE IN cursor_4c_LkpMoeda
1011:             ENDIF
1012:             THIS.AbrirBuscaMoeda(loc_cValor)
1013:         ENDIF
1014: 
1015:         THIS.txt_4c__cd_moeda.Refresh()
1016:         THIS.txt_4c__ds_moeda.Refresh()
1017:     ENDPROC
1018: 
1019:     *==========================================================================
1020:     * AbrirBuscaMoeda - PROTECTED. Abre o picker canonico (FormBase.
1021:     * AbrirLookupCanonico) filtrado pelo valor digitado (codigo OU
1022:     * descricao). Sem selecao (ESC), limpa os dois campos - espelha o ramo
1023:     * "If Lastkey() = 27" do Valid original.
1024:     *==========================================================================
1025:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValorDigitado)
1026:         LOCAL loc_lSelecionou
1027: 
1028:         loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
1029:             "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValorDigitado, ;
1030:             THIS.txt_4c__cd_moeda, THIS.txt_4c__ds_moeda)
1031: 
1032:         IF !loc_lSelecionou
1033:             THIS.txt_4c__cd_moeda.Value = ""
1034:             THIS.txt_4c__ds_moeda.Value = ""
1035:         ENDIF
1036:     ENDPROC
1037: 
1038:     *==========================================================================
1039:     * ValidarEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_Empresa). O
1040:     * legado usa fAcessoEmpresa(Usuar, "C", This.Value, GetEmpresa, GetDEmpresa)
1041:     * - funcao global Fortyus NAO portada para a nova arquitetura (ver
1042:     * CLAUDE.md/skill vfp9-migration). Substituido pelo lookup canonico em
1043:     * SigCdEmp.cemps: campo vazio limpa a razao social; digitado tenta match
1044:     * exato e, sem achar, delega para AbrirBuscaEmpresa.
1045:     *==========================================================================
1046:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1047:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1048: 
1049:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1050:             RETURN
1051:         ENDIF
1052: 
1053:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_Empresa.Value))
1054: 
1055:         IF EMPTY(loc_cValor)
1056:             THIS.txt_4c_DEmpresa.Value = ""
1057:             THIS.txt_4c_DEmpresa.Refresh()
1058:             RETURN
1059:         ENDIF
1060: 
1061:         IF USED("cursor_4c_LkpEmpresa")
1062:             USE IN cursor_4c_LkpEmpresa
1063:         ENDIF
1064: 
1065:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
1066:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1067: 
1068:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1069:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1070:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1071:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1072:             USE IN cursor_4c_LkpEmpresa
1073:         ELSE
1074:             IF USED("cursor_4c_LkpEmpresa")
1075:                 USE IN cursor_4c_LkpEmpresa
1076:             ENDIF
1077:             THIS.AbrirBuscaEmpresa(loc_cValor)
1078:         ENDIF
1079: 
1080:         THIS.txt_4c_Empresa.Refresh()
1081:         THIS.txt_4c_DEmpresa.Refresh()
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * ValidarDEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_DEmpresa).
1086:     * Espelha o When original ("Return Empty(ThisForm.getEmpresa.Value)") -
1087:     * so processa a digitacao quando o codigo da empresa esta vazio; caso
1088:     * contrario o campo Descricao fica so como espelho do lookup por codigo.
1089:     *==========================================================================
1090:     PROCEDURE ValidarDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1091:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1092: 
1093:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1094:             RETURN
1095:         ENDIF
1096: 
1097:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Empresa.Value))
1098:             RETURN
1099:         ENDIF
1100: 
1101:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_DEmpresa.Value))
1102: 
1103:         IF EMPTY(loc_cValor)
1104:             THIS.txt_4c_Empresa.Value = ""
1105:             THIS.txt_4c_Empresa.Refresh()
1106:             RETURN
1107:         ENDIF
1108: 
1109:         IF USED("cursor_4c_LkpEmpresa")
1110:             USE IN cursor_4c_LkpEmpresa
1111:         ENDIF
1112: 
1113:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE razas = " + EscaparSQL(loc_cValor)
1114:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1115: 
1116:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1117:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1118:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1119:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1120:             USE IN cursor_4c_LkpEmpresa
1121:         ELSE
1122:             IF USED("cursor_4c_LkpEmpresa")
1123:                 USE IN cursor_4c_LkpEmpresa
1124:             ENDIF
1125:             THIS.AbrirBuscaEmpresa(loc_cValor)
1126:         ENDIF
1127: 
1128:         THIS.txt_4c_Empresa.Refresh()
1129:         THIS.txt_4c_DEmpresa.Refresh()
1130:     ENDPROC
1131: 
1132:     *==========================================================================
1133:     * AbrirBuscaEmpresa - PROTECTED. Abre o picker canonico (FormBase.
1134:     * AbrirLookupCanonico) em SigCdEmp filtrado pelo valor digitado (codigo
1135:     * OU razao social). Sem selecao, limpa os dois campos.
1136:     *==========================================================================
1137:     PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cValorDigitado)
1138:         LOCAL loc_lSelecionou
1139: 
1140:         loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
1141:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValorDigitado, ;
1142:             THIS.txt_4c_Empresa, THIS.txt_4c_DEmpresa)
1143: 
1144:         IF !loc_lSelecionou
1145:             THIS.txt_4c_Empresa.Value  = ""
1146:             THIS.txt_4c_DEmpresa.Value = ""
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *==========================================================================
1151:     * FormParaBO - PROTECTED (escopo HERDADO de FormBase, que declara
1152:     * "PROTECTED PROCEDURE FormParaBO"; em VFP9 o override de metodo
1153:     * PROTECTED continua PROTECTED, e chamar de fora estoura "Property
1154:     * FORMPARABO is not found" mesmo com PEMSTATUS devolvendo .T. - regra #3
1155:     * CLAUDE.md). So e' chamado por THIS.Processamento(), que esta' dentro da
1156:     * classe, entao o escopo herdado e' o correto aqui.
1157:     *
1158:     * Transfere os SEIS filtros da tela para o Business Object e valida o
1159:     * periodo. Retorna .T. quando o BO ficou apto a processar, .F. quando
1160:     * falta dado obrigatorio (ja exibindo o aviso e devolvendo o foco ao
1161:     * campo, como o Processa.Click legado).
1162:     *
1163:     * As datas passam por ConverterParaData(): o TextBox nasce com .Value = {}
1164:     * (DATE) mas o mesmo campo recebe DATETIME quando vem de coluna do SQL
1165:     * Server - ProcessarLancamentos monta DATETIME(YEAR(..),MONTH(..),DAY(..))
1166:     * e quebraria com o tipo errado (regra #16 CLAUDE.md).
1167:     *
1168:     * O periodo INVERTIDO (inicial > final) tambem e' barrado aqui: o legado
1169:     * nunca chega a esse caso porque o usuario preenche em ordem, mas o
1170:     * Between do processamento devolveria silenciosamente ZERO lancamentos e
1171:     * a tela anunciaria "processado" sem gravar nada.
1172:     *==========================================================================
1173:     PROTECTED FUNCTION FormParaBO()
1174:         LOCAL loc_lValido, loc_dIni, loc_dFim, loc_oBO
1175: 
1176:         loc_lValido = .F.
1177: 
1178:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1179:             MsgErro("Business Object n" + CHR(227) + "o inicializado.", "FormParaBO")
1180:         ELSE
1181:             loc_oBO  = THIS.this_oBusinessObject
1182:             loc_dIni = ConverterParaData(THIS.txt_4c_DtInicial.Value)
1183:             loc_dFim = ConverterParaData(THIS.txt_4c_DtFinal.Value)
1184: 
1185:             DO CASE
1186:                 CASE EMPTY(loc_dIni) OR EMPTY(loc_dFim)
1187:                     MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", ;
1188:                         "Aten" + CHR(231) + CHR(227) + "o")
1189:                     THIS.txt_4c_DtInicial.SetFocus()
1190: 
1191:                 CASE loc_dIni > loc_dFim
1192:                     MsgAviso("Data inicial maior que a data final.", ;
1193:                         "Aten" + CHR(231) + CHR(227) + "o")
1194:                     THIS.txt_4c_DtInicial.SetFocus()
1195: 
1196:                 OTHERWISE
1197:                     loc_oBO.this_dDataInicial = loc_dIni
1198:                     loc_oBO.this_dDataFinal   = loc_dFim
1199:                     loc_oBO.this_cCdMoeda     = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
1200:                     loc_oBO.this_cDsMoeda     = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
1201:                     loc_oBO.this_cCdEmpresa   = ALLTRIM(THIS.txt_4c_Empresa.Value)
1202:                     loc_oBO.this_cDsEmpresa   = ALLTRIM(THIS.txt_4c_DEmpresa.Value)
1203:                     loc_lValido = .T.
1204:             ENDCASE
1205:         ENDIF
1206: 
1207:         RETURN loc_lValido
1208:     ENDFUNC
1209: 
1210:     *==========================================================================
1211:     * BOParaForm - PROTECTED (escopo HERDADO de FormBase, igual ao FormParaBO
1212:     * acima). Chamado por THIS.LimparTela(), de dentro da classe.
1213:     *
1214:     * Caminho inverso do FormParaBO: escreve os seis filtros guardados no BO
1215:     * de volta nos TextBox e da' Refresh em cada um, reproduzindo o bloco de
1216:     * Refresh do PROCEDURE limpatela legado.
1217:     *
1218:     * E' o UNICO ponto do form que escreve nesses seis campos a partir do
1219:     * estado do BO - LimparTela zera as propriedades e chama este metodo, em
1220:     * vez de repetir doze atribuicoes. Com o BO ausente (falha de conexao no
1221:     * InicializarForm) os campos sao apenas esvaziados, sem estourar.
1222:     *==========================================================================
1223:     PROTECTED PROCEDURE BOParaForm()
1224:         LOCAL loc_oBO
1225: 
1226:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1227:             loc_oBO = THIS.this_oBusinessObject
1228:             THIS.txt_4c_DtInicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
1229:             THIS.txt_4c_DtFinal.Value   = ConverterParaData(loc_oBO.this_dDataFinal)
1230:             THIS.txt_4c__cd_moeda.Value = loc_oBO.this_cCdMoeda
1231:             THIS.txt_4c__ds_moeda.Value = loc_oBO.this_cDsMoeda
1232:             THIS.txt_4c_Empresa.Value   = loc_oBO.this_cCdEmpresa
1233:             THIS.txt_4c_DEmpresa.Value  = loc_oBO.this_cDsEmpresa
1234:         ELSE
1235:             THIS.txt_4c_DtInicial.Value = {}
1236:             THIS.txt_4c_DtFinal.Value   = {}
1237:             THIS.txt_4c__cd_moeda.Value = ""
1238:             THIS.txt_4c__ds_moeda.Value = ""
1239:             THIS.txt_4c_Empresa.Value   = ""
1240:             THIS.txt_4c_DEmpresa.Value  = ""
1241:         ENDIF
1242: 
1243:         THIS.txt_4c_DtInicial.Refresh()
1244:         THIS.txt_4c_DtFinal.Refresh()
1245:         THIS.txt_4c__cd_moeda.Refresh()
1246:         THIS.txt_4c__ds_moeda.Refresh()
1247:         THIS.txt_4c_Empresa.Refresh()
1248:         THIS.txt_4c_DEmpresa.Refresh()
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * HabilitarCampos - PUBLIC. Trava (.F.) / destrava (.T.) os controles de
1253:     * entrada durante o processamento em lote. O form OPERACIONAL nao tem
1254:     * modo INCLUIR/ALTERAR: o unico estado em que a tela fica somente-leitura
1255:     * e' o intervalo em que ProcessarLancamentos percorre as operacoes
1256:     * marcadas gravando os pares D/C em SigMvCcr.
1257:     *
1258:     * "Encerrar" NUNCA e' desabilitado - o legado deixa o Cancela sempre
1259:     * acionavel, e desabilitar um CommandButton com icone faz o icone sumir
1260:     * na tela (botao vira retangulo cinza).
1261:     *==========================================================================
1262:     PROCEDURE HabilitarCampos(par_lHabilitar)
1263:         LOCAL loc_lHab
1264: 
1265:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1266: 
1267:         THIS.txt_4c_DtInicial.Enabled = loc_lHab
1268:         THIS.txt_4c_DtFinal.Enabled   = loc_lHab
1269:         THIS.txt_4c__cd_moeda.Enabled = loc_lHab
1270:         THIS.txt_4c__ds_moeda.Enabled = loc_lHab
1271:         THIS.txt_4c_Empresa.Enabled   = loc_lHab
1272:         THIS.txt_4c_DEmpresa.Enabled  = loc_lHab
1273: 
1274:         THIS.grd_4c_Dados.Enabled          = loc_lHab
1275:         THIS.obj_4c_CmdBtnGrade.Enabled    = loc_lHab
1276:         THIS.cmd_4c_Processa.Enabled       = loc_lHab
1277: 
1278:         THIS.Refresh()
1279:     ENDPROC
1280: 
1281:     *==========================================================================
1282:     * AjustarBotoesPorModo - PUBLIC (o harness de teste chama direto no oForm,
1283:     * de FORA da classe - por isso NAO pode ser PROTECTED, regra #3
1284:     * CLAUDE.md). Reavalia os botoes conforme o estado REAL da grade: com a
1285:     * grade sem nenhuma linha (RECCOUNT do cursor de operacoes igual a zero),
1286:     * Processar e Marcar/Desmarcar ficam desabilitados, porque nao ha o que
1287:     * marcar nem o que processar; com a grade contendo linhas, os dois ficam
1288:     * habilitados normalmente.
1289:     *
1290:     * "Encerrar" permanece sempre habilitado (unica saida da tela, que e'
1291:     * modal com ControlBox = .F. - desabilitar prenderia o usuario).
1292:     *==========================================================================
1293:     PROCEDURE AjustarBotoesPorModo()
1294:         LOCAL loc_cCursor, loc_lTemLinhas
1295: 
1296:         loc_lTemLinhas = .F.
1297: 
1298:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1299:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1300:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1301:                 loc_lTemLinhas = (RECCOUNT(loc_cCursor) > 0)
1302:             ENDIF
1303:         ENDIF
1304: 
1305:         THIS.cmd_4c_Processa.Enabled    = loc_lTemLinhas
1306:         THIS.obj_4c_CmdBtnGrade.Enabled = loc_lTemLinhas
1307:         THIS.grd_4c_Dados.Enabled       = loc_lTemLinhas
1308: 
1309:         THIS.cmd_4c_Cancela.Enabled = .T.
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     PROCEDURE Destroy()
1314:     *==========================================================================
1315:         LOCAL loc_cCursor, loc_cOrigem
1316: 
1317:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1318:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1319:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1320:                 USE IN (loc_cCursor)
1321:             ENDIF
1322: 
1323:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
1324:             IF !EMPTY(loc_cOrigem) AND USED(loc_cOrigem)
1325:                 USE IN (loc_cOrigem)
1326:             ENDIF
1327: 
1328:             THIS.this_oBusinessObject = .NULL.
1329:         ENDIF
1330:         DODEFAULT()
1331:     ENDPROC
1332: 
1333: ENDDEFINE

