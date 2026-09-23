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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTPG.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (902 linhas total):

*-- Linhas 12 a 211:
12: *     (no legado, o clique de Encerrar tambem valida a grade e grava tudo
13: *     via poDataMgr.Update+Commit antes de fechar - ver comportamento.json)
14: *
15: * Fase 3/8 - Estrutura base: propriedades, Init, InicializarForm, cabecalho
16: * Fase 4/8 - Grid editavel + botoes Incluir/Excluir/Encerrar
17: *   A grade legada eh editada linha-a-linha em memoria e so persiste tudo
18: *   no clique de Encerrar (poDataMgr.Update+Commit, modelo bufferizado).
19: *   BusinessBase/DataAccess desta arquitetura nao tem commit em lote, entao
20: *   a adaptacao persiste linha a linha (Salvar()/ExcluirPorChave() por
21: *   registro) preservando o MESMO resultado final que o usuario ve: a
22: *   validacao (Empty(Emps)/Empty(Tps)) roda ANTES de qualquer gravacao,
23: *   igual ao legado, e Excluir remove o registro na hora (nao bufferiza).
24: *   Sem AlternarPagina(): este form eh flat/single-page (sem PageFrame,
25: *   ver Fase 3) - nao existe segunda pagina para alternar. Criar um metodo
26: *   vazio so para "existir" seria um stub disfarcado (proibido).
27: * Fase 5/8 - N/A (ConfigurarPaginaDados / campos de Page2): o SIGCDTPG legado
28: *   nao tem segunda pagina de edicao (analise.json: campos=[], labels=[];
29: *   layout.json: 16 objetos, todos ja cobertos nas Fases 3-4). Os 3 unicos
30: *   dados (Emps/TpTrans/Tps) sao editados direto nas colunas do Grid1, ja
31: *   migradas em ConfigurarGrid()/ConfigurarGridDados() (Fase 4). Mesma
32: *   excecao que o CLAUDE.md ja documenta para FormFpd/FormGcp: form sem
33: *   pagina de dados real. Adicionar um ConfigurarPaginaDados() vazio so
34: *   para bater com o template das Fases 5-7 seria o mesmo stub disfarcado
35: *   vetado acima para AlternarPagina() - por isso a Fase 5 nao alterou
36: *   este arquivo.
37: * Fase 7/8 - N/A (BtnAlterarClick/BtnVisualizarClick): o SIGCDTPG legado
38: *   (SECAO 1 do dump) tem SOMENTE 3 CommandButtons - cmdinserir, cmdexcluir
39: *   e Command3 "Encerrar" dentro de Commandgroup1 (ButtonCount=1). NAO
40: *   existe Alterar nem Visualizar no original. A edicao dos dados eh feita
41: *   direto nas celulas do Grid1 (Column1/2/3.Text1.ControlSource ligado a
42: *   crSigPrTrn.Emps/TpTrans/Tps, com Valid por coluna) - ja migrada como
43: *   Col1EmpsKeyPress/Col2TpTransKeyPress/Col3TpsKeyPress na Fase 6.
44: *   BtnIncluirClick e BtnExcluirClick (os 2 unicos botoes CRUD do legado)
45: *   ja foram implementados na Fase 4, e BtnEncerrarClick (o Command3 -
46: *   equivalente ao "Salvar" deste form) tambem. Criar BtnAlterarClick/
47: *   BtnVisualizarClick vazios so para bater com o template das fases
48: *   seria tanto um stub disfarcado (proibido) quanto uma funcionalidade
49: *   inventada sem base no legado (viola o PILAR 1) - por isso a Fase 7
50: *   nao alterou os metodos de clique deste form.
51: * Fase 6/8 - Lookups das 3 colunas do Grid1 (fonte: SIGCDTPG_form_codigo_
52: *   fonte.txt, secao 3, Valid de Column1/Column2/Column3.Text1):
53: *   - Column1 (Emps): legado chama fAcessoEmpresa(Usuar,'C',...) - funcao
54: *     NAO portada (lesson feedback_facessoempresa_nao_portada). Substituida
55: *     pelo padrao canonico: valida existencia em SigCdEmp e abre
56: *     AbrirLookupCanonico("SigCdEmp","cemps","razas",...) quando nao acha
57: *     ou quando o usuario pede F4.
58: *   - Column2 (TpTrans): legado chama CreateObject('fwBuscaSel',
59: *     'crSigPrTrn','Codigos',...) com mAddColuna('Codigos'.../'Descrs'...).
60: *     'crSigPrTrn' e o alias do cursor principal (carregado de SigPrTra no
61: *     Init, que NAO tem colunas Codigos/Descrs) - o SEEK/lookup so faz
62: *     sentido contra a tabela MESTRE SigPrTrn (schema: codigos char(6) +
63: *     descrs char(20), EXATAMENTE do tamanho de TpTrans e dos nomes de
64: *     coluna citados no mAddColuna). Nome copiado do original (fwBuscaSel
65: *     recebe o mesmo texto 'SigPrTrn' sem o prefixo de cursor 'cr') -
66: *     NAO e tabela inventada.
67: *   - Column3 (Tps): legado so restringe a INLIST('T','R'), sem lookup.
68: *   - Os 3 Valid do legado terminam com a MESMA checagem de duplicidade
69: *     (Emps+TpTrans+Tps ja cadastrado em outra linha) - replicada em
70: *     ValidarDuplicidadeLinha(), chamada pelos 3 handlers apos a validacao
71: *     especifica de cada coluna.
72: * Fase 8/8 - Consolidacao final. O template generico desta fase pede
73: *   BtnBuscarClick/BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
74: *   HabilitarCampos/LimparCampos/CarregarLista(no Form)/AjustarBotoesPorModo
75: *   - nenhum tem base no SIGCDTPG legado (mesmo raciocinio ja registrado
76: *   nas Fases 5 e 7): nao ha botao Buscar (a lista carrega tudo no Init);
77: *   nao ha Salvar/Cancelar por registro nem modos INCLUIR/ALTERAR/
78: *   VISUALIZAR (edicao eh direto na celula do grid, ver Fase 6, e a
79: *   persistencia em lote acontece so no clique de Encerrar); nao ha
80: *   segunda pagina de dados, logo FormParaBO/BOParaForm/HabilitarCampos/
81: *   LimparCampos (que existem para sincronizar campos soltos de uma pagina
82: *   de edicao) nao tem o que fazer aqui - a "sincronizacao" equivalente ja
83: *   acontece linha a linha dentro do SCAN de BtnEncerrarClick. Adicionar
84: *   qualquer um desses metodos vazio ou com logica inventada seria stub
85: *   disfarcado (proibido) ou funcionalidade sem base no legado (viola o
86: *   PILAR 1). Ajustes reais desta fase: (1) BtnEncerrarClick agora marca
87: *   flagnovo=.F. apos cada linha persistida com sucesso - sem isso, um
88: *   reenvio apos falha parcial no SCAN tentava reinserir linha ja gravada
89: *   e colidia com a PK cidchaves; (2) integracao no menu (popMovimentos,
90: *   bar 125 -> AbrirFormTPG) - config.prg ja carrega TPGBO.prg/FormTPG.prg
91: *   automaticamente via ADIR, sem SET PROCEDURE manual (CLAUDE.md
92: *   "config.prg - Dynamic Loading").
93: *==============================================================================
94: SET SAFETY OFF
95: SET RESOURCE OFF
96: 
97: DEFINE CLASS FormTPG AS FormBase
98: 
99:     *-- Propriedades visuais (copiadas do SIGCDTPG.SCX original - PILAR 1)
100:     Width       = 592
101:     Height      = 408
102:     AutoCenter  = .T.
103:     Caption     = "Tipos de Transporte Autom" + CHR(225) + "tico"
104:     ShowWindow  = 1
105:     WindowType  = 1
106:     ControlBox  = .F.
107:     TitleBar    = 0
108:     BorderStyle = 2
109: 
110:     *==========================================================================
111:     * Init - DODEFAULT() ja chama FormBase.Init() -> THIS.InicializarForm()
112:     *==========================================================================
113:     PROCEDURE Init()
114:         RETURN DODEFAULT()
115:     ENDPROC
116: 
117:     *==========================================================================
118:     * InicializarForm - Cria o Business Object e monta o cabecalho do form
119:     *==========================================================================
120:     PROTECTED PROCEDURE InicializarForm()
121:         LOCAL loc_lSucesso, loc_oErro
122:         loc_lSucesso = .F.
123: 
124:         TRY
125:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
126:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
127:             ENDIF
128: 
129:             THIS.this_oBusinessObject = CREATEOBJECT("TPGBO")
130:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
131:                 MsgErro("Erro ao criar TPGBO." + CHR(13) + ;
132:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
133:                         "FormTPG.InicializarForm")
134:             ELSE
135:                 THIS.ConfigurarPageFrame()
136: 
137:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
138:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
139: 
140:                 THIS.ConfigurarPaginaLista()
141:                 THIS.BindEventos()
142: 
143:                 *-- Pula carga SQL em modo de validacao de UI (sem conexao)
144:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
145:                     THIS.this_oBusinessObject.CarregarLista()
146:                 ENDIF
147:                 THIS.ConfigurarGridDados()
148: 
149:                 THIS.TornarControlesVisiveis(THIS)
150: 
151:                 loc_lSucesso = .T.
152:             ENDIF
153: 
154:         CATCH TO loc_oErro
155:             MsgErro(loc_oErro.Message + CHR(13) + ;
156:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
157:                     "Procedure: " + loc_oErro.Procedure, ;
158:                     "Erro em FormTPG.InicializarForm")
159:         ENDTRY
160: 
161:         RETURN loc_lSucesso
162:     ENDPROC
163: 
164:     *==========================================================================
165:     * ConfigurarPageFrame - Cria o cabecalho do form operacional
166:     * Form OPERACIONAL sem PageFrame (SIGCDTPG legado eh single-page: o
167:     * Grid1 e os botoes Incluir/Excluir/Encerrar ficam direto na THIS)
168:     * Fase 3: apenas o cabecalho (cnt_4c_Cabecalho)
169:     * Fase 4: grade de tipos de transporte + botoes Incluir/Excluir/Encerrar
170:     *==========================================================================
171:     PROTECTED PROCEDURE ConfigurarPageFrame()
172:         LOCAL loc_oErro
173: 
174:         TRY
175:             *-- Cabecalho escuro (cntSombra do legado: Top=-2, Left=-2, W=800, H=80)
176:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
177:             WITH THIS.cnt_4c_Cabecalho
178:                 .Top         = -2
179:                 .Left        = -2
180:                 .Width       = THIS.Width
181:                 .Height      = 80
182:                 .BackStyle   = 1
183:                 .BackColor   = RGB(100, 100, 100)
184:                 .BorderWidth = 0
185:                 .Visible     = .T.
186:             ENDWITH
187: 
188:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
189:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
190:                 .FontBold  = .T.
191:                 .FontName  = "Tahoma"
192:                 .FontSize  = 18
193:                 .WordWrap  = .T.
194:                 .Alignment = 0
195:                 .BackStyle = 0
196:                 .AutoSize  = .F.
197:                 .Caption   = ""
198:                 .Height    = 40
199:                 .Left      = 10
200:                 .Top       = 18
201:                 .Width     = THIS.Width - 20
202:                 .ForeColor = RGB(0, 0, 0)
203:             ENDWITH
204: 
205:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
206:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
207:                 .FontBold  = .T.
208:                 .FontName  = "Tahoma"
209:                 .FontSize  = 18
210:                 .WordWrap  = .T.
211:                 .Alignment = 0

