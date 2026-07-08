*==============================================================================
* SIGREDCUBO.PRG
* Business Object para Impressao de Documento (SIGREDCU)
* Herda de RelatorioBase
*
* Dialogo de opcoes de impressao de documentos operacionais.
* Recebe cursores ja populados (TmpRelat/TmpRel) do form chamador.
*==============================================================================

DEFINE CLASS sigredcuBO AS RelatorioBase

    *-- Parametros do documento a imprimir (recebidos do form chamador)
    this_cEmps            = ""    && Codigo empresa (3 chars)
    this_cDopes           = ""    && Tipo de operacao (20 chars)
    this_nNumes           = 0     && Numero do documento
    this_nQbols           = 1     && Quantidade de vias para impressao
    this_cEmail           = ""    && Email de destino

    *-- Tipo de impressao (TpImpressao do legado)
    this_nTpImpressao     = 0     && 0=nenhum, 1=video, 2=impressora, 3=excel, 4=encerrar

    *-- Opcoes de impressao (mapeadas dos checkboxes do form)
    this_nChkImagem       = 0     && Imprimir imagem (0=nao, 1=sim)
    this_nChkItensP       = 0     && Apenas itens pendentes (0=nao, 1=sim)
    this_nChkDescIng      = 0     && Descricao em ingles (0=nao, 1=sim)
    this_nChkCompo        = 0     && Inibir composicao desmembrada (0=nao, 1=sim)
    this_nChkImpPag       = 0     && Imprimir cabecalho em todas as paginas (0=nao, 1=sim)

    *-- Tipo de agrupamento (OptAgrupa, default 2=Nenhum)
    this_nOptAgrupa       = 2     && 1=Produto/Cor/Valor, 2=Nenhum, 3=Ref Forn/Cor/Tamanho

    *-- Controle de impressao de documento (ChkImpDoc do legado)
    this_lChkImpDoc       = .F.   && Documento tem controle de impressao
    this_lChkImpDocAcess  = .F.   && Acesso para reimpressao liberado
    this_lImpTodasPaginas = .F.   && Estado: imprimir cabecalho em todas as paginas

    *-- Controles de acesso aos botoes (lAcImprimir/lAcExcel do frmrelatorio)
    this_lAcImprimir      = .T.   && Acesso ao botao imprimir
    this_lAcExcel         = .T.   && Acesso ao botao excel

    *-- Visibilidade do chkCompo (determinada por fChecaAcesso no Init)
    this_lChkCompoVisivel = .F.

    *-- Dados carregados de crSigCdOpeD (JOIN SigCdOpe + SigOpCdc + SigOpCdi)
    this_nNDopes          = 0     && ID numerico da operacao (para fChecaAcesso)
    this_nChkImpDocOpe    = 0     && SigOpCdc.chkImpDoc: flag controle impressao
    this_nCarCompos       = 0     && SigOpCdc.carcompos: tipo composicao
    this_nDckTermos       = 0     && SigOpCdc.dckTermos: flag termos de garantia
    this_cCMoes           = ""    && SigCdOpe.Cmoes: moeda
    this_nTipoNfs         = 0     && SigCdOpe.TipoNfs: tipo nota fiscal
    this_nOpers           = 0     && SigCdOpe.Opers: 1=fornecedor, 2=destino, 3=ambos
    this_cLblTxIdCs       = ""    && SigOpCdi.lbltxidCs: string de configuracao
    this_nChkIFoto        = 0     && SigOpCdi.chkIFoto: flag imagem padrao

    *-- Cursores de dados (populados externamente pelo form chamador)
    this_cCursorDados     = "TmpRelat"   && Cursor principal com dados do documento
    this_cCursorRel       = "TmpRel"     && Cursor auxiliar de relatorio

    *-- Referencia ao form pai (para reativar apos fechar este dialogo)
    this_oFormPai         = .NULL.

    *-- Arquivo gerado para email/PDF (pcArqEmail do legado)
    this_cArqEmail        = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Carrega dados da operacao do banco (crSigCdOpeD)
    * Chamado pelo Form apos setar this_cEmps/this_cDopes/this_nNumes
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, " + ;
                       "a.Cmoes, a.TipoNfs, a.Opers, c.lbltxidCs, c.chkIFoto " + ;
                       "FROM SigCdOpe a, SigOpCdc b, SigOpCdi c " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND b.Dopes = a.Dopes AND c.Dopes = a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuOpe")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigRedcuOpe
                IF !EOF()
                    THIS.this_nNDopes         = NVL(Ndopes, 0)
                    THIS.this_nChkImpDocOpe   = NVL(chkImpDoc, 0)
                    THIS.this_nCarCompos      = NVL(carcompos, 0)
                    THIS.this_nDckTermos      = NVL(dckTermos, 0)
                    THIS.this_cCMoes          = ALLTRIM(NVL(Cmoes, ""))
                    THIS.this_nTipoNfs        = NVL(TipoNfs, 0)
                    THIS.this_nOpers          = NVL(Opers, 0)
                    THIS.this_cLblTxIdCs      = ALLTRIM(NVL(lbltxidCs, ""))
                    THIS.this_nChkIFoto       = NVL(chkIFoto, 0)

                    *-- chkCompo inicializado com valor da posicao 21 de lbltxidCs
                    THIS.this_nChkCompo = INT(VAL(SUBSTR(THIS.this_cLblTxIdCs, 21, 1)))

                    *-- chkImagem inicializado com valor de chkIFoto
                    THIS.this_nChkImagem = THIS.this_nChkIFoto

                    *-- Flag controle de impressao
                    IF THIS.this_nChkImpDocOpe <> 0
                        THIS.this_lChkImpDoc = .T.
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + ;
                        ALLTRIM(THIS.this_cDopes) + " n" + CHR(227) + "o encontrada"
                ENDIF

                IF USED("cursor_4c_SigRedcuOpe")
                    USE IN cursor_4c_SigRedcuOpe
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar dados da opera" + ;
                    CHR(231) + CHR(227) + "o " + ALLTRIM(THIS.this_cDopes)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarReimpressao - Verifica se documento ja foi impresso em SigMvCab
    * Retorna .T. se ja foi impresso
    *--------------------------------------------------------------------------
    PROCEDURE VerificarReimpressao()
        LOCAL loc_lJaImpresso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lJaImpresso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT Impress FROM SigMvCab WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuImp")

            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuImp
                IF !EOF()
                    IF NVL(Impress, 0) <> 0
                        loc_lJaImpresso = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuImp")
                    USE IN cursor_4c_SigRedcuImp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigredcuBO.VerificarReimpressao")
        ENDTRY
        RETURN loc_lJaImpresso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarImpressao - Marca documento como impresso (Impress=1) em SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarImpressao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lSucesso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET Impress = 1 WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult >= 0
                SQLCOMMIT(gnConnHandle)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar impress" + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.RegistrarImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do documento (EmpDopNums concatenado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + ;
               PADR(THIS.this_cDopes, 20) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do documento em LogAuditoria
    * par_cOperacao: IMPRIMIR, VISUALIZAR, EXCEL, EMAIL
    * Para IMPRIMIR, tambem atualiza SigMvCab.Impress = 1 via RegistrarImpressao()
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_cOp
        loc_lSucesso = .F.
        TRY
            loc_cOp = UPPER(ALLTRIM(par_cOperacao))

            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmps) + ;
                         ";DOP=" + ALLTRIM(THIS.this_cDopes) + ;
                         ";NUM=" + ALLTRIM(STR(THIS.this_nNumes, 6))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReDcu") + ", " + ;
                       EscaparSQL(loc_cOp) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)

            *-- Para operacao IMPRIMIR, marca documento como impresso em SigMvCab
            IF loc_cOp = "IMPRIMIR"
                THIS.RegistrarImpressao()
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do documento
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do documento a partir de cursor preset
    * Permite restaurar configuracao previamente salva (vias, opcoes, tipo agrupamento)
    * par_cAliasCursor: cursor com colunas: cEmps, cDopes, nNumes, nQbols,
    *                   nOptAgrupa, nChkImagem, nChkItensP, nChkDescIng,
    *                   nChkCompo, nChkImpPag, cEmail
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SCATTER MEMVAR

            IF TYPE("m.cEmps") = "C"
                THIS.this_cEmps = ALLTRIM(m.cEmps)
            ENDIF
            IF TYPE("m.cDopes") = "C"
                THIS.this_cDopes = ALLTRIM(m.cDopes)
            ENDIF
            IF TYPE("m.nNumes") = "N"
                THIS.this_nNumes = m.nNumes
            ENDIF
            IF TYPE("m.nQbols") = "N"
                THIS.this_nQbols = IIF(m.nQbols >= 1, m.nQbols, 1)
            ENDIF
            IF TYPE("m.cEmail") = "C"
                THIS.this_cEmail = ALLTRIM(m.cEmail)
            ENDIF
            IF TYPE("m.nOptAgrupa") = "N"
                THIS.this_nOptAgrupa = m.nOptAgrupa
            ENDIF
            IF TYPE("m.nChkImagem") = "N"
                THIS.this_nChkImagem = m.nChkImagem
            ENDIF
            IF TYPE("m.nChkItensP") = "N"
                THIS.this_nChkItensP = m.nChkItensP
            ENDIF
            IF TYPE("m.nChkDescIng") = "N"
                THIS.this_nChkDescIng = m.nChkDescIng
            ENDIF
            IF TYPE("m.nChkCompo") = "N"
                THIS.this_nChkCompo = m.nChkCompo
            ENDIF
            IF TYPE("m.nChkImpPag") = "N"
                THIS.this_nChkImpPag = m.nChkImpPag
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o documento enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida parametros, executa Impressao() e registra auditoria IMPRIMIR
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            loc_lSucesso = THIS.Impressao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRIMIR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o documento em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Reaplica Processamento() (TmpRelat) e delega para Visualizacao()
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            *-- Reprocessa TmpRelat com as opcoes atuais antes do preview
            IF !THIS.Processamento()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Visualizacao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Configura flag ImpTodasPaginas e posiciona cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararImpressao()
        THIS.this_lImpTodasPaginas = (THIS.this_nChkImpPag = 1)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Popula TmpRelat chamando SigPrIdc com opcoes atuais
    * Chamado ao inicializar e cada vez que usuario altera uma opcao
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorRel)
                SELECT (THIS.this_cCursorRel)
                GO TOP IN (THIS.this_cCursorRel)
            ENDIF
            DO SigPrIdc WITH ;
                THIS.this_cEmps, ;
                THIS.this_cDopes, ;
                THIS.this_nNumes, ;
                0, ;
                THIS.this_nQbols, ;
                THIS.this_nOptAgrupa, ;
                .T., ;
                gnConnHandle, ;
                (THIS.this_nChkImagem = 1), ;
                .F., ;
                (THIS.this_nChkItensP = 1), ;
                THIS.this_oFormPai, ;
                .F., ;
                (THIS.this_nChkDescIng = 1), ;
                THIS.this_nChkCompo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Processamento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarOpcoes - Reprocessa TmpRelat ao alterar opcoes de impressao
    * Chamado pelos handlers de OptAgrupa e todos os checkboxes de opcoes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarOpcoes()
        RETURN THIS.Processamento()
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Exibe preview do documento na tela (REPORT FORM PREVIEW)
    * Apos o preview, imprime termo de garantia se dckTermos = 1
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 PREVIEW NOCONSOLE
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Visualizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Envia documento para impressora em this_nQbols vias
    * TpImpressao 2 ou 4 = sem dialogo de impressora; outros = com PROMPT
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            SET PRINTER TO DEFAULT
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                IF INLIST(THIS.this_nTpImpressao, 2, 4)
                    REPORT FORM SigReDc2 TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM SigReDc2 TO PRINTER PROMPT NOCONSOLE
                ENDIF
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Impressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DocumentoExcel - Gera exportacao do documento para arquivo XLS
    * Popula this_cArqEmail com o caminho do arquivo gerado para uso posterior
    *--------------------------------------------------------------------------
    PROCEDURE DocumentoExcel()
        LOCAL loc_lSucesso, loc_nCnt, loc_cArqSaida
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            IF EMPTY(THIS.this_cArqEmail)
                loc_cArqSaida = SYS(2023) + "\" + ;
                    "Dcto_" + ALLTRIM(THIS.this_cDopes) + "_" + ;
                    TRANSFORM(THIS.this_nNumes) + "_" + ;
                    TRANSFORM(DATE(), "@YL") + ".xls"
                THIS.this_cArqEmail = loc_cArqSaida
            ELSE
                loc_cArqSaida = THIS.this_cArqEmail
            ENDIF
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 TO FILE (loc_cArqSaida) ASCII NOCONSOLE
            NEXT
            loc_lSucesso = FILE(loc_cArqSaida)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.DocumentoExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * impGarantia - Imprime termo de garantia quando dckTermos = 1
    * Carrega colunas de texto e titulo de SigOpCdc e imprime SigReDc3
    *--------------------------------------------------------------------------
    PROCEDURE impGarantia()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTxtTermos
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nDckTermos <> 1
                loc_lSucesso = .T.
            ENDIF
            loc_cSQL = "SELECT DocTit, DocOrig, DocDest, DckReffs, DocReffs, " + ;
                       "DckPrzE, DocPrzE, TxtPrzEnts, ChkPrzEnts, DckVend, " + ;
                       "DocVend, DocPag, DckTVend, DckBarra, DckFretes, DocFretes, " + ;
                       "DckIcmIpi, DocDesco, DocAcres, DckEntregs, DocEntregs, " + ;
                       "DckObsI, ImgTecs, DckTermos, TitTermos, TxtTermos, " + ;
                       "ViaTermos, TitTermgs, TxtTermgs " + ;
                       "FROM SigOpCdc " + ;
                       "WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuGar")
            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuGar
                IF !EOF()
                    loc_cTxtTermos = ALLTRIM(NVL(TxtTermos, ""))
                    IF !EMPTY(loc_cTxtTermos)
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        REPORT FORM SigReDc3 TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuGar")
                    USE IN cursor_4c_SigRedcuGar
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.impGarantia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia documento por email com anexo PDF ou XLS
    * par_cAnexo - Caminho completo do arquivo a anexar
    * Usa this_cEmail (passado no Init pelo form chamador)
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cAnexo)
        LOCAL loc_lSucesso
        LOCAL loc_cEmailDest, loc_cAssunto
        loc_lSucesso = .F.
        TRY
            loc_cEmailDest = ALLTRIM(THIS.this_cEmail)
            IF EMPTY(loc_cEmailDest)
                THIS.this_cMensagemErro = "E-mail de destino n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(par_cAnexo) OR !FILE(par_cAnexo)
                THIS.this_cMensagemErro = "Arquivo anexo n" + CHR(227) + "o encontrado"
                loc_lSucesso = .F.
            ENDIF
            loc_cAssunto = "Documento " + ALLTRIM(THIS.this_cDopes) + ;
                           " N" + CHR(250) + "mero " + TRANSFORM(THIS.this_nNumes)
            ForeMails(loc_cEmailDest, loc_cAssunto, par_cAnexo, ;
                      PADR(THIS.this_cEmps, 3))
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.EnviarEmail")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
