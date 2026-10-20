# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtam.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1798 linhas total):

*-- Linhas 11 a 19:
11: *   par_oFormPai     - referencia ao form pai (FormProduto), para
12: *                      desabilitar/reabilitar durante o dialogo modal
13: *   par_cEscolha     - modo do form pai: "INSERIR"/"ALTERAR"/"VISUALIZAR"
14: *                      (controla Visible/Enabled de cmd_4c_Inserir/Excluir -
15: *                      legado so permite incluir/excluir tamanho quando o
16: *                      produto esta sendo incluido ou alterado)
17: *   par_cCodProduto  - codigo do produto filtrado (SigCdPro.cPros)
18: *
19: * PILAR 3 (simplificacao de arquitetura): o legado tem DOIS caminhos de

*-- Linhas 261 a 269:
261:                     *-- (Column3/Column6)
262:                     THIS.InstalarCelulasGrade()
263: 
264:                     *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
265:                     *-- - criados DEPOIS do cabecalho para desenhar por cima dele
266:                     *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
267:                     THIS.ConfigurarBotoes()
268: 
269:                     *-- AddObject cria controles com Visible=.F. por padrao

*-- Linhas 295 a 348:
295:     * Equivalente: SIGPRTAM.cntSombra + lblSombra + lblTitulo
296:     * Regra #11/#12: Width = THIS.Width (nao o literal do SCX, que excede o
297:     * form); label Width = THIS.Width - 20 para nao clipar o titulo.
298:     *--------------------------------------------------------------------------
299:     PROTECTED PROCEDURE ConfigurarCabecalho()
300:         THIS.AddObject("cnt_4c_Sombra", "Container")
301:         WITH THIS.cnt_4c_Sombra
302:             .Top         = 0
303:             .Left        = 0
304:             .Width       = THIS.Width
305:             .Height      = 80
306:             .BorderWidth = 0
307:             .BackStyle   = 1
308:             .BackColor   = RGB(100, 100, 100)
309:             .Visible     = .T.
310:         ENDWITH
311: 
312:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
313:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
314:             .AutoSize      = .F.
315:             .FontBold      = .T.
316:             .FontName      = "Tahoma"
317:             .FontSize      = 18
318:             .FontUnderline = .F.
319:             .WordWrap      = .T.
320:             .Alignment     = 0
321:             .BackStyle     = 0
322:             .Caption       = THIS.Caption
323:             .Height        = 40
324:             .Left          = 10
325:             .Top           = 25
326:             .Width         = THIS.Width - 20
327:             .ForeColor     = RGB(0, 0, 0)
328:             .Visible       = .T.
329:         ENDWITH
330: 
331:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
332:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
333:             .AutoSize      = .F.
334:             .FontBold      = .T.
335:             .FontName      = "Tahoma"
336:             .FontSize      = 18
337:             .WordWrap      = .T.
338:             .Alignment     = 0
339:             .BackStyle     = 0
340:             .Caption       = THIS.Caption
341:             .Height        = 46
342:             .Left          = 10
343:             .Top           = 24
344:             .Width         = THIS.Width - 20
345:             .ForeColor     = RGB(255, 255, 255)
346:             .ToolTipText   = "T" + CHR(237) + "tulo"
347:             .Visible       = .T.
348:         ENDWITH

*-- Linhas 368 a 377:
368: 
369:         THIS.AddObject("shp_4c_Shape1", "Shape")
370:         WITH THIS.shp_4c_Shape1
371:             .Top         = 12
372:             .Left        = 372
373:             .Height      = 110
374:             .Width       = 256
375:             .BackStyle   = 0
376:             .BorderStyle = 0
377:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 387 a 396:
387:     PROTECTED PROCEDURE ConfigurarGrid()
388:         THIS.AddObject("grd_4c_Dados", "Grid")
389:         WITH THIS.grd_4c_Dados
390:             .Top                = 111
391:             .Left               = 9
392:             .Width              = 620
393:             .Height             = 394
394:             .FontName           = "Tahoma"
395:             .FontSize           = 8
396:             .AllowHeaderSizing  = .F.

*-- Linhas 412 a 420:
412:             .Column1.Header1.FontName  = "Tahoma"
413:             .Column1.Header1.FontSize  = 8
414:             .Column1.Header1.Alignment = 2
415:             .Column1.Header1.Caption   = "Tam."
416:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
417:             .Column1.Text1.FontName    = "Tahoma"
418:             .Column1.Text1.FontSize    = 8
419:             .Column1.Text1.Margin      = 0
420:             .Column1.Text1.MaxLength   = 4

