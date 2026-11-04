# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, PARCS, CPROS, CODIGOS, DOPES, TPDESC, TIPOS, CGRUS, CDESC, QTDS, 1, ICLIS, DTINICIAL, DTFINAL, DTINI, DTFIN, TPPRO, VALMIN, DATAS, EMPDOPNUMS, SGRUS, UNITORIGS, DESCOS, VALUE, SELECAO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, PARCS, CPROS, CODIGOS, DOPES, TPDESC, TIPOS, CGRUS, CDESC, QTDS, 1, ICLIS, DTINICIAL, DTFINAL, DTINI, DTFIN, TPPRO, VALMIN, DATAS, EMPDOPNUMS, SGRUS, UNITORIGS, DESCOS, VALUE, SELECAO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NASCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, PARCS, CPROS, CODIGOS, DOPES, TPDESC, TIPOS, CGRUS, CDESC, QTDS, 1, ICLIS, DTINICIAL, DTFINAL, DTINI, DTFIN, TPPRO, VALMIN, DATAS, EMPDOPNUMS, SGRUS, UNITORIGS, DESCOS, VALUE, SELECAO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRECODE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, PARCS, CPROS, CODIGOS, DOPES, TPDESC, TIPOS, CGRUS, CDESC, QTDS, 1, ICLIS, DTINICIAL, DTFINAL, DTINI, DTFIN, TPPRO, VALMIN, DATAS, EMPDOPNUMS, SGRUS, UNITORIGS, DESCOS, VALUE, SELECAO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LISTAEMP' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, PARCS, CPROS, CODIGOS, DOPES, TPDESC, TIPOS, CGRUS, CDESC, QTDS, 1, ICLIS, DTINICIAL, DTFINAL, DTINI, DTFIN, TPPRO, VALMIN, DATAS, EMPDOPNUMS, SGRUS, UNITORIGS, DESCOS, VALUE, SELECAO

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column1.ControlSource = ""
SELECT localdes
SELECT crSigmvitd
SELECT localdes
SELECT localdes
SELECT * from xPar where parcs>1 into cursor crPar	&& mena - 13/12/2017 - seleciona recebimentos com parcelas
lcQuery = [Select * from SigcdPro where cpros=']+lcCpros+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crProd]) < 1)
lcQuery = [Select a.* from SigOpTdz a, SigCdTbd c where a.codigos = c.codigos and c.dopes = ']+TprMvCab.dopes+[' and a.tpdesc <> 0]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crDesc]) < 1)
DELETE FROM crDesc where tpDesc = 11 and !listaemp like [%]+lcEmp+[%]
Select 0 as selecao, 000000000.00 as valdes, descos as descosmax, * from crDesc  Order By Codigos into cursor crDesc readwrite
lcQuery = [Select b.*, a.tpdesc, a.listaemp from SigOpTdt b, SigOpTdz a where a.tpdesc <> 0 and a.codigos = b.codigos order by b.cidchaves]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTipo]) < 1)
DELETE FROM crTipo where tpDesc = 11 and !listaemp like [%]+lcEmp+[%]
SELECT SUM(totas) as valtot from crTpmMvItn where citens <> pcItem into cursor crXi
SELECT crTpmMvItn
Select crTpmMvItn
lcQuery = [Select cpros, cgrus from SigcdPro where cpros in]+lcListaP
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crProdL]) < 1)
SELECT codTips as grupoJ, codigos from crTipo where tipos = 1 and tpdesc = 2 into cursor crGruJ
SELECT SUM(qtds) as qtds from crTpmMvItn where cpros in (select cpros from crProdL where cgrus = crGruJ.grupoJ) into cursor crItnJT
SELECT SUM(a.qtds) as qtds from crTpmMvItn a, crSigMvItd c where a.cpros in (select b.cpros from crProdL b where b.cgrus = crGruJ.grupoJ) ;
	SELECT top 1 * from crTpmMvItn a where a.cpros in (select b.cpros from crProdL b where b.cgrus = crGruJ.grupoJ) ;
	(select c.cpros+STR(c.citens) from crSigMvItd c where c.tpdesc = 2 and c.cdesc=crGruJ.codigos ) ;
	SELECT * from crItnJP where cpros = lcCpros and citens = pcItem and qtds = 1 into cursor crItnJD
	SELECT * from crTpmMvItn where 1=0 into cursor crItnJD
