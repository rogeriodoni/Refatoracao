Define Class cOpenConn As Custom
	Declare pCnx(1,1)

	pCnx = []

	pOpnRelease = .f.
	pOpnLg4Erro = [Arq4erro.log]
	pOpnNomeCnx = Null

	********************************************************************************************
	Procedure Init(pCon, pIds, pTrv)
		Local Array laErr(1,1)
		Local pIdn, lnErr, llCnx, lnSec, lnIcr, lnMax, llLop, lnSca, lcStc

		SQLSetProp(0, [Asynchronous], .f.)
		SQLSetProp(0, [BatchMode], .t.)
		SQLSetProp(0, [DispLogin], 3)
		SQLSetProp(0, [ConnectTimeOut], 60)
		SQLSetProp(0, [DispWarnings], .f.)
		SQLSetProp(0, [IdleTimeOut], 0)
		SQLSetProp(0, [QueryTimeOut], 0)
		SQLSetProp(0, [Transactions], 2)
		SQLSetProp(0, [PacketSize], 4096)
		SQLSetProp(0, [WaitTime], 100)

		pCon = Iif(Type([pCon])=[C], pCon, [])
		pIds = Lower(Alltrim(Iif(Type([pIds])=[C], pIds, [])))
		pTrv = Iif(Type([pTrv])=[N], pTrv, 0)

		This.pOpnNomeCnx = pIds

		pIdn = SQLStringConnect(pCon)

		lnErr = pIdn
		laErr = Null
		lnSec = Seconds()
		lnIcr = 0 
		llCnx = .f.

		If (pIdn > 0)
			lnMax = Iif(pTrv = 1, 1, 30)
			llLop = .t.

			Do While llLop And (lnIcr < lnMax)
				If (lnErr > 0)
					lcSql = [Select * From SigConn Order By cIdConns]
					lnErr = SQLExec(pIdn, lcSql, [LocalCnx])
					=AError(laErr)
				EndIf
				llLop = (Not lnErr > 0)
				If llLop
					=InKey(1, [HM])
					lnIcr = Abs(Seconds() - lnSec)
				EndIf 
			EndDo 

			If (Not lnErr > 0 And Not IsNull(laErr))
				Local lcTxE
				lcTxE = [Erro SQL 1001: ] 
				For lnCnt = 1 to Alen(laErr, 1)
					For lnCni = 1 to Alen(laErr, 2)
						lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnCnt, lnCni)))
					Next
				Next
				This.fCriarLog(This.pOpnLg4Erro, lcTxE)
			EndIf 

			If Used([LocalCnx])
				Select ([LocalCnx])
				Set Order To ([]) In ([LocalCnx])
				Go Top In LocalCnx
				If Not Eof([LocalCnx])
					lnSca = 0
					Declare This.pCnx(RecCount([LocalCnx]),2)
						
					Select ([LocalCnx])
					Scan
						lnSca = lnSca + 1
						This.pCnx(lnSca,1) = Lower(AllTrim(LocalCnx.cIdconns))
						This.pCnx(lnSca,2) = Lower(AllTrim(LocalCnx.cStrgConns)) 
						llCnx = (llCnx Or Lower(AllTrim(LocalCnx.cIdconns)) = pIds)
					EndScan
				EndIf
			EndIf
		EndIf

		If Not llCnx And (pTrv = 1) 
			lnSca = (Alen(This.pCnx, 1) + 1)
			Declare This.pCnx(lnSca,2)
			This.pCnx(lnSca,1) = pIds
			This.pCnx(lnSca,2) = pCon
		EndIf 
		If Used([LocalCnx])
			Use In ([LocalCnx])
		EndIf

		For lnSca = 1 To Alen(This.pCnx, 1)
			If (Type([This.pCnx(lnSca, 2)]) = [C]) And (At([sql server], Lower(This.pCnx(lnSca, 2))) > 0)
				lcStc = Alltrim(Sys(16, 0)) + [ # ] + Alltrim(Sys(0))
				If Not Empty(GetEnv([ClientName]))
					lcStc = lcStc + [ # ] + GetEnv([ClientName])
				EndIf 
				This.pCnx(lnSca, 2) = [App=] + lcStc + [;] + This.pCnx(lnSca, 2)
			EndIf 
		EndFor 

		If (pIdn > 0)
			=Type([SQLRollBack(]   + Alltrim(Str(pIdn, 20, 0)) + [)])
			=Type([SQLDisConnect(] + Alltrim(Str(pIdn, 20, 0)) + [)])
		EndIf 
		=DoDefault()
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Connect(pIds, pOkc)
		Local Array laErr(1,1)
		Local lnStw, laErr, lcSte, lnMtz, lcScx, lnErr, lnSca

		pIds = Lower(AllTrim(Iif(Type([pIds])=[C], pIds, [])))
		pOkc = Iif(Type([pOkc]) = [L], pOkc, .f.)
		pIds = Iif((Empty(pIds) And Not pOkc), This.pOpnNomeCnx, pIds)
		
		lnStw = 0
		laErr = Null
		lcSte = Set([Exact], 1)
		Set Exact On

		lnMtz = Ceiling(AScan(This.pCnx,pIds) / 2)
		If (lnMtz = 0 And Not pOkc)
			lnMtz = Ceiling(AScan(This.pCnx, This.pOpnNomeCnx) / 2)
			pIds = This.pOpnNomeCnx
		EndIf
		 
		If (lnMtz > 0)
			lcScx = This.pCnx(lnMtz, 2)
			lnStw = SQLStringConnect(lcScx)
			=AError(laErr)
			lnErr = Iif(lnStw > 0, 1, -1)
			If (lnStw > 0) And (At([sql server], Lower(lcScx)) > 0)
				If (lnErr > 0)
					lnErr = SQLExec(lnStw, [Set Lock_TimeOut 10000], [])
				EndIf
				If (lnErr > 0)
					lnErr = SQLExec(lnStw, [Set Transaction Isolation Level Read UnCommitted], [])
				EndIf
				If (lnErr > 0)
					lnErr = SQLExec(lnStw, [Set NoCount On], [])
				EndIf
				If (lnErr > 0)
					lnErr = SQLExec(lnStw, [Set Dateformat ydm], [])
				EndIf
				If (lnErr > 0)
					lnErr = SQLExec(lnStw, [Set Language us_english], [])
				EndIf
			EndIf

			If (Not lnErr > 0 And Not IsNull(laErr))
				Local lcTxE
				lcTxE = [Erro SQL 1002]
				For lnSca = 1 to Alen(laErr, 1)
					For lnCnu = 1 to Alen(laErr, 2)
						lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnCnu)))
					Next
				Next
				This.fCriarLog(This.pOpnLg4Erro, lcTxE)
			EndIf 
		EndIf
		Set Exact &lcSte.
		Return lnStw
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Function fCriarLog(pArq, pTxt)
		Local lcGrv, lcLin
		pArq = Iif(Type([pArq])=[C], pArq, [])
		pTxt = Iif(Type([pTxt])=[C], pTxt, [])
		If Not Empty(pArq)
			pArq = (Addbs(Sys(5) + Sys(2003)) + JustFname(pArq))
			lcLin = Iif(At(Replicate([_], 64), pTxt) > 0, [], [( ] + Ttoc(Datetime()) + [ ) ])
			Text To lcGrv NoShow TextMerge
				<<Chr(13) + Chr(10)>><<lcLin + Alltrim(pTxt)>><<Chr(13) + Chr(10)>>
			EndText 
			=StrToFile(lcGrv, pArq, 1)
		EndIf 
		Return 1
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Release
		If Not This.pOpnRelease
			This.pOpnRelease = .t.
			Release This
		EndIf
	EndProc
EndDefine
* Fim **************************************************************************************



