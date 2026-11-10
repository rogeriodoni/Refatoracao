# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3702 linhas total):

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

*-- Linhas 411 a 495:
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
430:             SET NULL ON
431:             CREATE CURSOR cursor_4c_GrdValores ;
432:                 (Ordem N(3), Codigos C(10), Descrs C(100), Dopes C(20), ;
433:                  Notas M, Comandos M, Moedas C(3), Tipos C(1), TitBans C(12), ;
434:                  UsuIncs C(10), MovTits C(20), DatIncs T, UsuAlts C(10), ;
435:                  DatAlts T, GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ;
436:                  ContaECs C(11), GrupoPDs C(11), ContaPDs C(11), GrupoPCs C(11), ;
437:                  ContaPCs C(11), GrupoCDs C(11), ContaCDs C(11), GrupoCCs C(11), ;
438:                  ContaCCs C(11), GrupoADs C(11), ContaADs C(11), GrupoACs C(11), ;
439:                  ContaACs C(11))
440:             SET NULL OFF
441:             INDEX ON Ordem TAG Ordem
442:         ENDIF
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas
447:     * 999-1023: ColumnCount=1, Column1.Width=700, Header1.Caption = titulo da
448:     * grade) + os 3 botoes de navegacao/exclusao de linha (btnSetaUp/
449:     * btnSetaDn/btnExcluiGrd, dump linhas 1277-1309 - mesmo Left=739, Top
450:     * escalonado de 40 em 40). O Click dos botoes fica para a
451:     * Fase 7; aqui a montagem visual, o grid ja ligado ao
452:     * cursor_4c_GrdValores criado em CriarCursorGrdValores(), e a celula de
453:     * lookup da coluna Origem instalada por InstalarCelulaOrigem().
454:     *--------------------------------------------------------------------------
455:     PROTECTED PROCEDURE ConfigurarGrid()
456:         LOCAL loc_oGrd, loc_oErro
457: 
458:         TRY
459:             THIS.AddObject("grd_4c_Dados", "Grid")
460:             loc_oGrd = THIS.grd_4c_Dados
461: 
462:             WITH loc_oGrd
463:                 .Top               = 90
464:                 .Left              = 12
465:                 .Width             = 721
466:                 .Height            = 198
467:                 .FontName          = "Tahoma"
468:                 .FontSize          = 8
469:                 .AllowHeaderSizing = .F.
470:                 .AllowRowSizing    = .F.
471:                 .DeleteMark        = .F.
472:                 .RecordMark        = .F.
473:                 .RowHeight         = 16
474:                 .ScrollBars        = 2
475:                 .Highlight         = .T.
476:                 .HighlightStyle    = 2
477:                 .TabIndex          = 1
478:                 .ColumnCount       = 1
479:                 .RecordSource      = "cursor_4c_GrdValores"
480: 
481:                 .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
482:                 .Column1.Width             = 700
483:                 .Column1.FontName          = "Tahoma"
484:                 .Column1.FontSize          = 8
485:                 .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
486:                     CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
487:                 .Column1.Header1.Alignment = 2
488:                 .Column1.Header1.FontBold  = .F.
489: 
490:                 .Visible = .T.
491:             ENDWITH
492: 
493:             *-- Celula de lookup da coluna Origem (TextBoxOrigemSigOpFin_4c).
494:             *-- Vem DEPOIS do ENDWITH que fixa ColumnCount/RecordSource:
495:             *-- atribuir ColumnCount recria os objetos Column e destruiria o

*-- Linhas 549 a 753:
549:         CATCH TO loc_oErro
550:             MsgErro(loc_oErro.Message + CHR(13) + ;
551:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
552:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
553:         ENDTRY
554:     ENDPROC
555: 
556:     *--------------------------------------------------------------------------
557:     * ConfigurarEventosBotoesGrade - BINDEVENT dos 3 botoes de manutencao da
558:     * grade (Click), do AfterRowColChange do proprio grid (Fase 7) e do
559:     * cmd_4c_Sair (Fase 8 - equivalente ao SIGOPFIN.Sair.Click do legado).
560:     *--------------------------------------------------------------------------
561:     PROTECTED PROCEDURE ConfigurarEventosBotoesGrade()
562:         LOCAL loc_oErro
563: 
564:         TRY
565:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
566:                 BINDEVENT(THIS.cmd_4c_BtnSetaUp, "Click", THIS, "BtnSetaUpClick")
567:             ENDIF
568:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
569:                 BINDEVENT(THIS.cmd_4c_BtnSetaDn, "Click", THIS, "BtnSetaDnClick")
570:             ENDIF
571:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
572:                 BINDEVENT(THIS.cmd_4c_BtnExcluiGrd, "Click", THIS, "BtnExcluiGrdClick")
573:             ENDIF
574:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
575:                 BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "AfterRowColChange")
576:             ENDIF
577:             IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
578:                 BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
579:             ENDIF
580:         CATCH TO loc_oErro
581:             MsgErro(loc_oErro.Message + CHR(13) + ;
582:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
583:                 "Procedure: " + loc_oErro.Procedure, ;
584:                 "Erro em ConfigurarEventosBotoesGrade")
585:         ENDTRY
586:     ENDPROC
587: 
588:     *--------------------------------------------------------------------------
589:     * BtnSetaUpClick - equivalente a btnSetaUp.Click do legado: troca a Ordem
590:     * da linha corrente com a anterior. PUBLIC por exigencia do BINDEVENT
591:     * (regra CLAUDE.md #3).
592:     *--------------------------------------------------------------------------
593:     PROCEDURE BtnSetaUpClick()
594:         LOCAL loc_nAtu, loc_oErro
595: 
596:         TRY
597:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
598:                     AND cursor_4c_GrdValores.Ordem > 1 ;
599:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
600:                 THIS.LockScreen = .T.
601:                 loc_nAtu = cursor_4c_GrdValores.Ordem
602: 
603:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
604:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu - 1
605:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu - 1 WHERE Ordem = 999
606:                 UPDATE cursor_4c_GrdValores SET Ordem = Ordem + 1 WHERE Ordem > loc_nAtu
607: 
608:                 =SEEK(loc_nAtu - 1, "cursor_4c_GrdValores")
609: 
610:                 THIS.LockScreen    = .F.
611:                 THIS.this_lAlterou = .T.
612:             ENDIF
613: 
614:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
615:                 THIS.grd_4c_Dados.Refresh()
616:                 THIS.grd_4c_Dados.Column1.SetFocus()
617:                 THIS.grd_4c_Dados.Refresh()
618:             ENDIF
619:         CATCH TO loc_oErro
620:             THIS.LockScreen = .F.
621:             MsgErro(loc_oErro.Message + CHR(13) + ;
622:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
623:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaUpClick")
624:         ENDTRY
625:     ENDPROC
626: 
627:     *--------------------------------------------------------------------------
628:     * BtnSetaDnClick - equivalente a btnSetaDn.Click do legado: troca a Ordem
629:     * da linha corrente com a seguinte.
630:     *--------------------------------------------------------------------------
631:     PROCEDURE BtnSetaDnClick()
632:         LOCAL loc_nAtu, loc_oErro
633: 
634:         TRY
635:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
636:                     AND cursor_4c_GrdValores.Ordem > 1 ;
637:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
638:                 THIS.LockScreen = .T.
639:                 loc_nAtu = cursor_4c_GrdValores.Ordem
640: 
641:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
642:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu + 1
643:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu + 1 WHERE Ordem = 999
644: 
645:                 =SEEK(loc_nAtu + 1, "cursor_4c_GrdValores")
646: 
647:                 THIS.LockScreen    = .F.
648:                 THIS.this_lAlterou = .T.
649:             ENDIF
650: 
651:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
652:                 THIS.grd_4c_Dados.Refresh()
653:                 THIS.grd_4c_Dados.Column1.SetFocus()
654:                 THIS.grd_4c_Dados.Refresh()
655:             ENDIF
656:         CATCH TO loc_oErro
657:             THIS.LockScreen = .F.
658:             MsgErro(loc_oErro.Message + CHR(13) + ;
659:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
660:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSetaDnClick")
661:         ENDTRY
662:     ENDPROC
663: 
664:     *--------------------------------------------------------------------------
665:     * BtnExcluiGrdClick - equivalente a btnExcluiGrd.Click do legado: pede
666:     * confirmacao e exclui a linha corrente, renumerando a Ordem das
667:     * seguintes.
668:     *--------------------------------------------------------------------------
669:     PROCEDURE BtnExcluiGrdClick()
670:         LOCAL loc_nAtu, loc_oErro
671: 
672:         TRY
673:             IF USED("cursor_4c_GrdValores") AND !EOF("cursor_4c_GrdValores") ;
674:                     AND cursor_4c_GrdValores.Ordem > 0
675:                 IF MsgConfirma("Confirma a Exclus" + CHR(227) + "o da Linha " + ;
676:                         "Selecionada na Grade?", "Exclus" + CHR(227) + "o de " + ;
677:                         "Lan" + CHR(231) + "amento")
678:                     THIS.LockScreen = .T.
679:                     loc_nAtu = cursor_4c_GrdValores.Ordem
680: 
681:                     DELETE IN cursor_4c_GrdValores
682:                     UPDATE cursor_4c_GrdValores SET Ordem = Ordem - 1 WHERE Ordem > loc_nAtu
683: 
684:                     =SEEK(loc_nAtu, "cursor_4c_GrdValores")
685: 
686:                     THIS.LockScreen    = .F.
687:                     THIS.this_lAlterou = .T.
688:                 ENDIF
689:             ENDIF
690: 
691:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
692:                 THIS.grd_4c_Dados.Refresh()
693:                 THIS.grd_4c_Dados.Column1.SetFocus()
694:                 THIS.grd_4c_Dados.Refresh()
695:             ENDIF
696:         CATCH TO loc_oErro
697:             THIS.LockScreen = .F.
698:             MsgErro(loc_oErro.Message + CHR(13) + ;
699:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
700:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluiGrdClick")
701:         ENDTRY
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * AfterRowColChange - equivalente ao AfterRowColChange de grdValores no
706:     * legado (dump linhas 2484-2530): repinta os campos de detalhe da linha
707:     * corrente (ja ligados por ControlSource direto a cursor_4c_GrdValores,
708:     * que nao repintam sozinhos ao trocar de linha no grid) e recalcula o
709:     * ToolTipText de Grupo/Conta/TitBans/CMoes. PUBLIC por exigencia do
710:     * BINDEVENT (regra CLAUDE.md #3); tambem chamado diretamente por
711:     * MontaGrade() apos a carga inicial.
712:     *--------------------------------------------------------------------------
713:     PROCEDURE AfterRowColChange(par_nColIndex)
714:         LOCAL loc_oErro
715: 
716:         TRY
717:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
718:                 THIS.txt_4c_GrupoEDs.Refresh()
719:                 THIS.txt_4c_ContaEDs.Refresh()
720:                 THIS.txt_4c_GrupoECs.Refresh()
721:                 THIS.txt_4c_ContaECs.Refresh()
722:                 THIS.txt_4c_GrupoPDs.Refresh()
723:                 THIS.txt_4c_ContaPDs.Refresh()
724:                 THIS.txt_4c_GrupoPCs.Refresh()
725:                 THIS.txt_4c_ContaPCs.Refresh()
726: 
727:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoEDs", "txt_4c_ContaEDs")
728:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoECs", "txt_4c_ContaECs")
729:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPDs", "txt_4c_ContaPDs")
730:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoPCs", "txt_4c_ContaPCs")
731:             ENDIF
732: 
733:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
734:                 THIS.txt_4c_GrupoCDs.Refresh()
735:                 THIS.txt_4c_ContaCDs.Refresh()
736:                 THIS.txt_4c_GrupoCCs.Refresh()
737:                 THIS.txt_4c_ContaCCs.Refresh()
738:                 THIS.txt_4c_GrupoADs.Refresh()
739:                 THIS.txt_4c_ContaADs.Refresh()
740:                 THIS.txt_4c_GrupoACs.Refresh()
741:                 THIS.txt_4c_ContaACs.Refresh()
742: 
743:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCDs", "txt_4c_ContaCDs")
744:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoCCs", "txt_4c_ContaCCs")
745:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoADs", "txt_4c_ContaADs")
746:                 THIS.AtualizarTooltipGrupoConta("txt_4c_GrupoACs", "txt_4c_ContaACs")
747:             ENDIF
748: 
749:             IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
750:                 THIS.txt_4c_TitBans.Refresh()
751:                 THIS.txt_4c_MovTits.Refresh()
752:                 THIS.txt_4c_CMoes.Refresh()
753:                 THIS.txt_4c_Tipos.Refresh()

*-- Linhas 763 a 878:
763:         CATCH TO loc_oErro
764:             MsgErro(loc_oErro.Message + CHR(13) + ;
765:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
766:                 "Procedure: " + loc_oErro.Procedure, "Erro em AfterRowColChange")
767:         ENDTRY
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------
771:     * AtualizarTooltipGrupoConta - ToolTipText dos pares Grupo/Conta de uma
772:     * linha de detalhe (Emissor/Portador/Centro de Custo/Agente Cobrador).
773:     * Legado: "Seek(Padr(Value,10), [crLstCdGcr|crLstCdCli], [Codigos])" -
774:     * crLstCdGcr/crLstCdCli eram cursores locais montados por
775:     * fSigOpFin_Tabs() (fora do acervo); aqui a descricao vem direto das
776:     * tabelas reais (SigCdGcr/SigCdCli), ja usadas pelos pickers desses
777:     * mesmos campos (AbrirLookupGrupoExec/AbrirLookupContaExec).
778:     *--------------------------------------------------------------------------
779:     PROTECTED PROCEDURE AtualizarTooltipGrupoConta(par_cCampoGrupo, par_cCampoConta)
780:         LOCAL loc_oGrupo, loc_oConta, loc_cCodigo, loc_cDescricao
781: 
782:         IF PEMSTATUS(THIS, par_cCampoGrupo, 5)
783:             loc_oGrupo = EVALUATE("THIS." + par_cCampoGrupo)
784:             loc_oGrupo.ToolTipText = "Campo Em Branco"
785:             loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oGrupo.Value)), 10)
786:             IF !EMPTY(loc_cCodigo)
787:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdGcr", "codigos", "descrs", loc_cCodigo)
788:                 IF !EMPTY(loc_cDescricao)
789:                     loc_oGrupo.ToolTipText = loc_cDescricao
790:                 ENDIF
791:             ENDIF
792:         ENDIF
793: 
794:         IF PEMSTATUS(THIS, par_cCampoConta, 5)
795:             loc_oConta = EVALUATE("THIS." + par_cCampoConta)
796:             loc_oConta.ToolTipText = "Campo Em Branco"
797:             loc_cCodigo = LEFT(ALLTRIM(TRANSFORM(loc_oConta.Value)), 10)
798:             IF !EMPTY(loc_cCodigo)
799:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdCli", "iclis", "rclis", loc_cCodigo)
800:                 IF !EMPTY(loc_cDescricao)
801:                     loc_oConta.ToolTipText = loc_cDescricao
802:                 ENDIF
803:             ENDIF
804:         ENDIF
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * AtualizarTooltipTitBans - ToolTipText do Titulo Banco. Legado:
809:     * "Seek(Padr(Value,12), [crLstTitBc], [Codigos])" - crLstTitBc e o mesmo
810:     * cursor local sem equivalente no acervo (regra ja documentada em
811:     * AbrirLookupTituloBancoExec). Sem MsgAviso aqui: no legado este trecho
812:     * tambem e silencioso quando nao acha - so o tooltip fica no default.
813:     *--------------------------------------------------------------------------
814:     PROTECTED PROCEDURE AtualizarTooltipTitBans()
815:         LOCAL loc_oTxt, loc_cValor
816: 
817:         IF PEMSTATUS(THIS, "txt_4c_TitBans", 5)
818:             loc_oTxt = THIS.txt_4c_TitBans
819:             loc_oTxt.ToolTipText = "Campo Em Branco"
820:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 12)
821: 
822:             IF !EMPTY(loc_cValor) AND THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
823:                 SELECT crLstTitBc
824:                 GO TOP IN crLstTitBc
825:                 LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == UPPER(loc_cValor)
826:                 IF !EOF("crLstTitBc")
827:                     loc_oTxt.ToolTipText = ALLTRIM(TratarNulo(crLstTitBc.Descrs, ""))
828:                 ENDIF
829:             ENDIF
830:         ENDIF
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * AtualizarTooltipMoeda - ToolTipText da Moeda de Conversao. Legado:
835:     * "Seek(Padr(Value,3), [crLstMoeda], [Codigos])" - tabela real SigCdMoe
836:     * (cmoes/dmoes), ja usada por AbrirLookupMoedaExec.
837:     *--------------------------------------------------------------------------
838:     PROTECTED PROCEDURE AtualizarTooltipMoeda()
839:         LOCAL loc_oTxt, loc_cValor, loc_cDescricao
840: 
841:         IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
842:             loc_oTxt = THIS.txt_4c_CMoes
843:             loc_oTxt.ToolTipText = "Campo Em Branco"
844:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 3)
845: 
846:             IF !EMPTY(loc_cValor)
847:                 loc_cDescricao = THIS.ObterDescricaoPorCodigo("SigCdMoe", "cmoes", "dmoes", loc_cValor)
848:                 IF !EMPTY(loc_cDescricao)
849:                     loc_oTxt.ToolTipText = loc_cDescricao
850:                 ENDIF
851:             ENDIF
852:         ENDIF
853:     ENDPROC
854: 
855:     *--------------------------------------------------------------------------
856:     * ObterDescricaoPorCodigo - SELECT TOP 1 pontual para ToolTipText (nao ha
857:     * cursor local cacheado para Grupo/Conta/Moeda, como havia no legado via
858:     * fSigOpFin_Tabs). Sem conexao (modo de teste/validacao de UI) devolve
859:     * "" em silencio - o ToolTipText fica no default "Campo Em Branco".
860:     *--------------------------------------------------------------------------
861:     PROTECTED FUNCTION ObterDescricaoPorCodigo(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cValor)
862:         LOCAL loc_cDescricao, loc_cSQL, loc_nResultado, loc_cCursorTmp
863:         loc_cDescricao = ""
864:         loc_cCursorTmp = "cursor_4c_TooltipTmp"
865: 
866:         IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor)) ;
867:                 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 ;
868:                 AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
869:             THIS.FecharCursorTemporario(loc_cCursorTmp)
870: 
871:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
872:                 " WHERE " + par_cCampoCod + " = " + EscaparSQL(ALLTRIM(par_cValor))
873: 
874:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)
875: 
876:             IF loc_nResultado > 0 AND USED(loc_cCursorTmp) AND RECCOUNT(loc_cCursorTmp) > 0
877:                 loc_cDescricao = ALLTRIM(TratarNulo( ;
878:                     EVALUATE(loc_cCursorTmp + "." + par_cCampoDesc), ""))

