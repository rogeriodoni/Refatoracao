# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUCONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FPAGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABSTOP' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PAGECOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CONTADS, CONTAOS, EMPDOPNUMS, ICLIS, UMOVS, NUMS, TIPOOPS, GRCLIS, TIPOS

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
lcSql = [Select Dopes,TipoOps, Nivels, LimCres From SigCdOpe Where Dopes = ']+Operacao+[']
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'lCredOpe') < 1
Select TprMvCab
lcSql = [Select * From SigOpPed ]
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalOpePd') < 1
Select DbOpera
	lStrQuery = [Select Dopes,OpPends From SigCdOpe ]
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'CrTmpOpe') < 1
	Select CrTmpOpe
	lStrQuery = [Select a.dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados From SigMvCab a, SigOpPed b ]+;
				[Select a.dopes, a.EmpDopNums, a.ChkPagos, a.ChkSubn, a.Utilizados From SigMvCab a, SigOpPed b ]+;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery, 'CrTprMvCab') < 1
	Select a.empDopNums From CrTprMvCab a, LocalOpePd b Where a.Dopes = b.Dopes And ;
	Select CrConserto2
		lcSql = [Select Dopes, Moedas, Sum( ( Qtds-QtBaixas ) * (Units+ValRats) ) as Totas From SigMvItn ]+;
		ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'lCredEesti')
		Select lCredEesti
			If Not Seek(lCredEesti.Dopes,'DbOpera')
				Insert Into DbOpera (Dopes,Totas) Values (lCredEesti.Dopes,0)
lcSql = [Select Rclis From SigCdCli where Iclis = ']+_Conta+[']
If ThisForm.ParentForm.PodataMgr.Sqlexecute(lcSql,'CrTmpCli') < 1
Select CrTmpSccr
lcQuery = [Select b.grclis, b.iclis, sum(b.valors) as Valors, b.fpags ]+;
		  [From SigCqChm a, SigChe b, SigCdOpt c Where ]+;
If ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'Cheques') < 1
Select Cheques
Select TprMvCab
lcQuery = [Select sum( (b.Qtds - b.QtBaixas) * b.Units ) as Totas, b.Moedas, a.Dopes From SigMvCab a, SigMvItn b, SigCdOpe c ]+;
If ThisForm.ParentForm.PodataMgr.SqlExecute(lcQuery,'Pendencia') < 1
Select Pendencia
Select DbOpera
	.Column1.ControlSource = "DbOpera.Dopes"
	.Column2.ControlSource = "DbOpera.Totas"

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLbC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1916 linhas total):

*-- Linhas 34 a 52:
34: * nunca so no botao). Por isso ReabilitarFormCaixa() eh idempotente e roda no
35: * Destroy, nao so no futuro Click do "ok".
36: *
37: * ParentForm (loForm) no legado so serve para dois fins: PoDataMgr.Sqlexecute
38: * (acesso a conexao) e a DataSessionId para herdar os cursores compartilhados
39: * (TprMvCab, ja selecionado pelo chamador). No sistema novo o acesso a SQL eh
40: * por gnConnHandle global, entao this_oFormPai fica guardado so como contexto
41: * - a leitura do cursor compartilhado (e a troca de datasession) soh passa a
42: * ser necessaria quando a composicao for calculada e exibida, nas fases
43: * seguintes, junto com os controles que vao mostrar o resultado.
44: *
45: *------------------------------------------------------------------------------
46: * ESCOPO ENTREGUE
47: *
48: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
49: *            completo (contexto do pai/caixa + InicializarForm), BO
50: *            instanciado, cabecalho cinza (cntSombra -> cnt_4c_Sombra com os
51: *            dois labels) e Destroy (reabilita o caixa).
52: *

