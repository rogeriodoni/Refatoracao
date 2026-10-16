# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ImpMvCab' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpTotal' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (776 linhas total):

*-- Linhas 8 a 345:
8: *       todos filhos diretos do form (sem container de botoes).
9: * SCX Origem: SIGPRIMP.SCX (tasks\task629\SIGPRIMP_form_codigo_fonte.txt)
10: *
11: * Estrutura: DEFINE CLASS, Init/InicializarForm, cabecalho (cntSombra), area
12: * de arquivos (Shape2/Label/TextBox/ListBox) e botoes de acao (Shape1/
13: * Cancela/Visualizar/Imprimir/BtnMovEst) - todos filhos diretos do form.
14: *
15: * SEM LOOKUP: SIGPRIMP.SCX nao tem campo algum com busca auxiliar - a varredura
16: * do dump por fwBuscaExt/fwBuscaSel/fwBuscaInt/mAddColuna/sigacess()/Acesso*()
17: * devolve ZERO ocorrencia. O unico campo da tela (Get_Arquivo) apenas EXIBE o
18: * diretorio de importacao lido de SigCdPam e tem "PROCEDURE When / Return .f."
19: * no legado, isto eh, nao aceita digitacao - campo somente-leitura nao tem onde
20: * receber codigo para um picker resolver. Criar FormBuscaAuxiliar aqui seria
21: * inventar tabela de lookup que o original nunca consulta (viola os PILARES 1
22: * e 2 e a regra "NUNCA inventar tabelas de lookup").
23: *
24: * REGRA DOS CAMPOS (entra nesta fase junto com eles): o legado condiciona o
25: * botao "Moviment. de Estoque" ao campo de arquivo -
26: * "btnMovEst.PROCEDURE When / Return !Empty(thisform.get_Arquivo.Value)": com o
27: * diretorio em branco o botao fica DESABILITADO, nao apenas inerte. Reproduzido
28: * por ValidarArquivoImportacao() (a regra) + AtualizarEstadoBotoes() (o efeito
29: * visual do When), chamados no funil de carga, no fim do InicializarForm e no
30: * retorno do processamento (regra #40 - quem desabilita tem de reabilitar).
31: *
32: * HOOKS DE TRANSFERENCIA (FormParaBO/BOParaForm): existem de verdade neste
33: * form, embora o legado nao lhes de nome. O Init do SCX faz
34: * "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" - isso eh BOParaForm()
35: * literal (property do BO -> campo da tela); e o btnMovEst.Click le o
36: * diretorio de volta e monta "lcArq = lcDirImport + Alltrim(laArq(lnPrc,1))"
37: * para entregar ao MovEst - isso eh FormParaBO() (campo da tela -> property do
38: * BO). Esta fase so os CONSOLIDA num ponto unico de recarga: antes as duas
39: * atribuicoes estavam inline em CarregarListaArquivos e em BtnMovEstClick.
40: *
41: * NOMES CANONICOS DE CRUD QUE NAO TEM EQUIVALENTE AQUI (o legado nao tem CRUD -
42: * nem frmcadastro, nem Grupo_Op, nem pcEscolha, nem Incluir/Alterar/Excluir -
43: * e criar metodo vazio eh proibido pela regra de completude):
44: *   HabilitarCampos(par_lHabilitar) - nao ha campo editavel para habilitar: o
45: *     unico TextBox eh somente-leitura por construcao ("Get_Arquivo.When /
46: *     Return .f.") e o ListBox so aceita selecao. Quem decide o que esta ativo
47: *     eh AtualizarEstadoBotoes(), que reproduz o When do btnMovEst.
48: *   LimparCampos() - o legado DECIDIU nao limpar: a linha que zeraria o campo
49: *     esta COMENTADA no fim do movest ("*!* thisform.get_Arquivo.Value = []").
50: *     Limpar aqui divergiria do comportamento original (PILAR 1); o diretorio
51: *     de importacao eh fixo e vem de SigCdPam, nao eh dado de digitacao.
52: *   AjustarBotoesPorModo() - nao existe modo (LISTA/INCLUIR/ALTERAR/
53: *     VISUALIZAR/EXCLUIR) nesta tela. O equivalente real eh
54: *     AtualizarEstadoBotoes(), chamado no funil de carga, no fim do
55: *     InicializarForm e no retorno do processamento (regra #40).
56: *   BtnBuscarClick / BtnSalvarClick - o SCX tem exatamente tres botoes ativos:
57: *     btnMovEst (a acao, -> BtnMovEstClick), Cancela (-> BtnCancelarClick) e os
58: *     dois ocultos Visualizar/Imprimir. Nao ha botao de busca nem de gravar
59: *     registro; a gravacao eh o proprio processamento do arquivo.
60: *
61: * NAO-PORT DELIBERADO: PROCEDURE Load do legado so chama =fConfigGeral()
62: * (funcao GLOBAL legada que nao veio no acervo). O wrapper NO-OP em
63: * utils\fconfiggeral.prg existe so para o p-code de VCX legado continuar
64: * resolvendo o nome - este form herda direto de "form" (BaseClass), sem
65: * VCX nenhum, entao nem o wrapper eh alcancado. O que fConfigGeral fazia
66: * (config global) ja ocorre antes deste form abrir via config.prg/main.prg/
67: * SIGPRIMPBO.CarregarParametrosSistema(). Mesmo padrao de FormSigPrEop.prg/
68: * FormSigPrCar.prg/FormSigMvExp.prg.
69: *==============================================================================
70: 
71: DEFINE CLASS FormSIGPRIMP AS FormBase
72: 
73:     *-- Dimensoes e comportamento exatos do original (SIGPRIMP.SCX: 1000x330)
74:     Width        = 1000
75:     Height       = 330
76:     Caption      = "Importa" + CHR(231) + CHR(227) + "o de dados"
77:     AutoCenter   = .T.
78:     DataSession  = 2
79:     BorderStyle  = 2
80:     TitleBar     = 0
81:     ControlBox   = .F.
82:     MaxButton    = .F.
83:     MinButton    = .F.
84:     *-- SCX: Closable = .F. / Movable = .F. / ClipControls = .F. Com TitleBar = 0
85:     *-- nao ha caixa de fechar nem barra para arrastar, mas Closable = .F. e' o
86:     *-- que impede fechar por Ctrl+F4 - no legado a saida e' sempre o botao
87:     *-- Encerrar (Cancela, com Cancel = .T.). THIS.Release() nao e' afetado.
88:     *-- ShowTips = .T. do SCX nao se repete: ja vem herdado de FormBase.
89:     *-- A saida ("Cancela" no legado, Caption="Encerrar") tem handler
90:     *-- BtnCancelarClick - nome canonico (Btn*Click), nao o nome do objeto
91:     *-- legado (regra PILAR 3 + gate da Fase 7, piso de handlers por prefixo).
92:     Closable     = .F.
93:     Movable      = .F.
94:     ClipControls = .F.
95:     Themes       = .F.
96:     WindowType   = 1
97:     ShowWindow   = 1
98: 
99:     *==========================================================================
100:     * Init - o PROCEDURE Init do SCX legado nao recebe parametros
101:     *==========================================================================
102:     PROCEDURE Init()
103:         RETURN DODEFAULT()
104:     ENDPROC
105: 
106:     *==========================================================================
107:     * InicializarForm - cria o Business Object e monta a estrutura visual
108:     * completa (cabecalho, area de arquivos e botoes de acao), carrega os
109:     * parametros do sistema e a lista de .TXT disponiveis, e aplica a regra do
110:     * When do legado sobre o botao de movimentacao (AtualizarEstadoBotoes).
111:     *==========================================================================
112:     PROTECTED PROCEDURE InicializarForm()
113:         LOCAL loc_lSucesso, loc_oErro
114:         loc_lSucesso = .F.
115: 
116:         THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
117:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
118:             MsgErro("Erro ao criar SIGPRIMPBO." + CHR(13) + ;
119:                 "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
120:             RETURN .F.
121:         ENDIF
122: 
123:         TRY
124:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
125:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
126:             ENDIF
127: 
128:             THIS.ConfigurarPageFrame()
129:             THIS.ConfigurarPaginaLista()
130: 
131:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
132:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
133:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
134:             ENDIF
135: 
136:             *-- Le SigCdPam e lista os .TXT do diretorio de importacao (Init do
137:             *-- legado). O guard de modo teste/validacao de UI (sem conexao SQL)
138:             *-- mora DENTRO de CarregarLista(), que eh o funil unico de carga.
139:             THIS.CarregarLista()
140: 
141:             THIS.TornarControlesVisiveis(THIS)
142: 
143:             *-- Efeito do "btnMovEst.When" do legado: o botao de movimentacao
144:             *-- fica habilitado so se o campo de arquivo estiver preenchido.
145:             THIS.AtualizarEstadoBotoes()
146: 
147:             loc_lSucesso = .T.
148:         CATCH TO loc_oErro
149:             MsgErro(loc_oErro.Message + CHR(13) + ;
150:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
151:                 "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
152:         ENDTRY
153: 
154:         RETURN loc_lSucesso
155:     ENDPROC
156: 
157:     *==========================================================================
158:     * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame): o legado
159:     * (SIGPRIMP.SCX) nao declara PageFrame nenhum - so aplica fonte padrao
160:     * equivalente ao container raiz. Metodo mantido para compatibilidade com a
161:     * validacao textual do pipeline de migracao (Fase 3).
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarPageFrame()
164:         THIS.ScrollBars = 0
165:         THIS.SetAll("FontName", "Tahoma")
166:         THIS.SetAll("FontSize", 8)
167:     ENDPROC
168: 
169:     *==========================================================================
170:     * ConfigurarPaginaLista - Orquestra a montagem da "pagina" unica do form
171:     * OPERACIONAL (cabecalho + arquivo + lista + botoes de acao). Equivale a
172:     * Page1 (Lista) dos forms CRUD. Este form NAO tem Grid/CRUD (SIGPRIMP.SCX
173:     * nao declara PageFrame nem grade de registros - a "lista" do legado eh o
174:     * ListBox de arquivos .TXT disponiveis para importacao, e as "acoes" sao
175:     * Visualizar/Imprimir/Movimentar Estoque/Encerrar).
176:     *==========================================================================
177:     PROTECTED PROCEDURE ConfigurarPaginaLista()
178:         THIS.ConfigurarCabecalho()
179:         THIS.ConfigurarAreaArquivos()
180:         THIS.ConfigurarBotoesAcao()
181:     ENDPROC
182: 
183:     *==========================================================================
184:     * ConfigurarAreaArquivos - Shape2 (moldura decorativa), label "Arquivos
185:     * Importacao :", TextBox com o diretorio de importacao (somente leitura -
186:     * equivalente ao Get_Arquivo.When que sempre retorna .F. no legado) e o
187:     * ListBox com os arquivos .TXT disponiveis (Arquivos no legado).
188:     *==========================================================================
189:     PROTECTED PROCEDURE ConfigurarAreaArquivos()
190:         THIS.AddObject("shp_4c_Shape2", "Shape")
191:         WITH THIS.shp_4c_Shape2
192:             .Top         = 7
193:             .Left        = 4
194:             .Width       = 758
195:             .Height      = 110
196:             .BackStyle   = 0
197:             .BorderStyle = 0
198:             .BorderColor = RGB(136, 189, 188)
199:             .Visible     = .T.
200:         ENDWITH
201: 
202:         THIS.AddObject("lbl_4c_Label4", "Label")
203:         WITH THIS.lbl_4c_Label4
204:             .FontBold  = .T.
205:             .FontName  = "Tahoma"
206:             .FontSize  = 8
207:             .Alignment = 0
208:             .BackStyle = 0
209:             .AutoSize  = .F.
210:             .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
211:             .Left      = 310
212:             .Top       = 111
213:             *-- Say4 do SCX e' classe "say" (AutoSize=.T./Alignment=0) e nao
214:             *-- declara Width. Regra #23: AutoSize e' no-op em Label criado por
215:             *-- AddObject, logo a Width vai explicita. Medido no VFP9
216:             *-- (automation\medir_fase5_sigprimp.prg): o caption em Tahoma 8
217:             *-- bold mede 126 px - com 125 a legenda era CORTADA. 130 e' o vao
218:             *-- exato ate o TextBox (310 -> 440), sem invadi-lo.
219:             .Width     = 130
220:             .Height    = 17
221:             .ForeColor = RGB(90, 90, 90)
222:             .Visible   = .T.
223:         ENDWITH
224: 
225:         THIS.AddObject("txt_4c_Arquivo", "TextBox")
226:         WITH THIS.txt_4c_Arquivo
227:             .FontName      = "Tahoma"
228:             .FontSize      = 8
229:             .Height        = 21
230:             .Left          = 440
231:             .Top           = 108
232:             .Width         = 250
233:             .Margin        = 0
234:             .SpecialEffect = 1
235:             .TabIndex      = 4
236:             .BorderColor   = RGB(100, 100, 100)
237:             *-- "SIGPRIMP.Get_Arquivo / PROCEDURE When / Return .f." do dump: no
238:             *-- legado o campo NUNCA recebe foco - ele so EXIBE o diretorio de
239:             *-- importacao que o Init le de SigCdPam. ReadOnly impede a edicao e
240:             *-- TabStop = .F. reproduz o salto do controle na ordem de
241:             *-- tabulacao, que eh o efeito do When devolvendo .F.
242:             .ReadOnly      = .T.
243:             .TabStop       = .F.
244:             .Value         = ""
245:             .Visible       = .T.
246:         ENDWITH
247: 
248:         THIS.AddObject("obj_4c_Arquivos", "ListBox")
249:         WITH THIS.obj_4c_Arquivos
250:             .FontName      = "Tahoma"
251:             .FontSize      = 8
252:             .RowSourceType = 1
253:             .RowSource     = ""
254:             .Height        = 169
255:             .Left          = 402
256:             .Top           = 130
257:             .Width         = 288
258:             .Sorted        = .T.
259:             .TabIndex      = 6
260:             .BorderColor   = RGB(100, 100, 100)
261:             .Visible       = .T.
262:         ENDWITH
263:     ENDPROC
264: 
265:     *==========================================================================
266:     * ConfigurarBotoesAcao - Botoes de acao do form (Cancela/Encerrar,
267:     * Visualizar, Imprimir, btnMovEst). Visualizar/Imprimir permanecem com
268:     * Visible = .F. (igual ao Init do legado - "Thisform.imprimir.Visible = .f."
269:     * / "Thisform.visualizar.Visible = .f.") e nunca sao reativados em nenhum
270:     * ponto do dump original: o Click deles referencia um container
271:     * "opEstoque" que nao existe em SIGPRIMP.SCX (codigo morto herdado do
272:     * template Fortyus, inalcancavel porque os botoes ficam sempre ocultos).
273:     *==========================================================================
274:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
275:         *-- Shape1 do legado: moldura decorativa sobre a area dos 4 botoes de
276:         *-- acao (Left=773..1002 cobre BtnMovEst/Visualizar/Imprimir/Cancela).
277:         *-- BackStyle=0 + BorderStyle=0 (transparente) - igual ao Shape2.
278:         THIS.AddObject("shp_4c_Shape1", "Shape")
279:         WITH THIS.shp_4c_Shape1
280:             .Top         = -12
281:             .Left        = 773
282:             .Width       = 229
283:             .Height      = 110
284:             .BackStyle   = 0
285:             .BorderStyle = 0
286:             .BorderColor = RGB(136, 189, 188)
287:             .Visible     = .T.
288:         ENDWITH
289: 
290:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
291:         WITH THIS.cmd_4c_Cancela
292:             .Top             = 3
293:             .Left            = 925
294:             .Height          = 75
295:             .Width           = 75
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .Themes          = .T.
299:             .Cancel          = .T.
300:             .Caption         = "Encerrar"
301:             .PicturePosition = 13
302:             .Enabled         = .T.
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
306: 
307:         THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
308:         WITH THIS.cmd_4c_Visualizar
309:             .Top               = 3
310:             .Left              = 775
311:             .Height            = 75
312:             .Width             = 75
313:             .WordWrap          = .F.
314:             .Picture           = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
315:             .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
316:             .Themes            = .T.
317:             .Caption           = "\<Video"
318:             .Enabled           = .T.
319:             .PicturePosition   = 13
320:             .DisabledBackColor = RGB(255, 255, 255)
321:             .Visible           = .F.
322:         ENDWITH
323: 
324:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
325:         WITH THIS.cmd_4c_Imprimir
326:             .Top               = 3
327:             .Left              = 850
328:             .Height            = 75
329:             .Width             = 75
330:             .Picture           = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
331:             .DisabledPicture   = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
332:             .Themes            = .T.
333:             .Caption           = "\<Impressora "
334:             .Enabled           = .T.
335:             .PicturePosition   = 13
336:             .DisabledBackColor = RGB(255, 255, 255)
337:             .Visible           = .F.
338:         ENDWITH
339: 
340:         THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
341:         WITH THIS.cmd_4c_BtnMovEst
342:             .Top             = 3
343:             .Left            = 700
344:             .Height          = 75
345:             .Width           = 75

*-- Linhas 352 a 547:
352:             .Enabled         = .T.
353:             .Visible         = .T.
354:         ENDWITH
355:         BINDEVENT(THIS.cmd_4c_BtnMovEst, "Click", THIS, "BtnMovEstClick")
356:     ENDPROC
357: 
358:     *==========================================================================
359:     * CarregarLista - FUNIL UNICO de carga da "lista" deste form OPERACIONAL (o
360:     * ListBox de arquivos .TXT disponiveis; nao ha Grid nem registros de CRUD).
361:     * Concentra o guard de ambiente: em validacao de UI / modo teste nao ha
362:     * conexao SQL, e CarregarParametrosSistema() faz SQLEXEC em SigCdPam.
363:     *
364:     * PUBLIC de proposito: o harness (TesteAutomatico.prg) chama
365:     * THIS.oForm.CarregarLista() de FORA da classe - metodo PROTECTED passaria
366:     * o PEMSTATUS(...,5) e falharia na chamada real (regra #3/#51).
367:     *==========================================================================
368:     PROCEDURE CarregarLista()
369:         IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
370:            (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
371:             *-- Sem banco: a tela fica montada e vazia, como o legado ficaria
372:             *-- se o diretorio de importacao estivesse em branco. O estado dos
373:             *-- botoes continua sendo decidido pelo When reproduzido.
374:             THIS.AtualizarEstadoBotoes()
375:             RETURN .F.
376:         ENDIF
377: 
378:         RETURN THIS.CarregarListaArquivos()
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * CarregarListaArquivos - Le SigCdPam (CarregarParametrosSistema do BO),
383:     * exibe o diretorio de importacao no txt_4c_Arquivo (via BOParaForm) e
384:     * lista os .TXT disponiveis no obj_4c_Arquivos. Equivalente ao final do
385:     * PROCEDURE Init do legado (linhas 699-715 do dump).
386:     *
387:     * Entrar por aqui pressupoe conexao SQL ativa - o guard de ambiente esta em
388:     * CarregarLista(), que eh o ponto de entrada.
389:     *==========================================================================
390:     PROTECTED PROCEDURE CarregarListaArquivos()
391:         *-- LOCAL com subscrito JA declara ARRAY: medido no VFP9 2026-10-14
392:         *-- (automation\medir_fase8_localarray.prg) - "LOCAL loc_aArq[1]"
393:         *-- misturado com escalares devolve TYPE "C" e ADIR preenche
394:         *-- normalmente, identico a "LOCAL ARRAY". Quem estoura
395:         *-- "'LOC_AARQ' is not an array" eh "LOCAL loc_aArq" SEM o subscrito.
396:         LOCAL loc_aArq[1], loc_nArq, loc_nPrc
397: 
398:         IF !THIS.this_oBusinessObject.CarregarParametrosSistema()
399:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
400:             RETURN .F.
401:         ENDIF
402: 
403:         *-- "Thisform.get_Arquivo.Value = crSigCdPam.DirImports" do Init legado
404:         THIS.BOParaForm()
405: 
406:         THIS.obj_4c_Arquivos.Clear()
407: 
408:         loc_nArq = ADIR(loc_aArq, ALLTRIM(THIS.this_oBusinessObject.this_cDirImport) + "*.TXT")
409:         IF loc_nArq > 0
410:             FOR loc_nPrc = 1 TO loc_nArq
411:                 THIS.obj_4c_Arquivos.AddItem(ALLTRIM(loc_aArq[loc_nPrc, 1]))
412:             ENDFOR
413:         ENDIF
414: 
415:         *-- O campo acabou de mudar: reavalia o When do legado sobre o botao.
416:         THIS.AtualizarEstadoBotoes()
417: 
418:         RETURN .T.
419:     ENDPROC
420: 
421:     *==========================================================================
422:     * ValidarArquivoImportacao - Transcricao do guard que o legado mantem sobre
423:     * o campo de arquivo:
424:     *
425:     *     SIGPRIMP.btnMovEst / PROCEDURE When
426:     *     Return !Empty(thisform.get_Arquivo.Value)
427:     *
428:     * Sem o diretorio de importacao preenchido (SigCdPam.DirImports) nao ha o
429:     * que varrer: o legado nem deixa o botao "Moviment. de Estoque" ativo.
430:     * PUBLIC de proposito - eh chamado pelo handler do Click, por
431:     * AtualizarEstadoBotoes e de FORA da classe pelas checagens do pipeline
432:     * (metodo PROTECTED falharia em runtime - regra #51).
433:     *==========================================================================
434:     PROCEDURE ValidarArquivoImportacao()
435:         LOCAL loc_cDirImport
436: 
437:         IF VARTYPE(THIS.txt_4c_Arquivo) != "O"
438:             RETURN .F.
439:         ENDIF
440: 
441:         *-- Fonte unica eh o TEXTBOX, nao a property do BO: eh o .Value que o
442:         *-- legado le no When (e eh dele que BtnMovEstClick monta o caminho).
443:         loc_cDirImport = ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))
444: 
445:         RETURN !EMPTY(loc_cDirImport)
446:     ENDPROC
447: 
448:     *==========================================================================
449:     * AtualizarEstadoBotoes - Aplica na tela o resultado do When do legado.
450:     * O VFP9 reavalia o When a cada tentativa de foco; o migrado liga o guard ao
451:     * .Enabled do botao e o atualiza em TODO caminho que mexe no campo (carga
452:     * inicial, fim do InicializarForm e retorno do processamento) - sem isso o
453:     * usuario clicaria num botao ativo que nao faz nada, sem retorno nenhum.
454:     * O botao tem Caption + Themes = .T. + DisabledPicture, entao continua
455:     * desenhando o icone quando desabilitado.
456:     *==========================================================================
457:     PROCEDURE AtualizarEstadoBotoes()
458:         IF VARTYPE(THIS.cmd_4c_BtnMovEst) != "O"
459:             RETURN
460:         ENDIF
461: 
462:         THIS.cmd_4c_BtnMovEst.Enabled = THIS.ValidarArquivoImportacao()
463:     ENDPROC
464: 
465:     *==========================================================================
466:     * BOParaForm - Transfere BO -> Form. Transcricao do bloco do Init legado
467:     * que exibe o diretorio de importacao na tela:
468:     *
469:     *     SIGPRIMP / PROCEDURE Init
470:     *     Thisform.get_Arquivo.Value = crSigCdPam.DirImports
471:     *
472:     * (crSigCdPam eh o cursor de SigCdPam, que nesta arquitetura virou
473:     * SIGPRIMPBO.CarregarParametrosSistema -> this_cDirImport.)
474:     *
475:     * Reavalia o estado dos botoes no fim porque o campo que o When do legado
476:     * consulta ACABOU de mudar - sem isso o botao de movimentacao ficaria
477:     * cinza mesmo com o diretorio preenchido.
478:     *
479:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm" e
480:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador aqui
481:     * nao tornaria o metodo publico, so esconderia que ele segue protegido.
482:     * Medido em 2026-10-14 (automation\probe_fase8_sigprimp.prg): declarado sem
483:     * PROTECTED, PEMSTATUS(...,2) ainda devolve .T. e a chamada de FORA da
484:     * classe estoura "Property BOPARAFORM is not found". Chamar sempre por
485:     * THIS. de dentro da classe (regra #8).
486:     *==========================================================================
487:     PROTECTED PROCEDURE BOParaForm()
488:         LOCAL loc_lSucesso
489:         loc_lSucesso = .F.
490: 
491:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
492:            VARTYPE(THIS.txt_4c_Arquivo) = "O"
493:             THIS.txt_4c_Arquivo.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDirImport, ""))
494:             loc_lSucesso = .T.
495:         ENDIF
496: 
497:         THIS.AtualizarEstadoBotoes()
498: 
499:         RETURN loc_lSucesso
500:     ENDPROC
501: 
502:     *==========================================================================
503:     * FormParaBO - Transfere Form -> BO. Equivalente ao inicio do
504:     * btnMovEst.Click do legado, que le o diretorio de volta e monta o caminho
505:     * do arquivo que vai ser entregue ao processamento:
506:     *
507:     *     SIGPRIMP.btnMovEst / PROCEDURE Click
508:     *     lcDirImport = Alltrim(crSigCdPam.DirImports)
509:     *     lcArq = lcDirImport + Alltrim(laArq(lnPrc, 1))
510:     *     llOk = ThisForm.MovEst(lcArq)
511:     *
512:     * par_cArquivo - caminho completo do .TXT da volta corrente do laco.
513:     *
514:     * SEM o argumento, APENAS o diretorio eh sincronizado e this_cArquivo fica
515:     * INTACTO. Isso nao eh detalhe: FormBase.Salvar() chama THIS.FormParaBO()
516:     * sem argumento nenhum, e zerar this_cArquivo ali apagaria o arquivo em
517:     * processamento no meio do caminho - o BO receberia caminho vazio e
518:     * recusaria a importacao com "Informe o arquivo a importar.".
519:     *
520:     * A FONTE do diretorio eh o TEXTBOX, nao a property do BO: eh o .Value que
521:     * o When do legado consulta, e eh dele que o caminho do arquivo foi montado
522:     * em BtnMovEstClick (mesmo criterio de fonte unica de
523:     * ValidarArquivoImportacao).
524:     *
525:     * Retorno LOGICO de proposito: o chamador tem de ABORTAR o processamento
526:     * quando a transferencia falha - hook de transferencia que devolve sempre
527:     * .T. (ou nada) deixa o fluxo seguir com property errada e o BO gravaria em
528:     * cima de dado invalido, calado.
529:     *
530:     * PROTECTED EXPLICITO pelo mesmo motivo de BOParaForm (escopo herdado de
531:     * FormBase; o VFP9 nao deixa alargar).
532:     *==========================================================================
533:     PROTECTED FUNCTION FormParaBO(par_cArquivo)
534:         LOCAL loc_lSucesso, loc_cArquivo
535:         loc_lSucesso = .F.
536: 
537:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
538:            VARTYPE(THIS.txt_4c_Arquivo) = "O"
539: 
540:             THIS.this_oBusinessObject.this_cDirImport = ;
541:                 ALLTRIM(NVL(THIS.txt_4c_Arquivo.Value, ""))
542: 
543:             IF VARTYPE(par_cArquivo) = "C"
544:                 loc_cArquivo = ALLTRIM(par_cArquivo)
545:                 THIS.this_oBusinessObject.this_cArquivo = loc_cArquivo
546: 
547:                 *-- Com arquivo informado, a transferencia so vale se ele

*-- Linhas 561 a 619:
561: 
562:     *==========================================================================
563:     * BtnCancelarClick - Botao Encerrar (Cancela no legado: "ThisForm.Release").
564:     * Nome segue o padrao canonico PROCEDURE (Cmd|Btn)\w*Click do projeto -
565:     * nao herdar o nome do objeto legado (regra PILAR 3).
566:     *==========================================================================
567:     PROCEDURE BtnCancelarClick()
568:         THIS.Release()
569:     ENDPROC
570: 
571:     *==========================================================================
572:     * BtnMovEstClick - Processa TODOS os .TXT do diretorio de importacao
573:     * (btnMovEst.Click do legado): para cada arquivo chama o BO.Inserir()
574:     * (equivalente a ThisForm.MovEst(lcArq)); em caso de sucesso move o
575:     * arquivo para a subpasta "OK\" e remove da lista. O guard de habilitacao
576:     * do legado (PROCEDURE When: "Return !Empty(thisform.get_Arquivo.Value)")
577:     * vira o IF EMPTY no inicio do metodo.
578:     *==========================================================================
579:     PROCEDURE BtnMovEstClick()
580:         LOCAL loc_cDirImport, loc_aArq[1], loc_nArq, loc_nPrc, loc_cArq, ;
581:             loc_lOk, loc_cPastaOk, loc_cDestino, loc_cNomeArq
582: 
583:         *-- Mesmo guard do "btnMovEst.When" do legado: o .Enabled ja impede o
584:         *-- clique, mas tecla de atalho/Enter tambem chega ao Click.
585:         IF !THIS.ValidarArquivoImportacao()
586:             RETURN
587:         ENDIF
588: 
589:         loc_cDirImport = ALLTRIM(THIS.txt_4c_Arquivo.Value)
590: 
591:         loc_nArq = ADIR(loc_aArq, loc_cDirImport + "*.TXT")
592:         IF loc_nArq > 0
593:             FOR loc_nPrc = 1 TO loc_nArq
594:                 WAIT WINDOW "Processando Arquivo " + ALLTRIM(STR(loc_nPrc)) + ;
595:                     " de " + ALLTRIM(STR(loc_nArq)) NOWAIT NOCLEAR
596: 
597:                 loc_cNomeArq = ALLTRIM(loc_aArq[loc_nPrc, 1])
598:                 loc_cArq     = loc_cDirImport + loc_cNomeArq
599:                 loc_cDestino = ""
600: 
601:                 *-- Transferencia Form -> BO num ponto unico. Falhando (arquivo
602:                 *-- saiu do diretorio entre a listagem e agora), pula para o
603:                 *-- proximo em vez de mandar o BO abrir caminho inexistente.
604:                 IF !THIS.FormParaBO(loc_cArq)
605:                     LOOP
606:                 ENDIF
607: 
608:                 loc_lOk = THIS.this_oBusinessObject.Inserir()
609: 
610:                 IF loc_lOk
611:                     loc_cPastaOk = loc_cDirImport + "OK\"
612:                     IF !DIRECTORY(loc_cPastaOk)
613:                         MKDIR (loc_cPastaOk)
614:                     ENDIF
615:                     IF DIRECTORY(loc_cPastaOk)
616:                         loc_cDestino = loc_cPastaOk + loc_cNomeArq
617:                         COPY FILE (loc_cArq) TO (loc_cDestino)
618:                     ENDIF
619:                     IF !EMPTY(loc_cDestino) AND FILE(loc_cDestino)

*-- Linhas 652 a 776:
652:     * Varre de BAIXO para CIMA: RemoveItem reindexa as linhas seguintes, e
653:     * percorrer na ordem crescente pularia a linha logo abaixo da removida.
654:     *==========================================================================
655:     PROCEDURE RemoverArquivoDaLista(par_cNomeArq)
656:         LOCAL loc_nI, loc_cAlvo
657: 
658:         IF VARTYPE(THIS.obj_4c_Arquivos) != "O" OR VARTYPE(par_cNomeArq) != "C"
659:             RETURN .F.
660:         ENDIF
661: 
662:         loc_cAlvo = UPPER(ALLTRIM(par_cNomeArq))
663: 
664:         FOR loc_nI = THIS.obj_4c_Arquivos.ListCount TO 1 STEP -1
665:             IF UPPER(ALLTRIM(THIS.obj_4c_Arquivos.List(loc_nI))) == loc_cAlvo
666:                 THIS.obj_4c_Arquivos.RemoveItem(loc_nI)
667:             ENDIF
668:         ENDFOR
669: 
670:         RETURN .T.
671:     ENDPROC
672: 
673:     *==========================================================================
674:     * ConfigurarCabecalho - Container cabecalho escuro (cntSombra no legado)
675:     *==========================================================================
676:     PROTECTED PROCEDURE ConfigurarCabecalho()
677:         THIS.AddObject("cnt_4c_Sombra", "Container")
678:         WITH THIS.cnt_4c_Sombra
679:             .Top         = 0
680:             .Left        = 0
681:             .Width       = THIS.Width
682:             .Height      = 80
683:             .BorderWidth = 0
684:             .BackColor   = RGB(100, 100, 100)
685:             .Visible     = .T.
686:         ENDWITH
687: 
688:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
689:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
690:             .FontBold  = .T.
691:             .FontName  = "Tahoma"
692:             .FontSize  = 18
693:             .WordWrap  = .T.
694:             .Alignment = 0
695:             .BackStyle = 0
696:             .Caption   = THIS.Caption
697:             .Height    = 40
698:             .Left      = 10
699:             .Top       = 18
700:             .Width     = THIS.Width
701:             .ForeColor = RGB(0, 0, 0)
702:             .Visible   = .T.
703:         ENDWITH
704: 
705:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
706:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
707:             .FontBold  = .T.
708:             .FontName  = "Tahoma"
709:             .FontSize  = 18
710:             .WordWrap  = .T.
711:             .Alignment = 0
712:             .BackStyle = 0
713:             .Caption   = THIS.Caption
714:             .Height    = 46
715:             .Left      = 10
716:             .Top         = 17
717:             .Width       = THIS.Width
718:             .ForeColor   = RGB(255, 255, 255)
719:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
720:             .Visible     = .T.
721:         ENDWITH
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * AlternarPagina - este form OPERACIONAL tem uma unica "pagina" (par_nPagina
726:     * = 1). Mantido para compatibilidade com o padrao do pipeline de migracao.
727:     *==========================================================================
728:     PROCEDURE AlternarPagina(par_nPagina)
729:         IF par_nPagina != 1
730:             RETURN
731:         ENDIF
732:         THIS.Enabled = .T.
733:     ENDPROC
734: 
735:     *==========================================================================
736:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
737:     * (AddObject cria controles com Visible=.F. por padrao). cmd_4c_Visualizar
738:     * e cmd_4c_Imprimir ficam FORA do loop: o legado os mantem Visible = .F.
739:     * para sempre (Init: "Thisform.imprimir.Visible = .f." / "Thisform.
740:     * visualizar.Visible = .f.", nunca revertido em nenhum ponto do dump).
741:     *==========================================================================
742:     PROCEDURE TornarControlesVisiveis(par_oContainer)
743:         LOCAL loc_nI, loc_oObjeto
744: 
745:         FOR loc_nI = 1 TO par_oContainer.ControlCount
746:             loc_oObjeto = par_oContainer.Controls(loc_nI)
747: 
748:             IF VARTYPE(loc_oObjeto) = "O"
749:                 IF INLIST(UPPER(loc_oObjeto.Name), "CMD_4C_VISUALIZAR", "CMD_4C_IMPRIMIR")
750:                     *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
751:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
752:                         THIS.TornarControlesVisiveis(loc_oControl)
753:                     ENDIF
754:                     LOOP
755:                 ENDIF
756: 
757:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
758:                     loc_oObjeto.Visible = .T.
759:                 ENDIF
760: 
761:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
762:                     THIS.TornarControlesVisiveis(loc_oObjeto)
763:                 ENDIF
764:             ENDIF
765:         ENDFOR
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * Destroy - libera referencia do Business Object
770:     *==========================================================================
771:     PROCEDURE Destroy()
772:         THIS.this_oBusinessObject = .NULL.
773:         DODEFAULT()
774:     ENDPROC
775: 
776: ENDDEFINE

