# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarItensPedido()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ENDFOR define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDFOR.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1313 linhas total):

*-- Linhas 27 a 70:
27: * visiveis aqui pelo mesmo motivo.
28: *
29: * Montagem: Fase 3 - estrutura base (DEFINE CLASS, Init/Destroy/
30: * InicializarForm, cabecalho cnt_4c_Sombra, TornarControlesVisiveis).
31: * Fase 4 - as duas grades (grd_4c_GrdCab/grd_4c_GrdIte) com a carga de
32: * dados (CarregarLista/CarregarItensPedido) e os dois botoes de acao.
33: * Fase 6 - pedido corrente -> BO (SincronizarPedidoCorrente), os dois guards
34: * do legado (ValidarPedidoSelecionado/ValidarSaidaSemConfirmar), os
35: * membros publicos pcEscolha/GrupoOper e ProcessaPeriodo().
36: * Roteiro completo em ConfigurarPageFrame().
37: *==============================================================================
38: 
39: DEFINE CLASS FormSigPrGst AS FormBase
40: 
41:     *--------------------------------------------------------------------------
42:     * Propriedades do form (SIGPRGST.SCX: Width=1000, Height=600, BorderStyle=2,
43:     * AutoCenter=.T., ControlBox=.F., Movable=.F., KeyPreview=.T., TitleBar=0,
44:     * WindowType=1 - dump de SigPrGst_form_codigo_fonte.txt, linhas 222-235)
45:     *--------------------------------------------------------------------------
46:     Width        = 1000
47:     Height       = 600
48:     AutoCenter   = .T.
49:     TitleBar     = 0
50:     ShowWindow   = 1
51:     WindowType   = 1
52:     ControlBox   = .F.
53:     Movable      = .F.
54:     KeyPreview   = .T.
55:     Closable     = .F.
56:     MaxButton    = .F.
57:     MinButton    = .F.
58:     ClipControls = .F.
59:     BorderStyle  = 2
60:     FontName     = "Tahoma"
61:     FontSize     = 8
62: 
63:     Caption = "Gera" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(245) + "es de Estoque"
64: 
65:     *--------------------------------------------------------------------------
66:     * ThisForm.ParentForm do legado - form que ja populou csCabec/csItens/
67:     * csEstPe/CrSigCdNec/CrSigCdEmb antes de abrir esta tela (ver cabecalho
68:     * do arquivo). Guardado apenas para repassar pcEscolha ao BO no Init -
69:     * nenhum metodo com codigo do dump le mais nada de volta dele.
70:     *--------------------------------------------------------------------------