********************************************************************************************
Define Class fSqlConector as Custom
	Declare pfSqlTabela(1,1)
	pfSqlTabela = Null
	pOpnRelease = .f.
	pOpnNomeCnx = []
	pOpnNomeCur = []
	pOpnLg4Erro = [Arq4erro.Log]
	pOpnSelects = Null

	* Propriedades de Uso Interno
	pcDriver = []
	pnIdConn = 0
	pnTravaI = 0
	pnTravaF = 0

	********************************************************************************************
	Procedure Init(pNum, pDif, pOkc, pTrI)
		Local pIds, lcTip

		This.pnTravaI = Iif(Type([pTrI]) = [N], pTrI, 0)
		This.pnTravaI = Iif(This.pnTravaI = 0, 30, This.pnTravaI)
		This.pnTravaF = 10 

		If (Type([pNum]) = [N])
			This.pnIdConn = pNum
		Else 
			pNum = Lower(AllTrim(Iif(Type([pNum]) = [C], pNum, [])))
			If (Type([goSistema.ObjectConn]) = [O])
				This.pnIdConn = goSistema.ObjectConn.Connect(@pNum, pOkc)
			EndIf
		EndIf
		 
		If (This.pnIdConn > 0)
			lcTip = Lower(SQLGetProp(This.pnIdConn, [ConnectString]))

			Do Case
				Case (At([sql server], lcTip) > 0)
					lcTip = [sql]
					
				Case (At([foxpro], lcTip) > 0)
					lcTip = [foxpro]

				Otherwise
					lcTip = []
			EndCase

			This.pcDriver = lcTip
		Else 
			This.pnIdConn = -1
		EndIf 
		This.pOpnNomeCnx = Transform(pNum)
		DoDefault()
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure AddCursor(pAqv, pKey, pNme, pOrd, pObg, pQur, pReq)
		Local lnNum

		If (ALen(This.pfSqlTabela, 1) > 0 And Not IsNull(This.pfSqlTabela(1, 1)))
			Declare This.pfSqlTabela((ALen(This.pfSqlTabela, 1) + 1), 1)
		EndIf
		lnNum = ALen(This.pfSqlTabela, 1)
		This.pfSqlTabela(lnNum, 1) = CreateObject([pClsCursor], This, pAqv, pKey, pNme, pOrd, pObg, pQur, pReq)
		
		Return This.pfSqlTabela(lnNum, 1)
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Function SqlExecute(pQry, pCsr, pTrI) as Integer 
		Local Array laErr(1,1)
		Local lnRet, llLop, lcCur, lnSca, lnSmt, lnNcx, llEmw, lcEmw, lnTrF, lnCkg, lcCxy, lcPrg, lnSec, lnIcr, lnPrg

		lcEmw = On([Error])
		On Error llEmw = .t.

		pCsr = Iif(Type([pCsr]) = [C], pCsr, [])
		pTrI = Iif(Type([pTrI]) = [N], pTrI, 0)
		pTrI = Iif(pTrI = 0, This.pnTravaI, pTrI)
		If Not IsNull(pQry)
			pQry = Iif(Type([pQry]) = [C], pQry, [])			
		EndIf 

		lnNcx = This.pnIdConn
		llLop = (This.pnIdConn > 0 And Not IsNull(pQry))
		lnRet = Iif(llLop, 0, -1)
		lcCur = Set([Cursor], 1)
		lnTrF = Min(pTrI, 10)
		lnCkg = 0
		lcCxy = Sys(2015)
		laErr = Null
		lnSec = Seconds()
		lnIcr = 0 

		If Not This.pnTravaF = lnTrF
			This.pnTravaF = lnTrF
			If (This.pcDriver = [sql]) 
				pCmd = [Set Lock_TimeOut ] + Alltrim(Str(This.pnTravaF * 1000, 10, 0))
				lnRet = SQLExec(lnNcx, pCmd)
			EndIf 
		EndIf 

		This.pOpnNomeCur = Iif(Empty(pCsr), This.pOpnNomeCur, [])
		
		If (Not Empty(pCsr) And Used(pCsr))
			Use In (pCsr)
		EndIf
		
		If (Not Empty(This.pOpnNomeCur) And Used(This.pOpnNomeCur))
			Use In (This.pOpnNomeCur)
		EndIf 

		Do While llLop
			If Not Empty(pQry)
			   lnRet = SqlExec(lnNcx, pQry, pCsr)
			Else   
			   lnRet = SqlExec(lnNcx)
			EndIf 
			=AError(laErr)
			llLop = (lnRet = 0)

		   If (Not llLop And lnRet = -1)
				If (This.pcDriver = [sql]) 
					For lnSca=1 to Alen(laErr, 1)
						lcErroState1 = laErr(lnSca, 4)
						lnCkg = laErr(lnSca, 5) 

						Do case
							Case InList(lnCkg, 1205, 1211, 3928, 8650)
								lnRet = -2

							Case (lnCkg = 1222)
								=SqlExec(lnNcx, [Select @@TRANCOUNT as nTrans], lcCxy)
								If Not Used(lcCxy) Or Evaluate(lcCxy + [.nTrans]) = 0
									lnRet = -2
								EndIf 
								If Used(lcCxy)
									Use In (lcCxy)
								EndIf 
						EndCase 
						
						If InList(lcErroState1, [08S01], [08003])
							lnRet = -3
						EndIf 

						If InList(lnRet, -2, -3)
							Exit
						EndIf
					Next

					If InList(lnRet, -2, -3)
						llLop = .f.
						Loop
					EndIf 
				EndIf 

				If SqlGetProp(lnNcx, [ConnectBusy])
					Wait Window NoWait [Conex�o em Uso - ] + Left(pQry, 50)
					llLop = .t.
				Else
					If (lnIcr <= pTrI)
						Wait Window NoWait [Reconectando ao Servidor - ] + Left(pQry, 50) + [ ] + Alltrim(Str(lnIcr))
						llLop = .t.
					EndIf
					If (lnIcr > pTrI)
						Wait Window NoWait [Erro de Instru��o - ] + Left(pQry,50)
					EndIf
				EndIf
			Else
				If (lnRet = 0) And (lnIcr >= 60)
					Wait Window NoWait [Servidor Ocupado - ] + Left(pQry,50)
				EndIf 
			EndIf

			If llLop
				=InKey(1, [HM])
				lnIcr = Abs(Seconds() - lnSec)
			EndIf 
		Enddo

		If (Not lnRet > 0 And (Not IsNull(laErr) Or IsNull(pQry)))
			Local lcTxE
			lcPrg = []
			lnPrg = 0
			Do While Not Len(Sys(16, lnPrg)) = 0
				lnPrg = lnPrg + 1
			EndDo 
			If (lnPrg > 0)
				lnPrg = Max((lnPrg - 2), 0)				
			EndIf 
			lcPrg = Sys(16, lnPrg)
			lcTxE = [Erro SQL 1455: ] + Nvl(pQry, []) + Chr(13) + Chr(10) + [Programa : ] + Alltrim(lcPrg)

			For lnSca=1 to Alen(laErr, 1)
				For lnSmt = 1 to Alen(laErr, 2)
					lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
				Next
			Next
			This.fCriarLog(This.pOpnLg4Erro, lcTxE)
		EndIf 
		Wait Clear
		On Error &lcEmw.
		Return lnRet
	EndFunc 
	* Fim **************************************************************************************
	
	
	********************************************************************************************
	Function fCriarLog(pArq, pTxt)
		Local lcGrv, lcLin
		pArq = Iif(Type([pArq])=[C], pArq, [])
		pTxt = Iif(Type([pTxt])=[C], pTxt, [])
		If Not Empty(pArq)
			pArq = (Addbs(Sys(5) + Sys(2003)) + JustFname(pArq))
			lcLin = Iif(At(Replicate([_], 64), pTxt) > 0, [], [( ] + Ttoc(Datetime()) + [ ) ])
			Text To lcGrv NoShow TextMerge
				<<Chr(13) + Chr(10)>><<lcLin + Alltrim(pTxt)>><<Chr(13) + Chr(10)>>
			EndText 
			=StrToFile(lcGrv, pArq, 1)
		EndIf 
		Return 1
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function SqlPrepare(pQry, pCsr) As Integer 
		Local Array laErr(1,1)
		Local lnRet, lnNcx, lcEmw, llEmw, lnSca, lnSmt, lcPrg, lnPrg

		lcEmw = On([Error])
		On Error llEmw = .t.

		pCsr = Iif(Type([pCsr]) = [C], pCsr, [])
		If Not IsNull(pQry)
			pQry = Iif(Type([pQry]) = [C], pQry, [])
		EndIf 

		lnNcx = This.pnIdConn
		lnRet = Iif(lnNcx > 0 And Not IsNull(pQry), 0, -1)
		laErr = Null
		This.pOpnNomeCur = pCsr

		If (Not Empty(pCsr) And Used(pCsr))
			Use In (pCsr)
		EndIf 
		
		If Not IsNull(pQry)
			lnRet = SqlPrepare(lnNcx, pQry, pCsr)
			=AError(laErr)
		EndIf 

		If (Not lnRet > 0 And (Not IsNull(laErr) Or IsNull(pQry)))
			Local lcTxE
			lcPrg = []
			lnPrg = 0

			Do While Not Len(Sys(16, lnPrg)) = 0
				lnPrg = lnPrg + 1
			Enddo
			If (lnPrg > 0)
				lnPrg = Max((lnPrg - 2), 0)
			EndIf 
			lcPrg = Sys(16, lnPrg)
			lcTxE = [Erro SQL 8102: ] + Nvl(pQry, []) + Chr(13) + Chr(10) + [ - Prog: ] + Alltrim(lcPrg)

			For lnSca = 1 to Alen(laErr, 1)
				For lnSmt = 1 to Alen(laErr, 2)
					lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
				Next
			Next
			This.fCriarLog(This.pOpnLg4Erro, lcTxE)
		EndIf 
		Wait Clear
		On Error &lcEmw.
		Return lnRet
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function CursorQuery(pArq, pCcq, pNpo, pDad, pCpo, pOrd)
		Local Array laArg(1)
		Local lnErr, lnSca, lcWhe, pOrd

		pArq = Lower(AllTrim(Iif(Type([pArq]) = [C], pArq, [])))
		pCcq = Lower(AllTrim(Iif((Type([pCcq]) = [C] And Not Empty(pCcq)), pCcq, [cq] + pArq)))
		pCpo = Lower(AllTrim(Iif(Type([pCpo]) = [C], pCpo, [])))
		pOrd = Iif(Type([pOrd]) = [C], pOrd, [])
		pOrd = Lower(StrTran(pOrd, [ ], []))

		lnErr = Iif(This.pnIdConn>0,1,-1)
		lcWhe = []
		lnSla = Select()

		If (Type([Alen(pNpo, 2)]) = [N] And ALen(pNpo, 2) = 2)
			Declare pNpo(ALen(pNpo,1),ALen(pNpo,2))

			lcWhe = [ Where]
			For lnSca = 1 To ALen(pNpo,1)
				lcCtv = [pCtn] + Alltrim(Str(lnSca,20,0))
				Private &lcCtv.
				&lcCtv. = pNpo(lnSca,2)
				lcWhe = lcWhe + [ a.] + Lower(Alltrim(pNpo(lnSca,1))) + [=?pCtn] + Alltrim(Str(lnSca, 20, 0)) + [ And]
			Next
			lcWhe = Left(lcWhe, (Len(lcWhe)-4))
		Else
			pNpo = Iif(Type([pNpo]) = [C], pNpo, [])
			If Not Empty(pNpo)
				Private pCtn1
				pCtn1 = pDad
				lcWhe = [ Where a.] + Lower(Alltrim(pNpo)) + [=?pCtn1]
			EndIf
		EndIf
		If Empty(pCpo)
			pCpo = [a.*]
		Else 
			pCpo = [a.] + Strtran(pCpo, [,], [,a.])
		EndIf 
		If Empty(pOrd)
			lcTmz = Sys(2015)
			lcQrz = [Select ] + pCpo + [ From ] + pArq + [ a Where 0=1]

			If lnErr>0
				lnErr = This.SQLExecute(lcQrz,lcTmz)
			EndIf
			If Used(lcTmz)
				= AFields(laArg, lcTmz)
				
				For lnSca=1 To Alen(laArg, 1)
					If InList(laArg(lnSca,2),'C','N','I','F','L','D','T')
						pOrd = pOrd + Alltrim(Str(lnSca, 20, 0)) + [,]
						lnSca = Alen(laArg,1) + 1
					EndIf 
				EndFor 
				If Not Empty(pOrd)
					pOrd = [ Order By ] + Left(pOrd, Len(pOrd) - 1)
				EndIf 
				Use In (lcTmz)
			EndIf
		Else 
			pOrd = ([ order by a.]+Strtran(pOrd,[,],[,a.]))
		EndIf 
		lcQrz = [Select ] + pCpo + [ From ] + pArq + [ a] + lcWhe + pOrd
 		llRet = .f.

		If lnErr>0
			lnErr = This.SQLExecute(lcQrz, pCcq)
		EndIf
		llRet = (lnErr > 0 And Used(pCcq) And Reccount(pCcq) > 0)
		
		If llRet
			Select (pCcq)
			Locate 
		EndIf 
		If (lnSla > 0)
			Select Int(lnSla)
		EndIf 

		Return llRet
	EndFunc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure NewReg(pIdc, pZap)
		Local lnSca, lcOrig, lcLog

		lcLog = "C:\4c\projeto\app\NewReg_Diag.log"
		lcOrig = Transform(pIdc) + " zap=" + Transform(pZap)
		StrToFile("=== NewReg " + Ttoc(Datetime()) + " pIdc=" + lcOrig + " ===" + Chr(13)+Chr(10), lcLog, 0)

		pZap = Iif(Type([pZap]) = [L], pZap, .f.)

		If (Type([pIdc]) = [C])
			pIdc = Lower(AllTrim(pIdc))
			StrToFile("  normalized pIdc=[" + pIdc + "] len=" + Transform(Len(pIdc)) + Chr(13)+Chr(10), lcLog, 1)

			For lnSca=1 To ALen(This.pfSqlTabela,1))
				Local lcCur
				lcCur = This.pfSqlTabela(lnSca).pcNomeCursor
				StrToFile("  loop lnSca=" + Transform(lnSca) + " pfSqlTabela.pcNomeCursor=[" + Transform(lcCur) + "] eq=" + Transform(lcCur = pIdc) + Chr(13)+Chr(10), lcLog, 1)
				If (This.pfSqlTabela(lnSca).pcNomeCursor = pIdc)
					pIdc = lnSca
					lnSca = ALen(This.pfSqlTabela,1)
					StrToFile("  MATCH! pIdc reassigned to " + Transform(pIdc) + Chr(13)+Chr(10), lcLog, 1)
				EndIf
			EndFor
		EndIf
		If Not Type([pIdc])=[N]
			pIdc = 0
			StrToFile("  Type(pIdc) NOT N -> reset to 0" + Chr(13)+Chr(10), lcLog, 1)
		EndIf
		StrToFile("  final pIdc=" + Transform(pIdc) + " between check=" + Transform(BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))) + Chr(13)+Chr(10), lcLog, 1)

		If BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))
			With This.pfSqlTabela(pIdc)
				StrToFile("  With.pcNomecursor=[" + Transform(.pcNomecursor) + "] Used=" + Transform(Used(.pcNomecursor)) + Chr(13)+Chr(10), lcLog, 1)
				If Used(.pcNomecursor)
					If pZap
						Zap In (.pcNomecursor)
						StrToFile("  post-Zap reccount=" + Transform(Reccount(.pcNomecursor)) + Chr(13)+Chr(10), lcLog, 1)
					EndIf
					Select (.pcNomecursor)
					Scatter Memvar Blank
					Insert Into (.pcNomecursor) From Memvar
					StrToFile("  post-Insert reccount=" + Transform(Reccount(.pcNomecursor)) + Chr(13)+Chr(10), lcLog, 1)
				EndIf
			EndWith
		EndIf
		StrToFile("=== FIM ===" + Chr(13)+Chr(10), lcLog, 1)
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Function ReQuery(pIdc, pNpo, pDad)
		Local Array laGdd(1,1)
		Local lnSca,lnErr,lcQrz,lcKum

		lnErr = Iif(This.pnIdConn > 0, 1, -1)

		If (Type([pIdc]) = [C])
			pIdc = Lower(AllTrim(pIdc))

			For lnSca = 1 To ALen(This.pfSqlTabela,1))
				If This.pfSqlTabela(lnSca).pcNomecursor == pIdc		&& mena 09/02/2017 - colocado == (crSigopfpo <> crSigopfp) 
					pIdc = lnSca
					lnSca = ALen(This.pfSqlTabela,1)
				EndIf
			Next
		EndIf
		If Not Type([pIdc]) = [N]
			pIdc = 0
		EndIf
		If BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))
			lcAlq = []
			laGdd(1) = []
			With This.pfSqlTabela(pIdc)
				If At(' '+Lower(.pcTabela)+' ',Lower(.pcStrquery))>0
					lcAlq = Alltrim(Substr(.pcStrquery,(At(' '+Lower(.pcTabela),Lower(.pcStrquery))+Len(' '+.pcTabela+' '))))
					If At(',',lcAlq)>0
						lcAlq = Substr(lcAlq,1,(At(',',lcAlq)-1))
					EndIf 
					If At(' ',lcAlq)>0
						lcAlq = Substr(lcAlq,1,(At(' ',lcAlq)-1))
					EndIf 
					lcAlq = Alltrim(Substr(lcAlq,1))
					If InList(Lower(lcAlq),'inner','left','right','full','where','group','having','order')
						lcAlq = ''
					Else 
						lcAlq = (lcAlq+[.])
					EndIf 
				EndIf 
				lcWhe = []

				If (Type([Alen(pNpo,2)]) = [N] And ALen(pNpo, 2) = 2)
					Declare pNpo(ALen(pNpo, 1), ALen(pNpo,2))

					lcWhe = [ where]
					For lnSca=1 To ALen(pNpo, 1)
						lcCtv = [pCtn] + AllTrim(Str(lnSca,20,0))
						Private &lcCtv.
						&lcCtv. = pNpo(lnSca, 2)
						lcWhe = lcWhe + [ ] + lcAlq + Lower(Alltrim(pNpo(lnSca, 1))) + ;
									[=?pCtn] + Alltrim(Str(lnSca, 20, 0)) + [ And]
					EndFor
					lcWhe = Left(lcWhe,(Len(lcWhe)-4))
				Else 
					If (Type([pNpo]) = [C]) And Not Empty(pNpo)
						Private pCtn1
						pCtn1 = pDad
						lcWhe = [ Where ] + lcAlq + Lower(Alltrim(pNpo)) + [=?pCtn1]
					EndIf
				EndIf
				If Not Empty(lcWhe)
					lcQrz = ''
					DO Case
						Case At(' where ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Left(.pcStrquery,At(' where ',Lower(.pcStrquery)))+lcWhe)
						Case At(' group by ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Left(.pcStrquery,At(' group by ',Lower(.pcStrquery)))+lcWhe)
						Case At(' having ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Left(.pcStrquery,At(' having ',Lower(.pcStrquery)))+lcWhe)
						Case At(' order by ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Left(.pcStrquery,At(' order by ',Lower(.pcStrquery)))+lcWhe)
						OtherWise
							lcQrz = (.pcStrquery+lcWhe)
					EndCase
					DO Case
						Case At(' group by ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Substr(.pcStrquery,At(' group by ',Lower(.pcStrquery))))
						Case At(' having ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Substr(.pcStrquery,At(' having ',Lower(.pcStrquery))))
						Case At(' order by ',Lower(.pcStrquery))>0
							lcQrz = (lcQrz+Substr(.pcStrquery,At(' order by ',Lower(.pcStrquery))))
					EndCase
				Else 
					lcQrz = (.pcStrquery)
				EndIf 
				If (Used(.pcNomecursor) And InList(Type(.pcNomecursor+'.'+.pcChaveprimaria),'C','N','D','T'))
					.peIdChave = Evaluate(.pcNomecursor+'.'+.pcChaveprimaria)
				EndIf
				If Type('.poObjgrid1')=='O'
					Declare laGdd((.poObjgrid1.ColumnCount+1))
					laGdd(1) = .poObjgrid1.RecordSource
					.poObjgrid1.Enabled = .f.
					lnSca = 1

					If .Not.Empty(laGdd(1))
						If .poObjgrid1.ColumnCount>0
							For Each pObg In .poObjgrid1.Columns
								If Lower(pObg.BaseClass)=='column'
									lnSca = (lnSca+1)
									laGdd(lnSca) = pObg.ControlSource
									pObg.Enabled = .f.
									lcCl1 = pObg.CurrentControl
									If Type('pObg.&lcMcrCol1..Enabled')=='L'
										pObg.&lcMcrCol1..Enabled = .f.
									EndIf 
								EndIf
							EndFor
						EndIf 
						.poObjgrid1.RecordSource = ''
					EndIf
				EndIf
				If Used(.pcNomecursor)
					Use In (.pcNomecursor)
				EndIf
				If lnErr>0
					lnErr = This.SQLExecute(lcQrz,.pcNomecursor)
				EndIf
				If Used(.pcNomecursor)
					For lnSca=1 To ALen(.paFields,1)
						If .paFields(lnSca,ALen(.paFields,2))
							lcKum = Lower(Alltrim(.paFields(lnSca,1)))
							lcKdo = Left(lcKum,10)
							Select (.pcNomecursor)
							Index On &lcKum. Tag &lcKdo.
						EndIf
					EndFor

					Select (.pcNomecursor)
					Set Order To ('') In (.pcNomecursor)
					If (InList(Type('.peIdChave'),'C','N','D','T') And Not Empty(.peIdChave))
						Locate For (Evaluate(.pcNomecursor+'.'+.pcChaveprimaria)==.peIdChave)
					EndIf 
					If Eof(.pcNomecursor)
						Locate
					EndIf
				EndIf
				If Type('.poObjgrid1')=='O'
					.poObjgrid1.RecordSource = laGdd(1)
					.poObjgrid1.Enabled = .t.
					lnSca = 1

					If .poObjgrid1.ColumnCount>0
						For Each pObg In .poObjgrid1.Columns
							If Lower(pObg.BaseClass)=='column'
								lnSca = (lnSca+1)
								pObg.ControlSource = laGdd(lnSca)
								pObg.Enabled = .t.
								lcCl1 = pObg.CurrentControl
								If (Type([pObg.&lcMcrCol1..Enabled]) = [L])
									pObg.&lcMcrCol1..Enabled = .t.
								EndIf 
							EndIf
						EndFor
					EndIf 
				EndIf
			EndWith
		EndIf
		Return(lnErr)
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function ChkRegister(pArq, pNpo, pDad)
		Local lnErr,lcQrz, pCcq, lcWhe, lnSca,lcCtv

		pArq = Lower(AllTrim(Iif(Type([pArq]) = [C], pArq, [])))
		lnErr = Iif(This.pnIdConn>0,1,-1)
		pCcq = Sys(2015)
		lcWhe = []
		lnSla = Select()

		If (Type([Alen(pNpo, 2)]) = [N] And ALen(pNpo, 2) = 2)
			Declare pNpo(ALen(pNpo, 1), ALen(pNpo, 2))

			lcWhe = [ where]
			For lnSca=1 To ALen(pNpo, 1)
				lcCtv = ('pCtn'+AllTrim(Str(lnSca,20,0)))
				Private &lcCtv.
				&lcCtv. = pNpo(lnSca,2)
				lcWhe = (lcWhe+[ a.]+Lower(AllTrim(pNpo(lnSca,1)))+[=?pCtn]+AllTrim(Str(lnSca,20,0))+[ and])
			EndFor
			lcWhe = Left(lcWhe,(Len(lcWhe)-4))
		Else 
			pNpo = Iif(Type([pNpo]) = [C], pNpo, [])
			If Not Empty(pNpo)
				Private pCtn1
				pCtn1 = pDad
				lcWhe = [ Where a.] + Lower(Alltrim(pNpo)) + [=?pCtn1]
			EndIf
		EndIf
		lcQrz = [Select Count(*) as nreg1s From ] + pArq + [ a] + lcWhe
		llRet = .f.

		If Used(pCcq)
			Use In (pCcq)
		EndIf
		If lnErr>0
			lnErr = This.SQLExecute(lcQrz, pCcq)
		EndIf
		llRet = (lnErr > 0 And Used(pCcq) And Nvl(Evaluate(pCcq + [.] + Lower(fields(1, pCcq))), 0) > 0)
		If Used(pCcq)
			Use In (pCcq)
		EndIf
		If (lnSla > 0)
			Select Int(lnSla)
		EndIf 
		Return llRet
	EndFunc
	* Fim **************************************************************************************
	

	********************************************************************************************
	Procedure LocateCursor(pIdc, pNpo, pDad)
		Local lnErr,lcQrz, pCcq, llRet, lcWhe, lnSca, lcCtv
		pCcq = Sys(2015)
		llRet = .f.
		If Type('pIdc')=='C'
			pIdc = Lower(AllTrim(pIdc))
			For lnSca=1 To ALen(This.pfSqlTabela,1))
				If This.pfSqlTabela(lnSca).pcNomecursor==pIdc
					pIdc = lnSca
					lnSca = ALen(This.pfSqlTabela,1)
				EndIf
			EndFor
		EndIf
		If Not Type([pIdc])=[N]
			pIdc = 0
		EndIf
		If BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))
			With This.pfSqlTabela(pIdc)
				lcWhe = []
				lcOdf = []

				If (Type([Alen(pNpo, 2)]) = [N] And ALen(pNpo, 2) = 2)
					Declare pNpo(ALen(pNpo, 1), ALen(pNpo, 2))
					lcCps = []
					lcOdf = []
					Do Case
						Case Type(.pcNomecursor+'.'+.pcChaveprimaria)=='N'
							lcWhe = ([ where not a.]+.pcChaveprimaria+[=0])
						Case Type(.pcNomecursor+'.'+.pcChaveprimaria)=='C'
							lcWhe = ([ where not a.]+.pcChaveprimaria+[=']+Space(Len(Evaluate(.pcNomeCursor+[.]+.pcChaveprimaria)))+['])
						Case InList(Type(.pcNomecursor+'.'+.pcChaveprimaria),'D','T')
							lcWhe = ([ where a.]+.pcChaveprimaria+[ is null ])
					EndCase
					For lnSca=1 To ALen(pNpo,1)
						lcCps = (lcCps+[a.]+Lower(AllTrim(pNpo(lnSca,1)))+[ as corder]+AllTrim(Str(lnSca,20,0))+[s,])
						lcOdf = (lcOdf+AllTrim(Str(lnSca,20,0))+',')
						Do Case
							Case (Type([pNpo(lnSca,2)]) = [N] And pNpo(lnSca,2) > 0)
								lcWhe = (lcWhe+[ and a.]+Lower(AllTrim(pNpo(lnSca,1)))+[>=]+AllTrim(Str(pNpo(lnSca,2),20,10)))
							Case (Type('pNpo(lnSca,2)')=='C'.And..Not.Empty(pNpo(lnSca,2)))
								lcWhe = (lcWhe+[ and a.]+Lower(AllTrim(pNpo(lnSca,1)))+[ between ']+pNpo(lnSca,2)+[' and ']+PadR(AllTrim(pNpo(lnSca,2)),Len(pNpo(lnSca,2)),Chr(254))+['])
							Case (InList(Type('pNpo(lnSca,2)'),'D','T').And..Not.Empty(pNpo(lnSca,2)))
								lcCtv = ('pCtn'+AllTrim(Str(lnSca,20,0)))

								Private &lcCtv.

								&lcCtv. = pNpo(lnSca,2)
								lcWhe = (lcWhe+[ and a.]+Lower(AllTrim(pNpo(lnSca,1)))+[>=?m.]+lcCtv)
						EndCase
					EndFor
					lcCps = (lcCps+[a.]+.pcChaveprimaria)
					lcOdf = Left(lcOdf,(Len(lcOdf)-1))
				Else 
					If Type('pNpo')=='C'
						Private pCtn1
						pCtn1 = pDad
						lcCps = ([a.]+pNpo+[ as corder1s,a.]+.pcChaveprimaria)
						lcOdf = '1'
						Do Case
							Case Type(.pcNomecursor+'.'+.pcChaveprimaria)=='N'
								lcWhe = [ where not a.]+.pcChaveprimaria+[=0]
							Case Type(.pcNomecursor+'.'+.pcChaveprimaria)=='C'
								lcWhe = ([ where not a.]+.pcChaveprimaria+[=']+Space(Len(Evaluate(.pcNomeCursor+[.]+.pcChaveprimaria)))+['])
							Case InList(Type(.pcNomecursor+'.'+.pcChaveprimaria),'D','T')
								lcWhe = [ where a.]+.pcChaveprimaria+[ is null ]
						EndCase
						Do Case
							Case (Type('pDad')=='N'.And.pDad>0)
								lcWhe = (lcWhe+[ and a.]+pNpo+[>=]+AllTrim(Str(pDad,20,10)))
							Case (Type('pDad')=='C'.And..Not.Empty(pDad))
								lcWhe = (lcWhe+[ and a.]+pNpo+[ between ']+pDad+[' and ']+PadR(AllTrim(pDad),Len(pDad),Chr(254))+['])
							Case (InList(Type('pDad'),'D','T').And..Not.Empty(pDad))
								Private pCtn1
								pCtn1 = pDad
								lcWhe = (lcWhe+[ and a.]+pNpo+[>=?pCtn1])
						EndCase
					EndIf
				EndIf
				lcQrz = ([select ]+lcCps+[ from ]+.pcNomecursor+[ a]+lcWhe+;
	                           [ order by ]+lcOdf+[ into cursor ] + pCcq)

				If Used(pCcq)
					Use In (pCcq)
				EndIf
				&lcQrz.

				If Used(pCcq)
					Select (pCcq)
					Set Order To ('') In (pCcq)
					Locate 
					pDad = Evaluate(pCcq + [.] + .pcChaveprimaria)
					llRet = (Used(pCcq) And Not Eof(pCcq) And Not Empty(pDad))

					If llRet
						Select (.pcNomecursor)
						Set Order To ('') In (.pcNomecursor)
						Locate For (Evaluate(.pcNomecursor+'.'+.pcChaveprimaria)==pDad)
					EndIf
				EndIf
			EndWith
		EndIf
		If Used(pCcq)
			Use In (pCcq)
		EndIf

		Return llRet
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Function fSqlTemporario(pSqr, pTbh, pNum, pOcc, pCmd) As Integer 
		Local lnRet, lcQrz, lnErr, lnPir, lcPiI, lcPiF

		pSqr = AllTrim(Iif(Type('pSqr')=='C', pSqr, ''))
		lcPiI = Sys(2015)
		lcPiF = Transform(Int(Rand() * Rand() * 100), '@L 99') + ;
				Transform(Int(Rand() * Rand() * 100), '@L 99') + ;
				Transform(Int(Rand() * Rand() * 100), '@L 99') + ;
				Transform(Int(Rand() * Rand() * 100), '@L 99')
		pTbh = ('##' + lcPiI + lcPiF)
		lnPir = Iif(Type('pOcc')=='L' And pOcc, -1, 1)
		pCmd = AllTrim(Iif(Type('pCmd')=='C', pCmd, ''))
		lnSla = Select(0)
		lnRet = -1
		If (Not Empty(pSqr) And Not Empty(pTbh))
			If IsNull(This.pOpnSelects)
				This.pOpnSelects = Createobject([fSqlConector], pNum)
			EndIf 
			lnErr = This.pOpnSelects.pnIdConn
			If (This.pOpnSelects.pnIdConn > 0)
				If Empty(pCmd)
					lcQrz = This.fSqlRetornaF(pSqr)
				Else 
					lcQrz = pCmd
				EndIf 

				lcQrz = Strtran(lcQrz, [ from ], [ into ] + pTbh + [ from ], -1, lnPir, 1)
				If lnErr>0 
					lnErr = This.pOpnSelects.SQLExecute(lcQrz)
				EndIf 

				lcQrz = [Insert Into ] + pTbh + [ ] + pSqr
				If lnErr>0 
					lnErr = This.pOpnSelects.SQLExecute(lcQrz)
				EndIf 
				If lnErr>0 
					lnErr = This.pOpnSelects.Commit()
				EndIf 
				If Not lnErr>0 
					This.pOpnSelects.RollBack()
				EndIf 
			EndIf 
			lnRet = lnErr
		EndIf 
		If (lnSla > 0)
			Select (lnSla)
		EndIf
		Return lnRet
	EndFunc 		
	* Fim **************************************************************************************


	********************************************************************************************
	Function fSqlApagarTmp(pArq, pIdd, pNum) As Integer 
		Local lnRet,lcQrz,lnErr

		pArq = Lower(AllTrim(Iif(Type([pArq]) = [C], pArq, [])))
		pIdd = Padr(AllTrim(Iif(Type([pIdd]) = [C], pIdd, [])),20)
		lnSla = Select(0)
		lnRet = -1

		If (Not Empty(pArq) And Not Empty(pIdd))
			loCnx = Createobject([fSqlConector], pNum)
			lnErr = loCnx.pnIdConn

			If loCnx.pnIdConn>0
				lcQrz = [Delete From ] + pArq + [ Where cIdQuerys = '] + pIdd + [']

				If lnErr>0 
					lnErr = loCnx.SQLExecute(lcQrz)
				EndIf 
				If lnErr>0 
					lnErr = loCnx.Commit()
				EndIf 
				If Not lnErr>0 
					loCnx.RollBack()
				EndIf 
			EndIf 
			lnRet = lnErr
		EndIf 
		If Type('loCnx')=='O'
			loCnx.Release
			Release loCnx
		EndIf
		If (lnSla > 0)
			Select (lnSla)
		EndIf

		Return lnRet
	EndFunc 		
	* Fim **************************************************************************************
	

	********************************************************************************************
	Procedure UpDate(pIdc, pEpy, pIns)
		Local Array laArg(1), laCpg(1,3),laErr(1,1)
		Local llRet,lnSca,lnSmt

		llRet = .f.
		lnErr = Iif(This.pnIdConn>0,1,-1)
		If Type('pIdc')=='C'
			pIdc = Lower(AllTrim(pIdc))
			For lnSca=1 To ALen(This.pfSqlTabela,1))
				If This.pfSqlTabela(lnSca).pcNomecursor==pIdc
					pIdc = lnSca
					lnSca = ALen(This.pfSqlTabela,1)
				EndIf
			EndFor
		EndIf
		If Not Type('pIdc')='N'
			pIdc = 0
		EndIf
		
		pEpy = Iif(Type('pEpy')=='N', pEpy, 0)
		pIns = Iif(Type('pIns')=='L', pIns, .f.)

		If BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))
			With This.pfSqlTabela(pIdc)
				lcFdo = []
				laArg = []
				laCpg = []
				lcCpA = []
				lcCpB = []
				lcCpC = .pcChavePrimaria + [,]
				lcCrA = Sys(2015)
				lcCrB = Sys(2015)
				laArg(1) = .pcChavePrimaria + [,]
				lnSmt = 1
				lnPcG = 1
				lnQtr = 0
				lnQtt = 1

				For lnSca=1 To ALen(.paFields,1)
					lcFdo = Lower(AllTrim(.paFields(lnSca,1)))

					If (.paFields(lnSca, Alen(.paFields,2)-1) And (Not Lower(AllTrim(.paFields(lnSca,2))) = [m] Or ;
						 Not .paFields(lnSca,6)) And Not lcFdo = [rowguid])

						lcFdo = Lower(AllTrim(.paFields(lnSca,1)))
						lcFcp = Lower(AllTrim(.paFields(lnSca,2)))
						lcCpA = lcCpA + lcFdo + [ ] + .pcTabela + [.] + lcFdo + [,]
						lcCpB = lcCpB + lcFdo + [,]
						If Not lcFdo==.pcChavePrimaria
							If Not InList(lcFcp,'m','g')
								lcCpC = (lcCpC+lcFdo+[,])
							EndIf 
							If Not InList(lcFcp,'t','d','m','g') And (pEpy==0 Or Not .paFields(lnSca,5))
								lnSmt = lnSmt + 1
								laArg(lnPcG) = (laArg(lnPcG)+lcFdo+[,])
								If (Mod(lnSmt, 128) = 0)
									lnPcG = (lnPcG+1)
									Declare laArg(lnPcG)
									laArg(lnPcG) = ''
								EndIf 
							Else 
								lcCtv = lcFdo
								Private &lcCtv.

								lnQtr = (lnQtr+1)
								laCpg(lnQtt, 1) = laCpg(lnQtt, 1) + lcFdo + [,]
								laCpg(lnQtt, 2) = (laCpg(lnQtt, 2) + lcFdo + [ With Iif(IsNull(] + .pcNomeCursor + [.] + lcFdo + [) Or ] + ;
								Iif(Lower(AllTrim(.paFields(lnSca, 2))) = 'g', [Empty(], [Empty(]) + .pcNomeCursor + [.] + lcFdo + [), Null,] + ;
								.pcNomeCursor + [.] + lcFdo + [),])

								If Not lcFcp = [g]
									laCpg(lnQtt,3) = laCpg(lnQtt, 3) + lcFdo + [=?m.] + lcFdo + [,]
								EndIf 
								If Mod(lnQtr,128)==0 Or InList(lcFcp,'m','g')
									lnQtt = (lnQtt+1)
									Declare laCpg(lnQtt,3)
									laCpg(lnQtt,1) = []
									laCpg(lnQtt,2) = []
									laCpg(lnQtt,3) = []
								EndIf 
							EndIf
						EndIf 
					EndIf 
				EndFor 
				lcCpA = Left(lcCpA,(Len(lcCpA)-1))
				lcCpB = Left(lcCpB,(Len(lcCpB)-1))
				lcCpC = Left(lcCpC,(Len(lcCpC)-1))

				For lnSca=1 To Alen(laArg,1)
					laArg(lnSca) = Lower(Left(laArg(lnSca),(Len(laArg(lnSca))-1)))
				EndFor 
				For lnSca=1 To Alen(laCpg,1)
					laCpg(lnSca,1) = Lower(Left(laCpg(lnSca,1),(Len(laCpg(lnSca,1))-1)))
					laCpg(lnSca,2) = Lower(Left(laCpg(lnSca,2),(Len(laCpg(lnSca,2))-1)))
					laCpg(lnSca,3) = Lower(Left(laCpg(lnSca,3),(Len(laCpg(lnSca,3))-1)))
				EndFor 
				If Used(lcCrA)
					Use In (lcCrA)
				EndIf
				
				If lnErr>0
					lnErr = This.SQLExecute(([select ]+lcCpB+[ from ]+.pcTabela+[ where 0=1]), lcCrA)
					= AError(laErr)
					If Not lnErr>0 And Type([laErr(1,1)])=='N'
						Local lcTxE
						lcTxE = [Erro SQL 4001: ] 
						For lnSca=1 to Alen(laErr, 1)
							For lnSmt = 1 to Alen(laErr, 2)
								lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
							Next
						Next
						This.fCriarLog(This.pOpnLg4Erro, lcTxE)
					EndIf 
				EndIf 
				If Used(lcCrA)
					If Used(lcCrB)
						Use In (lcCrB)
					EndIf
					Create Cursor (lcCrB) (cnreg1s C(20),cnreg2s C(20))
					Index On cnreg1s Tag cnreg1s
					
					lnCxc = Recno(.pcNomeCursor)
					lcDel = Set([Deleted],1)

					Set Deleted Off

					Private &lcCpB.

					If Not pIns 
						Select (.pcNomeCursor)
						Set Order To ('') In (.pcNomeCursor)
						Locate

						Scan While lnErr>0
							Select (.pcNomeCursor)
							Scatter Memo Memvar 
							lcNra = Str(Recno(.pcNomeCursor),20,0)
							lcNrb = Str((Reccount(lcCrA)+1),20,0)

							If This.ChkRegister(.pcTabela,.pcChavePrimaria,Evaluate(.pcNomeCursor+[.]+.pcChavePrimaria))
								Insert Into (lcCrA) From Memvar
								Insert Into (lcCrB) (cnreg1s,cnreg2s) Values (lcNra,lcNrb)
							EndIf 
						EndScan 
					EndIf 
					If lnErr>0
						lnErr = Iif(CursorSetProp('Buffering',5,lcCrA),1,-1)
					EndIf 
					If lnErr>0
						lnErr = Iif(CursorSetProp('Tables',.pcTabela,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('UpdateNameList',lcCpA,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('KeyFieldList',.pcChavePrimaria,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('UpdatableFieldList','',lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('UseMemoSize',255,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('CompareMemo',.T.,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('UpdateType',1,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('WhereType',4,lcCrA),1,-1)
					EndIf
					If lnErr>0
						lnErr = Iif(CursorSetProp('SendUpdates',.t.,lcCrA),1,-1)
					EndIf

					Select (.pcNomeCursor)
					Set Order To ('') In (.pcNomeCursor)
					Locate

					Scan While lnErr>0
						Select (.pcNomeCursor)
						Scatter Memo Memvar 

						If Seek(Str(Recno(.pcNomeCursor),20,0),lcCrB,'cnreg1s')
							lnRgt = Val(Evaluate(lcCrB+'.cnreg2s'))

							Select (lcCrA)
							Goto (lnRgt) In (lcCrA)
							If Deleted(.pcNomeCursor)
								Delete
								If lnErr>0
									lnErr = Iif(TableUpdate(.t.,.t.,lcCrA),1,-1)

									= AError(laErr)

									If Not lnErr>0 And Type([laErr(1,1)])=='N'
										Local lcTxE
										lcTxE = [Erro SQL 3010: ]
										For lnSca=1 to Alen(laErr, 1)
											For lnSmt = 1 to Alen(laErr, 2)
												lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
											Next
										Next
										This.fCriarLog(This.pOpnLg4Erro, lcTxE)
									EndIf 
								EndIf
							Else 
								For lnSca=1 To Alen(laArg,1)
									lcEcP = laArg(lnSca)
									If Not Empty(lcEcP)
										If lnErr>0
											lnErr = Iif(CursorSetProp('UpdatableFieldList',lcEcP,lcCrA),1,-1)
										EndIf 
										Gather Memo Memvar Fields &lcEcP.
										If lnErr>0
											lnErr = Iif(TableUpdate(.t.,.t.,lcCrA),1,-1)

											= AError(laErr)

											If Not lnErr>0 And Type([laErr(1,1)])=='N'
												Local lcTxE											
												lcTxE = [Erro SQL 2030: ] 
												For lnSmt = 1 to Alen(laErr, 1)
													For lnPcG=1 to Alen(laErr, 2)
														lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSmt, lnPcG)))
													EndFor 
												EndFor 
												This.fCriarLog(This.pOpnLg4Erro, lcTxE)

											EndIf 
										EndIf
									EndIf 
								EndFor 
								For lnSca=1 To Alen(laCpg,1)
									lcEcP = laCpg(lnSca,1)
									If Not Empty(lcEcP)
										If lnErr>0
											lnErr = Iif(CursorSetProp('UpdatableFieldList',lcEcP,lcCrA),1,-1)
										EndIf 
										lcEcP = ([Replace ]+laCpg(lnSca,2)+[ In ]+lcCrA)
										&lcEcP.
										If lnErr>0
											lnErr = Iif(TableUpdate(.t.,.t.,lcCrA),1,-1)

											= AError(laErr)

											If Not lnErr>0 And Type([laErr(1,1)])=='N'
												Local lcTxE
												lcTxE = [Erro SQL 2040: ] 
												For lnSmt = 1 to Alen(laErr, 1)
													For lnPcG=1 to Alen(laErr, 2)
														lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSmt, lnPcG)))
													EndFor 
												EndFor 
												This.fCriarLog(This.pOpnLg4Erro, lcTxE)

											EndIf 

										EndIf

									EndIf 

									lcEcP = laCpg(lnSca,3)

									If Not Empty(lcEcP)
										Select (lcCrA)
										Scatter Memo Memvar

										Private pCtn1
										pCtn1 = Evaluate(.pcNomeCursor+[.]+.pcChavePrimaria)
										lcEcP = ([update ]+.pcTabela+[ set ]+lcEcP+;
															[ where ]+.pcChavePrimaria+[=?pCtn1])
										If lnErr>0
											lnErr = This.SQLExecute(lcEcP)
										EndIf 
									EndIf 
								EndFor 
							EndIf 
						Else 
							If Not Deleted(.pcNomeCursor)
								If lnErr>0
									lnErr = Iif(CursorSetProp('UpdatableFieldList',lcCpC,lcCrA),1,-1)
								EndIf 
								Insert Into (lcCrA) From Memvar
								For lnSca=1 To Alen(laCpg,1)
									lcEcP = laCpg(lnSca,1)
									If Not Empty(lcEcP)
										lcEcP = ([Replace ]+laCpg(lnSca,2)+[ In ]+lcCrA)
										&lcEcP.
									EndIf 
								EndFor 
								If lnErr>0
									lnErr = Iif(TableUpdate(.t.,.t.,lcCrA),1,-1)

									= AError(laErr)

									If Not lnErr>0 And Type([laErr(1,1)])=='N'
										Local lcTxE
										lcTxE = [Erro SQL 2050: ] 
										For lnSca=1 to Alen(laErr, 1)
											For lnSmt = 1 to Alen(laErr, 2)
												lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
											EndFor 
										EndFor 
										This.fCriarLog(This.pOpnLg4Erro, lcTxE)

									EndIf 

								EndIf

								For lnSca=1 To Alen(laCpg,1)
									lcEcP = laCpg(lnSca,3)
									If Not Empty(lcEcP)
										Select (lcCrA)
										Scatter Memo Memvar

										Private pCtn1
										pCtn1 = Evaluate(.pcNomeCursor+[.]+.pcChavePrimaria)
										lcEcP = ([update ]+.pcTabela+[ set ]+lcEcP+;
															[ where ]+.pcChavePrimaria+[=?pCtn1])
										If lnErr>0
											lnErr = This.SQLExecute(lcEcP)
										EndIf 
									EndIf 
								EndFor 
							EndIf 
						EndIf 
					EndScan 
					Set Deleted &lcDel.
					If lnErr>0
						lnErr = Iif(CursorSetProp('SendUpdates',.f.,lcCrA),1,-1)
					EndIf
					Use In (lcCrA)
					Use In (lcCrB)
					If Between(lnCxc,1,Reccount(.pcNomeCursor))
						Goto lnCxc In (.pcNomeCursor)
					EndIf 
				EndIf 
				llRet = (lnErr>0)
			EndWith
		EndIf

		Return llRet
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Delete(pIdc)
		Local llRet,lnSca,lnErr,lcFdo,lnCxc

		llRet = .f.
		lnErr = This.pnIdConn

		If Type('pIdc')=='C'
			pIdc = Lower(AllTrim(pIdc))

			For lnSca=1 To ALen(This.pfSqlTabela,1))
				If This.pfSqlTabela(lnSca).pcNomecursor==pIdc
					pIdc = lnSca
					lnSca = ALen(This.pfSqlTabela,1)
				EndIf
			EndFor
		EndIf
		If Not Type([pIdc])=[N]
			pIdc = 0
		EndIf
		If BetWeen(pIdc,1,ALen(This.pfSqlTabela,1))
			With This.pfSqlTabela(pIdc)
				lnCxc = Recno(.pcNomeCursor)
				lnCxt = .pcChaveprimaria
				Private &lnCxt.
				lcQrz = [Delete From ] + .pcTabela + [ Where ] + .pcChaveprimaria + [=?m.] + .pcChaveprimaria
				Select (.pcNomeCursor)
				Set Order To ('') In (.pcNomeCursor)
				Go Top
				Scan While lnErr>0 
					Scatter Memo Memvar Fields &lnCxt.
					If lnErr>0
						lnErr = This.SQLExecute(lcQrz)
					EndIf
				EndScan 
				If Between(lnCxc,1,Reccount(.pcNomeCursor))
					Goto lnCxc In (.pcNomeCursor)
				EndIf 
				llRet = (lnErr>0)
			EndWith
		EndIf
		Return llRet
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Function GetDateTime() as Datetime
		Local lnErr, lcQrz, lcArea1, ltDttime
		ltTmr = Datetime()
		If (This.GetDriver() = [sql])
			lnErr = This.pnIdConn
			lcQrz = [Select GetDate() as DataHora]
			lcAli = Sys(2015)
			ltTmr = Datetime()
			If lnErr>0 
				This.SQLExecute(lcQrz, lcAli, 3)
				If Used(lcAli)
					Select (lcAli)
					Go Top
					ltTmr = Evaluate(lcAli + [.DataHora])
					Use In (lcAli)
				EndIf 
			EndIf 
		EndIf 
		Return ltTmr
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function GetDriver
		Return This.pcDriver
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function GetDatabase
		Local lnErr, lcRet
		lnErr = Iif(This.pnIdConn > 0, 1, -1)
		lcRet = []
		If (lnErr > 0)
			lcRet = Lower(SQLGetProp(This.pnIdConn, [ConnectString]))
			Do Case
				Case (At([sql server], lcRet) > 0)
					If (At([database=], lcRet) > 0)
						lcRet = Substr(lcRet, (At([database=], lcRet)))
						lcRet = Substr(lcRet, 10)
						If (At([;], lcRet) > 0)
							lcRet = Substr(lcRet, 1, (At([;], lcRet) - 1))
						EndIf 
					Else 
						lcRet = []
					EndIf 

				Case (At([foxpro], lcRet) > 0)
					If (At([sourcedb=], lcRet) > 0)
						lcRet = Substr(lcRet, (At([sourcedb=], lcRet)))
						lcRet = Substr(lcRet, 10)
						If (At([;], lcRet) > 0)
							lcRet = Substr(lcRet, 1, (At([;], lcRet) - 1))
						EndIf 
					Else 
						lcRet = []
					EndIf 
				Otherwise
					lcRet = []
			EndCase
			lcRet = Alltrim(lcRet)
		EndIf 
		Return lcRet
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Function fSqlRetornaF(pQry) as String 
		Local lcQrz, lcMcrSql2, lcRet
		pQry = AllTrim(Iif(Type([pQry]) = [C], pQry, []))
		lcRet = []
		If Not Empty(pQry)
			lcQrz = pQry
			If At([(select ], Lower(lcQrz)) = 0
				If At([ union ], Lower(lcQrz)) > 0
					lcQrz = Substr(lcQrz,1,(At(' union ',Lower(lcQrz))))
				EndIf 
				Do Case
					Case At([ where ],Lower(lcQrz))>0
						lcSqA = Stuff(lcQrz,At([ where ],Lower(lcQrz)),Len(lcQrz),[ where 0=1])
					Case At([ group by ],Lower(lcQrz))>0
						lcSqA = Stuff(lcQrz,At([ group by ],Lower(lcQrz)),Len(lcQrz),[ where 0=1])
					Case At([ having ],Lower(lcQrz))>0
						lcSqA = Stuff(lcQrz,At([ having ],Lower(lcQrz)),Len(lcQrz),[ where 0=1])
					Case At([ order by ],Lower(lcQrz))>0
						lcSqA = Stuff(lcQrz,At([ order by ],Lower(lcQrz)),Len(lcQrz),[ where 0=1])
					OtherWise
						lcSqA = (AllTrim(lcQrz)+[ where 0=1])
				EndCase
				Do Case
					Case At([ group by ],Lower(lcQrz)) > 0
						lcSqA = (lcSqA + Substr(lcQrz, At([ group by ], Lower(lcQrz))))
					Case At([ having ], Lower(lcQrz)) > 0
						lcSqA = (lcSqA + Substr(lcQrz, At([ having ], Lower(lcQrz))))
					Case At([ order by ], Lower(lcQrz)) > 0
						lcSqA = (lcSqA + Substr(lcQrz, At([ order by ], Lower(lcQrz))))
				EndCase
			Else 
				lcSqA = Strtran(lcQrz, [ where ], [ where 0=1 and ], -1, -1, 1)
			EndIf 
			lcRet = lcSqA
		EndIf 
		Return lcRet
	EndFunc 
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Commit
		Local Array laErr(1,1)
		Local lnErr, lnSca, lnSmt
		laErr = Null
		lnErr = Iif(This.pnIdConn > 0, 1, -1)
		If (lnErr > 0) And Type([SQLGetProp(] + AllTrim(Str(This.pnIdConn, 20)) + [, 'Transactions')]) = 'N' And ;
		    SQLGetProp(This.pnIdConn,'Transactions') = 2
		   lnErr = SQLCommit(This.pnIdConn)
		   =AError(laErr)
		Else
			lnErr = -1
		EndIf

		If (lnErr < 0)
			SQLRollBack(This.pnIdConn)
		EndIf

		If Not (lnErr > 0) And Not IsNull(laErr)
			Local lcTxE
			lcTxE = [Erro SQL 5050: ] 
			For lnSca = 1 to Alen(laErr, 1)
				For lnSmt = 1 to Alen(laErr, 2)
					lcTxE = (lcTxE + Chr(13) + Chr(10) + Transform(laErr(lnSca, lnSmt)))
				Next 
			Next 
			This.fCriarLog(This.pOpnLg4Erro, lcTxE)
		EndIf 
		Return lnErr
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure RollBack
		Local lnErr
		lnErr = Iif(This.pnIdConn > 0, 1, -1)
		If (lnErr > 0)
			lnErr = SQLRollBack(This.pnIdConn)
		EndIf	
		Return lnErr
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Release
		If Not This.pOpnRelease
			Local loObj
			With This
				.pOpnSelects = Null
				If Not IsNull(.pfSqlTabela)
					For Each loObj In .pfSqlTabela
						loObj.Release
					EndFor
				EndIf 
				If (.pnIdConn > 0)
					=Type([SQLRollBack(]   + AllTrim(Str(.pnIdConn, 20, 0)) + [)])
					=Type([SQLDisConnect(] + AllTrim(Str(.pnIdConn, 20, 0)) + [)])
				EndIf 
				.pOpnRelease = .t.
			EndWith
		EndIf
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Destroy
		This.Release
	EndProc
EndDefine	
* Fim **************************************************************************************



********************************************************************************************
Define Class pClsCursor As Custom
	Declare paFields(1,1)

	paFields = NULL
	pcTabela = ''
	pcChaveprimaria = ''
	pcNomecursor = ''
	pcOrderBy1 = ''
	pcStrquery = ''
	poObjgrid1 = .f.
	pOpnRelease = .f.
	peIdChave = .f.
	pnIdConn = 0

	********************************************************************************************
	Procedure Init(pCnx, pAqv, pKey, pNme, pOrd, pObg, pQur, pReq)
		Local laCpo(1,1)
		Local lnIdCursor1, lnErr, lcQrz, lcCur, lnSca, lnSmt

		pCnx = Iif(Type([pCnx])=[O], pCnx, This)
		pAqv = Lower(AllTrim(Iif(Type([pAqv]) = [C], pAqv, [])))
		pKey = Lower(AllTrim(Iif(Type([pKey]) = [C], pKey, [])))
		pNme = Iif(Type([pNme]) = [C], pNme, [])
		pNme = Lower(AllTrim(Iif(Empty(pNme), pAqv, pNme)))
		pOrd = Iif(Type([pOrd]) = [C], pOrd, [])
		pOrd = Lower(StrTran(Iif(Empty(pOrd), pKey, pOrd),' ',''))
		If Not Empty(pOrd)
			pOrd = [ Order By ] + pOrd
		EndIf
		pObg = Iif(Type([pObg]) = [O], pObg, .f.)
		pQur = AllTrim(Iif(Type([pQur]) = [C], pQur, []))
		pReq = Iif(Type([pReq]) = [L], pReq, .f.)

		This.pnIdConn = pCnx.pnIdConn
		lcCur = Sys(2015)
		lnErr = Iif(This.pnIdConn > 0, 1, -1)
		lcQrz = []
		laCpo = []

		This.pcTabela = pAqv
		This.pcChaveprimaria = pKey
		This.pcNomecursor = pNme
		This.pcOrderBy1 = pOrd
		This.pcStrquery = pQur
		This.poObjgrid1 = pObg

		If Not Empty(This.pcTabela)
			If Used(lcCur)
				Use In (lcCur)
			EndIf
			If (lnErr > 0)
				lnErr = SQLColumns(This.pnIdConn, This.pcTabela, [FOXPRO], lcCur)
			EndIf
		EndIf
		If Used(lcCur)
			Select (lcCur)
			Index On field_name Tag field_name
			If Empty(This.pcStrquery)
				lcQrz = [select ]
				Select (lcCur)
				Set Order To ([]) In (lcCur)
				Scan
					lcQrz = lcQrz + Lower(Alltrim(Evaluate(lcCur + [.field_name]))) + [,]
				EndScan
				lcQrz = Left(lcQrz, (Len(lcQrz) - 1))
				lcQrz = lcQrz + [ From ] + This.pcTabela + This.pcOrderBy1
				This.pcStrquery = lcQrz
			EndIf
		EndIf
		If (Type([This.poObjgrid1])=[O])
			This.poObjgrid1.RecordSource = []
			If Not pReq
				This.poObjgrid1.ColumnCount = 0
			EndIf 
		EndIf 
		If Not Empty(This.pcStrquery)
			lcQrz = pCnx.fSqlRetornaF(This.pcStrquery)
			If (lnErr > 0)
				lnErr = pCnx.SQLExecute(lcQrz,This.pcNomecursor)
				If Used(This.pcNomecursor)
					lnSca = AFields(laCpo, This.pcNomecursor)
					If (lnSca > 0)
						lnLen = Len(Evaluate(lcCur + [.field_name]))
						Declare This.paFields(ALen(laCpo, 1),(ALen(laCpo, 2) + 2))
						For lnSca = 1 To ALen(laCpo, 1)
							For lnSmt = 1 To ALen(laCpo, 2)
								This.paFields(lnSca, lnSmt) = laCpo(lnSca, lnSmt)
							EndFor
							This.paFields(lnSca, Alen(This.paFields, 2) - 1) = (Seek(Padr(laCpo(lnSca,1), lnLen), lcCur, [field_name]))
						Next
					EndIf
				EndIf
			EndIf
		EndIf
		If (Type([This.poObjgrid1]) = [O]) And Not pReq
			This.poObjgrid1.RecordSource = pNme
		EndIf
		If Used(lcCur)
			Use In (lcCur)
		EndIf
		DoDefault()
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure pColuna(pCln, pFmt, pPcy, pTcl, pLrg, pIgd)
		Local lnNcolgrid, lcMcrCol1, lnSca, pTgd

		pCln = AllTrim(Iif(Type([pCln]) = [C], pCln, []))
		pFmt = AllTrim(Iif(Type([pFmt]) = [C], pFmt, []))
		pFmt = Lower(Iif(Empty(pFmt), [K], pFmt))
		pPcy = AllTrim(Iif(Type([pPcy]) = [C], pPcy, []))
		pTcl = AllTrim(Iif(Type([pTcl]) = [C], pTcl, []))
		pLrg = Iif(Type([pLrg])=[N], pLrg, 85)
		pIgd = Iif(Type([pIgd])=[L], pIgd, .f.)
		pTgd = []

		If Not Empty(pCln)
			pCln = Iif(At((This.pcNomecursor + [.]), Lower(pCln)) > 0, pCln, (This.pcNomecursor + [.] + Lower(pCln)))

			If pIgd
				For lnSca = 1 To ALen(This.paFields,1)
					If At(([.] + Lower(Alltrim(This.paFields(lnSca, 1)))), Lower(pCln)) > 0
						This.paFields(lnSca,ALen(This.paFields,2)) = .t.
						pTgd = Left(Lower(AllTrim(This.paFields(lnSca,1))),10)
						lnSca = ALen(This.paFields,1)
					EndIf
				Next
			EndIf
			With This.poObjgrid1
				lnCln = Max(.ColumnCount, 0) + 1
				If (lnCln = 0)
					lnCln = 1
				EndIf
				.AddColumn(lnCln)
				With .Columns(lnCln)
					If Upper(pCln) = 'LISTAEEST.PADL(NUMES,10,[0])'
						pCln = 'PADL(LISTAEEST.NUMES,10,[0])'
					EndIf 
					.ControlSource = pCln
					.Width = pLrg
					.Movable = .f.
					.Resizable = .f.
					.Format = pFmt
					.InputMask = pPcy
					.SelectOnEntry = .f.
					.FontName = [Courier New]
					.FontSize = 9
					.ReadOnly = .t.
					.Header1.Caption = pTcl
					.Header1.FontName = [Arial]
					.Header1.FontSize = 8
					.Header1.Alignment = 2
					.AddObject([ingrid1], [fwGrdLocate1])
					.CurrentControl = [ingrid1]
					.RemoveObject([text1])

					With .Ingrid1
						.Visible = .t.
						.Format = pFmt
						.InputMask = pPcy
						.FontName = [Courier New]
						.FontSize = 9
						.Alignment = 3
						.BorderStyle = 0
						.Margin = 0
						.Height = 25
						.Width = 100
						.ckeyfilter = []
						.clocateexpression = []
						.cordertag = pTgd
						.cprefixseek = []
						.csearchstring = []
						.cseektag = pTgd
						.lingridactive = pIgd
						.nwaittime = (_DblClick)
					EndWith
				EndWith
			EndWith
		EndIf
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Release
		If Not This.pOpnRelease
			This.pOpnRelease = .t.
			Release m.This
		EndIf
	EndProc
	* Fim **************************************************************************************


	********************************************************************************************
	Procedure Destroy
		If Not This.pOpnRelease
			This.pOpnRelease = .t.
		EndIf
		Return DoDefault()
	EndProc
	* Fim **************************************************************************************
EndDefine 
* Fim **************************************************************************************
