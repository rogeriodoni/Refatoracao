# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1107 linhas total):

*-- Linhas 29 a 37:
29:         LOCAL loc_lResultado
30:         loc_lResultado = .F.
31:         TRY
32:             THIS.Caption   = "Cadastro de Instru" + CHR(231) + CHR(245) + "es"
33:             loc_lResultado = DODEFAULT()
34:         CATCH TO loException
35:             MsgErro(loException.Message, "FormSIGPRINT.Init")
36:         ENDTRY
37:         RETURN loc_lResultado

*-- Linhas 47 a 56:
47:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRINTBO")
48:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
53:                     THIS.CarregarLista()
54:                 ENDIF
55:                 THIS.pgf_4c_Paginas.Visible = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 72 a 87:
72:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
73:         WITH THIS.pgf_4c_Paginas
74:             .PageCount       = 2
75:             .Top             = -29
76:             .Left            = 0
77:             .Width           = THIS.Width
78:             .Height          = THIS.Height
79:             .Tabs            = .F.
80:             .Visible         = .T.
81:             .Page1.Caption   = "Lista"
82:             .Page2.Caption   = "Dados"
83:             .Page1.BackColor = RGB(100, 100, 100)
84:             .Page2.BackColor = RGB(100, 100, 100)
85:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:         ENDWITH

*-- Linhas 103 a 139:
103:         *-- Cabecalho escuro com titulo (cntSombra no legado)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Caption   = THIS.Caption
117:                 .Top       = 15
118:                 .Left      = 10
119:                 .Width     = THIS.Width
120:                 .Height    = 40
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 16
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .AutoSize  = .F.
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Caption   = THIS.Caption
133:                 .Top       = 18
134:                 .Left      = 10
135:                 .Width     = THIS.Width
136:                 .Height    = 46
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.

*-- Linhas 147 a 170:
147:         *-- Container botoes CRUD (Grupo_op no legado: Left=344, Width=385)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 28
151:             .Left        =  542
152:             .Width       = 385
153:             .Height      = 85
154:             .BackStyle   = 1
155:             .BackColor   = RGB(53, 53, 53)
156:             .BorderWidth = 0
157:             .Visible     = .T.
158: 
159:             .AddObject("cmd_4c_Incluir", "CommandButton")
160:             WITH .cmd_4c_Incluir
161:                 .Caption         = "Incluir"
162:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:                 .PicturePosition = 13
164:                 .Top             = 5
165:                 .Left            =  542
166:                 .Width           = 75
167:                 .Height          = 75
168:                 .FontName        = "Tahoma"
169:                 .FontSize        = 8
170:                 .FontBold        = .T.

*-- Linhas 178 a 192:
178:                 .Visible         = .T.
179:             ENDWITH
180: 
181:             .AddObject("cmd_4c_Visualizar", "CommandButton")
182:             WITH .cmd_4c_Visualizar
183:                 .Caption         = "Visualizar"
184:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
185:                 .PicturePosition = 13
186:                 .Top             = 5
187:                 .Left            =  542
188:                 .Width           = 75
189:                 .Height          = 75
190:                 .FontName        = "Tahoma"
191:                 .FontSize        = 8
192:                 .FontBold        = .T.

*-- Linhas 201 a 215:
201:                 .Visible         = .T.
202:             ENDWITH
203: 
204:             .AddObject("cmd_4c_Alterar", "CommandButton")
205:             WITH .cmd_4c_Alterar
206:                 .Caption         = "Alterar"
207:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
208:                 .PicturePosition = 13
209:                 .Top             = 5
210:                 .Left            =  542
211:                 .Width           = 75
212:                 .Height          = 75
213:                 .FontName        = "Tahoma"
214:                 .FontSize        = 8
215:                 .FontBold        = .T.

*-- Linhas 224 a 238:
224:                 .Visible         = .T.
225:             ENDWITH
226: 
227:             .AddObject("cmd_4c_Excluir", "CommandButton")
228:             WITH .cmd_4c_Excluir
229:                 .Caption         = "Excluir"
230:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
231:                 .PicturePosition = 13
232:                 .Top             = 5
233:                 .Left            =  542
234:                 .Width           = 75
235:                 .Height          = 75
236:                 .FontName        = "Tahoma"
237:                 .FontSize        = 8
238:                 .FontBold        = .T.

*-- Linhas 247 a 261:
247:                 .Visible         = .T.
248:             ENDWITH
249: 
250:             .AddObject("cmd_4c_Buscar", "CommandButton")
251:             WITH .cmd_4c_Buscar
252:                 .Caption         = "Buscar"
253:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
254:                 .PicturePosition = 13
255:                 .Top             = 5
256:                 .Left            =  542
257:                 .Width           = 75
258:                 .Height          = 75
259:                 .FontName        = "Tahoma"
260:                 .FontSize        = 8
261:                 .FontBold        = .T.

