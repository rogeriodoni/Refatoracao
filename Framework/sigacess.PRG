********************************************************************************************
Function fRestritos(pGrO, pGrD, pCnx) as Boolean

Local lnSel, llRet, lcQry, lnErr

lnSel = Select(0)
llRet = .t.

If ((Type([pGrO])=[C]) And Not Empty(pGrO)) And ((Type([pGrD])=[C]) And Not Empty(pGrD))
	 = [SQL] + Sys(2015)

	lcQry = [Select * From SigCdRps Where GrupoOs = '] + Padr(pGrO, 10) + [']
	lnErr = pCnx.SQLExecute(lcQry, [crAr1])
	If (lnErr < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fRestritos 1)])
	Else
		Go Top In crAr1
	EndIf

	If (lnErr > 0) And Not Eof([crAr1])
		Use In crAr1
		lcQry = [Select * From SigCdRps Where GrupoOs = '] + pGrO + [' And GrupoDs = '] + pGrD + [']
		lnErr = pCnx.SQLExecute(lcQry, [crAr1])
		If (lnErr < 1)	
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fRestritos 2)])
		Else
			Go Top In crAr1
		EndIf

		If (lnErr > 0) And Eof([crAr1])
			llRet = .f.
		EndIf
		Use In crAr1
	EndIf
EndIf

If (lnSel > 0)
	Select (lnSel)
EndIf

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fChecaAcesso(pPrg, pPar, pMsg, pUsu, pTot) as Logical

Local llRet, lnAli, loCnx, llTot, lcUsu, lnCka, lnErr

pPar = Padr(Iif(Type([pPar]) = [C], pPar, []), 10)
pPrg = Upper(Padr(pPrg, 15))

lcUsu = Upper(Iif(Type([pUsu]) = [C], pUsu, Usuar))
lnAli = Select()
llRet = .f.
lnErr = 1

If Not (Type([gcTipoUsuario]) = [C] And Substr(gcTipoUsuario, 2) = lcUsu)
	loCnx = CreateObject([fSqlConector])
	lnErr = Iif(loCnx.pnIdConn > 0, 1, -1)
	If Used([crAc1])
		Use In ([crAc1])
	EndIf
	Public gcTipoUsuario
	lcImp = Iif(Upper(Alltrim(lcUsu)) = [4CONTROL], [i], [n])
	gcTipoUsuario = (lcImp + lcUsu)
	llTot = (Not pTot And InList(Left(gcTipoUsuario, 1), [i], [s]))
EndIf

If Left(gcTipoUsuario, 1) = [i] And Not pTot
	llRet = .t.
Else
	If Not (Type([gaAcesso]) = [U])
		If (Type([pUsu]) = [C])
			If (Type([loCnx]) <> [O])
				loCnx = CreateObject([fSqlConector])
				lnErr = Iif(loCnx.pnIdConn > 0, 1, -1)
			EndIf
			
			If (lnErr > 0)
				lcQry = [Select a.Programas, a.Parametros ] + ;
						  [From SigCdAcu a ] + ;
						 [Where Not a.Programas = '               ' And a.Usuarios = '] + lcUsu + [' ] + ;
						 [Group By a.Programas, a.Parametros ] + ;
						 [Union All ] + ;
						[Select a.Programas, a.Parametros ] + ;
						  [From SigCdAcu a ] + ;
						  [Left Outer Join SigCdAcg b On a.Grupos = b.Grupos ] + ;
						 [Where Not a.Programas = '               ' And b.Usuarios = '] + lcUsu + [' ] + ; 
						 [Group By a.Programas, a.Parametros ] + ;
						 [Order By 1, 2]

				lnErr = loCnx.SQLExecute(lcQry, [crTmpAc])
			EndIf
			
			If (lnErr > 0) And Used([crTmpAc])
				Select crTmpAc
				Go Top In crTmpAc
				Locate For Programas = pPrg And Parametros = pPar
				llRet = Not Eof([crTmpAc])
			EndIf
		Else
			lnCka = Ascan(gaAcesso, pPrg + pPar)
			llRet = (lnCka > 0 And lnCka <= Alen(gaAcesso, 1) And gaAcesso(lnCka, 1) = (pPrg + pPar))
		EndIf
	Else
		llRet = .f.
	EndIf
EndIf
Select Int(lnAli)

If (Type([loCnx]) = [O])
	loCnx.Release
	Release loCnx
EndIf

If pMsg And Not llRet
	=Messagebox([Usuário Sem Permissão Para Esse Acesso!!!], 0+64, [Checagem de Acessos])
Endif

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fChecaAcessoJOB (pUsu, pJob, pCnx) as Logical
	Local llRet

	llRet = .t. 

	If Not Empty(pUsu) And Not Empty(pJob)
		lcQuery = [Select Usuars ] + ;
				    [From SigCdAcJ ] + ;
				   [Where Jobs = '] + Padr(pJob, 10) + [']

		If (pCnx.SqlExecute(lcQuery, [crfAcJOB1]) < 1)
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (crfAcJOB1)])
			Return .f.
		EndIf		
		Select crfAcJOB1
		Go Top In crfAcJOB1
		If Not Eof([crfAcJOB1])
			llRet = .f.
			Locate For Usuars = Padr(pUsu, 10)
			If Not Eof([crfAcJOB1])
				llRet = .t.
			EndIf
		EndIf
		Use In crfAcJOB1
	EndIf

	Return llRet
EndFunc
********************************************************************************************


