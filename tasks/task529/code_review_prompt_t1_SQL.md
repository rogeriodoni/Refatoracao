# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CODIGOS

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
	.Column1.ControlSource = 'xOpe.codigos'
	.Column2.ControlSource = 'xOpe.descrs'
lcSql = [Select a.*, b.descrs From SigCdTbd a, SigOpTdz b Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.codigos = b.codigos ]
ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
Select CsSelecao
	Select xOpe
Select xOpe
Insert Into xOpe (codigos) Values ( Space(10))
Select xOpe
Select xOpe
	Select xOpe
	Delete 
	Select Codigos, Sum(1) as Qt From xOpe Group by 1 Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	Select CrSigCdTbd
	Select xOpe
			Insert Into crSigCdTbd (Dopes, codigos, cIdChaves) ;
		lcSql = [Delete From SigCdTbd Where dopes = ']+CrSigCdOpe.dopes+[']
		m.lnErro1 = ( .PodataMgr.SqlExecute(lcSql,'') )
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdTbd'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormTbd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1260 linhas total):

*-- Linhas 271 a 289:
271:                 .Height        = 274
272:                 .ColumnCount   = 2
273:                 .ScrollBars    = 2
274:                 .DeleteMark    = .F.
275:                 .RecordMark    = .F.
276:                 .GridLineColor = RGB(238, 238, 238)
277:                 .ReadOnly      = .F.
278:                 .Visible       = .T.
279: 
280:                 .Column1.Width      = 80
281:                 .Column1.Movable    = .F.
282:                 .Column1.Resizable  = .F.
283:                 .Column1.Header1.Caption   = "Tabela"
284:                 .Column1.Header1.FontName  = "Verdana"
285:                 .Column1.Header1.FontSize  = 8
286:                 .Column1.Header1.Alignment = 2
287:                 .Column1.Header1.ForeColor = RGB(36, 84, 155)
288:                 .Column1.Text1.FontName    = "Courier New"
289:                 .Column1.Text1.BorderStyle = 0

*-- Linhas 580 a 612:
580:                 loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)
581: 
582:                 IF EMPTY(loc_cValor)
583:                     SELECT cursor_4c_Dados
584:                     REPLACE descrs WITH ""
585:                 ELSE
586:                     IF USED("cursor_4c_ValTbd")
587:                         USE IN cursor_4c_ValTbd
588:                     ENDIF
589: 
590:                     loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
591:                                " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)
592: 
593:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValTbd")
594: 
595:                     IF loc_nResultado > 0 AND USED("cursor_4c_ValTbd") AND ;
596:                        RECCOUNT("cursor_4c_ValTbd") > 0
597:                         SELECT cursor_4c_Dados
598:                         REPLACE descrs WITH ALLTRIM(cursor_4c_ValTbd.descrs)
599:                         THIS.GravaDados = .T.
600: 
601:                         IF USED("cursor_4c_ValTbd")
602:                             USE IN cursor_4c_ValTbd
603:                         ENDIF
604: 
605:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
606:                         loc_oGrid.Refresh
607:                     ELSE
608:                         IF USED("cursor_4c_ValTbd")
609:                             USE IN cursor_4c_ValTbd
610:                         ENDIF
611:                         THIS.AbrirLookupTabelaDesconto()
612:                     ENDIF

