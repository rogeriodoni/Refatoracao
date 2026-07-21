# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Carac' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Ok' (parent: SIGPRPRO): Left original=723 vs migrado 'cmd_4c_Ok' Left=904 (diff=181px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (688 linhas total):

*-- Linhas 86 a 110:
86:             IF EMPTY(loc_cErroParam)
87:                 *-- Carregar descricao do produto
88:                 THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
89: 
90:                 *-- Criar cursor placeholder para o grid (estrutura identica ao SQLEXEC do BO)
91:                 IF USED("cursor_4c_Carac")
92:                     TABLEREVERT(.T., "cursor_4c_Carac")
93:                     USE IN cursor_4c_Carac
94:                 ENDIF
95:                 CREATE CURSOR cursor_4c_Carac ;
96:                     (cidchaves  C(20), ;
97:                      caracteris C(40), ;
98:                      compls     C(40), ;
99:                      infos      M)
100: 
101:                 *-- Criar componentes visuais
102:                 THIS.ConfigurarCabecalho()
103:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
104:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
105: 
106:                 *-- Criar area de exibicao do produto (shapes decorativos + codigo)
107:                 THIS.ConfigurarPaginaLista()
108:                 *-- Criar area de conteudo (grid + complemento + memo + botao OK)
109:                 THIS.ConfigurarPaginaDados()
110: 

*-- Linhas 138 a 191:
138: 
139:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
140:         WITH THIS.cnt_4c_Cabecalho
141:             .Top         = 0
142:             .Left        = 0
143:             .Width       = THIS.Width
144:             .Height      = 96
145:             .BackStyle   = 1
146:             .BackColor   = RGB(100, 100, 100)
147:             .BorderWidth = 0
148:             .Visible     = .T.
149:         ENDWITH
150: 
151:         *-- Label sombra (efeito de sombra no texto do titulo)
152:         *-- Original: Top=25, Left=10, FontSize=18, ForeColor=0,0,0 -> sombra preta
153:         loc_oCab = THIS.cnt_4c_Cabecalho
154:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
155:         WITH loc_oCab.lbl_4c_Sombra
156:             .Top       = 30
157:             .Left      = 12
158:             .Width     = loc_oCab.Width - 140
159:             .Height    = 48
160:             .FontName  = "Tahoma"
161:             .FontSize  = 18
162:             .FontBold  = .T.
163:             .AutoSize  = .F.
164:             .WordWrap  = .T.
165:             .BackStyle = 0
166:             .ForeColor = RGB(0, 0, 0)
167:             .Caption   = THIS.Caption
168:             .Visible   = .T.
169:         ENDWITH
170: 
171:         *-- Label titulo (texto principal branco sobre a sombra)
172:         *-- Original: Top=24, Left=10, FontSize=18, ForeColor=255,255,255
173:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
174:         WITH loc_oCab.lbl_4c_Titulo
175:             .Top       = 29
176:             .Left      = 12
177:             .Width     = loc_oCab.Width - 140
178:             .Height    = 55
179:             .FontName  = "Tahoma"
180:             .FontSize  = 18
181:             .FontBold  = .T.
182:             .AutoSize  = .F.
183:             .WordWrap  = .T.
184:             .BackStyle = 0
185:             .ForeColor = RGB(255, 255, 255)
186:             .Caption   = THIS.Caption
187:             .Visible   = .T.
188:         ENDWITH
189:     ENDPROC
190: 
191:     *---------------------------------------------------------------------------

