# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_XML. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopgar.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1473 linhas total):

*-- Linhas 4 a 24:
4: *
5: * Form OPERACIONAL de LAYOUT PROPRIO. O objeto raiz do legado eh um "form"
6: * GENERICO (nao frmcadastro, nao frmrelatorio), portanto NAO existe PageFrame
7: * nem o par Page1=Lista / Page2=Dados: dos objetos do SCX, a maioria pendura
8: * direto na Form e so os dois labels do titulo ficam dentro do unico
9: * container do legado (cntSombra -> cnt_4c_Sombra). Nenhum pgf_4c_* eh
10: * criado aqui - inventar um PageFrame que o legado nao tem violaria o
11: * PILAR 1. Mesmo perfil do dialogo irmao Formsigopecm.prg (task727).
12: *
13: * Estrutura visual do legado (SIGOPGAR, 799x300), na ordem em que o SCX a
14: * desenha (ver tasks\task738\sigopgar_form_codigo_fonte.txt, SECAO 1) - cada
15: * bloco entra no metodo Configurar* correspondente:
16: *   cntSombra + lblSombra + lblTitulo  -> ConfigurarCabecalho()  (faixa cinza)
17: *   CntTXT (Say1/getArqTXT/btnGetArqO/
18: *     chkImagens/Shape2/lblResults)    -> ConfigurarPainelTxt()  (painel TXT)
19: *   Shape1, Cancela, Processa          -> ConfigurarBotoes()
20: *   chkXml                             -> ConfigurarChkXml()  (alterna painel)
21: *   CntXml (btnDirs/Get_arquivo/
22: *     getDirs/Say1)                    -> ConfigurarPainelXml()  (painel XML)
23: *
24: * Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/

