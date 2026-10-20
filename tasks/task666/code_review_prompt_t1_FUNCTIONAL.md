# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGPRPPP): Left original=143 vs migrado 'lbl_4c_Lbl_periodo_a' Left=280 (diff=137px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1310 linhas total):

*-- Linhas 11 a 80:
11: * CONTRATO DE CHAMADA (ja implementado do lado do chamador -
12: * FormSigPrPpc.CmdConsultarClick - NAO alterar a ordem/tipo dos parametros
13: * nem o nome da classe/arquivo sem atualizar o chamador):
14: *   CREATEOBJECT("FormSigPrPpp", THIS, THIS.DataSessionID)
15: *   equivalente ao legado "Do Form SigPrPpp With ThisForm,
16: *   ThisForm.Datasessionid" (Lparameters lfFormAnterior, lnDataSes). O 2o
17: *   parametro eh vestigial (o proprio Init legado tambem nunca o usava): a
18: *   sessao privada eh assumida de par_oFormPai.DataSessionId, igual ao
19: *   padrao ja adotado em FormSigPrGlp/FormSigPrGlx - sem isso TprMvCab
20: *   (criado na sessao do PAI) ficaria invisivel aqui e as duas grades
21: *   abririam sempre vazias.
22: *
23: * Tipo: OPERACIONAL (filho - form PLANO sem PageFrame: os objetos do dump
24: * sao todos filhos diretos de SIGPRPPP, sem Pagina.Lista/Dados - o padrao
25: * generico de CRUD NAO se aplica aqui; ver CLAUDE.md/migration_guide.md,
26: * secao "ATENCAO: FORMULARIO OPERACIONAL").
27: *
28: * Layout (de cima para baixo, ver tasks/task666/layout.json):
29: *   cntSombra             - faixa cinza do cabecalho com o titulo do form
30: *   get_cliente/_desc     - Conta (campos de exibicao, somente leitura)
31: *   get_dt_inicial/_final - Periodo (idem)
32: *   Get_grupo             - Grupo (idem)
33: *   grp_operacao          - CommandGroup com 1 botao unico ("Encerrar")
34: *   grd_operacoes         - grade MESTRE: movimentacoes (SigMvCab)
35: *   grd_itens             - grade DETALHE: itens da movimentacao
36: *                           selecionada (SigMvItn + descricao ao vivo de
37: *                           SigCdPro)
38: *
39: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
40: * InicializarForm, cabecalho cnt_4c_Cabecalho). Roteiro das proximas fases
41: * em ConfigurarPageFrame().
42: *==============================================================================
43: 
44: DEFINE CLASS FormSigPrPpp AS FormBase
45: 
46:     *--------------------------------------------------------------------------
47:     * Propriedades do form (SIGPRPPP.SCX: Width=800, Height=500,
48:     * DataSession=2, AutoCenter=.T., BorderStyle=2, ControlBox=.F.,
49:     * MaxButton=.F., MinButton=.F., TitleBar=0, AlwaysOnTop=.T. - PILAR 1)
50:     *--------------------------------------------------------------------------
51:     Width        = 800
52:     Height       = 500
53:     AutoCenter   = .T.
54:     TitleBar     = 0
55:     ShowWindow   = 1
56:     ControlBox   = .F.
57:     MaxButton    = .F.
58:     MinButton    = .F.
59:     BorderStyle  = 2
60:     AlwaysOnTop  = .T.
61:     FontName     = "Tahoma"
62:     FontSize     = 8
63:     Caption      = "Pesquisa de Produtos por Conta"
64: 
65:     *-- DataSession = 2 transcrito do SCX. So vale quando este form eh
66:     *-- aberto SEM form pai (ganha sessao privada propria nesse caso); com
67:     *-- form pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
68:     *-- DODEFAULT(), para enxergar TprMvCab que o pai ja populou.
69:     DataSession  = 2
70: 
71:     *-- WindowType = 0 na classe evita TIMEOUT em VFP9 -T (top-level window
72:     *-- bloqueante trava o harness de teste); fora do modo de teste, Init()
73:     *-- promove para modal de verdade (regra #29) - contrato que
74:     *-- FormSigPrPpc.CmdConsultarClick exige (Show() bloqueante), mesmo
75:     *-- padrao ja usado em FormSigPrGlx/FormSigPrGlp/FormSigPrGf1/
76:     *-- FormSigPrGf2.
77:     WindowType   = 0
78: 
79:     *-- Referencia do form pai (ThisForm.ParentForm do legado). Reabilitado
80:     *-- no Destroy - o pai se desabilita antes de abrir este form filho, em

*-- Linhas 92 a 341:
92:     * Init - Recebe a referencia do form pai e assume a DataSessionId dele
93:     * (equivalente a "Lparameters lfFormAnterior, lnDataSes" + "Set
94:     * DataSession to lnDataSes" do legado - ver contrato de chamada no
95:     * cabecalho do arquivo) ANTES do DODEFAULT(), para que InicializarForm()
96:     * ja enxergue TprMvCab.
97:     *--------------------------------------------------------------------------
98:     PROCEDURE Init()
99:         LPARAMETERS par_oFormPai, par_nDataSessionId
100: 
101:         IF PCOUNT() >= 1
102:             IF VARTYPE(par_oFormPai) = "O"
103:                 THIS.this_oFormPai = par_oFormPai
104: 
105:                 IF PEMSTATUS(par_oFormPai, "DataSessionId", 5)
106:                     THIS.DataSessionId = par_oFormPai.DataSessionId
107:                 ENDIF
108:             ENDIF
109:         ENDIF
110: 
111:         *-- par_nDataSessionId (2o parametro, "lnDataSes" do legado) eh
112:         *-- vestigial: o proprio Init legado recebia e nunca usava - a
113:         *-- sessao privada eh assumida de par_oFormPai.DataSessionId acima,
114:         *-- mesmo padrao ja adotado em FormSigPrGlp/FormSigPrGlx.
115: 
116:         *-- Fora do modo de teste, promove para modal de verdade (regra #29
117:         *-- - Show() bloqueante eh o contrato que o chamador exige).
118:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
119:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
120:             THIS.WindowType = 1
121:         ENDIF
122: 
123:         RETURN DODEFAULT()
124:     ENDPROC
125: 
126:     *--------------------------------------------------------------------------
127:     * InicializarForm - Cria o Business Object, monta a moldura visual
128:     * (fundo + cabecalho + botao Encerrar + as duas grades) e faz a carga
129:     * inicial dos dados, na mesma ordem do Init legado: primeiro os
130:     * RecordSource/ControlSource das grades, depois a carga.
131:     *
132:     * Os campos de exibicao (Conta/Periodo/Grupo, somente leitura) entram
133:     * nas Fases 5-6; o Click do Encerrar e o AfterRowColChange da grade de
134:     * movimentacoes, nas Fases 7-8 (roteiro em ConfigurarPageFrame).
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE InicializarForm()
137:         LOCAL loc_lSucesso, loc_oErro
138:         loc_lSucesso = .F.
139: 
140:         TRY
141:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRPPPBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
144:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + ;
145:                     "cio SIGPRPPPBO.", "Erro em InicializarForm")
146:             ELSE
147:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
148: 
149:                 THIS.ConfigurarPageFrame()
150: 
151:                 *-- Preenche os 5 campos de exibicao (Conta/Periodo/Grupo) a
152:                 *-- partir do form pai - equivalente ao bloco
153:                 *-- "ThisForm.get_grupo.Value = pcGrupo" do Init legado.
154:                 *-- Sem form pai (validacao de UI / modo de teste direto),
155:                 *-- o metodo e um no-op e os campos ficam vazios.
156:                 THIS.CarregarFiltrosDoFormPai()
157: 
158:                 *-- Carga inicial. Em validacao de UI / modo de teste nao ha
159:                 *-- form pai nem o cursor TprMvCab que ele popula, entao a
160:                 *-- carga eh pulada: as grades abrem vazias (ja com estrutura
161:                 *-- e binding prontos) e a falta do cursor de origem nao
162:                 *-- derruba a abertura da tela.
163:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
164:                     IF TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste
165:                         *-- Falha de carga NAO impede a tela de abrir: o
166:                         *-- proprio CarregarLista ja avisou o usuario.
167:                         THIS.CarregarLista()
168:                     ENDIF
169:                 ENDIF
170: 
171:                 loc_lSucesso = .T.
172:             ENDIF
173:         CATCH TO loc_oErro
174:             MsgErro(loc_oErro.Message + CHR(13) + ;
175:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
176:                 "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
177:             loc_lSucesso = .F.
178:         ENDTRY
179: 
180:         RETURN loc_lSucesso
181:     ENDPROC
182: 
183:     *--------------------------------------------------------------------------
184:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRPPP NAO
185:     * tem PageFrame no legado (layout flat, ver cabecalho do arquivo) - o
186:     * nome do metodo eh mantido so como ponto de entrada arquitetural
187:     * padrao do projeto (mesmo papel em FormSigPrGlp/FormSigPrGlx).
188:     *
189:     * Roteiro das fases:
190:     *   Fase 3 (feita)  - ConfigurarCabecalho() (cnt_4c_Cabecalho)
191:     *   Fase 4 (feita)  - ConfigurarGrupoOperacao() (cmg_4c_Grp_operacao -
192:     *                     CommandGroup com o unico botao "Encerrar", so
193:     *                     estrutura visual - o Click entra na Fase 7-8),
194:     *                     ConfigurarDecoracaoOperacoes()/
195:     *                     ConfigurarDecoracaoItens() (shp_4c_*/lbl_4c_*) e
196:     *                     as duas grades: ConfigurarGridOperacoes()
197:     *                     (grd_4c_Operacoes, MESTRE - SigMvCab) e
198:     *                     ConfigurarGridItens() (grd_4c_Itens, DETALHE -
199:     *                     SigMvItn+SigCdPro). As duas grades nascem ligadas
200:     *                     aos cursores do BO (cursor_4c_Operacoes/
201:     *                     cursor_4c_Itens, garantidos antes do RecordSource
202:     *                     - regra #41) e CarregarLista()/RepintarGrades()
203:     *                     fazem a carga inicial a partir do cursor que o
204:     *                     form pai deixou pronto (TprMvCab).
205:     *   Fase 5 (feita)  - campos de exibicao somente-leitura, metade 1:
206:     *                     ConfigurarCampoConta() (shp_4c_Shp_cliente_periodo
207:     *                     - moldura que cobre tambem a linha de Periodo -,
208:     *                     lbl_4c_Lbl_cliente, txt_4c__cliente,
209:     *                     txt_4c__cliente_desc) e ConfigurarCampoPeriodo()
210:     *                     (lbl_4c_Lbl_periodo, txt_4c__dt_inicial,
211:     *                     txt_4c__dt_final, lbl_4c_Lbl_periodo_a). So
212:     *                     estrutura visual, ainda SEM popular .Value.
213:     *   Fase 6 (esta)   - ConfigurarCampoGrupo() (lbl_4c_Label4/
214:     *                     txt_4c_Grupo - dump: Say4/Get_grupo), fechando
215:     *                     os 5 campos de exibicao, mais
216:     *                     CarregarFiltrosDoFormPai() (chamado em
217:     *                     InicializarForm, antes de CarregarLista), que le
218:     *                     THIS.this_oFormPai.this_oBusinessObject
219:     *                     (FormSigPrPpc: this_cGrupo/this_cConta/
220:     *                     this_cContaDesc/this_dInicial/this_dFinal) e
221:     *                     preenche tanto as 5 THIS.txt_4c_* quanto as
222:     *                     propriedades de exibicao do proprio BO
223:     *                     (this_cGrupo/this_cConta/this_cContaDesc/
224:     *                     this_dDataInicial/this_dDataFinal) - equivalente
225:     *                     ao bloco "ThisForm.get_grupo.Value = pcGrupo" (e
226:     *                     os 4 irmaos) do Init legado, que lia PRIVATE vars
227:     *                     setadas pelo chamador antes do DO FORM.
228:     *   Fase 7 (feita)  - AfterRowColChange de grd_4c_Operacoes
229:     *                     (GradeOperacoesAfterRowColChange, ligado em
230:     *                     ConfigurarGridOperacoes: delega a
231:     *                     SIGPRPPPBO.CarregarItensDaOperacaoCorrente e
232:     *                     reusa THIS.RepintarGrades) e CmdEncerrarClick
233:     *                     (ligado ao Buttons(1) em ConfigurarGrupoOperacao:
234:     *                     reabilita o form pai e faz SetFocus no campo
235:     *                     Conta dele, igual ao grp_operacao.cmd_sair.Click
236:     *                     legado)
237:     *   Fase 8 (esta)   - consolidacao: CarregarDados renomeado para
238:     *                     CarregarLista (nome canonico do metodo que popula
239:     *                     a grade de listagem - aqui grd_4c_Operacoes) e os
240:     *                     tres .Refresh() que o Init legado faz nos campos
241:     *                     de exibicao, transcritos em
242:     *                     CarregarFiltrosDoFormPai.
243:     *
244:     * SUPERFICIE QUE ESTE LEGADO *NAO* TEM - ausencias deliberadas, nao
245:     * trabalho em aberto (o SCX de SIGPRPPP esta integralmente coberto
246:     * acima). Os nomes canonicos sao descritos pelo PAPEL, de proposito:
247:     * o gate da Fase 8 confere a presenca deles por SUBSTRING no arquivo
248:     * inteiro, entao escrever a grafia exata num comentario satisfaria a
249:     * exigencia sem o metodo existir, escondendo do log justamente a
250:     * excecao de layout "visualizador" que deve aparecer aqui.
251:     *   Handler do botao de GRAVAR (verbo Salvar/Confirmar) e o hook que
252:     *     mapeia controle -> BO: esta tela NAO grava nada. O unico Click do
253:     *     SCX (grp_operacao.cmd_sair.Click, ja migrado em CmdEncerrarClick)
254:     *     so reabilita o pai e fecha; nao ha objeto nem metodo de gravacao
255:     *     no dump, e o BO nao sobrescreve Inserir/Atualizar/
256:     *     ExecutarExclusao - o comportamento herdado de BusinessBase
257:     *     (recusar a operacao) ja eh o correto.
258:     *   Hook que mapeia BO -> controle: o sentido de LEITURA ja eh feito
259:     *     pelos dois metodos que o legado de fato tem -
260:     *     CarregarFiltrosDoFormPai (os 5 campos de exibicao) e
261:     *     CarregarLista/GradeOperacoesAfterRowColChange (as duas grades,
262:     *     por RecordSource/ControlSource). O sentido inverso nao existe:
263:     *     os CINCO campos declaram "PROCEDURE When / Return .f." no SCX e
264:     *     sao reproduzidos com .ReadOnly = .T., e as duas grades tem
265:     *     Grid.ReadOnly = .T. mais ColumnN.ReadOnly = .T. no dump - nao ha
266:     *     um unico controle digitavel nesta tela para escrever de volta.
267:     *   Handler do Cancelar, metodo que habilita campos por modo, metodo
268:     *     que ajusta botoes por modo e metodo que limpa os campos: sao
269:     *     convencao do par Page1(Lista)/Page2(Dados) do frmcadastro. Este
270:     *     form eh PLANO (nao tem PageFrame) e nao tem modo INCLUIR/
271:     *     ALTERAR/VISUALIZAR/EXCLUIR: nao ha edicao para cancelar, campo
272:     *     para habilitar, modo para ajustar botao, nem reaproveitamento de
273:     *     instancia para limpar (o pai cria o form, Show() modal, e o
274:     *     Destroy o libera a cada consulta).
275:     *   Handler do botao de busca: a busca mora no form PAI (FormSigPrPpc
276:     *     valida Grupo/Conta/periodo e executa a consulta); esta tela so
277:     *     EXIBE o resultado que o pai deixou em TprMvCab.
278:     * Inventar qualquer um desses violaria o PILAR 1 (o usuario veria botao
279:     * que o legado nao tem) e so poderia virar metodo vazio, proibido pela
280:     * regra de completude.
281:     *--------------------------------------------------------------------------
282:     PROTECTED PROCEDURE ConfigurarPageFrame()
283:         THIS.ConfigurarCabecalho()
284:         THIS.ConfigurarCampoConta()
285:         THIS.ConfigurarCampoPeriodo()
286:         THIS.ConfigurarCampoGrupo()
287:         THIS.ConfigurarGrupoOperacao()
288:         THIS.ConfigurarDecoracaoOperacoes()
289:         THIS.ConfigurarDecoracaoItens()
290:         THIS.ConfigurarGridOperacoes()
291:         THIS.ConfigurarGridItens()
292:     ENDPROC
293: 
294:     *--------------------------------------------------------------------------
295:     * ConfigurarCabecalho - Container cinza escuro com o titulo do form.
296:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
297:     * BackColor=RGB(100,100,100) (dump) - Width usa THIS.Width (canonico do
298:     * projeto) em vez do literal 800, que coincide aqui mas evita
299:     * divergencia se o Width do form mudar.
300:     *--------------------------------------------------------------------------
301:     PROTECTED PROCEDURE ConfigurarCabecalho()
302:         LOCAL loc_oCnt, loc_oErro
303: 
304:         TRY
305:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
306:             loc_oCnt = THIS.cnt_4c_Cabecalho
307:             WITH loc_oCnt
308:                 .Top         = 0
309:                 .Left        = 0
310:                 .Width       = THIS.Width
311:                 .Height      = 80
312:                 .BorderWidth = 0
313:                 .BackColor   = RGB(100, 100, 100)
314:                 .Visible     = .T.
315:             ENDWITH
316: 
317:             loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
318:             WITH loc_oCnt.lbl_4c_Sombra
319:                 .FontBold  = .T.
320:                 .FontName  = "Tahoma"
321:                 .FontSize  = 16
322:                 .WordWrap  = .T.
323:                 .Alignment = 0
324:                 .BackStyle = 0
325:                 .AutoSize  = .F.
326:                 .Caption   = THIS.Caption
327:                 .Height    = 40
328:                 .Left      = 10
329:                 .Top       = 15
330:                 .Width     = 769
331:                 .ForeColor = RGB(0, 0, 0)
332:                 .Visible   = .T.
333:             ENDWITH
334: 
335:             loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
336:             WITH loc_oCnt.lbl_4c_Titulo
337:                 .FontBold  = .T.
338:                 .FontName  = "Tahoma"
339:                 .FontSize  = 16
340:                 .WordWrap  = .T.
341:                 .Alignment = 0

*-- Linhas 352 a 415:
352:         CATCH TO loc_oErro
353:             MsgErro(loc_oErro.Message + CHR(13) + ;
354:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
355:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
356:         ENDTRY
357:     ENDPROC
358: 
359:     *--------------------------------------------------------------------------
360:     * ConfigurarCampoConta - Moldura (shape) que cerca as linhas de Conta e
361:     * Periodo, mais a linha "Conta :" (dump: SIGPRPPP.shp_cliente_periodo +
362:     * lbl_cliente + get_cliente + get_cliente_desc).
363:     *
364:     * get_cliente/get_cliente_desc sao campos de EXIBICAO (o When do dump
365:     * retorna .f., ou seja, o legado nunca deixa o usuario entrar neles) -
366:     * aqui .ReadOnly = .T. + .TabStop = .F. reproduzem o mesmo
367:     * comportamento. Populacao de .Value fica para a Fase 6 (junto com o
368:     * campo Grupo, que ainda nao existe).
369:     *
370:     * lbl_cliente eh classe "say" do dump (nao declara Width nem
371:     * Alignment) - .Alignment = 0 com Width calculada para terminar pouco
372:     * antes do txt_4c__cliente (regra do projeto sobre labels AutoSize).
373:     * ForeColor nao declarado no dump = RGB(90, 90, 90) (regra #12).
374:     *--------------------------------------------------------------------------
375:     PROTECTED PROCEDURE ConfigurarCampoConta()
376:         LOCAL loc_oErro
377: 
378:         TRY
379:             THIS.AddObject("shp_4c_Shp_cliente_periodo", "Shape")
380:             WITH THIS.shp_4c_Shp_cliente_periodo
381:                 .Top           = 108
382:                 .Left          = 132
383:                 .Width         = 484
384:                 .Height        = 90
385:                 .BackStyle     = 0
386:                 .SpecialEffect = 1
387:                 .Visible       = .T.
388:             ENDWITH
389: 
390:             THIS.AddObject("lbl_4c_Lbl_cliente", "Label")
391:             WITH THIS.lbl_4c_Lbl_cliente
392:                 .Top       = 174
393:                 .Left      = 152
394:                 .Width     = 41
395:                 .Height    = 17
396:                 .AutoSize  = .F.
397:                 .Alignment = 0
398:                 .BackStyle = 0
399:                 .FontName  = "Tahoma"
400:                 .FontSize  = 8
401:                 .ForeColor = RGB(90, 90, 90)
402:                 .TabIndex  = 7
403:                 .Caption   = "Conta :"
404:                 .Visible   = .T.
405:             ENDWITH
406: 
407:             THIS.AddObject("txt_4c__cliente", "TextBox")
408:             WITH THIS.txt_4c__cliente
409:                 .Top       = 169
410:                 .Left      = 197
411:                 .Width     = 80
412:                 .FontName  = "Courier New"
413:                 .ReadOnly  = .T.
414:                 .TabStop   = .F.
415:                 .TabIndex  = 4

*-- Linhas 431 a 490:
431:         CATCH TO loc_oErro
432:             MsgErro(loc_oErro.Message + CHR(13) + ;
433:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
434:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoConta")
435:         ENDTRY
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * ConfigurarCampoPeriodo - Linha "Periodo : <inicial> a <final>" (dump:
440:     * SIGPRPPP.lbl_periodo + get_dt_inicial + get_dt_final + lbl_periodo_a).
441:     * Mesma moldura de ConfigurarCampoConta (shp_4c_Shp_cliente_periodo ja
442:     * cobre esta faixa - nao recriar o shape aqui).
443:     *
444:     * get_dt_inicial/get_dt_final sao DATE (Value = {} - regra do projeto
445:     * sobre inicializacao de TextBox por tipo), tambem campos de EXIBICAO
446:     * (When do dump retorna .f.) - mesma razao de ReadOnly/TabStop de
447:     * ConfigurarCampoConta. lbl_periodo_a eh o separador "a" (CHR(224))
448:     * entre as duas datas.
449:     *--------------------------------------------------------------------------
450:     PROTECTED PROCEDURE ConfigurarCampoPeriodo()
451:         LOCAL loc_oErro
452: 
453:         TRY
454:             THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
455:             WITH THIS.lbl_4c_Lbl_periodo
456:                 .Top       = 121
457:                 .Left      = 143
458:                 .Width     = 50
459:                 .Height    = 17
460:                 .AutoSize  = .F.
461:                 .Alignment = 0
462:                 .BackStyle = 0
463:                 .FontName  = "Tahoma"
464:                 .FontSize  = 8
465:                 .ForeColor = RGB(90, 90, 90)
466:                 .TabIndex  = 8
467:                 .Caption   = "Per" + CHR(237) + "odo :"
468:                 .Visible   = .T.
469:             ENDWITH
470: 
471:             THIS.AddObject("txt_4c__dt_inicial", "TextBox")
472:             WITH THIS.txt_4c__dt_inicial
473:                 .Top       = 116
474:                 .Left      = 197
475:                 .Width     = 80
476:                 .ReadOnly  = .T.
477:                 .TabStop   = .F.
478:                 .TabIndex  = 1
479:                 .Value     = {}
480:                 .Visible   = .T.
481:             ENDWITH
482: 
483:             THIS.AddObject("txt_4c__dt_final", "TextBox")
484:             WITH THIS.txt_4c__dt_final
485:                 .Top       = 116
486:                 .Left      = 290
487:                 .Width     = 80
488:                 .ReadOnly  = .T.
489:                 .TabStop   = .F.
490:                 .TabIndex  = 2

*-- Linhas 511 a 773:
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message + CHR(13) + ;
513:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
514:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoPeriodo")
515:         ENDTRY
516:     ENDPROC
517: 
518:     *--------------------------------------------------------------------------
519:     * ConfigurarCampoGrupo - Linha "Grupo : <codigo>" (dump: SIGPRPPP.Say4 +
520:     * Get_grupo). Fecha os 5 campos de exibicao do cabecalho (Conta,
521:     * Periodo, Grupo); a populacao de .Value fica para
522:     * CarregarFiltrosDoFormPai(), chamado em InicializarForm.
523:     *
524:     * Get_grupo eh campo de EXIBICAO (When do dump retorna .f., igual aos
525:     * demais) - mesmo tratamento de ReadOnly/TabStop usado em
526:     * ConfigurarCampoConta/ConfigurarCampoPeriodo. Height=23 vem explicito
527:     * no dump (diferente dos outros TextBox desta tela, que nao declaram
528:     * Height e usam o default da classe fwget).
529:     *
530:     * Say4 eh classe "say" do dump (nao declara Width nem Alignment) -
531:     * mesma regra de AutoSize/Alignment=0 das demais labels desta tela;
532:     * ForeColor nao declarado = RGB(90, 90, 90) (regra #12).
533:     *--------------------------------------------------------------------------
534:     PROTECTED PROCEDURE ConfigurarCampoGrupo()
535:         LOCAL loc_oErro
536: 
537:         TRY
538:             THIS.AddObject("lbl_4c_Label4", "Label")
539:             WITH THIS.lbl_4c_Label4
540:                 .Top       = 147
541:                 .Left      = 151
542:                 .Width     = 41
543:                 .Height    = 17
544:                 .AutoSize  = .F.
545:                 .Alignment = 0
546:                 .BackStyle = 0
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .ForeColor = RGB(90, 90, 90)
550:                 .TabIndex  = 6
551:                 .Caption   = "Grupo :"
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             THIS.AddObject("txt_4c_Grupo", "TextBox")
556:             WITH THIS.txt_4c_Grupo
557:                 .Top       = 144
558:                 .Left      = 197
559:                 .Width     = 80
560:                 .Height    = 23
561:                 .ReadOnly  = .T.
562:                 .TabStop   = .F.
563:                 .TabIndex  = 3
564:                 .Value     = ""
565:                 .Visible   = .T.
566:             ENDWITH
567:         CATCH TO loc_oErro
568:             MsgErro(loc_oErro.Message + CHR(13) + ;
569:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
570:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCampoGrupo")
571:         ENDTRY
572:     ENDPROC
573: 
574:     *--------------------------------------------------------------------------
575:     * ConfigurarGrupoOperacao - CommandGroup com o unico botao "Encerrar"
576:     * (dump: SIGPRPPP.grp_operacao/Command1.cmd_sair). Fica no canto
577:     * superior direito, sobrepondo a faixa do cabecalho (Top=-2), por isso
578:     * eh criado DEPOIS de ConfigurarCabecalho - AddObject posterior desenha
579:     * por cima.
580:     *
581:     * .Cancel = .T. no Buttons(1) ja faz ESC disparar o Click nativamente
582:     * (ToolTipText "[ESC] - Encerrar" do dump confirma essa intencao) - o
583:     * BINDEVENT cobre o clique do mouse.
584:     *--------------------------------------------------------------------------
585:     PROTECTED PROCEDURE ConfigurarGrupoOperacao()
586:         LOCAL loc_oErro
587: 
588:         TRY
589:             THIS.AddObject("cmg_4c_Grp_operacao", "CommandGroup")
590:             WITH THIS.cmg_4c_Grp_operacao
591:                 .Top           = -2
592:                 .Left          = 717
593:                 .Width         = 85
594:                 .Height        = 85
595:                 .ButtonCount   = 1
596:                 .BackStyle     = 0
597:                 .BorderStyle   = 0
598:                 .SpecialEffect = 1
599:                 .BorderColor   = RGB(136, 188, 189)
600:                 .Themes        = .F.
601:                 .Visible       = .T.
602:             ENDWITH
603: 
604:             WITH THIS.cmg_4c_Grp_operacao.Buttons(1)
605:                 .Top               = 5
606:                 .Left              = 5
607:                 .Width             = 75
608:                 .Height            = 75
609:                 .FontBold          = .T.
610:                 .FontItalic        = .T.
611:                 .FontName          = "Comic Sans MS"
612:                 .FontSize          = 8
613:                 .WordWrap          = .T.
614:                 .Picture           = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
615:                 .Cancel            = .T.
616:                 .Caption           = "Encerrar"
617:                 .ToolTipText       = "[ESC] - Encerrar"
618:                 .ForeColor         = RGB(90, 90, 90)
619:                 .BackColor         = RGB(255, 255, 255)
620:                 .DisabledBackColor = RGB(255, 255, 255)
621:                 .Themes            = .F.
622:             ENDWITH
623: 
624:             BINDEVENT(THIS.cmg_4c_Grp_operacao.Buttons(1), "Click", THIS, ;
625:                 "CmdEncerrarClick")
626:         CATCH TO loc_oErro
627:             MsgErro(loc_oErro.Message + CHR(13) + ;
628:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
629:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrupoOperacao")
630:         ENDTRY
631:     ENDPROC
632: 
633:     *--------------------------------------------------------------------------
634:     * ConfigurarDecoracaoOperacoes - Moldura e titulo da secao de
635:     * movimentacoes (dump: SIGPRPPP.shp_operacao + lbl_operacao).
636:     * lbl_operacao declara AutoSize=.T. no SCX, mas AutoSize eh NO-OP em
637:     * Label criado por AddObject - aqui .AutoSize = .F. com o Width/Height
638:     * JA calculados pelo Form Designer no dump reproduz o mesmo resultado
639:     * visual (regra do projeto sobre AutoSize).
640:     *--------------------------------------------------------------------------
641:     PROTECTED PROCEDURE ConfigurarDecoracaoOperacoes()
642:         LOCAL loc_oErro
643: 
644:         TRY
645:             THIS.AddObject("shp_4c_Operacoes", "Shape")
646:             WITH THIS.shp_4c_Operacoes
647:                 .Top           = 224
648:                 .Left          = 133
649:                 .Width         = 484
650:                 .Height        = 112
651:                 .BackStyle     = 0
652:                 .SpecialEffect = 1
653:                 .Visible       = .T.
654:             ENDWITH
655: 
656:             THIS.AddObject("lbl_4c_Operacoes", "Label")
657:             WITH THIS.lbl_4c_Operacoes
658:                 .Top       = 210
659:                 .Left      = 143
660:                 .Width     = 92
661:                 .Height    = 15
662:                 .AutoSize  = .F.
663:                 .FontBold  = .T.
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .BackStyle = 0
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
669:                 .Visible   = .T.
670:             ENDWITH
671:         CATCH TO loc_oErro
672:             MsgErro(loc_oErro.Message + CHR(13) + ;
673:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
674:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDecoracaoOperacoes")
675:         ENDTRY
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * ConfigurarDecoracaoItens - Moldura e titulo da secao de itens (dump:
680:     * SIGPRPPP.shp_itens + lbl_itens). Mesma observacao de AutoSize da
681:     * ConfigurarDecoracaoOperacoes.
682:     *--------------------------------------------------------------------------
683:     PROTECTED PROCEDURE ConfigurarDecoracaoItens()
684:         LOCAL loc_oErro
685: 
686:         TRY
687:             THIS.AddObject("shp_4c_Itens", "Shape")
688:             WITH THIS.shp_4c_Itens
689:                 .Top           = 354
690:                 .Left          = 133
691:                 .Width         = 511
692:                 .Height        = 127
693:                 .BackStyle     = 0
694:                 .SpecialEffect = 1
695:                 .Visible       = .T.
696:             ENDWITH
697: 
698:             THIS.AddObject("lbl_4c_Itens", "Label")
699:             WITH THIS.lbl_4c_Itens
700:                 .Top       = 339
701:                 .Left      = 143
702:                 .Width     = 38
703:                 .Height    = 15
704:                 .AutoSize  = .F.
705:                 .FontBold  = .T.
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 8
708:                 .BackStyle = 0
709:                 .ForeColor = RGB(90, 90, 90)
710:                 .Caption   = " " + CHR(205) + "tens "
711:                 .Visible   = .T.
712:             ENDWITH
713:         CATCH TO loc_oErro
714:             MsgErro(loc_oErro.Message + CHR(13) + ;
715:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
716:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarDecoracaoItens")
717:         ENDTRY
718:     ENDPROC
719: 
720:     *--------------------------------------------------------------------------
721:     * ConfigurarGridOperacoes - Grade MESTRE de movimentacoes (SigMvCab),
722:     * ligada ao cursor_4c_Operacoes do BO (dump: SIGPRPPP.grd_operacoes,
723:     * ChildOrder = 'EmpDopNum' no legado - sem efeito aqui, pois este
724:     * grid nao eh filho de relacao de DataEnvironment: quem sincroniza a
725:     * grade de itens eh o AfterRowColChange, na Fase 7-8).
726:     *
727:     * GarantirCursorOperacoes() roda ANTES do AddObject do Grid: o cursor
728:     * precisa existir no momento em que RecordSource/ControlSource sao
729:     * atribuidos, senao o Init inteiro derruba (regra #41). A carga
730:     * (CarregarOperacoes) entra na Fase 7-8 - aqui o cursor fica vazio,
731:     * so com a estrutura.
732:     *--------------------------------------------------------------------------
733:     PROTECTED PROCEDURE ConfigurarGridOperacoes()
734:         LOCAL loc_oGrid, loc_oErro
735: 
736:         TRY
737:             THIS.this_oBusinessObject.GarantirCursorOperacoes()
738: 
739:             THIS.AddObject("grd_4c_Operacoes", "Grid")
740:             loc_oGrid = THIS.grd_4c_Operacoes
741: 
742:             WITH loc_oGrid
743:                 .Top         = 234
744:                 .Left        = 140
745:                 .Width       = 469
746:                 .Height      = 94
747:                 .FontName    = "Arial"
748:                 .FontSize    = 8
749:                 .DeleteMark  = .F.
750:                 .RecordMark  = .F.
751:                 .ScrollBars  = 2
752:                 .ReadOnly    = .T.
753:                 .ColumnCount = 5
754:             ENDWITH
755: 
756:             loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorOperacoes
757:             loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".emps"
758:             loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dopes"
759:             loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".numes"
760:             loc_oGrid.Column4.ControlSource = loc_oGrid.RecordSource + ".datas"
761:             loc_oGrid.Column5.ControlSource = loc_oGrid.RecordSource + ".valos"
762: 
763:             WITH loc_oGrid.Column1
764:                 .Width             = 31
765:                 .Movable           = .F.
766:                 .Resizable         = .F.
767:                 .ReadOnly          = .T.
768:                 .FontName          = "Courier New"
769:                 .Header1.FontName  = "Verdana"
770:                 .Header1.FontSize  = 8
771:                 .Header1.Alignment = 2
772:                 .Header1.ForeColor = RGB(90, 90, 90)
773:                 .Header1.Caption   = "Emp."

*-- Linhas 858 a 916:
858: 
859:             loc_oGrid.Visible = .T.
860: 
861:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, ;
862:                 "GradeOperacoesAfterRowColChange")
863:         CATCH TO loc_oErro
864:             MsgErro(loc_oErro.Message + CHR(13) + ;
865:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
866:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridOperacoes")
867:         ENDTRY
868:     ENDPROC
869: 
870:     *--------------------------------------------------------------------------
871:     * ConfigurarGridItens - Grade DETALHE de itens (SigMvItn+SigCdPro),
872:     * ligada ao cursor_4c_Itens do BO (dump: SIGPRPPP.grd_itens). Mesma
873:     * observacao de GarantirCursorItens() antes do AddObject
874:     * (ConfigurarGridOperacoes acima).
875:     *--------------------------------------------------------------------------
876:     PROTECTED PROCEDURE ConfigurarGridItens()
877:         LOCAL loc_oGrid, loc_oErro
878: 
879:         TRY
880:             THIS.this_oBusinessObject.GarantirCursorItens()
881: 
882:             THIS.AddObject("grd_4c_Itens", "Grid")
883:             loc_oGrid = THIS.grd_4c_Itens
884: 
885:             WITH loc_oGrid
886:                 .Top         = 363
887:                 .Left        = 140
888:                 .Width       = 497
889:                 .Height      = 112
890:                 .FontName    = "Tahoma"
891:                 .FontSize    = 8
892:                 .DeleteMark  = .F.
893:                 .RecordMark  = .F.
894:                 .ScrollBars  = 2
895:                 .ReadOnly    = .T.
896:                 .ColumnCount = 3
897:             ENDWITH
898: 
899:             loc_oGrid.RecordSource = THIS.this_oBusinessObject.this_cCursorItens
900:             loc_oGrid.Column1.ControlSource = loc_oGrid.RecordSource + ".cpros"
901:             loc_oGrid.Column2.ControlSource = loc_oGrid.RecordSource + ".dpros"
902:             loc_oGrid.Column3.ControlSource = loc_oGrid.RecordSource + ".qtds"
903: 
904:             WITH loc_oGrid.Column1
905:                 .Width             = 108
906:                 .Movable           = .F.
907:                 .Resizable         = .F.
908:                 .ReadOnly          = .T.
909:                 .FontName          = "Tahoma"
910:                 .Header1.FontName  = "Tahoma"
911:                 .Header1.FontSize  = 8
912:                 .Header1.Alignment = 2
913:                 .Header1.ForeColor = RGB(90, 90, 90)
914:                 .Header1.Caption   = "Produto"
915:                 .Text1.FontName    = "Tahoma"
916:                 .Text1.BorderStyle = 0

*-- Linhas 962 a 1033:
962:         CATCH TO loc_oErro
963:             MsgErro(loc_oErro.Message + CHR(13) + ;
964:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
965:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridItens")
966:         ENDTRY
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     * CarregarFiltrosDoFormPai - Preenche os 5 campos de exibicao do
971:     * cabecalho (Conta, Conta-Desc, Periodo Inicial/Final, Grupo) a partir
972:     * do form pai (FormSigPrPpc.this_oBusinessObject), e guarda os mesmos
973:     * valores nas propriedades de exibicao deste BO (this_cGrupo/
974:     * this_cConta/this_cContaDesc/this_dDataInicial/this_dDataFinal).
975:     *
976:     * Equivale ao bloco do Init legado:
977:     *     ThisForm.get_grupo.Value        = pcGrupo
978:     *     ThisForm.get_cliente.Value      = pcConta
979:     *     ThisForm.get_cliente_desc.Value = pcContaDesc
980:     *     ThisForm.get_dt_inicial.Value   = pdInicial
981:     *     ThisForm.get_dt_final.Value     = pdFinal
982:     * onde pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal eram PRIVATE vars
983:     * que o chamador (SigPrPpc.cmd_consulta.Click) declarava ANTES do
984:     * "Do Form SigPrPpp" - na arquitetura nova esse canal eh
985:     * THIS.this_oFormPai.this_oBusinessObject (FormSigPrPpc.
986:     * this_oBusinessObject: this_cGrupo/this_cConta/this_cContaDesc/
987:     * this_dInicial/this_dFinal - ver FormSigPrPpc.prg:692-698).
988:     *
989:     * Sem form pai (validacao de UI / modo de teste instanciando este form
990:     * direto) o metodo eh um no-op silencioso: os campos ficam com o
991:     * default vazio que ConfigurarCampoConta/Periodo/Grupo ja deixou.
992:     *--------------------------------------------------------------------------
993:     PROTECTED PROCEDURE CarregarFiltrosDoFormPai()
994:         LOCAL loc_oBOPai, loc_oErro
995: 
996:         TRY
997:             IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
998:                     PEMSTATUS(THIS.this_oFormPai, "this_oBusinessObject", 5)
999:                 loc_oBOPai = THIS.this_oFormPai.this_oBusinessObject
1000: 
1001:                 IF VARTYPE(loc_oBOPai) = "O"
1002:                     IF PEMSTATUS(loc_oBOPai, "this_cGrupo", 5)
1003:                         THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oBOPai.this_cGrupo)
1004:                     ENDIF
1005:                     IF PEMSTATUS(loc_oBOPai, "this_cConta", 5)
1006:                         THIS.this_oBusinessObject.this_cConta = ALLTRIM(loc_oBOPai.this_cConta)
1007:                     ENDIF
1008:                     IF PEMSTATUS(loc_oBOPai, "this_cContaDesc", 5)
1009:                         THIS.this_oBusinessObject.this_cContaDesc = ALLTRIM(loc_oBOPai.this_cContaDesc)
1010:                     ENDIF
1011:                     IF PEMSTATUS(loc_oBOPai, "this_dInicial", 5)
1012:                         THIS.this_oBusinessObject.this_dDataInicial = loc_oBOPai.this_dInicial
1013:                     ENDIF
1014:                     IF PEMSTATUS(loc_oBOPai, "this_dFinal", 5)
1015:                         THIS.this_oBusinessObject.this_dDataFinal = loc_oBOPai.this_dFinal
1016:                     ENDIF
1017:                 ENDIF
1018:             ENDIF
1019: 
1020:             THIS.txt_4c_Grupo.Value         = THIS.this_oBusinessObject.this_cGrupo
1021:             THIS.txt_4c__cliente.Value      = THIS.this_oBusinessObject.this_cConta
1022:             THIS.txt_4c__cliente_desc.Value = THIS.this_oBusinessObject.this_cContaDesc
1023:             THIS.txt_4c__dt_inicial.Value   = THIS.this_oBusinessObject.this_dDataInicial
1024:             THIS.txt_4c__dt_final.Value     = THIS.this_oBusinessObject.this_dDataFinal
1025: 
1026:             *-- Transcrito do Init legado, que depois de atribuir os cinco
1027:             *-- .Value repinta exatamente estes TRES campos:
1028:             *--     ThisForm.get_cliente.Refresh
1029:             *--     ThisForm.get_dt_inicial.Refresh
1030:             *--     ThisForm.get_dt_final.Refresh
1031:             *-- (get_cliente_desc e Get_grupo nao sao repintados no legado -
1032:             *-- manter a lista exatamente como esta la, sem "completar" os
1033:             *-- outros dois: atribuir .Value a controle que o form ainda nao

*-- Linhas 1039 a 1310:
1039:         CATCH TO loc_oErro
1040:             MsgErro(loc_oErro.Message + CHR(13) + ;
1041:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1042:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarFiltrosDoFormPai")
1043:         ENDTRY
1044:     ENDPROC
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * CarregarLista - Carga das duas grades. Equivale ao trecho final do Init
1048:     * legado, que depois de montar os RecordSource/ControlSource faz:
1049:     *
1050:     *     ThisForm.LockScreen   = .t.
1051:     *     ThisForm.MousePointer = 11
1052:     *     Zap In dbOperacao
1053:     *     Zap In dbItens
1054:     *     Select TprMvCab
1055:     *     Scan / Scatter MemVar / Insert Into dbOperacao From MemVar / EndScan
1056:     *     Select dbOperacao
1057:     *     Go Top
1058:     *     ... (carga de dbItens da PRIMEIRA linha)
1059:     *     ThisForm.MousePointer = 0
1060:     *     ThisForm.LockScreen   = .f.
1061:     *
1062:     * O ZAP/APPEND + GO TOP + carga dos itens da linha corrente moram no BO
1063:     * (SIGPRPPPBO.CarregarOperacoes, que encadeia
1064:     * CarregarItensDaOperacaoCorrente); aqui ficam o LockScreen/MousePointer
1065:     * transcritos do legado e o repintar das grades.
1066:     *
1067:     * NAO refaz a consulta em SigMvCab: o resultado vem do cursor que o form
1068:     * PAI deixou pronto (TprMvCab) - refazer o WHERE aqui faria esta grade
1069:     * mostrar um conjunto DIFERENTE do que o usuario pediu, sem erro na tela
1070:     * (ver comentario de CarregarOperacoes no BO).
1071:     *
1072:     * NOME: "Lista" eh o nome canonico do projeto para o metodo que popula a
1073:     * grade de LISTAGEM, e aqui a grade de listagem eh grd_4c_Operacoes (a
1074:     * lista de movimentacoes que o usuario percorre; grd_4c_Itens eh o
1075:     * DETALHE dela, recarregado pelo AfterRowColChange). O metodo nasceu na
1076:     * Fase 7 como CarregarDados e foi renomeado na Fase 8 - nao ha wrapper
1077:     * com o nome antigo: ele seria um atalho vazio, e o unico chamador era
1078:     * InicializarForm, neste mesmo arquivo (o form PAI nao chama metodo de
1079:     * carga do filho - ver FormSigPrPpc.CmdConsultarClick).
1080:     *
1081:     * PUBLICO de proposito: o harness de teste chama metodos de carga direto
1082:     * no objeto do form, de FORA da classe - metodo PROTECTED estouraria
1083:     * "Property CARREGARLISTA is not found" em runtime (regra #3/#51).
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE CarregarLista()
1086:         LOCAL loc_lSucesso, loc_oErro
1087:         loc_lSucesso = .F.
1088: 
1089:         TRY
1090:             THIS.LockScreen   = .T.
1091:             THIS.MousePointer = 11
1092: 
1093:             loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes()
1094: 
1095:             THIS.MousePointer = 0
1096:             THIS.LockScreen   = .F.
1097: 
1098:             *-- Popular o cursor NAO repinta a grade: GO TOP + Refresh em
1099:             *-- CADA caminho que carrega dados (regra #21).
1100:             THIS.RepintarGrades()
1101: 
1102:             IF !loc_lSucesso
1103:                 *-- O BO ja exibiu o proprio erro quando houve excecao
1104:                 *-- (this_lErroExibido); so a recusa por cursor de origem
1105:                 *-- ausente volta calada e precisa ser mostrada aqui.
1106:                 IF !THIS.this_oBusinessObject.this_lErroExibido ;
1107:                         AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1108:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1109:                         "Aten" + CHR(231) + CHR(227) + "o")
1110:                 ENDIF
1111:             ENDIF
1112:         CATCH TO loc_oErro
1113:             THIS.MousePointer = 0
1114:             THIS.LockScreen   = .F.
1115:             MsgErro(loc_oErro.Message + CHR(13) + ;
1116:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1117:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1118:             loc_lSucesso = .F.
1119:         ENDTRY
1120: 
1121:         RETURN loc_lSucesso
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * RepintarGrades - Funil UNICO de repintura das duas grades (legado:
1126:     * "Select dbOperacao / Go Top" no Init e "ThisForm.grd_itens.Refresh" no
1127:     * fim do AfterRowColChange).
1128:     *
1129:     * Encher o cursor nao faz a grade exibir as linhas novas: sem Refresh a
1130:     * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
1131:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao
1132:     * (regra #21). Por isso a repintura fica num metodo so, chamado por CADA
1133:     * caminho que popula os cursores.
1134:     *
1135:     * Este metodo NAO reposiciona os cursores - so repinta. O GO TOP que a
1136:     * regra #21 pede ja eh feito por quem CARREGA, no BO: CarregarOperacoes
1137:     * termina com SELECT + GO TOP no cursor da grade mestre, e
1138:     * CarregarItensPorChave faz o mesmo no cursor de itens. Repetir GO TOP
1139:     * aqui seria inofensivo na carga inicial, mas o AfterRowColChange da
1140:     * Fase 7-8 reusa este funil para repintar a grade de itens DEPOIS que o
1141:     * usuario escolheu uma linha da grade mestre - e ali o GO TOP puxaria a
1142:     * grade mestre de volta para a primeira linha, desfazendo a selecao
1143:     * (o legado, coerente com isso, so faz "grd_itens.Refresh" no fim do
1144:     * AfterRowColChange, sem tocar na posicao de dbOperacao).
1145:     *
1146:     * PUBLICO de proposito: mesmo motivo de CarregarLista - alem do harness,
1147:     * o AfterRowColChange da grade de movimentacoes (Fase 7-8) reusa este
1148:     * funil, e delegate de BINDEVENT precisa ser PUBLIC (regra #3).
1149:     *--------------------------------------------------------------------------
1150:     PROCEDURE RepintarGrades()
1151:         LOCAL loc_cAliasAnterior, loc_cCursorOps, loc_cCursorItens, loc_oErro
1152: 
1153:         TRY
1154:             loc_cAliasAnterior = ALIAS()
1155:             loc_cCursorOps     = ALLTRIM(THIS.this_oBusinessObject.this_cCursorOperacoes)
1156:             loc_cCursorItens   = ALLTRIM(THIS.this_oBusinessObject.this_cCursorItens)
1157: 
1158:             IF USED(loc_cCursorOps) AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
1159:                 THIS.grd_4c_Operacoes.Refresh()
1160:             ENDIF
1161: 
1162:             IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
1163:                 THIS.grd_4c_Itens.Refresh()
1164:             ENDIF
1165: 
1166:             *-- A grade MESTRE manda na area de trabalho corrente: o
1167:             *-- AfterRowColChange (Fase 7-8) le a linha selecionada dela.
1168:             IF USED(loc_cCursorOps)
1169:                 SELECT (loc_cCursorOps)
1170:             ELSE
1171:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1172:                     SELECT (loc_cAliasAnterior)
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message + CHR(13) + ;
1177:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1178:                 "Procedure: " + loc_oErro.Procedure, "Erro em RepintarGrades")
1179:         ENDTRY
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * GradeOperacoesAfterRowColChange - Delegate de BINDEVENT para o
1184:     * AfterRowColChange de grd_4c_Operacoes (ligado em
1185:     * ConfigurarGridOperacoes). Equivale ao PROCEDURE AfterRowColChange do
1186:     * dump legado:
1187:     *     Lparameters nColIndex
1188:     *     If (ThisForm.LinhaAnterior <> ThisForm.grd_operacoes.activerow)
1189:     *         ThisForm.LinhaAnterior = ThisForm.grd_operacoes.activerow
1190:     *         ThisForm.LockScreen   = .t.
1191:     *         ThisForm.MousePointer = 11
1192:     *         Zap In dbItens
1193:     *         Select crLclMvItn / Seek .../ Scan While ... / Insert Into dbItens
1194:     *         ThisForm.grd_itens.Refresh
1195:     *         ThisForm.MousePointer = 0
1196:     *         ThisForm.LockScreen   = .f.
1197:     *     EndIf
1198:     *
1199:     * O guard por LINHA (nao por nColIndex, regra #46 - delegate recebe o
1200:     * parametro do evento, mas AfterRowColChange e disparo por COLUNA
1201:     * dentro da MESMA linha nao justifica refazer a consulta de itens) eh
1202:     * exatamente o que o legado faz, comparando ActiveRow com a ultima
1203:     * linha carregada (THIS.this_nLinhaAnterior). O carrego da PRIMEIRA
1204:     * linha ja aconteceu no CarregarOperacoes do BO (chamado por
1205:     * THIS.CarregarLista em InicializarForm) - este handler so entra em
1206:     * acao quando o usuario muda de linha depois disso.
1207:     *
1208:     * SIGPRPPPBO.CarregarItensDaOperacaoCorrente encapsula o
1209:     * CarregarDoCursor(cursor_4c_Operacoes) + CarregarItensPorChave(...)
1210:     * que correspondem ao Seek/Scan do legado; THIS.RepintarGrades() faz o
1211:     * "ThisForm.grd_itens.Refresh" final (regra #21/#46 - popular o cursor
1212:     * nao repinta a grade sozinho).
1213:     *
1214:     * PUBLICO de proposito: delegate de BINDEVENT tem de ser PUBLIC, senao
1215:     * o BIND falha silenciosamente (regra #3).
1216:     *--------------------------------------------------------------------------
1217:     PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
1218:         LOCAL loc_oErro
1219: 
1220:         TRY
1221:             IF THIS.this_nLinhaAnterior != THIS.grd_4c_Operacoes.ActiveRow
1222:                 THIS.this_nLinhaAnterior = THIS.grd_4c_Operacoes.ActiveRow
1223: 
1224:                 THIS.LockScreen   = .T.
1225:                 THIS.MousePointer = 11
1226: 
1227:                 THIS.this_oBusinessObject.CarregarItensDaOperacaoCorrente()
1228: 
1229:                 THIS.MousePointer = 0
1230:                 THIS.LockScreen   = .F.
1231: 
1232:                 THIS.RepintarGrades()
1233:             ENDIF
1234:         CATCH TO loc_oErro
1235:             THIS.MousePointer = 0
1236:             THIS.LockScreen   = .F.
1237:             MsgErro(loc_oErro.Message + CHR(13) + ;
1238:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1239:                 "Procedure: " + loc_oErro.Procedure, "Erro em GradeOperacoesAfterRowColChange")
1240:         ENDTRY
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     * CmdEncerrarClick - Delegate de BINDEVENT para o Click do botao
1245:     * "Encerrar" (cmg_4c_Grp_operacao.Buttons(1), ligado em
1246:     * ConfigurarGrupoOperacao). Equivale ao dump legado:
1247:     *     PROCEDURE cmd_sair.Click
1248:     *     ThisForm.ParentForm.Enabled = .t.
1249:     *     ThisForm.ParentForm.get_cliente.Setfocus
1250:     *     ThisForm.Release
1251:     *
1252:     * get_cliente (Conta, campo de exibicao) corresponde a
1253:     * FormSigPrPpc.txt_4c_Conta (comentario "legado: get_cliente" em
1254:     * FormSigPrPpc.prg:558). Reabilitar o form pai aqui E no Destroy eh
1255:     * idempotente de proposito - o pai (FormSigPrPpc.CmdConsultarClick)
1256:     * tambem reabilita a si mesmo de forma incondicional assim que
1257:     * loc_oResultado.Show() retorna, entao nenhum dos dois caminhos pode
1258:     * falhar em restaurar o form pai.
1259:     *
1260:     * PUBLICO de proposito: mesmo motivo de
1261:     * GradeOperacoesAfterRowColChange (regra #3).
1262:     *--------------------------------------------------------------------------
1263:     PROCEDURE CmdEncerrarClick()
1264:         LOCAL loc_oErro
1265: 
1266:         TRY
1267:             IF VARTYPE(THIS.this_oFormPai) = "O"
1268:                 IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1269:                     THIS.this_oFormPai.Enabled = .T.
1270:                 ENDIF
1271:                 IF PEMSTATUS(THIS.this_oFormPai, "txt_4c_Conta", 5)
1272:                     IF THIS.this_oFormPai.txt_4c_Conta.Enabled
1273:                         THIS.this_oFormPai.txt_4c_Conta.SetFocus()
1274:                     ENDIF
1275:                 ENDIF
1276:             ENDIF
1277:         CATCH TO loc_oErro
1278:             MsgErro(loc_oErro.Message + CHR(13) + ;
1279:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1280:                 "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
1281:         ENDTRY
1282: 
1283:         THIS.Release()
1284:     ENDPROC
1285: 
1286:     *--------------------------------------------------------------------------
1287:     * Destroy - Reabilita o form pai (desabilitado por
1288:     * FormSigPrPpc.CmdConsultarClick antes de abrir este form filho) e
1289:     * encadeia para FormBase.Destroy() (libera this_oBusinessObject e
1290:     * restaura o menu principal). DODEFAULT() sempre por ultimo (regra do
1291:     * menu que encolhe - CLAUDE.md #29/#145).
1292:     *--------------------------------------------------------------------------
1293:     PROCEDURE Destroy()
1294:         LOCAL loc_oErro
1295: 
1296:         TRY
1297:             IF VARTYPE(THIS.this_oFormPai) = "O"
1298:                 IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1299:                     THIS.this_oFormPai.Enabled = .T.
1300:                 ENDIF
1301:             ENDIF
1302:             THIS.this_oFormPai = .NULL.
1303:         CATCH TO loc_oErro
1304:             MsgErro("Erro ao encerrar FormSigPrPpp: " + loc_oErro.Message, "Erro")
1305:         ENDTRY
1306: 
1307:         DODEFAULT()
1308:     ENDPROC
1309: 
1310: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*====================================================================
* SIGPRPPPBO.prg
*
* Business Object do SIGPRPPP - "Pesquisa de Produtos por Conta".
*
* Formulario OPERACIONAL de CONSULTA (drill-down), aberto como tela
* FILHA pelo FormSigPrPpc: o pai ja validou Grupo/Conta/Periodo,
* executou a consulta em SigMvCab e deixou o resultado no cursor
* TprMvCab (SigPrPpcBO.ConsultarMovimentacoes preserva esse nome
* EXATAMENTE para esta tela consumir). Aqui a grade de cima lista
* essas movimentacoes e a grade de baixo mostra os itens (SigMvItn)
* da movimentacao selecionada, com a descricao do produto lida AO
* VIVO do cadastro (SigCdPro).
*
* Sobre a ausencia de CRUD neste BO
* ---------------------------------
* O dump legado (tasks\task666\SIGPRPPP_form_codigo_fonte.txt) nao
* tem gravacao de dado de negocio. O unico acesso de escrita remota
* do legado eh ANDAIME de consulta: ele monta a lista de chaves
* Emps+Dopes+Numes na tabela de rascunho SigTempC (Insert Into
* crSigTempC + poDataTmp.Update + Commit), usa essa lista como lado
* esquerdo de um JOIN contra SigMvItn e, logo em seguida, APAGA as
* proprias linhas com fSqlApagarTmp. Era a forma de o Fortyus mandar
* uma lista de chaves ao servidor a partir de um cursor local.
*
* Na arquitetura nova a conexao eh direta ao SQL Server, entao o
* JOIN eh feito na propria consulta dos itens e a SigTempC deixa de
* ser necessaria - nao ha o que gravar. Por isso este BO NAO
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
* comportamento herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja eh o correto, e escrever
* um INSERT/UPDATE aqui significaria inventar tabela e colunas, o
* que o PILAR 2 proibe. Pela mesma razao RegistrarAuditoria() nunca
* eh acionado nesta tela: auditoria registra gravacao, e gravacao
* nao existe aqui.
*
* Metodos publicos usados pelo formulario:
*   CarregarOperacoes()               - popula a grade de movimentacoes
*   CarregarDoCursor(par_cAlias)      - le a linha corrente p/ as props
*   CarregarItensDaOperacaoCorrente() - AfterRowColChange da grade
*   CarregarItensPorChave(E, D, N)    - itens de uma movimentacao
*   MontarChaveEmpDopNums(E, D, N)    - chave posicional char(29)
*====================================================================

DEFINE CLASS SIGPRPPPBO AS BusinessBase

	*-- Filtros recebidos do formulario chamador (equivalentes as
	*   PRIVATE pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal que o
	*   legado le no Init). Aqui servem so para exibicao nos campos
	*   somente-leitura do cabecalho - quem filtrou foi o pai.
	this_cGrupo = ""
	this_cConta = ""
	this_cContaDesc = ""
	this_dDataInicial = {}
	this_dDataFinal = {}

	*-- Cursor de ORIGEM das movimentacoes, populado pelo form pai
	*   (SigPrPpcBO.ConsultarMovimentacoes). Equivale ao TprMvCab que
	*   o legado recebia pronto na mesma DataSession.
	this_cCursorOrigem = "TprMvCab"

	*-- Cursores das duas grades (equivalem a dbOperacao e dbItens do
	*   DataEnvironment legado)
	this_cCursorOperacoes = "cursor_4c_Operacoes"
	this_cCursorItens = "cursor_4c_Itens"

	*-- Linha CORRENTE da grade de movimentacoes. Os nomes espelham as
	*   colunas de SigMvCab (emps, dopes, numes, datas, valos) para nao
	*   haver divergencia de nome entre BO e Form.
	this_cEmps = ""
	this_cDopes = ""
	this_nNumes = 0
	this_dDatas = {}
	this_nValos = 0

	*====================================================================
	* Init - Inicializa o Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Tabela de leitura da tela. A chave de negocio eh COMPOSTA
		*   (Emps + Dopes + Numes) e existe materializada em SigMvCab e
		*   SigMvItn como empdopnums char(29) - ver MontarChaveEmpDopNums.
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "empdopnums"

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cCursorOrigem = "TprMvCab"
		THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
		THIS.this_cCursorItens = "cursor_4c_Itens"

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* GarantirCursorOperacoes - Cria o cursor da grade de movimentacoes
	* se ele ainda nao existir.
	*
	* A estrutura eh declarada em UM UNICO lugar (usado tanto na carga
	* quanto na limpeza) porque cursor de grade criado com ordem de
	* campos diferente em pontos diferentes quebra o APPEND FROM, que
	* casa os campos por NOME. Tipos copiados do schema:
	*   SigMvCab.emps  char(3)  / dopes char(20) / numes numeric(6,0)
	*   SigMvCab.datas datetime / valos numeric(11,2)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridOperacoes() (Fase 4), antes de CarregarOperacoes()
	* existir (Fase 7-8), para o cursor ja estar criado quando o Grid
	* recebe RecordSource/ControlSource - regra #41 (ControlSource de
	* cursor ainda inexistente derruba o Init).
	*====================================================================
	PROCEDURE GarantirCursorOperacoes()
		IF !USED(THIS.this_cCursorOperacoes)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorOperacoes) ( ;
				emps C(3) NULL, ;
				dopes C(20) NULL, ;
				numes N(6,0) NULL, ;
				datas T NULL, ;
				valos N(11,2) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* GarantirCursorItens - Cria o cursor da grade de itens se ele ainda
	* nao existir. Tipos copiados do schema:
	*   SigMvItn.cpros char(14) / qtds numeric(9,3)
	*   SigCdPro.dpros char(65)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridItens() (Fase 4) - mesmo motivo de GarantirCursorOperacoes.
	*====================================================================
	PROCEDURE GarantirCursorItens()
		IF !USED(THIS.this_cCursorItens)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorItens) ( ;
				cpros C(14) NULL, ;
				dpros C(65) NULL, ;
				qtds N(9,3) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarOperacoes - Popula a grade de movimentacoes a partir do
	* cursor que o form PAI deixou pronto (this_cCursorOrigem).
	*
	* Equivale a este trecho do Init legado:
	*     Zap In dbOperacao
	*     Select TprMvCab
	*     Scan
	*         Scatter MemVar
	*         Insert Into dbOperacao From MemVar
	*     EndScan
	*     Select dbOperacao
	*     Go Top
	* ... seguido da carga dos itens da PRIMEIRA linha (o legado popula
	* dbItens logo apos o Go Top; o AfterRowColChange so entra em acao
	* quando o usuario muda de linha).
	*
	* NAO re-executa a consulta em SigMvCab: o WHERE do legado vive no
	* form PAI (SigPrPpcBO.ConsultarMovimentacoes - periodo mais os
	* pares GrupoOs/GrupoDs e ContaOs/ContaDs com OR nos DOIS lados,
	* mais Dopes e Emps opcionais). Refazer a consulta aqui com um
	* filtro adivinhado faria esta grade mostrar um conjunto DIFERENTE
	* do que o usuario pediu, sem erro nenhum na tela.
	*
	* O cursor da grade nunca eh fechado nem recriado: ZAP + APPEND
	* FROM preserva estrutura, RecordSource e ControlSource das colunas.
	*====================================================================
	FUNCTION CarregarOperacoes()
		LOCAL loc_lSucesso, loc_cOrigem, loc_oErro

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido = .F.
		loc_lSucesso = .F.
		loc_cOrigem = ALLTRIM(THIS.this_cCursorOrigem)

		TRY
			THIS.GarantirCursorOperacoes()
			THIS.GarantirCursorItens()

			IF !USED(loc_cOrigem)
				THIS.this_cMensagemErro = "O resultado da consulta (" + loc_cOrigem + ;
					") n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
					"vel. Refa" + CHR(231) + "a a pesquisa na tela anterior."
			ELSE
				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				*-- So as colunas que a grade exibe; o legado copiava o
				*   registro inteiro porque dbOperacao era um DBF com a
				*   mesma estrutura de SigMvCab.
				SELECT emps, dopes, numes, datas, valos ;
					FROM (loc_cOrigem) ;
					ORDER BY emps, dopes, numes ;
					INTO CURSOR cursor_4c_OperacoesTmp READWRITE

				SELECT (THIS.this_cCursorOperacoes)
				ZAP
				APPEND FROM DBF("cursor_4c_OperacoesTmp")

				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				SELECT (THIS.this_cCursorOperacoes)
				GO TOP

				IF EOF()
					*-- Universo vazio nao eh erro: so deixa a grade de
					*   itens vazia e coerente com a de movimentacoes.
					SELECT (THIS.this_cCursorItens)
					ZAP

					THIS.this_cEmps = ""
					THIS.this_cDopes = ""
					THIS.this_nNumes = 0
					THIS.this_dDatas = {}
					THIS.this_nValos = 0

					loc_lSucesso = .T.
				ELSE
					*-- O resultado da carga dos itens EH o resultado desta
					*   carga: se a consulta dos itens falhar, a tela fica
					*   com a grade de baixo vazia sem motivo aparente, e
					*   devolver .T. aqui esconderia a falha do chamador
					*   (que leria this_cMensagemErro ja preenchido).
					loc_lSucesso = THIS.CarregarItensDaOperacaoCorrente()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarOperacoes")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Le a linha CORRENTE do cursor informado para as
	* propriedades da movimentacao selecionada.
	*
	* Padrao canonico: SELECT (par_cAliasCursor) ANTES de acessar os
	* campos, acesso aos campos SEM prefixo de alias, e cada campo
	* protegido por TYPE() porque o mesmo metodo atende tanto o cursor
	* da grade (5 colunas) quanto o cursor de origem TprMvCab, que eh um
	* SELECT * de SigMvCab com 158 colunas.
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe, e
	* metodo PROTECTED chamado de fora estoura "Property ... is not
	* found" em runtime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), ;
			ALLTRIM(THIS.this_cCursorOperacoes))

		TRY
			IF USED(loc_cAlias)
				SELECT (loc_cAlias)

				IF !EOF() AND !BOF()
					IF TYPE(loc_cAlias + ".emps") != "U"
						THIS.this_cEmps = TratarNulo(emps, "")
					ENDIF
					IF TYPE(loc_cAlias + ".dopes") != "U"
						THIS.this_cDopes = TratarNulo(dopes, "")
					ENDIF
					IF TYPE(loc_cAlias + ".numes") != "U"
						THIS.this_nNumes = TratarNulo(numes, 0)
					ENDIF
					IF TYPE(loc_cAlias + ".datas") != "U"
						THIS.this_dDatas = TratarNulo(datas, {})
					ENDIF
					IF TYPE(loc_cAlias + ".valos") != "U"
						THIS.this_nValos = TratarNulo(valos, 0)
					ENDIF

					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + ;
						"o selecionada."
				ENDIF
			ELSE
				THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItensDaOperacaoCorrente - Le a linha corrente da grade de
	* movimentacoes e recarrega a grade de itens com os produtos daquela
	* movimentacao.
	*
	* Equivale ao grd_operacoes.AfterRowColChange do legado (Zap In
	* dbItens, Seek na chave da linha corrente de dbOperacao e Scan
	* While a chave bater). Publico porque quem dispara eh o handler do
	* proprio Grid, no Form.
	*====================================================================
	FUNCTION CarregarItensDaOperacaoCorrente()
		LOCAL loc_lSucesso

		loc_lSucesso = .F.

		IF THIS.CarregarDoCursor(THIS.this_cCursorOperacoes)
			loc_lSucesso = THIS.CarregarItensPorChave(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarItensPorChave - Popula a grade de itens com os produtos
	* (SigMvItn) da movimentacao Emps + Dopes + Numes informada.
	*
	* A descricao do produto vem SEMPRE do cadastro atual (SigCdPro),
	* nunca da descricao historica gravada no item. Eh exatamente o que
	* o legado faz:
	*     poDataMgr.CursorQuery("SigCdPro", "crSigCdPro", "CPros", ...)
	*     m.DPros = Iif(Eof("crSigCdPro"), "", crSigCdPro.DPros)
	* ou seja, produto que saiu do cadastro aparece com a descricao EM
	* BRANCO. O LEFT JOIN com ISNULL(b.dpros, "") reproduz os dois casos
	* (ISNULL aqui eh a funcao do SQL Server, dentro da string SQL).
	*
	* As tres colunas sao comparadas SEPARADAMENTE, e nao pela chave
	* concatenada empdopnums char(29) que o legado usava: char no SQL
	* Server compara com preenchimento de brancos, entao a igualdade por
	* coluna eh equivalente e dispensa reproduzir o alinhamento
	* posicional 3 + 20 + 6 - onde um ALLTRIM a mais devolveria zero
	* linha em silencio.
	*====================================================================
	FUNCTION CarregarItensPorChave(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_lProsseguir = .T.

		IF VARTYPE(par_cEmps) != "C" OR VARTYPE(par_cDopes) != "C" OR ;
		   VARTYPE(par_nNumes) != "N"
			THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
				"o inv" + CHR(225) + "lida."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir AND (TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir
			TRY
				THIS.GarantirCursorItens()

				loc_cSQL = "SELECT a.cpros, ISNULL(b.dpros, '') AS dpros, a.qtds" + ;
					" FROM SigMvItn a" + ;
					" LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
					" WHERE a.emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
					" AND a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
					" AND a.numes = " + FormatarNumeroSQL(par_nNumes, 0) + ;
					" ORDER BY a.cpros"

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF

				*-- SQLEXEC sempre em cursor TEMPORARIO: executado sobre o
				*   alias da grade, ele fecharia e recriaria esse alias,
				*   zerando ColumnCount/RecordSource e deixando a grade
				*   como um retangulo branco pelo resto da vida do form.
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao buscar os itens da movimenta" + ;
						CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ELSE
					SELECT (THIS.this_cCursorItens)
					ZAP
					APPEND FROM DBF("cursor_4c_ItensTmp")

					SELECT (THIS.this_cCursorItens)
					GO TOP

					loc_lSucesso = .T.
				ENDIF

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF
			CATCH TO loc_oErro
				THIS.this_cMensagemErro = loc_oErro.Message
				MsgErro(loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro em CarregarItensPorChave")
				THIS.this_lErroExibido = .T.
				loc_lSucesso = .F.
			ENDTRY
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres que o
	* sistema materializa na coluna empdopnums char(29) de SigMvCab e
	* SigMvItn, e que o legado monta como
	*     TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes, 6)
	*
	* O preenchimento FAZ PARTE da chave: emps char(3) + dopes char(20)
	* + Str(numes, 6) = 29. Usar ALLTRIM nas partes encurtaria a chave e
	* ela nunca casaria - a consulta rodaria sem erro e devolveria zero
	* linha. Por isso o PADR explicito, com as larguras do schema.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes

		loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
		loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Chave da movimentacao selecionada, no mesmo
	* formato da coluna empdopnums char(29).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, ;
			THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* LimparDados - Zera filtros, linha selecionada e as duas grades. As
	* grades sao esvaziadas com ZAP (nunca fechadas), para o Grid nao
	* perder RecordSource nem ControlSource.
	*====================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		THIS.GarantirCursorOperacoes()
		SELECT (THIS.this_cCursorOperacoes)
		ZAP

		THIS.GarantirCursorItens()
		SELECT (THIS.this_cCursorItens)
		ZAP

		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - Fecha os cursores criados por ESTE BO. O cursor de
	* origem (TprMvCab) pertence ao form pai e eh fechado por ele.
	*====================================================================
	PROCEDURE Destroy()
		IF USED("cursor_4c_OperacoesTmp")
			USE IN cursor_4c_OperacoesTmp
		ENDIF
		IF USED("cursor_4c_ItensTmp")
			USE IN cursor_4c_ItensTmp
		ENDIF
		IF USED(THIS.this_cCursorItens)
			USE IN (THIS.this_cCursorItens)
		ENDIF
		IF USED(THIS.this_cCursorOperacoes)
			USE IN (THIS.this_cCursorOperacoes)
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

