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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS SQL (2010 linhas total):

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

*-- Linhas 637 a 667:
637: 
638:         *-- ===================================================================
639:         *-- Cursores placeholder para configuracao inicial dos grids
640:         *-- (estrutura identica aos criados pelos metodos BuscarMunicipios/BuscarProdutos do BO)
641:         *-- ===================================================================
642:         IF !USED("cursor_4c_Munis")
643:             SET NULL ON
644:             CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
645:                 tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
646:             SET NULL OFF
647:             APPEND BLANK
648:         ENDIF
649: 
650:         IF !USED("cursor_4c_Prods")
651:             SET NULL ON
652:             CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
653:                 dpros C(40), tipos C(1))
654:             SET NULL OFF
655:             APPEND BLANK
656:         ENDIF
657: 
658:         *-- ===================================================================
659:         *-- cmd_4c_InserirMuni - Inserir linha no GradMuni (inserir do legado)
660:         *-- Top=305+29=334, Left=356, Width=45, Height=45
661:         *-- ===================================================================
662:         loc_oPagina.AddObject("cmd_4c_InserirMuni", "CommandButton")
663:         WITH loc_oPagina.cmd_4c_InserirMuni
664:             .Caption         = ""
665:             .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
666:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
667:             .PicturePosition = 0

*-- Linhas 708 a 760:
708:         *-- Top=133+29=162, Left=41, Width=309, Height=456
709:         *-- Col1=UF(24), Col2=Municipio(263)
710:         *-- ===================================================================
711:         loc_oPagina.AddObject("grd_4c_Munis", "Grid")
712:         loc_oPagina.grd_4c_Munis.ColumnCount = 3
713:         loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
714:         loc_oPagina.grd_4c_Munis.ColumnCount  = 2
715: 
716:         WITH loc_oPagina.grd_4c_Munis
717:             .Top                = 162
718:             .Left               = 41
719:             .Width              = 309
720:             .Height             = 456
721:             .DeleteMark         = .F.
722:             .RecordMark         = .F.
723:             .RowHeight          = 16
724:             .ScrollBars         = 2
725:             .GridLines          = 3
726:             .GridLineColor      = RGB(238, 238, 238)
727:             .HeaderHeight       = 20
728:             .FontName           = "Tahoma"
729:             .FontSize           = 8
730:             .ForeColor          = RGB(0, 0, 0)
731:             .BackColor          = RGB(255, 255, 255)
732:             .HighlightBackColor = RGB(255, 255, 255)
733:             .HighlightForeColor = RGB(15, 41, 104)
734:             .HighlightStyle     = 2
735:             .Visible            = .T.
736: 
737:             .Column1.ControlSource     = "cursor_4c_Munis.uf"
738:             .Column1.Width             = 24
739:             .Column1.FontName          = "Tahoma"
740:             .Column1.FontSize          = 8
741:             .Column1.Resizable         = .T.
742:             .Column1.Header1.Caption   = "UF"
743:             .Column1.Header1.Alignment = 2
744: 
745:             .Column2.ControlSource     = "cursor_4c_Munis.munici"
746:             .Column2.Width             = 263
747:             .Column2.FontName          = "Tahoma"
748:             .Column2.FontSize          = 8
749:             .Column2.Resizable         = .T.
750:             .Column2.Header1.Caption   = "Munic" + CHR(237) + "pio"
751:             .Column2.Header1.Alignment = 2
752:         ENDWITH
753: 
754:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
755:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")
756: 
757:         *-- ===================================================================
758:         *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
759:         *-- Top=305+29=334, Left=912, Width=45, Height=45
760:         *-- ===================================================================

*-- Linhas 817 a 859:
817:             .Left               = 417
818:             .Width              = 490
819:             .Height             = 456
820:             .DeleteMark         = .F.
821:             .RecordMark         = .F.
822:             .RowHeight          = 16
823:             .ScrollBars         = 2
824:             .GridLines          = 3
825:             .GridLineColor      = RGB(238, 238, 238)
826:             .HeaderHeight       = 20
827:             .FontName           = "Tahoma"
828:             .FontSize           = 8
829:             .ForeColor          = RGB(0, 0, 0)
830:             .BackColor          = RGB(255, 255, 255)
831:             .HighlightBackColor = RGB(255, 255, 255)
832:             .HighlightForeColor = RGB(15, 41, 104)
833:             .HighlightStyle     = 2
834:             .Visible            = .T.
835: 
836:             .Column1.ControlSource     = "cursor_4c_Prods.cpros"
837:             .Column1.Width             = 108
838:             .Column1.FontName          = "Tahoma"
839:             .Column1.FontSize          = 8
840:             .Column1.Resizable         = .T.
841:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
842:             .Column1.Header1.Alignment = 2
843: 
844:             .Column2.ControlSource     = "cursor_4c_Prods.dpros"
845:             .Column2.Width             = 360
846:             .Column2.FontName          = "Tahoma"
847:             .Column2.FontSize          = 8
848:             .Column2.Resizable         = .T.
849:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
850:             .Column2.Header1.Alignment = 2
851:         ENDWITH
852: 
853:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
854:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
855:         BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")
856: 
857:         *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
858:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
859:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

