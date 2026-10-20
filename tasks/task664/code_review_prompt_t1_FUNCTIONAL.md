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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1699 linhas total):

*-- Linhas 32 a 87:
32: *   e' escopado por data session privada. Replicar o SET DATASESSION sem um
33: *   cursor compartilhado para proteger seria copiar sintaxe sem a razao que a
34: *   justifica.
35: *   "poDataMgr = CreateObject('fSqlConector', ...)" - cada form legado cria a
36: *   propria conexao; na arquitetura nova a conexao e' UNICA e global
37: *   (gnConnHandle, aberta uma vez no startup por start\config.prg) - por isso
38: *   sigprpdfBO.ObterDadosContaEmail usa gnConnHandle direto, sem objeto de
39: *   conexao proprio por form.
40: *
41: * Historico de fases:
42: *   Fase 1/2: sigprpdfBO.prg (propriedades + metodos de negocio completos)
43: *   Fase 3:   Formsigprpdf.prg - estrutura base (heranca, propriedades
44: *             visuais, Init recebendo par_oFormPai/par_cAssunto,
45: *             InicializarForm criando o BO/validando conexao/resolvendo
46: *             this_cDiretorio, ConfigurarCabecalho equivalente ao cntSombra,
47: *             TornarControlesVisiveis, Destroy). A colisao de Height
48: *             (ThisForm.Height = This.Height - This.CtnSaida_Email.Height,
49: *             equivalente ao colapso do bloco de e-mail quando
50: *             CtnSaida_Email.Visible = .F.) e' tratada na fase que criar
51: *             Chk_EMAIL/CtnSaida_Email - ainda nao existem controles para
52: *             aplicar esse calculo nesta fase.
53: *   Fase 4:   Formsigprpdf.prg - SUPERFICIE DE ACAO + painel de e-mail (este
54: *             arquivo). Ver a nota "POR QUE A FASE 4 NAO TEM GRID NEM BOTOES
55: *             CRUD" logo abaixo. Entregue aqui:
56: *               ConfigurarPainelEmail      - cnt_4c_CtnSaida_Email (o CONTAINER
57: *                                            colapsavel, vazio: os campos De/
58: *                                            Para/CC/Assunto/Texto que moram
59: *                                            dentro dele sao da Fase 5/6)
60: *               ConfigurarBarraAcao        - obj_4c_OptArquivo (PDF/Excel),
61: *                                            chk_4c_Chk_EMAIL,
62: *                                            cmd_4c_Cmd_GerarPDF e
63: *                                            cmd_4c_Cmd_SAIR (a fileira de
64: *                                            Top = 3, que e' a barra de acao
65: *                                            deste dialogo)
66: *               ConfigurarAreaArquivoSaida - lbl_4c_Lbl_SalvarEm,
67: *                                            txt_4c_TxtNomeArqSaida (ReadOnly),
68: *                                            cmd_4c_CmdGetFile e
69: *                                            cmd_4c_BtnPastasA
70: *               AplicarTipoArquivoPadrao / AplicarNomeArquivoPadrao /
71: *               AlternarPainelEmail        - os defaults e o colapso do Init
72: *                                            legado (resolve a pendencia que a
73: *                                            Fase 3 deixou anotada sobre
74: *                                            "ThisForm.Height = This.Height -
75: *                                            This.CtnSaida_Email.Height")
76: *               CarregarContaEmailEmpresa  - a consulta a SigCdEmp do Init
77: *                                            legado (via BO), que e' o dado por
78: *                                            tras do Chk_EMAIL criado aqui
79: *               ChkEmailClick / OptArquivoClick / CmdGetFileClick /
80: *               BtnPastasAClick / CmdSairClick - os Click legado que dependem
81: *                                            SO de controles desta fase, logo
82: *                                            portados COMPLETOS aqui.
83: *   Fase 5:   Formsigprpdf.prg - PRIMEIRA METADE dos campos de dentro de
84: *             cnt_4c_CtnSaida_Email (De / Para / CC), em ConfigurarCamposEmail:
85: *               lbl_4c_Label1 / txt_4c_TxtEmail_EnviarDE       (De - ReadOnly)
86: *               lbl_4c_Lbl_EmailPara / obj_4c_TxtEmail_EnviarPara (Para)
87: *               lbl_4c_LblEmail_CC / obj_4c_TxtEmail_CC           (CC)

*-- Linhas 121 a 241:
121: *             LOOKUP: este legado NAO tem nenhum. Conferido no dump
122: *             (tasks\task664\sigprpdf_form_codigo_fonte.txt): zero fwBuscaExt /
123: *             fwBuscaSel / fwBuscaInt / mAddColuna / sigacess() / AcessoXxx(),
124: *             zero "PROCEDURE Valid", zero "PROCEDURE When" e zero "PROCEDURE
125: *             LostFocus" - os unicos metodos do SCX inteiro sao Init e Click.
126: *             Nenhum dos 5 campos referencia tabela alguma: Assunto/Texto/CC
127: *             sao texto livre, De vem da consulta a SigCdEmp (ReadOnly) e Para
128: *             vem do form chamador. O unico "seletor" da tela e' o GetFile() do
129: *             cmd_4c_CmdGetFile, que e' dialogo de ARQUIVO do proprio VFP9 (ja
130: *             portado na Fase 4), nao busca em tabela. Criar AbrirLookupXxx
131: *             aqui significaria inventar tabela de lookup que o legado nunca
132: *             consultou - proibido pelo PILAR 1 e pela regra "NUNCA inventar
133: *             tabelas de lookup".
134: *
135: *   Fase 7/8: Formsigprpdf.prg - CmdGerarPDFClick, o Click do cmd_4c_Cmd_GerarPDF
136: *             (botao criado na Fase 4; BINDEVENT ligado agora em
137: *             ConfigurarBarraAcao). Usa o que as fases anteriores ja deixaram
138: *             pronto: THIS.ValidarDadosEnvio() (sincroniza a tela com o BO,
139: *             valida e da o foco ao campo recusado) e, no BO,
140: *             this_lContaEmailCarregada + ObterMensagemContaEmailIndisponivel()
141: *             para o aviso que NAO bloqueia o fechamento e
142: *             MontarDadosEnvioEmail() para o objeto de envio que vai para
143: *             par_oFormPai.oEMAIL. A unica saida da tela (cmd_4c_Cmd_SAIR,
144: *             Cancel = .T.) ja estava ligada desde a Fase 4, entao o dialogo
145: *             nunca ficou sem como fechar. Com isto, todos os Click do SCX
146: *             legado (Init/Click de Cmd_GerarPDF, Cmd_SAIR, Chk_EMAIL,
147: *             optArquivo, cmdGetFile, btnPastasA) estao portados - o dump
148: *             (tasks\task664\sigprpdf_form_codigo_fonte.txt) nao tem mais
149: *             nenhum PROCEDURE alem de Init, e Init e' o deste form.
150: *   Fase 8:   Consolidacao final - sem codigo novo de comportamento (ver
151: *             "POR QUE A FASE 8 NAO TEM Btn*/FormParaBO/BOParaForm/
152: *             HabilitarCampos/LimparCampos/CarregarLista/
153: *             AjustarBotoesPorModo" logo abaixo). Confirmado de novo contra
154: *             o dump que nao sobrou PROCEDURE do legado sem equivalente
155: *             neste arquivo - a migracao do COMPORTAMENTO fecha aqui.
156: *
157: * POR QUE A FASE 8 NAO TEM BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
158: * BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
159: * CarregarLista/AjustarBotoesPorModo
160: * ------------------------------------------------------------------------
161: * O texto generico da Fase 8 pede os metodos de consolidacao do padrao CRUD
162: * (FormCargo/FormCor): Buscar/Encerrar/Salvar/Cancelar ligados a um
163: * cnt_4c_Botoes, FormParaBO/BOParaForm por modo, HabilitarCampos por modo
164: * (INCLUIR/ALTERAR/VISUALIZAR), LimparCampos para reusar a MESMA tela em
165: * registros diferentes, CarregarLista+AjustarBotoesPorModo para a Page1 de
166: * lista. SIGPRPDF nao tem NENHUM desses conceitos - e' um dialogo de
167: * CAPTURA DE UM UNICO VALOR (CREATEOBJECT + Show() + Release(), sempre uma
168: * instancia NOVA por chamada, nunca reaberto/reusado), sem registro, sem
169: * tabela propria e sem Page1/Page2 (ver "POR QUE A FASE 4 NAO TEM GRID NEM
170: * BOTOES CRUD" acima). O equivalente de cada metodo generico ja foi
171: * entregue nas fases anteriores, com o nome do botao do PROPRIO legado (nao
172: * um nome generico inventado):
173: *   BtnSalvarClick    -> CmdGerarPDFClick (Fase 7) - confirma e fecha
174: *   BtnCancelarClick /
175: *   BtnEncerrarClick  -> CmdSairClick (Fase 7) - UNICA saida da tela
176: *                        (TitleBar = 0, ControlBox = .F.); o legado nao tem
177: *                        Confirmar+Encerrar de form CRUD, so Cmd_GerarPDF e
178: *                        Cmd_SAIR
179: *   BtnBuscarClick    -> N/A - zero lookup no legado, conferido no dump e
180: *                        documentado na Fase 6
181: *   FormParaBO        -> SincronizarCamposParaBO (Fase 6) - TELA -> BO,
182: *                        chamada por ValidarDadosEnvio()/CmdGerarPDFClick
183: *   BOParaForm        -> nao existe como metodo unico porque o legado nao
184: *                        tem ALTERAR/VISUALIZAR (nao ha registro para
185: *                        carregar de volta); o UNICO sentido BO -> Form do
186: *                        legado e' escrito exatamente onde o legado escreve:
187: *                        CarregarContaEmailEmpresa() grava this_cEmailDe em
188: *                        TxtEmail_EnviarDE (Fase 5/7) e ConfigurarCamposEmail
189: *                        grava this_cEmailPara/this_cEmailAssunto nos
190: *                        valores iniciais de Para/Assunto (Fase 5/6)
191: *   HabilitarCampos   -> N/A - nao ha modo INCLUIR/ALTERAR/VISUALIZAR; os
192: *                        unicos campos ReadOnly (TxtEmail_EnviarDE,
193: *                        TxtNomeArqSaida) sao FIXOS do SCX, nao variam por
194: *                        estado da tela
195: *   LimparCampos      -> N/A - a instancia NAO e' reaproveitada: cada
196: *                        chamador faz um CREATEOBJECT novo e o dialogo se
197: *                        libera (Release()) ao confirmar OU ao cancelar; nao
198: *                        ha "proximo registro" para limpar os campos
199: *   CarregarLista /
200: *   AjustarBotoesPorModo -> N/A - nao ha grid nem Page1 (ver nota da Fase 4)
201: * Escrever esses metodos vazios ou com MsgAviso("...sera implementado...")
202: * so para casar com o texto generico seria o "stub disfarcado" que a regra
203: * de completude do projeto proibe, e inventaria um fluxo de cadastro
204: * (registro/modo/lista) que SIGPRPDF nunca teve - o oposto de fidelidade ao
205: * legado (PILAR 1). "Completo" aqui significa cobrir TODO o dump do legado,
206: * nao reproduzir metodos de um padrao que o legado nao tem.
207: *
208: * POR QUE A FASE 4 NAO TEM GRID NEM BOTOES CRUD
209: * ---------------------------------------------
210: * A Fase 4 pede, no texto generico, "ConfigurarPaginaLista() com Grid completo +
211: * cnt_4c_Botoes com 6 botoes CRUD + AlternarPagina()". Conferido o dump do
212: * legado (tasks\task664\sigprpdf_form_codigo_fonte.txt e layout.json), SIGPRPDF
213: * nao tem NADA disso: zero "BaseClass: grid", zero "BaseClass: pageframe", zero
214: * AddCursor/pColuna/RecordSource/ControlSource e nenhum botao Incluir/
215: * Visualizar/Alterar/Excluir/Buscar - e' um dialogo MODAL de CAPTURA (800x360,
216: * TitleBar = 0, ControlBox = .F.) que coleta o nome do arquivo de saida e os
217: * dados do e-mail e devolve tudo ao form chamador. Inventar um PageFrame
218: * Lista/Dados com grade e 6 botoes CRUD violaria o PILAR 1 (UX fiel ao legado) e
219: * a regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina vazios
220: * so para casar com o texto da fase seria o "stub disfarcado" que a regra de
221: * completude proibe. O que esta fase acrescenta, entao, e' a superficie que este
222: * legado DE FATO tem e que a Fase 3 (estrutura base) ainda nao tinha: a barra de
223: * acao, a area do arquivo de saida e o container colapsavel de e-mail.
224: *
225: * DIVERGENCIAS DELIBERADAS DO SCX (registradas para serem auditaveis)
226: * ------------------------------------------------------------------
227: *   SIGPRPDF.REGISTRY1 (classe "registry" do framework.vcx) e a cadeia
228: *   "optArquivo.option1.Enabled = Registry1.IsKey('PDFCreator.clsPDFCreator') Or
229: *   Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO PORTADOS, pela mesma razao
230: *   ja registrada no form irmao Formsigprema.prg: a geracao do PDF via COM do
231: *   PDFCreator esta fora do escopo deste acervo - quem gera o arquivo e' o form
232: *   CHAMADOR (ver cabecalho de sigprpdfBO.prg), este dialogo so escolhe o nome.
233: *   Copiar a deteccao sem a funcionalidade que ela protege DESABILITARIA a opcao
234: *   PDF em toda maquina sem PDFCreator instalado - isto e', mataria justamente o
235: *   que a tela existe para fazer ("Geracao de PDF e E-mail"), sendo pior que o
236: *   legado em vez de fiel a ele. A EXPRESSAO do legado foi transcrita: o
237: *   Enabled de Buttons(1) e o Value default saem de
238: *   this_oBusinessObject.this_lPdfCreatorDisponivel (o campo que o BO declarou
239: *   justamente para esta decisao), resolvido aqui como .T. Trocar essa property
240: *   por uma deteccao real e' o UNICO ponto a mexer no futuro.
241: *   Consequencia conhecida: o ValidarUIFidelity vai acusar obj_4c_REGISTRY1

*-- Linhas 254 a 297:
254: *   este form nao usa essa textura. NAO se aplica aqui: fundo_cad_1003.jpg e' o
255: *   fundo das Pages de form CRUD, e este e' um dialogo OPERACIONAL FLAT cujo
256: *   SCX declara "Picture = ..\framework\imagens\new_background.jpg" - que e'
257: *   justamente o que o InicializarForm atribui. Trocar seria desviar do legado.
258: *
259: *   AutoCenter - o legado faz "Thisform.AutoCenter = .F." no fim do Init, DEPOIS
260: *   de encolher a tela, so para o colapso/expansao do painel de e-mail nao
261: *   recentralizar a janela. Aqui o AutoCenter fica .T. durante o Init (para o
262: *   dialogo JA COLAPSADO nascer centralizado quando o Show() acontecer, que no
263: *   sistema novo e' depois do Init) e e' desligado dentro de
264: *   AlternarPainelEmail, na primeira vez que a altura muda com a tela visivel -
265: *   mesmo efeito pratico, mesma protecao.
266: *==============================================================================
267: DEFINE CLASS Formsigprpdf AS FormBase
268: 
269:     *-- Business Object
270:     this_oBusinessObject = .NULL.
271: 
272:     *-- Parametros recebidos no Init (equivalentes a poformParent/pcAssunto)
273:     this_oFormPai = .NULL.   && poformParent / ThisForm.oParentForm
274:     this_cAssunto = ""       && pcAssunto - usado pela fase que criar CtnSaida_Email.txtEmail_Assunto
275: 
276:     *-- Estado do bloco de e-mail no que diz respeito a ALTURA do form.
277:     *-- Comeca .T. porque o Height = 360 declarado acima e' o do SCX, e o SCX
278:     *-- desenha a tela COM o painel ocupando Top 148..333 - isto e', o tamanho
279:     *-- de projeto JA CONTA o painel. E' justamente por isso que o Init legado
280:     *-- precisa encolher a tela ("Thisform.Height = This.Height -
281:     *-- This.CtnSaida_Email.Height" -> 360 - 185 = 175).
282:     *-- NAO usar cnt_4c_CtnSaida_Email.Visible como esse estado: o container
283:     *-- nasce Visible = .F. (fiel ao SCX) enquanto a ALTURA ainda esta na de
284:     *-- projeto, entao os dois nao coincidem no comeco - medido no VFP9 em
285:     *-- 2026-10-18: com o Visible como guarda, o colapso do Init virava no-op
286:     *-- em silencio e o dialogo abria 185px mais alto, com uma faixa vazia.
287:     this_lPainelEmailVisivel = .T.
288: 
289:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX legado)
290:     Top         = 0
291:     Left        = 0
292:     Height      = 360
293:     Width       = 800
294:     BorderStyle = 2
295:     AutoCenter  = .T.
296:     ShowWindow  = 1
297:     WindowType  = 1

*-- Linhas 307 a 457:
307:     * Init - Recebe os parametros equivalentes a poformParent/pcAssunto do
308:     * legado (Lparameters poformParent, pcAssunto)
309:     *--------------------------------------------------------------------------
310:     PROCEDURE Init(par_oFormPai, par_cAssunto)
311:         THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
312:         THIS.this_cAssunto = IIF(VARTYPE(par_cAssunto) = "C", par_cAssunto, "")
313: 
314:         *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
315:         RETURN DODEFAULT()
316:     ENDPROC
317: 
318:     *--------------------------------------------------------------------------
319:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT. Equivalente ao
320:     * PROCEDURE Init legado: cria o BO (no lugar do poDataMgr/fSqlConector
321:     * proprio do legado), confere a conexao global (equivalente a
322:     * "If .poDataMgr.pnIdconn > 0 / Else MessageBox(...)"), resolve
323:     * this_cDiretorio (equivalente a "ThisForm.Diretorio =
324:     * goSistema.DirFiscais"), monta a tela e aplica os defaults.
325:     *
326:     * A ORDEM de criacao importa: cnt_4c_Sombra (faixa cinza, Top = 0..80,
327:     * Width = 1100) vem PRIMEIRO; a barra de acao (Top = 3..78) e' criada
328:     * DEPOIS para desenhar POR CIMA dela. E ConfigurarPainelEmail vem antes da
329:     * barra porque AlternarPainelEmail le a .Height daquele container para
330:     * encolher o form, que e' a primeira coisa que o Init legado faz.
331:     *--------------------------------------------------------------------------
332:     PROTECTED PROCEDURE InicializarForm()
333:         LOCAL loc_lSucesso, loc_oErro, loc_cDiretorio
334:         loc_lSucesso = .F.
335: 
336:         TRY
337:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")
338: 
339:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
340:                 MsgErro("Erro ao criar sigprpdfBO." + CHR(13) + ;
341:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
342:                     "Formsigprpdf.InicializarForm")
343:             ELSE
344:                 *-- Equivalente a "If (.poDataMgr.pnIdconn > 0) ... Else
345:                 *-- Messagebox('Impossivel Efetuar Conexao...')" do legado -
346:                 *-- a conexao agora e' a global gnConnHandle (criada uma vez
347:                 *-- no startup), nao uma por form.
348:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
349:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
350:                         MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
351:                                 "o Com o Servidor de Banco de Dados...", ;
352:                                 "CreateObject")
353:                     ENDIF
354:                 ENDIF
355: 
356:                 *-- Repassa a referencia ao form pai para o BO (ele existe so
357:                 *-- para o Form usar - ver cabecalho de sigprpdfBO.prg)
358:                 THIS.this_oBusinessObject.this_oFormPai = THIS.this_oFormPai
359: 
360:                 *-- Equivalente a "ThisForm.Diretorio = goSistema.DirFiscais".
361:                 *-- DirFiscais e' property DINAMICA (SigReIdtBO a cria via
362:                 *-- AddProperty em runtime quando um relatorio informa
363:                 *-- diretorio alternativo) - NAO existe no AddProperty fixo de
364:                 *-- start\config.prg, entao ler sem PEMSTATUS estouraria
365:                 *-- "Property DIRFISCAIS is not found" (mesmo guard usado em
366:                 *-- FormSigReIdt.prg).
367:                 loc_cDiretorio = ""
368:                 IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
369:                     loc_cDiretorio = ALLTRIM(TratarNulo(go_4c_Sistema.DirFiscais, ""))
370:                 ENDIF
371:                 THIS.this_oBusinessObject.this_cDiretorio = loc_cDiretorio
372: 
373:                 *-- Imagem de fundo (legado: Picture = ..\framework\imagens\new_background.jpg)
374:                 IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
375:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
376:                 ENDIF
377: 
378:                 THIS.ConfigurarCabecalho()
379:                 THIS.ConfigurarPainelEmail()
380:                 THIS.ConfigurarCamposEmail()
381:                 THIS.ConfigurarBarraAcao()
382:                 THIS.ConfigurarAreaArquivoSaida()
383: 
384:                 THIS.TornarControlesVisiveis(THIS)
385: 
386:                 *-- Defaults do Init legado (optArquivo.option1.Enabled +
387:                 *-- optArquivo.Value + txtNomeArqSaida.Value)
388:                 THIS.AplicarTipoArquivoPadrao()
389: 
390:                 *-- Colapso inicial: "Thisform.Height = This.Height -
391:                 *-- This.CtnSaida_Email.Height" + "CtnSaida_Email.Visible = .F."
392:                 THIS.AlternarPainelEmail(.F.)
393: 
394:                 *-- Consulta de dados da conta de e-mail da empresa (o
395:                 *-- "Select ... From SigCdEmp Where CEmps = ..." do Init
396:                 *-- legado). Falha aqui IMPEDE a abertura da tela, igual ao
397:                 *-- "Return .f." do legado.
398:                 loc_lSucesso = THIS.CarregarContaEmailEmpresa()
399:             ENDIF
400:         CATCH TO loc_oErro
401:             loc_lSucesso = .F.
402:             MsgErro(loc_oErro.Message + CHR(13) + ;
403:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
404:                 "Procedure: " + loc_oErro.Procedure, ;
405:                 "Erro Formsigprpdf.InicializarForm")
406:         ENDTRY
407: 
408:         RETURN loc_lSucesso
409:     ENDPROC
410: 
411:     *--------------------------------------------------------------------------
412:     * ConfigurarCabecalho - Constroi a faixa cinza superior do form
413:     * (equivalente ao cntSombra do SCX legado, com lblSombra/lblTitulo).
414:     * Forms OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e' um container
415:     * direto no form.
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarCabecalho()
418:         LOCAL loc_oErro
419: 
420:         TRY
421:             THIS.AddObject("cnt_4c_Sombra", "Container")
422:             WITH THIS.cnt_4c_Sombra
423:                 .Top         = 0
424:                 .Left        = 0
425:                 .Width       = 1100
426:                 .Height      = 80
427:                 .BackColor   = RGB(100, 100, 100)
428:                 .BackStyle   = 1
429:                 .BorderWidth = 0
430: 
431:                 .AddObject("lbl_4c_Sombra", "Label")
432:                 WITH .lbl_4c_Sombra
433:                     .Top       = 18
434:                     .Left      = 10
435:                     *-- Canonico do sistema novo: os labels da faixa acompanham
436:                     *-- a largura do FORM (o SCX declara 769). O
437:                     *-- CorretorAutomatico (HEADER-WIDTH-TOTAL) aplica esta
438:                     *-- troca de qualquer forma, entao ja fica no formato final -
439:                     *-- NAO reverter para 769. Inerte visualmente: o label e'
440:                     *-- BackStyle = 0 com Alignment = 0, logo o texto continua
441:                     *-- desenhando da esquerda.
442:                     .Width     = THIS.Width
443:                     .Height    = 40
444:                     .FontBold  = .T.
445:                     .FontName  = "Tahoma"
446:                     .FontSize  = 18
447:                     .AutoSize  = .F.
448:                     .BackStyle = 0
449:                     .WordWrap  = .T.
450:                     .Alignment = 0
451:                     .ForeColor = RGB(0, 0, 0)
452:                     .Caption   = THIS.Caption
453:                 ENDWITH
454: 
455:                 .AddObject("lbl_4c_Titulo", "Label")
456:                 WITH .lbl_4c_Titulo
457:                     .Top       = 17

