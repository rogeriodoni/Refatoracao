*==============================================================================
* SIGPRNFS.PRG - Impressao / visualizacao de Nota Fiscal (rotina GLOBAL do legado)
*
* Migrado de: C:\4install\FortyusMC\Fortyus\sigprnfs.PRG (1381 linhas) - Erro365.
* Chamada por: sigregnfBO.Impressao() / Visualizacao() (Emissao Global de NF),
*   com o contrato do legado:  SigPrNfs(Pcnx, pTipo, pcEmps, pcDopes, pnNumes)
*     pTipo "V" = preview | "I" = impressora (grava SigMvNfi.Impress = Impress+1)
*
* TRANSCRICAO, nao reescrita (regra #17): a montagem do espelho da NF a partir de
*   SigCnFNf/SigCnFn2 (posicao de cada campo por serie), SigMvItn/SigMvIts,
*   SigCdPro/SigCdGrp, duplicatas, classificacao fiscal e totais segue o legado
*   linha a linha. Nomes de variaveis mantidos do legado de proposito: eh codigo
*   de rotina global (regra #27), nao form/BO, e renomear 1400 linhas trocaria
*   transcricao por reescrita.
*
* O que MUDOU em relacao ao legado (e por que):
*   1. Conector: o legado cria fSqlConector('Sige'), que sem goSistema.ObjectConn
*      volta com pnIdConn = -1. Aqui ele usa gnConnHandle e pOpnRelease = .T. -
*      o Release/Destroy do fSqlConector faz SQLDisconnect e derrubaria a conexao
*      principal do sistema.
*   2. Retornos de erro devolvem .F. (o legado devolvia .T. com 'Return' vazio);
*      o fim devolve llOk. O sigregnfBO so tira a NF da grade se vier .T.
*   3. Gravacao do modo "I" em transacao manual explicita, restaurada em todo
*      caminho (o Commit() do conector so confirma com Transactions = 2).
*   4. MessageBox -> MsgErro/MsgAviso; acentos em literal -> CHR() (regra #4).
*   O motor de saida eh utils\sigprnfx.prg (FRX gerado em tempo de execucao).
*==============================================================================
#define cnFactor                    (10000.0000/(12 * 8)) && 104.1666

Lparameters Pcnx,pTipo,pcEmps, pcDopes, pnNumes

Local lcMaskCasas, lnMaxCasas, lnItCasas, lcUnits, lnOldDecimals, lnCfoDigitos
Local llOk, lnImpressoras, lcNomeImpressora, lnPalavras, lnDeslV, lcProcura, lcProcura2, ;
		lnTamFolha1,lcFontname1,lcFontname2, lnFontsize1, lnFontsize2, lnNffatorln, lnNffatorcl, ;
		lcStyleDef1,lcNumNf,lnLinhaI,lnColI,lcStrOpSubn,lnTpMargem,lcTitEndEnt, lnNumVias, ;
		lnCnt1,lnFtGDI1, lnTamLinha, llContLinha, lnLinhaAnt, lnLinhaImp, lnLinhaAntObs

If Type('Pcnx')#"O" 
	*-- MIGRADO: conector legado sobre a conexao PRINCIPAL (gnConnHandle).
	*   pOpnRelease = .T. eh OBRIGATORIO: o Release/Destroy do fSqlConector faz
	*   SQLDisconnect(pnIdConn) - sem isso a conexao do sistema inteiro cairia.
	m.sloDatamgr = CreateObject('fSqlConector', gnConnHandle)
	m.sloDatamgr.pOpnRelease = .t.
	_Release = .f.
Else
	m.sloDatamgr = Pcnx
	_Release = .f.
EndIf

If Type('pTipo') # "C"
	pTipo="I"
EndIf

lcSep = Set([Separator])
lcPon = Set([Point])
Set Point To [,]
Set Separator To [.]

lcBuscOper = pcEmps + PcDopes + Str(pnNumes,6)
lcSql = [Select * From SigMvCab Where EmpDopNums = ']+lcBuscOper+[']
If m.slodatamgr.SqlExecute(lcSql,'TempEest') < 1
	=MsgErro('Favor Reinicializar o Processo!!!', 'Falha na Conex' + CHR(227) + 'o (TempEest)')
	Set Point To lcPon
	Set Separator To lcSep
	Return .F.
EndIf

lcSql = [Select * From SigMvNfi Where EmpdopNums = ']+lcBuscOper+[']
If m.slodatamgr.SqlExecute(lcSql,'CrTmpNfis') < 1
	MsgAviso("Esta Opera" + CHR(231) + "" + CHR(227) + "o n" + CHR(227) + "o possui Nota Fiscal Cadastrada...", "Aten" + CHR(231) + "" + CHR(227) + "o!!!")
	Set Point To lcPon
	Set Separator To lcSep
	Return .F.
EndIf

lcSql = [Select emps,codigos From SigMvPec Where EmpdopNums = ']+lcBuscOper+[' order by 1,2]
If m.slodatamgr.SqlExecute(lcSql,'crTmpEstPe') < 1
	=MsgErro('Favor Reinicializar o Processo!!!', 'Falha na Conex' + CHR(227) + 'o (EstPe)')
	Set Point To lcPon
	Set Separator To lcSep
	Return .F.
EndIf

Select 0
If Used('crTplMvNF')
	Use In crTplMvNF
EndIf

lcQuery = [Select nnfftlns, nnfftcls, nDeslv, AgCod,AgCor,AgTam,AgEmb From SigCdPam ]
If (m.sloDataMgr.SqlExecute(lcQuery, 'CrParam') < 1)
	=MsgErro('Favor Reinicializar o Processo!!!', 'Falha na Conex' + CHR(227) + 'o (CrParam)')
	Set Point To lcPon
	Set Separator To lcSep
	Return .F.
EndIf
Goto Top In crParam

m.lnNffatorln = crparam.nnfftlns
m.lnNffatorcl = crparam.nnfftcls
m.lcNfSentido = '0'
m.lnDeslV = Iif(Not IsEmpty(CrParam.nDeslV), CrParam.nDeslV, 1)

Create Cursor crTplMvNF ( Emps C(3), Dopes C(20), Numes N(6), Cpros C(14), CodEmbs C(3), ;
						CodCors C(4), CodTams C(4), Qtds N(10,3), QtdEmbs N(9,2), ;
						QtBaixas N(10,3), PrEmbs N(9,2), CodEmbEnts C(3), QtdEnts N(10,3), ;
						Units N(12,6), DPros C(40), SiTribs C(2), SitTrIcms c(3), Pesos N(9,2), Aliqs N(5,2), ;
						ValIPIs N(12,2), Obs M(4) null, TipoEstos N(1), AliqIcms N(6,2), OrigMercs c(1),;
						nFolha N(5), Icmss N(12,2), TPesos n(12,2))
Index On Cpros + Dpros + Str(Pesos,9,2) + Str(Units,12,6) Tag Cpros
Index On Cpros + CodCors + Str(Units,12,6) Tag CodCors
Index On Cpros + CodTams + Str(Units,12,6) Tag CodTams
Index On Cpros + CodEmbs + Str(Units,12,6) Tag CodEmbs
Index On Cpros + CodCors + CodTams + Str(Units,12,6) Tag CodCorTams
Index On Emps + Dopes + Str( Numes, 6 ) Tag EmpDopNum

Set Decimals to 2
=m.sloDataMgr.Cursorquery('SigCdEmp', 'CrTmpEmp',   'Cemps', TempEest.Emps,  'RazSocs, Razas, PFiscals, Endes, Numeros, Compls, Bairs, Cidas, Estas, Ceps, Cgcs, Ies, Tel1s, Tel2s')
=m.sloDatamgr.cursorquery('SigCdOpe', 'CrTmpOpe',   'Dopes', TempEest.Dopes, 'NFiscals, Casas, ItemAlfas, QtdPrecos')
=m.sloDatamgr.cursorquery('SigOpCdc', 'CrTmpDcOpe', 'Dopes', TempEest.Dopes, 'MaxItNfs, ImpNfObs')
=m.sloDatamgr.cursorquery('SigOpCdd', 'CrTmpOpe2',  'Dopes', TempEest.Dopes, 'Dopes,CasQtds,IdentPro,ImpCdProNf,ImpDfProNf')
=m.sloDatamgr.cursorquery('SigCdUni', 'CrTmpUni',   .f.,     .f.,            'cunis, fators', 'cunis')

Select crTmpUni
Index On cUnis Tag cUnis
Set Order To ('') In crTmpUni

lcCpo = 'Razaos, RClis, Cpfs, Endes, Nums, Compls, Bairs, Ceps, Cidas, Estas, ' + ;
		'Tel1s, Rgs, EndCobs, BaiCobs, CepCobs, CidCobs, EstCobs, Suframas, ddds'

If CrTmpOpe.NFiscals = 1
	=m.SloDatamgr.cursorquery('SigCdCli','CrTmpCli','Iclis',TempEest.Contaos, lcCpo)

Else
	=m.SloDatamgr.cursorquery('SigCdCli','CrTmpCli','Iclis',TempEest.Contads, lcCpo)

EndIf

=m.slodatamgr.cursorquery('SigCdCfo', 'CrTmpCfo', 'Codigos', CrTmpNfis.Cfis, 'Descricaos, NDigitos, SitTribs,IpiNCreds, UnitImps')
=m.slodatamgr.cursorquery('SigCdTif', 'CrTmpTif', 'Codigos', TempEest.TpFats, 'Adendos, Adendocs, TamDesc, TpDescs')
=m.slodatamgr.cursorquery('SigPrTrp', 'CrTmpTra', 'Itras', CrTmpNFis.CodTrans, 'Razaos, Cgcs, Inscs, Endes, Cidas, Estas')
=m.slodatamgr.CursorQuery('SigCdCfo', 'CrTmpCfoS','Codigos', CrTmpNFis.CfoSubs, 'Descricaos, NDigitos, SitTribs')

lcsql = [Select cobsi,tamlinobsi,tamcolobsi,tamlinobs,tamcolobs,esppads,fatbrutos,imppads,tamanhos,l1nf,c1nf,lnfsai,cnfsai,]+;
[lnfent,cnfent,lnatop,cnatop,lcfop,ccfop,lnome,cnome,lcgc,ccgc,ldtemi,cdtemi,lender,cender,lbairr,cbairr,lcep,ccep,lmuni,]+;
[cmuni,lesta,cesta,lfone,cfone,liest,ciest,lfat1num,cfat1num,lfat1val,cfat1val,lfat1vec,cfat1vec,lfat2num,cfat2num,lfat2val,]+;
[cfat2val,lfat2vec,cfat2vec,lfat3num,cfat3num,lfat3val,cfat3val,lfat3vec,cfat3vec,lfat4num,cfat4num,lfat4val,cfat4val,lfat4vec,]+;
[cfat4vec,lfat5num,cfat5num,lfat5val,cfat5val,lfat5vec,cfat5vec,lfat6num,cfat6num,lfat6val,cfat6val,lfat6vec,cfat6vec,lendcob,]+;
[cendcob,linprod,ccodpro,cdespro,cclfis,cstrib,cunid,cqtde,cvluni,cvltot,caicm,caipi,cvipi,lobs,cobs,oorig,oaden,ocor,oemb,]+;
[otam,lbicm,cbicm,lticm,cticm,lfrete,cfrete,lseguro,cseguro,loutras,coutras,ltprod,ctprod,ltipi,ctipi,ltnota,ctnota,ltrnome,]+;
[ctrnome,ltrcgc,ctrcgc,ltrie,ctrie,ltrend,ctrend,ltrmun,ctrmun,ltrest,ctrest,ltpfrete,ctpfrete,lplaca,cplaca,lplacauf,cplacauf,]+;
[lqtvol,cqtvol,lesp,cesp,lmarca,cmarca,lnumero,cnumero,lpbru,cpbru,lpliq,cpliq,lclas1,cclas1,impclas1,lclas2,cclas2,impclas2,]+;
[lclas3,cclas3,impclas3,lclas4,cclas4,impclas4,lclas5,cclas5,impclas5,lclas6,cclas6,impclas6,l2nf,c2nf,tamdesc,ldtemif,cdtemif,]+;
[lfatnum,cfatnum,ltnotaf,ctnotaf,ldupnum,cdupnum,lfatvec,cfatvec,lvalext,cvalext,ldescser,cdescser,ncdser,nldser,lvaliss,cvaliss,]+;
[lvalser,cvalser,pirs,piss,cbaicob,ccepcob,cdtsaidas,cestcob,cmuncob,lbaicob,lcepcob,ldtsaidas,lestcob,letras,lmuncob,series,]+;
[cpespro,impc1,impc2,impc3,impc4,impc5,impc6,cposfis,csufras,lposfis,lsufras,corigem,ctqtde,ltqtde,cdesconto,ldesconto,cclas7,]+;
[impc7,impclas7,lclas7,ctnotar,ltnotar,cfat10num,cfat10val,cfat10vec,cfat7num,cfat7val,cfat7vec,cfat8num,cfat8val,cfat8vec,]+;
[cfat9num,cfat9val,cfat9vec,lcselo,lfat10num,lfat10val,lfat10vec,lfat7num,lfat7val,lfat7vec,lfat8num,lfat8val,lfat8vec,]+;
[lfat9num,lfat9val,lfat9vec,lcnfselo,marpads,lcendemp,lcrazemp,tpcasas,pesovols,emps,tipos,ctamfolhas,cidchaves ] + ;
[From SigCnFnf Where Series = ']+CrTmpNfis.Series+[' order by emps,series]

llOk = .T.
If m.slodatamgr.SqlExecute(lcSql,'NF') < 0
	MsgAviso('N' + CHR(227) + 'o Existe Impressora Configurada para a Impress' + CHR(227) + 'o Dessa ' + ;
	           'Nota Fiscal na S' + CHR(233) + 'rie ' + AllTrim(CrTmpNfis.Series), ;
	           'Imposs' + CHR(237) + 'vel Impress' + CHR(227) + 'o de Nota Fiscal')
	llOk = .F.
EndIf

lcSql  = [select series,emps,lendent,cendent,lbaient,cbaient,lmunent,cmunent,lestent,cestent,lcepent,ccepent,lfoneent,cfoneent,] + ;
		 [liniped,ciniped,ntpmargems,lendtite,cendtite,ctitent,lEmpNome,cEmpNome,lEmpCgc,cEmpCgc,lEmpIest,cEmpIest,lEmpEnder,] + ;
		 [cEmpEnder,lEmpBair,cEmpBair,lEmpMuni,cEmpMuni,lEmpCep,cEmpCep,lEmpFone,cEmpFone,lEmpEsta,cEmpEsta,lXinc,cXinc,lenXinc,]+;
		 [lSac,cSac,contSac, lbipi, cbipi, LOPLOC, COPLOC, LOPCVD, COPCVD, LOPNVD, COPNVD, LOPCRP, COPCRP, LOPNRP, COPNRP, nVias, ] + ; 
		 [aClas1,aClas2,aClas3,aClas4,aClas5,aClas6,aClas7,a2Nf,atnotar,ainiped,aobs,aselo,anfselo,liniped2,ciniped2,ainiped2,nftgdi1s,] +;
		 [lClas8,cClas8,ImpClas8,ImpC8,aClas8,lClas9,cClas9,ImpClas9,ImpC9,aClas9,] + ;
		 [lClas10,cClas10,ImpClas10,ImpC10,aClas10,lClas11,cClas11,ImpClas11,ImpC11,aClas11,] + ;
		 [lClas12,cClas12,ImpClas12,ImpC12,aClas12,lbicmss,cbicmss,lvicmss,cvicmss, ] +;
		 [lnatopsub,cnatopsub,lcfopsub,ccfopsub,ccfoppro,cpesomet,cunipesos,totfsize ] + ;
		 [ from SigCnFn2 where series = ']+CrTmpNfis.Series+[' order by emps,series]
If m.slodatamgr.SqlExecute(lcSql,'NF2') < 0
	MsgAviso('Erro na Configura' + CHR(231) + '' + CHR(227) + 'o dos da Nota Fiscal na S' + CHR(233) + 'rie ' + AllTrim(CrTmpNfis.Series) + '.', ;
	           'Leitura de Dados')
	llOk = .F.
EndIf

* Apanhando a Serie da Nota Fical
=m.sloDataMgr.CursorQuery([SigCdSer], [crTmpSerie], [EmpCods], CrTmpNfis.Emps + CrTmpNfis.Series)
If Not Used([crTmpSerie])
	=MsgErro([Favor Reinicializar o Processo!!!], [Falha na Conex] + CHR(227) + [o (SigPrNfs - CursorQuery - crTmpSerie 1)])
	Set Point To lcPon
	Set Separator To lcSep
	Return .f.
EndIf
Go Top In crTmpSerie
If Eof([crTmpSerie])
	=m.sloDataMgr.CursorQuery([SigCdSer], [crTmpSerie], [EmpCods], Space(3) + CrTmpNfis.Series)
	If Not Used([crTmpSerie])
		=MsgErro([Favor Reinicializar o Processo!!!], [Falha na Conex] + CHR(227) + [o (SigPrNfs - CursorQuery - crTmpSerie 2)])
		Set Point To lcPon
		Set Separator To lcSep
		Return .f.
	EndIf
	Go Top In crTmpSerie
EndIf
If Eof([crTmpSerie])
	=MsgAviso([A S] + CHR(233) + [rie "] + CrTmpNfis.Series + [" da Nota Fiscal N] + CHR(227) + [o Est] + CHR(225) + [ Cadastrada!!!], [Aten] + CHR(231) + [] + CHR(227) + [o!!!])
	Set Point To lcPon
	Set Separator To lcSep
	Return .f.
EndIf

Select NF
Index On Emps Tag Emps
If Not Seek(TempEest.Emps, 'NF', 'Emps')
	=Seek(Space(3), 'NF', 'Emps')
EndIf

Select NF2
Index On Emps Tag Emps
If Not Seek(TempEest.Emps, 'NF2', 'Emps')
	=Seek(Space(3), 'NF2', 'Emps')
EndIf

lnTpMargem = Nvl(NF2.nTpMargems,0)
lnTpMargem = Iif(InList(lnTpMargem,1,2),lnTpMargem,1)
lcTitEndEnt = Alltrim(Nvl(NF2.cTitEnt,''))
lnFtGDI1 = NF2.nftgdi1s

If llOk And IsEmpty(NF.ImpPads)
	MsgAviso('Nome da Impressora de Nota Fiscal Inv' + CHR(225) + 'lido.' + Chr(13) + ;
	           'Corrija e tente a impress' + CHR(227) + 'o novamente !', ;
	           'Imposs' + CHR(237) + 'vel Impress' + CHR(227) + 'o de Nota Fiscal')
	llOk = .F.	
EndIf

lnNumVias = Nvl(NF2.nVias, 0)
lnNumVias = Iif(Ptipo="V" Or lnNumVias < 1, 1, lnNumVias)
lcFontname1 = 'Courier New' 
lcStyleDef1 = ''

If At('/',NF.cTamfolhas)>0
	lcFontname1 = Alltrim(Substr(NF.cTamfolhas,1,(At('/',NF.cTamfolhas)-1)))
EndIf 
If At(',',lcFontname1,2)>0
	lcStyleDef1 = Upper(Alltrim(Substr(lcFontname1,(At(',',lcFontname1,2)+1))))
EndIf 
If At(',',lcFontname1,1)>0
	lcFontname1 = Alltrim(Substr(lcFontname1,1,(At(',',lcFontname1)-1)))
EndIf 
lnTamFolha1 = Val(Alltrim(Substr(NF.cTamfolhas,(At('/',NF.cTamfolhas,1)+1),(At('/',NF.cTamfolhas,2)-(At('/',NF.cTamfolhas,1)+1)))))
lnImpressoras = APrinters(laPrinters)
lnTamFnt = Iif( IsEmpty(NF.Tamanhos), 9, NF.Tamanhos )
lnTamLinha  = Fontmetric(7,lcFontName1,lnTamFnt,lcStyleDef1) * NF.TamDesc

If llOk And lnImpressoras > 0
	llOk = .F.	
 	For lnI=1 to lnImpressoras
 		If AllTrim(Upper(laPrinters(lnI,1))) == AllTrim(Upper(NF.ImpPads))
 			lcNomeImpressora = AllTrim(laPrinters(lnI,1))
			llOk = .T.
			Exit
		Endif
	EndFor
	
	If Not llOk
		MsgAviso('Impressora ' + AllTrim(Upper(NF.ImpPads)) + ;
		           ' n' + CHR(227) + 'o est' + CHR(225) + ' configurada no Painel de Controle do seu microcomputador.' + ;
		           'Corrija e Tente novamente a impress' + CHR(227) + 'o dessa Nota Fiscal.', ;
		           'Imposs' + CHR(237) + 'vel Impress' + CHR(227) + 'o de Nota Fiscal')
	EndIf
Else
	If llOk And lnImpressoras = 0
		MsgAviso('N' + CHR(227) + 'o Existe Nenhuma Impressora no Painel de Controle !', ;
		'Imposs' + CHR(237) + 'vel Impress' + CHR(227) + 'o de Nota Fiscal')
		llOk = .F.
	EndIf
endif
	
If llOk
	lcProcura = TempEest.Emps + TempEest.Dopes + Str(TempEest.Numes,6)
	
	=m.slodatamgr.cursorquery('SigMvItn','crLclMvItn','EmpDopNums',lcProcura)
	=m.slodatamgr.cursorquery('SigMvIts','crLclMvIts','EmpDopNums',lcProcura)
	
	Select crLclMvIts
	Index On Citens Tag Citens

	Select crLclMvItn
	If CrTmpOpe.itemalfas=1
		Index On Cpros Tag Cpros
	Else 
		If CrTmpOpe.itemalfas=3
			Index On Moedas+Reffs Tag Moedas
		Else
			Index On Citens Tag citens
		endif
	EndIf

	Scan
		lcProcura2 = crLclMvItn.CItens
		=m.slodatamgr.cursorquery('SigCdPro','CrTmpPro','Cpros',crLclMvItn.Cpros,'CGrus, OrigMercs')
		=m.slodatamgr.cursorquery('SigCdGrp','CrTmpGru','Cgrus',CrTmpPro.CGrus)

		Select crLclMvIts
		If !Seek(lcProcura2)
			Select crLclMvItn
			xOrig = Iif(Not IsEmpty(crLclMvItn.OrigMercs),crLclMvItn.OrigMercs,CrTmpPro.OrigMercs)
			If Not Seek( crLclMvItn.Cpros + crLclMvItn.DPros + Str(crLclMvItn.Pesos,9,2) + Str(crLclMvItn.Units,12,6), 'crTplMvNF' , 'CPros' ) Or crTplMvNF.OrigMercs # xOrig Or ;
				Alltrim(crLclMvItn.Cpros) = '.'
				Insert Into crTplMvNF ( Emps, Dopes, Numes, Cpros, Units, DPros, SiTribs, ;
									  Pesos, TPesos, Aliqs, TipoEstos, AliqIcms, OrigMercs, Icmss, SitTrIcms ) ;
					Values ( crLclMvItn.Emps, crLclMvItn.Dopes, crLclMvItn.Numes, crLclMvItn.Cpros, ;
							 crLclMvItn.Units, crLclMvItn.DPros, crLclMvItn.SiTribs, ;
							 crLclMvItn.Pesos, crLclMvItn.TPesos, crLclMvItn.Aliqs, ;
							 CrTmpGru.TipoEstos, crLclMvItn.AliqIcms, xOrig, crLclMvItn.Icmss, crLclMvItn.SitTrIcms )
			EndIf
			Select crTplMvNF
			Replace crTplMvNF.Qtds     With crTplMvNF.Qtds + crLclMvItn.Qtds, ;
					crTplMvNF.QtBaixas With crTplMvNF.QtBaixas + crLclMvItn.QtBaixas, ;
					crTplMvNF.Obs      With crTplMvNF.Obs + Iif( Not IsEmpty(crTplMvNF.Obs), ;
									      Chr(13) + Chr(10),'') + crLclMvItn.Obs,;
					crTplMvNF.ValIPIs  With crTplMvNF.ValIPIs + crLclMvItn.ValIPIs
									      
		Else
			Goto Top In crParam
			If InList(CrTmpGru.TipoEstos,2,3,4) And (crParam.AgCod Or crParam.AgCor Or ;
					crParam.AgTam Or crParam.AgEmb)	&& Agrupamento da Nota Fiscal
				Do Case
					Case crParam.AgCod
						lcChave = 'crLclMvIts.Cpros'
						lcOrdem = 'CPros'
						
					Case crParam.AgCor
						lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodCors'
						lcOrdem = 'CodCors'
						
					Case crParam.AgTam
						lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodTams'
						lcOrdem = 'CodTams'

					Case crParam.AgEmb
						lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodEmbs'
						lcOrdem = 'CodEmbs'

					OtherWise
						lcChave = 'crLclMvIts.Cpros'
						lcOrdem = 'CPros'
					
				EndCase
			Else
				If InList(CrTmpGru.TipoEstos, 2, 3, 4) And ( nf.otam # 0 Or nf.ocor # 0 Or nf.oemb # 0 )
					Do Case
						Case CrTmpGru.TipoEstos = 2
							lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodCors'
							lcOrdem = 'CodCors'
							
						Case CrTmpGru.TipoEstos = 3
							lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodTams'
							lcOrdem = 'CodTams'

						Case CrTmpGru.TipoEstos = 4
							lcChave = 'crLclMvIts.Cpros + crLclMvIts.CodCors + crLclMvIts.CodTams'
							lcOrdem = 'CodCorTams'

						OtherWise
							lcChave = 'crLclMvIts.Cpros'
							lcOrdem = 'CPros'
						
					EndCase
				Else
					lcChave = 'crLclMvIts.Cpros'
					lcOrdem = 'CPros'
				EndIf
			EndIf
			
			lcChave = lcChave + ' + Str(crLclMvItn.Units,12,6)'
			Select crLclMvIts
			Scan While Citens = lcProcura2
				xOrig = Iif(Not IsEmpty(crLclMvItn.OrigMercs),crLclMvItn.OrigMercs,CrTmpPro.OrigMercs)
				Select crTplMvNF
				Set Order to ( lcOrdem )
				Seek ( lcChave )
				If Eof() Or crTplMvNF.OrigMercs # xOrig
					Insert Into crTplMvNF ( Emps, Dopes, Numes, Cpros, Units, DPros, SiTribs, SitTrIcms, ;
										  Pesos, TPesos, Aliqs, CodEmbs, CodCors, CodTams, ;
										  PrEmbs, CodEmbEnts, Obs, TipoEstos, AliqIcms, OrigMercs, QtdEmbs, Icmss ) ;
						Values ( crLclMvItn.Emps, crLclMvItn.Dopes, crLclMvItn.Numes, crLclMvItn.Cpros, ;
								 crLclMvItn.Units, crLclMvItn.DPros, crLclMvItn.SiTribs, crLclMvItn.SitTrIcms, ;
								 crLclMvItn.Pesos, crLclMvItn.TPesos, crLclMvItn.Aliqs, ;
								 crLclMvIts.CodEmbs, crLclMvIts.CodCors, crLclMvIts.CodTams, ;
								 crLclMvIts.PrEmbs, crLclMvIts.CodEmbEnts, crLclMvItn.Obs, ;
								 CrTmpGru.TipoEstos, crLclMvItn.AliqIcms, xOrig, crLclMvIts.QtdEmbs, crLclMvItn.Icmss )
				EndIf
				Replace crTplMvNF.Qtds With crTplMvNF.Qtds + (crLclMvIts.Qtds * crLclMvIts.QtdEmbs ), ;
						crTplMvNF.QtBaixas With crTplMvNF.QtBaixas + crLclMvIts.QtBaixas,;
						crTplMvNF.ValIPIs  With crTplMvNF.ValIPIs + crLclMvItn.ValIPIs
				Select crLclMvIts
			EndScan
		EndIf
	EndScan

	Select crTplMvNF	
	lnItens = Reccount('crTplMvNF')
	lnMaxNF = Iif(CrTmpDcOpe.MaxItNfs = 0, 99999, CrTmpDcOpe.MaxItNfs)
	lnNotas = Iif(lnItens=0,1,Iif(Int(lnItens / lnMaxNF) - (lnItens / lnMaxNF) < 0, Int(lnItens / lnMaxNF) + 1, Int(lnItens / lnMaxNF)))
	
	** Calculo para saber a qtd de linhas a serem impressas
	llContLinha = .F.

	llSoSubSt = .F.
	If( nf2.lcfopsub > 0 ) and not Empty(CrTmpNFis.CfoSubs)
		llSoSubSt = .T.
		Select crTplMvNF
		Scan
			=m.slodatamgr.cursorquery('SigCdPro','CrTmpPro','Cpros',crTplMvNF.cPros, [SitTrIcms])
			lcSitTrSub = Iif( IsEmpty( CrTmpCfoS.SitTribs ), Alltrim( CrTmpPro.SitTrIcms ), Alltrim( CrTmpCfoS.SitTribs ) )
			=m.sloDataMgr.CursorQuery([SigCdIcm],[crSigCdIcm],[Codigos],lcSitTrSub)						
			If( crSigCdIcm.Tipos <> [F] )
				llSoSubSt = .F.
			Endif
		EndScan			
		Go Top in crTplMvNF
	Endif

	Store 0 to xTotProd, xTotIcms, xTotIpi, xBaseIcm, lnTotalQtde, lnLinhaAnt, lnLinhaImp, lnLinhaAntObs

	For lnNFAtual = 1 To lnNotas
		Create Cursor TmpClass ( ClFiscals c(10), Numero c(2), Impresso l )
		Index on Numero Tag Numero
		Index on ClFiscals Tag ClFiscals

		lnLinhaImp = 0
		_xCla = 0
	
		For _xCla = 1 to 12
			_xv = Iif(_xCla <= 7,'nf.ImpClas','nf2.ImpClas') + Alltrim(Str( _xcla, 2 ))
			If !IsEmpty( &_xv. )
				If Nf.Letras = 1
					_xClaLet = Chr( _xCla + 64 )
				Else
					_xClaLet = Alltrim(Str( _xCla, 2 ))
				Endif
				Insert Into TmpClass ( ClFiscals, Numero, Impresso ) ;
							  Values ( &_xv., _xClaLet, .t. )
			Else
				_xCla = _xCla - 1
				Exit
			Endif
		Next

		Create Cursor TmpImprime ( Linha n(6,2), Coluna n(6,2), Conteudo c(100), Style c(3),fontname c(64), fontsize i, Angulo i, Align c(1), MaxLen n(3) )
		Index On ( Linha * 1000000000 ) + ( Coluna * 100 ) Tag Ordem

		If IsEmpty( lcFontname1 )
			xF = ''
			xFm = ''
			m.lcFontname2 = ''
			m.lnFontsize1 = 0
			m.lnFontsize2 = 0
		Else
			If IsEmpty( NF.Tamanhos )
				xF  = 'Font "' + Alltrim( lcFontname1 ) + '",9'
				xFm = 'Font "' + Alltrim( lcFontname1 ) + '",11'
				m.lcFontname2 = Alltrim( lcFontname1 )
				m.lnFontsize1 = 9
				m.lnFontsize2 = 11
			Else
				xF  = 'Font "' + Alltrim( lcFontname1 ) + '",' + Allt( Str( Nf.Tamanhos ) )
				xFm = 'Font "' + Alltrim( lcFontname1 ) + '",' + Allt( Str( Nf.Tamanhos + 2 ) )
				m.lcFontname2 = Alltrim( lcFontname1 )
				m.lnFontsize1 = Nf.Tamanhos
				m.lnFontsize2 = (Nf.Tamanhos+2)
			Endif
		Endif

		*** Razao Social da Empresa e Endereco da Empresa

		If ! IsEmpty(Nf.lcRazEmp)
			lcCpl = [NOVA RAZ] + CHR(195) + [O SOCIAL : ]
			=Grava(Val(Substr(Nf.lcRazEmp,1,6)),Val(Substr(Nf.lcRazEmp,7)),lcCpl + CrTmpEmp.RazSocs)
		Endif

		If ! IsEmpty(Nf.lcEndEmp)
			lcCpl = [NOVO ENDERE] + CHR(199) + [O : ]
			=Grava(Val(Substr(Nf.lcEndEmp,1,6)),Val(Substr(Nf.lcEndEmp,7)),lcCpl + Alltrim(CrTmpEmp.Endes) + ;
				   " " + Alltrim(CrTmpEmp.Numeros) + " " + Alltrim(CrTmpEmp.Bairs) + " " + Alltrim(CrTmpEmp.Cidas) + ;
				   " " + Alltrim(CrTmpEmp.Estas) + " " + Alltrim(CrTmpEmp.Ceps))
		Endif

		*** Cabecalho
		=Grava( nf.l1nf, nf.c1nf, CrTmpNfis.NFis, "B" )

		If CrTmpNfis.Operas = "S"
			=Grava( nf.lnfsai, nf.cnfsai, 'X' )
		Else
			=Grava( nf.lnfent, nf.cnfent, 'X' )
		EndIf

		If not llSoSubSt
			=Grava( nf.lnatop, nf.cnatop, Left( Alltrim( CrTmpCfo.Descricaos ), 35 ) )
			lnCfoDigitos = iif(Type('CrTmpCfo.NDigitos') = 'N' And CrTmpCfo.NDigitos >= 4, CrTmpCfo.NDigitos, 4)
			=Grava( nf.lcfop, nf.ccfop, Left( Alltrim( CrTmpNfis.CFis ), lnCfoDigitos ) )
		Endif			
		
		** Substituicao Tributaria
		If not Empty(crTmpNFis.CfoSubs)
			=Grava( nf2.lnatopsub, nf2.cnatopsub, Left( Alltrim( CrTmpCfoS.Descricaos ), 35 ) )
			lnCfoDigiSub = Iif(Type('CrTmpCfoS.NDigitos') = 'N' And CrTmpCfoS.NDigitos >= 4, CrTmpCfoS.NDigitos, 4)
			=Grava( nf2.lcfopsub, nf2.ccfopsub, Left( Alltrim( CrTmpNFis.CfoSubs ), lnCfoDigiSub ) )
		Endif			
		**

		If !IsEmpty( CrTmpNfis.DtSaidas )
			=Grava( nf.ldtsaidas, nf.cdtsaidas, Dtoc( CrTmpNfis.DtSaidas ) )
		EndIf
		
		=Grava( nf.lposfis, nf.cposfis, 'C' + CHR(243) + 'digo Posto Fiscal : ' + CrTmpEmp.PFiscals )
		=Grava( nf2.lXinc, nf2.cXinc, Replicate('X',nf2.lenXinc))
		=Grava( nf2.lSac,  nf2.cSac,  Alltrim(nf2.contSac))

		*** Destinatario / Remetente
		If !IsEmpty(CrTmpCli.Razaos)
			=Grava( nf.lnome, nf.cnome, Alltrim( CrTmpCli.Razaos ) )
		Else
			=Grava( nf.lnome, nf.cnome, Alltrim( CrTmpCli.RClis ) )
		EndIf
		=Grava( nf.lcgc, nf.ccgc, Alltrim( CrTmpCli.Cpfs ) )
		=Grava( nf.ldtemi, nf.cdtemi, Dtoc( CrTmpNfis.Emis ), 'X') &&, .f., .f., [R], 10)

		=Grava( nf.ldtemif, nf.cdtemif, Dtoc( CrTmpNfis.Emis ) )
	
		*** Endereco de Entrega
		Dimension laArray(2)
		laArray(1) = TempEest.ContaEs
		laArray(2) = TempEest.LocalEnts

		If fEndEntrega(@laArray, sloDataMgr)
			lcEnd = Alltrim(laArray(06)) + ;
					Iif(Empty(laArray(07)), '', ', ' + Alltrim(laArray(07))) + ;
					Iif(Empty(laArray(08)), '', ' - ' + Alltrim(laArray(08)))

			=Grava(nf2.lendtite, nf2.cendtite,  Alltrim(lcTitEndEnt))
			=Grava(nf2.lendent,  nf2.cendent,  Alltrim(lcEnd))
			=Grava(nf2.lbaient,  nf2.cbaient,  Alltrim(laArray(09)))
			=Grava(nf2.lcepent,  nf2.ccepent,  Alltrim(laArray(04)))
			=Grava(nf2.lmunent,  nf2.cmunent,  Alltrim(laArray(10)))
			=Grava(nf2.lestent,  nf2.cestent,  Alltrim(laArray(11))) 
			=Grava(nf2.lfoneent, nf2.cfoneent, Alltrim(laArray(13)))
		EndIf 

		lcEnd = Alltrim(CrTmpEmp.Endes) + ;
				Iif(Empty(Alltrim(CrTmpEmp.Numeros)), [], [, ] + Alltrim(CrTmpEmp.Numeros)) + ;
				Iif(Empty(Alltrim(CrTmpEmp.Compls)),  [], [ - ] + Alltrim(CrTmpEmp.Compls))

		lcTel = Alltrim(CrTmpEmp.Tel1s) + Iif(Empty(Alltrim(CrTmpEmp.Tel2s)), [], [ / ] + Alltrim(CrTmpEmp.Tel2s))

		=Grava(nf2.lEmpNome,  nf2.cEmpNome,  Alltrim(CrTmpEmp.RazSocs))
		=Grava(nf2.lEmpCgc,   nf2.cEmpCgc,   Alltrim(CrTmpEmp.Cgcs))
		=Grava(nf2.lEmpIest,  nf2.cEmpIest,  Alltrim(CrTmpEmp.Ies))
		=Grava(nf2.lEmpEnder, nf2.cEmpEnder, Alltrim(lcEnd))
		=Grava(nf2.lEmpBair,  nf2.cEmpBair,  Alltrim(CrTmpEmp.Bairs))
		=Grava(nf2.lEmpMuni,  nf2.cEmpMuni,  Alltrim(CrTmpEmp.Cidas))
		=Grava(nf2.lEmpCep,   nf2.cEmpCep,   Alltrim(CrTmpEmp.Ceps))
		=Grava(nf2.lEmpEsta,  nf2.cEmpEsta,  Alltrim(CrTmpEmp.Estas))
		=Grava(nf2.lEmpFone,  nf2.cEmpFone,  Alltrim(lcTel))
		 
		=Grava(nf.lender, nf.cender, Alltrim(CrTmpCli.Endes) + ' ' + Alltrim(CrTmpCli.Nums) + ' ' + Alltrim(CrTmpCli.Compls))
		=Grava(nf.lbairr, nf.cbairr, Alltrim(CrTmpCli.Bairs))
		=Grava(nf.lcep,   nf.ccep,   Alltrim(CrTmpCli.Ceps))
		=Grava(nf.lmuni,  nf.cmuni,  Alltrim(CrTmpCli.Cidas))
		=Grava(nf.lesta,  nf.cesta,  Alltrim(CrTmpCli.Estas))
		=Grava(nf.lfone,  nf.cfone,  Alltrim(CrTmpCli.ddds)+[ ]+Alltrim(CrTmpCli.Tel1s))

		If Empty(Alltrim(CrTmpCli.Endes))
			=MsgErro('O Endere' + CHR(231) + 'o P/Nota Fiscal est' + CHR(225) + ' em branco!!!', 'Cancelado Emiss' + CHR(227) + 'o da N.f.')
			Set Point To lcPon
			Set Separator To lcSep
			Return .F.
		EndIf

		If Empty(Alltrim(CrTmpCli.Estas))
			=MsgErro('O Estado P/Nota Fiscal est' + CHR(225) + ' em branco!!!', 'Cancelado Emiss' + CHR(227) + 'o da N.f.')
			Set Point To lcPon
			Set Separator To lcSep
			Return .F.
		EndIf

		=Grava( nf.liest, nf.ciest, Alltrim( CrTmpCli.Rgs ) )
		=Grava( nf.lendcob, nf.cendcob, Alltrim( CrTmpCli.EndCobs ) )
		=Grava( nf.lbaicob, nf.cbaicob, Alltrim( CrTmpCli.BaiCobs ) )
		=Grava( nf.lcepcob, nf.ccepcob, Alltrim( CrTmpCli.CepCobs ) )
		=Grava( nf.lmuncob, nf.cmuncob, Alltrim( CrTmpCli.CidCobs ) )
		=Grava( nf.lestcob, nf.cestcob, Alltrim( CrTmpCli.EstCobs ) ) 
		If !IsEmpty( CrTmpCli.Suframas )
			=Grava( nf.lsufras, nf.csufras, 'C' + CHR(243) + 'digo Suframa : ' + Alltrim( CrTmpCli.Suframas ) ) 
		Endif
		
		* Dados da Operacao
		If Not Empty(nf2.LOPLOC) And Not Empty(nf2.COPLOC)
			=Grava(nf2.LOPLOC, nf2.COPLOC, Alltrim(TempEest.Localizas))
		EndIf
			
		If Not Empty(nf2.LOPCVD) And Not Empty(nf2.COPCVD) And Not Empty(TempEest.Vends)
			=Grava(nf2.LOPCVD, nf2.COPCVD, Alltrim(TempEest.Vends))
		EndIf
		
		If Not Empty(nf2.LOPNVD) And Not Empty(nf2.COPNVD) And Not Empty(TempEest.Vends)
			m.sloDataMgr.CursorQuery([SigCdCli], [LocalCli], [IClis], TempEest.Vends, [RClis])
			=Grava(nf2.LOPNVD, nf2.COPNVD, Alltrim(LocalCli.RClis))
		EndIf
		
		If Not Empty(nf2.LOPCRP) And Not Empty(nf2.COPCRP) And Not Empty(TempEest.Resps)
			=Grava(nf2.LOPCRP, nf2.COPCRP, Alltrim(TempEest.Resps))
		EndIf
		
		If Not Empty(nf2.LOPNRP) And Not Empty(nf2.COPNRP) And Not Empty(TempEest.Resps)
			m.sloDataMgr.CursorQuery([SigCdCli], [LocalCli], [IClis], TempEest.Resps, [RClis])
			=Grava(nf2.LOPNRP, nf2.COPNRP, Alltrim(LocalCli.RClis))
		EndIf
		
		*** Desdobramento de Duplicatas
		lcEdn = Tempeest.Emps + Tempeest.Dopes + Str( Tempeest.Numes, 6 )
		lcQuery = [Select a.Vencs, a.FPags, a.Valos, b.ImpNotas ] + ;
					[From SigMvPar a, SigOpFp b ] + ;
				   [Where a.EmpDopNums = '] + lcEDN + [' And ] + ;
				   		 [a.FPags = b.FPags Order by a.Vencs ]

		If (m.sloDataMgr.SqlExecute(lcQuery, 'CrTmpPar') < 1)
			=MsgErro('Favor Reinicializar o Processo!!!', 'Falha na Conex' + CHR(227) + 'o (CrTmpPar)')
			Set Point To lcPon
			Set Separator To lcSep
			Return .F.
		EndIf

		Select CrTmpPar
		_Cont = 0
		Scan
			If !InList(ImpNotas,1,2) Or _Cont >= 10
				Loop
			Endif
			_Cont = _Cont + 1
			If _Cont = 1
				=Grava( nf.ldupnum, nf.cdupnum, CrTmpNfis.NFis + '- 1 ' )
				=Grava( nf.ltnotaf, nf.ctnotaf, Transf( CrTmpNfis.TotNotas, "999,999.99" ), 'X') &&, .f., .f., [R] )
				=Grava( nf.lfatvec, nf.cfatvec, Iif( CrTmpPar.ImpNotas = 1, Dtoc( CrTmpPar.Vencs ), CrTmpPar.FPags ) )
				=Grava( nf.lfatnum, nf.cfatnum, CrTmpNfis.NFis )
			Endif
			If _CONT < 10
				_vx = Str( _Cont, 1 )
			Else 
				_vx = Str( _Cont, 2 )		
			EndIf

			=Grava( nf.lfat&_vx.num, nf.cfat&_vx.num, CrTmpNfis.NFis + '-' + _vx )
			=Grava( nf.lfat&_vx.val, nf.cfat&_vx.val, Transf( CrTmpPar.Valos, "999,999.99" ), 'X') &&, .f., .f., [R], 10 )
			=Grava( nf.lfat&_vx.vec, nf.cfat&_vx.vec, Iif( CrTmpPar.ImpNotas = 1, Dtoc( CrTmpPar.Vencs ), CrTmpPar.FPags ) )
		EndScan

		If _Cont = 0
			=Grava( nf.ltnotaf, nf.ctnotaf, Transf( CrTmpNfis.TotNotas, "999,999,999.99" ), 'X') &&, .f., .f., [R], 10 )
			=Grava( nf.lfatnum, nf.cfatnum, CrTmpNfis.NFis )
		Endif

		lcAlias2 = 'crTplMvNF'
		lnMaxCasas = 2
		lnItCasas  = 2
		If NF.TpCasas # 1	&& Casas Decimais dos Itens e variavel
			lnOldDecimals = Set('Decimals')
			Set Decimals to CrTmpOpe.Casas
			Select &lcAlias2.
			Set Order to EmpDopNum
			=Seek( Tempeest.Emps + Tempeest.Dopes + Str( Tempeest.Numes, 6 ) )
			Scan While Emps + Dopes + Str( Numes, 6 ) = Tempeest.Emps + Tempeest.Dopes + Str( Tempeest.Numes, 6 )
				_Fator = Iif( ( nf.otam # 0 Or nf.ocor # 0 Or nf.oemb # 0 ) And ;
				              ( &lcAlias2..QtdEmbs # 0 ), &lcAlias2..qtdembs, 1 )
				&&                                              123456789.1234
				lcUnits    = Transf( &lcAlias2..Units * _Fator, "9999999.999999" )
				lnItCasas  = Max(lnItCasas, iif(Val(Substr(lcUnits,11,1)) # 0, 3, 2))
				lnItCasas  = Max(lnItCasas, iif(Val(Substr(lcUnits,12,1)) # 0, 4, 2))
				lnItCasas  = Max(lnItCasas, iif(Val(Substr(lcUnits,13,1)) # 0, 5, 2))
				lnItCasas  = Max(lnItCasas, iif(Val(Right(lcUnits,1)) # 0, 6, 2))
				lnMaxCasas = Max(lnItCasas,lnMaxCasas)
			EndScan
			
			Set Decimals to lnOldDecimals
			
		EndIf

		lcMaskCasas = '99999999.' + Replicate('9',iif(lnMaxCasas > 2,lnMaxCasas,2))

		lnItemAtual = 0

		If (crTmpDcOpe.ImpNfObs	= 2)  && 1-Produtos; 2-Observacao
			* Imprime a Observacao do SigMvCab, no Lugar dos Itens
			* Tira a Descricao dos Produtos e Lanca o Campo Obses
			xLinha = nf.linprod
			_Memo = Set( 'Memo' )
			If nf.TamDesc # 0
				Set Memo to nf.TamDesc
			Endif
			For _Linha = 1 to MemLine( Alltrim( TempEest.Obses ) )
				=Grava( xLinha, nf.cdespro, Alltrim( MLine( TempEest.Obses, _Linha ) ), .t. )
				If _Linha # MemLine( Alltrim( TempEest.Obses ) )
					xLinha = xLinha + 1
				Endif
			Next
			Set Memo to _Memo
		Else
			Select &lcAlias2.
			Set Order to EmpDopNum
			=Seek( Tempeest.Emps + Tempeest.Dopes + Str( Tempeest.Numes, 6 ) )
			xLinha = nf.linprod
			
			Scan While (lnMaxNF > lnItemAtual) And Emps + Dopes + Str( Numes, 6 ) = Tempeest.Emps + Tempeest.Dopes + Str( Tempeest.Numes, 6 )

				lnItemAtual = lnItemAtual + 1

				lcCpros  = Cpros
				lnQtds   = Qtds
				CodBarra = Cpros
				lcDPros  = DPros
				
				lcCpo = 'CPros, DPros, DescFis, ClFiscals, Linhas, Metals, Teors, PesoMs, CGrus, CUnis, SitTrIcms, PesoMetal'
				=m.slodatamgr.cursorquery('SigCdPro','CrTmpPro','Cpros',lcCpros, lcCpo)

				lnAliqIcms = 0
				If &lcAlias2..SiTribs = '1'
					lnAliqIcms = CrTmpNfis.Icms
				Endif

				If (&lcAlias2..DPros == CrTmpPro.DPros And !IsEmpty( Strt( CrTmpPro.ClFiscals, '.', '' ) ) ) or ;
					(crTmpOpe2.ImpCdProNf == 1 )
					=Grava( xLinha, nf.ccodpro, Alltrim( CrTmpTif.Adendocs ) + Alltrim( CodBarra ), .t. )
				Endif

				If !IsEmpty( TempEest.TpFats ) And CrTmpTif.TamDesc # 0
					lcDPros = &lcAlias2..DPros
				Else	
					If IsEmpty( CrTmpPro.DescFis ) Or ( &lcAlias2..DPros # CrTmpPro.DPros And CrTmpOpe2.ImpDfProNf = 0 )
						lcDPros = &lcAlias2..DPros
					Else
						lcDPros = crTmpPro.DescFis
					Endif
				EndIf

				* Inserido Para a Mult
				If( NF.TamDesc # 0 )
					lcDPros = Substr(lcDPros, 1, NF.TamDesc)
				EndIf
				
				lcDPros = Strtran(lcDPros, Chr(13) + Chr(10), ' ')

				_Memo = Set( 'Memo' )
				If nf.TamDesc # 0
					Set Memo to nf.TamDesc

				EndIf 

				If( lnLinhaAntObs == 0 )
					For _Linha = Iif(lnLinhaAnt > 0, lnLinhaAnt, 1) to MemLine( Alltrim( lcDPros ) )
						=Grava( xLinha, nf.cdespro, Alltrim( MLine( lcDPros, _Linha ) ), .t. )

						lnLinhaImp = (lnLinhaImp + 1)					

						If _Linha # MemLine( Alltrim( lcDPros ) )
							xLinha = (xLinha + lnDeslV)
							lnItemAtual	= lnItemAtual + 1
						EndIf 

						If (lnLinhaImp + 1) > lnMaxNF And MemLine( Alltrim( lcDPros ) ) > 1
							lnLinhaAnt = (_Linha + 1)

							Exit 

						EndIf 

					Next
				Endif					
				
				If _Linha >= MemLine( Alltrim( lcDPros ) )
					lnLinhaAnt = 0					
				EndIf 

				Set Memo to _Memo
				
				If lnLinhaAnt == 0				
					*** Observacao do Item
					If !IsEmpty( Alltrim( &lcAlias2..Obs ) )
						_Memo = Set( 'Memo' )
						If nf.TamColObsI # 0
							Set Memo to nf.TamColObsI
						Endif
						_QtLinhas = Min( MemLine( Alltrim( &lcAlias2..Obs ) ), nf.TamLinObsI )
						If( _QtLinhas > 0 ) and lnLinhaAntObs == 0
							lnItemAtual	= lnItemAtual + 1
							xLinha = (xLinha + lnDeslV)
						EndIf
						If( lnLinhaAntObs == 0 ) and (lnLinhaImp + 1) > lnMaxNF
							lnLinhaAntObs = 1
						Else
							For _Linha = Iif(lnLinhaAntObs > 0, lnLinhaAntObs, 1) to _QtLinhas
								=Grava( xLinha, nf.cobsI, Alltrim( MLine( &lcAlias2..Obs, _Linha ) ), .t. )
								lnLinhaImp = (lnLinhaImp + 1)					

								If _Linha # MemLine( Alltrim( &lcAlias2..Obs ) )
									xLinha = (xLinha + lnDeslV)
									lnItemAtual	= lnItemAtual + 1
								EndIf 

								If (lnLinhaImp + 1) > lnMaxNF And MemLine( Alltrim( &lcAlias2..Obs ) ) > 1
									lnLinhaAntObs = (_Linha + 1)

									Exit 
								EndIf 
							Next
							If _Linha >= Memline( Alltrim( &lcAlias2..Obs ) )
								lnLinhaAntObs = 0
							Endif
						Endif							
						Set Memo to _Memo
					EndIf						
				Endif															

				_Fator = 1
				If !IsEmpty( Strt( CrTmpPro.ClFiscals, '.', '' ) )
					If !Seek( CrTmpPro.ClFiscals, "TmpClass", "ClFiscals" ) And !IsEmpty( CrTmpPro.ClFiscals )
						_xCla = _xCla + 1
						If Nf.Letras = 1
							_xClaLet = Chr( _xCla + 64 )
						Else
							_xClaLet = Alltrim(Str( _xCla, 2 ))
						Endif

						Insert Into TmpClass ( ClFiscals, Numero ) Values ( CrTmpPro.ClFiscals, _xClaLet )

					EndIf 

					If lnLinhaAnt == 0 and lnLinhaAntObs == 0
						=Grava( xLinha, nf.corigem, &lcAlias2..OrigMercs, .t. )

						If IsEmpty( &lcAlias2..Pesos )
							lcPeso = Transf( fConv_Uni1(CrTmpPro.Pesoms, crTmpPro.cUnis, nf2.cUniPesos), '9999.99' )

						Else
							lcPeso = Transf( fConv_Uni1(&lcAlias2..Pesos, crTmpPro.cUnis, nf2.cUniPesos), '9999.99' )

						Endif	

						=Grava( xLinha, nf.cpespro, lcpeso, .t. )

						**** alteracao para Constantini 25/0/2001
						lctipo = CrTmpPro.cgrus
						lntipo = val(substr(nf.tipos,1,6))
						lcmetal = CrTmpPro.Metals
						lnmetal = val(substr(nf.tipos,7,6))
						lcteor = CrTmpPro.teors
						lnteor = val(substr(nf.tipos,13,6))
						
						=Grava( xLinha, lntipo, lctipo, .t. )
						=Grava( xLinha, lnmetal, lcmetal, .t. )
						=Grava( xLinha, lnteor, lcteor, .t. )
						
						lcPesoMet = Transform( crTmpPro.PesoMetal, '9999.99' ) && Retirado @Z
						=Grava( xLinha, nf2.cPesoMet, lcPesoMet, .T. )

						=Grava( xLinha, nf.cclfis, TmpClass.Numero, .t. )
						lcSitTrib = Iif(Not Empty(&lcAlias2..SitTrIcms), &lcAlias2..SitTrIcms, Iif( IsEmpty( CrTmpCfo.SitTribs ), Alltrim( CrTmpPro.SitTrIcms ), Alltrim( CrTmpCfo.SitTribs ) ))
						=Grava( xLinha, nf.cstrib, lcSitTrib, .t. )

						If nf.otam # 0 Or nf.ocor # 0 Or nf.oemb # 0
							=Grava( xLinha, nf.cUnid, Alltrim( &lcAlias2..CodEmbs ), .t. )
							_Fator = Iif( &lcAlias2..qtdembs # 0, &lcAlias2..QtdEmbs, 1 )

						Else
							=Grava( xLinha, nf.cUnid, Alltrim( CrTmpPro.CUnis ), .t. )

						Endif

						** Substituicao Tributaria
						If( nf2.lcfopsub > 0 ) and not Empty(CrTmpNFis.CfoSubs)
							lcSitTrSub = Iif( IsEmpty( CrTmpCfoS.SitTribs ), Alltrim( CrTmpPro.SitTrIcms ), Alltrim( CrTmpCfoS.SitTribs ) )
							=m.sloDataMgr.CursorQuery([SigCdIcm],[crSigCdIcm],[Codigos],lcSitTrSub)						
							If( crSigCdIcm.Tipos == [F] )
								=Grava( xLinha, nf2.ccfoppro, Left(Alltrim(CrTmpNFis.CfoSubs),lnCfoDigiSub), .T.)
							Else
								=Grava( xLinha, nf2.ccfoppro, Left(Alltrim(CrTmpNFis.Cfis),lnCfoDigitos), .T. )
							Endif						
						Endif
			
						Goto Top In crParam
						
						Do Case
							Case CrTmpOpe2.CasQtds < 0 && sem casa decimal
								lcMaskNCQtd = "999999"

							Case CrTmpOpe2.CasQtds == 0 && com 3 casas decimais
								lcMaskNCQtd = "999999.999"
								
							Otherwise && quantidade configurada pela operacao...
								lcMaskNCQtd = "999999." + Replicate("9", CrTmpOpe2.CasQtds)
							
						EndCase
						
						=Grava( xLinha, nf.cqtde, Transf( lnQtds, lcMaskNCQtd ), .t.) &&, .f., .f., [R] )
						lnTotalQtde = lnTotalQtde + ( lnQtds * _Fator )

						If Left( Strt( CrTmpNfis.CFis, '.', '' ), 2 ) # '31' Or CrTmpCfo.UnitImps = [N]
							Set Decimals to (lnMaxCasas)
							=Grava( xLinha, nf.cvluni, Transf( &lcAlias2..Units * _Fator, lcMaskCasas ), .t.) &&, .f., .f., [R])
							Set Decimals to 2
						EndIf
					EndIf 
				Endif

				If lnLinhaAnt == 0 and lnLinhaAntObs == 0
					If (crTmpOpe.QtdPrecos = 4) && Sim, Total de Peso
						=Grava( xLinha, nf.cvltot, Transf( &lcAlias2..Units * Iif(&lcAlias2..TPesos = 0, 1, &lcAlias2..TPesos) * _Fator, "99999999.99" ), .t.) &&, .f., .f., [R] )
					Else
						=Grava( xLinha, nf.cvltot, Transf( &lcAlias2..Units * lnQtds * _Fator, "99999999.99" ), .t.) &&, .f., .f., [R] )
					EndIf
					
					=Grava( xLinha, nf.caicm, Transf( &lcAlias2..AliqIcms, "99" ), .t. )
					=Grava( xLinha, nf.caipi, Transf( IIF(CrTmpCfo.IpiNCreds = 1,0,&lcAlias2..Aliqs), "99" ), .t. )
					=Grava( xLinha, nf.cvipi, Transf( IIF(CrTmpCfo.IpiNCreds = 1,0,&lcAlias2..ValIpis), "99999.99" ), .t.) &&, .f., .f., [R])

					xLinha   = xLinha + lnDeslV

					Delete In &lcAlias2.
				Else 
					Exit 

				EndIf 

			Endscan
		EndIf

		*** Classificacao Fiscal
		Select TmpClass
		Set Order to Numero
		Scan For !Impresso
			If Nf.Letras = 1
				_xClaLet = Asc( Numero ) - 64
			Else
				_xClaLet = Val( Numero )
			Endif
			If _xClaLet > 12
				Exit
			EndIf
			_xv  = 'clas' + Alltrim(Str( _xClaLet, 2 ))
			_xvl = Iif( _xClaLet <= 7, 'nf.lclas', 'Nf2.lClas') + Alltrim(Str( _xClaLet, 2 ))
			_xvc = Iif( _xClaLet <= 7, 'nf.cclas', 'Nf2.cClas') + Alltrim(Str( _xClaLet, 2 ))
			_xi  = Iif( _xClaLet <= 7, 'Nf.impc', 'Nf2.Impc') + Alltrim(Str( _xClaLet, 2 ))
			
			If &_xi
				=Grava( &_xvl., &_xvc., TmpClass.Numero + '-' + TmpClass.ClFiscals, .T., nf2.a&_xv )
			Else
				=Grava( &_xvl., &_xvc., TmpClass.ClFiscals, .T., nf2.a&_xv )
			Endif
		EndScan

		If (lnNFAtual = lnNotas) && Se For a Ultima Nota
			If TempEest.ValVars # 0
				If TempEest.ValVars > 0
					=Grava( nf.ldesconto, nf.cdesconto, 'Acr' + CHR(233) + 'scimo : ' + Transf( TempEest.ValVars, "999,999,999.99" ), 'X')
				Else
					=Grava( nf.ldesconto, nf.cdesconto, 'Desconto : ' + Transf( Abs( TempEest.ValVars ), "999,999,999.99" ), 'X')
				Endif
			EndIf
			
			=Grava( nf.lbicm, nf.cbicm, Transf( CrTmpNfis.BasecIcms, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf.lticm, nf.cticm, Transf( CrTmpNfis.ValIcms, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			
			=Grava( nf2.lbicmss, nf2.cbicmss, Transform( CrTmpNFis.BcIcmss, "999,999,999.99"), 'X')
			=Grava( nf2.lvicmss, nf2.cvicmss, Transform( CrTmpNFis.Icmss, "999,999,999.99"), 'X')
			
			=Grava( nf.ltprod, nf.ctprod, Transf( CrTmpNfis.TotProds, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf.lfrete, nf.cfrete, Iif(CrTmpNfis.VlFretes=0,CrTmpNfis.ObsFretes,Transf( CrTmpNfis.VlFretes, "999,999,999.99" )), 'X') &&, .f., .f., [R])
			=Grava( nf.lseguro, nf.cseguro, Transf( CrTmpNfis.VlSeguros, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf.loutras, nf.coutras, Transf( CrTmpNfis.DespAces, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf2.lbipi, nf2.cbipi, 'Base Calculo IPI '+Transf( CrTmpNfis.BasecIpis, "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf.ltipi, nf.ctipi, Transf( IIF(CrTmpCfo.IpiNCreds=1,0,CrTmpNfis.ValIpis), "999,999,999.99" ), 'X') &&, .f., .f., [R])
			=Grava( nf.ltnota, nf.ctnota, Transf( CrTmpNfis.TotNotas, "999,999,999.99" ), 'X', .f., nf2.TotFSize) &&, [R] )
			=Grava( nf.ltnotar, nf.ctnotar, Transf( CrTmpNfis.TotNotas, "999,999,999.99" ), 'X', nf2.atnotar) &&, [R] )
			=Grava( nf.ltqtde, nf.ctqtde, 'Total de Quantidade : ' + Transf( lnTotalQtde, "999,999,999.99" ), 'X') &&, .f., .f., [R])

			*** Transportador
			=Grava( nf.ltrnome, nf.ctrnome, CrTmpTra.Razaos ) 
			=Grava( nf.ltrcgc, nf.ctrcgc, CrTmpTra.Cgcs )
			=Grava( nf.ltrie, nf.ctrie, CrTmpTra.Inscs )
			=Grava( nf.ltrend, nf.ctrend, CrTmpTra.Endes )
			=Grava( nf.ltrmun, nf.ctrmun, CrTmpTra.Cidas )
			=Grava( nf.ltrest, nf.ctrest, CrTmpTra.Estas )
			=Grava( nf.ltpfrete, nf.ctpfrete, Str( CrTmpNfis.Fretes, 1 ) )
			=Grava( nf.lplaca, nf.cplaca, CrTmpNfis.Placas )
			=Grava( nf.lplacauf, nf.cplacauf, CrTmpNfis.UfPlacas )

			*** Volumes Transportados
			=Grava( nf.lqtvol, nf.cqtvol, Transf( CrTmpNfis.Qtdes, "999,999" ), 'X') &&, .f., .f., [R])
			=Grava( nf.lesp, nf.cesp, CrTmpNfis.Espes )
			=Grava( nf.lmarca, nf.cmarca, CrTmpNfis.Marcas )
			=Grava( nf.lnumero, nf.cnumero, CrTmpNfis.Numeros )
			=Grava( nf.lpbru, nf.cpbru, Alltrim(Iif(CrTmpNfis.pBrus=0,CrtmpNfis.ObspBrus,Transf( CrTmpNfis.PBrus, "9999999.99" )))+' '+nf2.cUnipesos, 'X') &&, .f., .f., [R])
			=Grava( nf.lpliq, nf.cpliq, Alltrim(Iif(CrTmpNfis.pLiqs=0,CrTmpNfis.ObspLiqs,Transf( CrTmpNfis.PLiqs, "9999999.99" )))+' '+nf2.cUniPesos, 'X') &&, .f., .f., [R])
	
		Else
			=Grava( nf.lbicm,   nf.cbicm,   [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.lticm,   nf.cticm,   [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.ltprod,  nf.ctprod,  [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.lfrete,  nf.cfrete,  [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.lseguro, nf.cseguro, [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.loutras, nf.coutras, [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf2.lbipi,  nf2.cbipi,  [Base Calculo IPI xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.ltipi,   nf.ctipi,   [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.ltnota,  nf.ctnota,  [xxx,xxx,xxx.xx], 'X') &&, .f., .f., [R])
			=Grava( nf.ltnotar, nf.ctnotar, [xxx,xxx,xxx.xx], 'X') &&, nf2.atnotar, .f., [R])

		EndIf

		*** Numero da Nota Fiscal

		If m.lcNfSentido=='0' Or .t.
			=Grava( nf.l2nf, nf.c2nf, CrTmpNfis.NFis, "B", nf2.a2nf )
		Else
			lcNumNf = CrTmpNfis.NFis
			lnLinhaI = nf.l2nf
			lnColI = nf.c2nf

			For lnCnt1=1 To Len(lcNumNf)
				=Grava( lnLinhaI, lnColI, Substr(lcNumNf,lnCnt1,1), "B", nf2.a2nf )
				lnLinhaI = (lnLinhaI + lnDeslV)
			EndFor 
		EndIf 

		*** Selo e NF no Selo
		If !IsEmpty(Nf.lcSelo)
			=Grava(Val(Substr(Nf.lcSelo,1,6)),Val(Substr(Nf.lcSelo,7)),Str(CrTmpNFis.Selos,10),'B',nf2.aSelo)
		Endif
		If !IsEmpty(Nf.lcNFSelo)
			=Grava(Val(Substr(Nf.lcNFSelo,1,6)),Val(Substr(Nf.lcNFSelo,7)),CrTmpNFis.NFis,'B',nf2.aNfSelo)
		EndIf
		
		m.lcStrOpSubn = ''

		If (crTmpDcOpe.ImpNfObs	<> 2)  && 1-Produtos; 2-Observacao
			Select crTmpEstPe
			Scan
				m.lcStrOpSubn = (m.lcStrOpSubn + Iif(Not Empty(m.lcStrOpSubn),'/','') + ;
									crTmpEstPe.emps + '-' + Alltrim(Str(crTmpEstPe.codigos,20,0)))
			EndScan 
			If Not Empty(m.lcStrOpSubn)
				lnLinhaI = nf2.liniped
				lnColI = nf2.ciniped
				= Grava( lnLinhaI, lnColI, m.lcStrOpSubn, .T., nf2.ainiped)
				lnLinhaI = nf2.liniped2
				lnColI = nf2.ciniped2
				= Grava( lnLinhaI, lnColI, m.lcStrOpSubn, .T., nf2.ainiped2)
			EndIf 
		EndIf

		Set Console Off
		Set Printer To Name (m.lcNomeImpressora)
		Set Device To Printer

		If (lnNFAtual = lnNotas) && Se For a Ultima Nota
			*** Valor por Extenso
			_Extenso   = Upper( Padr( fValorExtenso( CrTmpNfis.TotNotas ), 190, 'X ' ) )
			_Linha1Ext = Substr(_Extenso,1,95)
			_Linha2Ext = Substr(_Extenso,96,95)
			
			If Right(_Linha1Ext,1) # ' '
				lnColuna = Rat(' ', _Linha1Ext)
				_Linha1Ext = Substr(_Extenso,1,lnColuna)
				_Linha2Ext = Substr(_Extenso,lnColuna+1,95)
			EndIf

			If Left( _Linha2Ext, 1 ) = 'X'
				_Linha2Ext = ' ' + _Linha2Ext
			Endif

			=Grava( nf.lvalext, nf.cvalext, _Linha1Ext )
			If nf.lvalext # 0 Or nf.cvalext # 0
				=Grava( nf.lvalext+0.8, nf.cvalext, _Linha2Ext )
			Endif

			*** Servicos
			If (crTmpSerie.TpServicos = 3) && Servicos = Sim, com itens
				=m.sloDataMgr.CursorQuery([SigMvItt], [LocalEstiS], [EmpDopNums], TempEest.Emps + TempEest.Dopes + Str(TempEest.Numes,6))
				If Not Used([LocalEstiS])
					=MsgErro([Favor Reinicializar o Processo!!!], [Falha na Conex] + CHR(227) + [o (SigPrNfs - CursorQuery - LocalEstiS)])
					Set Point To lcPon
					Set Separator To lcSep
					Return .f.
				EndIf

				lnLinS = Nf.lDescSer
				lnMaxS = Nf.nLdSer
				lnItnS = 0
				Select LocalEstiS
				Scan While (lnMaxS > lnItnS)
					lnItnS = lnItnS + 1
					llImpS = .f.

					If Not Empty(Nf.CUnid)
						=Grava(lnLinS, Nf.CUnid, Alltrim(LocalEstiS.CUnis), .t.)
						llImpS = .t.
					EndIf

					If Not Empty(Nf.CCodPro)
						=Grava(lnLinS, Nf.CCodPro, Alltrim(LocalEstiS.Cpros), .t.)
						llImpS = .t.
					EndIf
					
					If Not Empty(Nf.CDesPro)
						=Grava(lnLinS, Nf.CDesPro, Alltrim(LocalEstiS.DPros), .t.)
						llImpS = .t.
					EndIf
					
					If Not Empty(Nf.CQtde)
						=Grava(lnLinS, Nf.CQtde, Transform(LocalEstiS.Qtds, [999999.99]), .t.)
						llImpS = .t.
					EndIf
					
					If Not Empty(Nf.CVlUni)
						=Grava(lnLinS, Nf.CVlUni, Transform(LocalEstiS.Units, lcMaskCasas), .t.)
						llImpS = .t.
					EndIf

					If Not Empty(Nf.CVlTot)
						=Grava(lnLinS, Nf.CVlTot, Transform(LocalEstiS.Totas, [99999999.99]), .t.)
						llImpS = .t.
					EndIf

					If llImpS
						lnLinS = lnLinS + 1
					EndIf
				EndScan

				=Grava(Nf.lValIss, Nf.cValIss, Transform(crTmpNfis.vTotIss,  [999,999,999.99]), [X]) &&, .f., .f., [R])
				=Grava(Nf.lValSer, Nf.cValSer, Transform(crTmpNfis.vTotSers, [999,999,999.99]), [X]) &&, .f., .f., [R])
				
				_Memo = Set( 'Memo' )
				If nf.ncdser # 0
					set memowidth to nf.ncdser
				EndIf
								
				*** Observacoes
				If (crTmpDcOpe.ImpNfObs	<> 2)  && 1-Produtos; 2-Observacao
					If nf.TamColObs # 0
						Set Memo to nf.TamColObs
					Endif
					_QtLinhas = Min( MemLine( Alltrim( TempEest.Obses ) ), nf.TamLinObs )
					For _Linha = 1 to _QtLinhas
						=Grava( nf.lobs + _Linha - 1, nf.cobs, Alltrim( MLine( TempEest.Obses, _Linha ) ), .t., nf2.aObs )
						If _Linha # _QtLinhas
							xLinha = xLinha + 1
						Endif
					Next 
					IF CrTmpCfo.IpiNCreds = 1
						xLinha = xLinha + 1
						=Grava( nf.lobs + _QtLinhas + 1, nf.cobs, 'Ipi n' + CHR(227) + 'o Tributado R$ '+Alltrim(TRANSFORM(CrTmpNfis.ValIpis,"999,999,999.99")), .t., nf2.aObs )
					Endif
					Set Memo to _Memo
				EndIf 
				
				
			Else
				_Memo = Set( 'Memo' )
				If nf.ncdser # 0
					set memowidth to nf.ncdser
				Endif
				descser=0
				impvaliss=.f.
				impvalser=.f.
				for i=1 to nf.nldser
					_Detalhe = mline(CrTmpNfis.descsers,i)
					=Grava( nf.ldescser+descser, nf.cdescser, Iif(IsEmpty(_Detalhe), '', _Detalhe ))
					if i=5
						=Grava( nf.ldescser+descser, nf.cvaliss, transf(CrTmpNfis.vtotiss,"999,999,999.99" ), 'X') &&, .f., .f., [R])
						impvaliss=.t.
					EndIf 
					if i=8
						=Grava( nf.ldescser+descser, nf.cvalser, transf(CrTmpNfis.vtotsers,"999,999,999.99" ), 'X') &&, .f., .f., [R])
						impvalser=.t.
					EndIf 
					descser=descser+1.0
				EndFor 
				if not impvaliss
					=Grava( nf.lvaliss, nf.cvaliss, transf(CrTmpNfis.vtotiss,"999,999,999.99" ), 'X') &&, .f., .f., [R])
				EndIf 
				if not impvalser
					=Grava( nf.lvalser, nf.cvalser, transf(CrTmpNfis.vtotsers,"999,999,999.99" ), 'X') &&, .f., .f., [R])
				EndIf
				
				*** Observacoes
				If (crTmpDcOpe.ImpNfObs	<> 2)  && 1-Produtos; 2-Observacao
					If nf.TamColObs # 0
						Set Memo to nf.TamColObs
					Endif
					_QtLinhas = Min( MemLine( Alltrim( TempEest.Obses ) ), nf.TamLinObs )
					For _Linha = 1 to _QtLinhas
						=Grava( nf.lobs + _Linha - 1, nf.cobs, Alltrim( MLine( TempEest.Obses, _Linha ) ), .t., nf2.aObs )
						If _Linha # _QtLinhas
							xLinha = xLinha + 1
						Endif
					Next 
					IF CrTmpCfo.IpiNCreds = 1
						xLinha = xLinha + 1
						=Grava( nf.lobs + _QtLinhas + 1, nf.cobs, 'Ipi n' + CHR(227) + 'o Tributado R$ '+Alltrim(TRANSFORM(CrTmpNfis.ValIpis,"999,999,999.99")), .t., nf2.aObs )
					Endif
					Set Memo to _Memo
				EndIf 
			EndIf
		EndIf
		m.lnLinhaAtual1 = 0

		Select ('tmpImprime')
		Set Order To ('ordem') In ('tmpImprime')
		Go Top
		
		Scan
			m.conteudo = Strtran(Strtran(conteudo,["],[]),['],[])
			If (At('B',tmpImprime.style)>0 Or At('I',tmpImprime.style)>0)
				m.fontname = m.lcFontname2
				m.fontsize = m.lnFontsize2
				m.style = tmpImprime.style
			Else
				m.fontname = m.lcFontname2
				m.fontsize = m.lnFontsize1
				m.style = lcStyleDef1
			EndIf
			Gather Memvar Fields fontname,style,Conteudo
			If Empty(TmpImprime.FontSize)
				Gather Memvar Fields fontsize
			EndIf
		Endscan

		Select ('tmpImprime')
		Set Order To ('ordem') In ('tmpImprime')
		Locate

		If (m.lnNffatorcl==999.Or.;
			m.lnNffatorln==999)	

			For lnCnt1 = 1 To lnNumVias

				Select TmpImprime
				Set Order To ('ordem') In ('TmpImprime')
				Go Top

				Scan
					_Estilo = Alltrim( Style ) && + 'T'
					if Style = 'B'
						@ Linha, Coluna Say Conteudo &xfm Style ( _Estilo )
					else
						If Style = 'X'
							@ Linha, Coluna Say RTrim(Conteudo) &xf && Style ( _Estilo )
						Else
							@ Linha, Coluna Say Alltrim( Conteudo ) &xf Style ( _Estilo )
						Endif
					endif
				EndScan
				
			EndFor 

		Else
			For lnCnt1 = 1 To lnNumVias
				do SigPrNfx with 'tmpimprime',m.lcNomeImpressora,Iif(Ptipo="V",'Preview','to printer noconsole'),0,lnTamFolha1,m.lnNffatorln,m.lnNffatorcl,m.lnTpMargem,m.lnFtGDI1
			EndFor 
		EndIf

		Set Printer to Default
		Set Device to Screen
		Set Console Off
	Next

	Select CrTmpNfis
	If (pTipo = "I")
		*-- MIGRADO: mesmas gravacoes do legado, na mesma ordem, mas em transacao MANUAL
		*   explicita: o Commit() do fSqlConector so confirma com Transactions = 2 e a
		*   conexao principal roda em modo automatico (Commit devolveria -1 + ROLLBACK).
		lnTransOrig = SQLGetProp(m.sloDataMgr.pnIdConn, 'Transactions')
		=SQLSetProp(m.sloDataMgr.pnIdConn, 'Transactions', 2)
		llGravou = .T.
		lcFalha  = ''
		Replace Impress with Impress + 1
		lcUpdate = [Update SigMvNfi Set Impress = ]+Str(CrTmpNfis.Impress,6)+[ Where CidChaves = ']+CrTmpNfis.CidChaves+[']
		If m.sloDataMgr.SqlExecute(lcUpDate,'') < 1
			llGravou = .F.
			lcFalha  = '(Update crSigMvNfi)'
		EndIf
		If llGravou
			lcUpdate = [Update SigMvCab Set Datatrans = Null Where CidChaves = ']+TempEest.Cidchaves+[']
			If m.sloDataMgr.SqlExecute(lcUpDate,'') < 1
				llGravou = .F.
				lcFalha  = '(Update SigMvCab)'
			EndIf
		EndIf
		If llGravou
			lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+TempEest.EmpDopNums+[']
			If m.sloDataMgr.SqlExecute(lcDelete,'') < 1
				llGravou = .F.
				lcFalha  = '(Delete SigMvEtt)'
			EndIf
		EndIf
		If llGravou
			If m.slodatamgr.commit() < 1
				llGravou = .F.
				lcFalha  = ''
			EndIf
		Else
			=m.sloDataMgr.RollBack()
		EndIf
		=SQLSetProp(m.sloDataMgr.pnIdConn, 'Transactions', lnTransOrig)
		If Not llGravou
			=MsgErro('Favor Reinicializar o Processo!!!', 'Falha na Conex' + CHR(227) + 'o ' + lcFalha)
			Set Point To lcPon
			Set Separator To lcSep
			Return .F.
		EndIf
	EndIf
EndIf

Set Point To lcPon
Set Separator To lcSep

Select NF
Use
*-- MIGRADO: devolve llOk (legado devolvia .T. sempre, ate com impressora invalida)
Return llOk
Function DescPro
LParameters lcDescricao
_xDescricao = ''
If !IsEmpty( TempEest.TpFats ) And CrTmpTif.TamDesc # 0
	lcAlias = 'CrTmpTif'
	Do Case
		Case CrTmpTif.TpDescs = 1
			lcDescricao = CrTmpPro.DPros
		Case CrTmpTif.TpDescs = 2
			lcDescricao = CrTmpPro.DescFis
	Endcase
Else
	lcAlias = 'nf'
Endif

For xDesc = 1 to 5
	Do Case
		Case &lcAlias..OOrig = xDesc
			_xDescricao = _xDescricao + Alltrim( lcDescricao ) + ' '
		Case &lcAlias..OAden = xDesc
			_xDescricao = _xDescricao + Alltrim( CrTmpTif.Adendos ) + ' '
		Case &lcAlias..OCor = xDesc
			_xDescricao = _xDescricao + iif(InList(&lcAlias2..TipoEstos,2,3,4),Alltrim( &lcAlias2..CodCors ) + ' ','')
		Case &lcAlias..OEmb = xDesc
			_xDescricao = _xDescricao + iif(InList(&lcAlias2..TipoEstos,2,3,4),Alltrim( &lcAlias2..CodEmbs ) + ' ','')
		Case &lcAlias..OTam = xDesc
			_xDescricao = _xDescricao + iif(InList(&lcAlias2..TipoEstos,2,3,4),Alltrim( &lcAlias2..CodTams ) + ' ','')
	Endcase
Next
Return Left( _xDescricao, &lcAlias..TamDesc )


Function Grava
LParameters _Lin, _Col, _Cont, _Style, _Angulo, _Size, _Align, _Len
If Type( "_Style" ) = "L" And _Style And _Col = 0
	Return
EndIf
_Angulo = Iif(Type("_Angulo") = "N", _Angulo, 0)
_Angulo = Iif(_Angulo = 2, 90, Iif( _Angulo = 3, 270, 0 ) )
_Size   = Iif(Type("_Size") = "N", _Size, 0)
_Align  = Iif(Type("_Align") = "C", _Align, [L])
_Len    = Iif(Type("_Len") = "N", _Len, 0)

If _Lin # 0 Or _Col # 0 
	Insert Into TmpImprime ( Linha, Coluna, Conteudo, Style, Angulo, FontSize, Align, MaxLen) ;
					Values ( _Lin, _Col, NVL(_Cont,''), 'N', _Angulo, _Size, _Align, _Len )
Else
	Return
Endif



If Inlist( Type( "_Style" ), "C", "L" )
	_Alias = Select()
	Select TmpImprime
	If Type( "_Style" ) = "L" 
		If _Style
			Replace Style With 'X'
		Endif
	Else
		Replace Style With Alltrim( _Style )
	Endif
	Select ( _Alias )
EndIf

&&
EndFunc 

Function fConv_Uni1(tnValor, tcUniOri, tcUniConv)

	Local lnValor1, lnValor2, lnRetorno1

	tnValor = Iif(Type('tnValor') == 'N', tnValor, 0)
	tcUniOri = Padr(Iif(Type('tcUniOri') == 'C', tcUniOri, ''), 3)
	tcUniConv = Padr(Iif(Type('tcUniConv') == 'C', tcUniConv, ''), 3)
	lnRetorno1 = tnValor
	
	If Used('crTmpUni')
		lnValor1 = 1
		lnValor2 = 1

		If Seek(tcUniOri, 'crTmpUni', 'cUnis') And crTmpUni.Fators > 0
			lnValor1 = crTmpUni.Fators
			
		EndIf 
	
		If Seek(tcUniConv, 'crTmpUni', 'cUnis') And crTmpUni.Fators > 0
			lnValor2 = crTmpUni.Fators
			
		EndIf 

		lnRetorno1 = Round((tnValor * lnValor1 / lnValor2), 2)
		
	EndIf 

	Return (lnRetorno1)
EndFunc