*-- Linhas 866 a 910:
866: 
867:     *===========================================================================
868:     * CarregarLista - Carrega dados no grid da Page1 via BO
869:     * Vincula RecordSource, ControlSource e Header1.Caption apos Buscar()
870:     *===========================================================================
871:     PROCEDURE CarregarLista()
872:         LOCAL loc_lResultado, loc_oGrid
873:         loc_lResultado = .F.
874: 
875:         TRY
876:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
877:                 loc_lResultado = .T.
878:             ELSE
879:                 IF !THIS.this_oBusinessObject.Buscar("")
880:                     loc_lResultado = .F.
881:                 ELSE
882:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
883: 
884:                     loc_oGrid.ColumnCount = 3
885:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
886:                     loc_oGrid.ColumnCount  = 2
887: 
888:                     *-- Reconfigurar ControlSource e Headers apos RecordSource
889:                     *-- (RecordSource reseta essas propriedades - Problema #2 FORMCOR_LICOES)
890:                     WITH loc_oGrid
891:                         .Column1.ControlSource   = "cursor_4c_Dados.iclis"
892:                         .Column1.Width           = 100
893:                         .Column1.Header1.Caption = "Conta"
894: 
895:                         .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
896:                         .Column2.Width           = 450
897:                         .Column2.Header1.Caption = "Nome"
898:                     ENDWITH
899: 
900:                     THIS.FormatarGridLista(loc_oGrid)
901: 
902:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
903:                         GO TOP IN cursor_4c_Dados
904:                     ENDIF
905: 
906:                     loc_lResultado = .T.
907:                 ENDIF
908:             ENDIF
909:         CATCH TO loException
910:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;

*-- Linhas 964 a 1023:
964:             MsgAviso("Selecione um registro na lista.", "Aviso")
965:             RETURN
966:         ENDIF
967:         SELECT cursor_4c_Dados
968:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
969:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
970:             THIS.this_cModoAtual = "VISUALIZAR"
971:             THIS.BOParaForm()
972:             THIS.CarregarGrades(loc_cSkChaves)
973:             THIS.HabilitarCampos(.F.)
974:             THIS.AlternarPagina(2)
975:         ENDIF
976:     ENDPROC
977: 
978:     *===========================================================================
979:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
980:     *===========================================================================
981:     PROCEDURE BtnAlterarClick()
982:         LOCAL loc_cSkChaves
983:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
984:             MsgAviso("Selecione um registro na lista.", "Aviso")
985:             RETURN
986:         ENDIF
987:         SELECT cursor_4c_Dados
988:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
989:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
990:             THIS.this_oBusinessObject.EditarRegistro()
991:             THIS.this_cModoAtual = "ALTERAR"
992:             THIS.BOParaForm()
993:             THIS.CarregarGrades(loc_cSkChaves)
994:             THIS.HabilitarCampos(.T.)
995:             THIS.AlternarPagina(2)
996:         ENDIF
997:     ENDPROC
998: 
999:     *===========================================================================
1000:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
1001:     *===========================================================================
1002:     PROCEDURE BtnExcluirClick()
1003:         LOCAL loc_cSkChaves, loc_cIclis
1004:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1005:             MsgAviso("Selecione um registro na lista.", "Aviso")
1006:             RETURN
1007:         ENDIF
1008:         SELECT cursor_4c_Dados
1009:         loc_cSkChaves = ALLTRIM(cursor_4c_Dados.skchaves)
1010:         loc_cIclis    = ALLTRIM(cursor_4c_Dados.iclis)
1011:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da exclusividade" + CHR(13) + ;
1012:                 "da conta: " + loc_cIclis + " ?", "Excluir")
1013:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSkChaves)
1014:                 IF THIS.this_oBusinessObject.Excluir()
1015:                     MsgInfo("Exclusividade exclu" + CHR(237) + "da com sucesso!")
1016:                     THIS.CarregarLista()
1017:                 ENDIF
1018:             ENDIF
1019:         ENDIF
1020:     ENDPROC
1021: 
1022:     *===========================================================================
1023:     * BtnBuscarClick - Recarrega a lista completa (reset de filtro)

*-- Linhas 1038 a 1059:
1038:     *===========================================================================
1039:     PROCEDURE Destroy()
1040:         IF USED("cursor_4c_Dados")
1041:             USE IN cursor_4c_Dados
1042:         ENDIF
1043:         IF USED("cursor_4c_Munis")
1044:             USE IN cursor_4c_Munis
1045:         ENDIF
1046:         IF USED("cursor_4c_Prods")
1047:             USE IN cursor_4c_Prods
1048:         ENDIF
1049:         THIS.this_oBusinessObject = .NULL.
1050:         DODEFAULT()
1051:     ENDPROC
1052: 
1053:     *===========================================================================
1054:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1055:     * Percorre Pages de PageFrames e controles de Containers recursivamente
1056:     *===========================================================================
1057:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1058:         LOCAL loc_nI, loc_oObjeto, loc_nP
1059: 

