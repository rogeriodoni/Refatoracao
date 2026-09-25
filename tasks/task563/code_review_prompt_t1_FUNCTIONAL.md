# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1332 linhas total):

*-- Linhas 5 a 150:
5: * Herda de: FormBase
6: * Tipo: OPERACIONAL (form de processamento em lote, SEM PageFrame Lista/Dados -
7: *       layout customizado: cabecalho + filtros de periodo/moeda/empresa +
8: *       grade de selecao de operacoes + botao Processar/Encerrar)
9: *
10: * FASE 4/8 - Grid de selecao de operacoes (grd_4c_Dados, espelha grdOperacaos
11: * + cursor csOperacaos do legado) e botoes Processar/Encerrar/Marcar-Desmarcar.
12: * Campos de filtro (Fases 5-6) e a logica pesada de processamento/validacao
13: * (Fases 7-8) sao adicionados nas fases seguintes - THIS.Processamento() e
14: * THIS.LimparTela() (equivalentes a ThisForm.Processamento/Limpatela do
15: * legado) sao chamados a partir daqui mas implementados so na Fase 7/8.
16: *
17: * FASE 5/8 - Primeira metade dos campos de filtro (grupo Periodo: getDtInicial/
18: * getDtFinal/Say1/Say6 + grupo Moeda: get_cd_moeda/lbl_moeda/get_ds_moeda),
19: * espelhando as posicoes exatas do SIGMVCMV.SCX original (form OPERACIONAL sem
20: * PageFrame - controles direto no form, sem compensacao de +29). Os handlers
21: * Valid com lookup (fwBuscaExt de moeda) e fAcessoEmpresa ficam para a Fase
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
253:             .FontName        = "Comic Sans MS"
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
280:             .FontName        = "Comic Sans MS"
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
582:         WITH THIS.grd_4c_Dados
583:             .ColumnCount       = 3
584:             .RecordSource      = loc_cCursor
585:             .HeaderHeight      = 0
586:             .DeleteMark        = .F.
587:             .RecordMark        = .F.
588:             .ReadOnly          = .F.
589:             .Top               = 165
590:             .Left              = 154
591:             .Width             = 247
592:             .Height            = 148
593:             .FontName          = "Tahoma"
594:             .FontSize          = 8
595:             .RowHeight         = 18
596:             .ScrollBars        = 2
597:             .GridLineColor     = RGB(238, 238, 238)
598:             .AllowHeaderSizing = .F.
599:             .AllowRowSizing    = .F.
600:             .TabIndex          = 12
601: 
602:             .Column1.Width        = 15
603:             .Column1.ControlSource = loc_cCursor + ".Marcas"
604:             .Column1.FontName     = "Courier New"
605:             .Column1.Movable      = .F.
606:             .Column1.Resizable    = .F.
607: 
608:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
609:             WITH .Column1.chk_4c_Check1
610:                 .Top       = 9
611:                 .Left      = 2
612:                 .Height    = 17
613:                 .Width     = 22
614:                 .FontName  = "Tahoma"
615:                 .Alignment = 0
616:                 .Caption   = ""
617:                 .Visible   = .T.