*-- Linhas 208 a 251:
208:     ENDPROC
209: 
210:     *---------------------------------------------------------------------------
211:     PROCEDURE Destroy()
212:     *---------------------------------------------------------------------------
213:         IF USED("cursor_4c_Carac")
214:             TABLEREVERT(.T., "cursor_4c_Carac")
215:             USE IN cursor_4c_Carac
216:         ENDIF
217:         DODEFAULT()
218:     ENDPROC
219: 
220:     *---------------------------------------------------------------------------
221:     PROTECTED PROCEDURE ConfigurarPaginaLista()
222:     *-- Primeiro 50% dos controles visuais:
223:     *-- Shapes decorativos + area de exibicao do codigo/descricao do produto
224:     *-- Layout fiel ao SIGPRPRO.SCX (800x500 escalado para 1000x600, fx=1.25, fy=1.2)
225:     *---------------------------------------------------------------------------
226: 
227:         *-- Shape decorativo superior-direito (area do botao OK)
228:         *-- Original: Top=7, Left=697, Width=90, Height=110
229:         THIS.AddObject("shp_4c_Shape", "Shape")
230:         WITH THIS.shp_4c_Shape
231:             .Top         = 8
232:             .Left        = 871
233:             .Width       = 113
234:             .Height      = 132
235:             .BackStyle   = 0
236:             .BorderStyle = 0
237:             .BorderColor = RGB(136, 189, 188)
238:             .Visible     = .T.
239:         ENDWITH
240: 
241:         *-- Borda da area de codigo do produto
242:         *-- Original: shpCodigo - Top=94, Left=13, Width=671, Height=34
243:         THIS.AddObject("shp_4c_ShpCodigo", "Shape")
244:         WITH THIS.shp_4c_ShpCodigo
245:             .Top           = 113
246:             .Left          = 16
247:             .Width         = 839
248:             .Height        = 41
249:             .BackStyle     = 0
250:             .Curvature     = 0
251:             .SpecialEffect = 1

*-- Linhas 257 a 299:
257:         *-- Original: Shape1 - Top=133, Left=13, Width=671, Height=341
258:         THIS.AddObject("shp_4c_Shape1", "Shape")
259:         WITH THIS.shp_4c_Shape1
260:             .Top           = 160
261:             .Left          = 16
262:             .Width         = 839
263:             .Height        = 409
264:             .BackStyle     = 0
265:             .Curvature     = 0
266:             .SpecialEffect = 1
267:             .BorderColor   = RGB(90, 90, 90)
268:             .Visible       = .T.
269:         ENDWITH
270: 
271:         *-- Label "Produto :"
272:         *-- Original: Label1 - Top=103, Left=25
273:         THIS.AddObject("lbl_4c_Label1", "Label")
274:         WITH THIS.lbl_4c_Label1
275:             .Top       = 124
276:             .Left      = 31
277:             .Width     = 59
278:             .Height    = 18
279:             .FontName  = "Tahoma"
280:             .FontSize  = 8
281:             .FontBold  = .F.
282:             .AutoSize  = .T.
283:             .BackStyle = 0
284:             .Caption   = "Produto :"
285:             .ForeColor = RGB(90, 90, 90)
286:             .Visible   = .T.
287:         ENDWITH
288: 
289:         *-- Campo codigo do produto (somente leitura - Enabled=.F.)
290:         *-- Original: getCPros - Top=99, Left=75, Width=108, Enabled=.F.
291:         THIS.AddObject("txt_4c_CPros", "TextBox")
292:         WITH THIS.txt_4c_CPros
293:             .Top               = 119
294:             .Left              = 94
295:             .Width             = 135
296:             .Height            = 28
297:             .Value             = THIS.this_cCPros
298:             .Enabled           = .F.
299:             .DisabledBackColor = RGB(255, 255, 230)

*-- Linhas 317 a 326:
317:         *-- Original: getDPros - Top=99, Left=184, Width=494, Enabled=.F.
318:         THIS.AddObject("txt_4c_DPros", "TextBox")
319:         WITH THIS.txt_4c_DPros
320:             .Top               = 119
321:             .Left              = 230
322:             .Width             = 618
323:             .Height            = 28
324:             .Value             = ""
325:             .Enabled           = .F.
326:             .Format            = "K!"