*-- Linhas 274 a 296:
274:         *-- Container Encerrar (padrao canonico: Left=917)
275:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
276:         WITH loc_oPagina.cnt_4c_Saida
277:             .Top         = 29
278:             .Left        = 917
279:             .Width       = 90
280:             .Height      = 85
281:             .BackStyle   = 0
282:             .BorderWidth = 0
283:             .Visible     = .T.
284: 
285:             .AddObject("cmd_4c_Encerrar", "CommandButton")
286:             WITH .cmd_4c_Encerrar
287:                 .Caption         = "Encerrar"
288:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
289:                 .PicturePosition = 13
290:                 .Top             = 5
291:                 .Left            = 917
292:                 .Width           = 75
293:                 .Height          = 75
294:                 .FontName        = "Tahoma"
295:                 .FontSize        = 8
296:                 .FontBold        = .T.

*-- Linhas 309 a 318:
309:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
310:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
311:         WITH loc_oPagina.grd_4c_Lista
312:             .Top                = 117
313:             .Left               = 26
314:             .Width              = 860
315:             .Height             = 450
316:             .FontName           = "Verdana"
317:             .FontSize           = 8
318:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 331 a 344:
331:         ENDWITH
332: 
333:         *-- BINDEVENTs dos botoes CRUD
334:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
335:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
336:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
337:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
338:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
339:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
340:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "BtnVisualizarClick")
341: 
342:         THIS.TornarControlesVisiveis(loc_oPagina)
343:     ENDPROC
344: 

*-- Linhas 355 a 377:
355:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=642, Top=-3 -> +29 = 26)
356:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
357:         WITH loc_oPagina.cnt_4c_BotoesAcao
358:             .Top         = 26
359:             .Left        = 642
360:             .Width       = 160
361:             .Height      = 85
362:             .BackStyle   = 0
363:             .BorderWidth = 0
364:             .Visible     = .T.
365: 
366:             .AddObject("cmd_4c_Confirmar", "CommandButton")
367:             WITH .cmd_4c_Confirmar
368:                 .Caption         = "Confirmar"
369:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
370:                 .PicturePosition = 13
371:                 .Top             = 5
372:                 .Left            = 5
373:                 .Width           = 75
374:                 .Height          = 75
375:                 .FontName        = "Tahoma"
376:                 .FontSize        = 8
377:                 .FontBold        = .T.

*-- Linhas 385 a 399:
385:                 .Visible         = .T.
386:             ENDWITH
387: 
388:             .AddObject("cmd_4c_Cancelar", "CommandButton")
389:             WITH .cmd_4c_Cancelar
390:                 .Caption         = "Encerrar"
391:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
392:                 .PicturePosition = 13
393:                 .Top             = 5
394:                 .Left            = 80
395:                 .Width           = 75
396:                 .Height          = 75
397:                 .FontName        = "Tahoma"
398:                 .FontSize        = 8
399:                 .FontBold        = .T.

*-- Linhas 410 a 422:
410:         ENDWITH
411: 
412:         *-- Label Codigo (Say8: Top=162 -> +29 = 191, Left=118, Width=42)
413:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
414:         WITH loc_oPagina.lbl_4c_Codigo
415:             .Caption   = "C" + CHR(243) + "digo :"
416:             .Top       = 191
417:             .Left      = 118
418:             .Width     = 42
419:             .Height    = 17
420:             .FontName  = "Tahoma"
421:             .FontSize  = 8
422:             .FontBold  = .F.

*-- Linhas 431 a 440:
431:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
432:         WITH loc_oPagina.txt_4c_Codigo
433:             .Value     = ""
434:             .Top       = 188
435:             .Left      = 162
436:             .Width     = 80
437:             .Height    = 23
438:             .MaxLength = 10
439:             .Format    = "!"
440:             .FontName  = "Tahoma"

*-- Linhas 448 a 460:
448:         ENDWITH
449: 
450:         *-- Label Descricao (Say1: Top=187 -> +29 = 216, Left=105, Width=55)
451:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
452:         WITH loc_oPagina.lbl_4c_Descricao
453:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
454:             .Top       = 216
455:             .Left      = 105
456:             .Width     = 55
457:             .Height    = 17
458:             .FontName  = "Tahoma"
459:             .FontSize  = 8
460:             .FontBold  = .F.

*-- Linhas 469 a 478:
469:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
470:         WITH loc_oPagina.txt_4c_Descricao
471:             .Value     = ""
472:             .Top       = 213
473:             .Left      = 162
474:             .Width     = 537
475:             .Height    = 23
476:             .MaxLength = 76
477:             .Format    = "!"
478:             .FontName  = "Tahoma"

*-- Linhas 486 a 498:
486:         ENDWITH
487: 
488:         *-- Label Mensagem (Say3: Top=210 -> +29 = 239, Left=100, Width=60)
489:         loc_oPagina.AddObject("lbl_4c_Mensagem", "Label")
490:         WITH loc_oPagina.lbl_4c_Mensagem
491:             .Caption   = "Mensagem :"
492:             .Top       = 239
493:             .Left      = 100
494:             .Width     = 60
495:             .Height    = 17
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .FontBold  = .F.

