# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CMES, CANO, CTITULO, MOEDA, CMOES, CODIGOS, ICLIS, VALOR, PERC, CGRUPOS, TIPO, CIDCHAVES, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CMES, CANO, CTITULO, MOEDA, CMOES, CODIGOS, ICLIS, VALOR, PERC, CGRUPOS, TIPO, CIDCHAVES, GRUPOS

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
  ControlSource = "crSigCdMrp.nVlTots"
  ControlSource = "crSigCdMrp.cmes"
  ControlSource = "crSigCdMrp.cemps"
  ControlSource = "crSigCdMrp.cano"
  ControlSource = "crSigCdMrp.ctitulo"
  ControlSource = ""
  ControlSource = "crSigCdMrp.moeda"
  DeleteMark = .F.
  Column1.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
Select crGrupos
Select crContas
Select (cArea)
Select Sum(Valor) as TotLancado from crGrupos into cursor crTotGrupos
Select Sum(Valor) as TotLancado from crContas into cursor crTotContas
	lcQryCdmp  = [Select cEmps, cMes, cAno, cTitulo, Moeda, nVlTots, Max(cIdChaves) as cIdChaves from SigCdMrp Group by cEmps, cMes, cAno, cTitulo, Moeda, nVlTots]
	lcQryCdmpD = [Select * From SigCdMrp Where cEmps = ?crSigCdMrp.cEmps and cMes = ?crSigCdMrp.cMes and cAno = ?crSigCdMrp.cAno and cTitulo = ?crSigCdMrp.cTitulo and Moeda = ?crSigCdMrp.Moeda]
	ThisForm.Pagina.Lista.Grade.Column2.ControlSource = [Alltrim(crSigCdMrp.cMes)+Iif(!IsEmpty(crSigCdMrp.cMes),'/','')+crSigCdMrp.cAno]
	If .poDataMgr.SQLExecute([Select Codigos, Descrs, 999999999.99 as Valor, 999.999999 as Perc from SigCdGcr Order by Codigos],'crGrupos') < 1 Then
	Update crGrupos set Valor = 0, Perc = 0
	ThisForm.Pagina.Dados.Grd_Grupos.Column1.ControlSource = [crGrupos.Codigos]
	ThisForm.Pagina.Dados.Grd_Grupos.Column2.ControlSource = [crGrupos.Descrs]
	ThisForm.Pagina.Dados.Grd_Grupos.Column3.ControlSource = [crGrupos.Valor]    
	ThisForm.Pagina.Dados.Grd_Grupos.Column4.ControlSource = [crGrupos.Perc]
	.poDataMgr.Delete(1)
	m.lnErro1 = Iif(ThisForm.poDatamgr.Update('crCdmpDados'),1,-1)
SELECT crSigCdMrp
Select crSigCdMrp
	If ThisForm.podatamgr.SQLExecute([Select Grupos, iClis, rClis, 999999999.99 as Valor, 999.999999 as Perc from SigCdCli],'crContas') < 1 Then
	Select crContas
	ThisForm.Pagina.Dados.Grd_Contas.Column1.ControlSource = [crContas.iClis]
	ThisForm.Pagina.Dados.Grd_Contas.Column2.ControlSource = [crContas.rClis]
	ThisForm.Pagina.Dados.Grd_Contas.Column3.ControlSource = [crContas.Valor]    
	ThisForm.Pagina.Dados.Grd_Contas.Column4.ControlSource = [crContas.Perc]
Update crGrupos set Valor = 0, Perc = 0
Update crContas set Valor = 0, Perc = 0
Select crSigCdMrp
		If ThisForm.podatamgr.SQLExecute([Select dmoes from SigCdMoe where cmoes = ']+crSigCdMrp.Moeda+['],'crMoeda') < 1 Then
		Select crMoeda
		Select crCdmpDados
				Update crGrupos set Valor = crCdmpDados.nValors, Perc = crCdmpDados.nPercs where Codigos = crCdmpDados.cGrupos
				Update crContas set Valor = crCdmpDados.nValors, Perc = crCdmpDados.nPercs where iClis = crCdmpDados.iClis		
