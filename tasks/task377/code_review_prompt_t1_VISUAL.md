# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 181: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 308: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 497: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 520: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNQ.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1048 linhas total):

*-- Linhas 51 a 61:
51:                 THIS.ConfigurarPaginaLista()
52:                 THIS.ConfigurarPaginaDados()
53: 
54:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
55:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 ENDIF
58: 
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     THIS.CarregarLista()
61:                 ENDIF

*-- Linhas 84 a 104:
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 629
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103:     ENDPROC
104: 

*-- Linhas 116 a 153:
116:         *-- Container cabecalho (cntSombra original: Top=2 -> 31 com compensacao)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = 1020
122:             .Height      = 80
123:             .BackStyle   = 0
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .AutoSize  = .F.
139:             .BackStyle = 0
140:             .ForeColor = RGB(0, 0, 0)
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.

*-- Linhas 160 a 279:
160:         *-- Container botoes CRUD (Grupo_op original: Top=-1 -> 29, Left=338 -> canonical 542)
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 400
166:             .Height      = 85
167:             .BackStyle   = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
176:             .PicturePosition = 13
177:             .Top             = 5
178:             .Left            = 5
179:             .Width           = 75
180:             .Height          = 75
181:             .FontName        = "Comic Sans MS"
182:             .FontSize        = 8
183:             .FontBold        = .T.
184:             .FontItalic      = .T.
185:             .ForeColor       = RGB(90, 90, 90)
186:             .BackColor       = RGB(255, 255, 255)
187:             .Themes          = .F.
188:             .SpecialEffect   = 0
189:             .MousePointer    = 15
190:             .WordWrap        = .T.
191:             .AutoSize        = .F.
192:             .Visible         = .T.
193:         ENDWITH
194: 
195:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
196:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
197:             .Caption         = "Visualizar"
198:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
199:             .PicturePosition = 13
200:             .Top             = 5
201:             .Left            = 80
202:             .Width           = 75
203:             .Height          = 75
204:             .FontName        = "Comic Sans MS"
205:             .FontSize        = 8
206:             .FontBold        = .T.
207:             .FontItalic      = .T.
208:             .ForeColor       = RGB(90, 90, 90)
209:             .BackColor       = RGB(255, 255, 255)
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .MousePointer    = 15
213:             .WordWrap        = .T.
214:             .AutoSize        = .F.
215:             .Visible         = .T.
216:         ENDWITH
217: 
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
220:             .Caption         = "Alterar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 155
225:             .Width           = 75
226:             .Height          = 75
227:             .FontName        = "Comic Sans MS"
228:             .FontSize        = 8
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .ForeColor       = RGB(90, 90, 90)
232:             .BackColor       = RGB(255, 255, 255)
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .FontBold        = .T.
253:             .FontItalic      = .T.
254:             .ForeColor       = RGB(90, 90, 90)
255:             .BackColor       = RGB(255, 255, 255)
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:             .AutoSize        = .F.
261:             .Visible         = .T.
262:         ENDWITH
263: 
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
266:             .Caption         = "Buscar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 305
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Comic Sans MS"
274:             .FontSize        = 8
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.

*-- Linhas 287 a 314:
287:         *-- Container saida canonico (CLAUDE.md regra #10: Left=917, Width=90)
288:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
289:         WITH loc_oPagina.cnt_4c_Saida
290:             .Top         = 29
291:             .Left        = 917
292:             .Width       = 90
293:             .Height      = 85
294:             .BackStyle   = 0
295:             .BorderWidth = 0
296:             .Visible     = .T.
297:         ENDWITH
298: 
299:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301:             .Caption         = "Encerrar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303:             .PicturePosition = 13
304:             .Width           = 75
305:             .Height          = 75
306:             .Left            = 5
307:             .Top             = 5
308:             .FontName        = "Comic Sans MS"
309:             .FontSize        = 8
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .ForeColor       = RGB(90, 90, 90)
313:             .BackColor       = RGB(255, 255, 255)
314:             .Themes          = .F.

*-- Linhas 323 a 332:
323:         *-- RecordSource e ControlSource configurados em CarregarLista() apos Buscar()
324:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
325:         loc_oGrid                    = loc_oPagina.grd_4c_Lista
326:         loc_oGrid.Top                = 117
327:         loc_oGrid.Left               = 2
328:         loc_oGrid.Width              = 910
329:         loc_oGrid.Height             = 477
330:         loc_oGrid.ColumnCount        = 3
331:         loc_oGrid.GridLines          = 3
332:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)

*-- Linhas 344 a 357:
344:         loc_oGrid.Visible            = .T.
345: 
346:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
347:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,  "Click", THIS, "BtnVisualizarClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
353: 
354:         THIS.TornarControlesVisiveis(loc_oPagina)
355:     ENDPROC
356: 
357:     *--------------------------------------------------------------------------

