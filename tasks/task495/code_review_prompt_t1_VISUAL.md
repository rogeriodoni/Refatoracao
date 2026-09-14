# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 256: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 279: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 393: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 415: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPai.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (912 linhas total):

*-- Linhas 47 a 55:
47:         loc_lResultado = .F.
48: 
49:         TRY
50:             THIS.Caption = "Cadastro de Pa" + CHR(237) + "ses"
51: 
52:             THIS.this_oBusinessObject = CREATEOBJECT("PaiBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar PaiBO!" + CHR(13) + ;

*-- Linhas 62 a 74:
62:                 LOCAL loc_oCab
63:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
64:                 IF VARTYPE(loc_oCab) = "O"
65:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
66:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
67:                     ENDIF
68:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
69:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
70:                     ENDIF
71:                 ENDIF
72: 
73:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
74:                     THIS.CarregarLista()

*-- Linhas 96 a 111:
96:     PROTECTED PROCEDURE ConfigurarPageFrame()
97:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:         WITH THIS.pgf_4c_Paginas
99:             .Top       = -29
100:             .Left      = 0
101:             .Width     = THIS.Width
102:             .Height    = THIS.Height + 29
103:             .PageCount = 2
104:             .Tabs      = .F.
105:             .Page1.Caption  = "Lista"
106:             .Page2.Caption  = "Dados"
107:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:             .Visible   = .T.
110:         ENDWITH
111:     ENDPROC

*-- Linhas 120 a 158:
120:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
121:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122: 
123:         *-- Cabecalho escuro com titulo (cntSombra.Top=1 + compensacao PageFrame +29 = 30, canonico 31)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 31
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133: 
134:             .AddObject("lbl_4c_Sombra", "Label")
135:             WITH .lbl_4c_Sombra
136:                 .Caption   = THIS.Caption
137:                 .Top       = 15
138:                 .Left      = 10
139:                 .Width     = THIS.Width
140:                 .Height    = 40
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 16
143:                 .FontBold  = .T.
144:                 .ForeColor = RGB(0, 0, 0)
145:                 .BackStyle = 0
146:                 .Visible   = .T.
147:             ENDWITH
148: 
149:             .AddObject("lbl_4c_Titulo", "Label")
150:             WITH .lbl_4c_Titulo
151:                 .Caption   = THIS.Caption
152:                 .Top       = 18
153:                 .Left      = 10
154:                 .Width     = THIS.Width
155:                 .Height    = 46
156:                 .FontName  = "Tahoma"
157:                 .FontSize  = 16
158:                 .FontBold  = .T.

*-- Linhas 165 a 188:
165:         *-- Botoes CRUD (lado direito - canonico Left=542)
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 29
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackStyle   = 1
173:             .BackColor   = RGB(53, 53, 53)
174:             .BorderWidth = 0
175:             .Visible     = .T.
176: 
177:             .AddObject("cmd_4c_Incluir", "CommandButton")
178:             WITH .cmd_4c_Incluir
179:                 .Caption         = "Incluir"
180:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:                 .PicturePosition = 13
182:                 .Top             = 5
183:                 .Left            =  542
184:                 .Width           = 75
185:                 .Height          = 75
186:                 .BackColor       = RGB(255, 255, 255)
187:                 .ForeColor       = RGB(90, 90, 90)
188:                 .FontName        = "Tahoma"

*-- Linhas 196 a 285:
196:                 .Visible         = .T.
197:             ENDWITH
198: 
199:             .AddObject("cmd_4c_Visualizar", "CommandButton")
200:             WITH .cmd_4c_Visualizar
201:                 .Caption         = "Visualizar"
202:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:                 .PicturePosition = 13
204:                 .Top             = 5
205:                 .Left            =  542
206:                 .Width           = 75
207:                 .Height          = 75
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .FontName        = "Tahoma"
211:                 .FontSize        = 8
212:                 .FontBold        = .T.
213:                 .FontItalic      = .T.
214:                 .Themes          = .F.
215:                 .SpecialEffect   = 0
216:                 .MousePointer    = 15
217:                 .WordWrap        = .T.
218:                 .AutoSize        = .F.
219:                 .Visible         = .T.
220:             ENDWITH
221: 
222:             .AddObject("cmd_4c_Alterar", "CommandButton")
223:             WITH .cmd_4c_Alterar
224:                 .Caption         = "Alterar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            =  542
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Tahoma"
234:                 .FontSize        = 8
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .Themes          = .F.
238:                 .SpecialEffect   = 0
239:                 .MousePointer    = 15
240:                 .WordWrap        = .T.
241:                 .AutoSize        = .F.
242:                 .Visible         = .T.
243:             ENDWITH
244: 
245:             .AddObject("cmd_4c_Excluir", "CommandButton")
246:             WITH .cmd_4c_Excluir
247:                 .Caption         = "Excluir"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            =  542
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .BackColor       = RGB(255, 255, 255)
255:                 .ForeColor       = RGB(90, 90, 90)
256:                 .FontName        = "Comic Sans MS"
257:                 .FontSize        = 8
258:                 .FontBold        = .T.
259:                 .FontItalic      = .T.
260:                 .Themes          = .F.
261:                 .SpecialEffect   = 0
262:                 .MousePointer    = 15
263:                 .WordWrap        = .T.
264:                 .AutoSize        = .F.
265:                 .Visible         = .T.
266:             ENDWITH
267: 
268:             .AddObject("cmd_4c_Buscar", "CommandButton")
269:             WITH .cmd_4c_Buscar
270:                 .Caption         = "Buscar"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top             = 5
274:                 .Left            =  542
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .BackColor       = RGB(255, 255, 255)
278:                 .ForeColor       = RGB(90, 90, 90)
279:                 .FontName        = "Comic Sans MS"
280:                 .FontSize        = 8
281:                 .FontBold        = .T.
282:                 .FontItalic      = .T.
283:                 .Themes          = .F.
284:                 .SpecialEffect   = 0
285:                 .MousePointer    = 15

*-- Linhas 292 a 320:
292:         *-- Container Saida (canonico: Left=917, Width=90 - PREVALECE sobre SCX legado)
293:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
294:         WITH loc_oPagina.cnt_4c_Saida
295:             .Top         = 29
296:             .Left        = 917
297:             .Width       = 90
298:             .Height      = 85
299:             .BackStyle   = 0
300:             .BorderWidth = 0
301:             .Visible     = .T.
302: 
303:             .AddObject("cmd_4c_Encerrar", "CommandButton")
304:             WITH .cmd_4c_Encerrar
305:                 .Caption         = "Encerrar"
306:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:                 .PicturePosition = 13
308:                 .Top             = 5
309:                 .Left            = 917
310:                 .Width           = 90
311:                 .Height          = 75
312:                 .BackColor       = RGB(255, 255, 255)
313:                 .ForeColor       = RGB(90, 90, 90)
314:                 .FontName        = "Comic Sans MS"
315:                 .FontSize        = 8
316:                 .FontBold        = .T.
317:                 .FontItalic      = .T.
318:                 .SpecialEffect   = 0
319:                 .MousePointer    = 15
320:                 .WordWrap        = .T.

*-- Linhas 326 a 335:
326:         *-- Grid de listagem (Codigos=50px, Descs=290px - do original)
327:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
328:         loc_oGrid = loc_oPagina.grd_4c_Lista
329:         loc_oGrid.Top         = 117
330:         loc_oGrid.Left        = 26
331:         loc_oGrid.Width       = 880
332:         loc_oGrid.Height      = 460
333:         loc_oGrid.ColumnCount = 2
334:         loc_oGrid.RecordSource = ""
335:         WITH loc_oGrid

*-- Linhas 349 a 362:
349:         ENDWITH
350: 
351:         *-- BINDEVENTs dos botoes (PUBLIC - sem PROTECTED para funcionar)
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
354:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
355:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
358: 
359:         THIS.TornarControlesVisiveis(loc_oPagina)
360:     ENDPROC
361: 
362:     *==========================================================================

*-- Linhas 371 a 438:
371: 
372:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
373:         WITH loc_oPagina.cnt_4c_BotoesAcao
374:             .Top         = 33
375:             .Left        = 842
376:             .Width       = 160
377:             .Height      = 85
378:             .BackStyle   = 0
379:             .BorderWidth = 0
380:             .Visible     = .T.
381: 
382:             .AddObject("cmd_4c_Confirmar", "CommandButton")
383:             WITH .cmd_4c_Confirmar
384:                 .Caption         = "Confirmar"
385:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
386:                 .PicturePosition = 13
387:                 .Top             = 5
388:                 .Left            = 5
389:                 .Width           = 75
390:                 .Height          = 75
391:                 .BackColor       = RGB(255, 255, 255)
392:                 .ForeColor       = RGB(90, 90, 90)
393:                 .FontName        = "Comic Sans MS"
394:                 .FontSize        = 8
395:                 .FontBold        = .T.
396:                 .FontItalic      = .T.
397:                 .SpecialEffect   = 0
398:                 .MousePointer    = 15
399:                 .WordWrap        = .T.
400:                 .AutoSize        = .F.
401:                 .Visible         = .T.
402:             ENDWITH
403: 
404:             .AddObject("cmd_4c_Cancelar", "CommandButton")
405:             WITH .cmd_4c_Cancelar
406:                 .Caption         = "Encerrar"
407:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
408:                 .PicturePosition = 13
409:                 .Top             = 5
410:                 .Left            = 80
411:                 .Width           = 75
412:                 .Height          = 75
413:                 .BackColor       = RGB(255, 255, 255)
414:                 .ForeColor       = RGB(90, 90, 90)
415:                 .FontName        = "Comic Sans MS"
416:                 .FontSize        = 8
417:                 .FontBold        = .T.
418:                 .FontItalic      = .T.
419:                 .Themes          = .F.
420:                 .SpecialEffect   = 0
421:                 .MousePointer    = 15
422:                 .WordWrap        = .T.
423:                 .AutoSize        = .F.
424:                 .Visible         = .T.
425:             ENDWITH
426:         ENDWITH
427: 
428:         *-- Label: Codigo (Label2 original - Top=148+29=177, Left=325)
429:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
430:         WITH loc_oPagina.lbl_4c_Codigo
431:             .Caption   = "C" + CHR(243) + "digo :"
432:             .Top       = 177
433:             .Left      = 325
434:             .Width     = 42
435:             .Height    = 15
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .FontBold  = .F.

*-- Linhas 446 a 471:
446:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
447:         WITH loc_oPagina.txt_4c_Codigos
448:             .Value         = ""
449:             .Top           = 174
450:             .Left          = 371
451:             .Width         = 45
452:             .Height        = 23
453:             .FontName      = "Tahoma"
454:             .FontSize      = 8
455:             .MaxLength     = 5
456:             .SpecialEffect = 1
457:             .ForeColor     = RGB(0, 0, 0)
458:             .Visible       = .T.
459:         ENDWITH
460: 
461:         *-- Label: Descricao (Label1 original - Top=175+29=204, Left=312)
462:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
463:         WITH loc_oPagina.lbl_4c_Descricao
464:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
465:             .Top       = 204
466:             .Left      = 312
467:             .Width     = 55
468:             .Height    = 15
469:             .FontName  = "Tahoma"
470:             .FontSize  = 8
471:             .FontBold  = .F.

*-- Linhas 479 a 501:
479:         loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
480:         WITH loc_oPagina.txt_4c_Descs
481:             .Value         = ""
482:             .Top           = 201
483:             .Left          = 371
484:             .Width         = 290
485:             .Height        = 23
486:             .FontName      = "Tahoma"
487:             .FontSize      = 8
488:             .MaxLength     = 40
489:             .SpecialEffect = 1
490:             .ForeColor     = RGB(0, 0, 0)
491:             .Visible       = .T.
492:         ENDWITH
493: 
494:         *-- BINDEVENTs dos botoes da Page2 (PUBLIC - sem PROTECTED para funcionar)
495:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
496:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
497: 
498:         THIS.TornarControlesVisiveis(loc_oPagina)
499:     ENDPROC
500: 
501:     *==========================================================================

*-- Linhas 523 a 532:
523:                     loc_oGrid.Column2.Width = 300
524: 
525:                     *-- Reconfigurar cabecalhos APOS RecordSource (VFP9 reseta os headers)
526:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
527:                     loc_oGrid.Column2.Header1.Caption = "Pa" + CHR(237) + "s"
528: 
529:                     THIS.FormatarGridLista(loc_oGrid)
530:                     loc_lResultado = .T.
531:                 ENDIF
532:             ENDIF

*-- Linhas 670 a 679:
670:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
671:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
672: 
673:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
674:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
675:     ENDPROC
676: 
677:     *==========================================================================
678:     * BtnIncluirClick - Prepara form para novo registro
679:     *==========================================================================


### BO (C:\4c\projeto\app\classes\PaiBO.prg):
*==============================================================================
* PaiBO.prg - Business Object para Cadastro de Paises
* Tabela: SigCdPai
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS PaiBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas para SigCdPai)
    this_cCodigos   = ""    && Codigos   C(5)  - Chave primaria
    this_cDescs     = ""    && Descs     C(40) - Nome do Pais
    this_cIdChaves  = ""    && cIdChaves C(?)  - Chave unica interna (fUniqueIds)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPai"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Codigos, Descs, cIdChaves" + ;
                    " FROM SigCdPai" + ;
                    " ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descs, cIdChaves" + ;
                    " FROM SigCdPai" + ;
                    " WHERE " + par_cFiltro + ;
                    " ORDER BY Codigos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Pa" + CHR(237) + "ses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar Pa" + CHR(237) + "ses:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo da PK
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Codigos, Descs, cIdChaves" + ;
                " FROM SigCdPai" + ;
                " WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar Pa" + CHR(237) + "s:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * REGRA: SELECT (alias) ANTES de acessar campos (sem prefixo de alias)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(Codigos,   "C")
            THIS.this_cDescs    = TratarNulo(Descs,     "C")
            THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios e duplicidade antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo do Pa" + CHR(237) + "s!!!", "")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Nome do Pa" + CHR(237) + "s!!!", "")
            RETURN .F.
        ENDIF

        IF THIS.this_lNovoRegistro AND THIS.VerificarDuplicidade()
            MsgAviso("Pa" + CHR(237) + "s j" + CHR(225) + " cadastrado!!!", "")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se o codigo ja existe no banco (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdPai" + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Chk") > 0
                SELECT cursor_4c_Chk
                loc_lExiste = (cursor_4c_Chk.Total > 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Chk")
            USE IN cursor_4c_Chk
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdChaves - Gera identificador unico para o campo cIdChaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdChaves()
        RETURN ALLTRIM(SYS(2015)) + ALLTRIM(SYS(2015))
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdPai (PROTECTED - chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = THIS.GerarIdChaves()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdPai (Codigos, Descs, cIdChaves) VALUES (" + ;
                EscaparSQL(THIS.this_cCodigos)  + ", " + ;
                EscaparSQL(THIS.this_cDescs)    + ", " + ;
                EscaparSQL(THIS.this_cIdChaves) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Pa" + CHR(237) + "s:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir Pa" + CHR(237) + "s:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdPai (PROTECTED - chamado por BusinessBase.Salvar)
    * Codigo (PK) nao e alterado; cIdChaves e imutavel
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPai SET" + ;
                " Descs = " + EscaparSQL(THIS.this_cDescs) + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Pa" + CHR(237) + "s:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar Pa" + CHR(237) + "s:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigCdPai (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPai" + ;
                " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir Pa" + CHR(237) + "s:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir Pa" + CHR(237) + "s:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

