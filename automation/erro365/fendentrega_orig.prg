Local lcAli, lcQry, lcCta, lnCta
pArq = Iif(Type([pArq]) = [C], pArq, [])
pCnx = Iif(Type([pCnx]) = [O], pCnx, Null)
pChv = Iif(Type([pChv]) = [C], pChv, [])

lcAli = []
If Not Empty(pChv)
	Dimension pArr(02)
	Dimension pArr(16)
	Private pTru
	pTru = .T.
	lcCta = pArr(01)

	lcQry = [Select Codigos, Descrs, Ceps, Paises, Endes, Nums, Compls, Bairs, ] + ;
	[Cidas, Estas, Ddds, Tel1s, Tel2s, Contatos, Refers ] + ;
	[From SigCdCeE ] + ;
	[Where 0=0 ] + ;
	Iif(Empty(lcCta),[],[And IClis = '] + lcCta + [' ]) + ;
	[And idEntrega = ']+pChv+[' And descrs = 'ENTREGA' ]

	If (pCnx.SQLExecute(lcQry, [crfRetEntrega1]) < 1)
		=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 3)])
		Return .F.
	Endif
	Go Top In crfRetEntrega1
	If Eof([crfRetEntrega1])
		lcQry = [Select 0 as Codigos, 'Endereço Principal' as Descrs, Ceps, Paises, Endes, Nums, ] + ;
		[Compls, Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contato as Contatos, '' as Refers ] + ;
		[From SigCdCli ] + ;
		[Where IClis = '] + pArr(01) + [']

		If (pCnx.SQLExecute(lcQry, [crfRetEntrega1]) < 1)
			=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 4)])
			Return .F.
		Endif
	Endif
	lcAli = [crfRetEntrega1]
Else

	If Not Empty(pArq)
		lcQry = [Select a.IClis, a.Codigos, a.Atuals, a.Descrs, a.Ceps, a.Paises, ] + ;
		[a.Endes, a.Nums, a.Compls, a.Bairs, a.Cidas, a.Estas, ] + ;
		[a.Ddds, a.Tel1s, a.Tel2s, a.Contatos, a.Refers ] + ;
		[From ] + pArq + [ t] + ;
		[Inner Join SigCdCeE a On a.Iclis = t.ContaEs] + ;
		[Order By a.IClis, a.Codigos]

		If (pCnx.SQLExecute(lcQry, [crfListEnt1]) < 1)
			=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 1)])
			Return .F.
		Endif

		lcQry = [Select a.IClis, 0 as Codigos, 'Endereço Principal' as Descrs, a.Ceps, ] + ;
		[a.Paises, a.Endes, a.Nums, a.Compls, a.Bairs, a.Cidas, a.Estas, ] + ;
		[a.Ddds, a.Tel1s, a.Tel2s, a.Contato as Contatos, ' ' as Refers ] + ;
		[From ] + pArq + [ t ] + ;
		[Inner Join SigCdCli a On a.IClis = t.ContaEs ] + ;
		[Order By a.IClis]

		If (pCnx.SQLExecute(lcQry, [crfListEnt2]) < 1)
			=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 2)])
			Return .F.
		Endif

		If Used([crfListEnt1]) And Used([crfListEnt2])
			Select crfListEnt1
			Index On Iclis Tag Iclis
			Index On Atuals Tag Atuals
			Set Order To

			Select crfListEnt2
			Index On Iclis Tag Iclis
			Set Order To
		Endif
	Else
		If Isnull(pCnx) And Used([crfListEnt1]) And Used([crfListEnt2])
			Dimension pArr(02)
			Dimension pArr(16)
			lcCta = pArr(1)
			lnCta = pArr(2)
			Select crfListEnt1
			If Empty(lnCta)
				Locate For Iclis = lcCta And Atuals = .T.
			Else
				Locate For Iclis = lcCta And Codigos = lnCta
			Endif
			If Not Eof([crfListEnt1])
				lcAli = [crfListEnt1]
			Else
				Select crfListEnt2
				Locate For Iclis = lcCta
				lcAli = [crfListEnt2]
			Endif
		Else
			Dimension pArr(02)
			Dimension pArr(16)
			Private pTru
			pTru = .T.
			lcQry = [Select Codigos, Descrs, Ceps, Paises, Endes, Nums, Compls, Bairs, ] + ;
			[Cidas, Estas, Ddds, Tel1s, Tel2s, Contatos, Refers ] + ;
			[From SigCdCeE ] + ;
			[Where IClis = '] + pArr(01) + [' And ] + ;
			Iif(Empty(pArr(2)), [Atuals = ?pTru], [Codigos = ] + Alltrim(Str(pArr(2), 10)))

			If (pCnx.SQLExecute(lcQry, [crfRetEntrega1]) < 1)
				=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 3)])
				Return .F.
			Endif
			Go Top In crfRetEntrega1
			If Eof([crfRetEntrega1])
				lcQry = [Select 0 as Codigos, 'Endereço Principal' as Descrs, Ceps, Paises, Endes, Nums, ] + ;
				[Compls, Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contato as Contatos, '' as Refers ] + ;
				[From SigCdCli ] + ;
				[Where IClis = '] + pArr(01) + [']

				If (pCnx.SQLExecute(lcQry, [crfRetEntrega1]) < 1)
					=Messagebox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (fEndEntrega - 4)])
					Return .F.
				Endif
			Endif
			lcAli = [crfRetEntrega1]
		Endif
	Endif
Endif

If Not Empty(lcAli) And Used(lcAli) And Not Eof(lcAli)
	pArr(02) = Evaluate(lcAli + [.Codigos])
	pArr(03) = Evaluate(lcAli + [.Descrs])
	pArr(04) = Evaluate(lcAli + [.Ceps])
	pArr(05) = Evaluate(lcAli + [.Paises])
	pArr(06) = Evaluate(lcAli + [.Endes])
	pArr(07) = Evaluate(lcAli + [.Nums])
	pArr(08) = Evaluate(lcAli + [.Compls])
	pArr(09) = Evaluate(lcAli + [.Bairs])
	pArr(10) = Evaluate(lcAli + [.Cidas])
	pArr(11) = Evaluate(lcAli + [.Estas])
	pArr(12) = Evaluate(lcAli + [.Ddds])
	pArr(13) = Evaluate(lcAli + [.Tel1s])
	pArr(14) = Evaluate(lcAli + [.Tel2s])
	pArr(15) = Evaluate(lcAli + [.Contatos])
	pArr(16) = Nvl(Evaluate(lcAli + [.Refers]), [])
	Return .T.
Else
	Return .F.
Endif