*-- Linhas 367 a 379:
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- Label Conquilha (Say1: top=150+29=179, left=343)
370:         loc_oPagina.AddObject("lbl_4c_Conquilha", "Label")
371:         WITH loc_oPagina.lbl_4c_Conquilha
372:             .Caption   = "Conquilha :"
373:             .Top       = 179
374:             .Left      = 343
375:             .Width     = 57
376:             .Height    = 17
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .FontBold  = .F.

*-- Linhas 388 a 414:
388:         loc_oPagina.AddObject("txt_4c_Conquilha", "TextBox")
389:         WITH loc_oPagina.txt_4c_Conquilha
390:             .Value        = ""
391:             .Top          = 176
392:             .Left         = 402
393:             .Width        = 115
394:             .Height       = 23
395:             .FontName     = "Tahoma"
396:             .FontSize     = 8
397:             .MaxLength    = 30
398:             .BackColor    = RGB(255, 255, 255)
399:             .ForeColor    = RGB(90, 90, 90)
400:             .Enabled      = .T.
401:             .Visible      = .T.
402:         ENDWITH
403: 
404:         *-- Label Codigo Tamanho/Aro (Say2: top=177+29=206, left=282)
405:         loc_oPagina.AddObject("lbl_4c_CodTam", "Label")
406:         WITH loc_oPagina.lbl_4c_CodTam
407:             .Caption   = "C" + CHR(243) + "digo Tamanho (Aro) :"
408:             .Top       = 206
409:             .Left      = 282
410:             .Width     = 118
411:             .Height    = 17
412:             .FontName  = "Tahoma"
413:             .FontSize  = 8
414:             .FontBold  = .F.

*-- Linhas 424 a 450:
424:         loc_oPagina.AddObject("txt_4c_CodTam", "TextBox")
425:         WITH loc_oPagina.txt_4c_CodTam
426:             .Value        = ""
427:             .Top          = 203
428:             .Left         = 402
429:             .Width        = 59
430:             .Height       = 23
431:             .FontName     = "Tahoma"
432:             .FontSize     = 8
433:             .MaxLength    = 10
434:             .BackColor    = RGB(255, 255, 255)
435:             .ForeColor    = RGB(90, 90, 90)
436:             .Enabled      = .T.
437:             .Visible      = .T.
438:         ENDWITH
439: 
440:         *-- Label Valor (Say8: top=205+29=234, left=366)
441:         loc_oPagina.AddObject("lbl_4c_Valor", "Label")
442:         WITH loc_oPagina.lbl_4c_Valor
443:             .Caption   = "Valor :"
444:             .Top       = 234
445:             .Left      = 366
446:             .Width     = 34
447:             .Height    = 17
448:             .FontName  = "Tahoma"
449:             .FontSize  = 8
450:             .FontBold  = .F.

*-- Linhas 459 a 468:
459:         loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
460:         WITH loc_oPagina.txt_4c_Valor
461:             .Value        = 0
462:             .Top          = 231
463:             .Left         = 402
464:             .Width        = 59
465:             .Height       = 23
466:             .FontName     = "Tahoma"
467:             .FontSize     = 8
468:             .InputMask    = "999999.99"

*-- Linhas 476 a 526:
476:         *-- Container botoes de acao (Grupo_Salva original: Top=4 -> 33, Left=842)
477:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
478:         WITH loc_oPagina.cnt_4c_BotoesAcao
479:             .Top         = 33
480:             .Left        = 842
481:             .Width       = 160
482:             .Height      = 85
483:             .BackStyle   = 0
484:             .BorderWidth = 0
485:             .Visible     = .T.
486:         ENDWITH
487: 
488:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
489:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
490:             .Caption         = "Confirmar"
491:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
492:             .PicturePosition = 13
493:             .Top             = 5
494:             .Left            = 5
495:             .Width           = 75
496:             .Height          = 75
497:             .FontName        = "Comic Sans MS"
498:             .FontSize        = 8
499:             .FontBold        = .T.
500:             .FontItalic      = .T.
501:             .ForeColor       = RGB(90, 90, 90)
502:             .BackColor       = RGB(255, 255, 255)
503:             .Themes          = .F.
504:             .SpecialEffect   = 0
505:             .MousePointer    = 15
506:             .WordWrap        = .T.
507:             .AutoSize        = .F.
508:             .Visible         = .T.
509:         ENDWITH
510: 
511:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
512:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
513:             .Caption         = "Encerrar"
514:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
515:             .PicturePosition = 13
516:             .Top             = 5
517:             .Left            = 80
518:             .Width           = 75
519:             .Height          = 75
520:             .FontName        = "Comic Sans MS"
521:             .FontSize        = 8
522:             .FontBold        = .T.
523:             .FontItalic      = .T.
524:             .ForeColor       = RGB(90, 90, 90)
525:             .BackColor       = RGB(255, 255, 255)
526:             .Themes          = .F.