*-- Linhas 899 a 957:
899:     * Cada TextBox e ligado via ControlSource direto a
900:     * cursor_4c_GrdValores.<Campo> (mesmo padrao do montagrades legado -
901:     * ThisForm.getGrupoEDs.ControlSource = [crGrdValores.GrupoEDs] - dump em
902:     * comportamento.json, metodo "SIGOPFIN.Procedure"): como o TextBox fica
903:     * FORA do grid mas ligado ao MESMO alias, ele reflete e edita a mesma
904:     * linha corrente que o grid exibe (mestre-detalhe por cursor compartilhado,
905:     * nao FormParaBO/BOParaForm). O religamento e repetido em MontaGrade()
906:     * (ver comentario la) para o caso de o cursor ser recriado.
907:     *
908:     * Nomes de objeto: o mapeamento.json colide "txt_4c_Grupo" para TODOS os
909:     * getGrupo<X><D|C>s (06 controles diferentes gerando o mesmo nome) -
910:     * usar esse nome causaria "object already exists" a cada AddObject
911:     * seguinte. Usa-se aqui o nome com o sufixo completo do legado
912:     * (txt_4c_GrupoEDs, txt_4c_ContaEDs, ...), unico por controle.
913:     *
914:     * MaxLength = 11 vem do schema (grupoeds/contaeds/... char(11) - ver
915:     * comentarios de sigopfinBO.prg), nao do Width em pixels (regra #19).
916:     *--------------------------------------------------------------------------
917:     PROTECTED PROCEDURE ConfigurarCamposGrupoContaEmissorPortador()
918:         LOCAL loc_oErro
919: 
920:         TRY
921:             *-- Cabecalhos de coluna - uma unica vez, acima das 4 linhas.
922:             THIS.AddObject("lbl_4c_Label14", "Label")
923:             WITH THIS.lbl_4c_Label14
924:                 .FontName  = "Tahoma"
925:                 .FontSize  = 8
926:                 .FontBold  = .T.
927:                 .BackStyle = 0
928:                 .Alignment = 0
929:                 .AutoSize  = .F.
930:                 .Top       = 454
931:                 .Left      = 184
932:                 .Width     = 60
933:                 .Height    = 17
934:                 .ForeColor = RGB(90, 90, 90)
935:                 .Caption   = "D" + CHR(233) + "bito [D]"
936:                 .Visible   = .T.
937:             ENDWITH
938: 
939:             THIS.AddObject("lbl_4c_Label15", "Label")
940:             WITH THIS.lbl_4c_Label15
941:                 .FontName  = "Tahoma"
942:                 .FontSize  = 8
943:                 .FontBold  = .T.
944:                 .BackStyle = 0
945:                 .Alignment = 0
946:                 .AutoSize  = .F.
947:                 .Top       = 454
948:                 .Left      = 362
949:                 .Width     = 63
950:                 .Height    = 17
951:                 .ForeColor = RGB(90, 90, 90)
952:                 .Caption   = "Cr" + CHR(233) + "dito [C]"
953:                 .Visible   = .T.
954:             ENDWITH
955: 
956:             THIS.AddObject("lbl_4c_Label5", "Label")
957:             WITH THIS.lbl_4c_Label5

*-- Linhas 1170 a 1230:
1170:         CATCH TO loc_oErro
1171:             MsgErro(loc_oErro.Message + CHR(13) + ;
1172:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1173:                 "Procedure: " + loc_oErro.Procedure, ;
1174:                 "Erro em ConfigurarCamposGrupoContaEmissorPortador")
1175:         ENDTRY
1176:     ENDPROC
1177: 
1178:     *--------------------------------------------------------------------------
1179:     * ConfigurarCamposCentroCustoAgenteCobrador - parte 2 (complementar a
1180:     * Fase 5) dos campos de detalhe da linha corrente da grade: linhas Centro de
1181:     * Custo (getGrupoCDs/getContaCDs/getGrupoCCs/getContaCCs, dump Top=538) e
1182:     * Agente Cobrador (getGrupoADs/getContaADs/getGrupoACs/getContaACs, dump
1183:     * Top=563), com os mesmos Left escalonados (139/220/310/391) e o mesmo
1184:     * padrao de ligacao direta a cursor_4c_GrdValores.<Campo> das linhas
1185:     * Emissor/Portador (ConfigurarCamposGrupoContaEmissorPortador).
1186:     *
1187:     * MaxLength = 11 vem do schema (grupocds/contacds/.../contaacs char(11),
1188:     * mesma largura das colunas de Emissor/Portador), nao do Width em pixels.
1189:     *--------------------------------------------------------------------------
1190:     PROTECTED PROCEDURE ConfigurarCamposCentroCustoAgenteCobrador()
1191:         LOCAL loc_oErro
1192: 
1193:         TRY
1194:             THIS.AddObject("lbl_4c_Label10", "Label")
1195:             WITH THIS.lbl_4c_Label10
1196:                 .FontName  = "Tahoma"
1197:                 .FontSize  = 8
1198:                 .BackStyle = 0
1199:                 .Alignment = 0
1200:                 .AutoSize  = .F.
1201:                 .Top       = 542
1202:                 .Left      = 24
1203:                 .Width     = 92
1204:                 .Height    = 17
1205:                 .ForeColor = RGB(90, 90, 90)
1206:                 .Caption   = "Centro de Custo"
1207:                 .Visible   = .T.
1208:             ENDWITH
1209: 
1210:             THIS.AddObject("lbl_4c_Label11", "Label")
1211:             WITH THIS.lbl_4c_Label11
1212:                 .FontName  = "Tahoma"
1213:                 .FontSize  = 8
1214:                 .BackStyle = 0
1215:                 .Alignment = 0
1216:                 .AutoSize  = .F.
1217:                 .Top       = 567
1218:                 .Left      = 17
1219:                 .Width     = 98
1220:                 .Height    = 17
1221:                 .ForeColor = RGB(90, 90, 90)
1222:                 .Caption   = "Agente Cobrador"
1223:                 .Visible   = .T.
1224:             ENDWITH
1225: 
1226:             *-- Linha Centro de Custo (dump: getGrupoCDs/getContaCDs/
1227:             *-- getGrupoCCs/getContaCCs, Top=538).
1228:             THIS.AddObject("txt_4c_GrupoCDs", "TextBox")
1229:             WITH THIS.txt_4c_GrupoCDs
1230:                 .FontName      = "Tahoma"

*-- Linhas 1341 a 1397:
1341:         CATCH TO loc_oErro
1342:             MsgErro(loc_oErro.Message + CHR(13) + ;
1343:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1344:                 "Procedure: " + loc_oErro.Procedure, ;
1345:                 "Erro em ConfigurarCamposCentroCustoAgenteCobrador")
1346:         ENDTRY
1347:     ENDPROC
1348: 
1349:     *--------------------------------------------------------------------------
1350:     * ConfigurarCamposComplementares - os 4 campos restantes da coluna
1351:     * direita do dump (txt_4c_CMoes/TitBans/Tipos/MovTits, equivalentes a
1352:     * getCMoes/getTitBans/getTipos/getMovTits), com o mesmo padrao de
1353:     * ligacao direta a cursor_4c_GrdValores.<Campo> dos demais campos de
1354:     * detalhe da linha corrente. MaxLength vem do schema (moedas char(3),
1355:     * titbans char(12), tipos char(1), movtits char(20)).
1356:     *--------------------------------------------------------------------------
1357:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
1358:         LOCAL loc_oErro
1359: 
1360:         TRY
1361:             THIS.AddObject("lbl_4c_Label12", "Label")
1362:             WITH THIS.lbl_4c_Label12
1363:                 .FontName  = "Tahoma"
1364:                 .FontSize  = 8
1365:                 .BackStyle = 0
1366:                 .Alignment = 0
1367:                 .AutoSize  = .F.
1368:                 .Top       = 238
1369:                 .Left      = 744
1370:                 .Width     = 160
1371:                 .Height    = 17
1372:                 .ForeColor = RGB(90, 90, 90)
1373:                 .Caption   = "Inibir Lan" + CHR(231) + "amentos de:"
1374:                 .Visible   = .T.
1375:             ENDWITH
1376: 
1377:             THIS.AddObject("lbl_4c_Label3", "Label")
1378:             WITH THIS.lbl_4c_Label3
1379:                 .FontName  = "Tahoma"
1380:                 .FontSize  = 8
1381:                 .BackStyle = 0
1382:                 .Alignment = 0
1383:                 .AutoSize  = .F.
1384:                 .Top       = 309
1385:                 .Left      = 744
1386:                 .Width     = 140
1387:                 .Height    = 17
1388:                 .ForeColor = RGB(90, 90, 90)
1389:                 .Caption   = "Moeda de Convers" + CHR(227) + "o"
1390:                 .Visible   = .T.
1391:             ENDWITH
1392: 
1393:             THIS.AddObject("txt_4c_CMoes", "TextBox")
1394:             WITH THIS.txt_4c_CMoes
1395:                 .FontName      = "Tahoma"
1396:                 .FontSize      = 8
1397:                 .Top           = 325

*-- Linhas 1496 a 1560:
1496:         CATCH TO loc_oErro
1497:             MsgErro(loc_oErro.Message + CHR(13) + ;
1498:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1499:                 "Procedure: " + loc_oErro.Procedure, ;
1500:                 "Erro em ConfigurarCamposComplementares")
1501:         ENDTRY
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
1506:     * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
1507:     * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
1508:     * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
1509:     * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
1510:     *
1511:     * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
1512:     * declara Value="0" literal) e NAO ha coluna correspondente nem em
1513:     * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
1514:     * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
1515:     * corresponde) - ficam como estado de tela, sem ControlSource inventado
1516:     * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
1517:     * de dirty-tracking (This.Tag <-> This.Value, que so seta
1518:     * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
1519:     *--------------------------------------------------------------------------
1520:     PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
1521:         LOCAL loc_oErro
1522: 
1523:         TRY
1524:             THIS.AddObject("lbl_4c_Label1", "Label")
1525:             WITH THIS.lbl_4c_Label1
1526:                 .FontName  = "Tahoma"
1527:                 .FontSize  = 8
1528:                 .BackStyle = 0
1529:                 .Alignment = 0
1530:                 .AutoSize  = .F.
1531:                 .Top       = 294
1532:                 .Left      = 12
1533:                 .Width     = 900
1534:                 .Height    = 17
1535:                 .ForeColor = RGB(90, 90, 90)
1536:                 .Caption   = "Notas Sobre a Configura" + CHR(231) + CHR(227) + ;
1537:                     "o (obrigat" + CHR(243) + "rio descrever o m" + CHR(225) + ;
1538:                     "ximo poss" + CHR(237) + "vel a finalidade do lan" + CHR(231) + "amento)"
1539:                 .Visible   = .T.
1540:             ENDWITH
1541: 
1542:             THIS.AddObject("obj_4c_GetNotas", "EditBox")
1543:             WITH THIS.obj_4c_GetNotas
1544:                 .FontName      = "Tahoma"
1545:                 .FontSize      = 8
1546:                 .Top           = 311
1547:                 .Left          = 12
1548:                 .Width         = 721
1549:                 .Height        = 131
1550:                 .ScrollBars    = 2
1551:                 .TabIndex      = 25
1552:                 .ControlSource = "cursor_4c_GrdValores.Notas"
1553:                 .Visible       = .T.
1554:             ENDWITH
1555: 
1556:             THIS.AddObject("lbl_4c_Label2", "Label")
1557:             WITH THIS.lbl_4c_Label2
1558:                 .FontName  = "Tahoma"
1559:                 .FontSize  = 8
1560:                 .BackStyle = 0

*-- Linhas 1617 a 2285:
1617:         CATCH TO loc_oErro
1618:             MsgErro(loc_oErro.Message + CHR(13) + ;
1619:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1620:                 "Procedure: " + loc_oErro.Procedure, ;
1621:                 "Erro em ConfigurarMemosEcheckboxes")
1622:         ENDTRY
1623:     ENDPROC
1624: 
1625:     *--------------------------------------------------------------------------
1626:     * ConfigurarEventosLookup - liga por BINDEVENT os campos que tem lookup no
1627:     * legado. Cada campo usa UM unico handler ligado aos tres eventos:
1628:     *
1629:     *   "LostFocus" - equivalente ao Valid do legado (o legado abre o picker
1630:     *                 ao SAIR do campo). NUNCA "KeyPress" sozinho: handler que
1631:     *                 abre picker so por o campo nao estar vazio dispararia o
1632:     *                 dialogo a CADA TECLA e o usuario nao conseguiria terminar
1633:     *                 de digitar o codigo (regra CLAUDE.md #47).
1634:     *   "KeyPress"  - atalho F4/F5 (convencao do sistema novo). O handler TESTA
1635:     *                 a tecla antes de abrir - sem o teste o picker subiria no
1636:     *                 primeiro caractere.
1637:     *   "DblClick"  - atalho de mouse (convencao do sistema novo).
1638:     *
1639:     * O MESMO handler atende aos tres porque BINDEVENT repassa os parametros do
1640:     * evento: em KeyPress chegam 2 (PCOUNT() = 2), em LostFocus/DblClick nenhum
1641:     * (PCOUNT() = 0). O handler so aplica o filtro de tecla quando de fato
1642:     * recebeu uma - handler SEM parametro ligado a KeyPress eh que estoura
1643:     * (regra CLAUDE.md #3), o inverso e seguro.
1644:     *
1645:     * Todos os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo
1646:     * PROTECTED falha em silencio (regra CLAUDE.md #3).
1647:     *--------------------------------------------------------------------------
1648:     PROTECTED PROCEDURE ConfigurarEventosLookup()
1649:         LOCAL loc_oErro
1650: 
1651:         TRY
1652:             *-- Grupo (8 campos) e Conta (8 campos) das 4 linhas
1653:             *-- Emissor/Portador/Centro de Custo/Agente Cobrador.
1654:             THIS.LigarEventosLookup("txt_4c_GrupoEDs", "GrupoEDsLookup")
1655:             THIS.LigarEventosLookup("txt_4c_ContaEDs", "ContaEDsLookup")
1656:             THIS.LigarEventosLookup("txt_4c_GrupoECs", "GrupoECsLookup")
1657:             THIS.LigarEventosLookup("txt_4c_ContaECs", "ContaECsLookup")
1658:             THIS.LigarEventosLookup("txt_4c_GrupoPDs", "GrupoPDsLookup")
1659:             THIS.LigarEventosLookup("txt_4c_ContaPDs", "ContaPDsLookup")
1660:             THIS.LigarEventosLookup("txt_4c_GrupoPCs", "GrupoPCsLookup")
1661:             THIS.LigarEventosLookup("txt_4c_ContaPCs", "ContaPCsLookup")
1662:             THIS.LigarEventosLookup("txt_4c_GrupoCDs", "GrupoCDsLookup")
1663:             THIS.LigarEventosLookup("txt_4c_ContaCDs", "ContaCDsLookup")
1664:             THIS.LigarEventosLookup("txt_4c_GrupoCCs", "GrupoCCsLookup")
1665:             THIS.LigarEventosLookup("txt_4c_ContaCCs", "ContaCCsLookup")
1666:             THIS.LigarEventosLookup("txt_4c_GrupoADs", "GrupoADsLookup")
1667:             THIS.LigarEventosLookup("txt_4c_ContaADs", "ContaADsLookup")
1668:             THIS.LigarEventosLookup("txt_4c_GrupoACs", "GrupoACsLookup")
1669:             THIS.LigarEventosLookup("txt_4c_ContaACs", "ContaACsLookup")
1670: 
1671:             *-- Demais campos com Valid de lookup no dump legado.
1672:             THIS.LigarEventosLookup("txt_4c_CMoes",   "CMoesLookup")
1673:             THIS.LigarEventosLookup("txt_4c_TitBans", "TitBansLookup")
1674:             THIS.LigarEventosLookup("txt_4c_MovTits", "MovTitsLookup")
1675:         CATCH TO loc_oErro
1676:             MsgErro(loc_oErro.Message + CHR(13) + ;
1677:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1678:                 "Procedure: " + loc_oErro.Procedure, ;
1679:                 "Erro em ConfigurarEventosLookup")
1680:         ENDTRY
1681:     ENDPROC
1682: 
1683:     *--------------------------------------------------------------------------
1684:     * LigarEventosLookup - liga os 3 eventos de UM campo ao seu handler.
1685:     * O controle e alcancado por EVALUATE (nome montado em tempo de execucao):
1686:     * Controls eh indexado por NUMERO, passar o NOME estoura em runtime
1687:     * (regra CLAUDE.md #34), e EVALUATE eh a forma canonica de LEITURA de
1688:     * membro por nome (regra CLAUDE.md #15).
1689:     *--------------------------------------------------------------------------
1690:     PROTECTED PROCEDURE LigarEventosLookup(par_cCampo, par_cHandler)
1691:         LOCAL loc_oTxt
1692: 
1693:         IF PEMSTATUS(THIS, par_cCampo, 5)
1694:             loc_oTxt = EVALUATE("THIS." + par_cCampo)
1695:             IF VARTYPE(loc_oTxt) = "O"
1696:                 BINDEVENT(loc_oTxt, "LostFocus", THIS, par_cHandler)
1697:                 BINDEVENT(loc_oTxt, "KeyPress",  THIS, par_cHandler)
1698:                 BINDEVENT(loc_oTxt, "DblClick",  THIS, par_cHandler)
1699:             ENDIF
1700:         ENDIF
1701:     ENDPROC
1702: 
1703:     *--------------------------------------------------------------------------
1704:     * TeclaAbreLookup - .T. quando o handler deve abrir o picker.
1705:     *
1706:     * Chamado com os parametros que o evento entregou: em LostFocus/DblClick
1707:     * nao vem nenhum (PCOUNT() = 0 no handler -> par_nKeyCode chega como .F.)
1708:     * e o lookup roda, que e o comportamento do Valid legado; em KeyPress vem
1709:     * o codigo da tecla e so F4 (115) e F5 (116) abrem.
1710:     *--------------------------------------------------------------------------
1711:     PROTECTED FUNCTION TeclaAbreLookup(par_nKeyCode)
1712:         LOCAL loc_lAbre
1713:         loc_lAbre = .T.
1714: 
1715:         IF VARTYPE(par_nKeyCode) = "N"
1716:             loc_lAbre = INLIST(par_nKeyCode, 115, 116)
1717:         ENDIF
1718: 
1719:         RETURN loc_lAbre
1720:     ENDFUNC
1721: 
1722:     *--------------------------------------------------------------------------
1723:     * Handlers de lookup - um por campo, ligado aos 3 eventos.
1724:     * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra CLAUDE.md #3).
1725:     *--------------------------------------------------------------------------
1726:     PROCEDURE GrupoEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1727:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1728:             THIS.AbrirLookupGrupo("txt_4c_GrupoEDs")
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     PROCEDURE GrupoECsLookup(par_nKeyCode, par_nShiftAltCtrl)
1733:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1734:             THIS.AbrirLookupGrupo("txt_4c_GrupoECs")
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     PROCEDURE GrupoPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1739:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1740:             THIS.AbrirLookupGrupo("txt_4c_GrupoPDs")
1741:         ENDIF
1742:     ENDPROC
1743: 
1744:     PROCEDURE GrupoPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1745:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1746:             THIS.AbrirLookupGrupo("txt_4c_GrupoPCs")
1747:         ENDIF
1748:     ENDPROC
1749: 
1750:     PROCEDURE GrupoCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1751:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1752:             THIS.AbrirLookupGrupo("txt_4c_GrupoCDs")
1753:         ENDIF
1754:     ENDPROC
1755: 
1756:     PROCEDURE GrupoCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1757:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1758:             THIS.AbrirLookupGrupo("txt_4c_GrupoCCs")
1759:         ENDIF
1760:     ENDPROC
1761: 
1762:     PROCEDURE GrupoADsLookup(par_nKeyCode, par_nShiftAltCtrl)
1763:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1764:             THIS.AbrirLookupGrupo("txt_4c_GrupoADs")
1765:         ENDIF
1766:     ENDPROC
1767: 
1768:     PROCEDURE GrupoACsLookup(par_nKeyCode, par_nShiftAltCtrl)
1769:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1770:             THIS.AbrirLookupGrupo("txt_4c_GrupoACs")
1771:         ENDIF
1772:     ENDPROC
1773: 
1774:     PROCEDURE ContaEDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1775:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1776:             THIS.AbrirLookupConta("txt_4c_ContaEDs")
1777:         ENDIF
1778:     ENDPROC
1779: 
1780:     PROCEDURE ContaECsLookup(par_nKeyCode, par_nShiftAltCtrl)
1781:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1782:             THIS.AbrirLookupConta("txt_4c_ContaECs")
1783:         ENDIF
1784:     ENDPROC
1785: 
1786:     PROCEDURE ContaPDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1787:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1788:             THIS.AbrirLookupConta("txt_4c_ContaPDs")
1789:         ENDIF
1790:     ENDPROC
1791: 
1792:     PROCEDURE ContaPCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1793:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1794:             THIS.AbrirLookupConta("txt_4c_ContaPCs")
1795:         ENDIF
1796:     ENDPROC
1797: 
1798:     PROCEDURE ContaCDsLookup(par_nKeyCode, par_nShiftAltCtrl)
1799:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1800:             THIS.AbrirLookupConta("txt_4c_ContaCDs")
1801:         ENDIF
1802:     ENDPROC
1803: 
1804:     PROCEDURE ContaCCsLookup(par_nKeyCode, par_nShiftAltCtrl)
1805:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1806:             THIS.AbrirLookupConta("txt_4c_ContaCCs")
1807:         ENDIF
1808:     ENDPROC
1809: 
1810:     PROCEDURE ContaADsLookup(par_nKeyCode, par_nShiftAltCtrl)
1811:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1812:             THIS.AbrirLookupConta("txt_4c_ContaADs")
1813:         ENDIF
1814:     ENDPROC
1815: 
1816:     PROCEDURE ContaACsLookup(par_nKeyCode, par_nShiftAltCtrl)
1817:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1818:             THIS.AbrirLookupConta("txt_4c_ContaACs")
1819:         ENDIF
1820:     ENDPROC
1821: 
1822:     PROCEDURE CMoesLookup(par_nKeyCode, par_nShiftAltCtrl)
1823:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1824:             THIS.AbrirLookupMoeda()
1825:         ENDIF
1826:     ENDPROC
1827: 
1828:     PROCEDURE TitBansLookup(par_nKeyCode, par_nShiftAltCtrl)
1829:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1830:             THIS.AbrirLookupTituloBanco()
1831:         ENDIF
1832:     ENDPROC
1833: 
1834:     PROCEDURE MovTitsLookup(par_nKeyCode, par_nShiftAltCtrl)
1835:         IF THIS.TeclaAbreLookup(par_nKeyCode)
1836:             THIS.AbrirLookupMovimentacao()
1837:         ENDIF
1838:     ENDPROC
1839: 
1840:     *--------------------------------------------------------------------------
1841:     * AbrirLookupGrupo - picker de Grupo (legado: getGrupo<X>.Valid, que faz
1842:     * Seek em crLstCdGcr e, nao achando, abre fwBuscaInt com as colunas
1843:     * Codigos/Descrs/Tipos e grava This.Value = Codigos + Tipos).
1844:     *
1845:     * Tabela: SigCdGcr (codigos char(10), descrs char(40)). Confirmada por
1846:     * codigo legado independente - em SIGMVCCR, get_sgrupo recebe
1847:     * crSigCdPam2.grupopags e get_sdgrupo.Value = crSigCdGcr.Descrs apos
1848:     * Seek(..., [crSigCdGcr], [Codigos]).
1849:     *
1850:     * crLstCdGcr era montado por fSigOpFin_Tabs() (SigOpFin.prg legado), que
1851:     * NAO veio no acervo; dele vinha tambem a coluna Tipos, que SigCdGcr nao
1852:     * possui. O 11o caractere do campo (char(11) = Codigos(10) + Tipos(1)) e
1853:     * BRANCO para grupo concreto: SIGMVCMV compara SigOpFin.GrupoECs (char 11)
1854:     * diretamente com SigMvCcr.grupos (char 10), igualdade que no SQL Server so
1855:     * se sustenta com o 11o caractere em branco. Por isso o valor gravado e
1856:     * PADR(codigo, 10) + " ", reproduzindo a concatenacao do legado.
1857:     *--------------------------------------------------------------------------
1858:     PROCEDURE AbrirLookupGrupo(par_cCampo)
1859:         IF THIS.this_lEmLookup
1860:             RETURN
1861:         ENDIF
1862: 
1863:         THIS.this_lEmLookup = .T.
1864:         THIS.AbrirLookupGrupoExec(par_cCampo)
1865:         THIS.this_lEmLookup = .F.
1866:     ENDPROC
1867: 
1868:     *--------------------------------------------------------------------------
1869:     * AbrirLookupGrupoExec - corpo do lookup de Grupo. Separado do wrapper
1870:     * acima porque o corpo tem saidas antecipadas: com set/clear da flag no
1871:     * mesmo metodo, uma saida antecipada deixaria this_lEmLookup ligada para
1872:     * sempre e mataria o lookup pelo resto da vida do form (CLAUDE.md #47).
1873:     *--------------------------------------------------------------------------
1874:     PROTECTED PROCEDURE AbrirLookupGrupoExec(par_cCampo)
1875:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
1876:         loc_cCursor = "cursor_4c_BuscaGrupo"
1877: 
1878:         TRY
1879:             loc_oTxt = THIS.ObterCampoLookup(par_cCampo)
1880: 
1881:             IF VARTYPE(loc_oTxt) = "O"
1882:                 *-- Legado: "If Not Empty(This.Value)" - campo vazio nao abre
1883:                 *-- picker nenhum (o grupo e opcional na linha).
1884:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
1885: 
1886:                 IF !EMPTY(loc_cValor)
1887:                     THIS.FecharCursorTemporario(loc_cCursor)
1888: 
1889:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1890:                         "SigCdGcr", loc_cCursor, "codigos", LEFT(loc_cValor, 10), ;
1891:                         "Grupos")
1892: 
1893:                     IF VARTYPE(loc_oBusca) = "O"
1894:                         *-- O Init ja tentou o match EXATO: achando 1 registro
1895:                         *-- ele resolve sozinho e o dialogo NAO deve aparecer
1896:                         *-- (contrato da regra CLAUDE.md #37, equivalente ao
1897:                         *-- "If Not Seek(...)" do legado).
1898:                         IF !loc_oBusca.this_lAchouRegistro
1899:                             loc_oBusca.mAddColuna("codigos", "", "Grupo")
1900:                             loc_oBusca.mAddColuna("descrs",  "", ;
1901:                                 "Descri" + CHR(231) + CHR(227) + "o")
1902:                             loc_oBusca.Show()
1903:                         ENDIF
1904: 
1905:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1906:                             SELECT (loc_cCursor)
1907:                             IF !EOF(loc_cCursor)
1908:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1909:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.codigos, "")), 10) + " ", ;
1910:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.descrs, "")))
1911:                             ENDIF
1912:                         ENDIF
1913: 
1914:                         loc_oBusca.Release()
1915:                     ENDIF
1916: 
1917:                     THIS.FecharCursorTemporario(loc_cCursor)
1918:                 ENDIF
1919:             ENDIF
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message + CHR(13) + ;
1922:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1923:                 "Procedure: " + loc_oErro.Procedure, ;
1924:                 "Erro em AbrirLookupGrupoExec")
1925:         ENDTRY
1926:     ENDPROC
1927: 
1928:     *--------------------------------------------------------------------------
1929:     * AbrirLookupConta - picker de Conta (legado: getConta<X>.Valid, que faz
1930:     * Seek em crLstCdCli e grava This.Value = Codigos + Tipos).
1931:     *
1932:     * Tabela: SigCdCli (iclis char(10) = codigo da conta, rclis char(50) =
1933:     * descricao). Confirmada por codigo legado independente - em SIGMVCCR,
1934:     * get_sCONTA recebe crSigCdPam2.contapags e get_sdCONTA.Value =
1935:     * crSigCdCli.RClis. Mesma regra do 11o caractere em branco do
1936:     * AbrirLookupGrupo.
1937:     *
1938:     * O legado NAO filtra a lista de contas pelo grupo da mesma linha
1939:     * (crLstCdCli e a lista inteira) - nenhum filtro e acrescentado aqui.
1940:     *--------------------------------------------------------------------------
1941:     PROCEDURE AbrirLookupConta(par_cCampo)
1942:         IF THIS.this_lEmLookup
1943:             RETURN
1944:         ENDIF
1945: 
1946:         THIS.this_lEmLookup = .T.
1947:         THIS.AbrirLookupContaExec(par_cCampo)
1948:         THIS.this_lEmLookup = .F.
1949:     ENDPROC
1950: 
1951:     PROTECTED PROCEDURE AbrirLookupContaExec(par_cCampo)
1952:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
1953:         loc_cCursor = "cursor_4c_BuscaConta"
1954: 
1955:         TRY
1956:             loc_oTxt = THIS.ObterCampoLookup(par_cCampo)
1957: 
1958:             IF VARTYPE(loc_oTxt) = "O"
1959:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
1960: 
1961:                 IF !EMPTY(loc_cValor)
1962:                     THIS.FecharCursorTemporario(loc_cCursor)
1963: 
1964:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1965:                         "SigCdCli", loc_cCursor, "iclis", LEFT(loc_cValor, 10), ;
1966:                         "Contas")
1967: 
1968:                     IF VARTYPE(loc_oBusca) = "O"
1969:                         IF !loc_oBusca.this_lAchouRegistro
1970:                             loc_oBusca.mAddColuna("iclis", "", "Conta")
1971:                             loc_oBusca.mAddColuna("rclis", "", ;
1972:                                 "Descri" + CHR(231) + CHR(227) + "o")
1973:                             loc_oBusca.Show()
1974:                         ENDIF
1975: 
1976:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1977:                             SELECT (loc_cCursor)
1978:                             IF !EOF(loc_cCursor)
1979:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1980:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaConta.iclis, "")), 10) + " ", ;
1981:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaConta.rclis, "")))
1982:                             ENDIF
1983:                         ENDIF
1984: 
1985:                         loc_oBusca.Release()
1986:                     ENDIF
1987: 
1988:                     THIS.FecharCursorTemporario(loc_cCursor)
1989:                 ENDIF
1990:             ENDIF
1991:         CATCH TO loc_oErro
1992:             MsgErro(loc_oErro.Message + CHR(13) + ;
1993:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1994:                 "Procedure: " + loc_oErro.Procedure, ;
1995:                 "Erro em AbrirLookupContaExec")
1996:         ENDTRY
1997:     ENDPROC
1998: 
1999:     *--------------------------------------------------------------------------
2000:     * AbrirLookupMoeda - picker de Moeda de Conversao (legado: getCMoes.Valid,
2001:     * Seek em crLstMoeda e This.Value = crLstMoeda.Codigos - sem concatenar
2002:     * Tipos, por isso aqui o valor e o codigo puro, char(3)).
2003:     *
2004:     * Tabela: SigCdMoe (cmoes char(3), dmoes char(15)).
2005:     *--------------------------------------------------------------------------
2006:     PROCEDURE AbrirLookupMoeda()
2007:         IF THIS.this_lEmLookup
2008:             RETURN
2009:         ENDIF
2010: 
2011:         THIS.this_lEmLookup = .T.
2012:         THIS.AbrirLookupMoedaExec()
2013:         THIS.this_lEmLookup = .F.
2014:     ENDPROC
2015: 
2016:     PROTECTED PROCEDURE AbrirLookupMoedaExec()
2017:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
2018:         loc_cCursor = "cursor_4c_BuscaMoeda"
2019: 
2020:         TRY
2021:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_CMoes")
2022: 
2023:             IF VARTYPE(loc_oTxt) = "O"
2024:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2025: 
2026:                 IF !EMPTY(loc_cValor)
2027:                     THIS.FecharCursorTemporario(loc_cCursor)
2028: 
2029:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2030:                         "SigCdMoe", loc_cCursor, "cmoes", LEFT(loc_cValor, 3), ;
2031:                         "Moedas")
2032: 
2033:                     IF VARTYPE(loc_oBusca) = "O"
2034:                         IF !loc_oBusca.this_lAchouRegistro
2035:                             loc_oBusca.mAddColuna("cmoes", "", "Moeda")
2036:                             loc_oBusca.mAddColuna("dmoes", "", ;
2037:                                 "Descri" + CHR(231) + CHR(227) + "o")
2038:                             loc_oBusca.Show()
2039:                         ENDIF
2040: 
2041:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2042:                             SELECT (loc_cCursor)
2043:                             IF !EOF(loc_cCursor)
2044:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2045:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.cmoes, "")), ;
2046:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.dmoes, "")))
2047:                             ENDIF
2048:                         ENDIF
2049: 
2050:                         loc_oBusca.Release()
2051:                     ENDIF
2052: 
2053:                     THIS.FecharCursorTemporario(loc_cCursor)
2054:                 ENDIF
2055:             ENDIF
2056:         CATCH TO loc_oErro
2057:             MsgErro(loc_oErro.Message + CHR(13) + ;
2058:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2059:                 "Procedure: " + loc_oErro.Procedure, ;
2060:                 "Erro em AbrirLookupMoedaExec")
2061:         ENDTRY
2062:     ENDPROC
2063: 
2064:     *--------------------------------------------------------------------------
2065:     * AbrirLookupMovimentacao - picker de Movimentacao de Titulos (legado:
2066:     * getMovTits.Valid). E o unico lookup REMOTO do dump - o legado chama
2067:     * CreateObject([fwBuscaExt], ..., [SigOpOpe], [crListaRemota], [Dopes],
2068:     * This.Value, [Selecao], .t.) e adiciona UMA unica coluna, Dopes.
2069:     *
2070:     * Tabela e campo transcritos do dump, nao deduzidos. Coluna unica: em
2071:     * SigOpOpe, Dopes char(20) e ao mesmo tempo a chave e o texto exibido.
2072:     *
2073:     * O legado grava This.Value = crListaRemota.Dopes INCONDICIONALMENTE (ou
2074:     * seja, tambem quando o usuario cancela, o que zera o campo). Aqui o valor
2075:     * so e aplicado sob this_lSelecionou, que e o contrato do
2076:     * FormBuscaAuxiliar (regra CLAUDE.md #37): cancelar preserva o que o
2077:     * usuario digitou em vez de apaga-lo.
2078:     *--------------------------------------------------------------------------
2079:     PROCEDURE AbrirLookupMovimentacao()
2080:         IF THIS.this_lEmLookup
2081:             RETURN
2082:         ENDIF
2083: 
2084:         THIS.this_lEmLookup = .T.
2085:         THIS.AbrirLookupMovimentacaoExec()
2086:         THIS.this_lEmLookup = .F.
2087:     ENDPROC
2088: 
2089:     PROTECTED PROCEDURE AbrirLookupMovimentacaoExec()
2090:         LOCAL loc_oTxt, loc_cValor, loc_oBusca, loc_oErro, loc_cCursor
2091:         loc_cCursor = "cursor_4c_BuscaMovTit"
2092: 
2093:         TRY
2094:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_MovTits")
2095: 
2096:             IF VARTYPE(loc_oTxt) = "O"
2097:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2098: 
2099:                 IF !EMPTY(loc_cValor)
2100:                     THIS.FecharCursorTemporario(loc_cCursor)
2101: 
2102:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2103:                         "SigOpOpe", loc_cCursor, "Dopes", LEFT(loc_cValor, 20), ;
2104:                         "Sele" + CHR(231) + CHR(227) + "o")
2105: 
2106:                     IF VARTYPE(loc_oBusca) = "O"
2107:                         IF !loc_oBusca.this_lAchouRegistro
2108:                             loc_oBusca.mAddColuna("Dopes", "", ;
2109:                                 "Movimenta" + CHR(231) + CHR(227) + "o")
2110:                             loc_oBusca.Show()
2111:                         ENDIF
2112: 
2113:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2114:                             SELECT (loc_cCursor)
2115:                             IF !EOF(loc_cCursor)
2116:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2117:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMovTit.Dopes, "")), "")
2118:                             ENDIF
2119:                         ENDIF
2120: 
2121:                         loc_oBusca.Release()
2122:                     ENDIF
2123: 
2124:                     THIS.FecharCursorTemporario(loc_cCursor)
2125:                 ENDIF
2126:             ENDIF
2127:         CATCH TO loc_oErro
2128:             MsgErro(loc_oErro.Message + CHR(13) + ;
2129:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2130:                 "Procedure: " + loc_oErro.Procedure, ;
2131:                 "Erro em AbrirLookupMovimentacaoExec")
2132:         ENDTRY
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * AbrirLookupTituloBanco - picker de Titulo Banco (legado:
2137:     * getTitBans.Valid, Seek(Padr(This.Value, 12), [crLstTitBc], [Codigos]) e,
2138:     * nao achando, fwBuscaInt sobre crLstTitBc com as colunas Codigos/Descrs/
2139:     * Tipos).
2140:     *
2141:     * crLstTitBc e um cursor LOCAL montado por fSigOpFin_Tabs() (SigOpFin.prg
2142:     * legado), que NAO veio no acervo - e nao ha, no schema canonico, tabela
2143:     * mestre de Titulo Banco: a coluna titbans char(12) so aparece em
2144:     * SigMvCcr, SigMvCpv e sigopfin, sempre como valor gravado. Por isso a
2145:     * lista NAO e remontada a partir de tabela nenhuma: escolher uma tabela
2146:     * por semelhanca e justamente o que a regra "NUNCA inventar tabelas de
2147:     * lookup que nao existem no original" proibe, e o palpite gravaria codigo
2148:     * errado em silencio.
2149:     *
2150:     * O picker roda portanto sobre o MESMO cursor que o legado le, quando ele
2151:     * estiver aberto na sessao (sera o caso assim que fSigOpFin_Tabs for
2152:     * portada). Nao estando, a ausencia e reportada nomeando a origem legada
2153:     * que falta - e o codigo digitado pelo usuario e PRESERVADO, nunca
2154:     * apagado (regra CLAUDE.md #50).
2155:     *--------------------------------------------------------------------------
2156:     PROCEDURE AbrirLookupTituloBanco()
2157:         IF THIS.this_lEmLookup
2158:             RETURN
2159:         ENDIF
2160: 
2161:         THIS.this_lEmLookup = .T.
2162:         THIS.AbrirLookupTituloBancoExec()
2163:         THIS.this_lEmLookup = .F.
2164:     ENDPROC
2165: 
2166:     PROTECTED PROCEDURE AbrirLookupTituloBancoExec()
2167:         LOCAL loc_oTxt, loc_cValor, loc_oErro
2168: 
2169:         TRY
2170:             loc_oTxt = THIS.ObterCampoLookup("txt_4c_TitBans")
2171: 
2172:             IF VARTYPE(loc_oTxt) = "O"
2173:                 loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2174: 
2175:                 IF !EMPTY(loc_cValor)
2176:                     IF THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
2177:                         *-- Legado: Seek(Padr(This.Value, 12), [crLstTitBc],
2178:                         *-- [Codigos]) - achando exato, nao abre o picker.
2179:                         SELECT crLstTitBc
2180:                         GO TOP IN crLstTitBc
2181:                         LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == ;
2182:                             UPPER(ALLTRIM(LEFT(loc_cValor, 12)))
2183: 
2184:                         IF EOF("crLstTitBc")
2185:                             THIS.MostrarPickerListaLocal("crLstTitBc", ;
2186:                                 "Codigos", "Descrs", ;
2187:                                 "T" + CHR(237) + "tulo Banco")
2188:                         ENDIF
2189: 
2190:                         IF USED("crLstTitBc") AND !EOF("crLstTitBc")
2191:                             THIS.AplicarValorLookup(loc_oTxt, ;
2192:                                 ALLTRIM(TratarNulo(crLstTitBc.Codigos, "")), ;
2193:                                 ALLTRIM(TratarNulo(crLstTitBc.Descrs, "")))
2194:                         ENDIF
2195:                     ELSE
2196:                         MsgAviso("A lista de T" + CHR(237) + "tulos de Banco " + ;
2197:                             "(cursor crLstTitBc) n" + CHR(227) + "o est" + CHR(225) + ;
2198:                             " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
2199:                             CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
2200:                             "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
2201:                             "do acervo migrado." + CHR(13) + ;
2202:                             "O c" + CHR(243) + "digo digitado foi mantido.", ;
2203:                             "Lista indispon" + CHR(237) + "vel")
2204:                     ENDIF
2205:                 ENDIF
2206:             ENDIF
2207:         CATCH TO loc_oErro
2208:             MsgErro(loc_oErro.Message + CHR(13) + ;
2209:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2210:                 "Procedure: " + loc_oErro.Procedure, ;
2211:                 "Erro em AbrirLookupTituloBancoExec")
2212:         ENDTRY
2213:     ENDPROC
2214: 
2215:     *--------------------------------------------------------------------------
2216:     * AbrirLookupOrigemGrade - picker da coluna "Origem dos Valores" da grade
2217:     * (legado: grdValores.Column1.Text1.Valid):
2218:     *
2219:     *   Locate For Upper(Descrs) = Upper(Padr(This.Value, 100))
2220:     *   If Eof([crTabOpFin]) -> fwBuscaInt(crTabOpFin, Descrs, ...) + Show
2221:     *   If LastKey() = 27 -> Replace Codigos With [], Descrs With []
2222:     *   Else              -> Replace Codigos/Descrs With crTabOpFin.*
2223:     *
2224:     * crTabOpFin e a lista de origens de valor do modulo SigOpFin, montada por
2225:     * fSigOpFin_Tabs() (SigOpFin.prg legado, fora do acervo) - nao existe
2226:     * tabela correspondente no schema canonico, e nenhuma e inventada aqui
2227:     * (mesma razao do AbrirLookupTituloBanco). O picker roda sobre o cursor do
2228:     * legado quando ele existir; nao existindo, a ausencia e reportada e o que
2229:     * o usuario digitou e preservado na linha.
2230:     *
2231:     * Recebe o TextBox da celula como parametro: dentro do Valid o valor
2232:     * digitado ainda esta em par_oTxt.Value e o cursor so o recebe DEPOIS -
2233:     * ler do cursor validaria o valor antigo (regra CLAUDE.md #46).
2234:     *--------------------------------------------------------------------------
2235:     PROCEDURE AbrirLookupOrigemGrade(par_oTxt)
2236:         IF THIS.this_lEmLookup
2237:             RETURN
2238:         ENDIF
2239: 
2240:         THIS.this_lEmLookup = .T.
2241:         THIS.AbrirLookupOrigemGradeExec(par_oTxt)
2242:         THIS.this_lEmLookup = .F.
2243:     ENDPROC
2244: 
2245:     PROTECTED PROCEDURE AbrirLookupOrigemGradeExec(par_oTxt)
2246:         LOCAL loc_cValor, loc_lCancelou, loc_oErro
2247: 
2248:         TRY
2249:             IF VARTYPE(par_oTxt) = "O" AND THIS.EmModoEdicao() ;
2250:                     AND USED("cursor_4c_GrdValores") ;
2251:                     AND !EOF("cursor_4c_GrdValores")
2252:                 loc_cValor = ALLTRIM(TRANSFORM(par_oTxt.Value))
2253: 
2254:                 *-- Legado: "If Not Empty(This.Value) And (Alltrim(This.Tag)
2255:                 *-- <> Alltrim(This.Value))" - celula vazia ou inalterada nao
2256:                 *-- dispara lookup nenhum.
2257:                 IF !EMPTY(loc_cValor) AND ;
2258:                         ALLTRIM(TRANSFORM(par_oTxt.Tag)) != loc_cValor
2259:                     IF THIS.ListaLocalDisponivel("crTabOpFin", "Descrs")
2260:                         loc_lCancelou = .F.
2261: 
2262:                         SELECT crTabOpFin
2263:                         GO TOP IN crTabOpFin
2264:                         LOCATE FOR UPPER(ALLTRIM(crTabOpFin.Descrs)) == ;
2265:                             UPPER(ALLTRIM(LEFT(loc_cValor, 100)))
2266: 
2267:                         IF EOF("crTabOpFin")
2268:                             loc_lCancelou = !THIS.MostrarPickerListaLocal( ;
2269:                                 "crTabOpFin", "Descrs", "Codigos", "Descritivos")
2270:                         ENDIF
2271: 
2272:                         SELECT cursor_4c_GrdValores
2273:                         IF loc_lCancelou OR !USED("crTabOpFin") OR EOF("crTabOpFin")
2274:                             *-- Legado: "If (LastKey() = 27) Replace Codigos
2275:                             *-- With [], Descrs With []".
2276:                             REPLACE Codigos WITH "", ;
2277:                                     Descrs  WITH "" IN cursor_4c_GrdValores
2278:                             par_oTxt.Value = ""
2279:                         ELSE
2280:                             REPLACE Codigos WITH ALLTRIM(TratarNulo(crTabOpFin.Codigos, "")), ;
2281:                                     Descrs  WITH ALLTRIM(TratarNulo(crTabOpFin.Descrs,  "")) ;
2282:                                 IN cursor_4c_GrdValores
2283:                             par_oTxt.Value = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2284:                         ENDIF
2285: 

*-- Linhas 2295 a 2534:
2295:                             THIS.grd_4c_Dados.Refresh()
2296:                         ENDIF
2297:                     ELSE
2298:                         MsgAviso("A lista de Origens dos Valores " + ;
2299:                             "(cursor crTabOpFin) n" + CHR(227) + "o est" + CHR(225) + ;
2300:                             " dispon" + CHR(237) + "vel nesta sess" + CHR(227) + "o." + ;
2301:                             CHR(13) + "Ela era montada por fSigOpFin_Tabs(), do " + ;
2302:                             "SigOpFin.prg legado, que n" + CHR(227) + "o faz parte " + ;
2303:                             "do acervo migrado." + CHR(13) + ;
2304:                             "O texto digitado foi mantido na linha.", ;
2305:                             "Lista indispon" + CHR(237) + "vel")
2306:                     ENDIF
2307:                 ENDIF
2308:             ENDIF
2309:         CATCH TO loc_oErro
2310:             MsgErro(loc_oErro.Message + CHR(13) + ;
2311:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2312:                 "Procedure: " + loc_oErro.Procedure, ;
2313:                 "Erro em AbrirLookupOrigemGradeExec")
2314:         ENDTRY
2315:     ENDPROC
2316: 
2317:     *--------------------------------------------------------------------------
2318:     * ObterCampoLookup - devolve o TextBox de nome par_cCampo quando ele pode
2319:     * receber lookup, ou .NULL. quando nao.
2320:     *
2321:     * O legado protege cada um desses campos com "When -> Return
2322:     * InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])": em VISUALIZAR o campo
2323:     * nao recebe foco e o Valid nunca roda. EmModoEdicao() reproduz esse When.
2324:     *
2325:     * O controle e alcancado por EVALUATE (regra CLAUDE.md #15/#34) - jamais
2326:     * por Controls(<nome>), que e indexado por NUMERO.
2327:     *--------------------------------------------------------------------------
2328:     PROTECTED FUNCTION ObterCampoLookup(par_cCampo)
2329:         LOCAL loc_oTxt
2330:         loc_oTxt = .NULL.
2331: 
2332:         IF THIS.EmModoEdicao() AND PEMSTATUS(THIS, par_cCampo, 5)
2333:             loc_oTxt = EVALUATE("THIS." + par_cCampo)
2334: 
2335:             IF VARTYPE(loc_oTxt) = "O"
2336:                 IF !loc_oTxt.Enabled OR loc_oTxt.ReadOnly
2337:                     loc_oTxt = .NULL.
2338:                 ENDIF
2339:             ENDIF
2340:         ENDIF
2341: 
2342:         RETURN loc_oTxt
2343:     ENDFUNC
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * AplicarValorLookup - grava no campo o codigo escolhido e a descricao no
2347:     * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
2348:     * marcando a tela como alterada (plAlterou do legado).
2349:     *
2350:     * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
2351:     * .Value grava na linha corrente do cursor, que e exatamente o que o
2352:     * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.
2353:     *--------------------------------------------------------------------------
2354:     PROTECTED PROCEDURE AplicarValorLookup(par_oTxt, par_cValor, par_cDescricao)
2355:         IF VARTYPE(par_oTxt) = "O" AND USED("cursor_4c_GrdValores") ;
2356:                 AND !EOF("cursor_4c_GrdValores")
2357:             par_oTxt.Value = par_cValor
2358: 
2359:             IF VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao)
2360:                 par_oTxt.ToolTipText = par_cDescricao
2361:             ENDIF
2362: 
2363:             par_oTxt.Refresh()
2364:             THIS.this_lAlterou = .T.
2365:         ENDIF
2366:     ENDPROC
2367: 
2368:     *--------------------------------------------------------------------------
2369:     * ListaLocalDisponivel - .T. quando o cursor de lista do legado existe na
2370:     * sessao e tem a coluna esperada com pelo menos uma linha.
2371:     *
2372:     * Conferir a COLUNA (e nao so USED()) evita abrir o picker sobre um alias
2373:     * homonimo de outra tela com estrutura diferente, caso em que o
2374:     * ControlSource da grade do picker estouraria em runtime. TYPE() e usado
2375:     * no lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento -
2376:     * com nome de cursor ele dispara o erro 11 do VFP9.
2377:     *--------------------------------------------------------------------------
2378:     PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
2379:         LOCAL loc_lOk
2380:         loc_lOk = .F.
2381: 
2382:         IF USED(par_cCursor)
2383:             IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
2384:                     AND RECCOUNT(par_cCursor) > 0
2385:                 loc_lOk = .T.
2386:             ENDIF
2387:         ENDIF
2388: 
2389:         RETURN loc_lOk
2390:     ENDFUNC
2391: 
2392:     *--------------------------------------------------------------------------
2393:     * MostrarPickerListaLocal - equivalente ao fwBuscaInt do legado: picker
2394:     * sobre um cursor LOCAL ja populado, com duas colunas.
2395:     *
2396:     * Usa a API manual do FormBuscaAuxiliar (CREATEOBJECT sem parametros +
2397:     * mAddColuna + Show) porque o cursor NAO vem de SQL: o Init com parametros
2398:     * dispararia um SELECT contra o SQL Server, que e o oposto do que o legado
2399:     * faz aqui. O cursor ja estar populado e pre-requisito - sem isso o
2400:     * ConfigurarGrid do picker retorna cedo e o dialogo abriria vazio; por
2401:     * isso o chamador sempre passa por ListaLocalDisponivel() antes.
2402:     *
2403:     * Devolve .T. quando o usuario selecionou. Ao selecionar, o ponteiro do
2404:     * cursor fica na linha escolhida (o grid do picker o posiciona), que e
2405:     * como o legado le o registro depois do Show.
2406:     *--------------------------------------------------------------------------
2407:     PROTECTED FUNCTION MostrarPickerListaLocal(par_cCursor, par_cCampoCod, ;
2408:             par_cCampoDesc, par_cTitulo)
2409:         LOCAL loc_oBusca, loc_lSelecionou
2410:         loc_lSelecionou = .F.
2411: 
2412:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2413: 
2414:         IF VARTYPE(loc_oBusca) = "O"
2415:             loc_oBusca.this_cCursorDestino = par_cCursor
2416:             loc_oBusca.this_cTitulo        = par_cTitulo
2417:             loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo
2418: 
2419:             loc_oBusca.mAddColuna(par_cCampoCod,  "", par_cCampoCod)
2420:             loc_oBusca.mAddColuna(par_cCampoDesc, "", par_cCampoDesc)
2421:             loc_oBusca.Show()
2422: 
2423:             loc_lSelecionou = loc_oBusca.this_lSelecionou
2424:             loc_oBusca.Release()
2425:         ENDIF
2426: 
2427:         RETURN loc_lSelecionou
2428:     ENDFUNC
2429: 
2430:     *--------------------------------------------------------------------------
2431:     * InstalarCelulaOrigem - poe na Column1 da grade o TextBox com Valid/
2432:     * KeyPress/DblClick embutidos, que e como se liga lookup a CELULA de grade
2433:     * (regra CLAUDE.md #46: AfterRowColChange entrega a coluna de DESTINO, e
2434:     * BINDEVENT em Valid de TextBox de Column nao e confiavel).
2435:     *
2436:     * Chamado tambem de MontaGrade(): atribuir ColumnCount RECRIA os objetos
2437:     * Column e destroi o controle instalado aqui, entao ele e reinstalado em
2438:     * qualquer caminho que religa a grade.
2439:     *
2440:     * CurrentControl e obrigatorio - sem ele a Column continua desenhando o
2441:     * Text1 nativo e o controle novo nunca aparece; Sparse = .F. faz valer em
2442:     * todas as linhas, nao so na ativa (regra CLAUDE.md #18). Column.ReadOnly
2443:     * vem DEPOIS do ReadOnly do Grid, que propaga para as colunas.
2444:     *--------------------------------------------------------------------------
2445:     PROTECTED PROCEDURE InstalarCelulaOrigem()
2446:         LOCAL loc_oCol, loc_oErro
2447: 
2448:         TRY
2449:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2450:                 loc_oCol = THIS.grd_4c_Dados.Column1
2451: 
2452:                 IF !PEMSTATUS(loc_oCol, "txt_4c_CelOrigem", 5)
2453:                     loc_oCol.AddObject("txt_4c_CelOrigem", "TextBoxOrigemSigOpFin_4c")
2454:                 ENDIF
2455: 
2456:                 loc_oCol.txt_4c_CelOrigem.Visible = .T.
2457:                 loc_oCol.CurrentControl           = "txt_4c_CelOrigem"
2458:                 loc_oCol.Sparse                   = .F.
2459:                 loc_oCol.ReadOnly                 = !THIS.EmModoEdicao()
2460:             ENDIF
2461:         CATCH TO loc_oErro
2462:             MsgErro(loc_oErro.Message + CHR(13) + ;
2463:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2464:                 "Procedure: " + loc_oErro.Procedure, ;
2465:                 "Erro em InstalarCelulaOrigem")
2466:         ENDTRY
2467:     ENDPROC
2468: 
2469:     *--------------------------------------------------------------------------
2470:     * CarregarDados - popula cursor_4c_GrdValores com as linhas de configuracao
2471:     * ja gravadas para a movimentacao (this_cDopes) e, em modo de edicao,
2472:     * acrescenta no fim a linha em branco que o legado usa para a inclusao da
2473:     * proxima origem.
2474:     *
2475:     * Equivalente ao trecho do Init legado (dump de
2476:     * sigopfin_form_codigo_fonte.txt, linhas 1483-1523):
2477:     *   =fSigOpFin_Cria()                        -> SELECT ... FROM sigopfin
2478:     *   Scan crSigOpFin / Scatter / Insert       -> DO WHILE sobre o cursor temp
2479:     *   Insert Into crGrdValores (Ordem) Values  -> linha em branco do fim
2480:     *   .MontaGrades()                           -> THIS.MontaGrade()
2481:     *
2482:     * fSigOpFin_Cria()/fSigOpFin_Tabs() vivem no SigOpFin.prg legado, que NAO
2483:     * veio no acervo; o que elas faziam de fato (abrir as linhas de sigopfin da
2484:     * movimentacao) esta reproduzido aqui com SQL direto sobre a tabela. O
2485:     * legado le crSigOpFin, cursor que o form PAI (cadastro de Operacoes) cria
2486:     * - aqui a consulta e propria, para o dialogo nao depender de cursor de
2487:     * terceiro.
2488:     *
2489:     * O SQLEXEC vai para um cursor TEMPORARIO: SQLEXEC sobre o alias ligado ao
2490:     * Grid fecha e recria o alias, zerando ColumnCount e deixando a grade um
2491:     * retangulo branco sem cabecalho. O alias da grade e recarregado com
2492:     * ZAP + insercao linha a linha, que preserva estrutura e binding.
2493:     *--------------------------------------------------------------------------
2494:     PROCEDURE CarregarDados()
2495:         LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado
2496:         LOCAL loc_nOrdem, loc_oErro
2497:         loc_lSucesso    = .F.
2498:         loc_lProsseguir = .T.
2499: 
2500:         TRY
2501:             THIS.CriarCursorGrdValores()
2502: 
2503:             IF !USED("cursor_4c_GrdValores")
2504:                 MsgErro("Cursor da grade n" + CHR(227) + "o foi criado.", ;
2505:                     "Erro em CarregarDados")
2506:                 loc_lProsseguir = .F.
2507:             ENDIF
2508: 
2509:             IF loc_lProsseguir
2510:                 SELECT cursor_4c_GrdValores
2511:                 ZAP
2512: 
2513:                 *-- Sem conexao (validacao de UI / modo de teste) a grade abre
2514:                 *-- vazia e o form continua funcionando - nao ha SQL a executar.
2515:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
2516:                         AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2517: 
2518:                     THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2519: 
2520:                     loc_cSQL = "SELECT codigos, dopes, ordem," + ;
2521:                                " moedas, tipos, titbans, movtits," + ;
2522:                                " notas, comandos," + ;
2523:                                " usuincs, datincs, usualts, datalts," + ;
2524:                                " grupoeds, contaeds, grupoecs, contaecs," + ;
2525:                                " grupopds, contapds, grupopcs, contapcs," + ;
2526:                                " grupocds, contacds, grupoccs, contaccs," + ;
2527:                                " grupoads, contaads, grupoacs, contaacs" + ;
2528:                                " FROM sigopfin" + ;
2529:                                " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
2530:                                " ORDER BY ordem"
2531: 
2532:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, ;
2533:                         "cursor_4c_GrdValoresTmp")
2534: 

