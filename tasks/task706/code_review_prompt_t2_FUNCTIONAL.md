# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1706 linhas total):

*-- Linhas 25 a 75:
25: *     TRANSCRITAS do dump (600x187, BorderStyle=2, AutoCenter, TitleBar=0,
26: *     ControlBox=.F., MaxButton=.F., Verdana 8, ForeColor 36,84,155)
27: *   - Init(par_oFormPai, par_cOperacao) recebendo o contexto do form chamador,
28: *     equivalente ao "LParameters poForm, pOperacao" do PROCEDURE Init legado
29: *   - InicializarForm() - instancia SigOpCopBO (Fases 1-2), aplica o Picture
30: *     de fundo e monta o cabecalho
31: *   - ConfigurarPageFrame() - orquestrador da montagem visual; NAO existe
32: *     PageFrame real (o legado e flat), o nome e mantido por conformidade com
33: *     o contrato do pipeline multi-fase, igual em FormSIGOPCCO/FormSigOpCcl
34: *   - ConfigurarCabecalho() - cnt_4c_Sombra + os dois labels de titulo
35: *   - TornarControlesVisiveis() / Destroy()
36: *
37: * O CommandGroup Copiar/Encerrar e o Click do CmdExit vieram no bloco da Fase
38: * 4, adiante. Os dois labels, os dois TextBox e os eventos restantes
39: * (GetOrigem.Valid/When, GetDestino.Valid, CmdCopia.Click) entram nos blocos
40: * seguintes deste cabecalho.
41: *
42: *------------------------------------------------------------------------------
43: * NOTAS DE TRANSCRICAO JA APLICADAS NESTE BLOCO
44: *
45: * 1. WindowType: o SCX declara WindowType = 1 (modal). A classe e definida com
46: *    WindowType = 0 porque modal top-level causaria TIMEOUT no VFP9 -T usado
47: *    pelo harness de validacao/teste; o Init restaura 1 fora desses modos -
48: *    mesmo padrao de FormSIGOPCCO, FormSigOpCcl e FormSigOpCgl. Transcrever o
49: *    0 do baseclass para a classe mataria a tela aberta pelo menu (o Show()
50: *    modeless retorna na hora e a referencia LOCAL do chamador cai).
51: *
52: * 2. Closable / MinButton / ClipControls: o dump NAO as declara, logo NAO sao
53: *    escritas aqui. ControlBox = .F. e TitleBar = 0 nao as implicam - sao
54: *    propriedades independentes, e fixar Closable = .F. por "coerencia"
55: *    removeria o Alt+F4 que o legado permite.
56: *
57: * 3. cntSombra.Width = 800 e lblSombra/lblTitulo.Width = 769 no dump, com o
58: *    form em 600: e artefato do Form Designer (container desenhado 200px alem
59: *    da borda direita). Aplicar o literal recortaria o titulo, porque controle
60: *    fora da area do pai e CORTADO sem erro. Usa-se THIS.Width no container e
61: *    THIS.Width - 20 nos labels.
62: *
63: * 4. Caption e ToolTipText com acento vao por CHR() e portanto FORA do
64: *    DEFINE CLASS (propriedade de classe aceita so literal constante): o
65: *    Caption e atribuido no Init, ANTES do DODEFAULT().
66: *
67: * 5. Os labels levam AutoSize = .F. com Width E Height do dump: AutoSize eh
68: *    no-op em Label criado por AddObject e, com WordWrap = .T., descarta a
69: *    Height e colapsa o texto de duas linhas para uma.
70: *
71: * 6. DataSession = 1 (sessao CORRENTE). O legado faz
72: *    "ThisForm.DataSessionId = poForm.DataSessionId", ou seja compartilha a
73: *    sessao do chamador - que e exatamente o que DataSession = 1 entrega,
74: *    inclusive quando o chamador roda em sessao privada.
75: *

