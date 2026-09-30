# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_CONTAINER2, CNT_4C_CONTAINER5, CNT_4C_CONTAINER4, CNT_4C_CONTAINER3. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container3.grd_4c_DispConta define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container3.grd_4c_DispConta.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container2.grd_4c_DispProduto define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container2.grd_4c_DispProduto.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container5.grd_4c_DispGrupo define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container5.grd_4c_DispGrupo.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container1.grd_4c_Linhas define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container1.grd_4c_Linhas.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container4.grd_4c_Pedras define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container4.grd_4c_Pedras.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).
- [GRID-HEADER] Header Caption 'Prior' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Prioridade, Disponível, Utilizar, Produto, Cor, Tam, Disponivel, Descrição, Uni, Qtde, Linha, Quantidade, Estoque, Produzir, Obs, Movimentação, Código, Atual, Utilizado, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLP.Container5): Left original=284 vs migrado 'lbl_4c_Label1' Left=6 (diff=278px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLP.Container5): Top original=413 vs migrado 'lbl_4c_Label2' Top=90 (diff=323px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLP.Container5): Top original=438 vs migrado 'lbl_4c_Label3' Top=131 (diff=307px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLP.Container2): Left original=284 vs migrado 'lbl_4c_Label1' Left=6 (diff=278px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLP.Container2): Top original=432 vs migrado 'lbl_4c_Label2' Top=90 (diff=342px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRGLP.Container2): Left original=168 vs migrado 'lbl_4c_Label2' Left=454 (diff=286px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLP.Container2): Top original=431 vs migrado 'lbl_4c_Label3' Top=131 (diff=300px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRGLP.Container2): Left original=365 vs migrado 'lbl_4c_Label3' Left=454 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLP.Container4): Left original=229 vs migrado 'lbl_4c_Label1' Left=6 (diff=223px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRGLP.Container1): Left original=259 vs migrado 'lbl_4c_Label1' Left=6 (diff=253px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pedras' (parent: SIGPRGLP): Left original=472 vs migrado 'grd_4c_Pedras' Left=9 (diff=463px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4730 linhas total):

*-- Linhas 19 a 354:
19: *
20: * CONTRATO DE CHAMADA (ja implementado do lado do chamador - NAO alterar a
21: * ordem/tipo dos parametros sem atualizar FormSigPrGl2.BtnProcessarClick):
22: *   CREATEOBJECT("FormSigPrGlp", par_oParentForm, par_nDataSessionId,
23: *       par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp)
24: *   equivalente ao legado "Do Form SigPrGlp With ThisForm,
25: *       ThisForm.Datasessionid, Reserva, poDataMgr, Emphpdr, automatico,
26: *       Numerodaop" - pCnx (poDataMgr) SAI da lista: a conexao migrada eh o
27: *       gnConnHandle global. par_nDataSessionId eh vestigial (equivale ao
28: *       "_Data" do LParameters legado, que o proprio Init original nunca
29: *       lia - a sessao privada eh assumida de par_oParentForm.DataSessionId,
30: *       igual ao "_ParentForm.DataSessionId" do legado e ao mesmo padrao
31: *       ja usado em FormSigPrGlx/FormSigPrGf2).
32: *
33: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS, Init/Destroy/
34: * InicializarForm, cabecalho cnt_4c_Sombra). Roteiro das proximas fases em
35: * ConfigurarPageFrame().
36: *==============================================================================
37: 
38: DEFINE CLASS FormSigPrGlp AS FormBase
39: 
40:     *--------------------------------------------------------------------------
41:     * Propriedades do form (SIGPRGLP.SCX: Width=1000, Height=600,
42:     * DataSession=2, BorderStyle=2, ControlBox=.F., Closable=.F.,
43:     * MaxButton=.F., MinButton=.F., ClipControls=.F., TitleBar=0,
44:     * WindowState=0, FontName="Tahoma" - PILAR 1)
45:     *--------------------------------------------------------------------------
46:     Width        = 1000
47:     Height       = 600
48:     AutoCenter   = .T.
49:     TitleBar     = 0
50:     ShowWindow   = 1
51:     ControlBox   = .F.
52:     Closable     = .F.
53:     MaxButton    = .F.
54:     MinButton    = .F.
55:     ClipControls = .F.
56:     BorderStyle  = 2
57:     WindowState  = 0
58:     FontName     = "Tahoma"
59: 
60:     *-- WindowType = 1 eh canonico do projeto (mesmo padrao de FormSigPrGlx/
61:     *-- FormSigPrGf1/FormSigPrGf2): FormSigPrGl2.BtnProcessarClick abre este
62:     *-- form com CREATEOBJECT + variavel LOCAL + .Show() - com modeless o
63:     *-- Show() retornaria na hora e a LOCAL sairia de escopo, destruindo o
64:     *-- form (pisca e some).
65:     WindowType   = 1
66: 
67:     *-- DataSession = 2 transcrito do SCX. So vale quando este form eh
68:     *-- aberto SEM form pai (ganha sessao privada propria nesse caso); com
69:     *-- form pai, Init() troca THIS.DataSessionId pela sessao dele ANTES do
70:     *-- DODEFAULT(), para enxergar TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
71:     *-- TmpLinha/SelPedra/CrSigCdPac/CrSigCdPam que o pai ja populou.
72:     DataSession  = 2
73: 
74:     Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
75: 
76:     *-- Referencia do form pai (ParentForm do legado). Reabilitado no
77:     *-- Destroy (o pai se desabilita antes de abrir este form filho).
78:     this_oParentForm = .NULL.
79: 
80:     *-- Guarda de reentrancia dos lookups de SigCdPro (colunas Produto e
81:     *-- Produto substituto do grd_4c_Pedras). FormBuscaAuxiliar eh MODAL:
82:     *-- o Show() bloqueia, o foco sai da celula e volta, e o proprio
83:     *-- KeyPress/DblClick pode disparar de novo empilhando um segundo
84:     *-- picker. Setada na entrada e limpa DEPOIS do ENDTRY, para valer
85:     *-- tambem quando o CATCH dispara.
86:     this_lLookupAberto = .F.
87: 
88:     *-- ThisForm.AntValue do legado (When da Column5.Text1 do GradePedra:
89:     *-- "ThisForm.AntValue = This.Value"), usado pelo LostFocus da mesma
90:     *-- coluna para decidir a insercao da linha em branco em SelPedra.
91:     this_cAntValue = ""
92: 
93:     *-- ThisForm.OldValue do legado (When da Column6.Text1 do GradeItens -
94:     *-- coluna Produzir), guardado no GotFocus e comparado no Valid para
95:     *-- decidir se o valor mudou e se precisa confirmar com o usuario a
96:     *-- perda da selecao manual de estoque (TmpSaldU.KeySelm).
97:     this_nProduzirValorAnterior = 0
98: 
99:     *--------------------------------------------------------------------------
100:     * Init - Recebe a referencia do form pai e os parametros de modo
101:     * (equivalente a "LParameters _ParentForm, _Data, _ReservaAuto, pCnx,
102:     * _nGerEmphPdr, _autom, _numeroOp" do legado - ver contrato de chamada
103:     * no cabecalho do arquivo). Assume a DataSessionId do pai e repassa os
104:     * parametros de modo ao BusinessObject ANTES do DODEFAULT(), para que
105:     * InicializarForm() ja os encontre prontos.
106:     *--------------------------------------------------------------------------
107:     PROCEDURE Init(par_oParentForm, par_nDataSessionId, par_lReservaAuto, ;
108:                    par_nGerEmphPdr, par_lAutom, par_nNumeroOp)
109: 
110:         LOCAL loc_lSucesso, loc_oErro
111:         loc_lSucesso = .F.
112: 
113:         TRY
114:             IF VARTYPE(par_oParentForm) = "O"
115:                 THIS.DataSessionId    = par_oParentForm.DataSessionId
116:                 THIS.this_oParentForm = par_oParentForm
117:             ENDIF
118: 
119:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
120: 
121:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
122:                 THIS.this_oBusinessObject.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
123:                 THIS.this_oBusinessObject.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
124:                 THIS.this_oBusinessObject.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
125:                 THIS.this_oBusinessObject.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)
126: 
127:                 DODEFAULT()
128:                 loc_lSucesso = .T.
129:             ENDIF
130:         CATCH TO loc_oErro
131:             MsgErro("Erro ao inicializar Pr" + CHR(233) + "via da Globaliza" + ;
132:                 CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
133:         ENDTRY
134: 
135:         RETURN loc_lSucesso
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * Destroy - os cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/
140:     * TmpLinha/SelPedra/TmpSaldU) vivem na DataSession PRIVADA compartilhada
141:     * com o pai - nao ha o que fechar aqui (o pai, dono da sessao, fecha os
142:     * dele quando for a vez dele). So reabilita o form pai (desabilitado por
143:     * FormSigPrGl2.BtnProcessarClick antes de abrir este form filho) e
144:     * encadeia para FormBase.Destroy() (libera this_oBusinessObject e
145:     * restaura o menu principal). DODEFAULT() SEMPRE por ultimo.
146:     *--------------------------------------------------------------------------
147:     PROCEDURE Destroy()
148:         LOCAL loc_oErro
149: 
150:         TRY
151:             IF VARTYPE(THIS.this_oParentForm) = "O"
152:                 THIS.this_oParentForm.Enabled = .T.
153:             ENDIF
154:             THIS.this_oParentForm = .NULL.
155:         CATCH TO loc_oErro
156:             MsgErro("Erro ao encerrar FormSigPrGlp: " + loc_oErro.Message, "Erro")
157:         ENDTRY
158: 
159:         DODEFAULT()
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     * InicializarForm - Business Object ja foi criado e configurado em
164:     * Init(); aqui so falta resolver o Caption dinamico (Globalizacao x
165:     * Reserva Automatica), o SigKey (cursor global CrSigCdPac, que o form
166:     * pai ja populou na sessao compartilhada) e montar a moldura visual
167:     * (fundo + cabecalho). Os containers flutuantes, grids, botoes de acao
168:     * e eventos entram nas proximas fases.
169:     *--------------------------------------------------------------------------
170:     PROTECTED PROCEDURE InicializarForm()
171:         LOCAL loc_lSucesso, loc_oErro, loc_cCaption
172:         loc_lSucesso = .F.
173: 
174:         TRY
175:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
176:                 MsgErro("Falha ao criar SigPrGlpBO.", "Erro")
177:             ELSE
178:                 *-- Caption dinamico (equivalente ao "If ThisForm.Reserva ...
179:                 *-- Else ... EndIf" do Init legado)
180:                 loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
181:                 IF THIS.this_oBusinessObject.this_lReserva
182:                     loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
183:                 ENDIF
184:                 THIS.Caption = loc_cCaption
185: 
186:                 *-- SigKey (Thisform.SigKey = CrSigCdPac.sigKeys do Init
187:                 *-- legado) - CrSigCdPac eh cursor global que o form pai ja
188:                 *-- populou, visivel aqui porque a DataSessionId eh
189:                 *-- compartilhada (ver Init acima)
190:                 IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
191:                     THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
192:                 ENDIF
193: 
194:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
195: 
196:                 THIS.ConfigurarPageFrame()
197: 
198:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
199:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
200: 
201:                 *-- Carga inicial da grade principal - o bind + "Go Top" +
202:                 *-- ".Refresh" com que o Init legado termina. Passa pelo funil
203:                 *-- CarregarLista porque ConfigurarGradeItens so consegue ligar
204:                 *-- o RecordSource se TmpFinal JA existia quando o grid foi
205:                 *-- criado; recebido depois (ou recriado pelo form pai), o
206:                 *-- grid ficaria permanentemente em branco.
207:                 *-- Pulada em validacao de UI, que instancia o form sem
208:                 *-- conexao e sem os cursores do chamador.
209:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
210:                     THIS.CarregarLista()
211:                 ENDIF
212: 
213:                 THIS.TornarControlesVisiveis(THIS)
214: 
215:                 loc_lSucesso = .T.
216:             ENDIF
217:         CATCH TO loc_oErro
218:             MsgErro(loc_oErro.Message + CHR(13) + ;
219:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
220:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGlp.InicializarForm")
221:         ENDTRY
222: 
223:         RETURN loc_lSucesso
224:     ENDPROC
225: 
226:     *--------------------------------------------------------------------------
227:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGLP nao
228:     * tem PageFrame no legado (layout flat) - o nome do metodo eh mantido
229:     * apenas como ponto de entrada arquitetural padrao (mesmo papel em
230:     * FormSigPrGlo/FormSigPrGf1).
231:     *
232:     * Roteiro das proximas fases:
233:     *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
234:     *   Fase 4 (esta)  - shp_4c_Shape2/shp_4c_Shape3 decorativos, os 7
235:     *                     botoes de acao standalone (Disponivel/TotLinha/
236:     *                     Pedras/SelEstoque/Cancelar/Processar/
237:     *                     btnRelatorio) e o grid principal grd_4c_Itens
238:     *                     (GradeItens, 9 colunas, RecordSource='TmpFinal')
239:     *   Fase 5 (esta)  - 3 dos 5 containers flutuantes (estrutura visual
240:     *                     apenas - RecordSource/ControlSource dos grids fica
241:     *                     para a Fase 7-8, igual ao legado, que so liga isso
242:     *                     dentro do Click de cada botao): cnt_4c_Container1
243:     *                     (Pecas a Produzir por Linha - botao TotLinha),
244:     *                     cnt_4c_Container2 (Estoque Disponivel por
245:     *                     Produto/Cor/Tam - botao Disponivel) e
246:     *                     cnt_4c_Container5 (Estoque Disponivel por
247:     *                     Grupo/Conta - botao SelEstoque)
248:     *   Fase 6 (esta)  - cnt_4c_Container4 (Requisicao de Componentes
249:     *                     Adicionais - botao Pedras; grid ligado a SelPedra
250:     *                     em runtime pelo Pedras.Click, mesmo padrao dos
251:     *                     containers da Fase 5), cnt_4c_Container3
252:     *                     (Estoque Disponivel por Conta, rodape SEMPRE
253:     *                     visivel - nao entra no filtro de
254:     *                     TornarControlesVisiveis), os campos totais da
255:     *                     grade principal (txt_4c_TotQtd/TotEst/TotPrz),
256:     *                     img_4c_ImgFigJpg (foto do item selecionado),
257:     *                     lbl_4c_TxtObsItens/obj_4c_ObsItens e os LOOKUPS
258:     *                     de SigCdPro das colunas Produto/Produto
259:     *                     substituto do grd_4c_Pedras (Valid legado ->
260:     *                     ValidarPedraProduto/ValidarPedraSubstituto +
261:     *                     AbrirLookupPedraProduto/AbrirLookupPedraSubstituto
262:     *                     via FormBuscaAuxiliar), o gate do When das
263:     *                     Column4/Column5 (AjustarColunasPedra, ligado ao
264:     *                     AfterRowColChange) e o LostFocus da Column5
265:     *                     (linha em branco no SelPedra)
266:     *   Fase 7 (esta)  - PrepararCursoresDeTrabalho() (o resto do Init
267:     *                     legado: linha em branco do SelPedra, cursores
268:     *                     TmpSaldU/crSigCdCom, bind do grid do Container3 e
269:     *                     totais do rodape) e ConfigurarEventos()
270:     *                     (BINDEVENT dos 6 botoes de acao + dos 4 botoes de
271:     *                     OK/Sair dos containers flutuantes), com os
272:     *                     handlers correspondentes: BtnDisponivelClick,
273:     *                     BtnSelEstoqueClick, BtnTotLinhaClick,
274:     *                     BtnPedrasClick, BtnRelatorioClick,
275:     *                     BtnCancelarClick, BtnConfirmarDispProdutoClick,
276:     *                     BtnConfirmarDispGrupoClick, BtnFecharPedrasClick
277:     *                     e BtnFecharLinhasClick
278:     *   Fase 8 (esta)  - BtnProcessarClick + o AfterRowColChange de
279:     *                     grd_4c_Itens (alimenta Container3/totais/imagem/
280:     *                     observacao), o When/Valid/LostFocus da coluna
281:     *                     Produzir e da coluna Utilizar dos dois paineis de
282:     *                     estoque, SigPrGlpBO.Processar/AtualizaPeso/
283:     *                     GravaHis e os funis de consolidacao no fim do
284:     *                     arquivo (CarregarLista/LigarGradeItens/
285:     *                     FormParaBO/BOParaForm/HabilitarCampos/
286:     *                     AjustarBotoesPorModo/LimparCampos)
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarPageFrame()
289:         THIS.ConfigurarCabecalho()
290:         THIS.ConfigurarFormasDecorativas()
291:         THIS.ConfigurarBotoesAcao()
292:         THIS.ConfigurarGradeItens()
293:         THIS.ConfigurarContainer1()
294:         THIS.ConfigurarContainer2()
295:         THIS.ConfigurarContainer5()
296:         THIS.ConfigurarContainer4()
297:         THIS.ConfigurarContainer3()
298:         THIS.ConfigurarCamposTotais()
299: 
300:         *-- Fase 7: os cursores de trabalho que o Init legado prepara DEPOIS
301:         *-- de montar a tela, e o BINDEVENT dos botoes de acao. Os dois vem
302:         *-- por ULTIMO porque dependem de todos os controles ja criados.
303:         THIS.PrepararCursoresDeTrabalho()
304:         THIS.ConfigurarEventos()
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
309:     * Original: cntSombra Top=0, Left=0, Width=1004, Height=80,
310:     * BackColor=RGB(100,100,100) (layout.json/dump) - Width usa THIS.Width
311:     * (canonico do projeto) em vez do literal 1004 do SCX, que ja excedia
312:     * em 4px o proprio Width do form (1000).
313:     *--------------------------------------------------------------------------
314:     PROTECTED PROCEDURE ConfigurarCabecalho()
315:         LOCAL loc_oCnt, loc_oErro
316: 
317:         TRY
318:             THIS.AddObject("cnt_4c_Sombra", "Container")
319:             loc_oCnt = THIS.cnt_4c_Sombra
320:             WITH loc_oCnt
321:                 .Top         = 0
322:                 .Left        = 0
323:                 .Width       = THIS.Width
324:                 .Height      = 80
325:                 .BorderWidth = 0
326:                 .BackColor   = RGB(100, 100, 100)
327:                 .Visible     = .T.
328:             ENDWITH
329: 
330:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
331:             WITH loc_oCnt.lbl_4c_LblSombra
332:                 .FontBold      = .T.
333:                 .FontName      = "Tahoma"
334:                 .FontSize      = 18
335:                 .FontUnderline = .F.
336:                 .WordWrap      = .T.
337:                 .Alignment     = 0
338:                 .BackStyle     = 0
339:                 .AutoSize      = .F.
340:                 .Caption       = THIS.Caption
341:                 .Height        = 40
342:                 .Left          = 10
343:                 .Top           = 18
344:                 .Width         = 769
345:                 .ForeColor     = RGB(0, 0, 0)
346:                 .Visible       = .T.
347:             ENDWITH
348: 
349:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
350:             WITH loc_oCnt.lbl_4c_LblTitulo
351:                 .FontBold  = .T.
352:                 .FontName  = "Tahoma"
353:                 .FontSize  = 18
354:                 .WordWrap  = .T.

*-- Linhas 366 a 468:
366:         CATCH TO loc_oErro
367:             MsgErro(loc_oErro.Message + CHR(13) + ;
368:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
369:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
370:         ENDTRY
371:     ENDPROC
372: 
373:     *--------------------------------------------------------------------------
374:     * ConfigurarFormasDecorativas - Os dois Shape do dump (Shape2/Shape3) sao
375:     * meramente decorativos: BackStyle=0 (sem preenchimento) e BorderStyle=0
376:     * (sem borda desenhada) - BorderColor fica sem efeito visivel com
377:     * BorderStyle=0, mas eh transcrito do SCX mesmo assim (regra de
378:     * transcricao literal - nao inventar, nao omitir).
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE ConfigurarFormasDecorativas()
381:         LOCAL loc_oErro
382: 
383:         TRY
384:             THIS.AddObject("shp_4c_Shape2", "Shape")
385:             WITH THIS.shp_4c_Shape2
386:                 .Top         = 9
387:                 .Left        = 9
388:                 .Width       = 279
389:                 .Height      = 51
390:                 .BackStyle   = 0
391:                 .BorderStyle = 0
392:                 .BorderColor = RGB(136, 189, 188)
393:                 .Visible     = .T.
394:             ENDWITH
395: 
396:             THIS.AddObject("shp_4c_Shape3", "Shape")
397:             WITH THIS.shp_4c_Shape3
398:                 .Top         = 10
399:                 .Left        = 820
400:                 .Width       = 116
401:                 .Height      = 38
402:                 .BackStyle   = 0
403:                 .BorderStyle = 0
404:                 .BorderColor = RGB(136, 189, 188)
405:                 .Visible     = .T.
406:             ENDWITH
407:         CATCH TO loc_oErro
408:             MsgErro(loc_oErro.Message + CHR(13) + ;
409:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
410:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarFormasDecorativas")
411:         ENDTRY
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * ConfigurarBotoesAcao - Os 7 botoes de acao ficam soltos, filhos diretos
416:     * do form (o SCX nao os agrupa em CommandGroup/Container), desenhados
417:     * POR CIMA de cnt_4c_Sombra (Top=3..78 cabe dentro da faixa Top=0..80) -
418:     * por isso este metodo roda DEPOIS de ConfigurarCabecalho() em
419:     * ConfigurarPageFrame(). Propriedades comuns (FontBold/FontItalic/
420:     * FontName "Comic Sans MS"/FontSize/ForeColor RGB(90,90,90)/BackColor
421:     * branco/Themes=.F.) sao as mesmas do padrao canonico de botoes CRUD
422:     * (docs/framework_frmcadastro_layout.md), confirmadas 1-a-1 no dump.
423:     * Icones e Captions (com o "\<" de atalho Alt) transcritos literalmente
424:     * do SCX - nunca inventados (regra de icone: CLAUDE.md #25). BINDEVENT
425:     * dos Click entra na Fase 7-8 (roteiro do cabecalho de
426:     * ConfigurarPageFrame).
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
429:         LOCAL loc_oErro
430: 
431:         TRY
432:             THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
433:             WITH THIS.cmd_4c_Disponivel
434:                 .Top        = 3
435:                 .Left       = 622
436:                 .Width      = 75
437:                 .Height     = 75
438:                 .FontBold   = .T.
439:                 .FontItalic = .T.
440:                 .FontName   = "Comic Sans MS"
441:                 .FontSize   = 8
442:                 .WordWrap   = .T.
443:                 .Picture    = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
444:                 .Caption    = "\<Disponiveis"
445:                 .ForeColor  = RGB(90, 90, 90)
446:                 .BackColor  = RGB(255, 255, 255)
447:                 .Themes     = .F.
448:                 .Visible    = .T.
449:             ENDWITH
450: 
451:             THIS.AddObject("cmd_4c_Pedras", "CommandButton")
452:             WITH THIS.cmd_4c_Pedras
453:                 .Top             = 3
454:                 .Left            = 472
455:                 .Width           = 75
456:                 .Height          = 75
457:                 .FontBold        = .T.
458:                 .FontItalic      = .T.
459:                 .FontName        = "Comic Sans MS"
460:                 .FontSize        = 8
461:                 .WordWrap        = .T.
462:                 .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
463:                 *-- Themes=.T. + DisabledPicture (diverge do Themes=.F. do
464:                 *-- SCX de proposito): este botao PODE nascer .Enabled=.F.
465:                 *-- (ver abaixo) e botao standalone com Picture+Enabled=.F.
466:                 *-- +Themes=.F. perde o icone em VFP9 (CorretorAutomatico #99)
467:                 .Themes          = .T.
468:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"

*-- Linhas 580 a 653:
580:         CATCH TO loc_oErro
581:             MsgErro(loc_oErro.Message + CHR(13) + ;
582:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
583:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
584:         ENDTRY
585:     ENDPROC
586: 
587:     *--------------------------------------------------------------------------
588:     * ConfigurarGradeItens - Grid principal (GradeItens no legado), 9
589:     * colunas ligadas ao cursor TmpFinal (ja populado pelo form pai, na
590:     * DataSession privada compartilhada). O RecordSource eh atribuido aqui
591:     * SOB GUARDA de IF USED("TmpFinal") - o cursor so existe quando o form
592:     * eh aberto pelo fluxo real (FormSigPrGl2.BtnProcessarClick), e em modo
593:     * de teste de UI (gb_4c_ValidandoUI) nao existe. Quando ele chega
594:     * DEPOIS, quem liga a grade eh CarregarLista() (chamado no fim do
595:     * InicializarForm), que refaz o bind por LigarGradeItens() repondo
596:     * ControlSource/Width/Header na ordem canonica.
597:     *
598:     * IMPORTANTE - Correspondencia ControlSource x Header (conferida com o
599:     * dump linha a linha, incluindo cruzamento com os handlers de
600:     * GotFocus/Valid do legado, que confirmam qual coluna eh a UNICA
601:     * editavel): a ordem de DECLARACAO das colunas (Column1..Column9, a
602:     * mesma usada no ".ColumnN.ControlSource=" do Init legado) NAO anda em
603:     * paralelo com a ordem em que os Header1/Text1 aparecem no dump do SCX
604:     * - os Header1/Text1 sao indexados pelo .Name HISTORICO de cada coluna
605:     * (ex.: a coluna fisica 2, ligada a CodCors, tem .Name="Column5" e por
606:     * isso seu Header1.Caption fica na secao "Column5" do dump = "Quantidade").
607:     * Coluna 3 (fisica), ligada a Dopes, tem .Name="Column6", Header
608:     * "Produzir" e eh a UNICA com ReadOnly=.F. (BackColor 221,252,255) - os
609:     * handlers GotFocus de TODAS as outras colunas (comportamento.json)
610:     * fazem SetFocus justamente para "GradeItens.Column6.Text1", confirmando
611:     * que esta (fisica 3/Dopes/"Produzir") eh a coluna editavel do grid.
612:     *--------------------------------------------------------------------------
613:     PROTECTED PROCEDURE ConfigurarGradeItens()
614:         LOCAL loc_oErro
615: 
616:         TRY
617:             THIS.AddObject("grd_4c_Itens", "Grid")
618:             WITH THIS.grd_4c_Itens
619:                 .Top               = 125
620:                 .Left              = 11
621:                 .Width             = 708
622:                 .Height            = 224
623:                 .FontName          = "Verdana"
624:                 .FontSize          = 8
625:                 .AllowHeaderSizing = .F.
626:                 .AllowRowSizing    = .F.
627:                 .DeleteMark        = .F.
628:                 .RecordMark        = .F.
629:                 .RowHeight         = 17
630:                 .ScrollBars        = 2
631:                 .GridLineColor     = RGB(238, 238, 238)
632:                 .Visible           = .T.
633: 
634:                 .ColumnCount = 9
635: 
636:                 IF USED("TmpFinal")
637:                     .RecordSource = "TmpFinal"
638:                 ENDIF
639: 
640:                 *-- Coluna 1 - Produto (Cpros)
641:                 .Column1.ControlSource = "TmpFinal.Cpros"
642:                 .Column1.Width         = 115
643:                 .Column1.Movable       = .F.
644:                 .Column1.Resizable     = .F.
645:                 .Column1.ReadOnly      = .T.
646:                 .Column1.Header1.FontName  = "Verdana"
647:                 .Column1.Header1.FontSize  = 8
648:                 .Column1.Header1.Alignment = 2
649:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
650:                 .Column1.Header1.Caption   = "Produto"
651:                 .Column1.Text1.FontSize    = 8
652:                 .Column1.Text1.BorderStyle = 0
653:                 .Column1.Text1.Margin      = 0

*-- Linhas 830 a 886:
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message + CHR(13) + ;
832:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
833:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeItens")
834:         ENDTRY
835:     ENDPROC
836: 
837:     *--------------------------------------------------------------------------
838:     * ConfigurarContainer1 - "Pecas a produzir por linha" (Container1 no
839:     * legado), alternado pelo botao cmd_4c_TotLinha (Fase 7-8). Grid
840:     * grd_4c_Linhas 100% somente-leitura (o proprio Grid tem .ReadOnly=.T.
841:     * no dump, alem de cada Column) - Column1..4.ControlSource ficam vazios
842:     * de proposito (assim declarado no SCX): TotLinha.Click monta o cursor
843:     * TmpLinha e liga RecordSource/ControlSource em runtime (Fase 7-8),
844:     * igual ao legado.
845:     *--------------------------------------------------------------------------
846:     PROTECTED PROCEDURE ConfigurarContainer1()
847:         LOCAL loc_oCnt, loc_oErro
848: 
849:         TRY
850:             THIS.AddObject("cnt_4c_Container1", "Container")
851:             loc_oCnt = THIS.cnt_4c_Container1
852:             WITH loc_oCnt
853:                 .Top           = 125
854:                 .Left          = 12
855:                 .Width         = 708
856:                 .Height        = 465
857:                 .SpecialEffect = 0
858:                 .BackColor     = RGB(255, 255, 255)
859:                 .Visible       = .F.
860:             ENDWITH
861: 
862:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
863:             WITH loc_oCnt.lbl_4c_Label1
864:                 .FontBold  = .T.
865:                 .FontName  = "Tahoma"
866:                 .FontSize  = 10
867:                 .Alignment = 0
868:                 .BackStyle = 0
869:                 .AutoSize  = .F.
870:                 .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
871:                 .Height    = 18
872:                 .Left      = 259
873:                 .Top       = 10
874:                 .Width     = 170
875:                 .ForeColor = RGB(90, 90, 90)
876:                 .Visible   = .T.
877:             ENDWITH
878: 
879:             loc_oCnt.AddObject("cmd_4c_CancelaLin", "CommandButton")
880:             WITH loc_oCnt.cmd_4c_CancelaLin
881:                 .Top         = 10
882:                 .Left        = 620
883:                 .Height      = 75
884:                 .Width       = 75
885:                 .FontBold    = .T.
886:                 .FontItalic  = .T.

*-- Linhas 1004 a 1058:
1004:         CATCH TO loc_oErro
1005:             MsgErro(loc_oErro.Message + CHR(13) + ;
1006:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1007:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer1")
1008:         ENDTRY
1009:     ENDPROC
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * ConfigurarContainer2 - "Estoque Disponivel" por PRODUTO/COR/TAM,
1013:     * alternado pelo botao cmd_4c_Disponivel (Fase 7-8). RecordSource/
1014:     * ControlSource ficam de fora aqui (o SCX nao declara ControlSource
1015:     * estatico para estas colunas - o Click do legado monta TmpDisp e liga
1016:     * tudo em runtime, mesmo padrao do Container5).
1017:     *--------------------------------------------------------------------------
1018:     PROTECTED PROCEDURE ConfigurarContainer2()
1019:         LOCAL loc_oCnt, loc_oErro
1020: 
1021:         TRY
1022:             THIS.AddObject("cnt_4c_Container2", "Container")
1023:             loc_oCnt = THIS.cnt_4c_Container2
1024:             WITH loc_oCnt
1025:                 .Top           = 125
1026:                 .Left          = 12
1027:                 .Width         = 708
1028:                 .Height        = 465
1029:                 .SpecialEffect = 0
1030:                 .BackColor     = RGB(255, 255, 255)
1031:                 .Visible       = .F.
1032:             ENDWITH
1033: 
1034:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1035:             WITH loc_oCnt.lbl_4c_Label1
1036:                 .FontBold  = .T.
1037:                 .FontName  = "Tahoma"
1038:                 .FontSize  = 10
1039:                 .BackStyle = 0
1040:                 .AutoSize  = .F.
1041:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1042:                 .Height    = 18
1043:                 .Left      = 284
1044:                 .Top       = 10
1045:                 .Width     = 123
1046:                 .ForeColor = RGB(90, 90, 90)
1047:                 .Visible   = .T.
1048:             ENDWITH
1049: 
1050:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1051:             WITH loc_oCnt.cmd_4c_CancelaDisp
1052:                 .Top       = 10
1053:                 .Left      = 620
1054:                 .Height    = 75
1055:                 .Width     = 75
1056:                 .FontName  = "Comic Sans MS"
1057:                 .FontSize  = 8
1058:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1237 a 1291:
1237:         CATCH TO loc_oErro
1238:             MsgErro(loc_oErro.Message + CHR(13) + ;
1239:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1240:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer2")
1241:         ENDTRY
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * ConfigurarContainer5 - "Estoque Disponivel" por GRUPO/CONTA, alternado
1246:     * pelo botao cmd_4c_SelEstoque ("Estoques" - Fase 7-8). O ColumnOrder do
1247:     * grid NAO acompanha a ordem de declaracao das colunas (Column3/
1248:     * Prioridade eh a PRIMEIRA visualmente - ColumnOrder=1) - transcrito
1249:     * literal do dump, nao "corrigido".
1250:     *--------------------------------------------------------------------------
1251:     PROTECTED PROCEDURE ConfigurarContainer5()
1252:         LOCAL loc_oCnt, loc_oErro
1253: 
1254:         TRY
1255:             THIS.AddObject("cnt_4c_Container5", "Container")
1256:             loc_oCnt = THIS.cnt_4c_Container5
1257:             WITH loc_oCnt
1258:                 .Top           = 125
1259:                 .Left          = 12
1260:                 .Width         = 708
1261:                 .Height        = 465
1262:                 .SpecialEffect = 0
1263:                 .BackColor     = RGB(255, 255, 255)
1264:                 .Visible       = .F.
1265:             ENDWITH
1266: 
1267:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1268:             WITH loc_oCnt.lbl_4c_Label1
1269:                 .FontBold  = .T.
1270:                 .FontName  = "Tahoma"
1271:                 .FontSize  = 10
1272:                 .BackStyle = 0
1273:                 .AutoSize  = .F.
1274:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1275:                 .Height    = 18
1276:                 .Left      = 284
1277:                 .Top       = 10
1278:                 .Width     = 123
1279:                 .ForeColor = RGB(90, 90, 90)
1280:                 .Visible   = .T.
1281:             ENDWITH
1282: 
1283:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1284:             WITH loc_oCnt.cmd_4c_CancelaDisp
1285:                 .Top         = 10
1286:                 .Left        = 620
1287:                 .Height      = 75
1288:                 .Width       = 75
1289:                 .FontBold    = .T.
1290:                 .FontItalic  = .T.
1291:                 .FontName    = "Comic Sans MS"

*-- Linhas 1526 a 1659:
1526:         CATCH TO loc_oErro
1527:             MsgErro(loc_oErro.Message + CHR(13) + ;
1528:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1529:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer5")
1530:         ENDTRY
1531:     ENDPROC
1532: 
1533:     *--------------------------------------------------------------------------
1534:     * ConfigurarContainer4 - "Requisicao de componentes adicionais"
1535:     * (Container4 no legado), alternado pelo botao cmd_4c_Pedras (Fase 7-8).
1536:     * Grid grd_4c_Pedras liga em runtime ao cursor SelPedra montado pelo
1537:     * Click (mesmo padrao de RecordSource/ControlSource vazio ja usado nos
1538:     * Containers 1/2/5) - Pedras.Click faz .RecordSource='SelPedra' e liga
1539:     * Column1..5 a Cpros/Dpros/Cunis/Qtds/Cpro2s.
1540:     *
1541:     * ReadOnly por coluna transcrito do When de cada Text1 no legado:
1542:     * Coluna1 (Produto) eh a UNICA de entrada livre - o Valid dela dispara
1543:     * o lookup fwBuscaExt em SigCdPro (Fase 7-8) e preenche Descricao/Uni
1544:     * (Colunas 2/3, sempre ReadOnly, "Return .f." no When). Colunas 4
1545:     * (Qtde) e 5 (Produto substituto, com o proprio lookup fwBuscaExt) so
1546:     * habilitam quando a Coluna1 estiver preenchida (When = "Return (Not
1547:     * Empty(...Column1.Text1.Value))"); a Coluna5 tambem tem um LostFocus
1548:     * que insere linha em branco no SelPedra (Fase 7-8).
1549:     *--------------------------------------------------------------------------
1550:     PROTECTED PROCEDURE ConfigurarContainer4()
1551:         LOCAL loc_oCnt, loc_oErro
1552: 
1553:         TRY
1554:             THIS.AddObject("cnt_4c_Container4", "Container")
1555:             loc_oCnt = THIS.cnt_4c_Container4
1556:             WITH loc_oCnt
1557:                 .Top           = 125
1558:                 .Left          = 12
1559:                 .Width         = 708
1560:                 .Height        = 465
1561:                 .SpecialEffect = 0
1562:                 .BackColor     = RGB(255, 255, 255)
1563:                 .Visible       = .F.
1564:             ENDWITH
1565: 
1566:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1567:             WITH loc_oCnt.lbl_4c_Label1
1568:                 .FontBold  = .T.
1569:                 .FontName  = "Tahoma"
1570:                 .FontSize  = 10
1571:                 .BackStyle = 0
1572:                 .AutoSize  = .F.
1573:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1574:                 .Height    = 18
1575:                 .Left      = 229
1576:                 .Top       = 8
1577:                 .Width     = 249
1578:                 .ForeColor = RGB(90, 90, 90)
1579:                 .Visible   = .T.
1580:             ENDWITH
1581: 
1582:             loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
1583:             WITH loc_oCnt.cmd_4c_CancelaDisp
1584:                 .Top       = 10
1585:                 .Left      = 620
1586:                 .Height    = 75
1587:                 .Width     = 75
1588:                 .FontName  = "Comic Sans MS"
1589:                 .FontSize  = 8
1590:                 .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1591:                 .Cancel    = .T.
1592:                 .Caption   = "Sair"
1593:                 .ForeColor = RGB(90, 90, 90)
1594:                 .BackColor = RGB(255, 255, 255)
1595:                 .Themes    = .F.
1596:                 .Visible   = .T.
1597:             ENDWITH
1598: 
1599:             loc_oCnt.AddObject("grd_4c_Pedras", "Grid")
1600:             WITH loc_oCnt.grd_4c_Pedras
1601:                 .Top               = 32
1602:                 .Left              = 9
1603:                 .Width             = 605
1604:                 .Height            = 420
1605:                 .FontSize          = 8
1606:                 .AllowHeaderSizing = .F.
1607:                 .AllowRowSizing    = .F.
1608:                 .DeleteMark        = .F.
1609:                 .RecordMark        = .T.
1610:                 .RowHeight         = 16
1611:                 .ScrollBars        = 2
1612:                 .GridLineColor     = RGB(238, 238, 238)
1613:                 .Visible           = .T.
1614: 
1615:                 .ColumnCount = 5
1616: 
1617:                 *-- Coluna 1 - Produto (futuro SelPedra.Cpros) - entrada
1618:                 *-- livre com lookup em SigCdPro (ValidarPedraProduto /
1619:                 *-- AbrirLookupPedraProduto, ligados por BINDEVENT abaixo)
1620:                 .Column1.ControlSource     = ""
1621:                 .Column1.Width             = 110
1622:                 .Column1.Movable           = .F.
1623:                 .Column1.Resizable         = .F.
1624:                 .Column1.ReadOnly          = .F.
1625:                 .Column1.Header1.FontName  = "Verdana"
1626:                 .Column1.Header1.FontSize  = 8
1627:                 .Column1.Header1.Alignment = 2
1628:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
1629:                 .Column1.Header1.Caption   = "Produto"
1630:                 .Column1.Text1.FontSize    = 8
1631:                 .Column1.Text1.BorderStyle = 0
1632:                 .Column1.Text1.Margin      = 0
1633:                 .Column1.Text1.ReadOnly    = .F.
1634:                 .Column1.Text1.ForeColor   = RGB(0, 0, 0)
1635:                 .Column1.Text1.BackColor   = RGB(255, 255, 255)
1636: 
1637:                 *-- Coluna 2 - Descricao (futuro SelPedra.Dpros) - sempre
1638:                 *-- ReadOnly, preenchida pelo lookup da Coluna1
1639:                 .Column2.ControlSource     = ""
1640:                 .Column2.Width             = 215
1641:                 .Column2.Movable           = .F.
1642:                 .Column2.Resizable         = .F.
1643:                 .Column2.ReadOnly          = .T.
1644:                 .Column2.Header1.FontName  = "Verdana"
1645:                 .Column2.Header1.FontSize  = 8
1646:                 .Column2.Header1.Alignment = 2
1647:                 .Column2.Header1.ForeColor = RGB(36, 84, 155)
1648:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1649:                 .Column2.Text1.FontSize    = 8
1650:                 .Column2.Text1.BorderStyle = 0
1651:                 .Column2.Text1.Margin      = 0
1652:                 .Column2.Text1.ReadOnly    = .T.
1653:                 .Column2.Text1.ForeColor   = RGB(0, 0, 0)
1654:                 .Column2.Text1.BackColor   = RGB(255, 255, 255)
1655: 
1656:                 *-- Coluna 3 - Uni (futuro SelPedra.Cunis) - sempre ReadOnly,
1657:                 *-- preenchida pelo lookup da Coluna1
1658:                 .Column3.ControlSource     = ""
1659:                 .Column3.Width             = 50

*-- Linhas 1717 a 1808:
1717:             ENDWITH
1718: 
1719:             *-- LOOKUPS fwBuscaExt em SigCdPro (legado: Valid das
1720:             *-- Column1.Text1 e Column5.Text1 do GradePedra). BINDEVENT em
1721:             *-- "Valid" NAO dispara de forma confiavel em TextBox: o gatilho
1722:             *-- equivalente eh KeyPress com ENTER(13)/TAB(9)/F4(115), mais o
1723:             *-- DblClick (CLAUDE.md regra BINDEVENT/KeyPress). Todos os
1724:             *-- handlers sao PUBLIC - BINDEVENT falha em silencio com
1725:             *-- PROTECTED (CLAUDE.md regra #3).
1726:             BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "KeyPress", ;
1727:                       THIS, "PedraProdutoKeyPress")
1728:             BINDEVENT(loc_oCnt.grd_4c_Pedras.Column1.Text1, "DblClick", ;
1729:                       THIS, "PedraProdutoDblClick")
1730:             BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "KeyPress", ;
1731:                       THIS, "PedraSubstitutoKeyPress")
1732:             BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "DblClick", ;
1733:                       THIS, "PedraSubstitutoDblClick")
1734:             BINDEVENT(loc_oCnt.grd_4c_Pedras.Column5.Text1, "LostFocus", ;
1735:                       THIS, "PedraSubstitutoLostFocus")
1736: 
1737:             *-- Gate das colunas Qtde/Produto-substituto: o legado usa
1738:             *-- "When -> Return (Not Empty(Column1.Text1.Value))" nas
1739:             *-- Column4/Column5. BINDEVENT descarta o retorno do delegate,
1740:             *-- entao o When nao bloqueia edicao por essa via - o
1741:             *-- equivalente fiel eh reavaliar o gate a cada troca de
1742:             *-- linha/coluna (AfterRowColChange) e ligar/desligar as duas
1743:             *-- colunas.
1744:             BINDEVENT(loc_oCnt.grd_4c_Pedras, "AfterRowColChange", ;
1745:                       THIS, "PedrasAfterRowColChange")
1746:         CATCH TO loc_oErro
1747:             MsgErro(loc_oErro.Message + CHR(13) + ;
1748:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1749:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer4")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     *--------------------------------------------------------------------------
1754:     * ConfigurarContainer3 - "Estoque Disponivel" por CONTA (Container3 no
1755:     * legado), rodape SEMPRE VISIVEL (o dump nao declara Visible=.F. para
1756:     * ele, ao contrario de Container1/2/4/5) - fica abaixo de grd_4c_Itens
1757:     * (Top=125+224=349) e mostra o detalhe de estoque por Grupo/Conta do
1758:     * ITEM SELECIONADO na grade principal. Distinto de cnt_4c_Container5
1759:     * (mesmo titulo "Estoque Disponivel", mas alternado pelo botao Estoques
1760:     * e mostrando outro produto/cor/tam escolhido pelo usuario).
1761:     *
1762:     * GradeDisp e os campos txt_4c_GetDGrupo/GetDConta/TotQtd/TotEst/TotPrz
1763:     * ficam sem ControlSource/Value dinamico aqui - GradeItens.
1764:     * AfterRowColChange (Fase 7-8) religa TmpSaldG com "Set Key To" filtrado
1765:     * pelo Cpros+CodCors+CodTams do item corrente e atualiza estes campos,
1766:     * igual ao legado.
1767:     *--------------------------------------------------------------------------
1768:     PROTECTED PROCEDURE ConfigurarContainer3()
1769:         LOCAL loc_oCnt, loc_oErro
1770: 
1771:         TRY
1772:             THIS.AddObject("cnt_4c_Container3", "Container")
1773:             loc_oCnt = THIS.cnt_4c_Container3
1774:             WITH loc_oCnt
1775:                 .Top           = 373
1776:                 .Left          = 12
1777:                 .Width         = 708
1778:                 .Height        = 205
1779:                 .SpecialEffect = 0
1780:                 .BackColor     = RGB(255, 255, 255)
1781:                 .Visible       = .T.
1782:             ENDWITH
1783: 
1784:             loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1785:             WITH loc_oCnt.lbl_4c_Label1
1786:                 .FontName  = "Tahoma"
1787:                 .FontSize  = 8
1788:                 .BackStyle = 0
1789:                 .AutoSize  = .F.
1790:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
1791:                 .Height    = 16
1792:                 .Left      = 6
1793:                 .Top       = 5
1794:                 .Width     = 118
1795:                 .ForeColor = RGB(90, 90, 90)
1796:                 .Visible   = .T.
1797:             ENDWITH
1798: 
1799:             loc_oCnt.AddObject("grd_4c_DispConta", "Grid")
1800:             WITH loc_oCnt.grd_4c_DispConta
1801:                 .Top               = 24
1802:                 .Left              = 6
1803:                 .Width             = 444
1804:                 .Height            = 148
1805:                 .FontSize          = 8
1806:                 .AllowHeaderSizing = .F.
1807:                 .AllowRowSizing    = .F.
1808:                 .DeleteMark        = .F.

*-- Linhas 2017 a 2074:
2017:         CATCH TO loc_oErro
2018:             MsgErro(loc_oErro.Message + CHR(13) + ;
2019:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2020:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarContainer3")
2021:         ENDTRY
2022:     ENDPROC
2023: 
2024:     *--------------------------------------------------------------------------
2025:     * ConfigurarCamposTotais - Ultimos controles filhos diretos do form:
2026:     * totais da grade principal (txt_4c_TotQtd/TotEst/TotPrz, Top=349,
2027:     * logo abaixo de grd_4c_Itens - distintos dos hom?nimos dentro de
2028:     * cnt_4c_Container3, que mostram o detalhe da LINHA selecionada, nao o
2029:     * somatorio geral), a foto do item (img_4c_ImgFigJpg, nasce oculta) e a
2030:     * observacao do item (lbl_4c_TxtObsItens/obj_4c_ObsItens). Todos
2031:     * alimentados por GradeItens.AfterRowColChange/Column6.Text1.LostFocus
2032:     * na Fase 7-8 - aqui e so a moldura visual.
2033:     *--------------------------------------------------------------------------
2034:     PROTECTED PROCEDURE ConfigurarCamposTotais()
2035:         LOCAL loc_oErro
2036: 
2037:         TRY
2038:             THIS.AddObject("txt_4c_TotQtd", "TextBox")
2039:             WITH THIS.txt_4c_TotQtd
2040:                 .Height        = 23
2041:                 .Width         = 80
2042:                 .Left          = 417
2043:                 .Top           = 349
2044:                 .InputMask     = "9,999.99"
2045:                 .SpecialEffect = 1
2046:                 .Value         = 0
2047:                 .ReadOnly      = .T.
2048:                 .Visible       = .T.
2049:             ENDWITH
2050: 
2051:             THIS.AddObject("txt_4c_TotEst", "TextBox")
2052:             WITH THIS.txt_4c_TotEst
2053:                 .Height        = 23
2054:                 .Width         = 81
2055:                 .Left          = 498
2056:                 .Top           = 349
2057:                 .InputMask     = "9,999.99"
2058:                 .SpecialEffect = 1
2059:                 .Value         = 0
2060:                 .ReadOnly      = .T.
2061:                 .Visible       = .T.
2062:             ENDWITH
2063: 
2064:             THIS.AddObject("txt_4c_TotPrz", "TextBox")
2065:             WITH THIS.txt_4c_TotPrz
2066:                 .Height        = 23
2067:                 .Width         = 82
2068:                 .Left          = 580
2069:                 .Top           = 349
2070:                 .InputMask     = "9,999.99"
2071:                 .SpecialEffect = 1
2072:                 .Value         = 0
2073:                 .ReadOnly      = .T.
2074:                 .Visible       = .T.

*-- Linhas 2119 a 2598:
2119:         CATCH TO loc_oErro
2120:             MsgErro(loc_oErro.Message + CHR(13) + ;
2121:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2122:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposTotais")
2123:         ENDTRY
2124:     ENDPROC
2125: 
2126:     *==========================================================================
2127:     * LOOKUPS DO grd_4c_Pedras (Container4 - "Requisicao de componentes
2128:     * adicionais")
2129:     *
2130:     * Legado (SIGPRGLP.Container4.GradePedra):
2131:     *   Column1.Text1.Valid -> CreateObject('fwBuscaExt', <conn>, 'SigCdPro',
2132:     *       'crListaRemota', 'CPros', This.Value, 'Selecao', 1000);
2133:     *       se Not plAchouRegistro -> mAddColuna('CPros'), mAddColuna('DPros'),
2134:     *       Show(); This.Value = CrListaRemota.Cpros;
2135:     *       Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
2136:     *               SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra;
2137:     *       Use In crListaRemota; GradePedra.Refresh
2138:     *   Column5.Text1.Valid -> mesmo lookup, sem o Replace (so o codigo do
2139:     *       produto substituto)
2140:     *   Column4/Column5.When -> Return (Not Empty(Column1.Text1.Value))
2141:     *   Column5.Text1.LostFocus -> garante uma linha em branco no fim do
2142:     *       SelPedra (Locate For Empty(Cpros) / Append Blank) e desce o cursor
2143:     *
2144:     * Migrado: o picker canonico do projeto eh FormBuscaAuxiliar (substitui
2145:     * fwBuscaExt). Contrato obrigatorio (CLAUDE.md regra #37): 1o argumento eh
2146:     * o HANDLE da conexao (regra #36); Show() SO quando this_lAchouRegistro
2147:     * for .F.; atribuicao SO sob this_lSelecionou - fora da guarda, uma
2148:     * desistencia do usuario ZERARIA o codigo ja digitado.
2149:     *==========================================================================
2150: 
2151:     *--------------------------------------------------------------------------
2152:     * PedraProdutoKeyPress - Gatilho do lookup da coluna Produto. PUBLIC
2153:     * (BINDEVENT falha em silencio com PROTECTED). LPARAMETERS obrigatorio,
2154:     * senao o VFP9 estoura "No PARAMETER statement is found".
2155:     *--------------------------------------------------------------------------
2156:     PROCEDURE PedraProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2157:         *-- ENTER(13)/TAB(9) reproduzem o Valid do legado (que rodava ao sair
2158:         *-- da celula); F4(115) eh o atalho de lookup do projeto.
2159:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2160:             THIS.ValidarPedraProduto()
2161:         ENDIF
2162:     ENDPROC
2163: 
2164:     *--------------------------------------------------------------------------
2165:     * PedraProdutoDblClick - Duplo clique na celula Produto abre o picker
2166:     * direto (equivalente ao F4).
2167:     *--------------------------------------------------------------------------
2168:     PROCEDURE PedraProdutoDblClick()
2169:         THIS.AbrirLookupPedraProduto()
2170:     ENDPROC
2171: 
2172:     *--------------------------------------------------------------------------
2173:     * ValidarPedraProduto - Valid da Column1.Text1 do GradePedra. Com a
2174:     * celula vazia o legado nao faz nada ("If Not Empty(This.Value)"); com
2175:     * valor digitado tenta o casamento EXATO em SigCdPro e, achando, ja
2176:     * preenche Descricao/Unidade no SelPedra sem exibir dialogo. Nao achando,
2177:     * cai no picker (AbrirLookupPedraProduto), que repete o padrao do legado
2178:     * (o fwBuscaExt tambem so mostrava a lista quando plAchouRegistro = .F.).
2179:     *--------------------------------------------------------------------------
2180:     PROCEDURE ValidarPedraProduto()
2181:         LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro
2182: 
2183:         loc_lAchou = .F.
2184: 
2185:         TRY
2186:             loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
2187:             loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2188: 
2189:             IF !EMPTY(loc_cValor)
2190:                 IF USED("cursor_4c_BuscaPedra")
2191:                     USE IN cursor_4c_BuscaPedra
2192:                 ENDIF
2193: 
2194:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2195:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2196:                         "SELECT cpros, dpros, cunis FROM SigCdPro " + ;
2197:                         "WHERE cpros = " + EscaparSQL(loc_cValor), ;
2198:                         "cursor_4c_BuscaPedra")
2199: 
2200:                     IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra") ;
2201:                        AND RECCOUNT("cursor_4c_BuscaPedra") = 1
2202:                         SELECT cursor_4c_BuscaPedra
2203:                         GO TOP
2204:                         THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
2205:                                                  ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
2206:                                                  ALLTRIM(cursor_4c_BuscaPedra.cunis))
2207:                         loc_lAchou = .T.
2208:                     ENDIF
2209:                 ENDIF
2210: 
2211:                 IF USED("cursor_4c_BuscaPedra")
2212:                     USE IN cursor_4c_BuscaPedra
2213:                 ENDIF
2214: 
2215:                 *-- Sem casamento exato o legado abria a lista - NUNCA
2216:                 *-- MsgAviso("nao encontrado") + limpar o campo antes do
2217:                 *-- picker (anti-padrao ja registrado no CLAUDE.md).
2218:                 IF !loc_lAchou
2219:                     THIS.AbrirLookupPedraProduto()
2220:                 ENDIF
2221:             ENDIF
2222:         CATCH TO loc_oErro
2223:             MsgErro(loc_oErro.Message + CHR(13) + ;
2224:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2225:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraProduto")
2226:         ENDTRY
2227:     ENDPROC
2228: 
2229:     *--------------------------------------------------------------------------
2230:     * AbrirLookupPedraProduto - Picker de SigCdPro para a coluna Produto.
2231:     * Substitui o "CreateObject('fwBuscaExt', ..., 'SigCdPro', 'crListaRemota',
2232:     * 'CPros', This.Value, 'Selecao', 1000)" do legado.
2233:     *--------------------------------------------------------------------------
2234:     PROCEDURE AbrirLookupPedraProduto()
2235:         LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro
2236: 
2237:         *-- Guarda de reentrancia: o picker eh MODAL e o foco sai/volta da
2238:         *-- celula, podendo redisparar o proprio gatilho.
2239:         IF THIS.this_lLookupAberto
2240:             RETURN
2241:         ENDIF
2242:         THIS.this_lLookupAberto = .T.
2243: 
2244:         TRY
2245:             loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.Text1
2246:             loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2247: 
2248:             IF USED("cursor_4c_BuscaPedra")
2249:                 USE IN cursor_4c_BuscaPedra
2250:             ENDIF
2251: 
2252:             *-- 1o argumento = HANDLE da conexao (CLAUDE.md regra #36)
2253:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2254:                 "SigCdPro", ;
2255:                 "cursor_4c_BuscaPedra", ;
2256:                 "cpros", ;
2257:                 loc_cValor, ;
2258:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
2259: 
2260:             IF VARTYPE(loc_oBusca) = "O"
2261:                 *-- Show() SO quando o Init nao resolveu sozinho o valor
2262:                 IF !loc_oBusca.this_lAchouRegistro
2263:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
2264:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2265:                     loc_oBusca.Show()
2266:                 ENDIF
2267: 
2268:                 *-- Atribuicao SO sob a guarda de selecao
2269:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra")
2270:                     SELECT cursor_4c_BuscaPedra
2271:                     THIS.AplicarPedraProduto(ALLTRIM(cursor_4c_BuscaPedra.cpros), ;
2272:                                              ALLTRIM(cursor_4c_BuscaPedra.dpros), ;
2273:                                              ALLTRIM(cursor_4c_BuscaPedra.cunis))
2274:                 ENDIF
2275: 
2276:                 loc_oBusca.Release()
2277:             ENDIF
2278: 
2279:             IF USED("cursor_4c_BuscaPedra")
2280:                 USE IN cursor_4c_BuscaPedra
2281:             ENDIF
2282:         CATCH TO loc_oErro
2283:             MsgErro(loc_oErro.Message + CHR(13) + ;
2284:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2285:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraProduto")
2286:         ENDTRY
2287: 
2288:         *-- Limpar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
2289:         THIS.this_lLookupAberto = .F.
2290:     ENDPROC
2291: 
2292:     *--------------------------------------------------------------------------
2293:     * AplicarPedraProduto - Efetiva a escolha do produto na linha corrente do
2294:     * SelPedra. Transcreve o trecho final do Valid legado:
2295:     *   This.Value = CrListaRemota.Cpros
2296:     *   Replace SelPedra.Dpros WITH CrListaRemota.Dpros,
2297:     *           SelPedra.Cunis WITH CrListaRemota.Cunis IN SelPedra
2298:     *   ThisForm.Container4.GradePedra.Refresh
2299:     * O SelPedra eh cursor de trabalho criado pelo form PAI (mesma
2300:     * DataSession) - por isso o USED() antes do REPLACE.
2301:     *--------------------------------------------------------------------------
2302:     PROTECTED PROCEDURE AplicarPedraProduto(par_cCodigo, par_cDescricao, par_cUnidade)
2303:         LOCAL loc_oGrid
2304: 
2305:         loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
2306:         loc_oGrid.Column1.Text1.Value = par_cCodigo
2307: 
2308:         IF USED("SelPedra") AND !EOF("SelPedra")
2309:             REPLACE SelPedra.Dpros WITH par_cDescricao, ;
2310:                     SelPedra.Cunis WITH par_cUnidade IN SelPedra
2311:         ENDIF
2312: 
2313:         *-- Com o Produto preenchido, o gate do When legado passa a liberar
2314:         *-- as colunas Qtde e Produto substituto.
2315:         THIS.AjustarColunasPedra()
2316:         loc_oGrid.Refresh()
2317:     ENDPROC
2318: 
2319:     *--------------------------------------------------------------------------
2320:     * PedraSubstitutoKeyPress - Gatilho do lookup da coluna Produto
2321:     * substituto (Column5). PUBLIC + LPARAMETERS, mesmas razoes da Column1.
2322:     *--------------------------------------------------------------------------
2323:     PROCEDURE PedraSubstitutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2324:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2325:             THIS.ValidarPedraSubstituto()
2326:         ENDIF
2327:     ENDPROC
2328: 
2329:     *--------------------------------------------------------------------------
2330:     * PedraSubstitutoDblClick - Duplo clique abre o picker direto.
2331:     *--------------------------------------------------------------------------
2332:     PROCEDURE PedraSubstitutoDblClick()
2333:         THIS.AbrirLookupPedraSubstituto()
2334:     ENDPROC
2335: 
2336:     *--------------------------------------------------------------------------
2337:     * ValidarPedraSubstituto - Valid da Column5.Text1 do GradePedra. Igual ao
2338:     * da Column1, SEM o Replace de Descricao/Unidade (o legado so atribui o
2339:     * codigo nesta coluna).
2340:     *--------------------------------------------------------------------------
2341:     PROCEDURE ValidarPedraSubstituto()
2342:         LOCAL loc_oTxt, loc_cValor, loc_nResultado, loc_lAchou, loc_oErro
2343: 
2344:         loc_lAchou = .F.
2345: 
2346:         TRY
2347:             loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
2348:             loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2349: 
2350:             IF !EMPTY(loc_cValor)
2351:                 IF USED("cursor_4c_BuscaPedra2")
2352:                     USE IN cursor_4c_BuscaPedra2
2353:                 ENDIF
2354: 
2355:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2356:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2357:                         "SELECT cpros, dpros FROM SigCdPro " + ;
2358:                         "WHERE cpros = " + EscaparSQL(loc_cValor), ;
2359:                         "cursor_4c_BuscaPedra2")
2360: 
2361:                     IF loc_nResultado > 0 AND USED("cursor_4c_BuscaPedra2") ;
2362:                        AND RECCOUNT("cursor_4c_BuscaPedra2") = 1
2363:                         SELECT cursor_4c_BuscaPedra2
2364:                         GO TOP
2365:                         THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
2366:                         loc_lAchou = .T.
2367:                     ENDIF
2368:                 ENDIF
2369: 
2370:                 IF USED("cursor_4c_BuscaPedra2")
2371:                     USE IN cursor_4c_BuscaPedra2
2372:                 ENDIF
2373: 
2374:                 IF !loc_lAchou
2375:                     THIS.AbrirLookupPedraSubstituto()
2376:                 ENDIF
2377:             ENDIF
2378:         CATCH TO loc_oErro
2379:             MsgErro(loc_oErro.Message + CHR(13) + ;
2380:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2381:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarPedraSubstituto")
2382:         ENDTRY
2383:     ENDPROC
2384: 
2385:     *--------------------------------------------------------------------------
2386:     * AbrirLookupPedraSubstituto - Picker de SigCdPro para a coluna Produto
2387:     * substituto (Column5.Text1 do GradePedra).
2388:     *--------------------------------------------------------------------------
2389:     PROCEDURE AbrirLookupPedraSubstituto()
2390:         LOCAL loc_oBusca, loc_oTxt, loc_cValor, loc_oErro
2391: 
2392:         IF THIS.this_lLookupAberto
2393:             RETURN
2394:         ENDIF
2395:         THIS.this_lLookupAberto = .T.
2396: 
2397:         TRY
2398:             loc_oTxt   = THIS.cnt_4c_Container4.grd_4c_Pedras.Column5.Text1
2399:             loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2400: 
2401:             IF USED("cursor_4c_BuscaPedra2")
2402:                 USE IN cursor_4c_BuscaPedra2
2403:             ENDIF
2404: 
2405:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2406:                 "SigCdPro", ;
2407:                 "cursor_4c_BuscaPedra2", ;
2408:                 "cpros", ;
2409:                 loc_cValor, ;
2410:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
2411: 
2412:             IF VARTYPE(loc_oBusca) = "O"
2413:                 IF !loc_oBusca.this_lAchouRegistro
2414:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
2415:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2416:                     loc_oBusca.Show()
2417:                 ENDIF
2418: 
2419:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPedra2")
2420:                     SELECT cursor_4c_BuscaPedra2
2421:                     THIS.AplicarPedraSubstituto(ALLTRIM(cursor_4c_BuscaPedra2.cpros))
2422:                 ENDIF
2423: 
2424:                 loc_oBusca.Release()
2425:             ENDIF
2426: 
2427:             IF USED("cursor_4c_BuscaPedra2")
2428:                 USE IN cursor_4c_BuscaPedra2
2429:             ENDIF
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message + CHR(13) + ;
2432:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2433:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupPedraSubstituto")
2434:         ENDTRY
2435: 
2436:         THIS.this_lLookupAberto = .F.
2437:     ENDPROC
2438: 
2439:     *--------------------------------------------------------------------------
2440:     * AplicarPedraSubstituto - "This.Value = CrListaRemota.Cpros" +
2441:     * "ThisForm.Container4.GradePedra.Refresh" do Valid legado da Column5.
2442:     *--------------------------------------------------------------------------
2443:     PROTECTED PROCEDURE AplicarPedraSubstituto(par_cCodigo)
2444:         LOCAL loc_oGrid
2445: 
2446:         loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
2447:         loc_oGrid.Column5.Text1.Value = par_cCodigo
2448:         loc_oGrid.Refresh()
2449:     ENDPROC
2450: 
2451:     *--------------------------------------------------------------------------
2452:     * PedraSubstitutoLostFocus - LostFocus da Column5.Text1 do GradePedra.
2453:     * Transcricao do legado:
2454:     *   SELECT SelPedra / xPosicao = RECNO() / Locate For Empty(Cpros)
2455:     *   If Eof() / Append Blank / EndIf
2456:     *   Locate for Recno() = xPosicao / KEYBOARD '{DNARROW}'
2457:     * Ou seja: garante que exista sempre UMA linha em branco no fim do
2458:     * cursor (para o usuario continuar digitando), volta para a linha em que
2459:     * estava e desce uma linha. PUBLIC (BINDEVENT).
2460:     *--------------------------------------------------------------------------
2461:     PROCEDURE PedraSubstitutoLostFocus()
2462:         LOCAL loc_nPosicao, loc_cAliasAnterior, loc_oErro
2463: 
2464:         TRY
2465:             IF USED("SelPedra")
2466:                 loc_cAliasAnterior = ALIAS()
2467: 
2468:                 SELECT SelPedra
2469:                 loc_nPosicao = RECNO("SelPedra")
2470: 
2471:                 LOCATE FOR EMPTY(SelPedra.Cpros)
2472:                 IF EOF("SelPedra")
2473:                     APPEND BLANK IN SelPedra
2474:                 ENDIF
2475: 
2476:                 *-- "Locate for Recno() = xPosicao" do legado: volta para o
2477:                 *-- registro em que o usuario estava
2478:                 IF loc_nPosicao > 0 AND loc_nPosicao <= RECCOUNT("SelPedra")
2479:                     GO loc_nPosicao IN SelPedra
2480:                 ENDIF
2481: 
2482:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2483:                     SELECT (loc_cAliasAnterior)
2484:                 ENDIF
2485: 
2486:                 KEYBOARD "{DNARROW}"
2487:             ENDIF
2488:         CATCH TO loc_oErro
2489:             MsgErro(loc_oErro.Message + CHR(13) + ;
2490:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2491:                 "Procedure: " + loc_oErro.Procedure, "Erro em PedraSubstitutoLostFocus")
2492:         ENDTRY
2493:     ENDPROC
2494: 
2495:     *--------------------------------------------------------------------------
2496:     * PedrasAfterRowColChange - Reavalia, a cada troca de linha/coluna do
2497:     * grd_4c_Pedras, o gate que o legado escrevia no When das Column4/Column5:
2498:     *   "RETURN (Not EMPTY(ThisForm.Container4.GradePedra.Column1.Text1.Value))"
2499:     * Guarda tambem o ThisForm.AntValue que o When da Column5 registrava.
2500:     * PUBLIC e com o parametro do evento declarado (AfterRowColChange recebe
2501:     * nColIndex) - CLAUDE.md regra #3.
2502:     *--------------------------------------------------------------------------
2503:     PROCEDURE PedrasAfterRowColChange(par_nColIndex)
2504:         THIS.AjustarColunasPedra()
2505:     ENDPROC
2506: 
2507:     *--------------------------------------------------------------------------
2508:     * AjustarColunasPedra - Aplica o gate do When legado: Qtde (Column4) e
2509:     * Produto substituto (Column5) so aceitam digitacao com o Produto
2510:     * (Column1) preenchido. Column.ReadOnly eh definido DEPOIS do
2511:     * Grid.ReadOnly (o do grid propaga para as colunas e sobrescreveria).
2512:     *--------------------------------------------------------------------------
2513:     PROTECTED PROCEDURE AjustarColunasPedra()
2514:         LOCAL loc_oGrid, loc_lLiberado, loc_oErro
2515: 
2516:         TRY
2517:             loc_oGrid = THIS.cnt_4c_Container4.grd_4c_Pedras
2518: 
2519:             loc_lLiberado = !EMPTY(ALLTRIM(TRANSFORM(loc_oGrid.Column1.Text1.Value)))
2520: 
2521:             loc_oGrid.Column4.ReadOnly       = !loc_lLiberado
2522:             loc_oGrid.Column4.Text1.ReadOnly = !loc_lLiberado
2523:             loc_oGrid.Column5.ReadOnly       = !loc_lLiberado
2524:             loc_oGrid.Column5.Text1.ReadOnly = !loc_lLiberado
2525: 
2526:             *-- "ThisForm.AntValue = This.Value" do When da Column5
2527:             THIS.this_cAntValue = ALLTRIM(TRANSFORM(loc_oGrid.Column5.Text1.Value))
2528:         CATCH TO loc_oErro
2529:             MsgErro(loc_oErro.Message + CHR(13) + ;
2530:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2531:                 "Procedure: " + loc_oErro.Procedure, "Erro em AjustarColunasPedra")
2532:         ENDTRY
2533:     ENDPROC
2534: 
2535:     *--------------------------------------------------------------------------
2536:     * PrepararCursoresDeTrabalho - Completa a preparacao de dados que o Init
2537:     * legado faz DEPOIS de montar a tela e da qual os eventos desta fase
2538:     * dependem (transcrito de SIGPRGLP.Init, dump linhas 2891-2959):
2539:     *
2540:     *   SELECT SelPedra / IF RECCOUNT() = 0 / APPEND BLANK    -> a grade de
2541:     *       Requisicoes (cmd_4c_Pedras) abre com UMA linha em branco pronta
2542:     *       para digitacao; sem isso o Click liga o grid a um cursor vazio.
2543:     *   Create Cursor TmpSaldU (Cpros c(14), KeySelm L)       -> marca os
2544:     *       produtos cujo estoque foi escolhido MANUALMENTE (consumido por
2545:     *       BtnConfirmarDispGrupoClick).
2546:     *   crSigCdCom (SigCdTpc + SigCdCom)                      -> tipos de
2547:     *       componente que entram no custo (consumido pelo AtualizaPeso).
2548:     *   Bind do grid do Container3 + Set Order/Set Key de TmpSaldG.
2549:     *   SetAll('ReadOnly', .t.) da grade principal quando SigCdPam.TransfRes
2550:     *       esta vazio (sem operacao de transferencia nao se edita Produzir).
2551:     *   Totais Tot_Qtd/Tot_Est/Tot_Prz somados de TmpFinal.
2552:     *
2553:     * Todos os cursores de trabalho chegam prontos do form pai, na
2554:     * DataSession privada compartilhada - por isso cada bloco eh guardado
2555:     * por USED(): em modo de teste de UI nenhum deles existe e o metodo
2556:     * simplesmente nao faz nada, sem erro.
2557:     *--------------------------------------------------------------------------
2558:     PROTECTED PROCEDURE PrepararCursoresDeTrabalho()
2559:         LOCAL loc_oErro, loc_nResultado, loc_cSQL
2560: 
2561:         TRY
2562:             *-- Linha em branco no SelPedra (Init legado)
2563:             IF USED("SelPedra")
2564:                 SELECT SelPedra
2565:                 IF RECCOUNT("SelPedra") = 0
2566:                     APPEND BLANK
2567:                 ENDIF
2568:             ENDIF
2569: 
2570:             *-- TmpSaldU - produtos com selecao MANUAL de estoque
2571:             IF !USED("TmpSaldU")
2572:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
2573:                 INDEX ON Cpros TAG Cpros
2574:             ENDIF
2575: 
2576:             *-- crSigCdCom: "Select a.Tipos, a.Custos, b.CGrus From SigCdTpc a,
2577:             *-- SigCdCom b Where a.Tipos = b.Tipos" + "Index On Tipos + CGrus
2578:             *-- Tag Tipos" do Init legado. Vai para cursor temporario e dai
2579:             *-- para cursor READWRITE porque cursor de SQLEXEC nasce
2580:             *-- somente-leitura e nao aceita INDEX ON.
2581:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !USED("crSigCdCom")
2582:                 loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus" + ;
2583:                            "  FROM SigCdTpc a, SigCdCom b" + ;
2584:                            " WHERE a.Tipos = b.Tipos"
2585: 
2586:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ComTmp")
2587: 
2588:                 IF loc_nResultado >= 0 AND USED("cursor_4c_ComTmp")
2589:                     SELECT * FROM cursor_4c_ComTmp INTO CURSOR crSigCdCom READWRITE
2590:                     USE IN cursor_4c_ComTmp
2591:                     SELECT crSigCdCom
2592:                     INDEX ON Tipos + CGrus TAG Tipos
2593:                 ELSE
2594:                     MsgErro("Falha ao carregar os tipos de componente (crSigCdCom)." + ;
2595:                         CHR(13) + CapturarErroSQL(), "Erro")
2596:                 ENDIF
2597:             ENDIF
2598: 

*-- Linhas 2622 a 3190:
2622:         CATCH TO loc_oErro
2623:             MsgErro(loc_oErro.Message + CHR(13) + ;
2624:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2625:                 "Procedure: " + loc_oErro.Procedure, "Erro em PrepararCursoresDeTrabalho")
2626:         ENDTRY
2627:     ENDPROC
2628: 
2629:     *--------------------------------------------------------------------------
2630:     * AplicarFaixaSaldoContas - Restringe TmpSaldG ao item corrente de
2631:     * TmpFinal (Produto + Cor + Tamanho), que eh o "Set Key To TmpFinal.Cpros
2632:     * + TmpFinal.CodCors + TmpFinal.CodTams" do Init legado - reemitido la
2633:     * pelo AfterRowColChange a cada troca de linha da grade principal.
2634:     *
2635:     * NAO da para usar SET KEY aqui. O indice de TmpSaldG eh COMPOSTO
2636:     * (Cpros + CodCors + CodTams + Str(Priors,2) + Grupos + Estos) e a
2637:     * chave acima cobre so os 22 primeiros caracteres; o legado roda com o
2638:     * SET EXACT OFF default do VFP, mas o config.prg deste projeto liga
2639:     * SET EXACT ON (linha 231), e com ele faixa/SEEK parciais sobre indice
2640:     * composto NUNCA casam. Medido no VFP9 em 2026-09-29:
2641:     *
2642:     *     EXACT ON  -> SET KEY parcial: eof=.T. | SEEK parcial: .F.
2643:     *     EXACT OFF -> SET KEY parcial: eof=.F. | SEEK parcial: .T.
2644:     *
2645:     * e a faixa eh avaliada na NAVEGACAO, nao no comando - setar SET KEY sob
2646:     * EXACT OFF e restaurar EXACT ON em seguida tambem devolve eof=.T.
2647:     * O efeito seria invisivel: com a faixa vazia o grid do Container3 fica
2648:     * sempre em branco e, pior, "REPLACE TmpSaldG.Disps" em EOF NAO da erro
2649:     * (medido) - a baixa de estoque por conta simplesmente nao aconteceria.
2650:     *
2651:     * A saida eh SET FILTER com "==" (comparacao exata, alheia ao SET
2652:     * EXACT), com o valor da chave EMBUTIDO por macro para o filtro
2653:     * ficar CONGELADO no item corrente, como o SET KEY do legado - um
2654:     * filtro que referenciasse TmpFinal seria reavaliado a cada navegacao e
2655:     * quebraria se TmpFinal fosse fechado ou chegasse a EOF.
2656:     *--------------------------------------------------------------------------
2657:     PROCEDURE AplicarFaixaSaldoContas()
2658:         LOCAL loc_cChave, loc_cFiltro, loc_oErro
2659: 
2660:         TRY
2661:             IF USED("TmpSaldG")
2662:                 SELECT TmpSaldG
2663: 
2664:                 IF USED("TmpFinal") AND !EOF("TmpFinal")
2665:                     loc_cChave = TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2666:                     *-- "]" quebraria o delimitador do literal montado abaixo;
2667:                     *-- nenhum codigo de produto/cor/tamanho o usa
2668:                     loc_cChave = STRTRAN(loc_cChave, "]", " ")
2669: 
2670:                     loc_cFiltro = "Cpros + CodCors + CodTams == [" + loc_cChave + "]"
2671:                     SET FILTER TO &loc_cFiltro
2672:                 ELSE
2673:                     SET FILTER TO
2674:                 ENDIF
2675: 
2676:                 GO TOP
2677:             ENDIF
2678:         CATCH TO loc_oErro
2679:             MsgErro(loc_oErro.Message + CHR(13) + ;
2680:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2681:                 "Procedure: " + loc_oErro.Procedure, "Erro em AplicarFaixaSaldoContas")
2682:         ENDTRY
2683:     ENDPROC
2684: 
2685:     *--------------------------------------------------------------------------
2686:     * LigarGradeContas - Liga o grid do Container3 (rodape SEMPRE visivel,
2687:     * "Estoque Disponivel" por Grupo/Conta) ao cursor TmpSaldG, transcrito
2688:     * de "With ThisForm.Container3.GradeDisp ... EndWith" do Init legado.
2689:     *
2690:     * Column4 exibe uma EXPRESSAO ("TmpSaldG.Saldo - TmpSaldG.Disps" = o
2691:     * que ja foi utilizado), nao uma coluna - igual ao legado.
2692:     *
2693:     * .SetAll("ReadOnly", .T.) vem ANTES de .Column6.ReadOnly = .F. porque o
2694:     * ReadOnly do Grid propaga para as colunas e sobrescreveria (regra #18).
2695:     * Column6 (Emp) so libera quando o usuario tem o acesso PRIORIDADE.
2696:     *--------------------------------------------------------------------------
2697:     PROTECTED PROCEDURE LigarGradeContas()
2698:         LOCAL loc_oErro
2699: 
2700:         TRY
2701:             WITH THIS.cnt_4c_Container3.grd_4c_DispConta
2702:                 .RecordSource          = "TmpSaldG"
2703:                 .Column1.ControlSource = "TmpSaldG.Grupos"
2704:                 .Column2.ControlSource = "TmpSaldG.Estos"
2705:                 .Column3.ControlSource = "TmpSaldG.Saldo"
2706:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
2707:                 .Column5.ControlSource = "TmpSaldG.Disps"
2708:                 .Column6.ControlSource = "TmpSaldG.Emps"
2709: 
2710:                 .SetAll("ReadOnly", .T.)
2711: 
2712:                 IF fChecaAcesso("SIGPRGLO", "PRIORIDADE")
2713:                     .Column6.ReadOnly              = .F.
2714:                     THIS.cmd_4c_SelEstoque.Enabled = .T.
2715:                 ENDIF
2716: 
2717:                 .Refresh()
2718:             ENDWITH
2719:         CATCH TO loc_oErro
2720:             MsgErro(loc_oErro.Message + CHR(13) + ;
2721:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2722:                 "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeContas")
2723:         ENDTRY
2724:     ENDPROC
2725: 
2726:     *--------------------------------------------------------------------------
2727:     * ConfigurarEventos - Liga cada botao de acao ao seu handler.
2728:     *
2729:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO
2730:     * com metodo PROTECTED (CLAUDE.md regra #3).
2731:     *
2732:     * Os nomes seguem a ACAO e nao o nome do objeto legado, que eh misnomer
2733:     * em dois casos: o "CancelaDisp" do Container2 e do Container5 nao
2734:     * cancela nada - eh o OK que aplica a quantidade digitada na coluna
2735:     * Utilizar e baixa o estoque (o SCX do Container5 ate rotula o botao
2736:     * como "OK"). Nos Containers 1 e 4 o mesmo nome de classe so fecha o
2737:     * painel, e ai o nome Fechar* eh o correto.
2738:     *--------------------------------------------------------------------------
2739:     PROTECTED PROCEDURE ConfigurarEventos()
2740:         LOCAL loc_oErro
2741: 
2742:         TRY
2743:             BINDEVENT(THIS.cmd_4c_Disponivel,   "Click", THIS, "BtnDisponivelClick")
2744:             BINDEVENT(THIS.cmd_4c_SelEstoque,   "Click", THIS, "BtnSelEstoqueClick")
2745:             BINDEVENT(THIS.cmd_4c_TotLinha,     "Click", THIS, "BtnTotLinhaClick")
2746:             BINDEVENT(THIS.cmd_4c_Pedras,       "Click", THIS, "BtnPedrasClick")
2747:             BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
2748:             BINDEVENT(THIS.cmd_4c_Cancelar,     "Click", THIS, "BtnCancelarClick")
2749: 
2750:             BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", ;
2751:                 THIS, "BtnConfirmarDispProdutoClick")
2752:             BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", ;
2753:                 THIS, "BtnConfirmarDispGrupoClick")
2754:             BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", ;
2755:                 THIS, "BtnFecharPedrasClick")
2756:             BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin,  "Click", ;
2757:                 THIS, "BtnFecharLinhasClick")
2758: 
2759:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
2760: 
2761:             *-- Grade principal (GradeItens) - troca de linha/coluna alimenta
2762:             *-- Container3/totais/imagem/observacao (legado: AfterRowColChange)
2763:             BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
2764:                 THIS, "GradeItensAfterRowColChange")
2765: 
2766:             *-- Coluna Produzir (Column6, fisica e por .Name - fix do bug de
2767:             *-- troca com a Column3, ver ConfigurarGradeItens) - When/Valid/
2768:             *-- LostFocus do legado
2769:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "GotFocus",  THIS, "ItemProduzirGotFocus")
2770:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "KeyPress",  THIS, "ItemProduzirKeyPress")
2771:             BINDEVENT(THIS.grd_4c_Itens.Column6.Text1, "LostFocus", THIS, "ItemProduzirLostFocus")
2772: 
2773:             *-- Demais colunas da grade principal - GotFocus redireciona para
2774:             *-- a coluna Produzir (legado: "ThisForm.GradeItens.Column6.
2775:             *-- Text1.SetFocus" nas Column1/3/4/5/7/8; Column2 e Column9 nao
2776:             *-- tem esse redirecionamento no dump)
2777:             BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2778:             BINDEVENT(THIS.grd_4c_Itens.Column3.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2779:             BINDEVENT(THIS.grd_4c_Itens.Column4.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2780:             BINDEVENT(THIS.grd_4c_Itens.Column5.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2781:             BINDEVENT(THIS.grd_4c_Itens.Column7.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2782:             BINDEVENT(THIS.grd_4c_Itens.Column8.Text1, "GotFocus", THIS, "ItemFocoColunaProduzir")
2783: 
2784:             *-- Coluna Utilizar dos dois paineis de estoque (Container2 =
2785:             *-- Produto/Cor/Tam, Container5 = Grupo/Conta) - Valid do legado,
2786:             *-- emulado por KeyPress (BINDEVENT "Valid" nao dispara de forma
2787:             *-- confiavel em TextBox). Reatribuir o MESMO ColumnCount nos
2788:             *-- Click dos botoes Disponivel/Estoques NAO derruba este
2789:             *-- BINDEVENT - mesmo comportamento ja medido e documentado em
2790:             *-- ConfigurarContainer4/BtnPedrasClick.
2791:             BINDEVENT(THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1, ;
2792:                 "KeyPress", THIS, "DispProdutoUtilizarKeyPress")
2793:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
2794:                 "KeyPress", THIS, "DispGrupoUtilizarKeyPress")
2795:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1, ;
2796:                 "LostFocus", THIS, "DispGrupoUtilizarLostFocus")
2797:         CATCH TO loc_oErro
2798:             MsgErro(loc_oErro.Message + CHR(13) + ;
2799:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2800:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarEventos")
2801:         ENDTRY
2802:     ENDPROC
2803: 
2804:     *--------------------------------------------------------------------------
2805:     * BtnDisponivelClick - botao "Disponiveis" (SIGPRGLP.Disponivel.Click).
2806:     * Abre o Container2 com o estoque disponivel do item corrente em TODOS
2807:     * os tamanhos (TmpSaldo filtrado por Produto+Cor), para o usuario
2808:     * escolher de qual tamanho tirar a quantidade.
2809:     *
2810:     * Os Width/Header1.Caption sao reaplicados DEPOIS do RecordSource
2811:     * porque eh isso que o legado faz - e os valores dele divergem de
2812:     * proposito do SCX (Column1 = 80 e nao 108; Column3 = 24 e nao 38).
2813:     *
2814:     * "m." nos nomes das variaveis LOCAIS dentro do SELECT VFP local eh
2815:     * obrigatorio: sem ele o VFP resolve o identificador como COLUNA.
2816:     *
2817:     * _TALLY eh capturado na linha seguinte ao SELECT - no legado ele eh
2818:     * lido varias linhas adiante, o que so funciona por nao haver comando
2819:     * de dados no meio.
2820:     *--------------------------------------------------------------------------
2821:     PROCEDURE BtnDisponivelClick()
2822:         LOCAL loc_cCpro, loc_cCor, loc_nTally, loc_oErro
2823: 
2824:         TRY
2825:             IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldo")
2826:                 MsgAviso("Nenhum item selecionado na grade.", ;
2827:                     "Aten" + CHR(231) + CHR(227) + "o")
2828:             ELSE
2829:                 loc_cCpro = TmpFinal.Cpros
2830:                 loc_cCor  = TmpFinal.CodCors
2831: 
2832:                 IF USED("TmpDisp")
2833:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.RecordSource = ""
2834:                     USE IN TmpDisp
2835:                 ENDIF
2836: 
2837:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2838:                   FROM TmpSaldo ;
2839:                  WHERE Cpros   = m.loc_cCpro ;
2840:                    AND CodCors = m.loc_cCor ;
2841:                    AND Disps   > 0 ;
2842:                  ORDER BY Cpros, CodCors, CodTams ;
2843:                   INTO CURSOR TmpDisp READWRITE
2844: 
2845:                 loc_nTally = _TALLY
2846: 
2847:                 THIS.grd_4c_Itens.Enabled = .F.
2848: 
2849:                 IF loc_nTally = 0
2850:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + ;
2851:                         "vel Em Nenhum Tamanho!!!", "Aten" + CHR(231) + CHR(227) + "o")
2852:                     THIS.BtnConfirmarDispProdutoClick()
2853:                 ELSE
2854:                     WITH THIS.cnt_4c_Container2.grd_4c_DispProduto
2855:                         .RecordSource = "TmpDisp"
2856:                         .ColumnCount  = 5
2857: 
2858:                         .Column1.ControlSource = "TmpDisp.Cpros"
2859:                         .Column2.ControlSource = "TmpDisp.CodCors"
2860:                         .Column3.ControlSource = "TmpDisp.CodTams"
2861:                         .Column4.ControlSource = "TmpDisp.Disps"
2862:                         .Column5.ControlSource = "TmpDisp.Utilizar"
2863: 
2864:                         .Column1.Width = 80
2865:                         .Column2.Width = 38
2866:                         .Column3.Width = 24
2867:                         .Column4.Width = 75
2868:                         .Column5.Width = 75
2869: 
2870:                         .Column1.Header1.Caption = "Produto"
2871:                         .Column2.Header1.Caption = "Cor"
2872:                         .Column3.Header1.Caption = "Tam"
2873:                         .Column4.Header1.Caption = "Disponivel"
2874:                         .Column5.Header1.Caption = "Utilizar"
2875:                     ENDWITH
2876: 
2877:                     THIS.cmd_4c_Processar.Enabled  = .F.
2878:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
2879:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
2880:                     THIS.cmd_4c_Disponivel.Enabled = .F.
2881:                     THIS.cnt_4c_Container3.Enabled = .F.
2882:                     THIS.cnt_4c_Container2.Visible = .T.
2883: 
2884:                     THIS.cnt_4c_Container2.ZOrder(0)
2885:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
2886:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.SetFocus()
2887:                     THIS.cnt_4c_Container2.grd_4c_DispProduto.Refresh()
2888:                 ENDIF
2889:             ENDIF
2890:         CATCH TO loc_oErro
2891:             MsgErro(loc_oErro.Message + CHR(13) + ;
2892:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2893:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnDisponivelClick")
2894:         ENDTRY
2895:     ENDPROC
2896: 
2897:     *--------------------------------------------------------------------------
2898:     * BtnSelEstoqueClick - botao "Estoques" (SIGPRGLP.SelEstoque.Click).
2899:     * Abre o Container5 com o estoque disponivel do item corrente quebrado
2900:     * por Prioridade/Grupo/Conta (TmpSaldG filtrado por Produto+Cor+Tam).
2901:     *
2902:     * O legado consulta para o cursor "Resultado" e reabre o DBF dele sob o
2903:     * alias TmpDisp ("Use Dbf('Resultado') Alias TmpDisp Again") justamente
2904:     * para obter um alias GRAVAVEL - a coluna Utilizar eh digitada pelo
2905:     * usuario. Transcrito literalmente.
2906:     *
2907:     * Os Header/Width tambem divergem do SCX de proposito (Column3 = "Prior"
2908:     * com 24px, contra "Prioridade" com 80px desenhado na tela).
2909:     *--------------------------------------------------------------------------
2910:     PROCEDURE BtnSelEstoqueClick()
2911:         LOCAL loc_cCpro, loc_cCor, loc_cTam, loc_nTally, loc_oErro
2912: 
2913:         TRY
2914:             IF !USED("TmpFinal") OR EOF("TmpFinal") OR !USED("TmpSaldG")
2915:                 MsgAviso("Nenhum item selecionado na grade.", ;
2916:                     "Aten" + CHR(231) + CHR(227) + "o")
2917:             ELSE
2918:                 loc_cCpro = TmpFinal.Cpros
2919:                 loc_cCor  = TmpFinal.CodCors
2920:                 loc_cTam  = TmpFinal.CodTams
2921: 
2922:                 IF USED("TmpDisp")
2923:                     THIS.cnt_4c_Container5.grd_4c_DispGrupo.RecordSource = ""
2924:                     USE IN TmpDisp
2925:                 ENDIF
2926: 
2927:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
2928:                        000000000.000 AS Utilizar ;
2929:                   FROM TmpSaldG ;
2930:                  WHERE Cpros   = m.loc_cCpro ;
2931:                    AND CodCors = m.loc_cCor ;
2932:                    AND CodTams = m.loc_cTam ;
2933:                    AND Disps   > 0 ;
2934:                   INTO CURSOR Resultado ;
2935:                  ORDER BY 1, 2, 3, 4
2936: 
2937:                 loc_nTally = _TALLY
2938: 
2939:                 SELECT 0
2940:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
2941:                 USE IN Resultado
2942: 
2943:                 THIS.grd_4c_Itens.Enabled = .F.
2944: 
2945:                 IF loc_nTally = 0
2946:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + ;
2947:                         "vel !!!", "Aten" + CHR(231) + CHR(227) + "o")
2948:                     THIS.BtnConfirmarDispGrupoClick()
2949:                 ELSE
2950:                     WITH THIS.cnt_4c_Container5.grd_4c_DispGrupo
2951:                         .RecordSource = "TmpDisp"
2952:                         .ColumnCount  = 5
2953: 
2954:                         .Column1.ControlSource = "TmpDisp.Grupos"
2955:                         .Column2.ControlSource = "TmpDisp.Estos"
2956:                         .Column3.ControlSource = "TmpDisp.Priors"
2957:                         .Column4.ControlSource = "TmpDisp.Disps"
2958:                         .Column5.ControlSource = "TmpDisp.Utilizar"
2959: 
2960:                         .Column1.Width = 80
2961:                         .Column2.Width = 80
2962:                         .Column3.Width = 24
2963:                         .Column4.Width = 75
2964:                         .Column5.Width = 75
2965: 
2966:                         .Column1.Header1.Caption = "Grupo"
2967:                         .Column2.Header1.Caption = "Conta"
2968:                         .Column3.Header1.Caption = "Prior"
2969:                         .Column4.Header1.Caption = "Disponivel"
2970:                         .Column5.Header1.Caption = "Utilizar"
2971:                     ENDWITH
2972: 
2973:                     *-- Bloco do legado com o "Estoques" INCLUSO (eh o unico
2974:                     *-- painel que desabilita o proprio botao que o abriu)
2975:                     THIS.HabilitarCampos(.F., .T.)
2976:                     THIS.cnt_4c_Container5.Visible = .T.
2977: 
2978:                     WITH THIS.cnt_4c_Container5
2979:                         .ZOrder(0)
2980:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
2981:                             loc_cCpro + " " + loc_cCor + "/" + loc_cTam + ")"
2982:                         .txt_4c_QtPedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
2983:                         .txt_4c_QtSelec.Value  = 0
2984:                         .grd_4c_DispGrupo.Refresh()
2985:                         .grd_4c_DispGrupo.Column5.SetFocus()
2986:                         .grd_4c_DispGrupo.Refresh()
2987:                     ENDWITH
2988:                 ENDIF
2989:             ENDIF
2990:         CATCH TO loc_oErro
2991:             MsgErro(loc_oErro.Message + CHR(13) + ;
2992:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2993:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelEstoqueClick")
2994:         ENDTRY
2995:     ENDPROC
2996: 
2997:     *--------------------------------------------------------------------------
2998:     * BtnTotLinhaClick - botao "Total/Linhas" (SIGPRGLP.TotLinha.Click).
2999:     * Abre o Container1 com o resumo por linha de producao (soma de
3000:     * Saldo/Estoque/Produzir agrupada por TmpFinal.Linhas) e uma linha
3001:     * "TOTAIS" acrescentada por UNION ALL, destacada em azul e negrito
3002:     * pelas expressoes Dynamic* - transcritas do legado.
3003:     *
3004:     * A coluna "Ordem" existe so para ordenar (Order By 2, 1) e deixar
3005:     * "TOTAIS" por ultimo - nao eh exibida (o grid tem 4 colunas).
3006:     *--------------------------------------------------------------------------
3007:     PROCEDURE BtnTotLinhaClick()
3008:         LOCAL loc_oErro
3009: 
3010:         TRY
3011:             IF !USED("TmpFinal")
3012:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para totalizar.", ;
3013:                     "Aten" + CHR(231) + CHR(227) + "o")
3014:             ELSE
3015:                 IF USED("TmpLinha")
3016:                     THIS.cnt_4c_Container1.grd_4c_Linhas.RecordSource = ""
3017:                 ENDIF
3018: 
3019:                 SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, ;
3020:                        SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
3021:                   FROM TmpFinal ;
3022:                  GROUP BY 1 ;
3023:                  UNION ALL ;
3024:                 SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
3025:                        SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
3026:                   FROM TmpFinal ;
3027:                  GROUP BY 1 ;
3028:                   INTO CURSOR TmpLinha ;
3029:                  ORDER BY 2, 1
3030: 
3031:                 WITH THIS.cnt_4c_Container1.grd_4c_Linhas
3032:                     .RecordSource = "TmpLinha"
3033:                     .ColumnCount  = 4
3034: 
3035:                     .Column1.ControlSource = "TmpLinha.Linhas"
3036:                     .Column2.ControlSource = "TmpLinha.Saldo"
3037:                     .Column3.ControlSource = "TmpLinha.Estoque"
3038:                     .Column4.ControlSource = "TmpLinha.Produzir"
3039: 
3040:                     .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
3041:                     .SetAll("DynamicForeColor", ;
3042:                         "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
3043:                 ENDWITH
3044: 
3045:                 *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
3046:                 THIS.HabilitarCampos(.F., .F.)
3047:                 THIS.cnt_4c_Container1.Visible = .T.
3048: 
3049:                 THIS.cnt_4c_Container1.ZOrder(0)
3050:                 THIS.cnt_4c_Container1.grd_4c_Linhas.Refresh()
3051:                 THIS.cnt_4c_Container1.grd_4c_Linhas.Column1.SetFocus()
3052:             ENDIF
3053:         CATCH TO loc_oErro
3054:             MsgErro(loc_oErro.Message + CHR(13) + ;
3055:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3056:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnTotLinhaClick")
3057:         ENDTRY
3058:     ENDPROC
3059: 
3060:     *--------------------------------------------------------------------------
3061:     * BtnPedrasClick - botao "Requisicoes" (SIGPRGLP.Pedras.Click).
3062:     * Abre o Container4 (Requisicao de Componentes Adicionais) ligando a
3063:     * grade ao cursor SelPedra, que o form pai criou e cuja unica linha em
3064:     * branco foi garantida por PrepararCursoresDeTrabalho().
3065:     *
3066:     * Os lookups de SigCdPro das colunas Produto/Produto substituto ja estao
3067:     * ligados por BINDEVENT desde ConfigurarContainer4() - reatribuir o
3068:     * MESMO ColumnCount nao os derruba (medido no VFP9 em 2026-09-29:
3069:     * AEVENTS continua 1 e Width/Header1.Caption ficam intactos).
3070:     *--------------------------------------------------------------------------
3071:     PROCEDURE BtnPedrasClick()
3072:         LOCAL loc_oErro
3073: 
3074:         TRY
3075:             IF !USED("SelPedra")
3076:                 MsgAviso("Cursor de requisi" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
3077:                     "o dispon" + CHR(237) + "vel.", "Aten" + CHR(231) + CHR(227) + "o")
3078:             ELSE
3079:                 THIS.cnt_4c_Container4.grd_4c_Pedras.RecordSource = ""
3080: 
3081:                 WITH THIS.cnt_4c_Container4.grd_4c_Pedras
3082:                     .RecordSource = "SelPedra"
3083:                     .ColumnCount  = 5
3084: 
3085:                     .Column1.ControlSource = "SelPedra.Cpros"
3086:                     .Column2.ControlSource = "SelPedra.Dpros"
3087:                     .Column3.ControlSource = "SelPedra.Cunis"
3088:                     .Column4.ControlSource = "SelPedra.Qtds"
3089:                     .Column5.ControlSource = "SelPedra.Cpro2s"
3090:                 ENDWITH
3091: 
3092:                 *-- "Estoques" FORA do bloco (o legado nao o toca aqui)
3093:                 THIS.HabilitarCampos(.F., .F.)
3094:                 THIS.cnt_4c_Container4.Visible = .T.
3095: 
3096:                 THIS.cnt_4c_Container4.ZOrder(0)
3097:                 THIS.cnt_4c_Container4.grd_4c_Pedras.Refresh()
3098:                 THIS.cnt_4c_Container4.grd_4c_Pedras.Column1.SetFocus()
3099: 
3100:                 *-- Reaplica o gate do When legado (Qtde e Produto substituto
3101:                 *-- so liberam com o Produto preenchido) na linha em que o
3102:                 *-- grid acabou de pousar
3103:                 THIS.AjustarColunasPedra()
3104:             ENDIF
3105:         CATCH TO loc_oErro
3106:             MsgErro(loc_oErro.Message + CHR(13) + ;
3107:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3108:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnPedrasClick")
3109:         ENDTRY
3110:     ENDPROC
3111: 
3112:     *--------------------------------------------------------------------------
3113:     * BtnRelatorioClick - botao "Relatorio" (SIGPRGLP.btnRelatorio.Click).
3114:     * Monta o cursor crImpressao a partir de TmpFinal, completa a descricao
3115:     * de cada produto consultando SigCdPro e manda para o SigReGlp.frx.
3116:     *
3117:     * O legado usa IsEmpty(TmpFinal.Obsps) na coluna ObsPs; aqui vai
3118:     * ISNULL(...) OR EMPTY(...) - mesma semantica do IsEmpty do Fortyus
3119:     * (que trata NULL como vazio), sem depender da resolucao do wrapper
3120:     * pelo PATH. Mesma forma ja usada no Column8 da grade principal.
3121:     *
3122:     * A descricao eh buscada produto a produto, como no legado ("Select
3123:     * Distinct Cpros ... Scan ... SqlExecute"): a consulta unica por IN
3124:     * seria mais rapida, mas mudaria a forma do acesso ao banco sem que o
3125:     * legado peca isso.
3126:     *--------------------------------------------------------------------------
3127:     PROCEDURE BtnRelatorioClick()
3128:         LOCAL loc_cSQL, loc_nResultado, loc_lProsseguir, loc_oErro
3129: 
3130:         TRY
3131:             loc_lProsseguir = .T.
3132: 
3133:             IF !USED("TmpFinal")
3134:                 MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
3135:                     "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
3136:                 loc_lProsseguir = .F.
3137:             ENDIF
3138: 
3139:             IF loc_lProsseguir
3140:                 SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
3141:                        Saldo, Estoque, Produzir, ;
3142:                        IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
3143:                   FROM TmpFinal ;
3144:                  ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
3145:                   INTO CURSOR crImpressao READWRITE
3146: 
3147:                 GO TOP IN crImpressao
3148: 
3149:                 IF EOF("crImpressao")
3150:                     MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + ;
3151:                         "o do Relat" + CHR(243) + "rio!!!", ;
3152:                         "Aten" + CHR(231) + CHR(227) + "o")
3153:                     loc_lProsseguir = .F.
3154:                 ENDIF
3155:             ENDIF
3156: 
3157:             *-- Sem conexao o relatorio sairia com a coluna Descricao em
3158:             *-- branco, sem nenhum aviso - o legado nem chega a testar isso
3159:             IF loc_lProsseguir AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3160:                 MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
3161:                     "o " + CHR(233) + " poss" + CHR(237) + "vel obter a descri" + CHR(231) + ;
3162:                     CHR(227) + "o dos produtos.", "Falha na Conex" + CHR(227) + "o")
3163:                 loc_lProsseguir = .F.
3164:             ENDIF
3165: 
3166:             IF loc_lProsseguir
3167:                 SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds
3168: 
3169:                 SELECT LocalProds
3170:                 SCAN
3171:                     loc_cSQL = "SELECT CPros, DPros" + ;
3172:                                "  FROM SigCdPro" + ;
3173:                                " WHERE CPros = " + EscaparSQL(LocalProds.CPros)
3174: 
3175:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "LocalBus")
3176: 
3177:                     IF loc_nResultado < 0
3178:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3179:                             CapturarErroSQL(), ;
3180:                             "Falha na Conex" + CHR(227) + "o (LocalBus)")
3181:                         loc_lProsseguir = .F.
3182:                         EXIT
3183:                     ENDIF
3184: 
3185:                     SELECT LocalBus
3186:                     GO TOP IN LocalBus
3187:                     IF !EOF("LocalBus")
3188:                         UPDATE crImpressao SET DPros = LocalBus.DPros ;
3189:                          WHERE CPros = LocalBus.CPros
3190:                     ENDIF

*-- Linhas 3208 a 3316:
3208:         CATCH TO loc_oErro
3209:             MsgErro(loc_oErro.Message + CHR(13) + ;
3210:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3211:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnRelatorioClick")
3212:         ENDTRY
3213:     ENDPROC
3214: 
3215:     *--------------------------------------------------------------------------
3216:     * BtnCancelarClick - botao "Sair" (SIGPRGLP.Cancelar.Click).
3217:     * Descarta a transacao em aberto e fecha a tela SEM efetivar nada.
3218:     *
3219:     * "ThisForm.poDataMgr.RollBack()" do legado vira SQLROLLBACK no handle
3220:     * global: a conexao deste ambiente nasce com Transactions = 2 (manual),
3221:     * entao o que o Processar tiver gravado e ainda nao confirmado precisa
3222:     * ser revertido explicitamente aqui.
3223:     *
3224:     * O Release() fica FORA do TRY: liberar o form de dentro do bloco
3225:     * derrubaria a propria pilha de execucao dentro dele (regra #1).
3226:     *--------------------------------------------------------------------------
3227:     PROCEDURE BtnCancelarClick()
3228:         LOCAL loc_lFechar, loc_oErro
3229:         loc_lFechar = .F.
3230: 
3231:         TRY
3232:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3233:                 SQLROLLBACK(gnConnHandle)
3234:             ENDIF
3235: 
3236:             IF VARTYPE(THIS.this_oParentForm) = "O"
3237:                 THIS.this_oParentForm.Enabled = .T.
3238:             ENDIF
3239: 
3240:             loc_lFechar = .T.
3241:         CATCH TO loc_oErro
3242:             MsgErro(loc_oErro.Message + CHR(13) + ;
3243:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3244:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
3245:         ENDTRY
3246: 
3247:         IF loc_lFechar
3248:             THIS.Release()
3249:         ENDIF
3250:     ENDPROC
3251: 
3252:     *--------------------------------------------------------------------------
3253:     * BtnConfirmarDispProdutoClick - botao OK do Container2
3254:     * (SIGPRGLP.Container2.CancelaDisp.Click). Apesar do nome legado, ele
3255:     * CONFIRMA a escolha: para cada tamanho com Utilizar > 0 ele QUEBRA a
3256:     * linha corrente de TmpFinal em duas - uma com o tamanho escolhido e a
3257:     * quantidade retirada do estoque (Produzir = 0), e o restante segue na
3258:     * linha original - e propaga a baixa em TmpSaldo/TmpSaldG e no item da
3259:     * O.P. (SigMvIts) que ainda estava sem tamanho definido.
3260:     *
3261:     * Substituicoes de sintaxe (mesma semantica, forma valida em VFP9):
3262:     *   "=Afiel(Tfinal)"  -> AFIELDS() com LOCAL ARRAY (a funcao EXIGE
3263:     *       array declarado; LOCAL simples estoura em runtime)
3264:     *   "Scatter To Memvar / Append From Array Memvar" -> SCATTER MEMVAR
3265:     *       MEMO + APPEND BLANK + GATHER MEMVAR MEMO (copia do registro
3266:     *       inteiro; o MEMO preserva a observacao do item na linha
3267:     *       desmembrada, que continua sendo o MESMO item)
3268:     *   "?pQtd / ?pAqt / ?pIds" -> EscaparSQL/FormatarNumeroSQL conforme o
3269:     *       TIPO de cada coluna em SigMvIts (qtds/aqtds numeric(9,3),
3270:     *       codtams char(4), cidchaves char(20))
3271:     *
3272:     * EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
3273:     * char(20) + Str(Numes, 6): o padding FAZ PARTE da chave, por isso
3274:     * PADR explicito e NUNCA ALLTRIM nas partes (regra #42).
3275:     *--------------------------------------------------------------------------
3276:     PROCEDURE BtnConfirmarDispProdutoClick()
3277:         LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nBaixa
3278:         LOCAL loc_cEdn, loc_cSQL, loc_nResultado, loc_lProsseguir
3279:         LOCAL loc_nQtd, loc_nAQtd, loc_cIds, loc_cExactOrig, loc_oErro
3280:         LOCAL ARRAY loc_aTFinal[1]
3281: 
3282:         TRY
3283:             loc_lProsseguir = .T.
3284: 
3285:             IF USED("TmpFinal") AND USED("TmpDisp")
3286:                 SELECT TmpFinal
3287:                 loc_nRegFinal = RECNO()
3288: 
3289:                 SELECT TmpDisp
3290:                 loc_nQtdUti = 0
3291:                 SUM Utilizar TO loc_nQtdUti
3292: 
3293:                 *-- Sem conexao nao da para acertar o item da O.P. em
3294:                 *-- SigMvIts, e o legado so descobre isso NO MEIO do laco -
3295:                 *-- quando TmpFinal/TmpSaldo/TmpSaldG ja foram alterados e o
3296:                 *-- "Return 0" deixa a divisao pela metade. Conferir ANTES de
3297:                 *-- mexer em qualquer cursor evita esse estado parcial.
3298:                 IF loc_nQtdUti > 0 AND !(TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
3299:                     MsgErro("Sem conex" + CHR(227) + "o com o banco de dados - n" + CHR(227) + ;
3300:                         "o " + CHR(233) + " poss" + CHR(237) + "vel confirmar a sele" + ;
3301:                         CHR(231) + CHR(227) + "o de estoque.", ;
3302:                         "Falha na Conex" + CHR(227) + "o")
3303:                     loc_lProsseguir = .F.
3304:                 ENDIF
3305: 
3306:                 IF loc_lProsseguir AND loc_nQtdUti > 0
3307:                     SELECT TmpFinal
3308:                     =AFIELDS(loc_aTFinal)
3309:                     CREATE CURSOR Temporario FROM ARRAY loc_aTFinal
3310: 
3311:                     SELECT TmpDisp
3312:                     SCAN
3313:                         IF TmpDisp.Utilizar = 0
3314:                             LOOP
3315:                         ENDIF
3316: 

*-- Linhas 3470 a 3670:
3470:                         USE IN TempEsti2
3471:                     ENDIF
3472:                 ENDIF
3473:             ENDIF
3474: 
3475:             THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container2, .F.)
3476:         CATCH TO loc_oErro
3477:             MsgErro(loc_oErro.Message + CHR(13) + ;
3478:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3479:                 "Procedure: " + loc_oErro.Procedure, ;
3480:                 "Erro em BtnConfirmarDispProdutoClick")
3481:         ENDTRY
3482:     ENDPROC
3483: 
3484:     *--------------------------------------------------------------------------
3485:     * BtnConfirmarDispGrupoClick - botao OK do Container5
3486:     * (SIGPRGLP.Container5.CancelaDisp.Click). Confirma de QUAIS contas sai
3487:     * a quantidade: para cada linha com Utilizar > 0, abate o total a
3488:     * produzir do item, baixa TmpSaldo e a conta correspondente em TmpSaldG
3489:     * (chave Produto+Cor+Tam+Prioridade+Grupo+Conta) e marca o produto em
3490:     * TmpSaldU.KeySelm, que sinaliza "estoque escolhido manualmente" para o
3491:     * restante do processamento.
3492:     *
3493:     * A chave do SEEK em TmpSaldG eh POSICIONAL - Str(Priors, 2) entre o
3494:     * tamanho e o grupo - e por isso nenhuma parte leva ALLTRIM (regra #42).
3495:     *--------------------------------------------------------------------------
3496:     PROCEDURE BtnConfirmarDispGrupoClick()
3497:         LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_oErro
3498: 
3499:         TRY
3500:             IF USED("TmpFinal") AND USED("TmpDisp")
3501:                 SELECT TmpFinal
3502:                 loc_nRegFinal = RECNO()
3503: 
3504:                 SELECT TmpDisp
3505:                 loc_nQtdUti = 0
3506:                 SUM Utilizar TO loc_nQtdUti
3507: 
3508:                 IF loc_nQtdUti > 0
3509:                     SELECT TmpDisp
3510:                     SCAN
3511:                         IF TmpDisp.Utilizar = 0
3512:                             LOOP
3513:                         ENDIF
3514: 
3515:                         loc_nQtUtil = TmpDisp.Utilizar
3516: 
3517:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
3518: 
3519:                         SELECT TmpFinal
3520:                         REPLACE Produzir WITH Produzir - loc_nQtUtil IN TmpFinal
3521:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir IN TmpFinal
3522: 
3523:                         SELECT TmpSaldo
3524:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil
3525: 
3526:                         IF USED("TmpSaldU")
3527:                             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3528:                                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3529:                             ENDIF
3530:                             REPLACE KeySelm WITH .T. IN TmpSaldU
3531:                         ENDIF
3532: 
3533:                         SELECT TmpSaldG
3534:                         SET ORDER TO Cpros
3535:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
3536:                               STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
3537:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil
3538: 
3539:                         SELECT TmpDisp
3540:                     ENDSCAN
3541: 
3542:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3543:                 ENDIF
3544:             ENDIF
3545: 
3546:             THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container5, .T.)
3547:         CATCH TO loc_oErro
3548:             MsgErro(loc_oErro.Message + CHR(13) + ;
3549:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3550:                 "Procedure: " + loc_oErro.Procedure, ;
3551:                 "Erro em BtnConfirmarDispGrupoClick")
3552:         ENDTRY
3553:     ENDPROC
3554: 
3555:     *--------------------------------------------------------------------------
3556:     * BtnFecharPedrasClick - botao "Sair" do Container4
3557:     * (SIGPRGLP.Container4.CancelaDisp.Click). Aqui o nome legado eh
3558:     * literal: nao ha nada a confirmar, o que foi digitado ja esta no
3559:     * cursor SelPedra e sera lido pelo Processar.
3560:     *--------------------------------------------------------------------------
3561:     PROCEDURE BtnFecharPedrasClick()
3562:         THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container4, .F.)
3563:     ENDPROC
3564: 
3565:     *--------------------------------------------------------------------------
3566:     * BtnFecharLinhasClick - botao "OK" do Container1
3567:     * (SIGPRGLP.Container1.CancelaLin.Click). O painel de totais por linha
3568:     * eh somente-leitura: fechar eh a unica acao.
3569:     *--------------------------------------------------------------------------
3570:     PROCEDURE BtnFecharLinhasClick()
3571:         THIS.RestaurarGradePrincipal(THIS.cnt_4c_Container1, .F.)
3572:     ENDPROC
3573: 
3574:     *--------------------------------------------------------------------------
3575:     * RestaurarGradePrincipal - Bloco "With ThisForm ... EndWith" que
3576:     * encerra os QUATRO handlers de fechamento de painel no legado
3577:     * (Container1.CancelaLin e Container2/4/5.CancelaDisp): reabilita os
3578:     * botoes de acao, esconde o painel, devolve o foco a coluna Produzir da
3579:     * grade principal e traz a grade para frente.
3580:     *
3581:     * A UNICA diferenca entre os quatro no legado eh o SelEstoque: so o
3582:     * Container5 o reabilita, porque so o BtnSelEstoqueClick o desabilita.
3583:     * Dai o parametro par_lReabilitarSelEstoque.
3584:     *
3585:     * NOTA DE FIDELIDADE: o legado reabilita cmd_4c_Pedras
3586:     * INCONDICIONALMENTE aqui, mesmo quando o Init o havia desabilitado por
3587:     * falta das colunas de transferencia em SigCdPam. O comportamento eh
3588:     * transcrito como esta - abrir o painel de Requisicoes nao depende
3589:     * desses parametros (quem depende deles eh o Processar).
3590:     *--------------------------------------------------------------------------
3591:     PROTECTED PROCEDURE RestaurarGradePrincipal(par_oContainer, par_lReabilitarSelEstoque)
3592:         LOCAL loc_oErro
3593: 
3594:         TRY
3595:             *-- Bloco "With ThisForm / .Processar.Enabled = .t. / ... /
3596:             *-- EndWith" que o legado repete no fechamento de cada painel
3597:             THIS.HabilitarCampos(.T., par_lReabilitarSelEstoque)
3598: 
3599:             IF VARTYPE(par_oContainer) = "O"
3600:                 par_oContainer.Visible = .F.
3601:             ENDIF
3602: 
3603:             THIS.grd_4c_Itens.Enabled = .T.
3604:             THIS.grd_4c_Itens.ZOrder(0)
3605:             THIS.grd_4c_Itens.Refresh()
3606:             THIS.grd_4c_Itens.Column6.SetFocus()
3607:         CATCH TO loc_oErro
3608:             MsgErro(loc_oErro.Message + CHR(13) + ;
3609:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3610:                 "Procedure: " + loc_oErro.Procedure, "Erro em RestaurarGradePrincipal")
3611:         ENDTRY
3612:     ENDPROC
3613: 
3614:     *==========================================================================
3615:     * GRADE PRINCIPAL (grd_4c_Itens) - troca de linha/coluna e coluna
3616:     * "Produzir" (Column6, fisica e por .Name - ver fix em ConfigurarGradeItens)
3617:     *==========================================================================
3618: 
3619:     *--------------------------------------------------------------------------
3620:     * GradeItensAfterRowColChange - Transcricao de SIGPRGLP.GradeItens.
3621:     * AfterRowColChange. A cada troca de linha/coluna da grade principal:
3622:     * atualiza a observacao do item (memo TmpFinal.Obsps, ligado direto por
3623:     * ControlSource em PrepararCursoresDeTrabalho), refaz a faixa/bind do
3624:     * Container3 (Estoque Disponivel por Conta) para o item corrente e
3625:     * recarrega a foto do produto (SigCdPro.FigJpgs, base64).
3626:     *
3627:     * "ThisForm.poDataMgr.CursorQuery" do legado (helper do Fortyus que nao
3628:     * foi portado) vira SQLEXEC direto em cursor descartavel.
3629:     *--------------------------------------------------------------------------
3630:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
3631:         LOCAL loc_cArquivo, loc_cFoto, loc_oErro
3632: 
3633:         TRY
3634:             IF USED("TmpFinal") AND !EOF("TmpFinal")
3635:                 THIS.obj_4c_ObsItens.Refresh()
3636:                 THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
3637:                     ALLTRIM(TmpFinal.Cpros)
3638: 
3639:                 IF USED("TmpSaldo")
3640:                     =SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
3641:                 ENDIF
3642: 
3643:                 *-- "Select TmpSaldG / Set Order To Cpros / Set Key To ... /
3644:                 *-- Go Top" do legado - a faixa via SET KEY parcial nao
3645:                 *-- funciona sob o SET EXACT ON deste projeto (ver comentario
3646:                 *-- de AplicarFaixaSaldoContas); reusa o mesmo metodo que ja
3647:                 *-- resolve isso com SET FILTER congelado
3648:                 THIS.AplicarFaixaSaldoContas()
3649: 
3650:                 WITH THIS.cnt_4c_Container3
3651:                     IF USED("TmpSaldo") AND !EOF("TmpSaldo")
3652:                         .txt_4c_TotQtd.Value = TmpSaldo.Saldo
3653:                         .txt_4c_TotEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
3654:                         .txt_4c_TotPrz.Value = TmpSaldo.Disps
3655:                     ENDIF
3656: 
3657:                     .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
3658:                         IIF(!EMPTY(TmpFinal.CodCors), "Cor:" + ALLTRIM(TmpFinal.CodCors), "") + ;
3659:                         IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + ALLTRIM(TmpFinal.CodTams), "")
3660: 
3661:                     .txt_4c_GetDGrupo.Value = ""
3662:                     .txt_4c_GetDConta.Value = ""
3663: 
3664:                     IF USED("TmpSaldG") AND !EOF("TmpSaldG")
3665:                         IF USED("TmpConta")
3666:                             USE IN TmpConta
3667:                         ENDIF
3668:                         IF USED("TmpGrupo")
3669:                             USE IN TmpGrupo
3670:                         ENDIF

*-- Linhas 3733 a 4222:
3733:         CATCH TO loc_oErro
3734:             MsgErro(loc_oErro.Message + CHR(13) + ;
3735:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3736:                 "Procedure: " + loc_oErro.Procedure, "Erro em GradeItensAfterRowColChange")
3737:         ENDTRY
3738:     ENDPROC
3739: 
3740:     *--------------------------------------------------------------------------
3741:     * ItemFocoColunaProduzir - GotFocus das demais colunas da grade principal
3742:     * (Column1/3/4/5/7/8 - legado: "ThisForm.GradeItens.Column6.Text1.
3743:     * SetFocus"). Column2 e Column9 nao tem esse redirecionamento no dump.
3744:     *--------------------------------------------------------------------------
3745:     PROCEDURE ItemFocoColunaProduzir()
3746:         THIS.grd_4c_Itens.Column6.SetFocus()
3747:     ENDPROC
3748: 
3749:     *--------------------------------------------------------------------------
3750:     * ItemProduzirGotFocus - When da Column6.Text1 do GradeItens (coluna
3751:     * Produzir). Guarda o valor anterior (ThisForm.OldValue do legado) e, em
3752:     * modo Reserva Automatica com o item ainda sem estoque baixado, libera o
3753:     * botao Disponiveis quando o grupo do produto tem TipoEstos 3 ou 4.
3754:     *--------------------------------------------------------------------------
3755:     PROCEDURE ItemProduzirGotFocus()
3756:         LOCAL loc_oErro
3757: 
3758:         TRY
3759:             IF USED("TmpFinal") AND !EOF("TmpFinal")
3760:                 THIS.this_nProduzirValorAnterior = THIS.grd_4c_Itens.Column6.Text1.Value
3761: 
3762:                 IF THIS.this_oBusinessObject.this_lReserva AND TmpFinal.Estoque = 0
3763:                     IF USED("TempPro")
3764:                         USE IN TempPro
3765:                     ENDIF
3766:                     IF USED("TempGru")
3767:                         USE IN TempGru
3768:                     ENDIF
3769: 
3770:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3771:                         SQLEXEC(gnConnHandle, ;
3772:                             "SELECT CGrus FROM SigCdPro WHERE Cpros = " + ;
3773:                             EscaparSQL(ALLTRIM(TmpFinal.Cpros)), "TempPro")
3774: 
3775:                         IF USED("TempPro") AND !EOF("TempPro")
3776:                             SQLEXEC(gnConnHandle, ;
3777:                                 "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
3778:                                 EscaparSQL(ALLTRIM(TempPro.CGrus)), "TempGru")
3779: 
3780:                             IF USED("TempGru") AND !EOF("TempGru") AND ;
3781:                                     INLIST(TempGru.TipoEstos, 3, 4)
3782:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
3783:                             ENDIF
3784:                         ENDIF
3785:                     ENDIF
3786: 
3787:                     IF USED("TempGru")
3788:                         USE IN TempGru
3789:                     ENDIF
3790:                     IF USED("TempPro")
3791:                         USE IN TempPro
3792:                     ENDIF
3793:                 ENDIF
3794:             ENDIF
3795:         CATCH TO loc_oErro
3796:             MsgErro(loc_oErro.Message + CHR(13) + ;
3797:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3798:                 "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirGotFocus")
3799:         ENDTRY
3800:     ENDPROC
3801: 
3802:     *--------------------------------------------------------------------------
3803:     * ItemProduzirKeyPress - Gatilho do Valid da Column6.Text1 (coluna
3804:     * Produzir), emulado por ENTER(13)/TAB(9) - BINDEVENT "Valid" nao
3805:     * dispara de forma confiavel em TextBox (CLAUDE.md).
3806:     *--------------------------------------------------------------------------
3807:     PROCEDURE ItemProduzirKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3808:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3809:             THIS.ValidarItemProduzir()
3810:         ENDIF
3811:     ENDPROC
3812: 
3813:     *--------------------------------------------------------------------------
3814:     * ValidarItemProduzir - Transcricao de SIGPRGLP.GradeItens.Column6.Text1.
3815:     * Valid. Impede quantidade negativa ou maior que o saldo do item, confirma
3816:     * com o usuario a perda de selecao manual de estoque (TmpSaldU.KeySelm) e,
3817:     * aceitando a nova quantidade, redistribui a baixa de estoque entre
3818:     * TmpSaldo/TmpSaldG.
3819:     *
3820:     * Os dois SEEK sobre TmpSaldG usam chave PARCIAL (Cpros+CodCors+CodTams,
3821:     * sem a Prioridade/Grupo/Conta que completam o indice composto) - por
3822:     * isso o bloco roda sob SET EXACT OFF, restaurado logo em seguida (mesma
3823:     * tecnica ja usada em BtnConfirmarDispProdutoClick).
3824:     *--------------------------------------------------------------------------
3825:     PROCEDURE ValidarItemProduzir()
3826:         LOCAL loc_oTxt, loc_nBaixa, loc_cExactOrig, loc_lConfirma, loc_oErro
3827: 
3828:         TRY
3829:             IF !USED("TmpFinal") OR !USED("TmpSaldo") OR !USED("TmpSaldG") OR EOF("TmpFinal")
3830:                 RETURN
3831:             ENDIF
3832: 
3833:             loc_oTxt = THIS.grd_4c_Itens.Column6.Text1
3834: 
3835:             IF !USED("TmpSaldU")
3836:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
3837:                 INDEX ON Cpros TAG Cpros
3838:             ENDIF
3839: 
3840:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
3841:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
3842:             ENDIF
3843: 
3844:             IF loc_oTxt.Value <> THIS.this_nProduzirValorAnterior AND TmpSaldU.KeySelm
3845:                 loc_lConfirma = MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque." + ;
3846:                     CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. " + ;
3847:                     "Deseja Continuar?", "Aten" + CHR(231) + CHR(227) + "o")
3848:                 IF !loc_lConfirma
3849:                     loc_oTxt.Value = THIS.this_nProduzirValorAnterior
3850:                     loc_oTxt.Refresh()
3851:                     RETURN
3852:                 ENDIF
3853:             ENDIF
3854: 
3855:             DO CASE
3856:                 CASE loc_oTxt.Value = THIS.this_nProduzirValorAnterior
3857:                     * nada a fazer - mesmo valor
3858: 
3859:                 CASE loc_oTxt.Value < 0
3860:                     MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", ;
3861:                         "Aten" + CHR(231) + CHR(227) + "o")
3862:                     loc_oTxt.Value = THIS.this_nProduzirValorAnterior
3863: 
3864:                 CASE loc_oTxt.Value > TmpFinal.Saldo
3865:                     MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da " + ;
3866:                         "Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
3867:                     loc_oTxt.Value = TmpFinal.Saldo - TmpFinal.Estoque
3868: 
3869:                 CASE !SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") ;
3870:                         AND TmpFinal.Produzir <> TmpFinal.Saldo
3871:                     MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
3872:                         "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
3873:                     loc_oTxt.Value = TmpFinal.Saldo
3874: 
3875:                 OTHERWISE
3876:                     IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_oTxt.Value
3877:                         REPLACE TmpSaldo.Disps WITH ;
3878:                             TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
3879:                         REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_oTxt.Value IN TmpFinal
3880:                         REPLACE KeySelm WITH .F. IN TmpSaldU
3881: 
3882:                         loc_nBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
3883: 
3884:                         loc_cExactOrig = SET("EXACT")
3885:                         SET EXACT OFF
3886: 
3887:                         SELECT TmpSaldG
3888:                         SET ORDER TO Cpros
3889:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3890:                         REPLACE Disps WITH Saldo ;
3891:                           WHILE Cpros   = TmpSaldo.Cpros ;
3892:                             AND CodCors = TmpSaldo.CodCors ;
3893:                             AND CodTams = TmpSaldo.CodTams
3894:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
3895:                         SCAN WHILE Cpros   = TmpSaldo.Cpros ;
3896:                                AND CodCors = TmpSaldo.CodCors ;
3897:                                AND CodTams = TmpSaldo.CodTams ;
3898:                                AND loc_nBaixa > 0
3899:                             IF TmpSaldG.Disps >= loc_nBaixa
3900:                                 REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nBaixa
3901:                                 loc_nBaixa = 0
3902:                             ELSE
3903:                                 loc_nBaixa = loc_nBaixa - TmpSaldG.Disps
3904:                                 REPLACE TmpSaldG.Disps WITH 0
3905:                             ENDIF
3906:                         ENDSCAN
3907: 
3908:                         SET EXACT &loc_cExactOrig
3909:                     ELSE
3910:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + ;
3911:                             "vel Deste Produto No Estoque Para Reservar!!!", "Aten" + CHR(231) + CHR(227) + "o")
3912:                         loc_oTxt.Value = THIS.this_nProduzirValorAnterior
3913:                     ENDIF
3914:             ENDCASE
3915: 
3916:             loc_oTxt.Refresh()
3917:         CATCH TO loc_oErro
3918:             MsgErro(loc_oErro.Message + CHR(13) + ;
3919:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3920:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarItemProduzir")
3921:         ENDTRY
3922:     ENDPROC
3923: 
3924:     *--------------------------------------------------------------------------
3925:     * ItemProduzirLostFocus - Transcricao de SIGPRGLP.GradeItens.Column6.
3926:     * Text1.LostFocus. Reflete o Saldo/Estoque/Produzir agregados de todo o
3927:     * TmpFinal nos totais do rodape da grade principal.
3928:     *
3929:     * O "Sum Saldo, Estoque, Produzir" com guarda de RECNO() eh exatamente o
3930:     * que BOParaForm faz - o legado repete esse mesmo bloco aqui, no Init e
3931:     * no retorno dos paineis de estoque, e aqui ele passa pelo funil unico.
3932:     *--------------------------------------------------------------------------
3933:     PROCEDURE ItemProduzirLostFocus()
3934:         LOCAL loc_oErro
3935: 
3936:         TRY
3937:             IF USED("TmpFinal")
3938:                 THIS.BOParaForm()
3939:                 THIS.Refresh()
3940:             ENDIF
3941:         CATCH TO loc_oErro
3942:             MsgErro(loc_oErro.Message + CHR(13) + ;
3943:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3944:                 "Procedure: " + loc_oErro.Procedure, "Erro em ItemProduzirLostFocus")
3945:         ENDTRY
3946:     ENDPROC
3947: 
3948:     *==========================================================================
3949:     * COLUNA "UTILIZAR" DOS PAINEIS DE ESTOQUE (Container2 = Produto/Cor/Tam,
3950:     * Container5 = Grupo/Conta)
3951:     *==========================================================================
3952: 
3953:     *--------------------------------------------------------------------------
3954:     * DispProdutoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
3955:     * grd_4c_DispProduto (Container2), emulado por ENTER/TAB.
3956:     *--------------------------------------------------------------------------
3957:     PROCEDURE DispProdutoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3958:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3959:             THIS.ValidarDispProdutoUtilizar()
3960:         ENDIF
3961:     ENDPROC
3962: 
3963:     *--------------------------------------------------------------------------
3964:     * ValidarDispProdutoUtilizar - Transcricao de SIGPRGLP.Container2.
3965:     * GradeDisp.Column5.Text1.Valid. Impede utilizar mais do que o disponivel
3966:     * na linha OU mais do que o total pedido, e espelha o somatorio em
3967:     * txt_4c_QtSelec (This.Parent.Parent.Parent.Qt_Selec do legado - Text1 ->
3968:     * Column -> Grid -> Container2).
3969:     *--------------------------------------------------------------------------
3970:     PROCEDURE ValidarDispProdutoUtilizar()
3971:         LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro
3972: 
3973:         TRY
3974:             IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
3975:                 RETURN
3976:             ENDIF
3977: 
3978:             loc_oTxt = THIS.cnt_4c_Container2.grd_4c_DispProduto.Column5.Text1
3979: 
3980:             IF loc_oTxt.Value > TmpDisp.Disps
3981:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
3982:                     "Dispon" + CHR(237) + "vel!!!", "Aten" + CHR(231) + CHR(227) + "o")
3983:                 loc_oTxt.Value = 0
3984:                 loc_oTxt.Refresh()
3985:             ELSE
3986:                 SELECT TmpDisp
3987:                 loc_nRegDisp = RECNO()
3988:                 loc_nQtdUti  = 0
3989:                 SUM Utilizar TO loc_nQtdUti
3990:                 IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
3991:                     GO loc_nRegDisp IN TmpDisp
3992:                 ENDIF
3993: 
3994:                 IF loc_nQtdUti > TmpFinal.Saldo
3995:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. " + ;
3996:                         "Pedida!!!", "Aten" + CHR(231) + CHR(227) + "o")
3997:                     loc_oTxt.Value = 0
3998:                     loc_oTxt.Refresh()
3999:                 ELSE
4000:                     THIS.cnt_4c_Container2.txt_4c_QtSelec.Value = loc_nQtdUti
4001:                     THIS.cnt_4c_Container2.txt_4c_QtSelec.Refresh()
4002:                 ENDIF
4003:             ENDIF
4004:         CATCH TO loc_oErro
4005:             MsgErro(loc_oErro.Message + CHR(13) + ;
4006:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4007:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispProdutoUtilizar")
4008:         ENDTRY
4009:     ENDPROC
4010: 
4011:     *--------------------------------------------------------------------------
4012:     * DispGrupoUtilizarKeyPress - Gatilho do Valid da Column5.Text1 do
4013:     * grd_4c_DispGrupo (Container5), emulado por ENTER/TAB.
4014:     *--------------------------------------------------------------------------
4015:     PROCEDURE DispGrupoUtilizarKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4016:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
4017:             THIS.ValidarDispGrupoUtilizar()
4018:         ENDIF
4019:     ENDPROC
4020: 
4021:     *--------------------------------------------------------------------------
4022:     * ValidarDispGrupoUtilizar - Transcricao de SIGPRGLP.Container5.
4023:     * GradeDisp.Column5.Text1.Valid. Mesma regra do Container2 (Disponivel na
4024:     * linha + total pedido), mas o total pedido eh TmpFinal.Saldo -
4025:     * TmpFinal.Estoque (o Container5 ja mostra so o saldo AINDA nao coberto
4026:     * por estoque - ver BtnSelEstoqueClick).
4027:     *--------------------------------------------------------------------------
4028:     PROCEDURE ValidarDispGrupoUtilizar()
4029:         LOCAL loc_oTxt, loc_nRegDisp, loc_nQtdUti, loc_oErro
4030: 
4031:         TRY
4032:             IF !USED("TmpDisp") OR !USED("TmpFinal") OR EOF("TmpDisp")
4033:                 RETURN
4034:             ENDIF
4035: 
4036:             loc_oTxt = THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1
4037: 
4038:             IF loc_oTxt.Value > TmpDisp.Disps
4039:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde " + ;
4040:                     "Disponivel...", "Aten" + CHR(231) + CHR(227) + "o")
4041:                 loc_oTxt.Value = 0
4042:                 loc_oTxt.Refresh()
4043:             ELSE
4044:                 IF loc_oTxt.Value < 0
4045:                     MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", ;
4046:                         "Aten" + CHR(231) + CHR(227) + "o")
4047:                     loc_oTxt.Value = 0
4048:                     loc_oTxt.Refresh()
4049:                 ELSE
4050:                     SELECT TmpDisp
4051:                     loc_nRegDisp = RECNO()
4052:                     loc_nQtdUti  = 0
4053:                     SUM Utilizar TO loc_nQtdUti
4054:                     IF loc_nRegDisp > 0 AND loc_nRegDisp <= RECCOUNT("TmpDisp")
4055:                         GO loc_nRegDisp IN TmpDisp
4056:                     ENDIF
4057: 
4058:                     IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
4059:                         MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde " + ;
4060:                             "Solicitada...", "Aten" + CHR(231) + CHR(227) + "o")
4061:                         loc_oTxt.Value = 0
4062:                         loc_oTxt.Refresh()
4063:                     ELSE
4064:                         THIS.cnt_4c_Container5.txt_4c_QtSelec.Value = loc_nQtdUti
4065:                         THIS.cnt_4c_Container5.txt_4c_QtSelec.Refresh()
4066:                     ENDIF
4067:                 ENDIF
4068:             ENDIF
4069:         CATCH TO loc_oErro
4070:             MsgErro(loc_oErro.Message + CHR(13) + ;
4071:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4072:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDispGrupoUtilizar")
4073:         ENDTRY
4074:     ENDPROC
4075: 
4076:     *--------------------------------------------------------------------------
4077:     * DispGrupoUtilizarLostFocus - Transcricao de SIGPRGLP.Container5.
4078:     * GradeDisp.Column5.Text1.LostFocus: com Enter, desce uma linha na grade
4079:     * (mesmo padrao do "{DNARROW}" ja usado em PedraSubstitutoLostFocus).
4080:     *--------------------------------------------------------------------------
4081:     PROCEDURE DispGrupoUtilizarLostFocus()
4082:         IF LASTKEY() = 13
4083:             KEYBOARD "{DNARROW}"
4084:         ENDIF
4085:         THIS.cnt_4c_Container5.grd_4c_DispGrupo.Column5.Text1.Refresh()
4086:     ENDPROC
4087: 
4088:     *--------------------------------------------------------------------------
4089:     * BtnProcessarClick - botao "Processar" (SIGPRGLP.Processar.Click).
4090:     * Efetiva a geracao das Ordens de Producao/Reserva Automatica a partir
4091:     * dos cursores de trabalho (TmpFinal/TmpDisp/TmpSaldo/TmpSaldG/TmpLinha/
4092:     * SelPedra) ja preparados pelo form pai (FormSigPrGl2) e avo
4093:     * (FormSigPrGlo). Este metodo so ORQUESTRA: repassa ao BO os dois
4094:     * campos que o Init legado lia direto do avo ("_Prev"/"_DtGera" =
4095:     * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao) e
4096:     * o tipo de geracao de OP (Container1 do avo), e delega toda a gravacao
4097:     * a SigPrGlpBO.Processar(), que transcreve o Click legado (1637 linhas
4098:     * no dump original).
4099:     *
4100:     * THIS.this_oParentForm eh o FormSigPrGl2 (pai direto - "Operacoes
4101:     * Selecionadas"); THIS.this_oParentForm.this_oParentForm eh o
4102:     * FormSigPrGlo (avo - "Processamento de O.P."), que tem o
4103:     * cnt_4c_Previsao e o cnt_4c_Container1.txt_4c_TpGOp.
4104:     *
4105:     * Release() fica FORA do TRY (regra #1 - liberar o proprio form de
4106:     * dentro do bloco derrubaria a pilha de execucao dentro dele), mesmo
4107:     * padrao ja usado em BtnCancelarClick.
4108:     *--------------------------------------------------------------------------
4109:     PROCEDURE BtnProcessarClick()
4110:         LOCAL loc_lSucesso, loc_lFechar, loc_oErro
4111:         loc_lFechar = .F.
4112: 
4113:         TRY
4114:             IF !USED("TmpFinal") OR RECCOUNT("TmpFinal") = 0
4115:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " itens para processar.", ;
4116:                     "Aten" + CHR(231) + CHR(227) + "o")
4117:             ELSE
4118:                 *-- FormParaBO sobe os parametros de modo que o Init legado le
4119:                 *-- do form avo (_Prev/_DtGera/_lcTpGOp/GerPorTp) + o SigKey.
4120:                 *-- Devolvendo .F. ele JA exibiu a causa - processar sem data
4121:                 *-- de previsao/geracao gravaria O.P. com data em branco.
4122:                 IF THIS.FormParaBO()
4123:                     loc_lSucesso = THIS.this_oBusinessObject.Processar()
4124: 
4125:                     IF loc_lSucesso
4126:                         MsgInfo("Processamento efetuado com sucesso!" + CHR(13) + ;
4127:                             "O.P. " + TRANSFORM(THIS.this_oBusinessObject.this_nNumeroOpGerada) + ;
4128:                             " gerada.", "Confirmar")
4129:                         loc_lFechar = .T.
4130:                     ELSE
4131:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
4132:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
4133:                         ENDIF
4134:                     ENDIF
4135:                 ENDIF
4136:             ENDIF
4137:         CATCH TO loc_oErro
4138:             MsgErro(loc_oErro.Message + CHR(13) + ;
4139:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4140:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
4141:         ENDTRY
4142: 
4143:         IF loc_lFechar
4144:             IF VARTYPE(THIS.this_oParentForm) = "O"
4145:                 THIS.this_oParentForm.Enabled = .T.
4146:             ENDIF
4147:             THIS.Release()
4148:         ENDIF
4149:     ENDPROC
4150: 
4151:     *--------------------------------------------------------------------------
4152:     * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
4153:     * #117/#147). O legado escreve "Report Form SigReGlp Preview NoConsole"
4154:     * na forma BARE, que faz o VFP9 procurar o FRX no diretorio CORRENTE em
4155:     * vez de gc_4c_CaminhoReports.
4156:     *
4157:     * O helper resolve o caminho, recusa com mensagem clara quando o FRX
4158:     * nao existe, evita preview vazio, e isola SET POINT/SEPARATOR/
4159:     * REPORTBEHAVIOR - os FRX legado Fortyus foram desenhados com
4160:     * POINT="." e REPORTBEHAVIOR 80; no modo 90 os campos numericos saem
4161:     * como asteriscos. No fim restaura o menu principal, que o preview
4162:     * corrompe.
4163:     *
4164:     * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
4165:     *--------------------------------------------------------------------------
4166:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
4167:         LOCAL loc_cFRX, loc_lProsseguir, loc_oErroMenu
4168:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
4169: 
4170:         loc_lProsseguir = .T.
4171:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
4172: 
4173:         IF NOT FILE(loc_cFRX)
4174:             MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
4175:                 CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
4176:                 "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
4177:             loc_lProsseguir = .F.
4178:         ENDIF
4179: 
4180:         IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
4181:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
4182:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
4183:                     "Aten" + CHR(231) + CHR(227) + "o")
4184:                 loc_lProsseguir = .F.
4185:             ENDIF
4186:         ENDIF
4187: 
4188:         IF loc_lProsseguir
4189:             loc_cPointOrig    = SET("POINT")
4190:             loc_cSepOrig      = SET("SEPARATOR")
4191:             loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
4192: 
4193:             SET POINT TO "."
4194:             SET SEPARATOR TO ","
4195:             SET REPORTBEHAVIOR 80
4196: 
4197:             DO CASE
4198:                 CASE par_cModo = "PREVIEW"
4199:                     REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
4200:                 CASE par_cModo = "PRINTER_PROMPT"
4201:                     REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
4202:                 CASE par_cModo = "PRINTER"
4203:                     REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
4204:             ENDCASE
4205: 
4206:             SET POINT TO (loc_cPointOrig)
4207:             SET SEPARATOR TO (loc_cSepOrig)
4208:             SET REPORTBEHAVIOR (loc_nBehaviorOrig)
4209: 
4210:             *-- O preview abre toolbar propria e corrompe o cache visual do
4211:             *-- _MSYSMENU: sem este bloco os popups do menu principal voltam
4212:             *-- encolhidos depois de fechar o preview (mesmo fix do
4213:             *-- FormBase.Destroy)
4214:             TRY
4215:                 SET SYSMENU TO DEFAULT
4216:                 RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
4217:                     popRelatorios, popFerramentas, popAjuda
4218:                 CriarMenuPrincipal()
4219:             CATCH TO loc_oErroMenu
4220:                 *-- CriarMenuPrincipal fora de escopo (harness de teste roda o
4221:                 *-- form sem menu.prg carregado). O relatorio ja foi entregue
4222:                 *-- e nao ha menu para restaurar - nada a reportar ao usuario.

*-- Linhas 4255 a 4379:
4255:     *
4256:     * ESCOPO: CarregarLista, HabilitarCampos e AjustarBotoesPorModo sao
4257:     * PUBLIC (chamados de fora da classe pelo harness de teste e por
4258:     * BINDEVENT, onde metodo PROTECTED falha em SILENCIO - CLAUDE.md regra
4259:     * #3). Ja FormParaBO, BOParaForm e LimparCampos sao PROTECTED porque o
4260:     * FormBase os declara assim (formbase.prg:276-285) e VFP9 NAO permite
4261:     * ALARGAR escopo herdado: medido em 2026-09-29, omitir o PROTECTED aqui
4262:     * faz PEMSTATUS devolver .T. e a chamada externa estourar mesmo assim
4263:     * com "Property BOPARAFORM is not found". Sao chamados por THIS. de
4264:     * dentro da classe (BtnProcessarClick -> FormParaBO; CarregarLista e
4265:     * ItemProduzirLostFocus -> BOParaForm), que eh o contrato do FormBase.
4266:     *==========================================================================
4267: 
4268:     *--------------------------------------------------------------------------
4269:     * CarregarLista - Funil UNICO de (re)carga da grade principal
4270:     * (grd_4c_Itens / GradeItens do legado, RecordSource = TmpFinal).
4271:     *
4272:     * Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21a): o
4273:     * legado sempre fecha com "Go Top" + ".Refresh" e eh isso que este metodo
4274:     * reproduz, em TODO caminho que mexe em TmpFinal (baixa de estoque por
4275:     * produto, por conta, e o retorno dos paineis flutuantes).
4276:     *
4277:     * O rebind so acontece quando o RecordSource NAO esta mais em TmpFinal -
4278:     * reatribuir RecordSource faz o VFP recalcular Column.Width para o default
4279:     * 90 e zerar Header1.Caption (Problema 48), por isso o rebind passa por
4280:     * LigarGradeItens(), que repoe as tres coisas na ordem canonica
4281:     * (RecordSource -> ControlSource -> ColumnOrder -> Width -> Header).
4282:     *--------------------------------------------------------------------------
4283:     PROCEDURE CarregarLista()
4284:         LOCAL loc_lSucesso, loc_oErro
4285:         loc_lSucesso = .F.
4286: 
4287:         TRY
4288:             IF !USED("TmpFinal")
4289:                 *-- Os cursores de trabalho sao recebidos prontos do form pai
4290:                 *-- na DataSession compartilhada; sem eles nao ha o que exibir
4291:                 THIS.LimparCampos()
4292:                 MsgAviso("Os itens da pr" + CHR(233) + "via n" + CHR(227) + "o foram recebidos " + ;
4293:                     "da tela de Processamento de O.P.", ;
4294:                     "Aten" + CHR(231) + CHR(227) + "o")
4295:             ELSE
4296:                 IF UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) != "TMPFINAL"
4297:                     THIS.LigarGradeItens()
4298:                 ENDIF
4299: 
4300:                 SELECT TmpFinal
4301:                 GO TOP IN TmpFinal
4302:                 THIS.grd_4c_Itens.Refresh()
4303: 
4304:                 *-- Totais do rodape + Caption + rotulo da observacao
4305:                 THIS.BOParaForm()
4306: 
4307:                 *-- Faixa do painel "Estoque Disponivel por Conta" (Container3)
4308:                 *-- no item que ficou corrente
4309:                 THIS.AplicarFaixaSaldoContas()
4310:                 THIS.cnt_4c_Container3.grd_4c_DispConta.Refresh()
4311: 
4312:                 IF RECCOUNT("TmpFinal") = 0
4313:                     THIS.LimparCampos()
4314:                 ENDIF
4315: 
4316:                 loc_lSucesso = (RECCOUNT("TmpFinal") > 0)
4317:             ENDIF
4318:         CATCH TO loc_oErro
4319:             MsgErro(loc_oErro.Message + CHR(13) + ;
4320:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4321:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
4322:         ENDTRY
4323: 
4324:         RETURN loc_lSucesso
4325:     ENDPROC
4326: 
4327:     *--------------------------------------------------------------------------
4328:     * LigarGradeItens - (Re)ligacao da grade principal a TmpFinal, transcrita
4329:     * de "With .GradeItens ... EndWith" do Init legado.
4330:     *
4331:     * ORDEM OBRIGATORIA: RecordSource -> ControlSource -> ColumnOrder ->
4332:     * Width -> Header1.Caption. RecordSource reseta Width e Caption, por isso
4333:     * os dois vem por ULTIMO (Problema 48 / CLAUDE.md regra #35c). Os valores
4334:     * sao os mesmos declarados em ConfigurarGradeItens (SCX legado).
4335:     *
4336:     * Column8 exibe uma EXPRESSAO (marcador "*" quando o item tem observacao),
4337:     * nao uma coluna - igual ao legado.
4338:     *--------------------------------------------------------------------------
4339:     PROTECTED PROCEDURE LigarGradeItens()
4340:         LOCAL loc_oErro
4341: 
4342:         TRY
4343:             WITH THIS.grd_4c_Itens
4344:                 .ColumnCount  = 9
4345:                 .RecordSource = "TmpFinal"
4346: 
4347:                 .Column1.ControlSource = "TmpFinal.Cpros"
4348:                 .Column2.ControlSource = "TmpFinal.CodCors"
4349:                 .Column3.ControlSource = "TmpFinal.Dopes"
4350:                 .Column4.ControlSource = "TmpFinal.Numes"
4351:                 .Column5.ControlSource = "TmpFinal.Saldo"
4352:                 .Column6.ControlSource = "TmpFinal.Produzir"
4353:                 .Column7.ControlSource = "TmpFinal.Estoque"
4354:                 .Column8.ControlSource = [IIF(ISNULL(TmpFinal.Obsps) OR EMPTY(TmpFinal.Obsps), "", "*")]
4355:                 .Column9.ControlSource = "TmpFinal.CodTams"
4356: 
4357:                 .Column2.ColumnOrder = 6
4358:                 .Column3.ColumnOrder = 8
4359:                 .Column4.ColumnOrder = 9
4360:                 .Column5.ColumnOrder = 7
4361:                 .Column6.ColumnOrder = 4
4362:                 .Column7.ColumnOrder = 5
4363:                 .Column8.ColumnOrder = 2
4364:                 .Column9.ColumnOrder = 3
4365: 
4366:                 .Column1.Width = 115
4367:                 .Column2.Width = 80
4368:                 .Column3.Width = 80
4369:                 .Column4.Width = 38
4370:                 .Column5.Width = 80
4371:                 .Column6.Width = 150
4372:                 .Column7.Width = 50
4373:                 .Column8.Width = 38
4374:                 .Column9.Width = 38
4375: 
4376:                 .Column1.Header1.Caption = "Produto"
4377:                 .Column2.Header1.Caption = "Cor"
4378:                 .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
4379:                 .Column4.Header1.Caption = "C" + CHR(243) + "digo"

*-- Linhas 4386 a 4429:
4386:         CATCH TO loc_oErro
4387:             MsgErro(loc_oErro.Message + CHR(13) + ;
4388:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4389:                 "Procedure: " + loc_oErro.Procedure, "Erro em LigarGradeItens")
4390:         ENDTRY
4391:     ENDPROC
4392: 
4393:     *--------------------------------------------------------------------------
4394:     * FormParaBO - Transfere para o Business Object tudo o que o
4395:     * processamento le da TELA antes de efetivar as Ordens de Producao.
4396:     *
4397:     * Os campos editaveis desta tela vivem em CURSOR, nao em TextBox: a
4398:     * coluna "Produzir" (TmpFinal.Produzir) e as colunas "Utilizar" dos dois
4399:     * paineis de estoque estao ligadas por ControlSource e o BO le os
4400:     * cursores diretamente - por isso o que sobe aqui sao os parametros de
4401:     * MODO, que o Init legado le do form AVO (FormSigPrGlo, a tela de
4402:     * Processamento de O.P.) e guarda em variaveis do proprio form:
4403:     *
4404:     *   _Prev    = Thisform.ParentForm.ParentForm.Container1.Get_Previsao.Value
4405:     *   _DtGera  = ... Get_Geracao.Value
4406:     *   _lcTpGOp = ... Get_TpGOp.Value
4407:     *   GerPorTp = Not Empty(_lcTpGOp)
4408:     *
4409:     * mais o SigKey (CrSigCdPac.sigKeys), relido aqui porque o form pai pode
4410:     * ter repopulado CrSigCdPac entre a abertura desta tela e o Processar.
4411:     *
4412:     * Retorna .F. (com mensagem) quando o avo nao esta acessivel - o
4413:     * chamador ABORTA a gravacao nesse caso, em vez de processar com data de
4414:     * previsao/geracao vazias.
4415:     *--------------------------------------------------------------------------
4416:     PROTECTED FUNCTION FormParaBO()
4417:         LOCAL loc_lSucesso, loc_oGlo, loc_cTpGOp, loc_oErro
4418:         loc_lSucesso = .F.
4419: 
4420:         TRY
4421:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
4422:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
4423:             ELSE
4424:                 *-- "Thisform.SigKey = CrSigCdPac.sigKeys" do Init legado
4425:                 IF USED("CrSigCdPac") AND RECCOUNT("CrSigCdPac") > 0 AND !EOF("CrSigCdPac")
4426:                     THIS.this_oBusinessObject.this_cSigKey = ALLTRIM(CrSigCdPac.sigKeys)
4427:                 ENDIF
4428: 
4429:                 *-- Avo = FormSigPrGlo (pai deste form = FormSigPrGl2)

*-- Linhas 4437 a 4730:
4437: 
4438:                 IF VARTYPE(loc_oGlo) != "O"
4439:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar a tela de " + ;
4440:                         "Processamento de O.P. (form av" + CHR(244) + ").", "Erro")
4441:                 ELSE
4442:                     loc_cTpGOp = ALLTRIM(loc_oGlo.cnt_4c_Container1.txt_4c_TpGOp.Value)
4443: 
4444:                     THIS.this_oBusinessObject.this_dPrevisao      = ;
4445:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Previsao.Value)
4446:                     THIS.this_oBusinessObject.this_dDataGeracao   = ;
4447:                         ConverterParaData(loc_oGlo.cnt_4c_Previsao.txt_4c_Geracao.Value)
4448:                     THIS.this_oBusinessObject.this_cTipoGeracaoOP = PADR(loc_cTpGOp, 10)
4449:                     THIS.this_oBusinessObject.this_lGerPorTp      = !EMPTY(loc_cTpGOp)
4450: 
4451:                     loc_lSucesso = .T.
4452:                 ENDIF
4453:             ENDIF
4454:         CATCH TO loc_oErro
4455:             MsgErro(loc_oErro.Message + CHR(13) + ;
4456:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4457:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
4458:         ENDTRY
4459: 
4460:         RETURN loc_lSucesso
4461:     ENDFUNC
4462: 
4463:     *--------------------------------------------------------------------------
4464:     * BOParaForm - Reflete na tela o estado do Business Object e dos cursores
4465:     * de trabalho. Funil UNICO dos totais do rodape da grade principal, que o
4466:     * legado recalcula em tres pontos diferentes com o MESMO codigo (Init,
4467:     * Column6.LostFocus e o retorno dos paineis de estoque):
4468:     *
4469:     *   Select TmpFinal / Sum Saldo, Estoque, Produzir To lnSal, lnEst, lnPrz
4470:     *   .Tot_Qtd.Value = lnSal / .Tot_Est.Value = lnEst / .Tot_Prz.Value = lnPrz
4471:     *
4472:     * SUM percorre o cursor inteiro e deixa o ponteiro em EOF - o RECNO() eh
4473:     * guardado antes e restaurado depois, senao a linha corrente da grade
4474:     * (e a faixa do Container3, que depende dela) se perde a cada total.
4475:     *
4476:     * Tambem repoe o Caption (Globalizacao x Reserva Automatica, do Init
4477:     * legado) e o rotulo da observacao do item corrente.
4478:     *--------------------------------------------------------------------------
4479:     PROTECTED PROCEDURE BOParaForm()
4480:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_cCaption, loc_oErro
4481: 
4482:         TRY
4483:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4484:                 loc_cCaption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
4485:                 IF THIS.this_oBusinessObject.this_lReserva
4486:                     loc_cCaption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
4487:                 ENDIF
4488:                 THIS.Caption = loc_cCaption
4489:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
4490:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
4491:             ENDIF
4492: 
4493:             IF USED("TmpFinal")
4494:                 SELECT TmpFinal
4495:                 loc_nRecno = RECNO()
4496:                 loc_nSal   = 0
4497:                 loc_nEst   = 0
4498:                 loc_nPrz   = 0
4499: 
4500:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
4501: 
4502:                 IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("TmpFinal")
4503:                     GO loc_nRecno IN TmpFinal
4504:                 ENDIF
4505: 
4506:                 THIS.txt_4c_TotQtd.Value = loc_nSal
4507:                 THIS.txt_4c_TotEst.Value = loc_nEst
4508:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
4509: 
4510:                 IF !EOF("TmpFinal")
4511:                     THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + ;
4512:                         "o do Item " + ALLTRIM(TmpFinal.Cpros)
4513:                 ENDIF
4514:             ELSE
4515:                 THIS.txt_4c_TotQtd.Value = 0
4516:                 THIS.txt_4c_TotEst.Value = 0
4517:                 THIS.txt_4c_TotPrz.Value = 0
4518:             ENDIF
4519: 
4520:             THIS.txt_4c_TotQtd.Refresh()
4521:             THIS.txt_4c_TotEst.Refresh()
4522:             THIS.txt_4c_TotPrz.Refresh()
4523:         CATCH TO loc_oErro
4524:             MsgErro(loc_oErro.Message + CHR(13) + ;
4525:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4526:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
4527:         ENDTRY
4528:     ENDPROC
4529: 
4530:     *--------------------------------------------------------------------------
4531:     * HabilitarCampos - Liga/desliga em bloco a superficie de trabalho da
4532:     * tela (os 5 botoes de acao, a grade principal e o painel de estoque por
4533:     * conta do rodape), transcrito dos blocos "With ThisForm / .Processar.
4534:     * Enabled = .f. / ... / EndWith" que o legado repete no Click de cada
4535:     * botao que abre um painel flutuante, e do bloco espelhado (.t.) no
4536:     * fechamento de cada painel.
4537:     *
4538:     * par_lIncluirSelEstoque controla se o botao "Estoques" entra no bloco:
4539:     * ele so existe para quem tem o acesso PRIORIDADE (ver
4540:     * AjustarBotoesPorModo), entao religa-lo sem criterio devolveria um
4541:     * botao que o usuario nao deveria ter - o legado, pelo mesmo motivo, o
4542:     * inclui no bloco do painel de estoque por conta e o omite nos demais.
4543:     *
4544:     * "Sair" (cmd_4c_Cancelar) entra no bloco porque o legado o desabilita
4545:     * junto: com um painel aberto, a saida se da pelo OK/Sair do painel.
4546:     *--------------------------------------------------------------------------
4547:     PROCEDURE HabilitarCampos(par_lHabilitar, par_lIncluirSelEstoque)
4548:         LOCAL loc_lLigar, loc_oErro
4549:         loc_lLigar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
4550: 
4551:         TRY
4552:             THIS.cmd_4c_Processar.Enabled  = loc_lLigar
4553:             THIS.cmd_4c_Cancelar.Enabled   = loc_lLigar
4554:             THIS.cmd_4c_TotLinha.Enabled   = loc_lLigar
4555:             THIS.cmd_4c_Pedras.Enabled     = loc_lLigar
4556:             THIS.cmd_4c_Disponivel.Enabled = loc_lLigar
4557: 
4558:             IF VARTYPE(par_lIncluirSelEstoque) = "L" AND par_lIncluirSelEstoque
4559:                 THIS.cmd_4c_SelEstoque.Enabled = loc_lLigar
4560:             ENDIF
4561: 
4562:             THIS.cnt_4c_Container3.Enabled = loc_lLigar
4563:             THIS.grd_4c_Itens.Enabled      = loc_lLigar
4564:         CATCH TO loc_oErro
4565:             MsgErro(loc_oErro.Message + CHR(13) + ;
4566:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4567:                 "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
4568:         ENDTRY
4569:     ENDPROC
4570: 
4571:     *--------------------------------------------------------------------------
4572:     * AjustarBotoesPorModo - Estado inicial dos botoes de acao, conforme as
4573:     * regras que o Init legado aplica uma a uma:
4574:     *
4575:     *   Requisicoes  - "ThisForm.Pedras.Enabled = .F." e so volta a .T. com
4576:     *                  as QUATRO operacoes de transferencia preenchidas em
4577:     *                  SigCdPam (DopEmphs/DopReqcs/DopPedcs/DopComps) E fora
4578:     *                  da Reserva Automatica;
4579:     *   Estoques     - nasce desligado no SCX e so liga com
4580:     *                  fChecaAcesso('SIGPRGLO','PRIORIDADE');
4581:     *   coluna
4582:     *   Produzir     - "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly',
4583:     *                  .t.)" - sem operacao de transferencia de reserva
4584:     *                  configurada a grade inteira fica somente-leitura.
4585:     *
4586:     * As demais acoes (Processar/Total-Linhas/Disponiveis/Relatorio) e a
4587:     * propria grade dependem de haver item em TmpFinal - processar ou
4588:     * imprimir previa vazia nao faz sentido. "Sair" fica SEMPRE disponivel:
4589:     * eh a unica saida da tela (o form legado tem TitleBar=0 e
4590:     * ControlBox=.F.).
4591:     *--------------------------------------------------------------------------
4592:     PROCEDURE AjustarBotoesPorModo()
4593:         LOCAL loc_lTemItens, loc_lPedras, loc_oErro
4594: 
4595:         TRY
4596:             loc_lTemItens = USED("TmpFinal") AND RECCOUNT("TmpFinal") > 0
4597: 
4598:             loc_lPedras = .F.
4599:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4600:                 loc_lPedras = !EMPTY(THIS.this_oBusinessObject.this_cPamDopEmphs) AND ;
4601:                               !EMPTY(THIS.this_oBusinessObject.this_cPamDopReqcs) AND ;
4602:                               !EMPTY(THIS.this_oBusinessObject.this_cPamDopPedcs) AND ;
4603:                               !EMPTY(THIS.this_oBusinessObject.this_cPamDopComps) AND ;
4604:                               !THIS.this_oBusinessObject.this_lReserva
4605:             ENDIF
4606: 
4607:             THIS.cmd_4c_Pedras.Enabled       = loc_lPedras AND loc_lTemItens
4608:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lTemItens AND fChecaAcesso("SIGPRGLO", "PRIORIDADE")
4609:             THIS.cmd_4c_Processar.Enabled    = loc_lTemItens
4610:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemItens
4611:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemItens
4612:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemItens
4613:             THIS.grd_4c_Itens.Enabled        = loc_lTemItens
4614:             THIS.cnt_4c_Container3.Enabled   = loc_lTemItens
4615: 
4616:             THIS.cmd_4c_Cancelar.Enabled     = .T.
4617: 
4618:             *-- "If Empty(crSigCdPam.TransfRes) / .SetAll('ReadOnly', .t.)".
4619:             *-- O ReadOnly do Grid propaga para as colunas, entao este bloco
4620:             *-- fica DEPOIS de qualquer ajuste de coluna (regra #18).
4621:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
4622:                     EMPTY(THIS.this_oBusinessObject.this_cPamTransfRes)
4623:                 THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
4624:             ENDIF
4625:         CATCH TO loc_oErro
4626:             MsgErro(loc_oErro.Message + CHR(13) + ;
4627:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4628:                 "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
4629:         ENDTRY
4630:     ENDPROC
4631: 
4632:     *--------------------------------------------------------------------------
4633:     * LimparCampos - Zera os campos de EXIBICAO da tela (totais do rodape,
4634:     * totais e descricoes do painel de estoque por conta, quantidades dos
4635:     * paineis flutuantes, rotulo da observacao e a foto do produto).
4636:     *
4637:     * Nao toca nos CURSORES: TmpFinal/TmpSaldo/TmpSaldG pertencem a
4638:     * DataSession compartilhada com o form pai, que os calculou - apagar o
4639:     * conteudo deles aqui destruiria o trabalho do chamador. Chamado quando
4640:     * nao ha item corrente (previa vazia ou cursores nao recebidos), para a
4641:     * tela nao exibir numeros e a foto do ultimo item consultado.
4642:     *
4643:     * CLEAR RESOURCES antes de soltar a Picture: o arquivo TempGlb.jpg eh
4644:     * reescrito a cada troca de linha e fica travado enquanto o VFP mantem a
4645:     * imagem em cache (mesmo motivo do CLEAR RESOURCES do
4646:     * GradeItensAfterRowColChange).
4647:     *--------------------------------------------------------------------------
4648:     PROTECTED PROCEDURE LimparCampos()
4649:         LOCAL loc_oErro
4650: 
4651:         TRY
4652:             THIS.txt_4c_TotQtd.Value = 0
4653:             THIS.txt_4c_TotEst.Value = 0
4654:             THIS.txt_4c_TotPrz.Value = 0
4655:             THIS.txt_4c_TotQtd.Refresh()
4656:             THIS.txt_4c_TotEst.Refresh()
4657:             THIS.txt_4c_TotPrz.Refresh()
4658: 
4659:             THIS.lbl_4c_TxtObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
4660: 
4661:             CLEAR RESOURCES
4662:             THIS.img_4c_ImgFigJpg.Picture = ""
4663:             THIS.img_4c_ImgFigJpg.Visible = .F.
4664: 
4665:             WITH THIS.cnt_4c_Container3
4666:                 .txt_4c_TotQtd.Value    = 0
4667:                 .txt_4c_TotEst.Value    = 0
4668:                 .txt_4c_TotPrz.Value    = 0
4669:                 .txt_4c_GetDGrupo.Value = ""
4670:                 .txt_4c_GetDConta.Value = ""
4671:                 .lbl_4c_Label1.Caption  = "Estoque Dispon" + CHR(237) + "vel"
4672:             ENDWITH
4673: 
4674:             WITH THIS.cnt_4c_Container2
4675:                 .txt_4c_QtPedida.Value = 0
4676:                 .txt_4c_QtSelec.Value  = 0
4677:             ENDWITH
4678: 
4679:             WITH THIS.cnt_4c_Container5
4680:                 .txt_4c_QtPedida.Value  = 0
4681:                 .txt_4c_QtSelec.Value   = 0
4682:                 .txt_4c_GetDGrupo.Value = ""
4683:                 .txt_4c_GetDConta.Value = ""
4684:             ENDWITH
4685: 
4686:             THIS.Refresh()
4687:         CATCH TO loc_oErro
4688:             MsgErro(loc_oErro.Message + CHR(13) + ;
4689:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4690:                 "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
4691:         ENDTRY
4692:     ENDPROC
4693: 
4694:     *--------------------------------------------------------------------------
4695:     * TornarControlesVisiveis - Torna visiveis os controles criados via
4696:     * AddObject (nascem Visible=.F.). Os containers flutuantes do legado
4697:     * (Container1/Container2/Container4/Container5 - cada um declara
4698:     * "Visible = .F." no dump e eh alternado pelos botoes de acao Pedras/
4699:     * SelEstoque/TotLinha/Disponivel, adicionados na Fase 4) sao FILTRADOS
4700:     * aqui: tornar visivel incondicionalmente destruiria esse comportamento
4701:     * (CLAUDE.md - regra de Containers Flutuantes em forms OPERACIONAL).
4702:     * Container3 (Estoque Disponivel por conta, rodape) NAO entra no
4703:     * filtro - o dump nao declara Visible para ele, ou seja permanece
4704:     * visivel por padrao, igual ao legado.
4705:     *--------------------------------------------------------------------------
4706:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4707:         LOCAL loc_nI, loc_oObjeto
4708: 
4709:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4710:             loc_oObjeto = par_oContainer.Controls(loc_nI)
4711: 
4712:             IF VARTYPE(loc_oObjeto) = "O"
4713:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER1", ;
4714:                         "CNT_4C_CONTAINER2", "CNT_4C_CONTAINER4", "CNT_4C_CONTAINER5")
4715:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4716:                     LOOP
4717:                 ENDIF
4718: 
4719:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
4720:                     loc_oObjeto.Visible = .T.
4721:                 ENDIF
4722: 
4723:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
4724:                     THIS.TornarControlesVisiveis(loc_oObjeto)
4725:                 ENDIF
4726:             ENDIF
4727:         ENDFOR
4728:     ENDPROC
4729: 
4730: ENDDEFINE