*-- Linhas 537 a 546:
537:         BINDEVENT(loc_oPagina.txt_4c_CodTam, "DblClick",  THIS, "CodTamDblClick")
538: 
539:         *-- BINDEVENTs botoes
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
541:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
542: 
543:         THIS.TornarControlesVisiveis(loc_oPagina)
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------

*-- Linhas 569 a 587:
569:                     WITH loc_oGrid
570:                         .Column1.ControlSource   = "cursor_4c_Dados.conquilhas"
571:                         .Column1.Width           = 150
572:                         .Column1.Header1.Caption = "Conquilha"
573:                         .Column1.Alignment       = 0
574: 
575:                         .Column2.ControlSource   = "cursor_4c_Dados.codtams"
576:                         .Column2.Width           = 100
577:                         .Column2.Header1.Caption = "Aro"
578:                         .Column2.Alignment       = 1
579: 
580:                         .Column3.ControlSource   = "cursor_4c_Dados.valors"
581:                         .Column3.Width           = 100
582:                         .Column3.Header1.Caption = "Valor"
583:                         .Column3.Alignment       = 1
584:                     ENDWITH
585: 
586:                     THIS.FormatarGridLista(loc_oGrid)
587:                     loc_oGrid.Refresh()

*-- Linhas 751 a 759:
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * BtnSalvarClick - Salvar alteracoes (chamado por cmd_4c_Confirmar)
755:     *--------------------------------------------------------------------------
756:     PROCEDURE BtnSalvarClick()
757:         LOCAL loc_lSucesso
758:         loc_lSucesso = .F.
759: 

*-- Linhas 875 a 884:
875: 
876:         *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
877:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
878:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
879:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
880:             ENDIF
881:         ENDIF
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------

*-- Linhas 890 a 903:
890:         loc_lNaLista = (THIS.this_cModoAtual = "LISTA")
891: 
892:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
893:             IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
894:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lNaLista
895:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lNaLista
896:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lNaLista
897:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lNaLista
898:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lNaLista
899:             ENDIF
900:         ENDIF
901:     ENDPROC
902: 
903:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\CNQBO.prg):
*==============================================================================
* CNQBO.prg - Business Object para Conquilhas (CNQ)
* Tabela: SigCdCnq | PK: conquilhas+codtams (chave composta de negocio)
* Schema: codtams char(4), conquilhas char(10), valors numeric(6,3)
*==============================================================================

DEFINE CLASS CNQBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCnq)
    this_cConquilha = ""    && Conquilhas CHAR(10)     - Conquilha
    this_cCodTam    = ""    && Codtams    CHAR(4)      - Codigo Tamanho (Aro) FK->SigCdTam.cods
    this_nValor     = 0     && Valors     NUMERIC(6,3) - Valor

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnq"
        THIS.this_cCampoChave = "conquilhas"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cConquilha = TratarNulo(Conquilhas, "C")
                THIS.this_cCodTam    = TratarNulo(Codtams,    "C")
                THIS.this_nValor     = TratarNulo(Valors,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CNQBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica conquilha + codtam duplicados no INSERT
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nRes, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdCnq" + ;
                       " WHERE conquilhas = " + EscaparSQL(THIS.this_cConquilha) + ;
                       " AND codtams = " + EscaparSQL(THIS.this_cCodTam)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.Total > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "CNQBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cConquilha))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conquilha.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Conquilha j" + CHR(225) + " cadastrada para este tamanho (Aro).")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnq (conquilhas, codtams, valors)
                VALUES (
                    <<EscaparSQL(THIS.this_cConquilha)>>,
                    <<EscaparSQL(THIS.this_cCodTam)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CNQBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnq
                SET valors = <<FormatarNumeroSQL(THIS.this_nValor, 3)>>
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CNQBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnq
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(THIS.this_cConquilha)>>
                AND codtams = <<EscaparSQL(THIS.this_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CNQBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com conquilhas, codtams, valors
    * Ordenado por conquilhas (ordem original do legado)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (conquilhas C(10), codtams C(4), valors N(6,3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT conquilhas, codtams, valors FROM SigCdCnq"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY conquilhas"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar conquilhas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CNQBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave composta "conquilhas|codtams"
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChaveComposta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cConquilha, loc_cCodTam, loc_nSep
        loc_lSucesso = .F.

        TRY
            loc_nSep      = AT("|", par_cChaveComposta)
            loc_cConquilha = ALLTRIM(LEFT(par_cChaveComposta, loc_nSep - 1))
            loc_cCodTam    = ALLTRIM(SUBSTR(par_cChaveComposta, loc_nSep + 1))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT conquilhas, codtams, valors
                FROM SigCdCnq
                WHERE conquilhas = <<EscaparSQL(loc_cConquilha)>>
                AND codtams = <<EscaparSQL(loc_cCodTam)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Conquilha n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar conquilha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CNQBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cConquilha) + "|" + ALLTRIM(THIS.this_cCodTam)
    ENDFUNC

ENDDEFINE

