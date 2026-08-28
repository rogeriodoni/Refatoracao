# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 174: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 197: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 220: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 266: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 383: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 406: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMTV.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (873 linhas total):

*-- Linhas 77 a 96:
77: 
78:         WITH THIS.pgf_4c_Paginas
79:             .PageCount  = 2
80:             .Top        = -29
81:             .Left       = 0
82:             .Width      = THIS.Width
83:             .Height     = THIS.Height + 29
84:             .Tabs       = .F.
85:             .Visible    = .T.
86: 
87:             .Page1.Caption   = "Lista"
88:             .Page1.BackColor = RGB(255, 255, 255)
89:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90: 
91:             .Page2.Caption   = "Dados"
92:             .Page2.BackColor = RGB(255, 255, 255)
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:         ENDWITH
95: 
96:         THIS.ConfigurarPaginaLista()

*-- Linhas 111 a 147:
111:         *-- Container cabecalho com titulo
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 31
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121:         ENDWITH
122: 
123:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
124:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
125:             .Caption   = THIS.Caption
126:             .Top       = 15
127:             .Left      = 10
128:             .Width     = 769
129:             .Height    = 40
130:             .FontName  = "Tahoma"
131:             .FontSize  = 16
132:             .FontBold  = .T.
133:             .ForeColor = RGB(0, 0, 0)
134:             .BackStyle = 0
135:             .Visible   = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
140:             .Caption   = THIS.Caption
141:             .Top       = 18
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 46
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.

*-- Linhas 153 a 272:
153:         *-- Container para botoes CRUD
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 29
157:             .Left        = 542
158:             .Width       = 390
159:             .Height      = 85
160:             .BackStyle = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
166:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
167:             .Caption         = "Incluir"
168:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
169:             .PicturePosition = 13
170:             .Top             = 5
171:             .Left            = 5
172:             .Width           = 75
173:             .Height          = 75
174:             .FontName        = "Comic Sans MS"
175:             .FontBold        = .T.
176:             .FontItalic      = .T.
177:             .FontSize        = 8
178:             .ForeColor       = RGB(90, 90, 90)
179:             .BackColor       = RGB(255, 255, 255)
180:             .Themes          = .F.
181:             .SpecialEffect   = 0
182:             .MousePointer    = 15
183:             .WordWrap        = .T.
184:             .AutoSize        = .F.
185:             .Visible         = .T.
186:         ENDWITH
187: 
188:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
189:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
190:             .Caption         = "Visualizar"
191:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:             .PicturePosition = 13
193:             .Top             = 5
194:             .Left            = 80
195:             .Width           = 75
196:             .Height          = 75
197:             .FontName        = "Comic Sans MS"
198:             .FontBold        = .T.
199:             .FontItalic      = .T.
200:             .FontSize        = 8
201:             .ForeColor       = RGB(90, 90, 90)
202:             .BackColor       = RGB(255, 255, 255)
203:             .Themes          = .F.
204:             .SpecialEffect   = 0
205:             .MousePointer    = 15
206:             .WordWrap        = .T.
207:             .AutoSize        = .F.
208:             .Visible         = .T.
209:         ENDWITH
210: 
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 155
218:             .Width           = 75
219:             .Height          = 75
220:             .FontName        = "Comic Sans MS"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontSize        = 8
224:             .ForeColor       = RGB(90, 90, 90)
225:             .BackColor       = RGB(255, 255, 255)
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:             .Visible         = .T.
232:         ENDWITH
233: 
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 230
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Comic Sans MS"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
259:             .Caption         = "Buscar"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 305
264:             .Width           = 75
265:             .Height          = 75
266:             .FontName        = "Comic Sans MS"
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .FontSize        = 8
270:             .ForeColor       = RGB(90, 90, 90)
271:             .BackColor       = RGB(255, 255, 255)
272:             .Themes          = .F.