*-- Linhas 222 a 306:
222:         CATCH TO loc_oErro
223:             MsgErro(loc_oErro.Message + CHR(13) + ;
224:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
225:                     "Procedure: " + loc_oErro.Procedure, ;
226:                     "Erro em FormTPG.ConfigurarPageFrame")
227:         ENDTRY
228:     ENDPROC
229: 
230:     *==========================================================================
231:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
232:     * Sem containers flutuantes neste form (nenhum Visible=.F. proposital)
233:     *==========================================================================
234:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
235:         LOCAL loc_nI, loc_oControl
236: 
237:         FOR loc_nI = 1 TO par_oContainer.ControlCount
238:             loc_oControl = par_oContainer.Controls(loc_nI)
239:             IF VARTYPE(loc_oControl) = "O"
240:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
241:                     loc_oControl.Visible = .T.
242:                 ENDIF
243:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
244:                    loc_oControl.ControlCount > 0
245:                     THIS.TornarControlesVisiveis(loc_oControl)
246:                 ENDIF
247:             ENDIF
248:         ENDFOR
249:     ENDPROC
250: 
251:     *==========================================================================
252:     * ConfigurarPaginaLista - Orquestra a montagem da grade e dos botoes
253:     * (unico "pagina" deste form flat/single-page - ver nota de cabecalho)
254:     *==========================================================================
255:     PROTECTED PROCEDURE ConfigurarPaginaLista()
256:         THIS.ConfigurarGrid()
257:         THIS.ConfigurarBotoesCrud()
258:         THIS.ConfigurarBotaoEncerrar()
259:     ENDPROC
260: 
261:     *==========================================================================
262:     * ConfigurarGrid - Grid1 do legado -> grd_4c_Dados (3 colunas editaveis)
263:     * Posicoes EXATAS do SIGCDTPG.SCX (Top=96,Left=201,W=233,H=308) - form eh
264:     * flat/sem PageFrame (Fase 3), entao nao ha compensacao de +29 no Top
265:     *==========================================================================
266:     PROTECTED PROCEDURE ConfigurarGrid()
267:         LOCAL loc_oGrid, loc_oCol
268: 
269:         THIS.AddObject("grd_4c_Dados", "Grid")
270:         loc_oGrid = THIS.grd_4c_Dados
271: 
272:         WITH loc_oGrid
273:             .Top           = 96
274:             .Left          = 201
275:             .Width         = 233
276:             .Height        = 308
277:             .ColumnCount   = 3
278:             .FontName      = "Tahoma"
279:             .FontSize      = 8
280:             .DeleteMark    = .F.
281:             .RecordMark    = .F.
282:             .RowHeight     = 16
283:             .ScrollBars    = 2
284:             .ForeColor     = RGB(90, 90, 90)
285:             .GridLineColor = RGB(238, 238, 238)
286:             .Visible       = .T.
287:         ENDWITH
288: 
289:         *-- Column1: Empresa (Emps) - alinhado a direita
290:         loc_oCol = loc_oGrid.Column1
291:         WITH loc_oCol
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .Alignment = 3
295:             .Width     = 56
296:             .ForeColor = RGB(90, 90, 90)
297:         ENDWITH
298:         loc_oCol.Header1.Caption   = "Empresa"
299:         loc_oCol.Header1.FontName  = "Tahoma"
300:         loc_oCol.Header1.FontSize  = 8
301:         loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
302:         loc_oCol.Text1.FontName    = "Tahoma"
303:         loc_oCol.Text1.FontSize    = 8
304:         loc_oCol.Text1.Alignment   = 3
305:         loc_oCol.Text1.BorderStyle = 0
306:         loc_oCol.Text1.Margin      = 0

