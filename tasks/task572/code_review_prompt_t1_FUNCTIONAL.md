# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (28)
- [METODO-INEXISTENTE] Metodo 'THIS.HaPagamentoPendente()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.HaFormaPagamentoEmAberto()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescontoBloqueadoPorSituacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ContaBloqueiaDesconto()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.HaSubNivelInformado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ContarItensLancados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.HaItemNaoImpresso()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.GravarDocumento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Pendencia): Top original=0 vs migrado 'lbl_4c_Label17' Top=70 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Pendencia): Left original=0 vs migrado 'lbl_4c_Label17' Left=57 (diff=57px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.CancelaItem): Top original=0 vs migrado 'lbl_4c_Label17' Top=70 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.CancelaItem): Left original=1 vs migrado 'lbl_4c_Label17' Left=57 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVITS.CancelaItem): Left original=32 vs migrado 'lbl_4c_Label2' Left=93 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITS.CancelaItem): Top original=58 vs migrado 'lbl_4c_Label3' Top=25 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGMVITS.CancelaItem): Left original=16 vs migrado 'lbl_4c_Label3' Left=85 (diff=69px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGMVITS.CancelaItem): Top original=84 vs migrado 'lbl_4c_Label4' Top=2 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Fpagto): Top original=-1 vs migrado 'lbl_4c_Label17' Top=70 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Fpagto): Left original=13 vs migrado 'lbl_4c_Label17' Left=57 (diff=44px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Mensagem' (parent: SIGMVITS.Cnt_Mensagem): Top original=2 vs migrado 'cnt_4c__Mensagem' Top=684 (diff=682px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Mensagem' (parent: SIGMVITS.Cnt_Mensagem): Left original=3 vs migrado 'cnt_4c__Mensagem' Left=97 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'pendencia' (parent: SIGMVITS.Barra_Botoes): Left original=189 vs migrado 'cnt_4c__Pendencia' Left=403 (diff=214px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'identifica' (parent: SIGMVITS.Barra_Botoes): Top original=45 vs migrado 'cnt_4c__Identifica' Top=171 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'identifica' (parent: SIGMVITS.Barra_Botoes): Left original=97 vs migrado 'cnt_4c__Identifica' Left=5 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGMVITS.Barra_Botoes): Left original=449 vs migrado 'cnt_4c_CancelaItem' Left=296 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pagto' (parent: SIGMVITS.Barra_Botoes): Top original=45 vs migrado 'cnt_4c__Fpagto' Top=175 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pagto' (parent: SIGMVITS.Barra_Botoes): Left original=189 vs migrado 'cnt_4c__Fpagto' Left=-8 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Identifica): Top original=3 vs migrado 'lbl_4c_Label17' Top=70 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVITS.Cnt_Identifica): Left original=0 vs migrado 'lbl_4c_Label17' Left=57 (diff=57px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvits.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5873 linhas total):

*-- Linhas 9 a 388:
9: *   BD   -> SigMvCab/SigMvItn/SigOpFp/SigCdCli/SigCdOpe (ver sigmvitsBO.prg)
10: *   CODE -> arquitetura em camadas (FormBase / sigmvitsBO)
11: *
12: * FASE 3/8 - Estrutura Base: DEFINE CLASS, Init/InicializarForm/Destroy e os
13: * containers principais do layout legado, ainda VAZIOS (sem grids, campos
14: * ou botoes - essas pecas entram nas Fases 4 a 8). Nao ha PageFrame: o
15: * SIGMVITS legado NAO usa o padrao CRUD Page1(Lista)/Page2(Dados) - e um
16: * form OPERACIONAL de layout unico, com containers posicionados livremente
17: * (ver docs\FRAMEWORK_class_codigo_fonte.txt e tasks\task572\layout.json).
18: *
19: * FASE 4/8 - GRADES + BOTOES DE ACAO DAS GRADES + BARRA DE BOTOES PRINCIPAL.
20: * SIGMVITS.SCX e uma tela de Caixa (frente de venda), nao um cadastro: NAO
21: * tem Page1=Lista/Page2=Dados nem os 6 botoes CRUD canonicos (Incluir/
22: * Visualizar/Alterar/Excluir/Buscar/Encerrar), e nao tem grid de LISTAGEM de
23: * registros para o usuario selecionar. Inventar esses 6 botoes ou uma pagina
24: * de Lista violaria o PILAR 1 e a regra "NUNCA inventar funcionalidade que o
25: * legado nao tem" (mesma decisao ja tomada em FormSigMvExp.prg/Formsigmvitn.prg
26: * - form irmao migrado da mesma familia SIGMV*, com o MESMO Cnt_Pendencia.
27: * GradeMultiSubN). O que esta fase adiciona, fiel ao dump (layout.json/
28: * mapeamento.json/sigmvits_form_codigo_fonte_slim.txt):
29: *
30: *   AS TRES GRADES do legado e o seu bind:
31: *     grd_4c_SubNiveis  (Cnt_Pendencia.GradeMultiSubN) -> TmpOperacao
32: *     grd_4c_Cupom      (CntGrade.GrdCupom)            -> crTpmMvItnC
33: *     grd_4c_FormasPag  (GrdFP, filha direta do form, oculta/Enabled=.F.
34: *                        no legado - RecordSource "xParC" e populada por
35: *                        SQL dinamico dentro do Confirmar (Barra_Botoes.ok);
36: *                        a estrutura e criada aqui, o bind fica para a fase
37: *                        de eventos, quando o cursor realmente existir -
38: *                        CLAUDE.md #41)
39: *   Junto vao os botoes que o legado cola nas grades: cmd_4c_Proximo e
40: *   o botao [F3]Pend. de Cnt_Pendencia, e os totais Cnt_subt/Get_Total e
41: *   cnt_tots/Get_total que ficam colados embaixo do GrdCupom.
42: *
43: *   OS CURSORES (CriarCursoresGrades): TmpOperacao e crTpmMvItnC nascem aqui,
44: *   com a estrutura transcrita do uso real no dump (comportamento.json) e da
45: *   mesma estrutura ja usada no form irmao Formsigmvitn.prg (identico
46: *   Cnt_Pendencia.GradeMultiSubN).
47: *
48: *   A BARRA DE BOTOES PRINCIPAL (cnt_4c_Barra_Botoes, criada vazia na Fase 3)
49: *   recebe aqui os 16 CommandButtons do legado (ConfigurarBotoesBarraPrincipal),
50: *   com Picture/Caption/posicao EXATOS do dump. Varios pares ocupam o MESMO
51: *   Left (Desconto/Acrescimo em Left=5,Top=45; CancPagto/apaga em Left=97,
52: *   Top=6; Financia/pendencia em Left=189,Top=6) porque a barra alterna qual
53: *   conjunto fica visivel conforme o estado da venda - a alternancia de
54: *   .Visible e os Click ficam para as Fases 7-8.
55: *
56: *   TextBoxes/ComboBox de dados (Fases 5-6) e eventos/handlers de Click/
57: *   KeyPress (Fases 7-8) NAO sao incluidos aqui.
58: *
59: * FASE 6/8 - CAMPOS RESTANTES (Cnt_Fpagto/Cnt_Identifica) + LOOKUPS.
60: * Completa os campos de dados que faltavam (segunda metade, apos a Fase 5):
61: *
62: *   cnt_4c__Fpagto (ConfigurarCamposPagamento): Desconto/Acrescimo da
63: *   venda, bloco Observacao, os 5 totalizadores (Total/Pagamentos/A Pagar/
64: *   Saldo Final/Desconto Promocional), cnt_forma (forma de pagamento/
65: *   parcelas/valor/vencimento - com LOOKUP de forma de pagamento) e os dois
66: *   paineis flutuantes ocultos Cnt_ChequepreTef (dados do cheque/TEF) e
67: *   cntnsu (NSU/Autorizacao/Adquirente - com LOOKUP de adquirente).
68: *
69: *   cnt_4c__Identifica (ConfigurarCamposIdentificacao + o factory
70: *   MontarBlocoIdentificacao): os 4 blocos IDENTICOS de identificacao de
71: *   conta (Destino/Responsavel/Vendedor/Origem - Grupo/Conta/Nome/CPF, cada
72: *   um com LOOKUP de grupo, conta e conta-por-CPF), Tab.Desconto/Lista de
73: *   Precos (com LOOKUP) e o bloco CodOperacao (Documento/Pedido Cliente).
74: *
75: *   LOOKUPS implementados (FormBuscaAuxiliar, contrato this_lAchouRegistro/
76: *   this_lSelecionou - CLAUDE.md #37): Forma de Pagamento (SigOpFp),
77: *   Adquirente (SigCdCad tipocads='ADQUIRENTE'), Tabela de Desconto
78: *   (SigOpTdz), Lista de Precos (SigCdLpc), Grupo de Contas (SigCdGrp),
79: *   Conta (SigCdCli por Iclis) e Conta por CPF/CNPJ (SigCdCli por Cpfs) -
80: *   os tres ultimos parametrizados por bloco (Destino/Responsavel/Vendedor/
81: *   Origem) via AbrirLookupGrupo/AbrirLookupConta/AbrirLookupContaPorCpf.
82: *
83: * CHAMADA:
84: *   loForm = CREATEOBJECT("Formsigmvits")
85: *   loForm.Show()
86: *==============================================================================*
87: 
88: DEFINE CLASS Formsigmvits AS FormBase
89: 
90:     *-- Dimensoes e comportamento identicos ao legado (SIGMVITS.SCX)
91:     Height       = 750
92:     Width        = 1280
93:     BorderStyle  = 0
94:     AutoCenter   = .T.
95:     TitleBar     = 0
96:     ShowWindow   = 1
97:     WindowType   = 1
98:     ControlBox   = .F.
99:     Closable     = .F.
100:     MaxButton    = .F.
101:     MinButton    = .F.
102:     Movable      = .F.
103:     ClipControls = .F.
104:     KeyPreview   = .T.
105:     ShowTips     = .T.
106:     DataSession  = 2
107: 
108:     *-- Estado operacional do Caixa (equivalente as properties/PUBLIC do legado)
109:     this_cOpEscolha = ""   && Op_Escolha: "INSERIR"/"ALTERAR"/"CANCELAR" - modo atual do cupom
110:     this_nCItem     = 0    && CItem: numero sequencial do proximo item do cupom
111:     this_lIniciou   = .F.  && Inicia: indica se o cupom fiscal ja foi iniciado
112: 
113:     *-- FASE 7: estado consumido pelos eventos dos botoes. Cada property
114:     *-- corresponde a uma do form legado (nome entre parenteses) e e DECLARADA
115:     *-- aqui porque LEITURA de property nao declarada estoura "Property ... is
116:     *-- not found" na primeira vez, antes de qualquer atribuicao.
117:     this_cTelaAtual     = "ITENS"  && qual container de operacao esta visivel
118:     this_lValidaDesconto = .F.     && Validadesconto: desconto/acrescimo em edicao
119:     this_lAlteraQtd      = .F.     && lAlteraqtd: usuario pediu alteracao de quantidade
120:     this_lAlteraValor    = .F.     && lAlteraValor: usuario pediu alteracao de preco
121:     this_lCancelouItem   = .F.     && CancelouItem: houve cancelamento de item no cupom
122:     this_nUltimoCancel   = 0       && UltimoCancel: maior numero de item cancelado
123:     this_lEditaOrigem    = .F.     && EditaOrigem: bloco Origem liberado para edicao
124:     this_lEditaDestino   = .F.     && EditaDestino: bloco Destino liberado para edicao
125:     this_lLiberaIdent    = .F.     && LiberaIdent: identificacao liberada fora do fluxo
126:     this_nTotIte         = 0       && TotIte: total dos itens do cupom
127:     this_lLibTroco       = .F.     && Libtroco: troco liberado nesta operacao
128:     this_nBcds           = 0       && Bcds: bonus/credito acumulado nas parcelas
129: 
130:     *==========================================================================
131:     PROCEDURE Init
132:     *==========================================================================
133:         RETURN DODEFAULT()
134:     ENDPROC
135: 
136:     *==========================================================================
137:     PROTECTED PROCEDURE InicializarForm
138:     *==========================================================================
139:         LOCAL loc_lSucesso
140:         loc_lSucesso = .F.
141: 
142:         THIS.this_oBusinessObject = CREATEOBJECT("sigmvitsBO")
143:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
144:             MsgErro("Falha ao criar sigmvitsBO", "Erro")
145:         ELSE
146:             *-- Toda vez que o Caixa abre, o cupom que esta sendo montado e
147:             *-- NOVO (nao ha tela de Buscar/Alterar aqui - regra #20 do
148:             *-- CLAUDE.md: sem isto this_lEmEdicao fica .F. e Salvar() falha
149:             *-- calado no primeiro IF).
150:             THIS.this_oBusinessObject.NovoRegistro()
151: 
152:             THIS.Caption   = "Caixa"
153:             THIS.BackColor = RGB(255, 255, 255)
154: 
155:             *-- DataSession = 2 da ao form uma datasession PRIVADA com os SETs
156:             *-- no DEFAULT do VFP, e o default de DELETED e OFF (mesma familia
157:             *-- da regra #9.4 do CLAUDE.md, que trata de SET DATE/CENTURY). O
158:             *-- legado rodava na datasession compartilhada, onde o config.prg
159:             *-- ja deixou SET DELETED ON - sem isto, o item cancelado (DELETE
160:             *-- em crTpmMvItn) continuaria aparecendo na grade do cupom e
161:             *-- entrando nos totais.
162:             SET DELETED ON
163: 
164:             *-- Os cursores das grades nascem ANTES dos controles: assim o
165:             *-- MontaGrade, mais abaixo, encontra os alias prontos. Ligar
166:             *-- Column.ControlSource a cursor inexistente derruba o Init
167:             *-- (CLAUDE.md #41).
168:             THIS.CriarCursoresGrades()
169: 
170:             THIS.ConfigurarContainerPrincipal()
171: 
172:             *-- Bind das grades (RecordSource/ControlSource/Width/cabecalhos).
173:             *-- Separado da criacao dos controles porque RecordSource reseta
174:             *-- Width, Header1.Caption, CurrentControl e Sparse - tudo isso
175:             *-- precisa vir DEPOIS dele (Problema 48 / CLAUDE.md #41).
176:             THIS.MontaGrade()
177: 
178:             *-- FASE 7: liga os Click/Timer. Vai DEPOIS de todo AddObject -
179:             *-- BINDEVENT contra objeto que ainda nao existe estoura no Init.
180:             THIS.RegistrarEventosPrincipais()
181: 
182:             *-- FASE 7: estado inicial da tela. O legado faz isso no proprio
183:             *-- Init ("Cnt_identifica.Visible = .f. / Cnt_pendencia.Visible =
184:             *-- .f. / Cnt_Fpagto.Visible = .f. / grdFP.Visible = .f."), deixando
185:             *-- so a tela de ITENS a mostra; sem esta chamada os quatro
186:             *-- containers de operacao, criados Visible = .T. nas Fases 3-6,
187:             *-- abrem empilhados na mesma area.
188:             THIS.AlternarTelaOperacao("ITENS")
189:             THIS.RecalcularTotais()
190: 
191:             loc_lSucesso = .T.
192:         ENDIF
193: 
194:         RETURN loc_lSucesso
195:     ENDPROC
196: 
197:     *==========================================================================
198:     PROTECTED PROCEDURE ConfigurarContainerPrincipal
199:     *==========================================================================
200:     * Orquestra a criacao de TODOS os containers de topo do form, na mesma
201:     * ordem do dump do SCX legado (SECAO 1/2 de
202:     * tasks\task572\sigmvits_form_codigo_fonte_slim.txt). Cada container
203:     * nasce VAZIO nesta fase - os filhos (grids/campos/botoes) sao
204:     * adicionados nas Fases 4 a 8.
205:     *
206:     * O legado tem 14 objetos de topo; 13 sao criados aqui (12 na Fase 3 +
207:     * GrdFP na Fase 4). O 1 restante NAO esta esquecido - e peca de fase
208:     * posterior, registrado aqui para nao se perder silenciosamente:
209:     *   - READCOMM (Class readcomm de framework.vcx, container com OLE MSComm)
210:     *              -> leitora serial de cheque (ThisForm.ReadComm.leitura()).
211:     *              Depende de SET CLASSLIB do VCX legado e so faz sentido com
212:     *              os eventos do Cnt_ChequepreTef; entra nas FASES 7/8.
213:     *==========================================================================
214:         THIS.ConfigurarCabecalho()
215:         THIS.ConfigurarAreaItem()
216:         THIS.ConfigurarCamposAreaItem()
217:         THIS.ConfigurarGrdFormasPagamento()
218:         THIS.ConfigurarAreaPendencia()
219:         THIS.ConfigurarGradeSubNiveis()
220:         THIS.ConfigurarAreaCancelamento()
221:         THIS.ConfigurarCamposCancelamento()
222:         THIS.ConfigurarAreaPagamento()
223:         THIS.ConfigurarCamposPagamento()
224:         THIS.ConfigurarAreaIdentificacao()
225:         THIS.ConfigurarCamposIdentificacao()
226:         THIS.ConfigurarBarraBotoes()
227:         THIS.ConfigurarBotoesBarraPrincipal()
228:         THIS.ConfigurarGradeCupom()
229:         THIS.ConfigurarGridCupomInterno()
230:         THIS.ConfigurarAreaMensagens()
231:         THIS.ConfigurarTimer()
232:     ENDPROC
233: 
234:     *==========================================================================
235:     PROTECTED PROCEDURE ConfigurarCabecalho
236:     *==========================================================================
237:     * cnt_4c__Img4c (logo) + lbl_4c_TxtCaption (barra de titulo) +
238:     * cnt_4c__Mensagem (barra de mensagem/rodape) - mapeamento.json:
239:     * Cnt_Img4c / TxtCaption / Cnt_Mensagem
240:     *==========================================================================
241:         THIS.AddObject("cnt_4c__Img4c", "Container")
242:         WITH THIS.cnt_4c__Img4c
243:             .Top           = 28
244:             .Left          = 4
245:             .Width         = 291
246:             .Height        = 101
247:             .BackStyle     = 0
248:             .BorderWidth   = 0
249:             .SpecialEffect = 2
250:             .ForeColor     = RGB(255, 255, 255)
251:             .Visible       = .T.
252:         ENDWITH
253: 
254:         THIS.AddObject("lbl_4c_TxtCaption", "Label")
255:         WITH THIS.lbl_4c_TxtCaption
256:             .Top       = 0
257:             .Left      = -1
258:             .Width     = 1300
259:             .Height    = 19
260:             .AutoSize  = .F.
261:             .FontBold  = .T.
262:             .FontName  = "Tahoma"
263:             .BackStyle = 1
264:             .ForeColor = RGB(255, 255, 255)
265:             .BackColor = RGB(90, 90, 90)
266:             .Caption   = "  Caixa"
267:             .Visible   = .T.
268:         ENDWITH
269: 
270:         THIS.AddObject("cnt_4c__Mensagem", "Container")
271:         WITH THIS.cnt_4c__Mensagem
272:             .Top           = 684
273:             .Left          = 97
274:             .Width         = 1004
275:             .Height        = 26
276:             .BackStyle     = 1
277:             .BorderWidth   = 0
278:             .SpecialEffect = 2
279:             .ForeColor     = RGB(255, 255, 255)
280:             .BackColor     = RGB(255, 255, 255)
281:             .BorderColor   = RGB(100, 100, 100)
282:             .Visible       = .T.
283:         ENDWITH
284: 
285:         *-- Os dois labels de cnt_4c__Mensagem - mapeamento.json:
286:         *-- Cnt_Mensagem.Mensagem / Cnt_Mensagem.Abertura. Nascem na FASE 7
287:         *-- porque e aqui que passam a ser escritos (Itens/Pagto.Click do
288:         *-- legado: "Cnt_mensagem.Mensagem.Caption = ' '" e
289:         *-- "Cnt_Mensagem.abertura.Caption = Substr(Ttoc(DataAbertura),12,5)").
290:         *-- O Caption de projeto no dump e vazio: o legado o preenche em
291:         *-- runtime.
292:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
293:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
294:             .Top       = 2
295:             .Left      = 3
296:             .Width     = 2
297:             .Height    = 18
298:             .AutoSize  = .T.
299:             .FontBold  = .T.
300:             .FontName  = "Tahoma"
301:             .FontSize  = 10
302:             .BackStyle = 0
303:             .ForeColor = RGB(90, 90, 90)
304:             .Caption   = ""
305:             .Visible   = .T.
306:         ENDWITH
307: 
308:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
309:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
310:             .Top       = 3
311:             .Left      = 317
312:             .Width     = 55
313:             .Height    = 19
314:             .AutoSize  = .F.
315:             .FontBold  = .T.
316:             .FontName  = "Tahoma"
317:             .FontSize  = 10
318:             .BackStyle = 0
319:             .ForeColor = RGB(90, 90, 90)
320:             .Caption   = ""
321:             .Visible   = .T.
322:         ENDWITH
323:     ENDPROC
324: 
325:     *==========================================================================
326:     PROTECTED PROCEDURE ConfigurarAreaItem
327:     *==========================================================================
328:     * cnt_4c_Item - area de digitacao/exibicao do item corrente (produto,
329:     * quantidade, valores) - mapeamento.json: cntItem
330:     *==========================================================================
331:         THIS.AddObject("cnt_4c_Item", "Container")
332:         WITH THIS.cnt_4c_Item
333:             .Top           = 140
334:             .Left          = 65
335:             .Width         = 1003
336:             .Height        = 499
337:             .BackStyle = 1
338:             .BorderWidth   = 0
339:             .SpecialEffect = 2
340:             .ForeColor     = RGB(255, 255, 255)
341:             .BackColor     = RGB(255, 255, 255)
342:             .BorderColor   = RGB(100, 100, 100)
343:             .Visible       = .T.
344:         ENDWITH
345:     ENDPROC
346: 
347:     *==========================================================================
348:     PROTECTED PROCEDURE ConfigurarCamposAreaItem
349:     *==========================================================================
350:     * Sub-containers e campos de cnt_4c_Item (container ja criado em
351:     * ConfigurarAreaItem): o bloco de digitacao/exibicao do item corrente
352:     * (produto, quantidade, valor unitario, descontos/acrescimos e as duas
353:     * imagens flutuantes de produto/empresa) - mapeamento.json: filhos de
354:     * cntItem (Cnt_Prod, Cnt_Qtd, cnt_val, Cnt_ValU, Cnt_pDesc, Cnt_vdesc,
355:     * Cnt_pacre, Cnt_vacre, Cnt_imgProd, Cnt_ImgEmp, Proximo).
356:     *
357:     * FASE 5/8 - primeira metade dos campos principais do form.
358:     *==========================================================================
359:         LOCAL loc_cIcones
360:         loc_cIcones = gc_4c_CaminhoIcones
361: 
362:         *-- Cnt_Prod: codigo do produto (Get_Produto) + botao de confirmacao
363:         *-- manual (cmdenviaprod, oculto por padrao - so aparece quando o
364:         *-- legado precisa que o operador confirme o produto digitado).
365:         THIS.cnt_4c_Item.AddObject("cnt_4c__Prod", "Container")
366:         WITH THIS.cnt_4c_Item.cnt_4c__Prod
367:             .Top           = 37
368:             .Left          = 797
369:             .Width         = 200
370:             .Height        = 50
371:             .BackStyle = 1
372:             .BorderWidth   = 1
373:             .SpecialEffect = 2
374:             .BackColor     = RGB(126, 211, 226)
375:             .Visible       = .T.
376:         ENDWITH
377: 
378:         THIS.cnt_4c_Item.cnt_4c__Prod.AddObject("lbl_4c_Label2", "Label")
379:         WITH THIS.cnt_4c_Item.cnt_4c__Prod.lbl_4c_Label2
380:             .Top       = 1
381:             .Left      = 10
382:             .FontBold  = .T.
383:             .FontName  = "Tahoma"
384:             .FontSize  = 8
385:             .BackStyle = 0
386:             .ForeColor = RGB(90, 90, 90)
387:             .Caption   = "C" + CHR(243) + "digo"
388:             .Visible   = .T.

*-- Linhas 821 a 864:
821:     ENDPROC
822: 
823:     *==========================================================================
824:     PROTECTED PROCEDURE ConfigurarGrdFormasPagamento
825:     *==========================================================================
826:     * grd_4c_FormasPag (GrdFP no legado) - grade OCULTA/Enabled=.F. que exibe
827:     * o resumo das formas de pagamento lancadas quando a operacao permite
828:     * parcelamento automatico (crSigCdOpe.ParAutos = 1, Barra_Botoes.ok).
829:     * Filha DIRETA do form (nao de nenhum container) - mapeamento.json: GrdFP.
830:     *
831:     * RecordSource/ControlSource NAO sao setados aqui de proposito: no legado
832:     * o alias "xParC" e um SELECT dinamico (PADR(fpags,20)+... agrupando xPar
833:     * por forma de pagamento) montado dentro do proprio Confirmar - o cursor
834:     * so existe a partir da fase de eventos. Ligar ControlSource contra alias
835:     * inexistente derruba o Init (CLAUDE.md #41).
836:     *
837:     * Original: Top=20 Left=306 Width=445 Height=146 ColumnCount=1 Enabled=.F.
838:     * GridLines=0 GridLineWidth=1 HeaderHeight=20 Panel=1 RecordMark=.F.
839:     * ScrollBars=0 Visible=.F. GridLineColor=192,192,192. Column1:
840:     * FontName="Courier New" FontSize=8 Enabled=.F. Width=432 Visible=.F.
841:     * Header1: FontName="Verdana" FontSize=8 Alignment=2
842:     * Caption="Formas de Pagamento" ForeColor=36,84,155. Text1:
843:     * FontName="Courier New" FontSize=8 Alignment=3 BorderStyle=0 Enabled=.F.
844:     * Format="!" Margin=0 Visible=.F.
845:     *==========================================================================
846:         THIS.AddObject("grd_4c_FormasPag", "Grid")
847:         WITH THIS.grd_4c_FormasPag
848:             .Top           = 20
849:             .Left          = 306
850:             .Width         = 445
851:             .Height        = 146
852:             .ColumnCount   = 1
853:             .Enabled       = .F.
854:             .GridLines     = 0
855:             .GridLineWidth = 1
856:             .HeaderHeight  = 20
857:             .Panel         = 1
858:             .RecordMark    = .F.
859:             .DeleteMark    = .F.
860:             .ScrollBars    = 0
861:             .GridLineColor = RGB(192, 192, 192)
862:             .Visible       = .F.
863: 
864:             .Column1.FontName  = "Courier New"

*-- Linhas 885 a 971:
885:     ENDPROC
886: 
887:     *==========================================================================
888:     PROTECTED PROCEDURE ConfigurarAreaPendencia
889:     *==========================================================================
890:     * cnt_4c__Pendencia - busca de pre-venda/pendencias - mapeamento.json:
891:     * Cnt_Pendencia
892:     *==========================================================================
893:         THIS.AddObject("cnt_4c__Pendencia", "Container")
894:         WITH THIS.cnt_4c__Pendencia
895:             .Top           = 20
896:             .Left          = 403
897:             .Width         = 346
898:             .Height        = 161
899:             .BackStyle     = 1
900:             .BorderWidth   = 0
901:             .SpecialEffect = 2
902:             .BackColor     = RGB(255, 255, 255)
903:             .BorderColor   = RGB(100, 100, 100)
904:             .Visible       = .T.
905:         ENDWITH
906:     ENDPROC
907: 
908:     *==========================================================================
909:     PROTECTED PROCEDURE ConfigurarGradeSubNiveis
910:     *==========================================================================
911:     * grd_4c_SubNiveis (GradeMultiSubN no legado) - lista os sub-niveis/
912:     * pendencias vinculados a movimentacao corrente (cursor TmpOperacao),
913:     * mais o titulo e os dois botoes de navegacao que ficam dentro do mesmo
914:     * container cnt_4c__Pendencia (ja criado em ConfigurarAreaPendencia).
915:     * Nome DIFERENTE do generico "grd_4c_Dados" de mapeamento.json de
916:     * proposito - o JSON mapeia as tres grades do legado (GradeMultiSubN,
917:     * GrdFP, GrdCupom) para o mesmo nome, e virariam irmas homonimas; a
918:     * colisao foi resolvida no proprio mapeamento.json, nao aqui (mesmo
919:     * ajuste feito no form irmao Formsigmvitn.prg/task571 para a MESMA
920:     * GradeMultiSubN).
921:     *
922:     * RecordSource/ControlSource ficam para MontaGrade() - RecordSource
923:     * reseta Width/Header1.Caption/CurrentControl/Sparse (CLAUDE.md #41).
924:     *
925:     * Original: Label1 Top=0 Left=0 Width=347 Height=19 FontBold=.T.
926:     * FontSize=10 Alignment=2 Caption="Busca Pre Venda" ForeColor=255,255,255
927:     * BackColor=90,90,90. GradeMultiSubN Top=21 Left=36 Width=274 Height=91
928:     * ColumnCount=3 FontName="Tahoma" DeleteMark=.F. HeaderHeight=16
929:     * RecordMark=.F. ScrollBars=2 ForeColor=0,0,0 BackColor=255,255,255.
930:     * Column1(Codigos) Width=80 InputMask="9999999999" Header="Pendencias".
931:     * Column2(Notas) Width=80 Header="Notas". Column3(Valor) Width=90
932:     * Header="Valor". Botao Pend. Top=112 Left=36 W=110 H=40
933:     * Picture=date2.ico Caption="[F3]Pend." Proximo Top=112 Left=200 W=110
934:     * H=40 Picture=b_arrow2.bmp Caption="" ForeColor=36,84,155.
935:     *==========================================================================
936:         LOCAL loc_cIcones
937:         loc_cIcones = gc_4c_CaminhoIcones
938: 
939:         THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label1", "Label")
940:         WITH THIS.cnt_4c__Pendencia.lbl_4c_Label1
941:             .Top       = 0
942:             .Left      = 0
943:             .Width     = 347
944:             .Height    = 19
945:             .FontBold  = .T.
946:             .FontSize  = 10
947:             .Alignment = 2
948:             .BackStyle = 1
949:             .ForeColor = RGB(255, 255, 255)
950:             .BackColor = RGB(90, 90, 90)
951:             .Caption   = "Busca Pre Venda"
952:             .Visible   = .T.
953:         ENDWITH
954: 
955:         THIS.cnt_4c__Pendencia.AddObject("grd_4c_SubNiveis", "Grid")
956:         WITH THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
957:             .Top          = 21
958:             .Left         = 36
959:             .Width        = 274
960:             .Height       = 91
961:             .ColumnCount  = 3
962:             .FontName     = "Tahoma"
963:             .HeaderHeight = 16
964:             .ScrollBars   = 2
965:             .DeleteMark   = .F.
966:             .RecordMark   = .F.
967:             .ForeColor    = RGB(0, 0, 0)
968:             .BackColor    = RGB(255, 255, 255)
969:             .Visible      = .T.
970: 
971:             .Column1.FontName  = "Tahoma"

*-- Linhas 1018 a 1732:
1018:             .Column3.Text1.BackColor   = RGB(255, 255, 255)
1019:         ENDWITH
1020: 
1021:         *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
1022:         *-- legado, Cnt_Pendencia.Bot_Pend.Click).
1023:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Bot_Pendentes", "CommandButton")
1024:         WITH THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes
1025:             .Top         = 112
1026:             .Left        = 36
1027:             .Width       = 110
1028:             .Height      = 40
1029:             .FontBold    = .T.
1030:             .FontItalic  = .T.
1031:             .FontName    = "Comic Sans MS"
1032:             .FontSize    = 8
1033:             .WordWrap    = .T.
1034:             .Picture     = loc_cIcones + "date2.ico"
1035:             .Caption     = "[F3]Pend."
1036:             .ToolTipText = "Abre Tela de Pend" + CHR(234) + "ncias"
1037:             .ForeColor   = RGB(90, 90, 90)
1038:             .BackColor   = RGB(255, 255, 255)
1039:             .Themes      = .F.
1040:             .Visible     = .T.
1041:         ENDWITH
1042: 
1043:         *-- Avanca para a proxima tela (Cnt_Pendencia.Proximo.Click).
1044:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
1045:         WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
1046:             .Top         = 112
1047:             .Left        = 200
1048:             .Width       = 110
1049:             .Height      = 40
1050:             .FontName    = "Verdana"
1051:             .FontSize    = 8
1052:             .Picture     = loc_cIcones + "b_arrow2.bmp"
1053:             .Caption     = ""
1054:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
1055:             .ForeColor   = RGB(36, 84, 155)
1056:             .BackColor   = RGB(255, 255, 255)
1057:             .Themes      = .F.
1058:             .Visible     = .T.
1059:         ENDWITH
1060:     ENDPROC
1061: 
1062:     *==========================================================================
1063:     PROTECTED PROCEDURE ConfigurarAreaCancelamento
1064:     *==========================================================================
1065:     * cnt_4c_CancelaItem - painel de cancelamento de item, flutuante e OCULTO
1066:     * por padrao - mapeamento.json: CancelaItem (Visible = .F. no legado)
1067:     *==========================================================================
1068:         THIS.AddObject("cnt_4c_CancelaItem", "Container")
1069:         WITH THIS.cnt_4c_CancelaItem
1070:             .Top           = 20
1071:             .Left          = 296
1072:             .Width         = 462
1073:             .Height        = 139
1074:             .BackStyle     = 1
1075:             .BorderWidth   = 0
1076:             .SpecialEffect = 2
1077:             .BackColor     = RGB(255, 255, 255)
1078:             .BorderColor   = RGB(190, 214, 235)
1079:             .Visible       = .F.
1080:         ENDWITH
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     PROTECTED PROCEDURE ConfigurarCamposCancelamento
1085:     *==========================================================================
1086:     * Campos do painel de cancelamento de item (cnt_4c_CancelaItem, ja criado
1087:     * em ConfigurarAreaCancelamento, flutuante e Visible=.F. por padrao) -
1088:     * mapeamento.json: filhos de CancelaItem.
1089:     *
1090:     * FASE 5/8 - primeira metade dos campos principais do form.
1091:     *==========================================================================
1092:         LOCAL loc_cIcones
1093:         loc_cIcones = gc_4c_CaminhoIcones
1094: 
1095:         THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label1", "Label")
1096:         WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label1
1097:             .Top         = 0
1098:             .Left        = 1
1099:             .Width       = 462
1100:             .Height      = 19
1101:             .FontBold    = .T.
1102:             .FontName    = "Tahoma"
1103:             .FontSize    = 10
1104:             .FontUnderline = .F.
1105:             .Alignment   = 2
1106:             .BackStyle   = 1
1107:             .ForeColor   = RGB(255, 255, 255)
1108:             .BackColor   = RGB(90, 90, 90)
1109:             .Caption     = "Cancelamento de Item"
1110:             .Visible     = .T.
1111:         ENDWITH
1112: 
1113:         THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label2", "Label")
1114:         WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label2
1115:             .Top       = 33
1116:             .Left      = 32
1117:             .Width     = 31
1118:             .Height    = 15
1119:             .AutoSize  = .T.
1120:             .FontBold  = .F.
1121:             .FontName  = "Tahoma"
1122:             .FontSize  = 8
1123:             .BackStyle = 0
1124:             .ForeColor = RGB(90, 90, 90)
1125:             .Caption   = "Item :"
1126:             .Visible   = .T.
1127:         ENDWITH
1128: 
1129:         THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Item", "TextBox")
1130:         WITH THIS.cnt_4c_CancelaItem.txt_4c_Item
1131:             .Top           = 31
1132:             .Left          = 66
1133:             .Width         = 31
1134:             .Height        = 23
1135:             .FontBold      = .T.
1136:             .FontName      = "Tahoma"
1137:             .FontSize      = 8
1138:             .SpecialEffect = 1
1139:             .InputMask     = "999"
1140:             .MaxLength     = 3
1141:             .Value         = 0
1142:             .ForeColor     = RGB(90, 90, 90)
1143:             .BackColor     = RGB(255, 255, 255)
1144:             .Visible       = .T.
1145:         ENDWITH
1146: 
1147:         THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label3", "Label")
1148:         WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label3
1149:             .Top       = 58
1150:             .Left      = 16
1151:             .Width     = 47
1152:             .Height    = 15
1153:             .AutoSize  = .T.
1154:             .FontBold  = .F.
1155:             .FontName  = "Tahoma"
1156:             .FontSize  = 8
1157:             .BackStyle = 0
1158:             .ForeColor = RGB(90, 90, 90)
1159:             .Caption   = "Produto :"
1160:             .Visible   = .T.
1161:         ENDWITH
1162: 
1163:         THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Produto", "TextBox")
1164:         WITH THIS.cnt_4c_CancelaItem.txt_4c_Produto
1165:             .Top           = 56
1166:             .Left          = 66
1167:             .Width         = 105
1168:             .Height        = 23
1169:             .FontBold      = .T.
1170:             .FontName      = "Tahoma"
1171:             .FontSize      = 8
1172:             .SpecialEffect = 1
1173:             .Format        = "K!"
1174:             .InputMask     = "!!!!!!!!!!!!!!"
1175:             .Value         = ""
1176:             .ForeColor     = RGB(90, 90, 90)
1177:             .BackColor     = RGB(255, 255, 255)
1178:             .Visible       = .T.
1179:         ENDWITH
1180: 
1181:         THIS.cnt_4c_CancelaItem.AddObject("txt_4c__dpro", "TextBox")
1182:         WITH THIS.cnt_4c_CancelaItem.txt_4c__dpro
1183:             .Top           = 56
1184:             .Left          = 172
1185:             .Width         = 281
1186:             .Height        = 23
1187:             .FontBold      = .T.
1188:             .FontName      = "Tahoma"
1189:             .FontSize      = 8
1190:             .SpecialEffect = 1
1191:             .Value         = ""
1192:             .ForeColor     = RGB(90, 90, 90)
1193:             .BackColor     = RGB(255, 255, 255)
1194:             .ReadOnly      = .T.
1195:             .Visible       = .T.
1196:         ENDWITH
1197: 
1198:         THIS.cnt_4c_CancelaItem.AddObject("lbl_4c_Label4", "Label")
1199:         WITH THIS.cnt_4c_CancelaItem.lbl_4c_Label4
1200:             .Top       = 84
1201:             .Left      = 28
1202:             .Width     = 35
1203:             .Height    = 15
1204:             .AutoSize  = .T.
1205:             .FontBold  = .F.
1206:             .FontName  = "Tahoma"
1207:             .FontSize  = 8
1208:             .BackStyle = 0
1209:             .ForeColor = RGB(90, 90, 90)
1210:             .Caption   = "Barra :"
1211:             .Visible   = .T.
1212:         ENDWITH
1213: 
1214:         THIS.cnt_4c_CancelaItem.AddObject("txt_4c_Cbarra", "TextBox")
1215:         WITH THIS.cnt_4c_CancelaItem.txt_4c_Cbarra
1216:             .Top           = 81
1217:             .Left          = 66
1218:             .Width         = 79
1219:             .Height        = 23
1220:             .FontBold      = .T.
1221:             .FontName      = "Tahoma"
1222:             .FontSize      = 8
1223:             .SpecialEffect = 1
1224:             .InputMask     = "99999999"
1225:             .MaxLength     = 8
1226:             .Value         = ""
1227:             .ForeColor     = RGB(90, 90, 90)
1228:             .BackColor     = RGB(255, 255, 255)
1229:             .Visible       = .T.
1230:         ENDWITH
1231: 
1232:         *-- ok: confirma o cancelamento do item exibido no painel.
1233:         THIS.cnt_4c_CancelaItem.AddObject("cmd_4c_Ok", "CommandButton")
1234:         WITH THIS.cnt_4c_CancelaItem.cmd_4c_Ok
1235:             .Top               = 89
1236:             .Left              = 360
1237:             .Width             = 45
1238:             .Height            = 45
1239:             .FontBold          = .T.
1240:             .FontItalic        = .T.
1241:             .Picture           = loc_cIcones + "Mouse4.ico"
1242:             .Cancel            = .F.
1243:             .Caption           = ""
1244:             .ToolTipText       = "Confirmar"
1245:             .ForeColor         = RGB(0, 128, 0)
1246:             .BackColor         = RGB(255, 255, 255)
1247:             .DisabledBackColor = RGB(255, 255, 255)
1248:             .Themes            = .F.
1249:             .Visible           = .T.
1250:         ENDWITH
1251: 
1252:         *-- CancelaDisp: fecha o painel sem cancelar o item.
1253:         THIS.cnt_4c_CancelaItem.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1254:         WITH THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp
1255:             .Top               = 89
1256:             .Left              = 406
1257:             .Width             = 45
1258:             .Height            = 45
1259:             .FontSize          = 8
1260:             .Picture           = loc_cIcones + "shut down.ico"
1261:             .Cancel            = .T.
1262:             .Caption           = ""
1263:             .ToolTipText       = "Cancelar"
1264:             .BackColor         = RGB(255, 255, 255)
1265:             .DisabledBackColor = RGB(255, 255, 255)
1266:             .Themes            = .F.
1267:             .Visible           = .T.
1268:         ENDWITH
1269:     ENDPROC
1270: 
1271:     *==========================================================================
1272:     PROTECTED PROCEDURE ConfigurarAreaPagamento
1273:     *==========================================================================
1274:     * cnt_4c__Fpagto - area de formas de pagamento - mapeamento.json:
1275:     * Cnt_Fpagto
1276:     *==========================================================================
1277:         THIS.AddObject("cnt_4c__Fpagto", "Container")
1278:         WITH THIS.cnt_4c__Fpagto
1279:             .Top           = 175
1280:             .Left          = -8
1281:             .Width         = 424
1282:             .Height        = 503
1283:             .BackStyle     = 1
1284:             .BorderWidth   = 0
1285:             .SpecialEffect = 2
1286:             .BackColor     = RGB(255, 255, 255)
1287:             .BorderColor   = RGB(190, 214, 240)
1288:             .Visible       = .T.
1289:         ENDWITH
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     PROTECTED PROCEDURE ConfigurarCamposPagamento
1294:     *==========================================================================
1295:     * Campos de cnt_4c__Fpagto (container ja criado em ConfigurarAreaPagamento):
1296:     * Desconto/Acrescimo da venda, Observacao, os 5 totalizadores (Total,
1297:     * Pagamentos, A Pagar, Saldo Final, Desconto Promocional), o bloco
1298:     * cnt_forma (forma de pagamento/parcelas/vencimento - com lookup) e os
1299:     * dois paineis flutuantes ocultos Cnt_ChequepreTef/cntnsu -
1300:     * mapeamento.json: filhos de Cnt_Fpagto.
1301:     *
1302:     * FASE 6/8 - segunda metade dos campos principais do form + lookups.
1303:     *==========================================================================
1304:         LOCAL loc_cIcones, loc_oCnt
1305:         loc_cIcones = gc_4c_CaminhoIcones
1306: 
1307:         *-- Desconto / Acrescimo: mesmo Left/Top (Top=202 Left=13) - so um
1308:         *-- fica visivel por vez, alternancia fica para a Fase 7/8.
1309:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c_Desconto", "Container")
1310:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto
1311:             .Top           = 202
1312:             .Left          = 13
1313:             .Width         = 200
1314:             .Height        = 48
1315:             .BackStyle     = 0
1316:             .BorderWidth   = 1
1317:             .SpecialEffect = 2
1318:             .BackColor     = RGB(126, 211, 226)
1319:             .Visible       = .T.
1320:         ENDWITH
1321: 
1322:         THIS.cnt_4c__Fpagto.cnt_4c_Desconto.AddObject("lbl_4c_Label2", "Label")
1323:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto.lbl_4c_Label2
1324:             .Top       = 5
1325:             .Left      = 11
1326:             .FontBold  = .T.
1327:             .FontName  = "Tahoma"
1328:             .FontSize  = 8
1329:             .BackStyle = 0
1330:             .ForeColor = RGB(90, 90, 90)
1331:             .Caption   = "Desconto"
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         THIS.cnt_4c__Fpagto.cnt_4c_Desconto.AddObject("txt_4c_TotVariacao", "TextBox")
1336:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao
1337:             .Top           = 18
1338:             .Left          = 11
1339:             .Width         = 180
1340:             .Height        = 25
1341:             .FontBold      = .T.
1342:             .FontName      = "Tahoma"
1343:             .FontSize      = 13
1344:             .Alignment     = 3
1345:             .SpecialEffect = 1
1346:             .InputMask     = "999,999,999.99"
1347:             .Value         = 0
1348:             .BackColor     = RGB(255, 255, 255)
1349:             .Visible       = .T.
1350:         ENDWITH
1351: 
1352:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c_Acrescimo", "Container")
1353:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo
1354:             .Top           = 202
1355:             .Left          = 13
1356:             .Width         = 200
1357:             .Height        = 48
1358:             .BackStyle     = 0
1359:             .BorderWidth   = 1
1360:             .SpecialEffect = 2
1361:             .BackColor     = RGB(126, 211, 226)
1362:             .Visible       = .F.
1363:         ENDWITH
1364: 
1365:         THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.AddObject("lbl_4c_Label2", "Label")
1366:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.lbl_4c_Label2
1367:             .Top       = 5
1368:             .Left      = 11
1369:             .FontBold  = .T.
1370:             .FontName  = "Tahoma"
1371:             .FontSize  = 8
1372:             .BackStyle = 0
1373:             .ForeColor = RGB(90, 90, 90)
1374:             .Caption   = "Acr" + CHR(233) + "scimo"
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.AddObject("txt_4c_TotVariacao", "TextBox")
1379:         WITH THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao
1380:             .Top           = 18
1381:             .Left          = 11
1382:             .Width         = 180
1383:             .Height        = 25
1384:             .FontBold      = .T.
1385:             .FontName      = "Tahoma"
1386:             .FontSize      = 13
1387:             .Alignment     = 3
1388:             .SpecialEffect = 1
1389:             .InputMask     = "999,999,999.99"
1390:             .Value         = 0
1391:             .BackColor     = RGB(255, 255, 255)
1392:             .Visible       = .T.
1393:         ENDWITH
1394: 
1395:         *-- Observacao (label estatico visivel) + o bloco oculto Get_OBS/
1396:         *-- GetObs/SayObs (transcritos EXATAMENTE como o dump, mesmo os tres
1397:         *-- juntos representando a mesma ideia - o legado tem os tres).
1398:         THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Label9", "Label")
1399:         WITH THIS.cnt_4c__Fpagto.lbl_4c_Label9
1400:             .Top       = 352
1401:             .Left      = 13
1402:             .FontName  = "Tahoma"
1403:             .FontSize  = 8
1404:             .BackStyle = 0
1405:             .ForeColor = RGB(90, 90, 90)
1406:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1407:             .Visible   = .T.
1408:         ENDWITH
1409: 
1410:         THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Obs", "Label")
1411:         WITH THIS.cnt_4c__Fpagto.lbl_4c_Obs
1412:             .Top       = 301
1413:             .Left      = 13
1414:             .Width     = 60
1415:             .Height    = 15
1416:             .FontName  = "Tahoma"
1417:             .FontSize  = 8
1418:             .Alignment = 1
1419:             .BackStyle = 0
1420:             .ForeColor = RGB(90, 90, 90)
1421:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1422:             .Visible   = .F.
1423:         ENDWITH
1424: 
1425:         THIS.cnt_4c__Fpagto.AddObject("obj_4c_GetObs", "EditBox")
1426:         WITH THIS.cnt_4c__Fpagto.obj_4c_GetObs
1427:             .Top           = 315
1428:             .Left          = 13
1429:             .Width         = 291
1430:             .Height        = 38
1431:             .SpecialEffect = 1
1432:             .Value         = ""
1433:             .Visible       = .F.
1434:         ENDWITH
1435: 
1436:         THIS.cnt_4c__Fpagto.AddObject("txt_4c_OBS", "TextBox")
1437:         WITH THIS.cnt_4c__Fpagto.txt_4c_OBS
1438:             .Top           = 365
1439:             .Left          = 13
1440:             .Width         = 150
1441:             .Height        = 23
1442:             .SpecialEffect = 1
1443:             .Value         = ""
1444:             .Visible       = .F.
1445:         ENDWITH
1446: 
1447:         *-- Proximo (Cnt_Fpagto.Proximo) - avanca para a proxima tela.
1448:         THIS.cnt_4c__Fpagto.AddObject("cmd_4c_Proximo", "CommandButton")
1449:         WITH THIS.cnt_4c__Fpagto.cmd_4c_Proximo
1450:             .Top         = 315
1451:             .Left        = 307
1452:             .Width       = 107
1453:             .Height      = 38
1454:             .FontName    = "Verdana"
1455:             .FontSize    = 8
1456:             .Picture     = loc_cIcones + "b_arrow1.bmp"
1457:             .Caption     = ""
1458:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
1459:             .SpecialEffect = 0
1460:             .ForeColor   = RGB(36, 84, 155)
1461:             .BackColor   = RGB(255, 255, 255)
1462:             .Themes      = .F.
1463:             .Visible     = .T.
1464:         ENDWITH
1465: 
1466:         *-- Cnt_tot: total original da venda (Get_valinic).
1467:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__tot", "Container")
1468:         WITH THIS.cnt_4c__Fpagto.cnt_4c__tot
1469:             .Top           = 152
1470:             .Left          = 13
1471:             .Width         = 200
1472:             .Height        = 48
1473:             .BackStyle     = 0
1474:             .BorderWidth   = 1
1475:             .SpecialEffect = 2
1476:             .BackColor     = RGB(126, 211, 226)
1477:             .Visible       = .T.
1478:         ENDWITH
1479: 
1480:         THIS.cnt_4c__Fpagto.cnt_4c__tot.AddObject("lbl_4c_Label2", "Label")
1481:         WITH THIS.cnt_4c__Fpagto.cnt_4c__tot.lbl_4c_Label2
1482:             .Top       = 5
1483:             .Left      = 12
1484:             .FontBold  = .T.
1485:             .FontName  = "Tahoma"
1486:             .FontSize  = 8
1487:             .BackStyle = 0
1488:             .ForeColor = RGB(90, 90, 90)
1489:             .Caption   = "Total"
1490:             .Visible   = .T.
1491:         ENDWITH
1492: 
1493:         THIS.cnt_4c__Fpagto.cnt_4c__tot.AddObject("txt_4c_Valinic", "TextBox")
1494:         WITH THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic
1495:             .Top           = 18
1496:             .Left          = 10
1497:             .Width         = 180
1498:             .Height        = 25
1499:             .FontBold      = .T.
1500:             .FontSize      = 13
1501:             .Alignment     = 3
1502:             .SpecialEffect = 1
1503:             .InputMask     = "999,999,999.99"
1504:             .Value         = 0
1505:             .BackColor     = RGB(255, 255, 255)
1506:             .Visible       = .T.
1507:         ENDWITH
1508: 
1509:         *-- cnt_pag: total ja pago com formas de pagamento (Get_TotForma).
1510:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__pag", "Container")
1511:         WITH THIS.cnt_4c__Fpagto.cnt_4c__pag
1512:             .Top           = 202
1513:             .Left          = 214
1514:             .Width         = 200
1515:             .Height        = 48
1516:             .BackStyle     = 0
1517:             .BorderWidth   = 1
1518:             .SpecialEffect = 2
1519:             .BackColor     = RGB(126, 211, 226)
1520:             .Visible       = .T.
1521:         ENDWITH
1522: 
1523:         THIS.cnt_4c__Fpagto.cnt_4c__pag.AddObject("lbl_4c_Label2", "Label")
1524:         WITH THIS.cnt_4c__Fpagto.cnt_4c__pag.lbl_4c_Label2
1525:             .Top       = 5
1526:             .Left      = 10
1527:             .FontBold  = .T.
1528:             .FontName  = "Tahoma"
1529:             .FontSize  = 8
1530:             .BackStyle = 0
1531:             .ForeColor = RGB(90, 90, 90)
1532:             .Caption   = "Pagamentos"
1533:             .Visible   = .T.
1534:         ENDWITH
1535: 
1536:         THIS.cnt_4c__Fpagto.cnt_4c__pag.AddObject("txt_4c_TotForma", "TextBox")
1537:         WITH THIS.cnt_4c__Fpagto.cnt_4c__pag.txt_4c_TotForma
1538:             .Top           = 18
1539:             .Left          = 10
1540:             .Width         = 180
1541:             .Height        = 25
1542:             .FontBold      = .T.
1543:             .FontSize      = 13
1544:             .Alignment     = 3
1545:             .SpecialEffect = 1
1546:             .Format        = "K"
1547:             .InputMask     = "999,999,999.99"
1548:             .Value         = 0
1549:             .BackColor     = RGB(255, 255, 255)
1550:             .Visible       = .T.
1551:         ENDWITH
1552: 
1553:         *-- cnt_apag: saldo que ainda falta pagar (Get_Saldo).
1554:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__apag", "Container")
1555:         WITH THIS.cnt_4c__Fpagto.cnt_4c__apag
1556:             .Top           = 252
1557:             .Left          = 214
1558:             .Width         = 200
1559:             .Height        = 48
1560:             .BackStyle     = 0
1561:             .BorderWidth   = 1
1562:             .SpecialEffect = 2
1563:             .BackColor     = RGB(126, 211, 226)
1564:             .Visible       = .T.
1565:         ENDWITH
1566: 
1567:         THIS.cnt_4c__Fpagto.cnt_4c__apag.AddObject("lbl_4c_Label2", "Label")
1568:         WITH THIS.cnt_4c__Fpagto.cnt_4c__apag.lbl_4c_Label2
1569:             .Top       = 5
1570:             .Left      = 10
1571:             .FontBold  = .T.
1572:             .FontName  = "Tahoma"
1573:             .FontSize  = 8
1574:             .BackStyle = 0
1575:             .ForeColor = RGB(90, 90, 90)
1576:             .Caption   = "A Pagar"
1577:             .Visible   = .T.
1578:         ENDWITH
1579: 
1580:         THIS.cnt_4c__Fpagto.cnt_4c__apag.AddObject("txt_4c_Saldo", "TextBox")
1581:         WITH THIS.cnt_4c__Fpagto.cnt_4c__apag.txt_4c_Saldo
1582:             .Top           = 18
1583:             .Left          = 10
1584:             .Width         = 180
1585:             .Height        = 25
1586:             .FontBold      = .T.
1587:             .FontSize      = 13
1588:             .Alignment     = 3
1589:             .SpecialEffect = 1
1590:             .Format        = "K"
1591:             .InputMask     = "999,999,999.99"
1592:             .Value         = 0
1593:             .BackColor     = RGB(255, 255, 255)
1594:             .Visible       = .T.
1595:         ENDWITH
1596: 
1597:         *-- cnt_saldo: saldo final apos desconto/acrescimo (Get_TotLiquido).
1598:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__saldo", "Container")
1599:         WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo
1600:             .Top           = 252
1601:             .Left          = 13
1602:             .Width         = 200
1603:             .Height        = 48
1604:             .BackStyle     = 0
1605:             .BorderWidth   = 1
1606:             .SpecialEffect = 2
1607:             .BackColor     = RGB(126, 211, 226)
1608:             .Visible       = .T.
1609:         ENDWITH
1610: 
1611:         THIS.cnt_4c__Fpagto.cnt_4c__saldo.AddObject("lbl_4c_Label2", "Label")
1612:         WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo.lbl_4c_Label2
1613:             .Top       = 5
1614:             .Left      = 13
1615:             .FontBold  = .T.
1616:             .FontName  = "Tahoma"
1617:             .FontSize  = 8
1618:             .BackStyle = 0
1619:             .ForeColor = RGB(90, 90, 90)
1620:             .Caption   = "Saldo Final"
1621:             .Visible   = .T.
1622:         ENDWITH
1623: 
1624:         THIS.cnt_4c__Fpagto.cnt_4c__saldo.AddObject("txt_4c_TotLiquido", "TextBox")
1625:         WITH THIS.cnt_4c__Fpagto.cnt_4c__saldo.txt_4c_TotLiquido
1626:             .Top           = 18
1627:             .Left          = 11
1628:             .Width         = 180
1629:             .Height        = 25
1630:             .FontBold      = .T.
1631:             .FontName      = "Tahoma"
1632:             .FontSize      = 13
1633:             .Alignment     = 3
1634:             .SpecialEffect = 1
1635:             .InputMask     = "999,999,999.99"
1636:             .Value         = 0
1637:             .BackColor     = RGB(255, 255, 255)
1638:             .Visible       = .T.
1639:         ENDWITH
1640: 
1641:         *-- cnt_descp: desconto promocional/campanha (Get_tvariacao).
1642:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__descp", "Container")
1643:         WITH THIS.cnt_4c__Fpagto.cnt_4c__descp
1644:             .Top           = 152
1645:             .Left          = 214
1646:             .Width         = 200
1647:             .Height        = 48
1648:             .BackStyle     = 0
1649:             .BorderWidth   = 1
1650:             .SpecialEffect = 2
1651:             .BackColor     = RGB(126, 211, 226)
1652:             .Visible       = .T.
1653:         ENDWITH
1654: 
1655:         THIS.cnt_4c__Fpagto.cnt_4c__descp.AddObject("lbl_4c_Label2", "Label")
1656:         WITH THIS.cnt_4c__Fpagto.cnt_4c__descp.lbl_4c_Label2
1657:             .Top       = 2
1658:             .Left      = 10
1659:             .FontBold  = .T.
1660:             .FontName  = "Tahoma"
1661:             .FontSize  = 8
1662:             .BackStyle = 0
1663:             .ForeColor = RGB(90, 90, 90)
1664:             .Caption   = "Desconto Promocional"
1665:             .Visible   = .T.
1666:         ENDWITH
1667: 
1668:         THIS.cnt_4c__Fpagto.cnt_4c__descp.AddObject("txt_4c_Tvariacao", "TextBox")
1669:         WITH THIS.cnt_4c__Fpagto.cnt_4c__descp.txt_4c_Tvariacao
1670:             .Top           = 18
1671:             .Left          = 10
1672:             .Width         = 180
1673:             .Height        = 25
1674:             .FontBold      = .T.
1675:             .FontName      = "Tahoma"
1676:             .FontSize      = 13
1677:             .Alignment     = 3
1678:             .SpecialEffect = 1
1679:             .InputMask     = "999,999,999.99"
1680:             .Value         = 0
1681:             .BackColor     = RGB(255, 255, 255)
1682:             .Visible       = .T.
1683:         ENDWITH
1684: 
1685:         *-- Titulo do container (barra escura "Finaliza a Venda").
1686:         THIS.cnt_4c__Fpagto.AddObject("lbl_4c_Label1", "Label")
1687:         WITH THIS.cnt_4c__Fpagto.lbl_4c_Label1
1688:             .Top       = -1
1689:             .Left      = 13
1690:             .Width     = 401
1691:             .Height    = 22
1692:             .FontBold  = .T.
1693:             .FontName  = "Tahoma"
1694:             .FontSize  = 10
1695:             .Alignment = 2
1696:             .BackStyle = 1
1697:             .ForeColor = RGB(255, 255, 255)
1698:             .BackColor = RGB(90, 90, 90)
1699:             .Caption   = "Finaliza a Venda"
1700:             .Visible   = .T.
1701:         ENDWITH
1702: 
1703:         *-- cnt_forma: forma de pagamento / parcelas / valor / vencimento.
1704:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__forma", "Container")
1705:         WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
1706:             .Top           = 22
1707:             .Left          = 13
1708:             .Width         = 401
1709:             .Height        = 128
1710:             .BackStyle     = 0
1711:             .BorderWidth   = 1
1712:             .SpecialEffect = 2
1713:             .BackColor     = RGB(126, 211, 226)
1714:             .Visible       = .T.
1715:         ENDWITH
1716: 
1717:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__forma
1718: 
1719:         loc_oCnt.AddObject("txt_4c_Fpg", "TextBox")
1720:         WITH loc_oCnt.txt_4c_Fpg
1721:             .Top           = 4
1722:             .Left          = 93
1723:             .Width         = 185
1724:             .Height        = 29
1725:             .FontBold      = .T.
1726:             .FontSize      = 13
1727:             .SpecialEffect = 1
1728:             .MaxLength     = 12
1729:             .Value         = ""
1730:             .ToolTipText   = "Condi" + CHR(231) + CHR(227) + "o de pagamento"
1731:             .Visible       = .T.
1732:         ENDWITH

*-- Linhas 1826 a 1907:
1826: 
1827:         *-- LOOKUP: forma de pagamento (SigOpFp) - F4/Enter/Tab abrem o
1828:         *-- picker; ver AbrirLookupFormaPagamento().
1829:         BINDEVENT(loc_oCnt.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")
1830: 
1831:         *-- Cnt_ChequepreTef: painel de dados do cheque pre-datado/TEF,
1832:         *-- flutuante e oculto por padrao.
1833:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__ChequepreTef", "Container")
1834:         WITH THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
1835:             .Top           = 389
1836:             .Left          = 13
1837:             .Width         = 407
1838:             .Height        = 62
1839:             .BackStyle     = 1
1840:             .BorderWidth   = 1
1841:             .SpecialEffect = 2
1842:             .BackColor     = RGB(255, 255, 255)
1843:             .Visible       = .F.
1844:         ENDWITH
1845: 
1846:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
1847: 
1848:         loc_oCnt.AddObject("cmd_4c_TefChq", "CommandButton")
1849:         WITH loc_oCnt.cmd_4c_TefChq
1850:             .Top         = 4
1851:             .Left        = 268
1852:             .Width       = 108
1853:             .Height      = 20
1854:             .FontBold    = .T.
1855:             .FontItalic  = .T.
1856:             .FontName    = "Comic Sans MS"
1857:             .FontSize    = 8
1858:             .WordWrap    = .T.
1859:             .Caption     = "Consulta C\<heque"
1860:             .ToolTipText = "Confirmar o Cheque"
1861:             .ForeColor   = RGB(90, 90, 90)
1862:             .BackColor   = RGB(255, 255, 255)
1863:             .Themes      = .F.
1864:             .Visible     = .T.
1865:         ENDWITH
1866: 
1867:         loc_oCnt.AddObject("obj_4c_Opc_cpf", "OptionGroup")
1868:         WITH loc_oCnt.obj_4c_Opc_cpf
1869:             .Top         = 5
1870:             .Left        = 3
1871:             .Width       = 118
1872:             .Height      = 17
1873:             .ButtonCount = 2
1874:             .BackStyle   = 0
1875:             .BorderStyle = 0
1876:             .Value       = 1
1877: 
1878:             WITH .Buttons(1)
1879:                 .BackStyle = 0
1880:                 .Caption   = "C.P.F."
1881:                 .Height    = 17
1882:                 .Left      = 5
1883:                 .Top       = 1
1884:                 .Width     = 49
1885:             ENDWITH
1886: 
1887:             WITH .Buttons(2)
1888:                 .FontSize  = 8
1889:                 .BackStyle = 0
1890:                 .Caption   = "C.N.P.J."
1891:                 .Left      = 54
1892:                 .Top       = 1
1893:             ENDWITH
1894: 
1895:             .Visible = .T.
1896:         ENDWITH
1897: 
1898:         loc_oCnt.AddObject("txt_4c_Cpf", "TextBox")
1899:         WITH loc_oCnt.txt_4c_Cpf
1900:             .Top           = 4
1901:             .Left          = 125
1902:             .Width         = 140
1903:             .Height        = 20
1904:             .SpecialEffect = 1
1905:             .MaxLength     = 20
1906:             .Value         = ""
1907:             .Visible       = .T.

*-- Linhas 2049 a 2080:
2049:             .Visible       = .T.
2050:         ENDWITH
2051: 
2052:         *-- cntnsu: NSU/Autorizacao/Adquirente do cartao (TEF), flutuante e
2053:         *-- oculto por padrao.
2054:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c_nsu", "Container")
2055:         WITH THIS.cnt_4c__Fpagto.cnt_4c_nsu
2056:             .Top           = 315
2057:             .Left          = 13
2058:             .Width         = 291
2059:             .Height        = 38
2060:             .SpecialEffect = 2
2061:             .BackColor     = RGB(255, 255, 255)
2062:             .Visible       = .F.
2063:         ENDWITH
2064: 
2065:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c_nsu
2066: 
2067:         loc_oCnt.AddObject("txt_4c_Nsu", "TextBox")
2068:         WITH loc_oCnt.txt_4c_Nsu
2069:             .Top           = 16
2070:             .Left          = 5
2071:             .Width         = 90
2072:             .Height        = 20
2073:             .FontName      = "Tahoma"
2074:             .SpecialEffect = 1
2075:             .InputMask     = "999999999999"
2076:             .Value         = ""
2077:             .ForeColor     = RGB(90, 90, 90)
2078:             .Visible       = .T.
2079:         ENDWITH
2080: 

*-- Linhas 2140 a 2410:
2140: 
2141:         *-- LOOKUP: adquirente do cartao (SigCdCad, tipocads='ADQUIRENTE') -
2142:         *-- ver AbrirLookupAdquirente().
2143:         BINDEVENT(loc_oCnt.txt_4c__adquire, "KeyPress", THIS, "AdquireKeyPress")
2144:     ENDPROC
2145: 
2146:     *==========================================================================
2147:     PROTECTED PROCEDURE ConfigurarAreaIdentificacao
2148:     *==========================================================================
2149:     * cnt_4c__Identifica - identificacao do cliente (Origem/Destino/Vendedor/
2150:     * Responsavel) - mapeamento.json: Cnt_Identifica
2151:     *==========================================================================
2152:         THIS.AddObject("cnt_4c__Identifica", "Container")
2153:         WITH THIS.cnt_4c__Identifica
2154:             .Top           = 171
2155:             .Left          = 5
2156:             .Width         = 406
2157:             .Height        = 475
2158:             .BackStyle     = 1
2159:             .BorderWidth   = 1
2160:             .SpecialEffect = 0
2161:             .BackColor     = RGB(255, 255, 255)
2162:             .BorderColor   = RGB(190, 214, 240)
2163:             .Visible       = .T.
2164:         ENDWITH
2165:     ENDPROC
2166: 
2167:     *==========================================================================
2168:     PROTECTED PROCEDURE ConfigurarCamposIdentificacao
2169:     *==========================================================================
2170:     * Campos de cnt_4c__Identifica (container ja criado em
2171:     * ConfigurarAreaIdentificacao): os quatro blocos de identificacao de
2172:     * conta (Destino/Responsavel/Vendedor/Origem - grupo+conta+nome+cpf,
2173:     * cada um com lookup proprio), Tab. Desconto/Lista de Precos (com
2174:     * lookup), numero do Documento/Pedido Cliente e o titulo do container -
2175:     * mapeamento.json: filhos de Cnt_Identifica.
2176:     *
2177:     * FASE 6/8 - segunda metade dos campos principais do form + lookups.
2178:     *==========================================================================
2179:         LOCAL loc_cIcones
2180:         loc_cIcones = gc_4c_CaminhoIcones
2181: 
2182:         *-- Destino: grupo/conta/nome/cpf do destinatario da operacao.
2183:         THIS.MontarBlocoIdentificacao("Destino", 179, "TprMvCab.grupods", "TprMvCab.contads", .T., "Destino")
2184: 
2185:         *-- Responsavel: grupo/conta/nome/cpf do responsavel financeiro.
2186:         THIS.MontarBlocoIdentificacao("Responsavel", 365, "TprMvCab.GrResps", "TprMvCab.Resps", .F., "Respons" + CHR(225) + "vel")
2187: 
2188:         *-- Vendedor: grupo/conta/nome/cpf do vendedor.
2189:         THIS.MontarBlocoIdentificacao("Vendedor", 272, "TprMvCab.grvends", "TprMvCab.vends", .F., "Vendedor")
2190: 
2191:         *-- Origem: grupo/conta/nome/cpf da origem da operacao.
2192:         THIS.MontarBlocoIdentificacao("Origem", 86, "TprMvCab.grupoos", "TprMvCab.contaos", .T., "Origem")
2193: 
2194:         *-- TabDesconto: tabela de desconto + lista de precos.
2195:         THIS.cnt_4c__Identifica.AddObject("cnt_4c_TabDesconto", "Container")
2196:         WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto
2197:             .Top           = 48
2198:             .Left          = 0
2199:             .Width         = 404
2200:             .Height        = 41
2201:             .BackStyle     = 0
2202:             .BorderWidth   = 0
2203:             .SpecialEffect = 2
2204:             .BackColor     = RGB(255, 255, 255)
2205:             .BorderColor   = RGB(36, 84, 155)
2206:             .Visible       = .T.
2207:         ENDWITH
2208: 
2209:         THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("lbl_4c_Label1", "Label")
2210:         WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.lbl_4c_Label1
2211:             .Top       = 4
2212:             .Left      = 10
2213:             .FontName  = "Tahoma"
2214:             .FontSize  = 8
2215:             .ForeColor = RGB(90, 90, 90)
2216:             .Caption   = "Tab. Desconto"
2217:             .Visible   = .T.
2218:         ENDWITH
2219: 
2220:         THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("txt_4c_Tabd", "TextBox")
2221:         WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd
2222:             .Top           = 18
2223:             .Left          = 10
2224:             .Width         = 80
2225:             .Height        = 20
2226:             .FontName      = "Tahoma"
2227:             .SpecialEffect = 1
2228:             .Value         = ""
2229:             .ForeColor     = RGB(90, 90, 90)
2230:             .Visible       = .T.
2231:         ENDWITH
2232: 
2233:         THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("txt_4c_ListaPreco", "TextBox")
2234:         WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco
2235:             .Top           = 18
2236:             .Left          = 123
2237:             .Width         = 220
2238:             .Height        = 20
2239:             .FontName      = "Tahoma"
2240:             .SpecialEffect = 1
2241:             .Format        = "K"
2242:             .MaxLength     = 30
2243:             .Value         = ""
2244:             .ForeColor     = RGB(90, 90, 90)
2245:             .Visible       = .T.
2246:         ENDWITH
2247: 
2248:         THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.AddObject("lbl_4c__ListaPreco", "Label")
2249:         WITH THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.lbl_4c__ListaPreco
2250:             .Top       = 4
2251:             .Left      = 124
2252:             .FontName  = "Tahoma"
2253:             .FontSize  = 8
2254:             .ForeColor = RGB(90, 90, 90)
2255:             .Caption   = "Lista de Pre" + CHR(231) + "os"
2256:             .Visible   = .T.
2257:         ENDWITH
2258: 
2259:         *-- LOOKUP: tabela de desconto (SigOpTdz) e lista de precos
2260:         *-- (SigCdLpc) - ver AbrirLookupTabDesconto()/AbrirLookupListaPreco().
2261:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_Tabd, "KeyPress", THIS, "TabdKeyPress")
2262:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_TabDesconto.txt_4c_ListaPreco, "KeyPress", THIS, "ListaPrecoKeyPress")
2263: 
2264:         *-- Proximo (Cnt_Identifica.Proximo) - oculto no legado.
2265:         THIS.cnt_4c__Identifica.AddObject("cmd_4c_Proximo", "CommandButton")
2266:         WITH THIS.cnt_4c__Identifica.cmd_4c_Proximo
2267:             .Top         = 413
2268:             .Left        = 319
2269:             .Width       = 80
2270:             .Height      = 38
2271:             .FontName    = "Verdana"
2272:             .FontSize    = 8
2273:             .Picture     = loc_cIcones + "b_arrow2.bmp"
2274:             .Caption     = ""
2275:             .SpecialEffect = 0
2276:             .ForeColor   = RGB(36, 84, 155)
2277:             .BackColor   = RGB(255, 255, 255)
2278:             .Themes      = .F.
2279:             .Visible     = .F.
2280:         ENDWITH
2281: 
2282:         *-- CodOperacao: numero do documento / pedido do cliente.
2283:         THIS.cnt_4c__Identifica.AddObject("cnt_4c_CodOperacao", "Container")
2284:         WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao
2285:             .Top           = 23
2286:             .Left          = 0
2287:             .Width         = 404
2288:             .Height        = 31
2289:             .BackStyle     = 0
2290:             .BorderWidth   = 0
2291:             .SpecialEffect = 2
2292:             .BackColor     = RGB(255, 255, 255)
2293:             .BorderColor   = RGB(36, 84, 155)
2294:             .Visible       = .T.
2295:         ENDWITH
2296: 
2297:         THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("lbl_4c_Label1", "Label")
2298:         WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.lbl_4c_Label1
2299:             .Top       = 8
2300:             .Left      = 25
2301:             .FontName  = "Tahoma"
2302:             .FontSize  = 8
2303:             .ForeColor = RGB(90, 90, 90)
2304:             .Caption   = "Documento : "
2305:             .Visible   = .T.
2306:         ENDWITH
2307: 
2308:         THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("txt_4c_Codigo", "TextBox")
2309:         WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.txt_4c_Codigo
2310:             .Top           = 4
2311:             .Left          = 94
2312:             .Width         = 61
2313:             .Height        = 23
2314:             .FontBold      = .T.
2315:             .FontName      = "Tahoma"
2316:             .FontSize      = 10
2317:             .SpecialEffect = 1
2318:             .MaxLength     = 6
2319:             .Value         = ""
2320:             .ForeColor     = RGB(90, 90, 90)
2321:             .Visible       = .T.
2322:         ENDWITH
2323: 
2324:         THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("lbl_4c_Label2", "Label")
2325:         WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.lbl_4c_Label2
2326:             .Top       = 8
2327:             .Left      = 176
2328:             .FontName  = "Tahoma"
2329:             .FontSize  = 8
2330:             .ForeColor = RGB(90, 90, 90)
2331:             .Caption   = "Pedido Cliente: "
2332:             .Visible   = .T.
2333:         ENDWITH
2334: 
2335:         THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.AddObject("txt_4c_PedCli", "TextBox")
2336:         WITH THIS.cnt_4c__Identifica.cnt_4c_CodOperacao.txt_4c_PedCli
2337:             .Top           = 4
2338:             .Left          = 260
2339:             .Width         = 80
2340:             .Height        = 23
2341:             .FontBold      = .T.
2342:             .FontName      = "Tahoma"
2343:             .FontSize      = 10
2344:             .SpecialEffect = 1
2345:             .Value         = ""
2346:             .ForeColor     = RGB(90, 90, 90)
2347:             .Visible       = .T.
2348:         ENDWITH
2349: 
2350:         *-- Titulo do container (barra escura "Identificacao do Cliente").
2351:         THIS.cnt_4c__Identifica.AddObject("lbl_4c_Label1", "Label")
2352:         WITH THIS.cnt_4c__Identifica.lbl_4c_Label1
2353:             .Top       = 3
2354:             .Left      = 0
2355:             .Width     = 404
2356:             .Height    = 21
2357:             .FontBold  = .T.
2358:             .FontName  = "Tahoma"
2359:             .FontSize  = 10
2360:             .Alignment = 2
2361:             .BackStyle = 1
2362:             .ForeColor = RGB(255, 255, 255)
2363:             .BackColor = RGB(90, 90, 90)
2364:             .Caption   = "Identifica" + CHR(231) + CHR(227) + "o do Cliente"
2365:             .Visible   = .T.
2366:         ENDWITH
2367:     ENDPROC
2368: 
2369:     *==========================================================================
2370:     PROTECTED PROCEDURE MontarBlocoIdentificacao(par_cNome, par_nTop, par_cCtrlGrupo, par_cCtrlConta, par_lCadastro, par_cTitulo)
2371:     *==========================================================================
2372:     * Fabrica os 4 blocos IDENTICOS de identificacao de conta (Destino,
2373:     * Responsavel, Vendedor, Origem) - todos com a MESMA estrutura de campos
2374:     * (Grupo/Conta/Nome/CPF) e so variando o Top e a presenca do botao de
2375:     * atalho para o cadastro (btnCadastros - so em Destino/Origem no
2376:     * legado). Nome do container gerado: "cnt_4c_" + par_cNome
2377:     * (cnt_4c_Destino/cnt_4c_Responsavel/cnt_4c_Vendedor/cnt_4c_Origem).
2378:     *
2379:     * par_cCtrlGrupo/par_cCtrlConta NAO sao aplicados a nenhuma propriedade
2380:     * aqui - documentam apenas o ControlSource legado (TprMvCab.grupods/
2381:     * grvends/grupoos/GrResps e contads/vends/contaos/Resps) para a Fase
2382:     * 7/8, quando FormParaBO/BOParaForm ligarem estes TextBox as
2383:     * propriedades do BO (este form nao usa .ControlSource nativo em
2384:     * nenhum outro campo, e nao seria diferente aqui).
2385:     *==========================================================================
2386:         LOCAL loc_cCnt, loc_oCnt, loc_cIcones
2387:         loc_cIcones = gc_4c_CaminhoIcones
2388:         loc_cCnt = "cnt_4c_" + par_cNome
2389: 
2390:         THIS.cnt_4c__Identifica.AddObject(loc_cCnt, "Container")
2391:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica." + loc_cCnt)
2392:         WITH loc_oCnt
2393:             .Top           = par_nTop
2394:             .Left          = 0
2395:             .Width         = 404
2396:             .Height        = 94
2397:             .BackStyle     = 0
2398:             .BorderWidth   = 0
2399:             .SpecialEffect = 2
2400:             .BackColor     = RGB(255, 255, 255)
2401:             .BorderColor   = RGB(36, 84, 155)
2402:             .Visible       = .T.
2403:         ENDWITH
2404: 
2405:         loc_oCnt.AddObject("lbl_4c_Label8", "Label")
2406:         WITH loc_oCnt.lbl_4c_Label8
2407:             .Top       = 18
2408:             .Left      = 10
2409:             .FontName  = "Tahoma"
2410:             .FontSize  = 8

*-- Linhas 2545 a 2624:
2545: 
2546:         *-- LOOKUP: grupo (SigCdGrp) e conta (SigCdCli) - um handler PUBLIC
2547:         *-- dedicado por bloco (Grupo<Nome>KeyPress/Conta<Nome>KeyPress/
2548:         *-- Cpf<Nome>KeyPress), criado logo abaixo desta procedure. Nomes
2549:         *-- fixos (nao gerados via macro) para BINDEVENT sempre achar um
2550:         *-- metodo PUBLIC existente (regra BINDEVENT so aceita PUBLIC).
2551:         BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "Grupo" + par_cNome + "KeyPress")
2552:         BINDEVENT(loc_oCnt.txt_4c_Conta, "KeyPress", THIS, "Conta" + par_cNome + "KeyPress")
2553:         BINDEVENT(loc_oCnt.txt_4c_Cpf, "KeyPress", THIS, "Cpf" + par_cNome + "KeyPress")
2554:     ENDPROC
2555: 
2556:     *==========================================================================
2557:     PROTECTED PROCEDURE ConfigurarBarraBotoes
2558:     *==========================================================================
2559:     * cnt_4c_Barra_Botoes - barra com os botoes funcionais do Caixa (Itens,
2560:     * Pagto, Identifica, etc. - adicionados na Fase 4) - mapeamento.json:
2561:     * Barra_Botoes
2562:     *==========================================================================
2563:         LOCAL loc_cImg
2564:         loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
2565: 
2566:         THIS.AddObject("cnt_4c_Barra_Botoes", "Container")
2567:         WITH THIS.cnt_4c_Barra_Botoes
2568:             .Top           = 15
2569:             .Left          = 755
2570:             .Width         = 536
2571:             .Height        = 82
2572:             .BackStyle = 1
2573:             .BorderWidth   = 0
2574:             .SpecialEffect = 0
2575:             .BackColor     = RGB(126, 211, 226)
2576:             .Visible       = .T.
2577:             IF FILE(loc_cImg)
2578:                 .Picture = loc_cImg
2579:             ENDIF
2580:         ENDWITH
2581:     ENDPROC
2582: 
2583:     *==========================================================================
2584:     PROTECTED PROCEDURE ConfigurarBotoesBarraPrincipal
2585:     *==========================================================================
2586:     * Os 16 CommandButtons de cnt_4c_Barra_Botoes (container ja criado em
2587:     * ConfigurarBarraBotoes). Varios pares OCUPAM O MESMO Left/Top porque a
2588:     * barra alterna qual conjunto fica visivel conforme a tela ativa
2589:     * (Desconto/Acrescimo em Left=5,Top=45; CancPagto/apaga em Left=97,Top=6;
2590:     * Financia/pendencia em Left=189,Top=6) - a alternancia de .Visible e os
2591:     * Click ficam para as Fases 7-8. Cada botao nasce com o .Visible EXATO do
2592:     * dump (a maioria .T.; Financia e .F. - opcao desligada por padrao).
2593:     * Propriedades comuns a TODOS (do dump): Height=36 Width=92 FontBold=.T.
2594:     * FontItalic=.T. FontName="Comic Sans MS" FontSize=8 ForeColor=90,90,90
2595:     * BackColor=255,255,255 DisabledForeColor=109,109,109
2596:     * DisabledBackColor=240,240,240 Themes=.F. (Confirmar/Cancela sao os dois
2597:     * botoes grandes 75x75, com PicturePosition=13).
2598:     *==========================================================================
2599:         LOCAL loc_cIcones
2600:         loc_cIcones = gc_4c_CaminhoIcones
2601: 
2602:         *-- [F2] Itens - tela padrao de lancamento de itens.
2603:         THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Itens", "CommandButton")
2604:         WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens
2605:             .Top                = 6
2606:             .Left               = 5
2607:             .Width              = 92
2608:             .Height             = 36
2609:             .AutoSize           = .F.
2610:             .FontBold           = .T.
2611:             .FontItalic         = .T.
2612:             .FontName           = "Comic Sans MS"
2613:             .FontSize           = 8
2614:             .WordWrap           = .T.
2615:             .Picture            = loc_cIcones + "cadastro_inserir_26.jpg"
2616:             .Caption            = "Itens-F2"
2617:             .MousePointer       = 15
2618:             .ToolTipText        = "[F2] Tela de Itens"
2619:             .PicturePosition    = 1
2620:             .ForeColor          = RGB(90, 90, 90)
2621:             .BackColor          = RGB(255, 255, 255)
2622:             .DisabledForeColor  = RGB(109, 109, 109)
2623:             .DisabledBackColor  = RGB(240, 240, 240)
2624:             .Themes             = .F.

*-- Linhas 2968 a 3038:
2968:     ENDPROC
2969: 
2970:     *==========================================================================
2971:     PROTECTED PROCEDURE ConfigurarGradeCupom
2972:     *==========================================================================
2973:     * cnt_4c_Grade - grade do cupom fiscal (itens ja impressos), flutuante e
2974:     * OCULTA por padrao - mapeamento.json: CntGrade (Visible = .F. no legado)
2975:     *==========================================================================
2976:         LOCAL loc_cImg
2977:         loc_cImg = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
2978: 
2979:         THIS.AddObject("cnt_4c_Grade", "Container")
2980:         WITH THIS.cnt_4c_Grade
2981:             .Top           = 178
2982:             .Left          = 412
2983:             .Width         = 450
2984:             .Height        = 415
2985:             .BackStyle     = 0
2986:             .BorderWidth   = 0
2987:             .SpecialEffect = 2
2988:             .BackColor     = RGB(126, 211, 226)
2989:             .BorderColor   = RGB(190, 214, 235)
2990:             .Visible       = .F.
2991:             IF FILE(loc_cImg)
2992:                 .Picture = loc_cImg
2993:             ENDIF
2994:         ENDWITH
2995:     ENDPROC
2996: 
2997:     *==========================================================================
2998:     PROTECTED PROCEDURE ConfigurarGridCupomInterno
2999:     *==========================================================================
3000:     * grd_4c_Cupom (GrdCupom no legado) - grade READONLY que lista as linhas
3001:     * ja formatadas do cupom fiscal em andamento (cursor crTpmMvItnC), mais
3002:     * os dois totais (Cnt_subt/Get_Total = Subtotal, cnt_tots/Get_total =
3003:     * Total Geral) que ficam colados embaixo dela dentro do MESMO container
3004:     * cnt_4c_Grade (ja criado em ConfigurarGradeCupom). Coluna unica sem
3005:     * cabecalho visivel (HeaderHeight=0 - cada linha e uma string formatada,
3006:     * padrao de cupom fiscal), fonte Cordia New roxa (ForeColor=58,44,126).
3007:     *
3008:     * RecordSource/ControlSource de grd_4c_Cupom ficam para MontaGrade() -
3009:     * RecordSource reseta Width/Header1.Caption (CLAUDE.md #41).
3010:     *
3011:     * Original: GrdCupom Top=0 Left=3 Width=445 Height=360 ColumnCount=1
3012:     * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
3013:     * ScrollBars=0 ForeColor=58,44,126. Column1 FontName="Cordia New"
3014:     * Width=345 Movable=.F. ReadOnly=.T. Cnt_subt/cnt_tots Top=365
3015:     * Width=221 Height=49 BackStyle=0 BorderWidth=1 SpecialEffect=2
3016:     * BackColor=126,211,226; Say7 Caption="Subtotal"/"Total Geral"
3017:     * FontBold=.T. FontSize=8 ForeColor=90,90,90; Get_Total/Get_total
3018:     * FontBold=.T. FontSize=18 Alignment=2 BackStyle=0 BorderStyle=0
3019:     * InputMask="9,999,999.99" Height=35 Width=218 ForeColor=0,0,0
3020:     * BackColor=255,255,255.
3021:     *==========================================================================
3022:         THIS.cnt_4c_Grade.AddObject("grd_4c_Cupom", "Grid")
3023:         WITH THIS.cnt_4c_Grade.grd_4c_Cupom
3024:             .Top          = 0
3025:             .Left         = 3
3026:             .Width        = 445
3027:             .Height       = 360
3028:             .ColumnCount  = 1
3029:             .Enabled      = .F.
3030:             .GridLines    = 0
3031:             .HeaderHeight = 0
3032:             .ReadOnly     = .T.
3033:             .RecordMark   = .F.
3034:             .DeleteMark   = .F.
3035:             .ScrollBars   = 0
3036:             .ForeColor    = RGB(58, 44, 126)
3037:             .Visible      = .T.
3038: 

*-- Linhas 3149 a 3282:
3149:     ENDPROC
3150: 
3151:     *==========================================================================
3152:     PROTECTED PROCEDURE ConfigurarAreaMensagens
3153:     *==========================================================================
3154:     * cnt_4c__mensagems - mensagens grandes de status (ex.: instrucoes durante
3155:     * a emissao fiscal) - mapeamento.json: Cnt_mensagems
3156:     *==========================================================================
3157:         THIS.AddObject("cnt_4c__mensagems", "Container")
3158:         WITH THIS.cnt_4c__mensagems
3159:             .Top           = 100
3160:             .Left          = 100
3161:             .Width         = 1000
3162:             .Height        = 72
3163:             .BackStyle     = 0
3164:             .BorderWidth   = 0
3165:             .SpecialEffect = 2
3166:             .ForeColor     = RGB(90, 90, 90)
3167:             .BackColor     = RGB(255, 255, 255)
3168:             .BorderColor   = RGB(190, 214, 240)
3169:             .Visible       = .T.
3170:         ENDWITH
3171: 
3172:         *-- Os dois labels de cnt_4c__mensagems - mapeamento.json:
3173:         *-- Cnt_mensagems.Mensage1 / Cnt_mensagems.Mensage2. O legado escreve
3174:         *-- neles a identificacao e a quantidade x valor do item lancado
3175:         *-- (Itens.Click: "xTexto1 = Padl(Cpros,14,'0')+' '+Dpros" /
3176:         *-- "xTexto2 = Transform(Qtds,...)+' X '+Transform(Units,...)"). O
3177:         *-- Caption "teste" do dump e placeholder de tempo de projeto -
3178:         *-- nasce vazio, porque o legado o sobrescreve em runtime.
3179:         THIS.cnt_4c__mensagems.AddObject("lbl_4c_Mensage1", "Label")
3180:         WITH THIS.cnt_4c__mensagems.lbl_4c_Mensage1
3181:             .Top       = 5
3182:             .Left      = 6
3183:             .Width     = 978
3184:             .Height    = 25
3185:             .AutoSize  = .F.
3186:             .FontBold  = .T.
3187:             .FontName  = "Tahoma"
3188:             .FontSize  = 13
3189:             .Alignment = 2
3190:             .BackStyle = 0
3191:             .ForeColor = RGB(90, 90, 90)
3192:             .Caption   = ""
3193:             .Visible   = .T.
3194:         ENDWITH
3195: 
3196:         THIS.cnt_4c__mensagems.AddObject("lbl_4c_Mensage2", "Label")
3197:         WITH THIS.cnt_4c__mensagems.lbl_4c_Mensage2
3198:             .Top       = 28
3199:             .Left      = 6
3200:             .Width     = 978
3201:             .Height    = 36
3202:             .AutoSize  = .F.
3203:             .FontBold  = .T.
3204:             .FontName  = "Tahoma"
3205:             .FontSize  = 18
3206:             .Alignment = 2
3207:             .BackStyle = 0
3208:             .ForeColor = RGB(90, 90, 90)
3209:             .Caption   = ""
3210:             .Visible   = .T.
3211:         ENDWITH
3212:     ENDPROC
3213: 
3214:     *==========================================================================
3215:     PROTECTED PROCEDURE ConfigurarTimer
3216:     *==========================================================================
3217:     * obj_4c_Timer1 - atualiza periodicamente a barra de titulo com
3218:     * data/hora/documento/operador - mapeamento.json: Timer1. O Interval e o
3219:     * do legado (1000 ms); o Procedure esta em TimerAtualizarTitulo() e e
3220:     * ligado por BINDEVENT em RegistrarEventosPrincipais(), que tambem liga o
3221:     * .Enabled - aqui ele nasce desligado para o Timer nao disparar no meio da
3222:     * construcao dos controles, quando a barra de titulo ainda nao existe.
3223:     *==========================================================================
3224:         THIS.AddObject("obj_4c_Timer1", "Timer")
3225:         WITH THIS.obj_4c_Timer1
3226:             .Interval = 1000
3227:             .Enabled  = .F.
3228:         ENDWITH
3229:     ENDPROC
3230: 
3231:     *==========================================================================
3232:     PROTECTED PROCEDURE CriarCursoresGrades
3233:     *==========================================================================
3234:     * Cria, VAZIOS, os cursores locais que alimentam grd_4c_SubNiveis e
3235:     * grd_4c_Cupom. No legado eles ja existiam - a tela de movimentacao (form
3236:     * pai) os montava na datasession COMPARTILHADA, e o SIGMVITS.SCX apenas
3237:     * fazia "Set DataSession To pnDatSes" e os enxergava prontos. Como este
3238:     * form usa DataSession = 2 (isolado), eles nascem aqui.
3239:     *
3240:     * Roda ANTES de qualquer RecordSource/ControlSource (MontaGrade): ligar
3241:     * coluna a alias inexistente estoura "Alias is not found" dentro do TRY
3242:     * do InicializarForm e o form nao chega a abrir (CLAUDE.md #41).
3243:     *
3244:     * SET NULL ON antes do CREATE CURSOR porque, quando a fase de eventos
3245:     * popular estes cursores via APPEND FROM DBF()/SQLEXEC, coluna nullable
3246:     * do SQL Server recusa o append num cursor declarado NOT NULL. Estado
3247:     * anterior restaurado no fim, para nao vazar SET para o resto da
3248:     * datasession.
3249:     *
3250:     * Estruturas transcritas do uso real no dump legado (comportamento.json)
3251:     * e IDENTICAS as ja usadas no form irmao Formsigmvitn.prg (task571), que
3252:     * tem o MESMO Cnt_Pendencia.GradeMultiSubN. Nomes de campo PRESERVADOS:
3253:     * sao chave de ControlSource e aparecem literalmente nas expressoes
3254:     * Locate/Replace/Seek das fases de evento.
3255:     *==========================================================================
3256:         LOCAL loc_cNullAnt
3257:         loc_cNullAnt = SET("NULL")
3258:         SET NULL ON
3259: 
3260:         *-- TmpOperacao: sub-niveis/pendencias vinculados a esta movimentacao
3261:         *-- (grd_4c_SubNiveis - Cnt_Pendencia.GradeMultiSubN).
3262:         IF !USED("TmpOperacao")
3263:             CREATE CURSOR TmpOperacao ( ;
3264:                 Emps      C(3)     NULL, ;
3265:                 Dopes     C(20)    NULL, ;
3266:                 Numes     N(6, 0)  NULL, ;
3267:                 Codigos   N(10, 0) NULL, ;
3268:                 Notas     C(6)     NULL, ;
3269:                 Valos     N(11, 2) NULL, ;
3270:                 VlValVars N(11, 2) NULL, ;
3271:                 EmpSubns  C(29)    NULL, ;
3272:                 ChkSubn   L        NULL, ;
3273:                 Validado  L        NULL, ;
3274:                 Saida     L        NULL)
3275:             INDEX ON STR(Codigos, 10) TAG Codigos
3276:             SET ORDER TO
3277:         ENDIF
3278: 
3279:         *-- crTpmMvItn: o CARRINHO - um registro por item lancado no cupom.
3280:         *-- Espelha as colunas de SigMvItn que o legado referencia MAIS duas
3281:         *-- que so existem no cursor local (nao estao na tabela): ImpCupFis
3282:         *-- (marca item ja impresso no cupom fiscal, testada em

*-- Linhas 3386 a 3922:
3386:     ENDPROC
3387: 
3388:     *==========================================================================
3389:     PROTECTED PROCEDURE MontaGrade
3390:     *==========================================================================
3391:     * Liga grd_4c_SubNiveis e grd_4c_Cupom aos seus cursores (criados em
3392:     * CriarCursoresGrades) e REAPLICA tudo o que o VFP9 reseta quando
3393:     * RecordSource muda: Column.Width e Header1.Caption (Problema 48 /
3394:     * CLAUDE.md #41). Por isso a ordem dentro de cada WITH e sempre a mesma
3395:     * e NAO pode ser trocada: RecordSource -> ControlSource -> Width ->
3396:     * Header1.Caption.
3397:     *
3398:     * grd_4c_FormasPag NAO entra aqui: o cursor "xParC" e um SELECT dinamico
3399:     * montado dentro do Confirmar (Barra_Botoes.ok, fase de eventos) - nao
3400:     * existe ainda nesta fase (ver comentario de ConfigurarGrdFormasPagamento).
3401:     *==========================================================================
3402:         LOCAL loc_oGrd
3403: 
3404:         loc_oGrd = THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
3405:         loc_oGrd.RecordSource = "TmpOperacao"
3406:         loc_oGrd.Column1.ControlSource = "TmpOperacao.Codigos"
3407:         loc_oGrd.Column2.ControlSource = "TmpOperacao.Notas"
3408:         loc_oGrd.Column3.ControlSource = "TmpOperacao.Valos"
3409:         loc_oGrd.Column1.Width = 80
3410:         loc_oGrd.Column2.Width = 80
3411:         loc_oGrd.Column3.Width = 90
3412:         loc_oGrd.Column1.Header1.Caption = "Pend" + CHR(234) + "ncias"
3413:         loc_oGrd.Column2.Header1.Caption = "Notas"
3414:         loc_oGrd.Column3.Header1.Caption = "Valor"
3415: 
3416:         loc_oGrd = THIS.cnt_4c_Grade.grd_4c_Cupom
3417:         loc_oGrd.RecordSource = "crTpmMvItnC"
3418:         loc_oGrd.Column1.ControlSource = "crTpmMvItnC.Texto"
3419:         loc_oGrd.Column1.Width = 345
3420:         loc_oGrd.Column1.Header1.Caption = "Header1"
3421:     ENDPROC
3422: 
3423:     *==========================================================================
3424:     * LOOKUPS (FASE 6/8) - handlers KeyPress (PUBLIC, exigido por BINDEVENT -
3425:     * CLAUDE.md #3) + os metodos AbrirLookupXxx() que efetivamente abrem o
3426:     * FormBuscaAuxiliar. Todos seguem o contrato canonico do projeto
3427:     * (CLAUDE.md #37): Show() SO quando !this_lAchouRegistro, atribuicao SO
3428:     * sob this_lSelecionou, e Release() sempre no final.
3429:     *==========================================================================
3430: 
3431:     *==========================================================================
3432:     PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3433:     *==========================================================================
3434:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3435:             THIS.AbrirLookupFormaPagamento()
3436:         ENDIF
3437:     ENDPROC
3438: 
3439:     *==========================================================================
3440:     PROTECTED PROCEDURE AbrirLookupFormaPagamento
3441:     *==========================================================================
3442:     * Get_fpg (Cnt_Fpagto.cnt_forma.Get_fpg) - forma de pagamento (SigOpFp,
3443:     * chave Fpags). No legado a validacao e feita contra um cursor local
3444:     * (ccSigOpFp) ja carregado pelas operacoes permitidas; aqui a consulta e
3445:     * direto na tabela, que e o dado de origem daquele cursor.
3446:     *==========================================================================
3447:         LOCAL loc_oCnt, loc_oBusca
3448:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__forma
3449: 
3450:         IF !loc_oCnt.txt_4c_Fpg.Enabled
3451:             RETURN
3452:         ENDIF
3453: 
3454:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3455:             "SigOpFp", ;
3456:             "cursor_4c_BuscaFpg", ;
3457:             "fpags", ;
3458:             ALLTRIM(loc_oCnt.txt_4c_Fpg.Value), ;
3459:             "Forma de Pagamento")
3460: 
3461:         IF VARTYPE(loc_oBusca) = "O"
3462:             loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")
3463:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
3464: 
3465:             IF !loc_oBusca.this_lAchouRegistro
3466:                 loc_oBusca.Show()
3467:             ENDIF
3468: 
3469:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
3470:                 SELECT cursor_4c_BuscaFpg
3471:                 loc_oCnt.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
3472:             ENDIF
3473: 
3474:             IF USED("cursor_4c_BuscaFpg")
3475:                 USE IN cursor_4c_BuscaFpg
3476:             ENDIF
3477:             loc_oBusca.Release()
3478:         ENDIF
3479:     ENDPROC
3480: 
3481:     *==========================================================================
3482:     PROCEDURE AdquireKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3483:     *==========================================================================
3484:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3485:             THIS.AbrirLookupAdquirente()
3486:         ENDIF
3487:     ENDPROC
3488: 
3489:     *==========================================================================
3490:     PROTECTED PROCEDURE AbrirLookupAdquirente
3491:     *==========================================================================
3492:     * get_adquire (Cnt_Fpagto.cntnsu.get_adquire) - adquirente do cartao
3493:     * (SigCdCad, tipocads = 'ADQUIRENTE'). O legado busca pelo NOME
3494:     * (descads), nao por codigo - o campo guarda o texto do adquirente, nao
3495:     * um codigo (CreateObject('fwbuscaint','crCad','descads',...)).
3496:     *==========================================================================
3497:         LOCAL loc_oCnt, loc_oBusca
3498:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c_nsu
3499: 
3500:         IF !loc_oCnt.txt_4c__adquire.Enabled
3501:             RETURN
3502:         ENDIF
3503: 
3504:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3505:             "SigCdCad", ;
3506:             "cursor_4c_BuscaAdq", ;
3507:             "descads", ;
3508:             ALLTRIM(loc_oCnt.txt_4c__adquire.Value), ;
3509:             "Adquirente", .F., .T., "tipocads = " + EscaparSQL("ADQUIRENTE"))
3510: 
3511:         IF VARTYPE(loc_oBusca) = "O"
3512:             loc_oBusca.mAddColuna("descads", "", "Descri" + CHR(231) + CHR(227) + "o")
3513: 
3514:             IF !loc_oBusca.this_lAchouRegistro
3515:                 loc_oBusca.Show()
3516:             ENDIF
3517: 
3518:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAdq")
3519:                 SELECT cursor_4c_BuscaAdq
3520:                 loc_oCnt.txt_4c__adquire.Value = ALLTRIM(cursor_4c_BuscaAdq.descads)
3521:             ENDIF
3522: 
3523:             IF USED("cursor_4c_BuscaAdq")
3524:                 USE IN cursor_4c_BuscaAdq
3525:             ENDIF
3526:             loc_oBusca.Release()
3527:         ENDIF
3528:     ENDPROC
3529: 
3530:     *==========================================================================
3531:     PROCEDURE TabdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3532:     *==========================================================================
3533:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3534:             THIS.AbrirLookupTabDesconto()
3535:         ENDIF
3536:     ENDPROC
3537: 
3538:     *==========================================================================
3539:     PROTECTED PROCEDURE AbrirLookupTabDesconto
3540:     *==========================================================================
3541:     * Get_tabd (Cnt_Identifica.TabDesconto.Get_tabd) - tabela de desconto
3542:     * (SigOpTdz, chave Codigos).
3543:     *==========================================================================
3544:         LOCAL loc_oCnt, loc_oBusca
3545:         loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_TabDesconto
3546: 
3547:         IF !loc_oCnt.txt_4c_Tabd.Enabled
3548:             RETURN
3549:         ENDIF
3550: 
3551:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3552:             "SigOpTdz", ;
3553:             "cursor_4c_BuscaTabd", ;
3554:             "codigos", ;
3555:             ALLTRIM(loc_oCnt.txt_4c_Tabd.Value), ;
3556:             "Tabelas de Desconto")
3557: 
3558:         IF VARTYPE(loc_oBusca) = "O"
3559:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3560:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
3561: 
3562:             IF !loc_oBusca.this_lAchouRegistro
3563:                 loc_oBusca.Show()
3564:             ENDIF
3565: 
3566:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3567:                 SELECT cursor_4c_BuscaTabd
3568:                 loc_oCnt.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3569:             ENDIF
3570: 
3571:             IF USED("cursor_4c_BuscaTabd")
3572:                 USE IN cursor_4c_BuscaTabd
3573:             ENDIF
3574:             loc_oBusca.Release()
3575:         ENDIF
3576:     ENDPROC
3577: 
3578:     *==========================================================================
3579:     PROCEDURE ListaPrecoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3580:     *==========================================================================
3581:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3582:             THIS.AbrirLookupListaPreco()
3583:         ENDIF
3584:     ENDPROC
3585: 
3586:     *==========================================================================
3587:     PROTECTED PROCEDURE AbrirLookupListaPreco
3588:     *==========================================================================
3589:     * Get_ListaPreco (Cnt_Identifica.TabDesconto.Get_ListaPreco) - lista de
3590:     * precos (SigCdLpc). SigCdLpc NAO tem coluna de descricao separada -
3591:     * lprecos (char 30) e ao mesmo tempo chave e nome, igual SigCdOpe.Dopes
3592:     * (CLAUDE.md regra sobre tabelas single-column). O filtro por Tipos do
3593:     * legado (crSigCdOpe.tplprecs) so entra quando o cursor da operacao
3594:     * corrente ja estiver carregado - sem ele, a lista sai completa.
3595:     *==========================================================================
3596:         LOCAL loc_oCnt, loc_oBusca, loc_cFiltro
3597: 
3598:         loc_oCnt = THIS.cnt_4c__Identifica.cnt_4c_TabDesconto
3599: 
3600:         IF !loc_oCnt.txt_4c_ListaPreco.Enabled
3601:             RETURN
3602:         ENDIF
3603: 
3604:         loc_cFiltro = ""
3605:         IF USED("crSigCdOpe")
3606:             loc_cFiltro = IIF(crSigCdOpe.tplprecs = 2, "tipos = 'C'", "tipos <> 'C'")
3607:         ENDIF
3608: 
3609:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3610:             "SigCdLpc", ;
3611:             "cursor_4c_BuscaLpc", ;
3612:             "lprecos", ;
3613:             ALLTRIM(loc_oCnt.txt_4c_ListaPreco.Value), ;
3614:             "Listas de Pre" + CHR(231) + "o", .F., .T., loc_cFiltro)
3615: 
3616:         IF VARTYPE(loc_oBusca) = "O"
3617:             loc_oBusca.mAddColuna("lprecos", "", "Descri" + CHR(231) + CHR(227) + "o")
3618: 
3619:             IF !loc_oBusca.this_lAchouRegistro
3620:                 loc_oBusca.Show()
3621:             ENDIF
3622: 
3623:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLpc")
3624:                 SELECT cursor_4c_BuscaLpc
3625:                 loc_oCnt.txt_4c_ListaPreco.Value = ALLTRIM(cursor_4c_BuscaLpc.lprecos)
3626:             ENDIF
3627: 
3628:             IF USED("cursor_4c_BuscaLpc")
3629:                 USE IN cursor_4c_BuscaLpc
3630:             ENDIF
3631:             loc_oBusca.Release()
3632:         ENDIF
3633:     ENDPROC
3634: 
3635:     *==========================================================================
3636:     * Identificacao de conta (Destino/Responsavel/Vendedor/Origem) - os 4
3637:     * blocos criados por MontarBlocoIdentificacao() tem a MESMA estrutura de
3638:     * campos, entao os handlers abaixo so mudam no NOME do bloco (par_cBloco)
3639:     * passado a AbrirLookupGrupo/AbrirLookupConta/AbrirLookupContaPorCpf.
3640:     *==========================================================================
3641: 
3642:     *==========================================================================
3643:     PROCEDURE GrupoDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3644:     *==========================================================================
3645:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3646:             THIS.AbrirLookupGrupo("Destino")
3647:         ENDIF
3648:     ENDPROC
3649: 
3650:     PROCEDURE ContaDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3651:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3652:             THIS.AbrirLookupConta("Destino")
3653:         ENDIF
3654:     ENDPROC
3655: 
3656:     PROCEDURE CpfDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3657:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3658:             THIS.AbrirLookupContaPorCpf("Destino")
3659:         ENDIF
3660:     ENDPROC
3661: 
3662:     PROCEDURE GrupoResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3663:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3664:             THIS.AbrirLookupGrupo("Responsavel")
3665:         ENDIF
3666:     ENDPROC
3667: 
3668:     PROCEDURE ContaResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3669:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3670:             THIS.AbrirLookupConta("Responsavel")
3671:         ENDIF
3672:     ENDPROC
3673: 
3674:     PROCEDURE CpfResponsavelKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3675:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3676:             THIS.AbrirLookupContaPorCpf("Responsavel")
3677:         ENDIF
3678:     ENDPROC
3679: 
3680:     PROCEDURE GrupoVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3681:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3682:             THIS.AbrirLookupGrupo("Vendedor")
3683:         ENDIF
3684:     ENDPROC
3685: 
3686:     PROCEDURE ContaVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3687:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3688:             THIS.AbrirLookupConta("Vendedor")
3689:         ENDIF
3690:     ENDPROC
3691: 
3692:     PROCEDURE CpfVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3693:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3694:             THIS.AbrirLookupContaPorCpf("Vendedor")
3695:         ENDIF
3696:     ENDPROC
3697: 
3698:     PROCEDURE GrupoOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3699:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3700:             THIS.AbrirLookupGrupo("Origem")
3701:         ENDIF
3702:     ENDPROC
3703: 
3704:     PROCEDURE ContaOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3705:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3706:             THIS.AbrirLookupConta("Origem")
3707:         ENDIF
3708:     ENDPROC
3709: 
3710:     PROCEDURE CpfOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3711:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3712:             THIS.AbrirLookupContaPorCpf("Origem")
3713:         ENDIF
3714:     ENDPROC
3715: 
3716:     *==========================================================================
3717:     PROTECTED PROCEDURE AbrirLookupGrupo(par_cBloco)
3718:     *==========================================================================
3719:     * Get_grupo (Destino/Responsavel/Vendedor/Origem) - grupo de contas
3720:     * (SigCdGrp, chave cgrus). par_cBloco identifica o container concreto
3721:     * (cnt_4c_Destino/cnt_4c_Responsavel/cnt_4c_Vendedor/cnt_4c_Origem).
3722:     *==========================================================================
3723:         LOCAL loc_oCnt, loc_oBusca
3724: 
3725:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)
3726: 
3727:         IF !loc_oCnt.txt_4c_Grupo.Enabled
3728:             RETURN
3729:         ENDIF
3730: 
3731:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3732:             "SigCdGrp", ;
3733:             "cursor_4c_BuscaGrupo", ;
3734:             "cgrus", ;
3735:             ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), ;
3736:             "Grupo de Contas")
3737: 
3738:         IF VARTYPE(loc_oBusca) = "O"
3739:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
3740:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3741: 
3742:             IF !loc_oBusca.this_lAchouRegistro
3743:                 loc_oBusca.Show()
3744:             ENDIF
3745: 
3746:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
3747:                 SELECT cursor_4c_BuscaGrupo
3748:                 loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
3749:             ENDIF
3750: 
3751:             IF USED("cursor_4c_BuscaGrupo")
3752:                 USE IN cursor_4c_BuscaGrupo
3753:             ENDIF
3754:             loc_oBusca.Release()
3755:         ENDIF
3756:     ENDPROC
3757: 
3758:     *==========================================================================
3759:     PROTECTED PROCEDURE AbrirLookupConta(par_cBloco)
3760:     *==========================================================================
3761:     * Get_conta (Destino/Responsavel/Vendedor/Origem) - conta (SigCdCli,
3762:     * chave Iclis). Ao selecionar, preenche tambem o Nome (txt_4c_Dconta),
3763:     * igual ao legado (fAcessoContas preenchia This.Parent.Get_DConta junto).
3764:     *==========================================================================
3765:         LOCAL loc_oCnt, loc_oBusca
3766: 
3767:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)
3768: 
3769:         IF !loc_oCnt.txt_4c_Conta.Enabled
3770:             RETURN
3771:         ENDIF
3772: 
3773:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3774:             "SigCdCli", ;
3775:             "cursor_4c_BuscaConta", ;
3776:             "iclis", ;
3777:             ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
3778:             "Contas")
3779: 
3780:         IF VARTYPE(loc_oBusca) = "O"
3781:             loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3782:             loc_oBusca.mAddColuna("rclis", "", "Nome")
3783: 
3784:             IF !loc_oBusca.this_lAchouRegistro
3785:                 loc_oBusca.Show()
3786:             ENDIF
3787: 
3788:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3789:                 SELECT cursor_4c_BuscaConta
3790:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
3791:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
3792:             ENDIF
3793: 
3794:             IF USED("cursor_4c_BuscaConta")
3795:                 USE IN cursor_4c_BuscaConta
3796:             ENDIF
3797:             loc_oBusca.Release()
3798:         ENDIF
3799:     ENDPROC
3800: 
3801:     *==========================================================================
3802:     PROTECTED PROCEDURE AbrirLookupContaPorCpf(par_cBloco)
3803:     *==========================================================================
3804:     * Get_cpf (Destino/Responsavel/Vendedor/Origem) - localiza a conta pelo
3805:     * CPF/CNPJ (SigCdCli, campo Cpfs). Ao selecionar, preenche Conta e Nome
3806:     * junto - mesmo comportamento do legado (o Valid de Get_cpf resolvia
3807:     * Conta+DConta a partir do documento digitado).
3808:     *==========================================================================
3809:         LOCAL loc_oCnt, loc_oBusca
3810: 
3811:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)
3812: 
3813:         IF !loc_oCnt.txt_4c_Cpf.Enabled
3814:             RETURN
3815:         ENDIF
3816: 
3817:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3818:             "SigCdCli", ;
3819:             "cursor_4c_BuscaCpf", ;
3820:             "cpfs", ;
3821:             ALLTRIM(loc_oCnt.txt_4c_Cpf.Value), ;
3822:             "Contas")
3823: 
3824:         IF VARTYPE(loc_oBusca) = "O"
3825:             loc_oBusca.mAddColuna("cpfs", "", "CPF/CNPJ")
3826:             loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
3827:             loc_oBusca.mAddColuna("rclis", "", "Nome")
3828: 
3829:             IF !loc_oBusca.this_lAchouRegistro
3830:                 loc_oBusca.Show()
3831:             ENDIF
3832: 
3833:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
3834:                 SELECT cursor_4c_BuscaCpf
3835:                 loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
3836:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCpf.iclis)
3837:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCpf.rclis)
3838:             ENDIF
3839: 
3840:             IF USED("cursor_4c_BuscaCpf")
3841:                 USE IN cursor_4c_BuscaCpf
3842:             ENDIF
3843:             loc_oBusca.Release()
3844:         ENDIF
3845:     ENDPROC
3846: 
3847:     *==========================================================================
3848:     * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
3849:     *==========================================================================
3850:     * Todos os handlers ligados por BINDEVENT sao PUBLIC (sem PROTECTED):
3851:     * metodo PROTECTED falha em SILENCIO no BINDEVENT (CLAUDE.md #3).
3852:     *
3853:     * SIGMVITS.SCX nao tem os 6 botoes CRUD canonicos (Incluir/Visualizar/
3854:     * Alterar/Excluir/Buscar/Encerrar) nem pagina de Lista: e uma tela de
3855:     * Caixa (frente de venda). Os "eventos principais" desta fase sao,
3856:     * portanto, os Click dos 16 botoes que o legado REALMENTE tem na
3857:     * Barra_Botoes, mais os botoes das telas de operacao, o KeyPress do form
3858:     * (KeyPreview = .T., que e o atalho de teclado de cada um deles) e o
3859:     * Timer da barra de titulo. Inventar botoes CRUD aqui violaria o PILAR 1.
3860:     *==========================================================================
3861: 
3862:     *--------------------------------------------------------------------------
3863:     * AlternarTelaOperacao - mostra EXATAMENTE um dos quatro containers de
3864:     * operacao e esconde os outros tres. No legado cada Click comeca zerando a
3865:     * visibilidade dos irmaos antes de mostrar o proprio (identifica.Click:
3866:     * "ThisForm.CntItem.Visible=.f. / ThisForm.CntGrade.Visible=.f. /
3867:     * Thisform.Cnt_pendencia.Visible=.f. / ThisForm.Cnt_fpagto.Visible=.f.").
3868:     * Sem este metodo os quatro nascem Visible=.T. (Fases 3-6) empilhados na
3869:     * mesma area da tela.
3870:     *
3871:     * cnt_4c_Grade (a grade do cupom) acompanha ITENS e FPAGTO - e o que o
3872:     * legado faz ("ThisForm.CntGrade.Visible = .t." no fim de Itens.Click e de
3873:     * Pagto.Click; identifica.Click a esconde).
3874:     *
3875:     * cnt_4c_CancelaItem e um painel sobreposto (aparece por cima da tela
3876:     * ativa) - trocar de tela fecha ele, igual ao CancelaDisp legado.
3877:     *--------------------------------------------------------------------------
3878:     PROTECTED PROCEDURE AlternarTelaOperacao(par_cTela)
3879:         LOCAL loc_cTela
3880:         loc_cTela = UPPER(ALLTRIM(par_cTela))
3881: 
3882:         THIS.this_cTelaAtual = loc_cTela
3883: 
3884:         THIS.cnt_4c_Item.Visible        = (loc_cTela == "ITENS")
3885:         THIS.cnt_4c__Pendencia.Visible  = (loc_cTela == "PENDENCIA")
3886:         THIS.cnt_4c__Identifica.Visible = (loc_cTela == "IDENTIFICA")
3887:         THIS.cnt_4c__Fpagto.Visible     = (loc_cTela == "FPAGTO")
3888: 
3889:         THIS.cnt_4c_Grade.Visible = (loc_cTela == "ITENS" OR loc_cTela == "FPAGTO")
3890: 
3891:         IF loc_cTela != "ITENS"
3892:             THIS.cnt_4c_CancelaItem.Visible = .F.
3893:             THIS.cnt_4c_Item.Enabled        = .T.
3894:         ENDIF
3895: 
3896:         *-- O container mostrado tem de ficar POR CIMA: os quatro ocupam a
3897:         *-- mesma regiao e a ordem de AddObject define o z-order inicial
3898:         *-- (legado: ".ZOrder(0)" no fim de cada Click).
3899:         DO CASE
3900:             CASE loc_cTela == "ITENS"
3901:                 THIS.cnt_4c_Item.ZOrder(0)
3902:             CASE loc_cTela == "PENDENCIA"
3903:                 THIS.cnt_4c__Pendencia.ZOrder(0)
3904:             CASE loc_cTela == "IDENTIFICA"
3905:                 THIS.cnt_4c__Identifica.ZOrder(0)
3906:             CASE loc_cTela == "FPAGTO"
3907:                 THIS.cnt_4c__Fpagto.ZOrder(0)
3908:         ENDCASE
3909: 
3910:         *-- Quem desabilita botao tem de reabilitar no FUNIL de volta: toda
3911:         *-- troca de tela passa por aqui, entao o gate dos botoes e reaplicado
3912:         *-- num lugar so e nao em cada Click (CLAUDE.md #40).
3913:         THIS.AjustarBotoesPorModo()
3914:     ENDPROC
3915: 
3916:     *--------------------------------------------------------------------------
3917:     * AjustarBotoesPorModo - gate de disponibilidade dos botoes da barra,
3918:     * transcrito dos blocos "Barra_Botoes.<X>.Enabled = ..." que o legado
3919:     * repete no fim de CADA Click:
3920:     *
3921:     *   Itens.Click    -> Apaga/Alteraqtd/AltPreco .T. ; CancPagto/Desconto/
3922:     *                     Acrescimo .F.

*-- Linhas 3930 a 4039:
3930:     * comportamento fica LIBERADO, como na operacao padrao, em vez de travar
3931:     * a tela.
3932:     *--------------------------------------------------------------------------
3933:     PROCEDURE AjustarBotoesPorModo()
3934:         LOCAL loc_lItens, loc_lFpagto, loc_lVars, loc_oBarra
3935: 
3936:         loc_oBarra  = THIS.cnt_4c_Barra_Botoes
3937:         loc_lItens  = (THIS.this_cTelaAtual == "ITENS")
3938:         loc_lFpagto = (THIS.this_cTelaAtual == "FPAGTO")
3939: 
3940:         loc_lVars = .T.
3941:         IF USED("crSigCdOpe")
3942:             loc_lVars = (NVL(crSigCdOpe.Vars, 1) = 1)
3943:         ENDIF
3944: 
3945:         loc_oBarra.cmd_4c_Apaga.Enabled     = loc_lItens
3946:         loc_oBarra.cmd_4c_Alteraqtd.Enabled = loc_lItens
3947:         loc_oBarra.cmd_4c_AltPreco.Enabled  = loc_lItens
3948: 
3949:         loc_oBarra.cmd_4c_CancPagto.Enabled = loc_lFpagto
3950:         loc_oBarra.cmd_4c_Desconto.Enabled  = (loc_lFpagto AND loc_lVars)
3951:         loc_oBarra.cmd_4c_Acrescimo.Enabled = (loc_lFpagto AND loc_lVars)
3952: 
3953:         *-- Impfiscal: o legado desliga o monitor da impressora tao logo o
3954:         *-- cupom e aberto ("Barra_Botoes.Impfiscal.Enabled = .f." em
3955:         *-- Itens/Pagto/identifica/pendencia.Click).
3956:         loc_oBarra.cmd_4c_Impfiscal.Enabled = !THIS.this_lIniciou
3957: 
3958:         *-- Itens/Pagto/Identifica/Pendencia/Confirmar/Cancelar ficam sempre
3959:         *-- disponiveis: no legado o gate deles e o When (Inicia/LiberaIdent),
3960:         *-- que o BINDEVENT nao reproduz - o retorno de um When delegado e
3961:         *-- DESCARTADO (CLAUDE.md #3). Por isso a mesma condicao do When e
3962:         *-- checada DENTRO de cada Click, no inicio.
3963:     ENDPROC
3964: 
3965:     *--------------------------------------------------------------------------
3966:     * FocarControle - SetFocus protegido. Falha de SetFocus aqui e sempre
3967:     * problema de TIMING (controle que acabou de ficar invisivel no mesmo
3968:     * ciclo de evento), nunca perda de dado: exibir MsgErro por causa de foco
3969:     * de teclado seria pior do que nao exibir nada. E o unico CATCH silencioso
3970:     * do form, e e silencioso de proposito.
3971:     *--------------------------------------------------------------------------
3972:     PROTECTED PROCEDURE FocarControle(par_oControle)
3973:         LOCAL loc_oErro
3974:         TRY
3975:             IF VARTYPE(par_oControle) = "O" AND par_oControle.Visible AND par_oControle.Enabled
3976:                 par_oControle.SetFocus
3977:             ENDIF
3978:         CATCH TO loc_oErro
3979:             * silencioso de proposito - ver comentario do metodo.
3980:         ENDTRY
3981:     ENDPROC
3982: 
3983:     *--------------------------------------------------------------------------
3984:     * ExibirMensagem - escreve na barra de mensagem do rodape
3985:     * (Cnt_Mensagem.Mensagem no legado, usada em Itens/Pagto.Click:
3986:     * "ThisForm.Cnt_mensagem.Mensagem.Caption = ' '").
3987:     *--------------------------------------------------------------------------
3988:     PROTECTED PROCEDURE ExibirMensagem(par_cTexto)
3989:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = par_cTexto
3990:         THIS.cnt_4c__Mensagem.Refresh()
3991:     ENDPROC
3992: 
3993:     *--------------------------------------------------------------------------
3994:     * Indica (.T.) se ha forma de pagamento lancada em xPar
3995:     * ainda nao inserida. Transcricao da guarda que o legado repete em
3996:     * Itens/Financia/pendencia/credito.Click: "Count to wxpar for Valos > 0
3997:     * and not Empty(fpags) And Not xPar.InsChs / If wxpar > 0 /
3998:     * MessageBox('Favor Excluir as Condicoes de Pagamento!!!')".
3999:     *--------------------------------------------------------------------------
4000:     PROTECTED FUNCTION HaPagamentoPendente()
4001:         LOCAL loc_nQt, loc_nAreaAnt
4002:         loc_nQt = 0
4003: 
4004:         IF USED("xPar")
4005:             loc_nAreaAnt = SELECT()
4006:             SELECT xPar
4007:             COUNT FOR NVL(Valos, 0) > 0 AND !EMPTY(NVL(FPags, "")) AND !NVL(InsChs, .F.) ;
4008:                 AND !DELETED() TO loc_nQt
4009:             IF loc_nAreaAnt > 0
4010:                 SELECT (loc_nAreaAnt)
4011:             ENDIF
4012:         ENDIF
4013: 
4014:         RETURN (loc_nQt > 0)
4015:     ENDFUNC
4016: 
4017:     *--------------------------------------------------------------------------
4018:     * HaFormaPagamentoEmAberto - .T. quando o campo Forma de Pagamento esta
4019:     * preenchido, isto e, ha lancamento de pagamento EM ANDAMENTO. Guarda
4020:     * literal do legado ("If Not Empty(Cnt_Fpagto.cnt_forma.get_fpg.Value) /
4021:     * Return 0") no inicio de Itens/Financia/pendencia/credito/identifica.
4022:     *--------------------------------------------------------------------------
4023:     PROTECTED FUNCTION HaFormaPagamentoEmAberto()
4024:         RETURN !EMPTY(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg.Value)
4025:     ENDFUNC
4026: 
4027:     *--------------------------------------------------------------------------
4028:     * HaItemNaoImpresso - .T. quando existe item no carrinho que ainda nao foi
4029:     * impresso no cupom fiscal. Guarda do legado em ok/Cancela/Pagto.Click:
4030:     * "Locate For Not ImpCupFis And Not Empty(Cpros) / If Not Eof() And
4031:     * Barra_Botoes.Itens.Enabled / MessageBox('Obrigatorio Impressao dos
4032:     * Itens... Click <F2>')".
4033:     *--------------------------------------------------------------------------
4034:     PROTECTED FUNCTION HaItemNaoImpresso()
4035:         LOCAL loc_lAchou, loc_nAreaAnt
4036:         loc_lAchou = .F.
4037: 
4038:         IF USED("crTpmMvItn")
4039:             loc_nAreaAnt = SELECT()

*-- Linhas 4098 a 4141:
4098:     * proximo item e abre UMA linha nova em branco; depois zera os oito campos
4099:     * do bloco de digitacao do item.
4100:     *--------------------------------------------------------------------------
4101:     PROTECTED PROCEDURE LimparCamposItem(par_lInsere)
4102:         LOCAL loc_nMax, loc_lInsere
4103:         loc_lInsere = IIF(VARTYPE(par_lInsere) = "L", par_lInsere, .F.)
4104: 
4105:         IF loc_lInsere AND USED("crTpmMvItn")
4106:             SELECT crTpmMvItn
4107:             SET ORDER TO
4108:             GO TOP
4109:             DELETE FOR EMPTY(NVL(cpros, ""))
4110: 
4111:             *-- Legado: "ThisForm.Citem = Iif(UltimoCancel > Max(Citens),
4112:             *-- UltimoCancel, Max(Citens)) + 1". O Max e apurado por SCAN e
4113:             *-- nao por SELECT ... INTO CURSOR para nao trocar a area de
4114:             *-- trabalho corrente no meio do metodo.
4115:             loc_nMax = 0
4116:             SCAN FOR !EMPTY(NVL(cpros, "")) AND !DELETED()
4117:                 IF NVL(citens, 0) > loc_nMax
4118:                     loc_nMax = NVL(citens, 0)
4119:                 ENDIF
4120:             ENDSCAN
4121: 
4122:             THIS.this_nCItem = MAX(THIS.this_nUltimoCancel, loc_nMax) + 1
4123: 
4124:             INSERT INTO crTpmMvItn (citens) VALUES (THIS.this_nCItem)
4125:             SELECT crTpmMvItn
4126:             SET ORDER TO
4127:         ENDIF
4128: 
4129:         WITH THIS.cnt_4c_Item
4130:             .cnt_4c__Prod.txt_4c_Produto.Value    = ""
4131:             .cnt_4c__Qtd.txt_4c_Qtds.Value        = 0
4132:             .cnt_4c__val.txt_4c_Valor.Value       = 0
4133:             .cnt_4c__ValU.txt_4c_Unival.Value     = 0
4134:             .cnt_4c__vdesc.txt_4c_Valdesc.Value   = 0
4135:             .cnt_4c__pDesc.txt_4c_Pvaldesc.Value  = 0
4136:             .cnt_4c__vacre.txt_4c_ValAcre.Value   = 0
4137:             .cnt_4c__pacre.txt_4c__pValAcre.Value = 0
4138:             .cnt_4c__Prod.txt_4c_Produto.Refresh()
4139:             .Visible     = .T.
4140:         ENDWITH
4141:     ENDPROC

*-- Linhas 4157 a 4227:
4157:     * Refresh, e e por isso que o Refresh das grades vem no fim (CLAUDE.md
4158:     * #21a).
4159:     *--------------------------------------------------------------------------
4160:     PROTECTED PROCEDURE RecalcularTotais()
4161:         LOCAL loc_nSubTotal, loc_nTotal, loc_nFormas
4162:         LOCAL loc_nDesc, loc_nAcre, loc_nDescP, loc_nLiquido
4163: 
4164:         loc_nSubTotal = 0
4165:         loc_nTotal    = 0
4166:         loc_nFormas   = 0
4167: 
4168:         IF USED("crTpmMvItn")
4169:             SELECT crTpmMvItn
4170:             *-- Ordem canonica do SUM: FOR vem ANTES do TO.
4171:             SUM NVL(qtds, 0) * NVL(units, 0) FOR !DELETED() TO loc_nSubTotal
4172:             SUM NVL(totas, 0) FOR !DELETED() TO loc_nTotal
4173:             GO TOP
4174:         ENDIF
4175: 
4176:         *-- O legado usa Totas (valor do item ja com desconto/acrescimo) no
4177:         *-- Total Geral e qtds*units no Subtotal. Carrinho recem-aberto tem
4178:         *-- Totas zerado - nesse caso o Total Geral acompanha o Subtotal, para
4179:         *-- nao exibir 0,00 com itens na tela.
4180:         IF loc_nTotal = 0
4181:             loc_nTotal = loc_nSubTotal
4182:         ENDIF
4183: 
4184:         THIS.cnt_4c_Grade.cnt_4c__subt.txt_4c_Total.Value = loc_nSubTotal
4185:         THIS.cnt_4c_Grade.cnt_4c__tots.txt_4c_Total.Value = loc_nTotal
4186:         THIS.this_nTotIte = loc_nTotal
4187: 
4188:         IF USED("xPar")
4189:             SELECT xPar
4190:             *-- Forma com Trocos = 1 ABATE (legado: "ctotal = Round(ctotal -
4191:             *-- (valos * cotfpgs), 2)"), as demais SOMAM.
4192:             SUM ROUND(NVL(Valos, 0) * NVL(CotFPgs, 1) * IIF(NVL(Trocos, 0) = 1, -1, 1), 2) ;
4193:                 FOR !DELETED() TO loc_nFormas
4194:             GO BOTTOM
4195:         ENDIF
4196: 
4197:         WITH THIS.cnt_4c__Fpagto
4198:             loc_nDesc  = .cnt_4c_Desconto.txt_4c_TotVariacao.Value
4199:             loc_nAcre  = .cnt_4c_Acrescimo.txt_4c_TotVariacao.Value
4200:             loc_nDescP = .cnt_4c__descp.txt_4c_Tvariacao.Value
4201: 
4202:             loc_nLiquido = loc_nTotal + loc_nAcre - loc_nDesc - loc_nDescP
4203: 
4204:             .cnt_4c__tot.txt_4c_Valinic.Value      = loc_nTotal
4205:             .cnt_4c__saldo.txt_4c_TotLiquido.Value = loc_nLiquido
4206:             .cnt_4c__pag.txt_4c_TotForma.Value     = loc_nFormas
4207:             .cnt_4c__apag.txt_4c_Saldo.Value       = loc_nLiquido - loc_nFormas
4208:             .Refresh()
4209:             .Visible     = .T.
4210:         ENDWITH
4211: 
4212:         THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
4213:         THIS.cnt_4c_Grade.grd_4c_Cupom.Refresh()
4214:     ENDPROC
4215: 
4216:     *==========================================================================
4217:     * HANDLERS - BARRA DE BOTOES PRINCIPAL (cnt_4c_Barra_Botoes)
4218:     *==========================================================================
4219: 
4220:     *--------------------------------------------------------------------------
4221:     * [F2] Itens (cmd_4c_Itens) - volta para a tela de lancamento de itens.
4222:     *
4223:     * Legado (Barra_Botoes.Itens.Click, 316 linhas): as duas guardas de
4224:     * entrada (pagamento lancado / forma de pagamento em aberto), abertura do
4225:     * cupom fiscal (IniciarCupom/GerarCupom), IMPRESSAO de cada item no ECF
4226:     * (VenFis/RotStatus/VerSubt no driver da impressora), recalculo dos
4227:     * totais, gate dos botoes, troca de tela e foco no campo Produto.

*-- Linhas 4234 a 4348:
4234:     * CLAUDE.md proibe. A abertura/emissao fiscal continua sendo da tela de
4235:     * movimentacao (form pai), que e quem fala com a impressora.
4236:     *--------------------------------------------------------------------------
4237:     PROCEDURE CmdItensClick()
4238:         IF THIS.HaPagamentoPendente()
4239:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", "Itens")
4240:             RETURN
4241:         ENDIF
4242: 
4243:         IF THIS.HaFormaPagamentoEmAberto()
4244:             RETURN
4245:         ENDIF
4246: 
4247:         THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Enabled = .T.
4248:         THIS.ExibirMensagem(" ")
4249: 
4250:         THIS.AlternarTelaOperacao("ITENS")
4251: 
4252:         *-- Legado: as duas imagens (produto/empresa) voltam a aparecer ao
4253:         *-- entrar na tela de itens e sao escondidas no Pagto.Click.
4254:         THIS.cnt_4c_Item.cnt_4c__imgProd.Visible = .T.
4255:         THIS.cnt_4c_Item.cnt_4c__ImgEmp.Visible  = .T.
4256: 
4257:         THIS.LimparCamposItem(.T.)
4258:         THIS.RecalcularTotais()
4259: 
4260:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
4261:     ENDPROC
4262: 
4263:     *--------------------------------------------------------------------------
4264:     * [F3] Qtde (cmd_4c_Alteraqtd) - legado (9 linhas): "If Empty(Get_produto.
4265:     * Value) / lAlteraqtd = .t. / Get_qtds.SetFocus / Else / Get_Produto.
4266:     * SetFocus / Endif".
4267:     *--------------------------------------------------------------------------
4268:     PROCEDURE CmdAlteraqtdClick()
4269:         LOCAL loc_oProd
4270:         loc_oProd = THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto
4271: 
4272:         IF EMPTY(loc_oProd.Value)
4273:             THIS.this_lAlteraQtd = .T.
4274:             THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Qtd.txt_4c_Qtds)
4275:         ELSE
4276:             THIS.FocarControle(loc_oProd)
4277:         ENDIF
4278:     ENDPROC
4279: 
4280:     *--------------------------------------------------------------------------
4281:     * [F3] Descon. (cmd_4c_Desconto) - legado (40 linhas): consulta a SITUACAO
4282:     * da conta (destino e origem) em SigCdCli/SigCdCst e BLOQUEIA o desconto
4283:     * quando SigCdCst.BlqDescs = 1; bloqueia tambem se ja houver acrescimo
4284:     * informado ou o painel de acrescimo aberto; senao abre o painel de
4285:     * desconto e o Saldo Final.
4286:     *--------------------------------------------------------------------------
4287:     PROCEDURE CmdDescontoClick()
4288:         LOCAL loc_lOk
4289: 
4290:         loc_lOk = .T.
4291: 
4292:         IF THIS.DescontoBloqueadoPorSituacao()
4293:             loc_lOk = .F.
4294:         ENDIF
4295: 
4296:         IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value > 0
4297:             MsgAviso("Acr" + CHR(233) + "scimo j" + CHR(225) + " Informado. N" + CHR(227) + ;
4298:                 "o pode haver Desconto!!!", "Desconto")
4299:             loc_lOk = .F.
4300:         ENDIF
4301: 
4302:         IF THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible
4303:             loc_lOk = .F.
4304:         ENDIF
4305: 
4306:         IF loc_lOk
4307:             THIS.this_lValidaDesconto = .T.
4308:             WITH THIS.cnt_4c__Fpagto
4309:                 .cnt_4c_Desconto.Visible                 = .T.
4310:                 .cnt_4c_Desconto.Enabled                 = .T.
4311:                 .cnt_4c__saldo.txt_4c_TotLiquido.Visible = .T.
4312:             ENDWITH
4313:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao)
4314:         ENDIF
4315:     ENDPROC
4316: 
4317:     *--------------------------------------------------------------------------
4318:     * DescontoBloqueadoPorSituacao - transcricao das duas consultas do
4319:     * Desconto.Click legado: a situacao (SigCdCli.Situas) da conta DESTINO e
4320:     * da conta ORIGEM e procurada em SigCdCst e, com BlqDescs = 1, o desconto
4321:     * e bloqueado com a mensagem "<situacao> - <descricao> / Desconto
4322:     * Bloqueado Pela Situacao da Conta".
4323:     *
4324:     * O legado le a conta de TprMvCab (cursor do form pai). Aqui as contas vem
4325:     * dos campos da propria tela (blocos Destino/Origem de cnt_4c__Identifica),
4326:     * que e o mesmo dado; sem conta informada nao ha o que checar.
4327:     *--------------------------------------------------------------------------
4328:     PROTECTED FUNCTION DescontoBloqueadoPorSituacao()
4329:         LOCAL loc_lBloqueia, loc_cDestino, loc_cOrigem
4330: 
4331:         loc_lBloqueia = .F.
4332:         loc_cDestino  = ALLTRIM(THIS.cnt_4c__Identifica.cnt_4c_Destino.txt_4c_Conta.Value)
4333:         loc_cOrigem   = ALLTRIM(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Conta.Value)
4334: 
4335:         IF !EMPTY(loc_cDestino)
4336:             loc_lBloqueia = THIS.ContaBloqueiaDesconto(loc_cDestino)
4337:         ENDIF
4338: 
4339:         IF !loc_lBloqueia AND !EMPTY(loc_cOrigem)
4340:             loc_lBloqueia = THIS.ContaBloqueiaDesconto(loc_cOrigem)
4341:         ENDIF
4342: 
4343:         RETURN loc_lBloqueia
4344:     ENDFUNC
4345: 
4346:     *--------------------------------------------------------------------------
4347:     * ContaBloqueiaDesconto - uma conta. O legado faz em duas etapas
4348:     * (CursorQuery SigCdCli -> CursorQuery SigCdCst); aqui o JOIN resolve as

*-- Linhas 4375 a 4558:
4375:                             loc_cDesc = ALLTRIM(NVL(cursor_4c_SitConta.Descrs, ""))
4376:                         ENDIF
4377: 
4378:                         MsgAviso(ALLTRIM(NVL(cursor_4c_SitConta.Codigos, "")) + " - " + loc_cDesc + CHR(13) + ;
4379:                             "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", ;
4380:                             "Situa" + CHR(231) + CHR(227) + CHR(227))
4381:                         loc_lBloqueia = .T.
4382:                     ENDIF
4383:                 ENDIF
4384:             ENDIF
4385: 
4386:             IF USED("cursor_4c_SitConta")
4387:                 USE IN cursor_4c_SitConta
4388:             ENDIF
4389:         CATCH TO loc_oErro
4390:             MsgErro(loc_oErro.Message + CHR(13) + ;
4391:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4392:                 "Procedure: " + loc_oErro.Procedure, ;
4393:                 "Erro ao checar situa" + CHR(231) + CHR(227) + "o da conta")
4394:         ENDTRY
4395: 
4396:         RETURN loc_lBloqueia
4397:     ENDFUNC
4398: 
4399:     *--------------------------------------------------------------------------
4400:     * [Ctrl+F3] Acrescimo (cmd_4c_Acrescimo) - legado (24 linhas): bloqueia se
4401:     * ja houver desconto informado ou o painel de desconto aberto; senao abre
4402:     * o painel de acrescimo e o Saldo Final.
4403:     *--------------------------------------------------------------------------
4404:     PROCEDURE CmdAcrescimoClick()
4405:         LOCAL loc_lOk
4406:         loc_lOk = .T.
4407: 
4408:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_TotVariacao.Value > 0
4409:             MsgAviso("Desconto Informado. N" + CHR(227) + "o pode haver Acr" + CHR(233) + "scimo!!!", ;
4410:                 "Acr" + CHR(233) + "scimo")
4411:             loc_lOk = .F.
4412:         ENDIF
4413: 
4414:         IF THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible
4415:             loc_lOk = .F.
4416:         ENDIF
4417: 
4418:         IF loc_lOk
4419:             THIS.this_lValidaDesconto = .T.
4420:             WITH THIS.cnt_4c__Fpagto
4421:                 .cnt_4c_Acrescimo.Visible                = .T.
4422:                 .cnt_4c_Acrescimo.Enabled                = .T.
4423:                 .cnt_4c__saldo.txt_4c_TotLiquido.Visible = .T.
4424:             ENDWITH
4425:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_TotVariacao)
4426:         ENDIF
4427:     ENDPROC
4428: 
4429:     *--------------------------------------------------------------------------
4430:     * [F4] Canc (cmd_4c_CancPagto) - cancela a forma de pagamento lancada.
4431:     *
4432:     * Legado (Barra_Botoes.CancPagto.Click, 184 linhas): quando a forma e de
4433:     * CARTAO (crSigOpFp.cCupomNvs = 'TEF'), consulta o gateway TEF no arquivo
4434:     * local SigTef, chama TefImpr/VerifGP (driver do pinpad), grava
4435:     * SigFiTef.cStatus = 'CNC' e so entao apaga a parcela; nas demais formas
4436:     * apaga direto ("Delete For nChaves = lnChv" quando CrSigOpCdd.VarPs = 1,
4437:     * senao "Delete"). No fim recalcula o total das formas, limpa os campos da
4438:     * forma e devolve o foco.
4439:     *
4440:     * O trecho de TEF depende do pinpad fisico e de TefImpr/VerifGP/
4441:     * DeleteSigTef (driver, nao portadas) - fica na tela de movimentacao, que
4442:     * e quem conversa com o gateway. Aqui a parcela LOCAL e removida junto com
4443:     * as demais da mesma chave de lancamento (nChaves), que e o caminho do
4444:     * legado para forma NAO-cartao, e a pendencia no gateway e AVISADA ao
4445:     * operador em vez de ser simulada em silencio (CLAUDE.md #27).
4446:     *--------------------------------------------------------------------------
4447:     PROCEDURE CmdCancPagtoClick()
4448:         LOCAL loc_nChave, loc_cIdTef
4449: 
4450:         IF !THIS.cnt_4c__Fpagto.Visible
4451:             RETURN
4452:         ENDIF
4453: 
4454:         IF !USED("xPar")
4455:             RETURN
4456:         ENDIF
4457: 
4458:         SELECT xPar
4459:         GO BOTTOM
4460:         IF EOF() OR EMPTY(NVL(xPar.FPags, ""))
4461:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4462:             RETURN
4463:         ENDIF
4464: 
4465:         loc_nChave = NVL(xPar.nChaves, 0)
4466:         loc_cIdTef = ALLTRIM(NVL(xPar.cnIdTefs, ""))
4467: 
4468:         IF !EMPTY(loc_cIdTef)
4469:             MsgAviso("Esta forma de pagamento tem transa" + CHR(231) + CHR(227) + "o de cart" + CHR(227) + ;
4470:                 "o (TEF) associada." + CHR(13) + ;
4471:                 "O cancelamento no gateway TEF depende do pinpad do caixa e deve ser " + ;
4472:                 "feito na tela de movimenta" + CHR(231) + CHR(227) + "o.", "Cancelar Pagamento")
4473:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4474:             RETURN
4475:         ENDIF
4476: 
4477:         SELECT xPar
4478:         DELETE FOR NVL(nChaves, 0) = loc_nChave
4479:         GO BOTTOM
4480: 
4481:         WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
4482:             .txt_4c_Fpg.Value             = ""
4483:             .txt_4c_Npar.Value            = 0
4484:             .txt_4c_Vpar.Value            = 0
4485:             .txt_4c_Fweditdata_venc.Value = {}
4486:             .Visible     = .T.
4487:         ENDWITH
4488: 
4489:         THIS.RecalcularTotais()
4490:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4491:     ENDPROC
4492: 
4493:     *--------------------------------------------------------------------------
4494:     * [F4] Canc (cmd_4c_Apaga) - cancelamento de ITEM.
4495:     *
4496:     * Legado (Barra_Botoes.apaga.Click, 45 linhas): com cupom fiscal (CupFis
4497:     * em 1/5/6) abre o painel CancelaItem preenchido com o ULTIMO item
4498:     * (Citem - 1); sem cupom fiscal apaga a linha direto do carrinho,
4499:     * renumera os itens e devolve o foco. Os dois caminhos estao aqui; sem
4500:     * crSigCdOpe (cursor do form pai) vale o do caixa fiscal, que e o unico
4501:     * que pede confirmacao antes de apagar.
4502:     *--------------------------------------------------------------------------
4503:     PROCEDURE CmdApagaClick()
4504:         LOCAL loc_nItem, loc_nCupFis, loc_nCont, loc_lAchou
4505: 
4506:         IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value)
4507:             RETURN
4508:         ENDIF
4509: 
4510:         IF !USED("crTpmMvItn")
4511:             RETURN
4512:         ENDIF
4513: 
4514:         loc_nCupFis = 1
4515:         IF USED("crSigCdOpe")
4516:             loc_nCupFis = NVL(crSigCdOpe.CupFis, 1)
4517:         ENDIF
4518: 
4519:         IF INLIST(loc_nCupFis, 1, 5, 6)
4520:             *-- Caminho do caixa fiscal: painel de cancelamento de item.
4521:             SELECT crTpmMvItn
4522:             SET ORDER TO
4523:             loc_nItem = THIS.this_nCItem - 1
4524: 
4525:             LOCATE FOR NVL(citens, 0) = loc_nItem
4526:             loc_lAchou = !EOF()
4527:             IF !loc_lAchou
4528:                 loc_nItem = 0
4529:             ENDIF
4530: 
4531:             WITH THIS.cnt_4c_CancelaItem
4532:                 .txt_4c_Item.Value    = loc_nItem
4533:                 .txt_4c_Produto.Value = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.cpros, "")), "")
4534:                 .txt_4c__dpro.Value   = IIF(loc_lAchou, ALLTRIM(NVL(crTpmMvItn.dpros, "")), "")
4535:                 .txt_4c_Cbarra.Value  = IIF(loc_lAchou, ;
4536:                     ALLTRIM(TRANSFORM(NVL(crTpmMvItn.codbarras, 0))), "")
4537:                 .Visible              = .T.
4538:                 .ZOrder(0)
4539:                 .Refresh()
4540:             ENDWITH
4541: 
4542:             THIS.cnt_4c_Item.Enabled = .F.
4543:             THIS.FocarControle(THIS.cnt_4c_CancelaItem.txt_4c_Item)
4544:         ELSE
4545:             *-- Caminho sem cupom fiscal: apaga a linha e renumera.
4546:             SELECT crTpmMvItn
4547:             IF !EMPTY(NVL(cpros, ""))
4548:                 DELETE
4549:             ENDIF
4550: 
4551:             loc_nCont = 0
4552:             SCAN FOR !DELETED()
4553:                 loc_nCont = loc_nCont + 1
4554:                 REPLACE citens WITH loc_nCont IN crTpmMvItn
4555:             ENDSCAN
4556:             THIS.this_nCItem = loc_nCont
4557: 
4558:             THIS.LimparCamposItem(.T.)