*-- Linhas 280 a 332:
280:         *-- Container saida - padrao canonico (prevalece sobre SCX legado)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle   = 0
288:             .BorderWidth = 0
289:             .Visible     = .T.
290:         ENDWITH
291: 
292:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
293:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
294:             .Caption         = "Encerrar"
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .PicturePosition = 13
297:             .Top             = 5
298:             .Left            = 5
299:             .Width           = 75
300:             .Height          = 75
301:             .FontName        = "Comic Sans MS"
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .FontSize        = 8
305:             .ForeColor       = RGB(90, 90, 90)
306:             .BackColor       = RGB(255, 255, 255)
307:             .Themes          = .F.
308:             .SpecialEffect   = 0
309:             .MousePointer    = 15
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:             .Visible         = .T.
313:         ENDWITH
314: 
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
316:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
317:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
318:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
319:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
320:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
321: 
322:         *-- Grid de lista
323:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
324:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
325:         WITH loc_oPagina.grd_4c_Lista
326:             .Top                = 117
327:             .Left               = 26
328:             .Width              = 890
329:             .Height             = 490
330:             .FontName           = "Verdana"
331:             .FontSize           = 8
332:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 358 a 480:
358:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
359: 
360:         *-- Container botoes de acao Salvar/Cancelar
361:         *-- Grupo_Salva.Top=24, Left=812 (SIGCDMTV) + 29 compensacao PageFrame
362:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
363:         WITH loc_oPagina.cnt_4c_BotoesAcao
364:             .Top         = 53
365:             .Left        = 812
366:             .Width       = 160
367:             .Height      = 85
368:             .BackStyle = 1
369:             .BackColor = RGB(255, 255, 255)
370:             .BorderWidth = 0
371:             .Visible     = .T.
372:         ENDWITH
373: 
374:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
375:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
376:             .Caption         = "Confirmar"
377:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
378:             .PicturePosition = 13
379:             .Top             = 5
380:             .Left            = 7
381:             .Width           = 75
382:             .Height          = 75
383:             .FontName        = "Comic Sans MS"
384:             .FontBold        = .T.
385:             .FontItalic      = .T.
386:             .FontSize        = 8
387:             .ForeColor       = RGB(90, 90, 90)
388:             .BackColor       = RGB(255, 255, 255)
389:             .Themes          = .F.
390:             .SpecialEffect   = 0
391:             .MousePointer    = 15
392:             .WordWrap        = .T.
393:             .AutoSize        = .F.
394:             .Visible         = .T.
395:         ENDWITH
396: 
397:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
398:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
399:             .Caption         = "Encerrar"
400:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
401:             .PicturePosition = 13
402:             .Top             = 5
403:             .Left            = 82
404:             .Width           = 75
405:             .Height          = 75
406:             .FontName        = "Comic Sans MS"
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .FontSize        = 8
410:             .ForeColor       = RGB(90, 90, 90)
411:             .BackColor       = RGB(255, 255, 255)
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .WordWrap        = .T.
416:             .AutoSize        = .F.
417:             .Visible         = .T.
418:         ENDWITH
419: 
420:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
421:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
422: 
423:         *-- Label e TextBox: Codigo
424:         *-- Say1.Top=141, Left=393 (SIGCDMTV) + 29 compensacao
425:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
426:         WITH loc_oPagina.lbl_4c_Label1
427:             .Caption   = "C" + CHR(243) + "digo :"
428:             .Top       = 170
429:             .Left      = 393
430:             .FontName  = "Tahoma"
431:             .FontSize  = 8
432:             .FontBold  = .F.
433:             .ForeColor = RGB(90, 90, 90)
434:             .BackStyle = 0
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         *-- getCods.Top=137, Left=443, Width=96, Height=24 + 29 compensacao
439:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
440:         WITH loc_oPagina.txt_4c_Codigo
441:             .Value         = ""
442:             .Top           = 166
443:             .Left          = 443
444:             .Width         = 96
445:             .Height        = 24
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .SpecialEffect = 1
449:             .BorderColor   = RGB(36, 84, 155)
450:             .Format        = "K!"
451:             .MaxLength     = 3
452:             .Visible       = .T.
453:         ENDWITH
454: 
455:         *-- Label e TextBox: Descricao
456:         *-- Say2.Top=167, Left=377 (SIGCDMTV) + 29 compensacao
457:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
458:         WITH loc_oPagina.lbl_4c_Label2
459:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
460:             .Top       = 196
461:             .Left      = 377
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .FontBold  = .F.
465:             .ForeColor = RGB(90, 90, 90)
466:             .BackStyle = 0
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         *-- getDescs.Top=163, Left=443, Width=179, Height=24 + 29 compensacao
471:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
472:         WITH loc_oPagina.txt_4c_Descricao
473:             .Value         = ""
474:             .Top           = 192
475:             .Left          = 443
476:             .Width         = 179
477:             .Height        = 24
478:             .FontName      = "Tahoma"
479:             .FontSize      = 8
480:             .SpecialEffect = 1

