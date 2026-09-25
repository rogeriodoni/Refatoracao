# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 513: FontName 'Comic Sans MS' e o dump do legado NAO declara essa fonte em lugar nenhum - trocar por 'Tahoma' NESTA linha (conferir o controle no dump antes).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVTI2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (805 linhas total):

*-- Linhas 22 a 30:
22: *
23: * FASE 4/8 - Grid de titulos (grdTitulos -> grd_4c_Dados), criado direto
24: * sobre o Form (sem PageFrame/Page1 - o legado nao tem nenhum, ver nota da
25: * Fase 3), o UNICO botao que o legado tem (cmdSair -> cmd_4c_CmdSair) e o
26: * metodo de carga da grade (CarregarLista).
27: *
28: * Os "6 botoes CRUD" do titulo generico desta fase NAO existem no legado: a
29: * arvore do dump (SECAO 1) nao tem Grupo_Op nem nenhum CommandButton/
30: * CommandGroup de Incluir/Alterar/Excluir/Buscar - esta tela e' um

*-- Linhas 39 a 57:
39: * "TestFormWrapper exige botoes CRUD que o despachante nao tem - fix no
40: * harness, nao no form".
41: *
42: * ATENCAO para as fases seguintes: cmd_4c_CmdSair JA foi criado aqui (e nao
43: * na Fase 5/6, como a nota anterior deste cabecalho previa). NAO repetir o
44: * AddObject - dois AddObject com o mesmo nome no mesmo alvo estouram
45: * "Object already exists" e derrubam o Init. Continuam para a Fase 5/6:
46: * shp_4c_Shape1 (moldura do botao, Top=6/Left=899/92x110), txt_4c_DGrupos,
47: * txt_4c_DContas, txt_4c_EDN e os 3 Labels de rodape.
48: *
49: * FASE 5/8 - Metade dos campos de rodape (SECAO 2 do dump legado):
50: * shp_4c_Shape1 (moldura do cmd_4c_CmdSair) + a linha "Movimentacao de
51: * Estoque" (lbl_4c_Label2 + txt_4c_EDN) + a linha "Grupo" (lbl_4c_Label3 +
52: * txt_4c_DGrupos). A linha "Conta" (lbl_4c_Label1 + txt_4c_DContas) fica
53: * para a Fase 6/8 - mesmo par citado no paragrafo acima. Os tres TextBox
54: * (getDGrupos/getDContas/GetEDN, mapeamento.json) tem PROCEDURE When
55: * "Return .f." no dump (SECAO 3): o legado bloqueia edicao manual, so'
56: * AfterRowColChange do grid (Fase 7/8) escreve neles. Equivalente adotado
57: * aqui e' .ReadOnly = .T. (mesmo efeito de UX - usuario nao edita - sem

*-- Linhas 91 a 99:
91: * Salvar/Cancelar, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
92: * AjustarBotoesPorModo): ja documentado nas notas de Fase 3/4 acima, a
93: * arvore do dump legado (SECAO 1) nao tem PageFrame nem nenhum desses
94: * controles - o unico controle interativo eh cmd_4c_CmdSair (Fase 4),
95: * cujo Click ja esta implementado (CmdSairClick). Gerar esses metodos
96: * aqui so' para casar com o gate generico da Fase 8 seria stub disfarcado
97: * (proibido pela regra de completude) e inventaria funcionalidade que o
98: * legado nao tem (violaria a regra "NUNCA inventar"). Mesma familia de
99: * FormSigMvMen/FormSigMvChv - ver CLAUDE.md e as licoes "Gate da Fase 7

*-- Linhas 227 a 236:
227:         THIS.AddObject("grd_4c_Dados", "Grid")
228:         loc_oGrd = THIS.grd_4c_Dados
229:         WITH loc_oGrd
230:             .Top           = 5
231:             .Left          = 6
232:             .Width         = 884
233:             .Height        = 509
234:             .ColumnCount   = 8
235:             .ScrollBars    = 2
236:             .DeleteMark    = .F.