*-- Linhas 1126 a 1146:
1126:             ENDIF
1127:         CATCH TO loException
1128:             *-- fAcessoContas indisponivel: busca direta em SigCdCli
1129:             loc_nResult = SQLEXEC(gnConnHandle, ;
1130:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1131:                 " WHERE Iclis = " + EscaparSQL(loc_cCodigo), ;
1132:                 "cursor_4c_BuscaCli")
1133:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1134:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1135:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1136:             ELSE
1137:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1138:                 loc_oPg2.txt_4c_Codigo.Value = ""
1139:                 loc_oPg2.txt_4c_Desc.Value   = ""
1140:                 loc_oPg2.txt_4c_Codigo.SetFocus()
1141:             ENDIF
1142:             IF USED("cursor_4c_BuscaCli")
1143:                 USE IN cursor_4c_BuscaCli
1144:             ENDIF
1145:         ENDTRY
1146:     ENDPROC

*-- Linhas 1173 a 1193:
1173:             ENDIF
1174:         CATCH TO loException
1175:             *-- fAcessoContas indisponivel: busca direta em SigCdCli por nome
1176:             loc_nResult = SQLEXEC(gnConnHandle, ;
1177:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1178:                 " WHERE Rclis LIKE " + EscaparSQL(loc_cDesc + "%"), ;
1179:                 "cursor_4c_BuscaCli")
1180:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaCli") > 0
1181:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1182:                 loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1183:             ELSE
1184:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Aviso")
1185:                 loc_oPg2.txt_4c_Desc.Value   = ""
1186:                 loc_oPg2.txt_4c_Codigo.Value = ""
1187:                 loc_oPg2.txt_4c_Desc.SetFocus()
1188:             ENDIF
1189:             IF USED("cursor_4c_BuscaCli")
1190:                 USE IN cursor_4c_BuscaCli
1191:             ENDIF
1192:         ENDTRY
1193:     ENDPROC

*-- Linhas 1205 a 1235:
1205:             RETURN
1206:         ENDIF
1207: 
1208:         SELECT cursor_4c_Prods
1209:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1210:         IF EMPTY(loc_cCodPro)
1211:             RETURN
1212:         ENDIF
1213: 
1214:         TRY
1215:             loc_nResult = SQLEXEC(gnConnHandle, ;
1216:                 "SELECT a.cpros, a.FigJpgs FROM SigCdPro a" + ;
1217:                 " WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1218:                 "cursor_4c_ImgPro")
1219:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgPro") > 0
1220:                 SELECT cursor_4c_ImgPro
1221:                 IF !EMPTY(NVL(cursor_4c_ImgPro.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgPro.FigJpgs)
1222:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1223:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgPro.FigJpgs, ;
1224:                         "data:image/png;base64,", ""), ;
1225:                         "data:image/jpeg;base64,", ""), ;
1226:                         "data:image/jpg;base64,", ""), 14)
1227:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1228:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1229:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1230:                 ENDIF
1231:             ENDIF
1232:             IF USED("cursor_4c_ImgPro")
1233:                 USE IN cursor_4c_ImgPro
1234:             ENDIF
1235:         CATCH TO loException

*-- Linhas 1261 a 1282:
1261:                 *-- Contar produtos com cpros valido
1262:                 loc_nQtdProd = 0
1263:                 IF USED("cursor_4c_Prods")
1264:                     SELECT cursor_4c_Prods
1265:                     loc_nRec = RECNO()
1266:                     GO TOP
1267:                     SCAN FOR !DELETED()
1268:                         IF !EMPTY(ALLTRIM(cpros))
1269:                             loc_nQtdProd = loc_nQtdProd + 1
1270:                         ENDIF
1271:                     ENDSCAN
1272:                     IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1273:                         GO (loc_nRec) IN cursor_4c_Prods
1274:                     ENDIF
1275:                 ENDIF
1276:                 IF loc_nQtdProd = 0
1277:                     MsgAviso("Informe ao menos um produto.", "Aviso")
1278:                 ELSE
1279:                     IF THIS.this_cModoAtual = "INCLUIR"
1280:                         IF THIS.this_oBusinessObject.VerificarContaCadastrada(loc_cIclis)
1281:                             MsgAviso("Esta conta j" + CHR(225) + " possui exclusividade cadastrada.", "Aviso")
1282:                             loc_oPg2.txt_4c_Codigo.SetFocus()