********************************************************************************************
Function fAcessoContas(pUsu, pGrp, pTip, pTxt, pSt1, pSt2, pInd, pGrc, pCnx, pLik, pNot, pFil, pLpz, pNtp, pDig) as Boolean 
	Local lcEsc, llRet, lcCta, llRst, llTot, lnSel, llOpn, laFil, lcCpo, lcInf, loCnx, lcTab, loLst
	
	If (Type([pCnx]) = [O])
		llOpn = .f.
		loCnx = pCnx
	Else
		llOpn = .t.
		loCnx = CreateObject([fSqlConector])
	EndIf

	pUsu = Padr(Iif(Type([pUsu]) = [C], pUsu, []), 10)
	pGrp = Padr(Iif(Type([pGrp]) = [C], pGrp, []), 10)
	pTip = Upper(Iif(Type([pTip]) = [C] And InList(pTip, [C], [D]), pTip, [C]))
	pTxt = Iif(Type([pTxt]) = [C], pTxt, [])
	pFil = Iif(Type([pFil]) = [C], pFil, [])
	pInd = Iif(Type([pInd]) = [L], pInd, .f.)
	pNot = Iif(Type([pNot]) = [L], pNot, .f.)
	pGrc = Iif(Type([pGrc]) = [C], pGrc, pGrp)
	pDig = Iif(Type([pDig]) = [C], Alltrim(pDig), [])
	pLik = goSistema.BuscaP

	lcCpo = Alltrim(Iif(Type([pLpz])=[C], pLpz, goSistema.BuscaNome))
	llRet = Empty(pTxt)
	lcCta = Space(10)
	lnSel = Select(0)
	lcEsc = Set([Escape])
	llRst = .f.
	llTot = .f.
	lnErr = Iif(loCnx.pnIdConn > 0, 1, -1)
	lcInf = Iif(Empty(pDig), [], [ a.Grupos In (Select Codigos From SigCdGcr Where Classes In (Select Classes From SigCdCss Where Substring(Classes, 1, 1) = '] + pDig + [')) And ])
	Set Escape Off

	If (lnErr > 0)
		lnErr = loCnx.SQLExecute([Select * From SigCdPac], [crPac1])
		If Type([crPac1.BuscaNome])=[N] And crPac1.BuscaNome = 2
			pLik = .T.
		EndIf 
	EndIf	
	
	If Used([crAc1])
		Use In ([crAc1])
	EndIf
	If (lnErr > 0)
		lnErr = loCnx.SQLExecute([Select a.Usuarios, a.Supervis From SigCdUsu a Where a.Usuarios = '] + pUsu + ['], [crAc1])
	EndIf

	If Used([crAc1])
		Select crAc1
		Go Top In crAc1
		llTot = (Not Eof([crAc1]) And (Upper(crAc1.Usuarios) = [4CONTROL]))
	EndIf
	
	lcQry = [Select Distinct a.GrContbs, a.GrContas, a.CdContas ] + ;
			  [From SigSyAgc a ] + ;
			  [Left Join SigCdAcG b On b.Grupos = a.GrAcess And b.Usuarios = '] + pUsu + [' ] + ;
			 [Where (a.UsuAcess = '] + pUsu + [' Or b.Usuarios = '] + pUsu + [') ] + ;
			 [Order By 1]
			 
	If (lnErr > 0)
		If Used([crAc2])
			Use In crAc2
		EndIf
		lnErr = loCnx.SQLExecute(lcQry, [crAc2])
	EndIf

	lcQry = [Select Distinct a.GrContas, a.CdContas ] + ;
			  [From SigSyAcc a ] + ;
			  [Left Join SigCdAcG b On b.Grupos = a.GrAcess And b.Usuarios = '] + pUsu + [' ] + ;
			 [Where (a.UsuAcess = '] + pUsu + [' Or b.Usuarios = '] + pUsu + [') ] + ;
	         [Order By 1]
	         
	If (lnErr > 0)
		If Used([crAc3])
			Use In crAc3
		EndIf
		lnErr = loCnx.SQLExecute(lcQry, [crAc3])
	EndIf

	*** Mena - 25/10/2017 - inclui conta contabil para checar acesso ***
	SELECT GrContas, CdContas from crAc3 union (select GrContbs, CdContas from crAc2 where cdContas <> ' ' and GrContbs = pGrp) into cursor crAc3 readwrite
	 
	If Used([crAc3])
		Select crAc3
		Index On GrContas + CdContas Tag Ordem
	EndIf
	llRst = ((Used([crAc3]) And Reccount([crAc3]) = 0) Or llTot) 

	If Not llRet
		If (Type([pSt1]) = [O] Or Type([pSt2]) = [O])
			laFil = .f.
			If pInd
				If pLik
					laFil = ([Grupos = '] + pGrc + [' And ] + Iif(pTip = [C], [IClis], lcCpo) + [ Like '%] + Alltrim(pTxt) + [%'])
					pNot = .t.
				Else 
					laFil = [Grupos = '] + pGrc + [']
				EndIf
			Else 
				If pLik
					laFil = Iif(pTip = [C], [IClis], lcCpo) + [ Like '%] + Alltrim(pTxt) + [%']
					pNot = .t.
				EndIf 
			EndIf 
			
			If Not Empty(pFil)
				If Not Type([laFil]) = [C]
					laFil = [1=1]
				EndIf 
				laFil = laFil + [ And ] + Alltrim(pFil)
			EndIf 

			lcTab = [SigCdCli a ] + ;
					[Inner Join SigCdGcr b On a.Grupos = b.Codigos And ] + lcInf + ;
					[(Not b.Coletors = 10 Or ] + ;
					[(b.Coletors = 10 And ] + ;
					Iif(Empty(pGrp), [], [a.Grupos = '] + Padr(pGrp, 10) + [' And ]) + ;
					[a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c Where ] + ;
					[c.Jobs  Not In (Select Distinct d.Jobs From SigCdAcJ d Where ] + ;
					[d.Usuars = '] + Usuar + ['))))]
			
			If (Type([pNtp]) = [N])		
				lcTab = [SigCdCli a Inner Join SigCdGcr b On a.Grupos = b.Codigos And ] + lcInf +;
						[b.Coletors = ] + Alltrim(Str(pNtp)) + [ And ] + ;
						[a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c Where ] + ;
						[c.Jobs  Not In (Select Distinct d.Jobs From SigCdAcJ d Where ] + ;
						[d.Usuars = '] + Usuar + [')) ] + ;
						Iif(pNtp = 10 And Not Empty(pGrp), [And a.Grupos = '] + Padr(pGrp, 10) + ['], [])
			EndIf

			If (pTip = [C])
				loLst = CreateObject([fwBuscaExt], loCnx.pnIdConn, lcTab, [crAc4], [IClis], pTxt, [Contas], 1000, .f., ;
									 @laFil, pNot, .f., [a.IClis, a.] + lcCpo + [, a.Grupos, a.Situas, a.Cpfs, a.Inativas, a.ContaMats])
				If Not loLst.plAchouRegistro
					loLst.mAddColuna([IClis], Replicate([x], 10), [Código],    .t.)
					loLst.mAddColuna(lcCpo,   Replicate([x], 50), [Descrição], .t.)
					loLst.mAddColuna([Grupos],Replicate([x], 10), [Grupo],     .f.)
					loLst.mAddColuna([Cpfs],  Replicate([x], 20), [CPF/CNPJ],  .f.)
					loLst.mAddColuna([Situas],Replicate([x], 08), [Situação],  .f.)
					If goSistema.Matrizes
						loLst.mAddColuna([ContaMats], Replicate([x], 10),[M/F],.f.)
					EndIf
					loLst.mAddColuna([Inativas], .f., .f., .f., .f., .f., .t.)
					loLst.GridProc.SetAll([DynamicForeColor], [Iif(crAc4.Inativas=1, Rgb(255,0,0), Rgb(0,0,0))], [Column])
					loLst.Show()
				EndIf
			Else
				loLst = CreateObject([fwBuscaExt], loCnx.pnIdConn, lcTab, [crAc4], lcCpo, pTxt, [Contas], .t., .f., ;
									 @laFil, pNot, .f., [a.IClis, a.] + lcCpo + [, a.Grupos, a.Situas, a.Cpfs, a.Inativas, a.ContaMats])
				If Not loLst.plAchouRegistro
					loLst.mAddColuna(lcCpo,   Replicate([x], 50), [Descrição], .t.)
					loLst.mAddColuna([IClis], Replicate([x], 10), [Código],    .t.)
					loLst.mAddColuna([Grupos],Replicate([x], 10), [Grupo],     .f.)
					loLst.mAddColuna([Cpfs],  Replicate([x], 20), [CPF/CNPJ],  .f.)
					loLst.mAddColuna([Situas],Replicate([x], 08), [Situação],  .f.)
					If goSistema.Matrizes
						loLst.mAddColuna([ContaMats], Replicate([x], 10),[M/F],.f.)
					EndIf
					loLst.mAddColuna([Inativas], .f., .f., .f., .f., .f., .t.)
					loLst.GridProc.SetAll([DynamicForeColor], [Iif(crAc4.Inativas=1, Rgb(255,0,0), Rgb(0,0,0))], [Column])
					loLst.Show()
				EndIf
			EndIf
			If (Type([pSt1]) = [O])
				pSt1.Value = Evaluate([crAc4.IClis])
				pSt1.Refresh
			EndIf
			If (Type([pSt2]) = [O])
				pSt2.Value = Evaluate([crAc4.&lcCpo.])
				pSt2.Refresh
			EndIf
		Else
			lcQry = [Select a.IClis, a.Grupos ] + ;
					  [From SigCdCli a ] + ;
					 [Where ] + Iif(pInd, [a.Grupos = '] + pGrc + [' And ], []) + [a.IClis = '] + pTxt + [']

			If (lnErr > 0)
				If Used([crAc4])
					Use In crAc4
				EndIf
				lnErr = loCnx.SQLExecute(lcQry, [crAc4])
			EndIf
		EndIf

		If (Used([crAc4]) And Not Eof([crAc4]))
			llRet = (llTot Or llRst)
			lcCta = crAc4.IClis

			If Not llRet
				If Used([crAc2])
					Select crAc2
					Set Order To ''
					Locate For crAc2.GrContbs = pGrp
				EndIf
				If (Empty(pGrp) Or (Used([crAc2]) And (Eof([crAc2]) Or Empty(crAc2.GrContas + crAc2.CdContas))))
					llRet =  (Not Eof([crAc4]) And crAc4.IClis = lcCta And (Seek(Space(10) + crAc4.Iclis, [crAc3], [Ordem]) Or ;
							  Seek(crAc4.Grupos + crAc4.IClis, [crAc3], [Ordem]) Or Seek(crAc4.Grupos + Space(10), [crAc3], [Ordem])))
				Else
					Select crAc2
					Set Order To ''
					Locate For crAc2.GrContbs = pGrp
					Scan While (llRet = .f. And crAc2.GrContbs = pGrp)
						Do Case
							Case Not Empty(crAc2.CdContas)
							     llRet = (crAc2.CdContas = lcCta)
							Case (Not Empty(crAc2.GrContas) And Empty(crAc2.CdContas))
								Select crAc4
								Set Order To ''
								Locate For (crAc4.Grupos = crAc2.GrContas And crAc4.IClis = lcCta)
								llRet = Not Eof([crAc4])
						EndCase
					EndScan
				EndIf
			EndIf
		EndIf
	Else
		If (Type([pSt1]) = [O])
			pSt1.Value = []
			pSt1.Refresh
		EndIf
		If (Type([pSt2]) = [O])
			pSt2.Value = []
			pSt2.Refresh
		EndIf
		llRet = llRst
	EndIf

	If llRet And Not Empty(lcCta)
		If Used([crAc4])
			Use In crAc4
		EndIf
		If (lnErr > 0)
			lnErr = loCnx.SQLExecute([Select a.IClis, a.Grupos, a.Vinculas From SigCdCli a Where a.IClis = '] + lcCta + [' Order By 1], [crAc4])
		EndIf
		If Used([crAc4])
			Select crAc4
			Set Order To ''
			Go Top In crAc4
			If (crAc4.Vinculas = 1)
				llRet = (crAc4.Grupos = pGrp Or (Not Empty(goSistema.Transitorio) And goSistema.Transitorio = pGrp) Or Empty(pGrp))
			EndIf
		EndIf
	EndIf 
	If Used([crAc1])
		Use In crAc1
	EndIf
	If Used([crAc2])
		Use In crAc2
	EndIf
	If Used([crAc3])
		Use In crAc3
	EndIf
	If Used([crAc4])
		Use In crAc4
	EndIf
	If llOpn And (Type([loCnx]) = [O])
		loCnx.Release
		Release loCnx
	EndIf
	If (lnSel > 0)
		Select (lnSel)
	EndIf
	Set Escape &lcEsc.

	Return llRet
