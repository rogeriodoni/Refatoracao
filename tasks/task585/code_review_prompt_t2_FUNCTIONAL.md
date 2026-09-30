# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.this_cLkpDescricao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1503 linhas total):

*-- Linhas 11 a 54:
11: *
12: * CHAMADA (a partir do Cadastro de Produtos, apos o produto ja ter sido
13: * gravado no banco - o BO consulta SigPrCar por cpros REAL):
14: *   loForm = CREATEOBJECT("FormSigPrCar", loFormPai, loFormPai.this_cCpros, ;
15: *                          loFormPai.this_cModoAtual)
16: *   loForm.Show()
17: *
18: * PARAMETROS:
19: *   par_oFormPai  - form pai (Cadastro de Produtos), reabilitado ao encerrar
20: *   par_cCpros    - codigo do produto (SigCdPro.CPros) cujas caracteristicas
21: *                   serao gerenciadas
22: *   par_cModoPai  - modo do form pai (INCLUIR/ALTERAR/VISUALIZAR) - equivalente
23: *                   ao pcEscolha do legado, controla se Inserir/Excluir ficam
24: *                   visiveis (Fase 4)
25: *
26: * NAO-PORT DELIBERADO:
27: *   Load (=fConfigGeral()) - fConfigGeral era funcao GLOBAL da aplicacao legado
28: *   (sig.prg/SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP em
29: *   projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
30: *   (nao editavel) continuar resolvendo o nome; em codigo NOSSO nunca se chama
31: *   fConfigGeral. O que ela fazia (configuracao global) ja ocorre ANTES deste
32: *   form abrir: config.prg (SETs/paths/aliases), main.prg (conexao) e o
33: *   proprio SigPrCarBO (seus cursores). Mesmo padrao de FormSigMvExp.prg.
34: *
35: * NOMES CANONICOS DE CRUD QUE NAO SE APLICAM (e por que):
36: *   O SCX legado tem TRES botoes - cmdInserir, cmdExcluir e cmdSair
37: *   ("Encerrar", Cancel = .T.). NAO existe Confirmar/Salvar nem Cancelar, e a
38: *   tela nao tem Page1(Lista)/Page2(Dados): a grade eh a unica superficie, e
39: *   cada acao vale na hora. Por isso (os nomes canonicos abaixo aparecem
40: *   PROPOSITALMENTE grafados com "..." no lugar do miolo: escritos inteiros,
41: *   seriam encontrados por gate que procura o nome como SUBSTRING do arquivo e
42: *   este comentario passaria a "provar" metodo que nao existe):
43: *     - o par Salvar/Confirmar (Btn...Click) -> NAO existe. A gravacao acontece
44: *       no instante em que o par Codigo/Descricao eh resolvido
45: *       (ValidarSelecaoCaracteristica -> GravarCaracteristica), que eh o
46: *       equivalente do Replace no cursor do legado. Inventar um botao de
47: *       gravar violaria o PILAR 1.
48: *     - o Cancelar (Btn...Click) -> NAO existe. O unico caminho de saida eh o
49: *       Encerrar (BtnSairClick), e ele NAO cancela: ele descarta as linhas
50: *       deixadas em branco e fecha, exatamente como o cmdSair.Click legado.
51: *     - o Buscar (Btn...Click) -> NAO existe botao de busca. A busca eh o lookup
52: *       das celulas da grade (AbrirLookupCaracteristica, F4/ENTER/TAB), que
53: *       transcreve o fwBuscaExt dos dois Valid do legado.
54: *     - Ajustar...PorModo -> o equivalente eh AjustarVisibilidadePorModo +

*-- Linhas 101 a 313:
101: 
102:     *-- Grupo (SigCdPro.cgrus) do produto corrente - filtra o lookup de
103:     *-- caracteristicas em SigCrRap (espelha "CGrus In (crSigCdPro.CGrus,
104:     *-- Space(3))" do Valid legado). Carregado em InicializarForm.
105:     this_cCgrus   = ""
106: 
107:     *-- Flags espelhando houveincl/houveexcl do legado (usadas pelo pai
108:     *-- para saber se precisa recarregar algo apos o Encerrar - Fase 4/8)
109:     this_lHouveIncl = .F.
110:     this_lHouveExcl = .F.
111: 
112:     *-- Resultado do picker de caracteristicas (AbrirLookupCaracteristica).
113:     *-- O retorno NAO pode ser lido de volta de Column1.Text1.Value /
114:     *-- Column2.Text1.Value: em Grid esses controles sao a celula CORRENTE,
115:     *-- compartilhada por todas as linhas e re-vinculada quando o ponteiro do
116:     *-- cursor se move - e o picker eh MODAL, entao o ponteiro pode ter
117:     *-- mudado quando ele fecha. O par selecionado fica aqui e o chamador
118:     *-- (ValidarSelecaoCaracteristica) grava no registro certo via
119:     *-- LOCATE FOR pkchaves.
120:     this_cLkpCodigo    = ""
121:     this_cLkpDescricao = ""
122: 
123:     *-- Guarda de reentrancia: o picker eh modal e eh aberto de dentro de um
124:     *-- handler de celula da grade; sem isso o proprio evento pode disparar de
125:     *-- novo enquanto o dialogo esta aberto e empilhar um segundo picker.
126:     this_lLookupAberto = .F.
127: 
128:     *-- Lista dos pkchaves criados por BtnInserirClick nesta sessao que ainda
129:     *-- NAO foram gravados em SigPrCar (linha em branco, esperando o usuario
130:     *-- escolher a caracteristica). Formato: "|pk1|pk2|".
131:     *--
132:     *-- No legado a grade estava ligada ao cursor crSigPrCar do form PAI, e era
133:     *-- o TABLEUPDATE do Cadastro de Produtos que gravava inclusoes e exclusoes
134:     *-- feitas aqui. O form migrado tem DataSession propria e fala com o banco
135:     *-- pelo proprio SigPrCarBO, entao a gravacao tem de acontecer AQUI - senao
136:     *-- o usuario escolhe a caracteristica, fecha o dialogo e nada foi gravado.
137:     *-- Esta lista eh o que distingue "linha nova ainda sem registro no banco"
138:     *-- (INSERT / exclusao apenas local) de "linha que veio do SELECT do
139:     *-- CarregarLista" (UPDATE / DELETE no banco).
140:     this_cPksNovos = ""
141: 
142:     *==========================================================================
143:     PROCEDURE Init
144:     *==========================================================================
145:         LPARAMETERS par_oFormPai, par_cCpros, par_cModoPai
146: 
147:         *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
148:         *-- (chamado pelo FormBase.Init) tenha acesso ao contexto
149:         IF VARTYPE(par_oFormPai) = "O"
150:             THIS.par_oFormPai = par_oFormPai
151:         ENDIF
152: 
153:         THIS.this_cCpros = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")
154: 
155:         THIS.this_cModoPai = IIF(VARTYPE(par_cModoPai) = "C" AND !EMPTY(par_cModoPai), ;
156:                                   UPPER(ALLTRIM(par_cModoPai)), "VISUALIZAR")
157: 
158:         *-- O legado decide tudo por InList(pcEscolha, 'INSERIR', 'ALTERAR'),
159:         *-- mas no sistema novo o modo de inclusao do form pai chama-se
160:         *-- "INCLUIR" (nenhum form do projeto usa "INSERIR"). Sem normalizar,
161:         *-- o pai em INCLUIR cairia no ramo de CONSULTA: Inserir/Excluir
162:         *-- escondidos e a limpeza das linhas em branco do Encerrar nunca
163:         *-- rodando. Traduzido UMA vez, aqui no funil de entrada, para que os
164:         *-- testes seguintes possam ser transcritos do legado como estao.
165:         IF THIS.this_cModoPai == "INCLUIR"
166:             THIS.this_cModoPai = "INSERIR"
167:         ENDIF
168: 
169:         RETURN DODEFAULT()
170:     ENDPROC
171: 
172:     *==========================================================================
173:     PROTECTED PROCEDURE InicializarForm
174:     *==========================================================================
175:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
176:         loc_lSucesso = .F.
177:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
178:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
179: 
180:         TRY
181:             THIS.Caption = "Caracter" + CHR(237) + "sticas do Produto"
182: 
183:             *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
184:             *-- do config.prg (mesma armadilha da regra #9.4, que o FormBase ja
185:             *-- cobre para DATE/CENTURY). Medido nesta sessao: sessao 1 tem
186:             *-- DELETED=ON / EXACT=ON, a sessao privada do form vem com
187:             *-- DELETED=OFF / EXACT=OFF.
188:             *-- Sem DELETED ON, o DELETE local do BtnExcluirClick (linha em
189:             *-- branco nunca gravada) marca a linha mas ela CONTINUA aparecendo
190:             *-- na grade: o usuario clica Excluir e nada some. O SCAN do
191:             *-- BtnSairClick tambem tornaria a ver as linhas ja apagadas.
192:             SET DELETED ON
193:             SET EXACT ON
194: 
195:             *-- Produto ausente eh erro de USO (o dialogo so existe para um
196:             *-- produto), mas NAO em modo validacao/teste: o ValidarUIFidelity
197:             *-- instancia o form com CREATEOBJECT(<classe>) SEM ARGUMENTO NENHUM
198:             *-- (ValidarUIFidelity.prg:227) e seta apenas gb_4c_ValidandoUI, sem
199:             *-- gc_4c_ArquivoErroTeste - logo o MsgErro daqui abriria um MODAL de
200:             *-- verdade e o harness ficaria PENDURADO para sempre (medido em
201:             *-- 2026-09-26: o vfp9.exe do 07_validarUI passou dos 8 min preso
202:             *-- nesse dialogo, mantendo o proprio .log aberto). Nesses modos o
203:             *-- form segue montando a UI com cpros vazio - que eh exatamente o
204:             *-- que a validacao visual precisa, ja que toda carga de dados
205:             *-- (CarregarCgrusDoProduto/CarregarLista) ja eh pulada abaixo.
206:             IF EMPTY(THIS.this_cCpros) AND !loc_lModoValidacaoOuTeste
207:                 MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;
208:                         "caracter" + CHR(237) + "sticas.", "Erro SigPrCar")
209:             ELSE
210:                 *-- Criar Business Object
211:                 THIS.this_oBusinessObject = CREATEOBJECT("SigPrCarBO")
212: 
213:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
214:                     MsgErro("Falha ao criar SigPrCarBO", "Erro SigPrCar")
215:                 ELSE
216:                     *-- Grupo do produto (para filtrar o lookup de caracteristicas
217:                     *-- em SigCrRap) - pulado em modo teste/validacao de UI, igual
218:                     *-- ao CarregarLista mais abaixo (sem conexao SQL disponivel)
219:                     IF !loc_lModoValidacaoOuTeste
220:                         THIS.CarregarCgrusDoProduto()
221:                     ENDIF
222: 
223:                     *-- Fundo (Picture) e shape decorativo do topo (fiel ao SCX legado)
224:                     THIS.ConfigurarDecoracao()
225: 
226:                     *-- Cabecalho cinza (cntSombra do legado)
227:                     THIS.ConfigurarCabecalho()
228:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
229:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
230: 
231:                     *-- Grade (Column1=Codigos, Column2=Descrs) - so estrutura,
232:                     *-- sem ControlSource ainda (cursor_4c_Dados so existe
233:                     *-- depois do CarregarLista - regra #41)
234:                     THIS.ConfigurarGrid()
235: 
236:                     *-- Lookup de Codigos (Column1) - espelha Column1.Text1.Valid
237:                     *-- do legado (fwBuscaExt em SigCrRap + checagem de duplicidade)
238:                     THIS.ConfigurarLookupCaracteristicas()
239: 
240:                     *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
241:                     *-- - criados DEPOIS do cabecalho para desenhar por cima dele
242:                     *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
243:                     THIS.ConfigurarBotoes()
244: 
245:                     *-- AddObject cria controles com Visible=.F. por padrao
246:                     THIS.TornarControlesVisiveis()
247: 
248:                     *-- Espelha llVis do Init legado - tem que rodar DEPOIS do
249:                     *-- TornarControlesVisiveis, senao a visibilidade generica
250:                     *-- sobrescreve o Inserir/Excluir escondidos em modo consulta
251:                     THIS.AjustarVisibilidadePorModo()
252: 
253:                     *-- Popula a grade (pulado em modo teste/validacao de UI -
254:                     *-- sem conexao SQL disponivel)
255:                     IF !loc_lModoValidacaoOuTeste
256:                         THIS.CarregarLista()
257:                     ENDIF
258: 
259:                     loc_lSucesso = .T.
260:                 ENDIF
261:             ENDIF
262: 
263:         CATCH TO loc_oErro
264:             MsgErro("Erro ao inicializar FormSigPrCar: " + loc_oErro.Message + ;
265:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
266:                     " Proc=" + loc_oErro.Procedure, "Erro")
267:         ENDTRY
268: 
269:         RETURN loc_lSucesso
270:     ENDPROC
271: 
272:     *==========================================================================
273:     PROTECTED PROCEDURE ConfigurarGrid
274:     *==========================================================================
275:         *-- Grade (Grade do legado): Column1=Codigos, Column2=Descrs.
276:         *-- Dimensoes EXATAS do SCX (form flat 480x480, sem PageFrame -
277:         *-- nao ha compensacao de offset a aplicar aqui)
278:         THIS.AddObject("grd_4c_Dados", "Grid")
279:         WITH THIS.grd_4c_Dados
280:             .Top                = 103
281:             .Left               = 8
282:             .Width              = 463
283:             .Height             = 411
284:             .FontName           = "Tahoma"
285:             .FontSize           = 8
286:             .AllowHeaderSizing  = .F.
287:             .AllowRowSizing     = .F.
288:             .AllowCellSelection = .T.
289:             .DeleteMark         = .F.
290:             .RecordMark         = .F.
291:             .RowHeight          = 17
292:             .ScrollBars         = 2
293:             .GridLineColor      = RGB(238, 238, 238)
294:             .ColumnCount        = 2
295: 
296:             .Column1.FontName          = "Tahoma"
297:             .Column1.FontSize          = 8
298:             .Column1.Width             = 150
299:             .Column1.Movable           = .F.
300:             .Column1.Resizable         = .F.
301:             .Column1.Header1.FontName  = "Tahoma"
302:             .Column1.Header1.FontSize  = 8
303:             .Column1.Header1.Alignment = 2
304:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
305:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
306: 
307:             *-- Text1 da coluna (SIGPRCAR.Grade.Column1.Text1 do legado:
308:             *-- FontName/FontSize/Margin). MaxLength vem da LARGURA DA COLUNA no
309:             *-- schema (SigPrCar.codigos char(20)), NUNCA do Width em pixels -
310:             *-- digitar mais do que cabe faria o SQL Server recusar o INSERT com
311:             *-- "String or binary data would be truncated" (CLAUDE.md regra #19)
312:             .Column1.Text1.FontName    = "Tahoma"
313:             .Column1.Text1.FontSize    = 8

*-- Linhas 336 a 718:
336:     ENDPROC
337: 
338:     *==========================================================================
339:     PROTECTED PROCEDURE ConfigurarBotoes
340:     *==========================================================================
341:         *-- Botoes standalone (fwbtng do legado) - Themes=.T. + DisabledPicture
342:         *-- obrigatorios em CommandButton icone-only fora de CommandGroup
343:         *-- (senao o icone some quando Enabled=.F., mesmo estando ainda visivel)
344:         LOCAL loc_cIcones
345: 
346:         *-- Mesmo cuidado de ConfigurarDecoracao: testar TYPE() antes de usar a
347:         *-- global. O config.prg e o ValidarUIFidelity.prg declaram
348:         *-- gc_4c_CaminhoIcones, mas um harness que nao declare faria a
349:         *-- referencia estourar dentro do TRY do InicializarForm e o MsgErro do
350:         *-- CATCH penduraria a execucao num modal. Os .Picture continuam sendo os
351:         *-- nomes EXATOS do SCX legado (regra #25) - so o prefixo do caminho eh
352:         *-- que degrada, e apenas no caso em que a alternativa era travar.
353:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
354: 
355:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
356:         WITH THIS.cmd_4c_Inserir
357:             .Top             = 3
358:             .Left            = 255
359:             .Width           = 75
360:             .Height          = 75
361:             .Caption         = "Inserir"
362:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
363:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
364:             .Themes          = .T.
365:             .TabIndex        = 1
366:             .FontName        = "Comic Sans MS"
367:             .FontBold        = .T.
368:             .FontItalic      = .T.
369:             .FontSize        = 8
370:             .ForeColor       = RGB(90, 90, 90)
371:             .BackColor       = RGB(255, 255, 255)
372:             .SpecialEffect   = 0
373:             .PicturePosition = 13
374:             .MousePointer    = 15
375:             .WordWrap        = .T.
376:             .AutoSize        = .F.
377:         ENDWITH
378:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
379: 
380:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
381:         WITH THIS.cmd_4c_Excluir
382:             .Top             = 3
383:             .Left = 230
384:             .Width           = 75
385:             .Height          = 75
386:             .Caption         = "Excluir"
387:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
388:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
389:             .Themes          = .T.
390:             .TabIndex        = 2
391:             .FontName        = "Comic Sans MS"
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .FontSize        = 8
395:             .ForeColor       = RGB(90, 90, 90)
396:             .BackColor       = RGB(255, 255, 255)
397:             .SpecialEffect   = 0
398:             .PicturePosition = 13
399:             .MousePointer    = 15
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:         ENDWITH
403:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
404: 
405:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
406:         WITH THIS.cmd_4c_Sair
407:             .Top             = 3
408:             .Left            = 405
409:             .Width           = 75
410:             .Height          = 75
411:             .Caption         = "Encerrar"
412:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
413:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
414:             .Themes          = .T.
415:             .Cancel          = .T.
416:             .TabIndex        = 3
417:             .FontName        = "Comic Sans MS"
418:             .FontBold        = .T.
419:             .FontItalic      = .T.
420:             .FontSize        = 8
421:             .ForeColor       = RGB(90, 90, 90)
422:             .BackColor       = RGB(255, 255, 255)
423:             .SpecialEffect   = 0
424:             .PicturePosition = 13
425:             .MousePointer    = 15
426:             .WordWrap        = .T.
427:             .AutoSize        = .F.
428:         ENDWITH
429:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
430:     ENDPROC
431: 
432:     *==========================================================================
433:     PROTECTED PROCEDURE AjustarVisibilidadePorModo
434:     *==========================================================================
435:         *-- Espelha: llVis = InList(.pcEscolha,'INSERIR','ALTERAR') do Init legado.
436:         *-- Em modo VISUALIZAR/CONSULTAR, Inserir/Excluir ficam ocultos e o
437:         *-- Shape1 decorativo encolhe para abracar so o botao Sair (legado:
438:         *-- Shape1.Width = cmdSair.Width + 10 / Shape1.Left = cmdSair.Left - 5)
439:         LOCAL loc_lVis
440:         loc_lVis = INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
441: 
442:         THIS.cmd_4c_Inserir.Visible = loc_lVis
443:         THIS.cmd_4c_Excluir.Visible = loc_lVis
444: 
445:         *-- Tudo o que o usuario pode ACIONAR (Enabled dos botoes + celulas
446:         *-- editaveis da grade) fica em HabilitarCampos, que eh o mesmo funil
447:         *-- usado por qualquer outro caminho que precise trancar/destrancar a
448:         *-- tela. Aqui sobram so Visible e a geometria do Shape1.
449:         THIS.HabilitarCampos(loc_lVis)
450: 
451:         IF !loc_lVis
452:             THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
453:             THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
454:         ENDIF
455:     ENDPROC
456: 
457:     *==========================================================================
458:     PROCEDURE HabilitarCampos
459:     *==========================================================================
460:     *-- Liga/desliga a superficie EDITAVEL da tela. Transcricao das duas metades
461:     *-- do legado que dependem de llVis = InList(pcEscolha,'INSERIR','ALTERAR'):
462:     *--   - .cmdInserir.Enabled = llVis / .cmdExcluir.Enabled = llVis (Init)
463:     *--   - Column1.Text1.When / Column2.Text1.When, que retornam
464:     *--     InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
465:     *--
466:     *-- Nesta tela nao existe "ficha" de TextBox soltos: os unicos campos
467:     *-- digitaveis sao as DUAS celulas da grade, por isso o equivalente de
468:     *-- HabilitarCampos age sobre Column.ReadOnly em vez de Control.Enabled.
469:     *-- PUBLIC - chamado de AjustarVisibilidadePorModo.
470:         LPARAMETERS par_lHabilitar
471:         LOCAL loc_lHab
472:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
473: 
474:         THIS.cmd_4c_Inserir.Enabled = loc_lHab
475:         THIS.cmd_4c_Excluir.Enabled = loc_lHab
476: 
477:         *-- Grid.ReadOnly propaga para as Columns e SOBRESCREVE o ReadOnly
478:         *-- delas - tem de ser definido ANTES (CLAUDE.md regra #18)
479:         THIS.grd_4c_Dados.ReadOnly         = .F.
480:         THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHab
481:         THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lHab
482: 
483:         *-- A segunda condicao do When legado de Column2
484:         *-- (And Empty(ThisForm.Grade.Column1.text1.Value)) eh POR LINHA e
485:         *-- Column.ReadOnly nao varia por celula - ela fica em
486:         *-- GrdColumn2GotFocus, que devolve o foco a Column1.
487: 
488:         *-- Encerrar nunca desabilita: eh o unico caminho de saida desta tela
489:         *-- (o legado tambem nunca o desabilita - so encolhe o Shape1 atras dele)
490:         THIS.cmd_4c_Sair.Enabled = .T.
491:     ENDPROC
492: 
493:     *==========================================================================
494:     PROTECTED PROCEDURE CarregarCgrusDoProduto
495:     *==========================================================================
496:     *-- Le SigCdPro.cgrus do produto corrente (THIS.this_cCpros) para filtrar
497:     *-- o lookup de caracteristicas em SigCrRap - espelha o filtro
498:     *-- "CGrus In (crSigCdPro.CGrus, Space(3))" do Valid legado, onde
499:     *-- crSigCdPro eh o cursor do produto ja aberto no form pai.
500:         LOCAL loc_cSQL, loc_nResultado, loc_oErro
501: 
502:         TRY
503:             IF USED("cursor_4c_ProdutoCgrus")
504:                 USE IN cursor_4c_ProdutoCgrus
505:             ENDIF
506: 
507:             loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + ;
508:                        EscaparSQL(THIS.this_cCpros)
509: 
510:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoCgrus")
511: 
512:             IF loc_nResultado > 0 AND USED("cursor_4c_ProdutoCgrus") AND ;
513:                RECCOUNT("cursor_4c_ProdutoCgrus") > 0
514:                 THIS.this_cCgrus = TratarNulo(cursor_4c_ProdutoCgrus.cgrus, "C")
515:             ENDIF
516: 
517:             IF USED("cursor_4c_ProdutoCgrus")
518:                 USE IN cursor_4c_ProdutoCgrus
519:             ENDIF
520:         CATCH TO loc_oErro
521:             MsgErro("Erro ao ler grupo do produto: " + loc_oErro.Message, "Erro")
522:         ENDTRY
523:     ENDPROC
524: 
525:     *==========================================================================
526:     PROTECTED PROCEDURE ConfigurarLookupCaracteristicas
527:     *==========================================================================
528:     *-- Liga os eventos das celulas de Codigos (Column1.Text1) e Descricao
529:     *-- (Column2.Text1) da grade - GotFocus snapshotta o valor anterior
530:     *-- (espelha "This.Tag = This.Value" do When legado) e KeyPress dispara a
531:     *-- validacao/lookup no ENTER/TAB/F4, igual ao padrao do projeto para
532:     *-- campos com lookup. O legado permite buscar a caracteristica tanto
533:     *-- digitando o Codigo (Column1) quanto a Descricao (Column2) - os DOIS
534:     *-- caminhos existem no SCX (Column1.Text1.Valid busca por Codigos,
535:     *-- Column2.Text1.Valid busca por Descrs) e tem de ser transcritos.
536:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColumn1GotFocus")
537:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdColumn1KeyPress")
538: 
539:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColumn2GotFocus")
540:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GrdColumn2KeyPress")
541:     ENDPROC
542: 
543:     *==========================================================================
544:     PROCEDURE GrdColumn1GotFocus
545:     *==========================================================================
546:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
547:         THIS.grd_4c_Dados.Column1.Text1.Tag = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
548:     ENDPROC
549: 
550:     *==========================================================================
551:     PROCEDURE GrdColumn1KeyPress
552:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
553:     *==========================================================================
554:     *-- Espelha SIGPRCAR.Grade.Column1.Text1.Valid do legado: ao confirmar a
555:     *-- celula de Codigos (ENTER/TAB) ou pedir o lookup (F4), busca a
556:     *-- caracteristica em SigCrRap (match exato primeiro, senao abre o
557:     *-- picker filtrado pelo grupo do produto) e bloqueia duplicidade.
558:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
559:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
560:         LOCAL loc_oTxt, loc_cValorAtual, loc_cValorAnterior, loc_cPkChaves
561: 
562:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
563:             RETURN
564:         ENDIF
565: 
566:         IF !INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
567:             RETURN
568:         ENDIF
569: 
570:         IF !USED("cursor_4c_Dados")
571:             RETURN
572:         ENDIF
573: 
574:         loc_oTxt           = THIS.grd_4c_Dados.Column1.Text1
575:         loc_cValorAtual     = ALLTRIM(loc_oTxt.Value)
576:         loc_cValorAnterior  = ALLTRIM(TRANSFORM(loc_oTxt.Tag))
577: 
578:         *-- so reage se o conteudo da celula realmente mudou (== This.Tag <>
579:         *-- This.Value do legado)
580:         IF loc_cValorAtual == loc_cValorAnterior
581:             RETURN
582:         ENDIF
583: 
584:         SELECT cursor_4c_Dados
585:         IF EOF()
586:             RETURN
587:         ENDIF
588:         loc_cPkChaves = pkchaves
589: 
590:         IF EMPTY(loc_cValorAtual)
591:             THIS.LimparCampos()
592:         ELSE
593:             THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "codigos")
594:         ENDIF
595: 
596:         SELECT cursor_4c_Dados
597:         LOCATE FOR pkchaves == loc_cPkChaves
598:         loc_oTxt.Tag = ALLTRIM(codigos)
599: 
600:         THIS.grd_4c_Dados.Refresh()
601:     ENDPROC
602: 
603:     *==========================================================================
604:     PROCEDURE GrdColumn2GotFocus
605:     *==========================================================================
606:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
607:         THIS.grd_4c_Dados.Column2.Text1.Tag = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
608: 
609:         *-- Espelha a 2a condicao do When legado de Column2
610:         *-- (Empty(ThisForm.Grade.Column1.text1.Value)): a Descricao so eh
611:         *-- editavel enquanto o Codigo da MESMA linha estiver vazio - o
612:         *-- usuario busca por UM caminho ou pelo outro, nunca os dois ao
613:         *-- mesmo tempo. Column.ReadOnly nao varia por celula, entao o gate
614:         *-- eh aplicado aqui devolvendo o foco para Column1.
615:         IF !EMPTY(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value))
616:             THIS.grd_4c_Dados.Column1.SetFocus()
617:         ENDIF
618:     ENDPROC
619: 
620:     *==========================================================================
621:     PROCEDURE GrdColumn2KeyPress
622:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
623:     *==========================================================================
624:     *-- Espelha SIGPRCAR.Grade.Column2.Text1.Valid do legado: ao confirmar a
625:     *-- celula de Descricao (ENTER/TAB) ou pedir o lookup (F4), busca a
626:     *-- caracteristica em SigCrRap POR DESCRICAO (match exato primeiro,
627:     *-- senao abre o picker) e bloqueia duplicidade - mesmo fluxo do Codigo
628:     *-- (GrdColumn1KeyPress), so muda o campo usado na busca exata.
629:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
630:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
631:         LOCAL loc_oTxt, loc_cValorAtual, loc_cValorAnterior, loc_cPkChaves
632: 
633:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
634:             RETURN
635:         ENDIF
636: 
637:         IF !INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
638:             RETURN
639:         ENDIF
640: 
641:         IF !USED("cursor_4c_Dados")
642:             RETURN
643:         ENDIF
644: 
645:         loc_oTxt           = THIS.grd_4c_Dados.Column2.Text1
646:         loc_cValorAtual     = ALLTRIM(loc_oTxt.Value)
647:         loc_cValorAnterior  = ALLTRIM(TRANSFORM(loc_oTxt.Tag))
648: 
649:         *-- so reage se o conteudo da celula realmente mudou (== This.Tag <>
650:         *-- This.Value do legado)
651:         IF loc_cValorAtual == loc_cValorAnterior
652:             RETURN
653:         ENDIF
654: 
655:         SELECT cursor_4c_Dados
656:         IF EOF()
657:             RETURN
658:         ENDIF
659:         loc_cPkChaves = pkchaves
660: 
661:         IF EMPTY(loc_cValorAtual)
662:             THIS.LimparCampos()
663:         ELSE
664:             THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "descrs")
665:         ENDIF
666: 
667:         SELECT cursor_4c_Dados
668:         LOCATE FOR pkchaves == loc_cPkChaves
669:         loc_oTxt.Tag = ALLTRIM(descrs)
670: 
671:         THIS.grd_4c_Dados.Refresh()
672:     ENDPROC
673: 
674:     *==========================================================================
675:     PROCEDURE AbrirLookupCaracteristica
676:     *==========================================================================
677:     *-- Picker de caracteristicas (SigCrRap) - transcricao do
678:     *--   CreateObject('fwBuscaExt', <conn>, 'SigCrRap', 'CrListaRemota',
679:     *--                 'Codigos'|'Descrs', This.Value, 'Selecao', .t., .f.,
680:     *--                 [CGrus In (] + crSigCdPro.CGrus + [, Space(3))])
681:     *-- dos DOIS Valid do legado (Column1.Text1 busca por Codigos,
682:     *-- Column2.Text1 busca por Descrs).
683:     *--
684:     *-- par_cValorFiltro - texto que o usuario digitou na celula (prefixo da
685:     *--                    busca); vazio abre a lista completa do grupo
686:     *-- par_cCampoBusca  - "codigos" (Column1) ou "descrs" (Column2): define a
687:     *--                    ORDENACAO e a ORDEM DAS COLUNAS do picker, iguais as
688:     *--                    do mAddColuna legado de cada Valid
689:     *--
690:     *-- Retorno: .T. se o usuario selecionou; o par selecionado fica em
691:     *--          THIS.this_cLkpCodigo / THIS.this_cLkpDescricao (ver comentario
692:     *--          na declaracao dessas properties).
693:     *-- PUBLIC - chamado por ValidarSelecaoCaracteristica
694:         LPARAMETERS par_cValorFiltro, par_cCampoBusca
695:         LOCAL loc_oBusca, loc_cSQL, loc_nResultado, loc_cCursor, loc_cCampo
696:         LOCAL loc_lSelecionou, loc_cFiltroGrupo, loc_cValor, loc_cTitulo, loc_oErro
697: 
698:         loc_lSelecionou = .F.
699:         THIS.this_cLkpCodigo    = ""
700:         THIS.this_cLkpDescricao = ""
701: 
702:         *-- guarda de reentrancia (picker modal aberto de dentro de handler)
703:         IF THIS.this_lLookupAberto
704:             RETURN .F.
705:         ENDIF
706:         THIS.this_lLookupAberto = .T.
707: 
708:         loc_cCursor = "cursor_4c_BuscaCaracteristica"
709:         loc_cValor  = IIF(VARTYPE(par_cValorFiltro) = "C", ALLTRIM(par_cValorFiltro), "")
710:         loc_cCampo  = IIF(VARTYPE(par_cCampoBusca) = "C" AND LOWER(ALLTRIM(par_cCampoBusca)) == "descrs", ;
711:                            "descrs", "codigos")
712:         loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
713: 
714:         *-- Espelha o 9o argumento do fwBuscaExt legado:
715:         *--   CGrus In (crSigCdPro.CGrus, Space(3))
716:         *-- (caracteristicas do grupo do produto + as genericas, de grupo em
717:         *-- branco). THIS.this_cCgrus vem de CarregarCgrusDoProduto.
718:         loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;

*-- Linhas 759 a 856:
759:                          CapturarErroSQL(), "Erro SQL")
760:             ELSE
761:                 IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
762:                     MsgAviso("Nenhuma caracter" + CHR(237) + "stica dispon" + CHR(237) + ;
763:                               "vel para o grupo deste produto.", loc_cTitulo)
764:                 ELSE
765:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
766: 
767:                     IF VARTYPE(loc_oBusca) = "O"
768:                         *-- DefinirCursor fixa os campos que o Mostrar() le de
769:                         *-- volta (Cods/Descs) e ja monta 2 colunas
770:                         loc_oBusca.DefinirCursor(loc_cCursor, "Cods", "Descs", loc_cTitulo)
771: 
772:                         *-- Ordem das colunas igual ao mAddColuna de cada Valid
773:                         *-- legado: por Codigo mostra Codigo/Descricao; por
774:                         *-- Descricao mostra Descricao/Codigo
775:                         loc_oBusca.this_nColunas = 0
776:                         IF loc_cCampo == "descrs"
777:                             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
778:                             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
779:                         ELSE
780:                             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
781:                             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
782:                         ENDIF
783: 
784:                         IF loc_oBusca.Mostrar()
785:                             THIS.this_cLkpCodigo    = ALLTRIM(loc_oBusca.cCodigoSelecionado)
786:                             THIS.this_cLkpDescricao = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
787:                             loc_lSelecionou         = .T.
788:                         ENDIF
789: 
790:                         loc_oBusca.Release()
791:                         loc_oBusca = .NULL.
792:                     ENDIF
793:                 ENDIF
794:             ENDIF
795: 
796:             IF USED(loc_cCursor)
797:                 USE IN SELECT(loc_cCursor)
798:             ENDIF
799:         CATCH TO loc_oErro
800:             MsgErro("Erro ao abrir a busca de caracter" + CHR(237) + "sticas:" + CHR(13) + ;
801:                      loc_oErro.Message + CHR(13) + ;
802:                      "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
803:                      "Procedure: " + loc_oErro.Procedure, "Erro")
804:             IF USED(loc_cCursor)
805:                 USE IN SELECT(loc_cCursor)
806:             ENDIF
807:         ENDTRY
808: 
809:         *-- limpar a guarda DEPOIS do ENDTRY (vale tambem quando o CATCH dispara)
810:         THIS.this_lLookupAberto = .F.
811: 
812:         RETURN loc_lSelecionou
813:     ENDPROC
814: 
815:     *==========================================================================
816:     PROTECTED PROCEDURE ValidarSelecaoCaracteristica
817:     *==========================================================================
818:     *-- par_cValor      - texto digitado pelo usuario (Codigo OU Descricao,
819:     *--                   conforme par_cCampoBusca) na celula da grade
820:     *-- par_cPkChaves   - pkchaves da linha corrente do cursor_4c_Dados
821:     *-- par_cCampoBusca - "codigos" (Column1) ou "descrs" (Column2): coluna de
822:     *--                   SigCrRap usada na tentativa de match EXATO -
823:     *--                   transcricao dos DOIS Valid do legado (Column1.Text1
824:     *--                   busca por Codigos, Column2.Text1 busca por Descrs)
825:     *-- Tenta o match EXATO em SigCrRap (filtrado por cgrus do produto);
826:     *-- sem match, abre o picker (THIS.AbrirLookupCaracteristica)
827:     *-- ja filtrado pelo mesmo cgrus (o picker busca por codigo OU descricao,
828:     *-- entao serve aos dois caminhos). Selecionado (ou match exato achado),
829:     *-- confere duplicidade contra as demais linhas do proprio cursor antes
830:     *-- de gravar - igual ao "Select ... Where a.Codigos = ... And
831:     *-- a.pkChaves <> crSigPrCar.pkChaves" dos dois Valid legado.
832:         LPARAMETERS par_cValor, par_cPkChaves, par_cCampoBusca
833:         LOCAL loc_cFiltroGrupo, loc_cSQL, loc_nResultado, loc_lAchou
834:         LOCAL loc_cCodigoSel, loc_cDescrSel, loc_lDuplicado, loc_cCampoBusca
835: 
836:         loc_lAchou    = .F.
837:         loc_cCodigoSel = ""
838:         loc_cDescrSel  = ""
839:         loc_cCampoBusca = IIF(VARTYPE(par_cCampoBusca) = "C" AND !EMPTY(par_cCampoBusca), ;
840:                                par_cCampoBusca, "codigos")
841: 
842:         loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;
843:                             ", " + EscaparSQL(SPACE(3)) + ")"
844: 
845:         IF USED("cursor_4c_LkpCarExato")
846:             USE IN cursor_4c_LkpCarExato
847:         ENDIF
848: 
849:         loc_cSQL = "SELECT codigos, descrs FROM SigCrRap WHERE " + loc_cCampoBusca + " = " + ;
850:                    EscaparSQL(par_cValor) + " AND " + loc_cFiltroGrupo
851: 
852:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpCarExato")
853: 
854:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpCarExato") AND ;
855:            RECCOUNT("cursor_4c_LkpCarExato") = 1
856:             loc_cCodigoSel = ALLTRIM(cursor_4c_LkpCarExato.codigos)

