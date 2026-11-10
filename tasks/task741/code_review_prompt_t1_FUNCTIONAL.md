# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (15)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterDescricaoPorCodigo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ListaLocalDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.TeclaAbreLookup()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterCampoLookup()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MostrarPickerListaLocal()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EmModoEdicao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterDescricaoOrigem()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarGradeValores()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AtualizarConfigFinanceiraOperacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_GrdValores' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-HEADER] Header Caption 'Origem dos Valores a Serem Lan' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Origem dos Valores a Serem Lançados na Movimentação Financeira. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Origem dos Valores a Serem Lan' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Origem dos Valores a Serem Lançados na Movimentação Financeira. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3700 linhas total):

*-- Linhas 22 a 115:
22: * fix SET DATE/CENTURY da regra CLAUDE.md #9.4).
23: *
24: * Montagem (migracao multi-fase):
25: *   Fase 3          - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
26: *                     cnt_4c_Sombra, TornarControlesVisiveis.
27: *   Fase 4          - cursor_4c_GrdValores (equivalente a crGrdValores do
28: *                     Load legado), grd_4c_Dados (grid de 1 coluna ligado
29: *                     a ele), cmd_4c_BtnSetaUp/cmd_4c_BtnSetaDn/
30: *                     cmd_4c_BtnExcluiGrd e a carga da grade:
31: *                     CarregarDados() (trecho do Init legado) +
32: *                     MontaGrade() (montagrades legado) +
33: *                     AjustarBotoesGrade().
34: *   Fase 5 parte 1  - campos de Grupo/Conta Debito/Credito das linhas
35: *                     Emissor e Portador (8 TextBox) + cabecalhos de
36: *                     coluna Debito/Credito/Grupo/Conta (uma unica vez,
37: *                     acima das 4 linhas).
38: *   Fase 6 (esta)   - parte 2 dos campos de detalhe, complementar a Fase 5
39: *                     (linhas Centro de Custo/Agente Cobrador - 8 TextBox -
40: *                     e txt_4c_CMoes/TitBans/Tipos/MovTits), mais
41: *                     obj_4c_GetNotas/obj_4c_GetComandos (EditBox memo) e
42: *                     chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS - com isto o
43: *                     conjunto completo de campos do dump (layout.json)
44: *                     esta no form - E os
45: *                     LOOKUPS dos 19 campos que tem Valid de busca no dump
46: *                     (8 Grupo + 8 Conta + CMoes + TitBans + MovTits),
47: *                     ligados por BINDEVENT em ConfigurarEventosLookup(),
48: *                     mais o lookup da CELULA da grade (coluna Origem dos
49: *                     Valores), que mora na classe
50: *                     TextBoxOrigemSigOpFin_4c instalada pelo
51: *                     InstalarCelulaOrigem().
52: *   Fase 7 (esta)   - eventos dos botoes de manutencao da grade
53: *                     (BtnSetaUpClick/BtnSetaDnClick/BtnExcluiGrdClick,
54: *                     ligados por BINDEVENT em
55: *                     ConfigurarEventosBotoesGrade()), AfterRowColChange()
56: *                     da grade (refresh dos campos de detalhe + ToolTipText
57: *                     de Grupo/Conta/TitBans/CMoes via
58: *                     ObterDescricaoPorCodigo(), tambem chamado ao final de
59: *                     MontaGrade()), AvancarLinhaGradeOrigem() (parte de
60: *                     navegacao do LostFocus da celula da grade) e o
61: *                     dirty-tracking GotFocus/LostFocus (This.Tag <->
62: *                     This.Value, ConfigurarEventosDirtyTracking()) que o
63: *                     legado usa para marcar plAlterou (aqui
64: *                     this_lAlterou), consumido no Click de Sair da Fase 8.
65: *   Fase 8 (esta)   - cmd_4c_Sair (equivalente ao botao Sair/OK do legado,
66: *                     dump linhas 465-475: Picture=cadastro_salvar_60.jpg,
67: *                     Cancel=.T., Caption="\<OK" - fecha-o grava, por isso o
68: *                     icone eh de salvar e nao de saida) e o Click dele
69: *                     (BtnSairClick), que reproduz literalmente o
70: *                     SIGOPFIN.Sair.Click do legado (dump linhas 1606-1732):
71: *                     ValidarGradeValores() (validacao linha a linha da
72: *                     grade, so quando EmModoEdicao() e this_lAlterou -
73: *                     equivalente ao "Select ... Into Cursor LocalSair" +
74: *                     "Scan While Empty(lcMsg)"), GravarDados() (equivalente
75: *                     ao PROCEDURE gravardados do legado: em ALTERAR, DELETE
76: *                     de todas as linhas antigas de sigopfin por este Dopes
77: *                     e reinsercao completa via sigopfinBO.Inserir() por
78: *                     linha, renumerando Ordem) e
79: *                     AtualizarConfigFinanceiraOperacao() (equivalente ao
80: *                     "Replace CfgFinancs ... In crSigCdOpe" do fim do
81: *                     gravardados legado - grava os 2 CheckBox nos 2
82: *                     primeiros caracteres da coluna SigCdOpe.cfgfinancs
83: *                     char(20), preservando os 18 restantes). Consolidacao
84: *                     final do form.
85: *
86: * Nomes de objeto conforme tasks/task741/mapeamento.json.
87: *==============================================================================
88: 
89: DEFINE CLASS Formsigopfin AS FormBase
90: 
91:     *--------------------------------------------------------------------------
92:     * Propriedades do form (SIGOPFIN.SCX: DataSession=1, BorderStyle=2,
93:     * Height=600, Width=1000, ShowTips=.T., AutoCenter=.T., ControlBox=.F.,
94:     * MaxButton=.F., Movable=.F., ClipControls=.F., TitleBar=0, WindowType=1 -
95:     * dump de sigopfin_form_codigo_fonte.txt, linhas 338-358). Closable e
96:     * MinButton NAO constam do dump - nao inventar (feedback
97:     * Closable_inventado_tira_a_unica_saida).
98:     *--------------------------------------------------------------------------
99:     Width        = 1000
100:     Height       = 600
101:     AutoCenter   = .T.
102:     ShowTips     = .T.
103:     TitleBar     = 0
104:     ShowWindow   = 1
105:     WindowType   = 1
106:     ControlBox   = .F.
107:     Movable      = .F.
108:     MaxButton    = .F.
109:     ClipControls = .F.
110:     BorderStyle  = 2
111:     FontName     = "Tahoma"
112:     FontSize     = 8
113: 
114:     Caption = "Configura" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + "amentos Financeiros"
115: 

