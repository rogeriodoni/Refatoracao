# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, ICLIS, PENDENTE, IMPS, TIPOCADS, NFPAGS, VENCS, FORMAS

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
  ControlSource = "crSigOpFp.especies"
  ControlSource = "crSigOpFp.indices"
  ControlSource = "crSigOpFp.entradas"
  ControlSource = "crSigOpFp.pVarias"
  ControlSource = "crSigOpFp.TolFcxs"
  ControlSource = "crSigOpFp.TaxJuros"
  ControlSource = "crSigOpFp.descs"
  ControlSource = "crSigOpFp.fparcs"
  ControlSource = "crSigOpFp.fpcomiss"
  ControlSource = "crSigOpFp.dias"
  ControlSource = "crSigOpFp.encargos"
  ControlSource = "crSigOpFp.Bancos"
  ControlSource = "crSigOpFp.VlrFpgs"
  ControlSource = "crSigOpFp.Agencias"
  ControlSource = "crSigOpFp.NContas"
  ControlSource = "crSigOpFp.impbols"
  ControlSource = "crSigOpFp.impdups"
  ControlSource = "crSigOpFp.BlqTabds"
  ControlSource = "crSigOpFp.Liscongv"
  ControlSource = "crSigOpFp.dadchqs"
  ControlSource = "crSigOpFp.tvens"
  ControlSource = "crSigOpFp.coldados"
  ControlSource = "crSigOpFp.infos"
  ControlSource = "crSigOpFp.opcsnas"
  ControlSource = "crSigOpFp.Situas"
  ControlSource = "crSigOpFp.ImpCpChqs"
  ControlSource = "crSigOpFp.valpends"
  ControlSource = "crSigOpFp.cPictures"
  ControlSource = "crSigOpFp.DetFecCxs"
  ControlSource = "crSigOpFp.cpags"
  ControlSource = "crSigOpFp.Emps"
  ControlSource = "crSigOpFp.Aprovas"
  ControlSource = "crSigOpFp.AgCobs"
  ControlSource = "crSigOpFp.ItemObrigs"
  ControlSource = "crSigOpFp.Promos"
  ControlSource = "crSigOpFp.impchqs"
  ControlSource = "crSigOpFp.acumulas"
  ControlSource = "crSigOpFp.trocos"
  ControlSource = "crSigOpFp.mesfec"
  ControlSource = "crSigOpFp.emichqs"
  ControlSource = "crSigOpFp.Autenticas"
  ControlSource = "crSigOpFp.BxComChqs"
  ControlSource = "crSigOpFp.EmiVales"
  ControlSource = "crSigOpFp.Baixas"
  ControlSource = "crSigOpFp.bxcomis"
  ControlSource = "crSigOpFp.obs"
  ControlSource = "crSigOpFp.Tpvencs"
  ControlSource = "crSigOpFp.TpCheques"
  ControlSource = "crSigOpFp.nDtComis"
  ControlSource = "crSigOpFp.chklimcre"
  ControlSource = "crSigOpFp.blqvctopar"
  ControlSource = "crSigOpFp.grupoemp"
  ControlSource = "crSigOpFp.chkBlqBon"
  ControlSource = "crSigOpFp.mFinancs"
  ControlSource = "crSigOpFp.ncodfinzs"
  ControlSource = "crSigOpFp.bandeira"
  ControlSource = "crSigOpFp.desc2s"
  ControlSource = "crSigOpFp.prazos"
  ControlSource = "crSigOpFp.hists"
  ControlSource = "crSigOpFp.garantias"
  ControlSource = "crSigOpFp.parcs"
  ControlSource = "crSigOpFp.lcartao"
  ControlSource = "crSigOpFp.opers"
  ControlSource = "crSigOpFp.adquirente"
  ControlSource = "crSigOpFp.parcfin"
  ControlSource = "crSigOpFp.parcini"
  ControlSource = "crSigOpFp.dcarts"
  ControlSource = "crSigOpFp.ccupomnvs"
  ControlSource = "crSigOpFp.codEstabs"
  ControlSource = "crSigOpFp.carauts"
  ControlSource = "crSigOpFp.grupobs"
  ControlSource = "crSigOpFp.contabs"
  ControlSource = "crSigOpFp.autoriza"
  ControlSource = ""
  ControlSource = "crSigOpFp.grupots"
  ControlSource = "crSigOpFp.contats"
  ControlSource = ""
  ControlSource = "crSigOpFp.nsu"
  ControlSource = "crSigOpFp.chkcpf"
  ControlSource = "crSigOpFp.acvchqs"
  ControlSource = "crSigOpFp.gavetas"
  ControlSource = "crSigOpFp.Libcsens"
  ControlSource = "crSigOpFp.impnotas"
  ControlSource = "crSigOpFp.nFinancs"
  ControlSource = "crSigOpFp.Chkbins"
  ControlSource = "crSigOpFp.TpHists"
  ControlSource = "crSigOpFp.LibCtaBlq"
  ControlSource = "crSigOpFp.cItems"
  ControlSource = "crSigOpFp.tcdc"
  ControlSource = "crSigOpFp.lsaque"
  ControlSource = "crSigOpFp.PCheque"
  ControlSource = "crSigOpFp.VlrMinPar"
  ControlSource = "crSigOpFp.Descrs"
  ControlSource = "crSigOpFp.TitFPags"
  ControlSource = "crSigOpFp.fpags"
  ControlSource = "crSigOpFp.nfpags"
  ControlSource = "crSigOpFp.codfpags"
  ControlSource = "crSigOpFp.moefpgs"
  ControlSource = "crSigOpFp.grupods"
  ControlSource = "crSigOpFp.contads"
  ControlSource = "crSigOpFp.dcontads"
  ControlSource = "crSigOpFp.OriDes"
  ControlSource = "crSigOpFp.formas"
  ControlSource = "crSigOpFp.ModPagto"
lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
Select LocalParac
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFp'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFpI'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFpP'),1,-1)
		lcSql = [Delete From SigOpFpI Where Fpags = ']+crSigOpFp.fpags+[']
		m.lnErro1 = .poDataMgr.Sqlexecute(lcSql,'')
		lcSql = [Delete From SigOpFpP Where Fpags = ']+crSigOpFp.fpags+[']
		m.lnErro1 = .poDataMgr.Sqlexecute(lcSql,'')
		lcSql = [Delete From SigOpFp Where Fpags = ']+crSigOpFp.fpags+[']
		m.lnErro1 = .poDataMgr.Sqlexecute(lcSql,'')
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpFp'),1,-1)
SELECT crSigOpFp
	lcSql = [Select Rclis From SigCdCli Where Iclis = ']+crSigOpFp.ContaDs+[']
	ThisForm.Podatamgr.sqlexecute(lcsql,'CrSigCdCli')
	lcSql = [Select Rclis From SigCdCli Where Iclis = ']+crSigOpFp.Contabs+[']
	ThisForm.Podatamgr.sqlexecute(lcsql,'CrSigCdCli')
	lcSql = [Select Rclis From SigCdCli Where Iclis = ']+crSigOpFp.Contats+[']
	ThisForm.Podatamgr.sqlexecute(lcsql,'CrSigCdCli')
