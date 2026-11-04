*==============================================================================
* OpsBO.prg - Business Object para Cadastro de Opera??es
* Tabela: SigCdOpe | PK: dopes
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OpsBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpe"
    this_cCampoChave  = "dopes"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpe (campos do formul?rio)
    *--------------------------------------------------------------------------
    this_cDopes     = ""    && dopes    char(20) - C�digo / chave prim�ria
    this_nNDopes    = 0     && ndopes   numeric(4,0) - N�mero da opera��o
    this_cTitOpes   = ""    && titopes  char(30) - T�tulo / descri��o
    this_cMenus     = ""    && menus    char(10) - Menu
    this_cSubMenus  = ""    && submenus char(15) - Submenu
    this_nOrdes     = 0     && ordes    numeric(4,0) - Ordem
    this_cCmoes     = ""    && cmoes    char(3)  - Moeda
    this_nCopers    = 0     && copers   numeric(1,0) - Tipo movimento (0=Entrada,1=Sa�da)
    this_cObsOpes   = ""    && obsopes  text     - Observa��o
    this_nTipoOps   = 0     && tipoops  numeric(2,0) - Tipo de opera��o
    this_cAbrevs    = ""    && abrevs   char(3)  - Abreviatura / reduzida
    this_cNivels    = ""    && nivels   char(20) - Sub-n�vel
    this_nNFiscals  = 0     && nfiscals numeric(1,0) - Fiscal

    *--------------------------------------------------------------------------
    * Propriedades - SigOpCdc (cursor secund?rio - inativa??o)
    *--------------------------------------------------------------------------
    this_nOpeInatvs = 0     && opeinatvs numeric(1,0) - Opera��o inativa (0=Ativa,1=Inativa)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave prim?ria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes    = TratarNulo(Dopes,    "C")
                THIS.this_nNDopes   = TratarNulo(NDopes,   "N")
                THIS.this_cTitOpes  = TratarNulo(TitOpes,  "C")
                THIS.this_cMenus    = TratarNulo(Menus,    "C")
                THIS.this_cSubMenus = TratarNulo(SubMenus, "C")
                THIS.this_nOrdes    = TratarNulo(Ordes,    "N")
                THIS.this_cCmoes    = TratarNulo(CMoes,    "C")
                THIS.this_nCopers   = TratarNulo(Copers,   "N")
                THIS.this_cObsOpes  = TratarNulo(ObsOpes,  "C")
                THIS.this_nTipoOps  = TratarNulo(TipoOps,  "N")
                THIS.this_cAbrevs   = TratarNulo(Abrevs,   "C")
                THIS.this_cNivels   = TratarNulo(Nivels,   "C")
                THIS.this_nNFiscals = TratarNulo(NFiscals, "N")
                IF TYPE("OpeInatvs") != "U"
                    THIS.this_nOpeInatvs = TratarNulo(OpeInatvs, "N")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message, "OpsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cDopes))
            MsgAviso("C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cDopes)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cTitOpes))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se dopes ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpe" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOps")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOps")
                SELECT cursor_4c_ChkOps
                loc_lExiste = (cursor_4c_ChkOps.qtd > 0)
                USE IN cursor_4c_ChkOps
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OpsBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * AtualizarSigOpCdc - Insere ou atualiza status de inativacao em SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE AtualizarSigOpCdc()
        LOCAL loc_cSQL, loc_nResultado, loc_nExiste
        loc_nExiste = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCdc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCdc")
                SELECT cursor_4c_ChkCdc
                loc_nExiste = NVL(cursor_4c_ChkCdc.qtd, 0)
                USE IN cursor_4c_ChkCdc
            ENDIF

            IF loc_nExiste > 0
                loc_cSQL = "UPDATE SigOpCdc SET OpeInatvs = " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ;
                    " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            ELSE
                loc_cSQL = "INSERT INTO SigOpCdc (Dopes, OpeInatvs)" + ;
                    " VALUES (" + ;
                    EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ")"
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loException
            MostrarErro("Erro ao atualizar SigOpCdc:" + CHR(13) + loException.Message, "OpsBO.AtualizarSigOpCdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
                *-- Erro307 / regra #22: SigCdOpe tem 248 colunas NOT NULL e
                *-- NENHUMA com DEFAULT (conferido no INFORMATION_SCHEMA do banco,
                *-- nao no docs/schema.sql, que nao registra default). O INSERT
                *-- listava 13 e o SQL Server recusava a gravacao inteira:
                *--   "Nao e possivel inserir o valor NULL na coluna cfgfinancs".
                *-- O legado grava com TABLEUPDATE sobre cursor de SELECT *, entao
                *-- TODA coluna ia junto com o branco/zero do cursor - e o que este
                *-- INSERT reproduz. Bloco GERADO por automation\GerarInsertOpsBO.ps1.
                *-- A montagem e feita em INSTRUCOES SEPARADAS, nao numa linha
                *-- logica gigante com "+ ;": com ~320 continuacoes o compilador
                *-- do VFP9 PENDURA (medido - o COMPILE nunca retorna).
                loc_cSQL = "INSERT INTO SigCdOpe ("
                loc_cSQL = loc_cSQL + "pedclis, zerqtds, valinotas, dopeetrfs, "
                loc_cSQL = loc_cSQL + "valitems, exibsits, chkqtds, dtcontab, "
                loc_cSQL = loc_cSQL + "abrevs, altdescs, antecs, aptpfats, "
                loc_cSQL = loc_cSQL + "arreds, baixasns, bxautos, bxparcials, "
                loc_cSQL = loc_cSQL + "cadclis, caixas, calcfecs, carnes, "
                loc_cSQL = loc_cSQL + "ccentrals, ccomis, cdesps, chdtentrs, "
                loc_cSQL = loc_cSQL + "cheqs, cmoes, cnopes, codbars, "
                loc_cSQL = loc_cSQL + "comcargs, condests, condsubs, confes, "
                loc_cSQL = loc_cSQL + "conorigs, conosubs, consclis, consers, "
                loc_cSQL = loc_cSQL + "consgs, contas, copers, crepls, "
                loc_cSQL = loc_cSQL + "ctipos, cupfis, deacrs, desmembs, "
                loc_cSQL = loc_cSQL + "destinos, dfpags, digdoc, digitens, "
                loc_cSQL = loc_cSQL + "digobs, docus, dopes, dtentrs, "
                loc_cSQL = loc_cSQL + "edcotas, edtpfats, efators, emppads, "
                loc_cSQL = loc_cSQL + "epesos, eprecos, estdests, estoqs, "
                loc_cSQL = loc_cSQL + "estorigs, expends, fatauts, fixcdests, "
                loc_cSQL = loc_cSQL + "fixcnopes, fixcorigs, fixgdests, fixgorigs, "
                loc_cSQL = loc_cSQL + "fixgropes, fixgvends, globalizas, grudests, "
                loc_cSQL = loc_cSQL + "gruorigs, grupos, grvends, imagems, "
                loc_cSQL = loc_cSQL + "itautos, itemalfas, itemzeros, limcres, "
                loc_cSQL = loc_cSQL + "limpauts, lprecos, menus, mestoqs, "
                loc_cSQL = loc_cSQL + "ndebitos, ndopes, nfiscals, nivels, "
                loc_cSQL = loc_cSQL + "nopcrs, numeras, opcrs, opers, "
                loc_cSQL = loc_cSQL + "ordes, origems, parautos, parcontas, "
                loc_cSQL = loc_cSQL + "parcs, parrecals, pesoauts, pesods, "
                loc_cSQL = loc_cSQL + "pesos, pesovts, porcs, precoauts, "
                loc_cSQL = loc_cSQL + "precods, precops, precovts, produc, "
                loc_cSQL = loc_cSQL + "qtdites, qtdpesos, qtdprecos, qtdrelevs, "
                loc_cSQL = loc_cSQL + "relfechas, reservas, results, situas, "
                loc_cSQL = loc_cSQL + "subns, tabdescs, tabdps, tipoops, "
                loc_cSQL = loc_cSQL + "transons, transps, transs, unitpesos, "
                loc_cSQL = loc_cSQL + "valests, valpends, valpres, vars, "
                loc_cSQL = loc_cSQL + "vendas, vendes, dopcs, especies, "
                loc_cSQL = loc_cSQL + "semetiqs, series, casas, alttrans, "
                loc_cSQL = loc_cSQL + "dadosnotas, hist2s, hists, obsdests, "
                loc_cSQL = loc_cSQL + "obsorigs, servicos, subnobrigs, tphist2s, "
                loc_cSQL = loc_cSQL + "tphists, blqdatas, senhads, senhaos, "
                loc_cSQL = loc_cSQL + "democreds, digcpfs, congvends, submenus, "
                loc_cSQL = loc_cSQL + "chkqtdss, valitnegs, obspads, grucados, "
                loc_cSQL = loc_cSQL + "grucadds, grucadvs, cdopes, calcmos, "
                loc_cSQL = loc_cSQL + "cfos, chkdval, relfechgrs, titopes, "
                loc_cSQL = loc_cSQL + "trnfis, dopestrfs, tabdobrigs, dtemis, "
                loc_cSQL = loc_cSQL + "conprecs, operchqes, operchqss, trocoauts, "
                loc_cSQL = loc_cSQL + "gremiss, conemiss, parczeros, bxvlopcrs, "
                loc_cSQL = loc_cSQL + "operfisics, codpropads, cadcliauts, fpagopcrs, "
                loc_cSQL = loc_cSQL + "obsitems, varitems, itsituas, habsubits, "
                loc_cSQL = loc_cSQL + "oppends, cadprods, subnautos, senhars, "
                loc_cSQL = loc_cSQL + "totcompos, chkedesc, ncpesos, lprecopads, "
                loc_cSQL = loc_cSQL + "editdocs, cempsubns, comisdivs, carcbars, "
                loc_cSQL = loc_cSQL + "ctrllotes, mascvens, orilotes, reffs, "
                loc_cSQL = loc_cSQL + "ccustos, dcpns, dtbars, aciosens, "
                loc_cSQL = loc_cSQL + "chkfunds, cliods, edcomis, impclis, "
                loc_cSQL = loc_cSQL + "opernf, infoipis, agrupas, codconpads, "
                loc_cSQL = loc_cSQL + "digenves, digrecs, empbxs, emplancs, "
                loc_cSQL = loc_cSQL + "empsubns, fechmals, habservs, marcasubns, "
                loc_cSQL = loc_cSQL + "opepads, programas, tiponfs, chkacpro, "
                loc_cSQL = loc_cSQL + "edunis, anprodzs, obsfins, obsinis, "
                loc_cSQL = loc_cSQL + "autenticas, autoins, bxpagos, carvends, "
                loc_cSQL = loc_cSQL + "cbxsubns, checpagos, chkagends, dopcreds, "
                loc_cSQL = loc_cSQL + "fixgven2s, inibcchqs, inibmens, inibmlcs, "
                loc_cSQL = loc_cSQL + "ncarsubs, obrigvd2s, obrigvds, tplprecs, "
                loc_cSQL = loc_cSQL + "vcompensas, fpubl, nfcompls, cfgfinancs, "
                loc_cSQL = loc_cSQL + "ObsOpes "
                loc_cSQL = loc_cSQL + ") VALUES ("
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cAbrevs) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cCmoes) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCopers, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cMenus) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNDopes, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cNivels) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nOrdes, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTipoOps, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cSubMenus) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cTitOpes) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + "0" + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ","
                loc_cSQL = loc_cSQL + EscaparSQL("") + ","
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObsOpes)
                loc_cSQL = loc_cSQL + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpe SET" + ;
                " NDopes   = " + FormatarNumeroSQL(THIS.this_nNDopes, 0) + "," + ;
                " TitOpes  = " + EscaparSQL(THIS.this_cTitOpes) + "," + ;
                " Menus    = " + EscaparSQL(THIS.this_cMenus) + "," + ;
                " SubMenus = " + EscaparSQL(THIS.this_cSubMenus) + "," + ;
                " Ordes    = " + FormatarNumeroSQL(THIS.this_nOrdes, 0) + "," + ;
                " CMoes    = " + EscaparSQL(THIS.this_cCmoes) + "," + ;
                " Copers   = " + FormatarNumeroSQL(THIS.this_nCopers, 0) + "," + ;
                " ObsOpes  = " + EscaparSQL(THIS.this_cObsOpes) + "," + ;
                " TipoOps  = " + FormatarNumeroSQL(THIS.this_nTipoOps, 0) + "," + ;
                " Abrevs   = " + EscaparSQL(THIS.this_cAbrevs) + "," + ;
                " Nivels   = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                " NFiscals = " + FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SigCdOpe e tabelas relacionadas
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar uso em SigOpFin (lancamentos financeiros)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFin" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFin")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFin")
                SELECT cursor_4c_ChkFin
                loc_nUso = NVL(cursor_4c_ChkFin.qtd, 0)
                USE IN cursor_4c_ChkFin
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                *-- Excluir registros filhos antes do principal
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdd WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdc WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))

                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista operacoes com filtro de status
    * par_cFiltro: "" = todos | "Ativo" = ativos | "Inativo" = inativos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Dopes C(20), NDopes N(4,0), ;
                        Abrevs C(20), CMoes C(3), Nivels C(20), Menus C(10), ;
                        SubMenus C(15), Ordes N(4,0), TipoOps N(2,0), ;
                        DopMenus C(30), Inativas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C"
                    DO CASE
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "ATIVO"
                            loc_cWhere = " WHERE ISNULL(b.OpeInatvs, 0) = 0"
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "INATIVO"
                            loc_cWhere = " WHERE ISNULL(b.OpeInatvs, 0) = 1"
                    ENDCASE
                ENDIF

                loc_cSQL = "SELECT a.Dopes, a.NDopes, a.Abrevs, a.CMoes," + ;
                    " a.Nivels, a.Menus, a.SubMenus, a.Ordes, a.TipoOps," + ;
                    " LEFT(RIGHT(d.ConfigGers, 89), 30) AS DopMenus," + ;
                    " ISNULL(b.OpeInatvs, 0) AS Inativas" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                    " LEFT JOIN SigOpCdd d ON d.Dopes = a.Dopes" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Dopes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (Dopes)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.NDopes, a.TitOpes, a.Menus, a.SubMenus," + ;
                " a.Ordes, a.CMoes, a.Copers, a.ObsOpes, a.TipoOps," + ;
                " a.Abrevs, a.Nivels, a.NFiscals," + ;
                " ISNULL(b.OpeInatvs, 0) AS OpeInatvs" + ;
                " FROM SigCdOpe a" + ;
                " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                " WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpsBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