SELECT * from crSigmvitd where cpros=lcCpros and citens = pcItem and tpdesc=2 and cdesc=crGruJ.codigos into cursor crItdJ
SELECT crTpmMvItn
lcQuery = [Select cpros from SigcdPro where cpros=']+lcCpros+[' and (foralinha=1) ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crFora]) < 1)
lcQuery = [Select cpros from SigcdPro where cpros=']+lcCpros+[' and (precode <> 0) ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crDepor]) < 1)
lcQuery = [Select * from SigcdCli where iclis=']+TprMvCab.contads+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crClid]) < 1)
lcQuery = [Select * from Sigimppr where cpros=']+lcCpros+[' and dtInicial <= ?TprMvCab.datas and dtfinal >=?TprMvCab.datas ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crProPro]) < 1)
lcQuery = [Select * from SigcdPmc where cpros=']+lcCpros+[' and dtIni <= ?TprMvCab.datas and dtfin >=?TprMvCab.datas and tppro=1 and valmin <= ]+lcValtot
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPromo]) < 1)
lcQuery = [Select * from SigprPre where cpros=']+lcCpros+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPre]) < 1)
SELECT pvens-pvensant as valdif, ROUND((pvens-pvensant)/pvens*100,2) as descos  from crPre where datas >= ldData into cursor crPre readwrite
SELECT * from crProd where 1=0 into cursor crProdS
SELECT * from crTpmMvItn where 1=0 into cursor crItns
	SELECT * from crEesti where empdopnums <> TprMvCab.empdopnums into cursor crItns
	lcQuery = [Select * from SigcdPro where cpros=']+crItns.cpros+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crProdS]) < 1)
SELECT * from crTipo where tipos = 1 and tpdesc = 2 order by cidchaves into cursor crTipoJ	&& seleciona os grupos - para desconto extra alianca
SELECT * from crProd where cgrus in (select codtips from crTipoJ) into cursor crGrJ			&& seleciona se grupo desse produto está na configuração do desconto
SELECT * from crTipo where tipos = 1 and tpdesc = 3 order by cidchaves into cursor crTipoRe					&& seleciona os grupos - para desconto relogio
SELECT top 1 * from crTipo where tipos = 8 and tpdesc = 7 order by cidchaves into cursor crTipoSG1			&& seleciona o subgrupos maior  - para desconto updiamound
SELECT top 1 * from crTipo where tipos = 8 and tpdesc = 7 order by cidchaves desc into cursor crTipoSG2		&& seleciona os subgrupos menor - para desconto updiamound
SELECT * from crTipo where tipos = 1 and tpdesc = 10 order by cidchaves into cursor crTipoAl				&& seleciona os grupos - para upgrade alianca
SELECT * from crProd where cgrus in (select codtips from crTipoRe) into cursor crGrRe	&& seleciona se grupo desse produto está na configuração do desconto
SELECT * from crProd where sgrus in (select codtips from crTipoSG1) into cursor crSG1	&& seleciona se subgrupo desse produto está na configuracao do desconto
SELECT * from crProdS where sgrus in (select codtips from crTipoSG1) into cursor crSG1S	&& seleciona se subgrupo do produto snivel está na configuracao do desconto
SELECT * from crProdS where sgrus in (select codtips from crTipoSG2) into cursor crSG2S	&& seleciona se subgrupo do produto snivel está na configuracao do desconto
SELECT * from crProd where cgrus in (select codtips from crTipoAl)  into cursor crGrAl	&& seleciona se grupo desse produto (al) está na configuração do desconto
SELECT * from crProdS where cgrus in (select codtips from crTipoAl) into cursor crGrAlS	&& seleciona se grupo do produto snivel está na configuracao do desconto
SELECT * from crItnS where cpros = lcCpros into cursor crItnZ	&& troca zerada
SELECT * from crItnS where cpros in (select cpros from crProdS where cgrus+codcors+colecoes+codfinp = lcProdCha) into cursor crItnUD	&& troca up diamond
SELECT * from crItnS where cpros in (select cpros from crProdS where cgrus = lcProdCha) into cursor crItnUL
SELECT * from crTipo where tipos = 1 and tpdesc = 11 order by cidchaves into cursor crTipoExAl	&& seleciona os grupos - para desconto extra alianca
SELECT * from crProd where cgrus in (select codtips from crTipoExAl) into cursor crGrAl			&& seleciona se grupo desse produto está na configuração do desconto
&&SELECT * from crDesc where lcEmp$NVL(listaemp,'') into cursor crDesExt readwrite
SELECT *, SPACE(10) as usuars from crDesc into cursor localDes readwrite
SELECT localDes
	DELETE for INLIST(tpdesc,6,7,10)	&& se desconto de troca não entra
	DELETE for tpdesc=11 and codigos = crTipoExAl.codigos		&& mena 11/05/2017 - exclui só o tipo alianca 
	DELETE for INLIST(tpdesc,13)
	DELETE for INLIST(tpdesc,7)	
	DELETE for INLIST(tpdesc,6)	
	DELETE for INLIST(tpdesc,10)	
	DELETE for INLIST(tpdesc,3)
	DELETE for INLIST(tpdesc,1)	 
	DELETE for !INLIST(tpdesc,8,9)
	DELETE for INLIST(tpdesc,12)
	DELETE for !INLIST(tpdesc,2,8,9)
	DELETE for tpdesc=2 and codigos = crTipoJ.codigos
SELECT * from crSigmvitd where cpros=lcCpros and citens = pcItem into cursor crOpItd
SELECT localDes
	SELECT crOpItd
	SELECT localDes
SELECT crSigCdDes
This.GrdCota.Column1.ControlSource = [crSigCdDes.emps]
This.GrdCota.Column3.ControlSource = [crSigCdDes.valcota]
This.GrdCota.Column4.ControlSource = [crSigCdDes.Valdes]
SELECT localDes
This.Grade.Column1.ControlSource = [localDes.Selecao]
This.Grade.Column2.ControlSource = [localDes.Descrs]
This.Grade.Column3.ControlSource = [localDes.Descos]
This.Grade.Column4.ControlSource = [localDes.Valdes]
This.Grade.Column1.ControlSource = []
This.Grade.Column2.ControlSource = []
This.Grade.Column3.ControlSource = []
This.Grade.Column4.ControlSource = []
Select localDes
SELECT crsigmvitd
DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
Select localDes
DELETE ALL for descos = 0
		INSERT into crSigmvItd (citens, emps, dopes, numes, cpros, cidchaves, empdopnums, dtalts, cdesc, ddesc, pdes, vdes, valbase, tpdesc, codigo, usuars) values;
	Update localDes Set Selecao = 0
	Update localDes Set Selecao = 1
SELECT crDesc
SELECT localDes
Select crDesc
Select localdes

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg) - TRECHOS RELEVANTES PARA PASS SQL (2757 linhas total):

*-- Linhas 253 a 271:
253:     *--------------------------------------------------------------------------
254:     * Quantidade de recebimentos PARCELADOS do movimento - equivalente a
255:     * RECCOUNT('crPar') do legado, que vem de
256:     * "SELECT * from xPar where parcs > 1 into cursor crPar" no Init. xPar
257:     * e' um cursor GLOBAL do form chamador (a tela de venda), igual a
258:     * TprMvCab/crTpmMvItn: nao existe nesta arquitetura, entao chega por
259:     * parametro no Init como todo o resto do contexto.
260:     *
261:     * Usado SO pelos dois Valid de celula desta fase (a regra "desconto
262:     * financeiro nao e' permitido para pagamento parcelado", tipo 2) - nao
263:     * vai para o BO porque nao alimenta SQL nem gravacao, e espelhar
264:     * contexto que o BO nao consome so criaria um segundo lugar para
265:     * divergir.
266:     *
267:     * Zero (o default quando o chamador omite o parametro) reproduz
268:     * exatamente o legado com crPar VAZIO: a regra nao bloqueia nada.
269:     *--------------------------------------------------------------------------
270:     this_nQtdParcelas = 0
271: 

*-- Linhas 415 a 433:
415: 
416:             *-- Carga das duas grades. Pulada em validacao de UI e em modo
417:             *-- de teste porque nesses modos nao ha conexao: gnConnHandle
418:             *-- invalido faz o SQLEXEC disparar excecao, e a tela deixaria
419:             *-- de instanciar por falta de banco, nao por defeito de layout.
420:             *-- O retorno e' descartado de proposito - a falha de carga ja
421:             *-- foi reportada pelo BO e a tela abre com a grade vazia, em
422:             *-- vez de nao abrir.
423:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
424:                (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
425:                 THIS.CarregarLista()
426:             ENDIF
427: 
428:             loc_lSucesso = .T.
429:         CATCH TO loc_oErro
430:             loc_lSucesso = .F.
431:             THIS.this_cMensagemErro = loc_oErro.Message
432:             MsgErro(loc_oErro.Message + CHR(13) + ;
433:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 561 a 628:
561:     * Column (ColumnCount = 3), com os 2 ultimos renomeados (.Name =
562:     * "Column3"/"Column4") por terem sobrado de um ColumnCount = 4 original
563:     * (a 2a coluna, ValMeta, esta comentada no Init - "*!*This.GrdCota.
564:     * Column2.ControlSource = [crSigCdDes.valmeta]") - aqui os 3 Column
565:     * ficam na ordem natural 1/2/3 (PILAR 3 nao exige preservar o
566:     * artefato de rename).
567:     *
568:     * O cursor cursor_4c_Cota e' criado vazio AQUI porque Column.ControlSource
569:     * exige que o cursor JA exista: atribuir ControlSource de cursor
570:     * inexistente estoura "Alias is not found" dentro do TRY do
571:     * InicializarForm, o CREATEOBJECT devolve .F. e o usuario aciona a tela
572:     * e nada acontece, sem erro visivel. Quem popula de verdade e'
573:     * SigOpDesBO.CarregarCota, chamada por CarregarLista.
574:     *==========================================================================
575:     PROTECTED PROCEDURE ConfigurarGradeCota()
576:         LOCAL loc_oGrdCota
577: 
578:         *-- Estrutura inicial com a MESMA lista de colunas que
579:         *-- SigOpDesBO.CarregarCota recria: APPEND FROM casa as colunas por
580:         *-- NOME, e coluna faltando aqui sumiria da grade em silencio.
581:         IF !USED("cursor_4c_Cota")
582:             SET NULL ON
583:             CREATE CURSOR cursor_4c_Cota ;
584:                 (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
585:                  Codigo C(10), Valmeta N(11,2))
586:             SET NULL OFF
587:         ENDIF
588: 
589:         THIS.AddObject("grd_4c_Cota", "Grid")
590:         loc_oGrdCota = THIS.grd_4c_Cota
591: 
592:         WITH loc_oGrdCota
593:             .ColumnCount  = 3
594:             .RecordSource = "cursor_4c_Cota"
595:             .Top          = 85
596:             .Left         = 25
597:             .Width        = 413
598:             .Height       = 39
599:             .FontName     = "Verdana"
600:             .FontSize     = 8
601:             .HeaderHeight = 22
602:             .RowHeight    = 16
603:             .ScrollBars   = 2
604:             .ReadOnly     = .T.
605:             .RecordMark   = .F.
606:             .DeleteMark   = .F.
607:             .TabIndex     = 1
608:             .Visible      = THIS.AcessoGradeCota()
609:         ENDWITH
610: 
611:         *-- Column1: Empresa (crSigCdDes.emps)
612:         WITH loc_oGrdCota.Column1
613:             .ControlSource = "cursor_4c_Cota.Emps"
614:             .Width         = 75
615:             .Movable       = .F.
616:             .Resizable     = .F.
617:             .ReadOnly      = .T.
618:             .Visible       = .T.
619:         ENDWITH
620:         WITH loc_oGrdCota.Column1.Text1
621:             .BorderStyle = 0
622:             .InputMask   = ""
623:             .Margin      = 0
624:             .ReadOnly    = .T.
625:             .ForeColor   = RGB(0, 0, 0)
626:             .BackColor   = RGB(255, 255, 255)
627:             .Visible     = .T.
628:         ENDWITH

*-- Linhas 635 a 676:
635: 
636:         *-- Column2: Cota (crSigCdDes.valcota)
637:         WITH loc_oGrdCota.Column2
638:             .ControlSource = "cursor_4c_Cota.ValCota"
639:             .Width         = 145
640:             .ReadOnly      = .T.
641:             .Visible       = .T.
642:         ENDWITH
643:         WITH loc_oGrdCota.Column2.Text1
644:             .BorderStyle = 0
645:             .Format      = "999,999,999.99"
646:             .InputMask   = ""
647:             .Margin      = 0
648:             .ReadOnly    = .T.
649:             .ForeColor   = RGB(0, 0, 0)
650:             .BackColor   = RGB(255, 255, 255)
651:         ENDWITH
652:         WITH loc_oGrdCota.Column2.Header1
653:             .FontName  = "Verdana"
654:             .FontSize  = 8
655:             .Alignment = 2
656:             .Caption   = "Cota"
657:         ENDWITH
658: 
659:         *-- Column3: Utilizada (crSigCdDes.Valdes)
660:         WITH loc_oGrdCota.Column3
661:             .ControlSource = "cursor_4c_Cota.Valdes"
662:             .Width         = 169
663:             .ReadOnly      = .T.
664:             .Visible       = .T.
665:         ENDWITH
666:         WITH loc_oGrdCota.Column3.Text1
667:             .BorderStyle = 0
668:             .Margin      = 0
669:             .ReadOnly    = .T.
670:             .ForeColor   = RGB(0, 0, 0)
671:             .BackColor   = RGB(255, 255, 255)
672:         ENDWITH
673:         WITH loc_oGrdCota.Column3.Header1
674:             .FontName  = "Verdana"
675:             .FontSize  = 8
676:             .Alignment = 2

*-- Linhas 692 a 739:
692:     *
693:     * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
694:     * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
695:     * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
696:     * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
697:     * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de
698:     * destino SigMvItd.pdes numeric(7,4) e SigMvItd.vdes numeric(9,2),
699:     * gravadas por SigOpDesBO.Inserir().
700:     *
701:     * As celulas de Column2/3/4 sao instaladas por InstalarCelulasGrade
702:     * (Fase 6/8), que poe em cada coluna uma SUBCLASSE de TextBox com o
703:     * When/Valid do legado embutido - as propriedades visuais que o dump
704:     * declara em ColumnN.Text1 passam a ser aplicadas nessa subclasse, que
705:     * e' quem desenha e edita a celula a partir do CurrentControl.
706:     *
707:     * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
708:     * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
709:     * (Fase 7/8) ficam no fim do metodo.
710:     *==========================================================================
711:     PROTECTED PROCEDURE ConfigurarGrade()
712:         LOCAL loc_oGrade
713: 
714:         *-- Estrutura inicial com a MESMA lista de colunas que
715:         *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
716:         *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
717:         *-- tambem mantem em localDes e que os fluxos de validacao e de
718:         *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
719:         *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
720:         *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
721:         *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
722:         IF !USED("cursor_4c_Dados")
723:             SET NULL ON
724:             CREATE CURSOR cursor_4c_Dados ;
725:                 (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
726:                  Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
727:                  Descosmax N(7,4), Usuars C(10))
728:             SET NULL OFF
729:         ENDIF
730: 
731:         THIS.AddObject("grd_4c_Dados", "Grid")
732:         loc_oGrade = THIS.grd_4c_Dados
733: 
734:         WITH loc_oGrade
735:             .ColumnCount  = 4
736:             .RecordSource = "cursor_4c_Dados"
737:             .Top          = 131
738:             .Left         = 24
739:             .Width        = 748

*-- Linhas 745 a 770:
745:             .ScrollBars   = 2
746:             .ReadOnly     = .F.
747:             .RecordMark   = .F.
748:             .DeleteMark   = .F.
749:             .TabIndex     = 1
750:             .Visible      = .T.
751:         ENDWITH
752: 
753:         *-- Column1: checkbox de selecao (fwcheckbox1 do legado)
754:         WITH loc_oGrade.Column1
755:             .ControlSource = "cursor_4c_Dados.Selecao"
756:             .Width         = 23
757:             .Alignment     = 2
758:             .Movable       = .F.
759:             .Resizable     = .F.
760:             .ReadOnly      = .F.
761:             .Sparse        = .F.
762:             .Format        = "K!"
763:             .ForeColor     = RGB(0, 0, 0)
764:             .Visible       = .T.
765:         ENDWITH
766: 
767:         loc_oGrade.Column1.AddObject("chk_4c_Selecao", "CheckBox")
768:         WITH loc_oGrade.Column1.chk_4c_Selecao
769:             .Top       = 31
770:             .Left      = 12

*-- Linhas 804 a 852:
804: 
805:         *-- Column2: descricao do tipo de desconto (localDes.Descrs)
806:         WITH loc_oGrade.Column2
807:             .ControlSource = "cursor_4c_Dados.Descrs"
808:             .Width         = 500
809:             .Movable       = .F.
810:             .Resizable     = .F.
811:             .ReadOnly      = .F.
812:             .Visible       = .T.
813:         ENDWITH
814:         WITH loc_oGrade.Column2.Header1
815:             .FontName  = "Verdana"
816:             .FontSize  = 8
817:             .Alignment = 2
818:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
819:         ENDWITH
820: 
821:         *-- Column3: percentual de desconto (localDes.Descos)
822:         WITH loc_oGrade.Column3
823:             .ControlSource = "cursor_4c_Dados.Descos"
824:             .Width         = 88
825:             .ReadOnly      = .F.
826:             .Visible       = .T.
827:         ENDWITH
828:         WITH loc_oGrade.Column3.Header1
829:             .FontName  = "Verdana"
830:             .FontSize  = 8
831:             .Alignment = 2
832:             .Caption   = "% Desconto"
833:         ENDWITH
834: 
835:         *-- Column4: valor do desconto (localDes.Valdes)
836:         WITH loc_oGrade.Column4
837:             .ControlSource = "cursor_4c_Dados.Valdes"
838:             .Width         = 110
839:             .ReadOnly      = .F.
840:             .Visible       = .T.
841:         ENDWITH
842:         WITH loc_oGrade.Column4.Header1
843:             .FontName  = "Verdana"
844:             .FontSize  = 8
845:             .Alignment = 2
846:             .Caption   = "Valor Desconto"
847:         ENDWITH
848: 
849:         *-- Celulas digitaveis / bloqueadas das colunas 2, 3 e 4. Fica por
850:         *-- ULTIMO porque Column.ReadOnly tem de ser definido DEPOIS de
851:         *-- Grid.ReadOnly (o do grid propaga para as colunas e sobrescreve
852:         *-- o delas - regra CLAUDE.md #46).

*-- Linhas 1081 a 1099:
1081:     * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
1082:     *
1083:     * O guard de modo existe porque fChecaAcesso abre conexao propria
1084:     * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
1085:     * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
1086:     * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
1087:     * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
1088:     * cota nao teria o que mostrar de qualquer forma.
1089:     *==========================================================================
1090:     PROTECTED FUNCTION AcessoGradeCota()
1091:         LOCAL loc_lAcesso
1092: 
1093:         loc_lAcesso = .F.
1094: 
1095:         IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
1096:            (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
1097:             loc_lAcesso = fChecaAcesso("SIGCDDES", "GERENTE")
1098:         ENDIF
1099: 

*-- Linhas 1110 a 1129:
1110:     *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
1111:     * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
1112:     * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
1113:     * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
1114:     * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
1115:     *
1116:     * PUBLIC de proposito: o harness de teste automatizado chama
1117:     * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
1118:     * para metodo PROTECTED e a chamada real falharia em runtime).
1119:     *
1120:     * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
1121:     *==========================================================================
1122:     PROCEDURE CarregarLista()
1123:         LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro
1124: 
1125:         loc_lSucesso = .F.
1126: 
1127:         TRY
1128:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1129:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;

*-- Linhas 1184 a 1282:
1184:     * recria os objetos Column e DESTRUIRIA o CheckBox posto por
1185:     * AddObject em Column1 (com ele, a coluna de selecao da grade).
1186:     *
1187:     * O rebind completo (RecordSource -> ControlSource -> Width ->
1188:     * Header1.Caption -> CurrentControl/Sparse) so roda quando o
1189:     * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
1190:     * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
1191:     * seria apagar o que ConfigurarGrade acabou de montar. Na carga
1192:     * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
1193:     * Refresh.
1194:     *==========================================================================
1195:     PROCEDURE MontaGrade()
1196:         LOCAL loc_oGrade, loc_oGrdCota, loc_oErro
1197: 
1198:         TRY
1199:             *-- Grade principal de descontos
1200:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1201:                 loc_oGrade = THIS.grd_4c_Dados
1202: 
1203:                 IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
1204:                     THIS.VincularGrade()
1205:                 ENDIF
1206: 
1207:                 SELECT cursor_4c_Dados
1208:                 GO TOP
1209:                 loc_oGrade.Refresh()
1210:             ENDIF
1211: 
1212:             *-- Grade da cota da empresa
1213:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
1214:                 loc_oGrdCota = THIS.grd_4c_Cota
1215: 
1216:                 IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
1217:                     THIS.VincularGradeCota()
1218:                 ENDIF
1219: 
1220:                 SELECT cursor_4c_Cota
1221:                 GO TOP
1222:                 loc_oGrdCota.Refresh()
1223:             ENDIF
1224: 
1225:             *-- Volta o alias corrente para a grade principal, que e' a
1226:             *-- que recebe o foco e de onde os eventos de celula leem.
1227:             IF USED("cursor_4c_Dados")
1228:                 SELECT cursor_4c_Dados
1229:             ENDIF
1230:         CATCH TO loc_oErro
1231:             MsgErro(loc_oErro.Message + CHR(13) + ;
1232:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1233:                     "Procedure: " + loc_oErro.Procedure, ;
1234:                     "Erro em MontaGrade")
1235:         ENDTRY
1236:     ENDPROC
1237: 
1238:     *==========================================================================
1239:     * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
1240:     * que a atribuicao de RecordSource reseta.
1241:     *
1242:     * Atribuir RecordSource devolve Column.Width ao default 90, limpa
1243:     * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
1244:     * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
1245:     * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
1246:     * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
1247:     * dump em ConfigurarGrade.
1248:     *
1249:     * ColumnCount fica de fora: reatribui-lo recriaria os Column e
1250:     * destruiria o CheckBox de Column1.
1251:     *==========================================================================
1252:     PROTECTED PROCEDURE VincularGrade()
1253:         LOCAL loc_oGrade
1254: 
1255:         loc_oGrade = THIS.grd_4c_Dados
1256: 
1257:         *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
1258:         *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
1259:         *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
1260:         *-- unico jeito de marcar a linha. Por isso, aqui:
1261:         *-- NAO reatribuir ColumnCount.
1262:         loc_oGrade.RecordSource = "cursor_4c_Dados"
1263: 
1264:         loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
1265:         loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1266:         loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
1267:         loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"
1268: 
1269:         loc_oGrade.Column1.Width = 23
1270:         loc_oGrade.Column2.Width = 500
1271:         loc_oGrade.Column3.Width = 88
1272:         loc_oGrade.Column4.Width = 110
1273: 
1274:         loc_oGrade.Column1.Header1.Caption = ""
1275:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
1276:                                              "o do Desconto"
1277:         loc_oGrade.Column3.Header1.Caption = "% Desconto"
1278:         loc_oGrade.Column4.Header1.Caption = "Valor Desconto"
1279: 
1280:         *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
1281:         *-- CheckBox de selecao, apesar de existir, nao aparece; sem
1282:         *-- Sparse = .F. ele apareceria so na linha ativa.

*-- Linhas 1296 a 1333:
1296:     *==========================================================================
1297:     * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
1298:     * que a atribuicao de RecordSource reseta (mesma regra de ordem de
1299:     * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
1300:     * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
1301:     * natural, com as larguras e captions do dump.
1302:     *
1303:     * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
1304:     * as colunas e sobrescreveria o das colunas.
1305:     *==========================================================================
1306:     PROTECTED PROCEDURE VincularGradeCota()
1307:         LOCAL loc_oGrdCota
1308: 
1309:         loc_oGrdCota = THIS.grd_4c_Cota
1310: 
1311:         *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
1312:         *-- larguras do dump sao montadas por ConfigurarGradeCota, e
1313:         *-- reatribuir ColumnCount as recriaria do zero.
1314:         loc_oGrdCota.RecordSource = "cursor_4c_Cota"
1315: 
1316:         loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
1317:         loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
1318:         loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"
1319: 
1320:         loc_oGrdCota.Column1.Width = 75
1321:         loc_oGrdCota.Column2.Width = 145
1322:         loc_oGrdCota.Column3.Width = 169
1323: 
1324:         loc_oGrdCota.Column1.Header1.Caption = "Empresa"
1325:         loc_oGrdCota.Column2.Header1.Caption = "Cota"
1326:         loc_oGrdCota.Column3.Header1.Caption = "Utilizada"
1327: 
1328:         loc_oGrdCota.ReadOnly         = .T.
1329:         loc_oGrdCota.Column1.ReadOnly = .T.
1330:         loc_oGrdCota.Column2.ReadOnly = .T.
1331:         loc_oGrdCota.Column3.ReadOnly = .T.
1332:     ENDPROC
1333: 

*-- Linhas 1510 a 1528:
1510:     *   lnReg = IIF(EOF('localdes'), 0, RECNO())
1511:     *   GO top / SUM valdes to lnTDesc
1512:     *   GO top / SUM valdes to lnTDescI for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1513:     *   SELECT crSigmvitd / GO top
1514:     *   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
1515:     *                           AND citens <> pcItem
1516:     *   replace valdes with crValdes.vdes + lnTDescI + lnTDescM in crSigCdDes
1517:     *   lnSaldo = lnvalor.value - lnTDesc
1518:     *   lnSaldo.Value = lnSaldo / lnTdesc.Value = lnTDesc
1519:     *   IF lnReg <> 0 / GO lnReg / endif
1520:     *   thisform.Refresh
1521:     *
1522:     * Os dois primeiros REPLACE sao SEM escopo no legado, isto e' valem
1523:     * para a linha CORRENTE e nao para o cursor inteiro - quem muda e' a
1524:     * linha que o usuario acabou de marcar ou editar.
1525:     *
1526:     * lnTDescM (descontos JA GRAVADOS dos OUTROS itens do movimento) vem
1527:     * de crSigmvitd, cursor global do form chamador que esta arquitetura
1528:     * nao tem: a soma e' resolvida uma vez na carga por

*-- Linhas 1555 a 1573:
1555:             ELSE
1556:                 loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
1557: 
1558:                 SELECT cursor_4c_Dados
1559: 
1560:                 *-- Linha corrente: desmarcada zera os dois campos, marcada
1561:                 *-- recalcula o valor a partir do percentual.
1562:                 IF !EOF("cursor_4c_Dados")
1563:                     IF NVL(cursor_4c_Dados.Selecao, 0) = 0
1564:                         REPLACE Descos WITH 0, ;
1565:                                 Valdes WITH 0 ;
1566:                             IN cursor_4c_Dados
1567:                     ELSE
1568:                         REPLACE Valdes WITH ROUND(loc_nValor * ;
1569:                                 NVL(cursor_4c_Dados.Descos, 0) / 100, 2) ;
1570:                             IN cursor_4c_Dados
1571:                     ENDIF
1572:                 ENDIF
1573: 

*-- Linhas 1624 a 1642:
1624:                 *-- properties, que foi exatamente o que esta fase desfez.
1625:                 THIS.FormParaBO()
1626: 
1627:                 SELECT cursor_4c_Dados
1628:                 IF loc_nReg <> 0 AND loc_nReg <= RECCOUNT("cursor_4c_Dados")
1629:                     GO loc_nReg IN cursor_4c_Dados
1630:                 ENDIF
1631: 
1632:                 THIS.Refresh()
1633:             ENDIF
1634:         CATCH TO loc_oErro
1635:             MsgErro(loc_oErro.Message + CHR(13) + ;
1636:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1637:                     "Procedure: " + loc_oErro.Procedure, ;
1638:                     "Erro em CalcularTotais")
1639:         ENDTRY
1640:     ENDPROC
1641: 
1642:     *==========================================================================

*-- Linhas 1665 a 1695:
1665:     * Legado (PROCEDURE btnConfirmar.Click):
1666:     *
1667:     *   ThisForm.Grade.Refresh
1668:     *   Select localDes / Go Top In localDes / ThisForm.Grade.Refresh
1669:     *   SELECT crsigmvitd
1670:     *   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
1671:     *   Select localDes / DELETE ALL for descos = 0 / GO top
1672:     *   SCAN
1673:     *       If (localDes.Selecao = 1)
1674:     *           lcIdChave = fUniqueIds()
1675:     *           INSERT into crSigmvItd (...) values (...)
1676:     *       ENDIF
1677:     *   ENDSCAN
1678:     *   ThisForm.Release
1679:     *
1680:     * "DELETE ALL for descos = 0" marca deletadas (SET DELETED liga) as
1681:     * linhas com desconto zero, e o SCAN so insere as que sobrevivem E tem
1682:     * Selecao = 1 - equivalente a "Selecao = 1 AND Descos <> 0", que e' o
1683:     * filtro usado no SCAN de ConfirmarSelecaoExec.
1684:     *
1685:     * O par wrapper + Exec existe pela mesma razao de ValidarPercentualDesconto
1686:     * (regra CLAUDE.md #1): o corpo tem SCAN/loop e chamadas de BO que podem
1687:     * estourar, e o Release() final tem de rodar FORA do TRY. Release()
1688:     * acontece SEMPRE, inclusive apos erro - igual ao legado, que nao tem
1689:     * TRY/CATCH nenhum e sempre libera o dialogo no fim.
1690:     *
1691:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1692:     *==========================================================================
1693:     PROCEDURE BtnConfirmarClick()
1694:         LOCAL loc_oErro
1695: 

*-- Linhas 1711 a 1734:
1711:     * cada tipo de desconto marcado na grade com valor diferente de zero.
1712:     *
1713:     * SigOpDesBO.ExcluirDescontosDoItem() substitui o
1714:     * "DELETE all for cpros = ... and citens = ..." em crsigmvitd (cursor
1715:     * global do form chamador): aqui a tabela e' acessada direto, restrita
1716:     * ao mesmo par cpros/citens.
1717:     *
1718:     * Cada iteracao do SCAN preenche no BO exatamente as colunas que o
1719:     * INSERT do legado usa alem do contexto fixo do item (ja presente nas
1720:     * properties this_cCpros/this_nCitens/this_cEmps/this_cDopes/
1721:     * this_nNumes, herdadas do Init do form): Cdesc/Ddesc/Pdes/Vdes/TpDesc/
1722:     * Usuars vem da linha corrente de cursor_4c_Dados, ValBase vem de
1723:     * this_nUnitOrigs (legado: "crTpmMvItn.unitorigs") e Codigo (a cota
1724:     * vigente, "crSigcdDes.codigo") ja foi resolvido por
1725:     * SigOpDesBO.CarregarCota na abertura da tela e permanece em
1726:     * this_oBusinessObject.this_cCodigo.
1727:     *
1728:     * this_cCidChaves e' zerado ANTES de cada Inserir(): e' o gatilho que faz
1729:     * Inserir() gerar um fUniqueIds() NOVO por linha (regra CLAUDE.md #22) -
1730:     * equivalente a "lcIdChave = fUniqueIds()" dentro do SCAN do legado.
1731:     *==========================================================================
1732:     PROCEDURE ConfirmarSelecaoExec()
1733:         LOCAL loc_lExcluiu
1734: 

*-- Linhas 1757 a 1775:
1757:             RETURN
1758:         ENDIF
1759: 
1760:         SELECT cursor_4c_Dados
1761:         GO TOP
1762: 
1763:         SCAN FOR NVL(Selecao, 0) = 1 AND NVL(Descos, 0) <> 0
1764:             WITH THIS.this_oBusinessObject
1765:                 *-- this_cCidChaves zerado a cada volta e' o gatilho que faz
1766:                 *-- Inserir() gerar um fUniqueIds() NOVO por linha (regra
1767:                 *-- CLAUDE.md #22) - equivalente ao "lcIdChave =
1768:                 *-- fUniqueIds()" dentro do SCAN do legado. Sem isto a
1769:                 *-- segunda linha colidiria no indice unico.
1770:                 .this_cCidChaves = ""
1771: 
1772:                 *-- Campos da LINHA corrente da grade (legado: localdes.*)
1773:                 .this_cCdesc     = cursor_4c_Dados.Codigos
1774:                 .this_cDdesc     = cursor_4c_Dados.Descrs
1775:                 .this_nPdes      = cursor_4c_Dados.Descos

*-- Linhas 1783 a 1845:
1783: 
1784:             THIS.this_oBusinessObject.Inserir()
1785: 
1786:             SELECT cursor_4c_Dados
1787:         ENDSCAN
1788:     ENDPROC
1789: 
1790:     *==========================================================================
1791:     * Header1Click - SIGOPDES.Grade.Column1.Header1.Click (selecionar/
1792:     * desmarcar TODAS as linhas da grade principal).
1793:     *
1794:     * Legado:
1795:     *
1796:     *   If (This.parent.Header1.Tag = [X])
1797:     *       This.parent.Header1.Tag = [ ]
1798:     *       Update localDes Set Selecao = 0
1799:     *   Else
1800:     *       This.parent.Header1.Tag = [X]
1801:     *       Update localDes Set Selecao = 1
1802:     *   EndIf
1803:     *   ThisForm.Grade.Refresh
1804:     *
1805:     * This.parent.Header1 e' o proprio Header1 (This.parent = Column1) - o
1806:     * Tag dele guarda o estado do toggle entre um clique e outro, igual ao
1807:     * que fica aqui em loc_oHeader.Tag (propriedade nativa, generica, de
1808:     * qualquer objeto VFP).
1809:     *
1810:     * NAO chama CalcularTotais - e' FIEL ao legado, que tambem so faz o
1811:     * Update + Refresh aqui. "Selecionar tudo" marca Selecao em TODAS as
1812:     * linhas sem passar pela autorizacao (SigOpSen) que o Click do checkbox
1813:     * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
1814:     * desta migracao.
1815:     *
1816:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1817:     *==========================================================================
1818:     PROCEDURE Header1Click()
1819:         LOCAL loc_oHeader, loc_oErro
1820: 
1821:         TRY
1822:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1823:                 loc_oHeader = THIS.grd_4c_Dados.Column1.Header1
1824: 
1825:                 IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
1826:                     loc_oHeader.Tag = ""
1827:                     UPDATE cursor_4c_Dados SET Selecao = 0
1828:                 ELSE
1829:                     loc_oHeader.Tag = "X"
1830:                     UPDATE cursor_4c_Dados SET Selecao = 1
1831:                 ENDIF
1832: 
1833:                 THIS.grd_4c_Dados.Refresh()
1834:             ENDIF
1835:         CATCH TO loc_oErro
1836:             MsgErro(loc_oErro.Message + CHR(13) + ;
1837:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1838:                     "Procedure: " + loc_oErro.Procedure, ;
1839:                     "Erro em Header1Click")
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
1845:     * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de

*-- Linhas 2059 a 2077:
2059:     *
2060:     * Transcricao do legado, regra por regra:
2061:     *
2062:     *   SELECT crDesc / LOCATE for codigos = localdes.codigos
2063:     *   IF this.Value > crDesc.descosmax -> "Desconto maior que o permitido"
2064:     *   IF crDesc.tpdesc = 2 and RECCOUNT('crPar') <> 0 and this.Value > 0
2065:     *      -> "Desconto nao permitido para pagamento parcelado."
2066:     *   thisform.calctots()
2067:     *   IF (lnSaldo.Value < 0) or (crSigCdDes.valdes > crSigCdDes.valcota
2068:     *      and !INLIST(crDesc.tpdesc,1,2,9,11))
2069:     *      -> "Desconto maior que o permitido"
2070:     *
2071:     * O LOCATE do legado procura em crDesc a linha de MESMO codigos da
2072:     * linha corrente de localDes. Nesta arquitetura crDesc e localDes
2073:     * foram FUNDIDOS num cursor so (cursor_4c_Dados, montado por
2074:     * SigOpDesBO.CarregarDescontos: Descos/Valdes sao as colunas editaveis
2075:     * de localDes e Descosmax/Tpdesc/Codigos vem de crDesc), entao "a
2076:     * linha de crDesc com o mesmo codigos" E' a linha corrente - o LOCATE
2077:     * deixa de ser necessario em vez de ser descartado.

*-- Linhas 2208 a 2226:
2208:     * percentual explicitamente, o valor recusado voltaria ao cursor.
2209:     * Zerar os dois e' o estado em que o legado converge depois do
2210:     * write-back, escrito de forma deterministica em vez de depender da
2211:     * ordem em que o VFP devolve o valor do controle ao ControlSource.
2212:     *==========================================================================
2213:     PROTECTED FUNCTION ValidarValorDescontoExec(par_oTxt)
2214:         LOCAL loc_nDigitado, loc_nValor, loc_nPdes, loc_nTeto, loc_nTpDesc
2215: 
2216:         IF VARTYPE(par_oTxt) != "O" OR !USED("cursor_4c_Dados") OR ;
2217:            EOF("cursor_4c_Dados")
2218:             RETURN .T.
2219:         ENDIF
2220: 
2221:         loc_nDigitado = THIS.ValorNumerico(par_oTxt.Value)
2222:         loc_nValor    = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
2223:         loc_nTeto     = NVL(cursor_4c_Dados.Descosmax, 0)
2224:         loc_nTpDesc   = NVL(cursor_4c_Dados.Tpdesc, 0)
2225: 
2226:         *-- Valor digitado convertido em percentual sobre o valor original

*-- Linhas 2432 a 2450:
2432:     * O inverso do FormParaBO, e com o mesmo alcance: os TRES campos de total
2433:     * da tela (Valor Original / Total Desconto / Saldo). Nao ha mais nada para
2434:     * espelhar - os campos editaveis desta tela nao sao controles do form, sao
2435:     * as CELULAS da grade, e elas leem de cursor_4c_Dados por ControlSource
2436:     * (quem repinta e' MontaGrade, nao este metodo).
2437:     *
2438:     * Legado equivalente, no fim do Init: "this.lnValor.value =
2439:     * crTpmMvItn.unitorigs" seguido de "=thisform.CalcTots()" - a tela abre
2440:     * com o Valor Original vindo do item e os outros dois ja calculados.
2441:     * Aqui o Valor Original vem de this_nValor (que FormParaBO acabou de
2442:     * resolver a partir de this_nUnitOrigs) e os outros dois das properties
2443:     * que a carga do BO deixou; CalcularTotais, chamado logo depois pelo
2444:     * CarregarLista, recalcula Total Desconto e Saldo sobre a grade ja cheia.
2445:     *
2446:     * GUARDA DE EXISTENCIA nos tres TextBox pela mesma razao do FormParaBO:
2447:     * o metodo pode rodar antes da superficie visual estar montada, e um
2448:     * "Property is not found" aqui derrubaria o Init inteiro.
2449:     *
2450:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase.prg

*-- Linhas 2502 a 2575:
2502:     *
2503:     *   RELEASE pcChv, pcEDN, pcItem
2504:     *   This.Grade.RecordSource          = []
2505:     *   This.Grade.Column1.ControlSource = []
2506:     *   This.Grade.Column2.ControlSource = []
2507:     *   This.Grade.Column3.ControlSource = []
2508:     *   This.Grade.Column4.ControlSource = []
2509:     *   Use In localDes
2510:     *
2511:     * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
2512:     * contexto que elas carregavam entre o Init e os eventos vive em
2513:     * properties this_* do form e do BO, que morrem com os objetos - nao ha
2514:     * o que soltar do espaco global.
2515:     *
2516:     * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
2517:     * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
2518:     * deixa o Grid apontando para alias morto, e qualquer repintura posterior
2519:     * (o VFP repinta durante a propria destruicao da tela) acha alias
2520:     * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
2521:     * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
2522:     * grades sao nossas e os dois cursores tambem.
2523:     *
2524:     * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
2525:     * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
2526:     * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
2527:     * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
2528:     * buffer sujo.
2529:     *
2530:     * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
2531:     * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
2532:     * cadeia de heranca o menu do sistema aparece encolhido depois que este
2533:     * dialogo fecha.
2534:     *
2535:     * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
2536:     * destruicao por falha de limpeza deixaria o form pendurado.
2537:     *==========================================================================
2538:     PROCEDURE Destroy()
2539:         LOCAL loc_oErro
2540: 
2541:         TRY
2542:             *-- Solta a grade principal do cursor (legado: Grade.RecordSource
2543:             *-- e os quatro Column.ControlSource)
2544:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2545:                 WITH THIS.grd_4c_Dados
2546:                     .RecordSource          = ""
2547:                     .Column1.ControlSource = ""
2548:                     .Column2.ControlSource = ""
2549:                     .Column3.ControlSource = ""
2550:                     .Column4.ControlSource = ""
2551:                 ENDWITH
2552:             ENDIF
2553: 
2554:             *-- Solta a grade da cota (GrdCota, 3 colunas)
2555:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
2556:                 WITH THIS.grd_4c_Cota
2557:                     .RecordSource          = ""
2558:                     .Column1.ControlSource = ""
2559:                     .Column2.ControlSource = ""
2560:                     .Column3.ControlSource = ""
2561:                 ENDWITH
2562:             ENDIF
2563: 
2564:             *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
2565:             IF USED("cursor_4c_Dados")
2566:                 USE IN cursor_4c_Dados
2567:             ENDIF
2568: 
2569:             IF USED("cursor_4c_Cota")
2570:                 USE IN cursor_4c_Cota
2571:             ENDIF
2572:         CATCH TO loc_oErro
2573:             MsgErro(loc_oErro.Message + CHR(13) + ;
2574:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2575:                     "Procedure: " + loc_oErro.Procedure, ;


### BO (C:\4c\projeto\app\classes\SigOpDesBO.prg):
*====================================================================
* SigOpDesBO.prg
*
* Business Object para Selecao de Descontos (dialogo modal aberto a
* partir da grade de itens de um movimento de venda).
*
* Tabela gravada ao confirmar a selecao: SigMvItd (uma linha por tipo
* de desconto marcado na grade). Tabela consultada/atualizada para o
* controle de cota acumulada por empresa: SigCdDes.
*
* O item/movimento de origem (Emps/Dopes/Numes/Cpros/Citens/...) e o
* cadastro do produto atual (Cgrus/Sgrus/...) sao fornecidos pelo form
* chamador - esta nova arquitetura nao depende mais dos cursores
* globais do legado (TprMvCab/crTpmMvItn), que sao passados pelo
* FormBase chamador via parametro.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDesBO AS BusinessBase

	*-- Contexto do movimento/item (equivalente a TprMvCab/crTpmMvItn do legado)
	this_cEmps       = ""   && Emps       char(3)  - empresa do movimento
	this_cDopes      = ""   && Dopes      char(20) - documento/operacao do movimento
	this_nNumes      = 0    && Numes      numeric(6,0) - numero do movimento
	this_cContads    = ""   && Contads    char(10) - codigo da conta/cliente do movimento
	this_dDatas      = {}   && Datas      datetime - data do movimento
	this_cEmpDopNums = ""   && EmpDopNums char(29) - chave posicional Emps+Dopes+Numes (regra #42, NAO usar ALLTRIM nas partes)
	this_cCpros      = ""   && Cpros      char(14) - codigo do produto do item atual
	this_nCitens     = 0    && Citens     numeric  - numero/indice do item na lista de itens
	this_nUnitOrigs  = 0    && UnitOrigs  numeric(14,6) - valor unitario original do item (base do desconto)
	this_nQtds       = 0    && Qtds       numeric(9,3)  - quantidade do item
	this_nTotas      = 0    && Totas      numeric(11,2) - valor total do item

	*-- Cadastro do produto atual (SigCdPro), usado nas regras de elegibilidade de desconto
	this_cCgrus      = ""   && Cgrus      - grupo do produto
	this_cSgrus      = ""   && Sgrus      - subgrupo do produto
	this_cCodcors    = ""   && Codcors    - codigo da cor do produto
	this_cColecoes   = ""   && Colecoes   - codigo da colecao do produto
	this_cCodfinp    = ""   && Codfinp    - codigo do acabamento/finp do produto
	this_nPvens      = 0    && Pvens      - preco de venda atual do produto
	this_dDtLacto    = {}   && DtLacto    - data de lancamento do produto
	this_lForaLinha  = .F.  && ForaLinha  - indica produto fora de linha
	this_nPrecode    = 0    && Precode    - indica produto de/por (preco promocional)

	*-- Totais da selecao de desconto (equivalente a ThisForm.lnValor/lnSaldo/lnTDesc do legado)
	this_nValor      = 0    && Valor original do item, base do calculo de desconto
	this_nSaldo      = 0    && Saldo apos aplicar os descontos selecionados na grade
	this_nTDesc      = 0    && Soma dos valores de desconto selecionados na grade

	*-- Cota de desconto da empresa (SigCdDes), controla o limite acumulado
	this_cCodigo     = ""   && Codigo    char(10)      - PK de SigCdDes
	this_nValCota    = 0    && ValCota   numeric(11,2) - valor da cota de desconto da empresa
	this_nValDes     = 0    && ValDes    numeric(11,2) - valor de desconto ja utilizado (acumulado)
	this_nValMeta    = 0    && ValMeta   numeric(11,2) - valor da meta de venda da empresa
	this_nValCotaC   = 0    && ValCotaC  numeric(11,2) - valor da cota complementar

	*-- Soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	*-- mesmo movimento, restrita aos tipos que CONSOMEM a cota da
	*-- empresa. Equivale ao lnTDescM do calctots legado, que vem de
	*-- "SELECT crSigmvitd / SUM vdes to lnTDescM for
	*--  !INLIST(tpdesc,1,2,6,7,10,11,12,13) AND citens <> pcItem".
	*-- crSigmvitd e' cursor global do form chamador, que esta
	*-- arquitetura nao tem: a soma e' resolvida por
	*-- CarregarDescontoOutrosItens e lida pelo CalcularTotais do form.
	this_nVDescOutrosItens = 0

	*-- Linha de desconto a gravar em SigMvItd quando o usuario confirma a selecao
	this_cCidChaves  = ""   && CidChaves char(20)      - PK da linha de desconto (gerada por fUniqueIds())
	this_dDtAlts     = {}   && DtAlts    datetime      - data/hora da inclusao do desconto
	this_cCdesc      = ""   && Cdesc     char(10)      - codigo do tipo de desconto selecionado (SigOpTdz.codigos)
	this_cDdesc      = ""   && Ddesc     char(30)      - descricao do tipo de desconto selecionado
	this_nPdes       = 0    && Pdes      numeric(7,4)  - percentual de desconto aplicado
	this_nVdes       = 0    && Vdes      numeric(9,2)  - valor de desconto aplicado
	this_nValBase    = 0    && ValBase   numeric(10,2) - valor base sobre o qual o desconto foi calculado
	this_nTpDesc     = 0    && TpDesc    numeric(2,0)  - tipo de desconto (1=aniversario,2=financeiro,3=relogio,6=troca,7=updiamond,8=supervisor,9=diretoria,10=upalianca,11=extra,12=brinde,13=alteracao de preco)
	this_cUsuars     = ""   && Usuars    char(10)      - usuario que autorizou/incluiu o desconto

	*-- Colunas NOT NULL de SigMvItd que o INSERT legado NUNCA cita (regra #22 -
	*-- invisiveis no dump porque nao tem controle na tela nem property no SCX).
	*-- Sem valor proprio no legado: usar o default documentado (numeric -> 0,
	*-- char -> vazio) para nao quebrar o INSERT com "valor NULL" no SQL Server.
	this_nCitensTpDesc = 0  && CitensTpDesc numeric(4,0) - sem referencia no legado, default 0
	this_cChaveexterna = "" && ChaveExterna char(33)     - sem referencia no legado, default vazio

	*-- Contexto de ELEGIBILIDADE do item, consultado por
	*-- ConsultarContextoElegibilidade e lido por FiltrarElegibilidade.
	*-- Cada uma substitui o RECCOUNT() de um cursor auxiliar do Init
	*-- legado (ver o comentario de FiltrarElegibilidade).
	this_nQtdPromoImp  = 0  && crProPro - SigImpPr vigente para o produto
	this_nQtdAniv      = 0  && crClid   - SigCdCli.nascs no mes corrente
	this_nQtdPrecoAlt  = 0  && crPre    - SigPrPre com troca de preco em 2 dias
	this_nDescPrecoAlt = 0  && crPre.descos - percentual da troca de preco (teto do tipo 13)
	this_nQtdItdJolie  = 0  && crItdJ   - SigMvItd ja gravado com o tipo 2 do grupo configurado

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigMvItd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso
	* em RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de SigMvItd do cursor
	* para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes
	* de acessar os campos (regra #9 CLAUDE.md).
	*
	* O 2o argumento de TratarNulo e' o VALOR PADRAO devolvido quando a
	* coluna vem NULL, NAO um codigo de tipo: TratarNulo(citens, "N")
	* gravaria a STRING "N" numa property numerica e a primeira conta
	* feita com ela estouraria por tipo. Por isso cada chamada abaixo
	* passa o default do TIPO da property - "" para char, 0 para numeric
	* e {} para datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCdesc         = TratarNulo(cdesc, "")
				THIS.this_cCidChaves     = TratarNulo(cidchaves, "")
				THIS.this_nCitens        = TratarNulo(citens, 0)
				THIS.this_cCpros         = TratarNulo(cpros, "")
				THIS.this_cDdesc         = TratarNulo(ddesc, "")
				THIS.this_cDopes         = TratarNulo(dopes, "")
				THIS.this_dDtAlts        = TratarNulo(dtalts, {})
				THIS.this_cEmpDopNums    = TratarNulo(empdopnums, "")
				THIS.this_cEmps          = TratarNulo(emps, "")
				THIS.this_nNumes         = TratarNulo(numes, 0)
				THIS.this_nPdes          = TratarNulo(pdes, 0)
				THIS.this_cUsuars        = TratarNulo(usuars, "")
				THIS.this_nValBase       = TratarNulo(valbase, 0)
				THIS.this_nVdes          = TratarNulo(vdes, 0)
				THIS.this_nCitensTpDesc  = TratarNulo(citenstpdesc, 0)
				THIS.this_cCodigo        = TratarNulo(codigo, "")
				THIS.this_nTpDesc        = TratarNulo(tpdesc, 0)
				THIS.this_cChaveexterna  = TratarNulo(chaveexterna, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere nova linha de desconto em SigMvItd
	* PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida -
	* equivalente a "lcIdChave = fUniqueIds()" do btnConfirmar.Click legado.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- DtAlts = data/hora da inclusao (equivalente a DATETIME() do legado)
			THIS.this_dDtAlts = DATETIME()

			loc_cSQL = "INSERT INTO SigMvItd ("
			loc_cSQL = loc_cSQL + "cdesc, cidchaves, citens, cpros, ddesc, dopes, dtalts, empdopnums,"
			loc_cSQL = loc_cSQL + "emps, numes, pdes, usuars, valbase, vdes, citenstpdesc, codigo,"
			loc_cSQL = loc_cSQL + "tpdesc, chaveexterna"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza linha de desconto existente em SigMvItd (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			loc_cSQL = "UPDATE SigMvItd SET"
			loc_cSQL = loc_cSQL + " cdesc = " + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " ddesc = " + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pdes = " + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + " valbase = " + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + " vdes = " + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + " citenstpdesc = " + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " codigo = " + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + " tpdesc = " + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidChaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirDescontosDoItem - remove TODAS as linhas de desconto do item
	* corrente em SigMvItd, antes de btnConfirmar.Click regravar a
	* selecao atual da grade.
	*
	* Legado (btnConfirmar.Click):
	*   SELECT crsigmvitd
	*   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
	*
	* crsigmvitd e' cursor GLOBAL do form chamador (todas as linhas de
	* desconto do movimento, de TODOS os itens) - nesta arquitetura o
	* DELETE vai direto na tabela, restrito ao mesmo par cpros/citens, que
	* e' exatamente o que o FOR do legado filtra.
	*
	* PUBLIC: chamado pelo form em BtnConfirmarClick (regra #51 - metodo
	* chamado de fora nunca pode ser PROTECTED).
	*====================================================================
	PROCEDURE ExcluirDescontosDoItem()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso

		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCpros, "")))
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelItd")

			IF loc_nResult < 0
				MsgErro("Erro ao remover os descontos anteriores do item:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.ExcluirDescontosDoItem")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ContarSQL - devolve o escalar da coluna N de um SELECT COUNT(*)
	* executado no SQL Server. Centraliza o padrao
	* "SQLEXEC -> le N -> fecha cursor" usado pelas checagens de
	* elegibilidade abaixo, que no legado eram RECCOUNT() de cursores
	* auxiliares (crProPro/crClid/crItdJ).
	*
	* O cursor de apoio e' SEMPRE fechado antes e depois, para nao deixar
	* alias aberto entre chamadas (o 2o SQLEXEC no mesmo alias erraria).
	* PROTECTED - chamado so por THIS. dentro do proprio BO (regra #51).
	*====================================================================
	PROTECTED FUNCTION ContarSQL(par_cSQL)
		LOCAL loc_nTotal, loc_nResult, loc_nAliasAnt

		loc_nTotal    = 0
		loc_nAliasAnt = SELECT()

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		loc_nResult = SQLEXEC(gnConnHandle, par_cSQL, "cursor_4c_DesCnt")

		IF loc_nResult >= 0 AND USED("cursor_4c_DesCnt")
			SELECT cursor_4c_DesCnt
			IF !EOF()
				loc_nTotal = NVL(cursor_4c_DesCnt.N, 0)
			ENDIF
		ENDIF

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		IF loc_nAliasAnt > 0
			SELECT (loc_nAliasAnt)
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ContarTipoConfig - conta linhas de cursor_4c_TipoTmp (o crTipo do
	* legado: SigOpTdt cruzado com SigOpTdz) para um par Tipos/TpDesc,
	* opcionalmente restrito ao grupo informado em Codtips.
	*
	* Substitui os RECCOUNT() dos cursores auxiliares do Init legado:
	*   crTipoRe   = crTipo where tipos = 1 and tpdesc = 3   (relogio)
	*   crTipoExAl = crTipo where tipos = 1 and tpdesc = 11  (extra alianca)
	*   crTipoJ    = crTipo where tipos = 1 and tpdesc = 2   (jolie)
	*   crGrRe/crGrAl/crGrJ = o MESMO conjunto, restrito a
	*                         "cgrus do produto in (codtips)"
	*
	* par_nUsarCod e' NUMERICO (0 = conta o par Tipos/TpDesc inteiro,
	* 1 = conta so as linhas cujo Codtips casa com par_cCodTips) de
	* proposito: parametro LOGICO omitido obriga teste de PCOUNT para ser
	* lido com seguranca.
	*
	* O RECNO corrente de cursor_4c_TipoTmp e' reposto no fim - o SCAN
	* move o ponteiro e outras checagens leem o mesmo alias depois.
	*====================================================================
	PROTECTED FUNCTION ContarTipoConfig(par_nTipos, par_nTpDesc, par_nUsarCod, par_cCodTips)
		LOCAL loc_nTotal, loc_nRecAnt, loc_cCod, loc_nAliasAnt

		loc_nTotal = 0

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			loc_cCod      = IIF(VARTYPE(par_cCodTips) = "C", ALLTRIM(par_cCodTips), "")

			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					IF par_nUsarCod = 0 OR ;
					   ALLTRIM(cursor_4c_TipoTmp.Codtips) == loc_cCod
						loc_nTotal = loc_nTotal + 1
					ENDIF
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ObterCodigoTipoConfig - devolve o Codigos da PRIMEIRA linha de
	* cursor_4c_TipoTmp para o par Tipos/TpDesc informado.
	*
	* Reproduz a leitura do legado "crTipoExAl.codigos" / "crTipoJ.codigos"
	* nos DELETE condicionais: apos "SELECT * from crTipo where ... into
	* cursor crTipoXX" o ponteiro fica no TOPO, entao o que o legado le e'
	* o primeiro registro da ordenacao por cidchaves - que e' a ordenacao
	* com que cursor_4c_TipoTmp e' criado.
	*====================================================================
	PROTECTED FUNCTION ObterCodigoTipoConfig(par_nTipos, par_nTpDesc)
		LOCAL loc_cCodigo, loc_nRecAnt, loc_nAliasAnt

		loc_cCodigo = ""

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					loc_cCodigo = ALLTRIM(NVL(cursor_4c_TipoTmp.Codigos, ""))
					EXIT
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* CarregarCota - popula cursor_4c_Cota (crSigCdDes do legado) com a
	* cota de desconto da empresa do movimento: codigo, empresa, cota
	* contratada, cota ja utilizada e meta.
	*
	* No legado crSigCdDes NAO e' consultado neste form - ele chega aberto
	* do form chamador, que o monta a partir de SigCdDes. Aqui a consulta
	* e' feita no proprio BO, filtrada pela empresa do movimento
	* (this_cEmps), que e' a mesma linha que o legado exibia.
	*
	* A coluna Valdes trazida aqui e' o acumulado GRAVADO em SigCdDes;
	* CalcTots soma a ela os descontos da tela antes de exibir.
	*
	* SQLEXEC NUNCA sobre o alias ligado ao Grid (isso zeraria o
	* ColumnCount): a consulta vai para cursor_4c_CotaTmp e cursor_4c_Cota
	* e' recarregado com ZAP + APPEND FROM DBF(), que preserva estrutura,
	* RecordSource e ControlSource.
	*====================================================================
	PROCEDURE CarregarCota()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps

		loc_lSucesso = .F.

		TRY
			loc_cEmps = ALLTRIM(NVL(THIS.this_cEmps, ""))

			loc_cSQL = "SELECT ISNULL(codigo, '') AS Codigo,"
			loc_cSQL = loc_cSQL + " ISNULL(emps, '') AS Emps,"
			loc_cSQL = loc_cSQL + " ISNULL(valcota, 0) AS Valcota,"
			loc_cSQL = loc_cSQL + " ISNULL(valdes, 0) AS Valdes,"
			loc_cSQL = loc_cSQL + " ISNULL(valmeta, 0) AS Valmeta"
			loc_cSQL = loc_cSQL + " FROM SigCdDes"
			loc_cSQL = loc_cSQL + " WHERE emps = " + EscaparSQL(loc_cEmps)
			loc_cSQL = loc_cSQL + " ORDER BY codigo"

			IF USED("cursor_4c_CotaTmp")
				USE IN cursor_4c_CotaTmp
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotaTmp")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar a cota de descontos da empresa:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF !USED("cursor_4c_Cota")
					SET NULL ON
					CREATE CURSOR cursor_4c_Cota ;
						(Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
						 Codigo C(10), Valmeta N(11,2))
					SET NULL OFF
				ENDIF

				SELECT cursor_4c_Cota
				ZAP

				IF USED("cursor_4c_CotaTmp") AND RECCOUNT("cursor_4c_CotaTmp") > 0
					SELECT cursor_4c_Cota
					APPEND FROM DBF("cursor_4c_CotaTmp")
				ENDIF

				IF USED("cursor_4c_CotaTmp")
					USE IN cursor_4c_CotaTmp
				ENDIF

				SELECT cursor_4c_Cota
				GO TOP

				*-- Codigo da cota vigente: e' o "crSigcdDes.codigo" que o
				*-- btnConfirmar.Click legado grava em SigMvItd.codigo.
				IF !EOF("cursor_4c_Cota")
					THIS.this_cCodigo  = ALLTRIM(NVL(cursor_4c_Cota.Codigo, ""))
					THIS.this_nValCota = NVL(cursor_4c_Cota.Valcota, 0)
					THIS.this_nValDes  = NVL(cursor_4c_Cota.Valdes, 0)
					THIS.this_nValMeta = NVL(cursor_4c_Cota.Valmeta, 0)
				ENDIF

				*-- lnTDescM do calctots legado: os descontos ja gravados
				*-- pelos OUTROS itens do movimento entram na cota
				*-- utilizada que a grade exibe. Resolvido aqui, junto com
				*-- a cota, porque e' a mesma conta e nao muda enquanto o
				*-- dialogo esta aberto. O retorno nao condiciona o
				*-- sucesso da carga da cota: sem a soma dos outros itens
				*-- a tela ainda abre e opera, so a cota utilizada fica
				*-- sem essa parcela - e a falha de SQL ja foi exibida.
				THIS.CarregarDescontoOutrosItens()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarCota")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDescontoOutrosItens - resolve o lnTDescM do calctots legado:
	* a soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	* mesmo movimento, contando so os tipos que CONSOMEM a cota da
	* empresa.
	*
	* Legado (PROCEDURE calctots):
	*
	*   SELECT crSigmvitd
	*   GO top
	*   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
	*                            AND citens <> pcItem
	*
	* crSigmvitd e' um cursor GLOBAL do form chamador (todos os itens de
	* desconto do movimento), igual a TprMvCab/crTpmMvItn - nao existe
	* nesta arquitetura, entao a mesma conta e' feita no SQL Server com o
	* filtro IDENTICO: mesmo movimento (empdopnums), outro item
	* (citens <> this_nCitens) e a MESMA lista de tipos excluidos.
	*
	* Os oito tipos de fora sao aniversario(1), financeiro(2), troca
	* zerada(6), up diamond(7), upgrade alianca(10), extra/loja(11),
	* brinde(12) e troca de preco(13) - a lista do comentario do legado
	* ("nao entra na cota A,V,TZ,UP,UpAlianca,extra/loja,brinde,troca
	* preco"). NAO confundir com a lista do teste de ESTOURO da cota nos
	* Valid das celulas, que exclui apenas 1, 2, 9 e 11: o legado tem duas
	* listas diferentes de proposito.
	*
	* Resolvido UMA vez, na carga: esta tela edita UM item, os descontos
	* dos outros itens nao mudam enquanto o dialogo esta aberto, e o
	* legado tambem nao os reconsulta (ele so re-soma um cursor que
	* ninguem alterou entre uma chamada de calctots e a seguinte).
	*
	* A chave do movimento e' POSICIONAL (regra #42): Emps char(3) +
	* Dopes char(20) + Str(Numes, 6) = char(29). PADR explicito em cada
	* parte, NUNCA ALLTRIM - encurtar qualquer parte desloca a chave, o
	* SELECT nao casa nada e devolve ZERO linhas sem erro nenhum, o que
	* faria a cota utilizada ser calculada sem os outros itens.
	*
	* Zero linhas NAO e' falha: movimento com um unico item, ou com
	* descontos so dos tipos excluidos, soma zero - exatamente o que o
	* legado obtem com crSigmvitd vazio.
	*====================================================================
	PROCEDURE CarregarDescontoOutrosItens()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpDopNums

		loc_lSucesso = .F.

		TRY
			THIS.this_nVDescOutrosItens = 0

			loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
							  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
							  STR(NVL(THIS.this_nNumes, 0), 6)

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF

			loc_cSQL = "SELECT ISNULL(SUM(vdes), 0) AS Vdes"
			loc_cSQL = loc_cSQL + " FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
			loc_cSQL = loc_cSQL + " AND citens <> " + ;
								  FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc NOT IN (1, 2, 6, 7, 10, 11, 12, 13)"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdOutros")

			IF loc_nResult < 0
				MsgErro("Erro ao somar os descontos dos demais itens do " + ;
						"movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ItdOutros") AND ;
				   RECCOUNT("cursor_4c_ItdOutros") > 0
					SELECT cursor_4c_ItdOutros
					GO TOP
					THIS.this_nVDescOutrosItens = NVL(cursor_4c_ItdOutros.Vdes, 0)
				ENDIF

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontoOutrosItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConsultarContextoElegibilidade - executa as consultas de contexto
	* que o Init legado fazia em cursores auxiliares e guarda o resultado
	* nas propriedades this_nQtd*/this_nDescPrecoAlt.
	*
	* Equivalencia com o legado, consulta por consulta:
	*
	*   crProPro -> this_nQtdPromoImp  (SigImpPr vigente na data do
	*               movimento; havendo promocao, so sobram os tipos 8 e 9)
	*   crClid   -> this_nQtdAniv      (SigCdCli.nascs no mes corrente;
	*               sem aniversario, o tipo 1 sai)
	*   crPre    -> this_nQtdPrecoAlt / this_nDescPrecoAlt (SigPrPre com
	*               troca de preco nos ultimos 2 dias; sem troca o tipo 13
	*               sai, com troca o percentual vira o teto do tipo 13)
	*   crItdJ   -> this_nQtdItdJolie  (SigMvItd ja gravado com o desconto
	*               tipo 2 do grupo configurado para este item)
	*
	* A divisao de crPre e' feita no VFP e nao no SQL Server porque
	* "ROUND((pvens - pvensant) / pvens * 100, 2)" com pvens = 0 ABORTA a
	* query inteira no SQL Server (divide by zero); aqui o zero devolve 0
	* e o tipo 13 fica com o teto do proprio cadastro, em vez de a tela
	* inteira falhar.
	*
	* ORDEM: depende de cursor_4c_TipoTmp ja estar carregado, porque o
	* codigo do tipo 2 jolie sai de ObterCodigoTipoConfig.
	*====================================================================
	PROTECTED PROCEDURE ConsultarContextoElegibilidade()
		LOCAL loc_cSQL, loc_cCpros, loc_cContads, loc_dBase, loc_dLimite
		LOCAL loc_nResult, loc_cCodTipoJ, loc_nPvens, loc_nPvensAnt

		loc_cCpros   = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cContads = ALLTRIM(NVL(THIS.this_cContads, ""))

		*-- Data base do movimento (TprMvCab.datas no legado). Sem data no
		*-- contexto cai em DATE(), para as comparacoes de vigencia nunca
		*-- virarem comparacao com NULL (que nao casa nada em silencio).
		loc_dBase = ConverterParaData(THIS.this_dDatas)
		IF EMPTY(loc_dBase)
			loc_dBase = DATE()
		ENDIF

		*-- Legado: ldData = DTOT(TTOD(TprMvCab.datas) - 2)
		loc_dLimite = loc_dBase - 2

		THIS.this_nQtdPromoImp  = 0
		THIS.this_nQtdAniv      = 0
		THIS.this_nQtdPrecoAlt  = 0
		THIS.this_nDescPrecoAlt = 0
		THIS.this_nQtdItdJolie  = 0

		*-- crProPro: produto com promocao de importacao vigente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigImpPr"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND dtinicial <= " + FormatarDataSQL(loc_dBase)
		loc_cSQL = loc_cSQL + " AND dtfinal >= " + FormatarDataSQL(loc_dBase)
		THIS.this_nQtdPromoImp = THIS.ContarSQL(loc_cSQL)

		*-- crClid: aniversario do cliente no mes corrente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigCdCli"
		loc_cSQL = loc_cSQL + " WHERE iclis = " + EscaparSQL(loc_cContads)
		loc_cSQL = loc_cSQL + " AND nascs IS NOT NULL"
		loc_cSQL = loc_cSQL + " AND MONTH(nascs) = " + FormatarNumeroSQL(MONTH(DATE()), 0)
		THIS.this_nQtdAniv = THIS.ContarSQL(loc_cSQL)

		*-- crPre: troca de preco do produto nos ultimos 2 dias
		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		loc_cSQL = "SELECT TOP 1 ISNULL(pvens, 0) AS Pvens,"
		loc_cSQL = loc_cSQL + " ISNULL(pvensant, 0) AS Pvensant"
		loc_cSQL = loc_cSQL + " FROM SigPrPre"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND datas >= " + FormatarDataSQL(loc_dLimite)
		loc_cSQL = loc_cSQL + " ORDER BY datas DESC"

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PreTmp")

		IF loc_nResult >= 0 AND USED("cursor_4c_PreTmp")
			SELECT cursor_4c_PreTmp
			IF !EOF()
				THIS.this_nQtdPrecoAlt = RECCOUNT("cursor_4c_PreTmp")
				loc_nPvens    = NVL(cursor_4c_PreTmp.Pvens, 0)
				loc_nPvensAnt = NVL(cursor_4c_PreTmp.Pvensant, 0)
				IF loc_nPvens <> 0
					THIS.this_nDescPrecoAlt = ROUND((loc_nPvens - loc_nPvensAnt) / ;
													loc_nPvens * 100, 2)
				ENDIF
			ENDIF
		ENDIF

		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		*-- crItdJ: desconto tipo 2 do grupo configurado ja gravado para
		*-- este item (havendo, o tipo 2 permanece na grade).
		loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)

		IF !EMPTY(loc_cCodTipoJ)
			loc_cSQL = "SELECT COUNT(*) AS N FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc = 2"
			loc_cSQL = loc_cSQL + " AND cdesc = " + EscaparSQL(loc_cCodTipoJ)
			THIS.this_nQtdItdJolie = THIS.ContarSQL(loc_cSQL)
		ENDIF
	ENDPROC

	*====================================================================
	* FiltrarElegibilidade - aplica sobre par_cAlias (copia de trabalho
	* dos tipos de desconto) os DELETE de elegibilidade do Init legado,
	* na MESMA ordem em que o legado os executa.
	*
	* Mapa linha a linha com o legado:
	*
	*  1) if RECCOUNT('crItnS') = 0 -> DELETE for INLIST(tpdesc,6,7,10)
	*     crItnS e' o item de SUBNIVEL, que no legado vem do cursor
	*     crEesti aberto pelo form chamador. O contrato de Init deste form
	*     recebe o item ATUAL, nao a troca de subnivel, logo RECCOUNT = 0
	*     e os tipos de troca (6 = troca zerada, 7 = up diamond,
	*     10 = upgrade alianca) saem - exatamente o que o legado faz
	*     quando nao ha subnivel.
	*  2) if RECCOUNT('crTipoExAl') <> 0 and RECCOUNT('crGrAl') = 0
	*        -> DELETE for tpdesc = 11 and codigos = crTipoExAl.codigos
	*  3) if RECCOUNT('crPre') = 0 -> DELETE for INLIST(tpdesc,13)
	*     senao -> replace descosmax with crPre.descos for tpdesc = 13
	*  4) if RECCOUNT('crGrRe') = 0 -> DELETE for INLIST(tpdesc,3)
	*  5) if nascs vazio ou de outro mes -> DELETE for INLIST(tpdesc,1)
	*  6) if RECCOUNT('crProPro') > 0 -> DELETE for !INLIST(tpdesc,8,9)
	*  7) if RECCOUNT('crDepor') > 0 -> DELETE for !INLIST(tpdesc,2,8,9)
	*     crDepor e' "SigCdPro where cpros = X and precode <> 0", que o
	*     contexto ja traz em this_nPrecode.
	*  8) jolie -> DELETE for tpdesc = 2 and codigos = crTipoJ.codigos
	*
	* Dois DELETE do legado ficam de FORA, por motivos opostos:
	*
	*  - FORA DE LINHA: o bloco "DELETE for !INLIST(tpdesc,2,5,8,9)" esta
	*    COMENTADO no legado (*!*), com a nota "Permite descontos mesmo se
	*    produto fora de linha" - manter o comportamento comentado e' a
	*    leitura fiel, e por isso this_lForaLinha nao filtra nada aqui.
	*  - BRINDE (tipo 12): o legado so o mantem quando SigCdPmc tem
	*    promocao vigente com "valmin <= valor dos OUTROS itens do
	*    movimento"; esse somatorio vem do cursor de itens do form
	*    chamador, que nao faz parte do contrato de Init. Filtrar por um
	*    total arbitrario RETIRARIA da tela um desconto que o legado
	*    concede, entao o tipo 12 permanece e a autorizacao continua
	*    sendo cobrada no fluxo de confirmacao.
	*
	* A condicao jolie do legado tem DOIS ramos ligados por OR; aqui
	* entra apenas o primeiro ("grupo configurado no tipo 2 e o produto
	* fora desse grupo"), porque o segundo depende do mesmo somatorio de
	* itens do chamador. O ramo aplicado e' um SUBCONJUNTO do que o legado
	* apaga, logo nenhum tipo que o legado mantem e' retirado.
	*====================================================================
	PROTECTED PROCEDURE FiltrarElegibilidade(par_cAlias)
		LOCAL loc_nTipoExAl, loc_nGrupoExAl, loc_cCodExAl
		LOCAL loc_nTipoRe, loc_nGrupoRe, loc_nTipoJ, loc_nGrupoJ, loc_cCodTipoJ
		LOCAL loc_cCgrus

		loc_cCgrus = ALLTRIM(NVL(THIS.this_cCgrus, ""))

		*-- (1) sem item de subnivel: tipos de troca saem
		SELECT (par_cAlias)
		DELETE FOR INLIST(Tpdesc, 6, 7, 10)

		*-- (2) tipo 11 com grupo configurado que nao e' o do produto
		loc_nTipoExAl  = THIS.ContarTipoConfig(1, 11, 0, "")
		loc_nGrupoExAl = THIS.ContarTipoConfig(1, 11, 1, loc_cCgrus)

		IF loc_nTipoExAl <> 0 AND loc_nGrupoExAl = 0
			loc_cCodExAl = THIS.ObterCodigoTipoConfig(1, 11)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 11 AND ALLTRIM(Codigos) == loc_cCodExAl
		ENDIF

		*-- (3) tipo 13 depende de troca de preco recente
		SELECT (par_cAlias)
		IF THIS.this_nQtdPrecoAlt = 0
			DELETE FOR INLIST(Tpdesc, 13)
		ELSE
			REPLACE ALL Descosmax WITH THIS.this_nDescPrecoAlt ;
				FOR Tpdesc = 13
		ENDIF

		*-- (4) tipo 3 (relogio) depende do grupo configurado
		loc_nTipoRe  = THIS.ContarTipoConfig(1, 3, 0, "")
		loc_nGrupoRe = THIS.ContarTipoConfig(1, 3, 1, loc_cCgrus)

		SELECT (par_cAlias)
		IF loc_nTipoRe <> 0 AND loc_nGrupoRe = 0
			DELETE FOR INLIST(Tpdesc, 3)
		ENDIF

		*-- (5) tipo 1 (aniversario) depende do mes de nascimento
		SELECT (par_cAlias)
		IF THIS.this_nQtdAniv = 0
			DELETE FOR INLIST(Tpdesc, 1)
		ENDIF

		*-- (6) produto em promocao: so supervisor (8) e diretoria (9)
		SELECT (par_cAlias)
		IF THIS.this_nQtdPromoImp > 0
			DELETE FOR !INLIST(Tpdesc, 8, 9)
		ENDIF

		*-- (7) produto de/por: so financeiro (2), supervisor (8), diretoria (9)
		SELECT (par_cAlias)
		IF NVL(THIS.this_nPrecode, 0) <> 0
			DELETE FOR !INLIST(Tpdesc, 2, 8, 9)
		ENDIF

		*-- (8) tipo 2 (jolie) com grupo configurado que nao e' o do produto
		loc_nTipoJ  = THIS.ContarTipoConfig(1, 2, 0, "")
		loc_nGrupoJ = THIS.ContarTipoConfig(1, 2, 1, loc_cCgrus)

		IF loc_nTipoJ <> 0 AND loc_nGrupoJ = 0 AND THIS.this_nQtdItdJolie = 0
			loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 2 AND ALLTRIM(Codigos) == loc_cCodTipoJ
		ENDIF

		SELECT (par_cAlias)
	ENDPROC

	*====================================================================
	* MarcarDescontosGravados - pre-seleciona em par_cAlias os tipos de
	* desconto JA gravados em SigMvItd para o item corrente, trazendo o
	* percentual, o valor e o usuario que autorizou.
	*
	* Legado (fim do Init):
	*   SELECT * from crSigmvitd where cpros = lcCpros and citens = pcItem
	*                                                   into cursor crOpItd
	*   SELECT localDes / GO top / SCAN
	*       SELECT crOpItd / LOCATE for cdesc = localDes.codigos
	*       IF FOUND()
	*           replace selecao with 1              in localDes
	*           replace descos  with crOpItd.pdes   in localDes
	*           replace valdes  with crOpItd.vdes   in localDes
	*           replace usuars  with crOpItd.usuars in localDes
	*       ENDIF
	*   ENDSCAN
	*
	* O filtro ganha empdopnums (a chave posicional Emps+Dopes+Numes) em
	* cima de cpros/citens: no legado crSigmvitd JA chega do chamador
	* restrito ao movimento aberto, enquanto aqui a leitura e' direta na
	* tabela e cpros+citens sozinhos casariam o mesmo item de OUTROS
	* movimentos. A chave e' montada com PADR nas partes, NUNCA ALLTRIM -
	* ela e' POSICIONAL (3 + 20 + 6 = 29, a largura de
	* SigMvItd.empdopnums); ALLTRIM nas partes encurta a chave e o SELECT
	* devolve ZERO linhas sem nenhum erro.
	*====================================================================
	PROTECTED PROCEDURE MarcarDescontosGravados(par_cAlias)
		LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNums, loc_cCpros, loc_cCodigo

		loc_cCpros      = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
						  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
						  STR(NVL(THIS.this_nNumes, 0), 6)

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		loc_cSQL = "SELECT ISNULL(cdesc, '') AS Cdesc,"
		loc_cSQL = loc_cSQL + " ISNULL(pdes, 0) AS Pdes,"
		loc_cSQL = loc_cSQL + " ISNULL(vdes, 0) AS Vdes,"
		loc_cSQL = loc_cSQL + " ISNULL(usuars, '') AS Usuars"
		loc_cSQL = loc_cSQL + " FROM SigMvItd"
		loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
		loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdTmp")

		IF loc_nResult < 0
			MsgErro("Erro ao ler os descontos j" + CHR(225) + " gravados do item:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
		ELSE
			IF USED("cursor_4c_ItdTmp") AND RECCOUNT("cursor_4c_ItdTmp") > 0
				SELECT (par_cAlias)
				GO TOP
				SCAN
					loc_cCodigo = ALLTRIM(NVL(EVALUATE(par_cAlias + ".Codigos"), ""))

					SELECT cursor_4c_ItdTmp
					GO TOP
					LOCATE FOR ALLTRIM(cursor_4c_ItdTmp.Cdesc) == loc_cCodigo

					IF FOUND()
						SELECT (par_cAlias)
						REPLACE Selecao WITH 1, ;
								Descos  WITH NVL(cursor_4c_ItdTmp.Pdes, 0), ;
								Valdes  WITH NVL(cursor_4c_ItdTmp.Vdes, 0), ;
								Usuars  WITH ALLTRIM(NVL(cursor_4c_ItdTmp.Usuars, ""))
					ENDIF

					SELECT (par_cAlias)
				ENDSCAN
			ENDIF
		ENDIF

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		SELECT (par_cAlias)
		GO TOP
	ENDPROC

	*====================================================================
	* CarregarDescontos - popula cursor_4c_Dados (localDes do legado) com
	* os tipos de desconto que o item corrente pode receber.
	*
	* Pipeline, espelhando o Init legado:
	*
	*  1) cursor_4c_DesTmp  <- SigOpTdz cruzado com SigCdTbd pela operacao
	*                          do movimento (crDesc do legado), com a
	*                          copia de trabalho das colunas de localDes:
	*                          Selecao = 0, Valdes = 0, Descos = 0 e
	*                          Descosmax = SigOpTdz.descos (o teto que o
	*                          Valid da coluna "% Desconto" cobra). O
	*                          legado monta esse mesmo par com
	*                          "Select 0 as selecao, 000000000.00 as
	*                          valdes, descos as descosmax, * from crDesc"
	*                          seguido de "replace all descos with 0.00".
	*  2) cursor_4c_TipoTmp <- SigOpTdt cruzado com SigOpTdz (crTipo),
	*                          ordenado por cidchaves: a configuracao de
	*                          grupo de cada tipo de desconto.
	*  3) ConsultarContextoElegibilidade -> promocao / aniversario /
	*                          troca de preco / jolie ja gravado
	*  4) FiltrarElegibilidade           -> os DELETE do legado
	*  5) MarcarDescontosGravados        -> pre-selecao a partir de SigMvItd
	*  6) cursor_4c_Dados   <- ZAP + APPEND FROM DBF(copia compactada)
	*
	* Dois cuidados de SQL nas consultas 1 e 2:
	*
	*  - COLLATE DATABASE_DEFAULT em "a.codigos = c.codigos":
	*    SigOpTdz.codigos e' SQL_Latin1_General_CP1_CI_AS e
	*    SigCdTbd.codigos e' Latin1_General_CI_AS. Sem o COLLATE o SQL
	*    Server RECUSA a query inteira com conflito de ordenacao, em
	*    runtime, com o .prg compilando limpo. O join de SigOpTdt com
	*    SigOpTdz nao precisa: as duas colunas estao na mesma collation.
	*  - "a.listaemp IS NULL" no filtro do tipo 11: o legado faz
	*    "DELETE FROM crDesc where tpDesc = 11 and !listaemp like '%emp%'"
	*    e, com listaemp nulo, "!NULL" e' NULL no VFP - a linha NAO e'
	*    apagada. Omitir o IS NULL apagaria linha que o legado mantem.
	*
	* O ZAP/APPEND existe porque SQLEXEC (ou SELECT INTO CURSOR) sobre o
	* alias ligado ao Grid o fecha e recria, zerando o ColumnCount - a
	* grade viraria um retangulo branco sem cabecalho, sem erro nenhum.
	* A lista de colunas do CREATE CURSOR aqui e' a MESMA do placeholder
	* criado em FormSigOpDes.ConfigurarGrade, porque APPEND FROM casa as
	* colunas por NOME.
	*====================================================================
	PROCEDURE CarregarDescontos()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps, loc_cDopes
		LOCAL loc_cListaEmp, loc_cDeletedAnt

		loc_lSucesso = .F.

		TRY
			loc_cEmps     = ALLTRIM(NVL(THIS.this_cEmps, ""))
			loc_cDopes    = ALLTRIM(NVL(THIS.this_cDopes, ""))
			loc_cListaEmp = EscaparSQL("%" + loc_cEmps + "%")

			*-- (1) crDesc: tipos habilitados na operacao do movimento
			IF USED("cursor_4c_DesSql")
				USE IN cursor_4c_DesSql
			ENDIF

			loc_cSQL = "SELECT 0 AS Selecao,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(9,2)) AS Valdes,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(7,4)) AS Descos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descos, 0) AS Descosmax,"
			loc_cSQL = loc_cSQL + " ISNULL(a.codigos, '') AS Codigos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descrs, '') AS Descrs,"
			loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc,"
			loc_cSQL = loc_cSQL + " CAST('' AS char(10)) AS Usuars"
			loc_cSQL = loc_cSQL + " FROM SigOpTdz a"
			loc_cSQL = loc_cSQL + " INNER JOIN SigCdTbd c"
			loc_cSQL = loc_cSQL + " ON a.codigos COLLATE DATABASE_DEFAULT = c.codigos"
			loc_cSQL = loc_cSQL + " WHERE c.dopes = " + EscaparSQL(loc_cDopes)
			loc_cSQL = loc_cSQL + " AND a.tpdesc <> 0"
			loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
			loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
								  loc_cListaEmp + ")"
			loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesSql")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar os tipos de desconto da opera" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + ;
						CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Copia de trabalho READWRITE: os DELETE/REPLACE de
				*-- elegibilidade nao rodam em cursor de SQL pass-through.
				IF USED("cursor_4c_DesTmp")
					USE IN cursor_4c_DesTmp
				ENDIF
				SELECT * FROM cursor_4c_DesSql INTO CURSOR cursor_4c_DesTmp READWRITE

				IF USED("cursor_4c_DesSql")
					USE IN cursor_4c_DesSql
				ENDIF

				*-- (2) crTipo: configuracao de grupo por tipo de desconto
				IF USED("cursor_4c_TipoTmp")
					USE IN cursor_4c_TipoTmp
				ENDIF

				loc_cSQL = "SELECT ISNULL(b.codigos, '') AS Codigos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.codtips, '') AS Codtips,"
				loc_cSQL = loc_cSQL + " ISNULL(b.tipos, 0) AS Tipos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.cidchaves, '') AS Cidchaves,"
				loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc"
				loc_cSQL = loc_cSQL + " FROM SigOpTdt b"
				loc_cSQL = loc_cSQL + " INNER JOIN SigOpTdz a ON a.codigos = b.codigos"
				loc_cSQL = loc_cSQL + " WHERE a.tpdesc <> 0"
				loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
				loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
									  loc_cListaEmp + ")"
				loc_cSQL = loc_cSQL + " ORDER BY b.cidchaves"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoTmp")

				IF loc_nResult < 0
					MsgErro("Erro ao carregar a configura" + CHR(231) + CHR(227) + ;
							"o dos tipos de desconto:" + CHR(13) + ;
							CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- (3) contexto e (4) elegibilidade
					THIS.ConsultarContextoElegibilidade()
					THIS.FiltrarElegibilidade("cursor_4c_DesTmp")

					*-- Compacta: APPEND FROM respeita SET DELETED, e o
					*-- estado do ambiente nao e' garantido aqui. O SET e'
					*-- restaurado logo depois, sem macro.
					loc_cDeletedAnt = SET("DELETED")
					SET DELETED ON

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					SELECT * FROM cursor_4c_DesTmp INTO CURSOR cursor_4c_DesApp READWRITE

					IF loc_cDeletedAnt = "OFF"
						SET DELETED OFF
					ELSE
						SET DELETED ON
					ENDIF

					IF USED("cursor_4c_DesTmp")
						USE IN cursor_4c_DesTmp
					ENDIF

					*-- (5) pre-selecao do que ja esta gravado
					THIS.MarcarDescontosGravados("cursor_4c_DesApp")

					*-- (6) recarga do alias do Grid preservando a estrutura
					IF !USED("cursor_4c_Dados")
						SET NULL ON
						CREATE CURSOR cursor_4c_Dados ;
							(Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
							 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
							 Descosmax N(7,4), Usuars C(10))
						SET NULL OFF
					ENDIF

					SELECT cursor_4c_Dados
					ZAP

					IF USED("cursor_4c_DesApp") AND RECCOUNT("cursor_4c_DesApp") > 0
						SELECT cursor_4c_Dados
						APPEND FROM DBF("cursor_4c_DesApp")
					ENDIF

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					IF USED("cursor_4c_TipoTmp")
						USE IN cursor_4c_TipoTmp
					ENDIF

					SELECT cursor_4c_Dados
					GO TOP

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontos")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