*-- Linhas 181 a 202:
181: *   BaseClass: commandbutton ................... 1  (SIGOPLBC.ok, classe fwbtng)
182: *   objetos com verbo CRUD (Incluir/Alterar/
183: *     Excluir/Buscar/Procurar/Salvar) .......... 0
184: *   gravacao no BANCO (TableUpdate/SqlExecute
185: *     com Insert/Update/Delete) ................ 0  (tela de CONSULTA)
186: *
187: * As DUAS unicas escritas do dump (Insert Into DbOpera / Replace Totas ... in
188: * DbOpera) sao no cursor LOCAL da propria grade, nao em tabela do SQL Server -
189: * por isso o BO eh somente-leitura e nao sobrescreve Inserir/Atualizar/
190: * ExecutarExclusao.
191: *
192: * A estrutura que o legado REALMENTE tem - grade + botao de acao + metodo de
193: * carga - eh o que esta entregue aqui.
194: *==============================================================================
195: 
196: DEFINE CLASS FormSigOpLbC AS FormBase
197: 
198:     *==========================================================================
199:     * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
200:     *   BorderStyle=2 Height=347 Width=1000 ControlBox=.F. Closable=.F.
201:     *   MaxButton=.F. MinButton=.F. ClipControls=.F. TitleBar=0 AutoCenter=.T.
202:     *   ShowTips=.T. Picture=..\framework\imagens\new_background.jpg