*-- Linhas 897 a 1202:
897:         LOCATE FOR pkchaves == par_cPkChaves
898: 
899:         IF loc_lDuplicado
900:             MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " informada " + ;
901:                       "para este produto!", "Aten" + CHR(231) + CHR(227) + "o")
902:             THIS.LimparCampos()
903:         ELSE
904:             REPLACE codigos WITH loc_cCodigoSel, descrs WITH loc_cDescrSel IN cursor_4c_Dados
905: 
906:             *-- Grava em SigPrCar na hora (INSERT na linha nova, UPDATE na que
907:             *-- veio do CarregarLista). No legado quem gravava era o TABLEUPDATE
908:             *-- do form pai sobre crSigPrCar; aqui o dialogo tem DataSession e
909:             *-- BO proprios, entao sem esta chamada a escolha do usuario ficaria
910:             *-- so no cursor local e se perderia ao encerrar.
911:             IF !THIS.GravarCaracteristica(par_cPkChaves, loc_cCodigoSel)
912:                 *-- Gravacao recusada (a falha ja foi exibida): desfaz na grade
913:                 *-- para a tela nao mostrar o que o banco nao tem
914:                 SELECT cursor_4c_Dados
915:                 LOCATE FOR pkchaves == par_cPkChaves
916:                 IF FOUND()
917:                     THIS.LimparCampos()
918:                 ENDIF
919:             ENDIF
920:         ENDIF
921: 
922:         THIS.grd_4c_Dados.Refresh()
923:     ENDPROC
924: 
925:     *==========================================================================
926:     PROCEDURE CarregarLista
927:     *==========================================================================
928:         *-- Busca as caracteristicas do produto corrente e vincula a grade.
929:         *-- PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
930:         *-- direto de fora da classe (regra #3/CLAUDE.md)
931:         LOCAL loc_lSucesso
932:         loc_lSucesso = .F.
933: 
934:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
935:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cCpros)
936:         ENDIF
937: 
938:         *-- Cursor recem-lido do banco: toda linha existe em SigPrCar, logo nao
939:         *-- ha mais pendencia de INSERT (as linhas em branco que estavam na
940:         *-- lista nao voltam do SELECT)
941:         THIS.this_cPksNovos = ""
942: 
943:         IF USED("cursor_4c_Dados")
944:             SELECT cursor_4c_Dados
945:             GO TOP
946: 
947:             *-- RecordSource com referencia EXPLICITA, FORA de WITH (Problema 36) -
948:             *-- Column1/Column2 ja existem desde ConfigurarGrid (ColumnCount=2),
949:             *-- mas evitar WITH aqui segue o mesmo padrao canonico de FormCor.CarregarLista.
950:             THIS.grd_4c_Dados.RecordSource = ""
951:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
952:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.codigos"
953:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.descrs"
954: 
955:             *-- RecordSource/ControlSource resetam Width e Header1.Caption -
956:             *-- reconfigurar SEMPRE depois de vincular (Problema 48/CLAUDE.md)
957:             THIS.grd_4c_Dados.Column1.Width           = 150
958:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
959:             THIS.grd_4c_Dados.Column2.Width           = 290
960:             THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
961: 
962:             THIS.grd_4c_Dados.Refresh()
963:         ENDIF
964: 
965:         RETURN loc_lSucesso
966:     ENDPROC
967: 
968:     *==========================================================================
969:     PROCEDURE BtnInserirClick
970:     *==========================================================================
971:         *-- Espelha cmdInserir.Click do legado: garante UMA linha em branco
972:         *-- (Codigos vazio) para o usuario preencher via lookup (Fase 6).
973:         *-- Legado: Locate For CPros = crSigCdPro.CPros And Empty(Codigos) /
974:         *-- If Eof() / Insert Into crSigPrCar (CPros, pkChaves) ...
975:         *-- PUBLIC - alvo de BINDEVENT (regra #3)
976:         LOCAL loc_cPkNovo
977: 
978:         IF !USED("cursor_4c_Dados")
979:             RETURN
980:         ENDIF
981: 
982:         THIS.this_lHouveIncl = .T.
983: 
984:         SELECT cursor_4c_Dados
985:         LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCpros) AND EMPTY(codigos)
986: 
987:         IF !FOUND()
988:             loc_cPkNovo = fUniqueIds()
989: 
990:             APPEND BLANK
991:             REPLACE cpros    WITH THIS.this_cCpros, ;
992:                     pkchaves WITH loc_cPkNovo, ;
993:                     codigos  WITH "", ;
994:                     descrs   WITH ""
995: 
996:             *-- Linha existe so no cursor local ate o usuario escolher a
997:             *-- caracteristica (GravarCaracteristica faz o INSERT)
998:             THIS.RegistrarPkNovo(loc_cPkNovo)
999:         ENDIF
1000: 
1001:         *-- Popular o cursor NAO repinta a grade (regra #21)
1002:         THIS.grd_4c_Dados.Refresh()
1003:         THIS.grd_4c_Dados.Column1.SetFocus()
1004:     ENDPROC
1005: 
1006:     *==========================================================================
1007:     PROCEDURE RegistrarPkNovo
1008:     *==========================================================================
1009:     *-- Marca o pkchaves como linha criada nesta sessao e ainda NAO gravada em
1010:     *-- SigPrCar. PUBLIC - chamado tambem de GravarCaracteristica.
1011:         LPARAMETERS par_cPkChaves
1012:         LOCAL loc_cPk
1013:         loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1014: 
1015:         IF !EMPTY(loc_cPk) AND !THIS.EhRegistroNovo(loc_cPk)
1016:             THIS.this_cPksNovos = THIS.this_cPksNovos + "|" + loc_cPk + "|"
1017:         ENDIF
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     PROCEDURE RemoverPkNovo
1022:     *==========================================================================
1023:     *-- Tira o pkchaves da lista das linhas AINDA NAO GRAVADAS (a linha passou
1024:     *-- a existir no banco, ou foi descartada).
1025:     *-- PUBLIC - usado pelos handlers de botao.
1026:         LPARAMETERS par_cPkChaves
1027:         LOCAL loc_cPk
1028:         loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1029: 
1030:         IF !EMPTY(loc_cPk)
1031:             THIS.this_cPksNovos = STRTRAN(THIS.this_cPksNovos, "|" + loc_cPk + "|", "")
1032:         ENDIF
1033:     ENDPROC
1034: 
1035:     *==========================================================================
1036:     PROCEDURE EhRegistroNovo
1037:     *==========================================================================
1038:     *-- .T. quando a linha foi criada nesta sessao e ainda nao tem registro
1039:     *-- em SigPrCar (logo: INSERT ao gravar, exclusao apenas local ao apagar).
1040:     *-- PUBLIC - usado pelos handlers de botao e por GravarCaracteristica.
1041:         LPARAMETERS par_cPkChaves
1042:         LOCAL loc_cPk
1043:         loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1044: 
1045:         RETURN !EMPTY(loc_cPk) AND ;
1046:                ("|" + loc_cPk + "|") $ THIS.this_cPksNovos
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     PROTECTED PROCEDURE FormParaBO
1051:     *==========================================================================
1052:     *-- Transfere a ficha da TELA para o BO. Nesta tela a ficha eh a LINHA
1053:     *-- CORRENTE da grade, nao um conjunto de TextBox soltos: as tres colunas
1054:     *-- persistidas de SigPrCar (pkchaves / cpros / codigos) sao exatamente as
1055:     *-- colunas da linha, e as celulas editaveis da grade estao vinculadas a
1056:     *-- elas por ControlSource (cursor_4c_Dados.codigos / .descrs).
1057:     *--
1058:     *-- Os valores NAO podem ser lidos de Column1.Text1.Value /
1059:     *-- Column2.Text1.Value: em Grid esses controles sao a celula CORRENTE,
1060:     *-- re-vinculada quando o ponteiro do cursor se move - ler do cursor eh o
1061:     *-- unico jeito de garantir que se esta lendo a linha pretendida.
1062:     *--
1063:     *-- Retorno: .T. quando havia linha corrente para transferir.
1064:     *--
1065:     *-- PROTECTED por HERANCA, nao por escolha: FormBase declara FormParaBO,
1066:     *-- BOParaForm e LimparCampos como PROTECTED (sao os hooks que
1067:     *-- FormBase.Salvar/Novo/Excluir/Cancelar chamam por THIS.), e o VFP9 NAO
1068:     *-- deixa a subclasse ALARGAR o escopo. Omitir o PROTECTED aqui nao tornaria
1069:     *-- o metodo publico - so esconderia o fato: medido no VFP9 em 2026-09-26,
1070:     *-- PEMSTATUS(oForm, "FormParaBO", 5) devolve .T. e a chamada de FORA da
1071:     *-- classe estoura "Property FORMPARABO is not found" (mesma armadilha da
1072:     *-- regra #3 do CLAUDE.md). Chamado so de dentro (GravarCaracteristica).
1073:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1074:             RETURN .F.
1075:         ENDIF
1076: 
1077:         SELECT cursor_4c_Dados
1078:         IF EOF()
1079:             RETURN .F.
1080:         ENDIF
1081: 
1082:         WITH THIS.this_oBusinessObject
1083:             .this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkchaves)
1084:             .this_cCpros    = ALLTRIM(cursor_4c_Dados.cpros)
1085:             .this_cCodigos  = ALLTRIM(cursor_4c_Dados.codigos)
1086: 
1087:             *-- descrs nao existe em SigPrCar (vem do JOIN com SigCrRap) - o BO
1088:             *-- so a guarda para exibicao/auditoria, nao a grava
1089:             .this_cDescrs   = ALLTRIM(cursor_4c_Dados.descrs)
1090:         ENDWITH
1091: 
1092:         RETURN .T.
1093:     ENDPROC
1094: 
1095:     *==========================================================================
1096:     PROTECTED PROCEDURE BOParaForm
1097:     *==========================================================================
1098:     *-- Sentido inverso do FormParaBO: escreve as propriedades do BO na LINHA
1099:     *-- CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido para a
1100:     *-- grade exibir o que o BO efetivamente levou ao banco - em especial o
1101:     *-- pkchaves, que SigPrCarBO.Inserir gera por conta propria (fUniqueIds())
1102:     *-- quando chega vazio: sem esta volta a linha ficaria com PK diferente da
1103:     *-- do registro gravado e o Excluir/Atualizar seguinte apontaria para o
1104:     *-- lugar errado.
1105:     *--
1106:     *-- Retorno: .T. quando havia linha corrente para atualizar.
1107:     *-- PROTECTED por heranca de FormBase (ver nota em FormParaBO) - chamado so
1108:     *-- de dentro da classe (GravarCaracteristica).
1109:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1110:             RETURN .F.
1111:         ENDIF
1112: 
1113:         SELECT cursor_4c_Dados
1114:         IF EOF()
1115:             RETURN .F.
1116:         ENDIF
1117: 
1118:         REPLACE pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves, ;
1119:                 cpros    WITH THIS.this_oBusinessObject.this_cCpros, ;
1120:                 codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
1121:                 descrs   WITH THIS.this_oBusinessObject.this_cDescrs ;
1122:              IN cursor_4c_Dados
1123: 
1124:         *-- Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21)
1125:         THIS.grd_4c_Dados.Refresh()
1126: 
1127:         RETURN .T.
1128:     ENDPROC
1129: 
1130:     *==========================================================================
1131:     PROTECTED PROCEDURE LimparCampos
1132:     *==========================================================================
1133:     *-- Limpa os campos editaveis da LINHA CORRENTE da grade (Codigos/Descrs).
1134:     *-- Transcricao do "Replace Codigos With [], Descrs With [] In crSigPrCar"
1135:     *-- que os DOIS Valid do legado executam em tres situacoes: celula esvaziada
1136:     *-- pelo usuario, picker dispensado com ESC (Lastkey() = 27) e escolha
1137:     *-- recusada por duplicidade.
1138:     *--
1139:     *-- A linha em si NAO eh apagada aqui (o legado tambem nao apaga): ela fica
1140:     *-- em branco na grade e so eh descartada pelo Excluir ou pela limpeza do
1141:     *-- Encerrar (BtnSairClick), fielmente ao legado.
1142:     *--
1143:     *-- Retorno: .T. quando havia linha corrente para limpar.
1144:     *-- PROTECTED por heranca de FormBase (ver nota em FormParaBO) - chamado so
1145:     *-- de dentro da classe (handlers de celula e ValidarSelecaoCaracteristica,
1146:     *-- todos com THIS.).
1147:         IF !USED("cursor_4c_Dados")
1148:             RETURN .F.
1149:         ENDIF
1150: 
1151:         SELECT cursor_4c_Dados
1152:         IF EOF()
1153:             RETURN .F.
1154:         ENDIF
1155: 
1156:         REPLACE codigos WITH "", descrs WITH "" IN cursor_4c_Dados
1157: 
1158:         RETURN .T.
1159:     ENDPROC
1160: 
1161:     *==========================================================================
1162:     PROCEDURE GravarCaracteristica
1163:     *==========================================================================
1164:     *-- Persiste em SigPrCar a caracteristica escolhida para a linha
1165:     *-- par_cPkChaves. INSERT quando a linha nasceu nesta sessao (Inserir),
1166:     *-- UPDATE quando o usuario trocou a caracteristica de uma linha que veio
1167:     *-- do CarregarLista. Chamado por ValidarSelecaoCaracteristica assim que o
1168:     *-- par Codigo/Descricao eh resolvido - a gravacao eh imediata, igual a
1169:     *-- exclusao (BtnExcluirClick), porque este dialogo nao tem botao Confirmar
1170:     *-- e o Encerrar do legado nao grava nada.
1171:     *-- PUBLIC - chamado de ValidarSelecaoCaracteristica.
1172:         LPARAMETERS par_cPkChaves, par_cCodigos
1173:         LOCAL loc_cPk, loc_cCodigos, loc_lNovo, loc_lSucesso
1174: 
1175:         loc_lSucesso = .F.
1176:         loc_cPk      = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1177:         loc_cCodigos = IIF(VARTYPE(par_cCodigos)  = "C", ALLTRIM(par_cCodigos),  "")
1178: 
1179:         IF EMPTY(loc_cPk) OR EMPTY(loc_cCodigos) OR ;
1180:            VARTYPE(THIS.this_oBusinessObject) != "O"
1181:             RETURN .F.
1182:         ENDIF
1183: 
1184:         loc_lNovo = THIS.EhRegistroNovo(loc_cPk)
1185: 
1186:         IF loc_lNovo
1187:             *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
1188:             THIS.this_oBusinessObject.NovoRegistro()
1189:         ELSE
1190:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1191:             THIS.this_oBusinessObject.EditarRegistro()
1192:         ENDIF
1193: 
1194:         *-- FormParaBO le a LINHA CORRENTE - posicionar nela antes de chamar
1195:         SELECT cursor_4c_Dados
1196:         LOCATE FOR ALLTRIM(pkchaves) == loc_cPk
1197:         IF !FOUND()
1198:             RETURN .F.
1199:         ENDIF
1200: 
1201:         IF !THIS.FormParaBO()
1202:             RETURN .F.

