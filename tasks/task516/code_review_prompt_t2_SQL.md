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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS SQL (2020 linhas total):

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
903:                         .Column2.Header1.Caption = "Nome"
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

*-- Linhas 1136 a 1156:
1136:             ENDIF
1137:         CATCH TO loException
1138:             *-- fAcessoContas indisponivel: busca direta em SigCdCli
1139:             loc_nResult = SQLEXEC(gnConnHandle, ;
1140:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1141:                 " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
1142:                 "cursor_4c_BuscaCli")
1143:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1144:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1145:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1146:             ELSE
1147:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1148:                 loc_oPg2.txt_4c_Codigo.Value = ""
1149:                 loc_oPg2.txt_4c_Desc.Value   = ""
1150:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1151:             ENDIF
1152:             IF USED("cursor_4c_BuscaCli")
1153:                 USE IN cursor_4c_BuscaCli
1154:             ENDIF
1155:         ENDTRY
1156:     ENDPROC

*-- Linhas 1183 a 1203:
1183:             ENDIF
1184:         CATCH TO loException
1185:             *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
1186:             loc_nResult = SQLEXEC(gnConnHandle, ;
1187:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1188:                 " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
1189:                 "cursor_4c_BuscaCli")
1190:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1191:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1192:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1193:             ELSE
1194:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1195:                 loc_oPg2.txt_4c_Desc.Value   = ""
1196:                 loc_oPg2.txt_4c_Codigo.Value = ""
1197:                 loc_oPg2.txt_4c_Desc.SetFocus()
1198:             ENDIF
1199:             IF USED("cursor_4c_BuscaCli")
1200:                 USE IN cursor_4c_BuscaCli
1201:             ENDIF
1202:         ENDTRY
1203:     ENDPROC

*-- Linhas 1215 a 1245:
1215:             RETURN
1216:         ENDIF
1217: 
1218:         SELECT cursor_4c_Prods
1219:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1220:         IF EMPTY(loc_cCodPro)
1221:             RETURN
1222:         ENDIF
1223: 
1224:         TRY
1225:             loc_nResult = SQLEXEC(gnConnHandle, ;
1226:                 "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
1227:                 " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1228:                 "cursor_4c_ImgPro")
1229:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
1230:                 SELECT cursor_4c_ImgPro
1231:                 IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
1232:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1233:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
1234:                         "data:image/png;base64,", ""), ;
1235:                         "data:image/jpeg;base64,", ""), ;
1236:                         "data:image/jpg;base64,", ""), 14)
1237:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1238:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1239:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1240:                 ENDIF
1241:             ENDIF
1242:             IF USED("cursor_4c_ImgPro")
1243:                 USE IN cursor_4c_ImgPro
1244:             ENDIF
1245:         CATCH TO loException

*-- Linhas 1271 a 1292:
1271:                 *-- Contar produtos com cpros valido
1272:                 loc_nQtdProd = 0
1273:                 IF USED("cursor_4c_Prods")
1274:                     SELECT cursor_4c_Prods
1275:                     loc_nRec = RECNO()
1276:                     GO TOP
1277:                     SCAN FOR !DELETED()
1278:                         IF !EMPTY(ALLTRIM(cpros))
1279:                             loc_nQtdProd = loc_nQtdProd + 1
1280:                         ENDIF
1281:                     ENDSCAN
1282:                     IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1283:                         GO (loc_nRec) IN cursor_4c_Prods
1284:                     ENDIF
1285:                 ENDIF
1286:                 IF loc_nQtdProd = 0
1287:                     MsgAviso("Informe ao menos um produto.", "Aviso")
1288:                 ELSE
1289:                     IF THIS.this_cModoAtual = "INCLUIR"
1290:                         IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
1291:                             MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
1292:                             loc_oPg2.txt_4c_Codigo.SetFocus()

