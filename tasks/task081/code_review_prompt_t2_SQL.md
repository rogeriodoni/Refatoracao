# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALVARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDES, DCKVEND, COMISDIVS, DCKVEND2, DCKORI, DCKDEST, TRANSS, XVLR, PTPALIGN, 1, MARCA, EMPS, DOPES, DATAS, NUMES, IMPRESS, EMPDOPNUMS, DCKRITEI, SUBNS, DCKCOEF, DCKLINAD, SOMAPESO, CPROS, CTITS, LNITEM2S, LNCOUNT, CORES, TAMS, TOT_QTDENT, DCKDSCCPS, NTOTAL, DCKPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKDEVO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDES, DCKVEND, COMISDIVS, DCKVEND2, DCKORI, DCKDEST, TRANSS, XVLR, PTPALIGN, 1, MARCA, EMPS, DOPES, DATAS, NUMES, IMPRESS, EMPDOPNUMS, DCKRITEI, SUBNS, DCKCOEF, DCKLINAD, SOMAPESO, CPROS, CTITS, LNITEM2S, LNCOUNT, CORES, TAMS, TOT_QTDENT, DCKDSCCPS, NTOTAL, DCKPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKACRES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDES, DCKVEND, COMISDIVS, DCKVEND2, DCKORI, DCKDEST, TRANSS, XVLR, PTPALIGN, 1, MARCA, EMPS, DOPES, DATAS, NUMES, IMPRESS, EMPDOPNUMS, DCKRITEI, SUBNS, DCKCOEF, DCKLINAD, SOMAPESO, CPROS, CTITS, LNITEM2S, LNCOUNT, CORES, TAMS, TOT_QTDENT, DCKDSCCPS, NTOTAL, DCKPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCKDESCO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDES, DCKVEND, COMISDIVS, DCKVEND2, DCKORI, DCKDEST, TRANSS, XVLR, PTPALIGN, 1, MARCA, EMPS, DOPES, DATAS, NUMES, IMPRESS, EMPDOPNUMS, DCKRITEI, SUBNS, DCKCOEF, DCKLINAD, SOMAPESO, CPROS, CTITS, LNITEM2S, LNCOUNT, CORES, TAMS, TOT_QTDENT, DCKDSCCPS, NTOTAL, DCKPESO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDES, DCKVEND, COMISDIVS, DCKVEND2, DCKORI, DCKDEST, TRANSS, XVLR, PTPALIGN, 1, MARCA, EMPS, DOPES, DATAS, NUMES, IMPRESS, EMPDOPNUMS, DCKRITEI, SUBNS, DCKCOEF, DCKLINAD, SOMAPESO, CPROS, CTITS, LNITEM2S, LNCOUNT, CORES, TAMS, TOT_QTDENT, DCKDSCCPS, NTOTAL, DCKPESO

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
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
SELECT TmpRel
	Select TmpEstPe
	Select TmpRel
	if seek(TmpRel.Dopes,"CrTmpOpe","DOPES")
			Select TmpRel
	Select TmpRel
	Select TmpRel
	if seek(TmpRel.Dopes,"CrTmpOpe","DOPES")
		Select TmpPag
	Select TmpRel
lcQuery = [ Select 0 as Marca, cEmps, Razas From SigCdEmp ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crEmpsT') < 1)
Select * from CrEmpsT where 1 = 0 Into Cursor crEmps ReadWrite
Select crEmpsT
		Insert into crEmps From Memvar
Thisform.GrdEmp.Column1.ControlSource = 'crEmps.Marca'
Thisform.GrdEmp.Column2.ControlSource = 'crEmps.cEmps'
Thisform.GrdEmp.Column3.ControlSource = 'crEmps.Razas'
Select crEmps 
Select TmpRelat
Select TmpRelat
Select TmpRel
Select TmpRelat
lcQuery = [Select * From SigCdOpe ]
If ThisForm.Podatamgr.SqlExecute(lcQuery,'CrTmpOpe') < 1
Select CrTmpOpe
lcQuery = [Select * From SigOpCdc ]
If ThisForm.Podatamgr.SqlExecute(lcQuery,'CrTmpDcOpe') < 1
Select CrTmpDcOpe
lcQuery = [Select * From SigOpTdz ]
If ThisForm.Podatamgr.SqlExecute(lcQuery,'CrTmpTabD') < 1
lcQuery = [Select * From SigCdPam ]
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrTmpParam') < 1
lcQuery = [Select * From SigCdPac ]
If ThisForm.Podatamgr.SqlExecute(lcQuery,'CrTmpParac') < 1
Select * From crEmps Where Marca = 1 Into Cursor csCemps
Select csCemps
	lcSql = [Select Emps,Dopes,Numes,EmpDopNums From SigMvCab Where Emps = ']+lcEmp+[' And Dopes = ']+lcDp+[' ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'TprMvCab') < 1
	Select TprMvCab
		loBarra.Update(.T.,pEmp +' - ' + pDop + ' -  ' + Str(pNum,6))
		lcSql = [Select * From SigMvPec Where EmpDopNums = ']+TprMvCab.EmpdopNums+[']
		If ThisForm.Podatamgr.SqlExecute(lcSql,'CrTmpEstPe') < 1
		Select a.Codigos, Nvl(b.Dopes, 0) As cDopes, Nvl(b.Abrevs,'') As cAbrevs ;
			From CrTmpEstPe a;
			Left Join CrTmpOpe b On b.NDopes = Val( Left( Str( a.Codigos, 10 ), 4 ) ) ;
			Select c.Emps, c.Dopes, c.Numes, c.Usuars, c.GrVends, c.Valos, c.ValInis, ;
				From CrTprMvCab c ;
					Left Join CrTmpOpe o   On c.Dopes == o.Dopes ;
					Left Join CrTmpTabd d  On c.Tabds == d.Codigos ;
					Left Join CrTmpdcOpe p  On c.Dopes == p.Dopes ;
					left Join CrTprMvCabi i On c.Emps+c.Dopes+Str(c.Numes,6) == i.Emps+i.Dopes+Str(i.Numes,6) ;
			Select i.cItens, i.Qtds - Iif(pItPendente,i.QtBaixas,0) as Qtds, i.CodEmbs, i.CodTams, i.CodCors, i.QtdEmbs, i.QtdEnts, i.CodEmbEnts, ;
					From crTmpEsti2 i ;
			Select c.Acres,   c.ContaDs, c.ContaOs, c.Datas,   c.Dopes, c.Emps,    c.EmpDs, ;
				From CrTprMvCab c ;
					Left Join CrTmpOpe   o On c.Dopes == o.Dopes ;
					Left Join CrTmpTabd  d On c.TabDs == d.Codigos ;
					Left Join CrTmpDcope p on c.Dopes == p.Dopes ;
					Left Join CrTprMvCabi i On c.Emps+c.Dopes+Str(c.Numes,6) == i.Emps+i.Dopes+Str(i.Numes,6) ;
					Left Join CrTmpEsti2 j On i.Emps + i.Dopes + Str(i.Numes,6) + Str(i.CItens,4) = j.Emps + j.Dopes + Str(j.Numes,6) + Str(j.CItens,4) ;
			Select * from TmpRelPi Where 1 = 0 Into Cursor TmpRelP ReadWrite
			Select TmpRelP 
			Select TmpRelPi
				If !Seek(lcSeek,'TmpRelP','IdxTmpRelP') 
					Insert into TmpRelP from Memvar 
			Select TmpRelP
			Create Cursor TmpRel From Array laCampos
			Select TmpRelP
				Insert Into TmpRel From MemVar
					Insert Into TmpRel2 From Memvar
		Select TmpRel2
			Select TmpRel
					Select TmpRel2
		Select TmpEstPe
		Select TmpRel
		=Seek( TmpRel.Dopes, 'CrTmpOpe'  , 'Dopes' )
		=Seek(TmpRel.Dopes,'CrTmpDcOpe','Dopes')
			Select Cpros,cItens,Sum(Qtds) as Qtds From TmpRel Group by Cpros,cItens Into cursor wEesti
			Select wEesti
				Select CrCompo
					Select TmpResIte
					If Not Seek(wEesti.Cpros + CrCompo.Mats + Str(wEesti.cItens,4))
		Select crBranco
		Append Memo Branco From (lcFigJpg) Overwrite
		Select TmpRel
				Select TmpRel2
				Select TmpRel
					If Not IsEmpty( TmpRel.nCodigos ) And Seek( TmpRel.nCodigos, 'TmpEstPe', 'Codigos' )
					Select xtotite
						if !seek( TmpRel.Moedas )
							insert into xtotite ( xmoeda ) values ( TmpRel.Moedas )
						if !seek( TmpRel.MoeFats )
							insert into xtotite ( xmoeda ) values ( TmpRel.MoeFats )
					Select TmpRel
					lcSql = [Select Resps From SigCdPft Where Cpros = ']+TmpRel.Cpros+[' And ctits = ']+CrTmpDcope.ctits+[']
					ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpProft')
					Select TmpProft
							Select TmpRel2
					Select TmpRel2
						Select TmpRel2
						If Seek( Str(TmpRel.CItens,4) )
					Select TmpRel
					Select TmpResIte
					=Seek(TmpRel.Cpros)
				Insert Into TmpRelat (Numes, Tipo, TITULO, LINHA, LINHANEG, CDETALHE, IDETALHE, IDETALHED, ;
			Select TmpRel
			Select TmpRel
				Insert INTO TMPRELAT (Numes,TIPO,TITULO,LINHA,LINHANEG,CDETALHE,IDETALHE,IDETALHED,;
		Select TmpRel
				select xtotite
				select TmpRel
			Select TmpPag
			Select Cmats, Cunis, sum(Qtds) as Qtds, Sum(QtScons) as QtScons From TmpResIte Group By 1,2 Into Cursor TmpResumo
			Select TmpResumo
		SELECT CrTprMvCab
			SELECT CrTmpCli
			SELECT CrTmpCli
		INSERT INTO TMPRELAT (Numes,TIPO,TITULO,LINHA,LINHANEG,CDETALHE,IDETALHE,IDETALHED,IDETALHEO,FINALIZA,;
Select TmpRelat
Select TmpRelat
		lcQuery = [ Select a.Ndopes, b.chkImpDoc ] + ;
				    [ From SigCdOpe a, SigOpCdc b ]+ ;
		If (ThisForm.PODatamgr.SqlExecute(lcQuery, [crSigCdOpeD]) < 1)
Select crEmps
Select crEmps

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredoc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1232 linhas total):

*-- Linhas 313 a 331:
313:             .FontSize         = 8
314:             .AllowHeaderSizing = .F.
315:             .AllowRowSizing   = .F.
316:             .DeleteMark       = .F.
317:             .HeaderHeight     = 16
318:             .RowHeight        = 16
319:             .ScrollBars       = 2
320:             .GridLineColor    = RGB(238, 238, 238)
321:             .RecordSource     = ""
322:             .Themes           = .F.
323:             .Visible          = .T.
324: 
325:             *-- Column1: CheckBox para Marca
326:             WITH .Column1
327:                 .Width     = 15
328:                 .Movable   = .F.
329:                 .Resizable = .F.
330:                 .Sparse    = .F.
331:                 .Header1.Caption   = ""

*-- Linhas 777 a 797:
777: 
778:                     loc_oGrd.RecordSource = loc_oCursor
779:                     WITH loc_oGrd
780:                         .Column1.ControlSource    = loc_oCursor + ".Marca"
781:                         .Column2.ControlSource    = loc_oCursor + ".cEmps"
782:                         .Column3.ControlSource    = loc_oCursor + ".Razas"
783:                         .Refresh()
784:                     ENDWITH
785:                 ELSE
786:                     MsgErro("Falha ao carregar lista de empresas.", "CarregarEmpresas")
787:                 ENDIF
788:             ENDIF
789:         CATCH TO loc_oErro
790:             MsgErro(loc_oErro.Message, "CarregarEmpresas")
791:         ENDTRY
792:     ENDPROC
793: 
794:     *--------------------------------------------------------------------------
795:     * LimparCampos - Inicializa filtros com valores padrao
796:     *--------------------------------------------------------------------------
797:     PROCEDURE LimparCampos()

*-- Linhas 975 a 1013:
975:             IF VARTYPE(THIS.this_oRelatorio) = "O"
976:                 loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
977:                 IF USED(loc_oCursor)
978:                     SELECT (loc_oCursor)
979:                     REPLACE ALL Marca WITH 1
980:                     GO TOP
981:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
982:                 ENDIF
983:             ENDIF
984:         CATCH TO loc_oErro
985:             MsgErro(loc_oErro.Message, "CmdSelecionarTodas")
986:         ENDTRY
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     * CmdDesmarcarTodasClick - Desmarca todas as empresas (Marca=0)
991:     *--------------------------------------------------------------------------
992:     PROCEDURE CmdDesmarcarTodasClick()
993:         LOCAL loc_oCursor, loc_oErro
994:         TRY
995:             IF VARTYPE(THIS.this_oRelatorio) = "O"
996:                 loc_oCursor = THIS.this_oRelatorio.this_cCursorEmpresas
997:                 IF USED(loc_oCursor)
998:                     SELECT (loc_oCursor)
999:                     REPLACE ALL Marca WITH 0
1000:                     GO TOP
1001:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
1002:                 ENDIF
1003:             ENDIF
1004:         CATCH TO loc_oErro
1005:             MsgErro(loc_oErro.Message, "CmdDesmarcarTodas")
1006:         ENDTRY
1007:     ENDPROC
1008: 
1009:     *--------------------------------------------------------------------------
1010:     * BtnVisualizarClick - Preview do relatorio na tela
1011:     *--------------------------------------------------------------------------
1012:     PROCEDURE BtnVisualizarClick()
1013:         LOCAL loc_oErro, loc_lContinuar, loc_cDopes