*-- Linhas 352 a 426:
352:     * ConfigurarGridDados - Liga o grid ao cursor_4c_Dados (chamado apos
353:     * THIS.this_oBusinessObject.CarregarLista() preencher o cursor)
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarGridDados()
356:         LOCAL loc_oGrid
357:         loc_oGrid = THIS.grd_4c_Dados
358: 
359:         loc_oGrid.RecordSource = ""
360:         loc_oGrid.ColumnCount  = 3
361: 
362:         IF USED("cursor_4c_Dados")
363:             loc_oGrid.RecordSource = "cursor_4c_Dados"
364:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
365:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tptrans"
366:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tps"
367:         ENDIF
368: 
369:         *-- RecordSource reseta Width/Header1.Caption (Problema 48) - reaplicar
370:         loc_oGrid.Column1.Width            = 56
371:         loc_oGrid.Column1.Header1.Caption  = "Empresa"
372:         loc_oGrid.Column2.Width            = 89
373:         loc_oGrid.Column2.Header1.Caption  = "Tipo de Transp."
374:         loc_oGrid.Column3.Width            = 56
375:         loc_oGrid.Column3.Header1.Caption  = "Tipo (T/R)"
376: 
377:         loc_oGrid.Refresh()
378:     ENDPROC
379: 
380:     *==========================================================================
381:     * ConfigurarBotoesCrud - cnt_4c_Botoes com cmd_4c_Incluir/cmd_4c_Excluir
382:     * Posicoes EXATAS do legado: cmdinserir Left=366/Top=2, cmdexcluir
383:     * Left=441/Top=2, ambos filhos diretos de SIGCDTPG (sem container la;
384:     * agrupados aqui num container transparente so por organizacao interna)
385:     *==========================================================================
386:     PROTECTED PROCEDURE ConfigurarBotoesCrud()
387:         LOCAL loc_oCnt
388: 
389:         THIS.AddObject("cnt_4c_Botoes", "Container")
390:         loc_oCnt = THIS.cnt_4c_Botoes
391:         WITH loc_oCnt
392:             .Top         = 2
393:             .Left        =  542
394:             .Width       = 150
395:             .Height      = 75
396:             .BackStyle   = 0
397:             .BorderWidth = 0
398:             .Visible     = .T.
399:         ENDWITH
400: 
401:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
402:         WITH loc_oCnt.cmd_4c_Incluir
403:             .Top            = 0
404:             .Left           = 0
405:             .Width          = 75
406:             .Height         = 75
407:             .Caption        = "\<Incluir"
408:             .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
409:             .FontBold       = .T.
410:             .FontItalic     = .T.
411:             .FontName       = "Comic Sans MS"
412:             .FontSize       = 8
413:             .ForeColor      = RGB(90, 90, 90)
414:             .BackColor      = RGB(255, 255, 255)
415:             .Themes         = .F.
416:             .SpecialEffect  = 0
417:             .PicturePosition = 13
418:             .MousePointer   = 15
419:             .WordWrap       = .T.
420:             .AutoSize       = .F.
421:             .Visible        = .T.
422:         ENDWITH
423: 
424:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
425:         WITH loc_oCnt.cmd_4c_Excluir
426:             .Top            = 0

