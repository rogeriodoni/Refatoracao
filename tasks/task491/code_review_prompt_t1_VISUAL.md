# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 413: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formorl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (869 linhas total):

*-- Linhas 83 a 100:
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85:         WITH THIS.pgf_4c_Paginas
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .PageCount = 2
91:             .Tabs      = .F.
92:             .Visible   = .T.
93:             .Page1.Caption = "Lista"
94:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page2.Caption = "Dados"
96:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:         ENDWITH
98:     ENDPROC
99: 
100:     *==========================================================================

*-- Linhas 110 a 145:
110:         *-- Container cabecalho (cntSombra no legado)
111:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
112:         WITH loc_oPagina.cnt_4c_Cabecalho
113:             .Top         = 2
114:             .Left        = 0
115:             .Width       = THIS.Width
116:             .Height      = 80
117:             .BackColor   = RGB(100, 100, 100)
118:             .BorderWidth = 0
119:             .Visible     = .T.
120: 
121:             .AddObject("lbl_4c_Sombra", "Label")
122:             WITH .lbl_4c_Sombra
123:                 .Caption   = THIS.Caption
124:                 .Top       = 15
125:                 .Left      = 12
126:                 .Width     = THIS.Width
127:                 .Height    = 40
128:                 .FontName  = "Tahoma"
129:                 .FontSize  = 16
130:                 .FontBold  = .T.
131:                 .ForeColor = RGB(0, 0, 0)
132:                 .BackStyle = 0
133:                 .Visible   = .T.
134:             ENDWITH
135: 
136:             .AddObject("lbl_4c_Titulo", "Label")
137:             WITH .lbl_4c_Titulo
138:                 .Caption   = THIS.Caption
139:                 .Top       = 18
140:                 .Left      = 10
141:                 .Width     = THIS.Width
142:                 .Height    = 46
143:                 .FontName  = "Tahoma"
144:                 .FontSize  = 16
145:                 .FontBold  = .T.

*-- Linhas 152 a 270:
152:         *-- Container botoes CRUD (Grupo_Op no legado) - lado direito
153:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
154:         WITH loc_oPagina.cnt_4c_Botoes
155:             .Top         = 0
156:             .Left        = 542
157:             .Width       = 390
158:             .Height      = 85
159:             .BackColor   = RGB(53, 53, 53)
160:             .BackStyle   = 1
161:             .BorderWidth = 0
162:             .Visible     = .T.
163: 
164:             .AddObject("cmd_4c_Incluir", "CommandButton")
165:             WITH .cmd_4c_Incluir
166:                 .Caption         = "Incluir"
167:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
168:                 .PicturePosition = 13
169:                 .Top             = 5
170:                 .Left            =  542
171:                 .Width           = 75
172:                 .Height          = 75
173:                 .FontName        = "Comic Sans MS"
174:                 .FontSize        = 8
175:                 .FontBold        = .T.
176:                 .FontItalic      = .T.
177:                 .ForeColor       = RGB(90, 90, 90)
178:                 .BackColor       = RGB(255, 255, 255)
179:                 .SpecialEffect   = 0
180:                 .MousePointer    = 15
181:                 .WordWrap        = .T.
182:                 .AutoSize        = .F.
183:                 .Visible         = .T.
184:             ENDWITH
185: 
186:             .AddObject("cmd_4c_Visualizar", "CommandButton")
187:             WITH .cmd_4c_Visualizar
188:                 .Caption         = "Visualizar"
189:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
190:                 .PicturePosition = 13
191:                 .Top             = 5
192:                 .Left            =  542
193:                 .Width           = 75
194:                 .Height          = 75
195:                 .FontName        = "Comic Sans MS"
196:                 .FontSize        = 8
197:                 .FontBold        = .T.
198:                 .FontItalic      = .T.
199:                 .ForeColor       = RGB(90, 90, 90)
200:                 .BackColor       = RGB(255, 255, 255)
201:                 .Themes          = .F.
202:                 .SpecialEffect   = 0
203:                 .MousePointer    = 15
204:                 .WordWrap        = .T.
205:                 .AutoSize        = .F.
206:                 .Visible         = .T.
207:             ENDWITH
208: 
209:             .AddObject("cmd_4c_Alterar", "CommandButton")
210:             WITH .cmd_4c_Alterar
211:                 .Caption         = "Alterar"
212:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
213:                 .PicturePosition = 13
214:                 .Top             = 5
215:                 .Left            =  542
216:                 .Width           = 75
217:                 .Height          = 75
218:                 .FontName        = "Comic Sans MS"
219:                 .FontSize        = 8
220:                 .FontBold        = .T.
221:                 .FontItalic      = .T.
222:                 .ForeColor       = RGB(90, 90, 90)
223:                 .BackColor       = RGB(255, 255, 255)
224:                 .Themes          = .F.
225:                 .SpecialEffect   = 0
226:                 .MousePointer    = 15
227:                 .WordWrap        = .T.
228:                 .AutoSize        = .F.
229:                 .Visible         = .T.
230:             ENDWITH
231: 
232:             .AddObject("cmd_4c_Excluir", "CommandButton")
233:             WITH .cmd_4c_Excluir
234:                 .Caption         = "Excluir"
235:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
236:                 .PicturePosition = 13
237:                 .Top             = 5
238:                 .Left            =  542
239:                 .Width           = 75
240:                 .Height          = 75
241:                 .FontName        = "Comic Sans MS"
242:                 .FontSize        = 8
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .ForeColor       = RGB(90, 90, 90)
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .Themes          = .F.
248:                 .SpecialEffect   = 0
249:                 .MousePointer    = 15
250:                 .WordWrap        = .T.
251:                 .AutoSize        = .F.
252:                 .Visible         = .T.
253:             ENDWITH
254: 
255:             .AddObject("cmd_4c_Buscar", "CommandButton")
256:             WITH .cmd_4c_Buscar
257:                 .Caption         = "Buscar"
258:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:                 .PicturePosition = 13
260:                 .Top             = 5
261:                 .Left            =  542
262:                 .Width           = 75
263:                 .Height          = 75
264:                 .FontName        = "Comic Sans MS"
265:                 .FontSize        = 8
266:                 .FontBold        = .T.
267:                 .FontItalic      = .T.
268:                 .ForeColor       = RGB(90, 90, 90)
269:                 .BackColor       = RGB(255, 255, 255)
270:                 .Themes          = .F.