*-- Linhas 481 a 563:
481:         CATCH TO loc_oErro
482:             MsgErro(loc_oErro.Message + CHR(13) + ;
483:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
484:                 "Procedure: " + loc_oErro.Procedure, ;
485:                 "Erro Formsigprpdf.ConfigurarCabecalho")
486:         ENDTRY
487:     ENDPROC
488: 
489:     *--------------------------------------------------------------------------
490:     * ConfigurarPainelEmail - Cria o container colapsavel do bloco de e-mail
491:     * (equivalente a SIGPRPDF.CtnSaida_Email). Geometria e propriedades
492:     * transcritas do dump do SCX; o BorderWidth = 0 vem do PROCEDURE Init do
493:     * proprio container no legado ("This.BorderWidth = 0"). Container NAO tem
494:     * BorderStyle no VFP9 - so BorderWidth.
495:     *
496:     * Nasce Visible = .F. igual ao legado - quem o mostra/esconde e' o
497:     * Chk_EMAIL, via AlternarPainelEmail(). Os controles de DENTRO dele - De/
498:     * Para/CC e os respectivos labels foram criados em ConfigurarCamposEmail
499:     * (Fase 5); Assunto/Texto ficam para a Fase 6.
500:     *
501:     * Criado ANTES da barra de acao de proposito: AlternarPainelEmail le a
502:     * .Height deste container para encolher/esticar o form, e o Init legado faz
503:     * esse calculo na primeira coisa que executa.
504:     *--------------------------------------------------------------------------
505:     PROTECTED PROCEDURE ConfigurarPainelEmail()
506:         LOCAL loc_oErro
507: 
508:         TRY
509:             THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
510:             WITH THIS.cnt_4c_CtnSaida_Email
511:                 .Top         = 148
512:                 .Left        = 155
513:                 .Width       = 480
514:                 .Height      = 185
515:                 .BackStyle   = 0
516:                 .BorderWidth = 0
517:                 .TabIndex    = 7
518:                 .Visible     = .F.
519:             ENDWITH
520:         CATCH TO loc_oErro
521:             MsgErro(loc_oErro.Message + CHR(13) + ;
522:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
523:                 "Procedure: " + loc_oErro.Procedure, ;
524:                 "Erro Formsigprpdf.ConfigurarPainelEmail")
525:         ENDTRY
526:     ENDPROC
527: 
528:     *--------------------------------------------------------------------------
529:     * ConfigurarCamposEmail - Cria os CINCO campos do painel de e-mail (De /
530:     * Para / CC / Assunto / Texto, dentro de cnt_4c_CtnSaida_Email) com os
531:     * respectivos labels. Geometria e propriedades transcritas do dump do SCX
532:     * legado (SIGPRPDF.CtnSaida_Email.*), controle a controle:
533:     *
534:     *   Label1           "De:"       Top=8   Left=47 W=19 H=15  TabIndex=1
535:     *   txtEmail_EnviarDE  (TextBox) Top=5   Left=68 W=404 H=23 TabIndex=2 ReadOnly
536:     *   lbl_EmailPara    "Para:"     Top=38  Left=38 W=28 H=15  TabIndex=3
537:     *   txtEmail_EnviarPara (EditBox) Top=35 Left=68 W=404 H=23 TabIndex=4
538:     *   lblEmail_CC      "CC:"       Top=68  Left=46 W=20 H=15  TabIndex=5
539:     *   txtEmail_CC      (EditBox)   Top=65  Left=68 W=404 H=23 TabIndex=6
540:     *   lblEmail_Assunto "Assunto:"  Top=99  Left=21 W=45 H=15  TabIndex=7
541:     *   txtEmail_Assunto (TextBox)   Top=95  Left=68 W=404 H=23 TabIndex=8
542:     *   lblEmail_Corpo   "Texto:"    Top=127 Left=32 W=34 H=15  TabIndex=9
543:     *   EdtEmail_Corpo   (EditBox)   Top=125 Left=68 W=404 H=53 TabIndex=10
544:     *
545:     * O ultimo controle termina em Top 125 + 53 = 178, dentro do Height = 185
546:     * do container - nada estoura a area do pai (que recortaria o controle sem
547:     * erro algum, so sumindo da tela).
548:     *
549:     * CADA label e' criado ANTES do campo da sua linha: o label tem
550:     * BackStyle = 0 (caixa transparente) e, se viesse depois, essa caixa ficaria
551:     * POR CIMA do campo e bloquearia o clique nele.
552:     *
553:     * Nomes com "txt" no legado que sao EDITBOX, nao TextBox (confirmado no
554:     * layout.json: baseClass = editbox) - txtEmail_EnviarPara e txtEmail_CC.
555:     * Os dois tem ScrollBars = 0 no SCX (comportam-se como campo de uma linha,
556:     * mas sem o SpecialEffect/visual de TextBox).
557:     *
558:     * Valores iniciais (equivalentes ao Init legado):
559:     *   thisform.ctnSaida_Email.txtEmail_EnviarPara.Value = thisform.oParentForm.Contaemail
560:     *   thisform.ctnSaida_Email.txtEmail_Assunto.Value = Iif(Type([pcAssunto]) = [C], pcAssunto, [])
561:     * Contaemail e' property do FORM CHAMADOR (fora deste acervo) - PEMSTATUS
562:     * antes de ler, mesmo padrao do CmdSairClick com pcArqEmail/oEmail. O
563:     * Assunto vem de this_cAssunto, que o Init do form ja resolveu com o mesmo