*-- Linhas 1372 a 1532:
1372:     *===========================================================================
1373:     * InicializarGradesVazias - Cria cursores locais vazios (1 linha em branco)
1374:     * Usado em modo INCLUIR para permitir digitacao imediata nas grades
1375:     *===========================================================================
1376:     PROTECTED PROCEDURE InicializarGradesVazias()
1377:         IF USED("cursor_4c_Munis")
1378:             USE IN cursor_4c_Munis
1379:         ENDIF
1380:         SET NULL ON
1381:         CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
1382:             tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
1383:         SET NULL OFF
1384:         APPEND BLANK IN cursor_4c_Munis
1385:         GO TOP IN cursor_4c_Munis
1386: 
1387:         IF USED("cursor_4c_Prods")
1388:             USE IN cursor_4c_Prods
1389:         ENDIF
1390:         SET NULL ON
1391:         CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
1392:             dpros C(40), tipos C(1))
1393:         SET NULL OFF
1394:         APPEND BLANK IN cursor_4c_Prods
1395:         GO TOP IN cursor_4c_Prods
1396: 
1397:         THIS.RefreshGridMunis()
1398:         THIS.RefreshGridProds()
1399:     ENDPROC
1400: 
1401:     *===========================================================================
1402:     * RefreshGridMunis - Rebinda grd_4c_Munis ao cursor_4c_Munis
1403:     * Necessario apos BuscarMunicipios() recriar o cursor (Problema #2/#48)
1404:     *===========================================================================
1405:     PROTECTED PROCEDURE RefreshGridMunis()
1406:         LOCAL loc_oGrid
1407:         TRY
1408:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Munis
1409:             loc_oGrid.ColumnCount = 3
1410:             loc_oGrid.RecordSource = "cursor_4c_Munis"
1411:             loc_oGrid.ColumnCount  = 2
1412:             WITH loc_oGrid
1413:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1414:                 .Column1.Width           = 24
1415:                 .Column1.Header1.Caption = "UF"
1416:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1417:                 .Column2.Width           = 263
1418:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1419:             ENDWITH
1420:             loc_oGrid.Refresh()
1421:         CATCH TO loException
1422:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1423:                 loException.Message, "Formrst.RefreshGridMunis")
1424:         ENDTRY
1425:     ENDPROC
1426: 
1427:     *===========================================================================
1428:     * RefreshGridProds - Rebinda grd_4c_Prods ao cursor_4c_Prods
1429:     * Necessario apos BuscarProdutos() recriar o cursor (Problema #2/#48)
1430:     *===========================================================================
1431:     PROTECTED PROCEDURE RefreshGridProds()
1432:         LOCAL loc_oGrid
1433:         TRY
1434:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Prods
1435:             loc_oGrid.ColumnCount = 3
1436:             loc_oGrid.RecordSource = "cursor_4c_Prods"
1437:             loc_oGrid.ColumnCount  = 2
1438:             WITH loc_oGrid
1439:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1440:                 .Column1.Width           = 108
1441:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1442:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1443:                 .Column2.Width           = 360
1444:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1445:             ENDWITH
1446:             loc_oGrid.Refresh()
1447:         CATCH TO loException
1448:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1449:                 "Formrst.RefreshGridProds")
1450:         ENDTRY
1451:     ENDPROC
1452: 
1453:     *===========================================================================
1454:     * GradMuniUFLostFocus - Valida UF digitada na Column1 de grd_4c_Munis
1455:     * Busca em SigCdUfs; se nao encontrado abre FormBuscaAuxiliar
1456:     *===========================================================================
1457:     PROCEDURE GradMuniUFLostFocus
1458:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1459:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1460:             RETURN
1461:         ENDIF
1462:         LOCAL loc_cUF, loc_nResult, loc_oBusca
1463: 
1464:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1465:             RETURN
1466:         ENDIF
1467: 
1468:         SELECT cursor_4c_Munis
1469:         loc_cUF = ALLTRIM(cursor_4c_Munis.uf)
1470: 
1471:         IF EMPTY(loc_cUF)
1472:             RETURN
1473:         ENDIF
1474: 
1475:         TRY
1476:             loc_nResult = SQLEXEC(gnConnHandle, ;
1477:                 "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1478:                 " WHERE estados = " + EscaparSQL(loc_cUF), ;
1479:                 "cursor_4c_BuscaUf")
1480:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaUf") > 0
1481:                 SELECT cursor_4c_Munis
1482:                 REPLACE uf      WITH ALLTRIM(cursor_4c_BuscaUf.estados), ;
1483:                         UFIBGEs WITH cursor_4c_BuscaUf.ufibges
1484:             ELSE
1485:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1486:                     "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs" + ;
1487:                     " WHERE estados LIKE " + EscaparSQL(loc_cUF + "%") + ;
1488:                     " ORDER BY estados", ;
1489:                     "cursor_4c_BuscaUfs")
1490:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaUfs") = 0
1491:                     IF USED("cursor_4c_BuscaUfs")
1492:                         USE IN cursor_4c_BuscaUfs
1493:                     ENDIF
1494:                     SQLEXEC(gnConnHandle, ;
1495:                         "SELECT estados AS codigo, estados AS descricao FROM SigCdUfs ORDER BY estados", ;
1496:                         "cursor_4c_BuscaUfs")
1497:                 ENDIF
1498:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1499:                 IF VARTYPE(loc_oBusca) = "O"
1500:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUfs"
1501:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaUfs", "codigo", "descricao", "UF")
1502:                     loc_oBusca.Mostrar()
1503:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1504:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1505:                             "SELECT TOP 1 estados, ufibges FROM SigCdUfs" + ;
1506:                             " WHERE estados = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1507:                             "cursor_4c_UfSel")
1508:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_UfSel") > 0
1509:                             SELECT cursor_4c_Munis
1510:                             REPLACE uf      WITH ALLTRIM(cursor_4c_UfSel.estados), ;
1511:                                     UFIBGEs WITH cursor_4c_UfSel.ufibges
1512:                         ENDIF
1513:                         IF USED("cursor_4c_UfSel")
1514:                             USE IN cursor_4c_UfSel
1515:                         ENDIF
1516:                     ELSE
1517:                         SELECT cursor_4c_Munis
1518:                         REPLACE uf WITH "", UFIBGEs WITH 0
1519:                     ENDIF
1520:                     IF USED("cursor_4c_BuscaUfs")
1521:                         USE IN cursor_4c_BuscaUfs
1522:                     ENDIF
1523:                 ENDIF
1524:             ENDIF
1525:             IF USED("cursor_4c_BuscaUf")
1526:                 USE IN cursor_4c_BuscaUf
1527:             ENDIF
1528:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1529:         CATCH TO loException
1530:             MsgErro("Erro ao validar UF:" + CHR(13) + loException.Message, ;
1531:                 "Formrst.GradMuniUFLostFocus")
1532:             IF USED("cursor_4c_BuscaUf")

