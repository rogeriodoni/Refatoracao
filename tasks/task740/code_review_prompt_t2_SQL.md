# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODBARRAS, CBARS, CPROS, OP_ESCOLHA, OPERS, CITEM2, CITENS, EMPDOPNUMS, MATS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BACKCOLOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODBARRAS, CBARS, CPROS, OP_ESCOLHA, OPERS, CITEM2, CITENS, EMPDOPNUMS, MATS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
		SELECT * , 0000000000 as citens, SPACE(50) as dpros from crSigOpeXi into cursor crSigOpeXi readwrite
	ThisForm.grdDevols.Column1.ControlSource = [crSigOpExI.CItens]
	ThisForm.grdDevols.Column2.ControlSource = [crSigOpExI.CBars]
	ThisForm.grdDevols.Column3.ControlSource = [crSigOpExI.CPros]
	ThisForm.grdDevols.Column4.ControlSource = [crSigOpExI.DPros]
	SELECT crSigOpExI
	Select Recno() as NRec, CPros, BlqAlts, qtds, units From crTpmMvItn Where CodBarras = lnBar Into Cursor csProcura1
		Select Recno() as NRec From crSigOpExI Where CBars = lnBar Into Cursor csProcura
			Select crSigOpExI
			thisform.parentform.parentform.podatamgr.sqlexecute('select dpros from SigCdPro where cpros = ?csProcura1.CPros','LocalPro')
			Insert Into crSigOpExI (EmpDopNums, Datas, pkChaves, CBars, CPros, dpros, valors, CItens) ;
			SELECT crSigOpExI
SELECT crSigOpeXi
	Select crTpmMvItn 
					Delete
					Delete For cItem2 = _cItem
					Select TmpOperacao
						Select xBaixa
						If Seek( _Cpro )
					Select crTpmMvIts
					Seek ( _CItem )
						Delete 
						Seek ( _CItem )
						lcSql = [Select Cpros From SigMvItn Where Cpros = ']+_cPRO+[' And EmpDopNums <> ']+TprMvCab.EmpdopNums+[']
						ThisForm.parentform.parentForm.PodataMgr.SqlExecute(lcSql,'LocEesti')
						lcSql = [Select Cpros From SigMvHst  Where Cpros = ']+_cPRO+[' And EmpDopNums <> ']+TprMvCab.EmpdopNums+[']
						ThisForm.parentForm.parentform.PodataMgr.SqlExecute(lcSql,'LocHis')
						lcSql = [Select Mats From SigPrCpo Where Mats = ']+_cPro+[']
						ThisForm.parentForm.parentform.PodataMgr.SqlExecute(lcSql,'LocCompo')
				Select [ ] as Agrupar,Count(1) As Total From crTpmMvItn Where IsEmpty(CPros) Into Cursor xApaga Group by 1
					Select crTpmMvItn
					Delete
			Select crTpmMvItn
				Insert Into crTpmMvItn( Emps, Dopes, Numes, CItens) ;
				Select crTpmMvIts
				Select crTpmMvItn
			Select crTpmMvItn
				Select crTpmMvIts
		Select crTpmMvItn
SELECT crSigOpExI

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopexi.prg) - TRECHOS RELEVANTES PARA PASS SQL (905 linhas total):

*-- Linhas 58 a 84:
58: *             ConfigurarTotais (lbl_4c_Label1 residual oculto + txt_4c_Totitens
59: *             + lbl_4c_Label2 + txt_4c_Totven + lbl_4c_Label3) e
60: *             ConfigurarBotoesAcao (cmd_4c_Confirmar/cmd_4c_BtnCancelar,
61: *             standalone). Column.ControlSource fica VAZIO (CLAUDE.md regra
62: *             #41 - o cursor crSigOpExI pode ainda nao estar com a estrutura
63: *             final neste ponto); o bind com o cursor (RecordSource +
64: *             Column*.ControlSource), o calculo dos totais (BO.
65: *             AtualizarTotais) e os handlers de clique/Valid ficam para fase
66: *             posterior, mesmo padrao de Formsigopagr.prg (Fase 4 so
67: *             estrutura, MontaGrade/eventos em fase seguinte).
68: *   Fase 5:   VincularGradeDevolucoes() - bind do grd_4c_Dados ao cursor
69: *             crSigOpExI (RecordSource + Column1..4.ControlSource) e
70: *             espelhamento dos totais (BO.AtualizarTotais) em
71: *             txt_4c_Totitens/txt_4c_Totven, equivalente literal ao bloco
72: *             "If Used([crSigOpExI]) ... EndIf" do Init legado (ver
73: *             cabecalho do arquivo). So age quando o cursor JA esta aberto
74: *             (ele eh aberto pelo form de Movimentacao ANTES deste dialogo
75: *             ser criado) - CLAUDE.md regra #41. Chamado uma vez em
76: *             InicializarForm; os handlers que o chamam de novo apos
77: *             incluir/confirmar/cancelar item (getBarras.Valid, confirmar.
78: *             Click, btnCancelar.Click) ficam para fase posterior.
79: *   Fase 6:   ValidarBarras()/BarrasKeyPress() - equivalente ao getBarras.
80: *             Valid legado (bipagem do codigo de barras). Este form NAO tem
81: *             lookup F4/FormBuscaAuxiliar (comportamento.json: temLookup=
82: *             false em todos os metodos) - o "lookup" real desta fase eh a
83: *             busca do item na movimentacao (crTpmMvItn) por codigo de
84: *             barras, ja encapsulada em THIS.this_oBusinessObject.