*-- Linhas 506 a 518:
506: 
507:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
508:                 loc_oGrid.Column1.Width           = 80
509:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
510: 
511:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
512:                 loc_oGrid.Column2.Width           = 150
513:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
514: 
515:                 THIS.FormatarGridLista(loc_oGrid)
516:                 loc_lResultado = .T.
517:             ENDIF
518:         CATCH TO loException

*-- Linhas 720 a 732:
720: 
721:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
722:                 loc_oGrid.Column1.Width           = 80
723:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
724: 
725:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
726:                 loc_oGrid.Column2.Width           = 150
727:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
728: 
729:                 THIS.FormatarGridLista(loc_oGrid)
730: 
731:                 IF RECCOUNT("cursor_4c_Dados") = 0
732:                     MsgAviso("Nenhum registro encontrado.", "Buscar")

*-- Linhas 829 a 837:
829:         loc_oPagina.txt_4c_Codigo.Enabled    = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
830:         loc_oPagina.txt_4c_Descricao.Enabled  = par_lHabilitar
831: 
832:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
833:             (par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR"))
834:     ENDPROC
835: 
836:     *--------------------------------------------------------------------------
837:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme o modo atual

*-- Linhas 844 a 860:
844:         loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
845: 
846:         *-- Botoes CRUD na Page1
847:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
848:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
849:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = (THIS.this_cModoAtual = "LISTA")
850:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = (THIS.this_cModoAtual = "LISTA")
851:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = (THIS.this_cModoAtual = "LISTA")
852: 
853:         *-- Botoes de acao na Page2: Confirmar desabilitado em VISUALIZAR
854:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEmEdicao
855:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
856:     ENDPROC
857: 
858:     *--------------------------------------------------------------------------
859:     * Destroy - Libera recursos do formulario
860:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\MTVBO.prg):
*==============================================================================
* MTVBO.prg - Business Object para Motivos
* Tabela: SigCdMtv
* Migrado de: SIGCDMTV.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS MTVBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""
    this_cDescricao = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMtv"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do cursor para o BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(Cods,  "C")
            THIS.this_cDescricao = TratarNulo(Descs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros no cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs" + ;
                       " FROM SigCdMtv" + ;
                       " ORDER BY Cods"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Cods, Descs" + ;
                           " FROM SigCdMtv" + ;
                           " WHERE Cods LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar motivos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (chave primaria)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs" + ;
                       " FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdMtv (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade de codigo (RETURN inside TRY proibido - usar flag)
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Check")
                TABLEREVERT(.T., "cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Check")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                SELECT cursor_4c_Check
                IF cursor_4c_Check.Total > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    loc_lDuplicado = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF

            IF !loc_lDuplicado
                loc_cSQL = "INSERT INTO SigCdMtv (Cods, Descs)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cCodigo) + ;
                           ", " + EscaparSQL(THIS.this_cDescricao) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_Check")
                USE IN cursor_4c_Check
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdMtv (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMtv SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdMtv (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMtv" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