*-- Linhas 507 a 516:
507:         loc_oPagina.AddObject("txt_4c_Mensagem", "EditBox")
508:         WITH loc_oPagina.txt_4c_Mensagem
509:             .Value     = ""
510:             .Top       = 238
511:             .Left      = 162
512:             .Width     = 537
513:             .Height    = 103
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 522 a 534:
522:         ENDWITH
523: 
524:         *-- Label Tipo (Say2: Top=320 -> +29 = 349, Left=131, Width=29)
525:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
526:         WITH loc_oPagina.lbl_4c_Tipo
527:             .Caption   = "Tipo :"
528:             .Top       = 349
529:             .Left      = 131
530:             .Width     = 29
531:             .Height    = 17
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .FontBold  = .F.

*-- Linhas 546 a 589:
546:             .Value       = 1
547:             .BackStyle   = 0
548:             .BorderStyle = 0
549:             .Top         = 343
550:             .Left        = 156
551:             .Width       = 292
552:             .Height      = 27
553:             .Enabled     = .F.
554:             .Visible     = .T.
555:             WITH .Buttons(1)
556:                 .Caption   = "Cheque"
557:                 .Left      = 7
558:                 .Top       = 5
559:                 .Width     = 62
560:                 .Height    = 17
561:                 .AutoSize  = .F.
562:                 .ForeColor = RGB(90, 90, 90)
563:                 .BackStyle = 0
564:                 .Themes    = .F.
565:                 .Visible   = .T.
566:             ENDWITH
567:             WITH .Buttons(2)
568:                 .Caption   = "T" + CHR(237) + "tulo"
569:                 .Left      = 84
570:                 .Top       = 5
571:                 .Width     = 62
572:                 .Height    = 17
573:                 .AutoSize  = .F.
574:                 .FontName  = "Tahoma"
575:                 .FontSize  = 8
576:                 .ForeColor = RGB(90, 90, 90)
577:                 .BackStyle = 0
578:                 .Themes    = .F.
579:                 .Visible   = .T.
580:             ENDWITH
581:             WITH .Buttons(3)
582:                 .Caption   = "Follow Up"
583:                 .Left      = 148
584:                 .Top       = 5
585:                 .Width     = 64
586:                 .Height    = 15
587:                 .AutoSize  = .T.
588:                 .FontName  = "Tahoma"
589:                 .FontSize  = 8

*-- Linhas 595 a 604:
595:         ENDWITH
596: 
597:         *-- BINDEVENTs dos botoes de Page2
598:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
599:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
600: 
601:         THIS.TornarControlesVisiveis(loc_oPagina)
602:     ENDPROC
603: 
604:     *--------------------------------------------------------------------------

*-- Linhas 623 a 633:
623:                         .Column1.Width            = 100
624:                         .Column2.Width            = 680
625:                         .Column3.Width            = 60
626:                         .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
627:                         .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
628:                         .Column3.Header1.Caption  = "Tipo"
629:                         .Column1.Alignment        = 0
630:                         .Column2.Alignment        = 0
631:                         .Column3.Alignment        = 2
632:                     ENDWITH
633: 

*-- Linhas 686 a 698:
686:         TRY
687:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
688:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
689:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
690:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
691:                 ENDIF
692:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
693:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
694:                 ENDIF
695:             ENDIF
696:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
697:                 loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR")
698:             ENDIF


### BO (C:\4c\projeto\app\classes\SIGPRINTBO.prg):
*==============================================================================
* SIGPRINTBO.prg - Business Object para Cadastro de Instru????es de Impress??o
* Tabela: SigOpIns
* Gerado em: 2026-07-17
*==============================================================================

DEFINE CLASS SIGPRINTBO AS BusinessBase

    *-- Propriedades da entidade (mapeiam colunas de SigOpIns)
    this_cCodigo    = ""   && cods    char(10) NOT NULL - PK
    this_cDescricao = ""   && descrs  char(76) NOT NULL
    this_cMensagem  = ""   && mensas  text NULL
    this_nTipo      = 0    && tipos   numeric(1,0) NOT NULL - 1=Cheque, 2=Titulos, 3=FollowUp
    this_cCidChaves = ""   && cidchaves char(20) NOT NULL

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpIns"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros de SigOpIns
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns ORDER BY cods"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                           " FROM SigOpIns" + ;
                           " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY cods"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (cods)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs, mensas, tipos, cidchaves" + ;
                       " FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,      "C")
            THIS.this_cDescricao = TratarNulo(descrs,    "C")
            THIS.this_cMensagem  = TratarNulo(mensas,    "C")
            THIS.this_nTipo      = TratarNulo(tipos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpIns
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigOpIns (cods, descrs, mensas, tipos, cidchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpIns SET" + ;
                       " descrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescricao), 76)) + ", " + ;
                       " mensas = " + EscaparSQL(THIS.this_cMensagem) + ", " + ;
                       " tipos = "  + FormatarNumeroSQL(THIS.this_nTipo) + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpIns (PK = cods)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir instru" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para validar unicidade)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigo(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpIns" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ValCod")
                TABLEREVERT(.T., "cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCod")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCod") > 0
                SELECT cursor_4c_ValCod
                loc_lExiste = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_ValCod")
                USE IN cursor_4c_ValCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