*-- Linhas 105 a 123:
105: *             migrado nesta task (ver comentario da property
106: *             this_oFormPai acima). BtnCancelarClick delega a
107: *             THIS.this_oBusinessObject.LimparItensDevolucao() (fase 1/2),
108: *             equivalente a "SELECT crSigOpExI / Zap" do legado.
109: *   Fase 8:   Consolidacao final - NENHUM metodo novo. O meta-prompt
110: *             generico desta fase pede BtnBuscarClick/BtnEncerrarClick/
111: *             BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/
112: *             HabilitarCampos/LimparCampos/CarregarLista/
113: *             AjustarBotoesPorModo - template de form CRUD (Page1=Lista/
114: *             Page2=Dados, cursor_4c_Dados, modos INCLUIR/ALTERAR/
115: *             VISUALIZAR/EXCLUIR). Este dialogo NAO tem NENHUM desses
116: *             elementos: nao tem PageFrame, nao tem grid de LISTA de
117: *             registros (grd_4c_Dados eh a grade de ITENS da devolucao
118: *             em edicao, nao uma lista de "registros sigopexi"), nao tem
119: *             modos de form CRUD e seus UNICOS dois botoes (Confirmar/
120: *             Cancelar, equivalentes a confirmar/btnCancelar do dump -
121: *             mapeamento.json nao lista nenhum outro CommandButton) ja
122: *             tem handler completo desde a Fase 7 (BtnConfirmarClick/
123: *             BtnCancelarClick). Nao ha BtnBuscarClick/BtnEncerrarClick/

*-- Linhas 230 a 248:
230:     * tem - ver cabecalho do arquivo). Ordem de criacao IDENTICA a arvore do
231:     * dump (SECAO 1): cntSombra, Say7+getBarras, grdDevols, Say1+gettotitens+
232:     * Say2+gettotven+Say3, confirmar+btnCancelar. Bind do grid ao cursor
233:     * crSigOpExI (Column*.ControlSource, que fica VAZIO aqui) e o calculo dos
234:     * totais ficam para fase posterior (CLAUDE.md regra #41 - o cursor pode
235:     * ainda nao estar populado neste ponto, mesmo padrao de
236:     * Formsigopagr.ConfigurarGradeItens/MontaGrade). Chamado automaticamente
237:     * por FormBase.Init() via DODEFAULT().
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE InicializarForm()
240:         LOCAL loc_lSucesso, loc_oErro
241:         loc_lSucesso = .F.
242: 
243:         TRY
244:             *-- Fundo do form (imagem do Framework Fortyus legado:
245:             *-- "..\framework\imagens\new_background.jpg" no SCX)
246:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
247: 
248:             THIS.ConfigurarCabecalho()

*-- Linhas 431 a 449:
431:                 THIS.txt_4c_Totven.Value   = THIS.this_oBusinessObject.this_nTotalValor
432: 
433:                 IF USED(loc_cCursor)
434:                     SELECT (loc_cCursor)
435:                     GO TOP
436:                 ENDIF
437:                 THIS.grd_4c_Dados.Refresh()
438: 
439:             CASE loc_cStatus == "BLOQUEADO"
440:                 MsgAviso("C" + CHR(243) + "digo do Produto n" + CHR(227) + "o pode ser Alterado", ;
441:                     "Opera" + CHR(231) + CHR(227) + "o com Baixa Parcial")
442: 
443:             CASE loc_cStatus == "INEXISTENTE"
444:                 MsgAviso("Item inexistente nessa opera" + CHR(231) + CHR(227) + "o", "Aviso")
445:                 THIS.txt_4c_Barras.Value = 0
446: 
447:             OTHERWISE
448:                 *-- "DUPLICADO" - sem acao, igual ao legado
449:         ENDCASE