*-- Linhas 428 a 436:
428:             .Column2.Header1.FontName  = "Tahoma"
429:             .Column2.Header1.FontSize  = 8
430:             .Column2.Header1.Alignment = 2
431:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
432:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
433:             .Column2.Text1.FontName    = "Tahoma"
434:             .Column2.Text1.FontSize    = 8
435:             .Column2.Text1.Margin      = 0
436:             .Column2.Text1.MaxLength   = 20

*-- Linhas 444 a 452:
444:             .Column3.Header1.FontName  = "Tahoma"
445:             .Column3.Header1.FontSize  = 8
446:             .Column3.Header1.Alignment = 2
447:             .Column3.Header1.Caption   = "Peso M" + CHR(233) + "dio"
448:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
449:             .Column3.Text1.FontName    = "Tahoma"
450:             .Column3.Text1.FontSize    = 8
451: 
452:             *-- Column4 = Percs (numeric(5,2))

*-- Linhas 459 a 467:
459:             .Column4.Header1.FontName  = "Tahoma"
460:             .Column4.Header1.FontSize  = 8
461:             .Column4.Header1.Alignment = 2
462:             .Column4.Header1.Caption   = "Percentual"
463:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
464:             .Column4.Text1.FontName    = "Tahoma"
465:             .Column4.Text1.FontSize    = 8
466:             .Column4.Text1.BorderStyle = 0
467:             .Column4.Text1.Margin      = 0

*-- Linhas 478 a 486:
478:             .Column5.Header1.FontName  = "Tahoma"
479:             .Column5.Header1.FontSize  = 8
480:             .Column5.Header1.Alignment = 2
481:             .Column5.Header1.Caption   = "Valor"
482:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
483:             .Column5.Text1.FontName    = "Tahoma"
484:             .Column5.Text1.FontSize    = 8
485:             .Column5.Text1.BorderStyle = 0
486:             .Column5.Text1.Margin      = 0

*-- Linhas 497 a 505:
497:             .Column6.Header1.FontName  = "Tahoma"
498:             .Column6.Header1.FontSize  = 8
499:             .Column6.Header1.Alignment = 2
500:             .Column6.Header1.Caption   = "Entrega"
501:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
502:             .Column6.Text1.FontName    = "Tahoma"
503:             .Column6.Text1.FontSize    = 8
504:             .Column6.Text1.BorderStyle = 0
505:             .Column6.Text1.Margin      = 0