*-- Linhas 452 a 558:
452:     * Left=917 do CLAUDE.md #10, porque esse padrao vale so para forms CRUD
453:     * (frmcadastro, Width=1000); este eh OPERACIONAL flat com Width=592
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
456:         LOCAL loc_oCnt
457: 
458:         THIS.AddObject("cnt_4c_Saida", "Container")
459:         loc_oCnt = THIS.cnt_4c_Saida
460:         WITH loc_oCnt
461:             .Top         = 1
462:             .Left        = 917
463:             .Width       = 90
464:             .Height      = 110
465:             .BackStyle   = 0
466:             .BorderWidth = 0
467:             .Visible     = .T.
468:         ENDWITH
469: 
470:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
471:         WITH loc_oCnt.cmd_4c_Encerrar
472:             .Top             = 1
473:             .Left            = 5
474:             .Width           = 75
475:             .Height          = 75
476:             .Caption         = "Encerrar"
477:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
478:             .FontBold        = .T.
479:             .FontItalic      = .T.
480:             .FontName        = "Comic Sans MS"
481:             .FontSize        = 8
482:             .ForeColor       = RGB(90, 90, 90)
483:             .BackColor       = RGB(255, 255, 255)
484:             .Themes          = .F.
485:             .SpecialEffect   = 0
486:             .PicturePosition = 13
487:             .MousePointer    = 15
488:             .WordWrap        = .T.
489:             .AutoSize        = .F.
490:             .Cancel          = .T.
491:             .Visible         = .T.
492:         ENDWITH
493:     ENDPROC
494: 
495:     *==========================================================================
496:     * BindEventos - Liga os cliques dos 3 botoes aos handlers (PUBLIC,
497:     * regra #3 - BINDEVENT exige metodo publico)
498:     *==========================================================================
499:     PROTECTED PROCEDURE BindEventos()
500:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
501:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
502:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
503: 
504:         *-- Lookups/validacao das 3 colunas editaveis do grid (Fase 6)
505:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "Col1EmpsKeyPress")
506:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "Col2TpTransKeyPress")
507:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "Col3TpsKeyPress")
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * Col1EmpsKeyPress - Column1.Text1 (Emps) KeyPress. Equivalente ao Valid
512:     * legado: fAcessoEmpresa(Usuar,'C',...) (funcao nao portada - lesson
513:     * feedback_facessoempresa_nao_portada) foi substituida por: F4 sempre
514:     * abre o lookup de Empresa; Enter/Tab valida existencia em SigCdEmp e,
515:     * se nao achar, abre o mesmo lookup. Ao final roda a checagem de
516:     * duplicidade Emps+TpTrans+Tps (igual nos 3 Valid do legado).
517:     *==========================================================================
518:     PROCEDURE Col1EmpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
519:         LOCAL loc_oTxt, loc_cValor, loc_lAchou, loc_oErro
520: 
521:         IF INLIST(par_nKeyCode, 13, 9, 115)
522:             loc_oTxt = THIS.grd_4c_Dados.Column1.Text1
523: 
524:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
525:                 THIS.AbrirLookupEmpresa(loc_oTxt)
526:                 THIS.ValidarDuplicidadeLinha(1)
527:             ELSE
528:                 loc_cValor = ALLTRIM(NVL(loc_oTxt.Value, ""))
529: 
530:                 IF !EMPTY(loc_cValor)
531:                     loc_lAchou = .F.
532: 
533:                     TRY
534:                         IF USED("cursor_4c_LkpChk")
535:                             USE IN cursor_4c_LkpChk
536:                         ENDIF
537: 
538:                         IF SQLEXEC(gnConnHandle, ;
539:                                 "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor), ;
540:                                 "cursor_4c_LkpChk") > 0 AND ;
541:                            USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
542:                             loc_lAchou = .T.
543:                         ENDIF
544: 
545:                         IF USED("cursor_4c_LkpChk")
546:                             USE IN cursor_4c_LkpChk
547:                         ENDIF
548:                     CATCH TO loc_oErro
549:                         MsgErro(loc_oErro.Message, "FormTPG.Col1EmpsKeyPress")
550:                     ENDTRY
551: 
552:                     IF !loc_lAchou
553:                         THIS.AbrirLookupEmpresa(loc_oTxt)
554:                     ENDIF
555: 
556:                     THIS.ValidarDuplicidadeLinha(1)
557:                 ENDIF
558:             ENDIF