*-- Linhas 2576 a 2638:
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message + CHR(13) + ;
2578:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2579:                 "Procedure: " + loc_oErro.Procedure, ;
2580:                 "Erro em Formsigopfin.CarregarDados")
2581:         ENDTRY
2582: 
2583:         RETURN loc_lSucesso
2584:     ENDPROC
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * InserirLinhaGrade - acrescenta a cursor_4c_GrdValores a linha corrente de
2588:     * cursor_4c_GrdValoresTmp, renumerando Ordem sequencialmente (par_nOrdem) e
2589:     * resolvendo a descricao da origem. Equivale ao corpo do Scan legado
2590:     * (Scatter Memvar Memo / m.Ordem / m.Descrs / Insert From Memvar).
2591:     *
2592:     * As colunas sao referenciadas com o alias explicito para a insercao nao
2593:     * depender da area de trabalho corrente. Descrs NAO existe na tabela
2594:     * sigopfin (so no cursor da grade) - vem da descricao da origem.
2595:     * DatIncs/DatAlts usam CTOT("") como default, igual ao Nvl(..., Ctot([]))
2596:     * do legado: campo T nao aceita o {} de um DATE vazio.
2597:     *--------------------------------------------------------------------------
2598:     PROTECTED PROCEDURE InserirLinhaGrade(par_nOrdem)
2599:         LOCAL loc_cCodigos, loc_cDescrs
2600: 
2601:         loc_cCodigos = TratarNulo(cursor_4c_GrdValoresTmp.codigos, "")
2602:         loc_cDescrs  = LEFT(THIS.ObterDescricaoOrigem(loc_cCodigos), 100)
2603: 
2604:         INSERT INTO cursor_4c_GrdValores ;
2605:             (Ordem,    Codigos,  Descrs,   Dopes, ;
2606:              Notas,    Comandos, Moedas,   Tipos,    TitBans, ;
2607:              UsuIncs,  MovTits,  DatIncs,  UsuAlts,  DatAlts, ;
2608:              GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
2609:              GrupoPDs, ContaPDs, GrupoPCs, ContaPCs, ;
2610:              GrupoCDs, ContaCDs, GrupoCCs, ContaCCs, ;
2611:              GrupoADs, ContaADs, GrupoACs, ContaACs) ;
2612:             VALUES ;
2613:             (par_nOrdem, ;
2614:              loc_cCodigos, ;
2615:              loc_cDescrs, ;
2616:              TratarNulo(cursor_4c_GrdValoresTmp.dopes,    ""), ;
2617:              TratarNulo(cursor_4c_GrdValoresTmp.notas,    ""), ;
2618:              TratarNulo(cursor_4c_GrdValoresTmp.comandos, ""), ;
2619:              TratarNulo(cursor_4c_GrdValoresTmp.moedas,   ""), ;
2620:              TratarNulo(cursor_4c_GrdValoresTmp.tipos,    ""), ;
2621:              TratarNulo(cursor_4c_GrdValoresTmp.titbans,  ""), ;
2622:              TratarNulo(cursor_4c_GrdValoresTmp.usuincs,  ""), ;
2623:              TratarNulo(cursor_4c_GrdValoresTmp.movtits,  ""), ;
2624:              TratarNulo(cursor_4c_GrdValoresTmp.datincs,  CTOT("")), ;
2625:              TratarNulo(cursor_4c_GrdValoresTmp.usualts,  ""), ;
2626:              TratarNulo(cursor_4c_GrdValoresTmp.datalts,  CTOT("")), ;
2627:              TratarNulo(cursor_4c_GrdValoresTmp.grupoeds, ""), ;
2628:              TratarNulo(cursor_4c_GrdValoresTmp.contaeds, ""), ;
2629:              TratarNulo(cursor_4c_GrdValoresTmp.grupoecs, ""), ;
2630:              TratarNulo(cursor_4c_GrdValoresTmp.contaecs, ""), ;
2631:              TratarNulo(cursor_4c_GrdValoresTmp.grupopds, ""), ;
2632:              TratarNulo(cursor_4c_GrdValoresTmp.contapds, ""), ;
2633:              TratarNulo(cursor_4c_GrdValoresTmp.grupopcs, ""), ;
2634:              TratarNulo(cursor_4c_GrdValoresTmp.contapcs, ""), ;
2635:              TratarNulo(cursor_4c_GrdValoresTmp.grupocds, ""), ;
2636:              TratarNulo(cursor_4c_GrdValoresTmp.contacds, ""), ;
2637:              TratarNulo(cursor_4c_GrdValoresTmp.grupoccs, ""), ;
2638:              TratarNulo(cursor_4c_GrdValoresTmp.contaccs, ""), ;

*-- Linhas 2707 a 2790:
2707:     * criados nas Fases 5 e 6, e o religamento deles entra NESTE metodo junto
2708:     * com eles.
2709:     *--------------------------------------------------------------------------
2710:     PROCEDURE MontaGrade()
2711:         LOCAL loc_oGrd, loc_oErro
2712: 
2713:         TRY
2714:             THIS.CriarCursorGrdValores()
2715: 
2716:             SELECT cursor_4c_GrdValores
2717:             SET ORDER TO TAG Ordem
2718:             GO TOP
2719: 
2720:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2721:                 loc_oGrd = THIS.grd_4c_Dados
2722: 
2723:                 WITH loc_oGrd
2724:                     .ColumnCount  = 1
2725:                     .RecordSource = "cursor_4c_GrdValores"
2726: 
2727:                     .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
2728:                     .Column1.Width             = 700
2729:                     .Column1.FontName          = "Tahoma"
2730:                     .Column1.FontSize          = 8
2731:                     .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
2732:                         CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
2733:                         "o Financeira"
2734:                     .Column1.Header1.Alignment = 2
2735:                     .Column1.Header1.FontBold  = .F.
2736: 
2737:                     .Refresh()
2738:                 ENDWITH
2739:             ENDIF
2740: 
2741:             *-- MontaGrade() reatribui ColumnCount, o que RECRIA os objetos
2742:             *-- Column e destroi o TextBox de lookup da celula - reinstalar
2743:             *-- em todo caminho que religa a grade.
2744:             THIS.InstalarCelulaOrigem()
2745: 
2746:             *-- Religamento dos campos de detalhe da linha corrente,
2747:             *-- criados em ConfigurarCamposGrupoContaEmissorPortador()
2748:             *-- (Fase 5 parte 1 - Emissor/Portador). Guardado por
2749:             *-- PEMSTATUS porque MontaGrade() tambem roda a partir de
2750:             *-- CarregarDados(), chamado no InicializarForm ANTES de
2751:             *-- ConfigurarPageFrame() ter criado esses controles na
2752:             *-- primeira passada (CarregarDados roda de novo depois, com
2753:             *-- os controles ja existindo).
2754:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
2755:                 THIS.txt_4c_GrupoEDs.ControlSource = "cursor_4c_GrdValores.GrupoEDs"
2756:                 THIS.txt_4c_ContaEDs.ControlSource = "cursor_4c_GrdValores.ContaEDs"
2757:                 THIS.txt_4c_GrupoECs.ControlSource = "cursor_4c_GrdValores.GrupoECs"
2758:                 THIS.txt_4c_ContaECs.ControlSource = "cursor_4c_GrdValores.ContaECs"
2759:                 THIS.txt_4c_GrupoPDs.ControlSource = "cursor_4c_GrdValores.GrupoPDs"
2760:                 THIS.txt_4c_ContaPDs.ControlSource = "cursor_4c_GrdValores.ContaPDs"
2761:                 THIS.txt_4c_GrupoPCs.ControlSource = "cursor_4c_GrdValores.GrupoPCs"
2762:                 THIS.txt_4c_ContaPCs.ControlSource = "cursor_4c_GrdValores.ContaPCs"
2763:                 THIS.txt_4c_GrupoEDs.Refresh()
2764:                 THIS.txt_4c_ContaEDs.Refresh()
2765:                 THIS.txt_4c_GrupoECs.Refresh()
2766:                 THIS.txt_4c_ContaECs.Refresh()
2767:                 THIS.txt_4c_GrupoPDs.Refresh()
2768:                 THIS.txt_4c_ContaPDs.Refresh()
2769:                 THIS.txt_4c_GrupoPCs.Refresh()
2770:                 THIS.txt_4c_ContaPCs.Refresh()
2771:             ENDIF
2772: 
2773:             *-- Religamento dos campos de detalhe criados nesta Fase 6
2774:             *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
2775:             *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
2776:             *-- Comandos - ConfigurarCamposComplementares/
2777:             *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
2778:             *-- Fase 5 parte 1, mesma razao.
2779:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
2780:                 THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
2781:                 THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
2782:                 THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"
2783:                 THIS.txt_4c_ContaCCs.ControlSource = "cursor_4c_GrdValores.ContaCCs"
2784:                 THIS.txt_4c_GrupoADs.ControlSource = "cursor_4c_GrdValores.GrupoADs"
2785:                 THIS.txt_4c_ContaADs.ControlSource = "cursor_4c_GrdValores.ContaADs"
2786:                 THIS.txt_4c_GrupoACs.ControlSource = "cursor_4c_GrdValores.GrupoACs"
2787:                 THIS.txt_4c_ContaACs.ControlSource = "cursor_4c_GrdValores.ContaACs"
2788:                 THIS.txt_4c_GrupoCDs.Refresh()
2789:                 THIS.txt_4c_ContaCDs.Refresh()
2790:                 THIS.txt_4c_GrupoCCs.Refresh()

*-- Linhas 2821 a 3359:
2821:         CATCH TO loc_oErro
2822:             MsgErro(loc_oErro.Message + CHR(13) + ;
2823:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2824:                 "Procedure: " + loc_oErro.Procedure, ;
2825:                 "Erro em Formsigopfin.MontaGrade")
2826:         ENDTRY
2827:     ENDPROC
2828: 
2829:     *--------------------------------------------------------------------------
2830:     * AjustarBotoesGrade - visibilidade dos 3 botoes de manutencao da grade
2831:     * conforme o modo. Legado (Init, dump linhas 1525-1527):
2832:     *   .btnExcluiGrd.Visible = InList(.pcEscolha, [INSERIR], [ALTERAR])
2833:     *   .btnSetaDn.Visible    = .btnExcluiGrd.Visible
2834:     *   .btnSetaUp.Visible    = .btnExcluiGrd.Visible
2835:     *
2836:     * Chamado DEPOIS de TornarControlesVisiveis(), que forca Visible = .T. em
2837:     * tudo e apagaria este ajuste se viesse antes. Fica num metodo proprio para
2838:     * que todo caminho que troque de modo possa reaplica-lo e os botoes
2839:     * reaparecam na volta.
2840:     *--------------------------------------------------------------------------
2841:     PROCEDURE AjustarBotoesGrade()
2842:         LOCAL loc_lEditando, loc_oErro
2843: 
2844:         TRY
2845:             loc_lEditando = THIS.EmModoEdicao()
2846: 
2847:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaUp", 5)
2848:                 THIS.cmd_4c_BtnSetaUp.Visible = loc_lEditando
2849:             ENDIF
2850:             IF PEMSTATUS(THIS, "cmd_4c_BtnSetaDn", 5)
2851:                 THIS.cmd_4c_BtnSetaDn.Visible = loc_lEditando
2852:             ENDIF
2853:             IF PEMSTATUS(THIS, "cmd_4c_BtnExcluiGrd", 5)
2854:                 THIS.cmd_4c_BtnExcluiGrd.Visible = loc_lEditando
2855:             ENDIF
2856:         CATCH TO loc_oErro
2857:             MsgErro(loc_oErro.Message + CHR(13) + ;
2858:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2859:                 "Procedure: " + loc_oErro.Procedure, ;
2860:                 "Erro em Formsigopfin.AjustarBotoesGrade")
2861:         ENDTRY
2862:     ENDPROC
2863: 
2864:     *--------------------------------------------------------------------------
2865:     * EmModoEdicao - .T. quando a tela esta em inclusao ou alteracao, isto e,
2866:     * quando o legado testa InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR]).
2867:     * O modo e copiado do form chamador no Init; "INCLUIR" e a grafia do
2868:     * sistema novo e "INSERIR" a do legado - as duas sao aceitas porque
2869:     * this_cModoAtual vem de par_oFormPai.this_cModoAtual, que pode trazer
2870:     * qualquer das duas.
2871:     *--------------------------------------------------------------------------
2872:     FUNCTION EmModoEdicao()
2873:         RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), ;
2874:             "INCLUIR", "INSERIR", "ALTERAR")
2875:     ENDFUNC
2876: 
2877:     *--------------------------------------------------------------------------
2878:     * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
2879:     * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
2880:     * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
2881:     * dispara o erro 1586 "Function requires row or table buffering mode". Dai
2882:     * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo.
2883:     *--------------------------------------------------------------------------
2884:     PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
2885:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
2886:             IF CURSORGETPROP("Buffering", par_cAlias) > 1
2887:                 TABLEREVERT(.T., par_cAlias)
2888:             ENDIF
2889:             USE IN (par_cAlias)
2890:         ENDIF
2891:     ENDPROC
2892:     *--------------------------------------------------------------------------
2893:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
2894:     * padrao; percorre recursivamente Controls (containers/PageFrame) para
2895:     * garantir que tudo fique visivel apos a montagem.
2896:     *--------------------------------------------------------------------------
2897:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2898:         LOCAL loc_nI, loc_oObjeto
2899: 
2900:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2901:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2902: 
2903:             IF VARTYPE(loc_oObjeto) = "O"
2904:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2905:                     loc_oObjeto.Visible = .T.
2906:                 ENDIF
2907: 
2908:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2909:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2910:                 ENDIF
2911:             ENDIF
2912:         ENDFOR
2913:     ENDPROC
2914: 
2915:     *--------------------------------------------------------------------------
2916:     * AvancarLinhaGradeOrigem - parte do LostFocus de grdValores.Column1.Text1
2917:     * que NAO e dirty-tracking (esta ja coberta em AbrirLookupOrigemGradeExec,
2918:     * chamado pelo Valid): ao sair da celula com ENTER e a linha preenchida,
2919:     * avanca para a proxima linha e, se for a ultima, insere uma em branco -
2920:     * para o usuario sempre ter onde continuar digitando. Chamado pelo
2921:     * LostFocus de TextBoxOrigemSigOpFin_4c. PUBLIC pelo mesmo motivo de
2922:     * AbrirLookupOrigemGrade (chamado de fora da classe do form).
2923:     *--------------------------------------------------------------------------
2924:     PROCEDURE AvancarLinhaGradeOrigem()
2925:         LOCAL loc_nQtdeBranco, loc_nMaxOrdem, loc_oErro
2926: 
2927:         TRY
2928:             IF THIS.EmModoEdicao() AND USED("cursor_4c_GrdValores") ;
2929:                     AND LASTKEY() = 13 ;
2930:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
2931:                 SELECT cursor_4c_GrdValores
2932:                 SKIP
2933: 
2934:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2935:                     THIS.grd_4c_Dados.Refresh()
2936:                 ENDIF
2937: 
2938:                 IF EOF("cursor_4c_GrdValores")
2939:                     loc_nQtdeBranco = 0
2940:                     COUNT FOR EMPTY(Codigos) TO loc_nQtdeBranco
2941: 
2942:                     IF loc_nQtdeBranco = 0
2943:                         loc_nMaxOrdem = 0
2944:                         CALCULATE MAX(Ordem) TO loc_nMaxOrdem
2945:                         INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nMaxOrdem + 1)
2946:                     ENDIF
2947: 
2948:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2949:                         THIS.grd_4c_Dados.Refresh()
2950:                     ENDIF
2951:                 ENDIF
2952: 
2953:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2954:                     THIS.grd_4c_Dados.Column1.SetFocus()
2955:                 ENDIF
2956:                 KEYBOARD "{DNARROW}"
2957:             ENDIF
2958:         CATCH TO loc_oErro
2959:             MsgErro(loc_oErro.Message + CHR(13) + ;
2960:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2961:                 "Procedure: " + loc_oErro.Procedure, ;
2962:                 "Erro em AvancarLinhaGradeOrigem")
2963:         ENDTRY
2964:     ENDPROC
2965: 
2966:     *--------------------------------------------------------------------------
2967:     * SalvarTagCampo / VerificarAlteracaoCampo - par generico de dirty-
2968:     * tracking (legado: "This.Tag = This.Value" no GotFocus e "If (This.Tag
2969:     * <> This.Value) ThisForm.plAlterou = .t. EndIf" no LostFocus, repetido
2970:     * em ~20 controles do dump). TRANSFORM() normaliza C/N (TextBox guarda
2971:     * char, CheckBox guarda numerico 0/1 - Str(Value,1) do legado e
2972:     * TRANSFORM(Value) aqui dao o mesmo "0"/"1").
2973:     *--------------------------------------------------------------------------
2974:     PROTECTED PROCEDURE SalvarTagCampo(par_cCampo)
2975:         LOCAL loc_oCtrl
2976: 
2977:         IF PEMSTATUS(THIS, par_cCampo, 5)
2978:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
2979:             IF VARTYPE(loc_oCtrl) = "O"
2980:                 loc_oCtrl.Tag = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
2981:             ENDIF
2982:         ENDIF
2983:     ENDPROC
2984: 
2985:     PROTECTED PROCEDURE VerificarAlteracaoCampo(par_cCampo)
2986:         LOCAL loc_oCtrl
2987: 
2988:         IF PEMSTATUS(THIS, par_cCampo, 5)
2989:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
2990:             IF VARTYPE(loc_oCtrl) = "O"
2991:                 IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
2992:                     THIS.this_lAlterou = .T.
2993:                 ENDIF
2994:             ENDIF
2995:         ENDIF
2996:     ENDPROC
2997: 
2998:     *--------------------------------------------------------------------------
2999:     * VerificarAlteracaoEMaiusculizar - variante usada por getNotas/
3000:     * getComandos: dirty-check seguido de "This.Value = Upper(This.Value)".
3001:     *--------------------------------------------------------------------------
3002:     PROTECTED PROCEDURE VerificarAlteracaoEMaiusculizar(par_cCampo)
3003:         LOCAL loc_oCtrl
3004: 
3005:         IF PEMSTATUS(THIS, par_cCampo, 5)
3006:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
3007:             IF VARTYPE(loc_oCtrl) = "O"
3008:                 IF ALLTRIM(TRANSFORM(loc_oCtrl.Tag)) != ALLTRIM(TRANSFORM(loc_oCtrl.Value))
3009:                     THIS.this_lAlterou = .T.
3010:                 ENDIF
3011:                 loc_oCtrl.Value = UPPER(loc_oCtrl.Value)
3012:             ENDIF
3013:         ENDIF
3014:     ENDPROC
3015: 
3016:     *--------------------------------------------------------------------------
3017:     * ConfigurarEventosDirtyTracking - BINDEVENT de GotFocus/LostFocus para
3018:     * dirty-tracking (this_lAlterou) em todos os controles de detalhe da
3019:     * linha corrente que o dump declara com esse par (16 Grupo/Conta +
3020:     * CMoes/TitBans/Tipos/MovTits + getNotas/getComandos + os 2 CheckBox).
3021:     * Fase 7. O LostFocus dos campos com lookup (Grupo/Conta/CMoes/TitBans/
3022:     * MovTits) ja esta ligado a *Lookup (Fase 6, equivalente ao Valid do
3023:     * legado) - o BIND aqui e um SEGUNDO handler no MESMO evento, que o VFP9
3024:     * encadeia na ordem de ligacao (Lookup primeiro, dirty-check depois),
3025:     * reproduzindo a ordem real do legado (Valid roda antes de LostFocus).
3026:     *--------------------------------------------------------------------------
3027:     PROTECTED PROCEDURE ConfigurarEventosDirtyTracking()
3028:         LOCAL loc_oErro
3029: 
3030:         TRY
3031:             THIS.LigarDirtyTracking("txt_4c_GrupoEDs", "GrupoEDsGotFoco", "GrupoEDsPerdeFoco")
3032:             THIS.LigarDirtyTracking("txt_4c_ContaEDs", "ContaEDsGotFoco", "ContaEDsPerdeFoco")
3033:             THIS.LigarDirtyTracking("txt_4c_GrupoECs", "GrupoECsGotFoco", "GrupoECsPerdeFoco")
3034:             THIS.LigarDirtyTracking("txt_4c_ContaECs", "ContaECsGotFoco", "ContaECsPerdeFoco")
3035:             THIS.LigarDirtyTracking("txt_4c_GrupoPDs", "GrupoPDsGotFoco", "GrupoPDsPerdeFoco")
3036:             THIS.LigarDirtyTracking("txt_4c_ContaPDs", "ContaPDsGotFoco", "ContaPDsPerdeFoco")
3037:             THIS.LigarDirtyTracking("txt_4c_GrupoPCs", "GrupoPCsGotFoco", "GrupoPCsPerdeFoco")
3038:             THIS.LigarDirtyTracking("txt_4c_ContaPCs", "ContaPCsGotFoco", "ContaPCsPerdeFoco")
3039:             THIS.LigarDirtyTracking("txt_4c_GrupoCDs", "GrupoCDsGotFoco", "GrupoCDsPerdeFoco")
3040:             THIS.LigarDirtyTracking("txt_4c_ContaCDs", "ContaCDsGotFoco", "ContaCDsPerdeFoco")
3041:             THIS.LigarDirtyTracking("txt_4c_GrupoCCs", "GrupoCCsGotFoco", "GrupoCCsPerdeFoco")
3042:             THIS.LigarDirtyTracking("txt_4c_ContaCCs", "ContaCCsGotFoco", "ContaCCsPerdeFoco")
3043:             THIS.LigarDirtyTracking("txt_4c_GrupoADs", "GrupoADsGotFoco", "GrupoADsPerdeFoco")
3044:             THIS.LigarDirtyTracking("txt_4c_ContaADs", "ContaADsGotFoco", "ContaADsPerdeFoco")
3045:             THIS.LigarDirtyTracking("txt_4c_GrupoACs", "GrupoACsGotFoco", "GrupoACsPerdeFoco")
3046:             THIS.LigarDirtyTracking("txt_4c_ContaACs", "ContaACsGotFoco", "ContaACsPerdeFoco")
3047: 
3048:             THIS.LigarDirtyTracking("txt_4c_CMoes",   "CMoesGotFoco",   "CMoesPerdeFoco")
3049:             THIS.LigarDirtyTracking("txt_4c_TitBans", "TitBansGotFoco", "TitBansPerdeFoco")
3050:             THIS.LigarDirtyTracking("txt_4c_MovTits", "MovTitsGotFoco", "MovTitsPerdeFoco")
3051:             THIS.LigarDirtyTracking("txt_4c_Tipos",   "TiposGotFoco",   "TiposPerdeFoco")
3052: 
3053:             THIS.LigarDirtyTracking("obj_4c_GetNotas",    "GetNotasGotFoco",    "GetNotasPerdeFoco")
3054:             THIS.LigarDirtyTracking("obj_4c_GetComandos", "GetComandosGotFoco", "GetComandosPerdeFoco")
3055: 
3056:             THIS.LigarDirtyTracking("chk_4c_Chk_P1_CMVS", "ChkP1CmvsGotFoco", "ChkP1CmvsPerdeFoco")
3057:             THIS.LigarDirtyTracking("chk_4c_Chk_P2_MOBS", "ChkP2MobsGotFoco", "ChkP2MobsPerdeFoco")
3058:         CATCH TO loc_oErro
3059:             MsgErro(loc_oErro.Message + CHR(13) + ;
3060:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3061:                 "Procedure: " + loc_oErro.Procedure, ;
3062:                 "Erro em ConfigurarEventosDirtyTracking")
3063:         ENDTRY
3064:     ENDPROC
3065: 
3066:     *--------------------------------------------------------------------------
3067:     * LigarDirtyTracking - liga os handlers de GotFocus/LostFocus de UM campo.
3068:     *--------------------------------------------------------------------------
3069:     PROTECTED PROCEDURE LigarDirtyTracking(par_cCampo, par_cHandlerGotFocus, par_cHandlerLostFocus)
3070:         LOCAL loc_oCtrl
3071: 
3072:         IF PEMSTATUS(THIS, par_cCampo, 5)
3073:             loc_oCtrl = EVALUATE("THIS." + par_cCampo)
3074:             IF VARTYPE(loc_oCtrl) = "O"
3075:                 BINDEVENT(loc_oCtrl, "GotFocus",  THIS, par_cHandlerGotFocus)
3076:                 BINDEVENT(loc_oCtrl, "LostFocus", THIS, par_cHandlerLostFocus)
3077:             ENDIF
3078:         ENDIF
3079:     ENDPROC
3080: 
3081:     *--------------------------------------------------------------------------
3082:     * Handlers de dirty-tracking - um par (GotFoco/PerdeFoco) por campo,
3083:     * cada um delegando para o par generico acima com o nome do campo.
3084:     * Todos PUBLIC (sem PROTECTED) por exigencia do BINDEVENT.
3085:     *--------------------------------------------------------------------------
3086:     PROCEDURE GrupoEDsGotFoco()
3087:         THIS.SalvarTagCampo("txt_4c_GrupoEDs")
3088:     ENDPROC
3089:     PROCEDURE GrupoEDsPerdeFoco()
3090:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoEDs")
3091:     ENDPROC
3092: 
3093:     PROCEDURE ContaEDsGotFoco()
3094:         THIS.SalvarTagCampo("txt_4c_ContaEDs")
3095:     ENDPROC
3096:     PROCEDURE ContaEDsPerdeFoco()
3097:         THIS.VerificarAlteracaoCampo("txt_4c_ContaEDs")
3098:     ENDPROC
3099: 
3100:     PROCEDURE GrupoECsGotFoco()
3101:         THIS.SalvarTagCampo("txt_4c_GrupoECs")
3102:     ENDPROC
3103:     PROCEDURE GrupoECsPerdeFoco()
3104:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoECs")
3105:     ENDPROC
3106: 
3107:     PROCEDURE ContaECsGotFoco()
3108:         THIS.SalvarTagCampo("txt_4c_ContaECs")
3109:     ENDPROC
3110:     PROCEDURE ContaECsPerdeFoco()
3111:         THIS.VerificarAlteracaoCampo("txt_4c_ContaECs")
3112:     ENDPROC
3113: 
3114:     PROCEDURE GrupoPDsGotFoco()
3115:         THIS.SalvarTagCampo("txt_4c_GrupoPDs")
3116:     ENDPROC
3117:     PROCEDURE GrupoPDsPerdeFoco()
3118:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoPDs")
3119:     ENDPROC
3120: 
3121:     PROCEDURE ContaPDsGotFoco()
3122:         THIS.SalvarTagCampo("txt_4c_ContaPDs")
3123:     ENDPROC
3124:     PROCEDURE ContaPDsPerdeFoco()
3125:         THIS.VerificarAlteracaoCampo("txt_4c_ContaPDs")
3126:     ENDPROC
3127: 
3128:     PROCEDURE GrupoPCsGotFoco()
3129:         THIS.SalvarTagCampo("txt_4c_GrupoPCs")
3130:     ENDPROC
3131:     PROCEDURE GrupoPCsPerdeFoco()
3132:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoPCs")
3133:     ENDPROC
3134: 
3135:     PROCEDURE ContaPCsGotFoco()
3136:         THIS.SalvarTagCampo("txt_4c_ContaPCs")
3137:     ENDPROC
3138:     PROCEDURE ContaPCsPerdeFoco()
3139:         THIS.VerificarAlteracaoCampo("txt_4c_ContaPCs")
3140:     ENDPROC
3141: 
3142:     PROCEDURE GrupoCDsGotFoco()
3143:         THIS.SalvarTagCampo("txt_4c_GrupoCDs")
3144:     ENDPROC
3145:     PROCEDURE GrupoCDsPerdeFoco()
3146:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoCDs")
3147:     ENDPROC
3148: 
3149:     PROCEDURE ContaCDsGotFoco()
3150:         THIS.SalvarTagCampo("txt_4c_ContaCDs")
3151:     ENDPROC
3152:     PROCEDURE ContaCDsPerdeFoco()
3153:         THIS.VerificarAlteracaoCampo("txt_4c_ContaCDs")
3154:     ENDPROC
3155: 
3156:     PROCEDURE GrupoCCsGotFoco()
3157:         THIS.SalvarTagCampo("txt_4c_GrupoCCs")
3158:     ENDPROC
3159:     PROCEDURE GrupoCCsPerdeFoco()
3160:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoCCs")
3161:     ENDPROC
3162: 
3163:     PROCEDURE ContaCCsGotFoco()
3164:         THIS.SalvarTagCampo("txt_4c_ContaCCs")
3165:     ENDPROC
3166:     PROCEDURE ContaCCsPerdeFoco()
3167:         THIS.VerificarAlteracaoCampo("txt_4c_ContaCCs")
3168:     ENDPROC
3169: 
3170:     PROCEDURE GrupoADsGotFoco()
3171:         THIS.SalvarTagCampo("txt_4c_GrupoADs")
3172:     ENDPROC
3173:     PROCEDURE GrupoADsPerdeFoco()
3174:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoADs")
3175:     ENDPROC
3176: 
3177:     PROCEDURE ContaADsGotFoco()
3178:         THIS.SalvarTagCampo("txt_4c_ContaADs")
3179:     ENDPROC
3180:     PROCEDURE ContaADsPerdeFoco()
3181:         THIS.VerificarAlteracaoCampo("txt_4c_ContaADs")
3182:     ENDPROC
3183: 
3184:     PROCEDURE GrupoACsGotFoco()
3185:         THIS.SalvarTagCampo("txt_4c_GrupoACs")
3186:     ENDPROC
3187:     PROCEDURE GrupoACsPerdeFoco()
3188:         THIS.VerificarAlteracaoCampo("txt_4c_GrupoACs")
3189:     ENDPROC
3190: 
3191:     PROCEDURE ContaACsGotFoco()
3192:         THIS.SalvarTagCampo("txt_4c_ContaACs")
3193:     ENDPROC
3194:     PROCEDURE ContaACsPerdeFoco()
3195:         THIS.VerificarAlteracaoCampo("txt_4c_ContaACs")
3196:     ENDPROC
3197: 
3198:     PROCEDURE CMoesGotFoco()
3199:         THIS.SalvarTagCampo("txt_4c_CMoes")
3200:     ENDPROC
3201:     PROCEDURE CMoesPerdeFoco()
3202:         THIS.VerificarAlteracaoCampo("txt_4c_CMoes")
3203:     ENDPROC
3204: 
3205:     PROCEDURE TitBansGotFoco()
3206:         THIS.SalvarTagCampo("txt_4c_TitBans")
3207:     ENDPROC
3208:     PROCEDURE TitBansPerdeFoco()
3209:         THIS.VerificarAlteracaoCampo("txt_4c_TitBans")
3210:     ENDPROC
3211: 
3212:     PROCEDURE MovTitsGotFoco()
3213:         THIS.SalvarTagCampo("txt_4c_MovTits")
3214:     ENDPROC
3215:     PROCEDURE MovTitsPerdeFoco()
3216:         THIS.VerificarAlteracaoCampo("txt_4c_MovTits")
3217:     ENDPROC
3218: 
3219:     PROCEDURE TiposGotFoco()
3220:         THIS.SalvarTagCampo("txt_4c_Tipos")
3221:     ENDPROC
3222:     PROCEDURE TiposPerdeFoco()
3223:         THIS.VerificarAlteracaoCampo("txt_4c_Tipos")
3224:     ENDPROC
3225: 
3226:     PROCEDURE GetNotasGotFoco()
3227:         THIS.SalvarTagCampo("obj_4c_GetNotas")
3228:     ENDPROC
3229:     PROCEDURE GetNotasPerdeFoco()
3230:         THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetNotas")
3231:     ENDPROC
3232: 
3233:     PROCEDURE GetComandosGotFoco()
3234:         THIS.SalvarTagCampo("obj_4c_GetComandos")
3235:     ENDPROC
3236:     PROCEDURE GetComandosPerdeFoco()
3237:         THIS.VerificarAlteracaoEMaiusculizar("obj_4c_GetComandos")
3238:     ENDPROC
3239: 
3240:     PROCEDURE ChkP1CmvsGotFoco()
3241:         THIS.SalvarTagCampo("chk_4c_Chk_P1_CMVS")
3242:     ENDPROC
3243:     PROCEDURE ChkP1CmvsPerdeFoco()
3244:         THIS.VerificarAlteracaoCampo("chk_4c_Chk_P1_CMVS")
3245:     ENDPROC
3246: 
3247:     PROCEDURE ChkP2MobsGotFoco()
3248:         THIS.SalvarTagCampo("chk_4c_Chk_P2_MOBS")
3249:     ENDPROC
3250:     PROCEDURE ChkP2MobsPerdeFoco()
3251:         THIS.VerificarAlteracaoCampo("chk_4c_Chk_P2_MOBS")
3252:     ENDPROC
3253: 
3254:     *--------------------------------------------------------------------------
3255:     * BtnSairClick - equivalente a SIGOPFIN.Sair.Click do legado (dump linhas
3256:     * 1606-1732): valida a grade quando houve alteracao, oferece abandonar os
3257:     * dados se a validacao falhar, remove as linhas em branco e grava. PUBLIC
3258:     * por exigencia do BINDEVENT (regra CLAUDE.md #3).
3259:     *
3260:     * Legado:
3261:     *   llOks = .t.
3262:     *   If Not Empty(lcMsg)
3263:     *       If (MessageBox(lcMsg + [Deseja Sair ...], 4+32+256, ...) = 6)
3264:     *           Zap In crGrdValores / plAlterou = .f. / llOks = .t.
3265:     *       Else
3266:     *           grdValores.Refresh/SetFocus/AfterRowColChange() / llOks = .f.
3267:     *       EndIf
3268:     *   EndIf
3269:     *   If llOks
3270:     *       Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
3271:     *       If ThisForm.GravarDados() / ThisForm.Release() / Else llOks=.f.
3272:     *   EndIf
3273:     *--------------------------------------------------------------------------
3274:     PROCEDURE BtnSairClick()
3275:         LOCAL loc_cMsg, loc_lOk, loc_oErro
3276:         loc_cMsg = ""
3277:         loc_lOk  = .T.
3278: 
3279:         TRY
3280:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3281:                 loc_cMsg = THIS.ValidarGradeValores()
3282:             ENDIF
3283: 
3284:             IF !EMPTY(loc_cMsg)
3285:                 IF MsgConfirma(loc_cMsg + CHR(13) + "Deseja Sair da Tela e " + ;
3286:                         "Abandonar Todos os Dados Alterados?", ;
3287:                         "Erro: Dados Inconsistentes")
3288:                     IF USED("cursor_4c_GrdValores")
3289:                         SELECT cursor_4c_GrdValores
3290:                         ZAP
3291:                     ENDIF
3292:                     THIS.this_lAlterou = .F.
3293:                     loc_lOk = .T.
3294:                 ELSE
3295:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3296:                         THIS.grd_4c_Dados.Refresh()
3297:                         THIS.grd_4c_Dados.SetFocus()
3298:                     ENDIF
3299:                     THIS.AfterRowColChange()
3300:                     loc_lOk = .F.
3301:                 ENDIF
3302:             ENDIF
3303: 
3304:             IF loc_lOk
3305:                 IF USED("cursor_4c_GrdValores")
3306:                     DELETE FROM cursor_4c_GrdValores ;
3307:                         WHERE EMPTY(Codigos) OR EMPTY(Descrs)
3308:                 ENDIF
3309: 
3310:                 IF THIS.GravarDados()
3311:                     THIS.Release()
3312:                 ELSE
3313:                     loc_lOk = .F.
3314:                 ENDIF
3315:             ENDIF
3316:         CATCH TO loc_oErro
3317:             MsgErro(loc_oErro.Message + CHR(13) + ;
3318:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3319:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
3320:         ENDTRY
3321:     ENDPROC
3322: 
3323:     *--------------------------------------------------------------------------
3324:     * ValidarGradeValores - equivalente ao trecho de validacao do
3325:     * SIGOPFIN.Sair.Click legado: "Select * From crGrdValores Where Not
3326:     * Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair" + "Scan
3327:     * While Empty(lcMsg)". Devolve a mensagem de inconsistencia (vazia se
3328:     * tudo estiver OK).
3329:     *
3330:     * Fidelidade a uma peculiaridade do legado: dentro de UMA linha, todos os
3331:     * IFs rodam em sequencia (nenhum e guardado por "Empty(lcMsg)" entre si),
3332:     * entao se MAIS DE UM campo da MESMA linha estiver vazio, loc_cMsg fica
3333:     * com o ULTIMO que bateu (nao o primeiro) - e so DEPOIS de terminar a
3334:     * linha inteira o "Scan While Empty(lcMsg)" para de avancar para a
3335:     * proxima. Por isso o EXIT fica no TOPO do corpo do SCAN, nao substitui o
3336:     * SCAN por "SCAN WHILE".
3337:     *--------------------------------------------------------------------------
3338:     PROTECTED FUNCTION ValidarGradeValores()
3339:         LOCAL loc_cMsg, loc_oErro
3340:         loc_cMsg = ""
3341: 
3342:         TRY
3343:             IF USED("cursor_4c_GrdValores")
3344:                 THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3345: 
3346:                 SELECT * FROM cursor_4c_GrdValores ;
3347:                     WHERE !EMPTY(Codigos) AND !EMPTY(Descrs) ;
3348:                     INTO CURSOR cursor_4c_LocalSair READWRITE
3349: 
3350:                 SELECT cursor_4c_LocalSair
3351:                 GO TOP
3352:                 SCAN
3353:                     IF !EMPTY(loc_cMsg)
3354:                         EXIT
3355:                     ENDIF
3356: 
3357:                     IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LocalSair.Notas, "")))
3358:                         loc_cMsg = "O Campo " + CHR(34) + "Notas Sobre a " + ;
3359:                             "Configura" + CHR(231) + CHR(227) + "o" + CHR(34) + ;