EndFunc
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoTitulo (pUsu, pTxt, pObj, pCnx) as Boolean 
Private lcEsc, llRet, loLst, llTot, llClr, lcMov, lnSel, loLst

pUsu = Padr(Iif(Type([pUsu]) = [C], pUsu, []), 10)
pTxt = Padr(Iif(Type([pTxt]) = [C], pTxt, []), 20)

lnSel = Select(0)
llRet = Empty(pTxt)
lcMov = Space(20)
lcEsc = Set([Escape])
lnSel = Select(0)
llClr = .f.

pCnx.SqlExecute([Select * From SigOpOpe], [crAr1])
Select crAr1

If Not llRet
	Set Escape Off
	llTot = (Upper(pUsu) = [4CONTROL])
	Set Step On 
	If llTot 
		pCnx.SqlExecute([Select Distinct Dopes, Ordes From SigOpOpe Order By 1], [crAr3])
	Else
		pCnx.SqlExecute([Select Distinct Dopes, Ordes, NDopes, 'C'+REPLICATE('0',8-LEN(NDopes))+ltrim(rtrim(CONVERT(varchar(3),NDopes))) as acesso From SigOpOpe], [crAr1])
		
		pCnx.SqlExecute([Select Distinct Usuarios, Grupos From SigCdAcG Where Usuarios = '] + pUsu + ['], [crAr2])

		pCnx.SqlExecute([Select Grupos, Usuarios, Programas From SigCdAcU], [crAr4])

		Select Distinct b.Dopes, b.Ordes ;
		  From crAr4 a ;
		  Left Join crAr2 c On c.Grupos + c.Usuarios = a.Grupos + pUsu ;
		 Right Join crAr1 b On b.acesso = a.Programas ;
		 Where (llTot Or a.Usuarios = pUsu Or c.Usuarios = pUsu) ;
		 Order By 1;
		  Into Cursor crAr3
	EndIf
	
	Select crAr3
	Index On Dopes Tag Dopes
	Set Escape &lcEsc.

	If (Type([pObj]) = [O])
	   Set Near On
	   If Not Seek(pTxt, [crAr3], [Dopes])
			loLst = CreateObject([fwBuscaInt], [crAr3], [Dopes], pTxt, [Titulos], .t.)
			loLst.mAddColuna([Dopes], Replicate([x], 20), [Movimentção], .t.)
			loLst.Show		
			llClr = (Lastkey() = 27)
		EndIf
		Set Near Off
	Else	
		=Seek(pTxt, [crAr3], [Dopes])
	EndIf	
	lcMov = crAr3.Dopes
	llRet = (Not Eof([crAr3]) And Not Empty(lcMov))
	If (Type([pObj]) = [O])
		pObj.Value = Iif(llClr, [], crAr3.Dopes)
		pObj.Refresh
	EndIf
