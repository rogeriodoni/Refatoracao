# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_MUN' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, PCESCOLHA, CODIBGES, UFIBGES, ESTADOS, CPROS, TAG, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, PCESCOLHA, CODIBGES, UFIBGES, ESTADOS, CPROS, TAG, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, PCESCOLHA, CODIBGES, UFIBGES, ESTADOS, CPROS, TAG, ICLIS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SKCHAVES, TIPOS, PCESCOLHA, CODIBGES, UFIBGES, ESTADOS, CPROS, TAG, ICLIS

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
  ControlSource = "crSigCdRst.Rclis"
  ControlSource = "crSigCdRst.Iclis"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdRst.ChkMatrs"
	lcQuery = [Select a.*, b.Rclis from SigCdRst a inner join SigCdCli b on a.Iclis = b.Iclis]	
Select *, Space(40) As munici, Space(2) As uf From crSigcdRsi  Into Cursor crMuni Readwrite
Select crMuni
	.column1.ControlSource = 'crMuni.uf'
	.Column2.ControlSource = 'crMuni.munici'
Select *, Space(40) As dpros From crSigcdRsi  Into Cursor crProd Readwrite
Select crProd
	.column1.ControlSource = 'crProd.cpros'
	.Column2.ControlSource = 'crProd.dpros'
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRst Where skChaves = ?pChave], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRsi Where skChaves = ?pChave], '') < 1)
If Not Thisform.poDataMgr.Update('crSigcdRst')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigcdRst )')
If Not Thisform.poDataMgr.Update('crSigcdRsi')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigcdRsi )')
Select crSigCdRst
Delete For skChaves = pChave
Select crSigCdRsi
Delete For skChaves = pChave
	If Not ThisForm.poDataMgr.Update('crSigCdRst')
	If Not ThisForm.poDataMgr.Update('crSigCdRsi')
If Not Thisform.poDataMgr.Update('crSigcdRst')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigcdRst )')
If Not Thisform.poDataMgr.Update('crSigcdRsi')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigcdRsi )')
Select crMuni
lcSql = [Select distinct a.skchaves, pkchaves, codibges, tipos, a.UFIBGEs,] +;
	[c.descs as munici, d.estados as uf From SigCdRsi a ] + ;
	[left Join SigCdRst b On a.skChaves = b.skchaves ] +  ;
	[left join sigcdmun c on c.codigos = a.codibges ] +;
	[left join sigcdufs d on d.ufibges = a.ufibges ] +;
=Thisform.PodataMgr.SqlExecute(lcSql,'TmpMun')
Select TmpMun
	Select crMuni
Select crMuni
Select crProd
lcSql = [Select distinct a.skchaves, a.pkchaves, a.codibges, a.tipos, ] +;
	[a.cpros, c.dpros From SigCdRsi a ] + ;
	[left Join SigCdRst b On a.skChaves = b.skchaves ] +  ;
	[left join sigcdpro c on c.cpros = a.cpros Where a.skchaves = '] + lcSK + [' and a.tipos='P']
=Thisform.PodataMgr.SqlExecute(lcSql,'TmpVen')
Select TmpVen
	Select crProd
Select crProd
Select crSigCdRst
	Select crProd
Set Delete Off
	Select crSigcdRsi
	Select crMuni
			Select crSigcdRsi
			If Deleted('crMuni')
				Delete
		Select crMuni
	Select crProd
			Select crSigcdRsi
			If Deleted('crProd')
				Delete
		Select crProd
Set Delete On
Select crMuni
Select crMuni
SELECT crMuni
Delete
Select uf, munici from crMuni into cursor Duplica group by uf, munici  having sum(1) > 1 
Select Duplica
	Select crMuni
Select crMuni
	lcQuery = 	[Select b.estados, a.descs as munici, a.codigos as codibges, b.UFIBGEs From SigCdMun a, SigcdUfs b where b.estados = '] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crlocal
		If Not Seek(Padr(This.Value, 40), [crLocal], [munici])
Select crProd
Select crProd
SELECT crProd
Delete
lcQuery = [Select a.FigJpgs From SigCdPro a ] +;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmpPro]) < 1)
Select cpros from crProd into cursor Duplica group by cpros  having sum(1) > 1 
Select Duplica
	Select crProd
Select crProd
lcSql = [Select a.cpros,a.dpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
		Delete File (lcArquivo)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS SQL (1996 linhas total):

*-- Linhas 345 a 363:
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 483
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16
351:             .ScrollBars         = 2
352:             .GridLines          = 3
353:             .FontName           = "Verdana"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .GridLineColor      = RGB(238, 238, 238)
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .Visible            = .T.
362:         ENDWITH
363: 

*-- Linhas 643 a 673:
643: 
644:         *-- ===================================================================
645:         *-- Cursores placeholder para configuracao inicial dos grids
646:         *-- (estrutura identica aos criados pelos metodos BuscarMunicipios/BuscarProdutos do BO)
647:         *-- ===================================================================
648:         IF !USED("cursor_4c_Munis")
649:             SET NULL ON
650:             CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
651:                 tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
652:             SET NULL OFF
653:             APPEND BLANK
654:         ENDIF
655: 
656:         IF !USED("cursor_4c_Prods")
657:             SET NULL ON
658:             CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
659:                 dpros C(40), tipos C(1))
660:             SET NULL OFF
661:             APPEND BLANK
662:         ENDIF
663: 
664:         *-- ===================================================================
665:         *-- cmd_4c_InserirMuni - Inserir linha no GradMuni (inserir do legado)
666:         *-- Top=305+29=334, Left=356, Width=45, Height=45
667:         *-- ===================================================================
668:         loc_oPagina.AddObject("cmd_4c_InserirMuni", "CommandButton")
669:         WITH loc_oPagina.cmd_4c_InserirMuni
670:             .Caption         = ""
671:             .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
672:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
673:             .PicturePosition = 0

