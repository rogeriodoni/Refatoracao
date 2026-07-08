# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 226: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDIR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1167 linhas total):

*-- Linhas 57 a 78:
57:         loc_lSucesso = .F.
58: 
59:         TRY
60:             THIS.Caption = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos - CSLL, COFINS e PIS/PASEP"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
66: 
67:             *-- Estrutura visual (independe de SQL - construida sempre)
68:             THIS.ConfigurarCabecalho()
69:             THIS.ConfigurarBotoes()
70:             THIS.ConfigurarPageFrame()
71: 
72:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:             *-- Instanciar BO apenas quando ha conexao real (pula em validacao UI)
76:             *   SIGREDIRBO.Init() executa SQLEXEC para carregar empresas;
77:             *   em modo gb_4c_ValidandoUI (gnConnHandle=-1) isso falharia.
78:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 109 a 188:
109:     PROTECTED PROCEDURE ConfigurarCabecalho()
110:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH THIS.cnt_4c_Cabecalho
112:             .Top         = 0
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackStyle   = 1
117:             .BackColor   = RGB(100, 100, 100)
118:             .BorderWidth = 0
119:             .Visible     = .T.
120: 
121:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
122:             .AddObject("lbl_4c_Sombra", "Label")
123:             WITH .lbl_4c_Sombra
124:                 .Top       = 22
125:                 .Left      = 22
126:                 .Width     = THIS.Width
127:                 .Height    = 30
128:                 .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 14
131:                 .FontBold  = .T.
132:                 .ForeColor = RGB(0, 0, 0)
133:                 .BackStyle = 0
134:                 .Visible   = .T.
135:             ENDWITH
136: 
137:             *-- Titulo em branco sobre a sombra
138:             .AddObject("lbl_4c_Titulo", "Label")
139:             WITH .lbl_4c_Titulo
140:                 .Top       = 20
141:                 .Left      = 20
142:                 .Width     = THIS.Width
143:                 .Height    = 30
144:                 .Caption   = "Demonstrativo de Reten" + CHR(231) + CHR(227) + "o de Impostos"
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 14
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(255, 255, 255)
149:                 .BackStyle = 0
150:                 .Visible   = .T.
151:             ENDWITH
152:         ENDWITH
153:     ENDPROC
154: 
155:     *--------------------------------------------------------------------------
156:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
157:     *   Original: btnReport.Left=527, Top=3
158:     *   Geometria exata do framework frmrelatorio:
159:     *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
160:     *     Buttons: Top=5, Width=65, Height=70, Lefts=5/71/137/203
161:     *--------------------------------------------------------------------------
162:     PROTECTED PROCEDURE ConfigurarBotoes()
163:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
164:         WITH THIS.cmg_4c_Botoes
165:             .Top           = 0
166:             .Left          = 529
167:             .Width         = 273
168:             .Height        = 80
169:             .ButtonCount   = 4
170:             .BackStyle     = 0
171:             .BorderStyle   = 0
172:             .BorderColor   = RGB(136, 189, 188)
173:             .SpecialEffect = 1
174:             .Themes        = .F.
175:             .Visible       = .T.
176: 
177:             *-- Buttons(1): Visualizar (preview em tela)
178:             WITH .Buttons(1)
179:                 .Top             = 5
180:                 .Left            = 5
181:                 .Width           = 65
182:                 .Height          = 70
183:                 .Caption         = "Visualizar"
184:                 .FontBold        = .T.
185:                 .FontItalic      = .T.
186:                 .BackColor       = RGB(255, 255, 255)
187:                 .ForeColor       = RGB(90, 90, 90)
188:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 196 a 210:
196: 
197:             *-- Buttons(2): Imprimir (com dialogo de impressora)
198:             WITH .Buttons(2)
199:                 .Top             = 5
200:                 .Left            = 71
201:                 .Width           = 65
202:                 .Height          = 70
203:                 .Caption         = "Imprimir"
204:                 .FontName        = "Comic Sans MS"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .FontSize        = 8
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 218 a 232:
218: 
219:             *-- Buttons(3): Excel (exportar dados do cursor)
220:             WITH .Buttons(3)
221:                 .Top             = 5
222:                 .Left            = 137
223:                 .Width           = 65
224:                 .Height          = 70
225:                 .Caption         = "Excel"
226:                 .FontName        = "Comic Sans MS"
227:                 .FontBold        = .T.
228:                 .FontItalic      = .T.
229:                 .FontSize        = 8
230:                 .BackColor       = RGB(255, 255, 255)
231:                 .ForeColor       = RGB(90, 90, 90)
232:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 240 a 255:
240: 
241:             *-- Buttons(4): Encerrar (ESC fecha o form - Cancel=.T.)
242:             WITH .Buttons(4)
243:                 .Top             = 5
244:                 .Left            = 203
245:                 .Width           = 65
246:                 .Height          = 70
247:                 .Caption         = "Encerrar"
248:                 .Cancel          = .T.
249:                 .FontName        = "Comic Sans MS"
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .FontSize        = 8
253:                 .BackColor       = RGB(255, 255, 255)
254:                 .ForeColor       = RGB(90, 90, 90)
255:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 278 a 292:
278:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
279:         loc_oPgf.PageCount = 1
280: 
281:         loc_oPgf.Top    = 85
282:         loc_oPgf.Left   = -1
283:         loc_oPgf.Width  = THIS.Width + 2
284:         loc_oPgf.Height = THIS.Height - 85
285:         loc_oPgf.Tabs   = .F.
286: 
287:         loc_oPgf.Page1.Caption   = "Filtros"
288:         loc_oPgf.Page1.FontName  = "Tahoma"
289:         loc_oPgf.Page1.FontSize  = 8
290:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
291:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
292:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 298 a 412:
298:     *--------------------------------------------------------------------------
299:     * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 e conecta eventos
300:     *   Em forms REPORT, "Pagina Lista" eh a unica pagina (filtros + grid de empresas)
301:     *   Posicoes relativas a Page1 (top original - pgf.Top=85)
302:     *   Chamado APOS SIGREDIRBO ser instanciado (grid usa cursor de empresas)
303:     *--------------------------------------------------------------------------
304:     PROTECTED PROCEDURE ConfigurarPaginaLista()
305:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
306: 
307:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
308: 
309:         *-- Label "Ano Base :"  (original: Say2.Top=109, Left=181 -> Page1: 24, 181)
310:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
311:         WITH loc_oPagina.lbl_4c_Label2
312:             .Top       = 24
313:             .Left      = 181
314:             .Width     = 54
315:             .Height    = 18
316:             .Caption   = "Ano Base :"
317:             .FontName  = "Tahoma"
318:             .FontSize  = 8
319:             .ForeColor = RGB(90, 90, 90)
320:             .BackStyle = 0
321:             .Visible   = .T.
322:         ENDWITH
323: 
324:         *-- TextBox Ano Base (original: getAnoBase.Top=106, Left=242 -> Page1: 21, 242)
325:         loc_oPagina.AddObject("txt_4c_AnoBase", "TextBox")
326:         WITH loc_oPagina.txt_4c_AnoBase
327:             .Top       = 21
328:             .Left      = 242
329:             .Width     = 38
330:             .Height    = 23
331:             .FontName  = "Tahoma"
332:             .FontSize  = 8
333:             .Value     = ""
334:             .InputMask = "9999"
335:             .MaxLength = 4
336:             .Visible   = .T.
337:         ENDWITH
338: 
339:         *-- Label "Fornecedor :"  (original: Say4.Top=147, Left=171 -> Page1: 62, 171)
340:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
341:         WITH loc_oPagina.lbl_4c_Label4
342:             .Top       = 62
343:             .Left      = 171
344:             .Width     = 64
345:             .Height    = 18
346:             .Caption   = "Fornecedor :"
347:             .FontName  = "Tahoma"
348:             .FontSize  = 8
349:             .ForeColor = RGB(90, 90, 90)
350:             .BackStyle = 0
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- TextBox codigo do fornecedor (original: Get_Fornec.Top=144, Left=242 -> Page1: 59, 242)
355:         loc_oPagina.AddObject("txt_4c_Fornec", "TextBox")
356:         WITH loc_oPagina.txt_4c_Fornec
357:             .Top         = 59
358:             .Left        = 242
359:             .Width       = 81
360:             .Height      = 23
361:             .FontName    = "Tahoma"
362:             .FontSize    = 8
363:             .Value       = ""
364:             .MaxLength   = 10
365:             .ToolTipText = "[F4] Buscar fornecedor por c" + CHR(243) + "digo"
366:             .Visible     = .T.
367:         ENDWITH
368: 
369:         *-- TextBox razao social do fornecedor (original: Get_Dforn.Top=144, Left=324 -> Page1: 59, 324)
370:         *   ReadOnly .F. quando Fornec vazio (usuario pode buscar por nome)
371:         *   ReadOnly .T. quando Fornec preenchido (exibe descricao somente)
372:         loc_oPagina.AddObject("txt_4c_Dforn", "TextBox")
373:         WITH loc_oPagina.txt_4c_Dforn
374:             .Top         = 59
375:             .Left        = 324
376:             .Width       = 306
377:             .Height      = 23
378:             .FontName    = "Tahoma"
379:             .FontSize    = 8
380:             .Value       = ""
381:             .ReadOnly    = .F.
382:             .ToolTipText = "[F4] Buscar fornecedor por nome (somente quando c" + CHR(243) + "digo vazio)"
383:             .Visible     = .T.
384:         ENDWITH
385: 
386:         *-- Label "Empresas :"  (original: Say1.Top=180, Left=172 -> Page1: 95, 172)
387:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
388:         WITH loc_oPagina.lbl_4c_Label1
389:             .Top       = 95
390:             .Left      = 172
391:             .Width     = 63
392:             .Height    = 18
393:             .Caption   = "Empresas :"
394:             .FontName  = "Tahoma"
395:             .FontSize  = 8
396:             .ForeColor = RGB(90, 90, 90)
397:             .BackStyle = 0
398:             .Visible   = .T.
399:         ENDWITH
400: 
401:         *-- Grid de selecao de empresas (original: grdEmps.Top=179, Left=238 -> Page1: 94, 238)
402:         *   3 colunas: CheckBox(Imps), Emp.(cemps), Descricao(razas)
403:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
404:         loc_oGrid = loc_oPagina.grd_4c_Dados
405:         WITH loc_oGrid
406:             .Top                = 94
407:             .Left               = 238
408:             .Width              = 291
409:             .Height             = 139
410:             .ColumnCount        = 3
411:             .DeleteMark         = .F.
412:             .RecordMark         = .F.