*-- Linhas 336 a 345:
336:         *-- Original: GradeCarac - Top=139, Left=20, Width=319, Height=328, ColumnCount=1
337:         THIS.AddObject("grd_4c_Dados", "Grid")
338:         WITH THIS.grd_4c_Dados
339:             .Top                = 167
340:             .Left               = 25
341:             .Width              = 399
342:             .Height             = 394
343:             .ColumnCount        = 1
344:             .ReadOnly           = .F.
345:             .RecordMark         = .F.

*-- Linhas 367 a 384:
367:         WITH loc_oGrd.Column1.Header1
368:             .FontName  = "Tahoma"
369:             .Alignment = 2
370:             .Caption   = "Caracter" + CHR(237) + "sticas"
371:             .ForeColor = RGB(90, 90, 90)
372:         ENDWITH
373: 
374:         *-- Campo complemento (preenchido via AfterRowColChange)
375:         *-- Original: getComples - Top=139, Left=348, Width=329, Height=23
376:         THIS.AddObject("txt_4c_Comples", "TextBox")
377:         WITH THIS.txt_4c_Comples
378:             .Top         = 167
379:             .Left        = 435
380:             .Width       = 411
381:             .Height      = 28
382:             .Value       = ""
383:             .ReadOnly    = .T.
384:             .FontName    = "Tahoma"