Select crSigOpFp
		lcSql = [Select Fpags, Count(*) as TT From SigMvPar Where Fpags = ']+crSigOpFp.Fpags+[' Group by Fpags ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPar')
		lcSql = [Select Fpags, Count(*) as TT From SigMvPar Where Fpags = ']+crSigOpFp.Fpags+[' Group by Fpags ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPar')
		lcSql = [Select top 1 Fpags, Dopes From SigOpFpo Where Fpags = ']+crSigOpFp.Fpags+[' ]
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalfPago')
Select crSigOpFp
Select crSigOpFp
SELECT crSigOpFp
SELECT crSigOpFp
SELECT crSigOpFp
	Select crSigOpFp
lcQryFPag  = [Select * from SigOpFp where FPags = ']+crSigOpFp.FPags+[']
lcQryFPagI = [Select * from SigOpFpI where FPags = ']+crSigOpFp.FPags+[']
lcQryFPagP = [Select * from SigOpFpP where FPags = ']+crSigOpFp.FPags+[']
lcQryFPagB = [Select * from SigOpFpB where FPags = ']+crSigOpFp.FPags+[']
If ThisForm.poDataMgr.SQLExecute(lcQryFPag,[TmpFPag]) < 1
If ThisForm.poDataMgr.SQLExecute(lcQryFPagI,[TmpFPagI]) < 1
If ThisForm.poDataMgr.SQLExecute(lcQryFPagP,[TmpFPagP]) < 1
If ThisForm.poDataMgr.SQLExecute(lcQryFPagB,[TmpFPagB]) < 1
Select TmpFPag
Insert Into crSigOpFp From Memvar
Select TmpFPagI
	Insert into crSigOpFpI from MemVar
Select TmpFPagP
	Insert into crSigOpFpP from MemVar
Select TmpFPagB
	Insert into crSigOpFpB from MemVar
Select crSigOpFp
SELECT crSigCdVct
Select crSigOpFp
SELECT crSigPrInf
select crSigOpFp
	select crSigFiFis
	ThisForm.podatamgr.SqlExecute([Select * from SigFiNal Where Imps = ']+CrSigFiFis.Imps+[' ],"crFinal")
	SELECT CrFinal
	if not seek(this.value)
select crSigOpFp
	select crSigFiFis
	ThisForm.podatamgr.SqlExecute([Select * from SigFiNal Where Imps = ']+CrSigFiFis.Imps+[' ],"crdFinal")
	SELECT CrdFinal
	if not seek(this.value)
select crSigOpFp
	ThisForm.podatamgr.SqlExecute([Select * from SigCdCrt ],"crBan")
	SELECT CrBan
	if not seek(this.value)
Select crSigOpFp
	ThisForm.podatamgr.SqlExecute([Select * from SigcdCad Where tipocads = 'ADQUIRENTE'],"crCad")
	SELECT CrCad
	if not seek(this.value)
Select crSigOpFp
	SELECT crSigFiNfs
Select crSigOpFp
select crSigOpFp
		select crSigOpFp
	select crSigOpFp
		select crSigOpFp
	select crSigOpFp
select crSigOpFp
		select crSigOpFp
	select crSigOpFp
		select crSigOpFp
	select crSigOpFp
SELECT crSigCdMoe
select crSigOpFp
select crSigOpFp
		select crSigOpFp
	select crSigOpFp
		select crSigOpFp
	select crSigOpFp
SELECT crSigOpFp
SELECT crSigCdMod
select crSigOpFp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formpag.prg) - TRECHOS RELEVANTES PARA PASS SQL (3611 linhas total):

*-- Linhas 265 a 299:
265:             ENDWITH
266: 
267:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
268:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.fpags"
269:             loc_oGrd.Column1.Width           = 100
270: 
271:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
272:             loc_oGrd.Column2.ControlSource   = "cursor_4c_Dados.descrs"
273:             loc_oGrd.Column2.Width           = 250
274: 
275:             loc_oGrd.Column3.Header1.Caption = "Moeda"
276:             loc_oGrd.Column3.ControlSource   = "cursor_4c_Dados.moefpgs"
277:             loc_oGrd.Column3.Width           = 60
278: 
279:             loc_oGrd.Column4.Header1.Caption = "Dias"
280:             loc_oGrd.Column4.ControlSource   = "cursor_4c_Dados.dias"
281:             loc_oGrd.Column4.Width           = 50
282: 
283:             loc_oGrd.Column5.Header1.Caption = "T.Venc"
284:             loc_oGrd.Column5.ControlSource   = "cursor_4c_Dados.tvens"
285:             loc_oGrd.Column5.Width           = 60
286: 
287:         CATCH TO loc_oErro
288:             MsgErro("Erro em Formpag.ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
289:         ENDTRY
290:     ENDPROC
291: 
292:     *==========================================================================
293:     PROTECTED PROCEDURE ConfigurarPaginaDados()
294:     *==========================================================================
295:         LOCAL loc_oPage, loc_oCntSalva, loc_oCntSaida2, loc_oPgf2
296:         TRY
297:             loc_oPage = THIS.pgf_4c_Paginas.Pages(2)
298:             loc_oPage.Caption = "Dados"
299: 

*-- Linhas 3257 a 3279:
3257:             IF THIS.this_oBusinessObject.Buscar("")
3258:                 IF USED("cursor_4c_Dados")
3259:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
3260:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
3261:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
3262:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
3263:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
3264:                     THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
3265:                 ENDIF
3266:                 loc_lResultado = .T.
3267:             ENDIF
3268:         CATCH TO loc_oErro
3269:             MsgErro("Erro em Formpag.CarregarLista: " + loc_oErro.Message, "Erro")
3270:         ENDTRY
3271: 
3272:         RETURN loc_lResultado
3273:     ENDPROC
3274: 
3275:     *==========================================================================
3276:     PROCEDURE BtnIncluirClick()
3277:     *==========================================================================
3278:         LOCAL loc_lResultado
3279:         loc_lResultado = .F.

*-- Linhas 3375 a 3415:
3375:                 USE IN cursor_4c_Busca
3376:             ENDIF
3377: 
3378:             loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
3379:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca") < 0
3380:                 SET NULL ON
3381:                 CREATE CURSOR cursor_4c_Busca (fpags C(12), descrs C(30))
3382:                 SET NULL OFF
3383:             ENDIF
3384: 
3385:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3386:             IF VARTYPE(loc_oBusca) = "O"
3387:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3388:                 loc_oBusca.DefinirCursor("cursor_4c_Busca", "fpags", "descrs", "Busca de Condi" + CHR(231) + CHR(245) + "es de Pagamento")
3389:                 loc_oBusca.Mostrar()
3390: 
3391:                 loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3392:                 IF !EMPTY(loc_cCodigo)
3393:                     THIS.this_oBusinessObject.Buscar("fpags = '" + loc_cCodigo + "'")
3394:                     IF USED("cursor_4c_Dados")
3395:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.RecordSource = "cursor_4c_Dados"
3396:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.fpags"
3397:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.descrs"
3398:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.moefpgs"
3399:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.dias"
3400:                         THIS.pgf_4c_Paginas.Pages(1).grd_4c_Lista.Column5.ControlSource = "cursor_4c_Dados.tvens"
3401:                     ENDIF
3402:                     loc_lResultado = .T.
3403:                 ENDIF
3404:             ENDIF
3405: 
3406:             IF USED("cursor_4c_Busca")
3407:                 USE IN cursor_4c_Busca
3408:             ENDIF
3409:         CATCH TO loc_oErro
3410:             MsgErro("Erro em Formpag.BtnBuscarClick: " + loc_oErro.Message, "Erro")
3411:             IF USED("cursor_4c_Busca")
3412:                 USE IN cursor_4c_Busca
3413:             ENDIF
3414:         ENDTRY
3415: 

*-- Linhas 3499 a 3549:
3499:                     loc_cCodDestino = ALLTRIM(loc_cCodDestino)
3500: 
3501:                     && Verificar se destino ja existe
3502:                     loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodDestino)
3503:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerDest") >= 0
3504:                         IF cursor_4c_VerDest.qtd > 0
3505:                             MsgAviso("C" + CHR(243) + "digo '" + loc_cCodDestino + "' j" + CHR(225) + " existe.")
3506:                             IF USED("cursor_4c_VerDest")
3507:                                 USE IN cursor_4c_VerDest
3508:                             ENDIF
3509:                         ELSE
3510:                             IF USED("cursor_4c_VerDest")
3511:                                 USE IN cursor_4c_VerDest
3512:                             ENDIF
3513: 
3514:                             && Copiar registro
3515:                             loc_cSQL = "INSERT INTO SigOpFp SELECT " + ;
3516:                                        EscaparSQL(loc_cCodDestino) + ", descrs, titfpags, formas, moefpgs, " + ;
3517:                                        "infos, situas, codfpags, nfpags, modpagto, grupods, contads, dcontads, " + ;
3518:                                        "orides, grupoos, contaos, dcontaos, grupobs, contabs, grupots, contats, " + ;
3519:                                        "bancos, agencias, ncontas, tvens, carauts, coldados, hists, ccupomnvs, " + ;
3520:                                        "operautos, operacaoss, operacaoes, cpictures, garantias, lcartao, lsaque, " + ;
3521:                                        "opers, parcs, autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, " + ;
3522:                                        "adquirente, emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
3523:                                        "mfinancs, datatrans, aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, " + ;
3524:                                        "emichqs, encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, " + ;
3525:                                        "valpends, impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, " + ;
3526:                                        "gavetas, tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
3527:                                        "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
3528:                                        "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, cnidtefs, " + ;
3529:                                        "detfecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, chklimcre, relsomsub, " + ;
3530:                                        "chkvalgar, chknccmov, arredonda, chkcachbk, chkuticach, autoriza, blqvctopar, " + ;
3531:                                        "vlrminpar, vlrlimfpgs, optcredcta, relmetvend " + ;
3532:                                        "FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cCodOrigem)
3533: 
3534:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3535:                             IF loc_nResult >= 0
3536:                                 THIS.CarregarLista()
3537:                                 MsgInfo("Condi" + CHR(231) + CHR(227) + "o '" + loc_cCodOrigem + "' copiada para '" + loc_cCodDestino + "'.", "Sucesso")
3538:                                 loc_lResultado = .T.
3539:                             ELSE
3540:                                 MsgErro("Erro ao copiar: " + CapturarErroSQL(), "Erro SQL")
3541:                             ENDIF
3542:                         ENDIF
3543:                     ELSE
3544:                         MsgErro("Erro ao verificar destino: " + CapturarErroSQL(), "Erro SQL")
3545:                     ENDIF
3546:                 ENDIF
3547:             ENDIF
3548:         CATCH TO loc_oErro
3549:             MsgErro("Erro em Formpag.BtnCopiarClick: " + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\pagBO.prg):
*==============================================================================
* pagBO.prg - Business Object para Condicoes de Pagamento
* Tabela principal: SigOpFp
* Chave primaria  : fpags char(12)
* Tabelas filhas  : SigOpFpI (fpags), SigOpFpP (fpags)
*==============================================================================

DEFINE CLASS pagBO AS BusinessBase

    *-- Chave primaria
    this_cFpags         = ""   && char(12) fpags

    *-- Identificacao basica
    this_cDescrs        = ""   && char(30)  descrs
    this_cTitfpags      = ""   && char(30)  titfpags
    this_cFormas        = ""   && char(12)  formas
    this_cMoefpgs       = ""   && char(3)   moefpgs
    this_cInfos         = ""   && char(1)   infos
    this_cSituas        = ""   && char(1)   situas
    this_cCodfpags      = ""   && char(2)   codfpags
    this_nNfpags        = 0    && numeric(2,0) nfpags
    this_cModpagto      = ""   && char(10)  modpagto
    this_cGrupods       = ""   && char(10)  grupods
    this_cContads       = ""   && char(10)  contads
    this_cDcontads      = ""   && char(40)  dcontads
    this_nOrides        = 0    && numeric(1,0) orides
    this_cGrupoos       = ""   && char(10)  grupoos
    this_cContaos       = ""   && char(10)  contaos
    this_cDcontaos      = ""   && char(40)  dcontaos
    this_cGrupobs       = ""   && char(10)  grupobs
    this_cContabs       = ""   && char(10)  contabs
    this_cGrupots       = ""   && char(10)  grupots
    this_cContats       = ""   && char(10)  contats
    this_cBancos        = ""   && char(3)   bancos
    this_cAgencias      = ""   && char(4)   agencias
    this_cNcontas       = ""   && char(10)  ncontas
    this_cTvens         = ""   && char(1)   tvens
    this_cCarauts       = ""   && char(1)   carauts
    this_cColdados      = ""   && char(1)   coldados
    this_cHists         = ""   && char(30)  hists
    this_cCcupomnvs     = ""   && char(20)  ccupomnvs
    this_cOperautos     = ""   && char(12)  operautos
    this_cOperacaoss    = ""   && char(15)  operacaoss
    this_cOperacaoes    = ""   && char(15)  operacaoes
    this_cCpictures     = ""   && char(20)  cpictures
    this_cGarantias     = ""   && char(1)   garantias
    this_cLcartao       = ""   && char(1)   lcartao
    this_cLsaque        = ""   && char(1)   lsaque
    this_cOpers         = ""   && char(1)   opers
    this_cParcs         = ""   && char(1)   parcs
    this_cAutotef       = ""   && char(1)   autotef
    this_cTcdc          = ""   && char(1)   tcdc
    this_cPcheque       = ""   && char(45)  pcheque
    this_cDadchqs       = ""   && char(1)   dadchqs
    this_cCodestabs     = ""   && char(8)   codestabs
    this_cCitems        = ""   && char(11)  citems
    this_cDcarts        = ""   && char(30)  dcarts
    this_cAdquirente    = ""   && char(8)   adquirente
    this_cEmps          = ""   && char(3)   emps
    this_cParcfin       = ""   && char(2)   parcfin
    this_cParcini       = ""   && char(2)   parcini
    this_cBandeira      = ""   && char(20)  bandeira
    this_cCdcashback    = ""   && char(3)   cdcashback
    this_cEspecies      = ""   && char(6)   especies
    this_cGrupoemp      = ""   && char(15)  grupoemp
    this_cMfinancs      = ""   && memo       mfinancs
    this_dDatatrans     = {}   && datetime   datatrans (nullable)

    *-- Campos numericos
    this_nAprovas       = 0    && numeric(1,0)
    this_nItemobrigs    = 0    && numeric(1,0)
    this_nBxcomis       = 0    && numeric(1,0)
    this_nCpags         = 0    && numeric(2,0)
    this_nDesc2s        = 0    && numeric(5,2)
    this_nDescs         = 0    && numeric(5,2)
    this_nDias          = 0    && numeric(3,0)
    this_nEmichqs       = 0    && numeric(1,0)
    this_nEncargos      = 0    && numeric(5,2)
    this_nEntradas      = 0    && numeric(3,0)
    this_nFparcs        = 0    && numeric(2,0)
    this_nFpcomiss      = 0    && numeric(5,2)
    this_nImpbols       = 0    && numeric(1,0)
    this_nPrazos        = 0    && numeric(3,0)
    this_nTrocos        = 0    && numeric(1,0)
    this_nValpends      = 0    && numeric(1,0)
    this_nImpnotas      = 0    && numeric(1,0)
    this_nImpdups       = 0    && numeric(1,0)
    this_nObs           = 0    && numeric(1,0)
    this_nTphists       = 0    && numeric(1,0)
    this_nNcodfinzs     = 0    && numeric(2,0)
    this_nImpchqs       = 0    && numeric(1,0)
    this_nEmivales      = 0    && numeric(1,0)
    this_nGavetas       = 0    && numeric(1,0)
    this_nTpcheques     = 0    && numeric(1,0)
    this_nBaixas        = 0    && numeric(1,0)
    this_nBxcomchqs     = 0    && numeric(1,0)
    this_nAutenticas    = 0    && numeric(1,0)
    this_nMesfec        = 0    && numeric(1,0)
    this_nAcvchqs       = 0    && numeric(1,0)
    this_nAcumulas      = 0    && numeric(1,0)
    this_nPromos        = 0    && numeric(1,0)
    this_nAgcobs        = 0    && numeric(1,0)
    this_nTolfcxs       = 0    && numeric(5,2)
    this_nTpvencs       = 0    && numeric(1,0)
    this_nPvarias       = 0    && numeric(5,2)
    this_nIndices       = 0    && numeric(6,3)
    this_nLibcsens      = 0    && numeric(1,0)
    this_nImpcpchqs     = 0    && numeric(1,0)
    this_nBlqtabds      = 0    && numeric(1,0)
    this_nChkbins       = 0    && numeric(1,0)
    this_nChkfidels     = 0    && numeric(1,0)
    this_nNfinancs      = 0    && numeric(1,0)
    this_nOpcsnas       = 0    && numeric(1,0)
    this_nVlrfpgs       = 0    && numeric(11,2)
    this_nLiscongv      = 0    && numeric(1,0)
    this_nCnidtefs      = 0    && numeric(1,0)
    this_nDetFecCxs     = 0    && numeric(1,0)
    this_nTaxjuros      = 0    && numeric(8,4)
    this_nNdtcomis      = 0    && numeric(1,0)
    this_nChkcpf        = 0    && numeric(1,0)
    this_nLibctablq     = 0    && numeric(1,0)
    this_nNsu           = 0    && numeric(1,0)
    this_nChklimcre     = 0    && numeric(1,0)
    this_nRelsomsub     = 0    && numeric(1,0)
    this_nChkvalgar     = 0    && numeric(1,0)
    this_nChknccmov     = 0    && numeric(1,0)
    this_nArredonda     = 0    && numeric(1,0)
    this_nChkcachbk     = 0    && numeric(1,0)
    this_nChkuticach    = 0    && numeric(1,0)
    this_nAutoriza      = 0    && numeric(1,0)
    this_nBlqvctopar    = 0    && numeric(1,0)
    this_nVlrminpar     = 0    && numeric(11,2)
    this_nVlrlimfpgs    = 0    && numeric(12,2)
    this_nOptcredcta    = 0    && numeric(1,0)
    this_nRelmetvend    = 0    && numeric(1,0)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado    = DODEFAULT()
            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "fpags"
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Init: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cFpags)
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega cursor_4c_Dados para o grid
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                       "grupods, contads FROM SigOpFp ORDER BY fpags"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT fpags, descrs, moefpgs, dias, tvens, infos, " + ;
                           "grupods, contads FROM SigOpFp WHERE " + par_cFiltro + ;
                           " ORDER BY fpags"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        fpags   C(12), ;
                        descrs  C(30), ;
                        moefpgs C(3), ;
                        dias    N(3), ;
                        tvens   C(1), ;
                        infos   C(1), ;
                        grupods C(10), ;
                        contads C(10) )
                    SET NULL OFF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Buscar: " + loc_oErro.Message, "Erro")
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    fpags   C(12), ;
                    descrs  C(30), ;
                    moefpgs C(3), ;
                    dias    N(3), ;
                    tvens   C(1), ;
                    infos   C(1), ;
                    grupods C(10), ;
                    contads C(10) )
                SET NULL OFF
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo fpags
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cFpags)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE fpags = " + ;
                       EscaparSQL(ALLTRIM(par_cFpags))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cFpags), "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags        = TratarNulo(fpags,        "C")
            THIS.this_cDescrs       = TratarNulo(descrs,       "C")
            THIS.this_cTitfpags     = TratarNulo(titfpags,     "C")
            THIS.this_cFormas       = TratarNulo(formas,       "C")
            THIS.this_cMoefpgs      = TratarNulo(moefpgs,      "C")
            THIS.this_cInfos        = TratarNulo(infos,        "C")
            THIS.this_cSituas       = TratarNulo(situas,       "C")
            THIS.this_cCodfpags     = TratarNulo(codfpags,     "C")
            THIS.this_nNfpags       = TratarNulo(nfpags,       "N")
            THIS.this_cModpagto     = TratarNulo(modpagto,     "C")
            THIS.this_cGrupods      = TratarNulo(grupods,      "C")
            THIS.this_cContads      = TratarNulo(contads,      "C")
            THIS.this_cDcontads     = TratarNulo(dcontads,     "C")
            THIS.this_nOrides       = TratarNulo(orides,       "N")
            THIS.this_cGrupoos      = TratarNulo(grupoos,      "C")
            THIS.this_cContaos      = TratarNulo(contaos,      "C")
            THIS.this_cDcontaos     = TratarNulo(dcontaos,     "C")
            THIS.this_cGrupobs      = TratarNulo(grupobs,      "C")
            THIS.this_cContabs      = TratarNulo(contabs,      "C")
            THIS.this_cGrupots      = TratarNulo(grupots,      "C")
            THIS.this_cContats      = TratarNulo(contats,      "C")
            THIS.this_cBancos       = TratarNulo(bancos,       "C")
            THIS.this_cAgencias     = TratarNulo(agencias,     "C")
            THIS.this_cNcontas      = TratarNulo(ncontas,      "C")
            THIS.this_cTvens        = TratarNulo(tvens,        "C")
            THIS.this_cCarauts      = TratarNulo(carauts,      "C")
            THIS.this_cColdados     = TratarNulo(coldados,     "C")
            THIS.this_cHists        = TratarNulo(hists,        "C")
            THIS.this_cCcupomnvs    = TratarNulo(ccupomnvs,    "C")
            THIS.this_cOperautos    = TratarNulo(operautos,    "C")
            THIS.this_cOperacaoss   = TratarNulo(operacaoss,   "C")
            THIS.this_cOperacaoes   = TratarNulo(operacaoes,   "C")
            THIS.this_cCpictures    = TratarNulo(cpictures,    "C")
            THIS.this_cGarantias    = TratarNulo(garantias,    "C")
            THIS.this_cLcartao      = TratarNulo(lcartao,      "C")
            THIS.this_cLsaque       = TratarNulo(lsaque,       "C")
            THIS.this_cOpers        = TratarNulo(opers,        "C")
            THIS.this_cParcs        = TratarNulo(parcs,        "C")
            THIS.this_cAutotef      = TratarNulo(autotef,      "C")
            THIS.this_cTcdc         = TratarNulo(tcdc,         "C")
            THIS.this_cPcheque      = TratarNulo(pcheque,      "C")
            THIS.this_cDadchqs      = TratarNulo(dadchqs,      "C")
            THIS.this_cCodestabs    = TratarNulo(codestabs,    "C")
            THIS.this_cCitems       = TratarNulo(citems,       "C")
            THIS.this_cDcarts       = TratarNulo(dcarts,       "C")
            THIS.this_cAdquirente   = TratarNulo(adquirente,   "C")
            THIS.this_cEmps         = TratarNulo(emps,         "C")
            THIS.this_cParcfin      = TratarNulo(parcfin,      "C")
            THIS.this_cParcini      = TratarNulo(parcini,      "C")
            THIS.this_cBandeira     = TratarNulo(bandeira,     "C")
            THIS.this_cCdcashback   = TratarNulo(cdcashback,   "C")
            THIS.this_cEspecies     = TratarNulo(especies,     "C")
            THIS.this_cGrupoemp     = TratarNulo(grupoemp,     "C")
            THIS.this_cMfinancs     = TratarNulo(mfinancs,     "M")
            THIS.this_nAprovas      = TratarNulo(aprovas,      "N")
            THIS.this_nItemobrigs   = TratarNulo(itemobrigs,   "N")
            THIS.this_nBxcomis      = TratarNulo(bxcomis,      "N")
            THIS.this_nCpags        = TratarNulo(cpags,        "N")
            THIS.this_nDesc2s       = TratarNulo(desc2s,       "N")
            THIS.this_nDescs        = TratarNulo(descs,        "N")
            THIS.this_nDias         = TratarNulo(dias,         "N")
            THIS.this_nEmichqs      = TratarNulo(emichqs,      "N")
            THIS.this_nEncargos     = TratarNulo(encargos,     "N")
            THIS.this_nEntradas     = TratarNulo(entradas,     "N")
            THIS.this_nFparcs       = TratarNulo(fparcs,       "N")
            THIS.this_nFpcomiss     = TratarNulo(fpcomiss,     "N")
            THIS.this_nImpbols      = TratarNulo(impbols,      "N")
            THIS.this_nPrazos       = TratarNulo(prazos,       "N")
            THIS.this_nTrocos       = TratarNulo(trocos,       "N")
            THIS.this_nValpends     = TratarNulo(valpends,     "N")
            THIS.this_nImpnotas     = TratarNulo(impnotas,     "N")
            THIS.this_nImpdups      = TratarNulo(impdups,      "N")
            THIS.this_nObs          = TratarNulo(obs,          "N")
            THIS.this_nTphists      = TratarNulo(tphists,      "N")
            THIS.this_nNcodfinzs    = TratarNulo(ncodfinzs,    "N")
            THIS.this_nImpchqs      = TratarNulo(impchqs,      "N")
            THIS.this_nEmivales     = TratarNulo(emivales,     "N")
            THIS.this_nGavetas      = TratarNulo(gavetas,      "N")
            THIS.this_nTpcheques    = TratarNulo(tpcheques,    "N")
            THIS.this_nBaixas       = TratarNulo(baixas,       "N")
            THIS.this_nBxcomchqs    = TratarNulo(bxcomchqs,    "N")
            THIS.this_nAutenticas   = TratarNulo(autenticas,   "N")
            THIS.this_nMesfec       = TratarNulo(mesfec,       "N")
            THIS.this_nAcvchqs      = TratarNulo(acvchqs,      "N")
            THIS.this_nAcumulas     = TratarNulo(acumulas,     "N")
            THIS.this_nPromos       = TratarNulo(promos,       "N")
            THIS.this_nAgcobs       = TratarNulo(agcobs,       "N")
            THIS.this_nTolfcxs      = TratarNulo(tolfcxs,      "N")
            THIS.this_nTpvencs      = TratarNulo(tpvencs,      "N")
            THIS.this_nPvarias      = TratarNulo(pvarias,      "N")
            THIS.this_nIndices      = TratarNulo(indices,      "N")
            THIS.this_nLibcsens     = TratarNulo(libcsens,     "N")
            THIS.this_nImpcpchqs    = TratarNulo(impcpchqs,    "N")
            THIS.this_nBlqtabds     = TratarNulo(blqtabds,     "N")
            THIS.this_nChkbins      = TratarNulo(chkbins,      "N")
            THIS.this_nChkfidels    = TratarNulo(chkfidels,    "N")
            THIS.this_nNfinancs     = TratarNulo(nfinancs,     "N")
            THIS.this_nOpcsnas      = TratarNulo(opcsnas,      "N")
            THIS.this_nVlrfpgs      = TratarNulo(vlrfpgs,      "N")
            THIS.this_nLiscongv     = TratarNulo(liscongv,     "N")
            THIS.this_nCnidtefs     = TratarNulo(cnidtefs,     "N")
            THIS.this_nDetFecCxs    = TratarNulo(DetFecCxs,    "N")
            THIS.this_nTaxjuros     = TratarNulo(taxjuros,     "N")
            THIS.this_nNdtcomis     = TratarNulo(ndtcomis,     "N")
            THIS.this_nChkcpf       = TratarNulo(chkcpf,       "N")
            THIS.this_nLibctablq    = TratarNulo(libctablq,    "N")
            THIS.this_nNsu          = TratarNulo(nsu,          "N")
            THIS.this_nChklimcre    = TratarNulo(chklimcre,    "N")
            THIS.this_nRelsomsub    = TratarNulo(relsomsub,    "N")
            THIS.this_nChkvalgar    = TratarNulo(chkvalgar,    "N")
            THIS.this_nChknccmov    = TratarNulo(chknccmov,    "N")
            THIS.this_nArredonda    = TratarNulo(arredonda,    "N")
            THIS.this_nChkcachbk    = TratarNulo(chkcachbk,    "N")
            THIS.this_nChkuticach   = TratarNulo(chkuticach,   "N")
            THIS.this_nAutoriza     = TratarNulo(autoriza,     "N")
            THIS.this_nBlqvctopar   = TratarNulo(blqvctopar,   "N")
            THIS.this_nVlrminpar    = TratarNulo(vlrminpar,    "N")
            THIS.this_nVlrlimfpgs   = TratarNulo(vlrlimfpgs,   "N")
            THIS.this_nOptcredcta   = TratarNulo(optcredcta,   "N")
            THIS.this_nRelmetvend   = TratarNulo(relmetvend,   "N")

            *-- datatrans (datetime, nullable)
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDatatrans = {}
            ELSE
                THIS.this_dDatatrans = datatrans
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarInsercao - Valida campos obrigatorios antes de inserir/atualizar
    *==========================================================================
    FUNCTION ValidarInsercao()
    *==========================================================================
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cFpags))
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cInfos))
            MsgAviso("Tipo n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMoefpgs))
            MsgAviso("Moeda n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cFormas))
            MsgAviso("Forma n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "INSERT INTO SigOpFp (" + ;
                "fpags, descrs, titfpags, formas, moefpgs, infos, situas, codfpags, " + ;
                "nfpags, modpagto, grupods, contads, dcontads, orides, grupoos, contaos, " + ;
                "dcontaos, grupobs, contabs, grupots, contats, bancos, agencias, ncontas, " + ;
                "tvens, carauts, coldados, hists, ccupomnvs, operautos, operacaoss, " + ;
                "operacaoes, cpictures, garantias, lcartao, lsaque, opers, parcs, " + ;
                "autotef, tcdc, pcheque, dadchqs, codestabs, citems, dcarts, adquirente, " + ;
                "emps, parcfin, parcini, bandeira, cdcashback, especies, grupoemp, " + ;
                "mfinancs, datatrans, " + ;
                "aprovas, itemobrigs, bxcomis, cpags, desc2s, descs, dias, emichqs, " + ;
                "encargos, entradas, fparcs, fpcomiss, impbols, prazos, trocos, valpends, " + ;
                "impnotas, impdups, obs, tphists, ncodfinzs, impchqs, emivales, gavetas, " + ;
                "tpcheques, baixas, bxcomchqs, autenticas, mesfec, acvchqs, acumulas, " + ;
                "promos, agcobs, tolfcxs, tpvencs, pvarias, indices, libcsens, impcpchqs, " + ;
                "blqtabds, chkbins, chkfidels, nfinancs, opcsnas, vlrfpgs, liscongv, " + ;
                "cnidtefs, DetFecCxs, taxjuros, ndtcomis, chkcpf, libctablq, nsu, " + ;
                "chklimcre, relsomsub, chkvalgar, chknccmov, arredonda, chkcachbk, " + ;
                "chkuticach, autoriza, blqvctopar, vlrminpar, vlrlimfpgs, optcredcta, relmetvend" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cFpags)       + ", " + ;
                EscaparSQL(THIS.this_cDescrs)      + ", " + ;
                EscaparSQL(THIS.this_cTitfpags)    + ", " + ;
                EscaparSQL(THIS.this_cFormas)      + ", " + ;
                EscaparSQL(THIS.this_cMoefpgs)     + ", " + ;
                EscaparSQL(THIS.this_cInfos)       + ", " + ;
                EscaparSQL(THIS.this_cSituas)      + ", " + ;
                EscaparSQL(THIS.this_cCodfpags)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                EscaparSQL(THIS.this_cModpagto)    + ", " + ;
                EscaparSQL(THIS.this_cGrupods)     + ", " + ;
                EscaparSQL(THIS.this_cContads)     + ", " + ;
                EscaparSQL(THIS.this_cDcontads)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoos)     + ", " + ;
                EscaparSQL(THIS.this_cContaos)     + ", " + ;
                EscaparSQL(THIS.this_cDcontaos)    + ", " + ;
                EscaparSQL(THIS.this_cGrupobs)     + ", " + ;
                EscaparSQL(THIS.this_cContabs)     + ", " + ;
                EscaparSQL(THIS.this_cGrupots)     + ", " + ;
                EscaparSQL(THIS.this_cContats)     + ", " + ;
                EscaparSQL(THIS.this_cBancos)      + ", " + ;
                EscaparSQL(THIS.this_cAgencias)    + ", " + ;
                EscaparSQL(THIS.this_cNcontas)     + ", " + ;
                EscaparSQL(THIS.this_cTvens)       + ", " + ;
                EscaparSQL(THIS.this_cCarauts)     + ", " + ;
                EscaparSQL(THIS.this_cColdados)    + ", " + ;
                EscaparSQL(THIS.this_cHists)       + ", " + ;
                EscaparSQL(THIS.this_cCcupomnvs)   + ", " + ;
                EscaparSQL(THIS.this_cOperautos)   + ", " + ;
                EscaparSQL(THIS.this_cOperacaoss)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaoes)  + ", " + ;
                EscaparSQL(THIS.this_cCpictures)   + ", " + ;
                EscaparSQL(THIS.this_cGarantias)   + ", " + ;
                EscaparSQL(THIS.this_cLcartao)     + ", " + ;
                EscaparSQL(THIS.this_cLsaque)      + ", " + ;
                EscaparSQL(THIS.this_cOpers)       + ", " + ;
                EscaparSQL(THIS.this_cParcs)       + ", " + ;
                EscaparSQL(THIS.this_cAutotef)     + ", " + ;
                EscaparSQL(THIS.this_cTcdc)        + ", " + ;
                EscaparSQL(THIS.this_cPcheque)     + ", " + ;
                EscaparSQL(THIS.this_cDadchqs)     + ", " + ;
                EscaparSQL(THIS.this_cCodestabs)   + ", " + ;
                EscaparSQL(THIS.this_cCitems)      + ", " + ;
                EscaparSQL(THIS.this_cDcarts)      + ", " + ;
                EscaparSQL(THIS.this_cAdquirente)  + ", " + ;
                EscaparSQL(THIS.this_cEmps)        + ", " + ;
                EscaparSQL(THIS.this_cParcfin)     + ", " + ;
                EscaparSQL(THIS.this_cParcini)     + ", " + ;
                EscaparSQL(THIS.this_cBandeira)    + ", " + ;
                EscaparSQL(THIS.this_cCdcashback)  + ", " + ;
                EscaparSQL(THIS.this_cEspecies)    + ", " + ;
                EscaparSQL(THIS.this_cGrupoemp)    + ", " + ;
                EscaparSQL(THIS.this_cMfinancs)    + ", " + ;
                loc_cDatatrans                          + ", " + ;
                FormatarNumeroSQL(THIS.this_nAprovas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nItemobrigs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomis)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpags)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesc2s)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nDescs)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nDias)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmichqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEncargos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nEntradas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFparcs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nFpcomiss)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpbols)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrazos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTrocos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nValpends)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpnotas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpdups)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nObs)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nTphists)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcodfinzs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nEmivales)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nGavetas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpcheques) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaixas)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxcomchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nMesfec)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcvchqs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAcumulas)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nPromos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgcobs)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nTolfcxs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpvencs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvarias)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndices)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibcsens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpcpchqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqtabds)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkbins)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkfidels) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfinancs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nOpcsnas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrfpgs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nLiscongv)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCnidtefs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nDetFecCxs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTaxjuros)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdtcomis)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcpf)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLibctablq) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNsu)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nChklimcre) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRelsomsub) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkvalgar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChknccmov) + ", " + ;
                FormatarNumeroSQL(THIS.this_nArredonda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkcachbk) + ", " + ;
                FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nAutoriza)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrminpar) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                FormatarNumeroSQL(THIS.this_nRelmetvend)+ ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Inserir: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigOpFp
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDatatrans
        loc_lSucesso = .F.

        IF !THIS.ValidarInsercao()
            RETURN .F.
        ENDIF

        TRY
            loc_cDatatrans = IIF(EMPTY(THIS.this_dDatatrans), "NULL", ;
                                 FormatarDataSQL(THIS.this_dDatatrans))

            loc_cSQL = "UPDATE SigOpFp SET " + ;
                "descrs = "       + EscaparSQL(THIS.this_cDescrs)     + ", " + ;
                "titfpags = "     + EscaparSQL(THIS.this_cTitfpags)   + ", " + ;
                "formas = "       + EscaparSQL(THIS.this_cFormas)     + ", " + ;
                "moefpgs = "      + EscaparSQL(THIS.this_cMoefpgs)    + ", " + ;
                "infos = "        + EscaparSQL(THIS.this_cInfos)      + ", " + ;
                "situas = "       + EscaparSQL(THIS.this_cSituas)     + ", " + ;
                "codfpags = "     + EscaparSQL(THIS.this_cCodfpags)   + ", " + ;
                "nfpags = "       + FormatarNumeroSQL(THIS.this_nNfpags)    + ", " + ;
                "modpagto = "     + EscaparSQL(THIS.this_cModpagto)   + ", " + ;
                "grupods = "      + EscaparSQL(THIS.this_cGrupods)    + ", " + ;
                "contads = "      + EscaparSQL(THIS.this_cContads)    + ", " + ;
                "dcontads = "     + EscaparSQL(THIS.this_cDcontads)   + ", " + ;
                "orides = "       + FormatarNumeroSQL(THIS.this_nOrides)    + ", " + ;
                "grupoos = "      + EscaparSQL(THIS.this_cGrupoos)    + ", " + ;
                "contaos = "      + EscaparSQL(THIS.this_cContaos)    + ", " + ;
                "dcontaos = "     + EscaparSQL(THIS.this_cDcontaos)   + ", " + ;
                "grupobs = "      + EscaparSQL(THIS.this_cGrupobs)    + ", " + ;
                "contabs = "      + EscaparSQL(THIS.this_cContabs)    + ", " + ;
                "grupots = "      + EscaparSQL(THIS.this_cGrupots)    + ", " + ;
                "contats = "      + EscaparSQL(THIS.this_cContats)    + ", " + ;
                "bancos = "       + EscaparSQL(THIS.this_cBancos)     + ", " + ;
                "agencias = "     + EscaparSQL(THIS.this_cAgencias)   + ", " + ;
                "ncontas = "      + EscaparSQL(THIS.this_cNcontas)    + ", " + ;
                "tvens = "        + EscaparSQL(THIS.this_cTvens)      + ", " + ;
                "carauts = "      + EscaparSQL(THIS.this_cCarauts)    + ", " + ;
                "coldados = "     + EscaparSQL(THIS.this_cColdados)   + ", " + ;
                "hists = "        + EscaparSQL(THIS.this_cHists)      + ", " + ;
                "ccupomnvs = "    + EscaparSQL(THIS.this_cCcupomnvs)  + ", " + ;
                "operautos = "    + EscaparSQL(THIS.this_cOperautos)  + ", " + ;
                "operacaoss = "   + EscaparSQL(THIS.this_cOperacaoss) + ", " + ;
                "operacaoes = "   + EscaparSQL(THIS.this_cOperacaoes) + ", " + ;
                "cpictures = "    + EscaparSQL(THIS.this_cCpictures)  + ", " + ;
                "garantias = "    + EscaparSQL(THIS.this_cGarantias)  + ", " + ;
                "lcartao = "      + EscaparSQL(THIS.this_cLcartao)    + ", " + ;
                "lsaque = "       + EscaparSQL(THIS.this_cLsaque)     + ", " + ;
                "opers = "        + EscaparSQL(THIS.this_cOpers)      + ", " + ;
                "parcs = "        + EscaparSQL(THIS.this_cParcs)      + ", " + ;
                "autotef = "      + EscaparSQL(THIS.this_cAutotef)    + ", " + ;
                "tcdc = "         + EscaparSQL(THIS.this_cTcdc)       + ", " + ;
                "pcheque = "      + EscaparSQL(THIS.this_cPcheque)    + ", " + ;
                "dadchqs = "      + EscaparSQL(THIS.this_cDadchqs)    + ", " + ;
                "codestabs = "    + EscaparSQL(THIS.this_cCodestabs)  + ", " + ;
                "citems = "       + EscaparSQL(THIS.this_cCitems)     + ", " + ;
                "dcarts = "       + EscaparSQL(THIS.this_cDcarts)     + ", " + ;
                "adquirente = "   + EscaparSQL(THIS.this_cAdquirente) + ", " + ;
                "emps = "         + EscaparSQL(THIS.this_cEmps)       + ", " + ;
                "parcfin = "      + EscaparSQL(THIS.this_cParcfin)    + ", " + ;
                "parcini = "      + EscaparSQL(THIS.this_cParcini)    + ", " + ;
                "bandeira = "     + EscaparSQL(THIS.this_cBandeira)   + ", " + ;
                "cdcashback = "   + EscaparSQL(THIS.this_cCdcashback) + ", " + ;
                "especies = "     + EscaparSQL(THIS.this_cEspecies)   + ", " + ;
                "grupoemp = "     + EscaparSQL(THIS.this_cGrupoemp)   + ", " + ;
                "mfinancs = "     + EscaparSQL(THIS.this_cMfinancs)   + ", " + ;
                "datatrans = "    + loc_cDatatrans                         + ", " + ;
                "aprovas = "      + FormatarNumeroSQL(THIS.this_nAprovas)  + ", " + ;
                "itemobrigs = "   + FormatarNumeroSQL(THIS.this_nItemobrigs) + ", " + ;
                "bxcomis = "      + FormatarNumeroSQL(THIS.this_nBxcomis)  + ", " + ;
                "cpags = "        + FormatarNumeroSQL(THIS.this_nCpags)    + ", " + ;
                "desc2s = "       + FormatarNumeroSQL(THIS.this_nDesc2s)   + ", " + ;
                "descs = "        + FormatarNumeroSQL(THIS.this_nDescs)    + ", " + ;
                "dias = "         + FormatarNumeroSQL(THIS.this_nDias)     + ", " + ;
                "emichqs = "      + FormatarNumeroSQL(THIS.this_nEmichqs)  + ", " + ;
                "encargos = "     + FormatarNumeroSQL(THIS.this_nEncargos) + ", " + ;
                "entradas = "     + FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                "fparcs = "       + FormatarNumeroSQL(THIS.this_nFparcs)   + ", " + ;
                "fpcomiss = "     + FormatarNumeroSQL(THIS.this_nFpcomiss) + ", " + ;
                "impbols = "      + FormatarNumeroSQL(THIS.this_nImpbols)  + ", " + ;
                "prazos = "       + FormatarNumeroSQL(THIS.this_nPrazos)   + ", " + ;
                "trocos = "       + FormatarNumeroSQL(THIS.this_nTrocos)   + ", " + ;
                "valpends = "     + FormatarNumeroSQL(THIS.this_nValpends) + ", " + ;
                "impnotas = "     + FormatarNumeroSQL(THIS.this_nImpnotas) + ", " + ;
                "impdups = "      + FormatarNumeroSQL(THIS.this_nImpdups)  + ", " + ;
                "obs = "          + FormatarNumeroSQL(THIS.this_nObs)      + ", " + ;
                "tphists = "      + FormatarNumeroSQL(THIS.this_nTphists)  + ", " + ;
                "ncodfinzs = "    + FormatarNumeroSQL(THIS.this_nNcodfinzs)+ ", " + ;
                "impchqs = "      + FormatarNumeroSQL(THIS.this_nImpchqs)  + ", " + ;
                "emivales = "     + FormatarNumeroSQL(THIS.this_nEmivales) + ", " + ;
                "gavetas = "      + FormatarNumeroSQL(THIS.this_nGavetas)  + ", " + ;
                "tpcheques = "    + FormatarNumeroSQL(THIS.this_nTpcheques)+ ", " + ;
                "baixas = "       + FormatarNumeroSQL(THIS.this_nBaixas)   + ", " + ;
                "bxcomchqs = "    + FormatarNumeroSQL(THIS.this_nBxcomchqs)+ ", " + ;
                "autenticas = "   + FormatarNumeroSQL(THIS.this_nAutenticas)+ ", " + ;
                "mesfec = "       + FormatarNumeroSQL(THIS.this_nMesfec)   + ", " + ;
                "acvchqs = "      + FormatarNumeroSQL(THIS.this_nAcvchqs)  + ", " + ;
                "acumulas = "     + FormatarNumeroSQL(THIS.this_nAcumulas) + ", " + ;
                "promos = "       + FormatarNumeroSQL(THIS.this_nPromos)   + ", " + ;
                "agcobs = "       + FormatarNumeroSQL(THIS.this_nAgcobs)   + ", " + ;
                "tolfcxs = "      + FormatarNumeroSQL(THIS.this_nTolfcxs)  + ", " + ;
                "tpvencs = "      + FormatarNumeroSQL(THIS.this_nTpvencs)  + ", " + ;
                "pvarias = "      + FormatarNumeroSQL(THIS.this_nPvarias)  + ", " + ;
                "indices = "      + FormatarNumeroSQL(THIS.this_nIndices)  + ", " + ;
                "libcsens = "     + FormatarNumeroSQL(THIS.this_nLibcsens) + ", " + ;
                "impcpchqs = "    + FormatarNumeroSQL(THIS.this_nImpcpchqs)+ ", " + ;
                "blqtabds = "     + FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                "chkbins = "      + FormatarNumeroSQL(THIS.this_nChkbins)  + ", " + ;
                "chkfidels = "    + FormatarNumeroSQL(THIS.this_nChkfidels)+ ", " + ;
                "nfinancs = "     + FormatarNumeroSQL(THIS.this_nNfinancs) + ", " + ;
                "opcsnas = "      + FormatarNumeroSQL(THIS.this_nOpcsnas)  + ", " + ;
                "vlrfpgs = "      + FormatarNumeroSQL(THIS.this_nVlrfpgs)  + ", " + ;
                "liscongv = "     + FormatarNumeroSQL(THIS.this_nLiscongv) + ", " + ;
                "cnidtefs = "     + FormatarNumeroSQL(THIS.this_nCnidtefs) + ", " + ;
                "DetFecCxs = "    + FormatarNumeroSQL(THIS.this_nDetFecCxs)+ ", " + ;
                "taxjuros = "     + FormatarNumeroSQL(THIS.this_nTaxjuros) + ", " + ;
                "ndtcomis = "     + FormatarNumeroSQL(THIS.this_nNdtcomis) + ", " + ;
                "chkcpf = "       + FormatarNumeroSQL(THIS.this_nChkcpf)   + ", " + ;
                "libctablq = "    + FormatarNumeroSQL(THIS.this_nLibctablq)+ ", " + ;
                "nsu = "          + FormatarNumeroSQL(THIS.this_nNsu)      + ", " + ;
                "chklimcre = "    + FormatarNumeroSQL(THIS.this_nChklimcre)+ ", " + ;
                "relsomsub = "    + FormatarNumeroSQL(THIS.this_nRelsomsub)+ ", " + ;
                "chkvalgar = "    + FormatarNumeroSQL(THIS.this_nChkvalgar)+ ", " + ;
                "chknccmov = "    + FormatarNumeroSQL(THIS.this_nChknccmov)+ ", " + ;
                "arredonda = "    + FormatarNumeroSQL(THIS.this_nArredonda)+ ", " + ;
                "chkcachbk = "    + FormatarNumeroSQL(THIS.this_nChkcachbk)+ ", " + ;
                "chkuticach = "   + FormatarNumeroSQL(THIS.this_nChkuticach)+ ", " + ;
                "autoriza = "     + FormatarNumeroSQL(THIS.this_nAutoriza) + ", " + ;
                "blqvctopar = "   + FormatarNumeroSQL(THIS.this_nBlqvctopar)+ ", " + ;
                "vlrminpar = "    + FormatarNumeroSQL(THIS.this_nVlrminpar)+ ", " + ;
                "vlrlimfpgs = "   + FormatarNumeroSQL(THIS.this_nVlrlimfpgs)+ ", " + ;
                "optcredcta = "   + FormatarNumeroSQL(THIS.this_nOptcredcta)+ ", " + ;
                "relmetvend = "   + FormatarNumeroSQL(THIS.this_nRelmetvend)+ ;
                " WHERE fpags = " + EscaparSQL(THIS.this_cFpags)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.Atualizar: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui o registro e suas filhas
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cFpags, loc_cSQLi, loc_cSQLp, loc_cSQLm
        LOCAL loc_nRi, loc_nRp, loc_nRm, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFpags = EscaparSQL(ALLTRIM(THIS.this_cFpags))

            *-- Exclui filha SigOpFpI
            loc_cSQLi = "DELETE FROM SigOpFpI WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelI")
                TABLEREVERT(.T., "cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            loc_nRi = SQLEXEC(gnConnHandle, loc_cSQLi, "cursor_4c_DelI")
            IF USED("cursor_4c_DelI")
                USE IN cursor_4c_DelI
            ENDIF

            *-- Exclui filha SigOpFpP
            loc_cSQLp = "DELETE FROM SigOpFpP WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelP")
                TABLEREVERT(.T., "cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            loc_nRp = SQLEXEC(gnConnHandle, loc_cSQLp, "cursor_4c_DelP")
            IF USED("cursor_4c_DelP")
                USE IN cursor_4c_DelP
            ENDIF

            *-- Exclui registro principal
            loc_cSQLm = "DELETE FROM SigOpFp WHERE fpags = " + loc_cFpags
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelM")
                TABLEREVERT(.T., "cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            loc_nRm = SQLEXEC(gnConnHandle, loc_cSQLm, "cursor_4c_DelM")
            IF USED("cursor_4c_DelM")
                USE IN cursor_4c_DelM
            ENDIF

            IF loc_nRm >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em pagBO.ExecutarExclusao: " + loc_oErro.Message + ;
                    " (Linha " + TRANSFORM(loc_oErro.LineNo) + ")", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE

