# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrTar.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (568 linhas total):

*-- Linhas 31 a 183:
31:     Themes      = .F.
32: 
33:     *-- Referencia ao form pai (parentform do legado - setado pelo chamador
34:     *-- apos CREATEOBJECT, antes do Show; usado no funil de encerramento)
35:     this_oFormPai    = .NULL.
36: 
37:     *-- Flags do legado (HouveIncl/HouveExcl) - preservadas para o form pai
38:     *-- consultar se esta tela provocou inclusao/exclusao em csTmpPrTar
39:     this_lHouveIncl  = .F.
40:     this_lHouveExcl  = .F.
41: 
42:     *-- pcEscolha do legado (modo herdado do form pai: INSERIR/ALTERAR/CONSULTAR)
43:     this_cPcEscolha  = ""
44: 
45:     *-- Chave da tarefa (pkchaves) cuja observacao de inspecao sera exibida.
46:     *-- Equivalente funcional ao registro corrente de csTmpPrTar que o form
47:     *-- chamador legado ja deixava posicionado antes de "DO FORM SigPrTar".
48:     this_cPkChave    = ""
49: 
50:     *--------------------------------------------------------------------------
51:     * Init - Recebe o form pai (equivalente ao "poForm" do legado) e a chave
52:     * da tarefa cuja observacao sera exibida; so entao DODEFAULT (FormBase
53:     * chama InicializarForm).
54:     *--------------------------------------------------------------------------
55:     PROCEDURE Init(par_oFormPai, par_cPkChave)
56:         THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
57:         THIS.this_cPkChave = IIF(VARTYPE(par_cPkChave) = "C", ALLTRIM(par_cPkChave), "")
58: 
59:         RETURN DODEFAULT()
60:     ENDPROC
61: 
62:     *-- Load legado ("=fConfigGeral()") NAO PORTADO - mesma decisao registrada
63:     *-- em FormSigMvMen.prg/FormSigMvExp.prg. fConfigGeral era funcao GLOBAL
64:     *-- de inicializacao da aplicacao legado; na arquitetura
65:     *-- nova esse papel eh de start\config.prg, que roda uma vez no startup.
66:     *-- O wrapper utils\fconfiggeral.prg existe so para o p-code dos VCX
67:     *-- legado que ainda o chamam (regra #27 CLAUDE.md) - codigo nosso nao o
68:     *-- chama de novo por form.
69: 
70:     *--------------------------------------------------------------------------
71:     * InicializarForm - Cria o Business Object e monta a estrutura completa
72:     * do dialogo (cabecalho + observacao de inspecao + botao Encerrar). Sem
73:     * PageFrame/Grid - legado SIGSERPR eh FLAT (raiz Class: form generico,
74:     * sem BaseClass: pageframe) e e' um dialogo de EXIBICAO: o unico campo
75:     * (getObsInsp) e' ReadOnly = .T. no SCX - nao ha lista nem CRUD para
76:     * acrescentar nesta fase (ver Test-LegadoDialogoExibicao em
77:     * automation\OrquestradorMigracao.ps1, ramo EXIBICAO da Fase 4 - mesma
78:     * familia de FormSigMvMen/SIGPDMEN).
79:     *--------------------------------------------------------------------------
80:     PROTECTED PROCEDURE InicializarForm()
81:         LOCAL loc_lSucesso, loc_oErro
82:         loc_lSucesso = .F.
83: 
84:         TRY
85:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrTarBO")
86: 
87:             *-- Fundo do form (legado SIGSERPR declara
88:             *-- Picture = ..\framework\imagens\new_background.jpg).
89:             *-- O arquivo esta em vbmp\, entao o caminho canonico eh
90:             *-- gc_4c_CaminhoIcones (convencao de 93 dos 137 forms
91:             *-- OPERACIONAL que reproduzem esse fundo).
92:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
93: 
94:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
95:                 THIS.ConfigurarCabecalho()
96:                 THIS.ConfigurarObservacao()
97:                 THIS.ConfigurarBotaoSair()
98:                 THIS.ConfigurarPaginaDados()
99: 
100:                 *-- ValidarUIFidelity.prg forca gnConnHandle = -1 (sem conexao);
101:                 *-- sem esta guarda, CarregarObservacao tentaria SQLEXEC e o
102:                 *-- MsgErro travaria o pipeline em dialogo modal (padrao do
103:                 *-- projeto - FORMCOR_LICOES_APRENDIDAS.md, Problema 4).
104:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
105:                     THIS.CarregarObservacao()
106:                 ENDIF
107: 
108:                 THIS.TornarControlesVisiveis()
109:                 loc_lSucesso = .T.
110:             ELSE
111:                 MsgErro("Erro ao criar Business Object de Tarefas do Processo." + CHR(13) + ;
112:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
113:             ENDIF
114:         CATCH TO loc_oErro
115:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
116:                     " PROC=" + loc_oErro.Procedure, ;
117:                     "Erro ao inicializar Observa" + CHR(231) + CHR(227) + "o de Inspe" + CHR(231) + CHR(227) + "o")
118:         ENDTRY
119: 
120:         RETURN loc_lSucesso
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
125:     * Equivalente: SIGSERPR.cntSombra + lblSombra + lblTitulo + Shape1
126:     * cnt_4c_Sombra: Top=0, Left=0, Height=80, BackColor=RGB(100,100,100)
127:     *
128:     * Width do cabecalho NAO transcreve o literal do SCX: o dump declara
129:     * cntSombra.Width = 800 e lblSombra/lblTitulo.Width = 769 num form de
130:     * Width = 588 - o container do cabecalho foi desenhado no Form Designer
131:     * 212px ALEM da borda direita da janela (artefato conhecido). Copiar 800/769
132:     * faria o titulo (Tahoma 18 bold) extrapolar a area visivel e ser
133:     * RECORTADO pelo form, sem erro e sem log (regra #30). Canonico do projeto
134:     * (regra #11/#30): container = THIS.Width e labels filhos = THIS.Width - 20,
135:     * para nao extrapolar o pai. DIFERENCA de Width que o ValidarUIFidelity
136:     * acusar nesses tres controles eh FALSO POSITIVO - ver Formsigprrcu
137:     * (task669) e FormSIGPRSTF, mesma decisao.
138:     * lbl_4c_LblSombra: sombra preta (ForeColor preto)
139:     * lbl_4c_LblTitulo: titulo branco (ForeColor branco) sobre a sombra
140:     * shp_4c_Shape1: decorativo (BackStyle=0, BorderStyle=0 - nao desenha nada,
141:     * preservado por fidelidade ao dump do SCX)
142:     *--------------------------------------------------------------------------
143:     PROTECTED PROCEDURE ConfigurarCabecalho()
144:         THIS.AddObject("cnt_4c_Sombra", "Container")
145:         WITH THIS.cnt_4c_Sombra
146:             .Top         = 0
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BorderWidth = 0
151:             .BackStyle   = 1
152:             .BackColor   = RGB(100, 100, 100)
153:             .Visible     = .T.
154:         ENDWITH
155: 
156:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
157:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
158:             .AutoSize      = .F.
159:             .FontBold      = .T.
160:             .FontName      = "Tahoma"
161:             .FontSize      = 18
162:             .FontUnderline = .F.
163:             .WordWrap      = .T.
164:             .Alignment     = 0
165:             .BackStyle     = 0
166:             .Caption       = THIS.Caption
167:             .Height        = 40
168:             .Left          = 10
169:             .Top           = 18
170:             .Width         = THIS.Width - 20
171:             .ForeColor     = RGB(0, 0, 0)
172:             .Visible       = .T.
173:         ENDWITH
174: 
175:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
176:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
177:             .AutoSize    = .F.
178:             .FontBold    = .T.
179:             .FontName    = "Tahoma"
180:             .FontSize    = 18
181:             .WordWrap    = .T.
182:             .Alignment   = 0
183:             .BackStyle   = 0

*-- Linhas 211 a 430:
211:     * Direto no form (sem container de saida) - nao eh form CRUD frmcadastro,
212:     * entao o padrao canonico cnt_4c_Saida (CLAUDE.md #10) nao se aplica aqui.
213:     *--------------------------------------------------------------------------
214:     PROTECTED PROCEDURE ConfigurarBotaoSair()
215:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
216:         WITH THIS.cmd_4c_CmdSair
217:             .Top             = 4
218:             .Left            = 510
219:             .Width           = 75
220:             .Height          = 75
221:             .Cancel          = .T.
222:             .Caption         = "Encerrar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
224:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
225:             .Themes          = .T.
226:             .FontName        = "Comic Sans MS"
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .FontSize        = 8
230:             .ForeColor       = RGB(90, 90, 90)
231:             .BackColor       = RGB(255, 255, 255)
232:             .SpecialEffect   = 0
233:             .WordWrap        = .T.
234:             .Visible         = .T.
235:         ENDWITH
236:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
237:     ENDPROC
238: 
239:     *--------------------------------------------------------------------------
240:     * ConfigurarObservacao - Label "Inspiracao" (Say1) + EditBox somente-
241:     * leitura (getObsInsp) que exibe a observacao de inspecao da tarefa.
242:     *
243:     * Legado: Say1 (classe say, right-aligned de proposito - Alignment=1 e
244:     * Width=62 SAO declarados no SCX, nao inventados - regra #23) e
245:     * getObsInsp (classe fwmemo, ReadOnly=.T., Format="K!", ControlSource=
246:     * "csTmpPrTar.ObsInsp" - cursor temporario que o form chamador legado
247:     * ja deixava populado). Aqui o texto vem via SigPrTarBO.this_cObservacao,
248:     * carregado por THIS.CarregarObservacao() a partir de THIS.this_cPkChave.
249:     *--------------------------------------------------------------------------
250:     PROTECTED PROCEDURE ConfigurarObservacao()
251:         THIS.AddObject("lbl_4c_Label1", "Label")
252:         WITH THIS.lbl_4c_Label1
253:             *-- AutoSize = .T. no SCX (classe say). Regra #23 CLAUDE.md:
254:             *-- AutoSize eh NO-OP em Label criado via AddObject - usar .F.
255:             *-- com Width/Height explicitos (os mesmos que o SCX declara).
256:             .AutoSize  = .F.
257:             .FontBold  = .T.
258:             .FontName  = "Tahoma"
259:             .FontSize  = 8
260:             .WordWrap  = .F.
261:             .Alignment = 1
262:             .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
263:             .Height    = 15
264:             .Left      = 12
265:             .Top       = 84
266:             .Width     = 62
267:             .ForeColor = RGB(90, 90, 90)
268:             .Visible   = .T.
269:         ENDWITH
270: 
271:         THIS.AddObject("obj_4c_GetObsInsp", "EditBox")
272:         WITH THIS.obj_4c_GetObsInsp
273:             .FontName          = "Tahoma"
274:             .FontSize          = 8
275:             .Format            = "K!"
276:             .Height            = 212
277:             .Left              = 12
278:             .Top               = 100
279:             .Width             = 564
280:             .ReadOnly          = .T.
281:             .DisabledBackColor = RGB(255, 255, 255)
282:             .DisabledForeColor = RGB(36, 84, 155)
283:             .NullDisplay       = "  "
284:             .Value             = ""
285:             .Visible           = .T.
286:         ENDWITH
287:     ENDPROC
288: 
289:     *--------------------------------------------------------------------------
290:     * FASE 6 (campos restantes + lookups) - REGISTRO DA VARREDURA
291:     *
292:     * Nenhum lookup a implementar: o SIGSERPR.SCX nao tem lookup algum. Varredura
293:     * feita no dump (tasks\task681\SigPrTar_form_codigo_fonte.txt) com os padroes
294:     * que o migration_guide.md exige, incluindo o generico "fwbusca" e a API de
295:     * colunas do picker legado - TODOS com ZERO ocorrencia:
296:     *
297:     *   fwbuscaext | fwBuscaSel | fwBusca | mAddColuna | sigacess(
298:     *   CreateObject( | PROCEDURE Valid | PROCEDURE KeyPress | PROCEDURE DblClick
299:     *
300:     * O dump tem apenas 3 metodos (Form.Init, Form.Load, cmdSair.Click) e ZERO
301:     * controle de entrada: "BaseClass: textbox|combobox|checkbox|spinner|
302:     * optiongroup|grid" nao casa nenhuma vez. O unico controle de dado eh
303:     * getObsInsp, EditBox com ReadOnly = .T. declarado no proprio controle -
304:     * campo somente-leitura NAO recebe lookup por definicao: nao existe onde o
305:     * usuario digite codigo para o picker resolver.
306:     *
307:     * Por isso NAO foram criados nesta fase (criar qualquer um deles seria
308:     * inventar superficie que o legado nao tem - viola o PILAR 1 e a regra
309:     * "NUNCA inventar tabelas de lookup que nao existem no original"):
310:     *   - AbrirLookup*/AbrirBusca* + FormBuscaAuxiliar  -> legado sem lookup
311:     *   - Validar<Campo> + BINDEVENT KeyPress/LostFocus -> nenhum campo digitavel
312:     *   - cnt_4c_BotoesAcao (Salvar/Cancelar)           -> legado so tem cmdSair
313:     *     ("Encerrar", Cancel = .T.), que apenas reabilita o pai e da Release;
314:     *     este eh um dialogo de EXIBICAO, nao um CRUD.
315:     *
316:     * O binding do campo segue o precedente do projeto para dialogo de exibicao
317:     * (FormSigMvMen/SIGPDMEN, task573): o texto chega por .Value em BOParaForm,
318:     * NAO por ControlSource. O legado declara ControlSource = "csTmpPrTar.ObsInsp"
319:     * porque csTmpPrTar eh um cursor que o form CHAMADOR deixava aberto - na
320:     * arquitetura nova nao ha cursor compartilhado entre forms, e o BO fecha o
321:     * cursor logo apos CarregarDoCursor. Fabricar um cursor de exibicao so para
322:     * ter um ControlSource acrescentaria ciclo de vida de cursor sem ganho
323:     * funcional num campo somente-leitura de um unico valor.
324:     *--------------------------------------------------------------------------
325: 
326:     *--------------------------------------------------------------------------
327:     * FASE 7/8 (Form - Eventos Principais) - REGISTRO DA VARREDURA
328:     *
329:     * O template generico desta fase pede BtnIncluirClick()/BtnAlterarClick()/
330:     * BtnVisualizarClick()/BtnExcluirClick() - botoes CRUD de Pagina.Lista do
331:     * frmcadastro. SIGSERPR.SCX NAO herda de frmcadastro (Class: form generico,
332:     * raiz sem PageFrame - ja registrado na FASE 3/6) e o dump
333:     * (tasks\task681\SigPrTar_form_codigo_fonte.txt + layout.json) tem apenas
334:     * 10 objetos e 3 metodos: Form.Init, Form.Load (=fConfigGeral()) e
335:     * cmdSair.Click. ZERO ocorrencia de Incluir/Alterar/Visualizar/Excluir,
336:     * CommandGroup, Grupo_op ou qualquer botao alem do cmdSair ("Encerrar").
337:     *
338:     * Criar os 4 eventos de qualquer forma - mesmo como wrappers inertes -
339:     * inventaria superficie de UI que o legado nao tem (viola o PILAR 1 e a
340:     * regra "paridade funcional 100%": paridade eh com o que o legado FAZ, nao
341:     * com o nome das fases do pipeline). O unico evento principal deste
342:     * dialogo e' o Encerrar, e ja esta implementado desde a FASE 3 em
343:     * CmdSairClick() (linha ~472), ligado via BINDEVENT em
344:     * ConfigurarBotaoSair() - mesmo padrao do FormSigMvMen/FormSigMvExp
345:     * (familia de dialogo OPERACIONAL de EXIBICAO, sem CRUD).
346:     *--------------------------------------------------------------------------
347: 
348:     *--------------------------------------------------------------------------
349:     * FASE 8/8 (Form - Eventos Auxiliares e Consolidacao Final) - REGISTRO
350:     * DA VARREDURA
351:     *
352:     * O template generico desta fase pede BtnBuscarClick()/BtnEncerrarClick()/
353:     * BtnSalvarClick()/BtnCancelarClick(), FormParaBO()/BOParaForm()
354:     * COMPLETOS, HabilitarCampos(), LimparCampos(), CarregarLista() e
355:     * AjustarBotoesPorModo() - convencao de form CRUD (frmcadastro, Page1
356:     * Lista + Page2 Dados, botoes de barra + modo INCLUIR/ALTERAR/
357:     * VISUALIZAR/EXCLUIR). SIGSERPR.SCX nao tem nada disso (ja registrado
358:     * nas Fases 3/4/6/7): raiz Class:form generico, sem PageFrame, sem
359:     * Grid, sem CommandGroup, sem variavel de modo - so 10 objetos e 3
360:     * metodos no dump inteiro (Form.Init, Form.Load, cmdSair.Click). O
361:     * gate desta fase (automation\OrquestradorMigracao.ps1) trata este caso
362:     * pelo ramo $legadoVisualizadorF8: legado sem CRUD, sem botao de gravar
363:     * e com TODO campo somente-leitura - o UNICO campo (getObsInsp) declara
364:     * ReadOnly = .T. no dump. Esse ramo dispensa BtnCancelarClick/
365:     * FormParaBO/BOParaForm e a exigencia de botao de acao (os tres
366:     * primeiros estao entregues assim mesmo, abaixo) e MANTEM CarregarLista.
367:     *
368:     * NAO eh o ramo $legadoExibicaoF8, embora a tela pareca o caso dele: ele
369:     * exige $temListaLegadoF8 falso, e esse predicado da VERDADEIRO aqui
370:     * porque procura a palavra 'ControlSource' no dump - e getObsInsp tem
371:     * ControlSource = 'csTmpPrTar.ObsInsp'. Um EditBox ligado a um cursor
372:     * do form PAI nao eh lista; e a diferenca pratica eh nenhuma, porque o
373:     * ramo VISUALIZADOR cobre a mesma tela sem precisar daquela prova.
374:     *
375:     *   ENTREGUES (ja presentes desde fases anteriores, reaproveitados
376:     *   aqui em vez de duplicados)
377:     *     BOParaForm()    - mapeia o UNICO campo do dialogo:
378:     *                       SigPrTarBO.this_cObservacao -> EditBox
379:     *                       obj_4c_GetObsInsp (linha ~524).
380:     *     FormParaBO()    - sem campo editavel (getObsInsp eh ReadOnly no
381:     *                       SCX), devolve .T. (nada a transferir) para
382:     *                       respeitar o contrato de FUNCTION logica
383:     *                       (linha ~509).
384:     *     CarregarLista() - PUBLIC (regra #3 CLAUDE.md - harness
385:     *                       TesteAutomatico.prg chama direto no objeto).
386:     *                       Re-le a observacao da tarefa corrente e
387:     *                       repinta o EditBox via CarregarObservacao
388:     *                       (linha ~543).
389:     *     "Encerrar"      - CmdSairClick() (linha ~472), ligado por
390:     *                       BINDEVENT em ConfigurarBotaoSair() desde a
391:     *                       Fase 3. Equivalente funcional ao
392:     *                       BtnEncerrarClick do template generico - nome
393:     *                       preservado (Cmd<NomeDoObjeto>Click) porque
394:     *                       SIGSERPR.cmdSair e' o nome do controle no SCX,
395:     *                       nao um botao de barra CRUD.
396:     *
397:     *   NAO SE APLICAM (dialogo sem CRUD, sem botao de gravar e com todo
398:     *   campo somente-leitura - gate trata pelo ramo $legadoVisualizadorF8)
399:     *     BtnBuscarClick/BtnSalvarClick/BtnCancelarClick - nao ha botao de
400:     *                       busca/gravacao/cancelamento no legado: o
401:     *                       UNICO botao e' "Encerrar" (acima).
402:     *     HabilitarCampos/AjustarBotoesPorModo - nao ha modo de edicao
403:     *                       (INCLUIR/ALTERAR/VISUALIZAR) nem botao de
404:     *                       barra CRUD para habilitar/desabilitar -
405:     *                       FormBase nao amarra esses nomes a F2-F5
406:     *                       (conferido em classes\formbase.prg).
407:     *     LimparCampos    - nao sobrescrito; o default de FormBase
408:     *                       (no-op, classes\formbase.prg linha 276) ja
409:     *                       basta, porque Novo()/Excluir() (que o
410:     *                       chamam) nunca sao acionados por este dialogo
411:     *                       - nao ha botao Incluir/Excluir aqui.
412:     *
413:     * Criar qualquer um desses 8 nomes do zero so para "bater com o
414:     * template" inventaria superficie de UI que o legado nao tem (viola o
415:     * PILAR 1) ou deixaria metodo vazio so para casar com o nome (stub
416:     * disfarcado, proibido pela regra de completude). Mesma decisao
417:     * tomada em FormSigMvMen.prg/FormSigMvExp.prg para a mesma familia de
418:     * dialogo OPERACIONAL de EXIBICAO.
419:     *--------------------------------------------------------------------------
420: 
421:     *--------------------------------------------------------------------------
422:     * ConfigurarPaginaDados - Form OPERACIONAL FLAT (SIGSERPR.SCX nao tem
423:     * PageFrame nem Page2 - layout.json lista so os 10 objetos de
424:     * ConfigurarCabecalho/ConfigurarBotaoSair/ConfigurarObservacao, e TODOS
425:     * ja foram criados nas fases anteriores). Nao ha campo novo para
426:     * acrescentar aqui (inventar um violaria o PILAR 1) - o que o dump
427:     * ainda tem e as fases anteriores descartaram eh a ORDEM DE TABULACAO.
428:     *
429:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
430:     * tem relacao com o TabIndex do SCX legado - nao da erro, nao entra em

*-- Linhas 440 a 568:
440:     * cmd_4c_CmdSair -> obj_4c_GetObsInsp (EditBox ReadOnly ainda e'
441:     * focavel, para permitir selecionar/copiar o texto).
442:     *--------------------------------------------------------------------------
443:     PROTECTED PROCEDURE ConfigurarPaginaDados()
444:         LOCAL loc_oErro
445:         TRY
446:             THIS.cmd_4c_CmdSair.TabIndex     = 3
447:             THIS.lbl_4c_Label1.TabIndex      = 3
448:             THIS.obj_4c_GetObsInsp.TabIndex  = 4
449: 
450:             THIS.Refresh()
451:         CATCH TO loc_oErro
452:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
453:         ENDTRY
454:     ENDPROC
455: 
456:     *--------------------------------------------------------------------------
457:     * CarregarObservacao - Busca SigPrTar pela chave recebida no Init e
458:     * popula o EditBox via BOParaForm. Equivalente funcional ao
459:     * ControlSource = "csTmpPrTar.ObsInsp" do legado (que exibia o campo
460:     * ja carregado pelo form chamador); aqui a carga e' feita pelo proprio
461:     * BO, porque nao ha cursor compartilhado entre forms na nova arquitetura.
462:     *--------------------------------------------------------------------------
463:     PROTECTED PROCEDURE CarregarObservacao()
464:         IF EMPTY(THIS.this_cPkChave) OR VARTYPE(THIS.this_oBusinessObject) != "O"
465:             RETURN .F.
466:         ENDIF
467: 
468:         IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cPkChave)
469:             THIS.BOParaForm()
470:             RETURN .T.
471:         ELSE
472:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
473:             RETURN .F.
474:         ENDIF
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     * CmdSairClick - PUBLIC (BINDEVENT - regra #3 CLAUDE.md). Espelha
479:     * SIGSERPR.cmdSair.Click: reabilita o form pai e encerra o dialogo.
480:     *--------------------------------------------------------------------------
481:     PROCEDURE CmdSairClick()
482:         IF VARTYPE(THIS.this_oFormPai) = "O"
483:             THIS.this_oFormPai.Enabled = .T.
484:         ENDIF
485:         THIS.Release()
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * TornarControlesVisiveis - Torna visiveis todos os controles do form e
490:     * filhos diretos (AddObject cria controles com Visible=.F. por padrao)
491:     *--------------------------------------------------------------------------
492:     PROTECTED PROCEDURE TornarControlesVisiveis()
493:         LOCAL loc_i, loc_j, loc_oControl, loc_oSub
494: 
495:         FOR loc_i = 1 TO THIS.ControlCount
496:             loc_oControl = THIS.Controls(loc_i)
497:             IF VARTYPE(loc_oControl) = "O"
498:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
499:                     loc_oControl.Visible = .T.
500:                 ENDIF
501:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
502:                     FOR loc_j = 1 TO loc_oControl.ControlCount
503:                         loc_oSub = loc_oControl.Controls(loc_j)
504:                         IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
505:                             loc_oSub.Visible = .T.
506:                         ENDIF
507:                     ENDFOR
508:                 ENDIF
509:             ENDIF
510:         ENDFOR
511:     ENDPROC
512: 
513:     *--------------------------------------------------------------------------
514:     * FormParaBO - Form eh somente-leitura (getObsInsp.ReadOnly=.T. no legado);
515:     * nao ha dados editaveis a transferir para o Business Object. Override do
516:     * hook PROTECTED de FormBase - regra "hooks protegidos nao se alargam".
517:     *--------------------------------------------------------------------------
518:     PROTECTED FUNCTION FormParaBO()
519:         *-- O dialogo nao tem campo editavel (getObsInsp eh ReadOnly = .T. no
520:         *-- SCX), entao nao ha o que transferir da tela para o Business Object.
521:         *-- Devolve .T. (nada a fazer = sucesso) para o contrato de
522:         *-- FormParaBO -> FUNCTION logica ser respeitado: quem chama aborta a
523:         *-- gravacao com .F., e aqui nao ha falha possivel.
524:         RETURN .T.
525:     ENDFUNC
526: 
527:     *--------------------------------------------------------------------------
528:     * BOParaForm - Mapeamento BO -> tela. Override do hook PROTECTED de
529:     * FormBase. O dialogo tem um unico campo exibido: o EditBox
530:     * obj_4c_GetObsInsp, alimentado por SigPrTarBO.this_cObservacao
531:     * (coluna SigPrTar.obstars).
532:     *--------------------------------------------------------------------------
533:     PROTECTED PROCEDURE BOParaForm()
534:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
535:             RETURN .F.
536:         ENDIF
537: 
538:         IF PEMSTATUS(THIS, "obj_4c_GetObsInsp", 5)
539:             THIS.obj_4c_GetObsInsp.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cObservacao, ""))
540:         ENDIF
541: 
542:         RETURN .T.
543:     ENDPROC
544: 
545:     *--------------------------------------------------------------------------
546:     * CarregarLista - PUBLIC (o harness TesteAutomatico.prg chama direto no
547:     * objeto do form, de fora da classe - regra #3 CLAUDE.md). Este dialogo
548:     * nao tem grade: o conteudo que ele "lista" eh a observacao de inspecao.
549:     * Re-le a tarefa corrente e repinta o EditBox, reaproveitando
550:     * CarregarObservacao para nao duplicar a regra.
551:     *--------------------------------------------------------------------------
552:     PROCEDURE CarregarLista()
553:         IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
554:             RETURN .T.
555:         ENDIF
556: 
557:         RETURN THIS.CarregarObservacao()
558:     ENDPROC
559: 
560:     *--------------------------------------------------------------------------
561:     * Destroy - Encerramento padrao (FormBase.Destroy ja libera o Business
562:     * Object e restaura o menu principal)
563:     *--------------------------------------------------------------------------
564:     PROCEDURE Destroy()
565:         RETURN DODEFAULT()
566:     ENDPROC
567: 
568: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrTarBO.prg):
*====================================================================
* SigPrTarBO.prg
*
* Business Object para Tarefas do Processo (visualizacao de
* observacoes de inspecao vinculadas a uma tarefa de processo)
* Tabela: SigPrTar
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrTarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTar)
    this_cPkChave      = ""    && pkchaves char(20) - PK (Fortyus unique key)
    this_cProduto      = ""    && cpros char(14)
    this_cTarefa       = ""    && tarefas char(20)
    this_dDataInicio   = {}    && dtinis datetime
    this_dDataFim      = {}    && dtfims datetime
    this_cObservacao   = ""    && obstars text (memo) - observacao de inspecao
    this_cUsuario      = ""    && usuars char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrTarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults para novo registro
    * usuars eh NOT NULL - gc_4c_UsuarioLogado eh o padrao do sistema
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChave    = TratarNulo(pkchaves, "")
                THIS.this_cProduto    = TratarNulo(cpros,    "")
                THIS.this_cTarefa     = TratarNulo(tarefas,  "")
                THIS.this_dDataInicio = TratarNulo(dtinis,   {})
                THIS.this_dDataFim    = TratarNulo(dtfims,   {})
                THIS.this_cObservacao = TratarNulo(obstars,  "")
                THIS.this_cUsuario    = TratarNulo(usuars,   "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrTarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Busca a tarefa do processo (e a observacao de
    * inspecao, obstars) pela chave primaria pkchaves. Usado pelo form
    * (FormSigPrTar) para exibir no EditBox somente-leitura o texto que,
    * no legado, chegava ja carregado no cursor temporario csTmpPrTar
    * montado pelo form chamador.
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cPkChave, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cpros, dtfims, dtinis, obstars, pkchaves, tarefas, usuars" + ;
                " FROM SigPrTar WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChave))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_SigPrTar")
                TABLEREVERT(.T., "cursor_4c_SigPrTar")
                USE IN cursor_4c_SigPrTar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrTar")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigPrTar") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_SigPrTar")
                ELSE
                    THIS.this_cMensagemErro = "Tarefa do processo n" + CHR(227) + "o encontrada"
                ENDIF

                IF USED("cursor_4c_SigPrTar")
                    USE IN cursor_4c_SigPrTar
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar tarefa do processo:" + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao carregar:" + CHR(13) + loException.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTar
    * pkchaves eh PK tecnica Fortyus - gerada via fUniqueIds(), nunca vazia
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = fUniqueIds()
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuario))
                THIS.this_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTar (cpros, dtfims, dtinis, obstars, pkchaves, tarefas, usuars)
                VALUES (
                    <<EscaparSQL(THIS.this_cProduto)>>,
                    <<FormatarDataSQL(THIS.this_dDataFim)>>,
                    <<FormatarDataSQL(THIS.this_dDataInicio)>>,
                    <<EscaparSQL(THIS.this_cObservacao)>>,
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cTarefa)>>,
                    <<EscaparSQL(THIS.this_cUsuario)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tarefa do processo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrTarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTar
                SET cpros   = <<EscaparSQL(THIS.this_cProduto)>>,
                    dtfims  = <<FormatarDataSQL(THIS.this_dDataFim)>>,
                    dtinis  = <<FormatarDataSQL(THIS.this_dDataInicio)>>,
                    obstars = <<EscaparSQL(THIS.this_cObservacao)>>,
                    tarefas = <<EscaparSQL(THIS.this_cTarefa)>>,
                    usuars  = <<EscaparSQL(THIS.this_cUsuario)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tarefa do processo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrTarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