Select crSigCdMrp
	Select Codigos as cGrupos, Valor, Perc, 'G' as Tipo, fUniqueIds() as cIdChaves from crGrupos where Valor <> 0 or Perc <> 0 into cursor crPrevAux readwrite
	Select crPrevAux
	Select iClis as cGrupos, Valor, Perc, 'C' as Tipo, fUniqueIds() as cIdChaves from crContas where Valor <> 0 or Perc <> 0 into cursor crPrevAux2 
	Select crPrevAux2
		Insert into crPrevAux from MemVar
	Select cIdChaves from crCdmpDados where cGrupos not in (Select cGrupos from crPrevAux where Tipo = 'G') into cursor crDeleta
	Select crDeleta
		If SQLExec(ThisForm.poDataMgr.pnIdConn,[Delete from SigCdMrp where cIdChaves = ']+crDeleta.cIdChaves+[']) < 1 Then
	Select cIdChaves from crCdmpDados where iClis not in (Select cGrupos from crPrevAux where Tipo = 'C') into cursor crDeleta
	Select crDeleta
		If SQLExec(ThisForm.poDataMgr.pnIdConn,[Delete from SigCdMrp where cIdChaves = ']+crDeleta.cIdChaves+[']) < 1 Then
	Select crPrevAux
		Select cGrupos, iClis from crCdmpDados where cGrupos = Iif(crPrevAux.Tipo = 'G',crPrevAux.cGrupos,'') and ;
		Select crAux
			Insert into crCdmpDados(cEmps,cMes,cAno,cTitulo,Moeda,cGrupos,iClis,nValors,cIdChaves,nPercs,nVlTots) Values(;
			Update crCdmpDados set nValors = crPrevAux.Valor, nPercs = crPrevAux.Perc, nVlTots = ThisForm.Pagina.Dados.Get_nVlTots.Value ;
	Select crCdmpDados
		If SQLExec(ThisForm.podatamgr.pnIdConn,[Delete from SigCdMrp where cIdChaves = ']+crCdmpDados.cIdChaves+[']) < 1 Then
Select crSigCdMrp
	If ThisForm.podatamgr.SQLExecute([Select Grupos, iClis, rClis, 999999999.99 as Valor, 999.999999 as Perc from SigCdCli],'crContas') < 1 Then
	Select crContas
	ThisForm.Pagina.Dados.Grd_Contas.Column1.ControlSource = [crContas.iClis]
	ThisForm.Pagina.Dados.Grd_Contas.Column2.ControlSource = [crContas.rClis]
	ThisForm.Pagina.Dados.Grd_Contas.Column3.ControlSource = [crContas.Valor]    
	ThisForm.Pagina.Dados.Grd_Contas.Column4.ControlSource = [crContas.Perc]
Update crGrupos set Valor = 0, Perc = 0
Update crContas set Valor = 0, Perc = 0
Select crCdmpDados
		Update crGrupos set Valor = crCdmpDados.nValors, Perc = crCdmpDados.nPercs where Codigos = crCdmpDados.cGrupos
		Update crContas set Valor = crCdmpDados.nValors, Perc = crCdmpDados.nPercs where iClis = crCdmpDados.iClis		
Select crContas
Select Count(*) as QTD from crContas where Valor <> 0 and Grupos = crGrupos.Codigos into cursor crAux
Select crAux
Select crContas
Select Count(*) as QTD from crContas where Valor <> 0 and Grupos = crGrupos.Codigos into cursor crAux
Select crAux

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOrc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1747 linhas total):

*-- Linhas 356 a 374:
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .ReadOnly           = .T.
364:             .GridLines          = 3
365:         ENDWITH
366: 
367:         WITH loc_oPagina.grd_4c_Lista
368:             .Column1.Header1.Caption = "Emp"
369:             .Column1.Width           = 40
370: 
371:             .Column2.Header1.Caption = "M" + CHR(234) + "s"
372:             .Column2.Width           = 35
373: 
374:             .Column3.Header1.Caption = "Ano"

*-- Linhas 679 a 697:
679:             .HighlightBackColor = RGB(255, 255, 255)
680:             .HighlightForeColor = RGB(15, 41, 104)
681:             .HighlightStyle     = 2
682:             .DeleteMark         = .F.
683:             .RecordMark         = .F.
684:             .RowHeight          = 16
685:             .ScrollBars         = 2
686:             .GridLines          = 3
687:             .Column1.Header1.Caption = "Grupo"
688:             .Column1.Width           = 80
689:             .Column1.ReadOnly        = .T.
690:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
691:             .Column2.Width           = 300
692:             .Column2.ReadOnly        = .T.
693:             .Column3.Header1.Caption = "Valor"
694:             .Column3.Width           = 170
695:             .Column3.Alignment       = 1
696:             .Column4.Header1.Caption = "%"
697:             .Column4.Width           = 100

*-- Linhas 730 a 748:
730:             .HighlightBackColor = RGB(255, 255, 255)
731:             .HighlightForeColor = RGB(15, 41, 104)
732:             .HighlightStyle     = 2
733:             .DeleteMark         = .F.
734:             .RecordMark         = .F.
735:             .RowHeight          = 16
736:             .ScrollBars         = 2
737:             .GridLines          = 3
738:             .Column1.Header1.Caption = "Conta"
739:             .Column1.Width           = 80
740:             .Column1.ReadOnly        = .T.
741:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
742:             .Column2.Width           = 300
743:             .Column2.ReadOnly        = .T.
744:             .Column3.Header1.Caption = "Valor"
745:             .Column3.Width           = 170
746:             .Column3.Alignment       = 1
747:             .Column4.Header1.Caption = "%"
748:             .Column4.Width           = 100