*-- Linhas 566 a 609:
566:     * SigPrTrn e, se nao achar, abre o mesmo lookup. Ao final roda a
567:     * checagem de duplicidade Emps+TpTrans+Tps.
568:     *==========================================================================
569:     PROCEDURE Col2TpTransKeyPress(par_nKeyCode, par_nShiftAltCtrl)
570:         LOCAL loc_oTxt, loc_cValor, loc_lAchou, loc_oErro
571: 
572:         IF INLIST(par_nKeyCode, 13, 9, 115)
573:             loc_oTxt = THIS.grd_4c_Dados.Column2.Text1
574: 
575:             IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
576:                 THIS.AbrirLookupTpTrans(loc_oTxt)
577:                 THIS.ValidarDuplicidadeLinha(2)
578:             ELSE
579:                 loc_cValor = ALLTRIM(NVL(loc_oTxt.Value, ""))
580: 
581:                 IF !EMPTY(loc_cValor)
582:                     loc_lAchou = .F.
583: 
584:                     TRY
585:                         IF USED("cursor_4c_LkpChk")
586:                             USE IN cursor_4c_LkpChk
587:                         ENDIF
588: 
589:                         IF SQLEXEC(gnConnHandle, ;
590:                                 "SELECT codigos FROM SigPrTrn WHERE codigos = " + EscaparSQL(loc_cValor), ;
591:                                 "cursor_4c_LkpChk") > 0 AND ;
592:                            USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
593:                             loc_lAchou = .T.
594:                         ENDIF
595: 
596:                         IF USED("cursor_4c_LkpChk")
597:                             USE IN cursor_4c_LkpChk
598:                         ENDIF
599:                     CATCH TO loc_oErro
600:                         MsgErro(loc_oErro.Message, "FormTPG.Col2TpTransKeyPress")
601:                     ENDTRY
602: 
603:                     IF !loc_lAchou
604:                         THIS.AbrirLookupTpTrans(loc_oTxt)
605:                     ENDIF
606: 
607:                     THIS.ValidarDuplicidadeLinha(2)
608:                 ENDIF
609:             ENDIF