*-- Linhas 569 a 612:
569:     * que roda em CarregarContaEmailEmpresa() - escrito la, nao aqui, porque a
570:     * esta altura this_oBusinessObject.this_cEmailDe ainda esta vazio.
571:     *--------------------------------------------------------------------------
572:     PROTECTED PROCEDURE ConfigurarCamposEmail()
573:         LOCAL loc_oErro, loc_cContaEmailPai, loc_oPainel
574: 
575:         TRY
576:             *-- AddObject SEMPRE fora de qualquer WITH, e cada WITH abaixo usa
577:             *-- o CAMINHO COMPLETO (nunca ".filho" aninhado dentro de outro
578:             *-- WITH) - WITH aninhado relativo apos AddObject falha em
579:             *-- resolver propriedade de Label/TextBox/EditBox em SILENCIO no
580:             *-- VFP9 (sem exception; Caption/ForeColor/Value nao sao
581:             *-- aplicados - ver licao sobre WITH aninhado em Container criado
582:             *-- por AddObject).
583:             loc_oPainel = THIS.cnt_4c_CtnSaida_Email
584: 
585:             *-- Label1 ("De:")
586:             loc_oPainel.AddObject("lbl_4c_Label1", "Label")
587:             WITH loc_oPainel.lbl_4c_Label1
588:                 .Top       = 8
589:                 .Left      = 47
590:                 .Width     = 19
591:                 .Height    = 15
592:                 .AutoSize  = .F.
593:                 .BackStyle = 0
594:                 .Alignment = 0
595:                 .FontName  = "Tahoma"
596:                 .FontSize  = 8
597:                 .Caption   = "De:"
598:                 .ForeColor = RGB(90, 90, 90)
599:                 .TabIndex  = 1
600:             ENDWITH
601: 
602:             *-- txtEmail_EnviarDE (De) - ReadOnly: preenchido so pela
603:             *-- consulta a SigCdEmp (CarregarContaEmailEmpresa)
604:             loc_oPainel.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
605:             WITH loc_oPainel.txt_4c_TxtEmail_EnviarDE
606:                 .Top               = 5
607:                 .Left              = 68
608:                 .Width             = 404
609:                 .Height            = 23
610:                 .FontName          = "Tahoma"
611:                 .FontSize          = 8
612:                 .ReadOnly          = .T.

*-- Linhas 780 a 855:
780:         CATCH TO loc_oErro
781:             MsgErro(loc_oErro.Message + CHR(13) + ;
782:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
783:                 "Procedure: " + loc_oErro.Procedure, ;
784:                 "Erro Formsigprpdf.ConfigurarCamposEmail")
785:         ENDTRY
786:     ENDPROC
787: 
788:     *--------------------------------------------------------------------------
789:     * ConfigurarBarraAcao - Cria a fileira de botoes de acao do topo direito
790:     * (Top = 3 no legado): optArquivo (PDF/Excel), Chk_EMAIL, Cmd_GerarPDF e
791:     * Cmd_SAIR. Estruturalmente e' o que o cnt_4c_Botoes e' num form CRUD, mas
792:     * aqui os controles ficam DIRETO no form, como no SCX legado (sem container
793:     * agrupador - ver layout.json).
794:     *
795:     * Criada DEPOIS de ConfigurarCabecalho de proposito: a faixa cinza
796:     * (cnt_4c_Sombra) ocupa Top = 0..80 com Width = 1100, logo estes controles
797:     * (Top = 3..78, Left = 420..800) ficam DENTRO da area dela e so aparecem se
798:     * forem criados depois - AddObject empilha o ultimo objeto por cima.
799:     *
800:     * Propriedades vindas da CLASSE fwoption (framework.vcx, lida como DBF) e
801:     * nao declaradas no SCX: no grupo, BackStyle = 0 e BorderStyle = 0; nos dois
802:     * OptionButton, BackStyle = 0, FontSize = 8 e DisabledForeColor =
803:     * 128,128,128. O SCX declara AutoSize = .T. no grupo, mas AutoSize e' no-op
804:     * em controle criado por AddObject - os Width = 161 / Height = 85 do SCX JA
805:     * SAO o auto-size que o Form Designer calculou (5 + 75 + 5 = 85), entao
806:     * fixa-los com AutoSize = .F. e' reproducao fiel, nao desvio. OptionGroup
807:     * NAO tem ForeColor: a cor mora em cada Buttons(N).
808:     *--------------------------------------------------------------------------
809:     PROTECTED PROCEDURE ConfigurarBarraAcao()
810:         LOCAL loc_oErro
811: 
812:         TRY
813:             *-- optArquivo: tipo do arquivo de saida (1 = PDF, 2 = XLS).
814:             *-- OptionGroup.Value e' INDICE 1-based, nunca booleano.
815:             THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
816:             WITH THIS.obj_4c_OptArquivo
817:                 .Top         = -2
818:                 .Left        = 420
819:                 .Width       = 161
820:                 .Height      = 85
821:                 .ButtonCount = 2
822:                 .AutoSize    = .F.
823:                 .BackStyle   = 0
824:                 .BorderStyle = 0
825:                 .Themes      = .T.
826:                 .TabIndex    = 1
827:                 .Value       = 1
828: 
829:                 WITH .Buttons(1)
830:                     .Top               = 5
831:                     .Left              = 5
832:                     .Width             = 75
833:                     .Height            = 75
834:                     .Style             = 1
835:                     .FontBold          = .T.
836:                     .FontItalic        = .T.
837:                     .FontName          = "Comic Sans MS"
838:                     .FontSize          = 8
839:                     .Caption           = "PDF"
840:                     .Picture           = gc_4c_CaminhoIcones + "pdf_60.png"
841:                     .DisabledPicture   = gc_4c_CaminhoIcones + "pdf_60.png"
842:                     .BackStyle         = 0
843:                     .BackColor         = RGB(255, 255, 255)
844:                     .ForeColor         = RGB(90, 90, 90)
845:                     .DisabledForeColor = RGB(128, 128, 128)
846:                     .Themes            = .F.
847:                 ENDWITH
848: 
849:                 WITH .Buttons(2)
850:                     .Top               = 5
851:                     .Left              = 81
852:                     .Width             = 75
853:                     .Height            = 75
854:                     .Style             = 1
855:                     .FontBold          = .T.