*-- Linhas 638 a 685:
638:                 ENDIF
639: 
640:                 IF !EMPTY(loc_cValor)
641:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
642:                                " WHERE codigos LIKE " + EscaparSQL(loc_cValor + "%") + ;
643:                                " OR descrs LIKE " + EscaparSQL(loc_cValor + "%") + ;
644:                                " ORDER BY codigos"
645:                 ELSE
646:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
647:                                " ORDER BY codigos"
648:                 ENDIF
649: 
650:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")
651: 
652:                 *-- Fallback SHOW-ALL: prefixo nao bateu, lista tudo
653:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
654:                    RECCOUNT("cursor_4c_LkpTbd") = 0 AND !EMPTY(loc_cValor)
655:                     USE IN cursor_4c_LkpTbd
656:                     loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs FROM SigOpTdz" + ;
657:                                " ORDER BY codigos"
658:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTbd")
659:                 ENDIF
660: 
661:                 IF loc_nResultado > 0 AND USED("cursor_4c_LkpTbd") AND ;
662:                    RECCOUNT("cursor_4c_LkpTbd") > 0
663: 
664:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
665:                     IF VARTYPE(loc_oBusca) = "O"
666:                         loc_oBusca.DefinirCursor("cursor_4c_LkpTbd", "Cods", "Descs", ;
667:                             "Tabelas de Desconto")
668: 
669:                         IF loc_oBusca.Mostrar()
670:                             SELECT cursor_4c_Dados
671:                             REPLACE codigos WITH LEFT(ALLTRIM(loc_oBusca.cCodigoSelecionado), 10), ;
672:                                     descrs  WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
673:                             THIS.GravaDados = .T.
674: 
675:                             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
676:                             loc_oGrid.Refresh
677:                         ENDIF
678:                     ENDIF
679:                 ELSE
680:                     MsgAviso("Nenhuma tabela de desconto encontrada" + ;
681:                         IIF(!EMPTY(loc_cValor), " para [" + loc_cValor + "]", "") + ".", ;
682:                         "Tabelas de Desconto")
683:                 ENDIF
684: 
685:                 IF USED("cursor_4c_LkpTbd")

*-- Linhas 697 a 730:
697:     * CarregarLista - Busca as tabelas de desconto ja vinculadas a operacao
698:     * corrente (THIS.this_cDopes) e vincula cursor_4c_Dados ao grid.
699:     * RecordSource reseta Column.Width/Header1.Caption (Problema 48) - por
700:     * isso a reconfiguracao acontece SEMPRE apos o ControlSource.
701:     *--------------------------------------------------------------------------
702:     PROTECTED FUNCTION CarregarLista()
703:         LOCAL loc_oGrid, loc_lSucesso, loc_oErro
704:         loc_lSucesso = .F.
705:         TRY
706:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
707:                THIS.this_oBusinessObject.BuscarPorOperacao(THIS.this_cDopes)
708: 
709:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
710: 
711:                 loc_oGrid.RecordSource = ""
712:                 loc_oGrid.ColumnCount  = 2
713:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
714:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
715:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
716: 
717:                 *-- Reconfigura Width/Header1.Caption (perdidos ao resetar RecordSource)
718:                 loc_oGrid.Column1.Width           = 80
719:                 loc_oGrid.Column1.Header1.Caption = "Tabela"
720:                 loc_oGrid.Column2.Width           = 200
721:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
722:                 loc_oGrid.Column2.Text1.ReadOnly  = .T.
723: 
724:                 loc_oGrid.Refresh
725: 
726:                 THIS.GravaDados = .F.
727:                 loc_lSucesso = .T.
728:             ENDIF
729:         CATCH TO loc_oErro
730:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 762 a 794:
762:     *--------------------------------------------------------------------------
763:     * BtnIncluirClick - Adiciona linha em branco no cursor_4c_Dados e coloca
764:     * o foco na coluna do codigo para digitacao. Espelha cmdInserir.Click do
765:     * legado: Insert Into xOpe (codigos) Values (Space(10)) / GravaDados = .t.
766:     * / GradeOpe.Column1.SetFocus. Handler ligado ao botao Inserir da Page1.
767:     *--------------------------------------------------------------------------
768:     PROCEDURE BtnIncluirClick()
769:         LOCAL loc_oGrid, loc_oErro
770:         TRY
771:             IF !USED("cursor_4c_Dados")
772:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
773:                     CHR(225) + " carregada.", "Aviso")
774:             ELSE
775:                 *-- Sai do modo somente-leitura (caso venha de VISUALIZAR)
776:                 THIS.HabilitarEdicaoGrid(.T.)
777:                 THIS.this_cModoAtual = "INCLUIR"
778: 
779:                 INSERT INTO cursor_4c_Dados (codigos) VALUES (SPACE(10))
780: 
781:                 THIS.GravaDados = .T.
782:                 THIS.AntValue   = SPACE(10)
783: 
784:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
785:                 loc_oGrid.Refresh
786:                 loc_oGrid.SetFocus
787:                 loc_oGrid.ActiveColumn = 1
788:                 IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
789:                     loc_oGrid.Column1.Text1.SetFocus
790:                 ENDIF
791:             ENDIF
792:         CATCH TO loc_oErro
793:             MsgErro(loc_oErro.Message + CHR(13) + ;
794:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 810 a 828:
810:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
811:                     CHR(225) + " carregada.", "Aviso")
812:             ELSE
813:                 SELECT cursor_4c_Dados
814:                 IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
815:                     MsgAviso("Selecione uma tabela de desconto na lista.", ;
816:                         "Aten" + CHR(231) + CHR(227) + "o")
817:                 ELSE
818:                     THIS.HabilitarEdicaoGrid(.T.)
819:                     THIS.this_cModoAtual = "ALTERAR"
820:                     THIS.AntValue        = cursor_4c_Dados.codigos
821: 
822:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
823:                     loc_oGrid.Refresh
824:                     loc_oGrid.SetFocus
825:                     loc_oGrid.ActiveColumn = 1
826:                     IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
827:                         loc_oGrid.Column1.Text1.SetFocus
828:                     ENDIF