*-- Linhas 4571 a 4749:
4571:     * IsEmpty(crTpmMvItn.CPros) / lAlteraValor = .t. / Get_ValDesc.Value = 0 /
4572:     * Get_PValDesc.Value = 0 / Cnt_val.Get_Valor.SetFocus / EndIf".
4573:     *--------------------------------------------------------------------------
4574:     PROCEDURE CmdAltPrecoClick()
4575:         IF !USED("crTpmMvItn")
4576:             RETURN
4577:         ENDIF
4578: 
4579:         SELECT crTpmMvItn
4580:         IF EMPTY(NVL(crTpmMvItn.cpros, ""))
4581:             RETURN
4582:         ENDIF
4583: 
4584:         THIS.this_lAlteraValor = .T.
4585:         WITH THIS.cnt_4c_Item
4586:             .cnt_4c__vdesc.txt_4c_Valdesc.Value  = 0
4587:             .cnt_4c__pDesc.txt_4c_Pvaldesc.Value = 0
4588:             .Visible     = .T.
4589:         ENDWITH
4590: 
4591:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__val.txt_4c_Valor)
4592:     ENDPROC
4593: 
4594:     *--------------------------------------------------------------------------
4595:     * [F6] Identif. (cmd_4c_Identifica) - abre a tela de identificacao das
4596:     * contas (Origem/Destino/Vendedor/Responsavel).
4597:     *
4598:     * Legado (Barra_Botoes.identifica.Click, 167 linhas): guarda de forma de
4599:     * pagamento em aberto; esconde as outras telas; zera o gate dos botoes;
4600:     * libera a edicao de Origem/Destino quando ainda nao ha sub-nivel nem
4601:     * devolucao lancados; CARREGA nome e CPF das quatro contas via SELECT em
4602:     * SigCdCli; e escolhe qual campo recebe o foco, na ordem Documento ->
4603:     * Pedido -> Tab.Desconto -> Lista de Precos -> Origem -> Destino ->
4604:     * Vendedor -> Responsavel -> Proximo.
4605:     *
4606:     * A cascata de foco do legado e decidida por 12 flags de crSigCdOpe
4607:     * (FixGOrigs/FixCOrigs/FixGDests/.../Numeras/PedClis/TabDescs/LPrecos),
4608:     * cursor do form pai. Sob DataSession = 2 essas flags nao existem aqui: a
4609:     * ordem e mantida, mas testando a VISIBILIDADE e o preenchimento de cada
4610:     * campo, que e o efeito pratico daquelas flags nesta tela.
4611:     *--------------------------------------------------------------------------
4612:     PROCEDURE CmdIdentificaClick()
4613:         IF THIS.HaFormaPagamentoEmAberto()
4614:             RETURN
4615:         ENDIF
4616: 
4617:         THIS.AlternarTelaOperacao("IDENTIFICA")
4618:         THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Visible = .F.
4619: 
4620:         *-- Legado: Origem/Destino voltam a ser editaveis quando nao ha
4621:         *-- sub-nivel lancado ("If CheckDup.Qt = 0 ... EditaDestino = .t. /
4622:         *-- EditaOrigem = .t.").
4623:         IF !THIS.HaSubNivelInformado()
4624:             THIS.this_lEditaDestino = .T.
4625:             THIS.this_lEditaOrigem  = .T.
4626:         ENDIF
4627: 
4628:         THIS.CarregarDadosContasIdentifica()
4629:         THIS.PosicionarFocoIdentifica()
4630:     ENDPROC
4631: 
4632:     *--------------------------------------------------------------------------
4633:     * CarregarDadosContasIdentifica - as quatro consultas do identifica.Click
4634:     * legado ("Select Iclis, Rclis, Cpfs From SigCdCli Where Iclis =
4635:     * '<conta>'" para Origem, Destino, Vendedor e Responsavel, preenchendo
4636:     * Get_dconta e Get_cpf de cada bloco). Bloco com conta vazia tem nome e
4637:     * CPF limpos, como no ELSE do legado.
4638:     *--------------------------------------------------------------------------
4639:     PROTECTED PROCEDURE CarregarDadosContasIdentifica()
4640:         THIS.CarregarContaBloco("Origem")
4641:         THIS.CarregarContaBloco("Destino")
4642:         THIS.CarregarContaBloco("Vendedor")
4643:         THIS.CarregarContaBloco("Responsavel")
4644:     ENDPROC
4645: 
4646:     *--------------------------------------------------------------------------
4647:     * CarregarContaBloco - um dos quatro blocos de identificacao. O nome do
4648:     * container e montado em tempo de execucao ("cnt_4c_" + par_cBloco) e
4649:     * resolvido por EVALUATE UMA VEZ, para uma referencia de objeto: dai em
4650:     * diante os campos sao alcancados por ponto normal. EVALUATE com "=" na
4651:     * string NAO atribuiria nada (CLAUDE.md #15) e Controls("<nome>") nao
4652:     * existe (CLAUDE.md #34).
4653:     *--------------------------------------------------------------------------
4654:     PROTECTED PROCEDURE CarregarContaBloco(par_cBloco)
4655:         LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRes, loc_oErro
4656: 
4657:         loc_oCnt = EVALUATE("THIS.cnt_4c__Identifica.cnt_4c_" + par_cBloco)
4658:         IF VARTYPE(loc_oCnt) != "O"
4659:             RETURN
4660:         ENDIF
4661: 
4662:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
4663: 
4664:         IF EMPTY(loc_cConta)
4665:             loc_oCnt.txt_4c_Dconta.Value = ""
4666:             loc_oCnt.txt_4c_Cpf.Value    = ""
4667:             RETURN
4668:         ENDIF
4669: 
4670:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
4671:             RETURN
4672:         ENDIF
4673: 
4674:         TRY
4675:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli " + ;
4676:                 "WHERE Iclis = " + EscaparSQL(loc_cConta)
4677: 
4678:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaIdent")
4679: 
4680:             IF loc_nRes > 0 AND USED("cursor_4c_ContaIdent")
4681:                 SELECT cursor_4c_ContaIdent
4682:                 IF RECCOUNT("cursor_4c_ContaIdent") > 0
4683:                     GO TOP
4684:                     loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_ContaIdent.Rclis, ""))
4685:                     loc_oCnt.txt_4c_Cpf.Value    = ALLTRIM(NVL(cursor_4c_ContaIdent.Cpfs, ""))
4686:                 ENDIF
4687:             ENDIF
4688: 
4689:             IF USED("cursor_4c_ContaIdent")
4690:                 USE IN cursor_4c_ContaIdent
4691:             ENDIF
4692: 
4693:             loc_oCnt.Refresh()
4694:         CATCH TO loc_oErro
4695:             MsgErro(loc_oErro.Message + CHR(13) + ;
4696:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4697:                 "Procedure: " + loc_oErro.Procedure, ;
4698:                 "Erro ao carregar a conta do bloco " + par_cBloco)
4699:         ENDTRY
4700:     ENDPROC
4701: 
4702:     *--------------------------------------------------------------------------
4703:     * PosicionarFocoIdentifica - cascata de foco do identifica.Click legado,
4704:     * na MESMA ordem: Documento -> Pedido Cliente -> Tab. Desconto -> Lista de
4705:     * Precos -> Origem -> Destino -> Vendedor -> Responsavel -> Proximo. O
4706:     * primeiro campo visivel e ainda vazio leva o foco; nenhum vazio, o foco
4707:     * vai para o botao Proximo, como no ELSE final do legado.
4708:     *--------------------------------------------------------------------------
4709:     PROTECTED PROCEDURE PosicionarFocoIdentifica()
4710:         LOCAL loc_oId
4711:         loc_oId = THIS.cnt_4c__Identifica
4712: 
4713:         DO CASE
4714:             CASE loc_oId.cnt_4c_CodOperacao.Visible AND ;
4715:                     EMPTY(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value)
4716:                 THIS.FocarControle(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo)
4717: 
4718:             CASE loc_oId.cnt_4c_CodOperacao.Visible AND ;
4719:                     EMPTY(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value)
4720:                 THIS.FocarControle(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli)
4721: 
4722:             CASE loc_oId.cnt_4c_TabDesconto.Visible AND ;
4723:                     EMPTY(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value)
4724:                 THIS.FocarControle(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd)
4725: 
4726:             CASE loc_oId.cnt_4c_TabDesconto.Visible AND ;
4727:                     EMPTY(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value)
4728:                 THIS.FocarControle(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco)
4729: 
4730:             CASE loc_oId.cnt_4c_Origem.Visible AND THIS.this_lEditaOrigem AND ;
4731:                     EMPTY(loc_oId.cnt_4c_Origem.txt_4c_Conta.Value)
4732:                 THIS.FocarControle(loc_oId.cnt_4c_Origem.txt_4c_Grupo)
4733: 
4734:             CASE loc_oId.cnt_4c_Destino.Visible AND THIS.this_lEditaDestino AND ;
4735:                     EMPTY(loc_oId.cnt_4c_Destino.txt_4c_Conta.Value)
4736:                 THIS.FocarControle(loc_oId.cnt_4c_Destino.txt_4c_Grupo)
4737: 
4738:             CASE loc_oId.cnt_4c_Vendedor.Visible AND ;
4739:                     EMPTY(loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value)
4740:                 THIS.FocarControle(loc_oId.cnt_4c_Vendedor.txt_4c_Grupo)
4741: 
4742:             CASE loc_oId.cnt_4c_Responsavel.Visible AND ;
4743:                     EMPTY(loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value)
4744:                 THIS.FocarControle(loc_oId.cnt_4c_Responsavel.txt_4c_Grupo)
4745: 
4746:             OTHERWISE
4747:                 THIS.FocarControle(loc_oId.cmd_4c_Proximo)
4748:         ENDCASE
4749:     ENDPROC

*-- Linhas 4764 a 5094:
4764:     * ausencia do painel fica VISIVEL para o operador em vez de virar um beco
4765:     * sem saida silencioso (CLAUDE.md #27).
4766:     *--------------------------------------------------------------------------
4767:     PROCEDURE CmdCreditoClick()
4768:         IF THIS.HaFormaPagamentoEmAberto()
4769:             RETURN
4770:         ENDIF
4771: 
4772:         IF THIS.HaPagamentoPendente()
4773:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
4774:                 "Cr" + CHR(233) + "dito")
4775:             RETURN
4776:         ENDIF
4777: 
4778:         MsgAviso("O painel de Cr" + CHR(233) + "ditos/Devolu" + CHR(231) + CHR(245) + "es foi retirado do " + ;
4779:             "formul" + CHR(225) + "rio legado (SIGMVITS.SCX) e n" + CHR(227) + ;
4780:             "o tem equivalente nesta tela.", "Cr" + CHR(233) + "dito")
4781:     ENDPROC
4782: 
4783:     *--------------------------------------------------------------------------
4784:     * [F8] Crediario (cmd_4c_Financia) - financiamento por carne.
4785:     *
4786:     * Legado (Barra_Botoes.Financia.Click, 42 linhas): mesmas guardas do
4787:     * Credito, esconde as telas e desliga os botoes; o painel CntFinanc esta
4788:     * COMENTADO no SCX e o proprio When do botao devolve .F. incondicional
4789:     * ("PROCEDURE When / RETURN .f."), isto e, o recurso esta DESLIGADO no
4790:     * legado - e por isso que o botao nasce com Visible = .F. (Fase 4).
4791:     *
4792:     * As guardas ficam transcritas e o Click continua ligado (o botao existe);
4793:     * a ausencia do painel e avisada em vez de esvaziar a tela, mesmo criterio
4794:     * do Credito acima.
4795:     *--------------------------------------------------------------------------
4796:     PROCEDURE CmdFinanciaClick()
4797:         IF THIS.HaFormaPagamentoEmAberto()
4798:             RETURN
4799:         ENDIF
4800: 
4801:         IF THIS.HaPagamentoPendente()
4802:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
4803:                 "Credi" + CHR(225) + "rio")
4804:             RETURN
4805:         ENDIF
4806: 
4807:         MsgAviso("O painel de Credi" + CHR(225) + "rio foi retirado do formul" + CHR(225) + "rio legado " + ;
4808:             "(SIGMVITS.SCX) e o recurso est" + CHR(225) + " desligado nesta opera" + CHR(231) + CHR(227) + "o.", ;
4809:             "Credi" + CHR(225) + "rio")
4810:     ENDPROC
4811: 
4812:     *--------------------------------------------------------------------------
4813:     * [F8] Pend. (cmd_4c_Pendencia) - sub-niveis/pendencias da movimentacao.
4814:     *
4815:     * Legado (Barra_Botoes.pendencia.Click, 72 linhas): guardas de forma de
4816:     * pagamento em aberto, de pagamento lancado e de item cancelado ("Existem
4817:     * Itens Cancelados!!! Para Utilizar SubNivel Cancele a Operacao e informe
4818:     * os subniveis primeiro"); esconde as outras telas; zera o gate dos
4819:     * botoes; mostra o painel com a grade de sub-niveis e o botao [F3]Pend.; e
4820:     * escolhe o foco entre a grade e o botao Proximo conforme a grade esteja
4821:     * ou nao habilitada.
4822:     *
4823:     * A grade fica DESABILITADA quando ja existe sub-nivel informado E item ja
4824:     * impresso no cupom ("GradeMultiSubn.Enabled = Not (llSubNivel And
4825:     * llTemItem)") - transcrito. A visibilidade condicionada a
4826:     * crSigCdOpe.SubNs/CrSigOpCdc.HabPends depende de cursores do form pai e,
4827:     * ausentes, nao esconde nada (a tela abre completa, como na operacao que
4828:     * usa sub-nivel).
4829:     *--------------------------------------------------------------------------
4830:     PROCEDURE CmdPendenciaClick()
4831:         LOCAL loc_lSubNivel, loc_lTemItem, loc_lLibera
4832: 
4833:         IF THIS.HaFormaPagamentoEmAberto()
4834:             RETURN
4835:         ENDIF
4836: 
4837:         IF THIS.HaPagamentoPendente()
4838:             MsgAviso("Favor Excluir as Condi" + CHR(231) + CHR(245) + "es de Pagamento!!!", ;
4839:                 "Pend" + CHR(234) + "ncia")
4840:             RETURN
4841:         ENDIF
4842: 
4843:         IF THIS.this_lCancelouItem
4844:             MsgAviso("Existem Itens Cancelados!!! Para Utilizar SubNivel Cancele a " + ;
4845:                 "Opera" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
4846:                 "e informe os subniveis primeiro", "Pend" + CHR(234) + "ncia")
4847:             RETURN
4848:         ENDIF
4849: 
4850:         loc_lSubNivel = THIS.HaSubNivelInformado()
4851:         loc_lTemItem  = .F.
4852:         IF USED("crTpmMvItn")
4853:             SELECT crTpmMvItn
4854:             LOCATE FOR NVL(ImpCupFis, .F.) AND !EMPTY(NVL(cpros, ""))
4855:             loc_lTemItem = !EOF()
4856:         ENDIF
4857: 
4858:         loc_lLibera = !(loc_lSubNivel AND loc_lTemItem)
4859: 
4860:         THIS.AlternarTelaOperacao("PENDENCIA")
4861: 
4862:         WITH THIS.cnt_4c__Pendencia
4863:             .grd_4c_SubNiveis.Visible     = .T.
4864:             .grd_4c_SubNiveis.Enabled     = loc_lLibera
4865:             .cmd_4c_Bot_Pendentes.Visible = .T.
4866:             .cmd_4c_Bot_Pendentes.Enabled = loc_lLibera
4867:         ENDWITH
4868: 
4869:         IF loc_lLibera
4870:             THIS.FocarControle(THIS.cnt_4c__Pendencia.grd_4c_SubNiveis)
4871:         ELSE
4872:             THIS.FocarControle(THIS.cnt_4c__Pendencia.cmd_4c_Proximo)
4873:         ENDIF
4874:     ENDPROC
4875: 
4876:     *--------------------------------------------------------------------------
4877:     * <Ctrl+P> VerPreco (cmd_4c_VerPreco) - consulta de preco.
4878:     *
4879:     * Legado (Barra_Botoes.VerPreco.Click): o corpo do metodo esta INTEIRO
4880:     * comentado ("mena - 26/02/2015 - retirado para testes") e o painel que
4881:     * ele abria (Cnt_Consulta, com Cnt_Prod/Get_Unit/Cnt_Resultado) nao existe
4882:     * na arvore de objetos de SIGMVITS.SCX (layout.json). O botao continua na
4883:     * barra mas, no legado, clicar nele nao faz absolutamente nada - e por
4884:     * isso que o atalho Ctrl+P tambem esta comentado no KeyPress.
4885:     *
4886:     * Handler vazio para copiar esse no-op seria um stub; inventar um painel
4887:     * de consulta violaria o PILAR 1. O Click fica ligado e a ausencia do
4888:     * painel fica VISIVEL, mesmo criterio do Credito e do Crediario.
4889:     *--------------------------------------------------------------------------
4890:     PROCEDURE CmdVerPrecoClick()
4891:         MsgAviso("A consulta de pre" + CHR(231) + "o foi retirada do formul" + CHR(225) + "rio legado " + ;
4892:             "(SIGMVITS.SCX) e n" + CHR(227) + "o tem painel equivalente nesta tela.", ;
4893:             "Consulta de Pre" + CHR(231) + "o")
4894:     ENDPROC
4895: 
4896:     *--------------------------------------------------------------------------
4897:     * [F9] Fiscal (cmd_4c_Impfiscal) - legado (4 linhas): "If Not
4898:     * Wexist('SIGMEFIS') / DO Form SIGMEFIS / Endif" - abre o monitor de
4899:     * status da impressora fiscal. SIGMEFIS conversa direto com o driver do
4900:     * ECF do caixa (nao migrado; e sem o hardware nao ha o que monitorar).
4901:     *--------------------------------------------------------------------------
4902:     PROCEDURE CmdImpfiscalClick()
4903:         MsgAviso("O monitor de status da impressora fiscal (SIGMEFIS) depende do driver " + ;
4904:             "ECF f" + CHR(237) + "sico do caixa, fora do escopo desta migra" + CHR(231) + CHR(227) + "o.", ;
4905:             "Impressora Fiscal")
4906:     ENDPROC
4907: 
4908:     *--------------------------------------------------------------------------
4909:     * [F11] Pagto (cmd_4c_Pagto) - abre a tela de formas de pagamento.
4910:     *
4911:     * Legado (Barra_Botoes.Pagto.Click, 448 linhas): guardas de item nao
4912:     * impresso e de subtotal do ECF (VerifSubTotal), exigencia de cadastro
4913:     * completo do cliente quando o total passa de 10.000 em NFC-e/SAT,
4914:     * abertura do cupom fiscal quando ainda nao aberto, recalculo de todos os
4915:     * totais, montagem do desconto/acrescimo ja aplicado ao documento,
4916:     * configuracao da leitora serial de cheque, carga das formas de pagamento
4917:     * e das parcelas de TEF (xParTef/ParcTef), gate dos botoes, troca de tela
4918:     * e foco na forma de pagamento.
4919:     *
4920:     * Fica nesta fase o que e da TELA: guardas, recalculo dos totais, limpeza
4921:     * dos campos da forma, gate dos botoes e o foco. Abertura de cupom fiscal
4922:     * (VerStatus/AbreCupom/GerarCupom), leitora serial de cheque (ReadComm, o
4923:     * container readcomm do VCX legado) e as parcelas de TEF dependem de
4924:     * hardware do caixa e continuam na tela de movimentacao.
4925:     *--------------------------------------------------------------------------
4926:     PROCEDURE CmdPagtoClick()
4927:         IF THIS.ContarItensLancados() = 0
4928:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens lan" + CHR(231) + "ados para pagamento.", ;
4929:                 "Pagamento")
4930:             RETURN
4931:         ENDIF
4932: 
4933:         *-- Legado: com sub-nivel informado e ItAutos = 8, o item precisa ter
4934:         *-- sido impresso antes de ir para o pagamento.
4935:         IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
4936:                 THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
4937:             MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
4938:                 "Pagamento")
4939:             RETURN
4940:         ENDIF
4941: 
4942:         *-- Legado: a imagem do produto e a da empresa saem da tela ao entrar
4943:         *-- no pagamento ("thisform.cntItem.Cnt_imgProd.Visible = .f.").
4944:         THIS.cnt_4c_Item.cnt_4c__imgProd.Visible = .F.
4945:         THIS.cnt_4c_Item.cnt_4c__ImgEmp.Visible  = .F.
4946: 
4947:         THIS.AlternarTelaOperacao("FPAGTO")
4948:         THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Visible = .F.
4949: 
4950:         *-- Desconto/acrescimo comecam fechados; quem os abre e o botao
4951:         *-- correspondente da barra (legado: "Cnt_Fpagto.Desconto.Visible =
4952:         *-- .F. / Cnt_Fpagto.Acrescimo.Visible = .f.").
4953:         THIS.cnt_4c__Fpagto.cnt_4c_Desconto.Visible  = .F.
4954:         THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.Visible = .F.
4955: 
4956:         WITH THIS.cnt_4c__Fpagto.cnt_4c__forma
4957:             .txt_4c_Fpg.Enabled           = .T.
4958:             .txt_4c_Npar.Enabled          = .T.
4959:             .txt_4c_Vpar.Enabled          = .T.
4960:             .txt_4c_Fpg.Value             = ""
4961:             .txt_4c_Npar.Value            = 0
4962:             .txt_4c_Vpar.Value            = 0
4963:             .txt_4c_Fweditdata_venc.Value = {}
4964:             .Visible     = .T.
4965:         ENDWITH
4966: 
4967:         THIS.RecalcularTotais()
4968:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
4969:     ENDPROC
4970: 
4971:     *--------------------------------------------------------------------------
4972:     * Confirmar (cmd_4c_Ok) - fecha a venda.
4973:     *
4974:     * Legado (Barra_Botoes.ok.Click, 76 linhas): exige impressao dos itens
4975:     * quando ha sub-nivel; exige sub-nivel quando SubnObrigs esta em 1/3;
4976:     * acumula o valor cancelado no form pai; e, conforme o modelo fiscal,
4977:     * chama montaNFc()/montaSatD() (emissao de NFC-e/SAT) ou
4978:     * ParentForm.AcioSalva(), que gravava o documento inteiro com TABLEUPDATE
4979:     * na datasession COMPARTILHADA.
4980:     *
4981:     * Aqui as guardas ficam iguais e a GRAVACAO acontece NESTE form, pelo BO:
4982:     * com DataSession = 2 o carrinho (crTpmMvItn) esta isolado do form pai, e
4983:     * sem gravar aqui os itens morreriam na memoria ao fechar a tela - o
4984:     * Confirmar anunciaria venda fechada sem nada no banco (CLAUDE.md #20 /
4985:     * "sucesso anunciado sem gravar"). A emissao FISCAL (NFC-e/SAT/cupom)
4986:     * continua na tela de movimentacao, que e quem tem a impressora.
4987:     *--------------------------------------------------------------------------
4988:     PROCEDURE BtnConfirmarClick()
4989:         LOCAL loc_nItens, loc_lTemPagamento
4990: 
4991:         loc_nItens = THIS.ContarItensLancados()
4992: 
4993:         *-- Sem item nenhum o Confirmar so encerra a tela: e o que o legado faz
4994:         *-- com carrinho vazio, e evita gravar documento sem item.
4995:         IF loc_nItens = 0
4996:             THIS.Release()
4997:             RETURN
4998:         ENDIF
4999: 
5000:         IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
5001:                 THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
5002:             MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
5003:                 "Confirmar")
5004:             RETURN
5005:         ENDIF
5006: 
5007:         loc_lTemPagamento = .F.
5008:         IF USED("xPar")
5009:             SELECT xPar
5010:             LOCATE FOR !EMPTY(NVL(FPags, ""))
5011:             loc_lTemPagamento = !EOF()
5012:         ENDIF
5013: 
5014:         IF !loc_lTemPagamento
5015:             MsgAviso("Informe a forma de pagamento antes de confirmar a venda.", "Confirmar")
5016:             THIS.CmdPagtoClick()
5017:             RETURN
5018:         ENDIF
5019: 
5020:         *-- Falhando a gravacao, NAO fecha a tela e NAO anuncia sucesso: o
5021:         *-- caixa fica com o carrinho na tela para corrigir e repetir.
5022:         *-- BusinessBase.Salvar() ja exibiu o motivo (CLAUDE.md #20).
5023:         IF !THIS.GravarDocumento()
5024:             RETURN
5025:         ENDIF
5026: 
5027:         MsgInfo("Venda gravada com sucesso." + CHR(13) + ;
5028:             "A finaliza" + CHR(231) + CHR(227) + "o fiscal prossegue na tela de " + ;
5029:             "movimenta" + CHR(231) + CHR(227) + "o.", "Confirmar")
5030:         THIS.Release()
5031:     ENDPROC
5032: 
5033:     *--------------------------------------------------------------------------
5034:     * FormParaBO - leva os campos da tela (cabecalho do cupom) para as
5035:     * propriedades do BO, na mesma nomenclatura de sigmvitsBO.prg. So os
5036:     * campos que EXISTEM nesta tela (SIGMVITS e um container filho do PDV;
5037:     * os demais campos de SigMvCab pertencem a tela de movimentacao, form
5038:     * pai que ainda nao foi migrado) - o resto fica com o default do BO.
5039:     *
5040:     * Empresa/Data: SIGMVITS.SCX nao tem campo proprio para isso (vinham de
5041:     * TprMvCab, cursor do form pai) - aqui usam go_4c_Sistema/DATETIME(),
5042:     * unica fonte disponivel nesta tela isolada.
5043:     *
5044:     * Documento (txt_4c_Codigo): o ControlSource do legado (TprMvCab.mascnum)
5045:     * e so o que o campo EXIBE - o Valid legado grava o digitado em
5046:     * TprMvCab.Numes (Replace TprMvCab.Numes With fRetornaInt(This.Value)),
5047:     * entao o valor numerico vai para this_nNumes, nao this_cMascnum.
5048:     *
5049:     * Desconto/Acrescimo/Vars: MESMA formula ja usada em RecalcularTotais()
5050:     * (nao recalculada de outro jeito) - valvars negativo em desconto,
5051:     * positivo em acrescimo (CLAUDE.md #17 - formula transcrita, nao
5052:     * reescrita).
5053:     *--------------------------------------------------------------------------
5054:     PROTECTED PROCEDURE FormParaBO()
5055:         LOCAL loc_oBO, loc_oId, loc_oFp, loc_nTotal, loc_nLiquido, loc_nFormas
5056:         LOCAL loc_nDesc, loc_nAcre, loc_nDescP, loc_nVarLiq
5057: 
5058:         loc_oBO = THIS.this_oBusinessObject
5059:         loc_oId = THIS.cnt_4c__Identifica
5060:         loc_oFp = THIS.cnt_4c__Fpagto
5061: 
5062:         *-- Empresa / data do movimento (unica fonte disponivel nesta tela).
5063:         loc_oBO.this_cEmps  = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
5064:         loc_oBO.this_cEmpds = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
5065:         loc_oBO.this_cNemps = LEFT(ALLTRIM(go_4c_Sistema.cEmpresa), 40)
5066:         loc_oBO.this_dDatas = DATETIME()
5067: 
5068:         *-- Documento / Pedido Cliente (Cnt_Identifica.CodOperacao).
5069:         loc_oBO.this_nNumes    = ALLTRIM(loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value)
5070:         loc_oBO.this_nNpedclis = ALLTRIM(loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value)
5071: 
5072:         *-- Identificacao: Destino/Responsavel/Vendedor/Origem (grupo+conta).
5073:         loc_oBO.this_cGrupods = LEFT(ALLTRIM(loc_oId.cnt_4c_Destino.txt_4c_Grupo.Value), 10)
5074:         loc_oBO.this_cContads = LEFT(ALLTRIM(loc_oId.cnt_4c_Destino.txt_4c_Conta.Value), 10)
5075:         loc_oBO.this_cGrresps = LEFT(ALLTRIM(loc_oId.cnt_4c_Responsavel.txt_4c_Grupo.Value), 10)
5076:         loc_oBO.this_cResps   = LEFT(ALLTRIM(loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value), 10)
5077:         loc_oBO.this_cGrvends = LEFT(ALLTRIM(loc_oId.cnt_4c_Vendedor.txt_4c_Grupo.Value), 10)
5078:         loc_oBO.this_cVends   = LEFT(ALLTRIM(loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value), 10)
5079:         loc_oBO.this_cGrupoos = LEFT(ALLTRIM(loc_oId.cnt_4c_Origem.txt_4c_Grupo.Value), 10)
5080:         loc_oBO.this_cContaos = LEFT(ALLTRIM(loc_oId.cnt_4c_Origem.txt_4c_Conta.Value), 10)
5081: 
5082:         *-- Tabela de desconto / Lista de precos.
5083:         loc_oBO.this_cTabds   = LEFT(ALLTRIM(loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value), 10)
5084:         loc_oBO.this_cLprecos = LEFT(ALLTRIM(loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value), 30)
5085: 
5086:         *-- Totais (ja calculados por RecalcularTotais - so leitura aqui).
5087:         loc_nDesc  = loc_oFp.cnt_4c_Desconto.txt_4c_TotVariacao.Value
5088:         loc_nAcre  = loc_oFp.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value
5089:         loc_nDescP = loc_oFp.cnt_4c__descp.txt_4c_Tvariacao.Value
5090:         loc_nTotal = loc_oFp.cnt_4c__tot.txt_4c_Valinic.Value
5091:         loc_nLiquido = loc_oFp.cnt_4c__saldo.txt_4c_TotLiquido.Value
5092:         loc_nFormas  = loc_oFp.cnt_4c__pag.txt_4c_TotForma.Value
5093: 
5094:         *-- valvars: negativo em desconto, positivo em acrescimo (legado:

*-- Linhas 5145 a 5188:
5145:     * unica, sem uma segunda consulta que possa divergir.
5146:     *
5147:     * Escopo: PROTECTED por HERANCA - FormBase.prg declara "PROTECTED
5148:     * PROCEDURE BOParaForm()" e o VFP9 nao deixa a subclasse alargar isso.
5149:     * Medido: PEMSTATUS(oForm, "BOParaForm", 5) devolve .T. e a chamada de
5150:     * FORA da classe estoura "Property BOPARAFORM is not found" (CLAUDE.md
5151:     * #3). E o escopo certo - quem o chama e o proprio FormBase (linha 235),
5152:     * de dentro da hierarquia; o harness de teste nao chama este metodo.
5153:     *--------------------------------------------------------------------------
5154:     FUNCTION BOParaForm()
5155:         LOCAL loc_oBO, loc_oId, loc_oFp, loc_nVar, loc_lOk
5156: 
5157:         loc_lOk = .F.
5158:         loc_oBO = THIS.this_oBusinessObject
5159: 
5160:         IF VARTYPE(loc_oBO) = "O"
5161:             loc_oId = THIS.cnt_4c__Identifica
5162:             loc_oFp = THIS.cnt_4c__Fpagto
5163: 
5164:             *-- Documento / Pedido Cliente. Zero e "documento ainda sem
5165:             *-- numero": o legado exibe branco, nao o algarismo 0.
5166:             loc_oId.cnt_4c_CodOperacao.txt_4c_Codigo.Value = ;
5167:                 IIF(loc_oBO.this_nNumes = 0, "", ALLTRIM(TRANSFORM(loc_oBO.this_nNumes)))
5168:             loc_oId.cnt_4c_CodOperacao.txt_4c_PedCli.Value = ;
5169:                 IIF(loc_oBO.this_nNpedclis = 0, "", ALLTRIM(TRANSFORM(loc_oBO.this_nNpedclis)))
5170: 
5171:             *-- Identificacao: os quatro blocos (grupo + conta).
5172:             loc_oId.cnt_4c_Destino.txt_4c_Grupo.Value     = ALLTRIM(loc_oBO.this_cGrupods)
5173:             loc_oId.cnt_4c_Destino.txt_4c_Conta.Value     = ALLTRIM(loc_oBO.this_cContads)
5174:             loc_oId.cnt_4c_Responsavel.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrresps)
5175:             loc_oId.cnt_4c_Responsavel.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cResps)
5176:             loc_oId.cnt_4c_Vendedor.txt_4c_Grupo.Value    = ALLTRIM(loc_oBO.this_cGrvends)
5177:             loc_oId.cnt_4c_Vendedor.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cVends)
5178:             loc_oId.cnt_4c_Origem.txt_4c_Grupo.Value      = ALLTRIM(loc_oBO.this_cGrupoos)
5179:             loc_oId.cnt_4c_Origem.txt_4c_Conta.Value      = ALLTRIM(loc_oBO.this_cContaos)
5180: 
5181:             *-- Tabela de desconto / Lista de precos.
5182:             loc_oId.cnt_4c_TabDesconto.txt_4c_Tabd.Value       = ALLTRIM(loc_oBO.this_cTabds)
5183:             loc_oId.cnt_4c_TabDesconto.txt_4c_ListaPreco.Value = ALLTRIM(loc_oBO.this_cLprecos)
5184: 
5185:             *-- Variacao: um campo do banco, duas caixas na tela.
5186:             loc_nVar = loc_oBO.this_nValvars
5187:             loc_oFp.cnt_4c_Desconto.txt_4c_TotVariacao.Value  = IIF(loc_nVar < 0, -loc_nVar, 0)
5188:             loc_oFp.cnt_4c_Acrescimo.txt_4c_TotVariacao.Value = IIF(loc_nVar > 0, loc_nVar, 0)

