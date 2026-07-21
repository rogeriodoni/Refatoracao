*====================================================================
* sigprimaBO.prg
* Business Object: Importacao/Exportacao de Imagens de Produtos
* Tabela principal: sigscjim
* Formulario OPERACIONAL
*====================================================================

DEFINE CLASS sigprimaBO AS BusinessBase

    *-- Tabela e chave (sigscjim)
    this_cTabela      = "sigscjim"
    this_cCampoChave  = "cidchaves"

    *-- Campos da tabela sigscjim
    this_cCidchaves = ""    && char(20) - chave primaria
    this_cCpros     = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_nIdimagem  = 0     && numeric(38,0) - id imagem
    this_cRefforref = ""    && char(50) - referencia do fornecedor

    *-- Parametros de operacao (passados via Init do form)
    this_cDiretorio = ""    && caminho do diretorio de imagens
    this_nTipoOp    = 1     && 1=Produtos, 2=Auxiliar(sigscjim), 3=Exportar
    this_cTipo1     = ""    && modo de execucao: 'A'=automatico, ''=manual

    *-- Resultado do processamento
    this_lSucesso   = .F.   && resultado do ultimo processamento
    this_cMsgFinal  = ""    && mensagem resultado a exibir

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigscjim"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida dados antes de inserir/atualizar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor sigscjim
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_nIdimagem  = TratarNulo(idimagem,  "N")
            THIS.this_cRefforref = TratarNulo(refforref, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidchaves = fUniqueIds()
            loc_cSQL = "INSERT INTO sigscjim " + ;
                       "(cidchaves, cpros, idimagem, refforref) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIdimagem, 0) + ", " + ;
                       EscaparSQL(THIS.this_cRefforref) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE sigscjim SET " + ;
                       "cpros     = " + EscaparSQL(THIS.this_cCpros)               + ", " + ;
                       "idimagem  = " + FormatarNumeroSQL(THIS.this_nIdimagem, 0)  + ", " + ;
                       "refforref = " + EscaparSQL(THIS.this_cRefforref)           + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processamento - Importa imagens JPG para produtos (SigCdPro) ou
    *                 registros auxiliares (sigscjim)
    * par_cDiretorio - diretorio com as imagens JPG
    * par_nTipo      - 1=Produtos, 2=Auxiliar(sigscjim)
    *====================================================================
    PROCEDURE Processamento(par_cDiretorio, par_nTipo)
        LOCAL loc_lSucesso, loc_cDir, loc_nTip, loc_nArq, loc_oErro
        LOCAL loc_oProgress, loc_nImg, loc_cImg, loc_cPro
        LOCAL loc_cDpro2, loc_cDpro3, loc_cReff, loc_cFig
        LOCAL loc_cSQL, loc_cQuery, loc_cMsg, loc_cDok, loc_cNom
        LOCAL loc_cArq, loc_cAok, loc_nCnt, loc_lVer, loc_lArq
        LOCAL loc_cImagem, loc_cImagem2, loc_cChave, loc_cOrigem
        LOCAL loc_nExiste
        LOCAL ARRAY loc_aArq(1)

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_nTip     = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 1)

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_nArq = ADIR(loc_aArq, loc_cDir + "*.JPG")

            IF loc_nArq < 1
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Cont" + CHR(233) + "m Nenhuma Imagem do Tipo .JPG!!!", ;
                         "Arquivos Inv" + CHR(225) + "lidos")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Nenhuma imagem .JPG encontrada."
                loc_lSucesso = .F.
            ENDIF

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processando Imagens...", loc_nArq)
            loc_oProgress.Show()

            loc_lSucesso = .T.

            FOR loc_nImg = 1 TO loc_nArq
                IF !loc_lSucesso
                    EXIT
                ENDIF

                loc_cImg  = ALLTRIM(loc_aArq(loc_nImg, 1))
                loc_lArq  = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")

                loc_cPro   = PADR(SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1), 14)
                loc_cDpro2 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cDpro3 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cReff  = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)

                loc_oProgress.SubTitulo.Caption = "Arquivo : " + ALLTRIM(loc_cImg)
                loc_oProgress.Update(.T.)

                IF loc_lArq
                    loc_cFig = loc_cDir + loc_cImg

                    IF FILE(loc_cFig)

                        IF loc_nTip = 2
                            *-- Modo auxiliar: busca em sigscjim por idimagem
                            loc_cQuery = "SELECT * FROM sigscjim WHERE idimagem = " + ;
                                         ALLTRIM(loc_cPro) + " ORDER BY CPros"

                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        loc_cImagem = FILETOSTR(loc_cFig)
                                        loc_cSQL    = "UPDATE sigscjim SET Imagem = ?loc_cImagem " + ;
                                                      "WHERE idimagem = " + ALLTRIM(loc_cPro) + ;
                                                      " AND CPros = " + EscaparSQL(cursor_4c_LocalPro.CPros)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigScjIm!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ELSE
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ENDIF

                                        IF USED("cursor_4c_Upd")
                                            USE IN cursor_4c_Upd
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF

                        ELSE
                            *-- Modo produtos: busca em SigCdPro por CPros/descricao/referencia

                            *-- Tentativa 1: busca por CPros
                            loc_cQuery = "SELECT * FROM SigCdPro WHERE CPros = " + ;
                                         EscaparSQL(loc_cPro) + " ORDER BY CPros"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            *-- Tentativa 2: busca por dPro2s
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(loc_cDpro2)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 3: busca por dPro2s sem pontos
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro2, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 4: busca por reffs (referencia fornecedor)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE reffs = " + ;
                                             EscaparSQL(ALLTRIM(loc_cReff)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 5: busca por dPro3s (descricao completa)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro " + ;
                                             "WHERE CONVERT(VARCHAR(50),dPro3s) = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro3, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        loc_cPro = cursor_4c_LocalPro.CPros

                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        *-- UPDATE SigCdPro com imagem
                                        loc_cImagem2 = FILETOSTR(loc_cFig)
                                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                                   "FigJpgs = ?loc_cImagem2, " + ;
                                                   "DtFilms = GETDATE(), " + ;
                                                   "Datas = GETDATE(), " + ;
                                                   "Flagctabs = 1, " + ;
                                                   "Transps = 0 " + ;
                                                   "WHERE CPros = " + EscaparSQL(loc_cPro)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        IF USED("cursor_4c_UpdPro")
                                            USE IN cursor_4c_UpdPro
                                        ENDIF

                                        *-- UPDATE/INSERT SigCdPrc com dados de auditoria
                                        IF loc_lSucesso
                                            loc_cChave  = fUniqueIds()
                                            loc_cOrigem = LEFT(TTOC(DATETIME()) + " SIGPRIMA", 50)

                                            IF SQLEXEC(gnConnHandle, ;
                                                "SELECT COUNT(1) AS nExiste FROM SigCdPrc " + ;
                                                "WHERE CPros = " + EscaparSQL(loc_cPro), ;
                                                "cursor_4c_ExistePrc") > 0 AND ;
                                               USED("cursor_4c_ExistePrc")
                                                SELECT cursor_4c_ExistePrc
                                                loc_nExiste = NVL(nExiste, 0)
                                                USE IN cursor_4c_ExistePrc
                                            ELSE
                                                loc_nExiste = 0
                                            ENDIF

                                            IF loc_nExiste > 0
                                                loc_cSQL = "UPDATE SigCdPrc SET " + ;
                                                           "DataAlts = GETDATE(), " + ;
                                                           "HoraAlts = " + EscaparSQL(TIME()) + ", " + ;
                                                           "UsuaAlts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                                                           "Origem   = " + EscaparSQL(loc_cOrigem) + ;
                                                           " WHERE CPros = " + EscaparSQL(loc_cPro)
                                            ELSE
                                                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                                                           "(cIdChaves, CPros, DataAlts, " + ;
                                                           "HoraAlts, UsuaAlts, Origem) VALUES (" + ;
                                                           EscaparSQL(loc_cChave)                      + ", " + ;
                                                           EscaparSQL(loc_cPro)                        + ", " + ;
                                                           "GETDATE(), "                               + ;
                                                           EscaparSQL(TIME())                          + ", " + ;
                                                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))    + ", " + ;
                                                           EscaparSQL(loc_cOrigem)                     + ;
                                                           ")"
                                            ENDIF

                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                        "vel Atualizar o Arquivo SigCdPrc!!!", ;
                                                        "Processamento Cancelado!!!")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        *-- DELETE FROM SigPrPrt
                                        IF loc_lSucesso
                                            loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + ;
                                                       EscaparSQL(loc_cPro)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                                        "Falha na Conex" + CHR(227) + "o (SigPrPrt)")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        IF loc_lSucesso
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ELSE
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                        ENDIF
                                    ENDIF
                                ENDSCAN

                                *-- Move arquivo para subpasta OK apos processamento
                                IF loc_lSucesso
                                    loc_cDok = loc_cDir + "OK\"
                                    IF !DIRECTORY(loc_cDok)
                                        MD (loc_cDok)
                                    ENDIF

                                    IF !DIRECTORY(loc_cDok)
                                        MsgAviso("O Diret" + CHR(243) + "rio [" + loc_cDok + ;
                                                 "] N" + CHR(227) + "o Pode Ser Criado!!!", ;
                                                 "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                                        loc_lSucesso = .F.
                                    ELSE
                                        loc_cNom = ALLTRIM(loc_aArq(loc_nImg, 1))
                                        loc_lArq = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")
                                        IF loc_lArq
                                            loc_cArq = loc_cDir + loc_cNom
                                            loc_cAok = ALLTRIM(loc_cDok) + "\" + ALLTRIM(loc_cNom)
                                            loc_nCnt = 0
                                            loc_lVer = .T.
                                            DO WHILE loc_lVer
                                                IF !FILE(loc_cAok)
                                                    loc_lVer = .F.
                                                    COPY FILE (loc_cArq) TO (loc_cAok)
                                                    IF FILE(loc_cAok)
                                                        DELETE FILE (loc_cArq)
                                                    ENDIF
                                                ELSE
                                                    loc_nCnt = loc_nCnt + 1
                                                    loc_cAok = loc_cDok + "\" + loc_cNom + "." + ;
                                                               PADL(loc_nCnt, 4, "0")
                                                ENDIF
                                            ENDDO
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            NEXT

            loc_oProgress.Complete()

            IF !loc_lSucesso
                loc_cMsg = "Os Arquivos N" + CHR(227) + "o Foram Importados!!!"
            ELSE
                loc_cMsg = "Os Arquivos Foram Importados!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

    *====================================================================
    * Exportar - Exporta imagens de produtos para arquivos JPG e
    *            converte para base64 (campo FigJpgs64)
    * par_cDiretorio - diretorio destino para os arquivos exportados
    *====================================================================
    PROCEDURE Exportar(par_cDiretorio)
        LOCAL loc_lSucesso, loc_cDir, loc_cMsg, loc_cQuery, loc_oErro
        LOCAL loc_cPro, loc_cFiltro, loc_cImag, loc_cSQL

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_cFiltro  = ""

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca grupos de produtos com imagem
            loc_cQuery = "SELECT cgrus, COUNT(1) AS qtd FROM sigcdpro " + ;
                         "WHERE 0=0 " + loc_cFiltro + ;
                         " GROUP BY cgrus ORDER BY 2"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Grupos") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Grupos)")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Falha ao buscar grupos."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            SCAN
                WAIT WINDOW "Atualizando o Grupo " + cursor_4c_Grupos.cgrus NOWAIT

                *-- Busca produtos do grupo
                loc_cQuery = "SELECT * FROM sigcdpro WHERE cgrus = " + ;
                             EscaparSQL(cursor_4c_Grupos.cgrus) + " " + loc_cFiltro
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Produtos)")
                    loc_lSucesso = .F.
                ENDIF

                IF loc_lSucesso AND USED("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    GO TOP IN cursor_4c_LocalPro

                    SCAN
                        *-- Pula produtos sem imagem
                        IF EMPTY(cursor_4c_LocalPro.FigJpgs)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Pula produtos que ja tem base64
                        IF !EMPTY(cursor_4c_LocalPro.FigJpgs64)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Exporta imagem para arquivo
                        loc_cPro = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                                   cursor_4c_LocalPro.cpros, "*", "_"), "/", "-"), "\", "-"))
                        STRTOFILE(cursor_4c_LocalPro.FigJpgs, ;
                                  loc_cDir + loc_cPro + ".jpg", .T.)

                        *-- Converte para base64 e atualiza FigJpgs64
                        loc_cImag = STRCONV(cursor_4c_LocalPro.FigJpgs, 13, 1046)

                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                   "FigJpgs64 = " + EscaparSQL("data:image/jpeg;base64," + loc_cImag) + ", " + ;
                                   "DtFilms   = GETDATE(), " + ;
                                   "Datas     = GETDATE(), " + ;
                                   "Flagctabs = 1, " + ;
                                   "Transps   = 0 " + ;
                                   "WHERE CPros = " + EscaparSQL(cursor_4c_LocalPro.cpros)

                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        ELSE
                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                    "Processamento Cancelado!!!")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                ENDIF

                SELECT cursor_4c_Grupos
            ENDSCAN

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            IF !loc_lSucesso
                loc_cMsg = "N" + CHR(227) + "o houve exporta" + CHR(231) + CHR(227) + "o!!!"
            ELSE
                loc_cMsg = "Exporta" + CHR(231) + CHR(227) + "o executada com sucesso!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

ENDDEFINE