*-- Linhas 421 a 445:
421:             .RowHeight          = 16
422:             .ScrollBars         = 2
423: 
424:             *-- Column1: CheckBox para selecao (Imps)
425:             *   ORDEM OBRIGATORIA: AddObject -> Caption -> CurrentControl -> ControlSource
426:             .Column1.Width = 25
427:             .Column1.Header1.Caption = ""
428:             .Column1.AddObject("Check1", "CheckBox")
429:             .Column1.Check1.Caption = ""
430:             .Column1.Check1.Value = 1
431:             .Column1.CurrentControl = "Check1"
432: 
433:             *-- Column2: Codigo da empresa
434:             .Column2.Width    = 55
435:             .Column2.Header1.Caption = "Emp."
436:             .Column2.ReadOnly = .T.
437: 
438:             *-- Column3: Razao Social
439:             .Column3.Width    = 211
440:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
441:             .Column3.ReadOnly = .T.
442: 
443:             .Visible = .T.
444:         ENDWITH
445: 

*-- Linhas 452 a 510:
452:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".razas"
453:         ENDIF
454: 
455:         *-- Checkbox "marcar/desmarcar todas" posicionado sobre o header do Column1
456:         *   (original: ck_MarcaEmp.Top=180, Left=240 -> Page1: 95, 240)
457:         *   ZOrder(0) garante que fica sobre o grid (adicionado apos o grid)
458:         loc_oPagina.AddObject("chk_4c_MarcaEmp", "CheckBox")
459:         WITH loc_oPagina.chk_4c_MarcaEmp
460:             .Top         = 95
461:             .Left        = 240
462:             .Width       = 22
463:             .Height      = 16
464:             .Caption     = ""
465:             .Value       = 1
466:             .ToolTipText = "Marcar/Desmarcar todas as empresas"
467:             .Visible     = .T.
468:         ENDWITH
469:         loc_oPagina.chk_4c_MarcaEmp.ZOrder(0)
470: 
471:         *-- CommandGroup Marcar/Desmarcar todas as empresas
472:         *   (original: cmdEmps.Top=204, Left=532 -> Page1: 119, 532)
473:         *   Dimensoes EXATAS do original: Width=50, Height=91 (vertical, icones sem caption)
474:         loc_oPagina.AddObject("obj_4c_CmdEmps", "CommandGroup")
475:         WITH loc_oPagina.obj_4c_CmdEmps
476:             .Top         = 119
477:             .Left        = 532
478:             .Width       = 50
479:             .Height      = 91
480:             .ButtonCount = 2
481:             .BackStyle   = 0
482:             .BorderStyle = 0
483:             .Themes      = .F.
484:             .Visible     = .T.
485: 
486:             WITH .Buttons(1)
487:                 .Top             = 5
488:                 .Left            = 5
489:                 .Width           = 40
490:                 .Height          = 40
491:                 .Caption         = ""
492:                 .Picture         = gc_4c_CaminhoIcones + "A_MISC1.BMP"
493:                 .BackColor       = RGB(255, 255, 255)
494:                 .ForeColor       = RGB(36, 84, 155)
495:                 .Themes          = .F.
496:                 .ToolTipText     = "Marcar todas as empresas"
497:                 .Visible         = .T.
498:             ENDWITH
499: 
500:             WITH .Buttons(2)
501:                 .Top             = 46
502:                 .Left            = 5
503:                 .Width           = 40
504:                 .Height          = 40
505:                 .Caption         = ""
506:                 .Picture         = gc_4c_CaminhoIcones + "A_MISC6.bmp"
507:                 .FontName        = "Verdana"
508:                 .FontSize        = 8
509:                 .BackColor       = RGB(255, 255, 255)
510:                 .ForeColor       = RGB(36, 84, 155)

