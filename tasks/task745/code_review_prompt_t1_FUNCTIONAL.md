# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.ObterValorExato()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirPicker()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpHis.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1639 linhas total):

*-- Linhas 19 a 107:
19: * CLAUDE.md #9.4).
20: *
21: * Montagem (migracao multi-fase):
22: *   Fase 3 (ja feita) - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
23: *                       cnt_4c_Sombra, TornarControlesVisiveis.
24: *   Fase 4 (feita)    - SEM TRABALHO, medido no dump (tasks/task745/
25: *                       SigOpHis_form_codigo_fonte.txt): ZERO BaseClass
26: *                       grid|pageframe|listbox, ZERO AddCursor/pColuna/
27: *                       Grade/grd, ZERO RecordSource; a UNICA ocorrencia de
28: *                       ControlSource (Get_grupo) eh override VAZIO ("")
29: *                       (regra #49 - nao transcrever, nao conta como
30: *                       lista). O form inteiro eh um dialogo de CAPTURA
31: *                       (8 fwget + CommandGroup "sair" com 2 botoes -
32: *                       Consulta/Encerrar), sem nenhuma superficie de
33: *                       LISTA para entregar Grid+CRUD (Incluir/
34: *                       Visualizar/Alterar/Excluir/Buscar/Encerrar) -
35: *                       inventar essa grade violaria o PILAR 1 ("manter
36: *                       o mais proximo possivel") e a regra "NUNCA
37: *                       inventar lista que o legado nao tem". Mesmo
38: *                       perfil ja registrado em SigOpChp (task699),
39: *                       SigOpCtd (task715) e SigOpCts (task717) - ver
40: *                       memoria
41: *                       feedback_noop_guard_sem_excecao_para_fase_sem_trabalho.
42: *   Fase 5 (feita)    - metade dos campos de filtro: Grupo (Get_grupo/
43: *                       Get_Dgrupo) e Conta (Get_est/Get_dest), via
44: *                       ConfigurarCamposFiltro().
45: *   Fase 6 (esta)     - segunda metade dos campos: Produto (Get_cod/
46: *                       Get_dcod) e Periodo (Get_DataIni/Say5/
47: *                       Get_DataFin), via ConfigurarCamposFiltro(), com
48: *                       as duas datas nascendo em DATE() como no Init
49: *                       legado; o CommandGroup "sair" (Consulta +
50: *                       Encerrar), via ConfigurarBotoesAcao() -
51: *                       geometria/icones/captions transcritos do dump
52: *                       (Command1="consulta"/Command2="sair"); e os SEIS
53: *                       LOOKUPS dos campos de codigo/descricao, ligados
54: *                       por BINDEVENT("LostFocus") + BINDEVENT("KeyPress")
55: *                       (F4 = 115) e resolvidos por SELECT TOP 1 exato +
56: *                       FormBuscaAuxiliar sobre SigCdGcr (Grupo),
57: *                       SigCdCli (Conta) e SigCdPro (Produto) - regra
58: *                       CLAUDE.md #36/#37/#47/#50, no lugar do
59: *                       fAcessoContab/fAcessoContas/fwBuscaExt do legado.
60: *                       O When de Get_Dgrupo/Get_dest/Get_dcod vira
61: *                       AjustarCamposDependentes().
62: *   Fase 7 (esta)     - eventos dos DOIS botoes que o legado tem, com o
63: *                       BINDEVENT("Click") de obj_4c_Sair.Buttons(1)/(2):
64: *                       BtnConsultaClick (consulta.Click - FormParaBO() +
65: *                       SigOpHisBO.ValidarFiltro() + MsgAviso/
66: *                       FocarCampoRecusado() no campo recusado e, se
67: *                       valido, Enabled=.F. + CREATEOBJECT("FormSigPrHpr",
68: *                       THIS) com as PRIVATE pcCd*/pdData* declaradas no
69: *                       handler) e BtnEncerrarClick (sair.Click ->
70: *                       THIS.Release()). NAO ha BtnIncluir/Alterar/
71: *                       Visualizar/ExcluirClick: o legado nao tem CRUD
72: *                       algum (herda de "form" puro, sem frmcadastro, sem
73: *                       Grupo_Op e sem pcEscolha) - ver o bloco "EVENTOS
74: *                       DOS BOTOES DE ACAO" adiante.
75: *   Fase 8 (esta)     - BOParaForm(), contraparte simetrica de FormParaBO()
76: *                       que faltava para fechar o contrato de form - o
77: *                       gate da Fase 8 classifica este dialogo como
78: *                       layout FILTRO-DESPACHO (legado sem lista/grade,
79: *                       sem CRUD, sem persistencia, despachando via
80: *                       "Do Form" para outro form), que dispensa
81: *                       BtnCancelarClick/CarregarLista mas EXIGE
82: *                       FormParaBO/BOParaForm/Btn\w*Click - os dois
83: *                       ultimos ja existiam desde a Fase 7. Chamado de
84: *                       ConfigurarPageFrame() ao final da montagem, para
85: *                       nao ficar metodo morto (regra "sem stub"):
86: *                       centraliza no BO (ja com os defaults postos em
87: *                       SigOpHisBO.Init()) a origem dos valores em branco
88: *                       do dialogo, em vez de duplicar literal "" /
89: *                       DATE() tanto no AddObject quanto no BO. Revisao
90: *                       final de completude: sem TODO/stub, Fases 3-8
91: *                       presentes.
92: *
93: * Nomes de objeto conforme tasks/task745/mapeamento.json.
94: *==============================================================================
95: 
96: DEFINE CLASS FormSigOpHis AS FormBase
97: 
98:     *--------------------------------------------------------------------------
99:     * Propriedades do form (SIGOPHIS.SCX: DataSession=2, BorderStyle=2,
100:     * Height=300, Width=650, AutoCenter=.T., ControlBox=.F., MaxButton=.F.,
101:     * MinButton=.F., TitleBar=0 - dump linhas 138-151). Closable NAO consta
102:     * do dump - nao inventar (feedback Closable_inventado_tira_a_unica_saida).
103:     *--------------------------------------------------------------------------
104:     DataSession  = 2
105:     Width        = 650
106:     Height       = 300
107:     AutoCenter   = .T.

*-- Linhas 117 a 319:
117: 
118:     *--------------------------------------------------------------------------
119:     * this_lEmLookup - guarda de reentrancia dos lookups (regra CLAUDE.md #37
120:     * e #47). O picker (FormBuscaAuxiliar) eh MODAL: ao receber o foco ele
121:     * dispara de novo o LostFocus do campo que o abriu, o que empilharia um
122:     * segundo dialogo. O corpo de cada handler vive num <Nome>Exec() para que
123:     * a flag seja SEMPRE liberada pelo wrapper, inclusive nos RETURN
124:     * antecipados; os irmaos de F4 usam save/restore (loc_lEmLookupAnt) porque
125:     * compoem sob aninhamento.
126:     *--------------------------------------------------------------------------
127:     this_lEmLookup = .F.
128: 
129:     Caption = "Hist" + CHR(243) + "rico de Produtos"
130: 
131:     *--------------------------------------------------------------------------
132:     * Init - cria o Business Object antes do DODEFAULT(), para que
133:     * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
134:     * encontre pronto.
135:     *--------------------------------------------------------------------------
136:     PROCEDURE Init()
137:         LOCAL loc_lSucesso, loc_oErro
138:         loc_lSucesso = .F.
139: 
140:         TRY
141:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpHisBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
144:                 loc_lSucesso = DODEFAULT()
145:             ELSE
146:                 MsgErro("Falha ao criar SigOpHisBO.", "Erro")
147:             ENDIF
148:         CATCH TO loc_oErro
149:             MsgErro("Erro ao inicializar Hist" + CHR(243) + "rico de Produtos: " + ;
150:                 loc_oErro.Message, "Erro")
151:         ENDTRY
152: 
153:         RETURN loc_lSucesso
154:     ENDPROC
155: 
156:     *--------------------------------------------------------------------------
157:     * Destroy - encadeia direto para FormBase.Destroy() (libera
158:     * this_oBusinessObject e restaura o menu principal).
159:     *--------------------------------------------------------------------------
160:     PROCEDURE Destroy()
161:         DODEFAULT()
162:     ENDPROC
163: 
164:     *--------------------------------------------------------------------------
165:     * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo e
166:     * cabecalho nesta fase; campos e botoes nas fases seguintes.
167:     *--------------------------------------------------------------------------
168:     PROTECTED PROCEDURE InicializarForm()
169:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
170:         loc_lSucesso = .F.
171: 
172:         TRY
173:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
174:                 MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Erro")
175:             ELSE
176:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
177:                 IF FILE(loc_cPicture)
178:                     THIS.Picture = loc_cPicture
179:                 ENDIF
180: 
181:                 THIS.ConfigurarPageFrame()
182: 
183:                 THIS.TornarControlesVisiveis(THIS)
184: 
185:                 loc_lSucesso = .T.
186:             ENDIF
187:         CATCH TO loc_oErro
188:             MsgErro(loc_oErro.Message + CHR(13) + ;
189:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
190:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpHis.InicializarForm")
191:         ENDTRY
192: 
193:         RETURN loc_lSucesso
194:     ENDPROC
195: 
196:     *--------------------------------------------------------------------------
197:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGOPHIS nao
198:     * tem PageFrame no legado (layout flat: cntSombra + campos + botao de
199:     * saida direto no form) - o nome do metodo e mantido apenas como ponto
200:     * de entrada arquitetural padrao (mesmo papel em Formsigopfin/
201:     * FormSigPrHpr).
202:     *
203:     * Fase 3 (feita)  - ConfigurarCabecalho() (cnt_4c_Sombra).
204:     * Fase 5 (feita)  - ConfigurarCamposFiltro() com a metade Grupo/Conta.
205:     * Fase 6 (feita)  - completar ConfigurarCamposFiltro() com Produto/
206:     *                   Periodo + o BINDEVENT dos seis lookups, e
207:     *                   ConfigurarBotoesAcao() (CommandGroup "sair":
208:     *                   Consulta/Encerrar).
209:     * Fase 8 (esta)   - BOParaForm() apos ConfigurarCamposFiltro(), para
210:     *                   que o estado inicial dos TextBox venha do BO
211:     *                   (fonte unica dos defaults do dialogo).
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarPageFrame()
214:         THIS.ConfigurarCabecalho()
215:         THIS.ConfigurarCamposFiltro()
216:         THIS.BOParaForm()
217:         THIS.ConfigurarBotoesAcao()
218:     ENDPROC
219: 
220:     *--------------------------------------------------------------------------
221:     * ConfigurarCamposFiltro - campos de filtro do dialogo. Todos filhos
222:     * diretos de THIS (form flat, sem PageFrame real - regra documentada no
223:     * cabecalho do arquivo).
224:     *
225:     * Fase 5 (feita): metade Grupo (Say4+Get_grupo+Get_Dgrupo) e Conta
226:     * (Say1+Get_est+Get_dest). Fase 6 (esta) completa com Produto
227:     * (Say2+Get_cod+Get_dcod), Periodo (Say3+Get_DataIni+Say5+Get_DataFin) e
228:     * o BINDEVENT dos seis lookups.
229:     *
230:     * Geometria TRANSCRITA do dump (tasks/task745/SigOpHis_form_codigo_
231:     * fonte.txt): Say1/Say2/Say3/Say4/Say5 sao classe "say" (AutoSize=.T./
232:     * Alignment=0 no legado, sem Width declarado) - regra CLAUDE.md #23:
233:     * usar AutoSize=.F. + Alignment=0 + Width que caiba o texto (nao
234:     * inventar Alignment=1), FontBold=.T. por nao haver override no dump
235:     * (mesmo padrao do irmao FormSigOpBcb). Width=38..52/Height=15 seguem o
236:     * padrao do projeto para as legendas "Grupo :"/"Conta :"/"Produto :"/
237:     * "Per" + CHR(237) + "odo :" (FormSIGRECMV, FormSigReCsp, FormSIGRECND,
238:     * FormSIGREAPR, Formsigreapp). Say5 ("CHR(224)" - separador "a" das
239:     * datas, mesmo CHR() do separador de periodo em FormBAL) nao tem
240:     * Width/Alignment no dump - AutoSize=.F. com Width=10 so para caber o
241:     * caractere.
242:     *
243:     * Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/Get_dcod/Get_DataIni/
244:     * Get_DataFin sao classe "fwget" (BaseClass textbox) - Height=23 so
245:     * consta explicito no dump para Get_grupo; os demais nao declaram
246:     * (extracao terse desta task) e seguem o mesmo valor para alinhar
247:     * visualmente a linha. FontName/FontSize/BackStyle/BorderStyle/
248:     * SpecialEffect/ForeColor seguem o padrao canonico de fwget do projeto
249:     * (FormSigOpBcb/FormSigOpCcl); Get_est preserva o UNICO override de
250:     * fonte do dump (FontName="Courier New").
251:     *
252:     * MaxLength: Get_grupo/Get_Dgrupo validam contra SigCdGcr.codigos
253:     * char(10)/descrs char(40) (fAcessoContab - Framework\sigacess.PRG:1029,
254:     * 1104/1107); Get_est/Get_dest contra SigCdCli.iclis char(10)/rclis
255:     * char(50) (fAcessoContas - Framework\sigacess.PRG:158, linha 63 do
256:     * corpo); Get_cod/Get_dcod contra SigCdPro.cpros char(14)/dpros char(65)
257:     * (docs/schema.sql - cpros bate com o MaxLength=14 ja declarado no dump
258:     * linha 251; dpros nao tem MaxLength explicito no dump, usar a largura
259:     * da coluna). Get_DataIni/Get_DataFin usam MaxLength=10 (dump linhas
260:     * 369/392 - tamanho da mascara "99/99/9999") - regra CLAUDE.md #19,
261:     * MaxLength vem da coluna/mascara, nunca do Width em pixels. Confirmado
262:     * em docs/schema.sql (UTF-16).
263:     *
264:     * Get_DataIni/Get_DataFin sao campos de DATA (Alignment=3 - dump linhas
265:     * 365/389), nao char: nascem em DATE(), nao em SPACE(N), reproduzindo o
266:     * Init legado (ThisForm.get_dataini.Value = Date() / get_datafin.Value =
267:     * Date()). InputMask="99/99/9999"
268:     * so consta explicito no dump para Get_DataFin (linha 390); aplicado
269:     * tambem a Get_DataIni para a mesma mascara visual nos dois campos da
270:     * linha.
271:     *
272:     * Sem ControlSource (comportamento.json confirma totalQueries=0 - os oito
273:     * campos sao de CAPTURA e os seis de lookup resolvem o par codigo/
274:     * descricao por consulta propria, nao por vinculo de cursor). O BINDEVENT
275:     * dos seis lookups fecha este metodo; o bloco LOOKUPS DOS CAMPOS DE
276:     * FILTRO, mais abaixo, documenta a correspondencia com o Valid/When do
277:     * legado.
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
280:         LOCAL loc_oErro
281: 
282:         TRY
283:             *-- Say4 "Grupo :"
284:             THIS.AddObject("lbl_4c_Label4", "Label")
285:             WITH THIS.lbl_4c_Label4
286:                 .Top       = 124
287:                 .Left      = 101
288:                 .Width     = 38
289:                 .Height    = 15
290:                 .AutoSize  = .F.
291:                 .Alignment = 0
292:                 .BackStyle = 0
293:                 .FontName  = "Tahoma"
294:                 .FontSize  = 8
295:                 .FontBold  = .T.
296:                 .ForeColor = RGB(90, 90, 90)
297:                 .Caption   = "Grupo :"
298:                 .Visible   = .T.
299:             ENDWITH
300: 
301:             *-- Get_grupo - codigo do Grupo Contabil (SigCdGcr.codigos)
302:             THIS.AddObject("txt_4c_Grupo", "TextBox")
303:             WITH THIS.txt_4c_Grupo
304:                 .Top           = 121
305:                 .Left          = 148
306:                 .Width         = 80
307:                 .Height        = 23
308:                 .FontName      = "Tahoma"
309:                 .FontSize      = 9
310:                 .FontBold      = .F.
311:                 .FontItalic    = .F.
312:                 .FontUnderline = .F.
313:                 .Alignment     = 0
314:                 .BackStyle     = 1
315:                 .BorderStyle   = 1
316:                 .SpecialEffect = 1
317:                 .MaxLength     = 10
318:                 .ForeColor     = RGB(0, 0, 0)
319:                 .TabIndex      = 1

*-- Linhas 558 a 667:
558:             ENDWITH
559: 
560:             *----------------------------------------------------------
561:             * Lookups - BINDEVENT dos seis campos que o legado valida no
562:             * Valid (Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/
563:             * Get_dcod). Dois eventos por campo:
564:             *
565:             *   "LostFocus" - funil de validacao, equivalente ao Valid do
566:             *                 legado (dispara ao SAIR do campo). Ligar o
567:             *                 picker a "KeyPress" sem testar a tecla abre
568:             *                 o dialogo a CADA caractere digitado e o
569:             *                 usuario nao consegue terminar de digitar o
570:             *                 codigo (regra CLAUDE.md #47).
571:             *   "KeyPress"  - so abre o picker em F4 (par_nKeyCode = 115),
572:             *                 atalho padrao do projeto. O handler TESTA a
573:             *                 tecla, portanto nao incorre na regra #47.
574:             *
575:             * LostFocus nao recebe parametro algum - os handlers ligados a
576:             * ele NAO declaram par_nKeyCode (regra CLAUDE.md #3).
577:             *----------------------------------------------------------
578:             BINDEVENT(THIS.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
579:             BINDEVENT(THIS.txt_4c_Grupo,  "KeyPress",  THIS, "GrupoKeyPress")
580:             BINDEVENT(THIS.txt_4c_Dgrupo, "LostFocus", THIS, "DgrupoLostFocus")
581:             BINDEVENT(THIS.txt_4c_Dgrupo, "KeyPress",  THIS, "DgrupoKeyPress")
582: 
583:             BINDEVENT(THIS.txt_4c_Est,    "LostFocus", THIS, "EstLostFocus")
584:             BINDEVENT(THIS.txt_4c_Est,    "KeyPress",  THIS, "EstKeyPress")
585:             BINDEVENT(THIS.txt_4c_Dest,   "LostFocus", THIS, "DestLostFocus")
586:             BINDEVENT(THIS.txt_4c_Dest,   "KeyPress",  THIS, "DestKeyPress")
587: 
588:             BINDEVENT(THIS.txt_4c_Cod,    "LostFocus", THIS, "CodLostFocus")
589:             BINDEVENT(THIS.txt_4c_Cod,    "KeyPress",  THIS, "CodKeyPress")
590:             BINDEVENT(THIS.txt_4c_Dcod,   "LostFocus", THIS, "DcodLostFocus")
591:             BINDEVENT(THIS.txt_4c_Dcod,   "KeyPress",  THIS, "DcodKeyPress")
592: 
593:             *-- Estado inicial dos tres campos de descricao (reproduz o
594:             *-- PROCEDURE When de Get_Dgrupo/Get_dest/Get_dcod do legado).
595:             THIS.AjustarCamposDependentes()
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message + CHR(13) + ;
598:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
599:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposFiltro")
600:         ENDTRY
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * ConfigurarBotoesAcao - CommandGroup "sair" do dump (SIGOPHIS.sair,
605:     * ButtonCount=2, dump linhas 269-316). Buttons(1) = Command1/"consulta"
606:     * (Picture geral_procura_60.jpg, Caption "\<Consulta"), Buttons(2) =
607:     * Command2/"sair" (Picture cadastro_sair_60.jpg, Caption "Encerrar",
608:     * Cancel=.T.) - indexacao NUMERICA dos Buttons (CLAUDE.md regra #34),
609:     * nunca por .Name. Geometria/fonte/cores TRANSCRITAS do dump
610:     * (Top/Left/Height/Width/FontName="Comic Sans MS"/FontBold/FontItalic/
611:     * FontSize/WordWrap/ForeColor/BackColor/Themes=.F. de cada Command);
612:     * icones resolvidos via gc_4c_CaminhoIcones (regra CLAUDE.md #25 - o
613:     * legado aponta para Framework\imagens, mas os mesmos .jpg existem em
614:     * vbmp\gc_4c_CaminhoIcones, igual ao restante do projeto).
615:     *
616:     * CommandGroup.Left=493 do dump extrapola o Width=650 do form junto com
617:     * ButtonCount=2 (Left=493 + Width=161 = 654 > 650) - ajustado para
618:     * terminar dentro do form (Left = THIS.Width - 161 - 6), preservando a
619:     * geometria INTERNA dos dois Command (regra sobre controle fora da
620:     * area do pai ser recortado).
621:     *
622:     * CommandGroup NAO tem FontName (CLAUDE.md regra #33) - fonte so nos
623:     * Buttons(N) individuais. O Click dos dois botoes (Consulta/Encerrar) eh
624:     * ligado na fase de eventos do form, descrita no cabecalho do arquivo -
625:     * aqui o CommandGroup entrega a geometria e os icones do dump.
626:     *--------------------------------------------------------------------------
627:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
628:         LOCAL loc_oErro
629: 
630:         TRY
631:             THIS.AddObject("obj_4c_Sair", "CommandGroup")
632:             WITH THIS.obj_4c_Sair
633:                 .Top         = -2
634:                 .Left        = THIS.Width - 161 - 6
635:                 .Width       = 161
636:                 .Height      = 85
637:                 .ButtonCount = 2
638:                 .AutoSize    = .T.
639:                 .BackStyle   = 0
640:                 .BorderStyle = 0
641:                 .SpecialEffect = 1
642:                 .BorderColor = RGB(136, 188, 189)
643:                 .Themes      = .F.
644:                 .Value       = 1
645:                 .Visible     = .T.
646: 
647:                 WITH .Buttons(1)
648:                     .Top       = 5
649:                     .Left      = 5
650:                     .Height    = 75
651:                     .Width     = 75
652:                     .FontBold  = .T.
653:                     .FontItalic = .T.
654:                     .FontName  = "Comic Sans MS"
655:                     .FontSize  = 8
656:                     .WordWrap  = .T.
657:                     .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
658:                     .Caption   = "\<Consulta"
659:                     .ForeColor = RGB(90, 90, 90)
660:                     .BackColor = RGB(255, 255, 255)
661:                     .Themes    = .F.
662:                 ENDWITH
663: 
664:                 WITH .Buttons(2)
665:                     .Top       = 5
666:                     .Left      = 81
667:                     .Height    = 75

*-- Linhas 684 a 885:
684:             * Click dos dois botoes do CommandGroup. Buttons(N) eh
685:             * indexado por NUMERO (regra CLAUDE.md #34) e N <= ButtonCount
686:             * (= 2, declarado acima). Os dois delegates sao PUBLIC - metodo
687:             * PROTECTED falha em SILENCIO no BINDEVENT (regra #3).
688:             *----------------------------------------------------------
689:             BINDEVENT(THIS.obj_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultaClick")
690:             BINDEVENT(THIS.obj_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
691:         CATCH TO loc_oErro
692:             MsgErro(loc_oErro.Message + CHR(13) + ;
693:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
694:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
695:         ENDTRY
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * EVENTOS DOS BOTOES DE ACAO - obj_4c_Sair (CommandGroup "sair" do dump)
700:     *
701:     * O CommandGroup do legado tem DOIS botoes, cada um com o seu Click
702:     * (SIGOPHIS.sair.consulta.Click e SIGOPHIS.sair.sair.Click no dump):
703:     *
704:     *   Buttons(1) "\<Consulta" (consulta) -> BtnConsultaClick
705:     *   Buttons(2) "Encerrar"   (sair)     -> BtnEncerrarClick
706:     *
707:     * Esses dois botoes sao TODA a superficie de acao do legado: o SCX herda
708:     * de "form" PURO (nao de frmcadastro), nao tem Grupo_Op, nao declara
709:     * pcEscolha e nao possui nenhum objeto Incluir/Alterar/Visualizar/
710:     * Excluir - eh um dialogo de CAPTURA de filtros, nao um cadastro. Por
711:     * isso NAO existem aqui os BtnIncluirClick/BtnAlterarClick/
712:     * BtnVisualizarClick/BtnExcluirClick da convencao CRUD: cria-los
713:     * obrigaria a INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a
714:     * regra "NUNCA inventar") ou a escrever quatro metodos vazios (proibido
715:     * pela regra de completude).
716:     *
717:     * Os dois handlers sao PUBLIC - exigido por BINDEVENT (regra CLAUDE.md
718:     * #3) - e BtnEncerrarClick usa o nome canonico que o harness
719:     * TesteAutomatico reconhece no teste BtnEncerrarExiste.
720:     *==========================================================================
721: 
722:     *--------------------------------------------------------------------------
723:     * FormParaBO - transfere os oito campos da tela para o BO, na MESMA ordem
724:     * do bloco "Inicializa variaveis de campos" do consulta.Click legado:
725:     *
726:     *     pcCdGrupo   = ThisForm.get_grupo.Value
727:     *     pcCdConta   = ThisForm.get_est.Value
728:     *     pcDsConta   = ThisForm.get_dest.Value
729:     *     pcCdProduto = ThisForm.get_cod.Value
730:     *     pcDsProduto = ThisForm.get_dcod.Value
731:     *     pdDataIni   = ThisForm.get_dataini.Value
732:     *     pdDataFin   = ThisForm.get_datafin.Value
733:     *
734:     * FUNCTION (nao PROCEDURE) devolvendo .T./.F.: BtnConsultaClick ABORTA a
735:     * acao quando a transferencia falha, em vez de seguir validando
736:     * propriedades que ninguem alimentou (CLAUDE.md - "FormParaBO deve ser
737:     * FUNCTION e o chamador deve abortar quando ela falhar").
738:     *
739:     * Os codigos vao PADR na largura da coluna do schema (SigCdGcr.codigos
740:     * char(10), SigCdCli.iclis char(10), SigCdPro.cpros char(14)); as datas
741:     * passam por ConverterParaData(), que normaliza DATE/DATETIME/CHAR - os
742:     * dois TextBox nascem com DATE() mas sao DIGITADOS pelo usuario, e
743:     * TTOD() sobre um DATE dispara erro 11 em runtime (regra CLAUDE.md #16).
744:     *
745:     * PROTECTED porque FormBase.FormParaBO() eh PROTECTED: declarar PUBLIC
746:     * aqui NAO alargaria o escopo (o PROTECTED da classe base prevalece -
747:     * regra CLAUDE.md #51) e o metodo so eh alcancado por THIS. de dentro
748:     * da propria classe.
749:     *--------------------------------------------------------------------------
750:     PROTECTED FUNCTION FormParaBO()
751:         LOCAL loc_lSucesso, loc_oErro
752:         loc_lSucesso = .F.
753: 
754:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
755:             MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Erro")
756:             RETURN .F.
757:         ENDIF
758: 
759:         TRY
760:             *-- Alvo qualificado em TODA atribuicao: WITH aninhado sobre o BO
761:             *-- sequestraria o escopo dos THIS.txt_4c_* (regra CLAUDE.md #33).
762:             THIS.this_oBusinessObject.this_cGrupo    = PADR(ALLTRIM(THIS.txt_4c_Grupo.Value), 10)
763:             THIS.this_oBusinessObject.this_cDGrupo   = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
764:             THIS.this_oBusinessObject.this_cConta    = PADR(ALLTRIM(THIS.txt_4c_Est.Value), 10)
765:             THIS.this_oBusinessObject.this_cDConta   = ALLTRIM(THIS.txt_4c_Dest.Value)
766:             THIS.this_oBusinessObject.this_cProduto  = PADR(ALLTRIM(THIS.txt_4c_Cod.Value), 14)
767:             THIS.this_oBusinessObject.this_cDProduto = ALLTRIM(THIS.txt_4c_Dcod.Value)
768:             THIS.this_oBusinessObject.this_dDataIni  = ConverterParaData(THIS.txt_4c_DataIni.Value)
769:             THIS.this_oBusinessObject.this_dDataFin  = ConverterParaData(THIS.txt_4c_DataFin.Value)
770: 
771:             loc_lSucesso = .T.
772:         CATCH TO loc_oErro
773:             MsgErro(loc_oErro.Message + CHR(13) + ;
774:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
775:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
776:         ENDTRY
777: 
778:         RETURN loc_lSucesso
779:     ENDFUNC
780: 
781:     *--------------------------------------------------------------------------
782:     * BOParaForm - contraparte simetrica de FormParaBO(): espelha os oito
783:     * campos do BO (this_oBusinessObject, ja com os defaults postos em
784:     * SigOpHisBO.Init() - SPACE(10)/""/DATE()) de volta para os TextBox.
785:     *
786:     * Este dialogo nao tem registro proprio para "carregar" (nao ha tabela
787:     * SigOpHis - regra CLAUDE.md "BO somente-leitura"), entao BOParaForm
788:     * nao eh chamado apos um SEEK/SELECT como nos forms CRUD: o papel dele
789:     * aqui eh restaurar a tela para o estado em BRANCO do BO, chamado uma
790:     * unica vez por ConfigurarPageFrame() ao final da montagem (fonte
791:     * unica dos defaults do dialogo, em vez de duplicar o literal
792:     * "" / DATE() tanto no AddObject de ConfigurarCamposFiltro() quanto no
793:     * SigOpHisBO.Init()).
794:     *
795:     * PROTECTED pelo mesmo motivo de FormParaBO: FormBase.BOParaForm() eh
796:     * PROTECTED e o PROTECTED da classe base prevalece (regra CLAUDE.md
797:     * #51) - o metodo so e alcancado por THIS. de dentro da propria
798:     * classe.
799:     *--------------------------------------------------------------------------
800:     PROTECTED PROCEDURE BOParaForm()
801:         LOCAL loc_oErro
802: 
803:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
804:             RETURN
805:         ENDIF
806: 
807:         TRY
808:             THIS.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
809:             THIS.txt_4c_Dgrupo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDGrupo)
810:             THIS.txt_4c_Est.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
811:             THIS.txt_4c_Dest.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
812:             THIS.txt_4c_Cod.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cProduto)
813:             THIS.txt_4c_Dcod.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDProduto)
814:             THIS.txt_4c_DataIni.Value  = ConverterParaData(THIS.this_oBusinessObject.this_dDataIni)
815:             THIS.txt_4c_DataFin.Value  = ConverterParaData(THIS.this_oBusinessObject.this_dDataFin)
816: 
817:             *-- Reaplica a dependencia Codigo/Descricao (regra CLAUDE.md
818:             *-- #3/#34 nao se aplica aqui - chamada direta, nao BINDEVENT):
819:             *-- com os valores do BO em branco, os tres campos de
820:             *-- descricao voltam a ficar habilitados.
821:             THIS.AjustarCamposDependentes()
822:         CATCH TO loc_oErro
823:             MsgErro(loc_oErro.Message + CHR(13) + ;
824:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
825:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
826:         ENDTRY
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * FocarCampoRecusado - reproduz o "ThisForm.get_xxx.SetFocus" que cada
831:     * bloco "Consiste o Campo..." do consulta.Click legado executa antes de
832:     * Return(.F.). O campo vem de SigOpHisBO.this_cCampoFoco, preenchido por
833:     * ValidarFiltro() na mesma ordem do legado (Grupo -> Conta -> Produto ->
834:     * DataIni -> DataFin -> periodo invertido, que volta para DataIni).
835:     *
836:     * SetFocus() em controle desabilitado/invisivel estoura - daqui a guarda
837:     * por .Enabled/.Visible, ainda que os cinco campos de CODIGO nunca sejam
838:     * desabilitados (AjustarCamposDependentes so desabilita os campos de
839:     * DESCRICAO).
840:     *
841:     * PUBLIC: chamado pelos handlers de botao da propria classe e alcancavel
842:     * pelo harness de teste - metodo chamado de fora nao pode ser PROTECTED
843:     * (regra CLAUDE.md #3).
844:     *--------------------------------------------------------------------------
845:     PROCEDURE FocarCampoRecusado()
846:         LOCAL loc_cCampo, loc_oControle
847: 
848:         loc_cCampo = ""
849:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
850:             loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)
851:         ENDIF
852: 
853:         loc_oControle = .NULL.
854: 
855:         DO CASE
856:             CASE loc_cCampo == "Grupo"
857:                 loc_oControle = THIS.txt_4c_Grupo
858:             CASE loc_cCampo == "Conta"
859:                 loc_oControle = THIS.txt_4c_Est
860:             CASE loc_cCampo == "Produto"
861:                 loc_oControle = THIS.txt_4c_Cod
862:             CASE loc_cCampo == "DataIni"
863:                 loc_oControle = THIS.txt_4c_DataIni
864:             CASE loc_cCampo == "DataFin"
865:                 loc_oControle = THIS.txt_4c_DataFin
866:         ENDCASE
867: 
868:         IF VARTYPE(loc_oControle) = "O"
869:             IF loc_oControle.Enabled AND loc_oControle.Visible
870:                 loc_oControle.SetFocus()
871:             ENDIF
872:         ENDIF
873:     ENDPROC
874: 
875:     *--------------------------------------------------------------------------
876:     * BtnConsultaClick - Click de obj_4c_Sair.Buttons(1) ("\<Consulta"),
877:     * transcricao do SIGOPHIS.sair.consulta.Click legado (dump linhas
878:     * 601-660):
879:     *
880:     *     pcCdGrupo = ... (sete campos)
881:     *     If IsEmpty(pcCdGrupo)       -> 'Grupo Invalido !'   + SetFocus
882:     *     If IsEmpty(pcCdConta) Or !ChkRegister('SigCdCli','iclis',...)
883:     *                                 -> 'Conta Invalida !'   + SetFocus
884:     *     If IsEmpty(pcCdProduto) Or !ChkRegister('SigCdPro','cpros',...)
885:     *                                 -> 'Produto Invalido !' + SetFocus

*-- Linhas 892 a 1069:
892:     * A sequencia de consistencias INTEIRA vive em SigOpHisBO.ValidarFiltro()
893:     * (Fase 2), que a transcreve na MESMA ordem e com as MESMAS mensagens e
894:     * devolve this_cMensagemErro + this_cCampoFoco; aqui ficam so a exibicao
895:     * e o foco. As mensagens de validacao de campo usam MsgAviso (dialogo
896:     * amarelo) e nao MsgErro, conforme a norma do projeto ("Campo
897:     * obrigatorio"/"Valor invalido" DEVEM usar MsgAviso; MsgErro fica para
898:     * erro tecnico) - o TEXTO eh o do legado, letra por letra.
899:     *
900:     * Despacho: "Do Form ... With ThisForm" nao existe no sistema novo (DO
901:     * FORM no projeto nunca abre o dialogo filho) - o equivalente eh
902:     * CREATEOBJECT("FormSigPrHpr", THIS), cujo Init(par_oFormPai) guarda o
903:     * form pai em this_oFormPai e LE as PRIVATE pcCdGrupo/pcCdConta/
904:     * pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do escopo do chamador -
905:     * exatamente como o legado, que as declara aqui. CREATEOBJECT com nome
906:     * LITERAL dentro de um Form dispensa GarantirClasse (o indice da carga
907:     * sob demanda ja traz o fecho de dependencias).
908:     *
909:     * Show() fica FORA do TRY: FormSigPrHpr eh MODAL (WindowType = 1) e o
910:     * Show() bloqueia, portanto todo o uso daquela tela correria dentro do
911:     * bloco e qualquer erro de runtime dela saltaria para este CATCH,
912:     * derrubando a referencia e FECHANDO a tela (regra CLAUDE.md #29).
913:     *
914:     * THIS.Enabled = .T. depois do Show() eh o funil de VOLTA: o
915:     * BtnSairClick do filho ja reabilita o pai (this_oFormPai.Enabled = .T.),
916:     * mas quem desabilita tem de reabilitar tambem no retorno, senao um
917:     * caminho de saida que nao passe por aquele botao deixaria este dialogo
918:     * permanentemente morto (regra CLAUDE.md #40).
919:     *
920:     * PUBLIC - exigido para BINDEVENT (regra CLAUDE.md #3).
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnConsultaClick()
923:         LOCAL loc_oFormHistorico, loc_oErro
924: 
925:         *-- Equivalente ao "Private pnOpcao,pcCdEstoque,..." do legado:
926:         *-- PRIVATE torna estas variaveis visiveis ao Init de FormSigPrHpr,
927:         *-- que as le pelo nome (TYPE("pcCdGrupo") etc.).
928:         PRIVATE pcCdGrupo, pcCdConta, pcDsConta, pcCdProduto, pcDsProduto
929:         PRIVATE pdDataIni, pdDataFin
930: 
931:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
932:             MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Consulta")
933:             RETURN
934:         ENDIF
935: 
936:         IF !THIS.FormParaBO()
937:             RETURN
938:         ENDIF
939: 
940:         IF !THIS.this_oBusinessObject.ValidarFiltro()
941:             MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
942:                 "Hist" + CHR(243) + "rico de Produtos")
943:             THIS.FocarCampoRecusado()
944:             RETURN
945:         ENDIF
946: 
947:         *-- Parametros lidos pelo Init de FormSigPrHpr (PRIVATE do chamador).
948:         pcCdGrupo   = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
949:         pcCdConta   = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
950:         pcDsConta   = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
951:         pcCdProduto = ALLTRIM(THIS.this_oBusinessObject.this_cProduto)
952:         pcDsProduto = ALLTRIM(THIS.this_oBusinessObject.this_cDProduto)
953:         pdDataIni   = THIS.this_oBusinessObject.this_dDataIni
954:         pdDataFin   = THIS.this_oBusinessObject.this_dDataFin
955: 
956:         *-- Legado: ThisForm.Enabled = .F. antes de abrir a tela de historico.
957:         THIS.Enabled = .F.
958: 
959:         loc_oFormHistorico = .NULL.
960:         TRY
961:             loc_oFormHistorico = CREATEOBJECT("FormSigPrHpr", THIS)
962:         CATCH TO loc_oErro
963:             MsgErro("Erro ao abrir Hist" + CHR(243) + "rico de Produtos:" + CHR(13) + ;
964:                 loc_oErro.Message + CHR(13) + ;
965:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
966:                 "Procedure: " + loc_oErro.Procedure, "Consulta")
967:             loc_oFormHistorico = .NULL.
968:         ENDTRY
969: 
970:         IF VARTYPE(loc_oFormHistorico) = "O"
971:             loc_oFormHistorico.Show()
972:         ENDIF
973: 
974:         *-- Funil de volta (regra #40): reabilita este dialogo por qualquer
975:         *-- caminho de retorno, inclusive quando o CREATEOBJECT falhou.
976:         THIS.Enabled = .T.
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * BtnEncerrarClick - Click de obj_4c_Sair.Buttons(2) ("Encerrar",
981:     * Cancel = .T.), transcricao do SIGOPHIS.sair.sair.Click legado (dump
982:     * linhas 663-666):
983:     *
984:     *     ThisForm.Release
985:     *
986:     * Nao ha poDataMgr a liberar (a conexao SQL do sistema novo eh
987:     * gnConnHandle, global) nem cursor proprio deste dialogo - os cursores
988:     * de lookup sao fechados pelos proprios helpers (ObterValorExato/
989:     * AbrirPicker). Release() encadeia para Destroy(), que chama DODEFAULT()
990:     * e deixa FormBase liberar o BO e restaurar o menu principal.
991:     *
992:     * PUBLIC - exigido para BINDEVENT (regra CLAUDE.md #3).
993:     *--------------------------------------------------------------------------
994:     PROCEDURE BtnEncerrarClick()
995:         THIS.Release()
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     * LOOKUPS DOS CAMPOS DE FILTRO
1000:     *
1001:     * No legado cada campo resolve o par codigo/descricao dentro do proprio
1002:     * Valid, por uma funcao global do Framework Fortyus:
1003:     *
1004:     *   Get_grupo / Get_Dgrupo -> fAcessoContab(Usuar, 'C'|'D', This.Value,
1005:     *                             ThisForm.get_grupo, ThisForm.get_DGrupo)
1006:     *                             -> picker sobre SigCdGcr (Codigos/Descrs)
1007:     *   Get_est   / Get_dest   -> fAcessoContas(Usuar, Grupo, 'C'|'D',
1008:     *                             This.Value, ThisForm.get_Est,
1009:     *                             ThisForm.get_DEst)
1010:     *                             -> picker sobre SigCdCli (IClis/RClis)
1011:     *   Get_cod   / Get_dcod   -> CreateObject('fwBuscaExt', ..., 'SigCdPro',
1012:     *                             'CrProds', 'cpros'|'dpros', This.Value, ...)
1013:     *                             -> picker sobre SigCdPro (cpros/dpros)
1014:     *
1015:     * Substituicao canonica do projeto (identica a Formsigmvcot/FormCRC):
1016:     * SELECT TOP 1 pelo valor EXATO digitado; achando, preenche o campo par;
1017:     * nao achando, abre FormBuscaAuxiliar com o valor como filtro. As duas
1018:     * funcoes globais continuam vivas em Framework\sigacess.PRG, mas NAO sao
1019:     * usadas como handler de lookup: fAcessoContas auto-preenche o PRIMEIRO
1020:     * registro que apenas CONTEM o valor digitado (LIKE percent valor percent),
1021:     * de modo que digitar "11" carregaria a primeira conta cujo codigo contem
1022:     * "11" sem o usuario ter escolhido nada (memoria "facessocontas_lookup_ux").
1023:     * Com isso, o recorte por grupo/usuario que aquelas funcoes aplicam sobre
1024:     * SigSyAcc/SigSyAgc/SigCdAcJ fica fora destes handlers - a conferencia do
1025:     * dialogo continua sendo a de SigOpHisBO.ValidarFiltro(), que transcreve
1026:     * os ChkRegister do consulta.Click legado.
1027:     *
1028:     * Universo vazio NAO eh erro (regra CLAUDE.md #50): havendo picker, o
1029:     * handler NAO exibe MsgAviso e NAO apaga o codigo digitado - o proprio
1030:     * dialogo eh o feedback e o valor digitado vira o filtro da busca.
1031:     *
1032:     * Tabelas/colunas conferidas em docs/schema.sql (UTF-16, lido com
1033:     * Get-Content -Raw - regra #14): SigCdGcr.codigos char(10)/descrs
1034:     * char(40); SigCdCli.iclis char(10)/rclis char(50); SigCdPro.cpros
1035:     * char(14)/dpros char(65) - as mesmas larguras dos MaxLength declarados
1036:     * em ConfigurarCamposFiltro. Sem filtro extra no WHERE: a chamada do
1037:     * legado omite pInd, entao fAcessoContas NAO restringe SigCdCli por
1038:     * Grupos - inventar esse recorte seria filtro que o legado nao tem.
1039:     *--------------------------------------------------------------------------
1040: 
1041:     *--------------------------------------------------------------------------
1042:     * ObterValorExato - resolve o campo par de um lookup pelo valor EXATO.
1043:     * Devolve "" quando nao ha conexao, quando o valor esta vazio ou quando
1044:     * nada casa - e eh esse "" que faz o handler abrir o picker.
1045:     *
1046:     * EVALUATE eh LEITURA do cursor (regra CLAUDE.md #15) e o alias vai entre
1047:     * parenteses em USE IN (name expression). TratarNulo(x, "") - o 2o
1048:     * argumento eh o valor PADRAO devolvido quando a coluna vem NULL, nao um
1049:     * codigo de tipo.
1050:     *--------------------------------------------------------------------------
1051:     PROTECTED FUNCTION ObterValorExato(par_cTabela, par_cCampoChave, ;
1052:             par_cCampoRetorno, par_cValor)
1053:         LOCAL loc_cSQL, loc_nResultado, loc_cRetorno, loc_cCursor, loc_oErro
1054: 
1055:         loc_cRetorno = ""
1056:         loc_cCursor  = "cursor_4c_LkpExata"
1057: 
1058:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0 OR ;
1059:                 EMPTY(ALLTRIM(par_cValor))
1060:             RETURN ""
1061:         ENDIF
1062: 
1063:         TRY
1064:             IF USED(loc_cCursor)
1065:                 USE IN (loc_cCursor)
1066:             ENDIF
1067: 
1068:             loc_cSQL = "SELECT TOP 1 " + par_cCampoRetorno + " AS cValor" + ;
1069:                        " FROM " + par_cTabela + ;

*-- Linhas 1078 a 1598:
1078:         CATCH TO loc_oErro
1079:             MsgErro(loc_oErro.Message + CHR(13) + ;
1080:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1081:                 "Procedure: " + loc_oErro.Procedure, "Erro em ObterValorExato")
1082:         ENDTRY
1083: 
1084:         IF USED(loc_cCursor)
1085:             USE IN (loc_cCursor)
1086:         ENDIF
1087: 
1088:         RETURN loc_cRetorno
1089:     ENDFUNC
1090: 
1091:     *--------------------------------------------------------------------------
1092:     * AbrirPicker - corpo unico dos seis AbrirLookup*. Reproduz o contrato de
1093:     * FormBuscaAuxiliar (regra CLAUDE.md #36/#37):
1094:     *   - 1o argumento eh o HANDLE da conexao (gnConnHandle), nunca a tabela;
1095:     *   - Show() SO quando this_lAchouRegistro eh .F. (com match exato unico
1096:     *     o Init ja resolveu o valor, e abrir o dialogo por cima da tela
1097:     *     preenchida obrigaria o usuario a dispensa-lo);
1098:     *   - atribuicao SO sob a guarda this_lSelecionou (fora dela o campo
1099:     *     seria ZERADO quando nada fosse escolhido).
1100:     *
1101:     * par_lLimparSeCancelar reproduz o ramo de cancelamento que o Valid de
1102:     * Get_cod/Get_dcod tem no dump (LastKey() = 27 / ESC limpa os dois
1103:     * campos); Grupo e Conta nao tem esse ramo no legado e nao limpam.
1104:     *
1105:     * Devolve .T. quando o par codigo/descricao foi resolvido.
1106:     *--------------------------------------------------------------------------
1107:     PROTECTED FUNCTION AbrirPicker(par_cTabela, par_cCampoChave, ;
1108:             par_cCaptionChave, par_cCampoPar, par_cCaptionPar, par_cTitulo, ;
1109:             par_cValor, par_oTxtChave, par_oTxtPar, par_lLimparSeCancelar)
1110:         LOCAL loc_oBusca, loc_cCursor, loc_lSelecionou, loc_oErro
1111:         LOCAL loc_cValChave, loc_cValPar
1112: 
1113:         loc_cCursor     = "cursor_4c_BuscaLkp"
1114:         loc_lSelecionou = .F.
1115:         loc_cValChave   = ""
1116:         loc_cValPar     = ""
1117: 
1118:         TRY
1119:             IF USED(loc_cCursor)
1120:                 USE IN (loc_cCursor)
1121:             ENDIF
1122: 
1123:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1124:                 par_cTabela, loc_cCursor, par_cCampoChave, ;
1125:                 ALLTRIM(par_cValor), par_cTitulo)
1126: 
1127:             IF VARTYPE(loc_oBusca) = "O"
1128:                 IF !loc_oBusca.this_lAchouRegistro
1129:                     loc_oBusca.mAddColuna(par_cCampoChave, "", par_cCaptionChave)
1130:                     loc_oBusca.mAddColuna(par_cCampoPar,   "", par_cCaptionPar)
1131:                     loc_oBusca.Show()
1132:                 ENDIF
1133: 
1134:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1135:                     SELECT (loc_cCursor)
1136:                     loc_cValChave   = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + "." + par_cCampoChave), ""))
1137:                     loc_cValPar     = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + "." + par_cCampoPar), ""))
1138:                     loc_lSelecionou = .T.
1139:                 ENDIF
1140: 
1141:                 loc_oBusca.Release()
1142:             ENDIF
1143:         CATCH TO loc_oErro
1144:             MsgErro(loc_oErro.Message + CHR(13) + ;
1145:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1146:                 "Procedure: " + loc_oErro.Procedure, "Erro em AbrirPicker")
1147:         ENDTRY
1148: 
1149:         IF USED(loc_cCursor)
1150:             USE IN (loc_cCursor)
1151:         ENDIF
1152: 
1153:         IF loc_lSelecionou
1154:             IF VARTYPE(par_oTxtChave) = "O"
1155:                 par_oTxtChave.Value = loc_cValChave
1156:                 par_oTxtChave.Refresh()
1157:             ENDIF
1158:             IF VARTYPE(par_oTxtPar) = "O"
1159:                 par_oTxtPar.Value = loc_cValPar
1160:                 par_oTxtPar.Refresh()
1161:             ENDIF
1162:         ELSE
1163:             IF par_lLimparSeCancelar
1164:                 IF VARTYPE(par_oTxtChave) = "O"
1165:                     par_oTxtChave.Value = ""
1166:                     par_oTxtChave.Refresh()
1167:                 ENDIF
1168:                 IF VARTYPE(par_oTxtPar) = "O"
1169:                     par_oTxtPar.Value = ""
1170:                     par_oTxtPar.Refresh()
1171:                 ENDIF
1172:             ENDIF
1173:         ENDIF
1174: 
1175:         THIS.AjustarCamposDependentes()
1176: 
1177:         RETURN loc_lSelecionou
1178:     ENDFUNC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * AjustarCamposDependentes - reproduz os tres PROCEDURE When do legado:
1182:     *   Get_Dgrupo.When -> Return(IsEmpty(ThisForm.Get_Grupo.Value))
1183:     *   Get_dest.When   -> Return(IsEmpty(ThisForm.get_Est.Value))
1184:     *   Get_dcod.When   -> Return(IsEmpty(ThisForm.get_cod.Value))
1185:     * Ou seja: o campo de DESCRICAO so aceita entrada enquanto o campo de
1186:     * CODIGO estiver vazio. BINDEVENT em "When" de TextBox nao eh confiavel
1187:     * (o retorno do delegate eh descartado), entao a dependencia eh aplicada
1188:     * por .Enabled, como nos irmaos ja migrados (FormCRC).
1189:     *
1190:     * PUBLIC: alcancado de fora da classe pelos funis de lookup e por
1191:     * ConfigurarCamposFiltro (regra CLAUDE.md #3 - metodo chamado de fora nao
1192:     * pode ser PROTECTED).
1193:     *--------------------------------------------------------------------------
1194:     PROCEDURE AjustarCamposDependentes()
1195:         THIS.txt_4c_Dgrupo.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
1196:         THIS.txt_4c_Dest.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c_Est.Value))
1197:         THIS.txt_4c_Dcod.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c_Cod.Value))
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * GRUPO CONTABIL - SigCdGcr (codigos / descrs)
1202:     * Legado: Get_grupo.Valid / Get_Dgrupo.Valid -> fAcessoContab
1203:     *==========================================================================
1204: 
1205:     *-- F4 abre o picker pelo CODIGO. Save/restore da flag (regra #47): este
1206:     *-- irmao tambem eh alcancado de dentro do funil de LostFocus.
1207:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1208:         LOCAL loc_lEmLookupAnt
1209:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1210:         THIS.this_lEmLookup = .T.
1211:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1212:             THIS.AbrirLookupGrupoCodigo()
1213:         ENDIF
1214:         THIS.this_lEmLookup = loc_lEmLookupAnt
1215:     ENDPROC
1216: 
1217:     *-- Funil equivalente ao Valid de Get_grupo. O corpo vive no Exec para a
1218:     *-- flag ser liberada mesmo nos RETURN antecipados dele (regra #47).
1219:     PROCEDURE GrupoLostFocus()
1220:         IF THIS.this_lEmLookup
1221:             RETURN
1222:         ENDIF
1223:         THIS.this_lEmLookup = .T.
1224:         THIS.GrupoLostFocusExec()
1225:         THIS.this_lEmLookup = .F.
1226:     ENDPROC
1227: 
1228:     PROCEDURE GrupoLostFocusExec()
1229:         LOCAL loc_cCodigo, loc_cDescricao
1230: 
1231:         loc_cCodigo = ALLTRIM(THIS.txt_4c_Grupo.Value)
1232: 
1233:         IF EMPTY(loc_cCodigo)
1234:             *-- Legado: ramo Else -> get_DGrupo.Value = vazio
1235:             THIS.txt_4c_Dgrupo.Value = ""
1236:             THIS.txt_4c_Dgrupo.Refresh()
1237:             THIS.AjustarCamposDependentes()
1238:             RETURN
1239:         ENDIF
1240: 
1241:         loc_cDescricao = THIS.ObterValorExato("SigCdGcr", "codigos", "descrs", loc_cCodigo)
1242: 
1243:         IF EMPTY(loc_cDescricao)
1244:             *-- Nada casou exato: o picker abre com o digitado como filtro.
1245:             *-- Sem MsgAviso e sem apagar o codigo (regra #50).
1246:             THIS.AbrirLookupGrupoCodigo()
1247:         ELSE
1248:             THIS.txt_4c_Dgrupo.Value = loc_cDescricao
1249:             THIS.txt_4c_Dgrupo.Refresh()
1250:             THIS.AjustarCamposDependentes()
1251:         ENDIF
1252:     ENDPROC
1253: 
1254:     PROCEDURE AbrirLookupGrupoCodigo()
1255:         IF !THIS.txt_4c_Grupo.Enabled
1256:             RETURN
1257:         ENDIF
1258: 
1259:         THIS.AbrirPicker("SigCdGcr", "codigos", "C" + CHR(243) + "digo", ;
1260:             "descrs", "Descri" + CHR(231) + CHR(227) + "o", ;
1261:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
1262:             THIS.txt_4c_Grupo.Value, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, .F.)
1263:     ENDPROC
1264: 
1265:     *-- F4 abre o picker pela DESCRICAO.
1266:     PROCEDURE DgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1267:         LOCAL loc_lEmLookupAnt
1268:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1269:         THIS.this_lEmLookup = .T.
1270:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1271:             THIS.AbrirLookupGrupoDescricao()
1272:         ENDIF
1273:         THIS.this_lEmLookup = loc_lEmLookupAnt
1274:     ENDPROC
1275: 
1276:     PROCEDURE DgrupoLostFocus()
1277:         IF THIS.this_lEmLookup
1278:             RETURN
1279:         ENDIF
1280:         THIS.this_lEmLookup = .T.
1281:         THIS.DgrupoLostFocusExec()
1282:         THIS.this_lEmLookup = .F.
1283:     ENDPROC
1284: 
1285:     PROCEDURE DgrupoLostFocusExec()
1286:         LOCAL loc_cDescricao, loc_cCodigo
1287: 
1288:         loc_cDescricao = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
1289: 
1290:         IF EMPTY(loc_cDescricao)
1291:             *-- Legado: ramo Else -> get_Grupo.Value = vazio
1292:             THIS.txt_4c_Grupo.Value = ""
1293:             THIS.txt_4c_Grupo.Refresh()
1294:             THIS.AjustarCamposDependentes()
1295:             RETURN
1296:         ENDIF
1297: 
1298:         loc_cCodigo = THIS.ObterValorExato("SigCdGcr", "descrs", "codigos", loc_cDescricao)
1299: 
1300:         IF EMPTY(loc_cCodigo)
1301:             THIS.AbrirLookupGrupoDescricao()
1302:         ELSE
1303:             THIS.txt_4c_Grupo.Value = loc_cCodigo
1304:             THIS.txt_4c_Grupo.Refresh()
1305:             THIS.AjustarCamposDependentes()
1306:         ENDIF
1307:     ENDPROC
1308: 
1309:     PROCEDURE AbrirLookupGrupoDescricao()
1310:         IF !THIS.txt_4c_Dgrupo.Enabled
1311:             RETURN
1312:         ENDIF
1313: 
1314:         THIS.AbrirPicker("SigCdGcr", "descrs", "Descri" + CHR(231) + CHR(227) + "o", ;
1315:             "codigos", "C" + CHR(243) + "digo", ;
1316:             "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
1317:             THIS.txt_4c_Dgrupo.Value, THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, .F.)
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * CONTA - SigCdCli (iclis / rclis)
1322:     * Legado: Get_est.Valid / Get_dest.Valid -> fAcessoContas
1323:     *==========================================================================
1324: 
1325:     PROCEDURE EstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1326:         LOCAL loc_lEmLookupAnt
1327:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1328:         THIS.this_lEmLookup = .T.
1329:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1330:             THIS.AbrirLookupContaCodigo()
1331:         ENDIF
1332:         THIS.this_lEmLookup = loc_lEmLookupAnt
1333:     ENDPROC
1334: 
1335:     PROCEDURE EstLostFocus()
1336:         IF THIS.this_lEmLookup
1337:             RETURN
1338:         ENDIF
1339:         THIS.this_lEmLookup = .T.
1340:         THIS.EstLostFocusExec()
1341:         THIS.this_lEmLookup = .F.
1342:     ENDPROC
1343: 
1344:     PROCEDURE EstLostFocusExec()
1345:         LOCAL loc_cCodigo, loc_cDescricao
1346: 
1347:         loc_cCodigo = ALLTRIM(THIS.txt_4c_Est.Value)
1348: 
1349:         IF EMPTY(loc_cCodigo)
1350:             *-- Legado: ramo Else -> get_dest.Value = vazio
1351:             THIS.txt_4c_Dest.Value = ""
1352:             THIS.txt_4c_Dest.Refresh()
1353:             THIS.AjustarCamposDependentes()
1354:             RETURN
1355:         ENDIF
1356: 
1357:         loc_cDescricao = THIS.ObterValorExato("SigCdCli", "iclis", "rclis", loc_cCodigo)
1358: 
1359:         IF EMPTY(loc_cDescricao)
1360:             THIS.AbrirLookupContaCodigo()
1361:         ELSE
1362:             THIS.txt_4c_Dest.Value = loc_cDescricao
1363:             THIS.txt_4c_Dest.Refresh()
1364:             THIS.AjustarCamposDependentes()
1365:         ENDIF
1366:     ENDPROC
1367: 
1368:     PROCEDURE AbrirLookupContaCodigo()
1369:         IF !THIS.txt_4c_Est.Enabled
1370:             RETURN
1371:         ENDIF
1372: 
1373:         THIS.AbrirPicker("SigCdCli", "iclis", "C" + CHR(243) + "digo", ;
1374:             "rclis", "Descri" + CHR(231) + CHR(227) + "o", ;
1375:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
1376:             THIS.txt_4c_Est.Value, THIS.txt_4c_Est, THIS.txt_4c_Dest, .F.)
1377:     ENDPROC
1378: 
1379:     PROCEDURE DestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1380:         LOCAL loc_lEmLookupAnt
1381:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1382:         THIS.this_lEmLookup = .T.
1383:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1384:             THIS.AbrirLookupContaDescricao()
1385:         ENDIF
1386:         THIS.this_lEmLookup = loc_lEmLookupAnt
1387:     ENDPROC
1388: 
1389:     PROCEDURE DestLostFocus()
1390:         IF THIS.this_lEmLookup
1391:             RETURN
1392:         ENDIF
1393:         THIS.this_lEmLookup = .T.
1394:         THIS.DestLostFocusExec()
1395:         THIS.this_lEmLookup = .F.
1396:     ENDPROC
1397: 
1398:     PROCEDURE DestLostFocusExec()
1399:         LOCAL loc_cDescricao, loc_cCodigo
1400: 
1401:         loc_cDescricao = ALLTRIM(THIS.txt_4c_Dest.Value)
1402: 
1403:         IF EMPTY(loc_cDescricao)
1404:             *-- Legado: ramo Else -> get_est.Value = vazio
1405:             THIS.txt_4c_Est.Value = ""
1406:             THIS.txt_4c_Est.Refresh()
1407:             THIS.AjustarCamposDependentes()
1408:             RETURN
1409:         ENDIF
1410: 
1411:         loc_cCodigo = THIS.ObterValorExato("SigCdCli", "rclis", "iclis", loc_cDescricao)
1412: 
1413:         IF EMPTY(loc_cCodigo)
1414:             THIS.AbrirLookupContaDescricao()
1415:         ELSE
1416:             THIS.txt_4c_Est.Value = loc_cCodigo
1417:             THIS.txt_4c_Est.Refresh()
1418:             THIS.AjustarCamposDependentes()
1419:         ENDIF
1420:     ENDPROC
1421: 
1422:     PROCEDURE AbrirLookupContaDescricao()
1423:         IF !THIS.txt_4c_Dest.Enabled
1424:             RETURN
1425:         ENDIF
1426: 
1427:         THIS.AbrirPicker("SigCdCli", "rclis", "Descri" + CHR(231) + CHR(227) + "o", ;
1428:             "iclis", "C" + CHR(243) + "digo", ;
1429:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
1430:             THIS.txt_4c_Dest.Value, THIS.txt_4c_Dest, THIS.txt_4c_Est, .F.)
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * PRODUTO - SigCdPro (cpros / dpros)
1435:     * Legado: Get_cod.Valid / Get_dcod.Valid -> fwBuscaExt sobre SigCdPro
1436:     *
1437:     * Unico par cujo Valid legado tem o ramo de CANCELAMENTO explicito: no
1438:     * dump, saindo do picker com ESC (LastKey() = 27) os DOIS campos sao
1439:     * limpos. Por isso par_lLimparSeCancelar entra .T. aqui e .F. nos pares
1440:     * de Grupo e Conta, que nao tem esse ramo.
1441:     *==========================================================================
1442: 
1443:     PROCEDURE CodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1444:         LOCAL loc_lEmLookupAnt
1445:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1446:         THIS.this_lEmLookup = .T.
1447:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1448:             THIS.AbrirLookupProdutoCodigo()
1449:         ENDIF
1450:         THIS.this_lEmLookup = loc_lEmLookupAnt
1451:     ENDPROC
1452: 
1453:     PROCEDURE CodLostFocus()
1454:         IF THIS.this_lEmLookup
1455:             RETURN
1456:         ENDIF
1457:         THIS.this_lEmLookup = .T.
1458:         THIS.CodLostFocusExec()
1459:         THIS.this_lEmLookup = .F.
1460:     ENDPROC
1461: 
1462:     PROCEDURE CodLostFocusExec()
1463:         LOCAL loc_cCodigo, loc_cDescricao
1464: 
1465:         loc_cCodigo = ALLTRIM(THIS.txt_4c_Cod.Value)
1466: 
1467:         IF EMPTY(loc_cCodigo)
1468:             *-- Legado: If IsEmpty(This.Value) -> get_dcod.Value = vazio
1469:             THIS.txt_4c_Dcod.Value = ""
1470:             THIS.txt_4c_Dcod.Refresh()
1471:             THIS.AjustarCamposDependentes()
1472:             RETURN
1473:         ENDIF
1474: 
1475:         loc_cDescricao = THIS.ObterValorExato("SigCdPro", "cpros", "dpros", loc_cCodigo)
1476: 
1477:         IF EMPTY(loc_cDescricao)
1478:             THIS.AbrirLookupProdutoCodigo()
1479:         ELSE
1480:             THIS.txt_4c_Dcod.Value = loc_cDescricao
1481:             THIS.txt_4c_Dcod.Refresh()
1482:             THIS.AjustarCamposDependentes()
1483:         ENDIF
1484:     ENDPROC
1485: 
1486:     PROCEDURE AbrirLookupProdutoCodigo()
1487:         IF !THIS.txt_4c_Cod.Enabled
1488:             RETURN
1489:         ENDIF
1490: 
1491:         THIS.AbrirPicker("SigCdPro", "cpros", "C" + CHR(243) + "digo", ;
1492:             "dpros", "Descri" + CHR(231) + CHR(227) + "o", ;
1493:             "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
1494:             THIS.txt_4c_Cod.Value, THIS.txt_4c_Cod, THIS.txt_4c_Dcod, .T.)
1495:     ENDPROC
1496: 
1497:     PROCEDURE DcodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1498:         LOCAL loc_lEmLookupAnt
1499:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1500:         THIS.this_lEmLookup = .T.
1501:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1502:             THIS.AbrirLookupProdutoDescricao()
1503:         ENDIF
1504:         THIS.this_lEmLookup = loc_lEmLookupAnt
1505:     ENDPROC
1506: 
1507:     PROCEDURE DcodLostFocus()
1508:         IF THIS.this_lEmLookup
1509:             RETURN
1510:         ENDIF
1511:         THIS.this_lEmLookup = .T.
1512:         THIS.DcodLostFocusExec()
1513:         THIS.this_lEmLookup = .F.
1514:     ENDPROC
1515: 
1516:     PROCEDURE DcodLostFocusExec()
1517:         LOCAL loc_cDescricao, loc_cCodigo
1518: 
1519:         loc_cDescricao = ALLTRIM(THIS.txt_4c_Dcod.Value)
1520: 
1521:         IF EMPTY(loc_cDescricao)
1522:             *-- Legado: If IsEmpty(This.Value) -> get_cod.Value = vazio
1523:             THIS.txt_4c_Cod.Value = ""
1524:             THIS.txt_4c_Cod.Refresh()
1525:             THIS.AjustarCamposDependentes()
1526:             RETURN
1527:         ENDIF
1528: 
1529:         loc_cCodigo = THIS.ObterValorExato("SigCdPro", "dpros", "cpros", loc_cDescricao)
1530: 
1531:         IF EMPTY(loc_cCodigo)
1532:             THIS.AbrirLookupProdutoDescricao()
1533:         ELSE
1534:             THIS.txt_4c_Cod.Value = loc_cCodigo
1535:             THIS.txt_4c_Cod.Refresh()
1536:             THIS.AjustarCamposDependentes()
1537:         ENDIF
1538:     ENDPROC
1539: 
1540:     PROCEDURE AbrirLookupProdutoDescricao()
1541:         IF !THIS.txt_4c_Dcod.Enabled
1542:             RETURN
1543:         ENDIF
1544: 
1545:         THIS.AbrirPicker("SigCdPro", "dpros", "Descri" + CHR(231) + CHR(227) + "o", ;
1546:             "cpros", "C" + CHR(243) + "digo", ;
1547:             "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
1548:             THIS.txt_4c_Dcod.Value, THIS.txt_4c_Dcod, THIS.txt_4c_Cod, .T.)
1549:     ENDPROC
1550: 
1551:     *--------------------------------------------------------------------------
1552:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
1553:     * Original (dump legado): cntSombra Top=0, Left=0, Width=800, Height=80,
1554:     * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
1555:     * projeto) em vez do literal 800 do dump (que extrapola o Width=650
1556:     * do proprio form).
1557:     *--------------------------------------------------------------------------
1558:     PROTECTED PROCEDURE ConfigurarCabecalho()
1559:         LOCAL loc_oCnt, loc_oErro
1560: 
1561:         TRY
1562:             THIS.AddObject("cnt_4c_Sombra", "Container")
1563:             loc_oCnt = THIS.cnt_4c_Sombra
1564:             WITH loc_oCnt
1565:                 .Top         = 0
1566:                 .Left        = 0
1567:                 .Width       = THIS.Width
1568:                 .Height      = 80
1569:                 .BorderWidth = 0
1570:                 .BackColor   = RGB(100, 100, 100)
1571:                 .Visible     = .T.
1572:             ENDWITH
1573: 
1574:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
1575:             WITH loc_oCnt.lbl_4c_LblSombra
1576:                 .FontBold  = .T.
1577:                 .FontName  = "Tahoma"
1578:                 .FontSize  = 18
1579:                 .WordWrap  = .T.
1580:                 .Alignment = 0
1581:                 .BackStyle = 0
1582:                 .AutoSize  = .F.
1583:                 .Caption   = THIS.Caption
1584:                 .Height    = 40
1585:                 .Left      = 10
1586:                 .Top       = 25
1587:                 .Width     = 619
1588:                 .ForeColor = RGB(0, 0, 0)
1589:                 .Visible   = .T.
1590:             ENDWITH
1591: 
1592:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
1593:             WITH loc_oCnt.lbl_4c_LblTitulo
1594:                 .FontBold  = .T.
1595:                 .FontName  = "Tahoma"
1596:                 .FontSize  = 18
1597:                 .WordWrap  = .T.
1598:                 .Alignment = 0

*-- Linhas 1609 a 1639:
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message + CHR(13) + ;
1611:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1612:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
1613:         ENDTRY
1614:     ENDPROC
1615: 
1616:     *--------------------------------------------------------------------------
1617:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1618:     * padrao; percorre recursivamente Controls (containers/PageFrame) para
1619:     * garantir que tudo fique visivel apos a montagem.
1620:     *--------------------------------------------------------------------------
1621:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1622:         LOCAL loc_nI, loc_oObjeto
1623: 
1624:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1625:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1626: 
1627:             IF VARTYPE(loc_oObjeto) = "O"
1628:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1629:                     loc_oObjeto.Visible = .T.
1630:                 ENDIF
1631: 
1632:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1633:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1634:                 ENDIF
1635:             ENDIF
1636:         ENDFOR
1637:     ENDPROC
1638: 
1639: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpHisBO.prg):
*==============================================================================
* SigOpHisBO.prg
*
* Business Object para SigOpHis (Historico de Produtos - tela de filtro)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe Grupo/Conta (contabeis), Produto e um periodo (Data Inicial/
* Data Final), valida os quatro campos e repassa os parametros para o form
* de historico (legado: "Do Form SigPrHpr With ThisForm"; no sistema novo,
* FormSigPrHpr - ja migrado - que le os mesmos nomes de PRIVATE pcCdGrupo/
* pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin no proprio Init).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase ja eh o correto para este BO,
* porque nao ha NENHUMA tabela proprietaria para gravar (regra CLAUDE.md
* "BO somente-leitura"). ObterChavePrimaria() tambem nao se aplica.
*
* Fase 2/8 - CarregarDoCursor() + validacoes equivalentes ao ChkRegister()
* legado (regra CLAUDE.md "ChkRegister NAO EXISTE em BusinessBase - usar
* SQLEXEC com SELECT COUNT(*)"). A validacao de Grupo (fAcessoContab) e de
* Conta (fAcessoContas) continua no FORM, igual ao legado - as duas funcoes
* globais ja estao portadas em utils\functions.prg e recebem os proprios
* TextBox do form para auto-preencher a descricao (ver SIGOPHIS.Get_grupo.
* Valid / SIGOPHIS.Get_est.Valid no dump); a BO nao duplica essa logica.
*==============================================================================

DEFINE CLASS SigOpHisBO AS BusinessBase

    *-- Propriedades da entidade (espelham os campos do form legado
    *-- SIGOPHIS: Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/Get_dcod/
    *-- Get_DataIni/Get_DataFin)
    this_cGrupo   = SPACE(10)   && Get_grupo.Value  - Codigo do Grupo Contabil
    this_cDGrupo  = ""          && Get_Dgrupo.Value - Descricao do Grupo Contabil
    this_cConta   = SPACE(10)   && Get_est.Value    - Codigo da Conta
    this_cDConta  = ""          && Get_dest.Value   - Descricao da Conta
    this_cProduto = SPACE(14)   && Get_cod.Value    - Codigo do Produto (SigCdPro.cpros)
    this_cDProduto = ""         && Get_dcod.Value   - Descricao do Produto (SigCdPro.dpros)
    this_dDataIni = {}          && Get_DataIni.Value - Data Inicial do periodo
    this_dDataFin = {}          && Get_DataFin.Value - Data Final do periodo

    *-- Nome do controle que deve receber o foco quando ValidarFiltro()
    *-- falhar (replica o ThisForm.get_xxx.SetFocus do consulta.Click
    *-- legado). Valores possiveis: "Grupo", "Conta", "Produto",
    *-- "DataIni", "DataFin" ou "" (nenhuma falha / ainda nao validado).
    this_cCampoFoco = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cGrupo = SPACE(10)
        THIS.this_cDGrupo = ""
        THIS.this_cConta = SPACE(10)
        THIS.this_cDConta = ""
        THIS.this_cProduto = SPACE(14)
        THIS.this_cDProduto = ""
        THIS.this_dDataIni = DATE()
        THIS.this_dDataFin = DATE()
        THIS.this_cCampoFoco = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Sobrescreve BusinessBase.CarregarDoCursor()
    *
    * Este dialogo nao tem cursor de lista/detalhe proprio (nao ha tabela
    * SigOpHis), mas o campo Produto usa o padrao FormBuscaAuxiliar (regra
    * CLAUDE.md #36/#37) no lugar do legado "CreateObject('fwBuscaExt',
    * ...,'SigCdPro','CrProds','cpros',...)" (ver SIGOPHIS.Get_cod.Valid /
    * SIGOPHIS.Get_dcod.Valid no dump). Quando o Form (Fase 5/6) abrir o
    * picker e o usuario selecionar um registro, o cursor resultante tera
    * as colunas cpros/dpros (mAddColuna do legado) - este metodo e quem
    * traz esse par para as propriedades this_cProduto/this_cDProduto.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cProduto  = TratarNulo(cpros, "C")
                THIS.this_cDProduto = TratarNulo(dpros, "C")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarContaExistente - Substitui o ChkRegister('SigCdCli','iclis',
    * pcCdConta) do legado (consulta.Click). PROTECTED: uso interno de
    * ValidarFiltro(), nunca chamado de fora (regra CLAUDE.md #51).
    *====================================================================
    PROTECTED PROCEDURE VerificarContaExistente(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste

        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ChkConta")
                USE IN cursor_4c_ChkConta
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS nExiste" + ;
                       " FROM SigCdCli" + ;
                       " WHERE iclis = " + EscaparSQL(ALLTRIM(par_cConta))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")

            IF loc_nResultado > 0
                loc_lExiste = (NVL(cursor_4c_ChkConta.nExiste, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar Conta")
        ENDTRY

        IF USED("cursor_4c_ChkConta")
            USE IN cursor_4c_ChkConta
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * VerificarProdutoExistente - Substitui o ChkRegister('SigCdPro',
    * 'cpros', pcCdProduto) do legado (consulta.Click). PROTECTED: uso
    * interno de ValidarFiltro(), nunca chamado de fora (regra #51).
    *====================================================================
    PROTECTED PROCEDURE VerificarProdutoExistente(par_cProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste

        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ChkProduto")
                USE IN cursor_4c_ChkProduto
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS nExiste" + ;
                       " FROM SigCdPro" + ;
                       " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProduto")

            IF loc_nResultado > 0
                loc_lExiste = (NVL(cursor_4c_ChkProduto.nExiste, 0) > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar Produto")
        ENDTRY

        IF USED("cursor_4c_ChkProduto")
            USE IN cursor_4c_ChkProduto
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * ValidarFiltro - Transcricao literal (regra CLAUDE.md #17) da
    * sequencia de "Consiste o Campo..." do SIGOPHIS.sair.consulta.Click
    * legado, na MESMA ordem e com as MESMAS mensagens (so com CHR() no
    * lugar do acento literal - regra #4). Quem chama fica responsavel
    * por exibir THIS.this_cMensagemErro (MsgErro) e dar SetFocus no
    * controle indicado por THIS.this_cCampoFoco - igual ao
    * ThisForm.get_xxx.SetFocus de cada bloco do legado.
    *====================================================================
    PROCEDURE ValidarFiltro()
        LOCAL loc_lValido
        loc_lValido = .T.

        THIS.this_cMensagemErro = ""
        THIS.this_cCampoFoco = ""

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido !"
            THIS.this_cCampoFoco = "Grupo"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND (EMPTY(ALLTRIM(THIS.this_cConta)) OR !THIS.VerificarContaExistente(THIS.this_cConta))
            THIS.this_cMensagemErro = "Conta Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "Conta"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND (EMPTY(ALLTRIM(THIS.this_cProduto)) OR !THIS.VerificarProdutoExistente(THIS.this_cProduto))
            THIS.this_cMensagemErro = "Produto Inv" + CHR(225) + "lido !"
            THIS.this_cCampoFoco = "Produto"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_dDataIni)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "DataIni"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_dDataFin)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida !"
            THIS.this_cCampoFoco = "DataFin"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_dDataIni > THIS.this_dDataFin
            THIS.this_cMensagemErro = "Data Inicial maior que Data Final !"
            THIS.this_cCampoFoco = "DataIni"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