*-- Linhas 148 a 400:
148:     *--------------------------------------------------------------------------
149:     * Init - recebe o codigo da movimentacao e o form chamador (equivalente
150:     * a "Parameters pMov, pFrm" do legado) e cria o Business Object ANTES do
151:     * DODEFAULT(), para que InicializarForm() (chamado por FormBase.Init()
152:     * via DODEFAULT) ja o encontre pronto. O Caption e ajustado ANTES do
153:     * DODEFAULT() porque ConfigurarCabecalho() (chamado dentro do
154:     * DODEFAULT) usa THIS.Caption para montar o titulo da faixa.
155:     *--------------------------------------------------------------------------
156:     PROCEDURE Init()
157:         LPARAMETERS par_cDopes, par_oFormPai
158:         LOCAL loc_lSucesso, loc_lParametrosOk, loc_oErro
159:         loc_lSucesso = .F.
160:         loc_lParametrosOk = .T.
161: 
162:         TRY
163:             IF PCOUNT() < 1 OR VARTYPE(par_cDopes) != "C" OR EMPTY(par_cDopes)
164:                 MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
165:                     "o informada (par_cDopes).", "Parametros Invalidos")
166:                 loc_lParametrosOk = .F.
167:             ENDIF
168: 
169:             IF loc_lParametrosOk AND (PCOUNT() < 2 OR VARTYPE(par_oFormPai) != "O")
170:                 MsgErro("Formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
171:                     "o informado (par_oFormPai).", "Parametros Invalidos")
172:                 loc_lParametrosOk = .F.
173:             ENDIF
174: 
175:             IF loc_lParametrosOk
176:                 THIS.this_cDopes   = PADR(ALLTRIM(par_cDopes), 20)
177:                 THIS.this_oFormPai = par_oFormPai
178: 
179:                 IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5) AND ;
180:                         !EMPTY(par_oFormPai.this_cModoAtual)
181:                     THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
182:                 ENDIF
183: 
184:                 THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ALLTRIM(par_cDopes)
185: 
186:                 THIS.this_oBusinessObject = CREATEOBJECT("sigopfinBO")
187: 
188:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
189:                     loc_lSucesso = DODEFAULT()
190: 
191:                     IF loc_lSucesso AND VARTYPE(THIS.this_oFormPai) = "O"
192:                         THIS.this_oFormPai.Enabled = .F.
193:                     ENDIF
194:                 ELSE
195:                     MsgErro("Falha ao criar sigopfinBO.", "Erro")
196:                 ENDIF
197:             ENDIF
198:         CATCH TO loc_oErro
199:             MsgErro("Erro ao inicializar Configura" + CHR(231) + CHR(227) + "o de Lan" + ;
200:                 CHR(231) + "amentos Financeiros: " + loc_oErro.Message, "Erro")
201:         ENDTRY
202: 
203:         RETURN loc_lSucesso
204:     ENDPROC
205: 
206:     *--------------------------------------------------------------------------
207:     * Destroy - reabilita o form chamador (equivalente a
208:     * ThisForm.ParentForm.Enabled = .t. do Release legado) e encadeia para
209:     * FormBase.Destroy() (libera this_oBusinessObject e restaura o menu
210:     * principal). this_oFormPai NAO e liberado aqui - pertence a quem criou.
211:     *--------------------------------------------------------------------------
212:     PROCEDURE Destroy()
213:         LOCAL loc_oErro
214: 
215:         TRY
216:             IF VARTYPE(THIS.this_oFormPai) = "O"
217:                 THIS.this_oFormPai.Enabled = .T.
218:             ENDIF
219:         CATCH TO loc_oErro
220:             MsgErro(loc_oErro.Message, "Erro ao encerrar Formsigopfin")
221:         ENDTRY
222: 
223:         DODEFAULT()
224:     ENDPROC
225: 
226:     *--------------------------------------------------------------------------
227:     * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo,
228:     * cabecalho e grade+botoes de reordenacao nesta fase; campos/memos/
229:     * checkboxes nas fases seguintes.
230:     *--------------------------------------------------------------------------
231:     PROTECTED PROCEDURE InicializarForm()
232:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
233:         loc_lSucesso = .F.
234: 
235:         TRY
236:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
237:                 MsgErro("sigopfinBO n" + CHR(227) + "o foi inicializado.", "Erro")
238:             ELSE
239:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
240:                 IF FILE(loc_cPicture)
241:                     THIS.Picture = loc_cPicture
242:                 ENDIF
243: 
244:                 THIS.CriarCursorGrdValores()
245: 
246:                 THIS.ConfigurarPageFrame()
247: 
248:                 THIS.TornarControlesVisiveis(THIS)
249: 
250:                 *-- Carga da grade e visibilidade dos botoes de manutencao
251:                 *-- (equivalente ao fim do Init legado). Vem DEPOIS de
252:                 *-- TornarControlesVisiveis(), que forca Visible = .T. em tudo
253:                 *-- e apagaria o ajuste de AjustarBotoesGrade() se viesse antes.
254:                 THIS.CarregarDados()
255:                 THIS.AjustarBotoesGrade()
256: 
257:                 loc_lSucesso = .T.
258:             ENDIF
259:         CATCH TO loc_oErro
260:             MsgErro(loc_oErro.Message + CHR(13) + ;
261:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
262:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfin.InicializarForm")
263:         ENDTRY
264: 
265:         RETURN loc_lSucesso
266:     ENDPROC
267: 
268:     *--------------------------------------------------------------------------
269:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGOPFIN nao
270:     * tem PageFrame no legado (layout flat: cntSombra + grid + campos +
271:     * memos + checkboxes + botoes direto no form) - o nome do metodo e
272:     * mantido apenas como ponto de entrada arquitetural padrao (mesmo papel
273:     * em FormSigPrIbb/FormSigPrGst/FormSigPrGmi).
274:     *
275:     * Fase 3          - ConfigurarCabecalho() (cnt_4c_Sombra).
276:     * Fase 4          - ConfigurarGrid() (grd_4c_Dados + cmd_4c_BtnSetaUp/
277:     *                   BtnSetaDn/BtnExcluiGrd).
278:     * Fase 5 parte 1  - ConfigurarCamposGrupoContaEmissorPortador() (linhas
279:     *                   Emissor/Portador).
280:     * Fase 6 (esta)   - ConfigurarCamposCentroCustoAgenteCobrador() (parte 2
281:     *                   complementar a Fase 5: linhas Centro de Custo/Agente
282:     *                   Cobrador) + ConfigurarCamposComplementares()
283:     *                   (txt_4c_CMoes/TitBans/Tipos/MovTits) +
284:     *                   ConfigurarMemosEcheckboxes() (obj_4c_GetNotas/
285:     *                   obj_4c_GetComandos e os 2 CheckBox) +
286:     *                   ConfigurarEventosLookup() (BINDEVENT dos 19 campos
287:     *                   com lookup). A celula de lookup da grade e instalada
288:     *                   por InstalarCelulaOrigem(), chamado de
289:     *                   ConfigurarGrid() e de MontaGrade().
290:     * Fase 7          - eventos dos botoes de manutencao da grade,
291:     *                   AfterRowColChange e dirty-tracking (plAlterou).
292:     * Fase 8 (esta)   - ConfigurarSaida() (cmd_4c_Sair); o BINDEVENT do Click
293:     *                   dele entra em ConfigurarEventosBotoesGrade(), junto
294:     *                   com os outros 3 botoes de botao-unico do form.
295:     *--------------------------------------------------------------------------
296:     PROTECTED PROCEDURE ConfigurarPageFrame()
297:         THIS.ConfigurarCabecalho()
298:         THIS.ConfigurarGrid()
299:         THIS.ConfigurarCamposGrupoContaEmissorPortador()
300:         THIS.ConfigurarCamposCentroCustoAgenteCobrador()
301:         THIS.ConfigurarCamposComplementares()
302:         THIS.ConfigurarMemosEcheckboxes()
303:         THIS.ConfigurarSaida()
304:         THIS.ConfigurarEventosLookup()
305:         THIS.ConfigurarEventosBotoesGrade()
306:         THIS.ConfigurarEventosDirtyTracking()
307:     ENDPROC
308: 
309:     *--------------------------------------------------------------------------
310:     * ConfigurarSaida - cmd_4c_Sair, equivalente ao SIGOPFIN.Sair do legado
311:     * (dump linhas 465-475). O icone eh o de SALVAR (cadastro_salvar_60.jpg),
312:     * nao o de sair - fiel ao legado: o Click deste botao grava a grade antes
313:     * de fechar o dialogo (regra CLAUDE.md #25 - FormBAL "Fecha" usa o mesmo
314:     * icone de salvar pelo mesmo motivo). Width/Height=75 (canonico do
315:     * projeto para CommandButton com Picture) nao constam do dump; Left=925
316:     * do dump + Width=75 fecha exatamente nos 1000px do form.
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarSaida()
319:         LOCAL loc_oErro
320: 
321:         TRY
322:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
323:             WITH THIS.cmd_4c_Sair
324:                 .Top             = 3
325:                 .Left            = 925
326:                 .Width           = 75
327:                 .Height          = 75
328:                 .Caption         = "\<OK"
329:                 .Cancel          = .T.
330:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
331:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
332:                 .Themes          = .T.
333:                 .SpecialEffect   = 0
334:                 .MousePointer    = 15
335:                 .WordWrap        = .T.
336:                 .FontName        = "Tahoma"
337:                 .FontSize        = 8
338:                 .FontBold        = .T.
339:                 .FontItalic      = .T.
340:                 .ForeColor       = RGB(90, 90, 90)
341:                 .BackColor       = RGB(255, 255, 255)
342:                 .TabIndex        = 46
343:                 .ToolTipText     = "Retornar Para a Tela Anterior"
344:                 .Visible         = .T.
345:             ENDWITH
346:         CATCH TO loc_oErro
347:             MsgErro(loc_oErro.Message + CHR(13) + ;
348:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
349:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarSaida")
350:         ENDTRY
351:     ENDPROC
352: 
353:     *--------------------------------------------------------------------------
354:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
355:     * Original (dump legado): cntSombra Top=0, Left=0, Width=1100, Height=80,
356:     * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
357:     * projeto) em vez do literal 1100 do dump (que extrapola o Width=1000
358:     * do proprio form).
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarCabecalho()
361:         LOCAL loc_oCnt, loc_oErro
362: 
363:         TRY
364:             THIS.AddObject("cnt_4c_Sombra", "Container")
365:             loc_oCnt = THIS.cnt_4c_Sombra
366:             WITH loc_oCnt
367:                 .Top         = 0
368:                 .Left        = 0
369:                 .Width       = THIS.Width
370:                 .Height      = 80
371:                 .BorderWidth = 0
372:                 .BackColor   = RGB(100, 100, 100)
373:                 .Visible     = .T.
374:             ENDWITH
375: 
376:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
377:             WITH loc_oCnt.lbl_4c_LblSombra
378:                 .FontBold  = .T.
379:                 .FontName  = "Tahoma"
380:                 .FontSize  = 18
381:                 .WordWrap  = .T.
382:                 .Alignment = 0
383:                 .BackStyle = 0
384:                 .AutoSize  = .F.
385:                 .Caption   = THIS.Caption
386:                 .Height    = 40
387:                 .Left      = 10
388:                 .Top       = 18
389:                 .Width     = 769
390:                 .ForeColor = RGB(0, 0, 0)
391:                 .Visible   = .T.
392:             ENDWITH
393: 
394:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
395:             WITH loc_oCnt.lbl_4c_LblTitulo
396:                 .FontBold  = .T.
397:                 .FontName  = "Tahoma"
398:                 .FontSize  = 18
399:                 .WordWrap  = .T.
400:                 .Alignment = 0

*-- Linhas 411 a 494:
411:         CATCH TO loc_oErro
412:             MsgErro(loc_oErro.Message + CHR(13) + ;
413:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
414:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
415:         ENDTRY
416:     ENDPROC
417: 
418:     *--------------------------------------------------------------------------
419:     * CriarCursorGrdValores - cria o cursor local equivalente a crGrdValores
420:     * (CREATE CURSOR do Load legado, dump de sigopfin_form_codigo_fonte.txt
421:     * linhas 1556-1564): uma linha por origem de valores configurada para a
422:     * movimentacao (this_cDopes). A Fase 7/8 preenche o cursor (equivalente
423:     * ao Scan de crSigOpFin do Init legado) e grava via sigopfinBO.Inserir/
424:     * Atualizar (uma linha por vez). Ordem eh a chave de reordenacao (regra
425:     * CLAUDE.md "CREATE CURSOR: ordem dos campos IDENTICA em todo lugar que
426:     * recriar este cursor" - aqui so existe esta declaracao).
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE CriarCursorGrdValores()
429:         IF !USED("cursor_4c_GrdValores")
430:             CREATE CURSOR cursor_4c_GrdValores ;
431:                 (Ordem N(3), Codigos C(10), Descrs C(100), Dopes C(20), ;
432:                  Notas M, Comandos M, Moedas C(3), Tipos C(1), TitBans C(12), ;
433:                  UsuIncs C(10), MovTits C(20), DatIncs T, UsuAlts C(10), ;
434:                  DatAlts T, GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ;
435:                  ContaECs C(11), GrupoPDs C(11), ContaPDs C(11), GrupoPCs C(11), ;
436:                  ContaPCs C(11), GrupoCDs C(11), ContaCDs C(11), GrupoCCs C(11), ;
437:                  ContaCCs C(11), GrupoADs C(11), ContaADs C(11), GrupoACs C(11), ;
438:                  ContaACs C(11))
439:             INDEX ON Ordem TAG Ordem
440:         ENDIF
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas
445:     * 999-1023: ColumnCount=1, Column1.Width=700, Header1.Caption = titulo da
446:     * grade) + os 3 botoes de navegacao/exclusao de linha (btnSetaUp/
447:     * btnSetaDn/btnExcluiGrd, dump linhas 1277-1309 - mesmo Left=739, Top
448:     * escalonado de 40 em 40). O Click dos botoes fica para a
449:     * Fase 7; aqui a montagem visual, o grid ja ligado ao
450:     * cursor_4c_GrdValores criado em CriarCursorGrdValores(), e a celula de
451:     * lookup da coluna Origem instalada por InstalarCelulaOrigem().
452:     *--------------------------------------------------------------------------
453:     PROTECTED PROCEDURE ConfigurarGrid()
454:         LOCAL loc_oGrd, loc_oErro
455: 
456:         TRY
457:             THIS.AddObject("grd_4c_Dados", "Grid")
458:             loc_oGrd = THIS.grd_4c_Dados
459: 
460:             WITH loc_oGrd
461:                 .Top               = 90
462:                 .Left              = 12
463:                 .Width             = 721
464:                 .Height            = 198
465:                 .FontName          = "Tahoma"
466:                 .FontSize          = 8
467:                 .AllowHeaderSizing = .F.
468:                 .AllowRowSizing    = .F.
469:                 .DeleteMark        = .F.
470:                 .RecordMark        = .F.
471:                 .RowHeight         = 16
472:                 .ScrollBars        = 2
473:                 .Highlight         = .T.
474:                 .HighlightStyle    = 2
475:                 .TabIndex          = 1
476:                 .ColumnCount       = 1
477:                 .RecordSource      = "cursor_4c_GrdValores"
478: 
479:                 .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
480:                 .Column1.Width             = 700
481:                 .Column1.FontName          = "Tahoma"
482:                 .Column1.FontSize          = 8
483:                 .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
484:                     CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
485:                 .Column1.Header1.Alignment = 2
486:                 .Column1.Header1.FontBold  = .F.
487: 
488:                 .Visible = .T.
489:             ENDWITH
490: 
491:             *-- Celula de lookup da coluna Origem (TextBoxOrigemSigOpFin_4c).
492:             *-- Vem DEPOIS do ENDWITH que fixa ColumnCount/RecordSource:
493:             *-- atribuir ColumnCount recria os objetos Column e destruiria o
494:             *-- controle instalado aqui.

*-- Linhas 547 a 751:
547:         CATCH TO loc_oErro
548:             MsgErro(loc_oErro.Message + CHR(13) + ;
549:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
550:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
551:         ENDTRY
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------
555:     * ConfigurarEventosBotoesGrade - BINDEVENT dos 3 botoes de manutencao da
556:     * grade (Click), do AfterRowColChange do proprio grid (Fase 7) e do
557:     * cmd_4c_Sair (Fase 8 - equivalente ao SIGOPFIN.Sair.Click do legado).
558:     *--------------------------------------------------------------------------
559:     PROTECTED PROCEDURE ConfigurarEventosBotoesGrade()
560:         LOCAL loc_oErro
561: 
562:         TRY
563:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
564:                 BINDEVENT(THIS.cmd_4c_BtnSetaUp, "Click", THIS, "BtnSetaUpClick")
565:             ENDIF
566:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
567:                 BINDEVENT(THIS.cmd_4c_BtnSetaDn, "Click", THIS, "BtnSetaDnClick")
568:             ENDIF
569:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
570:                 BINDEVENT(THIS.cmd_4c_BtnExcluiGrd, "Click", THIS, "BtnExcluiGrdClick")
571:             ENDIF
572:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
573:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AfterRowColChange")
574:             ENDIF
575:             IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
576:                 BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
577:             ENDIF
578:         CATCH TO loc_oErro
579:             MsgErro(loc_oErro.Message + CHR(13) + ;
580:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
581:                 "Procedure: " + loc_oErro.Procedure, ;
582:                 "Erro em ConfigurarEventosBotoesGrade")
583:         ENDTRY
584:     ENDPROC
585: 
586:     *--------------------------------------------------------------------------
587:     * BtnSetaUpClick - equivalente a btnSetaUp.Click do legado: troca a Ordem
588:     * da linha corrente com a anterior. PUBLIC por exigencia do BINDEVENT
589:     * (regra CLAUDE.md #3).
590:     *--------------------------------------------------------------------------
591:     PROCEDURE BtnSetaUpClick()
592:         LOCAL loc_nAtu, loc_oErro
593: 
594:         TRY
595:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
596:                     AND cursor_4c_GrdValores.Ordem > 1 ;
597:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
598:                 THIS.LockScreen = .T.
599:                 loc_nAtu = cursor_4c_GrdValores.Ordem
600: 
601:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
602:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu - 1
603:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu - 1 WHERE Ordem = 999
604:                 UPDATE cursor_4c_GrdValores SET Ordem = Ordem + 1 WHERE Ordem > loc_nAtu
605: 
606:                 =SEEK(loc_nAtu - 1, "cursor_4c_GrdValores")
607: 
608:                 THIS.LockScreen    = .F.
609:                 THIS.this_lAlterou = .T.
610:             ENDIF
611: 
612:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
613:                 THIS.grd_4c_Dados.Refresh()
614:                 THIS.grd_4c_Dados.Column1.SetFocus()
615:                 THIS.grd_4c_Dados.Refresh()
616:             ENDIF
617:         CATCH TO loc_oErro
618:             THIS.LockScreen = .F.
619:             MsgErro(loc_oErro.Message + CHR(13) + ;
620:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
621:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaUpClick")
622:         ENDTRY
623:     ENDPROC
624: 
625:     *--------------------------------------------------------------------------
626:     * BtnSetaDnClick - equivalente a btnSetaDn.Click do legado: troca a Ordem
627:     * da linha corrente com a seguinte.
628:     *--------------------------------------------------------------------------
629:     PROCEDURE BtnSetaDnClick()
630:         LOCAL loc_nAtu, loc_oErro
631: 
632:         TRY
633:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
634:                     AND cursor_4c_GrdValores.Ordem > 1 ;
635:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
636:                 THIS.LockScreen = .T.
637:                 loc_nAtu = cursor_4c_GrdValores.Ordem
638: 
639:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
640:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu + 1
641:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu + 1 WHERE Ordem = 999
642: 
643:                 =SEEK(loc_nAtu + 1, "cursor_4c_GrdValores")
644: 
645:                 THIS.LockScreen    = .F.
646:                 THIS.this_lAlterou = .T.
647:             ENDIF
648: 
649:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
650:                 THIS.grd_4c_Dados.Refresh()
651:                 THIS.grd_4c_Dados.Column1.SetFocus()
652:                 THIS.grd_4c_Dados.Refresh()
653:             ENDIF
654:         CATCH TO loc_oErro
655:             THIS.LockScreen = .F.
656:             MsgErro(loc_oErro.Message + CHR(13) + ;
657:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
658:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaDnClick")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * BtnExcluiGrdClick - equivalente a btnExcluiGrd.Click do legado: pede
664:     * confirmacao e exclui a linha corrente, renumerando a Ordem das
665:     * seguintes.
666:     *--------------------------------------------------------------------------
667:     PROCEDURE BtnExcluiGrdClick()
668:         LOCAL loc_nAtu, loc_oErro
669: 
670:         TRY
671:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
672:                     AND cursor_4c_GrdValores.Ordem > 0
673:                 IF MsgConfirma("Confirma a Exclus" + CHR(227) + "o da Linha " + ;
674:                         "Selecionada na Grade?", "Exclus" + CHR(227) + "o de " + ;
675:                         "Lan" + CHR(231) + "amento")
676:                     THIS.LockScreen = .T.
677:                     loc_nAtu = cursor_4c_GrdValores.Ordem
678: 
679:                     DELETE IN cursor_4c_GrdValores
680:                     UPDATE cursor_4c_GrdValores SET Ordem = Ordem - 1 WHERE Ordem > loc_nAtu
681: 
682:                     =SEEK(loc_nAtu, "cursor_4c_GrdValores")
683: 
684:                     THIS.LockScreen    = .F.
685:                     THIS.this_lAlterou = .T.
686:                 ENDIF
687:             ENDIF
688: 
689:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
690:                 THIS.grd_4c_Dados.Refresh()
691:                 THIS.grd_4c_Dados.Column1.SetFocus()
692:                 THIS.grd_4c_Dados.Refresh()
693:             ENDIF
694:         CATCH TO loc_oErro
695:             THIS.LockScreen = .F.
696:             MsgErro(loc_oErro.Message + CHR(13) + ;
697:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
698:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluiGrdClick")
699:         ENDTRY
700:     ENDPROC
701: 
702:     *--------------------------------------------------------------------------
703:     * AfterRowColChange - equivalente ao AfterRowColChange de grdValores no
704:     * legado (dump linhas 2484-2530): repinta os campos de detalhe da linha
705:     * corrente (ja ligados por ControlSource direto a cursor_4c_GrdValores,
706:     * que nao repintam sozinhos ao trocar de linha no grid) e recalcula o
707:     * ToolTipText de Grupo/Conta/TitBans/CMoes. PUBLIC por exigencia do
708:     * BINDEVENT (regra CLAUDE.md #3); tambem chamado diretamente por
709:     * MontaGrade() apos a carga inicial.
710:     *--------------------------------------------------------------------------
711:     PROCEDURE AfterRowColChange(par_nColIndex)
712:         LOCAL loc_oErro
713: 
714:         TRY
715:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
716:                 THIS.txt_4c_GrupoEDs.Refresh()
717:                 THIS.txt_4c_ContaEDs.Refresh()
718:                 THIS.txt_4c_GrupoECs.Refresh()
719:                 THIS.txt_4c_ContaECs.Refresh()
720:                 THIS.txt_4c_GrupoPDs.Refresh()
721:                 THIS.txt_4c_ContaPDs.Refresh()
722:                 THIS.txt_4c_GrupoPCs.Refresh()
723:                 THIS.txt_4c_ContaPCs.Refresh()
724: 
725:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoEDs", "txt_4c_ContaEDs")
726:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoECs", "txt_4c_ContaECs")
727:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPDs", "txt_4c_ContaPDs")
728:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPCs", "txt_4c_ContaPCs")
729:             ENDIF
730: 
731:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
732:                 THIS.txt_4c_GrupoCDs.Refresh()
733:                 THIS.txt_4c_ContaCDs.Refresh()
734:                 THIS.txt_4c_GrupoCCs.Refresh()
735:                 THIS.txt_4c_ContaCCs.Refresh()
736:                 THIS.txt_4c_GrupoADs.Refresh()
737:                 THIS.txt_4c_ContaADs.Refresh()
738:                 THIS.txt_4c_GrupoACs.Refresh()
739:                 THIS.txt_4c_ContaACs.Refresh()
740: 
741:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCDs", "txt_4c_ContaCDs")
742:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCCs", "txt_4c_ContaCCs")
743:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoADs", "txt_4c_ContaADs")
744:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoACs", "txt_4c_ContaACs")
745:             ENDIF
746: 
747:             IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
748:                 THIS.txt_4c_TitBans.Refresh()
749:                 THIS.txt_4c_MovTits.Refresh()
750:                 THIS.txt_4c_CMoes.Refresh()
751:                 THIS.txt_4c_Tipos.Refresh()

*-- Linhas 761 a 876:
761:         CATCH TO loc_oErro
762:             MsgErro(loc_oErro.Message + CHR(13) + ;
763:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
764:                 "Procedure: " + loc_oErro.Procedure, "Erro em AfterRowColChange")
765:         ENDTRY
766:     ENDPROC
767: 
768:     *--------------------------------------------------------------------------
769:     * AtualizarTooltipGrupoConta - ToolTipText dos pares Grupo/Conta de uma
770:     * linha de detalhe (Emissor/Portador/Centro de Custo/Agente Cobrador).
771:     * Legado: "Seek(Padr(Value,10), [crLstCdGcr|crLstCdCli], [Codigos])" -
772:     * crLstCdGcr/crLstCdCli eram cursores locais montados por
773:     * fSigOpFin_Tabs() (fora do acervo); aqui a descricao vem direto das
774:     * tabelas reais (SigCdGcr/SigCdCli), ja usadas pelos pickers desses
775:     * mesmos campos (AbrirLookupGrupoExec/AbrirLookupContaExec).
776:     *--------------------------------------------------------------------------
777:     PROTECTED PROCEDURE AtualizarTooltipGrupoConta(par_cCampoGrupo, par_cCampoConta)
778:         LOCAL loc_oGrupo, loc_oConta, loc_cCodigo, loc_cDescricao
779: 
780:         IF PEMSTATUS(THIS, par_cCampoGrupo, 5)
781:             loc_oGrupo = EVALUATE("THIS." + par_cCampoGrupo)
782:             loc_oGrupo.ToolTipText = "Campo Em Branco"
783:             loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oGrupo.Value)), 10)
784:             IF !EMPTY(loc_cCodigo)
785:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdGcr", "codigos", "descrs", loc_cCodigo)
786:                 IF !EMPTY(loc_cDescricao)
787:                     loc_oGrupo.ToolTipText = loc_cDescricao
788:                 ENDIF
789:             ENDIF
790:         ENDIF
791: 
792:         IF PEMSTATUS(THIS, par_cCampoConta, 5)
793:             loc_oConta = EVALUATE("THIS." + par_cCampoConta)
794:             loc_oConta.ToolTipText = "Campo Em Branco"
795:             loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oConta.Value)), 10)
796:             IF !EMPTY(loc_cCodigo)
797:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdCli", "iclis", "rclis", loc_cCodigo)
798:                 IF !EMPTY(loc_cDescricao)
799:                     loc_oConta.ToolTipText = loc_cDescricao
800:                 ENDIF
801:             ENDIF
802:         ENDIF
803:     ENDPROC
804: 
805:     *--------------------------------------------------------------------------
806:     * AtualizarTooltipTitBans - ToolTipText do Titulo Banco. Legado:
807:     * "Seek(Padr(Value,12), [crLstTitBc], [Codigos])" - crLstTitBc e o mesmo
808:     * cursor local sem equivalente no acervo (regra ja documentada em
809:     * AbrirLookupTituloBancoExec). Sem MsgAviso aqui: no legado este trecho
810:     * tambem e silencioso quando nao acha - so o tooltip fica no default.
811:     *--------------------------------------------------------------------------
812:     PROTECTED PROCEDURE AtualizarTooltipTitBans()
813:         LOCAL loc_oTxt, loc_cValor
814: 
815:         IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
816:             loc_oTxt = THIS.txt_4c_TitBans
817:             loc_oTxt.ToolTipText = "Campo Em Branco"
818:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 12)
819: 
820:             IF !EMPTY(loc_cValor) AND THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
821:                 SELECT crLstTitBc
822:                 GO TOP IN crLstTitBc
823:                 LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == UPPER(loc_cValor)
824:                 IF !EOF("crLstTitBc")
825:                     loc_oTxt.ToolTipText = ALLTRIM(TratarNulo(crLstTitBc.Descrs, ""))
826:                 ENDIF
827:             ENDIF
828:         ENDIF
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     * AtualizarTooltipMoeda - ToolTipText da Moeda de Conversao. Legado:
833:     * "Seek(Padr(Value,3), [crLstMoeda], [Codigos])" - tabela real SigCdMoe
834:     * (cmoes/dmoes), ja usada por AbrirLookupMoedaExec.
835:     *--------------------------------------------------------------------------
836:     PROTECTED PROCEDURE AtualizarTooltipMoeda()
837:         LOCAL loc_oTxt, loc_cValor, loc_cDescricao
838: 
839:         IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
840:             loc_oTxt = THIS.txt_4c_CMoes
841:             loc_oTxt.ToolTipText = "Campo Em Branco"
842:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 3)
843: 
844:             IF !EMPTY(loc_cValor)
845:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdMoe", "cmoes", "dmoes", loc_cValor)
846:                 IF !EMPTY(loc_cDescricao)
847:                     loc_oTxt.ToolTipText = loc_cDescricao
848:                 ENDIF
849:             ENDIF
850:         ENDIF
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * ObterDescricaoPorCodigo - SELECT TOP 1 pontual para ToolTipText (nao ha
855:     * cursor local cacheado para Grupo/Conta/Moeda, como havia no legado via
856:     * fSigOpFin_Tabs). Sem conexao (modo de teste/validacao de UI) devolve
857:     * "" em silencio - o ToolTipText fica no default "Campo Em Branco".
858:     *--------------------------------------------------------------------------
859:     PROTECTED FUNCTION ObterDescricaoPorCodigo(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cValor)
860:         LOCAL loc_cDescricao, loc_cSQL, loc_nResultado, loc_cCursorTmp
861:         loc_cDescricao = ""
862:         loc_cCursorTmp = "cursor_4c_TooltipTmp"
863: 
864:         IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor)) ;
865:                 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 ;
866:                 AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
867:             THIS.FecharCursorTemporario(loc_cCursorTmp)
868: 
869:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
870:                 " WHERE " + par_cCampoCod + " = " + EscaparSQL(ALLTRIM(par_cValor))
871: 
872:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)
873: 
874:             IF loc_nResultado > 0 AND USED(loc_cCursorTmp) AND RECCOUNT(loc_cCursorTmp) > 0
875:                 loc_cDescricao = ALLTRIM(TratarNulo( ;
876:                     EVALUATE(loc_cCursorTmp + "." + par_cCampoDesc), ""))

