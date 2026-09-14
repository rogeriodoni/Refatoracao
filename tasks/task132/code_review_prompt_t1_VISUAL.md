# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 334: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 356: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 378: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReJob.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (604 linhas total):

*-- Linhas 39 a 47:
39: * FASE 6/8 CONCLUIDA - Form - Campos Restantes e Lookups
40: *   RESULTADO: ConfigurarPaginaDados() corretamente vazio - form FLAT nao tem
41: *   Page2 de dados nem campos de entrada. O SCX original (Width=800, Height=130)
42: *   nao tinha TextBox, ComboBox, CheckBox nem lookups F4/F5. Nao ha campos
43: *   "restantes" a adicionar nem botoes Salvar/Cancelar (inexistentes no legado).
44: *   Toda a logica de selecao de dados esta em SigReJobBO.PrepararDadosInterno().
45: *
46: * IMPLEMENTACAO COMPLETA (Fases 3-7):
47: *   * DEFINE CLASS com todas as propriedades (this_oRelatorio, this_oParentFormRef)

*-- Linhas 121 a 132:
121:         TRY
122:             *-- Caption dinamico: "Impressao de <titulo do job>"
123:             IF VARTYPE(THIS.this_oParentFormRef) = "O"
124:                 THIS.Caption = "Impress" + CHR(227) + "o de " + ;
125:                                ALLTRIM(THIS.this_oParentFormRef.CfgTitJob)
126:             ELSE
127:                 THIS.Caption = "Impress" + CHR(227) + "o de Documento"
128:             ENDIF
129: 
130:             IF TYPE("gc_4c_CaminhoIcones") = "U"
131:                 gc_4c_CaminhoIcones = ""
132:             ENDIF

*-- Linhas 155 a 164:
155:             THIS.ConfigurarPageFrame()
156: 
157:             *-- Aplicar caption nos labels do cabecalho
158:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
159:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
160: 
161:             THIS.Visible    = .T.
162:             loc_lSucesso = .T.
163:         CATCH TO loc_oErro
164:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 242 a 317:
242:     PROTECTED PROCEDURE ConfigurarCabecalho()
243:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
244:         WITH THIS.cnt_4c_Cabecalho
245:             .Top         = 0
246:             .Left        = 0
247:             .Width       = THIS.Width
248:             .Height      = 80
249:             .BackStyle   = 1
250:             .BackColor   = RGB(100, 100, 100)
251:             .BorderWidth = 0
252:             .Visible     = .T.
253: 
254:             .AddObject("lbl_4c_Sombra", "Label")
255:             WITH .lbl_4c_Sombra
256:                 .Top       = 15
257:                 .Left      = 10
258:                 .Width     = THIS.Width
259:                 .Height    = 40
260:                 .FontName  = "Tahoma"
261:                 .FontSize  = 16
262:                 .FontBold  = .T.
263:                 .ForeColor = RGB(0, 0, 0)
264:                 .BackStyle = 0
265:                 .Caption   = ""
266:                 .Visible   = .T.
267:             ENDWITH
268: 
269:             .AddObject("lbl_4c_Titulo", "Label")
270:             WITH .lbl_4c_Titulo
271:                 .Top       = 18
272:                 .Left      = 10
273:                 .Width     = THIS.Width
274:                 .Height    = 46
275:                 .FontName  = "Tahoma"
276:                 .FontSize  = 16
277:                 .FontBold  = .T.
278:                 .ForeColor = RGB(255, 255, 255)
279:                 .BackStyle = 0
280:                 .Caption   = ""
281:                 .Visible   = .T.
282:             ENDWITH
283:         ENDWITH
284:     ENDPROC
285: 
286:     *--------------------------------------------------------------------------
287:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
288:     *   Equivalente ao btnReport do frmrelatorio legado.
289:     *   Buttons(1)=Visualizar, Buttons(2)=Imprimir, Buttons(3)=Arquivos, Buttons(4)=Sair
290:     *   Left=533 (exato do original: btnReport.Left=533)
291:     *--------------------------------------------------------------------------
292:     PROTECTED PROCEDURE ConfigurarBotoes()
293:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
294:         WITH THIS.cmg_4c_Botoes
295:             .Top           = 0
296:             .Left          = 533
297:             .Width         = 273
298:             .Height        = 80
299:             .ButtonCount   = 4
300:             .BackStyle     = 0
301:             .BorderStyle   = 0
302:             .BorderColor   = RGB(136, 189, 188)
303:             .SpecialEffect = 1
304:             .Themes        = .F.
305:             .Visible       = .T.
306: 
307:             WITH .Buttons(1)
308:                 .Top             = 5
309:                 .Left            = 5
310:                 .Width           = 65
311:                 .Height          = 70
312:                 .Caption         = "Visualizar"
313:                 .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
314:                 .FontBold        = .T.
315:                 .FontItalic      = .T.
316:                 .BackColor       = RGB(255, 255, 255)
317:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 325 a 340:
325:             ENDWITH
326: 
327:             WITH .Buttons(2)
328:                 .Top             = 5
329:                 .Left            = 71
330:                 .Width           = 65
331:                 .Height          = 70
332:                 .Caption         = "Imprimir"
333:                 .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
334:                 .FontName        = "Comic Sans MS"
335:                 .FontBold        = .T.
336:                 .FontItalic      = .T.
337:                 .FontSize        = 8
338:                 .BackColor       = RGB(255, 255, 255)
339:                 .ForeColor       = RGB(90, 90, 90)
340:                 .PicturePosition = 13