*-- Linhas 279 a 305:
279:         *-- Container saida - padrao canonico (Left=917, Width=90)
280:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
281:         WITH loc_oPagina.cnt_4c_Saida
282:             .Top         = 29
283:             .Left        = 917
284:             .Width       = 90
285:             .Height      = 85
286:             .BackStyle   = 0
287:             .BorderWidth = 0
288:             .Visible     = .T.
289: 
290:             .AddObject("cmd_4c_Encerrar", "CommandButton")
291:             WITH .cmd_4c_Encerrar
292:                 .Caption         = "Encerrar"
293:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
294:                 .PicturePosition = 13
295:                 .Top             = 5
296:                 .Left            = 917
297:                 .Width           = 75
298:                 .Height          = 75
299:                 .FontName        = "Comic Sans MS"
300:                 .FontSize        = 8
301:                 .FontBold        = .T.
302:                 .FontItalic      = .T.
303:                 .ForeColor       = RGB(90, 90, 90)
304:                 .BackColor       = RGB(255, 255, 255)
305:                 .SpecialEffect   = 0

*-- Linhas 316 a 325:
316:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
317: 
318:         WITH loc_oPagina.grd_4c_Lista
319:             .Top                = 117
320:             .Left               = 12
321:             .Width              = 900
322:             .Height             = 490
323:             .FontName           = "Verdana"
324:             .FontSize           = 8
325:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 338 a 362:
338:             WITH .Column1
339:                 .Width              = 90
340:                 .Alignment          = 0
341:                 .Header1.Caption    = "C" + CHR(243) + "digo"
342:             ENDWITH
343: 
344:             WITH .Column2
345:                 .Width              = 337
346:                 .Alignment          = 0
347:                 .Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
348:             ENDWITH
349:         ENDWITH
350: 
351:         *-- BINDEVENT para botoes CRUD (metodos devem ser PUBLIC)
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

*-- Linhas 372 a 419:
372:         *-- Container botoes de acao (Grupo_Salva no legado)
373:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
374:         WITH loc_oPagina.cnt_4c_BotoesAcao
375:             .Top         = 33
376:             .Left        = 842
377:             .Width       = 160
378:             .Height      = 85
379:             .BackStyle   = 0
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
391:                 .FontName        = "Comic Sans MS"
392:                 .FontSize        = 8
393:                 .FontBold        = .T.
394:                 .FontItalic      = .T.
395:                 .ForeColor       = RGB(90, 90, 90)
396:                 .BackColor       = RGB(255, 255, 255)
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
413:                 .FontName        = "Comic Sans MS"
414:                 .FontSize        = 8
415:                 .FontBold        = .T.
416:                 .FontItalic      = .T.
417:                 .ForeColor       = RGB(90, 90, 90)
418:                 .BackColor       = RGB(255, 255, 255)
419:                 .Themes          = .F.