*-- Linhas 5319 a 5340:
5319:             *-- 2) Rodape: total de itens, TOTAL, formas, recebido e troco.
5320:             loc_nQtItem = 0
5321:             SELECT crTpmMvItn
5322:             SUM NVL(qtds, 0) FOR !DELETED() TO loc_nQtItem
5323: 
5324:             loc_nTotLiq   = THIS.cnt_4c__Fpagto.cnt_4c__saldo.txt_4c_TotLiquido.Value
5325:             loc_nTotForma = THIS.cnt_4c__Fpagto.cnt_4c__pag.txt_4c_TotForma.Value
5326: 
5327:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5328:                 VALUES (1001, 0, REPLICATE("-", 47), 0)
5329:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5330:                 VALUES (1001, 1, "TI:" + TRANSFORM(loc_nQtItem, "@z 9,999.99"), 1)
5331:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5332:                 VALUES (1002, 1, "", 1)
5333:             INSERT INTO crTpmMvItnC (cItens, Linha, Texto, Cores) ;
5334:                 VALUES (1003, 2, PADR("..TOTAL", 33) + ;
5335:                     TRANSFORM(loc_nTotLiq, "@Z 999,999,999.99"), 1)
5336: 
5337:             loc_nBcd  = 0
5338:             loc_nItem = 1004
5339: 
5340:             IF USED("xPar")