Else
	If (Type([pObj]) = [O])
		pObj.Value = []
		pObj.Refresh
	EndIf
EndIf

If Used([crAr3])
	Use In crAr3
EndIf

If (lnSel > 0)
	Select (lnSel)
EndIf

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoMovmto (pUsu, pOpe, pObj, pCnx) as Boolean
Local llOpn, llLpa, llRet, lcDop, llTot, lcQuery, lnSQLErr, ;
		lcSQL1, lcVer

pUsu = Padr(Iif(Type('pUsu')='C', pUsu, ''), 10)
pOpe = Padr(Iif(Type('pOpe')='C', pOpe, ''), 20)

llLpa = .f.
llRet = (Empty(pUsu) Or Empty(pOpe))
lcDop = Space(20)
lnArq = Select()
llOpn = .f.

If llRet
	If (Type([pObj]) = [O])
		pObj.Value = []
		pObj.Refresh
	EndIf
Else
	If (Type([pCnx]) <> [O])
		llOpn = .t.
		pCnx = CreateObject([fSqlConector], [Sige])
	EndIf
	
	pCnx.SQLExecute([Select Supervis From SigCdUsu Where Usuarios = '] + pUsu + ['], [crAr1])
	
	Select crAr1
	Go Top In crAr1
	llTot = (Upper(pUsu) = [4CONTROL])
	
	If llTot
		pCnx.SQLExecute([Select Dopes, Ordes From SigCdOpe Order By 1], [crAr4])
	Else 
		lcQry = [Select a.Dopes, a.Ordes ] + ;
				  [From SigCdOpe a ] + ;
				 [Where Str(a.NDopes, 16, 0) In ] + ;
				 	   [(Select Distinct Str(Cast(a.Programas as Numeric(16, 0)), 16, 0) as NDopes ] + ;
				  [From SigCdAcU a ] + ;
				 [Where a.Programas Like '0%' And IsNumeric(a.Programas) = 1 And a.Usuarios = '] + pUsu + [') ] + ;
				 [Order By 1]
		pCnx.SQLExecute(lcQry, [crAr2])

		lcQry = [Select Distinct Str(Cast(a.programas as Numeric(16, 0)), 16, 0) as NDopes ] + ;
				  [From SigCdAcU a ] + ;
				 [Inner Join SigCdAcG c On c.Grupos = a.Grupos And c.Usuarios = '] + pUsu + ['] + ;
				 [Where a.Programas Like '0%' And IsNumeric(a.Programas) = 1 And a.Usuarios = Space(10)]
		pCnx.SQLExecute(lcQry, [crAr5])

		lcQry = [Select Dopes, Ordes, Str(Ndopes, 16, 0) as NDopes From SigCdOpe]
		pCnx.SQLExecute(lcQry, [crAr6])

		Select a.Dopes, a.Ordes ;
		  From crAr6 a ;
		 Where a.NDopes In (Select b.NDopes From crAr5 b) ;
		  Into Cursor crAr3 ;
		 Order By 1
		
		Select a.* From crAr2 a ;
		 Union All ;
		Select a.* From crAr3 a ;
		  Into Cursor crAr4 Readwrite
	EndIf 

	Select crAr4
	Index On Dopes Tag Dopes

	If (Type([pObj]) = [O])
		Set Near On
		If Not Seek(pOpe, [crAr4], [Dopes])
			loLst = CreateObject([fwBuscaSel], [crAr4], [Dopes], pOpe, [Movimentações])
			loLst.AddColuna([Dopes], Replicate([x], 20), [Movimentação], .t., [Dopes])
			loLst.AddColuna([Ordes], [999], [])
			loLst.Show
			llLpa = (Lastkey()=27)
		EndIf
		Set Near Off
	Else
		=Seek(pOpe, [crAr4], [Dopes])
	EndIf	

	lcDop = crAr4.Dopes
	llRet = (Not Eof([crAr4]) And Not Empty(lcDop))

	If (Type([pObj]) = [O])
		pObj.Value = Iif(llLpa, [], lcDop)
		pObj.Refresh
	EndIf
EndIf

If Used([crAr1])
	Use In crAr1
EndIf
If Used([crAr2])
	Use In crAr2
EndIf 
If Used([crAr3])
	Use In crAr3
EndIf 
If Used([crAr4])
	Use In crAr4
EndIf
If Used([crAr5])
	Use In crAr5
EndIf
If Used([crAr6])
	Use In crAr6
EndIf

If (lnArq > 0)
	Select Int(lnArq)
EndIf

If llOpn And (Type([pCnx])=[O])
	pCnx.Release
	Release pCnx
EndIf

Return (llRet)
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoMovInd (pUsu, pOpe, pObj, pCnx) as Boolean
Local llOpn, llLpa, llRet, lcDop, llTot, lcQuery, lnSQLErr, lcSQL1, lcChkNum1

pUsu = Padr(Iif(Type([pUsu]) = [C], pUsu, []), 10)
pOpe = Padr(Iif(Type([pOpe]) = [C], pOpe, []), 20)