*-- Linhas 1547 a 1658:
1547:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1548:             RETURN
1549:         ENDIF
1550:         LOCAL loc_cMunici, loc_cUF, loc_nContagem, loc_nResult, loc_oBusca, loc_nRec
1551: 
1552:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1553:             RETURN
1554:         ENDIF
1555: 
1556:         SELECT cursor_4c_Munis
1557:         loc_cMunici = ALLTRIM(cursor_4c_Munis.munici)
1558:         loc_cUF     = ALLTRIM(cursor_4c_Munis.uf)
1559: 
1560:         IF EMPTY(loc_cMunici)
1561:             RETURN
1562:         ENDIF
1563: 
1564:         TRY
1565:             *-- Verificar duplicidade: mesmo uf + munici em outra linha
1566:             SELECT cursor_4c_Munis
1567:             loc_nRec = RECNO()
1568:             GO TOP
1569:             loc_nContagem = 0
1570:             SCAN FOR !DELETED()
1571:                 IF ALLTRIM(uf) = loc_cUF AND ALLTRIM(munici) = loc_cMunici
1572:                     loc_nContagem = loc_nContagem + 1
1573:                 ENDIF
1574:             ENDSCAN
1575:             IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Munis")
1576:                 GO (loc_nRec) IN cursor_4c_Munis
1577:             ENDIF
1578: 
1579:             IF loc_nContagem > 1
1580:                 MsgAviso("Munic" + CHR(237) + "pio j" + CHR(225) + ;
1581:                     " adicionado para este estado.", "Aviso")
1582:                 SELECT cursor_4c_Munis
1583:                 REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1584:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1585:             ELSE
1586:                 *-- Busca exata em SigCdMun pelo nome do municipio
1587:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1588:                     "SELECT TOP 1 a.codigos, a.descs," + ;
1589:                     " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1590:                     " FROM SigCdMun a" + ;
1591:                     " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1592:                     " WHERE a.descs = " + EscaparSQL(loc_cMunici), ;
1593:                     "cursor_4c_BuscaMun")
1594:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaMun") > 0
1595:                     SELECT cursor_4c_Munis
1596:                     REPLACE codibges WITH ALLTRIM(cursor_4c_BuscaMun.codigos), ;
1597:                             munici   WITH ALLTRIM(cursor_4c_BuscaMun.descs), ;
1598:                             uf       WITH ALLTRIM(cursor_4c_BuscaMun.uf), ;
1599:                             UFIBGEs  WITH cursor_4c_BuscaMun.UFIBGEs
1600:                 ELSE
1601:                     *-- Abrir picker de municipios
1602:                     loc_nResult = SQLEXEC(gnConnHandle, ;
1603:                         "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1604:                         " FROM SigCdMun a" + ;
1605:                         " WHERE a.descs LIKE " + EscaparSQL(loc_cMunici + "%") + ;
1606:                         " ORDER BY a.descs", ;
1607:                         "cursor_4c_BuscaMuns")
1608:                     IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaMuns") = 0
1609:                         IF USED("cursor_4c_BuscaMuns")
1610:                             USE IN cursor_4c_BuscaMuns
1611:                         ENDIF
1612:                         SQLEXEC(gnConnHandle, ;
1613:                             "SELECT a.codigos AS codigo, a.descs AS descricao" + ;
1614:                             " FROM SigCdMun a ORDER BY a.descs", ;
1615:                             "cursor_4c_BuscaMuns")
1616:                     ENDIF
1617:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1618:                     IF VARTYPE(loc_oBusca) = "O"
1619:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaMuns"
1620:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaMuns", "codigo", "descricao", ;
1621:                             "Munic" + CHR(237) + "pio")
1622:                         loc_oBusca.Mostrar()
1623:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1624:                             loc_nResult = SQLEXEC(gnConnHandle, ;
1625:                                 "SELECT TOP 1 a.codigos, a.descs," + ;
1626:                                 " ISNULL(b.estados,'') AS uf, ISNULL(b.ufibges,0) AS UFIBGEs" + ;
1627:                                 " FROM SigCdMun a" + ;
1628:                                 " LEFT JOIN SigCdUfs b ON b.ufibges = a.ufibges" + ;
1629:                                 " WHERE a.codigos = " + ;
1630:                                 EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1631:                                 "cursor_4c_MunSel")
1632:                             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MunSel") > 0
1633:                                 SELECT cursor_4c_Munis
1634:                                 REPLACE codibges WITH ALLTRIM(cursor_4c_MunSel.codigos), ;
1635:                                         munici   WITH ALLTRIM(cursor_4c_MunSel.descs), ;
1636:                                         uf       WITH ALLTRIM(cursor_4c_MunSel.uf), ;
1637:                                         UFIBGEs  WITH cursor_4c_MunSel.UFIBGEs
1638:                             ENDIF
1639:                             IF USED("cursor_4c_MunSel")
1640:                                 USE IN cursor_4c_MunSel
1641:                             ENDIF
1642:                         ELSE
1643:                             SELECT cursor_4c_Munis
1644:                             REPLACE munici WITH "", codibges WITH "", UFIBGEs WITH 0, uf WITH ""
1645:                         ENDIF
1646:                         IF USED("cursor_4c_BuscaMuns")
1647:                             USE IN cursor_4c_BuscaMuns
1648:                         ENDIF
1649:                     ENDIF
1650:                 ENDIF
1651:                 IF USED("cursor_4c_BuscaMun")
1652:                     USE IN cursor_4c_BuscaMun
1653:                 ENDIF
1654:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1655:             ENDIF
1656:         CATCH TO loException
1657:             MsgErro("Erro ao validar munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1658:                 "Formrst.GradMuniMunLostFocus")

*-- Linhas 1680 a 1749:
1680:             RETURN
1681:         ENDIF
1682: 
1683:         SELECT cursor_4c_Prods
1684:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1685: 
1686:         IF EMPTY(loc_cCpros)
1687:             RETURN
1688:         ENDIF
1689: 
1690:         TRY
1691:             loc_nResult = SQLEXEC(gnConnHandle, ;
1692:                 "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1693:                 " WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
1694:                 "cursor_4c_BuscaPro")
1695:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaPro") > 0
1696:                 SELECT cursor_4c_Prods
1697:                 REPLACE cpros WITH ALLTRIM(cursor_4c_BuscaPro.cpros), ;
1698:                         dpros WITH ALLTRIM(cursor_4c_BuscaPro.dpros)
1699:             ELSE
1700:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1701:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1702:                     " WHERE a.cpros LIKE " + EscaparSQL(loc_cCpros + "%") + ;
1703:                     " ORDER BY a.cpros", ;
1704:                     "cursor_4c_BuscaPros")
1705:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaPros") = 0
1706:                     IF USED("cursor_4c_BuscaPros")
1707:                         USE IN cursor_4c_BuscaPros
1708:                     ENDIF
1709:                     SQLEXEC(gnConnHandle, ;
1710:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1711:                         " ORDER BY a.cpros", ;
1712:                         "cursor_4c_BuscaPros")
1713:                 ENDIF
1714:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1715:                 IF VARTYPE(loc_oBusca) = "O"
1716:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaPros"
1717:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaPros", "codigo", "descricao", ;
1718:                         CHR(67) + CHR(243) + "digo do Produto")
1719:                     loc_oBusca.Mostrar()
1720:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1721:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1722:                             "SELECT TOP 1 a.cpros, a.dpros FROM SigCdPro a" + ;
1723:                             " WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_oBusca.cCodigoSelecionado)), ;
1724:                             "cursor_4c_ProSel")
1725:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProSel") > 0
1726:                             SELECT cursor_4c_Prods
1727:                             REPLACE cpros WITH ALLTRIM(cursor_4c_ProSel.cpros), ;
1728:                                     dpros WITH ALLTRIM(cursor_4c_ProSel.dpros)
1729:                         ENDIF
1730:                         IF USED("cursor_4c_ProSel")
1731:                             USE IN cursor_4c_ProSel
1732:                         ENDIF
1733:                     ELSE
1734:                         SELECT cursor_4c_Prods
1735:                         REPLACE cpros WITH "", dpros WITH ""
1736:                     ENDIF
1737:                     IF USED("cursor_4c_BuscaPros")
1738:                         USE IN cursor_4c_BuscaPros
1739:                     ENDIF
1740:                 ENDIF
1741:             ENDIF
1742:             IF USED("cursor_4c_BuscaPro")
1743:                 USE IN cursor_4c_BuscaPro
1744:             ENDIF
1745:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1746:         CATCH TO loException
1747:             MsgErro("Erro ao validar produto:" + CHR(13) + loException.Message, ;
1748:                 "Formrst.GradProdCodLostFocus")
1749:             IF USED("cursor_4c_BuscaPro")