*-- Linhas 866 a 1022:
866:                     .Themes            = .F.
867:                 ENDWITH
868:             ENDWITH
869:             BINDEVENT(THIS.obj_4c_OptArquivo, "Click", THIS, "OptArquivoClick")
870: 
871:             *-- Chk_EMAIL: liga/desliga o bloco de e-mail. CheckBox GRAFICO
872:             *-- (Style = 1) - .Value e' NUMERICO (0/1), nunca .T./.F.
873:             THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
874:             WITH THIS.chk_4c_Chk_EMAIL
875:                 .Top        = 3
876:                 .Left       = 575
877:                 .Width      = 75
878:                 .Height     = 75
879:                 .Style      = 1
880:                 .AutoSize   = .F.
881:                 .FontBold   = .T.
882:                 .FontItalic = .T.
883:                 .FontName   = "Comic Sans MS"
884:                 .FontSize   = 8
885:                 .Alignment  = 0
886:                 .Caption    = "Email"
887:                 .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
888:                 .ForeColor  = RGB(90, 90, 90)
889:                 .BackColor  = RGB(255, 255, 255)
890:                 .Themes     = .F.
891:                 .TabIndex   = 2
892:                 .Value      = 0
893:             ENDWITH
894:             BINDEVENT(THIS.chk_4c_Chk_EMAIL, "Click", THIS, "ChkEmailClick")
895: 
896:             *-- Cmd_GerarPDF: botao de confirmacao do dialogo. O Click dele e'
897:             *-- da fase de eventos; as checagens que ele faz sobre os campos do
898:             *-- painel de e-mail estao prontas em THIS.ValidarDadosEnvio() -
899:             *-- ver o roteiro das fases no cabecalho do arquivo.
900:             *-- O .Tag guarda o Caption de origem, igual ao
901:             *-- "Cmd_GerarPDF.Init: This.Tag = This.Caption" do legado.
902:             THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
903:             WITH THIS.cmd_4c_Cmd_GerarPDF
904:                 .Top             = 3
905:                 .Left            = 650
906:                 .Width           = 75
907:                 .Height          = 75
908:                 .FontBold        = .T.
909:                 .FontItalic      = .T.
910:                 .FontName        = "Comic Sans MS"
911:                 .FontSize        = 8
912:                 .WordWrap        = .F.
913:                 .Alignment       = 6
914:                 .PicturePosition = 13
915:                 .Caption         = "   Gravar"
916:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
917:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
918:                 .ForeColor       = RGB(90, 90, 90)
919:                 .BackColor       = RGB(255, 255, 255)
920:                 .Themes          = .T.
921:                 .TabIndex        = 3
922:                 .Tag             = .Caption
923:             ENDWITH
924:             BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF, "Click", THIS, "CmdGerarPDFClick")
925: 
926:             *-- Cmd_SAIR: Cancel = .T. faz o ESC aciona-lo. Como este form tem
927:             *-- TitleBar = 0 e ControlBox = .F., ele e' a UNICA saida da tela -
928:             *-- por isso o Click dele e' portado JA nesta fase.
929:             THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
930:             WITH THIS.cmd_4c_Cmd_SAIR
931:                 .Top             = 3
932:                 .Left            = 725
933:                 .Width           = 75
934:                 .Height          = 75
935:                 .FontBold        = .T.
936:                 .FontItalic      = .T.
937:                 .FontName        = "Comic Sans MS"
938:                 .FontSize        = 8
939:                 .Cancel          = .T.
940:                 .Caption         = "Encerrar"
941:                 .ToolTipText     = "[ESC] - Sair"
942:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
943:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
944:                 .ForeColor       = RGB(90, 90, 90)
945:                 .BackColor       = RGB(255, 255, 255)
946:                 .Themes          = .T.
947:                 .TabIndex        = 8
948:             ENDWITH
949:             BINDEVENT(THIS.cmd_4c_Cmd_SAIR, "Click", THIS, "CmdSairClick")
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message + CHR(13) + ;
952:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
953:                 "Procedure: " + loc_oErro.Procedure, ;
954:                 "Erro Formsigprpdf.ConfigurarBarraAcao")
955:         ENDTRY
956:     ENDPROC
957: 
958:     *--------------------------------------------------------------------------
959:     * ConfigurarAreaArquivoSaida - Cria a linha "Salvar em:" com o caminho do
960:     * arquivo de saida (lbl_SalvarEm + txtNomeArqSaida + cmdGetFile +
961:     * btnPastasA no legado).
962:     *
963:     * txt_4c_TxtNomeArqSaida e' ReadOnly = .T. no SCX: o caminho NAO e'
964:     * digitado, ele e' escrito pelo optArquivo (default) ou pelo GetFile() do
965:     * cmd_4c_CmdGetFile. Por isso o legado declara DisabledBackColor =
966:     * 255,255,255 (branco) - para o campo travado nao parecer desabilitado. O
967:     * SCX nao declara Format nem InputMask neste campo (nao ha o que
968:     * transcrever), e MaxLength tambem nao: e' caminho de arquivo, nao coluna
969:     * de tabela - inventar um limite aqui cortaria caminho longo.
970:     *
971:     * lbl_4c_Lbl_SalvarEm: o SCX declara AutoSize = .T. com Width = 53 /
972:     * Height = 15. AutoSize e' no-op em Label criado por AddObject, entao
973:     * transcreve-se AutoSize = .F. + os Width/Height do dump, que JA SAO o
974:     * auto-size calculado pelo Form Designer. Alignment = 0 e
975:     * ForeColor = 90,90,90 saem do legado (classe "say": texto a esquerda,
976:     * cinza - branco ficaria invisivel sobre o new_background.jpg claro).
977:     *
978:     * cmd_4c_BtnPastasA (classe fwbtnp do framework.vcx, lida como DBF):
979:     * MousePointer = 15, WordWrap = .T. e BackColor = 255,255,255 vem da
980:     * classe; Caption = "" e 40x32 sao os overrides do SCX.
981:     *--------------------------------------------------------------------------
982:     PROTECTED PROCEDURE ConfigurarAreaArquivoSaida()
983:         LOCAL loc_oErro
984: 
985:         TRY
986:             THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
987:             WITH THIS.lbl_4c_Lbl_SalvarEm
988:                 .Top       = 109
989:                 .Left      = 150
990:                 .Width     = 53
991:                 .Height    = 15
992:                 .AutoSize  = .F.
993:                 .BackStyle = 0
994:                 .Alignment = 0
995:                 .FontName  = "Tahoma"
996:                 .FontSize  = 8
997:                 .Caption   = "Salvar em:"
998:                 .ForeColor = RGB(90, 90, 90)
999:                 .TabIndex  = 4
1000:             ENDWITH
1001: 
1002:             THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
1003:             WITH THIS.txt_4c_TxtNomeArqSaida
1004:                 .Top               = 105
1005:                 .Left              = 205
1006:                 .Width             = 383
1007:                 .Height            = 23
1008:                 .FontName          = "Tahoma"
1009:                 .FontSize          = 8
1010:                 .ReadOnly          = .T.
1011:                 .SpecialEffect     = 1
1012:                 .BorderColor       = RGB(100, 100, 100)
1013:                 .DisabledBackColor = RGB(255, 255, 255)
1014:                 .TabIndex          = 5
1015:                 .Value             = ""
1016:             ENDWITH
1017: 
1018:             *-- cmdGetFile: ". . ." - abre o GetFile(). Sem .Picture no legado,
1019:             *-- por isso mantem Themes = .F. (o padrao canonico de
1020:             *-- Themes = .T. vale para botao standalone COM icone).
1021:             THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
1022:             WITH THIS.cmd_4c_CmdGetFile