*-- Linhas 893 a 955:
893:     * cabecalhos de coluna Say14/Say15 (Debito/Credito) e Say5/Say6/Say7/
894:     * Say8 (Grupo/Conta), que no dump aparecem uma UNICA vez, acima das 4
895:     * linhas - por isso entram aqui e nao se repetem na Parte 2.
896:     *
897:     * Cada TextBox e ligado via ControlSource direto a
898:     * cursor_4c_GrdValores.<Campo> (mesmo padrao do montagrades legado -
899:     * ThisForm.getGrupoEDs.ControlSource = [crGrdValores.GrupoEDs] - dump em
900:     * comportamento.json, metodo "SIGOPFIN.Procedure"): como o TextBox fica
901:     * FORA do grid mas ligado ao MESMO alias, ele reflete e edita a mesma
902:     * linha corrente que o grid exibe (mestre-detalhe por cursor compartilhado,
903:     * nao FormParaBO/BOParaForm). O religamento e repetido em MontaGrade()
904:     * (ver comentario la) para o caso de o cursor ser recriado.
905:     *
906:     * Nomes de objeto: o mapeamento.json colide "txt_4c_Grupo" para TODOS os
907:     * getGrupo<X><D|C>s (06 controles diferentes gerando o mesmo nome) -
908:     * usar esse nome causaria "object already exists" a cada AddObject
909:     * seguinte. Usa-se aqui o nome com o sufixo completo do legado
910:     * (txt_4c_GrupoEDs, txt_4c_ContaEDs, ...), unico por controle.
911:     *
912:     * MaxLength = 11 vem do schema (grupoeds/contaeds/... char(11) - ver
913:     * comentarios de sigopfinBO.prg), nao do Width em pixels (regra #19).
914:     *--------------------------------------------------------------------------
915:     PROTECTED PROCEDURE ConfigurarCamposGrupoContaEmissorPortador()
916:         LOCAL loc_oErro
917: 
918:         TRY
919:             *-- Cabecalhos de coluna - uma unica vez, acima das 4 linhas.
920:             THIS.AddObject("lbl_4c_Label14", "Label")
921:             WITH THIS.lbl_4c_Label14
922:                 .FontName  = "Tahoma"
923:                 .FontSize  = 8
924:                 .FontBold  = .T.
925:                 .BackStyle = 0
926:                 .Alignment = 0
927:                 .AutoSize  = .F.
928:                 .Top       = 454
929:                 .Left      = 184
930:                 .Width     = 60
931:                 .Height    = 17
932:                 .ForeColor = RGB(90, 90, 90)
933:                 .Caption   = "D" + CHR(233) + "bito [D]"
934:                 .Visible   = .T.
935:             ENDWITH
936: 
937:             THIS.AddObject("lbl_4c_Label15", "Label")
938:             WITH THIS.lbl_4c_Label15
939:                 .FontName  = "Tahoma"
940:                 .FontSize  = 8
941:                 .FontBold  = .T.
942:                 .BackStyle = 0
943:                 .Alignment = 0
944:                 .AutoSize  = .F.
945:                 .Top       = 454
946:                 .Left      = 362
947:                 .Width     = 63
948:                 .Height    = 17
949:                 .ForeColor = RGB(90, 90, 90)
950:                 .Caption   = "Cr" + CHR(233) + "dito [C]"
951:                 .Visible   = .T.
952:             ENDWITH
953: 
954:             THIS.AddObject("lbl_4c_Label5", "Label")
955:             WITH THIS.lbl_4c_Label5

*-- Linhas 1060 a 1416:
1060:                 .Left          = 139
1061:                 .Width         = 77
1062:                 .Height        = 23
1063:                 .MaxLength     = 11
1064:                 .TabIndex      = 5
1065:                 .ControlSource = "cursor_4c_GrdValores.GrupoEDs"
1066:                 .Visible       = .T.
1067:             ENDWITH
1068: 
1069:             THIS.AddObject("txt_4c_ContaEDs", "TextBox")
1070:             WITH THIS.txt_4c_ContaEDs
1071:                 .FontName      = "Tahoma"
1072:                 .FontSize      = 8
1073:                 .Top           = 488
1074:                 .Left          = 220
1075:                 .Width         = 77
1076:                 .Height        = 23
1077:                 .MaxLength     = 11
1078:                 .TabIndex      = 6
1079:                 .ControlSource = "cursor_4c_GrdValores.ContaEDs"
1080:                 .Visible       = .T.
1081:             ENDWITH
1082: 
1083:             THIS.AddObject("txt_4c_GrupoECs", "TextBox")
1084:             WITH THIS.txt_4c_GrupoECs
1085:                 .FontName      = "Tahoma"
1086:                 .FontSize      = 8
1087:                 .Top           = 488
1088:                 .Left          = 310
1089:                 .Width         = 77
1090:                 .Height        = 23
1091:                 .MaxLength     = 11
1092:                 .TabIndex      = 7
1093:                 .ControlSource = "cursor_4c_GrdValores.GrupoECs"
1094:                 .Visible       = .T.
1095:             ENDWITH
1096: 
1097:             THIS.AddObject("txt_4c_ContaECs", "TextBox")
1098:             WITH THIS.txt_4c_ContaECs
1099:                 .FontName      = "Tahoma"
1100:                 .FontSize      = 8
1101:                 .Top           = 488
1102:                 .Left          = 391
1103:                 .Width         = 77
1104:                 .Height        = 23
1105:                 .MaxLength     = 11
1106:                 .TabIndex      = 8
1107:                 .ControlSource = "cursor_4c_GrdValores.ContaECs"
1108:                 .Visible       = .T.
1109:             ENDWITH
1110: 
1111:             *-- Linha Portador (dump: getGrupoPDs/getContaPDs/getGrupoPCs/
1112:             *-- getContaPCs, Top=513).
1113:             THIS.AddObject("txt_4c_GrupoPDs", "TextBox")
1114:             WITH THIS.txt_4c_GrupoPDs
1115:                 .FontName      = "Tahoma"
1116:                 .FontSize      = 8
1117:                 .Top           = 513
1118:                 .Left          = 139
1119:                 .Width         = 77
1120:                 .Height        = 23
1121:                 .MaxLength     = 11
1122:                 .TabIndex      = 9
1123:                 .ControlSource = "cursor_4c_GrdValores.GrupoPDs"
1124:                 .Visible       = .T.
1125:             ENDWITH
1126: 
1127:             THIS.AddObject("txt_4c_ContaPDs", "TextBox")
1128:             WITH THIS.txt_4c_ContaPDs
1129:                 .FontName      = "Tahoma"
1130:                 .FontSize      = 8
1131:                 .Top           = 513
1132:                 .Left          = 220
1133:                 .Width         = 77
1134:                 .Height        = 23
1135:                 .MaxLength     = 11
1136:                 .TabIndex      = 10
1137:                 .ControlSource = "cursor_4c_GrdValores.ContaPDs"
1138:                 .Visible       = .T.
1139:             ENDWITH
1140: 
1141:             THIS.AddObject("txt_4c_GrupoPCs", "TextBox")
1142:             WITH THIS.txt_4c_GrupoPCs
1143:                 .FontName      = "Tahoma"
1144:                 .FontSize      = 8
1145:                 .Top           = 513
1146:                 .Left          = 310
1147:                 .Width         = 77
1148:                 .Height        = 23
1149:                 .MaxLength     = 11
1150:                 .TabIndex      = 11
1151:                 .ControlSource = "cursor_4c_GrdValores.GrupoPCs"
1152:                 .Visible       = .T.
1153:             ENDWITH
1154: 
1155:             THIS.AddObject("txt_4c_ContaPCs", "TextBox")
1156:             WITH THIS.txt_4c_ContaPCs
1157:                 .FontName      = "Tahoma"
1158:                 .FontSize      = 8
1159:                 .Top           = 513
1160:                 .Left          = 391
1161:                 .Width         = 77
1162:                 .Height        = 23
1163:                 .MaxLength     = 11
1164:                 .TabIndex      = 12
1165:                 .ControlSource = "cursor_4c_GrdValores.ContaPCs"
1166:                 .Visible       = .T.
1167:             ENDWITH
1168:         CATCH TO loc_oErro
1169:             MsgErro(loc_oErro.Message + CHR(13) + ;
1170:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1171:                 "Procedure: " + loc_oErro.Procedure, ;
1172:                 "Erro em ConfigurarCamposGrupoContaEmissorPortador")
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * ConfigurarCamposCentroCustoAgenteCobrador - parte 2 (complementar a
1178:     * Fase 5) dos campos de detalhe da linha corrente da grade: linhas Centro de
1179:     * Custo (getGrupoCDs/getContaCDs/getGrupoCCs/getContaCCs, dump Top=538) e
1180:     * Agente Cobrador (getGrupoADs/getContaADs/getGrupoACs/getContaACs, dump
1181:     * Top=563), com os mesmos Left escalonados (139/220/310/391) e o mesmo
1182:     * padrao de ligacao direta a cursor_4c_GrdValores.<Campo> das linhas
1183:     * Emissor/Portador (ConfigurarCamposGrupoContaEmissorPortador).
1184:     *
1185:     * MaxLength = 11 vem do schema (grupocds/contacds/.../contaacs char(11),
1186:     * mesma largura das colunas de Emissor/Portador), nao do Width em pixels.
1187:     *--------------------------------------------------------------------------
1188:     PROTECTED PROCEDURE ConfigurarCamposCentroCustoAgenteCobrador()
1189:         LOCAL loc_oErro
1190: 
1191:         TRY
1192:             THIS.AddObject("lbl_4c_Label10", "Label")
1193:             WITH THIS.lbl_4c_Label10
1194:                 .FontName  = "Tahoma"
1195:                 .FontSize  = 8
1196:                 .BackStyle = 0
1197:                 .Alignment = 0
1198:                 .AutoSize  = .F.
1199:                 .Top       = 542
1200:                 .Left      = 24
1201:                 .Width     = 92
1202:                 .Height    = 17
1203:                 .ForeColor = RGB(90, 90, 90)
1204:                 .Caption   = "Centro de Custo"
1205:                 .Visible   = .T.
1206:             ENDWITH
1207: 
1208:             THIS.AddObject("lbl_4c_Label11", "Label")
1209:             WITH THIS.lbl_4c_Label11
1210:                 .FontName  = "Tahoma"
1211:                 .FontSize  = 8
1212:                 .BackStyle = 0
1213:                 .Alignment = 0
1214:                 .AutoSize  = .F.
1215:                 .Top       = 567
1216:                 .Left      = 17
1217:                 .Width     = 98
1218:                 .Height    = 17
1219:                 .ForeColor = RGB(90, 90, 90)
1220:                 .Caption   = "Agente Cobrador"
1221:                 .Visible   = .T.
1222:             ENDWITH
1223: 
1224:             *-- Linha Centro de Custo (dump: getGrupoCDs/getContaCDs/
1225:             *-- getGrupoCCs/getContaCCs, Top=538).
1226:             THIS.AddObject("txt_4c_GrupoCDs", "TextBox")
1227:             WITH THIS.txt_4c_GrupoCDs
1228:                 .FontName      = "Tahoma"
1229:                 .FontSize      = 8
1230:                 .Top           = 538
1231:                 .Left          = 139
1232:                 .Width         = 77
1233:                 .Height        = 23
1234:                 .MaxLength     = 11
1235:                 .TabIndex      = 13
1236:                 .ControlSource = "cursor_4c_GrdValores.GrupoCDs"
1237:                 .Visible       = .T.
1238:             ENDWITH
1239: 
1240:             THIS.AddObject("txt_4c_ContaCDs", "TextBox")
1241:             WITH THIS.txt_4c_ContaCDs
1242:                 .FontName      = "Tahoma"
1243:                 .FontSize      = 8
1244:                 .Top           = 538
1245:                 .Left          = 220
1246:                 .Width         = 77
1247:                 .Height        = 23
1248:                 .MaxLength     = 11
1249:                 .TabIndex      = 14
1250:                 .ControlSource = "cursor_4c_GrdValores.ContaCDs"
1251:                 .Visible       = .T.
1252:             ENDWITH
1253: 
1254:             THIS.AddObject("txt_4c_GrupoCCs", "TextBox")
1255:             WITH THIS.txt_4c_GrupoCCs
1256:                 .FontName      = "Tahoma"
1257:                 .FontSize      = 8
1258:                 .Top           = 538
1259:                 .Left          = 310
1260:                 .Width         = 77
1261:                 .Height        = 23
1262:                 .MaxLength     = 11
1263:                 .TabIndex      = 15
1264:                 .ControlSource = "cursor_4c_GrdValores.GrupoCCs"
1265:                 .Visible       = .T.
1266:             ENDWITH
1267: 
1268:             THIS.AddObject("txt_4c_ContaCCs", "TextBox")
1269:             WITH THIS.txt_4c_ContaCCs
1270:                 .FontName      = "Tahoma"
1271:                 .FontSize      = 8
1272:                 .Top           = 538
1273:                 .Left          = 391
1274:                 .Width         = 77
1275:                 .Height        = 23
1276:                 .MaxLength     = 11
1277:                 .TabIndex      = 16
1278:                 .ControlSource = "cursor_4c_GrdValores.ContaCCs"
1279:                 .Visible       = .T.
1280:             ENDWITH
1281: 
1282:             *-- Linha Agente Cobrador (dump: getGrupoADs/getContaADs/
1283:             *-- getGrupoACs/getContaACs, Top=563).
1284:             THIS.AddObject("txt_4c_GrupoADs", "TextBox")
1285:             WITH THIS.txt_4c_GrupoADs
1286:                 .FontName      = "Tahoma"
1287:                 .FontSize      = 8
1288:                 .Top           = 563
1289:                 .Left          = 139
1290:                 .Width         = 77
1291:                 .Height        = 23
1292:                 .MaxLength     = 11
1293:                 .TabIndex      = 17
1294:                 .ControlSource = "cursor_4c_GrdValores.GrupoADs"
1295:                 .Visible       = .T.
1296:             ENDWITH
1297: 
1298:             THIS.AddObject("txt_4c_ContaADs", "TextBox")
1299:             WITH THIS.txt_4c_ContaADs
1300:                 .FontName      = "Tahoma"
1301:                 .FontSize      = 8
1302:                 .Top           = 563
1303:                 .Left          = 220
1304:                 .Width         = 77
1305:                 .Height        = 23
1306:                 .MaxLength     = 11
1307:                 .TabIndex      = 18
1308:                 .ControlSource = "cursor_4c_GrdValores.ContaADs"
1309:                 .Visible       = .T.
1310:             ENDWITH
1311: 
1312:             THIS.AddObject("txt_4c_GrupoACs", "TextBox")
1313:             WITH THIS.txt_4c_GrupoACs
1314:                 .FontName      = "Tahoma"
1315:                 .FontSize      = 8
1316:                 .Top           = 563
1317:                 .Left          = 310
1318:                 .Width         = 77
1319:                 .Height        = 23
1320:                 .MaxLength     = 11
1321:                 .TabIndex      = 19
1322:                 .ControlSource = "cursor_4c_GrdValores.GrupoACs"
1323:                 .Visible       = .T.
1324:             ENDWITH
1325: 
1326:             THIS.AddObject("txt_4c_ContaACs", "TextBox")
1327:             WITH THIS.txt_4c_ContaACs
1328:                 .FontName      = "Tahoma"
1329:                 .FontSize      = 8
1330:                 .Top           = 563
1331:                 .Left          = 391
1332:                 .Width         = 77
1333:                 .Height        = 23
1334:                 .MaxLength     = 11
1335:                 .TabIndex      = 20
1336:                 .ControlSource = "cursor_4c_GrdValores.ContaACs"
1337:                 .Visible       = .T.
1338:             ENDWITH
1339:         CATCH TO loc_oErro
1340:             MsgErro(loc_oErro.Message + CHR(13) + ;
1341:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1342:                 "Procedure: " + loc_oErro.Procedure, ;
1343:                 "Erro em ConfigurarCamposCentroCustoAgenteCobrador")
1344:         ENDTRY
1345:     ENDPROC
1346: 
1347:     *--------------------------------------------------------------------------
1348:     * ConfigurarCamposComplementares - os 4 campos restantes da coluna
1349:     * direita do dump (txt_4c_CMoes/TitBans/Tipos/MovTits, equivalentes a
1350:     * getCMoes/getTitBans/getTipos/getMovTits), com o mesmo padrao de
1351:     * ligacao direta a cursor_4c_GrdValores.<Campo> dos demais campos de
1352:     * detalhe da linha corrente. MaxLength vem do schema (moedas char(3),
1353:     * titbans char(12), tipos char(1), movtits char(20)).
1354:     *--------------------------------------------------------------------------
1355:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
1356:         LOCAL loc_oErro
1357: 
1358:         TRY
1359:             THIS.AddObject("lbl_4c_Label12", "Label")
1360:             WITH THIS.lbl_4c_Label12
1361:                 .FontName  = "Tahoma"
1362:                 .FontSize  = 8
1363:                 .BackStyle = 0
1364:                 .Alignment = 0
1365:                 .AutoSize  = .F.
1366:                 .Top       = 238
1367:                 .Left      = 744
1368:                 .Width     = 160
1369:                 .Height    = 17
1370:                 .ForeColor = RGB(90, 90, 90)
1371:                 .Caption   = "Inibir Lan" + CHR(231) + "amentos de:"
1372:                 .Visible   = .T.
1373:             ENDWITH
1374: 
1375:             THIS.AddObject("lbl_4c_Label3", "Label")
1376:             WITH THIS.lbl_4c_Label3
1377:                 .FontName  = "Tahoma"
1378:                 .FontSize  = 8
1379:                 .BackStyle = 0
1380:                 .Alignment = 0
1381:                 .AutoSize  = .F.
1382:                 .Top       = 309
1383:                 .Left      = 744
1384:                 .Width     = 140
1385:                 .Height    = 17
1386:                 .ForeColor = RGB(90, 90, 90)
1387:                 .Caption   = "Moeda de Convers" + CHR(227) + "o"
1388:                 .Visible   = .T.
1389:             ENDWITH
1390: 
1391:             THIS.AddObject("txt_4c_CMoes", "TextBox")
1392:             WITH THIS.txt_4c_CMoes
1393:                 .FontName      = "Tahoma"
1394:                 .FontSize      = 8
1395:                 .Top           = 325
1396:                 .Left          = 744
1397:                 .Width         = 31
1398:                 .Height        = 23
1399:                 .MaxLength     = 3
1400:                 .TabIndex      = 21
1401:                 .ControlSource = "cursor_4c_GrdValores.Moedas"
1402:                 .Visible       = .T.
1403:             ENDWITH
1404: 
1405:             THIS.AddObject("lbl_4c_Label13", "Label")
1406:             WITH THIS.lbl_4c_Label13
1407:                 .FontName  = "Tahoma"
1408:                 .FontSize  = 8
1409:                 .BackStyle = 0
1410:                 .Alignment = 0
1411:                 .AutoSize  = .F.
1412:                 .Top       = 355
1413:                 .Left      = 744
1414:                 .Width     = 57
1415:                 .Height    = 17
1416:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1442 a 1476:
1442:                 .Left          = 744
1443:                 .Width         = 94
1444:                 .Height        = 23
1445:                 .MaxLength     = 12
1446:                 .TabIndex      = 22
1447:                 .ControlSource = "cursor_4c_GrdValores.TitBans"
1448:                 .Visible       = .T.
1449:             ENDWITH
1450: 
1451:             THIS.AddObject("txt_4c_Tipos", "TextBox")
1452:             WITH THIS.txt_4c_Tipos
1453:                 .FontName      = "Tahoma"
1454:                 .FontSize      = 8
1455:                 .Top           = 370
1456:                 .Left          = 853
1457:                 .Width         = 17
1458:                 .Height        = 23
1459:                 .MaxLength     = 1
1460:                 .TabIndex      = 23
1461:                 .ControlSource = "cursor_4c_GrdValores.Tipos"
1462:                 .Visible       = .T.
1463:             ENDWITH
1464: 
1465:             THIS.AddObject("lbl_4c_Label17", "Label")
1466:             WITH THIS.lbl_4c_Label17
1467:                 .FontName  = "Tahoma"
1468:                 .FontSize  = 8
1469:                 .BackStyle = 0
1470:                 .Alignment = 0
1471:                 .AutoSize  = .F.
1472:                 .Top       = 404
1473:                 .Left      = 744
1474:                 .Width     = 144
1475:                 .Height    = 17
1476:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1486 a 1565:
1486:                 .Left          = 744
1487:                 .Width         = 150
1488:                 .Height        = 23
1489:                 .MaxLength     = 20
1490:                 .TabIndex      = 24
1491:                 .ControlSource = "cursor_4c_GrdValores.MovTits"
1492:                 .Visible       = .T.
1493:             ENDWITH
1494:         CATCH TO loc_oErro
1495:             MsgErro(loc_oErro.Message + CHR(13) + ;
1496:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1497:                 "Procedure: " + loc_oErro.Procedure, ;
1498:                 "Erro em ConfigurarCamposComplementares")
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *--------------------------------------------------------------------------
1503:     * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
1504:     * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
1505:     * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
1506:     * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
1507:     * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
1508:     *
1509:     * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
1510:     * declara Value="0" literal) e NAO ha coluna correspondente nem em
1511:     * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
1512:     * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
1513:     * corresponde) - ficam como estado de tela, sem ControlSource inventado
1514:     * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
1515:     * de dirty-tracking (This.Tag <-> This.Value, que so seta
1516:     * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
1517:     *--------------------------------------------------------------------------
1518:     PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
1519:         LOCAL loc_oErro
1520: 
1521:         TRY
1522:             THIS.AddObject("lbl_4c_Label1", "Label")
1523:             WITH THIS.lbl_4c_Label1
1524:                 .FontName  = "Tahoma"
1525:                 .FontSize  = 8
1526:                 .BackStyle = 0
1527:                 .Alignment = 0
1528:                 .AutoSize  = .F.
1529:                 .Top       = 294
1530:                 .Left      = 12
1531:                 .Width     = 900
1532:                 .Height    = 17
1533:                 .ForeColor = RGB(90, 90, 90)
1534:                 .Caption   = "Notas Sobre a Configura" + CHR(231) + CHR(227) + ;
1535:                     "o (obrigat" + CHR(243) + "rio descrever o m" + CHR(225) + ;
1536:                     "ximo poss" + CHR(237) + "vel a finalidade do lan" + CHR(231) + "amento)"
1537:                 .Visible   = .T.
1538:             ENDWITH
1539: 
1540:             THIS.AddObject("obj_4c_GetNotas", "EditBox")
1541:             WITH THIS.obj_4c_GetNotas
1542:                 .FontName      = "Tahoma"
1543:                 .FontSize      = 8
1544:                 .Top           = 311
1545:                 .Left          = 12
1546:                 .Width         = 721
1547:                 .Height        = 131
1548:                 .ScrollBars    = 2
1549:                 .TabIndex      = 25
1550:                 .ControlSource = "cursor_4c_GrdValores.Notas"
1551:                 .Visible       = .T.
1552:             ENDWITH
1553: 
1554:             THIS.AddObject("lbl_4c_Label2", "Label")
1555:             WITH THIS.lbl_4c_Label2
1556:                 .FontName  = "Tahoma"
1557:                 .FontSize  = 8
1558:                 .BackStyle = 0
1559:                 .Alignment = 0
1560:                 .AutoSize  = .F.
1561:                 .Top       = 455
1562:                 .Left      = 485
1563:                 .Width     = 157
1564:                 .Height    = 15
1565:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1575 a 1595:
1575:                 .Left          = 485
1576:                 .Width         = 508
1577:                 .Height        = 121
1578:                 .ScrollBars    = 2
1579:                 .TabIndex      = 26
1580:                 .ControlSource = "cursor_4c_GrdValores.Comandos"
1581:                 .Visible       = .T.
1582:             ENDWITH
1583: 
1584:             THIS.AddObject("chk_4c_Chk_P1_CMVS", "CheckBox")
1585:             WITH THIS.chk_4c_Chk_P1_CMVS
1586:                 .FontName  = "Tahoma"
1587:                 .FontSize  = 8
1588:                 .BackStyle = 0
1589:                 .Top       = 256
1590:                 .Left      = 744
1591:                 .Width     = 220
1592:                 .Height    = 17
1593:                 .ForeColor = RGB(90, 90, 90)
1594:                 .Caption   = "CMV de Grupos de Produtos"
1595:                 .Value     = 0

*-- Linhas 1615 a 2655:
1615:         CATCH TO loc_oErro
1616:             MsgErro(loc_oErro.Message + CHR(13) + ;
1617:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1618:                 "Procedure: " + loc_oErro.Procedure, ;
1619:                 "Erro em ConfigurarMemosEcheckboxes")
1620:         ENDTRY
1621:     ENDPROC
1622: 
1623:     *--------------------------------------------------------------------------
1624:     * ConfigurarEventosLookup - liga por BINDEVENT os campos que tem lookup no
1625:     * legado. Cada campo usa UM unico handler ligado aos tres eventos:
1626:     *
1627:     *   "LostFocus" - equivalente ao Valid do legado (o legado abre o picker
1628:     *                 ao SAIR do campo). NUNCA "KeyPress" sozinho: handler que
1629:     *                 abre picker so por o campo nao estar vazio dispararia o
1630:     *                 dialogo a CADA TECLA e o usuario nao conseguiria terminar
1631:     *                 de digitar o codigo (regra CLAUDE.md #47).
1632:     *   "KeyPress"  - atalho F4/F5 (convencao do sistema novo). O handler TESTA
1633:     *                 a tecla antes de abrir - sem o teste o picker subiria no
1634:     *                 primeiro caractere.
1635:     *   "DblClick"  - atalho de mouse (convencao do sistema novo).
1636:     *
1637:     * O MESMO handler atende aos tres porque BINDEVENT repassa os parametros do
1638:     * evento: em KeyPress chegam 2 (PCOUNT() = 2), em LostFocus/DblClick nenhum
1639:     * (PCOUNT() = 0). O handler so aplica o filtro de tecla quando de fato
1640:     * recebeu uma - handler SEM parametro ligado a KeyPress eh que estoura
1641:     * (regra CLAUDE.md #3), o inverso e seguro.
1642:     *
1643:     * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
1644:     * PROTECTED falha em silencio (regra CLAUDE.md #3).
1645:     *--------------------------------------------------------------------------
1646:     PROTECTED PROCEDURE ConfigurarEventosLookup()
1647:         LOCAL loc_oErro
1648: 
1649:         TRY
1650:             *-- Grupo (8 campos) e Conta (8 campos) das 4 linhas
1651:             *-- Emissor/Portador/Centro de Custo/Agente Cobrador.
1652:             THIS.LigarEventosLookup("txt_4c_GrupoEDs", "GrupoEDsLookup")
1653:             THIS.LigarEventosLookup("txt_4c_ContaEDs", "ContaEDsLookup")
1654:             THIS.LigarEventosLookup("txt_4c_GrupoECs", "GrupoECsLookup")
1655:             THIS.LigarEventosLookup("txt_4c_ContaECs", "ContaECsLookup")
1656:             THIS.LigarEventosLookup("txt_4c_GrupoPDs", "GrupoPDsLookup")
1657:             THIS.LigarEventosLookup("txt_4c_ContaPDs", "ContaPDsLookup")
1658:             THIS.LigarEventosLookup("txt_4c_GrupoPCs", "GrupoPCsLookup")
1659:             THIS.LigarEventosLookup("txt_4c_ContaPCs", "ContaPCsLookup")
1660:             THIS.LigarEventosLookup("txt_4c_GrupoCDs", "GrupoCDsLookup")
1661:             THIS.LigarEventosLookup("txt_4c_ContaCDs", "ContaCDsLookup")
1662:             THIS.LigarEventosLookup("txt_4c_GrupoCCs", "GrupoCCsLookup")
1663:             THIS.LigarEventosLookup("txt_4c_ContaCCs", "ContaCCsLookup")
1664:             THIS.LigarEventosLookup("txt_4c_GrupoADs", "GrupoADsLookup")
1665:             THIS.LigarEventosLookup("txt_4c_ContaADs", "ContaADsLookup")
1666:             THIS.LigarEventosLookup("txt_4c_GrupoACs", "GrupoACsLookup")
1667:             THIS.LigarEventosLookup("txt_4c_ContaACs", "ContaACsLookup")
1668: 
1669:             *-- Demais campos com Valid de lookup no dump legado.
1670:             THIS.LigarEventosLookup("txt_4c_CMoes",   "CMoesLookup")
1671:             THIS.LigarEventosLookup("txt_4c_TitBans", "TitBansLookup")
1672:             THIS.LigarEventosLookup("txt_4c_MovTits", "MovTitsLookup")
1673:         CATCH TO loc_oErro
1674:             MsgErro(loc_oErro.Message + CHR(13) + ;
1675:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1676:                 "Procedure: " + loc_oErro.Procedure, ;
1677:                 "Erro em ConfigurarEventosLookup")
1678:         ENDTRY
1679:     ENDPROC
1680: 
1681:     *--------------------------------------------------------------------------
1682:     * LigarEventosLookup - liga os 3 eventos de UM campo ao seu handler.
1683:     * O controle e alcancado por EVALUATE (nome montado em tempo de execucao):
1684:     * Controls eh indexado por NUMERO, passar o NOME estoura em runtime
1685:     * (regra CLAUDE.md #34), e EVALUATE eh a forma canonica de LEITURA de
1686:     * membro por nome (regra CLAUDE.md #15).
1687:     *--------------------------------------------------------------------------
1688:     PROTECTED PROCEDURE LigarEventosLookup(par_cCampo, par_cHandler)
1689:         LOCAL loc_oTxt
1690: 
1691:         IF PEMSTATUS(THIS, par_cCampo, 5)
1692:             loc_oTxt = EVALUATE("THIS." + par_cCampo)
1693:             IF VARTYPE(loc_oTxt) = "O"
1694:                 BINDEVENT(loc_oTxt, "LostFocus", THIS, par_cHandler)
1695:                 BINDEVENT(loc_oTxt, "KeyPress",  THIS, par_cHandler)
1696:                 BINDEVENT(loc_oTxt, "DblClick",  THIS, par_cHandler)
1697:             ENDIF
1698:         ENDIF
1699:     ENDPROC
1700: 
1701:     *--------------------------------------------------------------------------
1702:     * TeclaAbreLookup - .T. quando o handler deve abrir o picker.
1703:     *
1704:     * Chamado com os parametros que o evento entregou: em LostFocus/DblClick
1705:     * nao vem nenhum (PCOUNT() = 0 no handler -> par_nKeyCode chega como .F.)
1706:     * e o lookup roda, que e o comportamento do Valid legado; em KeyPress vem
1707:     * o codigo da tecla e so F4 (115) e F5 (116) abrem.
1708:     *--------------------------------------------------------------------------
1709:     PROTECTED FUNCTION TeclaAbreLookup(par_nKeyCode)
1710:         LOCAL loc_lAbre
1711:         loc_lAbre = .T.
1712: 
1713:         IF VARTYPE(par_nKeyCode) = "N"
1714:             loc_lAbre = INLIST(par_nKeyCode, 115, 116)
1715:         ENDIF
1716: 
1717:         RETURN loc_lAbre
1718:     ENDFUNC
1719: 
1720:     *--------------------------------------------------------------------------
1721:     * Handlers de lookup - um por campo, ligado aos 3 eventos.
1722:     * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra CLAUDE.md #3).
1723:     *--------------------------------------------------------------------------
1724:     PROCEDURE GrupoEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1725:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1726:             THIS.AbrirLookupGrupo("txt_4c_GrupoEDs")
1727:         ENDIF
1728:     ENDPROC
1729: 
1730:     PROCEDURE GrupoECsLookup(par_nKeyCode, par_nShiftAltCtrl)
1731:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1732:             THIS.AbrirLookupGrupo("txt_4c_GrupoECs")
1733:         ENDIF
1734:     ENDPROC
1735: 
1736:     PROCEDURE GrupoPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1737:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1738:             THIS.AbrirLookupGrupo("txt_4c_GrupoPDs")
1739:         ENDIF
1740:     ENDPROC
1741: 
1742:     PROCEDURE GrupoPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1743:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1744:             THIS.AbrirLookupGrupo("txt_4c_GrupoPCs")
1745:         ENDIF
1746:     ENDPROC
1747: 
1748:     PROCEDURE GrupoCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1749:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1750:             THIS.AbrirLookupGrupo("txt_4c_GrupoCDs")
1751:         ENDIF
1752:     ENDPROC
1753: 
1754:     PROCEDURE GrupoCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1755:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1756:             THIS.AbrirLookupGrupo("txt_4c_GrupoCCs")
1757:         ENDIF
1758:     ENDPROC
1759: 
1760:     PROCEDURE GrupoADsLookup(par_nKeyCode, par_nShiftAltCtrl)
1761:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1762:             THIS.AbrirLookupGrupo("txt_4c_GrupoADs")
1763:         ENDIF
1764:     ENDPROC
1765: 
1766:     PROCEDURE GrupoACsLookup(par_nKeyCode, par_nShiftAltCtrl)
1767:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1768:             THIS.AbrirLookupGrupo("txt_4c_GrupoACs")
1769:         ENDIF
1770:     ENDPROC
1771: 
1772:     PROCEDURE ContaEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1773:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1774:             THIS.AbrirLookupConta("txt_4c_ContaEDs")
1775:         ENDIF
1776:     ENDPROC
1777: 
1778:     PROCEDURE ContaECsLookup(par_nKeyCode, par_nShiftAltCtrl)
1779:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1780:             THIS.AbrirLookupConta("txt_4c_ContaECs")
1781:         ENDIF
1782:     ENDPROC
1783: 
1784:     PROCEDURE ContaPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1785:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1786:             THIS.AbrirLookupConta("txt_4c_ContaPDs")
1787:         ENDIF
1788:     ENDPROC
1789: 
1790:     PROCEDURE ContaPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1791:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1792:             THIS.AbrirLookupConta("txt_4c_ContaPCs")
1793:         ENDIF
1794:     ENDPROC
1795: 
1796:     PROCEDURE ContaCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1797:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1798:             THIS.AbrirLookupConta("txt_4c_ContaCDs")
1799:         ENDIF
1800:     ENDPROC
1801: 
1802:     PROCEDURE ContaCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1803:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1804:             THIS.AbrirLookupConta("txt_4c_ContaCCs")
1805:         ENDIF
1806:     ENDPROC
1807: 
1808:     PROCEDURE ContaADsLookup(par_nKeyCode, par_nShiftAltCtrl)
1809:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1810:             THIS.AbrirLookupConta("txt_4c_ContaADs")
1811:         ENDIF
1812:     ENDPROC
1813: 
1814:     PROCEDURE ContaACsLookup(par_nKeyCode, par_nShiftAltCtrl)
1815:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1816:             THIS.AbrirLookupConta("txt_4c_ContaACs")
1817:         ENDIF
1818:     ENDPROC
1819: 
1820:     PROCEDURE CMoesLookup(par_nKeyCode, par_nShiftAltCtrl)
1821:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1822:             THIS.AbrirLookupMoeda()
1823:         ENDIF
1824:     ENDPROC
1825: 
1826:     PROCEDURE TitBansLookup(par_nKeyCode, par_nShiftAltCtrl)
1827:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1828:             THIS.AbrirLookupTituloBanco()
1829:         ENDIF
1830:     ENDPROC
1831: 
1832:     PROCEDURE MovTitsLookup(par_nKeyCode, par_nShiftAltCtrl)
1833:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1834:             THIS.AbrirLookupMovimentacao()
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     *--------------------------------------------------------------------------
1839:     * AbrirLookupGrupo - picker de Grupo (legado: getGrupo<X>.Valid, que faz
1840:     * Seek em crLstCdGcr e, nao achando, abre fwBuscaInt com as colunas
1841:     * Codigos/Descrs/Tipos e grava This.Value = Codigos + Tipos).
1842:     *
1843:     * Tabela: SigCdGcr (codigos char(10), descrs char(40)). Confirmada por
1844:     * codigo legado independente - em SIGMVCCR, get_sgrupo recebe
1845:     * crSigCdPam2.grupopags e get_sdgrupo.Value = crSigCdGcr.Descrs apos
1846:     * Seek(..., [crSigCdGcr], [Codigos]).
1847:     *
1848:     * crLstCdGcr era montado por fSigOpFin_Tabs() (SigOpFin.prg legado), que
1849:     * NAO veio no acervo; dele vinha tambem a coluna Tipos, que SigCdGcr nao
1850:     * possui. O 11o caractere do campo (char(11) = Codigos(10) + Tipos(1)) e
1851:     * BRANCO para grupo concreto: SIGMVCMV compara SigOpFin.GrupoECs (char 11)
1852:     * diretamente com SigMvCcr.grupos (char 10), igualdade que no SQL Server so
1853:     * se sustenta com o 11o caractere em branco. Por isso o valor gravado e
1854:     * PADR(codigo, 10) + " ", reproduzindo a concatenacao do legado.
1855:     *--------------------------------------------------------------------------
1856:     PROCEDURE AbrirLookupGrupo(par_cCampo)
1857:         IF THIS.this_lEmLookup
1858:             RETURN
1859:         ENDIF
1860: 
1861:         THIS.this_lEmLookup = .T.
1862:         THIS.AbrirLookupGrupoExec(par_cCampo)
1863:         THIS.this_lEmLookup = .F.
1864:     ENDPROC
1865: 
1866:     *--------------------------------------------------------------------------
1867:     * AbrirLookupGrupoExec - corpo do lookup de Grupo. Separado do wrapper
1868:     * acima porque o corpo tem saidas antecipadas: com set/clear da flag no
1869:     * mesmo metodo, uma saida antecipada deixaria this_lEmLookup ligada para
1870:     * sempre e mataria o lookup pelo resto da vida do form (CLAUDE.md #47).
1871:     *--------------------------------------------------------------------------
1872:     PROTECTED PROCEDURE AbrirLookupGrupoExec(par_cCampo)
1873:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
1874:         loc_cCursor = "cursor_4c_BuscaGrupo"
1875: 
1876:         TRY
1877:             loc_oTxt = THIS.ObterCampoLookup(par_cCampo)
1878: 
1879:             IF VARTYPE(loc_oTxt) = "O"
1880:                 *-- Legado: "If Not Empty(This.Value)" - campo vazio nao abre
1881:                 *-- picker nenhum (o grupo e opcional na linha).
1882:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
1883: 
1884:                 IF !EMPTY(loc_cValor)
1885:                     THIS.FecharCursorTemporario(loc_cCursor)
1886: 
1887:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1888:                         "SigCdGcr", loc_cCursor, "codigos", LEFT(loc_cValor, 10), ;
1889:                         "Grupos")
1890: 
1891:                     IF VARTYPE(loc_oBusca) = "O"
1892:                         *-- O Init ja tentou o match EXATO: achando 1 registro
1893:                         *-- ele resolve sozinho e o dialogo NAO deve aparecer
1894:                         *-- (contrato da regra CLAUDE.md #37, equivalente ao
1895:                         *-- "If Not Seek(...)" do legado).
1896:                         IF !loc_oBusca.this_lAchouRegistro
1897:                             loc_oBusca.mAddColuna("codigos", "", "Grupo")
1898:                             loc_oBusca.mAddColuna("descrs",  "", ;
1899:                                 "Descri" + CHR(231) + CHR(227) + "o")
1900:                             loc_oBusca.Show()
1901:                         ENDIF
1902: 
1903:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1904:                             SELECT (loc_cCursor)
1905:                             IF !EOF(loc_cCursor)
1906:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1907:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.codigos, "")), 10) + " ", ;
1908:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.descrs, "")))
1909:                             ENDIF
1910:                         ENDIF
1911: 
1912:                         loc_oBusca.Release()
1913:                     ENDIF
1914: 
1915:                     THIS.FecharCursorTemporario(loc_cCursor)
1916:                 ENDIF
1917:             ENDIF
1918:         CATCH TO loc_oErro
1919:             MsgErro(loc_oErro.Message + CHR(13) + ;
1920:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1921:                 "Procedure: " + loc_oErro.Procedure, ;
1922:                 "Erro em AbrirLookupGrupoExec")
1923:         ENDTRY
1924:     ENDPROC
1925: 
1926:     *--------------------------------------------------------------------------
1927:     * AbrirLookupConta - picker de Conta (legado: getConta<X>.Valid, que faz
1928:     * Seek em crLstCdCli e grava This.Value = Codigos + Tipos).
1929:     *
1930:     * Tabela: SigCdCli (iclis char(10) = codigo da conta, rclis char(50) =
1931:     * descricao). Confirmada por codigo legado independente - em SIGMVCCR,
1932:     * get_sCONTA recebe crSigCdPam2.contapags e get_sdCONTA.Value =
1933:     * crSigCdCli.RClis. Mesma regra do 11o caractere em branco do
1934:     * AbrirLookupGrupo.
1935:     *
1936:     * O legado NAO filtra a lista de contas pelo grupo da mesma linha
1937:     * (crLstCdCli e a lista inteira) - nenhum filtro e acrescentado aqui.
1938:     *--------------------------------------------------------------------------
1939:     PROCEDURE AbrirLookupConta(par_cCampo)
1940:         IF THIS.this_lEmLookup
1941:             RETURN
1942:         ENDIF
1943: 
1944:         THIS.this_lEmLookup = .T.
1945:         THIS.AbrirLookupContaExec(par_cCampo)
1946:         THIS.this_lEmLookup = .F.
1947:     ENDPROC
1948: 
1949:     PROTECTED PROCEDURE AbrirLookupContaExec(par_cCampo)
1950:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
1951:         loc_cCursor = "cursor_4c_BuscaConta"
1952: 
1953:         TRY
1954:             loc_oTxt = THIS.ObterCampoLookup(par_cCampo)
1955: 
1956:             IF VARTYPE(loc_oTxt) = "O"
1957:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
1958: 
1959:                 IF !EMPTY(loc_cValor)
1960:                     THIS.FecharCursorTemporario(loc_cCursor)
1961: 
1962:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1963:                         "SigCdCli", loc_cCursor, "iclis", LEFT(loc_cValor, 10), ;
1964:                         "Contas")
1965: 
1966:                     IF VARTYPE(loc_oBusca) = "O"
1967:                         IF !loc_oBusca.this_lAchouRegistro
1968:                             loc_oBusca.mAddColuna("iclis", "", "Conta")
1969:                             loc_oBusca.mAddColuna("rclis", "", ;
1970:                                 "Descri" + CHR(231) + CHR(227) + "o")
1971:                             loc_oBusca.Show()
1972:                         ENDIF
1973: 
1974:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1975:                             SELECT (loc_cCursor)
1976:                             IF !EOF(loc_cCursor)
1977:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1978:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaConta.iclis, "")), 10) + " ", ;
1979:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaConta.rclis, "")))
1980:                             ENDIF
1981:                         ENDIF
1982: 
1983:                         loc_oBusca.Release()
1984:                     ENDIF
1985: 
1986:                     THIS.FecharCursorTemporario(loc_cCursor)
1987:                 ENDIF
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro(loc_oErro.Message + CHR(13) + ;
1991:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1992:                 "Procedure: " + loc_oErro.Procedure, ;
1993:                 "Erro em AbrirLookupContaExec")
1994:         ENDTRY
1995:     ENDPROC
1996: 
1997:     *--------------------------------------------------------------------------
1998:     * AbrirLookupMoeda - picker de Moeda de Conversao (legado: getCMoes.Valid,
1999:     * Seek em crLstMoeda e This.Value = crLstMoeda.Codigos - sem concatenar
2000:     * Tipos, por isso aqui o valor e o codigo puro, char(3)).
2001:     *
2002:     * Tabela: SigCdMoe (cmoes char(3), dmoes char(15)).
2003:     *--------------------------------------------------------------------------
2004:     PROCEDURE AbrirLookupMoeda()
2005:         IF THIS.this_lEmLookup
2006:             RETURN
2007:         ENDIF
2008: 
2009:         THIS.this_lEmLookup = .T.
2010:         THIS.AbrirLookupMoedaExec()
2011:         THIS.this_lEmLookup = .F.
2012:     ENDPROC
2013: 
2014:     PROTECTED PROCEDURE AbrirLookupMoedaExec()
2015:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
2016:         loc_cCursor = "cursor_4c_BuscaMoeda"
2017: 
2018:         TRY
2019:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_CMoes")
2020: 
2021:             IF VARTYPE(loc_oTxt) = "O"
2022:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2023: 
2024:                 IF !EMPTY(loc_cValor)
2025:                     THIS.FecharCursorTemporario(loc_cCursor)
2026: 
2027:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2028:                         "SigCdMoe", loc_cCursor, "cmoes", LEFT(loc_cValor, 3), ;
2029:                         "Moedas")
2030: 
2031:                     IF VARTYPE(loc_oBusca) = "O"
2032:                         IF !loc_oBusca.this_lAchouRegistro
2033:                             loc_oBusca.mAddColuna("cmoes", "", "Moeda")
2034:                             loc_oBusca.mAddColuna("dmoes", "", ;
2035:                                 "Descri" + CHR(231) + CHR(227) + "o")
2036:                             loc_oBusca.Show()
2037:                         ENDIF
2038: 
2039:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2040:                             SELECT (loc_cCursor)
2041:                             IF !EOF(loc_cCursor)
2042:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2043:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.cmoes, "")), ;
2044:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.dmoes, "")))
2045:                             ENDIF
2046:                         ENDIF
2047: 
2048:                         loc_oBusca.Release()
2049:                     ENDIF
2050: 
2051:                     THIS.FecharCursorTemporario(loc_cCursor)
2052:                 ENDIF
2053:             ENDIF
2054:         CATCH TO loc_oErro
2055:             MsgErro(loc_oErro.Message + CHR(13) + ;
2056:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2057:                 "Procedure: " + loc_oErro.Procedure, ;
2058:                 "Erro em AbrirLookupMoedaExec")
2059:         ENDTRY
2060:     ENDPROC
2061: 
2062:     *--------------------------------------------------------------------------
2063:     * AbrirLookupMovimentacao - picker de Movimentacao de Titulos (legado:
2064:     * getMovTits.Valid). E o unico lookup REMOTO do dump - o legado chama
2065:     * CreateObject([fwBuscaExt], ..., [SigOpOpe], [crListaRemota], [Dopes],
2066:     * This.Value, [Selecao], .t.) e adiciona UMA unica coluna, Dopes.
2067:     *
2068:     * Tabela e campo transcritos do dump, nao deduzidos. Coluna unica: em
2069:     * SigOpOpe, Dopes char(20) e ao mesmo tempo a chave e o texto exibido.
2070:     *
2071:     * O legado grava This.Value = crListaRemota.Dopes INCONDICIONALMENTE (ou
2072:     * seja, tambem quando o usuario cancela, o que zera o campo). Aqui o valor
2073:     * so e aplicado sob this_lSelecionou, que e o contrato do
2074:     * FormBuscaAuxiliar (regra CLAUDE.md #37): cancelar preserva o que o
2075:     * usuario digitou em vez de apaga-lo.
2076:     *--------------------------------------------------------------------------
2077:     PROCEDURE AbrirLookupMovimentacao()
2078:         IF THIS.this_lEmLookup
2079:             RETURN
2080:         ENDIF
2081: 
2082:         THIS.this_lEmLookup = .T.
2083:         THIS.AbrirLookupMovimentacaoExec()
2084:         THIS.this_lEmLookup = .F.
2085:     ENDPROC
2086: 
2087:     PROTECTED PROCEDURE AbrirLookupMovimentacaoExec()
2088:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
2089:         loc_cCursor = "cursor_4c_BuscaMovTit"
2090: 
2091:         TRY
2092:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_MovTits")
2093: 
2094:             IF VARTYPE(loc_oTxt) = "O"
2095:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2096: 
2097:                 IF !EMPTY(loc_cValor)
2098:                     THIS.FecharCursorTemporario(loc_cCursor)
2099: 
2100:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2101:                         "SigOpOpe", loc_cCursor, "Dopes", LEFT(loc_cValor, 20), ;
2102:                         "Sele" + CHR(231) + CHR(227) + "o")
2103: 
2104:                     IF VARTYPE(loc_oBusca) = "O"
2105:                         IF !loc_oBusca.this_lAchouRegistro
2106:                             loc_oBusca.mAddColuna("Dopes", "", ;
2107:                                 "Movimenta" + CHR(231) + CHR(227) + "o")
2108:                             loc_oBusca.Show()
2109:                         ENDIF
2110: 
2111:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2112:                             SELECT (loc_cCursor)
2113:                             IF !EOF(loc_cCursor)
2114:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2115:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMovTit.Dopes, "")), "")
2116:                             ENDIF
2117:                         ENDIF
2118: 
2119:                         loc_oBusca.Release()
2120:                     ENDIF
2121: 
2122:                     THIS.FecharCursorTemporario(loc_cCursor)
2123:                 ENDIF
2124:             ENDIF
2125:         CATCH TO loc_oErro
2126:             MsgErro(loc_oErro.Message + CHR(13) + ;
2127:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2128:                 "Procedure: " + loc_oErro.Procedure, ;
2129:                 "Erro em AbrirLookupMovimentacaoExec")
2130:         ENDTRY
2131:     ENDPROC
2132: 
2133:     *--------------------------------------------------------------------------
2134:     * AbrirLookupTituloBanco - picker de Titulo Banco (legado:
2135:     * getTitBans.Valid, Seek(Padr(This.Value, 12), [crLstTitBc], [Codigos]) e,
2136:     * nao achando, fwBuscaInt sobre crLstTitBc com as colunas Codigos/Descrs/
2137:     * Tipos).
2138:     *
2139:     * crLstTitBc e um cursor LOCAL montado por fSigOpFin_Tabs() (SigOpFin.prg
2140:     * legado), que NAO veio no acervo - e nao ha, no schema canonico, tabela
2141:     * mestre de Titulo Banco: a coluna titbans char(12) so aparece em
2142:     * SigMvCcr, SigMvCpv e sigopfin, sempre como valor gravado. Por isso a
2143:     * lista NAO e remontada a partir de tabela nenhuma: escolher uma tabela
2144:     * por semelhanca e justamente o que a regra "NUNCA inventar tabelas de
2145:     * lookup que nao existem no original" proibe, e o palpite gravaria codigo
2146:     * errado em silencio.
2147:     *
2148:     * O picker roda portanto sobre o MESMO cursor que o legado le, quando ele
2149:     * estiver aberto na sessao (sera o caso assim que fSigOpFin_Tabs for
2150:     * portada). Nao estando, a ausencia e reportada nomeando a origem legada
2151:     * que falta - e o codigo digitado pelo usuario e PRESERVADO, nunca
2152:     * apagado (regra CLAUDE.md #50).
2153:     *--------------------------------------------------------------------------
2154:     PROCEDURE AbrirLookupTituloBanco()
2155:         IF THIS.this_lEmLookup
2156:             RETURN
2157:         ENDIF
2158: 
2159:         THIS.this_lEmLookup = .T.
2160:         THIS.AbrirLookupTituloBancoExec()
2161:         THIS.this_lEmLookup = .F.
2162:     ENDPROC
2163: 
2164:     PROTECTED PROCEDURE AbrirLookupTituloBancoExec()
2165:         LOCAL loc_oTxt, loc_cValor, loc_oErro
2166: 
2167:         TRY
2168:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_TitBans")
2169: 
2170:             IF VARTYPE(loc_oTxt) = "O"
2171:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2172: 
2173:                 IF !EMPTY(loc_cValor)
2174:                     IF THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
2175:                         *-- Legado: Seek(Padr(This.Value, 12), [crLstTitBc],
2176:                         *-- [Codigos]) - achando exato, nao abre o picker.
2177:                         SELECT crLstTitBc
2178:                         GO TOP IN crLstTitBc
2179:                         LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == ;
2180:                             UPPER(ALLTRIM(LEFT(loc_cValor, 12)))
2181: 
2182:                         IF EOF("crLstTitBc")
2183:                             THIS.MostrarPickerListaLocal("crLstTitBc", ;
2184:                                 "Codigos", "Descrs", ;
2185:                                 "T" + CHR(237) + "tulo Banco")
2186:                         ENDIF
2187: 
2188:                         IF USED("crLstTitBc") AND !EOF("crLstTitBc")
2189:                             THIS.AplicarValorLookup(loc_oTxt, ;
2190:                                 ALLTRIM(TratarNulo(crLstTitBc.Codigos, "")), ;
2191:                                 ALLTRIM(TratarNulo(crLstTitBc.Descrs, "")))
2192:                         ENDIF
2193:                     ELSE
2194:                         MsgAviso("A lista de T" + CHR(237) + "tulos de Banco " + ;
2195:                             "(cursor crLstTitBc) n" + CHR(227) + "o est" + CHR(225) + ;
2196:                             " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
2197:                             CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
2198:                             "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
2199:                             "do acervo migrado." + CHR(13) + ;
2200:                             "O c" + CHR(243) + "digo digitado foi mantido.", ;
2201:                             "Lista indispon" + CHR(237) + "vel")
2202:                     ENDIF
2203:                 ENDIF
2204:             ENDIF
2205:         CATCH TO loc_oErro
2206:             MsgErro(loc_oErro.Message + CHR(13) + ;
2207:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2208:                 "Procedure: " + loc_oErro.Procedure, ;
2209:                 "Erro em AbrirLookupTituloBancoExec")
2210:         ENDTRY
2211:     ENDPROC
2212: 
2213:     *--------------------------------------------------------------------------
2214:     * AbrirLookupOrigemGrade - picker da coluna "Origem dos Valores" da grade
2215:     * (legado: grdValores.Column1.Text1.Valid):
2216:     *
2217:     *   Locate For Upper(Descrs) = Upper(Padr(This.Value, 100))
2218:     *   If Eof([crTabOpFin]) -> fwBuscaInt(crTabOpFin, Descrs, ...) + Show
2219:     *   If LastKey() = 27 -> Replace Codigos With [], Descrs With []
2220:     *   Else              -> Replace Codigos/Descrs With crTabOpFin.*
2221:     *
2222:     * crTabOpFin e a lista de origens de valor do modulo SigOpFin, montada por
2223:     * fSigOpFin_Tabs() (SigOpFin.prg legado, fora do acervo) - nao existe
2224:     * tabela correspondente no schema canonico, e nenhuma e inventada aqui
2225:     * (mesma razao do AbrirLookupTituloBanco). O picker roda sobre o cursor do
2226:     * legado quando ele existir; nao existindo, a ausencia e reportada e o que
2227:     * o usuario digitou e preservado na linha.
2228:     *
2229:     * Recebe o TextBox da celula como parametro: dentro do Valid o valor
2230:     * digitado ainda esta em par_oTxt.Value e o cursor so o recebe DEPOIS -
2231:     * ler do cursor validaria o valor antigo (regra CLAUDE.md #46).
2232:     *--------------------------------------------------------------------------
2233:     PROCEDURE AbrirLookupOrigemGrade(par_oTxt)
2234:         IF THIS.this_lEmLookup
2235:             RETURN
2236:         ENDIF
2237: 
2238:         THIS.this_lEmLookup = .T.
2239:         THIS.AbrirLookupOrigemGradeExec(par_oTxt)
2240:         THIS.this_lEmLookup = .F.
2241:     ENDPROC
2242: 
2243:     PROTECTED PROCEDURE AbrirLookupOrigemGradeExec(par_oTxt)
2244:         LOCAL loc_cValor, loc_lCancelou, loc_oErro
2245: 
2246:         TRY
2247:             IF VARTYPE(par_oTxt) = "O" AND THIS.EmModoEdicao() ;
2248:                     AND USED("cursor_4c_GrdValores") ;
2249:                     AND !EOF("cursor_4c_GrdValores")
2250:                 loc_cValor = ALLTRIM(TRANSFORM(par_oTxt.Value))
2251: 
2252:                 *-- Legado: "If Not Empty(This.Value) And (Alltrim(This.Tag)
2253:                 *-- <> Alltrim(This.Value))" - celula vazia ou inalterada nao
2254:                 *-- dispara lookup nenhum.
2255:                 IF !EMPTY(loc_cValor) AND ;
2256:                         ALLTRIM(TRANSFORM(par_oTxt.Tag)) != loc_cValor
2257:                     IF THIS.ListaLocalDisponivel("crTabOpFin", "Descrs")
2258:                         loc_lCancelou = .F.
2259: 
2260:                         SELECT crTabOpFin
2261:                         GO TOP IN crTabOpFin
2262:                         LOCATE FOR UPPER(ALLTRIM(crTabOpFin.Descrs)) == ;
2263:                             UPPER(ALLTRIM(LEFT(loc_cValor, 100)))
2264: 
2265:                         IF EOF("crTabOpFin")
2266:                             loc_lCancelou = !THIS.MostrarPickerListaLocal( ;
2267:                                 "crTabOpFin", "Descrs", "Codigos", "Descritivos")
2268:                         ENDIF
2269: 
2270:                         SELECT cursor_4c_GrdValores
2271:                         IF loc_lCancelou OR !USED("crTabOpFin") OR EOF("crTabOpFin")
2272:                             *-- Legado: "If (LastKey() = 27) Replace Codigos
2273:                             *-- With [], Descrs With []".
2274:                             REPLACE Codigos WITH "", ;
2275:                                     Descrs  WITH "" IN cursor_4c_GrdValores
2276:                             par_oTxt.Value = ""
2277:                         ELSE
2278:                             REPLACE Codigos WITH ALLTRIM(TratarNulo(crTabOpFin.Codigos, "")), ;
2279:                                     Descrs  WITH ALLTRIM(TratarNulo(crTabOpFin.Descrs,  "")) ;
2280:                                 IN cursor_4c_GrdValores
2281:                             par_oTxt.Value = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2282:                         ENDIF
2283: 
2284:                         par_oTxt.Tag       = ALLTRIM(TRANSFORM(par_oTxt.Value))
2285:                         THIS.this_lAlterou = .T.
2286: 
2287:                         *-- Legado: "This.Refresh" - repintura da CELULA, nao
2288:                         *-- MontaGrade(). MontaGrade() reatribui ColumnCount,
2289:                         *-- o que RECRIA os objetos Column e destruiria o
2290:                         *-- proprio TextBox cujo Valid esta em execucao
2291:                         *-- (par_oTxt ficaria com referencia morta).
2292:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2293:                             THIS.grd_4c_Dados.Refresh()
2294:                         ENDIF
2295:                     ELSE
2296:                         MsgAviso("A lista de Origens dos Valores " + ;
2297:                             "(cursor crTabOpFin) n" + CHR(227) + "o est" + CHR(225) + ;
2298:                             " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
2299:                             CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
2300:                             "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
2301:                             "do acervo migrado." + CHR(13) + ;
2302:                             "O texto digitado foi mantido na linha.", ;
2303:                             "Lista indispon" + CHR(237) + "vel")
2304:                     ENDIF
2305:                 ENDIF
2306:             ENDIF
2307:         CATCH TO loc_oErro
2308:             MsgErro(loc_oErro.Message + CHR(13) + ;
2309:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2310:                 "Procedure: " + loc_oErro.Procedure, ;
2311:                 "Erro em AbrirLookupOrigemGradeExec")
2312:         ENDTRY
2313:     ENDPROC
2314: 
2315:     *--------------------------------------------------------------------------
2316:     * ObterCampoLookup - devolve o TextBox de nome par_cCampo quando ele pode
2317:     * receber lookup, ou .NULL. quando nao.
2318:     *
2319:     * O legado protege cada um desses campos com "When -> Return
2320:     * InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])": em VISUALIZAR o campo
2321:     * nao recebe foco e o Valid nunca roda. EmModoEdicao() reproduz esse When.
2322:     *
2323:     * O controle e alcancado por EVALUATE (regra CLAUDE.md #15/#34) - jamais
2324:     * por Controls(<nome>), que e indexado por NUMERO.
2325:     *--------------------------------------------------------------------------
2326:     PROTECTED FUNCTION ObterCampoLookup(par_cCampo)
2327:         LOCAL loc_oTxt
2328:         loc_oTxt = .NULL.
2329: 
2330:         IF THIS.EmModoEdicao() AND PEMSTATUS(THIS, par_cCampo, 5)
2331:             loc_oTxt = EVALUATE("THIS." + par_cCampo)
2332: 
2333:             IF VARTYPE(loc_oTxt) = "O"
2334:                 IF !loc_oTxt.Enabled OR loc_oTxt.ReadOnly
2335:                     loc_oTxt = .NULL.
2336:                 ENDIF
2337:             ENDIF
2338:         ENDIF
2339: 
2340:         RETURN loc_oTxt
2341:     ENDFUNC
2342: 
2343:     *--------------------------------------------------------------------------
2344:     * AplicarValorLookup - grava no campo o codigo escolhido e a descricao no
2345:     * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
2346:     * marcando a tela como alterada (plAlterou do legado).
2347:     *
2348:     * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
2349:     * .Value grava na linha corrente do cursor, que e exatamente o que o
2350:     * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.
2351:     *--------------------------------------------------------------------------
2352:     PROTECTED PROCEDURE AplicarValorLookup(par_oTxt, par_cValor, par_cDescricao)
2353:         IF VARTYPE(par_oTxt) = "O" AND USED("cursor_4c_GrdValores") ;
2354:                 AND !EOF("cursor_4c_GrdValores")
2355:             par_oTxt.Value = par_cValor
2356: 
2357:             IF VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao)
2358:                 par_oTxt.ToolTipText = par_cDescricao
2359:             ENDIF
2360: 
2361:             par_oTxt.Refresh()
2362:             THIS.this_lAlterou = .T.
2363:         ENDIF
2364:     ENDPROC
2365: 
2366:     *--------------------------------------------------------------------------
2367:     * ListaLocalDisponivel - .T. quando o cursor de lista do legado existe na
2368:     * sessao e tem a coluna esperada com pelo menos uma linha.
2369:     *
2370:     * Conferir a COLUNA (e nao so USED()) evita abrir o picker sobre um alias
2371:     * homonimo de outra tela com estrutura diferente, caso em que o
2372:     * ControlSource da grade do picker estouraria em runtime. TYPE() e usado
2373:     * no lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento -
2374:     * com nome de cursor ele dispara o erro 11 do VFP9.
2375:     *--------------------------------------------------------------------------
2376:     PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
2377:         LOCAL loc_lOk
2378:         loc_lOk = .F.
2379: 
2380:         IF USED(par_cCursor)
2381:             IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
2382:                     AND RECCOUNT(par_cCursor) > 0
2383:                 loc_lOk = .T.
2384:             ENDIF
2385:         ENDIF
2386: 
2387:         RETURN loc_lOk
2388:     ENDFUNC
2389: 
2390:     *--------------------------------------------------------------------------
2391:     * MostrarPickerListaLocal - equivalente ao fwBuscaInt do legado: picker
2392:     * sobre um cursor LOCAL ja populado, com duas colunas.
2393:     *
2394:     * Usa a API manual do FormBuscaAuxiliar (CREATEOBJECT sem parametros +
2395:     * mAddColuna + Show) porque o cursor NAO vem de SQL: o Init com parametros
2396:     * dispararia um SELECT contra o SQL Server, que e o oposto do que o legado
2397:     * faz aqui. O cursor ja estar populado e pre-requisito - sem isso o
2398:     * ConfigurarGrid do picker retorna cedo e o dialogo abriria vazio; por
2399:     * isso o chamador sempre passa por ListaLocalDisponivel() antes.
2400:     *
2401:     * Devolve .T. quando o usuario selecionou. Ao selecionar, o ponteiro do
2402:     * cursor fica na linha escolhida (o grid do picker o posiciona), que e
2403:     * como o legado le o registro depois do Show.
2404:     *--------------------------------------------------------------------------
2405:     PROTECTED FUNCTION MostrarPickerListaLocal(par_cCursor, par_cCampoCod, ;
2406:             par_cCampoDesc, par_cTitulo)
2407:         LOCAL loc_oBusca, loc_lSelecionou
2408:         loc_lSelecionou = .F.
2409: 
2410:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2411: 
2412:         IF VARTYPE(loc_oBusca) = "O"
2413:             loc_oBusca.this_cCursorDestino = par_cCursor
2414:             loc_oBusca.this_cTitulo        = par_cTitulo
2415:             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo
2416: 
2417:             loc_oBusca.mAddColuna(par_cCampoCod,  "", par_cCampoCod)
2418:             loc_oBusca.mAddColuna(par_cCampoDesc, "", par_cCampoDesc)
2419:             loc_oBusca.Show()
2420: 
2421:             loc_lSelecionou = loc_oBusca.this_lSelecionou
2422:             loc_oBusca.Release()
2423:         ENDIF
2424: 
2425:         RETURN loc_lSelecionou
2426:     ENDFUNC
2427: 
2428:     *--------------------------------------------------------------------------
2429:     * InstalarCelulaOrigem - poe na Column1 da grade o TextBox com Valid/
2430:     * KeyPress/DblClick embutidos, que e como se liga lookup a CELULA de grade
2431:     * (regra CLAUDE.md #46: AfterRowColChange entrega a coluna de DESTINO, e
2432:     * BINDEVENT em Valid de TextBox de Column nao e confiavel).
2433:     *
2434:     * Chamado tambem de MontaGrade(): atribuir ColumnCount RECRIA os objetos
2435:     * Column e destroi o controle instalado aqui, entao ele e reinstalado em
2436:     * qualquer caminho que religa a grade.
2437:     *
2438:     * CurrentControl e obrigatorio - sem ele a Column continua desenhando o
2439:     * Text1 nativo e o controle novo nunca aparece; Sparse = .F. faz valer em
2440:     * todas as linhas, nao so na ativa (regra CLAUDE.md #18). Column.ReadOnly
2441:     * vem DEPOIS do ReadOnly do Grid, que propaga para as colunas.
2442:     *--------------------------------------------------------------------------
2443:     PROTECTED PROCEDURE InstalarCelulaOrigem()
2444:         LOCAL loc_oCol, loc_oErro
2445: 
2446:         TRY
2447:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2448:                 loc_oCol = THIS.grd_4c_Dados.Column1
2449: 
2450:                 IF !PEMSTATUS(loc_oCol, "txt_4c_CelOrigem", 5)
2451:                     loc_oCol.AddObject("txt_4c_CelOrigem", "TextBoxOrigemSigOpFin_4c")
2452:                 ENDIF
2453: 
2454:                 loc_oCol.txt_4c_CelOrigem.Visible = .T.
2455:                 loc_oCol.CurrentControl           = "txt_4c_CelOrigem"
2456:                 loc_oCol.Sparse                   = .F.
2457:                 loc_oCol.ReadOnly                 = !THIS.EmModoEdicao()
2458:             ENDIF
2459:         CATCH TO loc_oErro
2460:             MsgErro(loc_oErro.Message + CHR(13) + ;
2461:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2462:                 "Procedure: " + loc_oErro.Procedure, ;
2463:                 "Erro em InstalarCelulaOrigem")
2464:         ENDTRY
2465:     ENDPROC
2466: 
2467:     *--------------------------------------------------------------------------
2468:     * CarregarDados - popula cursor_4c_GrdValores com as linhas de configuracao
2469:     * ja gravadas para a movimentacao (this_cDopes) e, em modo de edicao,
2470:     * acrescenta no fim a linha em branco que o legado usa para a inclusao da
2471:     * proxima origem.
2472:     *
2473:     * Equivalente ao trecho do Init legado (dump de
2474:     * sigopfin_form_codigo_fonte.txt, linhas 1483-1523):
2475:     *   =fSigOpFin_Cria()                        -> SELECT ... FROM sigopfin
2476:     *   Scan crSigOpFin / Scatter / Insert       -> DO WHILE sobre o cursor temp
2477:     *   Insert Into crGrdValores (Ordem) Values  -> linha em branco do fim
2478:     *   .MontaGrades()                           -> THIS.MontaGrade()
2479:     *
2480:     * fSigOpFin_Cria()/fSigOpFin_Tabs() vivem no SigOpFin.prg legado, que NAO
2481:     * veio no acervo; o que elas faziam de fato (abrir as linhas de sigopfin da
2482:     * movimentacao) esta reproduzido aqui com SQL direto sobre a tabela. O
2483:     * legado le crSigOpFin, cursor que o form PAI (cadastro de Operacoes) cria
2484:     * - aqui a consulta e propria, para o dialogo nao depender de cursor de
2485:     * terceiro.
2486:     *
2487:     * O SQLEXEC vai para um cursor TEMPORARIO: SQLEXEC sobre o alias ligado ao
2488:     * Grid fecha e recria o alias, zerando ColumnCount e deixando a grade um
2489:     * retangulo branco sem cabecalho. O alias da grade e recarregado com
2490:     * ZAP + insercao linha a linha, que preserva estrutura e binding.
2491:     *--------------------------------------------------------------------------
2492:     PROCEDURE CarregarDados()
2493:         LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado
2494:         LOCAL loc_nOrdem, loc_oErro
2495:         loc_lSucesso    = .F.
2496:         loc_lProsseguir = .T.
2497: 
2498:         TRY
2499:             THIS.CriarCursorGrdValores()
2500: 
2501:             IF !USED("cursor_4c_GrdValores")
2502:                 MsgErro("Cursor da grade n" + CHR(227) + "o foi criado.", ;
2503:                     "Erro em CarregarDados")
2504:                 loc_lProsseguir = .F.
2505:             ENDIF
2506: 
2507:             IF loc_lProsseguir
2508:                 SELECT cursor_4c_GrdValores
2509:                 ZAP
2510: 
2511:                 *-- Sem conexao (validacao de UI / modo de teste) a grade abre
2512:                 *-- vazia e o form continua funcionando - nao ha SQL a executar.
2513:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
2514:                         AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2515: 
2516:                     THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2517: 
2518:                     loc_cSQL = "SELECT codigos, dopes, ordem," + ;
2519:                                " moedas, tipos, titbans, movtits," + ;
2520:                                " notas, comandos," + ;
2521:                                " usuincs, datincs, usualts, datalts," + ;
2522:                                " grupoeds, contaeds, grupoecs, contaecs," + ;
2523:                                " grupopds, contapds, grupopcs, contapcs," + ;
2524:                                " grupocds, contacds, grupoccs, contaccs," + ;
2525:                                " grupoads, contaads, grupoacs, contaacs" + ;
2526:                                " FROM sigopfin" + ;
2527:                                " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
2528:                                " ORDER BY ordem"
2529: 
2530:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, ;
2531:                         "cursor_4c_GrdValoresTmp")
2532: 
2533:                     IF loc_nResultado < 0
2534:                         MsgErro("Erro ao carregar as configura" + CHR(231) + ;
2535:                             CHR(245) + "es de lan" + CHR(231) + "amento da " + ;
2536:                             "movimenta" + CHR(231) + CHR(227) + "o " + ;
2537:                             ALLTRIM(THIS.this_cDopes) + ":" + CHR(13) + ;
2538:                             CapturarErroSQL(), "Erro SQL")
2539:                         loc_lProsseguir = .F.
2540:                     ENDIF
2541:                 ENDIF
2542:             ENDIF
2543: 
2544:             IF loc_lProsseguir
2545:                 loc_nOrdem = 0
2546: 
2547:                 IF USED("cursor_4c_GrdValoresTmp")
2548:                     SELECT cursor_4c_GrdValoresTmp
2549:                     GO TOP
2550:                     DO WHILE !EOF("cursor_4c_GrdValoresTmp")
2551:                         loc_nOrdem = loc_nOrdem + 1
2552:                         THIS.InserirLinhaGrade(loc_nOrdem)
2553:                         SELECT cursor_4c_GrdValoresTmp
2554:                         SKIP
2555:                     ENDDO
2556:                 ENDIF
2557: 
2558:                 *-- Linha em branco do fim, so em modo de edicao - legado:
2559:                 *--   If InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
2560:                 *--       Insert Into crGrdValores (Ordem) Values (lnOrd)
2561:                 *-- Apenas Ordem e preenchida: Dopes/cIdChaves/UsuIncs sao
2562:                 *-- atribuidos na gravacao (gravardados legado, Fase 8).
2563:                 IF THIS.EmModoEdicao()
2564:                     loc_nOrdem = loc_nOrdem + 1
2565:                     INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nOrdem)
2566:                 ENDIF
2567: 
2568:                 THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2569: 
2570:                 THIS.MontaGrade()
2571: 
2572:                 loc_lSucesso = .T.
2573:             ENDIF
2574:         CATCH TO loc_oErro
2575:             MsgErro(loc_oErro.Message + CHR(13) + ;
2576:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2577:                 "Procedure: " + loc_oErro.Procedure, ;
2578:                 "Erro em Formsigopfin.CarregarDados")
2579:         ENDTRY
2580: 
2581:         RETURN loc_lSucesso
2582:     ENDPROC
2583: 
2584:     *--------------------------------------------------------------------------
2585:     * InserirLinhaGrade - acrescenta a cursor_4c_GrdValores a linha corrente de
2586:     * cursor_4c_GrdValoresTmp, renumerando Ordem sequencialmente (par_nOrdem) e
2587:     * resolvendo a descricao da origem. Equivale ao corpo do Scan legado
2588:     * (Scatter Memvar Memo / m.Ordem / m.Descrs / Insert From Memvar).
2589:     *
2590:     * As colunas sao referenciadas com o alias explicito para a insercao nao
2591:     * depender da area de trabalho corrente. Descrs NAO existe na tabela
2592:     * sigopfin (so no cursor da grade) - vem da descricao da origem.
2593:     * DatIncs/DatAlts usam CTOT("") como default, igual ao Nvl(..., Ctot([]))
2594:     * do legado: campo T nao aceita o {} de um DATE vazio.
2595:     *--------------------------------------------------------------------------
2596:     PROTECTED PROCEDURE InserirLinhaGrade(par_nOrdem)
2597:         LOCAL loc_cCodigos, loc_cDescrs
2598: 
2599:         loc_cCodigos = TratarNulo(cursor_4c_GrdValoresTmp.codigos, "")
2600:         loc_cDescrs  = LEFT(THIS.ObterDescricaoOrigem(loc_cCodigos), 100)
2601: 
2602:         INSERT INTO cursor_4c_GrdValores ;
2603:             (Ordem,    Codigos,  Descrs,   Dopes, ;
2604:              Notas,    Comandos, Moedas,   Tipos,    TitBans, ;
2605:              UsuIncs,  MovTits,  DatIncs,  UsuAlts,  DatAlts, ;
2606:              GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
2607:              GrupoPDs, ContaPDs, GrupoPCs, ContaPCs, ;
2608:              GrupoCDs, ContaCDs, GrupoCCs, ContaCCs, ;
2609:              GrupoADs, ContaADs, GrupoACs, ContaACs) ;
2610:             VALUES ;
2611:             (par_nOrdem, ;
2612:              loc_cCodigos, ;
2613:              loc_cDescrs, ;
2614:              TratarNulo(cursor_4c_GrdValoresTmp.dopes,    ""), ;
2615:              TratarNulo(cursor_4c_GrdValoresTmp.notas,    ""), ;
2616:              TratarNulo(cursor_4c_GrdValoresTmp.comandos, ""), ;
2617:              TratarNulo(cursor_4c_GrdValoresTmp.moedas,   ""), ;
2618:              TratarNulo(cursor_4c_GrdValoresTmp.tipos,    ""), ;
2619:              TratarNulo(cursor_4c_GrdValoresTmp.titbans,  ""), ;
2620:              TratarNulo(cursor_4c_GrdValoresTmp.usuincs,  ""), ;
2621:              TratarNulo(cursor_4c_GrdValoresTmp.movtits,  ""), ;
2622:              TratarNulo(cursor_4c_GrdValoresTmp.datincs,  CTOT("")), ;
2623:              TratarNulo(cursor_4c_GrdValoresTmp.usualts,  ""), ;
2624:              TratarNulo(cursor_4c_GrdValoresTmp.datalts,  CTOT("")), ;
2625:              TratarNulo(cursor_4c_GrdValoresTmp.grupoeds, ""), ;
2626:              TratarNulo(cursor_4c_GrdValoresTmp.contaeds, ""), ;
2627:              TratarNulo(cursor_4c_GrdValoresTmp.grupoecs, ""), ;
2628:              TratarNulo(cursor_4c_GrdValoresTmp.contaecs, ""), ;
2629:              TratarNulo(cursor_4c_GrdValoresTmp.grupopds, ""), ;
2630:              TratarNulo(cursor_4c_GrdValoresTmp.contapds, ""), ;
2631:              TratarNulo(cursor_4c_GrdValoresTmp.grupopcs, ""), ;
2632:              TratarNulo(cursor_4c_GrdValoresTmp.contapcs, ""), ;
2633:              TratarNulo(cursor_4c_GrdValoresTmp.grupocds, ""), ;
2634:              TratarNulo(cursor_4c_GrdValoresTmp.contacds, ""), ;
2635:              TratarNulo(cursor_4c_GrdValoresTmp.grupoccs, ""), ;
2636:              TratarNulo(cursor_4c_GrdValoresTmp.contaccs, ""), ;
2637:              TratarNulo(cursor_4c_GrdValoresTmp.grupoads, ""), ;
2638:              TratarNulo(cursor_4c_GrdValoresTmp.contaads, ""), ;
2639:              TratarNulo(cursor_4c_GrdValoresTmp.grupoacs, ""), ;
2640:              TratarNulo(cursor_4c_GrdValoresTmp.contaacs, ""))
2641:     ENDPROC
2642: 
2643:     *--------------------------------------------------------------------------
2644:     * ObterDescricaoOrigem - descricao exibida na coluna da grade para o codigo
2645:     * da origem dos valores. Equivale a fSigOpFin_Busca(Codigos, [D]) do Init
2646:     * legado, que le crTabOpFin - cursor montado por fSigOpFin_Tabs() no
2647:     * SigOpFin.prg legado, que NAO veio no acervo. crTabOpFin tambem NAO
2648:     * corresponde a tabela alguma do banco (o schema tem sigopfin e nenhuma
2649:     * outra tabela *opfin*), portanto a lista de origens nao e conhecida e NAO
2650:     * pode ser inventada.
2651:     *
2652:     * Enquanto crTabOpFin nao existir, a grade mostra o PROPRIO codigo em vez
2653:     * de celula vazia: a linha fica visivel e identificavel, e a ausencia da
2654:     * lista fica aparente em vez de parecer grade sem dados. Assim que o cursor
2655:     * existir (fonte legado), a descricao dele prevalece.

