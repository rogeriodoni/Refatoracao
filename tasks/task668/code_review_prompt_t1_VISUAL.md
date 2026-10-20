# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Ok' (parent: SIGPRPRO): Left original=723 vs migrado 'cmd_4c_Ok' Left=904 (diff=181px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (864 linhas total):

*-- Linhas 169 a 178:
169: 
170:             *-- Criar componentes visuais
171:             THIS.ConfigurarCabecalho()
172:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
173:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
174: 
175:             *-- Criar area de exibicao do produto (shapes decorativos + codigo)
176:             THIS.ConfigurarPaginaLista()
177:             *-- Criar area de conteudo (grid + complemento + memo + botao OK)
178:             THIS.ConfigurarPaginaDados()

*-- Linhas 212 a 265:
212: 
213:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
214:         WITH THIS.cnt_4c_Cabecalho
215:             .Top         = 0
216:             .Left        = 0
217:             .Width       = THIS.Width
218:             .Height      = 96
219:             .BackStyle   = 1
220:             .BackColor   = RGB(100, 100, 100)
221:             .BorderWidth = 0
222:             .Visible     = .T.
223:         ENDWITH
224: 
225:         *-- Label sombra (efeito de sombra no texto do titulo)
226:         *-- Original: Top=25, Left=10, FontSize=18, ForeColor=0,0,0 -> sombra preta
227:         loc_oCab = THIS.cnt_4c_Cabecalho
228:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
229:         WITH loc_oCab.lbl_4c_Sombra
230:             .Top       = 30
231:             .Left      = 12
232:             .Width     = loc_oCab.Width - 140
233:             .Height    = 48
234:             .FontName  = "Tahoma"
235:             .FontSize  = 18
236:             .FontBold  = .T.
237:             .AutoSize  = .F.
238:             .WordWrap  = .T.
239:             .BackStyle = 0
240:             .ForeColor = RGB(0, 0, 0)
241:             .Caption   = THIS.Caption
242:             .Visible   = .T.
243:         ENDWITH
244: 
245:         *-- Label titulo (texto principal branco sobre a sombra)
246:         *-- Original: Top=24, Left=10, FontSize=18, ForeColor=255,255,255
247:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
248:         WITH loc_oCab.lbl_4c_Titulo
249:             .Top       = 29
250:             .Left      = 12
251:             .Width     = loc_oCab.Width - 140
252:             .Height    = 55
253:             .FontName  = "Tahoma"
254:             .FontSize  = 18
255:             .FontBold  = .T.
256:             .AutoSize  = .F.
257:             .WordWrap  = .T.
258:             .BackStyle = 0
259:             .ForeColor = RGB(255, 255, 255)
260:             .Caption   = THIS.Caption
261:             .Visible   = .T.
262:         ENDWITH
263:     ENDPROC
264: 
265:     *---------------------------------------------------------------------------

*-- Linhas 304 a 327:
304:         *-- Original: Top=7, Left=697, Width=90, Height=110
305:         THIS.AddObject("shp_4c_Shape", "Shape")
306:         WITH THIS.shp_4c_Shape
307:             .Top         = 8
308:             .Left        = 871
309:             .Width       = 113
310:             .Height      = 132
311:             .BackStyle   = 0
312:             .BorderStyle = 0
313:             .BorderColor = RGB(136, 189, 188)
314:             .Visible     = .T.
315:         ENDWITH
316: 
317:         *-- Borda da area de codigo do produto
318:         *-- Original: shpCodigo - Top=94, Left=13, Width=671, Height=34
319:         THIS.AddObject("shp_4c_ShpCodigo", "Shape")
320:         WITH THIS.shp_4c_ShpCodigo
321:             .Top           = 113
322:             .Left          = 16
323:             .Width         = 839
324:             .Height        = 41
325:             .BackStyle     = 0
326:             .Curvature     = 0
327:             .SpecialEffect = 1

*-- Linhas 333 a 342:
333:         *-- Original: Shape1 - Top=133, Left=13, Width=671, Height=341
334:         THIS.AddObject("shp_4c_Shape1", "Shape")
335:         WITH THIS.shp_4c_Shape1
336:             .Top           = 160
337:             .Left          = 16
338:             .Width         = 839
339:             .Height        = 409
340:             .BackStyle     = 0
341:             .Curvature     = 0
342:             .SpecialEffect = 1

