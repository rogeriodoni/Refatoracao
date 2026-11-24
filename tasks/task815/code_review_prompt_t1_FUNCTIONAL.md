# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PersistirItens()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarUmaTransportadora()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeOpe define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeOpe.RecordSource).
- [GRID-WITH] Bloco WITH legado. define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: legado..RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigoptrp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1714 linhas total):

*-- Linhas 46 a 97:
46: *   direto, nao reusa cursor do form pai) - mesma decisao documentada no
47: *   cabecalho de FormSigOpTrf.prg.
48: *
49: *   "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
50: *   Fortyus era inicializacao GLOBAL da aplicacao, ja coberta pelo startup
51: *   do sistema novo (config.prg) - mesma decisao documentada no cabecalho
52: *   de SigOpTrfBO.prg/SigOpTopBO.prg (familia SigOp*).
53: *
54: * CHAMADA (equivale ao "Do Form Sigoptrp With ThisForm, ThisForm.
55: * DataSessionId" do legado, onde o proprio form pai eh "poForm" e
56: * "crSigCdOpe.Dopes" vem da linha corrente da Lista do pai):
57: *   loForm = CREATEOBJECT("FormSigoptrp", THISFORM, loc_cOperacaoAtual, ;
58: *       THISFORM.DataSessionId)
59: *   IF VARTYPE(loForm) = "O"
60: *       loForm.Show()          && modal: so volta quando o dialogo fecha
61: *   ENDIF
62: *
63: *   Como no legado, o Release eh do PROPRIO dialogo (botao Confirmar/
64: *   Cancelar, fase futura), nao do chamador.
65: *
66: * PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
67: *   par_oFormPai         - legado: poForm/ThisForm.ParentForm (property
68: *                          CUSTOM da classe - RESERVED3/ClassInfo do dump
69: *                          lista "parentform" como custom property, NAO a
70: *                          nativa de container MDI). Form pai SigCdOpe
71: *                          (Cadastro de Operacoes do Caixa), que precisa
72: *                          expor .Enabled - desabilitado enquanto este
73: *                          dialogo esta aberto (legado: .ParentForm.
74: *                          Enabled = .f.), reabilitado ao sair.
75: *   par_cDopes           - legado: crSigCdOpe.Dopes, lido direto do cursor
76: *                          do pai (ja na DataSession dele). Como o migrado
77: *                          nao troca de DataSession, o codigo da operacao
78: *                          e passado explicitamente pelo chamador.
79: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
80: *                          ja unifica a sessao com o pai; mantido so para
81: *                          auditoria/paridade com o legado.
82: *
83: * METODOS DE DADOS (ja implementados no BO - fases 1-2, ver cabecalho de
84: * SigoptrpBO.prg para o detalhamento completo): CarregarDoCursor/
85: * ObterChavePrimaria/Inserir/ApagarItensDaOperacao/CarregarItens/
86: * FecharCursoresTrabalho. NAO sobrescreve Atualizar() nem
87: * ExecutarExclusao(): nao ha alteracao nem exclusao unitaria no legado - a
88: * remocao de uma linha e so o efeito colateral de ela nao ser reinserida
89: * no lote seguinte, igual ao SigOpTrfBO.
90: *
91: * FASE 8 (esta fase): "Eventos Auxiliares e Consolidacao Final" - NAO SE
92: * APLICA ao roteiro generico de CRUD Lista/Dados deste pipeline, pela MESMA
93: * razao estrutural ja registrada na FASE 5 abaixo: este dialogo e FLAT
94: * (sem PageFrame Lista/Dados) e nao tem modos INCLUIR/ALTERAR/VISUALIZAR -
95: * so edita uma grade local (xOpe) e persiste em lote ao Confirmar. O
96: * roteiro padrao da Fase 8 pede 8 itens; cada um foi conferido contra o
97: * dump (Sigoptrp_form_codigo_fonte.txt) e contra o que as Fases 3-7 JA