*-- Linhas 1240 a 1288:
1240:     ENDPROC
1241: 
1242:     *==========================================================================
1243:     PROCEDURE BtnExcluirClick
1244:     *==========================================================================
1245:         *-- Espelha cmdExcluir.Click do legado. Linha ja persistida (Codigos
1246:         *-- preenchido) eh excluida de verdade via BO (gravacao nunca eh muda -
1247:         *-- CLAUDE.md); linha ainda em edicao (Codigos vazio, nunca gravada)
1248:         *-- eh so removida do cursor local. PUBLIC - alvo de BINDEVENT (regra #3)
1249:         LOCAL loc_cPkChaves
1250: 
1251:         IF !USED("cursor_4c_Dados")
1252:             RETURN
1253:         ENDIF
1254: 
1255:         SELECT cursor_4c_Dados
1256:         IF EOF()
1257:             RETURN
1258:         ENDIF
1259: 
1260:         *-- Guard do legado: "If Not Eof() And (crSigPrCar.CPros =
1261:         *-- crSigCdPro.CPros)" - so apaga linha do produto corrente
1262:         IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCpros)
1263:             RETURN
1264:         ENDIF
1265: 
1266:         loc_cPkChaves = ALLTRIM(pkchaves)
1267: 
1268:         IF !EMPTY(codigos) AND !THIS.EhRegistroNovo(loc_cPkChaves)
1269:             *-- Linha veio do banco (ou ja foi gravada nesta sessao): apaga la
1270:             THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves
1271:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1272: 
1273:             IF THIS.this_oBusinessObject.Excluir()
1274:                 THIS.this_lHouveExcl = .T.
1275:                 THIS.CarregarLista()
1276:             ELSE
1277:                 IF !THIS.this_oBusinessObject.this_lErroExibido
1278:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir " + ;
1279:                             "a caracter" + CHR(237) + "stica.", "Erro")
1280:                 ENDIF
1281:             ENDIF
1282:         ELSE
1283:             *-- Linha criada nesta sessao e ainda sem registro em SigPrCar -
1284:             *-- remove so localmente, igual ao Delete/Skip/Skip-1 do legado
1285:             *-- (SET DELETED ON no config.prg ja esconde o registro da grade)
1286:             THIS.RemoverPkNovo(loc_cPkChaves)
1287: 
1288:             DELETE

