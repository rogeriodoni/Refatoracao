# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'DGrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoDGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ContaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoContaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'DContaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoDContaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'GrupoCLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoGrupoCLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'DGrupoCLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoDGrupoCLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ContaCLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoContaCLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'DContaCLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoDContaCLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_PendAud' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-HEADER] Header Caption 'Conta ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Descrição, Moeda, Saldo, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1626 linhas total):

*-- Linhas 8 a 206:
8: *
9: * FASE 5/8 - Campos principais: bloco "Filtro" do Container1 legado
10: * (Label1 / lbl_grupo / Get_Grupo / Get_DGrupo / Say1 / Get_Conta /
11: * get_Dconta), com a dependencia entre eles (os "Procedure When" do legado)
12: * e o funil que repassa o filtro ao BO e recarrega a grade (as chamadas a
13: * ThisForm.MontaTela() dos Valid).
14: *
15: * FASE 6/8 - Campos restantes e lookups: bloco "Contra-Partida" (Label4 /
16: * Say4 / Get_GrupoC / Get_DgrupoC / Say5 / Get_contaC / Get_DcontaC) e bloco
17: * "Operacao" (Shape1 / Label2 / Get_Dope, lido de SigCdPac.DopZers no Init).
18: *
19: * A resolucao codigo <-> descricao NAO chama fAcessoContab/fAcessoContas
20: * direto: essas funcoes (utils\functions.prg) reexibem o picker legado
21: * (FormBuscaSimples) e, apos ele fechar, leem o REGISTRO CORRENTE do cursor
22: * de apoio para preencher o TextBox - sem distinguir "usuario selecionou" de
23: * "usuario cancelou", o mesmo defeito que a memoria do projeto documenta para
24: * fAcessoContas em lookup de UI (auto-preenche com o 1o registro). Em troca,
25: * THIS.ResolverCodigoDescricao() usa o padrao canonico do projeto: busca
26: * EXATA pelo valor digitado e, so se ela falhar, abre o picker por
27: * THIS.AbrirLookupCanonico() (herdado de FormBase), que so atribui o valor
28: * quando this_lSelecionou confirma a escolha do usuario.
29: *
30: * FASE 7/8 - Este form NAO tem CRUD (o legado nao declara Incluir/Alterar/
31: * Visualizar/Excluir - comportamento.json nao lista nenhum desses verbos; os
32: * unicos botoes sao SelTudo/Apaga/Processar/Encerrar, ja cobertos nas fases
33: * anteriores). O trabalho real desta fase e completar BtnProcessarClick com
34: * os 4 guards do cmdProcessa.Click legado e com a geracao dos lancamentos de
35: * encerramento em si (THIS.this_oBusinessObject.ProcessarEncerramento()),
36: * deixada so ESBOCADA na Fase 6 e implementada por completo aqui.
37: *
38: * FASE 8/8 - CONSOLIDACAO FINAL: os nomes genericos de form CRUD que um
39: * checklist padrao cobraria (BtnBuscarClick, BtnSalvarClick, BtnCancelarClick,
40: * FormParaBO/BOParaForm, Habilitar/LimparCampos, CarregarLista,
41: * AjustarBotoesPorModo) NAO se aplicam aqui, pela mesma razao da Fase 7: o
42: * legado SIGOPENC nao tem Page1=Lista/Page2=Dados, nao tem registro unico em
43: * edicao e nao grava por Inserir/Atualizar/Excluir - e um dialogo de
44: * PROCESSAMENTO EM LOTE (marca contas na grade de saldos e gera, de uma vez,
45: * os lancamentos de encerramento de todas as marcadas). Os equivalentes reais
46: * ja existem sob os nomes do dominio do form:
47: *   CarregarLista()        -> CarregarDados() (recarrega grd_4c_Dados)
48: *   LimparCampos()         -> LimparFiltro() (zera os 8 campos do Container1)
49: *   BtnSalvarClick()       -> BtnProcessarClick() (acao principal, com os 4
50: *                             guards do legado e ProcessarEncerramento())
51: *   BtnCancelarClick()     -> nao existe no legado (nao ha edicao para
52: *                             cancelar; LimparFiltro() e o "reset" ja usado
53: *                             dentro do proprio BtnProcessarClick ao concluir)
54: *   BtnBuscarClick()       -> nao existe no legado (a consulta de saldos e
55: *                             automatica via AplicarFiltro(), nos LostFocus
56: *                             dos campos de Grupo/Conta - nao ha botao
57: *                             "Buscar" no dump)
58: *   HabilitarCampos()/
59: *   AjustarBotoesPorModo() -> nao existem no legado (nao ha modo
60: *                             INCLUIR/ALTERAR/VISUALIZAR; os campos do filtro
61: *                             ficam sempre editaveis, e o unico Enabled
62: *                             condicional e cmd_4c_CmdProcessa, ja tratado em
63: *                             CarregarDados())
64: *
65: * O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
66: * decisao ja documentada em FormSIGPRMEI.prg/FormSigMvExp.prg/
67: * FormSigOpCcl.prg: fConfigGeral era funcao GLOBAL do legado (sig.prg/
68: * SIGFUNCS.PRG) que nao veio no acervo; o wrapper NO-OP em
69: * projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
70: * continuar resolvendo o nome, e em codigo NOSSO nunca se chama fConfigGeral.
71: *
72: * "Procedure fazcontra" do legado (gera a entrada espelhada/contra-partida a
73: * partir do registro CORRENTE de CrSigMvCcr) nao virou metodo separado: esta
74: * dobrada dentro do SCAN de THIS.this_oBusinessObject.ProcessarEncerramento(),
75: * no bloco "Entrada CONTRA-PARTIDA", que troca Grupos/Contas/Opers pelos
76: * campos S* na mesma iteracao em que a entrada direta e montada - evita
77: * depender de releitura de "registro corrente" (que nesta arquitetura nao
78: * existe um cursor crSigMvCcr com Append Blank, e sim um INSERT INTO
79: * SigMvCcr por SQLEXEC).
80: *==============================================================================
81: 
82: DEFINE CLASS FormSigOpEnc AS FormBase
83: 
84:     Width        = 800
85:     Height       = 600
86:     AutoCenter   = .T.
87:     Caption      = "Encerramento de Contas"
88:     ShowWindow   = 1
89:     WindowType   = 1
90:     ControlBox   = .F.
91:     Closable     = .F.
92:     MaxButton    = .F.
93:     MinButton    = .F.
94:     TitleBar     = 0
95:     ClipControls = .F.
96:     Themes       = .F.
97:     BorderStyle  = 2
98:     DataSession  = 1
99: 
100:     *-- Guarda de reentrancia dos lookups (regra CLAUDE.md #37/#47): o picker
101:     *-- FormBuscaAuxiliar e MODAL e e aberto de DENTRO de um LostFocus; ao
102:     *-- tomar o foco ele faz o proprio LostFocus do campo disparar de novo, o
103:     *-- que empilharia um segundo dialogo sobre o primeiro. Ligada no FUNIL
104:     *-- (AbrirLookup<X>) e liberada DEPOIS que ele retorna.
105:     this_lEmLookup = .F.
106: 
107:     *==========================================================================
108:     * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
109:     *==========================================================================
110:     PROCEDURE Init()
111:         RETURN DODEFAULT()
112:     ENDPROC
113: 
114:     *==========================================================================
115:     * InicializarForm - Cria o Business Object e monta a estrutura visual base
116:     *==========================================================================
117:     PROTECTED PROCEDURE InicializarForm()
118:         LOCAL loc_lSucesso, loc_oErro
119:         loc_lSucesso = .F.
120: 
121:         TRY
122:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpEncBO")
123: 
124:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
125:                 MsgErro("Erro ao criar SigOpEncBO. VARTYPE retornou: " + ;
126:                     VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnc.InicializarForm")
127:             ELSE
128:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
129: 
130:                 *-- SigCdPac.DopZers precisa estar lido ANTES de
131:                 *-- ConfigurarContainerFiltro(), que copia o valor para
132:                 *-- txt_4c_Dope.Value dentro de ConfigurarCamposOperacao()
133:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
134:                     THIS.this_oBusinessObject.CarregarParametros()
135:                 ENDIF
136: 
137:                 THIS.ConfigurarCabecalho()
138:                 THIS.ConfigurarContainerFiltro()
139:                 THIS.ConfigurarAreaSaldo()
140:                 THIS.ConfigurarBotoesAcao()
141: 
142:                 THIS.TornarControlesVisiveis(THIS)
143: 
144:                 *-- Carga inicial da grade. Com o filtro de Grupo vazio o
145:                 *-- sentinela ZYWZYWZYWZ do legado nao casa nada e a grade
146:                 *-- abre VAZIA, de proposito (regra #35a).
147:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
148:                     THIS.CarregarDados()
149:                 ENDIF
150: 
151:                 loc_lSucesso = .T.
152:             ENDIF
153:         CATCH TO loc_oErro
154:             MsgErro(loc_oErro.Message + CHR(13) + ;
155:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
156:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.InicializarForm")
157:         ENDTRY
158: 
159:         RETURN loc_lSucesso
160:     ENDPROC
161: 
162:     *==========================================================================
163:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
164:     * titulo do form duplicado (sombra preta + texto branco por cima)
165:     *==========================================================================
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:         LOCAL loc_oCnt
168: 
169:         THIS.AddObject("cnt_4c_Sombra", "Container")
170:         loc_oCnt = THIS.cnt_4c_Sombra
171:         WITH loc_oCnt
172:             .Top         = 0
173:             .Left        = 0
174:             .Width       = THIS.Width
175:             .Height      = 80
176:             .BorderWidth = 0
177:             .BackColor   = RGB(100, 100, 100)
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
182:         WITH loc_oCnt.lbl_4c_Sombra
183:             .FontBold      = .T.
184:             .FontName      = "Tahoma"
185:             .FontSize      = 18
186:             .FontUnderline = .F.
187:             .WordWrap      = .T.
188:             .Alignment     = 0
189:             .BackStyle     = 0
190:             .AutoSize      = .F.
191:             .Caption       = THIS.Caption
192:             .Height        = 40
193:             .Left          = 10
194:             .Top           = 18
195:             .Width         = 769
196:             .ForeColor     = RGB(0, 0, 0)
197:             .Visible       = .T.
198:         ENDWITH
199: 
200:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
201:         WITH loc_oCnt.lbl_4c_Titulo
202:             .FontBold  = .T.
203:             .FontName  = "Tahoma"
204:             .FontSize  = 18
205:             .WordWrap  = .T.
206:             .Alignment = 0

*-- Linhas 227 a 270:
227:     * disso reduziria o valor ao ControlCount corrente (regra do VFP9 que
228:     * limita TabIndex ao numero de controles ja existentes).
229:     *==========================================================================
230:     PROTECTED PROCEDURE ConfigurarContainerFiltro()
231:         THIS.AddObject("cnt_4c_Filtro", "Container")
232:         WITH THIS.cnt_4c_Filtro
233:             .Top         = 106
234:             .Left        = 60
235:             .Width       = 679
236:             .Height      = 132
237:             .BackStyle   = 0
238:             .BorderColor = RGB(90, 90, 90)
239:             .Visible     = .T.
240:         ENDWITH
241: 
242:         THIS.ConfigurarCamposFiltro()
243:         THIS.ConfigurarCamposContraPartida()
244:         THIS.ConfigurarCamposOperacao()
245:         THIS.AjustarTabIndexContainer1()
246:     ENDPROC
247: 
248:     *==========================================================================
249:     * ConfigurarCamposFiltro - Bloco "Filtro" do Container1 legado, transcrito
250:     * objeto a objeto do dump (Top/Left/Width/Height/Font/ForeColor/Format/
251:     * MaxLength). Os Top/Left ficam IGUAIS aos do dump porque sao relativos ao
252:     * Container, que ja esta posicionado em 106,60 - nao ha PageFrame com
253:     * Top = -29 neste form (layout FLAT), logo nao ha compensacao a aplicar.
254:     *
255:     * Mapa legado -> migrado:
256:     *   Label1     "Filtro"  -> lbl_4c_Filtro
257:     *   lbl_grupo  "Grupo :" -> lbl_4c_Grupo
258:     *   Get_Grupo            -> txt_4c_Grupo    (SigCdGcr.codigos char(10))
259:     *   Get_DGrupo           -> txt_4c_DGrupo   (SigCdGcr.descrs  char(40))
260:     *   Say1       "Conta :" -> lbl_4c_Conta
261:     *   Get_Conta            -> txt_4c_Conta    (SigCdCli.iclis   char(10))
262:     *   get_Dconta           -> txt_4c_DConta   (SigCdCli.rclis   char(50))
263:     *
264:     * ForeColor dos rotulos: Label1 declara 255,0,0 EXPLICITO no dump (titulo
265:     * de secao em Verdana 10 bold, igual ao Label4/Label2 do mesmo container);
266:     * lbl_grupo e Say1 declaram 90,90,90, que tambem e o canonico da classe
267:     * say sobre a textura clara do form (regra CLAUDE.md #12). Nenhum deles
268:     * leva branco.
269:     *
270:     * AutoSize: lbl_grupo declara AutoSize = .T. no dump, mas AutoSize e

*-- Linhas 305 a 348:
305:     * final de ConfigurarContainerFiltro(), quando os 16 controles do dump
306:     * (Contra-Partida e Operacao inclusive) ja existem no container.
307:     *==========================================================================
308:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
309:         LOCAL loc_oCnt
310:         loc_oCnt = THIS.cnt_4c_Filtro
311: 
312:         *-- Label1 "Filtro" (titulo da secao)
313:         loc_oCnt.AddObject("lbl_4c_Filtro", "Label")
314:         WITH loc_oCnt.lbl_4c_Filtro
315:             .Top       = 2
316:             .Left      = 3
317:             .Width     = 40
318:             .Height    = 17
319:             .AutoSize  = .F.
320:             .Alignment = 0
321:             .BackStyle = 0
322:             .FontName  = "Verdana"
323:             .FontSize  = 10
324:             .FontBold  = .T.
325:             .ForeColor = RGB(255, 0, 0)
326:             .Caption   = "Filtro"
327:             .Visible   = .T.
328:         ENDWITH
329: 
330:         *-- lbl_grupo "Grupo :"
331:         loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
332:         WITH loc_oCnt.lbl_4c_Grupo
333:             .Top       = 7
334:             .Left      = 83
335:             .Width     = 38
336:             .Height    = 15
337:             .AutoSize  = .F.
338:             .Alignment = 0
339:             .BackStyle = 0
340:             .FontName  = "Tahoma"
341:             .FontSize  = 8
342:             .ForeColor = RGB(90, 90, 90)
343:             .Caption   = "Grupo :"
344:             .Visible   = .T.
345:         ENDWITH
346: 
347:         *-- Get_Grupo - codigo do Grupo de Contas do filtro (SigCdGcr.codigos)
348:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")

*-- Linhas 434 a 523:
434:             .Visible           = .T.
435:         ENDWITH
436: 
437:         *-- DEPENDENCIA entre os campos (os "Procedure When" do legado, que
438:         *-- bloqueiam o foco enquanto a dependencia nao e satisfeita).
439:         *-- BINDEVENT "When" funciona de forma confiavel em TextBox - ao
440:         *-- contrario de "Valid", que NAO e (regra CLAUDE.md).
441:         BINDEVENT(loc_oCnt.txt_4c_DGrupo, "When", THIS, "DGrupoWhen")
442:         BINDEVENT(loc_oCnt.txt_4c_Conta,  "When", THIS, "ContaWhen")
443:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When", THIS, "DContaWhen")
444: 
445:         *-- O Valid do legado roda ao SAIR do campo; o gancho equivalente e
446:         *-- "LostFocus" (BINDEVENT "Valid" nao e confiavel em TextBox).
447:         BINDEVENT(loc_oCnt.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
448:         BINDEVENT(loc_oCnt.txt_4c_DGrupo, "LostFocus", THIS, "DGrupoLostFocus")
449:         BINDEVENT(loc_oCnt.txt_4c_Conta,  "LostFocus", THIS, "ContaLostFocus")
450:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
451:     ENDPROC
452: 
453:     *==========================================================================
454:     * ConfigurarCamposContraPartida - Bloco "Contra-Partida" do Container1
455:     * legado, transcrito do dump: Label4 (titulo da secao) / Get_GrupoC +
456:     * Get_DgrupoC + Say4 (par Grupo) / Get_contaC + Get_DcontaC + Say5 (par
457:     * Conta). Os quatro getters sao classe fwget (framework.vcx), igual aos
458:     * da fase anterior: Height = 23, Themes = .F., DisabledBackColor/
459:     * DisabledForeColor.
460:     *
461:     * Mapa legado -> migrado:
462:     *   Label4     "Contra-Partida" -> lbl_4c_ContraPartida
463:     *   Say4       "Grupo :"        -> lbl_4c_GrupoC
464:     *   Get_GrupoC                  -> txt_4c_GrupoC   (SigCdGcr.codigos char(10))
465:     *   Get_DgrupoC                 -> txt_4c_DGrupoC  (SigCdGcr.descrs  char(40))
466:     *   Say5       "Conta :"        -> lbl_4c_ContaC
467:     *   Get_contaC                  -> txt_4c_ContaC   (SigCdCli.iclis   char(10))
468:     *   Get_DcontaC                 -> txt_4c_DContaC  (SigCdCli.rclis   char(50))
469:     *
470:     * ForeColor: Label4 declara 255,0,0 (mesmo vermelho de Label1, titulo de
471:     * secao); Say4/Say5 declaram 90,90,90 (classe say sobre a textura clara
472:     * do form, regra CLAUDE.md #12). AutoSize = .T. de Label4 e NO-OP em
473:     * Label por AddObject (regra #23) - fica .F. com Width/Height do dump.
474:     *
475:     * MaxLength (regra #19): Get_GrupoC/Get_contaC usam o default herdado da
476:     * classe fwget (sem MaxLength no dump); Get_DcontaC declara 50, que
477:     * confere com SigCdCli.rclis char(50). Get_DgrupoC nao declara MaxLength
478:     * no dump.
479:     *
480:     * TabIndex: fica para AjustarTabIndexContainer1() - ver comentario em
481:     * ConfigurarContainerFiltro().
482:     *==========================================================================
483:     PROTECTED PROCEDURE ConfigurarCamposContraPartida()
484:         LOCAL loc_oCnt
485:         loc_oCnt = THIS.cnt_4c_Filtro
486: 
487:         *-- Label4 "Contra-Partida" (titulo da secao)
488:         loc_oCnt.AddObject("lbl_4c_ContraPartida", "Label")
489:         WITH loc_oCnt.lbl_4c_ContraPartida
490:             .Top       = 53
491:             .Left      = 2
492:             .Width     = 110
493:             .Height    = 18
494:             .AutoSize  = .F.
495:             .Alignment = 0
496:             .BackStyle = 0
497:             .FontName  = "Verdana"
498:             .FontSize  = 10
499:             .FontBold  = .T.
500:             .ForeColor = RGB(255, 0, 0)
501:             .Caption   = "Contra-Partida"
502:             .Visible   = .T.
503:         ENDWITH
504: 
505:         *-- Say4 "Grupo :" (rotulo do par GrupoC/DgrupoC)
506:         loc_oCnt.AddObject("lbl_4c_GrupoC", "Label")
507:         WITH loc_oCnt.lbl_4c_GrupoC
508:             .Top       = 78
509:             .Left      = 83
510:             .Width     = 38
511:             .Height    = 15
512:             .AutoSize  = .F.
513:             .Alignment = 0
514:             .BackStyle = 0
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .ForeColor = RGB(90, 90, 90)
518:             .Caption   = "Grupo :"
519:             .Visible   = .T.
520:         ENDWITH
521: 
522:         *-- Get_GrupoC - codigo do Grupo contra-partida (SigCdGcr.codigos)
523:         loc_oCnt.AddObject("txt_4c_GrupoC", "TextBox")

*-- Linhas 608 a 677:
608:             .Visible           = .T.
609:         ENDWITH
610: 
611:         *-- DEPENDENCIA entre os campos (os "Procedure When" do legado).
612:         *-- Get_GrupoC e Get_contaC NAO tem "Procedure When" no dump - ficam
613:         *-- sempre habilitados, sem depender do par Grupo/Conta do Filtro.
614:         BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "When", THIS, "DGrupoCWhen")
615:         BINDEVENT(loc_oCnt.txt_4c_DContaC, "When", THIS, "DContaCWhen")
616: 
617:         *-- O Valid do legado roda ao SAIR do campo (regra LostFocus, como no
618:         *-- bloco Filtro). Nenhum dos quatro chama MontaTela() - a
619:         *-- Contra-Partida nao afeta a consulta da grade de saldos.
620:         BINDEVENT(loc_oCnt.txt_4c_GrupoC,  "LostFocus", THIS, "GrupoCLostFocus")
621:         BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "LostFocus", THIS, "DGrupoCLostFocus")
622:         BINDEVENT(loc_oCnt.txt_4c_ContaC,  "LostFocus", THIS, "ContaCLostFocus")
623:         BINDEVENT(loc_oCnt.txt_4c_DContaC, "LostFocus", THIS, "DContaCLostFocus")
624:     ENDPROC
625: 
626:     *==========================================================================
627:     * ConfigurarCamposOperacao - Bloco "Operacao" do Container1 legado:
628:     * Shape1 (moldura) + Label2 (titulo da secao) + Get_Dope (valor lido de
629:     * SigCdPac.DopZers no Init - this_cOperacao do BO, ja carregado por
630:     * CarregarParametros() antes deste metodo rodar).
631:     *
632:     * Get_Dope.When do legado devolve .F. incondicional: o campo nunca recebe
633:     * foco, e por isso nunca e digitado pelo usuario - e so exibicao do
634:     * parametro do sistema. BackColor 255,255,215 (amarelo palido) e o padrao
635:     * do framework legado para esse tipo de campo informativo.
636:     *==========================================================================
637:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
638:         LOCAL loc_oCnt
639:         loc_oCnt = THIS.cnt_4c_Filtro
640: 
641:         loc_oCnt.AddObject("shp_4c_Operacao", "Shape")
642:         WITH loc_oCnt.shp_4c_Operacao
643:             .Top         = 72
644:             .Left        = 509
645:             .Width       = 166
646:             .Height      = 57
647:             .BackStyle   = 0
648:             .Curvature   = 0
649:             .BorderColor = RGB(90, 90, 90)
650:             .Visible     = .T.
651:         ENDWITH
652: 
653:         *-- Label2 "Operacao" (titulo da secao)
654:         loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
655:         WITH loc_oCnt.lbl_4c_Operacao
656:             .Top       = 78
657:             .Left      = 517
658:             .Width     = 72
659:             .Height    = 18
660:             .AutoSize  = .F.
661:             .Alignment = 0
662:             .BackStyle = 0
663:             .FontName  = "Verdana"
664:             .FontSize  = 10
665:             .FontBold  = .T.
666:             .ForeColor = RGB(255, 0, 0)
667:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         *-- Get_Dope - operacao de movimento de estoque (SigCdPac.DopZers)
672:         loc_oCnt.AddObject("txt_4c_Dope", "TextBox")
673:         WITH loc_oCnt.txt_4c_Dope
674:             .Top       = 99
675:             .Left      = 516
676:             .Width     = 151
677:             .Height    = 23

*-- Linhas 686 a 778:
686:         ENDWITH
687: 
688:         *-- Get_Dope.When devolve .F. incondicional no legado
689:         BINDEVENT(loc_oCnt.txt_4c_Dope, "When", THIS, "DopeWhen")
690:     ENDPROC
691: 
692:     *==========================================================================
693:     * AjustarTabIndexContainer1 - Aplica o TabIndex dos rotulos e dos getters
694:     * de Contra-Partida/Operacao, transcritos do dump (regra CLAUDE.md #
695:     * explicada em ConfigurarCamposFiltro). Roda por ULTIMO, quando os 16
696:     * controles ja existem no container - so assim o VFP9 aceita os valores
697:     * altos (9..16) sem renumerar/limitar.
698:     *==========================================================================
699:     PROTECTED PROCEDURE AjustarTabIndexContainer1()
700:         LOCAL loc_oCnt
701:         loc_oCnt = THIS.cnt_4c_Filtro
702: 
703:         loc_oCnt.txt_4c_GrupoC.TabIndex         = 5
704:         loc_oCnt.txt_4c_DGrupoC.TabIndex        = 6
705:         loc_oCnt.txt_4c_ContaC.TabIndex         = 7
706:         loc_oCnt.txt_4c_DContaC.TabIndex        = 8
707:         loc_oCnt.lbl_4c_Grupo.TabIndex          = 9
708:         loc_oCnt.lbl_4c_Filtro.TabIndex         = 10
709:         loc_oCnt.lbl_4c_ContraPartida.TabIndex  = 11
710:         loc_oCnt.txt_4c_Dope.TabIndex           = 12
711:         loc_oCnt.lbl_4c_GrupoC.TabIndex         = 13
712:         loc_oCnt.lbl_4c_ContaC.TabIndex         = 14
713:         loc_oCnt.lbl_4c_Conta.TabIndex          = 15
714:         loc_oCnt.lbl_4c_Operacao.TabIndex       = 16
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * DGrupoWhen / ContaWhen / DContaWhen - equivalentes aos "Procedure When"
719:     * do legado, transcritos um a um:
720:     *
721:     *   Get_DGrupo.When  -> IsEmpty(Get_Grupo.Value)
722:     *   Get_Conta.When   -> Not IsEmpty(Get_Grupo.Value)
723:     *   get_Dconta.When  -> IsEmpty(Get_Conta.Value) And
724:     *                       Not IsEmpty(Get_Grupo.Value)
725:     *
726:     * Isto e, cada par codigo/descricao aceita digitacao por UM lado so, e a
727:     * Conta so abre depois que o Grupo esta preenchido.
728:     *
729:     * DGrupoCWhen / DContaCWhen seguem o mesmo padrao para a Contra-Partida -
730:     * Get_GrupoC e Get_contaC NAO tem When no dump (sempre habilitados):
731:     *
732:     *   Get_DgrupoC.When -> IsEmpty(Get_GrupoC.Value)
733:     *   Get_DcontaC.When -> IsEmpty(Get_ContaC.Value)
734:     *
735:     * DopeWhen e o Get_Dope.When do legado - devolve .F. incondicional, o
736:     * campo nunca recebe foco (e so exibicao do parametro do sistema).
737:     *
738:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
739:     *==========================================================================
740:     FUNCTION DGrupoWhen()
741:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
742:     ENDFUNC
743: 
744:     FUNCTION ContaWhen()
745:         RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
746:     ENDFUNC
747: 
748:     FUNCTION DContaWhen()
749:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)) AND ;
750:                !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
751:     ENDFUNC
752: 
753:     FUNCTION DGrupoCWhen()
754:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value))
755:     ENDFUNC
756: 
757:     FUNCTION DContaCWhen()
758:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value))
759:     ENDFUNC
760: 
761:     FUNCTION DopeWhen()
762:         RETURN .F.
763:     ENDFUNC
764: 
765:     *==========================================================================
766:     * ResolverCodigoDescricao - Substitui fAcessoContab()/fAcessoContas() na
767:     * resolucao codigo <-> descricao dos quatro pares de campos deste form
768:     * (Grupo/DGrupo, GrupoC/DgrupoC, Conta/DConta, ContaC/DContaC).
769:     *
770:     * As duas funcoes legado (utils\functions.prg) reexibem o picker
771:     * FormBuscaSimples e, ao fechar, leem o REGISTRO CORRENTE do cursor de
772:     * apoio para preencher o par - sem distinguir "usuario selecionou" de
773:     * "usuario cancelou o dialogo". E exatamente o defeito que a memoria do
774:     * projeto documenta para fAcessoContas em lookup de UI (auto-preenche com
775:     * o 1o registro do cursor ao cancelar). Aqui, em troca, busca-se o valor
776:     * EXATO primeiro; so na falta dele abre-se THIS.AbrirLookupCanonico()
777:     * (herdado de FormBase), que SO atribui quando o usuario confirma a
778:     * escolha (this_lSelecionou) - nunca apaga o que foi digitado (regra

*-- Linhas 784 a 830:
784:     * exclusividade e garantida pelos When acima, que so liberam o campo de
785:     * descricao quando o de codigo esta vazio.
786:     *
787:     * PROTECTED: nenhum BINDEVENT aponta direto para este metodo (so para os
788:     * *LostFocus que o chamam).
789:     *==========================================================================
790:     PROTECTED PROCEDURE ResolverCodigoDescricao(par_oTxtCod, par_oTxtDesc, ;
791:             par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
792:         LOCAL loc_cCod, loc_cDesc, loc_cCursor, loc_cSQL, loc_nResult, loc_oErro
793:         loc_cCursor = "cursor_4c_ResolverCodDesc"
794: 
795:         TRY
796:             loc_cCod  = ALLTRIM(par_oTxtCod.Value)
797:             loc_cDesc = ALLTRIM(par_oTxtDesc.Value)
798: 
799:             IF !EMPTY(loc_cCod)
800:                 IF USED(loc_cCursor)
801:                     USE IN (loc_cCursor)
802:                 ENDIF
803: 
804:                 loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
805:                     " FROM " + par_cTabela + ;
806:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
807:                     IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
808:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
809: 
810:                 IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
811:                     SELECT (loc_cCursor)
812:                     par_oTxtDesc.Value = ALLTRIM(Descs)
813:                 ELSE
814:                     THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
815:                         par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
816:                 ENDIF
817: 
818:                 IF USED(loc_cCursor)
819:                     USE IN (loc_cCursor)
820:                 ENDIF
821:             ELSE
822:                 IF !EMPTY(loc_cDesc)
823:                     IF USED(loc_cCursor)
824:                         USE IN (loc_cCursor)
825:                     ENDIF
826: 
827:                     loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
828:                         " FROM " + par_cTabela + ;
829:                         " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
830:                         IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")

*-- Linhas 846 a 1253:
846:         CATCH TO loc_oErro
847:             MsgErro(loc_oErro.Message + CHR(13) + ;
848:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
849:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")
850:         ENDTRY
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * AbrirLookupGrupo / AbrirLookupConta / AbrirLookupGrupoC / AbrirLookupContaC
855:     * - FUNIL de lookup dos quatro pares codigo/descricao do form. Um metodo
856:     * por PAR (nao por campo): no legado o mesmo fAcessoContab/fAcessoContas
857:     * atende o Valid do codigo E o da descricao, decidindo pelo argumento
858:     * 'C'/'D'; aqui quem decide e ResolverCodigoDescricao, olhando qual dos
859:     * dois TextBox do par esta preenchido.
860:     *
861:     * Tabelas e colunas transcritas do legado (NUNCA adivinhadas):
862:     *   fAcessoContab -> SigCdGcr (codigos / descrs)  - grupos contabeis
863:     *   fAcessoContas -> SigCdCli (iclis  / rclis )   - contas correntes,
864:     *                    restritas ao grupo do bloco (pGrp do legado)
865:     *
866:     * A guarda this_lEmLookup mora AQUI, no funil, e nao em cada LostFocus:
867:     * assim cobre tambem qualquer outra entrada futura (F3/DblClick) com uma
868:     * unica trava. Como ResolverCodigoDescricao envolve todo o corpo em
869:     * TRY/CATCH e nao tem RETURN antecipado, a linha que libera a flag roda
870:     * sempre - inclusive quando o CATCH dispara (regra CLAUDE.md #47).
871:     *
872:     * PUBLIC (sem PROTECTED): sao chamados pelos *LostFocus e podem ser
873:     * acionados de FORA da classe (harness de teste) - regra CLAUDE.md #3/#51.
874:     *==========================================================================
875:     PROCEDURE AbrirLookupGrupo()
876:         IF THIS.this_lEmLookup
877:             RETURN
878:         ENDIF
879:         THIS.this_lEmLookup = .T.
880:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Grupo, ;
881:             THIS.cnt_4c_Filtro.txt_4c_DGrupo, ;
882:             "SigCdGcr", "codigos", "descrs", ;
883:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
884:         THIS.this_lEmLookup = .F.
885:     ENDPROC
886: 
887:     PROCEDURE AbrirLookupConta()
888:         IF THIS.this_lEmLookup
889:             RETURN
890:         ENDIF
891:         THIS.this_lEmLookup = .T.
892:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Conta, ;
893:             THIS.cnt_4c_Filtro.txt_4c_DConta, ;
894:             "SigCdCli", "iclis", "rclis", ;
895:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
896:             THIS.FiltroGrupoParaConta())
897:         THIS.this_lEmLookup = .F.
898:     ENDPROC
899: 
900:     PROCEDURE AbrirLookupGrupoC()
901:         IF THIS.this_lEmLookup
902:             RETURN
903:         ENDIF
904:         THIS.this_lEmLookup = .T.
905:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_GrupoC, ;
906:             THIS.cnt_4c_Filtro.txt_4c_DGrupoC, ;
907:             "SigCdGcr", "codigos", "descrs", ;
908:             "Sele" + CHR(231) + CHR(227) + "o de Grupo (Contra-Partida)", "")
909:         THIS.this_lEmLookup = .F.
910:     ENDPROC
911: 
912:     PROCEDURE AbrirLookupContaC()
913:         IF THIS.this_lEmLookup
914:             RETURN
915:         ENDIF
916:         THIS.this_lEmLookup = .T.
917:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_ContaC, ;
918:             THIS.cnt_4c_Filtro.txt_4c_DContaC, ;
919:             "SigCdCli", "iclis", "rclis", ;
920:             "Sele" + CHR(231) + CHR(227) + "o de Conta (Contra-Partida)", ;
921:             THIS.FiltroGrupoCParaConta())
922:         THIS.this_lEmLookup = .F.
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * GrupoLostFocus / DGrupoLostFocus / ContaLostFocus / DContaLostFocus -
927:     * o que o Valid do legado faz ao sair de cada campo do Filtro:
928:     *
929:     *   Get_Grupo.Valid  -> fAcessoContab('C',...) / lcGrupo = This.Value /
930:     *                       ThisForm.MontaTela() / Refreshes
931:     *   Get_DGrupo.Valid -> fAcessoContab('D',...) / ThisForm.MontaTela()
932:     *   Get_Conta.Valid  -> fAcessoContas('C',...) / ThisForm.MontaTela()
933:     *   get_Dconta.Valid -> fAcessoContas('D',...) / ThisForm.MontaTela()
934:     *
935:     * O lookup fica no funil THIS.AbrirLookup<X>() (ver comentario acima), que
936:     * substitui as chamadas a fAcessoContab/fAcessoContas. O MontaTela() esta
937:     * no funil UNICO AplicarFiltro, que repassa o filtro ao BO e chama
938:     * CarregarDados.
939:     *
940:     * O IF de reentrancia aqui, alem do que ja existe no AbrirLookup<X>,
941:     * suprime tambem o AplicarFiltro() quando o LostFocus redispara com o
942:     * picker modal aberto - recarregar a grade por baixo do dialogo nao e o
943:     * que o legado faz.
944:     *
945:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
946:     *==========================================================================
947:     PROCEDURE GrupoLostFocus()
948:         IF THIS.this_lEmLookup
949:             RETURN
950:         ENDIF
951:         THIS.AbrirLookupGrupo()
952:         THIS.AplicarFiltro()
953:     ENDPROC
954: 
955:     PROCEDURE DGrupoLostFocus()
956:         IF THIS.this_lEmLookup
957:             RETURN
958:         ENDIF
959:         THIS.AbrirLookupGrupo()
960:         THIS.AplicarFiltro()
961:     ENDPROC
962: 
963:     PROCEDURE ContaLostFocus()
964:         IF THIS.this_lEmLookup
965:             RETURN
966:         ENDIF
967:         THIS.AbrirLookupConta()
968:         THIS.AplicarFiltro()
969:     ENDPROC
970: 
971:     PROCEDURE DContaLostFocus()
972:         IF THIS.this_lEmLookup
973:             RETURN
974:         ENDIF
975:         THIS.AbrirLookupConta()
976:         THIS.AplicarFiltro()
977:     ENDPROC
978: 
979:     *==========================================================================
980:     * FiltroGrupoParaConta - expressao "grupos = '<Grupo>'" usada como
981:     * par_cFiltroExtra de ResolverCodigoDescricao() para a Conta do Filtro -
982:     * equivalente ao "grupo" lido no inicio de Get_Conta.Valid/get_Dconta.Valid
983:     * do legado (ThisForm.Container1.Get_Grupo.Value), que fAcessoContas
984:     * usava para restringir a busca ao grupo do filtro.
985:     *==========================================================================
986:     PROTECTED PROCEDURE FiltroGrupoParaConta()
987:         LOCAL loc_cGrupo
988:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
989:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
990:     ENDPROC
991: 
992:     *==========================================================================
993:     * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
994:     * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
995:     *
996:     *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
997:     *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
998:     *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
999:     *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
1000:     *
1001:     * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
1002:     * filtro de saldos, so e usada no Processar (fase 7/8).
1003:     *
1004:     * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),
1005:     * que ja carrega a guarda de reentrancia do picker modal.
1006:     *
1007:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
1008:     *==========================================================================
1009:     PROCEDURE GrupoCLostFocus()
1010:         THIS.AbrirLookupGrupoC()
1011:     ENDPROC
1012: 
1013:     PROCEDURE DGrupoCLostFocus()
1014:         THIS.AbrirLookupGrupoC()
1015:     ENDPROC
1016: 
1017:     PROCEDURE ContaCLostFocus()
1018:         THIS.AbrirLookupContaC()
1019:     ENDPROC
1020: 
1021:     PROCEDURE DContaCLostFocus()
1022:         THIS.AbrirLookupContaC()
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * FiltroGrupoCParaConta - mesma ideia de FiltroGrupoParaConta(), mas para
1027:     * a Conta da Contra-Partida: o legado usa Get_GrupoC.Value (nao
1028:     * Get_Grupo.Value) como grupo de referencia em Get_contaC.Valid/
1029:     * Get_DcontaC.Valid.
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE FiltroGrupoCParaConta()
1032:         LOCAL loc_cGrupo
1033:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1034:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1035:     ENDPROC
1036: 
1037:     *==========================================================================
1038:     * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
1039:     * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
1040:     * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
1041:     *
1042:     * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
1043:     * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
1044:     * a cada saida de campo, inclusive em Tab de passagem. A semantica do
1045:     * legado e preservada - o que muda e so a consulta repetida.
1046:     *
1047:     * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
1048:     * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
1049:     * posicional concatenada (regra CLAUDE.md #42).
1050:     *
1051:     * PUBLIC (sem PROTECTED) porque e chamado dos handlers de BINDEVENT e pelo
1052:     * harness de teste, de FORA da classe - regra CLAUDE.md #3.
1053:     *==========================================================================
1054:     PROCEDURE AplicarFiltro()
1055:         LOCAL loc_cGrupo, loc_cConta, loc_oErro
1056: 
1057:         TRY
1058:             loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1059:             loc_cConta = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
1060: 
1061:             IF loc_cGrupo == ALLTRIM(THIS.this_oBusinessObject.this_cGrupoFiltro) AND ;
1062:                loc_cConta == ALLTRIM(THIS.this_oBusinessObject.this_cContaFiltro)
1063:                 *-- Filtro inalterado: a grade ja reflete esta consulta
1064:             ELSE
1065:                 THIS.this_oBusinessObject.this_cGrupoFiltro = loc_cGrupo
1066:                 THIS.this_oBusinessObject.this_cContaFiltro = loc_cConta
1067: 
1068:                 THIS.this_oBusinessObject.this_cDescGrupoFiltro = ;
1069:                     ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
1070:                 THIS.this_oBusinessObject.this_cDescContaFiltro = ;
1071:                     ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
1072: 
1073:                 THIS.CarregarDados()
1074:             ENDIF
1075:         CATCH TO loc_oErro
1076:             MsgErro(loc_oErro.Message + CHR(13) + ;
1077:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1078:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.AplicarFiltro")
1079:         ENDTRY
1080:     ENDPROC
1081: 
1082:     *==========================================================================
1083:     * LimparFiltro - "Procedure iniciar" legado completo, que zera os OITO
1084:     * campos do Filtro e da Contra-Partida:
1085:     *
1086:     *   With ThisForm.Container1
1087:     *       .Get_GrupoC.Value = ' ' / .Get_grupo.Value = ' '
1088:     *       .Get_DgrupoC.Value = ' ' / .Get_DGrupo.Value = ' '
1089:     *       .Get_DcontaC.Value = ' ' / .get_dconta.Value = ' '
1090:     *       .Get_contaC.Value = ' ' / .Get_conta.Value = ' '
1091:     *   EndWith
1092:     *   ThisForm.MontaTela()
1093:     *
1094:     * O legado usa um ESPACO, nao string vazia; aqui fica "" porque todos os
1095:     * campos passam por ALLTRIM em todo consumidor (AplicarFiltro, os When e o
1096:     * CarregarSaldos do BO), e o espaco solo so existia para o Empty() legado
1097:     * dar verdadeiro - resultado identico. Get_Dope NAO entra aqui: o legado
1098:     * "iniciar" nao o zera (e so exibicao do parametro do sistema).
1099:     *
1100:     * Zera tambem os pares guardados no BO, senao a guarda de "filtro
1101:     * inalterado" do AplicarFiltro impediria a recarga.
1102:     *
1103:     * PUBLIC (sem PROTECTED): e o encerramento do Processar e o harness de
1104:     * teste o chama de FORA da classe - regra CLAUDE.md #3.
1105:     *==========================================================================
1106:     PROCEDURE LimparFiltro()
1107:         LOCAL loc_oErro
1108: 
1109:         TRY
1110:             WITH THIS.cnt_4c_Filtro
1111:                 .txt_4c_Grupo.Value   = ""
1112:                 .txt_4c_DGrupo.Value  = ""
1113:                 .txt_4c_Conta.Value   = ""
1114:                 .txt_4c_DConta.Value  = ""
1115:                 .txt_4c_GrupoC.Value  = ""
1116:                 .txt_4c_DGrupoC.Value = ""
1117:                 .txt_4c_ContaC.Value  = ""
1118:                 .txt_4c_DContaC.Value = ""
1119:             ENDWITH
1120: 
1121:             THIS.this_oBusinessObject.this_cGrupoFiltro     = ""
1122:             THIS.this_oBusinessObject.this_cDescGrupoFiltro = ""
1123:             THIS.this_oBusinessObject.this_cContaFiltro     = ""
1124:             THIS.this_oBusinessObject.this_cDescContaFiltro = ""
1125:             THIS.this_oBusinessObject.this_cGrupoContra     = ""
1126:             THIS.this_oBusinessObject.this_cDescGrupoContra = ""
1127:             THIS.this_oBusinessObject.this_cContaContra     = ""
1128:             THIS.this_oBusinessObject.this_cDescContaContra = ""
1129: 
1130:             THIS.CarregarDados()
1131:         CATCH TO loc_oErro
1132:             MsgErro(loc_oErro.Message + CHR(13) + ;
1133:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1134:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.LimparFiltro")
1135:         ENDTRY
1136:     ENDPROC
1137: 
1138:     *==========================================================================
1139:     * ConfigurarAreaSaldo - Moldura, rotulo e grade da area de saldos
1140:     * (shp_saldo + lbl_saldo + grd_saldo do legado). Cria tambem, via
1141:     * CriarCursorSaldosPlaceholder, o cursor vazio com a MESMA estrutura que a
1142:     * carga via SQL vai usar mais adiante (SigMvSlc + SigCdCli no MontaTela
1143:     * legado), para o Grid ja nascer ligado - regra "cursor placeholder =
1144:     * cursor real" do CLAUDE.md.
1145:     *==========================================================================
1146:     PROTECTED PROCEDURE ConfigurarAreaSaldo()
1147:         THIS.AddObject("shp_4c_Saldo", "Shape")
1148:         WITH THIS.shp_4c_Saldo
1149:             .Top         = 262
1150:             .Left        = 81
1151:             .Width       = 613
1152:             .Height      = 254
1153:             .BackStyle   = 0
1154:             .Curvature   = 0
1155:             .BorderColor = RGB(90, 90, 90)
1156:             .Visible     = .T.
1157:         ENDWITH
1158: 
1159:         THIS.AddObject("lbl_4c_Saldo", "Label")
1160:         WITH THIS.lbl_4c_Saldo
1161:             .AutoSize  = .T.
1162:             .FontBold  = .T.
1163:             .FontName  = "Tahoma"
1164:             .FontSize  = 8
1165:             .BackStyle = 0
1166:             .Caption   = " Contas / Saldos "
1167:             .Top       = 248
1168:             .Left      = 90
1169:             .ForeColor = RGB(90, 90, 90)
1170:             .Visible   = .T.
1171:         ENDWITH
1172: 
1173:         THIS.CriarCursorSaldosPlaceholder()
1174:         THIS.ConfigurarGridSaldo()
1175:     ENDPROC
1176: 
1177:     *==========================================================================
1178:     * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
1179:     * carga por SQL vai popular depois (equivalente ao
1180:     * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
1181:     * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
1182:     * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
1183:     * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
1184:     * incremental.
1185:     *==========================================================================
1186:     PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
1187:         LOCAL loc_cCursor
1188:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1189: 
1190:         IF USED(loc_cCursor)
1191:             USE IN (loc_cCursor)
1192:         ENDIF
1193: 
1194:         SET NULL ON
1195:         CREATE CURSOR (loc_cCursor) ;
1196:             (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
1197:              saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
1198:         SET NULL OFF
1199: 
1200:         SELECT (loc_cCursor)
1201:         INDEX ON contas TAG Contas
1202:         INDEX ON rclis TAG Rclis
1203:     ENDPROC
1204: 
1205:     *==========================================================================
1206:     * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
1207:     * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
1208:     * Marcas - sem handler extra, o proprio binding da Column grava no
1209:     * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
1210:     * destaca a linha ja processada (Flag = 1), igual ao SetAll do
1211:     * MontaTela().
1212:     *==========================================================================
1213:     PROTECTED PROCEDURE ConfigurarGridSaldo()
1214:         LOCAL loc_cCursor
1215:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1216: 
1217:         THIS.AddObject("grd_4c_Dados", "Grid")
1218:         WITH THIS.grd_4c_Dados
1219:             .Top           = 268
1220:             .Left          = 87
1221:             .Width         = 601
1222:             .Height        = 244
1223:             .FontName      = "Tahoma"
1224:             .FontSize      = 8
1225:             .DeleteMark    = .F.
1226:             .RecordMark    = .F.
1227:             .RowHeight     = 16
1228:             .ScrollBars    = 2
1229:             .GridLineColor = RGB(238, 238, 238)
1230:             .ColumnCount   = 5
1231:             .RecordSource  = loc_cCursor
1232: 
1233:             .Column1.ControlSource     = loc_cCursor + ".contas"
1234:             .Column1.Width             = 80
1235:             .Column1.Movable           = .F.
1236:             .Column1.Resizable         = .F.
1237:             .Column1.ReadOnly          = .T.
1238:             .Column1.Header1.Caption   = "Conta "
1239:             .Column1.Header1.Alignment = 2
1240: 
1241:             .Column2.ControlSource     = loc_cCursor + ".rclis"
1242:             .Column2.Width             = 320
1243:             .Column2.Movable           = .F.
1244:             .Column2.Resizable         = .F.
1245:             .Column2.ReadOnly          = .T.
1246:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1247:             .Column2.Header1.Alignment = 2
1248: 
1249:             .Column3.ControlSource     = loc_cCursor + ".moedas"
1250:             .Column3.Alignment         = 3
1251:             .Column3.Width             = 40
1252:             .Column3.Movable           = .F.
1253:             .Column3.Resizable         = .F.

*-- Linhas 1290 a 1333:
1290:     * para um CommandButton avulso, seguindo o padrao ja usado em outros
1291:     * forms OPERACIONAIS do projeto (ex.: FormDCC.cmd_4c_Encerrar).
1292:     *==========================================================================
1293:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1294:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1295:         WITH THIS.cmd_4c_SelTudo
1296:             .Top         = 519
1297:             .Left        = 90
1298:             .Width       = 40
1299:             .Height      = 40
1300:             .Caption     = ""
1301:             .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1302:             .ToolTipText = "Seleciona tudo"
1303:             .FontName    = "Verdana"
1304:             .FontSize    = 8
1305:             .ForeColor   = RGB(36, 84, 155)
1306:             .BackColor   = RGB(255, 255, 255)
1307:             .Themes      = .T.
1308:             .Visible     = .T.
1309:         ENDWITH
1310: 
1311:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1312:         WITH THIS.cmd_4c_Apaga
1313:             .Top         = 519
1314:             .Left        = 132
1315:             .Width       = 40
1316:             .Height      = 40
1317:             .Caption     = ""
1318:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1319:             .ToolTipText = "Desmarca tudo"
1320:             .FontName    = "Verdana"
1321:             .FontSize    = 8
1322:             .ForeColor   = RGB(36, 84, 155)
1323:             .BackColor   = RGB(255, 255, 255)
1324:             .Themes      = .T.
1325:             .Visible     = .T.
1326:         ENDWITH
1327: 
1328:         THIS.AddObject("cmd_4c_CmdProcessa", "CommandButton")
1329:         WITH THIS.cmd_4c_CmdProcessa
1330:             .Top             = 3
1331:             .Left            = 650
1332:             .Width           = 75
1333:             .Height          = 75

*-- Linhas 1373 a 1626:
1373:             .Visible         = .T.
1374:         ENDWITH
1375: 
1376:         BINDEVENT(THIS.cmd_4c_SelTudo,     "Click", THIS, "BtnSelTudoClick")
1377:         BINDEVENT(THIS.cmd_4c_Apaga,       "Click", THIS, "BtnApagaClick")
1378:         BINDEVENT(THIS.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarClick")
1379:         BINDEVENT(THIS.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1380:     ENDPROC
1381: 
1382:     *==========================================================================
1383:     * CarregarDados - MontaTela() do legado: recarrega a grade de saldos a
1384:     * partir do filtro corrente (Grupo / Conta, guardados no BO) e habilita o
1385:     * Processar so quando ha linha para processar.
1386:     *
1387:     * Funil UNICO de recarga da grade. O legado chama MontaTela() em todo
1388:     * ponto que muda o filtro (Get_Grupo.Valid, Get_Conta.Valid,
1389:     * Get_DGrupo.Valid, get_Dconta.Valid e o limpa-campos); as fases
1390:     * seguintes, que criam esses campos, chamam ESTE metodo - nunca repetem a
1391:     * consulta.
1392:     *
1393:     * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
1394:     * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
1395:     * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
1396:     * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
1397:     * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
1398:     * destruiria o Check1 posto por AddObject - regra #18/#41).
1399:     *
1400:     * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
1401:     * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
1402:     * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
1403:     * SQL/permissao.
1404:     *
1405:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
1406:     * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
1407:     *==========================================================================
1408:     PROCEDURE CarregarDados()
1409:         LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro
1410:         loc_lSucesso = .F.
1411: 
1412:         TRY
1413:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1414: 
1415:             IF !USED(loc_cCursor)
1416:                 THIS.CriarCursorSaldosPlaceholder()
1417:             ENDIF
1418: 
1419:             loc_lSucesso = THIS.this_oBusinessObject.CarregarSaldos()
1420: 
1421:             loc_nLinhas = 0
1422:             IF USED(loc_cCursor)
1423:                 loc_nLinhas = RECCOUNT(loc_cCursor)
1424:                 SELECT (loc_cCursor)
1425:                 GO TOP
1426:             ENDIF
1427: 
1428:             *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
1429:             *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
1430:             THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)
1431: 
1432:             THIS.grd_4c_Dados.Refresh()
1433:         CATCH TO loc_oErro
1434:             MsgErro(loc_oErro.Message + CHR(13) + ;
1435:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1436:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
1437:         ENDTRY
1438: 
1439:         RETURN loc_lSucesso
1440:     ENDPROC
1441: 
1442:     *==========================================================================
1443:     * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
1444:     * Update CrSigMvSlc Set Marcas = 1 do legado)
1445:     *==========================================================================
1446:     PROCEDURE BtnSelTudoClick()
1447:         LOCAL loc_oErro
1448: 
1449:         TRY
1450:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1451:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
1452:                 THIS.grd_4c_Dados.Refresh()
1453:             ENDIF
1454:         CATCH TO loc_oErro
1455:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1456:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
1457:         ENDTRY
1458:     ENDPROC
1459: 
1460:     *==========================================================================
1461:     * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
1462:     * Update CrSigMvSlc Set Marcas = 0 do legado)
1463:     *==========================================================================
1464:     PROCEDURE BtnApagaClick()
1465:         LOCAL loc_oErro
1466: 
1467:         TRY
1468:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1469:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
1470:                 THIS.grd_4c_Dados.Refresh()
1471:             ENDIF
1472:         CATCH TO loc_oErro
1473:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1474:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
1475:         ENDTRY
1476:     ENDPROC
1477: 
1478:     *==========================================================================
1479:     * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
1480:     * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
1481:     * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
1482:     * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
1483:     * lancamentos de encerramento por conta marcada - delegado a
1484:     * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
1485:     * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
1486:     * Update/Commit/RollBack de ThisForm.poDataMgr.
1487:     *
1488:     * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
1489:     * mensagens do legado, na mesma ordem. Guardados numa unica variavel
1490:     * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
1491:     * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
1492:     * 4 "If Empty(...) / Return 0" sequenciais do legado).
1493:     *
1494:     * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
1495:     * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
1496:     * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
1497:     * regra CLAUDE.md #35a).
1498:     *==========================================================================
1499:     PROCEDURE BtnProcessarClick()
1500:         LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
1501:             loc_nSelecionadas, loc_oErro
1502: 
1503:         loc_cErro = ""
1504: 
1505:         TRY
1506:             loc_cGrupo  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1507:             loc_cGrupoC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1508:             loc_cContaC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
1509:             loc_cDope   = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Dope.Value)
1510: 
1511:             IF EMPTY(loc_cGrupo)
1512:                 loc_cErro = "Obrigat" + CHR(243) + "rio Informar o Grupo de Filtro!!!"
1513:             ENDIF
1514:             IF EMPTY(loc_cErro) AND EMPTY(loc_cGrupoC)
1515:                 loc_cErro = "Grupo de Contra-Partida n" + CHR(227) + "o Informado!!!"
1516:             ENDIF
1517:             IF EMPTY(loc_cErro) AND EMPTY(loc_cContaC)
1518:                 loc_cErro = "Conta de Contra-Partida n" + CHR(227) + "o informada!!!"
1519:             ENDIF
1520:             IF EMPTY(loc_cErro) AND EMPTY(loc_cDope)
1521:                 loc_cErro = "Opera" + CHR(231) + CHR(227) + "o de Mov.Estoque n" + CHR(227) + ;
1522:                     "o cadastrada nos Par" + CHR(226) + "metros do Sistema!!!"
1523:             ENDIF
1524: 
1525:             IF !EMPTY(loc_cErro)
1526:                 MsgAviso(loc_cErro, "Aten" + CHR(231) + CHR(227) + "o")
1527:             ELSE
1528:                 loc_nSelecionadas = 0
1529: 
1530:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1531:                     SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
1532:                     COUNT TO loc_nSelecionadas FOR marcas = 1
1533:                 ENDIF
1534: 
1535:                 IF loc_nSelecionadas = 0
1536:                     MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
1537:                 ELSE
1538:                     THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas
1539: 
1540:                     IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
1541:                         MsgInfo("Encerramento processado com sucesso!", "Confirmar")
1542:                         THIS.LimparFiltro()
1543:                     ELSE
1544:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1545:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
1546:                         ENDIF
1547:                         THIS.grd_4c_Dados.Refresh()
1548:                     ENDIF
1549:                 ENDIF
1550:             ENDIF
1551:         CATCH TO loc_oErro
1552:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1553:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
1554:         ENDTRY
1555:     ENDPROC
1556: 
1557:     *==========================================================================
1558:     * BtnEncerrarClick - cmdGprocessa.cmdSair.Click do legado (fecha o form)
1559:     *==========================================================================
1560:     PROCEDURE BtnEncerrarClick()
1561:         THIS.Release()
1562:     ENDPROC
1563: 
1564:     *==========================================================================
1565:     * TornarControlesVisiveis - Torna visiveis os controles criados via
1566:     * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
1567:     * recursivamente.
1568:     *==========================================================================
1569:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1570:         LOCAL loc_nI, loc_nP, loc_oObjeto
1571: 
1572:         IF VARTYPE(par_oContainer) <> "O"
1573:             RETURN
1574:         ENDIF
1575: 
1576:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1577:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1578: 
1579:             IF VARTYPE(loc_oObjeto) = "O"
1580:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1581:                     loc_oObjeto.Visible = .T.
1582:                 ENDIF
1583: 
1584:                 IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
1585:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1586:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1587:                     ENDFOR
1588:                 ENDIF
1589: 
1590:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1591:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1592:                 ENDIF
1593:             ENDIF
1594:         ENDFOR
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * Destroy - Libera os cursores de trabalho do BO (equivalente ao
1599:     * ThisForm.poDataMgr.Release do legado)
1600:     *==========================================================================
1601:     PROCEDURE Destroy()
1602:         LOCAL loc_oErro
1603: 
1604:         TRY
1605:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1606:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1607:                     USE IN (THIS.this_oBusinessObject.this_cCursorSaldos)
1608:                 ENDIF
1609:                 IF USED(THIS.this_oBusinessObject.this_cCursorLancamentos)
1610:                     USE IN (THIS.this_oBusinessObject.this_cCursorLancamentos)
1611:                 ENDIF
1612:                 IF USED(THIS.this_oBusinessObject.this_cCursorCabecalhos)
1613:                     USE IN (THIS.this_oBusinessObject.this_cCursorCabecalhos)
1614:                 ENDIF
1615:                 IF USED(THIS.this_oBusinessObject.this_cCursorParametros)
1616:                     USE IN (THIS.this_oBusinessObject.this_cCursorParametros)
1617:                 ENDIF
1618:             ENDIF
1619:         CATCH TO loc_oErro
1620:             MsgErro(loc_oErro.Message, "Erro em FormSigOpEnc.Destroy")
1621:         ENDTRY
1622: 
1623:         DODEFAULT()
1624:     ENDPROC
1625: 
1626: ENDDEFINE