*-- Linhas 1382 a 1542:
1382:     *===========================================================================
1383:     * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
1384:     * Usado em modo INCLUIR para permitir digitacao imediata nas grades
1385:     *===========================================================================
1386:     PROTECTED PROCEDURE InicializarGradesVazias()
1387:         IF USED("cursor_4c_Munis")
1388:             USE IN cursor_4c_Munis
1389:         ENDIF
1390:         SET NULL ON
1391:         CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
1392:             tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
1393:         SET NULL OFF
1394:         APPEND BLANK IN cursor_4c_Munis
1395:         GO TOP IN cursor_4c_Munis
1396: 
1397:         IF USED("cursor_4c_Prods")
1398:             USE IN cursor_4c_Prods
1399:         ENDIF
1400:         SET NULL ON
1401:         CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
1402:             dpros C(40), tipos C(1))
1403:         SET NULL OFF
1404:         APPEND BLANK IN cursor_4c_Prods
1405:         GO TOP IN cursor_4c_Prods
1406: 
1407:         THIS.RefreshGridMunis()
1408:         THIS.RefreshGridProds()
1409:     ENDPROC
1410: 
1411:     *===========================================================================
1412:     * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
1413:     * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
1414:     *===========================================================================
1415:     PROTECTED PROCEDURE RefreshGridMunis()
1416:         LOCAL loc_oGrid
1417:         TRY
1418:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
1419:             loc_oGrid.ColumnCount = 3
1420:             loc_oGrid.RecordSource = "cursor_4c_Munis"
1421:             loc_oGrid.ColumnCount  = 2
1422:             WITH loc_oGrid
1423:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1424:                 .Column1.Width           = 24
1425:                 .Column1.Header1.Caption = "UF"
1426:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1427:                 .Column2.Width           = 263
1428:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1429:             ENDWITH
1430:             loc_oGrid.Refresh()
1431:         CATCH TO loException
1432:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1433:                 loException.Message, "Formrst.RefreshGridMunis")
1434:         ENDTRY
1435:     ENDPROC
1436: 
1437:     *===========================================================================
1438:     * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
1439:     * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
1440:     *===========================================================================
1441:     PROTECTED PROCEDURE RefreshGridProds()
1442:         LOCAL loc_oGrid
1443:         TRY
1444:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
1445:             loc_oGrid.ColumnCount = 3
1446:             loc_oGrid.RecordSource = "cursor_4c_Prods"
1447:             loc_oGrid.ColumnCount  = 2
1448:             WITH loc_oGrid
1449:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1450:                 .Column1.Width           = 108
1451:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1452:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1453:                 .Column2.Width           = 360
1454:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1455:             ENDWITH
1456:             loc_oGrid.Refresh()
1457:         CATCH TO loException
1458:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1459:                 "Formrst.RefreshGridProds")
1460:         ENDTRY
1461:     ENDPROC
1462: 
1463:     *===========================================================================
1464:     * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
1465:     * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
1466:     *===========================================================================
1467:     PROCEDURE GradMuniUFLostFocus
1468:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1469:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1470:             RETURN
1471:         ENDIF
1472:         LOCAL loc_cUF, loc_nResult, loc_oBusca
1473: 
1474:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1475:             RETURN
1476:         ENDIF
1477: 
1478:         SELECT cursor_4c_Munis
1479:         loc_cUF = ALLTRIM(cursor_4c_Munis.uf)
1480: 
1481:         IF EMPTY(loc_cUF)
1482:             RETURN
1483:         ENDIF
1484: 
1485:         TRY
1486:             loc_nResult = SQLEXEC(gnConnHandle, ;
1487:                 "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1488:                 " WHERE estados = " + EscaparSQL(loc_cUF), ;
1489:                 "cursor_4c_BuscaUf")
1490:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
1491:                 SELECT cursor_4c_Munis
1492:                 REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
1493:                         UFIBGEs WITH cursor_4c_BuscaUf.ufibges
1494:             ELSE
1495:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1496:                     "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
1497:                     " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
1498:                     " ORDER BY estados", ;
1499:                     "cursor_4c_BuscaUfs")
1500:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
1501:                     IF USED("cursor_4c_BuscaUfs")
1502:                         USE IN cursor_4c_BuscaUfs
1503:                     ENDIF
1504:                     SQLEXEC(gnConnHandle, ;
1505:                         "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
1506:                         "cursor_4c_BuscaUfs")
1507:                 ENDIF
1508:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1509:                 IF VARTYPE(loc_oBusca) = "O"
1510:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUfs"
1511:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
1512:                     loc_oBusca.Mostrar()
1513:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1514:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1515:                             "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1516:                             " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1517:                             "cursor_4c_UfSel")
1518:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
1519:                             SELECT cursor_4c_Munis
1520:                             REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
1521:                                     UFIBGEs WITH cursor_4c_UfSel.ufibges
1522:                         ENDIF
1523:                         IF USED("cursor_4c_UfSel")
1524:                             USE IN cursor_4c_UfSel
1525:                         ENDIF
1526:                     ELSE
1527:                         SELECT cursor_4c_Munis
1528:                         REPLACE uf WITH "", UFIBGEs WITH 0
1529:                     ENDIF
1530:                     IF USED("cursor_4c_BuscaUfs")
1531:                         USE IN cursor_4c_BuscaUfs
1532:                     ENDIF
1533:                 ENDIF
1534:             ENDIF
1535:             IF USED("cursor_4c_BuscaUf")
1536:                 USE IN cursor_4c_BuscaUf
1537:             ENDIF
1538:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1539:         CATCH TO loException
1540:             MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
1541:                 "Formrst.GradMuniUFLostFocus")
1542:             IF USED("cursor_4c_BuscaUf")

