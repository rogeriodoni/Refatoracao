# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarOrigem' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarOrigemValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1678 linhas total):

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

*-- Linhas 500 a 705:
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
553:     *--------------------------------------------------------------------------
554:     this_lEmLookupOrigem  = .F.
555:     this_lEmValidaDestino = .F.
556:     this_lEmCopia         = .F.
557: 
558:     *--------------------------------------------------------------------------
559:     * Init - recebe o contexto do form chamador, define o Caption com CHR() e
560:     * delega ao FormBase (que chama InicializarForm).
561:     *
562:     * Os dois parametros sao OPCIONAIS: o legado sempre os recebe do form de
563:     * Cadastro de Operacoes, mas a tela tambem e alcancavel pelo menu, e nesse
564:     * caso a operacao de origem fica em branco para o usuario informar.
565:     *--------------------------------------------------------------------------
566:     PROCEDURE Init(par_oFormPai, par_cOperacao)
567:         *-- "C" + o-acute + "pia de Movimenta" + c-cedilha + a-tilde + "o "
568:         *-- (o espaco final faz parte do literal do SCX)
569:         THIS.Caption = "C" + CHR(243) + "pia de Movimenta" + CHR(231) + CHR(227) + "o "
570: 
571:         THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
572:         THIS.this_cOperacaoOrigem = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "")
573: 
574:         *-- Ver nota 1 do cabecalho
575:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
576:              (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
577:             THIS.WindowType = 1
578:             THIS.ShowWindow = 1
579:         ENDIF
580: 
581:         RETURN DODEFAULT()
582:     ENDPROC
583: 
584:     *--------------------------------------------------------------------------
585:     * InicializarForm - instancia o Business Object, aplica o fundo do form e
586:     * monta a estrutura visual.
587:     *
588:     * NAO ha guarda de gb_4c_ValidandoUI envolvendo o metodo: essa flag serve
589:     * para pular QUERY SQL, e um RETURN no topo pularia tambem o Picture e o
590:     * cabecalho, tornando qualquer diferenca de UI Fidelity irrecuperavel pelo
591:     * auto-fix. Este bloco nao executa SQL nenhum.
592:     *--------------------------------------------------------------------------
593:     PROTECTED PROCEDURE InicializarForm()
594:         LOCAL loc_lSucesso, loc_oErro
595:         loc_lSucesso = .F.
596: 
597:         TRY
598:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCopBO")
599: 
600:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
601:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCopBO." + CHR(13) + ;
602:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
603:                         "Erro em InicializarForm")
604:             ELSE
605:                 *-- Fundo do form: o SCX aponta ..\framework\imagens\new_background.jpg
606:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
607: 
608:                 *-- Semeia o BO com a operacao de origem recebida do chamador,
609:                 *-- equivalente ao "ThisForm.GetOrigem.Value = pOperacao" do
610:                 *-- PROCEDURE Init legado. Vai para o BO porque o TextBox da
611:                 *-- tela ainda nao existe neste ponto da montagem.
612:                 THIS.this_oBusinessObject.this_cOperacaoOrigem = THIS.this_cOperacaoOrigem
613: 
614:                 THIS.ConfigurarPageFrame()
615: 
616:                 *-- "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" e
617:                 *-- "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption"
618:                 *-- do PROCEDURE Init legado
619:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
620:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
621: 
622:                 THIS.TornarControlesVisiveis(THIS)
623: 
624:                 loc_lSucesso = .T.
625:             ENDIF
626:         CATCH TO loc_oErro
627:             MsgErro(loc_oErro.Message + CHR(13) + ;
628:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
629:                     "Procedure: " + loc_oErro.Procedure, ;
630:                     "Erro em InicializarForm")
631:         ENDTRY
632: 
633:         RETURN loc_lSucesso
634:     ENDPROC
635: 
636:     *--------------------------------------------------------------------------
637:     * ConfigurarPageFrame - orquestra a montagem visual do form.
638:     *
639:     * NAO existe PageFrame real: o legado SIGOPCOP e flat (nenhum objeto de
640:     * BaseClass pageframe na arvore do SCX) e por isso nao ha compensacao de
641:     * Top = -29 a aplicar - os Top do dump sao absolutos no form e entram
642:     * transcritos. O nome do metodo e mantido por conformidade com o contrato
643:     * do pipeline multi-fase, igual em FormSIGOPCCO e FormSigOpCcl.
644:     *
645:     * ORDEM OBRIGATORIA: o cabecalho vem PRIMEIRO e a barra de botoes DEPOIS -
646:     * ver nota 11 do cabecalho (o grupo em Top = -2 esta dentro da faixa cinza
647:     * e so desenha por cima dela se for criado em segundo lugar).
648:     *
649:     * Os campos de dados vem por ULTIMO: ficam na faixa 107..130, abaixo do
650:     * cabecalho (0..80) e fora da area do grupo de botoes, logo a ordem entre
651:     * eles e indiferente para o desenho - mantem-se a sequencia da montagem.
652:     *--------------------------------------------------------------------------
653:     PROTECTED PROCEDURE ConfigurarPageFrame()
654:         THIS.ConfigurarCabecalho()
655:         THIS.ConfigurarBotoes()
656:         THIS.ConfigurarCampos()
657:     ENDPROC
658: 
659:     *--------------------------------------------------------------------------
660:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
661:     * labels de titulo sobrepostos: sombra preta embaixo, titulo branco em
662:     * cima. Geometria TRANSCRITA do dump (SIGOPCOP.cntSombra / .lblSombra /
663:     * .lblTitulo), com as larguras ajustadas conforme a nota 3 do cabecalho.
664:     *--------------------------------------------------------------------------
665:     PROTECTED PROCEDURE ConfigurarCabecalho()
666:         THIS.AddObject("cnt_4c_Sombra", "Container")
667:         WITH THIS.cnt_4c_Sombra
668:             .Top         = 0
669:             .Left        = 0
670:             .Width       = THIS.Width
671:             .Height      = 80
672:             .BackStyle   = 1
673:             .BackColor   = RGB(100, 100, 100)
674:             .BorderWidth = 0
675:             .Visible     = .T.
676:         ENDWITH
677: 
678:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
679:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
680:             .Top           = 18
681:             .Left          = 10
682:             .Width         = THIS.Width - 20
683:             .Height        = 40
684:             .AutoSize      = .F.
685:             .BackStyle     = 0
686:             .WordWrap      = .T.
687:             .Alignment     = 0
688:             .FontName      = "Tahoma"
689:             .FontSize      = 18
690:             .FontBold      = .T.
691:             .FontUnderline = .F.
692:             .ForeColor     = RGB(0, 0, 0)
693:             .Caption       = THIS.Caption
694:             .Visible       = .T.
695:         ENDWITH
696: 
697:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
698:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
699:             .Top         = 17
700:             .Left        = 10
701:             .Width       = THIS.Width - 20
702:             .Height      = 46
703:             .AutoSize    = .F.
704:             .BackStyle   = 0
705:             .WordWrap    = .T.