*-- Linhas 1034 a 1699:
1034:                 .Themes     = .F.
1035:                 .TabIndex   = 6
1036:             ENDWITH
1037:             BINDEVENT(THIS.cmd_4c_CmdGetFile, "Click", THIS, "CmdGetFileClick")
1038: 
1039:             THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
1040:             WITH THIS.cmd_4c_BtnPastasA
1041:                 .Top             = 100
1042:                 .Left            = 619
1043:                 .Width           = 40
1044:                 .Height          = 32
1045:                 .FontBold        = .T.
1046:                 .FontItalic      = .T.
1047:                 .FontName        = "Tahoma"
1048:                 .FontSize        = 8
1049:                 .WordWrap        = .T.
1050:                 .Caption         = ""
1051:                 .PicturePosition = 13
1052:                 .MousePointer    = 15
1053:                 .ToolTipText     = "Abrir o Diret" + CHR(243) + "rio / Pasta de Arquivos"
1054:                 .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1055:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1056:                 .ForeColor       = RGB(90, 90, 90)
1057:                 .BackColor       = RGB(255, 255, 255)
1058:                 .Themes          = .T.
1059:                 .TabIndex        = 82
1060:             ENDWITH
1061:             BINDEVENT(THIS.cmd_4c_BtnPastasA, "Click", THIS, "BtnPastasAClick")
1062:         CATCH TO loc_oErro
1063:             MsgErro(loc_oErro.Message + CHR(13) + ;
1064:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1065:                 "Procedure: " + loc_oErro.Procedure, ;
1066:                 "Erro Formsigprpdf.ConfigurarAreaArquivoSaida")
1067:         ENDTRY
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * AplicarTipoArquivoPadrao - Reproduz as duas linhas do Init legado que
1072:     * definem o tipo de arquivo inicial:
1073:     *   thisform.optArquivo.option1.Enabled = <PDFCreator instalado?>
1074:     *   thisform.optArquivo.Value = Iif(thisform.optArquivo.option1.Enabled,1,2)
1075:     * A EXPRESSAO e' a do legado; o que mudou e' a ORIGEM do "PDFCreator
1076:     * instalado?", que agora e' this_lPdfCreatorDisponivel do BO, resolvido
1077:     * como .T. (ver "DIVERGENCIAS DELIBERADAS DO SCX" no cabecalho - a deteccao
1078:     * por Registro/COM nao foi portada porque a geracao do PDF nao esta neste
1079:     * acervo, e desabilitar PDF aqui mataria a tela).
1080:     *--------------------------------------------------------------------------
1081:     PROCEDURE AplicarTipoArquivoPadrao()
1082:         LOCAL loc_lPdfDisponivel
1083: 
1084:         *-- Ponto UNICO a trocar se a deteccao real do PDFCreator for portada
1085:         THIS.this_oBusinessObject.this_lPdfCreatorDisponivel = .T.
1086:         loc_lPdfDisponivel = THIS.this_oBusinessObject.this_lPdfCreatorDisponivel
1087: 
1088:         THIS.obj_4c_OptArquivo.Buttons(1).Enabled = loc_lPdfDisponivel
1089:         THIS.obj_4c_OptArquivo.Value              = IIF(loc_lPdfDisponivel, 1, 2)
1090: 
1091:         THIS.AplicarNomeArquivoPadrao()
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * AplicarNomeArquivoPadrao - Escreve no campo o nome default do arquivo de
1096:     * saida para o tipo selecionado, equivalente ao
1097:     *   thisform.txtNomeArqSaida.Value = ThisForm.Diretorio + [FORTYUSPDF.PDF]
1098:     *                                  / ThisForm.Diretorio + [FORTYUSEXCEL.XLS]
1099:     * do PROCEDURE Click do optArquivo legado. A montagem do nome fica no BO
1100:     * (ObterNomeArquivoPadrao), que e' quem conhece o diretorio - fonte UNICA
1101:     * para o Init e para o Click; o valor tambem e' guardado em
1102:     * this_cArquivoSaida, que e' o que o Cmd_GerarPDF devolve ao form pai.
1103:     *
1104:     * Nota de fidelidade: o Init legado monta o nome com uma expressao um pouco
1105:     * diferente do Click - "Diretorio + [FORTYUSPDF.] + Iif(Value = 1,[PDF],
1106:     * [XLS])", isto e', no Init o XLS sairia como FORTYUSPDF.XLS e no Click como
1107:     * FORTYUSEXCEL.XLS. Com o default Value = 1 as duas expressoes dao o MESMO
1108:     * resultado (FORTYUSPDF.PDF), logo usar a do Click aqui nao muda nada hoje;
1109:     * a divergencia so apareceria se a opcao PDF nascesse desabilitada, o que
1110:     * depende da deteccao do PDFCreator que nao foi portada (ver cabecalho).
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE AplicarNomeArquivoPadrao()
1113:         LOCAL loc_cArquivo
1114: 
1115:         THIS.this_oBusinessObject.this_nTipoArquivo = THIS.obj_4c_OptArquivo.Value
1116: 
1117:         loc_cArquivo = THIS.this_oBusinessObject.ObterNomeArquivoPadrao( ;
1118:                            THIS.this_oBusinessObject.this_nTipoArquivo)
1119: 
1120:         THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
1121:         THIS.txt_4c_TxtNomeArqSaida.Value            = loc_cArquivo
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * AlternarPainelEmail - Mostra/esconde o bloco de e-mail esticando ou
1126:     * encolhendo o form na ALTURA DO CONTAINER, equivalente ao PROCEDURE Click
1127:     * do Chk_EMAIL legado:
1128:     *   ThisForm.LockScreen = .T.
1129:     *   If This.Value = 1
1130:     *       ThisForm.Cmd_GerarPDF.Caption = "Enviar Email"
1131:     *       ThisForm.Height = ThisForm.Height + ThisForm.CtnSaida_Email.Height
1132:     *       ThisForm.CtnSaida_Email.Visible = .T.
1133:     *   Else
1134:     *       ThisForm.Cmd_GerarPDF.Caption = [\<Gravar]
1135:     *       ThisForm.Height = ThisForm.Height - ThisForm.CtnSaida_Email.Height
1136:     *       ThisForm.CtnSaida_Email.Visible = .F.
1137:     *   EndIf
1138:     *   ThisForm.Refresh() / ThisForm.LockScreen = .F.
1139:     * e tambem ao colapso inicial do Init ("Thisform.Height = This.Height -
1140:     * This.CtnSaida_Email.Height" + "CtnSaida_Email.Visible = .F."), que e' a
1141:     * pendencia que a Fase 3 deixou anotada. O mesmo metodo serve aos dois
1142:     * porque o legado faz exatamente a mesma conta nos dois lugares (360 - 185
1143:     * = 175 colapsado; 175 + 185 = 360 expandido).
1144:     *
1145:     * A troca do Caption do Cmd_GerarPDF NAO esta aqui, e sim no
1146:     * ChkEmailClick: no legado ela existe SO dentro do Chk_EMAIL.Click - o
1147:     * colapso do Init nao mexe no Caption. Com a troca aqui dentro, o Init
1148:     * (que chama este metodo com .F.) sobrescrevia "   Gravar" por "\<Gravar"
1149:     * e a tela ja abria com o rotulo do estado alternado, perdendo os espacos
1150:     * que alinham o texto com o icone - medido no VFP9 em 2026-10-18.
1151:     *
1152:     * A altura so muda quando o estado REALMENTE muda - chamar duas vezes
1153:     * seguidas com o mesmo valor nao encolhe a tela duas vezes (o legado nao
1154:     * precisava desse cuidado porque o Click so dispara quando o usuario
1155:     * alterna, mas aqui o Init tambem chama). O estado comparado e'
1156:     * this_lPainelEmailVisivel, que nasce .T. por refletir a ALTURA DE PROJETO
1157:     * do SCX - e NAO o cnt_4c_CtnSaida_Email.Visible, que nasce .F. (ver a
1158:     * declaracao da property: usar o Visible como guarda transforma o colapso
1159:     * do Init em no-op silencioso).
1160:     *
1161:     * Caption: o Else legado restaura o literal "\<Gravar" (com o "\<" de tecla
1162:     * de atalho do VFP), e NAO o Caption de origem "   Gravar" - a alternativa
1163:     * via Tag esta comentada no proprio fonte legado ("&&ThisForm.Cmd_OK.Tag").
1164:     * Transcrito como esta no legado, inclusive a perda dos espacos de
1165:     * alinhamento com o icone.
1166:     *--------------------------------------------------------------------------
1167:     PROCEDURE AlternarPainelEmail(par_lMostrar)
1168:         LOCAL loc_lMostrar, loc_nAlturaPainel, loc_oErro
1169: 
1170:         loc_lMostrar = IIF(VARTYPE(par_lMostrar) = "L", par_lMostrar, .F.)
1171: 
1172:         TRY
1173:             IF loc_lMostrar != THIS.this_lPainelEmailVisivel
1174:                 loc_nAlturaPainel = THIS.cnt_4c_CtnSaida_Email.Height
1175: 
1176:                 THIS.LockScreen = .T.
1177: 
1178:                 *-- Protege o que o legado protege com "AutoCenter = .F." no
1179:                 *-- fim do Init: a janela nao deve se recentralizar a cada
1180:                 *-- colapso/expansao do painel. SO com a tela ja visivel: se
1181:                 *-- fosse desligado durante o Init (onde Visible ainda e' .F.,
1182:                 *-- porque o Show() vem depois), o dialogo JA COLAPSADO nasceria
1183:                 *-- em Top = 0 / Left = 0 em vez de centralizado.
1184:                 IF THIS.Visible
1185:                     THIS.AutoCenter = .F.
1186:                 ENDIF
1187: 
1188:                 IF loc_lMostrar
1189:                     THIS.Height                        = THIS.Height + loc_nAlturaPainel
1190:                     THIS.cnt_4c_CtnSaida_Email.Visible = .T.
1191:                 ELSE
1192:                     THIS.Height                        = THIS.Height - loc_nAlturaPainel
1193:                     THIS.cnt_4c_CtnSaida_Email.Visible = .F.
1194:                 ENDIF
1195: 
1196:                 THIS.this_lPainelEmailVisivel = loc_lMostrar
1197: 
1198:                 *-- Equivalente a "ThisForm.Chk_EMAIL.Value = 1" que o
1199:                 *-- Cmd_GerarPDF.Click legado consulta para decidir se monta o
1200:                 *-- objeto de envio
1201:                 THIS.this_oBusinessObject.this_lEnviarEmail = loc_lMostrar
1202: 
1203:                 THIS.Refresh()
1204:                 THIS.LockScreen = .F.
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             THIS.LockScreen = .F.
1208:             MsgErro(loc_oErro.Message + CHR(13) + ;
1209:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1210:                 "Procedure: " + loc_oErro.Procedure, ;
1211:                 "Erro Formsigprpdf.AlternarPainelEmail")
1212:         ENDTRY
1213:     ENDPROC
1214: 
1215:     *--------------------------------------------------------------------------
1216:     * CarregarContaEmailEmpresa - Equivalente ao trecho final do Init legado:
1217:     *   lcQuery = [Select PadEmails, PadServs, PadSenhas, pastas, PadPortas
1218:     *              From SigCdEmp Where CEmps = '] + _EMPR + [']
1219:     *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmpMail') < 1)
1220:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexao (TmpEmpMail)')
1221:     *       Return .f.
1222:     *   Endif
1223:     * A consulta propriamente dita esta no BO (ObterDadosContaEmail), que ja
1224:     * trata o cursor e mapeia as colunas em CarregarDoCursor. A empresa vem de
1225:     * go_4c_Sistema.cCodEmpresa - a global legada _EMPR NUNCA deve ser usada.
1226:     *
1227:     * Retorna .F. quando a consulta falha, reproduzindo o "Return .f." do
1228:     * legado - isto e', a tela NAO abre, porque sem os dados de SMTP o envio de
1229:     * e-mail nao teria como funcionar. Em modo de validacao de UI (sem conexao
1230:     * SQL) a consulta e' pulada e o retorno e' .T., senao nenhuma validacao
1231:     * conseguiria instanciar o form.
1232:     *
1233:     * O preenchimento visual que o legado faz em seguida
1234:     * ("CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
1235:     * TmpEmpMail.PadEmails,[])))") agora fica aqui: txt_4c_TxtEmail_EnviarDE
1236:     * (criado em ConfigurarCamposEmail, que roda ANTES deste metodo no
1237:     * InicializarForm) recebe this_cEmailDe so DEPOIS da consulta - exatamente
1238:     * como no legado, onde a atribuicao vem depois do
1239:     * "SqlExecute(lcQuery, 'TmpEmpMail')".
1240:     *--------------------------------------------------------------------------
1241:     PROCEDURE CarregarContaEmailEmpresa()
1242:         LOCAL loc_lSucesso, loc_cEmpresa
1243: 
1244:         loc_lSucesso = .T.
1245: 
1246:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
1247:             loc_cEmpresa = ""
1248:             IF TYPE("go_4c_Sistema") = "O"
1249:                 loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
1250:             ENDIF
1251: 
1252:             IF !THIS.this_oBusinessObject.ObterDadosContaEmail(loc_cEmpresa)
1253:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1254:                         "Falha na Conex" + CHR(227) + "o (TmpEmpMail)")
1255:                 loc_lSucesso = .F.
1256:             ELSE
1257:                 THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_EnviarDE.Value = ;
1258:                     THIS.this_oBusinessObject.this_cEmailDe
1259:             ENDIF
1260:         ENDIF
1261: 
1262:         RETURN loc_lSucesso
1263:     ENDPROC
1264: 
1265:     *--------------------------------------------------------------------------
1266:     * SincronizarCamposParaBO - Espelha TELA -> BO todos os controles de entrada
1267:     * do dialogo. PUBLIC: chamado por ValidarDadosEnvio() e pela fase de eventos
1268:     * (o Click do cmd_4c_Cmd_GerarPDF, que precisa dos valores no BO para
1269:     * MontarDadosEnvioEmail()).
1270:     *
1271:     * Por que o CONTROLE e' a fonte unica do valor: o Cmd_GerarPDF.Click legado
1272:     * nao consulta estado guardado em lugar nenhum, ele le o .Value na hora -
1273:     *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))
1274:     *   lcFrom = AllTrim(Nvl(ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.Value,   ""))
1275:     *   lcTO   = AllTrim(Nvl(ThisForm.CtnSaida_Email.txtEmail_EnviarPara.Value, ""))
1276:     *   ...AddProperty("cCC",      AllTrim(Nvl(...txtEmail_CC.Value, "")))
1277:     *   ...AddProperty("cAssunto", AllTrim(Nvl(...txtEmail_Assunto.Value, "")))
1278:     *   ...AddProperty("cCorpo",   AllTrim(Nvl(...EdtEmail_Corpo.Value, "")))
1279:     *   If ThisForm.Chk_EMAIL.Value = 1
1280:     * Validar contra a property do BO sem reler a tela antes validaria o valor
1281:     * ANTIGO - o usuario limparia o campo 'PARA:' e a tela aprovaria o e-mail
1282:     * que estava la na abertura. O ALLTRIM/TratarNulo reproduz o Alltrim(Nvl())
1283:     * de cada linha acima.
1284:     *
1285:     * Chk_EMAIL.Value e' NUMERICO (CheckBox criado por AddObject): compara-se
1286:     * com 1 para virar o Logico this_lEnviarEmail - atribuir o numero direto a
1287:     * uma property declarada .F. faria o proximo AND no BO estourar.
1288:     * obj_4c_OptArquivo.Value e' o INDICE 1-based do OptionGroup (1 = PDF,
1289:     * 2 = XLS), nunca booleano.
1290:     *--------------------------------------------------------------------------
1291:     PROCEDURE SincronizarCamposParaBO()
1292:         LOCAL loc_oBO, loc_oPainel
1293: 
1294:         loc_oBO     = THIS.this_oBusinessObject
1295:         loc_oPainel = THIS.cnt_4c_CtnSaida_Email
1296: 
1297:         loc_oBO.this_cArquivoSaida = ALLTRIM(TratarNulo(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
1298:         loc_oBO.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
1299:         loc_oBO.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)
1300: 
1301:         loc_oBO.this_cEmailDe      = ALLTRIM(TratarNulo(loc_oPainel.txt_4c_TxtEmail_EnviarDE.Value, ""))
1302:         loc_oBO.this_cEmailPara    = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_TxtEmail_EnviarPara.Value, ""))
1303:         loc_oBO.this_cEmailCC      = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_TxtEmail_CC.Value, ""))
1304:         loc_oBO.this_cEmailAssunto = ALLTRIM(TratarNulo(loc_oPainel.txt_4c_TxtEmail_Assunto.Value, ""))
1305:         loc_oBO.this_cEmailCorpo   = ALLTRIM(TratarNulo(loc_oPainel.obj_4c_EdtEmail_Corpo.Value, ""))
1306:     ENDPROC
1307: 
1308:     *--------------------------------------------------------------------------
1309:     * ValidarDadosEnvio - Reproduz as checagens BLOQUEANTES que o
1310:     * Cmd_GerarPDF.Click legado faz sobre os campos desta tela, na mesma ordem,
1311:     * com a mesma mensagem e o mesmo SetFocus:
1312:     *   If Empty( ThisForm.oParentForm.pcArqEmail)
1313:     *       MessageBox([Selecione um nome para o arquivo!], 48, [Atencao])
1314:     *       This.Parent.CmdGetFile.SetFocus() / Return
1315:     *   If ThisForm.Chk_EMAIL.Value = 1
1316:     *       If Empty( lcFrom )
1317:     *           MessageBox("O campo 'DE:' nao foi preenchido.", 48, "Atencao")
1318:     *           ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.SetFocus() / Return
1319:     *       If Empty( lcTO )
1320:     *           MessageBox("O campo 'PARA:' nao foi preenchido.", 48, "Atencao")
1321:     *           ThisForm.CtnSaida_Email.txtEmail_EnviarPara.SetFocus() / Return
1322:     * Devolve .T. quando passou e .F. quando recusou (ja tendo exibido a
1323:     * mensagem e dado o foco), para a fase de eventos escrever
1324:     * "IF !THIS.ValidarDadosEnvio() / RETURN / ENDIF" no Click do botao.
1325:     *
1326:     * PUBLIC porque e' chamado de fora (pelo handler do cmd_4c_Cmd_GerarPDF).
1327:     *
1328:     * FONTE UNICA DA REGRA: o texto e a ORDEM das tres checagens moram em
1329:     * sigprpdfBO.ValidarDadosConfirmacao(), que e' quem para na PRIMEIRA falha e
1330:     * devolve this_cMensagemErro + this_cCampoInvalido. Aqui fica so o que o BO
1331:     * nao pode fazer: ler a tela ANTES de validar (SincronizarCamposParaBO) e
1332:     * dar o foco ao campo recusado.
1333:     *
1334:     * MsgAviso, nao MsgErro: o legado usa MessageBox(..., 48, ...), isto e',
1335:     * icone de AVISO - e sao recusas de preenchimento (validacao de tela), nao
1336:     * falha tecnica. MESSAGEBOX direto e' proibido (nao se suprime em teste).
1337:     *
1338:     * O QUE NAO E' REPRODUZIDO AQUI, e por que: o legado envolve as checagens de
1339:     * 'DE:'/'PARA:' num gate a mais - "If Used('TmpEmpMail') And
1340:     * RecCount('TmpEmpMail') > 0" - e, SEM a conta de e-mail da empresa, nao
1341:     * valida os dois campos: cai no Else, exibe "Problemas na selecao de dados
1342:     * do email..." (sem Return) e fecha o dialogo. Esse ramo e' inalcancavel na
1343:     * arquitetura nova: a consulta a SigCdEmp roda no InicializarForm
1344:     * (CarregarContaEmailEmpresa) e, falhando, devolve .F. - o form NAO ABRE,
1345:     * igual ao "Return .f." do Init legado. Ou seja, com a tela aberta
1346:     * this_lContaEmailCarregada e' sempre .T. e o gate e' sempre verdadeiro. O
1347:     * aviso nao-bloqueante continua existindo e e' da fase de eventos, que ja
1348:     * tem no BO ObterMensagemContaEmailIndisponivel() + this_lContaEmailCarregada
1349:     * para exibi-lo sem impedir o fechamento.
1350:     *--------------------------------------------------------------------------
1351:     PROCEDURE ValidarDadosEnvio()
1352:         LOCAL loc_lValido, loc_oBO, loc_oErro
1353: 
1354:         loc_lValido = .F.
1355: 
1356:         TRY
1357:             THIS.SincronizarCamposParaBO()
1358: 
1359:             loc_oBO     = THIS.this_oBusinessObject
1360:             loc_lValido = loc_oBO.ValidarDadosConfirmacao()
1361: 
1362:             IF !loc_lValido
1363:                 MsgAviso(loc_oBO.this_cMensagemErro, ;
1364:                          "Aten" + CHR(231) + CHR(227) + "o")
1365:                 THIS.FocarCampoInvalido(loc_oBO.this_cCampoInvalido)
1366:             ENDIF
1367:         CATCH TO loc_oErro
1368:             loc_lValido = .F.
1369:             MsgErro(loc_oErro.Message + CHR(13) + ;
1370:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1371:                 "Procedure: " + loc_oErro.Procedure, ;
1372:                 "Erro Formsigprpdf.ValidarDadosEnvio")
1373:         ENDTRY
1374: 
1375:         RETURN loc_lValido
1376:     ENDPROC
1377: 
1378:     *--------------------------------------------------------------------------
1379:     * FocarCampoInvalido - Devolve o foco ao controle recusado pela validacao,
1380:     * traduzindo o this_cCampoInvalido que o BO preenche para o controle
1381:     * correspondente da tela. Os tres destinos sao os do legado:
1382:     *   ARQUIVO    -> This.Parent.CmdGetFile.SetFocus()
1383:     *                 (o legado foca o BOTAO de escolha, nao o campo - o campo
1384:     *                 e' ReadOnly, nao ha o que digitar nele)
1385:     *   EMAIL_DE   -> ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.SetFocus()
1386:     *   EMAIL_PARA -> ThisForm.CtnSaida_Email.txtEmail_EnviarPara.SetFocus()
1387:     *
1388:     * Os dois destinos do painel so sao alcancados quando this_lEnviarEmail =
1389:     * .T., caso em que o painel esta expandido; o IF .Visible esta aqui porque
1390:     * SetFocus em controle dentro de container oculto estoura em runtime, e
1391:     * perder o foco nunca pode custar a mensagem de validacao que o usuario
1392:     * precisa ler.
1393:     *--------------------------------------------------------------------------
1394:     PROTECTED PROCEDURE FocarCampoInvalido(par_cCampo)
1395:         LOCAL loc_cCampo, loc_oPainel
1396: 
1397:         loc_cCampo  = UPPER(ALLTRIM(TratarNulo(par_cCampo, "")))
1398:         loc_oPainel = THIS.cnt_4c_CtnSaida_Email
1399: 
1400:         DO CASE
1401:             CASE loc_cCampo == "ARQUIVO"
1402:                 THIS.cmd_4c_CmdGetFile.SetFocus()
1403:             CASE loc_cCampo == "EMAIL_DE"
1404:                 IF loc_oPainel.Visible
1405:                     loc_oPainel.txt_4c_TxtEmail_EnviarDE.SetFocus()
1406:                 ENDIF
1407:             CASE loc_cCampo == "EMAIL_PARA"
1408:                 IF loc_oPainel.Visible
1409:                     loc_oPainel.obj_4c_TxtEmail_EnviarPara.SetFocus()
1410:                 ENDIF
1411:         ENDCASE
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * CmdGerarPDFClick - PROCEDURE Click do Cmd_GerarPDF legado:
1416:     *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))
1417:     *   If Empty(ThisForm.oParentForm.pcArqEmail)
1418:     *       MessageBox([Selecione um nome para o arquivo!], 48, [Atencao])
1419:     *       This.Parent.CmdGetFile.SetFocus() / Return
1420:     *   EndIf
1421:     *   If ThisForm.Chk_EMAIL.Value = 1
1422:     *       If Used("TmpEmpMail") And RecCount("TmpEmpMail") > 0
1423:     *           ** valida 'DE:'/'PARA:', monta o objeto de envio (AddProperty) e
1424:     *           ** grava em ThisForm.oParentForm.oEMAIL
1425:     *       Else
1426:     *           MessageBox("Problemas na selecao de dados do email...", 48, "Atencao")
1427:     *           ** SEM Return - o legado fecha o dialogo mesmo assim
1428:     *       EndIf
1429:     *   EndIf
1430:     *   ThisForm.Release()
1431:     * PUBLIC (alvo de BINDEVENT).
1432:     *
1433:     * As duas checagens bloqueantes do legado (arquivo vazio / 'DE:'-'PARA:'
1434:     * vazios quando Chk_EMAIL esta marcado) sao as mesmas que
1435:     * THIS.ValidarDadosEnvio() ja reproduz - ela sincroniza a tela com o BO,
1436:     * chama ValidarDadosConfirmacao() e da o foco ao campo recusado.
1437:     * Falhando, o RETURN aqui e' o equivalente aos dois "Return" do legado -
1438:     * ANTES do TRY, nunca dentro (RETURN dentro de TRY/CATCH e' proibido).
1439:     *
1440:     * O terceiro caso do legado ("Used('TmpEmpMail') And RecCount('TmpEmpMail')
1441:     * > 0" = .F.) NAO bloqueia: exibe o aviso e fecha o dialogo mesmo assim.
1442:     * Na arquitetura nova esse ramo e' praticamente inalcancavel com a tela
1443:     * aberta (this_lContaEmailCarregada e' sempre .T. - a consulta que o
1444:     * alimenta roda no InicializarForm e, falhando, o form nao abre - ver nota
1445:     * em ValidarDadosEnvio), mas o aviso nao-bloqueante e' reproduzido do
1446:     * mesmo jeito via ObterMensagemContaEmailIndisponivel(), para o caso
1447:     * defensivo de this_lContaEmailCarregada estar .F. com a tela ja visivel.
1448:     *
1449:     * pcArqEmail/oEmail sao properties do form PAI (fora deste acervo) - mesmo
1450:     * padrao de PEMSTATUS usado em CmdSairClick: so se escreve se existirem.
1451:     *--------------------------------------------------------------------------
1452:     PROCEDURE CmdGerarPDFClick()
1453:         LOCAL loc_oPai, loc_oBO, loc_oEmail, loc_oErro
1454: 
1455:         IF !THIS.ValidarDadosEnvio()
1456:             RETURN
1457:         ENDIF
1458: 
1459:         TRY
1460:             loc_oPai = THIS.this_oFormPai
1461:             loc_oBO  = THIS.this_oBusinessObject
1462: 
1463:             IF VARTYPE(loc_oPai) = "O"
1464:                 IF PEMSTATUS(loc_oPai, "pcArqEmail", 5)
1465:                     loc_oPai.pcArqEmail = loc_oBO.this_cArquivoSaida
1466:                 ENDIF
1467: 
1468:                 IF loc_oBO.this_lEnviarEmail
1469:                     IF loc_oBO.this_lContaEmailCarregada
1470:                         loc_oEmail = loc_oBO.MontarDadosEnvioEmail()
1471:                         IF PEMSTATUS(loc_oPai, "oEmail", 5)
1472:                             loc_oPai.oEmail = loc_oEmail
1473:                         ENDIF
1474:                     ELSE
1475:                         MsgAviso(loc_oBO.ObterMensagemContaEmailIndisponivel(), ;
1476:                                  "Aten" + CHR(231) + CHR(227) + "o")
1477:                     ENDIF
1478:                 ENDIF
1479:             ENDIF
1480:         CATCH TO loc_oErro
1481:             MsgErro(loc_oErro.Message + CHR(13) + ;
1482:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1483:                 "Procedure: " + loc_oErro.Procedure, ;
1484:                 "Erro Formsigprpdf.CmdGerarPDFClick")
1485:         ENDTRY
1486: 
1487:         THIS.Release()
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * ChkEmailClick - PROCEDURE Click do Chk_EMAIL legado. PUBLIC (alvo de
1492:     * BINDEVENT). CheckBox.Value e' NUMERICO: compara-se com 1, nunca com .T.
1493:     *
1494:     * O Caption do Cmd_GerarPDF e' trocado AQUI porque no legado ele so muda
1495:     * dentro deste Click (o colapso do Init nao o toca - ver nota em
1496:     * AlternarPainelEmail). O literal "\<Gravar" do ramo Else e' transcrito como
1497:     * esta no legado, inclusive sem os espacos de alinhamento do Caption de
1498:     * origem "   Gravar" e com o "\<" de tecla de atalho do VFP - o proprio
1499:     * fonte legado deixa a alternativa via Tag COMENTADA ("&&ThisForm.Cmd_OK.Tag").
1500:     *--------------------------------------------------------------------------
1501:     PROCEDURE ChkEmailClick()
1502:         LOCAL loc_lMarcado
1503: 
1504:         loc_lMarcado = (THIS.chk_4c_Chk_EMAIL.Value = 1)
1505: 
1506:         THIS.cmd_4c_Cmd_GerarPDF.Caption = IIF(loc_lMarcado, "Enviar Email", "\<Gravar")
1507: 
1508:         THIS.AlternarPainelEmail(loc_lMarcado)
1509:     ENDPROC
1510: 
1511:     *--------------------------------------------------------------------------
1512:     * OptArquivoClick - PROCEDURE Click do optArquivo legado: trocar entre PDF
1513:     * e Excel reescreve o nome default do arquivo de saida. PUBLIC (alvo de
1514:     * BINDEVENT). O parametro existe porque o Click de OptionGroup pode receber
1515:     * o indice do botao acionado (handler de BINDEVENT declara os parametros do
1516:     * evento).
1517:     *--------------------------------------------------------------------------
1518:     PROCEDURE OptArquivoClick(par_nIndiceBotao)
1519:         THIS.AplicarNomeArquivoPadrao()
1520:     ENDPROC
1521: 
1522:     *--------------------------------------------------------------------------
1523:     * CmdGetFileClick - PROCEDURE Click do cmdGetFile legado:
1524:     *   lcTpArq    = Iif(thisform.optArquivo.Value = 1,[PDF],[XLS])
1525:     *   lcArqSaida = GetFile( lcTpArq, [Arquivo:],[Selecionar],0,[Selecione o arquivo])
1526:     *   If isEmpty( lcArqSaida ) / Return / EndIf
1527:     *   If JUSTEXT(lcArqSaida) $ lcTpArq / ** extensao valida
1528:     *   Else / lcArqSaida = ForceExt(lcArqSaida, Left( lcTpArq, 3 )) / EndIf
1529:     *   ThisForm.TxtNomeArqSaida.Value = Alltrim( lcArqSaida )
1530:     * PUBLIC (alvo de BINDEVENT).
1531:     *
1532:     * O "isEmpty" do legado e' funcao global do framework Fortyus; em codigo
1533:     * nosso usa-se EMPTY() direto (ISEMPTY nao existe no VFP9 - o wrapper
1534:     * utils\isempty.prg existe so para o p-code dos VCX legado). JUSTEXT e
1535:     * FORCEEXT sao nativas do VFP9, nao helpers do legado.
1536:     *
1537:     * Cancelar o dialogo de arquivo NAO limpa o campo: o legado so devolve sem
1538:     * mexer, mantendo o caminho que ja estava la. O early "Return" do legado
1539:     * virou o IF !EMPTY(...) porque RETURN dentro de TRY/CATCH e' proibido.
1540:     *--------------------------------------------------------------------------
1541:     PROCEDURE CmdGetFileClick()
1542:         LOCAL loc_cTipoArq, loc_cArqSaida, loc_oErro
1543: 
1544:         TRY
1545:             loc_cTipoArq  = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
1546:             loc_cArqSaida = GETFILE(loc_cTipoArq, "Arquivo:", "Selecionar", 0, ;
1547:                                     "Selecione o arquivo")
1548: 
1549:             IF !EMPTY(loc_cArqSaida)
1550:                 *-- Extensao diferente da escolhida no optArquivo: forca a certa
1551:                 IF !(JUSTEXT(loc_cArqSaida) $ loc_cTipoArq)
1552:                     loc_cArqSaida = FORCEEXT(loc_cArqSaida, LEFT(loc_cTipoArq, 3))
1553:                 ENDIF
1554: 
1555:                 loc_cArqSaida = ALLTRIM(loc_cArqSaida)
1556: 
1557:                 THIS.txt_4c_TxtNomeArqSaida.Value            = loc_cArqSaida
1558:                 THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArqSaida
1559:             ENDIF
1560:         CATCH TO loc_oErro
1561:             MsgErro(loc_oErro.Message + CHR(13) + ;
1562:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1563:                 "Procedure: " + loc_oErro.Procedure, ;
1564:                 "Erro Formsigprpdf.CmdGetFileClick")
1565:         ENDTRY
1566:     ENDPROC
1567: 
1568:     *--------------------------------------------------------------------------
1569:     * BtnPastasAClick - PROCEDURE Click do btnPastasA legado: abre o diretorio
1570:     * de saida no Explorer.
1571:     *   lcDir = ThisForm.Diretorio
1572:     *   If Not Empty(lcDir)
1573:     *       If Not Directory(lcDir) / MessageBox([Diretorio nao Localizado],0+64,[Atencao])
1574:     *       Else / loApp = CreateObject([Shell.Application]) / loApp.Open(lcDir) / EndIf
1575:     *   EndIf
1576:     * PUBLIC (alvo de BINDEVENT). O diretorio vem de this_cDiretorio do BO
1577:     * (equivalente a ThisForm.Diretorio, resolvido no InicializarForm a partir
1578:     * de go_4c_Sistema.DirFiscais).
1579:     *
1580:     * A mensagem de diretorio ausente e' validacao de tela, logo MsgAviso -
1581:     * MESSAGEBOX direto e' proibido (nao se suprime em teste automatizado).
1582:     *--------------------------------------------------------------------------
1583:     PROCEDURE BtnPastasAClick()
1584:         LOCAL loc_cDir, loc_oShell, loc_oErro
1585: 
1586:         TRY
1587:             loc_cDir = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cDiretorio, ""))
1588: 
1589:             IF !EMPTY(loc_cDir)
1590:                 IF !DIRECTORY(loc_cDir)
1591:                     MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", ;
1592:                              "Aten" + CHR(231) + CHR(227) + "o")
1593:                 ELSE
1594:                     loc_oShell = CREATEOBJECT("Shell.Application")
1595:                     loc_oShell.Open(loc_cDir)
1596:                     loc_oShell = .NULL.
1597:                 ENDIF
1598:             ENDIF
1599:         CATCH TO loc_oErro
1600:             MsgErro(loc_oErro.Message + CHR(13) + ;
1601:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1602:                 "Procedure: " + loc_oErro.Procedure, ;
1603:                 "Erro Formsigprpdf.BtnPastasAClick")
1604:         ENDTRY
1605:     ENDPROC
1606: 
1607:     *--------------------------------------------------------------------------
1608:     * CmdSairClick - PROCEDURE Click do Cmd_SAIR legado:
1609:     *   thisform.oparentform.pcArqEmail = []
1610:     *   thisform.oparentform.oEmail = Null
1611:     *   ThisForm.Release()
1612:     * PUBLIC (alvo de BINDEVENT). Cancelar o dialogo LIMPA o resultado no form
1613:     * pai - e' assim que o chamador distingue "cancelou" de "confirmou" (o
1614:     * Cmd_GerarPDF e' que grava o caminho e o objeto de envio).
1615:     *
1616:     * As duas properties sao do form PAI (pcArqEmail / oEmail), criadas por
1617:     * ele; so se escreve nelas se existirem. O PEMSTATUS aqui nao mascara
1618:     * defeito nosso - e' nao assumir a superficie de um form que nao faz parte
1619:     * deste acervo (este dialogo e' chamado por varios).
1620:     *--------------------------------------------------------------------------
1621:     PROCEDURE CmdSairClick()
1622:         LOCAL loc_oPai, loc_oErro
1623: 
1624:         TRY
1625:             loc_oPai = THIS.this_oFormPai
1626: 
1627:             IF VARTYPE(loc_oPai) = "O"
1628:                 IF PEMSTATUS(loc_oPai, "pcArqEmail", 5)
1629:                     loc_oPai.pcArqEmail = ""
1630:                 ENDIF
1631:                 IF PEMSTATUS(loc_oPai, "oEmail", 5)
1632:                     loc_oPai.oEmail = .NULL.
1633:                 ENDIF
1634:             ENDIF
1635:         CATCH TO loc_oErro
1636:             MsgErro(loc_oErro.Message + CHR(13) + ;
1637:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1638:                 "Procedure: " + loc_oErro.Procedure, ;
1639:                 "Erro Formsigprpdf.CmdSairClick")
1640:         ENDTRY
1641: 
1642:         THIS.Release()
1643:     ENDPROC
1644: 
1645:     *--------------------------------------------------------------------------
1646:     * TornarControlesVisiveis - Torna visiveis todos os controles do form,
1647:     * percorrendo containers e paginas de PageFrame recursivamente. AddObject
1648:     * cria controles com Visible = .F. por padrao.
1649:     *
1650:     * cnt_4c_CtnSaida_Email e' container FLUTUANTE (nasce oculto e e' alternado
1651:     * pelo Chk_EMAIL): o .Visible DELE nao pode ser ligado aqui. Mas a recursao
1652:     * TEM de acontecer mesmo assim, para os filhos dele ficarem com
1653:     * Visible = .T. - senao, quando o usuario marca Email, o painel aparece
1654:     * VAZIO (os campos continuariam invisiveis para sempre).
1655:     *--------------------------------------------------------------------------
1656:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1657:         LOCAL loc_nI, loc_oObjeto
1658: 
1659:         IF VARTYPE(par_oContainer) != "O"
1660:             RETURN
1661:         ENDIF
1662: 
1663:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1664:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1665: 
1666:             IF VARTYPE(loc_oObjeto) = "O"
1667:                 *-- Container flutuante: recursa nos filhos, NAO liga o proprio
1668:                 IF UPPER(ALLTRIM(loc_oObjeto.Name)) == "CNT_4C_CTNSAIDA_EMAIL"
1669:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1670:                     LOOP
1671:                 ENDIF
1672: 
1673:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1674:                     loc_oObjeto.Visible = .T.
1675:                 ENDIF
1676: 
1677:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1678:                     LOCAL loc_nP
1679:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1680:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1681:                     ENDFOR
1682:                 ENDIF
1683: 
1684:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1685:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1686:                 ENDIF
1687:             ENDIF
1688:         ENDFOR
1689:     ENDPROC
1690: 
1691:     *--------------------------------------------------------------------------
1692:     * Destroy - Libera o Business Object (que por sua vez libera o cursor de
1693:     * trabalho aberto - ver sigprpdfBO.Destroy)
1694:     *--------------------------------------------------------------------------
1695:     PROCEDURE Destroy()
1696:         DODEFAULT()
1697:     ENDPROC
1698: 
1699: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* SIGPRPDFBO.PRG
* Business Object do formulario Formsigprpdf (Geracao de PDF e E-mail)
* Herda de: BusinessBase
*
* SIGPRPDF e um DIALOGO FILHO (WindowType = 1, modal), instanciado por outro
* form (par_oFormPai, equivalente a poformParent/ThisForm.oParentForm do
* legado) para o usuario escolher o nome/tipo do arquivo de saida (PDF ou
* XLS) e, opcionalmente, os dados do e-mail de envio. O proprio SIGPRPDF
* NAO gera o PDF/XLS nem envia o e-mail - o Cmd_GerarPDF.Click legado (linhas
* 749-823 do fonte original) apenas:
*   1) grava o caminho escolhido em ThisForm.oParentForm.pcArqEmail;
*   2) quando Chk_EMAIL.Value = 1, monta um objeto CUSTOM
*      (ThisForm.oParentForm.oEMAIL) com os dados de SMTP/mensagem via
*      AddProperty, e devolve esse objeto ao form PAI;
*   3) fecha o dialogo (ThisForm.Release()).
* Quem efetivamente gera o arquivo e dispara o envio e o form chamador
* (fora do escopo desta migracao - nao faz parte do acervo de SIGPRPDF).
*
* POR QUE this_cTabela/this_cCampoChave FICAM VAZIOS
* ---------------------------------------------------
* Nao ha CRUD nem PK proprios: a UNICA leitura ao SQL Server no Init legado
* e "Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp
* Where CEmps = <empresa>" (dados da conta de e-mail da empresa, colunas
* reais conferidas em docs/schema.sql - tabela sigcdemp: pademails,
* padservs, padsenhas, pastas, padportas). Nao ha Insert/Update/Delete em
* tabela nenhuma - por isso este BO (como o sigpremaBO irmao) nao sobrescreve
* Inserir()/Atualizar()/ExecutarExclusao(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao) ja e o correto para esta tela.
*
* REGISTRY1 / PDFCREATOR (optArquivo.Option1.Enabled) - DECISAO DEFERIDA
* ------------------------------------------------------------------------
* O legado habilita a opcao "PDF" conforme
* "ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
* ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" (deteccao de instalacao
* do PDFCreator via COM/Registro do Windows). O form irmao Formsigprema ja
* documentou a mesma checagem como NAO PORTADA (ver cabecalho de
* Formsigprema.prg) porque a geracao do PDF via PDFCreator esta fora do
* escopo do acervo migrado. A property this_lPdfCreatorDisponivel fica
* declarada aqui para a fase de Form decidir como resolve-la (registro real,
* sempre .T., ou configuravel) - Fase 1 so declara, nao decide.
*==============================================================================

DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Referencia ao form que instanciou este dialogo (equivalente a
    *-- ThisForm.oParentForm / par_oFormPai do legado) - usado para devolver
    *-- o caminho do arquivo escolhido (pcArqEmail) e os dados de envio
    *-- (oEMAIL) de volta ao chamador, e para ler o e-mail de destino inicial
    *-- (par_oFormPai.Contaemail)
    this_oFormPai = .NULL.

    *-- Diretorio padrao de saida (equivalente a ThisForm.Diretorio =
    *-- goSistema.DirFiscais), usado tanto para montar o nome default do
    *-- arquivo (FORTYUSPDF.PDF / FORTYUSEXCEL.XLS) quanto para abrir a
    *-- pasta via btnPastasA (CreateObject('Shell.Application').Open)
    this_cDiretorio = ""

    *-- Tipo de arquivo de saida (equivalente a optArquivo.Value - indice
    *-- 1-based do OptionGroup, NUNCA booleano): 1 = PDF, 2 = XLS
    this_nTipoArquivo = 1

    *-- .T. quando o PDFCreator (COM) esta disponivel na maquina
    *-- (equivalente a optArquivo.Option1.Enabled, resolvido via
    *-- Registry1.IsKey no legado - ver nota no cabecalho deste arquivo).
    *-- Resolucao definitiva fica para a fase do Form.
    this_lPdfCreatorDisponivel = .F.

    *-- Caminho completo do arquivo escolhido pelo usuario (equivalente a
    *-- txtNomeArqSaida.Value) - e o valor devolvido como
    *-- ThisForm.oParentForm.pcArqEmail ao confirmar (Cmd_GerarPDF.Click) e
    *-- tambem o anexo do e-mail (cAnexo) quando o envio esta habilitado
    this_cArquivoSaida = ""

    *-- .T. quando o usuario marcou a opcao de enviar e-mail (equivalente a
    *-- Chk_EMAIL.Value = 1) - controla a exibicao de CtnSaida_Email e se
    *-- Cmd_GerarPDF.Click monta o objeto de envio (oEMAIL) no form pai
    this_lEnviarEmail = .F.

    *-- Campos do bloco de e-mail (CtnSaida_Email), equivalentes a
    *-- cFrom/cTO/cCC/cAssunto/cCorpo do objeto oEMAIL montado no legado
    this_cEmailDe       = ""   && txtEmail_EnviarDE.Value (ReadOnly - preenchido com this_cEmpPadEmails)
    this_cEmailPara     = ""   && txtEmail_EnviarPara.Value (inicial: par_oFormPai.Contaemail)
    this_cEmailCC       = ""   && txtEmail_CC.Value
    this_cEmailAssunto  = ""   && txtEmail_Assunto.Value (inicial: par_cAssunto recebido no Init do form)
    this_cEmailCorpo    = ""   && EdtEmail_Corpo.Value

    *-- Dados da conta de e-mail da empresa (SigCdEmp.Cemps = empresa
    *-- corrente), equivalentes ao cursor TmpEmpMail do legado - colunas
    *-- reais conferidas em docs/schema.sql: pademails, padservs, padsenhas,
    *-- pastas, padportas
    this_cEmpPadEmails = ""   && pademails - conta remetente/usuario SMTP (cSendUserName/cFrom)
    this_cEmpPadServs  = ""   && padservs - servidor SMTP (cSmtpServer)
    this_cEmpPadSenhas = ""   && padsenhas - senha SMTP (cSendPassWord)
    this_cEmpPastas    = ""   && pastas - selecionada pelo legado (TmpEmpMail.pastas) mas nunca referenciada depois do Select; mantida so para rastrear a mesma consulta
    this_nEmpPadPortas = 0    && padportas - porta SMTP (nSmtpServerPort)

    *-- .T. apos ObterDadosContaEmail() carregar com sucesso os dados de
    *-- SigCdEmp (equivalente a "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0"
    *-- checado no Cmd_GerarPDF.Click legado antes de montar o objeto oEMAIL)
    this_lContaEmailCarregada = .F.

    *-- Identifica qual campo falhou na ultima chamada a
    *-- ValidarDadosConfirmacao() - "ARQUIVO" | "EMAIL_DE" | "EMAIL_PARA" |
    *-- "EMAIL_CONTA" | "" (sem falha). O Form usa isto so para decidir o
    *-- SetFocus, igual ao This.Parent.CmdGetFile.SetFocus() /
    *-- TxtEmail_EnviarDE.SetFocus() / txtEmail_EnviarPara.SetFocus() do
    *-- Cmd_GerarPDF.Click legado - a mensagem em si vai em this_cMensagemErro
    *-- (ja declarada em BusinessBase)
    this_cCampoInvalido = ""

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()

            *-- SIGPRPDF nao tem tabela/PK propria (ver cabecalho do arquivo)
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_oFormPai = .NULL.
            THIS.this_cDiretorio = ""

            THIS.this_nTipoArquivo          = 1
            THIS.this_lPdfCreatorDisponivel = .F.
            THIS.this_cArquivoSaida         = ""
            THIS.this_lEnviarEmail          = .F.

            THIS.this_cEmailDe      = ""
            THIS.this_cEmailPara    = ""
            THIS.this_cEmailCC      = ""
            THIS.this_cEmailAssunto = ""
            THIS.this_cEmailCorpo   = ""

            THIS.this_cEmpPadEmails = ""
            THIS.this_cEmpPadServs  = ""
            THIS.this_cEmpPadSenhas = ""
            THIS.this_cEmpPastas    = ""
            THIS.this_nEmpPadPortas = 0

            THIS.this_lContaEmailCarregada = .F.
            THIS.this_cCampoInvalido       = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigprpdfBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor da conta de e-mail da
    * empresa (SigCdEmp) para as properties deste BO. Eh o hook canonico do
    * BusinessBase e o UNICO ponto do BO que le colunas de cursor - chamado por
    * ObterDadosContaEmail() depois do SQLEXEC, e tambem utilizavel pelo Form
    * quando o cursor TmpEmpMail/equivalente ja estiver aberto.
    *
    * As conversoes sao as do Init / Cmd_GerarPDF.Click legado, coluna a coluna
    * (linhas 652 e 801-804 do fonte original) - LOWER + ALLTRIM em PadEmails e
    * PadServs, so ALLTRIM em PadSenhas, Nvl(...,0) em PadPortas:
    *   TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, [])))
    *   "cSmtpServer"     <- Lower(Alltrim(Nvl(TmpEmpMail.PadServs,  "")))
    *   "nSmtpServerPort" <-            Nvl(TmpEmpMail.PadPortas, 0)
    *   "cSendUserName"   <- Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, "")))
    *   "cSendPassWord"   <-       Alltrim(Nvl(TmpEmpMail.PadSenhas, "")))
    * Tipos conferidos em docs/schema.sql (tabela sigcdemp): pademails char(50),
    * padservs char(50), padsenhas char(30), pastas char(50), padportas
    * numeric(3,0) - por isso padportas vai para a property NUMERICA
    * this_nEmpPadPortas e as demais para properties de caractere.
    *
    * Marca this_lContaEmailCarregada, que eh o equivalente migrado de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" checado no
    * Cmd_GerarPDF.Click legado antes de montar o objeto de envio.
    *
    * par_cAliasCursor: alias do cursor a ler. Retorna .T. se leu a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nAreaAnterior

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cAlias        = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        THIS.this_lContaEmailCarregada = .F.

        TRY
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de dados da conta de e-mail " + ;
                                          "indispon" + CHR(237) + "vel."
            ELSE
                *-- Alias dinamico: SELECT (var) + acesso DIRETO aos campos.
                *-- NUNCA campo, que eh sintaxe invalida em VFP9.
                SELECT (loc_cAlias)
                GO TOP

                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Conta de e-mail n" + CHR(227) + "o " + ;
                                              "cadastrada para a empresa."
                ELSE
                    *-- Existencia de campo em CURSOR se testa com TYPE(),
                    *-- NUNCA com PEMSTATUS (que exige objeto no 1o argumento)
                    IF TYPE(loc_cAlias + ".PadEmails") != "U"
                        THIS.this_cEmpPadEmails = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadServs") != "U"
                        THIS.this_cEmpPadServs = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadSenhas") != "U"
                        THIS.this_cEmpPadSenhas = ALLTRIM(TratarNulo(PadSenhas, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Pastas") != "U"
                        THIS.this_cEmpPastas = ALLTRIM(TratarNulo(Pastas, ""))
                    ENDIF

                    *-- padportas eh numeric(3,0) no schema: NVL numerico, sem
                    *-- ALLTRIM/STR (ALLTRIM sobre numerico dispara o erro 11)
                    IF TYPE(loc_cAlias + ".PadPortas") != "U"
                        THIS.this_nEmpPadPortas = NVL(PadPortas, 0)
                    ENDIF

                    *-- Init legado: TxtEmail_EnviarDE.Value recebe PadEmails
                    THIS.this_cEmailDe = THIS.this_cEmpPadEmails

                    THIS.this_lContaEmailCarregada = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.CarregarDoCursor")
        ENDTRY

        *-- Restaura a work area do chamador (o SELECT acima a trocou)
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosContaEmail - Carrega os dados da conta de e-mail parametrizada
    * para a empresa em SigCdEmp (equivalente a "Select PadEmails, PadServs,
    * PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = <empresa>"
    * no Init legado, que populava o cursor TmpEmpMail). par_cCodEmpresa deve
    * vir de go_4c_Sistema.cCodEmpresa (CLAUDE.md: NUNCA usar a legada _EMPR).
    *
    * Tambem repete o que o Init legado fazia com o resultado -
    * THIS.this_cEmailDe recebe PadEmails em minusculo/trim, equivalente a
    * "Thisform.CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
    * TmpEmpMail.PadEmails, [])))".
    *
    * Retorna .T. se a consulta foi executada com sucesso. Em caso de falha,
    * reproduz a mensagem do legado ("Favor Reinicializar o Processo!!!") em
    * this_cMensagemErro - o Form decide como exibir (MsgErro).
    *==========================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.
        THIS.this_lContaEmailCarregada = .F.
        THIS.this_cMensagemErro        = ""

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, Pastas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- A leitura das colunas fica num lugar so (CarregarDoCursor),
                *-- que eh o hook canonico do BusinessBase para esse mapeamento
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_TmpEmpMail")

                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeArquivoPadrao - Monta o nome/caminho default do arquivo de
    * saida, equivalente a:
    *   Init legado:        ThisForm.Diretorio + [FORTYUSPDF.] + Iif(... ,[PDF],[XLS])
    *   optArquivo.Click:   ThisForm.Diretorio + [FORTYUSPDF.PDF] / [FORTYUSEXCEL.XLS]
    * par_nTipoArquivo: 1 = PDF, 2 = XLS (THIS.this_nTipoArquivo - indice
    * 1-based do OptionGroup, NUNCA booleano - CLAUDE.md regra sobre
    * ControlSource numerico).
    *==========================================================================
    PROCEDURE ObterNomeArquivoPadrao(par_nTipoArquivo)
        LOCAL loc_cDir

        loc_cDir = ALLTRIM(TratarNulo(THIS.this_cDiretorio, ""))
        IF !EMPTY(loc_cDir) AND RIGHT(loc_cDir, 1) != "\"
            loc_cDir = loc_cDir + "\"
        ENDIF

        RETURN loc_cDir + IIF(par_nTipoArquivo = 1, "FORTYUSPDF.PDF", "FORTYUSEXCEL.XLS")
    ENDPROC

    *==========================================================================
    * ValidarDadosConfirmacao - Reproduz, na ordem, as DUAS checagens
    * BLOQUEANTES do Cmd_GerarPDF.Click legado - as unicas que fazem Return
    * antecipado (o dialogo NAO fecha):
    *   1) nome do arquivo de saida preenchido (senao, igual ao legado,
    *      MessageBox + This.Parent.CmdGetFile.SetFocus());
    *   2) quando this_lEnviarEmail = .T. (Chk_EMAIL.Value = 1):
    *      2a) campo 'DE:' preenchido (TxtEmail_EnviarDE.SetFocus());
    *      2b) campo 'PARA:' preenchido (txtEmail_EnviarPara.SetFocus()).
    *
    * A terceira checagem do legado (conta de e-mail da empresa ausente -
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0") NAO bloqueia: o
    * Else so exibe MessageBox('Problemas na selecao de dados do email...')
    * SEM Return, e o fluxo segue at? ThisForm.Release() (o dialogo fecha
    * mesmo assim, so sem montar o objeto de envio). Por isso essa checagem
    * fica fora deste metodo - o Form consulta THIS.this_lContaEmailCarregada
    * direto para decidir se exibe o aviso antes de chamar
    * MontarDadosEnvioEmail(), sem impedir o fechamento.
    *
    * Retorna .T. se passou nas duas checagens bloqueantes. Em caso de
    * falha, preenche this_cMensagemErro (texto IDENTICO ao MessageBox
    * legado) e this_cCampoInvalido (para o Form decidir o SetFocus) e para
    * na PRIMEIRA falha, igual ao Return antecipado do legado.
    *==========================================================================
    PROCEDURE ValidarDadosConfirmacao()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_cCampoInvalido = ""

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cArquivoSaida, "")))
                THIS.this_cMensagemErro  = "Selecione um nome para o arquivo!"
                THIS.this_cCampoInvalido = "ARQUIVO"
            ELSE
                IF !THIS.this_lEnviarEmail
                    loc_lValido = .T.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
                        THIS.this_cMensagemErro  = "O campo 'DE:' n" + CHR(227) + "o foi preenchido."
                        THIS.this_cCampoInvalido = "EMAIL_DE"
                    ELSE
                        IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
                            THIS.this_cMensagemErro  = "O campo 'PARA:' n" + CHR(227) + "o foi preenchido."
                            THIS.this_cCampoInvalido = "EMAIL_PARA"
                        ELSE
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ValidarDadosConfirmacao")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ObterMensagemContaEmailIndisponivel - Mensagem a exibir (sem bloquear o
    * fechamento do dialogo) quando this_lEnviarEmail = .T. mas
    * this_lContaEmailCarregada = .F. - equivalente ao Else sem Return de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" no Cmd_GerarPDF.Click
    * legado. Ver nota em ValidarDadosConfirmacao sobre por que esta checagem
    * NAO entra na cadeia bloqueante.
    *==========================================================================
    PROCEDURE ObterMensagemContaEmailIndisponivel()
        RETURN "Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. Favor enviar novamente."
    ENDPROC

    *==========================================================================
    * MontarDadosEnvioEmail - Monta a estrutura de envio equivalente ao
    * objeto CUSTOM que o Cmd_GerarPDF.Click legado cria em
    * ThisForm.oParentForm.oEMAIL via AddProperty (cSmtpServer, nSmtpServerPort,
    * cSendUserName, cSendPassWord, cFrom, cTO, cCC, cAssunto, cCorpo, cAnexo).
    * Devolve um objeto CUSTOM com as mesmas properties, na mesma grafia, para
    * o Form atribuir direto a par_oFormPai.oEMAIL - este BO nao conhece o
    * form pai, so monta o objeto (THIS.this_oFormPai existe so para o Form
    * usar, nunca eh referenciado por este BO).
    *
    * Chamar APENAS depois de ValidarDadosConfirmacao() retornar .T. E
    * this_lContaEmailCarregada = .T. - este metodo nao revalida. Sem os
    * dados da conta (this_lContaEmailCarregada = .F.), devolve .NULL.,
    * equivalente ao legado NAO atribuir ThisForm.oParentForm.oEMAIL quando
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" falha.
    *==========================================================================
    PROCEDURE MontarDadosEnvioEmail()
        LOCAL loc_oEmail

        IF !THIS.this_lContaEmailCarregada
            RETURN .NULL.
        ENDIF

        loc_oEmail = CREATEOBJECT("Empty")

        ADDPROPERTY(loc_oEmail, "cSmtpServer",     THIS.this_cEmpPadServs)
        ADDPROPERTY(loc_oEmail, "nSmtpServerPort", THIS.this_nEmpPadPortas)
        ADDPROPERTY(loc_oEmail, "cSendUserName",   THIS.this_cEmpPadEmails)
        ADDPROPERTY(loc_oEmail, "cSendPassWord",   THIS.this_cEmpPadSenhas)
        ADDPROPERTY(loc_oEmail, "cFrom",           ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
        ADDPROPERTY(loc_oEmail, "cTO",             ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
        ADDPROPERTY(loc_oEmail, "cCC",             ALLTRIM(TratarNulo(THIS.this_cEmailCC, "")))
        ADDPROPERTY(loc_oEmail, "cAssunto",        ALLTRIM(TratarNulo(THIS.this_cEmailAssunto, "")))
        ADDPROPERTY(loc_oEmail, "cCorpo",           ALLTRIM(TratarNulo(THIS.this_cEmailCorpo, "")))
        ADDPROPERTY(loc_oEmail, "cAnexo",           THIS.this_cArquivoSaida)

        RETURN loc_oEmail
    ENDPROC

    *==========================================================================
    * Destroy - Libera o cursor de trabalho aberto por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