*-- Linhas 1557 a 1668:
1557:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1558:             RETURN
1559:         ENDIF
1560:         LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1561: 
1562:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1563:             RETURN
1564:         ENDIF
1565: 
1566:         SELECT cursor_4c_Munis
1567:         loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
1568:         loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)
1569: 
1570:         IF EMPTY(loc_cMunici)
1571:             RETURN
1572:         ENDIF
1573: 
1574:         TRY
1575:             *-- Verificar duplicidade: mesmo uf + munici em outra linha
1576:             SELECT cursor_4c_Munis
1577:             loc_nRec = RECNO()
1578:             GO TOP
1579:             loc_nContagem = 0
1580:             SCAN FOR !DELETED()
1581:                 IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
1582:                     loc_nContagem = loc_nContagem + 1
1583:                 ENDIF
1584:             ENDSCAN
1585:             IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
1586:                 GO (loc_nRec) IN cursor_4c_Munis
1587:             ENDIF
1588: 
1589:             IF loc_nContagem > 1
1590:                 MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
1591:                     " adicionado para este estado.", "Aviso")
1592:                 SELECT cursor_4c_Munis
1593:                 REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1594:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1595:             ELSE
1596:                 *-- Busca exata em SigCdMun pelo nome do municipio
1597:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1598:                     "SELECT TOP 1 a.codigos, a.descs," + ;
1599:                     " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1600:                     " FROM SigCdMun a" + ;
1601:                     " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1602:                     " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
1603:                     "cursor_4c_BuscaMun")
1604:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
1605:                     SELECT cursor_4c_Munis
1606:                     REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
1607:                             munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
1608:                             uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
1609:                             UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
1610:                 ELSE
1611:                     *-- Abrir picker de municipios
1612:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1613:                         "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1614:                         " FROM SigCdMun a" + ;
1615:                         " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
1616:                         " ORDER BY a.descs", ;
1617:                         "cursor_4c_BuscaMuns")
1618:                     IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
1619:                         IF USED("cursor_4c_BuscaMuns")
1620:                             USE IN cursor_4c_BuscaMuns
1621:                         ENDIF
1622:                         SQLEXEC(gnConnHandle, ;
1623:                             "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1624:                             " FROM SigCdMun a ORDER BY a.descs", ;
1625:                             "cursor_4c_BuscaMuns")
1626:                     ENDIF
1627:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1628:                     IF VARTYPE(loc_oBusca) = "O"
1629:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMuns"
1630:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
1631:                             "Munic" + CHR(237) + "pio")
1632:                         loc_oBusca.Mostrar()
1633:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1634:                             loc_nResult = SQLEXEC(gnConnHandle, ;
1635:                                 "SELECT TOP 1 a.codigos, a.descs," + ;
1636:                                 " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1637:                                 " FROM SigCdMun a" + ;
1638:                                 " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1639:                                 " WHERE a.codigos = " + ;
1640:                                 EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1641:                                 "cursor_4c_MunSel")
1642:                             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
1643:                                 SELECT cursor_4c_Munis
1644:                                 REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
1645:                                         munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
1646:                                         uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
1647:                                         UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
1648:                             ENDIF
1649:                             IF USED("cursor_4c_MunSel")
1650:                                 USE IN cursor_4c_MunSel
1651:                             ENDIF
1652:                         ELSE
1653:                             SELECT cursor_4c_Munis
1654:                             REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1655:                         ENDIF
1656:                         IF USED("cursor_4c_BuscaMuns")
1657:                             USE IN cursor_4c_BuscaMuns
1658:                         ENDIF
1659:                     ENDIF
1660:                 ENDIF
1661:                 IF USED("cursor_4c_BuscaMun")
1662:                     USE IN cursor_4c_BuscaMun
1663:                 ENDIF
1664:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1665:             ENDIF
1666:         CATCH TO loException
1667:             MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1668:                 "Formrst.GradMuniMunLostFocus")

