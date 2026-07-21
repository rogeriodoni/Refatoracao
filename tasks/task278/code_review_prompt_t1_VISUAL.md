# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [ALINHAMENTO] Botao 'cmd_4c_BtnEmail' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [FONTNAME-ERRADO] Linha 229: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 256: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (789 linhas total):

*-- Linhas 91 a 100:
91:                     THIS.ConfigurarBINDEVENTs()
92: 
93:                     *-- Propagar Caption para labels do cabecalho
94:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
95:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                     THIS.grd_4c_Dados.Refresh()
98:                     loc_lSucesso = .T.
99:                 ENDIF
100:             ENDIF

*-- Linhas 118 a 141:
118:     *==========================================================================
119:     * ConfigurarPaginaLista - Bloco fixo do topo do form OPERACIONAL
120:     *--------------------------------------------------------------------------
121:     * Equivale a "Page1 (Lista)" dos forms CRUD. Neste form plano monta o
122:     * cabecalho escuro (cnt_4c_Sombra), o shape decorativo, o botao Enviar
123:     * Email flutuante (cmd_4c_BtnEmail) e o container de saida (cnt_4c_Saida
124:     * com cmd_4c_Encerrar) que sao persistentes na visualizacao.
125:     *==========================================================================
126:     PROTECTED PROCEDURE ConfigurarPaginaLista()
127:         THIS.ConfigurarCabecalho()
128:         THIS.ConfigurarBotoes()
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPaginaDados - Area de trabalho (grid + botoes de selecao)
133:     *--------------------------------------------------------------------------
134:     * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta a
135:     * grade principal (grd_4c_Dados exibindo cursor_4c_Total) e os botoes
136:     * auxiliares cmd_4c_SelTudo/cmd_4c_Apaga que operam sobre o cursor de
137:     * destinatarios.
138:     *==========================================================================
139:     PROTECTED PROCEDURE ConfigurarPaginaDados()
140:         THIS.ConfigurarGrade()
141:         THIS.ConfigurarSelecaoBotoes()