*-- Linhas 2684 a 3359:
2684: 
2685:         RETURN loc_cDescricao
2686:     ENDFUNC
2687: 
2688:     *--------------------------------------------------------------------------
2689:     * MontaGrade - religa grd_4c_Dados a cursor_4c_GrdValores e repinta.
2690:     * Equivale ao montagrades legado (dump linhas 1417-1446).
2691:     *
2692:     * Metodo UNICO de repintura: todo caminho que popula, reordena ou exclui
2693:     * linha do cursor termina aqui. Popular o cursor NAO repinta a grade
2694:     * sozinho - o legado tambem fecha com Go Top + Refresh; sem isso a grade
2695:     * fica visualmente vazia com o cursor cheio.
2696:     *
2697:     * A ordem das atribuicoes e a canonica (ColumnCount -> RecordSource ->
2698:     * ControlSource -> Width -> Header1.Caption): RecordSource recalcula as
2699:     * larguras para o default 90 e apaga o caption, por isso os dois vem
2700:     * DEPOIS dele.
2701:     *
2702:     * O montagrades legado tambem religa os ControlSource dos campos de
2703:     * detalhe (getNotas/getComandos/getCMoes/getTitBans/getTipos/getMovTits e
2704:     * os 16 de Grupo/Conta) e chama AfterRowColChange - esses controles sao
2705:     * criados nas Fases 5 e 6, e o religamento deles entra NESTE metodo junto
2706:     * com eles.
2707:     *--------------------------------------------------------------------------
2708:     PROCEDURE MontaGrade()
2709:         LOCAL loc_oGrd, loc_oErro
2710: 
2711:         TRY
2712:             THIS.CriarCursorGrdValores()
2713: 
2714:             SELECT cursor_4c_GrdValores
2715:             SET ORDER TO TAG Ordem
2716:             GO TOP
2717: 
2718:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2719:                 loc_oGrd = THIS.grd_4c_Dados
2720: 
2721:                 WITH loc_oGrd
2722:                     .ColumnCount  = 1
2723:                     .RecordSource = "cursor_4c_GrdValores"
2724: 
2725:                     .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
2726:                     .Column1.Width             = 700
2727:                     .Column1.FontName          = "Tahoma"
2728:                     .Column1.FontSize          = 8
2729:                     .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
2730:                         CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
2731:                         "o Financeira"
2732:                     .Column1.Header1.Alignment = 2
2733:                     .Column1.Header1.FontBold  = .F.
2734: 
2735:                     .Refresh()
2736:                 ENDWITH
2737:             ENDIF
2738: 
2739:             *-- MontaGrade() reatribui ColumnCount, o que RECRIA os objetos
2740:             *-- Column e destroi o TextBox de lookup da celula - reinstalar
2741:             *-- em todo caminho que religa a grade.
2742:             THIS.InstalarCelulaOrigem()
2743: 
2744:             *-- Religamento dos campos de detalhe da linha corrente,
2745:             *-- criados em ConfigurarCamposGrupoContaEmissorPortador()
2746:             *-- (Fase 5 parte 1 - Emissor/Portador). Guardado por
2747:             *-- PEMSTATUS porque MontaGrade() tambem roda a partir de
2748:             *-- CarregarDados(), chamado no InicializarForm ANTES de
2749:             *-- ConfigurarPageFrame() ter criado esses controles na
2750:             *-- primeira passada (CarregarDados roda de novo depois, com
2751:             *-- os controles ja existindo).
2752:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
2753:                 THIS.txt_4c_GrupoEDs.ControlSource = "cursor_4c_GrdValores.GrupoEDs"
2754:                 THIS.txt_4c_ContaEDs.ControlSource = "cursor_4c_GrdValores.ContaEDs"
2755:                 THIS.txt_4c_GrupoECs.ControlSource = "cursor_4c_GrdValores.GrupoECs"
2756:                 THIS.txt_4c_ContaECs.ControlSource = "cursor_4c_GrdValores.ContaECs"
2757:                 THIS.txt_4c_GrupoPDs.ControlSource = "cursor_4c_GrdValores.GrupoPDs"
2758:                 THIS.txt_4c_ContaPDs.ControlSource = "cursor_4c_GrdValores.ContaPDs"
2759:                 THIS.txt_4c_GrupoPCs.ControlSource = "cursor_4c_GrdValores.GrupoPCs"
2760:                 THIS.txt_4c_ContaPCs.ControlSource = "cursor_4c_GrdValores.ContaPCs"
2761:                 THIS.txt_4c_GrupoEDs.Refresh()
2762:                 THIS.txt_4c_ContaEDs.Refresh()
2763:                 THIS.txt_4c_GrupoECs.Refresh()
2764:                 THIS.txt_4c_ContaECs.Refresh()
2765:                 THIS.txt_4c_GrupoPDs.Refresh()
2766:                 THIS.txt_4c_ContaPDs.Refresh()
2767:                 THIS.txt_4c_GrupoPCs.Refresh()
2768:                 THIS.txt_4c_ContaPCs.Refresh()
2769:             ENDIF
2770: 
2771:             *-- Religamento dos campos de detalhe criados nesta Fase 6
2772:             *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
2773:             *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
2774:             *-- Comandos - ConfigurarCamposComplementares/
2775:             *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
2776:             *-- Fase 5 parte 1, mesma razao.
2777:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
2778:                 THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
2779:                 THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
2780:                 THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"
2781:                 THIS.txt_4c_ContaCCs.ControlSource = "cursor_4c_GrdValores.ContaCCs"
2782:                 THIS.txt_4c_GrupoADs.ControlSource = "cursor_4c_GrdValores.GrupoADs"
2783:                 THIS.txt_4c_ContaADs.ControlSource = "cursor_4c_GrdValores.ContaADs"
2784:                 THIS.txt_4c_GrupoACs.ControlSource = "cursor_4c_GrdValores.GrupoACs"
2785:                 THIS.txt_4c_ContaACs.ControlSource = "cursor_4c_GrdValores.ContaACs"
2786:                 THIS.txt_4c_GrupoCDs.Refresh()
2787:                 THIS.txt_4c_ContaCDs.Refresh()
2788:                 THIS.txt_4c_GrupoCCs.Refresh()
2789:                 THIS.txt_4c_ContaCCs.Refresh()
2790:                 THIS.txt_4c_GrupoADs.Refresh()
2791:                 THIS.txt_4c_ContaADs.Refresh()
2792:                 THIS.txt_4c_GrupoACs.Refresh()
2793:                 THIS.txt_4c_ContaACs.Refresh()
2794:             ENDIF
2795: 
2796:             IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
2797:                 THIS.txt_4c_CMoes.ControlSource   = "cursor_4c_GrdValores.Moedas"
2798:                 THIS.txt_4c_TitBans.ControlSource = "cursor_4c_GrdValores.TitBans"
2799:                 THIS.txt_4c_Tipos.ControlSource    = "cursor_4c_GrdValores.Tipos"
2800:                 THIS.txt_4c_MovTits.ControlSource  = "cursor_4c_GrdValores.MovTits"
2801:                 THIS.txt_4c_CMoes.Refresh()
2802:                 THIS.txt_4c_TitBans.Refresh()
2803:                 THIS.txt_4c_Tipos.Refresh()
2804:                 THIS.txt_4c_MovTits.Refresh()
2805:             ENDIF
2806: 
2807:             IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
2808:                 THIS.obj_4c_GetNotas.ControlSource    = "cursor_4c_GrdValores.Notas"
2809:                 THIS.obj_4c_GetComandos.ControlSource = "cursor_4c_GrdValores.Comandos"
2810:                 THIS.obj_4c_GetNotas.Refresh()
2811:                 THIS.obj_4c_GetComandos.Refresh()
2812:             ENDIF
2813: 
2814:             *-- Legado: ".AfterRowColChange()" ao final do montagrades -
2815:             *-- recalcula os ToolTipText de Grupo/Conta/TitBans/CMoes para a
2816:             *-- linha corrente (Fase 7). Chamado por ultimo, com os campos ja
2817:             *-- religados acima.
2818:             THIS.AfterRowColChange()
2819:         CATCH TO loc_oErro
2820:             MsgErro(loc_oErro.Message + CHR(13) + ;
2821:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2822:                 "Procedure: " + loc_oErro.Procedure, ;
2823:                 "Erro em Formsigopfin.MontaGrade")
2824:         ENDTRY
2825:     ENDPROC
2826: 
2827:     *--------------------------------------------------------------------------
2828:     * AjustarBotoesGrade - visibilidade dos 3 botoes de manutencao da grade
2829:     * conforme o modo. Legado (Init, dump linhas 1525-1527):
2830:     *   .btnExcluiGrd.Visible = InList(.pcEscolha, [INSERIR], [ALTERAR])
2831:     *   .btnSetaDn.Visible    = .btnExcluiGrd.Visible
2832:     *   .btnSetaUp.Visible    = .btnExcluiGrd.Visible
2833:     *
2834:     * Chamado DEPOIS de TornarControlesVisiveis(), que forca Visible = .T. em
2835:     * tudo e apagaria este ajuste se viesse antes. Fica num metodo proprio para
2836:     * que todo caminho que troque de modo possa reaplica-lo e os botoes
2837:     * reaparecam na volta.
2838:     *--------------------------------------------------------------------------
2839:     PROCEDURE AjustarBotoesGrade()
2840:         LOCAL loc_lEditando, loc_oErro
2841: 
2842:         TRY
2843:             loc_lEditando = THIS.EmModoEdicao()
2844: 
2845:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
2846:                 THIS.cmd_4c_BtnSetaUp.Visible = loc_lEditando
2847:             ENDIF
2848:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
2849:                 THIS.cmd_4c_BtnSetaDn.Visible = loc_lEditando
2850:             ENDIF
2851:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
2852:                 THIS.cmd_4c_BtnExcluiGrd.Visible = loc_lEditando
2853:             ENDIF
2854:         CATCH TO loc_oErro
2855:             MsgErro(loc_oErro.Message + CHR(13) + ;
2856:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2857:                 "Procedure: " + loc_oErro.Procedure, ;
2858:                 "Erro em Formsigopfin.AjustarBotoesGrade")
2859:         ENDTRY
2860:     ENDPROC
2861: 
2862:     *--------------------------------------------------------------------------
2863:     * EmModoEdicao - .T. quando a tela esta em inclusao ou alteracao, isto e,
2864:     * quando o legado testa InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR]).
2865:     * O modo e copiado do form chamador no Init; "INCLUIR" e a grafia do
2866:     * sistema novo e "INSERIR" a do legado - as duas sao aceitas porque
2867:     * this_cModoAtual vem de par_oFormPai.this_cModoAtual, que pode trazer
2868:     * qualquer das duas.
2869:     *--------------------------------------------------------------------------
2870:     FUNCTION EmModoEdicao()
2871:         RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), ;
2872:             "INCLUIR", "INSERIR", "ALTERAR")
2873:     ENDFUNC
2874: 
2875:     *--------------------------------------------------------------------------
2876:     * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
2877:     * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
2878:     * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
2879:     * dispara o erro 1586 "Function requires row or table buffering mode". Dai
2880:     * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo.
2881:     *--------------------------------------------------------------------------
2882:     PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
2883:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
2884:             IF CURSORGETPROP("Buffering", par_cAlias) > 1
2885:                 TABLEREVERT(.T., par_cAlias)
2886:             ENDIF
2887:             USE IN (par_cAlias)
2888:         ENDIF
2889:     ENDPROC
2890:     *--------------------------------------------------------------------------
2891:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
2892:     * padrao; percorre recursivamente Controls (containers/PageFrame) para
2893:     * garantir que tudo fique visivel apos a montagem.
2894:     *--------------------------------------------------------------------------
2895:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2896:         LOCAL loc_nI, loc_oObjeto
2897: 
2898:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2899:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2900: 
2901:             IF VARTYPE(loc_oObjeto) = "O"
2902:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2903:                     loc_oObjeto.Visible = .T.
2904:                 ENDIF
2905: 
2906:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2907:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2908:                 ENDIF
2909:             ENDIF
2910:         ENDFOR
2911:     ENDPROC
2912: 
2913:     *--------------------------------------------------------------------------
2914:     * AvancarLinhaGradeOrigem - parte do LostFocus de grdValores.Column1.Text1
2915:     * que NAO e dirty-tracking (esta ja coberta em AbrirLookupOrigemGradeExec,
2916:     * chamado pelo Valid): ao sair da celula com ENTER e a linha preenchida,
2917:     * avanca para a proxima linha e, se for a ultima, insere uma em branco -
2918:     * para o usuario sempre ter onde continuar digitando. Chamado pelo
2919:     * LostFocus de TextBoxOrigemSigOpFin_4c. PUBLIC pelo mesmo motivo de
2920:     * AbrirLookupOrigemGrade (chamado de fora da classe do form).
2921:     *--------------------------------------------------------------------------
2922:     PROCEDURE AvancarLinhaGradeOrigem()
2923:         LOCAL loc_nQtdeBranco, loc_nMaxOrdem, loc_oErro
2924: 
2925:         TRY
2926:             IF THIS.EmModoEdicao() AND USED("cursor_4c_GrdValores") ;
2927:                     AND LASTKEY() = 13 ;
2928:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
2929:                 SELECT cursor_4c_GrdValores
2930:                 SKIP
2931: 
2932:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2933:                     THIS.grd_4c_Dados.Refresh()
2934:                 ENDIF
2935: 
2936:                 IF EOF("cursor_4c_GrdValores")
2937:                     loc_nQtdeBranco = 0
2938:                     COUNT FOR EMPTY(Codigos) TO loc_nQtdeBranco
2939: 
2940:                     IF loc_nQtdeBranco = 0
2941:                         loc_nMaxOrdem = 0
2942:                         CALCULATE MAX(Ordem) TO loc_nMaxOrdem
2943:                         INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nMaxOrdem + 1)
2944:                     ENDIF
2945: 
2946:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2947:                         THIS.grd_4c_Dados.Refresh()
2948:                     ENDIF
2949:                 ENDIF
2950: 
2951:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2952:                     THIS.grd_4c_Dados.Column1.SetFocus()
2953:                 ENDIF
2954:                 KEYBOARD "{DNARROW}"
2955:             ENDIF
2956:         CATCH TO loc_oErro
2957:             MsgErro(loc_oErro.Message + CHR(13) + ;
2958:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2959:                 "Procedure: " + loc_oErro.Procedure, ;
2960:                 "Erro em AvancarLinhaGradeOrigem")
2961:         ENDTRY
2962:     ENDPROC
2963: 
2964:     *--------------------------------------------------------------------------
2965:     * SalvarTagCampo / VerificarAlteracaoCampo - par generico de dirty-
2966:     * tracking (legado: "This.Tag = This.Value" no GotFocus e "If (This.Tag
2967:     * <> This.Value) ThisForm.plAlterou = .t. EndIf" no LostFocus, repetido
2968:     * em ~20 controles do dump). TRANSFORM() normaliza C/N (TextBox guarda
2969:     * char, CheckBox guarda numerico 0/1 - Str(Value,1) do legado e
2970:     * TRANSFORM(Value) aqui dao o mesmo "0"/"1").
2971:     *--------------------------------------------------------------------------
2972:     PROTECTED PROCEDURE SalvarTagCampo(par_cCampo)
2973:         LOCAL loc_oCtrl
2974: 
2975:         IF PEMSTATUS(THIS, par_cCampo, 5)
2976:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
2977:             IF VARTYPE(loc_oCtrl) = "O"
2978:                 loc_oCtrl.Tag = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
2979:             ENDIF
2980:         ENDIF
2981:     ENDPROC
2982: 
2983:     PROTECTED PROCEDURE VerificarAlteracaoCampo(par_cCampo)
2984:         LOCAL loc_oCtrl
2985: 
2986:         IF PEMSTATUS(THIS, par_cCampo, 5)
2987:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
2988:             IF VARTYPE(loc_oCtrl) = "O"
2989:                 IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
2990:                     THIS.this_lAlterou = .T.
2991:                 ENDIF
2992:             ENDIF
2993:         ENDIF
2994:     ENDPROC
2995: 
2996:     *--------------------------------------------------------------------------
2997:     * VerificarAlteracaoEMaiusculizar - variante usada por getNotas/
2998:     * getComandos: dirty-check seguido de "This.Value = Upper(This.Value)".
2999:     *--------------------------------------------------------------------------
3000:     PROTECTED PROCEDURE VerificarAlteracaoEMaiusculizar(par_cCampo)
3001:         LOCAL loc_oCtrl
3002: 
3003:         IF PEMSTATUS(THIS, par_cCampo, 5)
3004:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
3005:             IF VARTYPE(loc_oCtrl) = "O"
3006:                 IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
3007:                     THIS.this_lAlterou = .T.
3008:                 ENDIF
3009:                 loc_oCtrl.Value = UPPER(loc_oCtrl.Value)
3010:             ENDIF
3011:         ENDIF
3012:     ENDPROC
3013: 
3014:     *--------------------------------------------------------------------------
3015:     * ConfigurarEventosDirtyTracking - BINDEVENT de GotFocus/LostFocus para
3016:     * dirty-tracking (this_lAlterou) em todos os controles de detalhe da
3017:     * linha corrente que o dump declara com esse par (16 Grupo/Conta +
3018:     * CMoes/TitBans/Tipos/MovTits + getNotas/getComandos + os 2 CheckBox).
3019:     * Fase 7. O LostFocus dos campos com lookup (Grupo/Conta/CMoes/TitBans/
3020:     * MovTits) ja esta ligado a *Lookup (Fase 6, equivalente ao Valid do
3021:     * legado) - o BIND aqui e um SEGUNDO handler no MESMO evento, que o VFP9
3022:     * encadeia na ordem de ligacao (Lookup primeiro, dirty-check depois),
3023:     * reproduzindo a ordem real do legado (Valid roda antes de LostFocus).
3024:     *--------------------------------------------------------------------------
3025:     PROTECTED PROCEDURE ConfigurarEventosDirtyTracking()
3026:         LOCAL loc_oErro
3027: 
3028:         TRY
3029:             THIS.LigarDirtyTracking("txt_4c_GrupoEDs", "GrupoEDsGotFoco", "GrupoEDsPerdeFoco")
3030:             THIS.LigarDirtyTracking("txt_4c_ContaEDs", "ContaEDsGotFoco", "ContaEDsPerdeFoco")
3031:             THIS.LigarDirtyTracking("txt_4c_GrupoECs", "GrupoECsGotFoco", "GrupoECsPerdeFoco")
3032:             THIS.LigarDirtyTracking("txt_4c_ContaECs", "ContaECsGotFoco", "ContaECsPerdeFoco")
3033:             THIS.LigarDirtyTracking("txt_4c_GrupoPDs", "GrupoPDsGotFoco", "GrupoPDsPerdeFoco")
3034:             THIS.LigarDirtyTracking("txt_4c_ContaPDs", "ContaPDsGotFoco", "ContaPDsPerdeFoco")
3035:             THIS.LigarDirtyTracking("txt_4c_GrupoPCs", "GrupoPCsGotFoco", "GrupoPCsPerdeFoco")
3036:             THIS.LigarDirtyTracking("txt_4c_ContaPCs", "ContaPCsGotFoco", "ContaPCsPerdeFoco")
3037:             THIS.LigarDirtyTracking("txt_4c_GrupoCDs", "GrupoCDsGotFoco", "GrupoCDsPerdeFoco")
3038:             THIS.LigarDirtyTracking("txt_4c_ContaCDs", "ContaCDsGotFoco", "ContaCDsPerdeFoco")
3039:             THIS.LigarDirtyTracking("txt_4c_GrupoCCs", "GrupoCCsGotFoco", "GrupoCCsPerdeFoco")
3040:             THIS.LigarDirtyTracking("txt_4c_ContaCCs", "ContaCCsGotFoco", "ContaCCsPerdeFoco")
3041:             THIS.LigarDirtyTracking("txt_4c_GrupoADs", "GrupoADsGotFoco", "GrupoADsPerdeFoco")
3042:             THIS.LigarDirtyTracking("txt_4c_ContaADs", "ContaADsGotFoco", "ContaADsPerdeFoco")
3043:             THIS.LigarDirtyTracking("txt_4c_GrupoACs", "GrupoACsGotFoco", "GrupoACsPerdeFoco")
3044:             THIS.LigarDirtyTracking("txt_4c_ContaACs", "ContaACsGotFoco", "ContaACsPerdeFoco")
3045: 
3046:             THIS.LigarDirtyTracking("txt_4c_CMoes",   "CMoesGotFoco",   "CMoesPerdeFoco")
3047:             THIS.LigarDirtyTracking("txt_4c_TitBans", "TitBansGotFoco", "TitBansPerdeFoco")
3048:             THIS.LigarDirtyTracking("txt_4c_MovTits", "MovTitsGotFoco", "MovTitsPerdeFoco")
3049:             THIS.LigarDirtyTracking("txt_4c_Tipos",   "TiposGotFoco",   "TiposPerdeFoco")
3050: 
3051:             THIS.LigarDirtyTracking("obj_4c_GetNotas",    "GetNotasGotFoco",    "GetNotasPerdeFoco")
3052:             THIS.LigarDirtyTracking("obj_4c_GetComandos", "GetComandosGotFoco", "GetComandosPerdeFoco")
3053: 
3054:             THIS.LigarDirtyTracking("chk_4c_Chk_P1_CMVS", "ChkP1CmvsGotFoco", "ChkP1CmvsPerdeFoco")
3055:             THIS.LigarDirtyTracking("chk_4c_Chk_P2_MOBS", "ChkP2MobsGotFoco", "ChkP2MobsPerdeFoco")
3056:         CATCH TO loc_oErro
3057:             MsgErro(loc_oErro.Message + CHR(13) + ;
3058:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3059:                 "Procedure: " + loc_oErro.Procedure, ;
3060:                 "Erro em ConfigurarEventosDirtyTracking")
3061:         ENDTRY
3062:     ENDPROC
3063: 
3064:     *--------------------------------------------------------------------------
3065:     * LigarDirtyTracking - liga os handlers de GotFocus/LostFocus de UM campo.
3066:     *--------------------------------------------------------------------------
3067:     PROTECTED PROCEDURE LigarDirtyTracking(par_cCampo, par_cHandlerGotFocus, par_cHandlerLostFocus)
3068:         LOCAL loc_oCtrl
3069: 
3070:         IF PEMSTATUS(THIS, par_cCampo, 5)
3071:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
3072:             IF VARTYPE(loc_oCtrl) = "O"
3073:                 BINDEVENT(loc_oCtrl, "GotFocus",  THIS, par_cHandlerGotFocus)
3074:                 BINDEVENT(loc_oCtrl, "LostFocus", THIS, par_cHandlerLostFocus)
3075:             ENDIF
3076:         ENDIF
3077:     ENDPROC
3078: 
3079:     *--------------------------------------------------------------------------
3080:     * Handlers de dirty-tracking - um par (GotFoco/PerdeFoco) por campo,
3081:     * cada um delegando para o par generico acima com o nome do campo.
3082:     * Todos PUBLIC (sem PROTECTED) por exigencia do BINDEVENT.
3083:     *--------------------------------------------------------------------------
3084:     PROCEDURE GrupoEDsGotFoco()
3085:         THIS.SalvarTagCampo("txt_4c_GrupoEDs")
3086:     ENDPROC
3087:     PROCEDURE GrupoEDsPerdeFoco()
3088:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoEDs")
3089:     ENDPROC
3090: 
3091:     PROCEDURE ContaEDsGotFoco()
3092:         THIS.SalvarTagCampo("txt_4c_ContaEDs")
3093:     ENDPROC
3094:     PROCEDURE ContaEDsPerdeFoco()
3095:         THIS.VerificarAlteracaoCampo("txt_4c_ContaEDs")
3096:     ENDPROC
3097: 
3098:     PROCEDURE GrupoECsGotFoco()
3099:         THIS.SalvarTagCampo("txt_4c_GrupoECs")
3100:     ENDPROC
3101:     PROCEDURE GrupoECsPerdeFoco()
3102:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoECs")
3103:     ENDPROC
3104: 
3105:     PROCEDURE ContaECsGotFoco()
3106:         THIS.SalvarTagCampo("txt_4c_ContaECs")
3107:     ENDPROC
3108:     PROCEDURE ContaECsPerdeFoco()
3109:         THIS.VerificarAlteracaoCampo("txt_4c_ContaECs")
3110:     ENDPROC
3111: 
3112:     PROCEDURE GrupoPDsGotFoco()
3113:         THIS.SalvarTagCampo("txt_4c_GrupoPDs")
3114:     ENDPROC
3115:     PROCEDURE GrupoPDsPerdeFoco()
3116:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoPDs")
3117:     ENDPROC
3118: 
3119:     PROCEDURE ContaPDsGotFoco()
3120:         THIS.SalvarTagCampo("txt_4c_ContaPDs")
3121:     ENDPROC
3122:     PROCEDURE ContaPDsPerdeFoco()
3123:         THIS.VerificarAlteracaoCampo("txt_4c_ContaPDs")
3124:     ENDPROC
3125: 
3126:     PROCEDURE GrupoPCsGotFoco()
3127:         THIS.SalvarTagCampo("txt_4c_GrupoPCs")
3128:     ENDPROC
3129:     PROCEDURE GrupoPCsPerdeFoco()
3130:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoPCs")
3131:     ENDPROC
3132: 
3133:     PROCEDURE ContaPCsGotFoco()
3134:         THIS.SalvarTagCampo("txt_4c_ContaPCs")
3135:     ENDPROC
3136:     PROCEDURE ContaPCsPerdeFoco()
3137:         THIS.VerificarAlteracaoCampo("txt_4c_ContaPCs")
3138:     ENDPROC
3139: 
3140:     PROCEDURE GrupoCDsGotFoco()
3141:         THIS.SalvarTagCampo("txt_4c_GrupoCDs")
3142:     ENDPROC
3143:     PROCEDURE GrupoCDsPerdeFoco()
3144:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoCDs")
3145:     ENDPROC
3146: 
3147:     PROCEDURE ContaCDsGotFoco()
3148:         THIS.SalvarTagCampo("txt_4c_ContaCDs")
3149:     ENDPROC
3150:     PROCEDURE ContaCDsPerdeFoco()
3151:         THIS.VerificarAlteracaoCampo("txt_4c_ContaCDs")
3152:     ENDPROC
3153: 
3154:     PROCEDURE GrupoCCsGotFoco()
3155:         THIS.SalvarTagCampo("txt_4c_GrupoCCs")
3156:     ENDPROC
3157:     PROCEDURE GrupoCCsPerdeFoco()
3158:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoCCs")
3159:     ENDPROC
3160: 
3161:     PROCEDURE ContaCCsGotFoco()
3162:         THIS.SalvarTagCampo("txt_4c_ContaCCs")
3163:     ENDPROC
3164:     PROCEDURE ContaCCsPerdeFoco()
3165:         THIS.VerificarAlteracaoCampo("txt_4c_ContaCCs")
3166:     ENDPROC
3167: 
3168:     PROCEDURE GrupoADsGotFoco()
3169:         THIS.SalvarTagCampo("txt_4c_GrupoADs")
3170:     ENDPROC
3171:     PROCEDURE GrupoADsPerdeFoco()
3172:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoADs")
3173:     ENDPROC
3174: 
3175:     PROCEDURE ContaADsGotFoco()
3176:         THIS.SalvarTagCampo("txt_4c_ContaADs")
3177:     ENDPROC
3178:     PROCEDURE ContaADsPerdeFoco()
3179:         THIS.VerificarAlteracaoCampo("txt_4c_ContaADs")
3180:     ENDPROC
3181: 
3182:     PROCEDURE GrupoACsGotFoco()
3183:         THIS.SalvarTagCampo("txt_4c_GrupoACs")
3184:     ENDPROC
3185:     PROCEDURE GrupoACsPerdeFoco()
3186:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoACs")
3187:     ENDPROC
3188: 
3189:     PROCEDURE ContaACsGotFoco()
3190:         THIS.SalvarTagCampo("txt_4c_ContaACs")
3191:     ENDPROC
3192:     PROCEDURE ContaACsPerdeFoco()
3193:         THIS.VerificarAlteracaoCampo("txt_4c_ContaACs")
3194:     ENDPROC
3195: 
3196:     PROCEDURE CMoesGotFoco()
3197:         THIS.SalvarTagCampo("txt_4c_CMoes")
3198:     ENDPROC
3199:     PROCEDURE CMoesPerdeFoco()
3200:         THIS.VerificarAlteracaoCampo("txt_4c_CMoes")
3201:     ENDPROC
3202: 
3203:     PROCEDURE TitBansGotFoco()
3204:         THIS.SalvarTagCampo("txt_4c_TitBans")
3205:     ENDPROC
3206:     PROCEDURE TitBansPerdeFoco()
3207:         THIS.VerificarAlteracaoCampo("txt_4c_TitBans")
3208:     ENDPROC
3209: 
3210:     PROCEDURE MovTitsGotFoco()
3211:         THIS.SalvarTagCampo("txt_4c_MovTits")
3212:     ENDPROC
3213:     PROCEDURE MovTitsPerdeFoco()
3214:         THIS.VerificarAlteracaoCampo("txt_4c_MovTits")
3215:     ENDPROC
3216: 
3217:     PROCEDURE TiposGotFoco()
3218:         THIS.SalvarTagCampo("txt_4c_Tipos")
3219:     ENDPROC
3220:     PROCEDURE TiposPerdeFoco()
3221:         THIS.VerificarAlteracaoCampo("txt_4c_Tipos")
3222:     ENDPROC
3223: 
3224:     PROCEDURE GetNotasGotFoco()
3225:         THIS.SalvarTagCampo("obj_4c_GetNotas")
3226:     ENDPROC
3227:     PROCEDURE GetNotasPerdeFoco()
3228:         THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetNotas")
3229:     ENDPROC
3230: 
3231:     PROCEDURE GetComandosGotFoco()
3232:         THIS.SalvarTagCampo("obj_4c_GetComandos")
3233:     ENDPROC
3234:     PROCEDURE GetComandosPerdeFoco()
3235:         THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetComandos")
3236:     ENDPROC
3237: 
3238:     PROCEDURE ChkP1CmvsGotFoco()
3239:         THIS.SalvarTagCampo("chk_4c_Chk_P1_CMVS")
3240:     ENDPROC
3241:     PROCEDURE ChkP1CmvsPerdeFoco()
3242:         THIS.VerificarAlteracaoCampo("chk_4c_Chk_P1_CMVS")
3243:     ENDPROC
3244: 
3245:     PROCEDURE ChkP2MobsGotFoco()
3246:         THIS.SalvarTagCampo("chk_4c_Chk_P2_MOBS")
3247:     ENDPROC
3248:     PROCEDURE ChkP2MobsPerdeFoco()
3249:         THIS.VerificarAlteracaoCampo("chk_4c_Chk_P2_MOBS")
3250:     ENDPROC
3251: 
3252:     *--------------------------------------------------------------------------
3253:     * BtnSairClick - equivalente a SIGOPFIN.Sair.Click do legado (dump linhas
3254:     * 1606-1732): valida a grade quando houve alteracao, oferece abandonar os
3255:     * dados se a validacao falhar, remove as linhas em branco e grava. PUBLIC
3256:     * por exigencia do BINDEVENT (regra CLAUDE.md #3).
3257:     *
3258:     * Legado:
3259:     *   llOks = .t.
3260:     *   If Not Empty(lcMsg)
3261:     *       If (MessageBox(lcMsg + [Deseja Sair ...], 4+32+256, ...) = 6)
3262:     *           Zap In crGrdValores / plAlterou = .f. / llOks = .t.
3263:     *       Else
3264:     *           grdValores.Refresh/SetFocus/AfterRowColChange() / llOks = .f.
3265:     *       EndIf
3266:     *   EndIf
3267:     *   If llOks
3268:     *       Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
3269:     *       If ThisForm.GravarDados() / ThisForm.Release() / Else llOks=.f.
3270:     *   EndIf
3271:     *--------------------------------------------------------------------------
3272:     PROCEDURE BtnSairClick()
3273:         LOCAL loc_cMsg, loc_lOk, loc_oErro
3274:         loc_cMsg = ""
3275:         loc_lOk  = .T.
3276: 
3277:         TRY
3278:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3279:                 loc_cMsg = THIS.ValidarGradeValores()
3280:             ENDIF
3281: 
3282:             IF !EMPTY(loc_cMsg)
3283:                 IF MsgConfirma(loc_cMsg + CHR(13) + "Deseja Sair da Tela e " + ;
3284:                         "Abandonar Todos os Dados Alterados?", ;
3285:                         "Erro: Dados Inconsistentes")
3286:                     IF USED("cursor_4c_GrdValores")
3287:                         SELECT cursor_4c_GrdValores
3288:                         ZAP
3289:                     ENDIF
3290:                     THIS.this_lAlterou = .F.
3291:                     loc_lOk = .T.
3292:                 ELSE
3293:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3294:                         THIS.grd_4c_Dados.Refresh()
3295:                         THIS.grd_4c_Dados.SetFocus()
3296:                     ENDIF
3297:                     THIS.AfterRowColChange()
3298:                     loc_lOk = .F.
3299:                 ENDIF
3300:             ENDIF
3301: 
3302:             IF loc_lOk
3303:                 IF USED("cursor_4c_GrdValores")
3304:                     DELETE FROM cursor_4c_GrdValores ;
3305:                         WHERE EMPTY(Codigos) OR EMPTY(Descrs)
3306:                 ENDIF
3307: 
3308:                 IF THIS.GravarDados()
3309:                     THIS.Release()
3310:                 ELSE
3311:                     loc_lOk = .F.
3312:                 ENDIF
3313:             ENDIF
3314:         CATCH TO loc_oErro
3315:             MsgErro(loc_oErro.Message + CHR(13) + ;
3316:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3317:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
3318:         ENDTRY
3319:     ENDPROC
3320: 
3321:     *--------------------------------------------------------------------------
3322:     * ValidarGradeValores - equivalente ao trecho de validacao do
3323:     * SIGOPFIN.Sair.Click legado: "Select * From crGrdValores Where Not
3324:     * Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair" + "Scan
3325:     * While Empty(lcMsg)". Devolve a mensagem de inconsistencia (vazia se
3326:     * tudo estiver OK).
3327:     *
3328:     * Fidelidade a uma peculiaridade do legado: dentro de UMA linha, todos os
3329:     * IFs rodam em sequencia (nenhum e guardado por "Empty(lcMsg)" entre si),
3330:     * entao se MAIS DE UM campo da MESMA linha estiver vazio, loc_cMsg fica
3331:     * com o ULTIMO que bateu (nao o primeiro) - e so DEPOIS de terminar a
3332:     * linha inteira o "Scan While Empty(lcMsg)" para de avancar para a
3333:     * proxima. Por isso o EXIT fica no TOPO do corpo do SCAN, nao substitui o
3334:     * SCAN por "SCAN WHILE".
3335:     *--------------------------------------------------------------------------
3336:     PROTECTED FUNCTION ValidarGradeValores()
3337:         LOCAL loc_cMsg, loc_oErro
3338:         loc_cMsg = ""
3339: 
3340:         TRY
3341:             IF USED("cursor_4c_GrdValores")
3342:                 THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3343: 
3344:                 SELECT * FROM cursor_4c_GrdValores ;
3345:                     WHERE !EMPTY(Codigos) AND !EMPTY(Descrs) ;
3346:                     INTO CURSOR cursor_4c_LocalSair READWRITE
3347: 
3348:                 SELECT cursor_4c_LocalSair
3349:                 GO TOP
3350:                 SCAN
3351:                     IF !EMPTY(loc_cMsg)
3352:                         EXIT
3353:                     ENDIF
3354: 
3355:                     IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LocalSair.Notas, "")))
3356:                         loc_cMsg = "O Campo " + CHR(34) + "Notas Sobre a " + ;
3357:                             "Configura" + CHR(231) + CHR(227) + "o" + CHR(34) + ;
3358:                             " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
3359:                             "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)