*-- Linhas 461 a 526:
461:     * fora de ordem, mas o campo .Name de cada grupo confere com o Column
462:     * real: grupo rotulado "Column2" no dump pertence a Column3/"Produto",
463:     * grupo "Column3" pertence a Column4/"Descricao", grupo "Column4"
464:     * pertence a Column2/"Barras"). Column*.ControlSource fica VAZIO
465:     * propositalmente - ver comentario de InicializarForm.
466:     *--------------------------------------------------------------------------
467:     PROTECTED PROCEDURE ConfigurarGradeDevolucoes()
468:         LOCAL loc_oGrid
469: 
470:         THIS.AddObject("grd_4c_Dados", "Grid")
471:         loc_oGrid = THIS.grd_4c_Dados
472:         WITH loc_oGrid
473:             .Top               = 112
474:             .Left              = 9
475:             .Width             = 809
476:             .Height            = 452
477:             .ColumnCount       = 4
478:             .FontName          = "Courier New"
479:             .AllowHeaderSizing = .F.
480:             .DeleteMark        = .F.
481:             .RecordMark        = .F.
482:             .HeaderHeight      = 16
483:             .ScrollBars        = 2
484:             .ToolTipText       = "Grade de Produtos Para Devolu" + CHR(231) + CHR(227) + "o"
485:             .Visible           = .T.
486:         ENDWITH
487: 
488:         *-- Column1: Item (crSigOpExI.CItens)
489:         WITH loc_oGrid.Column1
490:             .FontName          = "Courier New"
491:             .ControlSource     = ""
492:             .Width             = 31
493:             .Movable           = .F.
494:             .Resizable         = .F.
495:             .ReadOnly          = .T.
496:             .Format            = "K!"
497:             .InputMask         = "9999"
498:             .Visible           = .T.
499:             .Header1.FontName  = "Arial"
500:             .Header1.FontSize  = 8
501:             .Header1.Alignment = 2
502:             .Header1.Caption   = "Item"
503:             .Text1.Margin      = 0
504:             .Text1.ReadOnly    = .T.
505:         ENDWITH
506: 
507:         *-- Column2: Barras (crSigOpExI.CBars) - ColumnOrder 2
508:         WITH loc_oGrid.Column2
509:             .FontName          = "Courier New"
510:             .ColumnOrder       = 2
511:             .ControlSource     = ""
512:             .Width             = 108
513:             .Movable           = .F.
514:             .Resizable         = .F.
515:             .ReadOnly          = .T.
516:             .InputMask         = "99999999999999"
517:             .Visible           = .T.
518:             .Header1.FontName  = "Arial"
519:             .Header1.FontSize  = 8
520:             .Header1.Alignment = 2
521:             .Header1.Caption   = "Barras"
522:             .Text1.FontName    = "Courier New"
523:             .Text1.Alignment   = 3
524:             .Text1.BorderStyle = 0
525:             .Text1.InputMask   = "99999999"
526:             .Text1.Margin      = 0

*-- Linhas 532 a 567:
532:         WITH loc_oGrid.Column3
533:             .FontName          = "Courier New"
534:             .ColumnOrder       = 3
535:             .ControlSource     = ""
536:             .Width             = 122
537:             .Movable           = .F.
538:             .Resizable         = .F.
539:             .ReadOnly          = .T.
540:             .Visible           = .T.
541:             .Header1.FontName  = "Arial"
542:             .Header1.FontSize  = 8
543:             .Header1.Alignment = 2
544:             .Header1.Caption   = "Produto"
545:             .Text1.ReadOnly    = .T.
546:         ENDWITH
547: 
548:         *-- Column4: Descricao (crSigOpExI.DPros) - ColumnOrder 4
549:         WITH loc_oGrid.Column4
550:             .FontName          = "Courier New"
551:             .ColumnOrder       = 4
552:             .ControlSource     = ""
553:             .Width             = 513
554:             .Resizable         = .F.
555:             .ReadOnly          = .T.
556:             .Visible           = .T.
557:             .Header1.FontName  = "Arial"
558:             .Header1.FontSize  = 8
559:             .Header1.Alignment = 2
560:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
561:             .Text1.Height      = 23
562:             .Text1.Left        = 35
563:             .Text1.Top         = 19
564:             .Text1.Width       = 100
565:         ENDWITH
566:     ENDPROC
567: 