*-- Linhas 426 a 438:
426:         ENDWITH
427: 
428:         *-- Label Codigo (Say1 no legado: top=124, left=215 -> +29 compensacao = 153)
429:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
430:         WITH loc_oPagina.lbl_4c_Codigo
431:             .Caption   = "C" + CHR(243) + "digo :"
432:             .Top       = 153
433:             .Left      = 215
434:             .Width     = 48
435:             .Height    = 17
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .FontBold  = .F.

*-- Linhas 446 a 469:
446:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
447:         WITH loc_oPagina.txt_4c_Codigo
448:             .Value     = ""
449:             .Top       = 150
450:             .Left      = 263
451:             .Width     = 72
452:             .Height    = 23
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .MaxLength = 5
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- Label Descricao (Say2 no legado: top=149, left=202 -> +29 = 178)
460:         loc_oPagina.AddObject("lbl_4c_Desc", "Label")
461:         WITH loc_oPagina.lbl_4c_Desc
462:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
463:             .Top       = 178
464:             .Left      = 202
465:             .Width     = 61
466:             .Height    = 17
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .FontBold  = .F.

*-- Linhas 477 a 497:
477:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
478:         WITH loc_oPagina.txt_4c_Desc
479:             .Value     = ""
480:             .Top       = 175
481:             .Left      = 263
482:             .Width     = 240
483:             .Height    = 23
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .MaxLength = 50
487:             .Visible   = .T.
488:         ENDWITH
489: 
490:         *-- BINDEVENT para botoes de Page2
491:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
492:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
493: 
494:         THIS.TornarControlesVisiveis(loc_oPagina)
495:     ENDPROC
496: 
497:     *==========================================================================

*-- Linhas 513 a 522:
513:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
514:                     loc_oGrid.Column1.Width = 90
515:                     loc_oGrid.Column2.Width = 337
516:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
517:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
518:                     THIS.FormatarGridLista(loc_oGrid)
519:                     loc_lResultado = .T.
520:                 ENDIF
521:             ENDIF
522:         CATCH TO loException

*-- Linhas 685 a 694:
685:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
686:                     loc_oGrid.Column1.Width = 90
687:                     loc_oGrid.Column2.Width = 337
688:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
689:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
690:                     THIS.FormatarGridLista(loc_oGrid)
691:                     loc_lResultado = .T.
692:                 ELSE
693:                     MsgAviso("Nenhum registro encontrado para o filtro informado.", "Buscar")
694:                 ENDIF

*-- Linhas 816 a 828:
816:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
817:         loc_lModoVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")
818: 
819:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
820:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lModoVisualizar
821:         ENDIF
822:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
823:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
824:         ENDIF
825:     ENDPROC
826: 
827:     *==========================================================================
828:     * TornarControlesVisiveis - Torna controles visiveis recursivamente


### BO (C:\4c\projeto\app\classes\orlBO.prg):
*====================================================================
* orlBO.prg
*
* Business Object para Cadastro de Origem
* Tabela: sigcdorl
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS orlBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigcdorl)
    this_cCodigo    = ""    && cods char(10) - codigo de origem (chave de negocio)
    this_cCodChaves = ""    && cidchaves char(20) - PK tecnica gerada por fUniqueIds()
    this_cDescricao = ""    && descs char(40)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigcdorl"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "orlBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cCodChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "orlBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - SELECT de registros (suporta filtro parcial por cods/descs)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MostrarErro("Erro ao buscar origens:" + CHR(13) + CapturarErroSQL(), "orlBO.Buscar")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "orlBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cods, cidchaves, descs" + ;
                       " FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MostrarErro("Erro ao carregar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.CarregarPorCodigo")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "orlBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarCodigoDuplicado - Verifica se cods ja existe (apenas no INSERT)
    *====================================================================
    FUNCTION VerificarCodigoDuplicado()
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Chk") > 0
                SELECT cursor_4c_Chk
                loc_lDuplicado = (cursor_4c_Chk.qtd > 0)
            ENDIF

            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "orlBO.VerificarCodigoDuplicado")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT de um novo registro em sigcdorl
    * Gera cidchaves via fUniqueIds()
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarCodigoDuplicado()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lSucesso = .F.
            ELSE
                THIS.this_cCodChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO sigcdorl" + ;
                           " (cods, cidchaves, descs)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MostrarErro("Erro ao inserir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "orlBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE do registro em sigcdorl (identifica por cods)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdorl SET" + ;
                       " descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao atualizar origem:" + CHR(13) + CapturarErroSQL(), "orlBO.Atualizar")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "orlBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do registro em sigcdorl
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcdorl" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MostrarErro("Erro ao excluir origem:" + CHR(13) + CapturarErroSQL(), "orlBO.ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "orlBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Destroy - Libera cursores
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Chk")
            USE IN cursor_4c_Chk
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