*-- Linhas 616 a 735:
616:     * Invalida. Informe <T>ransporte <R>ecepcao". Se valido, roda a mesma
617:     * checagem de duplicidade dos outros 2 campos.
618:     *==========================================================================
619:     PROCEDURE Col3TpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
620:         LOCAL loc_oTxt, loc_cValor
621: 
622:         IF INLIST(par_nKeyCode, 13, 9)
623:             loc_oTxt   = THIS.grd_4c_Dados.Column3.Text1
624:             loc_cValor = UPPER(ALLTRIM(NVL(loc_oTxt.Value, "")))
625: 
626:             IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "T", "R")
627:                 MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. Informe <T>ransporte <R>ecepc" + CHR(227) + "o", ;
628:                          "Aten" + CHR(231) + CHR(227) + "o")
629:                 loc_oTxt.Value = ""
630:             ELSE
631:                 IF !EMPTY(loc_cValor)
632:                     THIS.ValidarDuplicidadeLinha(3)
633:                 ENDIF
634:             ENDIF
635:         ENDIF
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * AbrirLookupEmpresa - Lookup de Empresa (SigCdEmp.cemps/razas) para a
640:     * coluna Emps do grid, via helper canonico (FormBase.AbrirLookupCanonico)
641:     *==========================================================================
642:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
643:         THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
644:             "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
645:             ALLTRIM(NVL(par_oTxt.Value, "")), ;
646:             par_oTxt, .NULL.)
647:         THIS.grd_4c_Dados.Refresh()
648:     ENDPROC
649: 
650:     *==========================================================================
651:     * AbrirLookupTpTrans - Lookup de Tipo de Transporte (SigPrTrn.codigos/
652:     * descrs) para a coluna TpTrans do grid, via helper canonico
653:     *==========================================================================
654:     PROTECTED PROCEDURE AbrirLookupTpTrans(par_oTxt)
655:         THIS.AbrirLookupCanonico("SigPrTrn", "codigos", "descrs", ;
656:             "Tipo de Transporte", ;
657:             ALLTRIM(NVL(par_oTxt.Value, "")), ;
658:             par_oTxt, .NULL.)
659:         THIS.grd_4c_Dados.Refresh()
660:     ENDPROC
661: 
662:     *==========================================================================
663:     * ValidarDuplicidadeLinha - Replica a checagem repetida nos 3 Valid do
664:     * legado: apos editar Emps/TpTrans/Tps, verifica se ja existe OUTRA
665:     * linha com a MESMA combinacao (chave de negocio). Se achar, avisa,
666:     * limpa o campo que disparou a checagem e devolve o foco a ele - mesmo
667:     * efeito pratico do MessageBox + Return .f. do Valid legado.
668:     * par_nColuna: 1=Emps, 2=TpTrans, 3=Tps (indica qual Column limpar/focar)
669:     *==========================================================================
670:     PROTECTED PROCEDURE ValidarDuplicidadeLinha(par_nColuna)
671:         LOCAL loc_cEmp, loc_cTra, loc_cTps, loc_cChave, loc_nRegAtual, loc_oErro, loc_oCol
672: 
673:         IF USED("cursor_4c_Dados")
674:             DO CASE
675:             CASE par_nColuna = 1
676:                 loc_oCol = THIS.grd_4c_Dados.Column1
677:             CASE par_nColuna = 2
678:                 loc_oCol = THIS.grd_4c_Dados.Column2
679:             CASE par_nColuna = 3
680:                 loc_oCol = THIS.grd_4c_Dados.Column3
681:             ENDCASE
682: 
683:             TRY
684:                 SELECT cursor_4c_Dados
685:                 loc_nRegAtual = RECNO()
686:                 loc_cEmp      = emps
687:                 loc_cTra      = tptrans
688:                 loc_cTps      = tps
689:                 loc_cChave    = cidchaves
690: 
691:                 LOCATE FOR emps = loc_cEmp AND tptrans = loc_cTra AND ;
692:                            tps = loc_cTps AND cidchaves <> loc_cChave
693: 
694:                 IF !EOF()
695:                     MsgAviso("Tipo de Transfer" + CHR(234) + "ncia Cadastrada", ;
696:                              "Aten" + CHR(231) + CHR(227) + "o")
697:                     GO loc_nRegAtual IN cursor_4c_Dados
698:                     THIS.grd_4c_Dados.Refresh()
699:                     IF VARTYPE(loc_oCol) = "O"
700:                         loc_oCol.Text1.Value = ""
701:                         THIS.grd_4c_Dados.SetFocus()
702:                         loc_oCol.SetFocus()
703:                     ENDIF
704:                 ELSE
705:                     GO loc_nRegAtual IN cursor_4c_Dados
706:                     THIS.grd_4c_Dados.Refresh()
707:                 ENDIF
708:             CATCH TO loc_oErro
709:                 MsgErro(loc_oErro.Message + CHR(13) + ;
710:                         "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
711:                         "Erro em FormTPG.ValidarDuplicidadeLinha")
712:             ENDTRY
713:         ENDIF
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * BtnIncluirClick - cmdinserir do legado: reaproveita linha vazia
718:     * existente ou anexa uma nova (cidchaves = fUniqueIds()), navega para
719:     * ela (index EmpTp legado ordena vazios primeiro - replicado em
720:     * TPGBO.CarregarLista) e foca a 1a coluna da grade
721:     *==========================================================================
722:     FUNCTION BtnIncluirClick()
723:         LOCAL loc_oErro, loc_lProsseguir
724:         loc_lProsseguir = .T.
725: 
726:         TRY
727:             IF !USED("cursor_4c_Dados")
728:                 loc_lProsseguir = .F.
729:             ENDIF
730: 
731:             IF loc_lProsseguir
732:                 SELECT cursor_4c_Dados
733:                 LOCATE FOR EMPTY(emps) AND EMPTY(tptrans) AND EMPTY(tps)
734:                 IF EOF()
735:                     APPEND BLANK