*-- Linhas 391 a 507:
391:         *-- Original: GetMemo (fwmemo/editbox) - Top=167, Left=348, Width=329, Height=300
392:         THIS.AddObject("edt_4c_Infos", "EditBox")
393:         WITH THIS.edt_4c_Infos
394:             .Top        = 200
395:             .Left       = 435
396:             .Width      = 411
397:             .Height     = 360
398:             .Value      = ""
399:             .ReadOnly   = .T.
400:             .FontName   = "Tahoma"
401:             .FontSize   = 8
402:             .ScrollBars = 2
403:             .Visible    = .T.
404:         ENDWITH
405: 
406:         *-- Botao OK (fecha o form)
407:         *-- Original: Ok - Top=3, Left=723, Caption="OK", Picture=cadastro_salvar_60.jpg
408:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
409:         WITH THIS.cmd_4c_Ok
410:             .Top             = 4
411:             .Left            = 904
412:             .Width           = 75
413:             .Height          = 75
414:             .Caption         = "OK"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
416:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
417:             .FontName        = "Tahoma"
418:             .FontSize        = 8
419:             .FontBold        = .T.
420:             .FontItalic      = .T.
421:             .ForeColor       = RGB(90, 90, 90)
422:             .BackColor       = RGB(255, 255, 255)
423:             .Themes          = .T.
424:             .SpecialEffect   = 0
425:             .PicturePosition = 13
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .Visible         = .T.
429:         ENDWITH
430: 
431:         *-- Vincular eventos (metodos devem ser PUBLIC para BINDEVENT)
432:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
433:         BINDEVENT(THIS.cmd_4c_Ok,    "Click",             THIS, "CmdOkClick")
434:     ENDPROC
435: 
436:     *---------------------------------------------------------------------------
437:     PROTECTED PROCEDURE CarregarDados()
438:     *-- Popula grid de caracteristicas e campos de exibicao
439:     *---------------------------------------------------------------------------
440:         LOCAL loc_oGrd, loc_oErro
441: 
442:         TRY
443:             *-- Descricao do produto (carregada pelo BO em BuscarDadosProduto)
444:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
445:                 THIS.txt_4c_DPros.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDPros, ""))
446:             ENDIF
447: 
448:             *-- Carregar caracteristicas via BO (popula cursor_4c_Carac)
449:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
450:                 THIS.this_oBusinessObject.BuscarCaracteristicas(THIS.this_cCPros)
451:             ENDIF
452: 
453:             *-- Configurar RecordSource do grid (ColumnCount ANTES de RecordSource)
454:             loc_oGrd = THIS.grd_4c_Dados
455:             loc_oGrd.ColumnCount           = 1
456:             loc_oGrd.RecordSource          = "cursor_4c_Carac"
457:             loc_oGrd.Column1.ControlSource = "cursor_4c_Carac.caracteris"
458:             *-- Re-setar cabecalho (RecordSource pode resetar headers)
459:             loc_oGrd.Column1.Header1.Caption = "Caracter" + CHR(237) + "sticas"
460: 
461:             *-- Exibir informacoes da primeira caracteristica (se houver)
462:             IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
463:                 GO TOP IN cursor_4c_Carac
464:                 THIS.txt_4c_Comples.Value = NVL(cursor_4c_Carac.compls, "")
465:                 THIS.edt_4c_Infos.Value   = NVL(cursor_4c_Carac.infos, "")
466:             ELSE
467:                 THIS.txt_4c_Comples.Value = ""
468:                 THIS.edt_4c_Infos.Value   = ""
469:             ENDIF
470: 
471:         CATCH TO loc_oErro
472:             MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
473:                     "Erro ao carregar dados")
474:         ENDTRY
475:     ENDPROC
476: 
477:     *---------------------------------------------------------------------------
478:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
479:     *-- Form plano (sem PageFrame) - nao aplica alternancia de paginas
480:     *---------------------------------------------------------------------------
481:         RETURN
482:     ENDPROC
483: 
484:     *---------------------------------------------------------------------------
485:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
486:     *-- Atualiza campos Comples e Infos ao navegar no grid de caracteristicas
487:     *-- PUBLIC: obrigatorio para BINDEVENT (AfterRowColChange)
488:     *-- Equivalente ao GradeCarac.AfterRowColChange do SIGPRPRO.SCX
489:     *---------------------------------------------------------------------------
490:         IF USED("cursor_4c_Carac") AND !EOF("cursor_4c_Carac")
491:             THIS.txt_4c_Comples.Value = NVL(cursor_4c_Carac.compls, "")
492:             THIS.edt_4c_Infos.Value   = NVL(cursor_4c_Carac.infos, "")
493:         ENDIF
494:     ENDPROC
495: 
496:     *---------------------------------------------------------------------------
497:     PROCEDURE CmdOkClick()
498:     *-- Fecha o form de caracteristicas de produto
499:     *-- PUBLIC: obrigatorio para BINDEVENT (Click)
500:     *-- Equivalente ao Ok.Click do SIGPRPRO.SCX
501:     *---------------------------------------------------------------------------
502:         THIS.Release()
503:     ENDPROC
504: 
505:     *---------------------------------------------------------------------------
506:     PROCEDURE BtnIncluirClick()
507:     *-- Popup somente-leitura (SIGPRPRO.SCX legado nao tem CRUD).

*-- Linhas 533 a 553:
533: 
534:         TRY
535:             IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
536:                 THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
537:                 THIS.CarregarDados()
538:                 IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
539:                     THIS.grd_4c_Dados.Refresh()
540:                 ENDIF
541:             ELSE
542:                 MsgAviso("Nenhum produto carregado para visualiza" + CHR(231) + CHR(227) + "o.", ;
543:                          "Visualizar")
544:             ENDIF
545:         CATCH TO loc_oErro
546:             MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
547:                     "Erro ao visualizar")
548:         ENDTRY
549:     ENDPROC
550: 
551:     *---------------------------------------------------------------------------
552:     PROCEDURE BtnExcluirClick()
553:     *-- Popup somente-leitura - exclusao nao permitida neste contexto.

