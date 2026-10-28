# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1066 linhas total):

*-- Linhas 33 a 259:
33: * dump (SECAO 1) nao declara PageFrame nenhum (raiz "Class: form" generico).
34: *
35: * Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init() (recebe
36: * par_oFormPai/par_cDopes/par_cEscolha), InicializarForm() (cria o Business
37: * Object, aparencia do form, faixa do cabecalho, posicionamento junto ao pai
38: * e desabilita o pai enquanto o dialogo estiver aberto) e
39: * TornarControlesVisiveis (AddObject cria com Visible=.F. por padrao).
40: *
41: * Fase 4/8 - Grade e botoes: ConfigurarGrade() monta a grade (GradeSubN ->
42: * grd_4c_Dados, 4 colunas CFOP/Obs/De/Ate) e ConfigurarBotoes() monta os
43: * tres botoes (cmdSair/cmdInserir/cmdExcluir -> cmd_4c_CmdSair/
44: * cmd_4c_CmdInserir/cmd_4c_CmdExcluir), com Inserir/Excluir Visible/Enabled
45: * conforme this_cEscolha (legado). CarregarGrade() popula o cursor de
46: * trabalho do Business Object (equivalente a TmpCfoOp) e vincula o grid a
47: * ele - chamado em InicializarForm, guardado por gb_4c_ValidandoUI.
48: *
49: * Fase 5/8 - Lookup da coluna CFOP: TextBoxCfopGridCfp_4c (classes\
50: * TextBoxGridLookup.prg), instalada em Column1 via AddObject + CurrentControl
51: * + Sparse = .F. (regra #18) - BINDEVENT em evento de celula de Grid NAO eh
52: * confiavel (regra #46). Valid/KeyPress(F4/F5) delegam para
53: * ValidarCfopGridExec()/AbrirLookupCfopGrade() (metodos PUBLIC deste form,
54: * chamados de fora da classe pela celula - mesma exigencia de BINDEVENT da
55: * regra #3), que reproduzem o fwBuscaExt do legado contra SigCdCfo.
56: *
57: * Fase 6/8 - Lookup das colunas de Observacao (Padrao/Inicial/Final):
58: * TextBoxObsGridCfp_4c (classes\TextBoxGridLookup.prg), instalada em
59: * Column2/Column3/Column4 com o mesmo padrao AddObject + CurrentControl +
60: * Sparse = .F. da Column1. Valid/KeyPress(F4/F5) delegam para
61: * ValidarObsGridExec()/AbrirLookupObsGrade() (metodos PUBLIC deste form),
62: * que reproduzem o fwBuscaExt do legado contra SigCdObs E a validacao
63: * cruzada entre as tres colunas da mesma linha (ObsInis <= ObsPads <=
64: * ObsFins). Este dialogo nao tem pagina de Dados/Salvar separada - toda a
65: * edicao acontece nas celulas da grade (Column1..4), por isso nao ha
66: * container de botoes Salvar/Cancelar equivalente ao CRUD Page2 (o
67: * "cnt_4c_BotoesAcao" do template generico de fase 6 nao se aplica a este
68: * form OPERACIONAL).
69: *
70: * Fase 7/8 - Eventos principais: este dialogo NAO segue o padrao CRUD
71: * Incluir/Alterar/Visualizar/Excluir (o legado SIGOPCFP so tem cmdInserir/
72: * cmdExcluir/cmdSair - nenhum Alterar nem Visualizar, a edicao eh direto
73: * nas celulas da grade). BtnInserirClick/BtnExcluirClick/BtnSairClick
74: * (BINDEVENT no Click dos 3 CommandButton de ConfigurarBotoes) transcrevem
75: * cmdInserir/cmdExcluir/cmdSair do legado; SigOpCfpBO.SalvarGrade() (nova)
76: * persiste as alteracoes linha a linha (Inserir/Atualizar/ExecutarExclusao
77: * ja existentes) com o MESMO resultado final do bulk Delete+Append do
78: * legado (PILAR 3 - arquitetura obrigatoriamente diferente). O When de
79: * cada coluna de Observacao (habilita so depois do CFOP preenchido) vai
80: * em CelulaObsGradeEditavel(), chamado por TextBoxObsGridCfp_4c.When().
81: *
82: * Fase 8/8 - Consolidacao final: Destroy() acrescenta a rede de seguranca
83: * que reabilita this_oParentForm/AjustarBotoesFormPai mesmo fora do caminho
84: * de sucesso de BtnSairClick, e fecha os cursores de trabalho deste dialogo
85: * (cursor_4c_Dados/this_cCursorGrade e cursor_4c_OopOriginais) antes de
86: * DODEFAULT() (CorretorAutomatico Pattern #145). Os metodos auxiliares do
87: * template generico de form CRUD (FormParaBO/BOParaForm, HabilitarCampos/
88: * LimparCampos, CarregarLista, AjustarBotoesPorModo, BtnSalvarClick/
89: * BtnCancelarClick/BtnBuscarClick/BtnEncerrarClick) NAO se aplicam a este
90: * form OPERACIONAL: nao ha Page1/Page2, a edicao eh direto nas celulas da
91: * grade (CarregarGrade/BtnInserirClick/BtnExcluirClick da fase 4/7 cobrem o
92: * equivalente de CarregarLista/Incluir/Excluir) e o "salvar" eh
93: * SalvarGrade(), chamado por BtnSairClick (fase 7) - o proprio botao
94: * "Encerrar" do legado (cmdSair). THIS.Release() em BtnSairClick eh seguro
95: * aqui (diferente de dialogo tipo FormBuscaAuxiliar/FormSigOpCbx): este
96: * dialogo nao devolve nenhum valor por property para o chamador ler depois
97: * do Show() - toda a persistencia ja aconteceu via SalvarGrade() antes do
98: * Release(), e o legado tambem nao expõe nenhum "Retorno" no Unload do
99: * SIGOPCFP original.
100: *
101: * Nota de integracao: diferente de form OPERACIONAL autonomo (menu ->
102: * AbrirForm<X>), este dialogo e filho MODAL do Cadastro de Operacoes
103: * (SigCdOpe) e exige par_oFormPai/par_cDopes/par_cEscolha na abertura -
104: * nao ha como abri-lo isolado pelo menu. A chamada
105: * CREATEOBJECT("FormSigOpCfp", ThisForm, <Dopes>, <pcEscolha>).Show() fica
106: * a cargo da migracao do form de Operacoes (SigCdOpe/FormOPE); confirmado
107: * por grep em 2026-10-23 que aquele form ainda esta por migrar - sem
108: * SET PROCEDURE nem item de menu proprios aqui, portanto.
109: *==============================================================================
110: 
111: DEFINE CLASS FormSigOpCfp AS FormBase
112: 
113:     *-- Propriedades visuais (legado SIGOPCFP.scx)
114:     Width        = 800
115:     Height       = 400
116:     BorderStyle  = 2
117:     ControlBox   = .F.
118:     Movable      = .F.
119:     ClipControls = .F.
120:     TitleBar     = 0
121:     WindowType   = 1
122:     ShowWindow   = 1
123: 
124:     *-- Parametros recebidos na abertura (legado: Lparameters poForm,
125:     *-- pnDataSes, pcEscolha - pnDataSes deixou de ser necessario, ver nota
126:     *-- no cabecalho do arquivo)
127:     this_oParentForm = .NULL.
128:     this_cDopes      = ""   && codigo da Operacao (legado "crSigCdOpe.Dopes")
129:     this_cEscolha    = ""   && legado "pcEscolha" - habilita Inserir/Excluir
130: 
131:     *--------------------------------------------------------------------------
132:     * Init - Recebe o form pai, o codigo da Operacao (Dopes) e o modo de
133:     * edicao, monta o Caption dinamico (legado: "Cfop's p/: " +
134:     * AllTrim(Proper(crSigCdOpe.Dopes))) e encaminha para
135:     * FormBase.Init()/InicializarForm().
136:     *--------------------------------------------------------------------------
137:     PROCEDURE Init(par_oFormPai, par_cDopes, par_cEscolha)
138:         THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
139:         THIS.this_cDopes      = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
140:         THIS.this_cEscolha    = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
141: 
142:         THIS.Caption = "Cfop's p/: " + ALLTRIM(PROPER(THIS.this_cDopes))
143: 
144:         RETURN DODEFAULT()
145:     ENDPROC
146: 
147:     *--------------------------------------------------------------------------
148:     * InicializarForm - Instancia o Business Object (repassando o codigo da
149:     * Operacao recebido no Init), monta a aparencia do form e a faixa do
150:     * cabecalho, posiciona o dialogo perto da grade da Lista do pai e
151:     * desabilita o pai enquanto o dialogo estiver aberto (legado: Init faz
152:     * "Thisform.ParentForm.Enabled = .F." + "Thisform.mCtrlBotoes(.F.)").
153:     * Monta a grade e os botoes (ConfigurarGrade/ConfigurarBotoes) e, fora do
154:     * modo de validacao de UI, carrega os Cfops ja permitidos (CarregarGrade).
155:     *--------------------------------------------------------------------------
156:     PROTECTED PROCEDURE InicializarForm()
157:         LOCAL loc_lSucesso, loc_oErro
158: 
159:         loc_lSucesso = .F.
160: 
161:         TRY
162:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCfpBO")
163: 
164:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
165:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
166: 
167:                 THIS.ConfigurarAparencia()
168:                 THIS.ConfigurarCabecalho()
169:                 THIS.ConfigurarGrade()
170:                 THIS.ConfigurarBotoes()
171:                 THIS.PosicionarJuntoAoFormPai()
172: 
173:                 IF VARTYPE(THIS.this_oParentForm) = "O"
174:                     THIS.this_oParentForm.Enabled = .F.
175:                 ENDIF
176:                 THIS.AjustarBotoesFormPai(.F.)
177: 
178:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
179:                     THIS.CarregarGrade()
180:                 ENDIF
181: 
182:                 THIS.TornarControlesVisiveis(THIS)
183: 
184:                 loc_lSucesso = .T.
185:             ELSE
186:                 MsgErro("Erro ao criar Business Object de Cfop's Permitidas " + ;
187:                     "para Opera" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
188:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
189:             ENDIF
190:         CATCH TO loc_oErro
191:             MsgErro(loc_oErro.Message + CHR(13) + ;
192:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
193:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpCfp")
194:         ENDTRY
195: 
196:         RETURN loc_lSucesso
197:     ENDPROC
198: 
199:     *--------------------------------------------------------------------------
200:     * ConfigurarAparencia - Fundo padrao do dialogo (legado: form.Picture =
201:     * ..\framework\imagens\new_background.jpg) e fonte base (Tahoma 8, igual
202:     * aos demais controles do dump).
203:     *--------------------------------------------------------------------------
204:     PROTECTED PROCEDURE ConfigurarAparencia()
205:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
206:         THIS.SetAll("FontName", "Tahoma")
207:         THIS.SetAll("FontSize", 8)
208:     ENDPROC
209: 
210:     *--------------------------------------------------------------------------
211:     * ConfigurarCabecalho - Faixa cinza do topo (legado: cntSombra), com os
212:     * dois labels de titulo sombra/frente (CLAUDE.md regra #11/#23). O legado
213:     * declara cntSombra.Width=800/labels.Width=769 (boilerplate do template
214:     * generico de frmcadastro, igual a FormSigOpCbx - mesmo dump, mesmos
215:     * valores) - cnt_4c_Sombra usa THIS.Width (regra #11, canonico); os
216:     * labels mantem a largura literal do dump (769 < 800, cabe inteiro na
217:     * area visivel, nao ha clipping).
218:     *--------------------------------------------------------------------------
219:     PROTECTED PROCEDURE ConfigurarCabecalho()
220:         THIS.AddObject("cnt_4c_Sombra", "Container")
221: 
222:         WITH THIS.cnt_4c_Sombra
223:             .Top         = 0
224:             .Left        = 0
225:             .Width       = THIS.Width
226:             .Height      = 80
227:             .BackColor   = RGB(100, 100, 100)
228:             .BorderWidth = 0
229:             .Visible     = .T.
230:         ENDWITH
231: 
232:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
233:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
234:             .Top       = 18
235:             .Left      = 10
236:             .Width     = 769
237:             .Height    = 40
238:             .FontName  = "Tahoma"
239:             .FontSize  = 18
240:             .FontBold  = .T.
241:             .Alignment = 0
242:             .BackStyle = 0
243:             .WordWrap  = .T.
244:             .ForeColor = RGB(0, 0, 0)
245:             .Caption   = THIS.Caption
246:             .Visible   = .T.
247:         ENDWITH
248: 
249:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
250:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
251:             .Top       = 17
252:             .Left      = 10
253:             .Width     = 769
254:             .Height    = 46
255:             .FontName  = "Tahoma"
256:             .FontSize  = 18
257:             .FontBold  = .T.
258:             .Alignment = 0
259:             .BackStyle = 0

*-- Linhas 278 a 414:
278:     * instanciacao standalone/teste, sem form pai). Falhando qualquer
279:     * checagem, o dialogo mantem o AutoCenter padrao herdado de FormBase.
280:     *--------------------------------------------------------------------------
281:     PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
282:         LOCAL loc_oGrade
283: 
284:         IF VARTYPE(THIS.this_oParentForm) != "O"
285:             RETURN
286:         ENDIF
287: 
288:         IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
289:             RETURN
290:         ENDIF
291: 
292:         IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
293:             RETURN
294:         ENDIF
295: 
296:         IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
297:             RETURN
298:         ENDIF
299: 
300:         loc_oGrade = THIS.this_oParentForm.pgf_4c_Paginas.Page1.grd_4c_Lista
301: 
302:         IF !PEMSTATUS(loc_oGrade, "Column1", 5) OR !PEMSTATUS(loc_oGrade, "Column3", 5)
303:             RETURN
304:         ENDIF
305: 
306:         THIS.AutoCenter = .F.
307:         THIS.Top  = THIS.this_oParentForm.Top + loc_oGrade.Top + 50
308:         THIS.Left = THIS.this_oParentForm.Left + loc_oGrade.Left + ;
309:             loc_oGrade.Column1.Width + loc_oGrade.Column3.Width + 16
310:     ENDPROC
311: 
312:     *--------------------------------------------------------------------------
313:     * AjustarBotoesFormPai - Legado "mCtrlBotoes(plHabilita)": percorre os
314:     * botoes CRUD do form pai e o botao de saida, habilitando/desabilitando
315:     * conforme par_lHabilita. No pai (form CRUD canonico) os botoes CRUD ficam
316:     * em pgf_4c_Paginas.Page1.cnt_4c_Botoes e o de saida em
317:     * pgf_4c_Paginas.Page1.cnt_4c_Saida (docs\framework_frmcadastro_layout.md) -
318:     * equivalente a Grupo_Op/Grupo_Saida.Sair do legado. Cada nivel e checado
319:     * com PEMSTATUS; sem a estrutura esperada (form pai ausente ou standalone/
320:     * teste), o metodo e no-op.
321:     *
322:     * Chamado com .F. no InicializarForm (legado: Init); com .T. no
323:     * BtnSairClick (legado: cmdSair.Click), nas proximas fases.
324:     *--------------------------------------------------------------------------
325:     PROTECTED PROCEDURE AjustarBotoesFormPai(par_lHabilita)
326:         LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_nI, loc_oCtrl
327: 
328:         IF VARTYPE(THIS.this_oParentForm) != "O"
329:             RETURN
330:         ENDIF
331: 
332:         IF !PEMSTATUS(THIS.this_oParentForm, "pgf_4c_Paginas", 5)
333:             RETURN
334:         ENDIF
335: 
336:         IF !PEMSTATUS(THIS.this_oParentForm.pgf_4c_Paginas, "Page1", 5)
337:             RETURN
338:         ENDIF
339: 
340:         loc_oPagina = THIS.this_oParentForm.pgf_4c_Paginas.Page1
341: 
342:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
343:             loc_oBotoes = loc_oPagina.cnt_4c_Botoes
344:             FOR loc_nI = 1 TO loc_oBotoes.ControlCount
345:                 loc_oCtrl = loc_oBotoes.Controls(loc_nI)
346:                 IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON" AND loc_oCtrl.Visible
347:                     loc_oCtrl.Enabled = par_lHabilita
348:                 ENDIF
349:             ENDFOR
350:         ENDIF
351: 
352:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
353:             loc_oSaida = loc_oPagina.cnt_4c_Saida
354:             FOR loc_nI = 1 TO loc_oSaida.ControlCount
355:                 loc_oCtrl = loc_oSaida.Controls(loc_nI)
356:                 IF UPPER(loc_oCtrl.BaseClass) = "COMMANDBUTTON"
357:                     loc_oCtrl.Enabled = par_lHabilita
358:                 ENDIF
359:             ENDFOR
360:         ENDIF
361:     ENDPROC
362: 
363:     *--------------------------------------------------------------------------
364:     * ConfigurarGrade - Monta a grade de Cfops permitidos (legado GradeSubN,
365:     * 4 colunas: CFOP/Obs/De/Ate - equivalentes a Cfops/ObsPads/ObsInis/
366:     * ObsFins de SigCdOop). Aqui so a ESTRUTURA visual (Width/Header/estilo
367:     * de cada coluna) - RecordSource/ControlSource ficam em CarregarGrade(),
368:     * DEPOIS do Business Object (re)criar o cursor de trabalho, porque
369:     * vincular antes seria descartado quando o cursor for recriado (mesmo
370:     * padrao de FormFpN.ConfigurarPaginaLista/CarregarDados). As colunas 1
371:     * (lookup de CFOP) e 2/3/4 (lookup de Observacao) recebem BINDEVENT nas
372:     * fases 5/6.
373:     *--------------------------------------------------------------------------
374:     PROTECTED PROCEDURE ConfigurarGrade()
375:         THIS.AddObject("grd_4c_Dados", "Grid")
376: 
377:         WITH THIS.grd_4c_Dados
378:             .Top           = 120
379:             .Left          = 281
380:             .Width         = 237
381:             .Height        = 221
382:             .ColumnCount   = 4
383:             .FontName      = "Tahoma"
384:             .FontSize      = 8
385:             .DeleteMark    = .F.
386:             .RecordMark    = .F.
387:             .RowHeight     = 16
388:             .ScrollBars    = 2
389:             .TabIndex      = 1
390:             .GridLineColor = RGB(238, 238, 238)
391:         ENDWITH
392: 
393:         WITH THIS.grd_4c_Dados.Column1
394:             .Width     = 80
395:             .Movable   = .F.
396:             .Resizable = .F.
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             WITH .Header1
400:                 .FontName  = "Tahoma"
401:                 .FontSize  = 8
402:                 .Alignment = 2
403:                 .Caption   = "CFOP"
404:                 .ForeColor = RGB(0, 0, 0)
405:             ENDWITH
406:             WITH .Text1
407:                 .FontName    = "Tahoma"
408:                 .FontSize    = 8
409:                 .BorderStyle = 0
410:                 .Margin      = 0
411:                 .ForeColor   = RGB(0, 0, 0)
412:                 .BackColor   = RGB(255, 255, 255)
413:             ENDWITH
414: 

*-- Linhas 533 a 576:
533:     * sempre disponivel, com Cancel=.T. (ESC aciona, igual ao legado). O
534:     * Click de cada botao fica para a fase 7/8.
535:     *--------------------------------------------------------------------------
536:     PROTECTED PROCEDURE ConfigurarBotoes()
537:         LOCAL loc_lHabilitaEdicao
538: 
539:         loc_lHabilitaEdicao = IIF(EMPTY(THIS.this_cEscolha), .T., ;
540:             INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR"))
541: 
542:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
543:         WITH THIS.cmd_4c_CmdInserir
544:             .Top             = 3
545:             .Left            = 575
546:             .Width           = 75
547:             .Height          = 75
548:             .Caption         = "\<Inserir"
549:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
550:             .FontName        = "Tahoma"
551:             .FontBold        = .T.
552:             .FontItalic      = .T.
553:             .FontSize        = 8
554:             .ForeColor       = RGB(90, 90, 90)
555:             .BackColor       = RGB(255, 255, 255)
556:             .Themes          = .T.
557:             .SpecialEffect   = 0
558:             .PicturePosition = 13
559:             .MousePointer    = 15
560:             .WordWrap        = .T.
561:             .AutoSize        = .F.
562:             .Visible         = loc_lHabilitaEdicao
563:             .Enabled         = loc_lHabilitaEdicao
564:         ENDWITH
565: 
566:         THIS.AddObject("cmd_4c_CmdExcluir", "CommandButton")
567:         WITH THIS.cmd_4c_CmdExcluir
568:             .Top             = 3
569:             .Left            = 650
570:             .Width           = 75
571:             .Height          = 75
572:             .Caption         = "\<Excluir"
573:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
574:             .FontName        = "Tahoma"
575:             .FontBold        = .T.
576:             .FontItalic      = .T.

*-- Linhas 612 a 1066:
612:             .Enabled         = .T.
613:         ENDWITH
614: 
615:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirClick")
616:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirClick")
617:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnInserirClick - Inclui linha em branco na grade (legado:
622:     * cmdInserir.Click: "Locate for Cfops = Space(10) / If Eof() / Insert
623:     * Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
624:     * fUniqueIds()) / Endif", reaproveitando a linha vazia se ja existir
625:     * uma - nunca abre uma segunda). this_oBusinessObject.NovoRegistro()
626:     * gera a chave (InicializarValoresPadrao -> fUniqueIds(), regra #22 -
627:     * PK Fortyus nunca pode nascer vazia) e zera as demais propriedades
628:     * (LimparDados tambem zera this_cDopes - reposto abaixo, igual ao
629:     * padrao de SigOpCflBO.this_cNums).
630:     *--------------------------------------------------------------------------
631:     PROCEDURE BtnInserirClick()
632:         LOCAL loc_cCursor
633: 
634:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
635:             RETURN
636:         ENDIF
637: 
638:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
639: 
640:         IF !USED(loc_cCursor)
641:             RETURN
642:         ENDIF
643: 
644:         SELECT (loc_cCursor)
645:         LOCATE FOR EMPTY(ALLTRIM(NVL(cfops, "")))
646: 
647:         IF EOF()
648:             THIS.this_oBusinessObject.NovoRegistro()
649:             THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
650: 
651:             SELECT (loc_cCursor)
652:             APPEND BLANK
653:             REPLACE dopes     WITH THIS.this_oBusinessObject.this_cDopes, ;
654:                     cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
655:                     cfops     WITH "", ;
656:                     cgrus     WITH "", ;
657:                     obspads   WITH 0, ;
658:                     obsinis   WITH 0, ;
659:                     obsfins   WITH 0
660:         ENDIF
661: 
662:         THIS.grd_4c_Dados.Refresh()
663:         THIS.grd_4c_Dados.Column1.SetFocus()
664:     ENDPROC
665: 
666:     *--------------------------------------------------------------------------
667:     * BtnExcluirClick - Remove a linha corrente da grade (legado:
668:     * cmdExcluir.Click: "If Not Eof() / Delete / Skip / Skip - 1 / Endif").
669:     * So marca a linha como deletada no cursor de trabalho - a exclusao
670:     * efetiva em SigCdOop (quando a linha ja existia la) acontece em
671:     * SalvarGrade(), no BtnSairClick, igual ao legado (que so regrava
672:     * SigCdOop ao sair do dialogo, nunca a cada clique em Excluir).
673:     *--------------------------------------------------------------------------
674:     PROCEDURE BtnExcluirClick()
675:         LOCAL loc_cCursor
676: 
677:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
678:             RETURN
679:         ENDIF
680: 
681:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
682: 
683:         IF !USED(loc_cCursor)
684:             RETURN
685:         ENDIF
686: 
687:         SELECT (loc_cCursor)
688:         IF !EOF()
689:             DELETE
690:             SKIP
691:             SKIP -1
692:         ENDIF
693: 
694:         THIS.grd_4c_Dados.Refresh()
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     * BtnSairClick - Fecha o dialogo (legado: cmdSair.Click). So tenta
699:     * gravar quando o dialogo estava em modo editavel (legado: "If
700:     * Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible") - em
701:     * VISUALIZAR (Inserir/Excluir ocultos pelo this_cEscolha) fecha direto,
702:     * sem tocar no banco. Falhando a gravacao (Cfop duplicado ou erro de
703:     * SQL - SigOpCfpBO.SalvarGrade ja exibiu o aviso/erro), o dialogo
704:     * PERMANECE aberto para o usuario corrigir, igual ao "Return .f." do
705:     * legado no meio do Click (nao reabilita o pai, nao libera o form).
706:     *--------------------------------------------------------------------------
707:     PROCEDURE BtnSairClick()
708:         LOCAL loc_lPodeEditar, loc_lSucesso
709: 
710:         loc_lPodeEditar = THIS.cmd_4c_CmdInserir.Visible OR THIS.cmd_4c_CmdExcluir.Visible
711:         loc_lSucesso    = .T.
712: 
713:         IF loc_lPodeEditar AND VARTYPE(THIS.this_oBusinessObject) = "O"
714:             loc_lSucesso = THIS.this_oBusinessObject.SalvarGrade()
715:         ENDIF
716: 
717:         IF loc_lSucesso
718:             IF VARTYPE(THIS.this_oParentForm) = "O"
719:                 THIS.this_oParentForm.Enabled = .T.
720:             ENDIF
721:             THIS.AjustarBotoesFormPai(.T.)
722:             THIS.Release()
723:         ENDIF
724:     ENDPROC
725: 
726:     *--------------------------------------------------------------------------
727:     * CarregarGrade - Popula o cursor de trabalho do Business Object com os
728:     * Cfops ja permitidos para a Operacao corrente (legado Init: "Select *
729:     * From SigCdOop where Dopes=...") e vincula o grid a ele. RecordSource/
730:     * ControlSource ficam aqui (nao em ConfigurarGrade) porque o Business
731:     * Object RECRIA o cursor a cada chamada - vincular antes seria
732:     * descartado (mesmo padrao de FormFpN.CarregarDados). Reaplica
733:     * Header1.Caption depois do ControlSource, porque RecordSource reseta
734:     * os cabecalhos das colunas.
735:     *--------------------------------------------------------------------------
736:     PROCEDURE CarregarGrade()
737:         LOCAL loc_oGrid, loc_cCursor
738: 
739:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
740:             RETURN .F.
741:         ENDIF
742: 
743:         IF !THIS.this_oBusinessObject.CarregarCfopsPermitidos()
744:             RETURN .F.
745:         ENDIF
746: 
747:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
748:         loc_oGrid   = THIS.grd_4c_Dados
749: 
750:         loc_oGrid.ColumnCount  = 4
751:         loc_oGrid.RecordSource = loc_cCursor
752: 
753:         loc_oGrid.Column1.ControlSource = loc_cCursor + ".cfops"
754:         loc_oGrid.Column2.ControlSource = loc_cCursor + ".obspads"
755:         loc_oGrid.Column3.ControlSource = loc_cCursor + ".obsinis"
756:         loc_oGrid.Column4.ControlSource = loc_cCursor + ".obsfins"
757: 
758:         loc_oGrid.Column1.Header1.Caption = "CFOP"
759:         loc_oGrid.Column2.Header1.Caption = "Obs"
760:         loc_oGrid.Column3.Header1.Caption = "De"
761:         loc_oGrid.Column4.Header1.Caption = "At" + CHR(233)
762: 
763:         IF USED(loc_cCursor)
764:             SELECT (loc_cCursor)
765:             GO TOP
766:         ENDIF
767: 
768:         loc_oGrid.Refresh()
769: 
770:         RETURN .T.
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * ValidarCfopGridExec - Corpo do Valid da celula CFOP da grade (legado
775:     * SIGOPCFP.GradeSubN.Column1.Text1.Valid: "If Lastkey() == 27 / Return"
776:     * antes de qualquer coisa - ESC na celula aborta o Valid sem tentar o
777:     * lookup, preservando o valor atual). PUBLIC: chamado de FORA da classe
778:     * do form pela celula TextBoxCfopGridCfp_4c (THISFORM.<metodo>, mesma
779:     * exigencia de BINDEVENT da regra #3).
780:     *--------------------------------------------------------------------------
781:     PROCEDURE ValidarCfopGridExec(par_oTxt)
782:         IF LASTKEY() = 27
783:             RETURN .T.
784:         ENDIF
785: 
786:         RETURN THIS.AbrirLookupCfopGrade(par_oTxt)
787:     ENDPROC
788: 
789:     *--------------------------------------------------------------------------
790:     * AbrirLookupCfopGrade - Lookup de CFOP (legado: "xBrox = CreateObject(
791:     * 'fwBuscaExt',...,'SigCdCfo','crSigCdCfo','Codigos',This.Value,
792:     * 'Selecao',.t.,'Codigos')" + mAddColuna Codigos/Descricaos/Operacaos).
793:     * FormBuscaAuxiliar.Init ja tenta o match exato sozinho (regra #37) -
794:     * so abre o Show() quando nao resolveu. Atribuicao do valor escolhido
795:     * SOMENTE sob a guarda this_lSelecionou (regra #37); fora dela, o
796:     * legado faz "Else This.Value = ''" (ESC no picker limpa o codigo) -
797:     * reproduzido aqui, nao eh o defeito da regra #50 (ali nao havia
798:     * picker nenhum para servir de feedback).
799:     *
800:     * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
801:     * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
802:     * sistema novo). PUBLIC pelo mesmo motivo de ValidarCfopGridExec.
803:     *--------------------------------------------------------------------------
804:     PROCEDURE AbrirLookupCfopGrade(par_oTxt)
805:         LOCAL loc_oBusca, loc_cValor
806: 
807:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
808: 
809:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCfo", ;
810:             "cursor_4c_BuscaCfop", "codigos", loc_cValor, ;
811:             "Sele" + CHR(231) + CHR(227) + "o", .F.)
812: 
813:         IF VARTYPE(loc_oBusca) = "O"
814:             IF !loc_oBusca.this_lAchouRegistro
815:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
816:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
817:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
818:                 loc_oBusca.Show()
819:             ENDIF
820: 
821:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfop")
822:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaCfop.codigos)
823:             ELSE
824:                 par_oTxt.Value = ""
825:             ENDIF
826: 
827:             loc_oBusca.Release()
828:         ENDIF
829: 
830:         IF USED("cursor_4c_BuscaCfop")
831:             USE IN cursor_4c_BuscaCfop
832:         ENDIF
833: 
834:         par_oTxt.Refresh()
835: 
836:         RETURN .T.
837:     ENDPROC
838: 
839:     *--------------------------------------------------------------------------
840:     * ValidarObsGridExec - Corpo do Valid das celulas de Observacao da grade
841:     * (legado SIGOPCFP.GradeSubN.Column2/3/4.Text1.Valid - as 3 colunas
842:     * repetem o mesmo padrao): abre o lookup quando a celula nao esta vazia
843:     * e, em seguida, valida CRUZADO contra as outras duas colunas da MESMA
844:     * linha (Padrao/Inicial/Final) - "Return 0" do legado mantem o foco na
845:     * celula quando a cruzada falha. par_cCampoObs ("OBSPADS"/"OBSINIS"/
846:     * "OBSFINS") vem de TextBoxObsGridCfp_4c.this_cCampoObs e diz qual das
847:     * tres regras aplicar. PUBLIC: chamado de FORA da classe do form pela
848:     * celula (mesma exigencia de BINDEVENT da regra #3).
849:     *
850:     * O valor em validacao ainda esta em par_oTxt.Value (o cursor so recebe
851:     * DEPOIS - regra #46); os outros dois lados da comparacao vem do cursor
852:     * da grade, que ja reflete o que foi digitado nas celulas anteriores da
853:     * mesma linha.
854:     *--------------------------------------------------------------------------
855:     PROCEDURE ValidarObsGridExec(par_oTxt, par_cCampoObs)
856:         LOCAL loc_lResultado, loc_cCursor, loc_nObsPad, loc_nObsIni, loc_nObsFin
857: 
858:         IF LASTKEY() = 27
859:             RETURN .T.
860:         ENDIF
861: 
862:         loc_lResultado = .T.
863: 
864:         IF !EMPTY(par_oTxt.Value)
865:             THIS.AbrirLookupObsGrade(par_oTxt)
866:         ENDIF
867: 
868:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
869: 
870:         IF USED(loc_cCursor)
871:             loc_nObsPad = EVALUATE(loc_cCursor + ".obspads")
872:             loc_nObsIni = EVALUATE(loc_cCursor + ".obsinis")
873:             loc_nObsFin = EVALUATE(loc_cCursor + ".obsfins")
874: 
875:             DO CASE
876:             CASE par_cCampoObs = "OBSPADS"
877:                 loc_nObsPad = par_oTxt.Value
878:                 IF !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsIni) AND (loc_nObsIni > loc_nObsPad)
879:                     MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
880:                         "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
881:                     loc_lResultado = .F.
882:                 ENDIF
883:                 IF loc_lResultado AND !EMPTY(loc_nObsPad) AND !EMPTY(loc_nObsFin) AND (loc_nObsFin < loc_nObsPad)
884:                     MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
885:                         "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
886:                     loc_lResultado = .F.
887:                 ENDIF
888:             CASE par_cCampoObs = "OBSINIS"
889:                 loc_nObsIni = par_oTxt.Value
890:                 IF !EMPTY(loc_nObsIni) AND !EMPTY(loc_nObsPad) AND (loc_nObsIni > loc_nObsPad)
891:                     MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Inicial N" + CHR(227) + ;
892:                         "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
893:                     loc_lResultado = .F.
894:                 ENDIF
895:             CASE par_cCampoObs = "OBSFINS"
896:                 loc_nObsFin = par_oTxt.Value
897:                 IF !EMPTY(loc_nObsFin) AND !EMPTY(loc_nObsPad) AND (loc_nObsFin < loc_nObsPad)
898:                     MsgAviso("A Observa" + CHR(231) + CHR(227) + "o Final N" + CHR(227) + ;
899:                         "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
900:                     loc_lResultado = .F.
901:                 ENDIF
902:             ENDCASE
903:         ENDIF
904: 
905:         RETURN loc_lResultado
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * AbrirLookupObsGrade - Lookup de Observacao (legado: "xBrox =
910:     * CreateObject('fwBuscaExt',...,'SigCdObs','crSigCdObs','Codigos',
911:     * This.Value,'Cadastro de Observacoes',.t.,'Codigos')" + mAddColuna
912:     * Codigos/Observas). FormBuscaAuxiliar.Init ja tenta o match exato
913:     * sozinho (regra #37) - equivalente ao ChkRegister do legado, que so
914:     * abre o picker quando o codigo digitado NAO existe. Coluna numeric(3,0)
915:     * (SigCdObs.codigos/SigCdOop.obspads-obsinis-obsfins): o valor digitado
916:     * eh convertido para string so para a busca (par_cValor de
917:     * FormBuscaAuxiliar eh sempre Character); de volta, o Codigos escolhido
918:     * retorna NUMERICO para a celula. ESC no picker zera a celula (legado:
919:     * "This.Value = Iif(Lastkey()==27, 0, crSigCdObs.Codigos)") - NAO bloqueia
920:     * a saida da celula (a cruzada de ValidarObsGridExec trata Empty(0) como
921:     * "sem restricao", igual ao legado).
922:     *
923:     * Chamado pelo Valid da celula (par_oTxt.Value ainda NAO chegou ao
924:     * cursor da grade - regra #46) e pelo F4/F5 da celula (afordancia do
925:     * sistema novo). PUBLIC pelo mesmo motivo de ValidarObsGridExec.
926:     *--------------------------------------------------------------------------
927:     PROCEDURE AbrirLookupObsGrade(par_oTxt)
928:         LOCAL loc_oBusca, loc_cValor
929: 
930:         loc_cValor = ALLTRIM(TRANSFORM(NVL(par_oTxt.Value, 0)))
931: 
932:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdObs", ;
933:             "cursor_4c_BuscaObs", "codigos", loc_cValor, ;
934:             "Cadastro de Observa" + CHR(231) + CHR(245) + "es", .F.)
935: 
936:         IF VARTYPE(loc_oBusca) = "O"
937:             IF !loc_oBusca.this_lAchouRegistro
938:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
939:                 loc_oBusca.mAddColuna("observas", "", "Observa" + CHR(231) + CHR(227) + "o")
940:                 loc_oBusca.Show()
941:             ENDIF
942: 
943:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaObs")
944:                 par_oTxt.Value = NVL(cursor_4c_BuscaObs.codigos, 0)
945:             ELSE
946:                 par_oTxt.Value = 0
947:             ENDIF
948: 
949:             loc_oBusca.Release()
950:         ENDIF
951: 
952:         IF USED("cursor_4c_BuscaObs")
953:             USE IN cursor_4c_BuscaObs
954:         ENDIF
955: 
956:         par_oTxt.Refresh()
957: 
958:         RETURN .T.
959:     ENDPROC
960: 
961:     *--------------------------------------------------------------------------
962:     * CelulaObsGradeEditavel - Legado (GradeSubN.Column2/3/4.Text1.When):
963:     * "Return (not Empty(TmpCfoOp.Cfops))" - as celulas de Observacao
964:     * (Padrao/Inicial/Final) so ficam editaveis depois do CFOP da MESMA
965:     * linha estar preenchido. Chamado pelo When de TextBoxObsGridCfp_4c
966:     * (classes\TextBoxGridLookup.prg) - PUBLIC pelo mesmo motivo das
967:     * demais delegacoes de celula de grade (regra #3/#46).
968:     *--------------------------------------------------------------------------
969:     PROCEDURE CelulaObsGradeEditavel()
970:         LOCAL loc_cCursor
971: 
972:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
973:             RETURN .T.
974:         ENDIF
975: 
976:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
977: 
978:         IF !USED(loc_cCursor)
979:             RETURN .T.
980:         ENDIF
981: 
982:         RETURN !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".cfops"), "")))
983:     ENDPROC
984: 
985:     *--------------------------------------------------------------------------
986:     * Destroy - Consolidacao final (fase 8/8): rede de seguranca para o pai e
987:     * limpeza dos cursores de trabalho deste dialogo.
988:     *
989:     * BtnSairClick (fase 7/8) ja reabilita THIS.this_oParentForm e chama
990:     * AjustarBotoesFormPai(.T.) no caminho de SUCESSO antes de THIS.Release().
991:     * Mas o legado garantia a reabilitacao do pai so por viver na MESMA
992:     * DataSession/Release Windows unico - aqui, se o dialogo for destruido por
993:     * qualquer caminho que nao passe por ali (erro nao tratado em algum ponto
994:     * fora de TRY, RELEASE externo), o pai NAO pode ficar desabilitado para
995:     * sempre. Repetir aqui eh idempotente (reabilitar duas vezes nao tem
996:     * efeito colateral).
997:     *
998:     * Fecha tambem cursor_4c_Dados (grade de trabalho, this_cCursorGrade do
999:     * BO) e cursor_4c_OopOriginais (snapshot usado por SalvarGrade) - os
1000:     * demais cursores temporarios (cursor_4c_BuscaCfop/Obs,
1001:     * cursor_4c_OopTemp/Duplic/Removidas) ja se fecham inline nos proprios
1002:     * metodos. O nome do cursor de grade e lido ANTES do DODEFAULT() (abaixo)
1003:     * porque FormBase.Destroy() anula THIS.this_oBusinessObject.
1004:     *
1005:     * DODEFAULT() por ULTIMO (CorretorAutomatico Pattern #145) - sem isso
1006:     * FormBase.Destroy() nao roda e o menu principal fica com popups
1007:     * encolhidos apos este dialogo fechar.
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE Destroy()
1010:         LOCAL loc_cCursorGrade
1011: 
1012:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1013:             loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
1014:         ELSE
1015:             loc_cCursorGrade = "cursor_4c_Dados"
1016:         ENDIF
1017: 
1018:         IF VARTYPE(THIS.this_oParentForm) = "O"
1019:             THIS.this_oParentForm.Enabled = .T.
1020:         ENDIF
1021:         THIS.AjustarBotoesFormPai(.T.)
1022: 
1023:         IF !EMPTY(loc_cCursorGrade) AND USED(loc_cCursorGrade)
1024:             USE IN (loc_cCursorGrade)
1025:         ENDIF
1026: 
1027:         IF USED("cursor_4c_OopOriginais")
1028:             USE IN cursor_4c_OopOriginais
1029:         ENDIF
1030: 
1031:         DODEFAULT()
1032:     ENDPROC
1033: 
1034:     *--------------------------------------------------------------------------
1035:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1036:     * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
1037:     * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
1038:     * metodo fica generico para reaproveitar nas fases seguintes).
1039:     *--------------------------------------------------------------------------
1040:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1041:         LOCAL loc_nI, loc_oControl, loc_nP
1042: 
1043:         IF VARTYPE(par_oContainer) != "O"
1044:             RETURN
1045:         ENDIF
1046: 
1047:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1048:             loc_oControl = par_oContainer.Controls(loc_nI)
1049: 
1050:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1051:                 loc_oControl.Visible = .T.
1052:             ENDIF
1053: 
1054:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1055:                 FOR loc_nP = 1 TO loc_oControl.PageCount
1056:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1057:                 ENDFOR
1058:             ENDIF
1059: 
1060:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1061:                 THIS.TornarControlesVisiveis(loc_oControl)
1062:             ENDIF
1063:         ENDFOR
1064:     ENDPROC
1065: 
1066: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCfpBO.prg):
*==============================================================================
* SigOpCfpBO.prg - Business Object para Cfop's Permitidas por Operacao
*
* Form OPERACIONAL (popup filho do Cadastro de Operacoes - SigCdOpe): mantem
* a lista de CFOPs permitidos para uma Operacao (Dopes), com os limites de
* Observacao (Padrao/Inicial/Final) de cada CFOP.
*
* Tabela: SigCdOop (cada registro = um CFOP permitido para uma Operacao)
*   cfops      char(10) NOT NULL - codigo do CFOP permitido
*   cidchaves  char(20) NOT NULL - chave primaria (PK Fortyus, gerada com fUniqueIds())
*   dopes      char(20) NOT NULL - codigo da Operacao (FK SigCdOpe.Dopes)
*   cgrus      char(3)  NOT NULL - grupo (nao exibido na grade, preservado do SELECT *)
*   obspads    numeric(3,0) NOT NULL - observacao padrao
*   obsinis    numeric(3,0) NOT NULL - observacao inicial
*   obsfins    numeric(3,0) NOT NULL - observacao final
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCfpBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade (mapeamento para a tabela SigCdOop)
    * Cada instancia representa UMA linha da grade de CFOPs permitidos.
    *==========================================================================
    this_cCidChaves  = ""   && cidchaves char(20) - PK Fortyus
    this_cDopes      = ""   && dopes char(20) - codigo da Operacao (FK SigCdOpe.Dopes)
    this_cCfop       = ""   && cfops char(10) - codigo do CFOP permitido
    this_cCgrupo     = ""   && cgrus char(3) - grupo (NOT NULL, nao exibido na grade)
    this_nObsPadrao  = 0    && obspads numeric(3,0) - observacao padrao da operacao
    this_nObsInicial = 0    && obsinis numeric(3,0) - observacao inicial permitida
    this_nObsFinal   = 0    && obsfins numeric(3,0) - observacao final permitida

    *-- Cursor de trabalho do grid (legado "TmpCfoOp") - editavel, recriado
    *-- a cada CarregarCfopsPermitidos(). Nome exposto para o Form vincular
    *-- RecordSource/ControlSource DEPOIS de (re)carregar (igual a FpNBO).
    this_cCursorGrade = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdOop"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/
    * CancelarEdicao). this_cDopes TAMBEM eh limpo - eh FK para a Operacao
    * (SigCdOpe.Dopes) que o Form (fase do layout) deve repor logo apos
    * THIS.NovoRegistro(), igual ao padrao de SigOpCflBO.this_cNums.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves  = ""
        THIS.this_cDopes      = ""
        THIS.this_cCfop       = ""
        THIS.this_cCgrupo     = ""
        THIS.this_nObsPadrao  = 0
        THIS.this_nObsInicial = 0
        THIS.this_nObsFinal   = 0
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Espelha o ramo do cmdInserir.Click legado:
    *     Insert Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
    * A chave ja nasce com a linha em branco, antes do usuario preencher o
    * CFOP - exatamente como o legado gera a PK na hora de inserir a linha na
    * grade, nao na hora de salvar.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * de SigCdOop (cursor_4c_Dados ou o cursor temporario da grade).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * campo nao eh sintaxe valida em VFP9.
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, ao
    * posicionar na linha da grade (ex.: BtnExcluirClick/AfterRowColChange).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes,     "")
                THIS.this_cCfop       = TratarNulo(cfops,     "")
                THIS.this_cCgrupo     = TratarNulo(cgrus,     "")
                THIS.this_nObsPadrao  = TratarNulo(obspads,   0)
                THIS.this_nObsInicial = TratarNulo(obsinis,   0)
                THIS.this_nObsFinal   = TratarNulo(obsfins,   0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursorGrade - (Re)cria o cursor de trabalho do grid, vazio,
    * com a mesma estrutura de SigCdOop usada na grade (legado "TmpCfoOp" -
    * "Select * From xCfoOp Into Cursor TmpCfoOp ReadWrite"). Chamado por
    * CarregarCfopsPermitidos() antes de popular - o Form so vincula
    * RecordSource/ControlSource DEPOIS dessa chamada (regra: Column.
    * ControlSource exige que o cursor ja exista).
    *==========================================================================
    PROCEDURE InicializarCursorGrade()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorGrade) ;
                (cidchaves C(20) NULL, dopes C(20) NULL, cfops C(10) NULL, ;
                 cgrus C(3) NULL, obspads N(3,0) NULL, obsinis N(3,0) NULL, obsfins N(3,0) NULL)
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.InicializarCursorGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCfopsPermitidos - Carrega para THIS.this_cCursorGrade todos os
    * Cfops ja permitidos da Operacao corrente (THIS.this_cDopes), espelhando
    * a consulta do Init legado ("Select * From SigCdOop where Dopes=...").
    * SQLEXEC vai para um cursor TEMPORARIO - nunca direto no cursor do grid
    * (SQLEXEC sobre o alias ligado ao Grid zera o ColumnCount). PUBLIC: o
    * Form chama de fora, apos instanciar o BO (regra #51).
    *==========================================================================
    PROCEDURE CarregarCfopsPermitidos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = THIS.InicializarCursorGrade()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF

            loc_cSQL = "SELECT cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins" + ;
                " FROM SigCdOop WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OopTemp")

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorGrade)
                IF RECCOUNT("cursor_4c_OopTemp") > 0
                    APPEND FROM DBF("cursor_4c_OopTemp")
                ENDIF
                GO TOP

                *-- Snapshot das chaves JA existentes em SigCdOop ao abrir o
                *-- dialogo - usado por SalvarGrade() (fase 7/8) para decidir
                *-- Inserir() x Atualizar() x excluir por diferenca, sem
                *-- precisar do Delete+Append em massa do legado.
                IF USED("cursor_4c_OopOriginais")
                    USE IN cursor_4c_OopOriginais
                ENDIF
                SELECT cidchaves FROM (THIS.this_cCursorGrade) ;
                    INTO CURSOR cursor_4c_OopOriginais

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
            MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarCfopsPermitidos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Transcricao das validacoes do legado espalhadas pelos
    * Valid das colunas da grade (Column2/Column3/Column4): a Observacao
    * Inicial nao pode ser maior que a Padrao, e a Observacao Final nao pode
    * ser menor que a Padrao. Empty(0) = .T. em VFP9, entao a checagem so
    * entra em vigor quando os dois lados estao preenchidos - igual ao legado.
    * Chamado por BusinessBase.Salvar(), que exibe a falha via ExibirFalha()
    * quando este metodo devolve .F. (regra #20) - sem MsgAviso proprio aqui.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cCfop))
            THIS.this_cMensagemErro = "Cfop n" + CHR(227) + "o informado."
        CASE EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
        CASE !EMPTY(THIS.this_nObsInicial) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsInicial > THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Inicial N" + ;
                CHR(227) + "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!"
        CASE !EMPTY(THIS.this_nObsFinal) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsFinal < THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Final N" + ;
                CHR(227) + "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!"
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - Inclui um CFOP permitido para a Operacao em SigCdOop.
    * Espelha o INSERT em massa do cmdSair.Click legado (Select * From
    * TmpCfoOp / Append From Dbf), aplicado linha a linha pela arquitetura
    * nova. cgrus eh NOT NULL e nao aparece na grade - vem preservado da
    * propriedade (this_cCgrupo), carregada do SELECT * do cursor de origem.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdOop (cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCfpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza um CFOP permitido existente em SigCdOop.
    * dopes e cidchaves sao a chave do registro e NAO sao regraveis; cfops e
    * as tres observacoes (padrao/inicial/final) espelham o que o usuario
    * edita nas colunas da grade. cgrus eh regravado com o mesmo valor
    * carregado (nunca editado na tela), preservando o grupo original.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdOop
                   SET cfops   = <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                       cgrus   = <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                       obspads = <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                       obsinis = <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                       obsfins = <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                 WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCfpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExisteChaveOriginal - .T. se par_cCidChaves ja existia em SigCdOop ao
    * abrir o dialogo (snapshot cursor_4c_OopOriginais, tirado em
    * CarregarCfopsPermitidos). Usado por SalvarGrade() para decidir entre
    * Inserir() e Atualizar() - sem indice em cursor_4c_OopOriginais, por
    * isso LOCATE (poucas linhas, nao precisa de SEEK).
    *==========================================================================
    PROTECTED FUNCTION ExisteChaveOriginal(par_cCidChaves)
        LOCAL loc_lAchou, loc_cAliasAtual

        loc_lAchou = .F.

        IF USED("cursor_4c_OopOriginais")
            loc_cAliasAtual = ALIAS()
            SELECT cursor_4c_OopOriginais
            LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(NVL(par_cCidChaves, ""))
            loc_lAchou = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * SalvarGrade - Persiste as alteracoes da grade de Cfops permitidos
    * (this_cCursorGrade): INSERT para linha nova, UPDATE para linha
    * existente, DELETE para linha removida pelo usuario - resultado final
    * equivalente ao cmdSair.Click legado (Delete From SigCdOop Where
    * Dopes=... seguido de reinsercao INTEGRAL de TmpCfoOp), aqui aplicado
    * linha a linha pelos metodos Inserir/Atualizar/ExecutarExclusao ja
    * existentes (PILAR 3 - arquitetura obrigatoriamente diferente do
    * legado, mesmo resultado final no banco).
    *
    * Validacoes na MESMA ordem do legado:
    *   1. Descarta as linhas em branco do cursor (legado: "Delete For
    *      Cfops = Space(10)") - cmdInserir.Click (fase 7/8) cria a linha
    *      vazia; se o usuario sair sem preencher o Cfop, ela e descartada
    *      em silencio, igual ao legado.
    *   2. Cfop duplicado entre as linhas remanescentes (legado: "Select
    *      Cfops, sum(1) From TmpCfoOp Group by 1 having sum(1) > 1") ->
    *      aborta com o MESMO aviso do legado e devolve .F. SEM alterar o
    *      banco - BtnSairClick (fase 7/8) mantem o dialogo aberto para o
    *      usuario corrigir (legado: "Return .f." no meio do Click).
    *
    * As linhas que existiam ao abrir o dialogo e que nao sobraram no
    * cursor apos a etapa 1 (porque o usuario excluiu, ou porque a linha
    * em branco por acaso reaproveitou uma chave existente - nunca ocorre,
    * cidchaves de linha nova sempre vem de fUniqueIds()) sao EXCLUIDAS do
    * banco.
    *
    * PUBLIC: chamado pelo form em BtnSairClick (regra #51 - Inserir/
    * Atualizar/ExecutarExclusao continuam PROTECTED, acessados so por
    * este metodo, da PROPRIA classe).
    *==========================================================================
    PROCEDURE SalvarGrade()
        LOCAL loc_lSucesso, loc_cCursor, loc_nDuplic

        loc_lSucesso = .T.
        loc_cCursor  = THIS.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        TRY
            *-- 1) descarta linhas em branco (legado: Delete For Cfops = Space(10))
            SELECT (loc_cCursor)
            DELETE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

            *-- 2) duplicidade de Cfop entre as linhas remanescentes
            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF
            SELECT cfops FROM (loc_cCursor) WHERE !DELETED() ;
                GROUP BY cfops HAVING COUNT(*) > 1 INTO CURSOR cursor_4c_OopDuplic

            loc_nDuplic = RECCOUNT("cursor_4c_OopDuplic")

            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF

            IF loc_nDuplic > 0
                MsgAviso("Existem Cfops em Duplicidade. Favor Acertar!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- 3) INSERT/UPDATE das linhas remanescentes
            IF loc_lSucesso
                SELECT (loc_cCursor)
                SCAN FOR !DELETED()
                    THIS.CarregarDoCursor(loc_cCursor)

                    IF THIS.ExisteChaveOriginal(THIS.this_cCidChaves)
                        loc_lSucesso = THIS.Atualizar()
                    ELSE
                        loc_lSucesso = THIS.Inserir()
                    ENDIF

                    IF !loc_lSucesso
                        EXIT
                    ENDIF

                    SELECT (loc_cCursor)
                ENDSCAN
            ENDIF

            *-- 4) exclui as linhas que existiam antes e nao sobraram no cursor
            IF loc_lSucesso AND USED("cursor_4c_OopOriginais")
                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF

                SELECT cidchaves FROM cursor_4c_OopOriginais ;
                    WHERE cidchaves NOT IN ;
                        (SELECT cidchaves FROM (loc_cCursor) WHERE !DELETED()) ;
                    INTO CURSOR cursor_4c_OopRemovidas

                SELECT cursor_4c_OopRemovidas
                SCAN
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_lSucesso = THIS.ExecutarExclusao()
                    IF !loc_lSucesso
                        EXIT
                    ENDIF
                    SELECT cursor_4c_OopRemovidas
                ENDSCAN

                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.SalvarGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui o CFOP permitido de SigCdOop.
    * Espelha o cmdExcluir.Click legado (Delete na linha corrente da grade) -
    * aqui aplicado direto na tabela, chave por cidchaves.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdOop WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCfpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