*-- Linhas 3411 a 3544:
3411:             THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3412:             MsgErro(loc_oErro.Message + CHR(13) + ;
3413:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3414:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGradeValores")
3415:         ENDTRY
3416: 
3417:         RETURN loc_cMsg
3418:     ENDFUNC
3419: 
3420:     *--------------------------------------------------------------------------
3421:     * ValidarCampoGradeVazio - um unico "If Empty(LocalSair.<Campo>)" do
3422:     * Click legado: testa a coluna par_cCampo da linha corrente de
3423:     * cursor_4c_LocalSair e, vazia, monta a mensagem e foca o campo
3424:     * correspondente da grade (par_cCampoForm). par_cMsg e passado por
3425:     * referencia para reproduzir a sobrescrita sequencial do legado (regra de
3426:     * ValidarGradeValores acima).
3427:     *--------------------------------------------------------------------------
3428:     PROTECTED PROCEDURE ValidarCampoGradeVazio(par_cCampo, par_cCampoForm, par_cRotulo, par_cMsg)
3429:         LOCAL loc_oCtrl
3430: 
3431:         IF EMPTY(EVALUATE("cursor_4c_LocalSair." + par_cCampo))
3432:             par_cMsg = "O Campo " + CHR(34) + par_cRotulo + CHR(34) + ;
3433:                 " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
3434:                 "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
3435:             IF PEMSTATUS(THIS, par_cCampoForm, 5)
3436:                 loc_oCtrl = EVALUATE("THIS." + par_cCampoForm)
3437:                 IF VARTYPE(loc_oCtrl) = "O"
3438:                     loc_oCtrl.SetFocus()
3439:                 ENDIF
3440:             ENDIF
3441:         ENDIF
3442:     ENDPROC
3443: 
3444:     *--------------------------------------------------------------------------
3445:     * GravarDados - equivalente ao PROCEDURE gravardados do legado (dump
3446:     * linhas 1367-1412). So grava quando EmModoEdicao() e this_lAlterou (o
3447:     * legado: "If InList(pcEscolha,[INSERIR],[ALTERAR]) And plAlterou"); caso
3448:     * contrario devolve .T. sem fazer nada, igual ao legado ("Return .t."
3449:     * fora do IF).
3450:     *
3451:     * Em ALTERAR, o legado apaga TODAS as linhas antigas de SigOpFin para
3452:     * este Dopes e reinsere TODAS as linhas validas da grade (delete-then-
3453:     * reinsert, nao um diff) - aqui reproduzido com DELETE via SQLEXEC +
3454:     * sigopfinBO.Inserir() por linha, renumerando Ordem sequencialmente.
3455:     *
3456:     * Desvio assumido (documentado, nao e regra de negocio visivel ao
3457:     * usuario): o legado preserva UsuIncs/DatIncs/UsuAlts/DatAlts das linhas
3458:     * pre-existentes no delete-then-reinsert (Iif(pcEscolha=INSERIR Or
3459:     * Empty(m.UsuIncs), Usuar, m.UsuIncs), e similar para os outros tres);
3460:     * sigopfinBO.Inserir() sempre estampa this_cUsuIncs=gc_4c_UsuarioLogado,
3461:     * datincs=GETDATE() e datalts=NULL (nao ha gancho para preservar os
3462:     * valores originais sem reescrever o BO), e this_cUsuAlts fica no
3463:     * default "" do BO (nenhuma linha reinserida e tratada como "alterada"
3464:     * por este fluxo). O rastro de quem/quando INCLUIU de fato fica no
3465:     * LogAuditoria via RegistrarAuditoria(), chamado dentro do proprio
3466:     * Inserir().
3467:     *--------------------------------------------------------------------------
3468:     PROTECTED FUNCTION GravarDados()
3469:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nOrdem, loc_oLinha, loc_oErro
3470:         loc_lSucesso = .T.
3471: 
3472:         TRY
3473:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3474: 
3475:                 IF UPPER(ALLTRIM(THIS.this_cModoAtual)) = "ALTERAR"
3476:                     loc_cSQL = "DELETE FROM sigopfin WHERE dopes = " + ;
3477:                         EscaparSQL(THIS.this_cDopes)
3478: 
3479:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3480:                     IF loc_nResultado < 0
3481:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3482:                             CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
3483:                         loc_lSucesso = .F.
3484:                     ENDIF
3485:                 ENDIF
3486: 
3487:                 IF loc_lSucesso AND USED("cursor_4c_GrdValores")
3488:                     loc_nOrdem = 0
3489: 
3490:                     SELECT cursor_4c_GrdValores
3491:                     GO TOP
3492:                     SCAN FOR !EMPTY(Codigos)
3493:                         loc_nOrdem = loc_nOrdem + 1
3494: 
3495:                         loc_oLinha = CREATEOBJECT("sigopfinBO")
3496:                         IF VARTYPE(loc_oLinha) = "O"
3497:                             *-- CarregarDoCursor() do BO NAO serve aqui: ele le
3498:                             *-- cidchaves/chkempds, colunas que NAO existem em
3499:                             *-- cursor_4c_GrdValores (CriarCursorGrdValores so
3500:                             *-- declara os campos que a grade/campos de
3501:                             *-- detalhe usam - cidchaves e gerado de novo a
3502:                             *-- cada Inserir() e chkempds nao tem controle na
3503:                             *-- tela). Chama-lo estouraria "Variable CIDCHAVES
3504:                             *-- is not found". Os campos sao copiados um a um.
3505:                             loc_oLinha.this_cCodigos  = TratarNulo(cursor_4c_GrdValores.Codigos,  "")
3506:                             loc_oLinha.this_cComandos = TratarNulo(cursor_4c_GrdValores.Comandos, "")
3507:                             loc_oLinha.this_cContaAcs = TratarNulo(cursor_4c_GrdValores.ContaACs,  "")
3508:                             loc_oLinha.this_cContaAds = TratarNulo(cursor_4c_GrdValores.ContaADs,  "")
3509:                             loc_oLinha.this_cContaCcs = TratarNulo(cursor_4c_GrdValores.ContaCCs,  "")
3510:                             loc_oLinha.this_cContaCds = TratarNulo(cursor_4c_GrdValores.ContaCDs,  "")
3511:                             loc_oLinha.this_cContaEcs = TratarNulo(cursor_4c_GrdValores.ContaECs,  "")
3512:                             loc_oLinha.this_cContaEds = TratarNulo(cursor_4c_GrdValores.ContaEDs,  "")
3513:                             loc_oLinha.this_cContaPcs = TratarNulo(cursor_4c_GrdValores.ContaPCs,  "")
3514:                             loc_oLinha.this_cContaPds = TratarNulo(cursor_4c_GrdValores.ContaPDs,  "")
3515:                             loc_oLinha.this_cDopes    = THIS.this_cDopes
3516:                             loc_oLinha.this_cGrupoAcs = TratarNulo(cursor_4c_GrdValores.GrupoACs,  "")
3517:                             loc_oLinha.this_cGrupoAds = TratarNulo(cursor_4c_GrdValores.GrupoADs,  "")
3518:                             loc_oLinha.this_cGrupoCcs = TratarNulo(cursor_4c_GrdValores.GrupoCCs,  "")
3519:                             loc_oLinha.this_cGrupoCds = TratarNulo(cursor_4c_GrdValores.GrupoCDs,  "")
3520:                             loc_oLinha.this_cGrupoEcs = TratarNulo(cursor_4c_GrdValores.GrupoECs,  "")
3521:                             loc_oLinha.this_cGrupoEds = TratarNulo(cursor_4c_GrdValores.GrupoEDs,  "")
3522:                             loc_oLinha.this_cGrupoPcs = TratarNulo(cursor_4c_GrdValores.GrupoPCs,  "")
3523:                             loc_oLinha.this_cGrupoPds = TratarNulo(cursor_4c_GrdValores.GrupoPDs,  "")
3524:                             loc_oLinha.this_cMoedas   = TratarNulo(cursor_4c_GrdValores.Moedas,    "")
3525:                             loc_oLinha.this_cMovTits  = TratarNulo(cursor_4c_GrdValores.MovTits,   "")
3526:                             loc_oLinha.this_cNotas    = TratarNulo(cursor_4c_GrdValores.Notas,     "")
3527:                             loc_oLinha.this_nOrdem    = loc_nOrdem
3528:                             loc_oLinha.this_cTipos    = TratarNulo(cursor_4c_GrdValores.Tipos,     "")
3529:                             loc_oLinha.this_cTitBans  = TratarNulo(cursor_4c_GrdValores.TitBans,   "")
3530: 
3531:                             IF !loc_oLinha.Inserir()
3532:                                 loc_lSucesso = .F.
3533:                             ENDIF
3534:                         ELSE
3535:                             MsgErro("Falha ao criar sigopfinBO.", "Erro")
3536:                             loc_lSucesso = .F.
3537:                         ENDIF
3538: 
3539:                         IF !loc_lSucesso
3540:                             EXIT
3541:                         ENDIF
3542:                     ENDSCAN
3543:                 ENDIF
3544: 

*-- Linhas 3550 a 3593:
3550:             loc_lSucesso = .F.
3551:             MsgErro(loc_oErro.Message + CHR(13) + ;
3552:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3553:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfin.GravarDados")
3554:         ENDTRY
3555: 
3556:         RETURN loc_lSucesso
3557:     ENDFUNC
3558: 
3559:     *--------------------------------------------------------------------------
3560:     * AtualizarConfigFinanceiraOperacao - equivalente a "Replace CfgFinancs
3561:     * With Padr(chk_P1_CMVS.Value,1) + Padr(chk_P2_MOBS.Value,1) +
3562:     * Substr(crSigCdOpe.CfgFinancs,3,18) In crSigCdOpe" (fim do gravardados
3563:     * legado). crSigCdOpe no legado e o registro da operacao (SigCdOpe, PK
3564:     * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
3565:     * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
3566:     * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
3567:     * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
3568:     * blank-padding ANSI do SQL Server.
3569:     *
3570:     * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
3571:     * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma
3572:     * inconsistencia que nao e deste form).
3573:     *--------------------------------------------------------------------------
3574:     PROTECTED FUNCTION AtualizarConfigFinanceiraOperacao()
3575:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCfgAtual, loc_cCfgNova, loc_oErro
3576:         loc_lSucesso = .T.
3577: 
3578:         TRY
3579:             THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3580: 
3581:             loc_cSQL = "SELECT cfgfinancs FROM SigCdOpe WHERE dopes = " + ;
3582:                 EscaparSQL(THIS.this_cDopes)
3583: 
3584:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgFinTmp")
3585: 
3586:             IF loc_nResultado >= 0 AND USED("cursor_4c_CfgFinTmp") ;
3587:                     AND RECCOUNT("cursor_4c_CfgFinTmp") > 0
3588:                 loc_cCfgAtual = PADR(TratarNulo(cursor_4c_CfgFinTmp.cfgfinancs, ""), 20)
3589: 
3590:                 loc_cCfgNova = PADR(IIF(THIS.chk_4c_Chk_P1_CMVS.Value = 1, "S", "N"), 1) + ;
3591:                                PADR(IIF(THIS.chk_4c_Chk_P2_MOBS.Value = 1, "S", "N"), 1) + ;
3592:                                SUBSTR(loc_cCfgAtual, 3, 18)
3593: 

*-- Linhas 3610 a 3700:
3610:             loc_lSucesso = .F.
3611:             MsgErro(loc_oErro.Message + CHR(13) + ;
3612:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3613:                 "Procedure: " + loc_oErro.Procedure, ;
3614:                 "Erro em AtualizarConfigFinanceiraOperacao")
3615:         ENDTRY
3616: 
3617:         RETURN loc_lSucesso
3618:     ENDFUNC
3619: 
3620: ENDDEFINE
3621: 
3622: *==============================================================================
3623: * TextBoxOrigemSigOpFin_4c - celula da coluna "Origem dos Valores a Serem
3624: * Lancados na Movimentacao Financeira" (grd_4c_Dados.Column1), equivalente ao
3625: * SIGOPFIN.grdValores.Column1.Text1 do legado.
3626: *
3627: * Os eventos ficam EMBUTIDOS na classe, nao ligados por BINDEVENT: em VFP9,
3628: * BINDEVENT no Valid de um TextBox dentro de Column nao dispara de forma
3629: * confiavel, e validar a celula no AfterRowColChange da grade valida a linha
3630: * ERRADA, porque o nColIndex que esse evento entrega e a coluna de DESTINO
3631: * (regra CLAUDE.md #46). O corpo de cada evento apenas delega para um metodo
3632: * PUBLIC do form, onde a regra de negocio mora.
3633: *
3634: * Instalada por Formsigopfin.InstalarCelulaOrigem(), que tambem cuida do
3635: * CurrentControl/Sparse/ReadOnly da Column.
3636: *==============================================================================
3637: DEFINE CLASS TextBoxOrigemSigOpFin_4c AS TextBox
3638: 
3639:     FontName   = "Tahoma"
3640:     FontSize   = 8
3641:     BorderStyle = 0
3642:     Margin     = 0
3643:     MaxLength  = 100
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * When - legado: "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])"
3647:     * (a celula so aceita digitacao em inclusao/alteracao).
3648:     *--------------------------------------------------------------------------
3649:     PROCEDURE When()
3650:         RETURN THISFORM.EmModoEdicao()
3651:     ENDPROC
3652: 
3653:     *--------------------------------------------------------------------------
3654:     * GotFocus - legado: "This.Tag = This.Value". O Tag guarda o valor de
3655:     * entrada; o Valid so dispara o lookup quando ele mudou.
3656:     *--------------------------------------------------------------------------
3657:     PROCEDURE GotFocus()
3658:         THIS.Tag = ALLTRIM(TRANSFORM(THIS.Value))
3659:     ENDPROC
3660: 
3661:     *--------------------------------------------------------------------------
3662:     * Valid - legado: Locate em crTabOpFin pela descricao digitada e, nao
3663:     * achando, picker; depois Replace Codigos/Descrs na linha da grade.
3664:     *--------------------------------------------------------------------------
3665:     PROCEDURE Valid()
3666:         THISFORM.AbrirLookupOrigemGrade(THIS)
3667:         RETURN .T.
3668:     ENDPROC
3669: 
3670:     *--------------------------------------------------------------------------
3671:     * LostFocus - legado: avanca para a proxima linha da grade (e insere uma
3672:     * em branco, se for a ultima) quando a saida foi por ENTER com a linha
3673:     * preenchida. O dirty-tracking (This.Tag <> This.Value) desta mesma
3674:     * celula ja e feito em AbrirLookupOrigemGradeExec (chamado pelo Valid,
3675:     * que roda ANTES do LostFocus na ordem real do VFP9) - aqui so a parte
3676:     * de navegacao, delegada ao form (Fase 7).
3677:     *--------------------------------------------------------------------------
3678:     PROCEDURE LostFocus()
3679:         THISFORM.AvancarLinhaGradeOrigem()
3680:     ENDPROC
3681: 
3682:     *--------------------------------------------------------------------------
3683:     * KeyPress - atalho F4/F5 para abrir a lista (convencao do sistema novo).
3684:     * A tecla E testada: sem o teste o picker subiria a cada caractere.
3685:     *--------------------------------------------------------------------------
3686:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3687:         IF INLIST(par_nKeyCode, 115, 116)
3688:             THISFORM.AbrirLookupOrigemGrade(THIS)
3689:             NODEFAULT
3690:         ENDIF
3691:     ENDPROC
3692: 
3693:     *--------------------------------------------------------------------------
3694:     * DblClick - atalho de mouse para abrir a lista.
3695:     *--------------------------------------------------------------------------
3696:     PROCEDURE DblClick()
3697:         THISFORM.AbrirLookupOrigemGrade(THIS)
3698:     ENDPROC
3699: 
3700: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopfinBO.prg):
*====================================================================
* sigopfinBO.prg
*
* Business Object para Configuracao de Lancamentos Financeiros
* Tabela: sigopfin
* Herda de: BusinessBase
*
* Cada registro de sigopfin eh uma LINHA de configuracao (origem dos
* valores a serem lancados) associada a uma movimentacao (dopes, FK
* para SigOpOpe.Dopes). A tela (Formsigopfin) exibe/edita varias
* linhas simultaneamente num grid; este BO trata uma linha por vez.
*====================================================================

DEFINE CLASS sigopfinBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopfin)
    this_cCidChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cCodigos   = ""    && codigos   char(10) - FK para origem (crTabOpFin.Codigos)
    this_cComandos  = ""    && comandos  text     - memo de comandos de programacao
    this_cContaAcs  = ""    && contaacs  char(11)
    this_cContaAds  = ""    && contaads  char(11)
    this_cContaCcs  = ""    && contaccs  char(11)
    this_cContaCds  = ""    && contacds  char(11)
    this_cContaEcs  = ""    && contaecs  char(11)
    this_cContaEds  = ""    && contaeds  char(11)
    this_cContaPcs  = ""    && contapcs  char(11)
    this_cContaPds  = ""    && contapds  char(11)
    this_dDatAlts   = {}    && datalts   datetime
    this_dDatIncs   = {}    && datincs   datetime
    this_cDopes     = ""    && dopes     char(20) - FK para SigOpOpe.Dopes (movimentacao)
    this_cGrupoAcs  = ""    && grupoacs  char(11)
    this_cGrupoAds  = ""    && grupoads  char(11)
    this_cGrupoCcs  = ""    && grupoccs  char(11)
    this_cGrupoCds  = ""    && grupocds  char(11)
    this_cGrupoEcs  = ""    && grupoecs  char(11)
    this_cGrupoEds  = ""    && grupoeds  char(11)
    this_cGrupoPcs  = ""    && grupopcs  char(11)
    this_cGrupoPds  = ""    && grupopds  char(11)
    this_cMoedas    = ""    && moedas    char(3)
    this_cMovTits   = ""    && movtits   char(20)
    this_cNotas     = ""    && notas     text     - memo de notas sobre a configuracao
    this_nOrdem     = 0     && ordem     numeric(3,0)
    this_cTipos     = ""    && tipos     char(1)
    this_cTitBans   = ""    && titbans   char(12)
    this_cUsuAlts   = ""    && usualts   char(10)
    this_cUsuIncs   = ""    && usuincs   char(10)
    this_nChkEmpds  = 0     && chkempds  numeric(1,0)

    *-- Propriedade NAO persistida: descricao exibida no grid (origem do
    *-- lookup contra crTabOpFin.Descrs, casada por this_cCodigos). Nao
    *-- existe coluna "descrs" em sigopfin - eh so exibicao.
    this_cDescricao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopfin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopfinBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * da linha de configuracao (sigopfin). par_cAliasCursor eh o alias do
    * cursor posicionado no registro a carregar (ex.: resultado de um
    * SQLEXEC pela chave cidchaves, ou a linha corrente de crGrdValores).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCodigos   = TratarNulo(codigos,   "")
            THIS.this_cComandos  = TratarNulo(comandos,  "")
            THIS.this_cContaAcs  = TratarNulo(contaacs,  "")
            THIS.this_cContaAds  = TratarNulo(contaads,  "")
            THIS.this_cContaCcs  = TratarNulo(contaccs,  "")
            THIS.this_cContaCds  = TratarNulo(contacds,  "")
            THIS.this_cContaEcs  = TratarNulo(contaecs,  "")
            THIS.this_cContaEds  = TratarNulo(contaeds,  "")
            THIS.this_cContaPcs  = TratarNulo(contapcs,  "")
            THIS.this_cContaPds  = TratarNulo(contapds,  "")
            THIS.this_dDatAlts   = TratarNulo(datalts,   {})
            THIS.this_dDatIncs   = TratarNulo(datincs,   {})
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupoAcs  = TratarNulo(grupoacs,  "")
            THIS.this_cGrupoAds  = TratarNulo(grupoads,  "")
            THIS.this_cGrupoCcs  = TratarNulo(grupoccs,  "")
            THIS.this_cGrupoCds  = TratarNulo(grupocds,  "")
            THIS.this_cGrupoEcs  = TratarNulo(grupoecs,  "")
            THIS.this_cGrupoEds  = TratarNulo(grupoeds,  "")
            THIS.this_cGrupoPcs  = TratarNulo(grupopcs,  "")
            THIS.this_cGrupoPds  = TratarNulo(grupopds,  "")
            THIS.this_cMoedas    = TratarNulo(moedas,    "")
            THIS.this_cMovTits   = TratarNulo(movtits,   "")
            THIS.this_cNotas     = TratarNulo(notas,     "")
            THIS.this_nOrdem     = TratarNulo(ordem,     0)
            THIS.this_cTipos     = TratarNulo(tipos,     "")
            THIS.this_cTitBans   = TratarNulo(titbans,   "")
            THIS.this_cUsuAlts   = TratarNulo(usualts,   "")
            THIS.this_cUsuIncs   = TratarNulo(usuincs,   "")
            THIS.this_nChkEmpds  = TratarNulo(chkempds,  0)

            *-- descrs nao eh coluna de sigopfin: so chega quando o cursor de
            *-- origem for montado com JOIN contra crTabOpFin/SigOpOpe (lookup
            *-- da descricao exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricao = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricao = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cUsuIncs   = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO sigopfin (cidchaves, codigos, comandos, contaacs," + ;
                       " contaads, contaccs, contacds, contaecs, contaeds, contapcs," + ;
                       " contapds, datalts, datincs, dopes, grupoacs, grupoads," + ;
                       " grupoccs, grupocds, grupoecs, grupoeds, grupopcs, grupopds," + ;
                       " moedas, movtits, notas, ordem, tipos, titbans, usualts," + ;
                       " usuincs, chkempds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cComandos)  + "," + ;
                       EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       "NULL," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cDopes)     + "," + ;
                       EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       EscaparSQL(THIS.this_cNotas)     + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       EscaparSQL(THIS.this_cTipos)     + "," + ;
                       EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       EscaparSQL(THIS.this_cUsuIncs)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE sigopfin SET" + ;
                       " codigos   = " + EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       " comandos  = " + EscaparSQL(THIS.this_cComandos)  + "," + ;
                       " contaacs  = " + EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       " contaads  = " + EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       " contaccs  = " + EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       " contacds  = " + EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       " contaecs  = " + EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       " contaeds  = " + EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       " contapcs  = " + EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       " contapds  = " + EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       " datalts   = GETDATE()," + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)     + "," + ;
                       " grupoacs  = " + EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       " grupoads  = " + EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       " grupoccs  = " + EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       " grupocds  = " + EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       " grupoecs  = " + EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       " grupoeds  = " + EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       " grupopcs  = " + EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       " grupopds  = " + EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       " moedas    = " + EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       " movtits   = " + EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       " notas     = " + EscaparSQL(THIS.this_cNotas)     + "," + ;
                       " ordem     = " + FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + "," + ;
                       " titbans   = " + EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       " usualts   = " + EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       " chkempds  = " + FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