*-- Linhas 849 a 891:
849:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
850:                     CHR(225) + " carregada.", "Aviso")
851:             ELSE
852:                 SELECT cursor_4c_Dados
853:                 IF RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
854:                     MsgAviso("Selecione uma tabela de desconto na lista.", ;
855:                         "Aten" + CHR(231) + CHR(227) + "o")
856:                 ELSE
857:                     THIS.this_cModoAtual = "VISUALIZAR"
858:                     THIS.HabilitarEdicaoGrid(.F.)
859: 
860:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
861:                     loc_oGrid.Refresh
862: 
863:                     loc_cValor = ALLTRIM(cursor_4c_Dados.codigos)
864: 
865:                     IF EMPTY(loc_cValor)
866:                         MsgAviso("Linha sem c" + CHR(243) + "digo de tabela informado.", ;
867:                             "Tabelas de Desconto")
868:                     ELSE
869:                         IF USED("cursor_4c_VisTbd")
870:                             USE IN cursor_4c_VisTbd
871:                         ENDIF
872: 
873:                         loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
874:                                    " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cValor)
875: 
876:                         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VisTbd")
877: 
878:                         IF loc_nResultado > 0 AND USED("cursor_4c_VisTbd") AND ;
879:                            RECCOUNT("cursor_4c_VisTbd") > 0
880: 
881:                             MsgInfo("Opera" + CHR(231) + CHR(227) + "o: " + ;
882:                                 ALLTRIM(THIS.this_cDopes) + CHR(13) + ;
883:                                 "C" + CHR(243) + "digo: " + ;
884:                                 ALLTRIM(NVL(cursor_4c_VisTbd.codigos, "")) + CHR(13) + ;
885:                                 "Descri" + CHR(231) + CHR(227) + "o: " + ;
886:                                 ALLTRIM(NVL(cursor_4c_VisTbd.descrs, "")), ;
887:                                 "Tabela de Desconto")
888: 
889:                             USE IN cursor_4c_VisTbd
890:                         ELSE
891:                             IF USED("cursor_4c_VisTbd")