*-- Linhas 160 a 308:
160:         THIS.AddObject("cnt_4c_Sombra", "Container")
161:         WITH THIS.cnt_4c_Sombra
162:             .Visible     = .T.
163:             .Top         = 0
164:             .Left        = 0
165:             .Width       = THIS.Width
166:             .Height      = 80
167:             .BorderWidth = 0
168:             .BackColor   = RGB(100, 100, 100)
169:             .AddObject("lbl_4c_Sombra", "Label")
170:             WITH .lbl_4c_Sombra
171:                 .FontBold      = .T.
172:                 .FontName      = "Tahoma"
173:                 .FontSize      = 18
174:                 .FontUnderline = .F.
175:                 .WordWrap      = .T.
176:                 .Alignment     = 0
177:                 .AutoSize      = .F.
178:                 .BackStyle     = 0
179:                 .Caption       = THIS.Caption
180:                 .Height        = 40
181:                 .Left          = 10
182:                 .Top           = 18
183:                 .Width         = THIS.Width
184:                 .ForeColor     = RGB(0, 0, 0)
185:             ENDWITH
186:             .AddObject("lbl_4c_Titulo", "Label")
187:             WITH .lbl_4c_Titulo
188:                 .FontBold   = .T.
189:                 .FontName   = "Tahoma"
190:                 .FontSize   = 18
191:                 .WordWrap   = .T.
192:                 .Alignment  = 0
193:                 .AutoSize   = .F.
194:                 .BackStyle  = 0
195:                 .Caption    = THIS.Caption
196:                 .Height     = 46
197:                 .Left       = 10
198:                 .Top        = 17
199:                 .Width      = THIS.Width
200:                 .ForeColor  = RGB(255, 255, 255)
201:             ENDWITH
202:         ENDWITH
203:     ENDPROC
204: 
205:     *==========================================================================
206:     PROTECTED PROCEDURE ConfigurarBotoes
207:     *==========================================================================
208:         *-- Shape decorativo (Shape1 do legado)
209:         THIS.AddObject("shp_4c_Shape1", "Shape")
210:         WITH THIS.shp_4c_Shape1
211:             .Top           = -2
212:             .Left          = 819
213:             .Height        = 84
214:             .Width         = 84
215:             .BackStyle     = 0
216:             .BorderStyle   = 0
217:             .SpecialEffect = 1
218:         ENDWITH
219: 
220:         *-- Botao Enviar Email (btnEmail do legado) - standalone com icone 60px
221:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
222:         WITH THIS.cmd_4c_BtnEmail
223:             .Top         = 3
224:             .Left        = 848
225:             .Height      = 75
226:             .Width       = 75
227:             .FontBold    = .T.
228:             .FontItalic  = .T.
229:             .FontName    = "Comic Sans MS"
230:             .FontSize    = 8
231:             .Picture     = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
232:             .Caption     = "Enviar Email"
233:             .ToolTipText = "Enviar Email"
234:             .ForeColor   = RGB(90, 90, 90)
235:             .BackColor   = RGB(255, 255, 255)
236:             .Themes      = .T.
237:         ENDWITH
238: 
239:         *-- Container canonico Encerrar (padrao novo sistema, Left=917)
240:         THIS.AddObject("cnt_4c_Saida", "Container")
241:         WITH THIS.cnt_4c_Saida
242:             .Top         = -2
243:             .Left        = 917
244:             .Width       = 90
245:             .Height      = 85
246:             .BorderWidth = 0
247:             .BackStyle   = 0
248:             .AddObject("cmd_4c_Encerrar", "CommandButton")
249:             WITH .cmd_4c_Encerrar
250:                 .Top         = 5
251:                 .Left        = 917
252:                 .Height      = 75
253:                 .Width       = 90
254:                 .FontBold    = .T.
255:                 .FontItalic  = .T.
256:                 .FontName    = "Comic Sans MS"
257:                 .FontSize    = 8
258:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
259:                 .Cancel      = .T.
260:                 .Caption     = "Encerrar"
261:                 .ToolTipText = "[Esc] Encerrar"
262:                 .ForeColor   = RGB(90, 90, 90)
263:                 .BackColor   = RGB(255, 255, 255)
264:             ENDWITH
265:         ENDWITH
266:     ENDPROC
267: 
268:     *==========================================================================
269:     PROTECTED PROCEDURE ConfigurarSelecaoBotoes
270:     *==========================================================================
271:         *-- Botao Marcar Todos (SelTudo do legado)
272:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
273:         WITH THIS.cmd_4c_SelTudo
274:             .Top         = 90
275:             .Left        = 4
276:             .Height      = 40
277:             .Width       = 40
278:             .FontName    = "Verdana"
279:             .FontSize    = 8
280:             .WordWrap    = .T.
281:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
282:             .Caption     = ""
283:             .TabStop     = .F.
284:             .ToolTipText = "Marcar Todos"
285:             .ForeColor   = RGB(36, 84, 155)
286:             .BackColor   = RGB(255, 255, 255)
287:             .Themes      = .T.
288:         ENDWITH
289: 
290:         *-- Botao Desmarcar Todos (apaga do legado)
291:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
292:         WITH THIS.cmd_4c_Apaga
293:             .Top         = 90
294:             .Left        = 43
295:             .Height      = 40
296:             .Width       = 40
297:             .FontBold    = .F.
298:             .FontItalic  = .F.
299:             .FontName    = "Verdana"
300:             .FontSize    = 8
301:             .WordWrap    = .T.
302:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
303:             .Caption     = ""
304:             .TabStop     = .F.
305:             .ToolTipText = "Desmarcar Todos"
306:             .ForeColor   = RGB(36, 84, 155)
307:             .BackColor   = RGB(255, 255, 255)
308:             .Themes      = .T.

*-- Linhas 314 a 323:
314:     *==========================================================================
315:         THIS.AddObject("grd_4c_Dados", "Grid")
316:         WITH THIS.grd_4c_Dados
317:             .Top                  = 132
318:             .Left                 = 3
319:             .Width                = 993
320:             .Height               = 435
321:             .RecordMark           = .F.
322:             .DeleteMark           = .F.
323:             .RowHeight            = 18