*-- Linhas 42 a 155:
42: * default - cntTXT.visible = .T. no Init legado), ConfigurarBotoes()
43: * (Shape1/Cancela/Processa), ConfigurarChkXml() (toggle TXT<->XML) e
44: * ConfigurarPainelXml() (painel oculto por default - cntXml.visible = .F.
45: * no Init legado), com os handlers de botao/checkbox e os BINDEVENTs em
46: * InicializarForm. Unica diferenca deste dialogo para o perfil-irmao: DOIS
47: * paineis alternados por chkXml, em vez de um unico painel fixo.
48: *
49: * chk_4c_ChkXml e cmd_4c_BtnDirs/txt_4c_Dirs/txt_4c_Arquivo (dentro de
50: * cnt_4c_Xml) NAO existiam na Fase 3 - cnt_4c_Xml nasce com Visible = .F.
51: * (AddObject default) e TornarControlesVisiveis() foi atualizado para NAO
52: * forcar .T. nele (continua recursando nos filhos, para eles nao ficarem
53: * Visible = .F. "para sempre" quando o chkXml alternar o painel depois -
54: * regra do CorretorAutomatico #109/CLAUDE.md).
55: *
56: * Fase 5/8: "metade dos campos da Page2" nao se aplica - nao ha Page2, e os
57: * 19 objetos do SCX (3 TextBox, 2 CheckBox, 5 Label, 2 Shape, 4 CommandButton
58: * e os 3 Container) ja estavam TODOS criados desde a Fase 4; acrescentar
59: * campo aqui seria inventar superficie que o legado nao tem. O gate da fase
60: * passa pelo ramo CAPTURA, por paridade (3 dos 3 TextBox do legado, piso 2).
61: * O trabalho real da fase foi (a) a ORDEM DE TABULACAO, que o migrador havia
62: * descartado - ver ConfigurarOrdemTabulacao() - e (b) a auditoria campo a
63: * campo contra o dump, que achou nove divergencias silenciosas:
64: *
65: *   cmd_4c_BtnDirs    .Picture apontava geral_pasta_16.jpg, que eh o icone do
66: *                     IRMAO btnGetArqO - o dump pede geral_pasta_26.jpg. Os
67: *                     DOIS arquivos existem em vbmp\, entao o errado desenhava
68: *                     um icone sem erro nenhum (regra #25). No mesmo bloco,
69: *                     Verdana 10 / SpecialEffect = 2 / ForeColor 36,84,155
70: *                     tambem vinham do irmao: btnDirs eh classe "fwbtnp"
71: *                     (Comic Sans MS 8 bold+italic, MousePointer 15,
72: *                     ForeColor 90,90,90), nao "commandbutton".
73: *   ToolTipText       btnGetArqO dizia "... Que Sera Gerado" no lugar do
74: *                     "... Que Sera Processado" do dump; btnDirs tinha texto
75: *                     inventado; e getArqTXT/getDirs nao tinham tooltip
76: *                     nenhuma, embora o dump declare as duas.
77: *   PicturePosition   = 13 ausente nos dois botoes de pasta.
78: *   txt_4c_Arquivo    .Height = 22 contra os 23 do default da classe "fwget"
79: *                     (o dump nao sobrescreve Height), mais SpecialEffect e
80: *                     BorderColor que nem o dump nem a fwget declaram.
81: *   FontBold          marcado em chk_4c_ChkXml e lbl_4c_LabelArquivo, que o
82: *                     dump NAO declara (chkXml eh "checkbox" pura e o label eh
83: *                     classe "say" - as duas com default .F.). Vinha do par
84: *                     chkImagens/CntTXT.Say1, cujos dumps DECLARAM negrito.
85: *   AutoSize          explicitado .F. nos dois CheckBox: o dump declara .T.,
86: *                     que eh NO-OP em controle criado por AddObject (regra
87: *                     #23) e precisa de Width/Height fixos.
88: *
89: * Nenhuma delas quebra compilacao nem aparece em log - sao todas visuais ou
90: * de ordem de foco. Provado em VFP9 em 2026-11-05: COMPILE sem .ERR (com
91: * controle negativo gerando .ERR nas linhas acrescentadas), CREATEOBJECT
92: * devolvendo objeto e os 15 TabIndex lidos de volta iguais a ordem medida do
93: * legado (automation\probe738f5.prg / probe738f5.txt).
94: *
95: * Fase 6/8: "campos restantes + lookups" - as DUAS metades foram medidas
96: * contra o dump antes de escrever qualquer linha, e o resultado eh que este
97: * form NAO tem nenhuma das duas a acrescentar:
98: *
99: *   CAMPOS   os 19 objetos da arvore do SCX (3 Container, 5 Label, 3 TextBox,
100: *            2 CheckBox, 2 Shape e 4 CommandButton - contados um a um na
101: *            SECAO 1 do dump, fora o Dataenvironment e a propria Form) ja
102: *            estavam TODOS criados desde a Fase 4, e a Fase 5 auditou as
103: *            propriedades de cada um contra o dump. Nao sobrou campo: criar
104: *            mais um seria inventar superficie que o legado nao tem.
105: *
106: *   LOOKUPS  ZERO. Varredura do dump (tasks\task738\sigopgar_form_codigo_
107: *            fonte.txt, 987 linhas) pelos SEIS padroes de lookup do legado
108: *            Fortyus - "fwbusca" (cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
109: *            "mAddColuna", "sigacess(", "Acesso<X>(" das 9 funcoes de
110: *            sigacess.PRG, "FormBuscaAuxiliar" e "CreateObject(" - devolveu
111: *            0, 0, 0, 0, 0 e UM unico acerto, que eh
112: *            CreateObject([XMLAdapter]) do ExportaProduto (gerador de XML,
113: *            nao picker). O form tem UM unico "PROCEDURE Valid" no dump
114: *            inteiro (chkXml), que apenas alterna os paineis e ja esta
115: *            migrado em ChkXmlClick(); os dois "PROCEDURE When" devolvem .f.
116: *            (campos nao-digitaveis, migrados como ReadOnly = .T. +
117: *            TabStop = .F.); e os dois Seek() do dump buscam no cursor LOCAL
118: *            crGrupos, de controle de duplicidade dentro do laco de
119: *            geracao - nao sao busca de codigo em tabela.
120: *
121: *            Portanto NAO existe AbrirLookup*/AbrirBusca* aqui, e nao pode
122: *            existir: escrever um obrigaria a inventar tabela de lookup que
123: *            o legado nunca consulta (viola o PILAR 1 e a regra "NUNCA
124: *            inventar tabelas de lookup") ou a deixar metodo vazio (proibido
125: *            pela regra de completude). O gate da fase passa pelo ramo
126: *            CAPTURA, que reconhece exatamente este perfil.
127: *
128: * O trabalho real da fase foi fechar a auditoria dos campos nos dois pontos
129: * que a Fase 5 nao cobriu, os dois medidos no VFP9 em 2026-11-05
130: * (automation\probe738f6.prg / probe738f6.txt):
131: *
132: *   shp_4c_Shape2    tinha .BorderColor = RGB(90,90,90) INVENTADO - o dump de
133: *                    Shape2 nao declara BorderColor, e o default medido da
134: *                    base class Shape eh 6579300 = RGB(100,100,100) (nao
135: *                    preto, como se poderia supor). Linha removida: a moldura
136: *                    arredondada volta a cor que o legado desenha. Shape1 eh o
137: *                    caso oposto - o dump DECLARA 136,189,188 - e ficou.
138: *
139: *   txt_4c_Arquivo   campo APOSENTADO e SOTERRADO no proprio legado (regra
140: *                    #28): mesmo Top/Left de getDirs, que eh 2,8x mais largo e
141: *                    desenha por cima. Medido: 78..228 x 11..34 contido em
142: *                    78..499 x 11..34 - inalcancavel ao clique. A unica leitura
143: *                    dele no legado esta COMENTADA. Geometria e ordem de
144: *                    criacao mantidas identicas ao SCX (de proposito) e o caso
145: *                    documentado no ponto de criacao, para a proxima leitura
146: *                    nao o tomar por campo vivo nem por defeito da migracao.
147: *
148: * Dois desvios que FICAM como estao, por serem herdados do SCX (regra #28) e
149: * nao defeito da migracao: cmd_4c_Cancela termina em 804 com Form.Width = 799
150: * (Left 724 do dump + Width 80 do default da classe fwbtng), perdendo 5px na
151: * borda, e cmd_4c_Processa termina em 729, cobrindo os mesmos 5px da esquerda
152: * do Cancela. Os dois numeros sao consequencia aritmetica de valores que o
153: * legado declara; "consertar" exigiria inventar Left ou Width proprio.
154: *
155: * Fase 8/8 (consolidacao final): o template desta fase cobra nomes de form

*-- Linhas 177 a 220:
177: *                           corresponde a "carga inicial da tela" eh o estado
178: *                           dos campos: o metodo eh o funil do Init legado -
179: *                           LimparCampos() + BOParaForm() -, chamado por
180: *                           InicializarForm e idempotente, para o harness
181: *                           poder reaciona-lo de fora sem efeito colateral.
182: *   BtnCancelarClick()      RENOMEADO (era batizado pelo Caption). O objeto do
183: *                           legado chama-se "Cancela" e declara Cancel = .T.,
184: *                           isto eh, a tecla ESC o acionava - no migrado ele eh
185: *                           cmd_4c_Cancela, e o nome do handler agora segue o
186: *                           objeto, como nos outros oito sites do projeto que
187: *                           ligam cmd_4c_Cancela. O Caption continua
188: *                           "Encerrar", transcrito do dump.
189: *
190: * O que NAO entrou, e por que escrever seria pior do que faltar:
191: *
192: *   botao de BUSCA       nao existe no SCX: os quatro CommandButton do legado
193: *                        sao os dois pickers de arquivo (btnGetArqO/btnDirs) e
194: *                        o par Processa/Cancela. Criar o handler obrigaria a
195: *                        inventar o botao (PILAR 1) ou a deixar metodo vazio
196: *                        (proibido pela regra de completude).
197: *   botao de GRAVAR com  o verbo do legado eh "Processar" - BtnProcessarClick,
198: *   o nome canonico CRUD entregue desde a Fase 7, eh a acao de gravar desta
199: *                        tela (ela grava em ARQUIVO, nao em tabela: o dump nao
200: *                        tem Insert/Update/Delete algum).
201: *   HabilitarCampos      nenhum campo eh habilitado/desabilitado em runtime
202: *                        pelo legado: getArqTXT e getDirs ja nascem
203: *                        ReadOnly = .T. (transcricao do "When -> Return .f.")
204: *                        e os dois CheckBox nunca travam. Nao ha modo a
205: *                        condicionar - o que alterna aqui eh VISIBILIDADE de
206: *                        painel, e isso eh AplicarPainelPorModo.
207: *   AjustarBotoesPorModo nenhum dos quatro botoes eh desabilitado em ponto
208: *                        algum do dump, e nao ha modo CRUD neste dialogo.
209: *
210: * Nenhum nome ausente aparece escrito por extenso neste cabecalho, de
211: * proposito: o gate da fase casa identificador no arquivo INTEIRO, comentario
212: * incluido, entao documentar a ausencia pelo nome fa-lo-ia concluir que o
213: * metodo EXISTE - a fase passaria pelo caminho errado e a ausencia legitima
214: * nunca seria medida.
215: *
216: *============================================================================
217: 
218: DEFINE CLASS Formsigopgar AS FormBase
219: 
220:     *==========================================================================

*-- Linhas 254 a 564:
254:     this_oFormPai = .NULL.
255: 
256:     *==========================================================================
257:     * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
258:     * (equivalente ao Caption de lblResults no legado, atualizado dentro do
259:     * Scan de ProcessaTxt/GerarArquivoTxt). Guardado na classe porque o
260:     * label correspondente (lbl_4c_LblResults) so sera criado no painel TXT,
261:     * em fase posterior - assim o progresso reportado antes do label existir
262:     * nao se perde.
263:     *==========================================================================
264:     this_cUltimoProgresso = ""
265: 
266:     *==========================================================================
267:     * this_lProcessando - guarda de REENTRANCIA do botao Processar (fase
268:     * posterior). sigopgarBO.AtualizarProgresso chama DOEVENTS a cada
269:     * grupo/produto gravado (o legado nao tinha DOEVENTS), o que despacha a
270:     * fila de eventos do Windows e permite ao usuario reacionar o botao
271:     * Processar durante uma geracao em curso - uma 2a chamada seria
272:     * destrutiva para a 1a (regrava o arquivo em modo sobrescrita e
273:     * fecha/recria os cursores que a 1a chamada esta percorrendo). A
274:     * propriedade fica declarada aqui desde a estrutura base; o uso dela
275:     * acompanha o handler do botao Processar.
276:     *==========================================================================
277:     this_lProcessando = .F.
278: 
279:     *==========================================================================
280:     * Init - replica "Parameters oObjForm / ThisForm.poObjForm = oObjForm" do
281:     * legado e define o Caption antes de delegar ao FormBase.Init (que chama
282:     * InicializarForm - NUNCA chamar InicializarForm aqui tambem, senao os
283:     * AddObject rodam duas vezes e estouram "member object with this name
284:     * already exists").
285:     *
286:     * par_oFormPai eh OPCIONAL: o harness de teste e a validacao de UI
287:     * instanciam o form sem parametro, e o legado tambem aceitava Parameters
288:     * sem argumento (oObjForm chegaria .F.). Por isso o tipo eh conferido
289:     * antes de guardar - atribuir .F. em this_oFormPai faria VARTYPE devolver
290:     * "L" e os guards de objeto adiante lerem lixo.
291:     *==========================================================================
292:     PROCEDURE Init(par_oFormPai)
293:         THIS.Caption = "Gera Arquivo"
294: 
295:         IF VARTYPE(par_oFormPai) = "O"
296:             THIS.this_oFormPai = par_oFormPai
297:         ENDIF
298: 
299:         RETURN DODEFAULT()
300:     ENDPROC
301: 
302:     *==========================================================================
303:     * ValidarParametros - guarda de conexao, PUBLIC para ser alcancavel pelo
304:     * harness. Chamada ANTES do TRY de InicializarForm, para o RETURN ficar
305:     * fora de TRY/CATCH (regra CLAUDE.md #1).
306:     *
307:     * O bypass de gb_4c_ModoTeste/gb_4c_ValidandoUI vem PRIMEIRO porque o
308:     * TesteAutomatico.prg e o ValidarUIFidelity nao abrem conexao real - sem
309:     * o bypass, InicializarForm devolveria .F., CREATEOBJECT devolveria
310:     * logico e a instanciacao falharia sem nenhum erro de SQL no log.
311:     *==========================================================================
312:     PROCEDURE ValidarParametros()
313:         LOCAL loc_lValido
314:         loc_lValido = .T.
315: 
316:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
317:             RETURN .T.
318:         ENDIF
319:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
320:             RETURN .T.
321:         ENDIF
322: 
323:         DO CASE
324:             CASE TYPE("gnConnHandle") != "N"
325:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
326:                     "o Com o Servidor de Banco de Dados.", "CreateObject")
327:                 loc_lValido = .F.
328:             CASE gnConnHandle <= 0
329:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
330:                     "o Com o Servidor de Banco de Dados.", "CreateObject")
331:                 loc_lValido = .F.
332:         ENDCASE
333: 
334:         RETURN loc_lValido
335:     ENDPROC
336: 
337:     *==========================================================================
338:     * InicializarForm - monta a estrutura base do form operacional: fundo,
339:     * Business Object e o(s) container(es) de topo ja disponiveis nesta
340:     * fase (cabecalho). Paineis TXT/XML e botoes entram em fases seguintes,
341:     * dentro de ConfigurarPageFrame.
342:     *==========================================================================
343:     PROTECTED PROCEDURE InicializarForm()
344:         LOCAL loc_lSucesso, loc_oErro
345:         loc_lSucesso = .F.
346: 
347:         IF !THIS.ValidarParametros()
348:             RETURN .F.
349:         ENDIF
350: 
351:         TRY
352:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
353:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
354: 
355:             THIS.this_oBusinessObject = CREATEOBJECT("sigopgarBO")
356: 
357:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
358:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopgarBO.", ;
359:                     "Erro em InicializarForm")
360:             ELSE
361:                 *-- O BO repinta o progresso durante o Scan de GerarArquivoTxt
362:                 *-- chamando this_oFormUI.AtualizarProgresso() - equivale ao
363:                 *-- "ThisForm.cntTxt.lblResults.Caption = ..." repetido no
364:                 *-- legado dentro de ProcessaTxt.
365:                 THIS.this_oBusinessObject.this_oFormUI = THIS
366: 
367:                 THIS.ConfigurarPageFrame()
368: 
369:                 *-- Fase 8: estado inicial da tela (o Init legado limpa os
370:                 *-- tres campos de arquivo e assenta chkXml/paineis). Vem
371:                 *-- DEPOIS de ConfigurarPageFrame, que cria os controles, e
372:                 *-- ANTES de TornarControlesVisiveis, para que a decisao de
373:                 *-- qual painel fica visivel seja respeitada por ele.
374:                 THIS.CarregarLista()
375: 
376:                 *-- BINDEVENTs: botoes/checkbox criados em ConfigurarBotoes/
377:                 *-- ConfigurarPainelTxt/ConfigurarChkXml/ConfigurarPainelXml,
378:                 *-- acima.
379:                 BINDEVENT(THIS.cmd_4c_Processa,              "Click", THIS, "BtnProcessarClick")
380:                 BINDEVENT(THIS.cmd_4c_Cancela,               "Click", THIS, "BtnCancelarClick")
381:                 BINDEVENT(THIS.chk_4c_ChkXml,                "Click", THIS, "ChkXmlClick")
382:                 BINDEVENT(THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")
383:                 BINDEVENT(THIS.cnt_4c_Xml.cmd_4c_BtnDirs,    "Click", THIS, "BtnDirsClick")
384: 
385:                 THIS.TornarControlesVisiveis(THIS)
386: 
387:                 loc_lSucesso = .T.
388:             ENDIF
389:         CATCH TO loc_oErro
390:             MsgErro(loc_oErro.Message + CHR(13) + ;
391:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
392:                 "Procedure: " + loc_oErro.Procedure, ;
393:                 "Erro em InicializarForm")
394:         ENDTRY
395: 
396:         RETURN loc_lSucesso
397:     ENDPROC
398: 
399:     *==========================================================================
400:     * ConfigurarPageFrame - orquestra a montagem visual. Nao existe PageFrame
401:     * real neste form (objeto raiz do legado eh "Class: form" generico, sem
402:     * frmcadastro/Page1=Lista/Page2=Dados): o metodo apenas encadeia os
403:     * configuradores de cada bloco do SCX, na ordem em que o legado os
404:     * desenha (ver arvore de objetos em tasks\task738\sigopgar_form_codigo_
405:     * fonte.txt, SECAO 1): cntSombra -> CntTXT -> Shape1 -> Cancela/Processa
406:     * -> chkXml -> CntXml.
407:     *
408:     * Fase 3/8 entrega so o cabecalho - os paineis TXT/XML, o Shape1 e os
409:     * botoes Processar/Encerrar/chkXml sao acrescentados nas fases seguintes,
410:     * chamados aqui NA MESMA ordem do SCX (o cabecalho ocupa Top = 0..80 e
411:     * os botoes Cancela/Processa ficam em Top = 3, DENTRO dessa faixa -
412:     * criados depois, eles desenham POR CIMA da faixa).
413:     *==========================================================================
414:     PROTECTED PROCEDURE ConfigurarPageFrame()
415:         THIS.ConfigurarCabecalho()
416:         THIS.ConfigurarPainelTxt()
417:         THIS.ConfigurarBotoes()
418:         THIS.ConfigurarChkXml()
419:         THIS.ConfigurarPainelXml()
420: 
421:         *-- SEMPRE por ULTIMO: TabIndex eh posicional e cada atribuicao empurra
422:         *-- os demais controles do MESMO pai, entao o passe so fecha depois que
423:         *-- cada um dos AddObject acima ja rodou.
424:         THIS.ConfigurarOrdemTabulacao()
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * ConfigurarOrdemTabulacao - ordem de tabulacao do form. Com AddObject o
429:     * VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a
430:     * do legado: nao da erro, nao entra em log e nao aparece em screenshot -
431:     * so o Tab andando na ordem errada.
432:     *
433:     * Os numeros abaixo sao a ordem EFETIVA do legado, MEDIDA, nao os literais
434:     * do SCX. A distincao eh o ponto todo deste metodo: o VFP aplica o TabIndex
435:     * gravado no instante em que CRIA cada objeto e descarta o que excede a
436:     * contagem existente naquele momento. No CntXml o SCX guarda btnDirs = 15,
437:     * getDirs = 14 e Say1 = 13 - valores que NUNCA cabem (o container tem 4
438:     * filhos), e transcreve-los ao pe da letra jogaria o botao de pasta para o
439:     * FIM do ciclo quando o legado o poe em SEGUNDO: fiel ao ARQUIVO e infiel a
440:     * TELA. No CntTXT o SCX repete o valor 1 em Say1 e lblResults, e a
441:     * duplicata faz lblResults ganhar a posicao 1 e empurrar Say1 para 2.
442:     *
443:     * Medido no VFP9 em 2026-11-05 (automation\simtab738.prg): o load foi
444:     * simulado recriando os objetos na ordem dos REGISTROS do .scx (lidos como
445:     * DBF por automation\dump738_scx.prg) e aplicando o TabIndex gravado logo
446:     * apos cada AddObject; os valores abaixo sao o que se leu de volta.
447:     *
448:     *   FILHOS DA FORM    cnt_4c_Sombra 1 / cnt_4c_TXT 2 / cmd_4c_Cancela 3 /
449:     *                     cmd_4c_Processa 4 / chk_4c_ChkXml 5 / cnt_4c_Xml 6
450:     *   cnt_4c_TXT        lbl_4c_LblResults 1 / lbl_4c_Label1 2 /
451:     *                     txt_4c_ArqTXT 3 / cmd_4c_BtnGetArqO 4 /
452:     *                     chk_4c_ChkImagens 5
453:     *   cnt_4c_Xml        txt_4c_Arquivo 1 / cmd_4c_BtnDirs 2 /
454:     *                     txt_4c_Dirs 3 / lbl_4c_LabelArquivo 4
455:     *
456:     * TabIndex eh escopado por PAI, por isso as tres sequencias recomecam em 1.
457:     * Atribuicao em ordem ASCENDENTE dentro de cada pai: descendente TROCA os
458:     * controles de lugar (medido). Nos dois paineis a ordem relativa dos
459:     * FOCALIZAVEIS ja coincidia com a ordem de criacao, entao o passe eh hoje
460:     * um no-op de comportamento - fica como documentacao da ordem do legado e
461:     * como guarda para quando alguem reordenar os AddObject.
462:     *
463:     * shp_4c_Shape1 e shp_4c_Shape2 ficam de FORA: Shape nao tem TabIndex
464:     * (medido - PEMSTATUS devolve .F.) e atribuir estouraria "Property TABINDEX
465:     * is not found". Os dois labels de cnt_4c_Sombra tambem ficam de fora - o
466:     * SCX nao lhes da TabIndex e Label nao tem TabStop (nao recebe foco).
467:     *
468:     * Fora do ciclo do Tab de proposito: txt_4c_ArqTXT e txt_4c_Dirs levam
469:     * ReadOnly = .T. + TabStop = .F., transcricao do "When -> Return .f." do
470:     * legado (no Framework Fortyus o When em .F. impede o FOCO, nao so a
471:     * edicao). Eles recebem TabIndex para a sequencia nao abrir lacuna, mas o
472:     * TabStop = .F. os mantem fora da navegacao.
473:     *
474:     * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de FORA
475:     * da classe, e PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo em metodo
476:     * PROTECTED - o teste entraria no branch e a chamada real falharia em
477:     * runtime com "Property CONFIGURARORDEMTABULACAO is not found" (regra #3).
478:     *==========================================================================
479:     PROCEDURE ConfigurarOrdemTabulacao()
480:         *-- Filhos diretos da Form (o SCX nao declara TabIndex em nenhum deles:
481:         *-- a ordem efetiva eh a de criacao dos REGISTROS do .scx).
482:         THIS.cnt_4c_Sombra.TabIndex   = 1
483:         THIS.cnt_4c_TXT.TabIndex      = 2
484:         THIS.cmd_4c_Cancela.TabIndex  = 3
485:         THIS.cmd_4c_Processa.TabIndex = 4
486:         THIS.chk_4c_ChkXml.TabIndex   = 5
487:         THIS.cnt_4c_Xml.TabIndex      = 6
488: 
489:         *-- Painel TXT. SCX: Say1 = 1, getArqTXT = 2, btnGetArqO = 3,
490:         *-- chkImagens = 4, lblResults = 1 (DUPLICADO com Say1).
491:         THIS.cnt_4c_TXT.lbl_4c_LblResults.TabIndex = 1
492:         THIS.cnt_4c_TXT.lbl_4c_Label1.TabIndex     = 2
493:         THIS.cnt_4c_TXT.txt_4c_ArqTXT.TabIndex     = 3
494:         THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO.TabIndex = 4
495:         THIS.cnt_4c_TXT.chk_4c_ChkImagens.TabIndex = 5
496: 
497:         *-- Painel XML. SCX: btnDirs = 15, Get_arquivo = 1, getDirs = 14,
498:         *-- Say1 = 13 - so o 1 de Get_arquivo cabe e sobrevive ao load.
499:         THIS.cnt_4c_Xml.txt_4c_Arquivo.TabIndex      = 1
500:         THIS.cnt_4c_Xml.cmd_4c_BtnDirs.TabIndex      = 2
501:         THIS.cnt_4c_Xml.txt_4c_Dirs.TabIndex         = 3
502:         THIS.cnt_4c_Xml.lbl_4c_LabelArquivo.TabIndex = 4
503:     ENDPROC
504: 
505:     *==========================================================================
506:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
507:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
508:     * efeito de sombra: lblSombra em preto (Top = 25) sob lblTitulo em
509:     * branco (Top = 24). Width/Height/Font/ForeColor transcritos do dump
510:     * (secao "PROPRIEDADES DE: SIGOPGAR.cntSombra" e dos dois labels
511:     * filhos).
512:     *
513:     * Os dois labels declaram WordWrap = .T. e Width/Height explicitos no
514:     * SCX, entao AutoSize fica .F.: em Label criado por AddObject o AutoSize
515:     * eh no-op para a largura e, com WordWrap, DESCARTA a Height (regra
516:     * CLAUDE.md #23) - os numeros do dump ja sao o auto-size calculado pelo
517:     * Form Designer, logo fixa-los eh reproducao fiel.
518:     *
519:     * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
520:     * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
521:     * do Init legado - o texto "Cadastro de Testes" do dump e' so o default
522:     * generico do Form Designer, sobrescrito em runtime pelo proprio legado.
523:     *==========================================================================
524:     PROTECTED PROCEDURE ConfigurarCabecalho()
525:         LOCAL loc_oCab
526: 
527:         THIS.AddObject("cnt_4c_Sombra", "Container")
528:         loc_oCab = THIS.cnt_4c_Sombra
529:         WITH loc_oCab
530:             .Top         = 0
531:             .Left        = 0
532:             .Width       = THIS.Width
533:             .Height      = 80
534:             .BackStyle   = 1
535:             .BackColor   = RGB(100, 100, 100)
536:             .BorderWidth = 0
537:             .Visible     = .T.
538:         ENDWITH
539: 
540:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
541:         WITH loc_oCab.lbl_4c_LblSombra
542:             .AutoSize  = .F.
543:             .Top       = 25
544:             .Left      = 10
545:             .Width     = 769
546:             .Height    = 40
547:             .FontName  = "Tahoma"
548:             .FontSize  = 18
549:             .FontBold  = .T.
550:             .WordWrap  = .T.
551:             .Alignment = 0
552:             .BackStyle = 0
553:             .ForeColor = RGB(0, 0, 0)
554:             .Caption   = THIS.Caption
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
559:         WITH loc_oCab.lbl_4c_LblTitulo
560:             .AutoSize  = .F.
561:             .Top       = 24
562:             .Left      = 10
563:             .Width     = 769
564:             .Height    = 46

*-- Linhas 583 a 637:
583:     * getArqTXT.ReadOnly = .T. transcreve o "getArqTXT.When -> Return .f."
584:     * do dump (comportamento.json) - o campo so recebe valor pelo picker de
585:     * btnGetArqO, nunca por digitacao direta (mesma armadilha da regra
586:     * CLAUDE.md #3/#34: BINDEVENT em "When" descartaria o retorno do
587:     * delegate e o campo continuaria digitavel - por isso ReadOnly direto,
588:     * nao BINDEVENT).
589:     *
590:     * Say1 (classe "say" sem Width/Alignment no dump) e chkImagens (classe
591:     * "fwcheckbox") repetem a armadilha de AutoSize no-op da regra #23/#33 -
592:     * AutoSize = .F. + Width explicito. Shape2 eh a moldura do resultado
593:     * (lblResults, label de progresso atualizado por
594:     * sigopgarBO.AtualizarProgresso via THIS.AtualizarProgresso - ver
595:     * abaixo).
596:     *==========================================================================
597:     PROTECTED PROCEDURE ConfigurarPainelTxt()
598:         LOCAL loc_oTxt
599: 
600:         THIS.AddObject("cnt_4c_TXT", "Container")
601:         loc_oTxt = THIS.cnt_4c_TXT
602:         WITH loc_oTxt
603:             .Top       = 155
604:             .Left      = 102
605:             .Width     = 595
606:             .Height    = 127
607:             .BackStyle = 0
608:             .Visible   = .T.
609:         ENDWITH
610: 
611:         loc_oTxt.AddObject("lbl_4c_Label1", "Label")
612:         WITH loc_oTxt.lbl_4c_Label1
613:             .Top       = 6
614:             .Left      = 11
615:             .Width     = 170
616:             .Height    = 15
617:             .AutoSize  = .F.
618:             .Alignment = 0
619:             .BackStyle = 0
620:             .FontBold  = .T.
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8
623:             .ForeColor = RGB(90, 90, 90)
624:             .Caption   = "Arquivo a Ser Gerado"
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         loc_oTxt.AddObject("txt_4c_ArqTXT", "TextBox")
629:         WITH loc_oTxt.txt_4c_ArqTXT
630:             .Top           = 23
631:             .Left          = 11
632:             .Width         = 540
633:             .Height        = 22
634:             .FontName      = "Tahoma"
635:             .FontSize      = 8
636:             .SpecialEffect = 1
637:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 742 a 785:
742:     * "\<Processar" preserva o marcador de tecla de acesso (Alt+P) do VFP9 -
743:     * sintaxe nativa, nao removida na migracao.
744:     *==========================================================================
745:     PROTECTED PROCEDURE ConfigurarBotoes()
746:         THIS.AddObject("shp_4c_Shape1", "Shape")
747:         WITH THIS.shp_4c_Shape1
748:             .Top           = 7
749:             .Left          = 615
750:             .Width         = 173
751:             .Height        = 110
752:             .BackStyle     = 0
753:             .BorderStyle   = 0
754:             .SpecialEffect = 1
755:             .BorderColor   = RGB(136, 189, 188)
756:             .Visible       = .T.
757:         ENDWITH
758: 
759:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
760:         WITH THIS.cmd_4c_Cancela
761:             .Top          = 3
762:             .Left         = 724
763:             .Height       = 100
764:             .Width        = 80
765:             .Cancel       = .T.
766:             .Caption      = "Encerrar"
767:             .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
768:             .FontBold     = .T.
769:             .FontItalic   = .T.
770:             .FontName     = "Comic Sans MS"
771:             .FontSize     = 8
772:             .WordWrap     = .T.
773:             .MousePointer = 15
774:             .ForeColor    = RGB(90, 90, 90)
775:             .BackColor    = RGB(255, 255, 255)
776:             .Themes       = .T.
777:             .Visible      = .T.
778:         ENDWITH
779: 
780:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
781:         WITH THIS.cmd_4c_Processa
782:             .Top          = 3
783:             .Left         = 649
784:             .Height       = 100
785:             .Width        = 80

*-- Linhas 807 a 890:
807:     * de label de dados do projeto (CLAUDE.md regra #12) por nao haver
808:     * override proprio.
809:     *==========================================================================
810:     PROTECTED PROCEDURE ConfigurarChkXml()
811:         THIS.AddObject("chk_4c_ChkXml", "CheckBox")
812:         WITH THIS.chk_4c_ChkXml
813:             *-- AutoSize = .F. pelo mesmo motivo de chk_4c_ChkImagens (no-op em
814:             *-- AddObject) - aqui o dump JA traz Width/Height explicitos.
815:             *-- FontBold NAO entra: o dump de chkXml nao o declara e a classe eh
816:             *-- "checkbox" PURA (default .F.) - diferente de chkImagens, que eh
817:             *-- "fwcheckbox" e cujo dump declara FontBold = .T. Marcar negrito
818:             *-- aqui engrossaria uma legenda que o legado desenha fina.
819:             .AutoSize  = .F.
820:             .Top       = 90
821:             .Left      = 108
822:             .Width     = 152
823:             .Height    = 15
824:             .FontBold  = .F.
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .Alignment = 0
828:             .BackStyle = 0
829:             .ForeColor = RGB(90, 90, 90)
830:             .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivo em XML"
831:             .Value     = 0
832:             .Visible   = .T.
833:         ENDWITH
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * ConfigurarPainelXml - painel de geracao do arquivo XML (CntXml no
838:     * legado -> cnt_4c_Xml), OCULTO por default (Init legado: "Thisform.
839:     * cntXml.visible = .F."). Fica SEM atribuir .Visible aqui (AddObject ja
840:     * cria Visible = .F.) - o toggle real eh feito por ChkXmlClick(), e
841:     * TornarControlesVisiveis() foi ajustado para NAO sobrescrever este
842:     * container com .T. (continua recursando nos filhos dele).
843:     *
844:     * Get_arquivo (txt_4c_Arquivo) eh classe "fwget" com Format = "K!" no
845:     * legado - transcrito aqui porque eh so um CODIGO informativo
846:     * (this_cCodArquivo no BO, char(20)); getDirs (txt_4c_Dirs) eh o campo
847:     * do CAMINHO completo, ReadOnly = .T. pelo mesmo motivo de getArqTXT
848:     * (getDirs.When -> Return .f. no dump).
849:     *==========================================================================
850:     PROTECTED PROCEDURE ConfigurarPainelXml()
851:         LOCAL loc_oXml
852: 
853:         THIS.AddObject("cnt_4c_Xml", "Container")
854:         loc_oXml = THIS.cnt_4c_Xml
855:         WITH loc_oXml
856:             .Top       = 109
857:             .Left      = 102
858:             .Width     = 595
859:             .Height    = 47
860:             .BackStyle = 0
861:         ENDWITH
862: 
863:         loc_oXml.AddObject("lbl_4c_LabelArquivo", "Label")
864:         WITH loc_oXml.lbl_4c_LabelArquivo
865:             .Top        = 15
866:             .Left       = 30
867:             .Width      = 45
868:             .Height     = 15
869:             .AutoSize   = .F.
870:             .Alignment  = 0
871:             .BackStyle  = 0
872:             *-- FontBold = .F.: o dump de CntXml.Say1 declara FontItalic/
873:             *-- FontName/FontSize/ForeColor e NAO declara FontBold, e a classe
874:             *-- "say" tambem nao (default .F. - ver
875:             *-- docs/FRAMEWORK_class_codigo_fonte.txt). Nao confundir com
876:             *-- CntTXT.Say1, cujo dump DECLARA FontBold = .T.
877:             .FontBold   = .F.
878:             .FontItalic = .F.
879:             .FontName   = "Tahoma"
880:             .FontSize   = 8
881:             .ForeColor  = RGB(90, 90, 90)
882:             .Caption    = "Arquivo :"
883:             .Visible    = .T.
884:         ENDWITH
885: 
886:         *-- CAMPO APOSENTADO E SOTERRADO no proprio legado (regra #28).
887:         *-- Get_arquivo e getDirs tem o MESMO Top (11) e o MESMO Left (78) no
888:         *-- SCX, e o segundo eh quase tres vezes mais largo: medido no VFP9 em
889:         *-- 2026-11-05 (automation\probe738f6.prg), txt_4c_Arquivo ocupa
890:         *-- 78..228 x 11..34 e txt_4c_Dirs ocupa 78..499 x 11..34 - o primeiro

*-- Linhas 902 a 945:
902:         *-- ficam IDENTICAS ao SCX: mexer nelas para "desenterrar" o campo
903:         *-- mostraria na tela algo que o legado nunca mostrou (PILAR 1), e
904:         *-- esconder com Visible = .F. exigiria mais uma excecao em
905:         *-- TornarControlesVisiveis() sem mudar nada para o usuario - ele ja
906:         *-- eh inalcancavel. Consequencia a conhecer: this_cCodArquivo chega
907:         *-- SEMPRE vazio ao BO (o usuario nao tem onde digitar), e por isso
908:         *-- nenhum metodo de sigopgarBO o consome - exatamente como no legado.
909:         loc_oXml.AddObject("txt_4c_Arquivo", "TextBox")
910:         WITH loc_oXml.txt_4c_Arquivo
911:             .Top       = 11
912:             .Left      = 78
913:             .Width     = 150
914:             *-- Height = 23 (NAO 22): o dump de Get_arquivo nao declara Height,
915:             *-- entao vale o default da classe "fwget", que eh 23. SpecialEffect
916:             *-- e BorderColor NAO entram - nem o dump nem a fwget os declaram
917:             *-- (sao do IRMAO getArqTXT, textbox PURA, cujo dump declara os
918:             *-- dois); inventa-los mudaria a moldura do campo.
919:             .Height    = 23
920:             .FontName  = "Tahoma"
921:             .FontSize  = 8
922:             .ForeColor = RGB(0, 0, 0)
923:             .Themes    = .F.
924:             .Format    = "K!"
925:             .MaxLength = 20
926:             .Value     = ""
927:             .Visible   = .T.
928:         ENDWITH
929: 
930:         loc_oXml.AddObject("txt_4c_Dirs", "TextBox")
931:         WITH loc_oXml.txt_4c_Dirs
932:             .Top           = 11
933:             .Left          = 78
934:             .Width         = 421
935:             .Height        = 23
936:             .FontName      = "Tahoma"
937:             .FontSize      = 8
938:             .SpecialEffect = 1
939:             .ForeColor     = RGB(0, 0, 0)
940:             .Themes        = .F.
941:             *-- BorderColor NAO entra: nao esta no dump de getDirs nem na classe
942:             *-- "fwget" (vinha copiada do irmao getArqTXT).
943:             *-- ZOrderSet = 4 do dump fica DE FORA de proposito - eh property so
944:             *-- do Form Designer, nao existe em runtime (regra #33).
945:             .ReadOnly      = .T.

*-- Linhas 986 a 1125:
986:     ENDPROC
987: 
988:     *==========================================================================
989:     * TornarControlesVisiveis - AddObject cria todo controle com
990:     * Visible = .F.; este metodo percorre a arvore e os exibe. EXCECAO:
991:     * cnt_4c_Xml (painel XML) nasce Visible = .F. de proposito (Init
992:     * legado: "Thisform.cntXml.visible = .F.") e so eh mostrado por
993:     * ChkXmlClick() quando o usuario marca chk_4c_ChkXml - por isso este
994:     * metodo PULA a atribuicao de .Visible no proprio container, mas
995:     * continua RECURSANDO nos filhos dele (regra do CorretorAutomatico
996:     * #109: pular so o container e nao recursar deixaria os filhos
997:     * Visible = .F. para sempre, e o painel apareceria vazio quando
998:     * alternado para visivel).
999:     *==========================================================================
1000:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1001:         LOCAL loc_i, loc_oControl
1002: 
1003:         FOR loc_i = 1 TO par_oContainer.ControlCount
1004:             loc_oControl = par_oContainer.Controls(loc_i)
1005:             IF VARTYPE(loc_oControl) = "O"
1006:                 IF UPPER(loc_oControl.Name) = "CNT_4C_XML"
1007:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1008:                         THIS.TornarControlesVisiveis(loc_oControl)
1009:                     ENDIF
1010:                     LOOP
1011:                 ENDIF
1012:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1013:                     loc_oControl.Visible = .T.
1014:                 ENDIF
1015:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1016:                     THIS.TornarControlesVisiveis(loc_oControl)
1017:                 ENDIF
1018:             ENDIF
1019:         ENDFOR
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * FASE 8 - LimparCampos: zera os TRES campos de caminho/codigo de arquivo
1024:     * dos dois paineis. Transcricao do bloco que o legado repete IDENTICO em
1025:     * DOIS lugares - no Init ("Thisform.cntXml.getDirs.Value = [] / Thisform.
1026:     * cntXml.Get_arquivo.Value = [] / Thisform.cntTxt.getArqTXT.Value = []") e
1027:     * nas tres primeiras linhas de chkXml.Valid, letra por letra iguais.
1028:     *
1029:     * Eh justamente por serem DUAS copias no legado que o metodo existe: ate a
1030:     * Fase 7 as tres atribuicoes moravam INLINE em ChkXmlClick, e o caminho de
1031:     * ABERTURA da tela nao as tinha - duas copias da mesma regra divergiriam no
1032:     * primeiro campo novo (CLAUDE.md #44, item 6).
1033:     *
1034:     * Zera TAMBEM as tres properties correspondentes do BO, nao so os
1035:     * controles: BOParaForm (abaixo) espelha BO -> tela, entao limpar so a tela
1036:     * deixaria o BO com o caminho velho e o proximo espelhamento o TRARIA DE
1037:     * VOLTA ao campo que o usuario acabou de ver limpo. O legado nao corria
1038:     * esse risco porque nao havia BO - o controle era a unica copia do valor.
1039:     *
1040:     * PROTECTED EXPLICITO - nao eh estilo, eh o escopo REAL: FormBase declara
1041:     * "PROTECTED PROCEDURE LimparCampos" e o VFP9 NAO deixa a subclasse ALARGAR
1042:     * escopo herdado (regra #51). Por isso eh chamado so por THIS., de dentro
1043:     * da classe (regra #8) - nunca de fora, nem pelo harness.
1044:     *==========================================================================
1045:     PROTECTED FUNCTION LimparCampos()
1046:         LOCAL loc_lSucesso
1047:         loc_lSucesso = .F.
1048: 
1049:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1050:             THIS.this_oBusinessObject.this_cArquivoTxt = ""
1051:             THIS.this_oBusinessObject.this_cArquivoXml = ""
1052:             THIS.this_oBusinessObject.this_cCodArquivo = ""
1053:         ENDIF
1054: 
1055:         IF VARTYPE(THIS.cnt_4c_TXT) = "O" AND VARTYPE(THIS.cnt_4c_Xml) = "O"
1056:             THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value  = ""
1057:             THIS.cnt_4c_Xml.txt_4c_Dirs.Value    = ""
1058:             THIS.cnt_4c_Xml.txt_4c_Arquivo.Value = ""
1059:             loc_lSucesso = .T.
1060:         ENDIF
1061: 
1062:         RETURN loc_lSucesso
1063:     ENDFUNC
1064: 
1065:     *==========================================================================
1066:     * FASE 8 - AplicarPainelPorModo: alterna qual dos dois paineis fica
1067:     * visivel, conforme chk_4c_ChkXml (1 = XML, 0 = TXT). Segundo bloco que o
1068:     * legado repete nos MESMOS dois lugares de LimparCampos: o IF de
1069:     * chkXml.Valid e as duas linhas finais do Init ("Thisform.cntXml.visible =
1070:     * .F. / Thisform.cntTXT.visible = .T.", que sao exatamente este estado com
1071:     * chkXml.Value = 0).
1072:     *
1073:     * Le o CHECKBOX, nao uma copia do modo: o controle eh a fonte unica do que
1074:     * o usuario escolheu (mesmo criterio do campo de filtro da regra #35b) -
1075:     * guardar o modo numa property e consultar ela aqui criaria a segunda copia
1076:     * que este metodo existe para evitar.
1077:     *
1078:     * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de FORA
1079:     * da classe, e PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo em metodo
1080:     * PROTECTED - o teste entraria no branch e a chamada real falharia em
1081:     * runtime com "Property APLICARPAINELPORMODO is not found" (regra #3).
1082:     * Chamar de fora eh seguro: o metodo so LE o checkbox e escreve .Visible,
1083:     * logo eh idempotente.
1084:     *==========================================================================
1085:     PROCEDURE AplicarPainelPorModo()
1086:         IF VARTYPE(THIS.chk_4c_ChkXml) != "O" OR ;
1087:            VARTYPE(THIS.cnt_4c_TXT) != "O" OR ;
1088:            VARTYPE(THIS.cnt_4c_Xml) != "O"
1089:             RETURN .F.
1090:         ENDIF
1091: 
1092:         IF THIS.chk_4c_ChkXml.Value = 1
1093:             THIS.cnt_4c_Xml.Visible = .T.
1094:             THIS.cnt_4c_TXT.Visible = .F.
1095:         ELSE
1096:             THIS.cnt_4c_Xml.Visible = .F.
1097:             THIS.cnt_4c_TXT.Visible = .T.
1098:         ENDIF
1099: 
1100:         RETURN .T.
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * FASE 8 - FormParaBO: Tela -> BO. Transfere os CINCO controles de ENTRADA
1105:     * do dialogo para as properties que sigopgarBO.GerarArquivo() consome. Ate
1106:     * a Fase 7 essa leitura morava INLINE em BtnProcessarClickExec; trazida
1107:     * para o hook canonico de FormBase para ficar FONTE UNICA - um segundo
1108:     * caminho que precisasse dos mesmos valores releria o controle em vez de
1109:     * confiar numa copia que ja pode ter ficado velha (CLAUDE.md #44, item 6).
1110:     *
1111:     * "TODOS os campos" (cobranca da Fase 8) esta satisfeito por construcao: o
1112:     * dump tem exatamente TRES TextBox e DOIS CheckBox, e os cinco aparecem
1113:     * aqui. Os dois TextBox de caminho (txt_4c_ArqTXT e txt_4c_Dirs) sao
1114:     * ReadOnly = .T. - o valor so chega pelo picker do botao de pasta vizinho -
1115:     * e txt_4c_Arquivo eh o campo soterrado documentado em
1116:     * ConfigurarPainelXml(), que por isso chega SEMPRE vazio ao BO. Os tres sao
1117:     * lidos de qualquer forma: decidir quais campos consumir eh do BO, nao
1118:     * deste hook, e omitir um aqui esconderia a informacao de quem reler o par.
1119:     *
1120:     * PROTECTED EXPLICITO pelo MESMO motivo de LimparCampos, acima (regra #51).
1121:     *==========================================================================
1122:     PROTECTED FUNCTION FormParaBO()
1123:         LOCAL loc_lSucesso
1124:         loc_lSucesso = .F.
1125: 

*-- Linhas 1195 a 1473:
1195:     * (chkXml.Value = 0 -> cntXml invisivel, cntTXT visivel). As duas metades
1196:     * ja sao os funis acima, entao este metodo nao repete regra nenhuma - ele
1197:     * so nomeia a sequencia e lhe da um unico ponto de chamada, usado por
1198:     * InicializarForm().
1199:     *
1200:     * Idempotente de proposito: chamar de novo reconstroi o MESMO estado, sem
1201:     * efeito colateral e sem tocar o banco - o harness de teste alcanca este
1202:     * metodo de fora da classe e precisa poder reaciona-lo. Por isso tambem eh
1203:     * PUBLIC (regra #3: PEMSTATUS nao distingue escopo, e um PROTECTED aqui
1204:     * passaria o teste e falharia em runtime).
1205:     *
1206:     * O nome NAO reclassifica o form no pipeline, conferido em
1207:     * TesteAutomatico.prg: a deteccao automatica que chamaria este form de CRUD
1208:     * por achar o metodo (o IF que exige a AUSENCIA dele e da troca de pagina)
1209:     * so roda quando NAO vem hint do pipeline, e o orquestrador passa o
1210:     * FormType do task_state.json - aqui OPERACIONAL -, que entra antes dela.
1211:     *==========================================================================
1212:     PROCEDURE CarregarLista()
1213:         LOCAL loc_lSucesso
1214: 
1215:         loc_lSucesso = THIS.LimparCampos()
1216: 
1217:         IF !THIS.BOParaForm()
1218:             loc_lSucesso = .F.
1219:         ENDIF
1220: 
1221:         RETURN loc_lSucesso
1222:     ENDPROC
1223: 
1224:     *==========================================================================
1225:     * BtnProcessarClick - equivale a SIGOPGAR.Processa.Click -> ThisForm.
1226:     * Processamento. PUBLIC porque BINDEVENT exige metodo publico (regra
1227:     * #3). Guarda de reentrancia (this_lProcessando) pelo mesmo motivo
1228:     * documentado em Formsigopecm.prg: sigopgarBO.AtualizarProgresso chama
1229:     * DOEVENTS a cada grupo/produto, o que despacha a fila de eventos do
1230:     * Windows e permite reacionar o botao durante uma geracao em curso.
1231:     *
1232:     * O corpo fica em BtnProcessarClickExec() para a liberacao da flag no
1233:     * FINALLY sobreviver ao RETURN antecipado de "usuario cancelou o
1234:     * MsgConfirma" (regra #47) - e para o Release() (abaixo) so acontecer
1235:     * DEPOIS que a flag ja foi liberada, nunca enquanto o TRY/FINALLY ainda
1236:     * esta no ar.
1237:     *==========================================================================
1238:     PROCEDURE BtnProcessarClick()
1239:         LOCAL loc_oErro, loc_lConfirmou
1240:         loc_lConfirmou = .F.
1241: 
1242:         IF THIS.this_lProcessando
1243:             RETURN
1244:         ENDIF
1245: 
1246:         THIS.this_lProcessando = .T.
1247: 
1248:         TRY
1249:             loc_lConfirmou = THIS.BtnProcessarClickExec()
1250:         CATCH TO loc_oErro
1251:             MsgErro(loc_oErro.Message + CHR(13) + ;
1252:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1253:                 "Procedure: " + loc_oErro.Procedure, ;
1254:                 "Erro em BtnProcessarClick")
1255:         FINALLY
1256:             THIS.this_lProcessando = .F.
1257:         ENDTRY
1258: 
1259:         *-- Transcricao literal do legado (Processa.Click: "Thisform.
1260:         *-- Processamento() / Thisform.Release", SEM condicionar ao
1261:         *-- resultado) - o dialogo fecha sempre que o usuario CONFIRMOU a
1262:         *-- geracao, mesmo quando ela falha (o aviso de erro ja foi
1263:         *-- exibido dentro do Exec, acima). So NAO fecha quando o usuario
1264:         *-- desistiu no MsgConfirma.
1265:         IF loc_lConfirmou
1266:             THIS.Release()
1267:         ENDIF
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * BtnProcessarClickExec - corpo real do Processar. Passa os campos dos
1272:     * dois paineis ao BO pelo hook FormParaBO() (Fase 8 - antes disso a
1273:     * leitura dos cinco controles morava INLINE aqui) e despacha
1274:     * sigopgarBO.GerarArquivo(), que ja escolhe entre GerarArquivoXml()/
1275:     * GerarArquivoTxt() por this_lGeraXml.
1276:     *
1277:     * Retorno: .T. se o usuario CONFIRMOU a geracao (independente do
1278:     * resultado dela) - usado por BtnProcessarClick para decidir se fecha o
1279:     * dialogo; .F. se desistiu no MsgConfirma (dialogo continua aberto).
1280:     *
1281:     * Ha um TERCEIRO retorno .F., sem contraparte no legado: FormParaBO()
1282:     * recusando a leitura da tela. Nao pode acontecer em uso normal (os
1283:     * cinco controles nascem em InicializarForm, sem o qual o form nao
1284:     * existe), e o dialogo fica ABERTO de proposito - com os valores nao
1285:     * lidos, gerar o arquivo escreveria conteudo errado em silencio, e
1286:     * fechar depois do aviso tiraria do usuario a chance de repetir.
1287:     *
1288:     * Contrato de erro do BO (ver cabecalho de GerarArquivoXml/
1289:     * GerarArquivoTxt): falha de validacao preenche this_cMensagemErro SEM
1290:     * MsgErro previo - este handler exibe com MsgAviso (regra #20: a falha
1291:     * de SQL o proprio BO ja exibe, nao repetir). Sucesso do ramo XML ja
1292:     * mostra o proprio MsgInfo dentro de GerarArquivoXml - este handler so
1293:     * complementa a mensagem final do ramo TXT, que o BO deixa em
1294:     * this_cMensagemProgresso sem exibir.
1295:     *==========================================================================
1296:     PROCEDURE BtnProcessarClickExec()
1297:         IF !MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?", ;
1298:                 "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
1299:             RETURN .F.
1300:         ENDIF
1301: 
1302:         *-- Fase 8: a leitura dos cinco controles de entrada passou a
1303:         *-- morar em FormParaBO() - FONTE UNICA (ver a nota la).
1304:         IF !THIS.FormParaBO()
1305:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os dados da tela.", ;
1306:                 "Erro em BtnProcessarClickExec")
1307:             RETURN .F.
1308:         ENDIF
1309: 
1310:         IF THIS.this_oBusinessObject.GerarArquivo()
1311:             IF !THIS.this_oBusinessObject.this_lGeraXml AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemProgresso)
1312:                 IF THIS.this_oBusinessObject.this_nQtdProdutos > 0
1313:                     MsgInfo(THIS.this_oBusinessObject.this_cMensagemProgresso, "Processamento Finalizado")
1314:                 ELSE
1315:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemProgresso, "Processamento Finalizado")
1316:                 ENDIF
1317:             ENDIF
1318:         ELSE
1319:             IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1320:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o!!!")
1321:             ENDIF
1322:         ENDIF
1323: 
1324:         RETURN .T.
1325:     ENDPROC
1326: 
1327:     *==========================================================================
1328:     * BtnCancelarClick - equivale a SIGOPGAR.Cancela.Click -> ThisForm.
1329:     * Release. O dialogo nao devolve resultado nenhum ao form chamador (so
1330:     * gera o arquivo em disco, igual ao irmao Formsigopecm), entao
1331:     * Release() eh fiel ao legado. PUBLIC pelo mesmo motivo de
1332:     * BtnProcessarClick.
1333:     *
1334:     * Fase 8: renomeado - o handler era batizado pelo CAPTION do botao e
1335:     * agora segue o OBJETO, como nos outros oito sites do projeto que ligam
1336:     * um cmd_4c_Cancela. O objeto do legado chama-se "Cancela" e declara
1337:     * Cancel = .T. (a tecla ESC o aciona), entao "cancelar" descreve o papel
1338:     * dele melhor do que o Caption, que o dump traz como "Encerrar" e que
1339:     * segue transcrito tal e qual em ConfigurarBotoes(). O canonico
1340:     * cmd_4c_Encerrar da CLAUDE.md #10 eh do bloco de saida dos forms CRUD -
1341:     * nao deste dialogo, cujo botao tem nome proprio no SCX.
1342:     *==========================================================================
1343:     PROCEDURE BtnCancelarClick()
1344:         THIS.Release()
1345:     ENDPROC
1346: 
1347:     *==========================================================================
1348:     * BtnGetArqOClick - equivale a SIGOPGAR.CntTXT.btnGetArqO.Click: abre o
1349:     * picker nativo GETFILE() e, se o usuario nao cancelar, grava o caminho
1350:     * escolhido em cnt_4c_TXT.txt_4c_ArqTXT.Value (transcricao literal do
1351:     * "GetFile([TXT], [Arquivo TXT:], [Criar], 0, [Informe o Nome do
1352:     * Arquivo TXT])" do legado - nenhum dos literais tem acento).
1353:     *==========================================================================
1354:     PROCEDURE BtnGetArqOClick()
1355:         LOCAL loc_cArquivo
1356: 
1357:         loc_cArquivo = GETFILE("TXT", "Arquivo TXT:", "Criar", 0, "Informe o Nome do Arquivo TXT")
1358: 
1359:         IF !EMPTY(loc_cArquivo)
1360:             THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value = ALLTRIM(loc_cArquivo)
1361:         ENDIF
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * BtnDirsClick - equivale a SIGOPGAR.CntXml.btnDirs.Click: abre o
1366:     * picker nativo PUTFILE() (o legado comenta um GetDir() de diretorio e
1367:     * usa PUTFILE() de fato - transcricao do que o dump executa, nao do
1368:     * que esta comentado) e grava o caminho escolhido em
1369:     * cnt_4c_Xml.txt_4c_Dirs.Value. A leitura inicial de getDirs.Value no
1370:     * dump ("lcDir = Alltrim(ThisForm.cntXml.getDirs.Value)") eh codigo
1371:     * morto - PUTFILE nao recebe esse valor como parametro e o sobrescreve
1372:     * de imediato - por isso nao reproduzida aqui.
1373:     *==========================================================================
1374:     PROCEDURE BtnDirsClick()
1375:         LOCAL loc_cDir
1376: 
1377:         loc_cDir = PUTFILE("", "", "XML")
1378: 
1379:         IF !EMPTY(loc_cDir)
1380:             THIS.cnt_4c_Xml.txt_4c_Dirs.Value = ALLTRIM(loc_cDir)
1381:         ENDIF
1382:     ENDPROC
1383: 
1384:     *==========================================================================
1385:     * ChkXmlClick - equivale a SIGOPGAR.chkXml.Valid: limpa os tres campos
1386:     * de arquivo/diretorio dos dois paineis e alterna qual painel fica
1387:     * visivel, conforme o Value do checkbox (1 = XML, 0 = TXT). Ligado em
1388:     * "Click" (nao em "Valid" - BINDEVENT em TextBox/CheckBox "Valid" nao
1389:     * dispara de forma confiavel, regra CLAUDE.md #3/#46); no CheckBox,
1390:     * Click dispara DEPOIS do toggle de .Value, entao ler THIS.chk_4c_
1391:     * ChkXml.Value aqui ja reflete a escolha do usuario, igual ao This.
1392:     * Value do Valid legado.
1393:     *==========================================================================
1394:     PROCEDURE ChkXmlClick()
1395:         *-- Fase 8: as duas metades sao os funis compartilhados com o
1396:         *-- caminho de abertura da tela (CarregarLista) - o legado escreve
1397:         *-- as MESMAS linhas aqui e no Init.
1398:         THIS.LimparCampos()
1399:         THIS.AplicarPainelPorModo()
1400: 
1401:         THIS.chk_4c_ChkXml.Refresh()
1402:     ENDPROC
1403: 
1404:     *==========================================================================
1405:     * AtualizarProgresso - contrato com sigopgarBO.AtualizarProgresso, que
1406:     * chama este metodo a cada grupo/produto processado (equivale ao
1407:     * "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan de
1408:     * ProcessaTxt no legado). PUBLIC porque quem chama eh o BO, de fora da
1409:     * classe.
1410:     *
1411:     * O texto eh sempre guardado em this_cUltimoProgresso e so entao
1412:     * exibido, se o label de resultado do painel TXT ja existir - assim o
1413:     * progresso reportado antes de o painel entrar em cena nao se perde
1414:     * (mesmo padrao de Formsigopecm.AtualizarProgresso).
1415:     *==========================================================================
1416:     PROCEDURE AtualizarProgresso(par_cTexto)
1417:         LOCAL loc_cTexto
1418: 
1419:         loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
1420:         THIS.this_cUltimoProgresso = loc_cTexto
1421: 
1422:         IF PEMSTATUS(THIS, "cnt_4c_TXT", 5) AND PEMSTATUS(THIS.cnt_4c_TXT, "lbl_4c_LblResults", 5)
1423:             THIS.cnt_4c_TXT.lbl_4c_LblResults.Caption = loc_cTexto
1424:             THIS.cnt_4c_TXT.lbl_4c_LblResults.Refresh()
1425:             DOEVENTS
1426:         ENDIF
1427:     ENDPROC
1428: 
1429:     *==========================================================================
1430:     * Destroy - libera o Business Object e os cursores auxiliares que
1431:     * sigopgarBO.GerarArquivoXml/GerarArquivoTxt abrem durante a geracao,
1432:     * cobrindo o caso de a tela ser fechada no meio do processamento.
1433:     * DODEFAULT() por ULTIMO, para FormBase.Destroy reconstruir os popups do
1434:     * menu principal (regra CLAUDE.md "PROCEDURE Destroy DEVE chamar
1435:     * DODEFAULT() como ULTIMA linha").
1436:     *==========================================================================
1437:     PROCEDURE Destroy()
1438:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1439:             THIS.this_oBusinessObject.this_oFormUI = .NULL.
1440:             THIS.this_oBusinessObject = .NULL.
1441:         ENDIF
1442: 
1443:         THIS.this_oFormPai = .NULL.
1444: 
1445:         IF USED("cursor_4c_ArqXmlProd")
1446:             USE IN cursor_4c_ArqXmlProd
1447:         ENDIF
1448:         IF USED("cursor_4c_ArqXml")
1449:             USE IN cursor_4c_ArqXml
1450:         ENDIF
1451:         IF USED("cursor_4c_GruposSelec")
1452:             USE IN cursor_4c_GruposSelec
1453:         ENDIF
1454:         IF USED("cursor_4c_ProdutosGrupo")
1455:             USE IN cursor_4c_ProdutosGrupo
1456:         ENDIF
1457:         IF USED("cursor_4c_ControleGrupos")
1458:             USE IN cursor_4c_ControleGrupos
1459:         ENDIF
1460:         IF USED("cursor_4c_DadosGrupo")
1461:             USE IN cursor_4c_DadosGrupo
1462:         ENDIF
1463:         IF USED("cursor_4c_DadosProduto")
1464:             USE IN cursor_4c_DadosProduto
1465:         ENDIF
1466:         IF USED("cursor_4c_Caracteristicas")
1467:             USE IN cursor_4c_Caracteristicas
1468:         ENDIF
1469: 
1470:         DODEFAULT()
1471:     ENDPROC
1472: 
1473: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopgarBO.prg):
*==============================================================================
* sigopgarBO.prg
*
* Business Object para sigopgar (Gera Arquivo)
* Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/
* selecao de produtos para exportar os produtos SELECIONADOS para um arquivo
* em disco, em um de dois formatos escolhidos pelo usuario (chkXml):
*
*   - chkXml.Value = 1 (XML): gera um XML via XMLAdapter com os produtos do
*     cursor de origem (Produto/Descricao/Grupo/Unidade/Modelo/Foto/DataAlt),
*     salvando no arquivo/diretorio escolhido em CntXml.getDirs.
*   - chkXml.Value = 0 (TXT, default): gera um arquivo TXT de largura fixa
*     (protocolo proprio "td01"/"td03") com um registro por Grupo distinto e
*     um registro por Produto, mais a exportacao de cada foto (FigJpgs) como
*     .jpg separado na mesma pasta do TXT (ProcessaTxt/ExportaProduto no
*     legado), usando o arquivo escolhido em CntTXT.getArqTXT.
*
* Nao possui tabela principal propria: a origem dos produtos e o cursor
* global CrImagens, populado pelo formulario pai ANTES de abrir este dialogo
* (equivalente ao parametro oObjForm do Init legado - aqui this_cCursorOrigem
* documenta o nome do cursor recebido). A gravacao real deste BO e em ARQUIVO
* (StrToFile), nao em tabela do SQL Server - os unicos SQLEXEC existentes sao
* leituras auxiliares (SigCdGrp/SigCdPro/SigPrCar+SigCrRap) para montar o
* conteudo exportado.
*
* Criado na Fase 1 (propriedades e Init). Completo a partir da Fase 2 com
* os metodos que GERAM O ARQUIVO (GerarArquivo/GerarArquivoXml/
* GerarArquivoTxt/ExportarXml) - os "metodos CRUD" deste BO, ja que nao
* ha Inserir()/Atualizar() de tabela neste dialogo (ver acima).
*==============================================================================

DEFINE CLASS sigopgarBO AS BusinessBase

    *-- Cursor de origem dos produtos selecionados (equivalente a CrImagens
    *-- no legado), recebido do formulario pai antes de abrir este dialogo
    this_cCursorOrigem      = ""    && char - nome do cursor com os produtos selecionados (colunas Cpros/Cgrus/Cunis/FigJpgs)

    *-- Modo de geracao escolhido pelo usuario (chkXml.Valid no legado)
    this_lGeraXml           = .F.   && logical - .T. = gera arquivo XML (CntXml visivel) / .F. = gera arquivo TXT (CntTXT visivel), default .F.

    *-- Painel XML (CntXml) - visivel quando this_lGeraXml = .T.
    this_cCodArquivo        = ""    && char(20) - CntXml.Get_arquivo.Value ("Arquivo :") - codigo informativo do arquivo XML (Format "K!" no legado)
    this_cArquivoXml        = ""    && char - CntXml.getDirs.Value - caminho completo do arquivo XML de destino (extensao .xml obrigatoria)

    *-- Painel TXT (CntTXT) - visivel quando this_lGeraXml = .F. (default)
    this_cArquivoTxt        = ""    && char - CntTXT.getArqTXT.Value - caminho completo do arquivo TXT de destino
    this_lExportarImagens   = .T.   && logical - CntTXT.chkImagens.Value - exporta as fotos (FigJpgs) dos produtos como .jpg junto ao TXT, default .T. (Value=1 no SCX)

    *-- Progresso exibido durante a geracao do TXT (CntTXT.lblResults.Caption
    *-- no legado - atualizado a cada grupo/produto processado)
    this_cMensagemProgresso = ""    && char/memo - texto de progresso ("Processando N Grupo(s) / Produtos Gerados : M")
    this_nQtdGrupos         = 0     && numeric - total de grupos distintos no cursor de origem (lnQtd no legado)
    this_nQtdProdutos       = 0     && numeric - total de produtos efetivamente gravados no TXT (lnCnt no legado)

    *-- Referencia opcional ao form para repintar o progresso durante
    *-- GerarArquivoTxt (equivalente ao "ThisForm.cntTxt.lblResults.Caption
    *-- = ..." repetido dentro do Scan de ProcessaTxt no legado). Fica
    *-- .NULL. quando o BO eh usado sem interface (ex.: teste automatizado).
    this_oFormUI            = .NULL.

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal propria (a
    * gravacao efetiva eh em arquivo, nao em tabela do SQL Server - ver
    * cabecalho da classe).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Cursor global montado pelo formulario pai antes de abrir este
        *-- dialogo (equivalente a CrImagens, citado direto por nome no
        *-- Init/Processamento/ProcessaTxt do legado - nao e parametro do
        *-- Init legado). Mantido como property (em vez de literal fixo)
        *-- para permitir que o Form troque o nome, se precisar.
        THIS.this_cCursorOrigem = "crImagens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela/cursor
    * de registro unico: a origem dos dados eh this_cCursorOrigem (cursor
    * externo populado pelo formulario pai), percorrido inteiro pelo metodo
    * de geracao do arquivo, nao carregado campo a campo numa property.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. A persistencia deste dialogo eh em ARQUIVO
    * (StrToFile do XML/TXT gerado), nao em INSERT no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

    *==========================================================================
    * METODOS DE PROCESSAMENTO (equivalentes as operacoes de gravacao deste
    * dialogo - ver cabecalho da classe: a persistencia real e em ARQUIVO,
    * nunca em INSERT/UPDATE de tabela, entao os "metodos CRUD" deste BO sao
    * os que GERAM O ARQUIVO, nao Inserir()/Atualizar() de BusinessBase
    * (mesmo padrao adotado em sigopecmBO.prg para forms operacionais sem
    * tabela propria).
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarProgresso - Repinta o andamento do processamento (equivalente
    * ao "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan
    * de ProcessaTxt no legado). Delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh(). Nao faz nada
    * quando this_oFormUI esta .NULL. (BO usado sem interface).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemProgresso = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivo - Ponto de entrada do processamento (equivalente a
    * SIGOPGAR.Processamento no legado). Fecha o cursor auxiliar de XML
    * (equivalente ao "If Used([csArqXMl]) / Use In csArqXMl" do topo do
    * legado) e despacha para GerarArquivoXml() ou GerarArquivoTxt()
    * conforme this_lGeraXml (chkXml.Value).
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivo()
        IF USED("cursor_4c_ArqXml")
            USE IN cursor_4c_ArqXml
        ENDIF

        IF THIS.this_lGeraXml
            RETURN THIS.GerarArquivoXml()
        ELSE
            RETURN THIS.GerarArquivoTxt()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoXml - Gera o arquivo XML com os produtos do cursor de
    * origem (equivalente ao ramo "Else" de Processamento + ExportaProduto
    * no legado - chkXml.Value = 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoXml   - caminho completo do .xml de destino
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *
    * Contrato de erro: falha de validacao (arquivo vazio/extensao errada/
    * sem produtos selecionados) preenche this_cMensagemErro e retorna .F.
    * SEM exibir MsgErro - quem exibe eh o Form (BtnProcessarClickExec,
    * com MsgAviso), igual ao legado, que devolve .F. e deixa a
    * MessageBox para o chamador. O SetFocus que o legado faz nesses
    * ramos (btnDirs no XML, btnGetArqO no TXT, Cancela no fim de
    * ProcessaTxt) NAO foi reproduzido de proposito: Processa.Click
    * executa "Thisform.Processamento() / Thisform.Release" SEM
    * condicionar ao retorno, entao o dialogo fecha logo depois e o
    * foco recem-posto nunca chega a ser visto. Reproduzi-lo seria
    * acrescentar linha inobservavel; o que importa para o PILAR 1 -
    * mensagem identica e dialogo fechando - esta reproduzido.
    * Falha de SQL exibe o proprio MsgErro aqui, igual ao resto da classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoXml()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cProduto, loc_cSQL, loc_nResultado

        loc_lResultado          = .F.
        THIS.this_cMensagemErro = ""
        loc_cArquivo            = ALLTRIM(NVL(THIS.this_cArquivoXml, ""))
        loc_cCursorOrigem       = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "Arquivo n" + CHR(227) + "o informado!!!"
            ELSE
                IF UPPER(JUSTEXT(loc_cArquivo)) != "XML"
                    THIS.this_cMensagemErro = "Arquivo com Extens" + CHR(227) + "o inv" + CHR(225) + "lida!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        IF USED("cursor_4c_ArqXml")
                            USE IN cursor_4c_ArqXml
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ArqXml (Produto C(14), Descricao C(254), Grupo C(3), Unidade C(3), Modelo C(3), Foto W, DataAlt T)
                        SET NULL OFF
                        INDEX ON Produto TAG Produto

                        loc_lResultado = .T.

                        SELECT (loc_cCursorOrigem)
                        GO TOP
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cProduto = EVALUATE(loc_cCursorOrigem + ".Cpros")

                            loc_cSQL = "SELECT a.DPro3s, a.CodFinP, b.DataAlts" + ;
                                " FROM SigCdPro a JOIN SigCdPrc b ON a.cpros = b.cpros" + ;
                                " WHERE a.cpros = " + EscaparSQL(loc_cProduto)

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqXmlProd")

                            IF loc_nResultado < 0
                                MsgErro("Falha na Gera" + CHR(231) + CHR(227) + "o do Arquivo. Reinicie o Processo...", "Select (crTProd)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            INSERT INTO cursor_4c_ArqXml (Produto, Descricao, Grupo, Unidade, Modelo, Foto, DataAlt) VALUES ( ;
                                PADR(loc_cProduto, 14), ;
                                "", ;
                                EVALUATE(loc_cCursorOrigem + ".Cgrus"), ;
                                EVALUATE(loc_cCursorOrigem + ".Cunis"), ;
                                "", ;
                                NVL(EVALUATE(loc_cCursorOrigem + ".FigJpgs"), ""), ;
                                CTOD(""))

                            IF USED("cursor_4c_ArqXmlProd") AND RECCOUNT("cursor_4c_ArqXmlProd") > 0
                                SELECT cursor_4c_ArqXml
                                REPLACE Descricao WITH ALLTRIM(LEFT(TratarNulo(cursor_4c_ArqXmlProd.DPro3s, ""), 254)), ;
                                        Modelo    WITH TratarNulo(cursor_4c_ArqXmlProd.CodFinP, ""), ;
                                        DataAlt   WITH cursor_4c_ArqXmlProd.DataAlts
                            ENDIF

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF

                            SELECT (loc_cCursorOrigem)
                        ENDSCAN

                        IF loc_lResultado
                            SELECT cursor_4c_ArqXml
                            GO TOP

                            THIS.ExportarXml(loc_cArquivo)

                            IF FILE(loc_cArquivo)
                                MsgInfo("Arquivo Gerado com Sucesso", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo XML: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_ArqXmlProd")
                USE IN cursor_4c_ArqXmlProd
            ENDIF
            IF USED("cursor_4c_ArqXml")
                USE IN cursor_4c_ArqXml
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarXml - Grava em disco o arquivo XML com o conteudo do cursor
    * cursor_4c_ArqXml (equivalente a ExportaProduto() no legado - usa
    * XMLAdapter para serializar o cursor e grava a string resultante com
    * StrToFile).
    *
    * NOTA: XMLAdapter.ToXML() recebe o NOME da variavel de saida (como
    * string) e preenche essa variavel por substituicao - igual ao legado
    * (.ToXML([lcStr]) seguido de StrToFile(lcStr, ...)). Passar o VALOR de
    * loc_cStr no lugar do nome "loc_cStr" produziria XML vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExportarXml(par_cArquivo)
        LOCAL loc_oXml, loc_cStr
        loc_cStr = ""

        loc_oXml = CREATEOBJECT("XMLAdapter")

        WITH loc_oXml
            .RespectCursorCP = .T.
            .RespectNesting  = .T.
            .UTF8Encoded     = .T.
            .FormattedOutput = .T.
            .XMLName         = STRCONV("cpros", 12)

            .AddTableSchema("cursor_4c_ArqXml")
            .ToXML("loc_cStr")
        ENDWITH

        STRTOFILE(loc_cStr, par_cArquivo, 0)

        loc_oXml = .NULL.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoTxt - Gera o arquivo TXT de largura fixa (protocolo
    * "td01"/"td03") com um registro por Grupo distinto e um registro por
    * Produto do cursor de origem, mais a exportacao de cada foto (FigJpgs)
    * como .jpg separado na mesma pasta do TXT (equivalente a ProcessaTxt
    * no legado - chkXml.Value <> 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoTxt   - caminho completo do .txt a ser gerado
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *   THIS.this_oFormUI       - opcional, para repintar o progresso
    *
    * this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - CntTXT.chkImagens aparece so na arvore de objetos
    * e nas propriedades do SCX, nunca referenciado dentro de ProcessaTxt.
    * Acrescentar essa checagem seria inventar restricao que o legado nao
    * tem (PILAR 1 / CLAUDE.md regra #49) - a imagem e exportada sempre que
    * SigCdPro.FigJpgs estiver preenchido, independente da caixa marcada.
    *
    * Contrato de erro: igual a GerarArquivoXml() - falha de validacao
    * preenche this_cMensagemErro e retorna .F. sem MsgErro; falha de SQL
    * exibe o proprio MsgErro aqui.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoTxt()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemProgresso = ""

        loc_cArquivo      = ALLTRIM(NVL(THIS.this_cArquivoTxt, ""))
        loc_cCursorOrigem = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM (loc_cCursorOrigem) ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        SET NULL OFF
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            IF !EOF("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(cursor_4c_DadosGrupo.Ids, 8, "0")
                                loc_cDes = PADR(ALLTRIM(cursor_4c_DadosGrupo.Dgrus), 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(cursor_4c_DadosGrupo.Ids, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_DadosGrupo.Ids)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM (loc_cCursorOrigem) ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, DtIncs, Situas, PesoMs, Icms," + ;
                                        " AliqIpis, ClFiscals, SitTrIcms, Pvens, FigJpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF !EOF("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(cursor_4c_DadosProduto.Cpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(ALLTRIM(cursor_4c_DadosProduto.Dpros), 60)
                                        loc_cUni = PADR(ALLTRIM(cursor_4c_DadosProduto.Cunis), 3)
                                        loc_cDat = DTOC(TTOD(cursor_4c_DadosProduto.DtIncs))
                                        loc_cSit = IIF(cursor_4c_DadosProduto.Situas = 2, "i", "a")
                                        *-- PADL direto na COLUNA (nao em variavel) converte o
                                        *-- numero com as decimais DECLARADAS no SQL Server
                                        *-- (pesoms numeric(8,3), pvens numeric(11,5)); em
                                        *-- variavel usaria SET DECIMALS (regra CLAUDE.md #42
                                        *-- / sigopecmBO.GerarArquivoExportacao).
                                        loc_cPes = STRTRAN(PADL(cursor_4c_DadosProduto.PesoMs, 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(cursor_4c_DadosProduto.AliqIpis), 2, "0")
                                        loc_cIcm = PADL(INT(cursor_4c_DadosProduto.Icms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(cursor_4c_DadosProduto.ClFiscals, [ .], []), 8)
                                        loc_cTri = PADR(cursor_4c_DadosProduto.SitTrIcms, 3)
                                        loc_cVal = STRTRAN(PADL(cursor_4c_DadosProduto.Pvens, 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(cursor_4c_DadosProduto.Cpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            IF !EMPTY(cursor_4c_Caracteristicas.Ordens)
                                                IF !SEEK(cursor_4c_Caracteristicas.Ordens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_Caracteristicas.Ordens)

                                                    loc_cGr1 = PADL(cursor_4c_Caracteristicas.Ordens, 8, "0")
                                                    loc_cDe1 = PADR(ALLTRIM(cursor_4c_Caracteristicas.Descrs), 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(cursor_4c_Caracteristicas.Ordens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando a imagem. O legado NAO consulta
                                        *-- chkImagens aqui - ver nota de
                                        *-- this_lExportarImagens no cabecalho do metodo.
                                        IF !EMPTY(cursor_4c_DadosProduto.FigJpgs) AND !ISNULL(cursor_4c_DadosProduto.FigJpgs)
                                            loc_cImg  = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_DadosProduto.FigJpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemProgresso = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemProgresso = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo TXT: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