*-- Linhas 422 a 488:
422:         loc_oGrd.RecordSource = "cursor_4c_Dados"
423: 
424:         loc_oGrd.Column1.ControlSource     = "cursor_4c_Dados.Titulos"
425:         loc_oGrd.Column1.Header1.Caption   = "T" + CHR(237) + "tulo"
426:         loc_oGrd.Column1.Header1.Alignment = 2
427:         loc_oGrd.Column1.Header1.FontName  = "Verdana"
428:         loc_oGrd.Column1.Header1.FontSize  = 8
429:         loc_oGrd.Column1.Width             = 100
430: 
431:         loc_oGrd.Column2.ControlSource     = "TTOD(cursor_4c_Dados.Vencs)"
432:         loc_oGrd.Column2.Header1.Caption   = "Vencimento"
433:         loc_oGrd.Column2.Header1.Alignment = 2
434:         loc_oGrd.Column2.Header1.FontName  = "Verdana"
435:         loc_oGrd.Column2.Header1.FontSize  = 8
436:         loc_oGrd.Column2.Width             = 80
437: 
438:         loc_oGrd.Column3.ControlSource     = "cursor_4c_Dados.Valors"
439:         loc_oGrd.Column3.Header1.Caption   = "Valor"
440:         loc_oGrd.Column3.Header1.Alignment = 2
441:         loc_oGrd.Column3.Header1.FontName  = "Verdana"
442:         loc_oGrd.Column3.Header1.FontSize  = 8
443:         loc_oGrd.Column3.Width             = 120
444: 
445:         loc_oGrd.Column4.ControlSource     = "cursor_4c_Dados.Moedas"
446:         loc_oGrd.Column4.Header1.Caption   = "Moe"
447:         loc_oGrd.Column4.Header1.Alignment = 2
448:         loc_oGrd.Column4.Header1.FontName  = "Verdana"
449:         loc_oGrd.Column4.Header1.FontSize  = 8
450:         loc_oGrd.Column4.Width             = 31
451: 
452:         loc_oGrd.Column5.ControlSource     = "cursor_4c_Dados.Hists"
453:         loc_oGrd.Column5.Header1.Caption   = "Hist" + CHR(243) + "rico"
454:         loc_oGrd.Column5.Header1.Alignment = 2
455:         loc_oGrd.Column5.Header1.FontName  = "Verdana"
456:         loc_oGrd.Column5.Header1.FontSize  = 8
457:         loc_oGrd.Column5.Width             = 305
458: 
459:         loc_oGrd.Column6.ControlSource     = "cursor_4c_Dados.Grupos"
460:         loc_oGrd.Column6.Header1.Caption   = "Grupo"
461:         loc_oGrd.Column6.Header1.Alignment = 2
462:         loc_oGrd.Column6.Header1.FontName  = "Verdana"
463:         loc_oGrd.Column6.Header1.FontSize  = 8
464:         loc_oGrd.Column6.Width             = 90
465: 
466:         loc_oGrd.Column7.ControlSource     = "cursor_4c_Dados.Contas"
467:         loc_oGrd.Column7.Header1.Caption   = "Conta"
468:         loc_oGrd.Column7.Header1.Alignment = 2
469:         loc_oGrd.Column7.Header1.FontName  = "Verdana"
470:         loc_oGrd.Column7.Header1.FontSize  = 8
471:         loc_oGrd.Column7.Width             = 90
472: 
473:         loc_oGrd.Column8.ControlSource     = "cursor_4c_Dados.Opers"
474:         loc_oGrd.Column8.Header1.Caption   = "D/C"
475:         loc_oGrd.Column8.Header1.Alignment = 2
476:         loc_oGrd.Column8.Header1.FontName  = "Verdana"
477:         loc_oGrd.Column8.Header1.FontSize  = 8
478:         loc_oGrd.Column8.Width             = 30
479:         loc_oGrd.Column8.ReadOnly          = .T.
480:     ENDPROC
481: 
482:     *==========================================================================
483:     * ConfigurarBotoes - UNICO botao do form: cmdSair -> cmd_4c_CmdSair
484:     * (nome do mapeamento.json). Este e' um VISUALIZADOR: o legado NAO tem
485:     * Incluir/Alterar/Excluir/Buscar - ver a nota do cabecalho.
486:     *
487:     * Top/Left/Caption/Picture/Cancel/TabIndex sao transcricao literal de
488:     * SECAO 2 (sigmvtit.cmdSair); Width/Height/fonte/cores vem da CLASSE

