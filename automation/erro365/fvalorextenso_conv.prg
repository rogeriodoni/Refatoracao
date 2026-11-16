Dimension laPtt(3,5), laPtf(5)
lcSep = [ E ]
lcTp2 = []
lcVal = Ltrim(Str(pVal, 15, 2))
lcSpc = 15 - Len(lcVal)
lcVal = Space(lcSpc) + lcVal
lnPos = 14
lnSum = 1
Do While lnPos >= 12
	lcPtt = Substr(lcVal,15-lnPos,1)
	laPtt(lnSum,1) = lcPtt
	lnPos = lnPos - 1
	lnSum = lnSum + 1
Enddo
lnPos = 11
lnSum = 1
Do While lnPos >= 9
	lcPtt = Substr(lcVal, 15 - lnPos, 1)
	laPtt(lnSum, 2) = lcPtt
	lnPos = lnPos - 1
	lnSum = lnSum + 1
Enddo
lnPos = 8
lnSum = 1
Do While lnPos >= 6
	lcPtt = Substr(lcVal, 15 - lnPos, 1)
	laPtt(lnSum, 3) = lcPtt
	lnPos = lnPos - 1
	lnSum = lnSum + 1
Enddo
lnPos = 5
lnSum = 1
Do While lnPos >= 3
	lcPtt = Substr(lcVal, 15 - lnPos, 1)
	laPtt(lnSum, 4) = lcPtt
	lnPos = lnPos - 1
	lnSum = lnSum + 1
Enddo
lnPos = 2
lnSum = 1
Do While lnPos >= 0
	lcPtt = Substr(lcVal, 15 - lnPos, 1)
	laPtt(lnSum, 5) = lcPtt
	lnPos = lnPos - 1
	lnSum = lnSum + 1
Enddo