*-- Linhas 1770 a 1844:
1770:             RETURN
1771:         ENDIF
1772: 
1773:         SELECT cursor_4c_Prods
1774:         loc_cDpros = ALLTRIM(cursor_4c_Prods.dpros)
1775:         loc_cCpros = ALLTRIM(cursor_4c_Prods.cpros)
1776: 
1777:         IF EMPTY(loc_cDpros)
1778:             RETURN
1779:         ENDIF
1780: 
1781:         TRY
1782:             IF !EMPTY(loc_cCpros)
1783:                 *-- Verificar duplicidade: mesmo cpros em outra linha
1784:                 SELECT cursor_4c_Prods
1785:                 loc_nRec = RECNO()
1786:                 GO TOP
1787:                 loc_nContagem = 0
1788:                 SCAN FOR !DELETED()
1789:                     IF ALLTRIM(cpros) = loc_cCpros
1790:                         loc_nContagem = loc_nContagem + 1
1791:                     ENDIF
1792:                 ENDSCAN
1793:                 IF loc_nRec > 0 AND loc_nRec <= RECCOUNT("cursor_4c_Prods")
1794:                     GO (loc_nRec) IN cursor_4c_Prods
1795:                 ENDIF
1796:                 IF loc_nContagem > 1
1797:                     MsgAviso("Produto j" + CHR(225) + " adicionado a esta exclusividade.", "Aviso")
1798:                     SELECT cursor_4c_Prods
1799:                     REPLACE cpros WITH "", dpros WITH ""
1800:                 ENDIF
1801:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1802:             ELSE
1803:                 *-- cpros vazio: buscar produto por descricao digitada
1804:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1805:                     "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1806:                     " WHERE a.dpros LIKE " + EscaparSQL(loc_cDpros + "%") + ;
1807:                     " ORDER BY a.dpros", ;
1808:                     "cursor_4c_BuscaDpros")
1809:                 IF loc_nResult < 0 OR RECCOUNT("cursor_4c_BuscaDpros") = 0
1810:                     IF USED("cursor_4c_BuscaDpros")
1811:                         USE IN cursor_4c_BuscaDpros
1812:                     ENDIF
1813:                     SQLEXEC(gnConnHandle, ;
1814:                         "SELECT a.cpros AS codigo, a.dpros AS descricao FROM SigCdPro a" + ;
1815:                         " ORDER BY a.dpros", ;
1816:                         "cursor_4c_BuscaDpros")
1817:                 ENDIF
1818:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1819:                 IF VARTYPE(loc_oBusca) = "O"
1820:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDpros"
1821:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaDpros", "codigo", "descricao", ;
1822:                         "Descri" + CHR(231) + CHR(227) + "o do Produto")
1823:                     loc_oBusca.Mostrar()
1824:                     IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1825:                         SELECT cursor_4c_Prods
1826:                         REPLACE cpros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado), ;
1827:                                 dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1828:                     ELSE
1829:                         SELECT cursor_4c_Prods
1830:                         REPLACE cpros WITH "", dpros WITH ""
1831:                     ENDIF
1832:                     IF USED("cursor_4c_BuscaDpros")
1833:                         USE IN cursor_4c_BuscaDpros
1834:                     ENDIF
1835:                 ENDIF
1836:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1837:             ENDIF
1838:         CATCH TO loException
1839:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1840:                 loException.Message, "Formrst.GradProdDescLostFocus")
1841:             IF USED("cursor_4c_BuscaDpros")
1842:                 USE IN cursor_4c_BuscaDpros
1843:             ENDIF
1844:         ENDTRY