*-- Linhas 871 a 879:
871: 
872:     *--------------------------------------------------------------------------
873:     * BtnMarcaEmpClick - Marca/desmarca todas as empresas pelo chk_4c_MarcaEmp
874:     *   CheckBox.Value=1 -> marca todas; Value=0 -> desmarca todas
875:     *--------------------------------------------------------------------------
876:     PROCEDURE BtnMarcaEmpClick()
877:         LOCAL loc_lMarcar
878:         IF VARTYPE(THIS.this_oRelatorio) != "O"
879:             RETURN


### BO (C:\4c\projeto\app\classes\SIGREDIRBO.prg):
*==============================================================================
* SIGREDIRBO.PRG
* Business Object - Demonstrativo de Retencao de Impostos
* CSLL, COFINS e PIS/PASEP
*
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREDIRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cAnoBase            = ""
    this_cFornec             = ""
    this_cDforn              = ""

    *-- Cursores internos
    this_cCursorEmpresas     = "cursor_4c_Empresas"
    this_cCursorDados        = "cursor_4c_Dados"

    *-- Arquivo de relatorio (sem extensao)
    this_cArquivoFRX         = "sigReDir"
    this_cUltimoArquivoExcel  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursor de empresas para selecao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        IF !DODEFAULT()
            THIS.this_cMensagemErro = "Falha na inicializa" + CHR(231) + CHR(227) + "o da classe base"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")

            IF loc_nResult > 0
                *-- Cria cursor local READWRITE para permitir marcacao pelo usuario
                IF USED(THIS.this_cCursorEmpresas)
                    USE IN (THIS.this_cCursorEmpresas)
                ENDIF
                SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
                    INTO CURSOR (THIS.this_cCursorEmpresas) READWRITE
                USE IN cursor_4c_EmpTmp
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar lista de empresas"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e recursos alocados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorEmpresas)
            USE IN (THIS.this_cCursorEmpresas)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarEmpresas - Monta clausula WHERE para filtro de empresas selecionadas
    * Retorna string SQL (ex: " AND a.Emps = 'xxx'") ou "" se nenhuma selecionada
    *--------------------------------------------------------------------------
    PROCEDURE MontarEmpresas()
        LOCAL loc_cEmp, loc_cVir, loc_nCount

        loc_cEmp   = ""
        loc_cVir   = ""
        loc_nCount = 0

        IF !USED(THIS.this_cCursorEmpresas)
            THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN ""
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        SCAN
            IF Imps = 1
                loc_nCount = loc_nCount + 1
            ENDIF
        ENDSCAN

        IF loc_nCount = 0
            THIS.this_cMensagemErro = "Nenhuma empresa foi selecionada."
            RETURN ""
        ENDIF

        IF loc_nCount = 1
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = " AND a.Emps = '" + ALLTRIM(cemps) + "'"
                ENDIF
            ENDSCAN
        ELSE
            loc_cEmp = " AND a.Emps IN ("
            SELECT (THIS.this_cCursorEmpresas)
            SCAN
                IF Imps = 1
                    loc_cEmp = loc_cEmp + loc_cVir + "'" + ALLTRIM(cemps) + "'"
                    loc_cVir = ", "
                ENDIF
            ENDSCAN
            loc_cEmp = loc_cEmp + ")"
        ENDIF

        RETURN loc_cEmp
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL UNION ALL (PIS/COFINS/CSLL) e executa query
    * Retorna .T. se dados carregados com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpFilter, loc_cFornecFilter
        LOCAL loc_cDtIni, loc_cDtFin, loc_cAno
        LOCAL loc_cJoins, loc_cWhere
        LOCAL loc_cSelect1, loc_cSelect2, loc_cSelect3

        loc_lSucesso = .F.

        TRY
            *-- Validacao: ano base obrigatorio
            loc_cAno = ALLTRIM(THIS.this_cAnoBase)
            IF EMPTY(loc_cAno)
                THIS.this_cMensagemErro = "Ano base n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Filtro de empresas (valida selecao e monta clausula)
            loc_cEmpFilter = THIS.MontarEmpresas()
            IF EMPTY(loc_cEmpFilter)
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo do exercicio anual
            loc_cDtIni = "'" + loc_cAno + "-01-01'"
            loc_cDtFin = "'" + loc_cAno + "-12-31 23:59:59'"

            *-- Filtro de fornecedor (opcional)
            IF !EMPTY(ALLTRIM(THIS.this_cFornec))
                loc_cFornecFilter = " AND a.clifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornec))
            ELSE
                loc_cFornecFilter = ""
            ENDIF

            *-- Clausulas reutilizaveis
            loc_cJoins = " LEFT JOIN SigCdSrv b WITH (NOLOCK) ON a.codservs = b.codservs" + ;
                         " LEFT JOIN SigCdCli c ON c.iclis = a.clifors" + ;
                         " LEFT JOIN SigCdEmp d ON a.emps = d.cemps"

            loc_cWhere = " WHERE a.emis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + ;
                         " AND (a.vpis <> 0 OR a.vcofins <> 0 OR a.vcsll <> 0)" + ;
                         loc_cEmpFilter + loc_cFornecFilter

            *-- SELECT PIS
            loc_cSelect1 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vpis AS vimposto, b.codpiss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT COFINS
            loc_cSelect2 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcofins AS vimposto, b.codcofinss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT CSLL
            loc_cSelect3 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcsll AS vimposto, b.codcslls AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- UNION ALL (PIS + COFINS + CSLL) com ordenacao
            loc_cSQL = loc_cSelect1 + ;
                       " UNION ALL " + loc_cSelect2 + ;
                       " UNION ALL " + loc_cSelect3 + ;
                       " ORDER BY cnpj, clifors, emis, codservs"

            *-- Fechar cursor anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e abre dialogo de impressao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresas - Marca ou desmarca todas as empresas no cursor
    * par_lMarcar: .T. marca todas, .F. desmarca todas
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresas(par_lMarcar)
        LOCAL loc_nValor
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)
        IF USED(THIS.this_cCursorEmpresas)
            SELECT (THIS.this_cCursorEmpresas)
            REPLACE ALL Imps WITH loc_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresaUnica - Marca/desmarca empresa especifica no cursor
    * par_cCodigoEmp: codigo da empresa (cemps) a alterar
    * par_lMarcar: .T. para marcar (Imps=1), .F. para desmarcar (Imps=0)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, par_lMarcar)
        LOCAL loc_lSucesso, loc_nValor, loc_cCodigo
        loc_lSucesso = .F.
        loc_cCodigo = ALLTRIM(par_cCodigoEmp)
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)

        IF EMPTY(loc_cCodigo) OR !USED(THIS.this_cCursorEmpresas)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        LOCATE FOR ALLTRIM(cemps) == loc_cCodigo
        IF FOUND()
            REPLACE Imps WITH loc_nValor
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirEmpresaNaSelecao - Adiciona empresa especifica na selecao (Imps=1)
    * Util para pre-selecionar empresas via codigo externo (ex: empresa logada)
    * par_cCodigoEmp: codigo da empresa (cemps) a marcar
    *--------------------------------------------------------------------------
    PROCEDURE InserirEmpresaNaSelecao(par_cCodigoEmp)
        RETURN THIS.AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros da linha atual do cursor
    * Permite restaurar estado de filtros a partir de cursor externo
    * (ex: configuracao salva, parametros de outro form, agendamento)
    * par_cAliasCursor: nome do cursor com campos AnoBase/Fornec/Dforn
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ELSE
                SELECT (par_cAliasCursor)

                IF TYPE("AnoBase") <> "U"
                    THIS.this_cAnoBase = TratarNulo(AnoBase, "C")
                ENDIF

                IF TYPE("Fornec") <> "U"
                    THIS.this_cFornec = TratarNulo(Fornec, "C")
                ENDIF

                IF TYPE("Dforn") <> "U"
                    THIS.this_cDforn = TratarNulo(Dforn, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para arquivo XLS
    *   Retorna .T. se exportacao bem-sucedida
    *   this_cUltimoArquivoExcel recebe caminho do arquivo gerado
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cData
        loc_lSucesso = .F.
        THIS.this_cUltimoArquivoExcel = ""

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cData    = TRANSFORM(YEAR(DATE())) + ;
                           RIGHT("0" + TRANSFORM(MONTH(DATE())), 2) + ;
                           RIGHT("0" + TRANSFORM(DAY(DATE())), 2)
            loc_cArquivo = SYS(5) + CURDIR() + "sigReDir_" + loc_cData + ".xls"

            SELECT (THIS.this_cCursorDados)
            COPY TO (loc_cArquivo) TYPE XLS

            THIS.this_cUltimoArquivoExcel = loc_cArquivo
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do relatorio (ano base + cnpj fornec)
    * Usado por RegistrarAuditoria para identificar a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cAnoBase)
        IF !EMPTY(ALLTRIM(THIS.this_cFornec))
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cFornec)
        ENDIF
        RETURN loc_cChave
    ENDPROC

ENDDEFINE