*-- Linhas 123 a 249:
123: *
124: *   | metodo                       | conteudo |
125: *   |------------------------------|----------|
126: *   | ConfigurarBINDEVENTs()       | liga os 4 Click (regra #3 - BINDEVENT so com metodo PUBLIC) |
127: *   | MarcarDadosAlterados()       | legado: ThisForm.GravaDados = .t. - sincroniza Form + BO |
128: *   | CmdInserirClick()            | cmdInserir.Click: linha em branco em xOpe + foco na coluna Itras |
129: *   | CmdExcluirClick()            | cmdExcluir.Click: apaga a linha corrente de xOpe |
130: *   | BtnSairClick()                | cmdSair.Click ("Confirmar"): valida duplicata, regrava o lote, fecha |
131: *   | PersistirItens()             | PROTECTED, corpo do "apaga tudo e reinsere" do Confirmar |
132: *   | GravarUmaTransportadora()    | PROTECTED, NovoRegistro()+Salvar() por linha nao-vazia (regra #51) |
133: *   | BtnCancelarClick()           | Cancela.Click: fecha sem gravar |
134: *
135: *   NAO ha BtnIncluirClick()/BtnAlterarClick()/BtnVisualizarClick()/
136: *   BtnExcluirClick() (nomenclatura generica de CRUD Lista/Dados): este
137: *   dialogo NAO tem CRUD, Alterar nem Visualizar - o dump legado so
138: *   prova os 4 botoes acima (cmdInserir/cmdExcluir sao toolbar de LINHA
139: *   da grade, cmdSair/Cancela sao saida), igual ao irmao
140: *   FormSigOpTrf.prg. Inventar os 4 metodos genericos delegando para
141: *   estes 4 reais violaria a regra do pipeline sobre alias CRUD que
142: *   dispara transacao real sob nome enganoso (aqui NENHUM dos 4 nomes
143: *   genericos corresponde a um botao de verdade, entao nem o alias
144: *   inerte se justifica - eh pura invencao de API que o legado nao tem).
145: *
146: *   cmdInserir/cmdExcluir usam o prefixo "Cmd" (nao "Btn"), mesma
147: *   convencao do irmao FormSigOpTrf.prg (CmdInserirClick/CmdExcluirClick
148: *   la tambem operam linha de grade, nao CRUD). cmdSair ("Confirmar") e
149: *   Cancela ("Cancelar") usam o prefixo "Btn" (BtnSairClick no irmao;
150: *   BtnCancelarClick aqui existe porque, diferente do irmao, este
151: *   dialogo TEM um botao Cancelar de verdade no dump).
152: *
153: *   DUPLICATA (so neste form - o irmao nao tem): "Select Itras, Sum(1)
154: *   ... Group By 1 ... Having Sum(1) > 1" aborta o Confirmar com
155: *   MessageBox ANTES de tocar no banco - "Return .f." no legado, que
156: *   SAI do metodo sem reabilitar o pai nem fechar o dialogo (regra #17 -
157: *   transcrever o early-exit, nao so a mensagem).
158: *
159: *   "GravaDados = .t." no cmdExcluir.Click do legado fica FORA do "If
160: *   Not Eof()" - sempre marcado, mesmo clicando Excluir com a grade
161: *   vazia (regra #17 - nao "corrigir" a assimetria do legado).
162: *
163: * FASE 6: lookup de celula da coluna "Transportadora"
164: *
165: *   | metodo                   | conteudo |
166: *   |--------------------------|----------|
167: *   | GuardarItrasAnterior()   | PUBLIC, legado: GradeOpe.Column1.Text1.When -> Thisform.AntValue = This.Value |
168: *   | ValidarItrasGridExec()   | PUBLIC, legado: Column1.Text1.Valid - vazio limpa, senao delega ao lookup |
169: *   | AbrirLookupItras()       | PUBLIC, funil com guarda de reentrancia (regra #47) |
170: *   | AbrirLookupItrasExec()   | PROTECTED, fwbuscaext em SigPrTrp -> FormBuscaAuxiliar (regra #37) |
171: *
172: *   TextBoxTransportadoraTrp_4c (classes\textboxgridlookup.PRG) instalada em
173: *   Column1 por AplicarFormatoGrade (AddObject + CurrentControl + Sparse,
174: *   regra #18/#46) - When/Valid/KeyPress(F4,F5)/DblClick da classe delegam
175: *   para os 4 metodos acima. Sem recusa de duplicata (diferente do irmao
176: *   TextBoxOperacaoTrf_4c de FormSigOpTrf): o legado deste dialogo nao
177: *   confere Itras repetido entre as linhas de xOpe.
178: *
179: * FASE 4: a grade + os 4 botoes + carga inicial
180: *
181: *   | metodo                | conteudo |
182: *   |------------------------|----------|
183: *   | ConfigurarGrade()      | grd_4c_Dados (GradeOpe) - so o que nao depende de dado (regra #41) |
184: *   | AplicarFormatoGrade()  | PUBLIC, FONTE UNICA de Column.Width/Header1.Caption - reaplicada por CarregarLista (Problema 48) |
185: *   | ConfigurarBotoes()     | cmd_4c_CmdInserir/CmdExcluir/CmdSair/Cancela, nesta ordem (dump) |
186: *   | CarregarLista()        | PUBLIC, funil: BO.CarregarItens() + bind do grid + GO TOP + Refresh |
187: *
188: *   grd_4c_Dados eh EDITAVEL (sem ReadOnly = .T. no grid nem na Column1 -
189: *   diferente do irmao SOMENTE LEITURA FormSigOpTop): cmdInserir insere
190: *   linha em branco e o usuario digita o codigo da transportadora
191: *   (Column1/Itras). Column2 (Razaos) recebe .ReadOnly = .T.: o legado
192: *   bloqueia a edicao com "Column2.Text1.When / Return .f." - efeito
193: *   estrutural equivalente, sem calculo nenhum ali (mesmo raciocinio do
194: *   col_dpros de FormSigOpTrf).
195: *
196: *   Header1.ForeColor = RGB(36, 84, 155) nas DUAS colunas eh TRANSCRITO do
197: *   dump (Sigoptrp_form_codigo_fonte.txt declara ForeColor = 36,84,155 nos
198: *   dois Header1) - NAO eh o canonico cinza (90,90,90) que se usa quando o
199: *   dump OMITE a propriedade (regra #12); aqui o legado declara
200: *   explicitamente, e o literal prevalece.
201: *
202: *   Os 4 botoes (cmdInserir/cmdExcluir/cmdSair/Cancela) sao fwbtng no SCX
203: *   (Width/Height nao constam do dump - canonico 75x75 de icone 60px,
204: *   mesma convencao dos irmaos desta familia). 725 + 75 = 800 = Form.Width
205: *   (fecha exatamente na borda). Todos ficam dentro da faixa do cabecalho
206: *   (Top 4..79, dentro de Top 0..80 de cnt_4c_Cabecalho) e por isso sao
207: *   criados DEPOIS dela em InicializarForm, igual ao SCX (regra #11).
208: *
209: *   NENHUM BINDEVENT de Click nesta fase: ControlBox = .F. mas sem
210: *   Closable/MinButton declarados (regra closable_inventado_tira_a_unica_
211: *   saida), o Alt+F4 continua disponivel como saida enquanto os botoes nao
212: *   estao cablados - mesma decisao do irmao FormSigOpTrf (que tem mais de
213: *   um botao). cmd_4c_Cancela.Cancel = .T. (transcrito do dump) so ativa o
214: *   ESC quando o Click correspondente existir (Fase 7); nao chama Click
215: *   nenhum por si so.
216: *
217: *   A carga inicial (CarregarLista) e pulada em modo teste/validacao de UI
218: *   (padrao FormSigOpTrf/FormSigOpTop): sem gnConnHandle nem operacao, a
219: *   consulta so produziria ruido de erro no log do harness. O grid fica
220: *   vazio, com as colunas ja formatadas por AplicarFormatoGrade.
221: *
222: * FASE 5: NAO SE APLICA a este form - sem stub vazio
223: *   O roteiro padrao pede ConfigurarPaginaDados() com cnt_4c_Cabecalho +
224: *   metade dos TextBoxes/Labels da Page2. Este form NAO TEM Page2/PageFrame
225: *   (eh FLAT, igual ao legado - zero "BaseClass: pageframe" no dump,
226: *   confirmado em layout.json/totalObjects=15) e o SCX nao declara NENHUM
227: *   TextBox FORA da grade: os 15 objetos do dump
228: *   (Sigoptrp_form_codigo_fonte.txt / layout.json) sao cntSombra + 2
229: *   labels, GradeOpe (2 Column, cada uma so com Header1+Text1) e os 4
230: *   botoes (cmdInserir/cmdExcluir/cmdSair/Cancela) - confirmado tambem em
231: *   analise.json ("campos": []). Os unicos controles de entrada de dado
232: *   sao os Text1 de GradeOpe.Column1/Column2 (Itras/Razaos), com Parent
233: *   terminando em ".ColumnN" (perfil GRADE+BOTOES, nao DESPACHANTE) - ja
234: *   criados em ConfigurarGrade/AplicarFormatoGrade, Fase 4, nao TextBoxes
235: *   soltos numa pagina de dados.
236: *
237: *   Repetir o roteiro aqui seria (a) duplicar cnt_4c_Cabecalho, que
238: *   ConfigurarPageFrame ja criou -> "object already exists" (regra #11/
239: *   CLAUDE.md), e (b) inventar campos digitaveis que o legado nao tem
240: *   (REGRA FUNDAMENTAL - proibido inventar UI). Um metodo
241: *   ConfigurarPaginaDados() vazio so para "cumprir o roteiro" seria o stub
242: *   disfarcado que a regra de completude proibe. Mesma decisao documentada
243: *   no cabecalho de FormSigOpTrf.prg/FormSigOpTop.prg (familia SigOp*).
244: *
245: * FASE 3: estrutura base do form
246: *   - Propriedades que espelham o contexto recebido do form pai
247: *     (this_oFormPai/this_cDopes/this_nDataSessionPai), o estado dos
248: *     lookups de celula (Fase 6 - this_cValorAnteriorItras/
249: *     this_lEmLookupItras) e o estado de edicao (Fase 7/8 -

*-- Linhas 255 a 326:
255: *     mesma convencao do irmao FormSigOpTrf.prg) + ValidarParametros
256: *     (precondicao: sem form pai e sem operacao de origem nao ha o que
257: *     editar).
258: *   - InicializarForm (cria o BO, desabilita o form pai, monta o Caption,
259: *     aplica o fundo e cria o cabecalho cinza). Grade/botoes/carga agora na
260: *     Fase 4 (ver acima).
261: *   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f.).
262: *   - ConfigurarDecoracao (Picture do form - new_background.jpg).
263: *   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; nome do
264: *     metodo mantido por paridade com os demais dialogos filhos desta
265: *     familia, mesmo sem PageFrame real: este form eh FLAT, igual ao
266: *     legado - SIGOPTRP nao tem PageFrame no SCX, so form + cntSombra +
267: *     1 grid + 4 botoes).
268: *   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
269: *     rede de seguranca, igual ao cmdSair.Click do legado; fecha tambem o
270: *     cursor de trabalho do BO, se ja estiver aberto).
271: *==============================================================================
272: 
273: DEFINE CLASS FormSigoptrp AS FormBase
274: 
275:     *--------------------------------------------------------------------------
276:     * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
277:     *--------------------------------------------------------------------------
278: 
279:     *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
280:     *-- de Operacoes do Caixa) que abriu este dialogo
281:     this_cMensagemErro = ""
282:     this_oFormPai = .NULL.
283: 
284:     *-- crSigCdOpe.Dopes do legado - codigo da operacao cujas
285:     *-- transportadoras habilitadas serao editadas. Repassado ao BO em
286:     *-- InicializarForm (THIS.this_oBusinessObject.this_cDopes)
287:     this_cDopes = ""
288: 
289:     *-- pnDataSes do legado - informativo (DataSession = 1 ja unifica a
290:     *-- sessao com o pai, ver comentario de DataSession abaixo)
291:     this_nDataSessionPai = 0
292: 
293:     *--------------------------------------------------------------------------
294:     * ESTADO DO LOOKUP DE CELULA (FASE 6) - ver AplicarFormatoGrade
295:     * (instalacao do TextBox customizado) e os metodos GuardarItrasAnterior/
296:     * ValidarItrasGridExec/AbrirLookupItras/AbrirLookupItrasExec.
297:     *--------------------------------------------------------------------------
298: 
299:     *-- Legado: Thisform.AntValue - snapshot do valor da celula
300:     *-- "Transportadora" ANTES da edicao (GradeOpe.Column1.Text1.When),
301:     *-- usado pela validacao para saber se o usuario realmente mudou o
302:     *-- codigo digitado
303:     this_cValorAnteriorItras = ""
304: 
305:     *-- Guarda de reentrancia (regra #47): o picker eh MODAL, tira o foco
306:     *-- da celula e redispara o proprio Valid/KeyPress que o chamou
307:     this_lEmLookupItras = .F.
308: 
309:     *--------------------------------------------------------------------------
310:     * ESTADO DE EDICAO (FASE 7/8)
311:     *--------------------------------------------------------------------------
312: 
313:     *-- Legado: ThisForm.GravaDados (property customizada do SCX - ver
314:     *-- RESERVED3/ClassInfo no fim do dump: antvalue/gravadados/
315:     *-- parentform/podatamgr). Ligada por TODO caminho que muda a lista de
316:     *-- transportadoras (os 2 botoes de grade e o Valid da celula) e LIDA
317:     *-- pelo cmdSair.Click ("If ThisForm.GravaDados") para decidir se o
318:     *-- lote precisa ser regravado.
319:     *--
320:     *-- DECLARACAO OBRIGATORIA, nao decorativa (mesmo raciocinio do
321:     *-- cabecalho de FormSigOpTrf.prg): a property do FORM eh a fonte da
322:     *-- verdade, NAO a do BO (this_oBusinessObject.this_lDadosAlterados) -
323:     *-- BusinessBase.NovoRegistro()/Salvar() zerariam a do BO a cada linha
324:     *-- gravada, perdendo o flag no meio do proprio lote de gravacao em
325:     *-- lote do Confirmar.
326:     this_lDadosAlterados = .F.

*-- Linhas 337 a 646:
337: 
338:     *-- Caption do SCX ("Tabelas de Desconto" - literal estatico do Form
339:     *-- Designer, nunca chega a ser exibido) - sobrescrito em
340:     *-- InicializarForm com o codigo da operacao, igual ao legado
341:     *-- (.Caption = 'Transportadoras ' + AllTrim(crSigCdOpe.Dopes))
342:     Caption = "Tabelas de Desconto"
343: 
344:     *-- ControlBox = .F. / Movable = .F. / TitleBar = 0 / ClipControls = .F.
345:     *-- - literais do dump. MaxButton/Closable/MinButton NAO declarados no
346:     *-- SCX -> NAO inventar (regra closable_inventado_tira_a_unica_saida):
347:     *-- o default .T. deixa o Alt+F4 funcionando, que eh uma das saidas
348:     *-- alem do Confirmar/Cancelar (sem barra de titulo nao ha X na
349:     *-- janela, so o ControlBox = .F. remove o icone de sistema)
350:     ControlBox   = .F.
351:     Movable      = .F.
352:     TitleBar     = 0
353:     ClipControls = .F.
354: 
355:     *-- AutoCenter = .T. do SCX - centraliza na tela, sem calculo manual
356:     *-- de posicao relativa ao pai
357:     AutoCenter = .T.
358: 
359:     *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
360:     *-- Show() bloqueie ate o usuario Confirmar/Cancelar (legado:
361:     *-- .ParentForm.Enabled = .f. enquanto este form esta aberto, emulando
362:     *-- modalidade)
363:     WindowType = 1
364: 
365:     *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
366:     ShowWindow = 1
367: 
368:     *-- Fonte base (os controles do cabecalho declaram a propria fonte -
369:     *-- Tahoma 16 - transcrita em ConfigurarPageFrame)
370:     FontName = "Tahoma"
371:     FontSize = 8
372: 
373:     *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
374:     *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
375:     *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
376:     *-- SEMPRE na sessao do form pai. DataSession = 1 eh a reproducao
377:     *-- direta desse resultado, sem a troca manual de sessao - mesmo
378:     *-- padrao adotado em FormSigOpTrf.prg/FormSigOpTop.prg/
379:     *-- FormSIGOPTOR.prg/FormSigOpTot.prg
380:     DataSession = 1
381: 
382:     *==========================================================================
383:     * Init - LParameters poForm, pnDataSes do legado (com 1 parametro
384:     * extra - par_cDopes - necessario porque o migrado nao troca de
385:     * DataSession para ler crSigCdOpe.Dopes direto do cursor do pai; mesma
386:     * convencao dos dialogos irmaos desta familia).
387:     *==========================================================================
388:     PROCEDURE Init
389:         LPARAMETERS par_oFormPai, par_cDopes, par_nDataSessionPai
390: 
391:         IF VARTYPE(par_oFormPai) = "O"
392:             THIS.this_oFormPai = par_oFormPai
393:         ENDIF
394: 
395:         THIS.this_cDopes          = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
396:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
397: 
398:         *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
399:         *-- seguida THIS.InicializarForm()
400:         RETURN DODEFAULT()
401:     ENDPROC
402: 
403:     *==========================================================================
404:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
405:     * quem reabilitar, e sem operacao nao ha transportadora nenhuma para
406:     * editar (o legado tambem depende dessas referencias em todo o Init -
407:     * crSigCdOpe.Dopes/ThisForm.ParentForm.*).
408:     *
409:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
410:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
411:     *
412:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
413:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
414:     * bypass a instanciacao reprovaria sempre.
415:     *
416:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
417:     * bloco algum.
418:     *==========================================================================
419:     PROCEDURE ValidarParametros
420:         LOCAL loc_lValido
421:         loc_lValido = .T.
422: 
423:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
424:             RETURN .T.
425:         ENDIF
426: 
427:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
428:             RETURN .T.
429:         ENDIF
430: 
431:         IF VARTYPE(THIS.this_oFormPai) != "O"
432:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
433:                     "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
434:                     "Transportadoras")
435:             loc_lValido = .F.
436:         ENDIF
437: 
438:         IF EMPTY(THIS.this_cDopes)
439:             MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
440:                     "Transportadoras")
441:             loc_lValido = .F.
442:         ENDIF
443: 
444:         RETURN loc_lValido
445:     ENDPROC
446: 
447:     *==========================================================================
448:     * InicializarForm - estrutura base do dialogo
449:     *
450:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
451:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
452:     *
453:     * Grade/botoes/carga inicial ficam para a Fase 4 (os metodos
454:     * ConfigurarGradeOperacoes/ConfigurarBotoes/CarregarLista ainda nao
455:     * existem nesta fase) - a Fase 4 acrescenta as chamadas correspondentes
456:     * aqui, apos THIS.ConfigurarPageFrame().
457:     *==========================================================================
458:     PROTECTED PROCEDURE InicializarForm
459:         LOCAL loc_lSucesso, loc_oErro
460:         loc_lSucesso = .F.
461: 
462:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
463:         *-- dentro de TRY/CATCH (regra #1)
464:         IF !THIS.ValidarParametros()
465:             RETURN .F.
466:         ENDIF
467: 
468:         TRY
469:             *-- Business Object das Fases 1-2
470:             THIS.this_oBusinessObject = CREATEOBJECT("SigoptrpBO")
471: 
472:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
473:                 MsgErro("Falha ao criar SigoptrpBO.", "Transportadoras")
474:             ELSE
475:                 *-- Contexto no BO (operacao - this_cDopes do BO eh a
476:                 *-- mesma property declarada em SigoptrpBO.prg)
477:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
478: 
479:                 *-- Legado: .ParentForm.Enabled = .f.
480:                 THIS.CarregarContextoFormPai()
481: 
482:                 *-- Legado: .Caption = 'Transportadoras ' +
483:                 *-- AllTrim(crSigCdOpe.Dopes)
484:                 THIS.Caption = "Transportadoras " + ALLTRIM(THIS.this_cDopes)
485: 
486:                 THIS.this_oBusinessObject.this_cTituloDialogo = THIS.Caption
487: 
488:                 *-- Fundo do form (Picture do SCX)
489:                 THIS.ConfigurarDecoracao()
490: 
491:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
492:                 *-- AddObject do form, igual ao SCX
493:                 THIS.ConfigurarPageFrame()
494: 
495:                 *-- GradeOpe, depois os 4 botoes - nesta ordem (dump).
496:                 *-- Os botoes ficam DENTRO da faixa do cabecalho
497:                 *-- (Top 4..79) e por isso sao criados DEPOIS dela
498:                 THIS.ConfigurarGrade()
499:                 THIS.ConfigurarBotoes()
500: 
501:                 *-- FASE 7: Click dos 4 botoes. DEPOIS dos AddObject -
502:                 *-- sem o controle criado, o BINDEVENT estouraria no bind
503:                 THIS.ConfigurarBINDEVENTs()
504: 
505:                 *-- AddObject cria controle com Visible = .F.
506:                 THIS.TornarControlesVisiveis(THIS)
507: 
508:                 *-- Legado: o Init termina consultando SigOpTrp/SigPrTrp e
509:                 *-- ligando a grade ao resultado. Pulado em modo
510:                 *-- teste/validacao de UI (padrao FormSigOpTrf/
511:                 *-- FormSigOpTop): la nao ha gnConnHandle nem operacao,
512:                 *-- entao a carga so produziria ruido de erro no log do
513:                 *-- harness. A grade fica vazia, com as colunas ja
514:                 *-- formatadas por AplicarFormatoGrade. O harness chama
515:                 *-- CarregarLista de fora quando quer exercita-la
516:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) AND ;
517:                    !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
518:                     THIS.CarregarLista()
519:                 ENDIF
520: 
521:                 loc_lSucesso = .T.
522:             ENDIF
523: 
524:         CATCH TO loc_oErro
525:             THIS.this_cMensagemErro = loc_oErro.Message
526:             MsgErro("Erro ao inicializar FormSigoptrp: " + loc_oErro.Message + ;
527:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
528:                     " | Procedure: " + loc_oErro.Procedure, "Erro")
529:             loc_lSucesso = .F.
530:         ENDTRY
531: 
532:         RETURN loc_lSucesso
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * CarregarContextoFormPai - migra para o form o que o Init legado faz
537:     * com o form pai:
538:     *
539:     *     ThisForm.ParentForm = poForm
540:     *     ThisForm.ParentForm.Enabled = .f.
541:     *
542:     * (crSigCdOpe.Dopes ja foi recebido via parametro no Init deste form -
543:     * ver cabecalho do arquivo). Protegido por PEMSTATUS/VARTYPE: em modo
544:     * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
545:     * ou um stub sem essa property, e a ausencia aqui NAO eh falha de
546:     * inicializacao (ValidarParametros ja fez o bypass acima).
547:     *==========================================================================
548:     PROTECTED PROCEDURE CarregarContextoFormPai
549:         IF VARTYPE(THIS.this_oFormPai) = "O"
550:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
551:                 THIS.this_oFormPai.Enabled = .F.
552:             ENDIF
553:         ENDIF
554:     ENDPROC
555: 
556:     *==========================================================================
557:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
558:     *==========================================================================
559:     PROTECTED PROCEDURE ConfigurarDecoracao
560:         LOCAL loc_cImagemFundo
561:         loc_cImagemFundo = ""
562: 
563:         IF TYPE("gc_4c_CaminhoIcones") = "C"
564:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
565:         ENDIF
566: 
567:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
568:             THIS.Picture = loc_cImagemFundo
569:         ENDIF
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * ConfigurarPageFrame - cntSombra do legado -> cnt_4c_Cabecalho. Nome do
574:     * metodo mantido por paridade com os demais dialogos filhos desta
575:     * familia (FormSigOpTrf.prg/FormSigOpTop.prg/FormSIGOPTOR.prg/
576:     * FormSigOpTot.prg usam o mesmo nome), mesmo sem PageFrame real - este
577:     * form eh FLAT, igual ao legado (SIGOPTRP nao tem PageFrame no SCX).
578:     *
579:     * Transcricao do dump (Sigoptrp_form_codigo_fonte.txt):
580:     *   cntSombra  Top=0  Left=-1  Width=800  Height=80  BorderWidth=0
581:     *              BackColor=100,100,100
582:     *   lblSombra  Top=25 Left=10 Width=769 Height=40 ForeColor=0,0,0
583:     *              Tahoma 16 bold, FontUnderline=.F., WordWrap=.T.,
584:     *              Alignment=0, BackStyle=0
585:     *   lblTitulo  Top=24 Left=10 Width=769 Height=46 ForeColor=255,255,255
586:     *              Tahoma 16 bold, WordWrap=.T., Alignment=0, BackStyle=0
587:     *
588:     * O Init legado sobrescreve os dois Caption com ThisForm.Caption
589:     * ("Transportadoras <operacao>"), por isso .Caption = THIS.Caption
590:     * (dinamico) - o literal do dump ("Cadastro de Testes") eh so o default
591:     * do Form Designer, nunca chega a ser exibido.
592:     *
593:     * Width do container usa THIS.Width (padrao canonico da faixa, regra
594:     * #11), igual ao literal do dump (800 = Form.Width, sem divergencia
595:     * aqui - diferente do irmao FormSigOpTrf, onde o SCX declarava o
596:     * container mais largo que o form). Os labels usam THIS.Width - 20,
597:     * mesma margem de 10px dos dois lados aplicada pelos irmaos
598:     * FormSigOpTrf.prg/FormSigOpTop.prg (o literal 769 do dump extrapolaria
599:     * os 800px do form se usado ao pe da letra com Left=10).
600:     *
601:     * AutoSize = .F. explicito nos dois labels: com WordWrap = .T. o
602:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
603:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form
604:     * Designer.
605:     *==========================================================================
606:     PROTECTED PROCEDURE ConfigurarPageFrame
607:         *-- Container da faixa (cntSombra)
608:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
609:         WITH THIS.cnt_4c_Cabecalho
610:             .Top           = 0
611:             .Left          = 0
612:             .Width         = THIS.Width
613:             .Height        = 80
614:             .BorderWidth   = 0
615:             .BackStyle     = 1
616:             .BackColor     = RGB(100, 100, 100)
617:             .SpecialEffect = 0
618:             .Visible       = .T.
619:         ENDWITH
620: 
621:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
622:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
623:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
624:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
625:             .AutoSize      = .F.
626:             .FontBold      = .T.
627:             .FontName      = "Tahoma"
628:             .FontSize      = 16
629:             .FontUnderline = .F.
630:             .WordWrap      = .T.
631:             .Alignment     = 0
632:             .BackStyle     = 0
633:             .Caption       = THIS.Caption
634:             .Top           = 25
635:             .Left          = 10
636:             .Width         = THIS.Width - 20
637:             .Height        = 40
638:             .ForeColor     = RGB(0, 0, 0)
639:             .Rotation      = 0
640:             .Visible       = .T.
641:         ENDWITH
642: 
643:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
644:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
645:         *-- regra #12)
646:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")

*-- Linhas 686 a 729:
686:     * moram em CarregarLista. Column.Width/Header1.Caption moram em
687:     * AplicarFormatoGrade, chamada ao final.
688:     *==========================================================================
689:     PROTECTED PROCEDURE ConfigurarGrade
690:         THIS.AddObject("grd_4c_Dados", "Grid")
691:         WITH THIS.grd_4c_Dados
692:             .ColumnCount   = 2
693:             .FontName      = "Tahoma"
694:             .FontSize      = 8
695:             .Top           = 87
696:             .Left          = 236
697:             .Height        = 307
698:             .Width         = 313
699:             .RowHeight     = 16
700:             .ScrollBars    = 2
701:             .TabIndex      = 1
702:             .DeleteMark    = .F.
703:             .RecordMark    = .F.
704:             .GridLineColor = RGB(238, 238, 238)
705:             .ForeColor     = RGB(90, 90, 90)
706:             .Visible       = .T.
707:         ENDWITH
708: 
709:         THIS.AplicarFormatoGrade()
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * AplicarFormatoGrade - FONTE UNICA da geometria das colunas da grade
714:     * (regra do Problema 48 - RecordSource zera Column.Width e
715:     * Header1.Caption, entao este metodo e chamado de novo em
716:     * CarregarLista, depois do bind).
717:     *
718:     * Transcricao do dump:
719:     *   Column1 (Itras)  - Width=80,  Movable=.F., Resizable=.F., Tahoma 8
720:     *     Header1  Tahoma 8 Alignment=2 Caption="Transportadora" ForeColor=36,84,155
721:     *     Text1    BorderStyle=0 Margin=0 ForeColor=90,90,90 BackColor=255,255,255
722:     *   Column2 (Razaos) - Width=200, Movable=.F., Resizable=.F., Tahoma 8
723:     *     Header1  Tahoma 8 Alignment=2 Caption="Descricao" ForeColor=36,84,155
724:     *     Text1    (identico ao da Column1)
725:     *
726:     * Column2 recebe .ReadOnly = .T. (grid e Text1): o legado bloqueia a
727:     * edicao com "Column2.Text1.When / Return .f." - efeito estrutural
728:     * equivalente, SOMENTE EXIBICAO, nunca persistida em SigOpTrp (so
729:     * aparece na grade via JOIN com SigPrTrp - ver cabecalho de

*-- Linhas 737 a 789:
737:     * Column1 (Itras) recebe o TextBox customizado de lookup
738:     * (TextBoxTransportadoraTrp_4c, classes\textboxgridlookup.PRG) via
739:     * Column.AddObject + CurrentControl + Sparse = .F. (regra #18) -
740:     * BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
741:     * Guard IF !PEMSTATUS(...) antes do AddObject: este metodo roda de
742:     * novo em CarregarLista (Problema 48, RecordSource reseta
743:     * Column.Width/Header1.Caption/CurrentControl) e o 2o AddObject
744:     * estouraria "Object ... is already defined".
745:     *
746:     * Metodo PUBLIC: chamado pela montagem (ConfigurarGrade) E pela
747:     * recarga (CarregarLista), e o harness de teste o alcanca de fora.
748:     *==========================================================================
749:     PROCEDURE AplicarFormatoGrade
750:         LOCAL loc_lAplicou
751:         loc_lAplicou = .F.
752: 
753:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
754:             WITH THIS.grd_4c_Dados
755:                 *-- Column1 (Itras) - "Transportadora", EDITAVEL
756:                 .Column1.Width             = 80
757:                 .Column1.Movable           = .F.
758:                 .Column1.Resizable         = .F.
759:                 .Column1.FontName          = "Tahoma"
760:                 .Column1.FontSize          = 8
761:                 .Column1.Header1.Caption   = "Transportadora"
762:                 .Column1.Header1.FontName  = "Tahoma"
763:                 .Column1.Header1.FontSize  = 8
764:                 .Column1.Header1.Alignment = 2
765:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
766:                 .Column1.Text1.BorderStyle = 0
767:                 .Column1.Text1.Margin      = 0
768:                 .Column1.Text1.FontName    = "Tahoma"
769:                 .Column1.Text1.FontSize    = 8
770:                 .Column1.Text1.ForeColor   = RGB(90, 90, 90)
771:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
772: 
773:                 *-- Lookup de transportadora (legado: GradeOpe.Column1.
774:                 *-- Text1.Valid/When, fwbuscaext contra SigPrTrp pela chave
775:                 *-- Itras)
776:                 IF !PEMSTATUS(.Column1, "txt_4c_CelItras", 5)
777:                     .Column1.AddObject("txt_4c_CelItras", "TextBoxTransportadoraTrp_4c")
778:                 ENDIF
779:                 .Column1.CurrentControl = "txt_4c_CelItras"
780:                 .Column1.Sparse         = .F.
781:                 .Column1.ReadOnly       = .F.
782: 
783:                 *-- Column2 (Razaos) - "Descricao", SOMENTE EXIBICAO
784:                 *-- (legado: Column2.Text1.When retorna .F.)
785:                 .Column2.Width             = 200
786:                 .Column2.Movable           = .F.
787:                 .Column2.Resizable         = .F.
788:                 .Column2.FontName          = "Tahoma"
789:                 .Column2.FontSize          = 8

*-- Linhas 823 a 882:
823:     *
824:     * Todos os 4 ficam dentro da faixa do cabecalho (Top 4..79, dentro de
825:     * Top 0..80 de cnt_4c_Cabecalho) e por isso sao criados DEPOIS dela em
826:     * InicializarForm, igual ao SCX (regra #11).
827:     *
828:     * Themes = .T. + DisabledPicture: standalone CommandButton com Picture
829:     * exige isso para desenhar o icone (regra #99). Picture so eh
830:     * atribuido se o arquivo existir - .Picture inexistente falha em
831:     * SILENCIO (regra #25).
832:     *
833:     * cmd_4c_Cancela.Cancel = .T. eh transcrito do dump, mas so ativa o ESC
834:     * de fato quando o Click correspondente existir (Fase 7) - sem
835:     * BINDEVENT, a propriedade por si so nao chama Click nenhum.
836:     *
837:     * NENHUM BINDEVENT de Click aqui - fica para a Fase 7 (ver cabecalho
838:     * do arquivo). ControlBox = .F. mas sem Closable/MinButton declarados
839:     * (regra closable_inventado_tira_a_unica_saida): o Alt+F4 continua
840:     * disponivel como saida enquanto os botoes nao estao cablados.
841:     *==========================================================================
842:     PROTECTED PROCEDURE ConfigurarBotoes
843:         LOCAL loc_cIconeInserir, loc_cIconeExcluir, loc_cIconeConfirmar, loc_cIconeCancelar
844:         loc_cIconeInserir   = ""
845:         loc_cIconeExcluir   = ""
846:         loc_cIconeConfirmar = ""
847:         loc_cIconeCancelar  = ""
848: 
849:         IF TYPE("gc_4c_CaminhoIcones") = "C"
850:             loc_cIconeInserir   = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
851:             loc_cIconeExcluir   = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
852:             loc_cIconeConfirmar = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
853:             loc_cIconeCancelar  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
854:         ENDIF
855: 
856:         *-- cmdInserir -> cmd_4c_CmdInserir (linha nova em xOpe)
857:         THIS.AddObject("cmd_4c_CmdInserir", "CommandButton")
858:         WITH THIS.cmd_4c_CmdInserir
859:             .Top          = 4
860:             .Left         = 500
861:             .Width        = 75
862:             .Height       = 75
863:             .Caption      = "\<Inserir"
864:             .TabIndex     = 4
865:             .FontName     = "Comic Sans MS"
866:             .FontSize     = 8
867:             .FontBold     = .T.
868:             .FontItalic   = .T.
869:             .WordWrap     = .T.
870:             .AutoSize     = .F.
871:             .ForeColor    = RGB(90, 90, 90)
872:             .BackColor    = RGB(255, 255, 255)
873:             .MousePointer = 15
874:             .Themes       = .T.
875: 
876:             IF !EMPTY(loc_cIconeInserir) AND FILE(loc_cIconeInserir)
877:                 .Picture         = loc_cIconeInserir
878:                 .DisabledPicture = loc_cIconeInserir
879:                 .PicturePosition = 13
880:             ENDIF
881: 
882:             .Visible = .T.

*-- Linhas 972 a 1066:
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * ConfigurarBINDEVENTs - liga os 4 Click que a Fase 4 ainda nao ligava
976:     * (cmdInserir/cmdExcluir/cmdSair/Cancela). Chamado em InicializarForm
977:     * DEPOIS de ConfigurarBotoes - BINDEVENT com objeto inexistente estoura
978:     * no proprio bind.
979:     *
980:     * Handlers PUBLIC (regra #3): PROTECTED faz BINDEVENT falhar em
981:     * SILENCIO.
982:     *==========================================================================
983:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
984:         BINDEVENT(THIS.cmd_4c_CmdInserir, "Click", THIS, "CmdInserirClick")
985:         BINDEVENT(THIS.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
986:         BINDEVENT(THIS.cmd_4c_CmdSair,    "Click", THIS, "BtnSairClick")
987:         BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * CarregarLista - funil de carga da grade. Reproduz o trecho final do
992:     * Init legado:
993:     *
994:     *     With Thisform.GradeOpe
995:     *         .RecordSource          = 'xOpe'
996:     *         .Column1.ControlSource = 'xOpe.Itras'
997:     *         .Column2.ControlSource = 'xOpe.Razaos'
998:     *         .Refresh
999:     *     EndWith
1000:     *     ... (Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b ... Scan /
1001:     *     Scatter Memvar / Append Blank In xOpe / Gather Memvar) ...
1002:     *     Select xOpe / Set Order to / Go Top
1003:     *     ThisForm.GradeOpe.Refresh
1004:     *
1005:     * A consulta e a expansao moram no BO (SigoptrpBO.CarregarItens, Fases
1006:     * 1-2), que popula this_cCursorItens. Aqui fica o que eh do FORM: o
1007:     * binding, a reaplicacao de formato e a repintura.
1008:     *
1009:     * Tres cuidados do projeto, todos presentes no legado ou exigidos por
1010:     * regra:
1011:     *   1. ColumnCount e RecordSource FORA do WITH (GRID-WITH): acessar
1012:     *      .Column dentro do mesmo WITH que atribui RecordSource estoura
1013:     *      'Unknown member COLUMN1' - mesma cautela dos irmaos desta
1014:     *      familia.
1015:     *   2. AplicarFormatoGrade roda DEPOIS do RecordSource, que zera
1016:     *      Column.Width e Header1.Caption (Problema 48).
1017:     *   3. GO TOP + Refresh no fim (regra #21a): popular/ligar cursor NAO
1018:     *      repinta a grade sozinho - eh o ".Refresh" do With legado.
1019:     *
1020:     * Metodo PUBLIC (regra #3): o harness o chama de FORA da classe, sem
1021:     * argumento algum - a operacao corrente vem de THIS.this_cDopes,
1022:     * guardado no Init.
1023:     *
1024:     * RETURN unico, FORA do TRY/CATCH (regra #1).
1025:     *==========================================================================
1026:     PROCEDURE CarregarLista
1027:         LOCAL loc_lCarregou, loc_cAlias, loc_oErro
1028:         loc_lCarregou = .F.
1029: 
1030:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1031:             RETURN .F.
1032:         ENDIF
1033: 
1034:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1035:             RETURN .F.
1036:         ENDIF
1037: 
1038:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens
1039: 
1040:         IF VARTYPE(loc_cAlias) != "C" OR EMPTY(loc_cAlias)
1041:             RETURN .F.
1042:         ENDIF
1043: 
1044:         TRY
1045:             *-- Legado: Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
1046:             *-- Where a.Dopes=... And a.Itras=b.Itras / Scan+Scatter+Append
1047:             IF THIS.this_oBusinessObject.CarregarItens() AND USED(loc_cAlias)
1048: 
1049:                 THIS.grd_4c_Dados.ColumnCount  = 2
1050:                 THIS.grd_4c_Dados.RecordSource = loc_cAlias
1051: 
1052:                 WITH THIS.grd_4c_Dados
1053:                     .Column1.ControlSource = loc_cAlias + ".Itras"
1054:                     .Column2.ControlSource = loc_cAlias + ".Razaos"
1055:                 ENDWITH
1056: 
1057:                 *-- Reaplica largura/cabecalho, que o RecordSource zerou
1058:                 THIS.AplicarFormatoGrade()
1059: 
1060:                 *-- Legado: Select xOpe / Set Order to / Go Top / .Refresh
1061:                 SELECT (loc_cAlias)
1062:                 GO TOP
1063:                 THIS.grd_4c_Dados.Refresh()
1064: 
1065:                 loc_lCarregou = .T.
1066:             ELSE

*-- Linhas 1077 a 1138:
1077:             THIS.this_cMensagemErro = loc_oErro.Message
1078:             MsgErro("Erro ao carregar as transportadoras: " + loc_oErro.Message + ;
1079:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1080:                     " | Procedure: " + loc_oErro.Procedure, THIS.Caption)
1081:             loc_lCarregou = .F.
1082:         ENDTRY
1083: 
1084:         RETURN loc_lCarregou
1085:     ENDPROC
1086: 
1087:     *==========================================================================
1088:     * GuardarItrasAnterior - snapshot do valor da celula "Transportadora"
1089:     * ANTES da edicao (legado: GradeOpe.Column1.Text1.When -> Thisform.
1090:     * AntValue = This.Value). Usado por ValidarItrasGridExec/pela classe
1091:     * TextBoxTransportadoraTrp_4c (classes\textboxgridlookup.PRG) - nesta
1092:     * tela o valor anterior fica so para paridade estrutural com o legado,
1093:     * ja que o Valid daqui (diferente do irmao SigOpTrf) nao compara
1094:     * contra ele (regra #17 - o legado nao faz essa comparacao aqui).
1095:     *
1096:     * PUBLIC: chamado de fora da classe (THISFORM) pelo TextBox da coluna.
1097:     *==========================================================================
1098:     PROCEDURE GuardarItrasAnterior(par_oTxt)
1099:         IF VARTYPE(par_oTxt) = "O"
1100:             THIS.this_cValorAnteriorItras = par_oTxt.Value
1101:         ENDIF
1102:     ENDPROC
1103: 
1104:     *==========================================================================
1105:     * ValidarItrasGridExec - Valid da celula "Transportadora" (Column1) de
1106:     * grd_4c_Dados. par_oTxt eh o TextBox da coluna (regra #46): dentro do
1107:     * Valid, o valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao
1108:     * cursor.
1109:     *
1110:     * Equivalente ao legado (GradeOpe.Column1.Text1.Valid):
1111:     *   If Not Empty(This.Value)
1112:     *       <lookup fwbuscaext em SigPrTrp, delegado abaixo>
1113:     *   Else
1114:     *       This.Value = ''
1115:     *   EndIf
1116:     *   This.Refresh
1117:     *
1118:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1119:     *==========================================================================
1120:     FUNCTION ValidarItrasGridExec(par_oTxt)
1121:         IF VARTYPE(par_oTxt) != "O"
1122:             RETURN .T.
1123:         ENDIF
1124: 
1125:         *-- Legado: If Not Empty(This.Value) ... Else This.Value = ''
1126:         IF EMPTY(ALLTRIM(par_oTxt.Value))
1127:             par_oTxt.Value = ""
1128:         ELSE
1129:             THIS.AbrirLookupItras(par_oTxt)
1130:         ENDIF
1131: 
1132:         *-- Legado: This.Refresh (fora do If/Else, sempre executado)
1133:         par_oTxt.Refresh()
1134: 
1135:         RETURN .T.
1136:     ENDFUNC
1137: 
1138:     *==========================================================================

*-- Linhas 1146 a 1242:
1146:     *
1147:     * PUBLIC: chamado de fora da classe pelo TextBox da coluna.
1148:     *==========================================================================
1149:     PROCEDURE AbrirLookupItras(par_oTxt)
1150:         IF THIS.this_lEmLookupItras
1151:             RETURN
1152:         ENDIF
1153: 
1154:         THIS.this_lEmLookupItras = .T.
1155:         THIS.AbrirLookupItrasExec(par_oTxt)
1156:         THIS.this_lEmLookupItras = .F.
1157:     ENDPROC
1158: 
1159:     *==========================================================================
1160:     * AbrirLookupItrasExec - corpo do lookup de transportadora. Equivalente
1161:     * ao legado:
1162:     *
1163:     *   loLista = CreateObject('fwbuscaext', <conn>, 'SigPrTrp',
1164:     *       'CrListaRemota', 'Itras', This.Value, 'Selecao', .t.)
1165:     *   If Not loLista.plAchouRegistro
1166:     *       loLista.mAddColuna('Itras', '', 'Transportadora', .t.)
1167:     *       loLista.mAddColuna('Razaos', '', 'Descricao', .t.)
1168:     *       loLista.Show()
1169:     *   EndIf
1170:     *   This.Value = CrListaRemota.Itras
1171:     *   Replace Razaos with CrListaRemota.Razaos In xOpe
1172:     *   Use In CrListaRemota
1173:     *
1174:     * Migrado: FormBuscaAuxiliar direto contra SigPrTrp (regra #37), que ja
1175:     * tenta o match exato antes de abrir o picker (regra #37 - Init testa
1176:     * this_lAchouRegistro). Achando (exato ou pelo picker), grava o codigo
1177:     * na celula E a descricao na MESMA linha de this_cCursorItens (xOpe) -
1178:     * "Replace Razaos with CrListaRemota.Razaos In xOpe" eh direto no
1179:     * cursor local, sem FormParaBO/BOParaForm (ainda nao existem nesta
1180:     * fase). Cancelar (ESC) ou nao selecionar nada LIMPA a celula, igual ao
1181:     * legado - This.Value = CrListaRemota.Itras sempre executa no legado, e
1182:     * sem selecao o cursor fica sem linha corrente (equivale a limpar,
1183:     * mesmo raciocinio do irmao AbrirLookupOperacaoTrfGradeExec de
1184:     * FormSigOpTrf.prg).
1185:     *==========================================================================
1186:     PROTECTED PROCEDURE AbrirLookupItrasExec(par_oTxt)
1187:         LOCAL loc_cValorDigitado, loc_oBusca, loc_oErro, loc_cCodigoResolvido, ;
1188:               loc_cDescricaoResolvida, loc_cAliasItens
1189:         loc_cAliasItens = ""
1190: 
1191:         IF VARTYPE(par_oTxt) != "O"
1192:             RETURN
1193:         ENDIF
1194: 
1195:         loc_cValorDigitado = ALLTRIM(par_oTxt.Value)
1196: 
1197:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1198:             loc_cAliasItens = THIS.this_oBusinessObject.this_cCursorItens
1199:         ENDIF
1200: 
1201:         TRY
1202:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1203:                 "SigPrTrp", "cursor_4c_BuscaTransportadora", "Itras", loc_cValorDigitado, ;
1204:                 "Sele" + CHR(231) + CHR(227) + "o")
1205: 
1206:             IF VARTYPE(loc_oBusca) = "O"
1207:                 *-- Init ja tentou o match exato (regra #37) - so abre o
1208:                 *-- picker se nao achou
1209:                 IF !loc_oBusca.this_lAchouRegistro
1210:                     loc_oBusca.mAddColuna("Itras", "", "Transportadora")
1211:                     loc_oBusca.mAddColuna("Razaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1212:                     loc_oBusca.Show()
1213:                 ENDIF
1214: 
1215:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTransportadora") AND ;
1216:                    RECCOUNT("cursor_4c_BuscaTransportadora") > 0
1217:                     SELECT cursor_4c_BuscaTransportadora
1218:                     loc_cCodigoResolvido    = ALLTRIM(NVL(Itras, ""))
1219:                     loc_cDescricaoResolvida = ALLTRIM(NVL(Razaos, ""))
1220: 
1221:                     *-- Legado: This.Value = CrListaRemota.Itras
1222:                     par_oTxt.Value = loc_cCodigoResolvido
1223: 
1224:                     *-- Legado: Replace Razaos with CrListaRemota.Razaos In xOpe
1225:                     IF !EMPTY(loc_cAliasItens) AND USED(loc_cAliasItens)
1226:                         REPLACE Razaos WITH loc_cDescricaoResolvida IN (loc_cAliasItens)
1227:                     ENDIF
1228:                 ELSE
1229:                     *-- Legado: This.Value = CrListaRemota.Itras (sem
1230:                     *-- selecao, o cursor local fica sem linha corrente -
1231:                     *-- equivale a limpar a celula)
1232:                     par_oTxt.Value = ""
1233:                 ENDIF
1234: 
1235:                 loc_oBusca.Release()
1236:             ENDIF
1237:         CATCH TO loc_oErro
1238:             MsgErro(loc_oErro.Message, "FormSigoptrp.AbrirLookupItrasExec")
1239:         ENDTRY
1240: 
1241:         IF USED("cursor_4c_BuscaTransportadora")
1242:             USE IN cursor_4c_BuscaTransportadora

*-- Linhas 1255 a 1524:
1255:     *
1256:     * PUBLIC: chamado pelos handlers dos botoes desta classe.
1257:     *==========================================================================
1258:     PROCEDURE MarcarDadosAlterados
1259:         THIS.this_lDadosAlterados = .T.
1260: 
1261:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1262:             THIS.this_oBusinessObject.this_lDadosAlterados = .T.
1263:         ENDIF
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1268:     *
1269:     *     Insert Into xOpe (Itras) Values ( Space(10))
1270:     *     Select xOpe
1271:     *     ThisForm.GravaDados = .t.
1272:     *     Thisform.GradeOpe.Column1.SetFocus
1273:     *
1274:     * Insere a linha EM BRANCO na grade (so Itras, com o espacamento do
1275:     * legado) e joga o foco na celula do codigo - quem valida, resolve a
1276:     * descricao e abre o picker eh o Valid da celula (Fase 6,
1277:     * ValidarItrasGridExec).
1278:     *
1279:     * Grava SO no cursor LOCAL (this_cCursorItens). A persistencia em
1280:     * SigOpTrp eh em LOTE, no Confirmar (PersistirItens), igual ao legado.
1281:     *
1282:     * Column1.SetFocus() eh o que o legado chama ("Column1" eh o NOME
1283:     * interno da unica coluna digitavel - a API eh sempre por POSICAO,
1284:     * regra #34).
1285:     *
1286:     * O "Select xOpe" do legado nao vira efeito colateral permanente: este
1287:     * form roda na DataSession do PAI (DataSession = 1), e o alias
1288:     * anterior eh restaurado no fim para nao atrapalhar quem chamou.
1289:     *
1290:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1291:     *==========================================================================
1292:     PROCEDURE CmdInserirClick
1293:         LOCAL loc_cAliasAnterior, loc_cAlias, loc_oErro
1294: 
1295:         TRY
1296:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1297:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens
1298: 
1299:                 IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1300: 
1301:                     loc_cAliasAnterior = ALIAS()
1302: 
1303:                     *-- Legado: Insert Into xOpe (Itras) Values (Space(10))
1304:                     INSERT INTO (loc_cAlias) (Itras) VALUES (SPACE(10))
1305: 
1306:                     *-- Legado: Select xOpe
1307:                     SELECT (loc_cAlias)
1308: 
1309:                     *-- Legado: ThisForm.GravaDados = .t.
1310:                     THIS.MarcarDadosAlterados()
1311: 
1312:                     *-- Legado: Thisform.GradeOpe.Column1.SetFocus
1313:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1314:                         THIS.grd_4c_Dados.Refresh()
1315:                         THIS.grd_4c_Dados.Column1.SetFocus()
1316:                     ENDIF
1317: 
1318:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1319:                         SELECT (loc_cAliasAnterior)
1320:                     ENDIF
1321:                 ENDIF
1322:             ENDIF
1323:         CATCH TO loc_oErro
1324:             MsgErro(loc_oErro.Message + CHR(13) + ;
1325:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1326:                     "Procedure: " + loc_oErro.Procedure, ;
1327:                     "Erro em CmdInserirClick")
1328:         ENDTRY
1329:     ENDPROC
1330: 
1331:     *==========================================================================
1332:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1333:     *
1334:     *     Select xOpe
1335:     *     If Not Eof()
1336:     *         Select xOpe
1337:     *         Delete
1338:     *         Skip
1339:     *         If Eof()
1340:     *             Go Bott
1341:     *         Endif
1342:     *     Endif
1343:     *     Thisform.GradeOpe.SetFocus
1344:     *     ThisForm.GravaDados = .t.
1345:     *
1346:     * O par "Skip / If Eof() Go Bott" reposiciona o ponteiro numa linha
1347:     * VIVA depois da marcacao: com SET DELETED ON (config.prg) a linha
1348:     * excluida desaparece da grade de imediato.
1349:     *
1350:     * "ThisForm.GravaDados = .t." fica FORA do "If Not Eof()" no legado -
1351:     * SEMPRE marcado, mesmo clicando Excluir com a grade vazia.
1352:     * Transcricao literal da assimetria (regra #17) - nao se "corrige"
1353:     * aqui.
1354:     *
1355:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1356:     *==========================================================================
1357:     PROCEDURE CmdExcluirClick
1358:         LOCAL loc_cAliasAnterior, loc_cAlias, loc_oErro
1359: 
1360:         TRY
1361:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1362:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens
1363: 
1364:                 IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1365: 
1366:                     loc_cAliasAnterior = ALIAS()
1367: 
1368:                     *-- Legado: Select xOpe / If Not Eof()
1369:                     SELECT (loc_cAlias)
1370: 
1371:                     IF !EOF()
1372:                         *-- Legado: Delete / Skip / If Eof() Go Bott
1373:                         DELETE
1374:                         SKIP
1375:                         IF EOF()
1376:                             GO BOTTOM
1377:                         ENDIF
1378:                     ENDIF
1379: 
1380:                     *-- Legado: Thisform.GradeOpe.SetFocus
1381:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1382:                         THIS.grd_4c_Dados.Refresh()
1383:                         THIS.grd_4c_Dados.SetFocus()
1384:                     ENDIF
1385: 
1386:                     *-- Legado: ThisForm.GravaDados = .t. (fora do If Not
1387:                     *-- Eof())
1388:                     THIS.MarcarDadosAlterados()
1389: 
1390:                     IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1391:                         SELECT (loc_cAliasAnterior)
1392:                     ENDIF
1393:                 ENDIF
1394:             ENDIF
1395:         CATCH TO loc_oErro
1396:             MsgErro(loc_oErro.Message + CHR(13) + ;
1397:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1398:                     "Procedure: " + loc_oErro.Procedure, ;
1399:                     "Erro em CmdExcluirClick")
1400:         ENDTRY
1401:     ENDPROC
1402: 
1403:     *==========================================================================
1404:     * BtnSairClick - cmdSair.Click do legado ("Confirmar"), transcrito:
1405:     *
1406:     *   If ThisForm.GravaDados
1407:     *       Select Itras, Sum(1) as Qt From xOpe Group by 1 Into Cursor
1408:     *           Selecao where Itras <> ' ' having Sum(1) > 1
1409:     *       If Reccount('Selecao') > 0
1410:     *           MessageBox('Existem lancamentos de Transportadoras Em
1411:     *               Duplicidade!!!',0+16,'')
1412:     *           Return .f.
1413:     *       EndIf
1414:     *       <apaga tudo de SigOpTrp desta operacao e regrava uma linha
1415:     *       por Itras nao-vazio de xOpe - PersistirItens>
1416:     *       <Delete+UpDate+Commit/RollBack, com MessageBox no erro>
1417:     *   EndIf
1418:     *   Thisform.ParentForm.Enabled = .T.
1419:     *   ThisForm.Release
1420:     *
1421:     * "Return .f." do legado, achando duplicata, sai do metodo SEM chegar
1422:     * nas duas ultimas linhas - o dialogo fica ABERTO e o pai continua
1423:     * desabilitado, para o usuario corrigir a duplicata antes de sair
1424:     * (regra #17 - o early-exit eh regra de negocio, nao detalhe). Por
1425:     * isso o RETURN de saida fica FORA do TRY/CATCH (regra #1) - a
1426:     * checagem de duplicata roda DENTRO do TRY, mas so AVALIA a flag; a
1427:     * decisao de sair acontece depois do ENDTRY.
1428:     *
1429:     * "Thisform.ParentForm.Enabled = .T." roda no Destroy() deste form,
1430:     * que o Release() dispara - mesma decisao do irmao FormSigOpTrf.prg.
1431:     *
1432:     * A mensagem generica "Erro na Gravacao dos Dados!!!" do legado vai
1433:     * GUARDADA por this_lErroExibido (regra #20): ApagarItensDaOperacao/
1434:     * Inserir do BO ja exibem a propria falha com o texto do SQL Server -
1435:     * repetir aqui daria dois dialogos para o mesmo erro.
1436:     *
1437:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1438:     *==========================================================================
1439:     PROCEDURE BtnSairClick
1440:         LOCAL loc_cAlias, loc_lDuplicado, loc_lGravou, loc_lErroExibido, loc_oErro
1441: 
1442:         loc_lDuplicado   = .F.
1443:         loc_lGravou      = .T.
1444:         loc_lErroExibido = .F.
1445: 
1446:         *-- Legado: If ThisForm.GravaDados
1447:         IF THIS.this_lDadosAlterados AND VARTYPE(THIS.this_oBusinessObject) = "O"
1448: 
1449:             TRY
1450:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens
1451: 
1452:                 IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1453: 
1454:                     *-- Legado: Select Itras, Sum(1) as Qt From xOpe
1455:                     *-- Group by 1 Into Cursor Selecao where Itras <> ' '
1456:                     *-- having Sum(1) > 1
1457:                     SELECT Itras, COUNT(*) AS Qt FROM (loc_cAlias) ;
1458:                         WHERE ALLTRIM(NVL(Itras, "")) <> "" ;
1459:                         GROUP BY Itras ;
1460:                         HAVING COUNT(*) > 1 ;
1461:                         INTO CURSOR cursor_4c_Duplicadas
1462: 
1463:                     IF RECCOUNT("cursor_4c_Duplicadas") > 0
1464:                         loc_lDuplicado = .T.
1465:                     ENDIF
1466: 
1467:                     IF USED("cursor_4c_Duplicadas")
1468:                         USE IN cursor_4c_Duplicadas
1469:                     ENDIF
1470:                 ENDIF
1471: 
1472:                 IF !loc_lDuplicado
1473:                     loc_lGravou = THIS.PersistirItens()
1474: 
1475:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1476:                         loc_lErroExibido = THIS.this_oBusinessObject.this_lErroExibido
1477:                     ENDIF
1478:                 ENDIF
1479:             CATCH TO loc_oErro
1480:                 loc_lGravou      = .F.
1481:                 loc_lErroExibido = .T.
1482:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1483:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1484:                         "Procedure: " + loc_oErro.Procedure, ;
1485:                         "Erro em BtnSairClick")
1486:             ENDTRY
1487: 
1488:             *-- Legado: MessageBox('Existem lancamentos de
1489:             *-- Transportadoras Em Duplicidade!!!',0+16,'') + Return .f.
1490:             *-- - sai SEM reabilitar o pai nem fechar o dialogo
1491:             IF loc_lDuplicado
1492:                 MsgErro("Existem lan" + CHR(231) + CHR(227) + "mentos de " + ;
1493:                         "Transportadoras Em Duplicidade!!!", THIS.Caption)
1494:                 RETURN
1495:             ENDIF
1496: 
1497:             *-- Legado: = MessageBox('Erro na Gravacao dos Dados!!!',48)
1498:             *-- - so quando ninguem mais reportou (regra #20)
1499:             IF !loc_lGravou AND !loc_lErroExibido
1500:                 MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", THIS.Caption)
1501:             ENDIF
1502:         ENDIF
1503: 
1504:         *-- Legado: Thisform.ParentForm.Enabled = .T. / ThisForm.Release -
1505:         *-- a reabilitacao roda no Destroy(), que o Release() dispara
1506:         THIS.Release()
1507:     ENDPROC
1508: 
1509:     *==========================================================================
1510:     * PersistirItens - corpo do "apaga tudo e regrava" do Confirmar
1511:     * (depois da checagem de duplicata, que fica em BtnSairClick).
1512:     * Transcricao:
1513:     *
1514:     *   Select CrSigOpTrp
1515:     *   Zap
1516:     *   Select xOpe
1517:     *   Scan
1518:     *       If Not Empty(Itras)
1519:     *           Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves) ;
1520:     *               Values (crSigCdOpe.Dopes, xOpe.Itras, fUniqueIds())
1521:     *       Endif
1522:     *   EndScan
1523:     *   <UpDate('CrSigOpTrp') + Commit(), com RollBack e MessageBox no
1524:     *   erro>

*-- Linhas 1583 a 1626:
1583:             THIS.this_cMensagemErro = loc_oErro.Message
1584:             MsgErro(loc_oErro.Message + CHR(13) + ;
1585:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1586:                     "Procedure: " + loc_oErro.Procedure, ;
1587:                     "Erro em PersistirItens")
1588:         ENDTRY
1589: 
1590:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1591:             SELECT (loc_cAliasAnterior)
1592:         ENDIF
1593: 
1594:         RETURN loc_lSucesso
1595:     ENDFUNC
1596: 
1597:     *==========================================================================
1598:     * GravarUmaTransportadora - grava UMA transportadora do lote em
1599:     * SigOpTrp. Equivale ao par "Insert Into CrSigOpTrp (Dopes, Itras,
1600:     * cIdChaves) Values (...)" do cmdSair.Click legado.
1601:     *
1602:     * SEMPRE INSERT, nunca UPDATE (ver cabecalho de PersistirItens).
1603:     * this_cCidChaves vai VAZIO de proposito - Inserir() do BO chama
1604:     * fUniqueIds() (regra #22). this_cDopes vem do CONTEXTO da operacao
1605:     * (THIS.this_cDopes), NAO da coluna Dopes da linha de xOpe - igual ao
1606:     * legado (crSigCdOpe.Dopes, nao xOpe.Dopes, que nem existe
1607:     * preenchida - ver CmdInserirClick).
1608:     *
1609:     * PROTECTED: primitiva interna do lote do Confirmar.
1610:     *==========================================================================
1611:     PROTECTED FUNCTION GravarUmaTransportadora(par_cItras)
1612:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1613:             RETURN .F.
1614:         ENDIF
1615: 
1616:         THIS.this_oBusinessObject.NovoRegistro()
1617: 
1618:         THIS.this_oBusinessObject.this_cCidChaves = ""
1619:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(THIS.this_cDopes)
1620:         THIS.this_oBusinessObject.this_cItras     = IIF(VARTYPE(par_cItras) = "C", ALLTRIM(par_cItras), "")
1621:         THIS.this_oBusinessObject.this_cRazaos    = ""
1622: 
1623:         RETURN THIS.this_oBusinessObject.Salvar()
1624:     ENDFUNC
1625: 
1626:     *==========================================================================

*-- Linhas 1635 a 1714:
1635:     * parentform.enabled = .T." roda no Destroy() deste form, que o
1636:     * Release() dispara.
1637:     *
1638:     * PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness de teste.
1639:     *==========================================================================
1640:     PROCEDURE BtnCancelarClick
1641:         THIS.Release()
1642:     ENDPROC
1643: 
1644:     *==========================================================================
1645:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.
1646:     * Percorre recursivamente Controls (containers/paginas) para garantir
1647:     * que tudo que foi adicionado fique visivel.
1648:     *==========================================================================
1649:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1650:         LOCAL loc_nI, loc_oControl
1651: 
1652:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1653:             loc_oControl = par_oContainer.Controls(loc_nI)
1654:             IF VARTYPE(loc_oControl) = "O"
1655:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1656:                     loc_oControl.Visible = .T.
1657:                 ENDIF
1658:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1659:                    loc_oControl.ControlCount > 0
1660:                     THIS.TornarControlesVisiveis(loc_oControl)
1661:                 ENDIF
1662:             ENDIF
1663:         ENDFOR
1664:     ENDPROC
1665: 
1666:     *==========================================================================
1667:     * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
1668:     * cmdSair.Click/Cancela.Click fazem .ParentForm.Enabled = .t. antes do
1669:     * ThisForm.Release; aqui tambem fica como rede de seguranca para
1670:     * qualquer caminho de fechamento que nao passe pelos botoes -
1671:     * ESC/Alt+F4/erro).
1672:     *
1673:     * Fecha tambem o cursor de trabalho do BO (this_cCursorItens - ver
1674:     * cabecalho de SigoptrpBO.prg), se ja estiver aberto: nesta fase
1675:     * (estrutura base) ele ainda nao existe (a carga eh Fase 4), mas o
1676:     * guard USED() torna este bloco seguro desde ja e evita ter que
1677:     * revisitar o Destroy quando a carga for acrescentada. Como o form
1678:     * roda na DataSession do pai (DataSession = 1), deixar algum alias
1679:     * aberto poluiria a sessao compartilhada.
1680:     *
1681:     * O TABLEREVERT vai GUARDADO por CURSORGETPROP("Buffering") > 1: sem
1682:     * buffering ele nao eh no-op, dispara o erro 1586 (regra #52).
1683:     *==========================================================================
1684:     PROCEDURE Destroy
1685:         LOCAL loc_cAlias
1686: 
1687:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1688:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorItens
1689: 
1690:             IF VARTYPE(loc_cAlias) = "C" AND !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1691:                 IF CURSORGETPROP("Buffering", loc_cAlias) > 1
1692:                     TABLEREVERT(.T., loc_cAlias)
1693:                 ENDIF
1694:                 USE IN (loc_cAlias)
1695:             ENDIF
1696:         ENDIF
1697: 
1698:         IF VARTYPE(THIS.this_oFormPai) = "O"
1699:             *-- PEMSTATUS pela MESMA razao de CarregarContextoFormPai: em
1700:             *-- modo teste o "form pai" pode ser um objeto simples, sem a
1701:             *-- property Enabled. Sem a guarda, o teardown estoura
1702:             *-- "Property ENABLED is not found" depois de o dialogo ja ter
1703:             *-- fechado
1704:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
1705:                 THIS.this_oFormPai.Enabled = .T.
1706:             ENDIF
1707: 
1708:             THIS.this_oFormPai = .NULL.
1709:         ENDIF
1710: 
1711:         DODEFAULT()
1712:     ENDPROC
1713: 
1714: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigoptrpBO.prg):
*==============================================================================
* SIGOPTRPBO.PRG
* Business Object do dialogo "Transportadoras" (SIGOPTRP), aberto pelo form
* pai de Cadastro de Operacoes (SigCdOpe) via
* "Do Form Sigoptrp With ThisForm, nDataSession", NAO acessivel direto pelo
* menu.
*
* Tabela persistida : SigOpTrp  (transportadoras habilitadas para a operacao)
* Chave Real (PK)    : cidchaves - gerada com fUniqueIds() ao inserir (regra
*                       #22 do CLAUDE.md - NUNCA string vazia, senao a 2a
*                       linha colide no indice unico)
* Colunas da tabela  : dopes, itras, cidchaves (lista tirada literalmente do
*                       "Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves)
*                       Values (...)" do legado - ver NOTA DE SCHEMA abaixo)
*
* NOTA DE SCHEMA (regra #14 do CLAUDE.md): a tabela SigOpTrp NAO aparece em
* docs/schema.sql (conferido com Get-Content -Raw -Encoding Unicode, que
* respeita o BOM UTF-16 - zero ocorrencias de "OpTrp" no arquivo inteiro,
* contra SigOpTrf/SigPrTrp/SigIvTrp/SIGFITRP que existem). O legado
* (Sigoptrp_form_codigo_fonte.txt) usa o nome "SigOpTrp" de forma consistente
* em TRES pontos (AddCursor, Insert Into CrSigOpTrp, Delete From SigOpTrp) -
* nao ha divergencia de grafia dentro do proprio legado, nem tabela com nome
* parecido que sugira erro de digitacao do migrador. Por isso o nome foi
* mantido EXATO, igual ao legado (PILAR 2) - a ausencia no snapshot do
* schema e uma divergencia de BANCO/ambiente (tabela pode ter sido criada
* depois do snapshot), nao um erro de migracao a corrigir trocando o nome.
*
* NATUREZA DESTE DIALOGO (lido do legado, Sigoptrp_form_codigo_fonte.txt):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe, lista
*   de operacoes) e pnDataSes e a DataSession do pai - o dialogo faz
*   "Set DataSession to pnDataSes" para conseguir ler crSigCdOpe (cursor do
*   pai) diretamente, antes de abrir a propria DataSession = 2 privada
*   (mesmo padrao de SigOpTrf/SigOpTop - FormSigOpTrf usa DataSession = 1
*   compartilhada no migrado, em vez de trocar de sessao manualmente).
*
*   O Caption e montado como:
*     'Transportadoras ' + AllTrim(crSigCdOpe.Dopes)
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Uma unica grade (GradeOpe, 2 colunas) <- xOpe (Dopes C(20), Itras C(10),
*   Razaos C(40)) - cursor LOCAL editavel, carregado no Init a partir das
*   linhas ja gravadas em SigOpTrp para esta operacao (JOIN com SigPrTrp
*   para resolver a descricao):
*     lcSql = "Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
*              Where a.Dopes = '<crSigCdOpe.Dopes>' And a.Itras = b.Itras"
*   Column1.Text1 (Itras) tem Valid com lookup fwbuscaext em SigPrTrp pela
*   chave Itras - achando, preenche Razaos (xOpe.Razaos); vazio, limpa o
*   campo. Column2.Text1 (Razaos) tem When = Return .F. - e SOMENTE EXIBICAO,
*   nunca editado digitando, NUNCA persistido em SigOpTrp (so aparece no
*   SELECT acima via JOIN) - mesmo papel do this_cDpros em SigOpTrfBO.
*
*   cmdInserir: Insert Into xOpe (Itras) Values (Space(10)) - acrescenta
*   linha em branco na grade e foca a coluna do codigo; marca GravaDados.
*
*   cmdExcluir: apaga a linha corrente de xOpe (Delete + Skip); marca
*   GravaDados.
*
*   cmdSair (Caption "Confirmar"): SE GravaDados -> valida que nao ha
*   Itras duplicado entre as linhas nao-vazias de xOpe (Group By Itras
*   Having Sum(1) > 1 -> aborta com MessageBox se achar); senao, apaga TODAS
*   as linhas de SigOpTrp desta operacao (Delete From SigOpTrp Where
*   dopes = '<crSigCdOpe.Dopes>') e regrava uma linha por xOpe.Itras
*   nao-vazio (Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves) Values
*   (crSigCdOpe.Dopes, xOpe.Itras, fUniqueIds())), via
*   poDatamgr.UpDate('CrSigOpTrp') + Commit() dentro de TRY/CATCH com
*   RollBack no erro - mesmo padrao "apaga tudo da operacao e reinsere" do
*   SigOpTrfBO (regra #22 do CLAUDE.md - cidchaves SEMPRE fUniqueIds(),
*   nunca string vazia). Confirmar reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Cancela: so reabilita o form pai e libera o dialogo, SEM gravar nada
*   (equivalente ao Cancelar do SigOpTrfBO - nenhuma chamada ao BO).
*
*   Por isso este BO sobrescreve Inserir() (fase seguinte) operando sobre
*   UMA linha por vez (identificada por cidchaves), que o fluxo de gravacao
*   em lote do Confirmar (fases seguintes) vai chamar em loop, uma vez por
*   linha nao-vazia de xOpe, dentro do "apaga tudo e reinsere" do legado.
*   NAO sobrescreve Atualizar() nem ExecutarExclusao(): nao ha alteracao nem
*   exclusao unitaria no legado - a remocao de uma linha e so o efeito
*   colateral de ela nao ser reinserida no lote seguinte, igual ao
*   SigOpTrfBO.
*==============================================================================

DEFINE CLASS SigoptrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado, cursor do form pai)
    * Operacao cujas transportadoras habilitadas estao sendo editadas.
    * this_cDopes e usado tanto como filtro da carga quanto como o valor da
    * coluna "dopes" de cada linha gravada em SigOpTrp (as duas coisas sao
    * sempre o mesmo codigo, por desenho deste dialogo - mesmo papel do
    * SigOpTrfBO).
    *--------------------------------------------------------------------------
    this_cDopes          = ""  && SigCdOpe.Dopes CHAR(20) - operacao (contexto, vindo do form pai)
    this_cTituloDialogo  = ""  && Caption montado: "Transportadoras " + this_cDopes

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA GRADE (xOpe / SigOpTrp + SigPrTrp)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""  && cidchaves - PK, gerada com fUniqueIds() ao inserir
    this_cItras     = ""  && itras  CHAR(10) - codigo da transportadora (SigPrTrp.Itras)
    this_cRazaos    = ""  && razaos CHAR(40) - descricao da transportadora (SigPrTrp.Razaos) - SOMENTE EXIBICAO, NAO persistida em SigOpTrp

    *--------------------------------------------------------------------------
    * CURSOR DE TRABALHO - nome fixo, populado pelo BO nas fases seguintes.
    * Nunca e SQLEXEC direto no cursor ligado ao Grid (regra do CLAUDE.md
    * sobre SQLEXEC derrubar ColumnCount de Grid) - carga via cursor
    * temporario + ZAP/APPEND FROM DBF(), mesmo padrao do SigOpTrfBO.
    *--------------------------------------------------------------------------
    this_cCursorItens = "cursor_4c_Itens"  && xOpe no legado - Dopes C(20), Itras C(10), Razaos C(40)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_lDadosAlterados = .F.  && ThisForm.GravaDados no legado - .T. quando algo foi incluido/excluido e precisa regravar ao Confirmar
    this_nTotalItens      = 0   && RECCOUNT de this_cCursorItens apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * this_cTabela/this_cCampoChave apontam para a tabela REALMENTE gravada
    * por este dialogo (SigOpTrp) - ver NOTA DE SCHEMA no cabecalho do
    * arquivo sobre a ausencia dela em docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpTrp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cDopes         = ""
            THIS.this_cTituloDialogo = ""

            THIS.this_cCidChaves = ""
            THIS.this_cItras     = ""
            THIS.this_cRazaos    = ""

            THIS.this_lDadosAlterados = .F.
            THIS.this_nTotalItens     = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da linha de SigOpTrp (cidchaves).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dopes/itras/razaos da linha corrente de um
    * alias no formato de this_cCursorItens (xOpe no legado - Dopes C(20),
    * Itras C(10), Razaos C(40)). Razaos e SOMENTE EXIBICAO (resolvida via
    * JOIN com SigPrTrp em CarregarItens), nunca persistida em SigOpTrp - ver
    * cabecalho do arquivo.
    *
    * this_cCidChaves e SEMPRE zerado aqui: xOpe nao tem essa coluna (o
    * legado regrava cidchaves do ZERO com fUniqueIds() a cada Confirmar,
    * para TODAS as linhas - nunca preserva a PK antiga, mesmo quando a
    * linha ja existia). Quem for persistir esta linha (Inserir, fase
    * seguinte) gera a PK nova sozinho.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cDopes     = TratarNulo(dopes, "")
        THIS.this_cItras     = TratarNulo(itras, "")
        THIS.this_cRazaos    = TratarNulo(razaos, "")
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma transportadora habilitada em SigOpTrp.
    * cidchaves (PK real, regra #22 do CLAUDE.md) e gerado com fUniqueIds()
    * quando ainda nao foi atribuido - NUNCA string vazia, senao a 2a linha
    * do lote colide no indice unico. O fluxo de gravacao em lote do
    * Confirmar (PersistirItens, fase seguinte) zera this_cCidChaves antes
    * de chamar Inserir() para cada linha nao-vazia de xOpe, reproduzindo o
    * "Zap + Scan ... Insert ... fUniqueIds()" do legado - cidchaves NUNCA e
    * reaproveitado de uma gravacao anterior.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTrp (cidchaves, dopes, itras)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cItras) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagarItensDaOperacao - apaga TODAS as transportadoras ja gravadas em
    * SigOpTrp para a operacao corrente (this_cDopes). Equivale ao
    * "Select CrSigOpTrp / Zap" do cmdSair.Click legado (a view CrSigOpTrp e
    * o AddCursor sem filtro em SigOpTrp - mas o DELETE aqui, ao contrario do
    * legado, filtra explicitamente por dopes, porque este BO fala com o SQL
    * Server direto, sem a AddCursor/UpDate/Commit do poDatamgr).
    *
    * Primitiva do "apaga tudo e regrava" que o Confirmar faz em lote
    * (FormSigoptrp.PersistirItens, fase seguinte) ANTES de reinserir uma
    * linha por item nao-vazio de xOpe. O legado NAO tem exclusao unitaria
    * de item (cmdExcluir so apaga da grade local xOpe, nunca de SigOpTrp
    * direto), e por isso este BO nao sobrescreve ExecutarExclusao() -
    * Excluir() por cidchaves nao serviria aqui, porque o cidchaves exibido
    * na grade nunca foi persistido (ver CarregarDoCursor).
    *
    * Esta no BO, e nao no Form, porque eh SQL (PILAR 3 - arquitetura em
    * camadas): o Form orquestra o lote, o BO fala com o banco.
    *
    * A auditoria de um DELETE em LOTE nao tem uma PK unica para registrar,
    * entao a chave logada eh o codigo da OPERACAO - que eh o que identifica
    * o conjunto afetado. this_cCidChaves eh preservado e reposto: ele
    * pertence a linha corrente, nao a este comando.
    *
    * EscaparSQL(this_cDopes) com o valor ALLTRIM'd eh a mesma forma usada
    * em CarregarItens: dopes eh CHAR(20) e o SQL Server compara CHAR com
    * blank-padding ANSI, entao o WHERE casa com o valor gravado (ALLTRIM na
    * chave INTEIRA eh inofensivo - regra #42 proibe ALLTRIM nas PARTES de
    * chave concatenada, que nao eh o caso).
    *
    * O RETURN de guarda fica FORA do TRY e o RETURN final eh unico
    * (regra #1).
    *
    * Metodo PUBLIC: chamado pelo Form (PersistirItens) e pelo harness de
    * teste - metodo que o form chama de fora NUNCA pode ser PROTECTED
    * (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE ApagarItensDaOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveAnterior, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigOpTrp" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                *-- Auditoria do lote pela operacao (ver cabecalho do metodo)
                loc_cChaveAnterior   = THIS.this_cCidChaves
                THIS.this_cCidChaves = ALLTRIM(THIS.this_cDopes)
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_cCidChaves = loc_cChaveAnterior

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao apagar as transportadoras:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao apagar as transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresTrabalho - fecha o cursor de trabalho (regra #52 -
    * TABLEREVERT so quando ha buffering, senao dispara o erro 1586).
    * Chamado no INICIO de CarregarItens (reentrancia - este dialogo pode
    * ser aberto mais de uma vez na mesma sessao do processo) e pelo
    * Destroy do Form (teardown final).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresTrabalho()
        IF VARTYPE(THIS.this_cCursorItens) = "C" AND !EMPTY(THIS.this_cCursorItens) ;
                AND USED(THIS.this_cCursorItens)
            IF CURSORGETPROP("Buffering", THIS.this_cCursorItens) > 1
                TABLEREVERT(.T., THIS.this_cCursorItens)
            ENDIF
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - carga inicial do dialogo (trecho principal do Init
    * legado): popula this_cCursorItens (xOpe) a partir das transportadoras
    * ja habilitadas para a operacao corrente, resolvendo a descricao via
    * JOIN com SigPrTrp.
    *
    *   Legado (Init):
    *     lcSql = [Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
    *              Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Itras = b.Itras]
    *     ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
    *     Select CsSelecao
    *     Scan
    *         Scatter Memvar
    *         Select xOpe
    *         Append Blank
    *         Gather Memvar
    *     EndScan
    *
    * O JOIN (a.Itras = b.Itras, sem OUTER) e DE PROPOSITO: so entra na
    * grade transportadora que EXISTE em SigPrTrp - mesma regra que o Valid
    * do Column1.Text1 aplica ao digitar (fwbuscaext em SigPrTrp). xOpe nao
    * tem coluna cidchaves (ver CarregarDoCursor) porque o legado nunca
    * preserva a PK antiga ao regravar.
    *
    * FecharCursoresTrabalho() no INICIO garante reentrancia - o CREATE
    * CURSOR abaixo estouraria "Cursor ja existe" se this_cCursorItens ja
    * estivesse aberto de uma chamada anterior.
    *
    * Metodo PUBLIC: chamado pelo Form (CarregarLista, fase seguinte) e pelo
    * harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cAliasTemp, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresTrabalho()

            loc_cAliasTemp = "cursor_4c_ItensTemp"

            loc_cSQL = "SELECT a.dopes, a.itras, b.razaos" + ;
                       " FROM SigOpTrp a, SigPrTrp b" + ;
                       " WHERE a.dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND a.itras = b.itras"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar transportadoras:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ELSE
                *-- xOpe: cursor LOCAL editavel (Insert/Delete direto da
                *-- grade, nunca SQLEXEC nele - regra do CLAUDE.md sobre
                *-- SQLEXEC derrubar Grid.ColumnCount)
                CREATE CURSOR (THIS.this_cCursorItens) (Dopes C(20), Itras C(10), Razaos C(40))
                INDEX ON Dopes TAG Dopes
                SET ORDER TO

                IF USED(loc_cAliasTemp)
                    SELECT (loc_cAliasTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) (Dopes, Itras, Razaos) ;
                            VALUES (TratarNulo(dopes, ""), TratarNulo(itras, ""), TratarNulo(razaos, ""))
                    ENDSCAN
                    USE IN (loc_cAliasTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                SET ORDER TO
                GO TOP

                THIS.this_nTotalItens = RECCOUNT(THIS.this_cCursorItens)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