*-- Linhas 714 a 766:
714:         *-- Top=133+29=162, Left=41, Width=309, Height=456
715:         *-- Col1=UF(24), Col2=Municipio(263)
716:         *-- ===================================================================
717:         loc_oPagina.AddObject("grd_4c_Munis", "Grid")
718:         loc_oPagina.grd_4c_Munis.ColumnCount = 3
719:         loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
720:         loc_oPagina.grd_4c_Munis.ColumnCount  = 2
721: 
722:         WITH loc_oPagina.grd_4c_Munis
723:             .Top                = 162
724:             .Left               = 41
725:             .Width              = 309
726:             .Height             = 456
727:             .DeleteMark         = .F.
728:             .RecordMark         = .F.
729:             .RowHeight          = 16
730:             .ScrollBars         = 2
731:             .GridLines          = 3
732:             .GridLineColor      = RGB(238, 238, 238)
733:             .HeaderHeight       = 20
734:             .FontName           = "Tahoma"
735:             .FontSize           = 8
736:             .ForeColor          = RGB(0, 0, 0)
737:             .BackColor          = RGB(255, 255, 255)
738:             .HighlightBackColor = RGB(255, 255, 255)
739:             .HighlightForeColor = RGB(15, 41, 104)
740:             .HighlightStyle     = 2
741:             .Visible            = .T.
742: 
743:             .Column1.ControlSource     = "cursor_4c_Munis.uf"
744:             .Column1.Width             = 24
745:             .Column1.FontName          = "Tahoma"
746:             .Column1.FontSize          = 8
747:             .Column1.Resizable         = .T.
748:             .Column1.Header1.Caption   = "UF"
749:             .Column1.Header1.Alignment = 2
750: 
751:             .Column2.ControlSource     = "cursor_4c_Munis.munici"
752:             .Column2.Width             = 263
753:             .Column2.FontName          = "Tahoma"
754:             .Column2.FontSize          = 8
755:             .Column2.Resizable         = .T.
756:             .Column2.Header1.Caption   = "Munic" + CHR(237) + "pio"
757:             .Column2.Header1.Alignment = 2
758:         ENDWITH
759: 
760:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
761:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")
762: 
763:         *-- ===================================================================
764:         *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
765:         *-- Top=305+29=334, Left=912, Width=45, Height=45
766:         *-- ===================================================================

*-- Linhas 823 a 865:
823:             .Left               = 417
824:             .Width              = 490
825:             .Height             = 456
826:             .DeleteMark         = .F.
827:             .RecordMark         = .F.
828:             .RowHeight          = 16
829:             .ScrollBars         = 2
830:             .GridLines          = 3
831:             .GridLineColor      = RGB(238, 238, 238)
832:             .HeaderHeight       = 20
833:             .FontName           = "Tahoma"
834:             .FontSize           = 8
835:             .ForeColor          = RGB(0, 0, 0)
836:             .BackColor          = RGB(255, 255, 255)
837:             .HighlightBackColor = RGB(255, 255, 255)
838:             .HighlightForeColor = RGB(15, 41, 104)
839:             .HighlightStyle     = 2
840:             .Visible            = .T.
841: 
842:             .Column1.ControlSource     = "cursor_4c_Prods.cpros"
843:             .Column1.Width             = 108
844:             .Column1.FontName          = "Tahoma"
845:             .Column1.FontSize          = 8
846:             .Column1.Resizable         = .T.
847:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
848:             .Column1.Header1.Alignment = 2
849: 
850:             .Column2.ControlSource     = "cursor_4c_Prods.dpros"
851:             .Column2.Width             = 360
852:             .Column2.FontName          = "Tahoma"
853:             .Column2.FontSize          = 8
854:             .Column2.Resizable         = .T.
855:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
856:             .Column2.Header1.Alignment = 2
857:         ENDWITH
858: 
859:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
860:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
861:         BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")
862: 
863:         *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
864:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
865:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