llLpa = .f.
llRet = (Empty(pUsu) Or Empty(pOpe))
lcDop = Space(20)
lnArq = Select()
llOpn = .f.

If llRet
	If (Type([pObj]) = [O])
		pObj.Value = []
		pObj.Refresh
	EndIf
Else
	llTot = (Upper(pUsu) = [4CONTROL])
	
	If llTot
		pCnx.SQLExecute([Select a.Dopps, a.Ordes From SigCdOpd a Order By 1], [crAr3])
	Else 
		lcQry = [Select a.Dopps, a.Ordes ] + ;
				  [From SigCdOpd a ] + ;
				 [Where 'P' + (Replicate('0', 8 - Len(NDopps)) + Cast(NDopps as Varchar(8))) In ] + ;
				 	   [(Select Distinct a.Programas as NDopps ] + ;
				 	      [From SigCdAcU a Where a.Programas Like 'P0%' And a.Usuarios = '] + pUsu + [') ] + ; 
				 [Order By 1]
		pCnx.SQLExecute(lcQry, [crAr1])

		lcQry = [Select Distinct a.programas As nDopps ] + ;
				  [From SigCdAcU a Inner Join SigCdAcG c On c.Grupos = a.Grupos And c.Usuarios = '] + pUsu + ['] + ;
				 [Where a.Programas Like 'P0%' And a.Usuarios = Space(10)]
		pCnx.SQLExecute(lcQry, [crAr4])

		lcQry = [Select Dopps, Ordes, 'P' + (Replicate('0', 8 - Len(NDopps)) + Cast(NDopps as Varchar(8))) as NDopps From SigCdOpd]
		pCnx.SQLExecute(lcQry, [crAr5])

		Select a.Dopps, a.Ordes ;
		  From crAr5 a ;
		 Where a.Ndopps In (Select b.NDopps From crAr4 b) ;
		  Into Cursor crAr2 ;
		 Order By 1
		
		Select a.* From crAr1 a ;
		 Union All ;
		Select a.* From crAr2 a;
		  Into Cursor crAr3 Readwrite
	EndIf 

	Select crAr3
	Index On Dopps Tag Dopps

	If (Type([pObj]) = [O])
		Set Near On
		If Not Seek(pOpe, [crAr3], [Dopps])
			loLst = CreateObject([fwBuscaSel], [crAr3], [Dopps], pOpe, [Movimentações])
			loLst.AddColuna([Dopps], Replicate([x], 20), [Movimentação], .t., [Dopps])
			loLst.AddColuna([Ordes], [999], [])
			loLst.Show
			llLpa = (Lastkey()=27)
		EndIf
		Set Near Off
	Else
		=Seek(pOpe, [crAr3], [Dopps])
	EndIf	

	lcDop = crAr3.Dopps
	llRet = (Not Eof([crAr3]) And Not Empty(lcDop))

	If (Type([pObj]) = [O])
		pObj.Value = Iif(llLpa, [], lcDop)
		pObj.Refresh
	EndIf
EndIf

If Used([crAr1])
	Use In crAr1
EndIf 
If Used([crAr2])
	Use In crAr2
EndIf 
If Used([crAr3])
	Use In crAr3
EndIf
If Used([crAr4])
	Use In crAr4
EndIf 
If Used([crAr5])
	Use In crAr5
EndIf

If (lnArq > 0)
	Select Int(lnArq)
EndIf

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoEmpresa (pUsu, pTip, pChv, pObC, pObD, pCnx, pAtv) as Boolean

Local llOpn, llLpa, llRet, lcDop, llTot

pUsu = Padr(Iif(Type([pUsu]) = [C], pUsu, []), 10)
pTip = Iif(Type([pTip]) = [C] And InList(pTip, [C], [D], [c], [d]), Upper(pTip), [C])
pChv = Iif(Type([pChv]) = [C], pChv, [])

llRet = Empty(pChv)
lcEmp = Space(3)
lnArq = Select()
llLpa = .f.
llOpn = .f.

If (Type([pCnx]) <> [O])
	llOpn = .t.
	pCnx = CreateObject([fSqlConector], [Sige])
EndIf

lcSQL1 = [Select BlqmEmps From SigCdPam]
pCnx.SQLExecute(lcSQL1, [crAr2])

Select crAr2
Go Top In crAr2

llTot = (Upper(pUsu) = [4CONTROL])

llBlq = crAr2.BlqmEmps
llAtv = pAtv

lcSQL1 = [Select a.Cemps, a.Razas ] + ;
		   [From SigCdEmp a ] + ;
		  [Inner Join SigCdAcE b On b.Emps = a.cEmps ] + ;
		  [Where b.Usuarios = '] + pUsu + [' ] + ;
				 Iif(llBlq, [And a.Cemps = '] + _Empr + [' ], []) + ;
				 Iif(llAtv, [And a.Ativas = 1 ], []) + ;
		  [Order By 1]

pCnx.SQLExecute(lcSQL1, [crAr3])

llRst = (Reccount([crAr3]) < 1 Or llTot)

If llRst
	lcSQL1 = [Select Cemps, Razas ] + ;
			   [From SigCdEmp ] + ;
			  [Where 1 = 1 ] + ;
					 Iif(llBlq, [And Cemps = '] + _Empr + [' ], []) + ;
					 Iif(llAtv, [And Ativas = 1 ], []) + ;
			  [Order By 1]

	pCnx.SQLExecute(lcSQL1, [crAr3])
EndIf

Select crAr3
Index On Cemps Tag Cemps
Index On Razas Tag Razas

If llRet
	If (Type([pObC]) = [O])
		pObC.Value = []
		pObC.Refresh
	EndIf

	If (Type([pObD]) = [O])
		pObD.Value = []
		pObD.Refresh
	EndIf
	llRet = llRst
