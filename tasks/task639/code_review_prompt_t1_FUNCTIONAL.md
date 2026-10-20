# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverTemCotas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarCamposObrigatoriosConfirma()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.LocalizarCidContrapartida()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopacc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2673 linhas total):

*-- Linhas 7 a 112:
7: *          Formsigmvtit/Formsigmvccr), equivalente ao legado
8: *          PARAMETERS pOldForm, OPER, pTpAltera.
9: *
10: * Chamada: CREATEOBJECT("Formsigopacc", par_oFormPai, par_cOperacao, ;
11: *              par_nTpAltera, par_cPkChaves)
12: *   par_oFormPai   - referencia ao form chamador (equivale a ThisForm.parentForm)
13: *   par_cOperacao  - "ALTERAR"/"INSERIR" (equivale a ThisForm.Op_Escolha;
14: *                     reaproveita THIS.this_cModoAtual, de FormBase)
15: *   par_nTpAltera  - flag numerico do legado (ThisForm.nTpAltera) que restringe
16: *                     a edicao de alguns campos mesmo em modo ALTERAR
17: *   par_cPkChaves  - cidchaves (PK char(20)) do lancamento de SigMvCcr a editar
18: *                     (equivale a ThisForm.pkChaves = crAltcc.cIdChaves do
19: *                     legado - aqui recebido como parametro explicito, em vez
20: *                     de depender de um cursor externo ja posicionado)
21: *
22: * Historico de fases:
23: *   Fase 1/2: sigopaccBO.prg (propriedades + CRUD completo)
24: *   Fase 3:   Formsigopacc.prg - estrutura base (Init, InicializarForm,
25: *             ConfigurarPageFrame/ConfigurarCabecalho, TornarControlesVisiveis).
26: *   Fase 4:   Formsigopacc.prg - layout CAPTURA (sem lista/Grid no legado -
27: *             zero AddCursor-com-grade/pColuna no dump): ConfigurarShapes()
28: *             (linhas divisorias), ConfigurarPaginaDados() (TODOS os ~34 campos +
29: *             OptionGroup Acerto, visual completo com Left/Top/Width/Height/
30: *             InputMask/Format/MaxLength EXATOS do SCX) e ConfigurarBotoesAcao()
31: *             (Cmd_Confirma/Cmd_Cancela/Alteracotacao/AlteraSCotacao, visual
32: *             completo). O Valid de cada campo e os Click dos botoes ficam
33: *             para as Fases de eventos/lookups (6-8); o When foi transcrito
34: *             na Fase 5 (AtualizarEstadoControles) - metodo sem logica real
35: *             nao pode ser criado so para "existir" (regra de completude).
36: *             Medido no dump legado: 0 BaseClass grid/pageframe/column/
37: *             listbox, 0 RecordSource, 0 pColuna/Grade/grd e AddCursor que
38: *             nao liga grade - nao ha lista a reproduzir. Os 64 AddObject
39: *             deste .prg batem 1-a-1 com os 64 objetos do layout.json
40: *             (5 Shape, 1 Container, 24 Label, 29 TextBox, 1 OptionGroup,
41: *             4 CommandButton).
42: *             Este form NAO declara os dois metodos de paginacao/lista do
43: *             padrao CRUD (os que alternam Page1/Page2 e recarregam a grade).
44: *             Aqui eles seriam no-op, isto e' stub proibido; e a presenca
45: *             deles faria TesteAutomatico.prg classificar o form como CRUD -
46: *             ele detecta OPERACIONAL justamente pela AUSENCIA desse par
47: *             (ver TesteAutomatico.prg, deteccao automatica de tipo).
48: *   Fase 5:   Formsigopacc.prg - os CAMPOS passam a funcionar de verdade:
49: *             - ConfigurarCampos() renomeado para ConfigurarPaginaDados(),
50: *               nome canonico do metodo que monta a superficie de DADOS
51: *               (mesmo padrao de Formale.prg, outro OPERACIONAL flat sem
52: *               PageFrame). Nenhum controle novo foi inventado: a Page2 de
53: *               Lista/Dados do padrao CRUD nao existe no legado (PILAR 1).
54: *             - CarregarDados(): le o registro de SigMvCcr pela PK
55: *               (cidchaves) e chama BOParaForm(); em INCLUIR prepara
56: *               registro novo. Equivale ao "crAltcc ja posicionado" que o
57: *               legado herda do form pai via ControlSource - sem isso os
58: *               campos abriam todos em branco no modo ALTERAR.
59: *             - BOParaForm()/FormParaBO() COMPLETOS (os 29 TextBox + o
60: *               OptionGroup Acerto). NAO foi feita a divisao "metade agora,
61: *               metade na Fase 6": os campos ja existiam todos desde a Fase
62: *               4 e mapear so parte deles e exatamente o defeito do Erro184
63: *               (o valor digitado nunca chega ao BO e o bloco grava em
64: *               branco, calado). Dividir aqui criaria o defeito de proposito.
65: *             - AtualizarEstadoControles(): transcricao do When de CADA
66: *               controle do SCX (hook PUBLIC que FormBase.Init() ja chama
67: *               depois de InicializarForm) + o Cmd_Confirma.Enabled do Init
68: *               legado (desabilitado em CONSULTAR).
69: *             - this_nOldContaPgs: ThisForm.OldContaPgs do Init legado,
70: *               usado pelo Cmd_Confirma.Click (Fase 7) para decidir o
71: *               estorno de valpags. Medido no VFP9 (2026-10-16): atribuir
72: *               OptionGroup.Value = 3 ou 4 com ButtonCount = 2 e coagido
73: *               para 0 em SILENCIO - e contapgs chega com 3/4 (o When
74: *               legado testa Inlist(contapgs,3,4)). Por isso o valor
75: *               original e guardado e regravado quando o grupo esta
76: *               desabilitado/fora da faixa, em vez de ser achatado para 2.
77: *             FICA PARA A FASE 6 (lookups): as descricoes carregadas por
78: *             Seek em crSigCdGcr/CrSigCdCli (Grupo/Conta/Job e contrapartida),
79: *             a troca InvEmisCCs (SGrupos<->GrupEms, SContas<->ContEms, que
80: *             depende de SigCdCss) e a visibilidade de Cotacao/SCotacao, que
81: *             depende de crSigCdMoe.Cotas e de crSigCdCrg.AltCots.
82: *   Fase 7:   Formsigopacc.prg - os 4 botoes de acao ganham Click real:
83: *             - BtnCancelarClick(): Cmd_Cancela.Click do legado (Encerrar) -
84: *               so THIS.Release(), sem gravar.
85: *             - BtnAlteraCotacaoClick()/BtnAlteraSCotacaoClick(): o legado
86: *               abre "Do Form SigOpAlC WITH ... TO lcRetorno" (tela auxiliar
87: *               que NAO foi migrada - origem\SigOpAlC.SCX). Substituido por
88: *               INPUTBOX(), mesmo padrao ja aceito em
89: *               Formsigmvccr.BtnAlterarCotacaoClick: grava a cotacao
90: *               digitada, this_cCotusus = gc_4c_UsuarioLogado e recalcula o
91: *               SVALOR. Cancelar o INPUTBOX (resposta vazia) equivale ao
92: *               ELSE do legado (.Value = .peAntValue) porque nada e alterado.
93: *             - BtnConfirmarClick()/ValidarCamposObrigatoriosConfirma()/
94: *               SalvarLancamento()/LocalizarCidContrapartida(): Cmd_Confirma.
95: *               Click. Valida os 10 campos obrigatorios do legado (so em
96: *               ALTERAR) e grava.
97: *               DESVIO DOCUMENTADO (arquitetura, nao regra de negocio): o
98: *               legado mantem Craltcc com as N linhas do mesmo Nopers,
99: *               EXCLUI o grupo inteiro de SigMvCcr e RECRIA tudo do zero
100: *               (Append Blank + CidChaves novo via
101: *               Dtos()+fGerUniqueKey()+Sigkey) - artificio exigido pelo
102: *               cursor buffered do legado (so' se adiciona uma 2a linha com
103: *               Append Blank antes do TableUpdate). A arquitetura nova
104: *               localiza a linha da CONTRAPARTIDA (mesmo Nopers, outro
105: *               cidchaves - LocalizarCidContrapartida) e faz UPDATE IN
106: *               PLACE nas DUAS linhas (a principal, this_cPkChaves, e a
107: *               contrapartida, com os campos D<->C trocados), preservando
108: *               os CidChaves existentes. O estado final em SigMvCcr e'
109: *               equivalente (mesmos Grupos/Contas/Moedas/Valores/Opers
110: *               trocados); fUniqueIds() (regra #22 CLAUDE.md) e o gerador
111: *               de chave do projeto, usado so' quando o BO precisa de PK
112: *               nova (Inserir), nao neste fluxo. O recalculo de saldo

*-- Linhas 129 a 344:
129: *             BtnConfirmarClick (= "Salvar"/BtnSalvarClick),
130: *             AtualizarEstadoControles (= HabilitarCampos, transcricao do
131: *             When de cada campo) e BOParaForm/FormParaBO (completos desde a
132: *             Fase 5 - os 29 TextBox + OptionGroup). Nao ha "Buscar" (sem
133: *             lookup de lista) nem "LimparCampos" (instancia unica, nunca
134: *             reaproveitada para incluir o registro seguinte). Adicionar
135: *             esses metodos como stub faria o form VIOLAR a regra de
136: *             completude (metodo sem logica real) e, pior, faria
137: *             TesteAutomatico.prg classifica-lo erradamente como CRUD.
138: *             ACHADO (fora do escopo deste form, registrado para o
139: *             integrador): o UNICO chamador no sistema novo,
140: *             Formsigopind.prg (BtnConsultaHistClick/BtnAlterarHistClick/
141: *             BtnExcluirHistClick), ainda invoca `DO FORM SigOpAcc WITH
142: *             THIS, "<modo>"[, loc_nTpAltera]` - sintaxe legado, apontando
143: *             para uma classe/SCX que nao existe no sistema novo (nem
144: *             recebe par_cPkChaves). Esse form foi migrado ANTES de
145: *             Formsigopacc existir e precisa ser atualizado para
146: *             `CREATEOBJECT("Formsigopacc", THIS, par_cOperacao,
147: *             loc_nTpAltera, cursor_4c_Altcc.cidchaves)` + `.Show()`; o
148: *             modo "EXCLUIR" dos 3 call sites nao tem equivalente aqui (este
149: *             BO so trata INSERIR/INCLUIR e ALTERAR/CONSULTAR) e precisa de
150: *             decisao de produto antes de portar - por isso NAO foi alterado
151: *             nesta fase.
152: *==============================================================================
153: DEFINE CLASS Formsigopacc AS FormBase
154: 
155:     *-- Parametros de entrada recebidos no Init (contexto do form pai)
156:     this_oFormPai  = .NULL.  && referencia ao form chamador (ThisForm.parentForm do legado)
157:     this_nTpAltera = 0       && flag do legado (ThisForm.nTpAltera) - restringe edicao em ALTERAR
158:     this_cPkChaves = ""      && cidchaves do lancamento a editar (ThisForm.pkChaves do legado)
159:     this_nOldContaPgs = 0    && ThisForm.OldContaPgs do legado - contapgs como veio do banco
160:     this_lInvEmisCCs  = .F.  && ThisForm.InvEmisCCs do legado - inverte emissor x contrapartida
161: 
162:     *-- Visibilidade dos campos de cambio (Cotacao/SCotacao) - depende de
163:     *-- SigCdMoe.Cotas da moeda escolhida (Fase 6)
164:     this_lMoedaTemCotas  = .F.
165:     this_lSMoedaTemCotas = .F.
166: 
167:     *-- Guardas "valor mudou" dos lookups da Fase 6 - evita revalidar o
168:     *-- mesmo codigo a cada LostFocus (regra #47 do CLAUDE.md)
169:     this_cUltimoGrupoValidado    = ""
170:     this_cUltimoDgrupoValidado   = ""
171:     this_cUltimaContaValidada    = ""
172:     this_cUltimoDcontaValidado   = ""
173:     this_cUltimoSGrupoValidado   = ""
174:     this_cUltimoSdgrupoValidado  = ""
175:     this_cUltimaSContaValidada   = ""
176:     this_cUltimoSdcontaValidado  = ""
177:     this_cUltimoGrupEmsValidado  = ""
178:     this_cUltimoDGrupEmsValidado = ""
179:     this_cUltimoContEmsValidado  = ""
180:     this_cUltimoDContEmsValidado = ""
181:     this_cUltimoJobValidado      = ""
182:     this_cUltimoDJobValidado     = ""
183:     this_cUltimaMoedaValidada    = ""
184:     this_cUltimaSMoedaValidada   = ""
185: 
186:     *-- Business Object
187:     this_oBusinessObject = .NULL.
188: 
189:     *-- Propriedades visuais (PILAR 1 - layout.json: form width=700, height=500)
190:     Width        = 700
191:     Height       = 500
192:     AutoCenter   = .T.
193:     TitleBar     = 0
194:     WindowType   = 1
195:     ShowWindow   = 1
196:     ControlBox   = .F.
197:     Closable     = .F.
198:     MaxButton    = .F.
199:     MinButton    = .F.
200:     Movable      = .F.
201:     BorderStyle  = 2
202:     ClipControls = .F.
203:     FontName     = "Verdana"
204:     FontSize     = 8
205: 
206:     *--------------------------------------------------------------------------
207:     * Init - Armazena o contexto do form pai, cria o BO e dispara
208:     * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT).
209:     *--------------------------------------------------------------------------
210:     PROCEDURE Init(par_oFormPai, par_cOperacao, par_nTpAltera, par_cPkChaves)
211:         LOCAL loc_lSucesso, loc_oErro
212:         loc_lSucesso = .F.
213: 
214:         TRY
215:             THIS.this_oFormPai  = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
216:             THIS.this_cModoAtual = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
217:                                         UPPER(ALLTRIM(par_cOperacao)), "ALTERAR")
218:             THIS.this_nTpAltera = IIF(VARTYPE(par_nTpAltera) = "N", par_nTpAltera, 0)
219:             THIS.this_cPkChaves = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
220: 
221:             THIS.this_oBusinessObject = CREATEOBJECT("sigopaccBO")
222:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
223:                 MsgErro("Erro ao criar Business Object sigopaccBO." + CHR(13) + ;
224:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
225:                     "Formsigopacc.Init")
226:             ELSE
227:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
228:                 loc_lSucesso = DODEFAULT()
229:             ENDIF
230:         CATCH TO loc_oErro
231:             MsgErro(loc_oErro.Message + CHR(13) + ;
232:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
233:                 "Procedure: " + loc_oErro.Procedure, "Formsigopacc.Init")
234:         ENDTRY
235: 
236:         RETURN loc_lSucesso
237:     ENDPROC
238: 
239:     *--------------------------------------------------------------------------
240:     * InicializarForm - Monta a estrutura visual base (cabecalho).
241:     * Chamado automaticamente por FormBase.Init() via DODEFAULT().
242:     *--------------------------------------------------------------------------
243:     PROTECTED PROCEDURE InicializarForm()
244:         LOCAL loc_lSucesso, loc_oErro
245: 
246:         loc_lSucesso = .F.
247: 
248:         TRY
249:             *-- Caption identico ao legado: Proper(Alltrim(Oper)) + " Lancamento
250:             *-- de Conta Corrente" (ThisForm.Caption do Init original)
251:             THIS.Caption = PROPER(ALLTRIM(THIS.this_cModoAtual)) + " Lan" + CHR(231) + "amento de Conta Corrente"
252: 
253:             THIS.ConfigurarPageFrame()
254:             THIS.RegistrarEventosLookup()
255: 
256:             *-- Propaga o titulo para os labels do cabecalho (equivale a
257:             *-- ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption)
258:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
259:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
260: 
261:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
262:             THIS.TornarControlesVisiveis(THIS)
263: 
264:             *-- Carrega o lancamento a editar nos campos. Pulado quando nao ha
265:             *-- conexao (ValidarUIFidelity/TesteAutomatico definem gnConnHandle
266:             *-- = -1): sem o guard o Init estouraria e CREATEOBJECT devolveria
267:             *-- .F. (FORMCOR_LICOES_APRENDIDAS, Problema 4).
268:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
269:                 THIS.CarregarDados()
270:             ENDIF
271: 
272:             loc_lSucesso = .T.
273:         CATCH TO loc_oErro
274:             MsgErro(loc_oErro.Message + CHR(13) + ;
275:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
276:                 "Procedure: " + loc_oErro.Procedure, "Formsigopacc.InicializarForm")
277:         ENDTRY
278: 
279:         RETURN loc_lSucesso
280:     ENDPROC
281: 
282:     *--------------------------------------------------------------------------
283:     * ConfigurarPageFrame - Orquestrador de layout base.
284:     * SIGOPACC original eh flat OPERACIONAL (sem PageFrame nativo, sem lista -
285:     * "layout CAPTURA": dialogo modal com ~34 campos de edicao e 4 botoes,
286:     * zero Grid/pColuna/AddCursor-com-grade no dump legado). Fabricar um
287:     * Grid+CRUD de Page1 aqui violaria o PILAR 1 (inventar UI que o legado
288:     * nao tem). Nesta fase: cabecalho (Fase 3), shapes decorativos, TODOS os
289:     * campos de dados e os 4 botoes (visual completo). Valid/When dos campos
290:     * e os Click de Cmd_Confirma/Cmd_Cancela ficam para as Fases de eventos.
291:     *--------------------------------------------------------------------------
292:     PROTECTED PROCEDURE ConfigurarPageFrame()
293:         THIS.ConfigurarCabecalho()
294:         THIS.ConfigurarShapes()
295:         THIS.ConfigurarPaginaDados()
296:         THIS.ConfigurarBotoesAcao()
297:     ENDPROC
298: 
299:     *--------------------------------------------------------------------------
300:     * ConfigurarCabecalho - Cria a faixa cinza superior com o titulo
301:     * (cntSombra do legado). Container com Width = THIS.Width: o legado
302:     * declara Width=800 num form de 700px (sobra descartada - CLAUDE.md #11).
303:     *--------------------------------------------------------------------------
304:     PROTECTED PROCEDURE ConfigurarCabecalho()
305:         LOCAL loc_oCab
306: 
307:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
308:         loc_oCab = THIS.cnt_4c_Cabecalho
309:         WITH loc_oCab
310:             .Top         = 0
311:             .Left        = 0
312:             .Width       = THIS.Width
313:             .Height      = 80
314:             .BorderWidth = 0
315:             .BackStyle   = 1
316:             .BackColor   = RGB(100, 100, 100)
317:         ENDWITH
318: 
319:         *-- Labels adicionados FORA do WITH do container: WITH aninhado com
320:         *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
321:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
322:         WITH loc_oCab.lbl_4c_Sombra
323:             .FontBold  = .T.
324:             .FontName  = "Tahoma"
325:             .FontSize  = 18
326:             .WordWrap  = .T.
327:             .AutoSize  = .F.
328:             .Alignment = 0
329:             .BackStyle = 0
330:             .Caption   = ""
331:             .Height    = 40
332:             .Left      = 10
333:             .Top       = 18
334:             .Width     = 769
335:             .ForeColor = RGB(0, 0, 0)
336:         ENDWITH
337: 
338:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
339:         WITH loc_oCab.lbl_4c_Titulo
340:             .FontBold  = .T.
341:             .FontName  = "Tahoma"
342:             .FontSize  = 18
343:             .WordWrap  = .T.
344:             .AutoSize  = .F.

*-- Linhas 357 a 400:
357:     * ConfigurarShapes - Linhas divisorias decorativas (Shape1/2/3/6) e o
358:     * contorno do bloco de Cotacao (Shape7), transcritos do dump do SCX.
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarShapes()
361:         THIS.AddObject("shp_4c_Shape7", "Shape")
362:         WITH THIS.shp_4c_Shape7
363:             .Top         = -8
364:             .Left        = 528
365:             .Height      = 110
366:             .Width       = 173
367:             .BackStyle   = 0
368:             .BorderStyle = 0
369:             .BorderColor = RGB(136, 189, 188)
370:         ENDWITH
371: 
372:         THIS.AddObject("shp_4c_Shape1", "Shape")
373:         WITH THIS.shp_4c_Shape1
374:             .Top         = 213
375:             .Left        = 11
376:             .Height      = 2
377:             .Width       = 502
378:             .BackStyle   = 0
379:             .Curvature   = 21
380:             .BorderColor = RGB(90, 90, 90)
381:         ENDWITH
382: 
383:         THIS.AddObject("shp_4c_Shape3", "Shape")
384:         WITH THIS.shp_4c_Shape3
385:             .Top         = 295
386:             .Left        = 11
387:             .Height      = 2
388:             .Width       = 677
389:             .BackStyle   = 0
390:             .Curvature   = 21
391:             .BorderColor = RGB(90, 90, 90)
392:         ENDWITH
393: 
394:         THIS.AddObject("shp_4c_Shape6", "Shape")
395:         WITH THIS.shp_4c_Shape6
396:             .Top         = 378
397:             .Left        = 11
398:             .Height      = 2
399:             .Width       = 677
400:             .BackStyle   = 0

*-- Linhas 415 a 466:
415:     ENDPROC
416: 
417:     *--------------------------------------------------------------------------
418:     * ConfigurarPaginaDados - Labels + TextBoxes + OptionGroup "Acerto", transcritos
419:     * do dump do SCX (Left/Top/Width/Height/InputMask/Format/MaxLength EXATOS).
420:     * CLAUDE.md #23: label classe "say" sem Width/Alignment no dump -> AutoSize
421:     * = .F. + Alignment = 0 + Width calculada para nao invadir o campo vizinho.
422:     * CLAUDE.md #12: ForeColor de label de dados = RGB(90,90,90) (nao branco).
423:     * Sem ControlSource (regra #15/arquitetura nova): campos sao preenchidos
424:     * via FormParaBO/BOParaForm (Fase de campos/eventos), nao por binding.
425:     *--------------------------------------------------------------------------
426:     PROTECTED PROCEDURE ConfigurarPaginaDados()
427:         LOCAL loc_cNao
428: 
429:         *-- Labels ------------------------------------------------------------
430:         THIS.AddObject("lbl_4c_Label1", "Label")
431:         WITH THIS.lbl_4c_Label1
432:             .FontBold  = .T.
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .Alignment = 0
436:             .AutoSize  = .F.
437:             .BackStyle = 0
438:             .Caption   = "Data : "
439:             .ForeColor = RGB(90, 90, 90)
440:             .Height    = 17
441:             .Left      = 69
442:             .Top       = 116
443:             .Width     = 36
444:         ENDWITH
445: 
446:         THIS.AddObject("lbl_4c_Label10", "Label")
447:         WITH THIS.lbl_4c_Label10
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .Alignment = 0
451:             .AutoSize  = .F.
452:             .BackStyle = 0
453:             .Caption   = "Vencimento : "
454:             .ForeColor = RGB(90, 90, 90)
455:             .Height    = 17
456:             .Left      = 218
457:             .Top       = 116
458:             .Width     = 65
459:         ENDWITH
460: 
461:         THIS.AddObject("lbl_4c_Label7", "Label")
462:         WITH THIS.lbl_4c_Label7
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8
465:             .Alignment = 0
466:             .AutoSize  = .F.

*-- Linhas 1121 a 1533:
1121:             .ForeColor     = RGB(0, 0, 0)
1122:         ENDWITH
1123: 
1124:         *-- OptionGroup "Acerto" (Sim/Nao) - ControlSource legado: crAltcc.contapgs
1125:         *-- (numerico, indice 1-based - regra #45). Default legado Value=2 (Nao).
1126:         THIS.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1127:         WITH THIS.obj_4c_Opcao_conta
1128:             .ButtonCount = 2
1129:             .Left        = 282
1130:             .Top         = 163
1131:             .Width       = 88
1132:             .Height      = 27
1133:             .Value       = 2
1134:         ENDWITH
1135:         WITH THIS.obj_4c_Opcao_conta.Buttons(1)
1136:             .Caption   = "Sim"
1137:             .Left      = 5
1138:             .Top       = 5
1139:             .AutoSize  = .F.
1140:             .BackStyle = 0
1141:         ENDWITH
1142:         loc_cNao = "N" + CHR(227) + "o"
1143:         WITH THIS.obj_4c_Opcao_conta.Buttons(2)
1144:             .Caption   = loc_cNao
1145:             .Left      = 46
1146:             .Top       = 6
1147:             .Alignment = 0
1148:             .AutoSize  = .T.
1149:             .BackStyle = 0
1150:         ENDWITH
1151:     ENDPROC
1152: 
1153:     *--------------------------------------------------------------------------
1154:     * ConfigurarBotoesAcao - Botoes standalone do dialogo: Confirmar/Encerrar
1155:     * (acao principal) e os dois botoes de alteracao de cotacao (icone-only,
1156:     * ao lado dos campos Cotacao/SCotacao). Visual completo, transcrito do
1157:     * dump; BINDEVENT dos Click fica para a fase de eventos (regra de
1158:     * completude - metodo sem logica real nao pode ser criado como stub).
1159:     *--------------------------------------------------------------------------
1160:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1161:         LOCAL loc_cTituloCambio
1162: 
1163:         THIS.AddObject("cmd_4c_Cmd_Confirma", "CommandButton")
1164:         WITH THIS.cmd_4c_Cmd_Confirma
1165:             .Top             = 3
1166:             .Left            = 549
1167:             .Width           = 75
1168:             .Height          = 75
1169:             .FontBold        = .T.
1170:             .FontItalic      = .T.
1171:             .FontName        = "Comic Sans MS"
1172:             .FontSize        = 8
1173:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1174:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1175:             .Caption         = "\<Confirmar"
1176:             .ForeColor       = RGB(90, 90, 90)
1177:             .BackColor       = RGB(255, 255, 255)
1178:             .Themes          = .T.
1179:         ENDWITH
1180:         BINDEVENT(THIS.cmd_4c_Cmd_Confirma, "Click", THIS, "BtnConfirmarClick")
1181: 
1182:         THIS.AddObject("cmd_4c_Cmd_Cancela", "CommandButton")
1183:         WITH THIS.cmd_4c_Cmd_Cancela
1184:             .Top        = 3
1185:             .Left       = 624
1186:             .Width      = 75
1187:             .Height     = 75
1188:             .FontBold   = .T.
1189:             .FontItalic = .T.
1190:             .FontName   = "Comic Sans MS"
1191:             .FontSize   = 8
1192:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1193:             .Cancel     = .T.
1194:             .Caption    = "Encerrar"
1195:             .ForeColor  = RGB(90, 90, 90)
1196:             .BackColor  = RGB(255, 255, 255)
1197:             .Themes           = .T.
1198:         ENDWITH
1199:         BINDEVENT(THIS.cmd_4c_Cmd_Cancela, "Click", THIS, "BtnCancelarClick")
1200: 
1201:         loc_cTituloCambio = "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o"
1202: 
1203:         THIS.AddObject("cmd_4c_Alteracotacao", "CommandButton")
1204:         WITH THIS.cmd_4c_Alteracotacao
1205:             .Top           = 268
1206:             .Left          = 659
1207:             .Width         = 30
1208:             .Height        = 23
1209:             .FontBold      = .T.
1210:             .FontName      = "Verdana"
1211:             .FontSize      = 8
1212:             .Picture       = gc_4c_CaminhoIcones + "geral_cambio_16.jpg"
1213:             .Caption       = ""
1214:             .TabStop       = .F.
1215:             .ToolTipText   = loc_cTituloCambio
1216:             .SpecialEffect = 1
1217:             .ForeColor     = RGB(36, 84, 155)
1218:             .BackColor     = RGB(255, 255, 255)
1219:             .Themes           = .T.
1220:         ENDWITH
1221:         BINDEVENT(THIS.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteraCotacaoClick")
1222: 
1223:         THIS.AddObject("cmd_4c_AlteraSCotacao", "CommandButton")
1224:         WITH THIS.cmd_4c_AlteraSCotacao
1225:             .Top           = 351
1226:             .Left          = 659
1227:             .Width         = 30
1228:             .Height        = 23
1229:             .FontBold      = .T.
1230:             .FontName      = "Verdana"
1231:             .FontSize      = 8
1232:             .Picture       = gc_4c_CaminhoIcones + "geral_cambio_16.jpg"
1233:             .Caption       = ""
1234:             .TabStop       = .F.
1235:             .ToolTipText   = loc_cTituloCambio
1236:             .SpecialEffect = 1
1237:             .ForeColor     = RGB(36, 84, 155)
1238:             .BackColor     = RGB(255, 255, 255)
1239:             .Themes           = .T.
1240:         ENDWITH
1241:         BINDEVENT(THIS.cmd_4c_AlteraSCotacao, "Click", THIS, "BtnAlteraSCotacaoClick")
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * CarregarDados - Traz para a tela o lancamento que o form pai mandou
1246:     * editar. No legado isto nao existia como codigo: o SIGOPACC era aberto com
1247:     * o cursor crAltcc do pai ja posicionado no registro e TODOS os campos
1248:     * tinham ControlSource = "crAltcc.<coluna>". A arquitetura nova nao
1249:     * compartilha cursor entre telas, entao a PK chega por parametro (Init) e o
1250:     * BO le o registro (sigopaccBO.CarregarPorChave).
1251:     *
1252:     * Guarda tambem this_nOldContaPgs, que eh o "ThisForm.OldContaPgs =
1253:     * crAltcc.ContaPgs" do Init legado - o Cmd_Confirma.Click (Fase 7) compara
1254:     * o valor atual com ele para decidir o estorno de valpags.
1255:     *--------------------------------------------------------------------------
1256:     PROTECTED PROCEDURE CarregarDados()
1257:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
1258: 
1259:         loc_lSucesso = .F.
1260:         loc_oBO      = THIS.this_oBusinessObject
1261: 
1262:         TRY
1263:             IF VARTYPE(loc_oBO) != "O"
1264:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
1265:                     "Formsigopacc.CarregarDados")
1266:             ELSE
1267:                 IF INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR")
1268:                     *-- Lancamento novo: defaults do BO. O legado nunca abre
1269:                     *-- este dialogo sem registro, mas o parametro OPER aceita
1270:                     *-- INSERIR - entao o caminho existe e nao pode estourar.
1271:                     loc_oBO.NovoRegistro()
1272:                     loc_oBO.this_cUsualts = gc_4c_UsuarioLogado
1273:                     IF EMPTY(loc_oBO.this_dDatas)
1274:                         loc_oBO.this_dDatas = DATE()
1275:                     ENDIF
1276:                     loc_lSucesso = .T.
1277:                 ELSE
1278:                     IF EMPTY(THIS.this_cPkChaves)
1279:                         MsgAviso("Lan" + CHR(231) + "amento n" + CHR(227) + "o informado pela tela de origem.", ;
1280:                             "Aten" + CHR(231) + CHR(227) + "o")
1281:                     ELSE
1282:                         loc_lSucesso = loc_oBO.CarregarPorChave(THIS.this_cPkChaves)
1283: 
1284:                         IF loc_lSucesso
1285:                             *-- ALTERAR abre a edicao no BO: sem isso o
1286:                             *-- Salvar() herdado recusa por "fora de edicao".
1287:                             *-- CONSULTAR so exibe, entao NAO entra em edicao.
1288:                             IF THIS.this_cModoAtual == "ALTERAR"
1289:                                 loc_oBO.EditarRegistro()
1290:                             ENDIF
1291:                         ELSE
1292:                             *-- BusinessBase/BO so exibem a falha uma vez
1293:                             *-- (this_lErroExibido) - regra #20 do CLAUDE.md.
1294:                             IF !loc_oBO.this_lErroExibido
1295:                                 MsgAviso(loc_oBO.ObterMensagemErro(), ;
1296:                                     "Aten" + CHR(231) + CHR(227) + "o")
1297:                             ENDIF
1298:                         ENDIF
1299:                     ENDIF
1300:                 ENDIF
1301: 
1302:                 *-- ThisForm.OldContaPgs / ThisForm.InvEmisCCs do Init legado.
1303:                 THIS.this_nOldContaPgs = loc_oBO.this_nContapgs
1304:                 THIS.this_lInvEmisCCs  = .F.
1305: 
1306:                 THIS.BOParaForm()
1307: 
1308:                 *-- Fase 6: troca SGrupos<->GrupEms/SContas<->ContEms quando a
1309:                 *-- Classe do Grupo exige (SigCdCss.InvEmisCCs), resolve as
1310:                 *-- descricoes de todos os pares codigo/descricao por lookup e
1311:                 *-- calcula a visibilidade dos campos de cambio (Cotacao/
1312:                 *-- SCotacao) a partir de SigCdMoe.Cotas.
1313:                 THIS.AplicarInversaoEmissor()
1314:                 THIS.CarregarDescricoesLookup()
1315:                 THIS.AtualizarVisibilidadeCambio()
1316:             ENDIF
1317:         CATCH TO loc_oErro
1318:             MsgErro(loc_oErro.Message + CHR(13) + ;
1319:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1320:                 "Procedure: " + loc_oErro.Procedure, "Formsigopacc.CarregarDados")
1321:         ENDTRY
1322: 
1323:         RETURN loc_lSucesso
1324:     ENDPROC
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * BOParaForm - Copia as propriedades do BO para os controles do form.
1328:     * Cobre os 29 TextBox e o OptionGroup "Acerto" - TODOS os controles de
1329:     * dados do SCX, na mesma ordem em que o dump os declara. Mapear so parte
1330:     * deles eh o defeito do Erro184 (o campo aparece na tela, o usuario digita
1331:     * e o valor nunca chega ao BO; o resto grava em branco, sem erro nenhum).
1332:     *
1333:     * ConverterParaData() normaliza DATE/DATETIME/CHAR (regra #16 do CLAUDE.md:
1334:     * this_dDatas/this_dVencs sao datetime no BO e os TextBox trabalham com
1335:     * DATE - TTOD() direto estouraria erro 11 no modo INCLUIR).
1336:     *--------------------------------------------------------------------------
1337:     PROTECTED PROCEDURE BOParaForm()
1338:         LOCAL loc_oBO
1339: 
1340:         loc_oBO = THIS.this_oBusinessObject
1341: 
1342:         *-- Bloco principal do lancamento ------------------------------------
1343:         THIS.txt_4c_Fweditdata_DATA.Value = ConverterParaData(loc_oBO.this_dDatas)
1344:         THIS.txt_4c_Fweditdata_VENC.Value = ConverterParaData(loc_oBO.this_dVencs)
1345:         THIS.txt_4c_Nota.Value            = loc_oBO.this_cNfs
1346:         THIS.txt_4c_Usuario.Value         = loc_oBO.this_cUsualts
1347:         THIS.txt_4c_DOCU.Value            = loc_oBO.this_cDocus
1348:         THIS.txt_4c_Job.Value             = loc_oBO.this_cJobs
1349:         THIS.txt_4c_DJob.Value            = loc_oBO.this_cDescJob
1350:         THIS.txt_4c_OPER.Value            = loc_oBO.this_cOpers
1351:         THIS.txt_4c_Grupo.Value           = loc_oBO.this_cGrupos
1352:         THIS.txt_4c_Dgrupo.Value          = loc_oBO.this_cDescGrupo
1353:         THIS.txt_4c_Conta.Value           = loc_oBO.this_cContas
1354:         THIS.txt_4c_Dconta.Value          = loc_oBO.this_cDescConta
1355:         THIS.txt_4c_MOEDA.Value           = loc_oBO.this_cMoedas
1356:         THIS.txt_4c_VALOR.Value           = loc_oBO.this_nValors
1357:         THIS.txt_4c_COTACAO.Value         = loc_oBO.this_nCotacaos
1358: 
1359:         *-- Bloco de contrapartida -------------------------------------------
1360:         THIS.txt_4c_SOPER.Value           = loc_oBO.this_cSopers
1361:         THIS.txt_4c_SGRUPO.Value          = loc_oBO.this_cSgrupos
1362:         THIS.txt_4c_Sdgrupo.Value         = loc_oBO.this_cDescSGrupo
1363:         THIS.txt_4c_SCONTA.Value          = loc_oBO.this_cScontas
1364:         THIS.txt_4c_SDCONTA.Value         = loc_oBO.this_cDescSConta
1365:         THIS.txt_4c_Smoeda.Value          = loc_oBO.this_cSmoedas
1366:         THIS.txt_4c_SVALOR.Value          = loc_oBO.this_nSvalors
1367:         THIS.txt_4c_SCOTACAO.Value        = loc_oBO.this_nScotacaos
1368: 
1369:         *-- Bloco do emissor --------------------------------------------------
1370:         THIS.txt_4c__GrupEms.Value        = loc_oBO.this_cGrupems
1371:         THIS.txt_4c__DGrupEms.Value       = loc_oBO.this_cDescGrupEms
1372:         THIS.txt_4c__ContEms.Value        = loc_oBO.this_cContems
1373:         THIS.txt_4c__DContEms.Value       = loc_oBO.this_cDescContEms
1374: 
1375:         *-- Historico ---------------------------------------------------------
1376:         THIS.txt_4c_HIST.Value            = loc_oBO.this_cHists
1377:         THIS.txt_4c_Hist2.Value           = loc_oBO.this_cHist2s
1378: 
1379:         *-- OptionGroup "Acerto": ControlSource legado eh crAltcc.contapgs
1380:         *-- direto, coluna numeric(1,0) 1-based (regra #45 - sem +1/-1).
1381:         *-- contapgs NAO esta limitado a 1..2: o proprio When do legado testa
1382:         *-- Inlist(Craltcc.contapgs, 3, 4). Medido no VFP9 (2026-10-16):
1383:         *-- atribuir .Value = 3 ou 4 a um OptionGroup com ButtonCount = 2
1384:         *-- devolve 0 em SILENCIO (nenhum botao marcado) - que eh exatamente o
1385:         *-- que o legado exibe nesse caso. Achatar para 2 "para ficar valido"
1386:         *-- faria o FormParaBO regravar 2 por cima de 3/4 (PILAR 2: nada de
1387:         *-- valor inventado). O valor original fica em this_nOldContaPgs e eh
1388:         *-- devolvido intacto pelo FormParaBO.
1389:         IF BETWEEN(loc_oBO.this_nContapgs, 1, THIS.obj_4c_Opcao_conta.ButtonCount)
1390:             THIS.obj_4c_Opcao_conta.Value = loc_oBO.this_nContapgs
1391:         ELSE
1392:             THIS.obj_4c_Opcao_conta.Value = 0
1393:         ENDIF
1394:     ENDPROC
1395: 
1396:     *--------------------------------------------------------------------------
1397:     * FormParaBO - Copia os valores dos controles do form para o BO.
1398:     * Mesmo conjunto completo do BOParaForm acima.
1399:     * Retorna .T./.F. - quem chamar (BtnConfirmaClick, Fase 7) deve ABORTAR a
1400:     * gravacao quando retornar .F.
1401:     *--------------------------------------------------------------------------
1402:     PROTECTED PROCEDURE FormParaBO()
1403:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
1404: 
1405:         loc_lSucesso = .T.
1406:         loc_oBO      = THIS.this_oBusinessObject
1407: 
1408:         TRY
1409:             *-- Bloco principal do lancamento --------------------------------
1410:             loc_oBO.this_dDatas     = ConverterParaData(THIS.txt_4c_Fweditdata_DATA.Value)
1411:             loc_oBO.this_dVencs     = ConverterParaData(THIS.txt_4c_Fweditdata_VENC.Value)
1412:             loc_oBO.this_cNfs       = ALLTRIM(THIS.txt_4c_Nota.Value)
1413:             loc_oBO.this_cDocus     = ALLTRIM(THIS.txt_4c_DOCU.Value)
1414:             loc_oBO.this_cJobs      = ALLTRIM(THIS.txt_4c_Job.Value)
1415:             loc_oBO.this_cOpers     = ALLTRIM(THIS.txt_4c_OPER.Value)
1416:             loc_oBO.this_cGrupos    = ALLTRIM(THIS.txt_4c_Grupo.Value)
1417:             loc_oBO.this_cContas    = ALLTRIM(THIS.txt_4c_Conta.Value)
1418:             loc_oBO.this_cMoedas    = ALLTRIM(THIS.txt_4c_MOEDA.Value)
1419:             loc_oBO.this_nValors    = THIS.txt_4c_VALOR.Value
1420:             loc_oBO.this_nCotacaos  = THIS.txt_4c_COTACAO.Value
1421: 
1422:             *-- Bloco de contrapartida ---------------------------------------
1423:             loc_oBO.this_cSopers    = ALLTRIM(THIS.txt_4c_SOPER.Value)
1424:             loc_oBO.this_cSgrupos   = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
1425:             loc_oBO.this_cScontas   = ALLTRIM(THIS.txt_4c_SCONTA.Value)
1426:             loc_oBO.this_cSmoedas   = ALLTRIM(THIS.txt_4c_Smoeda.Value)
1427:             loc_oBO.this_nSvalors   = THIS.txt_4c_SVALOR.Value
1428:             loc_oBO.this_nScotacaos = THIS.txt_4c_SCOTACAO.Value
1429: 
1430:             *-- Bloco do emissor ----------------------------------------------
1431:             loc_oBO.this_cGrupems   = ALLTRIM(THIS.txt_4c__GrupEms.Value)
1432:             loc_oBO.this_cContems   = ALLTRIM(THIS.txt_4c__ContEms.Value)
1433: 
1434:             *-- Historico ------------------------------------------------------
1435:             loc_oBO.this_cHists     = ALLTRIM(THIS.txt_4c_HIST.Value)
1436:             loc_oBO.this_cHist2s    = ALLTRIM(THIS.txt_4c_Hist2.Value)
1437: 
1438:             *-- OptionGroup "Acerto": so grava o que o usuario podia escolher.
1439:             *-- Com o grupo desabilitado (o When do legado o trava em INSERIR,
1440:             *-- em CONSULTAR e quando contapgs eh 3 ou 4) ou com .Value fora da
1441:             *-- faixa dos botoes, devolve o valor ORIGINAL do banco em vez de
1442:             *-- um 0/2 inventado.
1443:             IF THIS.obj_4c_Opcao_conta.Enabled AND ;
1444:                BETWEEN(THIS.obj_4c_Opcao_conta.Value, 1, THIS.obj_4c_Opcao_conta.ButtonCount)
1445:                 loc_oBO.this_nContapgs = THIS.obj_4c_Opcao_conta.Value
1446:             ELSE
1447:                 loc_oBO.this_nContapgs = THIS.this_nOldContaPgs
1448:             ENDIF
1449: 
1450:             *-- txt_4c_Usuario eh SOMENTE EXIBICAO (legado: Get_usuario.When
1451:             *-- sempre RETURN .F.) - this_cUsualts eh preenchido pelo proprio
1452:             *-- BO em Inserir/Atualizar com gc_4c_UsuarioLogado, nunca a
1453:             *-- partir do controle.
1454: 
1455:             *-- Descricoes de lookup (exibicao; nao sao colunas de SigMvCcr)
1456:             loc_oBO.this_cDescJob      = ALLTRIM(THIS.txt_4c_DJob.Value)
1457:             loc_oBO.this_cDescGrupo    = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
1458:             loc_oBO.this_cDescConta    = ALLTRIM(THIS.txt_4c_Dconta.Value)
1459:             loc_oBO.this_cDescSGrupo   = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
1460:             loc_oBO.this_cDescSConta   = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
1461:             loc_oBO.this_cDescGrupEms  = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
1462:             loc_oBO.this_cDescContEms  = ALLTRIM(THIS.txt_4c__DContEms.Value)
1463:         CATCH TO loc_oErro
1464:             MsgErro(loc_oErro.Message + CHR(13) + ;
1465:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1466:                 "Procedure: " + loc_oErro.Procedure, "Formsigopacc.FormParaBO")
1467:             loc_lSucesso = .F.
1468:         ENDTRY
1469: 
1470:         RETURN loc_lSucesso
1471:     ENDPROC
1472: 
1473:     *--------------------------------------------------------------------------
1474:     * AtualizarEstadoControles - Transcricao do When de CADA controle do SCX.
1475:     * Hook PUBLIC de FormBase, chamado automaticamente por FormBase.Init()
1476:     * depois de InicializarForm(); os lookups da Fase 6 devem chama-lo de novo
1477:     * depois de preencher um codigo, porque o When das caixas de DESCRICAO
1478:     * depende de o campo de codigo estar vazio.
1479:     *
1480:     * Mapeamento When -> Enabled: em VFP9 o When nega o FOCO ao controle, e o
1481:     * equivalente na arquitetura nova eh Enabled (mesmo criterio do
1482:     * HabilitarCampos dos demais forms). Excecao: cmd_4c_Alteracotacao e
1483:     * cmd_4c_AlteraSCotacao sao botoes SO-ICONE (Caption vazio) - neles
1484:     * Enabled = .F. apaga o icone e deixa um retangulo vazio, e o proprio Init
1485:     * legado liga/desliga esses dois por .Visible. Entao aqui tambem eh
1486:     * .Visible.
1487:     *
1488:     * As duas condicoes que o legado ainda soma ao When de Cotacao/SCotacao
1489:     * (crSigCdCrg.AltCots = "S" para o cargo do usuario e crSigCdMoe.Cotas da
1490:     * moeda do lancamento) dependem de cursores de lookup que entram na Fase 6
1491:     * - ate la vale a parte ja transcrita, nunca um valor inventado.
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE AtualizarEstadoControles()
1494:         LOCAL loc_lAlterar, loc_lAltSemTp, loc_lConsultar
1495: 
1496:         *-- Thisform.op_escolha = ALTERAR (e nTpAltera = 0 na variante estrita)
1497:         loc_lAlterar   = (THIS.this_cModoAtual == "ALTERAR")
1498:         loc_lAltSemTp  = loc_lAlterar AND (THIS.this_nTpAltera = 0)
1499:         loc_lConsultar = (THIS.this_cModoAtual == "CONSULTAR")
1500: 
1501:         *-- When = RETURN .F. fixo no SCX (campos que o legado nunca deixa editar)
1502:         THIS.txt_4c_Fweditdata_DATA.Enabled = .F.   && nao permite alterar a data (mena, 27/04/2017)
1503:         THIS.txt_4c_OPER.Enabled            = .F.   && nao permite alterar a operacao (mena, 27/04/2017)
1504:         THIS.txt_4c_Usuario.Enabled         = .F.
1505:         THIS.txt_4c_SOPER.Enabled           = .F.
1506:         THIS.txt_4c_SVALOR.Enabled          = .F.
1507: 
1508:         *-- When = (op_escolha=ALTERAR And nTpAltera = 0)
1509:         THIS.txt_4c_Fweditdata_VENC.Enabled = loc_lAltSemTp
1510:         THIS.txt_4c_Nota.Enabled            = loc_lAltSemTp
1511:         THIS.txt_4c_DOCU.Enabled            = loc_lAltSemTp
1512:         THIS.txt_4c_VALOR.Enabled           = loc_lAltSemTp
1513:         THIS.txt_4c_MOEDA.Enabled           = loc_lAltSemTp
1514:         THIS.txt_4c_COTACAO.Enabled         = loc_lAltSemTp
1515:         THIS.txt_4c_SGRUPO.Enabled          = loc_lAltSemTp
1516:         THIS.txt_4c_SCONTA.Enabled          = loc_lAltSemTp
1517:         THIS.txt_4c_SDCONTA.Enabled         = loc_lAltSemTp
1518:         THIS.txt_4c_Smoeda.Enabled          = loc_lAltSemTp
1519:         THIS.txt_4c_SCOTACAO.Enabled        = loc_lAltSemTp
1520:         THIS.txt_4c_HIST.Enabled            = loc_lAltSemTp
1521:         THIS.txt_4c_Hist2.Enabled           = loc_lAltSemTp
1522: 
1523:         *-- When = (op_escolha=ALTERAR)
1524:         THIS.txt_4c_Grupo.Enabled           = loc_lAlterar
1525:         THIS.txt_4c_Conta.Enabled           = loc_lAlterar
1526:         THIS.txt_4c_Job.Enabled             = loc_lAlterar
1527:         THIS.txt_4c__GrupEms.Enabled        = loc_lAlterar
1528:         THIS.txt_4c__ContEms.Enabled        = loc_lAlterar
1529: 
1530:         *-- Caixas de DESCRICAO: o legado so libera a digitacao da descricao
1531:         *-- quando o campo de CODIGO irmao esta vazio (busca pelo nome).
1532:         THIS.txt_4c_Dgrupo.Enabled    = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
1533:         THIS.txt_4c_Dconta.Enabled    = loc_lAlterar  AND EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))

*-- Linhas 1576 a 1650:
1576:     ENDPROC
1577: 
1578:     *--------------------------------------------------------------------------
1579:     * RegistrarEventosLookup - BINDEVENT "LostFocus" de todos os campos com
1580:     * lookup (grupo/conta normal, contrapartida, emissor, job e moeda).
1581:     * Regra #47 do CLAUDE.md: o legado valida no Valid (ao SAIR do campo) -
1582:     * o evento equivalente eh LostFocus, nunca KeyPress sem testar a tecla.
1583:     *--------------------------------------------------------------------------
1584:     PROTECTED PROCEDURE RegistrarEventosLookup()
1585:         BINDEVENT(THIS.txt_4c_Grupo,      "LostFocus", THIS, "ValidarGrupo")
1586:         BINDEVENT(THIS.txt_4c_Dgrupo,     "LostFocus", THIS, "ValidarDgrupo")
1587:         BINDEVENT(THIS.txt_4c_Conta,      "LostFocus", THIS, "ValidarConta")
1588:         BINDEVENT(THIS.txt_4c_Dconta,     "LostFocus", THIS, "ValidarDconta")
1589:         BINDEVENT(THIS.txt_4c_SGRUPO,     "LostFocus", THIS, "ValidarSGrupo")
1590:         BINDEVENT(THIS.txt_4c_Sdgrupo,    "LostFocus", THIS, "ValidarSdgrupo")
1591:         BINDEVENT(THIS.txt_4c_SCONTA,     "LostFocus", THIS, "ValidarSConta")
1592:         BINDEVENT(THIS.txt_4c_SDCONTA,    "LostFocus", THIS, "ValidarSDConta")
1593:         BINDEVENT(THIS.txt_4c__GrupEms,   "LostFocus", THIS, "ValidarGrupEms")
1594:         BINDEVENT(THIS.txt_4c__DGrupEms,  "LostFocus", THIS, "ValidarDGrupEms")
1595:         BINDEVENT(THIS.txt_4c__ContEms,   "LostFocus", THIS, "ValidarContEms")
1596:         BINDEVENT(THIS.txt_4c__DContEms,  "LostFocus", THIS, "ValidarDContEms")
1597:         BINDEVENT(THIS.txt_4c_Job,        "LostFocus", THIS, "ValidarJob")
1598:         BINDEVENT(THIS.txt_4c_DJob,       "LostFocus", THIS, "ValidarDJob")
1599:         BINDEVENT(THIS.txt_4c_MOEDA,      "LostFocus", THIS, "ValidarMoeda")
1600:         BINDEVENT(THIS.txt_4c_Smoeda,     "LostFocus", THIS, "ValidarSmoeda")
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * AplicarInversaoEmissor - Legado (Init): quando a Classe do Grupo
1605:     * principal (this_cGrupos) tem SigCdCss.InvEmisCCs = 1, o lancamento
1606:     * grava a contrapartida e o emissor TROCADOS (SGrupos<->GrupEms,
1607:     * SContas<->ContEms). Reproduz isso nos controles ja preenchidos por
1608:     * BOParaForm, ANTES de resolver as descricoes (CarregarDescricoesLookup).
1609:     *--------------------------------------------------------------------------
1610:     PROTECTED PROCEDURE AplicarInversaoEmissor()
1611:         LOCAL loc_cGrupo, loc_cClasse, loc_lInverter
1612:         LOCAL loc_cAntSGrupos, loc_cAntGrupEms, loc_cAntSContas, loc_cAntContEms
1613: 
1614:         loc_cClasse   = ""
1615:         loc_lInverter = .F.
1616:         loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)
1617: 
1618:         IF !EMPTY(loc_cGrupo)
1619:             IF USED("cursor_4c_ValClasseGrp")
1620:                 USE IN cursor_4c_ValClasseGrp
1621:             ENDIF
1622:             SQLEXEC(gnConnHandle, "SELECT Classes FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), "cursor_4c_ValClasseGrp")
1623:             IF USED("cursor_4c_ValClasseGrp") AND RECCOUNT("cursor_4c_ValClasseGrp") > 0
1624:                 loc_cClasse = ALLTRIM(NVL(cursor_4c_ValClasseGrp.Classes, ""))
1625:             ENDIF
1626:             IF USED("cursor_4c_ValClasseGrp")
1627:                 USE IN cursor_4c_ValClasseGrp
1628:             ENDIF
1629:         ENDIF
1630: 
1631:         IF !EMPTY(loc_cClasse)
1632:             IF USED("cursor_4c_ValInvEmis")
1633:                 USE IN cursor_4c_ValInvEmis
1634:             ENDIF
1635:             SQLEXEC(gnConnHandle, "SELECT InvEmisCCs FROM SigCdCss WHERE Classes = " + EscaparSQL(loc_cClasse), "cursor_4c_ValInvEmis")
1636:             IF USED("cursor_4c_ValInvEmis") AND RECCOUNT("cursor_4c_ValInvEmis") > 0
1637:                 IF VARTYPE(cursor_4c_ValInvEmis.InvEmisCCs) = "L"
1638:                     loc_lInverter = cursor_4c_ValInvEmis.InvEmisCCs
1639:                 ELSE
1640:                     loc_lInverter = (NVL(cursor_4c_ValInvEmis.InvEmisCCs, 0) = 1)
1641:                 ENDIF
1642:             ENDIF
1643:             IF USED("cursor_4c_ValInvEmis")
1644:                 USE IN cursor_4c_ValInvEmis
1645:             ENDIF
1646:         ENDIF
1647: 
1648:         THIS.this_lInvEmisCCs = loc_lInverter
1649: 
1650:         IF loc_lInverter

*-- Linhas 1669 a 1963:
1669:     * (MsgErro/limpeza de campo). Chamado uma vez, apos BOParaForm +
1670:     * AplicarInversaoEmissor.
1671:     *--------------------------------------------------------------------------
1672:     PROTECTED PROCEDURE CarregarDescricoesLookup()
1673:         THIS.txt_4c_Dgrupo.Value = ""
1674:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
1675:             fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c_Grupo.Value), ;
1676:                 THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
1677:         ENDIF
1678: 
1679:         THIS.txt_4c_Dconta.Value = ""
1680:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1681:             fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c_Grupo.Value), "C", ;
1682:                 ALLTRIM(THIS.txt_4c_Conta.Value), THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
1683:         ENDIF
1684: 
1685:         THIS.txt_4c_Sdgrupo.Value = ""
1686:         IF !EMPTY(ALLTRIM(THIS.txt_4c_SGRUPO.Value))
1687:             fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c_SGRUPO.Value), ;
1688:                 THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
1689:         ENDIF
1690: 
1691:         THIS.txt_4c_SDCONTA.Value = ""
1692:         IF !EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
1693:             fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c_SGRUPO.Value), "C", ;
1694:                 ALLTRIM(THIS.txt_4c_SCONTA.Value), THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
1695:         ENDIF
1696: 
1697:         THIS.txt_4c__DGrupEms.Value = ""
1698:         IF !EMPTY(ALLTRIM(THIS.txt_4c__GrupEms.Value))
1699:             fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(THIS.txt_4c__GrupEms.Value), ;
1700:                 THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
1701:         ENDIF
1702: 
1703:         THIS.txt_4c__DContEms.Value = ""
1704:         IF !EMPTY(ALLTRIM(THIS.txt_4c__ContEms.Value))
1705:             fAcessoContas(gc_4c_UsuarioLogado, ALLTRIM(THIS.txt_4c__GrupEms.Value), "C", ;
1706:                 ALLTRIM(THIS.txt_4c__ContEms.Value), THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
1707:         ENDIF
1708: 
1709:         THIS.txt_4c_DJob.Value = ""
1710:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Job.Value))
1711:             fAcessoContas(gc_4c_UsuarioLogado, "", "C", ALLTRIM(THIS.txt_4c_Job.Value), ;
1712:                 THIS.txt_4c_Job, THIS.txt_4c_DJob)
1713:         ENDIF
1714: 
1715:         THIS.this_cUltimoGrupoValidado    = ALLTRIM(THIS.txt_4c_Grupo.Value)
1716:         THIS.this_cUltimoDgrupoValidado   = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
1717:         THIS.this_cUltimaContaValidada    = ALLTRIM(THIS.txt_4c_Conta.Value)
1718:         THIS.this_cUltimoDcontaValidado   = ALLTRIM(THIS.txt_4c_Dconta.Value)
1719:         THIS.this_cUltimoSGrupoValidado   = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
1720:         THIS.this_cUltimoSdgrupoValidado  = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
1721:         THIS.this_cUltimaSContaValidada   = ALLTRIM(THIS.txt_4c_SCONTA.Value)
1722:         THIS.this_cUltimoSdcontaValidado  = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
1723:         THIS.this_cUltimoGrupEmsValidado  = ALLTRIM(THIS.txt_4c__GrupEms.Value)
1724:         THIS.this_cUltimoDGrupEmsValidado = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
1725:         THIS.this_cUltimoContEmsValidado  = ALLTRIM(THIS.txt_4c__ContEms.Value)
1726:         THIS.this_cUltimoDContEmsValidado = ALLTRIM(THIS.txt_4c__DContEms.Value)
1727:         THIS.this_cUltimoJobValidado      = ALLTRIM(THIS.txt_4c_Job.Value)
1728:         THIS.this_cUltimoDJobValidado     = ALLTRIM(THIS.txt_4c_DJob.Value)
1729:     ENDPROC
1730: 
1731:     *--------------------------------------------------------------------------
1732:     * ResolverTemCotas - Le SigCdMoe.Cotas para o codigo de moeda informado.
1733:     * Leitura pura (sem efeito colateral) usada tanto na carga inicial
1734:     * (AtualizarVisibilidadeCambio) quanto apos a troca de moeda pelo
1735:     * usuario (ProcessarMudancaMoeda).
1736:     *--------------------------------------------------------------------------
1737:     PROTECTED FUNCTION ResolverTemCotas(par_cMoeda)
1738:         LOCAL loc_lResultado
1739:         loc_lResultado = .F.
1740: 
1741:         IF !EMPTY(par_cMoeda)
1742:             IF USED("cursor_4c_ValMoeCota")
1743:                 USE IN cursor_4c_ValMoeCota
1744:             ENDIF
1745:             SQLEXEC(gnConnHandle, "SELECT Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(par_cMoeda), "cursor_4c_ValMoeCota")
1746:             IF USED("cursor_4c_ValMoeCota") AND RECCOUNT("cursor_4c_ValMoeCota") > 0
1747:                 loc_lResultado = ConverterParaLogico(cursor_4c_ValMoeCota.Cotas)
1748:             ENDIF
1749:             IF USED("cursor_4c_ValMoeCota")
1750:                 USE IN cursor_4c_ValMoeCota
1751:             ENDIF
1752:         ENDIF
1753: 
1754:         RETURN loc_lResultado
1755:     ENDFUNC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * AtualizarVisibilidadeCambio - Calcula this_lMoedaTemCotas/
1759:     * this_lSMoedaTemCotas a partir da moeda JA CARREGADA (sem recalcular a
1760:     * cotacao vigente - o valor persistido no banco eh historico e nao pode
1761:     * ser sobrescrito so por exibir a tela). Chamado uma vez na carga;
1762:     * AtualizarEstadoControles() le essas duas properties para decidir o
1763:     * Visible dos campos de cambio.
1764:     *--------------------------------------------------------------------------
1765:     PROTECTED PROCEDURE AtualizarVisibilidadeCambio()
1766:         THIS.this_lMoedaTemCotas  = THIS.ResolverTemCotas(ALLTRIM(THIS.txt_4c_MOEDA.Value))
1767:         THIS.this_lSMoedaTemCotas = THIS.ResolverTemCotas(ALLTRIM(THIS.txt_4c_Smoeda.Value))
1768:     ENDPROC
1769: 
1770:     *--------------------------------------------------------------------------
1771:     * BtnCancelarClick - Cmd_Cancela.Click do legado (botao "Encerrar"):
1772:     * fecha o dialogo sem gravar nada.
1773:     *--------------------------------------------------------------------------
1774:     PROCEDURE BtnCancelarClick()
1775:         THIS.Release()
1776:     ENDPROC
1777: 
1778:     *--------------------------------------------------------------------------
1779:     * BtnAlteraCotacaoClick / BtnAlteraSCotacaoClick - alteracotacao.Click /
1780:     * AlteraSCotacao.Click do legado. O legado abre "Do Form SigOpAlC WITH
1781:     * .Get_Moeda.Value, .Get_Cotacao.Value, .fweditdata_Data.Value TO
1782:     * lcRetorno" - SigOpAlC (origem\SigOpAlC.SCX) NAO foi migrado. Mesma
1783:     * substituicao ja aceita em Formsigmvccr.BtnAlterarCotacaoClick: INPUTBOX
1784:     * no lugar do form auxiliar, gravando this_cCotusus (usuario que alterou
1785:     * a cotacao) e recalculando o SVALOR. Resposta vazia/ESC no INPUTBOX
1786:     * equivale ao ELSE do legado (.Value = .peAntValue): nada e alterado.
1787:     *--------------------------------------------------------------------------
1788:     PROCEDURE BtnAlteraCotacaoClick()
1789:         LOCAL loc_cResp, loc_nNovaCotacao
1790: 
1791:         loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ;
1792:             ALLTRIM(THIS.txt_4c_MOEDA.Value) + ":", ;
1793:             "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o", ;
1794:             TRANSFORM(THIS.txt_4c_COTACAO.Value))
1795: 
1796:         IF !EMPTY(loc_cResp)
1797:             loc_nNovaCotacao = VAL(loc_cResp)
1798:             IF loc_nNovaCotacao > 0
1799:                 THIS.txt_4c_COTACAO.Value = loc_nNovaCotacao
1800:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1801:                     THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
1802:                 ENDIF
1803:                 IF THIS.txt_4c_SCOTACAO.Value != 0
1804:                     THIS.txt_4c_SVALOR.Value = THIS.txt_4c_VALOR.Value * THIS.txt_4c_COTACAO.Value / THIS.txt_4c_SCOTACAO.Value
1805:                 ENDIF
1806:             ENDIF
1807:         ENDIF
1808:     ENDPROC
1809: 
1810:     PROCEDURE BtnAlteraSCotacaoClick()
1811:         LOCAL loc_cResp, loc_nNovaCotacao
1812: 
1813:         loc_cResp = INPUTBOX("Informe a nova cota" + CHR(231) + CHR(227) + "o para " + ;
1814:             ALLTRIM(THIS.txt_4c_Smoeda.Value) + ":", ;
1815:             "Altera" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(227) + "o", ;
1816:             TRANSFORM(THIS.txt_4c_SCOTACAO.Value))
1817: 
1818:         IF !EMPTY(loc_cResp)
1819:             loc_nNovaCotacao = VAL(loc_cResp)
1820:             IF loc_nNovaCotacao > 0
1821:                 THIS.txt_4c_SCOTACAO.Value = loc_nNovaCotacao
1822:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1823:                     THIS.this_oBusinessObject.this_cCotusus = gc_4c_UsuarioLogado
1824:                 ENDIF
1825:                 IF THIS.txt_4c_SCOTACAO.Value != 0
1826:                     THIS.txt_4c_SVALOR.Value = THIS.txt_4c_VALOR.Value * THIS.txt_4c_COTACAO.Value / THIS.txt_4c_SCOTACAO.Value
1827:                 ENDIF
1828:             ENDIF
1829:         ENDIF
1830:     ENDPROC
1831: 
1832:     *--------------------------------------------------------------------------
1833:     * BtnConfirmarClick - Cmd_Confirma.Click do legado. So valida campos
1834:     * obrigatorios em ALTERAR (o legado nao valida nada em INSERIR - o bloco
1835:     * de validacao do Click fica dentro de "if thisform.op_escolha =
1836:     * 'ALTERAR'"); em CONSULTAR o Confirmar so fecha (Enabled = .F. nesse
1837:     * modo via AtualizarEstadoControles, mas o guard fica aqui tambem, caso
1838:     * o botao seja acionado por teclado/outro caminho).
1839:     *--------------------------------------------------------------------------
1840:     PROCEDURE BtnConfirmarClick()
1841:         IF THIS.this_cModoAtual == "CONSULTAR"
1842:             THIS.Release()
1843:             RETURN
1844:         ENDIF
1845: 
1846:         IF THIS.this_cModoAtual == "ALTERAR" AND !THIS.ValidarCamposObrigatoriosConfirma()
1847:             RETURN
1848:         ENDIF
1849: 
1850:         THIS.SalvarLancamento()
1851:     ENDPROC
1852: 
1853:     *--------------------------------------------------------------------------
1854:     * ValidarCamposObrigatoriosConfirma - Transcricao literal do bloco de
1855:     * validacao no topo do Cmd_Confirma.Click legado (so roda em ALTERAR).
1856:     * Cada IsEmpty(...)/Messagebox(...)/SetFocus/Return do legado mapeia
1857:     * 1-para-1 para EMPTY(...)/MsgAviso(...)/SetFocus()/RETURN .F. - sem TRY
1858:     * em volta, o RETURN aqui nao viola a regra #1 do CLAUDE.md.
1859:     *--------------------------------------------------------------------------
1860:     PROTECTED FUNCTION ValidarCamposObrigatoriosConfirma()
1861:         IF EMPTY(THIS.txt_4c_Fweditdata_DATA.Value)
1862:             MsgAviso("Data Inv" + CHR(225) + "lida")
1863:             THIS.txt_4c_Fweditdata_DATA.SetFocus()
1864:             RETURN .F.
1865:         ENDIF
1866: 
1867:         IF !INLIST(ALLTRIM(THIS.txt_4c_OPER.Value), "D", "C")
1868:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!")
1869:             THIS.txt_4c_OPER.SetFocus()
1870:             RETURN .F.
1871:         ENDIF
1872: 
1873:         IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
1874:             MsgAviso("Grupo Inv" + CHR(225) + "lido")
1875:             THIS.txt_4c_Grupo.SetFocus()
1876:             RETURN .F.
1877:         ENDIF
1878: 
1879:         IF EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1880:             MsgAviso("Conta Inv" + CHR(225) + "lida")
1881:             THIS.txt_4c_Conta.SetFocus()
1882:             RETURN .F.
1883:         ENDIF
1884: 
1885:         IF EMPTY(ALLTRIM(THIS.txt_4c_MOEDA.Value))
1886:             MsgAviso("Moeda Inv" + CHR(225) + "lida")
1887:             THIS.txt_4c_MOEDA.SetFocus()
1888:             RETURN .F.
1889:         ENDIF
1890: 
1891:         IF EMPTY(THIS.txt_4c_VALOR.Value)
1892:             MsgAviso("Valor Inv" + CHR(225) + "lido")
1893:             THIS.txt_4c_VALOR.SetFocus()
1894:             RETURN .F.
1895:         ENDIF
1896: 
1897:         IF EMPTY(ALLTRIM(THIS.txt_4c_SGRUPO.Value))
1898:             MsgAviso("Grupo Inv" + CHR(225) + "lido")
1899:             THIS.txt_4c_SGRUPO.SetFocus()
1900:             RETURN .F.
1901:         ENDIF
1902: 
1903:         IF EMPTY(ALLTRIM(THIS.txt_4c_SCONTA.Value))
1904:             MsgAviso("Conta Inv" + CHR(225) + "lida")
1905:             THIS.txt_4c_SCONTA.SetFocus()
1906:             RETURN .F.
1907:         ENDIF
1908: 
1909:         IF EMPTY(ALLTRIM(THIS.txt_4c_Smoeda.Value))
1910:             MsgAviso("Moeda Inv" + CHR(225) + "lida")
1911:             THIS.txt_4c_Smoeda.SetFocus()
1912:             RETURN .F.
1913:         ENDIF
1914: 
1915:         IF EMPTY(THIS.txt_4c_SVALOR.Value)
1916:             MsgAviso("Valor Inv" + CHR(225) + "lido")
1917:             THIS.txt_4c_SVALOR.SetFocus()
1918:             RETURN .F.
1919:         ENDIF
1920: 
1921:         IF ALLTRIM(THIS.txt_4c_MOEDA.Value) == ALLTRIM(THIS.txt_4c_Smoeda.Value) AND ;
1922:            THIS.txt_4c_COTACAO.Value != THIS.txt_4c_SCOTACAO.Value
1923:             MsgAviso("Cota" + CHR(231) + CHR(227) + "o Inconsistente!")
1924:             THIS.txt_4c_MOEDA.SetFocus()
1925:             RETURN .F.
1926:         ENDIF
1927: 
1928:         RETURN .T.
1929:     ENDFUNC
1930: 
1931:     *--------------------------------------------------------------------------
1932:     * LocalizarCidContrapartida - Localiza, em SigMvCcr, a OUTRA linha do
1933:     * mesmo lancamento (mesmo Emps+Nopers, cidchaves diferente do principal)
1934:     * - a linha-espelho que o legado alcancava percorrendo CsLog/Craltcc
1935:     * pelo Nopers. Devolve "" quando o lancamento so tem a linha principal
1936:     * (nao ha contrapartida fisica a atualizar).
1937:     *--------------------------------------------------------------------------
1938:     PROTECTED FUNCTION LocalizarCidContrapartida()
1939:         LOCAL loc_cResultado, loc_cSQL
1940: 
1941:         loc_cResultado = ""
1942: 
1943:         IF USED("cursor_4c_ValContrapartida")
1944:             USE IN cursor_4c_ValContrapartida
1945:         ENDIF
1946: 
1947:         loc_cSQL = "SELECT TOP 1 cidchaves FROM SigMvCcr" + ;
1948:             " WHERE Emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
1949:             " AND Nopers = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNopers, 0) + ;
1950:             " AND cidchaves <> " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))
1951: 
1952:         SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValContrapartida")
1953: 
1954:         IF USED("cursor_4c_ValContrapartida") AND RECCOUNT("cursor_4c_ValContrapartida") > 0
1955:             loc_cResultado = ALLTRIM(cursor_4c_ValContrapartida.cidchaves)
1956:         ENDIF
1957: 
1958:         IF USED("cursor_4c_ValContrapartida")
1959:             USE IN cursor_4c_ValContrapartida
1960:         ENDIF
1961: 
1962:         RETURN loc_cResultado
1963:     ENDFUNC