*-- Linhas 499 a 519:
499: 
500:         loc_cIcone = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501: 
502:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
503:         WITH THIS.cmd_4c_CmdSair
504:             .Top             = 12
505:             .Left            = 905
506:             .Width           = 80
507:             .Height          = 100
508:             .Caption         = "OK"
509:             .Picture         = loc_cIcone
510:             .DisabledPicture = loc_cIcone
511:             .Cancel          = .T.
512:             .TabIndex        = 1
513:             .FontName        = "Comic Sans MS"
514:             .FontSize        = 8
515:             .FontBold        = .T.
516:             .FontItalic      = .T.
517:             .ForeColor       = RGB(90, 90, 90)
518:             .BackColor       = RGB(255, 255, 255)
519:             .Themes          = .T.

*-- Linhas 525 a 540:
525:             .Visible         = .T.
526:         ENDWITH
527: 
528:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
529:     ENDPROC
530: 
531:     *==========================================================================
532:     * ConfigurarCamposDescricao - FASE 5+6/8: shp_4c_Shape1 (moldura do
533:     * cmd_4c_CmdSair) + as 3 linhas de rodape do legado (SECAO 1/2 do dump):
534:     * "Movimentacao de Estoque" (lbl_4c_Label2 + txt_4c_EDN), "Grupo"
535:     * (lbl_4c_Label3 + txt_4c_DGrupos) e "Conta" (lbl_4c_Label1 +
536:     * txt_4c_DContas, completada nesta fase). Top/Left/Width/Height/Caption/
537:     * cores transcritos LITERALMENTE de SECAO 2 do dump legado
538:     * (sigmvtit.Shape1/Label1/Label2/Label3/getDGrupos/getDContas/GetEDN).
539:     *
540:     * LOOKUPS (FASE 6/8): este form NAO TEM nenhum lookup a implementar. A

*-- Linhas 552 a 579:
552:     *==========================================================================
553:     PROTECTED PROCEDURE ConfigurarCamposDescricao()
554: 
555:         *-- Shape1 - moldura do botao OK (cmd_4c_CmdSair), so' contorno
556:         THIS.AddObject("shp_4c_Shape1", "Shape")
557:         WITH THIS.shp_4c_Shape1
558:             .Top         = 6
559:             .Left        = 899
560:             .Width       = 92
561:             .Height      = 110
562:             .BackStyle   = 0
563:             .BorderColor = RGB(136, 189, 188)
564:             .Visible     = .T.
565:         ENDWITH
566: 
567:         *-- Label2 - "Movimentacao de Estoque" (Top=516)
568:         THIS.AddObject("lbl_4c_Label2", "Label")
569:         WITH THIS.lbl_4c_Label2
570:             .Top       = 516
571:             .Left      = 6
572:             .Width     = 172
573:             .Height    = 15
574:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
575:             .AutoSize  = .T.
576:             .BackStyle = 0
577:             .FontName  = "Verdana"
578:             .FontSize  = 8
579:             .FontBold  = .T.

*-- Linhas 586 a 628:
586:         *-- proprio SCX original, nao erro de transcricao (PILAR 1).
587:         THIS.AddObject("txt_4c_EDN", "TextBox")
588:         WITH THIS.txt_4c_EDN
589:             .Top           = 531
590:             .Left          = 6
591:             .Width         = 440
592:             .Height        = 23
593:             .Value         = ""
594:             .ReadOnly      = .T.
595:             .SpecialEffect = 1
596:             .BorderColor   = RGB(136, 189, 188)
597:             .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
598:             .TabStop       = .F.
599:             .Visible       = .T.
600:         ENDWITH
601: 
602:         *-- Label3 - "Descricao do Grupo" (Top=554)
603:         THIS.AddObject("lbl_4c_Label3", "Label")
604:         WITH THIS.lbl_4c_Label3
605:             .Top       = 554
606:             .Left      = 6
607:             .Width     = 129
608:             .Height    = 15
609:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
610:             .AutoSize  = .T.
611:             .BackStyle = 0
612:             .FontName  = "Verdana"
613:             .FontSize  = 8
614:             .FontBold  = .T.
615:             .ForeColor = RGB(255, 255, 255)
616:             .Visible   = .T.
617:         ENDWITH
618: 
619:         *-- getDGrupos -> txt_4c_DGrupos (Top=569)
620:         THIS.AddObject("txt_4c_DGrupos", "TextBox")
621:         WITH THIS.txt_4c_DGrupos
622:             .Top           = 569
623:             .Left          = 6
624:             .Width         = 440
625:             .Height        = 23
626:             .Value         = ""
627:             .ReadOnly      = .T.
628:             .SpecialEffect = 1