lnLop = 1
Do While lnLop <= 5
	lnSum = 1
	Do While lnSum <= 3
		If (lnSum = 1)
			lcCen = [ ]
			If (lnLop < 5)
				Do Case
				Case laPtt(lnSum,lnLop) = [1]
					lcCen = Iif(laPtt(2, lnLop) = [0] And laPtt(3,lnLop) = [0], [CEM], [CENTO])
				Case laPtt(lnSum,lnLop) = [2]
					lcCen = [DUZENTOS]
				Case laPtt(lnSum,lnLop) = [3]
					lcCen = [TREZENTOS]
				Case laPtt(lnSum,lnLop) = [4]
					lcCen = [QUATROCENTOS]
				Case laPtt(lnSum,lnLop) = [5]
					lcCen = [QUINHENTOS]
				Case laPtt(lnSum,lnLop) = [6]
					lcCen = [SEISCENTOS]
				Case laPtt(lnSum,lnLop) = [7]
					lcCen = [SETECENTOS]
				Case laPtt(lnSum,lnLop) = [8]
					lcCen = [OITOCENTOS]
				Case laPtt(lnSum,lnLop) = [9]
					lcCen = [NOVECENTOS]
				Endcase
			Endif
		Endif

		If (lnSum = 02)
			lcDez = [ ]
			Do Case
			Case laPtt(lnSum,lnLop) = [1]
				If laPtt(3,lnLop) = [0]
					lcDez = [DEZ]
				Else
					Do Case
					Case laPtt(3,lnLop) = [1]
						lcDez = [ONZE]
					Case laPtt(3,lnLop) = [2]
						lcDez = [DOZE]
					Case laPtt(3,lnLop) = [3]
						lcDez = [TREZE]
					Case laPtt(3,lnLop) = [4]
						lcDez = [QUATORZE]
					Case laPtt(3,lnLop) = [5]
						lcDez = [QUINZE]
					Case laPtt(3,lnLop) = [6]
						lcDez = [DEZESSEIS]
					Case laPtt(3,lnLop) = [7]
						lcDez = [DEZESSETE]
					Case laPtt(3,lnLop) = [8]
						lcDez = [DEZOITO]
					Case laPtt(3,lnLop) = [9]
						lcDez = [DEZENOVE]
					Endcase
				Endif

			Case laPtt(lnSum,lnLop) = [2]
				lcDez = [VINTE]
			Case laPtt(lnSum,lnLop) = [3]
				lcDez = [TRINTA]
			Case laPtt(lnSum,lnLop) = [4]
				lcDez = [QUARENTA]
			Case laPtt(lnSum,lnLop) = [5]
				lcDez = [CINQUENTA]
			Case laPtt(lnSum,lnLop) = [6]
				lcDez = [SESSENTA]
			Case laPtt(lnSum,lnLop) = [7]
				lcDez = [SETENTA]
			Case laPtt(lnSum,lnLop) = [8]
				lcDez = [OITENTA]
			Case laPtt(lnSum,lnLop) = [9]
				lcDez = [NOVENTA]
			Endcase
		Endif

		If (lnSum = 3)
			lcUni = [ ]
			If laPtt(2,lnLop) <> [1]
				Do Case
				Case laPtt(lnSum,lnLop) = [1]
					lcUni = [UM]
				Case laPtt(lnSum,lnLop) = [2]
					lcUni = [DOIS]
				Case laPtt(lnSum,lnLop) = [3]
					lcUni = [TRES]
				Case laPtt(lnSum,lnLop) = [4]
					lcUni = [QUATRO]
				Case laPtt(lnSum,lnLop) = [5]
					lcUni = [CINCO]
				Case laPtt(lnSum,lnLop) = [6]
					lcUni = [SEIS]
				Case laPtt(lnSum,lnLop) = [7]
					lcUni = [SETE]
				Case laPtt(lnSum,lnLop) = [8]
					lcUni = [OITO]
				Case laPtt(lnSum,lnLop) = [9]
					lcUni = [NOVE]
				Endcase
			Endif
		Endif
		lnSum = lnSum + 01
	Enddo

	If (lcCen <> [ ]) And (lnLop <> 6)
		If (lnLop = 2) And laPtf(1)
			lcTp2 = lcTp2 + lcSep
		Endif
		If (lnLop = 3) And (laPtf(2) Or laPtf(1))
			lcTp2 = lcTp2 + lcSep
		Endif
		lcTp2 = lcTp2 + lcCen
	Endif

	If (lcDez <> [ ])
		If (lcCen <> [ ]) Or laPtf(1) Or laPtf(2) Or laPtf(3) Or laPtf(4)
			lcTp2 = lcTp2 + lcSep
		Endif
		lcTp2 = lcTp2 + lcDez
	Endif

	If (lcUni <> [ ])
		If (lnLop = 01) And ((lcCen <> [ ]) Or (lcDez <> [ ]))
			lcTp2 = lcTp2 + lcSep
		Endif
		If (lnLop = 02) And (lcCen <> [ ] Or lcDez <> [ ] Or laPtf(1))
			lcTp2 = lcTp2 + lcSep
		Endif
		If (lnLop = 03) And (lcCen <> [ ] Or lcDez <> [ ] Or laPtf(1) Or laPtf(2))
			lcTp2 = lcTp2 + lcSep
		Endif
		If (lnLop = 04) And (lcCen <> [ ] Or lcDez <> [ ] Or laPtf(1) Or laPtf(2) Or laPtf(3))
			lcTp2 = lcTp2 + lcSep
		Endif
		If (lnLop = 05) And (lcDez <> [ ] Or laPtf(1) Or laPtf(2) Or laPtf(3) Or laPtf(4))
			lcTp2 = lcTp2 + lcSep
		Endif
		lcTp2 = lcTp2 + lcUni
	Endif

	If (Len(Trim(lcCen+lcDez+lcUni)) <> 0)
		If (lnLop = 1)
			lcFnl = Iif(lcCen=[ ] And lcDez=[ ] And lcUni = [UM], [ BILHAO ], [ BILHOES ])
			lcTp2 = lcTp2 + lcFnl
		Endif
		If (lnLop = 2)
			lcFnl = Iif(lcCen=[ ] And lcDez=[ ] And lcUni = [UM], [ MILHAO ], [ MILHOES ])
			lcTp2 = lcTp2 + lcFnl
		Endif
		If (lnLop = 3)
			lcTp2 = lcTp2 + [ MIL ]
		Endif
		laPtf(lnLop) = .T.
	Endif
	lnLop = lnLop + 01
	If (lnLop = 5)
		If laPtf(1) Or laPtf(2) Or laPtf(3) Or laPtf(4)
			lcBde = [ REAL ]
			If (pVal >= 2)
				If Not laPtf(2) And (Not laPtf(3)) And (Not laPtf(4))
					lcTp2 = lcTp2 + [ DE]
				Endif
				lcBde = [ REAIS ]
			Endif
			lcTp2 = lcTp2 + lcBde
		Endif
	Endif
	If (lnLop  = 6) And laPtf(5)
		lcBde = [ CENTAVOS]
		lcTp2 = lcTp2 + lcBde
	Endif
Enddo
lnLen = 150 - Len(Alltrim(lcTp2))
pVal = lcTp2 + [ ] + Replicate([X ], Int(lnLen / 2))
Return pVal