*-- Linhas 632 a 1332:
632:             .Column2.Text1.Margin      = 0
633: 
634:             .Visible = .T.
635:         ENDWITH
636: 
637:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "ChkMarcasClick")
638:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "ChkMarcasKeyPress")
639:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
640:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "ChkMarcasMouseUp")
641:     ENDPROC
642: 
643:     *==========================================================================
644:     * CarregarLista - PUBLIC (o harness de teste chama direto no oForm, e o
645:     * metodo tambem e' acionado pela propria tela). Popula a grade de selecao de
646:     * operacoes, espelhando o bloco do PROCEDURE Init legado:
647:     *
648:     *   Select crSigOpFin
649:     *   Scan
650:     *       Insert Into csOperacaos (Marcas, Operacaos, VisTit) ;
651:     *           Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
652:     *   Endscan
653:     *   Select csOperacaos
654:     *   Go Top
655:     *
656:     * Todas as linhas nascem MARCADAS (.T.), exatamente como no legado - o
657:     * usuario desmarca o que nao quer processar. O cursor da grade e' ZAPado
658:     * (nunca fechado/recriado): fechar quebraria o RecordSource do grid e
659:     * resetaria Column.Width/CurrentControl/Sparse ja configurados.
660:     *==========================================================================
661:     PROCEDURE CarregarLista()
662:         LOCAL loc_cCursor, loc_cOrigem, loc_nArea, loc_cDopes, loc_nVisTit, loc_oErro
663: 
664:         TRY
665:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
666:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
667:             loc_nArea   = SELECT()
668: 
669:             IF !USED(loc_cCursor)
670:                 THIS.CriarCursorOperacoes()
671:             ENDIF
672: 
673:             SELECT (loc_cCursor)
674:             ZAP
675: 
676:             *-- Sem conexao (modo de validacao de UI) a grade fica vazia, mas
677:             *-- o form abre normalmente - nao ha SQL para executar
678:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
679:                     AND THIS.this_oBusinessObject.CarregarOperacoes() ;
680:                     AND USED(loc_cOrigem)
681: 
682:                 SELECT (loc_cOrigem)
683:                 GO TOP
684:                 DO WHILE !EOF(loc_cOrigem)
685:                     loc_cDopes  = EVALUATE(loc_cOrigem + ".Dopes")
686:                     loc_nVisTit = NVL(EVALUATE(loc_cOrigem + ".VisTit"), 0)
687: 
688:                     INSERT INTO (loc_cCursor) (Marcas, Operacaos, VisTit) ;
689:                         VALUES (.T., loc_cDopes, loc_nVisTit)
690: 
691:                     SELECT (loc_cOrigem)
692:                     SKIP
693:                 ENDDO
694:             ENDIF
695: 
696:             *-- Popular o cursor NAO repinta a grade: o legado sempre fecha com
697:             *-- "Select csOperacaos / Go Top" + Refresh (regra #21 CLAUDE.md)
698:             SELECT (loc_cCursor)
699:             GO TOP
700:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
701:                 THIS.grd_4c_Dados.Refresh()
702:             ENDIF
703: 
704:             IF loc_nArea > 0
705:                 SELECT (loc_nArea)
706:             ENDIF
707:         CATCH TO loc_oErro
708:             MsgErro(loc_oErro.Message + CHR(13) + ;
709:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
710:                 "Procedure: " + loc_oErro.Procedure, ;
711:                 "Erro CarregarLista")
712:         ENDTRY
713:     ENDPROC
714: 
715:     *==========================================================================
716:     * ChkMarcasClick / ChkMarcasKeyPress / ChkMarcasMouseDown / ChkMarcasMouseUp
717:     * PUBLIC (BINDEVENT exige metodo publico - regra #3 CLAUDE.md). Espelham
718:     * SIGMVCMV.grdOperacaos.Column1.Check1 do legado: o toggle acontece no
719:     * KeyPress (Enter/Espaco) e no MouseDown; Click e MouseUp apenas suprimem
720:     * o comportamento nativo (NoDefault) para nao alternar em duplicidade.
721:     * NAO transcrito: o ramo "If nKeyCode = 9 -> ThisForm.opt_nr_tipo.Option1.
722:     * SetFocus" do KeyPress legado - opt_nr_tipo nao existe neste form (nao
723:     * consta na arvore de objetos do SIGMVCMV.SCX), e' codigo morto herdado
724:     * de copy-paste de outro form; reproduzi-lo quebraria com "Property
725:     * OPT_NR_TIPO is not found" ao pressionar Tab.
726:     *==========================================================================
727:     PROCEDURE ChkMarcasClick()
728:         NODEFAULT
729:     ENDPROC
730: 
731:     PROCEDURE ChkMarcasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
732:         LOCAL loc_cCursor, loc_nAreaAnterior
733: 
734:         IF INLIST(par_nKeyCode, 13, 32)
735:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
736:             IF USED(loc_cCursor)
737:                 loc_nAreaAnterior = SELECT()
738:                 SELECT (loc_cCursor)
739:                 IF !EOF()
740:                     REPLACE Marcas WITH !Marcas
741:                     THIS.grd_4c_Dados.Refresh()
742:                 ENDIF
743:                 SELECT (loc_nAreaAnterior)
744:             ENDIF
745:             NODEFAULT
746:         ENDIF
747:     ENDPROC
748: 
749:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
750:         LOCAL loc_cCursor, loc_nAreaAnterior
751: 
752:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
753:         IF USED(loc_cCursor)
754:             loc_nAreaAnterior = SELECT()
755:             SELECT (loc_cCursor)
756:             IF !EOF()
757:                 REPLACE Marcas WITH !Marcas
758:                 THIS.grd_4c_Dados.Refresh()
759:             ENDIF
760:             SELECT (loc_nAreaAnterior)
761:         ENDIF
762:         NODEFAULT
763:     ENDPROC
764: 
765:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
766:         NODEFAULT
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * CmdBtnGradeClick - PUBLIC (BINDEVENT). Marca/desmarca TODAS as linhas
771:     * da grade (espelha SIGMVCMV.cmdBtnGrade.Click: Value=1 -> btnMarcaTudo,
772:     * Value=2 -> btnDesmarcar).
773:     *==========================================================================
774:     PROCEDURE CmdBtnGradeClick()
775:         LOCAL loc_cCursor, loc_nAreaAnterior
776: 
777:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
778:         IF !USED(loc_cCursor)
779:             RETURN
780:         ENDIF
781: 
782:         loc_nAreaAnterior = SELECT()
783:         SELECT (loc_cCursor)
784: 
785:         DO CASE
786:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1
787:                 REPLACE ALL Marcas WITH .T.
788:                 GO TOP
789:                 THIS.grd_4c_Dados.Refresh()
790:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2
791:                 REPLACE ALL Marcas WITH .F.
792:                 GO TOP
793:                 THIS.grd_4c_Dados.Refresh()
794:         ENDCASE
795: 
796:         SELECT (loc_nAreaAnterior)
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * BtnCancelarClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Cancela.Click
801:     * ("Thisform.Release").
802:     *==========================================================================
803:     PROCEDURE BtnCancelarClick()
804:         THIS.Release()
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * BtnProcessaClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Processa.Click:
809:     * valida periodo informado + pelo menos uma operacao marcada + confirma,
810:     * depois delega para THIS.Processamento() e limpa a tela com
811:     * THIS.LimparTela(), na MESMA ordem do legado ("=ThisForm.Processamento()"
812:     * seguido de "=ThisForm.Limpatela()").
813:     *
814:     * FASE 8/8: a tela e' TRAVADA (HabilitarCampos(.F.)) durante o lote e
815:     * destravada logo apos - o processamento percorre todas as operacoes
816:     * marcadas gravando pares D/C em SigMvCcr e, sem o travamento, o usuario
817:     * consegue acionar Processar/marcar a grade no meio da gravacao. O
818:     * destravamento nao depende do resultado: Processamento() trata o proprio
819:     * erro no CATCH e nunca propaga, entao a linha seguinte sempre executa.
820:     *==========================================================================
821:     PROCEDURE BtnProcessaClick()
822:         LOCAL loc_cCursor, loc_lConfirmou
823: 
824:         IF EMPTY(THIS.txt_4c_DtInicial.Value) OR EMPTY(THIS.txt_4c_DtFinal.Value)
825:             MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", "Aten" + CHR(231) + CHR(227) + "o")
826:             THIS.txt_4c_DtInicial.SetFocus()
827:             RETURN
828:         ENDIF
829: 
830:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
831:         IF !USED(loc_cCursor)
832:             RETURN
833:         ENDIF
834: 
835:         SELECT (loc_cCursor)
836:         LOCATE FOR Marcas = .T.
837:         IF !FOUND()
838:             MsgAviso("Selecione uma Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
839:             THIS.grd_4c_Dados.Column1.SetFocus()
840:             RETURN
841:         ENDIF
842: 
843:         loc_lConfirmou = MsgConfirma("Confirma o Processamento?", "Aten" + CHR(231) + CHR(227) + "o")
844:         IF !loc_lConfirmou
845:             RETURN
846:         ENDIF
847: 
848:         THIS.HabilitarCampos(.F.)
849:         THIS.Processamento()
850:         THIS.HabilitarCampos(.T.)
851: 
852:         THIS.LimparTela()
853: 
854:         *-- HabilitarCampos(.T.) reabilita tudo sem olhar a grade; este
855:         *-- AjustarBotoesPorModo devolve o estado REAL (grade vazia volta a
856:         *-- desabilitar Processar/Marcar). A grade NAO e' recarregada: no
857:         *-- legado csOperacaos e' montado UMA vez no Init (lista de operacoes
858:         *-- financeiras do cadastro, que o processamento nao altera), e
859:         *-- recarregar aqui remarcaria tudo com .T., jogando fora a selecao
860:         *-- que o usuario acabou de fazer.
861:         THIS.AjustarBotoesPorModo()
862:     ENDPROC
863: 
864:     *==========================================================================
865:     * LimparTela - PUBLIC (chamado por BtnProcessaClick e pelo harness de
866:     * teste). Espelha o PROCEDURE limpatela do legado: limpa os campos de
867:     * filtro (periodo, moeda, empresa) apos o processamento.
868:     *==========================================================================
869:     PROCEDURE LimparTela()
870:         LOCAL loc_oBO
871: 
872:         *-- Os seis filtros vivem no BO (fonte unica): zerar la' e deixar
873:         *-- BOParaForm escrever na tela reproduz exatamente o legado, que
874:         *-- atribui "" / Ctod('') aos seis campos e chama Refresh em cada um.
875:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
876:             loc_oBO = THIS.this_oBusinessObject
877:             loc_oBO.this_dDataInicial = {}
878:             loc_oBO.this_dDataFinal   = {}
879:             loc_oBO.this_cCdMoeda     = ""
880:             loc_oBO.this_cDsMoeda     = ""
881:             loc_oBO.this_cCdEmpresa   = ""
882:             loc_oBO.this_cDsEmpresa   = ""
883:         ENDIF
884: 
885:         THIS.BOParaForm()
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * Processamento - PUBLIC (chamado por BtnProcessaClick e pelo harness de
890:     * teste). Delega a geracao dos lancamentos D/C ao BO
891:     * (SIGMVCMVBO.ProcessarLancamentos) - que ja exibe MsgInfo/MsgErro/
892:     * MsgAviso em cada caminho de sucesso/falha (regra #20 CLAUDE.md: BO ja
893:     * reporta, o form nao precisa de ELSE duplicando a mensagem). So resta
894:     * ao form avisar sobre as operacoes que pedem visualizacao de titulos
895:     * (VisTit = 1): a tela SigMvTi2 do legado esta fora do acervo desta
896:     * migracao (ver SIGMVCMVBO.ContarOperacoesVisTit).
897:     *==========================================================================
898:     PROCEDURE Processamento()
899:         LOCAL loc_lSucesso, loc_oErro
900: 
901:         TRY
902:             *-- FormParaBO transfere os seis filtros da tela para o BO e
903:             *-- valida o periodo; sem ele o lote rodaria com os valores da
904:             *-- execucao anterior (o form OPERACIONAL nao fecha entre um
905:             *-- processamento e outro).
906:             IF THIS.FormParaBO()
907:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarLancamentos( ;
908:                     THIS.this_oBusinessObject.this_dDataInicial, ;
909:                     THIS.this_oBusinessObject.this_dDataFinal, ;
910:                     THIS.this_oBusinessObject.this_cCdEmpresa, ;
911:                     THIS.this_oBusinessObject.this_cCdMoeda)
912:             ENDIF
913: 
914:             IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdVisTit > 0
915:                 MsgAviso("Existem " + ALLTRIM(STR(THIS.this_oBusinessObject.this_nQtdVisTit)) + ;
916:                     " opera" + CHR(231) + CHR(245) + "o(" + CHR(245) + "es) marcada(s) que exige(m) " + ;
917:                     "visualiza" + CHR(231) + CHR(227) + "o de t" + CHR(237) + "tulos - tela ainda " + ;
918:                     "n" + CHR(227) + "o migrada (SigMvTi2). Consulte os t" + CHR(237) + "tulos " + ;
919:                     "diretamente no m" + CHR(243) + "dulo financeiro.", "Aten" + CHR(231) + CHR(227) + "o")
920:             ENDIF
921:         CATCH TO loc_oErro
922:             MsgErro(loc_oErro.Message + CHR(13) + ;
923:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
924:                 "Procedure: " + loc_oErro.Procedure, ;
925:                 "Erro Processamento")
926:         ENDTRY
927:     ENDPROC
928: 
929:     *==========================================================================
930:     * ValidarMoeda - PUBLIC (BINDEVENT KeyPress em txt_4c__cd_moeda). Espelha
931:     * o Valid original de get_cd_moeda: campo vazio limpa a descricao; digitado
932:     * tenta match exato em SigCdMoe.cmoes e, sem achar, delega para
933:     * AbrirBuscaMoeda (fwBuscaExt do legado ja mostrava o picker sempre que
934:     * nao achava registro exato).
935:     *==========================================================================
936:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
937:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
938: 
939:         IF !INLIST(par_nKeyCode, 13, 9, 115)
940:             RETURN
941:         ENDIF
942: 
943:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__cd_moeda.Value))
944: 
945:         IF EMPTY(loc_cValor)
946:             THIS.txt_4c__ds_moeda.Value = ""
947:             THIS.txt_4c__ds_moeda.Refresh()
948:             RETURN
949:         ENDIF
950: 
951:         IF USED("cursor_4c_LkpMoeda")
952:             USE IN cursor_4c_LkpMoeda
953:         ENDIF
954: 
955:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
956:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
957: 
958:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
959:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
960:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
961:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
962:             USE IN cursor_4c_LkpMoeda
963:         ELSE
964:             IF USED("cursor_4c_LkpMoeda")
965:                 USE IN cursor_4c_LkpMoeda
966:             ENDIF
967:             THIS.AbrirBuscaMoeda(loc_cValor)
968:         ENDIF
969: 
970:         THIS.txt_4c__cd_moeda.Refresh()
971:         THIS.txt_4c__ds_moeda.Refresh()
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * ValidarMoedaDesc - PUBLIC (BINDEVENT KeyPress em txt_4c__ds_moeda).
976:     * Espelha o Valid original de get_ds_moeda: campo vazio limpa o codigo;
977:     * digitado tenta match exato em SigCdMoe.dmoes e, sem achar, delega para
978:     * AbrirBuscaMoeda.
979:     *==========================================================================
980:     PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
981:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
982: 
983:         IF !INLIST(par_nKeyCode, 13, 9, 115)
984:             RETURN
985:         ENDIF
986: 
987:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c__ds_moeda.Value))
988: 
989:         IF EMPTY(loc_cValor)
990:             THIS.txt_4c__cd_moeda.Value = ""
991:             THIS.txt_4c__cd_moeda.Refresh()
992:             RETURN
993:         ENDIF
994: 
995:         IF USED("cursor_4c_LkpMoeda")
996:             USE IN cursor_4c_LkpMoeda
997:         ENDIF
998: 
999:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes = " + EscaparSQL(loc_cValor)
1000:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
1001: 
1002:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
1003:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
1004:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
1005:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
1006:             USE IN cursor_4c_LkpMoeda
1007:         ELSE
1008:             IF USED("cursor_4c_LkpMoeda")
1009:                 USE IN cursor_4c_LkpMoeda
1010:             ENDIF
1011:             THIS.AbrirBuscaMoeda(loc_cValor)
1012:         ENDIF
1013: 
1014:         THIS.txt_4c__cd_moeda.Refresh()
1015:         THIS.txt_4c__ds_moeda.Refresh()
1016:     ENDPROC
1017: 
1018:     *==========================================================================
1019:     * AbrirBuscaMoeda - PROTECTED. Abre o picker canonico (FormBase.
1020:     * AbrirLookupCanonico) filtrado pelo valor digitado (codigo OU
1021:     * descricao). Sem selecao (ESC), limpa os dois campos - espelha o ramo
1022:     * "If Lastkey() = 27" do Valid original.
1023:     *==========================================================================
1024:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_cValorDigitado)
1025:         LOCAL loc_lSelecionou
1026: 
1027:         loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdMoe", "cmoes", "dmoes", ;
1028:             "Sele" + CHR(231) + CHR(227) + "o de Moeda", par_cValorDigitado, ;
1029:             THIS.txt_4c__cd_moeda, THIS.txt_4c__ds_moeda)
1030: 
1031:         IF !loc_lSelecionou
1032:             THIS.txt_4c__cd_moeda.Value = ""
1033:             THIS.txt_4c__ds_moeda.Value = ""
1034:         ENDIF
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * ValidarEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_Empresa). O
1039:     * legado usa fAcessoEmpresa(Usuar, "C", This.Value, GetEmpresa, GetDEmpresa)
1040:     * - funcao global Fortyus NAO portada para a nova arquitetura (ver
1041:     * CLAUDE.md/skill vfp9-migration). Substituido pelo lookup canonico em
1042:     * SigCdEmp.cemps: campo vazio limpa a razao social; digitado tenta match
1043:     * exato e, sem achar, delega para AbrirBuscaEmpresa.
1044:     *==========================================================================
1045:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1046:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1047: 
1048:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1049:             RETURN
1050:         ENDIF
1051: 
1052:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_Empresa.Value))
1053: 
1054:         IF EMPTY(loc_cValor)
1055:             THIS.txt_4c_DEmpresa.Value = ""
1056:             THIS.txt_4c_DEmpresa.Refresh()
1057:             RETURN
1058:         ENDIF
1059: 
1060:         IF USED("cursor_4c_LkpEmpresa")
1061:             USE IN cursor_4c_LkpEmpresa
1062:         ENDIF
1063: 
1064:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
1065:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1066: 
1067:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1068:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1069:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1070:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1071:             USE IN cursor_4c_LkpEmpresa
1072:         ELSE
1073:             IF USED("cursor_4c_LkpEmpresa")
1074:                 USE IN cursor_4c_LkpEmpresa
1075:             ENDIF
1076:             THIS.AbrirBuscaEmpresa(loc_cValor)
1077:         ENDIF
1078: 
1079:         THIS.txt_4c_Empresa.Refresh()
1080:         THIS.txt_4c_DEmpresa.Refresh()
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * ValidarDEmpresa - PUBLIC (BINDEVENT KeyPress em txt_4c_DEmpresa).
1085:     * Espelha o When original ("Return Empty(ThisForm.getEmpresa.Value)") -
1086:     * so processa a digitacao quando o codigo da empresa esta vazio; caso
1087:     * contrario o campo Descricao fica so como espelho do lookup por codigo.
1088:     *==========================================================================
1089:     PROCEDURE ValidarDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1090:         LOCAL loc_cValor, loc_cSQL, loc_nResultado
1091: 
1092:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1093:             RETURN
1094:         ENDIF
1095: 
1096:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Empresa.Value))
1097:             RETURN
1098:         ENDIF
1099: 
1100:         loc_cValor = ALLTRIM(UPPER(THIS.txt_4c_DEmpresa.Value))
1101: 
1102:         IF EMPTY(loc_cValor)
1103:             THIS.txt_4c_Empresa.Value = ""
1104:             THIS.txt_4c_Empresa.Refresh()
1105:             RETURN
1106:         ENDIF
1107: 
1108:         IF USED("cursor_4c_LkpEmpresa")
1109:             USE IN cursor_4c_LkpEmpresa
1110:         ENDIF
1111: 
1112:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE razas = " + EscaparSQL(loc_cValor)
1113:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1114: 
1115:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1116:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1117:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1118:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1119:             USE IN cursor_4c_LkpEmpresa
1120:         ELSE
1121:             IF USED("cursor_4c_LkpEmpresa")
1122:                 USE IN cursor_4c_LkpEmpresa
1123:             ENDIF
1124:             THIS.AbrirBuscaEmpresa(loc_cValor)
1125:         ENDIF
1126: 
1127:         THIS.txt_4c_Empresa.Refresh()
1128:         THIS.txt_4c_DEmpresa.Refresh()
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * AbrirBuscaEmpresa - PROTECTED. Abre o picker canonico (FormBase.
1133:     * AbrirLookupCanonico) em SigCdEmp filtrado pelo valor digitado (codigo
1134:     * OU razao social). Sem selecao, limpa os dois campos.
1135:     *==========================================================================
1136:     PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cValorDigitado)
1137:         LOCAL loc_lSelecionou
1138: 
1139:         loc_lSelecionou = THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
1140:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", par_cValorDigitado, ;
1141:             THIS.txt_4c_Empresa, THIS.txt_4c_DEmpresa)
1142: 
1143:         IF !loc_lSelecionou
1144:             THIS.txt_4c_Empresa.Value  = ""
1145:             THIS.txt_4c_DEmpresa.Value = ""
1146:         ENDIF
1147:     ENDPROC
1148: 
1149:     *==========================================================================
1150:     * FormParaBO - PROTECTED (escopo HERDADO de FormBase, que declara
1151:     * "PROTECTED PROCEDURE FormParaBO"; em VFP9 o override de metodo
1152:     * PROTECTED continua PROTECTED, e chamar de fora estoura "Property
1153:     * FORMPARABO is not found" mesmo com PEMSTATUS devolvendo .T. - regra #3
1154:     * CLAUDE.md). So e' chamado por THIS.Processamento(), que esta' dentro da
1155:     * classe, entao o escopo herdado e' o correto aqui.
1156:     *
1157:     * Transfere os SEIS filtros da tela para o Business Object e valida o
1158:     * periodo. Retorna .T. quando o BO ficou apto a processar, .F. quando
1159:     * falta dado obrigatorio (ja exibindo o aviso e devolvendo o foco ao
1160:     * campo, como o Processa.Click legado).
1161:     *
1162:     * As datas passam por ConverterParaData(): o TextBox nasce com .Value = {}
1163:     * (DATE) mas o mesmo campo recebe DATETIME quando vem de coluna do SQL
1164:     * Server - ProcessarLancamentos monta DATETIME(YEAR(..),MONTH(..),DAY(..))
1165:     * e quebraria com o tipo errado (regra #16 CLAUDE.md).
1166:     *
1167:     * O periodo INVERTIDO (inicial > final) tambem e' barrado aqui: o legado
1168:     * nunca chega a esse caso porque o usuario preenche em ordem, mas o
1169:     * Between do processamento devolveria silenciosamente ZERO lancamentos e
1170:     * a tela anunciaria "processado" sem gravar nada.
1171:     *==========================================================================
1172:     PROTECTED FUNCTION FormParaBO()
1173:         LOCAL loc_lValido, loc_dIni, loc_dFim, loc_oBO
1174: 
1175:         loc_lValido = .F.
1176: 
1177:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1178:             MsgErro("Business Object n" + CHR(227) + "o inicializado.", "FormParaBO")
1179:         ELSE
1180:             loc_oBO  = THIS.this_oBusinessObject
1181:             loc_dIni = ConverterParaData(THIS.txt_4c_DtInicial.Value)
1182:             loc_dFim = ConverterParaData(THIS.txt_4c_DtFinal.Value)
1183: 
1184:             DO CASE
1185:                 CASE EMPTY(loc_dIni) OR EMPTY(loc_dFim)
1186:                     MsgAviso("Favor Informar o Per" + CHR(237) + "odo.", ;
1187:                         "Aten" + CHR(231) + CHR(227) + "o")
1188:                     THIS.txt_4c_DtInicial.SetFocus()
1189: 
1190:                 CASE loc_dIni > loc_dFim
1191:                     MsgAviso("Data inicial maior que a data final.", ;
1192:                         "Aten" + CHR(231) + CHR(227) + "o")
1193:                     THIS.txt_4c_DtInicial.SetFocus()
1194: 
1195:                 OTHERWISE
1196:                     loc_oBO.this_dDataInicial = loc_dIni
1197:                     loc_oBO.this_dDataFinal   = loc_dFim
1198:                     loc_oBO.this_cCdMoeda     = ALLTRIM(THIS.txt_4c__cd_moeda.Value)
1199:                     loc_oBO.this_cDsMoeda     = ALLTRIM(THIS.txt_4c__ds_moeda.Value)
1200:                     loc_oBO.this_cCdEmpresa   = ALLTRIM(THIS.txt_4c_Empresa.Value)
1201:                     loc_oBO.this_cDsEmpresa   = ALLTRIM(THIS.txt_4c_DEmpresa.Value)
1202:                     loc_lValido = .T.
1203:             ENDCASE
1204:         ENDIF
1205: 
1206:         RETURN loc_lValido
1207:     ENDFUNC
1208: 
1209:     *==========================================================================
1210:     * BOParaForm - PROTECTED (escopo HERDADO de FormBase, igual ao FormParaBO
1211:     * acima). Chamado por THIS.LimparTela(), de dentro da classe.
1212:     *
1213:     * Caminho inverso do FormParaBO: escreve os seis filtros guardados no BO
1214:     * de volta nos TextBox e da' Refresh em cada um, reproduzindo o bloco de
1215:     * Refresh do PROCEDURE limpatela legado.
1216:     *
1217:     * E' o UNICO ponto do form que escreve nesses seis campos a partir do
1218:     * estado do BO - LimparTela zera as propriedades e chama este metodo, em
1219:     * vez de repetir doze atribuicoes. Com o BO ausente (falha de conexao no
1220:     * InicializarForm) os campos sao apenas esvaziados, sem estourar.
1221:     *==========================================================================
1222:     PROTECTED PROCEDURE BOParaForm()
1223:         LOCAL loc_oBO
1224: 
1225:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1226:             loc_oBO = THIS.this_oBusinessObject
1227:             THIS.txt_4c_DtInicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
1228:             THIS.txt_4c_DtFinal.Value   = ConverterParaData(loc_oBO.this_dDataFinal)
1229:             THIS.txt_4c__cd_moeda.Value = loc_oBO.this_cCdMoeda
1230:             THIS.txt_4c__ds_moeda.Value = loc_oBO.this_cDsMoeda
1231:             THIS.txt_4c_Empresa.Value   = loc_oBO.this_cCdEmpresa
1232:             THIS.txt_4c_DEmpresa.Value  = loc_oBO.this_cDsEmpresa
1233:         ELSE
1234:             THIS.txt_4c_DtInicial.Value = {}
1235:             THIS.txt_4c_DtFinal.Value   = {}
1236:             THIS.txt_4c__cd_moeda.Value = ""
1237:             THIS.txt_4c__ds_moeda.Value = ""
1238:             THIS.txt_4c_Empresa.Value   = ""
1239:             THIS.txt_4c_DEmpresa.Value  = ""
1240:         ENDIF
1241: 
1242:         THIS.txt_4c_DtInicial.Refresh()
1243:         THIS.txt_4c_DtFinal.Refresh()
1244:         THIS.txt_4c__cd_moeda.Refresh()
1245:         THIS.txt_4c__ds_moeda.Refresh()
1246:         THIS.txt_4c_Empresa.Refresh()
1247:         THIS.txt_4c_DEmpresa.Refresh()
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * HabilitarCampos - PUBLIC. Trava (.F.) / destrava (.T.) os controles de
1252:     * entrada durante o processamento em lote. O form OPERACIONAL nao tem
1253:     * modo INCLUIR/ALTERAR: o unico estado em que a tela fica somente-leitura
1254:     * e' o intervalo em que ProcessarLancamentos percorre as operacoes
1255:     * marcadas gravando os pares D/C em SigMvCcr.
1256:     *
1257:     * "Encerrar" NUNCA e' desabilitado - o legado deixa o Cancela sempre
1258:     * acionavel, e desabilitar um CommandButton com icone faz o icone sumir
1259:     * na tela (botao vira retangulo cinza).
1260:     *==========================================================================
1261:     PROCEDURE HabilitarCampos(par_lHabilitar)
1262:         LOCAL loc_lHab
1263: 
1264:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1265: 
1266:         THIS.txt_4c_DtInicial.Enabled = loc_lHab
1267:         THIS.txt_4c_DtFinal.Enabled   = loc_lHab
1268:         THIS.txt_4c__cd_moeda.Enabled = loc_lHab
1269:         THIS.txt_4c__ds_moeda.Enabled = loc_lHab
1270:         THIS.txt_4c_Empresa.Enabled   = loc_lHab
1271:         THIS.txt_4c_DEmpresa.Enabled  = loc_lHab
1272: 
1273:         THIS.grd_4c_Dados.Enabled          = loc_lHab
1274:         THIS.obj_4c_CmdBtnGrade.Enabled    = loc_lHab
1275:         THIS.cmd_4c_Processa.Enabled       = loc_lHab
1276: 
1277:         THIS.Refresh()
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * AjustarBotoesPorModo - PUBLIC (o harness de teste chama direto no oForm,
1282:     * de FORA da classe - por isso NAO pode ser PROTECTED, regra #3
1283:     * CLAUDE.md). Reavalia os botoes conforme o estado REAL da grade: com a
1284:     * grade sem nenhuma linha (RECCOUNT do cursor de operacoes igual a zero),
1285:     * Processar e Marcar/Desmarcar ficam desabilitados, porque nao ha o que
1286:     * marcar nem o que processar; com a grade contendo linhas, os dois ficam
1287:     * habilitados normalmente.
1288:     *
1289:     * "Encerrar" permanece sempre habilitado (unica saida da tela, que e'
1290:     * modal com ControlBox = .F. - desabilitar prenderia o usuario).
1291:     *==========================================================================
1292:     PROCEDURE AjustarBotoesPorModo()
1293:         LOCAL loc_cCursor, loc_lTemLinhas
1294: 
1295:         loc_lTemLinhas = .F.
1296: 
1297:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1298:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1299:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1300:                 loc_lTemLinhas = (RECCOUNT(loc_cCursor) > 0)
1301:             ENDIF
1302:         ENDIF
1303: 
1304:         THIS.cmd_4c_Processa.Enabled    = loc_lTemLinhas
1305:         THIS.obj_4c_CmdBtnGrade.Enabled = loc_lTemLinhas
1306:         THIS.grd_4c_Dados.Enabled       = loc_lTemLinhas
1307: 
1308:         THIS.cmd_4c_Cancela.Enabled = .T.
1309:     ENDPROC
1310: 
1311:     *==========================================================================
1312:     PROCEDURE Destroy()
1313:     *==========================================================================
1314:         LOCAL loc_cCursor, loc_cOrigem
1315: 
1316:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1317:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
1318:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
1319:                 USE IN (loc_cCursor)
1320:             ENDIF
1321: 
1322:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
1323:             IF !EMPTY(loc_cOrigem) AND USED(loc_cOrigem)
1324:                 USE IN (loc_cOrigem)
1325:             ENDIF
1326: 
1327:             THIS.this_oBusinessObject = .NULL.
1328:         ENDIF
1329:         DODEFAULT()
1330:     ENDPROC
1331: 
1332: ENDDEFINE