*-- Linhas 872 a 920:
872: 
873:     *===========================================================================
874:     * CarregarLista - Carrega dados no grid da Page1 via BO
875:     * Vincula RecordSource, ControlSource e Header1.Caption apos Buscar()
876:     *===========================================================================
877:     PROCEDURE CarregarLista()
878:         LOCAL loc_lResultado, loc_oGrid
879:         loc_lResultado = .F.
880: 
881:         TRY
882:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
883:                 loc_lResultado = .T.
884:             ELSE
885:                 IF !THIS.this_oBusinessObject.Buscar("")
886:                     loc_lResultado = .F.
887:                 ELSE
888:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
889: 
890:                     loc_oGrid.ColumnCount = 3
891:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
892:                     loc_oGrid.ColumnCount  = 3
893: 
894:                     *-- Reconfigurar ControlSource e Headers apos RecordSource
895:                     *-- (RecordSource reseta essas propriedades - Problema #2 FORMCOR_LICOES)
896:                     WITH loc_oGrid
897:                         .Column1.ControlSource   = "cursor_4c_Dados.iclis"
898:                         .Column1.Width           = 100
899:                         .Column1.Header1.Caption = "Conta"
900: 
901:                         .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
902:                         .Column2.Width           = 450
903:                         .Column2.Header1.Caption = "Nome da Conta"
904: 
905:                         .Column3.ControlSource   = "cursor_4c_Dados.datas"
906:                         .Column3.Width           = 80
907:                         .Column3.Header1.Caption = "Data"
908:                     ENDWITH
909: 
910:                     THIS.FormatarGridLista(loc_oGrid)
911: 
912:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
913:                         GO TOP IN cursor_4c_Dados
914:                     ENDIF
915: 
916:                     loc_lResultado = .T.
917:                 ENDIF
918:             ENDIF
919:         CATCH TO loException
920:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;

*-- Linhas 974 a 1033:
974:             MsgAviso("Selecione um registro na lista.", "Aviso")
975:             RETURN
976:         ENDIF
977:         SELECT cursor_4c_Dados
978:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
979:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
980:             THIS.this_cModoAtual = "VISUALIZAR"
981:             THIS.BOParaForm()
982:             THIS.CarregarGrades(loc_cSkChaves)
983:             THIS.HabilitarCampos(.F.)
984:             THIS.AlternarPagina(2)
985:         ENDIF
986:     ENDPROC
987: 
988:     *===========================================================================
989:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
990:     *===========================================================================
991:     PROCEDURE BtnAlterarClick()
992:         LOCAL loc_cSkChaves
993:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
994:             MsgAviso("Selecione um registro na lista.", "Aviso")
995:             RETURN
996:         ENDIF
997:         SELECT cursor_4c_Dados
998:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
999:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1000:             THIS.this_oBusinessObject.EditarRegistro()
1001:             THIS.this_cModoAtual = "ALTERAR"
1002:             THIS.BOParaForm()
1003:             THIS.CarregarGrades(loc_cSkChaves)
1004:             THIS.HabilitarCampos(.T.)
1005:             THIS.AlternarPagina(2)
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *===========================================================================
1010:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1011:     *===========================================================================
1012:     PROCEDURE BtnExcluirClick()
1013:         LOCAL loc_cSkChaves, loc_cIclis
1014:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1015:             MsgAviso("Selecione um registro na lista.", "Aviso")
1016:             RETURN
1017:         ENDIF
1018:         SELECT cursor_4c_Dados
1019:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
1020:         loc_cIclis    = ALLTRIM(cursor_4c_Dados.iclis)
1021:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da exclusividade" + CHR(13) + ;
1022:                 "da conta: " + loc_cIclis + " ?", "Excluir")
1023:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1024:                 IF THIS.this_oBusinessObject.Excluir()
1025:                     MsgInfo("Exclusividade exclu" + CHR(237) + "da com sucesso!")
1026:                     THIS.CarregarLista()
1027:                 ENDIF
1028:             ENDIF
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     *===========================================================================
1033:     * BtnBuscarClick - Recarrega a lista completa (reset de filtro)

*-- Linhas 1048 a 1069:
1048:     *===========================================================================
1049:     PROCEDURE Destroy()
1050:         IF USED("cursor_4c_Dados")
1051:             USE IN cursor_4c_Dados
1052:         ENDIF
1053:         IF USED("cursor_4c_Munis")
1054:             USE IN cursor_4c_Munis
1055:         ENDIF
1056:         IF USED("cursor_4c_Prods")
1057:             USE IN cursor_4c_Prods
1058:         ENDIF
1059:         THIS.this_oBusinessObject = .NULL.
1060:         DODEFAULT()
1061:     ENDPROC
1062: 
1063:     *===========================================================================
1064:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1065:     * Percorre Pages de PageFrames e controles de Containers recursivamente
1066:     *===========================================================================
1067:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1068:         LOCAL loc_nI, loc_oObjeto, loc_nP
1069: 

*-- Linhas 1133 a 1153:
1133:             ENDIF
1134:         CATCH TO loException
1135:             *-- fAcessoContas indisponivel: busca direta em SigCdCli
1136:             loc_nResult = SQLEXEC(gnConnHandle, ;
1137:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1138:                 " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
1139:                 "cursor_4c_BuscaCli")
1140:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1141:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1142:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1143:             ELSE
1144:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1145:                 loc_oPg2.txt_4c_Codigo.Value = ""
1146:                 loc_oPg2.txt_4c_Desc.Value   = ""
1147:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1148:             ENDIF
1149:             IF USED("cursor_4c_BuscaCli")
1150:                 USE IN cursor_4c_BuscaCli
1151:             ENDIF
1152:         ENDTRY
1153:     ENDPROC

*-- Linhas 1179 a 1199:
1179:             ENDIF
1180:         CATCH TO loException
1181:             *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
1182:             loc_nResult = SQLEXEC(gnConnHandle, ;
1183:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1184:                 " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
1185:                 "cursor_4c_BuscaCli")
1186:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1187:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1188:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1189:             ELSE
1190:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1191:                 loc_oPg2.txt_4c_Desc.Value   = ""
1192:                 loc_oPg2.txt_4c_Codigo.Value = ""
1193:                 loc_oPg2.txt_4c_Desc.SetFocus()
1194:             ENDIF
1195:             IF USED("cursor_4c_BuscaCli")
1196:                 USE IN cursor_4c_BuscaCli
1197:             ENDIF
1198:         ENDTRY
1199:     ENDPROC

*-- Linhas 1211 a 1241:
1211:             RETURN
1212:         ENDIF
1213: 
1214:         SELECT cursor_4c_Prods
1215:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1216:         IF EMPTY(loc_cCodPro)
1217:             RETURN
1218:         ENDIF
1219: 
1220:         TRY
1221:             loc_nResult = SQLEXEC(gnConnHandle, ;
1222:                 "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
1223:                 " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1224:                 "cursor_4c_ImgPro")
1225:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
1226:                 SELECT cursor_4c_ImgPro
1227:                 IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
1228:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1229:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
1230:                         "data:image/png;base64,", ""), ;
1231:                         "data:image/jpeg;base64,", ""), ;
1232:                         "data:image/jpg;base64,", ""), 14)
1233:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1234:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1235:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1236:                 ENDIF
1237:             ENDIF
1238:             IF USED("cursor_4c_ImgPro")
1239:                 USE IN cursor_4c_ImgPro
1240:             ENDIF
1241:         CATCH TO loException

*-- Linhas 1267 a 1288:
1267:                 *-- Contar produtos com cpros valido
1268:                 loc_nQtdProd = 0
1269:                 IF USED("cursor_4c_Prods")
1270:                     SELECT cursor_4c_Prods
1271:                     loc_nRec = RECNO()
1272:                     GO TOP
1273:                     SCAN FOR !DELETED()
1274:                         IF !EMPTY(ALLTRIM(cpros))
1275:                             loc_nQtdProd = loc_nQtdProd + 1
1276:                         ENDIF
1277:                     ENDSCAN
1278:                     IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1279:                         GO (loc_nRec) IN cursor_4c_Prods
1280:                     ENDIF
1281:                 ENDIF
1282:                 IF loc_nQtdProd = 0
1283:                     MsgAviso("Informe ao menos um produto.", "Aviso")
1284:                 ELSE
1285:                     IF THIS.this_cModoAtual = "INCLUIR"
1286:                         IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
1287:                             MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
1288:                             loc_oPg2.txt_4c_Codigo.SetFocus()

*-- Linhas 1378 a 1533:
1378:     *===========================================================================
1379:     * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
1380:     * Usado em modo INCLUIR para permitir digitacao imediata nas grades
1381:     *===========================================================================
1382:     PROTECTED PROCEDURE InicializarGradesVazias()
1383:         IF USED("cursor_4c_Munis")
1384:             USE IN cursor_4c_Munis
1385:         ENDIF
1386:         SET NULL ON
1387:         CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
1388:             tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
1389:         SET NULL OFF
1390:         APPEND BLANK IN cursor_4c_Munis
1391:         GO TOP IN cursor_4c_Munis
1392: 
1393:         IF USED("cursor_4c_Prods")
1394:             USE IN cursor_4c_Prods
1395:         ENDIF
1396:         SET NULL ON
1397:         CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
1398:             dpros C(40), tipos C(1))
1399:         SET NULL OFF
1400:         APPEND BLANK IN cursor_4c_Prods
1401:         GO TOP IN cursor_4c_Prods
1402: 
1403:         THIS.RefreshGridMunis()
1404:         THIS.RefreshGridProds()
1405:     ENDPROC
1406: 
1407:     *===========================================================================
1408:     * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
1409:     * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
1410:     *===========================================================================
1411:     PROTECTED PROCEDURE RefreshGridMunis()
1412:         LOCAL loc_oGrid
1413:         TRY
1414:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
1415:             loc_oGrid.ColumnCount = 3
1416:             loc_oGrid.RecordSource = "cursor_4c_Munis"
1417:             loc_oGrid.ColumnCount  = 2
1418:             WITH loc_oGrid
1419:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1420:                 .Column1.Width           = 24
1421:                 .Column1.Header1.Caption = "UF"
1422:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1423:                 .Column2.Width           = 263
1424:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1425:             ENDWITH
1426:             loc_oGrid.Refresh()
1427:         CATCH TO loException
1428:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1429:                 loException.Message, "Formrst.RefreshGridMunis")
1430:         ENDTRY
1431:     ENDPROC
1432: 
1433:     *===========================================================================
1434:     * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
1435:     * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
1436:     *===========================================================================
1437:     PROTECTED PROCEDURE RefreshGridProds()
1438:         LOCAL loc_oGrid
1439:         TRY
1440:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
1441:             loc_oGrid.ColumnCount = 3
1442:             loc_oGrid.RecordSource = "cursor_4c_Prods"
1443:             loc_oGrid.ColumnCount  = 2
1444:             WITH loc_oGrid
1445:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1446:                 .Column1.Width           = 108
1447:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1448:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1449:                 .Column2.Width           = 360
1450:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1451:             ENDWITH
1452:             loc_oGrid.Refresh()
1453:         CATCH TO loException
1454:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1455:                 "Formrst.RefreshGridProds")
1456:         ENDTRY
1457:     ENDPROC
1458: 
1459:     *===========================================================================
1460:     * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
1461:     * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
1462:     *===========================================================================
1463:     PROCEDURE GradMuniUFLostFocus()
1464:         LOCAL loc_cUF, loc_nResult, loc_oBusca
1465: 
1466:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1467:             RETURN
1468:         ENDIF
1469: 
1470:         SELECT cursor_4c_Munis
1471:         loc_cUF = ALLTRIM(cursor_4c_Munis.uf)
1472: 
1473:         IF EMPTY(loc_cUF)
1474:             RETURN
1475:         ENDIF
1476: 
1477:         TRY
1478:             loc_nResult = SQLEXEC(gnConnHandle, ;
1479:                 "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1480:                 " WHERE estados = " + EscaparSQL(loc_cUF), ;
1481:                 "cursor_4c_BuscaUf")
1482:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
1483:                 SELECT cursor_4c_Munis
1484:                 REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
1485:                         UFIBGEs WITH cursor_4c_BuscaUf.ufibges
1486:             ELSE
1487:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1488:                     "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
1489:                     " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
1490:                     " ORDER BY estados", ;
1491:                     "cursor_4c_BuscaUfs")
1492:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
1493:                     IF USED("cursor_4c_BuscaUfs")
1494:                         USE IN cursor_4c_BuscaUfs
1495:                     ENDIF
1496:                     SQLEXEC(gnConnHandle, ;
1497:                         "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
1498:                         "cursor_4c_BuscaUfs")
1499:                 ENDIF
1500:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1501:                 IF VARTYPE(loc_oBusca) = "O"
1502:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
1503:                     loc_oBusca.Mostrar()
1504:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1505:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1506:                             "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1507:                             " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1508:                             "cursor_4c_UfSel")
1509:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
1510:                             SELECT cursor_4c_Munis
1511:                             REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
1512:                                     UFIBGEs WITH cursor_4c_UfSel.ufibges
1513:                         ENDIF
1514:                         IF USED("cursor_4c_UfSel")
1515:                             USE IN cursor_4c_UfSel
1516:                         ENDIF
1517:                     ELSE
1518:                         SELECT cursor_4c_Munis
1519:                         REPLACE uf WITH "", UFIBGEs WITH 0
1520:                     ENDIF
1521:                     IF USED("cursor_4c_BuscaUfs")
1522:                         USE IN cursor_4c_BuscaUfs
1523:                     ENDIF
1524:                 ENDIF
1525:             ENDIF
1526:             IF USED("cursor_4c_BuscaUf")
1527:                 USE IN cursor_4c_BuscaUf
1528:             ENDIF
1529:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1530:         CATCH TO loException
1531:             MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
1532:                 "Formrst.GradMuniUFLostFocus")
1533:             IF USED("cursor_4c_BuscaUf")

*-- Linhas 1544 a 1654:
1544:     * Verifica duplicidade + busca em SigCdMun; se nao encontrado abre picker
1545:     *===========================================================================
1546:     PROCEDURE GradMuniMunLostFocus()
1547:         LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1548: 
1549:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1550:             RETURN
1551:         ENDIF
1552: 
1553:         SELECT cursor_4c_Munis
1554:         loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
1555:         loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)
1556: 
1557:         IF EMPTY(loc_cMunici)
1558:             RETURN
1559:         ENDIF
1560: 
1561:         TRY
1562:             *-- Verificar duplicidade: mesmo uf + munici em outra linha
1563:             SELECT cursor_4c_Munis
1564:             loc_nRec = RECNO()
1565:             GO TOP
1566:             loc_nContagem = 0
1567:             SCAN FOR !DELETED()
1568:                 IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
1569:                     loc_nContagem = loc_nContagem + 1
1570:                 ENDIF
1571:             ENDSCAN
1572:             IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
1573:                 GO (loc_nRec) IN cursor_4c_Munis
1574:             ENDIF
1575: 
1576:             IF loc_nContagem > 1
1577:                 MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
1578:                     " adicionado para este estado.", "Aviso")
1579:                 SELECT cursor_4c_Munis
1580:                 REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1581:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1582:             ELSE
1583:                 *-- Busca exata em SigCdMun pelo nome do municipio
1584:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1585:                     "SELECT TOP 1 a.codigos, a.descs," + ;
1586:                     " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1587:                     " FROM SigCdMun a" + ;
1588:                     " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1589:                     " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
1590:                     "cursor_4c_BuscaMun")
1591:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
1592:                     SELECT cursor_4c_Munis
1593:                     REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
1594:                             munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
1595:                             uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
1596:                             UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
1597:                 ELSE
1598:                     *-- Abrir picker de municipios
1599:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1600:                         "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1601:                         " FROM SigCdMun a" + ;
1602:                         " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
1603:                         " ORDER BY a.descs", ;
1604:                         "cursor_4c_BuscaMuns")
1605:                     IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
1606:                         IF USED("cursor_4c_BuscaMuns")
1607:                             USE IN cursor_4c_BuscaMuns
1608:                         ENDIF
1609:                         SQLEXEC(gnConnHandle, ;
1610:                             "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1611:                             " FROM SigCdMun a ORDER BY a.descs", ;
1612:                             "cursor_4c_BuscaMuns")
1613:                     ENDIF
1614:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1615:                     IF VARTYPE(loc_oBusca) = "O"
1616:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
1617:                             "Munic" + CHR(237) + "pio")
1618:                         loc_oBusca.Mostrar()
1619:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1620:                             loc_nResult = SQLEXEC(gnConnHandle, ;
1621:                                 "SELECT TOP 1 a.codigos, a.descs," + ;
1622:                                 " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1623:                                 " FROM SigCdMun a" + ;
1624:                                 " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1625:                                 " WHERE a.codigos = " + ;
1626:                                 EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1627:                                 "cursor_4c_MunSel")
1628:                             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
1629:                                 SELECT cursor_4c_Munis
1630:                                 REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
1631:                                         munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
1632:                                         uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
1633:                                         UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
1634:                             ENDIF
1635:                             IF USED("cursor_4c_MunSel")
1636:                                 USE IN cursor_4c_MunSel
1637:                             ENDIF
1638:                         ELSE
1639:                             SELECT cursor_4c_Munis
1640:                             REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1641:                         ENDIF
1642:                         IF USED("cursor_4c_BuscaMuns")
1643:                             USE IN cursor_4c_BuscaMuns
1644:                         ENDIF
1645:                     ENDIF
1646:                 ENDIF
1647:                 IF USED("cursor_4c_BuscaMun")
1648:                     USE IN cursor_4c_BuscaMun
1649:                 ENDIF
1650:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1651:             ENDIF
1652:         CATCH TO loException
1653:             MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1654:                 "Formrst.GradMuniMunLostFocus")

*-- Linhas 1672 a 1740:
1672:             RETURN
1673:         ENDIF
1674: 
1675:         SELECT cursor_4c_Prods
1676:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1677: 
1678:         IF EMPTY(loc_cCpros)
1679:             RETURN
1680:         ENDIF
1681: 
1682:         TRY
1683:             loc_nResult = SQLEXEC(gnConnHandle, ;
1684:                 "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1685:                 " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
1686:                 "cursor_4c_BuscaPro")
1687:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
1688:                 SELECT cursor_4c_Prods
1689:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
1690:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
1691:             ELSE
1692:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1693:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1694:                     " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
1695:                     " ORDER BY a.cpros", ;
1696:                     "cursor_4c_BuscaPros")
1697:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
1698:                     IF USED("cursor_4c_BuscaPros")
1699:                         USE IN cursor_4c_BuscaPros
1700:                     ENDIF
1701:                     SQLEXEC(gnConnHandle, ;
1702:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1703:                         " ORDER BY a.cpros", ;
1704:                         "cursor_4c_BuscaPros")
1705:                 ENDIF
1706:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1707:                 IF VARTYPE(loc_oBusca) = "O"
1708:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
1709:                         CHR(67) + CHR(243) + "digo do Produto")
1710:                     loc_oBusca.Mostrar()
1711:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1712:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1713:                             "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1714:                             " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1715:                             "cursor_4c_ProSel")
1716:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
1717:                             SELECT cursor_4c_Prods
1718:                             REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
1719:                                     dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
1720:                         ENDIF
1721:                         IF USED("cursor_4c_ProSel")
1722:                             USE IN cursor_4c_ProSel
1723:                         ENDIF
1724:                     ELSE
1725:                         SELECT cursor_4c_Prods
1726:                         REPLACE cpros WITH "", dpros WITH ""
1727:                     ENDIF
1728:                     IF USED("cursor_4c_BuscaPros")
1729:                         USE IN cursor_4c_BuscaPros
1730:                     ENDIF
1731:                 ENDIF
1732:             ENDIF
1733:             IF USED("cursor_4c_BuscaPro")
1734:                 USE IN cursor_4c_BuscaPro
1735:             ENDIF
1736:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1737:         CATCH TO loException
1738:             MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
1739:                 "Formrst.GradProdCodLostFocus")
1740:             IF USED("cursor_4c_BuscaPro")

*-- Linhas 1757 a 1830:
1757:             RETURN
1758:         ENDIF
1759: 
1760:         SELECT cursor_4c_Prods
1761:         loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
1762:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1763: 
1764:         IF EMPTY(loc_cDpros)
1765:             RETURN
1766:         ENDIF
1767: 
1768:         TRY
1769:             IF !EMPTY(loc_cCpros)
1770:                 *-- Verificar duplicidade: mesmo cpros em outra linha
1771:                 SELECT cursor_4c_Prods
1772:                 loc_nRec = RECNO()
1773:                 GO TOP
1774:                 loc_nContagem = 0
1775:                 SCAN FOR !DELETED()
1776:                     IF ALLTRIM(cpros) = loc_cCpros
1777:                         loc_nContagem = loc_nContagem + 1
1778:                     ENDIF
1779:                 ENDSCAN
1780:                 IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1781:                     GO (loc_nRec) IN cursor_4c_Prods
1782:                 ENDIF
1783:                 IF loc_nContagem > 1
1784:                     MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
1785:                     SELECT cursor_4c_Prods
1786:                     REPLACE cpros WITH "", dpros WITH ""
1787:                 ENDIF
1788:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1789:             ELSE
1790:                 *-- cpros vazio: buscar produto por descricao digitada
1791:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1792:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1793:                     " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
1794:                     " ORDER BY a.dpros", ;
1795:                     "cursor_4c_BuscaDpros")
1796:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
1797:                     IF USED("cursor_4c_BuscaDpros")
1798:                         USE IN cursor_4c_BuscaDpros
1799:                     ENDIF
1800:                     SQLEXEC(gnConnHandle, ;
1801:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1802:                         " ORDER BY a.dpros", ;
1803:                         "cursor_4c_BuscaDpros")
1804:                 ENDIF
1805:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1806:                 IF VARTYPE(loc_oBusca) = "O"
1807:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
1808:                         "Descri" + CHR(231) + CHR(227) + "o do Produto")
1809:                     loc_oBusca.Mostrar()
1810:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1811:                         SELECT cursor_4c_Prods
1812:                         REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
1813:                                 dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1814:                     ELSE
1815:                         SELECT cursor_4c_Prods
1816:                         REPLACE cpros WITH "", dpros WITH ""
1817:                     ENDIF
1818:                     IF USED("cursor_4c_BuscaDpros")
1819:                         USE IN cursor_4c_BuscaDpros
1820:                     ENDIF
1821:                 ENDIF
1822:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1823:             ENDIF
1824:         CATCH TO loException
1825:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1826:                 loException.Message, "Formrst.GradProdDescLostFocus")
1827:             IF USED("cursor_4c_BuscaDpros")
1828:                 USE IN cursor_4c_BuscaDpros
1829:             ENDIF
1830:         ENDTRY

*-- Linhas 1843 a 1875:
1843:             RETURN
1844:         ENDIF
1845: 
1846:         SELECT cursor_4c_Prods
1847:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1848: 
1849:         IF EMPTY(loc_cCodPro)
1850:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1851:             RETURN
1852:         ENDIF
1853: 
1854:         TRY
1855:             loc_lTemImagem = .F.
1856:             loc_nResult = SQLEXEC(gnConnHandle, ;
1857:                 "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1858:                 "cursor_4c_ImgArc")
1859:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
1860:                 SELECT cursor_4c_ImgArc
1861:                 IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
1862:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1863:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
1864:                         "data:image/png;base64,", ""), ;
1865:                         "data:image/jpeg;base64,", ""), ;
1866:                         "data:image/jpg;base64,", ""), 14)
1867:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1868:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1869:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1870:                     loc_lTemImagem = .T.
1871:                 ENDIF
1872:             ENDIF
1873:             IF USED("cursor_4c_ImgArc")
1874:                 USE IN cursor_4c_ImgArc
1875:             ENDIF

*-- Linhas 1889 a 1978:
1889:     *===========================================================================
1890:     * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
1891:     *===========================================================================
1892:     PROCEDURE BtnInserirMuniClick()
1893:         TRY
1894:             IF !USED("cursor_4c_Munis")
1895:                 THIS.InicializarGradesVazias()
1896:             ELSE
1897:                 SELECT cursor_4c_Munis
1898:                 APPEND BLANK
1899:                 REPLACE tipos    WITH "M", ;
1900:                         pkchaves WITH "", ;
1901:                         munici   WITH "", ;
1902:                         codibges WITH "", ;
1903:                         uf       WITH "", ;
1904:                         UFIBGEs  WITH 0
1905:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1906:             ENDIF
1907:         CATCH TO loException
1908:             MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1909:                 "Formrst.BtnInserirMuniClick")
1910:         ENDTRY
1911:     ENDPROC
1912: 
1913:     *===========================================================================
1914:     * BtnExcluirMuniClick - Remove municipio selecionado da grade
1915:     *===========================================================================
1916:     PROCEDURE BtnExcluirMuniClick()
1917:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1918:             MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
1919:             RETURN
1920:         ENDIF
1921:         TRY
1922:             SELECT cursor_4c_Munis
1923:             DELETE
1924:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1925:         CATCH TO loException
1926:             MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1927:                 "Formrst.BtnExcluirMuniClick")
1928:         ENDTRY
1929:     ENDPROC
1930: 
1931:     *===========================================================================
1932:     * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
1933:     *===========================================================================
1934:     PROCEDURE BtnInserirProdClick()
1935:         TRY
1936:             IF !USED("cursor_4c_Prods")
1937:                 THIS.InicializarGradesVazias()
1938:             ELSE
1939:                 SELECT cursor_4c_Prods
1940:                 APPEND BLANK
1941:                 REPLACE tipos    WITH "P", ;
1942:                         pkchaves WITH "", ;
1943:                         cpros    WITH "", ;
1944:                         dpros    WITH ""
1945:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1946:             ENDIF
1947:         CATCH TO loException
1948:             MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
1949:                 "Formrst.BtnInserirProdClick")
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953:     *===========================================================================
1954:     * BtnExcluirProdClick - Remove produto selecionado da grade
1955:     *===========================================================================
1956:     PROCEDURE BtnExcluirProdClick()
1957:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1958:             MsgAviso("Selecione um produto para excluir.", "Aviso")
1959:             RETURN
1960:         ENDIF
1961:         TRY
1962:             SELECT cursor_4c_Prods
1963:             DELETE
1964:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1965:         CATCH TO loException
1966:             MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
1967:                 "Formrst.BtnExcluirProdClick")
1968:         ENDTRY
1969:     ENDPROC
1970: 
1971:     *===========================================================================
1972:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
1973:     * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
1974:     *===========================================================================
1975:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1976:         LOCAL loc_oPg2, loc_lEditando
1977:         TRY
1978:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2