*-- Linhas 98 a 444:
98: * Entregue neste bloco:
99: *   - ConfigurarBotoes() - cmg_4c_Botoes e os dois botoes, com geometria,
100: *     fonte, cor, Picture e Caption TRANSCRITOS do dump
101: *   - BtnEncerrarClick() - o "PROCEDURE Click / Release Windows" do CmdExit
102: *   - a chamada a ConfigurarBotoes() em ConfigurarPageFrame(), DEPOIS de
103: *     ConfigurarCabecalho()
104: *
105: * Os dois labels, os dois TextBox (GetOrigem/GetDestino) e o Click do CmdCopia
106: * entram nos blocos seguintes deste cabecalho.
107: *
108: *------------------------------------------------------------------------------
109: * NOTAS DE TRANSCRICAO JA APLICADAS NO BLOCO DA FASE 4
110: *
111: * 7. CommandGroup NAO tem ForeColor nem FontName. A lista real da classe base
112: *    traz AutoSize/BackColor/BackStyle/BorderColor/BorderStyle/ButtonCount/
113: *    SpecialEffect/TabIndex/Themes/Value/Visible e nenhuma das duas - atribuir
114: *    qualquer uma estouraria no Init, dentro do TRY, e a tela NAO abriria
115: *    (regra #33). O dump tambem nao as declara no grupo: fonte e cor estao em
116: *    cada BOTAO (Command1.FontName / Command1.ForeColor).
117: *
118: * 8. AutoSize = .T. do dump vira AutoSize = .F. com Width/Height transcritos:
119: *    os dois botoes de 75x75 em 5,5 e 80,5 somam exatamente 160 x 85, que e o
120: *    Width/Height que o Form Designer gravou - ou seja a geometria fixa JA E o
121: *    auto-size calculado, e fixa-la e reproducao fiel. Evita tambem o risco da
122: *    regra #23 (AutoSize descartando Width/Height em controle de AddObject).
123: *
124: * 9. Themes = .F. no grupo E nos dois botoes, exatamente como o dump declara:
125: *    Buttons(N) de CommandGroup com Picture NAO precisa do Themes = .T. +
126: *    DisabledPicture que um CommandButton STANDALONE exige para desenhar o
127: *    icone.
128: *
129: * 10. ForeColor dos botoes = RGB(90, 90, 90), do dump. Branco deixaria a
130: *     legenda invisivel: o botao tem BackColor = RGB(255, 255, 255) e o form
131: *     tem Picture de fundo CLARA (regra #12).
132: *
133: * 11. O grupo e criado DEPOIS de cnt_4c_Sombra: com Top = -2 ele cai dentro da
134: *     faixa cinza (0..80) e so desenha POR CIMA dela nessa ordem. Invertido, o
135: *     cabecalho cobriria Copiar/Encerrar (regra #11).
136: *
137: * 12. O legado NAO tem Click no grupo: tem um Click em CADA botao
138: *     (CmdCopia.Click e CmdExit.Click), entao cada Buttons(N) recebe o seu
139: *     proprio BINDEVENT, sem DO CASE sobre .Value. No bloco desta Fase 4 so o
140: *     de Buttons(2) (Encerrar) foi registrado, porque BINDEVENT valida o
141: *     delegate NA HORA DO BIND: apontar para um handler que o form ainda nao
142: *     tem estoura "Property X is not found" dentro do InicializarForm,
143: *     CREATEOBJECT devolve .F. e a tela nao abre. O de Buttons(1) (Copiar)
144: *     entrou junto com BtnCopiarClick, no bloco da Fase 7.
145: *
146: * 13. TabIndex = 5 transcrito do grupo. Medido ao instanciar: com so dois
147: *     filhos no form (cabecalho + grupo) o VFP9 limita o valor ao numero de
148: *     controles e o grupo le TabIndex = 2 - comportamento esperado, nao
149: *     divergencia. A sequencia completa de tabulacao (os dois TextBox, 3 e 4,
150: *     antes do grupo) e aplicada em ordem ascendente no bloco dos campos,
151: *     quando os controles focalizaveis existirem; Label tem TabIndex mas nao
152: *     tem TabStop, logo nao entra na conta.
153: *------------------------------------------------------------------------------
154: * FASE 5/8 - CAMPOS PRINCIPAIS, PARTE 1 (este bloco)
155: *
156: * O SIGOPCOP tem QUATRO objetos de dados na arvore do SCX, em duas linhas:
157: *
158: *   Label1     -> lbl_4c_Label1   "Movimentacao Atual : "  169,110  109x15
159: *   GetOrigem  -> txt_4c_Origem   operacao de ORIGEM       280,107  150x23
160: *   Label2     -> lbl_4c_Label2   "Nova Movimentacao : "   169,136  109x15
161: *   GetDestino -> txt_4c_Destino  operacao de DESTINO      280,134  150x23
162: *
163: * Este bloco entrega a linha de CIMA (Label1 + GetOrigem), a metade superior
164: * do bloco de dados. Label2 + GetDestino, o Valid de cada campo (lookup de
165: * SigCdOpe na origem, conferencia de duplicidade no destino) e o Click do
166: * CmdCopia entram nos blocos seguintes deste cabecalho.
167: *
168: * Entregue neste bloco:
169: *   - ConfigurarCampos() - lbl_4c_Label1 e txt_4c_Origem, com geometria,
170: *     fonte, cor, Format e MaxLength TRANSCRITOS do dump
171: *   - OrigemWhen() - equivalente ao "PROCEDURE When / Return .f." de GetOrigem
172: *   - a chamada a ConfigurarCampos() em ConfigurarPageFrame(), DEPOIS de
173: *     ConfigurarBotoes()
174: *   - "ThisForm.GetOrigem.Value = pOperacao" + ".Refresh" do PROCEDURE Init
175: *     legado, agora que o TextBox existe (a semeadura do Business Object feita
176: *     em InicializarForm continua, porque e dela que o BO valida e grava)
177: *
178: *------------------------------------------------------------------------------
179: * NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 5
180: *
181: * 14. NAO ha ControlSource em campo nenhum, e o dump do legado nao tem sequer
182: *     a palavra. O SIGOPCOP nao abre cursor de tela: o Init recebe a origem
183: *     por parametro e o CmdCopia le os dois .Value direto. Vincular os campos
184: *     a um cursor seria INVENTAR ligacao que o original nao tem - e aqui isso
185: *     nao e cosmetico, e DEFEITO: os cursores da copia sao fechados e
186: *     recriados a cada etapa do lote, logo o valor digitado seria sobrescrito.
187: *
188: * 15. Format = "!" e MaxLength = 20 TRANSCRITOS do dump. Descartar essas duas
189: *     linhas muda o que o usuario digita E o que chega ao banco (regra #49): o
190: *     "!" forca MAIUSCULA, que e como o Inserir do BO monta o destino
191: *     (UPPER(ALLTRIM(...))). O 20 vem da LARGURA DA COLUNA - SigCdOpe.dopes e
192: *     char(20) no schema - nunca do Width em pixels (regra #19).
193: *
194: * 16. Alignment NAO e escrito no TextBox: o dump nao o declara e o default de
195: *     TextBox e 3 (automatico pelo tipo de dado), nao 0 - fixar 0 seria
196: *     divergencia inventada.
197: *
198: * 17. Label com AutoSize = .T. no dump vira AutoSize = .F. com Width E Height
199: *     TRANSCRITOS (109x15): AutoSize e no-op em Label criado por AddObject e,
200: *     com WordWrap, descarta a Height e colapsa o texto. O 109 JA E o
201: *     auto-size que o Form Designer calculou, logo fixa-lo e reproducao fiel
202: *     (regra #23). Alignment = 0 pelo mesmo motivo: a classe say do legado e
203: *     left-align e o Left = 169 ja foi escalonado para o texto terminar em
204: *     278, dois pixels antes do campo em 280 - encostar o texto na borda
205: *     direita (Alignment = 1) o jogaria para dentro do TextBox.
206: *
207: * 18. ForeColor = RGB(90, 90, 90) TRANSCRITO do dump. Branco deixaria a
208: *     legenda INVISIVEL: o fundo do form e o Picture CLARO
209: *     new_background.jpg e o label e transparente (BackStyle = 0) - regra #12.
210: *
211: * 19. "PROCEDURE When / Return .f." de GetOrigem e replicado por BINDEVENT
212: *     "When" + OrigemWhen(), o padrao que os irmaos FormSigOpBcb
213: *     (NaoPermitirFocoWhen) e FormSigOpCcl ja usam - ao contrario de "Valid",
214: *     que NAO e confiavel em TextBox. Soma-se ReadOnly = .T. e TabStop = .F.
215: *     para que o valor nao possa ser alterado nem pelo caminho em que o
216: *     bloqueio de foco nao pegasse; o efeito observavel do When = .F. legado e
217: *     justamente esse, e ReadOnly nao acinzenta o campo (Enabled = .F.
218: *     acinzentaria, divergindo do legado).
219: *
220: *     DESVIO DELIBERADO E ESTREITO, registrado aqui: o bloqueio vale SO quando
221: *     a origem veio do chamador (par_cOperacao preenchido), que e o UNICO
222: *     caminho que o legado tem - o SIGOPCOP e sempre aberto pelo Cadastro de
223: *     Operacoes passando a operacao corrente. Nesse caminho o comportamento e
224: *     IDENTICO ao legado. Aberto SEM chamador - caminho que so existe no
225: *     sistema novo, pelo item de menu - o campo fica digitavel, senao a tela
226: *     abriria com o primeiro campo em branco e IMPOSSIVEL de preencher, e o
227: *     CmdCopia responderia "Origem Invalida !!!" para sempre: o mesmo defeito
228: *     que a regra #50 descreve (impedir o usuario de preencher o campo).
229: *     O lookup de SigCdOpe que o GetOrigem.Valid legado abre - morto no legado
230: *     justamente por causa do When = .F. - e o que atende esse caminho, e vem
231: *     no bloco seguinte.
232: *
233: *------------------------------------------------------------------------------
234: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (este bloco)
235: *
236: * Fecha o bloco de dados com a linha de BAIXO e liga o "PROCEDURE Valid" dos
237: * DOIS campos - as duas unicas regras de campo que o SIGOPCOP tem:
238: *
239: *   GetOrigem.Valid  -> lookup de SigCdOpe (fwBuscaExt), reproduzido com
240: *                       FormBuscaAuxiliar; campo vazio avisa "Operacao Deve
241: *                       ser informada !!!" e devolve o foco
242: *   GetDestino.Valid -> conferencia de DUPLICIDADE em SigCdOpe; achando
243: *                       registro avisa "Operacao ja Cadastrada !!!" e devolve
244: *                       o foco
245: *
246: * Entregue neste bloco:
247: *   - lbl_4c_Label2 e txt_4c_Destino em ConfigurarCampos(), com geometria,
248: *     fonte, cor, Format e MaxLength TRANSCRITOS do dump
249: *   - ValidarOrigem()  - o Valid de GetOrigem, ligado a "LostFocus"
250: *   - TxtOrigemKeyPress() / TxtOrigemDblClick() - F4/F5 e duplo clique, as
251: *     outras duas entradas do funil do lookup
252: *   - AbrirBuscaOrigem() - o funil UNICO do lookup de SigCdOpe
253: *   - ValidarDestino() - o Valid de GetDestino, ligado a "LostFocus"
254: *   - as duas guardas de reentrancia (this_lEmLookupOrigem /
255: *     this_lEmValidaDestino) e os quatro BINDEVENT
256: *
257: * O "PROCEDURE Click" do CmdCopia - que le os dois campos, chama o copiador do
258: * Business Object e e a acao principal da tela - entra no bloco seguinte deste
259: * cabecalho, junto com o espelho tela -> Business Object.
260: *
261: *------------------------------------------------------------------------------
262: * NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 6
263: *
264: * 20. O "PROCEDURE Valid" dos dois campos vai em BINDEVENT "LostFocus", nunca
265: *     em "KeyPress": o Valid legado roda ao SAIR do campo, e um handler de
266: *     KeyPress que age so por o campo estar preenchido abriria o picker a CADA
267: *     caractere digitado - o usuario nao conseguiria terminar de digitar o
268: *     codigo (regra #47). BINDEVENT "Valid" tambem nao e alternativa: nao
269: *     dispara de forma confiavel em TextBox. Como BINDEVENT DESCARTA o retorno
270: *     do delegate, o "Return .f." legado (que impede o foco de sair) se
271: *     reproduz com SetFocus no proprio campo, nao com RETURN .F.
272: *
273: * 21. O lookup existe SO no GetOrigem, e so o dump decide isso. O GetDestino
274: *     nao tem nenhuma das tres classes de busca do legado (fwBuscaExt /
275: *     fwBuscaSel / fwBuscaInt) no Valid dele - e nao poderia ter: ali o
276: *     usuario informa uma operacao que ainda NAO existe, e achar registro e
277: *     exatamente o que reprova. Inventar um picker nesse campo seria inverter
278: *     a regra de negocio da tela.
279: *
280: *     No GetOrigem o lookup e preservado com o alcance que a nota 19 descreve:
281: *     AbrirBuscaOrigem nao altera o campo quando ele esta somente-exibicao
282: *     (origem vinda do chamador), que e o caminho em que o When = .F. legado
283: *     tornava o proprio Valid inalcancavel.
284: *
285: * 22. As duas guardas de reentrancia sao OBRIGATORIAS, e por motivos
286: *     diferentes do mesmo tipo: o picker e MODAL e TIRA o foco do campo, e o
287: *     SetFocus com que se reproduz o "Return .f." o DEVOLVE - as duas coisas
288: *     redisparam o proprio LostFocus que as acionou, empilhando um segundo
289: *     dialogo ou um segundo aviso (regra #37).
290: *
291: *     A distribuicao segue a regra #47: o handler ALVO (ValidarOrigem /
292: *     ValidarDestino) faz set no topo + clear DEPOIS do ENDTRY, com o unico
293: *     RETURN antes do set; o FUNIL alcancado tambem pelos irmaos
294: *     (AbrirBuscaOrigem, chamado de dentro do ValidarOrigem e direto pelo
295: *     F4/duplo clique) faz SAVE/RESTORE - um clear fixo nele liberaria a
296: *     guarda antes de o alvo terminar. Nenhum dos tres tem RETURN depois de
297: *     ligar a flag: RETURN ali a deixaria presa em .T. e MATARIA o lookup pelo
298: *     resto da vida do form.
299: *
300: * 23. F4 (115) e F5 (116) - nunca 28 nem 63, que sao outras teclas - e duplo
301: *     clique chamam o MESMO funil. ENTER e TAB ficam DE FORA de proposito: as
302: *     duas movem o foco, logo o LostFocus ja abre o funil, e abrir no KeyPress
303: *     tambem faria o picker aparecer duas vezes em sequencia. A assinatura do
304: *     handler de KeyPress declara os dois parametros do evento, senao estoura
305: *     a cada tecla (regra #3).
306: *
307: * 24. "MessageBox(...,16,'')" dos dois Valid vira MsgAviso (dialogo de
308: *     atencao), nao MsgErro: as duas mensagens sao validacao de UI, e MsgErro
309: *     oferece "Fechar Aplicacao" num caso em que o usuario so precisa corrigir
310: *     o campo. O texto e o literal do legado, com os acentos em CHR().
311: *     MsgAviso e chamado sem titulo, equivalendo ao titulo vazio do legado - o
312: *     proprio helper preenche "Atencao".
313: *
314: *     A conferencia de duplicidade do destino SO roda com conexao viva
315: *     (gnConnHandle > 0): em validacao de UI e em modo teste o handle e -1 e o
316: *     SQLEXEC dispararia excecao. Pular ali nao abre brecha de gravacao - o
317: *     ValidarDados do Business Object repete a mesma conferencia antes de
318: *     abrir a transacao, e e ele a barreira real; este Valid e o aviso
319: *     ANTECIPADO que o legado da, para o usuario nao descobrir o problema
320: *     apenas ao acionar Copiar.
321: *
322: *------------------------------------------------------------------------------
323: * FASE 7/8 - EVENTOS PRINCIPAIS (este bloco)
324: *
325: * Entrega o "PROCEDURE CmdCopia.Click" - a ACAO PRINCIPAL da tela, e o unico
326: * evento de botao que faltava:
327: *
328: *   - BtnCopiarClick()   - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado):
329: *                          valida os dois campos, espelha tela -> Business
330: *                          Object, dispara o copiador das 15 tabelas e fecha
331: *                          a tela, exatamente na ordem do Click legado
332: *   - AtualizarFormPai() - repinte da lista do form CHAMADOR, que no legado
333: *                          vinha de graca pelo cursor compartilhado (nota 27)
334: *   - this_lEmCopia      - guarda de reentrancia do botao (nota 26)
335: *   - o BINDEVENT de Click de Buttons(1), que so pode ser registrado agora
336: *     que o handler existe (ver nota 12)
337: *
338: * NAO existem BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
339: * BtnExcluirClick - e nao podem existir. O SIGOPCOP e um DIALOGO DE PARAMETRO
340: * (Class: form puro) sem CRUD nenhum: o dump inteiro nao tem frmcadastro, nao
341: * tem Grupo_Op, nao tem pcEscolha e nao tem UM botao com verbo CRUD. A unica
342: * barra de acao e o Commandgroup1 com ButtonCount = 2, e os dois botoes que
343: * ele hospeda - CmdCopia e CmdExit - tem agora um handler cada. Criar os
344: * quatro nomes CRUD aqui obrigaria a INVENTAR botao que o legado nao tem
345: * (viola o PILAR 1) ou a escrever metodo vazio (proibido pela regra de
346: * completude).
347: *
348: *------------------------------------------------------------------------------
349: * NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 7
350: *
351: * 25. A gravacao INTEIRA mora no Business Object (SigOpCopBO.Inserir, Fase 2),
352: *     que acumula o INSERT...SELECT das 14 tabelas de origem mais o bloco de
353: *     permissoes de SigCdPrg e executa tudo numa transacao UNICA. O handler do
354: *     botao NAO monta SQL: ele faz o que o Click legado faz antes do copiador
355: *     - confere os dois campos, passa os valores adiante e fecha a tela.
356: *
357: *     O caminho e NovoRegistro() + Salvar() (os dois PUBLIC em BusinessBase),
358: *     nunca Inserir() direto: Salvar() e quem roda ValidarDados() - que repete
359: *     os guards "Origem Invalida"/"Destino Invalido" e a conferencia de
360: *     duplicidade do destino - antes de abrir a transacao. NovoRegistro() vem
361: *     ANTES de escrever as duas propriedades porque ele chama LimparDados().
362: *
363: * 26. Guarda de reentrancia this_lEmCopia, pelo mesmo motivo das outras duas
364: *     (nota 22) e com um agravante: o processo atravessa 15 tabelas numa
365: *     transacao unica, e o MsgAviso dos guards tira e devolve o foco. Sem a
366: *     guarda, duplo clique no botao dispararia a copia DUAS vezes, criando
367: *     duas operacoes com nDopes diferentes para o mesmo destino digitado - e
368: *     a segunda falharia na PK, deixando a primeira gravada e um erro na tela.
369: *
370: *     A flag e liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH
371: *     dispara, e ANTES do Release() - depois do Release o objeto nao existe
372: *     mais e a atribuicao estouraria.
373: *
374: * 27. "ThisForm.Release" e a ULTIMA linha do CmdCopia.Click legado: copia
375: *     feita, o dialogo fecha e o controle volta ao form chamador. Transcrito.
376: *
377: *     Entre a gravacao e o Release entra THIS.AtualizarFormPai(), que NAO e
378: *     invencao: o legado faz "ThisForm.DataSessionId = poForm.DataSessionId" e
379: *     grava nos cursores crSigCdOpe/crSigOpCdc/... que sao os MESMOS do form
380: *     chamador (Cadastro de Operacoes), inclusive o RecordSource da grade
381: *     dele - a lista do pai se atualizava de graca. O PILAR 3 eliminou o
382: *     cursor global compartilhado, entao esse repinte precisa ser escrito a
383: *     mao, senao o usuario copia a operacao e a lista do pai continua sem ela.
384: *
385: *     Tres exigencias no metodo: (a) o pai e OPCIONAL (.NULL. quando a tela e
386: *     aberta pelo menu ou pelo harness) e nem todo chamador tem o metodo, dai
387: *     VARTYPE = "O" + PEMSTATUS(..., "CarregarLista", 5) - aqui PEMSTATUS
388: *     confere so EXISTENCIA, que e exatamente o que se quer; (b) o metodo do
389: *     pai precisa ser PUBLIC (FormOPE.CarregarLista e, conferido) senao a
390: *     chamada estoura "Property CARREGARLISTA is not found" (regra #51);
391: *     (c) TRY/CATCH com AVISO, nunca erro fatal - a copia ja esta confirmada
392: *     no banco e tratar falha de repinte como erro derrubaria uma transacao
393: *     bem-sucedida.
394: *
395: * 28. NAO ha dialogo de sucesso. O Click legado nao exibe nenhuma confirmacao:
396: *     o feedback de que a copia terminou e a tela FECHAR. Acrescentar um
397: *     MsgInfo seria desvio do PILAR 1 num ponto em que o legado e explicito.
398: *     A falha, ao contrario, nunca e muda - BusinessBase.Salvar() exibe todo
399: *     caminho de recusa e marca this_lErroExibido (regra #20), por isso o
400: *     ELSE do IF Salvar() apenas confere essa flag em vez de repetir texto.
401: *
402: * 29. Os guards "Origem Invalida !!!" / "Destino Invalido !!!" sao LITERAIS do
403: *     legado, com um "Return" seco depois de cada MessageBox. Aqui viram
404: *     MsgAviso (mesmo motivo da nota 24) e, como RETURN dentro de TRY/CATCH e
405: *     proibido (regra #1), o early-exit e feito com a flag loc_lProsseguir e
406: *     um RETURN unico - na verdade nenhum - DEPOIS do ENDTRY. O legado nao da
407: *     SetFocus nesses dois caminhos (ao contrario do Valid dos campos, que da
408: *     por causa do Return .f.), e aqui tambem nao se da.
409: *------------------------------------------------------------------------------
410: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL (este bloco)
411: *
412: * Fecha o form com os metodos de apoio que faltavam, todos sobre os DOIS
413: * campos que esta tela tem:
414: *
415: *   - FormParaBO()      - espelho TELA -> Business Object: o
416: *                         "lcOpeOri = ...GetOrigem.Value / lcOpeDes =
417: *                         ...GetDestino.Value" do CmdCopia.Click legado, que
418: *                         estava inline no BtnCopiarClick e agora tem lugar
419: *                         proprio e retorno verificado
420: *   - BOParaForm()      - o espelho inverso, fonte UNICA do valor exibido na
421: *                         origem (antes o ConfigurarCampos lia a propriedade
422: *                         por conta propria)
423: *   - LimparCampos()    - devolve a tela ao estado de abertura: origem de
424: *                         volta ao valor do chamador, destino em branco
425: *   - HabilitarCampos() - a UNICA regra de editabilidade do SIGOPCOP num lugar
426: *                         so, e a trava da tela durante a transacao
427: *   - BtnCopiarClick    - passa a usar FormParaBO() e a travar/destravar a
428: *                         tela; o destravamento fica DEPOIS do ENDTRY
429: *
430: * O ConfigurarCampos deixou de calcular o estado dos campos: ele monta os
431: * controles e chama THIS.HabilitarCampos(.T.) no fim. Antes a regra estava
432: * escrita em loc_lOrigemDoChamador dentro do proprio metodo, e repeti-la em
433: * tres lugares era a receita para os tres divergirem.
434: *
435: *------------------------------------------------------------------------------
436: * O QUE NAO SE APLICA A ESTA TELA, E POR QUE
437: *
438: * Os nomes canonicos de form CRUD que faltam continuam faltando de PROPOSITO,
439: * e nao sao os mesmos casos:
440: *
441: * a) Botao de ABANDONAR edicao (o par do Salvar na Page2 de Dados). O SCX tem
442: *    DOIS botoes e os dois tem handler: Commandgroup1.Command1 "CmdCopia"
443: *    ("\<Copiar", a acao) -> BtnCopiarClick, e Command2 "CmdExit" ("Encerrar",
444: *    cujo Click INTEIRO e "Release Windows") -> BtnEncerrarClick. Nao ha

*-- Linhas 500 a 717:
500: *     impressao de que alargou (regra #51). Nada fora da classe os chama: o
501: *     harness de teste toca apenas Show/Release/Visible/Width/Height/
502: *     WindowType/Name/Class, conferido em TestFormWrapper.prg. Os handlers de
503: *     BINDEVENT continuam PUBLIC, como exige a regra #3.
504: *==============================================================================
505: 
506: DEFINE CLASS FormSigOpCop AS FormBase
507: 
508:     *--------------------------------------------------------------------------
509:     * Propriedades visuais - TRANSCRITAS de SIGOPCOP (secao 2 do dump)
510:     *--------------------------------------------------------------------------
511:     Height      = 187
512:     Width       = 600
513:     Caption     = ""
514:     BorderStyle = 2
515:     AutoCenter  = .T.
516:     TitleBar    = 0
517:     ShowWindow = 1
518:     ControlBox  = .F.
519:     MaxButton   = .F.
520:     FontName    = "Verdana"
521:     FontSize    = 8
522:     ForeColor   = RGB(36, 84, 155)
523: 
524:     *-- Ver nota 1 do cabecalho: a classe nasce modeless e o Init promove a
525:     *-- modal (WindowType = 1 / ShowWindow = 1) fora de validacao e teste.
526:     WindowType  = 0
527:     ShowWindow  = 0
528: 
529:     *-- Ver nota 6 do cabecalho
530:     DataSession = 1
531: 
532:     *--------------------------------------------------------------------------
533:     * Contexto recebido do form chamador (par_* do Init)
534:     *
535:     * this_oFormPai         <- poForm     ("ThisForm.ParentForm = poForm")
536:     * this_cOperacaoOrigem  <- pOperacao  ("ThisForm.GetOrigem.Value = pOperacao")
537:     *
538:     * O legado tambem guarda poDatamgr ("ThisForm.poDatamgr = poForm.poDataMgr").
539:     * Na arquitetura nova o acesso ao banco e do DataAccess/BusinessBase pelo
540:     * handle global gnConnHandle, entao nao ha equivalente a propagar.
541:     *--------------------------------------------------------------------------
542:     this_oFormPai        = .NULL.
543:     this_cOperacaoOrigem = ""
544: 
545:     *--------------------------------------------------------------------------
546:     * Guardas de reentrancia dos dois handlers de LostFocus - ver nota 22
547:     *
548:     * this_lEmLookupOrigem  - picker MODAL de SigCdOpe aberto a partir do
549:     *                         LostFocus da origem (ou de F4/F5/duplo clique)
550:     * this_lEmValidaDestino - MsgAviso + SetFocus da conferencia do destino
551:     * this_lEmCopia         - acao do botao Copiar, que atravessa 15 tabelas
552:     *                         numa transacao unica - ver nota 26
553:     *
554:     * this_cUltimoValidarOrigemValidado - ultimo valor de txt_4c_Origem que
555:     *                         ValidarOrigem ja processou com sucesso.
556:     *                         LostFocus dispara SEMPRE que o foco sai do
557:     *                         campo, mesmo sem alteracao nenhuma - diferente
558:     *                         do Valid legado, que so age quando o conteudo
559:     *                         MUDA. Sem esta guarda, so passar o foco pelo
560:     *                         campo reabriria o lookup a cada vez. Sentinela
561:     *                         que nunca casa com um Dopes real nem com "",
562:     *                         para nao suprimir o aviso de campo obrigatorio
563:     *                         na primeira passagem com o campo vazio.
564:     *--------------------------------------------------------------------------
565:     this_lEmLookupOrigem  = .F.
566:     this_lEmValidaDestino = .F.
567:     this_lEmCopia         = .F.
568:     this_cUltimoValidarOrigemValidado = "~~NAO_VALIDADO_4C~~"
569: 
570:     *--------------------------------------------------------------------------
571:     * Init - recebe o contexto do form chamador, define o Caption com CHR() e
572:     * delega ao FormBase (que chama InicializarForm).
573:     *
574:     * Os dois parametros sao OPCIONAIS: o legado sempre os recebe do form de
575:     * Cadastro de Operacoes, mas a tela tambem e alcancavel pelo menu, e nesse
576:     * caso a operacao de origem fica em branco para o usuario informar.
577:     *--------------------------------------------------------------------------
578:     PROCEDURE Init(par_oFormPai, par_cOperacao)
579:         *-- "C" + o-acute + "pia de Movimenta" + c-cedilha + a-tilde + "o "
580:         *-- (o espaco final faz parte do literal do SCX)
581:         THIS.Caption = "C" + CHR(243) + "pia de Movimenta" + CHR(231) + CHR(227) + "o "
582: 
583:         THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
584:         THIS.this_cOperacaoOrigem = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "")
585: 
586:         *-- Ver nota 1 do cabecalho
587:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
588:              (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
589:             THIS.WindowType = 1
590:             THIS.ShowWindow = 1
591:         ENDIF
592: 
593:         RETURN DODEFAULT()
594:     ENDPROC
595: 
596:     *--------------------------------------------------------------------------
597:     * InicializarForm - instancia o Business Object, aplica o fundo do form e
598:     * monta a estrutura visual.
599:     *
600:     * NAO ha guarda de gb_4c_ValidandoUI envolvendo o metodo: essa flag serve
601:     * para pular QUERY SQL, e um RETURN no topo pularia tambem o Picture e o
602:     * cabecalho, tornando qualquer diferenca de UI Fidelity irrecuperavel pelo
603:     * auto-fix. Este bloco nao executa SQL nenhum.
604:     *--------------------------------------------------------------------------
605:     PROTECTED PROCEDURE InicializarForm()
606:         LOCAL loc_lSucesso, loc_oErro
607:         loc_lSucesso = .F.
608: 
609:         TRY
610:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCopBO")
611: 
612:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
613:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCopBO." + CHR(13) + ;
614:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
615:                         "Erro em InicializarForm")
616:             ELSE
617:                 *-- Fundo do form: o SCX aponta ..\framework\imagens\new_background.jpg
618:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
619: 
620:                 *-- Semeia o BO com a operacao de origem recebida do chamador,
621:                 *-- equivalente ao "ThisForm.GetOrigem.Value = pOperacao" do
622:                 *-- PROCEDURE Init legado. Vai para o BO porque o TextBox da
623:                 *-- tela ainda nao existe neste ponto da montagem.
624:                 THIS.this_oBusinessObject.this_cOperacaoOrigem = THIS.this_cOperacaoOrigem
625: 
626:                 THIS.ConfigurarPageFrame()
627: 
628:                 *-- "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" e
629:                 *-- "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption"
630:                 *-- do PROCEDURE Init legado
631:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
632:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
633: 
634:                 THIS.TornarControlesVisiveis(THIS)
635: 
636:                 loc_lSucesso = .T.
637:             ENDIF
638:         CATCH TO loc_oErro
639:             MsgErro(loc_oErro.Message + CHR(13) + ;
640:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
641:                     "Procedure: " + loc_oErro.Procedure, ;
642:                     "Erro em InicializarForm")
643:         ENDTRY
644: 
645:         RETURN loc_lSucesso
646:     ENDPROC
647: 
648:     *--------------------------------------------------------------------------
649:     * ConfigurarPageFrame - orquestra a montagem visual do form.
650:     *
651:     * NAO existe PageFrame real: o legado SIGOPCOP e flat (nenhum objeto de
652:     * BaseClass pageframe na arvore do SCX) e por isso nao ha compensacao de
653:     * Top = -29 a aplicar - os Top do dump sao absolutos no form e entram
654:     * transcritos. O nome do metodo e mantido por conformidade com o contrato
655:     * do pipeline multi-fase, igual em FormSIGOPCCO e FormSigOpCcl.
656:     *
657:     * ORDEM OBRIGATORIA: o cabecalho vem PRIMEIRO e a barra de botoes DEPOIS -
658:     * ver nota 11 do cabecalho (o grupo em Top = -2 esta dentro da faixa cinza
659:     * e so desenha por cima dela se for criado em segundo lugar).
660:     *
661:     * Os campos de dados vem por ULTIMO: ficam na faixa 107..130, abaixo do
662:     * cabecalho (0..80) e fora da area do grupo de botoes, logo a ordem entre
663:     * eles e indiferente para o desenho - mantem-se a sequencia da montagem.
664:     *--------------------------------------------------------------------------
665:     PROTECTED PROCEDURE ConfigurarPageFrame()
666:         THIS.ConfigurarCabecalho()
667:         THIS.ConfigurarBotoes()
668:         THIS.ConfigurarCampos()
669:     ENDPROC
670: 
671:     *--------------------------------------------------------------------------
672:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
673:     * labels de titulo sobrepostos: sombra preta embaixo, titulo branco em
674:     * cima. Geometria TRANSCRITA do dump (SIGOPCOP.cntSombra / .lblSombra /
675:     * .lblTitulo), com as larguras ajustadas conforme a nota 3 do cabecalho.
676:     *--------------------------------------------------------------------------
677:     PROTECTED PROCEDURE ConfigurarCabecalho()
678:         THIS.AddObject("cnt_4c_Sombra", "Container")
679:         WITH THIS.cnt_4c_Sombra
680:             .Top         = 0
681:             .Left        = 0
682:             .Width       = THIS.Width
683:             .Height      = 80
684:             .BackStyle   = 1
685:             .BackColor   = RGB(100, 100, 100)
686:             .BorderWidth = 0
687:             .Visible     = .T.
688:         ENDWITH
689: 
690:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
691:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
692:             .Top           = 18
693:             .Left          = 10
694:             .Width         = THIS.Width - 20
695:             .Height        = 40
696:             .AutoSize      = .F.
697:             .BackStyle     = 0
698:             .WordWrap      = .T.
699:             .Alignment     = 0
700:             .FontName      = "Tahoma"
701:             .FontSize      = 18
702:             .FontBold      = .T.
703:             .FontUnderline = .F.
704:             .ForeColor     = RGB(0, 0, 0)
705:             .Caption       = THIS.Caption
706:             .Visible       = .T.
707:         ENDWITH
708: 
709:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
710:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
711:             .Top         = 17
712:             .Left        = 10
713:             .Width       = THIS.Width - 20
714:             .Height      = 46
715:             .AutoSize    = .F.
716:             .BackStyle   = 0
717:             .WordWrap    = .T.

*-- Linhas 738 a 781:
738:     *
739:     * Ver notas 7 a 13 do cabecalho.
740:     *--------------------------------------------------------------------------
741:     PROTECTED PROCEDURE ConfigurarBotoes()
742:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
743:         WITH THIS.cmg_4c_Botoes
744:             .Top           = -2
745:             .Left          = 445
746:             .Width         = 160
747:             .Height        = 85
748: 
749:             *-- ButtonCount ANTES de configurar Buttons(N): atribuir a
750:             *-- ButtonCount RECRIA os botoes e descartaria o que ja tivesse
751:             *-- sido posto neles.
752:             .ButtonCount   = 2
753: 
754:             *-- Ver nota 8 do cabecalho
755:             .AutoSize      = .F.
756: 
757:             .BackStyle     = 0
758:             .BorderStyle   = 0
759:             .SpecialEffect = 1
760:             .BorderColor   = RGB(136, 189, 188)
761: 
762:             *-- Ver nota 9 do cabecalho
763:             .Themes        = .F.
764: 
765:             .Value         = 1
766: 
767:             *-- Ver nota 13 do cabecalho
768:             .TabIndex      = 5
769: 
770:             .Visible       = .T.
771:         ENDWITH
772: 
773:         *-- Buttons(1) = Command1 "CmdCopia". O "\<" do Caption e o marcador de
774:         *-- tecla de acesso do VFP (Alt+C), transcrito do dump.
775:         WITH THIS.cmg_4c_Botoes.Buttons(1)
776:             .Top        = 5
777:             .Left       = 5
778:             .Width      = 75
779:             .Height     = 75
780:             .FontName   = "Comic Sans MS"
781:             .FontSize   = 8

*-- Linhas 811 a 882:
811: 
812:         *-- Ver nota 12 do cabecalho: o legado NAO tem Click no grupo, tem um
813:         *-- Click em CADA botao (CmdCopia.Click e CmdExit.Click), entao cada
814:         *-- Buttons(N) recebe o seu proprio BINDEVENT. Os dois handlers sao
815:         *-- PUBLIC: alvo de BINDEVENT declarado PROTECTED falha em SILENCIO.
816:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCopiarClick")
817:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
818:     ENDPROC
819: 
820:     *--------------------------------------------------------------------------
821:     * ConfigurarCampos - bloco de dados do SIGOPCOP, as DUAS linhas.
822:     *
823:     * Linha de CIMA  - Label1 "Movimentacao Atual : " + GetOrigem,  a operacao
824:     *                  que sera COPIADA (entregue no bloco da Fase 5).
825:     * Linha de BAIXO - Label2 "Nova Movimentacao : "  + GetDestino, a operacao
826:     *                  NOVA que recebera a copia (acrescentada na Fase 6).
827:     *
828:     * Geometria, fonte, cor, Format e MaxLength TRANSCRITOS do dump (secao 2,
829:     * "PROPRIEDADES DE: SIGOPCOP.Label1" / ".Label2" / ".GetOrigem" /
830:     * ".GetDestino").
831:     *
832:     * Em cada linha o label e criado ANTES do TextBox para que o campo desenhe
833:     * POR CIMA caso a caixa do label avance sobre ele (regra #23). Aqui nao
834:     * avanca - o label termina em 278 e o campo comeca em 280 - mas a ordem
835:     * segura e a mesma.
836:     *
837:     * Os BINDEVENT dos dois campos ficam no FIM do metodo, depois de ambos os
838:     * TextBox existirem: BINDEVENT valida o objeto de origem NA HORA DO BIND.
839:     *
840:     * Ver notas 14 a 24 do cabecalho.
841:     *--------------------------------------------------------------------------
842:     PROTECTED PROCEDURE ConfigurarCampos()
843:         LOCAL loc_lOrigemDoChamador
844: 
845:         *-- Ver nota 19: origem recebida do chamador e somente-exibicao, como
846:         *-- no legado; origem em branco (tela aberta sem chamador) e digitavel.
847:         loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))
848: 
849:         *-- Label1. Caption: "Movimenta" + c-cedilha + a-tilde + "o Atual : "
850:         *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
851:         THIS.AddObject("lbl_4c_Label1", "Label")
852:         WITH THIS.lbl_4c_Label1
853:             .Top       = 110
854:             .Left      = 169
855:             .Width     = 109
856:             .Height    = 15
857: 
858:             *-- Ver nota 17 do cabecalho
859:             .AutoSize  = .F.
860:             .Alignment = 0
861: 
862:             .BackStyle = 0
863:             .FontName  = "Tahoma"
864:             .FontSize  = 8
865: 
866:             *-- Ver nota 18 do cabecalho
867:             .ForeColor = RGB(90, 90, 90)
868: 
869:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Atual : "
870:             .TabIndex  = 1
871:             .Visible   = .T.
872:         ENDWITH
873: 
874:         *-- GetOrigem: operacao de origem da copia (SigCdOpe.dopes char(20))
875:         THIS.AddObject("txt_4c_Origem", "TextBox")
876:         WITH THIS.txt_4c_Origem
877:             .Top       = 107
878:             .Left      = 280
879:             .Width     = 150
880:             .Height    = 23
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8

*-- Linhas 889 a 949:
889: 
890:             *-- Inicializacao de TIPO, nao de valor: o TextBox tem de nascer
891:             *-- CARACTERE. O valor em si - o "ThisForm.GetOrigem.Value =
892:             *-- pOperacao" do PROCEDURE Init legado - chega pelo BOParaForm no
893:             *-- fim deste metodo, que e a fonte UNICA dele (ver nota 30).
894:             .Value     = ""
895: 
896:             *-- Ver nota 19 do cabecalho. ReadOnly/TabStop NAO sao escritos
897:             *-- aqui: a regra de editabilidade mora em HabilitarCampos, que e
898:             *-- chamado logo abaixo. Escreve-la nos dois lugares era a receita
899:             *-- para os dois divergirem (nota 31).
900: 
901:             .Visible   = .T.
902:         ENDWITH
903: 
904:         *-- Ver nota 19 do cabecalho. O BINDEVENT so e registrado quando o
905:         *-- bloqueio de foco vale: ligado sempre, tornaria o campo inalcancavel
906:         *-- tambem no caminho sem chamador, em que ele e o unico jeito de
907:         *-- informar a origem.
908:         IF loc_lOrigemDoChamador
909:             BINDEVENT(THIS.txt_4c_Origem, "When", THIS, "OrigemWhen")
910:         ENDIF
911: 
912:         *-- Label2. Caption: "Nova Movimenta" + c-cedilha + a-tilde + "o : "
913:         *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
914:         THIS.AddObject("lbl_4c_Label2", "Label")
915:         WITH THIS.lbl_4c_Label2
916:             .Top       = 136
917:             .Left      = 169
918:             .Width     = 109
919:             .Height    = 15
920: 
921:             *-- Ver nota 17 do cabecalho
922:             .AutoSize  = .F.
923:             .Alignment = 0
924: 
925:             .BackStyle = 0
926:             .FontName  = "Tahoma"
927:             .FontSize  = 8
928: 
929:             *-- Ver nota 18 do cabecalho
930:             .ForeColor = RGB(90, 90, 90)
931: 
932:             .Caption   = "Nova Movimenta" + CHR(231) + CHR(227) + "o : "
933:             .TabIndex  = 2
934:             .Visible   = .T.
935:         ENDWITH
936: 
937:         *-- GetDestino: operacao NOVA, a que recebera a copia (SigCdOpe.dopes
938:         *-- char(20)). Nasce em BRANCO e digitavel em todo caminho: o Init
939:         *-- legado semeia apenas GetOrigem, e este campo e justamente o que o
940:         *-- usuario vem informar. Ver nota 21 do cabecalho.
941:         THIS.AddObject("txt_4c_Destino", "TextBox")
942:         WITH THIS.txt_4c_Destino
943:             .Top       = 134
944:             .Left      = 280
945:             .Width     = 150
946:             .Height    = 23
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949: 

*-- Linhas 956 a 1371:
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         *-- Ver nota 20: o "PROCEDURE Valid" de cada campo e ligado a
960:         *-- "LostFocus" - e ao SAIR do campo que o Valid legado roda.
961:         BINDEVENT(THIS.txt_4c_Origem,  "LostFocus", THIS, "ValidarOrigem")
962:         BINDEVENT(THIS.txt_4c_Destino, "LostFocus", THIS, "ValidarDestino")
963: 
964:         *-- Ver nota 23: F4/F5 e duplo clique desaguam no MESMO funil do
965:         *-- lookup de SigCdOpe que o LostFocus da origem usa.
966:         BINDEVENT(THIS.txt_4c_Origem, "KeyPress", THIS, "TxtOrigemKeyPress")
967:         BINDEVENT(THIS.txt_4c_Origem, "DblClick", THIS, "TxtOrigemDblClick")
968: 
969:         *-- Ver nota 30: espelho Business Object -> tela. E ele que poe na
970:         *-- origem o valor que o chamador trouxe (o
971:         *-- "ThisForm.GetOrigem.Value = pOperacao" do Init legado), e ele
972:         *-- termina chamando HabilitarCampos, que aplica a regra de
973:         *-- editabilidade da nota 19 - origem do chamador somente-exibicao,
974:         *-- origem em branco digitavel.
975:         THIS.BOParaForm()
976: 
977:         *-- "ThisForm.GetOrigem.Refresh" do PROCEDURE Init legado
978:         THIS.txt_4c_Origem.Refresh()
979:     ENDPROC
980: 
981:     *--------------------------------------------------------------------------
982:     * OrigemWhen - equivalente ao "PROCEDURE When / Return .f." de GetOrigem:
983:     * o campo EXIBE a operacao de origem trazida pelo chamador e nunca recebe
984:     * foco, nem por Tab nem por clique.
985:     *
986:     * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
987:     * falha em silencio (regra #3). Ver nota 19 do cabecalho.
988:     *--------------------------------------------------------------------------
989:     FUNCTION OrigemWhen()
990:         RETURN .F.
991:     ENDFUNC
992: 
993:     *--------------------------------------------------------------------------
994:     * ValidarOrigem - "PROCEDURE Valid" de GetOrigem, ligado a "LostFocus".
995:     *
996:     * Legado:
997:     *   If !IsEmpty( This.Value )
998:     *       xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'csSigCdOpe',
999:     *                            'Dopes', This.Value, 'Operacoes', .t., 'Dopes')
1000:     *       If Not xBrox.plAchouRegistro
1001:     *           xBrox.mAddColuna('Dopes', '', 'Operacao', .t.)
1002:     *           xBrox.Show()
1003:     *       EndIf
1004:     *       This.Value = Iif( LastKey() # 27, Evaluate('csSigCdOpe.Dopes'), '' )
1005:     *   Else
1006:     *       If Lastkey() <> 27
1007:     *           MessageBox("Operacao Deve ser informada !!!",16,"")
1008:     *           Return .f.
1009:     *       Endif
1010:     *   Endif
1011:     *
1012:     * Campo PREENCHIDO -> funil do lookup (AbrirBuscaOrigem, que reproduz o
1013:     * fwBuscaExt inteiro). Campo VAZIO e saida que NAO foi por ESC -> avisa e
1014:     * devolve o foco: BINDEVENT descarta o retorno do delegate, entao o efeito
1015:     * observavel do "Return .f." legado (o foco nao sai do campo) se reproduz
1016:     * com SetFocus, nao com RETURN .F.
1017:     *
1018:     * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
1019:     * falha em silencio (regra #3). Sem parametros: LostFocus nao passa nenhum.
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE ValidarOrigem()
1022:         LOCAL loc_cValor, loc_oErro
1023: 
1024:         *-- Ver nota 22: o picker e MODAL e o SetFocus do ramo vazio devolve o
1025:         *-- foco ao campo - as duas coisas redisparam este proprio LostFocus.
1026:         IF THIS.this_lEmLookupOrigem
1027:             RETURN
1028:         ENDIF
1029: 
1030:         loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)
1031: 
1032:         *-- LostFocus dispara SEMPRE que o foco sai do campo, mesmo sem
1033:         *-- alteracao nenhuma - o Valid legado so age quando o conteudo MUDA.
1034:         *-- Sem esta guarda, so passar o foco pelo campo (sem editar nada)
1035:         *-- reabriria o lookup de SigCdOpe a cada vez. O ramo de campo VAZIO
1036:         *-- fica de fora da guarda (nunca atualiza o valor memorizado), para
1037:         *-- continuar avisando "Operacao Deve ser informada" a cada passagem
1038:         *-- enquanto o campo ficar vazio - exatamente como o legado.
1039:         IF loc_cValor == THIS.this_cUltimoValidarOrigemValidado
1040:             RETURN
1041:         ENDIF
1042: 
1043:         THIS.this_lEmLookupOrigem = .T.
1044: 
1045:         TRY
1046:             IF EMPTY(loc_cValor)
1047:                 *-- Ramo ELSE do legado. LASTKEY() = 27 e a saida por ESC, em
1048:                 *-- que o legado nao avisa nada.
1049:                 IF LASTKEY() != 27
1050:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser informada !!!")
1051:                     THIS.txt_4c_Origem.SetFocus()
1052:                 ENDIF
1053:             ELSE
1054:                 THIS.AbrirBuscaOrigem()
1055: 
1056:                 *-- Validacao bem-sucedida: memoriza o valor FINAL (o lookup
1057:                 *-- pode ter trocado o conteudo do campo) para a guarda acima
1058:                 *-- nao reabrir o lookup na proxima passagem sem alteracao.
1059:                 THIS.this_cUltimoValidarOrigemValidado = ALLTRIM(THIS.txt_4c_Origem.Value)
1060:             ENDIF
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message + CHR(13) + ;
1063:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1064:                     "Procedure: " + loc_oErro.Procedure, ;
1065:                     "Erro em ValidarOrigem")
1066:         ENDTRY
1067: 
1068:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1069:         THIS.this_lEmLookupOrigem = .F.
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     * TxtOrigemKeyPress - segunda entrada do funil do lookup: F4 (115) e F5
1074:     * (116), as teclas que o projeto usa para chamar o picker.
1075:     *
1076:     * ENTER e TAB NAO entram aqui DE PROPOSITO: as duas MOVEM o foco, logo o
1077:     * LostFocus (ValidarOrigem) ja abre o funil, e abrir aqui tambem faria o
1078:     * picker aparecer duas vezes seguidas. Abrir o picker sem testar a tecla
1079:     * faria o dialogo subir a CADA caractere digitado (regra #47).
1080:     *
1081:     * Os dois parametros do evento sao OBRIGATORIOS na assinatura: handler sem
1082:     * eles ligado a KeyPress estoura a cada tecla (regra #3).
1083:     *--------------------------------------------------------------------------
1084:     PROCEDURE TxtOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1085:         IF VARTYPE(par_nKeyCode) = "N"
1086:             IF INLIST(par_nKeyCode, 115, 116)
1087:                 THIS.AbrirBuscaOrigem()
1088:             ENDIF
1089:         ENDIF
1090:     ENDPROC
1091: 
1092:     *--------------------------------------------------------------------------
1093:     * TxtOrigemDblClick - terceira entrada do funil do lookup. O duplo clique
1094:     * no campo e o atalho de mouse equivalente ao F4; o legado nao o tem
1095:     * porque com When = .F. o GetOrigem nunca recebe clique nenhum, e no
1096:     * caminho em que o campo e digitavel (nota 19) ele e o atalho esperado.
1097:     *--------------------------------------------------------------------------
1098:     PROCEDURE TxtOrigemDblClick()
1099:         THIS.AbrirBuscaOrigem()
1100:     ENDPROC
1101: 
1102:     *--------------------------------------------------------------------------
1103:     * AbrirBuscaOrigem - FUNIL UNICO do lookup de operacoes, chamado pelas tres
1104:     * entradas (LostFocus, F4/F5 e duplo clique). Reproduz o fwBuscaExt do
1105:     * GetOrigem.Valid legado com o FormBuscaAuxiliar do sistema novo:
1106:     *
1107:     *   fwBuscaExt(pnIdConn, 'SigCdOpe', 'csSigCdOpe', 'Dopes', This.Value,
1108:     *              'Operacoes', .t., 'Dopes')
1109:     *     -> CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe",
1110:     *                     "cursor_4c_BuscaOpe", "Dopes", <valor>, "Operacoes")
1111:     *   plAchouRegistro -> this_lAchouRegistro
1112:     *   mAddColuna      -> mAddColuna (mesmo nome)
1113:     *
1114:     * UMA unica coluna no picker, como o legado: SigCdOpe nao tem coluna de
1115:     * descricao - Dopes char(20) e ao mesmo tempo a chave e o texto da
1116:     * operacao. Acrescentar uma segunda coluna ("descrs"/"Descrs") estouraria
1117:     * "Variable 'DESCRS' is not found" dentro do FormBuscaAuxiliar.
1118:     *
1119:     * Ver notas 21, 22 e 24 do cabecalho.
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE AbrirBuscaOrigem()
1122:         LOCAL loc_oBusca, loc_cValor, loc_lEmLookupAnt, loc_oErro
1123: 
1124:         *-- Ver nota 22: SAVE/RESTORE, nao set/clear - este metodo e chamado
1125:         *-- de DENTRO do ValidarOrigem (que ja ligou a flag) e tambem direto
1126:         *-- pelo F4/duplo clique. Um clear fixo liberaria a guarda antes de o
1127:         *-- ValidarOrigem terminar, e o LostFocus de volta do picker abriria um
1128:         *-- segundo dialogo.
1129:         loc_lEmLookupAnt          = THIS.this_lEmLookupOrigem
1130:         THIS.this_lEmLookupOrigem = .T.
1131: 
1132:         TRY
1133:             *-- Ver nota 21: quando a origem veio do chamador o campo e
1134:             *-- somente-exibicao (When = .F. do legado), e o lookup - que no
1135:             *-- legado e inalcancavel por esse mesmo motivo - nao pode alterar
1136:             *-- o valor. Guarda por IF, nunca por RETURN: um RETURN aqui
1137:             *-- deixaria a flag de reentrancia ligada para sempre e mataria o
1138:             *-- lookup pelo resto da vida do form (regra #47).
1139:             IF !THIS.txt_4c_Origem.ReadOnly
1140:                 loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)
1141: 
1142:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1143:                     "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1144:                     "Opera" + CHR(231) + CHR(245) + "es")
1145: 
1146:                 IF VARTYPE(loc_oBusca) = "O"
1147:                     *-- Contrato do FormBuscaAuxiliar (regra #37): o Init ja
1148:                     *-- tentou o match EXATO e, achando UM registro, resolveu o
1149:                     *-- valor sozinho - nesse caso o dialogo NAO deve aparecer.
1150:                     IF !loc_oBusca.this_lAchouRegistro
1151:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1152:                         loc_oBusca.Show()
1153:                     ENDIF
1154: 
1155:                     *-- Atribuir SO sob a guarda de selecao: nada escolhido
1156:                     *-- (ESC/Cancelar) deixa no campo o que o usuario digitou.
1157:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1158:                         SELECT cursor_4c_BuscaOpe
1159:                         THIS.txt_4c_Origem.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1160:                     ENDIF
1161: 
1162:                     loc_oBusca.Release()
1163:                 ENDIF
1164:             ENDIF
1165:         CATCH TO loc_oErro
1166:             MsgErro(loc_oErro.Message + CHR(13) + ;
1167:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1168:                     "Procedure: " + loc_oErro.Procedure, ;
1169:                     "Erro em AbrirBuscaOrigem")
1170:         ENDTRY
1171: 
1172:         *-- Restaurar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1173:         THIS.this_lEmLookupOrigem = loc_lEmLookupAnt
1174: 
1175:         IF USED("cursor_4c_BuscaOpe")
1176:             USE IN cursor_4c_BuscaOpe
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * ValidarDestino - "PROCEDURE Valid" de GetDestino, ligado a "LostFocus".
1182:     *
1183:     * Legado:
1184:     *   If NOt Empty(This.Value) And Not Lastkey() = 27
1185:     *       Sqlexecute([Select dopes from SigCdOpe Where Dopes = ']+this.Value+['],
1186:     *                  'csSigCdOpe')
1187:     *       Select csSigCdOpe
1188:     *       If ! Eof()
1189:     *           MessageBox('Operacao ja Cadastrada !!!',16,'')
1190:     *           Return .f.
1191:     *       EndIf
1192:     *   EndIf
1193:     *
1194:     * Conferencia de duplicidade - NAO e lookup, e o INVERSO dele: aqui o
1195:     * usuario informa uma operacao que ainda NAO existe, e achar registro e
1196:     * que reprova. Por isso nao ha picker neste campo: abrir um dialogo de
1197:     * escolha para um codigo que precisa ser novo nao faria sentido, e nenhuma
1198:     * das tres classes fwBusca* aparece no Valid do GetDestino no dump.
1199:     *
1200:     * O codigo digitado NUNCA e apagado (regra #50): o legado tambem nao o
1201:     * apaga - devolve o foco para o usuario corrigir.
1202:     *
1203:     * Ver notas 20, 22 e 24 do cabecalho.
1204:     *--------------------------------------------------------------------------
1205:     PROCEDURE ValidarDestino()
1206:         LOCAL loc_cValor, loc_nResultado, loc_lDuplicada, loc_oErro
1207: 
1208:         *-- Ver nota 22: o MsgAviso e modal e o SetFocus devolve o foco ao
1209:         *-- campo - as duas coisas redisparam este proprio LostFocus.
1210:         IF THIS.this_lEmValidaDestino
1211:             RETURN
1212:         ENDIF
1213: 
1214:         THIS.this_lEmValidaDestino = .T.
1215: 
1216:         TRY
1217:             loc_cValor     = ALLTRIM(THIS.txt_4c_Destino.Value)
1218:             loc_lDuplicada = .F.
1219: 
1220:             *-- "If NOt Empty(This.Value) And Not Lastkey() = 27" do legado
1221:             IF !EMPTY(loc_cValor) AND LASTKEY() != 27
1222:                 *-- Ver nota 24: sem conexao viva (validacao de UI / modo
1223:                 *-- teste, com gnConnHandle = -1) o SQLEXEC dispara excecao -
1224:                 *-- a conferencia e pulada, e a do BO (ValidarDados) continua
1225:                 *-- sendo a barreira que impede a gravacao duplicada.
1226:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1227:                     IF USED("cursor_4c_DestinoDup")
1228:                         USE IN cursor_4c_DestinoDup
1229:                     ENDIF
1230: 
1231:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
1232:                         "SELECT dopes FROM SigCdOpe" + ;
1233:                         " WHERE dopes = " + EscaparSQL(loc_cValor), ;
1234:                         "cursor_4c_DestinoDup")
1235: 
1236:                     IF loc_nResultado >= 0
1237:                         *-- "Select csSigCdOpe / If ! Eof()" do legado
1238:                         loc_lDuplicada = (RECCOUNT("cursor_4c_DestinoDup") > 0)
1239:                     ELSE
1240:                         MsgErro("Erro ao conferir a opera" + CHR(231) + CHR(227) + ;
1241:                                 "o de destino." + CHR(13) + CapturarErroSQL(), ;
1242:                                 "Erro SQL")
1243:                     ENDIF
1244: 
1245:                     IF USED("cursor_4c_DestinoDup")
1246:                         USE IN cursor_4c_DestinoDup
1247:                     ENDIF
1248:                 ENDIF
1249: 
1250:                 IF loc_lDuplicada
1251:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
1252:                              " Cadastrada !!!")
1253:                     THIS.txt_4c_Destino.SetFocus()
1254:                 ENDIF
1255:             ENDIF
1256:         CATCH TO loc_oErro
1257:             MsgErro(loc_oErro.Message + CHR(13) + ;
1258:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1259:                     "Procedure: " + loc_oErro.Procedure, ;
1260:                     "Erro em ValidarDestino")
1261:         ENDTRY
1262: 
1263:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1264:         THIS.this_lEmValidaDestino = .F.
1265:     ENDPROC
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * BtnCopiarClick - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado) e a ACAO
1269:     * PRINCIPAL da tela: copia a operacao de ORIGEM inteira para a operacao de
1270:     * DESTINO digitada, atravessando 15 tabelas.
1271:     *
1272:     * Transcricao do "PROCEDURE CmdCopia.Click", na MESMA ordem:
1273:     *
1274:     *   If Empty(ThisForm.GetOrigem.Value)
1275:     *       MessageBox('Origem Invalida !!!',16,'')
1276:     *       Return
1277:     *   EndIf
1278:     *   If Empty(ThisForm.GetDestino.Value)
1279:     *       MessageBox('Destino Invalido !!!',16,'')
1280:     *       Return
1281:     *   EndIf
1282:     *   lcOpeOri = ThisForm.GetOrigem.Value
1283:     *   lcOpeDes = ThisForm.GetDestino.Value
1284:     *   lnNDopes = fGerUniqueKey("SigCdOpe")
1285:     *   ...  (Zap/Scatter/Gather/Insert das 15 tabelas + bloco de SigCdPrg)
1286:     *   fGravarLog( 'C', Thisform.Name, 'COPIA', lcTransacao )
1287:     *   ThisForm.poDatamgr.UpDate(...) x15 / ThisForm.poDatamgr.Commit()
1288:     *   ThisForm.Release
1289:     *
1290:     * As 459 linhas do MEIO - a geracao de nDopes/Programas, os Zap/Scatter/
1291:     * Gather de cada tabela, o bloco de permissoes de SigCdPrg e o Commit -
1292:     * moram em SigOpCopBO.Inserir (Fase 2), que as executa numa transacao
1293:     * UNICA. Aqui fica so o que o Click faz em volta: conferir os dois campos,
1294:     * entregar os valores ao Business Object e fechar a tela.
1295:     *
1296:     * PUBLIC porque e alvo de BINDEVENT (handler PROTECTED falha em silencio).
1297:     *
1298:     * Ver notas 25 a 29 do cabecalho.
1299:     *--------------------------------------------------------------------------
1300:     PROCEDURE BtnCopiarClick()
1301:         LOCAL loc_cOrigem, loc_cDestino, loc_lProsseguir, loc_lCopiou, loc_oErro
1302: 
1303:         *-- Ver nota 26: a copia abre uma transacao de 15 tabelas e os MsgAviso
1304:         *-- dos guards tiram e devolvem o foco - duplo clique no botao
1305:         *-- dispararia o processo duas vezes.
1306:         IF THIS.this_lEmCopia
1307:             RETURN
1308:         ENDIF
1309: 
1310:         THIS.this_lEmCopia = .T.
1311: 
1312:         loc_lCopiou = .F.
1313: 
1314:         TRY
1315:             loc_lProsseguir = .T.
1316: 
1317:             loc_cOrigem  = ALLTRIM(THIS.txt_4c_Origem.Value)
1318:             loc_cDestino = ALLTRIM(THIS.txt_4c_Destino.Value)
1319: 
1320:             *-- "If Empty(ThisForm.GetOrigem.Value) / MessageBox / Return"
1321:             IF EMPTY(loc_cOrigem)
1322:                 MsgAviso("Origem Invalida !!!")
1323:                 loc_lProsseguir = .F.
1324:             ENDIF
1325: 
1326:             *-- "If Empty(ThisForm.GetDestino.Value) / MessageBox / Return"
1327:             IF loc_lProsseguir
1328:                 IF EMPTY(loc_cDestino)
1329:                     *-- Literal do legado, SEM acento ("Invalido"), igual ao
1330:                     *-- texto que SigOpCopBO.ValidarDados usa
1331:                     MsgAviso("Destino Invalido !!!")
1332:                     loc_lProsseguir = .F.
1333:                 ENDIF
1334:             ENDIF
1335: 
1336:             IF loc_lProsseguir
1337:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
1338:                     MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1339:                             "o dispon" + CHR(237) + "vel - a c" + CHR(243) + ;
1340:                             "pia n" + CHR(227) + "o pode ser executada.", ;
1341:                             "Erro em BtnCopiarClick")
1342:                     loc_lProsseguir = .F.
1343:                 ENDIF
1344:             ENDIF
1345: 
1346:             IF loc_lProsseguir
1347:                 *-- Ver nota 25: NovoRegistro() ANTES do espelho, porque ele
1348:                 *-- chama LimparDados() e zeraria propriedades recem-escritas.
1349:                 THIS.this_oBusinessObject.NovoRegistro()
1350: 
1351:                 *-- Ver nota 30: o espelho tela -> Business Object mora em
1352:                 *-- FormParaBO, nao inline aqui. Ele devolve .F. quando a
1353:                 *-- transferencia nao pode ser feita, e nesse caso a gravacao
1354:                 *-- ABORTA: seguir em frente gravaria registro PARCIAL sem
1355:                 *-- erro visivel.
1356:                 IF !THIS.FormParaBO()
1357:                     loc_lProsseguir = .F.
1358:                 ENDIF
1359:             ENDIF
1360: 
1361:             IF loc_lProsseguir
1362:                 *-- Ver nota 31: a tela e travada enquanto a transacao das 15
1363:                 *-- tabelas corre. O destravamento NAO fica aqui - esta DEPOIS
1364:                 *-- do ENDTRY, junto com a liberacao da guarda, senao uma
1365:                 *-- excecao no Salvar deixaria a tela travada para sempre
1366:                 *-- (quem desabilita tem de reabilitar - regra #40).
1367:                 THIS.HabilitarCampos(.F.)
1368: 
1369:                 *-- Salvar() roda ValidarDados() (que repete os dois guards e a
1370:                 *-- conferencia de duplicidade) e so depois chama Inserir(), que
1371:                 *-- e o copiador das 15 tabelas em transacao unica.

*-- Linhas 1385 a 1527:
1385:             loc_lCopiou = .F.
1386:             MsgErro(loc_oErro.Message + CHR(13) + ;
1387:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1388:                     "Procedure: " + loc_oErro.Procedure, ;
1389:                     "Erro em BtnCopiarClick")
1390:         ENDTRY
1391: 
1392:         *-- Liberar DEPOIS do ENDTRY (vale tambem quando o CATCH dispara) e
1393:         *-- ANTES do Release() - ver nota 26. O destravamento da tela anda
1394:         *-- junto, pelo mesmo motivo: no caminho de sucesso o form fecha logo
1395:         *-- abaixo e o estado nao importa, mas no caminho de FALHA (recusa do
1396:         *-- ValidarDados ou excecao) a tela continua aberta e tem de voltar a
1397:         *-- aceitar digitacao para o usuario corrigir o destino.
1398:         THIS.this_lEmCopia = .F.
1399:         THIS.HabilitarCampos(.T.)
1400: 
1401:         IF loc_lCopiou
1402:             *-- Ver nota 27: repinte da lista do chamador, que no legado vinha
1403:             *-- de graca pelo cursor compartilhado, e so depois o
1404:             *-- "ThisForm.Release" que fecha o Click legado.
1405:             THIS.AtualizarFormPai()
1406:             THIS.Release()
1407:         ENDIF
1408:     ENDPROC
1409: 
1410:     *--------------------------------------------------------------------------
1411:     * AtualizarFormPai - recarrega a lista do form CHAMADOR depois de uma copia
1412:     * bem-sucedida.
1413:     *
1414:     * No legado o dialogo adota a data session do pai
1415:     * ("ThisForm.DataSessionId = poForm.DataSessionId") e grava nos cursores
1416:     * crSigCdOpe/crSigOpCdc/... que sao os MESMOS do Cadastro de Operacoes -
1417:     * inclusive o RecordSource da grade dele. O PILAR 3 eliminou o cursor
1418:     * global compartilhado (cada form tem o seu BO e o seu cursor_4c_*), entao
1419:     * o repinte que o legado ganhava de brinde precisa ser escrito a mao.
1420:     *
1421:     * O pai e OPCIONAL (.NULL. quando a tela e aberta pelo menu ou pelo
1422:     * harness) e nem todo chamador tem CarregarLista, dai as duas guardas; e a
1423:     * falha de repinte e AVISO, nunca erro fatal - a copia ja esta confirmada
1424:     * no banco. Ver nota 27.
1425:     *--------------------------------------------------------------------------
1426:     PROTECTED PROCEDURE AtualizarFormPai()
1427:         LOCAL loc_oErro
1428: 
1429:         IF VARTYPE(THIS.this_oFormPai) != "O"
1430:             RETURN
1431:         ENDIF
1432: 
1433:         TRY
1434:             *-- PEMSTATUS com atributo 5 confere EXISTENCIA do membro, que e
1435:             *-- exatamente o que se quer aqui (nao escopo - ver regra #34)
1436:             IF PEMSTATUS(THIS.this_oFormPai, "CarregarLista", 5)
1437:                 THIS.this_oFormPai.CarregarLista()
1438:             ENDIF
1439:         CATCH TO loc_oErro
1440:             MsgAviso("A c" + CHR(243) + "pia foi gravada, mas a lista da tela " + ;
1441:                      "anterior n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
1442:                      "atualizada:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1443:                      "Reabra a tela de Opera" + CHR(231) + CHR(245) + "es para " + ;
1444:                      "ver a nova movimenta" + CHR(231) + CHR(227) + "o.")
1445:         ENDTRY
1446:     ENDPROC
1447: 
1448:     *--------------------------------------------------------------------------
1449:     * BtnEncerrarClick - cmg_4c_Botoes.Buttons(2) (CmdExit do legado), cujo
1450:     * Click inteiro e "Release Windows": fecha a tela e devolve o controle ao
1451:     * form chamador.
1452:     *
1453:     * THIS.Release() e o equivalente na arquitetura nova - dispara o Destroy,
1454:     * que solta a referencia ao chamador e delega ao FormBase (liberacao do
1455:     * Business Object + restauracao dos popups do menu principal). PUBLIC
1456:     * porque e alvo de BINDEVENT: handler PROTECTED falha em silencio.
1457:     *--------------------------------------------------------------------------
1458:     PROCEDURE BtnEncerrarClick()
1459:         THIS.Release()
1460:     ENDPROC
1461: 
1462:     *--------------------------------------------------------------------------
1463:     * HabilitarCampos - estado de EDICAO dos dois campos e do botao de acao.
1464:     *
1465:     * Centraliza a UNICA regra de editabilidade que o SIGOPCOP tem, para que
1466:     * ela nao fique duplicada em ConfigurarCampos, LimparCampos e BOParaForm:
1467:     *
1468:     *   txt_4c_Origem  - somente-exibicao QUANDO a origem veio do chamador
1469:     *                    (equivalente ao "PROCEDURE When / Return .f." do
1470:     *                    GetOrigem legado); digitavel quando a tela foi aberta
1471:     *                    sem chamador - ver nota 19 do cabecalho
1472:     *   txt_4c_Destino - sempre digitavel: e o campo que o usuario vem informar
1473:     *
1474:     * par_lHabilitar = .F. TRAVA a tela (os dois campos e o Copiar) e e usado
1475:     * enquanto a transacao das 15 tabelas corre; par_lHabilitar = .T. devolve
1476:     * cada controle ao estado que a regra acima manda - nao a ".T. em tudo",
1477:     * senao a origem trazida pelo chamador viraria editavel e a tela divergiria
1478:     * do legado. Ver nota 31.
1479:     *
1480:     * Encerrar fica FORA: ele nunca e desabilitado, nem durante a copia - e a
1481:     * unica saida da tela (o form tem ControlBox = .F. e TitleBar = 0, logo nao
1482:     * ha botao de fechar da janela), e desabilita-lo deixaria o usuario preso.
1483:     *
1484:     * PROTECTED: so o proprio form chama. Nao e hook de FormBase e nada fora
1485:     * da classe precisa dele.
1486:     *--------------------------------------------------------------------------
1487:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1488:         LOCAL loc_lHabilitar, loc_lOrigemDoChamador
1489: 
1490:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1491: 
1492:         *-- Ver nota 19: a origem recebida do chamador e somente-exibicao
1493:         loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))
1494: 
1495:         IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1496:             WITH THIS.txt_4c_Origem
1497:                 .ReadOnly = loc_lOrigemDoChamador OR !loc_lHabilitar
1498:                 .TabStop  = !loc_lOrigemDoChamador AND loc_lHabilitar
1499:             ENDWITH
1500:         ENDIF
1501: 
1502:         IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1503:             WITH THIS.txt_4c_Destino
1504:                 .ReadOnly = !loc_lHabilitar
1505:                 .TabStop  = loc_lHabilitar
1506:             ENDWITH
1507:         ENDIF
1508: 
1509:         *-- Buttons(1) = CmdCopia. Enabled, nao Visible: o botao tem Caption
1510:         *-- ALEM do Picture, e Buttons(N) de CommandGroup desenha o icone
1511:         *-- normalmente com Enabled = .F. - o apagamento de icone em
1512:         *-- Enabled = .F. e de CommandButton STANDALONE icone-only (Caption
1513:         *-- vazio), que nao e o caso aqui.
1514:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1515:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHabilitar
1516:         ENDIF
1517:     ENDPROC
1518: 
1519:     *--------------------------------------------------------------------------
1520:     * LimparCampos - devolve a tela ao estado de abertura.
1521:     *
1522:     * NAO e "zerar os dois campos": a origem volta ao valor que o chamador
1523:     * trouxe - que e o que o "ThisForm.GetOrigem.Value = pOperacao" do Init
1524:     * legado poe la, e o que o usuario precisa ver para saber O QUE esta sendo
1525:     * copiado - e so o DESTINO, o campo que o usuario digita, e esvaziado.
1526:     * Zerar os dois faria a tela perder o contexto da copia sem que nada o
1527:     * recolocasse, porque o Init nao roda de novo.

*-- Linhas 1533 a 1706:
1533:     * nivel da heranca torna o metodo protegido, e declara-lo sem modificador
1534:     * aqui NAO alargaria o escopo (regra #51). Nada fora da classe o chama.
1535:     *--------------------------------------------------------------------------
1536:     PROTECTED PROCEDURE LimparCampos()
1537:         IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1538:             THIS.txt_4c_Origem.Value = THIS.this_cOperacaoOrigem
1539:         ENDIF
1540: 
1541:         IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1542:             THIS.txt_4c_Destino.Value = ""
1543:         ENDIF
1544: 
1545:         THIS.HabilitarCampos(.T.)
1546:     ENDPROC
1547: 
1548:     *--------------------------------------------------------------------------
1549:     * FormParaBO - espelho TELA -> Business Object.
1550:     *
1551:     * E o "lcOpeOri = ThisForm.GetOrigem.Value / lcOpeDes =
1552:     * ThisForm.GetDestino.Value" do CmdCopia.Click legado: os DOIS unicos
1553:     * valores que esta tela produz, que sao exatamente os dois campos
1554:     * editaveis do SCX.
1555:     *
1556:     * As demais propriedades do SigOpCopBO (nDopes, Programas, Menus,
1557:     * SubMenus, CArqIcones, o bloco de SigCdPrg, a transacao) NAO entram aqui,
1558:     * e isso nao e esquecimento: nenhuma delas tem controle na tela. O legado
1559:     * as produz dentro do proprio Click - fGerUniqueKey para o nDopes e
1560:     * Scatter do registro de ORIGEM para o resto - e no migrado isso mora em
1561:     * SigOpCopBO.Inserir/CarregarOrigem. Transferi-las daqui seria inventar
1562:     * origem de dado que a tela nao tem.
1563:     *
1564:     * FUNCTION, nao PROCEDURE: devolve .F. quando a transferencia nao pode ser
1565:     * feita, e BtnCopiarClick ABORTA a gravacao nesse caso. Transferencia que
1566:     * falha e segue em frente grava registro PARCIAL sem erro visivel - o
1567:     * defeito silencioso que a regra do erro 11 em FormParaBO descreve.
1568:     *
1569:     * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
1570:     *--------------------------------------------------------------------------
1571:     PROTECTED FUNCTION FormParaBO()
1572:         LOCAL loc_lSucesso, loc_oErro
1573: 
1574:         loc_lSucesso = .F.
1575: 
1576:         TRY
1577:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1578:                PEMSTATUS(THIS, "txt_4c_Origem", 5) AND ;
1579:                PEMSTATUS(THIS, "txt_4c_Destino", 5)
1580: 
1581:                 *-- ALLTRIM nos DOIS: a chave de SigCdOpe e a coluna dopes
1582:                 *-- char(20) SOZINHA, nao uma chave posicional concatenada,
1583:                 *-- logo tirar o padding aqui nao desloca nada (regra #42). O
1584:                 *-- EscaparSQL do Business Object recebe o valor ja sem
1585:                 *-- brancos, como o legado faz ao concatenar This.Value direto
1586:                 *-- no WHERE.
1587:                 THIS.this_oBusinessObject.this_cOperacaoOrigem = ;
1588:                     ALLTRIM(THIS.txt_4c_Origem.Value)
1589: 
1590:                 THIS.this_oBusinessObject.this_cOperacaoDestino = ;
1591:                     ALLTRIM(THIS.txt_4c_Destino.Value)
1592: 
1593:                 loc_lSucesso = .T.
1594:             ELSE
1595:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel transferir " + ;
1596:                         "os dados da tela para o objeto de neg" + CHR(243) + "cio.", ;
1597:                         "Erro em FormParaBO")
1598:             ENDIF
1599:         CATCH TO loc_oErro
1600:             MsgErro(loc_oErro.Message + CHR(13) + ;
1601:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1602:                     "Procedure: " + loc_oErro.Procedure, ;
1603:                     "Erro em FormParaBO")
1604:         ENDTRY
1605: 
1606:         RETURN loc_lSucesso
1607:     ENDFUNC
1608: 
1609:     *--------------------------------------------------------------------------
1610:     * BOParaForm - espelho Business Object -> TELA, o inverso do FormParaBO
1611:     * sobre os MESMOS dois campos.
1612:     *
1613:     * No legado nao existe caminho de "carregar registro na tela": o SIGOPCOP
1614:     * recebe a origem por parametro e nunca reabre um registro gravado. Os
1615:     * dois usos aqui sao REAIS e nascem da arquitetura nova:
1616:     *
1617:     *   1. InicializarForm semeia o Business Object com a origem recebida do
1618:     *      chamador ANTES de os TextBox existirem; montados os campos, este
1619:     *      metodo e quem leva o valor a tela - no lugar de ConfigurarCampos
1620:     *      ler a propriedade por conta propria. Fonte UNICA do valor.
1621:     *   2. Quando o lookup de SigCdOpe resolve a origem (AbrirBuscaOrigem) ou
1622:     *      o Business Object normaliza o destino em ValidarDados, a tela passa
1623:     *      a refletir o que de fato sera gravado.
1624:     *
1625:     * Fecha reaplicando a regra de editabilidade: origem que ACABOU de chegar
1626:     * do Business Object e, por definicao, origem vinda do chamador, e tem de
1627:     * ficar somente-exibicao como no legado.
1628:     *
1629:     * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
1630:     *--------------------------------------------------------------------------
1631:     PROTECTED PROCEDURE BOParaForm()
1632:         LOCAL loc_cOrigem, loc_oErro
1633: 
1634:         TRY
1635:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1636:                 loc_cOrigem = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoOrigem, ""))
1637: 
1638:                 *-- A origem exibida e a que vale para o resto da tela:
1639:                 *-- HabilitarCampos e LimparCampos leem this_cOperacaoOrigem
1640:                 *-- para decidir se o campo e digitavel, entao o espelho
1641:                 *-- atualiza a propriedade do form JUNTO com o controle.
1642:                 THIS.this_cOperacaoOrigem = loc_cOrigem
1643: 
1644:                 IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1645:                     THIS.txt_4c_Origem.Value = loc_cOrigem
1646:                 ENDIF
1647: 
1648:                 IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1649:                     THIS.txt_4c_Destino.Value = ;
1650:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoDestino, ""))
1651:                 ENDIF
1652: 
1653:                 THIS.HabilitarCampos(.T.)
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             MsgErro(loc_oErro.Message + CHR(13) + ;
1657:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1658:                     "Procedure: " + loc_oErro.Procedure, ;
1659:                     "Erro em BOParaForm")
1660:         ENDTRY
1661:     ENDPROC
1662: 
1663:     *--------------------------------------------------------------------------
1664:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.;
1665:     * este metodo percorre a arvore e os torna visiveis.
1666:     *
1667:     * Sem lista de excecao: o SIGOPCOP nao tem container flutuante nem
1668:     * controle com Visible = .F. declarado no dump - os dez objetos do SCX
1669:     * estao todos na tela desde a abertura.
1670:     *--------------------------------------------------------------------------
1671:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1672:         LOCAL loc_nI, loc_oControle
1673: 
1674:         IF VARTYPE(par_oContainer) != "O"
1675:             RETURN
1676:         ENDIF
1677: 
1678:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1679:             loc_oControle = par_oContainer.Controls(loc_nI)
1680: 
1681:             IF VARTYPE(loc_oControle) = "O"
1682:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
1683:                     loc_oControle.Visible = .T.
1684:                 ENDIF
1685: 
1686:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
1687:                     THIS.TornarControlesVisiveis(loc_oControle)
1688:                 ENDIF
1689:             ENDIF
1690:         ENDFOR
1691:     ENDPROC
1692: 
1693:     *--------------------------------------------------------------------------
1694:     * Destroy - solta a referencia ao form chamador e delega ao FormBase, que
1695:     * libera o Business Object e restaura os popups do menu principal (fix
1696:     * menu-shrinks). DODEFAULT() na ULTIMA linha e obrigatorio: sem ele a
1697:     * cadeia de heranca e quebrada e os popups ficam com o cache visual
1698:     * encolhido.
1699:     *--------------------------------------------------------------------------
1700:     PROCEDURE Destroy()
1701:         THIS.this_oFormPai = .NULL.
1702: 
1703:         DODEFAULT()
1704:     ENDPROC
1705: 
1706: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCopBO.prg):
*==============================================================================
* SigOpCopBO.prg
*
* Business Object para FormSigOpCop - Copia de Movimentacao
* Legado: SigOpCop.SCX (task706)
*
* Tabela principal : SigCdOpe (chave: dopes char(20))
* Contador da PK   : SIGSYSEQ, chave "SigCdOpe" -> SigCdOpe.ndopes
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Duplica uma operacao de movimentacao inteira: le o registro de SigCdOpe
* identificado por this_cOperacaoOrigem e regrava tudo sob o nome novo
* this_cOperacaoDestino, propagando a copia para as 14 tabelas filhas e
* registrando as permissoes do programa novo em SigCdPrg.
*
* Ordem das tabelas, transcrita do CmdCopia.Click legado (os "Zap In" e os
* "poDatamgr.Update()" do legado seguem exatamente esta sequencia):
*
*    1  SigCdOpe   dopes              mestre            (1 linha)
*    2  SigOpCdc   dopes              configuracao      (1 linha)
*    3  SigOpCdi   dopes              itens             (N linhas)
*    4  SigOpCsn   cdopes + cidchaves subniveis         (N linhas)
*    5  SigOpCrr   dopes  + cidchaves recorrencias      (N linhas)
*    6  SigOpDup   dopes  + cidchaves duplicatas        (N linhas)
*    7  SigCdPrg   pkchaves           programa/acessos  (ate 15 linhas)
*    8  SigOpCdd   dopes              dados compl.      (N linhas)
*    9  SigMvCxs   cdopes + cidchaves caixas            (N linhas)
*   10  SigCcCpe   dopes  + cidchaves centro de custo   (N linhas)
*   11  SigCdMop   cdopes + cidchaves multi-operacao    (N linhas)
*   12  SigOpFpO   dopes  + cidchaves formas de pagto   (N linhas)
*   13  SigOpTrf   dopes  + cidchaves transferencias    (N linhas)
*   14  SigOpFin   dopes  + cidchaves financeiro        (N linhas)
*   15  SigOpLso   dopes  + cidchaves lancamentos       (N linhas)
*
* Conferido em docs/schema.sql (UTF-16, lido com Get-Content -Raw - regra #14):
* as tabelas que o legado alimenta com "m.cIdChaves = fUniqueIds()" sao
* exatamente as que POSSUEM a coluna cidchaves, e as que recebem apenas
* m.Dopes/m.cDopes sao as que NAO a possuem. A grafia da coluna de operacao
* tambem varia (dopes x cdopes) e esta anotada acima tabela por tabela - nao
* deduzir pelo prefixo do nome (regra #48).
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado copia registro a registro com "Scatter MemVar Memo" + "Gather
* MemVar", trazendo as colunas ao VFP so para devolve-las ao servidor. Como
* SigCdOpe tem 254 colunas e SigOpCdc/SigOpCdd passam de 240, a copia e feita
* server-side, preservando a semantica do Scatter/Gather (intersecao de
* colunas por NOME) - ver docs e regra #22 sobre colunas NOT NULL.
*
* Esta classe NAO e um CRUD: a tela tem um unico botao de acao (Copiar) e
* nunca altera nem exclui a operacao de origem. Por isso o comportamento
* herdado de BusinessBase para Excluir() ja e o correto e nao e redefinido.
*==============================================================================

DEFINE CLASS SigOpCopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Operacao de origem e de destino (SigCdOpe.dopes char(20))
    * Origem  : recebida do form pai (parametro pOperacao do Init legado)
    * Destino : digitada pelo usuario em txt_4c_Destino
    *--------------------------------------------------------------------------
    this_cOperacaoOrigem  = ""
    this_cOperacaoDestino = ""

    *--------------------------------------------------------------------------
    * Chaves geradas para o registro NOVO de SigCdOpe
    * Legado: lnNDopes    = fGerUniqueKey("SigCdOpe")
    *         lcProgramas = Padl(lnNDopes, 8, '0')
    *--------------------------------------------------------------------------
    this_nNDopes    = 0      && SigCdOpe.ndopes    numeric(4,0)
    this_cProgramas = ""     && SigCdOpe.programas char(15)

    *--------------------------------------------------------------------------
    * Campos lidos do registro de ORIGEM, usados para montar a descricao e a
    * barra de menu do programa novo em SigCdPrg
    *--------------------------------------------------------------------------
    this_cMenus     = ""     && SigCdOpe.menus      char(10)
    this_cSubMenus  = ""     && SigCdOpe.submenus   char(15)
    this_cArqIcones = ""     && SigCdOpe.carqicones char(64) NULL

    *--------------------------------------------------------------------------
    * Registro de programa e permissoes - SigCdPrg (todas as 6 colunas da
    * tabela sao NOT NULL, conferido no schema)
    * Legado: _Prog       = Padr(Padl(crSigCdOpe.NDopes, 8, '0'), 15)
    *         _Desc       = lcOperacao + Proper(...)
    *         lcSubMenus  = '_' + Upper(Left(crSigCdOpe.SubMenus, 14))
    *         lcBarraForm = Space(50) ou [SigMvExp WITH "<dopes>","E"]
    *--------------------------------------------------------------------------
    this_cProg         = ""  && SigCdPrg.programas  char(15)
    this_cDescPrograma = ""  && SigCdPrg.descricaos char(150)
    this_cSubMenuPrg   = ""  && SigCdPrg.programas  char(15) - entrada do submenu
    this_cBarraForm    = ""  && SigCdPrg.barraforms char(50)
    this_cBarraPict    = ""  && SigCdPrg.barrapict  char(60)
    this_cPrefixoMenu  = ""  && lcOperacao: prefixo textual da descricao

    *--------------------------------------------------------------------------
    * Log de auditoria do legado: fGravarLog('C', <form>, 'COPIA', lcTransacao)
    *--------------------------------------------------------------------------
    this_cTransacao = ""

    *--------------------------------------------------------------------------
    * Acompanhamento do processo (a copia atravessa 15 tabelas; a etapa atual
    * entra nas mensagens de erro para o usuario saber onde parou, no lugar do
    * "Favor Reinicializar o Processo!!!" generico do legado)
    *--------------------------------------------------------------------------
    this_cEtapaAtual        = ""
    this_nTabelasCopiadas   = 0
    this_nRegistrosCopiados = 0

    *--------------------------------------------------------------------------
    * Cursores de trabalho
    *--------------------------------------------------------------------------
    this_cCursorOrigem = "cursor_4c_OpeOrigem"   && registro mestre de origem
    this_cCursorAux    = "cursor_4c_OpeAux"      && conferencias pontuais
    this_cCursorBusca  = "cursor_4c_Busca"       && lookup de operacoes

    *--------------------------------------------------------------------------
    * Lote de comandos SQL acumulados pelo copiador (MontarLoteCopia +
    * CopiarTabelaFilha + os Acumular* de SigCdPrg) para execucao ATOMICA
    * unica em ExecutarLoteCopia - mesmo padrao de ProdutoBO.this_cLoteCopia
    *--------------------------------------------------------------------------
    this_cLoteCopia = ""

    *--------------------------------------------------------------------------
    * Init - define a tabela principal e a chave primaria
    *
    * NAO carrega dado nenhum aqui: Init de BO que devolve .F. destroi o
    * objeto, CREATEOBJECT retorna .F. e o form nunca abre - inclusive em
    * validacao de UI, onde gnConnHandle = -1 e qualquer SQLEXEC estoura.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "dopes"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpCopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Transcricao dos guards do CmdCopia.Click ("Origem
    * Invalida"/"Destino Invalido") + do GetDestino.Valid ("Opera??o j?
    * Cadastrada") do legado, mais uma conferencia defensiva de que a
    * origem existe (o legado confia no fwBuscaExt do Valid do campo, que
    * so roda quando o usuario passa pelo TextBox - aqui garantimos o mesmo
    * antes de abrir a transacao inteira).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cOrigem, loc_cDestino, loc_nResultado

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        loc_cOrigem  = ALLTRIM(NVL(THIS.this_cOperacaoOrigem, ""))
        loc_cDestino = ALLTRIM(NVL(THIS.this_cOperacaoDestino, ""))

        IF EMPTY(loc_cOrigem)
            THIS.this_cMensagemErro = "Origem Invalida !!!"
            loc_lValido = .F.
        ELSE
            IF EMPTY(loc_cDestino)
                THIS.this_cMensagemErro = "Destino Invalido !!!"
                loc_lValido = .F.
            ELSE
                IF USED("cursor_4c_OpeValida")
                    USE IN cursor_4c_OpeValida
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT dopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cOrigem), ;
                    "cursor_4c_OpeValida")

                IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_OpeValida") = 0
                    THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + ;
                        CHR(227) + "o encontrada."
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_OpeValida")
                    USE IN cursor_4c_OpeValida
                ENDIF

                IF loc_lValido
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT dopes FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDestino), ;
                        "cursor_4c_OpeValida")

                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_OpeValida") > 0
                        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o j" + ;
                            CHR(225) + " Cadastrada !!!"
                        loc_lValido = .F.
                    ENDIF

                    IF USED("cursor_4c_OpeValida")
                        USE IN cursor_4c_OpeValida
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigCdOpe que este BO modela
    * (Dopes/NDopes/Programas/Menus/SubMenus/CArqIcones) a partir do cursor
    * do registro de ORIGEM. As demais ~248 colunas de SigCdOpe NUNCA
    * passam pela memoria do VFP - a copia delas eh feita server-side via
    * MontarInsertCopia (ver nota de arquitetura no cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("Dopes") != "U"
                    THIS.this_cOperacaoOrigem = ALLTRIM(TratarNulo(Dopes, ""))
                ENDIF
                IF TYPE("NDopes") != "U"
                    THIS.this_nNDopes = TratarNulo(NDopes, 0)
                ENDIF
                IF TYPE("Programas") != "U"
                    THIS.this_cProgramas = ALLTRIM(TratarNulo(Programas, ""))
                ENDIF
                IF TYPE("Menus") != "U"
                    THIS.this_cMenus = ALLTRIM(TratarNulo(Menus, ""))
                ENDIF
                IF TYPE("SubMenus") != "U"
                    THIS.this_cSubMenus = ALLTRIM(TratarNulo(SubMenus, ""))
                ENDIF
                IF TYPE("CArqIcones") != "U"
                    THIS.this_cArqIcones = ALLTRIM(TratarNulo(CArqIcones, ""))
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpCopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOrigem - Busca o registro de origem em SigCdOpe e carrega
    * Menus/SubMenus/CArqIcones (necessarios para montar o bloco de
    * permissoes em SigCdPrg) via CarregarDoCursor. Equivalente ao "Select
    * CrSigCdOpe" implicito que o CmdCopia.Click legado faz antes do Scatter.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOrigem(par_cCodigoOrigem)
        LOCAL loc_lSucesso, loc_cCodigo, loc_nResultado

        loc_lSucesso = .F.
        loc_cCodigo  = ALLTRIM(NVL(par_cCodigoOrigem, ""))

        IF !EMPTY(loc_cCodigo)
            IF USED(THIS.this_cCursorOrigem)
                USE IN (THIS.this_cCursorOrigem)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Dopes, NDopes, Programas, Menus, SubMenus, CArqIcones" + ;
                " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo), ;
                THIS.this_cCursorOrigem)

            IF loc_nResultado >= 0 AND RECCOUNT(THIS.this_cCursorOrigem) > 0
                SELECT (THIS.this_cCursorOrigem)
                GO TOP
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorOrigem)
            ELSE
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de origem n" + ;
                    CHR(227) + "o encontrada."
            ENDIF

            IF USED(THIS.this_cCursorOrigem)
                USE IN (THIS.this_cCursorOrigem)
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para este BO a "chave" relevante para auditoria
    * eh a operacao recem-criada (destino), nao a origem - que permanece
    * intocada (ver nota de arquitetura no cabecalho).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cOperacaoDestino, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Transcricao de CmdCopia.Click: gera nDopes/Programas,
    * monta o lote inteiro (15 tabelas + bloco de permissoes SigCdPrg) e
    * executa tudo numa unica transacao atomica - igual ao legado, que so
    * descarrega os cursores no Update()/Commit() do fim.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cOrigem, loc_cDestino, loc_nNDopes, loc_cProgramas, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cOrigem  = ALLTRIM(NVL(THIS.this_cOperacaoOrigem, ""))
            loc_cDestino = UPPER(ALLTRIM(NVL(THIS.this_cOperacaoDestino, "")))

            IF EMPTY(loc_cOrigem)
                THIS.this_cMensagemErro = "Origem Invalida !!!"
            ELSE
                IF EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Destino Invalido !!!"
                ELSE
                    IF !THIS.CarregarOrigem(loc_cOrigem)
                        *-- mensagem ja definida por CarregarOrigem
                    ELSE
                        loc_nNDopes    = fGerUniqueKey("SigCdOpe")
                        loc_cProgramas = PADL(TRANSFORM(loc_nNDopes), 8, "0")

                        THIS.this_nNDopes    = loc_nNDopes
                        THIS.this_cProgramas = loc_cProgramas
                        THIS.this_cProg      = PADR(loc_cProgramas, 15)

                        IF THIS.MontarLoteCopia(loc_cOrigem, loc_cDestino, loc_nNDopes, loc_cProgramas)
                            THIS.MontarBlocoSigCdPrg(loc_cDestino)
                            loc_lSucesso = THIS.ExecutarLoteCopia()

                            IF loc_lSucesso
                                THIS.this_cOperacaoDestino = loc_cDestino
                                THIS.this_cTransacao       = loc_cDestino
                                fGravarLog("C", "FormSigOpCop", "COPIA", loc_cDestino)
                                THIS.RegistrarAuditoria("INSERT")
                            ENDIF
                        ELSE
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cLoteCopia = ""
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "SigOpCopBO.Inserir")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - O legado nao distingue INSERIR/ALTERAR neste dialogo: o
    * unico botao "Copiar" sempre cria uma operacao NOVA a partir da
    * origem. O fluxo canonico (NovoRegistro + Salvar) so chama Inserir(),
    * mas Atualizar() delega para o mesmo lugar para nao ficar quebrado se
    * algum caller chamar Salvar() sem passar por NovoRegistro().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarLoteCopia - Acumula em this_cLoteCopia o INSERT...SELECT de
    * cada uma das 14 tabelas (SigCdOpe + 13 filhas), na ORDEM do
    * CmdCopia.Click legado. SigCdPrg (15a tabela da lista do cabecalho)
    * NAO vem de origem - eh construida em MontarBlocoSigCdPrg().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteCopia(par_cOrigem, par_cDestino, par_nNDopes, par_cProgramas)
        LOCAL loc_lOk, loc_cSQL

        loc_lOk = .T.

        THIS.this_cLoteCopia         = ""
        THIS.this_nTabelasCopiadas   = 0
        THIS.this_nRegistrosCopiados = 0

        *-- SigCdOpe - registro mestre (1 linha)
        THIS.this_cEtapaAtual = "SigCdOpe"
        loc_cSQL = THIS.MontarInsertCopia("SigCdOpe", ;
            "dopes=" + EscaparSQL(par_cDestino) + ;
            "|ndopes=" + FormatarNumeroSQL(par_nNDopes, 0) + ;
            "|programas=" + EscaparSQL(par_cProgramas), ;
            "dopes = " + EscaparSQL(par_cOrigem))
        loc_lOk = !EMPTY(loc_cSQL)
        IF loc_lOk
            THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
            THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
        ENDIF

        *-- SigOpCdc - configuracao (1 linha)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdc"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdc", "dopes=" + EscaparSQL(par_cDestino), ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigOpCdi - itens (N linhas, sem cidchaves - a chave natural eh
        *-- dopes + o item do legado, preservado linha a linha)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdi"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdi", "dopes=" + EscaparSQL(par_cDestino), ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigOpCsn - subniveis (N linhas, cidchaves proprio). O inner join
        *-- do legado com SigCdOpe em a.cnivels = b.Dopes eh um filtro de
        *-- integridade (so copia subnivel cujo cnivels ainda exista como
        *-- operacao cadastrada) - replicado no WHERE, nao traz coluna nova.
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCsn"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpCsn", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "cnivels IN (SELECT dopes FROM SigCdOpe)")
        ENDIF

        *-- SigOpCrr - recorrencias (N linhas, cidchaves proprio). O inner
        *-- join do legado (a.dopes = b.Dopes Where a.Dopes = origem) eh
        *-- degenerado - SigCdOpe ja tem a linha de origem por definicao
        *-- (conferido em CarregarOrigem antes de chegar aqui).
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCrr"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpCrr", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpDup - duplicatas (N linhas, cidchaves proprio, mesmo join
        *-- degenerado de SigOpCrr)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpDup"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpDup", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpCdd - dados complementares (N linhas, sem cidchaves).
        *-- Legado: m.ConfigGers = Substr(m.ConfigGers,1,161) + Space(30) +
        *-- Substr(m.ConfigGers,192,59) - zera os 30 chars 162..191
        *-- (161+30+59 = 250 = Configgers char(250)). STUFF reproduz igual.
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpCdd"
            loc_cSQL = THIS.MontarInsertCopia("SigOpCdd", ;
                "dopes=" + EscaparSQL(par_cDestino) + ;
                "|configgers=STUFF(configgers, 162, 30, REPLICATE(' ', 30))", ;
                "dopes = " + EscaparSQL(par_cOrigem))
            loc_lOk = !EMPTY(loc_cSQL)
            IF loc_lOk
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
            ENDIF
        ENDIF

        *-- SigMvCxs - caixas (N linhas, cidchaves proprio, liga por cdopes)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigMvCxs"
            loc_lOk = THIS.CopiarTabelaFilha("SigMvCxs", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigCcCpe - centro de custo (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigCcCpe"
            loc_lOk = THIS.CopiarTabelaFilha("SigCcCpe", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigCdMop - multi-operacao (N linhas, cidchaves proprio, liga por cdopes)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigCdMop"
            loc_lOk = THIS.CopiarTabelaFilha("SigCdMop", "cdopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpFpO - formas de pagamento (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpFpO"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpFpO", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpTrf - transferencias (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpTrf"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpTrf", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpFin - financeiro (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpFin"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpFin", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        *-- SigOpLso - lancamentos (N linhas, cidchaves proprio)
        IF loc_lOk
            THIS.this_cEtapaAtual = "SigOpLso"
            loc_lOk = THIS.CopiarTabelaFilha("SigOpLso", "dopes", "cidchaves", ;
                par_cOrigem, par_cDestino, "", "")
        ENDIF

        IF !loc_lOk AND EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
            THIS.this_cMensagemErro = "Falha ao montar a c" + CHR(243) + "pia de " + ;
                ALLTRIM(NVL(THIS.this_cEtapaAtual, "")) + "."
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarBlocoSigCdPrg - Transcricao do bloco final do CmdCopia.Click
    * que registra o programa novo e as 13 permissoes em SigCdPrg. Usa
    * Menus/SubMenus/CArqIcones ja carregados pela ORIGEM (this_cMenus etc.
    * nao sao sobrescritos na copia - sao os mesmos no registro novo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarBlocoSigCdPrg(par_cDestino)
        LOCAL loc_cOperacao, loc_lUsaBarra, loc_cBarraForm, loc_cSubMenuProg, loc_cDescBase

        THIS.this_cEtapaAtual = "SigCdPrg"

        loc_cOperacao = IIF(UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))) == "CAIXA", ;
            "Menu - Financeiro - Caixa - ", ;
            "Opera" + CHR(231) + CHR(245) + "es de Estoque - ")
        THIS.this_cPrefixoMenu = loc_cOperacao

        loc_lUsaBarra = INLIST(UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))), "SISTEMA", "CAIXA") ;
            OR UPPER(ALLTRIM(NVL(THIS.this_cMenus, ""))) == "ESTOQUE"

        loc_cBarraForm = SPACE(50)
        IF loc_lUsaBarra
            loc_cBarraForm = 'SigMvExp WITH "' + UPPER(ALLTRIM(par_cDestino)) + '","E"'
        ENDIF
        THIS.this_cBarraForm = loc_cBarraForm
        THIS.this_cBarraPict = ALLTRIM(NVL(THIS.this_cArqIcones, ""))

        IF !EMPTY(ALLTRIM(NVL(THIS.this_cSubMenus, "")))
            loc_cSubMenuProg = "_" + UPPER(LEFT(ALLTRIM(THIS.this_cSubMenus), 14))
            THIS.this_cSubMenuPrg = loc_cSubMenuProg

            THIS.AcumularSubMenuPrograma(loc_cSubMenuProg, ;
                loc_cOperacao + PROPER(ALLTRIM(THIS.this_cSubMenus)))

            loc_cDescBase = loc_cOperacao + PROPER(ALLTRIM(THIS.this_cSubMenus)) + ;
                " - " + PROPER(ALLTRIM(par_cDestino))
        ELSE
            loc_cDescBase = loc_cOperacao + PROPER(ALLTRIM(par_cDestino))
        ENDIF
        THIS.this_cDescPrograma = loc_cDescBase

        THIS.AcumularProgramaBase(THIS.this_cProg, loc_cDescBase, loc_cBarraForm, THIS.this_cBarraPict)

        THIS.AcumularProgramaTipo(THIS.this_cProg, "INSERIR", ;
            loc_cDescBase + " [Inserir]", loc_cDescBase + " - [Inserir ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "ALTERAR", ;
            loc_cDescBase + " [Alterar]", loc_cDescBase + " - [Alterar ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "EXCLUIR", ;
            loc_cDescBase + " [Excluir]", loc_cDescBase + " - [Excluir ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "LISTAR", ;
            loc_cDescBase + " [Listar]", loc_cDescBase + " - [Listar ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "COTACAO", ;
            loc_cDescBase + " [Cota" + CHR(231) + CHR(227) + "o]", ;
            loc_cDescBase + " - [Cotacao ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "FORMAPAG", ;
            loc_cDescBase + " [Altera Forma de Pagamento]", ;
            loc_cDescBase + " - [Forma Pagamento ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "COMISSAO", ;
            loc_cDescBase + " [Comiss" + CHR(227) + "o]", ;
            loc_cDescBase + " - [Comissao ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "ALTPRECO", ;
            loc_cDescBase + " [Altera Pre" + CHR(231) + "o]", ;
            loc_cDescBase + " - [Altera Preco ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "CANCITEM", ;
            loc_cDescBase + " [Cancela Item]", loc_cDescBase + " - [Cancela Item ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "SERVICOS", ;
            loc_cDescBase + " [Servicos]", ;
            loc_cDescBase + " - [Servi" + CHR(231) + "os ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "QUITACAO", ;
            loc_cDescBase + " [Quita" + CHR(231) + CHR(227) + "o]", ;
            loc_cDescBase + " - [Quita" + CHR(231) + CHR(227) + "o ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "SUBNIVEL", ;
            loc_cDescBase + " [SubNivel]", loc_cDescBase + " - [SubNivel ]")
        THIS.AcumularProgramaTipo(THIS.this_cProg, "DADOSCOMPL", ;
            loc_cDescBase + " [Dados Complementares]", ;
            loc_cDescBase + " - [Dados complementares ]")
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularSubMenuPrograma - "Insert Into crSigCdPrg (...) " do ramo
    * "If !ChkRegister('SigCdPrg','Programas',lcSubMenus)" - SEM ramo de
    * update (se o programa do submenu ja existe, o legado nao toca nele).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularSubMenuPrograma(par_cPrograma, par_cDescricao)
        LOCAL loc_cSQL

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + ")" + CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves, BarraForms)" + ;
            " VALUES (" + EscaparSQL(par_cDescricao) + ", '', " + EscaparSQL(par_cPrograma) + ;
            ", " + EscaparSQL(fUniqueIds()) + ", SPACE(50))"

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularProgramaBase - ChkRegister('SigCdPrg', @laProgs) com
    * Parametros = Space(10): registra o programa principal da operacao
    * nova, com BarraForms/BarraPict. Insert se nao existe, Update se existe
    * (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularProgramaBase(par_cPrograma, par_cDescricao, par_cBarraForm, par_cBarraPict)
        LOCAL loc_cSQL, loc_cParam

        loc_cParam = EscaparSQL(SPACE(10))

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + " AND parametros = " + loc_cParam + ")" + CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves, BarraForms, BarraPict)" + ;
            " VALUES (" + EscaparSQL(par_cDescricao) + ", " + loc_cParam + ", " + ;
            EscaparSQL(par_cPrograma) + ", " + EscaparSQL(fUniqueIds()) + ", " + ;
            EscaparSQL(par_cBarraForm) + ", " + EscaparSQL(par_cBarraPict) + ")" + CHR(13) + CHR(10) + ;
            "ELSE" + CHR(13) + CHR(10) + ;
            "UPDATE SigCdPrg SET Descricaos = " + EscaparSQL(par_cDescricao) + ;
            ", BarraForms = " + EscaparSQL(par_cBarraForm) + ;
            ", BarraPict = " + EscaparSQL(par_cBarraPict) + ;
            " WHERE programas = " + EscaparSQL(par_cPrograma) + " AND parametros = " + loc_cParam

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * AcumularProgramaTipo - um dos 13 ChkRegister('SigCdPrg', @laProgs)
    * com Parametros = 'INSERIR'/'ALTERAR'/etc. Insert se nao existe,
    * Update (so a Descricaos) se existe - texto de insert e de update
    * transcritos LITERALMENTE do legado, inclusive as inconsistencias de
    * acentuacao/capitalizacao entre os dois (regra #17: nunca "corrigir").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AcumularProgramaTipo(par_cPrograma, par_cParametro, par_cDescInsert, par_cDescUpdate)
        LOCAL loc_cSQL

        loc_cSQL = "IF NOT EXISTS (SELECT 1 FROM SigCdPrg WHERE programas = " + ;
            EscaparSQL(par_cPrograma) + " AND parametros = " + EscaparSQL(par_cParametro) + ")" + ;
            CHR(13) + CHR(10) + ;
            "INSERT INTO SigCdPrg (Descricaos, Parametros, Programas, pkChaves)" + ;
            " VALUES (" + EscaparSQL(par_cDescInsert) + ", " + EscaparSQL(par_cParametro) + ", " + ;
            EscaparSQL(par_cPrograma) + ", " + EscaparSQL(fUniqueIds()) + ")" + CHR(13) + CHR(10) + ;
            "ELSE" + CHR(13) + CHR(10) + ;
            "UPDATE SigCdPrg SET Descricaos = " + EscaparSQL(par_cDescUpdate) + ;
            " WHERE programas = " + EscaparSQL(par_cPrograma) + ;
            " AND parametros = " + EscaparSQL(par_cParametro)

        THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarTabelaFilha - Clona as linhas de uma tabela filha ligada pela
    * operacao de origem, uma linha de origem por INSERT, para que cada
    * registro novo receba a SUA propria chave Fortyus (regra #22: chave
    * repetida colide no indice unico de cidchaves/pkchaves).
    *
    * par_cTabela        - tabela filha
    * par_cCampoLigacao  - coluna que guarda a operacao (dopes/cdopes)
    * par_cCampoPk        - coluna da chave Fortyus (cidchaves)
    * par_cOrigem/par_cDestino - codigos da operacao
    * par_cExtra          - overrides ADICIONAIS ("col=expr|...") ou ""
    * par_cFiltro         - condicao extra no SELECT de origem, ou ""
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CopiarTabelaFilha(par_cTabela, par_cCampoLigacao, par_cCampoPk, ;
            par_cOrigem, par_cDestino, par_cExtra, par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_cPk, loc_cOvr, loc_lOk

        loc_lOk = .T.

        IF USED("cursor_4c_PkCopia")
            USE IN cursor_4c_PkCopia
        ENDIF

        loc_cSQL = "SELECT " + par_cCampoPk + " AS pk FROM " + par_cTabela + ;
            " WHERE " + par_cCampoLigacao + " = " + EscaparSQL(par_cOrigem)

        IF !EMPTY(NVL(par_cFiltro, ""))
            loc_cSQL = loc_cSQL + " AND " + par_cFiltro
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PkCopia")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao ler " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        SELECT cursor_4c_PkCopia
        SCAN WHILE loc_lOk
            loc_cPk = ALLTRIM(NVL(cursor_4c_PkCopia.pk, ""))

            loc_cOvr = par_cCampoLigacao + "=" + EscaparSQL(par_cDestino) + ;
                "|" + par_cCampoPk + "=" + EscaparSQL(fUniqueIds())

            IF !EMPTY(NVL(par_cExtra, ""))
                loc_cOvr = loc_cOvr + "|" + par_cExtra
            ENDIF

            loc_cSQL = THIS.MontarInsertCopia(par_cTabela, loc_cOvr, ;
                par_cCampoPk + " = " + EscaparSQL(loc_cPk))

            IF EMPTY(loc_cSQL)
                loc_lOk = .F.
            ELSE
                THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + CHR(13) + CHR(10)
                THIS.this_nRegistrosCopiados = THIS.this_nRegistrosCopiados + 1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_PkCopia")
            USE IN cursor_4c_PkCopia
        ENDIF

        IF loc_lOk
            THIS.this_nTabelasCopiadas = THIS.this_nTabelasCopiadas + 1
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarInsertCopia - Monta "INSERT INTO T (cols) SELECT exprs FROM T
    * WHERE <where>", trocando por EXPRESSAO as colunas sobrepostas. A
    * lista de colunas vem do INFORMATION_SCHEMA em tempo de execucao de
    * proposito: SigCdOpe tem 254 colunas e fixa-las aqui garantiria que no
    * dia em que o schema mudar o INSERT quebre em silencio (mesmo
    * raciocinio de ProdutoBO.MontarInsertCopia, portado aqui).
    *
    * par_cOverrides - "col=<expr SQL>|col=<expr SQL>|..." (col sem aspas,
    *                  expr ja no formato final de SQL Server)
    * Devolve "" se nao conseguir ler as colunas (o chamador aborta).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarInsertCopia(par_cTabela, par_cOverrides, par_cWhere)
        LOCAL loc_cTab, loc_cCols, loc_cExprs, loc_cCol, loc_cOvr, loc_nPos, ;
            loc_cValor, loc_nResultado, loc_nUsados, loc_nPedidos

        loc_cTab = ALLTRIM(par_cTabela)

        IF USED("cursor_4c_ColsCopia")
            USE IN cursor_4c_ColsCopia
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME AS col FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = " + EscaparSQL(loc_cTab) + ;
            " ORDER BY ORDINAL_POSITION", "cursor_4c_ColsCopia")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ColsCopia") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler as colunas de " + loc_cTab + ":" + CHR(13) + CapturarErroSQL()
            RETURN ""
        ENDIF

        loc_cCols   = ""
        loc_cExprs  = ""
        loc_nUsados = 0

        SELECT cursor_4c_ColsCopia
        SCAN
            loc_cCol = ALLTRIM(cursor_4c_ColsCopia.col)

            loc_cValor = ""
            loc_cOvr   = "|" + ALLTRIM(NVL(par_cOverrides, "")) + "|"
            loc_nPos   = AT("|" + LOWER(loc_cCol) + "=", LOWER(loc_cOvr))

            IF loc_nPos > 0
                loc_cValor  = SUBSTR(loc_cOvr, loc_nPos + LEN(loc_cCol) + 2)
                loc_cValor  = LEFT(loc_cValor, AT("|", loc_cValor) - 1)
                loc_nUsados = loc_nUsados + 1
            ELSE
                loc_cValor = loc_cCol
            ENDIF

            loc_cCols  = loc_cCols  + IIF(EMPTY(loc_cCols),  "", ", ") + loc_cCol
            loc_cExprs = loc_cExprs + IIF(EMPTY(loc_cExprs), "", ", ") + loc_cValor
        ENDSCAN

        IF USED("cursor_4c_ColsCopia")
            USE IN cursor_4c_ColsCopia
        ENDIF

        *-- Cada override tem de ter casado com uma coluna REAL - erro de
        *-- grafia na chamada (regra #22) nasceria silencioso sem isto.
        loc_nPedidos = 0
        IF !EMPTY(NVL(par_cOverrides, ""))
            loc_nPedidos = OCCURS("|", ALLTRIM(par_cOverrides)) + 1
        ENDIF

        IF loc_nUsados < loc_nPedidos
            THIS.this_cMensagemErro = "C" + CHR(243) + "pia de " + loc_cTab + ": " + ;
                TRANSFORM(loc_nPedidos - loc_nUsados) + " de " + ;
                TRANSFORM(loc_nPedidos) + " campos a sobrepor n" + CHR(227) + ;
                "o existem na tabela." + CHR(13) + ALLTRIM(par_cOverrides)
            RETURN ""
        ENDIF

        RETURN "INSERT INTO " + loc_cTab + " (" + loc_cCols + ")" + ;
            " SELECT " + loc_cExprs + " FROM " + loc_cTab + " WHERE " + par_cWhere
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarLoteCopia - Executa this_cLoteCopia (15 tabelas + SigCdPrg)
    * numa transacao ATOMICA unica: o VFP ja abre transacao propria por
    * conta do SQLEXEC (medido: @@TRANCOUNT = 1 numa conexao recem-aberta)
    * - um BEGIN/COMMIT direto so ANINHARIA sem efetivar nada no ROLLBACK
    * (mesmo achado de ProdutoBO.CopiarProduto). Por isso SAVE TRANSACTION
    * quando ja ha transacao aberta (o caso normal aqui) e THROW no CATCH
    * para o erro chegar ao retorno do SQLEXEC.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarLoteCopia()
        LOCAL loc_cSQL, loc_nResultado, loc_lOk

        loc_lOk = .F.

        IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteCopia, "")))
            THIS.this_cMensagemErro = "Nada para copiar."
            RETURN .F.
        ENDIF

        loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
            "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
            "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
            "ELSE SAVE TRANSACTION Cop4c;" + CHR(13) + CHR(10) + ;
            "BEGIN TRY" + CHR(13) + CHR(10) + ;
            THIS.this_cLoteCopia + ;
            "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
            "END TRY" + CHR(13) + CHR(10) + ;
            "BEGIN CATCH" + CHR(13) + CHR(10) + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cop4c; END;" + CHR(13) + CHR(10) + ;
            "THROW;" + CHR(13) + CHR(10) + ;
            "END CATCH"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao gravar a c" + CHR(243) + "pia (" + ;
                ALLTRIM(NVL(THIS.this_cEtapaAtual, "")) + "):" + CHR(13) + CapturarErroSQL()
            loc_lOk = .F.
        ELSE
            loc_lOk = .T.
        ENDIF

        THIS.this_cLoteCopia = ""

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

