# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 6 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.DescricaoLostFocusExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ProdutoLostFocusExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RefForLostFocusExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DPro2sLostFocusExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopbus.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1143 linhas total):

*-- Linhas 8 a 331:
8: * Legado (SIGOPBUS.SCX): BaseClass = form (generico), sem PageFrame, sem
9: * grid, sem botao CRUD - apenas 4 TextBox de criterio de busca (Get_Descricao,
10: * Get_Produto, Get_RefFor, get_DPro2s), cada um abrindo o picker fwBuscaExt
11: * (equivalente a FormBuscaAuxiliar no migrado) sobre SigCdPro, e um unico
12: * CommandButton "Sair".
13: *
14: * Historico de fases:
15: *   Fase 1/2: sigopbusBO.prg (propriedades de criterio/resultado + Init)
16: *   Fase 2/8: sigopbusBO.prg (CarregarDoCursor/ObterCodigoRetorno/
17: *             ObterFiltroSituacao/ObterChavePrimaria/LimparDados)
18: *   Fase 3/8: Formsigopbus.prg - estrutura base (Init, InicializarForm,
19: *             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
20: *             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
21: *             Page nenhuma - nenhum pgf_4c_* eh criado neste form (mesma
22: *             familia do SIGOPBIN/FormSIGOPBIN).
23: *   Fase 4/8 (CONCLUIDA COMO NO-OP JUSTIFICADO): nao ha Grid nem botoes
24: *             CRUD a acrescentar - tasks\task649\analise.json/layout.json
25: *             nao declaram grid nem PageFrame, e o SCX legado (SIGOPBUS)
26: *             nao tem UMA lista sequer: a arvore inteira (layout.json) eh
27: *             Form + cntSombra decorativo + 6 Label + 4 TextBox (Get_Descricao/
28: *             Get_Produto/Get_RefFor/get_DPro2s) + 1 CommandButton (Sair).
29: *             Os 4 TextBox sao campos de ENTRADA (cada um com Valid abrindo
30: *             fwBuscaExt sobre SigCdPro - comportamento.json confirma
31: *             temLookup=true nos 4 e funcoesExternas=["fwBuscaExt"]) e o
32: *             Sair so faz ThisForm.Release - nenhum verbo CRUD. Este eh um
33: *             dialogo FLAT de CAPTURA (campos editaveis, sem lista, sem
34: *             botao CRUD) - mesma familia do SIGMVVDE/FormSigMvVde e do
35: *             SIGOPBIN/FormSIGOPBIN, documentada no gate da Fase 4 do
36: *             OrquestradorMigracao.ps1 (ramo "layout captura"). Inventar
37: *             Page1/Grid/6 botoes CRUD aqui violaria o PILAR 1 (o legado eh
38: *             um popup de busca 412x336 com 4 campos, nao um cadastro) e a
39: *             regra "NUNCA inventar" (CLAUDE.md). Os 6 Label, os 4 TextBox
40: *             (com os respectivos Valid/lookup) e o CommandButton Sair
41: *             ficam para as Fases 5 a 7.
42: *   Fase 5/8: ConfigurarPaginaDados() - metade dos campos (layout.json, ordem
43: *             do dump): Label1/lbl_4c_Label1 + Get_Descricao/txt_4c_Descricao
44: *             (criterio Dpros) e Label3/lbl_4c_Label3 + Get_Produto/
45: *             txt_4c_Produto (criterio Cpros). Valor inicial de cada TextBox
46: *             vem do BO (this_cDpros/this_cCpros - fonte unica), sem
47: *             BINDEVENT ainda - o Valid/lookup fwBuscaExt de cada campo entra
48: *             na Fase 6, junto com Label5/Get_RefFor e Label6/get_DPro2s
49: *             (segunda metade). Label4 (instrucao ESC) e Sair ficam para a
50: *             Fase 7.
51: *   Fase 6/8: ConfigurarPaginaDados() - segunda metade dos campos
52: *             (Label5/txt_4c_RefFor - criterio Reffs; Label6/txt_4c_DPro2s -
53: *             criterio Dpro2s) + BINDEVENT "LostFocus" nos 4 campos +
54: *             metodos <Campo>LostFocus/<Campo>LostFocusExec completos
55: *             (equivalentes aos 4 PROCEDURE Valid do legado), com guarda
56: *             de reentrancia this_lEmLookup. Cada Exec abre
57: *             FormBuscaAuxiliar sobre SigCdPro com as colunas e o filtro
58: *             de situacao exatos do dump (coluna "CnjLacto" do legado
59: *             omitida - nao existe em SigCdPro).
60: *   Fase 7/8: ConfigurarBotaoSair() - Label4 (instrucao ESC, Visible=.T.
61: *             por default - o dump NAO sobrescreve Visible, os 4 Valid()
62: *             so reforcam ".t." quando ha tentativa de busca) + o unico
63: *             CommandButton do legado (cmd_4c_Sair, Top/Left/Width/Height/
64: *             Caption/Style exatos do dump). ".Cancel = .T." reproduz o
65: *             "[Pressione <ESC> para cancelar]" nativamente - o legado NAO
66: *             tem PROCEDURE KeyPress nenhuma no form nem nos TextBox para
67: *             ESC; eh o VFP9 que aciona o Click do botao Cancel quando o
68: *             usuario pressiona ESC. BtnSairClick transcreve literalmente
69: *             o Click do legado ("x=Inkey(.1) / ThisForm.Release" - a
70: *             pausa de 0.1s antes de liberar o form, regra #17/#31).
71: *             Corrigidos tambem 3 desvios de fidelidade (PILAR 1) achados
72: *             nas Fases 5/6 ao conferir o dump linha a linha: MaxLength de
73: *             txt_4c_Descricao (65 -> 40, o dump declara 40 para este
74: *             campo de CRITERIO de busca - igual aos outros 3 - a largura
75: *             da coluna Dpros no schema nao se aplica aqui), BackColor
76: *             255,255,234 ausente nos 4 TextBox (tom amarelo-claro que o
77: *             SCX declara em todos) e FontSize de Label1/Label3/Label5/
78: *             Label6 (8 -> 12, valor exato do dump).
79: *   Fase 8/8 (CONCLUIDA COM 1 METODO REAL + NO-OP JUSTIFICADO no resto):
80: *             ObterProduto() - unico item desta fase com equivalente real
81: *             no legado: PROCEDURE Unload / Return(Thisform.Produto). O
82: *             legado era aberto via "DO FORM SigOpBus WITH ... TO lcVar"
83: *             (o VFP captura nessa clausula o retorno do Unload); este form
84: *             migrado eh aberto por CREATEOBJECT + Show() modal (sem DO
85: *             FORM/TO), entao o metodo publico ObterProduto() eh como o
86: *             form chamador le o resultado - padrao identico ao irmao desta
87: *             mesma familia de dialogo FLAT, FormSIGOPBIN.ObterResultadoSaida()/
88: *             SIGOPBINBO.ObterResultadoSaida() (mesmo equivalente de Unload).
89: *             Seguro ler apos o Show() retornar porque THIS.Release() (que
90: *             os 4 LostFocusExec/BtnSairClick chamam) NAO destroi o objeto
91: *             enquanto o CALLER mantiver a variavel viva - FormBase.Destroy()
92: *             so zera this_oBusinessObject quando a ultima referencia cai
93: *             (loForm = .NULL. no caller), nao no instante do Release()
94: *             interno. Convencao de chamada: loForm = CREATEOBJECT(...) /
95: *             loForm.Show() / lcCodigo = loForm.ObterProduto() / loForm =
96: *             .NULL..
97: *
98: *             FormParaBO() / BOParaForm() / LimparCampos() - hooks REAIS,
99: *             nao convencao vazia de Page2 de Dados. Os 4 TextBox deste
100: *             dialogo sao campos EDITAVEIS que alimentam a operacao da tela
101: *             (a consulta a SigCdPro), e o legado le cada um deles com
102: *             "This.Value" dentro do proprio PROCEDURE Valid. FormParaBO()
103: *             centraliza essa leitura (os 4 Exec passaram a pegar o criterio
104: *             da property do BO, fonte unica, em vez de reler o controle);
105: *             BOParaForm() centraliza a carga inversa, que estava inline em
106: *             cada AddObject (".Value = TratarNulo(...)") e agora tem UM
107: *             ponto de recarga; LimparCampos() devolve o dialogo ao estado
108: *             do Init legado ("ThisForm.Produto = Space(14)" com os 4 campos
109: *             vazios - o SCX nao declara Value nem ControlSource em nenhum).
110: *             Os TRES sao PROTECTED porque FormBase declara os hooks
111: *             PROTECTED e VFP9 nao permite ALARGAR escopo de metodo herdado.
112: *             BOParaForm() NAO substitui o eco por campo que cada Exec faz
113: *             depois de uma selecao: o legado escreve SO no proprio campo
114: *             ("This.Value = CrListaRemota.Dpros"), e reescrever os quatro
115: *             ali seria desvio do PILAR 1.
116: *
117: *             Os demais itens do roteiro generico desta fase (BtnBuscarClick/
118: *             BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick/CarregarLista/
119: *             HabilitarCampos/AjustarBotoesPorModo) sao NO-OP JUSTIFICADO:
120: *             sao vocabulario de form CRUD (frmcadastro, Page1=Lista/
121: *             Page2=Dados com Confirmar/Cancelar/Encerrar) e este dialogo
122: *             FLAT nao tem CRUD nenhum - o legado (SIGOPBUS.SCX) nao declara
123: *             UM botao Buscar/Salvar/Cancelar/Encerrar, nem Grid, nem
124: *             PageFrame (ver nota da Fase 4), logo nao ha lista a carregar
125: *             nem modo de edicao a alternar. O unico botao do legado (Sair)
126: *             ja foi implementado na Fase 7 (BtnSairClick, transcricao
127: *             literal do Click) e eh ele mesmo o caminho de cancelamento,
128: *             com ".Cancel = .T." respondendo ao ESC - por isso nao existe
129: *             um "BtnCancelarClick" separado: criar um alias faria o nome
130: *             MENTIR sobre o objeto do legado que o handler representa.
131: *             Inventar esses metodos aqui violaria o PILAR 1 ("NUNCA
132: *             inventar", CLAUDE.md) - mesma justificativa documentada em
133: *             FormSIGOPBIN.prg (Fase 7/8, "CONCLUIDA COMO NO-OP
134: *             JUSTIFICADO").
135: *
136: *             DIVERGENCIA DECLARADA (ausencia que tem de ficar VISIVEL,
137: *             CLAUDE.md #27): o picker legado exibe a FOTO do produto -
138: *             "loLista.mAddColuna('figjpgs', .f., .f., .f., .f., .t.)", em
139: *             que o 6o argumento marca a coluna como IMAGEM. O
140: *             FormBuscaAuxiliar desta arquitetura tem mAddColuna de TRES
141: *             parametros (campo, mascara, titulo) e nao suporta coluna de
142: *             imagem, entao os 4 lookups desta tela saem SEM a miniatura.
143: *             A coluna figjpgs EXISTE em SigCdPro (conferido no
144: *             docs/schema.sql) - o que falta eh o suporte no picker, nao o
145: *             dado. Nao foi criado stub que finja exibir a imagem.
146: *
147: *             Tambem NAO ha equivalente a "Thisform.PodataMgr.Release" do
148: *             PROCEDURE Release do legado (DoDefault() + libera a conexao
149: *             fSqlConector criada no Init): esta arquitetura nao cria
150: *             conexao por form (sem poDataMgr) - sigopbusBO.Init() usa o
151: *             gnConnHandle global, igual a TODOS os outros BOs do projeto
152: *             (CCJBO, EndBO, ProdutoBO, SigOpAlCBO etc. documentam a mesma
153: *             substituicao). Nao ha conexao a liberar, logo nao ha Release()
154: *             a sobrescrever neste form.
155: *
156: *             Integracao (menu.prg): NAO adicionado item de menu. Este eh um
157: *             dialogo modal REUTILIZAVEL (ver cabecalho do arquivo), chamado
158: *             com parametros por outros forms/BOs que precisem resolver o
159: *             codigo de um produto - o legado nunca o expos como entrada de
160: *             menu independente (nenhum "DO FORM SigOpBus" solto em menu;
161: *             sempre invocado de dentro de outro metodo, com os 6 parametros
162: *             de comportamento). Adicionar entrada de menu criaria um
163: *             fluxo que o legado nao tem, violando o PILAR 1. SET PROCEDURE
164: *             nao e necessario (config.prg ja carrega Form*.prg/*BO.prg via
165: *             ADIR() dinamico, CLAUDE.md "config.prg - Dynamic Loading").
166: *==============================================================================
167: DEFINE CLASS Formsigopbus AS FormBase
168: 
169:     *-- Parametros de entrada recebidos no Init (equivalem as Lparameters do
170:     *-- legado: pRetorno, pSituacao, pConjunto, pCodMacro, pFiltraSit, pCnj)
171: 
172:     *-- Guarda de reentrancia (regra #37/#47): FormBuscaAuxiliar eh MODAL e
173:     *-- tira o foco do TextBox, o que redispara o proprio LostFocus.
174:     this_lEmLookup = .F.
175: 
176:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPBUS)
177:     Width       = 412
178:     Height      = 336
179:     AutoCenter  = .T.
180:     TitleBar    = 0
181:     ShowWindow  = 1
182:     WindowType  = 1
183:     ControlBox  = .F.
184:     Closable    = .F.
185:     MaxButton   = .F.
186:     MinButton   = .F.
187:     BorderStyle = 2
188:     Caption     = ""
189:     ClipControls = .F.
190:     AlwaysOnTop = .T.
191: 
192:     *--------------------------------------------------------------------------
193:     * Init - Recebe os parametros de comportamento do dialogo (equivale ao
194:     * "Lparameters pRetorno, pSituacao, pConjunto, pCodMacro, pFiltraSit, pCnj"
195:     * do legado) e cria o Business Object antes de inicializar a parte visual
196:     * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
197:     *--------------------------------------------------------------------------
198:     PROCEDURE Init(par_lTipoRetorno, par_nSituas, par_lConjunto, ;
199:             par_lCodMacro, par_nFiltraSituas, par_lCnjLacto)
200:         LOCAL loc_lSucesso, loc_oErro
201:         loc_lSucesso = .F.
202: 
203:         TRY
204:             THIS.this_oBusinessObject = CREATEOBJECT("sigopbusBO")
205: 
206:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
207:                 MsgErro("Erro ao criar sigopbusBO." + CHR(13) + ;
208:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
209:                     "Formsigopbus.Init")
210:             ELSE
211:                 *-- ThisForm.Tiporetorno = pRetorno
212:                 THIS.this_oBusinessObject.this_lTipoRetorno = ;
213:                     IIF(VARTYPE(par_lTipoRetorno) = "L", par_lTipoRetorno, .F.)
214: 
215:                 *-- ThisForm.Situas = Iif(Type('pSituacao')='N', pSituacao, 0)
216:                 THIS.this_oBusinessObject.this_nSituas = ;
217:                     IIF(VARTYPE(par_nSituas) = "N", par_nSituas, 0)
218: 
219:                 *-- ThisForm.FiltraSituas = Iif(Type('pFiltraSit')='N', pFiltraSit, 0)
220:                 THIS.this_oBusinessObject.this_nFiltraSituas = ;
221:                     IIF(VARTYPE(par_nFiltraSituas) = "N", par_nFiltraSituas, 0)
222: 
223:                 *-- ThisFOrm.Conjunto = pConjunto
224:                 THIS.this_oBusinessObject.this_lConjunto = ;
225:                     IIF(VARTYPE(par_lConjunto) = "L", par_lConjunto, .F.)
226: 
227:                 *-- ThisFOrm.CodMacro = pCodMacro
228:                 THIS.this_oBusinessObject.this_lCodMacro = ;
229:                     IIF(VARTYPE(par_lCodMacro) = "L", par_lCodMacro, .F.)
230: 
231:                 *-- ThisForm.Cnjlacto = pCnj
232:                 THIS.this_oBusinessObject.this_lCnjLacto = ;
233:                     IIF(VARTYPE(par_lCnjLacto) = "L", par_lCnjLacto, .F.)
234: 
235:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
236:                 loc_lSucesso = DODEFAULT()
237:             ENDIF
238:         CATCH TO loc_oErro
239:             MsgErro(loc_oErro.Message + CHR(13) + ;
240:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
241:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.Init")
242:         ENDTRY
243: 
244:         RETURN loc_lSucesso
245:     ENDPROC
246: 
247:     *--------------------------------------------------------------------------
248:     * InicializarForm - Monta a estrutura visual base
249:     * (chamado por FormBase.Init via DODEFAULT)
250:     *--------------------------------------------------------------------------
251:     PROTECTED PROCEDURE InicializarForm()
252:         LOCAL loc_lSucesso, loc_oErro
253:         loc_lSucesso = .F.
254: 
255:         TRY
256:             *-- Fundo do form (imagem do Framework Fortyus legado)
257:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
258: 
259:             *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
260:             THIS.ConfigurarPageFrame()
261: 
262:             *-- Campos de criterio de busca (Fases 5 e 6/8)
263:             THIS.ConfigurarPaginaDados()
264: 
265:             *-- Label de instrucao ESC + unico botao do dialogo (Fase 7/8)
266:             THIS.ConfigurarBotaoSair()
267: 
268:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
269:             THIS.TornarControlesVisiveis(THIS)
270: 
271:             loc_lSucesso = .T.
272:         CATCH TO loc_oErro
273:             MsgErro(loc_oErro.Message + CHR(13) + ;
274:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
275:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.InicializarForm")
276:         ENDTRY
277: 
278:         RETURN loc_lSucesso
279:     ENDPROC
280: 
281:     *--------------------------------------------------------------------------
282:     * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
283:     *   Form OPERACIONAL FLAT: o legado (SIGOPBUS.SCX) nao tem PageFrame nem
284:     *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
285:     *   metodo mantido por convencao do orquestrador de migracao (nenhum
286:     *   AddObject("pgf_4c_...") eh feito aqui).
287:     *   Demais controles do legado (Label1/Get_Descricao, Label3/Get_Produto,
288:     *   Sair, Label4, Label5/Get_RefFor, Label6/get_DPro2s) entram em fase
289:     *   posterior (campos de dados / eventos).
290:     *--------------------------------------------------------------------------
291:     PROTECTED PROCEDURE ConfigurarPageFrame()
292:         LOCAL loc_oCab, loc_oErro
293:         TRY
294:             *-- cntSombra original: Top=0, Left=-2, Width=800 (-> THIS.Width),
295:             *-- Height=80, BackColor=100,100,100
296:             THIS.AddObject("cnt_4c_Sombra", "Container")
297:             loc_oCab = THIS.cnt_4c_Sombra
298:             WITH loc_oCab
299:                 .Top         = 0
300:                 .Left        = 0
301:                 .Width       = THIS.Width
302:                 .Height      = 80
303:                 .BorderWidth = 0
304:                 .BackStyle   = 1
305:                 .BackColor   = RGB(100, 100, 100)
306:             ENDWITH
307: 
308:             *-- Labels adicionados FORA do WITH do container (WITH aninhado com
309:             *-- AddObject ignora propriedades silenciosamente - regra conhecida)
310:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
311:             WITH loc_oCab.lbl_4c_LblSombra
312:                 .FontBold      = .T.
313:                 .FontName      = "Tahoma"
314:                 .FontSize      = 18
315:                 .FontUnderline = .F.
316:                 .WordWrap      = .T.
317:                 .AutoSize      = .F.
318:                 .Alignment     = 0
319:                 .BackStyle     = 0
320:                 .Caption       = "Busca  de  Produto"
321:                 .Height        = 40
322:                 .Left          = 10
323:                 .Top           = 18
324:                 .Width         = 769
325:                 .ForeColor     = RGB(0, 0, 0)
326:             ENDWITH
327: 
328:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
329:             WITH loc_oCab.lbl_4c_LblTitulo
330:                 .FontBold    = .T.
331:                 .FontName    = "Tahoma"

*-- Linhas 345 a 426:
345:         CATCH TO loc_oErro
346:             MsgErro(loc_oErro.Message + CHR(13) + ;
347:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
348:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarPageFrame")
349:         ENDTRY
350:     ENDPROC
351: 
352:     *--------------------------------------------------------------------------
353:     * ConfigurarPaginaDados - Campos de criterio de busca, filhos diretos do
354:     * form (FLAT, sem PageFrame/Page - mesma observacao da regra #30/#31 nao
355:     * se aplica aqui porque nao ha container intermediario).
356:     *
357:     * Fase 5/8: PRIMEIRA METADE (ordem do layout.json/dump legado):
358:     *   Label1        -> lbl_4c_Label1  (Top=90,  Left=52, Width=209, H=21)
359:     *   Get_Descricao -> txt_4c_Descricao (Top=112, Left=52, Width=295, H=23)
360:     *   Label3        -> lbl_4c_Label3  (Top=145, Left=52, Width=193, H=21)
361:     *   Get_Produto   -> txt_4c_Produto (Top=167, Left=52, Width=113, H=23)
362:     *
363:     * Fase 6/8: SEGUNDA METADE (ordem do layout.json/dump legado):
364:     *   Label5      -> lbl_4c_Label5  (Top=199, Left=52, Width=254, H=21)
365:     *   Get_RefFor  -> txt_4c_RefFor  (Top=221, Left=52, Width=160, H=23)
366:     *   Label6      -> lbl_4c_Label6  (Top=253, Left=52, Width=212, H=21)
367:     *   get_DPro2s  -> txt_4c_DPro2s  (Top=275, Left=52, Width=295, H=23)
368:     * mais o BINDEVENT "LostFocus" (regra #47 - o legado valida no Valid,
369:     * ou seja ao SAIR do campo) + os 4 metodos <Campo>LostFocus/
370:     * <Campo>LostFocusExec completos (logo apos TornarControlesVisiveis,
371:     * antes do ENDDEFINE).
372:     *
373:     * Label4 (instrucao ESC) e o CommandButton Sair entram na Fase 7/8.
374:     *
375:     * Os Say* do legado sao classe "say" pura (sem Width/Alignment no dump -
376:     * regra #23): AutoSize=.F. + Alignment=0 + ForeColor=RGB(90,90,90)
377:     * (regra #12 - nao ha container escuro aqui, a pagina eh clara).
378:     *
379:     * Valor inicial de cada TextBox vem do BO (this_cDpros/this_cCpros/
380:     * this_cReffs/this_cDpro2s - fonte unica, equivalente ao "ThisForm.
381:     * Produto = Space(14)" do Init legado que LimparDados() do BO
382:     * reproduz), nao de literal "". MaxLength = largura da coluna no
383:     * schema (Dpros char(65), Cpros char(14), Reffs char(40), Dpro2s
384:     * char(45) - docs/schema.sql), NUNCA o Width em pixels (regra #19).
385:     *--------------------------------------------------------------------------
386:     PROTECTED PROCEDURE ConfigurarPaginaDados()
387:         LOCAL loc_oErro
388:         TRY
389:             *-- Label1 (Say) + Get_Descricao -> criterio de busca por Descricao (Dpros)
390:             THIS.AddObject("lbl_4c_Label1", "Label")
391:             WITH THIS.lbl_4c_Label1
392:                 .FontName  = "Tahoma"
393:                 .FontSize  = 12
394:                 .WordWrap  = .T.
395:                 .AutoSize  = .F.
396:                 .Alignment = 0
397:                 .BackStyle = 0
398:                 .Caption   = "Busca Produto pela Descri" + CHR(231) + CHR(227) + "o"
399:                 .Height    = 21
400:                 .Left      = 52
401:                 .Top       = 90
402:                 .Width     = 209
403:                 .ForeColor = RGB(90, 90, 90)
404:             ENDWITH
405: 
406:             THIS.AddObject("txt_4c_Descricao", "TextBox")
407:             WITH THIS.txt_4c_Descricao
408:                 .Value     = ""                 && carga real centralizada em BOParaForm() - fonte unica (this_cDpros)
409:                 .MaxLength = 40
410:                 .FontName  = "Tahoma"
411:                 .FontSize  = 8
412:                 .Left      = 52
413:                 .Top       = 112
414:                 .Width     = 295
415:                 .Height    = 23
416:                 .ForeColor = RGB(0, 0, 0)
417:                 .BackColor = RGB(255, 255, 234)
418:             ENDWITH
419: 
420:             *-- Label3 (Say) + Get_Produto -> criterio de busca por Codigo (Cpros)
421:             THIS.AddObject("lbl_4c_Label3", "Label")
422:             WITH THIS.lbl_4c_Label3
423:                 .FontName  = "Tahoma"
424:                 .FontSize  = 12
425:                 .WordWrap  = .T.
426:                 .AutoSize  = .F.

*-- Linhas 514 a 1143:
514:                 .BackColor = RGB(255, 255, 234)
515:             ENDWITH
516: 
517:             *-- BINDEVENT "LostFocus" nos 4 campos de criterio (regra #47 - o
518:             *-- legado valida no Valid, ou seja ao SAIR do campo, NUNCA em
519:             *-- KeyPress sem testar a tecla). Handlers completos logo apos
520:             *-- TornarControlesVisiveis.
521:             BINDEVENT(THIS.txt_4c_Descricao, "LostFocus", THIS, "DescricaoLostFocus")
522:             BINDEVENT(THIS.txt_4c_Produto,   "LostFocus", THIS, "ProdutoLostFocus")
523:             BINDEVENT(THIS.txt_4c_RefFor,    "LostFocus", THIS, "RefForLostFocus")
524:             BINDEVENT(THIS.txt_4c_DPro2s,    "LostFocus", THIS, "DPro2sLostFocus")
525: 
526:             *-- Carga INICIAL dos 4 criterios a partir do BO. Centralizada
527:             *-- aqui (e nao inline em cada AddObject) para que exista UM
528:             *-- ponto de recarga - o mesmo metodo eh reusado por
529:             *-- LimparCampos(). Ver nota da Fase 8/8 no cabecalho.
530:             THIS.BOParaForm()
531:         CATCH TO loc_oErro
532:             MsgErro(loc_oErro.Message + CHR(13) + ;
533:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
534:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarPaginaDados")
535:         ENDTRY
536:     ENDPROC
537: 
538:     *--------------------------------------------------------------------------
539:     * ConfigurarBotaoSair - Label4 (instrucao de ESC) + cmd_4c_Sair, os
540:     * dois unicos controles do legado que ainda faltavam (ver nota da Fase
541:     * 7/8 no cabecalho do arquivo).
542:     *
543:     * Label4: classe "label" pura, sem Width/Alignment no dump a nao ser
544:     * AutoSize=.T. - regra #23 (AutoSize eh no-op em Label criado por
545:     * AddObject) manda escrever AutoSize=.F. + Width/Height EXATOS do SCX
546:     * (219x18) em vez de confiar no auto-calculo. Visible fica no default
547:     * .T. (o dump NAO declara Visible para Label4 - os 4 Valid() so
548:     * reforcam ".t." quando ha uma tentativa de busca, redundante com o
549:     * estado inicial).
550:     *
551:     * cmd_4c_Sair: unico CommandButton do legado (BaseClass=commandbutton
552:     * puro, sem Picture no dump). .Cancel = .T. eh o que faz o VFP9
553:     * acionar o Click deste botao quando o usuario pressiona ESC - eh
554:     * exatamente o que o Label4 anuncia ("[Pressione <ESC> para
555:     * cancelar]"). Sem equivalente a THIS.lbl_4c_Label4.Visible = .t. aqui
556:     * porque o controle ja nasce visivel (ver acima).
557:     *--------------------------------------------------------------------------
558:     PROTECTED PROCEDURE ConfigurarBotaoSair()
559:         LOCAL loc_oErro
560:         TRY
561:             THIS.AddObject("lbl_4c_Label4", "Label")
562:             WITH THIS.lbl_4c_Label4
563:                 .FontBold  = .T.
564:                 .FontName  = "Tahoma"
565:                 .FontSize  = 10
566:                 .WordWrap  = .T.
567:                 .AutoSize  = .F.
568:                 .Alignment = 0
569:                 .BackStyle = 0
570:                 .Caption   = "[Pressione <ESC> para cancelar]"
571:                 .Height    = 18
572:                 .Left      = 88
573:                 .Top       = 308
574:                 .Width     = 219
575:                 .ForeColor = RGB(90, 90, 90)
576:             ENDWITH
577: 
578:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
579:             WITH THIS.cmd_4c_Sair
580:                 .Top     = 272
581:                 .Left    = 358
582:                 .Width   = 75
583:                 .Height  = 75
584:                 .Caption = "Encerrar"
585:                 .Style   = 1
586:                 .Cancel  = .T.
587:             ENDWITH
588: 
589:             BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
590:         CATCH TO loc_oErro
591:             MsgErro(loc_oErro.Message + CHR(13) + ;
592:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
593:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ConfigurarBotaoSair")
594:         ENDTRY
595:     ENDPROC
596: 
597:     *--------------------------------------------------------------------------
598:     * BtnSairClick - cmd_4c_Sair.Click. Transcricao literal do Click do
599:     * legado (regra #17/#31):
600:     *   PROCEDURE Click
601:     *   x=Inkey(.1)
602:     *   ThisForm.Release
603:     * INKEY(0.1) eh a mesma pausa de 0.1s do legado antes de liberar o
604:     * form (nao ha nada mais a fazer com o retorno - a variavel "x" do
605:     * legado tambem era descartada).
606:     *--------------------------------------------------------------------------
607:     PROCEDURE BtnSairClick()
608:         LOCAL loc_nTecla
609:         loc_nTecla = INKEY(0.1)
610:         THIS.Release()
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
615:     *--------------------------------------------------------------------------
616:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
617:         LOCAL loc_i, loc_oControl, loc_oErro
618:         TRY
619:             FOR loc_i = 1 TO par_oContainer.ControlCount
620:                 loc_oControl = par_oContainer.Controls(loc_i)
621:                 IF VARTYPE(loc_oControl) = "O"
622:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
623:                         loc_oControl.Visible = .T.
624:                     ENDIF
625:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
626:                        loc_oControl.ControlCount > 0
627:                         THIS.TornarControlesVisiveis(loc_oControl)
628:                     ENDIF
629:                 ENDIF
630:             ENDFOR
631:         CATCH TO loc_oErro
632:             MsgErro(loc_oErro.Message + CHR(13) + ;
633:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
634:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.TornarControlesVisiveis")
635:         ENDTRY
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * FASE 6/8 - Lookups completos dos 4 campos de criterio (equivalentes aos
640:     * PROCEDURE Valid de Get_Descricao/Get_Produto/Get_RefFor/get_DPro2s do
641:     * SIGOPBUS.SCX). Padrao: wrapper PUBLIC ligado via BINDEVENT "LostFocus"
642:     * (regra #47) com guarda de reentrancia this_lEmLookup (regra #37/#47 -
643:     * FormBuscaAuxiliar eh MODAL e tira o foco, o que redispara o proprio
644:     * LostFocus) + corpo em <Nome>LostFocusExec() PROTECTED, que devolve
645:     * .T./.F. indicando se o dialogo deve ser fechado (ThisForm.Release do
646:     * legado).
647:     *
648:     * Cada Exec reproduz literalmente (regra CLAUDE.md #17/#31 - transcrever,
649:     * nunca reescrever, mesmo quando parece estranho):
650:     *   - a ORDEM e o CONJUNTO de colunas do mAddColuna de cada campo (sao
651:     *     DIFERENTES entre si - Produto nao tem CnjLacto nem erra em ter
652:     *     cgrus a mais, RefFor nao tem cgrus, DPro2s troca cgrus por
653:     *     ObsPes/ObsPeds);
654:     *   - o filtro de Situacao (BO.ObterFiltroSituacao()) aplicado em
655:     *     Descricao/Produto/DPro2s e NUNCA em RefFor;
656:     *   - o campo ecoado de volta no TextBox apos a selecao: Descricao/
657:     *     Produto ecoam Dpros (SIM, Get_Produto.Valid tambem usa
658:     *     CrListaRemota.Dpros no legado - nao eh erro de transcricao, eh o
659:     *     dump original), RefFor ecoa Cpros, DPro2s ecoa Dpro2s;
660:     *   - Get_RefFor.Valid tem "ThisForm.Release" FORA do "If Not
661:     *     Empty(This.Value)" - o dialogo fecha ao sair do campo RefFor
662:     *     mesmo SEM ter digitado nada. Os outros 3 so fecham apos uma
663:     *     tentativa de busca (campo preenchido).
664:     *
665:     * "CnjLacto" (coluna condicional do legado quando ThisForm.CnjLacto eh
666:     * .T.) NAO existe em SigCdPro (docs/schema.sql, regra #14/#22/#48) -
667:     * omitida nos 4 campos. Conjunts e CodMacro existem e sao preservados.
668:     *==========================================================================
669: 
670:     *--------------------------------------------------------------------------
671:     * DescricaoLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Dpros
672:     *--------------------------------------------------------------------------
673:     PROCEDURE DescricaoLostFocus()
674:         LOCAL loc_oErro, loc_lFechar
675:         IF THIS.this_lEmLookup
676:             RETURN
677:         ENDIF
678:         THIS.this_lEmLookup = .T.
679:         loc_lFechar = .F.
680:         TRY
681:             loc_lFechar = THIS.DescricaoLostFocusExec()
682:         CATCH TO loc_oErro
683:             MsgErro(loc_oErro.Message + CHR(13) + ;
684:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
685:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.DescricaoLostFocus")
686:         ENDTRY
687:         THIS.this_lEmLookup = .F.
688:         IF loc_lFechar
689:             THIS.Release()
690:         ENDIF
691:     ENDPROC
692: 
693:     *--------------------------------------------------------------------------
694:     * DescricaoLostFocusExec - Equivalente ao Valid de Get_Descricao. Busca
695:     * por Dpros LIKE '%valor%' (fwBuscaExt com busca parcial no legado),
696:     * filtrada por situacao quando aplicavel. Devolve .T. se o dialogo deve
697:     * ser fechado (campo nao estava vazio).
698:     *--------------------------------------------------------------------------
699:     PROTECTED FUNCTION DescricaoLostFocusExec()
700:         LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
701:         loc_lFechar = .F.
702:         *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
703:         *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
704:         *-- controle - equivale ao "This.Value" do Valid legado.
705:         THIS.FormParaBO()
706:         loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)
707: 
708:         IF !EMPTY(loc_cValor)
709:             loc_lFechar = .T.
710: 
711:             IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
712:                 THIS.lbl_4c_Label4.Visible = .T.
713:             ENDIF
714: 
715:             loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()
716: 
717:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
718:                 "SigCdPro", "cursor_4c_BuscaProduto", "Dpros", loc_cValor, ;
719:                 "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)
720: 
721:             IF VARTYPE(loc_oBusca) = "O"
722:                 IF !loc_oBusca.this_lAchouRegistro
723:                     loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
724:                     loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
725:                     loc_oBusca.mAddColuna("cgrus",  "", "Grupo")
726:                     loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
727:                     loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
728:                     IF THIS.this_oBusinessObject.this_lConjunto
729:                         loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
730:                     ENDIF
731:                     IF THIS.this_oBusinessObject.this_lCodMacro
732:                         loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
733:                     ENDIF
734:                     loc_oBusca.Show()
735:                 ENDIF
736: 
737:                 THIS.this_oBusinessObject.this_cProduto = SPACE(14)
738: 
739:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
740:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
741:                     THIS.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)
742:                 ENDIF
743: 
744:                 loc_oBusca.Release()
745:             ENDIF
746: 
747:             IF USED("cursor_4c_BuscaProduto")
748:                 USE IN cursor_4c_BuscaProduto
749:             ENDIF
750:         ENDIF
751: 
752:         RETURN loc_lFechar
753:     ENDFUNC
754: 
755:     *--------------------------------------------------------------------------
756:     * ProdutoLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Cpros
757:     *--------------------------------------------------------------------------
758:     PROCEDURE ProdutoLostFocus()
759:         LOCAL loc_oErro, loc_lFechar
760:         IF THIS.this_lEmLookup
761:             RETURN
762:         ENDIF
763:         THIS.this_lEmLookup = .T.
764:         loc_lFechar = .F.
765:         TRY
766:             loc_lFechar = THIS.ProdutoLostFocusExec()
767:         CATCH TO loc_oErro
768:             MsgErro(loc_oErro.Message + CHR(13) + ;
769:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
770:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.ProdutoLostFocus")
771:         ENDTRY
772:         THIS.this_lEmLookup = .F.
773:         IF loc_lFechar
774:             THIS.Release()
775:         ENDIF
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * ProdutoLostFocusExec - Equivalente ao Valid de Get_Produto. Busca por
780:     * Cpros, filtrada por situacao quando aplicavel (legado: "If Situas=0
781:     * Or FiltraSituas=0" sem filtro, senao aplica o Do Case - equivalente a
782:     * chamar ObterFiltroSituacao() incondicionalmente, que ja tem esse
783:     * mesmo guard). Devolve .T. se o dialogo deve ser fechado.
784:     *
785:     * NOTA DE FIDELIDADE: o legado ecoa This.Value = CrListaRemota.Dpros
786:     * (a DESCRICAO, nao o Cpros) mesmo neste campo de busca por codigo -
787:     * confirmado linha a linha no dump (sigopbus_form_codigo_fonte.txt).
788:     * Preservado literalmente (regra #17/#31); sem efeito pratico porque o
789:     * dialogo fecha imediatamente apos.
790:     *--------------------------------------------------------------------------
791:     PROTECTED FUNCTION ProdutoLostFocusExec()
792:         LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
793:         loc_lFechar = .F.
794:         *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
795:         *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
796:         *-- controle - equivale ao "This.Value" do Valid legado.
797:         THIS.FormParaBO()
798:         loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
799: 
800:         IF !EMPTY(loc_cValor)
801:             loc_lFechar = .T.
802: 
803:             IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
804:                 THIS.lbl_4c_Label4.Visible = .T.
805:             ENDIF
806: 
807:             loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()
808: 
809:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
810:                 "SigCdPro", "cursor_4c_BuscaProduto", "Cpros", loc_cValor, ;
811:                 "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)
812: 
813:             IF VARTYPE(loc_oBusca) = "O"
814:                 IF !loc_oBusca.this_lAchouRegistro
815:                     loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
816:                     loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
817:                     loc_oBusca.mAddColuna("cgrus",  "", "Grupo")
818:                     loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
819:                     loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
820:                     IF THIS.this_oBusinessObject.this_lConjunto
821:                         loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
822:                     ENDIF
823:                     IF THIS.this_oBusinessObject.this_lCodMacro
824:                         loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
825:                     ENDIF
826:                     loc_oBusca.Show()
827:                 ENDIF
828: 
829:                 THIS.this_oBusinessObject.this_cProduto = SPACE(14)
830: 
831:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
832:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
833:                     THIS.txt_4c_Produto.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpros)
834:                 ENDIF
835: 
836:                 loc_oBusca.Release()
837:             ENDIF
838: 
839:             IF USED("cursor_4c_BuscaProduto")
840:                 USE IN cursor_4c_BuscaProduto
841:             ENDIF
842:         ENDIF
843: 
844:         RETURN loc_lFechar
845:     ENDFUNC
846: 
847:     *--------------------------------------------------------------------------
848:     * RefForLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Reffs
849:     *--------------------------------------------------------------------------
850:     PROCEDURE RefForLostFocus()
851:         LOCAL loc_oErro, loc_lFechar
852:         IF THIS.this_lEmLookup
853:             RETURN
854:         ENDIF
855:         THIS.this_lEmLookup = .T.
856:         loc_lFechar = .F.
857:         TRY
858:             loc_lFechar = THIS.RefForLostFocusExec()
859:         CATCH TO loc_oErro
860:             MsgErro(loc_oErro.Message + CHR(13) + ;
861:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
862:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.RefForLostFocus")
863:         ENDTRY
864:         THIS.this_lEmLookup = .F.
865:         IF loc_lFechar
866:             THIS.Release()
867:         ENDIF
868:     ENDPROC
869: 
870:     *--------------------------------------------------------------------------
871:     * RefForLostFocusExec - Equivalente ao Valid de Get_RefFor. Busca por
872:     * Reffs (ALLTRIM, sem filtro de situacao - o legado NUNCA aplica o Do
873:     * Case de Situas neste campo). Legado so mostra o picker "If Not
874:     * loLista.plAchouRegistro" (equivalente ao this_lAchouRegistro do
875:     * FormBuscaAuxiliar - unico dos 4 campos que ja tem esse guard no
876:     * dump).
877:     *
878:     * NOTA DE FIDELIDADE (regra #17/#31 - transcrever mesmo o que parece
879:     * estranho): no dump, "ThisForm.Release" fica FORA do "If Not
880:     * Empty(This.Value)" - ao contrario dos outros 3 campos, o dialogo
881:     * SEMPRE fecha quando o foco sai de Get_RefFor, mesmo com o campo
882:     * vazio (sem nenhuma busca ter sido tentada). Por isso este Exec
883:     * devolve .T. incondicionalmente.
884:     *--------------------------------------------------------------------------
885:     PROTECTED FUNCTION RefForLostFocusExec()
886:         LOCAL loc_oBusca, loc_cValor
887: 
888:         *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
889:         *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
890:         *-- controle - equivale ao "This.Value" do Valid legado.
891:         THIS.FormParaBO()
892:         loc_cValor = ALLTRIM(THIS.this_oBusinessObject.this_cReffs)
893: 
894:         IF !EMPTY(loc_cValor)
895:             IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
896:                 THIS.lbl_4c_Label4.Visible = .T.
897:             ENDIF
898: 
899:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
900:                 "SigCdPro", "cursor_4c_BuscaProduto", "Reffs", loc_cValor, ;
901:                 "Sele" + CHR(231) + CHR(227) + "o", .F., .F., "")
902: 
903:             IF VARTYPE(loc_oBusca) = "O"
904:                 IF !loc_oBusca.this_lAchouRegistro
905:                     loc_oBusca.mAddColuna("Reffs",  "", "Ref.Fornecedor")
906:                     loc_oBusca.mAddColuna("Cpros",  "", "C" + CHR(243) + "digo")
907:                     loc_oBusca.mAddColuna("Dpros",  "", "Descri" + CHR(231) + CHR(227) + "o")
908:                     loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
909:                     loc_oBusca.mAddColuna("PesoMs", "99,999.999", "Peso M" + CHR(233) + "dio")
910:                     IF THIS.this_oBusinessObject.this_lConjunto
911:                         loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
912:                     ENDIF
913:                     IF THIS.this_oBusinessObject.this_lCodMacro
914:                         loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
915:                     ENDIF
916:                     loc_oBusca.Show()
917:                 ENDIF
918: 
919:                 THIS.this_oBusinessObject.this_cProduto = SPACE(14)
920: 
921:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
922:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
923:                     THIS.txt_4c_RefFor.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
924:                 ENDIF
925: 
926:                 loc_oBusca.Release()
927:             ENDIF
928: 
929:             IF USED("cursor_4c_BuscaProduto")
930:                 USE IN cursor_4c_BuscaProduto
931:             ENDIF
932:         ENDIF
933: 
934:         RETURN .T.
935:     ENDFUNC
936: 
937:     *--------------------------------------------------------------------------
938:     * DPro2sLostFocus - wrapper PUBLIC (BINDEVENT) do criterio Dpro2s
939:     *--------------------------------------------------------------------------
940:     PROCEDURE DPro2sLostFocus()
941:         LOCAL loc_oErro, loc_lFechar
942:         IF THIS.this_lEmLookup
943:             RETURN
944:         ENDIF
945:         THIS.this_lEmLookup = .T.
946:         loc_lFechar = .F.
947:         TRY
948:             loc_lFechar = THIS.DPro2sLostFocusExec()
949:         CATCH TO loc_oErro
950:             MsgErro(loc_oErro.Message + CHR(13) + ;
951:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
952:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.DPro2sLostFocus")
953:         ENDTRY
954:         THIS.this_lEmLookup = .F.
955:         IF loc_lFechar
956:             THIS.Release()
957:         ENDIF
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * DPro2sLostFocusExec - Equivalente ao Valid de get_DPro2s. Busca por
962:     * Dpro2s LIKE '%valor%', filtrada por situacao quando aplicavel. As
963:     * colunas do picker trocam cgrus por ObsPes/ObsPeds (fieis ao dump -
964:     * este campo nao exibe Grupo, exibe as duas observacoes do produto).
965:     * Devolve .T. se o dialogo deve ser fechado.
966:     *--------------------------------------------------------------------------
967:     PROTECTED FUNCTION DPro2sLostFocusExec()
968:         LOCAL loc_oBusca, loc_cFiltro, loc_cValor, loc_lFechar
969:         loc_lFechar = .F.
970:         *-- FormParaBO() transfere os 4 criterios digitados da tela para o BO.
971:         *-- O criterio desta busca eh lido DE LA (fonte unica), nunca mais do
972:         *-- controle - equivale ao "This.Value" do Valid legado.
973:         THIS.FormParaBO()
974:         loc_cValor  = ALLTRIM(THIS.this_oBusinessObject.this_cDpro2s)
975: 
976:         IF !EMPTY(loc_cValor)
977:             loc_lFechar = .T.
978: 
979:             IF PEMSTATUS(THIS, "lbl_4c_Label4", 5)
980:                 THIS.lbl_4c_Label4.Visible = .T.
981:             ENDIF
982: 
983:             loc_cFiltro = THIS.this_oBusinessObject.ObterFiltroSituacao()
984: 
985:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
986:                 "SigCdPro", "cursor_4c_BuscaProduto", "Dpro2s", loc_cValor, ;
987:                 "Sele" + CHR(231) + CHR(227) + "o", .F., .F., loc_cFiltro)
988: 
989:             IF VARTYPE(loc_oBusca) = "O"
990:                 IF !loc_oBusca.this_lAchouRegistro
991:                     loc_oBusca.mAddColuna("Dpro2s",  "", "Descri" + CHR(231) + CHR(227) + "o")
992:                     loc_oBusca.mAddColuna("Cpros",   "", "C" + CHR(243) + "digo")
993:                     loc_oBusca.mAddColuna("ObsPes",  "", "Obs 1")
994:                     loc_oBusca.mAddColuna("ObsPeds", "", "Obs 2")
995:                     loc_oBusca.mAddColuna("PesoMs",  "99,999.999", "Peso M" + CHR(233) + "dio")
996:                     IF THIS.this_oBusinessObject.this_lConjunto
997:                         loc_oBusca.mAddColuna("Conjunts", "", "Cod. Pai")
998:                     ENDIF
999:                     IF THIS.this_oBusinessObject.this_lCodMacro
1000:                         loc_oBusca.mAddColuna("CodMacro", "", "Cod. Macro")
1001:                     ENDIF
1002:                     loc_oBusca.Show()
1003:                 ENDIF
1004: 
1005:                 THIS.this_oBusinessObject.this_cProduto = SPACE(14)
1006: 
1007:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
1008:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_BuscaProduto")
1009:                     THIS.txt_4c_DPro2s.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDpro2s)
1010:                 ENDIF
1011: 
1012:                 loc_oBusca.Release()
1013:             ENDIF
1014: 
1015:             IF USED("cursor_4c_BuscaProduto")
1016:                 USE IN cursor_4c_BuscaProduto
1017:             ENDIF
1018:         ENDIF
1019: 
1020:         RETURN loc_lFechar
1021:     ENDFUNC
1022: 
1023:     *--------------------------------------------------------------------------
1024:     * FormParaBO - Transfere os 4 criterios de busca da tela para o Business
1025:     * Object. NAO eh convencao vazia de Page2 de Dados: estes 4 TextBox sao
1026:     * campos EDITAVEIS que alimentam a operacao desta tela (a consulta a
1027:     * SigCdPro), e o legado le cada um deles com "This.Value" dentro do
1028:     * proprio PROCEDURE Valid. Centralizar a leitura aqui da aos 4 handlers
1029:     * UMA fonte unica para o criterio, em vez de cada um reler o controle.
1030:     *
1031:     * PROTECTED porque FormBase declara o hook PROTECTED e VFP9 nao permite
1032:     * ALARGAR o escopo de metodo herdado.
1033:     *
1034:     * Sem guarda de "branco nao sobrescreve": aqui o branco eh SIGNIFICATIVO
1035:     * (criterio de busca que o usuario apagou), ao contrario de tela de
1036:     * configuracao, onde apagar o campo zeraria valor ja resolvido no Init.
1037:     * Os PEMSTATUS existem porque o metodo tambem eh alcancavel por
1038:     * FormBase.Salvar() antes de ConfigurarPaginaDados() ter criado os
1039:     * controles.
1040:     *--------------------------------------------------------------------------
1041:     PROTECTED PROCEDURE FormParaBO()
1042:         LOCAL loc_oErro
1043:         TRY
1044:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1045:                 MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1046:                     "o inicializado.", "Formsigopbus.FormParaBO")
1047:             ELSE
1048:                 IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
1049:                     THIS.this_oBusinessObject.this_cDpros = ALLTRIM(THIS.txt_4c_Descricao.Value)
1050:                 ENDIF
1051:                 IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
1052:                     THIS.this_oBusinessObject.this_cCpros = ALLTRIM(THIS.txt_4c_Produto.Value)
1053:                 ENDIF
1054:                 IF PEMSTATUS(THIS, "txt_4c_RefFor", 5)
1055:                     THIS.this_oBusinessObject.this_cReffs = ALLTRIM(THIS.txt_4c_RefFor.Value)
1056:                 ENDIF
1057:                 IF PEMSTATUS(THIS, "txt_4c_DPro2s", 5)
1058:                     THIS.this_oBusinessObject.this_cDpro2s = ALLTRIM(THIS.txt_4c_DPro2s.Value)
1059:                 ENDIF
1060:             ENDIF
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message + CHR(13) + ;
1063:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1064:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.FormParaBO")
1065:         ENDTRY
1066:     ENDPROC
1067: 
1068:     *--------------------------------------------------------------------------
1069:     * BOParaForm - Inverso de FormParaBO: escreve nos 4 TextBox o valor que
1070:     * esta nas properties de criterio do BO. Eh o ponto UNICO de carga dos
1071:     * campos - chamado no fim de ConfigurarPaginaDados() (carga inicial, no
1072:     * lugar do ".Value = TratarNulo(...)" que estava inline em cada
1073:     * AddObject) e por LimparCampos() (recarga).
1074:     *
1075:     * PROTECTED pelo mesmo motivo de FormParaBO (hook PROTECTED em FormBase).
1076:     *
1077:     * NAO substitui o eco por campo que cada Exec faz depois de uma selecao:
1078:     * o legado escreve SO no proprio campo ("This.Value =
1079:     * CrListaRemota.Dpros"), e reescrever os quatro ali seria desvio do
1080:     * PILAR 1.
1081:     *--------------------------------------------------------------------------
1082:     PROTECTED PROCEDURE BOParaForm()
1083:         LOCAL loc_oErro
1084:         TRY
1085:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1086:                 MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
1087:                     "o inicializado.", "Formsigopbus.BOParaForm")
1088:             ELSE
1089:                 IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
1090:                     THIS.txt_4c_Descricao.Value = TratarNulo(THIS.this_oBusinessObject.this_cDpros, "")
1091:                 ENDIF
1092:                 IF PEMSTATUS(THIS, "txt_4c_Produto", 5)
1093:                     THIS.txt_4c_Produto.Value = TratarNulo(THIS.this_oBusinessObject.this_cCpros, "")
1094:                 ENDIF
1095:                 IF PEMSTATUS(THIS, "txt_4c_RefFor", 5)
1096:                     THIS.txt_4c_RefFor.Value = TratarNulo(THIS.this_oBusinessObject.this_cReffs, "")
1097:                 ENDIF
1098:                 IF PEMSTATUS(THIS, "txt_4c_DPro2s", 5)
1099:                     THIS.txt_4c_DPro2s.Value = TratarNulo(THIS.this_oBusinessObject.this_cDpro2s, "")
1100:                 ENDIF
1101:             ENDIF
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message + CHR(13) + ;
1104:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1105:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.BOParaForm")
1106:         ENDTRY
1107:     ENDPROC
1108: 
1109:     *--------------------------------------------------------------------------
1110:     * LimparCampos - Zera os 4 criterios e o resultado, devolvendo o dialogo
1111:     * ao estado em que o Init legado o deixava ("ThisForm.Produto =
1112:     * Space(14)", com os 4 TextBox vazios porque o SCX nao declara Value
1113:     * nem ControlSource em nenhum deles). Delega ao BO (fonte unica dos
1114:     * valores) e repinta a tela por BOParaForm().
1115:     *
1116:     * PROTECTED - FormBase declara LimparCampos() PROTECTED.
1117:     *--------------------------------------------------------------------------
1118:     PROTECTED PROCEDURE LimparCampos()
1119:         LOCAL loc_oErro
1120:         TRY
1121:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1122:                 THIS.this_oBusinessObject.LimparDados()
1123:             ENDIF
1124:             THIS.BOParaForm()
1125:         CATCH TO loc_oErro
1126:             MsgErro(loc_oErro.Message + CHR(13) + ;
1127:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1128:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.LimparCampos")
1129:         ENDTRY
1130:     ENDPROC
1131: 
1132: 
1133:     *--------------------------------------------------------------------------
1134:     * ObterProduto - Equivalente ao PROCEDURE Unload do legado:
1135:     *   Return(Thisform.Produto)
1136:     * O form chamador le este valor apos o Show() modal retornar, antes de
1137:     * liberar o dialogo (ver nota da Fase 8/8 no cabecalho do arquivo).
1138:     *--------------------------------------------------------------------------
1139:     FUNCTION ObterProduto()
1140:         RETURN THIS.this_oBusinessObject.ObterProduto()
1141:     ENDFUNC
1142: 
1143: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopbusBO.prg):
*******************************************************************************
* sigopbusBO.prg - Business Object para Busca de Produto (dialogo auxiliar)
* Tabela principal: SigCdPro (PK: cpros)
* Origem: tasks\task649\sigopbus_form_codigo_fonte.txt (SIGOPBUS)
* Natureza: dialogo de busca (NAO eh CRUD) - pesquisa SigCdPro por Descricao,
*           Codigo, Referencia de Fornecedor ou Descritivo e devolve o
*           codigo escolhido ao form chamador.
*
* Fase 2/8 - O dump legado (tasks\task649\comportamento.json: metodosComSQL=0,
* totalQueries=0, funcoesExternas=["fwBuscaExt"]) nao tem nenhum
* TABLEUPDATE/AddCursor/Insert/Update/Delete em tabela remota - os quatro
* Valid() (Get_Descricao/Get_Produto/Get_RefFor/get_DPro2s) apenas abrem o
* picker fwBuscaExt (equivalente a FormBuscaAuxiliar no migrado) e leem o
* registro escolhido. Por isso Inserir()/Atualizar()/ExecutarExclusao()
* permanecem SEM override: o comportamento padrao herdado de BusinessBase
* ja eh o correto para este dialogo somente-leitura.
*
* Completado em: Fase 2 - CarregarDoCursor()/ObterCodigoRetorno()/
* ObterFiltroSituacao()/ObterChavePrimaria()/LimparDados()
*******************************************************************************

DEFINE CLASS sigopbusBO AS BusinessBase

    *-- Criterios de busca (um por campo de pesquisa do dialogo legado)
    this_cCpros        = ""    && cpros char(14) - codigo do produto (busca/retorno)
    this_cDpros        = ""    && dpros char(65) - descricao do produto (criterio de busca)
    this_cDpro2s       = ""    && dpro2s char(45) - descritivo do produto (criterio de busca)
    this_cReffs        = ""    && reffs char(40) - referencia de fornecedor (criterio de busca)

    *-- Resultado devolvido ao form chamador
    this_cProduto      = ""    && valor retornado (codigo, cod. pai, cod. macro ou cod. barras conforme flags abaixo)

    *-- Parametros de comportamento recebidos do form chamador (equivalentes as Lparameters do legado)
    this_nSituas       = 0     && filtro de situacao: 0=todas,1=ativos,2=inativos,3=0/1/2,4=ativos+encomenda,5=encomenda
    this_nFiltraSituas = 0     && <>0 ativa o filtro de this_nSituas na busca
    this_lTipoRetorno  = .F.   && .T.=devolve codigo de barras (cbars); .F.=devolve codigo do produto (cpros)
    this_lConjunto     = .F.   && .T.=produto trabalha com conjunto (devolve/exibe conjunts - Cod. Pai)
    this_lCodMacro     = .F.   && .T.=produto trabalha com codigo macro (devolve/exibe codmacro)
    this_lCnjLacto     = .F.   && .T.=exibe coluna de conjunto no resultado da busca

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Equivalente ao "ThisForm.Produto = Space(14)" que o
    * legado repete no inicio de cada Valid(), antes de tentar a busca, e
    * limpa tambem os criterios para o dialogo poder ser reaproveitado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCpros   = ""
        THIS.this_cDpros   = ""
        THIS.this_cDpro2s  = ""
        THIS.this_cReffs   = ""
        THIS.this_cProduto = SPACE(14)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cpros eh a PK de SigCdPro. Fica disponivel so por
    * completude de contrato (regra CLAUDE.md #51): RegistrarAuditoria nunca
    * eh chamado por este BO, porque Inserir()/Atualizar() nao sao
    * sobrescritos (dialogo somente-leitura, ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFiltroSituacao - Fragmento de filtro adicional por situacao do
    * produto, reproduzindo o "Do Case" presente nos Valid() de
    * Get_Descricao/Get_Produto/get_DPro2s do legado. So atua quando
    * this_nSituas <> 0 E this_nFiltraSituas <> 0 (legado: "If
    * Thisform.Situas <> 0 And ThisForm.FiltraSituas <> 0"); fora disso
    * devolve "" (sem filtro adicional).
    *
    * O fragmento NAO leva "And" nem "Where" na frente - quem consome
    * (par_cFiltro de FormBuscaAuxiliar) concatena "And (filtro)" por conta
    * propria (regra CLAUDE.md #37/Pattern #154).
    *
    * Get_RefFor (busca por Referencia de Fornecedor) NUNCA aplica este
    * filtro no legado - o form (Fase 6) so chama este metodo para os
    * outros tres campos de busca.
    *--------------------------------------------------------------------------
    FUNCTION ObterFiltroSituacao()
        LOCAL loc_cFiltro
        loc_cFiltro = ""

        IF THIS.this_nSituas != 0 AND THIS.this_nFiltraSituas != 0
            DO CASE
            CASE THIS.this_nSituas = 1
                loc_cFiltro = "Situas <> 2"
            CASE THIS.this_nSituas = 2
                loc_cFiltro = "Situas = 2"
            CASE THIS.this_nSituas = 3
                loc_cFiltro = "Situas In(0,1,2)"
            CASE THIS.this_nSituas = 4
                loc_cFiltro = "Situas <> 2 And Encoms = 1"
            CASE THIS.this_nSituas = 5
                loc_cFiltro = "Encoms = 1"
            ENDCASE
        ENDIF

        RETURN loc_cFiltro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCodigoRetorno - Resolve o valor que o dialogo devolve ao form
    * chamador. Legado (presente nos quatro Valid(), apos "If Lastkey() <>
    * 27", com CrListaRemota ja posicionado no registro escolhido pelo
    * picker):
    *   ThisForm.Produto = Iif(ThisForm.Conjunto, CrListaRemota.Conjunts,
    *       Iif(ThisForm.CodMacro, CrListaRemota.CodMacro,
    *       Iif(ThisForm.Tiporetorno, Str(CrListaRemota.Cbars),
    *       CrListaRemota.Cpros)))
    *
    * par_cAliasCursor eh o cursor/linha ja selecionada pelo lookup
    * (fwBuscaExt no legado, FormBuscaAuxiliar no migrado). Preenche
    * THIS.this_cProduto e devolve o mesmo valor. Guardas de TYPE() evitam
    * "Variable X is not found" quando a coluna preferida (Conjunts/
    * CodMacro/Cbars) nao vier no cursor de resultado - nesse caso cai para
    * Cpros, que eh sempre o identificador base do produto.
    *--------------------------------------------------------------------------
    FUNCTION ObterCodigoRetorno(par_cAliasCursor)
        LOCAL loc_cResultado
        loc_cResultado = SPACE(14)

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                DO CASE
                CASE THIS.this_lConjunto AND TYPE(par_cAliasCursor + ".Conjunts") != "U"
                    loc_cResultado = TratarNulo(Conjunts, SPACE(14))
                CASE THIS.this_lCodMacro AND TYPE(par_cAliasCursor + ".CodMacro") != "U"
                    loc_cResultado = TratarNulo(CodMacro, SPACE(14))
                CASE THIS.this_lTipoRetorno AND TYPE(par_cAliasCursor + ".Cbars") != "U"
                    loc_cResultado = ALLTRIM(STR(TratarNulo(Cbars, 0)))
                OTHERWISE
                    loc_cResultado = TratarNulo(Cpros, SPACE(14))
                ENDCASE
            ENDIF
        ENDIF

        THIS.this_cProduto = loc_cResultado
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a linha ATUAL de par_cAliasCursor
    * (resultado do lookup/picker apos a selecao do usuario) para as
    * properties de criterio/resultado e resolve THIS.this_cProduto (ver
    * ObterCodigoRetorno). Equivalente ao trecho comum aos quatro Valid()
    * do legado, apos "If Lastkey() <> 27": leitura das colunas do produto
    * encontrado. Regra CLAUDE.md #9: SELECT antes de acessar campo, nunca
    * campo direto sobre o alias.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                IF TYPE(par_cAliasCursor + ".Cpros") != "U"
                    THIS.this_cCpros = TratarNulo(Cpros, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Dpros") != "U"
                    THIS.this_cDpros = TratarNulo(Dpros, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Dpro2s") != "U"
                    THIS.this_cDpro2s = TratarNulo(Dpro2s, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Reffs") != "U"
                    THIS.this_cReffs = TratarNulo(Reffs, "")
                ENDIF

                THIS.ObterCodigoRetorno(par_cAliasCursor)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProduto - Equivalente ao PROCEDURE Unload do legado:
    *   Return(Thisform.Produto)
    * O legado era aberto via "DO FORM SigOpBus WITH ... TO lcVar" (o VFP
    * captura nessa clausula o retorno do Unload); o form chamador le este
    * metodo (via Formsigopbus.ObterProduto()) apos o Show() modal
    * retornar, antes de liberar o dialogo.
    *--------------------------------------------------------------------------
    FUNCTION ObterProduto()
        RETURN THIS.this_cProduto
    ENDFUNC

ENDDEFINE