*-- Linhas 333 a 372:
333:             .GridLines            = 2
334:             .ColumnCount          = 5
335: 
336:             *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
337:             *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
338:             WITH .Column1
339:                 .ColumnOrder   = 1
340:                 .Width         = 17
341:                 .ReadOnly      = .F.
342:                 WITH .Header1
343:                     .Caption  = ""
344:                     .FontName = "Verdana"
345:                     .FontSize = 8
346:                 ENDWITH
347:                 .AddObject("ctlCheckbox", "CheckBox")
348:                 WITH .ctlCheckbox
349:                     .Caption   = ""
350:                     .Alignment = 0
351:                     .FontName  = "Verdana"
352:                     .FontSize  = 8
353:                     .Value     = 0
354:                 ENDWITH
355:                 .CurrentControl = "ctlCheckbox"
356:                 .Sparse        = .F.
357:                 .ControlSource = "cursor_4c_Total.Checks"
358:             ENDWITH
359: 
360:             *-- Column2: Conta (ColumnOrder=2)
361:             WITH .Column2
362:                 .ColumnOrder   = 2
363:                 .Width         = 80
364:                 .ReadOnly      = .T.
365:                 .ControlSource = "cursor_4c_Total.Contas"
366:                 WITH .Header1
367:                     .Caption   = " Conta"
368:                     .Alignment = 2
369:                     .FontName  = "Verdana"
370:                     .FontSize  = 8
371:                     .BackColor = RGB(192, 192, 192)
372:                 ENDWITH

*-- Linhas 390 a 398:
390:                 .ReadOnly      = .T.
391:                 .ControlSource = "cursor_4c_Total.Rclis"
392:                 WITH .Header1
393:                     .Caption   = " Nome"
394:                     .Alignment = 2
395:                     .FontName  = "Verdana"
396:                     .FontSize  = 8
397:                     .BackColor = RGB(64, 128, 128)
398:                 ENDWITH

*-- Linhas 416 a 424:
416:                 .ReadOnly      = .F.
417:                 .ControlSource = "cursor_4c_Total.emails"
418:                 WITH .Header1
419:                     .Caption   = "Email"
420:                     .Alignment = 2
421:                     .FontName  = "Verdana"
422:                     .FontSize  = 8
423:                     .BackColor = RGB(192, 192, 192)
424:                 ENDWITH

*-- Linhas 443 a 451:
443:                 .Sparse        = .F.
444:                 .ControlSource = "cursor_4c_Total.mensagems"
445:                 WITH .Header1
446:                     .Caption   = "Mensagem"
447:                     .Alignment = 2
448:                     .FontName  = "Verdana"
449:                     .FontSize  = 8
450:                 ENDWITH
451:                 .AddObject("ctlEditBox", "EditBox")

*-- Linhas 473 a 494:
473: 
474:     *==========================================================================
475:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
476:     *==========================================================================
477:         *-- Botoes de acao
478:         BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
479:         BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
480:         BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
481:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
482: 
483:         *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
484:         BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
485:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")
486:         BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "Col4HeaderClick")
487: 
488:         *-- Checkbox individual para marcar/desmarcar linha
489:         BINDEVENT(THIS.grd_4c_Dados.Column1.ctlCheckbox, "InteractiveChange", ;
490:                   THIS, "GrdChkInteractiveChange")
491:     ENDPROC
492: 
493:     *==========================================================================
494:     * TornarControlesVisiveis - Form plano (sem PageFrame); nao ha containers

*-- Linhas 592 a 600:
592:     PROCEDURE GrdChkInteractiveChange()
593:         LOCAL loc_nValue
594:         IF USED("cursor_4c_Total")
595:             loc_nValue = THIS.grd_4c_Dados.Column1.ctlCheckbox.Value
596:             REPLACE Checks WITH loc_nValue IN cursor_4c_Total
597:         ENDIF
598:         THIS.grd_4c_Dados.Refresh()
599:     ENDPROC
600: 

*-- Linhas 718 a 739:
718:     PROCEDURE HabilitarCampos(par_lHabilitar)
719:         LOCAL loc_lTemDados
720: 
721:         loc_lTemDados = USED("cursor_4c_Total") AND RECCOUNT("cursor_4c_Total") > 0
722: 
723:         IF PEMSTATUS(THIS, "cmd_4c_BtnEmail", 5)
724:             THIS.cmd_4c_BtnEmail.Enabled = loc_lTemDados
725:         ENDIF
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * LimparCampos - Form OPERACIONAL: desmarca todos os destinatarios
730:     *--------------------------------------------------------------------------
731:     * Equivale ao botao "Desmarcar Todos". Mantem semantica de "limpar
732:     * selecao atual" sem fechar o form.
733:     *==========================================================================
734:     PROCEDURE LimparCampos()
735:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
736:             THIS.this_oBusinessObject.DesmarcarTodos()
737:         ENDIF
738:         THIS.grd_4c_Dados.Refresh()
739:     ENDPROC