*-- Linhas 726 a 769:
726:     *
727:     * Ver notas 7 a 13 do cabecalho.
728:     *--------------------------------------------------------------------------
729:     PROTECTED PROCEDURE ConfigurarBotoes()
730:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
731:         WITH THIS.cmg_4c_Botoes
732:             .Top           = -2
733:             .Left          = 445
734:             .Width         = 160
735:             .Height        = 85
736: 
737:             *-- ButtonCount ANTES de configurar Buttons(N): atribuir a
738:             *-- ButtonCount RECRIA os botoes e descartaria o que ja tivesse
739:             *-- sido posto neles.
740:             .ButtonCount   = 2
741: 
742:             *-- Ver nota 8 do cabecalho
743:             .AutoSize      = .F.
744: 
745:             .BackStyle     = 0
746:             .BorderStyle   = 0
747:             .SpecialEffect = 1
748:             .BorderColor   = RGB(136, 189, 188)
749: 
750:             *-- Ver nota 9 do cabecalho
751:             .Themes        = .F.
752: 
753:             .Value         = 1
754: 
755:             *-- Ver nota 13 do cabecalho
756:             .TabIndex      = 5
757: 
758:             .Visible       = .T.
759:         ENDWITH
760: 
761:         *-- Buttons(1) = Command1 "CmdCopia". O "\<" do Caption e o marcador de
762:         *-- tecla de acesso do VFP (Alt+C), transcrito do dump.
763:         WITH THIS.cmg_4c_Botoes.Buttons(1)
764:             .Top        = 5
765:             .Left       = 5
766:             .Width      = 75
767:             .Height     = 75
768:             .FontName   = "Comic Sans MS"
769:             .FontSize   = 8

*-- Linhas 799 a 870:
799: 
800:         *-- Ver nota 12 do cabecalho: o legado NAO tem Click no grupo, tem um
801:         *-- Click em CADA botao (CmdCopia.Click e CmdExit.Click), entao cada
802:         *-- Buttons(N) recebe o seu proprio BINDEVENT. Os dois handlers sao
803:         *-- PUBLIC: alvo de BINDEVENT declarado PROTECTED falha em SILENCIO.
804:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCopiarClick")
805:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
806:     ENDPROC
807: 
808:     *--------------------------------------------------------------------------
809:     * ConfigurarCampos - bloco de dados do SIGOPCOP, as DUAS linhas.
810:     *
811:     * Linha de CIMA  - Label1 "Movimentacao Atual : " + GetOrigem,  a operacao
812:     *                  que sera COPIADA (entregue no bloco da Fase 5).
813:     * Linha de BAIXO - Label2 "Nova Movimentacao : "  + GetDestino, a operacao
814:     *                  NOVA que recebera a copia (acrescentada na Fase 6).
815:     *
816:     * Geometria, fonte, cor, Format e MaxLength TRANSCRITOS do dump (secao 2,
817:     * "PROPRIEDADES DE: SIGOPCOP.Label1" / ".Label2" / ".GetOrigem" /
818:     * ".GetDestino").
819:     *
820:     * Em cada linha o label e criado ANTES do TextBox para que o campo desenhe
821:     * POR CIMA caso a caixa do label avance sobre ele (regra #23). Aqui nao
822:     * avanca - o label termina em 278 e o campo comeca em 280 - mas a ordem
823:     * segura e a mesma.
824:     *
825:     * Os BINDEVENT dos dois campos ficam no FIM do metodo, depois de ambos os
826:     * TextBox existirem: BINDEVENT valida o objeto de origem NA HORA DO BIND.
827:     *
828:     * Ver notas 14 a 24 do cabecalho.
829:     *--------------------------------------------------------------------------
830:     PROTECTED PROCEDURE ConfigurarCampos()
831:         LOCAL loc_lOrigemDoChamador
832: 
833:         *-- Ver nota 19: origem recebida do chamador e somente-exibicao, como
834:         *-- no legado; origem em branco (tela aberta sem chamador) e digitavel.
835:         loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))
836: 
837:         *-- Label1. Caption: "Movimenta" + c-cedilha + a-tilde + "o Atual : "
838:         *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
839:         THIS.AddObject("lbl_4c_Label1", "Label")
840:         WITH THIS.lbl_4c_Label1
841:             .Top       = 110
842:             .Left      = 169
843:             .Width     = 109
844:             .Height    = 15
845: 
846:             *-- Ver nota 17 do cabecalho
847:             .AutoSize  = .F.
848:             .Alignment = 0
849: 
850:             .BackStyle = 0
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8
853: 
854:             *-- Ver nota 18 do cabecalho
855:             .ForeColor = RGB(90, 90, 90)
856: 
857:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Atual : "
858:             .TabIndex  = 1
859:             .Visible   = .T.
860:         ENDWITH
861: 
862:         *-- GetOrigem: operacao de origem da copia (SigCdOpe.dopes char(20))
863:         THIS.AddObject("txt_4c_Origem", "TextBox")
864:         WITH THIS.txt_4c_Origem
865:             .Top       = 107
866:             .Left      = 280
867:             .Width     = 150
868:             .Height    = 23
869:             .FontName  = "Tahoma"
870:             .FontSize  = 8

