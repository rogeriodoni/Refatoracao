*------------------------------------------------------------------------------
* SIGPRIBLBO.prg - Business Object para Impressao de Boleto Bancario
* Herda de: BusinessBase
* Tabela principal: SigCnFBl (configuracao de boleto)
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRIBLBO AS BusinessBase

    *-- Identificacao da tabela e chave
    this_cTabela      = "SigCnFBl"
    this_cCampoChave  = "FPags"

    *-- Chave do movimento recebida do form pai (pcchave1)
    this_cChave1      = ""

    *-- Campos da configuracao de boleto (SigCnFBl)
    this_cFPags       = ""
    this_cIdChaves    = ""
    this_cLocals      = ""
    this_cTxtCds      = ""
    this_cNomeImps    = ""
    this_cFontePdrs   = ""
    this_nTamFontes   = 0
    this_cTamFolha    = ""

    *-- Posicoes de impressao: Local de Pagamento
    this_nLnLocals    = 0
    this_nClLocals    = 0

    *-- Posicoes de impressao: Data de Vencimento
    this_nLnDtVencs   = 0
    this_nClDtVencs   = 0

    *-- Posicoes de impressao: Data do Documento
    this_nLnDtDocs    = 0
    this_nClDtDocs    = 0

    *-- Posicoes de impressao: Numero do Documento
    this_nLnNrDocs    = 0
    this_nClNrDocs    = 0

    *-- Posicoes de impressao: Valor do Documento
    this_nLnVlDocs    = 0
    this_nClVlDocs    = 0

    *-- Posicoes de impressao: Razao Social do Cliente
    this_nLnRazClis   = 0
    this_nClRazClis   = 0

    *-- Posicoes de impressao: CPF/CNPJ do Cliente
    this_nLnCgcClis   = 0
    this_nClCgcClis   = 0

    *-- Posicoes de impressao: Endereco de Cobranca
    this_nLnEndCobs   = 0
    this_nClEndCobs   = 0

    *-- Posicoes de impressao: Bairro de Cobranca
    this_nLnBaiCobs   = 0
    this_nClBaiCobs   = 0

    *-- Posicoes de impressao: Cidade de Cobranca
    this_nLnCidCobs   = 0
    this_nClCidCobs   = 0

    *-- Posicoes de impressao: Estado de Cobranca
    this_nLnEstCobs   = 0
    this_nClEstCobs   = 0

    *-- Posicoes de impressao: CEP de Cobranca
    this_nLnCepCobs   = 0
    this_nClCepCobs   = 0

    *-- Posicoes de impressao: Texto do Cedente
    this_nLnTxtCds    = 0
    this_nClTxtCds    = 0

    *-- Fatores de escala para impressao matricial
    this_nNffatorln   = 0
    this_nNffatorcl   = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCnFBl"
        THIS.this_cCampoChave = "FPags"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPags)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarConfiguracao - Carrega configuracao de boleto para FPags informado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfiguracao(par_cFPags)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Config")
                USE IN cursor_4c_Config
            ENDIF
            loc_cSQL = "SELECT FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       " FROM SigCnFBl" + ;
                       " WHERE FPags = " + EscaparSQL(PADR(par_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Config")
            IF loc_nRet > 0
                IF RECCOUNT("cursor_4c_Config") > 0
                    SELECT cursor_4c_Config
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Config")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_*
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves,  "C")
                THIS.this_cLocals    = TratarNulo(cLocals,    "C")
                THIS.this_cTxtCds    = TratarNulo(cTxtCds,    "C")
                THIS.this_cNomeImps  = TratarNulo(cNomeImps,  "C")
                THIS.this_cFontePdrs = TratarNulo(cFontePdrs, "C")
                THIS.this_nTamFontes = TratarNulo(nTamFontes, "N")
                THIS.this_cTamFolha  = TratarNulo(cTamFolha,  "C")
                THIS.this_nLnLocals  = TratarNulo(nLnLocals,  "N")
                THIS.this_nClLocals  = TratarNulo(nClLocals,  "N")
                THIS.this_nLnDtVencs = TratarNulo(nLnDtVencs, "N")
                THIS.this_nClDtVencs = TratarNulo(nClDtVencs, "N")
                THIS.this_nLnDtDocs  = TratarNulo(nLnDtDocs,  "N")
                THIS.this_nClDtDocs  = TratarNulo(nClDtDocs,  "N")
                THIS.this_nLnNrDocs  = TratarNulo(nLnNrDocs,  "N")
                THIS.this_nClNrDocs  = TratarNulo(nClNrDocs,  "N")
                THIS.this_nLnVlDocs  = TratarNulo(nLnVlDocs,  "N")
                THIS.this_nClVlDocs  = TratarNulo(nClVlDocs,  "N")
                THIS.this_nLnRazClis = TratarNulo(nLnRazClis, "N")
                THIS.this_nClRazClis = TratarNulo(nClRazClis, "N")
                THIS.this_nLnCgcClis = TratarNulo(nLnCgcClis, "N")
                THIS.this_nClCgcClis = TratarNulo(nClCgcClis, "N")
                THIS.this_nLnEndCobs = TratarNulo(nLnEndCobs, "N")
                THIS.this_nClEndCobs = TratarNulo(nClEndCobs, "N")
                THIS.this_nLnBaiCobs = TratarNulo(nLnBaiCobs, "N")
                THIS.this_nClBaiCobs = TratarNulo(nClBaiCobs, "N")
                THIS.this_nLnCidCobs = TratarNulo(nLnCidCobs, "N")
                THIS.this_nClCidCobs = TratarNulo(nClCidCobs, "N")
                THIS.this_nLnEstCobs = TratarNulo(nLnEstCobs, "N")
                THIS.this_nClEstCobs = TratarNulo(nClEstCobs, "N")
                THIS.this_nLnCepCobs = TratarNulo(nLnCepCobs, "N")
                THIS.this_nClCepCobs = TratarNulo(nClCepCobs, "N")
                THIS.this_nLnTxtCds  = TratarNulo(nLnTxtCds,  "N")
                THIS.this_nClTxtCds  = TratarNulo(nClTxtCds,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cFPags))
            THIS.this_cMensagemErro = "Condi" + CHR(231) + CHR(227) + "o de Pagamento obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova configuracao de boleto em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarDados()
                RETURN
            ENDIF
            loc_cSQL = "INSERT INTO SigCnFBl (" + ;
                       " FPags, cIdChaves, cLocals, cTxtCds, cNomeImps," + ;
                       " cFontePdrs, nTamFontes, cTamFolha," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       ") VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12)) + ", " + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cTxtCds) + ", " + ;
                       EscaparSQL(THIS.this_cNomeImps) + ", " + ;
                       EscaparSQL(THIS.this_cFontePdrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamFontes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cTamFolha) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClLocals, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtVencs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClDtDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClNrDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClVlDocs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClRazClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCgcClis, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEndCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClBaiCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCidCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClEstCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClCepCobs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLnTxtCds, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nClTxtCds, 2) + ;
                       ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Salva campos editaveis (cLocals, cTxtCds) em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.this_cTxtCds) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui configuracao de boleto de SigCnFBl
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cFPags))
                MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento n" + CHR(227) + "o selecionada.", "Aviso")
                RETURN
            ENDIF
            loc_cSQL = "DELETE FROM SigCnFBl WHERE FPags = " + ;
                       EscaparSQL(PADR(THIS.this_cFPags, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