*-- Linhas 814 a 837:
814:                 ELSE
815:                     loc_oGrid.ColumnCount = 6
816:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
817:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
818:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cmes"
819:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cano"
820:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctitulo"
821:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.moeda"
822:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.nvltots"
823: 
824:                     *-- Reconfigurar cabecalhos apos RecordSource (obrigatorio - RecordSource reseta)
825:                     loc_oGrid.Column1.Header1.Caption = "Emp"
826:                     loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
827:                     loc_oGrid.Column3.Header1.Caption = "Ano"
828:                     loc_oGrid.Column4.Header1.Caption = "T" + CHR(237) + "tulo"
829:                     loc_oGrid.Column5.Header1.Caption = "Moeda"
830:                     loc_oGrid.Column6.Header1.Caption = "Total Or" + CHR(231) + "ado"
831: 
832:                     loc_oGrid.Column1.Width     = 40
833:                     loc_oGrid.Column2.Width     = 35
834:                     loc_oGrid.Column3.Width     = 45
835:                     loc_oGrid.Column4.Width     = 350
836:                     loc_oGrid.Column5.Width     = 55
837:                     loc_oGrid.Column6.Width     = 120

*-- Linhas 906 a 924:
906:         loc_cIdChaves = ""
907: 
908:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
909:             SELECT cursor_4c_Dados
910:             loc_cIdChaves = ALLTRIM(cidchaves)
911:         ENDIF
912: 
913:         IF EMPTY(loc_cIdChaves)
914:             MsgAviso("Selecione um or" + CHR(231) + "amento para visualizar.", "Aviso")
915:             RETURN
916:         ENDIF
917: 
918:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
919:             THIS.this_oBusinessObject.BuscarGrupos()
920:             THIS.this_oBusinessObject.BuscarContas()
921:             THIS.this_oBusinessObject.CarregarDetalhe()
922:             THIS.this_cModoAtual = "VISUALIZAR"
923:             THIS.AjustarBotoesPorModo()
924:             THIS.BOParaForm()

*-- Linhas 935 a 953:
935:         loc_cIdChaves = ""
936: 
937:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
938:             SELECT cursor_4c_Dados
939:             loc_cIdChaves = ALLTRIM(cidchaves)
940:         ENDIF
941: 
942:         IF EMPTY(loc_cIdChaves)
943:             MsgAviso("Selecione um or" + CHR(231) + "amento para alterar.", "Aviso")
944:             RETURN
945:         ENDIF
946: 
947:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
948:             THIS.this_oBusinessObject.BuscarGrupos()
949:             THIS.this_oBusinessObject.BuscarContas()
950:             THIS.this_oBusinessObject.CarregarDetalhe()
951:             THIS.this_oBusinessObject.EditarRegistro()
952:             THIS.this_cModoAtual = "ALTERAR"
953:             THIS.AjustarBotoesPorModo()

*-- Linhas 966 a 984:
966:         loc_cDescricao = ""
967: 
968:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
969:             SELECT cursor_4c_Dados
970:             loc_cIdChaves  = ALLTRIM(cidchaves)
971:             loc_cDescricao = ALLTRIM(ctitulo) + " (" + ALLTRIM(cmes) + "/" + ALLTRIM(cano) + ")"
972:         ENDIF
973: 
974:         IF EMPTY(loc_cIdChaves)
975:             MsgAviso("Selecione um or" + CHR(231) + "amento para excluir.", "Aviso")
976:             RETURN
977:         ENDIF
978: 
979:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o:" + CHR(13) + ;
980:             loc_cDescricao, "Confirmar Exclus" + CHR(227) + "o")
981: 
982:         IF !loc_lConfirma
983:             RETURN
984:         ENDIF