*-- Linhas 877 a 937:
877: 
878:             *-- Inicializacao de TIPO, nao de valor: o TextBox tem de nascer
879:             *-- CARACTERE. O valor em si - o "ThisForm.GetOrigem.Value =
880:             *-- pOperacao" do PROCEDURE Init legado - chega pelo BOParaForm no
881:             *-- fim deste metodo, que e a fonte UNICA dele (ver nota 30).
882:             .Value     = ""
883: 
884:             *-- Ver nota 19 do cabecalho. ReadOnly/TabStop NAO sao escritos
885:             *-- aqui: a regra de editabilidade mora em HabilitarCampos, que e
886:             *-- chamado logo abaixo. Escreve-la nos dois lugares era a receita
887:             *-- para os dois divergirem (nota 31).
888: 
889:             .Visible   = .T.
890:         ENDWITH
891: 
892:         *-- Ver nota 19 do cabecalho. O BINDEVENT so e registrado quando o
893:         *-- bloqueio de foco vale: ligado sempre, tornaria o campo inalcancavel
894:         *-- tambem no caminho sem chamador, em que ele e o unico jeito de
895:         *-- informar a origem.
896:         IF loc_lOrigemDoChamador
897:             BINDEVENT(THIS.txt_4c_Origem, "When", THIS, "OrigemWhen")
898:         ENDIF
899: 
900:         *-- Label2. Caption: "Nova Movimenta" + c-cedilha + a-tilde + "o : "
901:         *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
902:         THIS.AddObject("lbl_4c_Label2", "Label")
903:         WITH THIS.lbl_4c_Label2
904:             .Top       = 136
905:             .Left      = 169
906:             .Width     = 109
907:             .Height    = 15
908: 
909:             *-- Ver nota 17 do cabecalho
910:             .AutoSize  = .F.
911:             .Alignment = 0
912: 
913:             .BackStyle = 0
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916: 
917:             *-- Ver nota 18 do cabecalho
918:             .ForeColor = RGB(90, 90, 90)
919: 
920:             .Caption   = "Nova Movimenta" + CHR(231) + CHR(227) + "o : "
921:             .TabIndex  = 2
922:             .Visible   = .T.
923:         ENDWITH
924: 
925:         *-- GetDestino: operacao NOVA, a que recebera a copia (SigCdOpe.dopes
926:         *-- char(20)). Nasce em BRANCO e digitavel em todo caminho: o Init
927:         *-- legado semeia apenas GetOrigem, e este campo e justamente o que o
928:         *-- usuario vem informar. Ver nota 21 do cabecalho.
929:         THIS.AddObject("txt_4c_Destino", "TextBox")
930:         WITH THIS.txt_4c_Destino
931:             .Top       = 134
932:             .Left      = 280
933:             .Width     = 150
934:             .Height    = 23
935:             .FontName  = "Tahoma"
936:             .FontSize  = 8
937: 