*-- Linhas 1690 a 1759:
1690:             RETURN
1691:         ENDIF
1692: 
1693:         SELECT cursor_4c_Prods
1694:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1695: 
1696:         IF EMPTY(loc_cCpros)
1697:             RETURN
1698:         ENDIF
1699: 
1700:         TRY
1701:             loc_nResult = SQLEXEC(gnConnHandle, ;
1702:                 "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1703:                 " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
1704:                 "cursor_4c_BuscaPro")
1705:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
1706:                 SELECT cursor_4c_Prods
1707:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
1708:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
1709:             ELSE
1710:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1711:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1712:                     " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
1713:                     " ORDER BY a.cpros", ;
1714:                     "cursor_4c_BuscaPros")
1715:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
1716:                     IF USED("cursor_4c_BuscaPros")
1717:                         USE IN cursor_4c_BuscaPros
1718:                     ENDIF
1719:                     SQLEXEC(gnConnHandle, ;
1720:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1721:                         " ORDER BY a.cpros", ;
1722:                         "cursor_4c_BuscaPros")
1723:                 ENDIF
1724:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1725:                 IF VARTYPE(loc_oBusca) = "O"
1726:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaPros"
1727:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
1728:                         CHR(67) + CHR(243) + "digo do Produto")
1729:                     loc_oBusca.Mostrar()
1730:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1731:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1732:                             "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1733:                             " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1734:                             "cursor_4c_ProSel")
1735:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
1736:                             SELECT cursor_4c_Prods
1737:                             REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
1738:                                     dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
1739:                         ENDIF
1740:                         IF USED("cursor_4c_ProSel")
1741:                             USE IN cursor_4c_ProSel
1742:                         ENDIF
1743:                     ELSE
1744:                         SELECT cursor_4c_Prods
1745:                         REPLACE cpros WITH "", dpros WITH ""
1746:                     ENDIF
1747:                     IF USED("cursor_4c_BuscaPros")
1748:                         USE IN cursor_4c_BuscaPros
1749:                     ENDIF
1750:                 ENDIF
1751:             ENDIF
1752:             IF USED("cursor_4c_BuscaPro")
1753:                 USE IN cursor_4c_BuscaPro
1754:             ENDIF
1755:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1756:         CATCH TO loException
1757:             MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
1758:                 "Formrst.GradProdCodLostFocus")
1759:             IF USED("cursor_4c_BuscaPro")

*-- Linhas 1780 a 1854:
1780:             RETURN
1781:         ENDIF
1782: 
1783:         SELECT cursor_4c_Prods
1784:         loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
1785:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1786: 
1787:         IF EMPTY(loc_cDpros)
1788:             RETURN
1789:         ENDIF
1790: 
1791:         TRY
1792:             IF !EMPTY(loc_cCpros)
1793:                 *-- Verificar duplicidade: mesmo cpros em outra linha
1794:                 SELECT cursor_4c_Prods
1795:                 loc_nRec = RECNO()
1796:                 GO TOP
1797:                 loc_nContagem = 0
1798:                 SCAN FOR !DELETED()
1799:                     IF ALLTRIM(cpros) = loc_cCpros
1800:                         loc_nContagem = loc_nContagem + 1
1801:                     ENDIF
1802:                 ENDSCAN
1803:                 IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1804:                     GO (loc_nRec) IN cursor_4c_Prods
1805:                 ENDIF
1806:                 IF loc_nContagem > 1
1807:                     MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
1808:                     SELECT cursor_4c_Prods
1809:                     REPLACE cpros WITH "", dpros WITH ""
1810:                 ENDIF
1811:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1812:             ELSE
1813:                 *-- cpros vazio: buscar produto por descricao digitada
1814:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1815:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1816:                     " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
1817:                     " ORDER BY a.dpros", ;
1818:                     "cursor_4c_BuscaDpros")
1819:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
1820:                     IF USED("cursor_4c_BuscaDpros")
1821:                         USE IN cursor_4c_BuscaDpros
1822:                     ENDIF
1823:                     SQLEXEC(gnConnHandle, ;
1824:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1825:                         " ORDER BY a.dpros", ;
1826:                         "cursor_4c_BuscaDpros")
1827:                 ENDIF
1828:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1829:                 IF VARTYPE(loc_oBusca) = "O"
1830:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDpros"
1831:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
1832:                         "Descri" + CHR(231) + CHR(227) + "o do Produto")
1833:                     loc_oBusca.Mostrar()
1834:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1835:                         SELECT cursor_4c_Prods
1836:                         REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
1837:                                 dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1838:                     ELSE
1839:                         SELECT cursor_4c_Prods
1840:                         REPLACE cpros WITH "", dpros WITH ""
1841:                     ENDIF
1842:                     IF USED("cursor_4c_BuscaDpros")
1843:                         USE IN cursor_4c_BuscaDpros
1844:                     ENDIF
1845:                 ENDIF
1846:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1847:             ENDIF
1848:         CATCH TO loException
1849:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1850:                 loException.Message, "Formrst.GradProdDescLostFocus")
1851:             IF USED("cursor_4c_BuscaDpros")
1852:                 USE IN cursor_4c_BuscaDpros
1853:             ENDIF
1854:         ENDTRY

