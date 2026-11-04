# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarGrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDGrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarContaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarContaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarDContaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarDContaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Fases' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Nome do Demonstrativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Fase, Funcionário, E/S, Ordem, Tipo Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo Operaç' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Fase, Funcionário, E/S, Ordem, Tipo Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigOpDmp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4124 linhas total):

*-- Linhas 9 a 68:
9: *   Fases 1-2 : SigOpDmpBO (propriedades, Init, CarregarDoCursor, Inserir,
10: *               Atualizar) + Buscar, que alimenta cursor_4c_Dados - o cursor
11: *               da grade entregue nesta fase.
12: *   Fase  3   : DEFINE CLASS + estado, Init, InicializarForm,
13: *               ConfigurarPageFrame (Page1 = Lista / Page2 = Dados) e a faixa
14: *               cinza do cabecalho nas DUAS paginas (CLAUDE.md regra #11).
15: *   Fase  4   : grade da Lista (coluna Nome, espelhando o pColuna do Init
16: *               legado), os 5 botoes CRUD, o Encerrar, Confirmar/Cancelar da
17: *               pagina Dados, CarregarLista, AlternarPagina e
18: *               AjustarBotoesPorModo.
19: *   Fase  5   : os campos da PARTE 1 da pagina Dados - a linha Nome
20: *               (Say1/GetNome do SCX) e a linha Grupo Sd Inicial
21: *               (Label1/Get_Grupo/Get_DGrupo).
22: *   Fase  6   : a linha Conta Sd Inicial (Label2/Get_Conta/Get_DConta), a
23: *               grade de fases (Grade - SigCdDpr, 5 colunas) com as celulas
24: *               editaveis e os botoes Inserir/Excluir de LINHA, os 7 lookups
25: *               (Grupo, DGrupo, Conta, DConta e as celulas Fase, Funcionario
26: *               e Tipo Operacao), as validacoes de Ordem e E/S, e o
27: *               AtualizarEstadoCampos que reproduz os "When" do legado.
28: *   Fase  7   : BINDEVENT dos 4 primeiros botoes CRUD e as regras do
29: *               Grupo_op.Click - os tres verbos que carregam registro
30: *               existente (AbrirFichaDoRegistro), o IniciaDesc
31: *               (CarregarDescricoesMestre), o Requery de SigCdDpr
32: *               (CarregarFasesDoBanco), o Zap do ramo INSERIR (LimparFases),
33: *               o Cancelar e o Encerrar.
34: *   Fase  8   : o Confirmar (BtnSalvarClick e o Do Case do Salva.Click do
35: *               frmcadastro) com a PERSISTENCIA da grade de fases
36: *               (SigOpDmpBO.GravarFases), a exclusao (ExcluirFicha +
37: *               ExcluiItens), o Buscar por exemplo (BtnBuscarClick +
38: *               ExecutarBuscaPorNome = msv_procurar), o FormParaBO, o
39: *               HabilitarCampos e o par Commit/RollBack do poDataMgr.
40: *
41: * Cursores desta tela:
42: *   cursor_4c_Dados - mestre (SigPrDmo), grade da pagina Lista, alimentado
43: *                     por SigOpDmpBO.Buscar (Fases 1-2).
44: *   cursor_4c_Fases - detalhe (SigCdDpr), grade da pagina Dados. Equivale ao
45: *                     crSigCdDpr do AddCursor do Init legado, que nasce VAZIO
46: *                     (sNome = Space(20) nao casa nenhuma linha) e so e'
47: *                     recarregado pelo Grupo_op.Click - Fases 7-8. Aqui ele e'
48: *                     criado como placeholder com a estrutura EXATA de
49: *                     SigCdDpr, porque ligar Column.ControlSource a um cursor
50: *                     inexistente derruba o Init e a tela nao abre (regra #41).
51: *
52: * Notas de fidelidade (PILAR 1):
53: *   - O SCX legado tem Caption = (prompt()), resolvido em tempo de execucao a
54: *     partir do prompt da barra de menu. O dump nao traz o texto literal, logo
55: *     o Caption fixo abaixo acompanha o cabecalho do SigOpDmpBO (Fases 1-2) e
56: *     sera o mesmo texto do DEFINE BAR no menu.prg.
57: *   - Pagina.Dados.Picture = imagens\new_background.jpg vem do SCX. A pagina
58: *     Lista nao e sobrescrita no SCX: usa a textura canonica do form de
59: *     1000px de largura (fundo_cad_1003.jpg).
60: *   - Grupo_op (Left=338) e Grupo_Saida (Left=718) do SCX estao no espaco de
61: *     coordenadas do frmcadastro de 800px. O form novo tem 1000px e usa os
62: *     valores canonicos 542 e 917 (CLAUDE.md regra #10).
63: *   - Pagina.Top = -29 no legado: todo controle das Pages compensa +29 no Top.
64: *==============================================================================
65: 
66: DEFINE CLASS FormSigOpDmp AS FormBase
67: 
68:     *-- Propriedades visuais (PILAR 1 - frmcadastro: 1000x600, sem barra de titulo)

*-- Linhas 81 a 275:
81:     this_oBusinessObject = .NULL.
82:     this_cModoAtual      = "LISTA"
83: 
84:     *-- Guarda de reentrancia dos lookups (regra #37/#47): o FormBuscaAuxiliar
85:     *-- e MODAL, tira o foco do campo e redispara o proprio LostFocus que o
86:     *-- abriu - sem a flag sobem DOIS pickers. Ligada e desligada no FUNIL
87:     *-- (AbrirLookup*), que atende as tres portas: LostFocus, F4/F5 e DblClick.
88:     this_lEmLookup       = .F.
89: 
90:     *===========================================================================
91:     * Init - Inicializa o formulario
92:     * REGRA CRITICA: apenas RETURN DODEFAULT().
93:     * FormBase.Init() ja chama InicializarForm() - NUNCA duplicar a chamada.
94:     *===========================================================================
95:     PROCEDURE Init()
96:         RETURN DODEFAULT()
97:     ENDPROC
98: 
99:     *===========================================================================
100:     * InicializarForm - Cria o Business Object e monta a estrutura do form
101:     * Chamado automaticamente por FormBase.Init() via DODEFAULT()
102:     *===========================================================================
103:     PROTECTED PROCEDURE InicializarForm()
104:         LOCAL loc_lSucesso
105:         loc_lSucesso = .F.
106: 
107:         TRY
108:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpDmpBO")
109: 
110:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
111:                 MostrarErro("Erro ao criar SigOpDmpBO" + CHR(13) + ;
112:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
113:                     "FormSigOpDmp.InicializarForm")
114:             ELSE
115:                 THIS.ConfigurarPageFrame()
116: 
117:                 *-- Titulo das faixas das DUAS paginas (legado: lblSombra/lblTitulo
118:                 *-- recebem ThisForm.Caption no Init do frmcadastro)
119:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
120:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
121:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
122:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
123: 
124:                 THIS.pgf_4c_Paginas.Visible    = .T.
125:                 THIS.pgf_4c_Paginas.ActivePage = 1
126:                 THIS.this_cModoAtual           = "LISTA"
127: 
128:                 *-- Carga inicial da grade da Lista.
129:                 *-- gb_4c_ValidandoUI = .T. significa ValidarUIFidelity rodando
130:                 *-- sem conexao SQL: nao consultar o banco (Problema 8).
131:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
132:                     THIS.CarregarLista()
133:                 ENDIF
134: 
135:                 THIS.AjustarBotoesPorModo()
136: 
137:                 loc_lSucesso = .T.
138:             ENDIF
139: 
140:         CATCH TO loException
141:             MostrarErro("Erro ao inicializar FormSigOpDmp:" + CHR(13) + ;
142:                 loException.Message + CHR(13) + ;
143:                 "Linha: " + TRANSFORM(loException.LineNo), ;
144:                 "FormSigOpDmp.InicializarForm")
145:         ENDTRY
146: 
147:         RETURN loc_lSucesso
148:     ENDPROC
149: 
150:     *===========================================================================
151:     * ConfigurarPageFrame - PageFrame com Page1 (Lista) e Page2 (Dados)
152:     * Legado: Pagina.PageCount=2, Top=-29, Left=0, abas escondidas.
153:     * Top=-29 esconde as abas; os controles das Pages compensam +29 no Top.
154:     *===========================================================================
155:     PROTECTED PROCEDURE ConfigurarPageFrame()
156:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
157: 
158:         WITH THIS.pgf_4c_Paginas
159:             .PageCount = 2
160:             .Top       = -29
161:             .Left      = 0
162:             .Width     = THIS.Width
163:             .Height    = THIS.Height + 29
164:             .Tabs      = .F.
165:             .Visible   = .T.
166: 
167:             *-- Page1 = Lista (legado: Pagina.Page1.Name = "Lista")
168:             .Page1.Caption   = "Lista"
169:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
170:             .Page1.BackColor = RGB(255, 255, 255)
171: 
172:             *-- Page2 = Dados (legado: Pagina.Page2.Name = "Dados", com a
173:             *-- Picture sobrescrita no SCX para new_background.jpg)
174:             .Page2.Caption   = "Dados"
175:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
176:             .Page2.BackColor = RGB(255, 255, 255)
177:         ENDWITH
178: 
179:         THIS.ConfigurarPaginaLista()
180:         THIS.ConfigurarPaginaDados()
181:     ENDPROC
182: 
183:     *===========================================================================
184:     * ConfigurarPaginaLista - Monta a Page1 (faixa, botoes CRUD, saida, grade)
185:     * A faixa do cabecalho e o PRIMEIRO AddObject da pagina (regra #11): os
186:     * containers de botao ficam em Top=29, DENTRO da area da faixa, e so
187:     * aparecem se criados DEPOIS dela.
188:     * A grade espelha o pColuna do Init legado: UMA coluna (Nome). O bind do
189:     * RecordSource/ControlSource fica em CarregarLista, porque a Page1 e
190:     * montada ANTES de o cursor existir (regra #41).
191:     *===========================================================================
192:     PROTECTED PROCEDURE ConfigurarPaginaLista()
193:         LOCAL loc_oPagina
194:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
195: 
196:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
197:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
198: 
199:         *-- Faixa do cabecalho (legado: Pagina.Lista.cntSombra Top=2, Height=80,
200:         *-- BackColor=100,100,100; com a compensacao +29 do PageFrame -> Top=29)
201:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
202:         WITH loc_oPagina.cnt_4c_Cabecalho
203:             .Top         = 29
204:             .Left        = 0
205:             .Width       = THIS.Width
206:             .Height      = 80
207:             .BackStyle   = 1
208:             .BackColor   = RGB(100, 100, 100)
209:             .BorderWidth = 0
210:             .Visible     = .T.
211:         ENDWITH
212: 
213:         THIS.ConfigurarLabelsCabecalho(loc_oPagina.cnt_4c_Cabecalho)
214: 
215:         *-- Container dos botoes CRUD (legado: Pagina.Lista.Grupo_op Top=-1,
216:         *-- Width=389, Height=85, Left=338 no espaco de 800px).
217:         *-- Canonico do form de 1000px: Top=29 (-1+29), Left=542, Width=390.
218:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
219:         WITH loc_oPagina.cnt_4c_Botoes
220:             .Top         = 29
221:             .Left        = 542
222:             .Width       = 390
223:             .Height      = 85
224:             .BackStyle   = 0
225:             .BorderWidth = 0
226:             .Visible     = .T.
227:         ENDWITH
228: 
229:         *-- Os 5 botoes CRUD. Ordem e papel identicos ao Grupo_op do legado:
230:         *--   Inserir(5) Consultar(81) Alterar(157) Excluir(233) Procurar(309)
231:         *-- Os Left usados sao os do framework (5/80/155/230/305, passo 75),
232:         *-- obrigatorios para todo CRUD migrado conforme
233:         *-- docs\framework_frmcadastro_layout.md; o legado usa passo 76 e os
234:         *-- 5 botoes cabem nos dois esquemas (305+75=380 < 390).
235:         *-- Sem BINDEVENT nesta fase: BINDEVENT valida o delegado no REGISTRO,
236:         *-- entao vincular a metodo que ainda nao existe aborta o Init. Os
237:         *-- handlers dos 5 vem na Fase 7, junto com o Grupo_op.Click do legado.
238: 
239:         *-- Incluir (legado: Grupo_op.Inserir)
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
242:             .Caption         = "Incluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 5
247:             .Width           = 75
248:             .Height          = 75
249:             .FontName        = "Tahoma"
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .FontSize        = 8
253:             .ForeColor       = RGB(90, 90, 90)
254:             .BackColor       = RGB(255, 255, 255)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262: 
263:         *-- Visualizar (legado: Grupo_op.Consultar)
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
266:             .Caption         = "Visualizar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 80
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Tahoma"
274:             .FontBold        = .T.
275:             .FontItalic      = .T.

*-- Linhas 333 a 510:
333:         ENDWITH
334: 
335:         *-- Buscar (legado: Grupo_op.Procurar).
336:         *-- ATENCAO Fase 7: o legado tem PROCEDURE msv_procurar, logo o
337:         *-- Procurar deste form e BUSCA POR EXEMPLO - NAO abre picker.
338:         *-- Ele poe o form em modo PROCURAR, limpa a ficha e habilita so o
339:         *-- campo Nome na pagina Dados; quem executa a consulta e o Confirmar,
340:         *-- que reproduz o msv_procurar (Set Near On, Seek pelo nome digitado,
341:         *-- Set Near Off) para posicionar a grade da Lista.
342:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
343:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
344:             .Caption         = "Buscar"
345:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
346:             .PicturePosition = 13
347:             .Top             = 5
348:             .Left            = 305
349:             .Width           = 75
350:             .Height          = 75
351:             .FontName        = "Tahoma"
352:             .FontBold        = .T.
353:             .FontItalic      = .T.
354:             .FontSize        = 8
355:             .ForeColor       = RGB(90, 90, 90)
356:             .BackColor       = RGB(255, 255, 255)
357:             .Themes          = .F.
358:             .SpecialEffect   = 0
359:             .MousePointer    = 15
360:             .WordWrap        = .T.
361:             .AutoSize        = .F.
362:             .Visible         = .T.
363:         ENDWITH
364: 
365:         *-- BINDEVENT dos 5 verbos CRUD. No legado os cinco botoes sao UM
366:         *-- CommandGroup e o verbo vem do Value (Grupo_op.Click(lnOpt), com
367:         *-- 1=INSERIR 2=CONSULTAR 3=ALTERAR 4=EXCLUIR 5=PROCURAR); aqui cada
368:         *-- Case do Do Case virou um handler PUBLIC proprio.
369:         *-- O Buscar (BtnBuscarClick) e BUSCA POR EXEMPLO - o legado tem
370:         *-- PROCEDURE msv_procurar - e quem executa a consulta e o Confirmar.
371:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
372:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
373:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
374:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
376: 
377:         *-- Container de saida (legado: Pagina.Lista.Grupo_Saida Top=-1,
378:         *-- Left=718 no espaco de 800px). Padrao canonico (regra #10, que
379:         *-- prevalece sobre o PILAR 1): Left=917, Width=90, Height=85,
380:         *-- transparente.
381:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
382:         WITH loc_oPagina.cnt_4c_Saida
383:             .Top         = 29
384:             .Left        = 917
385:             .Width       = 90
386:             .Height      = 85
387:             .BackStyle   = 0
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         *-- Encerrar (legado: Grupo_Saida.SAIR Top=5 Left=5). Caption, Width e
393:         *-- Height sao os canonicos da regra #10, nao os do SCX.
394:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
395:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
396:             .Caption         = "Encerrar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 5
401:             .Width           = 75
402:             .Height          = 75
403:             .FontName        = "Tahoma"
404:             .FontBold        = .T.
405:             .FontItalic      = .T.
406:             .FontSize        = 8
407:             .ForeColor       = RGB(90, 90, 90)
408:             .BackColor       = RGB(255, 255, 255)
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
417: 
418:         *-- Grade da Lista (legado: Pagina.Lista.Grade). O SCX sobrescreve so
419:         *-- FontName="Tahoma", FontSize=8, RowHeight=16 e ForeColor=90,90,90;
420:         *-- a geometria vem da classe frmcadastro (Top=88 -> 117 com a
421:         *-- compensacao +29, Left=26, Height=498). Width=880 para a grade nao
422:         *-- correr por baixo de cnt_4c_Saida (Left=917).
423:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH as colunas
424:         *-- nao existem na linha seguinte).
425:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
426:         loc_oPagina.grd_4c_Lista.ColumnCount = 1
427:         WITH loc_oPagina.grd_4c_Lista
428:             .Top                = 117
429:             .Left               = 26
430:             .Width              = 880
431:             .Height             = 498
432:             .FontName           = "Tahoma"
433:             .FontSize           = 8
434:             .RowHeight          = 16
435:             .ForeColor          = RGB(90, 90, 90)
436:             .BackColor          = RGB(255, 255, 255)
437:             .GridLineColor      = RGB(238, 238, 238)
438:             .HighlightBackColor = RGB(255, 255, 255)
439:             .HighlightForeColor = RGB(15, 41, 104)
440:             .HighlightStyle     = 2
441:             .DeleteMark         = .F.
442:             .RecordMark         = .F.
443:             .ScrollBars         = 2
444:             .GridLines          = 3
445:             .ReadOnly           = .T.
446:             .Visible            = .T.
447:         ENDWITH
448: 
449:         *-- Atalhos da grade (Fase 7). O Enter sobre a grade da Lista e
450:         *-- CONSULTAR no frmcadastro (KeyPress: nKeyCode=13 + ActiveControl
451:         *-- GRID -> Grupo_Op.Click(2)); o duplo clique nao existe no legado e
452:         *-- cai no MESMO funil. O handler de KeyPress declara os DOIS
453:         *-- parametros do evento, senao o VFP estoura "No PARAMETER statement
454:         *-- is found" a cada tecla (regra #3).
455:         BINDEVENT(loc_oPagina.grd_4c_Lista, "KeyPress", THIS, "GradeListaKeyPress")
456:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")
457: 
458:         THIS.TornarControlesVisiveis(loc_oPagina)
459:     ENDPROC
460: 
461:     *===========================================================================
462:     * ConfigurarPaginaDados - Monta a Page2 (faixa e Confirmar/Cancelar)
463:     * A faixa tambem vai aqui (regra #11: cabecalho nas DUAS paginas) e e o
464:     * PRIMEIRO AddObject, antes do container de Confirmar/Cancelar.
465:     * PARTE 1 (Fase 5): a linha Nome e a linha Grupo Sd Inicial.
466:     * PARTE 2 (Fase 6): a linha Conta Sd Inicial, a grade de fases com os
467:     * botoes Inserir/Excluir de linha, os BINDEVENT dos lookups e o vinculo
468:     * da grade ao cursor de detalhe.
469:     *===========================================================================
470:     PROTECTED PROCEDURE ConfigurarPaginaDados()
471:         LOCAL loc_oPagina
472:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
473: 
474:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
475:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
476: 
477:         *-- Faixa do cabecalho (mesmos valores canonicos da Page1)
478:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
479:         WITH loc_oPagina.cnt_4c_Cabecalho
480:             .Top         = 29
481:             .Left        = 0
482:             .Width       = THIS.Width
483:             .Height      = 80
484:             .BackStyle   = 1
485:             .BackColor   = RGB(100, 100, 100)
486:             .BorderWidth = 0
487:             .Visible     = .T.
488:         ENDWITH
489: 
490:         THIS.ConfigurarLabelsCabecalho(loc_oPagina.cnt_4c_Cabecalho)
491: 
492:         *-- Container Confirmar/Cancelar (legado: Pagina.Dados.Grupo_Salva,
493:         *-- com Salva em Left=5 e Cancelar em Left=80, ambos Top=5).
494:         *-- Canonico do form de 1000px: Top=33 (4+29), Left=842, Width=160.
495:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
496:         WITH loc_oPagina.cnt_4c_Salva
497:             .Top         = 33
498:             .Left        = 842
499:             .Width       = 160
500:             .Height      = 85
501:             .BackStyle = 1
502:             .BackColor = RGB(255, 255, 255)
503:             .BorderWidth = 0
504:             .Visible     = .T.
505:         ENDWITH
506: 
507:         *-- Confirmar (legado: Grupo_Salva.Salva). O Click e o despachante por
508:         *-- modo: grava o cabecalho e as fases em INCLUIR/ALTERAR, exclui em
509:         *-- EXCLUIR e executa o msv_procurar em PROCURAR (BtnSalvarClick).
510:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")

*-- Linhas 529 a 600:
529:             .AutoSize        = .F.
530:             .Visible         = .T.
531:         ENDWITH
532:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
533: 
534:         *-- Cancelar (legado: Grupo_Salva.Cancelar, cujo Click chama
535:         *-- DoDefault() e, se plCancelar, mAtivapagina1 - ou seja, volta para a
536:         *-- pagina Lista). O handler esta completo nesta fase, por isso ele ja
537:         *-- recebe BINDEVENT: sem ele a pagina Dados nao teria saida.
538:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
539:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
540:             .Caption         = "Encerrar"
541:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
542:             .PicturePosition = 13
543:             .Top             = 5
544:             .Left            = 80
545:             .Width           = 75
546:             .Height          = 75
547:             .FontName        = "Tahoma"
548:             .FontBold        = .T.
549:             .FontItalic      = .T.
550:             .FontSize        = 8
551:             .ForeColor       = RGB(90, 90, 90)
552:             .BackColor       = RGB(255, 255, 255)
553:             .Themes          = .F.
554:             .SpecialEffect   = 0
555:             .MousePointer    = 15
556:             .WordWrap        = .T.
557:             .AutoSize        = .F.
558:             .Visible         = .T.
559:         ENDWITH
560:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
561: 
562:         *-- ---------------------------------------------------------------
563:         *-- CAMPOS DA FICHA - PARTE 1: Nome e Grupo Sd Inicial
564:         *-- ---------------------------------------------------------------
565:         *-- No SCX legado os campos ficam DIRETO na Pagina.Dados (nao existe
566:         *-- container de campos), e todo Top compensa +29 porque
567:         *-- pgf_4c_Paginas.Top = -29. Nenhum deles fica abaixo de 109, logo
568:         *-- nenhum e' coberto pela faixa do cabecalho (regra #11).
569:         *--
570:         *-- Os labels sao criados ANTES dos TextBox vizinhos: a caixa de um
571:         *-- label com BackStyle = 0 nao pinta, mas interceptaria o clique no
572:         *-- campo se fosse desenhada por cima dele (regra #23).
573:         *--
574:         *-- ZOrderSet do dump NAO e' transcrito: e' propriedade so do Form
575:         *-- Designer e atribui-la em runtime derruba o Init (regra #33). O
576:         *-- legado nao chama ZOrder() em nenhum desses controles.
577: 
578:         *-- Say1 -> lbl_4c_Nome ("Nome : ", classe legada say).
579:         *-- A classe say e' AutoSize = .T., mas AutoSize e' no-op em Label
580:         *-- criado por AddObject e, com WordWrap, DESCARTA a Height (regra
581:         *-- #23): vai como .F. com os 39x15 do dump, que JA SAO o auto-size
582:         *-- calculado pelo Form Designer.
583:         *-- Alignment = 0 (esquerda) e ForeColor = 90,90,90 sao os da classe
584:         *-- say: branco aqui ficaria INVISIVEL, porque a Page tem Picture
585:         *-- clara por cima do BackColor (regra #12).
586:         loc_oPagina.AddObject("lbl_4c_Nome", "Label")
587:         WITH loc_oPagina.lbl_4c_Nome
588:             .Caption   = "Nome : "
589:             .Top       = 178
590:             .Left      = 172
591:             .Width     = 39
592:             .Height    = 15
593:             .FontName  = "Tahoma"
594:             .FontSize  = 8
595:             .FontBold  = .F.
596:             .Alignment = 0
597:             .AutoSize  = .F.
598:             .BackStyle = 0
599:             .ForeColor = RGB(90, 90, 90)
600:             .Visible   = .T.

*-- Linhas 840 a 967:
840:             .MousePointer  = 15
841:             .Visible       = .T.
842:         ENDWITH
843:         BINDEVENT(loc_oPagina.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
844: 
845:         *-- Excluir -> cmd_4c_ExcluirFase (legado: Pagina.Dados.Excluir).
846:         *-- NAO confundir com o cmd_4c_Excluir da pagina Lista (CRUD do
847:         *-- registro mestre): este exclui a LINHA da grade de fases.
848:         loc_oPagina.AddObject("cmd_4c_ExcluirFase", "CommandButton")
849:         WITH loc_oPagina.cmd_4c_ExcluirFase
850:             .Caption       = ""
851:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
852:             .ToolTipText   = "Excluir Fase"
853:             .Top           = 381
854:             .Left          = 607
855:             .Width         = 40
856:             .Height        = 40
857:             .FontName      = "Verdana"
858:             .FontSize      = 8
859:             .ForeColor     = RGB(36, 84, 155)
860:             .BackColor     = RGB(255, 255, 255)
861:             .Themes        = .F.
862:             .SpecialEffect = 0
863:             .MousePointer  = 15
864:             .Visible       = .T.
865:         ENDWITH
866:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
867: 
868:         *-- ---------------------------------------------------------------
869:         *-- LOOKUPS DOS CAMPOS DA FICHA (Valid do legado = ao SAIR do campo)
870:         *-- ---------------------------------------------------------------
871:         *-- O legado valida/abre o picker no "Valid" dos quatro campos, ou
872:         *-- seja ao SAIR deles -> "LostFocus", NUNCA "KeyPress" (regra #47):
873:         *-- ligado a KeyPress sem testar a tecla, o dialogo subiria a CADA
874:         *-- caractere e o usuario nao conseguiria terminar de digitar.
875:         *-- O F4/F5 e o duplo clique sao portas EXTRA para o mesmo funil, e
876:         *-- ali o handler TESTA par_nKeyCode antes de abrir.
877:         BINDEVENT(loc_oPagina.txt_4c_Grupo,  "LostFocus", THIS, "ValidarGrupoLostFocus")
878:         BINDEVENT(loc_oPagina.txt_4c_Grupo,  "KeyPress",  THIS, "TxtGrupoKeyPress")
879:         BINDEVENT(loc_oPagina.txt_4c_Grupo,  "DblClick",  THIS, "TxtGrupoDblClick")
880: 
881:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "LostFocus", THIS, "ValidarDGrupoLostFocus")
882:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress",  THIS, "TxtDGrupoKeyPress")
883:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick",  THIS, "TxtDGrupoDblClick")
884: 
885:         BINDEVENT(loc_oPagina.txt_4c_Conta,  "LostFocus", THIS, "ValidarContaLostFocus")
886:         BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress",  THIS, "TxtContaKeyPress")
887:         BINDEVENT(loc_oPagina.txt_4c_Conta,  "DblClick",  THIS, "TxtContaDblClick")
888: 
889:         BINDEVENT(loc_oPagina.txt_4c_DConta, "LostFocus", THIS, "ValidarDContaLostFocus")
890:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress",  THIS, "TxtDContaKeyPress")
891:         BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick",  THIS, "TxtDContaDblClick")
892: 
893:         *-- O "When" de Get_DGrupo/Get_DConta depende do valor CORRENTE do
894:         *-- campo de codigo irmao (IsEmpty(Get_Grupo.Value) / Get_Conta) e o
895:         *-- legado o reavalia a cada chegada de foco: esvaziar o codigo tem de
896:         *-- REABRIR a descricao. InteractiveChange cobre a digitacao.
897:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "AtualizarEstadoCampos")
898:         BINDEVENT(loc_oPagina.txt_4c_Conta, "InteractiveChange", THIS, "AtualizarEstadoCampos")
899: 
900:         *-- GetNome.Valid do legado: nome obrigatorio e, com a grade de fases
901:         *-- vazia, insere a primeira linha. Ligado em LostFocus pelo mesmo
902:         *-- motivo dos lookups.
903:         BINDEVENT(loc_oPagina.txt_4c_Nome, "LostFocus", THIS, "ValidarNomeLostFocus")
904: 
905:         *-- Ordem de tabulacao do legado, numerada de uma vez com a pagina
906:         *-- ja montada (ver AjustarOrdemTabulacao).
907:         THIS.AjustarOrdemTabulacao(loc_oPagina)
908: 
909:         THIS.TornarControlesVisiveis(loc_oPagina)
910: 
911:         *-- Cursor de detalhe + vinculo da grade DEPOIS do TornarControlesVisiveis:
912:         *-- Column.ControlSource exige o cursor ABERTO, senao o Init estoura
913:         *-- "Alias not found" e a tela nao abre (regra #41).
914:         THIS.CriarCursorFases()
915:         THIS.VincularGradeFases()
916: 
917:         *-- Estado inicial dos campos conforme os "When" do legado.
918:         THIS.AtualizarEstadoCampos()
919:     ENDPROC
920: 
921:     *===========================================================================
922:     * ConfigurarLabelsCabecalho - Cria lbl_4c_Sombra/lbl_4c_Titulo na faixa
923:     * Fonte unica para as duas paginas (regra #11: os labels NUNCA ficam
924:     * pelados, e o Caption vem do Caption do form). O ForeColor branco e
925:     * legitimo aqui porque o container e OPACO e escuro (excecao da regra #12).
926:     *===========================================================================
927:     PROTECTED PROCEDURE ConfigurarLabelsCabecalho(par_oCabecalho)
928:         par_oCabecalho.AddObject("lbl_4c_Sombra", "Label")
929:         WITH par_oCabecalho.lbl_4c_Sombra
930:             .Caption   = THIS.Caption
931:             .Top       = 15
932:             .Left      = 10
933:             .Width     = 769
934:             .Height    = 40
935:             .FontName  = "Tahoma"
936:             .FontSize  = 16
937:             .FontBold  = .T.
938:             .ForeColor = RGB(0, 0, 0)
939:             .BackStyle = 0
940:             .AutoSize  = .F.
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         par_oCabecalho.AddObject("lbl_4c_Titulo", "Label")
945:         WITH par_oCabecalho.lbl_4c_Titulo
946:             .Caption   = THIS.Caption
947:             .Top       = 18
948:             .Left      = 10
949:             .Width     = 769
950:             .Height    = 46
951:             .FontName  = "Tahoma"
952:             .FontSize  = 16
953:             .FontBold  = .T.
954:             .ForeColor = RGB(255, 255, 255)
955:             .BackStyle = 0
956:             .AutoSize  = .F.
957:             .Visible   = .T.
958:         ENDWITH
959:     ENDPROC
960: 
961:     *===========================================================================
962:     * AjustarOrdemTabulacao - Define a ordem de tabulacao da pagina Dados
963:     *
964:     * TabIndex NAO pode ser atribuido junto com o AddObject de cada controle.
965:     * Medido no VFP9 nesta tela: atribuir TabIndex REPOSICIONA o controle na
966:     * lista do container e EMPURRA os de indice >= N, entao o valor gravado
967:     * antes do proximo AddObject e desfeito pelo controle seguinte - o

*-- Linhas 983 a 1122:
983:     * Os PEMSTATUS permanecem por seguranca: o metodo numera o que ja existe,
984:     * na ordem do legado, sem presumir que todo controle esteja criado.
985:     *===========================================================================
986:     PROTECTED PROCEDURE AjustarOrdemTabulacao(par_oPagina)
987:         LOCAL ARRAY loc_aOrdem[12]
988:         LOCAL loc_nI, loc_nSlot
989: 
990:         IF VARTYPE(par_oPagina) != "O"
991:             RETURN
992:         ENDIF
993: 
994:         loc_aOrdem[1]  = "cnt_4c_Salva"
995:         loc_aOrdem[2]  = "lbl_4c_Nome"
996:         loc_aOrdem[3]  = "lbl_4c_Grupo"
997:         loc_aOrdem[4]  = "txt_4c_Nome"
998:         loc_aOrdem[5]  = "txt_4c_Grupo"
999:         loc_aOrdem[6]  = "txt_4c_DGrupo"
1000:         loc_aOrdem[7]  = "txt_4c_Conta"
1001:         loc_aOrdem[8]  = "txt_4c_DConta"
1002:         loc_aOrdem[9]  = "lbl_4c_Conta"
1003:         loc_aOrdem[10] = "grd_4c_Fases"
1004:         loc_aOrdem[11] = "cmd_4c_InserirFase"
1005:         loc_aOrdem[12] = "cmd_4c_ExcluirFase"
1006: 
1007:         loc_nSlot = 0
1008: 
1009:         FOR loc_nI = 1 TO ALEN(loc_aOrdem)
1010:             IF PEMSTATUS(par_oPagina, loc_aOrdem[loc_nI], 5)
1011:                 loc_nSlot = loc_nSlot + 1
1012:                 *-- Membro alcancado por NOME: STORE ... TO (expressao).
1013:                 *-- Controls(<nome>) e array por NUMERO e estouraria aqui
1014:                 *-- (regra #34); EVALUATE nao atribui (regra #15).
1015:                 STORE loc_nSlot TO ("par_oPagina." + loc_aOrdem[loc_nI] + ".TabIndex")
1016:             ENDIF
1017:         ENDFOR
1018:     ENDPROC
1019: 
1020:     *===========================================================================
1021:     * TornarControlesVisiveis - Torna os controles visiveis recursivamente
1022:     * AddObject cria com Visible=.F.; chamar SEMPRE com o container por parametro
1023:     *===========================================================================
1024:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1025:         LOCAL loc_nI, loc_nP, loc_oObjeto
1026: 
1027:         IF VARTYPE(par_oContainer) != "O"
1028:             RETURN
1029:         ENDIF
1030: 
1031:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1032:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1033: 
1034:             IF VARTYPE(loc_oObjeto) = "O"
1035:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1036:                     loc_oObjeto.Visible = .T.
1037:                 ENDIF
1038: 
1039:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1040:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1041:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1042:                     ENDFOR
1043:                 ENDIF
1044: 
1045:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1046:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1047:                 ENDIF
1048:             ENDIF
1049:         ENDFOR
1050:     ENDPROC
1051: 
1052:     *===========================================================================
1053:     * FormatarGridLista - Formatacao visual da grade da Lista
1054:     * Legado: Pagina.Lista.Grade FontName="Tahoma", FontSize=8, RowHeight=16,
1055:     * ForeColor=90,90,90, GridLineColor=238,238,238.
1056:     *===========================================================================
1057:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1058:         IF VARTYPE(par_oGrid) != "O"
1059:             RETURN
1060:         ENDIF
1061: 
1062:         WITH par_oGrid
1063:             .FontName      = "Tahoma"
1064:             .FontSize      = 8
1065:             .RowHeight     = 16
1066:             .ForeColor     = RGB(90, 90, 90)
1067:             .GridLineColor = RGB(238, 238, 238)
1068:             .FontName = "Tahoma"
1069:             .FontSize = 8
1070:         ENDWITH
1071:     ENDPROC
1072: 
1073:     *===========================================================================
1074:     * CarregarLista - Alimenta a grade da pagina Lista
1075:     * Legado (Init): AddCursor('SigPrDmo', 'cIdChaves', 'crSigPrDmo', '',
1076:     *   ThisForm.Pagina.Lista.Grade, [Select * From SigPrDmo ]) seguido de
1077:     *   pfSqlTabela(1).pColuna('Nome','','','Nome do Demonstrativo',150,.t.)
1078:     * Ou seja: UMA coluna na grade da Lista (regra #35 - a grade espelha o
1079:     * pColuna do Init, nao os headers desenhados no SCX) e consulta SEM filtro.
1080:     * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
1081:     *===========================================================================
1082:     PROCEDURE CarregarLista()
1083:         LOCAL loc_lResultado, loc_oGrid
1084:         loc_lResultado = .F.
1085: 
1086:         TRY
1087:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1088: 
1089:             IF !THIS.this_oBusinessObject.Buscar("")
1090:                 loc_lResultado = .F.
1091:             ELSE
1092:                 *-- Ordem obrigatoria (regra #41 / Problemas 32 e 48):
1093:                 *-- ColumnCount -> RecordSource -> ControlSource ->
1094:                 *-- Header1.Caption -> FormatarGridLista -> Width.
1095:                 *-- RecordSource faz auto-bind e RESETA largura e caption.
1096:                 loc_oGrid.ColumnCount  = 1
1097:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1098: 
1099:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.nome"
1100:                 loc_oGrid.Column1.Header1.Caption = "Nome do Demonstrativo"
1101: 
1102:                 *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18): o do
1103:                 *-- grid propaga para as colunas e sobrescreveria este.
1104:                 loc_oGrid.Column1.ReadOnly = .T.
1105: 
1106:                 THIS.FormatarGridLista(loc_oGrid)
1107: 
1108:                 *-- Column.Width por ULTIMO (regra #35): mexer em RecordSource,
1109:                 *-- em ControlSource ou na FONTE do grid faz o VFP recalcular a
1110:                 *-- largura das colunas. Medido nesta tela: com o Width antes do
1111:                 *-- FormatarGridLista a coluna abria com 45 em vez de 150.
1112:                 loc_oGrid.Column1.Width = 150
1113: 
1114:                 *-- Popular o cursor NAO repinta a grade (regra #21).
1115:                 *-- Legado: "Go Top In <cursor>" + "<grid>.Refresh".
1116:                 IF USED("cursor_4c_Dados")
1117:                     GO TOP IN cursor_4c_Dados
1118:                 ENDIF
1119:                 loc_oGrid.Refresh()
1120: 
1121:                 loc_lResultado = .T.
1122:             ENDIF

*-- Linhas 1141 a 1223:
1141:     * usuario grava, volta para a Lista e encontra os 5 botoes cinza.
1142:     * PUBLIC: chamado de fora pelos handlers e pelo harness de teste.
1143:     *===========================================================================
1144:     PROCEDURE AlternarPagina(par_nPagina)
1145:         LOCAL loc_lResultado
1146:         loc_lResultado = .F.
1147: 
1148:         TRY
1149:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1150:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
1151:                     TRANSFORM(par_nPagina))
1152:             ELSE
1153:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1154: 
1155:                 IF par_nPagina = 1
1156:                     THIS.this_cModoAtual = "LISTA"
1157:                     THIS.CarregarLista()
1158:                 ENDIF
1159: 
1160:                 THIS.AjustarBotoesPorModo()
1161:                 loc_lResultado = .T.
1162:             ENDIF
1163: 
1164:         CATCH TO loException
1165:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
1166:                 loException.Message, "FormSigOpDmp.AlternarPagina")
1167:             loc_lResultado = .F.
1168:         ENDTRY
1169: 
1170:         RETURN loc_lResultado
1171:     ENDPROC
1172: 
1173:     *===========================================================================
1174:     * AjustarBotoesPorModo - Habilita/desabilita os botoes conforme o modo
1175:     * Legado: o When de cada botao do Grupo_op/Grupo_Salva do frmcadastro -
1176:     * os 5 do CRUD valem so na Lista; na pagina Dados valem Confirmar (quando
1177:     * ha o que gravar ou excluir) e Cancelar (sempre, e a saida da ficha).
1178:     * Os PEMSTATUS permanecem por seguranca: o metodo e chamado tambem pelo
1179:     * InicializarForm e pelo harness de teste, e nao pode presumir que toda a
1180:     * pagina Dados esteja montada.
1181:     * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
1182:     *===========================================================================
1183:     PROCEDURE AjustarBotoesPorModo()
1184:         LOCAL loc_oPg1, loc_oPg2, loc_lNaLista, loc_lEditando
1185: 
1186:         TRY
1187:             loc_lNaLista  = (THIS.this_cModoAtual == "LISTA")
1188:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "PROCURAR")
1189: 
1190:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1191: 
1192:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1193:                 WITH loc_oPg1.cnt_4c_Botoes
1194:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1195:                         .cmd_4c_Incluir.Enabled = loc_lNaLista
1196:                     ENDIF
1197:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1198:                         .cmd_4c_Visualizar.Enabled = loc_lNaLista
1199:                     ENDIF
1200:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1201:                         .cmd_4c_Alterar.Enabled = loc_lNaLista
1202:                     ENDIF
1203:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1204:                         .cmd_4c_Excluir.Enabled = loc_lNaLista
1205:                     ENDIF
1206:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1207:                         .cmd_4c_Buscar.Enabled = loc_lNaLista
1208:                     ENDIF
1209:                 ENDWITH
1210:             ENDIF
1211: 
1212:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1213: 
1214:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1215:                 WITH loc_oPg2.cnt_4c_Salva
1216:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1217:                         .cmd_4c_Confirmar.Enabled = loc_lEditando OR ;
1218:                             (THIS.this_cModoAtual == "EXCLUIR")
1219:                     ENDIF
1220:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1221:                         .cmd_4c_Cancelar.Enabled = .T.
1222:                     ENDIF
1223:                 ENDWITH

*-- Linhas 1264 a 1307:
1264:     * ZOrderSet = 15 do dump NAO e transcrito: e propriedade so do Form
1265:     * Designer e atribui-la em runtime derruba o Init (regra #33).
1266:     *===========================================================================
1267:     PROTECTED PROCEDURE ConfigurarGradeFases(par_oPagina)
1268:         LOCAL loc_oGrid
1269: 
1270:         par_oPagina.AddObject("grd_4c_Fases", "Grid")
1271:         loc_oGrid = par_oPagina.grd_4c_Fases
1272: 
1273:         *-- ColumnCount FORA de bloco WITH e antes de qualquer acesso a
1274:         *-- Column1..N: dentro do WITH as colunas podem nao existir ainda e a
1275:         *-- linha seguinte estoura "Unknown member COLUMN1" (Problema 36).
1276:         loc_oGrid.ColumnCount = 5
1277: 
1278:         WITH loc_oGrid
1279:             .Top               = 254
1280:             .Left              = 108
1281:             .Width             = 492
1282:             .Height            = 260
1283:             .FontName          = "Tahoma"
1284:             .FontSize          = 8
1285:             .RowHeight         = 20
1286:             .ScrollBars        = 2
1287:             .Panel             = 1
1288:             .DeleteMark        = .F.
1289:             .AllowHeaderSizing = .F.
1290:             .AllowRowSizing    = .F.
1291:             .GridLineColor     = RGB(238, 238, 238)
1292:             .ReadOnly          = .F.
1293:             .Visible           = .T.
1294:         ENDWITH
1295: 
1296:         *-- Propriedades que NAO dependem do cursor. O ControlSource, os
1297:         *-- Header1.Caption e a Width ficam no VincularGradeFases: ligar
1298:         *-- Column.ControlSource a um cursor que ainda nao existe estoura
1299:         *-- "Alias not found" DENTRO do Init e a tela nao abre (regra #41).
1300:         *-- Column.ReadOnly vem DEPOIS de Grid.ReadOnly, que propaga para as
1301:         *-- colunas e sobrescreveria este (regra #18).
1302:         loc_oGrid.Column1.Movable   = .F.
1303:         loc_oGrid.Column1.Resizable = .F.
1304:         loc_oGrid.Column1.ReadOnly  = .F.
1305:         loc_oGrid.Column1.FontName  = "Tahoma"
1306:         loc_oGrid.Column1.FontSize  = 8
1307:         loc_oGrid.Column1.InputMask = "999"

*-- Linhas 1364 a 1414:
1364:     * aparece na linha ativa (regra #18).
1365:     *
1366:     * As celulas sao TextBoxCelulaDmp_4c (classes\TextBoxGridLookup.prg) com
1367:     * When/Valid/KeyPress/DblClick EMBUTIDOS: BINDEVENT em evento de
1368:     * Column.Text1 nao dispara de forma confiavel e AfterRowColChange entrega
1369:     * a coluna de DESTINO, nao a de origem - o lookup nunca abriria (regra #46).
1370:     *
1371:     * Idempotente (PEMSTATUS): o metodo e chamado tambem pelo
1372:     * VincularGradeFases, que pode ter mexido em ColumnCount/RecordSource.
1373:     *===========================================================================
1374:     PROTECTED PROCEDURE InstalarCelulasGradeFases(par_oGrid)
1375:         LOCAL ARRAY loc_aCel[5, 2]
1376:         LOCAL loc_nI, loc_oCol, loc_oCel, loc_lNova
1377: 
1378:         IF VARTYPE(par_oGrid) != "O"
1379:             RETURN
1380:         ENDIF
1381: 
1382:         *-- this_cCelula + MaxLength pela largura da COLUNA no schema, NUNCA
1383:         *-- pelo Width em pixels (regra #19): SigCdDpr.ordems numeric(4,0),
1384:         *-- grupos/contas char(10), tpops char(15), operas char(1).
1385:         loc_aCel[1, 1] = "ORDEM"
1386:         loc_aCel[1, 2] = 3
1387:         loc_aCel[2, 1] = "FASE"
1388:         loc_aCel[2, 2] = 10
1389:         loc_aCel[3, 1] = "FUNCIONARIO"
1390:         loc_aCel[3, 2] = 10
1391:         loc_aCel[4, 1] = "TPOP"
1392:         loc_aCel[4, 2] = 15
1393:         loc_aCel[5, 1] = "ES"
1394:         loc_aCel[5, 2] = 1
1395: 
1396:         FOR loc_nI = 1 TO 5
1397:             *-- Columns e array indexado por NUMERO - este e o uso CORRETO
1398:             *-- (regra #34: o que estoura e passar o NOME da coluna).
1399:             loc_oCol = par_oGrid.Columns(loc_nI)
1400: 
1401:             loc_lNova = !PEMSTATUS(loc_oCol, "txt_4c_Cel", 5)
1402:             IF loc_lNova
1403:                 loc_oCol.AddObject("txt_4c_Cel", "TextBoxCelulaDmp_4c")
1404:             ENDIF
1405: 
1406:             loc_oCel = loc_oCol.txt_4c_Cel
1407: 
1408:             loc_oCel.this_cCelula = loc_aCel[loc_nI, 1]
1409:             loc_oCel.MaxLength    = loc_aCel[loc_nI, 2]
1410:             loc_oCel.Visible      = .T.
1411: 
1412:             IF loc_nI = 1
1413:                 *-- Coluna Ordem: numerica, alinhada a direita e com o
1414:                 *-- InputMask "999" do dump. O .Value inicial SO na criacao -

*-- Linhas 1456 a 1544:
1456:     * NOT NULL, logo nenhum NULL volta do SQL Server, e num cursor
1457:     * null-capable o APPEND BLANK do InserirLinhaFase gravaria .NULL. nas
1458:     * colunas que o legado nao sobrescreve.
1459:     *===========================================================================
1460:     PROTECTED PROCEDURE CriarCursorFases()
1461:         IF USED("cursor_4c_Fases")
1462:             *-- USE IN fecha o alias mesmo com buffer sujo; TABLEREVERT sem
1463:             *-- antes conferir o Buffering dispara o erro 1586 (regra #52).
1464:             IF CURSORGETPROP("Buffering", "cursor_4c_Fases") > 1
1465:                 TABLEREVERT(.T., "cursor_4c_Fases")
1466:             ENDIF
1467:             USE IN cursor_4c_Fases
1468:         ENDIF
1469: 
1470:         CREATE CURSOR cursor_4c_Fases ( ;
1471:             contas    C(10), ;
1472:             grupos    C(10), ;
1473:             nome      C(20), ;
1474:             operas    C(1),  ;
1475:             ordems    N(4),  ;
1476:             tpops     C(15), ;
1477:             cidchaves C(20), ;
1478:             dopes     C(20))
1479:     ENDPROC
1480: 
1481:     *===========================================================================
1482:     * VincularGradeFases - Liga a grade de fases ao cursor_4c_Fases
1483:     *
1484:     * Ordem OBRIGATORIA (regra #41 / Problemas 32, 36 e 48):
1485:     *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption ->
1486:     *   celulas (CurrentControl) -> Width (por ULTIMO).
1487:     * RecordSource faz auto-bind pela ordem dos campos do cursor e RESETA
1488:     * ControlSource, Header1.Caption e a largura das colunas para o default 90.
1489:     *
1490:     * ColumnCount so e tocado se divergir de 5: reatribui-lo DESTROI os
1491:     * objetos postos por Column.AddObject (as celulas).
1492:     *
1493:     * PUBLIC: chamado de fora pelos handlers de recarga da grade (Fases 7-8) e
1494:     * pelo harness de teste.
1495:     *===========================================================================
1496:     PROCEDURE VincularGradeFases()
1497:         LOCAL loc_lResultado, loc_oGrid
1498:         loc_lResultado = .F.
1499: 
1500:         TRY
1501:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1502: 
1503:             IF !USED("cursor_4c_Fases")
1504:                 MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
1505:                     "FormSigOpDmp")
1506:             ELSE
1507:                 IF loc_oGrid.ColumnCount != 5
1508:                     loc_oGrid.ColumnCount = 5
1509:                 ENDIF
1510: 
1511:                 loc_oGrid.RecordSource = "cursor_4c_Fases"
1512: 
1513:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Fases.ordems"
1514:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Fases.grupos"
1515:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Fases.contas"
1516:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Fases.tpops"
1517:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Fases.operas"
1518: 
1519:                 loc_oGrid.Column1.Header1.Caption = "Ordem"
1520:                 loc_oGrid.Column2.Header1.Caption = "Fase"
1521:                 loc_oGrid.Column3.Header1.Caption = "Funcion" + CHR(225) + "rio"
1522:                 loc_oGrid.Column4.Header1.Caption = "Tipo Opera" + CHR(231) + ;
1523:                     CHR(227) + "o"
1524:                 loc_oGrid.Column5.Header1.Caption = "E/S"
1525: 
1526:                 *-- Grid.ReadOnly ANTES de Column.ReadOnly: o do grid propaga
1527:                 *-- para as colunas (regra #18). O legado faz exatamente isto
1528:                 *-- no Grupo_op.Click (columnN.ReadOnly = .F.); quem bloqueia a
1529:                 *-- edicao fora dos modos INSERIR/ALTERAR e o "When" da celula.
1530:                 loc_oGrid.ReadOnly         = .F.
1531:                 loc_oGrid.Column1.ReadOnly = .F.
1532:                 loc_oGrid.Column2.ReadOnly = .F.
1533:                 loc_oGrid.Column3.ReadOnly = .F.
1534:                 loc_oGrid.Column4.ReadOnly = .F.
1535:                 loc_oGrid.Column5.ReadOnly = .F.
1536: 
1537:                 *-- Reafirma CurrentControl/Sparse: RecordSource pode ter
1538:                 *-- desfeito o vinculo da celula com a coluna.
1539:                 THIS.InstalarCelulasGradeFases(loc_oGrid)
1540: 
1541:                 *-- Larguras por ULTIMO, na ordem visual do ColumnOrder do dump
1542:                 loc_oGrid.Column1.Width = 40
1543:                 loc_oGrid.Column2.Width = 75
1544:                 loc_oGrid.Column3.Width = 75

*-- Linhas 1571 a 1670:
1571:     * visualmente vazia com o cursor cheio.
1572:     *
1573:     * PUBLIC: chamado de fora pelos handlers e pelas Fases 7-8.
1574:     *===========================================================================
1575:     PROCEDURE RepintarGradeFases()
1576:         IF USED("cursor_4c_Fases")
1577:             GO TOP IN cursor_4c_Fases
1578:         ENDIF
1579: 
1580:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Fases", 5)
1581:             THIS.pgf_4c_Paginas.Page2.grd_4c_Fases.Refresh()
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     *===========================================================================
1586:     * ContarLinhasFases - COUNT de linhas vivas do cursor de fases
1587:     *
1588:     * Legado: "Select crSigCdDpr / Count to lnLinhas" - COUNT respeita
1589:     * SET DELETED ON (as linhas excluidas pelo botao Excluir NAO entram),
1590:     * diferente de RECCOUNT(). O preco e que COUNT percorre o cursor e MOVE o
1591:     * ponteiro: o RECNO e o alias correntes sao salvos e repostos, senao a
1592:     * linha selecionada na grade salta sozinha.
1593:     *===========================================================================
1594:     PROTECTED PROCEDURE ContarLinhasFases()
1595:         LOCAL loc_nLinhas, loc_nAliasAnt, loc_nRegAnt
1596: 
1597:         loc_nLinhas = 0
1598: 
1599:         IF USED("cursor_4c_Fases")
1600:             loc_nAliasAnt = SELECT(0)
1601:             SELECT cursor_4c_Fases
1602:             loc_nRegAnt = RECNO("cursor_4c_Fases")
1603: 
1604:             COUNT TO loc_nLinhas
1605: 
1606:             IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1607:                 GO loc_nRegAnt IN cursor_4c_Fases
1608:             ENDIF
1609:             SELECT (loc_nAliasAnt)
1610:         ENDIF
1611: 
1612:         RETURN loc_nLinhas
1613:     ENDPROC
1614: 
1615:     *===========================================================================
1616:     * NomeEditavel - Reproduz o "When" de GetNome do legado
1617:     *
1618:     *   Case pcEscolha = 'PROCURAR'  -> .T.
1619:     *   Case pcEscolha <> 'INSERIR'  -> .F.
1620:     *   Case pcEscolha = 'INSERIR'   -> .T. so se a grade de fases estiver
1621:     *        vazia, ou tiver UMA unica linha com Grupos E Contas vazios
1622:     *        (ou seja, a linha em branco que o proprio form acabou de inserir)
1623:     *   Other                        -> .F.
1624:     *
1625:     * Ou seja: depois que o usuario comeca a preencher as fases, o Nome deixa
1626:     * de ser editavel - ele e a chave que amarra as linhas de SigCdDpr.
1627:     *===========================================================================
1628:     PROTECTED PROCEDURE NomeEditavel()
1629:         LOCAL loc_lEditavel, loc_nLinhas, loc_nAliasAnt, loc_nRegAnt
1630:         LOCAL loc_lPrimeiraVazia
1631: 
1632:         loc_lEditavel = .F.
1633: 
1634:         DO CASE
1635:             CASE THIS.this_cModoAtual == "PROCURAR"
1636:                 loc_lEditavel = .T.
1637: 
1638:             CASE THIS.this_cModoAtual != "INCLUIR"
1639:                 loc_lEditavel = .F.
1640: 
1641:             OTHERWISE
1642:                 loc_nLinhas       = THIS.ContarLinhasFases()
1643:                 loc_lPrimeiraVazia = .F.
1644: 
1645:                 IF loc_nLinhas = 1 AND USED("cursor_4c_Fases")
1646:                     loc_nAliasAnt = SELECT(0)
1647:                     SELECT cursor_4c_Fases
1648:                     loc_nRegAnt = RECNO("cursor_4c_Fases")
1649: 
1650:                     GO TOP IN cursor_4c_Fases
1651:                     loc_lPrimeiraVazia = EMPTY(cursor_4c_Fases.grupos) AND ;
1652:                         EMPTY(cursor_4c_Fases.contas)
1653: 
1654:                     IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
1655:                         GO loc_nRegAnt IN cursor_4c_Fases
1656:                     ENDIF
1657:                     SELECT (loc_nAliasAnt)
1658:                 ENDIF
1659: 
1660:                 loc_lEditavel = (loc_nLinhas = 0) OR loc_lPrimeiraVazia
1661:         ENDCASE
1662: 
1663:         RETURN loc_lEditavel
1664:     ENDPROC
1665: 
1666:     *===========================================================================
1667:     * AtualizarEstadoCampos - Reavalia os "When" dos campos da pagina Dados
1668:     *
1669:     * FONTE UNICA das regras de habilitacao do legado:
1670:     *   GetNome.When    -> ver NomeEditavel

*-- Linhas 1676 a 1732:
1676:     * Os campos de DESCRICAO nao sao rotulo: sao a SEGUNDA porta de entrada
1677:     * (buscar o grupo/a conta pelo nome) e por isso NAO podem nascer com
1678:     * ReadOnly fixo - quem decide e este metodo, chamado no fim do
1679:     * ConfigurarPaginaDados, nos lookups e por BINDEVENT InteractiveChange dos
1680:     * campos de CODIGO, porque esvaziar o codigo tem de REABRIR a descricao.
1681:     *
1682:     * ReadOnly (e nao Enabled) de proposito: o "When" do legado so impede o
1683:     * foco, nao pinta o campo de cinza - Enabled = .F. aplicaria o
1684:     * DisabledBackColor 192,192,192 e mudaria a tela (PILAR 1).
1685:     *
1686:     * Os botoes Inserir/Excluir de LINHA ficam de fora: sao icone-only
1687:     * (Caption = "") e Enabled = .F. em runtime faz o VFP desenhar um
1688:     * retangulo VAZIO, sem icone. O "When" deles vive no proprio handler.
1689:     *
1690:     * PUBLIC: e alvo de BINDEVENT (regra #3) e do harness de teste.
1691:     *===========================================================================
1692:     PROCEDURE AtualizarEstadoCampos()
1693:         LOCAL loc_oPg2, loc_lEditando, loc_cGrupo, loc_cConta
1694: 
1695:         TRY
1696:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1697: 
1698:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1699: 
1700:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
1701:                 loc_oPg2.txt_4c_Nome.ReadOnly = !THIS.NomeEditavel()
1702:             ENDIF
1703: 
1704:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1705:                 loc_oPg2.txt_4c_Grupo.ReadOnly = !loc_lEditando
1706:             ENDIF
1707: 
1708:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1709:                 loc_oPg2.txt_4c_Conta.ReadOnly = !loc_lEditando
1710:             ENDIF
1711: 
1712:             IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5) AND ;
1713:                PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
1714:                 loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1715:                 loc_oPg2.txt_4c_DGrupo.ReadOnly = ;
1716:                     !(EMPTY(loc_cGrupo) AND loc_lEditando)
1717:             ENDIF
1718: 
1719:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5) AND ;
1720:                PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1721:                 loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1722:                 loc_oPg2.txt_4c_DConta.ReadOnly = ;
1723:                     !(EMPTY(loc_cConta) AND loc_lEditando)
1724:             ENDIF
1725: 
1726:         CATCH TO loException
1727:             MostrarErro("Erro ao atualizar o estado dos campos:" + CHR(13) + ;
1728:                 loException.Message, "FormSigOpDmp.AtualizarEstadoCampos")
1729:         ENDTRY
1730:     ENDPROC
1731: 
1732:     *===========================================================================

*-- Linhas 1744 a 2149:
1744:     * efetivo da gravacao fica no Confirmar (Fase 7), que e onde o legado
1745:     * tambem recusa gravar sem nome.
1746:     *
1747:     * A guarda this_lEmLookup tambem vale aqui: o MsgAviso e MODAL, tira o
1748:     * foco e redisparia este proprio LostFocus.
1749:     *
1750:     * PUBLIC: BINDEVENT exige metodo publico (regra #3). LostFocus nao passa
1751:     * parametro nenhum.
1752:     *===========================================================================
1753:     PROCEDURE ValidarNomeLostFocus()
1754:         LOCAL loc_oPg2, loc_cNome, loc_lEmLookupAnt
1755: 
1756:         IF THIS.this_lEmLookup
1757:             RETURN
1758:         ENDIF
1759: 
1760:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1761:         THIS.this_lEmLookup = .T.
1762: 
1763:         TRY
1764:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1765:             loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)
1766: 
1767:             IF EMPTY(loc_cNome)
1768:                 IF LASTKEY() != 27 AND ;
1769:                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1770:                     MsgAviso("O Nome deve ser informado...", "FormSigOpDmp")
1771:                 ENDIF
1772:             ELSE
1773:                 *-- Com a grade de fases vazia, o legado insere a primeira
1774:                 *-- linha em branco assim que o Nome e confirmado - e ela que
1775:                 *-- carrega o nome como chave de SigCdDpr.
1776:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
1777:                    THIS.ContarLinhasFases() = 0
1778:                     THIS.InserirLinhaFase()
1779:                 ENDIF
1780:             ENDIF
1781: 
1782:             THIS.AtualizarEstadoCampos()
1783: 
1784:         CATCH TO loException
1785:             MostrarErro("Erro ao validar o Nome:" + CHR(13) + ;
1786:                 loException.Message, "FormSigOpDmp.ValidarNomeLostFocus")
1787:         ENDTRY
1788: 
1789:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
1790:         THIS.this_lEmLookup = loc_lEmLookupAnt
1791:     ENDPROC
1792: 
1793:     *===========================================================================
1794:     * InserirLinhaFase - PROCEDURE insirareggrade do legado
1795:     *
1796:     *   Select crSigCdDpr / Append Blank
1797:     *   Replace contas With Space(10), grupos With Space(10),
1798:     *           nome With getNome.Value, operas With Space(1),
1799:     *           ordems With 0, tpops With Space(15),
1800:     *           cIdChaves With fUniqueIds()
1801:     *
1802:     * cidchaves vem de fUniqueIds() e NUNCA de string vazia: com cidchaves em
1803:     * branco a segunda linha colidiria no indice unico de SigCdDpr (regra #22).
1804:     * dopes nao e citada em lugar nenhum do legado, mas e NOT NULL na tabela -
1805:     * o legado a ganhava em branco do "Select *" + "Append Blank" e aqui ela e
1806:     * preenchida explicitamente pelo mesmo motivo.
1807:     *
1808:     * PUBLIC: chamado pelo handler do botao, pelo ValidarNomeLostFocus e pelas
1809:     * Fases 7-8.
1810:     *===========================================================================
1811:     PROCEDURE InserirLinhaFase()
1812:         LOCAL loc_lResultado, loc_nAliasAnt, loc_cNome
1813:         loc_lResultado = .F.
1814: 
1815:         TRY
1816:             IF !USED("cursor_4c_Fases")
1817:                 MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
1818:                     "FormSigOpDmp")
1819:             ELSE
1820:                 loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
1821: 
1822:                 loc_nAliasAnt = SELECT(0)
1823:                 SELECT cursor_4c_Fases
1824:                 APPEND BLANK
1825:                 REPLACE contas    WITH SPACE(10), ;
1826:                         grupos    WITH SPACE(10), ;
1827:                         nome      WITH loc_cNome, ;
1828:                         operas    WITH SPACE(1),  ;
1829:                         ordems    WITH 0,         ;
1830:                         tpops     WITH SPACE(15), ;
1831:                         cidchaves WITH fUniqueIds(), ;
1832:                         dopes     WITH SPACE(20) ;
1833:                         IN cursor_4c_Fases
1834:                 SELECT (loc_nAliasAnt)
1835: 
1836:                 loc_lResultado = .T.
1837:             ENDIF
1838: 
1839:         CATCH TO loException
1840:             MostrarErro("Erro ao inserir a linha de fase:" + CHR(13) + ;
1841:                 loException.Message, "FormSigOpDmp.InserirLinhaFase")
1842:             loc_lResultado = .F.
1843:         ENDTRY
1844: 
1845:         RETURN loc_lResultado
1846:     ENDPROC
1847: 
1848:     *===========================================================================
1849:     * BtnInserirFaseClick - Pagina.Dados.Inserir.Click do legado
1850:     *
1851:     *   ThisForm.InsiraRegGrade()
1852:     *   ThisForm.Pagina.Dados.Grade.Column1.Text1.SetFocus
1853:     *   ThisForm.Pagina.Dados.Grade.Refresh
1854:     *
1855:     * O "When" do botao (Inlist(pcEscolha,'INSERIR','ALTERAR')) vira guarda no
1856:     * inicio do handler: o botao e icone-only e Enabled = .F. em runtime
1857:     * fa-lo-ia virar um retangulo vazio, sem icone.
1858:     *
1859:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
1860:     *===========================================================================
1861:     PROCEDURE BtnInserirFaseClick()
1862:         LOCAL loc_oGrid
1863: 
1864:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1865:             RETURN
1866:         ENDIF
1867: 
1868:         TRY
1869:             IF THIS.InserirLinhaFase()
1870:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1871: 
1872:                 *-- O legado devolve o foco a' celula Ordem da linha corrente.
1873:                 *-- A linha nova e' a ULTIMA, por isso o GO BOTTOM antes -
1874:                 *-- sem ele o RepintarGradeFases levaria o ponteiro para o
1875:                 *-- topo e o usuario digitaria na linha errada.
1876:                 IF USED("cursor_4c_Fases")
1877:                     GO BOTTOM IN cursor_4c_Fases
1878:                 ENDIF
1879:                 loc_oGrid.Refresh()
1880:                 THIS.AtualizarEstadoCampos()
1881:                 loc_oGrid.SetFocus()
1882:             ENDIF
1883: 
1884:         CATCH TO loException
1885:             MostrarErro("Erro ao inserir fase:" + CHR(13) + ;
1886:                 loException.Message, "FormSigOpDmp.BtnInserirFaseClick")
1887:         ENDTRY
1888:     ENDPROC
1889: 
1890:     *===========================================================================
1891:     * BtnExcluirFaseClick - Pagina.Dados.Excluir.Click do legado
1892:     *
1893:     *   If Inlist( pcEscolha, 'INSERIR', 'ALTERAR' )
1894:     *       Select crSigCdDpr / Delete / Skip
1895:     *       If Eof() -> Go Bottom
1896:     *       If Eof() -> InsiraRegGrade()
1897:     *       Grade.Column1.Text1.SetFocus / Grade.Refresh
1898:     *   Endif
1899:     *
1900:     * O segundo "If Eof()" nao e repetido por descuido: com o cursor vazio o
1901:     * GO BOTTOM nao sai do EOF, e e dai que o legado conclui que a grade ficou
1902:     * sem nenhuma linha e repoe a linha em branco.
1903:     *
1904:     * NAO confundir com BtnExcluirClick (CRUD do registro mestre, pagina
1905:     * Lista): este exclui a LINHA da grade de fases.
1906:     *
1907:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
1908:     *===========================================================================
1909:     PROCEDURE BtnExcluirFaseClick()
1910:         LOCAL loc_oGrid, loc_nAliasAnt
1911: 
1912:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         TRY
1917:             IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
1918:                 MsgAviso("Nenhuma fase selecionada.", "FormSigOpDmp")
1919:             ELSE
1920:                 loc_nAliasAnt = SELECT(0)
1921:                 SELECT cursor_4c_Fases
1922:                 DELETE
1923:                 SKIP
1924: 
1925:                 IF EOF("cursor_4c_Fases")
1926:                     GO BOTTOM IN cursor_4c_Fases
1927:                 ENDIF
1928:                 SELECT (loc_nAliasAnt)
1929: 
1930:                 *-- Grade sem nenhuma linha viva: repor a linha em branco.
1931:                 IF THIS.ContarLinhasFases() = 0
1932:                     THIS.InserirLinhaFase()
1933:                 ENDIF
1934: 
1935:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
1936:                 loc_oGrid.Refresh()
1937:                 THIS.AtualizarEstadoCampos()
1938:                 loc_oGrid.SetFocus()
1939:             ENDIF
1940: 
1941:         CATCH TO loException
1942:             MostrarErro("Erro ao excluir fase:" + CHR(13) + ;
1943:                 loException.Message, "FormSigOpDmp.BtnExcluirFaseClick")
1944:         ENDTRY
1945:     ENDPROC
1946: 
1947:     *===========================================================================
1948:     * ConexaoAtiva - Ha conexao SQL utilizavel?
1949:     *
1950:     * Os sete lookups consultam o banco. Com gnConnHandle invalido o SQLEXEC
1951:     * do FormBuscaAuxiliar dispara EXCECAO (nao devolve -1), e sem esta guarda
1952:     * o ValidarUIFidelity e o harness headless - que rodam com
1953:     * gnConnHandle = -1 - encheriam a tela de dialogos de erro.
1954:     *===========================================================================
1955:     PROTECTED PROCEDURE ConexaoAtiva()
1956:         RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
1957:     ENDPROC
1958: 
1959:     *===========================================================================
1960:     * UsuarioCorrente - Usuario logado para os checks de acesso
1961:     *===========================================================================
1962:     PROTECTED PROCEDURE UsuarioCorrente()
1963:         LOCAL loc_cUsuario
1964:         loc_cUsuario = ""
1965: 
1966:         IF TYPE("gc_4c_UsuarioLogado") = "C"
1967:             loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
1968:         ENDIF
1969: 
1970:         RETURN loc_cUsuario
1971:     ENDPROC
1972: 
1973:     *===========================================================================
1974:     * FecharCursorBusca - Fecha um cursor de lookup com o guard de Buffering
1975:     * TABLEREVERT sem conferir o Buffering dispara o erro 1586; USE IN fecha o
1976:     * alias mesmo com buffer sujo (regra #52).
1977:     *===========================================================================
1978:     PROTECTED PROCEDURE FecharCursorBusca(par_cCursor)
1979:         IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
1980:             IF CURSORGETPROP("Buffering", par_cCursor) > 1
1981:                 TABLEREVERT(.T., par_cCursor)
1982:             ENDIF
1983:             USE IN (par_cCursor)
1984:         ENDIF
1985:     ENDPROC
1986: 
1987:     *===========================================================================
1988:     * GravarCelulaFase - Escreve o valor resolvido na linha corrente da grade
1989:     *
1990:     * Dentro de um Valid de celula o valor digitado vive em <TextBox>.Value e
1991:     * o CURSOR so o recebe depois (regra #46). Quando o lookup resolve outro
1992:     * valor, ele tem de ir para os DOIS lugares - para a .Value (senao o texto
1993:     * digitado sobrescreve o cursor na saida da celula) e para o cursor (senao
1994:     * a linha mantem o valor antigo).
1995:     *
1996:     * REPLACE aceita name expression entre parenteses, logo o nome da coluna
1997:     * pode vir por parametro.
1998:     *===========================================================================
1999:     PROTECTED PROCEDURE GravarCelulaFase(par_cCampo, par_uValor)
2000:         LOCAL loc_nAliasAnt
2001: 
2002:         IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
2003:             RETURN
2004:         ENDIF
2005: 
2006:         loc_nAliasAnt = SELECT(0)
2007:         SELECT cursor_4c_Fases
2008:         REPLACE (par_cCampo) WITH par_uValor IN cursor_4c_Fases
2009:         SELECT (loc_nAliasAnt)
2010:     ENDPROC
2011: 
2012:     *===========================================================================
2013:     * GrupoDaLinhaFase - Grupo da linha corrente da grade de fases
2014:     * Legado: crSigCdDpr.Grupos, usado como filtro do lookup de Tipo de
2015:     * Operacao e como 2o argumento do fAcessoContas.
2016:     *===========================================================================
2017:     PROTECTED PROCEDURE GrupoDaLinhaFase()
2018:         LOCAL loc_cGrupo
2019:         loc_cGrupo = ""
2020: 
2021:         IF USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
2022:             loc_cGrupo = ALLTRIM(cursor_4c_Fases.grupos)
2023:         ENDIF
2024: 
2025:         RETURN loc_cGrupo
2026:     ENDPROC
2027: 
2028:     *===========================================================================
2029:     * LOOKUP DO CAMPO GRUPO SD INICIAL (Get_Grupo do legado)
2030:     *
2031:     * Legado (Valid):
2032:     *   If !IsEmpty(This.Value)
2033:     *       If !Seek( This.Value, 'crSigCdGcr', 'BalCodigo')
2034:     *           xBrow = CreateObject('fwBuscaSel','crSigCdGcr','BalCodigo',...)
2035:     *           xBrow.AddColuna('Codigos',...,'Codigo') / ('Descrs',...,'Descricao')
2036:     *           xBrow.Show
2037:     *       EndIf
2038:     *       Get_Grupo.Value  = Iif(LastKey()==27,'', crSigCdGcr.Codigos )
2039:     *       Get_DGrupo.Value = Iif(LastKey()==27,'', crSigCdGcr.Descrs  )
2040:     *   Else
2041:     *       Get_DGrupo.Value = Space(20)
2042:     *   EndIf
2043:     *
2044:     * crSigCdGcr e criado no Init legado com
2045:     *   Select codigos,Descrs From SigCdGcr Where gerbals=1
2046:     * logo o universo do lookup e' SO os grupos com gerbals = 1 - o filtro faz
2047:     * parte da regra e vai para o 9o argumento do FormBuscaAuxiliar, que o
2048:     * aplica na busca exata, na parcial e no fallback show-all.
2049:     *===========================================================================
2050:     PROCEDURE ValidarGrupoLostFocus()
2051:         LOCAL loc_oPg2, loc_cGrupo
2052: 
2053:         *-- Guarda de reentrancia: o picker e MODAL, tira o foco do campo e
2054:         *-- redispara este proprio LostFocus (regra #37). A flag e ligada
2055:         *-- dentro de AbrirLookupGrupo, funil das TRES portas (LostFocus,
2056:         *-- F4/F5 e DblClick).
2057:         IF THIS.this_lEmLookup
2058:             RETURN
2059:         ENDIF
2060: 
2061:         TRY
2062:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2063:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2064: 
2065:             IF EMPTY(loc_cGrupo)
2066:                 *-- ELSE do legado: codigo vazio limpa a descricao
2067:                 loc_oPg2.txt_4c_DGrupo.Value = ""
2068:             ELSE
2069:                 THIS.AbrirLookupGrupo()
2070:             ENDIF
2071: 
2072:             THIS.AtualizarEstadoCampos()
2073: 
2074:         CATCH TO loException
2075:             MsgErro("Erro em FormSigOpDmp.ValidarGrupoLostFocus: " + ;
2076:                 loException.Message, "Erro")
2077:         ENDTRY
2078:     ENDPROC
2079: 
2080:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2081:         *-- Porta EXTRA do mesmo funil. O par_nKeyCode E testado: handler que
2082:         *-- abre picker sem olhar a tecla faz o dialogo subir a CADA
2083:         *-- caractere e o usuario nao consegue digitar o codigo (regra #47).
2084:         IF INLIST(par_nKeyCode, 115, 116)
2085:             THIS.AbrirLookupGrupo()
2086:             THIS.AtualizarEstadoCampos()
2087:         ENDIF
2088:     ENDPROC
2089: 
2090:     PROCEDURE TxtGrupoDblClick()
2091:         THIS.AbrirLookupGrupo()
2092:         THIS.AtualizarEstadoCampos()
2093:     ENDPROC
2094: 
2095:     PROTECTED PROCEDURE AbrirLookupGrupo()
2096:         LOCAL loc_oBusca, loc_cGrupo, loc_oPg2, loc_lMostrou
2097: 
2098:         IF !THIS.ConexaoAtiva()
2099:             RETURN
2100:         ENDIF
2101: 
2102:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2103:         loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2104: 
2105:         THIS.this_lEmLookup = .T.
2106:         TRY
2107:             *-- 1o argumento = HANDLE da conexao (regra #36): passar a tabela
2108:             *-- ali desloca todos os outros e o picker abre VAZIO.
2109:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2110:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cGrupo, ;
2111:                 "Grupos de Estoque", .F., .T., "gerbals = 1")
2112: 
2113:             IF VARTYPE(loc_oBusca) = "O"
2114:                 loc_lMostrou = .F.
2115: 
2116:                 *-- Show SO se o Init nao resolveu sozinho (regra #37): com o
2117:                 *-- codigo JA valido o dialogo abriria por cima da ficha
2118:                 *-- preenchida e o usuario teria de dispensa-lo.
2119:                 IF !loc_oBusca.this_lAchouRegistro
2120:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2121:                     loc_oBusca.mAddColuna("descrs",  "", ;
2122:                         "Descri" + CHR(231) + CHR(227) + "o")
2123:                     loc_oBusca.Show()
2124:                     loc_lMostrou = .T.
2125:                 ENDIF
2126: 
2127:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2128:                     SELECT cursor_4c_BuscaGcr
2129:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2130:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2131:                 ELSE
2132:                     *-- ESC/Cancelar com o picker ABERTO: o legado limpa os
2133:                     *-- dois (Iif(LastKey()==27,'',...)). Sem o picker na tela
2134:                     *-- nada e limpado - apagar o que o usuario digitou o
2135:                     *-- deixaria sem como preencher o campo (regra #50).
2136:                     IF loc_lMostrou
2137:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2138:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2139:                     ENDIF
2140:                 ENDIF
2141: 
2142:                 loc_oBusca.Release()
2143:             ENDIF
2144: 
2145:         CATCH TO loException
2146:             MsgErro("Erro em FormSigOpDmp.AbrirLookupGrupo: " + ;
2147:                 loException.Message, "Erro")
2148:         ENDTRY
2149:         *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara

*-- Linhas 2164 a 2256:
2164:     * e inofensivo, porque o "When" so libera a descricao com o codigo vazio -
2165:     * mas fica transcrito como esta (PILAR 1).
2166:     *===========================================================================
2167:     PROCEDURE ValidarDGrupoLostFocus()
2168:         LOCAL loc_oPg2, loc_cDesc
2169: 
2170:         IF THIS.this_lEmLookup
2171:             RETURN
2172:         ENDIF
2173: 
2174:         TRY
2175:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2176:             loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)
2177: 
2178:             IF EMPTY(loc_cDesc)
2179:                 loc_oPg2.txt_4c_Grupo.Value = ""
2180:             ELSE
2181:                 THIS.AbrirLookupDGrupo()
2182:             ENDIF
2183: 
2184:             THIS.AtualizarEstadoCampos()
2185: 
2186:         CATCH TO loException
2187:             MsgErro("Erro em FormSigOpDmp.ValidarDGrupoLostFocus: " + ;
2188:                 loException.Message, "Erro")
2189:         ENDTRY
2190:     ENDPROC
2191: 
2192:     PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2193:         IF INLIST(par_nKeyCode, 115, 116)
2194:             THIS.AbrirLookupDGrupo()
2195:             THIS.AtualizarEstadoCampos()
2196:         ENDIF
2197:     ENDPROC
2198: 
2199:     PROCEDURE TxtDGrupoDblClick()
2200:         THIS.AbrirLookupDGrupo()
2201:         THIS.AtualizarEstadoCampos()
2202:     ENDPROC
2203: 
2204:     PROTECTED PROCEDURE AbrirLookupDGrupo()
2205:         LOCAL loc_oBusca, loc_cDesc, loc_oPg2, loc_lMostrou
2206: 
2207:         IF !THIS.ConexaoAtiva()
2208:             RETURN
2209:         ENDIF
2210: 
2211:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2212:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)
2213: 
2214:         THIS.this_lEmLookup = .T.
2215:         TRY
2216:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2217:                 "SigCdGcr", "cursor_4c_BuscaGcrD", "descrs", loc_cDesc, ;
2218:                 "Grupos de Estoque", .F., .T., "gerbals = 1")
2219: 
2220:             IF VARTYPE(loc_oBusca) = "O"
2221:                 loc_lMostrou = .F.
2222: 
2223:                 IF !loc_oBusca.this_lAchouRegistro
2224:                     loc_oBusca.mAddColuna("descrs",  "", ;
2225:                         "Descri" + CHR(231) + CHR(227) + "o")
2226:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2227:                     loc_oBusca.Show()
2228:                     loc_lMostrou = .T.
2229:                 ENDIF
2230: 
2231:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
2232:                     SELECT cursor_4c_BuscaGcrD
2233:                     loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcrD.codigos)
2234:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcrD.descrs)
2235:                 ELSE
2236:                     IF loc_lMostrou
2237:                         loc_oPg2.txt_4c_Grupo.Value  = ""
2238:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2239:                     ENDIF
2240:                 ENDIF
2241: 
2242:                 loc_oBusca.Release()
2243:             ENDIF
2244: 
2245:         CATCH TO loException
2246:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDGrupo: " + ;
2247:                 loException.Message, "Erro")
2248:         ENDTRY
2249:         THIS.this_lEmLookup = .F.
2250: 
2251:         THIS.FecharCursorBusca("cursor_4c_BuscaGcrD")
2252:     ENDPROC
2253: 
2254:     *===========================================================================
2255:     * LOOKUP DO CAMPO CONTA SD INICIAL (Get_Conta do legado)
2256:     *

*-- Linhas 2262 a 2587:
2262:     *   Select Grupos, IClis, RClis From SigCdCli Where GerBals = 1
2263:     * logo o universo e' SO as contas com gerbals = 1.
2264:     *===========================================================================
2265:     PROCEDURE ValidarContaLostFocus()
2266:         LOCAL loc_oPg2, loc_cConta
2267: 
2268:         IF THIS.this_lEmLookup
2269:             RETURN
2270:         ENDIF
2271: 
2272:         TRY
2273:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2274:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2275: 
2276:             IF EMPTY(loc_cConta)
2277:                 loc_oPg2.txt_4c_DConta.Value = ""
2278:             ELSE
2279:                 THIS.AbrirLookupConta()
2280:             ENDIF
2281: 
2282:             THIS.AtualizarEstadoCampos()
2283: 
2284:         CATCH TO loException
2285:             MsgErro("Erro em FormSigOpDmp.ValidarContaLostFocus: " + ;
2286:                 loException.Message, "Erro")
2287:         ENDTRY
2288:     ENDPROC
2289: 
2290:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2291:         IF INLIST(par_nKeyCode, 115, 116)
2292:             THIS.AbrirLookupConta()
2293:             THIS.AtualizarEstadoCampos()
2294:         ENDIF
2295:     ENDPROC
2296: 
2297:     PROCEDURE TxtContaDblClick()
2298:         THIS.AbrirLookupConta()
2299:         THIS.AtualizarEstadoCampos()
2300:     ENDPROC
2301: 
2302:     PROTECTED PROCEDURE AbrirLookupConta()
2303:         LOCAL loc_oBusca, loc_cConta, loc_oPg2, loc_lMostrou
2304: 
2305:         IF !THIS.ConexaoAtiva()
2306:             RETURN
2307:         ENDIF
2308: 
2309:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2310:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2311: 
2312:         THIS.this_lEmLookup = .T.
2313:         TRY
2314:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2315:                 "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cConta, ;
2316:                 "Contas", .F., .T., "gerbals = 1")
2317: 
2318:             IF VARTYPE(loc_oBusca) = "O"
2319:                 loc_lMostrou = .F.
2320: 
2321:                 IF !loc_oBusca.this_lAchouRegistro
2322:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
2323:                     loc_oBusca.mAddColuna("rclis", "", ;
2324:                         "Descri" + CHR(231) + CHR(227) + "o")
2325:                     loc_oBusca.Show()
2326:                     loc_lMostrou = .T.
2327:                 ENDIF
2328: 
2329:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2330:                     SELECT cursor_4c_BuscaCli
2331:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2332:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
2333:                 ELSE
2334:                     IF loc_lMostrou
2335:                         loc_oPg2.txt_4c_Conta.Value  = ""
2336:                         loc_oPg2.txt_4c_DConta.Value = ""
2337:                     ENDIF
2338:                 ENDIF
2339: 
2340:                 loc_oBusca.Release()
2341:             ENDIF
2342: 
2343:         CATCH TO loException
2344:             MsgErro("Erro em FormSigOpDmp.AbrirLookupConta: " + ;
2345:                 loException.Message, "Erro")
2346:         ENDTRY
2347:         THIS.this_lEmLookup = .F.
2348: 
2349:         THIS.FecharCursorBusca("cursor_4c_BuscaCli")
2350:     ENDPROC
2351: 
2352:     *===========================================================================
2353:     * LOOKUP DA DESCRICAO DA CONTA (Get_DConta do legado)
2354:     *
2355:     * Busca em SigCdCli pelo NOME (indice BalNome do legado), colunas RClis /
2356:     * IClis nessa ordem. O ELSE do legado limpa a si mesmo (Get_DConta), nao o
2357:     * codigo - assimetrico em relacao ao Get_DGrupo, e transcrito como esta.
2358:     *===========================================================================
2359:     PROCEDURE ValidarDContaLostFocus()
2360:         LOCAL loc_oPg2, loc_cDesc
2361: 
2362:         IF THIS.this_lEmLookup
2363:             RETURN
2364:         ENDIF
2365: 
2366:         TRY
2367:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2368:             loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
2369: 
2370:             IF EMPTY(loc_cDesc)
2371:                 loc_oPg2.txt_4c_DConta.Value = ""
2372:             ELSE
2373:                 THIS.AbrirLookupDConta()
2374:             ENDIF
2375: 
2376:             THIS.AtualizarEstadoCampos()
2377: 
2378:         CATCH TO loException
2379:             MsgErro("Erro em FormSigOpDmp.ValidarDContaLostFocus: " + ;
2380:                 loException.Message, "Erro")
2381:         ENDTRY
2382:     ENDPROC
2383: 
2384:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2385:         IF INLIST(par_nKeyCode, 115, 116)
2386:             THIS.AbrirLookupDConta()
2387:             THIS.AtualizarEstadoCampos()
2388:         ENDIF
2389:     ENDPROC
2390: 
2391:     PROCEDURE TxtDContaDblClick()
2392:         THIS.AbrirLookupDConta()
2393:         THIS.AtualizarEstadoCampos()
2394:     ENDPROC
2395: 
2396:     PROTECTED PROCEDURE AbrirLookupDConta()
2397:         LOCAL loc_oBusca, loc_cDesc, loc_oPg2, loc_lMostrou
2398: 
2399:         IF !THIS.ConexaoAtiva()
2400:             RETURN
2401:         ENDIF
2402: 
2403:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2404:         loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
2405: 
2406:         THIS.this_lEmLookup = .T.
2407:         TRY
2408:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2409:                 "SigCdCli", "cursor_4c_BuscaCliD", "rclis", loc_cDesc, ;
2410:                 "Contas", .F., .T., "gerbals = 1")
2411: 
2412:             IF VARTYPE(loc_oBusca) = "O"
2413:                 loc_lMostrou = .F.
2414: 
2415:                 IF !loc_oBusca.this_lAchouRegistro
2416:                     loc_oBusca.mAddColuna("rclis", "", ;
2417:                         "Descri" + CHR(231) + CHR(227) + "o")
2418:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
2419:                     loc_oBusca.Show()
2420:                     loc_lMostrou = .T.
2421:                 ENDIF
2422: 
2423:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
2424:                     SELECT cursor_4c_BuscaCliD
2425:                     loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliD.iclis)
2426:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
2427:                 ELSE
2428:                     IF loc_lMostrou
2429:                         loc_oPg2.txt_4c_Conta.Value  = ""
2430:                         loc_oPg2.txt_4c_DConta.Value = ""
2431:                     ENDIF
2432:                 ENDIF
2433: 
2434:                 loc_oBusca.Release()
2435:             ENDIF
2436: 
2437:         CATCH TO loException
2438:             MsgErro("Erro em FormSigOpDmp.AbrirLookupDConta: " + ;
2439:                 loException.Message, "Erro")
2440:         ENDTRY
2441:         THIS.this_lEmLookup = .F.
2442: 
2443:         THIS.FecharCursorBusca("cursor_4c_BuscaCliD")
2444:     ENDPROC
2445: 
2446:     *===========================================================================
2447:     * CELULAS DA GRADE DE FASES - "When" comum as cinco
2448:     *
2449:     * Legado (Column1..5.Text1.When, corpo IDENTICO nas cinco):
2450:     *   Return Inlist( ThisForm.pcEscolha, 'INSERIR', 'ALTERAR' )
2451:     *
2452:     * PUBLIC: a classe TextBoxCelulaDmp_4c chama este metodo de FORA
2453:     * (THISFORM.GradeFasesCelulaWhen()), nao por BINDEVENT - PROTECTED
2454:     * estouraria "Property GRADEFASESCELULAWHEN is not found" em runtime,
2455:     * mesmo com o PEMSTATUS da classe devolvendo .T. (regra #3/#51).
2456:     *===========================================================================
2457:     PROCEDURE GradeFasesCelulaWhen()
2458:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2459:     ENDPROC
2460: 
2461:     *===========================================================================
2462:     * GradeFasesOrdemValid - Column1.Text1.Valid do legado (coluna Ordem)
2463:     *
2464:     *   If !Between( This.Value, 0, 999 )
2465:     *       Messagebox( 'Entre com um valor entre 1 e 999...', 32, '' )
2466:     *       This.Value = 0
2467:     *       Return
2468:     *   Endif
2469:     *
2470:     * O limite 0..999 nao e enfeite: SigCdDpr.ordems e numeric(4,0) e o
2471:     * InputMask "999" do dump reflete o mesmo teto.
2472:     *===========================================================================
2473:     PROCEDURE GradeFasesOrdemValid(par_oTxt)
2474:         LOCAL loc_nOrdem
2475: 
2476:         IF VARTYPE(par_oTxt) != "O"
2477:             RETURN .T.
2478:         ENDIF
2479: 
2480:         TRY
2481:             *-- O valor digitado vive na .Value da celula; o cursor so o
2482:             *-- recebe depois (regra #46). VARTYPE antes de comparar: celula
2483:             *-- recem-criada pode trazer character.
2484:             loc_nOrdem = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
2485:                 VAL(TRANSFORM(par_oTxt.Value)))
2486: 
2487:             IF !BETWEEN(loc_nOrdem, 0, 999)
2488:                 MsgAviso("Entre com um valor entre 1 e 999...", "FormSigOpDmp")
2489:                 par_oTxt.Value = 0
2490:                 THIS.GravarCelulaFase("ordems", 0)
2491:             ENDIF
2492: 
2493:         CATCH TO loException
2494:             MsgErro("Erro em FormSigOpDmp.GradeFasesOrdemValid: " + ;
2495:                 loException.Message, "Erro")
2496:         ENDTRY
2497: 
2498:         RETURN .T.
2499:     ENDPROC
2500: 
2501:     *===========================================================================
2502:     * GradeFasesFaseValid - Column2.Text1.Valid do legado (coluna Fase)
2503:     *
2504:     *   If not IsEmpty(This.Value)
2505:     *       If not Seek(Padr(This.Value,10),'crSigCdGcr','BalCodigo')
2506:     *           xBrow = CreateObject('fwBuscaInt','crSigCdGcr','Codigos',...)
2507:     *           ... xBrow.Show
2508:     *           If Lastkey()<>27 -> This.Value = crSigCdGcr.Codigos
2509:     *       EndIf
2510:     *   EndIf
2511:     *
2512:     * Repare que aqui o ESC NAO limpa a celula (diferente das colunas
2513:     * Funcionario e Tipo Operacao): o legado so atribui quando LastKey()<>27.
2514:     *===========================================================================
2515:     PROCEDURE GradeFasesFaseValid(par_oTxt)
2516:         IF VARTYPE(par_oTxt) != "O"
2517:             RETURN .T.
2518:         ENDIF
2519: 
2520:         IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
2521:             THIS.AbrirLookupFaseGrade(par_oTxt)
2522:         ENDIF
2523: 
2524:         RETURN .T.
2525:     ENDPROC
2526: 
2527:     *===========================================================================
2528:     * AbrirLookupFaseGrade - Lookup da coluna Fase (SigCdGcr)
2529:     * Universo: gerbals = 1, o mesmo do crSigCdGcr do Init legado.
2530:     * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
2531:     *===========================================================================
2532:     PROCEDURE AbrirLookupFaseGrade(par_oTxt)
2533:         LOCAL loc_oBusca, loc_cFase, loc_lEmLookupAnt
2534: 
2535:         IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
2536:             RETURN
2537:         ENDIF
2538: 
2539:         loc_cFase = ALLTRIM(TRANSFORM(par_oTxt.Value))
2540: 
2541:         *-- save/restore (nao set/clear): este metodo e chamado tanto do Valid
2542:         *-- quanto do F4/DblClick da propria celula, e um clear interno
2543:         *-- liberaria a flag cedo demais se houver aninhamento (regra #47).
2544:         loc_lEmLookupAnt    = THIS.this_lEmLookup
2545:         THIS.this_lEmLookup = .T.
2546:         TRY
2547:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2548:                 "SigCdGcr", "cursor_4c_BuscaFase", "codigos", loc_cFase, ;
2549:                 "Cadastro de Grupos", .F., .T., "gerbals = 1")
2550: 
2551:             IF VARTYPE(loc_oBusca) = "O"
2552:                 IF !loc_oBusca.this_lAchouRegistro
2553:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2554:                     loc_oBusca.mAddColuna("descrs",  "", ;
2555:                         "Descri" + CHR(231) + CHR(227) + "o")
2556:                     loc_oBusca.Show()
2557:                 ENDIF
2558: 
2559:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
2560:                     SELECT cursor_4c_BuscaFase
2561:                     *-- O codigo escolhido vai para os DOIS lugares: .Value e
2562:                     *-- cursor. Sem a .Value o texto digitado sobrescreveria o
2563:                     *-- cursor na saida da celula (regra #46).
2564:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFase.codigos)
2565:                     THIS.GravarCelulaFase("grupos", ;
2566:                         PADR(ALLTRIM(cursor_4c_BuscaFase.codigos), 10))
2567:                 ENDIF
2568: 
2569:                 loc_oBusca.Release()
2570:             ENDIF
2571: 
2572:         CATCH TO loException
2573:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFaseGrade: " + ;
2574:                 loException.Message, "Erro")
2575:         ENDTRY
2576:         THIS.this_lEmLookup = loc_lEmLookupAnt
2577: 
2578:         THIS.FecharCursorBusca("cursor_4c_BuscaFase")
2579:     ENDPROC
2580: 
2581:     *===========================================================================
2582:     * GradeFasesFuncionarioValid - Column3.Text1.Valid (coluna Funcionario)
2583:     *
2584:     *   If !IsEmpty( This.Value )
2585:     *       If !Seek( This.Value, 'crSigCdCli', 'BalCodigo' ) -> fwBuscaSel
2586:     *           If Lastkey() = 27 -> this.Value = ''
2587:     *           Else              -> this.Value = crSigCdCli.Iclis

*-- Linhas 2598 a 2694:
2598:     * TextBox): ela consulta SigSyAcc/SigSyAgc/SigCdAcG e devolve logico, sem
2599:     * abrir picker nem popular campo nenhum.
2600:     *===========================================================================
2601:     PROCEDURE GradeFasesFuncionarioValid(par_oTxt)
2602:         LOCAL loc_cConta, loc_cGrupoLinha, loc_cUsuario
2603: 
2604:         IF VARTYPE(par_oTxt) != "O"
2605:             RETURN .T.
2606:         ENDIF
2607: 
2608:         TRY
2609:             IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
2610:                 THIS.AbrirLookupFuncionarioGrade(par_oTxt)
2611: 
2612:                 loc_cConta = ALLTRIM(TRANSFORM(par_oTxt.Value))
2613: 
2614:                 *-- O check de acesso so faz sentido com conta resolvida e com
2615:                 *-- conexao: fAcessoContas consulta o banco.
2616:                 IF !EMPTY(loc_cConta) AND THIS.ConexaoAtiva()
2617:                     loc_cGrupoLinha = THIS.GrupoDaLinhaFase()
2618:                     loc_cUsuario    = THIS.UsuarioCorrente()
2619: 
2620:                     IF !fAcessoContas(loc_cUsuario, loc_cGrupoLinha, "C", loc_cConta)
2621:                         MsgAviso("Acesso Negado...", "FormSigOpDmp")
2622:                         par_oTxt.Value = ""
2623:                         THIS.GravarCelulaFase("contas", SPACE(10))
2624:                     ENDIF
2625:                 ENDIF
2626:             ENDIF
2627: 
2628:         CATCH TO loException
2629:             MsgErro("Erro em FormSigOpDmp.GradeFasesFuncionarioValid: " + ;
2630:                 loException.Message, "Erro")
2631:         ENDTRY
2632: 
2633:         RETURN .T.
2634:     ENDPROC
2635: 
2636:     *===========================================================================
2637:     * AbrirLookupFuncionarioGrade - Lookup da coluna Funcionario (SigCdCli)
2638:     * Universo: gerbals = 1, o mesmo do crSigCdCli do Init legado.
2639:     * Aqui o ESC LIMPA a celula (this.Value = ''), como o legado.
2640:     * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
2641:     *===========================================================================
2642:     PROCEDURE AbrirLookupFuncionarioGrade(par_oTxt)
2643:         LOCAL loc_oBusca, loc_cConta, loc_lEmLookupAnt, loc_lMostrou
2644: 
2645:         IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
2646:             RETURN
2647:         ENDIF
2648: 
2649:         loc_cConta = ALLTRIM(TRANSFORM(par_oTxt.Value))
2650: 
2651:         loc_lEmLookupAnt    = THIS.this_lEmLookup
2652:         THIS.this_lEmLookup = .T.
2653:         TRY
2654:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2655:                 "SigCdCli", "cursor_4c_BuscaFunc", "iclis", loc_cConta, ;
2656:                 "Cadastro de Contas", .F., .T., "gerbals = 1")
2657: 
2658:             IF VARTYPE(loc_oBusca) = "O"
2659:                 loc_lMostrou = .F.
2660: 
2661:                 IF !loc_oBusca.this_lAchouRegistro
2662:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2663:                     loc_oBusca.mAddColuna("rclis",  "", ;
2664:                         "Descri" + CHR(231) + CHR(227) + "o")
2665:                     loc_oBusca.mAddColuna("grupos", "", "Grupo")
2666:                     loc_oBusca.Show()
2667:                     loc_lMostrou = .T.
2668:                 ENDIF
2669: 
2670:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFunc")
2671:                     SELECT cursor_4c_BuscaFunc
2672:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFunc.iclis)
2673:                     THIS.GravarCelulaFase("contas", ;
2674:                         PADR(ALLTRIM(cursor_4c_BuscaFunc.iclis), 10))
2675:                 ELSE
2676:                     IF loc_lMostrou
2677:                         par_oTxt.Value = ""
2678:                         THIS.GravarCelulaFase("contas", SPACE(10))
2679:                     ENDIF
2680:                 ENDIF
2681: 
2682:                 loc_oBusca.Release()
2683:             ENDIF
2684: 
2685:         CATCH TO loException
2686:             MsgErro("Erro em FormSigOpDmp.AbrirLookupFuncionarioGrade: " + ;
2687:                 loException.Message, "Erro")
2688:         ENDTRY
2689:         THIS.this_lEmLookup = loc_lEmLookupAnt
2690: 
2691:         THIS.FecharCursorBusca("cursor_4c_BuscaFunc")
2692:     ENDPROC
2693: 
2694:     *===========================================================================

*-- Linhas 2709 a 2792:
2709:     * operacao serve se for do grupo da LINHA ou se for generico (Grupos
2710:     * vazio). Esse filtro tambem e o que invalida um codigo que existe mas
2711:     * pertence a outro grupo - e por isso ele vai no 9o argumento do
2712:     * FormBuscaAuxiliar, que o aplica TAMBEM na busca exata.
2713:     *===========================================================================
2714:     PROCEDURE GradeFasesTpOpValid(par_oTxt)
2715:         IF VARTYPE(par_oTxt) != "O"
2716:             RETURN .T.
2717:         ENDIF
2718: 
2719:         *-- "If IsEmpty(This.Value) -> Return .t." do legado: tipo de operacao
2720:         *-- em branco e valido e nao abre nada.
2721:         IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
2722:             THIS.AbrirLookupTpOpGrade(par_oTxt)
2723:         ENDIF
2724: 
2725:         RETURN .T.
2726:     ENDPROC
2727: 
2728:     *===========================================================================
2729:     * AbrirLookupTpOpGrade - Lookup da coluna Tipo Operacao (SigOpOpt)
2730:     * Aqui o ESC LIMPA a celula (Iif(Lastkey()==27,'',TmpOpt.Cods)).
2731:     * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
2732:     *===========================================================================
2733:     PROCEDURE AbrirLookupTpOpGrade(par_oTxt)
2734:         LOCAL loc_oBusca, loc_cTpOp, loc_cGrupoLinha, loc_cFiltro
2735:         LOCAL loc_lEmLookupAnt, loc_lMostrou
2736: 
2737:         IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
2738:             RETURN
2739:         ENDIF
2740: 
2741:         loc_cTpOp       = ALLTRIM(TRANSFORM(par_oTxt.Value))
2742:         loc_cGrupoLinha = THIS.GrupoDaLinhaFase()
2743: 
2744:         *-- "Where Grupos = lcGrupo Or IsEmpty( Grupos )" do legado.
2745:         *-- EscaparSQL JA devolve o valor COM as aspas (regra #5).
2746:         loc_cFiltro = "(RTRIM(grupos) = " + EscaparSQL(loc_cGrupoLinha) + ;
2747:             " OR RTRIM(grupos) = '')"
2748: 
2749:         loc_lEmLookupAnt    = THIS.this_lEmLookup
2750:         THIS.this_lEmLookup = .T.
2751:         TRY
2752:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2753:                 "SigOpOpt", "cursor_4c_BuscaTpOp", "cods", loc_cTpOp, ;
2754:                 "Cadastro de Tipos de Opera" + CHR(231) + CHR(227) + "o", ;
2755:                 .F., .T., loc_cFiltro)
2756: 
2757:             IF VARTYPE(loc_oBusca) = "O"
2758:                 loc_lMostrou = .F.
2759: 
2760:                 IF !loc_oBusca.this_lAchouRegistro
2761:                     loc_oBusca.mAddColuna("cods",    "", "C" + CHR(243) + "digo")
2762:                     loc_oBusca.mAddColuna("descs",   "", ;
2763:                         "Descri" + CHR(231) + CHR(227) + "o")
2764:                     loc_oBusca.mAddColuna("pfalhas", "999.99 %", "Falha")
2765:                     loc_oBusca.Show()
2766:                     loc_lMostrou = .T.
2767:                 ENDIF
2768: 
2769:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOp")
2770:                     SELECT cursor_4c_BuscaTpOp
2771:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTpOp.cods)
2772:                     THIS.GravarCelulaFase("tpops", ;
2773:                         PADR(ALLTRIM(cursor_4c_BuscaTpOp.cods), 15))
2774:                 ELSE
2775:                     IF loc_lMostrou
2776:                         par_oTxt.Value = ""
2777:                         THIS.GravarCelulaFase("tpops", SPACE(15))
2778:                     ENDIF
2779:                 ENDIF
2780: 
2781:                 loc_oBusca.Release()
2782:             ENDIF
2783: 
2784:         CATCH TO loException
2785:             MsgErro("Erro em FormSigOpDmp.AbrirLookupTpOpGrade: " + ;
2786:                 loException.Message, "Erro")
2787:         ENDTRY
2788:         THIS.this_lEmLookup = loc_lEmLookupAnt
2789: 
2790:         THIS.FecharCursorBusca("cursor_4c_BuscaTpOp")
2791:     ENDPROC
2792: 

*-- Linhas 2805 a 2859:
2805:     * dispara o aviso de novo na proxima saida. Comportamento do legado,
2806:     * mantido (PILAR 1).
2807:     *===========================================================================
2808:     PROCEDURE GradeFasesEsValid(par_oTxt)
2809:         LOCAL loc_cEs
2810: 
2811:         IF VARTYPE(par_oTxt) != "O"
2812:             RETURN .T.
2813:         ENDIF
2814: 
2815:         TRY
2816:             loc_cEs = UPPER(ALLTRIM(TRANSFORM(par_oTxt.Value)))
2817: 
2818:             IF !INLIST(loc_cEs, "E", "S", "P", "H", "T")
2819:                 MsgAviso("Informe [E]NTRADA / [S]A" + CHR(205) + "DA / " + ;
2820:                     "[P]OSI" + CHR(199) + CHR(195) + "O ATUAL...", ;
2821:                     "FormSigOpDmp")
2822:                 par_oTxt.Value = " "
2823:                 THIS.GravarCelulaFase("operas", " ")
2824:             ELSE
2825:                 *-- Format = "K!" do legado forca maiuscula na digitacao; a
2826:                 *-- normalizacao aqui cobre o valor vindo do cursor/banco.
2827:                 par_oTxt.Value = loc_cEs
2828:                 THIS.GravarCelulaFase("operas", loc_cEs)
2829:             ENDIF
2830: 
2831:         CATCH TO loException
2832:             MsgErro("Erro em FormSigOpDmp.GradeFasesEsValid: " + ;
2833:                 loException.Message, "Erro")
2834:         ENDTRY
2835: 
2836:         RETURN .T.
2837:     ENDPROC
2838: 
2839:     *===========================================================================
2840:     * FASE 7 - EVENTOS PRINCIPAIS (os ramos do Grupo_op.Click do legado)
2841:     *
2842:     * No legado os cinco botoes da barra da Lista sao UM CommandGroup
2843:     * (Pagina.Lista.Grupo_op) e o Do Case do frmcadastro resolve o verbo pelo
2844:     * Value do grupo:
2845:     *
2846:     *   Value | pcEscolha  | o que o frmcadastro faz
2847:     *   ------+------------+------------------------------------------------
2848:     *     1   | INSERIR    | poDataMgr.NewReg(1,.t.)  -> registro em branco
2849:     *     2   | CONSULTAR  | ReQuery(1, PK, <cursor>.PK) -> recarrega o atual
2850:     *     3   | ALTERAR    | ReQuery(1, PK, <cursor>.PK)
2851:     *     4   | EXCLUIR    | ReQuery(1, PK, <cursor>.PK)
2852:     *     5   | PROCURAR   | NewReg(1) (busca por exemplo - Fase 8)
2853:     *
2854:     * e, DEPOIS do Do Case, comum a todos:
2855:     *   mObjEnabled(Pagina.Dados,.t.)
2856:     *   If (Value<>0) And (Not Used(<cursor>) Or Not Eof(<cursor>))
2857:     *       Pagina.Dados.Grupo_Salva.Salva.Enabled = (Not pcEscolha=[CONSULTAR])
2858:     *       Pagina.ActivePage = 2
2859:     *   Else

*-- Linhas 2873 a 3037:
2873:     *   <re-liga as 5 colunas da grade> / Go Top in ('crSigCdDpr') / Refresh
2874:     *
2875:     * Aqui cada botao e um CommandButton com o seu proprio handler PUBLIC
2876:     * (BINDEVENT exige metodo publico - regra #3) e os tres ramos que carregam
2877:     * registro existente compartilham o funil AbrirFichaDoRegistro: o verbo
2878:     * muda so o modo resultante e o foco inicial.
2879:     *
2880:     * A EXCLUSAO NAO ACONTECE AQUI: no legado o Excluir apenas abre a ficha em
2881:     * modo EXCLUIR com os campos travados, e quem pergunta "Deseja Realmente
2882:     * Excluir Esses Dados?" e executa o DELETE e o Salva.Click (frmcadastro:
2883:     * Case pcEscolha=[EXCLUIR] -> MessageBox + mSv_Excluir, mais o ExcluiItens
2884:     * desta tela, que apaga as linhas de SigCdDpr). Esse caminho e o Confirmar,
2885:     * da Fase 8.
2886:     *===========================================================================
2887: 
2888:     *===========================================================================
2889:     * LimparCampos - Deixa a ficha em branco (legado: poDataMgr.NewReg, que
2890:     * cria um registro VAZIO no cursor mestre, e os controles ligados a ele
2891:     * passam a exibir branco).
2892:     * Os campos desta tela nao tem ControlSource: quem os esvazia e este
2893:     * metodo. Os PEMSTATUS existem porque ele pode ser chamado antes de a
2894:     * pagina Dados estar inteiramente montada.
2895:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
2896:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
2897:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
2898:     * o modificador nao torna o metodo publico, so esconde do leitor que ele
2899:     * continua protegido. Chamar sempre por THIS. de dentro da classe; de
2900:     * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
2901:     * "da para chamar daqui?").
2902:     *===========================================================================
2903:     PROTECTED PROCEDURE LimparCampos()
2904:         LOCAL loc_oPg2
2905: 
2906:         TRY
2907:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2908: 
2909:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
2910:                 loc_oPg2.txt_4c_Nome.Value = ""
2911:             ENDIF
2912:             IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
2913:                 loc_oPg2.txt_4c_Grupo.Value = ""
2914:             ENDIF
2915:             IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5)
2916:                 loc_oPg2.txt_4c_DGrupo.Value = ""
2917:             ENDIF
2918:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
2919:                 loc_oPg2.txt_4c_Conta.Value = ""
2920:             ENDIF
2921:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
2922:                 loc_oPg2.txt_4c_DConta.Value = ""
2923:             ENDIF
2924: 
2925:         CATCH TO loException
2926:             MsgErro("Erro em FormSigOpDmp.LimparCampos: " + ;
2927:                 loException.Message, "Erro")
2928:         ENDTRY
2929:     ENDPROC
2930: 
2931:     *===========================================================================
2932:     * BOParaForm - Espelha as propriedades do BO nos campos da ficha
2933:     *
2934:     * SigPrDmo tem QUATRO colunas: nome, grupos, contas e cidchaves. As tres
2935:     * primeiras tem campo na tela; cidchaves e a PK Fortyus, que o legado
2936:     * tambem nunca exibe (e gerada por fUniqueIds no Salva.Click) e por isso
2937:     * fica so na property do BO.
2938:     * As DESCRICOES (txt_4c_DGrupo/txt_4c_DConta) nao vem do BO: sao de outras
2939:     * tabelas e sao resolvidas por CarregarDescricoesMestre, o IniciaDesc do
2940:     * legado.
2941:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
2942:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
2943:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
2944:     * o modificador nao torna o metodo publico, so esconde do leitor que ele
2945:     * continua protegido. Chamar sempre por THIS. de dentro da classe; de
2946:     * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
2947:     * "da para chamar daqui?").
2948:     *===========================================================================
2949:     PROTECTED PROCEDURE BOParaForm()
2950:         LOCAL loc_oPg2, loc_oBO, loc_lResultado
2951:         loc_lResultado = .F.
2952: 
2953:         TRY
2954:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2955:                 MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
2956:                     "FormSigOpDmp.BOParaForm")
2957:             ELSE
2958:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2959:                 loc_oBO  = THIS.this_oBusinessObject
2960: 
2961:                 loc_oPg2.txt_4c_Nome.Value  = ALLTRIM(loc_oBO.this_cNome)
2962:                 loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupos)
2963:                 loc_oPg2.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContas)
2964: 
2965:                 loc_lResultado = .T.
2966:             ENDIF
2967: 
2968:         CATCH TO loException
2969:             MsgErro("Erro em FormSigOpDmp.BOParaForm: " + ;
2970:                 loException.Message, "Erro")
2971:             loc_lResultado = .F.
2972:         ENDTRY
2973: 
2974:         RETURN loc_lResultado
2975:     ENDPROC
2976: 
2977:     *===========================================================================
2978:     * CarregarDescricoesMestre - PROCEDURE iniciadesc do legado
2979:     *
2980:     *   Chave = crSigPrDmo.Grupos
2981:     *   If not IsEmpty(Chave)
2982:     *       poDataMgr.CursorQuery('SigCdGcr','crCursorPesq','Codigos',Chave)
2983:     *       Get_DGrupo.Value = crCursorPesq.DesCrs
2984:     *   Else
2985:     *       Get_DGrupo.Value = ''
2986:     *   EndIf
2987:     *   <o mesmo para Contas -> SigCdCli.iclis -> Get_DConta = rclis>
2988:     *
2989:     * O CursorQuery do fSqlConector consulta a TABELA pela chave, sem o filtro
2990:     * gerbals = 1 que o Init aplica aos cursores de LOOKUP - logo a descricao
2991:     * aparece mesmo para um grupo/conta que hoje nao esteja mais marcado como
2992:     * de balanco. Transcrito assim de proposito: filtrar aqui esconderia a
2993:     * descricao de registro gravado antes da mudanca do cadastro.
2994:     *
2995:     * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir.
2996:     *===========================================================================
2997:     PROCEDURE CarregarDescricoesMestre()
2998:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_cSQL, loc_nResultado
2999: 
3000:         TRY
3001:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3002:             loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
3003:             loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
3004: 
3005:             *-- Descricao do Grupo Sd Inicial (SigCdGcr.descrs)
3006:             IF EMPTY(loc_cGrupo) OR !THIS.ConexaoAtiva()
3007:                 loc_oPg2.txt_4c_DGrupo.Value = ""
3008:             ELSE
3009:                 THIS.FecharCursorBusca("cursor_4c_DescGcr")
3010: 
3011:                 loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
3012:                     " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cGrupo)
3013: 
3014:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGcr")
3015: 
3016:                 IF loc_nResultado < 0
3017:                     MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
3018:                         "o do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3019:                     loc_oPg2.txt_4c_DGrupo.Value = ""
3020:                 ELSE
3021:                     IF USED("cursor_4c_DescGcr") AND RECCOUNT("cursor_4c_DescGcr") > 0
3022:                         GO TOP IN cursor_4c_DescGcr
3023:                         loc_oPg2.txt_4c_DGrupo.Value = ;
3024:                             ALLTRIM(TratarNulo(cursor_4c_DescGcr.descrs, ""))
3025:                     ELSE
3026:                         loc_oPg2.txt_4c_DGrupo.Value = ""
3027:                     ENDIF
3028:                 ENDIF
3029: 
3030:                 THIS.FecharCursorBusca("cursor_4c_DescGcr")
3031:             ENDIF
3032: 
3033:             *-- Descricao da Conta Sd Inicial (SigCdCli.rclis)
3034:             IF EMPTY(loc_cConta) OR !THIS.ConexaoAtiva()
3035:                 loc_oPg2.txt_4c_DConta.Value = ""
3036:             ELSE
3037:                 THIS.FecharCursorBusca("cursor_4c_DescCli")

*-- Linhas 3077 a 3174:
3077:     * logo o SET SAFETY OFF do main.prg nao alcanca form com DataSession = 2 -
3078:     * e o estado anterior e reposto para nao mexer no ambiente do chamador.
3079:     *===========================================================================
3080:     PROTECTED PROCEDURE LimparFases()
3081:         LOCAL loc_cSafety
3082: 
3083:         IF USED("cursor_4c_Fases")
3084:             loc_cSafety = SET("SAFETY")
3085:             SET SAFETY OFF
3086: 
3087:             ZAP IN cursor_4c_Fases
3088: 
3089:             IF loc_cSafety = "ON"
3090:                 SET SAFETY ON
3091:             ENDIF
3092:         ENDIF
3093:     ENDPROC
3094: 
3095:     *===========================================================================
3096:     * CarregarFasesDoBanco - o Requery('crSigCdDpr') do legado
3097:     *
3098:     * Query do AddCursor do Init legado, com o nome da ficha no lugar do
3099:     * parametro ?sNome que o Grupo_op.Click atribuia antes do Requery:
3100:     *   Select * From SigCdDpr Where nome=?sNome Order By Ordems
3101:     *
3102:     * O SELECT vai para um cursor TEMPORARIO e as linhas entram no
3103:     * cursor_4c_Fases por ZAP + APPEND FROM: SQLEXEC direto sobre o alias da
3104:     * grade DESTROI o cursor e com ele todas as Column (Problema 34) - a linha
3105:     * seguinte estouraria "Unknown member COLUMN1". A lista de colunas segue a
3106:     * ordem EXATA de SigCdDpr, que e a ordem do CREATE CURSOR de
3107:     * CriarCursorFases, porque APPEND FROM casa os campos por POSICAO.
3108:     *
3109:     * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir e pela
3110:     * Fase 8 (o Confirmar recarrega a ficha gravada).
3111:     *===========================================================================
3112:     PROCEDURE CarregarFasesDoBanco()
3113:         LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cNome, loc_nAliasAnt
3114:         loc_lResultado = .F.
3115: 
3116:         TRY
3117:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
3118: 
3119:             IF !USED("cursor_4c_Fases")
3120:                 *-- O placeholder e criado na montagem da pagina Dados; se
3121:                 *-- algum caminho de erro o fechou, recria-lo aqui e o que
3122:                 *-- permite a grade voltar a funcionar. Quem religa a grade e o
3123:                 *-- VincularGradeFases, chamado pelos handlers logo depois.
3124:                 THIS.CriarCursorFases()
3125:             ENDIF
3126: 
3127:             IF !THIS.ConexaoAtiva()
3128:                 *-- Sem conexao (ValidarUIFidelity / teste headless) a ficha
3129:                 *-- abre com a grade vazia, nao com as linhas da ficha anterior.
3130:                 THIS.LimparFases()
3131:                 loc_lResultado = .T.
3132:             ELSE
3133:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3134: 
3135:                 loc_cSQL = "SELECT contas, grupos, nome, operas, ordems," + ;
3136:                     " tpops, cidchaves, dopes FROM SigCdDpr" + ;
3137:                     " WHERE RTRIM(nome) = " + EscaparSQL(loc_cNome) + ;
3138:                     " ORDER BY ordems"
3139: 
3140:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
3141: 
3142:                 IF loc_nResultado < 0
3143:                     MsgErro("Erro ao carregar as fases do demonstrativo:" + ;
3144:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
3145:                 ELSE
3146:                     THIS.LimparFases()
3147: 
3148:                     IF USED("cursor_4c_FasesTmp") AND ;
3149:                        RECCOUNT("cursor_4c_FasesTmp") > 0
3150:                         loc_nAliasAnt = SELECT(0)
3151:                         SELECT cursor_4c_Fases
3152:                         APPEND FROM DBF("cursor_4c_FasesTmp")
3153:                         SELECT (loc_nAliasAnt)
3154:                     ENDIF
3155: 
3156:                     loc_lResultado = .T.
3157:                 ENDIF
3158: 
3159:                 THIS.FecharCursorBusca("cursor_4c_FasesTmp")
3160:             ENDIF
3161: 
3162:         CATCH TO loException
3163:             MsgErro("Erro em FormSigOpDmp.CarregarFasesDoBanco: " + ;
3164:                 loException.Message, "Erro")
3165:             loc_lResultado = .F.
3166:         ENDTRY
3167: 
3168:         RETURN loc_lResultado
3169:     ENDPROC
3170: 
3171:     *===========================================================================
3172:     * FocarAposAbrirFicha - o Do Case de SetFocus do Grupo_op.Click do SCX
3173:     *
3174:     *   Case Inlist(pcEscolha,'INSERIR','PROCURAR')  -> GetNome.SetFocus

*-- Linhas 3180 a 3295:
3180:     * desabilitado dispara erro - por isso o Enabled e conferido antes e o foco
3181:     * cai no Cancelar, que nesse modo e a unica saida da ficha.
3182:     *===========================================================================
3183:     PROTECTED PROCEDURE FocarAposAbrirFicha()
3184:         LOCAL loc_oPg2
3185:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3186: 
3187:         DO CASE
3188:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
3189:                 IF loc_oPg2.txt_4c_Nome.Enabled AND loc_oPg2.txt_4c_Nome.Visible
3190:                     loc_oPg2.txt_4c_Nome.SetFocus()
3191:                 ENDIF
3192: 
3193:             CASE THIS.this_cModoAtual == "ALTERAR"
3194:                 IF loc_oPg2.txt_4c_Grupo.Enabled AND loc_oPg2.txt_4c_Grupo.Visible
3195:                     loc_oPg2.txt_4c_Grupo.SetFocus()
3196:                 ENDIF
3197: 
3198:             CASE INLIST(THIS.this_cModoAtual, "EXCLUIR", "VISUALIZAR")
3199:                 IF loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled AND ;
3200:                    loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible
3201:                     loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
3202:                 ELSE
3203:                     IF loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled AND ;
3204:                        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Visible
3205:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
3206:                     ENDIF
3207:                 ENDIF
3208:         ENDCASE
3209:     ENDPROC
3210: 
3211:     *===========================================================================
3212:     * AbrirFichaDoRegistro - funil dos tres verbos que carregam registro
3213:     * existente (CONSULTAR, ALTERAR e EXCLUIR do Grupo_op.Click)
3214:     *
3215:     * Os tres fazem a MESMA coisa no legado - ReQuery(1, PK, <cursor>.PK), ou
3216:     * seja recarregam do BANCO o registro em que a grade da Lista esta
3217:     * posicionada - e divergem so no modo resultante (que e quem trava os
3218:     * campos e habilita o Confirmar) e no foco inicial.
3219:     *
3220:     * Com a Lista VAZIA o frmcadastro devolve .F. e o Click do SCX volta para a
3221:     * pagina 1 sem abrir a ficha. Aqui a recusa vem com MsgAviso: o silencio do
3222:     * legado e efeito da arquitetura dele, e botao que nao responde ao clique
3223:     * nem explica por que e o pior dos dois mundos.
3224:     *===========================================================================
3225:     PROTECTED PROCEDURE AbrirFichaDoRegistro(par_cModo)
3226:         LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_cErroBO
3227:         loc_lResultado  = .F.
3228:         loc_lProsseguir = .T.
3229: 
3230:         TRY
3231:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
3232:                EOF("cursor_4c_Dados")
3233:                 MsgAviso("Selecione um demonstrativo na lista.", "FormSigOpDmp")
3234:                 loc_lProsseguir = .F.
3235:             ENDIF
3236: 
3237:             IF loc_lProsseguir
3238:                 loc_cNome = ALLTRIM(TratarNulo(cursor_4c_Dados.nome, ""))
3239: 
3240:                 IF EMPTY(loc_cNome)
3241:                     MsgAviso("A linha selecionada n" + CHR(227) + "o tem nome " + ;
3242:                         "de demonstrativo.", "FormSigOpDmp")
3243:                     loc_lProsseguir = .F.
3244:                 ENDIF
3245:             ENDIF
3246: 
3247:             IF loc_lProsseguir
3248:                 *-- ReQuery do legado: o registro vem do BANCO, nao do cursor
3249:                 *-- da grade - a lista pode estar na tela desde antes de outro
3250:                 *-- usuario alterar o registro.
3251:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cNome)
3252:                     loc_cErroBO = ;
3253:                         ALLTRIM(THIS.this_oBusinessObject.ObterMensagemErro())
3254:                     IF !EMPTY(loc_cErroBO)
3255:                         MsgAviso(loc_cErroBO, "FormSigOpDmp")
3256:                     ENDIF
3257:                     loc_lProsseguir = .F.
3258:                 ENDIF
3259:             ENDIF
3260: 
3261:             IF loc_lProsseguir
3262:                 *-- EditarRegistro so no ALTERAR: ele liga this_lEmEdicao, que
3263:                 *-- e o que autoriza o Salvar do BusinessBase. CONSULTAR e
3264:                 *-- EXCLUIR nao gravam por este caminho.
3265:                 IF par_cModo == "ALTERAR"
3266:                     THIS.this_oBusinessObject.EditarRegistro()
3267:                 ENDIF
3268: 
3269:                 THIS.BOParaForm()
3270:                 THIS.CarregarDescricoesMestre()
3271:                 THIS.CarregarFasesDoBanco()
3272: 
3273:                 *-- Modo ANTES de trocar de pagina: AlternarPagina chama
3274:                 *-- AjustarBotoesPorModo, que decide o Confirmar e o ReadOnly
3275:                 *-- dos campos pelo modo (Problema 19).
3276:                 THIS.this_cModoAtual = par_cModo
3277:                 THIS.AlternarPagina(2)
3278: 
3279:                 *-- Re-liga a grade DEPOIS de popular o cursor, como o
3280:                 *-- Grupo_op.Click do legado, e repinta so com a pagina JA
3281:                 *-- ativa: Refresh em pagina oculta nao pinta (regra #21).
3282:                 THIS.VincularGradeFases()
3283:                 THIS.RepintarGradeFases()
3284: 
3285:                 THIS.FocarAposAbrirFicha()
3286: 
3287:                 loc_lResultado = .T.
3288:             ENDIF
3289: 
3290:         CATCH TO loException
3291:             MostrarErro("Erro ao abrir a ficha do demonstrativo:" + CHR(13) + ;
3292:                 loException.Message + CHR(13) + ;
3293:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3294:                 "FormSigOpDmp.AbrirFichaDoRegistro")
3295:             loc_lResultado = .F.

*-- Linhas 3307 a 3562:
3307:     * confirmado (GetNome.Valid -> InsiraRegGrade, ja em ValidarNomeLostFocus)
3308:     * ou pelo botao Inserir de linha.
3309:     *
3310:     * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
3311:     * chama este metodo de fora.
3312:     *===========================================================================
3313:     PROCEDURE BtnIncluirClick()
3314:         LOCAL loc_lResultado
3315:         loc_lResultado = .F.
3316: 
3317:         TRY
3318:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3319:                 MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
3320:                     "FormSigOpDmp.BtnIncluirClick")
3321:             ELSE
3322:                 *-- NovoRegistro limpa as properties do BO e liga
3323:                 *-- this_lNovoRegistro, que e o que faz o Salvar escolher
3324:                 *-- INSERT em vez de UPDATE. Sem ele o Confirmar da Fase 8
3325:                 *-- tentaria atualizar um registro que ainda nao existe.
3326:                 THIS.this_oBusinessObject.NovoRegistro()
3327: 
3328:                 THIS.LimparCampos()
3329:                 THIS.LimparFases()
3330: 
3331:                 THIS.this_cModoAtual = "INCLUIR"
3332:                 THIS.AlternarPagina(2)
3333: 
3334:                 THIS.VincularGradeFases()
3335:                 THIS.RepintarGradeFases()
3336: 
3337:                 THIS.FocarAposAbrirFicha()
3338: 
3339:                 loc_lResultado = .T.
3340:             ENDIF
3341: 
3342:         CATCH TO loException
3343:             MostrarErro("Erro ao iniciar a inclus" + CHR(227) + "o:" + CHR(13) + ;
3344:                 loException.Message + CHR(13) + ;
3345:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3346:                 "FormSigOpDmp.BtnIncluirClick")
3347:             loc_lResultado = .F.
3348:         ENDTRY
3349: 
3350:         RETURN loc_lResultado
3351:     ENDPROC
3352: 
3353:     *===========================================================================
3354:     * BtnVisualizarClick - Grupo_op.Click(2), pcEscolha = 'CONSULTAR'
3355:     *
3356:     * Ficha somente leitura: o AjustarBotoesPorModo deixa o Confirmar
3357:     * desabilitado (frmcadastro: Salva.Enabled = Not pcEscolha=[CONSULTAR]) e o
3358:     * AtualizarEstadoCampos poe ReadOnly em todos os campos, porque o "When"
3359:     * deles so libera INSERIR e ALTERAR.
3360:     *
3361:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3362:     *===========================================================================
3363:     PROCEDURE BtnVisualizarClick()
3364:         RETURN THIS.AbrirFichaDoRegistro("VISUALIZAR")
3365:     ENDPROC
3366: 
3367:     *===========================================================================
3368:     * BtnAlterarClick - Grupo_op.Click(3), pcEscolha = 'ALTERAR'
3369:     *
3370:     * Unico verbo que chama EditarRegistro no BO. O Nome continua travado
3371:     * (NomeEditavel devolve .F. fora de INCLUIR/PROCURAR): ele e a chave que
3372:     * amarra as linhas de SigCdDpr ao demonstrativo.
3373:     *
3374:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3375:     *===========================================================================
3376:     PROCEDURE BtnAlterarClick()
3377:         RETURN THIS.AbrirFichaDoRegistro("ALTERAR")
3378:     ENDPROC
3379: 
3380:     *===========================================================================
3381:     * BtnExcluirClick - Grupo_op.Click(4), pcEscolha = 'EXCLUIR'
3382:     *
3383:     * NAO exclui nada: abre a ficha travada em modo EXCLUIR, com o Confirmar
3384:     * habilitado, exatamente como o legado. A pergunta "Deseja Realmente
3385:     * Excluir Esses Dados?" e o DELETE (mSv_Excluir + ExcluiItens, que apaga as
3386:     * linhas de SigCdDpr do mesmo nome) vivem no Confirmar, da Fase 8.
3387:     *
3388:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3389:     *===========================================================================
3390:     PROCEDURE BtnExcluirClick()
3391:         RETURN THIS.AbrirFichaDoRegistro("EXCLUIR")
3392:     ENDPROC
3393: 
3394:     *===========================================================================
3395:     * GradeListaKeyPress / GradeListaDblClick - atalhos da grade da Lista
3396:     *
3397:     * O frmcadastro trata o Enter na grade da Lista como CONSULTAR:
3398:     *   Case (nKeyCode = 13) And lnPag = 1 And ...ActiveControl.BaseClass=[GRID]
3399:     *       NoDefault / loGrp.Click(2)
3400:     * O duplo clique nao existe no legado e vai para o MESMO funil: e o gesto
3401:     * que o usuario tenta primeiro numa lista e nao retira nada da tela.
3402:     *
3403:     * KeyPress PRECISA declarar os dois parametros do evento (regra #3): sem
3404:     * eles o VFP estoura "No PARAMETER statement is found" a cada tecla.
3405:     * PUBLIC: alvo de BINDEVENT.
3406:     *===========================================================================
3407:     PROCEDURE GradeListaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3408:         IF par_nKeyCode = 13 AND par_nShiftAltCtrl = 0 AND ;
3409:            THIS.pgf_4c_Paginas.ActivePage = 1
3410:             THIS.BtnVisualizarClick()
3411:         ENDIF
3412:     ENDPROC
3413: 
3414:     PROCEDURE GradeListaDblClick()
3415:         IF THIS.pgf_4c_Paginas.ActivePage = 1
3416:             THIS.BtnVisualizarClick()
3417:         ENDIF
3418:     ENDPROC
3419: 
3420:     *===========================================================================
3421:     * BtnCancelarClick - Cancela a ficha e volta para a pagina Lista
3422:     * Legado: Grupo_Salva.Cancelar.Click -> DoDefault() e, se plCancelar,
3423:     * ThisForm.mAtivapagina1. AlternarPagina(1) ja repoe o modo LISTA,
3424:     * recarrega a grade e reabilita os botoes CRUD.
3425:     *
3426:     * O mAtivapagina1 do frmcadastro ABRE com ".poDataMgr.RollBack": e o
3427:     * rollback que faz o Cancelar realmente cancelar numa conexao em transacao
3428:     * manual. Sem ele, uma gravacao parcial ainda aberta na transacao
3429:     * seria efetivada depois, no disconnect.
3430:     *
3431:     * A confirmacao vem do Cancelar.Click do frmcadastro, transcrita:
3432:     *   .plCancelar = (Not InList(.pcEscolha, [INSERIR], [ALTERAR]) Or
3433:     *                  MessageBox([Confirma o Cancelamento Dos Dados
3434:     *                  Informados?], 4+32+256, ...) = 6)
3435:     * ou seja: so pergunta quando ha dado digitado para perder (INSERIR e
3436:     * ALTERAR); em CONSULTAR/EXCLUIR/PROCURAR o Cancelar sai direto. E "Nao"
3437:     * NAO fecha a ficha - o mAtivapagina1 do SCX so roda "If Thisform
3438:     * .plCancelar". MsgConfirma devolve LOGICO, nunca 6 (regra #7).
3439:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3440:     *===========================================================================
3441:     PROCEDURE BtnCancelarClick()
3442:         LOCAL loc_lCancelar
3443: 
3444:         loc_lCancelar = .T.
3445: 
3446:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3447:             loc_lCancelar = MsgConfirma("Confirma o Cancelamento Dos Dados " + ;
3448:                 "Informados?", "Confirma" + CHR(231) + CHR(227) + "o de " + ;
3449:                 "Cancelamento")
3450:         ENDIF
3451: 
3452:         IF loc_lCancelar
3453:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3454:                 THIS.this_oBusinessObject.CancelarEdicao()
3455:             ENDIF
3456: 
3457:             THIS.DesfazerTransacao()
3458: 
3459:             THIS.AlternarPagina(1)
3460:         ENDIF
3461:     ENDPROC
3462: 
3463:     *===========================================================================
3464:     * BtnEncerrarClick - Fecha o formulario
3465:     * Legado: Grupo_Saida.SAIR, cujo Click do frmcadastro libera o form.
3466:     * PUBLIC: BINDEVENT exige metodo publico (regra #3).
3467:     *===========================================================================
3468:     PROCEDURE BtnEncerrarClick()
3469:         THIS.Release()
3470:     ENDPROC
3471: 
3472:     *===========================================================================
3473:     * FASE 8 - CONFIRMAR, BUSCAR POR EXEMPLO E PERSISTENCIA
3474:     *
3475:     * Legado (Pagina.Dados.Grupo_Salva.Salva.Click do SCX):
3476:     *   <limpa RecordSource/ControlSource da grade de fases>
3477:     *   If pcescolha = 'INSERIR' -> Replace cIdChaves With fUniqueIds()
3478:     *   If Not poDataMgr.Update('crSigCdDpr') -> erro
3479:     *   If Inlist( pcEscolha, 'EXCLUIR' ) -> ExcluiItens()
3480:     *   =DoDefault()          && frmcadastro.Salva.Click: o Do Case por verbo
3481:     *   ThisForm.mAtivapagina1
3482:     *
3483:     * e o Do Case do frmcadastro, que e o despachante de verdade:
3484:     *   INSERIR   -> mSv_Inserir   (poDataMgr.Update(1) + Commit)
3485:     *   CONSULTAR -> mSv_Consultar
3486:     *   ALTERAR   -> mSv_Alterar   (poDataMgr.Update(1) + Commit)
3487:     *   EXCLUIR   -> MessageBox('Deseja Realmente Excluir Esses Dados?')
3488:     *                e, se 6, mSv_Excluir (poDataMgr.Delete(1) + Commit)
3489:     *   PROCURAR  -> apaga o registro em branco do cursor mestre e chama
3490:     *                mSv_Procurar, que nesta tela e o Seek por nome
3491:     *===========================================================================
3492: 
3493:     *===========================================================================
3494:     * FormParaBO - Transfere os campos da ficha para as propriedades do BO
3495:     *
3496:     * No SCX os TRES campos do cabecalho tem ControlSource no cursor mestre:
3497:     *   GetNome   -> crSigPrDmo.nome
3498:     *   Get_Grupo -> crSigPrDmo.Grupos
3499:     *   Get_Conta -> crSigPrDmo.Contas
3500:     * ou seja, o que o usuario digita vai DIRETO para o registro que o
3501:     * TableUpdate do Salva.Click grava. Os campos desta tela nao tem
3502:     * ControlSource (o valor vive na .Value) e este metodo e o equivalente.
3503:     *
3504:     * Os campos de DESCRICAO (txt_4c_DGrupo/txt_4c_DConta) NAO entram: eles
3505:     * sao a segunda porta de entrada do lookup e vem de outras tabelas
3506:     * (SigCdGcr.descrs e SigCdCli.rclis); quem os resolve e o
3507:     * CarregarDescricoesMestre. SigPrDmo nao tem coluna de descricao.
3508:     *
3509:     * cidchaves tambem nao vem da tela: e a PK Fortyus de SigPrDmo. No
3510:     * INCLUIR o Inserir do BO a gera com fUniqueIds (legado: "If pcescolha
3511:     * ='INSERIR' Replace cIdChaves With fUniqueIds() in crSigPrDmo"); no
3512:     * ALTERAR ela ja veio do CarregarPorCodigo e nao se toca.
3513:     *
3514:     * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
3515:     * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
3516:     * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
3517:     * o modificador nao torna o metodo publico, so esconde do leitor que ele
3518:     * continua protegido. Chamar sempre por THIS. de dentro da classe; de
3519:     * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
3520:     * "da para chamar daqui?").
3521:     *===========================================================================
3522:     PROTECTED PROCEDURE FormParaBO()
3523:         LOCAL loc_oPg2, loc_oBO, loc_lResultado
3524:         loc_lResultado = .F.
3525: 
3526:         TRY
3527:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3528:                 MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
3529:                     "FormSigOpDmp.FormParaBO")
3530:             ELSE
3531:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3532:                 loc_oBO  = THIS.this_oBusinessObject
3533: 
3534:                 *-- Os LEFT() respeitam a largura das colunas de SigPrDmo
3535:                 *-- (nome char(20), grupos char(10), contas char(10)): sem
3536:                 *-- eles o SQL Server recusa o INSERT inteiro com "String or
3537:                 *-- binary data would be truncated" (regra #19).
3538:                 loc_oBO.this_cNome   = LEFT(ALLTRIM(loc_oPg2.txt_4c_Nome.Value), 20)
3539:                 loc_oBO.this_cGrupos = LEFT(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), 10)
3540:                 loc_oBO.this_cContas = LEFT(ALLTRIM(loc_oPg2.txt_4c_Conta.Value), 10)
3541: 
3542:                 loc_lResultado = .T.
3543:             ENDIF
3544: 
3545:         CATCH TO loException
3546:             MsgErro("Erro em FormSigOpDmp.FormParaBO: " + ;
3547:                 loException.Message, "Erro")
3548:             loc_lResultado = .F.
3549:         ENDTRY
3550: 
3551:         RETURN loc_lResultado
3552:     ENDPROC
3553: 
3554:     *===========================================================================
3555:     * HabilitarCampos - Libera ou trava os campos editaveis da ficha
3556:     *
3557:     * Equivale ao mObjEnabled(Pagina.Dados, .t.) do frmcadastro, chamado pelo
3558:     * Grupo_op.Click antes de trocar de pagina.
3559:     *
3560:     * ReadOnly, e NAO Enabled (PILAR 1): o mObjEnabled do legado deixa
3561:     * Enabled = .T. ate em CONSULTAR/EXCLUIR e mexe no ReadOnly justamente
3562:     * para nao pintar o campo de cinza (ele chega a copiar ForeColor/BackColor

*-- Linhas 3571 a 3614:
3571:     *
3572:     * PUBLIC: alvo do harness de teste.
3573:     *===========================================================================
3574:     PROCEDURE HabilitarCampos(par_lHabilitar)
3575:         LOCAL loc_lHabilitar, loc_oPg2
3576: 
3577:         loc_lHabilitar = .T.
3578:         IF VARTYPE(par_lHabilitar) = "L"
3579:             loc_lHabilitar = par_lHabilitar
3580:         ENDIF
3581: 
3582:         TRY
3583:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3584: 
3585:             IF loc_lHabilitar
3586:                 *-- Grid.ReadOnly ANTES das colunas: o do grid propaga
3587:                 *-- (regra #18). Quem bloqueia a digitacao celula a celula
3588:                 *-- fora de INCLUIR/ALTERAR e o GradeFasesCelulaWhen.
3589:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Fases", 5)
3590:                     loc_oPg2.grd_4c_Fases.ReadOnly = .F.
3591:                 ENDIF
3592: 
3593:                 THIS.AtualizarEstadoCampos()
3594:             ELSE
3595:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
3596:                     loc_oPg2.txt_4c_Nome.ReadOnly = .T.
3597:                 ENDIF
3598:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
3599:                     loc_oPg2.txt_4c_Grupo.ReadOnly = .T.
3600:                 ENDIF
3601:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5)
3602:                     loc_oPg2.txt_4c_DGrupo.ReadOnly = .T.
3603:                 ENDIF
3604:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
3605:                     loc_oPg2.txt_4c_Conta.ReadOnly = .T.
3606:                 ENDIF
3607:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
3608:                     loc_oPg2.txt_4c_DConta.ReadOnly = .T.
3609:                 ENDIF
3610:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Fases", 5)
3611:                     loc_oPg2.grd_4c_Fases.ReadOnly = .T.
3612:                 ENDIF
3613:             ENDIF
3614: 

*-- Linhas 3640 a 3868:
3640:     * "IF loc_lManual AND SQLCOMMIT(...)" chamaria o SQLCOMMIT de qualquer
3641:     * jeito.
3642:     *===========================================================================
3643:     PROTECTED PROCEDURE ConfirmarTransacao()
3644:         LOCAL loc_lResultado, loc_lManual
3645:         loc_lResultado = .T.
3646: 
3647:         IF THIS.ConexaoAtiva()
3648:             loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
3649: 
3650:             IF loc_lManual
3651:                 IF SQLCOMMIT(gnConnHandle) < 1
3652:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3653:                         CapturarErroSQL(), "Falha ao confirmar a grava" + ;
3654:                         CHR(231) + CHR(227) + "o")
3655:                     loc_lResultado = .F.
3656:                 ENDIF
3657:             ENDIF
3658:         ENDIF
3659: 
3660:         RETURN loc_lResultado
3661:     ENDPROC
3662: 
3663:     *===========================================================================
3664:     * DesfazerTransacao - o poDataMgr.RollBack do mAtivapagina1 legado
3665:     *
3666:     * O mAtivapagina1 do frmcadastro ABRE com ".poDataMgr.RollBack", ou seja
3667:     * qualquer retorno a pagina Lista descarta o nao confirmado - e o que
3668:     * faz o Cancelar realmente cancelar numa conexao em transacao manual.
3669:     * Depois de um Confirmar bem-sucedido o rollback e inofensivo: a transacao
3670:     * ja foi fechada pelo commit e nao resta nada aberto.
3671:     *
3672:     * O legado ignora o retorno do RollBack e aqui tambem: a conexao pode
3673:     * estar em auto-commit (loc_lManual = .F.) ou sem transacao aberta, e os
3674:     * dois casos sao normais - nao ha falha a reportar ao usuario.
3675:     *===========================================================================
3676:     PROTECTED PROCEDURE DesfazerTransacao()
3677:         LOCAL loc_lManual
3678: 
3679:         IF THIS.ConexaoAtiva()
3680:             loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
3681: 
3682:             IF loc_lManual
3683:                 = SQLROLLBACK(gnConnHandle)
3684:             ENDIF
3685:         ENDIF
3686:     ENDPROC
3687: 
3688:     *===========================================================================
3689:     * BtnBuscarClick - Grupo_op.Click(5), pcEscolha = 'PROCURAR'
3690:     *
3691:     * Legado (frmcadastro.Pagina.Lista.Grupo_Op.Click, Case This.Value = 5):
3692:     *   .pcEscolha = [PROCURAR]
3693:     *   If (Used(<cursor mestre>) And Not Eof(<cursor mestre>))
3694:     *       ThisForm.poDataMgr.NewReg(1)
3695:     *   EndIf
3696:     * e, no Click do SCX, "Zap in ('crSigCdDpr')" (o ramo nao-INSERIR e o
3697:     * unico que faz Requery) e "GetNome.SetFocus".
3698:     *
3699:     * NAO ABRE PICKER. Este form tem PROCEDURE msv_procurar, logo o Procurar
3700:     * e BUSCA POR EXEMPLO: ele poe a ficha em branco, libera SO o campo Nome
3701:     * (o "When" de GetNome devolve .T. em PROCURAR e os de Grupo/Conta
3702:     * devolvem .F.) e quem executa a consulta e o Confirmar.
3703:     *
3704:     * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
3705:     * chama este metodo de fora.
3706:     *===========================================================================
3707:     PROCEDURE BtnBuscarClick()
3708:         LOCAL loc_lResultado
3709:         loc_lResultado = .F.
3710: 
3711:         TRY
3712:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3713:                 MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
3714:                     "FormSigOpDmp.BtnBuscarClick")
3715:             ELSE
3716:                 *-- NewReg(1) do legado: a ficha passa a exibir um registro em
3717:                 *-- branco. Aqui o equivalente e LimparDados no BO (que zera
3718:                 *-- inclusive a cidchaves do registro anterior - regra #22) e
3719:                 *-- LimparCampos na tela.
3720:                 THIS.this_oBusinessObject.LimparDados()
3721:                 THIS.this_oBusinessObject.CancelarEdicao()
3722: 
3723:                 THIS.LimparCampos()
3724:                 THIS.LimparFases()
3725: 
3726:                 THIS.this_cModoAtual = "PROCURAR"
3727:                 THIS.AlternarPagina(2)
3728: 
3729:                 THIS.VincularGradeFases()
3730:                 THIS.RepintarGradeFases()
3731: 
3732:                 THIS.FocarAposAbrirFicha()
3733: 
3734:                 loc_lResultado = .T.
3735:             ENDIF
3736: 
3737:         CATCH TO loException
3738:             MostrarErro("Erro ao iniciar a busca:" + CHR(13) + ;
3739:                 loException.Message + CHR(13) + ;
3740:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3741:                 "FormSigOpDmp.BtnBuscarClick")
3742:             loc_lResultado = .F.
3743:         ENDTRY
3744: 
3745:         RETURN loc_lResultado
3746:     ENDPROC
3747: 
3748:     *===========================================================================
3749:     * BtnSalvarClick - Pagina.Dados.Grupo_Salva.Salva.Click (o Confirmar)
3750:     *
3751:     * Despachante por modo, como o Do Case do frmcadastro. Cada ramo esta no
3752:     * seu proprio metodo porque os tres fazem coisas sem nada em comum:
3753:     * gravar, excluir e posicionar a lista.
3754:     *
3755:     * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
3756:     * chama este metodo de fora.
3757:     *===========================================================================
3758:     PROCEDURE BtnSalvarClick()
3759:         LOCAL loc_lResultado
3760:         loc_lResultado = .F.
3761: 
3762:         TRY
3763:             DO CASE
3764:                 CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3765:                     loc_lResultado = THIS.GravarFicha()
3766: 
3767:                 CASE THIS.this_cModoAtual == "EXCLUIR"
3768:                     loc_lResultado = THIS.ExcluirFicha()
3769: 
3770:                 CASE THIS.this_cModoAtual == "PROCURAR"
3771:                     loc_lResultado = THIS.ExecutarBuscaPorNome()
3772: 
3773:                 CASE THIS.this_cModoAtual == "VISUALIZAR"
3774:                     *-- Legado: mSv_Consultar, que no frmcadastro nao grava
3775:                     *-- nada - e o Confirmar esta DESABILITADO neste modo
3776:                     *-- (Salva.Enabled = Not pcEscolha = [CONSULTAR]), logo
3777:                     *-- o clique nao chega aqui. O ramo existe porque o
3778:                     *-- handler tambem e chamado de fora (harness de teste),
3779:                     *-- e a unica coisa coerente a fazer e fechar a ficha.
3780:                     THIS.AlternarPagina(1)
3781:                     loc_lResultado = .T.
3782: 
3783:                 OTHERWISE
3784:                     MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o em " + ;
3785:                         "andamento para confirmar.", "FormSigOpDmp")
3786:             ENDCASE
3787: 
3788:         CATCH TO loException
3789:             MostrarErro("Erro ao confirmar:" + CHR(13) + ;
3790:                 loException.Message + CHR(13) + ;
3791:                 "Linha: " + TRANSFORM(loException.LineNo), ;
3792:                 "FormSigOpDmp.BtnSalvarClick")
3793:             loc_lResultado = .F.
3794:         ENDTRY
3795: 
3796:         RETURN loc_lResultado
3797:     ENDPROC
3798: 
3799:     *===========================================================================
3800:     * GravarFicha - ramos INSERIR e ALTERAR do Confirmar
3801:     *
3802:     * ORDEM: fases (SigCdDpr) ANTES do mestre (SigPrDmo), como no legado - o
3803:     * Salva.Click do SCX faz "poDataMgr.Update('crSigCdDpr')" e so depois
3804:     * chama o DoDefault() que dispara mSv_Inserir/mSv_Alterar. As duas tabelas
3805:     * nao tem FK entre si, logo a ordem nao muda o resultado no banco; o que
3806:     * ela muda e o estado do BO quando algo falha. Com o mestre primeiro, uma
3807:     * falha nas fases deixaria o BO com this_lNovoRegistro = .F. (o Salvar
3808:     * limpa os flags no sucesso) e a retentativa viraria um UPDATE de um
3809:     * registro que o rollback apagou - UPDATE que afeta 0 linhas devolve
3810:     * sucesso e perderia o cadastro EM SILENCIO. Na ordem do legado o BO so
3811:     * muda de estado depois que tudo deu certo.
3812:     *
3813:     * A validacao do Nome fica FORA do TRY. Ela e a mesma do GetNome.Valid
3814:     * legado ("O Nome deve ser informado..."), que la retem o foco com
3815:     * "Return 0" e por isso impede o usuario de chegar ao Confirmar sem nome;
3816:     * aqui o LostFocus nao pode reter o foco (ver ValidarNomeLostFocus) e este
3817:     * e o ponto onde a gravacao e efetivamente recusada.
3818:     *===========================================================================
3819:     PROTECTED PROCEDURE GravarFicha()
3820:         LOCAL loc_lResultado, loc_lProsseguir, loc_oPg2, loc_cNome, loc_oBO
3821:         loc_lResultado  = .F.
3822:         loc_lProsseguir = .T.
3823: 
3824:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3825:         loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)
3826: 
3827:         IF EMPTY(loc_cNome)
3828:             MsgAviso("O Nome deve ser informado...", "FormSigOpDmp")
3829: 
3830:             IF loc_oPg2.txt_4c_Nome.Enabled AND loc_oPg2.txt_4c_Nome.Visible ;
3831:                AND !loc_oPg2.txt_4c_Nome.ReadOnly
3832:                 loc_oPg2.txt_4c_Nome.SetFocus()
3833:             ENDIF
3834: 
3835:             RETURN .F.
3836:         ENDIF
3837: 
3838:         TRY
3839:             loc_oBO = THIS.this_oBusinessObject
3840: 
3841:             IF !THIS.FormParaBO()
3842:                 loc_lProsseguir = .F.
3843:             ENDIF
3844: 
3845:             *-- Fases primeiro (poDataMgr.Update('crSigCdDpr') do legado).
3846:             IF loc_lProsseguir
3847:                 IF !loc_oBO.GravarFases("cursor_4c_Fases", loc_cNome)
3848:                     IF !loc_oBO.this_lErroExibido
3849:                         MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3850:                             "Favor Reinicializar o Processo!!!", ;
3851:                             ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3852:                             "Falha ao gravar as fases")
3853:                     ENDIF
3854:                     loc_lProsseguir = .F.
3855:                 ENDIF
3856:             ENDIF
3857: 
3858:             *-- Mestre depois (mSv_Inserir / mSv_Alterar do frmcadastro).
3859:             *-- O BusinessBase.Salvar() escolhe INSERT ou UPDATE pelo
3860:             *-- this_lNovoRegistro e JA reporta toda falha (regra #20): o
3861:             *-- ELSE abaixo so cobre o caso de ele recusar sem exibir.
3862:             IF loc_lProsseguir
3863:                 IF !loc_oBO.Salvar()
3864:                     IF !loc_oBO.this_lErroExibido
3865:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
3866:                             "vel gravar o demonstrativo.", "Confirmar")
3867:                     ENDIF
3868:                     loc_lProsseguir = .F.

*-- Linhas 3924 a 3975:
3924:     *
3925:     * MsgConfirma devolve LOGICO (.T./.F.), nunca 6 (regra #7).
3926:     *===========================================================================
3927:     PROTECTED PROCEDURE ExcluirFicha()
3928:         LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_oBO
3929:         loc_lResultado  = .F.
3930:         loc_lProsseguir = .T.
3931: 
3932:         loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
3933: 
3934:         IF EMPTY(loc_cNome)
3935:             MsgAviso("A ficha n" + CHR(227) + "o tem nome de demonstrativo " + ;
3936:                 "para excluir.", "FormSigOpDmp")
3937:             RETURN .F.
3938:         ENDIF
3939: 
3940:         IF !MsgConfirma("Deseja Realmente Excluir Esses Dados?", ;
3941:                 "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
3942:             *-- plCancelar = .T. no legado, e o Salva.Click do SCX segue para o
3943:             *-- mAtivapagina1: a ficha fecha e a Lista volta como estava.
3944:             THIS.AlternarPagina(1)
3945:             RETURN .F.
3946:         ENDIF
3947: 
3948:         TRY
3949:             loc_oBO = THIS.this_oBusinessObject
3950: 
3951:             *-- ExcluiItens do legado: apaga as fases do nome.
3952:             IF !loc_oBO.ExcluirFases(loc_cNome)
3953:                 IF !loc_oBO.this_lErroExibido
3954:                     MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3955:                         "Favor Reinicializar o Processo!!!", ;
3956:                         ALLTRIM(loc_oBO.ObterMensagemErro())), ;
3957:                         "Falha ao excluir as fases")
3958:                 ENDIF
3959:                 loc_lProsseguir = .F.
3960:             ENDIF
3961: 
3962:             *-- mSv_Excluir: DELETE do mestre. O Excluir() do BusinessBase e
3963:             *-- PUBLIC e chama o ExecutarExclusao do BO (regra #51); ele ja
3964:             *-- reporta toda falha (regra #20).
3965:             IF loc_lProsseguir
3966:                 IF !loc_oBO.Excluir()
3967:                     IF !loc_oBO.this_lErroExibido
3968:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
3969:                             "vel excluir o demonstrativo.", "Confirmar")
3970:                     ENDIF
3971:                     loc_lProsseguir = .F.
3972:                 ENDIF
3973:             ENDIF
3974: 
3975:             IF loc_lProsseguir

*-- Linhas 3999 a 4065:
3999:     ENDPROC
4000: 
4001:     *===========================================================================
4002:     * ExecutarBuscaPorNome - PROCEDURE msv_procurar do legado
4003:     *
4004:     *   Set Near On
4005:     *   Select crSigPrDmo
4006:     *   Index On nome tag ix_Nome
4007:     *   Set Order To ix_nome
4008:     *   Seek ThisForm.pagina.dados.getNome.Value
4009:     *   Set Near Off
4010:     *
4011:     * SET NEAR ON e o que faz desta uma busca APROXIMADA: sem casamento
4012:     * exato o ponteiro para no registro mais proximo em vez de ir para EOF.
4013:     * Repor o SET anterior em vez de forcar OFF (o legado forca) porque
4014:     * SET NEAR e de sessao e esta tela nao tem data session privada - deixar
4015:     * o ambiente como estava e o que nao quebra quem chamou.
4016:     *
4017:     * ORDEM INVERTIDA EM RELACAO AO LEGADO, por necessidade: a volta para a
4018:     * pagina Lista vem ANTES do Seek. AlternarPagina(1) chama CarregarLista,
4019:     * que refaz o SELECT e RECRIA o cursor_4c_Dados - posicionar antes seria
4020:     * jogado fora na troca de pagina. No legado o mAtivapagina1 tambem faz
4021:     * ReQuery depois do msv_procurar, com o mesmo efeito de descartar a
4022:     * posicao; a ordem daqui e a unica em que o Procurar realmente posiciona
4023:     * a grade, que e o que o usuario pediu ao clicar no botao.
4024:     *===========================================================================
4025:     PROTECTED PROCEDURE ExecutarBuscaPorNome()
4026:         LOCAL loc_lResultado, loc_cNome, loc_oGrid, loc_nAliasAnt, loc_cNearAnt
4027:         loc_lResultado = .F.
4028: 
4029:         TRY
4030:             loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)
4031: 
4032:             THIS.AlternarPagina(1)
4033: 
4034:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
4035: 
4036:             IF EMPTY(loc_cNome)
4037:                 *-- Procurar sem nome nenhum: o Seek do legado com a string em
4038:                 *-- branco para no primeiro registro, que e onde a Lista
4039:                 *-- recem-recarregada ja esta. Nada a fazer.
4040:                 loc_lResultado = .T.
4041:             ELSE
4042:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
4043:                     loc_nAliasAnt = SELECT(0)
4044:                     SELECT cursor_4c_Dados
4045: 
4046:                     *-- O Buscar do BO ja devolve ORDER BY nome, logo a ordem
4047:                     *-- visual da grade nao muda com este indice - ele existe
4048:                     *-- so para o SEEK, que exige tag ativa.
4049:                     INDEX ON nome TAG ix_nome
4050:                     SET ORDER TO ix_nome IN cursor_4c_Dados
4051: 
4052:                     loc_cNearAnt = SET("NEAR")
4053:                     SET NEAR ON
4054: 
4055:                     SEEK loc_cNome IN cursor_4c_Dados
4056: 
4057:                     IF loc_cNearAnt == "ON"
4058:                         SET NEAR ON
4059:                     ELSE
4060:                         SET NEAR OFF
4061:                     ENDIF
4062: 
4063:                     *-- Nome posterior ao ultimo do indice: o NEAR deixa o
4064:                     *-- ponteiro em EOF e a grade apareceria sem linha
4065:                     *-- selecionada. O registro mais proximo, nesse caso, e o

*-- Linhas 4079 a 4124:
4079: 
4080:                     loc_lResultado = .T.
4081:                 ELSE
4082:                     MsgAviso("Nenhum demonstrativo cadastrado.", "FormSigOpDmp")
4083:                 ENDIF
4084:             ENDIF
4085: 
4086:         CATCH TO loException
4087:             MostrarErro("Erro ao procurar o demonstrativo:" + CHR(13) + ;
4088:                 loException.Message + CHR(13) + ;
4089:                 "Linha: " + TRANSFORM(loException.LineNo), ;
4090:                 "FormSigOpDmp.ExecutarBuscaPorNome")
4091:             loc_lResultado = .F.
4092:         ENDTRY
4093: 
4094:         RETURN loc_lResultado
4095:     ENDPROC
4096: 
4097:     *===========================================================================
4098:     * Destroy - Libera o Business Object e os cursores do formulario
4099:     * O fechamento passa pelo FecharCursorBusca, que tem o guard de Buffering
4100:     * obrigatorio (regra #52): TABLEREVERT em cursor com Buffering = 1 dispara
4101:     * o erro 1586, e USE IN fecha o alias mesmo com buffer sujo.
4102:     *===========================================================================
4103:     PROCEDURE Destroy()
4104:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
4105:             THIS.this_oBusinessObject = .NULL.
4106:         ENDIF
4107: 
4108:         THIS.FecharCursorBusca("cursor_4c_Dados")
4109:         THIS.FecharCursorBusca("cursor_4c_Fases")
4110: 
4111:         *-- Cursores dos sete lookups: cada funil ja fecha o seu no caminho
4112:         *-- normal, mas um CATCH no meio pode deixar algum aberto.
4113:         THIS.FecharCursorBusca("cursor_4c_BuscaGcr")
4114:         THIS.FecharCursorBusca("cursor_4c_BuscaGcrD")
4115:         THIS.FecharCursorBusca("cursor_4c_BuscaCli")
4116:         THIS.FecharCursorBusca("cursor_4c_BuscaCliD")
4117:         THIS.FecharCursorBusca("cursor_4c_BuscaFase")
4118:         THIS.FecharCursorBusca("cursor_4c_BuscaFunc")
4119:         THIS.FecharCursorBusca("cursor_4c_BuscaTpOp")
4120: 
4121:         DODEFAULT()
4122:     ENDPROC
4123: 
4124: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpDmpBO.prg):
*====================================================================
* SigOpDmpBO.prg
*
* Business Object para Cadastro de Demonstrativos de Balanco (SigOpDmp)
* Tabela: SigPrDmo (cabecalho) - detalhe em SigCdDpr (fases 2+)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrDmo)
    this_cNome      = ""    && nome char(20) - chave (nome do demonstrativo)
    this_cContas    = ""    && contas char(10)
    this_cGrupos    = ""    && grupos char(10)
    this_cCidChaves = ""    && cidchaves char(20) - PK Fortyus (gerada em fUniqueIds())

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrDmo"
            THIS.this_cCampoChave = "nome"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpDmpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave (nome) do demonstrativo para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNome)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- O 2o argumento do TratarNulo e o valor PADRAO, nao o tipo:
                *-- TratarNulo(x, "C") devolveria a letra "C" se a coluna
                *-- viesse NULL. Nenhuma coluna de SigPrDmo aceita nulo
                *-- no schema, logo o caminho era inerte - mas o
                *-- padrao certo de coluna char e a string vazia.
                THIS.this_cNome      = TratarNulo(nome,      "")
                THIS.this_cContas    = TratarNulo(contas,    "")
                THIS.this_cGrupos    = TratarNulo(grupos,    "")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpDmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrDmo
    * cidchaves = PK Fortyus (fUniqueIds) - NUNCA string vazia (regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrDmo (contas, grupos, nome, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cNome)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpDmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrDmo
    * nome eh a chave de negocio (nao editavel em modo ALTERAR) - WHERE por nome
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrDmo
                SET contas = <<EscaparSQL(THIS.this_cContas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>
                WHERE nome = <<EscaparSQL(THIS.this_cNome)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar demonstrativo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpDmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * Buscar - Alimenta cursor_4c_Dados, o cursor da grade da pagina Lista
    *
    * Legado (Init do SCX):
    *   lcQryDmPro = [Select * From SigPrDmo ]
    *   .AddCursor('SigPrDmo','cIdChaves','crSigPrDmo','',
    *              ThisForm.Pagina.Lista.Grade, lcQryDmPro)
    *   Select crSigPrDmo / Index On nome tag ix_nome
    * Ou seja: consulta SEM filtro (tabela inteira) e ordenada por nome
    * (regra #35 - a pagina Lista segue o Init do legado).
    *
    * O BusinessBase.Buscar herdado NAO serve aqui: ele delega para
    * this_oDataAccess (nunca instanciado, porque o Init chama DODEFAULT()
    * sem o nome da tabela) e grava no cursor "cur" + tabela, nao no
    * cursor_4c_Dados a que a grade se liga.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (ValidarUIFidelity / teste headless): cria um
                *-- cursor vazio com a MESMA estrutura de SigPrDmo, para a
                *-- grade ter a que se ligar sem consultar o banco.
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (contas C(10), grupos C(10), nome C(20), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT contas, grupos, nome, cidchaves FROM SigPrDmo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY nome"

                *-- USE IN fecha o alias mesmo com buffer sujo; NUNCA
                *-- TABLEREVERT sem antes conferir o Buffering (regra #52).
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar demonstrativos:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Le do BANCO o demonstrativo de um nome
    *
    * Equivale ao ReQuery(1, pcChavePrimaria, <cursor>.<chave>) que o
    * Grupo_op.Click do frmcadastro dispara nos verbos CONSULTAR, ALTERAR e
    * EXCLUIR: o registro vem da tabela, nao do cursor que esta na grade da
    * Lista - que pode estar na tela desde antes de outro usuario altera-lo.
    *
    * A chave de NEGOCIO e o nome (this_cCampoChave = "nome"), e nao a
    * cidchaves: o nome e o que a grade da Lista exibe e o que amarra as
    * linhas de SigCdDpr ao demonstrativo (Where nome=?sNome do AddCursor
    * legado).
    *
    * this_lNovoRegistro volta a .F. aqui: sem isso, um Incluir seguido de
    * Alterar faria o Salvar escolher INSERT e violar a chave primaria.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""

            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF

                    loc_cSQL = "SELECT contas, grupos, nome, cidchaves" + ;
                        " FROM SigPrDmo" + ;
                        " WHERE RTRIM(nome) = " + EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar o demonstrativo:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        IF USED("cursor_4c_Carrega") AND ;
                           RECCOUNT("cursor_4c_Carrega") > 0
                            GO TOP IN cursor_4c_Carrega
                            loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                            THIS.this_lNovoRegistro = .F.
                        ELSE
                            THIS.this_cMensagemErro = "Demonstrativo n" + ;
                                CHR(227) + "o encontrado: " + ALLTRIM(par_cNome)
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao carregar por c" + CHR(243) + "digo:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.CarregarPorCodigo")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as properties da entidade
    *
    * O LimparDados do BusinessBase limpa so a mensagem de erro: as
    * properties de CADA entidade sao responsabilidade da subclasse. Sem este
    * override, NovoRegistro() (chamado pelo Incluir) deixaria nome, grupos,
    * contas e - o mais grave - a cidchaves do registro ANTERIOR nas
    * properties, e o INSERT seguinte reaproveitaria aquela PK: colisao na
    * chave primaria de SigPrDmo (regra #22).
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cNome      = ""
        THIS.this_cContas    = ""
        THIS.this_cGrupos    = ""
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro mestre em SigPrDmo
    *
    * Legado: frmcadastro.mSv_Excluir -> poDataMgr.Delete(1) + Commit(). O
    * AddCursor do Init legado passa 'cIdChaves' como chave do cursor
    * mestre, logo o Delete(1) do Fortyus apaga PELA cidchaves - que e a
    * PRIMARY KEY de SigPrDmo (docs\schema.sql, lido com Get-Content -Raw
    * por ser UTF-16 - regra #14). O nome e a chave de NEGOCIO e NAO tem
    * indice unico: apagar por nome mataria tambem um homonimo gravado por
    * outro caminho. Por isso o WHERE prefere a cidchaves e so cai no nome
    * quando ela nao veio.
    *
    * O COMMIT NAO ACONTECE AQUI. No legado ele e um passo com caminho de
    * falha PROPRIO logo depois do Delete/Update ("If (poDataMgr.Commit()
    * < 1) -> Favor Reinicializar o Processo!!!"), e nesta tela UMA
    * gravacao mexe em DUAS tabelas (SigPrDmo e SigCdDpr): commitar aqui
    * efetivaria o mestre antes de saber se as fases foram gravadas. O
    * commit unico vive no Confirmar do form.
    *
    * PROTECTED: quem chama e o Excluir() do BusinessBase, que ja faz o
    * AntesDeExcluir e o ExibirFalha (regra #51). O form chama Excluir().
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(nome) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cNome))
            ELSE
                loc_cSQL = "DELETE FROM SigPrDmo WHERE RTRIM(cidchaves) = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir demonstrativo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "SigOpDmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirFases - PROCEDURE excluiitens do legado
    *
    *   lcQuery = [Delete From SigCdDpr Where nome=] + getnome.Value
    *   If (poDataMgr.SqlExecute(lcQuery, 'crDelSigCdDpr') < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *   If (poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *
    * Apaga TODAS as fases de um demonstrativo. Serve a dois caminhos do
    * Confirmar: a exclusao do demonstrativo inteiro (o ExcluiItens do
    * legado) e o "apaga e regrava" do GravarFases.
    *
    * O Commit fica de fora pelo mesmo motivo do ExecutarExclusao: e UM so,
    * no form, cobrindo mestre e fases.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE ExcluirFases(par_cNome)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."

                OTHERWISE
                    loc_cSQL = "DELETE FROM SigCdDpr WHERE RTRIM(nome) = " + ;
                        EscaparSQL(ALLTRIM(par_cNome))

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir as fases do " + ;
                            "demonstrativo:" + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao excluir as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.ExcluirFases")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GravarFases - o poDataMgr.Update('crSigCdDpr') do Salva.Click legado
    *
    * No legado o cursor de detalhe e um cursor REMOTO BUFFERIZADO: o
    * Update do fSqlConector e um TABLEUPDATE, que manda ao SQL Server o
    * INSERT das linhas novas, o UPDATE das alteradas e o DELETE das
    * marcadas. Aqui o cursor_4c_Fases e um cursor LOCAL sem buffering
    * (TABLEUPDATE/TABLEREVERT em cursor com Buffering = 1 dispara o erro
    * 1586 - regra #52), logo nao existe lista de alteracoes em aberto a
    * mandar: a gravacao e "apaga as fases deste nome e regrava as linhas
    * vivas da grade".
    *
    * O efeito no banco e o MESMO do TABLEUPDATE: o conjunto de linhas de
    * SigCdDpr daquele nome passa a ser exatamente o conjunto exibido na
    * grade, cada uma com a sua cidchaves PRESERVADA (a PK de SigCdDpr).
    *
    * SCAN FOR !DELETED(): o botao Excluir de LINHA do form faz DELETE no
    * cursor (delecao LOGICA, como o legado), e linha apagada nao pode ser
    * regravada. O FOR explicito e necessario porque SET DELETED e escopado
    * por data session - confiar no SET DELETED ON do config.prg deixaria a
    * exclusao de linha sem efeito em form de sessao privada.
    *
    * O nome gravado em cada linha e o da FICHA, nao o que estava na linha:
    * ele e a chave que amarra a fase ao demonstrativo (o Where nome=?sNome
    * do AddCursor legado). O legado o estampa no momento do Append Blank
    * (InsiraRegGrade) e a ficha nunca deixa trocar o Nome depois que as
    * fases estao preenchidas (o "When" de GetNome), logo em todo caminho
    * normal e o MESMO valor - mas gravar o da ficha fecha a janela em que
    * o usuario troca o Nome com a grade ainda em branco e as linhas ficam
    * ORFAS, invisiveis para o CarregarFasesDoBanco.
    *
    * PUBLIC: o form chama este metodo de fora (regra #51).
    *====================================================================
    PROCEDURE GravarFases(par_cCursor, par_cNome)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cNome, loc_cSQL
        LOCAL loc_nResultado, loc_nAliasAnt, loc_nRegAnt, loc_cCidChaves

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            DO CASE
                CASE VARTYPE(par_cCursor) != "C" OR !USED(par_cCursor)
                    THIS.this_cMensagemErro = "Cursor de fases indispon" + ;
                        CHR(237) + "vel."
                    loc_lProsseguir = .F.

                CASE VARTYPE(par_cNome) != "C" OR EMPTY(ALLTRIM(par_cNome))
                    THIS.this_cMensagemErro = "Nome do demonstrativo n" + ;
                        CHR(227) + "o informado."
                    loc_lProsseguir = .F.

                CASE TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Sem conex" + CHR(227) + ;
                        "o com o banco de dados."
                    loc_lProsseguir = .F.
            ENDCASE

            IF loc_lProsseguir
                loc_cNome = ALLTRIM(par_cNome)

                *-- Apaga as fases atuais do nome. A falha ja foi exibida
                *-- pelo proprio ExcluirFases.
                IF !THIS.ExcluirFases(loc_cNome)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nAliasAnt = SELECT(0)
                SELECT (par_cCursor)
                loc_nRegAnt = RECNO(par_cCursor)

                loc_lSucesso = .T.

                SCAN FOR !DELETED()
                    *-- cidchaves NUNCA em branco: com ela vazia a segunda
                    *-- linha colidiria na PK de SigCdDpr (regra #22).
                    loc_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    IF EMPTY(loc_cCidChaves)
                        loc_cCidChaves = fUniqueIds()
                    ENDIF

                    *-- As OITO colunas de SigCdDpr sao NOT NULL e todas
                    *-- entram no INSERT - inclusive dopes, que nao aparece
                    *-- em lugar nenhum do codigo legado (ele a ganhava de
                    *-- graca do "Select *" + "Append Blank") e cuja
                    *-- ausencia faria o SQL Server recusar o INSERT
                    *-- inteiro (regra #22).
                    loc_cSQL = "INSERT INTO SigCdDpr" + ;
                        " (contas, grupos, nome, operas, ordems," + ;
                        " tpops, cidchaves, dopes) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TratarNulo(contas, ""))) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(grupos, ""))) + "," + ;
                        EscaparSQL(loc_cNome) + "," + ;
                        EscaparSQL(TratarNulo(operas, " ")) + "," + ;
                        FormatarNumeroSQL(TratarNulo(ordems, 0), 0) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(tpops, ""))) + "," + ;
                        EscaparSQL(loc_cCidChaves) + "," + ;
                        EscaparSQL(ALLTRIM(TratarNulo(dopes, ""))) + ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao gravar a fase de ordem " + ;
                            TRANSFORM(TratarNulo(ordems, 0)) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT(par_cCursor)
                    GO loc_nRegAnt IN (par_cCursor)
                ENDIF
                SELECT (loc_nAliasAnt)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar as fases:" + CHR(13) + ;
                loException.Message, "SigOpDmpBO.GravarFases")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC
ENDDEFINE