*-- Linhas 813 a 903:
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     * BtnCancelarClick - equivalente ao btnCancelar.Click do dump: "SELECT
817:     * crSigOpExI / Zap" (THIS.this_oBusinessObject.LimparItensDevolucao(),
818:     * fase 1/2) seguido de Release(). "Set Confirm off" sem equivalente
819:     * (ver comentario de BtnConfirmarClick).
820:     *--------------------------------------------------------------------------
821:     PROCEDURE BtnCancelarClick()
822:         THIS.this_oBusinessObject.LimparItensDevolucao(THIS.this_cCursorDevolucao)
823:         THIS.Release()
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * VincularGradeDevolucoes - Liga grd_4c_Dados ao cursor de devolucao
828:     * (THIS.this_cCursorDevolucao, igual a "crSigOpExI" - aberto pelo form
829:     * de Movimentacao ANTES deste dialogo ser criado) e espelha os totais
830:     * calculados pelo BO (sigopexiBO.AtualizarTotais) em txt_4c_Totitens/
831:     * txt_4c_Totven - equivalente literal ao bloco "If Used([crSigOpExI])
832:     * ... EndIf" do Init legado (ver cabecalho do arquivo). So faz algo se
833:     * o cursor JA estiver aberto (CLAUDE.md regra #41 - Column.ControlSource
834:     * de cursor ainda inexistente derruba o Init); se nao estiver, a grade
835:     * fica com ControlSource vazio (ja deixado assim em
836:     * ConfigurarGradeDevolucoes). GO TOP + Grid.Refresh no fim (cursor
837:     * populado nao repinta a grade sozinho).
838:     *--------------------------------------------------------------------------
839:     PROTECTED PROCEDURE VincularGradeDevolucoes()
840:         LOCAL loc_cCursor
841: 
842:         loc_cCursor = THIS.this_cCursorDevolucao
843: 
844:         IF USED(loc_cCursor)
845:             *-- Equivalente a "IF TYPE('crSigOpExI.CItens') = 'U' / SELECT * ,
846:             *-- 0000000000 as citens, SPACE(50) as dpros from crSigOpeXi into
847:             *-- cursor crSigOpeXi readwrite / ENDIF" do Init legado - acrescenta
848:             *-- as 2 colunas somente-memoria (citens/dpros, ver cabecalho do
849:             *-- BO) quando o cursor ainda nao as tem (o form de Movimentacao
850:             *-- pode te-lo aberto so com as colunas da tabela sigopexi).
851:             IF TYPE(loc_cCursor + ".citens") = "U"
852:                 SELECT * , 0000000000 AS citens, SPACE(50) AS dpros ;
853:                     FROM (loc_cCursor) INTO CURSOR (loc_cCursor) READWRITE
854:             ENDIF
855: 
856:             *-- RecordSource/ControlSource RESETAM Column.Width e
857:             *-- Header1.Caption (Problema 48/FormCor Licoes Aprendidas) -
858:             *-- reconfigurar os dois IMEDIATAMENTE depois, na mesma ordem
859:             *-- em que foram definidos em ConfigurarGradeDevolucoes.
860:             *-- RecordSource fica FORA do WITH (referencia explicita) -
861:             *-- dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
862:             *-- recriou as colunas e estoura "Unknown member COLUMN1".
863:             THIS.grd_4c_Dados.RecordSource = loc_cCursor
864: 
865:             WITH THIS.grd_4c_Dados
866:                 .Column1.ControlSource = loc_cCursor + ".CItens"
867:                 .Column2.ControlSource = loc_cCursor + ".CBars"
868:                 .Column3.ControlSource = loc_cCursor + ".CPros"
869:                 .Column4.ControlSource = loc_cCursor + ".DPros"
870: 
871:                 .Column1.Width           = 31
872:                 .Column1.Header1.Caption = "Item"
873: 
874:                 .Column2.Width           = 108
875:                 .Column2.Header1.Caption = "Barras"
876: 
877:                 .Column3.Width           = 122
878:                 .Column3.Header1.Caption = "Produto"
879: 
880:                 .Column4.Width           = 513
881:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
882:             ENDWITH
883: 
884:             THIS.this_oBusinessObject.AtualizarTotais(loc_cCursor)
885:             THIS.txt_4c_Totitens.Value = THIS.this_oBusinessObject.this_nTotalItens
886:             THIS.txt_4c_Totven.Value   = THIS.this_oBusinessObject.this_nTotalValor
887: 
888:             SELECT (loc_cCursor)
889:             GO TOP
890:             THIS.grd_4c_Dados.Refresh()
891:         ENDIF
892:     ENDPROC
893: 
894:     *--------------------------------------------------------------------------
895:     * Destroy - Libera a referencia ao form chamador e chama DODEFAULT()
896:     * (CLAUDE.md regra #29 - Destroy sem DODEFAULT: FormBase.Destroy() faz o
897:     * RELEASE POPUP + CriarMenuPrincipal() que evita o menu "encolher" apos
898:     * fechar form modal, alem de liberar THIS.this_oBusinessObject).
899:     *--------------------------------------------------------------------------
900:     PROCEDURE Destroy()
901:         THIS.this_oFormPai = .NULL.
902:         DODEFAULT()
903:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigopexiBO.prg):
*====================================================================
* sigopexiBO.prg
*
* Business Object para Devolucao de Produtos (dialogo filho OPERACIONAL)
* Tabela: sigopexi
* Herda de: BusinessBase
*
* NOTA: SIGOPEXI eh um dialogo MODAL chamado pela tela de Movimentacao
* (parentform) para lancar devolucao de itens digitados por codigo de
* barras. A tabela sigopexi grava so as colunas persistidas abaixo;
* CItens e DPros existem apenas no cursor em memoria (crSigOpExI) usado
* pela grade do dialogo e NAO tem coluna correspondente na tabela.
*====================================================================