*-- Linhas 898 a 945:
898:                         ENDIF
899:                     ENDIF
900: 
901:                     SELECT cursor_4c_Dados
902:                 ENDIF
903:             ENDIF
904:         CATCH TO loc_oErro
905:             MsgErro(loc_oErro.Message + CHR(13) + ;
906:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
907:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnVisualizarClick")
908:         ENDTRY
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * BtnExcluirClick - Remove a linha corrente do cursor_4c_Dados. Espelha
913:     * cmdExcluir.Click do legado (Delete / Skip / Go Bott se Eof / GravaDados
914:     * = .t.) - sem confirmacao, igual ao original. Bloqueado em VISUALIZAR.
915:     *--------------------------------------------------------------------------
916:     PROCEDURE BtnExcluirClick()
917:         LOCAL loc_oGrid, loc_oErro
918:         TRY
919:             IF !USED("cursor_4c_Dados")
920:                 MsgAviso("Lista de tabelas de desconto n" + CHR(227) + "o est" + ;
921:                     CHR(225) + " carregada.", "Aviso")
922:             ELSE
923:                 IF THIS.this_cModoAtual = "VISUALIZAR"
924:                     MsgAviso("Lista em modo de visualiza" + CHR(231) + CHR(227) + "o." + ;
925:                         CHR(13) + "Clique em Inserir ou volte a alterar a linha " + ;
926:                         "antes de excluir.", "Tabelas de Desconto")
927:                 ELSE
928:                     SELECT cursor_4c_Dados
929:                     IF !EOF()
930:                         DELETE
931:                         SKIP
932:                         IF EOF()
933:                             GO BOTTOM
934:                         ENDIF
935:                     ENDIF
936: 
937:                     THIS.GravaDados = .T.
938: 
939:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
940:                     loc_oGrid.Refresh
941:                     loc_oGrid.SetFocus
942:                 ENDIF
943:             ENDIF
944:         CATCH TO loc_oErro
945:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 957 a 975:
957:     * (SalvarPorOperacao) apenas exibe o erro mas NAO impede o fechamento -
958:     * no legado o "MessageBox('Erro na Gravacao...')" nao tem Return .f.
959:     * apos ele, o fluxo cai direto em ParentForm.Enabled=.T./Release. Usa
960:     * TbdBO.VerificarDuplicidade + SalvarPorOperacao (DELETE + INSERT por
961:     * operacao, ja implementados na Fase 1/2).
962:     *--------------------------------------------------------------------------
963:     PROCEDURE BtnConfirmarClick()
964:         LOCAL loc_lPodeFechar, loc_oErro
965:         loc_lPodeFechar = .T.
966:         TRY
967:             *-- Toda a gravacao (FormParaBO + duplicidade + SalvarPorOperacao)
968:             *-- esta em BtnSalvarClick; aqui so decidimos se o form fecha.
969:             loc_lPodeFechar = THIS.BtnSalvarClick()
970:         CATCH TO loc_oErro
971:             loc_lPodeFechar = .F.
972:             MsgErro(loc_oErro.Message + CHR(13) + ;
973:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
974:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BtnConfirmarClick")
975:         ENDTRY

*-- Linhas 1000 a 1018:
1000:     * o cmdSair.Click do legado, que monta o registro a partir de
1001:     * crSigCdOpe.Dopes + xOpe.codigos antes de gravar.
1002:     * Retorna .F. (com aviso) quando o form nao tem operacao definida - sem
1003:     * Dopes o DELETE/INSERT por operacao apagaria a faixa errada.
1004:     *--------------------------------------------------------------------------
1005:     FUNCTION FormParaBO()
1006:         LOCAL loc_lSucesso, loc_oErro
1007:         loc_lSucesso = .F.
1008:         TRY
1009:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1010:                 MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
1011:                     "Tabelas de Desconto")
1012:             ELSE
1013:                 IF EMPTY(ALLTRIM(THIS.this_cDopes))
1014:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
1015:                         "o informada." + CHR(13) + "Selecione a opera" + CHR(231) + ;
1016:                         CHR(227) + "o antes de gravar as tabelas de desconto.", ;
1017:                         "Tabelas de Desconto")
1018:                 ELSE

