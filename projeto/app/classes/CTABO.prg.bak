*-----------------------------------------------------------------
* CTABO.prg - BO Cadastro de Contas (SigCdCli)
* Herda BusinessBase | Entidade: CTA
*-----------------------------------------------------------------
DEFINE CLASS CTABO AS BusinessBase

  this_cTabela     = "SigCdCli"
  this_cCampoChave = "IClis"

  *-- Chave primaria
  this_cIClis          = ""

  *-- Identificacao basica
  this_nIdcontas       = 0
  this_nIdconta        = 0
  this_nNclis          = 0
  this_cGrupos         = ""
  this_cRclis          = ""
  this_cRazaos         = ""
  this_cCpfs           = ""
  this_cRgs            = ""
  this_cEmissors       = ""
  this_cSenhas         = ""
  this_cCodigos        = ""
  this_cCtelems        = ""

  *-- Status e classificacao
  this_cSituas         = ""
  this_nInativas       = 0
  this_nVinculas       = 0
  this_nTpcads         = 0
  this_nTpclis         = 0
  this_cTabds          = ""
  this_cTabd2s         = ""
  this_cLprecos        = ""
  this_cFpags          = ""
  this_nPrazoents      = 0
  this_cCodsegs        = ""
  this_cCodvendedor    = ""
  this_nDiasPEntrega   = 0

  *-- Empresa e responsavel
  this_cEmps           = ""
  this_cUsualts        = ""
  this_cUsuars         = ""
  this_cGrupovens      = ""
  this_cGruprods       = ""
  this_cGrupocents     = ""
  this_cGrupocobs      = ""
  this_cGrupomats      = ""
  this_cContacobs      = ""
  this_cContamats      = ""
  this_cContavens      = ""
  this_cContaven2s     = ""
  this_cContacents     = ""
  this_cConprods       = ""
  this_cContato        = ""
  this_cContats        = ""
  this_cCcontabs       = ""

  *-- Endere?o principal
  this_cEndes          = ""
  this_cNums           = ""
  this_cCompls         = ""
  this_cBairs          = ""
  this_cCidas          = ""
  this_cEstas          = ""
  this_cCeps           = ""
  this_cPaises         = ""
  this_cRegiaos        = ""
  this_nNmuncips       = 0
  this_cInscmuns       = ""

  *-- Contato e telefone
  this_cDdds           = ""
  this_cTel1s          = ""
  this_cTel2s          = ""
  this_cTel3s          = ""
  this_cFaxs           = ""
  this_cRamals         = ""
  this_cDdd2s          = ""
  this_cEmails         = ""

  *-- Dados pessoais
  this_dNascs          = {}
  this_cSexos          = ""
  this_cNacionals      = ""
  this_cEstcivils      = ""
  this_cConjuges       = ""
  this_cCpfcs          = ""
  this_cRgconjuges     = ""
  this_dDtcasas        = {}
  this_dDtncons        = {}
  this_cDmcasas        = ""
  this_cDmconjs        = ""
  this_cDmnascs        = ""
  this_cMaes           = ""
  this_cPais           = ""
  this_cGraupares      = ""
  this_cProfiss        = ""
  this_cNomearts       = ""

  *-- Datas de controle
  this_dDtalts         = {}
  this_dDataincs       = {}
  this_dUltcomps       = {}
  this_dDtvals         = {}
  this_dDtfilms        = {}
  this_dDtatrans       = {}
  this_dDtfats         = {}
  this_dDtmacums       = {}
  this_dDtadmis        = {}
  this_dPenultcomp     = {}
  this_dDataesp        = {}
  this_dAutdtavld      = {}

  *-- Credito e financeiro
  this_nLimcres        = 0
  this_nVultcomps      = 0
  this_nMacums         = 0
  this_nMfats          = 0
  this_nJuros          = 0
  this_nComis          = 0
  this_nPercdescli     = 0

  *-- Endere?o de cobran?a
  this_cEndcobs        = ""
  this_cCepcobs        = ""
  this_cCidcobs        = ""
  this_cEstcobs        = ""
  this_cBaicobs        = ""
  this_cPaicobs        = ""

  *-- Endere?o de entrega (cos)
  this_cEndcos         = ""
  this_cCepcos         = ""
  this_cCidcos         = ""
  this_cEstcos         = ""
  this_cBaicos         = ""
  this_cNomecos        = ""
  this_cComplcos       = ""
  this_nNumcos         = 0

  *-- Endere?o de trabalho
  this_cEndtrabs       = ""
  this_cCeptrabs       = ""
  this_cCidatrabs      = ""
  this_cCidtrabs       = ""
  this_cEstatrabs      = ""
  this_cEsttrabs       = ""
  this_cBairtrabs      = ""
  this_cPaitrabs       = ""
  this_cNumtrabs       = ""
  this_cCompltrabs     = ""
  this_cEmptrabs       = ""
  this_cCnpjtrabs      = ""
  this_cTeltrabs       = ""

  *-- Flags e controles numericos
  this_nConcilas       = 0
  this_nColetors       = 0
  this_nVcolets        = 0
  this_nGerbals        = 0
  this_nPagfals        = 0
  this_nRecfals        = 0
  this_nIntconts       = 0
  this_nTphists        = 0
  this_nAptos          = 0
  this_nComcargs       = 0
  this_nMasters        = 0
  this_nLibtabcmvs     = 0
  this_nConsigs        = 0
  this_nPatrietqs      = 0
  this_nRestfors       = 0
  this_nConsignas      = 0
  this_nMsgpends       = 0
  this_nCtaencrypt     = 0
  this_nChkexcdre      = 0
  this_nDdanular       = 0
  this_nDdindicado     = 0
  this_nDdmedio        = 0
  this_nDdminimo       = 0
  this_nDdpolegar      = 0
  this_nInvisivel      = 0
  this_nValemail       = 0

  *-- LGPD / Consentimentos
  this_nAutdados       = 0
  this_nAutemail       = 0
  this_nAutsms         = 0
  this_nAutwhats       = 0
  this_nAutteleg       = 0
  this_cUsuariocrm     = ""

  *-- Valores beneficios/transporte
  this_nVlrvaltransp   = 0
  this_nVlrvalref      = 0
  this_nVlrvalalim     = 0
  this_nVlrplansaude   = 0
  this_nVlrplandent    = 0
  this_nSalarios       = 0
  this_nRendafams      = 0
  this_nMaxtransps     = 0

  *-- Codigos adicionais
  this_cFpubls         = ""
  this_cCfos           = ""
  this_cCodtifs        = ""
  this_cGrufals        = ""
  this_cSuframas       = ""
  this_cTpcps          = ""
  this_cRgcs           = ""
  this_cCcartoes       = ""
  this_cHists          = ""
  this_cPracas         = ""
  this_cObspagto       = ""
  this_cPis            = ""
  this_cMicroemps      = ""
  this_cOptsimples     = ""
  this_nEan13ents      = 0
  this_nEan13cobs      = 0

  *-- Memo / texto longo
  this_mObs            = ""
  this_mPerfils        = ""
  this_mPastas         = ""
  this_mFigjpgs        = ""
  this_mFiglgpds       = ""
  this_cCobs           = ""

  *-- Configuracoes fiscais (9 tipos)
  this_cCfgFisICs      = ""
  this_cCfgFisIPs      = ""
  this_cCfgFisIIs      = ""
  this_cCfgFisISs      = ""
  this_cCfgFisIRs      = ""
  this_cCfgFisINs      = ""
  this_cCfgFisPIs      = ""
  this_cCfgFisCSs      = ""
  this_cCfgFisCOs      = ""

  *-------------------------------------------------------------
  FUNCTION Init()
  *-------------------------------------------------------------
    DODEFAULT()
    THIS.this_cTabela     = "SigCdCli"
    THIS.this_cCampoChave = "IClis"
    RETURN .T.
  ENDFUNC

  *-------------------------------------------------------------
  FUNCTION ObterChavePrimaria()
  *-------------------------------------------------------------
    RETURN ALLTRIM(THIS.this_cIClis)
  ENDFUNC

  *-------------------------------------------------------------
  FUNCTION Buscar(par_cFiltro)
  *-- Lista contas com colunas da grade (grupos+periodo)
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_nRet
    loc_lResultado = .F.

    TRY
      IF USED("cursor_4c_Dados")
        USE IN cursor_4c_Dados
      ENDIF

      IF VARTYPE(par_cFiltro) != "C"
        par_cFiltro = ""
      ENDIF

      loc_cSQL = "SELECT a.IClis, a.Grupos, a.Rclis, a.Cpfs, a.Rgs," + ;
                 " a.Situas, a.DtAlts, a.Ultcomps, a.Usualts," + ;
                 " a.Inativas, a.Ddds, a.Tel1s" + ;
                 " FROM SigCdCli a"

      IF !EMPTY(par_cFiltro)
        loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
      ENDIF

      loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Rclis"

      *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
      IF USED("cursor_4c_Dados")
          TABLEREVERT(.T., "cursor_4c_Dados")
          USE IN cursor_4c_Dados
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
      IF loc_nRet > 0
        IF USED("cursor_4c_Dados")
          GO TOP IN cursor_4c_Dados
        ENDIF
        loc_lResultado = .T.
      ELSE
        MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.Buscar:" + CHR(13) + loException.Message, "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  FUNCTION BuscarComFiltro(par_cGrupo, par_dDtIni, par_dDtFim)
  *-- Lista com filtro de grupo e periodo de alteracao
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nRet
    loc_lResultado = .F.

    TRY
      IF USED("cursor_4c_Dados")
        USE IN cursor_4c_Dados
      ENDIF

      loc_cSQL   = "SELECT a.IClis, a.Grupos, a.Rclis, a.Cpfs, a.Rgs," + ;
                   " a.Situas, a.DtAlts, a.Ultcomps, a.Usualts," + ;
                   " a.Inativas, a.Ddds, a.Tel1s" + ;
                   " FROM SigCdCli a"
      loc_cWhere = ""

      IF VARTYPE(par_cGrupo) = "C" AND !EMPTY(par_cGrupo)
        loc_cWhere = " WHERE a.Grupos = " + EscaparSQL(PADR(par_cGrupo, 10))
      ENDIF

      IF VARTYPE(par_dDtIni) = "D" AND !EMPTY(par_dDtIni) AND ;
         VARTYPE(par_dDtFim) = "D" AND !EMPTY(par_dDtFim)
        IF EMPTY(loc_cWhere)
          loc_cWhere = " WHERE a.DtAlts BETWEEN " + FormatarDataSQL(par_dDtIni) + ;
                       " AND " + FormatarDataSQL(par_dDtFim)
        ELSE
          loc_cWhere = loc_cWhere + ;
                       " AND a.DtAlts BETWEEN " + FormatarDataSQL(par_dDtIni) + ;
                       " AND " + FormatarDataSQL(par_dDtFim)
        ENDIF
      ENDIF

      loc_cSQL = loc_cSQL + loc_cWhere + " ORDER BY a.Rclis"
      *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
      IF USED("cursor_4c_Dados")
          TABLEREVERT(.T., "cursor_4c_Dados")
          USE IN cursor_4c_Dados
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

      IF loc_nRet > 0
        GO TOP IN cursor_4c_Dados
        loc_lResultado = .T.
      ELSE
        MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.BuscarComFiltro:" + CHR(13) + loException.Message, "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  FUNCTION CarregarPorCodigo(par_cICli)
  *-- Carrega registro completo pelo IClis (PK)
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_nRet
    loc_lResultado = .F.

    TRY
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF

      IF VARTYPE(par_cICli) != "C" OR EMPTY(par_cICli)
        loc_lResultado = .F.
      ELSE
        loc_cSQL = "SELECT * FROM SigCdCli WHERE IClis = " + ;
                   EscaparSQL(PADR(par_cICli, 10))

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

        IF loc_nRet > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
          loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
          THIS.this_lNovoRegistro = .F.
        ENDIF

        IF USED("cursor_4c_Carrega")
          USE IN cursor_4c_Carrega
        ENDIF
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  PROTECTED FUNCTION CarregarDoCursor(par_cAlias)
  *-- Mapeia todos os campos do cursor para propriedades do BO
  *-------------------------------------------------------------
    LOCAL loc_lResultado
    loc_lResultado = .F.

    IF USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
      SELECT (par_cAlias)
      GO TOP IN (par_cAlias)

      THIS.this_cIClis        = TratarNulo(IClis,        "C")
      THIS.this_nIdcontas     = TratarNulo(Idcontas,     "N")
      THIS.this_nIdconta      = TratarNulo(Idconta,      "N")
      THIS.this_nNclis        = TratarNulo(Nclis,        "N")
      THIS.this_cGrupos       = TratarNulo(Grupos,       "C")
      THIS.this_cRclis        = TratarNulo(Rclis,        "C")
      THIS.this_cRazaos       = TratarNulo(Razaos,       "C")
      THIS.this_cCpfs         = TratarNulo(Cpfs,         "C")
      THIS.this_cRgs          = TratarNulo(Rgs,          "C")
      THIS.this_cEmissors     = TratarNulo(Emissors,     "C")
      THIS.this_cSenhas       = TratarNulo(Senhas,       "C")
      THIS.this_cCodigos      = TratarNulo(Codigos,      "C")
      THIS.this_cCtelems      = TratarNulo(Ctelems,      "C")
      THIS.this_cSituas       = TratarNulo(Situas,       "C")
      THIS.this_nInativas     = TratarNulo(Inativas,     "N")
      THIS.this_nVinculas     = TratarNulo(Vinculas,     "N")
      THIS.this_nTpcads       = TratarNulo(Tpcads,       "N")
      THIS.this_nTpclis       = TratarNulo(Tpclis,       "N")
      THIS.this_cTabds        = TratarNulo(Tabds,        "C")
      THIS.this_cTabd2s       = TratarNulo(Tabd2s,       "C")
      THIS.this_cLprecos      = TratarNulo(Lprecos,      "C")
      THIS.this_cFpags        = TratarNulo(Fpags,        "C")
      THIS.this_nPrazoents    = TratarNulo(Prazoents,    "N")
      THIS.this_cCodsegs      = TratarNulo(Codsegs,      "C")
      THIS.this_cEmps         = TratarNulo(Emps,         "C")
      THIS.this_cUsualts      = TratarNulo(Usualts,      "C")
      THIS.this_cUsuars       = TratarNulo(Usuars,       "C")
      THIS.this_cGrupovens    = TratarNulo(Grupovens,    "C")
      THIS.this_cGruprods     = TratarNulo(Gruprods,     "C")
      THIS.this_cGrupocents   = TratarNulo(Grupocents,   "C")
      THIS.this_cGrupocobs    = TratarNulo(Grupocobs,    "C")
      THIS.this_cGrupomats    = TratarNulo(Grupomats,    "C")
      THIS.this_cContacobs    = TratarNulo(Contacobs,    "C")
      THIS.this_cContamats    = TratarNulo(Contamats,    "C")
      THIS.this_cContavens    = TratarNulo(Contavens,    "C")
      THIS.this_cContaven2s   = TratarNulo(Contaven2s,   "C")
      THIS.this_cContacents   = TratarNulo(Contacents,   "C")
      THIS.this_cConprods     = TratarNulo(Conprods,     "C")
      THIS.this_cContato      = TratarNulo(Contato,      "C")
      THIS.this_cContats      = TratarNulo(Contats,      "C")
      THIS.this_cCcontabs     = TratarNulo(Ccontabs,     "C")
      THIS.this_cEndes        = TratarNulo(Endes,        "C")
      THIS.this_cNums         = TratarNulo(Nums,         "C")
      THIS.this_cCompls       = TratarNulo(Compls,       "C")
      THIS.this_cBairs        = TratarNulo(Bairs,        "C")
      THIS.this_cCidas        = TratarNulo(Cidas,        "C")
      THIS.this_cEstas        = TratarNulo(Estas,        "C")
      THIS.this_cCeps         = TratarNulo(Ceps,         "C")
      THIS.this_cPaises       = TratarNulo(Paises,       "C")
      THIS.this_cRegiaos      = TratarNulo(Regiaos,      "C")
      THIS.this_nNmuncips     = TratarNulo(Nmuncips,     "N")
      THIS.this_cInscmuns     = TratarNulo(Inscmuns,     "C")
      THIS.this_cDdds         = TratarNulo(Ddds,         "C")
      THIS.this_cTel1s        = TratarNulo(Tel1s,        "C")
      THIS.this_cTel2s        = TratarNulo(Tel2s,        "C")
      THIS.this_cTel3s        = TratarNulo(Tel3s,        "C")
      THIS.this_cFaxs         = TratarNulo(Faxs,         "C")
      THIS.this_cRamals       = TratarNulo(Ramals,       "C")
      THIS.this_cDdd2s        = TratarNulo(Ddd2s,        "C")
      THIS.this_cEmails       = TratarNulo(Emails,       "C")
      THIS.this_dNascs        = TratarNulo(Nascs,        "D")
      THIS.this_cSexos        = TratarNulo(Sexos,        "C")
      THIS.this_cNacionals    = TratarNulo(Nacionals,    "C")
      THIS.this_cEstcivils    = TratarNulo(Estcivils,    "C")
      THIS.this_cConjuges     = TratarNulo(Conjuges,     "C")
      THIS.this_cCpfcs        = TratarNulo(Cpfcs,        "C")
      THIS.this_cRgconjuges   = TratarNulo(Rgconjuges,   "C")
      THIS.this_dDtcasas      = TratarNulo(Dtcasas,      "D")
      THIS.this_dDtncons      = TratarNulo(Dtncons,      "D")
      THIS.this_cDmcasas      = TratarNulo(Dmcasas,      "C")
      THIS.this_cDmconjs      = TratarNulo(Dmconjs,      "C")
      THIS.this_cDmnascs      = TratarNulo(Dmnascs,      "C")
      THIS.this_cMaes         = TratarNulo(Maes,         "C")
      THIS.this_cPais         = TratarNulo(Pais,         "C")
      THIS.this_cGraupares    = TratarNulo(Grauparens,   "C")
      THIS.this_cProfiss      = TratarNulo(Profiss,      "C")
      THIS.this_cNomearts     = TratarNulo(Nomearts,     "C")
      THIS.this_dDtalts       = TratarNulo(DtAlts,       "D")
      THIS.this_dDataincs     = TratarNulo(Dataincs,     "D")
      THIS.this_dUltcomps     = TratarNulo(Ultcomps,     "D")
      THIS.this_dDtvals       = TratarNulo(Dtvals,       "D")
      THIS.this_dDtfilms      = TratarNulo(Dtfilms,      "D")
      THIS.this_dDtatrans     = TratarNulo(Dtatrans,     "D")
      THIS.this_dDtfats       = TratarNulo(Dtfats,       "D")
      THIS.this_dDtmacums     = TratarNulo(Dtmacums,     "D")
      THIS.this_dDtadmis      = TratarNulo(Dtadmis,      "D")
      THIS.this_dPenultcomp   = TratarNulo(Penultcomp,   "D")
      THIS.this_dAutdtavld    = TratarNulo(Autdtavld,    "D")
      THIS.this_nLimcres      = TratarNulo(Limcres,      "N")
      THIS.this_nVultcomps    = TratarNulo(Vultcomps,    "N")
      THIS.this_nMacums       = TratarNulo(Macums,       "N")
      THIS.this_nMfats        = TratarNulo(Mfats,        "N")
      THIS.this_nJuros        = TratarNulo(Juros,        "N")
      THIS.this_nComis        = TratarNulo(Comis,        "N")
      THIS.this_nPercdescli   = TratarNulo(Percdescli,   "N")
      THIS.this_cEndcobs      = TratarNulo(Endcobs,      "C")
      THIS.this_cCepcobs      = TratarNulo(Cepcobs,      "C")
      THIS.this_cCidcobs      = TratarNulo(Cidcobs,      "C")
      THIS.this_cEstcobs      = TratarNulo(Estcobs,      "C")
      THIS.this_cBaicobs      = TratarNulo(Baicobs,      "C")
      THIS.this_cPaicobs      = TratarNulo(Paicobs,      "C")
      THIS.this_cEndcos       = TratarNulo(Endcos,       "C")
      THIS.this_cCepcos       = TratarNulo(Cepcos,       "C")
      THIS.this_cCidcos       = TratarNulo(Cidcos,       "C")
      THIS.this_cEstcos       = TratarNulo(Estcos,       "C")
      THIS.this_cBaicos       = TratarNulo(Baicos,       "C")
      THIS.this_cNomecos      = TratarNulo(Nomecos,      "C")
      THIS.this_cComplcos     = TratarNulo(Complcos,     "C")
      THIS.this_nNumcos       = TratarNulo(Numcos,       "N")
      THIS.this_cEndtrabs     = TratarNulo(Endtrabs,     "C")
      THIS.this_cCeptrabs     = TratarNulo(Ceptrabs,     "C")
      THIS.this_cCidtrabs     = TratarNulo(Cidtrabs,     "C")
      THIS.this_cEsttrabs     = TratarNulo(Esttrabs,     "C")
      THIS.this_cBairtrabs    = TratarNulo(Bairtrabs,    "C")
      THIS.this_cPaitrabs     = TratarNulo(Paitrabs,     "C")
      THIS.this_cNumtrabs     = TratarNulo(Numtrabs,     "C")
      THIS.this_cCompltrabs   = TratarNulo(Compltrabs,   "C")
      THIS.this_cEmptrabs     = TratarNulo(Emptrabs,     "C")
      THIS.this_cCnpjtrabs    = TratarNulo(Cnpjtrabs,    "C")
      THIS.this_cTeltrabs     = TratarNulo(Teltrabs,     "C")
      THIS.this_nConcilas     = TratarNulo(Concilias,    "N")
      THIS.this_nColetors     = TratarNulo(Coletors,     "N")
      THIS.this_nVcolets      = TratarNulo(Vcolets,      "N")
      THIS.this_nGerbals      = TratarNulo(Gerbals,      "N")
      THIS.this_nPagfals      = TratarNulo(Pagfals,      "N")
      THIS.this_nRecfals      = TratarNulo(Recfals,      "N")
      THIS.this_nIntconts     = TratarNulo(Intconts,     "N")
      THIS.this_nTphists      = TratarNulo(Tphists,      "N")
      THIS.this_nAptos        = TratarNulo(Aptos,        "N")
      THIS.this_nComcargs     = TratarNulo(Comcargs,     "N")
      THIS.this_nMasters      = TratarNulo(Masters,      "N")
      THIS.this_nLibtabcmvs   = TratarNulo(Libtabcmvs,  "N")
      THIS.this_nConsigs      = TratarNulo(Consigs,      "N")
      THIS.this_nPatrietqs    = TratarNulo(Patrietqs,    "N")
      THIS.this_nRestfors     = TratarNulo(Restfors,     "N")
      THIS.this_nConsignas    = TratarNulo(Consignas,    "N")
      THIS.this_nMsgpends     = TratarNulo(Msgpends,     "N")
      THIS.this_nCtaencrypt   = TratarNulo(Ctaencrypt,   "N")
      THIS.this_nChkexcdre    = TratarNulo(Chkexcdre,    "N")
      THIS.this_nDdanular     = TratarNulo(Ddanular,     "N")
      THIS.this_nDdindicado   = TratarNulo(Ddindicado,   "N")
      THIS.this_nDdmedio      = TratarNulo(Ddmedio,      "N")
      THIS.this_nDdminimo     = TratarNulo(Ddminimo,     "N")
      THIS.this_nDdpolegar    = TratarNulo(Ddpolegar,    "N")
      THIS.this_nInvisivel    = TratarNulo(Invisivel,    "N")
      THIS.this_nValemail     = TratarNulo(Valemail,     "N")
      THIS.this_nAutdados     = TratarNulo(Autdados,     "N")
      THIS.this_nAutemail     = TratarNulo(Autemail,     "N")
      THIS.this_nAutsms       = TratarNulo(Autsms,       "N")
      THIS.this_nAutwhats     = TratarNulo(Autwhats,     "N")
      THIS.this_nAutteleg     = TratarNulo(Autteleg,     "N")
      THIS.this_cUsuariocrm   = TratarNulo(Usuariocrm,  "C")
      THIS.this_nVlrvaltransp = TratarNulo(Vlrvaltransp, "N")
      THIS.this_nVlrvalref    = TratarNulo(Vlrvalref,    "N")
      THIS.this_nVlrvalalim   = TratarNulo(Vlrvalalim,   "N")
      THIS.this_nVlrplansaude = TratarNulo(Vlrplansaude, "N")
      THIS.this_nVlrplandent  = TratarNulo(Vlrplandent,  "N")
      THIS.this_nSalarios     = TratarNulo(Salarios,     "N")
      THIS.this_nRendafams    = TratarNulo(Rendafams,    "N")
      THIS.this_nMaxtransps   = TratarNulo(Maxtransps,   "N")
      THIS.this_cFpubls       = TratarNulo(Fpubls,       "C")
      THIS.this_cCfos         = TratarNulo(Cfos,         "C")
      THIS.this_cCodtifs      = TratarNulo(Codtifs,      "C")
      THIS.this_cGrufals      = TratarNulo(Grufals,      "C")
      THIS.this_cSuframas     = TratarNulo(Suframas,     "C")
      THIS.this_cTpcps        = TratarNulo(Tpcps,        "C")
      THIS.this_cRgcs         = TratarNulo(Rgcs,         "C")
      THIS.this_cCcartoes     = TratarNulo(Ccartoes,     "C")
      THIS.this_cHists        = TratarNulo(Hists,        "C")
      THIS.this_cPracas       = TratarNulo(Pracas,       "C")
      THIS.this_cObspagto     = TratarNulo(Obspagto,     "C")
      THIS.this_cPis          = TratarNulo(Pis,          "C")
      THIS.this_cMicroemps    = TratarNulo(Microemps,    "C")
      THIS.this_cOptsimples   = TratarNulo(Optsimples,   "C")
      THIS.this_nEan13ents    = TratarNulo(Ean13ents,    "N")
      THIS.this_nEan13cobs    = TratarNulo(Ean13cobs,    "N")
      THIS.this_mObs          = TratarNulo(Obs,          "C")
      THIS.this_mPerfils      = TratarNulo(Perfils,      "C")
      THIS.this_mPastas       = TratarNulo(Pastas,       "C")
      THIS.this_mFigjpgs      = TratarNulo(Figjpgs,      "C")
      THIS.this_mFiglgpds     = TratarNulo(Figlgpds,     "C")
      THIS.this_cCobs         = TratarNulo(Cobs,         "C")
      THIS.this_cCfgFisICs    = TratarNulo(CfgFisICs,   "C")
      THIS.this_cCfgFisIPs    = TratarNulo(CfgFisIPs,   "C")
      THIS.this_cCfgFisIIs    = TratarNulo(CfgFisIIs,   "C")
      THIS.this_cCfgFisISs    = TratarNulo(CfgFisISs,   "C")
      THIS.this_cCfgFisIRs    = TratarNulo(CfgFisIRs,   "C")
      THIS.this_cCfgFisINs    = TratarNulo(CfgFisINs,   "C")
      THIS.this_cCfgFisPIs    = TratarNulo(CfgFisPIs,   "C")
      THIS.this_cCfgFisCSs    = TratarNulo(CfgFisCSs,   "C")
      THIS.this_cCfgFisCOs    = TratarNulo(CfgFisCOs,   "C")

      loc_lResultado = .T.
    ENDIF

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  PROTECTED FUNCTION Inserir()
  *-- INSERT INTO SigCdCli com todos os campos
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_nRet
    LOCAL loc_cVals1, loc_cVals2, loc_cVals3, loc_cVals4, loc_cVals5
    loc_lResultado = .F.

    TRY
      *-- Grupo 1: chave e identificacao basica
      loc_cVals1 = EscaparSQL(PADR(THIS.this_cIClis,10)) + ", " + ;
                   EscaparSQL(PADR(THIS.this_cGrupos,10)) + ", " + ;
                   EscaparSQL(THIS.this_cRclis) + ", " + ;
                   EscaparSQL(THIS.this_cRazaos) + ", " + ;
                   EscaparSQL(THIS.this_cCpfs) + ", " + ;
                   EscaparSQL(THIS.this_cRgs) + ", " + ;
                   EscaparSQL(THIS.this_cEmissors) + ", " + ;
                   EscaparSQL(THIS.this_cSenhas) + ", " + ;
                   EscaparSQL(THIS.this_cCodigos) + ", " + ;
                   EscaparSQL(THIS.this_cCtelems) + ", " + ;
                   EscaparSQL(THIS.this_cSituas) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nInativas) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVinculas) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nTpcads) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nTpclis) + ","

      *-- Grupo 2: classificacao e contatos de grupo
      loc_cVals2 = " " + EscaparSQL(THIS.this_cTabds) + ", " + ;
                   EscaparSQL(THIS.this_cTabd2s) + ", " + ;
                   EscaparSQL(THIS.this_cLprecos) + ", " + ;
                   EscaparSQL(THIS.this_cFpags) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nPrazoents) + ", " + ;
                   EscaparSQL(THIS.this_cCodsegs) + ", " + ;
                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                   EscaparSQL(THIS.this_cUsualts) + ", " + ;
                   EscaparSQL(THIS.this_cUsuars) + ", " + ;
                   EscaparSQL(THIS.this_cGrupovens) + ", " + ;
                   EscaparSQL(THIS.this_cGruprods) + ", " + ;
                   EscaparSQL(THIS.this_cGrupocents) + ", " + ;
                   EscaparSQL(THIS.this_cGrupocobs) + ", " + ;
                   EscaparSQL(THIS.this_cGrupomats) + ", " + ;
                   EscaparSQL(THIS.this_cContacobs) + ", " + ;
                   EscaparSQL(THIS.this_cContamats) + ", " + ;
                   EscaparSQL(THIS.this_cContavens) + ", " + ;
                   EscaparSQL(THIS.this_cContaven2s) + ", " + ;
                   EscaparSQL(THIS.this_cContacents) + ", " + ;
                   EscaparSQL(THIS.this_cConprods) + ", " + ;
                   EscaparSQL(THIS.this_cContato) + ", " + ;
                   EscaparSQL(THIS.this_cContats) + ", " + ;
                   EscaparSQL(THIS.this_cCcontabs) + ","

      *-- Grupo 3: enderecos e contatos telefonicos
      loc_cVals3 = " " + EscaparSQL(THIS.this_cEndes) + ", " + ;
                   EscaparSQL(THIS.this_cNums) + ", " + ;
                   EscaparSQL(THIS.this_cCompls) + ", " + ;
                   EscaparSQL(THIS.this_cBairs) + ", " + ;
                   EscaparSQL(THIS.this_cCidas) + ", " + ;
                   EscaparSQL(THIS.this_cEstas) + ", " + ;
                   EscaparSQL(THIS.this_cCeps) + ", " + ;
                   EscaparSQL(THIS.this_cPaises) + ", " + ;
                   EscaparSQL(THIS.this_cRegiaos) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNmuncips) + ", " + ;
                   EscaparSQL(THIS.this_cInscmuns) + ", " + ;
                   EscaparSQL(THIS.this_cDdds) + ", " + ;
                   EscaparSQL(THIS.this_cTel1s) + ", " + ;
                   EscaparSQL(THIS.this_cTel2s) + ", " + ;
                   EscaparSQL(THIS.this_cTel3s) + ", " + ;
                   EscaparSQL(THIS.this_cFaxs) + ", " + ;
                   EscaparSQL(THIS.this_cRamals) + ", " + ;
                   EscaparSQL(THIS.this_cDdd2s) + ", " + ;
                   EscaparSQL(THIS.this_cEmails) + ","

      *-- Grupo 4: dados pessoais e datas
      loc_cVals4 = " " + FormatarDataSQL(THIS.this_dNascs) + ", " + ;
                   EscaparSQL(THIS.this_cSexos) + ", " + ;
                   EscaparSQL(THIS.this_cNacionals) + ", " + ;
                   EscaparSQL(THIS.this_cEstcivils) + ", " + ;
                   EscaparSQL(THIS.this_cConjuges) + ", " + ;
                   EscaparSQL(THIS.this_cCpfcs) + ", " + ;
                   EscaparSQL(THIS.this_cRgconjuges) + ", " + ;
                   FormatarDataSQL(THIS.this_dDtcasas) + ", " + ;
                   FormatarDataSQL(THIS.this_dDtncons) + ", " + ;
                   EscaparSQL(THIS.this_cDmcasas) + ", " + ;
                   EscaparSQL(THIS.this_cDmconjs) + ", " + ;
                   EscaparSQL(THIS.this_cDmnascs) + ", " + ;
                   EscaparSQL(THIS.this_cMaes) + ", " + ;
                   EscaparSQL(THIS.this_cPais) + ", " + ;
                   EscaparSQL(THIS.this_cGraupares) + ", " + ;
                   EscaparSQL(THIS.this_cProfiss) + ", " + ;
                   EscaparSQL(THIS.this_cNomearts) + ", " + ;
                   "GETDATE(), GETDATE(), " + ;
                   FormatarDataSQL(THIS.this_dUltcomps) + ", " + ;
                   FormatarDataSQL(THIS.this_dDtvals) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nLimcres) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVultcomps) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nMacums) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nMfats) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nJuros) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nComis) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nPercdescli) + ","

      *-- Grupo 5: enderecos cobr/cos/trab, flags e configuracoes fiscais
      loc_cVals5 = " " + EscaparSQL(THIS.this_cEndcobs) + ", " + ;
                   EscaparSQL(THIS.this_cCepcobs) + ", " + ;
                   EscaparSQL(THIS.this_cCidcobs) + ", " + ;
                   EscaparSQL(THIS.this_cEstcobs) + ", " + ;
                   EscaparSQL(THIS.this_cBaicobs) + ", " + ;
                   EscaparSQL(THIS.this_cPaicobs) + ", " + ;
                   EscaparSQL(THIS.this_cEndcos) + ", " + ;
                   EscaparSQL(THIS.this_cCepcos) + ", " + ;
                   EscaparSQL(THIS.this_cCidcos) + ", " + ;
                   EscaparSQL(THIS.this_cEstcos) + ", " + ;
                   EscaparSQL(THIS.this_cBaicos) + ", " + ;
                   EscaparSQL(THIS.this_cNomecos) + ", " + ;
                   EscaparSQL(THIS.this_cComplcos) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNumcos) + ", " + ;
                   EscaparSQL(THIS.this_cEndtrabs) + ", " + ;
                   EscaparSQL(THIS.this_cCeptrabs) + ", " + ;
                   EscaparSQL(THIS.this_cCidtrabs) + ", " + ;
                   EscaparSQL(THIS.this_cEsttrabs) + ", " + ;
                   EscaparSQL(THIS.this_cBairtrabs) + ", " + ;
                   EscaparSQL(THIS.this_cPaitrabs) + ", " + ;
                   EscaparSQL(THIS.this_cNumtrabs) + ", " + ;
                   EscaparSQL(THIS.this_cCompltrabs) + ", " + ;
                   EscaparSQL(THIS.this_cEmptrabs) + ", " + ;
                   EscaparSQL(THIS.this_cCnpjtrabs) + ", " + ;
                   EscaparSQL(THIS.this_cTeltrabs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nColetors) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nVcolets) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nGerbals) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nPagfals) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nRecfals) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nIntconts) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nTphists) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAptos) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nMasters) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nConsigs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nPatrietqs) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nRestfors) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nConsignas) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nInvisivel) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nValemail) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAutdados) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAutemail) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAutsms) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAutwhats) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nAutteleg) + ", " + ;
                   EscaparSQL(THIS.this_cFpubls) + ", " + ;
                   EscaparSQL(THIS.this_cCfos) + ", " + ;
                   EscaparSQL(THIS.this_cCodtifs) + ", " + ;
                   EscaparSQL(THIS.this_cTpcps) + ", " + ;
                   EscaparSQL(THIS.this_cRgcs) + ", " + ;
                   EscaparSQL(THIS.this_cHists) + ", " + ;
                   EscaparSQL(THIS.this_cPracas) + ", " + ;
                   EscaparSQL(THIS.this_cObspagto) + ", " + ;
                   EscaparSQL(THIS.this_cPis) + ", " + ;
                   EscaparSQL(THIS.this_cMicroemps) + ", " + ;
                   EscaparSQL(THIS.this_cOptsimples) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nEan13ents) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nEan13cobs) + ", " + ;
                   EscaparSQL(THIS.this_mObs) + ", " + ;
                   EscaparSQL(THIS.this_mPerfils) + ", " + ;
                   EscaparSQL(THIS.this_mPastas) + ", " + ;
                   EscaparSQL(THIS.this_mFigjpgs) + ", " + ;
                   EscaparSQL(THIS.this_cCobs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisICs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisIPs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisIIs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisISs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisIRs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisINs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisPIs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisCSs) + ", " + ;
                   EscaparSQL(THIS.this_cCfgFisCOs)

      loc_cSQL = "INSERT INTO SigCdCli (" + ;
                 "IClis, Grupos, Rclis, Razaos, Cpfs, Rgs, Emissors, Senhas," + ;
                 " Codigos, Ctelems, Situas, Inativas, Vinculas, Tpcads, Tpclis," + ;
                 " Tabds, Tabd2s, Lprecos, Fpags, Prazoents, Codsegs, Emps," + ;
                 " Usualts, Usuars, Grupovens, Gruprods, Grupocents, Grupocobs," + ;
                 " Grupomats, Contacobs, Contamats, Contavens, Contaven2s," + ;
                 " Contacents, Conprods, Contato, Contats, Ccontabs," + ;
                 " Endes, Nums, Compls, Bairs, Cidas, Estas, Ceps, Paises," + ;
                 " Regiaos, Nmuncips, Inscmuns, Ddds, Tel1s, Tel2s, Tel3s," + ;
                 " Faxs, Ramals, Ddd2s, Emails," + ;
                 " Nascs, Sexos, Nacionals, Estcivils, Conjuges, Cpfcs," + ;
                 " Rgconjuges, Dtcasas, Dtncons, Dmcasas, Dmconjs, Dmnascs," + ;
                 " Maes, Pais, Grauparens, Profiss, Nomearts," + ;
                 " DtAlts, Dataincs, Ultcomps, Dtvals, Limcres, Vultcomps," + ;
                 " Macums, Mfats, Juros, Comis, Percdescli," + ;
                 " Endcobs, Cepcobs, Cidcobs, Estcobs, Baicobs, Paicobs," + ;
                 " Endcos, Cepcos, Cidcos, Estcos, Baicos, Nomecos, Complcos, Numcos," + ;
                 " Endtrabs, Ceptrabs, Cidtrabs, Esttrabs, Bairtrabs, Paitrabs," + ;
                 " Numtrabs, Compltrabs, Emptrabs, Cnpjtrabs, Teltrabs," + ;
                 " Coletors, Vcolets, Gerbals, Pagfals, Recfals, Intconts," + ;
                 " Tphists, Aptos, Masters, Consigs, Patrietqs, Restfors, Consignas," + ;
                 " Invisivel, Valemail, Autdados, Autemail, Autsms, Autwhats, Autteleg," + ;
                 " Fpubls, Cfos, Codtifs, Tpcps, Rgcs, Hists, Pracas, Obspagto, Pis," + ;
                 " Microemps, Optsimples, Ean13ents, Ean13cobs," + ;
                 " Obs, Perfils, Pastas, Figjpgs, Cobs," + ;
                 " CfgFisICs, CfgFisIPs, CfgFisIIs, CfgFisISs, CfgFisIRs," + ;
                 " CfgFisINs, CfgFisPIs, CfgFisCSs, CfgFisCOs) VALUES (" + ;
                 loc_cVals1 + loc_cVals2 + loc_cVals3 + loc_cVals4 + ;
                 loc_cVals5 + ")"

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nRet > 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lResultado = .T.
      ELSE
        MsgErro("Erro ao inserir conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.Inserir:" + CHR(13) + loException.Message + ;
              CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  PROTECTED FUNCTION Atualizar()
  *-- UPDATE SigCdCli WHERE IClis = this_cIClis
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_nRet
    LOCAL loc_cSet1, loc_cSet2, loc_cSet3, loc_cSet4, loc_cSet5
    loc_lResultado = .F.

    TRY
      *-- Grupo 1: identificacao e status
      loc_cSet1 = "Grupos = " + EscaparSQL(PADR(THIS.this_cGrupos,10)) + "," + ;
                  " Rclis = " + EscaparSQL(THIS.this_cRclis) + "," + ;
                  " Razaos = " + EscaparSQL(THIS.this_cRazaos) + "," + ;
                  " Cpfs = " + EscaparSQL(THIS.this_cCpfs) + "," + ;
                  " Rgs = " + EscaparSQL(THIS.this_cRgs) + "," + ;
                  " Emissors = " + EscaparSQL(THIS.this_cEmissors) + "," + ;
                  " Senhas = " + EscaparSQL(THIS.this_cSenhas) + "," + ;
                  " Codigos = " + EscaparSQL(THIS.this_cCodigos) + "," + ;
                  " Ctelems = " + EscaparSQL(THIS.this_cCtelems) + "," + ;
                  " Situas = " + EscaparSQL(THIS.this_cSituas) + "," + ;
                  " Inativas = " + FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                  " Vinculas = " + FormatarNumeroSQL(THIS.this_nVinculas) + "," + ;
                  " Tpcads = " + FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                  " Tpclis = " + FormatarNumeroSQL(THIS.this_nTpclis) + ","

      *-- Grupo 2: classificacao e grupos de contas
      loc_cSet2 = " Tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                  " Tabd2s = " + EscaparSQL(THIS.this_cTabd2s) + "," + ;
                  " Lprecos = " + EscaparSQL(THIS.this_cLprecos) + "," + ;
                  " Fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                  " Prazoents = " + FormatarNumeroSQL(THIS.this_nPrazoents) + "," + ;
                  " Codsegs = " + EscaparSQL(THIS.this_cCodsegs) + "," + ;
                  " Emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                  " Usualts = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                  " Usuars = " + EscaparSQL(THIS.this_cUsuars) + "," + ;
                  " Grupovens = " + EscaparSQL(THIS.this_cGrupovens) + "," + ;
                  " Gruprods = " + EscaparSQL(THIS.this_cGruprods) + "," + ;
                  " Grupocents = " + EscaparSQL(THIS.this_cGrupocents) + "," + ;
                  " Grupocobs = " + EscaparSQL(THIS.this_cGrupocobs) + "," + ;
                  " Grupomats = " + EscaparSQL(THIS.this_cGrupomats) + "," + ;
                  " Contacobs = " + EscaparSQL(THIS.this_cContacobs) + "," + ;
                  " Contamats = " + EscaparSQL(THIS.this_cContamats) + "," + ;
                  " Contavens = " + EscaparSQL(THIS.this_cContavens) + "," + ;
                  " Contaven2s = " + EscaparSQL(THIS.this_cContaven2s) + "," + ;
                  " Contacents = " + EscaparSQL(THIS.this_cContacents) + "," + ;
                  " Conprods = " + EscaparSQL(THIS.this_cConprods) + "," + ;
                  " Contato = " + EscaparSQL(THIS.this_cContato) + "," + ;
                  " Contats = " + EscaparSQL(THIS.this_cContats) + "," + ;
                  " Ccontabs = " + EscaparSQL(THIS.this_cCcontabs) + ","

      *-- Grupo 3: enderecos e comunicacao
      loc_cSet3 = " Endes = " + EscaparSQL(THIS.this_cEndes) + "," + ;
                  " Nums = " + EscaparSQL(THIS.this_cNums) + "," + ;
                  " Compls = " + EscaparSQL(THIS.this_cCompls) + "," + ;
                  " Bairs = " + EscaparSQL(THIS.this_cBairs) + "," + ;
                  " Cidas = " + EscaparSQL(THIS.this_cCidas) + "," + ;
                  " Estas = " + EscaparSQL(THIS.this_cEstas) + "," + ;
                  " Ceps = " + EscaparSQL(THIS.this_cCeps) + "," + ;
                  " Paises = " + EscaparSQL(THIS.this_cPaises) + "," + ;
                  " Regiaos = " + EscaparSQL(THIS.this_cRegiaos) + "," + ;
                  " Nmuncips = " + FormatarNumeroSQL(THIS.this_nNmuncips) + "," + ;
                  " Inscmuns = " + EscaparSQL(THIS.this_cInscmuns) + "," + ;
                  " Ddds = " + EscaparSQL(THIS.this_cDdds) + "," + ;
                  " Tel1s = " + EscaparSQL(THIS.this_cTel1s) + "," + ;
                  " Tel2s = " + EscaparSQL(THIS.this_cTel2s) + "," + ;
                  " Tel3s = " + EscaparSQL(THIS.this_cTel3s) + "," + ;
                  " Faxs = " + EscaparSQL(THIS.this_cFaxs) + "," + ;
                  " Ramals = " + EscaparSQL(THIS.this_cRamals) + "," + ;
                  " Ddd2s = " + EscaparSQL(THIS.this_cDdd2s) + "," + ;
                  " Emails = " + EscaparSQL(THIS.this_cEmails) + ","

      *-- Grupo 4: dados pessoais, financeiros e datas
      loc_cSet4 = " Nascs = " + FormatarDataSQL(THIS.this_dNascs) + "," + ;
                  " Sexos = " + EscaparSQL(THIS.this_cSexos) + "," + ;
                  " Nacionals = " + EscaparSQL(THIS.this_cNacionals) + "," + ;
                  " Estcivils = " + EscaparSQL(THIS.this_cEstcivils) + "," + ;
                  " Conjuges = " + EscaparSQL(THIS.this_cConjuges) + "," + ;
                  " Cpfcs = " + EscaparSQL(THIS.this_cCpfcs) + "," + ;
                  " Rgconjuges = " + EscaparSQL(THIS.this_cRgconjuges) + "," + ;
                  " Dtcasas = " + FormatarDataSQL(THIS.this_dDtcasas) + "," + ;
                  " Dtncons = " + FormatarDataSQL(THIS.this_dDtncons) + "," + ;
                  " Dmcasas = " + EscaparSQL(THIS.this_cDmcasas) + "," + ;
                  " Dmconjs = " + EscaparSQL(THIS.this_cDmconjs) + "," + ;
                  " Dmnascs = " + EscaparSQL(THIS.this_cDmnascs) + "," + ;
                  " Maes = " + EscaparSQL(THIS.this_cMaes) + "," + ;
                  " Pais = " + EscaparSQL(THIS.this_cPais) + "," + ;
                  " Grauparens = " + EscaparSQL(THIS.this_cGraupares) + "," + ;
                  " Profiss = " + EscaparSQL(THIS.this_cProfiss) + "," + ;
                  " Nomearts = " + EscaparSQL(THIS.this_cNomearts) + "," + ;
                  " DtAlts = GETDATE()," + ;
                  " Ultcomps = " + FormatarDataSQL(THIS.this_dUltcomps) + "," + ;
                  " Dtvals = " + FormatarDataSQL(THIS.this_dDtvals) + "," + ;
                  " Limcres = " + FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                  " Vultcomps = " + FormatarNumeroSQL(THIS.this_nVultcomps) + "," + ;
                  " Macums = " + FormatarNumeroSQL(THIS.this_nMacums) + "," + ;
                  " Mfats = " + FormatarNumeroSQL(THIS.this_nMfats) + "," + ;
                  " Juros = " + FormatarNumeroSQL(THIS.this_nJuros) + "," + ;
                  " Comis = " + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                  " Percdescli = " + FormatarNumeroSQL(THIS.this_nPercdescli) + ","

      *-- Grupo 5: end.cobr/cos/trab, flags, configs fiscais e memos
      loc_cSet5 = " Endcobs = " + EscaparSQL(THIS.this_cEndcobs) + "," + ;
                  " Cepcobs = " + EscaparSQL(THIS.this_cCepcobs) + "," + ;
                  " Cidcobs = " + EscaparSQL(THIS.this_cCidcobs) + "," + ;
                  " Estcobs = " + EscaparSQL(THIS.this_cEstcobs) + "," + ;
                  " Baicobs = " + EscaparSQL(THIS.this_cBaicobs) + "," + ;
                  " Paicobs = " + EscaparSQL(THIS.this_cPaicobs) + "," + ;
                  " Endcos = " + EscaparSQL(THIS.this_cEndcos) + "," + ;
                  " Cepcos = " + EscaparSQL(THIS.this_cCepcos) + "," + ;
                  " Cidcos = " + EscaparSQL(THIS.this_cCidcos) + "," + ;
                  " Estcos = " + EscaparSQL(THIS.this_cEstcos) + "," + ;
                  " Baicos = " + EscaparSQL(THIS.this_cBaicos) + "," + ;
                  " Nomecos = " + EscaparSQL(THIS.this_cNomecos) + "," + ;
                  " Complcos = " + EscaparSQL(THIS.this_cComplcos) + "," + ;
                  " Numcos = " + FormatarNumeroSQL(THIS.this_nNumcos) + "," + ;
                  " Endtrabs = " + EscaparSQL(THIS.this_cEndtrabs) + "," + ;
                  " Ceptrabs = " + EscaparSQL(THIS.this_cCeptrabs) + "," + ;
                  " Cidtrabs = " + EscaparSQL(THIS.this_cCidtrabs) + "," + ;
                  " Esttrabs = " + EscaparSQL(THIS.this_cEsttrabs) + "," + ;
                  " Bairtrabs = " + EscaparSQL(THIS.this_cBairtrabs) + "," + ;
                  " Paitrabs = " + EscaparSQL(THIS.this_cPaitrabs) + "," + ;
                  " Numtrabs = " + EscaparSQL(THIS.this_cNumtrabs) + "," + ;
                  " Compltrabs = " + EscaparSQL(THIS.this_cCompltrabs) + "," + ;
                  " Emptrabs = " + EscaparSQL(THIS.this_cEmptrabs) + "," + ;
                  " Cnpjtrabs = " + EscaparSQL(THIS.this_cCnpjtrabs) + "," + ;
                  " Teltrabs = " + EscaparSQL(THIS.this_cTeltrabs) + "," + ;
                  " Coletors = " + FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                  " Vcolets = " + FormatarNumeroSQL(THIS.this_nVcolets) + "," + ;
                  " Gerbals = " + FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                  " Pagfals = " + FormatarNumeroSQL(THIS.this_nPagfals) + "," + ;
                  " Recfals = " + FormatarNumeroSQL(THIS.this_nRecfals) + "," + ;
                  " Intconts = " + FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                  " Tphists = " + FormatarNumeroSQL(THIS.this_nTphists) + "," + ;
                  " Aptos = " + FormatarNumeroSQL(THIS.this_nAptos) + "," + ;
                  " Masters = " + FormatarNumeroSQL(THIS.this_nMasters) + "," + ;
                  " Consigs = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                  " Patrietqs = " + FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                  " Restfors = " + FormatarNumeroSQL(THIS.this_nRestfors) + "," + ;
                  " Consignas = " + FormatarNumeroSQL(THIS.this_nConsignas) + "," + ;
                  " Invisivel = " + FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                  " Valemail = " + FormatarNumeroSQL(THIS.this_nValemail) + "," + ;
                  " Autdados = " + FormatarNumeroSQL(THIS.this_nAutdados) + "," + ;
                  " Autemail = " + FormatarNumeroSQL(THIS.this_nAutemail) + "," + ;
                  " Autsms = " + FormatarNumeroSQL(THIS.this_nAutsms) + "," + ;
                  " Autwhats = " + FormatarNumeroSQL(THIS.this_nAutwhats) + "," + ;
                  " Autteleg = " + FormatarNumeroSQL(THIS.this_nAutteleg) + "," + ;
                  " Fpubls = " + EscaparSQL(THIS.this_cFpubls) + "," + ;
                  " Cfos = " + EscaparSQL(THIS.this_cCfos) + "," + ;
                  " Codtifs = " + EscaparSQL(THIS.this_cCodtifs) + "," + ;
                  " Tpcps = " + EscaparSQL(THIS.this_cTpcps) + "," + ;
                  " Rgcs = " + EscaparSQL(THIS.this_cRgcs) + "," + ;
                  " Hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                  " Pracas = " + EscaparSQL(THIS.this_cPracas) + "," + ;
                  " Obspagto = " + EscaparSQL(THIS.this_cObspagto) + "," + ;
                  " Pis = " + EscaparSQL(THIS.this_cPis) + "," + ;
                  " Microemps = " + EscaparSQL(THIS.this_cMicroemps) + "," + ;
                  " Optsimples = " + EscaparSQL(THIS.this_cOptsimples) + "," + ;
                  " Ean13ents = " + FormatarNumeroSQL(THIS.this_nEan13ents) + "," + ;
                  " Ean13cobs = " + FormatarNumeroSQL(THIS.this_nEan13cobs) + "," + ;
                  " Obs = " + EscaparSQL(THIS.this_mObs) + "," + ;
                  " Perfils = " + EscaparSQL(THIS.this_mPerfils) + "," + ;
                  " Pastas = " + EscaparSQL(THIS.this_mPastas) + "," + ;
                  " Figjpgs = " + EscaparSQL(THIS.this_mFigjpgs) + "," + ;
                  " Cobs = " + EscaparSQL(THIS.this_cCobs) + "," + ;
                  " CfgFisICs = " + EscaparSQL(THIS.this_cCfgFisICs) + "," + ;
                  " CfgFisIPs = " + EscaparSQL(THIS.this_cCfgFisIPs) + "," + ;
                  " CfgFisIIs = " + EscaparSQL(THIS.this_cCfgFisIIs) + "," + ;
                  " CfgFisISs = " + EscaparSQL(THIS.this_cCfgFisISs) + "," + ;
                  " CfgFisIRs = " + EscaparSQL(THIS.this_cCfgFisIRs) + "," + ;
                  " CfgFisINs = " + EscaparSQL(THIS.this_cCfgFisINs) + "," + ;
                  " CfgFisPIs = " + EscaparSQL(THIS.this_cCfgFisPIs) + "," + ;
                  " CfgFisCSs = " + EscaparSQL(THIS.this_cCfgFisCSs) + "," + ;
                  " CfgFisCOs = " + EscaparSQL(THIS.this_cCfgFisCOs)

      loc_cSQL = "UPDATE SigCdCli SET " + loc_cSet1 + loc_cSet2 + loc_cSet3 + ;
                 loc_cSet4 + loc_cSet5 + ;
                 " WHERE IClis = " + EscaparSQL(PADR(THIS.this_cIClis, 10))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nRet > 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lResultado = .T.
      ELSE
        MsgErro("Erro ao atualizar conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.Atualizar:" + CHR(13) + loException.Message + ;
              CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *-------------------------------------------------------------
  PROTECTED FUNCTION ExecutarExclusao()
  *-- DELETE SigCdCli com cascata em SigCdCeb e SigCdClh
  *-------------------------------------------------------------
    LOCAL loc_lResultado, loc_cSQL, loc_nRet
    LOCAL loc_cGrC, loc_cGru, loc_cICli
    loc_lResultado = .F.

    TRY
      loc_cICli = PADR(THIS.this_cIClis, 10)
      loc_cGru  = PADR(THIS.this_cGrupos, 10)
      loc_cGrC  = loc_cGru + loc_cICli

      *-- Cascata: SigCdCeb (Grucontas = Grupos+IClis)
      loc_cSQL = "DELETE FROM SigCdCeb WHERE Grucontas = " + EscaparSQL(loc_cGrC)
      SQLEXEC(gnConnHandle, loc_cSQL)

      *-- Cascata: SigCdClh (GruContas = Grupos+IClis)
      loc_cSQL = "DELETE FROM SigCdClh WHERE GruContas = " + EscaparSQL(loc_cGrC)
      SQLEXEC(gnConnHandle, loc_cSQL)

      *-- Registro principal
      loc_cSQL = "DELETE FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cICli)
      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet > 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lResultado = .T.
      ELSE
        MsgErro("Erro ao excluir conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loException
      MsgErro("Erro em CTABO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

ENDDEFINE