*-- Linhas 1867 a 1899:
1867:             RETURN
1868:         ENDIF
1869: 
1870:         SELECT cursor_4c_Prods
1871:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1872: 
1873:         IF EMPTY(loc_cCodPro)
1874:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1875:             RETURN
1876:         ENDIF
1877: 
1878:         TRY
1879:             loc_lTemImagem = .F.
1880:             loc_nResult = SQLEXEC(gnConnHandle, ;
1881:                 "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1882:                 "cursor_4c_ImgArc")
1883:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
1884:                 SELECT cursor_4c_ImgArc
1885:                 IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
1886:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1887:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
1888:                         "data:image/png;base64,", ""), ;
1889:                         "data:image/jpeg;base64,", ""), ;
1890:                         "data:image/jpg;base64,", ""), 14)
1891:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1892:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1893:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1894:                     loc_lTemImagem = .T.
1895:                 ENDIF
1896:             ENDIF
1897:             IF USED("cursor_4c_ImgArc")
1898:                 USE IN cursor_4c_ImgArc
1899:             ENDIF

*-- Linhas 1913 a 2002:
1913:     *===========================================================================
1914:     * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
1915:     *===========================================================================
1916:     PROCEDURE BtnInserirMuniClick()
1917:         TRY
1918:             IF !USED("cursor_4c_Munis")
1919:                 THIS.InicializarGradesVazias()
1920:             ELSE
1921:                 SELECT cursor_4c_Munis
1922:                 APPEND BLANK
1923:                 REPLACE tipos    WITH "M", ;
1924:                         pkchaves WITH "", ;
1925:                         munici   WITH "", ;
1926:                         codibges WITH "", ;
1927:                         uf       WITH "", ;
1928:                         UFIBGEs  WITH 0
1929:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1930:             ENDIF
1931:         CATCH TO loException
1932:             MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1933:                 "Formrst.BtnInserirMuniClick")
1934:         ENDTRY
1935:     ENDPROC
1936: 
1937:     *===========================================================================
1938:     * BtnExcluirMuniClick - Remove municipio selecionado da grade
1939:     *===========================================================================
1940:     PROCEDURE BtnExcluirMuniClick()
1941:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1942:             MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
1943:             RETURN
1944:         ENDIF
1945:         TRY
1946:             SELECT cursor_4c_Munis
1947:             DELETE
1948:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1949:         CATCH TO loException
1950:             MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1951:                 "Formrst.BtnExcluirMuniClick")
1952:         ENDTRY
1953:     ENDPROC
1954: 
1955:     *===========================================================================
1956:     * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
1957:     *===========================================================================
1958:     PROCEDURE BtnInserirProdClick()
1959:         TRY
1960:             IF !USED("cursor_4c_Prods")
1961:                 THIS.InicializarGradesVazias()
1962:             ELSE
1963:                 SELECT cursor_4c_Prods
1964:                 APPEND BLANK
1965:                 REPLACE tipos    WITH "P", ;
1966:                         pkchaves WITH "", ;
1967:                         cpros    WITH "", ;
1968:                         dpros    WITH ""
1969:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1970:             ENDIF
1971:         CATCH TO loException
1972:             MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
1973:                 "Formrst.BtnInserirProdClick")
1974:         ENDTRY
1975:     ENDPROC
1976: 
1977:     *===========================================================================
1978:     * BtnExcluirProdClick - Remove produto selecionado da grade
1979:     *===========================================================================
1980:     PROCEDURE BtnExcluirProdClick()
1981:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1982:             MsgAviso("Selecione um produto para excluir.", "Aviso")
1983:             RETURN
1984:         ENDIF
1985:         TRY
1986:             SELECT cursor_4c_Prods
1987:             DELETE
1988:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1989:         CATCH TO loException
1990:             MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
1991:                 "Formrst.BtnExcluirProdClick")
1992:         ENDTRY
1993:     ENDPROC
1994: 
1995:     *===========================================================================
1996:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
1997:     * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
1998:     *===========================================================================
1999:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2000:         LOCAL loc_oPg2, loc_lEditando
2001:         TRY
2002:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2


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