*-- Linhas 1005 a 1055:
1005:             RETURN
1006:         ENDIF
1007: 
1008:         loc_cFiltro = "ctitulo LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")
1009:         IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1010:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1011:             loc_oGrid.ColumnCount = 6
1012:             loc_oGrid.RecordSource          = "cursor_4c_Dados"
1013:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
1014:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cmes"
1015:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cano"
1016:             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctitulo"
1017:             loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.moeda"
1018:             loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.nvltots"
1019:             loc_oGrid.Column1.Header1.Caption = "Emp"
1020:             loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s"
1021:             loc_oGrid.Column3.Header1.Caption = "Ano"
1022:             loc_oGrid.Column4.Header1.Caption = "T" + CHR(237) + "tulo"
1023:             loc_oGrid.Column5.Header1.Caption = "Moeda"
1024:             loc_oGrid.Column6.Header1.Caption = "Total Or" + CHR(231) + "ado"
1025:             loc_oGrid.Refresh()
1026:         ELSE
1027:             MsgAviso("Nenhum or" + CHR(231) + "amento encontrado.", "Busca")
1028:         ENDIF
1029:     ENDPROC
1030: 
1031:     *===========================================================================
1032:     * BtnCopiarClick - Copia orcamento selecionado para novo registro
1033:     * Carrega grupos/contas do original; usuario altera cabecalho e salva como novo
1034:     *===========================================================================
1035:     PROCEDURE BtnCopiarClick()
1036:         LOCAL loc_cIdChaves
1037:         loc_cIdChaves = ""
1038: 
1039:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1040:             SELECT cursor_4c_Dados
1041:             loc_cIdChaves = ALLTRIM(cidchaves)
1042:         ENDIF
1043: 
1044:         IF EMPTY(loc_cIdChaves)
1045:             MsgAviso("Selecione um or" + CHR(231) + "amento para copiar.", "Aviso")
1046:             RETURN
1047:         ENDIF
1048: 
1049:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1050:             IF THIS.this_oBusinessObject.BuscarGrupos() AND ;
1051:                THIS.this_oBusinessObject.BuscarContas() AND ;
1052:                THIS.this_oBusinessObject.CarregarDetalhe()
1053: 
1054:                 THIS.this_oBusinessObject.NovoRegistro()
1055:                 THIS.this_cModoAtual = "INCLUIR"

*-- Linhas 1137 a 1192:
1137:             IF USED("cursor_4c_Grupos")
1138:                 loc_oGrdGrupos.ColumnCount = 4
1139:                 loc_oGrdGrupos.RecordSource          = "cursor_4c_Grupos"
1140:                 loc_oGrdGrupos.Column1.ControlSource = "cursor_4c_Grupos.codigos"
1141:                 loc_oGrdGrupos.Column2.ControlSource = "cursor_4c_Grupos.descrs"
1142:                 loc_oGrdGrupos.Column3.ControlSource = "cursor_4c_Grupos.Valor"
1143:                 loc_oGrdGrupos.Column4.ControlSource = "cursor_4c_Grupos.Perc"
1144:                 loc_oGrdGrupos.Column1.Header1.Caption = "Grupo"
1145:                 loc_oGrdGrupos.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1146:                 loc_oGrdGrupos.Column3.Header1.Caption = "Valor"
1147:                 loc_oGrdGrupos.Column4.Header1.Caption = "%"
1148:                 loc_oGrdGrupos.Column1.Width = 80
1149:                 loc_oGrdGrupos.Column2.Width = 300
1150:                 loc_oGrdGrupos.Column3.Width = 170
1151:                 loc_oGrdGrupos.Column4.Width = 100
1152:                 GO TOP IN cursor_4c_Grupos
1153:             ENDIF
1154: 
1155:             loc_oGrdContas = loc_oPg2.grd_4c_Contas
1156:             IF USED("cursor_4c_Contas")
1157:                 *-- Indexar por grupos para viabilizar SET KEY TO (filtro de exibicao)
1158:                 SELECT cursor_4c_Contas
1159:                 INDEX ON ALLTRIM(grupos) TAG grupos
1160:                 loc_oGrdContas.ColumnCount = 4
1161:                 loc_oGrdContas.RecordSource          = "cursor_4c_Contas"
1162:                 loc_oGrdContas.Column1.ControlSource = "cursor_4c_Contas.iclis"
1163:                 loc_oGrdContas.Column2.ControlSource = "cursor_4c_Contas.rclis"
1164:                 loc_oGrdContas.Column3.ControlSource = "cursor_4c_Contas.Valor"
1165:                 loc_oGrdContas.Column4.ControlSource = "cursor_4c_Contas.Perc"
1166:                 loc_oGrdContas.Column1.Header1.Caption = "Conta"
1167:                 loc_oGrdContas.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1168:                 loc_oGrdContas.Column3.Header1.Caption = "Valor"
1169:                 loc_oGrdContas.Column4.Header1.Caption = "%"
1170:                 loc_oGrdContas.Column1.Width = 80
1171:                 loc_oGrdContas.Column2.Width = 300
1172:                 loc_oGrdContas.Column3.Width = 170
1173:                 loc_oGrdContas.Column4.Width = 100
1174: 
1175:                 *-- Filtrar contas para o primeiro grupo
1176:                 IF USED("cursor_4c_Grupos") AND !EOF("cursor_4c_Grupos")
1177:                     SELECT cursor_4c_Grupos
1178:                     SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
1179:                     GO TOP IN cursor_4c_Contas
1180:                 ENDIF
1181:             ENDIF
1182: 
1183:             THIS.RetornarTotalLancado()
1184: 
1185:         CATCH TO loException
1186:             MostrarErro(loException, "FormOrc.ConfigurarGridsDetalhe")
1187:         ENDTRY
1188:     ENDPROC
1189: 
1190:     *===========================================================================
1191:     * BOParaForm - Transfere dados do BO para os campos visuais da Page2
1192:     *===========================================================================