*-- Linhas 1969 a 2048:
1969:     * (UPDATE in place nas duas linhas do lancamento, em vez do
1970:     * delete-tudo-e-recria-tudo do cursor buffered legado).
1971:     *--------------------------------------------------------------------------
1972:     PROTECTED PROCEDURE SalvarLancamento()
1973:         LOCAL loc_oBO, loc_oBOCtra, loc_oErro, loc_lOk, loc_lJaExibiu
1974:         LOCAL loc_cCidCtrapartida, loc_nValPagsD, loc_nValPagsC, loc_cTransacao
1975:         LOCAL loc_cGrupoAnt, loc_cContaAnt, loc_cMoedaAnt, loc_dDataAnt
1976:         LOCAL loc_cGrupoCAnt, loc_cContaCAnt, loc_cMoedaCAnt
1977: 
1978:         loc_lOk     = .F.
1979:         loc_oBO     = THIS.this_oBusinessObject
1980:         loc_oBOCtra = .NULL.
1981: 
1982:         TRY
1983:             IF INLIST(THIS.this_cModoAtual, "INSERIR", "INCLUIR")
1984:                 *-- Caminho teorico (legado nunca abre o dialogo assim -
1985:                 *-- nota da Fase 5): grava so a linha principal, sem
1986:                 *-- contrapartida nem recalculo de saldo de uma 2a linha
1987:                 *-- que nao existe.
1988:                 loc_lOk = THIS.FormParaBO()
1989:                 IF loc_lOk
1990:                     loc_lOk = loc_oBO.Salvar()
1991:                 ENDIF
1992:             ELSE
1993:                 *-- ALTERAR: combos ANTIGOS (antes da edicao), para
1994:                 *-- recalculo do saldo do que esta sendo substituido
1995:                 *-- (legado: fRecalculaS sobre CsLog, lido ANTES do Update/
1996:                 *-- Delete em SigMvCcr).
1997:                 loc_cGrupoAnt  = ALLTRIM(loc_oBO.this_cGrupos)
1998:                 loc_cContaAnt  = ALLTRIM(loc_oBO.this_cContas)
1999:                 loc_cMoedaAnt  = ALLTRIM(loc_oBO.this_cMoedas)
2000:                 loc_dDataAnt   = ConverterParaData(loc_oBO.this_dDatas)
2001:                 loc_cGrupoCAnt = ALLTRIM(loc_oBO.this_cSgrupos)
2002:                 loc_cContaCAnt = ALLTRIM(loc_oBO.this_cScontas)
2003:                 loc_cMoedaCAnt = ALLTRIM(loc_oBO.this_cSmoedas)
2004:                 loc_nValPagsD  = loc_oBO.this_nValpags
2005: 
2006:                 loc_cCidCtrapartida = THIS.LocalizarCidContrapartida()
2007:                 IF !EMPTY(loc_cCidCtrapartida)
2008:                     loc_oBOCtra = CREATEOBJECT("sigopaccBO")
2009:                     IF VARTYPE(loc_oBOCtra) = "O" AND loc_oBOCtra.CarregarPorChave(loc_cCidCtrapartida)
2010:                         loc_nValPagsC = loc_oBOCtra.this_nValpags
2011:                         loc_oBOCtra.EditarRegistro()
2012:                     ELSE
2013:                         loc_oBOCtra = .NULL.
2014:                     ENDIF
2015:                 ENDIF
2016: 
2017:                 loc_lOk = THIS.FormParaBO()
2018: 
2019:                 IF loc_lOk
2020:                     *-- ValPags da linha principal (regra #45 CLAUDE.md: o
2021:                     *-- flag Acerto ANTIGO x NOVO decide se zera ou mantem
2022:                     *-- o valor pago - legado: If OldContaPgs # crAltcc.
2023:                     *-- ContaPgs And nTpAltera = 0).
2024:                     IF THIS.this_nOldContaPgs != loc_oBO.this_nContapgs AND THIS.this_nTpAltera = 0
2025:                         loc_oBO.this_nValpags = IIF(THIS.this_nOldContaPgs = 2, 0, loc_oBO.this_nValors)
2026:                     ELSE
2027:                         loc_oBO.this_nValpags = loc_nValPagsD
2028:                     ENDIF
2029: 
2030:                     loc_lOk = loc_oBO.Salvar()
2031:                 ENDIF
2032: 
2033:                 IF loc_lOk AND VARTYPE(loc_oBOCtra) = "O"
2034:                     *-- Espelha os campos trocados na contrapartida (legado:
2035:                     *-- Scatter Memvar + troca D<->C antes do Append Blank).
2036:                     *-- Grupo/Conta emissor (grupems/contems) NAO trocam.
2037:                     loc_oBOCtra.this_cOpers     = loc_oBO.this_cSopers
2038:                     loc_oBOCtra.this_cGrupos    = loc_oBO.this_cSgrupos
2039:                     loc_oBOCtra.this_cContas    = loc_oBO.this_cScontas
2040:                     loc_oBOCtra.this_cMoedas    = loc_oBO.this_cSmoedas
2041:                     loc_oBOCtra.this_nCotacaos  = loc_oBO.this_nScotacaos
2042:                     loc_oBOCtra.this_nValors    = loc_oBO.this_nSvalors
2043:                     loc_oBOCtra.this_cSopers    = loc_oBO.this_cOpers
2044:                     loc_oBOCtra.this_cSgrupos   = loc_oBO.this_cGrupos
2045:                     loc_oBOCtra.this_cScontas   = loc_oBO.this_cContas
2046:                     loc_oBOCtra.this_cSmoedas   = loc_oBO.this_cMoedas
2047:                     loc_oBOCtra.this_nScotacaos = loc_oBO.this_nCotacaos
2048:                     loc_oBOCtra.this_nSvalors   = loc_oBO.this_nValors