*-- Linhas 944 a 1343:
944:             .Visible   = .T.
945:         ENDWITH
946: 
947:         *-- Ver nota 20: o "PROCEDURE Valid" de cada campo e ligado a
948:         *-- "LostFocus" - e ao SAIR do campo que o Valid legado roda.
949:         BINDEVENT(THIS.txt_4c_Origem,  "LostFocus", THIS, "ValidarOrigem")
950:         BINDEVENT(THIS.txt_4c_Destino, "LostFocus", THIS, "ValidarDestino")
951: 
952:         *-- Ver nota 23: F4/F5 e duplo clique desaguam no MESMO funil do
953:         *-- lookup de SigCdOpe que o LostFocus da origem usa.
954:         BINDEVENT(THIS.txt_4c_Origem, "KeyPress", THIS, "TxtOrigemKeyPress")
955:         BINDEVENT(THIS.txt_4c_Origem, "DblClick", THIS, "TxtOrigemDblClick")
956: 
957:         *-- Ver nota 30: espelho Business Object -> tela. E ele que poe na
958:         *-- origem o valor que o chamador trouxe (o
959:         *-- "ThisForm.GetOrigem.Value = pOperacao" do Init legado), e ele
960:         *-- termina chamando HabilitarCampos, que aplica a regra de
961:         *-- editabilidade da nota 19 - origem do chamador somente-exibicao,
962:         *-- origem em branco digitavel.
963:         THIS.BOParaForm()
964: 
965:         *-- "ThisForm.GetOrigem.Refresh" do PROCEDURE Init legado
966:         THIS.txt_4c_Origem.Refresh()
967:     ENDPROC
968: 
969:     *--------------------------------------------------------------------------
970:     * OrigemWhen - equivalente ao "PROCEDURE When / Return .f." de GetOrigem:
971:     * o campo EXIBE a operacao de origem trazida pelo chamador e nunca recebe
972:     * foco, nem por Tab nem por clique.
973:     *
974:     * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
975:     * falha em silencio (regra #3). Ver nota 19 do cabecalho.
976:     *--------------------------------------------------------------------------
977:     FUNCTION OrigemWhen()
978:         RETURN .F.
979:     ENDFUNC
980: 
981:     *--------------------------------------------------------------------------
982:     * ValidarOrigem - "PROCEDURE Valid" de GetOrigem, ligado a "LostFocus".
983:     *
984:     * Legado:
985:     *   If !IsEmpty( This.Value )
986:     *       xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'csSigCdOpe',
987:     *                            'Dopes', This.Value, 'Operacoes', .t., 'Dopes')
988:     *       If Not xBrox.plAchouRegistro
989:     *           xBrox.mAddColuna('Dopes', '', 'Operacao', .t.)
990:     *           xBrox.Show()
991:     *       EndIf
992:     *       This.Value = Iif( LastKey() # 27, Evaluate('csSigCdOpe.Dopes'), '' )
993:     *   Else
994:     *       If Lastkey() <> 27
995:     *           MessageBox("Operacao Deve ser informada !!!",16,"")
996:     *           Return .f.
997:     *       Endif
998:     *   Endif
999:     *
1000:     * Campo PREENCHIDO -> funil do lookup (AbrirBuscaOrigem, que reproduz o
1001:     * fwBuscaExt inteiro). Campo VAZIO e saida que NAO foi por ESC -> avisa e
1002:     * devolve o foco: BINDEVENT descarta o retorno do delegate, entao o efeito
1003:     * observavel do "Return .f." legado (o foco nao sai do campo) se reproduz
1004:     * com SetFocus, nao com RETURN .F.
1005:     *
1006:     * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
1007:     * falha em silencio (regra #3). Sem parametros: LostFocus nao passa nenhum.
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE ValidarOrigem()
1010:         LOCAL loc_cValor, loc_oErro
1011: 
1012:         *-- Ver nota 22: o picker e MODAL e o SetFocus do ramo vazio devolve o
1013:         *-- foco ao campo - as duas coisas redisparam este proprio LostFocus.
1014:         IF THIS.this_lEmLookupOrigem
1015:             RETURN
1016:         ENDIF
1017: 
1018:         THIS.this_lEmLookupOrigem = .T.
1019: 
1020:         TRY
1021:             loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)
1022: 
1023:             IF EMPTY(loc_cValor)
1024:                 *-- Ramo ELSE do legado. LASTKEY() = 27 e a saida por ESC, em
1025:                 *-- que o legado nao avisa nada.
1026:                 IF LASTKEY() != 27
1027:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser informada !!!")
1028:                     THIS.txt_4c_Origem.SetFocus()
1029:                 ENDIF
1030:             ELSE
1031:                 THIS.AbrirBuscaOrigem()
1032:             ENDIF
1033:         CATCH TO loc_oErro
1034:             MsgErro(loc_oErro.Message + CHR(13) + ;
1035:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1036:                     "Procedure: " + loc_oErro.Procedure, ;
1037:                     "Erro em ValidarOrigem")
1038:         ENDTRY
1039: 
1040:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1041:         THIS.this_lEmLookupOrigem = .F.
1042:     ENDPROC
1043: 
1044:     *--------------------------------------------------------------------------
1045:     * TxtOrigemKeyPress - segunda entrada do funil do lookup: F4 (115) e F5
1046:     * (116), as teclas que o projeto usa para chamar o picker.
1047:     *
1048:     * ENTER e TAB NAO entram aqui DE PROPOSITO: as duas MOVEM o foco, logo o
1049:     * LostFocus (ValidarOrigem) ja abre o funil, e abrir aqui tambem faria o
1050:     * picker aparecer duas vezes seguidas. Abrir o picker sem testar a tecla
1051:     * faria o dialogo subir a CADA caractere digitado (regra #47).
1052:     *
1053:     * Os dois parametros do evento sao OBRIGATORIOS na assinatura: handler sem
1054:     * eles ligado a KeyPress estoura a cada tecla (regra #3).
1055:     *--------------------------------------------------------------------------
1056:     PROCEDURE TxtOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1057:         IF VARTYPE(par_nKeyCode) = "N"
1058:             IF INLIST(par_nKeyCode, 115, 116)
1059:                 THIS.AbrirBuscaOrigem()
1060:             ENDIF
1061:         ENDIF
1062:     ENDPROC
1063: 
1064:     *--------------------------------------------------------------------------
1065:     * TxtOrigemDblClick - terceira entrada do funil do lookup. O duplo clique
1066:     * no campo e o atalho de mouse equivalente ao F4; o legado nao o tem
1067:     * porque com When = .F. o GetOrigem nunca recebe clique nenhum, e no
1068:     * caminho em que o campo e digitavel (nota 19) ele e o atalho esperado.
1069:     *--------------------------------------------------------------------------
1070:     PROCEDURE TxtOrigemDblClick()
1071:         THIS.AbrirBuscaOrigem()
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     * AbrirBuscaOrigem - FUNIL UNICO do lookup de operacoes, chamado pelas tres
1076:     * entradas (LostFocus, F4/F5 e duplo clique). Reproduz o fwBuscaExt do
1077:     * GetOrigem.Valid legado com o FormBuscaAuxiliar do sistema novo:
1078:     *
1079:     *   fwBuscaExt(pnIdConn, 'SigCdOpe', 'csSigCdOpe', 'Dopes', This.Value,
1080:     *              'Operacoes', .t., 'Dopes')
1081:     *     -> CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe",
1082:     *                     "cursor_4c_BuscaOpe", "Dopes", <valor>, "Operacoes")
1083:     *   plAchouRegistro -> this_lAchouRegistro
1084:     *   mAddColuna      -> mAddColuna (mesmo nome)
1085:     *
1086:     * UMA unica coluna no picker, como o legado: SigCdOpe nao tem coluna de
1087:     * descricao - Dopes char(20) e ao mesmo tempo a chave e o texto da
1088:     * operacao. Acrescentar uma segunda coluna ("descrs"/"Descrs") estouraria
1089:     * "Variable 'DESCRS' is not found" dentro do FormBuscaAuxiliar.
1090:     *
1091:     * Ver notas 21, 22 e 24 do cabecalho.
1092:     *--------------------------------------------------------------------------
1093:     PROCEDURE AbrirBuscaOrigem()
1094:         LOCAL loc_oBusca, loc_cValor, loc_lEmLookupAnt, loc_oErro
1095: 
1096:         *-- Ver nota 22: SAVE/RESTORE, nao set/clear - este metodo e chamado
1097:         *-- de DENTRO do ValidarOrigem (que ja ligou a flag) e tambem direto
1098:         *-- pelo F4/duplo clique. Um clear fixo liberaria a guarda antes de o
1099:         *-- ValidarOrigem terminar, e o LostFocus de volta do picker abriria um
1100:         *-- segundo dialogo.
1101:         loc_lEmLookupAnt          = THIS.this_lEmLookupOrigem
1102:         THIS.this_lEmLookupOrigem = .T.
1103: 
1104:         TRY
1105:             *-- Ver nota 21: quando a origem veio do chamador o campo e
1106:             *-- somente-exibicao (When = .F. do legado), e o lookup - que no
1107:             *-- legado e inalcancavel por esse mesmo motivo - nao pode alterar
1108:             *-- o valor. Guarda por IF, nunca por RETURN: um RETURN aqui
1109:             *-- deixaria a flag de reentrancia ligada para sempre e mataria o
1110:             *-- lookup pelo resto da vida do form (regra #47).
1111:             IF !THIS.txt_4c_Origem.ReadOnly
1112:                 loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)
1113: 
1114:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1115:                     "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
1116:                     "Opera" + CHR(231) + CHR(245) + "es")
1117: 
1118:                 IF VARTYPE(loc_oBusca) = "O"
1119:                     *-- Contrato do FormBuscaAuxiliar (regra #37): o Init ja
1120:                     *-- tentou o match EXATO e, achando UM registro, resolveu o
1121:                     *-- valor sozinho - nesse caso o dialogo NAO deve aparecer.
1122:                     IF !loc_oBusca.this_lAchouRegistro
1123:                         loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1124:                         loc_oBusca.Show()
1125:                     ENDIF
1126: 
1127:                     *-- Atribuir SO sob a guarda de selecao: nada escolhido
1128:                     *-- (ESC/Cancelar) deixa no campo o que o usuario digitou.
1129:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
1130:                         SELECT cursor_4c_BuscaOpe
1131:                         THIS.txt_4c_Origem.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
1132:                     ENDIF
1133: 
1134:                     loc_oBusca.Release()
1135:                 ENDIF
1136:             ENDIF
1137:         CATCH TO loc_oErro
1138:             MsgErro(loc_oErro.Message + CHR(13) + ;
1139:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1140:                     "Procedure: " + loc_oErro.Procedure, ;
1141:                     "Erro em AbrirBuscaOrigem")
1142:         ENDTRY
1143: 
1144:         *-- Restaurar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1145:         THIS.this_lEmLookupOrigem = loc_lEmLookupAnt
1146: 
1147:         IF USED("cursor_4c_BuscaOpe")
1148:             USE IN cursor_4c_BuscaOpe
1149:         ENDIF
1150:     ENDPROC
1151: 
1152:     *--------------------------------------------------------------------------
1153:     * ValidarDestino - "PROCEDURE Valid" de GetDestino, ligado a "LostFocus".
1154:     *
1155:     * Legado:
1156:     *   If NOt Empty(This.Value) And Not Lastkey() = 27
1157:     *       Sqlexecute([Select dopes from SigCdOpe Where Dopes = ']+this.Value+['],
1158:     *                  'csSigCdOpe')
1159:     *       Select csSigCdOpe
1160:     *       If ! Eof()
1161:     *           MessageBox('Operacao ja Cadastrada !!!',16,'')
1162:     *           Return .f.
1163:     *       EndIf
1164:     *   EndIf
1165:     *
1166:     * Conferencia de duplicidade - NAO e lookup, e o INVERSO dele: aqui o
1167:     * usuario informa uma operacao que ainda NAO existe, e achar registro e
1168:     * que reprova. Por isso nao ha picker neste campo: abrir um dialogo de
1169:     * escolha para um codigo que precisa ser novo nao faria sentido, e nenhuma
1170:     * das tres classes fwBusca* aparece no Valid do GetDestino no dump.
1171:     *
1172:     * O codigo digitado NUNCA e apagado (regra #50): o legado tambem nao o
1173:     * apaga - devolve o foco para o usuario corrigir.
1174:     *
1175:     * Ver notas 20, 22 e 24 do cabecalho.
1176:     *--------------------------------------------------------------------------
1177:     PROCEDURE ValidarDestino()
1178:         LOCAL loc_cValor, loc_nResultado, loc_lDuplicada, loc_oErro
1179: 
1180:         *-- Ver nota 22: o MsgAviso e modal e o SetFocus devolve o foco ao
1181:         *-- campo - as duas coisas redisparam este proprio LostFocus.
1182:         IF THIS.this_lEmValidaDestino
1183:             RETURN
1184:         ENDIF
1185: 
1186:         THIS.this_lEmValidaDestino = .T.
1187: 
1188:         TRY
1189:             loc_cValor     = ALLTRIM(THIS.txt_4c_Destino.Value)
1190:             loc_lDuplicada = .F.
1191: 
1192:             *-- "If NOt Empty(This.Value) And Not Lastkey() = 27" do legado
1193:             IF !EMPTY(loc_cValor) AND LASTKEY() != 27
1194:                 *-- Ver nota 24: sem conexao viva (validacao de UI / modo
1195:                 *-- teste, com gnConnHandle = -1) o SQLEXEC dispara excecao -
1196:                 *-- a conferencia e pulada, e a do BO (ValidarDados) continua
1197:                 *-- sendo a barreira que impede a gravacao duplicada.
1198:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1199:                     IF USED("cursor_4c_DestinoDup")
1200:                         USE IN cursor_4c_DestinoDup
1201:                     ENDIF
1202: 
1203:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
1204:                         "SELECT dopes FROM SigCdOpe" + ;
1205:                         " WHERE dopes = " + EscaparSQL(loc_cValor), ;
1206:                         "cursor_4c_DestinoDup")
1207: 
1208:                     IF loc_nResultado >= 0
1209:                         *-- "Select csSigCdOpe / If ! Eof()" do legado
1210:                         loc_lDuplicada = (RECCOUNT("cursor_4c_DestinoDup") > 0)
1211:                     ELSE
1212:                         MsgErro("Erro ao conferir a opera" + CHR(231) + CHR(227) + ;
1213:                                 "o de destino." + CHR(13) + CapturarErroSQL(), ;
1214:                                 "Erro SQL")
1215:                     ENDIF
1216: 
1217:                     IF USED("cursor_4c_DestinoDup")
1218:                         USE IN cursor_4c_DestinoDup
1219:                     ENDIF
1220:                 ENDIF
1221: 
1222:                 IF loc_lDuplicada
1223:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
1224:                              " Cadastrada !!!")
1225:                     THIS.txt_4c_Destino.SetFocus()
1226:                 ENDIF
1227:             ENDIF
1228:         CATCH TO loc_oErro
1229:             MsgErro(loc_oErro.Message + CHR(13) + ;
1230:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1231:                     "Procedure: " + loc_oErro.Procedure, ;
1232:                     "Erro em ValidarDestino")
1233:         ENDTRY
1234: 
1235:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1236:         THIS.this_lEmValidaDestino = .F.
1237:     ENDPROC
1238: 
1239:     *--------------------------------------------------------------------------
1240:     * BtnCopiarClick - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado) e a ACAO
1241:     * PRINCIPAL da tela: copia a operacao de ORIGEM inteira para a operacao de
1242:     * DESTINO digitada, atravessando 15 tabelas.
1243:     *
1244:     * Transcricao do "PROCEDURE CmdCopia.Click", na MESMA ordem:
1245:     *
1246:     *   If Empty(ThisForm.GetOrigem.Value)
1247:     *       MessageBox('Origem Invalida !!!',16,'')
1248:     *       Return
1249:     *   EndIf
1250:     *   If Empty(ThisForm.GetDestino.Value)
1251:     *       MessageBox('Destino Invalido !!!',16,'')
1252:     *       Return
1253:     *   EndIf
1254:     *   lcOpeOri = ThisForm.GetOrigem.Value
1255:     *   lcOpeDes = ThisForm.GetDestino.Value
1256:     *   lnNDopes = fGerUniqueKey("SigCdOpe")
1257:     *   ...  (Zap/Scatter/Gather/Insert das 15 tabelas + bloco de SigCdPrg)
1258:     *   fGravarLog( 'C', Thisform.Name, 'COPIA', lcTransacao )
1259:     *   ThisForm.poDatamgr.UpDate(...) x15 / ThisForm.poDatamgr.Commit()
1260:     *   ThisForm.Release
1261:     *
1262:     * As 459 linhas do MEIO - a geracao de nDopes/Programas, os Zap/Scatter/
1263:     * Gather de cada tabela, o bloco de permissoes de SigCdPrg e o Commit -
1264:     * moram em SigOpCopBO.Inserir (Fase 2), que as executa numa transacao
1265:     * UNICA. Aqui fica so o que o Click faz em volta: conferir os dois campos,
1266:     * entregar os valores ao Business Object e fechar a tela.
1267:     *
1268:     * PUBLIC porque e alvo de BINDEVENT (handler PROTECTED falha em silencio).
1269:     *
1270:     * Ver notas 25 a 29 do cabecalho.
1271:     *--------------------------------------------------------------------------
1272:     PROCEDURE BtnCopiarClick()
1273:         LOCAL loc_cOrigem, loc_cDestino, loc_lProsseguir, loc_lCopiou, loc_oErro
1274: 
1275:         *-- Ver nota 26: a copia abre uma transacao de 15 tabelas e os MsgAviso
1276:         *-- dos guards tiram e devolvem o foco - duplo clique no botao
1277:         *-- dispararia o processo duas vezes.
1278:         IF THIS.this_lEmCopia
1279:             RETURN
1280:         ENDIF
1281: 
1282:         THIS.this_lEmCopia = .T.
1283: 
1284:         loc_lCopiou = .F.
1285: 
1286:         TRY
1287:             loc_lProsseguir = .T.
1288: 
1289:             loc_cOrigem  = ALLTRIM(THIS.txt_4c_Origem.Value)
1290:             loc_cDestino = ALLTRIM(THIS.txt_4c_Destino.Value)
1291: 
1292:             *-- "If Empty(ThisForm.GetOrigem.Value) / MessageBox / Return"
1293:             IF EMPTY(loc_cOrigem)
1294:                 MsgAviso("Origem Invalida !!!")
1295:                 loc_lProsseguir = .F.
1296:             ENDIF
1297: 
1298:             *-- "If Empty(ThisForm.GetDestino.Value) / MessageBox / Return"
1299:             IF loc_lProsseguir
1300:                 IF EMPTY(loc_cDestino)
1301:                     *-- Literal do legado, SEM acento ("Invalido"), igual ao
1302:                     *-- texto que SigOpCopBO.ValidarDados usa
1303:                     MsgAviso("Destino Invalido !!!")
1304:                     loc_lProsseguir = .F.
1305:                 ENDIF
1306:             ENDIF
1307: 
1308:             IF loc_lProsseguir
1309:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
1310:                     MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1311:                             "o dispon" + CHR(237) + "vel - a c" + CHR(243) + ;
1312:                             "pia n" + CHR(227) + "o pode ser executada.", ;
1313:                             "Erro em BtnCopiarClick")
1314:                     loc_lProsseguir = .F.
1315:                 ENDIF
1316:             ENDIF
1317: 
1318:             IF loc_lProsseguir
1319:                 *-- Ver nota 25: NovoRegistro() ANTES do espelho, porque ele
1320:                 *-- chama LimparDados() e zeraria propriedades recem-escritas.
1321:                 THIS.this_oBusinessObject.NovoRegistro()
1322: 
1323:                 *-- Ver nota 30: o espelho tela -> Business Object mora em
1324:                 *-- FormParaBO, nao inline aqui. Ele devolve .F. quando a
1325:                 *-- transferencia nao pode ser feita, e nesse caso a gravacao
1326:                 *-- ABORTA: seguir em frente gravaria registro PARCIAL sem
1327:                 *-- erro visivel.
1328:                 IF !THIS.FormParaBO()
1329:                     loc_lProsseguir = .F.
1330:                 ENDIF
1331:             ENDIF
1332: 
1333:             IF loc_lProsseguir
1334:                 *-- Ver nota 31: a tela e travada enquanto a transacao das 15
1335:                 *-- tabelas corre. O destravamento NAO fica aqui - esta DEPOIS
1336:                 *-- do ENDTRY, junto com a liberacao da guarda, senao uma
1337:                 *-- excecao no Salvar deixaria a tela travada para sempre
1338:                 *-- (quem desabilita tem de reabilitar - regra #40).
1339:                 THIS.HabilitarCampos(.F.)
1340: 
1341:                 *-- Salvar() roda ValidarDados() (que repete os dois guards e a
1342:                 *-- conferencia de duplicidade) e so depois chama Inserir(), que
1343:                 *-- e o copiador das 15 tabelas em transacao unica.

*-- Linhas 1357 a 1499:
1357:             loc_lCopiou = .F.
1358:             MsgErro(loc_oErro.Message + CHR(13) + ;
1359:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1360:                     "Procedure: " + loc_oErro.Procedure, ;
1361:                     "Erro em BtnCopiarClick")
1362:         ENDTRY
1363: 
1364:         *-- Liberar DEPOIS do ENDTRY (vale tambem quando o CATCH dispara) e
1365:         *-- ANTES do Release() - ver nota 26. O destravamento da tela anda
1366:         *-- junto, pelo mesmo motivo: no caminho de sucesso o form fecha logo
1367:         *-- abaixo e o estado nao importa, mas no caminho de FALHA (recusa do
1368:         *-- ValidarDados ou excecao) a tela continua aberta e tem de voltar a
1369:         *-- aceitar digitacao para o usuario corrigir o destino.
1370:         THIS.this_lEmCopia = .F.
1371:         THIS.HabilitarCampos(.T.)
1372: 
1373:         IF loc_lCopiou
1374:             *-- Ver nota 27: repinte da lista do chamador, que no legado vinha
1375:             *-- de graca pelo cursor compartilhado, e so depois o
1376:             *-- "ThisForm.Release" que fecha o Click legado.
1377:             THIS.AtualizarFormPai()
1378:             THIS.Release()
1379:         ENDIF
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * AtualizarFormPai - recarrega a lista do form CHAMADOR depois de uma copia
1384:     * bem-sucedida.
1385:     *
1386:     * No legado o dialogo adota a data session do pai
1387:     * ("ThisForm.DataSessionId = poForm.DataSessionId") e grava nos cursores
1388:     * crSigCdOpe/crSigOpCdc/... que sao os MESMOS do Cadastro de Operacoes -
1389:     * inclusive o RecordSource da grade dele. O PILAR 3 eliminou o cursor
1390:     * global compartilhado (cada form tem o seu BO e o seu cursor_4c_*), entao
1391:     * o repinte que o legado ganhava de brinde precisa ser escrito a mao.
1392:     *
1393:     * O pai e OPCIONAL (.NULL. quando a tela e aberta pelo menu ou pelo
1394:     * harness) e nem todo chamador tem CarregarLista, dai as duas guardas; e a
1395:     * falha de repinte e AVISO, nunca erro fatal - a copia ja esta confirmada
1396:     * no banco. Ver nota 27.
1397:     *--------------------------------------------------------------------------
1398:     PROTECTED PROCEDURE AtualizarFormPai()
1399:         LOCAL loc_oErro
1400: 
1401:         IF VARTYPE(THIS.this_oFormPai) != "O"
1402:             RETURN
1403:         ENDIF
1404: 
1405:         TRY
1406:             *-- PEMSTATUS com atributo 5 confere EXISTENCIA do membro, que e
1407:             *-- exatamente o que se quer aqui (nao escopo - ver regra #34)
1408:             IF PEMSTATUS(THIS.this_oFormPai, "CarregarLista", 5)
1409:                 THIS.this_oFormPai.CarregarLista()
1410:             ENDIF
1411:         CATCH TO loc_oErro
1412:             MsgAviso("A c" + CHR(243) + "pia foi gravada, mas a lista da tela " + ;
1413:                      "anterior n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
1414:                      "atualizada:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1415:                      "Reabra a tela de Opera" + CHR(231) + CHR(245) + "es para " + ;
1416:                      "ver a nova movimenta" + CHR(231) + CHR(227) + "o.")
1417:         ENDTRY
1418:     ENDPROC
1419: 
1420:     *--------------------------------------------------------------------------
1421:     * BtnEncerrarClick - cmg_4c_Botoes.Buttons(2) (CmdExit do legado), cujo
1422:     * Click inteiro e "Release Windows": fecha a tela e devolve o controle ao
1423:     * form chamador.
1424:     *
1425:     * THIS.Release() e o equivalente na arquitetura nova - dispara o Destroy,
1426:     * que solta a referencia ao chamador e delega ao FormBase (liberacao do
1427:     * Business Object + restauracao dos popups do menu principal). PUBLIC
1428:     * porque e alvo de BINDEVENT: handler PROTECTED falha em silencio.
1429:     *--------------------------------------------------------------------------
1430:     PROCEDURE BtnEncerrarClick()
1431:         THIS.Release()
1432:     ENDPROC
1433: 
1434:     *--------------------------------------------------------------------------
1435:     * HabilitarCampos - estado de EDICAO dos dois campos e do botao de acao.
1436:     *
1437:     * Centraliza a UNICA regra de editabilidade que o SIGOPCOP tem, para que
1438:     * ela nao fique duplicada em ConfigurarCampos, LimparCampos e BOParaForm:
1439:     *
1440:     *   txt_4c_Origem  - somente-exibicao QUANDO a origem veio do chamador
1441:     *                    (equivalente ao "PROCEDURE When / Return .f." do
1442:     *                    GetOrigem legado); digitavel quando a tela foi aberta
1443:     *                    sem chamador - ver nota 19 do cabecalho
1444:     *   txt_4c_Destino - sempre digitavel: e o campo que o usuario vem informar
1445:     *
1446:     * par_lHabilitar = .F. TRAVA a tela (os dois campos e o Copiar) e e usado
1447:     * enquanto a transacao das 15 tabelas corre; par_lHabilitar = .T. devolve
1448:     * cada controle ao estado que a regra acima manda - nao a ".T. em tudo",
1449:     * senao a origem trazida pelo chamador viraria editavel e a tela divergiria
1450:     * do legado. Ver nota 31.
1451:     *
1452:     * Encerrar fica FORA: ele nunca e desabilitado, nem durante a copia - e a
1453:     * unica saida da tela (o form tem ControlBox = .F. e TitleBar = 0, logo nao
1454:     * ha botao de fechar da janela), e desabilita-lo deixaria o usuario preso.
1455:     *
1456:     * PROTECTED: so o proprio form chama. Nao e hook de FormBase e nada fora
1457:     * da classe precisa dele.
1458:     *--------------------------------------------------------------------------
1459:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1460:         LOCAL loc_lHabilitar, loc_lOrigemDoChamador
1461: 
1462:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1463: 
1464:         *-- Ver nota 19: a origem recebida do chamador e somente-exibicao
1465:         loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))
1466: 
1467:         IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1468:             WITH THIS.txt_4c_Origem
1469:                 .ReadOnly = loc_lOrigemDoChamador OR !loc_lHabilitar
1470:                 .TabStop  = !loc_lOrigemDoChamador AND loc_lHabilitar
1471:             ENDWITH
1472:         ENDIF
1473: 
1474:         IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1475:             WITH THIS.txt_4c_Destino
1476:                 .ReadOnly = !loc_lHabilitar
1477:                 .TabStop  = loc_lHabilitar
1478:             ENDWITH
1479:         ENDIF
1480: 
1481:         *-- Buttons(1) = CmdCopia. Enabled, nao Visible: o botao tem Caption
1482:         *-- ALEM do Picture, e Buttons(N) de CommandGroup desenha o icone
1483:         *-- normalmente com Enabled = .F. - o apagamento de icone em
1484:         *-- Enabled = .F. e de CommandButton STANDALONE icone-only (Caption
1485:         *-- vazio), que nao e o caso aqui.
1486:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1487:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHabilitar
1488:         ENDIF
1489:     ENDPROC
1490: 
1491:     *--------------------------------------------------------------------------
1492:     * LimparCampos - devolve a tela ao estado de abertura.
1493:     *
1494:     * NAO e "zerar os dois campos": a origem volta ao valor que o chamador
1495:     * trouxe - que e o que o "ThisForm.GetOrigem.Value = pOperacao" do Init
1496:     * legado poe la, e o que o usuario precisa ver para saber O QUE esta sendo
1497:     * copiado - e so o DESTINO, o campo que o usuario digita, e esvaziado.
1498:     * Zerar os dois faria a tela perder o contexto da copia sem que nada o
1499:     * recolocasse, porque o Init nao roda de novo.