*-- Linhas 1384 a 1403:
1384:         ENDIF
1385: 
1386:         TRY
1387:             loc_cSQL = "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps)
1388:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpChk")
1389:             IF loc_nResult > 0 AND !EOF("cursor_4c_EmpChk")
1390:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = PADR(loc_cEmps, 3)
1391:             ELSE
1392:                 MsgAviso("Empresa " + loc_cEmps + " n" + CHR(227) + "o encontrada.", "Aviso")
1393:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1394:                 THIS.this_cUltimaEmpValidada = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1395:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
1396:             ENDIF
1397:             IF USED("cursor_4c_EmpChk")
1398:                 USE IN cursor_4c_EmpChk
1399:             ENDIF
1400:         CATCH TO loException
1401:             MostrarErro(loException, "FormOrc.ValidarEmps")
1402:         ENDTRY
1403:     ENDPROC

*-- Linhas 1482 a 1505:
1482:         ENDIF
1483: 
1484:         TRY
1485:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
1486:                        "WHERE cmoes = " + EscaparSQL(loc_cCod)
1487:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeChk")
1488: 
1489:             IF loc_nResult > 0 AND !EOF("cursor_4c_MoeChk")
1490:                 SELECT cursor_4c_MoeChk
1491:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = ALLTRIM(cmoes)
1492:                 THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1493:                 THIS.this_cUltimaMoedaValidada = ALLTRIM(cmoes)
1494:             ELSE
1495:                 THIS.AbrirLookupMoeda()
1496:             ENDIF
1497: 
1498:             IF USED("cursor_4c_MoeChk")
1499:                 USE IN cursor_4c_MoeChk
1500:             ENDIF
1501:         CATCH TO loException
1502:             MostrarErro(loException, "FormOrc.ValidarMoedaCodigo")
1503:         ENDTRY
1504:     ENDPROC
1505: 

*-- Linhas 1518 a 1541:
1518:         ENDIF
1519: 
1520:         TRY
1521:             loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
1522:                        "WHERE dmoes = " + EscaparSQL(loc_cDesc)
1523:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescChk")
1524: 
1525:             IF loc_nResult > 0 AND !EOF("cursor_4c_MoeDescChk")
1526:                 SELECT cursor_4c_MoeDescChk
1527:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = ALLTRIM(cmoes)
1528:                 THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1529:                 THIS.this_cUltimaMoedaValidada = ALLTRIM(cmoes)
1530:             ELSE
1531:                 THIS.AbrirLookupMoeda()
1532:             ENDIF
1533: 
1534:             IF USED("cursor_4c_MoeDescChk")
1535:                 USE IN cursor_4c_MoeDescChk
1536:             ENDIF
1537:         CATCH TO loException
1538:             MostrarErro(loException, "FormOrc.ValidarMoedaDesc")
1539:         ENDTRY
1540:     ENDPROC
1541: 

*-- Linhas 1559 a 1577:
1559:                 loc_oBusca.Show()
1560: 
1561:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1562:                     SELECT cursor_4c_BuscaMoe
1563:                     loc_cCodigo    = ALLTRIM(cmoes)
1564:                     loc_cDescricao = ALLTRIM(dmoes)
1565:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = loc_cCodigo
1566:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = loc_cDescricao
1567:                     THIS.this_cUltimaMoedaValidada = loc_cCodigo
1568:                 ENDIF
1569: 
1570:                 loc_oBusca.Release()
1571:             ENDIF
1572: 
1573:             IF USED("cursor_4c_BuscaMoe")
1574:                 USE IN cursor_4c_BuscaMoe
1575:             ENDIF
1576:         CATCH TO loException
1577:             MostrarErro(loException, "FormOrc.AbrirLookupMoeda")