*-- Linhas 2090 a 2531:
2090:         CATCH TO loc_oErro
2091:             MsgErro(loc_oErro.Message + CHR(13) + ;
2092:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2093:                 "Procedure: " + loc_oErro.Procedure, "Formsigopacc.SalvarLancamento")
2094:             loc_lOk = .F.
2095:         ENDTRY
2096: 
2097:         IF loc_lOk
2098:             THIS.Release()
2099:         ELSE
2100:             loc_lJaExibiu = (VARTYPE(loc_oBO) = "O" AND loc_oBO.this_lErroExibido) OR ;
2101:                 (VARTYPE(loc_oBOCtra) = "O" AND loc_oBOCtra.this_lErroExibido)
2102:             IF !loc_lJaExibiu
2103:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
2104:             ENDIF
2105:         ENDIF
2106:     ENDPROC
2107: 
2108:     *--------------------------------------------------------------------------
2109:     * ValidarGrupo / ValidarDgrupo - LostFocus de txt_4c_Grupo/txt_4c_Dgrupo
2110:     * (legado: Get_grupo.Valid / Get_dgrupo.Valid). fAcessoContab resolve a
2111:     * descricao (ou a abertura do picker quando o codigo nao existe); o
2112:     * legado nao verifica o retorno nem exibe mensagem de erro para este par.
2113:     *--------------------------------------------------------------------------
2114:     PROCEDURE ValidarGrupo()
2115:         LOCAL loc_cValor
2116:         loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
2117: 
2118:         IF loc_cValor == THIS.this_cUltimoGrupoValidado
2119:             RETURN
2120:         ENDIF
2121:         THIS.this_cUltimoGrupoValidado = loc_cValor
2122: 
2123:         IF !EMPTY(loc_cValor)
2124:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
2125:                 THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
2126:             THIS.this_cUltimoGrupoValidado = ALLTRIM(THIS.txt_4c_Grupo.Value)
2127:         ELSE
2128:             THIS.txt_4c_Dgrupo.Value = ""
2129:         ENDIF
2130: 
2131:         THIS.AtualizarEstadoControles()
2132:     ENDPROC
2133: 
2134:     PROCEDURE ValidarDgrupo()
2135:         LOCAL loc_cValor
2136:         loc_cValor = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
2137: 
2138:         IF loc_cValor == THIS.this_cUltimoDgrupoValidado
2139:             RETURN
2140:         ENDIF
2141:         THIS.this_cUltimoDgrupoValidado = loc_cValor
2142: 
2143:         IF !EMPTY(loc_cValor)
2144:             fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
2145:                 THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, THIS.txt_4c_Conta.Value)
2146:             THIS.this_cUltimoDgrupoValidado = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
2147:             THIS.this_cUltimoGrupoValidado  = ALLTRIM(THIS.txt_4c_Grupo.Value)
2148:         ELSE
2149:             THIS.txt_4c_Grupo.Value = ""
2150:         ENDIF
2151: 
2152:         THIS.AtualizarEstadoControles()
2153:     ENDPROC
2154: 
2155:     *--------------------------------------------------------------------------
2156:     * ValidarConta / ValidarDconta - LostFocus de txt_4c_Conta/txt_4c_Dconta
2157:     * (legado: Get_conta.Valid / Get_dconta.Valid). fAcessoContas devolve
2158:     * .F. quando o acesso eh negado - so ai o legado avisa e limpa os dois
2159:     * campos (codigo + descricao).
2160:     *--------------------------------------------------------------------------
2161:     PROCEDURE ValidarConta()
2162:         LOCAL loc_cValor, loc_cGrupo
2163:         loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)
2164: 
2165:         IF loc_cValor == THIS.this_cUltimaContaValidada
2166:             RETURN
2167:         ENDIF
2168:         THIS.this_cUltimaContaValidada = loc_cValor
2169: 
2170:         IF EMPTY(loc_cValor)
2171:             THIS.txt_4c_Dconta.Value = ""
2172:             RETURN
2173:         ENDIF
2174: 
2175:         loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
2176:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
2177:             MsgErro("Acesso Negado !!", "Aviso")
2178:             THIS.txt_4c_Conta.Value  = ""
2179:             THIS.txt_4c_Dconta.Value = ""
2180:             THIS.this_cUltimaContaValidada = ""
2181:         ELSE
2182:             THIS.this_cUltimaContaValidada = ALLTRIM(THIS.txt_4c_Conta.Value)
2183:         ENDIF
2184:     ENDPROC
2185: 
2186:     PROCEDURE ValidarDconta()
2187:         LOCAL loc_cValor, loc_cGrupo
2188:         loc_cValor = ALLTRIM(THIS.txt_4c_Dconta.Value)
2189: 
2190:         IF loc_cValor == THIS.this_cUltimoDcontaValidado
2191:             RETURN
2192:         ENDIF
2193:         THIS.this_cUltimoDcontaValidado = loc_cValor
2194: 
2195:         IF EMPTY(loc_cValor)
2196:             THIS.txt_4c_Conta.Value = ""
2197:             RETURN
2198:         ENDIF
2199: 
2200:         loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
2201:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c_Conta, THIS.txt_4c_Dconta)
2202:             MsgErro("Acesso Negado !!", "Aviso")
2203:             THIS.txt_4c_Conta.Value  = ""
2204:             THIS.txt_4c_Dconta.Value = ""
2205:             THIS.this_cUltimoDcontaValidado = ""
2206:         ELSE
2207:             THIS.this_cUltimoDcontaValidado = ALLTRIM(THIS.txt_4c_Dconta.Value)
2208:             THIS.this_cUltimaContaValidada  = ALLTRIM(THIS.txt_4c_Conta.Value)
2209:         ENDIF
2210:     ENDPROC
2211: 
2212:     *--------------------------------------------------------------------------
2213:     * ValidarSGrupo / ValidarSdgrupo - espelho de ValidarGrupo/ValidarDgrupo
2214:     * para a contrapartida (legado: Get_SGRUPO.Valid / Get_sdgrupo.Valid)
2215:     *--------------------------------------------------------------------------
2216:     PROCEDURE ValidarSGrupo()
2217:         LOCAL loc_cValor
2218:         loc_cValor = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
2219: 
2220:         IF loc_cValor == THIS.this_cUltimoSGrupoValidado
2221:             RETURN
2222:         ENDIF
2223:         THIS.this_cUltimoSGrupoValidado = loc_cValor
2224: 
2225:         IF !EMPTY(loc_cValor)
2226:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
2227:                 THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
2228:             THIS.this_cUltimoSGrupoValidado = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
2229:         ELSE
2230:             THIS.txt_4c_Sdgrupo.Value = ""
2231:         ENDIF
2232: 
2233:         THIS.AtualizarEstadoControles()
2234:     ENDPROC
2235: 
2236:     PROCEDURE ValidarSdgrupo()
2237:         LOCAL loc_cValor
2238:         loc_cValor = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
2239: 
2240:         IF loc_cValor == THIS.this_cUltimoSdgrupoValidado
2241:             RETURN
2242:         ENDIF
2243:         THIS.this_cUltimoSdgrupoValidado = loc_cValor
2244: 
2245:         IF !EMPTY(loc_cValor)
2246:             fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
2247:                 THIS.txt_4c_SGRUPO, THIS.txt_4c_Sdgrupo, THIS.txt_4c_SCONTA.Value)
2248:             THIS.this_cUltimoSdgrupoValidado = ALLTRIM(THIS.txt_4c_Sdgrupo.Value)
2249:             THIS.this_cUltimoSGrupoValidado  = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
2250:         ELSE
2251:             THIS.txt_4c_SGRUPO.Value = ""
2252:         ENDIF
2253: 
2254:         THIS.AtualizarEstadoControles()
2255:     ENDPROC
2256: 
2257:     *--------------------------------------------------------------------------
2258:     * ValidarSConta / ValidarSDConta - espelho de ValidarConta/ValidarDconta
2259:     * para a contrapartida (legado: Get_SCONTA.Valid / Get_SDCONTA.Valid)
2260:     *--------------------------------------------------------------------------
2261:     PROCEDURE ValidarSConta()
2262:         LOCAL loc_cValor, loc_cGrupo
2263:         loc_cValor = ALLTRIM(THIS.txt_4c_SCONTA.Value)
2264: 
2265:         IF loc_cValor == THIS.this_cUltimaSContaValidada
2266:             RETURN
2267:         ENDIF
2268:         THIS.this_cUltimaSContaValidada = loc_cValor
2269: 
2270:         IF EMPTY(loc_cValor)
2271:             THIS.txt_4c_SDCONTA.Value = ""
2272:             RETURN
2273:         ENDIF
2274: 
2275:         loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
2276:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
2277:             MsgErro("Acesso Negado !!", "Aviso")
2278:             THIS.txt_4c_SCONTA.Value  = ""
2279:             THIS.txt_4c_SDCONTA.Value = ""
2280:             THIS.this_cUltimaSContaValidada = ""
2281:         ELSE
2282:             THIS.this_cUltimaSContaValidada = ALLTRIM(THIS.txt_4c_SCONTA.Value)
2283:         ENDIF
2284:     ENDPROC
2285: 
2286:     PROCEDURE ValidarSDConta()
2287:         LOCAL loc_cValor, loc_cGrupo
2288:         loc_cValor = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
2289: 
2290:         IF loc_cValor == THIS.this_cUltimoSdcontaValidado
2291:             RETURN
2292:         ENDIF
2293:         THIS.this_cUltimoSdcontaValidado = loc_cValor
2294: 
2295:         IF EMPTY(loc_cValor)
2296:             THIS.txt_4c_SCONTA.Value = ""
2297:             RETURN
2298:         ENDIF
2299: 
2300:         loc_cGrupo = ALLTRIM(THIS.txt_4c_SGRUPO.Value)
2301:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c_SCONTA, THIS.txt_4c_SDCONTA)
2302:             MsgErro("Acesso Negado !!", "Aviso")
2303:             THIS.txt_4c_SCONTA.Value  = ""
2304:             THIS.txt_4c_SDCONTA.Value = ""
2305:             THIS.this_cUltimoSdcontaValidado = ""
2306:         ELSE
2307:             THIS.this_cUltimoSdcontaValidado = ALLTRIM(THIS.txt_4c_SDCONTA.Value)
2308:             THIS.this_cUltimaSContaValidada  = ALLTRIM(THIS.txt_4c_SCONTA.Value)
2309:         ENDIF
2310:     ENDPROC
2311: 
2312:     *--------------------------------------------------------------------------
2313:     * ValidarGrupEms / ValidarDGrupEms - grupo emissor (legado:
2314:     * get_GrupEms.Valid / get_DGrupEms.Valid) - mesmo padrao de
2315:     * ValidarGrupo/ValidarDgrupo, sem o campo de conta como pCta (o legado
2316:     * passa Thisform.get_contems.value no lugar de get_conta.value aqui).
2317:     *--------------------------------------------------------------------------
2318:     PROCEDURE ValidarGrupEms()
2319:         LOCAL loc_cValor
2320:         loc_cValor = ALLTRIM(THIS.txt_4c__GrupEms.Value)
2321: 
2322:         IF loc_cValor == THIS.this_cUltimoGrupEmsValidado
2323:             RETURN
2324:         ENDIF
2325:         THIS.this_cUltimoGrupEmsValidado = loc_cValor
2326: 
2327:         IF !EMPTY(loc_cValor)
2328:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_cValor, ;
2329:                 THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
2330:             THIS.this_cUltimoGrupEmsValidado = ALLTRIM(THIS.txt_4c__GrupEms.Value)
2331:         ELSE
2332:             THIS.txt_4c__DGrupEms.Value = ""
2333:         ENDIF
2334: 
2335:         THIS.AtualizarEstadoControles()
2336:     ENDPROC
2337: 
2338:     PROCEDURE ValidarDGrupEms()
2339:         LOCAL loc_cValor
2340:         loc_cValor = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
2341: 
2342:         IF loc_cValor == THIS.this_cUltimoDGrupEmsValidado
2343:             RETURN
2344:         ENDIF
2345:         THIS.this_cUltimoDGrupEmsValidado = loc_cValor
2346: 
2347:         IF !EMPTY(loc_cValor)
2348:             fAcessoContab(gc_4c_UsuarioLogado, "D", loc_cValor, ;
2349:                 THIS.txt_4c__GrupEms, THIS.txt_4c__DGrupEms, THIS.txt_4c__ContEms.Value)
2350:             THIS.this_cUltimoDGrupEmsValidado = ALLTRIM(THIS.txt_4c__DGrupEms.Value)
2351:             THIS.this_cUltimoGrupEmsValidado  = ALLTRIM(THIS.txt_4c__GrupEms.Value)
2352:         ELSE
2353:             THIS.txt_4c__GrupEms.Value = ""
2354:         ENDIF
2355: 
2356:         THIS.AtualizarEstadoControles()
2357:     ENDPROC
2358: 
2359:     *--------------------------------------------------------------------------
2360:     * ValidarContEms / ValidarDContEms - conta emissor (legado:
2361:     * get_ContEms.Valid / get_DContEms.Valid) - mesmo padrao de
2362:     * ValidarConta/ValidarDconta, filtrado pelo grupo emissor.
2363:     *--------------------------------------------------------------------------
2364:     PROCEDURE ValidarContEms()
2365:         LOCAL loc_cValor, loc_cGrupo
2366:         loc_cValor = ALLTRIM(THIS.txt_4c__ContEms.Value)
2367: 
2368:         IF loc_cValor == THIS.this_cUltimoContEmsValidado
2369:             RETURN
2370:         ENDIF
2371:         THIS.this_cUltimoContEmsValidado = loc_cValor
2372: 
2373:         IF EMPTY(loc_cValor)
2374:             THIS.txt_4c__DContEms.Value = ""
2375:             RETURN
2376:         ENDIF
2377: 
2378:         loc_cGrupo = ALLTRIM(THIS.txt_4c__GrupEms.Value)
2379:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cValor, THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
2380:             MsgErro("Acesso Negado !!", "Aviso")
2381:             THIS.txt_4c__ContEms.Value  = ""
2382:             THIS.txt_4c__DContEms.Value = ""
2383:             THIS.this_cUltimoContEmsValidado = ""
2384:         ELSE
2385:             THIS.this_cUltimoContEmsValidado = ALLTRIM(THIS.txt_4c__ContEms.Value)
2386:         ENDIF
2387:     ENDPROC
2388: 
2389:     PROCEDURE ValidarDContEms()
2390:         LOCAL loc_cValor, loc_cGrupo
2391:         loc_cValor = ALLTRIM(THIS.txt_4c__DContEms.Value)
2392: 
2393:         IF loc_cValor == THIS.this_cUltimoDContEmsValidado
2394:             RETURN
2395:         ENDIF
2396:         THIS.this_cUltimoDContEmsValidado = loc_cValor
2397: 
2398:         IF EMPTY(loc_cValor)
2399:             THIS.txt_4c__ContEms.Value = ""
2400:             RETURN
2401:         ENDIF
2402: 
2403:         loc_cGrupo = ALLTRIM(THIS.txt_4c__GrupEms.Value)
2404:         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cValor, THIS.txt_4c__ContEms, THIS.txt_4c__DContEms)
2405:             MsgErro("Acesso Negado !!", "Aviso")
2406:             THIS.txt_4c__ContEms.Value  = ""
2407:             THIS.txt_4c__DContEms.Value = ""
2408:             THIS.this_cUltimoDContEmsValidado = ""
2409:         ELSE
2410:             THIS.this_cUltimoDContEmsValidado = ALLTRIM(THIS.txt_4c__DContEms.Value)
2411:             THIS.this_cUltimoContEmsValidado  = ALLTRIM(THIS.txt_4c__ContEms.Value)
2412:         ENDIF
2413:     ENDPROC
2414: 
2415:     *--------------------------------------------------------------------------
2416:     * ValidarJob / ValidarDJob - LostFocus de txt_4c_Job/txt_4c_DJob (legado:
2417:     * getJob.Valid / getDJob.Valid). Grupo = '' - o legado nao restringe o
2418:     * job por grupo contabil.
2419:     *--------------------------------------------------------------------------
2420:     PROCEDURE ValidarJob()
2421:         LOCAL loc_cValor
2422:         loc_cValor = ALLTRIM(THIS.txt_4c_Job.Value)
2423: 
2424:         IF loc_cValor == THIS.this_cUltimoJobValidado
2425:             RETURN
2426:         ENDIF
2427:         THIS.this_cUltimoJobValidado = loc_cValor
2428: 
2429:         IF EMPTY(loc_cValor)
2430:             THIS.txt_4c_DJob.Value = ""
2431:             RETURN
2432:         ENDIF
2433: 
2434:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, THIS.txt_4c_Job, THIS.txt_4c_DJob)
2435:             MsgErro("Acesso Negado!!!", "Aviso")
2436:             THIS.txt_4c_Job.Value  = ""
2437:             THIS.txt_4c_DJob.Value = ""
2438:             THIS.this_cUltimoJobValidado = ""
2439:         ELSE
2440:             THIS.this_cUltimoJobValidado = ALLTRIM(THIS.txt_4c_Job.Value)
2441:         ENDIF
2442:     ENDPROC
2443: 
2444:     PROCEDURE ValidarDJob()
2445:         LOCAL loc_cValor
2446:         loc_cValor = ALLTRIM(THIS.txt_4c_DJob.Value)
2447: 
2448:         IF loc_cValor == THIS.this_cUltimoDJobValidado
2449:             RETURN
2450:         ENDIF
2451:         THIS.this_cUltimoDJobValidado = loc_cValor
2452: 
2453:         IF EMPTY(loc_cValor)
2454:             THIS.txt_4c_Job.Value = ""
2455:             RETURN
2456:         ENDIF
2457: 
2458:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, THIS.txt_4c_Job, THIS.txt_4c_DJob)
2459:             MsgErro("Acesso Negado!!!", "Aviso")
2460:             THIS.txt_4c_Job.Value  = ""
2461:             THIS.txt_4c_DJob.Value = ""
2462:             THIS.this_cUltimoDJobValidado = ""
2463:         ELSE
2464:             THIS.this_cUltimoDJobValidado = ALLTRIM(THIS.txt_4c_DJob.Value)
2465:             THIS.this_cUltimoJobValidado  = ALLTRIM(THIS.txt_4c_Job.Value)
2466:         ENDIF
2467:     ENDPROC
2468: 
2469:     *--------------------------------------------------------------------------
2470:     * ValidarMoeda / ValidarSmoeda - LostFocus de txt_4c_MOEDA/txt_4c_Smoeda
2471:     * (legado: Get_MOEDA.Valid / Get_smoeda.Valid)
2472:     *--------------------------------------------------------------------------
2473:     PROCEDURE ValidarMoeda()
2474:         THIS.ProcessarMudancaMoeda("D")
2475:     ENDPROC
2476: 
2477:     PROCEDURE ValidarSmoeda()
2478:         THIS.ProcessarMudancaMoeda("S")
2479:     ENDPROC
2480: 
2481:     *--------------------------------------------------------------------------
2482:     * ProcessarMudancaMoeda - nucleo comum do Valid de Moeda/SMoeda. Resolve
2483:     * a cotacao vigente em SigCdCot na data do lancamento, espelha moeda e
2484:     * cotacao para o lado vazio, recalcula o SValor e atualiza a
2485:     * visibilidade dos campos de cambio (this_lMoedaTemCotas/
2486:     * this_lSMoedaTemCotas, lidos por AtualizarEstadoControles). O legado
2487:     * tambem condiciona o botao "$" a crSigCdCrg.AltCots do cargo do
2488:     * usuario - cache que nao existe nesta arquitetura (mesma simplificacao
2489:     * de Formsigmvccr.ProcessarMudancaMoeda).
2490:     *--------------------------------------------------------------------------
2491:     PROTECTED PROCEDURE ProcessarMudancaMoeda(par_cLado)
2492:         LOCAL loc_cValor, loc_lCotas, loc_dData, loc_nCotacao
2493: 
2494:         IF par_cLado == "D"
2495:             loc_cValor = ALLTRIM(THIS.txt_4c_MOEDA.Value)
2496:             IF loc_cValor == THIS.this_cUltimaMoedaValidada
2497:                 RETURN
2498:             ENDIF
2499:             THIS.this_cUltimaMoedaValidada = loc_cValor
2500:         ELSE
2501:             loc_cValor = ALLTRIM(THIS.txt_4c_Smoeda.Value)
2502:             IF loc_cValor == THIS.this_cUltimaSMoedaValidada
2503:                 RETURN
2504:             ENDIF
2505:             THIS.this_cUltimaSMoedaValidada = loc_cValor
2506:         ENDIF
2507: 
2508:         IF EMPTY(loc_cValor)
2509:             RETURN
2510:         ENDIF
2511: 
2512:         IF USED("cursor_4c_ValMoe")
2513:             USE IN cursor_4c_ValMoe
2514:         ENDIF
2515:         SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor), "cursor_4c_ValMoe")
2516: 
2517:         IF !USED("cursor_4c_ValMoe") OR RECCOUNT("cursor_4c_ValMoe") = 0
2518:             IF USED("cursor_4c_ValMoe")
2519:                 USE IN cursor_4c_ValMoe
2520:             ENDIF
2521:             IF par_cLado == "D"
2522:                 THIS.AbrirLookupMoeda()
2523:             ELSE
2524:                 THIS.AbrirLookupSMoeda()
2525:             ENDIF
2526:             RETURN
2527:         ENDIF
2528: 
2529:         loc_lCotas = ConverterParaLogico(cursor_4c_ValMoe.Cotas)
2530:         loc_cValor = ALLTRIM(cursor_4c_ValMoe.CMoes)
2531:         USE IN cursor_4c_ValMoe