*-- Linhas 5419 a 5439:
5419:             *-- legado sempre faz (CLAUDE.md #21a).
5420:             SELECT crTpmMvItnC
5421:             SET ORDER TO
5422:             GO TOP
5423:             THIS.cnt_4c_Grade.grd_4c_Cupom.Refresh()
5424:             THIS.cnt_4c__Pendencia.grd_4c_SubNiveis.Refresh()
5425: 
5426:             *-- Legado encerra o AtuaCupom limpando a linha de mensagem.
5427:             THIS.ExibirMensagem("")
5428: 
5429:             IF loc_nAreaAnt > 0
5430:                 SELECT (loc_nAreaAnt)
5431:             ELSE
5432:                 SELECT crTpmMvItn
5433:             ENDIF
5434: 
5435:             loc_lOk = .T.
5436:         ENDIF
5437: 
5438:         RETURN loc_lOk
5439:     ENDFUNC

*-- Linhas 5459 a 5796:
5459:         CATCH TO loc_oErro
5460:             MsgErro(loc_oErro.Message + CHR(13) + ;
5461:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5462:                 "Procedure: " + loc_oErro.Procedure, "Erro ao gravar o documento")
5463:             loc_lOk = .F.
5464:         ENDTRY
5465: 
5466:         RETURN loc_lOk
5467:     ENDFUNC
5468: 
5469:     *--------------------------------------------------------------------------
5470:     * Cancelar (cmd_4c_Cancela, Cancel = .T. / ESC) - encerra o Caixa.
5471:     *
5472:     * Legado (Barra_Botoes.Cancela.Click, 29 linhas): fecha as telas
5473:     * auxiliares SIGPRDFT/SigCrTef se estiverem abertas; bloqueia o
5474:     * cancelamento enquanto ha produto sendo digitado ("If Not
5475:     * Empty(Get_Produto.Value) / Return .f."); exige impressao dos itens
5476:     * quando ha sub-nivel; acumula o valor cancelado; e chama
5477:     * ParentForm.AcioCancela(.t.).
5478:     *
5479:     * AcioCancela e do form pai (estorna o documento e libera o caixa). Aqui o
5480:     * cancelamento fecha esta tela e devolve o controle a tela de
5481:     * movimentacao, com confirmacao do operador antes - o carrinho esta em
5482:     * cursor local e sai da memoria junto.
5483:     *--------------------------------------------------------------------------
5484:     PROCEDURE BtnCancelarClick()
5485:         IF !EMPTY(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value)
5486:             RETURN
5487:         ENDIF
5488: 
5489:         IF THIS.HaSubNivelInformado() AND THIS.HaItemNaoImpresso() AND ;
5490:                 THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
5491:             MsgAviso("Obrigat" + CHR(243) + "rio Impress" + CHR(227) + "o dos Itens... Click <F2>", ;
5492:                 "Cancelar")
5493:             RETURN
5494:         ENDIF
5495: 
5496:         IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
5497:             THIS.Release()
5498:         ENDIF
5499:     ENDPROC
5500: 
5501:     *--------------------------------------------------------------------------
5502:     * BtnEncerrarClick - nome canonico de encerramento. SIGMVITS.SCX nao tem
5503:     * botao Encerrar/Fechar/Sair: a saida e o proprio Cancelar
5504:     * (Barra_Botoes.Cancela, Cancel = .T.). Nenhum botao novo e criado
5505:     * (PILAR 1) - este metodo so da o nome canonico que TesteAutomatico.prg
5506:     * procura por PEMSTATUS.
5507:     *--------------------------------------------------------------------------
5508:     PROCEDURE BtnEncerrarClick()
5509:         THIS.BtnCancelarClick()
5510:     ENDPROC
5511: 
5512:     *==========================================================================
5513:     * HANDLERS - BOTOES DAS TELAS DE OPERACAO
5514:     *==========================================================================
5515: 
5516:     *--------------------------------------------------------------------------
5517:     * [F3]Pend. (cnt_4c__Pendencia.cmd_4c_Bot_Pend) - legado (13 linhas):
5518:     * exige conta de ORIGEM quando crSigOpCdi.OrigDest = 1; limpa as linhas
5519:     * com codigo zerado ("Select TmpOperacao / Delete For Codigos = 0"); e
5520:     * abre SigOpPen, a tela de selecao de pendencias do cliente, que nao tem
5521:     * equivalente migrado. A limpeza local acontece de todo modo.
5522:     *--------------------------------------------------------------------------
5523:     PROCEDURE CmdBotPendentesClick()
5524:         IF EMPTY(THIS.cnt_4c__Identifica.cnt_4c_Origem.txt_4c_Conta.Value)
5525:             MsgAviso("Conta de Origem Obrigat" + CHR(243) + "ria!", "Aviso")
5526:             THIS.CmdIdentificaClick()
5527:             RETURN
5528:         ENDIF
5529: 
5530:         IF !USED("TmpOperacao")
5531:             RETURN
5532:         ENDIF
5533: 
5534:         SELECT TmpOperacao
5535:         DELETE FOR NVL(Codigos, 0) = 0
5536:         GO TOP
5537: 
5538:         THIS.RecalcularTotais()
5539:     ENDPROC
5540: 
5541:     *--------------------------------------------------------------------------
5542:     * Painel de cancelamento de item - Ok (cnt_4c_CancelaItem.cmd_4c_Ok).
5543:     *
5544:     * Legado (CancelaItem.ok.Click, 52 linhas): pede senha de supervisor ("Do
5545:     * Form SigOpSen With 'CANCITEM' ..."), chama ParentForm.Cancel_Item_Gen()
5546:     * e replica o cancelamento em CQSigExMvi/CQSigExMvc (tabelas de exportacao
5547:     * fiscal do PAF) antes de atualizar o cupom.
5548:     *
5549:     * SigOpSen (senha) nao tem equivalente migrado - MsgConfirma faz o papel do
5550:     * gate. A replicacao nas tabelas de exportacao fiscal e do form pai. O que
5551:     * e desta tela - remover o item do carrinho, marcar que houve cancelamento
5552:     * (UltimoCancel/CancelouItem, que o legado usa para renumerar e para
5553:     * bloquear sub-nivel depois) e recalcular - fica aqui.
5554:     *--------------------------------------------------------------------------
5555:     PROCEDURE CancelaItemOkClick()
5556:         LOCAL loc_nItem
5557: 
5558:         loc_nItem = THIS.cnt_4c_CancelaItem.txt_4c_Item.Value
5559: 
5560:         IF loc_nItem <= 0 OR !USED("crTpmMvItn")
5561:             THIS.FecharPainelCancelaItem()
5562:             RETURN
5563:         ENDIF
5564: 
5565:         IF !MsgConfirma("Confirma o cancelamento do item " + ALLTRIM(TRANSFORM(loc_nItem)) + "?", ;
5566:                 "Cancelamento de Item")
5567:             THIS.FecharPainelCancelaItem()
5568:             RETURN
5569:         ENDIF
5570: 
5571:         SELECT crTpmMvItn
5572:         SET ORDER TO
5573:         LOCATE FOR NVL(citens, 0) = loc_nItem
5574:         IF EOF()
5575:             MsgAviso("Item n" + CHR(227) + "o encontrado!!!", "Cancelamento de Item")
5576:             THIS.FecharPainelCancelaItem()
5577:             RETURN
5578:         ENDIF
5579: 
5580:         DELETE
5581: 
5582:         *-- Legado: "UltimoCancel = Iif(Get_item.Value > UltimoCancel,
5583:         *-- Get_item.Value, UltimoCancel)" - guarda o maior item cancelado
5584:         *-- para a renumeracao nao reaproveitar o numero.
5585:         THIS.this_nUltimoCancel = MAX(THIS.this_nUltimoCancel, loc_nItem)
5586:         THIS.this_lCancelouItem = .T.
5587: 
5588:         *-- As linhas de texto do cupom daquele item saem da grade junto.
5589:         IF USED("crTpmMvItnC")
5590:             SELECT crTpmMvItnC
5591:             DELETE FOR NVL(cItens, 0) = loc_nItem
5592:             GO TOP
5593:         ENDIF
5594: 
5595:         THIS.RecalcularTotais()
5596:         THIS.FecharPainelCancelaItem()
5597:     ENDPROC
5598: 
5599:     *--------------------------------------------------------------------------
5600:     * Painel de cancelamento de item - CancelaDisp (cmd_4c_CancelaDisp).
5601:     * Legado (6 linhas): "Select crTpmMvItn / Set Order To / CntItem.Enabled =
5602:     * .T. / CancelaItem.Visible = .f. / Get_Produto.Setfocus" - fecha o painel
5603:     * SEM cancelar nada.
5604:     *--------------------------------------------------------------------------
5605:     PROCEDURE CancelaItemCancelaDispClick()
5606:         IF USED("crTpmMvItn")
5607:             SELECT crTpmMvItn
5608:             SET ORDER TO
5609:         ENDIF
5610:         THIS.FecharPainelCancelaItem()
5611:     ENDPROC
5612: 
5613:     *--------------------------------------------------------------------------
5614:     * FecharPainelCancelaItem - fecha o painel e devolve o controle a tela de
5615:     * itens. Compartilhado pelo Ok (apos processar) e pelo CancelaDisp.
5616:     *--------------------------------------------------------------------------
5617:     PROTECTED PROCEDURE FecharPainelCancelaItem()
5618:         THIS.cnt_4c_CancelaItem.Visible = .F.
5619:         THIS.cnt_4c_Item.Enabled        = .T.
5620:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto)
5621:     ENDPROC
5622: 
5623:     *--------------------------------------------------------------------------
5624:     * Proximo - o mesmo botao "seta" existe em quatro telas (cnt_4c_Item,
5625:     * cnt_4c__Pendencia, cnt_4c__Fpagto, cnt_4c__Identifica) e em todas ele
5626:     * AVANCA para a etapa seguinte do fluxo do caixa. Legado:
5627:     *
5628:     *   CntItem.Proximo.Click        -> Barra_Botoes.Pagto.Click()
5629:     *   Cnt_Identifica.Proximo.Click -> Itens.Click() e, com Itens
5630:     *                                   desabilitado, Pagto.Click()
5631:     *   Cnt_Pendencia.Proximo.Click  -> limpa o sub-nivel zerado e segue
5632:     *   Cnt_Fpagto.Proximo.Click     -> foco no Confirmar quando o saldo esta
5633:     *                                   zerado, senao volta para a forma
5634:     *
5635:     * Cada tela tem o seu handler porque o destino e diferente; a troca de
5636:     * icone (b_arrow1/b_arrow2) tambem e do legado.
5637:     *--------------------------------------------------------------------------
5638:     PROCEDURE ItemProximoClick()
5639:         THIS.CmdPagtoClick()
5640:     ENDPROC
5641: 
5642:     PROCEDURE IdentificaProximoClick()
5643:         IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Enabled
5644:             THIS.CmdItensClick()
5645:         ELSE
5646:             THIS.CmdPagtoClick()
5647:         ENDIF
5648:     ENDPROC
5649: 
5650:     PROCEDURE PendenciaProximoClick()
5651:         *-- Legado (Cnt_Pendencia.Proximo.Click): limpa as linhas zeradas do
5652:         *-- sub-nivel e segue para os itens.
5653:         IF USED("TmpOperacao")
5654:             SELECT TmpOperacao
5655:             DELETE FOR NVL(Codigos, 0) = 0
5656:             GO TOP
5657:         ENDIF
5658: 
5659:         THIS.CmdItensClick()
5660:     ENDPROC
5661: 
5662:     PROCEDURE FpagtoProximoClick()
5663:         IF THIS.cnt_4c__Fpagto.cnt_4c__apag.txt_4c_Saldo.Value <= 0
5664:             THIS.FocarControle(THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok)
5665:         ELSE
5666:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c__forma.txt_4c_Fpg)
5667:         ENDIF
5668:     ENDPROC
5669: 
5670:     *==========================================================================
5671:     * TIMER - barra de titulo
5672:     *==========================================================================
5673: 
5674:     *--------------------------------------------------------------------------
5675:     * TimerAtualizarTitulo - legado (Timer1.Procedure, 6 linhas): reescreve
5676:     * TxtCaption a cada segundo com data/hora, operacao, numero do documento,
5677:     * caixa e operador. O nome completo do operador vinha de SigCdUsu.nComps
5678:     * por CursorQuery; aqui o operador e gc_4c_UsuarioLogado, e operacao/numero
5679:     * vem do BO (as mesmas colunas dopes/numes que o legado lia de TprMvCab).
5680:     * O numero do caixa estava em crSigFiMpf, cursor do form pai - ausente,
5681:     * sai vazio, como no proprio Iif(Used(...)) do legado.
5682:     *--------------------------------------------------------------------------
5683:     PROCEDURE TimerAtualizarTitulo()
5684:         LOCAL loc_cCaixa, loc_cDope, loc_nNume
5685: 
5686:         loc_cCaixa = ""
5687:         IF USED("crSigFiMpf")
5688:             loc_cCaixa = ALLTRIM(NVL(crSigFiMpf.cnCaixas, ""))
5689:         ENDIF
5690: 
5691:         loc_cDope = ""
5692:         loc_nNume = 0
5693:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5694:             loc_cDope = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
5695:             loc_nNume = THIS.this_oBusinessObject.this_nNumes
5696:         ENDIF
5697: 
5698:         THIS.lbl_4c_TxtCaption.Caption = "   [ " + DTOC(DATE()) + " " + TIME() + " ]   " + ;
5699:             loc_cDope + "   [ No : " + STR(loc_nNume, 6) + " ] " + SPACE(10) + ;
5700:             "Caixa: " + loc_cCaixa + SPACE(10) + ;
5701:             "Operador(a) : " + ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
5702:     ENDPROC
5703: 
5704:     *==========================================================================
5705:     * KEYPRESS DO FORM (KeyPreview = .T.) - atalhos de teclado
5706:     *==========================================================================
5707: 
5708:     *--------------------------------------------------------------------------
5709:     * KeyPress - transcricao do SIGMVITS.KeyPress (143 linhas). O legado
5710:     * despacha cada tecla para o Click do botao correspondente; aqui o
5711:     * despacho vai para o METODO do Click - mesmo efeito, sem depender do
5712:     * BINDEVENT para a chamada programatica.
5713:     *
5714:     * Codigos de tecla como no legado (form com KeyPreview = .T.): F2 = -1,
5715:     * F3 = -2, F4 = -3, F5 = -4, F6 = -5, F8 = -7, F9 = -8, F11 = 133,
5716:     * Ctrl+F3 = 96. F7 (-6, Credito), Ctrl+P (16, VerPreco) e Ctrl+K (11,
5717:     * calculadora) estao COMENTADOS no legado e por isso NAO sao despachados
5718:     * aqui - o botao continua clicavel, so nao tem atalho, igual ao legado.
5719:     *
5720:     * As guardas de cada Case sao as do legado: "Empty(lcItem)" (nada sendo
5721:     * digitado no campo Produto), o botao habilitado e a tela certa visivel. O
5722:     * bloco externo tambem e o do legado: nada e despachado enquanto o painel
5723:     * do cheque/TEF ou o de cancelamento de item estiver aberto.
5724:     *--------------------------------------------------------------------------
5725:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5726:         LOCAL loc_oBarra, loc_cItem, loc_lItemVisivel, loc_lFpagtoVisivel
5727: 
5728:         loc_oBarra = THIS.cnt_4c_Barra_Botoes
5729:         loc_cItem  = THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Value
5730: 
5731:         IF THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Visible OR THIS.cnt_4c_CancelaItem.Visible
5732:             RETURN
5733:         ENDIF
5734: 
5735:         loc_lItemVisivel   = THIS.cnt_4c_Item.Visible
5736:         loc_lFpagtoVisivel = THIS.cnt_4c__Fpagto.Visible
5737: 
5738:         DO CASE
5739:             *-- F3 na tela de pendencias: [F3]Pend. (tratado ANTES do bloco
5740:             *-- geral, como no primeiro Do Case do legado).
5741:             CASE par_nKeyCode = -2 AND THIS.cnt_4c__Pendencia.Visible AND ;
5742:                     THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes.Enabled
5743:                 NODEFAULT
5744:                 THIS.CmdBotPendentesClick()
5745: 
5746:             *-- F2 - Itens
5747:             CASE par_nKeyCode = -1 AND loc_oBarra.cmd_4c_Itens.Enabled AND EMPTY(loc_cItem)
5748:                 NODEFAULT
5749:                 THIS.CmdItensClick()
5750: 
5751:             *-- F3 - Qtde (tela de itens)
5752:             CASE par_nKeyCode = -2 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_Alteraqtd.Enabled AND ;
5753:                     THIS.cnt_4c_Item.cnt_4c__Prod.txt_4c_Produto.Enabled AND EMPTY(loc_cItem)
5754:                 NODEFAULT
5755:                 THIS.CmdAlteraqtdClick()
5756: 
5757:             *-- F4 - Cancelar item (tela de itens)
5758:             CASE par_nKeyCode = -3 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_Apaga.Enabled AND ;
5759:                     !THIS.this_lAlteraQtd AND EMPTY(loc_cItem)
5760:                 NODEFAULT
5761:                 THIS.CmdApagaClick()
5762: 
5763:             *-- F5 - Alterar preco (tela de itens)
5764:             CASE par_nKeyCode = -4 AND loc_lItemVisivel AND loc_oBarra.cmd_4c_AltPreco.Enabled
5765:                 NODEFAULT
5766:                 THIS.CmdAltPrecoClick()
5767: 
5768:             *-- F4 - Cancelar forma de pagamento (tela de pagamento)
5769:             CASE par_nKeyCode = -3 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_CancPagto.Enabled
5770:                 NODEFAULT
5771:                 THIS.CmdCancPagtoClick()
5772: 
5773:             *-- F3 - Desconto (tela de pagamento, com total diferente de zero)
5774:             CASE par_nKeyCode = -2 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_Desconto.Enabled AND ;
5775:                     THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic.Value <> 0
5776:                 NODEFAULT
5777:                 THIS.CmdDescontoClick()
5778: 
5779:             *-- Ctrl+F3 - Acrescimo (tela de pagamento, com total diferente de zero)
5780:             CASE par_nKeyCode = 96 AND loc_lFpagtoVisivel AND loc_oBarra.cmd_4c_Acrescimo.Enabled AND ;
5781:                     THIS.cnt_4c__Fpagto.cnt_4c__tot.txt_4c_Valinic.Value <> 0
5782:                 NODEFAULT
5783:                 THIS.CmdAcrescimoClick()
5784: 
5785:             *-- F6 - Identificacao
5786:             CASE par_nKeyCode = -5 AND loc_oBarra.cmd_4c_Identifica.Enabled AND EMPTY(loc_cItem)
5787:                 NODEFAULT
5788:                 THIS.CmdIdentificaClick()
5789: 
5790:             *-- F8 - Pendencia / Crediario (o legado tem os dois no mesmo F8:
5791:             *-- o Case de Pendencia vem primeiro e so cai no Crediario quando
5792:             *-- Financia esta habilitado).
5793:             CASE par_nKeyCode = -7 AND loc_oBarra.cmd_4c_Pendencia.Enabled AND EMPTY(loc_cItem)
5794:                 NODEFAULT
5795:                 THIS.CmdPendenciaClick()
5796: 