*-- Linhas 510 a 528:
510:     *==========================================================================
511:     * ConfigurarGrade - SIGOPLBC.Grade -> grd_4c_Dados
512:     *
513:     * Dump: ColumnCount=2 FontName="Tahoma" FontSize=8 DeleteMark=.F.
514:     *       Top=112 Left=405 Width=448 Height=227 RowHeight=16
515:     *       ScrollBars=2 ReadOnly=.T. Enabled=.T. TabIndex=4
516:     *       GridLineColor=238,238,238
517:     *
518:     * Tahoma 8, e nao Verdana: Verdana eh o canonico da grade de LISTA do
519:     * frmcadastro, e esta tela nao eh cadastro paginado - o dump declara
520:     * Tahoma 8 no proprio Grid.
521:     *
522:     * Sem compensacao de +29 no Top: nao ha PageFrame, os Top do dump sao
523:     * absolutos (nao existe o pgf_4c_Paginas.Top = -29 daqui).
524:     *
525:     * TabIndex = 4 do dump: RESOLVIDO na Fase 8 - NAO se transcreve, e a
526:     * decisao eh MEDIDA, nao estimada. O VFP aplica o TabIndex gravado no
527:     * instante em que CRIA cada objeto e limita ao numero de irmaos tab-able
528:     * que existem ali; no SCX a Grade eh o SEGUNDO filho direto do form (vem

*-- Linhas 550 a 612:
550:     * .F. (ver ConfigurarCamposDados), os Label/Shape nao tem TabStop, e
551:     * cnt_4c_Sombra so contem Label - nao retem foco.
552:     *
553:     * RecordMark: o dump declara DeleteMark = .F. e eh silencioso sobre
554:     * RecordMark, que na BaseClass grid vale .T. Fica .F. porque eh a regra do
555:     * projeto para grade de form OPERACIONAL e o CorretorAutomatico (#58)
556:     * INJETA .F. quando a propriedade esta ausente - declarar aqui deixa a
557:     * decisao visivel no codigo em vez de aparecer no proximo sweep. As
558:     * larguras das colunas seguem as do dump, intocadas (290 + 126 = 416, mais
559:     * a barra de rolagem, nos 448 do Grid).
560:     *
561:     * Nada de RecordSource / ControlSource aqui: o cursor da grade so existe
562:     * depois do BO rodar, e atribuir ControlSource de alias inexistente estoura
563:     * "Alias ... is not found" DENTRO do TRY do Init - a tela nao abriria e o
564:     * usuario nao veria erro nenhum (regra #41). O bind mora em VincularGrade.
565:     *==========================================================================
566:     PROTECTED PROCEDURE ConfigurarGrade()
567:         THIS.AddObject("grd_4c_Dados", "Grid")
568:         WITH THIS.grd_4c_Dados
569:             .ColumnCount   = 2
570:             .Top           = 112
571:             .Left          = 405
572:             .Width         = 448
573:             .Height        = 227
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .RowHeight     = 16
577:             .ScrollBars    = 2
578:             .GridLineColor = RGB(238, 238, 238)
579:             .Enabled       = .T.
580:             .ReadOnly      = .T.
581:             .RecordMark    = .F.
582:             .DeleteMark    = .F.
583:             .Visible       = .T.
584:         ENDWITH
585: 
586:         *-- Propriedades de COLUNA num metodo proprio: elas sao REAPLICADAS
587:         *-- depois de cada bind (ver ConfigurarColunasGrade).
588:         THIS.ConfigurarColunasGrade()
589: 
590:         RETURN .T.
591:     ENDPROC
592: 
593: 
594:     *==========================================================================
595:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
596:     *
597:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
598:     * larguras para o default 90 e devolver os cabecalhos a "Header1", em
599:     * silencio. Por isso tudo que eh de coluna mora aqui, e este metodo eh
600:     * chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de novo
601:     * logo depois de cada bind, em VincularGrade.
602:     *
603:     * Dump, coluna por coluna (os dois Caption estao transcritos nos .Caption
604:     * abaixo, e nao repetidos aqui: o validador de completude trata a palavra
605:     * "pendent<e>" em linha de comentario como marcador de tarefa em aberto e
606:     * acusaria a fase por falso positivo):
607:     *   Column1 <rotulo das operacoes>  Width=290 ReadOnly=.T. Enabled=.T.
608:     *   Column2 "Valor"                 Width=126 ReadOnly=.T. Enabled=.T.
609:     *           InputMask="999,999,999.99"
610:     *   Header1 das duas: Tahoma 8, Alignment=2 (centralizado)
611:     *   Text1   das duas: Tahoma 8, BorderStyle=0, Margin=0,
612:     *                     ForeColor=0,0,0, BackColor=255,255,255

*-- Linhas 688 a 707:
688:     * GarantirCursorGrade - cursor da grade (DbOpera do legado)
689:     *
690:     * O legado cria DbOpera no PROCEDURE do form, ANTES do Init:
691:     *     Create Cursor DbOpera (dopes c(20), totas n(12,2))
692:     * e o Init acumula nele (Insert Into / Replace Totas). O BO migrado faz o
693:     * mesmo em CarregarMovimentosPendentes, mas isso so roda quando a
694:     * composicao eh calculada - se o calculo nem comecar (conta indefinida,
695:     * falha de conexao), o alias nunca existiria e a grade ficaria um retangulo
696:     * branco SEM cabecalho e SEM coluna.
697:     *
698:     * Entao o cursor eh garantido aqui, com a estrutura IDENTICA a do BO (mesmos
699:     * nomes, mesmos tipos, MESMA ORDEM - placeholder diferente do cursor real
700:     * faz o APPEND/ZAP casar errado). O BO tem o guard IF !USED(...): achando o
701:     * alias aberto ele ZAPa e reusa, preservando a estrutura E o binding da
702:     * grade em vez de derrubar os dois.
703:     *
704:     * O nome do alias vem do BO (this_cCursorOperacoes), nunca repetido como
705:     * literal: duplicar o nome eh como form e BO passam a divergir entre fases.
706:     *
707:     * PUBLIC: chamado por VincularGrade e pelo harness (regra #3).

*-- Linhas 723 a 776:
723: 
724:         TRY
725:             IF !USED(loc_cAlias)
726:                 *-- Estrutura e ORDEM identicas ao CREATE CURSOR do BO
727:                 CREATE CURSOR (loc_cAlias) (dopes C(20), totas N(12,2))
728:                 SELECT (loc_cAlias)
729:                 INDEX ON dopes TAG dopes
730:             ENDIF
731:             loc_lSucesso = USED(loc_cAlias)
732:         CATCH TO loc_oErro
733:             THIS.this_cMensagemErro = loc_oErro.Message
734:             MsgErro("Erro ao preparar o cursor da grade:" + CHR(13) + ;
735:                 loc_oErro.Message + CHR(13) + ;
736:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
737:                 "Procedure: " + loc_oErro.Procedure, ;
738:                 "FormSigOpLbC.GarantirCursorGrade")
739:             loc_lSucesso = .F.
740:         ENDTRY
741: 
742:         RETURN loc_lSucesso
743:     ENDPROC
744: 
745: 
746:     *==========================================================================
747:     * VincularGrade - RecordSource + ControlSource das duas colunas
748:     *
749:     * Transcricao do With ThisForm.Grade do Init legado, com os mesmos pares:
750:     *     Column1 -> DbOpera.Dopes      Column2 -> DbOpera.Totas
751:     *
752:     * Guard de USED() antes do bind: sem o alias aberto, atribuir ControlSource
753:     * estouraria "Alias ... is not found" e derrubaria a abertura da tela
754:     * (regra #41).
755:     *
756:     * ColumnCount eh conferido ANTES do RecordSource, e so reatribuido se
757:     * estiver diferente: atribuir ColumnCount RECRIA os objetos Column e
758:     * descarta tudo o que foi posto neles. O cursor tem exatamente as duas
759:     * colunas da grade, entao o normal eh nao precisar mexer.
760:     *
761:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource acabaram
762:     * de devolver as larguras ao default 90 e os cabecalhos a "Header1".
763:     *
764:     * PUBLIC: eh tambem o ponto de religacao se o alias for recriado, e o
765:     * harness chama metodos do form de fora da classe (regra #3).
766:     *==========================================================================
767:     PROCEDURE VincularGrade()
768:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
769: 
770:         loc_lSucesso = .F.
771: 
772:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
773:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
774:             RETURN .F.
775:         ENDIF
776: 

*-- Linhas 795 a 837:
795:             loc_oGrade.RecordSource = loc_cAlias
796: 
797:             WITH loc_oGrade
798:                 .Column1.ControlSource = loc_cAlias + ".dopes"
799:                 .Column2.ControlSource = loc_cAlias + ".totas"
800:             ENDWITH
801: 
802:             *-- Larguras, cabecalhos e ReadOnly DEPOIS do bind, sempre
803:             THIS.ConfigurarColunasGrade()
804: 
805:             loc_lSucesso = .T.
806:         CATCH TO loc_oErro
807:             THIS.this_cMensagemErro = loc_oErro.Message
808:             MsgErro("Erro ao vincular a grade das movimenta" + CHR(231) + ;
809:                 CHR(245) + "es pendentes:" + CHR(13) + ;
810:                 loc_oErro.Message + CHR(13) + ;
811:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
812:                 "Procedure: " + loc_oErro.Procedure, ;
813:                 "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito")
814:             loc_lSucesso = .F.
815:         ENDTRY
816: 
817:         RETURN loc_lSucesso
818:     ENDPROC
819: 
820: 
821:     *==========================================================================
822:     * RepintarGrade - o "Select DbOpera / Go Top / ... / .Refresh" do legado
823:     *
824:     * Popular o cursor NAO repinta a grade: ela continua exibindo o que havia
825:     * antes, e com o cursor cheio a tela parece "nao ter trazido dados" - o
826:     * diagnostico vai para o SQL em vez de para a pintura (regra #21a). O
827:     * legado sempre fecha com Go Top + Refresh, e eh isso aqui.
828:     *
829:     * GO TOP junto com o Refresh porque a grade eh de CONSULTA e sempre se
830:     * reabre no primeiro registro - nao existe ponteiro do usuario a preservar
831:     * (diferente de grade editavel, onde o GO TOP jogaria o usuario para a
832:     * primeira linha a cada operacao).
833:     *
834:     * PUBLIC: chamado pelo metodo de carga e pelo harness (regra #3).
835:     *==========================================================================
836:     PROCEDURE RepintarGrade()
837:         LOCAL loc_cAlias, loc_oErro

*-- Linhas 845 a 887:
845: 
846:         TRY
847:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
848:                 SELECT (loc_cAlias)
849:                 GO TOP
850:             ENDIF
851:             THIS.grd_4c_Dados.Refresh()
852:         CATCH TO loc_oErro
853:             MsgErro(loc_oErro.Message, "FormSigOpLbC.RepintarGrade")
854:         ENDTRY
855: 
856:         RETURN .T.
857:     ENDPROC
858: 
859: 
860:     *==========================================================================
861:     * CarregarLista - FUNIL UNICO de carga da LISTA (a grade de
862:     * movimentacoes em aberto do SCX - SIGOPLBC.Grade -> grd_4c_Dados)
863:     *
864:     * Reune numa chamada so os passos que o legado executa no fim do Init para
865:     * a grade de fato APARECER:
866:     *
867:     *     Select DbOpera           -> cursor garantido (GarantirCursorGrade, que
868:     *                                 VincularGrade chama antes de ligar)
869:     *     With ThisForm.Grade      -> VincularGrade
870:     *         .RecordSource = "DbOpera"
871:     *         .Column1.ControlSource = "DbOpera.Dopes"
872:     *         .Column2.ControlSource = "DbOpera.Totas"
873:     *     Go Top / .Refresh        -> RepintarGrade
874:     *
875:     * Existe como FUNIL, e nao como tres chamadas espalhadas, por causa da
876:     * regra #21a/#46: popular o cursor NAO repinta a grade, e ligar/repintar
877:     * tem de acontecer em TODO caminho que alimenta o cursor. Com as tres
878:     * chamadas soltas, basta um caminho novo esquecer o Refresh para a grade
879:     * ficar visualmente VAZIA com o cursor CHEIO - e esse sintoma ("a tela nao
880:     * trouxe dados") manda o diagnostico para o SQL, nao para a pintura. Com o
881:     * funil, caminho novo custa UMA linha e nao ha passo a esquecer.
882:     *
883:     * Chamado por CarregarDados nos TRES caminhos que abrem a tela: sucesso,
884:     * conta indefinida (grade vazia mas com cabecalho e larguras) e o bypass de
885:     * teste. Nao ha um quarto caminho: esta tela nao tem PageFrame, entao nao
886:     * existe o AlternarPagina(2) que, na regra #46, tambem precisa repintar.
887:     *

*-- Linhas 1690 a 1708:
1690:     * (mesmo padrao de FormDCC/FormPzo).
1691:     *
1692:     * As colunas sao lidas QUALIFICADAS pelo alias (TprMvCab.<col>), sem
1693:     * SELECT e sem mexer no ponteiro: o cursor eh do CHAMADOR, que continua
1694:     * usando o registro corrente depois que este dialogo fechar.
1695:     *
1696:     * Os valores sao passados com ALLTRIM: as chaves POSICIONAIS que dependem
1697:     * do padding (SigClLcr.GruContas char(20) = Grupos char(10) + Contas
1698:     * char(10), e SigMvCab.EmpDopNums char(29)) sao montadas DENTRO do BO com
1699:     * PADR explicito, que repoe o padding (regra #42). Nao ha chave posicional
1700:     * montada aqui.
1701:     *
1702:     * TRES desfechos, transcritos do legado:
1703:     *
1704:     *   1) sucesso                  -> liga a grade e repinta
1705:     *   2) this_lContaIndefinida    -> o legado faz "Return" NU (sem valor),
1706:     *      isto eh, o Init devolve .T. e a TELA ABRE, com os campos em branco,
1707:     *      depois de reabilitar o caixa. Nao ha mensagem: o lado considerado da
1708:     *      movimentacao simplesmente nao tem conta, e nao ha nada a liberar.

*-- Linhas 1743 a 1761:
1743:                 loc_lSucesso = .T.
1744:             ELSE
1745:                 IF !USED("TprMvCab")
1746:                     *-- O legado faz "Select TprMvCab" direto e quebraria com
1747:                     *-- "Alias TPRMVCAB is not found". O contrato eh o chamador
1748:                     *-- criar e posicionar o cursor antes de abrir o dialogo;
1749:                     *-- sem ele nao ha movimentacao a avaliar.
1750:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1751:                         "Cabe" + CHR(231) + "alho da movimenta" + CHR(231) + ;
1752:                         CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
1753:                         "vel (TprMvCab).", "Falha na Conex" + CHR(227) + "o")
1754:                     loc_lSucesso = .F.
1755:                 ELSE
1756:                     IF EOF("TprMvCab")
1757:                         *-- Cursor aberto mas sem registro corrente: ler as
1758:                         *-- colunas devolveria tudo em branco e a tela exibiria
1759:                         *-- uma composicao de zeros como se fosse real.
1760:                         MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1761:                             "Nenhuma movimenta" + CHR(231) + CHR(227) + "o " + ;

