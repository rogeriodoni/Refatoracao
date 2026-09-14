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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRINT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1110 linhas total):

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
292:                 .Width           = 90
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

*-- Linhas 334 a 347:
334:         ENDWITH
335: 
336:         *-- BINDEVENTs dos botoes CRUD
337:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
338:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
339:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
340:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
341:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
342:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
343:         BINDEVENT(loc_oPagina.grd_4c_Lista,                    "DblClick", THIS, "BtnVisualizarClick")
344: 
345:         THIS.TornarControlesVisiveis(loc_oPagina)
346:     ENDPROC
347: 

*-- Linhas 358 a 380:
358:         *-- Container Salvar/Cancelar (Grupo_Salva: Left=642, Top=-3 -> +29 = 26)
359:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
360:         WITH loc_oPagina.cnt_4c_BotoesAcao
361:             .Top         = 26
362:             .Left        = 642
363:             .Width       = 160
364:             .Height      = 85
365:             .BackStyle   = 0
366:             .BorderWidth = 0
367:             .Visible     = .T.
368: 
369:             .AddObject("cmd_4c_Confirmar", "CommandButton")
370:             WITH .cmd_4c_Confirmar
371:                 .Caption         = "Confirmar"
372:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
373:                 .PicturePosition = 13
374:                 .Top             = 5
375:                 .Left            = 5
376:                 .Width           = 75
377:                 .Height          = 75
378:                 .FontName        = "Tahoma"
379:                 .FontSize        = 8
380:                 .FontBold        = .T.

*-- Linhas 388 a 402:
388:                 .Visible         = .T.
389:             ENDWITH
390: 
391:             .AddObject("cmd_4c_Cancelar", "CommandButton")
392:             WITH .cmd_4c_Cancelar
393:                 .Caption         = "Encerrar"
394:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
395:                 .PicturePosition = 13
396:                 .Top             = 5
397:                 .Left            = 80
398:                 .Width           = 75
399:                 .Height          = 75
400:                 .FontName        = "Tahoma"
401:                 .FontSize        = 8
402:                 .FontBold        = .T.

*-- Linhas 413 a 425:
413:         ENDWITH
414: 
415:         *-- Label Codigo (Say8: Top=162 -> +29 = 191, Left=118, Width=42)
416:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
417:         WITH loc_oPagina.lbl_4c_Codigo
418:             .Caption   = "C" + CHR(243) + "digo :"
419:             .Top       = 191
420:             .Left      = 118
421:             .Width     = 42
422:             .Height    = 17
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .FontBold  = .F.

*-- Linhas 434 a 443:
434:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
435:         WITH loc_oPagina.txt_4c_Codigo
436:             .Value     = ""
437:             .Top       = 188
438:             .Left      = 162
439:             .Width     = 80
440:             .Height    = 23
441:             .MaxLength = 10
442:             .Format    = "!"
443:             .FontName  = "Tahoma"

*-- Linhas 451 a 463:
451:         ENDWITH
452: 
453:         *-- Label Descricao (Say1: Top=187 -> +29 = 216, Left=105, Width=55)
454:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
455:         WITH loc_oPagina.lbl_4c_Descricao
456:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
457:             .Top       = 216
458:             .Left      = 105
459:             .Width     = 55
460:             .Height    = 17
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .FontBold  = .F.

*-- Linhas 472 a 481:
472:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
473:         WITH loc_oPagina.txt_4c_Descricao
474:             .Value     = ""
475:             .Top       = 213
476:             .Left      = 162
477:             .Width     = 537
478:             .Height    = 23
479:             .MaxLength = 76
480:             .Format    = "!"
481:             .FontName  = "Tahoma"

*-- Linhas 489 a 501:
489:         ENDWITH
490: 
491:         *-- Label Mensagem (Say3: Top=210 -> +29 = 239, Left=100, Width=60)
492:         loc_oPagina.AddObject("lbl_4c_Mensagem", "Label")
493:         WITH loc_oPagina.lbl_4c_Mensagem
494:             .Caption   = "Mensagem :"
495:             .Top       = 239
496:             .Left      = 100
497:             .Width     = 60
498:             .Height    = 17
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .FontBold  = .F.

*-- Linhas 510 a 519:
510:         loc_oPagina.AddObject("txt_4c_Mensagem", "EditBox")
511:         WITH loc_oPagina.txt_4c_Mensagem
512:             .Value     = ""
513:             .Top       = 238
514:             .Left      = 162
515:             .Width     = 537
516:             .Height    = 103
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 525 a 537:
525:         ENDWITH
526: 
527:         *-- Label Tipo (Say2: Top=320 -> +29 = 349, Left=131, Width=29)
528:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
529:         WITH loc_oPagina.lbl_4c_Tipo
530:             .Caption   = "Tipo :"
531:             .Top       = 349
532:             .Left      = 131
533:             .Width     = 29
534:             .Height    = 17
535:             .FontName  = "Tahoma"
536:             .FontSize  = 8
537:             .FontBold  = .F.

*-- Linhas 549 a 592:
549:             .Value       = 1
550:             .BackStyle   = 0
551:             .BorderStyle = 0
552:             .Top         = 343
553:             .Left        = 156
554:             .Width       = 292
555:             .Height      = 27
556:             .Enabled     = .F.
557:             .Visible     = .T.
558:             WITH .Buttons(1)
559:                 .Caption   = "Cheque"
560:                 .Left      = 7
561:                 .Top       = 5
562:                 .Width     = 62
563:                 .Height    = 17
564:                 .AutoSize  = .F.
565:                 .ForeColor = RGB(90, 90, 90)
566:                 .BackStyle = 0
567:                 .Themes    = .F.
568:                 .Visible   = .T.
569:             ENDWITH
570:             WITH .Buttons(2)
571:                 .Caption   = "T" + CHR(237) + "tulo"
572:                 .Left      = 84
573:                 .Top       = 5
574:                 .Width     = 62
575:                 .Height    = 17
576:                 .AutoSize  = .F.
577:                 .FontName  = "Tahoma"
578:                 .FontSize  = 8
579:                 .ForeColor = RGB(90, 90, 90)
580:                 .BackStyle = 0
581:                 .Themes    = .F.
582:                 .Visible   = .T.
583:             ENDWITH
584:             WITH .Buttons(3)
585:                 .Caption   = "Follow Up"
586:                 .Left      = 148
587:                 .Top       = 5
588:                 .Width     = 64
589:                 .Height    = 15
590:                 .AutoSize  = .T.
591:                 .FontName  = "Tahoma"
592:                 .FontSize  = 8

*-- Linhas 598 a 607:
598:         ENDWITH
599: 
600:         *-- BINDEVENTs dos botoes de Page2
601:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
602:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
603: 
604:         THIS.TornarControlesVisiveis(loc_oPagina)
605:     ENDPROC
606: 
607:     *--------------------------------------------------------------------------

*-- Linhas 626 a 636:
626:                         .Column1.Width            = 100
627:                         .Column2.Width            = 680
628:                         .Column3.Width            = 60
629:                         .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
630:                         .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
631:                         .Column3.Header1.Caption  = "Tipo"
632:                         .Column1.Alignment        = 0
633:                         .Column2.Alignment        = 0
634:                         .Column3.Alignment        = 2
635:                     ENDWITH
636: 

*-- Linhas 689 a 701:
689:         TRY
690:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
691:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
692:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
693:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
694:                 ENDIF
695:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
696:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
697:                 ENDIF
698:             ENDIF
699:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
700:                 loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR")
701:             ENDIF


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

