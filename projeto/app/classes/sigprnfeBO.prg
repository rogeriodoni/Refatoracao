*******************************************************************************
* sigprnfeBO.prg - Business Object - Processamento de NF-e
* Herda de BusinessBase
* Migrado de: SIGPRNFE.SCX (Framework Fortyus)
*******************************************************************************
DEFINE CLASS sigprnfeBO AS BusinessBase

    *-- Filtros do formulario (controles de cntOperacoes)
    this_cEmps             = ""   && Empresa (SigCdEmp.Cemps char(3))
    this_cSeries           = ""   && Serie NF-e (SigCdSer.Cods char(3))
    this_dDtIni            = {}   && Data inicial de emissao
    this_dDtFin            = {}   && Data final de emissao
    this_nProcessados      = 0    && 1=Nao Processados, 2=Ja Processados
    this_nTipos            = 0    && 1=Saida, 2=Entrada
    this_nAmbiente         = 0    && 1=Producao, 2=Homologacao
    this_nAcao             = 0    && 1=Enviar, 2=Consultar, 3=Cancelar, 4=Inutilizar, 5=PDF, 6=Email, 7=Status
    this_nImpressao        = 0    && Tipo de impressao DANFE
    this_nContin           = 0    && Contingencia (1=Nenhuma, 2=EPEC, 3=SCAN/SVC)
    this_cInuIni           = ""   && Numero inicial para inutilizacao
    this_cInuFim           = ""   && Numero final para inutilizacao
    this_cRegime           = ""   && Regime tributario (descricao combo)
    this_cArquivos         = ""   && Caminho base arquivos NF-e
    this_dIniContin        = {}   && Data inicio contingencia
    this_lHVerao           = .F.  && Horario de verao
    this_lVenc             = .F.  && Vencimentos futuros
    this_lOptSub           = .F.  && Substituir codigo produto por referencia
    this_lOptArq           = .F.  && Usar TXT-ALT
    this_cVersao           = ""   && Versao schema NF-e (ex: 2.0.4)
    this_lValidaIE         = .F.  && Validar Inscricao Estadual via DLL

    *-- Dados NF-e em processamento (equivalente as vars PUBLIC do legado)
    this_cId               = ""   && Chave de acesso NF-e 44 chars (SigMvNfi.nfechv)
    this_cCnpj             = ""   && CNPJ empresa emitente
    this_cDEmis            = ""   && Data emissao formato NF-e
    this_cEmail            = ""   && Email NF-e empresa
    this_cConteudoTXT      = ""   && Conteudo arquivo TXT
    this_cConteudoXML      = ""   && Conteudo arquivo XML
    this_cConteudoPDF      = ""   && Conteudo arquivo PDF
    this_cPathUni          = ""   && Caminho unificado NF-e
    this_cLote             = ""   && Numero do lote de envio
    this_cRecibo           = ""   && Recibo do lote SEFAZ
    this_cProt             = ""   && Protocolo de autorizacao

    *-- Caminhos de pastas NF-e (equiv lcP* PUBLIC do legado)
    this_cPathNFe          = ""   && Caminho raiz arquivos NF-e
    this_cDanfe            = ""   && Arquivo DANFE
    this_cUniNFe           = ""   && Arquivo unificado NF-e
    this_cLog              = ""   && Arquivo de log
    this_cBKP              = ""   && Caminho de backup
    this_cPEnvio           = ""   && Pasta: a enviar
    this_cPEnviado         = ""   && Pasta: enviados
    this_cPEnvioEmLote     = ""   && Pasta: envio em lote
    this_cPErro            = ""   && Pasta: erros
    this_cPRetorno         = ""   && Pasta: retorno SEFAZ
    this_cPValidar         = ""   && Pasta: a validar
    this_cPBKenviados      = ""   && Pasta: backup enviados
    this_cPEmProc          = ""   && Pasta: em processamento
    this_cPAssinado        = ""   && Pasta: assinados
    this_cPValidado        = ""   && Pasta: validados
    this_cPAutorizados     = ""   && Pasta: autorizados
    this_cPPdf             = ""   && Pasta: PDFs DANFE
    this_cPBkp             = ""   && Pasta: backup geral
    this_cPTxt             = ""   && Prefixo tipo arquivo (ex: "nfe-")
    this_cChr              = ""   && Caractere codificacao XML
    this_cTpImp            = ""   && Tipo impressao DANFE (RETRATO/PAISAGEM)

    *-- Dados da empresa emitente (de SigCdEmp)
    this_cCemps            = ""   && Codigo empresa (SigCdEmp.Cemps char(3))
    this_cRazas            = ""   && Razao social (SigCdEmp.Razas)
    this_cEstas            = ""   && UF da empresa
    this_nRegimeEmp        = 0    && Regime (1=Simples, 2=Presumido, 3=Real, 4=Arbitrado)
    this_cTextoNFe         = ""   && Texto padrao corpo email NF-e
    this_cEmailNFe         = ""   && Email remetente/copia NF-e
    this_cServs            = ""   && Servidor SMTP
    this_cSenhas           = ""   && Senha SMTP
    this_nPortas           = 0    && Porta SMTP

    *-- Controle de processamento em lote
    this_lEmProcessamento  = .F.  && Flag: processamento ativo
    this_cMensagemErro     = ""   && Ultima mensagem de erro no processamento
    this_nTotalProcessados = 0    && Total de NFs processadas com sucesso
    this_nTotalErros       = 0    && Total de NFs com erro no lote

    *-- Dados do registro NF-e corrente (mapeado de csOperacoes)
    this_lSelImp           = .F.  && Flag selecao para processamento
    this_cDopes            = ""   && Operacao (SigMvNfi.dopes char(20))
    this_nNumes            = 0    && Numero NF (SigMvNfi.numes numeric(6,0))
    this_dDatas            = {}   && Data emissao do registro corrente
    this_nValos            = 0    && Valor NF (SigMvNfi.TotNotas numeric(14,2))
    this_cNotas            = ""   && Numero NF string (SigMvNfi.NFis char(6))
    this_cNFMemo           = ""   && Memo da NF
    this_cErros            = ""   && Erros de processamento
    this_cStats            = ""   && Status NF-e (sigprnfe.stats char(3))
    this_cStatts           = ""   && Sub-status NF-e (sigprnfe.statts char(1))
    this_cEmpDopNums       = ""   && Chave composta emps+dopes+numes (char(29))

    *-- Conteudo NF-e para UPDATE SigMvNfi
    this_cNfeTxt           = ""   && Conteudo arquivo TXT NF-e (nfetxt text)
    this_cNfeXml           = ""   && Conteudo arquivo XML NF-e (nfexml text)
    this_cNfePdf           = ""   && Conteudo arquivo PDF NF-e (nfepdf text)
    this_nImpress          = 0    && Flag nota impressa (SigMvNfi.impress numeric(6,0))
    this_cNfePrt           = ""   && Protocolo autorizacao (SigMvNfi.nfeprt char(15))
    this_cCidChaves        = ""   && PK de SigMvNfi para UPDATE (cidchaves char(20))

    *-- Dados para INSERT em sigprnfe
    this_cArquivoNFe       = ""   && Caminho arquivo TXT gerado (sigprnfe.arquivos char(250))
    this_cPkSigPrNfe       = ""   && PK de sigprnfe (cidchaves char(20)) gerado em Inserir
    this_cNumeronota       = ""   && Numero estendido da nota (sigprnfe.numeronota char(10))

    *==========================================================================
    * Init - Inicializa BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODOS os campos de csOperacoes para this_*
    * par_cAliasCursor: alias do cursor de trabalho (normalmente "csOperacoes")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_lSelImp     = NVL(SelImp, .F.)
                THIS.this_cEmps       = ALLTRIM(NVL(Emps, ""))
                THIS.this_cDopes      = ALLTRIM(NVL(Dopes, ""))
                THIS.this_nNumes      = NVL(Numes, 0)
                THIS.this_dDatas      = NVL(Datas, {})
                THIS.this_nValos      = NVL(Valos, 0)
                THIS.this_cNotas      = ALLTRIM(NVL(Notas, ""))
                THIS.this_cSeries     = ALLTRIM(NVL(Series, ""))
                THIS.this_cNFMemo     = NVL(NFMemo, "")
                THIS.this_cErros      = NVL(Erros, "")
                THIS.this_nTipos      = NVL(Tipos, 0)
                THIS.this_cStats      = ALLTRIM(NVL(stats, ""))
                THIS.this_cId         = ALLTRIM(NVL(ids, ""))
                THIS.this_cLote       = ALLTRIM(NVL(lotes, ""))
                THIS.this_cRecibo     = ALLTRIM(NVL(recibos, ""))
                THIS.this_cProt       = ALLTRIM(NVL(prots, ""))
                THIS.this_cStatts     = ALLTRIM(NVL(statts, ""))
                THIS.this_cEmpDopNums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        ALLTRIM(THIS.this_cDopes) + ;
                                        PADL(ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Selecionar - Carrega registros NF-e da base conforme filtros em this_*
    * par_cCursorDestino: cursor de destino (default: "csOperacoes")
    * Retorna .T. se encontrou registros, .F. se vazio ou erro
    *==========================================================================
    PROCEDURE Selecionar(par_cCursorDestino)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_cSQL2, loc_cSQL3
        LOCAL loc_cEmp, loc_cSer, loc_cOper, loc_nOper
        LOCAL loc_cDtI, loc_cDtF, loc_cCheOpe
        LOCAL loc_cCursor, loc_nRet

        loc_lResultado = .F.
        loc_cCursor = IIF(PCOUNT() >= 1 .AND. !EMPTY(par_cCursorDestino), ;
                          par_cCursorDestino, "csOperacoes")

        *-- Validacoes (fora do TRY para RETURN seguro)
        IF EMPTY(THIS.this_cEmps)
            MsgAviso("A Empresa N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtIni)
            MsgAviso("A Data Inicial N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFin)
            MsgAviso("A Data Final N" + CHR(227) + "o Foi Informada!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFin < THIS.this_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!", ;
                     "Sele" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF INLIST(THIS.this_nAcao, 4, 7)
            IF EMPTY(THIS.this_cInuIni) OR EMPTY(THIS.this_cInuFim) ;
               OR THIS.this_cInuFim < THIS.this_cInuIni
                MsgAviso("A Numera" + CHR(231) + CHR(227) + "o informada est" + ;
                         CHR(225) + " inconsistente!", "Sele" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF
        IF THIS.this_nProcessados = 2
            IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Opera" + ;
                            CHR(231) + CHR(245) + "es J" + CHR(225) + ;
                            " Processadas Anteriormente?")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            *-- Monta variaveis
            loc_cEmp  = PADR(ALLTRIM(THIS.this_cEmps), 3)
            loc_cSer  = PADR(ALLTRIM(THIS.this_cSeries), 3)
            loc_cOper = IIF(THIS.this_nTipos = 1, "S", "E")
            loc_nOper = IIF(THIS.this_nTipos = 1, 2, 1)
            loc_cDtI  = FormatarDataSQL(THIS.this_dDtIni)
            loc_cDtF  = FormatarDataSQL(THIS.this_dDtFin)

            *-- Query 1: busca NF-e em SigMvNfi
            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Emis AS Datas, " + ;
                       "a.TotNotas AS Valos, a.NFis AS Notas, a.Series, " + ;
                       "a.EmpDopNums, o2.PalmEsts " + ;
                       "FROM SigMvNfi a, SigCdOpe o, SigOpCdd o2, SigMvCab e " + ;
                       "WHERE a.Emis BETWEEN " + loc_cDtI + ;
                       " AND DATEADD(second, 86399, " + loc_cDtF + ") " + ;
                       "AND a.Emps = " + EscaparSQL(loc_cEmp) + " " + ;
                       IIF(EMPTY(ALLTRIM(loc_cSer)), "", ;
                           "AND a.Series = " + EscaparSQL(loc_cSer) + " ") + ;
                       "AND a.Dopes = o.Dopes " + ;
                       "AND o.Dopes = o2.Dopes " + ;
                       "AND o.Opers = " + TRANSFORM(loc_nOper) + " " + ;
                       "AND a.EmpDopNums = e.EmpDopNums " + ;
                       "AND e.LCancelas = 0 " + ;
                       IIF(THIS.this_nProcessados = 1, ;
                           "AND a.EmpDopNums NOT IN (SELECT b.EmpDopNums FROM sigprnfe b) ", ;
                           IIF(THIS.this_nProcessados = 2, ;
                               "AND a.EmpDopNums IN (SELECT b.EmpDopNums FROM sigprnfe b) ", "")) + ;
                       "ORDER BY a.Emps, a.Dopes, a.Numes"

            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigDados")
            IF loc_nRet < 1
                MsgErro("Falha na consulta de NF-e (SigMvNfi). Verifique a conex" + ;
                        CHR(227) + "o.", "Sele" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

            *-- Monta lista de EmpDopNums para query sigprnfe
            SELECT cursor_4c_SigDados
            GO TOP
            loc_cCheOpe = ""
            SCAN
                loc_cCheOpe = loc_cCheOpe + ;
                    IIF(EMPTY(loc_cCheOpe), "", ",") + ;
                    "'" + ALLTRIM(cursor_4c_SigDados.EmpDopNums) + "'"
            ENDSCAN

            IF EMPTY(loc_cCheOpe)
                loc_cCheOpe = "'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'"
            ENDIF

            *-- Query 2: busca registros sigprnfe (controle de processamento)
            loc_cSQL2 = "SELECT a.* FROM sigprnfe a " + ;
                        "WHERE a.EmpDopNums IN (" + loc_cCheOpe + ")"

            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_NfeSel1")
            IF loc_nRet < 1
                MsgErro("Falha na consulta sigprnfe. Verifique a conex" + ;
                        CHR(227) + "o.", "Sele" + CHR(231) + CHR(227) + "o")
                IF USED("cursor_4c_SigDados")
                    USE IN cursor_4c_SigDados
                ENDIF
                loc_lResultado = .F.
            ELSE

            *-- Filtra sigprnfe pelos EmpDopNums encontrados + ordena por data desc
            SELECT a.* FROM cursor_4c_NfeSel1 a ;
                WHERE a.EmpDopNums IN ;
                    (SELECT b.EmpDopNums FROM cursor_4c_SigDados b) ;
                ORDER BY a.EmpDopNums, a.datas DESC ;
                INTO CURSOR cursor_4c_NfeSel READWRITE

            *-- Query 3: busca series NF-e eletronica (ImpNfs = 3)
            loc_cSQL3 = "SELECT a.Emps, a.Cods AS Series, a.ImpNfs " + ;
                        "FROM SigCdSer a " + ;
                        "WHERE a.ImpNfs = 3 " + ;
                        "ORDER BY a.Emps, a.Cods, a.ImpNfs"

            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_SeriesNFe")

            *-- Recria cursor destino com estrutura csOperacoes
            IF USED(loc_cCursor)
                ZAP IN (loc_cCursor)
            ELSE
                SET NULL ON
                CREATE CURSOR (loc_cCursor) ( ;
                    SelImp  L(1) NULL, ;
                    Emps    C(3) NULL, ;
                    Dopes   C(20) NULL, ;
                    Numes   N(6,0) NULL, ;
                    Datas   D(8) NULL, ;
                    Valos   N(12,2) NULL, ;
                    Notas   C(10) NULL, ;
                    Series  C(3) NULL, ;
                    NFMemo  M(4) NULL, ;
                    Erros   M(4) NULL, ;
                    Tipos   N(1,0) NULL, ;
                    stats   C(3) NULL, ;
                    ids     C(47) NULL, ;
                    lotes   C(15) NULL, ;
                    recibos C(15) NULL, ;
                    prots   C(15) NULL, ;
                    statts  C(1) NULL ;
                )
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6) TAG Notas
                SET NULL OFF
            ENDIF

            *-- Popula cursor destino
            SELECT cursor_4c_SigDados
            GO TOP
            SCAN
                *-- Verifica se a serie eh NF-e (ImpNfs=3)
                SELECT cursor_4c_SeriesNFe
                GO TOP
                LOCATE FOR ALLTRIM(Emps) = ALLTRIM(cursor_4c_SigDados.Emps) ;
                    AND ALLTRIM(Series) = PADR(ALLTRIM(cursor_4c_SigDados.Series), 3)
                IF EOF("cursor_4c_SeriesNFe")
                    GO TOP IN cursor_4c_SeriesNFe
                    LOCATE FOR EMPTY(ALLTRIM(Emps)) ;
                        AND ALLTRIM(Series) = PADR(ALLTRIM(cursor_4c_SigDados.Series), 3)
                ENDIF

                *-- Busca registro em sigprnfe correspondente
                SELECT cursor_4c_NfeSel
                GO TOP
                LOCATE FOR ALLTRIM(EmpDopNums) = ALLTRIM(cursor_4c_SigDados.EmpDopNums)

                IF !EOF("cursor_4c_SeriesNFe")
                    INSERT INTO (loc_cCursor) ;
                        (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                         Notas, Series, Tipos, stats, ids, lotes, recibos, prots, statts) ;
                        VALUES (.F., ;
                                cursor_4c_SigDados.Emps, ;
                                cursor_4c_SigDados.Dopes, ;
                                cursor_4c_SigDados.Numes, ;
                                cursor_4c_SigDados.Datas, ;
                                cursor_4c_SigDados.Valos, ;
                                cursor_4c_SigDados.Notas, ;
                                cursor_4c_SigDados.Series, ;
                                MAX(cursor_4c_SigDados.PalmEsts, 1), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.stats), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.ids), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.lotes), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.recibos), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.prots), ""), ;
                                IIF(!EOF("cursor_4c_NfeSel"), ;
                                    ALLTRIM(cursor_4c_NfeSel.statts), ""))
                ENDIF
                SELECT cursor_4c_SigDados
            ENDSCAN

            *-- Fecha cursores temporarios
            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF
            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF
            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF

            *-- Posiciona no inicio do cursor destino
            SELECT (loc_cCursor)
            SET ORDER TO TAG Notas
            GO TOP

            loc_lResultado = !EOF(loc_cCursor)

            ENDIF  && query2 ok
            ENDIF  && query1 ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Selecionar")
            IF USED("cursor_4c_SigDados")
                USE IN cursor_4c_SigDados
            ENDIF
            IF USED("cursor_4c_NfeSel1")
                USE IN cursor_4c_NfeSel1
            ENDIF
            IF USED("cursor_4c_NfeSel")
                USE IN cursor_4c_NfeSel
            ENDIF
            IF USED("cursor_4c_SeriesNFe")
                USE IN cursor_4c_SeriesNFe
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarEmpresa - Carrega dados da empresa de SigCdEmp para this_*
    * par_cCemps: codigo empresa (char(3))
    * Retorna .T. se encontrou, .F. se nao encontrou ou erro
    *==========================================================================
    PROCEDURE CarregarEmpresa(par_cCemps)
        LOCAL loc_lResultado, loc_oErro, loc_nRet, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdEmp WHERE NOT Ativas = 2"

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar dados de empresa.", "Erro")
                loc_lResultado = .F.
            ELSE

            SELECT cursor_4c_Empresa
            GO TOP
            LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(par_cCemps)

            IF !EOF("cursor_4c_Empresa")
                THIS.this_cCemps      = ALLTRIM(NVL(Cemps, ""))
                THIS.this_cRazas      = ALLTRIM(NVL(Razas, ""))
                THIS.this_cEstas      = ALLTRIM(NVL(estas, ""))
                THIS.this_nRegimeEmp  = NVL(Regimes, 0)
                THIS.this_cTextoNFe   = ALLTRIM(NVL(textonfe, ""))
                THIS.this_cEmailNFe   = ALLTRIM(NVL(emailnfe, ""))
                THIS.this_cServs      = ALLTRIM(NVL(servs, ""))
                THIS.this_cSenhas     = ALLTRIM(NVL(senhas, ""))
                THIS.this_nPortas     = NVL(portas, 0)
                THIS.this_cArquivos   = ALLTRIM(NVL(pastas, ""))
                THIS.this_cCnpj       = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(NVL(cgcs,""),".",""),"-",""),"/",""))

                DO CASE
                    CASE THIS.this_nRegimeEmp = 1
                        THIS.this_cRegime = "Simples Nacional"
                    CASE THIS.this_nRegimeEmp = 2
                        THIS.this_cRegime = "Lucro Presumido"
                    CASE THIS.this_nRegimeEmp = 3
                        THIS.this_cRegime = "Lucro Real"
                    CASE THIS.this_nRegimeEmp = 4
                        THIS.this_cRegime = "Lucro Arbitrado"
                    OTHERWISE
                        THIS.this_cRegime = ""
                ENDCASE

                loc_lResultado = .T.
            ELSE
                MsgAviso("Empresa " + ALLTRIM(par_cCemps) + " n" + CHR(227) + ;
                         "o encontrada ou inativa.", "Empresa")
            ENDIF

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            ENDIF  && sqlexec ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarEmpresa")
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Registra NF-e processada em sigprnfe
    * Popula THIS.this_cPkSigPrNfe com cidchaves gerado
    * Retorna .T. se inseriu com sucesso
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cEmpDopNums
        loc_lResultado = .F.
        TRY
            loc_cCidChaves  = LEFT(fUniqueIds(), 20)
            loc_cEmpDopNums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                              ALLTRIM(THIS.this_cDopes) + ;
                              PADL(ALLTRIM(STR(THIS.this_nNumes, 6)), 6)

            loc_cSQL = "INSERT INTO sigprnfe " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, datas, usuars, " + ;
                       " arquivos, notas, ids, lotes, recibos, prots, stats, statts, numeronota) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cCidChaves) + ", " + ;
                       EscaparSQL(LEFT(loc_cEmpDopNums, 29)) + ", " + ;
                       EscaparSQL(LEFT(PADR(ALLTRIM(THIS.this_cEmps), 3), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cArquivoNFe), 250)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNotas), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cId), 47)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLote), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cRecibo), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cProt), 15)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cStats), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cStatts), 1)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumeronota), 10)) + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao registrar NF-e em sigprnfe.", "Erro Inserir")
            ELSE
                THIS.this_cPkSigPrNfe = loc_cCidChaves
                THIS.RegistrarAuditoria("I")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza SigMvNfi com conteudo NF-e apos processamento SEFAZ
    * Atualiza: nfetxt, nfexml, nfepdf, nfechv, nfeprt, impress
    * Usa this_cCidChaves como PK para identificar o registro
    * Retorna .T. se atualizou com sucesso
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        LOCAL loc_mNfeTxt, loc_mNfeXml, loc_mNfePdf
        loc_lResultado = .F.
        TRY
            *-- Usa this_cCidChaves (PK) ou busca por EmpDopNums se nao definido
            IF EMPTY(THIS.this_cCidChaves)
                LOCAL loc_cSQLBusca, loc_nRetBusca
                loc_cSQLBusca = "SELECT TOP 1 cidchaves FROM SigMvNfi " + ;
                                "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
                IF USED("cursor_4c_ChaveMvNfi")
                    USE IN cursor_4c_ChaveMvNfi
                ENDIF
                loc_nRetBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "cursor_4c_ChaveMvNfi")
                IF loc_nRetBusca >= 1 .AND. RECCOUNT("cursor_4c_ChaveMvNfi") > 0
                    SELECT cursor_4c_ChaveMvNfi
                    GO TOP
                    THIS.this_cCidChaves = ALLTRIM(NVL(cidchaves, ""))
                ENDIF
                IF USED("cursor_4c_ChaveMvNfi")
                    USE IN cursor_4c_ChaveMvNfi
                ENDIF
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel identificar o registro em SigMvNfi.", ;
                        "Erro Atualizar")
                loc_lResultado = .F.
            ELSE

            *-- Prepara memo vars para parametrizacao (TEXT columns)
            loc_mNfeTxt = THIS.this_cNfeTxt
            loc_mNfeXml = THIS.this_cNfeXml
            loc_mNfePdf = THIS.this_cNfePdf

            loc_cSQL = "UPDATE SigMvNfi SET " + ;
                       "nfetxt = ?loc_mNfeTxt, " + ;
                       "nfexml = ?loc_mNfeXml, " + ;
                       "nfepdf = ?loc_mNfePdf, " + ;
                       "nfechv = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cId), 44)) + ", " + ;
                       "nfeprt = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNfePrt), 15)) + ", " + ;
                       "impress = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar SigMvNfi com conte" + CHR(250) + ;
                        "do NF-e.", "Erro Atualizar")
            ELSE
                THIS.RegistrarAuditoria("A")
                loc_lResultado = .T.
            ENDIF

            ENDIF  && cidchaves ok

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Atualizar")
            IF USED("cursor_4c_ChaveMvNfi")
                USE IN cursor_4c_ChaveMvNfi
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave do registro NF-e atual
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cId
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    * par_cOperacao: "I"=Inserir, "A"=Atualizar, "E"=Excluir
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL, loc_nRet
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("sigprnfe") + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cOperacao), 1)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 50)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChecarDirs - Configura caminhos das pastas NF-e a partir de this_cArquivos
    *==========================================================================
    PROCEDURE ChecarDirs()
        LOCAL loc_cBase, loc_oErro
        TRY
            loc_cBase = ALLTRIM(THIS.this_cArquivos)
            IF EMPTY(loc_cBase)
                RETURN
            ENDIF
            IF RIGHT(loc_cBase, 1) # "\"
                loc_cBase = loc_cBase + "\"
            ENDIF
            THIS.this_cPathNFe      = loc_cBase
            THIS.this_cPEnvio       = loc_cBase + "envio\"
            THIS.this_cPEnviado     = loc_cBase + "enviados\"
            THIS.this_cPEnvioEmLote = loc_cBase + "emLote\"
            THIS.this_cPErro        = loc_cBase + "erros\"
            THIS.this_cPRetorno     = loc_cBase + "retorno\"
            THIS.this_cPValidar     = loc_cBase + "avalidar\"
            THIS.this_cPBKenviados  = loc_cBase + "bkp_enviados\"
            THIS.this_cPEmProc      = loc_cBase + "emprocessamento\"
            THIS.this_cPAssinado    = loc_cBase + "assinados\"
            THIS.this_cPValidado    = loc_cBase + "validados\"
            THIS.this_cPAutorizados = loc_cBase + "autorizados\"
            THIS.this_cPPdf         = loc_cBase + "pdfs\"
            THIS.this_cPBkp         = loc_cBase + "backup\"
            THIS.this_cPTxt         = IIF(THIS.this_nTipos = 1, "nfe-", "nfe-e-")
            THIS.this_cChr          = CHR(13) + CHR(10)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ChecarDirs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GerarNomeArquivo - Gera nome unico de arquivo para NF-e na pasta indicada
    * par_cPasta: pasta destino (ex: this_cPEnvio)
    * par_cPref: prefixo (ex: "nfe-")
    * par_cExt: extensao sem ponto (ex: "txt")
    *==========================================================================
    PROTECTED PROCEDURE GerarNomeArquivo(par_cPasta, par_cPref, par_cExt)
        LOCAL loc_cBase, loc_cNom, loc_nIdx
        loc_cBase = ALLTRIM(par_cPasta)
        IF RIGHT(loc_cBase, 1) # "\"
            loc_cBase = loc_cBase + "\"
        ENDIF
        loc_nIdx = 0
        loc_cNom = ""
        DO WHILE .T.
            loc_cNom = loc_cBase + ALLTRIM(par_cPref) + "-" + ;
                       LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()), 5, 2) + ;
                       "-" + RIGHT(DTOS(DATE()), 2) + "-" + ;
                       IIF(THIS.this_nTipos = 1, "S", "E") + ;
                       PADL(TRANSFORM(loc_nIdx), 2, "0") + "." + ALLTRIM(par_cExt)
            IF !FILE(loc_cNom)
                STRTOFILE("", loc_cNom)
                EXIT
            ENDIF
            loc_nIdx = loc_nIdx + 1
        ENDDO
        RETURN loc_cNom
    ENDPROC

    *==========================================================================
    * Processamento - Loop principal: processa NF-es selecionadas em csOperacoes
    * par_cEmps: codigo empresa (char 3)
    * par_cSeries: serie NF-e (char 3)
    *==========================================================================
    PROCEDURE Processamento(par_cEmps, par_cSeries)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_oProgress, loc_nTotal, loc_nProc, loc_nErro, loc_lOkReg
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ContSel")
                USE IN cursor_4c_ContSel
            ENDIF
            SELECT COUNT(*) AS nSel FROM csOperacoes WHERE SelImp INTO CURSOR cursor_4c_ContSel
            loc_nTotal = cursor_4c_ContSel.nSel
            USE IN cursor_4c_ContSel

            IF loc_nTotal = 0
                MsgAviso("Nenhum lan" + CHR(231) + "amento selecionado para processamento.")
                loc_lResultado = .F.
            ENDIF

            THIS.ChecarDirs()
            THIS.this_nTotalProcessados = 0
            THIS.this_nTotalErros       = 0
            loc_nProc = 0
            loc_nErro = 0

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processamento NF-e", loc_nTotal)
            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress.Show()
            ENDIF

            SELECT csOperacoes
            GO TOP
            SCAN FOR SelImp
                THIS.CarregarDoCursor("csOperacoes")

                DO CASE
                    CASE THIS.this_nAcao = 1
                        loc_lOkReg = THIS.ProcessarEnvio()
                    CASE THIS.this_nAcao = 2
                        loc_lOkReg = THIS.ProcessarConsulta()
                    CASE THIS.this_nAcao = 3
                        loc_lOkReg = THIS.ProcessarCancelamento()
                    CASE THIS.this_nAcao = 5
                        loc_lOkReg = THIS.GerarPDF()
                    CASE THIS.this_nAcao = 6
                        loc_lOkReg = THIS.EnviarEmail()
                    CASE THIS.this_nAcao = 7
                        loc_lOkReg = THIS.ConsultarStatus()
                    OTHERWISE
                        loc_lOkReg = .T.
                ENDCASE

                IF loc_lOkReg
                    loc_nProc = loc_nProc + 1
                ELSE
                    loc_nErro = loc_nErro + 1
                ENDIF

                IF VARTYPE(loc_oProgress) = "O"
                    loc_oProgress.SubTitulo.Caption = ;
                        TRANSFORM(loc_nProc + loc_nErro) + " de " + TRANSFORM(loc_nTotal)
                    loc_oProgress.Update(.T.)
                ENDIF

                SELECT csOperacoes
            ENDSCAN

            THIS.this_nTotalProcessados = loc_nProc
            THIS.this_nTotalErros       = loc_nErro

            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress.Complete(.T.)
                loc_oProgress = .NULL.
            ENDIF

            IF loc_nErro = 0
                MsgInfo("Processamento conclu" + CHR(237) + "do." + CHR(13) + ;
                        TRANSFORM(loc_nProc) + " NF(s) processada(s) com sucesso.")
            ELSE
                MsgAviso("Processamento conclu" + CHR(237) + "do." + CHR(13) + ;
                         "Processados: " + TRANSFORM(loc_nProc) + CHR(13) + ;
                         "Com erro: " + TRANSFORM(loc_nErro))
            ENDIF

            loc_lResultado = (loc_nProc > 0)
        CATCH TO loc_oErro
            IF VARTYPE(loc_oProgress) = "O"
                loc_oProgress = .NULL.
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Processamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarEnvio - Grava TXT NF-e na pasta de envio e aguarda retorno SEFAZ
    * O servico transmissor externo (Fortyus/NFeio) assina e envia; retorna
    * o protocolo na pasta de retorno. Retorna .T. se autorizada.
    *==========================================================================
    PROTECTED PROCEDURE ProcessarEnvio()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqTxt, loc_cArqRet
        LOCAL loc_cResposta, loc_nWait
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPathNFe))
                MsgErro("Pasta NF-e n" + CHR(227) + "o configurada." + CHR(13) + ;
                        "Informe o caminho no campo Arquivos.", "Envio NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT TOP 1 nfetxt, nfechv FROM SigMvNfi " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
            IF USED("cursor_4c_NfeTxt")
                USE IN cursor_4c_NfeTxt
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeTxt")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeTxt") > 0
                SELECT cursor_4c_NfeTxt
                GO TOP
                THIS.this_cConteudoTXT = NVL(nfetxt, "")
                THIS.this_cId          = ALLTRIM(NVL(nfechv, ""))
            ENDIF
            IF USED("cursor_4c_NfeTxt")
                USE IN cursor_4c_NfeTxt
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cConteudoTXT))
                MsgErro("Conte" + CHR(250) + "do TXT da NF " + ;
                        ALLTRIM(THIS.this_cNotas) + " n" + CHR(227) + "o encontrado.", "Envio NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqTxt = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt, "txt")
            THIS.this_cArquivoNFe = loc_cArqTxt
            STRTOFILE(ALLTRIM(THIS.this_cConteudoTXT), loc_cArqTxt)

            loc_cArqRet = STRTRAN(loc_cArqTxt, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta = FILETOSTR(loc_cArqRet)
                THIS.this_cProt   = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
                THIS.this_cRecibo = ALLTRIM(STREXTRACT(loc_cResposta, "<nRec>",  "</nRec>",  1))
                THIS.this_cStats  = IIF(!EMPTY(ALLTRIM(THIS.this_cProt)), "100", "900")
                THIS.this_cNfePrt = THIS.this_cProt
                THIS.Atualizar()
                THIS.Inserir()
                SELECT csOperacoes
                REPLACE stats   WITH THIS.this_cStats, ;
                        prots   WITH THIS.this_cProt, ;
                        recibos WITH THIS.this_cRecibo, ;
                        ids     WITH THIS.this_cId
                loc_lResultado = (THIS.this_cStats = "100")
            ELSE
                MsgErro("Tempo esgotado aguardando SEFAZ para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Envio NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Envio")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarConsulta - Consulta situacao da NF-e na SEFAZ via arquivo XML
    *==========================================================================
    PROTECTED PROCEDURE ProcessarConsulta()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqXml, loc_cArqRet
        LOCAL loc_cResposta, loc_nWait, loc_cAmb, loc_cXmlPed
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_NfeSit")
                USE IN cursor_4c_NfeSit
            ENDIF
            loc_cSQL = "SELECT TOP 1 ids, stats, prots FROM sigprnfe " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ;
                       " ORDER BY datas DESC"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeSit")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeSit") > 0
                SELECT cursor_4c_NfeSit
                GO TOP
                THIS.this_cId    = ALLTRIM(NVL(ids, ""))
                THIS.this_cStats = ALLTRIM(NVL(stats, ""))
                THIS.this_cProt  = ALLTRIM(NVL(prots, ""))
            ENDIF
            IF USED("cursor_4c_NfeSit")
                USE IN cursor_4c_NfeSit
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada.", "Consulta NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAmb    = IIF(THIS.this_nAmbiente = 2, "2", "1")
            loc_cXmlPed = '<?xml version="1.0" encoding="UTF-8"?>' + THIS.this_cChr + ;
                          '<consSitNFe versao="4.00">' + THIS.this_cChr + ;
                          '<tpAmb>' + loc_cAmb + '</tpAmb>' + THIS.this_cChr + ;
                          '<xServ>CONSULTAR</xServ>' + THIS.this_cChr + ;
                          '<chNFe>' + THIS.this_cId + '</chNFe>' + THIS.this_cChr + ;
                          '</consSitNFe>'

            loc_cArqXml = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt + "ped-sit", "xml")
            STRTOFILE(loc_cXmlPed, loc_cArqXml)

            loc_cArqRet = STRTRAN(loc_cArqXml, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta    = FILETOSTR(loc_cArqRet)
                THIS.this_cProt  = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
                THIS.this_cStats = IIF(!EMPTY(ALLTRIM(THIS.this_cProt)), "100", "900")
                SELECT csOperacoes
                REPLACE stats WITH THIS.this_cStats, prots WITH THIS.this_cProt
                loc_lResultado = .T.
            ELSE
                MsgErro("Tempo esgotado aguardando consulta para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Consulta NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Consulta")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCancelamento - Cancela NF-e autorizada via arquivo XML
    *==========================================================================
    PROTECTED PROCEDURE ProcessarCancelamento()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArqXml, loc_cArqRet, loc_cResposta, loc_nWait
        LOCAL loc_cAmb, loc_cJust, loc_cXmlCan, loc_cCodStat
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada para cancelamento.", "Cancelamento NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cProt))
                MsgErro("Protocolo n" + CHR(227) + "o encontrado." + CHR(13) + ;
                        "A NF-e deve estar autorizada para ser cancelada.", "Cancelamento NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAmb  = IIF(THIS.this_nAmbiente = 2, "2", "1")
            loc_cJust = "Cancelamento da NF-e conforme solicitado pelo emitente"

            loc_cXmlCan = '<?xml version="1.0" encoding="UTF-8"?>' + THIS.this_cChr + ;
                          '<cancNFe versao="4.00">' + THIS.this_cChr + ;
                          '<infCanc>' + THIS.this_cChr + ;
                          '<tpAmb>' + loc_cAmb + '</tpAmb>' + THIS.this_cChr + ;
                          '<xServ>CANCELAR</xServ>' + THIS.this_cChr + ;
                          '<chNFe>' + THIS.this_cId + '</chNFe>' + THIS.this_cChr + ;
                          '<nProt>' + THIS.this_cProt + '</nProt>' + THIS.this_cChr + ;
                          '<xJust>' + loc_cJust + '</xJust>' + THIS.this_cChr + ;
                          '</infCanc>' + THIS.this_cChr + ;
                          '</cancNFe>'

            loc_cArqXml = THIS.GerarNomeArquivo(THIS.this_cPEnvio, THIS.this_cPTxt + "ped-can", "xml")
            STRTOFILE(loc_cXmlCan, loc_cArqXml)

            loc_cArqRet = STRTRAN(loc_cArqXml, THIS.this_cPEnvio, THIS.this_cPRetorno)
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 60
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqRet)
                loc_cResposta = FILETOSTR(loc_cArqRet)
                loc_cCodStat  = ALLTRIM(STREXTRACT(loc_cResposta, "<cStat>", "</cStat>", 1))
                THIS.this_cStats = IIF(INLIST(loc_cCodStat, "101", "135"), "CAN", "900")
                SELECT csOperacoes
                REPLACE stats WITH THIS.this_cStats
                loc_lResultado = (THIS.this_cStats = "CAN")
            ELSE
                MsgErro("Tempo esgotado aguardando cancelamento para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "Cancelamento NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Cancelamento")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GerarPDF - Verifica/solicita PDF DANFE da NF-e via pasta de PDFs
    *==========================================================================
    PROTECTED PROCEDURE GerarPDF()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cSQL, loc_nRet, loc_cArqPdf, loc_cArqXml, loc_nWait
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada para gerar PDF.", "PDF NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqPdf = THIS.this_cPPdf + THIS.this_cId + "-nfe.pdf"
            IF FILE(loc_cArqPdf)
                THIS.this_cDanfe      = loc_cArqPdf
                THIS.this_cConteudoPDF = FILETOSTR(loc_cArqPdf)
                loc_lResultado = .T.
            ENDIF

            *-- Precisa gerar: busca XML de SigMvNfi e solicita via pasta
            IF EMPTY(ALLTRIM(THIS.this_cConteudoXML))
                loc_cSQL = "SELECT TOP 1 nfexml FROM SigMvNfi WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))
                IF USED("cursor_4c_NfeXml")
                    USE IN cursor_4c_NfeXml
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeXml")
                IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeXml") > 0
                    SELECT cursor_4c_NfeXml
                    GO TOP
                    THIS.this_cConteudoXML = NVL(nfexml, "")
                ENDIF
                IF USED("cursor_4c_NfeXml")
                    USE IN cursor_4c_NfeXml
                ENDIF
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cConteudoXML))
                MsgErro("XML da NF " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrado para gerar PDF.", "PDF NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cArqXml = THIS.this_cPPdf + THIS.this_cId + "-nfe.xml"
            STRTOFILE(ALLTRIM(THIS.this_cConteudoXML), loc_cArqXml)

            loc_nWait = 0
            DO WHILE !FILE(loc_cArqPdf) AND loc_nWait < 30
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF FILE(loc_cArqPdf)
                THIS.this_cDanfe       = loc_cArqPdf
                THIS.this_cConteudoPDF = FILETOSTR(loc_cArqPdf)
                loc_lResultado = .T.
            ELSE
                MsgErro("PDF n" + CHR(227) + "o gerado para NF " + ;
                        ALLTRIM(THIS.this_cNotas) + ".", "PDF NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GerarPDF")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * EnviarEmail - Prepara e envia NF-e por email usando config SMTP de SigCdEmp
    *==========================================================================
    PROTECTED PROCEDURE EnviarEmail()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cXmlFile, loc_cPdfFile, loc_cAssunto
        loc_lResultado = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmailNFe))
                MsgErro("Email NF-e n" + CHR(227) + "o configurado em SigCdEmp." + CHR(13) + ;
                        "Preencha o campo emailnfe.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cId))
                MsgErro("Chave NF-e " + ALLTRIM(THIS.this_cNotas) + ;
                        " n" + CHR(227) + "o encontrada.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cXmlFile = THIS.this_cPAutorizados + THIS.this_cId + "-nfe.xml"
            loc_cPdfFile = THIS.this_cPPdf + THIS.this_cId + "-nfe.pdf"

            IF !FILE(loc_cXmlFile)
                MsgErro("Arquivo XML n" + CHR(227) + "o encontrado: " + CHR(13) + ;
                        loc_cXmlFile, "Email NF-e")
                loc_lResultado = .F.
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cServs)) OR THIS.this_nPortas = 0
                MsgErro("Configura" + CHR(231) + CHR(227) + "o SMTP incompleta em SigCdEmp." + CHR(13) + ;
                        "Preencha servs e portas.", "Email NF-e")
                loc_lResultado = .F.
            ENDIF

            loc_cAssunto = "NF-e " + ALLTRIM(THIS.this_cNotas) + " - " + ALLTRIM(THIS.this_cRazas)

            *-- Parametros SMTP para envio via servico externo (pasta emLote)
            PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha, nPorta
            m.cTo      = ALLTRIM(THIS.this_cEmailNFe)
            m.cAssunto = loc_cAssunto
            m.cAnexo   = loc_cXmlFile + IIF(FILE(loc_cPdfFile), ";" + loc_cPdfFile, "")
            m.cCorpo   = IIF(EMPTY(ALLTRIM(THIS.this_cTextoNFe)), ;
                             "Segue em anexo a NF-e " + ALLTRIM(THIS.this_cNotas) + ".", ;
                             ALLTRIM(THIS.this_cTextoNFe))
            m.cFrom    = ALLTRIM(THIS.this_cEmailNFe)
            m.cCC      = ALLTRIM(THIS.this_cEmailNFe)
            m.cServer  = ALLTRIM(THIS.this_cServs)
            m.cSenha   = ALLTRIM(THIS.this_cSenhas)
            m.nPorta   = THIS.this_nPortas

            *-- Grava arquivo de controle na pasta emLote para o servico transmissor
            LOCAL loc_cArqEmail
            loc_cArqEmail = THIS.this_cPEnvioEmLote + THIS.this_cId + "-email.txt"
            STRTOFILE(m.cTo + "|" + m.cAssunto + "|" + m.cAnexo + "|" + m.cFrom, loc_cArqEmail)

            SELECT csOperacoes
            REPLACE statts WITH "E"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Email")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConsultarStatus - Le status atual da NF-e em sigprnfe e atualiza csOperacoes
    *==========================================================================
    PROTECTED PROCEDURE ConsultarStatus()
        LOCAL loc_lResultado, loc_oErro, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_NfeStatus")
                USE IN cursor_4c_NfeStatus
            ENDIF
            loc_cSQL = "SELECT TOP 1 ids, stats, prots, lotes, recibos FROM sigprnfe " + ;
                       "WHERE empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ;
                       " ORDER BY datas DESC"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NfeStatus")
            IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_NfeStatus") > 0
                SELECT cursor_4c_NfeStatus
                GO TOP
                THIS.this_cId     = ALLTRIM(NVL(ids,     ""))
                THIS.this_cStats  = ALLTRIM(NVL(stats,   ""))
                THIS.this_cProt   = ALLTRIM(NVL(prots,   ""))
                THIS.this_cLote   = ALLTRIM(NVL(lotes,   ""))
                THIS.this_cRecibo = ALLTRIM(NVL(recibos, ""))
                SELECT csOperacoes
                REPLACE stats   WITH THIS.this_cStats, ;
                        prots   WITH THIS.this_cProt, ;
                        lotes   WITH THIS.this_cLote, ;
                        recibos WITH THIS.this_cRecibo, ;
                        ids     WITH THIS.this_cId
                loc_lResultado = .T.
            ELSE
                MsgAviso("NF " + ALLTRIM(THIS.this_cNotas) + ;
                         " n" + CHR(227) + "o encontrada em sigprnfe.")
            ENDIF
            IF USED("cursor_4c_NfeStatus")
                USE IN cursor_4c_NfeStatus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConsultarStatus")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ImprimirSimplificado - Imprime relatorio listagem NF-es em csOperacoes
    * par_cCursorDados: cursor com os registros (default: "csOperacoes")
    *==========================================================================
    PROCEDURE ImprimirSimplificado(par_cCursorDados)
        LOCAL loc_lResultado, loc_oErro, loc_cCursor, loc_cFrx
        LOCAL loc_cPointAnt, loc_cSepAnt, loc_nBehavAnt
        loc_lResultado = .F.
        TRY
            loc_cCursor = IIF(PCOUNT() >= 1 AND !EMPTY(par_cCursorDados), ;
                              par_cCursorDados, "csOperacoes")
            loc_cFrx = gc_4c_CaminhoReports + "sigprnfe.frx"

            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum registro para impress" + CHR(227) + "o.")
                loc_lResultado = .F.
            ENDIF
            IF !FILE(loc_cFrx)
                MsgErro("Relat" + CHR(243) + "rio sigprnfe.frx n" + CHR(227) + ;
                        "o encontrado em:" + CHR(13) + gc_4c_CaminhoReports, ;
                        "Impress" + CHR(227) + "o Simplificada")
                loc_lResultado = .F.
            ENDIF

            loc_cPointAnt = SET("POINT")
            loc_cSepAnt   = SET("SEPARATOR")
            loc_nBehavAnt = SET("REPORTBEHAVIOR")
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            TRY
                SELECT (loc_cCursor)
                GO TOP
                REPORT FORM (loc_cFrx) PREVIEW
                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro ao imprimir")
            ENDTRY

            SET POINT TO (loc_cPointAnt)
            SET SEPARATOR TO (loc_cSepAnt)
            SET REPORTBEHAVIOR (loc_nBehavAnt)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ImprimirSimplificado")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CodIBGEUF - Retorna codigo IBGE da UF a partir de SigCdUfs
    * par_cEstas: sigla UF (char 2, ex: "BA")
    * Retorna: codigo IBGE numerico, 0 em caso de erro
    *==========================================================================
    PROCEDURE CodIBGEUF(par_cEstas)
        LOCAL loc_nRet, loc_nSql, loc_oErro
        loc_nRet = 0
        TRY
            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF
            loc_nSql = SQLEXEC(gnConnHandle, ;
                "SELECT UFIBGEs FROM SigCdUfs WHERE Estados = '" + ;
                PADR(ALLTRIM(par_cEstas), 2) + "'", "cursor_4c_LocalUF")
            IF loc_nSql >= 1 AND USED("cursor_4c_LocalUF")
                SELECT cursor_4c_LocalUF
                GO TOP
                IF !EOF()
                    loc_nRet = cursor_4c_LocalUF.UFIBGEs
                ENDIF
            ENDIF
            IF USED("cursor_4c_LocalUF")
                USE IN cursor_4c_LocalUF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CodIBGEUF")
        ENDTRY
        RETURN loc_nRet
    ENDPROC

    *==========================================================================
    * SelecionarInutilizadas - Popula cursor nfAinu com candidatos a inutilizacao
    * Identifica gaps na numeracao NF-e (entre notas EMI e INU em sigprnfe)
    * par_cEmps: empresa filtro (char 3) - para contexto de log
    * Retorna .T. se cursor nfAinu criado com sucesso (pode estar vazio)
    *==========================================================================
    PROCEDURE SelecionarInutilizadas(par_cEmps)
        LOCAL loc_lResultado, loc_oErro, loc_nRet
        LOCAL loc_lcCnpj, loc_lcSeries, loc_lnNotaInu
        loc_lResultado = .F.
        TRY
            *-- Cria cursor nfAinu com schema correto (WHERE stats='xxx' retorna vazio)
            IF USED("nfAinu")
                USE IN nfAinu
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT DISTINCT emps, SUBSTRING(ids,7,14) AS cnpj, " + ;
                "SUBSTRING(ids,23,3) AS series, " + ;
                "SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf " + ;
                "FROM sigprnfe WHERE stats = 'xxx'", "nfAinu")
            IF loc_nRet < 1
                MsgErro("Falha ao inicializar cursor de inutiliza" + CHR(231) + ;
                        CHR(227) + "o.", "SelecionarInutilizadas")
            ELSE
                *-- Carrega notas usadas (EMI e INU) para analise de gaps
                IF USED("cursor_4c_NfUsadas")
                    USE IN cursor_4c_NfUsadas
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT emps, SUBSTRING(ids,7,14) AS cnpj, " + ;
                    "SUBSTRING(ids,23,3) AS series, " + ;
                    "SUBSTRING(ids,26,9) AS notai, SUBSTRING(ids,26,9) AS notaf " + ;
                    "FROM sigprnfe WHERE stats = 'EMI' AND SUBSTRING(ids,26,9) <> '' " + ;
                    "UNION " + ;
                    "SELECT DISTINCT emps, SUBSTRING(ids,5,14) AS cnpj, " + ;
                    "SUBSTRING(ids,21,3) AS series, " + ;
                    "SUBSTRING(ids,24,9) AS notai, SUBSTRING(ids,33,9) AS notaf " + ;
                    "FROM sigprnfe WHERE stats = 'INU' AND SUBSTRING(ids,24,9) <> '' " + ;
                    "ORDER BY 1,2,4,5", "cursor_4c_NfUsadas")

                IF loc_nRet >= 1 AND USED("cursor_4c_NfUsadas")
                    *-- Filtra CNPJs validos e ordena
                    IF USED("cursor_4c_NfUsadas1")
                        USE IN cursor_4c_NfUsadas1
                    ENDIF
                    SELECT * FROM cursor_4c_NfUsadas ;
                        WHERE RTRIM(cnpj) != '' ;
                        ORDER BY cnpj, series, notai ;
                        INTO CURSOR cursor_4c_NfUsadas1

                    *-- Gap analysis: identifica numeros nao usados entre notas emitidas
                    loc_lnNotaInu = 1
                    SELECT cursor_4c_NfUsadas1
                    GO TOP
                    IF !EOF()
                        loc_lcCnpj   = ALLTRIM(cursor_4c_NfUsadas1.cnpj)
                        loc_lcSeries = ALLTRIM(cursor_4c_NfUsadas1.series)
                        DO WHILE !EOF("cursor_4c_NfUsadas1")
                            DO WHILE !EOF("cursor_4c_NfUsadas1") .AND. ;
                                     ALLTRIM(cursor_4c_NfUsadas1.cnpj)   = loc_lcCnpj .AND. ;
                                     ALLTRIM(cursor_4c_NfUsadas1.series) = loc_lcSeries
                                IF loc_lnNotaInu < VAL(ALLTRIM(cursor_4c_NfUsadas1.notai))
                                    SELECT nfAinu
                                    APPEND BLANK
                                    REPLACE notai WITH PADL(ALLTRIM(STR(loc_lnNotaInu)), 8, "0")
                                    DO WHILE loc_lnNotaInu < VAL(ALLTRIM(cursor_4c_NfUsadas1.notai))
                                        REPLACE emps   WITH cursor_4c_NfUsadas1.emps, ;
                                                cnpj   WITH cursor_4c_NfUsadas1.cnpj, ;
                                                series WITH cursor_4c_NfUsadas1.series, ;
                                                notaf  WITH PADL(ALLTRIM(STR(loc_lnNotaInu)), 8, "0")
                                        loc_lnNotaInu = loc_lnNotaInu + 1
                                    ENDDO
                                    SELECT cursor_4c_NfUsadas1
                                ENDIF
                                loc_lnNotaInu = VAL(ALLTRIM(cursor_4c_NfUsadas1.notaf)) + 1
                                EXIT
                            ENDDO
                            IF !EOF("cursor_4c_NfUsadas1") .AND. ;
                               (ALLTRIM(cursor_4c_NfUsadas1.cnpj)   != loc_lcCnpj .OR. ;
                                ALLTRIM(cursor_4c_NfUsadas1.series) != loc_lcSeries)
                                loc_lcCnpj   = ALLTRIM(cursor_4c_NfUsadas1.cnpj)
                                loc_lcSeries = ALLTRIM(cursor_4c_NfUsadas1.series)
                                loc_lnNotaInu = 1
                                LOOP
                            ENDIF
                            SELECT cursor_4c_NfUsadas1
                            IF !EOF()
                                SKIP
                            ENDIF
                        ENDDO
                    ENDIF
                    IF USED("cursor_4c_NfUsadas1")
                        USE IN cursor_4c_NfUsadas1
                    ENDIF
                ENDIF
                IF USED("cursor_4c_NfUsadas")
                    USE IN cursor_4c_NfUsadas
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SelecionarInutilizadas")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessaInutilizadas - Executa inutilizacao de numeracao NF-e/NFC-e
    * par_cEmps  : codigo empresa (char 3)
    * par_cSeries: serie (char 3 - ex: "001")
    * par_cCnpj  : CNPJ sem mascara (14 chars)
    * par_cNIni  : numero inicial (ex: "00000001")
    * par_cNFim  : numero final   (ex: "00000005")
    * Retorna .T. se inutilizacao aprovada pela SEFAZ (cStat = 102)
    *==========================================================================
    PROCEDURE ProcessaInutilizadas(par_cEmps, par_cSeries, par_cCnpj, par_cNIni, par_cNFim)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cAmb, loc_cMod, loc_cUf, loc_cAno, loc_cData
        LOCAL loc_cSer, loc_cNIni, loc_cNFim, loc_cId, loc_cXmlInu
        LOCAL loc_cArqXml, loc_cArqRet, loc_cResposta, loc_nWait
        LOCAL loc_cCodStat, loc_cCampo, loc_cProt, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            *-- Carrega dados da empresa e configura caminhos NF-e
            IF !THIS.CarregarEmpresa(ALLTRIM(par_cEmps))
                loc_lResultado = .F.
            ENDIF
            THIS.ChecarDirs()

            IF EMPTY(ALLTRIM(THIS.this_cPEnvio))
                MsgErro("Pasta NF-e n" + CHR(227) + "o configurada para empresa " + ;
                        ALLTRIM(par_cEmps) + ". Configure o campo Pastas em SigCdEmp.", ;
                        "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            IF EMPTY(ALLTRIM(par_cCnpj))
                MsgErro("CNPJ n" + CHR(227) + "o informado para inutiliza" + ;
                        CHR(231) + CHR(227) + "o.", "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            *-- Parametros basicos do XML
            loc_cAmb  = IIF(THIS.this_nAmbiente = 2, "2", "1")
            loc_cMod  = IIF(THIS.this_nAcao = 7, "65", "55")  && NFC-e=65, NF-e=55
            loc_cUf   = ALLTRIM(STR(THIS.CodIBGEUF(THIS.this_cEstas)))
            loc_cAno  = SUBSTR(DTOS(DATE()), 3, 2)
            loc_cData = DTOS(DATE())

            *-- Formata serie e numeros no padrao XML NF-e
            loc_cSer  = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cSeries)), "@R 999"))
            loc_cNIni = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cNIni)), "@R 999999999"))
            loc_cNFim = ALLTRIM(TRANSFORM(VAL(ALLTRIM(par_cNFim)), "@R 999999999"))

            *-- Chave de identificacao: cUF+AA+CNPJ+mod+serie+nIni+nFim
            loc_cId = loc_cUf + loc_cAno + ALLTRIM(par_cCnpj) + loc_cMod + ;
                      PADR(ALLTRIM(par_cSeries), 3) + ;
                      PADL(ALLTRIM(par_cNIni), 9, "0") + ;
                      PADL(ALLTRIM(par_cNFim), 9, "0")

            *-- Monta XML de inutilizacao conforme layout NF-e 4.00
            loc_cXmlInu = '<?xml version="1.0" encoding="UTF-8"?>' + THIS.this_cChr + ;
                '<inutNFe versao="4.00" xmlns="http://www.portalfiscal.inf.br/nfe">' + THIS.this_cChr + ;
                '<infInut Id="ID' + loc_cId + '">' + THIS.this_cChr + ;
                '<tpAmb>' + loc_cAmb + '</tpAmb>' + THIS.this_cChr + ;
                '<xServ>INUTILIZAR</xServ>' + THIS.this_cChr + ;
                '<cUF>' + loc_cUf + '</cUF>' + THIS.this_cChr + ;
                '<ano>' + loc_cAno + '</ano>' + THIS.this_cChr + ;
                '<CNPJ>' + ALLTRIM(par_cCnpj) + '</CNPJ>' + THIS.this_cChr + ;
                '<mod>' + loc_cMod + '</mod>' + THIS.this_cChr + ;
                '<serie>' + loc_cSer + '</serie>' + THIS.this_cChr + ;
                '<nNFIni>' + loc_cNIni + '</nNFIni>' + THIS.this_cChr + ;
                '<nNFFin>' + loc_cNFim + '</nNFFin>' + THIS.this_cChr + ;
                '<xJust>Ocorreu uma falha no sistema que pulou a sequencia de numeracao</xJust>' + THIS.this_cChr + ;
                '</infInut>' + THIS.this_cChr + ;
                '</inutNFe>'

            *-- Grava XML na pasta envio/ para o UniNFe assinar e transmitir
            loc_cArqXml = THIS.this_cPEnvio + loc_cId + "-ped-inu.XML"
            IF FILE(loc_cArqXml)
                DELETE FILE (loc_cArqXml)
            ENDIF
            STRTOFILE(loc_cXmlInu, loc_cArqXml)

            *-- Aguarda retorno SEFAZ na pasta retorno/ (timeout 180s)
            loc_cArqRet = THIS.this_cPRetorno + loc_cId + "-inu.XML"
            loc_nWait = 0
            DO WHILE !FILE(loc_cArqRet) AND loc_nWait < 180
                INKEY(1)
                loc_nWait = loc_nWait + 1
            ENDDO

            IF !FILE(loc_cArqRet)
                MsgErro("Tempo esgotado aguardando retorno SEFAZ." + CHR(13) + ;
                        "Verifique se o UniNFe est" + CHR(225) + " ativo.", "Inutilizar NF-e")
                loc_lResultado = .F.
            ENDIF

            *-- Processa XML de retorno
            loc_cResposta = FILETOSTR(loc_cArqRet)
            loc_cCodStat  = ALLTRIM(STREXTRACT(loc_cResposta, "<cStat>", "</cStat>", 1))
            loc_cCampo    = ALLTRIM(STREXTRACT(loc_cResposta, "<xMotivo>", "</xMotivo>", 1))
            loc_cProt     = ALLTRIM(STREXTRACT(loc_cResposta, "<nProt>", "</nProt>", 1))
            DELETE FILE (loc_cArqRet)

            IF "102" $ loc_cCodStat
                *-- Aprovada: registra inutilizacao em sigprnfe
                loc_cSQL = "INSERT INTO sigprnfe " + ;
                           "(cidchaves, empdopnums, emps, dopes, numes, datas, usuars, " + ;
                           " ids, lotes, recibos, prots, stats) " + ;
                           "VALUES (" + ;
                           EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
                           EscaparSQL(LEFT(PADR(ALLTRIM(par_cEmps),3) + ;
                               "INUTILIZACAO" + PADL(ALLTRIM(par_cNIni), 6), 29)) + ", " + ;
                           EscaparSQL(LEFT(PADR(ALLTRIM(par_cEmps), 3), 3)) + ", " + ;
                           "'INUTILIZACAO', " + ;
                           FormatarNumeroSQL(VAL(ALLTRIM(par_cNIni)), 0) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(loc_cId), 47)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNIni), 15)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNFim), 15)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(loc_cProt), 15)) + ", " + ;
                           "'INU'" + ;
                           ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet >= 1
                    MsgInfo("Inutiliza" + CHR(231) + CHR(227) + "o aprovada." + CHR(13) + ;
                            STRCONV(loc_cCampo, 11))
                    loc_lResultado = .T.
                ELSE
                    MsgErro("SEFAZ aprovou mas falha ao registrar em sigprnfe.", "Inutilizar NF-e")
                ENDIF
            ELSE
                MsgErro("Inutiliza" + CHR(231) + CHR(227) + "o rejeitada." + CHR(13) + ;
                        "C" + CHR(243) + "d.: " + loc_cCodStat + CHR(13) + ;
                        STRCONV(loc_cCampo, 11), "Inutilizar NF-e")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ProcessaInutilizadas")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