*-- Linhas 91 a 409:
91:     *--------------------------------------------------------------------------
92:     * Init - recebe o form pai (equivalente a "Parameters poform" do legado)
93:     * e cria o Business Object ANTES do DODEFAULT(), para que
94:     * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
95:     * encontre pronto. Repassa pcEscolha do pai para o BO (equivalente a
96:     * "ThisForm.PcEscolha = ThisForm.ParentForm.pcEscolha").
97:     *--------------------------------------------------------------------------
98:     PROCEDURE Init()
99:         LPARAMETERS par_oFormPai
100:         LOCAL loc_lSucesso, loc_oErro
101:         loc_lSucesso = .F.
102: 
103:         TRY
104:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGstBO")
105: 
106:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
107:                 *-- "ThisForm.GrupoOper = Space(10)" do Init legado
108:                 THIS.GrupoOper = SPACE(10)
109:                 THIS.this_oBusinessObject.this_cGrupoOper = SPACE(10)
110: 
111:                 IF PCOUNT() >= 1 AND VARTYPE(par_oFormPai) = "O"
112:                     THIS.this_oFormPai = par_oFormPai
113: 
114:                     IF PEMSTATUS(par_oFormPai, "pcEscolha", 5)
115:                         *-- "ThisForm.PcEscolha = ThisForm.ParentForm.pcEscolha"
116:                         THIS.pcEscolha = PADR(TratarNulo(par_oFormPai.pcEscolha, ""), 10)
117:                         THIS.this_oBusinessObject.this_cPcEscolha = THIS.pcEscolha
118:                     ENDIF
119:                 ENDIF
120: 
121:                 loc_lSucesso = DODEFAULT()
122:             ENDIF
123:         CATCH TO loc_oErro
124:             MsgErro("Erro ao inicializar Gera" + CHR(231) + CHR(227) + "o de Movimenta" + ;
125:                 CHR(231) + CHR(245) + "es de Estoque: " + loc_oErro.Message, "Erro")
126:         ENDTRY
127: 
128:         RETURN loc_lSucesso
129:     ENDPROC
130: 
131:     *--------------------------------------------------------------------------
132:     * Destroy - encadeia direto para FormBase.Destroy() (libera
133:     * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
134:     * eh liberado aqui - pertence a quem o criou.
135:     *--------------------------------------------------------------------------
136:     PROCEDURE Destroy()
137:         DODEFAULT()
138:     ENDPROC
139: 
140:     *--------------------------------------------------------------------------
141:     * InicializarForm - monta a tela inteira via ConfigurarPageFrame(): fundo,
142:     * cabecalho, as duas grades (ja ligadas aos cursores do form pai) e os dois
143:     * botoes de acao. Os Click dos botoes entram na fase de eventos.
144:     *--------------------------------------------------------------------------
145:     PROTECTED PROCEDURE InicializarForm()
146:         LOCAL loc_lSucesso, loc_oErro, loc_cPicture
147:         loc_lSucesso = .F.
148: 
149:         TRY
150:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
151:                 MsgErro("Falha ao criar SigPrGstBO.", "Erro")
152:             ELSE
153:                 loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
154:                 IF FILE(loc_cPicture)
155:                     THIS.Picture = loc_cPicture
156:                 ENDIF
157: 
158:                 THIS.ConfigurarPageFrame()
159: 
160:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
161:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
162: 
163:                 THIS.TornarControlesVisiveis(THIS)
164: 
165:                 loc_lSucesso = .T.
166:             ENDIF
167:         CATCH TO loc_oErro
168:             MsgErro(loc_oErro.Message + CHR(13) + ;
169:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
170:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.InicializarForm")
171:         ENDTRY
172: 
173:         RETURN loc_lSucesso
174:     ENDPROC
175: 
176:     *--------------------------------------------------------------------------
177:     * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRGST nao
178:     * tem PageFrame no legado (layout flat: cntSombra + 2 grids + 2 botoes
179:     * no proprio form) - o nome do metodo eh mantido apenas como ponto de
180:     * entrada arquitetural padrao (mesmo papel em FormSigPrGmi/FormSigPrGlp).
181:     *
182:     * NOTA SOBRE O ROTEIRO GENERICO DE 8 FASES: o template padrao da Fase 4
183:     * ("Grid e botoes CRUD - Page1") pressupoe form CRUD com PageFrame
184:     * Lista/Dados e 6 botoes (Incluir/Visualizar/Alterar/Excluir/Buscar/
185:     * Encerrar). SIGPRGST NAO tem essa superficie - o dump legado (Secao 1
186:     * do .txt) prova PageFrame=0, e os UNICOS botoes do form inteiro sao
187:     * CmdCancela ("Sair") e CmdGrava ("Confirmar"). Inventar PageFrame
188:     * Lista/Dados ou os 6 botoes CRUD viola o PILAR 1 (UX) e a regra "NUNCA
189:     * inventar" (CLAUDE.md) - mesma familia de caso documentada para
190:     * SIGMVEXP/SIGPDMEN/SIGMVVDE/SIGPRCCC (formularios OPERACIONAL cuja
191:     * superficie real nao casa com o template CRUD). Esta fase entrega,
192:     * em vez disso, a superficie REAL do legado: os dois grids de lista
193:     * (csCabec/csItens) e os dois botoes de acao.
194:     *
195:     * Historico de montagem (migracao multi-fase):
196:     *   Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra)
197:     *   Fase 4 (esta)  - ConfigurarGrids() (grd_4c_GrdCab + grd_4c_GrdIte,
198:     *                     formatadas por FormatarGridCabecalho()/
199:     *                     FormatarGridItens()) + CarregarLista() /
200:     *                     CarregarItensPedido() (funil unico do bind a
201:     *                     csCabec/csItens, usado tambem pelo
202:     *                     GrdCabAfterRowColChange) + ConfigurarBotoesAcao()
203:     *                     (shp_4c_ShpP2 decorativo + cmd_4c_CmdGrava +
204:     *                     cmd_4c_CmdCancela)
205:     *   Fase 6 (esta)  - a superficie de DADOS que este legado de fato tem.
206:     *                     NAO ha campo nem lookup a acrescentar, e isso esta
207:     *                     PROVADO pelo dump: a Secao 1 nao lista um unico
208:     *                     controle de entrada (textbox/combobox/checkbox/
209:     *                     optiongroup/spinner) fora das colunas das grades, as
210:     *                     colunas das DUAS grades sao ReadOnly = .T. (Secao 2)
211:     *                     e o arquivo inteiro nao tem UMA ocorrencia de
212:     *                     fwBuscaExt/fwBuscaSel/mAddColuna/sigacess/Acesso* -
213:     *                     o unico CreateObject do form eh fwprogressbar, dentro
214:     *                     de gerarpedido. Inventar uma Page2 de Dados, um campo
215:     *                     com ControlSource ou um lookup para alguma tabela
216:     *                     auxiliar violaria o PILAR 1 e a regra explicita
217:     *                     "NUNCA inventar tabelas de lookup que nao existem no
218:     *                     original"; metodo de lookup vazio seria stub
219:     *                     disfarcado. O dado de ENTRADA desta tela eh a LINHA
220:     *                     selecionada em csCabec - e eh isso que a fase
221:     *                     entrega: SincronizarPedidoCorrente() (a linha
222:     *                     corrente alimentando as propriedades do BO, nos dois
223:     *                     caminhos que a mudam), ValidarPedidoSelecionado() e
224:     *                     ValidarSaidaSemConfirmar() (os dois guards
225:     *                     transcritos do topo de CmdGrava.Click e de
226:     *                     CmdCancela.Click, que a Fase 7 vai chamar), os
227:     *                     membros publicos pcEscolha/GrupoOper e o metodo de
228:     *                     contrato ProcessaPeriodo() (ClassInfo do SCX).
229:     *   Fase 7 (esta)  - BINDEVENT de Click em cmd_4c_CmdGrava/cmd_4c_CmdCancela
230:     *                     (BtnConfirmarClick: ValidarPedidoSelecionado() ->
231:     *                     this_oBusinessObject.GerarPedido() -> abrir
232:     *                     Formsigmvcab; BtnCancelarClick:
233:     *                     ValidarSaidaSemConfirmar() -> THIS.Release())
234:     *==========================================================================
235:     PROTECTED PROCEDURE ConfigurarPageFrame()
236:         THIS.ConfigurarCabecalho()
237:         THIS.ConfigurarGrids()
238:         THIS.ConfigurarBotoesAcao()
239:     ENDPROC
240: 
241:     *--------------------------------------------------------------------------
242:     * ConfigurarGrids - cria grd_4c_GrdCab (pedidos a gerar, csCabec) e
243:     * grd_4c_GrdIte (itens do pedido corrente, csItens) com a geometria e as
244:     * propriedades estaticas transcritas do dump legado
245:     * (SigPrGst_form_codigo_fonte.txt, Secao 2 - GrdCab/GrdIte).
246:     *
247:     * ATENCAO ao mapear as colunas do dump: o SCX guarda a ORDEM FISICA dos
248:     * registros de coluna com "ColumnN.Name = ColumnM", e o legado referencia
249:     * as colunas pelo NOME (With ThisForm.GrdCab / .Column3.ControlSource),
250:     * exibindo-as na ordem de ColumnOrder. No GrdCab os dois nao coincidem:
251:     *
252:     *   ColumnOrder | objeto legado | Header          | Width | ControlSource
253:     *   ------------+---------------+-----------------+-------+---------------
254:     *        1      | Column1       | Emp             |    35 | csCabec.EmpDs
255:     *        2      | Column7       | Movimentacao    |   225 | csCabec.Dopes
256:     *        3      | Column2       | Grupo Origem    |   100 | csCabec.GrupoOs
257:     *        4      | Column3       | Conta Origem    |   100 | csCabec.ContaOs
258:     *        5      | Column5       | Grupo Destino   |   100 | csCabec.GrupoDs
259:     *        6      | Column4       | Conta Destino   |   100 | csCabec.ContaDs
260:     *        7      | Column6       | Confirmacao     |   100 | csCabec.Gerado
261:     *
262:     * (35+225+5*100 = 760, dentro do Width=798 da grade). Aqui as colunas sao
263:     * criadas por POSICAO (.Column1 .. .Column7 de um Grid com ColumnCount=7),
264:     * entao a posicao N recebe o que o legado exibe em ColumnOrder = N - e NAO
265:     * o registro N do dump. No GrdIte as duas ordens coincidem (ColumnOrder 1
266:     * a 7 = Column1 a Column7), mas as larguras tambem precisam vir por NOME:
267:     * 36 / 120 / 403 / 23 / 130 / 100 / 130 (soma 942, Width=980).
268:     *
269:     * O bind de dados NAO fica aqui: csCabec/csItens sao abertos pelo form PAI
270:     * (DataSession=1, sessao compartilhada - ver cabecalho do arquivo) e podem
271:     * nao existir ainda. Toda a ligacao com os cursores vive em
272:     * CarregarLista()/CarregarItensPedido(), que sao o funil unico desse
273:     * trabalho - chamado tambem quando o usuario troca de linha na grade de
274:     * cabecalho.
275:     *--------------------------------------------------------------------------
276:     PROTECTED PROCEDURE ConfigurarGrids()
277:         LOCAL loc_oErro
278: 
279:         TRY
280:             *----------------------------------------------------------------
281:             * grd_4c_GrdCab - pedidos ainda nao gerados (csCabec)
282:             *----------------------------------------------------------------
283:             THIS.AddObject("grd_4c_GrdCab", "Grid")
284:             WITH THIS.grd_4c_GrdCab
285:                 .Top               = 95
286:                 .Left              = 11
287:                 .Width             = 798
288:                 .Height            = 194
289:                 .FontName          = "Tahoma"
290:                 .FontSize          = 8
291:                 .ColumnCount       = 7
292:                 .AllowHeaderSizing = .F.
293:                 .AllowRowSizing    = .F.
294:                 .DeleteMark        = .F.
295:                 .RecordMark        = .F.
296:                 .ReadOnly          = .T.
297:                 .HeaderHeight      = 15
298:                 .RowHeight         = 16
299:                 .ScrollBars        = 2
300:                 .TabStop           = .F.
301:                 .GridLineColor     = RGB(238, 238, 238)
302:                 .Visible           = .T.
303:             ENDWITH
304: 
305:             *-- Colunas/cabecalhos. O ReadOnly de cada coluna fica em
306:             *-- FormatarGridCabecalho porque tem de vir DEPOIS do
307:             *-- Grid.ReadOnly acima, que propaga para as colunas
308:             THIS.FormatarGridCabecalho()
309: 
310:             BINDEVENT(THIS.grd_4c_GrdCab, "AfterRowColChange", THIS, "GrdCabAfterRowColChange")
311: 
312:             *----------------------------------------------------------------
313:             * grd_4c_GrdIte - itens do pedido corrente (csItens, escopado por
314:             * csCabec.EmpDopNums em CarregarItensPedido)
315:             *----------------------------------------------------------------
316:             THIS.AddObject("grd_4c_GrdIte", "Grid")
317:             WITH THIS.grd_4c_GrdIte
318:                 .Top               = 295
319:                 .Left              = 10
320:                 .Width             = 980
321:                 .Height            = 289
322:                 .FontName          = "Tahoma"
323:                 .FontSize          = 8
324:                 .ColumnCount       = 7
325:                 .AllowHeaderSizing = .F.
326:                 .AllowRowSizing    = .F.
327:                 .DeleteMark        = .F.
328:                 .RecordMark        = .F.
329:                 .ReadOnly          = .T.
330:                 .HeaderHeight      = 15
331:                 .RowHeight         = 16
332:                 .ScrollBars        = 2
333:                 .TabStop           = .F.
334:                 .GridLineColor     = RGB(238, 238, 238)
335:                 .Visible           = .T.
336:             ENDWITH
337: 
338:             THIS.FormatarGridItens()
339: 
340:             *-- Carga inicial: equivalente ao bloco final do Init legado
341:             *-- (Select CsCabec / Go Top / Select CsItens / Set Key To ... /
342:             *--  With ThisForm.GrdCab ... / With ThisForm.GrdIte ...)
343:             THIS.CarregarLista()
344:         CATCH TO loc_oErro
345:             MsgErro(loc_oErro.Message + CHR(13) + ;
346:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
347:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrids")
348:         ENDTRY
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------
352:     * FormatarGridCabecalho - Width / Header1.Caption / ReadOnly / Text1 de
353:     * TODAS as colunas de grd_4c_GrdCab.
354:     *
355:     * Metodo separado porque esse bloco precisa rodar DUAS vezes: na montagem
356:     * (ConfigurarGrids) e depois de CADA bind de RecordSource/ControlSource em
357:     * CarregarLista() - o VFP9 reseta Column.Width, Header1.Caption e
358:     * Column.ReadOnly para os defaults quando a fonte de dados da grade muda
359:     * (Problema 48 de FORMCOR_LICOES_APRENDIDAS.md; CLAUDE.md regra #43.1).
360:     * Por isso Width vem SEMPRE depois do ControlSource, nunca antes.
361:     *
362:     * Movable/Resizable: o dump declara .F. apenas nas colunas legado
363:     * Column1/Column2/Column4/Column5/Column6 - as legado Column3
364:     * (Conta Origem, posicao 4) e Column7 (Movimentacao, posicao 2) nao os
365:     * declaram e ficam no default .T. A assimetria eh do SCX legado, nao
366:     * descuido da migracao (AllowHeaderSizing = .F. no Grid ja bloqueia o
367:     * redimensionamento na pratica).
368:     *--------------------------------------------------------------------------
369:     PROTECTED PROCEDURE FormatarGridCabecalho()
370:         WITH THIS.grd_4c_GrdCab
371: 
372:             *-- Posicao 1 (legado Column1) - Emp
373:             WITH .Column1
374:                 .FontName  = "Tahoma"
375:                 .FontSize  = 8
376:                 .Movable   = .F.
377:                 .Resizable = .F.
378:                 .ReadOnly  = .T.
379:                 WITH .Header1
380:                     .Caption   = "Emp"
381:                     .FontName  = "Tahoma"
382:                     .FontSize  = 8
383:                     .Alignment = 2
384:                     .ForeColor = RGB(0, 0, 0)
385:                 ENDWITH
386:                 WITH .Text1
387:                     .FontSize    = 8
388:                     .BorderStyle = 0
389:                     .Margin      = 0
390:                     .ReadOnly    = .T.
391:                     .ForeColor   = RGB(0, 0, 0)
392:                     .BackColor   = RGB(255, 255, 255)
393:                 ENDWITH
394:                 .Width = 35
395:             ENDWITH
396: 
397:             *-- Posicao 2 (legado Column7) - Movimentacao
398:             WITH .Column2
399:                 .FontName = "Tahoma"
400:                 .FontSize = 8
401:                 .ReadOnly = .T.
402:                 WITH .Header1
403:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
404:                     .FontName  = "Tahoma"
405:                     .FontSize  = 8
406:                     .Alignment = 2
407:                     .ForeColor = RGB(0, 0, 0)
408:                 ENDWITH
409:                 WITH .Text1

*-- Linhas 562 a 605:
562:     * A posicao 1 tem Header1.Caption = "" no legado (coluna do numero do
563:     * item, csItens.CItens): vazio eh o valor do dump, nao caption esquecido.
564:     *--------------------------------------------------------------------------
565:     PROTECTED PROCEDURE FormatarGridItens()
566:         LOCAL loc_nCol
567:         LOCAL ARRAY loc_aLargura[7], loc_aCaption[7]
568: 
569:         loc_aLargura[1] = 36
570:         loc_aLargura[2] = 120
571:         loc_aLargura[3] = 403
572:         loc_aLargura[4] = 23
573:         loc_aLargura[5] = 130
574:         loc_aLargura[6] = 100
575:         loc_aLargura[7] = 130
576: 
577:         loc_aCaption[1] = ""
578:         loc_aCaption[2] = "Produto"
579:         loc_aCaption[3] = "Descri" + CHR(231) + CHR(227) + "o do Produto"
580:         loc_aCaption[4] = "M"
581:         loc_aCaption[5] = "Pr. Unit."
582:         loc_aCaption[6] = "Quantidade"
583:         loc_aCaption[7] = "Total"
584: 
585:         FOR loc_nCol = 1 TO 7
586:             *-- Columns(N) (PLURAL) eh a collection que aceita indice de
587:             *-- variavel; .Column(N) NAO existe em VFP9 (CLAUDE.md regra #43)
588:             WITH THIS.grd_4c_GrdIte.Columns(loc_nCol)
589:                 .FontName  = "Tahoma"
590:                 .FontSize  = 8
591:                 .Movable   = .F.
592:                 .Resizable = .F.
593:                 .ReadOnly  = .T.
594: 
595:                 WITH .Header1
596:                     .Caption   = loc_aCaption[loc_nCol]
597:                     .FontName  = "Tahoma"
598:                     .FontSize  = 8
599:                     .Alignment = 2
600:                     .ForeColor = RGB(0, 0, 0)
601:                 ENDWITH
602: 
603:                 WITH .Text1
604:                     .FontSize    = 8
605:                     .BorderStyle = 0

*-- Linhas 618 a 661:
618:     *--------------------------------------------------------------------------
619:     * CarregarLista - liga as duas grades aos cursores do form pai e posiciona
620:     * as duas no primeiro registro. Transcricao do bloco final do Init legado
621:     * (SigPrGst_form_codigo_fonte.txt, PROCEDURE Init):
622:     *
623:     *     Select CsCabec / Go Top
624:     *     Select CsItens / Set Key To CsCabec.EmpdopNums / Go Top
625:     *     Select CsCabec
626:     *     With ThisForm.GrdCab ... RecordSource + 7 ControlSource +
627:     *                             SetAll DynamicBackColor + Refresh
628:     *     With ThisForm.GrdIte ... RecordSource + 7 ControlSource + Refresh
629:     *
630:     * csCabec/csItens NAO sao abertos aqui: quem os popula eh o form que abre
631:     * esta tela (ver cabecalho do arquivo). O guard USED() existe porque
632:     * atribuir RecordSource/ControlSource a um alias inexistente derruba o
633:     * Init com "Alias ... is not found" e o form nunca abre (CLAUDE.md regra
634:     * #41) - eh o que aconteceria em ValidarUIFidelity/gb_4c_ModoTeste, que
635:     * instanciam o form sem form pai. Sem os cursores as grades ficam com as
636:     * colunas formatadas e RecordSource vazio, que eh o estado correto.
637:     *
638:     * PUBLIC (sem PROTECTED) de proposito: TesteAutomatico.prg chama
639:     * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS(...,5) devolve
640:     * .T. mesmo para metodo PROTECTED - o harness entraria no branch e a
641:     * chamada falharia em runtime (CLAUDE.md regra #3).
642:     *--------------------------------------------------------------------------
643:     FUNCTION CarregarLista()
644:         LOCAL loc_lSucesso, loc_oErro
645:         loc_lSucesso = .F.
646: 
647:         TRY
648:             IF USED("csCabec")
649:                 SELECT csCabec
650:                 GO TOP
651: 
652:                 THIS.grd_4c_GrdCab.RecordSourceType = 1
653:                 THIS.grd_4c_GrdCab.RecordSource      = "csCabec"
654: 
655:                 WITH THIS.grd_4c_GrdCab
656:                     .Column1.ControlSource = "csCabec.EmpDs"
657:                     .Column2.ControlSource = "csCabec.Dopes"
658:                     .Column3.ControlSource = "csCabec.GrupoOs"
659:                     .Column4.ControlSource = "csCabec.ContaOs"
660:                     .Column5.ControlSource = "csCabec.GrupoDs"
661:                     .Column6.ControlSource = "csCabec.ContaDs"

*-- Linhas 687 a 941:
687:         CATCH TO loc_oErro
688:             MsgErro(loc_oErro.Message + CHR(13) + ;
689:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
690:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarLista")
691:         ENDTRY
692: 
693:         RETURN loc_lSucesso
694:     ENDFUNC
695: 
696:     *--------------------------------------------------------------------------
697:     * CarregarItensPedido - liga grd_4c_GrdIte a csItens, escopa o cursor no
698:     * pedido corrente de csCabec e repinta a grade. Funil UNICO desse trabalho:
699:     * chamado pela carga inicial (CarregarLista) E pela troca de linha na grade
700:     * de cabecalho (GrdCabAfterRowColChange) - sem isso a grade de itens fica
701:     * visualmente parada ao trocar de pedido (CLAUDE.md regra #21a).
702:     *
703:     * SET KEY TO depende da ordem ativa em csItens, criada pelo form pai junto
704:     * com o cursor (o legado conta com ela: "Select CsItens / Set Key To
705:     * CsCabec.EmpdopNums"). O teste de ORDER() nao existe no legado - ele
706:     * evita que a tela morra quando o form eh instanciado sem form pai
707:     * (ValidarUIFidelity/gb_4c_ModoTeste), caso em que nao ha o que escopar.
708:     *
709:     * PUBLIC: chamado pelo handler ligado por BINDEVENT (CLAUDE.md regra #3).
710:     *--------------------------------------------------------------------------
711:     FUNCTION CarregarItensPedido()
712:         LOCAL loc_lSucesso, loc_oErro
713:         loc_lSucesso = .F.
714: 
715:         TRY
716:             IF USED("csItens")
717:                 THIS.grd_4c_GrdIte.RecordSourceType = 1
718:                 THIS.grd_4c_GrdIte.RecordSource      = "csItens"
719: 
720:                 WITH THIS.grd_4c_GrdIte
721:                     .Column1.ControlSource = "csItens.CItens"
722:                     .Column2.ControlSource = "csItens.CPros"
723:                     .Column3.ControlSource = "csItens.DPros"
724:                     .Column4.ControlSource = "csItens.Moedas"
725:                     .Column5.ControlSource = "csItens.Units"
726:                     .Column6.ControlSource = "csItens.Qtds"
727:                     .Column7.ControlSource = "csItens.Totas"
728:                 ENDWITH
729: 
730:                 *-- Reaplicar apos o bind (ver FormatarGridCabecalho)
731:                 THIS.FormatarGridItens()
732: 
733:                 SELECT csItens
734:                 IF USED("csCabec") AND !EMPTY(ORDER("csItens"))
735:                     SET KEY TO csCabec.EmpdopNums
736:                 ENDIF
737:                 GO TOP
738: 
739:                 *-- Devolve o alias corrente para a grade de cabecalho, como o
740:                 *-- legado faz ("Select CsCabec" antes de montar GrdCab)
741:                 IF USED("csCabec")
742:                     SELECT csCabec
743:                 ENDIF
744: 
745:                 THIS.grd_4c_GrdIte.Refresh()
746:             ENDIF
747: 
748:             loc_lSucesso = .T.
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarItensPedido")
753:         ENDTRY
754: 
755:         RETURN loc_lSucesso
756:     ENDFUNC
757: 
758:     *--------------------------------------------------------------------------
759:     * GrdCabAfterRowColChange - transcricao de SIGPRGST.GrdCab.AfterRowColChange
760:     * (dump legado): ao trocar de linha/coluna em grd_4c_GrdCab, re-escopa
761:     * csItens para o pedido agora corrente em csCabec e repinta grd_4c_GrdIte.
762:     *
763:     * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (CLAUDE.md
764:     * regra #3); declara par_nColIndex porque o grid invoca o evento sempre
765:     * com esse parametro (handler sem o parametro estoura "No PARAMETER
766:     * statement is found").
767:     *--------------------------------------------------------------------------
768:     PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
769:         *-- Trocou o pedido corrente: alinhar o BO com a nova linha ANTES de
770:         *-- re-escopar os itens (a chave que CarregarItensPedido usa no
771:         *-- SET KEY TO eh a desta linha)
772:         THIS.SincronizarPedidoCorrente()
773:         THIS.CarregarItensPedido()
774:     ENDPROC
775: 
776:     *--------------------------------------------------------------------------
777:     * SincronizarPedidoCorrente - leva a linha CORRENTE de csCabec para as
778:     * propriedades do BO (this_cEmps / this_cDopes / this_cEmpDopNums).
779:     *
780:     * POR QUE ISTO EH O "CAMPO" DESTA TELA: SIGPRGST nao tem nenhum controle
781:     * de entrada de dados - o dump legado (Secao 1) prova que os unicos
782:     * objetos do form sao duas grades, o container do cabecalho, um Shape
783:     * decorativo e os dois botoes; zero textbox/combobox/checkbox fora das
784:     * colunas das grades, e as colunas das DUAS grades sao ReadOnly = .T.
785:     * (Secao 2: GrdCab/GrdIte .ColumnN.Text1.ReadOnly = .T.). A unica "coisa
786:     * que o usuario informa" eh QUAL LINHA de csCabec esta selecionada, e eh
787:     * exatamente isso que o legado propaga quando escopa os itens:
788:     *
789:     *     Select CsItens
790:     *     Set Key To CsCabec.EmpdopNums
791:     *
792:     * Dai a chave do pedido corrente ser o dado de entrada deste form. O BO
793:     * declara as tres propriedades desde a Fase 1 e nada as alimentava; sem
794:     * este funil, ObterChavePrimaria() (usada pela auditoria de
795:     * BusinessBase) devolve a chave VAZIA e o registro de auditoria da
796:     * geracao sai sem identificar o pedido - falha silenciosa, sem erro na
797:     * tela. GerarPedido() le csCabec direto, como o legado, entao a geracao
798:     * em si nao depende disto - a auditoria sim.
799:     *
800:     * Chamado nos DOIS caminhos que mudam o pedido corrente: a carga inicial
801:     * (CarregarLista) e a troca de linha na grade (GrdCabAfterRowColChange) -
802:     * mesmo funil unico de CarregarItensPedido (CLAUDE.md regra #40: quem
803:     * muda estado repoe em CADA caminho, nunca so no primeiro).
804:     *
805:     * A chave NAO eh remontada aqui: le-se csCabec.EmpDopNums como gravado,
806:     * porque ela eh POSICIONAL (Emps char(3) + Dopes char(20) + Str(Numes,6)
807:     * = char(29)) e reconstruir com as partes ja aparadas devolve chave curta
808:     * que nunca casa no SET KEY (CLAUDE.md regra #42).
809:     *
810:     * PUBLIC: chamado por GrdCabAfterRowColChange, que roda por BINDEVENT
811:     * (CLAUDE.md regra #3).
812:     *--------------------------------------------------------------------------
813:     PROCEDURE SincronizarPedidoCorrente()
814:         LOCAL loc_lSucesso, loc_oErro
815:         loc_lSucesso = .F.
816: 
817:         TRY
818:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
819:                 IF USED("csCabec") AND !EOF("csCabec") AND !BOF("csCabec")
820:                     THIS.this_oBusinessObject.this_cEmps       = PADR(TratarNulo(csCabec.Emps, ""), 3)
821:                     THIS.this_oBusinessObject.this_cDopes      = PADR(TratarNulo(csCabec.Dopes, ""), 20)
822:                     THIS.this_oBusinessObject.this_cEmpDopNums = TratarNulo(csCabec.EmpDopNums, "")
823:                 ELSE
824:                     *-- Sem linha corrente nao ha pedido: limpar, para nao
825:                     *-- deixar a chave do pedido ANTERIOR grudada no BO
826:                     THIS.this_oBusinessObject.this_cEmps       = SPACE(3)
827:                     THIS.this_oBusinessObject.this_cDopes      = SPACE(20)
828:                     THIS.this_oBusinessObject.this_cEmpDopNums = ""
829:                 ENDIF
830: 
831:                 loc_lSucesso = .T.
832:             ENDIF
833:         CATCH TO loc_oErro
834:             MsgErro(loc_oErro.Message + CHR(13) + ;
835:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
836:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.SincronizarPedidoCorrente")
837:         ENDTRY
838: 
839:         RETURN loc_lSucesso
840:     ENDPROC
841: 
842:     *--------------------------------------------------------------------------
843:     * ValidarPedidoSelecionado - guard do pedido corrente, transcrito do
844:     * TOPO de SIGPRGST.CmdGrava.Click (dump legado):
845:     *
846:     *     Select csCabec
847:     *     If Eof([csCabec])
848:     *         =MessageBox([Selecione Um Pedido a Ser Gerado Na Grade e Tente
849:     *                      Novamente], 16, [Atencao!!!])
850:     *         Return .f.
851:     *     EndIf
852:     *
853:     * Devolve .T. quando ha pedido corrente e a geracao pode prosseguir; .F.
854:     * depois de ja ter avisado o usuario. Quem chama eh o Click de
855:     * cmd_4c_CmdGrava (fase de eventos), ANTES de
856:     * this_oBusinessObject.GerarPedido().
857:     *
858:     * O texto da mensagem eh o do legado, palavra por palavra. Vai em
859:     * MsgAviso (dialogo amarelo) e nao em MsgErro: eh validacao de UI
860:     * ("Selecione um registro"), nao excecao tecnica - o legado usa icone 16
861:     * (critico), desvio consciente e documentado para seguir o padrao de
862:     * mensagens do sistema novo.
863:     *
864:     * NAO bloqueia pedido JA gerado, de proposito: o legado deixa passar
865:     * (GerarPedido devolve sucesso sem fazer nada quando csCabec.Gerado esta
866:     * preenchido) justamente para que o "If llRet And Not Empty(csCabec.
867:     * Gerado)" seguinte reabra a movimentacao existente para conferencia.
868:     * Barrar aqui tiraria do usuario esse caminho de consulta.
869:     *
870:     * PUBLIC: o harness de teste chama os validadores do form de fora da
871:     * classe, e PEMSTATUS(...,5) devolve .T. mesmo para metodo PROTECTED
872:     * (CLAUDE.md regra #3).
873:     *--------------------------------------------------------------------------
874:     PROCEDURE ValidarPedidoSelecionado()
875:         LOCAL loc_lValido, loc_oErro
876:         loc_lValido = .F.
877: 
878:         TRY
879:             IF !USED("csCabec")
880:                 *-- Nao existe no legado: la o cursor eh garantido pelo form
881:                 *-- pai. Aqui evita "Alias is not found" derrubar o Click
882:                 *-- quando a tela eh instanciada sem pai (modo teste).
883:                 MsgAviso("Nenhum pedido carregado para gera" + CHR(231) + CHR(227) + "o.", ;
884:                     "Aten" + CHR(231) + CHR(227) + "o")
885:             ELSE
886:                 SELECT csCabec
887: 
888:                 IF EOF("csCabec")
889:                     MsgAviso("Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente", ;
890:                         "Aten" + CHR(231) + CHR(227) + "o")
891:                 ELSE
892:                     *-- Pedido corrente valido: alinhar o BO com a linha antes
893:                     *-- de entregar o fluxo para GerarPedido()
894:                     THIS.SincronizarPedidoCorrente()
895:                     loc_lValido = .T.
896:                 ENDIF
897:             ENDIF
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message + CHR(13) + ;
900:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
901:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.ValidarPedidoSelecionado")
902:         ENDTRY
903: 
904:         RETURN loc_lValido
905:     ENDPROC
906: 
907:     *--------------------------------------------------------------------------
908:     * ValidarSaidaSemConfirmar - guard da saida, transcrito de
909:     * SIGPRGST.CmdCancela.Click (dump legado):
910:     *
911:     *     Select Emps, Dopes, Numes From csCabec Where Empty(Gerado) ;
912:     *       Into Cursor LocalGerado
913:     *     lnFal = Reccount([LocalGerado])
914:     *     If (lnFal > 0)
915:     *         If MessageBox([Existem ] + Alltrim(Str(lnFal,10)) +
916:     *                       [ Operacoes Nao Confirmadas!] + Chr(13) +
917:     *                       [Tem Certeza Que Nao Deseja Gerar Esses Pedidos?],
918:     *                       4+32+256, [Atencao!!!]) <> 6
919:     *             Return .f.
920:     *         Else
921:     *             fGravarLog([T], CrSigCdNec.Dopps, [AUTOMATICO],
922:     *                        [A Geracao de ] + Alltrim(Str(lnFal,10)) +
923:     *                        [ Operacao Foi Cancelada Sem Confirmacao])
924:     *         EndIf
925:     *     EndIf
926:     *     ThisForm.Release
927:     *
928:     * Devolve .T. quando a tela pode fechar (nada a confirmar, ou o usuario
929:     * confirmou abandonar) e .F. quando o usuario desistiu de sair. Quem
930:     * chama eh o Click de cmd_4c_CmdCancela (fase de eventos), que so chama
931:     * THIS.Release() com .T.
932:     *
933:     * Tres pontos transcritos que o migrador costuma perder (CLAUDE.md
934:     * regra #21b - a condicao que CERCA a validacao faz parte dela):
935:     *   1. o filtro eh Empty(Gerado) - conta os NAO confirmados, nao o total;
936:     *   2. a contagem entra no TEXTO da pergunta;
937:     *   3. confirmando a saida, o legado REGISTRA o abandono em log antes de
938:     *      liberar - nao eh "nao faz nada".
939:     *
940:     * Cursor de trabalho renomeado de LocalGerado para cursor_4c_NaoGerados
941:     * (PILAR 3) - nenhum outro metodo do legado o le. O legado o deixa aberto

*-- Linhas 947 a 990:
947:     *
948:     * PUBLIC: mesma razao de ValidarPedidoSelecionado.
949:     *--------------------------------------------------------------------------
950:     PROCEDURE ValidarSaidaSemConfirmar()
951:         LOCAL loc_lPodeSair, loc_nFal, loc_cQtd, loc_cDopps, loc_oErro
952:         loc_lPodeSair = .T.
953: 
954:         TRY
955:             IF USED("csCabec")
956:                 IF USED("cursor_4c_NaoGerados")
957:                     USE IN cursor_4c_NaoGerados
958:                 ENDIF
959: 
960:                 SELECT Emps, Dopes, Numes ;
961:                     FROM csCabec ;
962:                     WHERE EMPTY(Gerado) ;
963:                     INTO CURSOR cursor_4c_NaoGerados
964: 
965:                 loc_nFal = IIF(USED("cursor_4c_NaoGerados"), RECCOUNT("cursor_4c_NaoGerados"), 0)
966: 
967:                 IF USED("cursor_4c_NaoGerados")
968:                     USE IN cursor_4c_NaoGerados
969:                 ENDIF
970: 
971:                 SELECT csCabec
972: 
973:                 IF loc_nFal > 0
974:                     loc_cQtd = ALLTRIM(STR(loc_nFal, 10))
975: 
976:                     IF MsgConfirma("Existem " + loc_cQtd + " Opera" + CHR(231) + CHR(245) + "es N" + ;
977:                             CHR(227) + "o Confirmadas!" + CHR(13) + ;
978:                             "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
979:                             "Aten" + CHR(231) + CHR(227) + "o")
980: 
981:                         *-- Usuario confirmou abandonar: registrar o abandono,
982:                         *-- como o legado faz antes do Release
983:                         loc_cDopps = ""
984:                         IF USED("CrSigCdNec")
985:                             loc_cDopps = TratarNulo(CrSigCdNec.Dopps, "")
986:                         ENDIF
987: 
988:                         fGravarLog("T", loc_cDopps, "AUTOMATICO", ;
989:                             "A Gera" + CHR(231) + CHR(227) + "o de " + loc_cQtd + " Opera" + ;
990:                             CHR(231) + CHR(227) + "o Foi Cancelada Sem Confirma" + CHR(231) + CHR(227) + "o")

*-- Linhas 997 a 1092:
997:         CATCH TO loc_oErro
998:             MsgErro(loc_oErro.Message + CHR(13) + ;
999:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1000:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.ValidarSaidaSemConfirmar")
1001:         ENDTRY
1002: 
1003:         RETURN loc_lPodeSair
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * ProcessaPeriodo - transcricao LITERAL de SIGPRGST.processaperiodo (dump
1008:     * legado, Secao 3), cujo corpo inteiro no SCX sao duas linhas:
1009:     *
1010:     *     Lparameters P1, P2, P3  && Rotina Criada Apenas Para Nao Gerar Erro
1011:     *                             && Nas Chamadas do SigMvCab.
1012:     *     Return .t.
1013:     *
1014:     * Nao eh codigo em aberto: o proprio comentario do legado diz que o
1015:     * metodo existe para SATISFAZER UM CONTRATO. O CmdGrava.Click abre a tela
1016:     * de movimentacao passando este form como pai ("Do Form SigMvCab With
1017:     * ..., ThisForm, .f., .t."), e SigMvCab chama ProcessaPeriodo no pai
1018:     * durante o seu proprio fluxo; o pai de verdade (a tela de pedidos) tem
1019:     * uma rotina de periodo, este despachante nao - e devolver .t. eh a
1020:     * resposta correta, porque nao ha periodo a reprocessar depois de gerar o
1021:     * movimento. Copiar o `Return .t.` eh reproduzir a regra, nao adiar
1022:     * trabalho; qualquer calculo inventado aqui seria pior (CLAUDE.md regra
1023:     * #17 - calculo adivinhado grava numero errado em silencio).
1024:     *
1025:     * Omitir o metodo tem efeito concreto: a chamada vinda do form filho
1026:     * estoura "Property PROCESSAPERIODO is not found" em RUNTIME, e nao em
1027:     * compilacao (CLAUDE.md regra #32), bem no meio da gravacao.
1028:     *
1029:     * PUBLIC e com o NOME DO LEGADO (sem prefixo this_/par_ nos parametros
1030:     * sendo a assinatura externa): quem chama eh outro form, por
1031:     * ThisForm.ParentForm.ProcessaPeriodo(...) - renomear quebra a chamada.
1032:     *--------------------------------------------------------------------------
1033:     PROCEDURE ProcessaPeriodo(P1, P2, P3)
1034:         RETURN .T.
1035:     ENDPROC
1036: 
1037:     *--------------------------------------------------------------------------
1038:     * ConfigurarBotoesAcao - shp_4c_ShpP2 (separador decorativo) + os DOIS
1039:     * botoes reais do legado: cmd_4c_CmdGrava ("Confirmar") e
1040:     * cmd_4c_CmdCancela ("Sair"). Posicoes/icones/caption transcritos do
1041:     * dump (Secao 2: ShpP2/CmdCancela/CmdGrava). Os dois ficam na faixa do
1042:     * cabecalho (Top=3, dentro da Height=80 de cnt_4c_Sombra), como filhos
1043:     * diretos do form - standalone, fora de CommandGroup.
1044:     *
1045:     * Themes = .T. + DisabledPicture obrigatorios em standalone CommandButton
1046:     * com .Picture definido (CorretorAutomatico Pattern #99) - sem isso o
1047:     * icone some quando o botao for desabilitado.
1048:     *
1049:     * Click vinculado por BINDEVENT (CLAUDE.md regra #3 - exige metodo
1050:     * PUBLIC) para BtnConfirmarClick()/BtnCancelarClick(), implementados na Fase 7.
1051:     *--------------------------------------------------------------------------
1052:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1053:         LOCAL loc_oErro
1054: 
1055:         TRY
1056:             THIS.AddObject("shp_4c_ShpP2", "Shape")
1057:             WITH THIS.shp_4c_ShpP2
1058:                 .Top           = 11
1059:                 .Left          = 819
1060:                 .Width         = 21
1061:                 .Height        = 37
1062:                 .BackStyle     = 0
1063:                 .BorderStyle   = 0
1064:                 .SpecialEffect = 1
1065:                 .BorderColor   = RGB(136, 189, 188)
1066:                 .Visible       = .T.
1067:             ENDWITH
1068: 
1069:             THIS.AddObject("cmd_4c_CmdGrava", "CommandButton")
1070:             WITH THIS.cmd_4c_CmdGrava
1071:                 .Top             = 3
1072:                 .Left            = 850
1073:                 .Width           = 75
1074:                 .Height          = 75
1075:                 .Caption         = "Confirmar"
1076:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
1077:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
1078:                 .FontName        = "Comic Sans MS"
1079:                 .FontBold        = .T.
1080:                 .FontItalic      = .T.
1081:                 .FontSize        = 8
1082:                 .ForeColor       = RGB(90, 90, 90)
1083:                 .BackColor       = RGB(255, 255, 255)
1084:                 .Themes          = .T.
1085:                 .SpecialEffect   = 0
1086:                 .PicturePosition = 13
1087:                 .MousePointer    = 15
1088:                 .WordWrap        = .T.
1089:                 .AutoSize        = .F.
1090:                 .Visible         = .T.
1091:             ENDWITH
1092: 

*-- Linhas 1115 a 1272:
1115:                 .Visible         = .T.
1116:             ENDWITH
1117: 
1118:             BINDEVENT(THIS.cmd_4c_CmdGrava, "Click", THIS, "BtnConfirmarClick")
1119:             BINDEVENT(THIS.cmd_4c_CmdCancela, "Click", THIS, "BtnCancelarClick")
1120:         CATCH TO loc_oErro
1121:             MsgErro(loc_oErro.Message + CHR(13) + ;
1122:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1123:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
1124:         ENDTRY
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     * BtnConfirmarClick - transcricao de SIGPRGST.CmdGrava.Click (dump legado):
1129:     *
1130:     *     Select csCabec
1131:     *     If Eof([csCabec])
1132:     *         =MessageBox([Selecione Um Pedido...], 16, [Atencao!!!])
1133:     *         Return .f.
1134:     *     EndIf
1135:     *     llRet = ThisForm.GerarPedido()
1136:     *     If llRet And Not Empty(csCabec.Gerado)
1137:     *         Do Form SigMvCab With csCabec.GerDopes, csCabec.GerNumes,
1138:     *                               csCabec.GerEmps, .t., 3, ThisForm, .f., .t.
1139:     *     EndIf
1140:     *
1141:     * O guard (Eof) ja esta em ValidarPedidoSelecionado() (Fase 6), que
1142:     * tambem alinha o BO com a linha corrente (SincronizarPedidoCorrente)
1143:     * antes de GerarPedido() ler csCabec. A decisao de abrir a tela de
1144:     * movimentacao usa o MESMO teste do legado - csCabec.Gerado preenchido
1145:     * DEPOIS da chamada, nao this_lGerado do BO - porque csCabec.Gerado fica
1146:     * preenchido tanto quando GerarPedido() acabou de gravar quanto quando o
1147:     * pedido JA estava gerado (GerarPedido() devolve .T. sem fazer nada
1148:     * nesse caso, igual ao "If Empty(csCabec.Gerado) ... EndIf / Return
1149:     * llOks" do legado) - nos dois casos o legado abre SigMvCab para
1150:     * conferencia.
1151:     *
1152:     * Do Form SigMvCab With <8 parametros posicionais> (Dopes/Numes/Emps do
1153:     * movimento gerado, modo Visualizar, ThisForm pai) NAO tem equivalente
1154:     * direto: Formsigmvcab.prg (migracao de SigMvCab) foi migrado como
1155:     * cadastro CRUD autonomo, com Init() sem parametros (lista propria,
1156:     * sem abertura filtrada por chave) - mudar essa assinatura eh trabalho
1157:     * da migracao de SigMvCab, fora do escopo desta fase. Abrir pelo padrao
1158:     * canonico do projeto (CREATEOBJECT + VARTYPE + Show(), sem Release() -
1159:     * FormBase cuida disso) entrega a mesma intencao do legado (deixar o
1160:     * usuario revisar a movimentacao) sem inventar parametros que o form
1161:     * migrado nao suporta.
1162:     *
1163:     * A grade de cabecalho eh repintada apos GerarPedido() para refletir a
1164:     * coluna Confirmacao/realce amarelo (DynamicBackColor, CarregarLista) -
1165:     * REPLACE em csCabec.Gerado acontece no mesmo cursor ja ligado ao grid,
1166:     * entao Refresh() basta, sem precisar reabrir o RecordSource.
1167:     *
1168:     * PUBLIC - BINDEVENT exige metodo publico (CLAUDE.md regra #3).
1169:     *--------------------------------------------------------------------------
1170:     PROCEDURE BtnConfirmarClick()
1171:         LOCAL loc_lGerou, loc_oFormMv, loc_oErro
1172: 
1173:         TRY
1174:             IF THIS.ValidarPedidoSelecionado()
1175:                 loc_lGerou = THIS.this_oBusinessObject.GerarPedido()
1176: 
1177:                 IF !loc_lGerou
1178:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1179:                         "Erro ao Gerar Pedido")
1180:                 ELSE
1181:                     IF USED("csCabec")
1182:                         THIS.grd_4c_GrdCab.Refresh()
1183:                     ENDIF
1184: 
1185:                     *-- "If llRet And Not Empty(csCabec.Gerado) / Do Form SigMvCab..."
1186:                     IF USED("csCabec") AND !EMPTY(TratarNulo(csCabec.Gerado, ""))
1187:                         loc_oFormMv = CREATEOBJECT("Formsigmvcab")
1188: 
1189:                         IF VARTYPE(loc_oFormMv) = "O"
1190:                             loc_oFormMv.Show()
1191:                         ENDIF
1192:                     ENDIF
1193:                 ENDIF
1194:             ENDIF
1195:         CATCH TO loc_oErro
1196:             MsgErro(loc_oErro.Message + CHR(13) + ;
1197:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1198:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.BtnConfirmarClick")
1199:         ENDTRY
1200:     ENDPROC
1201: 
1202:     *--------------------------------------------------------------------------
1203:     * BtnCancelarClick - transcricao de SIGPRGST.CmdCancela.Click (dump
1204:     * legado): o guard (contagem de pedidos nao confirmados + confirmacao +
1205:     * log) ja esta inteiro em ValidarSaidaSemConfirmar() (Fase 6) - aqui so
1206:     * resta chamar o guard e, se ele devolver .T., fechar a tela
1207:     * ("ThisForm.Release").
1208:     *
1209:     * PUBLIC - BINDEVENT exige metodo publico (CLAUDE.md regra #3).
1210:     *--------------------------------------------------------------------------
1211:     PROCEDURE BtnCancelarClick()
1212:         LOCAL loc_oErro
1213: 
1214:         TRY
1215:             IF THIS.ValidarSaidaSemConfirmar()
1216:                 THIS.Release()
1217:             ENDIF
1218:         CATCH TO loc_oErro
1219:             MsgErro(loc_oErro.Message + CHR(13) + ;
1220:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1221:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.BtnCancelarClick")
1222:         ENDTRY
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------
1226:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
1227:     * Original (layout.json): cntSombra Top=0, Left=0, Width=1100, Height=80,
1228:     * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
1229:     * projeto) em vez do literal 1100 do dump (que extrapola o Width=1000
1230:     * do proprio form).
1231:     *--------------------------------------------------------------------------
1232:     PROTECTED PROCEDURE ConfigurarCabecalho()
1233:         LOCAL loc_oCnt, loc_oErro
1234: 
1235:         TRY
1236:             THIS.AddObject("cnt_4c_Sombra", "Container")
1237:             loc_oCnt = THIS.cnt_4c_Sombra
1238:             WITH loc_oCnt
1239:                 .Top         = 0
1240:                 .Left        = 0
1241:                 .Width       = THIS.Width
1242:                 .Height      = 80
1243:                 .BorderWidth = 0
1244:                 .BackColor   = RGB(100, 100, 100)
1245:                 .Visible     = .T.
1246:             ENDWITH
1247: 
1248:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
1249:             WITH loc_oCnt.lbl_4c_LblSombra
1250:                 .FontBold  = .T.
1251:                 .FontName  = "Tahoma"
1252:                 .FontSize  = 18
1253:                 .WordWrap  = .T.
1254:                 .Alignment = 0
1255:                 .BackStyle = 0
1256:                 .AutoSize  = .F.
1257:                 .Caption   = THIS.Caption
1258:                 .Height    = 40
1259:                 .Left      = 10
1260:                 .Top       = 18
1261:                 .Width     = 769
1262:                 .ForeColor = RGB(0, 0, 0)
1263:                 .Visible   = .T.
1264:             ENDWITH
1265: 
1266:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
1267:             WITH loc_oCnt.lbl_4c_LblTitulo
1268:                 .FontBold  = .T.
1269:                 .FontName  = "Tahoma"
1270:                 .FontSize  = 18
1271:                 .WordWrap  = .T.
1272:                 .Alignment = 0

*-- Linhas 1283 a 1313:
1283:         CATCH TO loc_oErro
1284:             MsgErro(loc_oErro.Message + CHR(13) + ;
1285:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1286:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
1287:         ENDTRY
1288:     ENDPROC
1289: 
1290:     *--------------------------------------------------------------------------
1291:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1292:     * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
1293:     * eventuais PageFrames filhos) tornando tudo visivel.
1294:     *--------------------------------------------------------------------------
1295:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1296:         LOCAL loc_nI, loc_oObjeto
1297: 
1298:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1299:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1300: 
1301:             IF VARTYPE(loc_oObjeto) = "O"
1302:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1303:                     loc_oObjeto.Visible = .T.
1304:                 ENDIF
1305: 
1306:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1307:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1308:                 ENDIF
1309:             ENDIF
1310:         ENDFOR
1311:     ENDPROC
1312: 
1313: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):
*============================================================================
* SigPrGstBO.prg - Business Object para Geracao de Movimentacoes de Estoque
* (SIGPRGST)
*
* Form OPERACIONAL (SIGPRGST / FormSigPrGst): tela auxiliar aberta por um
* form pai que ja populou os cursores csCabec/csItens/csEstPe (pedidos de
* movimentacao ainda nao gerados) e CrSigCdNec/CrSigCdEmb (parametros de
* embalagem). O usuario confirma, na grade de csCabec, qual pedido deseja
* gerar; o botao Confirmar chama GerarPedido(), que grava os movimentos
* (SigMvCab/SigMvItn/SigMvIts/SigMvPec/SigInBep) e, com sucesso, abre o
* form SigMvCab (Do Form SigMvCab With csCabec.GerDopes, ...) para o
* usuario revisar a movimentacao recem-gerada.
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - os cursores csCabec/csItens/csEstPe/CrSigCdNec/
* CrSigCdEmb sao preparados por quem abre esta tela (conforme
* tasks/task620/SigPrGst_form_codigo_fonte.txt, Procedure gerarpedido) e o
* BO so os le/atualiza pelo nome, igual ao legado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - GerarPedido() (gravacao real) + ObterChavePrimaria/
*                MontarChaveEmpDopNums + helpers de persistencia SQL Server
*============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *==========================================================================
    * Estado herdado do form pai (equivalente a ThisForm.PcEscolha e
    * ThisForm.GrupoOper do Init legado - GrupoOper e declarado no SCX mas
    * nao e lido em nenhum metodo com codigo; mantido por paridade)
    *==========================================================================
    this_cPcEscolha      = SPACE(10)  && ThisForm.ParentForm.pcEscolha
    this_cGrupoOper      = SPACE(10)  && ThisForm.GrupoOper (Space(10) no Init legado)

    *==========================================================================
    * Pedido corrente selecionado na grade csCabec (chave usada por
    * GerarPedido/AfterRowColChange para resolver csItens/csEstPe via
    * Set Key To csCabec.EmpdopNums)
    *==========================================================================
    this_cEmps           = SPACE(3)   && csCabec.Emps do registro corrente
    this_cDopes          = SPACE(20)  && csCabec.Dopes do registro corrente
    this_cEmpDopNums     = ""         && csCabec.EmpDopNums do registro corrente

    *==========================================================================
    * Resultado de GerarPedido() - espelha os campos que o legado grava de
    * volta em csCabec apos a geracao (Replace Gerado/GerEmps/GerDopes/
    * GerNumes In csCabec)
    *==========================================================================
    this_lGerado         = .F.        && .T. quando GerarPedido() concluiu com sucesso
    this_cGerEmps        = SPACE(3)   && crSigMvCab.Emps gravado
    this_cGerDopes       = SPACE(20)  && crSigMvCab.Dopes gravado
    this_nGerNumes       = 0          && crSigMvCab.Numes gravado

    *==========================================================================
    * Numeracao/mascara do movimento gerado (lnNum/lcMsk do Gerarpedido
    * legado - fGerUniqueKey/fGerMascara)
    *==========================================================================
    this_nNumeroGerado   = 0          && lnNum
    this_cMascaraNumero  = ""         && lcMsk

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (BO opera sobre os cursores csCabec/csItens/
    * csEstPe/CrSigCdNec/CrSigCdEmb preparados pelo form pai antes de abrir
    * esta tela) - mesmo padrao adotado em SigPrGlxBO.Init.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cPcEscolha  = SPACE(10)
            THIS.this_cGrupoOper  = SPACE(10)

            THIS.this_cEmps       = SPACE(3)
            THIS.this_cDopes      = SPACE(20)
            THIS.this_cEmpDopNums = ""

            THIS.this_lGerado     = .F.
            THIS.this_cGerEmps    = SPACE(3)
            THIS.this_cGerDopes   = SPACE(20)
            THIS.this_nGerNumes   = 0

            THIS.this_nNumeroGerado  = 0
            THIS.this_cMascaraNumero = ""

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() / CarregarDoCursor(): este
    * BO deliberadamente NAO sobrescreve esses metodos do BusinessBase.
    *
    * SIGPRGST nao eh um cadastro: nao existe uma unica tabela/registro que o
    * form carregue, edite e grave via Salvar()/Excluir(). O usuario escolhe,
    * na grade csCabec (preparada por quem abre esta tela - ver cabecalho do
    * arquivo), qual pedido confirmar; a gravacao real ocorre em
    * THIS.GerarPedido() - transcricao de SIGPRGST.gerarpedido (dump do SCX
    * legado, linhas 812-941) - que grava em CINCO tabelas (SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep) dentro de uma unica transacao e
    * chama THIS.RegistrarAuditoria() por conta propria ao concluir com
    * sucesso. Os stubs herdados de BusinessBase (que devolvem .F. com
    * mensagem de erro) permanecem corretos, pois Salvar()/Excluir() nunca
    * sao acionados por este form.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do movimento efetivado por GerarPedido(),
    * usada por RegistrarAuditoria(). EmpDopNums (Emps+Dopes+Str(Numes,6)) eh
    * a mesma chave composta de SigMvCab.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDopNums(THIS.this_cGerEmps, THIS.this_cGerDopes, THIS.this_nGerNumes)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6) usada por SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep.
    *
    * A chave eh POSICIONAL: o padding faz parte dela. As partes vao com
    * PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - com
    * ALLTRIM nas partes a chave encurta e o SELECT que a compara devolve
    * ZERO linhas em silencio (CLAUDE.md regra #42 / Erro177).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente (o
    * legado chama SqlExecute sem reselecionar depois - SQLEXEC() troca a
    * area selecionada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - SELECT * FROM tabela WHERE campo = valor (equivalente
    * a ThisForm.poDataMgr.Cursorquery do legado). Cursor fica ABERTO; com
    * zero linhas, leitura de campo devolve branco (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, par_uValorChave)
        LOCAL loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao consultar " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (vazio) um cursor READWRITE com a estrutura
    * COMPLETA da tabela informada - garante que PersistirCursor() cubra
    * TODA coluna NOT NULL da tabela destino (CLAUDE.md regra #22), mesmo
    * quando o cursor de origem (csCabec/csItens/csEstPe) nao tem todos os
    * campos da tabela de destino.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_GstEstrut")
            USE IN cursor_4c_GstEstrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_GstEstrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_GstEstrut")
            SELECT * FROM cursor_4c_GstEstrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_GstEstrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao preparar a estrutura de " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor local (que AbrirCursorTabela criou com a estrutura completa
    * da tabela). Cursor vazio/inexistente = sucesso sem efeito (nada a
    * gravar) - equivalente a ThisForm.poDataMgr.UpDate('<cursor>').
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Falha ao gravar em " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarPedido - transcricao de SIGPRGST.gerarpedido (dump do SCX legado,
    * linhas 812-941): efetiva, em SigMvCab/SigMvItn/SigMvIts/SigMvPec/
    * SigInBep, o movimento do pedido CORRENTE de csCabec (linha selecionada
    * na grade do form).
    *
    * csCabec/csItens/csEstPe/CrSigCdNec sao preparados por quem abre esta
    * tela (ver cabecalho do arquivo) - este metodo so os LE pelo nome, como
    * o legado. crSigCdEmb/crSigMvCab/crSigMvItn/crSigMvIts/CrSigMvPec/
    * CrSigInBep/crTmpPro/crTmpGru sao cursores de trabalho LOCAIS, criados
    * e fechados aqui.
    *
    * Se csCabec.Gerado JA estiver preenchido, o legado nao faz nada e
    * devolve sucesso ("If Empty(csCabec.Gerado) ... EndIf / Return llOks") -
    * reproduzido abaixo.
    *--------------------------------------------------------------------------
    FUNCTION GerarPedido()
        LOCAL loc_lOks, loc_oErro, loc_nNum, loc_cMsk, loc_cEmpr, loc_cGerEmps, loc_cGerDopes
        LOCAL loc_cCgrus, loc_cCunis, loc_nTipoEstos, loc_nEmbs, loc_lSub
        LOCAL loc_nMultis, loc_cCodEmbs, loc_cDopps

        loc_lOks = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lGerado       = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            RETURN .F.
        ENDIF

        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente"
            RETURN .F.
        ENDIF

        *-- "If Empty(csCabec.Gerado) ... EndIf / Return llOks" - ja gerado:
        *-- nada a fazer, sucesso (o legado nunca entra no bloco de geracao)
        IF !EMPTY(TratarNulo(csCabec.Gerado, ""))
            RETURN .T.
        ENDIF

        loc_cEmpr = PADR(go_4c_Sistema.cCodEmpresa, 3)

        TRY
            *-- 1. Carrega SigCdEmb (Cods, Multis) - "Select Cods, Multis From SigCdEmb"
            loc_lOks = THIS.ExecutarSQL("SELECT Cods, Multis FROM SigCdEmb", "crSigCdEmb", "crSigCdEmb")

            IF loc_lOks AND USED("crSigCdEmb")
                SELECT crSigCdEmb
                INDEX ON Cods TAG Cods
                GO TOP
            ENDIF

            *-- 2. Cursores de gravacao, vazios, com a estrutura COMPLETA da
            *-- tabela destino (equivalente ao "Zap In crSigMvCab/..." do
            *-- legado - aqui nascem vazios em vez de serem zerados)
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigInBep", "SigInBep")
            ENDIF

            *-- 3. Numeracao do movimento - "lnNum = fGerUniqueKey(...) / lcMsk = fGerMascara(lnNum)"
            IF loc_lOks
                loc_nNum = fGerUniqueKey(ALLTRIM(csCabec.Dopes) + loc_cEmpr)
                loc_cMsk = ALLTRIM(fGerMascara(loc_nNum))

                IF loc_nNum = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a numera" + ;
                        CHR(231) + CHR(227) + "o do movimento."
                    loc_lOks = .F.
                ENDIF
            ENDIF

            *-- 4. Cabecalho - "Select csCabec / Scatter Memvar / ... / Insert Into crSigMvCab From Memvar"
            IF loc_lOks
                SELECT csCabec
                SCATTER MEMVAR MEMO
                m.Numes      = loc_nNum
                m.MascNum    = loc_cMsk
                m.Datars     = DATE()
                m.cIdChaves  = fUniqueIds()
                m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                IF USED("CrSigCdNec")
                    m.EmpDnPs = TratarNulo(CrSigCdNec.EmpDnPs, "")
                ENDIF

                loc_cGerEmps  = PADR(m.Emps, 3)
                loc_cGerDopes = PADR(m.Dopes, 20)

                INSERT INTO crSigMvCab FROM MEMVAR
                INSERT INTO CrSigInBep FROM MEMVAR

                *-- 5. Itens - "Select csItens / Set Key To csCabec.EmpDopNums / Go Top / Scan ... EndScan"
                IF USED("csItens")
                    SELECT csItens
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SELECT csItens
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)

                        INSERT INTO crSigMvItn FROM MEMVAR

                        loc_cCgrus = ""
                        loc_cCunis = ""
                        IF THIS.ConsultarTabela("SigCdPro", "crTmpPro", "Cpros", ALLTRIM(m.Cpros))
                            IF USED("crTmpPro") AND !EOF("crTmpPro")
                                loc_cCgrus = TratarNulo(crTmpPro.Cgrus, "")
                                loc_cCunis = TratarNulo(crTmpPro.cUnis, "")
                            ENDIF
                        ENDIF

                        loc_nTipoEstos = 0
                        loc_nEmbs      = 0
                        IF !EMPTY(loc_cCgrus) AND ;
                                THIS.ConsultarTabela("SigCdGrp", "crTmpGru", "Cgrus", ALLTRIM(loc_cCgrus))
                            IF USED("crTmpGru") AND !EOF("crTmpGru")
                                loc_nTipoEstos = TratarNulo(crTmpGru.TipoEstos, 0)
                                loc_nEmbs      = TratarNulo(crTmpGru.Embs, 0)
                            ENDIF
                        ENDIF

                        loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)

                        IF loc_lSub AND !EMPTY(loc_cCunis)
                            loc_nMultis  = 0
                            loc_cCodEmbs = ""
                            IF USED("crSigCdEmb") AND SEEK(loc_cCunis, "crSigCdEmb", "Cods")
                                loc_nMultis  = TratarNulo(crSigCdEmb.Multis, 0)
                                loc_cCodEmbs = TratarNulo(crSigCdEmb.Cods, "")
                            ENDIF

                            SELECT csItens
                            m.Qtds    = m.Qtds / IIF(loc_nMultis = 0, 1, loc_nMultis)
                            m.CodEmbs = loc_cCodEmbs
                            m.QtdEmbs = loc_nMultis

                            INSERT INTO crSigMvIts FROM MEMVAR
                        ENDIF

                        SELECT csItens
                    ENDSCAN
                    SELECT csItens
                    SET KEY TO
                ENDIF

                *-- 6. Pecas/estoque reservado (CsEstPe) - mesmo padrao do item anterior
                IF USED("csEstPe")
                    SELECT csEstPe
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                        m.EmpSubNs   = loc_cEmpr

                        INSERT INTO CrSigMvPec FROM MEMVAR

                        SELECT csEstPe
                    ENDSCAN
                    SELECT csEstPe
                    SET KEY TO
                ENDIF

                SELECT csCabec

                *-- "fGravarLog('T', CrSigCdNec.Dopps, 'AUTOMATICO', Emps-Dopes-Numes)" -
                *-- wrapper no-op (ver utils\fgravarlog.prg) - transcrito por fidelidade
                loc_cDopps = IIF(USED("CrSigCdNec"), TratarNulo(CrSigCdNec.Dopps, ""), "")
                = fGravarLog("T", loc_cDopps, "AUTOMATICO", ;
                    ALLTRIM(csCabec.Emps) + "-" + ALLTRIM(csCabec.Dopes) + "-" + ALLTRIM(STR(loc_nNum, 6)))
            ENDIF

            *-- 7. Persiste no SQL Server, dentro da MESMA transacao (equivalente a
            *-- "poDataMgr.UpDate('crSigMvCab') / ... / poDataMgr.Commit()")
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigInBep", "SigInBep")
            ENDIF

            IF loc_lOks
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Falha ao confirmar a grava" + CHR(231) + CHR(227) + "o." + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOks = .F.
                ENDIF
            ENDIF

            IF !loc_lOks
                = SQLROLLBACK(gnConnHandle)
            ELSE
                *-- "Go Top In crSigMvCab / Replace Gerado With 'OK', GerEmps...,
                *-- GerDopes..., GerNumes... In csCabec"
                THIS.this_nNumeroGerado  = loc_nNum
                THIS.this_cMascaraNumero = loc_cMsk
                THIS.this_cGerEmps       = loc_cGerEmps
                THIS.this_cGerDopes      = loc_cGerDopes
                THIS.this_nGerNumes      = loc_nNum
                THIS.this_lGerado        = .T.

                SELECT csCabec
                REPLACE Gerado   WITH "OK", ;
                        GerEmps  WITH loc_cGerEmps, ;
                        GerDopes WITH loc_cGerDopes, ;
                        GerNumes WITH loc_nNum

                THIS.RegistrarAuditoria("GERAR")
            ENDIF

        CATCH TO loc_oErro
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            MsgErro(THIS.this_cMensagemErro, "SigPrGstBO.GerarPedido")
            loc_lOks = .F.
        ENDTRY

        *-- Fecha cursores de trabalho locais
        IF USED("crSigCdEmb")
            USE IN crSigCdEmb
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        IF USED("crSigMvItn")
            USE IN crSigMvItn
        ENDIF
        IF USED("crSigMvIts")
            USE IN crSigMvIts
        ENDIF
        IF USED("CrSigMvPec")
            USE IN CrSigMvPec
        ENDIF
        IF USED("CrSigInBep")
            USE IN CrSigInBep
        ENDIF
        IF USED("crTmpPro")
            USE IN crTmpPro
        ENDIF
        IF USED("crTmpGru")
            USE IN crTmpGru
        ENDIF

        RETURN loc_lOks
    ENDFUNC

ENDDEFINE