*-- Linhas 1295 a 1432:
1295:     ENDPROC
1296: 
1297:     *==========================================================================
1298:     PROCEDURE BtnSairClick
1299:     *==========================================================================
1300:         *-- Espelha cmdSair.Click do legado: em modo INSERIR/ALTERAR, descarta
1301:         *-- linhas deixadas em branco (Codigos vazio) antes de encerrar.
1302:         *--
1303:         *-- Linha em branco que NAO esta na lista das linhas ainda nao gravadas eh linha que veio
1304:         *-- do banco e teve a caracteristica limpa (picker cancelado / escolha
1305:         *-- duplicada): no legado ela ficava marcada para Delete e o TABLEUPDATE
1306:         *-- do form pai a apagava de SigPrCar - aqui isso tem de ser feito pelo
1307:         *-- BO, senao o registro antigo sobrevive ao que o usuario apagou.
1308:         *-- PUBLIC - alvo de BINDEVENT (regra #3)
1309:         LOCAL loc_cPkChaves
1310: 
1311:         IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
1312:            INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
1313: 
1314:             IF USED("cursor_4c_Dados")
1315:                 SELECT cursor_4c_Dados
1316:                 SCAN
1317:                     IF EMPTY(codigos)
1318:                         loc_cPkChaves = ALLTRIM(pkchaves)
1319: 
1320:                         IF !THIS.EhRegistroNovo(loc_cPkChaves)
1321:                             THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves
1322:                             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1323: 
1324:                             IF THIS.this_oBusinessObject.Excluir()
1325:                                 THIS.this_lHouveExcl = .T.
1326:                             ELSE
1327:                                 IF !THIS.this_oBusinessObject.this_lErroExibido
1328:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1329:                                             "vel excluir a caracter" + CHR(237) + ;
1330:                                             "stica.", "Erro")
1331:                                 ENDIF
1332:                             ENDIF
1333:                         ELSE
1334:                             THIS.RemoverPkNovo(loc_cPkChaves)
1335:                         ENDIF
1336: 
1337:                         *-- Excluir() do BO faz SQLEXEC (DELETE + auditoria) e
1338:                         *-- pode deixar outra area corrente - reposicionar antes
1339:                         *-- de apagar a linha local
1340:                         SELECT cursor_4c_Dados
1341:                         LOCATE FOR ALLTRIM(pkchaves) == loc_cPkChaves
1342:                         IF FOUND()
1343:                             DELETE
1344:                         ENDIF
1345:                     ENDIF
1346:                 ENDSCAN
1347:             ENDIF
1348:         ENDIF
1349: 
1350:         THIS.Release()
1351:     ENDPROC
1352: 
1353:     *==========================================================================
1354:     PROTECTED PROCEDURE ConfigurarDecoracao
1355:     *==========================================================================
1356:         LOCAL loc_cImgFundo
1357: 
1358:         *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRCAR original).
1359:         *-- O nome da global tem de ser testado com TYPE() antes de ser USADO:
1360:         *-- gc_4c_CaminhoFramework eh criada pelo config.prg, e o
1361:         *-- ValidarUIFidelity.prg NAO roda config.prg - ele monta o ambiente com
1362:         *-- SET PROCEDURE manual e declara apenas gnConnHandle,
1363:         *-- gc_4c_CaminhoIcones e gb_4c_ValidandoUI (linhas 124-127). Sem o
1364:         *-- teste, a referencia estoura "Variable GC_4C_CAMINHOFRAMEWORK is not
1365:         *-- found" DENTRO do TRY do InicializarForm, o CATCH chama MsgErro e -
1366:         *-- como o validador tambem nao seta gc_4c_ArquivoErroTeste, que eh o
1367:         *-- que faz messages.prg desviar o dialogo para arquivo - abre um MODAL
1368:         *-- de verdade que PENDURA o harness (medido em 2026-09-26: vfp9.exe
1369:         *-- parado 4min30 com 0,25s de CPU, segurando o proprio .log aberto).
1370:         IF TYPE("gc_4c_CaminhoFramework") = "C"
1371:             loc_cImgFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
1372:             IF FILE(loc_cImgFundo)
1373:                 THIS.Picture = loc_cImgFundo
1374:             ENDIF
1375:         ENDIF
1376: 
1377:         *-- Shape1 do legado: elemento decorativo atras dos botoes de acao
1378:         *-- Top=-3, Left=239, Width=250, Height=38, BackStyle=0, BorderStyle=0
1379:         THIS.AddObject("shp_4c_Shape1", "Shape")
1380:         WITH THIS.shp_4c_Shape1
1381:             .Top         = -3
1382:             .Left        = 239
1383:             .Height      = 38
1384:             .Width       = 250
1385:             .BackStyle   = 0
1386:             .BorderStyle = 0
1387:             .BorderColor = RGB(136, 189, 188)
1388:         ENDWITH
1389:     ENDPROC
1390: 
1391:     *==========================================================================
1392:     PROTECTED PROCEDURE ConfigurarCabecalho
1393:     *==========================================================================
1394:         LOCAL loc_nW
1395: 
1396:         *-- 800, o valor LITERAL do cntSombra no SCX, e NAO THIS.Width (480):
1397:         *-- o legado declara um container mais LARGO que o proprio form e deixa o
1398:         *-- form recortar o excesso. Visualmente da no mesmo (a faixa cobre toda
1399:         *-- a largura util nos dois casos) e nao ha o risco que a regra #10/#11
1400:         *-- combate - aquele vem de SUBTRAIR largura (THIS.Width - 60), que
1401:         *-- expoe uma faixa clara a direita; aqui se cobre de sobra. Transcrever
1402:         *-- o numero do SCX eh PILAR 1 literal e evita divergencia na validacao
1403:         *-- de UI, que compara contra o dump.
1404:         loc_nW = 800
1405: 
1406:         *-- Container cabecalho cinza (cntSombra do legado)
1407:         *-- Top=0, Left=0, Height=80, BackColor=RGB(100,100,100)
1408:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
1409:         WITH THIS.cnt_4c_Cabecalho
1410:             .Top         = 0
1411:             .Left        = 0
1412:             .Width       = loc_nW
1413:             .Height      = 80
1414:             .BackStyle   = 1
1415:             .BackColor   = RGB(100, 100, 100)
1416:             .BorderWidth = 0
1417: 
1418:             *-- lblSombra: Top=25, Left=10, FontSize=18, ForeColor preto
1419:             *-- (efeito de profundidade atras do lblTitulo)
1420:             .AddObject("lbl_4c_Sombra", "Label")
1421:             WITH .lbl_4c_Sombra
1422:                 .AutoSize  = .F.
1423:                 .Top       = 25
1424:                 .Left      = 10
1425:                 .Width     = loc_nW - 31   && 769 = 800 - 31, valor literal do SCX
1426:                 .Height    = 40
1427:                 .Caption   = ""
1428:                 .FontName  = "Tahoma"
1429:                 .FontSize  = 18
1430:                 .FontBold  = .T.
1431:                 .BackStyle = 0
1432:                 .ForeColor = RGB(0, 0, 0)