Else
	If (Type([pObC]) = [O]) Or (Type([pObD]) = [O])
		Set Near On
		If (pTip = [C])
			If Not Seek(pChv, [crAr3], [Cemps])
				loLst = CreateObject([fwBuscaSel], [crAr3], [Cemps], pChv, [Empresas])
				loLst.AddColuna([Cemps], Replicate([x], 06), [Código], .t., [Cemps])
				loLst.AddColuna([Razas], Replicate([x], 40), [Nome],   .t., [Razas])
				loLst.Show
				llLpa = (Lastkey()=27)
			EndIf
		Else
			If Not Seek(pChv, [crAr3], 'Razas')
				loLst = CreateObject([fwBuscaSel], [crAr3], [Razas], pChv, [Empresas])
				loLst.AddColuna([Razas], Replicate([x], 40), [Nome],   .t., [Razas])
				loLst.AddColuna([Cemps], Replicate([x], 06), [Código], .t., [Cemps])
				loLst.Show
				llLpa = (Lastkey()==27)
			EndIf
		EndIf
		Set Near Off
	Else	
		=Seek(pChv, [crAr3], Iif(pTip = [C], [Cemps], [Razas]))
	EndIf	
	
	lcEmp = crAr3.Cemps
	llRet = Not Eof([crAr3]) And Not Empty(lcEmp)
	
	If (Type([pObC]) = [O])
		pObC.Value = Iif(llLpa, [], crAr3.Cemps)
		pObC.Refresh
	EndIf

	If (Type([pObD]) = [O])
		pObD.Value = Iif(llLpa, [], crAr3.Razas)
		pObD.Refresh
	EndIf
EndIf

If Used([crAr1])
	Use In crAr1
EndIf
If Used([crAr2])
	Use In crAr2
EndIf
If Used([crAr3])
	Use In crAr3
EndIf

If (lnArq > 0)
	Select Int(lnArq)
EndIf

If llOpn And (Type([pCnx]) = [O])
	pCnx.Release
	Release pCnx
EndIf

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoGrupos(pCod, pDat, pCnx) as Boolean 
Local llRet, lnRet

pDat = Iif(Type([pDat]) = [T], pDat, Ttod(pDat))

llRet = .t.

If pCnx.CursorQuery([SigCdGcr], [crAr1], [Codigos], pCod, [ddRetros, ddFutus, Codigos])
	Select crAr1
	Go Top In crAr1
	If (crAr1.ddRetros > 0 Or crAr1.ddFutus > 0)
		lnRet = 0
		If (pDat < (Date() - crAr1.ddRetros))
			lnRet = -1
		EndIf
		If (pDat > (Date() + crAr1.ddFutus))
			lnRet = 1
		EndIf
		If (lnRet <> 0)
			=Messagebox([O Período Está Bloqueado!!! Grupo ] + pCod + [!!!], 0+48, [Bloqueio de Grupos])
			llRet = .f.
		Endif
	Endif
EndIf

Return llRet
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoProduto (pGru, pUsu, pGrE, pCtE, pCnx, pMer) as Variant 
Local llRet, lcRet, lcGru, lcUsu, lcGrE, lcCtE, llMer, llOpn, loCnx, lcQry

If (Type([pGru])<>[C])
	=MessageBox([O Grupo de Produto Passado Como Parâmetro é Inválido!!!], 0+48, [Parâmetro Inválido: ] + pGru)
	Return .f.
EndIf

llRet = .t.
lcRet = []
lcGru = Padr(pGru, 3)
lcUsu = Iif(Type([pUsu])<>[C] Or Empty(pUsu), Padr(Usuar, 10), Padr(pUsu, 10))
lcGrE = Iif(Type([pGrE])<>[C], Space(10), Padr(pGrE, 10))
lcCtE = Iif(Type([pCtE])<>[C], Space(10), Padr(pCtE, 10))
llMer = Iif(Type([pMer])<>[L], .f., pMer)
llOpn = .f.
If (Type([pCnx]) = [O])
	loCnx = pCnx
Else
	llOpn = .t.
	loCnx = CreateObject([fSqlConector], [Sige])
EndIf

If llMer 
	lcQry = [Select Codigos as Mercs ] + ;
			  [From SigCdGpr ] + ;
		 	 [Order By Codigos]
Else
	lcQry = [Select Distinct Mercs ] + ;
			  [From SigCdGrp ] + ;
			 [Where ] + Iif(Empty(lcGru), [], [CGrus = '] + lcGru + [' And ]) + ;
				   [Not Mercs = '   ']
EndIf

lnErr = loCnx.SQLExecute(lcQry, [crAr1])
If (lnErr < 1)
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fAcessoProduto - Grupo de Produto)])
	llRet = .f.
EndIf

If (lnErr > 0) And llRet
	Select crAr1
	Scan While llRet Or Empty(lcGru)
		llRet = .t.

		lcQry = [Select Grupos, Contas ] + ;
				  [From SigSyPro ] + ;
				 [Where Mercs = '] + crAr1.Mercs + [' ] + ;
				 [Order By Grupos, Contas]

		lnErr = loCnx.SQLExecute(lcQry, [crAr2])
		If (lnErr < 1)
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fAcessoProduto - Acesso de Grande Grupo)])
			llRet = .f.
		EndIf

		If (lnErr > 0)
			Select crAr2
			Goto Top
			If Not Eof()
				llRet = .f.
			EndIf

			If Not Empty(lcGrE) Or Not Empty(lcCtE) 
				Scan While Not llRet
					If (crAr2.Grupos = lcGrE)
						If Empty(lcCtE) Or Empty(crAr2.Contas)
							llRet = .t.
						Else
							If (crAr2.Contas = lcCtE)
								llRet = .t.
							EndIf
						EndIf
					EndIf
				EndScan
			Else
				Scan While Not llRet
					If Empty(crAr2.Contas) And fAcessoContab(lcUsu, [C], crAr2.Grupos, .f., .f., .f., loCnx)
						llRet = .t.
					Else
						If fAcessoContas(lcUsu, crAr2.Grupos, [C], crAr2.Contas, .f., .f., .f., .f., loCnx)
							llRet = .t.
						EndIf
					EndIf
				EndScan
			EndIf
		EndIf

		If Empty(lcGru) And llRet
			If llMer
				lcRet = lcRet + crAr1.Mercs
			Else
				lcQry = [Select CGrus ] + ;
						  [From SigCdGrp ] + ;
						 [Where Mercs = '] + crAr1.Mercs + [']

				lnErr = loCnx.SQLExecute(lcQry, [crAr3])
				If (lnErr < 1)
					=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fAcessoProduto - Grupos)])
					llRet = .f.
				EndIf

				If llRet
					Select crAr3
					Scan
						lcRet = lcRet + crAr3.CGrus
					EndScan
				EndIf
			EndIf
		EndIf
	EndScan
EndIf

If Used([crAr1])
	Use In crAr1
EndIf
If Used([crAr2])
	Use In crAr2
EndIf
If Used([crAr3])
	Use In crAr3
EndIf
If llOpn And (Type([loCnx]) = [O])
	loCnx.Release
	Release loCnx
EndIf

If Empty(lcGru)
	Return lcRet
Else
	Return llRet