*-- Linhas 3413 a 3487:
3413:             THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3414:             MsgErro(loc_oErro.Message + CHR(13) + ;
3415:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3416:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGradeValores")
3417:         ENDTRY
3418: 
3419:         RETURN loc_cMsg
3420:     ENDFUNC
3421: 
3422:     *--------------------------------------------------------------------------
3423:     * ValidarCampoGradeVazio - um unico "If Empty(LocalSair.<Campo>)" do
3424:     * Click legado: testa a coluna par_cCampo da linha corrente de
3425:     * cursor_4c_LocalSair e, vazia, monta a mensagem e foca o campo
3426:     * correspondente da grade (par_cCampoForm). par_cMsg e passado por
3427:     * referencia para reproduzir a sobrescrita sequencial do legado (regra de
3428:     * ValidarGradeValores acima).
3429:     *--------------------------------------------------------------------------
3430:     PROTECTED PROCEDURE ValidarCampoGradeVazio(par_cCampo, par_cCampoForm, par_cRotulo, par_cMsg)
3431:         LOCAL loc_oCtrl
3432: 
3433:         IF EMPTY(EVALUATE("cursor_4c_LocalSair." + par_cCampo))
3434:             par_cMsg = "O Campo " + CHR(34) + par_cRotulo + CHR(34) + ;
3435:                 " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
3436:                 "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
3437:             IF PEMSTATUS(THIS, par_cCampoForm, 5)
3438:                 loc_oCtrl = EVALUATE("THIS." + par_cCampoForm)
3439:                 IF VARTYPE(loc_oCtrl) = "O"
3440:                     loc_oCtrl.SetFocus()
3441:                 ENDIF
3442:             ENDIF
3443:         ENDIF
3444:     ENDPROC
3445: 
3446:     *--------------------------------------------------------------------------
3447:     * GravarDados - equivalente ao PROCEDURE gravardados do legado (dump
3448:     * linhas 1367-1412). So grava quando EmModoEdicao() e this_lAlterou (o
3449:     * legado: "If InList(pcEscolha,[INSERIR],[ALTERAR]) And plAlterou"); caso
3450:     * contrario devolve .T. sem fazer nada, igual ao legado ("Return .t."
3451:     * fora do IF).
3452:     *
3453:     * Em ALTERAR, o legado apaga TODAS as linhas antigas de SigOpFin para
3454:     * este Dopes e reinsere TODAS as linhas validas da grade (delete-then-
3455:     * reinsert, nao um diff) - aqui reproduzido com DELETE via SQLEXEC +
3456:     * sigopfinBO.Inserir() por linha, renumerando Ordem sequencialmente.
3457:     *
3458:     * Desvio assumido (documentado, nao e regra de negocio visivel ao
3459:     * usuario): o legado preserva UsuIncs/DatIncs/UsuAlts/DatAlts das linhas
3460:     * pre-existentes no delete-then-reinsert (Iif(pcEscolha=INSERIR Or
3461:     * Empty(m.UsuIncs), Usuar, m.UsuIncs), e similar para os outros tres);
3462:     * sigopfinBO.Inserir() sempre estampa this_cUsuIncs=gc_4c_UsuarioLogado,
3463:     * datincs=GETDATE() e datalts=NULL (nao ha gancho para preservar os
3464:     * valores originais sem reescrever o BO), e this_cUsuAlts fica no
3465:     * default "" do BO (nenhuma linha reinserida e tratada como "alterada"
3466:     * por este fluxo). O rastro de quem/quando INCLUIU de fato fica no
3467:     * LogAuditoria via RegistrarAuditoria(), chamado dentro do proprio
3468:     * Inserir().
3469:     *--------------------------------------------------------------------------
3470:     PROTECTED FUNCTION GravarDados()
3471:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nOrdem, loc_oLinha, loc_oErro
3472:         loc_lSucesso = .T.
3473: 
3474:         TRY
3475:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3476: 
3477:                 IF UPPER(ALLTRIM(THIS.this_cModoAtual)) = "ALTERAR"
3478:                     loc_cSQL = "DELETE FROM sigopfin WHERE dopes = " + ;
3479:                         EscaparSQL(THIS.this_cDopes)
3480: 
3481:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3482:                     IF loc_nResultado < 0
3483:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3484:                             CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
3485:                         loc_lSucesso = .F.
3486:                     ENDIF
3487:                 ENDIF

*-- Linhas 3494 a 3537:
3494:                     SCAN FOR !EMPTY(Codigos)
3495:                         loc_nOrdem = loc_nOrdem + 1
3496: 
3497:                         loc_oLinha = CREATEOBJECT("sigopfinBO")
3498:                         IF VARTYPE(loc_oLinha) = "O"
3499:                             *-- CarregarDoCursor() do BO NAO serve aqui: ele le
3500:                             *-- cidchaves/chkempds, colunas que NAO existem em
3501:                             *-- cursor_4c_GrdValores (CriarCursorGrdValores so
3502:                             *-- declara os campos que a grade/campos de
3503:                             *-- detalhe usam - cidchaves e gerado de novo a
3504:                             *-- cada Inserir() e chkempds nao tem controle na
3505:                             *-- tela). Chama-lo estouraria "Variable CIDCHAVES
3506:                             *-- is not found". Os campos sao copiados um a um.
3507:                             loc_oLinha.this_cCodigos  = TratarNulo(cursor_4c_GrdValores.Codigos,  "")
3508:                             loc_oLinha.this_cComandos = TratarNulo(cursor_4c_GrdValores.Comandos, "")
3509:                             loc_oLinha.this_cContaAcs = TratarNulo(cursor_4c_GrdValores.ContaACs,  "")
3510:                             loc_oLinha.this_cContaAds = TratarNulo(cursor_4c_GrdValores.ContaADs,  "")
3511:                             loc_oLinha.this_cContaCcs = TratarNulo(cursor_4c_GrdValores.ContaCCs,  "")
3512:                             loc_oLinha.this_cContaCds = TratarNulo(cursor_4c_GrdValores.ContaCDs,  "")
3513:                             loc_oLinha.this_cContaEcs = TratarNulo(cursor_4c_GrdValores.ContaECs,  "")
3514:                             loc_oLinha.this_cContaEds = TratarNulo(cursor_4c_GrdValores.ContaEDs,  "")
3515:                             loc_oLinha.this_cContaPcs = TratarNulo(cursor_4c_GrdValores.ContaPCs,  "")
3516:                             loc_oLinha.this_cContaPds = TratarNulo(cursor_4c_GrdValores.ContaPDs,  "")
3517:                             loc_oLinha.this_cDopes    = THIS.this_cDopes
3518:                             loc_oLinha.this_cGrupoAcs = TratarNulo(cursor_4c_GrdValores.GrupoACs,  "")
3519:                             loc_oLinha.this_cGrupoAds = TratarNulo(cursor_4c_GrdValores.GrupoADs,  "")
3520:                             loc_oLinha.this_cGrupoCcs = TratarNulo(cursor_4c_GrdValores.GrupoCCs,  "")
3521:                             loc_oLinha.this_cGrupoCds = TratarNulo(cursor_4c_GrdValores.GrupoCDs,  "")
3522:                             loc_oLinha.this_cGrupoEcs = TratarNulo(cursor_4c_GrdValores.GrupoECs,  "")
3523:                             loc_oLinha.this_cGrupoEds = TratarNulo(cursor_4c_GrdValores.GrupoEDs,  "")
3524:                             loc_oLinha.this_cGrupoPcs = TratarNulo(cursor_4c_GrdValores.GrupoPCs,  "")
3525:                             loc_oLinha.this_cGrupoPds = TratarNulo(cursor_4c_GrdValores.GrupoPDs,  "")
3526:                             loc_oLinha.this_cMoedas   = TratarNulo(cursor_4c_GrdValores.Moedas,    "")
3527:                             loc_oLinha.this_cMovTits  = TratarNulo(cursor_4c_GrdValores.MovTits,   "")
3528:                             loc_oLinha.this_cNotas    = TratarNulo(cursor_4c_GrdValores.Notas,     "")
3529:                             loc_oLinha.this_nOrdem    = loc_nOrdem
3530:                             loc_oLinha.this_cTipos    = TratarNulo(cursor_4c_GrdValores.Tipos,     "")
3531:                             loc_oLinha.this_cTitBans  = TratarNulo(cursor_4c_GrdValores.TitBans,   "")
3532: 
3533:                             IF !loc_oLinha.Inserir()
3534:                                 loc_lSucesso = .F.
3535:                             ENDIF
3536:                         ELSE
3537:                             MsgErro("Falha ao criar sigopfinBO.", "Erro")

*-- Linhas 3552 a 3595:
3552:             loc_lSucesso = .F.
3553:             MsgErro(loc_oErro.Message + CHR(13) + ;
3554:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3555:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopfin.GravarDados")
3556:         ENDTRY
3557: 
3558:         RETURN loc_lSucesso
3559:     ENDFUNC
3560: 
3561:     *--------------------------------------------------------------------------
3562:     * AtualizarConfigFinanceiraOperacao - equivalente a "Replace CfgFinancs
3563:     * With Padr(chk_P1_CMVS.Value,1) + Padr(chk_P2_MOBS.Value,1) +
3564:     * Substr(crSigCdOpe.CfgFinancs,3,18) In crSigCdOpe" (fim do gravardados
3565:     * legado). crSigCdOpe no legado e o registro da operacao (SigCdOpe, PK
3566:     * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
3567:     * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
3568:     * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
3569:     * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
3570:     * blank-padding ANSI do SQL Server.
3571:     *
3572:     * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
3573:     * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma
3574:     * inconsistencia que nao e deste form).
3575:     *--------------------------------------------------------------------------
3576:     PROTECTED FUNCTION AtualizarConfigFinanceiraOperacao()
3577:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCfgAtual, loc_cCfgNova, loc_oErro
3578:         loc_lSucesso = .T.
3579: 
3580:         TRY
3581:             THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3582: 
3583:             loc_cSQL = "SELECT cfgfinancs FROM SigCdOpe WHERE dopes = " + ;
3584:                 EscaparSQL(THIS.this_cDopes)
3585: 
3586:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgFinTmp")
3587: 
3588:             IF loc_nResultado >= 0 AND USED("cursor_4c_CfgFinTmp") ;
3589:                     AND RECCOUNT("cursor_4c_CfgFinTmp") > 0
3590:                 loc_cCfgAtual = PADR(TratarNulo(cursor_4c_CfgFinTmp.cfgfinancs, ""), 20)
3591: 
3592:                 loc_cCfgNova = PADR(IIF(THIS.chk_4c_Chk_P1_CMVS.Value = 1, "S", "N"), 1) + ;
3593:                                PADR(IIF(THIS.chk_4c_Chk_P2_MOBS.Value = 1, "S", "N"), 1) + ;
3594:                                SUBSTR(loc_cCfgAtual, 3, 18)
3595: 

*-- Linhas 3612 a 3702:
3612:             loc_lSucesso = .F.
3613:             MsgErro(loc_oErro.Message + CHR(13) + ;
3614:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3615:                 "Procedure: " + loc_oErro.Procedure, ;
3616:                 "Erro em AtualizarConfigFinanceiraOperacao")
3617:         ENDTRY
3618: 
3619:         RETURN loc_lSucesso
3620:     ENDFUNC
3621: 
3622: ENDDEFINE
3623: 
3624: *==============================================================================
3625: * TextBoxOrigemSigOpFin_4c - celula da coluna "Origem dos Valores a Serem
3626: * Lancados na Movimentacao Financeira" (grd_4c_Dados.Column1), equivalente ao
3627: * SIGOPFIN.grdValores.Column1.Text1 do legado.
3628: *
3629: * Os eventos ficam EMBUTIDOS na classe, nao ligados por BINDEVENT: em VFP9,
3630: * BINDEVENT no Valid de um TextBox dentro de Column nao dispara de forma
3631: * confiavel, e validar a celula no AfterRowColChange da grade valida a linha
3632: * ERRADA, porque o nColIndex que esse evento entrega e a coluna de DESTINO
3633: * (regra CLAUDE.md #46). O corpo de cada evento apenas delega para um metodo
3634: * PUBLIC do form, onde a regra de negocio mora.
3635: *
3636: * Instalada por Formsigopfin.InstalarCelulaOrigem(), que tambem cuida do
3637: * CurrentControl/Sparse/ReadOnly da Column.
3638: *==============================================================================
3639: DEFINE CLASS TextBoxOrigemSigOpFin_4c AS TextBox
3640: 
3641:     FontName   = "Tahoma"
3642:     FontSize   = 8
3643:     BorderStyle = 0
3644:     Margin     = 0
3645:     MaxLength  = 100
3646: 
3647:     *--------------------------------------------------------------------------
3648:     * When - legado: "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])"
3649:     * (a celula so aceita digitacao em inclusao/alteracao).
3650:     *--------------------------------------------------------------------------
3651:     PROCEDURE When()
3652:         RETURN THISFORM.EmModoEdicao()
3653:     ENDPROC
3654: 
3655:     *--------------------------------------------------------------------------
3656:     * GotFocus - legado: "This.Tag = This.Value". O Tag guarda o valor de
3657:     * entrada; o Valid so dispara o lookup quando ele mudou.
3658:     *--------------------------------------------------------------------------
3659:     PROCEDURE GotFocus()
3660:         THIS.Tag = ALLTRIM(TRANSFORM(THIS.Value))
3661:     ENDPROC
3662: 
3663:     *--------------------------------------------------------------------------
3664:     * Valid - legado: Locate em crTabOpFin pela descricao digitada e, nao
3665:     * achando, picker; depois Replace Codigos/Descrs na linha da grade.
3666:     *--------------------------------------------------------------------------
3667:     PROCEDURE Valid()
3668:         THISFORM.AbrirLookupOrigemGrade(THIS)
3669:         RETURN .T.
3670:     ENDPROC
3671: 
3672:     *--------------------------------------------------------------------------
3673:     * LostFocus - legado: avanca para a proxima linha da grade (e insere uma
3674:     * em branco, se for a ultima) quando a saida foi por ENTER com a linha
3675:     * preenchida. O dirty-tracking (This.Tag <> This.Value) desta mesma
3676:     * celula ja e feito em AbrirLookupOrigemGradeExec (chamado pelo Valid,
3677:     * que roda ANTES do LostFocus na ordem real do VFP9) - aqui so a parte
3678:     * de navegacao, delegada ao form (Fase 7).
3679:     *--------------------------------------------------------------------------
3680:     PROCEDURE LostFocus()
3681:         THISFORM.AvancarLinhaGradeOrigem()
3682:     ENDPROC
3683: 
3684:     *--------------------------------------------------------------------------
3685:     * KeyPress - atalho F4/F5 para abrir a lista (convencao do sistema novo).
3686:     * A tecla E testada: sem o teste o picker subiria a cada caractere.
3687:     *--------------------------------------------------------------------------
3688:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3689:         IF INLIST(par_nKeyCode, 115, 116)
3690:             THISFORM.AbrirLookupOrigemGrade(THIS)
3691:             NODEFAULT
3692:         ENDIF
3693:     ENDPROC
3694: 
3695:     *--------------------------------------------------------------------------
3696:     * DblClick - atalho de mouse para abrir a lista.
3697:     *--------------------------------------------------------------------------
3698:     PROCEDURE DblClick()
3699:         THISFORM.AbrirLookupOrigemGrade(THIS)
3700:     ENDPROC
3701: 
3702: ENDDEFINE


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