*-- Linhas 748 a 791:
748:         CATCH TO loc_oErro
749:             MsgErro(loc_oErro.Message + CHR(13) + ;
750:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
751:                     "Procedure: " + loc_oErro.Procedure, ;
752:                     "Erro em FormTPG.BtnIncluirClick")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * BtnExcluirClick - cmdexcluir do legado: exclui o registro corrente.
758:     * Linha ainda nao persistida (flagnovo) so sai do cursor; linha ja
759:     * gravada tambem eh removida de SigPrTra na hora (TPGBO.ExcluirPorChave)
760:     * - o legado bufferiza ate o Encerrar, aqui persiste de imediato porque
761:     * esta arquitetura (BusinessBase/DataAccess) nao tem commit em lote
762:     *==========================================================================
763:     FUNCTION BtnExcluirClick()
764:         LOCAL loc_oErro, loc_cChave, loc_lNovo, loc_cCidChaves, loc_lProsseguir
765:         loc_lProsseguir = .T.
766: 
767:         TRY
768:             IF !USED("cursor_4c_Dados")
769:                 loc_lProsseguir = .F.
770:             ENDIF
771: 
772:             IF loc_lProsseguir
773:                 SELECT cursor_4c_Dados
774:                 IF EOF()
775:                     loc_lProsseguir = .F.
776:                 ENDIF
777:             ENDIF
778: 
779:             IF loc_lProsseguir
780:                 IF !MsgConfirmaExclusao()
781:                     loc_lProsseguir = .F.
782:                 ENDIF
783:             ENDIF
784: 
785:             IF loc_lProsseguir
786:                 loc_cCidChaves = cursor_4c_Dados.cidchaves
787:                 loc_lNovo      = cursor_4c_Dados.flagnovo
788:                 loc_cChave     = ALLTRIM(cursor_4c_Dados.emps) + " - " + ;
789:                                   ALLTRIM(cursor_4c_Dados.tptrans) + " - " + ;
790:                                   ALLTRIM(cursor_4c_Dados.tps)
791: 