*-- Linhas 1857 a 1889:
1857:             RETURN
1858:         ENDIF
1859: 
1860:         SELECT cursor_4c_Prods
1861:         loc_cCodPro = ALLTRIM(cursor_4c_Prods.cpros)
1862: 
1863:         IF EMPTY(loc_cCodPro)
1864:             loc_oPg2.img_4c_ImgProds.Visible = .F.
1865:             RETURN
1866:         ENDIF
1867: 
1868:         TRY
1869:             loc_lTemImagem = .F.
1870:             loc_nResult = SQLEXEC(gnConnHandle, ;
1871:                 "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCodPro), ;
1872:                 "cursor_4c_ImgArc")
1873:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgArc") > 0
1874:                 SELECT cursor_4c_ImgArc
1875:                 IF !EMPTY(NVL(cursor_4c_ImgArc.FigJpgs, "")) AND !ISNULL(cursor_4c_ImgArc.FigJpgs)
1876:                     loc_cArquivo = SYS(2023) + "\" + goSistema.Sys2015Tmp + SYS(2015) + ".jpg"
1877:                     loc_cFoto    = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ImgArc.FigJpgs, ;
1878:                         "data:image/png;base64,", ""), ;
1879:                         "data:image/jpeg;base64,", ""), ;
1880:                         "data:image/jpg;base64,", ""), 14)
1881:                     STRTOFILE(loc_cFoto, loc_cArquivo)
1882:                     loc_oPg2.img_4c_ImgProds.Picture = loc_cArquivo
1883:                     loc_oPg2.img_4c_ImgProds.Visible = .T.
1884:                     loc_lTemImagem = .T.
1885:                 ENDIF
1886:             ENDIF
1887:             IF USED("cursor_4c_ImgArc")
1888:                 USE IN cursor_4c_ImgArc
1889:             ENDIF

