# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMpn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2138 linhas total):

*-- Linhas 22 a 118:
22: * pai, ficam visiveis aqui pelo NOME, sem precisar emular "Set
23: * DataSession To <numero>" (sem equivalente nesta arquitetura).
24: *
25: * Aberto com: CREATEOBJECT("FormSigOpMpn", oFormPai)
26: *
27: * Parametros de Init (equivalentes ao legado "LParameters pForm, DatSes,
28: * Operacao"):
29: *   par_oFormPai - pForm: form chamador. Guardado em this_oFormPai; o
30: *                  legado tambem copia This.pEmps/This.pcEscolha dele no
31: *                  Init (aqui: this_oBusinessObject.this_cEmpresa e
32: *                  this_cModoAtual) e o reabilita no fechamento
33: *                  (ThisForm.ParentForm.Enabled = .t., replicado em
34: *                  Destroy() - mesmo padrao de FormSigOpMpd.prg).
35: *   par_nDataSession - DatSes (DataSessionId do pai): sem equivalente
36: *                  nesta arquitetura (DataSession=1 compartilhada
37: *                  substitui, ver nota acima). Recebido so por fidelidade
38: *                  de assinatura - nunca lido.
39: *   par_cOperacao - Operacao: recebido pelo LParameters legado mas NUNCA
40: *                  referenciado no corpo do Init (confirmado por grep no
41: *                  dump inteiro - unico ponto onde o nome aparece e a
42: *                  propria declaracao do parametro). Parametro morto no
43: *                  legado - recebido aqui so por fidelidade de assinatura.
44: *
45: * Historico de fases:
46: *   Fase 1/2: SigOpMpnBO.prg (propriedades, Init, ObterChavePrimaria,
47: *             CarregarDoCursor, Atualizar).
48: *   Fase 3:   FormSigOpMpn.prg - estrutura base (Init, InicializarForm,
49: *             ConfigurarCabecalho, Destroy).
50: *   Fase 4:   grd_4c_Grade (TmpPends, selecao), grd_4c_Itens/grd_4c_Total
51: *             (xPNensi/xPNensiT, detalhe) e os botoes de acao (cmd_4c_Ok/
52: *             cmd_4c_SelTudo/cmd_4c_Apaga/cmd_4c_Totaliza), MAIS a carga e
53: *             o vinculo das tres grades (CarregarGrade/CarregarLista +
54: *             SigOpMpnBO.CarregarPendencias, que cria os tres cursores e
55: *             popula TmpPends/xPNensi/xPNensiT). A montagem visual
56: *             (Configurar*) e o bind (Carregar*) ficam SEPARADOS por causa
57: *             da regra #41 - Column.ControlSource de cursor que ainda nao
58: *             existe derruba o Init -, mas rodam na MESMA ordem do Init
59: *             legado: monta, cria cursor, liga.
60: *
61: *   Fase 5:   lbl_4c_Label1 + txt_4c_OpSubNivel (Nivels do nivel para o
62: *             qual a movimentacao de subnivel esta indo - legado:
63: *             "ThisForm.OpSubNivel.Value = crSigCdOpd.Nivels", calculado
64: *             em CarregarGrade() a partir de TmpNens.Dopps/crSigCdOpd -
65: *             cursor do form pai e cursor global, ambos visiveis aqui
66: *             pelo nome por causa da DataSession=1 compartilhada).
67: *   Fase 6:   lbl_4c__Procura/txt_4c_Procura (busca incremental por Numps
68: *             na grade de selecao - legado: Say_Procura/Get_Procura.Valid/
69: *             LostFocus, transcritos em ValidarProcuraNumero/
70: *             TxtProcuraKeyPress/TxtProcuraLostFocus porque BINDEVENT
71: *             "Valid" nao funciona em TextBox, regra do projeto - KeyPress
72: *             com ENTER/TAB simula o Valid) e obj_4c_Mm_obs (EditBox
73: *             read-only, legado: ControlSource = TmpPends.Obss, ligado em
74: *             CarregarGrade() pelo mesmo motivo de regra #41 das grades -
75: *             TmpPends ainda nao existe no momento do AddObject).
76: *   Fase 7:   GarantirCheckBoxSelecionar() + ChkSelecionarInteractiveChange
77: *             (toggle da coluna de selecao - legado: fwcheckbox1.
78: *             InteractiveChange -> ThisForm.Marca()/Desmarca), CmdSelTudoClick/
79: *             CmdApagaClick (Marca/Desmarca em lote - legado: SelTudo.Click/
80: *             apaga.Click), CmdTotalizaClick (alterna grd_4c_Itens com
81: *             grd_4c_Total via this_nContador - legado: Totaliza.Click) e
82: *             GradeAfterRowColChange (reaplica o "Set Key To" das duas
83: *             grades de detalhe quando o usuario troca de pendencia -
84: *             regra #46: sem filtro de coluna, porque recarrega o DETALHE
85: *             da linha corrente). ConfigurarEventosGrade liga tambem o
86: *             GotFocus das colunas de exibicao (Usuario/data/Grupo/Conta/
87: *             Peso) a FocarColunaSelecao, que redireciona sempre para o
88: *             CheckBox (legado: "ThisForm.Grade.Seleciona.fwcheckbox1.
89: *             SetFocus" incondicional - mesmo padrao de FormSigOpMpd.prg).
90: *   Fase 8:   CmdOkClick (o "ok" legado - grava via SigOpMpnBO.
91: *             ConfirmarMovimentacoes, que povoa xMFas/xOpi/xNensi do form
92: *             pai e atualiza SigCdNec.ChkSubn, e so fecha o dialogo em
93: *             caso de sucesso), FecharDialogo/BtnEncerrarClick/
94: *             BtnCancelarClick (os tres nomes canonicos do projeto
95: *             convergindo no MESMO funil - o legado nao oferece saida sem
96: *             gravar: ControlBox=.F., Closable=.F., sem ESC) e Destroy
97: *             (reabilita o form pai, libera o BO, fecha os cursores
98: *             PROPRIOS desta tela - TmpPends/xPNensi/xPNensiT - e chama
99: *             DODEFAULT() por ultimo, regra do projeto sobre os popups do
100: *             menu principal).
101: *==============================================================================
102: 
103: DEFINE CLASS FormSigOpMpn AS FormBase
104: 
105:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGOPMPN;
106:     *-- WindowState nao tem equivalente direto de uso no projeto e fica
107:     *-- no default do VFP, igual aos demais dialogos desta familia)
108:     Height       = 600
109:     Width        = 1000
110:     AutoCenter   = .T.
111:     BorderStyle  = 2
112:     ShowWindow   = 1
113:     WindowType   = 1
114:     ControlBox   = .F.
115:     Closable     = .F.
116:     MaxButton    = .F.
117:     MinButton    = .F.
118:     Movable      = .F.

*-- Linhas 148 a 306:
148:     * Init - recebe o form chamador (e os dois parametros legados sem
149:     * equivalente nesta arquitetura - ver nota no cabecalho), copia
150:     * Empresa/Modo do pai, cria o Business Object e delega a
151:     * FormBase.Init() (que chama THIS.InicializarForm() via DODEFAULT()).
152:     *--------------------------------------------------------------------------
153:     PROCEDURE Init(par_oFormPai, par_nDataSession, par_cOperacao)
154:         LOCAL loc_lSucesso, loc_oErro
155:         loc_lSucesso = .F.
156: 
157:         TRY
158:             IF VARTYPE(par_oFormPai) = "O"
159:                 THIS.this_oFormPai = par_oFormPai
160:                 IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
161:                     THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
162:                 ENDIF
163:             ENDIF
164: 
165:             THIS.this_nContador = 0
166: 
167:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpMpnBO")
168:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
169:                 MsgErro("Erro ao criar Business Object SigOpMpnBO." + CHR(13) + ;
170:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
171:                     "FormSigOpMpn.Init")
172:             ELSE
173:                 *-- Legado: ThisForm.pEmps = ThisForm.ParentForm.pEmps -
174:                 *-- copia simples da empresa do form pai, guardada no BO
175:                 *-- (this_cEmpresa ja existe la - ver cabecalho de
176:                 *-- SigOpMpnBO.prg)
177:                 IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "this_cEmpresa", 5)
178:                     THIS.this_oBusinessObject.this_cEmpresa = par_oFormPai.this_cEmpresa
179:                 ENDIF
180: 
181:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
182:                 loc_lSucesso = DODEFAULT()
183:             ENDIF
184:         CATCH TO loc_oErro
185:             MsgErro(loc_oErro.Message + CHR(13) + ;
186:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
187:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.Init")
188:         ENDTRY
189: 
190:         RETURN loc_lSucesso
191:     ENDPROC
192: 
193:     *--------------------------------------------------------------------------
194:     * InicializarForm - fundo do form + cabecalho (SIGOPMPN.cntSombra do
195:     * dump). Grade de selecao, grades de itens/total e botoes de acao sao
196:     * das fases seguintes (regra #41 - Column.ControlSource de cursor que
197:     * ainda nao existe derruba o Init; esses cursores so nascem quando o
198:     * metodo de carga da Fase 4 roda). Chamado automaticamente por
199:     * FormBase.Init() via DODEFAULT().
200:     *--------------------------------------------------------------------------
201:     PROTECTED PROCEDURE InicializarForm()
202:         LOCAL loc_lSucesso, loc_oErro
203:         loc_lSucesso = .F.
204: 
205:         TRY
206:             THIS.LockScreen = .T.
207: 
208:             *-- Fundo do form (imagem do Framework Fortyus legado:
209:             *-- "..\framework\imagens\new_background.jpg" no SCX)
210:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
211: 
212:             *-- Ordem identica ao dump legado (SECAO 1 - arvore de
213:             *-- objetos): cntSombra e o primeiro objeto da arvore
214:             THIS.ConfigurarCabecalho()
215: 
216:             *-- Grade de selecao (TmpPends) + grades de detalhe (xPNensi/
217:             *-- xPNensiT) + botoes de acao (ok/SelTudo/Apaga/Totaliza) -
218:             *-- so a ESTRUTURA visual, SEM RecordSource/ControlSource
219:             *-- (regra #41: Column.ControlSource de cursor que ainda nao
220:             *-- existe derruba o Init e a tela nao abre). Mesma divisao de
221:             *-- FormSigOpMpd.prg.
222:             THIS.ConfigurarGrade()
223:             THIS.ConfigurarGradesDetalhe()
224:             THIS.ConfigurarBotoesAcao()
225:             THIS.ConfigurarEventosBotoes()
226:             THIS.ConfigurarEventosGrade()
227: 
228:             *-- Label1 + OpSubNivel (SIGOPMPN.Label1/OpSubNivel do dump) -
229:             *-- so ESTRUTURA visual aqui; o valor de txt_4c_OpSubNivel eh
230:             *-- preenchido em CarregarGrade() (depende de TmpNens, que e'
231:             *-- do form pai - mesma razao de ConfigurarGrade/CarregarGrade
232:             *-- estarem separados, regra #41)
233:             THIS.ConfigurarCamposComplementares()
234: 
235:             *-- E so DEPOIS a carga, que cria os tres cursores e liga as
236:             *-- grades (legado: tudo isso acontece dentro do MESMO Init,
237:             *-- nesta ordem - montagem, Create Cursor, bind). CarregarGrade
238:             *-- ja chama AjustarBotoesPorModo no fim, porque a visibilidade
239:             *-- de SelTudo/Apaga/Totaliza depende do SepPedras do nivel,
240:             *-- que so eh conhecido depois de consultar crSigCdOpd.
241:             THIS.CarregarGrade()
242: 
243:             THIS.LockScreen = .F.
244: 
245:             loc_lSucesso = .T.
246:         CATCH TO loc_oErro
247:             MsgErro(loc_oErro.Message + CHR(13) + ;
248:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
249:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.InicializarForm")
250:         ENDTRY
251: 
252:         RETURN loc_lSucesso
253:     ENDPROC
254: 
255:     *--------------------------------------------------------------------------
256:     * ConfigurarCabecalho - faixa escura de titulo (SIGOPMPN.cntSombra do
257:     * dump), com os dois labels sobrepostos (lblSombra = sombra preta,
258:     * lblTitulo = titulo branco por cima - mesmo padrao de
259:     * FormSigOpMpd.prg/FormSigOpLrC.prg/Formsigopagr.prg). Caption dos
260:     * dois labels recebe a propriedade Caption do form - legado:
261:     * ThisForm.cntSombra.lblSombra e lblTitulo.Caption = ThisForm.Caption,
262:     * feito no inicio do Init. Largura em THIS.Width (nao o literal 1100
263:     * do dump, maior que o Form.Width=1000 do proprio SCX) - regra do
264:     * projeto sobre container de cabecalho (CLAUDE.md regra #11/#30).
265:     *--------------------------------------------------------------------------
266:     PROTECTED PROCEDURE ConfigurarCabecalho()
267:         LOCAL loc_oCab
268: 
269:         THIS.AddObject("cnt_4c_Sombra", "Container")
270:         loc_oCab = THIS.cnt_4c_Sombra
271:         WITH loc_oCab
272:             .Top         = 0
273:             .Left        = 0
274:             .Width       = THIS.Width
275:             .Height      = 80
276:             .BackColor   = RGB(100, 100, 100)
277:             .BackStyle   = 1
278:             .BorderWidth = 0
279:             .Visible     = .T.
280:         ENDWITH
281: 
282:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
283:         WITH loc_oCab.lbl_4c_LblSombra
284:             .AutoSize      = .F.
285:             .Top           = 18
286:             .Left          = 10
287:             .Width         = loc_oCab.Width - 20
288:             .Height        = 40
289:             .FontName      = "Tahoma"
290:             .FontSize      = 18
291:             .FontBold      = .T.
292:             .FontUnderline = .F.
293:             .Alignment     = 0
294:             .BackStyle     = 0
295:             .WordWrap      = .T.
296:             .ForeColor     = RGB(0, 0, 0)
297:             .Caption       = THIS.Caption
298:             .Visible       = .T.
299:         ENDWITH
300: 
301:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
302:         WITH loc_oCab.lbl_4c_LblTitulo
303:             .AutoSize    = .F.
304:             .Top         = 17
305:             .Left        = 10
306:             .Width       = loc_oCab.Width - 20

*-- Linhas 334 a 377:
334:     * .ReadOnly de nascimento, espelhando o When do legado (fwcheckbox1.
335:     * When: Return (pcEscolha = 'INSERIR')).
336:     *--------------------------------------------------------------------------
337:     PROTECTED PROCEDURE ConfigurarGrade()
338:         THIS.AddObject("grd_4c_Grade", "Grid")
339: 
340:         WITH THIS.grd_4c_Grade
341:             .Top               = 118
342:             .Left              = 12
343:             .Width             = 668
344:             .Height            = 260
345:             .ColumnCount       = 7
346:             .FontName          = "Courier New"
347:             .AllowHeaderSizing = .F.
348:             .DeleteMark        = .F.
349:             .RecordMark        = .F.
350:             .RowHeight         = 17
351:             .ScrollBars        = 2
352:             *-- Grid.ReadOnly propaga para as colunas - por isso vem ANTES
353:             *-- delas (regra do projeto)
354:             .ReadOnly          = .F.
355:             .Visible           = .T.
356:         ENDWITH
357: 
358:         *-- Column1 "seleciona" - ColumnOrder=1 (default)
359:         WITH THIS.grd_4c_Grade.Column1
360:             .Width     = 15
361:             .FontName  = "Courier New"
362:             .FontSize  = 9
363:             .Movable   = .F.
364:             .Resizable = .F.
365:             *-- valor de NASCIMENTO (legado: fwcheckbox1.When). A caixa
366:             *-- embutida (regra #18) so nasce quando TmpPends existir.
367:             .ReadOnly  = (THIS.this_cModoAtual != "INCLUIR")
368:         ENDWITH
369:         WITH THIS.grd_4c_Grade.Column1.Header1
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .Alignment = 2
373:             .Caption   = ""
374:         ENDWITH
375: 
376:         *-- Column2 "Usuario" - ColumnOrder=7 (ultima coluna visivel)
377:         WITH THIS.grd_4c_Grade.Column2

*-- Linhas 553 a 596:
553:     * duas (fase de handlers - THIS.ok.Click do legado so chama Visible
554:     * em cascata, fica para CmdTotalizaClick em fase posterior).
555:     *--------------------------------------------------------------------------
556:     PROTECTED PROCEDURE ConfigurarGradesDetalhe()
557:         *-- grd_4c_Itens (Gradeitem) ----------------------------------------
558:         THIS.AddObject("grd_4c_Itens", "Grid")
559: 
560:         WITH THIS.grd_4c_Itens
561:             .Top               = 383
562:             .Left              = 12
563:             .Width             = 668
564:             .Height            = 206
565:             .ColumnCount       = 9
566:             .FontSize          = 8
567:             .HeaderHeight      = 16
568:             .RowHeight         = 16
569:             .AllowHeaderSizing = .F.
570:             .DeleteMark        = .F.
571:             .RecordMark        = .F.
572:             .ReadOnly          = .F.
573:             .Visible           = .T.
574:         ENDWITH
575: 
576:         WITH THIS.grd_4c_Itens.Column1
577:             .Width     = 80
578:             .FontName  = "Courier New"
579:             .FontSize  = 8
580:             .Movable   = .F.
581:             .Resizable = .F.
582:             .ReadOnly  = .T.
583:             .Format    = "L"
584:             .InputMask = "9999999999"
585:         ENDWITH
586:         WITH THIS.grd_4c_Itens.Column1.Header1
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .Alignment = 2
590:             .Caption   = "Ordem Produ" + CHR(231) + CHR(227) + "o"
591:         ENDWITH
592:         WITH THIS.grd_4c_Itens.Column1.Text1
593:             .FontName    = "Courier New"
594:             .FontSize    = 8
595:             .BorderStyle = 0
596:             .Format      = "L"

*-- Linhas 1016 a 1059:
1016:     * classe de framework.vcx; mesmos valores de FormSigOpMpd.prg,
1017:     * mesma familia de tela).
1018:     *--------------------------------------------------------------------------
1019:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1020: 
1021:         THIS.AddObject("shp_4c_Shape1", "Shape")
1022:         WITH THIS.shp_4c_Shape1
1023:             .Top         = 7
1024:             .Left        = 818
1025:             .Width       = 171
1026:             .Height      = 110
1027:             .BackStyle   = 0
1028:             .BorderStyle = 0
1029:             .BorderColor = RGB(136, 189, 188)
1030:             .Visible     = .T.
1031:         ENDWITH
1032: 
1033:         *-- SelTudo (legado: fwbtnp) - marca todas as linhas de TmpPends
1034:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1035:         WITH THIS.cmd_4c_SelTudo
1036:             .Top          = 145
1037:             .Left         = 690
1038:             .Width        = 36
1039:             .Height       = 36
1040:             .Caption      = ""
1041:             .FontName     = "Verdana"
1042:             .FontSize     = 8
1043:             .ForeColor    = RGB(36, 84, 155)
1044:             .BackColor    = RGB(255, 255, 255)
1045:             .Themes       = .T.
1046:             .MousePointer = 15
1047:             .ToolTipText  = "Seleciona Tudo"
1048:             .Picture      = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
1049:         ENDWITH
1050: 
1051:         *-- apaga (legado: fwbtnp) - desmarca todas as linhas de TmpPends
1052:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1053:         WITH THIS.cmd_4c_Apaga
1054:             .Top          = 145
1055:             .Left         = 731
1056:             .Width        = 36
1057:             .Height       = 36
1058:             .Caption      = ""
1059:             .FontName     = "Verdana"

*-- Linhas 1124 a 1598:
1124:     ENDPROC
1125: 
1126:     *--------------------------------------------------------------------------
1127:     * ConfigurarEventosBotoes - BINDEVENT dos quatro botoes de acao
1128:     * (ok/SelTudo/apaga/Totaliza). Handlers alvo sao PUBLIC de proposito -
1129:     * BINDEVENT falha em silencio com metodo PROTECTED (regra #3).
1130:     *--------------------------------------------------------------------------
1131:     PROTECTED PROCEDURE ConfigurarEventosBotoes()
1132:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
1133:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
1134:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
1135:         BINDEVENT(THIS.cmd_4c_Totaliza, "Click", THIS, "CmdTotalizaClick")
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * ConfigurarEventosGrade - BINDEVENT do AfterRowColChange da grade de
1140:     * selecao e do redirecionamento de foco das colunas de EXIBICAO
1141:     * (Usuario/data/Grupo/Conta/Peso) para o CheckBox embutido na Column1 -
1142:     * legado: GotFocus de cada uma chama "ThisForm.Grade.Seleciona.
1143:     * fwcheckbox1.SetFocus" incondicionalmente. Column3 "codigo" NAO entra
1144:     * aqui: eh o foco inicial natural do dialogo (Ingrid1/busca incremental
1145:     * no legado), igual ao padrao de FormSigOpMpd.prg.
1146:     *--------------------------------------------------------------------------
1147:     PROTECTED PROCEDURE ConfigurarEventosGrade()
1148:         BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1149: 
1150:         BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1151:         BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1152:         BINDEVENT(THIS.grd_4c_Grade.Column5.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1153:         BINDEVENT(THIS.grd_4c_Grade.Column6.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1154:         BINDEVENT(THIS.grd_4c_Grade.Column7.Text1, "GotFocus", THIS, "FocarColunaSelecao")
1155:     ENDPROC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * AjustarBotoesPorModo - Visible de SelTudo/Apaga/Totaliza (regra
1159:     * #40: quem desabilita no funil, reabilita no funil - chamado de
1160:     * novo pela fase que recarrega a grade, ja que RecordSource reseta
1161:     * estado da Column mas nao destes botoes).
1162:     *
1163:     * Legado (fim do Init):
1164:     *   ThisForm.SelTudo.Visible   = (pcEscolha = 'INSERIR')
1165:     *   ThisForm.Apaga.Visible     = (pcEscolha = 'INSERIR')
1166:     *   ThisForm.Totaliza.Visible  = (pcEscolha = 'INSERIR' And
1167:     *                                 CrSigCdOpd.SepPedras = 4)
1168:     *
1169:     * CrSigCdOpd so fica POSICIONADO no "nivel" certo depois que o
1170:     * metodo de carga da necessidade corrente roda (Seek(TmpPends.Dopps,
1171:     * 'crSigCdOpd', 'Dopps') - mesmo Dopps que THIS.this_oBusinessObject.
1172:     * this_cDopps guarda, da linha corrente de TmpPends via
1173:     * CarregarDoCursor). Antes disso (TmpPends ainda vazio - esta fase),
1174:     * this_cDopps esta vazio e Totaliza fica oculto - correto, nao eh
1175:     * stub: o calculo e' real e so avalia .T. quando ha dado para
1176:     * avaliar.
1177:     *--------------------------------------------------------------------------
1178:     *-- PUBLIC (regra #3): o harness de teste chama AjustarBotoesPorModo()
1179:     *-- direto de fora da classe, e PEMSTATUS(oForm, <metodo>, 5) devolve .T.
1180:     *-- mesmo para metodo PROTECTED (so testa existencia, nao escopo) - o
1181:     *-- teste entraria no branch e a chamada falharia em runtime.
1182:     PROCEDURE AjustarBotoesPorModo()
1183:         LOCAL loc_lModoIncluir, loc_lSeparaPedras, loc_cAliasAnterior
1184: 
1185:         loc_lModoIncluir  = (THIS.this_cModoAtual == "INCLUIR")
1186:         loc_lSeparaPedras = .F.
1187: 
1188:         *-- SepPedras vem do registro do NIVEL em SigCdOpd. Depois da carga
1189:         *-- quem tem o valor autoritativo eh o BO (SigOpMpnBO.CarregarNivel
1190:         *-- grava this_nSepPedras na SEGUNDA consulta, que eh justamente a
1191:         *-- do nivel) - ler a property evita depender do ponteiro de um
1192:         *-- cursor global estar parado no registro certo.
1193:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1194:                 PEMSTATUS(THIS.this_oBusinessObject, "this_nSepPedras", 5)
1195:             loc_lSeparaPedras = (THIS.this_oBusinessObject.this_nSepPedras = 4)
1196:         ENDIF
1197: 
1198:         *-- Fallback para antes da carga (property ainda em 0): le o cursor
1199:         *-- global, como o legado faz
1200:         IF !loc_lSeparaPedras AND USED("crSigCdOpd") AND ;
1201:                 VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1202:                 !EMPTY(THIS.this_oBusinessObject.this_cDopps)
1203:             loc_cAliasAnterior = ALIAS()
1204: 
1205:             IF SEEK(THIS.this_oBusinessObject.this_cDopps, "crSigCdOpd", "Dopps")
1206:                 loc_lSeparaPedras = (crSigCdOpd.SepPedras = 4)
1207:             ENDIF
1208: 
1209:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1210:                 SELECT (loc_cAliasAnterior)
1211:             ENDIF
1212:         ENDIF
1213: 
1214:         IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
1215:             THIS.cmd_4c_SelTudo.Visible = loc_lModoIncluir
1216:         ENDIF
1217:         IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
1218:             THIS.cmd_4c_Apaga.Visible = loc_lModoIncluir
1219:         ENDIF
1220:         IF PEMSTATUS(THIS, "cmd_4c_Totaliza", 5)
1221:             THIS.cmd_4c_Totaliza.Visible = (loc_lModoIncluir AND loc_lSeparaPedras)
1222:         ENDIF
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------
1226:     * ConfigurarCamposComplementares - Label1 + OpSubNivel (dump: filhos
1227:     * DIRETOS do form, Top=89..93, Left=12..324 - a esquerda da grade de
1228:     * selecao). txt_4c_OpSubNivel exibe o "Nivels" do nivel de DESTINO da
1229:     * movimentacao de subnivel; o legado bloqueia o foco com "PROCEDURE
1230:     * When / Return .f." (nunca editavel por teclado) - aqui reproduzido
1231:     * com .ReadOnly = .T., que preserva a aparencia normal do TextBox (o
1232:     * legado nao usa DisabledBackColor nem Enabled = .F. para este campo).
1233:     *
1234:     * So a ESTRUTURA visual: o Value de txt_4c_OpSubNivel e' calculado em
1235:     * CarregarGrade() porque depende de TmpNens (cursor do form PAI,
1236:     * visivel aqui por nome - DataSession=1 compartilhada) e crSigCdOpd
1237:     * (cursor global), nenhum dos dois garantido no momento do Init.
1238:     *
1239:     * lbl_4c__Procura/txt_4c_Procura (SIGOPMPN.Say_Procura/Get_Procura do
1240:     * dump) sao a busca incremental por Numps na grade de selecao - so a
1241:     * ESTRUTURA aqui; o Valid/LostFocus legado vira ValidarProcuraNumero/
1242:     * TxtProcuraKeyPress/TxtProcuraLostFocus (ver nota la). Os BINDEVENT
1243:     * ficam AQUI (e nao em CarregarGrade) porque os handlers nao dependem
1244:     * de TmpPends existir - so o CORPO deles consulta o cursor, com guarda
1245:     * USED() (mesmo padrao do resto do form).
1246:     *
1247:     * obj_4c_Mm_obs (SIGOPMPN.mm_obs do dump) e' o EditBox de observacao -
1248:     * SEMPRE ReadOnly = .T. no legado (simples exibicao, nunca editavel).
1249:     * So a ESTRUTURA aqui: o ControlSource ("TmpPends.Obss") fica em
1250:     * CarregarGrade() pela MESMA razao das colunas das grades (regra #41 -
1251:     * TmpPends ainda nao existe neste ponto do Init).
1252:     *--------------------------------------------------------------------------
1253:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
1254:         THIS.AddObject("lbl_4c_Label1", "Label")
1255:         WITH THIS.lbl_4c_Label1
1256:             .AutoSize  = .F.
1257:             .Top       = 93
1258:             .Left      = 12
1259:             .Width     = 136
1260:             .Height    = 15
1261:             .FontName  = "Tahoma"
1262:             .FontSize  = 8
1263:             .BackStyle = 0
1264:             .ForeColor = RGB(90, 90, 90)
1265:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Subn" + CHR(237) + "vel :"
1266:             .Visible   = .T.
1267:         ENDWITH
1268: 
1269:         THIS.AddObject("txt_4c_OpSubNivel", "TextBox")
1270:         WITH THIS.txt_4c_OpSubNivel
1271:             .Top       = 89
1272:             .Left      = 150
1273:             .Width     = 174
1274:             .Height    = 23
1275:             .FontName  = "Tahoma"
1276:             .FontSize  = 8
1277:             .Alignment = 3
1278:             .Format    = "K"
1279:             .Value     = ""
1280:             *-- legado: Procedure When / Return .f. - nunca recebe foco
1281:             .ReadOnly  = .T.
1282:             .Visible   = .T.
1283:         ENDWITH
1284: 
1285:         *-- lbl_4c__Procura (Say_Procura) - AutoSize do dump eh NO-OP em
1286:         *-- Label criado por AddObject (regra #23): Width explicita =
1287:         *-- Width do dump, Alignment = 0 (classe say, sem Alignment
1288:         *-- declarado no dump)
1289:         THIS.AddObject("lbl_4c__Procura", "Label")
1290:         WITH THIS.lbl_4c__Procura
1291:             .AutoSize  = .F.
1292:             .Top       = 93
1293:             .Left      = 524
1294:             .Width     = 96
1295:             .Height    = 15
1296:             .FontName  = "Tahoma"
1297:             .FontSize  = 8
1298:             .BackStyle = 0
1299:             .Alignment = 0
1300:             .ForeColor = RGB(90, 90, 90)
1301:             .Caption   = "Busca de  C" + CHR(243) + "digos :"
1302:             .Visible   = .T.
1303:         ENDWITH
1304: 
1305:         *-- txt_4c_Procura (Get_Procura) - numerico (Value=0 no dump),
1306:         *-- MaxLength=6 transcrito literal; sem InputMask no dump (o
1307:         *-- Value numerico ja restringe a digitos/sinal)
1308:         THIS.AddObject("txt_4c_Procura", "TextBox")
1309:         WITH THIS.txt_4c_Procura
1310:             .Top         = 89
1311:             .Left        = 622
1312:             .Width       = 58
1313:             .Height      = 23
1314:             .FontName    = "Tahoma"
1315:             .FontSize    = 8
1316:             .Alignment   = 3
1317:             .Format      = "K"
1318:             .MaxLength   = 6
1319:             .Value       = 0
1320:             .ToolTipText = "Busca de C" + CHR(243) + "digos"
1321:             .Visible     = .T.
1322:         ENDWITH
1323: 
1324:         *-- KeyPress/LostFocus substituem Valid/LostFocus (BINDEVENT
1325:         *-- "Valid" nao funciona em TextBox - regra do projeto)
1326:         BINDEVENT(THIS.txt_4c_Procura, "KeyPress", THIS, "TxtProcuraKeyPress")
1327:         BINDEVENT(THIS.txt_4c_Procura, "LostFocus", THIS, "TxtProcuraLostFocus")
1328: 
1329:         *-- obj_4c_Mm_obs (mm_obs) - ReadOnly = .T. de nascimento (igual ao
1330:         *-- dump); ControlSource fica para CarregarGrade() (regra #41)
1331:         THIS.AddObject("obj_4c_Mm_obs", "EditBox")
1332:         WITH THIS.obj_4c_Mm_obs
1333:             .Top               = 192
1334:             .Left              = 690
1335:             .Width             = 301
1336:             .Height            = 184
1337:             .FontName          = "Tahoma"
1338:             .FontSize          = 8
1339:             .ReadOnly          = .T.
1340:             .DisabledBackColor = RGB(255, 255, 220)
1341:             .Visible           = .T.
1342:         ENDWITH
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * ValidarProcuraNumero - equivalente ao Valid legado de Get_Procura:
1347:     *
1348:     *   If Not Empty(This.Value)
1349:     *       Select TmpPends / Set Order To Numps / Set Near On
1350:     *       Seek This.Value / Set Near Off
1351:     *       ThisForm.Refresh
1352:     *       If (This.Value = TmpPends.Numps)
1353:     *           This.Value = 0
1354:     *       Else
1355:     *           Return 0
1356:     *       EndIf
1357:     *   EndIf
1358:     *
1359:     * "Return 0" do Valid legado mantem o foco no campo (SET NEAR so achou
1360:     * um vizinho, nao o Numps exato digitado) - aqui devolve .F. para o
1361:     * KeyPress decidir com NODEFAULT (ver TxtProcuraKeyPress). THIS.Refresh()
1362:     * repinta a grade de selecao (posicionada pelo SEEK) e obj_4c_Mm_obs
1363:     * (ControlSource = TmpPends.Obss, muda com o registro corrente).
1364:     *
1365:     * PROTECTED: so chamado de dentro da classe (regra #51 - nao eh metodo
1366:     * que precise ser alcancado de fora, diferente dos handlers de evento).
1367:     *--------------------------------------------------------------------------
1368:     PROTECTED PROCEDURE ValidarProcuraNumero()
1369:         LOCAL loc_lPodeSair, loc_cAliasPends, loc_cAliasAnterior, loc_nValor
1370: 
1371:         loc_lPodeSair   = .T.
1372:         loc_cAliasPends = ""
1373: 
1374:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1375:             loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
1376:         ENDIF
1377: 
1378:         IF !EMPTY(THIS.txt_4c_Procura.Value) AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
1379:             loc_nValor         = THIS.txt_4c_Procura.Value
1380:             loc_cAliasAnterior = ALIAS()
1381: 
1382:             SELECT (loc_cAliasPends)
1383:             SET ORDER TO Numps
1384:             SET NEAR ON
1385:             SEEK loc_nValor
1386:             SET NEAR OFF
1387: 
1388:             THIS.Refresh()
1389: 
1390:             IF loc_nValor = EVALUATE(loc_cAliasPends + ".Numps")
1391:                 THIS.txt_4c_Procura.Value = 0
1392:             ELSE
1393:                 loc_lPodeSair = .F.
1394:             ENDIF
1395: 
1396:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1397:                 SELECT (loc_cAliasAnterior)
1398:             ENDIF
1399:         ENDIF
1400: 
1401:         RETURN loc_lPodeSair
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * TxtProcuraKeyPress - PUBLIC (regra #3: alvo de BINDEVENT). Testa
1406:     * ENTER(13)/TAB(9) para simular o Valid legado (BINDEVENT "Valid" nao
1407:     * funciona em TextBox).
1408:     *
1409:     * TAB: quando ValidarProcuraNumero() devolve .F. (entrada invalida), o
1410:     * NODEFAULT suprime a navegacao padrao do Tab - o campo continua com o
1411:     * foco, igual ao "Return 0" do Valid legado.
1412:     *
1413:     * ENTER: diferente do Tab, Enter NAO move o foco por padrao no VFP9 -
1414:     * sem este bloco extra o legado jamais chegaria a perder o foco so por
1415:     * Enter, e TxtProcuraLostFocus (equivalente ao LostFocus legado) nunca
1416:     * dispararia. Forcar o foco para a coluna de selecao aqui reproduz o
1417:     * MESMO destino do LostFocus legado, so que pela via do Enter.
1418:     *--------------------------------------------------------------------------
1419:     PROCEDURE TxtProcuraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1420:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1421:             IF !THIS.ValidarProcuraNumero()
1422:                 NODEFAULT
1423:             ELSE
1424:                 IF par_nKeyCode = 13
1425:                     NODEFAULT
1426:                     THIS.FocarColunaSelecao()
1427:                 ENDIF
1428:             ENDIF
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *--------------------------------------------------------------------------
1433:     * TxtProcuraLostFocus - PUBLIC (regra #3: alvo de BINDEVENT). Equivalente
1434:     * ao LostFocus legado de Get_Procura:
1435:     *
1436:     *   If (TmpPends.Numps = This.Value) Or (This.Value = 0)
1437:     *       ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus
1438:     *   EndIf
1439:     *
1440:     * Dispara sempre que o campo perde o foco DE VERDADE (Tab, clique, ou o
1441:     * SetFocus programatico que o proprio TxtProcuraKeyPress dispara no
1442:     * caso do Enter) - complementa o Enter (que o KeyPress ja resolve
1443:     * direto) cobrindo Tab/clique, que o legado tambem atende.
1444:     *--------------------------------------------------------------------------
1445:     PROCEDURE TxtProcuraLostFocus()
1446:         LOCAL loc_cAliasPends, loc_lPodeFocar
1447: 
1448:         loc_cAliasPends = ""
1449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1450:             loc_cAliasPends = THIS.this_oBusinessObject.this_cCursorPends
1451:         ENDIF
1452: 
1453:         loc_lPodeFocar = (THIS.txt_4c_Procura.Value = 0)
1454: 
1455:         IF !loc_lPodeFocar AND !EMPTY(loc_cAliasPends) AND USED(loc_cAliasPends)
1456:             loc_lPodeFocar = (EVALUATE(loc_cAliasPends + ".Numps") = THIS.txt_4c_Procura.Value)
1457:         ENDIF
1458: 
1459:         IF loc_lPodeFocar
1460:             THIS.FocarColunaSelecao()
1461:         ENDIF
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------
1465:     * FocarColunaSelecao - PUBLIC (mesmo nome/padrao de FormSigOpMpd.prg,
1466:     * mesma familia de tela - reutilizavel pelos GotFocus das colunas de
1467:     * exibicao da grade, fase posterior). Redireciona o foco para o
1468:     * CheckBox embutido na coluna de selecao, quando ele ja existe (so
1469:     * nasce em GarantirCheckBoxSelecionar, chamado por CarregarGrade -
1470:     * regra #18).
1471:     *--------------------------------------------------------------------------
1472:     PROCEDURE FocarColunaSelecao()
1473:         IF PEMSTATUS(THIS, "grd_4c_Grade", 5) AND ;
1474:                 PEMSTATUS(THIS.grd_4c_Grade.Column1, "chk_4c_Selecionar", 5)
1475:             THIS.grd_4c_Grade.Column1.chk_4c_Selecionar.SetFocus()
1476:         ENDIF
1477:     ENDPROC
1478: 
1479:     *--------------------------------------------------------------------------
1480:     * GarantirCheckBoxSelecionar - embute o CheckBox na coluna de selecao da
1481:     * grade (legado: SIGOPMPN.Grade.seleciona.fwcheckbox1, ControlSource =
1482:     * TmpPends.Flag).
1483:     *
1484:     * Vive separado de ConfigurarGrade porque so pode rodar DEPOIS de
1485:     * Column1.ControlSource apontar para TmpPends.Flag, que eh Logico - e
1486:     * TmpPends nasce na carga, nao na montagem da tela (regra #41). Alem
1487:     * disso RecordSource RECRIA os objetos Column, entao a caixa tem de ser
1488:     * reinstalada a CADA rebind: por isso o PEMSTATUS, que torna o metodo
1489:     * idempotente.
1490:     *
1491:     * Os tres comandos sao inseparaveis (regra #18): AddObject so CRIA o
1492:     * objeto - sem CurrentControl a coluna continua desenhando o Text1 dela,
1493:     * e sem Sparse = .F. o CheckBox aparece apenas na linha ativa.
1494:     *
1495:     * O TOGGLE (Click/MouseDown/MouseUp/KeyPress com NODEFAULT, que eh como
1496:     * o legado alterna o valor - ele SUPRIME o toggle nativo e faz o Replace
1497:     * por codigo, ver SIGOPMPN.Grade.seleciona.fwcheckbox1.InteractiveChange
1498:     * -> ThisForm.Marca/Desmarca) eh da fase de EVENTOS. Aqui NAO se chama
1499:     * BINDEVENT: apontar para um handler que ainda nao existe estoura no
1500:     * proprio bind.
1501:     *--------------------------------------------------------------------------
1502:     PROTECTED PROCEDURE GarantirCheckBoxSelecionar()
1503:         LOCAL loc_oColuna
1504:         loc_oColuna = THIS.grd_4c_Grade.Column1
1505: 
1506:         IF !PEMSTATUS(loc_oColuna, "chk_4c_Selecionar", 5)
1507:             loc_oColuna.AddObject("chk_4c_Selecionar", "CheckBox")
1508: 
1509:             WITH loc_oColuna.chk_4c_Selecionar
1510:                 .Caption   = ""
1511:                 .BackStyle = 0
1512:                 .Visible   = .T.
1513:             ENDWITH
1514: 
1515:             *-- legado: fwcheckbox1.InteractiveChange (=DoDefault() + If Not
1516:             *-- This.Value / ThisForm.Desmarca / Else / This.Value =
1517:             *-- ThisForm.Marca() / EndIf) - BINDEVENT dentro do MESMO IF: o
1518:             *-- objeto so eh recriado quando RecordSource derruba a Column,
1519:             *-- e um bind duplicado sobre o MESMO objeto empilharia o
1520:             *-- handler
1521:             BINDEVENT(loc_oColuna.chk_4c_Selecionar, "InteractiveChange", ;
1522:                 THIS, "ChkSelecionarInteractiveChange")
1523:         ENDIF
1524: 
1525:         loc_oColuna.CurrentControl = "chk_4c_Selecionar"
1526:         loc_oColuna.Sparse         = .F.
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * CarregarGrade - funil UNICO de carga e vinculo das TRES grades.
1531:     * Transcricao do trecho final do Init legado: depois de montar TmpPends/
1532:     * xPNensi/xPNensiT, ele faz o "With Thisform.Grade / .RecordSource = ...
1533:     * / .<coluna>.ControlSource = ..." para Grade, Gradeitem e GradeTotal.
1534:     *
1535:     * PUBLIC (regra #3/#51): o harness de teste chama CarregarLista/
1536:     * CarregarGrade de FORA da classe, e PEMSTATUS(...,5) devolve .T. para
1537:     * metodo PROTECTED, entao o teste entraria no branch e a chamada
1538:     * falharia em runtime.
1539:     *
1540:     * SigOpMpnBO.CarregarPendencias() recria os tres cursores do zero (mesma
1541:     * semantica do "Create Cursor" do Init legado) e so DEPOIS as grades sao
1542:     * ligadas - regra #41: Column.ControlSource de cursor que ainda nao
1543:     * existe derruba o Init e a tela nao abre.
1544:     *
1545:     * Ordem obrigatoria por grade: RecordSource -> ControlSource -> (Column1:
1546:     * AddObject do CheckBox) -> Width -> Header1.Caption -> ReadOnly. Mexer
1547:     * em RecordSource RECALCULA as larguras para o default 90 e reseta
1548:     * Header1.Caption, Sparse, CurrentControl e o ReadOnly das colunas (que
1549:     * volta a herdar o do Grid) - por isso tudo isso eh reaplicado AQUI, e
1550:     * nao so em ConfigurarGrade/ConfigurarGradesDetalhe (Problema 48 do
1551:     * FormCor; o ReadOnly da coluna sempre DEPOIS do ReadOnly do Grid).
1552:     *
1553:     * Bypass de SQL em modo teste/ValidarUIFidelity: TmpNens/TmpOperacao sao
1554:     * cursores do form PAI e nao existem em instanciacao headless - as
1555:     * grades ficam com a estrutura montada e sem dado, o que basta para a
1556:     * validacao de UI.
1557:     *--------------------------------------------------------------------------
1558:     PROCEDURE CarregarGrade()
1559:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
1560:         LOCAL loc_cPends, loc_cPNensi, loc_cPNensiT, loc_cChaveDetalhe
1561:         LOCAL loc_cNivelDestino, loc_cAliasNivelAnt
1562: 
1563:         loc_lSucesso = .F.
1564: 
1565:         TRY
1566:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
1567:                 (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
1568: 
1569:             *-- Legado (Init, antes do "Create Cursor TmpPends"):
1570:             *-- "=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps') / _DoppsNivel =
1571:             *-- crSigCdOpd.Nivels / ThisForm.OpSubNivel.Value = _DoppsNivel"
1572:             *-- - descricao do NIVEL de destino, lida do cursor global
1573:             *-- crSigCdOpd pela chave do nivel corrente do form pai
1574:             *-- (TmpNens.Dopps). TmpNens nao existe em modo teste/
1575:             *-- ValidarUIFidelity headless (cursor do form pai) - o guard
1576:             *-- USED() deixa o campo vazio nesse caso, igual ao resto da
1577:             *-- tela.
1578:             IF PEMSTATUS(THIS, "txt_4c_OpSubNivel", 5)
1579:                 loc_cNivelDestino = ""
1580:                 IF USED("TmpNens") AND USED("crSigCdOpd")
1581:                     loc_cAliasNivelAnt = ALIAS()
1582:                     IF SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
1583:                         loc_cNivelDestino = crSigCdOpd.Nivels
1584:                     ENDIF
1585:                     IF !EMPTY(loc_cAliasNivelAnt) AND USED(loc_cAliasNivelAnt)
1586:                         SELECT (loc_cAliasNivelAnt)
1587:                     ENDIF
1588:                 ENDIF
1589:                 THIS.txt_4c_OpSubNivel.Value = loc_cNivelDestino
1590:             ENDIF
1591: 
1592:             loc_cPends   = THIS.this_oBusinessObject.this_cCursorPends
1593:             loc_cPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
1594:             loc_cPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT
1595: 
1596:             IF !loc_lBypassTeste
1597:                 THIS.this_oBusinessObject.CarregarPendencias()
1598:             ENDIF

*-- Linhas 1759 a 2138:
1759:         CATCH TO loc_oErro
1760:             MsgErro(loc_oErro.Message + CHR(13) + ;
1761:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1762:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CarregarGrade")
1763:         ENDTRY
1764: 
1765:         RETURN loc_lSucesso
1766:     ENDPROC
1767: 
1768:     *--------------------------------------------------------------------------
1769:     * VincularGradeDetalhe - liga UMA das duas grades de detalhe ao seu
1770:     * cursor. As duas tem as MESMAS 9 colunas, nas MESMAS ControlSource do
1771:     * legado (Nops/CMats/CGrus/CUnis/TpOps/Qtds/Pesos/Cats/NEnvs, nessa
1772:     * ordem), por isso o bind eh um metodo unico - so largura e titulo
1773:     * diferem, e ficam no chamador.
1774:     *
1775:     * SET ORDER TO EmpDopNum + SET KEY TO reproduzem o filtro mestre-detalhe
1776:     * do legado ("Select xPnensiT / Set Order to EmpDopNum / Go Top / Set
1777:     * Key To <chave de TmpPends>"). Em xPNensi o legado conta com o indice
1778:     * EmpDopNum estar ativo por ser o ULTIMO criado - aqui a ordem eh
1779:     * explicita, que eh o mesmo efeito sem depender dessa ordem.
1780:     *
1781:     * Todas as 9 colunas voltam a ReadOnly = .T. DEPOIS do RecordSource: as
1782:     * duas grades sao de exibicao (no legado cada Text1 delas tem
1783:     * "When: Return .f.") e o RecordSource faz a coluna herdar de novo o
1784:     * ReadOnly = .F. do Grid.
1785:     *--------------------------------------------------------------------------
1786:     PROTECTED PROCEDURE VincularGradeDetalhe(par_oGrade, par_cCursor, par_cChave)
1787:         LOCAL loc_nI
1788: 
1789:         SELECT (par_cCursor)
1790:         SET ORDER TO EmpDopNum
1791:         GO TOP
1792:         IF EMPTY(par_cChave)
1793:             SET KEY TO
1794:         ELSE
1795:             SET KEY TO par_cChave
1796:         ENDIF
1797: 
1798:         *-- RecordSource FORA do WITH (regra do projeto): mexer em
1799:         *-- RecordSource recria as Column, e acessa-las dentro do MESMO
1800:         *-- WITH que acabou de atribuir RecordSource estoura 'Unknown
1801:         *-- member COLUMN1'
1802:         par_oGrade.RecordSource = par_cCursor
1803: 
1804:         WITH par_oGrade
1805:             .Column1.ControlSource = par_cCursor + ".Nops"
1806:             .Column2.ControlSource = par_cCursor + ".CMats"
1807:             .Column3.ControlSource = par_cCursor + ".CGrus"
1808:             .Column4.ControlSource = par_cCursor + ".CUnis"
1809:             .Column5.ControlSource = par_cCursor + ".TpOps"
1810:             .Column6.ControlSource = par_cCursor + ".Qtds"
1811:             .Column7.ControlSource = par_cCursor + ".Pesos"
1812:             .Column8.ControlSource = par_cCursor + ".Cats"
1813:             .Column9.ControlSource = par_cCursor + ".NEnvs"
1814:         ENDWITH
1815: 
1816:         *-- Column.ReadOnly SEMPRE depois do Grid.ReadOnly (o do Grid
1817:         *-- propaga e sobrescreve) - regra #18/#46
1818:         FOR loc_nI = 1 TO par_oGrade.ColumnCount
1819:             par_oGrade.Columns(loc_nI).ReadOnly = .T.
1820:         ENDFOR
1821: 
1822:         SELECT (par_cCursor)
1823:         GO TOP
1824:         par_oGrade.Refresh()
1825:     ENDPROC
1826: 
1827:     *--------------------------------------------------------------------------
1828:     * CarregarLista - nome canonico de carga do projeto; funil unico para
1829:     * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness chama de fora -
1830:     * regra #3).
1831:     *--------------------------------------------------------------------------
1832:     PROCEDURE CarregarLista()
1833:         RETURN THIS.CarregarGrade()
1834:     ENDPROC
1835: 
1836:     *--------------------------------------------------------------------------
1837:     * ChkSelecionarInteractiveChange - legado: SIGOPMPN.Grade.seleciona.
1838:     * fwcheckbox1.InteractiveChange:
1839:     *     =DoDefault()
1840:     *     If Not This.Value
1841:     *         ThisForm.Desmarca
1842:     *     Else
1843:     *         This.Value = ThisForm.Marca()
1844:     *     EndIf
1845:     *
1846:     * O ControlSource ja gravou o novo valor em TmpPends.Flag ANTES deste
1847:     * handler disparar. THIS.this_oBusinessObject.CarregarDoCursor() le a
1848:     * linha CORRENTE (this_cEmps/this_cDopps/this_nNumps/this_dDatas), que
1849:     * Marcar()/Desmarcar() usam. Em .T. (marcando), Marcar() pode recusar
1850:     * (duplicidade/numeracao-automatica/data) - nesse caso desfaz o Flag,
1851:     * equivalente a "This.Value = ThisForm.Marca()" quando o retorno eh
1852:     * .F. Quando Marcar() sinaliza this_lFecharAposMarcar (legado:
1853:     * "This.ok.click" dentro do proprio marca, ramo _NumeroAnt), o RETURN
1854:     * fica FORA do TRY (regra #1) e so entao fecha via CmdOkClick.
1855:     *
1856:     * PUBLIC (regra #3: alvo de BINDEVENT).
1857:     *--------------------------------------------------------------------------
1858:     PROCEDURE ChkSelecionarInteractiveChange()
1859:         LOCAL loc_cAlias, loc_lNovoValor, loc_lResultado, loc_lFechar, loc_oErro
1860: 
1861:         loc_lFechar = .F.
1862: 
1863:         TRY
1864:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1865: 
1866:             IF USED(loc_cAlias)
1867:                 SELECT (loc_cAlias)
1868:                 loc_lNovoValor = ConverterParaLogico(Flag)
1869: 
1870:                 THIS.this_oBusinessObject.CarregarDoCursor()
1871: 
1872:                 IF loc_lNovoValor
1873:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.F.)
1874: 
1875:                     IF !loc_lResultado
1876:                         SELECT (loc_cAlias)
1877:                         REPLACE Flag WITH .F.
1878:                     ELSE
1879:                         loc_lFechar = THIS.this_oBusinessObject.this_lFecharAposMarcar
1880:                     ENDIF
1881:                 ELSE
1882:                     THIS.this_oBusinessObject.Desmarcar()
1883:                 ENDIF
1884: 
1885:                 IF !loc_lFechar
1886:                     SELECT (loc_cAlias)
1887:                     THIS.grd_4c_Grade.Refresh()
1888:                 ENDIF
1889:             ENDIF
1890:         CATCH TO loc_oErro
1891:             MsgErro(loc_oErro.Message + CHR(13) + ;
1892:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1893:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.ChkSelecionarInteractiveChange")
1894:         ENDTRY
1895: 
1896:         IF loc_lFechar
1897:             THIS.CmdOkClick()
1898:         ENDIF
1899:     ENDPROC
1900: 
1901:     *--------------------------------------------------------------------------
1902:     * CmdSelTudoClick - legado: SIGOPMPN.SelTudo.Click
1903:     *     Select TmpPends
1904:     *     Scan For Not Flag
1905:     *         Replace Flag With ThisForm.Marca(.t.)
1906:     *     EndScan
1907:     *     ThisForm.Grade.Refresh
1908:     *
1909:     * Interrompe o Scan (EXIT) e fecha o dialogo (CmdOkClick) assim que
1910:     * Marcar() sinalizar this_lFecharAposMarcar - mesma semantica do
1911:     * legado, onde "This.ok.click" dentro de marca() libera (Release) o
1912:     * form NO MEIO do Scan.
1913:     *--------------------------------------------------------------------------
1914:     PROCEDURE CmdSelTudoClick()
1915:         LOCAL loc_cAlias, loc_lResultado, loc_lFecharApos, loc_oErro
1916: 
1917:         loc_lFecharApos = .F.
1918: 
1919:         TRY
1920:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1921: 
1922:             IF USED(loc_cAlias)
1923:                 SELECT (loc_cAlias)
1924:                 SCAN FOR !Flag
1925:                     THIS.this_oBusinessObject.CarregarDoCursor()
1926:                     loc_lResultado = THIS.this_oBusinessObject.Marcar(.T.)
1927: 
1928:                     SELECT (loc_cAlias)
1929:                     REPLACE Flag WITH loc_lResultado
1930: 
1931:                     IF loc_lResultado AND THIS.this_oBusinessObject.this_lFecharAposMarcar
1932:                         loc_lFecharApos = .T.
1933:                         EXIT
1934:                     ENDIF
1935: 
1936:                     SELECT (loc_cAlias)
1937:                 ENDSCAN
1938: 
1939:                 IF !loc_lFecharApos
1940:                     THIS.grd_4c_Grade.Refresh()
1941:                 ENDIF
1942:             ENDIF
1943:         CATCH TO loc_oErro
1944:             MsgErro(loc_oErro.Message + CHR(13) + ;
1945:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1946:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdSelTudoClick")
1947:         ENDTRY
1948: 
1949:         IF loc_lFecharApos
1950:             THIS.CmdOkClick()
1951:         ENDIF
1952:     ENDPROC
1953: 
1954:     *--------------------------------------------------------------------------
1955:     * CmdApagaClick - legado: SIGOPMPN.apaga.Click
1956:     *     Select TmpPends
1957:     *     Scan For Flag
1958:     *         Replace Flag With ThisForm.DesMarca()
1959:     *     EndScan
1960:     *     ThisForm.Grade.Refresh
1961:     *
1962:     * DESVIO DOCUMENTADO: "DesMarca()" no legado so tem "Return 0" no
1963:     * caminho de ERRO (falha de SqlExecute); sem RETURN explicito no
1964:     * caminho normal, VFP devolve .T. implicito - logo "Replace Flag With
1965:     * ThisForm.DesMarca()" tende a GRAVAR Flag = .T. de volta (reversao
1966:     * acidental do proprio "apagar"), e no caminho de erro tentaria gravar
1967:     * o NUMERO 0 num campo Logico (type mismatch). Mesmo padrao ja adotado
1968:     * em FormSigOpMpd.CmdApagaClick (mesma familia de tela): zera Flag
1969:     * ANTES de chamar Desmarcar(), sem depender do retorno.
1970:     *--------------------------------------------------------------------------
1971:     PROCEDURE CmdApagaClick()
1972:         LOCAL loc_cAlias, loc_oErro
1973: 
1974:         TRY
1975:             loc_cAlias = THIS.this_oBusinessObject.this_cCursorPends
1976: 
1977:             IF USED(loc_cAlias)
1978:                 SELECT (loc_cAlias)
1979:                 SCAN FOR Flag
1980:                     SELECT (loc_cAlias)
1981:                     REPLACE Flag WITH .F.
1982:                     THIS.this_oBusinessObject.CarregarDoCursor()
1983:                     THIS.this_oBusinessObject.Desmarcar()
1984:                     SELECT (loc_cAlias)
1985:                 ENDSCAN
1986: 
1987:                 THIS.grd_4c_Grade.Refresh()
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro(loc_oErro.Message + CHR(13) + ;
1991:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1992:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpMpn.CmdApagaClick")
1993:         ENDTRY
1994:     ENDPROC
1995: 
1996:     *--------------------------------------------------------------------------
1997:     * CmdTotalizaClick - legado: SIGOPMPN.Totaliza.Click. Alterna grd_4c_
1998:     * Itens (Gradeitem) com grd_4c_Total (GradeTotal) via this_nContador
1999:     * (legado: ThisForm.contador/ContaDor).
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE CmdTotalizaClick()
2002:         IF THIS.this_nContador = 0
2003:             THIS.grd_4c_Itens.Visible = .F.
2004:             THIS.grd_4c_Total.Visible = .T.
2005:             THIS.grd_4c_Total.Refresh()
2006:             THIS.this_nContador       = 1
2007:             THIS.cmd_4c_Totaliza.Caption = "Itens"
2008:         ELSE
2009:             THIS.grd_4c_Itens.Visible = .T.
2010:             THIS.grd_4c_Total.Visible = .F.
2011:             THIS.grd_4c_Itens.Refresh()
2012:             THIS.this_nContador       = 0
2013:             THIS.cmd_4c_Totaliza.Caption = "Totaliza"
2014:         ENDIF
2015:     ENDPROC
2016: 
2017:     *--------------------------------------------------------------------------
2018:     * GradeAfterRowColChange - legado: SIGOPMPN.Grade.AfterRowColChange.
2019:     * Reaplica o "Set Key To" das duas grades de detalhe (itens/total) com
2020:     * a chave da linha NOVA de TmpPends (regra #46: SEM filtro de coluna -
2021:     * este handler recarrega o DETALHE da linha corrente, nao valida
2022:     * celula).
2023:     *
2024:     * PUBLIC (regra #3: alvo de BINDEVENT).
2025:     *--------------------------------------------------------------------------
2026:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
2027:         LOCAL loc_cAliasPends, loc_cAliasPNensi, loc_cAliasPNensiT, loc_cChave
2028: 
2029:         loc_cAliasPends   = THIS.this_oBusinessObject.this_cCursorPends
2030:         loc_cAliasPNensi  = THIS.this_oBusinessObject.this_cCursorPNensi
2031:         loc_cAliasPNensiT = THIS.this_oBusinessObject.this_cCursorPNensiT
2032: 
2033:         IF !USED(loc_cAliasPends) OR EOF(loc_cAliasPends)
2034:             RETURN
2035:         ENDIF
2036: 
2037:         *-- Chave POSICIONAL char(33) (regra #42): Emps/Dopps sao colunas
2038:         *-- CHAR fixas de TmpPends, lidas direto (sem ALLTRIM)
2039:         loc_cChave = EVALUATE(loc_cAliasPends + ".Emps") + EVALUATE(loc_cAliasPends + ".Dopps") + ;
2040:             STR(EVALUATE(loc_cAliasPends + ".Numps"), 10)
2041: 
2042:         IF USED(loc_cAliasPNensiT)
2043:             SELECT (loc_cAliasPNensiT)
2044:             SET KEY TO loc_cChave
2045:             GO TOP
2046:         ENDIF
2047: 
2048:         IF USED(loc_cAliasPNensi)
2049:             SELECT (loc_cAliasPNensi)
2050:             SET KEY TO loc_cChave
2051:             GO TOP
2052:         ENDIF
2053: 
2054:         THIS.grd_4c_Itens.Refresh()
2055:         THIS.obj_4c_Mm_obs.Refresh()
2056:     ENDPROC
2057: 
2058:     *--------------------------------------------------------------------------
2059:     * CmdOkClick - legado: SIGOPMPN.ok.Click. Grava (SigOpMpnBO.
2060:     * ConfirmarMovimentacoes - xMFas/xOpi/xNensi/SigCdNec) e so fecha o
2061:     * dialogo se a gravacao for bem-sucedida: no legado, qualquer "Return
2062:     * 0" dentro do Click aborta ANTES das duas ultimas linhas
2063:     * (ParentForm.Enabled = .t. / ThisForm.Release), ou seja, erro mantem
2064:     * a tela aberta (o MsgErro ja foi mostrado dentro do BO).
2065:     *--------------------------------------------------------------------------
2066:     PROCEDURE CmdOkClick()
2067:         IF THIS.this_oBusinessObject.ConfirmarMovimentacoes()
2068:             THIS.FecharDialogo()
2069:         ENDIF
2070:     ENDPROC
2071: 
2072:     *--------------------------------------------------------------------------
2073:     * FecharDialogo - saida UNICA da tela. O dialogo tem ControlBox = .F.
2074:     * e Closable = .F. (valores do SCX legado), portanto nao ha X nem ESC:
2075:     * o botao OK (apos gravar) eh o unico caminho que o legado oferece, e
2076:     * todos os nomes canonicos de saida do projeto apontam para aqui.
2077:     *--------------------------------------------------------------------------
2078:     PROCEDURE FecharDialogo()
2079:         THIS.Release()
2080:     ENDPROC
2081: 
2082:     *--------------------------------------------------------------------------
2083:     * BtnEncerrarClick - nome canonico do projeto para o botao de saida.
2084:     * Aqui o botao de saida eh o OK do legado (SIGOPMPN.ok), por isso
2085:     * delega ao mesmo funil (que grava antes de fechar).
2086:     *--------------------------------------------------------------------------
2087:     PROCEDURE BtnEncerrarClick()
2088:         THIS.CmdOkClick()
2089:     ENDPROC
2090: 
2091:     *--------------------------------------------------------------------------
2092:     * BtnCancelarClick - nome canonico do projeto para "sair sem gravar".
2093:     * O legado nao oferece esse caminho (ControlBox = .F., sem ESC) - o
2094:     * UNICO jeito de sair eh o OK, que ja grava. Delega ao mesmo funil em
2095:     * vez de dar ao usuario a impressao falsa de que ha algo a descartar.
2096:     *--------------------------------------------------------------------------
2097:     PROCEDURE BtnCancelarClick()
2098:         THIS.CmdOkClick()
2099:     ENDPROC
2100: 
2101:     *--------------------------------------------------------------------------
2102:     * Destroy - reabilita o form pai (legado: ThisForm.ParentForm.Enabled
2103:     * nao aparece explicito no dump de SIGOPMPN, mas reforcar aqui segue o
2104:     * mesmo padrao de seguranca de FormSigOpMpd.prg - cobre fechamento por
2105:     * qualquer caminho) e libera o Business Object. Fecha tambem TmpPends
2106:     * (cursor proprio desta tela, criado nas fases seguintes - guard
2107:     * USED() o torna seguro mesmo antes de existir). DODEFAULT() por
2108:     * ULTIMO (regra do projeto: sem ela os popups do menu principal
2109:     * encolhem visualmente apos o form fechar).
2110:     *--------------------------------------------------------------------------
2111:     PROCEDURE Destroy()
2112:         IF VARTYPE(THIS.this_oFormPai) = "O"
2113:             THIS.this_oFormPai.Enabled = .T.
2114:         ENDIF
2115: 
2116:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2117:             THIS.this_oBusinessObject = .NULL.
2118:         ENDIF
2119: 
2120:         *-- Cursores PROPRIOS desta tela (criados por
2121:         *-- SigOpMpnBO.CriarCursoresGrades). Os cursores do form PAI
2122:         *-- (TmpNens/TmpOperacao/xMFas/xOpi/xPesa/xNensi) NAO sao fechados
2123:         *-- aqui: pertencem a ele e continuam em uso depois que o dialogo
2124:         *-- fecha.
2125:         IF USED("TmpPends")
2126:             USE IN TmpPends
2127:         ENDIF
2128:         IF USED("xPNensi")
2129:             USE IN xPNensi
2130:         ENDIF
2131:         IF USED("xPNensiT")
2132:             USE IN xPNensiT
2133:         ENDIF
2134: 
2135:         DODEFAULT()
2136:     ENDPROC
2137: 
2138: ENDDEFINE