*-- Linhas 5811 a 5873:
5811:     ENDPROC
5812: 
5813:     *==========================================================================
5814:     * REGISTRO DOS EVENTOS (BINDEVENT)
5815:     *==========================================================================
5816: 
5817:     *--------------------------------------------------------------------------
5818:     * RegistrarEventosPrincipais - liga o Click de cada botao ao seu handler.
5819:     * Chamado no fim do InicializarForm, quando TODOS os controles ja existem:
5820:     * BINDEVENT contra objeto inexistente estoura no Init e o form nao abre.
5821:     *
5822:     * O When de cada botao NAO e ligado por BINDEVENT: o retorno de um When
5823:     * delegado e DESCARTADO pelo VFP (CLAUDE.md #3) e nao bloqueia nada - por
5824:     * isso a condicao do When legado e checada no inicio do proprio Click, e o
5825:     * gate de Enabled vive em AjustarBotoesPorModo().
5826:     *--------------------------------------------------------------------------
5827:     PROTECTED PROCEDURE RegistrarEventosPrincipais
5828:         LOCAL loc_oBarra
5829: 
5830:         *-- Barra de botoes principal (os 16 botoes do legado).
5831:         loc_oBarra = THIS.cnt_4c_Barra_Botoes
5832:         BINDEVENT(loc_oBarra.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
5833:         BINDEVENT(loc_oBarra.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
5834:         BINDEVENT(loc_oBarra.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
5835:         BINDEVENT(loc_oBarra.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
5836:         BINDEVENT(loc_oBarra.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
5837:         BINDEVENT(loc_oBarra.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
5838:         BINDEVENT(loc_oBarra.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
5839:         BINDEVENT(loc_oBarra.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
5840:         BINDEVENT(loc_oBarra.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
5841:         BINDEVENT(loc_oBarra.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
5842:         BINDEVENT(loc_oBarra.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
5843:         BINDEVENT(loc_oBarra.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
5844:         BINDEVENT(loc_oBarra.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
5845:         BINDEVENT(loc_oBarra.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
5846:         BINDEVENT(loc_oBarra.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
5847:         BINDEVENT(loc_oBarra.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
5848: 
5849:         *-- Painel de pendencias/sub-niveis.
5850:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Bot_Pendentes, "Click", THIS, "CmdBotPendentesClick")
5851:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,       "Click", THIS, "PendenciaProximoClick")
5852: 
5853:         *-- Painel de cancelamento de item.
5854:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
5855:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")
5856: 
5857:         *-- Botao "Proximo" das demais telas de operacao.
5858:         BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
5859:         BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")
5860:         BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")
5861: 
5862:         *-- Timer da barra de titulo (legado: Timer1.Interval = 1000).
5863:         BINDEVENT(THIS.obj_4c_Timer1, "Timer", THIS, "TimerAtualizarTitulo")
5864:         THIS.obj_4c_Timer1.Enabled = .T.
5865:     ENDPROC
5866: 
5867:     *==========================================================================
5868:     PROCEDURE Destroy
5869:     *==========================================================================
5870:         DODEFAULT()
5871:     ENDPROC
5872: 
5873: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigmvitsBO.prg):
*===============================================================================
* sigmvitsBO.prg - Business Object para Caixa (Frente de Loja / PDV)
* Tabela principal: SigMvCab (cabecalho do movimento/cupom em processamento)
* PK tecnica: empdopnums char(29) = Emps + Dopes + Str(Numes,6)
* Origem legado: SIGMVITS ("Caixa"), pagina/container filho do PDV completo
* Tabelas relacionadas usadas pelo legado (fases seguintes): crTpmMvItn (SigMvItn,
* itens do cupom), SigOpFp/SigOpFpi (formas de pagamento), SigFiFis/SigFiMpf
* (config. fiscal da impressora), SigCdCli (identificacao do cliente/conta),
* SigCdOpe (config. da operacao), SigCdPam (parametros gerais do sistema)
*===============================================================================
DEFINE CLASS sigmvitsBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = "empdopnums"

    *---------------------------------------------------------------------------
    * Propriedades - SigMvCab (cabecalho do movimento/cupom - TprMvCab no legado)
    *---------------------------------------------------------------------------
    this_cEmpdopnums = ""   && empdopnums char(29) NOT NULL - Chave tecnica (Emps+Dopes+Str(Numes,6))
    this_cEmps       = ""   && emps       char(3)  NOT NULL - Empresa
    this_cDopes      = ""   && dopes      char(20) NOT NULL - Codigo da operacao (tipo de movimento)
    this_nNumes      = 0    && numes      numeric(6,0) NOT NULL - Numero do documento/cupom
    this_cEmpds      = ""   && empds      char(3)  NOT NULL - Empresa do documento
    this_cNemps      = ""   && nemps      char(40) NOT NULL - Nome da empresa (grade/historico)
    this_dDatas      = {}   && datas      datetime NULL - Data do movimento
    this_cContads    = ""   && contads    char(10) NOT NULL - Conta destino (cliente)
    this_cContaos    = ""   && contaos    char(10) NOT NULL - Conta origem
    this_cGrupods    = ""   && grupods    char(10) NOT NULL - Grupo destino
    this_cGrupoos    = ""   && grupoos    char(10) NOT NULL - Grupo origem
    this_cResps      = ""   && resps      char(10) NOT NULL - Responsavel/vendedor destino
    this_cGrresps    = ""   && grresps    char(10) NOT NULL - Grupo do responsavel destino
    this_cVends      = ""   && vends      char(10) NOT NULL - Vendedor
    this_cGrvends    = ""   && grvends    char(10) NOT NULL - Grupo do vendedor
    this_cTabds      = ""   && tabds      char(10) NOT NULL - Tabela de desconto
    this_cLprecos    = ""   && lprecos    char(30) NOT NULL - Lista de precos
    this_cMascnum    = ""   && mascnum    char(10) NOT NULL - Mascara de numeracao do documento
    this_nNpedclis   = 0    && npedclis   numeric(11,0) NOT NULL - Numero do pedido do cliente
    this_cTpfats     = ""   && tpfats     char(3)  NOT NULL - Tipo de faturamento
    this_cEcfs       = ""   && ecfs       char(7)  NOT NULL - Numero de serie do ECF
    this_cNcupoms    = ""   && ncupoms    char(6)  NOT NULL - Numero do cupom fiscal
    this_cCodtrans   = ""   && codtrans   char(10) NOT NULL - Codigo da transacao (TEF/cartao)
    this_cMotdscs    = ""   && motdscs    char(10) NOT NULL - Motivo do desconto
    this_cEspes      = ""   && espes      char(10) NOT NULL - Especie (documento/moeda)
    this_cNotas      = ""   && notas      char(6)  NOT NULL - Numero da nota (impressao)
    this_cObses      = ""   && obses      text NULL - Observacoes (memo)
    this_dPrazoents  = {}   && prazoents  datetime NULL - Prazo de entrega
    this_dDtagends   = {}   && dtagends   datetime NULL - Data agendada
    this_nQtdes      = 0    && qtdes      numeric(6,0) NOT NULL - Quantidade de itens do cupom
    this_nPbrus      = 0    && pbrus      numeric(10,3) NULL - Peso bruto
    this_nPliqs      = 0    && pliqs      numeric(10,3) NULL - Peso liquido
    this_nUtilizados = 0    && utilizados numeric(1,0) NOT NULL - Flag de utilizacao
    this_nLocalents  = 0    && localents  numeric(10,0) NOT NULL - Local de entrega
    this_nValos      = 0    && valos      numeric(11,2) NOT NULL - Valor total do documento
    this_nValinis    = 0    && valinis    numeric(11,2) NOT NULL - Valor inicial (bruto dos itens)
    this_nValdevs    = 0    && valdevs    numeric(11,2) NOT NULL - Valor devolvido
    this_nValobxs    = 0    && valobxs    numeric(11,2) NOT NULL - Valor baixado
    this_nValservs   = 0    && valservs   numeric(11,2) NOT NULL - Valor de servicos
    this_nValvars    = 0    && valvars    numeric(11,2) NOT NULL - Valor de variacao (desconto/acrescimo)
    this_nValvarps   = 0    && valvarps   numeric(11,2) NOT NULL - Valor de variacao percentual
    this_nVars       = 0    && vars       numeric(9,4) NOT NULL - Percentual de variacao
    this_lChkpagos   = .F.  && chkpagos   bit NOT NULL - Flag pagamento conferido
    this_lChksubn    = .F.  && chksubn    bit NOT NULL - Flag possui sub-nivel
    this_lLcancelas  = .F.  && lcancelas  bit NOT NULL - Flag documento cancelado

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "empdopnums"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpdopnums)
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega do cursor SQL para as propriedades do BO.
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar os campos -
    * "campo" e sintaxe invalida em VFP9 (regra #9 CLAUDE.md).
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cEmpds      = TratarNulo(empds, "")
                THIS.this_cNemps      = TratarNulo(nemps, "")
                THIS.this_dDatas      = TratarNulo(datas, {})
                THIS.this_cContads    = TratarNulo(contads, "")
                THIS.this_cContaos    = TratarNulo(contaos, "")
                THIS.this_cGrupods    = TratarNulo(grupods, "")
                THIS.this_cGrupoos    = TratarNulo(grupoos, "")
                THIS.this_cResps      = TratarNulo(resps, "")
                THIS.this_cGrresps    = TratarNulo(grresps, "")
                THIS.this_cVends      = TratarNulo(vends, "")
                THIS.this_cGrvends    = TratarNulo(grvends, "")
                THIS.this_cTabds      = TratarNulo(tabds, "")
                THIS.this_cLprecos    = TratarNulo(lprecos, "")
                THIS.this_cMascnum    = TratarNulo(mascnum, "")
                THIS.this_nNpedclis   = TratarNulo(npedclis, 0)
                THIS.this_cTpfats     = TratarNulo(tpfats, "")
                THIS.this_cEcfs       = TratarNulo(ecfs, "")
                THIS.this_cNcupoms    = TratarNulo(ncupoms, "")
                THIS.this_cCodtrans   = TratarNulo(codtrans, "")
                THIS.this_cMotdscs    = TratarNulo(motdscs, "")
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cNotas      = TratarNulo(notas, "")
                THIS.this_cObses      = TratarNulo(obses, "")
                THIS.this_dPrazoents  = TratarNulo(prazoents, {})
                THIS.this_dDtagends   = TratarNulo(dtagends, {})
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_nPbrus      = TratarNulo(pbrus, 0)
                THIS.this_nPliqs      = TratarNulo(pliqs, 0)
                THIS.this_nUtilizados = TratarNulo(utilizados, 0)
                THIS.this_nLocalents  = TratarNulo(localents, 0)
                THIS.this_nValos      = TratarNulo(valos, 0)
                THIS.this_nValinis    = TratarNulo(valinis, 0)
                THIS.this_nValdevs    = TratarNulo(valdevs, 0)
                THIS.this_nValobxs    = TratarNulo(valobxs, 0)
                THIS.this_nValservs   = TratarNulo(valservs, 0)
                THIS.this_nValvars    = TratarNulo(valvars, 0)
                THIS.this_nValvarps   = TratarNulo(valvarps, 0)
                THIS.this_nVars       = TratarNulo(vars, 0)

                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF

                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF

                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCab (PROTECTED, chamado por
    * BusinessBase.Salvar() quando this_lNovoRegistro = .T.)
    *
    * SigMvCab tem 158 colunas, quase todas NOT NULL sem DEFAULT (regra #22
    * CLAUDE.md). Este BO so declara propriedade para as colunas que o
    * container "Caixa" (SIGMVITS) de fato le/grava - as demais colunas
    * NOT NULL recebem o default do TIPO (char="", numeric/bit=0) para nao
    * violar a constraint; colunas NULLABLE sem propriedade sao OMITIDAS da
    * lista (o SQL Server preenche NULL sozinho). cidchaves eh a PK real
    * (fUniqueIds()) - NUNCA string vazia, senao a inclusao inteira falha
    * por colisao/violacao da PRIMARY KEY.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCidchaves, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCidchaves = LEFT(fUniqueIds(), 20)

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCab ("
            loc_cSQL = loc_cSQL + "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datas,"
            loc_cSQL = loc_cSQL + "desc2s, descs, devols, dopes, empds, emps, grresps, grupods,"
            loc_cSQL = loc_cSQL + "grupoos, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
            loc_cSQL = loc_cSQL + "mascnum, ncarnecs, nemps, nops, notas, nrcons, ntrans, numes,"
            loc_cSQL = loc_cSQL + "numolds, obses, opers, prazoents, resps, tabds, tpfats, transps,"
            loc_cSQL = loc_cSQL + "usuals, usuars, usulibs, valacres, valdes2s, valdescs, valdevs, valencs,"
            loc_cSQL = loc_cSQL + "valinis, valos, valservs, valvars, vars, vends, cotusus, espes,"
            loc_cSQL = loc_cSQL + "pbrus, pliqs, qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs,"
            loc_cSQL = loc_cSQL + "codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms, auditors,"
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, empgopnums, contaes, dtagends, localents, localizas, chkpagos,"
            loc_cSQL = loc_cSQL + "chkpgs, codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs,"
            loc_cSQL = loc_cSQL + "ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, usupagos,"
            loc_cSQL = loc_cSQL + "ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis,"
            loc_cSQL = loc_cSQL + "idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, jobs,"
            loc_cSQL = loc_cSQL + "ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, valserfix, perserfix, valosfix,"
            loc_cSQL = loc_cSQL + "chkencerra, perdesc, compet, pedidoweb, cdrastreio, identrega, idtransp, peracresc,"
            loc_cSQL = loc_cSQL + "tpmovs, empfats, numeronota, meiotrans, chavenota, contaccs, grupoccs, natend,"
            loc_cSQL = loc_cSQL + "nlivdg, presente, chaveexterna, empret, msgpresnte, ckoperpend, usuconfs"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidchaves) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + "0" + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL("") + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCab (WHERE empdopnums,
    * chave tecnica desta entidade - Emps+Dopes+Str(Numes,6) - regra #22).
    * cidchaves (PK real da tabela) NUNCA e regravado num UPDATE.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " obses = " + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ","
            loc_cSQL = loc_cSQL + " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6))
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