*-- Linhas 352 a 381:
352:         *-- (fx=1.25 / fy=1.2) - esses numeros JA SAO o auto-size que o Form
353:         *-- Designer calculou, logo fixa-los reproduz o legado.
354:         *-- Alignment fica no default 0 (esquerda), como a classe `say` do legado.
355:         THIS.AddObject("lbl_4c_Label1", "Label")
356:         WITH THIS.lbl_4c_Label1
357:             .Top       = 124
358:             .Left      = 31
359:             .Width     = 59
360:             .Height    = 18
361:             .FontName  = "Tahoma"
362:             .FontSize  = 8
363:             .FontBold  = .F.
364:             .AutoSize  = .F.
365:             .BackStyle = 0
366:             .Caption   = "Produto :"
367:             .ForeColor = RGB(90, 90, 90)
368:             .Visible   = .T.
369:         ENDWITH
370: 
371:         *-- Campo codigo do produto (somente leitura - Enabled=.F.)
372:         *-- Original: getCPros - Top=99, Left=75, Width=108, Enabled=.F.
373:         THIS.AddObject("txt_4c_CPros", "TextBox")
374:         WITH THIS.txt_4c_CPros
375:             .Top               = 119
376:             .Left              = 94
377:             .Width             = 135
378:             .Height            = 28
379:             .Value             = THIS.this_cCPros
380:             .Enabled           = .F.
381:             .DisabledBackColor = RGB(255, 255, 230)

*-- Linhas 399 a 408:
399:         *-- Original: getDPros - Top=99, Left=184, Width=494, Enabled=.F.
400:         THIS.AddObject("txt_4c_DPros", "TextBox")
401:         WITH THIS.txt_4c_DPros
402:             .Top               = 119
403:             .Left              = 230
404:             .Width             = 618
405:             .Height            = 28
406:             .Value             = ""
407:             .Enabled           = .F.
408:             .Format            = "K!"

*-- Linhas 418 a 427:
418:         *-- Original: GradeCarac - Top=139, Left=20, Width=319, Height=328, ColumnCount=1
419:         THIS.AddObject("grd_4c_Dados", "Grid")
420:         WITH THIS.grd_4c_Dados
421:             .Top                = 167
422:             .Left               = 25
423:             .Width              = 399
424:             .Height             = 394
425:             .ColumnCount        = 1
426:             .ReadOnly           = .F.
427:             .RecordMark         = .F.

*-- Linhas 449 a 457:
449:         WITH loc_oGrd.Column1.Header1
450:             .FontName  = "Tahoma"
451:             .Alignment = 2
452:             .Caption   = "Caracter" + CHR(237) + "sticas"
453:             .ForeColor = RGB(90, 90, 90)
454:         ENDWITH
455: 
456:         *-- Text1 da coluna (controle que a Column realmente DESENHA na celula).
457:         *-- Transcrito do dump: SIGPRPRO.GradeCarac.Column1.Text1 declara

*-- Linhas 474 a 483:
474:         *-- Original: getComples - Top=139, Left=348, Width=329, Height=23
475:         THIS.AddObject("txt_4c_Comples", "TextBox")
476:         WITH THIS.txt_4c_Comples
477:             .Top         = 167
478:             .Left        = 435
479:             .Width       = 411
480:             .Height      = 28
481:             .Value       = ""
482:             .ReadOnly    = .T.
483:             .FontName    = "Tahoma"

*-- Linhas 490 a 499:
490:         *-- Original: GetMemo (fwmemo/editbox) - Top=167, Left=348, Width=329, Height=300
491:         THIS.AddObject("edt_4c_Infos", "EditBox")
492:         WITH THIS.edt_4c_Infos
493:             .Top        = 200
494:             .Left       = 435
495:             .Width      = 411
496:             .Height     = 360
497:             .Value      = ""
498:             .ReadOnly   = .T.
499:             .FontName   = "Tahoma"

*-- Linhas 507 a 552:
507:         *-- Left ESCALADO: 723 * (1000/800) = 904. O legado desenha este botao
508:         *-- DENTRO do Shape decorativo (legado 697..787; migrado 871..984); com o
509:         *-- 723 cru do SCX o botao caia em 723..798, FORA da moldura e por cima do
510:         *-- lbl_4c_Titulo. Top permanece 4 (= 3 * 1.2), acima da moldura, como no
511:         *-- legado (Ok.Top=3 < Shape.Top=7).
512:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
513:         WITH THIS.cmd_4c_Ok
514:             .Top             = 4
515:             .Left            = 904
516:             .Width           = 75
517:             .Height          = 75
518:             .Caption         = "OK"
519:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
520:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
521:             .FontName        = "Tahoma"
522:             .FontSize        = 8
523:             .FontBold        = .T.
524:             .FontItalic      = .T.
525:             .ForeColor       = RGB(90, 90, 90)
526:             .BackColor       = RGB(255, 255, 255)
527:             .Themes          = .T.
528:             .SpecialEffect   = 0
529:             .PicturePosition = 13
530:             .MousePointer    = 15
531:             .WordWrap        = .T.
532:             .Visible         = .T.
533:         ENDWITH
534: 
535:         *-- Vincular eventos (metodos devem ser PUBLIC para BINDEVENT)
536:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
537:         BINDEVENT(THIS.cmd_4c_Ok,    "Click",             THIS, "CmdOkClick")
538:     ENDPROC
539: 
540:     *---------------------------------------------------------------------------
541:     PROCEDURE CarregarDados()
542:     *-- Popula grid de caracteristicas e campos de exibicao
543:     *---------------------------------------------------------------------------
544:         LOCAL loc_oGrd, loc_oErro
545: 
546:         TRY
547:             *-- Descricao do produto (legado: .getDPros.Value = LocalPro.DPros,
548:             *   logo apos o Select DPros From SigCdPro do Init)
549:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
550:                 THIS.this_oBusinessObject.BuscarProduto(THIS.this_cCPros)
551:                 THIS.txt_4c_DPros.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDPros, ""))
552:             ENDIF

