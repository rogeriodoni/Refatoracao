*==============================================================================
* sigpriteBO.prg - Business Object para SIGPRITE (Itens de Ordem de Producao)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta de itens de OP - somente leitura)
*==============================================================================

DEFINE CLASS sigpriteBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de contexto da OP
    *--------------------------------------------------------------------------
    this_cEmp        = ""    && Empresa (char 3)
    this_cDop        = ""    && Operacao/Documento (char 20)
    this_nNum        = 0     && Numero da OP (numeric 6,0)
    this_cEmpDopNum  = ""    && Chave concatenada: PADR(cEmp,3)+PADR(cDop,20)+STR(nNum,6) = char 29
    this_lChecaDisps = .F.   && Flag: verificar disponibilidade do produto

    *--------------------------------------------------------------------------
    * Item corrente (linha selecionada em grd_4c_Itens)
    *--------------------------------------------------------------------------
    this_nCItens  = 0     && Sequencial do item (numeric 10,0)
    this_cCPros   = ""    && Codigo produto (char 14)
    this_cDPros   = ""    && Descricao produto (char 65)
    this_cObs     = ""    && Observacao (text)
    this_cCUnis   = ""    && Unidade (char 3)
    this_nVolumes = 0     && Volume (numeric 3,0)
    this_cOpers   = ""    && Tipo operacao (char 1)
    this_nQtdOs   = 0     && Quantidade original/SigMvItn.Qtds (numeric 9,3)
    this_nQtdBs   = 0     && Quantidade baixada/SigMvItn.QtBaixas (numeric 9,3)
    this_nQtdSs   = 0     && Quantidade saldo calculada (Qtds - QtBaixas)
    this_nUnits   = 0     && Preco unitario/SigMvItn.Units (numeric 15,6)
    this_cCMoes   = ""    && Codigo moeda/SigMvItn.Moedas (char 3)
    this_nTotas   = 0     && Valor total/SigMvItn.Totas (numeric 11,2)
    this_nDisps   = 0     && Disponibilidade do produto (numeric 9,3)

    *--------------------------------------------------------------------------
    * Controle interno
    *--------------------------------------------------------------------------
    this_cArquivo  = ""    && Caminho arquivo temporario para imagem do produto
    this_nImagems  = 0     && SigCdOpe.Imagems: 1=exibir foto produto, 0=nao

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarCursores()
    *==========================================================================
        SET NULL ON
        IF USED("cursor_4c_Itens")
            SELECT cursor_4c_Itens
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Itens (CItens n(10), CPros c(14), DPros c(40), ;
                Obs m(4), CUnis c(3), Volumes n(3), Opers c(1), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                Units n(12,2), CMoes c(3), Totas n(12,2), Disps n(10,3))
        ENDIF
        IF USED("cursor_4c_Rodape")
            SELECT cursor_4c_Rodape
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Rodape (CPros c(14), Volumes n(3), ;
                QtdOs n(10,3), QtdBs n(10,3), QtdSs n(10,3), ;
                CMoes c(3), Totas n(12,2))
        ENDIF
        SET NULL OFF
    ENDPROC

    *==========================================================================
    PROCEDURE BuscarItens()
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado, loc_nRec
        loc_lResultado = .F.
        loc_nRec       = 0

        TRY
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.CItens, a.CPros, a.DPros, a.Obs, a.CUnis, c.Volumes, " + ;
                       "a.Opers, a.Qtds AS QtdOs, a.QtBaixas AS QtdBs, " + ;
                       "(a.Qtds - a.QtBaixas) AS QtdSs, a.Units, a.Moedas AS CMoes, a.Totas " + ;
                       "FROM SigMvItn a, SigCdOpe b, SigCdPro c " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum) + ;
                       " AND a.Dopes = b.Dopes AND a.CPros = c.CPros " + ;
                       "ORDER BY a.CItens, a.CPros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") < 1
                MsgErro("Falha ao executar consulta de itens da OP.", "Erro SQL")
            ELSE
                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    ZAP
                ENDIF
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Popular cursor_4c_Itens (CItens = numero sequencial como no legado)
                SELECT cursor_4c_DadosTemp
                SCAN
                    loc_nRec = loc_nRec + 1
                    INSERT INTO cursor_4c_Itens ;
                        (CItens, CPros, DPros, Obs, CUnis, Volumes, Opers, ;
                         QtdOs, QtdBs, QtdSs, Units, CMoes, Totas, Disps) ;
                    VALUES ;
                        (loc_nRec, ;
                         cursor_4c_DadosTemp.CPros, ;
                         cursor_4c_DadosTemp.DPros, ;
                         NVL(cursor_4c_DadosTemp.Obs, ""), ;
                         cursor_4c_DadosTemp.CUnis, ;
                         cursor_4c_DadosTemp.Volumes, ;
                         cursor_4c_DadosTemp.Opers, ;
                         cursor_4c_DadosTemp.QtdOs, ;
                         cursor_4c_DadosTemp.QtdBs, ;
                         cursor_4c_DadosTemp.QtdSs, ;
                         cursor_4c_DadosTemp.Units, ;
                         cursor_4c_DadosTemp.CMoes, ;
                         cursor_4c_DadosTemp.Totas, ;
                         0)
                ENDSCAN

                *-- Popular cursor_4c_Rodape (totais por moeda)
                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                SELECT CMoes, SUM(Volumes) AS Volumes, SUM(QtdOs) AS QtdOs, ;
                       SUM(QtdBs) AS QtdBs, SUM(QtdSs) AS QtdSs, SUM(Totas) AS Totas ;
                  FROM cursor_4c_DadosTemp ;
                 GROUP BY CMoes ;
                  INTO CURSOR cursor_4c_TotalTemp READWRITE

                SELECT cursor_4c_TotalTemp
                SCAN
                    INSERT INTO cursor_4c_Rodape ;
                        (CPros, Volumes, QtdOs, QtdBs, QtdSs, CMoes, Totas) ;
                    VALUES ;
                        ("", ;
                         cursor_4c_TotalTemp.Volumes, ;
                         cursor_4c_TotalTemp.QtdOs, ;
                         cursor_4c_TotalTemp.QtdBs, ;
                         cursor_4c_TotalTemp.QtdSs, ;
                         cursor_4c_TotalTemp.CMoes, ;
                         cursor_4c_TotalTemp.Totas)
                ENDSCAN

                IF USED("cursor_4c_TotalTemp")
                    USE IN cursor_4c_TotalTemp
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
                    GO TOP IN cursor_4c_Itens
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao buscar itens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCItens  = NVL(CItens, 0)
            THIS.this_cCPros   = ALLTRIM(NVL(CPros, ""))
            THIS.this_cDPros   = ALLTRIM(NVL(DPros, ""))
            THIS.this_cObs     = NVL(Obs, "")
            THIS.this_cCUnis   = ALLTRIM(NVL(CUnis, ""))
            THIS.this_nVolumes = NVL(Volumes, 0)
            THIS.this_cOpers   = ALLTRIM(NVL(Opers, ""))
            THIS.this_nQtdOs   = NVL(QtdOs, 0)
            THIS.this_nQtdBs   = NVL(QtdBs, 0)
            THIS.this_nQtdSs   = NVL(QtdSs, 0)
            THIS.this_nUnits   = NVL(Units, 0)
            THIS.this_cCMoes   = ALLTRIM(NVL(CMoes, ""))
            THIS.this_nTotas   = NVL(Totas, 0)
            THIS.this_nDisps   = NVL(Disps, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarInfoOperacao(par_cDopes)
    *==========================================================================
        LOCAL loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF

            loc_cSQL = "SELECT TOP 1 Imagems FROM SigCdOpe " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeInfo") > 0
                SELECT cursor_4c_SigCdOpeInfo
                IF !EOF()
                    THIS.this_nImagems = NVL(Imagems, 0)
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_SigCdOpeInfo")
                USE IN cursor_4c_SigCdOpeInfo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarImagemProduto(par_cCPros, par_cArquivo)
    *==========================================================================
        LOCAL loc_cSQL, loc_cFoto, loc_lResultado
        loc_lResultado       = .F.
        THIS.this_cArquivo   = ""

        TRY
            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF

            loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgPro") > 0
                SELECT cursor_4c_ImgPro
                IF !EOF() AND !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                    CLEAR RESOURCES
                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, par_cArquivo)
                    THIS.this_cArquivo = par_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgPro")
                USE IN cursor_4c_ImgPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Erro ao carregar imagem do produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN PADR(THIS.this_cEmpDopNum, 29) + TRANSFORM(THIS.this_nCItens)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida propriedades obrigatorias antes de Inserir/Atualizar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_cEmp)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDop)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF THIS.this_nNum <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da OP " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cCPros)
            THIS.this_cMensagemErro = "Produto " + CHR(233) + " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        IF THIS.this_nQtdOs < 0
            THIS.this_cMensagemErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cEmpDopNum)
            THIS.this_cEmpDopNum = PADR(THIS.this_cEmp, 3) + PADR(THIS.this_cDop, 20) + ;
                                    STR(THIS.this_nNum, 6)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - INSERT em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvItn " + ;
                       "(Emps, Dopes, Numes, EmpDopNums, CItens, CPros, DPros, Obs, " + ;
                       "CUnis, Opers, Qtds, QtBaixas, Units, Moedas, Totas, DtAlts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(PADR(THIS.this_cEmp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDop, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNum, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCItens, 0) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       EscaparSQL(THIS.this_cObs) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "GETDATE())"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao inserir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em SigMvItn dos campos gerenciados pelo BO
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvItn SET " + ;
                       "CPros    = " + EscaparSQL(PADR(THIS.this_cCPros, 14)) + ", " + ;
                       "DPros    = " + EscaparSQL(PADR(LEFT(THIS.this_cDPros, 65), 65)) + ", " + ;
                       "Obs      = " + EscaparSQL(THIS.this_cObs) + ", " + ;
                       "CUnis    = " + EscaparSQL(PADR(THIS.this_cCUnis, 3)) + ", " + ;
                       "Opers    = " + EscaparSQL(PADR(THIS.this_cOpers, 1)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtdOs, 3) + ", " + ;
                       "QtBaixas = " + FormatarNumeroSQL(THIS.this_nQtdBs, 3) + ", " + ;
                       "Units    = " + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                       "Moedas   = " + EscaparSQL(PADR(THIS.this_cCMoes, 3)) + ", " + ;
                       "Totas    = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ", " + ;
                       "DtAlts   = GETDATE() " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao atualizar item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE em SigMvItn do item corrente
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lResultado, loc_oErro, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvItn " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(PADR(THIS.this_cEmpDopNum, 29)) + " " + ;
                       "  AND CItens = " + FormatarNumeroSQL(THIS.this_nCItens, 0)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao excluir item da OP."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao excluir item")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