*-- Linhas 1604 a 1632:
1604: 
1605:         TRY
1606:             IF USED("cursor_4c_Grupos")
1607:                 SELECT cursor_4c_Grupos
1608:                 SCAN
1609:                     IF cursor_4c_Grupos.Perc <> 0
1610:                         loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Grupos.Perc / 100), 2)
1611:                         REPLACE Valor WITH loc_nValor
1612:                     ENDIF
1613:                 ENDSCAN
1614:             ENDIF
1615: 
1616:             IF USED("cursor_4c_Contas")
1617:                 SELECT cursor_4c_Contas
1618:                 SCAN
1619:                     IF cursor_4c_Contas.Perc <> 0
1620:                         loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Contas.Perc / 100), 2)
1621:                         REPLACE Valor WITH loc_nValor
1622:                     ENDIF
1623:                 ENDSCAN
1624:             ENDIF
1625: 
1626:             THIS.RetornarTotalLancado()
1627: 
1628:             IF USED("cursor_4c_Grupos")
1629:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
1630:             ENDIF
1631:             IF USED("cursor_4c_Contas")
1632:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()

*-- Linhas 1639 a 1678:
1639:     *===========================================================================
1640:     * RetornarTotalLancado - Soma grupos + contas e exibe em txt_4c_TotLancado
1641:     * Replica logica do SIGCDORC.RetTotLancado no legado
1642:     * OBS: VFP SELECT SQL ignora SET KEY TO -> soma todos os registros (correto)
1643:     *===========================================================================
1644:     PROCEDURE RetornarTotalLancado()
1645:         LOCAL loc_nTotGrupos, loc_nTotContas, loc_nVlLancado
1646:         loc_nTotGrupos = 0
1647:         loc_nTotContas = 0
1648:         loc_nVlLancado = 0
1649: 
1650:         TRY
1651:             IF USED("cursor_4c_Grupos")
1652:                 SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Grupos ;
1653:                     INTO CURSOR cursor_4c_TotGrp
1654:                 IF !EOF("cursor_4c_TotGrp")
1655:                     loc_nTotGrupos = NVL(cursor_4c_TotGrp.TotLancado, 0)
1656:                 ENDIF
1657:                 IF USED("cursor_4c_TotGrp")
1658:                     USE IN cursor_4c_TotGrp
1659:                 ENDIF
1660:             ENDIF
1661: 
1662:             IF USED("cursor_4c_Contas")
1663:                 SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Contas ;
1664:                     INTO CURSOR cursor_4c_TotCta
1665:                 IF !EOF("cursor_4c_TotCta")
1666:                     loc_nTotContas = NVL(cursor_4c_TotCta.TotLancado, 0)
1667:                 ENDIF
1668:                 IF USED("cursor_4c_TotCta")
1669:                     USE IN cursor_4c_TotCta
1670:                 ENDIF
1671:             ENDIF
1672: 
1673:             loc_nVlLancado = loc_nTotGrupos + loc_nTotContas
1674:             THIS.pgf_4c_Paginas.Page2.txt_4c_TotLancado.Value = loc_nVlLancado
1675:         CATCH TO loException
1676:             MostrarErro(loException, "FormOrc.RetornarTotalLancado")
1677:         ENDTRY
1678:     ENDPROC

*-- Linhas 1686 a 1704:
1686:         TRY
1687:             IF USED("cursor_4c_Grupos") AND USED("cursor_4c_Contas") AND ;
1688:                !EOF("cursor_4c_Grupos")
1689:                 SELECT cursor_4c_Grupos
1690:                 SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
1691:                 GO TOP IN cursor_4c_Contas
1692:                 THIS.RetornarTotalLancado()
1693:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()
1694:             ENDIF
1695:         CATCH TO loException
1696:             MostrarErro(loException, "FormOrc.GruposAfterRowColChange")
1697:         ENDTRY
1698:     ENDPROC
1699: 
1700:     *===========================================================================
1701:     * ContasAfterRowColChange - Linha/coluna do grd_4c_Contas mudou
1702:     * Recalcula total lancado apos mudanca de valor em conta
1703:     * BINDEVENT exige declaracao de par_nColIndex
1704:     *===========================================================================


### BO (C:\4c\projeto\app\classes\OrcBO.prg):
*====================================================================
* OrcBO.prg
*
* Business Object para Orc (Orcamento/Previsao)
* Tabela: SigCdMrp (multi-linha: uma por grupo/conta)
*
* Chave composta do "cabecalho": cEmps + cMes + cAno + cTitulo + Moeda
* Chave de linha: cIdChaves (UUID gerado por fUniqueIds)
*
* Estrutura SigCdMrp:
*   cemps     - Empresa       (C(3))
*   cmes      - Mes           (C(2))
*   cano      - Ano           (C(4))
*   ctitulo   - Titulo        (C(40))
*   moeda     - Cod. Moeda    (C(3))
*   nvltots   - Total orcado  (N(15,2))
*   cgrupos   - Cod. Grupo    (C(10)) - linha de grupo
*   iclis     - Cod. Cliente  (C(10)) - linha de conta
*   nvalors   - Valor         (N(15,2))
*   npercs    - Percentual    (N(9,6))
*   cidchaves - ID unico linha (C(20))
*====================================================================