*-- Linhas 634 a 648:
634: 
635:         *-- Label1 - "Descricao da Conta" (Top=554, Left=450 - ao lado do
636:         *-- Label3 "Descricao do Grupo")
637:         THIS.AddObject("lbl_4c_Label1", "Label")
638:         WITH THIS.lbl_4c_Label1
639:             .Top       = 554
640:             .Left      = 450
641:             .Width     = 127
642:             .Height    = 15
643:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o da Conta"
644:             .AutoSize  = .T.
645:             .BackStyle = 0
646:             .FontName  = "Verdana"
647:             .FontSize  = 8
648:             .FontBold  = .T.

*-- Linhas 654 a 663:
654:         *-- txt_4c_DGrupos)
655:         THIS.AddObject("txt_4c_DContas", "TextBox")
656:         WITH THIS.txt_4c_DContas
657:             .Top           = 569
658:             .Left          = 450
659:             .Width         = 440
660:             .Height        = 23
661:             .Value         = ""
662:             .ReadOnly      = .T.
663:             .SpecialEffect = 1


### BO (C:\4c\projeto\app\classes\SIGMVTI2BO.prg):
*==============================================================================
* SIGMVTI2BO.PRG
* Business Object - Titulos Gerados (Processamento CMV) (SIGMVTI2)
* Consulta os titulos financeiros gerados pelo processamento de CMV
* (SigMvCcr), no periodo compreendido entre o momento da abertura do
* formulario e o final do dia, com joins para descricao do grupo de
* conta (SigCdGcr) e descricao da conta (SigCdCli).
* Heranca: BusinessBase
*
* NOTA IMPORTANTE (paridade com o legado): o SIGMVTIT/SIGMVTI2 eh um
* formulario de CONSULTA (grid de titulos recem-gerados) - o codigo fonte
* original (Init) faz SOMENTE um SELECT em SigMvCcr com Left Join em
* SigCdGcr/SigCdCli e Join em SigOpCdi. Nao existe, em lugar nenhum do
* legado, INSERT/UPDATE/DELETE em SigMvCcr disparado por este formulario -
* por isso Inserir()/Atualizar()/ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a
* operacao e reportar via ExibirFalha) ja eh o correto para um BO
* somente-leitura.
*==============================================================================