*-- Linhas 1095 a 1127:
1095:                         USE IN cursor_4c_BoTbd
1096:                     ENDIF
1097: 
1098:                     loc_cSQL = "SELECT codigos, descrs FROM SigOpTdz" + ;
1099:                                " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cCodigo)
1100: 
1101:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BoTbd")
1102: 
1103:                     IF loc_nResultado > 0 AND USED("cursor_4c_BoTbd") AND ;
1104:                        RECCOUNT("cursor_4c_BoTbd") > 0
1105:                         loc_cDescricao = ALLTRIM(NVL(cursor_4c_BoTbd.descrs, ""))
1106:                     ENDIF
1107: 
1108:                     IF USED("cursor_4c_BoTbd")
1109:                         USE IN cursor_4c_BoTbd
1110:                     ENDIF
1111: 
1112:                     SELECT cursor_4c_Dados
1113:                     REPLACE codigos WITH LEFT(loc_cCodigo, 10), ;
1114:                             descrs  WITH loc_cDescricao
1115: 
1116:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1117:                     loc_oGrid.Refresh
1118:                 ENDIF
1119: 
1120:                 loc_lSucesso = .T.
1121:             ENDIF
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message + CHR(13) + ;
1124:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1125:                 "Procedure: " + loc_oErro.Procedure, "FormTbd.BOParaForm")
1126:         ENDTRY
1127:         RETURN loc_lSucesso

*-- Linhas 1159 a 1177:
1159:     * form. Concentra a logica de gravacao do cmdSair.Click legado:
1160:     *   If ThisForm.GravaDados
1161:     *       <checa duplicidade> -> Return .f.
1162:     *       Zap crSigCdTbd / Scan xOpe -> Insert / Delete From SigCdTbd / Update
1163:     *       If erro -> MessageBox (sem Return .f.)
1164:     *   EndIf
1165:     * Retorno: .T. = fluxo pode prosseguir (nada a gravar, ou gravacao
1166:     * tentada); .F. = duplicidade detectada, o usuario precisa corrigir o
1167:     * grid. Esse retorno eh o que BtnConfirmarClick usa para decidir se fecha
1168:     * o form - no legado somente a duplicidade tem "Return .f.": um erro de
1169:     * gravacao exibe a mensagem mas o form fecha assim mesmo.
1170:     *--------------------------------------------------------------------------
1171:     FUNCTION BtnSalvarClick()
1172:         LOCAL loc_lProsseguir, loc_oErro
1173:         loc_lProsseguir = .T.
1174:         TRY
1175:             IF THIS.GravaDados
1176:                 IF !THIS.FormParaBO()
1177:                     *-- Sem operacao definida: FormParaBO ja avisou o usuario


