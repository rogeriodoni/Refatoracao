# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.Caption()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarAcessoConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExigirChequeSelecionado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Protocolo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDFOR define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDFOR.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'InicializarForm' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'FormatarBotoesHistorico' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnEncerrarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'optFiltro' (parent: SIGOPCHI.Pagina.Filtro.Origem): Left original=282 vs migrado 'obj_4c_OptFiltro' Left=5 (diff=277px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4101 linhas total):

*-- Linhas 9 a 53:
9: * (grades de cheque, movimentacao e prorrogacoes, followup e navegacao para
10: * os formularios de detalhe SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc).
11: *
12: * Fase 3: estrutura base (heranca, Init, InicializarForm, PageFrame,
13: * containers de cabecalho vazios, labels de cabecalho, TornarControlesVisiveis,
14: * Destroy).
15: * Fase 4: grades do Historico (grd_4c_Cheque/Movimenta/Prorrog), botoes CRUD/
16: * acao (cmg_4c_Botoes/cmg_4c_Saida), CarregarDados (SqlDados legado) e
17: * AlternarPagina.
18: * Fase 5: campos restantes da Page2/Historico - Cnt_periodo (filtro de
19: * vencimento), Cnt_Followup (ultimo followup, so-leitura) e o container
20: * Emitente (filtro por conta do emitente, com os tres lookups de SigCdCli -
21: * mesmo padrao do container Origem da Page1). Os 8 botoes de cmg_4c_Botoes
22: * (Relatorio/Busca/Prorroga/FollowUp/Carteira/Protocolo/Movimento/FollowUp
23: * Cheque) e o AfterRowColChange de grd_4c_Cheque ficam para a fase de acoes.
24: *==============================================================================
25: 
26: DEFINE CLASS FormSigOpChi AS FormBase
27: 
28:     *-- Propriedades visuais (PILAR 1 - copiadas do SCX original SIGOPCHI)
29:     Width        = 1000
30:     Height       = 600
31:     DataSession  = 2
32:     BorderStyle  = 2
33:     AutoCenter   = .T.
34:     Caption      = "Hist" + CHR(243) + "rico de Cheques"
35:     ControlBox   = .F.
36:     Closable     = .F.
37:     MaxButton    = .F.
38:     MinButton    = .F.
39:     ClipControls = .F.
40:     KeyPreview   = .T.
41:     TitleBar     = 0
42:     ZoomBox      = .T.
43:     Themes       = .F.
44:     ShowWindow   = 1
45:     WindowType   = 1
46: 
47:     *-- Business Object
48:     this_oBusinessObject = .NULL.
49: 
50:     *-- Espelho do "ThisForm.Acesso" do legado - .T. quando pcAcesso eh
51:     *-- 'TOTAL' ou 'CARTEIRA' (acesso irrestrito as contas do historico)
52:     this_lAcesso = .T.
53: 

*-- Linhas 78 a 127:
78:     * Init - Equivalente a:
79:     * LParameters pAcesso, lcNomeFrm1, pBancos, pAgencias, pNContas, pNCheques, pVencs
80:     *--------------------------------------------------------------------------
81:     PROCEDURE Init(par_cAcesso, par_cNomeFrm1, par_cBancos, par_cAgencias, ;
82:                    par_cNContas, par_cNCheques, par_dVencs)
83:         LOCAL loc_lSucesso, loc_oErro
84:         loc_lSucesso = .F.
85: 
86:         TRY
87:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpChiBO")
88: 
89:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
90:                 MsgErro("Erro ao criar SigOpChiBO." + CHR(13) + ;
91:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "FormSigOpChi.Init")
92:             ELSE
93:                 IF VARTYPE(par_cAcesso) = "C" AND !EMPTY(par_cAcesso)
94:                     THIS.this_oBusinessObject.this_cAcesso = par_cAcesso
95:                 ENDIF
96:                 THIS.this_lAcesso = INLIST(THIS.this_oBusinessObject.this_cAcesso, "TOTAL", "CARTEIRA")
97:                 THIS.this_oBusinessObject.this_lAcesso = THIS.this_lAcesso
98: 
99:                 IF VARTYPE(par_cNomeFrm1) = "C"
100:                     THIS.this_cNomeFrmChamador = par_cNomeFrm1
101:                 ENDIF
102:                 IF VARTYPE(par_cBancos) = "C"
103:                     THIS.this_cParamBancos = ALLTRIM(par_cBancos)
104:                 ENDIF
105:                 IF VARTYPE(par_cAgencias) = "C"
106:                     THIS.this_cParamAgencias = ALLTRIM(par_cAgencias)
107:                 ENDIF
108:                 IF VARTYPE(par_cNContas) = "C"
109:                     THIS.this_cParamNContas = ALLTRIM(par_cNContas)
110:                 ENDIF
111:                 IF VARTYPE(par_cNCheques) = "C"
112:                     THIS.this_cParamNCheques = ALLTRIM(par_cNCheques)
113:                 ENDIF
114:                 IF VARTYPE(par_dVencs) = "D" OR VARTYPE(par_dVencs) = "T"
115:                     THIS.this_dParamVencs = ConverterParaData(par_dVencs)
116:                 ENDIF
117: 
118:                 *-- Periodo de vencimento default. Transcrito do Init legado:
119:                 *--   .Cnt_periodo.Dt_inicial.Value = IIF(pcAcesso='CARTEIRA', pcVencs, Date())
120:                 *--   .Cnt_periodo.Dt_Final.Value   = IIF(pcAcesso='CARTEIRA', pcVencs,
121:                 *--                                       CTOD('31/12/'+ALLTRIM(STR(YEAR(DATE())))))
122:                 *-- No acesso CARTEIRA o periodo colapsa no vencimento do cheque
123:                 *-- recebido, porque a consulta eh de UM cheque especifico.
124:                 *-- Os TextBox Dt_inicial/Dt_final espelham estas duas
125:                 *-- propriedades do BO, que sao a fonte unica do periodo.
126:                 IF ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso)) == "CARTEIRA" ;
127:                         AND !EMPTY(THIS.this_dParamVencs)