EndIf
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoContab (pUsu, pTip, pTxt, pCod, pDsc, pCta, pCnx, pDat, pArr, pRecPag) as Variant 
	Local lcEsc, llRet, loLst, llTot, llRst, llClr, lcGpr, lnSel, loCnx, lnErr, llOpn

	If (Type([pCnx]) = [O])
		llOpn = .f.
		loCnx = pCnx
	Else
		llOpn = .t.
		loCnx = CreateObject([fSqlConector])
	EndIf

	pUsu = Padr(Iif(Type([pUsu]) = [C], pUsu, []), 10)
	pTip = Upper(Iif(Type([pTip]) = [C] And InList(pTip, [C], [D]) ,pTip, [C]))
	pTxt = Iif(Type([pTxt]) = [C], pTxt, [])
	pCta = Padr(Iif(Type([pCta]) = [C], pCta, []), 10)

	laArr = Iif(Type([pArr]) = [L], .f., .t.)
	llRet = Empty(pTxt)
	lcGpr = Space(10)
	lcEsc = Set([Escape])
	lnSel = Select(0)
	llClr = .f.
	llRst = .f.
	lnErr = Iif(loCnx.pnIdConn > 0, 1, -1)
	llTot = .f.

	ldDsr = 0
	ldDsf = 0
	If (Type([pDat]) = [T] Or Type([pDat]) = [D])
		pDat = Iif(Type([pDat]) = [T], Ttod(pDat), pDat)
	Else
		pDat = Ctod([])
	EndIf
	
	llLik = goSistema.BuscaP
	
	Set Escape Off

	If Used([crAc1])
		Use In crAc1
	EndIf
	If (lnErr > 0)
		lnErr = loCnx.SQLExecute([Select Usuarios, Supervis From SigCdUsu Where Usuarios = '] + pUsu + ['], [crAc1])
	EndIf
	If Used([crAc1])
		Select crAc1
		Go Top
		llTot = (Not Eof([crAc1]) And (Upper(crAc1.Usuarios) = [4CONTROL]))
	EndIf
	If (lnErr > 0)
		lnErr = loCnx.SQLExecute([Select Usuarios, Supervis From SigCdUsu Where Usuarios = '] + pUsu + ['], [crAc1])
	EndIf
	If Not llTot
		lcQry = [Select Count(*) as Nnreg1s ] + ;
				  [From SigSyAgc a ] + ;
				  [Left Join SigCdAcG c On c.Grupos = a.GrAcess And c.Usuarios = '] + pUsu + [' ] + ;
		         [Right Join SigCdGcr b On b.Codigos = a.GrContbs ] + ;
		         [Where (a.Usuacess = '] + pUsu + [' Or c.Usuarios = '] + pUsu + [')]
		         
		If Used([crAc2])
			Use In crAc2
		EndIf
		If (lnErr > 0)
			lnErr = loCnx.SQLExecute(lcQry, [crAc2])
		EndIf
		If Used([crAc2])
			Select crAc2
			Set Order To ''
			Locate
		EndIf
	EndIf
	lcFiltroRec = []
	If pRecPag
		lcFiltroRec = lcFiltroRec + []
	EndIf 
	lcQry = [Select a.Grcontbs, b.Codigos, b.Descrs, b.ddRetros, b.ddFutus ] + ;
			  [From SigSyAgc a ] + ;
	          [Left Join SigCdAcG c On c.Grupos = a.Gracess And c.Usuarios = '] + pUsu + [' ] + ;
	         [Right Join SigCdGcr b On b.Codigos = a.Grcontbs ] + ;
	         [Where ] + Iif(llTot, [0=0], [(a.Usuacess = '] + pUsu + [' Or c.Usuarios = '] + pUsu + [')]) + ;
	                    Iif(Empty(pTxt), [], Iif(pTip = [C], ;
	                    [ And ((a.Grcontbs between '] + pTxt + [' And '] + Padr(AllTrim(pTxt), Len(pTxt), Chr(254)) + [')] + ;
		                [ Or (b.Codigos Between '] + pTxt + [' And '] + PadR(AllTrim(pTxt), Len(pTxt), Chr(254)) + ['))], ;
                       	[ And b.Descrs Between '] + pTxt + [' And '] + PadR(AllTrim(pTxt), Len(pTxt), Chr(254)) + ['])) + ;
	               [ Group By a.Grcontbs, b.Codigos, b.Descrs, b.ddRetros, b.ddFutus ] + ;
	               [ Order By 1]
	If Used([crAc3])
		Use In crAc3
	EndIf
	If (lnErr > 0)
		lnErr = loCnx.SQLExecute(lcQry, [crAc3])
	EndIf
	If Used([crAc3])
		Select Nvl(GrContbs, Codigos) as GrContbs, a.Descrs, a.Codigos, a.ddRetros, a.ddFutus ;
		  From crAc3 a ;
		 Group By 1, 2, 3, 4, 5 ;
		 Order By 1, 3 ;
		  Into Cursor crAr4
	EndIf
	
	llRst = ((Used([crAr4]) And Reccount([crAr4])=0 And Used([crAc2]) And crAc2.nNreg1s = 0) Or llTot)

	If llRst
		lcQry = [Select Codigos as Grcontbs, Descrs, ddRetros, ddfutus ] + ;
				  [From SigCdGcr a ] + ;
				  		Iif(Empty(pTxt), [], Iif(llLik, Iif(pTip = [C], ;
				  		[ Where Codigos Like '%] + Alltrim(pTxt) + [%'], [ Where Descrs Like '%] + Alltrim(pTxt) + [%']), + ;
				  		Iif(pTip = [C], [ Where Codigos Between '] + pTxt + [' And '] + PadR(AllTrim(pTxt), Len(pTxt), Chr(254)) + ['], ;
	                    [ Where Descrs Between '] + pTxt + [' And '] + PadR(AllTrim(pTxt), Len(pTxt), Chr(254)) + [']))) + ;
				[ Order By 1]

		If Used([crAr4])
			Use In crAr4
		EndIf
		If (lnErr > 0)
			lnErr = loCnx.SQLExecute(lcQry, [crAr4])
		EndIf
	EndIf
	
	If Used([crAr4]) And laArr
		Select GrContbs From crAr4 Group By 1 Into Array pArr
	EndIf
	
	If Not llRet And Not laArr
		If Used([crAr4])
			Select crAr4
			Index On GrContbs Tag GrContbs

			Use Dbf([crAr4]) Again Alias crAr5 In 0
			Select crAr5
			Index On Descrs Tag Descrs

			If (Type([pCod]) = [O] Or Type([pDsc]) = [O])
			   Set Near On
			   If (pTip = [C])
				   If Not Seek(pTxt, [crAr5], [GrContbs])
						loLst = CreateObject([fwBuscaInt], [crAr5], [GrContbs], pTxt, [Grupos], .t.)
						loLst.mAddColuna([GrContbs], [xxxxxxxxxx], [Código], .t.)
						loLst.mAddColuna([Descrs], [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx], [Descrição], .t.)
						loLst.Show
						llClr = (Lastkey()=27)
					EndIf
				Else
				   If Not Seek(pTxt, [crAr5], [Descrs])
						loLst = CreateObject([fwBuscaInt], [crAr5], [Descrs], pTxt, [Grupos], .t.)
						loLst.mAddColuna([Descrs], [], [Descrição], .t.)
						loLst.mAddColuna([GrContbs], [xxxxxxxxxx], [Código], .t.)
						loLst.Show
						llClr = (Lastkey()=27)
					EndIf
				EndIf
				Set Near Off
			Else	
				=Seek(pTxt, [crAr5], Iif(pTip = [C], [GrContbs], [Descrs]))
			EndIf	
			lcGpr = crAr5.GrContbs
			ldDsr = crAr5.ddretros
			ldDsf = crAr5.ddfutus
			llRet = (Not Eof([crAr5]) And Not Empty(lcGpr))
			
			If (Type([pCod]) = [O])
				pCod.Value = Iif(llClr, [], crAr5.GrContbs)
				pCod.Refresh
			EndIf
			If (Type([pDsc]) = [O])
				pDsc.Value = Iif(llClr, [], crAr5.Descrs)
				pDsc.Refresh
			EndIf 
		EndIf 
	Else
		If (Type([pCod]) = [O])
			pCod.Value = []
			pCod.Refresh
		EndIf
		If (Type([pDsc]) = [O])
			pDsc.Value = []
			pDsc.Refresh
		EndIf
		llRet = llRst
		If Used([crAr4])
			ldDsr = crAr4.ddretros
			ldDsf = crAr4.ddfutus
		EndIf
	EndIf
	
	If Not Empty(pCta)
		If Used([crAr6])
			Use In crAr6
		EndIf
		If (lnErr > 0)
			lnErr = loCnx.SQLExecute([Select IClis, Vinculas, Grupos From SigCdCli Where IClis = '] + pCta + [' Order By 1], [crAr6])
		EndIf
		If Used([crAr6])
			Select crAr6
			Set Order To ''
			Go Top
			If (crAr6.Vinculas = 1)
				llRet = (lcGpr = crAr6.Grupos)
				If Not llRet
					=Messagebox([Este É Um Grupo Vinculado!!! Verifique o Acesso Dele!!!], 0+48, [Grupo Vinculado])
					If (Type([pCod]) = [O])
						pCod.Value = []
						pCod.Refresh
					EndIf
					If (Type([pDsc]) = [O])
						pDsc.Value = []
						pDsc.Refresh
					EndIf
				EndIf 
			EndIf 
		EndIf
	EndIf
	
	If (llRet) And Not Empty(pDat) And (ldDsr > 0 Or ldDsf > 0 ) And Not laArr
		lnRet = 0
		If (pDat < (Date() - ldDsr))
			lnRet = -1
		EndIf
		If (pDat > (Date() + ldDsf))
			lnRet = 1
		EndIf
		If (lnRet <> 0)
			=Messagebox([Período Bloqueado Para Este Grupo!!!], 0+48, [Bloqueio do Grupo: ] + lcGpr)
			If (Type([pCod]) = [O])
				pCod.Value = []
				pCod.Refresh
			EndIf
			If (Type([pDsc]) = [O])
				pDsc.Value = []
				pDsc.Refresh
			EndIf
			llRet = .f.
		EndIf 
	EndIf 
	
	If Used([crAc1])
		Use In crAc1
	EndIf
	If Used([crAc2])
		Use In crAc2
	EndIf
	If Used([crAc3])
		Use In crAc3
	EndIf
	If Used([crAr4])
		Use In crAr4
	EndIf
	If Used([crAr5])
		Use In crAr5
	EndIf
	If Used([crAr6])
		Use In crAr6
	EndIf
	If (lnSel > 0)
		Select (lnSel)
	EndIf

	If llOpn And Type([loCnx]) = [O]
		loCnx.Release
		Release loCnx
	EndIf
	Set Escape &lcEsc.

	goSistema.BuscaP = .f.

	Return Iif(laArr, pArr, llRet)