### BO (C:\4c\projeto\app\classes\TbdBO.prg):
*====================================================================
* TbdBO.prg
*
* Business Object para Tabelas de Desconto por Operacao
* Tabela principal: SigCdTbd (cidchaves PK)
* Tabela pai: SigCdOpe (dopes) - Operacao a qual as tabelas pertencem
* Tabela de referencia (lookup): SigOpTdz (codigos) - Tabela de Desconto
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbdBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTbd)
	this_cCodigos     = ""   && codigos char(10)   - codigo da tabela de desconto (FK SigOpTdz.codigos)
	this_cCidChaves   = ""   && cidchaves char(20) - PK (chave unica Fortyus)
	this_cDopes       = ""   && dopes char(20)     - codigo/descricao da operacao (FK SigCdOpe.dopes)

	*-- Propriedades locais (NAO persistem - apenas estado/UI)
	this_cDescOperacao = ""  && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTbd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos   = TratarNulo(codigos, "C")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, dopes" + ;
			           " FROM SigCdTbd" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
			           " VALUES (" + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           EscaparSQL(THIS.this_cCidChaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTbd SET" + ;
			           " codigos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           " dopes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarPorOperacao - Carrega TODAS as tabelas de desconto vinculadas
	* a uma operacao (Dopes), com a descricao da tabela (SigOpTdz.descrs).
	* Espelha o SELECT original do Init() legado:
	*   Select a.*, b.descrs From SigCdTbd a, SigOpTdz b
	*   Where a.Dopes = <dopes> And a.codigos = b.codigos
	* cursor_4c_Dados eh convertido para READWRITE (SQLEXEC gera cursor
	* somente-leitura) pois o grid permite Inserir/Excluir/editar linhas
	* localmente antes de Confirmar (SalvarPorOperacao).
	*====================================================================
	PROCEDURE BuscarPorOperacao(par_cDopes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT a.codigos AS codigos, a.cidchaves AS cidchaves," + ;
			           " a.dopes AS dopes, b.descrs AS descrs" + ;
			           " FROM SigCdTbd a INNER JOIN SigOpTdz b ON a.codigos = b.codigos" + ;
			           " WHERE RTRIM(a.dopes) = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
			           " ORDER BY a.codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResultado >= 0
				SELECT codigos, cidchaves, dopes, descrs ;
					FROM cursor_4c_DadosTmp ;
					INTO CURSOR cursor_4c_Dados READWRITE

				IF USED("cursor_4c_DadosTmp")
					USE IN cursor_4c_DadosTmp
				ENDIF

				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DadosTmp")
				USE IN cursor_4c_DadosTmp
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarPorOperacao - Grava a lista completa de tabelas de desconto
	* de uma operacao (Dopes), substituindo os registros existentes.
	* Espelha o cmdSair.Click original: Delete From SigCdTbd Where dopes = ?
	* seguido de Insert Into SigCdTbd para cada linha nao vazia do grid.
	* par_cAliasCursor: cursor com as linhas do grid (coluna codigos).
	*====================================================================
	PROCEDURE SalvarPorOperacao(par_cDopes, par_cAliasCursor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves

		loc_lSucesso = .F.

		IF !USED(par_cAliasCursor)
			THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o localizado"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(dopes) = " + ;
			           EscaparSQL(ALLTRIM(par_cDopes))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir tabelas de desconto anteriores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.

				SELECT (par_cAliasCursor)
				SCAN WHILE loc_lSucesso
					IF !EMPTY(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")))
						loc_cCidChaves = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
						           " VALUES (" + ;
						           EscaparSQL(LEFT(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")), 10)) + "," + ;
						           EscaparSQL(loc_cCidChaves) + "," + ;
						           EscaparSQL(LEFT(ALLTRIM(par_cDopes), 20)) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("Erro ao gravar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ELSE
							THIS.this_cCidChaves = loc_cCidChaves
							THIS.this_cCodigos   = ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos"))
							THIS.this_cDopes     = ALLTRIM(par_cDopes)
							THIS.RegistrarAuditoria("INSERT")
						ENDIF
					ENDIF
				ENDSCAN

				SELECT (par_cAliasCursor)
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gravar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se ha codigos de tabela duplicados
	* no cursor do grid (espelha a checagem do cmdSair.Click original):
	*   Select Codigos, Sum(1) as Qt From xOpe Group by 1
	*   Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	*====================================================================
	FUNCTION VerificarDuplicidade(par_cAliasCursor)
		LOCAL loc_lDuplicado

		loc_lDuplicado = .F.

		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF

		IF USED("cursor_4c_Duplicados")
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT codigos, COUNT(*) AS Qt FROM (par_cAliasCursor) ;
			WHERE ALLTRIM(codigos) <> "" ;
			GROUP BY codigos ;
			HAVING COUNT(*) > 1 ;
			INTO CURSOR cursor_4c_Duplicados

		IF USED("cursor_4c_Duplicados")
			IF RECCOUNT("cursor_4c_Duplicados") > 0
				loc_lDuplicado = .T.
			ENDIF
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT (par_cAliasCursor)

		RETURN loc_lDuplicado
	ENDFUNC

ENDDEFINE