*-- Linhas 1903 a 1992:
1903:     *===========================================================================
1904:     * BtnInserirMuniClick - Adiciona linha em branco na grade de municipios
1905:     *===========================================================================
1906:     PROCEDURE BtnInserirMuniClick()
1907:         TRY
1908:             IF !USED("cursor_4c_Munis")
1909:                 THIS.InicializarGradesVazias()
1910:             ELSE
1911:                 SELECT cursor_4c_Munis
1912:                 APPEND BLANK
1913:                 REPLACE tipos    WITH "M", ;
1914:                         pkchaves WITH "", ;
1915:                         munici   WITH "", ;
1916:                         codibges WITH "", ;
1917:                         uf       WITH "", ;
1918:                         UFIBGEs  WITH 0
1919:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1920:             ENDIF
1921:         CATCH TO loException
1922:             MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1923:                 "Formrst.BtnInserirMuniClick")
1924:         ENDTRY
1925:     ENDPROC
1926: 
1927:     *===========================================================================
1928:     * BtnExcluirMuniClick - Remove municipio selecionado da grade
1929:     *===========================================================================
1930:     PROCEDURE BtnExcluirMuniClick()
1931:         IF !USED("cursor_4c_Munis") OR EOF("cursor_4c_Munis") OR BOF("cursor_4c_Munis")
1932:             MsgAviso("Selecione um munic" + CHR(237) + "pio para excluir.", "Aviso")
1933:             RETURN
1934:         ENDIF
1935:         TRY
1936:             SELECT cursor_4c_Munis
1937:             DELETE
1938:             THIS.pgf_4c_Paginas.Page2.grd_4c_Munis.Refresh()
1939:         CATCH TO loException
1940:             MsgErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + loException.Message, ;
1941:                 "Formrst.BtnExcluirMuniClick")
1942:         ENDTRY
1943:     ENDPROC
1944: 
1945:     *===========================================================================
1946:     * BtnInserirProdClick - Adiciona linha em branco na grade de produtos
1947:     *===========================================================================
1948:     PROCEDURE BtnInserirProdClick()
1949:         TRY
1950:             IF !USED("cursor_4c_Prods")
1951:                 THIS.InicializarGradesVazias()
1952:             ELSE
1953:                 SELECT cursor_4c_Prods
1954:                 APPEND BLANK
1955:                 REPLACE tipos    WITH "P", ;
1956:                         pkchaves WITH "", ;
1957:                         cpros    WITH "", ;
1958:                         dpros    WITH ""
1959:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1960:             ENDIF
1961:         CATCH TO loException
1962:             MsgErro("Erro ao inserir produto:" + CHR(13) + loException.Message, ;
1963:                 "Formrst.BtnInserirProdClick")
1964:         ENDTRY
1965:     ENDPROC
1966: 
1967:     *===========================================================================
1968:     * BtnExcluirProdClick - Remove produto selecionado da grade
1969:     *===========================================================================
1970:     PROCEDURE BtnExcluirProdClick()
1971:         IF !USED("cursor_4c_Prods") OR EOF("cursor_4c_Prods") OR BOF("cursor_4c_Prods")
1972:             MsgAviso("Selecione um produto para excluir.", "Aviso")
1973:             RETURN
1974:         ENDIF
1975:         TRY
1976:             SELECT cursor_4c_Prods
1977:             DELETE
1978:             THIS.pgf_4c_Paginas.Page2.grd_4c_Prods.Refresh()
1979:         CATCH TO loException
1980:             MsgErro("Erro ao excluir produto:" + CHR(13) + loException.Message, ;
1981:                 "Formrst.BtnExcluirProdClick")
1982:         ENDTRY
1983:     ENDPROC
1984: 
1985:     *===========================================================================
1986:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo atual
1987:     * INCLUIR/ALTERAR -> Confirmar habilitado; VISUALIZAR -> Confirmar desabilitado
1988:     *===========================================================================
1989:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1990:         LOCAL loc_oPg2, loc_lEditando
1991:         TRY
1992:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2


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