DEFINE CLASS SIGMVTI2BO AS BusinessBase

    *-- Filtro de periodo (espelha pDtI/pDtF do Init legado:
    *   pDtI = fDtoSQL(Datetime())                 -> momento atual
    *   pDtF = fDtoSQL(Datetime(), [23:59:59])      -> hoje as 23:59:59)
    this_dDtI = {}    && Data/hora inicial do filtro (SigMvCcr.datas between this_dDtI e this_dDtF)
    this_dDtF = {}    && Data/hora final do filtro

    *-- Dados do titulo selecionado no grid (SigMvCcr + joins SigCdGcr/SigCdCli)
    this_cTitulos    = ""   && SigMvCcr.titulos     char(10)      - codigo do titulo (PK logica)
    this_dVencs      = {}   && SigMvCcr.vencs       datetime      - data de vencimento
    this_nValors     = 0    && SigMvCcr.valors      numeric(11,2) - valor do titulo
    this_cMoedas     = ""   && SigMvCcr.moedas      char(3)       - codigo da moeda
    this_cHists      = ""   && SigMvCcr.hists       char(60)      - historico
    this_cGrupos     = ""   && SigMvCcr.grupos      char(10)      - grupo de conta (FK SigCdGcr.codigos)
    this_cDGrupos    = ""   && SigCdGcr.descrs                    - descricao do grupo (join b, alias DGrupos)
    this_cContas     = ""   && SigMvCcr.contas      char(10)      - conta (FK SigCdCli.IClis)
    this_cDContas    = ""   && SigCdCli.RClis                     - descricao da conta (join c, alias DContas)
    this_cEmpDopNums = ""   && SigMvCcr.empdopnums  char(29)      - chave Empresa+Operacao+Numero
    this_cOpers      = ""   && SigMvCcr.opers       char(1)       - tipo de operacao (D/C)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigMvCcr")

        THIS.this_cCampoChave = "cidchaves"

        * Periodo padrao: do momento atual ate o final do dia de hoje,
        * reproduzindo pDtI/pDtF do Init legado (fDtoSQL(Datetime()) e
        * fDtoSQL(Datetime(), [23:59:59]))
        THIS.this_dDtI = DATETIME()
        THIS.this_dDtF = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

        THIS.this_cTitulos    = ""
        THIS.this_dVencs      = {}
        THIS.this_nValors     = 0
        THIS.this_cMoedas     = ""
        THIS.this_cHists      = ""
        THIS.this_cGrupos     = ""
        THIS.this_cDGrupos    = ""
        THIS.this_cContas     = ""
        THIS.this_cDContas    = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cOpers      = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulosGerados - Popula cursor_4c_Dados com os titulos gerados
    * pelo processamento de CMV no periodo THIS.this_dDtI / THIS.this_dDtF.
    * Transcricao literal da query do Init legado (SigMvCcr a + Left Join
    * SigCdGcr b + Left Join SigCdCli c + Join SigOpCdi d), trocando os
    * parametros ?pDtI/?pDtF por literais formatados (FormatarDataSQL) e o
    * cursor local LocalTits pelo cursor_4c_Dados do grid.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulosGerados()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos, " + ;
                   "b.Descrs AS DGrupos, a.Contas, c.RClis AS DContas, a.EmpDopNums, a.Opers " + ;
                   "FROM SigMvCcr a " + ;
                   "LEFT JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "LEFT JOIN SigCdCli c ON a.Contas = c.IClis " + ;
                   "JOIN SigOpCdi d ON d.Dopes = a.Dopes " + ;
                   "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtI) + " AND " + FormatarDataSQL(THIS.this_dDtF) + " " + ;
                   "ORDER BY a.Vencs, a.Titulos, a.Grupos, a.Contas"

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

        IF loc_nResultado >= 0
            loc_lSucesso = .T.
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            MostrarErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o (T" + CHR(237) + "tulos Gerados)")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir de UMA linha
    * do cursor_4c_Dados (mesmas colunas/alias de BuscarTitulosGerados),
    * reproduzindo o AfterRowColChange do grdTitulos legado (que lia
    * LocalTits.DGrupos/DContas/EmpDopNums direto para os GETs de rodape).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        THIS.this_cTitulos    = TratarNulo(Titulos, "")
        THIS.this_dVencs      = TratarNulo(Vencs, {})
        THIS.this_nValors     = TratarNulo(Valors, 0)
        THIS.this_cMoedas     = TratarNulo(Moedas, "")
        THIS.this_cHists      = TratarNulo(Hists, "")
        THIS.this_cGrupos     = TratarNulo(Grupos, "")
        THIS.this_cDGrupos    = TratarNulo(DGrupos, "")
        THIS.this_cContas     = TratarNulo(Contas, "")
        THIS.this_cDContas    = TratarNulo(DContas, "")
        THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
        THIS.this_cOpers      = TratarNulo(Opers, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identificador logico do titulo corrente (coluna
    * Titulos, chave usada pelo grid legado). cidchaves (PK fisica da
    * SigMvCcr) nao entra no SELECT desta consulta (o legado tambem nao a
    * le) - RegistrarAuditoria/ObterChavePrimaria so existem aqui por
    * completude de heranca, ja que este BO nao grava (ver nota no Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

ENDDEFINE