DEFINE CLASS OrcBO AS BusinessBase

	*-- ==========================================
	*-- Propriedades do cabecalho (identificacao)
	*-- ==========================================
	this_cEmps      = ""  && Empresa (C(3))
	this_cMes       = ""  && Mes (C(2)) - "01" a "12"
	this_cAno       = ""  && Ano (C(4)) - "2026"
	this_cTitulo    = ""  && Titulo da previsao (C(40))
	this_cMoeda     = ""  && Codigo da moeda (C(3))
	this_cDescMoeda = ""  && Descricao da moeda - de SigCdMoe.dmoes
	this_nVlTots    = 0   && Total orcado (N(15,2))

	*-- ==========================================
	*-- Propriedades de linha (detalhe)
	*-- ==========================================
	this_cIdChaves  = ""  && ID unico da linha - gerado por fUniqueIds
	this_cGrupos    = ""  && Codigo do grupo - SigCdGcr.codigos
	this_cIClis     = ""  && Codigo da conta/cliente - SigCdCli.iclis
	this_nValors    = 0   && Valor alocado (N(15,2))
	this_nPercs     = 0   && Percentual alocado (N(9,6))

	*-- ==========================================
	*-- Propriedades de controle interno
	*-- ==========================================
	this_cChaveCompostaAnterior = ""  && Chave antes de edicao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = DODEFAULT()

			THIS.this_cTabela     = "SigCdMrp"
			THIS.this_cCampoChave = "cIdChaves"

		CATCH TO loException
			MsgErro("Erro em OrcBO.Init: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave composta para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEmps) + "+" + ;
		       ALLTRIM(THIS.this_cMes)  + "+" + ;
		       ALLTRIM(THIS.this_cAno)  + "+" + ;
		       ALLTRIM(THIS.this_cTitulo) + "+" + ;
		       ALLTRIM(THIS.this_cMoeda)
	ENDPROC

	*====================================================================
	* Buscar - Carrega cursor_4c_Dados com lista agrupada de orcamentos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cWhere = " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			IF !EMPTY(par_cFiltro)
				loc_cWhere = loc_cWhere + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
			           "MAX(cidchaves) AS cidchaves " + ;
			           "FROM SIGCDMRP" + ;
			           loc_cWhere + ;
			           " GROUP BY cemps, cmes, cano, ctitulo, moeda, nvltots" + ;
			           " ORDER BY cano, cmes, ctitulo"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
				USE IN cursor_4c_DadosTmp
				GO TOP IN cursor_4c_Dados
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar or" + CHR(231) + "amentos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEmps     = ALLTRIM(cemps)
				THIS.this_cMes      = ALLTRIM(cmes)
				THIS.this_cAno      = ALLTRIM(cano)
				THIS.this_cTitulo   = ALLTRIM(ctitulo)
				THIS.this_cMoeda    = ALLTRIM(moeda)
				THIS.this_nVlTots   = nvltots
				THIS.this_cIdChaves = ALLTRIM(cidchaves)

				THIS.this_cChaveCompostaAnterior = THIS.ObterChavePrimaria()

				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro por cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, cidchaves " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cidchaves = " + EscaparSQL(par_cChave)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodTmp")
			IF loc_nResult > 0 AND !EOF("cursor_4c_CodTmp")
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CodTmp")
				THIS.this_lNovoRegistro = .F.
			ELSE
				THIS.this_cUltimoErro = "Registro n" + CHR(227) + "o encontrado."
			ENDIF

			IF USED("cursor_4c_CodTmp")
				USE IN cursor_4c_CodTmp
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor_4c_Grupos de SigCdGcr (READWRITE)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_cSQL = "SELECT codigos, descrs, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SigCdGcr " + ;
			           "ORDER BY codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_GrpTmp INTO CURSOR cursor_4c_Grupos READWRITE
				USE IN cursor_4c_GrpTmp
				GO TOP IN cursor_4c_Grupos
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar grupos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor_4c_Contas de SIGCDCLI (READWRITE)
	*====================================================================
	PROCEDURE BuscarContas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_cSQL = "SELECT grupos, iclis, rclis, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SIGCDCLI " + ;
			           "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
			           " ORDER BY rclis"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_CtaTmp INTO CURSOR cursor_4c_Contas READWRITE
				USE IN cursor_4c_CtaTmp
				GO TOP IN cursor_4c_Contas
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar contas."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDetalhe - Popula Valor/Perc em cursor_4c_Grupos e cursor_4c_Contas
	*                   com os valores existentes no BD para o orcamento atual
	*====================================================================
	PROCEDURE CarregarDetalhe()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cGrupo, loc_cConta, loc_nValor, loc_nPerc
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cgrupos, iclis, nvalors, npercs " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")
			IF loc_nResult > 0
				SELECT cursor_4c_Detalhe
				SCAN
					loc_cGrupo = ALLTRIM(cgrupos)
					loc_cConta = ALLTRIM(iclis)
					loc_nValor = nvalors
					loc_nPerc  = npercs

					IF !EMPTY(loc_cGrupo) AND USED("cursor_4c_Grupos")
						SELECT cursor_4c_Grupos
						LOCATE FOR ALLTRIM(codigos) == loc_cGrupo
						IF FOUND("cursor_4c_Grupos")
							SELECT cursor_4c_Grupos
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF

					IF !EMPTY(loc_cConta) AND USED("cursor_4c_Contas")
						SELECT cursor_4c_Contas
						LOCATE FOR ALLTRIM(iclis) == loc_cConta
						IF FOUND("cursor_4c_Contas")
							SELECT cursor_4c_Contas
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF
				ENDSCAN

				IF USED("cursor_4c_Detalhe")
					USE IN cursor_4c_Detalhe
				ENDIF

				IF USED("cursor_4c_Grupos")
					GO TOP IN cursor_4c_Grupos
				ENDIF
				IF USED("cursor_4c_Contas")
					GO TOP IN cursor_4c_Contas
				ENDIF
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Retorna .T. se chave composta ja existe no BD
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
			IF loc_nResult > 0
				SELECT cursor_4c_DupChk
				loc_lResultado = (qtde > 0)
				USE IN cursor_4c_DupChk
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterDescricaoMoeda - Retorna SigCdMoe.dmoes para o codigo informado
	*====================================================================
	PROCEDURE ObterDescricaoMoeda(par_cCodMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResult
		loc_cDescricao = ""

		TRY
			IF !EMPTY(par_cCodMoeda)
				loc_cSQL = "SELECT dmoes FROM SigCdMoe " + ;
				           "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodMoeda))

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
				IF loc_nResult > 0 AND !EOF("cursor_4c_Moeda")
					SELECT cursor_4c_Moeda
					loc_cDescricao = ALLTRIM(dmoes)
				ENDIF
				IF USED("cursor_4c_Moeda")
					USE IN cursor_4c_Moeda
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDPROC

	*====================================================================
	* EfetuarSalvamento - Delta save de grupos e contas em SIGCDMRP
	*   Para cada grupo/conta: faz UPDATE se ja existe, INSERT se novo
	*   Para ALTERAR: deleta previamente linhas zeradas (removidas pelo usuario)
	*====================================================================
	PROTECTED PROCEDURE EfetuarSalvamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda, loc_nVlTots
		LOCAL loc_cCodigo, loc_cIdChaves, loc_cOper, loc_lOk
		loc_lResultado = .F.

		TRY
			loc_lOk     = .T.
			loc_cEmps   = EscaparSQL(ALLTRIM(THIS.this_cEmps))
			loc_cMes    = EscaparSQL(ALLTRIM(THIS.this_cMes))
			loc_cAno    = EscaparSQL(ALLTRIM(THIS.this_cAno))
			loc_cTitulo = EscaparSQL(ALLTRIM(THIS.this_cTitulo))
			loc_cMoeda  = EscaparSQL(ALLTRIM(THIS.this_cMoeda))
			loc_nVlTots = FormatarNumeroSQL(THIS.this_nVlTots)
			loc_cOper   = IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE")

			*-- Para ALTERAR: remover linhas de grupos zerados (usuario removeu do orcamento)
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor = 0 AND cursor_4c_Grupos.Perc = 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = EscaparSQL(ALLTRIM(codigos))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + loc_cCodigo + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover grupo zerado."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Para ALTERAR: remover linhas de contas zeradas
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor = 0 AND cursor_4c_Contas.Perc = 0
					SELECT cursor_4c_Contas
					loc_cCodigo = EscaparSQL(ALLTRIM(iclis))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + loc_cCodigo + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover conta zerada."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar grupos com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor <> 0 OR cursor_4c_Grupos.Perc <> 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = ALLTRIM(codigos)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           EscaparSQL("") + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar grupo " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar contas com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor <> 0 OR cursor_4c_Contas.Perc <> 0
					SELECT cursor_4c_Contas
					loc_cCodigo = ALLTRIM(iclis)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL("") + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar conta " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			IF loc_lOk
				THIS.RegistrarAuditoria(loc_cOper)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui todas as linhas do orcamento no BD
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao excluir or" + CHR(231) + "amento."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