DEFINE CLASS sigopexiBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopexi)
    this_cPkChaves    = ""    && pkchaves char(20) - PK (gerada via fUniqueIds())
    this_nCBars       = 0     && cbars numeric(14,0) - codigo de barras do produto devolvido
    this_cCPros       = ""    && cpros char(14) - codigo do produto
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave do movimento (Emps+Dopes+Str(Numes,6))
    this_dDatas       = {}    && datas datetime - data/hora do lancamento da devolucao
    this_nValors      = 0     && valors numeric(11,2) - valor da devolucao (qtds * units)

    *-- Propriedades auxiliares somente-memoria (nao persistidas em sigopexi)
    this_nCItens      = 0     && citens - sequencial do item na grade (crSigOpExI.CItens)
    this_cDPros       = ""    && dpros char(50) - descricao do produto (crSigOpExI.DPros, via SigCdPro)

    *-- Propriedades auxiliares de processo (equivalentes a propriedades/
    *-- controles do form legado - preenchidas/lidas pelos metodos desta
    *-- fase, consumidas pelo FormSigopexi nas fases seguintes)
    this_cOpEscolha            = ""    && espelha ThisForm.op_escolha (recebido do form pai) - usado em AdicionarItemPorBarras/ConfirmarDevolucoes
    this_nTotalItens           = 0     && espelha thisform.gettotitens.Value (COUNT da grade de devolucao)
    this_nTotalValor           = 0     && espelha thisform.gettotven.Value (SUM de valors da grade de devolucao)
    this_cProdutosParaExcluir  = ""    && codigos de produto (separados por virgula) elegiveis para exclusao de cadastro (CrSigCdOpe.CadProds = 3) - o Form pergunta ao usuario e chama THIS.parentform.ExcluirPro() para cada
    this_nNovoCItem            = 0     && equivalente a thisform.parentform.CItem apos ConfirmarDevolucoes renumerar crTpmMvItn
    this_lChamouApaIte         = .F.   && .T. quando ConfirmarDevolucoes identifica que o Form deve chamar THIS.parentform.ApaIte()

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopexi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopexiBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da tabela sigopexi
    * (pkchaves/cbars/cpros/empdopnums/datas/valors) a partir da linha
    * CORRENTE do cursor informado (tipicamente crSigOpExI - a grade de
    * devolucao), mais as duas colunas auxiliares somente-memoria
    * (citens/dpros), quando presentes no cursor.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_nCBars      = TratarNulo(cbars, 0)
            THIS.this_cCPros      = TratarNulo(cpros, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_nValors     = TratarNulo(valors, 0)

            *-- Colunas auxiliares somente-memoria do cursor da grade
            *-- (nao existem na tabela sigopexi - ver cabecalho da classe)
            IF TYPE(par_cAliasCursor + ".citens") != "U"
                THIS.this_nCItens = TratarNulo(citens, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dpros") != "U"
                THIS.this_cDPros = TratarNulo(dpros, "")
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO sigopexi com os valores das properties this_*.
    * Gera THIS.this_cPkChaves via fUniqueIds() quando ainda vazio (igual
    * ao getBarras.Valid do legado, que gera a chave no momento do insert).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigopexi (pkchaves, cbars, cpros, empdopnums, datas, valors)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCBars, 0) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE sigopexi, identificado por this_cPkChaves.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigopexi SET" + ;
                " cbars = "      + FormatarNumeroSQL(THIS.this_nCBars, 0) + "," + ;
                " cpros = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + "," + ;
                " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + "," + ;
                " datas = "      + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                " valors = "     + FormatarNumeroSQL(THIS.this_nValors, 2) + ;
                " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da tabela sigopexi (pkchaves).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * AtualizarTotais - Recalcula THIS.this_nTotalItens/this_nTotalValor a
    * partir do cursor de devolucao (equivalente a "Select crSigOpExI /
    * Sum valors to lntotven / Count to lnitn" repetido no getBarras.Valid
    * e no Init do legado). O Form eh quem espelha estes valores nos
    * labels gettotitens/gettotven - esta funcao so calcula.
    *====================================================================
    PROCEDURE AtualizarTotais(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias, loc_nTotalValor, loc_nTotalItens

        loc_cAlias      = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        loc_nTotalValor = 0
        loc_nTotalItens = 0

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            SUM valors TO loc_nTotalValor
            COUNT TO loc_nTotalItens
        ENDIF

        THIS.this_nTotalValor = loc_nTotalValor
        THIS.this_nTotalItens = loc_nTotalItens

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterDescricaoProduto - SELECT dpros FROM SigCdPro WHERE cpros = ...
    * (equivalente a "podatamgr.sqlexecute('select dpros from SigCdPro
    * where cpros = ?csProcura1.CPros','LocalPro')" do getBarras.Valid
    * legado - unica consulta SQL de verdade neste dialogo).
    *====================================================================
    PROTECTED PROCEDURE ObterDescricaoProduto(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao

        loc_cDescricao = ""

        loc_cSQL = "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(par_cCodigoProduto, "")))

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")

        IF loc_nResultado > 0 AND USED("cursor_4c_BuscaProduto")
            SELECT cursor_4c_BuscaProduto
            GO TOP
            IF !EOF()
                loc_cDescricao = TratarNulo(dpros, "")
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL do movimento (EmpDopNums),
    * igual a "TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)" do
    * legado. O padding faz parte da chave (regra das colunas char de
    * largura fixa) - NUNCA usar ALLTRIM nas partes, so no resultado
    * inteiro seria inofensivo. Larguras conferidas no schema: emps
    * char(3) + dopes char(20) + Str(numes,6) = 29 = empdopnums char(29).
    *====================================================================
    PROTECTED PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(ALLTRIM(NVL(par_cEmps, "")), 3) + ;
               PADR(ALLTRIM(NVL(par_cDopes, "")), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * AdicionarItemPorBarras - Localiza o item da movimentacao
    * (crTpmMvItn - cursor global compartilhado com o form pai de
    * Movimentacao) pelo codigo de barras e, se elegivel, inclui uma nova
    * linha no cursor de devolucao (equivalente ao getBarras.Valid do
    * legado). So manipula dados - o Form (fases seguintes) limpa o
    * campo de barras, da Refresh no Grid e exibe a mensagem conforme o
    * status retornado.
    *
    * Retorno:
    *   "OK"          - item incluido com sucesso na grade de devolucao
    *   "BLOQUEADO"   - produto com baixa parcial, nao pode ser alterado
    *   "INEXISTENTE" - codigo de barras nao encontrado na movimentacao
    *   "DUPLICADO"   - produto ja estava na grade de devolucao (nao faz
    *                   nada, igual ao legado, que ignora em silencio)
    *====================================================================
    PROCEDURE AdicionarItemPorBarras(par_nBarras, par_cAliasCursorDevolucao)
        LOCAL loc_cStatus, loc_cAliasDevol, loc_nItem, loc_cDescricao, loc_cChave

        loc_cStatus     = "INEXISTENTE"
        loc_cAliasDevol = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        *-- VARTYPE isolado num IF proprio: VFP9 nao faz short-circuit em
        *-- AND/OR, e "par_nBarras != 0" com par_nBarras nao-numerico
        *-- estouraria "Operator/operand type mismatch" se avaliado junto.
        IF VARTYPE(par_nBarras) = "N"
        IF par_nBarras != 0 AND USED("crTpmMvItn") AND USED(loc_cAliasDevol)
            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
            SELECT RECNO() AS NRec, CPros, BlqAlts, qtds, units FROM crTpmMvItn ;
                WHERE CodBarras = par_nBarras INTO CURSOR cursor_4c_BuscaMovimento
            GO TOP IN cursor_4c_BuscaMovimento

            IF !EOF("cursor_4c_BuscaMovimento")
                IF cursor_4c_BuscaMovimento.BlqAlts
                    loc_cStatus = "BLOQUEADO"
                ELSE
                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                    SELECT RECNO() AS NRec FROM (loc_cAliasDevol) ;
                        WHERE CBars = par_nBarras INTO CURSOR cursor_4c_BuscaDuplicado
                    GO TOP IN cursor_4c_BuscaDuplicado

                    IF EOF("cursor_4c_BuscaDuplicado")
                        *-- Renumera CItens das linhas existentes (igual ao
                        *-- legado - normalmente no-op, preserva fidelidade)
                        loc_nItem = 0
                        SELECT (loc_cAliasDevol)
                        SCAN
                            loc_nItem = loc_nItem + 1
                            REPLACE CItens WITH loc_nItem IN (loc_cAliasDevol)
                        ENDSCAN
                        loc_nItem = loc_nItem + 1

                        loc_cDescricao = THIS.ObterDescricaoProduto(cursor_4c_BuscaMovimento.CPros)
                        loc_cChave     = THIS.MontarChaveEmpDopNums(TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)

                        INSERT INTO (loc_cAliasDevol) (EmpDopNums, Datas, pkChaves, CBars, CPros, dpros, valors, CItens) VALUES ( ;
                            loc_cChave, ;
                            DATETIME(), ;
                            fUniqueIds(), ;
                            par_nBarras, ;
                            cursor_4c_BuscaMovimento.CPros, ;
                            loc_cDescricao, ;
                            cursor_4c_BuscaMovimento.qtds * cursor_4c_BuscaMovimento.units, ;
                            loc_nItem)

                        THIS.AtualizarTotais(loc_cAliasDevol)

                        loc_cStatus = "OK"
                    ELSE
                        loc_cStatus = "DUPLICADO"
                    ENDIF

                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
        ENDIF
        ENDIF

        RETURN loc_cStatus
    ENDPROC

    *====================================================================
    * LimparItensDevolucao - Esvazia o cursor de devolucao (equivalente a
    * "SELECT crSigOpExI / Zap" do btnCancelar.Click do legado).
    *====================================================================
    PROCEDURE LimparItensDevolucao(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias
        loc_cAlias = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            ZAP
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConfirmarDevolucoes - Processa a confirmacao da devolucao
    * (equivalente ao confirmar.Click do legado). Para cada item da
    * grade de devolucao, localiza o item correspondente na movimentacao
    * (crTpmMvItn) pelo codigo de barras e, se nao estiver bloqueado,
    * exclui o item (e seus componentes, em crTpmMvIts) da movimentacao,
    * renumera os itens restantes e, quando aplicavel, estorna a baixa
    * de estoque (xBaixa) e avalia se o cadastro do produto pode ser
    * excluido (CrSigCdOpe.CadProds = 3 - ver AvaliarExclusaoProduto).
    *
    * Cursores globais compartilhados com o form pai de Movimentacao
    * (crTpmMvItn, crTpmMvIts, TprMvCab, CrSigCdOpe, CrSigOpCdc,
    * TmpOperacao, xBaixa) sao referenciados por NOME, igual ao legado -
    * este dialogo so eh aberto depois que o pai os deixa abertos.
    *
    * O que o legado faz em "ThisForm.parentform" (fwgrade/fwgradeR.
    * Refresh, Produto.SetFocus, CItem, ExcluirPro, ApaIte) eh
    * responsabilidade de UI/navegacao do FORM pai, nao deste BO - o
    * Form (fases seguintes) le o resultado desta chamada
    * (this_cProdutosParaExcluir, this_nNovoCItem, this_lChamouApaIte) e
    * executa essas acoes contra o parentform depois de chamar este
    * metodo.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo sem
    * nenhuma devolucao processada - igual ao legado, que nao verifica
    * sucesso por item).
    *====================================================================
    PROCEDURE ConfirmarDevolucoes(par_cAliasCursorDevolucao)
        LOCAL loc_cAliasDevol, loc_oErro, loc_lSucesso, loc_nBarras
        LOCAL loc_cItem, loc_cPro, loc_nQtde, loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper
        LOCAL loc_nReg, loc_lDel, loc_lSubNiv, loc_cont, loc_cIt, loc_nRecNo2

        loc_lSucesso                  = .F.
        loc_cAliasDevol                = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        THIS.this_cProdutosParaExcluir = ""
        THIS.this_nNovoCItem           = 0
        THIS.this_lChamouApaIte        = .F.

        TRY
            IF USED(loc_cAliasDevol) AND USED("crTpmMvItn")
                SELECT (loc_cAliasDevol)
                SCAN
                    loc_nBarras = cbars

                    SELECT crTpmMvItn
                    LOCATE FOR CodBarras = loc_nBarras

                    IF !EOF("crTpmMvItn")
                        IF crTpmMvItn.BlqAlts
                            *-- bloqueado: o legado so exibe o MessageBox e
                            *-- segue para o proximo item do SCAN (o Form
                            *-- exibe a mensagem de bloqueio, se desejar).
                        ELSE
                            IF !EMPTY(crTpmMvItn.cpros)
                                loc_cItem         = crTpmMvItn.CItens
                                loc_cPro          = crTpmMvItn.Cpros
                                loc_nQtde         = crTpmMvItn.Qtds
                                loc_lCarregaItens = INLIST(NVL(CrSigCdOpe.ItAutos, 0), 1, 3, 4, 5) AND THIS.this_cOpEscolha == "INSERIR"
                                loc_lChecaQtde    = INLIST(NVL(CrSigCdOpe.ChkQtdss, 0), 1, 3, 4)
                                loc_lChecaOper    = (EMPTY(CrSigOpCdc.ChkOpers) OR crTpmMvItn.Opers == CrSigOpCdc.ChkOpers)

                                SELECT crTpmMvItn
                                loc_nReg = RECNO()
                                loc_lDel = .F.

                                LOCATE FOR .F.
                                IF BETWEEN(loc_nReg, 1, RECCOUNT("crTpmMvItn"))
                                    GO loc_nReg
                                    DELETE
                                    DELETE FOR cItem2 = loc_cItem
                                    loc_lDel = .T.
                                ENDIF

                                IF loc_lDel
                                    loc_lSubNiv = .F.
                                    IF USED("TmpOperacao")
                                        SELECT TmpOperacao
                                        SCAN FOR !EMPTY(Codigos)
                                            loc_lSubNiv = .T.
                                        ENDSCAN
                                    ENDIF

                                    IF loc_lSubNiv AND loc_lChecaQtde AND loc_lChecaOper AND !loc_lCarregaItens
                                        IF USED("xBaixa")
                                            SELECT xBaixa
                                            IF SEEK(loc_cPro)
                                                REPLACE qtbaixas WITH qtbaixas - loc_nQtde IN xBaixa
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    IF USED("crTpmMvIts")
                                        SELECT crTpmMvIts
                                        SET ORDER TO
                                        SET ORDER TO CItens
                                        SEEK (loc_cItem)
                                        DO WHILE !EOF("crTpmMvIts") AND crTpmMvIts.CItens = loc_cItem
                                            DELETE
                                            SEEK (loc_cItem)
                                        ENDDO
                                    ENDIF

                                    IF NVL(CrSigCdOpe.CadProds, 0) = 3
                                        THIS.AvaliarExclusaoProduto(loc_cPro, NVL(TprMvCab.EmpdopNums, ""))
                                    ENDIF
                                ENDIF
                            ELSE
                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                                SELECT "" AS Agrupar, COUNT(1) AS Total FROM crTpmMvItn ;
                                    WHERE EMPTY(CPros) INTO CURSOR xApaga GROUP BY 1

                                IF xApaga.Total > 1
                                    SELECT crTpmMvItn
                                    DELETE
                                ELSE
                                    THIS.this_lChamouApaIte = .T.
                                ENDIF

                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                            ENDIF

                            SELECT crTpmMvItn
                            SET ORDER TO CItens
                            GO TOP
                            IF EOF()
                                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CItens) ;
                                    VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, 1)
                            ENDIF

                            loc_cont = 0
                            SELECT crTpmMvItn
                            SCAN
                                loc_cont = loc_cont + 1
                                IF USED("crTpmMvIts")
                                    SELECT crTpmMvIts
                                    SET ORDER TO
                                    SET ORDER TO CItens
                                    SEEK crTpmMvItn.CItens
                                    SCAN WHILE CItens = crTpmMvItn.CItens
                                        REPLACE CItens WITH loc_cont
                                    ENDSCAN
                                ENDIF
                                SELECT crTpmMvItn
                                loc_cIt     = CItens
                                loc_nRecNo2 = RECNO()
                                REPLACE cItem2 WITH loc_cont FOR cItem2 = loc_cIt
                                GO loc_nRecNo2
                                REPLACE CItens WITH loc_cont
                            ENDSCAN

                            THIS.this_nNovoCItem = loc_cont

                            SELECT crTpmMvItn
                            SET ORDER TO
                            GO BOTTOM
                            IF !EOF() AND USED("crTpmMvIts")
                                SELECT crTpmMvIts
                                SET ORDER TO CItens
                                SET KEY TO crTpmMvItn.CItens
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT (loc_cAliasDevol)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao confirmar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.ConfirmarDevolucoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AvaliarExclusaoProduto - Verifica se o produto devolvido ainda tem
    * movimento (SigMvItn), historico (SigMvHst) ou composicao (SigPrCpo)
    * em outro documento; se nao tiver nenhum, acrescenta o codigo a
    * THIS.this_cProdutosParaExcluir (lista separada por virgula) para o
    * Form perguntar ao usuario (MessageBox) e chamar
    * THIS.parentform.ExcluirPro() - equivalente ao bloco "If
    * CrSigCdOpe.CadProds = 3" do confirmar.Click legado.
    *====================================================================
    PROTECTED PROCEDURE AvaliarExclusaoProduto(par_cCodigoProduto, par_cEmpDopNumsAtual)
        LOCAL loc_cSQL, loc_nTotalMov, loc_nTotalHist, loc_nTotalCompo, loc_cProduto, loc_cEmpDopNums

        loc_cProduto     = ALLTRIM(NVL(par_cCodigoProduto, ""))
        loc_cEmpDopNums  = NVL(par_cEmpDopNumsAtual, "")

        loc_cSQL = "SELECT cpros FROM SigMvItn WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaMov")
        loc_nTotalMov = IIF(USED("cursor_4c_VerificaMov"), RECCOUNT("cursor_4c_VerificaMov"), 0)

        loc_cSQL = "SELECT cpros FROM SigMvHst WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaHist")
        loc_nTotalHist = IIF(USED("cursor_4c_VerificaHist"), RECCOUNT("cursor_4c_VerificaHist"), 0)

        loc_cSQL = "SELECT mats FROM SigPrCpo WHERE mats = " + EscaparSQL(loc_cProduto)
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaCompo")
        loc_nTotalCompo = IIF(USED("cursor_4c_VerificaCompo"), RECCOUNT("cursor_4c_VerificaCompo"), 0)

        IF loc_nTotalMov = 0 AND loc_nTotalHist = 0 AND loc_nTotalCompo = 0
            THIS.this_cProdutosParaExcluir = THIS.this_cProdutosParaExcluir + ;
                IIF(EMPTY(THIS.this_cProdutosParaExcluir), "", ",") + loc_cProduto
        ENDIF

        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
    ENDPROC

ENDDEFINE