*-- Linhas 1505 a 1678:
1505:     * nivel da heranca torna o metodo protegido, e declara-lo sem modificador
1506:     * aqui NAO alargaria o escopo (regra #51). Nada fora da classe o chama.
1507:     *--------------------------------------------------------------------------
1508:     PROTECTED PROCEDURE LimparCampos()
1509:         IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1510:             THIS.txt_4c_Origem.Value = THIS.this_cOperacaoOrigem
1511:         ENDIF
1512: 
1513:         IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1514:             THIS.txt_4c_Destino.Value = ""
1515:         ENDIF
1516: 
1517:         THIS.HabilitarCampos(.T.)
1518:     ENDPROC
1519: 
1520:     *--------------------------------------------------------------------------
1521:     * FormParaBO - espelho TELA -> Business Object.
1522:     *
1523:     * E o "lcOpeOri = ThisForm.GetOrigem.Value / lcOpeDes =
1524:     * ThisForm.GetDestino.Value" do CmdCopia.Click legado: os DOIS unicos
1525:     * valores que esta tela produz, que sao exatamente os dois campos
1526:     * editaveis do SCX.
1527:     *
1528:     * As demais propriedades do SigOpCopBO (nDopes, Programas, Menus,
1529:     * SubMenus, CArqIcones, o bloco de SigCdPrg, a transacao) NAO entram aqui,
1530:     * e isso nao e esquecimento: nenhuma delas tem controle na tela. O legado
1531:     * as produz dentro do proprio Click - fGerUniqueKey para o nDopes e
1532:     * Scatter do registro de ORIGEM para o resto - e no migrado isso mora em
1533:     * SigOpCopBO.Inserir/CarregarOrigem. Transferi-las daqui seria inventar
1534:     * origem de dado que a tela nao tem.
1535:     *
1536:     * FUNCTION, nao PROCEDURE: devolve .F. quando a transferencia nao pode ser
1537:     * feita, e BtnCopiarClick ABORTA a gravacao nesse caso. Transferencia que
1538:     * falha e segue em frente grava registro PARCIAL sem erro visivel - o
1539:     * defeito silencioso que a regra do erro 11 em FormParaBO descreve.
1540:     *
1541:     * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
1542:     *--------------------------------------------------------------------------
1543:     PROTECTED FUNCTION FormParaBO()
1544:         LOCAL loc_lSucesso, loc_oErro
1545: 
1546:         loc_lSucesso = .F.
1547: 
1548:         TRY
1549:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1550:                PEMSTATUS(THIS, "txt_4c_Origem", 5) AND ;
1551:                PEMSTATUS(THIS, "txt_4c_Destino", 5)
1552: 
1553:                 *-- ALLTRIM nos DOIS: a chave de SigCdOpe e a coluna dopes
1554:                 *-- char(20) SOZINHA, nao uma chave posicional concatenada,
1555:                 *-- logo tirar o padding aqui nao desloca nada (regra #42). O
1556:                 *-- EscaparSQL do Business Object recebe o valor ja sem
1557:                 *-- brancos, como o legado faz ao concatenar This.Value direto
1558:                 *-- no WHERE.
1559:                 THIS.this_oBusinessObject.this_cOperacaoOrigem = ;
1560:                     ALLTRIM(THIS.txt_4c_Origem.Value)
1561: 
1562:                 THIS.this_oBusinessObject.this_cOperacaoDestino = ;
1563:                     ALLTRIM(THIS.txt_4c_Destino.Value)
1564: 
1565:                 loc_lSucesso = .T.
1566:             ELSE
1567:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel transferir " + ;
1568:                         "os dados da tela para o objeto de neg" + CHR(243) + "cio.", ;
1569:                         "Erro em FormParaBO")
1570:             ENDIF
1571:         CATCH TO loc_oErro
1572:             MsgErro(loc_oErro.Message + CHR(13) + ;
1573:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1574:                     "Procedure: " + loc_oErro.Procedure, ;
1575:                     "Erro em FormParaBO")
1576:         ENDTRY
1577: 
1578:         RETURN loc_lSucesso
1579:     ENDFUNC
1580: 
1581:     *--------------------------------------------------------------------------
1582:     * BOParaForm - espelho Business Object -> TELA, o inverso do FormParaBO
1583:     * sobre os MESMOS dois campos.
1584:     *
1585:     * No legado nao existe caminho de "carregar registro na tela": o SIGOPCOP
1586:     * recebe a origem por parametro e nunca reabre um registro gravado. Os
1587:     * dois usos aqui sao REAIS e nascem da arquitetura nova:
1588:     *
1589:     *   1. InicializarForm semeia o Business Object com a origem recebida do
1590:     *      chamador ANTES de os TextBox existirem; montados os campos, este
1591:     *      metodo e quem leva o valor a tela - no lugar de ConfigurarCampos
1592:     *      ler a propriedade por conta propria. Fonte UNICA do valor.
1593:     *   2. Quando o lookup de SigCdOpe resolve a origem (AbrirBuscaOrigem) ou
1594:     *      o Business Object normaliza o destino em ValidarDados, a tela passa
1595:     *      a refletir o que de fato sera gravado.
1596:     *
1597:     * Fecha reaplicando a regra de editabilidade: origem que ACABOU de chegar
1598:     * do Business Object e, por definicao, origem vinda do chamador, e tem de
1599:     * ficar somente-exibicao como no legado.
1600:     *
1601:     * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
1602:     *--------------------------------------------------------------------------
1603:     PROTECTED PROCEDURE BOParaForm()
1604:         LOCAL loc_cOrigem, loc_oErro
1605: 
1606:         TRY
1607:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1608:                 loc_cOrigem = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoOrigem, ""))
1609: 
1610:                 *-- A origem exibida e a que vale para o resto da tela:
1611:                 *-- HabilitarCampos e LimparCampos leem this_cOperacaoOrigem
1612:                 *-- para decidir se o campo e digitavel, entao o espelho
1613:                 *-- atualiza a propriedade do form JUNTO com o controle.
1614:                 THIS.this_cOperacaoOrigem = loc_cOrigem
1615: 
1616:                 IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
1617:                     THIS.txt_4c_Origem.Value = loc_cOrigem
1618:                 ENDIF
1619: 
1620:                 IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
1621:                     THIS.txt_4c_Destino.Value = ;
1622:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoDestino, ""))
1623:                 ENDIF
1624: 
1625:                 THIS.HabilitarCampos(.T.)
1626:             ENDIF
1627:         CATCH TO loc_oErro
1628:             MsgErro(loc_oErro.Message + CHR(13) + ;
1629:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1630:                     "Procedure: " + loc_oErro.Procedure, ;
1631:                     "Erro em BOParaForm")
1632:         ENDTRY
1633:     ENDPROC
1634: 
1635:     *--------------------------------------------------------------------------
1636:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.;
1637:     * este metodo percorre a arvore e os torna visiveis.
1638:     *
1639:     * Sem lista de excecao: o SIGOPCOP nao tem container flutuante nem
1640:     * controle com Visible = .F. declarado no dump - os dez objetos do SCX
1641:     * estao todos na tela desde a abertura.
1642:     *--------------------------------------------------------------------------
1643:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1644:         LOCAL loc_nI, loc_oControle
1645: 
1646:         IF VARTYPE(par_oContainer) != "O"
1647:             RETURN
1648:         ENDIF
1649: 
1650:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1651:             loc_oControle = par_oContainer.Controls(loc_nI)
1652: 
1653:             IF VARTYPE(loc_oControle) = "O"
1654:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
1655:                     loc_oControle.Visible = .T.
1656:                 ENDIF
1657: 
1658:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
1659:                     THIS.TornarControlesVisiveis(loc_oControle)
1660:                 ENDIF
1661:             ENDIF
1662:         ENDFOR
1663:     ENDPROC
1664: 
1665:     *--------------------------------------------------------------------------
1666:     * Destroy - solta a referencia ao form chamador e delega ao FormBase, que
1667:     * libera o Business Object e restaura os popups do menu principal (fix
1668:     * menu-shrinks). DODEFAULT() na ULTIMA linha e obrigatorio: sem ele a
1669:     * cadeia de heranca e quebrada e os popups ficam com o cache visual
1670:     * encolhido.
1671:     *--------------------------------------------------------------------------
1672:     PROCEDURE Destroy()
1673:         THIS.this_oFormPai = .NULL.
1674: 
1675:         DODEFAULT()
1676:     ENDPROC
1677: 
1678: ENDDEFINE


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

