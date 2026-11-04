# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupCanonico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1708 linhas total):

*-- Linhas 8 a 51:
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

*-- Linhas 62 a 220:
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
107:     *-- Guarda de "valor nao mudou" dos LostFocus de lookup (regra CLAUDE.md
108:     *-- #47/Problema 45): no legado o Valid so dispara quando o Value MUDA;
109:     *-- LostFocus dispara SEMPRE, inclusive em Tab de passagem sem digitar
110:     *-- nada. Cada propriedade guarda o ultimo valor ja validado do campo
111:     *-- correspondente - atualizada so DEPOIS da validacao rodar.
112:     this_cUltimoGrupoLostFocusValidado   = ""
113:     this_cUltimoDGrupoLostFocusValidado  = ""
114:     this_cUltimoContaLostFocusValidado   = ""
115:     this_cUltimoDContaLostFocusValidado  = ""
116:     this_cUltimoGrupoCLostFocusValidado  = ""
117:     this_cUltimoDGrupoCLostFocusValidado = ""
118:     this_cUltimoContaCLostFocusValidado  = ""
119:     this_cUltimoDContaCLostFocusValidado = ""
120: 
121:     *==========================================================================
122:     * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
123:     *==========================================================================
124:     PROCEDURE Init()
125:         RETURN DODEFAULT()
126:     ENDPROC
127: 
128:     *==========================================================================
129:     * InicializarForm - Cria o Business Object e monta a estrutura visual base
130:     *==========================================================================
131:     PROTECTED PROCEDURE InicializarForm()
132:         LOCAL loc_lSucesso, loc_oErro
133:         loc_lSucesso = .F.
134: 
135:         TRY
136:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpEncBO")
137: 
138:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
139:                 MsgErro("Erro ao criar SigOpEncBO. VARTYPE retornou: " + ;
140:                     VARTYPE(THIS.this_oBusinessObject), "FormSigOpEnc.InicializarForm")
141:             ELSE
142:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
143: 
144:                 *-- SigCdPac.DopZers precisa estar lido ANTES de
145:                 *-- ConfigurarContainerFiltro(), que copia o valor para
146:                 *-- txt_4c_Dope.Value dentro de ConfigurarCamposOperacao()
147:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
148:                     THIS.this_oBusinessObject.CarregarParametros()
149:                 ENDIF
150: 
151:                 THIS.ConfigurarCabecalho()
152:                 THIS.ConfigurarContainerFiltro()
153:                 THIS.ConfigurarAreaSaldo()
154:                 THIS.ConfigurarBotoesAcao()
155: 
156:                 THIS.TornarControlesVisiveis(THIS)
157: 
158:                 *-- Carga inicial da grade. Com o filtro de Grupo vazio o
159:                 *-- sentinela ZYWZYWZYWZ do legado nao casa nada e a grade
160:                 *-- abre VAZIA, de proposito (regra #35a).
161:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
162:                     THIS.CarregarDados()
163:                 ENDIF
164: 
165:                 loc_lSucesso = .T.
166:             ENDIF
167:         CATCH TO loc_oErro
168:             MsgErro(loc_oErro.Message + CHR(13) + ;
169:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
170:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.InicializarForm")
171:         ENDTRY
172: 
173:         RETURN loc_lSucesso
174:     ENDPROC
175: 
176:     *==========================================================================
177:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
178:     * titulo do form duplicado (sombra preta + texto branco por cima)
179:     *==========================================================================
180:     PROTECTED PROCEDURE ConfigurarCabecalho()
181:         LOCAL loc_oCnt
182: 
183:         THIS.AddObject("cnt_4c_Sombra", "Container")
184:         loc_oCnt = THIS.cnt_4c_Sombra
185:         WITH loc_oCnt
186:             .Top         = 0
187:             .Left        = 0
188:             .Width       = THIS.Width
189:             .Height      = 80
190:             .BorderWidth = 0
191:             .BackColor   = RGB(100, 100, 100)
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
196:         WITH loc_oCnt.lbl_4c_Sombra
197:             .FontBold      = .T.
198:             .FontName      = "Tahoma"
199:             .FontSize      = 18
200:             .FontUnderline = .F.
201:             .WordWrap      = .T.
202:             .Alignment     = 0
203:             .BackStyle     = 0
204:             .AutoSize      = .F.
205:             .Caption       = THIS.Caption
206:             .Height        = 40
207:             .Left          = 10
208:             .Top           = 18
209:             .Width         = 769
210:             .ForeColor     = RGB(0, 0, 0)
211:             .Visible       = .T.
212:         ENDWITH
213: 
214:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
215:         WITH loc_oCnt.lbl_4c_Titulo
216:             .FontBold  = .T.
217:             .FontName  = "Tahoma"
218:             .FontSize  = 18
219:             .WordWrap  = .T.
220:             .Alignment = 0

*-- Linhas 241 a 284:
241:     * disso reduziria o valor ao ControlCount corrente (regra do VFP9 que
242:     * limita TabIndex ao numero de controles ja existentes).
243:     *==========================================================================
244:     PROTECTED PROCEDURE ConfigurarContainerFiltro()
245:         THIS.AddObject("cnt_4c_Filtro", "Container")
246:         WITH THIS.cnt_4c_Filtro
247:             .Top         = 106
248:             .Left        = 60
249:             .Width       = 679
250:             .Height      = 132
251:             .BackStyle   = 0
252:             .BorderColor = RGB(90, 90, 90)
253:             .Visible     = .T.
254:         ENDWITH
255: 
256:         THIS.ConfigurarCamposFiltro()
257:         THIS.ConfigurarCamposContraPartida()
258:         THIS.ConfigurarCamposOperacao()
259:         THIS.AjustarTabIndexContainer1()
260:     ENDPROC
261: 
262:     *==========================================================================
263:     * ConfigurarCamposFiltro - Bloco "Filtro" do Container1 legado, transcrito
264:     * objeto a objeto do dump (Top/Left/Width/Height/Font/ForeColor/Format/
265:     * MaxLength). Os Top/Left ficam IGUAIS aos do dump porque sao relativos ao
266:     * Container, que ja esta posicionado em 106,60 - nao ha PageFrame com
267:     * Top = -29 neste form (layout FLAT), logo nao ha compensacao a aplicar.
268:     *
269:     * Mapa legado -> migrado:
270:     *   Label1     "Filtro"  -> lbl_4c_Filtro
271:     *   lbl_grupo  "Grupo :" -> lbl_4c_Grupo
272:     *   Get_Grupo            -> txt_4c_Grupo    (SigCdGcr.codigos char(10))
273:     *   Get_DGrupo           -> txt_4c_DGrupo   (SigCdGcr.descrs  char(40))
274:     *   Say1       "Conta :" -> lbl_4c_Conta
275:     *   Get_Conta            -> txt_4c_Conta    (SigCdCli.iclis   char(10))
276:     *   get_Dconta           -> txt_4c_DConta   (SigCdCli.rclis   char(50))
277:     *
278:     * ForeColor dos rotulos: Label1 declara 255,0,0 EXPLICITO no dump (titulo
279:     * de secao em Verdana 10 bold, igual ao Label4/Label2 do mesmo container);
280:     * lbl_grupo e Say1 declaram 90,90,90, que tambem e o canonico da classe
281:     * say sobre a textura clara do form (regra CLAUDE.md #12). Nenhum deles
282:     * leva branco.
283:     *
284:     * AutoSize: lbl_grupo declara AutoSize = .T. no dump, mas AutoSize e

*-- Linhas 319 a 362:
319:     * final de ConfigurarContainerFiltro(), quando os 16 controles do dump
320:     * (Contra-Partida e Operacao inclusive) ja existem no container.
321:     *==========================================================================
322:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
323:         LOCAL loc_oCnt
324:         loc_oCnt = THIS.cnt_4c_Filtro
325: 
326:         *-- Label1 "Filtro" (titulo da secao)
327:         loc_oCnt.AddObject("lbl_4c_Filtro", "Label")
328:         WITH loc_oCnt.lbl_4c_Filtro
329:             .Top       = 2
330:             .Left      = 3
331:             .Width     = 40
332:             .Height    = 17
333:             .AutoSize  = .F.
334:             .Alignment = 0
335:             .BackStyle = 0
336:             .FontName  = "Verdana"
337:             .FontSize  = 10
338:             .FontBold  = .T.
339:             .ForeColor = RGB(255, 0, 0)
340:             .Caption   = "Filtro"
341:             .Visible   = .T.
342:         ENDWITH
343: 
344:         *-- lbl_grupo "Grupo :"
345:         loc_oCnt.AddObject("lbl_4c_Grupo", "Label")
346:         WITH loc_oCnt.lbl_4c_Grupo
347:             .Top       = 7
348:             .Left      = 83
349:             .Width     = 38
350:             .Height    = 15
351:             .AutoSize  = .F.
352:             .Alignment = 0
353:             .BackStyle = 0
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .ForeColor = RGB(90, 90, 90)
357:             .Caption   = "Grupo :"
358:             .Visible   = .T.
359:         ENDWITH
360: 
361:         *-- Get_Grupo - codigo do Grupo de Contas do filtro (SigCdGcr.codigos)
362:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")

*-- Linhas 448 a 537:
448:             .Visible           = .T.
449:         ENDWITH
450: 
451:         *-- DEPENDENCIA entre os campos (os "Procedure When" do legado, que
452:         *-- bloqueiam o foco enquanto a dependencia nao e satisfeita).
453:         *-- BINDEVENT "When" funciona de forma confiavel em TextBox - ao
454:         *-- contrario de "Valid", que NAO e (regra CLAUDE.md).
455:         BINDEVENT(loc_oCnt.txt_4c_DGrupo, "When", THIS, "DGrupoWhen")
456:         BINDEVENT(loc_oCnt.txt_4c_Conta,  "When", THIS, "ContaWhen")
457:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When", THIS, "DContaWhen")
458: 
459:         *-- O Valid do legado roda ao SAIR do campo; o gancho equivalente e
460:         *-- "LostFocus" (BINDEVENT "Valid" nao e confiavel em TextBox).
461:         BINDEVENT(loc_oCnt.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
462:         BINDEVENT(loc_oCnt.txt_4c_DGrupo, "LostFocus", THIS, "DGrupoLostFocus")
463:         BINDEVENT(loc_oCnt.txt_4c_Conta,  "LostFocus", THIS, "ContaLostFocus")
464:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
465:     ENDPROC
466: 
467:     *==========================================================================
468:     * ConfigurarCamposContraPartida - Bloco "Contra-Partida" do Container1
469:     * legado, transcrito do dump: Label4 (titulo da secao) / Get_GrupoC +
470:     * Get_DgrupoC + Say4 (par Grupo) / Get_contaC + Get_DcontaC + Say5 (par
471:     * Conta). Os quatro getters sao classe fwget (framework.vcx), igual aos
472:     * da fase anterior: Height = 23, Themes = .F., DisabledBackColor/
473:     * DisabledForeColor.
474:     *
475:     * Mapa legado -> migrado:
476:     *   Label4     "Contra-Partida" -> lbl_4c_ContraPartida
477:     *   Say4       "Grupo :"        -> lbl_4c_GrupoC
478:     *   Get_GrupoC                  -> txt_4c_GrupoC   (SigCdGcr.codigos char(10))
479:     *   Get_DgrupoC                 -> txt_4c_DGrupoC  (SigCdGcr.descrs  char(40))
480:     *   Say5       "Conta :"        -> lbl_4c_ContaC
481:     *   Get_contaC                  -> txt_4c_ContaC   (SigCdCli.iclis   char(10))
482:     *   Get_DcontaC                 -> txt_4c_DContaC  (SigCdCli.rclis   char(50))
483:     *
484:     * ForeColor: Label4 declara 255,0,0 (mesmo vermelho de Label1, titulo de
485:     * secao); Say4/Say5 declaram 90,90,90 (classe say sobre a textura clara
486:     * do form, regra CLAUDE.md #12). AutoSize = .T. de Label4 e NO-OP em
487:     * Label por AddObject (regra #23) - fica .F. com Width/Height do dump.
488:     *
489:     * MaxLength (regra #19): Get_GrupoC/Get_contaC usam o default herdado da
490:     * classe fwget (sem MaxLength no dump); Get_DcontaC declara 50, que
491:     * confere com SigCdCli.rclis char(50). Get_DgrupoC nao declara MaxLength
492:     * no dump.
493:     *
494:     * TabIndex: fica para AjustarTabIndexContainer1() - ver comentario em
495:     * ConfigurarContainerFiltro().
496:     *==========================================================================
497:     PROTECTED PROCEDURE ConfigurarCamposContraPartida()
498:         LOCAL loc_oCnt
499:         loc_oCnt = THIS.cnt_4c_Filtro
500: 
501:         *-- Label4 "Contra-Partida" (titulo da secao)
502:         loc_oCnt.AddObject("lbl_4c_ContraPartida", "Label")
503:         WITH loc_oCnt.lbl_4c_ContraPartida
504:             .Top       = 53
505:             .Left      = 2
506:             .Width     = 110
507:             .Height    = 18
508:             .AutoSize  = .F.
509:             .Alignment = 0
510:             .BackStyle = 0
511:             .FontName  = "Verdana"
512:             .FontSize  = 10
513:             .FontBold  = .T.
514:             .ForeColor = RGB(255, 0, 0)
515:             .Caption   = "Contra-Partida"
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- Say4 "Grupo :" (rotulo do par GrupoC/DgrupoC)
520:         loc_oCnt.AddObject("lbl_4c_GrupoC", "Label")
521:         WITH loc_oCnt.lbl_4c_GrupoC
522:             .Top       = 78
523:             .Left      = 83
524:             .Width     = 38
525:             .Height    = 15
526:             .AutoSize  = .F.
527:             .Alignment = 0
528:             .BackStyle = 0
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .ForeColor = RGB(90, 90, 90)
532:             .Caption   = "Grupo :"
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         *-- Get_GrupoC - codigo do Grupo contra-partida (SigCdGcr.codigos)
537:         loc_oCnt.AddObject("txt_4c_GrupoC", "TextBox")

*-- Linhas 622 a 691:
622:             .Visible           = .T.
623:         ENDWITH
624: 
625:         *-- DEPENDENCIA entre os campos (os "Procedure When" do legado).
626:         *-- Get_GrupoC e Get_contaC NAO tem "Procedure When" no dump - ficam
627:         *-- sempre habilitados, sem depender do par Grupo/Conta do Filtro.
628:         BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "When", THIS, "DGrupoCWhen")
629:         BINDEVENT(loc_oCnt.txt_4c_DContaC, "When", THIS, "DContaCWhen")
630: 
631:         *-- O Valid do legado roda ao SAIR do campo (regra LostFocus, como no
632:         *-- bloco Filtro). Nenhum dos quatro chama MontaTela() - a
633:         *-- Contra-Partida nao afeta a consulta da grade de saldos.
634:         BINDEVENT(loc_oCnt.txt_4c_GrupoC,  "LostFocus", THIS, "GrupoCLostFocus")
635:         BINDEVENT(loc_oCnt.txt_4c_DGrupoC, "LostFocus", THIS, "DGrupoCLostFocus")
636:         BINDEVENT(loc_oCnt.txt_4c_ContaC,  "LostFocus", THIS, "ContaCLostFocus")
637:         BINDEVENT(loc_oCnt.txt_4c_DContaC, "LostFocus", THIS, "DContaCLostFocus")
638:     ENDPROC
639: 
640:     *==========================================================================
641:     * ConfigurarCamposOperacao - Bloco "Operacao" do Container1 legado:
642:     * Shape1 (moldura) + Label2 (titulo da secao) + Get_Dope (valor lido de
643:     * SigCdPac.DopZers no Init - this_cOperacao do BO, ja carregado por
644:     * CarregarParametros() antes deste metodo rodar).
645:     *
646:     * Get_Dope.When do legado devolve .F. incondicional: o campo nunca recebe
647:     * foco, e por isso nunca e digitado pelo usuario - e so exibicao do
648:     * parametro do sistema. BackColor 255,255,215 (amarelo palido) e o padrao
649:     * do framework legado para esse tipo de campo informativo.
650:     *==========================================================================
651:     PROTECTED PROCEDURE ConfigurarCamposOperacao()
652:         LOCAL loc_oCnt
653:         loc_oCnt = THIS.cnt_4c_Filtro
654: 
655:         loc_oCnt.AddObject("shp_4c_Operacao", "Shape")
656:         WITH loc_oCnt.shp_4c_Operacao
657:             .Top         = 72
658:             .Left        = 509
659:             .Width       = 166
660:             .Height      = 57
661:             .BackStyle   = 0
662:             .Curvature   = 0
663:             .BorderColor = RGB(90, 90, 90)
664:             .Visible     = .T.
665:         ENDWITH
666: 
667:         *-- Label2 "Operacao" (titulo da secao)
668:         loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
669:         WITH loc_oCnt.lbl_4c_Operacao
670:             .Top       = 78
671:             .Left      = 517
672:             .Width     = 72
673:             .Height    = 18
674:             .AutoSize  = .F.
675:             .Alignment = 0
676:             .BackStyle = 0
677:             .FontName  = "Verdana"
678:             .FontSize  = 10
679:             .FontBold  = .T.
680:             .ForeColor = RGB(255, 0, 0)
681:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         *-- Get_Dope - operacao de movimento de estoque (SigCdPac.DopZers)
686:         loc_oCnt.AddObject("txt_4c_Dope", "TextBox")
687:         WITH loc_oCnt.txt_4c_Dope
688:             .Top       = 99
689:             .Left      = 516
690:             .Width     = 151
691:             .Height    = 23

*-- Linhas 700 a 792:
700:         ENDWITH
701: 
702:         *-- Get_Dope.When devolve .F. incondicional no legado
703:         BINDEVENT(loc_oCnt.txt_4c_Dope, "When", THIS, "DopeWhen")
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * AjustarTabIndexContainer1 - Aplica o TabIndex dos rotulos e dos getters
708:     * de Contra-Partida/Operacao, transcritos do dump (regra CLAUDE.md #
709:     * explicada em ConfigurarCamposFiltro). Roda por ULTIMO, quando os 16
710:     * controles ja existem no container - so assim o VFP9 aceita os valores
711:     * altos (9..16) sem renumerar/limitar.
712:     *==========================================================================
713:     PROTECTED PROCEDURE AjustarTabIndexContainer1()
714:         LOCAL loc_oCnt
715:         loc_oCnt = THIS.cnt_4c_Filtro
716: 
717:         loc_oCnt.txt_4c_GrupoC.TabIndex         = 5
718:         loc_oCnt.txt_4c_DGrupoC.TabIndex        = 6
719:         loc_oCnt.txt_4c_ContaC.TabIndex         = 7
720:         loc_oCnt.txt_4c_DContaC.TabIndex        = 8
721:         loc_oCnt.lbl_4c_Grupo.TabIndex          = 9
722:         loc_oCnt.lbl_4c_Filtro.TabIndex         = 10
723:         loc_oCnt.lbl_4c_ContraPartida.TabIndex  = 11
724:         loc_oCnt.txt_4c_Dope.TabIndex           = 12
725:         loc_oCnt.lbl_4c_GrupoC.TabIndex         = 13
726:         loc_oCnt.lbl_4c_ContaC.TabIndex         = 14
727:         loc_oCnt.lbl_4c_Conta.TabIndex          = 15
728:         loc_oCnt.lbl_4c_Operacao.TabIndex       = 16
729:     ENDPROC
730: 
731:     *==========================================================================
732:     * DGrupoWhen / ContaWhen / DContaWhen - equivalentes aos "Procedure When"
733:     * do legado, transcritos um a um:
734:     *
735:     *   Get_DGrupo.When  -> IsEmpty(Get_Grupo.Value)
736:     *   Get_Conta.When   -> Not IsEmpty(Get_Grupo.Value)
737:     *   get_Dconta.When  -> IsEmpty(Get_Conta.Value) And
738:     *                       Not IsEmpty(Get_Grupo.Value)
739:     *
740:     * Isto e, cada par codigo/descricao aceita digitacao por UM lado so, e a
741:     * Conta so abre depois que o Grupo esta preenchido.
742:     *
743:     * DGrupoCWhen / DContaCWhen seguem o mesmo padrao para a Contra-Partida -
744:     * Get_GrupoC e Get_contaC NAO tem When no dump (sempre habilitados):
745:     *
746:     *   Get_DgrupoC.When -> IsEmpty(Get_GrupoC.Value)
747:     *   Get_DcontaC.When -> IsEmpty(Get_ContaC.Value)
748:     *
749:     * DopeWhen e o Get_Dope.When do legado - devolve .F. incondicional, o
750:     * campo nunca recebe foco (e so exibicao do parametro do sistema).
751:     *
752:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
753:     *==========================================================================
754:     FUNCTION DGrupoWhen()
755:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
756:     ENDFUNC
757: 
758:     FUNCTION ContaWhen()
759:         RETURN !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
760:     ENDFUNC
761: 
762:     FUNCTION DContaWhen()
763:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)) AND ;
764:                !EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value))
765:     ENDFUNC
766: 
767:     FUNCTION DGrupoCWhen()
768:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value))
769:     ENDFUNC
770: 
771:     FUNCTION DContaCWhen()
772:         RETURN EMPTY(ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value))
773:     ENDFUNC
774: 
775:     FUNCTION DopeWhen()
776:         RETURN .F.
777:     ENDFUNC
778: 
779:     *==========================================================================
780:     * ResolverCodigoDescricao - Substitui fAcessoContab()/fAcessoContas() na
781:     * resolucao codigo <-> descricao dos quatro pares de campos deste form
782:     * (Grupo/DGrupo, GrupoC/DgrupoC, Conta/DConta, ContaC/DContaC).
783:     *
784:     * As duas funcoes legado (utils\functions.prg) reexibem o picker
785:     * FormBuscaSimples e, ao fechar, leem o REGISTRO CORRENTE do cursor de
786:     * apoio para preencher o par - sem distinguir "usuario selecionou" de
787:     * "usuario cancelou o dialogo". E exatamente o defeito que a memoria do
788:     * projeto documenta para fAcessoContas em lookup de UI (auto-preenche com
789:     * o 1o registro do cursor ao cancelar). Aqui, em troca, busca-se o valor
790:     * EXATO primeiro; so na falta dele abre-se THIS.AbrirLookupCanonico()
791:     * (herdado de FormBase), que SO atribui quando o usuario confirma a
792:     * escolha (this_lSelecionou) - nunca apaga o que foi digitado (regra

*-- Linhas 798 a 844:
798:     * exclusividade e garantida pelos When acima, que so liberam o campo de
799:     * descricao quando o de codigo esta vazio.
800:     *
801:     * PROTECTED: nenhum BINDEVENT aponta direto para este metodo (so para os
802:     * *LostFocus que o chamam).
803:     *==========================================================================
804:     PROTECTED PROCEDURE ResolverCodigoDescricao(par_oTxtCod, par_oTxtDesc, ;
805:             par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
806:         LOCAL loc_cCod, loc_cDesc, loc_cCursor, loc_cSQL, loc_nResult, loc_oErro
807:         loc_cCursor = "cursor_4c_ResolverCodDesc"
808: 
809:         TRY
810:             loc_cCod  = ALLTRIM(par_oTxtCod.Value)
811:             loc_cDesc = ALLTRIM(par_oTxtDesc.Value)
812: 
813:             IF !EMPTY(loc_cCod)
814:                 IF USED(loc_cCursor)
815:                     USE IN (loc_cCursor)
816:                 ENDIF
817: 
818:                 loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
819:                     " FROM " + par_cTabela + ;
820:                     " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cCod) + ;
821:                     IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
822:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
823: 
824:                 IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
825:                     SELECT (loc_cCursor)
826:                     par_oTxtDesc.Value = ALLTRIM(Descs)
827:                 ELSE
828:                     THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
829:                         par_cTitulo, loc_cCod, par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
830:                 ENDIF
831: 
832:                 IF USED(loc_cCursor)
833:                     USE IN (loc_cCursor)
834:                 ENDIF
835:             ELSE
836:                 IF !EMPTY(loc_cDesc)
837:                     IF USED(loc_cCursor)
838:                         USE IN (loc_cCursor)
839:                     ENDIF
840: 
841:                     loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + par_cCampoDesc + " AS Descs" + ;
842:                         " FROM " + par_cTabela + ;
843:                         " WHERE " + par_cCampoDesc + " = " + EscaparSQL(loc_cDesc) + ;
844:                         IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")

*-- Linhas 860 a 1327:
860:         CATCH TO loc_oErro
861:             MsgErro(loc_oErro.Message + CHR(13) + ;
862:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
863:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.ResolverCodigoDescricao")
864:         ENDTRY
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * AbrirLookupGrupo / AbrirLookupConta / AbrirLookupGrupoC / AbrirLookupContaC
869:     * - FUNIL de lookup dos quatro pares codigo/descricao do form. Um metodo
870:     * por PAR (nao por campo): no legado o mesmo fAcessoContab/fAcessoContas
871:     * atende o Valid do codigo E o da descricao, decidindo pelo argumento
872:     * 'C'/'D'; aqui quem decide e ResolverCodigoDescricao, olhando qual dos
873:     * dois TextBox do par esta preenchido.
874:     *
875:     * Tabelas e colunas transcritas do legado (NUNCA adivinhadas):
876:     *   fAcessoContab -> SigCdGcr (codigos / descrs)  - grupos contabeis
877:     *   fAcessoContas -> SigCdCli (iclis  / rclis )   - contas correntes,
878:     *                    restritas ao grupo do bloco (pGrp do legado)
879:     *
880:     * A guarda this_lEmLookup mora AQUI, no funil, e nao em cada LostFocus:
881:     * assim cobre tambem qualquer outra entrada futura (F3/DblClick) com uma
882:     * unica trava. Como ResolverCodigoDescricao envolve todo o corpo em
883:     * TRY/CATCH e nao tem RETURN antecipado, a linha que libera a flag roda
884:     * sempre - inclusive quando o CATCH dispara (regra CLAUDE.md #47).
885:     *
886:     * PUBLIC (sem PROTECTED): sao chamados pelos *LostFocus e podem ser
887:     * acionados de FORA da classe (harness de teste) - regra CLAUDE.md #3/#51.
888:     *==========================================================================
889:     PROCEDURE AbrirLookupGrupo()
890:         IF THIS.this_lEmLookup
891:             RETURN
892:         ENDIF
893:         THIS.this_lEmLookup = .T.
894:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Grupo, ;
895:             THIS.cnt_4c_Filtro.txt_4c_DGrupo, ;
896:             "SigCdGcr", "codigos", "descrs", ;
897:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
898:         THIS.this_lEmLookup = .F.
899:     ENDPROC
900: 
901:     PROCEDURE AbrirLookupConta()
902:         IF THIS.this_lEmLookup
903:             RETURN
904:         ENDIF
905:         THIS.this_lEmLookup = .T.
906:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_Conta, ;
907:             THIS.cnt_4c_Filtro.txt_4c_DConta, ;
908:             "SigCdCli", "iclis", "rclis", ;
909:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
910:             THIS.FiltroGrupoParaConta())
911:         THIS.this_lEmLookup = .F.
912:     ENDPROC
913: 
914:     PROCEDURE AbrirLookupGrupoC()
915:         IF THIS.this_lEmLookup
916:             RETURN
917:         ENDIF
918:         THIS.this_lEmLookup = .T.
919:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_GrupoC, ;
920:             THIS.cnt_4c_Filtro.txt_4c_DGrupoC, ;
921:             "SigCdGcr", "codigos", "descrs", ;
922:             "Sele" + CHR(231) + CHR(227) + "o de Grupo (Contra-Partida)", "")
923:         THIS.this_lEmLookup = .F.
924:     ENDPROC
925: 
926:     PROCEDURE AbrirLookupContaC()
927:         IF THIS.this_lEmLookup
928:             RETURN
929:         ENDIF
930:         THIS.this_lEmLookup = .T.
931:         THIS.ResolverCodigoDescricao(THIS.cnt_4c_Filtro.txt_4c_ContaC, ;
932:             THIS.cnt_4c_Filtro.txt_4c_DContaC, ;
933:             "SigCdCli", "iclis", "rclis", ;
934:             "Sele" + CHR(231) + CHR(227) + "o de Conta (Contra-Partida)", ;
935:             THIS.FiltroGrupoCParaConta())
936:         THIS.this_lEmLookup = .F.
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * GrupoLostFocus / DGrupoLostFocus / ContaLostFocus / DContaLostFocus -
941:     * o que o Valid do legado faz ao sair de cada campo do Filtro:
942:     *
943:     *   Get_Grupo.Valid  -> fAcessoContab('C',...) / lcGrupo = This.Value /
944:     *                       ThisForm.MontaTela() / Refreshes
945:     *   Get_DGrupo.Valid -> fAcessoContab('D',...) / ThisForm.MontaTela()
946:     *   Get_Conta.Valid  -> fAcessoContas('C',...) / ThisForm.MontaTela()
947:     *   get_Dconta.Valid -> fAcessoContas('D',...) / ThisForm.MontaTela()
948:     *
949:     * O lookup fica no funil THIS.AbrirLookup<X>() (ver comentario acima), que
950:     * substitui as chamadas a fAcessoContab/fAcessoContas. O MontaTela() esta
951:     * no funil UNICO AplicarFiltro, que repassa o filtro ao BO e chama
952:     * CarregarDados.
953:     *
954:     * O IF de reentrancia aqui, alem do que ja existe no AbrirLookup<X>,
955:     * suprime tambem o AplicarFiltro() quando o LostFocus redispara com o
956:     * picker modal aberto - recarregar a grade por baixo do dialogo nao e o
957:     * que o legado faz.
958:     *
959:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
960:     *==========================================================================
961:     PROCEDURE GrupoLostFocus()
962:         LOCAL loc_cValor
963:         IF THIS.this_lEmLookup
964:             RETURN
965:         ENDIF
966:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
967:         IF loc_cValor == THIS.this_cUltimoGrupoLostFocusValidado
968:             RETURN
969:         ENDIF
970:         THIS.AbrirLookupGrupo()
971:         THIS.AplicarFiltro()
972:         THIS.this_cUltimoGrupoLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
973:     ENDPROC
974: 
975:     PROCEDURE DGrupoLostFocus()
976:         LOCAL loc_cValor
977:         IF THIS.this_lEmLookup
978:             RETURN
979:         ENDIF
980:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
981:         IF loc_cValor == THIS.this_cUltimoDGrupoLostFocusValidado
982:             RETURN
983:         ENDIF
984:         THIS.AbrirLookupGrupo()
985:         THIS.AplicarFiltro()
986:         THIS.this_cUltimoDGrupoLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
987:     ENDPROC
988: 
989:     PROCEDURE ContaLostFocus()
990:         LOCAL loc_cValor
991:         IF THIS.this_lEmLookup
992:             RETURN
993:         ENDIF
994:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
995:         IF loc_cValor == THIS.this_cUltimoContaLostFocusValidado
996:             RETURN
997:         ENDIF
998:         THIS.AbrirLookupConta()
999:         THIS.AplicarFiltro()
1000:         THIS.this_cUltimoContaLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
1001:     ENDPROC
1002: 
1003:     PROCEDURE DContaLostFocus()
1004:         LOCAL loc_cValor
1005:         IF THIS.this_lEmLookup
1006:             RETURN
1007:         ENDIF
1008:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
1009:         IF loc_cValor == THIS.this_cUltimoDContaLostFocusValidado
1010:             RETURN
1011:         ENDIF
1012:         THIS.AbrirLookupConta()
1013:         THIS.AplicarFiltro()
1014:         THIS.this_cUltimoDContaLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
1015:     ENDPROC
1016: 
1017:     *==========================================================================
1018:     * FiltroGrupoParaConta - expressao "grupos = '<Grupo>'" usada como
1019:     * par_cFiltroExtra de ResolverCodigoDescricao() para a Conta do Filtro -
1020:     * equivalente ao "grupo" lido no inicio de Get_Conta.Valid/get_Dconta.Valid
1021:     * do legado (ThisForm.Container1.Get_Grupo.Value), que fAcessoContas
1022:     * usava para restringir a busca ao grupo do filtro.
1023:     *==========================================================================
1024:     PROTECTED PROCEDURE FiltroGrupoParaConta()
1025:         LOCAL loc_cGrupo
1026:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1027:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * GrupoCLostFocus / DGrupoCLostFocus / ContaCLostFocus / DContaCLostFocus
1032:     * - o que o Valid do legado faz ao sair de cada campo da Contra-Partida:
1033:     *
1034:     *   Get_GrupoC.Valid  -> fAcessoContab('C',...) / sem MontaTela()
1035:     *   Get_DgrupoC.Valid -> fAcessoContab('D',...) / sem MontaTela()
1036:     *   Get_contaC.Valid  -> fAcessoContas('C', Get_GrupoC.Value, ...) / sem MontaTela()
1037:     *   Get_DcontaC.Valid -> fAcessoContas('D', Get_GrupoC.Value, ...) / sem MontaTela()
1038:     *
1039:     * Nenhum dos quatro recarrega a grade - a Contra-Partida nao faz parte do
1040:     * filtro de saldos, so e usada no Processar (fase 7/8).
1041:     *
1042:     * O lookup fica no funil THIS.AbrirLookupGrupoC()/AbrirLookupContaC(),
1043:     * que ja carrega a guarda de reentrancia do picker modal.
1044:     *
1045:     * PUBLIC (sem PROTECTED) porque sao alvo de BINDEVENT - regra CLAUDE.md #3.
1046:     *==========================================================================
1047:     PROCEDURE GrupoCLostFocus()
1048:         LOCAL loc_cValor
1049:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1050:         IF loc_cValor == THIS.this_cUltimoGrupoCLostFocusValidado
1051:             RETURN
1052:         ENDIF
1053:         THIS.AbrirLookupGrupoC()
1054:         THIS.this_cUltimoGrupoCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1055:     ENDPROC
1056: 
1057:     PROCEDURE DGrupoCLostFocus()
1058:         LOCAL loc_cValor
1059:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupoC.Value)
1060:         IF loc_cValor == THIS.this_cUltimoDGrupoCLostFocusValidado
1061:             RETURN
1062:         ENDIF
1063:         THIS.AbrirLookupGrupoC()
1064:         THIS.this_cUltimoDGrupoCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupoC.Value)
1065:     ENDPROC
1066: 
1067:     PROCEDURE ContaCLostFocus()
1068:         LOCAL loc_cValor
1069:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
1070:         IF loc_cValor == THIS.this_cUltimoContaCLostFocusValidado
1071:             RETURN
1072:         ENDIF
1073:         THIS.AbrirLookupContaC()
1074:         THIS.this_cUltimoContaCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
1075:     ENDPROC
1076: 
1077:     PROCEDURE DContaCLostFocus()
1078:         LOCAL loc_cValor
1079:         loc_cValor = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DContaC.Value)
1080:         IF loc_cValor == THIS.this_cUltimoDContaCLostFocusValidado
1081:             RETURN
1082:         ENDIF
1083:         THIS.AbrirLookupContaC()
1084:         THIS.this_cUltimoDContaCLostFocusValidado = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DContaC.Value)
1085:     ENDPROC
1086: 
1087:     *==========================================================================
1088:     * FiltroGrupoCParaConta - mesma ideia de FiltroGrupoParaConta(), mas para
1089:     * a Conta da Contra-Partida: o legado usa Get_GrupoC.Value (nao
1090:     * Get_Grupo.Value) como grupo de referencia em Get_contaC.Valid/
1091:     * Get_DcontaC.Valid.
1092:     *==========================================================================
1093:     PROTECTED PROCEDURE FiltroGrupoCParaConta()
1094:         LOCAL loc_cGrupo
1095:         loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1096:         RETURN IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
1097:     ENDPROC
1098: 
1099:     *==========================================================================
1100:     * AplicarFiltro - funil UNICO do MontaTela() legado no que diz respeito ao
1101:     * filtro: le os dois codigos digitados, guarda-os no BO (de onde o
1102:     * CarregarSaldos monta o WHERE a.grupos / a.contas) e recarrega a grade.
1103:     *
1104:     * So recarrega quando o par Grupo/Conta MUDOU em relacao ao que o BO ja
1105:     * tem: mesma consulta devolveria o mesmo resultado, e o LostFocus dispara
1106:     * a cada saida de campo, inclusive em Tab de passagem. A semantica do
1107:     * legado e preservada - o que muda e so a consulta repetida.
1108:     *
1109:     * O ALLTRIM aqui e no par descricao e seguro porque o WHERE compara
1110:     * coluna char com literal (blank-padding ANSI do SQL Server); nao e chave
1111:     * posicional concatenada (regra CLAUDE.md #42).
1112:     *
1113:     * PUBLIC (sem PROTECTED) porque e chamado dos handlers de BINDEVENT e pelo
1114:     * harness de teste, de FORA da classe - regra CLAUDE.md #3.
1115:     *==========================================================================
1116:     PROCEDURE AplicarFiltro()
1117:         LOCAL loc_cGrupo, loc_cConta, loc_oErro
1118: 
1119:         TRY
1120:             loc_cGrupo = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1121:             loc_cConta = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Conta.Value)
1122: 
1123:             IF loc_cGrupo == ALLTRIM(THIS.this_oBusinessObject.this_cGrupoFiltro) AND ;
1124:                loc_cConta == ALLTRIM(THIS.this_oBusinessObject.this_cContaFiltro)
1125:                 *-- Filtro inalterado: a grade ja reflete esta consulta
1126:             ELSE
1127:                 THIS.this_oBusinessObject.this_cGrupoFiltro = loc_cGrupo
1128:                 THIS.this_oBusinessObject.this_cContaFiltro = loc_cConta
1129: 
1130:                 THIS.this_oBusinessObject.this_cDescGrupoFiltro = ;
1131:                     ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DGrupo.Value)
1132:                 THIS.this_oBusinessObject.this_cDescContaFiltro = ;
1133:                     ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_DConta.Value)
1134: 
1135:                 THIS.CarregarDados()
1136:             ENDIF
1137:         CATCH TO loc_oErro
1138:             MsgErro(loc_oErro.Message + CHR(13) + ;
1139:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1140:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.AplicarFiltro")
1141:         ENDTRY
1142:     ENDPROC
1143: 
1144:     *==========================================================================
1145:     * LimparFiltro - "Procedure iniciar" legado completo, que zera os OITO
1146:     * campos do Filtro e da Contra-Partida:
1147:     *
1148:     *   With ThisForm.Container1
1149:     *       .Get_GrupoC.Value = ' ' / .Get_grupo.Value = ' '
1150:     *       .Get_DgrupoC.Value = ' ' / .Get_DGrupo.Value = ' '
1151:     *       .Get_DcontaC.Value = ' ' / .get_dconta.Value = ' '
1152:     *       .Get_contaC.Value = ' ' / .Get_conta.Value = ' '
1153:     *   EndWith
1154:     *   ThisForm.MontaTela()
1155:     *
1156:     * O legado usa um ESPACO, nao string vazia; aqui fica "" porque todos os
1157:     * campos passam por ALLTRIM em todo consumidor (AplicarFiltro, os When e o
1158:     * CarregarSaldos do BO), e o espaco solo so existia para o Empty() legado
1159:     * dar verdadeiro - resultado identico. Get_Dope NAO entra aqui: o legado
1160:     * "iniciar" nao o zera (e so exibicao do parametro do sistema).
1161:     *
1162:     * Zera tambem os pares guardados no BO, senao a guarda de "filtro
1163:     * inalterado" do AplicarFiltro impediria a recarga.
1164:     *
1165:     * PUBLIC (sem PROTECTED): e o encerramento do Processar e o harness de
1166:     * teste o chama de FORA da classe - regra CLAUDE.md #3.
1167:     *==========================================================================
1168:     PROCEDURE LimparFiltro()
1169:         LOCAL loc_oErro
1170: 
1171:         TRY
1172:             WITH THIS.cnt_4c_Filtro
1173:                 .txt_4c_Grupo.Value   = ""
1174:                 .txt_4c_DGrupo.Value  = ""
1175:                 .txt_4c_Conta.Value   = ""
1176:                 .txt_4c_DConta.Value  = ""
1177:                 .txt_4c_GrupoC.Value  = ""
1178:                 .txt_4c_DGrupoC.Value = ""
1179:                 .txt_4c_ContaC.Value  = ""
1180:                 .txt_4c_DContaC.Value = ""
1181:             ENDWITH
1182: 
1183:             THIS.this_oBusinessObject.this_cGrupoFiltro     = ""
1184:             THIS.this_oBusinessObject.this_cDescGrupoFiltro = ""
1185:             THIS.this_oBusinessObject.this_cContaFiltro     = ""
1186:             THIS.this_oBusinessObject.this_cDescContaFiltro = ""
1187:             THIS.this_oBusinessObject.this_cGrupoContra     = ""
1188:             THIS.this_oBusinessObject.this_cDescGrupoContra = ""
1189:             THIS.this_oBusinessObject.this_cContaContra     = ""
1190:             THIS.this_oBusinessObject.this_cDescContaContra = ""
1191: 
1192:             *-- Reseta as guardas de "valor nao mudou" dos LostFocus - senao
1193:             *-- redigitar o MESMO codigo depois de limpar ficaria sem validar
1194:             *-- (guarda comparando contra o valor antigo, nao contra o atual).
1195:             THIS.this_cUltimoGrupoLostFocusValidado   = ""
1196:             THIS.this_cUltimoDGrupoLostFocusValidado  = ""
1197:             THIS.this_cUltimoContaLostFocusValidado   = ""
1198:             THIS.this_cUltimoDContaLostFocusValidado  = ""
1199:             THIS.this_cUltimoGrupoCLostFocusValidado  = ""
1200:             THIS.this_cUltimoDGrupoCLostFocusValidado = ""
1201:             THIS.this_cUltimoContaCLostFocusValidado  = ""
1202:             THIS.this_cUltimoDContaCLostFocusValidado = ""
1203: 
1204:             THIS.CarregarDados()
1205:         CATCH TO loc_oErro
1206:             MsgErro(loc_oErro.Message + CHR(13) + ;
1207:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1208:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.LimparFiltro")
1209:         ENDTRY
1210:     ENDPROC
1211: 
1212:     *==========================================================================
1213:     * ConfigurarAreaSaldo - Moldura, rotulo e grade da area de saldos
1214:     * (shp_saldo + lbl_saldo + grd_saldo do legado). Cria tambem, via
1215:     * CriarCursorSaldosPlaceholder, o cursor vazio com a MESMA estrutura que a
1216:     * carga via SQL vai usar mais adiante (SigMvSlc + SigCdCli no MontaTela
1217:     * legado), para o Grid ja nascer ligado - regra "cursor placeholder =
1218:     * cursor real" do CLAUDE.md.
1219:     *==========================================================================
1220:     PROTECTED PROCEDURE ConfigurarAreaSaldo()
1221:         THIS.AddObject("shp_4c_Saldo", "Shape")
1222:         WITH THIS.shp_4c_Saldo
1223:             .Top         = 262
1224:             .Left        = 81
1225:             .Width       = 613
1226:             .Height      = 254
1227:             .BackStyle   = 0
1228:             .Curvature   = 0
1229:             .BorderColor = RGB(90, 90, 90)
1230:             .Visible     = .T.
1231:         ENDWITH
1232: 
1233:         THIS.AddObject("lbl_4c_Saldo", "Label")
1234:         WITH THIS.lbl_4c_Saldo
1235:             .AutoSize  = .T.
1236:             .FontBold  = .T.
1237:             .FontName  = "Tahoma"
1238:             .FontSize  = 8
1239:             .BackStyle = 0
1240:             .Caption   = " Contas / Saldos "
1241:             .Top       = 248
1242:             .Left      = 90
1243:             .ForeColor = RGB(90, 90, 90)
1244:             .Visible   = .T.
1245:         ENDWITH
1246: 
1247:         THIS.CriarCursorSaldosPlaceholder()
1248:         THIS.ConfigurarGridSaldo()
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * CriarCursorSaldosPlaceholder - Cursor vazio com a mesma estrutura que a
1253:     * carga por SQL vai popular depois (equivalente ao
1254:     * Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
1255:     * b.Situas, 0 as Flag, 0 as Marcas do MontaTela() legado, sobre
1256:     * SigMvSlc/SigCdCli). Indices iguais aos do legado (Index On Rclis /
1257:     * Index On Contas), que o Ingrid1 das colunas 1/2 usava para busca
1258:     * incremental.
1259:     *==========================================================================
1260:     PROTECTED PROCEDURE CriarCursorSaldosPlaceholder()
1261:         LOCAL loc_cCursor
1262:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1263: 
1264:         IF USED(loc_cCursor)
1265:             USE IN (loc_cCursor)
1266:         ENDIF
1267: 
1268:         SET NULL ON
1269:         CREATE CURSOR (loc_cCursor) ;
1270:             (emps C(3), grupos C(10), contas C(10), moedas C(3), ;
1271:              saldos N(13,2), rclis C(50), situas C(3), flag N(1,0), marcas N(1,0))
1272:         SET NULL OFF
1273: 
1274:         SELECT (loc_cCursor)
1275:         INDEX ON contas TAG Contas
1276:         INDEX ON rclis TAG Rclis
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * ConfigurarGridSaldo - grd_saldo do legado: Conta/Descricao/Moeda/Saldo
1281:     * mais a coluna de marcacao (Column5.Check1 do dump, ligada direto a
1282:     * Marcas - sem handler extra, o proprio binding da Column grava no
1283:     * cursor ao clicar, igual ao legado). DynamicBackColor verde claro
1284:     * destaca a linha ja processada (Flag = 1), igual ao SetAll do
1285:     * MontaTela().
1286:     *==========================================================================
1287:     PROTECTED PROCEDURE ConfigurarGridSaldo()
1288:         LOCAL loc_cCursor
1289:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1290: 
1291:         THIS.AddObject("grd_4c_Dados", "Grid")
1292: 
1293:         *-- ColumnCount/RecordSource FORA do WITH (regra CLAUDE.md #41): com
1294:         *-- os dois dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
1295:         *-- recriou as colunas no instante em que .Column1 e referenciado, e
1296:         *-- estoura "Unknown member COLUMN1". Atribuir por referencia explicita
1297:         *-- ANTES do WITH garante que as colunas ja existem quando o bloco
1298:         *-- abaixo as configura.
1299:         THIS.grd_4c_Dados.ColumnCount  = 5
1300:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
1301: 
1302:         WITH THIS.grd_4c_Dados
1303:             .Top           = 268
1304:             .Left          = 87
1305:             .Width         = 601
1306:             .Height        = 244
1307:             .FontName      = "Tahoma"
1308:             .FontSize      = 8
1309:             .DeleteMark    = .F.
1310:             .RecordMark    = .F.
1311:             .RowHeight     = 16
1312:             .ScrollBars    = 2
1313:             .GridLineColor = RGB(238, 238, 238)
1314: 
1315:             .Column1.ControlSource     = loc_cCursor + ".contas"
1316:             .Column1.Width             = 80
1317:             .Column1.Movable           = .F.
1318:             .Column1.Resizable         = .F.
1319:             .Column1.ReadOnly          = .T.
1320:             .Column1.Header1.Caption   = "Conta"
1321:             .Column1.Header1.Alignment = 2
1322: 
1323:             .Column2.ControlSource     = loc_cCursor + ".rclis"
1324:             .Column2.Width             = 320
1325:             .Column2.Movable           = .F.
1326:             .Column2.Resizable         = .F.
1327:             .Column2.ReadOnly          = .T.

*-- Linhas 1372 a 1415:
1372:     * para um CommandButton avulso, seguindo o padrao ja usado em outros
1373:     * forms OPERACIONAIS do projeto (ex.: FormDCC.cmd_4c_Encerrar).
1374:     *==========================================================================
1375:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1376:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1377:         WITH THIS.cmd_4c_SelTudo
1378:             .Top         = 519
1379:             .Left        = 90
1380:             .Width       = 40
1381:             .Height      = 40
1382:             .Caption     = ""
1383:             .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
1384:             .ToolTipText = "Seleciona tudo"
1385:             .FontName    = "Verdana"
1386:             .FontSize    = 8
1387:             .ForeColor   = RGB(36, 84, 155)
1388:             .BackColor   = RGB(255, 255, 255)
1389:             .Themes      = .T.
1390:             .Visible     = .T.
1391:         ENDWITH
1392: 
1393:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1394:         WITH THIS.cmd_4c_Apaga
1395:             .Top         = 519
1396:             .Left        = 132
1397:             .Width       = 40
1398:             .Height      = 40
1399:             .Caption     = ""
1400:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1401:             .ToolTipText = "Desmarca tudo"
1402:             .FontName    = "Verdana"
1403:             .FontSize    = 8
1404:             .ForeColor   = RGB(36, 84, 155)
1405:             .BackColor   = RGB(255, 255, 255)
1406:             .Themes      = .T.
1407:             .Visible     = .T.
1408:         ENDWITH
1409: 
1410:         THIS.AddObject("cmd_4c_CmdProcessa", "CommandButton")
1411:         WITH THIS.cmd_4c_CmdProcessa
1412:             .Top             = 3
1413:             .Left            = 650
1414:             .Width           = 75
1415:             .Height          = 75

*-- Linhas 1455 a 1708:
1455:             .Visible         = .T.
1456:         ENDWITH
1457: 
1458:         BINDEVENT(THIS.cmd_4c_SelTudo,     "Click", THIS, "BtnSelTudoClick")
1459:         BINDEVENT(THIS.cmd_4c_Apaga,       "Click", THIS, "BtnApagaClick")
1460:         BINDEVENT(THIS.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarClick")
1461:         BINDEVENT(THIS.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * CarregarDados - MontaTela() do legado: recarrega a grade de saldos a
1466:     * partir do filtro corrente (Grupo / Conta, guardados no BO) e habilita o
1467:     * Processar so quando ha linha para processar.
1468:     *
1469:     * Funil UNICO de recarga da grade. O legado chama MontaTela() em todo
1470:     * ponto que muda o filtro (Get_Grupo.Valid, Get_Conta.Valid,
1471:     * Get_DGrupo.Valid, get_Dconta.Valid e o limpa-campos); as fases
1472:     * seguintes, que criam esses campos, chamam ESTE metodo - nunca repetem a
1473:     * consulta.
1474:     *
1475:     * O cursor da grade NAO e fechado nem reaberto: o BO recarrega por
1476:     * ZAP + APPEND FROM DBF(), entao RecordSource, ControlSource, Width,
1477:     * Header, DynamicBackColor e o Check1 da Column5 sobrevivem - por isso
1478:     * aqui nao se repete o rebind que o legado faz no fim do MontaTela()
1479:     * (ele rebinda porque FECHA e RECRIA o cursor; refazer o bind aqui
1480:     * destruiria o Check1 posto por AddObject - regra #18/#41).
1481:     *
1482:     * O GO TOP + Refresh e obrigatorio: popular o cursor NAO repinta a grade
1483:     * (regra #21a) - sem ele a grade fica visualmente vazia com o cursor
1484:     * cheio, e o sintoma ("a tela nao traz dados") manda o diagnostico para
1485:     * SQL/permissao.
1486:     *
1487:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os
1488:     * metodos de carga direto no objeto do form, de FORA da classe (regra #3).
1489:     *==========================================================================
1490:     PROCEDURE CarregarDados()
1491:         LOCAL loc_cCursor, loc_nLinhas, loc_lSucesso, loc_oErro
1492:         loc_lSucesso = .F.
1493: 
1494:         TRY
1495:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldos
1496: 
1497:             IF !USED(loc_cCursor)
1498:                 THIS.CriarCursorSaldosPlaceholder()
1499:             ENDIF
1500: 
1501:             loc_lSucesso = THIS.this_oBusinessObject.CarregarSaldos()
1502: 
1503:             loc_nLinhas = 0
1504:             IF USED(loc_cCursor)
1505:                 loc_nLinhas = RECCOUNT(loc_cCursor)
1506:                 SELECT (loc_cCursor)
1507:                 GO TOP
1508:             ENDIF
1509: 
1510:             *-- MontaTela(): If Reccount('CrSigMvSlc') > 0 /
1511:             *-- CmdProcessa.Enabled = .t. / Else / .Enabled = .f. / EndIf
1512:             THIS.cmd_4c_CmdProcessa.Enabled = (loc_nLinhas > 0)
1513: 
1514:             THIS.grd_4c_Dados.Refresh()
1515:         CATCH TO loc_oErro
1516:             MsgErro(loc_oErro.Message + CHR(13) + ;
1517:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1518:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnc.CarregarDados")
1519:         ENDTRY
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * BtnSelTudoClick - Marca todas as linhas da grade (equivalente a
1526:     * Update CrSigMvSlc Set Marcas = 1 do legado)
1527:     *==========================================================================
1528:     PROCEDURE BtnSelTudoClick()
1529:         LOCAL loc_oErro
1530: 
1531:         TRY
1532:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1533:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 1
1534:                 THIS.grd_4c_Dados.Refresh()
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1538:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSelTudoClick")
1539:         ENDTRY
1540:     ENDPROC
1541: 
1542:     *==========================================================================
1543:     * BtnApagaClick - Desmarca todas as linhas da grade (equivalente a
1544:     * Update CrSigMvSlc Set Marcas = 0 do legado)
1545:     *==========================================================================
1546:     PROCEDURE BtnApagaClick()
1547:         LOCAL loc_oErro
1548: 
1549:         TRY
1550:             IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1551:                 UPDATE (THIS.this_oBusinessObject.this_cCursorSaldos) SET marcas = 0
1552:                 THIS.grd_4c_Dados.Refresh()
1553:             ENDIF
1554:         CATCH TO loc_oErro
1555:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1556:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
1557:         ENDTRY
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * BtnProcessarClick - cmdProcessa.Click do legado: os 4 guards do topo
1562:     * (With ThisForm.Container1 / If Empty(...) / MessageBox / Return 0),
1563:     * depois a checagem "Nenhuma Conta Selecionada" (Select CrSigMvSlc /
1564:     * Count To x For Marcas = 1) e, so entao, o SCAN que gera os dois
1565:     * lancamentos de encerramento por conta marcada - delegado a
1566:     * THIS.this_oBusinessObject.ProcessarEncerramento(), que concentra o que
1567:     * no legado era FazContra/fGerUniqueKey/fBuscarCotacao/fRecalculaS e o
1568:     * Update/Commit/RollBack de ThisForm.poDataMgr.
1569:     *
1570:     * Os 4 guards ficam no FORM (lem textbox, nao property de BO) - mesmas
1571:     * mensagens do legado, na mesma ordem. Guardados numa unica variavel
1572:     * (loc_cErro) em vez de 4 IFs encaixados, para nao passar de 3 niveis de
1573:     * aninhamento (regra de legibilidade; a ordem de avaliacao e idêntica aos
1574:     * 4 "If Empty(...) / Return 0" sequenciais do legado).
1575:     *
1576:     * Sucesso encerra igual ao legado (ThisForm.Iniciar() no fim do Click):
1577:     * THIS.LimparFiltro() zera os 8 campos do Container1 e recarrega a grade
1578:     * (que fica vazia, porque o sentinela de grupo vazio nao casa nada -
1579:     * regra CLAUDE.md #35a).
1580:     *==========================================================================
1581:     PROCEDURE BtnProcessarClick()
1582:         LOCAL loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope, loc_cErro, ;
1583:             loc_nSelecionadas, loc_oErro
1584: 
1585:         loc_cErro = ""
1586: 
1587:         TRY
1588:             loc_cGrupo  = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Grupo.Value)
1589:             loc_cGrupoC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_GrupoC.Value)
1590:             loc_cContaC = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_ContaC.Value)
1591:             loc_cDope   = ALLTRIM(THIS.cnt_4c_Filtro.txt_4c_Dope.Value)
1592: 
1593:             IF EMPTY(loc_cGrupo)
1594:                 loc_cErro = "Obrigat" + CHR(243) + "rio Informar o Grupo de Filtro!!!"
1595:             ENDIF
1596:             IF EMPTY(loc_cErro) AND EMPTY(loc_cGrupoC)
1597:                 loc_cErro = "Grupo de Contra-Partida n" + CHR(227) + "o Informado!!!"
1598:             ENDIF
1599:             IF EMPTY(loc_cErro) AND EMPTY(loc_cContaC)
1600:                 loc_cErro = "Conta de Contra-Partida n" + CHR(227) + "o informada!!!"
1601:             ENDIF
1602:             IF EMPTY(loc_cErro) AND EMPTY(loc_cDope)
1603:                 loc_cErro = "Opera" + CHR(231) + CHR(227) + "o de Mov.Estoque n" + CHR(227) + ;
1604:                     "o cadastrada nos Par" + CHR(226) + "metros do Sistema!!!"
1605:             ENDIF
1606: 
1607:             IF !EMPTY(loc_cErro)
1608:                 MsgAviso(loc_cErro, "Aten" + CHR(231) + CHR(227) + "o")
1609:             ELSE
1610:                 loc_nSelecionadas = 0
1611: 
1612:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1613:                     SELECT (THIS.this_oBusinessObject.this_cCursorSaldos)
1614:                     COUNT TO loc_nSelecionadas FOR marcas = 1
1615:                 ENDIF
1616: 
1617:                 IF loc_nSelecionadas = 0
1618:                     MsgAviso("Nenhuma Conta Selecionada!", "Aten" + CHR(231) + CHR(227) + "o")
1619:                 ELSE
1620:                     THIS.this_oBusinessObject.this_nContasSelecionadas = loc_nSelecionadas
1621: 
1622:                     IF THIS.this_oBusinessObject.ProcessarEncerramento(loc_cGrupo, loc_cGrupoC, loc_cContaC, loc_cDope)
1623:                         MsgInfo("Encerramento processado com sucesso!", "Confirmar")
1624:                         THIS.LimparFiltro()
1625:                     ELSE
1626:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1627:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel processar o encerramento.", "Confirmar")
1628:                         ENDIF
1629:                         THIS.grd_4c_Dados.Refresh()
1630:                     ENDIF
1631:                 ENDIF
1632:             ENDIF
1633:         CATCH TO loc_oErro
1634:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1635:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnProcessarClick")
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * BtnEncerrarClick - cmdGprocessa.cmdSair.Click do legado (fecha o form)
1641:     *==========================================================================
1642:     PROCEDURE BtnEncerrarClick()
1643:         THIS.Release()
1644:     ENDPROC
1645: 
1646:     *==========================================================================
1647:     * TornarControlesVisiveis - Torna visiveis os controles criados via
1648:     * AddObject (nascem com Visible = .F.), percorrendo Pages e Controls
1649:     * recursivamente.
1650:     *==========================================================================
1651:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1652:         LOCAL loc_nI, loc_nP, loc_oObjeto
1653: 
1654:         IF VARTYPE(par_oContainer) <> "O"
1655:             RETURN
1656:         ENDIF
1657: 
1658:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1659:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1660: 
1661:             IF VARTYPE(loc_oObjeto) = "O"
1662:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1663:                     loc_oObjeto.Visible = .T.
1664:                 ENDIF
1665: 
1666:                 IF UPPER(loc_oObjeto.BaseClass) == "PAGEFRAME"
1667:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1668:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1669:                     ENDFOR
1670:                 ENDIF
1671: 
1672:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1673:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1674:                 ENDIF
1675:             ENDIF
1676:         ENDFOR
1677:     ENDPROC
1678: 
1679:     *==========================================================================
1680:     * Destroy - Libera os cursores de trabalho do BO (equivalente ao
1681:     * ThisForm.poDataMgr.Release do legado)
1682:     *==========================================================================
1683:     PROCEDURE Destroy()
1684:         LOCAL loc_oErro
1685: 
1686:         TRY
1687:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1688:                 IF USED(THIS.this_oBusinessObject.this_cCursorSaldos)
1689:                     USE IN (THIS.this_oBusinessObject.this_cCursorSaldos)
1690:                 ENDIF
1691:                 IF USED(THIS.this_oBusinessObject.this_cCursorLancamentos)
1692:                     USE IN (THIS.this_oBusinessObject.this_cCursorLancamentos)
1693:                 ENDIF
1694:                 IF USED(THIS.this_oBusinessObject.this_cCursorCabecalhos)
1695:                     USE IN (THIS.this_oBusinessObject.this_cCursorCabecalhos)
1696:                 ENDIF
1697:                 IF USED(THIS.this_oBusinessObject.this_cCursorParametros)
1698:                     USE IN (THIS.this_oBusinessObject.this_cCursorParametros)
1699:                 ENDIF
1700:             ENDIF
1701:         CATCH TO loc_oErro
1702:             MsgErro(loc_oErro.Message, "Erro em FormSigOpEnc.Destroy")
1703:         ENDTRY
1704: 
1705:         DODEFAULT()
1706:     ENDPROC
1707: 
1708: ENDDEFINE