*-- Linhas 618 a 626:
618:         WITH loc_oGrd.Column1.Header1
619:             .FontName  = "Tahoma"
620:             .Alignment = 2
621:             .Caption   = "Caracter" + CHR(237) + "sticas"
622:             .ForeColor = RGB(90, 90, 90)
623:         ENDWITH
624:         WITH loc_oGrd.Column1.Text1
625:             .FontName    = "Tahoma"
626:             .FontSize    = 8

*-- Linhas 755 a 775:
755:         THIS.RecarregarConsulta("Buscar")
756:     ENDPROC
757: 
758:     *---------------------------------------------------------------------------
759:     PROCEDURE BtnEncerrarClick()
760:     *-- Fecha o popup (equivalente ao cmd_4c_Ok / botao Encerrar canonico).
761:     *---------------------------------------------------------------------------
762:         THIS.Release()
763:     ENDPROC
764: 
765:     *---------------------------------------------------------------------------
766:     PROCEDURE BtnSalvarClick()
767:     *-- Formulario somente-leitura - salvar nao disponivel neste contexto.
768:     *---------------------------------------------------------------------------
769:         MsgAviso("Este formul" + CHR(225) + "rio " + CHR(233) + " apenas de consulta." + CHR(13) + ;
770:                  "Nenhuma altera" + CHR(231) + CHR(227) + "o pode ser salva.", ;
771:                  "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
772:     ENDPROC
773: 
774:     *---------------------------------------------------------------------------
775:     PROCEDURE BtnCancelarClick()


### BO (C:\4c\projeto\app\classes\SIGPRPROBO.prg):
*==============================================================================
* SIGPRPROBO.prg
*
* Business Object para "Caracteristicas de Produtos" (form OPERACIONAL)
* Origem legado  : SIGPRPRO.SCX (tasks\task668)
*
* Tabela principal : SigPrCrr  (PK: cidchaves char(20); FK: cpros char(14))
*   caracteris char(40) NOT NULL - texto da caracteristica (coluna da grade)
*   cidchaves  char(20) NOT NULL - chave primaria (padrao Fortyus)
*   compls     char(40) NOT NULL - complemento da caracteristica
*   cpros      char(14) NOT NULL - codigo do produto (FK SigCdPro.cpros)
*   infos      text     NULL     - informacoes detalhadas (memo)
*
* Tabela de apoio  : SigCdPro  (cpros char(14) / dpros char(65))
*   Usada apenas para exibir a descricao do produto no cabecalho da tela,
*   reproduzindo o "Select DPros From SigCdPro Where CPros = ..." do Init legado.
*
* Herda de: BusinessBase
*
* NATUREZA DO FORM: visualizador. O SIGPRPRO legado apenas consulta
* (SqlExecute em LocalPro + CursorQuery em LocalCrPro) e o unico botao da tela
* ("Ok") fecha os cursores e libera o form - nao existe Insert, Update nem
* Delete no codigo legado. Por isso as operacoes de gravacao do BusinessBase
* NAO sao sobrescritas: o comportamento padrao herdado da classe base (recusar
* a operacao) ja eh o correto para esta tela.
*
* Fase 1/8: declaracao de propriedades + Init()
*==============================================================================

DEFINE CLASS SIGPRPROBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigPrCrr (colunas do banco)
    *==========================================================================
    this_cCidChaves  = ""    && cidchaves  char(20) - PK (chave unica Fortyus)
    this_cCaracteris = ""    && caracteris char(40) - caracteristica (grade)
    this_cCompls     = ""    && compls     char(40) - complemento
    this_cInfos      = ""    && infos      text     - informacoes (memo)
    this_cCPros      = ""    && cpros      char(14) - produto (FK SigCdPro)

    *==========================================================================
    * Propriedade de apoio (SigCdPro) - somente exibicao, nao gravada
    *==========================================================================
    this_cDPros      = ""    && dpros      char(65) - descricao do produto

    *==========================================================================
    * Aliases dos cursores usados pela tela
    *   this_cCursorCarac   - alias ligado a grade de caracteristicas
    *                         (equivale ao LocalCrPro do legado)
    *   this_cCursorProduto - alias com a descricao do produto
    *                         (equivale ao LocalPro do legado)
    *==========================================================================
    this_cCursorCarac   = "cursor_4c_Carac"
    this_cCursorProduto = "cursor_4c_Produto"

    *==========================================================================
    * Contador de caracteristicas carregadas na ultima consulta
    *==========================================================================
    this_nQtdeCarac  = 0

    *==========================================================================
    * Init - Configura tabela principal e campo chave do Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigPrCrr"
            THIS.this_cCampoChave = "cidchaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGPRPROBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a caracteristica da linha corrente do cursor
    * da grade (equivale ao AfterRowColChange do legado, que copia
    * LocalCrPro.Infos/Compls para os campos de detalhe ao mudar de linha)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
            THIS.this_cCaracteris = TratarNulo(caracteris, "")
            THIS.this_cCompls     = TratarNulo(compls, "")
            THIS.this_cCPros      = TratarNulo(cpros, "")
            THIS.this_cInfos      = TratarNulo(infos, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarProduto - Reproduz o "Select DPros From SigCdPro Where CPros = ..."
    * do Init() legado. Carrega a descricao do produto exibida no cabecalho
    * da tela (campo getDPros, Enabled = .F. no SCX - somente leitura).
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCPros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cCPros = PADR(ALLTRIM(TratarNulo(par_cCPros, "")), 14)

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorProduto) (DPros C(65))
                SET NULL OFF
                THIS.this_cDPros = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DPros FROM SigCdPro WHERE CPros = " + ;
                           EscaparSQL(THIS.this_cCPros)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

                IF loc_nResultado > 0
                    SELECT (THIS.this_cCursorProduto)
                    GO TOP IN (THIS.this_cCursorProduto)
                    THIS.this_cDPros = TratarNulo(DPros, "")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cDPros = ""
                    MostrarErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalPro)")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRPROBO.BuscarProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarCaracteristicas - Reproduz o
    * ThisForm.ParentForm.poDataMgr.CursorQuery('SigPrCrr','LocalCrPro',
    * 'CPros', pPro) do Init() legado. Popula o cursor ligado a grade
    * (GradeCarac/Column1.ControlSource = 'LocalCrPro.Caracteris').
    *==========================================================================
    PROCEDURE BuscarCaracteristicas(par_cCPros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCarac)
                USE IN (THIS.this_cCursorCarac)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorCarac) ;
                    (cidchaves C(20), caracteris C(40), compls C(40), ;
                     cpros C(14), infos M)
                SET NULL OFF
                THIS.this_nQtdeCarac = 0
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, caracteris, compls, cpros, infos" + ;
                           " FROM SigPrCrr" + ;
                           " WHERE CPros = " + ;
                           EscaparSQL(PADR(ALLTRIM(TratarNulo(par_cCPros, "")), 14))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCarac)

                IF loc_nResultado >= 0
                    THIS.this_nQtdeCarac = RECCOUNT(THIS.this_cCursorCarac)
                    IF THIS.this_nQtdeCarac > 0
                        GO TOP IN (THIS.this_cCursorCarac)
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_nQtdeCarac = 0
                    MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRPROBO.BuscarCaracteristicas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria do registro (PK Fortyus cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() - decisao de projeto
    *
    * O SIGPRPRO legado eh um visualizador de caracteristicas: o unico botao
    * da tela ("Ok") apenas fecha os cursores LocalPro/LocalCrPro e libera o
    * form. O dump do SCX nao tem nenhum Insert Into/Update/Delete From
    * contra tabela do SQL Server, e os tres controles digitaveis da tela
    * (GetMemo, getComples e o Text1 da coluna da grade) tem a PROCEDURE When
    * retornando .f., ou seja nunca recebem foco - a tela eh somente leitura
    * de ponta a ponta.
    *
    * Por isso Inserir() e Atualizar() NAO sao sobrescritos neste BO: o
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para esta tela, e inventar colunas de INSERT/UPDATE sem
    * lastro no legado violaria a regra de que a lista de colunas vem do
    * schema, nunca de suposicao.
    *==========================================================================

ENDDEFINE