*-- Linhas 567 a 601:
567: 
568:         TRY
569:             IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
570:                 THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
571:                 THIS.CarregarDados()
572:                 IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
573:                     THIS.grd_4c_Dados.Refresh()
574:                 ENDIF
575:             ELSE
576:                 MsgAviso("Nenhum produto carregado para busca.", "Buscar")
577:             ENDIF
578:         CATCH TO loc_oErro
579:             MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;
580:                     "Erro ao buscar")
581:         ENDTRY
582:     ENDPROC
583: 
584:     *---------------------------------------------------------------------------
585:     PROCEDURE BtnEncerrarClick()
586:     *-- Fecha o popup (equivalente ao cmd_4c_Ok / botao Encerrar canonico).
587:     *---------------------------------------------------------------------------
588:         THIS.Release()
589:     ENDPROC
590: 
591:     *---------------------------------------------------------------------------
592:     PROCEDURE BtnSalvarClick()
593:     *-- Formulario somente-leitura - salvar nao disponivel neste contexto.
594:     *---------------------------------------------------------------------------
595:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
596:                  "Nenhuma altera" + CHR(231) + CHR(227) + "o pode ser salva.", ;
597:                  "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
598:     ENDPROC
599: 
600:     *---------------------------------------------------------------------------
601:     PROCEDURE BtnCancelarClick()

*-- Linhas 631 a 652:
631:         IF PEMSTATUS(THIS, "txt_4c_DPros", 5)
632:             THIS.txt_4c_DPros.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDPros, ""))
633:         ENDIF
634: 
635:         IF PEMSTATUS(THIS, "txt_4c_Comples", 5)
636:             IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
637:                 SELECT cursor_4c_Carac
638:                 GO TOP
639:                 THIS.txt_4c_Comples.Value = NVL(ALLTRIM(compls), "")
640:                 THIS.edt_4c_Infos.Value   = NVL(infos, "")
641:             ELSE
642:                 THIS.txt_4c_Comples.Value = ""
643:                 THIS.edt_4c_Infos.Value   = ""
644:             ENDIF
645:         ENDIF
646:     ENDPROC
647: 
648:     *---------------------------------------------------------------------------
649:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
650:     *-- Formulario somente-leitura: ignora o parametro.
651:     *-- Todos os campos permanecem desabilitados (When=.F. no legado).
652:     *-- O unico controle interativo eh o grid e o botao OK.