*-- Linhas 812 a 885:
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message + CHR(13) + ;
814:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
815:                     "Procedure: " + loc_oErro.Procedure, ;
816:                     "Erro em FormTPG.BtnExcluirClick")
817:         ENDTRY
818:     ENDPROC
819: 
820:     *==========================================================================
821:     * BtnEncerrarClick - Commandgroup1.Command3 do legado: valida TODAS as
822:     * linhas (Empty(Emps)/Empty(Tps) - a checagem de TpTrans esta comentada
823:     * no legado e por isso NAO entra aqui, regra #17), so entao grava linha
824:     * a linha via BusinessObject e fecha o form
825:     *==========================================================================
826:     FUNCTION BtnEncerrarClick()
827:         LOCAL loc_oErro, loc_lValido, loc_lSucesso
828:         loc_lValido  = .T.
829:         loc_lSucesso = .T.
830: 
831:         TRY
832:             IF USED("cursor_4c_Dados")
833:                 SELECT cursor_4c_Dados
834:                 GO TOP
835:                 SCAN
836:                     IF EMPTY(cursor_4c_Dados.emps)
837:                         MsgAviso("Empresa Inv" + CHR(225) + "lida !!", ;
838:                                  "Aten" + CHR(231) + CHR(227) + "o")
839:                         THIS.grd_4c_Dados.SetFocus()
840:                         THIS.grd_4c_Dados.Column1.SetFocus()
841:                         loc_lValido = .F.
842:                         EXIT
843:                     ENDIF
844:                     IF EMPTY(cursor_4c_Dados.tps)
845:                         MsgAviso("Tipo Inv" + CHR(225) + "lido !!", ;
846:                                  "Aten" + CHR(231) + CHR(227) + "o")
847:                         THIS.grd_4c_Dados.SetFocus()
848:                         THIS.grd_4c_Dados.Column3.SetFocus()
849:                         loc_lValido = .F.
850:                         EXIT
851:                     ENDIF
852:                 ENDSCAN
853:             ENDIF
854: 
855:             IF loc_lValido AND USED("cursor_4c_Dados")
856:                 SELECT cursor_4c_Dados
857:                 GO TOP
858:                 SCAN
859:                     IF cursor_4c_Dados.flagnovo
860:                         THIS.this_oBusinessObject.NovoRegistro()
861:                     ELSE
862:                         IF !THIS.this_oBusinessObject.EditarRegistro()
863:                             loc_lSucesso = .F.
864:                             EXIT
865:                         ENDIF
866:                     ENDIF
867: 
868:                     THIS.this_oBusinessObject.this_cCidChaves = cursor_4c_Dados.cidchaves
869:                     THIS.this_oBusinessObject.this_cEmps      = cursor_4c_Dados.emps
870:                     THIS.this_oBusinessObject.this_cTpTrans   = cursor_4c_Dados.tptrans
871:                     THIS.this_oBusinessObject.this_cTps       = cursor_4c_Dados.tps
872:                     THIS.this_oBusinessObject.this_cModulos   = ""
873: 
874:                     IF !THIS.this_oBusinessObject.Salvar()
875:                         loc_lSucesso = .F.
876:                         EXIT
877:                     ENDIF
878: 
879:                     *-- Marca a linha como persistida: sem isso, um novo clique
880:                     *-- em Encerrar apos falha EM OUTRA linha do SCAN tentaria
881:                     *-- inserir de novo esta linha (ja gravada) com o mesmo
882:                     *-- cidchaves, colidindo com a PK
883:                     REPLACE cursor_4c_Dados.flagnovo WITH .F.
884:                 ENDSCAN
885:             ELSE

*-- Linhas 894 a 902:
894:         CATCH TO loc_oErro
895:             MsgErro(loc_oErro.Message + CHR(13) + ;
896:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
897:                     "Procedure: " + loc_oErro.Procedure, ;
898:                     "Erro em FormTPG.BtnEncerrarClick")
899:         ENDTRY
900:     ENDPROC
901: 
902: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TPGBO.prg):
*==============================================================================
* TPGBO.prg - Business Object para Tipos de Transporte Automatico
*==============================================================================
* Tabela   : SigPrTra
* PK real  : cidchaves (CHAR 20, gerado por fUniqueIds)
* Chave neg: emps + tptrans + tps
* Herda de : BusinessBase (app\classes\businessbase.prg)
*
* Fase 1/8 - Propriedades e Init
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS TPGBO AS BusinessBase

    *==========================================================================
    *-- PROPRIEDADES DA TABELA SigPrTra (schema exato)
    *==========================================================================

    *-- Chave primaria real (gerada por fUniqueIds)
    this_cCidChaves = ""    && cidchaves CHAR(20) - PK

    *-- Chave de negocio composta: Emps + TpTrans + Tps
    this_cEmps      = ""    && emps      CHAR(3)  - Codigo da Empresa
    this_cTpTrans   = ""    && tptrans   CHAR(6)  - Codigo do Tipo de Transporte (FK SigPrTrn.codigos)
    this_cTps       = ""    && tps       CHAR(1)  - Tipo (T=Transporte / R=Recepcao)

    *-- Coluna NOT NULL sem campo na tela original (regra #22 CLAUDE.md)
    this_cModulos   = ""    && modulos   CHAR(1)  - Modulo (nao exibido no legado)

    *==========================================================================
    *-- INICIALIZACAO
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTra"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "TPGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- AUDITORIA: retorna PK real para RegistrarAuditoria()
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    *-- CarregarDoCursor - Carrega propriedades a partir de uma linha do
    *-- cursor de dados (crSigPrTrn no legado / cursor_4c_Dados no migrado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cTpTrans   = TratarNulo(TpTrans,   "C")
                THIS.this_cTps       = TratarNulo(Tps,       "C")
                THIS.this_cModulos   = TratarNulo(Modulos,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPGBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Inserir - Grava novo registro na tabela SigPrTra
    *-- Cobre TODAS as colunas NOT NULL (emps, tptrans, tps, cidchaves, modulos)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTra (emps, tptrans, tps, cidchaves, modulos)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cModulos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPGBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Atualizar - Atualiza registro existente na tabela SigPrTra
    *-- Chave de localizacao: cidchaves (PK real, imutavel)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTra
                SET emps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    tptrans = <<EscaparSQL(THIS.this_cTpTrans)>>,
                    tps     = <<EscaparSQL(THIS.this_cTps)>>,
                    modulos = <<EscaparSQL(THIS.this_cModulos)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPGBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- CarregarLista - Popula cursor_4c_Dados (READWRITE) com todos os
    *-- registros de SigPrTra, na ordem Emps+TpTrans+Tps (Index EmpTp legado)
    *-- Cursor precisa ser READWRITE porque a grade do form eh EDITAVEL
    *-- diretamente sobre as celulas (regra: grid editavel + cursor de
    *-- SQLEXEC = somente leitura)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, emps, tptrans, tps
                FROM SigPrTra
                ORDER BY emps, tptrans, tps
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT cidchaves, emps, tptrans, tps, .F. AS flagnovo ;
                    FROM cursor_4c_DadosTmp ;
                    INTO CURSOR cursor_4c_Dados READWRITE

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON emps + tptrans + tps TAG EmpTp
                SET ORDER TO TAG EmpTp
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "TPGBO.CarregarLista")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                        "TPGBO.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- ExcluirPorChave - Exclui diretamente um registro ja persistido de
    *-- SigPrTra pela PK real (cidchaves). Usado pela grade editavel do form,
    *-- que grava/exclui linha a linha (NUNCA chamar ExecutarExclusao() daqui
    *-- - este metodo eh o caminho publico equivalente para exclusao por
    *-- linha de grade, fora do fluxo de registro unico de BusinessBase)
    *==========================================================================
    FUNCTION ExcluirPorChave(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cCidChaves, "")))
            RETURN .F.
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigPrTra
                WHERE cidchaves = <<EscaparSQL(par_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                        "TPGBO.ExcluirPorChave")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