*-- Linhas 347 a 362:
347:             ENDWITH
348: 
349:             WITH .Buttons(3)
350:                 .Top             = 5
351:                 .Left            = 137
352:                 .Width           = 65
353:                 .Height          = 70
354:                 .Caption         = "Arquivos"
355:                 .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
356:                 .FontName        = "Comic Sans MS"
357:                 .FontBold        = .T.
358:                 .FontItalic      = .T.
359:                 .FontSize        = 8
360:                 .BackColor       = RGB(255, 255, 255)
361:                 .ForeColor       = RGB(90, 90, 90)
362:                 .PicturePosition = 13

*-- Linhas 369 a 384:
369:             ENDWITH
370: 
371:             WITH .Buttons(4)
372:                 .Top             = 5
373:                 .Left            = 203
374:                 .Width           = 65
375:                 .Height          = 70
376:                 .Caption         = "Sair"
377:                 .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
378:                 .FontName        = "Comic Sans MS"
379:                 .FontBold        = .T.
380:                 .FontItalic      = .T.
381:                 .FontSize        = 8
382:                 .BackColor       = RGB(255, 255, 255)
383:                 .ForeColor       = RGB(90, 90, 90)
384:                 .PicturePosition = 13

*-- Linhas 496 a 507:
496:             loc_cCaption = "Impress" + CHR(227) + "o de " + ;
497:                            ALLTRIM(THIS.this_oParentFormRef.CfgTitJob)
498:             IF THIS.Caption != loc_cCaption
499:                 THIS.Caption = loc_cCaption
500:                 IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
501:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
502:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
503:                 ENDIF
504:             ENDIF
505:         ENDIF
506:     ENDPROC
507: 

*-- Linhas 563 a 571:
563: 
564:     *--------------------------------------------------------------------------
565:     * BtnEncerrarClick - Fecha o form (alias canonico para o botao Encerrar)
566:     *   Mantem consistencia de nomenclatura com cnt_4c_Saida/cmd_4c_Encerrar
567:     *   dos forms CRUD. Delega para BtnSairClick().
568:     *--------------------------------------------------------------------------
569:     PROCEDURE BtnEncerrarClick()
570:         THIS.BtnSairClick()
571:     ENDPROC