### BO (C:\4c\projeto\app\classes\rstBO.prg):
*==============================================================================
* rstBO.prg - Business Object para Exclusividade Por Contas (SigCdRst/SigCdRsi)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS rstBO AS BusinessBase

    *-- SigCdRst - Propriedades principais
    this_cSkChaves  = ""    && skchaves  C(20) PK
    this_cIclis     = ""    && iclis     C(10) FK SigCdCli
    this_nChkMatrs  = 0     && chkmatrs  N(1,0) Checa Matriz (op_con)
    this_dDatas     = {}    && datas     D nullable
    this_dDtAlts    = {}    && dtalts    D nullable (auditoria)

    *-- Propriedade derivada (JOIN SigCdCli) - somente exibicao
    this_cRclis     = ""    && Rclis C(40) nome do cliente

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRst"
            THIS.this_cCampoChave = "skChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de exclusividades com nome do cliente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " ORDER BY b.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar exclusividades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (skchaves C(20), iclis C(10), Rclis C(40), ;
                    chkmatrs N(1,0), datas T, dtalts T)
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro SigCdRst por skChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSkChaves = TratarNulo(skchaves, "C")
            THIS.this_cIclis    = TratarNulo(iclis,    "C")
            THIS.this_cRclis    = TratarNulo(Rclis,    "C")
            THIS.this_nChkMatrs = TratarNulo(chkmatrs, "N")
            THIS.this_dDatas    = TratarNulo(datas,    "D")
            THIS.this_dDtAlts   = TratarNulo(dtalts,   "D")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMunicipios - Carrega SigCdRsi tipo 'M' para o skChaves dado
    * Popula cursor_4c_Munis com: skchaves, pkchaves, codibges, tipos, UFIBGEs, munici, uf
    *--------------------------------------------------------------------------
    FUNCTION BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Munis")
                USE IN cursor_4c_Munis
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.codibges, a.tipos," + ;
                           " a.ufibges AS UFIBGEs," + ;
                           " ISNULL(c.descs,'') AS munici, ISNULL(d.estados,'') AS uf" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdMun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN SigCdUfs d ON d.ufibges = a.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'M'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MunisTmp")
                    TABLEREVERT(.T., "cursor_4c_MunisTmp")
                    USE IN cursor_4c_MunisTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MunisTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_MunisTmp
                    SCAN
                        SELECT cursor_4c_Munis
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.pkchaves, "")), ;
                                codibges WITH ALLTRIM(NVL(cursor_4c_MunisTmp.codibges, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_MunisTmp.tipos, "")), ;
                                UFIBGEs  WITH NVL(cursor_4c_MunisTmp.UFIBGEs, 0), ;
                                munici   WITH ALLTRIM(NVL(cursor_4c_MunisTmp.munici, "")), ;
                                uf       WITH ALLTRIM(NVL(cursor_4c_MunisTmp.uf, ""))
                        SELECT cursor_4c_MunisTmp
                    ENDSCAN
                    IF USED("cursor_4c_MunisTmp")
                        USE IN cursor_4c_MunisTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Munis
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Munis
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar munic" + CHR(237) + "pios:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_MunisTmp")
                USE IN cursor_4c_MunisTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Carrega SigCdRsi tipo 'P' para o skChaves dado
    * Popula cursor_4c_Prods com: skchaves, pkchaves, cpros, dpros, tipos
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutos(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Prods")
                USE IN cursor_4c_Prods
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.cpros," + ;
                           " ISNULL(c.dpros,'') AS dpros, a.tipos" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdPro c ON c.cpros = a.cpros" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'P'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ProdsTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdsTmp")
                    USE IN cursor_4c_ProdsTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdsTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_ProdsTmp
                    SCAN
                        SELECT cursor_4c_Prods
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.pkchaves, "")), ;
                                cpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.cpros, "")), ;
                                dpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.dpros, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.tipos, ""))
                        SELECT cursor_4c_ProdsTmp
                    ENDSCAN
                    IF USED("cursor_4c_ProdsTmp")
                        USE IN cursor_4c_ProdsTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Prods
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Prods
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProdsTmp")
                USE IN cursor_4c_ProdsTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaCadastrada - Checa se Iclis ja tem exclusividade em SigCdRst
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaCadastrada(par_cIclis)
        LOCAL loc_lExiste, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 skchaves FROM SigCdRst WHERE iclis = " + EscaparSQL(par_cIclis), ;
                "cursor_4c_ChkRst")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkRst") > 0
                loc_lExiste = .T.
            ENDIF
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave C(20) via NEWID do SQL Server
    *--------------------------------------------------------------------------
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS novachave", ;
                "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(novachave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirItensSigCdRsi - INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    * Metodo auxiliar compartilhado por Inserir() e Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirItensSigCdRsi()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cPkChave
        loc_lResultado = .T.

        *-- INSERT municipios (tipo 'M')
        IF USED("cursor_4c_Munis")
            SELECT cursor_4c_Munis
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Munis.codibges)) OR cursor_4c_Munis.UFIBGEs <> 0
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Munis.codibges)) + "," + ;
                                   "'M'," + ;
                                   FormatarNumeroSQL(cursor_4c_Munis.UFIBGEs) + "," + ;
                                   "''," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Munis
            ENDSCAN
        ENDIF

        *-- INSERT produtos (tipo 'P')
        IF USED("cursor_4c_Prods")
            SELECT cursor_4c_Prods
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Prods.cpros))
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "''," + ;
                                   "'P'," + ;
                                   "0," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Prods.cpros)) + "," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Prods
            ENDSCAN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRst + INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = THIS.GerarChaveUnica()
            IF EMPTY(loc_cSQL)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cSkChaves = loc_cSQL

                loc_cSQL = "INSERT INTO SigCdRst (skchaves, iclis, chkmatrs, datas, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cSkChaves) + "," + ;
                           EscaparSQL(THIS.this_cIclis) + "," + ;
                           FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           "GETDATE(), NULL)"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRst")
                    TABLEREVERT(.T., "cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRst")
                IF USED("cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRst + DELETE SigCdRsi + INSERT SigCdRsi novos itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi antigos
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi")
            IF USED("cursor_4c_DelRsi")
                USE IN cursor_4c_DelRsi
            ENDIF

            IF loc_nResult >= 0
                *-- UPDATE SigCdRst
                loc_cSQL = "UPDATE SigCdRst SET" + ;
                           " iclis = " + EscaparSQL(THIS.this_cIclis) + "," + ;
                           " chkmatrs = " + FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           " dtalts = GETDATE()" + ;
                           " WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRst")
                    TABLEREVERT(.T., "cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRst")
                IF USED("cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao limpar itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRsi e SigCdRst (nesta ordem - FK constraint)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi primeiro (filho)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi2")
            IF USED("cursor_4c_DelRsi2")
                USE IN cursor_4c_DelRsi2
            ENDIF

            IF loc_nResult >= 0
                *-- DELETE SigCdRst (pai)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdRst WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                    "cursor_4c_DelRst")
                IF USED("cursor_4c_DelRst")
                    USE IN cursor_4c_DelRst
                ENDIF

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