EndFunc
* Fim **************************************************************************************


********************************************************************************************
Function fAcessoCampos (pPrg, pPar, pCnx, pNot, pUsu, pNta) as Boolean 

Local llRet, lnSel, lnIdAcesso1, lnErr, lcMcrSql1

pPrg = Upper(Padr(pPrg, 10))
pPar = Upper(Padr(Iif(Type([pPar]) <> [C], [ ], pPar), 31))
pUsu = Upper(Iif(Type([pUsu]) = [C], pUsu, Usuar))

lnSel = Select()
llRet = .f.
lnErr = 1

If (Upper(Alltrim(pUsu)) = [4CONTROL]) And Not pNta
	llRet = .f.
Else
	If (lnErr > 0) And Empty(pPar)
		lcQry = [Select a.* ] + ;
				  [From SigAcTel a ] + ;
				 [Where a.CCodigos = '] + pPrg + [' And a.Usuarios = '] + pUsu + [' ] + ; 
				 [Union All ] + ;
				[Select a.* ] + ;
				  [From SigAcTel a ] + ;
				  [Left Outer Join SigCdAcG b On a.Grupos = b.Grupos ] + ;
				 [Where a.CCodigos = '] + pPrg + [' And b.Usuarios = '] + pUsu + [' ] + ; 
				 [Order By a.CCodigos]

		lnErr = pCnx.SQLExecute(lcQry, [crfSigAcTel])
		If (lnErr > 0) And Used([crfSigAcTel])			
			Select crfSigAcTel
			Go Top In crfSigAcTel
			Replace All CCampos With Upper(CCampos)
			Index On CCampos + Alltrim(Str(NStatus)) Tag CCampos							
		EndIf 
	EndIf
	
	If (lnErr > 0) And Used([crfSigAcTel])
		Select crfSigAcTel
		Go Top In crfSigAcTel
		llRet = Not Eof([crfSigAcTel])
		If Not Empty(pPar)
			llRet = Seek(pPar, [crfSigAcTel], [CCampos])
		EndIf 
	EndIf
EndIf
Select Int(lnSel)

Return llRet
* Fim **************************************************************************************