*-- Linhas 2582 a 2673:
2582: 
2583:     *--------------------------------------------------------------------------
2584:     * AbrirLookupMoeda / AbrirLookupSMoeda - legado usa fwBuscaSel em
2585:     * crSigCdMoe (CMoes/DMoes); aqui FormBuscaAuxiliar sobre SigCdMoe.
2586:     *--------------------------------------------------------------------------
2587:     PROCEDURE AbrirLookupMoeda()
2588:         LOCAL loc_oBusca
2589: 
2590:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2591:             "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
2592:             ALLTRIM(THIS.txt_4c_MOEDA.Value), "Moedas")
2593: 
2594:         IF VARTYPE(loc_oBusca) = "O"
2595:             IF !loc_oBusca.this_lAchouRegistro
2596:                 loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2597:                 loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2598:                 loc_oBusca.Show()
2599:             ENDIF
2600: 
2601:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2602:                 THIS.txt_4c_MOEDA.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2603:             ELSE
2604:                 THIS.txt_4c_MOEDA.Value = ""
2605:             ENDIF
2606: 
2607:             loc_oBusca.Release()
2608:         ENDIF
2609: 
2610:         IF USED("cursor_4c_BuscaMoeda")
2611:             USE IN cursor_4c_BuscaMoeda
2612:         ENDIF
2613: 
2614:         THIS.this_cUltimaMoedaValidada = ALLTRIM(THIS.txt_4c_MOEDA.Value)
2615:     ENDPROC
2616: 
2617:     PROCEDURE AbrirLookupSMoeda()
2618:         LOCAL loc_oBusca
2619: 
2620:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2621:             "SigCdMoe", "cursor_4c_BuscaSMoeda", "CMoes", ;
2622:             ALLTRIM(THIS.txt_4c_Smoeda.Value), "Moedas")
2623: 
2624:         IF VARTYPE(loc_oBusca) = "O"
2625:             IF !loc_oBusca.this_lAchouRegistro
2626:                 loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2627:                 loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2628:                 loc_oBusca.Show()
2629:             ENDIF
2630: 
2631:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSMoeda")
2632:                 THIS.txt_4c_Smoeda.Value = ALLTRIM(cursor_4c_BuscaSMoeda.CMoes)
2633:             ELSE
2634:                 THIS.txt_4c_Smoeda.Value = ""
2635:             ENDIF
2636: 
2637:             loc_oBusca.Release()
2638:         ENDIF
2639: 
2640:         IF USED("cursor_4c_BuscaSMoeda")
2641:             USE IN cursor_4c_BuscaSMoeda
2642:         ENDIF
2643: 
2644:         THIS.this_cUltimaSMoedaValidada = ALLTRIM(THIS.txt_4c_Smoeda.Value)
2645:     ENDPROC
2646: 
2647:     *--------------------------------------------------------------------------
2648:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2649:     * (AddObject cria controles com Visible=.F. por padrao)
2650:     *--------------------------------------------------------------------------
2651:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2652:         LOCAL loc_i, loc_oCtrl
2653: 
2654:         FOR loc_i = 1 TO par_oContainer.ControlCount
2655:             loc_oCtrl = par_oContainer.Controls(loc_i)
2656:             IF VARTYPE(loc_oCtrl) = "O"
2657:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
2658:                     loc_oCtrl.Visible = .T.
2659:                 ENDIF
2660:                 IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
2661:                     LOCAL loc_p
2662:                     FOR loc_p = 1 TO loc_oCtrl.PageCount
2663:                         THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
2664:                     ENDFOR
2665:                 ENDIF
2666:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
2667:                     THIS.TornarControlesVisiveis(loc_oCtrl)
2668:                 ENDIF
2669:             ENDIF
2670:         ENDFOR
2671:     ENDPROC
2672: 
2673: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopaccBO.prg):
*============================================================================
* sigopaccBO.prg - Business Object para Lancamento de Conta Corrente
*
* Tabela principal : SigMvCcr  (PK: cidchaves char(20))
* Lookup grupo/conta: SigCdGrp / SigCdCta (ou equivalentes, grupo+conta normal e contrapartida)
* Lookup emissor    : SigCdGrp / SigCdCta (GrupEms / ContEms)
* Lookup job         : SigCdJob (ou equivalente)
* Lookup moeda       : SigCdMoe
*
* Este BO suporta um dialogo OPERACIONAL de ALTERACAO de um lancamento
* ja existente de SigMvCcr (edicao pontual de um registro de movimento de
* conta corrente), espelhando o comportamento do legado SIGOPACC.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopaccBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigMvCcr (campos do banco - chave e dados)
    *==========================================================================
    this_cCidchaves = ""   && char(20)      - Chave primaria (PK, fUniqueIds())
    this_dDatas      = {}  && datetime NULL - Data do lancamento
    this_cOpers      = ""  && char(1)       - Operacao (D/C)
    this_cDocus      = ""  && char(10)      - Documento
    this_cNfs        = ""  && char(10)      - Nota Fiscal
    this_nValors     = 0   && numeric(11,2) - Valor
    this_nCotacaos   = 0   && numeric(15,7) - Cotacao
    this_dVencs      = {}  && datetime NULL - Vencimento
    this_cHists      = ""  && char(60)      - Historico
    this_cHist2s     = ""  && char(80)      - Historico complementar
    this_cSopers     = ""  && char(1)       - Operacao contrapartida (D/C)
    this_nSvalors    = 0   && numeric(11,2) - Valor contrapartida
    this_nScotacaos  = 0   && numeric(15,7) - Cotacao contrapartida
    this_cGrupos     = ""  && char(10)      - Grupo
    this_cContas     = ""  && char(10)      - Conta
    this_cSgrupos    = ""  && char(10)      - Grupo contrapartida
    this_cScontas    = ""  && char(10)      - Conta contrapartida
    this_cMoedas     = ""  && char(3)       - Moeda
    this_cSmoedas    = ""  && char(3)       - Moeda contrapartida
    this_cGrupems    = ""  && char(10)      - Grupo emissor
    this_cContems    = ""  && char(10)      - Conta emissor
    this_cJobs       = ""  && char(10)      - Job
    this_nContapgs   = 0   && numeric(1,0)  - Conta a Pagar (flag/opcao do lancamento original)
    this_cCotusus    = ""  && char(10)      - Usuario que alterou a cotacao

    *==========================================================================
    * Propriedades das demais colunas de SigMvCcr (nao editadas na tela, mas
    * obrigatorias no INSERT - regra #22 CLAUDE.md: INSERT cobre TODA coluna
    * NOT NULL). Nomeadas como as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_dDatalts    = {}   && datetime NULL - datalts (data de alteracao)
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps (empresa)
    this_cGrupages   = ""   && char(10)      - grupages
    this_cLocals     = ""   && char(10)      - locals
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers (numero da operacao)
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cShists     = ""   && char(40)      - shists
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts (usuario que alterou)
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (posicional: emps+dopes+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (posicional: emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos (0/1 conforme valors = valpags)
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
    this_nImpostos   = 0    && numeric(11,2) - impostos
    this_nTpimpostos = 0    && numeric(2,0)  - tpimpostos
    this_cTitpais    = ""   && char(10)      - titpais
    this_cEmpccs     = ""   && char(3)       - empccs
    this_nRecor      = 0    && numeric(1,0)  - recor
    this_cCompet     = ""   && char(7)       - compet
    this_cEmpos      = ""   && char(3)       - empos
    this_cOridopnums = ""   && char(29)      - oridopnums
    this_cPastas     = ""   && text NULL     - pastas
    this_cRcontas    = ""   && char(10)      - rcontas
    this_cTpdocnf    = ""   && char(2)       - tpdocnf

    *==========================================================================
    * Propriedades de controle da tela - nao persistidas diretamente
    *==========================================================================
    this_cUsuario     = ""  && Usuario corrente exibido no cabecalho (auditoria)
    this_nOpcaoConta  = 0   && OptionGroup Acerto (D/C) - indice 1-based

    *==========================================================================
    * Propriedades de exibicao (descricoes de lookup) - nao armazenadas no banco
    *==========================================================================
    this_cDescGrupo    = ""  && Descricao do Grupo (this_cGrupos)
    this_cDescConta    = ""  && Descricao da Conta (this_cContas)
    this_cDescSGrupo   = ""  && Descricao do Grupo contrapartida (this_cSgrupos)
    this_cDescSConta   = ""  && Descricao da Conta contrapartida (this_cScontas)
    this_cDescGrupEms  = ""  && Descricao do Grupo emissor (this_cGrupems)
    this_cDescContEms  = ""  && Descricao da Conta emissor (this_cContems)
    this_cDescJob      = ""  && Descricao do Job (this_cJobs)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigMvCcr")
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso em
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Le UM lancamento de SigMvCcr pela PK (cidchaves) e
    * popula as propriedades do BO atraves de CarregarDoCursor().
    *
    * No legado o registro ja chegava posicionado: o form pai mantinha o cursor
    * crAltcc e o SIGOPACC lia tudo por ControlSource. A arquitetura nova nao
    * compartilha cursor entre telas, entao quem abre o dialogo passa a PK e o
    * BO busca o registro.
    *
    * SQLEXEC direto (mesmo estilo de Inserir/Atualizar deste BO) em vez do
    * Buscar() herdado: aqui o nome do cursor e EXPLICITO, em vez de depender
    * do default interno do DataAccess ("cur" + tabela).
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
                THIS.this_cMensagemErro = "Chave do lan" + CHR(231) + "amento n" + CHR(227) + "o informada."
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                    " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao ler o lan" + CHR(231) + "amento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "sigopaccBO.CarregarPorChave")
                    THIS.this_lErroExibido = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") = 0
                        THIS.this_cMensagemErro = "Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado."
                    ELSE
                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Dados")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "sigopaccBO.CarregarPorChave")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cContems = TratarNulo(contems, "")
                THIS.this_nCotacaos = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts = TratarNulo(datalts, {})
                THIS.this_dDatas = TratarNulo(datas, {})
                THIS.this_dDataconcs = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
                THIS.this_dDatexcs = TratarNulo(datexcs, {})
                THIS.this_cDocus = TratarNulo(docus, "")
                THIS.this_cDopes = TratarNulo(dopes, "")
                THIS.this_dDtemis = TratarNulo(dtemis, {})
                THIS.this_cEmps = TratarNulo(emps, "")
                THIS.this_cGrupages = TratarNulo(grupages, "")
                THIS.this_cGrupems = TratarNulo(grupems, "")
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cHists = TratarNulo(hists, "")
                THIS.this_cLocals = TratarNulo(locals, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_cNfs = TratarNulo(nfs, "")
                THIS.this_nNlancs = TratarNulo(nlancs, 0)
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nNtrans = TratarNulo(ntrans, 0)
                THIS.this_nNumes = TratarNulo(numes, 0)
                THIS.this_cOpers = TratarNulo(opers, "")
                THIS.this_nSaldocs = TratarNulo(saldocs, 0)
                THIS.this_nSaldons = TratarNulo(saldons, 0)
                THIS.this_nSaldos = TratarNulo(saldos, 0)
                THIS.this_cScontas = TratarNulo(scontas, "")
                THIS.this_nScotacaos = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos = TratarNulo(sgrupos, "")
                THIS.this_cShists = TratarNulo(shists, "")
                THIS.this_cSmoedas = TratarNulo(smoedas, "")
                THIS.this_cSopers = TratarNulo(sopers, "")
                THIS.this_nSvalors = TratarNulo(svalors, 0)
                THIS.this_cTipos = TratarNulo(tipos, "")
                THIS.this_cTitbans = TratarNulo(titbans, "")
                THIS.this_cTitulos = TratarNulo(titulos, "")
                THIS.this_cUsualts = TratarNulo(usualts, "")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "")
                THIS.this_nValliqs = TratarNulo(valliqs, 0)
                THIS.this_nValocurs = TratarNulo(valocurs, 0)
                THIS.this_nValors = TratarNulo(valors, 0)
                THIS.this_nValpags = TratarNulo(valpags, 0)
                THIS.this_dVencs = TratarNulo(vencs, {})
                THIS.this_cVlancs = TratarNulo(vlancs, "")
                THIS.this_cVopers = TratarNulo(vopers, "")
                THIS.this_nContapgs = TratarNulo(contapgs, 0)
                THIS.this_cDopcs = TratarNulo(dopcs, "")
                THIS.this_nNumcs = TratarNulo(numcs, 0)
                THIS.this_cCotusus = TratarNulo(cotusus, "")
                THIS.this_cBcontas = TratarNulo(bcontas, "")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "")
                THIS.this_nBorderos = TratarNulo(borderos, 0)
                THIS.this_cHist2s = TratarNulo(hist2s, "")
                THIS.this_nIntconts = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "")
                THIS.this_cAuditors = TratarNulo(auditors, "")
                THIS.this_dDtaudits = TratarNulo(dtaudits, {})
                THIS.this_nValprev = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos = TratarNulo(pagos, "")
                THIS.this_cDopotps = TratarNulo(dopotps, "")
                THIS.this_cUsupagos = TratarNulo(usupagos, "")
                THIS.this_nTitcancs = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs = TratarNulo(jobs, "")
                THIS.this_nImpostos = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais = TratarNulo(titpais, "")
                THIS.this_cEmpccs = TratarNulo(empccs, "")
                THIS.this_nRecor = TratarNulo(recor, 0)
                THIS.this_cCompet = TratarNulo(compet, "")
                THIS.this_cEmpos = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas = TratarNulo(pastas, "")
                THIS.this_cRcontas = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo lancamento em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = gc_4c_UsuarioLogado
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