*-- Linhas 1457 a 1503:
1457:     ENDPROC
1458: 
1459:     *==========================================================================
1460:     PROTECTED PROCEDURE TornarControlesVisiveis
1461:     *==========================================================================
1462:         LPARAMETERS par_oContainer
1463:         LOCAL loc_oContainer, loc_i, loc_oControl
1464: 
1465:         IF VARTYPE(par_oContainer) = "O"
1466:             loc_oContainer = par_oContainer
1467:         ELSE
1468:             loc_oContainer = THIS
1469:         ENDIF
1470: 
1471:         FOR loc_i = 1 TO loc_oContainer.ControlCount
1472:             loc_oControl = loc_oContainer.Controls(loc_i)
1473:             IF VARTYPE(loc_oControl) = "O"
1474:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1475:                     THIS.TornarControlesVisiveis(loc_oControl)
1476:                 ENDIF
1477:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1478:                     loc_oControl.Visible = .T.
1479:                 ENDIF
1480:             ENDIF
1481:         ENDFOR
1482:     ENDPROC
1483: 
1484:     *==========================================================================
1485:     PROCEDURE Destroy
1486:     *==========================================================================
1487:         *-- Reabilita o form pai (mirrors ThisForm.ParentForm.Enabled = .T.
1488:         *-- do cmdSair.Click do legado - feito aqui no Destroy para valer
1489:         *-- em qualquer caminho de fechamento, nao so no botao Sair)
1490:         IF VARTYPE(THIS.par_oFormPai) = "O"
1491:             THIS.par_oFormPai.Enabled = .T.
1492:         ENDIF
1493: 
1494:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1495:             THIS.this_oBusinessObject = .NULL.
1496:         ENDIF
1497: 
1498:         THIS.par_oFormPai = .NULL.
1499: 
1500:         DODEFAULT()
1501:     ENDPROC
1502: 
1503: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
*
* Business Object para SigPrCar (Caracteristicas do Produto)
* Tabela: SigPrCar (codigos char(20), cpros char(14), pkchaves char(20) - PK)
* Sub-formulario modal chamado de dentro do Cadastro de Produtos (SigCdPro)
* para gerenciar as caracteristicas vinculadas ao produto corrente.
* A descricao (Descrs) nao existe na tabela SigPrCar - vem do lookup em
* SigCrRap (tabela de caracteristicas) filtrado pelo Cgrus do produto.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCar)
    this_cPkChaves = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cCpros    = ""    && cpros char(14) - FK para SigCdPro.CPros
    this_cCodigos  = ""    && codigos char(20) - FK para SigCrRap.Codigos

    *-- Propriedade de apoio (NAO persistida em SigPrCar - vem do JOIN com SigCrRap)
    this_cDescrs   = ""    && descrs - descricao da caracteristica (SigCrRap.Descrs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
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
                THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
                THIS.this_cCpros    = TratarNulo(cpros,    "C")
                THIS.this_cCodigos  = TratarNulo(codigos,  "C")

                *-- descrs so existe se o cursor veio de um JOIN com SigCrRap
                IF TYPE(par_cAliasCursor + ".descrs") = "C"
                    THIS.this_cDescrs = TratarNulo(descrs, "C")
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrCarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o informado!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodigos)
            MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCar (codigos, cpros, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCar
                SET codigos = <<EscaparSQL(THIS.this_cCodigos)>>,
                    cpros   = <<EscaparSQL(THIS.this_cCpros)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCar WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca as caracteristicas vinculadas a um produto (par_cCpros)
    * Retorna cursor_4c_Dados com pkchaves, cpros, codigos, descrs
    * (descrs vem do JOIN com SigCrRap)
    *====================================================================
    PROCEDURE Buscar(par_cCpros)
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
                SELECT a.pkchaves, a.cpros, a.codigos, b.descrs
                FROM SigPrCar a
                INNER JOIN SigCrRap b ON b.codigos = a.codigos
                WHERE a.cpros = <<EscaparSQL(par_cCpros)>>
                ORDER BY b.descrs
            ENDTEXT

            *-- SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            *-- (Inserir) e apagar (Excluir) linhas localmente, entao o
            *-- resultado eh copiado para um cursor READWRITE (CLAUDE.md:
            *-- "Grid com coluna EDITAVEL exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