*-- Linhas 133 a 393:
133:                         CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
134:                 ENDIF
135: 
136:                 *-- DODEFAULT() dispara FormBase.Init() -> THIS.InicializarForm()
137:                 *-- Tambem aciona SET DATE TO BRITISH + SET CENTURY ON (DataSession=2)
138:                 loc_lSucesso = DODEFAULT()
139:             ENDIF
140:         CATCH TO loc_oErro
141:             MsgErro(loc_oErro.Message + CHR(13) + ;
142:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
143:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Init")
144:         ENDTRY
145: 
146:         RETURN loc_lSucesso
147:     ENDPROC
148: 
149:     *--------------------------------------------------------------------------
150:     * KeyPress - Transcricao literal do KeyPress legado (KeyPreview = .T.,
151:     * ja declarado nas propriedades do form): F3/F4/F5/F6/F7/F8/F9/F11 so
152:     * atuam na Pagina 2 (Historico) e delegam para os mesmos metodos dos
153:     * botoes de cmg_4c_Botoes. Os codigos negativos (-2..-8) sao os valores
154:     * que o VFP9 entrega em Form.KeyPress para F3..F9 quando KeyPreview esta
155:     * ligado; F11 chega como 133 (idem legado).
156:     *--------------------------------------------------------------------------
157:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
158:         LOCAL loc_nPagina
159:         loc_nPagina = THIS.pgf_4c_Paginas.ActivePage
160: 
161:         DO CASE
162:             CASE par_nKeyCode = -2 AND loc_nPagina = 2 && <F3> FollowUp Cheque
163:                 NODEFAULT
164:                 THIS.AcaoFollowUpChqClick()
165: 
166:             CASE par_nKeyCode = -3 AND loc_nPagina = 2 && <F4> Documento
167:                 NODEFAULT
168:                 THIS.AcaoDocumentoClick()
169: 
170:             CASE par_nKeyCode = -4 AND loc_nPagina = 2 && <F5> Procurar
171:                 NODEFAULT
172:                 THIS.AcaoProcurarClick()
173: 
174:             CASE par_nKeyCode = -5 AND loc_nPagina = 2 && <F6> Relatorio
175:                 NODEFAULT
176:                 THIS.AcaoRelatorioClick()
177: 
178:             CASE par_nKeyCode = -6 AND loc_nPagina = 2 && <F7> Prorrogar
179:                 NODEFAULT
180:                 THIS.AcaoProrrogaClick()
181: 
182:             CASE par_nKeyCode = -7 AND loc_nPagina = 2 && <F8> FollowUp Cliente
183:                 NODEFAULT
184:                 THIS.AcaoFollowUpClick()
185: 
186:             CASE par_nKeyCode = -8 AND loc_nPagina = 2 && <F9> Protocolo
187:                 NODEFAULT
188:                 THIS.AcaoProtocoloClick()
189: 
190:             CASE par_nKeyCode = 133 AND loc_nPagina = 2 && <F11> Carteira
191:                 NODEFAULT
192:                 THIS.AcaoCarteiraClick()
193:         ENDCASE
194:     ENDPROC
195: 
196:     *--------------------------------------------------------------------------
197:     * InicializarForm - Monta a estrutura visual base do form
198:     * (chamado por FormBase.Init via DODEFAULT)
199:     *--------------------------------------------------------------------------
200:     PROTECTED PROCEDURE InicializarForm()
201:         LOCAL loc_lSucesso, loc_oErro
202:         loc_lSucesso = .F.
203: 
204:         TRY
205:             THIS.ConfigurarPageFrame()
206:             THIS.ConfigurarContainersBase()
207:             THIS.ConfigurarPaginaFiltro()
208:             THIS.ConfigurarPaginaHistorico()
209:             THIS.ConfigurarGradesHistorico()
210:             THIS.ConfigurarBotoesHistorico()
211:             THIS.ConfigurarCursorProtocolo()
212: 
213:             THIS.pgf_4c_Paginas.Visible = .T.
214: 
215:             THIS.TornarControlesVisiveis(THIS)
216: 
217:             *-- Espelha o BO na tela (periodo default resolvido no Init, campos
218:             *-- de Origem/Emitente e Caption) e aplica a cascata dos PROCEDURE
219:             *-- When do legado. TornarControlesVisiveis ja rodou, entao nenhum
220:             *-- Visible declarado aqui eh sobrescrito depois.
221:             THIS.BOParaForm()
222: 
223:             *-- Transcrito do Init legado: com acesso TOTAL/CARTEIRA a tela abre
224:             *-- direto no Historico e ja carrega os dados ("If ThisForm.Acesso
225:             *-- ... .ActivePage = 2 / ThisForm.SqlDados"); sem acesso irrestrito
226:             *-- abre no Filtro, exigindo que o usuario informe a conta
227:             *-- ("Else / ThisForm.Pagina.Filtro.Origem.Get_conta.Setfocus").
228:             *-- ActivePage eh trocada DEPOIS de TornarControlesVisiveis para que
229:             *-- as grades sejam repintadas com a pagina ja visivel.
230:             THIS.AlternarPagina(IIF(THIS.this_lAcesso, 2, 1))
231: 
232:             loc_lSucesso = .T.
233:         CATCH TO loc_oErro
234:             MsgErro(loc_oErro.Message + CHR(13) + ;
235:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
236:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.InicializarForm")
237:         ENDTRY
238: 
239:         RETURN loc_lSucesso
240:     ENDPROC
241: 
242:     *--------------------------------------------------------------------------
243:     * AtualizarTituloCabecalho - Espelha THIS.Caption nos labels da faixa do
244:     * cabecalho (lbl_4c_Sombra/lbl_4c_Titulo) das DUAS paginas (regra #11).
245:     * Os labels sao criados ja com Caption = THIS.Caption (ConfigurarPagina
246:     * Filtro/ConfigurarPaginaHistorico), mas CmdOkClick/CarregarDados/
247:     * BOParaForm trocam THIS.Caption depois disso - sem este espelhamento a
248:     * faixa fica com o titulo antigo.
249:     *--------------------------------------------------------------------------
250:     PROTECTED PROCEDURE AtualizarTituloCabecalho()
251:         LOCAL loc_oCab1, loc_oCab2
252: 
253:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
254:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
255:                 loc_oCab1 = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
256:                 IF PEMSTATUS(loc_oCab1, "lbl_4c_Sombra", 5)
257:                     loc_oCab1.lbl_4c_Sombra.Caption = THIS.Caption
258:                 ENDIF
259:                 IF PEMSTATUS(loc_oCab1, "lbl_4c_Titulo", 5)
260:                     loc_oCab1.lbl_4c_Titulo.Caption = THIS.Caption
261:                 ENDIF
262:             ENDIF
263: 
264:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Cabecalho", 5)
265:                 loc_oCab2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho
266:                 IF PEMSTATUS(loc_oCab2, "lbl_4c_Sombra", 5)
267:                     loc_oCab2.lbl_4c_Sombra.Caption = THIS.Caption
268:                 ENDIF
269:                 IF PEMSTATUS(loc_oCab2, "lbl_4c_Titulo", 5)
270:                     loc_oCab2.lbl_4c_Titulo.Caption = THIS.Caption
271:                 ENDIF
272:             ENDIF
273:         ENDIF
274:     ENDPROC
275: 
276:     *--------------------------------------------------------------------------
277:     * ConfigurarPageFrame - PageFrame com Page1 (Filtro) e Page2 (Historico)
278:     * Tabs ocultas (Top=-29 / Tabs=.F.) - controles internos recebem a
279:     * compensacao +29 quando adicionados nas proximas fases
280:     *--------------------------------------------------------------------------
281:     PROTECTED PROCEDURE ConfigurarPageFrame()
282:         LOCAL loc_oErro
283:         TRY
284:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
285:             WITH THIS.pgf_4c_Paginas
286:                 .Top         = -29
287:                 .Left        = 0
288:                 .Width       = THIS.Width
289:                 .Height      = THIS.Height + 29
290:                 .PageCount   = 2
291:                 .Tabs        = .F.
292:                 .BorderWidth = 0
293: 
294:                 .Page1.Caption = "Filtro"
295:                 .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
296: 
297:                 .Page2.Caption = "Hist" + CHR(243) + "rico"
298:                 .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
299:                 .Page2.Enabled = .F.
300:             ENDWITH
301:         CATCH TO loc_oErro
302:             MsgErro(loc_oErro.Message + CHR(13) + ;
303:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
304:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPageFrame")
305:         ENDTRY
306:     ENDPROC
307: 
308:     *--------------------------------------------------------------------------
309:     * ConfigurarContainersBase - Cria o container de cabecalho (faixa cinza)
310:     * em cada Page. E o PRIMEIRO AddObject de cada pagina, para que os
311:     * controles adicionados depois desenhem por cima dele.
312:     *--------------------------------------------------------------------------
313:     PROTECTED PROCEDURE ConfigurarContainersBase()
314:         LOCAL loc_oPag1, loc_oPag2, loc_oErro
315:         TRY
316:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
317:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
318: 
319:             loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
320:             WITH loc_oPag1.cnt_4c_Cabecalho
321:                 .Top         = 0 + 29
322:                 .Left        = 0
323:                 .Width       = THIS.Width
324:                 .Height      = 80
325:                 .BorderWidth = 0
326:                 .BackStyle   = 1
327:                 .BackColor   = RGB(100, 100, 100)
328:                 .Visible     = .T.
329:             ENDWITH
330: 
331:             loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
332:             WITH loc_oPag2.cnt_4c_Cabecalho
333:                 .Top         = 0 + 29
334:                 .Left        = 0
335:                 .Width       = THIS.Width
336:                 .Height      = 80
337:                 .BorderWidth = 0
338:                 .BackStyle   = 1
339:                 .BackColor   = RGB(100, 100, 100)
340:                 .Visible     = .T.
341:             ENDWITH
342:         CATCH TO loc_oErro
343:             MsgErro(loc_oErro.Message + CHR(13) + ;
344:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
345:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarContainersBase")
346:         ENDTRY
347:     ENDPROC
348: 
349:     *--------------------------------------------------------------------------
350:     * ConfigurarPaginaFiltro - Preenche o cabecalho da Page1 (Filtro) com
351:     * o titulo do formulario (lbl_4c_Sombra atras, lbl_4c_Titulo na frente)
352:     *--------------------------------------------------------------------------
353:     PROTECTED PROCEDURE ConfigurarPaginaFiltro()
354:         LOCAL loc_oCab, loc_oPag1, loc_oErro
355:         TRY
356:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
357:             loc_oCab  = loc_oPag1.cnt_4c_Cabecalho
358: 
359:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
360:             WITH loc_oCab.lbl_4c_Sombra
361:                 .AutoSize  = .F.
362:                 .FontBold  = .T.
363:                 .FontName  = "Tahoma"
364:                 .FontSize  = 18
365:                 .BackStyle = 0
366:                 .Alignment = 0
367:                 .Caption   = THIS.Caption
368:                 .Height    = 40
369:                 .Left      = 10
370:                 .Top       = 18
371:                 .Width     = THIS.Width - 20
372:                 .ForeColor = RGB(0, 0, 0)
373:             ENDWITH
374: 
375:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
376:             WITH loc_oCab.lbl_4c_Titulo
377:                 .AutoSize  = .F.
378:                 .FontBold  = .T.
379:                 .FontName  = "Tahoma"
380:                 .FontSize  = 18
381:                 .BackStyle = 0
382:                 .Alignment = 0
383:                 .Caption   = THIS.Caption
384:                 .Height    = 46
385:                 .Left      = 10
386:                 .Top       = 17
387:                 .Width     = THIS.Width - 20
388:                 .ForeColor = RGB(255, 255, 255)
389:             ENDWITH
390: 
391:             *-- Shape1 (decorativo, sem preenchimento nem borda no SCX legado;
392:             *-- BorderColor transcrito do dump, inerte com BorderStyle = 0)
393:             loc_oPag1.AddObject("shp_4c_Shape1", "Shape")

*-- Linhas 406 a 458:
406:         CATCH TO loc_oErro
407:             MsgErro(loc_oErro.Message + CHR(13) + ;
408:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
409:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaFiltro")
410:         ENDTRY
411:     ENDPROC
412: 
413:     *--------------------------------------------------------------------------
414:     * ConfigurarOrigemFiltro - Container "Origem" da Page1: conta, CPF/CNPJ e
415:     * nome do cliente de origem (ou filtro geral, via optFiltro), com os tres
416:     * lookups ligados por SigCdCli.Iclis/Rclis/Cpfs
417:     *--------------------------------------------------------------------------
418:     PROTECTED PROCEDURE ConfigurarOrigemFiltro(par_oPagina)
419:         LOCAL loc_oOrig, loc_oErro
420:         TRY
421:             par_oPagina.AddObject("cnt_4c_Origem", "Container")
422:             WITH par_oPagina.cnt_4c_Origem
423:                 .Top         = 277 + 29
424:                 .Left        = 230
425:                 .Width       = 539
426:                 .Height      = 50
427:                 .BackStyle   = 0
428:                 .BorderWidth = 1
429:                 .BorderColor = RGB(90, 90, 90)
430:                 .TabIndex    = 1
431:                 .Visible     = .T.
432:             ENDWITH
433:             loc_oOrig = par_oPagina.cnt_4c_Origem
434: 
435:             loc_oOrig.AddObject("lbl_4c_Label2", "Label")
436:             WITH loc_oOrig.lbl_4c_Label2
437:                 .AutoSize  = .F.
438:                 .BackStyle = 0
439:                 .Alignment = 0
440:                 .FontSize  = 8
441:                 .Caption   = "Conta"
442:                 .Left      = 5
443:                 .Top       = 4
444:                 .Width     = 60
445:                 .Height    = 14
446:                 .ForeColor = RGB(90, 90, 90)
447:                 .TabIndex  = 1
448:             ENDWITH
449: 
450:             loc_oOrig.AddObject("lbl_4c__CPF", "Label")
451:             WITH loc_oOrig.lbl_4c__CPF
452:                 .AutoSize  = .F.
453:                 .BackStyle = 0
454:                 .Alignment = 0
455:                 .FontSize  = 8
456:                 .Caption   = "CPF / CNPJ"
457:                 .Left      = 90
458:                 .Top       = 4

*-- Linhas 520 a 736:
520:                 .TabIndex      = 6
521:             ENDWITH
522: 
523:             loc_oOrig.AddObject("obj_4c_OptFiltro", "OptionGroup")
524:             WITH loc_oOrig.obj_4c_OptFiltro
525:                 .ButtonCount = 2
526:                 .Top         = -2
527:                 .Left        = 282
528:                 .Width       = 93
529:                 .Height      = 19
530:                 .BackStyle   = 0
531:                 .Value       = 1
532:                 .TabIndex    = 7
533:                 WITH .Buttons(1)
534:                     .Caption   = "\<Lista"
535:                     .FontName        = "Comic Sans MS"
536:                     .FontSize  = 8
537:                     .Height    = 15
538:                     .Left      = 5
539:                     .Top       = 5
540:                     .Width     = 45
541:                     .Style     = 0
542:                     .BackStyle = 0
543:                 ENDWITH
544:                 WITH .Buttons(2)
545:                     .Caption   = "\<Filtro"
546:                     .FontName        = "Comic Sans MS"
547:                     .FontSize  = 8
548:                     .Height    = 15
549:                     .Left      = 48
550:                     .Top       = 5
551:                     .Width     = 45
552:                     .Style     = 0
553:                     .BackStyle = 0
554:                 ENDWITH
555:             ENDWITH
556: 
557:             BINDEVENT(loc_oOrig.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaOrigem")
558:             BINDEVENT(loc_oOrig.txt_4c__Cpf,     "KeyPress", THIS, "ValidarCpfOrigem")
559:             BINDEVENT(loc_oOrig.txt_4c__DConta,  "KeyPress", THIS, "ValidarNomeOrigem")
560: 
561:             *-- Cascata dos PROCEDURE When do legado (exclusao mutua entre
562:             *-- Conta / CPF / Nome / optFiltro) - reaplicada a cada caractere.
563:             *-- O alvo eh AplicarDependenciaCampos (parametro ZERO) e nao
564:             *-- HabilitarCampos: InteractiveChange nao passa argumento e, em
565:             *-- VFP9, parametro nao passado chega como .F. logico, o que
566:             *-- deixaria a tela inteira somente-leitura
567:             BINDEVENT(loc_oOrig.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
568:             BINDEVENT(loc_oOrig.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
569:             BINDEVENT(loc_oOrig.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
570:         CATCH TO loc_oErro
571:             MsgErro(loc_oErro.Message + CHR(13) + ;
572:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
573:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarOrigemFiltro")
574:         ENDTRY
575:     ENDPROC
576: 
577:     *--------------------------------------------------------------------------
578:     * ConfigurarBotoesFiltro - Botoes "Processar" e "Encerrar" da Page1,
579:     * standalone (sem CommandGroup), posicoes do SCX legado (Top+29)
580:     *--------------------------------------------------------------------------
581:     PROTECTED PROCEDURE ConfigurarBotoesFiltro(par_oPagina)
582:         LOCAL loc_oErro
583:         TRY
584:             par_oPagina.AddObject("cmd_4c_Ok", "CommandButton")
585:             WITH par_oPagina.cmd_4c_Ok
586:                 .Top             = 4 + 29
587:                 .Left            = 849
588:                 .Width           = 75
589:                 .Height          = 75
590:                 .Caption         = "Processar"
591:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
592:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
593:                 .FontName        = "Tahoma"
594:                 .FontBold        = .T.
595:                 .FontItalic      = .T.
596:                 .FontSize        = 8
597:                 .ForeColor       = RGB(90, 90, 90)
598:                 .BackColor       = RGB(255, 255, 255)
599:                 .Themes          = .T.
600:                 .SpecialEffect   = 0
601:                 .PicturePosition = 13
602:                 .MousePointer    = 15
603:                 .WordWrap        = .T.
604:             ENDWITH
605: 
606:             par_oPagina.AddObject("cmd_4c_Cancelar", "CommandButton")
607:             WITH par_oPagina.cmd_4c_Cancelar
608:                 .Top             = 4 + 29
609:                 .Left            = 924
610:                 .Width           = 75
611:                 .Height          = 75
612:                 .Caption         = "Encerrar"
613:                 .Cancel          = .T.
614:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
615:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
616:                 .FontName        = "Tahoma"
617:                 .FontBold        = .T.
618:                 .FontItalic      = .T.
619:                 .FontSize        = 8
620:                 .ForeColor       = RGB(90, 90, 90)
621:                 .BackColor       = RGB(255, 255, 255)
622:                 .Themes          = .T.
623:                 .SpecialEffect   = 0
624:                 .PicturePosition = 13
625:                 .MousePointer    = 15
626:                 .WordWrap        = .T.
627:             ENDWITH
628: 
629:             BINDEVENT(par_oPagina.cmd_4c_Ok,        "Click", THIS, "CmdOkClick")
630:             BINDEVENT(par_oPagina.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
631:         CATCH TO loc_oErro
632:             MsgErro(loc_oErro.Message + CHR(13) + ;
633:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
634:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesFiltro")
635:         ENDTRY
636:     ENDPROC
637: 
638:     *--------------------------------------------------------------------------
639:     * ConfigurarPaginaHistorico - Preenche o cabecalho da Page2 (Historico)
640:     * com o titulo do formulario (mesmo padrao da Page1)
641:     *--------------------------------------------------------------------------
642:     PROTECTED PROCEDURE ConfigurarPaginaHistorico()
643:         LOCAL loc_oCab, loc_oPag2, loc_oErro
644:         TRY
645:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
646:             loc_oCab  = loc_oPag2.cnt_4c_Cabecalho
647: 
648:             loc_oCab.AddObject("lbl_4c_Sombra", "Label")
649:             WITH loc_oCab.lbl_4c_Sombra
650:                 .AutoSize  = .F.
651:                 .FontBold  = .T.
652:                 .FontName  = "Tahoma"
653:                 .FontSize  = 18
654:                 .BackStyle = 0
655:                 .Alignment = 0
656:                 .Caption   = THIS.Caption
657:                 .Height    = 40
658:                 .Left      = 10
659:                 .Top       = 18
660:                 .Width     = THIS.Width - 20
661:                 .ForeColor = RGB(0, 0, 0)
662:             ENDWITH
663: 
664:             loc_oCab.AddObject("lbl_4c_Titulo", "Label")
665:             WITH loc_oCab.lbl_4c_Titulo
666:                 .AutoSize  = .F.
667:                 .FontBold  = .T.
668:                 .FontName  = "Tahoma"
669:                 .FontSize  = 18
670:                 .BackStyle = 0
671:                 .Alignment = 0
672:                 .Caption   = THIS.Caption
673:                 .Height    = 46
674:                 .Left      = 10
675:                 .Top       = 17
676:                 .Width     = THIS.Width - 20
677:                 .ForeColor = RGB(255, 255, 255)
678:             ENDWITH
679: 
680:             THIS.ConfigurarPeriodoHistorico(loc_oPag2)
681:             THIS.ConfigurarFollowupHistorico(loc_oPag2)
682:             THIS.ConfigurarEmitenteHistorico(loc_oPag2)
683:         CATCH TO loc_oErro
684:             MsgErro(loc_oErro.Message + CHR(13) + ;
685:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
686:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPaginaHistorico")
687:         ENDTRY
688:     ENDPROC
689: 
690:     *--------------------------------------------------------------------------
691:     * ConfigurarPeriodoHistorico - Container "Cnt_periodo" da Page2: filtro de
692:     * vencimento (Dt_inicial/Dt_final), usado pelos ramos TOTAL/CARTEIRA de
693:     * CarregarDados. Valores iniciais espelham THIS.this_oBusinessObject, ja
694:     * definidos no Init (DATE()/31-12 ou o vencimento unico da CARTEIRA).
695:     *--------------------------------------------------------------------------
696:     PROTECTED PROCEDURE ConfigurarPeriodoHistorico(par_oPagina)
697:         LOCAL loc_oPer, loc_oErro
698:         TRY
699:             par_oPagina.AddObject("cnt_4c__periodo", "Container")
700:             WITH par_oPagina.cnt_4c__periodo
701:                 .Top           = 8 + 29
702:                 .Left          = 647
703:                 .Width         = 230
704:                 .Height        = 67
705:                 .BackStyle     = 1
706:                 .BackColor     = RGB(255, 255, 255)
707:                 .BorderWidth   = 1
708:                 .BorderColor   = RGB(90, 90, 90)
709:                 .SpecialEffect = 1
710:                 .Visible     = .T.
711:             ENDWITH
712:             loc_oPer = par_oPagina.cnt_4c__periodo
713: 
714:             *-- Label1: o dump declara AutoSize = .T., mas AutoSize eh no-op em
715:             *-- Label criado por AddObject (regra #23) - fica .F. com a
716:             *-- Width/Height que o Form Designer calculou (123x15)
717:             loc_oPer.AddObject("lbl_4c_Label1", "Label")
718:             WITH loc_oPer.lbl_4c_Label1
719:                 .AutoSize  = .F.
720:                 .FontBold  = .T.
721:                 .FontName  = "Tahoma"
722:                 .FontSize  = 8
723:                 .BackStyle = 0
724:                 .Alignment = 0
725:                 .Caption   = "Filtro Por Vencimento"
726:                 .Left      = 20
727:                 .Top       = 7
728:                 .Width     = 123
729:                 .Height    = 15
730:                 .ForeColor = RGB(90, 90, 90)
731:                 .TabIndex  = 1
732:             ENDWITH
733: 
734:             loc_oPer.AddObject("lbl_4c_Label2", "Label")
735:             WITH loc_oPer.lbl_4c_Label2
736:                 .AutoSize  = .F.

*-- Linhas 775 a 888:
775:                 .TabIndex      = 7
776:             ENDWITH
777: 
778:             BINDEVENT(loc_oPer.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
779:             BINDEVENT(loc_oPer.txt_4c_Dt_final,   "KeyPress", THIS, "ValidarDataFinal")
780:         CATCH TO loc_oErro
781:             MsgErro(loc_oErro.Message + CHR(13) + ;
782:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
783:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarPeriodoHistorico")
784:         ENDTRY
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * ValidarDataInicial - KeyPress em txt_4c_Dt_inicial (equivalente ao
789:     * Valid do Dt_inicial legado): se a data inicial ficar depois da final,
790:     * a final eh empurrada para a inicial.
791:     *--------------------------------------------------------------------------
792:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
793:         LOCAL loc_oPer, loc_dVal
794: 
795:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
796:             RETURN
797:         ENDIF
798: 
799:         loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
800:         loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
801: 
802:         *-- Legado: If This.Value > This.Parent.Dt_final.Value / This.Parent.Dt_Final.Value = This.Value
803:         IF loc_dVal > ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
804:             loc_oPer.txt_4c_Dt_final.Value = loc_dVal
805:             loc_oPer.txt_4c_Dt_final.Refresh
806:         ENDIF
807: 
808:         THIS.this_oBusinessObject.this_dDataInicial = loc_dVal
809:         THIS.this_oBusinessObject.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * ValidarDataFinal - KeyPress em txt_4c_Dt_final (equivalente ao Valid do
814:     * Dt_final legado): se a data final ficar antes da inicial, a inicial eh
815:     * empurrada para a final, e o historico eh recarregado (legado: ThisForm.
816:     * SqlDados). LostFocus do legado (SetFocus na grade) nao tem equivalente
817:     * aqui - navegacao automatica de foco apos ENTER/TAB fica a cargo do VFP.
818:     *--------------------------------------------------------------------------
819:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
820:         LOCAL loc_oPer, loc_dVal
821: 
822:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
823:             RETURN
824:         ENDIF
825: 
826:         loc_oPer = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
827:         loc_dVal = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
828: 
829:         *-- Legado: If This.Value < This.Parent.Dt_Inicial.Value / This.Parent.Dt_Inicial.Value = This.Value
830:         IF loc_dVal < ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
831:             loc_oPer.txt_4c_Dt_inicial.Value = loc_dVal
832:             loc_oPer.txt_4c_Dt_inicial.Refresh
833:         ENDIF
834: 
835:         THIS.this_oBusinessObject.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
836:         THIS.this_oBusinessObject.this_dDataFinal   = loc_dVal
837: 
838:         *-- Legado: ThisForm.SqlDados. Pelo FUNIL (FormParaBO -> CarregarDados
839:         *-- -> Repintar): popular o cursor nao repinta a grade sozinho
840:         THIS.CarregarLista()
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * ConfigurarFollowupHistorico - Container "Cnt_Followup" da Page2: exibe
845:     * o ultimo followup do cheque corrente (so-leitura; AfterRowColChange de
846:     * grd_4c_Cheque alimenta this.Value - fase de acoes).
847:     *--------------------------------------------------------------------------
848:     PROTECTED PROCEDURE ConfigurarFollowupHistorico(par_oPagina)
849:         LOCAL loc_oFup, loc_oErro
850:         TRY
851:             par_oPagina.AddObject("cnt_4c__Followup", "Container")
852:             WITH par_oPagina.cnt_4c__Followup
853:                 .Top           = 514 + 29
854:                 .Left          = 10
855:                 .Width         = 558
856:                 .Height        = 27
857:                 .BackStyle     = 1
858:                 .BackColor     = RGB(255, 255, 255)
859:                 .BorderWidth   = 1
860:                 .BorderColor   = RGB(90, 90, 90)
861:                 .SpecialEffect = 1
862:                 .Visible     = .T.
863:             ENDWITH
864:             loc_oFup = par_oPagina.cnt_4c__Followup
865: 
866:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
867:             *-- #23) - fica .F. com a Width/Height do SCX (44x15)
868:             loc_oFup.AddObject("lbl_4c_Label1", "Label")
869:             WITH loc_oFup.lbl_4c_Label1
870:                 .AutoSize  = .F.
871:                 .FontName  = "Tahoma"
872:                 .FontSize  = 8
873:                 .BackStyle = 0
874:                 .Alignment = 0
875:                 .Caption   = "Followup"
876:                 .Left      = 8
877:                 .Top       = 6
878:                 .Width     = 44
879:                 .Height    = 15
880:                 .ForeColor = RGB(90, 90, 90)
881:             ENDWITH
882: 
883:             loc_oFup.AddObject("txt_4c_UltFollowup", "TextBox")
884:             WITH loc_oFup.txt_4c_UltFollowup
885:                 .FontName      = "Tahoma"
886:                 .FontSize      = 8
887:                 .Height        = 20
888:                 .Left          = 62

*-- Linhas 898 a 952:
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message + CHR(13) + ;
900:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
901:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarFollowupHistorico")
902:         ENDTRY
903:     ENDPROC
904: 
905:     *--------------------------------------------------------------------------
906:     * ConfigurarEmitenteHistorico - Container "Emitente" da Page2: filtro por
907:     * conta do emitente do cheque (usado so no ramo TOTAL de CarregarDados -
908:     * a.ConOrigs/a.Contat). Mesmo padrao de tres campos + tres lookups do
909:     * container Origem da Page1 (regra: so SigCdCli.Iclis/Rclis/Cpfs, sem
910:     * optFiltro - o dump nao tem OptionGroup aqui).
911:     *--------------------------------------------------------------------------
912:     PROTECTED PROCEDURE ConfigurarEmitenteHistorico(par_oPagina)
913:         LOCAL loc_oEmi, loc_oErro
914:         TRY
915:             par_oPagina.AddObject("cnt_4c_Emitente", "Container")
916:             WITH par_oPagina.cnt_4c_Emitente
917:                 .Top         = 543 + 29
918:                 .Left        = 10
919:                 .Width       = 558
920:                 .Height      = 53
921:                 .BackStyle   = 0
922:                 .BorderWidth = 1
923:                 .BorderColor = RGB(90, 90, 90)
924:                 .TabIndex    = 1
925:                 .Visible     = .T.
926:             ENDWITH
927:             loc_oEmi = par_oPagina.cnt_4c_Emitente
928: 
929:             *-- Label1: dump declara AutoSize = .T. (no-op em AddObject, regra
930:             *-- #23) - fica .F. com a Width/Height do SCX (137x15)
931:             loc_oEmi.AddObject("lbl_4c_Label1", "Label")
932:             WITH loc_oEmi.lbl_4c_Label1
933:                 .AutoSize  = .F.
934:                 .FontName  = "Tahoma"
935:                 .FontSize  = 8
936:                 .BackStyle = 0
937:                 .Alignment = 0
938:                 .Caption   = "Filtro por Conta do Emitente"
939:                 .Left      = 5
940:                 .Top       = 0
941:                 .Width     = 137
942:                 .Height    = 15
943:                 .ForeColor = RGB(90, 90, 90)
944:             ENDWITH
945: 
946:             loc_oEmi.AddObject("lbl_4c_Label2", "Label")
947:             WITH loc_oEmi.lbl_4c_Label2
948:                 .AutoSize  = .F.
949:                 .FontName  = "Tahoma"
950:                 .FontSize  = 8
951:                 .BackStyle = 0
952:                 .Alignment = 0

*-- Linhas 1034 a 1090:
1034:                 .TabIndex      = 6
1035:             ENDWITH
1036: 
1037:             BINDEVENT(loc_oEmi.txt_4c__Conta,  "KeyPress", THIS, "ValidarContaEmitente")
1038:             BINDEVENT(loc_oEmi.txt_4c__Cpf,    "KeyPress", THIS, "ValidarCpfEmitente")
1039:             BINDEVENT(loc_oEmi.txt_4c__DConta, "KeyPress", THIS, "ValidarNomeEmitente")
1040: 
1041:             *-- Cascata dos PROCEDURE When do legado neste container (Conta ->
1042:             *-- CPF -> Nome). Mesmo motivo do alvo parametro-zero descrito em
1043:             *-- ConfigurarOrigemFiltro
1044:             BINDEVENT(loc_oEmi.txt_4c__Conta,  "InteractiveChange", THIS, "AplicarDependenciaCampos")
1045:             BINDEVENT(loc_oEmi.txt_4c__Cpf,    "InteractiveChange", THIS, "AplicarDependenciaCampos")
1046:             BINDEVENT(loc_oEmi.txt_4c__DConta, "InteractiveChange", THIS, "AplicarDependenciaCampos")
1047:         CATCH TO loc_oErro
1048:             MsgErro(loc_oErro.Message + CHR(13) + ;
1049:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1050:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarEmitenteHistorico")
1051:         ENDTRY
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * VerificarAcessoConta - espelha o "If !fAcessoContas(Usuar, '', 'C'|'D',
1056:     * ...)" que o Valid dos TRES campos de conta do legado executa em TODO
1057:     * caminho de resolucao (dump SigOpChi_form_codigo_fonte.txt linhas 2238,
1058:     * 2317, 2398 e 2422 no container Origem; 3302, 3382 e 3463 no Emitente).
1059:     *
1060:     * Chamada SEM os objetos TextBox (pSt1/pSt2): nessa forma o fAcessoContas
1061:     * portado (utils\functions.prg) entra no ramo "Busca sem UI (apenas
1062:     * verifica acesso)" e so devolve .T./.F., sem o auto-load do primeiro
1063:     * match parcial que a regra do projeto proibe em lookup (Erro16). A conta
1064:     * chega aqui JA resolvida, por isso o tipo eh sempre 'C' (codigo) - o ramo
1065:     * 'D' do legado apenas resolve a descricao para o mesmo codigo antes de
1066:     * checar.
1067:     *
1068:     * Sem conexao (modo de teste / ValidarUIFidelity) nao ha o que consultar:
1069:     * devolve .T. para nao bloquear a tela - o legado sempre roda conectado.
1070:     * Em excecao de infraestrutura tambem devolve .T., mas EXIBINDO o erro:
1071:     * "Acesso Negado" por falha transitoria de SQL seria mensagem mentirosa.
1072:     *--------------------------------------------------------------------------
1073:     PROTECTED FUNCTION VerificarAcessoConta(par_cConta)
1074:         LOCAL loc_lAcesso, loc_cUsuario, loc_oErro
1075: 
1076:         loc_lAcesso = .T.
1077: 
1078:         IF VARTYPE(par_cConta) = "C" AND !EMPTY(ALLTRIM(par_cConta)) AND ;
1079:                 TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1080:             loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
1081:             TRY
1082:                 loc_lAcesso = fAcessoContas(loc_cUsuario, "", "C", ALLTRIM(par_cConta))
1083:             CATCH TO loc_oErro
1084:                 MsgErro("Falha ao verificar acesso " + CHR(224) + " conta:" + CHR(13) + ;
1085:                     loc_oErro.Message, "Erro")
1086:                 loc_lAcesso = .T.
1087:             ENDTRY
1088:         ENDIF
1089: 
1090:         RETURN loc_lAcesso

*-- Linhas 1096 a 1691:
1096:     * unica lida por CarregarDados no ramo TOTAL) o registro de SigCdCli
1097:     * resolvido por qualquer um dos tres lookups
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE PreencherEmitente(par_cConta, par_cDConta, par_cCpf)
1100:         LOCAL loc_oEmi, loc_cConta, loc_cDConta, loc_cCpf
1101: 
1102:         loc_cConta  = par_cConta
1103:         loc_cDConta = par_cDConta
1104:         loc_cCpf    = par_cCpf
1105: 
1106:         *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
1107:         *-- (get_Conta.Valid linha 3302: MessageBox('Acesso Negado!!!') +
1108:         *-- .get_conta/.get_dconta/.get_cpf = '' + Return 0). O EMPTY espelha
1109:         *-- o "If !Empty(This.Value)" que cerca a checagem no legado - limpar
1110:         *-- os campos nao se re-verifica.
1111:         IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
1112:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1113:             loc_cConta  = ""
1114:             loc_cDConta = ""
1115:             loc_cCpf    = ""
1116:         ENDIF
1117: 
1118:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1119:         loc_oEmi.txt_4c__Conta.Value  = loc_cConta
1120:         loc_oEmi.txt_4c__DConta.Value = loc_cDConta
1121:         loc_oEmi.txt_4c__Cpf.Value    = loc_cCpf
1122:         loc_oEmi.txt_4c__Conta.Refresh
1123:         loc_oEmi.txt_4c__DConta.Refresh
1124:         loc_oEmi.txt_4c__Cpf.Refresh
1125: 
1126:         THIS.this_oBusinessObject.this_cContaEmitente  = loc_cConta
1127:         THIS.this_oBusinessObject.this_cDContaEmitente = loc_cDConta
1128:         THIS.this_oBusinessObject.this_cCpfEmitente    = loc_cCpf
1129: 
1130:         *-- A cascata do When (regra de dependencia entre os tres campos)
1131:         *-- depende dos valores que acabaram de ser escritos
1132:         THIS.HabilitarCampos(.T.)
1133:     ENDPROC
1134: 
1135:     PROCEDURE LimparEmitente()
1136:         THIS.PreencherEmitente("", "", "")
1137:     ENDPROC
1138: 
1139:     *--------------------------------------------------------------------------
1140:     * ValidarContaEmitente - KeyPress em txt_4c__Conta do Emitente (Valid do
1141:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT
1142:     * exato por Iclis e, sem match, abre o picker com o valor digitado como
1143:     * prefixo. A checagem de acesso do legado roda no funil PreencherEmitente
1144:     * (ver VerificarAcessoConta), que cobre os tres campos do container.
1145:     *--------------------------------------------------------------------------
1146:     PROCEDURE ValidarContaEmitente(par_nKeyCode, par_nShiftAltCtrl)
1147:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1148: 
1149:         IF par_nKeyCode = 115
1150:             THIS.AbrirBuscaContaEmitente()
1151:             RETURN
1152:         ENDIF
1153:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1154:             RETURN
1155:         ENDIF
1156: 
1157:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1158:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
1159:         IF EMPTY(loc_cVal)
1160:             THIS.PreencherEmitente("", "", "")
1161:             RETURN
1162:         ENDIF
1163: 
1164:         TRY
1165:             loc_nResult = SQLEXEC(gnConnHandle, ;
1166:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1167:                 "cursor_4c_EmitenteVal")
1168:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1169:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1170:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1171:             ELSE
1172:                 THIS.AbrirBuscaContaEmitente()
1173:             ENDIF
1174:             IF USED("cursor_4c_EmitenteVal")
1175:                 USE IN cursor_4c_EmitenteVal
1176:             ENDIF
1177:         CATCH TO loc_oErro
1178:             MsgErro(loc_oErro.Message, "Erro")
1179:         ENDTRY
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * AbrirBuscaContaEmitente - picker por Iclis/Rclis em SigCdCli (Pattern A),
1184:     * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa se
1185:     * vazio). Mesmo padrao de AbrirBuscaContaOrigem.
1186:     *--------------------------------------------------------------------------
1187:     PROCEDURE AbrirBuscaContaEmitente()
1188:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1189:               loc_cCpf, loc_oErro
1190: 
1191:         IF THIS.this_lEmLookupEmitente
1192:             RETURN
1193:         ENDIF
1194:         THIS.this_lEmLookupEmitente = .T.
1195: 
1196:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1197:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
1198: 
1199:         TRY
1200:             IF USED("cursor_4c_BuscaEmitente")
1201:                 USE IN cursor_4c_BuscaEmitente
1202:             ENDIF
1203: 
1204:             IF EMPTY(loc_cValor)
1205:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1206:             ELSE
1207:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1208:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1209:                            " ORDER BY Iclis"
1210:             ENDIF
1211:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1212: 
1213:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1214:                     AND !EMPTY(loc_cValor)
1215:                 IF USED("cursor_4c_BuscaEmitente")
1216:                     USE IN cursor_4c_BuscaEmitente
1217:                 ENDIF
1218:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1219:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaEmitente")
1220:             ENDIF
1221: 
1222:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1223:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1224:             ELSE
1225:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1226:                 IF VARTYPE(loc_oBusca) = "O"
1227:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1228:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1229:                     IF loc_oBusca.Mostrar()
1230:                         loc_cCpf = ""
1231:                         IF USED("cursor_4c_BuscaEmitente")
1232:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1233:                         ENDIF
1234:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
1235:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1236:                     ENDIF
1237:                     loc_oBusca.Release()
1238:                 ENDIF
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message, "Erro")
1242:         ENDTRY
1243: 
1244:         IF USED("cursor_4c_BuscaEmitente")
1245:             USE IN cursor_4c_BuscaEmitente
1246:         ENDIF
1247:         THIS.this_lEmLookupEmitente = .F.
1248:     ENDPROC
1249: 
1250:     *--------------------------------------------------------------------------
1251:     * ValidarCpfEmitente - KeyPress em txt_4c__Cpf do Emitente (Valid do
1252:     * get_Cpf legado). Mesma montagem de mascara e validacao de digito
1253:     * verificador (ValidarCPF/ValidarCNPJ) do container Origem.
1254:     *--------------------------------------------------------------------------
1255:     PROCEDURE ValidarCpfEmitente(par_nKeyCode, par_nShiftAltCtrl)
1256:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1257:               loc_oEmi, loc_oErro
1258: 
1259:         IF par_nKeyCode = 115
1260:             THIS.AbrirBuscaCpfEmitente()
1261:             RETURN
1262:         ENDIF
1263:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1264:             RETURN
1265:         ENDIF
1266: 
1267:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1268:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
1269:         IF EMPTY(loc_cVal)
1270:             loc_oEmi.txt_4c__DConta.Value = ""
1271:             loc_oEmi.txt_4c__DConta.Refresh
1272:             RETURN
1273:         ENDIF
1274: 
1275:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")
1276: 
1277:         IF LEN(loc_cDigitos) != 14
1278:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
1279:         ELSE
1280:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
1281:         ENDIF
1282: 
1283:         TRY
1284:             loc_nResult = SQLEXEC(gnConnHandle, ;
1285:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1286:                 "cursor_4c_EmitenteVal")
1287:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1288:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1289:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1290:             ELSE
1291:                 THIS.AbrirBuscaCpfEmitente()
1292:             ENDIF
1293:             IF USED("cursor_4c_EmitenteVal")
1294:                 USE IN cursor_4c_EmitenteVal
1295:             ENDIF
1296:         CATCH TO loc_oErro
1297:             MsgErro(loc_oErro.Message, "Erro")
1298:         ENDTRY
1299: 
1300:         IF LEN(loc_cVal) = 14
1301:             IF !ValidarCPF(loc_cDigitos)
1302:                 MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1303:             ENDIF
1304:         ELSE
1305:             IF !ValidarCNPJ(loc_cDigitos)
1306:                 MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1307:             ENDIF
1308:         ENDIF
1309:     ENDPROC
1310: 
1311:     *--------------------------------------------------------------------------
1312:     * AbrirBuscaCpfEmitente - picker por Cpfs/Rclis em SigCdCli (Pattern A),
1313:     * filtrado por "contem". Mesmo padrao de AbrirBuscaCpfOrigem.
1314:     *--------------------------------------------------------------------------
1315:     PROCEDURE AbrirBuscaCpfEmitente()
1316:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1317:               loc_cConta, loc_oErro
1318: 
1319:         IF THIS.this_lEmLookupEmitente
1320:             RETURN
1321:         ENDIF
1322:         THIS.this_lEmLookupEmitente = .T.
1323: 
1324:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1325:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
1326: 
1327:         TRY
1328:             IF USED("cursor_4c_BuscaEmitente")
1329:                 USE IN cursor_4c_BuscaEmitente
1330:             ENDIF
1331: 
1332:             IF EMPTY(loc_cValor)
1333:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1334:             ELSE
1335:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1336:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1337:                            " ORDER BY Cpfs"
1338:             ENDIF
1339:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1340: 
1341:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1342:                     AND !EMPTY(loc_cValor)
1343:                 IF USED("cursor_4c_BuscaEmitente")
1344:                     USE IN cursor_4c_BuscaEmitente
1345:                 ENDIF
1346:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1347:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaEmitente")
1348:             ENDIF
1349: 
1350:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1351:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1352:             ELSE
1353:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1354:                 IF VARTYPE(loc_oBusca) = "O"
1355:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1356:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1357:                     IF loc_oBusca.Mostrar()
1358:                         loc_cConta = ""
1359:                         IF USED("cursor_4c_BuscaEmitente")
1360:                             loc_cConta = ALLTRIM(cursor_4c_BuscaEmitente.Iclis)
1361:                         ENDIF
1362:                         THIS.PreencherEmitente(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
1363:                             loc_oBusca.cCodigoSelecionado)
1364:                     ENDIF
1365:                     loc_oBusca.Release()
1366:                 ENDIF
1367:             ENDIF
1368:         CATCH TO loc_oErro
1369:             MsgErro(loc_oErro.Message, "Erro")
1370:         ENDTRY
1371: 
1372:         IF USED("cursor_4c_BuscaEmitente")
1373:             USE IN cursor_4c_BuscaEmitente
1374:         ENDIF
1375:         THIS.this_lEmLookupEmitente = .F.
1376:     ENDPROC
1377: 
1378:     *--------------------------------------------------------------------------
1379:     * ValidarNomeEmitente - KeyPress em txt_4c__DConta do Emitente (Valid do
1380:     * get_DConta legado). Mesmo padrao de ValidarNomeOrigem.
1381:     *--------------------------------------------------------------------------
1382:     PROCEDURE ValidarNomeEmitente(par_nKeyCode, par_nShiftAltCtrl)
1383:         LOCAL loc_cVal, loc_nResult, loc_oEmi, loc_oErro
1384: 
1385:         IF par_nKeyCode = 115
1386:             THIS.AbrirBuscaNomeEmitente()
1387:             RETURN
1388:         ENDIF
1389:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1390:             RETURN
1391:         ENDIF
1392: 
1393:         loc_oEmi = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1394:         loc_cVal = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
1395:         IF EMPTY(loc_cVal)
1396:             THIS.PreencherEmitente("", "", "")
1397:             RETURN
1398:         ENDIF
1399: 
1400:         TRY
1401:             loc_nResult = SQLEXEC(gnConnHandle, ;
1402:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1403:                 "cursor_4c_EmitenteVal")
1404:             IF loc_nResult > 0 AND USED("cursor_4c_EmitenteVal") AND !EOF("cursor_4c_EmitenteVal")
1405:                 THIS.PreencherEmitente(ALLTRIM(cursor_4c_EmitenteVal.Iclis), ;
1406:                     ALLTRIM(cursor_4c_EmitenteVal.Rclis), ALLTRIM(cursor_4c_EmitenteVal.Cpfs))
1407:             ELSE
1408:                 THIS.AbrirBuscaNomeEmitente()
1409:             ENDIF
1410:             IF USED("cursor_4c_EmitenteVal")
1411:                 USE IN cursor_4c_EmitenteVal
1412:             ENDIF
1413:         CATCH TO loc_oErro
1414:             MsgErro(loc_oErro.Message, "Erro")
1415:         ENDTRY
1416:     ENDPROC
1417: 
1418:     *--------------------------------------------------------------------------
1419:     * AbrirBuscaNomeEmitente - picker por Rclis/Iclis em SigCdCli (Pattern A),
1420:     * filtrado por "contem". Mesmo padrao de AbrirBuscaNomeOrigem.
1421:     *--------------------------------------------------------------------------
1422:     PROCEDURE AbrirBuscaNomeEmitente()
1423:         LOCAL loc_oEmi, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1424:               loc_cCpf, loc_oErro
1425: 
1426:         IF THIS.this_lEmLookupEmitente
1427:             RETURN
1428:         ENDIF
1429:         THIS.this_lEmLookupEmitente = .T.
1430: 
1431:         loc_oEmi   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
1432:         loc_cValor = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
1433: 
1434:         TRY
1435:             IF USED("cursor_4c_BuscaEmitente")
1436:                 USE IN cursor_4c_BuscaEmitente
1437:             ENDIF
1438: 
1439:             IF EMPTY(loc_cValor)
1440:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1441:             ELSE
1442:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1443:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1444:                            " ORDER BY Rclis"
1445:             ENDIF
1446:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmitente")
1447: 
1448:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0) ;
1449:                     AND !EMPTY(loc_cValor)
1450:                 IF USED("cursor_4c_BuscaEmitente")
1451:                     USE IN cursor_4c_BuscaEmitente
1452:                 ENDIF
1453:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1454:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaEmitente")
1455:             ENDIF
1456: 
1457:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmitente") OR RECCOUNT("cursor_4c_BuscaEmitente") = 0
1458:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1459:             ELSE
1460:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1461:                 IF VARTYPE(loc_oBusca) = "O"
1462:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaEmitente", "Cods", "Descs", ;
1463:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1464:                     IF loc_oBusca.Mostrar()
1465:                         loc_cCpf = ""
1466:                         IF USED("cursor_4c_BuscaEmitente")
1467:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaEmitente.Cpfs)
1468:                         ENDIF
1469:                         THIS.PreencherEmitente(loc_oBusca.cCodigoSelecionado, ;
1470:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1471:                     ENDIF
1472:                     loc_oBusca.Release()
1473:                 ENDIF
1474:             ENDIF
1475:         CATCH TO loc_oErro
1476:             MsgErro(loc_oErro.Message, "Erro")
1477:         ENDTRY
1478: 
1479:         IF USED("cursor_4c_BuscaEmitente")
1480:             USE IN cursor_4c_BuscaEmitente
1481:         ENDIF
1482:         THIS.this_lEmLookupEmitente = .F.
1483:     ENDPROC
1484: 
1485:     *--------------------------------------------------------------------------
1486:     * PreencherOrigem / LimparOrigem - espelham nos tres campos do container
1487:     * Origem o registro de SigCdCli resolvido por qualquer um dos lookups
1488:     * (conta, CPF/CNPJ ou nome)
1489:     *--------------------------------------------------------------------------
1490:     PROCEDURE PreencherOrigem(par_cConta, par_cDConta, par_cCpf)
1491:         LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf
1492: 
1493:         loc_cConta  = par_cConta
1494:         loc_cDConta = par_cDConta
1495:         loc_cCpf    = par_cCpf
1496: 
1497:         *-- Legado: acesso negado exibe o aviso e limpa os TRES campos
1498:         *-- (get_Conta.Valid linha 2238 / get_DConta.Valid linhas 2398 e 2422:
1499:         *-- MessageBox('Acesso Negado!!!') + os tres .Value = '' + Return 0).
1500:         IF !EMPTY(loc_cConta) AND !THIS.VerificarAcessoConta(loc_cConta)
1501:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1502:             loc_cConta  = ""
1503:             loc_cDConta = ""
1504:             loc_cCpf    = ""
1505:         ENDIF
1506: 
1507:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1508:         loc_oOrig.txt_4c__Conta.Value  = loc_cConta
1509:         loc_oOrig.txt_4c__DConta.Value = loc_cDConta
1510:         loc_oOrig.txt_4c__Cpf.Value    = loc_cCpf
1511:         loc_oOrig.txt_4c__Conta.Refresh
1512:         loc_oOrig.txt_4c__DConta.Refresh
1513:         loc_oOrig.txt_4c__Cpf.Refresh
1514: 
1515:         *-- Espelha no BO (fonte unica lida por CarregarDados) e reaplica a
1516:         *-- cascata do When, que depende destes tres valores
1517:         THIS.this_oBusinessObject.this_cContaOrigem  = loc_cConta
1518:         THIS.this_oBusinessObject.this_cDContaOrigem = loc_cDConta
1519:         THIS.this_oBusinessObject.this_cCpfOrigem    = loc_cCpf
1520:         THIS.this_lFiltrado                          = !EMPTY(ALLTRIM(loc_cConta))
1521:         THIS.this_oBusinessObject.this_lFiltrado     = THIS.this_lFiltrado
1522: 
1523:         THIS.HabilitarCampos(.T.)
1524:     ENDPROC
1525: 
1526:     PROCEDURE LimparOrigem()
1527:         THIS.PreencherOrigem("", "", "")
1528:     ENDPROC
1529: 
1530:     *--------------------------------------------------------------------------
1531:     * ValidarContaOrigem - KeyPress em txt_4c__Conta (equivalente ao Valid do
1532:     * get_Conta legado). F4 abre o picker direto; Enter/Tab faz o SELECT exato
1533:     * por Iclis e, sem match, abre o picker com o valor digitado como prefixo.
1534:     *--------------------------------------------------------------------------
1535:     PROCEDURE ValidarContaOrigem(par_nKeyCode, par_nShiftAltCtrl)
1536:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1537: 
1538:         IF par_nKeyCode = 115
1539:             THIS.AbrirBuscaContaOrigem()
1540:             RETURN
1541:         ENDIF
1542:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1543:             RETURN
1544:         ENDIF
1545: 
1546:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1547:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1548:         IF EMPTY(loc_cVal)
1549:             loc_oOrig.txt_4c__DConta.Value = ""
1550:             loc_oOrig.txt_4c__Cpf.Value    = ""
1551:             loc_oOrig.txt_4c__DConta.Refresh
1552:             loc_oOrig.txt_4c__Cpf.Refresh
1553:             RETURN
1554:         ENDIF
1555: 
1556:         TRY
1557:             loc_nResult = SQLEXEC(gnConnHandle, ;
1558:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal), ;
1559:                 "cursor_4c_OrigemVal")
1560:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1561:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1562:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1563:             ELSE
1564:                 THIS.AbrirBuscaContaOrigem()
1565:             ENDIF
1566:             IF USED("cursor_4c_OrigemVal")
1567:                 USE IN cursor_4c_OrigemVal
1568:             ENDIF
1569:         CATCH TO loc_oErro
1570:             MsgErro(loc_oErro.Message, "Erro")
1571:         ENDTRY
1572:     ENDPROC
1573: 
1574:     *--------------------------------------------------------------------------
1575:     * AbrirBuscaContaOrigem - picker por Iclis/Rclis em SigCdCli (Pattern A:
1576:     * SQL no caller + CREATEOBJECT sem parametros + DefinirCursor + Mostrar),
1577:     * filtrado pelo prefixo ja digitado em txt_4c__Conta (ou lista completa
1578:     * se vazio). Cpfs eh lido do cursor apos a selecao, pois DefinirCursor/
1579:     * Mostrar so devolvem codigo+descricao.
1580:     *--------------------------------------------------------------------------
1581:     PROCEDURE AbrirBuscaContaOrigem()
1582:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1583:               loc_cCpf, loc_oErro
1584: 
1585:         IF THIS.this_lEmLookupOrigem
1586:             RETURN
1587:         ENDIF
1588:         THIS.this_lEmLookupOrigem = .T.
1589: 
1590:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1591:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1592: 
1593:         TRY
1594:             IF USED("cursor_4c_BuscaOrigem")
1595:                 USE IN cursor_4c_BuscaOrigem
1596:             ENDIF
1597: 
1598:             IF EMPTY(loc_cValor)
1599:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis"
1600:             ELSE
1601:                 loc_cSQL = "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli " + ;
1602:                            "WHERE Iclis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1603:                            " ORDER BY Iclis"
1604:             ENDIF
1605:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1606: 
1607:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1608:                     AND !EMPTY(loc_cValor)
1609:                 IF USED("cursor_4c_BuscaOrigem")
1610:                     USE IN cursor_4c_BuscaOrigem
1611:                 ENDIF
1612:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1613:                     "SELECT Iclis AS Cods, Rclis AS Descs, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaOrigem")
1614:             ENDIF
1615: 
1616:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1617:                 MsgAviso("Nenhuma conta encontrada.", "Contas")
1618:             ELSE
1619:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1620:                 IF VARTYPE(loc_oBusca) = "O"
1621:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1622:                         "Sele" + CHR(231) + CHR(227) + "o de Conta")
1623:                     IF loc_oBusca.Mostrar()
1624:                         loc_cCpf = ""
1625:                         IF USED("cursor_4c_BuscaOrigem")
1626:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1627:                         ENDIF
1628:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
1629:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1630:                     ENDIF
1631:                     loc_oBusca.Release()
1632:                 ENDIF
1633:             ENDIF
1634:         CATCH TO loc_oErro
1635:             MsgErro(loc_oErro.Message, "Erro")
1636:         ENDTRY
1637: 
1638:         IF USED("cursor_4c_BuscaOrigem")
1639:             USE IN cursor_4c_BuscaOrigem
1640:         ENDIF
1641:         THIS.this_lEmLookupOrigem = .F.
1642:     ENDPROC
1643: 
1644:     *--------------------------------------------------------------------------
1645:     * ValidarCpfOrigem - KeyPress em txt_4c__Cpf (equivalente ao Valid do
1646:     * get_Cpf legado). Monta o CPF/CNPJ formatado (com pontuacao, igual ao
1647:     * valor gravado em SigCdCli.Cpfs), faz o SELECT exato e, sem match, abre
1648:     * o picker; ao final valida o digito verificador com ValidarCPF/ValidarCNPJ
1649:     * (regra #13 - delegar ao validador novo, nao ao wrapper do legado).
1650:     *--------------------------------------------------------------------------
1651:     PROCEDURE ValidarCpfOrigem(par_nKeyCode, par_nShiftAltCtrl)
1652:         LOCAL loc_cVal, loc_cDigitos, loc_cFormatado, loc_nResult, ;
1653:               loc_oOrig, loc_oErro
1654: 
1655:         IF par_nKeyCode = 115
1656:             THIS.AbrirBuscaCpfOrigem()
1657:             RETURN
1658:         ENDIF
1659:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1660:             RETURN
1661:         ENDIF
1662: 
1663:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1664:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1665:         IF EMPTY(loc_cVal)
1666:             loc_oOrig.txt_4c__DConta.Value = ""
1667:             loc_oOrig.txt_4c__DConta.Refresh
1668:             RETURN
1669:         ENDIF
1670: 
1671:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cVal, ".", ""), "-", ""), "/", "")
1672: 
1673:         *-- Igual ao legado: a mascara usada para montar o valor de BUSCA
1674:         *-- (Cpfs = formatado) depende do tamanho dos DIGITOS (sem pontuacao);
1675:         *-- a validacao do digito verificador, mais abaixo, usa o tamanho do
1676:         *-- valor DIGITADO (com pontuacao, se houver) - sao criterios distintos
1677:         *-- no proprio SIGOPCHI.SCX e foram transcritos tal como estao la.
1678:         IF LEN(loc_cDigitos) != 14
1679:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 999.999.999-99")
1680:         ELSE
1681:             loc_cFormatado = TRANSFORM(loc_cDigitos, "@R 99.999.999/9999-99")
1682:         ENDIF
1683: 
1684:         TRY
1685:             loc_nResult = SQLEXEC(gnConnHandle, ;
1686:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cFormatado), ;
1687:                 "cursor_4c_OrigemVal")
1688:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1689:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1690:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1691:             ELSE

*-- Linhas 1700 a 2009:
1700: 
1701:         IF LEN(loc_cVal) = 14
1702:             IF !ValidarCPF(loc_cDigitos)
1703:                 MsgAviso("CPF Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1704:             ENDIF
1705:         ELSE
1706:             IF !ValidarCNPJ(loc_cDigitos)
1707:                 MsgAviso("CGC Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1708:             ENDIF
1709:         ENDIF
1710:     ENDPROC
1711: 
1712:     *--------------------------------------------------------------------------
1713:     * AbrirBuscaCpfOrigem - picker por Cpfs/Rclis em SigCdCli (Pattern A),
1714:     * filtrado por "contem" (igual ao Like '%valor%' do legado). Iclis eh
1715:     * lido do cursor apos a selecao.
1716:     *--------------------------------------------------------------------------
1717:     PROCEDURE AbrirBuscaCpfOrigem()
1718:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1719:               loc_cConta, loc_oErro
1720: 
1721:         IF THIS.this_lEmLookupOrigem
1722:             RETURN
1723:         ENDIF
1724:         THIS.this_lEmLookupOrigem = .T.
1725: 
1726:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1727:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1728: 
1729:         TRY
1730:             IF USED("cursor_4c_BuscaOrigem")
1731:                 USE IN cursor_4c_BuscaOrigem
1732:             ENDIF
1733: 
1734:             IF EMPTY(loc_cValor)
1735:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs"
1736:             ELSE
1737:                 loc_cSQL = "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli " + ;
1738:                            "WHERE Cpfs LIKE " + EscaparSQL("%" + loc_cValor + "%") + ;
1739:                            " ORDER BY Cpfs"
1740:             ENDIF
1741:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1742: 
1743:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1744:                     AND !EMPTY(loc_cValor)
1745:                 IF USED("cursor_4c_BuscaOrigem")
1746:                     USE IN cursor_4c_BuscaOrigem
1747:                 ENDIF
1748:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1749:                     "SELECT Cpfs AS Cods, Rclis AS Descs, Iclis FROM SigCdCli ORDER BY Cpfs", "cursor_4c_BuscaOrigem")
1750:             ENDIF
1751: 
1752:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1753:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1754:             ELSE
1755:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1756:                 IF VARTYPE(loc_oBusca) = "O"
1757:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1758:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1759:                     IF loc_oBusca.Mostrar()
1760:                         loc_cConta = ""
1761:                         IF USED("cursor_4c_BuscaOrigem")
1762:                             loc_cConta = ALLTRIM(cursor_4c_BuscaOrigem.Iclis)
1763:                         ENDIF
1764:                         THIS.PreencherOrigem(loc_cConta, loc_oBusca.cDescricaoSelecionada, ;
1765:                             loc_oBusca.cCodigoSelecionado)
1766:                     ENDIF
1767:                     loc_oBusca.Release()
1768:                 ENDIF
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro(loc_oErro.Message, "Erro")
1772:         ENDTRY
1773: 
1774:         IF USED("cursor_4c_BuscaOrigem")
1775:             USE IN cursor_4c_BuscaOrigem
1776:         ENDIF
1777:         THIS.this_lEmLookupOrigem = .F.
1778:     ENDPROC
1779: 
1780:     *--------------------------------------------------------------------------
1781:     * ValidarNomeOrigem - KeyPress em txt_4c__DConta (equivalente ao Valid do
1782:     * get_DConta legado). Faz o SELECT exato por Rclis e, sem match, abre o
1783:     * picker com o valor digitado como filtro "contem".
1784:     *--------------------------------------------------------------------------
1785:     PROCEDURE ValidarNomeOrigem(par_nKeyCode, par_nShiftAltCtrl)
1786:         LOCAL loc_cVal, loc_nResult, loc_oOrig, loc_oErro
1787: 
1788:         IF par_nKeyCode = 115
1789:             THIS.AbrirBuscaNomeOrigem()
1790:             RETURN
1791:         ENDIF
1792:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1797:         loc_cVal  = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1798:         IF EMPTY(loc_cVal)
1799:             loc_oOrig.txt_4c__Conta.Value = ""
1800:             loc_oOrig.txt_4c__Cpf.Value   = ""
1801:             loc_oOrig.txt_4c__Conta.Refresh
1802:             loc_oOrig.txt_4c__Cpf.Refresh
1803:             RETURN
1804:         ENDIF
1805: 
1806:         TRY
1807:             loc_nResult = SQLEXEC(gnConnHandle, ;
1808:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cVal), ;
1809:                 "cursor_4c_OrigemVal")
1810:             IF loc_nResult > 0 AND USED("cursor_4c_OrigemVal") AND !EOF("cursor_4c_OrigemVal")
1811:                 THIS.PreencherOrigem(ALLTRIM(cursor_4c_OrigemVal.Iclis), ;
1812:                     ALLTRIM(cursor_4c_OrigemVal.Rclis), ALLTRIM(cursor_4c_OrigemVal.Cpfs))
1813:             ELSE
1814:                 THIS.AbrirBuscaNomeOrigem()
1815:             ENDIF
1816:             IF USED("cursor_4c_OrigemVal")
1817:                 USE IN cursor_4c_OrigemVal
1818:             ENDIF
1819:         CATCH TO loc_oErro
1820:             MsgErro(loc_oErro.Message, "Erro")
1821:         ENDTRY
1822:     ENDPROC
1823: 
1824:     *--------------------------------------------------------------------------
1825:     * AbrirBuscaNomeOrigem - picker por Rclis/Iclis em SigCdCli (Pattern A).
1826:     *
1827:     * O modo de busca vem do OptionGroup optFiltro, que o legado consulta no
1828:     * get_DConta.Valid ("If .optFiltro.Value = 2 && Procura Com Filtro"):
1829:     *   Value = 2 (Filtro) -> Like '%valor%' (contem), igual ao legado
1830:     *   Value = 1 (Lista)  -> Like 'valor%'  (comeca com)
1831:     * O ramo Lista do legado chamava fAcessoContas(Usuar,'','D',...) passando
1832:     * os TextBox, forma proibida no projeto porque auto-preenche o primeiro
1833:     * match PARCIAL sem o usuario escolher (Erro16); o substituto canonico eh
1834:     * o picker filtrado por prefixo, que eh o que se faz aqui.
1835:     *
1836:     * Cpfs eh lido do cursor apos a selecao.
1837:     *--------------------------------------------------------------------------
1838:     PROCEDURE AbrirBuscaNomeOrigem()
1839:         LOCAL loc_oOrig, loc_cValor, loc_cSQL, loc_nResult, loc_oBusca, ;
1840:               loc_cCpf, loc_cPadrao, loc_oErro
1841: 
1842:         IF THIS.this_lEmLookupOrigem
1843:             RETURN
1844:         ENDIF
1845:         THIS.this_lEmLookupOrigem = .T.
1846: 
1847:         loc_oOrig  = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1848:         loc_cValor = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1849: 
1850:         TRY
1851:             IF USED("cursor_4c_BuscaOrigem")
1852:                 USE IN cursor_4c_BuscaOrigem
1853:             ENDIF
1854: 
1855:             IF EMPTY(loc_cValor)
1856:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis"
1857:             ELSE
1858:                 *-- optFiltro = 2 ("Filtro") procura por CONTEM; = 1 ("Lista")
1859:                 *-- procura por COMECA COM (ver cabecalho deste metodo)
1860:                 loc_cPadrao = IIF(loc_oOrig.obj_4c_OptFiltro.Value = 2, ;
1861:                     "%" + loc_cValor + "%", loc_cValor + "%")
1862:                 loc_cSQL = "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli " + ;
1863:                            "WHERE RTRIM(Rclis) LIKE " + EscaparSQL(loc_cPadrao) + ;
1864:                            " ORDER BY Rclis"
1865:             ENDIF
1866:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOrigem")
1867: 
1868:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0) ;
1869:                     AND !EMPTY(loc_cValor)
1870:                 IF USED("cursor_4c_BuscaOrigem")
1871:                     USE IN cursor_4c_BuscaOrigem
1872:                 ENDIF
1873:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1874:                     "SELECT Rclis AS Descs, Iclis AS Cods, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaOrigem")
1875:             ENDIF
1876: 
1877:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOrigem") OR RECCOUNT("cursor_4c_BuscaOrigem") = 0
1878:                 MsgAviso("Nenhum cliente encontrado.", "Clientes")
1879:             ELSE
1880:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1881:                 IF VARTYPE(loc_oBusca) = "O"
1882:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaOrigem", "Cods", "Descs", ;
1883:                         "Sele" + CHR(231) + CHR(227) + "o de Cliente")
1884:                     IF loc_oBusca.Mostrar()
1885:                         loc_cCpf = ""
1886:                         IF USED("cursor_4c_BuscaOrigem")
1887:                             loc_cCpf = ALLTRIM(cursor_4c_BuscaOrigem.Cpfs)
1888:                         ENDIF
1889:                         THIS.PreencherOrigem(loc_oBusca.cCodigoSelecionado, ;
1890:                             loc_oBusca.cDescricaoSelecionada, loc_cCpf)
1891:                     ENDIF
1892:                     loc_oBusca.Release()
1893:                 ENDIF
1894:             ENDIF
1895:         CATCH TO loc_oErro
1896:             MsgErro(loc_oErro.Message, "Erro")
1897:         ENDTRY
1898: 
1899:         IF USED("cursor_4c_BuscaOrigem")
1900:             USE IN cursor_4c_BuscaOrigem
1901:         ENDIF
1902:         THIS.this_lEmLookupOrigem = .F.
1903:     ENDPROC
1904: 
1905:     *--------------------------------------------------------------------------
1906:     * CmdOkClick - "Processar" (equivalente ao Ok.Click legado). Valida a
1907:     * conta quando o acesso eh restrito, monta o titulo com os dados de
1908:     * origem resolvidos e troca para a Page2 (Historico).
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE CmdOkClick()
1911:         LOCAL loc_oOrig, loc_cConta, loc_cDConta, loc_cCpf, loc_oErro
1912: 
1913:         loc_oOrig   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
1914:         loc_cConta  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
1915: 
1916:         IF !THIS.this_lAcesso AND EMPTY(loc_cConta)
1917:             MsgAviso("Conta Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
1918:             loc_oOrig.txt_4c__Conta.SetFocus()
1919:             RETURN
1920:         ENDIF
1921: 
1922:         loc_cDConta = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
1923:         loc_cCpf    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
1924: 
1925:         THIS.this_lFiltrado = !EMPTY(loc_cConta)
1926: 
1927:         THIS.Caption = "Hist" + CHR(243) + "rico de Cheques de: " + loc_cConta + " - " + ;
1928:             loc_cDConta + " / " + loc_cCpf
1929:         THIS.AtualizarTituloCabecalho()
1930: 
1931:         TRY
1932:             *-- Legado: .Historico.Cnt_periodo.Visible = .f. - o historico por
1933:             *-- conta (ramo 1 de CarregarDados) ignora o periodo de vencimento,
1934:             *-- entao o filtro de data fica escondido neste caminho
1935:             THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo.Visible = .F.
1936: 
1937:             *-- Troca de pagina, carga das grades e ajuste dos botoes do
1938:             *-- Historico moram TODOS em AlternarPagina (funil unico, usado
1939:             *-- tambem pelo Init e pelo Encerrar do Historico)
1940:             THIS.AlternarPagina(2)
1941:         CATCH TO loc_oErro
1942:             MsgErro(loc_oErro.Message + CHR(13) + ;
1943:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1944:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CmdOkClick")
1945:         ENDTRY
1946:     ENDPROC
1947: 
1948:     *--------------------------------------------------------------------------
1949:     * CmdCancelarClick - "Encerrar" da Page1 (equivalente ao cancelar.Click
1950:     * legado: ThisForm.Release). Alvo do BINDEVENT do botao; o corpo mora em
1951:     * BtnCancelarClick (nome canonico), para existir UM so lugar que fecha.
1952:     *--------------------------------------------------------------------------
1953:     PROCEDURE CmdCancelarClick()
1954:         THIS.BtnCancelarClick()
1955:     ENDPROC
1956: 
1957:     *--------------------------------------------------------------------------
1958:     * ConfigurarGradesHistorico - Cria as TRES grades da Page2 (Historico):
1959:     *   grd_4c_Cheque    <- GradeCheque     (12 colunas, SigChe)
1960:     *   grd_4c_Movimenta <- GradeMovimenta  ( 9 colunas, SigCqChm)
1961:     *   grd_4c_Prorrog   <- GradeProrrog    ( 1 coluna,  SigChea)
1962:     *
1963:     * Geometria/fontes/larguras transcritas do dump do SCX legado. Top recebe
1964:     * a compensacao +29 do pgf_4c_Paginas.Top = -29.
1965:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores so existem
1966:     * depois de CarregarDados, e ControlSource de cursor inexistente derruba o
1967:     * Init. O vinculo mora em VincularGrade*, chamado por CarregarDados.
1968:     *--------------------------------------------------------------------------
1969:     PROTECTED PROCEDURE ConfigurarGradesHistorico()
1970:         LOCAL loc_oPagina, loc_oErro
1971:         TRY
1972:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1973: 
1974:             *-- GradeCheque: Top=124 Left=8 Width=981 Height=228 (dump legado)
1975:             loc_oPagina.AddObject("grd_4c_Cheque", "Grid")
1976:             WITH loc_oPagina.grd_4c_Cheque
1977:                 .Top                = 124 + 29
1978:                 .Left               = 8
1979:                 .Width              = 981
1980:                 .Height             = 228
1981:                 .HeaderHeight       = 0
1982:                 .ColumnCount        = 12
1983:                 .FontName           = "Tahoma"
1984:                 .FontSize           = 8
1985:                 .RowHeight          = 18
1986:                 .ScrollBars         = 2
1987:                 .DeleteMark         = .F.
1988:                 .RecordMark         = .F.
1989:                 .ForeColor          = RGB(0, 0, 0)
1990:                 .BackColor          = RGB(255, 255, 255)
1991:                 .GridLineColor      = RGB(238, 238, 238)
1992:                 .HighlightBackColor = RGB(255, 255, 255)
1993:                 .HighlightForeColor = RGB(15, 41, 104)
1994:                 .HighlightStyle     = 2
1995:                 .ReadOnly           = .T.
1996:                 .Themes             = .F.
1997:                 .Visible            = .T.
1998:             ENDWITH
1999:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Cheque, 12)
2000: 
2001:             *-- Colunas 1..10 travadas (Movable/Resizable = .F. no dump); as
2002:             *-- colunas 11 e 12 nao declaram essas duas e ficam no default
2003:             WITH loc_oPagina.grd_4c_Cheque
2004:                 .Column1.Alignment        = 2
2005:                 .Column1.Text1.Alignment  = 2
2006:                 .Column6.InputMask        = "999,999,999.99"
2007:                 .Column12.Alignment       = 2
2008:                 .Column12.Text1.Alignment = 2
2009:                 .Column11.Movable         = .T.

*-- Linhas 2016 a 2059:
2016:             *-- persiste por toda a vida do form (so os Columns sao recriados a
2017:             *-- cada ColumnCount em VincularGradeCheque), por isso o bind e feito
2018:             *-- UMA vez aqui, nao a cada CarregarDados/VincularGradeCheque
2019:             BINDEVENT(loc_oPagina.grd_4c_Cheque, "AfterRowColChange", THIS, "GradeChequeAfterRowColChange")
2020: 
2021:             *-- GradeMovimenta: Top=359 Left=8 Width=858 Height=147 (dump legado)
2022:             loc_oPagina.AddObject("grd_4c_Movimenta", "Grid")
2023:             WITH loc_oPagina.grd_4c_Movimenta
2024:                 .Top                = 359 + 29
2025:                 .Left               = 8
2026:                 .Width              = 858
2027:                 .Height             = 147
2028:                 .HeaderHeight       = 0
2029:                 .ColumnCount        = 9
2030:                 .FontName           = "Tahoma"
2031:                 .FontSize           = 8
2032:                 .RowHeight          = 18
2033:                 .ScrollBars         = 2
2034:                 .DeleteMark         = .F.
2035:                 *-- RecordMark = .T. eh declaracao EXPLICITA do SCX legado -
2036:                 *-- GradeMovimenta eh a unica das tres grades que exibe a barra
2037:                 *-- de marcacao de registro (PILAR 1)
2038:                 .RecordMark         = .T.
2039:                 .ForeColor          = RGB(0, 0, 0)
2040:                 .BackColor          = RGB(255, 255, 255)
2041:                 .GridLineColor      = RGB(238, 238, 238)
2042:                 .HighlightBackColor = RGB(255, 255, 255)
2043:                 .HighlightForeColor = RGB(15, 41, 104)
2044:                 .HighlightStyle     = 2
2045:                 .ReadOnly           = .T.
2046:                 .Themes             = .F.
2047:                 .Visible            = .T.
2048:             ENDWITH
2049:             THIS.FormatarGradeHistorico(loc_oPagina.grd_4c_Movimenta, 9)
2050: 
2051:             *-- Conta/Origem alinhada a direita (Column5.Text1.Alignment = 3)
2052:             loc_oPagina.grd_4c_Movimenta.Column5.Text1.Alignment = 3
2053: 
2054:             *-- GradeProrrog: Top=359 Left=875 Width=114 Height=146 (dump legado)
2055:             loc_oPagina.AddObject("grd_4c_Prorrog", "Grid")
2056:             WITH loc_oPagina.grd_4c_Prorrog
2057:                 .Top                = 359 + 29
2058:                 .Left               = 875
2059:                 .Width              = 114

*-- Linhas 2080 a 2176:
2080:         CATCH TO loc_oErro
2081:             MsgErro(loc_oErro.Message + CHR(13) + ;
2082:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2083:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarGradesHistorico")
2084:         ENDTRY
2085:     ENDPROC
2086: 
2087:     *--------------------------------------------------------------------------
2088:     * FormatarGradeHistorico - Propriedades comuns a todas as colunas das
2089:     * grades do Historico (dump legado: Column<N> em Verdana 8, Text1 com
2090:     * BorderStyle = 0 / Margin = 0 / ForeColor 0,0,0 / BackColor 255,255,255 e
2091:     * Header1 em Tahoma 8 centralizado). Chamado uma vez por grade.
2092:     *--------------------------------------------------------------------------
2093:     PROTECTED PROCEDURE FormatarGradeHistorico(par_oGrade, par_nColunas)
2094:         LOCAL loc_nI, loc_oColuna
2095:         WITH par_oGrade
2096:             .FontName = "Verdana"
2097:             .FontSize = 8
2098:             .SetAll("Movable", .F., "Column")
2099:             .SetAll("Resizable", .F., "Column")
2100:         ENDWITH
2101: 
2102:         FOR loc_nI = 1 TO par_nColunas
2103:             loc_oColuna = par_oGrade.Columns(loc_nI)
2104:             WITH loc_oColuna.Header1
2105:                 .FontName  = "Tahoma"
2106:                 .FontSize  = 8
2107:                 .Alignment = 2
2108:                 .ForeColor = RGB(0, 0, 0)
2109:             ENDWITH
2110:             WITH loc_oColuna.Text1
2111:                 .FontName    = "Verdana"
2112:                 .FontSize    = 8
2113:                 .BorderStyle = 0
2114:                 .Margin      = 0
2115:                 .ForeColor   = RGB(0, 0, 0)
2116:                 .BackColor   = RGB(255, 255, 255)
2117:             ENDWITH
2118:         ENDFOR
2119:     ENDPROC
2120: 
2121:     *--------------------------------------------------------------------------
2122:     * ConfigurarBotoesHistorico - Cria as duas barras de botoes da Page2:
2123:     *   cmg_4c_Botoes <- Grupo_op     (8 botoes de acao sobre o cheque)
2124:     *   cmg_4c_Saida  <- Grupo_Saida  (Encerrar)
2125:     *
2126:     * Criadas DEPOIS do cnt_4c_Cabecalho (montado em ConfigurarContainersBase):
2127:     * as duas barras ficam na area da faixa do cabecalho (Top = 29) e precisam
2128:     * ser adicionadas por ultimo para desenhar POR CIMA dela.
2129:     * Geometria, caption, picture e tooltip de cada botao vem do dump do SCX
2130:     * legado; a numeracao Buttons(N) segue a numeracao Command<N> do dump.
2131:     * O Click da barra de saida eh ligado aqui, porque o Sair.Click legado eh
2132:     * autocontido. Os Click dos 8 botoes de Grupo_op abrem os formularios de
2133:     * detalhe (SigOpChr/SigOpChb/SigOpChp/SigOpFlp/SigOpChc/SigCdPgr) e sao
2134:     * ligados na fase de acoes.
2135:     *--------------------------------------------------------------------------
2136:     PROTECTED PROCEDURE ConfigurarBotoesHistorico()
2137:         LOCAL loc_oPagina, loc_oErro
2138:         TRY
2139:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2140: 
2141:             *-- Grupo_op: o dump traz AutoSize = .T.; aqui fica .F. com a
2142:             *-- Width/Height medidas do SCX (610x85), porque AutoSize em grupo
2143:             *-- criado por AddObject deixa a caixa dependente da ordem de
2144:             *-- atribuicao das propriedades dos membros
2145:             loc_oPagina.AddObject("cmg_4c_Botoes", "CommandGroup")
2146:             WITH loc_oPagina.cmg_4c_Botoes
2147:                 .AutoSize      = .F.
2148:                 .ButtonCount   = 8
2149:                 .Top           = 29
2150:                 .Left          = 30
2151:                 .Width         = 610
2152:                 .Height        = 85
2153:                 .BackStyle     = 0
2154:                 .BorderStyle   = 0
2155:                 .SpecialEffect = 1
2156:                 .BorderColor   = RGB(90, 90, 90)
2157:                 .Themes        = .F.
2158:                 .Value         = 0
2159:                 .Visible       = .T.
2160: 
2161:                 *-- Command1 = Relatorio
2162:                 WITH .Buttons(1)
2163:                     .Top             = 5
2164:                     .Left            = 230
2165:                     .Width           = 75
2166:                     .Height          = 75
2167:                     .Caption         = "Relat" + CHR(243) + "rio"
2168:                     .FontName        = "Comic Sans MS"
2169:                     .FontSize        = 8
2170:                     .ToolTipText     = "[F6] Relat" + CHR(243) + "rio"
2171:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2172:                     .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2173:                     .PicturePosition = 13
2174:                 ENDWITH
2175: 
2176:                 *-- Command2 = Procurar ("Busca")

*-- Linhas 2291 a 2571:
2291:             *-- indice (1-based) do botao acionado - despachado em CmgBotoesClick.
2292:             *-- O objeto cmg_4c_Botoes persiste (ButtonCount nao e reatribuido
2293:             *-- depois de criado), por isso o bind e feito uma unica vez aqui
2294:             BINDEVENT(loc_oPagina.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")
2295: 
2296:             *-- Grupo_Saida: Left = 917 / Height = 85 com o botao Encerrar 75x75
2297:             *-- em 5,5 - padrao canonico de saida do sistema novo, que coincide
2298:             *-- com o dump legado (o dump traz Width = 85; canonico eh 90)
2299:             loc_oPagina.AddObject("cmg_4c_Saida", "CommandGroup")
2300:             WITH loc_oPagina.cmg_4c_Saida
2301:                 .AutoSize      = .F.
2302:                 .ButtonCount   = 1
2303:                 .Top           = 29
2304:                 .Left          = 917
2305:                 .Width         = 90
2306:                 .Height        = 85
2307:                 .BackStyle     = 0
2308:                 .BorderStyle   = 0
2309:                 .SpecialEffect = 1
2310:                 .BorderColor   = RGB(136, 189, 188)
2311:                 .Themes        = .F.
2312:                 .Value         = 1
2313:                 .Visible       = .T.
2314: 
2315:                 WITH .Buttons(1)
2316:                     .Top             = 5
2317:                     .Left            = 5
2318:                     .Width           = 75
2319:                     .Height          = 75
2320:                     .Caption         = "Encerrar"
2321:                     .FontName        = "Comic Sans MS"
2322:                     .FontSize        = 8
2323:                     .Cancel          = .T.
2324:                     .ToolTipText     = "<ESC> Sair"
2325:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2326:                     .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2327:                     .PicturePosition = 13
2328:                 ENDWITH
2329:             ENDWITH
2330: 
2331:             THIS.FormatarBotoesHistorico(loc_oPagina.cmg_4c_Saida, 1)
2332: 
2333:             BINDEVENT(loc_oPagina.cmg_4c_Saida, "Click", THIS, "CmgSaidaClick")
2334:         CATCH TO loc_oErro
2335:             MsgErro(loc_oErro.Message + CHR(13) + ;
2336:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2337:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarBotoesHistorico")
2338:         ENDTRY
2339:     ENDPROC
2340: 
2341:     *--------------------------------------------------------------------------
2342:     * FormatarBotoesHistorico - Fonte/cores comuns aos membros de um
2343:     * CommandGroup da Page2, transcritas do dump (Comic Sans MS 8 bold italic,
2344:     * ForeColor 90,90,90, BackColor branco, Themes = .F.)
2345:     *--------------------------------------------------------------------------
2346:     PROTECTED PROCEDURE FormatarBotoesHistorico(par_oGrupo, par_nBotoes)
2347:         LOCAL loc_nI
2348:         FOR loc_nI = 1 TO par_nBotoes
2349:             WITH par_oGrupo.Buttons(loc_nI)
2350:                 .FontName      = "Comic Sans MS"
2351:                 .FontSize      = 8
2352:                 .FontBold      = .T.
2353:                 .FontItalic    = .T.
2354:                 .ForeColor     = RGB(90, 90, 90)
2355:                 .BackColor     = RGB(255, 255, 255)
2356:                 .Themes        = .F.
2357:                 .SpecialEffect = 0
2358:                 .MousePointer  = 15
2359:                 .Visible       = .T.
2360:             ENDWITH
2361:         ENDFOR
2362:     ENDPROC
2363: 
2364:     *--------------------------------------------------------------------------
2365:     * AlternarPagina - FUNIL unico de troca entre Filtro (1) e Historico (2).
2366:     * O legado repete o mesmo bloco em tres lugares:
2367:     *   Init       -> .Historico.Enabled = .t. / .Filtro.Enabled = .f. / .ActivePage = 2
2368:     *   Ok.Click   -> idem + SqlDados + Procurar.Enabled = !Filtrado
2369:     *   Sair.Click -> .Filtro.Enabled = .t. / .Historico.Enabled = .f. / .ActivePage = 1
2370:     * Quem desabilita a pagina na ida reabilita na volta - aqui.
2371:     *--------------------------------------------------------------------------
2372:     PROCEDURE AlternarPagina(par_nPagina)
2373:         LOCAL loc_nPagina, loc_oErro
2374:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
2375: 
2376:         TRY
2377:             IF loc_nPagina = 2
2378:                 *-- Espelha "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
2379:                 THIS.this_lFiltrado = ;
2380:                     !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value))
2381:                 THIS.this_oBusinessObject.this_lFiltrado = THIS.this_lFiltrado
2382: 
2383:                 THIS.pgf_4c_Paginas.Page1.Enabled = .F.
2384:                 THIS.pgf_4c_Paginas.Page2.Enabled = .T.
2385:                 THIS.pgf_4c_Paginas.ActivePage    = 2
2386: 
2387:                 *-- Funil do estado dos botoes/campos (repoe o modo e reabilita
2388:                 *-- o que o caminho de ida desabilitou) e funil de carga
2389:                 *-- (FormParaBO -> CarregarDados -> Repintar). O Repintar fica
2390:                 *-- DEPOIS do ActivePage: Refresh em pagina oculta nao pinta.
2391:                 THIS.AjustarBotoesPorModo()
2392:                 THIS.CarregarLista()
2393:             ELSE
2394:                 THIS.pgf_4c_Paginas.Page2.Enabled = .F.
2395:                 THIS.pgf_4c_Paginas.Page1.Enabled = .T.
2396:                 THIS.pgf_4c_Paginas.ActivePage    = 1
2397: 
2398:                 *-- Caminho de VOLTA: sem esta chamada os botoes/campos que o
2399:                 *-- modo Historico ajustou ficariam no estado anterior
2400:                 THIS.AjustarBotoesPorModo()
2401: 
2402:                 IF THIS.Visible
2403:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.SetFocus()
2404:                 ENDIF
2405:             ENDIF
2406:         CATCH TO loc_oErro
2407:             MsgErro(loc_oErro.Message + CHR(13) + ;
2408:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2409:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AlternarPagina")
2410:         ENDTRY
2411:     ENDPROC
2412: 
2413:     *--------------------------------------------------------------------------
2414:     * AjustarBotoesHistorico - Estado dos botoes de Grupo_op, transcrito do
2415:     * legado:
2416:     *   Init/Ok.Click -> .Grupo_op.Procurar.Enabled  = !ThisForm.Filtrado
2417:     *   Init          -> .Grupo_op.Protocolo.Enabled = fChecaAcesso('SigCheHI','PROTOCOLO')
2418:     * Buttons(2) = Procurar ("Busca"), Buttons(6) = Protocolo.
2419:     *--------------------------------------------------------------------------
2420:     PROCEDURE AjustarBotoesHistorico()
2421:         LOCAL loc_oGrupo, loc_oErro
2422:         TRY
2423:             loc_oGrupo = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes
2424:             loc_oGrupo.Buttons(2).Enabled = !THIS.this_lFiltrado
2425:             loc_oGrupo.Buttons(6).Enabled = fChecaAcesso("SigCheHI", "PROTOCOLO")
2426:         CATCH TO loc_oErro
2427:             MsgErro(loc_oErro.Message + CHR(13) + ;
2428:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2429:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesHistorico")
2430:         ENDTRY
2431:     ENDPROC
2432: 
2433:     *--------------------------------------------------------------------------
2434:     * CmgSaidaClick - Encerrar do Historico. Transcrito de Sair.Click: sem
2435:     * acesso irrestrito limpa os campos de Origem, volta ao Filtro e restaura
2436:     * o Caption; com acesso irrestrito fecha o formulario.
2437:     *--------------------------------------------------------------------------
2438:     PROCEDURE CmgSaidaClick()
2439:         IF !THIS.this_lAcesso
2440:             *-- LimparCampos zera Origem/Emitente no BO, restaura o periodo
2441:             *-- default e o Caption "Historico de Cheques", e espelha tudo na
2442:             *-- tela via BOParaForm - os tres passos que o Sair.Click legado
2443:             *-- faz a mao
2444:             THIS.LimparCampos()
2445:             THIS.AlternarPagina(1)
2446:         ELSE
2447:             THIS.Release()
2448:         ENDIF
2449:     ENDPROC
2450: 
2451:     *--------------------------------------------------------------------------
2452:     * FecharCursor - Fecha um alias com seguranca. TABLEREVERT EXIGE buffering
2453:     * (sem ele dispara erro 1586), por isso o CURSORGETPROP antes; USE IN fecha
2454:     * o alias mesmo com buffer sujo.
2455:     *--------------------------------------------------------------------------
2456:     PROTECTED PROCEDURE FecharCursor(par_cAlias)
2457:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias)
2458:             IF USED(par_cAlias)
2459:                 IF CURSORGETPROP("Buffering", par_cAlias) > 1
2460:                     TABLEREVERT(.T., par_cAlias)
2461:                 ENDIF
2462:                 USE IN (par_cAlias)
2463:             ENDIF
2464:         ENDIF
2465:     ENDPROC
2466: 
2467:     *--------------------------------------------------------------------------
2468:     * DesvincularGradesHistorico - Legado: as tres grades recebem
2469:     * RecordSource = ' ' no inicio do SqlDados, antes de os cursores serem
2470:     * refeitos
2471:     *--------------------------------------------------------------------------
2472:     PROTECTED PROCEDURE DesvincularGradesHistorico()
2473:         LOCAL loc_oPagina
2474:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2475:         loc_oPagina.grd_4c_Cheque.RecordSource    = ""
2476:         loc_oPagina.grd_4c_Movimenta.RecordSource = ""
2477:         loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
2478:     ENDPROC
2479: 
2480:     *--------------------------------------------------------------------------
2481:     * RepintarGradesHistorico - Legado: Go Top In <cursor> + <grade>.Refresh.
2482:     * Popular o cursor NAO repinta a grade; e Refresh em pagina oculta nao
2483:     * pinta, por isso AlternarPagina chama este metodo DEPOIS de trocar o
2484:     * ActivePage.
2485:     *--------------------------------------------------------------------------
2486:     PROCEDURE RepintarGradesHistorico()
2487:         LOCAL loc_oPagina, loc_cAliasAnt, loc_oErro
2488:         TRY
2489:             loc_cAliasAnt = ALIAS()
2490:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
2491: 
2492:             IF USED("cursor_4c_Cheque")
2493:                 GO TOP IN cursor_4c_Cheque
2494:             ENDIF
2495:             IF USED("cursor_4c_Movimento")
2496:                 GO TOP IN cursor_4c_Movimento
2497:             ENDIF
2498:             IF USED("cursor_4c_Prorrog")
2499:                 GO TOP IN cursor_4c_Prorrog
2500:             ENDIF
2501: 
2502:             loc_oPagina.grd_4c_Cheque.Refresh()
2503:             loc_oPagina.grd_4c_Movimenta.Refresh()
2504:             loc_oPagina.grd_4c_Prorrog.Refresh()
2505: 
2506:             IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
2507:                 SELECT (loc_cAliasAnt)
2508:             ENDIF
2509:         CATCH TO loc_oErro
2510:             MsgErro(loc_oErro.Message + CHR(13) + ;
2511:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2512:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.RepintarGradesHistorico")
2513:         ENDTRY
2514:     ENDPROC
2515: 
2516:     *--------------------------------------------------------------------------
2517:     * CarregarDados - Transcricao do SqlDados legado.
2518:     *
2519:     * Monta os cursores do Historico e vincula as grades:
2520:     *   cursor_4c_Cheque    (SigChe + coluna Tipo) -> grd_4c_Cheque
2521:     *   cursor_4c_Movimento (SigCqChm)             -> grd_4c_Movimenta
2522:     *   cursor_4c_Prorrog   (SigChea)              -> grd_4c_Prorrog
2523:     *   cursor_4c_ChequeP   (auxiliar: Nums com historico em SigCheh - eh o
2524:     *                        'LocalChP' do legado, que marca a coluna Tipo)
2525:     * Os alias sao os declarados em SigOpChiBO.this_cCursor*.
2526:     *
2527:     * Cada SQLEXEC vai para cursor_4c_Temp e o alias definitivo eh recriado
2528:     * READWRITE a partir dele: SQLEXEC direto sobre o alias ligado a uma grade
2529:     * fecha e recria o alias, zerando o ColumnCount da grade.
2530:     *--------------------------------------------------------------------------
2531:     PROCEDURE CarregarDados()
2532:         LOCAL loc_lSucesso, loc_lModoTeste, loc_lOk, loc_oErro
2533:         LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
2534:         LOCAL loc_cConta, loc_cEmitente, loc_cFiltroEmi, loc_cNumCheque, loc_cAcesso
2535:         LOCAL loc_cSQLChe, loc_cSQLChP, loc_cSQLMov, loc_cSQLPro
2536:         loc_lSucesso = .F.
2537: 
2538:         loc_lModoTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
2539:                          (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
2540: 
2541:         *-- RETURN sempre FORA de TRY/CATCH
2542:         IF loc_lModoTeste OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
2543:             RETURN .F.
2544:         ENDIF
2545: 
2546:         TRY
2547:             loc_lOk = .T.
2548: 
2549:             *-- Legado: RecordSource = ' ' nas tres grades antes de refazer os
2550:             *-- cursores
2551:             THIS.DesvincularGradesHistorico()
2552: 
2553:             loc_dIni = ConverterParaData(THIS.this_oBusinessObject.this_dDataInicial)
2554:             loc_dFim = ConverterParaData(THIS.this_oBusinessObject.this_dDataFinal)
2555:             IF EMPTY(loc_dIni)
2556:                 loc_dIni = DATE()
2557:             ENDIF
2558:             IF EMPTY(loc_dFim)
2559:                 loc_dFim = CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
2560:             ENDIF
2561:             *-- Legado: fDtoSQL(llDatai) e fDtoSQL(llDataf,'23:59:59')
2562:             loc_tIni = DTOT(loc_dIni)
2563:             loc_tFim = DTOT(loc_dFim) + 86399
2564: 
2565:             loc_cAcesso = ALLTRIM(UPPER(THIS.this_oBusinessObject.this_cAcesso))
2566:             *-- FONTE UNICA: a conta de origem vem da property que FormParaBO
2567:             *-- alimenta (CarregarLista chama FormParaBO antes deste metodo).
2568:             *-- Ler o TextBox aqui criaria um segundo caminho que divergiria do
2569:             *-- BO no primeiro ponto que mexesse so num dos dois.
2570:             loc_cConta  = ALLTRIM(THIS.this_oBusinessObject.this_cContaOrigem)
2571:             loc_cSQLChe = ""

*-- Linhas 2624 a 2667:
2624:             *-- ramos monta consulta - o legado nem chega aqui, porque o
2625:             *-- Ok.Click exige a conta antes de trocar de pagina
2626:             IF EMPTY(loc_cSQLChe)
2627:                 MsgAviso("Informe a conta de origem antes de consultar o " + ;
2628:                     "hist" + CHR(243) + "rico.", "Aten" + CHR(231) + CHR(227) + "o")
2629:                 loc_lOk = .F.
2630:             ENDIF
2631: 
2632:             *-- 1) cursor auxiliar: Nums que possuem historico em SigCheh
2633:             IF loc_lOk
2634:                 THIS.FecharCursor("cursor_4c_ChequeP")
2635:                 THIS.FecharCursor("cursor_4c_Temp")
2636:                 IF SQLEXEC(gnConnHandle, loc_cSQLChP, "cursor_4c_Temp") < 0
2637:                     MsgErro("Erro ao consultar o hist" + CHR(243) + "rico dos cheques." + ;
2638:                         CHR(13) + CapturarErroSQL(), "FormSigOpChi.CarregarDados")
2639:                     loc_lOk = .F.
2640:                 ELSE
2641:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_ChequeP READWRITE
2642:                     THIS.FecharCursor("cursor_4c_Temp")
2643:                     SELECT cursor_4c_ChequeP
2644:                     INDEX ON Nums TAG Nums
2645:                 ENDIF
2646:             ENDIF
2647: 
2648:             *-- 2) cursor principal da GradeCheque
2649:             IF loc_lOk
2650:                 THIS.FecharCursor("cursor_4c_Cheque")
2651:                 THIS.FecharCursor("cursor_4c_Temp")
2652:                 IF SQLEXEC(gnConnHandle, loc_cSQLChe, "cursor_4c_Temp") < 0
2653:                     MsgErro("Erro ao consultar os cheques." + CHR(13) + CapturarErroSQL(), ;
2654:                         "FormSigOpChi.CarregarDados")
2655:                     loc_lOk = .F.
2656:                 ELSE
2657:                     SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Cheque READWRITE
2658:                     THIS.FecharCursor("cursor_4c_Temp")
2659:                 ENDIF
2660:             ENDIF
2661: 
2662:             *-- 3) marca com "S" o cheque que tem historico (legado: Scan +
2663:             *-- Seek em LocalChP + Replace Tipo With [S]) e cria os TAGs que a
2664:             *-- ordenacao por cabecalho de coluna usa
2665:             loc_cNumCheque = ""
2666:             IF loc_lOk
2667:                 SELECT cursor_4c_Cheque

*-- Linhas 2754 a 2809:
2754:         CATCH TO loc_oErro
2755:             MsgErro(loc_oErro.Message + CHR(13) + ;
2756:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2757:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.CarregarDados")
2758:         ENDTRY
2759: 
2760:         RETURN loc_lSucesso
2761:     ENDPROC
2762: 
2763:     *--------------------------------------------------------------------------
2764:     * VincularGradeCheque - ColumnCount -> RecordSource -> ControlSource ->
2765:     * Width -> Header1.Caption. A ordem eh obrigatoria: RecordSource recalcula
2766:     * as larguras das colunas para o default, entao Width e caption vem por
2767:     * ultimo. ControlSource e DynamicFore/BackColor transcritos do SqlDados.
2768:     *--------------------------------------------------------------------------
2769:     PROTECTED PROCEDURE VincularGradeCheque()
2770:         LOCAL loc_oGrade
2771:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
2772: 
2773:         WITH loc_oGrade
2774:             .ColumnCount  = 12
2775:             .RecordSource = "cursor_4c_Cheque"
2776: 
2777:             .Column1.ControlSource  = "TTOD(cursor_4c_Cheque.Vencs)"
2778:             .Column2.ControlSource  = "cursor_4c_Cheque.Bancos"
2779:             .Column3.ControlSource  = "cursor_4c_Cheque.Agencias"
2780:             .Column4.ControlSource  = "cursor_4c_Cheque.nContas"
2781:             .Column5.ControlSource  = "cursor_4c_Cheque.nCheques"
2782:             .Column6.ControlSource  = "cursor_4c_Cheque.Valors"
2783:             .Column7.ControlSource  = "cursor_4c_Cheque.GruCarts"
2784:             .Column8.ControlSource  = "cursor_4c_Cheque.ConCarts"
2785:             .Column9.ControlSource  = "cursor_4c_Cheque.Emps"
2786:             .Column10.ControlSource = "cursor_4c_Cheque.Numeros"
2787:             .Column11.ControlSource = "cursor_4c_Cheque.UMovs"
2788:             .Column12.ControlSource = "TTOD(cursor_4c_Cheque.DtEmis)"
2789: 
2790:             .Column1.Width  = 80
2791:             .Column2.Width  = 35
2792:             .Column3.Width  = 49
2793:             .Column4.Width  = 90
2794:             .Column5.Width  = 60
2795:             .Column6.Width  = 115
2796:             .Column7.Width  = 95
2797:             .Column8.Width  = 95
2798:             .Column9.Width  = 31
2799:             .Column10.Width = 58
2800:             .Column11.Width = 150
2801:             .Column12.Width = 80
2802: 
2803:             .Column1.Header1.Caption  = "Vencimento"
2804:             .Column2.Header1.Caption  = "Bco"
2805:             .Column3.Header1.Caption  = "Ag" + CHR(234) + "ncia"
2806:             .Column4.Header1.Caption  = "Conta"
2807:             .Column5.Header1.Caption  = "N" + CHR(250) + "mero"
2808:             .Column6.Header1.Caption  = "Valor"
2809:             .Column7.Header1.Caption  = "Grupo Carteira"

*-- Linhas 2838 a 2894:
2838:             *-- RECRIADOS a cada atribuicao de ColumnCount (regra #183), por
2839:             *-- isso o bind tem de ser refeito aqui, a cada chamada, e nao em
2840:             *-- ConfigurarGradesHistorico (que so roda uma vez)
2841:             BINDEVENT(.Column1.Header1, "Click", THIS, "GradeChequeHeader1Click")
2842:             BINDEVENT(.Column2.Header1, "Click", THIS, "GradeChequeHeader2Click")
2843:             BINDEVENT(.Column3.Header1, "Click", THIS, "GradeChequeHeader3Click")
2844:             BINDEVENT(.Column4.Header1, "Click", THIS, "GradeChequeHeader4Click")
2845:             BINDEVENT(.Column5.Header1, "Click", THIS, "GradeChequeHeader5Click")
2846:             BINDEVENT(.Column6.Header1, "Click", THIS, "GradeChequeHeader6Click")
2847:         ENDWITH
2848:     ENDPROC
2849: 
2850:     *--------------------------------------------------------------------------
2851:     * VincularGradeMovimenta - ControlSource/Width/Caption de GradeMovimenta
2852:     * (SigCqChm), transcritos do SqlDados e do dump legado
2853:     *--------------------------------------------------------------------------
2854:     PROTECTED PROCEDURE VincularGradeMovimenta()
2855:         LOCAL loc_oGrade
2856:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Movimenta
2857: 
2858:         WITH loc_oGrade
2859:             .ColumnCount  = 9
2860:             .RecordSource = "cursor_4c_Movimento"
2861: 
2862:             .Column1.ControlSource = "cursor_4c_Movimento.Codigos"
2863:             .Column2.ControlSource = "cursor_4c_Movimento.Nalineas"
2864:             .Column3.ControlSource = "TTOD(cursor_4c_Movimento.DtEnts)"
2865:             .Column4.ControlSource = "cursor_4c_Movimento.GruOrigs"
2866:             .Column5.ControlSource = "cursor_4c_Movimento.ConOrigs"
2867:             .Column6.ControlSource = "cursor_4c_Movimento.Grupos"
2868:             .Column7.ControlSource = "cursor_4c_Movimento.Contas"
2869:             .Column8.ControlSource = "cursor_4c_Movimento.NumLotes"
2870:             .Column9.ControlSource = "cursor_4c_Movimento.Protocolos"
2871: 
2872:             .Column1.Width = 157
2873:             .Column2.Width = 40
2874:             .Column3.Width = 80
2875:             .Column4.Width = 90
2876:             .Column5.Width = 90
2877:             .Column6.Width = 90
2878:             .Column7.Width = 90
2879:             .Column8.Width = 90
2880:             .Column9.Width = 90
2881: 
2882:             .Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2883:             .Column2.Header1.Caption = "Alinea"
2884:             .Column3.Header1.Caption = "Entrada"
2885:             .Column4.Header1.Caption = "Grupo/Origem"
2886:             .Column5.Header1.Caption = "Conta/Origem"
2887:             .Column6.Header1.Caption = "Grupo/Destino"
2888:             .Column7.Header1.Caption = "Conta/Destino"
2889:             .Column8.Header1.Caption = "Lote"
2890:             .Column9.Header1.Caption = "Protocolo"
2891: 
2892:             *-- Dump legado: Column8 e Column9 declaram apenas Movable = .F.;
2893:             *-- so as sete primeiras travam tambem o Resizable
2894:             .Column8.Resizable = .T.

*-- Linhas 2900 a 3025:
2900:     * VincularGradeProrrog - ControlSource/Width/Caption de GradeProrrog
2901:     * (SigChea - vencimentos das prorrogacoes do cheque corrente)
2902:     *--------------------------------------------------------------------------
2903:     PROTECTED PROCEDURE VincularGradeProrrog()
2904:         LOCAL loc_oGrade
2905:         loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Prorrog
2906: 
2907:         WITH loc_oGrade
2908:             .ColumnCount             = 1
2909:             .RecordSource            = "cursor_4c_Prorrog"
2910:             .Column1.ControlSource   = "TTOD(cursor_4c_Prorrog.Vencs)"
2911:             .Column1.Width           = 83
2912:             .Column1.Header1.Caption = "Prorroga" + CHR(231) + CHR(245) + "es"
2913:         ENDWITH
2914:     ENDPROC
2915: 
2916:     *--------------------------------------------------------------------------
2917:     * IndexarCursorCheque - Os dez TAGs + SET ORDER usados por CarregarDados
2918:     * (carga inicial) e por AcaoProcurarClick (mescla dos cheques encontrados
2919:     * pelo dialogo de busca). Fatorado para nao duplicar o bloco em dois
2920:     * lugares - mesmas dez expressoes do SqlDados legado.
2921:     *--------------------------------------------------------------------------
2922:     PROTECTED PROCEDURE IndexarCursorCheque()
2923:         SELECT cursor_4c_Cheque
2924:         INDEX ON DTOS(Vencs) + Bancos + Agencias + nContas + nCheques TAG Venc
2925:         INDEX ON Bancos + Agencias + nContas + nCheques TAG Cheque
2926:         INDEX ON Agencias + nContas + nCheques TAG Agencia
2927:         INDEX ON Agencias + nContas TAG AgenciaCta
2928:         INDEX ON Agencias + nCheques TAG AgenciaChe
2929:         INDEX ON nContas + nCheques TAG Conta
2930:         INDEX ON nCheques TAG NCheque
2931:         INDEX ON STR(Valors, 12, 2) + Bancos + Agencias + nContas + nCheques TAG Valor
2932:         INDEX ON Numeros TAG Numeros
2933:         INDEX ON Nums TAG Nums
2934:         SET ORDER TO Venc
2935:     ENDPROC
2936: 
2937:     *--------------------------------------------------------------------------
2938:     * ConfigurarCursorProtocolo - Cursor local usado por AcaoProtocoloClick,
2939:     * equivalente ao "Create Cursor TempChq" que o Init legado executa uma
2940:     * unica vez. Chamado uma vez em InicializarForm.
2941:     *--------------------------------------------------------------------------
2942:     PROTECTED PROCEDURE ConfigurarCursorProtocolo()
2943:         LOCAL loc_oErro
2944:         TRY
2945:             IF !USED("cursor_4c_Protocolo")
2946:                 CREATE CURSOR cursor_4c_Protocolo (Bancos C(3), Agencias C(4), ;
2947:                     NContas C(10), NCheques C(6), Vencs D NULL, Valors N(12, 2), ;
2948:                     Emps C(3), Iclis C(10), Grclis C(10), Contas C(10), ;
2949:                     Grupos C(10), ValPags N(12, 2), Nums C(8), Protocolos C(8), Obss M)
2950:                 INDEX ON Bancos + Agencias + NContas + NCheques TAG Cheque
2951:             ENDIF
2952:         CATCH TO loc_oErro
2953:             MsgErro(loc_oErro.Message + CHR(13) + ;
2954:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2955:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.ConfigurarCursorProtocolo")
2956:         ENDTRY
2957:     ENDPROC
2958: 
2959:     *--------------------------------------------------------------------------
2960:     * ExigirChequeSelecionado - Guarda comum aos 8 botoes de cmg_4c_Botoes:
2961:     * nenhum deles tem sentido sem uma linha corrente em cursor_4c_Cheque (o
2962:     * legado presume que a grade sempre tem o cheque corrente porque o Init/
2963:     * SqlDados so chega aqui com Reccount > 0 - aqui a lista pode ficar vazia
2964:     * e os botoes continuam clicaveis)
2965:     *--------------------------------------------------------------------------
2966:     PROTECTED FUNCTION ExigirChequeSelecionado()
2967:         IF !USED("cursor_4c_Cheque") OR RECCOUNT("cursor_4c_Cheque") = 0 OR ;
2968:                 EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNums))
2969:             MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
2970:             RETURN .F.
2971:         ENDIF
2972:         RETURN .T.
2973:     ENDFUNC
2974: 
2975:     *--------------------------------------------------------------------------
2976:     * AtualizarEstadoChequeAtual - Recalcula, para o cheque CORRENTE de
2977:     * cursor_4c_Cheque, tudo que o legado recalcula em GradeCheque.
2978:     * AfterRowColChange: BO (CarregarDoCursor), Caption (so quando Acesso eh
2979:     * TOTAL/CARTEIRA - no filtro restrito o Caption ja foi fixado por
2980:     * CmdOkClick e nao muda por linha), Documento.Enabled (ChkRegister
2981:     * SigCdPgr/SigMvCab x2), Carteira.Enabled (ChkRegister SIGCCCHM) e o
2982:     * texto do ultimo Followup (SigCheh). ChkRegister nao existe na nova
2983:     * arquitetura (regra do projeto) - substituido por SELECT COUNT(*).
2984:     *--------------------------------------------------------------------------
2985:     PROTECTED PROCEDURE AtualizarEstadoChequeAtual()
2986:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
2987:               loc_lDocEnab, loc_lCartEnab, loc_cHist, loc_cRclis, loc_cCpfs, loc_oErro
2988: 
2989:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
2990:             RETURN
2991:         ENDIF
2992: 
2993:         TRY
2994:             SELECT cursor_4c_Cheque
2995:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Cheque")
2996: 
2997:             *-- Caption (legado: ramo "If ThisForm.Acesso")
2998:             IF THIS.this_lAcesso
2999:                 loc_cRclis = ""
3000:                 loc_cCpfs  = ""
3001:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3002:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + ;
3003:                     EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cIClis)), "cursor_4c_CliCaption")
3004:                 IF loc_nResultado > 0 AND USED("cursor_4c_CliCaption") AND !EOF("cursor_4c_CliCaption")
3005:                     loc_cRclis = ALLTRIM(cursor_4c_CliCaption.Rclis)
3006:                     loc_cCpfs  = ALLTRIM(cursor_4c_CliCaption.Cpfs)
3007:                 ENDIF
3008:                 THIS.FecharCursor("cursor_4c_CliCaption")
3009:                 *-- Caption guardado no BO (this_cCaptionAtual eh a fonte unica
3010:                 *-- que BOParaForm espelha ao recarregar a tela)
3011:                 THIS.this_oBusinessObject.this_cCaptionAtual = ;
3012:                     "Hist" + CHR(243) + "rico de Cheques de: " + ;
3013:                     ALLTRIM(THIS.this_oBusinessObject.this_cIClis) + " - " + loc_cRclis + " / " + loc_cCpfs
3014:                 THIS.Caption = THIS.this_oBusinessObject.this_cCaptionAtual
3015:                 THIS.AtualizarTituloCabecalho()
3016:             ENDIF
3017: 
3018:             *-- Documento.Enabled (legado: Do Case com ChkRegister('SigCdPgr',
3019:             *-- laCampo1) / ChkRegister('SigMvCab', laCampo3 - EmpDopNums
3020:             *-- recalculado) / ChkRegister('SigMvCab', laCampo4 - EmpDopNums
3021:             *-- do proprio registro de SigCqChm)
3022:             loc_lDocEnab = .F.
3023:             IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
3024:                 loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
3025:                 loc_cDope = cursor_4c_Movimento.Dopes

*-- Linhas 3080 a 4101:
3080:             THIS.FecharCursor("cursor_4c_FollowupVal")
3081:             *-- Fonte unica no BO; a tela espelha (BOParaForm faz o mesmo ao
3082:             *-- recarregar, para o campo nao "esquecer" o texto)
3083:             THIS.this_oBusinessObject.this_cUltimoFollowup = loc_cHist
3084:             THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = loc_cHist
3085:         CATCH TO loc_oErro
3086:             MsgErro(loc_oErro.Message + CHR(13) + ;
3087:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3088:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AtualizarEstadoChequeAtual")
3089:         ENDTRY
3090:     ENDPROC
3091: 
3092:     *--------------------------------------------------------------------------
3093:     * GradeChequeAfterRowColChange - Transcricao do AfterRowColChange de
3094:     * GradeCheque: ao mudar a linha corrente, refaz Movimento/Prorrog para o
3095:     * Nums da NOVA linha e recalcula Documento/Carteira/Followup/Caption
3096:     * (AtualizarEstadoChequeAtual). Dispara tambem na ligacao inicial do
3097:     * RecordSource (VincularGradeCheque), cobrindo o cheque do GO TOP.
3098:     *--------------------------------------------------------------------------
3099:     PROCEDURE GradeChequeAfterRowColChange(par_nColIndex)
3100:         LOCAL loc_cNums, loc_cSQLMov, loc_cSQLPro, loc_oPagina, loc_oErro
3101: 
3102:         IF !USED("cursor_4c_Cheque") OR EOF("cursor_4c_Cheque")
3103:             RETURN
3104:         ENDIF
3105: 
3106:         loc_cNums   = cursor_4c_Cheque.Nums
3107:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
3108: 
3109:         TRY
3110:             *-- Legado: RecordSource = " " antes de refazer os cursores
3111:             loc_oPagina.grd_4c_Movimenta.RecordSource = ""
3112:             loc_oPagina.grd_4c_Prorrog.RecordSource   = ""
3113: 
3114:             loc_cSQLMov = "SELECT * FROM SigCqChm WHERE Nums = " + EscaparSQL(loc_cNums) + ;
3115:                 " ORDER BY Nums, Dtsis DESC"
3116:             loc_cSQLPro = "SELECT * FROM SigChea WHERE Nums = " + EscaparSQL(loc_cNums)
3117: 
3118:             THIS.FecharCursor("cursor_4c_Movimento")
3119:             THIS.FecharCursor("cursor_4c_Temp")
3120:             IF SQLEXEC(gnConnHandle, loc_cSQLMov, "cursor_4c_Temp") < 0
3121:                 MsgErro("Erro ao consultar a movimenta" + CHR(231) + CHR(227) + ;
3122:                     "o do cheque." + CHR(13) + CapturarErroSQL(), ;
3123:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3124:             ELSE
3125:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Movimento READWRITE
3126:             ENDIF
3127:             THIS.FecharCursor("cursor_4c_Temp")
3128: 
3129:             THIS.FecharCursor("cursor_4c_Prorrog")
3130:             THIS.FecharCursor("cursor_4c_Temp")
3131:             IF SQLEXEC(gnConnHandle, loc_cSQLPro, "cursor_4c_Temp") < 0
3132:                 MsgErro("Erro ao consultar as prorroga" + CHR(231) + CHR(245) + ;
3133:                     "es do cheque." + CHR(13) + CapturarErroSQL(), ;
3134:                     "FormSigOpChi.GradeChequeAfterRowColChange")
3135:             ELSE
3136:                 SELECT * FROM cursor_4c_Temp INTO CURSOR cursor_4c_Prorrog READWRITE
3137:             ENDIF
3138:             THIS.FecharCursor("cursor_4c_Temp")
3139: 
3140:             THIS.VincularGradeMovimenta()
3141:             THIS.VincularGradeProrrog()
3142:             THIS.AtualizarEstadoChequeAtual()
3143:             THIS.RepintarGradesHistorico()
3144:         CATCH TO loc_oErro
3145:             MsgErro(loc_oErro.Message + CHR(13) + ;
3146:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3147:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.GradeChequeAfterRowColChange")
3148:         ENDTRY
3149:     ENDPROC
3150: 
3151:     *--------------------------------------------------------------------------
3152:     * OrdenarGradeCheque / GradeChequeHeader<N>Click - Transcricao dos SEIS
3153:     * Header1.Click do dump legado (Column1..Column6): reindexa pelo TAG da
3154:     * coluna preservando o registro corrente (legado: _Recno = Recno() / Set
3155:     * Order to &lcOrd. / Go _Recno) e realca o cabecalho clicado em verde
3156:     * claro, os outros cinco em cinza. Colunas 7..12 nao tem Header1.Click no
3157:     * legado. Header1.Click nao recebe parametro nenhum do VFP - por isso sao
3158:     * SEIS wrappers PUBLIC (alvo de BINDEVENT), cada um chamando o metodo
3159:     * compartilhado com a coluna fixa.
3160:     *--------------------------------------------------------------------------
3161:     PROTECTED PROCEDURE OrdenarGradeCheque(par_nColuna)
3162:         LOCAL loc_cOrd, loc_oGrade, loc_nI, loc_nRecno, loc_oErro
3163: 
3164:         IF !USED("cursor_4c_Cheque")
3165:             RETURN
3166:         ENDIF
3167: 
3168:         loc_cOrd = ""
3169:         DO CASE
3170:             CASE par_nColuna = 1
3171:                 loc_cOrd = "Venc"
3172:             CASE par_nColuna = 2
3173:                 loc_cOrd = "Cheque"
3174:             CASE par_nColuna = 3
3175:                 loc_cOrd = "Agencia"
3176:             CASE par_nColuna = 4
3177:                 loc_cOrd = "Conta"
3178:             CASE par_nColuna = 5
3179:                 loc_cOrd = "NCheque"
3180:             CASE par_nColuna = 6
3181:                 loc_cOrd = "Valor"
3182:         ENDCASE
3183:         IF EMPTY(loc_cOrd)
3184:             RETURN
3185:         ENDIF
3186: 
3187:         TRY
3188:             loc_nRecno = RECNO("cursor_4c_Cheque")
3189:             SELECT cursor_4c_Cheque
3190:             SET ORDER TO (loc_cOrd)
3191:             IF BETWEEN(loc_nRecno, 1, RECCOUNT())
3192:                 GO RECORD (loc_nRecno)
3193:             ENDIF
3194: 
3195:             loc_oGrade = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3196:             FOR loc_nI = 1 TO 6
3197:                 loc_oGrade.Columns(loc_nI).Header1.BackColor = ;
3198:                     IIF(loc_nI = par_nColuna, RGB(220, 255, 220), RGB(192, 192, 192))
3199:             ENDFOR
3200:             loc_oGrade.Refresh()
3201:         CATCH TO loc_oErro
3202:             MsgErro(loc_oErro.Message + CHR(13) + ;
3203:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3204:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.OrdenarGradeCheque")
3205:         ENDTRY
3206:     ENDPROC
3207: 
3208:     PROCEDURE GradeChequeHeader1Click()
3209:         THIS.OrdenarGradeCheque(1)
3210:     ENDPROC
3211: 
3212:     PROCEDURE GradeChequeHeader2Click()
3213:         THIS.OrdenarGradeCheque(2)
3214:     ENDPROC
3215: 
3216:     PROCEDURE GradeChequeHeader3Click()
3217:         THIS.OrdenarGradeCheque(3)
3218:     ENDPROC
3219: 
3220:     PROCEDURE GradeChequeHeader4Click()
3221:         THIS.OrdenarGradeCheque(4)
3222:     ENDPROC
3223: 
3224:     PROCEDURE GradeChequeHeader5Click()
3225:         THIS.OrdenarGradeCheque(5)
3226:     ENDPROC
3227: 
3228:     PROCEDURE GradeChequeHeader6Click()
3229:         THIS.OrdenarGradeCheque(6)
3230:     ENDPROC
3231: 
3232:     *--------------------------------------------------------------------------
3233:     * CmgBotoesClick - Despachante unico do CommandGroup cmg_4c_Botoes
3234:     * (Grupo_op legado). .Value do CommandGroup eh o indice (1-based) do
3235:     * botao que disparou o Click, na mesma numeracao Buttons(N) usada em
3236:     * ConfigurarBotoesHistorico (Command1..Command8 do dump).
3237:     *--------------------------------------------------------------------------
3238:     PROCEDURE CmgBotoesClick()
3239:         LOCAL loc_nBotao
3240:         loc_nBotao = THIS.pgf_4c_Paginas.Page2.cmg_4c_Botoes.Value
3241: 
3242:         DO CASE
3243:             CASE loc_nBotao = 1
3244:                 THIS.AcaoRelatorioClick()
3245:             CASE loc_nBotao = 2
3246:                 THIS.AcaoProcurarClick()
3247:             CASE loc_nBotao = 3
3248:                 THIS.AcaoProrrogaClick()
3249:             CASE loc_nBotao = 4
3250:                 THIS.AcaoFollowUpClick()
3251:             CASE loc_nBotao = 5
3252:                 THIS.AcaoCarteiraClick()
3253:             CASE loc_nBotao = 6
3254:                 THIS.AcaoProtocoloClick()
3255:             CASE loc_nBotao = 7
3256:                 THIS.AcaoDocumentoClick()
3257:             CASE loc_nBotao = 8
3258:                 THIS.AcaoFollowUpChqClick()
3259:         ENDCASE
3260:     ENDPROC
3261: 
3262:     *--------------------------------------------------------------------------
3263:     * AcaoRelatorioClick - Buttons(1) "Relatorio" ([F6]). Legado: "Do Form
3264:     * SigOpChr With crSigChe.GrClis, crSigChe.IClis, ThisForm". SigOpChr
3265:     * ainda nao foi migrado (sem SCX no acervo desta task) - a acao e
3266:     * tentada de verdade e so degrada com aviso se a classe nao existir.
3267:     *--------------------------------------------------------------------------
3268:     PROCEDURE AcaoRelatorioClick()
3269:         LOCAL loc_oForm, loc_oErro
3270: 
3271:         IF !THIS.ExigirChequeSelecionado()
3272:             RETURN
3273:         ENDIF
3274: 
3275:         TRY
3276:             loc_oForm = CREATEOBJECT("FormSigOpChr", THIS.this_oBusinessObject.this_cGrClis, ;
3277:                 THIS.this_oBusinessObject.this_cIClis, THIS)
3278:             IF VARTYPE(loc_oForm) = "O"
3279:                 loc_oForm.Show()
3280:             ENDIF
3281:         CATCH TO loc_oErro
3282:             MsgAviso("Tela de Relat" + CHR(243) + "rio do Hist" + CHR(243) + "rico (SigOpChr) " + ;
3283:                 "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3284:         ENDTRY
3285:     ENDPROC
3286: 
3287:     *--------------------------------------------------------------------------
3288:     * AcaoProcurarClick - Buttons(2) "Busca" ([F5]). Legado: "Do Form
3289:     * SigOpChb With Thisform.LeCheque, Thisform.ChqLido, Thisform.Leitor,
3290:     * ThisForm" + Refresh + SetFocus na grade. SIGOPCHI nunca declara/usa as
3291:     * tres propriedades do leitor de codigo de barras (varredura do dump:
3292:     * zero ocorrencias fora desta chamada) - chegam sempre em .F./""/.F.,
3293:     * entao e isso que se passa aqui. FormSigOpChb (ja migrado) devolve o
3294:     * resultado da busca em cursor_4c_SigChe (Hide, nao Release - o
3295:     * CHAMADOR le o cursor e so depois libera o dialogo).
3296:     *--------------------------------------------------------------------------
3297:     PROCEDURE AcaoProcurarClick()
3298:         LOCAL loc_oBusca, loc_oGrid, loc_cNums, loc_oErro
3299: 
3300:         TRY
3301:             loc_oBusca = CREATEOBJECT("FormSigOpChb", .F., "", .F., THIS)
3302:             IF VARTYPE(loc_oBusca) = "O"
3303:                 loc_oBusca.Show()
3304: 
3305:                 IF USED("cursor_4c_SigChe") AND RECCOUNT("cursor_4c_SigChe") > 0 AND ;
3306:                         USED("cursor_4c_Cheque")
3307:                     SELECT cursor_4c_SigChe
3308:                     SCAN
3309:                         loc_cNums = Nums
3310:                         IF !SEEK(loc_cNums, "cursor_4c_Cheque", "Nums")
3311:                             SCATTER MEMVAR MEMO
3312:                             SELECT cursor_4c_Cheque
3313:                             APPEND BLANK
3314:                             GATHER MEMVAR MEMO
3315:                             REPLACE Tipo WITH IIF(USED("cursor_4c_ChequeP") AND ;
3316:                                 SEEK(loc_cNums, "cursor_4c_ChequeP", "Nums"), "S", " ")
3317:                         ENDIF
3318:                         SELECT cursor_4c_SigChe
3319:                     ENDSCAN
3320: 
3321:                     THIS.IndexarCursorCheque()
3322:                     SELECT cursor_4c_Cheque
3323:                     GO TOP
3324:                     THIS.AtualizarEstadoChequeAtual()
3325:                     THIS.RepintarGradesHistorico()
3326:                 ENDIF
3327: 
3328:                 loc_oBusca.Release()
3329:             ENDIF
3330:         CATCH TO loc_oErro
3331:             MsgErro(loc_oErro.Message + CHR(13) + ;
3332:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3333:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProcurarClick")
3334:         ENDTRY
3335: 
3336:         *-- Legado: ThisForm.Pagina.Historico.Refresh + GradeCheque.SetFocus +
3337:         *-- GradeCheque.Column1.Text1.SetFocus
3338:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque
3339:         THIS.pgf_4c_Paginas.Page2.Refresh()
3340:         loc_oGrid.SetFocus()
3341:         loc_oGrid.Column1.Text1.SetFocus()
3342:     ENDPROC
3343: 
3344:     *--------------------------------------------------------------------------
3345:     * AcaoProrrogaClick - Buttons(3) "Prorroga" ([F7]). Legado: Seek em
3346:     * crSigCdOpt (Operacaos = CrSigChe.Umovs); bloqueia com aviso se
3347:     * Tipos = "CR" e Prorrogas <> 1; senao "Do Form SigOpChp With ThisForm".
3348:     * crSigCdOpt nao existe como cursor global nesta migracao - substituido
3349:     * por SELECT direto em SigCdOpt. SigOpChp ainda nao foi migrado.
3350:     *--------------------------------------------------------------------------
3351:     PROCEDURE AcaoProrrogaClick()
3352:         LOCAL loc_nResultado, loc_cTipos, loc_nProrrogas, loc_lPode, loc_oForm, loc_oErro
3353: 
3354:         IF !THIS.ExigirChequeSelecionado()
3355:             RETURN
3356:         ENDIF
3357: 
3358:         loc_lPode = .T.
3359:         TRY
3360:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3361:                 "SELECT TOP 1 Tipos, Prorrogas FROM SigCdOpt WHERE Operacaos = " + ;
3362:                 EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cUMovs)), "cursor_4c_OptVal")
3363:             IF loc_nResultado > 0 AND USED("cursor_4c_OptVal") AND !EOF("cursor_4c_OptVal")
3364:                 loc_cTipos     = ALLTRIM(cursor_4c_OptVal.Tipos)
3365:                 loc_nProrrogas = NVL(cursor_4c_OptVal.Prorrogas, 0)
3366:                 IF loc_cTipos == "CR" AND loc_nProrrogas != 1
3367:                     MsgAviso("Imposs" + CHR(237) + "vel prorrogar cheques que n" + CHR(227) + ;
3368:                         "o estejam pendentes...", "Aten" + CHR(231) + CHR(227) + "o!!!")
3369:                     loc_lPode = .F.
3370:                 ENDIF
3371:             ENDIF
3372:             THIS.FecharCursor("cursor_4c_OptVal")
3373:         CATCH TO loc_oErro
3374:             MsgErro(loc_oErro.Message, "Erro")
3375:             loc_lPode = .F.
3376:         ENDTRY
3377: 
3378:         IF !loc_lPode
3379:             RETURN
3380:         ENDIF
3381: 
3382:         TRY
3383:             loc_oForm = CREATEOBJECT("FormSigOpChp", THIS)
3384:             IF VARTYPE(loc_oForm) = "O"
3385:                 loc_oForm.Show()
3386:             ENDIF
3387:         CATCH TO loc_oErro
3388:             MsgAviso("Tela de Prorroga" + CHR(231) + CHR(227) + "o de Cheques (SigOpChp) " + ;
3389:                 "ainda n" + CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3390:         ENDTRY
3391:     ENDPROC
3392: 
3393:     *--------------------------------------------------------------------------
3394:     * AcaoFollowUpClick - Buttons(4) "Followup Clientes" ([F8]). Legado: usa
3395:     * a conta do FILTRO (Pagina.Filtro.Origem.Get_Conta) se preenchida, senao
3396:     * cai para CrSigChe.Iclis do cheque corrente; "do Form SigOpFlp With
3397:     * lcCliente, ThisForm.DatasessionId". SigOpFlp ainda nao foi migrado.
3398:     *--------------------------------------------------------------------------
3399:     PROCEDURE AcaoFollowUpClick()
3400:         LOCAL loc_cCliente, loc_oForm, loc_oErro
3401: 
3402:         loc_cCliente = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c__Conta.Value)
3403:         IF EMPTY(loc_cCliente)
3404:             IF !THIS.ExigirChequeSelecionado()
3405:                 RETURN
3406:             ENDIF
3407:             loc_cCliente = ALLTRIM(THIS.this_oBusinessObject.this_cIClis)
3408:         ENDIF
3409: 
3410:         TRY
3411:             loc_oForm = CREATEOBJECT("FormSigOpFlp", loc_cCliente, THIS.DataSessionId)
3412:             IF VARTYPE(loc_oForm) = "O"
3413:                 loc_oForm.Show()
3414:             ENDIF
3415:         CATCH TO loc_oErro
3416:             MsgAviso("Tela de Followup de Clientes (SigOpFlp) ainda n" + CHR(227) + ;
3417:                 "o foi migrada.", "Indispon" + CHR(237) + "vel")
3418:         ENDTRY
3419:     ENDPROC
3420: 
3421:     *--------------------------------------------------------------------------
3422:     * AcaoCarteiraClick - Buttons(5) "Carteira" ([F11]). Legado: "do Form
3423:     * SigOpChc With ThisForm" + atualiza a grade depois da baixa (comentario
3424:     * do legado: "chama o metodo abaixo para atualizar a grade" via
3425:     * cnt_periodo.dt_final.Valid, aqui pelo funil THIS.CarregarLista()).
3426:     * FormSigOpChc JA FOI MIGRADO (Init recebe o form pai e o Nums do cheque
3427:     * corrente - exatamente o par que este botao fornece).
3428:     *--------------------------------------------------------------------------
3429:     PROCEDURE AcaoCarteiraClick()
3430:         LOCAL loc_oForm, loc_oErro
3431: 
3432:         IF !THIS.ExigirChequeSelecionado()
3433:             RETURN
3434:         ENDIF
3435: 
3436:         TRY
3437:             loc_oForm = CREATEOBJECT("FormSigOpChc", THIS, ALLTRIM(THIS.this_oBusinessObject.this_cNums))
3438:             IF VARTYPE(loc_oForm) = "O"
3439:                 loc_oForm.Show()
3440:             ENDIF
3441:         CATCH TO loc_oErro
3442:             MsgErro(loc_oErro.Message + CHR(13) + ;
3443:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3444:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoCarteiraClick")
3445:         ENDTRY
3446: 
3447:         THIS.CarregarLista()
3448:     ENDPROC
3449: 
3450:     *--------------------------------------------------------------------------
3451:     * AcaoProtocoloClick - Buttons(6) "Protocolo" ([F9]). Legado: sem
3452:     * Protocolos no cheque, apenas avisa; com Protocolos, monta TempChq (aqui
3453:     * cursor_4c_Protocolo) com os dados do cheque + o Protocolos da
3454:     * movimentacao corrente e abre "Do Form SigOpIbo With ThisForm, 1,
3455:     * lcCaption" (impressao). SigOpIbo ainda nao foi migrado - a preparacao
3456:     * do cursor de impressao (o trabalho de dado real do botao) e feita de
3457:     * qualquer forma; so a tela de impressao em si degrada com aviso.
3458:     *--------------------------------------------------------------------------
3459:     PROCEDURE AcaoProtocoloClick()
3460:         LOCAL loc_cCheque, loc_cCaption, loc_cProtocolo, loc_oForm, loc_oErro
3461: 
3462:         IF !THIS.ExigirChequeSelecionado()
3463:             RETURN
3464:         ENDIF
3465: 
3466:         IF EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cProtocolos))
3467:             MsgAviso("Este lan" + CHR(231) + "amento n" + CHR(227) + "o possui protocolo!", "Aviso...")
3468:             RETURN
3469:         ENDIF
3470: 
3471:         loc_cCheque  = ALLTRIM(THIS.this_oBusinessObject.this_cBancos) + "/" + ;
3472:                        ALLTRIM(THIS.this_oBusinessObject.this_cAgencias) + "/" + ;
3473:                        ALLTRIM(THIS.this_oBusinessObject.this_cNContas) + "/" + ;
3474:                        ALLTRIM(THIS.this_oBusinessObject.this_cNCheques)
3475:         loc_cCaption = "Impress" + CHR(227) + "o do Protocolo do Cheque: " + loc_cCheque
3476: 
3477:         loc_cProtocolo = ""
3478:         IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
3479:             loc_cProtocolo = ALLTRIM(cursor_4c_Movimento.Protocolos)
3480:         ENDIF
3481: 
3482:         TRY
3483:             IF USED("cursor_4c_Protocolo")
3484:                 SELECT cursor_4c_Protocolo
3485:                 ZAP
3486:                 INSERT INTO cursor_4c_Protocolo (Bancos, Agencias, NContas, NCheques, Vencs, Valors, Protocolos) ;
3487:                     VALUES (THIS.this_oBusinessObject.this_cBancos, THIS.this_oBusinessObject.this_cAgencias, ;
3488:                             THIS.this_oBusinessObject.this_cNContas, THIS.this_oBusinessObject.this_cNCheques, ;
3489:                             ConverterParaData(THIS.this_oBusinessObject.this_dVencs), ;
3490:                             THIS.this_oBusinessObject.this_nValors, loc_cProtocolo)
3491:             ENDIF
3492:         CATCH TO loc_oErro
3493:             MsgErro(loc_oErro.Message + CHR(13) + ;
3494:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3495:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoProtocoloClick")
3496:         ENDTRY
3497: 
3498:         TRY
3499:             loc_oForm = CREATEOBJECT("FormSigOpIbo", THIS, 1, loc_cCaption)
3500:             IF VARTYPE(loc_oForm) = "O"
3501:                 loc_oForm.Show()
3502:             ENDIF
3503:         CATCH TO loc_oErro
3504:             MsgAviso("Tela de Impress" + CHR(227) + "o de Protocolo (SigOpIbo) ainda n" + ;
3505:                 CHR(227) + "o foi migrada.", "Indispon" + CHR(237) + "vel")
3506:         ENDTRY
3507:     ENDPROC
3508: 
3509:     *--------------------------------------------------------------------------
3510:     * AcaoDocumentoClick - Buttons(7) "Movimento" ([F4], "Documento" no
3511:     * legado). Legado: Do Case com tres ChkRegister (SigCdPgr por Emps/Dopes/
3512:     * Numes; SigMvCab por EmpDopNums recalculado; SigMvCab por EmpDopNums do
3513:     * proprio registro de SigCqChm), abrindo SigCdPgr/SigMvExp conforme o
3514:     * primeiro que casar. ChkRegister nao existe na nova arquitetura -
3515:     * substituido por SELECT COUNT(*). FormSigMvExp JA FOI MIGRADO; SigCdPgr
3516:     * ainda nao. O guard "WExist('FORM_')" do legado (bloqueia abrir SigMvExp
3517:     * com a Movimentacao de Estoque aberta) nao tem equivalente nesta
3518:     * arquitetura - nao ha janela "FORM_" para detectar.
3519:     *--------------------------------------------------------------------------
3520:     PROCEDURE AcaoDocumentoClick()
3521:         LOCAL loc_cEmpr, loc_cDope, loc_nNume, loc_cKey1, loc_cKey2, loc_nResultado, ;
3522:               loc_oForm, loc_oErro
3523: 
3524:         IF !THIS.ExigirChequeSelecionado()
3525:             RETURN
3526:         ENDIF
3527:         IF !USED("cursor_4c_Movimento") OR EOF("cursor_4c_Movimento")
3528:             MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o selecionada.", ;
3529:                 "Aten" + CHR(231) + CHR(227) + "o")
3530:             RETURN
3531:         ENDIF
3532: 
3533:         loc_cEmpr = THIS.this_oBusinessObject.this_cEmps
3534:         loc_cDope = cursor_4c_Movimento.Dopes
3535:         loc_nNume = cursor_4c_Movimento.NumDopes
3536:         *-- Chave POSICIONAL (char padded) - NUNCA ALLTRIM nas partes
3537:         loc_cKey1 = loc_cEmpr + loc_cDope + STR(loc_nNume, 6)
3538:         loc_cKey2 = cursor_4c_Movimento.EmpDopNums
3539: 
3540:         loc_oForm = .NULL.
3541:         TRY
3542:             loc_nResultado = SQLEXEC(gnConnHandle, ;
3543:                 "SELECT COUNT(*) AS nExiste FROM SigCdPgr WHERE Emps = " + EscaparSQL(ALLTRIM(loc_cEmpr)) + ;
3544:                 " AND Dopes = " + EscaparSQL(loc_cDope) + " AND Numes = " + FormatarNumeroSQL(loc_nNume, 0), ;
3545:                 "cursor_4c_DocVal")
3546:             IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3547:                 THIS.FecharCursor("cursor_4c_DocVal")
3548:                 TRY
3549:                     loc_oForm = CREATEOBJECT("FormSigCdPgr", LEFT(loc_cDope, 1), .T., loc_cEmpr, loc_cDope, loc_nNume)
3550:                 CATCH TO loc_oErro
3551:                     MsgAviso("Tela de Registro de Pagamentos (SigCdPgr) ainda n" + CHR(227) + ;
3552:                         "o foi migrada.", "Indispon" + CHR(237) + "vel")
3553:                 ENDTRY
3554:             ELSE
3555:                 THIS.FecharCursor("cursor_4c_DocVal")
3556:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3557:                     "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3558:                     EscaparSQL(loc_cKey1), "cursor_4c_DocVal")
3559:                 IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3560:                     THIS.FecharCursor("cursor_4c_DocVal")
3561:                     loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, loc_cEmpr, .T.)
3562:                 ELSE
3563:                     THIS.FecharCursor("cursor_4c_DocVal")
3564:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
3565:                         "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
3566:                         EscaparSQL(loc_cKey2), "cursor_4c_DocVal")
3567:                     IF loc_nResultado > 0 AND USED("cursor_4c_DocVal") AND NVL(cursor_4c_DocVal.nExiste, 0) > 0
3568:                         loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cDope, "C", loc_nNume, ;
3569:                             cursor_4c_Movimento.Emps, .T.)
3570:                     ENDIF
3571:                 ENDIF
3572:             ENDIF
3573:             THIS.FecharCursor("cursor_4c_DocVal")
3574: 
3575:             IF VARTYPE(loc_oForm) = "O"
3576:                 loc_oForm.Show()
3577:             ENDIF
3578:         CATCH TO loc_oErro
3579:             MsgErro(loc_oErro.Message + CHR(13) + ;
3580:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3581:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoDocumentoClick")
3582:         ENDTRY
3583:     ENDPROC
3584: 
3585:     *--------------------------------------------------------------------------
3586:     * AcaoFollowUpChqClick - Buttons(8) "Followup Cheques" ([F3],
3587:     * "followUpChq" no legado). Legado: "Do Form SigOpCfl With crSigChe.Nums,
3588:     * ThisForm.DatasessionId" + SetFocus na grade. FormSigOpCfl JA FOI
3589:     * MIGRADO (Init: par_cConta recebe exatamente o SigChe.Nums do cheque
3590:     * consultado - mesma semantica desta chamada).
3591:     *--------------------------------------------------------------------------
3592:     PROCEDURE AcaoFollowUpChqClick()
3593:         LOCAL loc_oForm, loc_oErro
3594: 
3595:         IF !THIS.ExigirChequeSelecionado()
3596:             RETURN
3597:         ENDIF
3598: 
3599:         TRY
3600:             loc_oForm = CREATEOBJECT("FormSigOpCfl", ALLTRIM(THIS.this_oBusinessObject.this_cNums), ;
3601:                 THIS.DataSessionId)
3602:             IF VARTYPE(loc_oForm) = "O"
3603:                 loc_oForm.Show()
3604:             ENDIF
3605:         CATCH TO loc_oErro
3606:             MsgErro(loc_oErro.Message + CHR(13) + ;
3607:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3608:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AcaoFollowUpChqClick")
3609:         ENDTRY
3610: 
3611:         THIS.pgf_4c_Paginas.Page2.grd_4c_Cheque.SetFocus()
3612:     ENDPROC
3613: 
3614:     *==========================================================================
3615:     * FASE 8 - CONSOLIDACAO: hooks de transferencia, funil de carga, estado
3616:     * dos campos e dos botoes.
3617:     *
3618:     * Este form OPERACIONAL nao tem CRUD (o legado SIGOPCHI nao faz Insert/
3619:     * Update/Delete em SigChe - ver cabecalho de SigOpChiBO.prg), mas TEM
3620:     * campos EDITAVEIS que alimentam a operacao: os tres campos do container
3621:     * Origem (Page1) + o OptionGroup Lista/Filtro, os tres campos do container
3622:     * Emitente (Page2) e as duas datas do periodo de vencimento. Por isso
3623:     * FormParaBO/BOParaForm existem de verdade aqui - o bloco ja estava no
3624:     * Init legado, espalhado pelos AddObject, sem esse nome.
3625:     *==========================================================================
3626: 
3627:     *--------------------------------------------------------------------------
3628:     * FormParaBO - Le os campos EDITAVEIS da tela para as propriedades do BO,
3629:     * que sao a FONTE UNICA lida por CarregarDados.
3630:     *
3631:     * PROTECTED porque FormBase declara este hook PROTECTED e VFP9 nao permite
3632:     * ALARGAR o escopo de metodo herdado.
3633:     *
3634:     * Transferencia pura, sem validacao propria: a unica validacao que o
3635:     * legado faz antes de consultar eh a conta obrigatoria quando o acesso eh
3636:     * restrito, e ela mora em CmdOkClick (Ok.Click legado) e no guard de
3637:     * CarregarDados - repeti-la aqui exibiria a mesma mensagem duas vezes.
3638:     *--------------------------------------------------------------------------
3639:     PROTECTED FUNCTION FormParaBO()
3640:         LOCAL loc_lSucesso, loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro
3641:         loc_lSucesso = .F.
3642: 
3643:         TRY
3644:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3645:                     PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3646:                 loc_oBO   = THIS.this_oBusinessObject
3647:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3648:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3649:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3650: 
3651:                 *-- Container Origem (Pagina.Filtro.Origem do legado)
3652:                 loc_oBO.this_cContaOrigem  = ALLTRIM(loc_oOrig.txt_4c__Conta.Value)
3653:                 loc_oBO.this_cDContaOrigem = ALLTRIM(loc_oOrig.txt_4c__DConta.Value)
3654:                 loc_oBO.this_cCpfOrigem    = ALLTRIM(loc_oOrig.txt_4c__Cpf.Value)
3655: 
3656:                 *-- optFiltro eh OptionGroup: .Value eh o INDICE 1-based do
3657:                 *-- botao marcado (1 = Lista, 2 = Filtro), NUNCA 0/1 logico
3658:                 loc_oBO.this_nTipoFiltroOrigem = ;
3659:                     IIF(loc_oOrig.obj_4c_OptFiltro.Value >= 1, loc_oOrig.obj_4c_OptFiltro.Value, 1)
3660: 
3661:                 *-- Container Emitente (Pagina.Historico.Emitente do legado)
3662:                 loc_oBO.this_cContaEmitente  = ALLTRIM(loc_oEmi.txt_4c__Conta.Value)
3663:                 loc_oBO.this_cDContaEmitente = ALLTRIM(loc_oEmi.txt_4c__DConta.Value)
3664:                 loc_oBO.this_cCpfEmitente    = ALLTRIM(loc_oEmi.txt_4c__Cpf.Value)
3665: 
3666:                 *-- Periodo de vencimento (Cnt_periodo). ConverterParaData
3667:                 *-- normaliza DATE/DATETIME/CHAR - TTOD() direto estouraria
3668:                 *-- erro 11 com o DATE que o TextBox guarda
3669:                 loc_oBO.this_dDataInicial = ConverterParaData(loc_oPer.txt_4c_Dt_inicial.Value)
3670:                 loc_oBO.this_dDataFinal   = ConverterParaData(loc_oPer.txt_4c_Dt_final.Value)
3671: 
3672:                 *-- Espelho do "ThisForm.Filtrado = !Empty(Get_Conta.Value)"
3673:                 THIS.this_lFiltrado    = !EMPTY(loc_oBO.this_cContaOrigem)
3674:                 loc_oBO.this_lFiltrado = THIS.this_lFiltrado
3675: 
3676:                 loc_lSucesso = .T.
3677:             ENDIF
3678:         CATCH TO loc_oErro
3679:             MsgErro(loc_oErro.Message + CHR(13) + ;
3680:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3681:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.FormParaBO")
3682:         ENDTRY
3683: 
3684:         RETURN loc_lSucesso
3685:     ENDFUNC
3686: 
3687:     *--------------------------------------------------------------------------
3688:     * BOParaForm - Caminho inverso: escreve as propriedades do BO nos campos
3689:     * editaveis e nos campos somente-exibicao (Followup e Caption).
3690:     *
3691:     * Equivale ao bloco de ".<campo>.Value = ThisForm.<prop>" que o Init
3692:     * legado executa depois de resolver o periodo default e os parametros de
3693:     * pre-filtro (pBancos/pAgencias/pNContas/pNCheques/pVencs no acesso
3694:     * CARTEIRA). Eh o ponto de RECARGA: chamado por AlternarPagina e por
3695:     * LimparCampos, de modo que a tela sempre reflita o BO.
3696:     *
3697:     * PROTECTED pelo mesmo motivo de FormParaBO (hook herdado de FormBase).
3698:     *--------------------------------------------------------------------------
3699:     PROTECTED PROCEDURE BOParaForm()
3700:         LOCAL loc_oOrig, loc_oEmi, loc_oPer, loc_oBO, loc_oErro
3701: 
3702:         TRY
3703:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
3704:                     PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3705:                 loc_oBO   = THIS.this_oBusinessObject
3706:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3707:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3708:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3709: 
3710:                 loc_oOrig.txt_4c__Conta.Value    = loc_oBO.this_cContaOrigem
3711:                 loc_oOrig.txt_4c__DConta.Value   = loc_oBO.this_cDContaOrigem
3712:                 loc_oOrig.txt_4c__Cpf.Value      = loc_oBO.this_cCpfOrigem
3713:                 loc_oOrig.obj_4c_OptFiltro.Value = ;
3714:                     IIF(loc_oBO.this_nTipoFiltroOrigem >= 1, loc_oBO.this_nTipoFiltroOrigem, 1)
3715: 
3716:                 loc_oEmi.txt_4c__Conta.Value  = loc_oBO.this_cContaEmitente
3717:                 loc_oEmi.txt_4c__DConta.Value = loc_oBO.this_cDContaEmitente
3718:                 loc_oEmi.txt_4c__Cpf.Value    = loc_oBO.this_cCpfEmitente
3719: 
3720:                 loc_oPer.txt_4c_Dt_inicial.Value = ConverterParaData(loc_oBO.this_dDataInicial)
3721:                 loc_oPer.txt_4c_Dt_final.Value   = ConverterParaData(loc_oBO.this_dDataFinal)
3722: 
3723:                 *-- Campos somente-exibicao: o texto do ultimo followup e o
3724:                 *-- Caption do form sao resolvidos por AtualizarEstadoChequeAtual
3725:                 *-- e guardados no BO; aqui apenas se espelham na tela
3726:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.Value = ;
3727:                     loc_oBO.this_cUltimoFollowup
3728:                 IF !EMPTY(loc_oBO.this_cCaptionAtual)
3729:                     THIS.Caption = loc_oBO.this_cCaptionAtual
3730:                     THIS.AtualizarTituloCabecalho()
3731:                 ENDIF
3732: 
3733:                 loc_oOrig.txt_4c__Conta.Refresh
3734:                 loc_oOrig.txt_4c__DConta.Refresh
3735:                 loc_oOrig.txt_4c__Cpf.Refresh
3736:                 loc_oEmi.txt_4c__Conta.Refresh
3737:                 loc_oEmi.txt_4c__DConta.Refresh
3738:                 loc_oEmi.txt_4c__Cpf.Refresh
3739:                 loc_oPer.txt_4c_Dt_inicial.Refresh
3740:                 loc_oPer.txt_4c_Dt_final.Refresh
3741: 
3742:                 *-- A dependencia entre os campos (When do legado) depende dos
3743:                 *-- valores que acabaram de ser escritos
3744:                 THIS.HabilitarCampos(.T.)
3745:             ENDIF
3746:         CATCH TO loc_oErro
3747:             MsgErro(loc_oErro.Message + CHR(13) + ;
3748:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3749:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.BOParaForm")
3750:         ENDTRY
3751:     ENDPROC
3752: 
3753:     *--------------------------------------------------------------------------
3754:     * CarregarLista - FUNIL UNICO de carga do Historico: transfere a tela para
3755:     * o BO, executa a consulta (CarregarDados = SqlDados legado) e repinta as
3756:     * tres grades.
3757:     *
3758:     * PUBLIC de proposito: TesteAutomatico.prg chama THIS.oForm.CarregarLista()
3759:     * de FORA da classe, e PEMSTATUS(oForm, "CarregarLista", 5) devolve .T.
3760:     * mesmo para metodo PROTECTED (so verifica existencia, nao escopo) - o
3761:     * teste entraria no branch e a chamada estouraria em runtime.
3762:     *
3763:     * Popular cursor NAO repinta a grade, e Refresh em pagina oculta nao
3764:     * pinta: por isso o Repintar vem no FIM e AlternarPagina chama este metodo
3765:     * DEPOIS de trocar o ActivePage.
3766:     *--------------------------------------------------------------------------
3767:     PROCEDURE CarregarLista()
3768:         LOCAL loc_lSucesso
3769:         loc_lSucesso = .F.
3770: 
3771:         IF THIS.FormParaBO()
3772:             loc_lSucesso = THIS.CarregarDados()
3773:             THIS.RepintarGradesHistorico()
3774:         ENDIF
3775: 
3776:         RETURN loc_lSucesso
3777:     ENDPROC
3778: 
3779:     *--------------------------------------------------------------------------
3780:     * HabilitarCampos - Estado de entrada dos campos de filtro. Transcreve os
3781:     * cinco PROCEDURE When do legado, que implementam EXCLUSAO MUTUA entre os
3782:     * campos de conta:
3783:     *
3784:     *   Origem.get_Cpf.When    -> Empty(Get_Conta.Value)
3785:     *   Origem.get_DConta.When -> Empty(Get_Conta.Value) And Empty(Get_Cpf.Value)
3786:     *   Origem.optFiltro.When  -> Empty(Get_Conta) And Empty(Get_Cpf) And Empty(get_DConta)
3787:     *   Emitente.get_Cpf.When    -> Empty(Get_Conta.Value)
3788:     *   Emitente.get_DConta.When -> Empty(Get_Conta) And Empty(Get_Cpf)
3789:     *
3790:     * Preenchido o campo de conta, os seguintes param de aceitar digitacao -
3791:     * o legado limpa os irmaos no Valid do campo resolvido (PreencherOrigem/
3792:     * PreencherEmitente fazem o mesmo), e eh por ali que se recomeca.
3793:     *
3794:     * Mecanismo: TextBox recebe ReadOnly + TabStop (e NAO Enabled), que eh o
3795:     * equivalente de runtime mais fiel ao When - bloqueia foco e digitacao
3796:     * SEM acinzentar o controle (PILAR 1). OptionGroup nao tem ReadOnly, so
3797:     * Enabled; o acinzentamento dele eh divergencia inevitavel do legado.
3798:     * BINDEVENT em "When" nao serve: o BINDEVENT DESCARTA o retorno do
3799:     * delegate, entao um When ligado por ali nao bloquearia nada.
3800:     *
3801:     * par_lHabilitar = .F. forca TODOS os campos somente-leitura, ignorando a
3802:     * cascata. Parametro OMITIDO vale .T. - a distincao usa PCOUNT(), porque
3803:     * em VFP9 parametro nao passado chega como .F. logico e VARTYPE nao
3804:     * distingue um do outro.
3805:     *--------------------------------------------------------------------------
3806:     PROCEDURE HabilitarCampos(par_lHabilitar)
3807:         LOCAL loc_lHab, loc_oOrig, loc_oEmi, loc_oPer, loc_oErro
3808:         LOCAL loc_lContaOrig, loc_lCpfOrig, loc_lNomeOrig
3809:         LOCAL loc_lContaEmi, loc_lCpfEmi, loc_lNomeEmi
3810:         loc_lHab = IIF(PCOUNT() = 0, .T., par_lHabilitar)
3811: 
3812:         TRY
3813:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3814:                 loc_oOrig = THIS.pgf_4c_Paginas.Page1.cnt_4c_Origem
3815:                 loc_oEmi  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Emitente
3816:                 loc_oPer  = THIS.pgf_4c_Paginas.Page2.cnt_4c__periodo
3817: 
3818:                 *-- Cascata do When (Origem): a conta eh sempre digitavel; o
3819:                 *-- CPF so com a conta vazia; o nome so com conta E CPF vazios;
3820:                 *-- o optFiltro so com os TRES vazios
3821:                 loc_lContaOrig = loc_lHab
3822:                 loc_lCpfOrig   = loc_lHab AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Conta.Value))
3823:                 loc_lNomeOrig  = loc_lCpfOrig AND EMPTY(ALLTRIM(loc_oOrig.txt_4c__Cpf.Value))
3824: 
3825:                 loc_oOrig.txt_4c__Conta.ReadOnly   = !loc_lContaOrig
3826:                 loc_oOrig.txt_4c__Conta.TabStop    = loc_lContaOrig
3827:                 loc_oOrig.txt_4c__Cpf.ReadOnly     = !loc_lCpfOrig
3828:                 loc_oOrig.txt_4c__Cpf.TabStop      = loc_lCpfOrig
3829:                 loc_oOrig.txt_4c__DConta.ReadOnly  = !loc_lNomeOrig
3830:                 loc_oOrig.txt_4c__DConta.TabStop   = loc_lNomeOrig
3831:                 loc_oOrig.obj_4c_OptFiltro.Enabled = loc_lNomeOrig AND ;
3832:                     EMPTY(ALLTRIM(loc_oOrig.txt_4c__DConta.Value))
3833: 
3834:                 *-- Cascata do When (Emitente): identica, sem optFiltro - o
3835:                 *-- dump nao declara OptionGroup neste container
3836:                 loc_lContaEmi = loc_lHab
3837:                 loc_lCpfEmi   = loc_lHab AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Conta.Value))
3838:                 loc_lNomeEmi  = loc_lCpfEmi AND EMPTY(ALLTRIM(loc_oEmi.txt_4c__Cpf.Value))
3839: 
3840:                 loc_oEmi.txt_4c__Conta.ReadOnly  = !loc_lContaEmi
3841:                 loc_oEmi.txt_4c__Conta.TabStop   = loc_lContaEmi
3842:                 loc_oEmi.txt_4c__Cpf.ReadOnly    = !loc_lCpfEmi
3843:                 loc_oEmi.txt_4c__Cpf.TabStop     = loc_lCpfEmi
3844:                 loc_oEmi.txt_4c__DConta.ReadOnly = !loc_lNomeEmi
3845:                 loc_oEmi.txt_4c__DConta.TabStop  = loc_lNomeEmi
3846: 
3847:                 *-- As duas datas do periodo nao tem When no legado: seguem
3848:                 *-- apenas o par_lHabilitar
3849:                 loc_oPer.txt_4c_Dt_inicial.ReadOnly = !loc_lHab
3850:                 loc_oPer.txt_4c_Dt_inicial.TabStop  = loc_lHab
3851:                 loc_oPer.txt_4c_Dt_final.ReadOnly   = !loc_lHab
3852:                 loc_oPer.txt_4c_Dt_final.TabStop    = loc_lHab
3853: 
3854:                 *-- UltFollowup eh somente-exibicao no legado
3855:                 *-- (Cnt_Followup.UltFollowup.When -> Return .f.)
3856:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.ReadOnly = .T.
3857:                 THIS.pgf_4c_Paginas.Page2.cnt_4c__Followup.txt_4c_UltFollowup.TabStop  = .F.
3858:             ENDIF
3859:         CATCH TO loc_oErro
3860:             MsgErro(loc_oErro.Message + CHR(13) + ;
3861:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3862:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.HabilitarCampos")
3863:         ENDTRY
3864:     ENDPROC
3865: 
3866:     *--------------------------------------------------------------------------
3867:     * AplicarDependenciaCampos - Alvo parametro-zero dos BINDEVENT de
3868:     * InteractiveChange dos seis campos de conta. NAO se liga HabilitarCampos
3869:     * direto ao evento: InteractiveChange nao passa argumento e, em VFP9,
3870:     * parametro nao passado chega como .F. logico - par_lHabilitar viria .F. e
3871:     * a tela inteira ficaria somente-leitura ao primeiro caractere digitado.
3872:     *--------------------------------------------------------------------------
3873:     PROCEDURE AplicarDependenciaCampos()
3874:         THIS.HabilitarCampos(.T.)
3875:     ENDPROC
3876: 
3877:     *--------------------------------------------------------------------------
3878:     * LimparCampos - Zera os dois containers de conta e restaura o periodo de
3879:     * vencimento default, voltando o BO e a tela ao estado de abertura.
3880:     *
3881:     * Transcreve o Sair.Click legado do Historico, que no acesso restrito
3882:     * limpa os TRES campos de Origem e restaura o Caption:
3883:     *   .Filtro.Origem.Get_conta.Value  = ''
3884:     *   .Filtro.Origem.Get_Dconta.Value = ''
3885:     *   .Filtro.Origem.Get_Cpf.Value    = ''
3886:     *   ThisForm.Caption = 'Historico de Cheques'
3887:     * mais o periodo default do Init legado (Date() ate 31/12 do ano corrente;
3888:     * no acesso CARTEIRA, o vencimento do cheque recebido).
3889:     *
3890:     * PROTECTED porque FormBase declara este hook PROTECTED.
3891:     *--------------------------------------------------------------------------
3892:     PROTECTED PROCEDURE LimparCampos()
3893:         LOCAL loc_oBO, loc_oErro
3894: 
3895:         TRY
3896:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3897:                 loc_oBO = THIS.this_oBusinessObject
3898: 
3899:                 loc_oBO.this_cContaOrigem      = ""
3900:                 loc_oBO.this_cDContaOrigem     = ""
3901:                 loc_oBO.this_cCpfOrigem        = ""
3902:                 loc_oBO.this_nTipoFiltroOrigem = 1
3903:                 loc_oBO.this_cContaEmitente    = ""
3904:                 loc_oBO.this_cDContaEmitente   = ""
3905:                 loc_oBO.this_cCpfEmitente      = ""
3906:                 loc_oBO.this_cUltimoFollowup   = ""
3907:                 loc_oBO.this_cCaptionAtual     = "Hist" + CHR(243) + "rico de Cheques"
3908: 
3909:                 *-- Periodo default - mesma regra do Init legado
3910:                 IF ALLTRIM(UPPER(loc_oBO.this_cAcesso)) == "CARTEIRA" AND ;
3911:                         !EMPTY(THIS.this_dParamVencs)
3912:                     loc_oBO.this_dDataInicial = THIS.this_dParamVencs
3913:                     loc_oBO.this_dDataFinal   = THIS.this_dParamVencs
3914:                 ELSE
3915:                     loc_oBO.this_dDataInicial = DATE()
3916:                     loc_oBO.this_dDataFinal   = ;
3917:                         CTOD("31/12/" + ALLTRIM(STR(YEAR(DATE()))))
3918:                 ENDIF
3919: 
3920:                 THIS.this_lFiltrado    = .F.
3921:                 loc_oBO.this_lFiltrado = .F.
3922: 
3923:                 *-- BOParaForm espelha tudo na tela (e reaplica a cascata do
3924:                 *-- When ao fim), inclusive o Caption restaurado
3925:                 THIS.BOParaForm()
3926:             ENDIF
3927:         CATCH TO loc_oErro
3928:             MsgErro(loc_oErro.Message + CHR(13) + ;
3929:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3930:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.LimparCampos")
3931:         ENDTRY
3932:     ENDPROC
3933: 
3934:     *--------------------------------------------------------------------------
3935:     * AjustarBotoesPorModo - FUNIL do estado dos botoes e dos campos conforme
3936:     * a pagina ativa, que eh o "modo" deste form:
3937:     *
3938:     *   Page1 (Filtro)    -> this_cModoAtual = "LISTA"
3939:     *                        Processar/Encerrar habilitados, campos editaveis
3940:     *   Page2 (Historico) -> this_cModoAtual = "VISUALIZAR"
3941:     *                        barra Grupo_op habilitada conforme o legado
3942:     *                        (Procurar = !Filtrado, Protocolo = fChecaAcesso)
3943:     *
3944:     * Chamado por AlternarPagina nos DOIS sentidos - desabilitar no caminho de
3945:     * ida sem reabilitar no de volta deixaria a tela inutilizavel.
3946:     *
3947:     * PUBLIC: TesteAutomatico.prg chama este metodo de fora da classe.
3948:     *--------------------------------------------------------------------------
3949:     PROCEDURE AjustarBotoesPorModo()
3950:         LOCAL loc_nPagina, loc_oPg1, loc_oErro
3951: 
3952:         TRY
3953:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3954:                 loc_nPagina = THIS.pgf_4c_Paginas.ActivePage
3955:                 loc_oPg1    = THIS.pgf_4c_Paginas.Page1
3956: 
3957:                 IF loc_nPagina = 2
3958:                     THIS.this_cModoAtual = "VISUALIZAR"
3959:                     THIS.AjustarBotoesHistorico()
3960:                 ELSE
3961:                     THIS.this_cModoAtual = "LISTA"
3962:                     loc_oPg1.cmd_4c_Ok.Enabled       = .T.
3963:                     loc_oPg1.cmd_4c_Cancelar.Enabled = .T.
3964:                 ENDIF
3965: 
3966:                 *-- Reaplica a cascata do When - os campos seguem editaveis nos
3967:                 *-- dois modos (o Historico tem o filtro de Emitente e o
3968:                 *-- periodo), o que troca eh a pagina ativa
3969:                 THIS.HabilitarCampos(.T.)
3970:             ENDIF
3971:         CATCH TO loc_oErro
3972:             MsgErro(loc_oErro.Message + CHR(13) + ;
3973:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3974:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.AjustarBotoesPorModo")
3975:         ENDTRY
3976:     ENDPROC
3977: 
3978:     *--------------------------------------------------------------------------
3979:     * BtnProcessarClick - Nome canonico da ACAO desta tela. O verbo vem do
3980:     * proprio legado: o botao da pagina de Filtro se chama "Ok" no SCX mas tem
3981:     * Caption "\<Processar", e o Click dele eh o que dispara a consulta e leva
3982:     * o usuario ao Historico.
3983:     *
3984:     * Esta tela eh um VISUALIZADOR - o legado SIGOPCHI nao tem botao de gravar
3985:     * (varredura do dump: zero ocorrencia de btnSalvar/btnGravar/mGravaDados) e
3986:     * nao persiste nada em SigChe; quem grava sao os formularios de detalhe que
3987:     * os botoes de Grupo_op abrem. Por isso a acao eh "Processar" (consultar) e
3988:     * NAO existe BtnSalvarClick - inventar um violaria o PILAR 1.
3989:     *
3990:     * Funil PUBLIC: o corpo mora em CmdOkClick (alvo do BINDEVENT do botao).
3991:     *--------------------------------------------------------------------------
3992:     PROCEDURE BtnProcessarClick()
3993:         THIS.CmdOkClick()
3994:     ENDPROC
3995: 
3996:     *--------------------------------------------------------------------------
3997:     * BtnBuscarClick - Nome canonico para a acao de BUSCA desta tela, que eh o
3998:     * botao "Busca" ([F5]) de Grupo_op (Buttons(2) -> Procurar.Click legado,
3999:     * que abre SigOpChb). Funil PUBLIC: nao duplica logica, delega ao handler
4000:     * ja transcrito do legado.
4001:     *--------------------------------------------------------------------------
4002:     PROCEDURE BtnBuscarClick()
4003:         THIS.AcaoProcurarClick()
4004:     ENDPROC
4005: 
4006:     *--------------------------------------------------------------------------
4007:     * BtnEncerrarClick - Nome canonico para o Encerrar. Este form tem DOIS
4008:     * botoes de saida, um por pagina, com comportamentos DIFERENTES no legado:
4009:     *   Page1 (cancelar.Click) -> ThisForm.Release
4010:     *   Page2 (Sair.Click)     -> sem acesso irrestrito volta ao Filtro
4011:     *                             limpando a Origem; com acesso, Release
4012:     * Por isso o funil eh sensivel a pagina ativa, em vez de escolher um dos
4013:     * dois arbitrariamente.
4014:     *--------------------------------------------------------------------------
4015:     PROCEDURE BtnEncerrarClick()
4016:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5) AND THIS.pgf_4c_Paginas.ActivePage = 2
4017:             THIS.CmgSaidaClick()
4018:         ELSE
4019:             THIS.BtnCancelarClick()
4020:         ENDIF
4021:     ENDPROC
4022: 
4023:     *--------------------------------------------------------------------------
4024:     * BtnCancelarClick - Nome canonico do Encerrar da pagina de Filtro
4025:     * (cancelar.Click legado: ThisForm.Release, sem pedir confirmacao - eh um
4026:     * visualizador, nao ha alteracao em aberto para desfazer).
4027:     * CmdCancelarClick (alvo do BINDEVENT do botao) delega para ca, para que
4028:     * exista UM so corpo.
4029:     *--------------------------------------------------------------------------
4030:     PROCEDURE BtnCancelarClick()
4031:         THIS.Release()
4032:     ENDPROC
4033: 
4034:     *--------------------------------------------------------------------------
4035:     * TornarControlesVisiveis - Torna visiveis recursivamente os controles
4036:     * criados via AddObject (percorre tambem as Pages de um PageFrame)
4037:     *--------------------------------------------------------------------------
4038:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4039:         LOCAL loc_nI, loc_nP, loc_oControl, loc_oErro
4040:         TRY
4041:             FOR loc_nI = 1 TO par_oContainer.ControlCount
4042:                 loc_oControl = par_oContainer.Controls(loc_nI)
4043:                 IF VARTYPE(loc_oControl) = "O"
4044:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
4045:                         loc_oControl.Visible = .T.
4046:                     ENDIF
4047:                     IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
4048:                         FOR loc_nP = 1 TO loc_oControl.PageCount
4049:                             THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
4050:                         ENDFOR
4051:                     ENDIF
4052:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
4053:                         THIS.TornarControlesVisiveis(loc_oControl)
4054:                     ENDIF
4055:                 ENDIF
4056:             ENDFOR
4057:         CATCH TO loc_oErro
4058:             MsgErro(loc_oErro.Message + CHR(13) + ;
4059:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4060:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.TornarControlesVisiveis")
4061:         ENDTRY
4062:     ENDPROC
4063: 
4064:     *--------------------------------------------------------------------------
4065:     * Destroy - Fecha os cursores que o form criou e so depois delega.
4066:     *
4067:     * DODEFAULT() eh a ULTIMA linha: FormBase.Destroy libera o BO e refaz os
4068:     * popups de _MSYSMENU (sem isso o menu principal fica visualmente
4069:     * encolhido depois de qualquer form modal).
4070:     *
4071:     * As tres grades ficam desvinculadas antes, porque fechar o alias que esta
4072:     * em RecordSource com a grade ainda ligada deixa o Grid apontando para
4073:     * alias morto.
4074:     *--------------------------------------------------------------------------
4075:     PROCEDURE Destroy()
4076:         LOCAL loc_oErro
4077: 
4078:         TRY
4079:             *-- O PageFrame pode nao existir se o Init falhou antes de cria-lo:
4080:             *-- nesse caso ja houve mensagem de erro, e desvincular grade
4081:             *-- inexistente so somaria um segundo dialogo
4082:             IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
4083:                 THIS.DesvincularGradesHistorico()
4084:             ENDIF
4085: 
4086:             THIS.FecharCursor("cursor_4c_Cheque")
4087:             THIS.FecharCursor("cursor_4c_ChequeP")
4088:             THIS.FecharCursor("cursor_4c_Movimento")
4089:             THIS.FecharCursor("cursor_4c_Prorrog")
4090:             THIS.FecharCursor("cursor_4c_Protocolo")
4091:             THIS.FecharCursor("cursor_4c_Temp")
4092:         CATCH TO loc_oErro
4093:             MsgErro(loc_oErro.Message + CHR(13) + ;
4094:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4095:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpChi.Destroy")
4096:         ENDTRY
4097: 
4098:         DODEFAULT()
4099:     ENDPROC
4100: 
4101: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpChiBO.prg):
*============================================================================
* SigOpChiBO.prg - Business Object para Historico de Cheques
*
* Tabela principal : SigChe    (PK: Nums char(8) - numero sequencial do cheque)
* Tabela detalhe    : SigCqChm (FK: Nums - movimentos/followup do cheque)
* Lookup conta      : SigCdCli (PK: Iclis, desc: Rclis, doc: Cpfs)
*
* Form OPERACIONAL (consulta/historico) - sem Inserir/Atualizar/Excluir.
* Filtra cheques por conta (Origem) ou por conta do Emitente, dentro de um
* periodo de vencimento, e exibe tres grades: Cheque, Movimentacao e
* Prorrogacoes, alem do ultimo Followup registrado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpChiBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigChe (todas as colunas - cheque selecionado
    * na GradeCheque da pagina Historico). Nums eh char(8) NO BANCO - NUNCA
    * numerico (conferido em docs/schema.sql: CONSTRAINT sigche_nums PK em
    * [nums] char(8)).
    *==========================================================================
    this_cNums      = ""    && char(8)  - PK do cheque selecionado na grade
    this_cEmps      = ""    && char(3)  - Empresa do cheque selecionado
    this_cBancos    = ""    && char(3)
    this_cAgencias  = ""    && char(4)
    this_lAutos     = .F.   && bit
    this_cConCarts  = ""    && char(10) - Conta Carteira
    this_cConOrigs  = ""    && char(10) - Conta Origem
    this_cConRes    = ""    && char(10)
    this_cContas    = ""    && char(10)
    this_cCopchs    = ""    && char(15)
    this_dDatas     = {}    && datetime
    this_dDataTrans = {}    && datetime
    this_cFpags     = ""    && char(12)
    this_cGrClis    = ""    && char(10) - Grupo do cliente
    this_cGruCarts  = ""    && char(10) - Grupo Carteira
    this_cGruOrigs  = ""    && char(10) - Grupo Origem
    this_cGrupos    = ""    && char(10)
    this_cGrures    = ""    && char(10)
    this_cGrvends   = ""    && char(10)
    this_cIClis     = ""    && char(10) - Codigo do cliente/conta
    this_cLeituras  = ""    && char(34)
    this_cLocals    = ""    && char(10)
    this_nNalineas  = 0     && numeric(3,0)
    this_cNCheques  = ""    && char(6)
    this_cNContas   = ""    && char(10)
    this_cNotas     = ""    && char(6)
    this_nNtrans    = 0     && numeric(6,0)
    this_cNumeros   = ""    && char(6)
    this_cNumolds   = ""    && char(8)
    this_nNumos     = 0     && numeric(8,0)
    this_cProtocolos = ""   && char(8)
    this_cUMovs     = ""    && char(15) - Ultimo Movimento
    this_nValors    = 0     && numeric(11,2)
    this_nValpags   = 0     && numeric(11,2)
    this_dVencs     = {}    && datetime
    this_cVends     = ""    && char(10)
    this_dDtEmis    = {}    && datetime
    this_dDtAlts    = {}    && datetime
    this_cContat    = ""    && char(10)
    this_cGrupot    = ""    && char(10)
    this_nCotas     = 0     && numeric(11,4)
    this_cMoeds     = ""    && char(3)
    this_nTipoBlq   = 0     && numeric(1,0)
    this_cCustodia  = ""    && char(4)

    *==========================================================================
    * Filtro por Conta de Origem (Pagina.Filtro.Origem)
    *==========================================================================
    this_cContaOrigem     = ""    && Iclis digitado/selecionado
    this_cDContaOrigem    = ""    && Rclis (descricao/nome da conta)
    this_cCpfOrigem       = ""    && Cpfs (CPF/CNPJ da conta)
    this_nTipoFiltroOrigem = 1    && optFiltro.Value: 1=Conta exata, 2=Com Filtro (LIKE)

    *==========================================================================
    * Filtro por Conta do Emitente (Pagina.Historico.Emitente)
    *==========================================================================
    this_cContaEmitente   = ""    && Iclis do emitente
    this_cDContaEmitente  = ""    && Rclis do emitente
    this_cCpfEmitente     = ""    && Cpfs do emitente

    *==========================================================================
    * Filtro por Periodo de Vencimento (Cnt_periodo)
    *==========================================================================
    this_dDataInicial = {}    && Dt_inicial.Value
    this_dDataFinal   = {}    && Dt_final.Value

    *==========================================================================
    * Estado de acesso e navegacao
    *==========================================================================
    this_cAcesso      = "TOTAL"    && Parametro pcAcesso recebido na abertura
    this_lAcesso      = .T.        && INLIST(this_cAcesso,'TOTAL','CARTEIRA')
    this_lFiltrado    = .F.        && .T. quando a Lista foi filtrada por uma conta
    this_cCaptionAtual = ""        && Caption dinamico ("Historico de Cheques de: ...")
    this_cUltimoFollowup = ""      && Texto do ultimo followup do cheque selecionado

    *==========================================================================
    * Alias dos cursores usados pelas grades e pelos lookups
    *==========================================================================
    this_cCursorCheque      = "cursor_4c_Cheque"       && GradeCheque      (SigChe)
    this_cCursorMovimento   = "cursor_4c_Movimento"    && GradeMovimenta   (SigCqChm)
    this_cCursorProrrog     = "cursor_4c_Prorrog"      && GradeProrrog     (prorrogacoes)
    this_cCursorChequeMov   = "cursor_4c_ChequeMov"    && Detalhe do cheque selecionado
    this_cCursorCliente     = "cursor_4c_Cliente"      && Lookup SigCdCli (conta/emitente)
    this_cCursorProtocolo   = "cursor_4c_Protocolo"    && TempChq (impressao de protocolo)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "Nums"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do cheque selecionado
    * na GradeCheque, usada por RegistrarAuditoria (via BusinessBase) caso
    * algum passo futuro do historico precise identificar o registro.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigChe para as
    * propriedades do BO. Alimentado pelo cursor que fica posicionado no
    * cheque corrente da GradeCheque (Pagina.Historico) apos o usuario
    * selecionar uma linha - equivalente ao acesso direto a crSigChe.<col>
    * que o legado faz em Grupo_op.Click (Relatorio/Documento/Prorroga/
    * FollowUp/Protocolo/Carteira) e em GradeCheque.AfterRowColChange.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cNums       = TratarNulo(Nums, "C")
            THIS.this_cEmps       = TratarNulo(Emps, "C")
            THIS.this_cBancos     = TratarNulo(Bancos, "C")
            THIS.this_cAgencias   = TratarNulo(Agencias, "C")
            THIS.this_lAutos      = ConverterParaLogico(Autos)
            THIS.this_cConCarts   = TratarNulo(ConCarts, "C")
            THIS.this_cConOrigs   = TratarNulo(ConOrigs, "C")
            THIS.this_cConRes     = TratarNulo(ConRes, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cCopchs     = TratarNulo(Copchs, "C")
            THIS.this_dDatas      = ConverterParaData(Datas)
            THIS.this_dDataTrans  = ConverterParaData(DataTrans)
            THIS.this_cFpags      = TratarNulo(Fpags, "C")
            THIS.this_cGrClis     = TratarNulo(GrClis, "C")
            THIS.this_cGruCarts   = TratarNulo(GruCarts, "C")
            THIS.this_cGruOrigs   = TratarNulo(GruOrigs, "C")
            THIS.this_cGrupos     = TratarNulo(Grupos, "C")
            THIS.this_cGrures     = TratarNulo(Grures, "C")
            THIS.this_cGrvends    = TratarNulo(Grvends, "C")
            THIS.this_cIClis      = TratarNulo(Iclis, "C")
            THIS.this_cLeituras   = TratarNulo(Leituras, "C")
            THIS.this_cLocals     = TratarNulo(Locals, "C")
            THIS.this_nNalineas   = NVL(Nalineas, 0)
            THIS.this_cNCheques   = TratarNulo(NCheques, "C")
            THIS.this_cNContas    = TratarNulo(NContas, "C")
            THIS.this_cNotas      = TratarNulo(Notas, "C")
            THIS.this_nNtrans     = NVL(Ntrans, 0)
            THIS.this_cNumeros    = TratarNulo(Numeros, "C")
            THIS.this_cNumolds    = TratarNulo(Numolds, "C")
            THIS.this_nNumos      = NVL(Numos, 0)
            THIS.this_cProtocolos = TratarNulo(Protocolos, "C")
            THIS.this_cUMovs      = TratarNulo(UMovs, "C")
            THIS.this_nValors     = NVL(Valors, 0)
            THIS.this_nValpags    = NVL(Valpags, 0)
            THIS.this_dVencs      = ConverterParaData(Vencs)
            THIS.this_cVends      = TratarNulo(Vends, "C")
            THIS.this_dDtEmis     = ConverterParaData(DtEmis)
            THIS.this_dDtAlts     = ConverterParaData(DtAlts)
            THIS.this_cContat     = TratarNulo(Contat, "C")
            THIS.this_cGrupot     = TratarNulo(Grupot, "C")
            THIS.this_nCotas      = NVL(Cotas, 0)
            THIS.this_cMoeds      = TratarNulo(Moeds, "C")
            THIS.this_nTipoBlq    = NVL(TipoBlq, 0)
            THIS.this_cCustodia   = TratarNulo(Custodia, "C")

            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *==========================================================================
    * SigOpChi (Historico de Cheques) eh um form de CONSULTA: o legado
    * (SIGOPCHI) nao faz Insert/Update/Delete em SigChe por esta tela - o
    * usuario apenas filtra por conta/periodo e navega para os formularios
    * de detalhe (SigOpChr, SigOpChb, SigOpChp, SigOpFlp, SigOpChc), que sao
    * os responsaveis por qualquer gravacao. Por isso o comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao)
    * ja eh o correto para este BO.
    *==========================================================================

ENDDEFINE