### BO (C:\4c\projeto\app\classes\SIGPRPROBO.prg):
*==============================================================================
* SIGPRPROBO.prg - Business Object: Caracteristicas de Produtos
* Tabela principal : SigPrCrr
* Form OPERACIONAL - somente leitura (viewer de caracteristicas por produto)
* Fase 2/8: Metodos CRUD (BuscarDadosProduto, BuscarCaracteristicas,
*            CarregarDoCursor, ObterChavePrimaria)
*==============================================================================
DEFINE CLASS SIGPRPROBO AS BusinessBase

  *-- SigCdPro
  this_cCPros   = ""   && cpros char(14) - codigo do produto (FK SigCdPro)
  this_cDPros   = ""   && dpros char(65) - descricao do produto

  *-- SigPrCrr
  this_cCidChaves  = ""   && cidchaves  char(20) - chave PK da caracteristica
  this_cCaracteris = ""   && caracteris char(40) - texto da caracteristica
  this_cCompls     = ""   && compls     char(40) - complemento
  this_cInfos      = ""   && infos      text     - informacoes detalhadas (memo)

  *----------------------------------------------------------------------------
  PROCEDURE Init()
    THIS.this_cTabela     = "SigPrCrr"
    THIS.this_cCampoChave = "cidchaves"
    DODEFAULT()
  ENDPROC

  *----------------------------------------------------------------------------
  * BuscarDadosProduto - Carrega descricao do produto em this_cDPros
  *   Equivale ao: SELECT DPros FROM SigCdPro WHERE CPros = pPro
  * Retorna .T. se encontrou, .F. se nao encontrou ou erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarDadosProduto(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProTemp")

      IF loc_nRet > 0 AND USED("cursor_4c_ProTemp") AND RECCOUNT("cursor_4c_ProTemp") > 0
        SELECT cursor_4c_ProTemp
        GO TOP
        THIS.this_cDPros = NVL(ALLTRIM(dpros), "")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cDPros = ""
      ENDIF

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * BuscarCaracteristicas - Carrega SigPrCrr no cursor_4c_Carac para o grid
  *   Equivale ao: CursorQuery('SigPrCrr', 'LocalCrPro', 'CPros', pPro)
  *   O cursor cursor_4c_Carac deve existir (criado no InicializarForm do Form)
  * Retorna .T. se sucesso, .F. se erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarCaracteristicas(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT cidchaves, caracteris, compls, infos " + ;
                 "FROM SigPrCrr " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + " " + ;
                 "ORDER BY cidchaves"

      IF USED("cursor_4c_CaracTemp")
        USE IN cursor_4c_CaracTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracTemp")

      IF loc_nRet >= 0
        IF USED("cursor_4c_Carac")
          TABLEREVERT(.T., "cursor_4c_Carac")
          SELECT cursor_4c_Carac
          ZAP
          IF USED("cursor_4c_CaracTemp") AND RECCOUNT("cursor_4c_CaracTemp") > 0
            APPEND FROM DBF("cursor_4c_CaracTemp")
          ENDIF
          GO TOP IN cursor_4c_Carac
        ENDIF

        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF

        loc_lSucesso = .T.
      ELSE
        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF
        MsgErro("Erro ao consultar caracter" + CHR(237) + "sticas do produto.", "Erro")
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
  *   par_cAliasCursor: nome do alias do cursor (ex: "cursor_4c_Carac")
  * Retorna .T. se sucesso, .F. caso contrario
  *----------------------------------------------------------------------------
  FUNCTION CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso, loc_oErro

    loc_lSucesso = .F.

    TRY
      IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
        SELECT (par_cAliasCursor)
        THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
        THIS.this_cCaracteris = NVL(ALLTRIM(caracteris), "")
        THIS.this_cCompls     = NVL(ALLTRIM(compls), "")
        THIS.this_cInfos      = NVL(ALLTRIM(infos), "")
        loc_lSucesso = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ObterChavePrimaria - Retorna valor da chave primaria (cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ObterChavePrimaria()
    RETURN ALLTRIM(THIS.this_cCidChaves)
  ENDFUNC

  *----------------------------------------------------------------------------
  * ValidarDados - Valida campos obrigatorios de SigPrCrr
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ValidarDados()
    LOCAL loc_lValido

    loc_lValido = .T.
    THIS.this_cMensagemErro = ""

    IF EMPTY(ALLTRIM(THIS.this_cCPros))
      THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto (cpros) " + CHR(233) + " obrigat" + CHR(243) + "rio."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCidChaves))
      THIS.this_cMensagemErro = "Chave da caracter" + CHR(237) + "stica (cidchaves) " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCaracteris))
      THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    RETURN loc_lValido
  ENDFUNC

  *----------------------------------------------------------------------------
  * Inserir - Insere novo registro em SigPrCrr
  *   Colunas: caracteris char(40), cidchaves char(20) PK, compls char(40),
  *            cpros char(14), infos text NULL
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Inserir()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "INSERT INTO SigPrCrr (caracteris, cidchaves, compls, cpros, infos) VALUES (" + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 EscaparSQL(ALLTRIM(THIS.this_cInfos)) + ")"

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet > 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao inserir caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * Atualizar - Atualiza registro existente em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Atualizar()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "UPDATE SigPrCrr SET " + ;
                 "caracteris = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 "compls = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 "cpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 "infos = " + EscaparSQL(ALLTRIM(THIS.this_cInfos)) + " " + ;
                 "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao atualizar caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ExecutarExclusao - Deleta registro em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ExecutarExclusao()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "DELETE FROM SigPrCrr WHERE cidchaves = " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao excluir caracter" + CHR(237) + "stica do SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

ENDDEFINE