*-- Linhas 1361 a 1379:
1361:             *-- RecordSource/ControlSource resetam Width e Header1.Caption -
1362:             *-- reconfigurar SEMPRE depois de vincular (regra #48)
1363:             THIS.grd_4c_Dados.Column1.Width           = 38
1364:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Tam."
1365:             THIS.grd_4c_Dados.Column2.Width           = 216
1366:             THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1367:             THIS.grd_4c_Dados.Column3.Width           = 100
1368:             THIS.grd_4c_Dados.Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
1369:             THIS.grd_4c_Dados.Column4.Width           = 80
1370:             THIS.grd_4c_Dados.Column4.Header1.Caption = "Percentual"
1371:             THIS.grd_4c_Dados.Column5.Width           = 100
1372:             THIS.grd_4c_Dados.Column5.Header1.Caption = "Valor"
1373:             THIS.grd_4c_Dados.Column6.Width           = 60
1374:             THIS.grd_4c_Dados.Column6.Header1.Caption = "Entrega"
1375: 
1376:             *-- Re-vincular RecordSource/ControlSource reseta propriedades de
1377:             *-- Column - CurrentControl e Sparse entre elas. Sem reinstalar,
1378:             *-- a coluna volta a desenhar o Text1 nativo e o When/Valid das
1379:             *-- celulas (lookup de Tamanho, calculo Percentual<->Valor) para

*-- Linhas 1558 a 1566:
1558:     * PUBLIC - alvo de BINDEVENT (regra #3)
1559:     *--------------------------------------------------------------------------
1560:     PROCEDURE BtnSairClick()
1561:         IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
1562:            INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1563: 
1564:             IF USED("cursor_4c_Dados")
1565:                 SELECT cursor_4c_Dados
1566:                 SCAN

*-- Linhas 1617 a 1631:
1617:         LOCAL loc_cIcones
1618:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
1619: 
1620:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
1621:         WITH THIS.cmd_4c_Inserir
1622:             .Top             = 3
1623:             .Left            = 413
1624:             .Width           = 75
1625:             .Height          = 75
1626:             .Caption         = "Inserir"
1627:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
1628:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
1629:             .Themes          = .T.
1630:             .TabIndex        = 9
1631:             .FontName        = "Comic Sans MS"

*-- Linhas 1640 a 1656:
1640:             .WordWrap        = .T.
1641:             .AutoSize        = .F.
1642:         ENDWITH
1643:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "BtnInserirClick")
1644: 
1645:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1646:         WITH THIS.cmd_4c_Excluir
1647:             .Top             = 3
1648:             .Left            = 488
1649:             .Width           = 75
1650:             .Height          = 75
1651:             .Caption         = "Excluir"
1652:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
1653:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
1654:             .Themes          = .T.
1655:             .TabIndex        = 7
1656:             .FontName        = "Comic Sans MS"

*-- Linhas 1665 a 1681:
1665:             .WordWrap        = .T.
1666:             .AutoSize        = .F.
1667:         ENDWITH
1668:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
1669: 
1670:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
1671:         WITH THIS.cmd_4c_Sair
1672:             .Top             = 3
1673:             .Left            = 563
1674:             .Width           = 75
1675:             .Height          = 75
1676:             .Caption         = "Encerrar"
1677:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
1678:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
1679:             .Themes          = .T.
1680:             .Cancel          = .T.
1681:             .TabIndex        = 8

*-- Linhas 1691 a 1720:
1691:             .WordWrap        = .T.
1692:             .AutoSize        = .F.
1693:         ENDWITH
1694:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * AjustarVisibilidadePorModo - Espelha llVis = InList(.pcEscolha,
1699:     * 'INSERIR','ALTERAR') do Init legado. Em modo VISUALIZAR, Inserir/
1700:     * Excluir ficam ocultos e o Shape1 decorativo encolhe para abracar so o
1701:     * botao Sair (legado: Shape1.Width = cmdSair.Width+10 / Shape1.Left =
1702:     * cmdSair.Left-5).
1703:     *--------------------------------------------------------------------------
1704:     PROTECTED PROCEDURE AjustarVisibilidadePorModo()
1705:         LOCAL loc_lVis
1706:         loc_lVis = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
1707: 
1708:         THIS.cmd_4c_Inserir.Visible = loc_lVis
1709:         THIS.cmd_4c_Excluir.Visible = loc_lVis
1710: 
1711:         THIS.HabilitarCampos(loc_lVis)
1712: 
1713:         IF !loc_lVis
1714:             THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
1715:             THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
1716:         ENDIF
1717:     ENDPROC
1718: 
1719:     *--------------------------------------------------------------------------
1720:     * HabilitarCampos - Liga/desliga a superficie EDITAVEL da tela:

*-- Linhas 1730 a 1752:
1730:         LOCAL loc_lHab
1731:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .F.)
1732: 
1733:         THIS.cmd_4c_Inserir.Enabled = loc_lHab
1734:         THIS.cmd_4c_Excluir.Enabled = loc_lHab
1735: 
1736:         *-- Grid.ReadOnly propaga para as Columns e SOBRESCREVE o ReadOnly
1737:         *-- delas - tem de ser definido ANTES (CLAUDE.md regra #18)
1738:         THIS.grd_4c_Dados.ReadOnly         = .F.
1739:         THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHab
1740:         THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lHab
1741:         THIS.grd_4c_Dados.Column3.ReadOnly = !loc_lHab
1742:         THIS.grd_4c_Dados.Column4.ReadOnly = !loc_lHab
1743:         THIS.grd_4c_Dados.Column5.ReadOnly = !loc_lHab
1744:         THIS.grd_4c_Dados.Column6.ReadOnly = !loc_lHab
1745: 
1746:         *-- Encerrar nunca desabilita: eh o unico caminho de saida desta tela
1747:         THIS.cmd_4c_Sair.Enabled = .T.
1748:     ENDPROC
1749: 
1750:     *--------------------------------------------------------------------------
1751:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
1752:     * padrao; percorre recursivamente form/containers tornando tudo visivel.


### BO (C:\4c\projeto\app\classes\sigprtamBO.prg):
*==============================================================================
* sigprtamBO.prg - Business Object para Tamanhos do Produto (SIGPRTAM)
* Tabela Principal: SigPrTam (PK: cidchaves)
* Tabela Relacionada: SigCdTam (cadastro de tamanhos - cods/descs/varias)
*
* SIGPRTAM e um dialogo filho chamado pelo cadastro de produtos para
* manter a grade de tamanhos (codigo, descricao, peso medio, percentual,
* valor e prazo de entrega) de UM produto por vez (filtro por cpros).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Propriedades: SigPrTam
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCodTams    = ""   && codtams   char(4)  NOT NULL - FK SigCdTam.cods
    this_cCpros      = ""   && cpros     char(14) NOT NULL - FK SigCdPro.cPros (produto filtrado)
    this_dDataAlts   = {}   && dataalts  datetime NULL
    this_dDataTrans  = {}   && datatrans datetime NULL
    this_dDtMovs     = {}   && dtmovs    datetime NULL
    this_nPesoMs     = 0    && pesoms    numeric(7,3) NOT NULL - peso medio do tamanho
    this_nPercs      = 0    && percs     numeric(5,2) NOT NULL - percentual sobre o preco de venda
    this_nValor      = 0    && valor     numeric(11,5) NOT NULL - valor calculado a partir do percentual
    this_nDiasPrz    = 0    && diasprz   numeric(2,0) NOT NULL - prazo de entrega em dias

    *-- Propriedade NAO persistida: descricao do tamanho (join com SigCdTam.descs)
    this_cDescs      = ""   && descs char(20) - vem de SigCdTam, exibida na grade

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor (cursor_4c_Dados, populado pelo Form a partir de SigPrTam)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCodTams   = TratarNulo(codtams,   "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDataAlts  = TratarNulo(dataalts,  {})
                THIS.this_dDataTrans = TratarNulo(datatrans, {})
                THIS.this_dDtMovs    = TratarNulo(dtmovs,    {})
                THIS.this_nPesoMs    = TratarNulo(pesoms,    0)
                THIS.this_nPercs     = TratarNulo(percs,     0)
                THIS.this_nValor     = TratarNulo(valor,     0)
                THIS.this_nDiasPrz   = TratarNulo(diasprz,   0)

                * Descs vem de um JOIN com SigCdTam (nao existe na tabela
                * SigPrTam) - so esta presente quando o SELECT do Form a traz
                IF TYPE("descs") = "C"
                    THIS.this_cDescs = TratarNulo(descs, "")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigprtamBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria de SigPrTam (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTam (novo tamanho para o produto filtrado)
    * O legado gera a PK com fUniqueIds() no clique do botao Inserir, antes
    * de o usuario preencher qualquer coluna da grade (regra #22).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTam (cidchaves, codtams, cpros, dataalts, datatrans, dtmovs, pesoms, percs, valor, diasprz)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTam (cpros e cidchaves nao mudam depois do
    * Inserir - sao a chave e o filtro de origem do registro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTam
                SET codtams   = <<EscaparSQL(THIS.this_cCodTams)>>,
                    dataalts  = <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    datatrans = <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    dtmovs    = <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    pesoms    = <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    percs     = <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    valor     = <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    diasprz   = <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrTam (equivalente ao Delete do
    * cursor buferizado no cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTam WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca os tamanhos vinculados a um produto (par_cCpros).
    * Retorna cursor_4c_Dados com cidchaves/codtams/cpros/.../descs.
    *
    * NAO faz JOIN com SigCdTam para preencher descs: o legado tambem nao
    * faz (Init: "Select a.*, Space(40) as Descs From SigPrTam a Where
    * a.cPros = ...") - a descricao so e preenchida em runtime pelo lookup
    * da celula de Codigo/Descricao (Column1/Column2.Text1.Valid), nunca
    * pela carga inicial. Transcricao literal (CLAUDE.md regra #17).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codtams, cpros, dataalts, datatrans, dtmovs,
                       pesoms, percs, valor, diasprz, SPACE(20) AS descs
                FROM SigPrTam
                WHERE cpros = <<EscaparSQL(par_cCpros)>>
            ENDTEXT

            * SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            * (Inserir) e apagar (Excluir) linhas localmente, alem de editar
            * peso/percentual/valor/prazo, entao o resultado eh copiado para
            * um cursor READWRITE (CLAUDE.md: "Grid com coluna EDITAVEL
            * exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao buscar tamanhos do produto:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

