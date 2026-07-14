*------------------------------------------------------------------------------
* sigopdivBO.prg - Business Object para Separacao de Industrializacao
* Form OPERACIONAL: Divide/Reinicia Ordens de Producao (SigOpPic)
* Tabelas principais: SigOpPic, SigCdNec, SigCdNei, SigPdMvf, SigCdOpd
*------------------------------------------------------------------------------
DEFINE CLASS sigopdivBO AS BusinessBase

    *-- Tabela e chave
    this_cTabela          = "SigOpPic"
    this_cCampoChave      = "CidChaves"

    *-- Estado da operacao
    this_cOperacao        = ""       && 'D'=Divisao, 'R'=Reinicia
    this_cEmps            = ""       && Empresa corrente
    this_cDivisaoop       = " "      && Dopps da nova OP gerada
    this_cSigKey          = ""       && SigKeys de SigCdPac
    this_lAutomatico      = .F.      && Modo automatico
    this_lEnvelopado      = .F.      && OP envelopada
    this_nEnvelope        = 0        && Numero do envelope
    this_lTransacaoAberta = .F.      && Flag de transacao aberta no SQL Server

    *-- Parametros de configuracao (SigCdPam)
    this_cDivOps          = ""       && Operacao de divisao configurada
    this_cDoppPads        = ""       && DoppPads de SigCdPam
    this_cDoppServs       = ""       && DoppServs de SigCdPam

    *-- OP sendo processada (campos de SigOpPic)
    this_nNops            = 0        && Numero da OP (Nops)
    this_nNumps           = 0        && Numps (Int(Nops/10000))
    this_cDopps           = ""       && Dopps da OP original
    this_cDopes           = ""       && Dopes (pedido)
    this_nNumes           = 0        && Numes (item do pedido)
    this_cCpros           = ""       && Codigo do produto (Cpros)
    this_cDpros           = ""       && Descricao do produto (Dpros)
    this_nQtds            = 0        && Quantidade da OP (Qtds)
    this_nPesos           = 0        && Peso da OP (Pesos)
    this_cCodCors         = ""       && Codigo da cor (CodCors)
    this_cCodTams         = ""       && Codigo do tamanho (CodTams)
    this_cEmpds           = ""       && Empresa destino (Empds)
    this_cNotas           = ""       && Nota fiscal (Notas)
    this_cContas          = ""       && Conta (Contas)
    this_nCitens          = 0        && Sequencia do item (Citens)
    this_nSeqDivs         = 0        && Sequencia de divisao (SeqDivs)
    this_nNopMaes         = 0        && OP mae (NopMaes)
    this_cObss            = ""       && Observacao (Obss)
    this_cCidChaves       = ""       && Chave unica (CidChaves)
    this_cEmpDopNums      = ""       && Chave composta (EmpDopNums)
    this_cEmpDNps         = ""       && Chave composta (EmpDNps)
    this_cEmpDopNops      = ""       && Chave composta (EmpDopNops)
    this_lDivs            = .F.      && Flag OP dividida (Divs - BIT)
    this_nQtdCpnts        = 0        && Quantidade de componentes (QtdCpnts)
    this_dDataes          = {}       && Data da OP (Dataes)

    *-- Configuracao da operacao de divisao (SigCdOpd)
    this_cGruOrigs        = ""       && Grupo origem (GruOrigs)
    this_cConOrigs        = ""       && Conta origem (ConOrigs)
    this_cGruDests        = ""       && Grupo destino (GruDests)
    this_cConDests        = ""       && Conta destino (ConDests)
    this_lChkDests        = .F.      && Flag destino (ChkDests - BIT)
    this_lEnvelopes       = .F.      && Flag envelope (Envelopes - BIT)
    this_cTpPadraos       = ""       && Tipo padrao (TpPadraos)
    this_lAutos           = .F.      && Automatico (Autos - BIT)

    *-- Produto carregado para exibicao
    this_cProduto         = ""       && Descricao do produto para Get_Produto

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "CidChaves"
            THIS.this_cEmps       = go_4c_Sistema.cCodEmpresa

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigOpPic
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_nNumps     = TratarNulo(Numps,     "N")
                THIS.this_cDopps     = TratarNulo(Dopps,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_cDpros     = TratarNulo(Dpros,     "C")
                THIS.this_nQtds      = TratarNulo(Qtds,      "N")
                THIS.this_nPesos     = TratarNulo(Pesos,     "N")
                THIS.this_cCodCors   = TratarNulo(CodCors,   "C")
                THIS.this_cCodTams   = TratarNulo(CodTams,   "C")
                THIS.this_cEmpds     = TratarNulo(Empds,     "C")
                THIS.this_cNotas     = TratarNulo(Notas,     "C")
                THIS.this_nCitens    = TratarNulo(Citens,    "N")
                THIS.this_nSeqDivs   = TratarNulo(SeqDivs,   "N")
                THIS.this_nNopMaes   = TratarNulo(NopMaes,   "N")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_lDivs      = NVL(Divs, .F.)
                THIS.this_nQtdCpnts  = TratarNulo(QtdCpnts, "N")
                IF TYPE("Dataes") = "D" OR TYPE("Dataes") = "T"
                    THIS.this_dDataes = IIF(EMPTY(Dataes), DATE(), CTOD(DTOC(Dataes)))
                ENDIF
                THIS.this_cObss      = NVL(Obss, "")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cEmpDNps   = TratarNulo(EmpDNps,   "C")
                THIS.this_cEmpDopNops = TratarNulo(EmpDopNops, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigOpPic via SQLEXEC
    * Usado para persistir uma OP individual gerada no processo de divisao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpPic (" + ;
                       "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                       "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                       "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, Pesos, " + ;
                       "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cDivisaoop) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqDivs) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopMaes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCpnts) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDNps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNops) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       EscaparSQL(THIS.this_cNotas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCitens) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos) + ", " + ;
                       "' ', 0, 0, 0, 0, '   ', 0, 0, '')"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigOpPic via SQLEXEC
    * Atualiza quantidade, divisao, usuario e peso do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpPic SET " + ;
                       "Qtds = "     + FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       "SeqDivs = "  + FormatarNumeroSQL(THIS.this_nSeqDivs) + ", " + ;
                       "Divs = "     + IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                       "Imprs = 0, " + ;
                       "Usuars = "   + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "Pesos = "    + FormatarNumeroSQL(THIS.this_nPesos) + ", " + ;
                       "QtdCpnts = " + FormatarNumeroSQL(THIS.this_nQtdCpnts) + " " + ;
                       "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("U")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOP - Carrega OP para divisao/reiniciacao (logica de Get_OP.Valid)
    * Popula os cursores Temp_DivOp e xNensi para uso no grid
    * Retorna: .T. se OP valida e carregada, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOP(par_nNop)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nPNop, loc_lcEdn, loc_lcBusca, loc_lChkSubn
        LOCAL loc_lBlqDivOps, loc_nCitem, loc_lcConta, loc_cChaveNensi

        loc_lSucesso = .F.
        loc_nCitem   = 1

        TRY
            *-- Limpar cursores de trabalho
            IF USED("Temp_DivOp")
                SELECT Temp_DivOp
                ZAP
            ENDIF
            IF USED("xNensi")
                SELECT xNensi
                ZAP
            ENDIF
            IF USED("Temporario")
                SELECT Temporario
                ZAP
            ENDIF

            IF par_nNop <= 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPNop = par_nNop

            *-- Verificar envelope: SigCdOpd WHERE ChkDests = 1
            loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE ChkDests = 1"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp") > 0
                SELECT cursor_4c_TmpOpp
                IF RECCOUNT() > 0
                    GO TOP
                    loc_lcBusca = THIS.this_cEmps + ALLTRIM(cursor_4c_TmpOpp.Dopps) + STR(loc_nPNop, 10)
                    loc_cSQL = "SELECT Nops, Numps FROM SigPdMvf WHERE EmpDnPs = " + EscaparSQL(loc_lcBusca)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas") > 0
                        SELECT cursor_4c_TmpMfas
                        IF RECCOUNT() > 0
                            GO TOP
                            loc_nPNop = cursor_4c_TmpMfas.Nops
                            THIS.this_lEnvelopado = .T.
                            THIS.this_nEnvelope   = cursor_4c_TmpMfas.Numps
                        ELSE
                            loc_cSQL = "SELECT Nops, NumPs FROM SigPdMvf " + ;
                                       "WHERE Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                                       " AND Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_TmpOpp.Dopps))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas2") > 0
                                SELECT cursor_4c_TmpMfas2
                                IF RECCOUNT() > 0
                                    GO TOP
                                    THIS.this_lEnvelopado = .T.
                                    THIS.this_nEnvelope   = cursor_4c_TmpMfas2.Numps
                                ENDIF
                                USE IN cursor_4c_TmpMfas2
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpOpp
            ENDIF

            *-- Carregar TmpOpi: SigOpPic WHERE Nops = pNop
            loc_cSQL = "SELECT TOP 1 Nops, Emps, Dopps, CodBarras FROM SigOpPic " + ;
                       "WHERE Nops = " + FormatarNumeroSQL(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") <= 0
                MsgErro("Falha na consulta de OP: " + TRANSFORM(loc_nPNop), "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TmpOpi
            IF RECCOUNT() = 0
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                USE IN cursor_4c_TmpOpi
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(cursor_4c_TmpOpi.Emps) <> ALLTRIM(THIS.this_cEmps)
                MsgErro("Op " + TRANSFORM(loc_nPNop) + " " + CHR(233) + " de outra empresa " + ;
                        ALLTRIM(cursor_4c_TmpOpi.Emps), "Erro")
                USE IN cursor_4c_TmpOpi
                loc_lSucesso = .F.
            ENDIF
            loc_lcEdn = ALLTRIM(cursor_4c_TmpOpi.Emps) + ALLTRIM(cursor_4c_TmpOpi.Dopps) + ;
                        STR(cursor_4c_TmpOpi.Nops, 10)
            THIS.this_cDivisaoop = ALLTRIM(cursor_4c_TmpOpi.Dopps)
            THIS.this_nNops      = loc_nPNop
            USE IN cursor_4c_TmpOpi

            *-- Verificar status (ChkSubn = encerrada) em SigCdNec
            loc_cSQL = "SELECT TOP 1 ChkSubn FROM SigCdNec WHERE EmpDnPs = " + EscaparSQL(loc_lcEdn)
            loc_lChkSubn = .F.
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpNens") > 0
                SELECT cursor_4c_TmpNens
                IF RECCOUNT() = 0
                    USE IN cursor_4c_TmpNens
                    MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
                GO TOP
                loc_lChkSubn = NVL(cursor_4c_TmpNens.ChkSubn, .F.)
                USE IN cursor_4c_TmpNens
            ENDIF
            IF loc_lChkSubn
                MsgAviso("O.P. j" + CHR(225) + " foi encerrada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Carregar LocalMfas: SigPdMvf WHERE Nops = pNop
            loc_cSQL = "SELECT Nops, Emps, Dopps, Numps, cIdChaves, Grupods, " + ;
                       "Contads, Grupoos, Contaos, Qtds, Pesos, Nenvs, Ordems, Datars, Datas, EmpDnPs " + ;
                       "FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfas") <= 0
                MsgErro("Falha na consulta de fases da OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfas
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfas
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Verificar bloqueio de divisao (SigCdGcr.BlqDivOps)
            loc_lBlqDivOps = .F.
            IF !EMPTY(ALLTRIM(cursor_4c_LocalMfas.Grupods))
                loc_cSQL = "SELECT TOP 1 BlqDivOps FROM SigCdGcr"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGccr") > 0
                    SELECT cursor_4c_TmpGccr
                    IF RECCOUNT() > 0
                        GO TOP
                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                        ELSE
                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                            ELSE
                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                ELSE
                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                    ELSE
                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                        ELSE
                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                            ELSE
                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                ELSE
                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                    ELSE
                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                        ELSE
                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                            ELSE
                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                ELSE
                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                    ELSE
                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                        ELSE
                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                            ELSE
                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                ELSE
                                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                    ELSE
                                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                        ELSE
                                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                            ELSE
                                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                ELSE
                                                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                    ELSE
                                                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                        ELSE
                                                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                            ELSE
                                                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                        loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                            loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                                loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(cursor_4c_TmpGccr.BlqDivOps) = "L"
                                                                                                                                                                    loc_lBlqDivOps = cursor_4c_TmpGccr.BlqDivOps
                                                                                                                                                                ELSE
                                                                                                                                                                    loc_lBlqDivOps = (NVL(cursor_4c_TmpGccr.BlqDivOps, 0) = 1)
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_TmpGccr
                ENDIF
            ENDIF
            IF loc_lBlqDivOps
                USE IN cursor_4c_LocalMfas
                MsgAviso("Setor Bloqueado para Divis" + CHR(227) + "o de Op!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            USE IN cursor_4c_LocalMfas

            *-- Carregar LocalOpi: SigOpPic WHERE Nops = pNop (todos os itens)
            loc_cSQL = "SELECT CidChaves, Dopes, Numes, Qtds, Dataes, Obss, SeqDivs, Cpros, " + ;
                       "CodCors, CodTams, Empds, Dpros, Notas, Citens, Pesos, CodBarras, EmpDopNums " + ;
                       "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi") <= 0
                MsgErro("Falha na consulta detalhada da OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalOpi
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalOpi
                MsgAviso("O.P. n" + CHR(227) + "o localizada!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            GO TOP
            IF NVL(cursor_4c_LocalOpi.CodBarras, 0) > 0
                USE IN cursor_4c_LocalOpi
                MsgAviso("Op de Servi" + CHR(231) + "o com Barra n" + CHR(227) + "o pode ser Dividido!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Set produto para exibicao
            THIS.this_cProduto = ALLTRIM(cursor_4c_LocalOpi.Cpros)

            *-- Para cada item: buscar conta e inserir em Temp_DivOp
            SELECT cursor_4c_LocalOpi
            GO TOP
            DO WHILE !EOF()
                loc_cSQL = "SELECT a.ContaOs, a.ContaDs, b.Globalizas, b.Servicos " + ;
                           "FROM SigMvCab a INNER JOIN SigCdOpe b ON a.Dopes = b.dopes " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_LocalOpi.EmpDopNums))
                loc_lcConta = ""
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") > 0
                    SELECT cursor_4c_LocalEest
                    IF RECCOUNT() > 0
                        GO TOP
                        IF NVL(cursor_4c_LocalEest.Globalizas, 0) = 1 OR ;
                           NVL(cursor_4c_LocalEest.Servicos,   0) = 1
                            loc_lcConta = ALLTRIM(cursor_4c_LocalEest.ContaOs)
                        ELSE
                            loc_lcConta = ALLTRIM(cursor_4c_LocalEest.ContaDs)
                        ENDIF
                    ENDIF
                    USE IN cursor_4c_LocalEest
                ENDIF

                *-- UPDATE SeqDivs no SigOpPic
                loc_cSQL = "UPDATE SigOpPic SET SeqDivs = " + FormatarNumeroSQL(loc_nCitem) + ;
                           " WHERE CidChaves = " + EscaparSQL(ALLTRIM(cursor_4c_LocalOpi.CidChaves))
                SQLEXEC(gnConnHandle, loc_cSQL)

                *-- INSERT INTO Temp_DivOp
                SET NULL ON
                INSERT INTO Temp_DivOp ;
                    (Dopes, Numes, Qtds, Dataes, Obss, SeqDivs, Cpros, CodCors, ;
                     CodTams, Empds, Dpros, Notas, Contas, Citens, Pesos) ;
                    VALUES (cursor_4c_LocalOpi.Dopes, cursor_4c_LocalOpi.Numes, ;
                            cursor_4c_LocalOpi.Qtds, cursor_4c_LocalOpi.Dataes, ;
                            cursor_4c_LocalOpi.Obss, loc_nCitem, ;
                            cursor_4c_LocalOpi.Cpros, cursor_4c_LocalOpi.CodCors, ;
                            cursor_4c_LocalOpi.CodTams, cursor_4c_LocalOpi.Empds, ;
                            cursor_4c_LocalOpi.Dpros, cursor_4c_LocalOpi.Notas, ;
                            loc_lcConta, cursor_4c_LocalOpi.Citens, cursor_4c_LocalOpi.Pesos)
                SET NULL OFF

                loc_nCitem = loc_nCitem + 1
                SELECT cursor_4c_LocalOpi
                SKIP
            ENDDO
            USE IN cursor_4c_LocalOpi

            *-- Carregar xNensi: SigCdNei via join com SigCdNec e SigCdOpd
            loc_cSQL = "SELECT a.*, b.Datas, c.SepPedras, c.GrComps " + ;
                       "FROM SigCdNei a " + ;
                       "INNER JOIN SigCdNec b ON a.Empdnps = b.EmpDnps " + ;
                       "INNER JOIN SigCdOpd c ON a.Dopps = c.Dopps " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nPNop) + ;
                       " ORDER BY b.Datas DESC, b.EmpDnPs DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNensi") > 0
                SELECT cursor_4c_LocalNensi
                IF RECCOUNT() > 0
                    GO TOP
                    *-- Verificar SepPedras/GrComps: avancar ate condicao valida
                    DO WHILE !EOF()
                        IF (NOT INLIST(NVL(cursor_4c_LocalNensi.SepPedras, 0), 1, 3)) AND ;
                           (NVL(cursor_4c_LocalNensi.GrComps, 0) = 1)
                            EXIT
                        ENDIF
                        SKIP
                    ENDDO
                    *-- Copiar grupo com mesmo EmpDnPs para xNensi
                    IF !EOF()
                        loc_cChaveNensi = ALLTRIM(cursor_4c_LocalNensi.EmpDnPs)
                        IF USED("xNensi")
                            loc_cSQL = "SELECT * FROM SigCdNei WHERE EmpDnPs = " + ;
                                       EscaparSQL(loc_cChaveNensi)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiSrc") > 0
                                SELECT xNensi
                                ZAP
                                APPEND FROM DBF("cursor_4c_NensiSrc")
                                USE IN cursor_4c_NensiSrc
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                USE IN cursor_4c_LocalNensi
            ENDIF

            SELECT Temp_DivOp
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovaOP - Gera nova OP por divisao ('D') ou reinicio ('R')
    * Abre transacao SQL Server, executa operacao, aguarda ConfirmarGravacao
    * par_cOperacao: 'D'=Divisao, 'R'=Reinicia
    * par_nNop: numero da OP sendo processada
    * par_nQtds: soma total de Qtds em Temp_DivOp
    * par_nQtdDivs: soma total de QtdDivs em Temp_DivOp
    * par_nQtdEtiqs: soma total de QtdEtiqs em Temp_DivOp
    * Retorna: .T. se operacao iniciada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovaOP(par_cOperacao, par_nNop, par_nQtds, par_nQtdDivs, par_nQtdEtiqs)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        LOCAL loc_nNumOp, loc_nNovaOp, loc_xPeso

        loc_lSucesso = .F.

        TRY
            *-- Validacoes de entrada
            IF par_cOperacao = "D"
                IF par_nQtds = par_nQtdDivs
                    MsgAviso("A OP n" + CHR(227) + "o pode ficar com quantidade = 0", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
                IF par_nQtdDivs = 0 AND par_nQtdEtiqs = 0
                    MsgAviso("Nenhuma OP foi gerada...", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Calcular numeracao da nova OP
            loc_nNumOp = INT(par_nNop / 10000)
            loc_cSQL = "SELECT MAX(Nops) AS MaxNops FROM SigOpPic WHERE Numps = " + ;
                       FormatarNumeroSQL(loc_nNumOp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMaxOp") <= 0
                MsgErro("Falha ao obter pr" + CHR(243) + "xima OP", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMaxOp
            GO TOP
            loc_nNovaOp = NVL(cursor_4c_LocalMaxOp.MaxNops, 0) + 1
            USE IN cursor_4c_LocalMaxOp

            *-- Calcular xPeso (soma de pesos em xNensi)
            loc_xPeso = 0
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                SELECT SUM(Pesos) AS SomaPesos FROM xNensi INTO CURSOR cursor_4c_xPesoTmp
                SELECT cursor_4c_xPesoTmp
                GO TOP
                loc_xPeso = NVL(cursor_4c_xPesoTmp.SomaPesos, 0)
                USE IN cursor_4c_xPesoTmp
            ENDIF

            *-- Iniciar transacao SQL Server
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") <= 0
                MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lSucesso = .F.
            ENDIF
            THIS.this_lTransacaoAberta = .T.

            *-- Delegar para metodo especifico
            IF par_cOperacao = "D"
                loc_lSucesso = THIS.GerarDivisao(par_nNop, loc_nNovaOp, ;
                                                 THIS.this_cDivisaoop, ;
                                                 par_nQtdDivs, par_nQtdEtiqs, loc_xPeso)
            ELSE
                loc_lSucesso = THIS.GerarReinicio(par_nNop, loc_nNovaOp, THIS.this_cDivisaoop)
            ENDIF

            IF !loc_lSucesso
                THIS.RollbackTransacao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.RollbackTransacao()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarGravacao - Confirma gravacao: atualiza Obss e faz COMMIT
    * Chamado quando usuario clica "Confirmar" apos revisar Grade2
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lTransacaoAberta
                MsgErro("Nenhuma transa" + CHR(231) + CHR(227) + "o aberta para confirmar", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Atualizar Obss em SigOpPic a partir de Temporario
            IF USED("Temporario") AND RECCOUNT("Temporario") > 0
                SELECT Temporario
                GO TOP
                DO WHILE !EOF()
                    LOCAL loc_nNopTemp, loc_cObssTemp, loc_nSeqTemp
                    LOCAL loc_cDopesTemp, loc_nNumesTemp
                    loc_nNopTemp   = Temporario.Nops
                    loc_nSeqTemp   = Temporario.SeqDivs
                    loc_cObssTemp  = NVL(Temporario.Obss, "")
                    loc_cDopesTemp = ALLTRIM(Temporario.Dopes)
                    loc_nNumesTemp = Temporario.Numes

                    loc_cSQL = "UPDATE SigOpPic SET Obss = " + EscaparSQL(loc_cObssTemp) + ;
                               " WHERE Nops = " + FormatarNumeroSQL(loc_nNopTemp) + ;
                               " AND Dopes = " + EscaparSQL(loc_cDopesTemp) + ;
                               " AND Numes = " + FormatarNumeroSQL(loc_nNumesTemp)
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    SELECT Temporario
                    SKIP
                ENDDO
            ENDIF

            *-- Atualizar CodTgOps nas OPs geradas (busca fresh da OP original)
            *-- cursor_4c_TmpOpi foi fechado em BuscarOP; usar this_nNops para re-query
            IF THIS.this_nNops > 0 AND USED("Temporario") AND RECCOUNT("Temporario") > 0
                LOCAL loc_cCodTgOps
                loc_cCodTgOps = ""
                loc_cSQL = "SELECT TOP 1 CodTgOps FROM SigOpPic WHERE Nops = " + ;
                           FormatarNumeroSQL(THIS.this_nNops)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCodTg") > 0
                    SELECT cursor_4c_TmpCodTg
                    IF RECCOUNT() > 0
                        GO TOP
                        loc_cCodTgOps = ALLTRIM(NVL(cursor_4c_TmpCodTg.CodTgOps, ""))
                    ENDIF
                    USE IN cursor_4c_TmpCodTg
                ENDIF
                IF !EMPTY(loc_cCodTgOps)
                    SELECT Temporario
                    GO TOP
                    DO WHILE !EOF()
                        loc_cSQL = "UPDATE SigOpPic SET CodTgOps = " + EscaparSQL(loc_cCodTgOps) + ;
                                   " WHERE Nops = " + FormatarNumeroSQL(Temporario.Nops)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                        SELECT Temporario
                        SKIP
                    ENDDO
                ENDIF
            ENDIF

            *-- COMMIT
            IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                THIS.this_lTransacaoAberta = .F.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o", "Erro")
                THIS.RollbackTransacao()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.RollbackTransacao()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RollbackTransacao - Desfaz transacao aberta
    *--------------------------------------------------------------------------
    PROCEDURE RollbackTransacao()
        IF THIS.this_lTransacaoAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            THIS.this_lTransacaoAberta = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Auto-rollback se transacao aberta ao destruir BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.RollbackTransacao()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDivisao - Logica de divisao de OP (operacao 'D')
    * Traduz Grupo_Salva.Click para operacao 'D' em nova arquitetura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarDivisao(par_nNop, par_nNovaOp, par_cDivisaoop, ;
                                     par_nQtdDivs, par_nQtdEtiqs, par_xPeso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nCitem, loc_nTotal, loc_llGeraOp
        LOCAL loc_nNovaOpCurr, loc_nQtdTb, loc_nPesoOpNew
        LOCAL loc_cIdsNec, loc_cIds, loc_cEmpDnPs

        loc_lSucesso = .F.
        loc_nCitem   = 500
        loc_nTotal   = 0
        loc_llGeraOp = .F.
        loc_nNovaOpCurr = par_nNovaOp

        TRY
            *-- Carregar LocalMfas: SigPdMvf WHERE Nops = par_nNop
            loc_cSQL = "SELECT * FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfas") <= 0
                MsgErro("Falha ao carregar SigPdMvf", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfas
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfas
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Inserir SigCdNec para nova OP se houver QtdDivs
            IF par_nQtdDivs > 0
                loc_cIdsNec  = fUniqueIds()
                loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                loc_cSQL = "INSERT INTO SigCdNec (" + ;
                           "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                           "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                           "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                           "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                           "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                           "SELECT " + ;
                           EscaparSQL(THIS.this_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                           FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE(), " + ;
                           "GrupoDs, ContaDs, Grupods, Contads, " + ;
                           EscaparSQL(loc_cIdsNec) + ", " + ;
                           EscaparSQL(loc_cEmpDnPs) + ", " + ;
                           "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ' " + ;
                           "FROM SigPdMvf WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    MsgErro("Favor Reinicializar o Processo!!! (SigCdNec D)", "Erro")
                    USE IN cursor_4c_LocalMfas
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- SCAN Temp_DivOp: processar cada item com QtdDivs > 0
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                IF Temp_DivOp.QtdDivs > 0
                    *-- Obter QtdTb: SigCdPro + SigCdGrp + SigPrMtz
                    loc_nQtdTb = THIS.ObterQtdTubos(ALLTRIM(Temp_DivOp.Cpros))
                    *-- Calcular peso proporcional
                    loc_nPesoOpNew = IIF(Temp_DivOp.Pesos = 0, 0, ;
                                        (Temp_DivOp.Pesos / Temp_DivOp.Qtds) * Temp_DivOp.QtdDivs)

                    *-- INSERT INTO SigOpPic (nova OP)
                    loc_cIds    = fUniqueIds()
                    loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                    loc_cSQL = "INSERT INTO SigOpPic (" + ;
                               "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                               "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                               "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, Pesos, " + ;
                               "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                               "VALUES (" + ;
                               EscaparSQL(THIS.this_cEmps) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                               FormatarNumeroSQL(INT(loc_nNovaOpCurr / 10000)) + ", " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.Numes) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(Temp_DivOp.Dataes) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               EscaparSQL(NVL(Temp_DivOp.Obss, "")) + ", " + ;
                               FormatarNumeroSQL(loc_nCitem) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Cpros)) + ", " + ;
                               "1, " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.CodTams)) + ", " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               FormatarNumeroSQL(par_nNop) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdTb * Temp_DivOp.QtdDivs) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Empds)) + ", " + ;
                               EscaparSQL(loc_cIds) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Empds) + ALLTRIM(Temp_DivOp.Dopes) + ;
                                          STR(Temp_DivOp.Numes, 6)) + ", " + ;
                               EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                          STR(INT(loc_nNovaOpCurr / 10000), 10)) + ", " + ;
                               EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                          STR(loc_nNovaOpCurr, 10)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Dpros)) + ", " + ;
                               EscaparSQL(ALLTRIM(Temp_DivOp.Notas)) + ", " + ;
                               FormatarNumeroSQL(Temp_DivOp.Citens) + ", " + ;
                               FormatarNumeroSQL(loc_nPesoOpNew) + ", " + ;
                               "' ', 0, 0, 0, 0, '   ', 0, 0, '')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                        MsgErro("Favor Reinicializar o Processo!!! (INSERT SigOpPic)", "Erro")
                        USE IN cursor_4c_LocalMfas
                        loc_lSucesso = .F.
                    ENDIF

                    *-- INSERT INTO Temporario (cursor local para exibicao em Grade2)
                    SET NULL ON
                    INSERT INTO Temporario ;
                        (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                         Empds, Dpros, Notas, Contas) ;
                        VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, Temp_DivOp.QtdDivs, ;
                                Temp_DivOp.Obss, loc_nNovaOpCurr, loc_nCitem, ;
                                Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                Temp_DivOp.Contas)
                    SET NULL OFF

                    loc_nCitem = loc_nCitem + 1

                    *-- INSERT INTO SigPdMvf (nova entrada de fase)
                    SELECT cursor_4c_LocalMfas
                    GO TOP
                    loc_cIds    = fUniqueIds()
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfas.Emps) + ;
                                   ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                    loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                               "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                               "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                               "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                               "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                               "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                               "SELECT Codpds, Contads, Grupods, Dataes, Dataps, GETDATE(), Datas, " + ;
                               "Dopes, " + EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                               "Grupods, Grupods, " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               "Numes, " + ;
                               FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                               "Opers, " + ;
                               "CASE WHEN " + FormatarNumeroSQL(par_xPeso) + " = 0 THEN 1 ELSE Ordems END, " + ;
                               "0, " + ;
                               FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                               EscaparSQL(loc_cIds) + ", " + ;
                               EscaparSQL(loc_cEmpDnPs) + ", " + ;
                               "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                               "FROM SigPdMvf WHERE cIdChaves = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                    IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                        MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf D)", "Erro")
                        USE IN cursor_4c_LocalMfas
                        loc_lSucesso = .F.
                    ENDIF

                    *-- UPDATE SigOpPic original: reduzir Qtds, marcar Divs
                    loc_cSQL = "UPDATE SigOpPic SET " + ;
                               "Qtds = Qtds - " + FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ", " + ;
                               "SeqDivs = " + FormatarNumeroSQL(loc_nCitem - 1) + ", " + ;
                               "Divs = 1, Imprs = 0, " + ;
                               "Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "Pesos = (Pesos / CASE WHEN Qtds = 0 THEN 1 ELSE Qtds END) * " + ;
                               "(Qtds - " + FormatarNumeroSQL(Temp_DivOp.QtdDivs) + ") " + ;
                               "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes) + ;
                               " AND CodCors = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ;
                               " AND CodTams = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodTams))
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    *-- Inserir Temporario para items sem divisao (QtdDivs=0 e QtdEtiqs=0)
                ELSE
                    IF NVL(Temp_DivOp.QtdEtiqs, 0) = 0 AND NVL(Temp_DivOp.QtdDivs, 0) = 0
                        SET NULL ON
                        INSERT INTO Temporario ;
                            (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                             Empds, Dpros, Notas, Contas) ;
                            VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, Temp_DivOp.Qtds, ;
                                    Temp_DivOp.Obss, par_nNop, Temp_DivOp.SeqDivs, ;
                                    Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                    Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                    Temp_DivOp.Contas)
                        SET NULL OFF
                    ENDIF
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            IF loc_nCitem > 500
                loc_nNovaOpCurr = loc_nNovaOpCurr + 1
            ENDIF

            *-- Processar etiquetas (QtdEtiqs > 0)
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                IF NVL(Temp_DivOp.QtdEtiqs, 0) > 0
                    LOCAL loc_nQtd, loc_nY, loc_nX
                    loc_nQtd = INT(Temp_DivOp.Qtds / Temp_DivOp.QtdEtiqs)
                    loc_nY   = IIF(Temp_DivOp.QtdEtiqs = 1, 1, Temp_DivOp.QtdEtiqs - 1)
                    loc_nQtdTb = THIS.ObterQtdTubos(ALLTRIM(Temp_DivOp.Cpros))

                    FOR loc_nX = 1 TO loc_nY
                        *-- INSERT INTO SigOpPic para cada etiqueta
                        loc_cIds    = fUniqueIds()
                        loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                       STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigOpPic (" + ;
                                   "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                                   "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, QtdCpnts, " + ;
                                   "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, Citens, " + ;
                                   "Locals, Ntrans, CodBarras, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(INT(loc_nNovaOpCurr / 10000)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ", " + ;
                                   FormatarNumeroSQL(Temp_DivOp.Numes) + ", " + ;
                                   "GETDATE(), " + ;
                                   FormatarDataSQL(Temp_DivOp.Dataes) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   EscaparSQL(NVL(Temp_DivOp.Obss, "")) + ", " + ;
                                   FormatarNumeroSQL(loc_nCitem) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Cpros)) + ", " + ;
                                   "1, " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.CodTams)) + ", " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   FormatarNumeroSQL(par_nNop) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdTb * loc_nQtd) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Empds)) + ", " + ;
                                   EscaparSQL(loc_cIds) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Empds) + ALLTRIM(Temp_DivOp.Dopes) + ;
                                              STR(Temp_DivOp.Numes, 6)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(INT(loc_nNovaOpCurr / 10000), 10)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(loc_nNovaOpCurr, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Dpros)) + ", " + ;
                                   EscaparSQL(ALLTRIM(Temp_DivOp.Notas)) + ", " + ;
                                   FormatarNumeroSQL(Temp_DivOp.Citens) + ", " + ;
                                   "' ', 0, 0, 0, 0, '   ', 0, 0, '')"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            MsgErro("Favor Reinicializar o Processo!!! (SigOpPic Etiq)", "Erro")
                            USE IN cursor_4c_LocalMfas
                            loc_lSucesso = .F.
                        ENDIF

                        *-- INSERT INTO Temporario para etiqueta
                        SET NULL ON
                        INSERT INTO Temporario ;
                            (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, ;
                             Empds, Dpros, Notas, Contas) ;
                            VALUES (Temp_DivOp.Dopes, Temp_DivOp.Numes, loc_nQtd, ;
                                    Temp_DivOp.Obss, loc_nNovaOpCurr, loc_nCitem, ;
                                    Temp_DivOp.Cpros, Temp_DivOp.CodCors, Temp_DivOp.CodTams, ;
                                    Temp_DivOp.Empds, Temp_DivOp.Dpros, Temp_DivOp.Notas, ;
                                    Temp_DivOp.Contas)
                        SET NULL OFF

                        *-- INSERT INTO SigCdNec para etiqueta
                        SELECT cursor_4c_LocalMfas
                        GO TOP
                        loc_cIdsNec  = fUniqueIds()
                        loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                       STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigCdNec (" + ;
                                   "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                                   "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                                   "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                                   "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                                   "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                                   "SELECT " + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   "GETDATE(), " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   "GETDATE(), GrupoDs, ContaDs, Grupods, Contads, " + ;
                                   EscaparSQL(loc_cIdsNec) + ", " + ;
                                   EscaparSQL(loc_cEmpDnPs) + ", " + ;
                                   "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ' " + ;
                                   "FROM SigPdMvf WHERE cIdChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        *-- INSERT INTO SigPdMvf para etiqueta
                        SELECT cursor_4c_LocalMfas
                        GO TOP
                        loc_cIds    = fUniqueIds()
                        loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfas.Emps) + ;
                                       ALLTRIM(par_cDivisaoop) + STR(loc_nNovaOpCurr, 10)
                        loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                                   "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                                   "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                                   "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                                   "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                                   "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                                   "SELECT Codpds, Contads, Grupods, Dataes, Dataps, GETDATE(), Datas, " + ;
                                   "Dopes, " + EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                                   "Grupods, Grupods, " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", Numes, " + ;
                                   FormatarNumeroSQL(loc_nNovaOpCurr) + ", Opers, " + ;
                                   "CASE WHEN " + FormatarNumeroSQL(par_xPeso) + " = 0 THEN 1 ELSE Ordems END, " + ;
                                   "0, " + FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                                   EscaparSQL(loc_cIds) + ", " + ;
                                   EscaparSQL(loc_cEmpDnPs) + ", " + ;
                                   "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                                   "FROM SigPdMvf WHERE cIdChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_LocalMfas.cIdChaves))
                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf Etiq)", "Erro")
                            USE IN cursor_4c_LocalMfas
                            loc_lSucesso = .F.
                        ENDIF

                        *-- UPDATE SigOpPic: reduzir quantidade original
                        loc_cSQL = "UPDATE SigOpPic SET " + ;
                                   "Qtds = Qtds - " + FormatarNumeroSQL(loc_nQtd) + ", " + ;
                                   "Divs = 1, Imprs = 0, " + ;
                                   "Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   "QtdCpnts = (QtdCpnts / CASE WHEN Qtds = 0 THEN 1 ELSE Qtds END) * " + ;
                                   "(Qtds - " + FormatarNumeroSQL(loc_nQtd) + ") " + ;
                                   "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                                   " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                                   " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes) + ;
                                   " AND CodCors = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodCors)) + ;
                                   " AND CodTams = " + EscaparSQL(ALLTRIM(Temp_DivOp.CodTams))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        loc_nNovaOpCurr = loc_nNovaOpCurr + 1
                        loc_nCitem = loc_nCitem + 1
                        loc_llGeraOp = .T.
                    NEXT

                    *-- INSERT residual no Temporario para item com etiquetas
                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = " + FormatarNumeroSQL(loc_nCitem) + ;
                               " WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    *-- Query SigOpPic residual para inserir em Temporario
                    loc_cSQL = "SELECT Dopes, Numes, Qtds, Obss, Nops, Cpros, CodCors, CodTams, " + ;
                               "Empds, Dpros, Notas FROM SigOpPic " + ;
                               "WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                               " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                               " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpiResidual") > 0
                        SELECT cursor_4c_OpiResidual
                        IF RECCOUNT() > 0
                            GO TOP
                            SET NULL ON
                            INSERT INTO Temporario ;
                                (Dopes, Numes, Qtds, Obss, Nops, SeqDivs, Cpros, CodCors, ;
                                 CodTams, Empds, Dpros, Notas, Contas) ;
                                VALUES (cursor_4c_OpiResidual.Dopes, cursor_4c_OpiResidual.Numes, ;
                                        cursor_4c_OpiResidual.Qtds, cursor_4c_OpiResidual.Obss, ;
                                        cursor_4c_OpiResidual.Nops, loc_nCitem, ;
                                        cursor_4c_OpiResidual.Cpros, cursor_4c_OpiResidual.CodCors, ;
                                        cursor_4c_OpiResidual.CodTams, cursor_4c_OpiResidual.Empds, ;
                                        cursor_4c_OpiResidual.Dpros, cursor_4c_OpiResidual.Notas, ;
                                        Temp_DivOp.Contas)
                            SET NULL OFF
                        ENDIF
                        USE IN cursor_4c_OpiResidual
                    ENDIF
                    loc_nCitem = loc_nCitem + 1
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            *-- Rateio de pesos do xNensi para os novos cursores SigCdNei
            IF USED("xNensi") AND RECCOUNT("xNensi") > 0
                LOCAL loc_nPRatear, loc_nQRatear, loc_nQOrigin
                loc_nPRatear = 0
                loc_nQRatear = 0
                SELECT SUM(Pesos) AS SomaPes, SUM(Qtds) AS SomaQtd FROM xNensi INTO CURSOR cursor_4c_NensiSum
                SELECT cursor_4c_NensiSum
                GO TOP
                loc_nPRatear = NVL(cursor_4c_NensiSum.SomaPes, 0)
                loc_nQRatear = NVL(cursor_4c_NensiSum.SomaQtd, 0)
                USE IN cursor_4c_NensiSum

                SELECT SUM(Qtds) AS TotalQtd FROM Temp_DivOp INTO CURSOR cursor_4c_TotQtd
                SELECT cursor_4c_TotQtd
                GO TOP
                loc_nQOrigin = NVL(cursor_4c_TotQtd.TotalQtd, 0)
                USE IN cursor_4c_TotQtd

                IF loc_nPRatear <> 0 AND USED("Temporario") AND RECCOUNT("Temporario") > 0
                    *-- Para cada Nops distinto em Temporario, inserir SigCdNei rateado
                    SELECT Nops, SUM(Qtds) AS Qtds FROM Temporario GROUP BY Nops INTO CURSOR cursor_4c_TempDiv
                    SELECT cursor_4c_TempDiv
                    GO TOP
                    DO WHILE !EOF()
                        LOCAL loc_nOpDiv, loc_nQtDiv
                        loc_nOpDiv = cursor_4c_TempDiv.Nops
                        loc_nQtDiv = cursor_4c_TempDiv.Qtds

                        *-- INSERT SigCdNei rateado: SELECT + ajustes de peso/qtd
                        SELECT xNensi
                        GO TOP
                        DO WHILE !EOF()
                            loc_cIds = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                                       "Aqtds, Cats, Cdescs, Cgrus, Cmats, Coefs, Contafs, Cunis, " + ;
                                       "Dopps, Emps, Fators, Flagincs, Grupofins, Grupofs, Moedas, Moeds, " + ;
                                       "Nenvs, Nops, Numps, Obss, Pesos, Qtds, Servicos, Tpops, " + ;
                                       "Locals, Ntrans, CidChaves, Nlotes, PesoFixs, Coefinfs, Cretrabs, " + ;
                                       "EmpDnPs, EmpDopNums, ChkSubn, CodCors, CodNConfs, CodTams, Peso2s, Custofs, Moecusfs, Estorno, Pvens) " + ;
                                       "VALUES (" + ;
                                       FormatarNumeroSQL(xNensi.Aqtds) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cats)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cdescs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cgrus)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cmats)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Coefs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Contafs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cunis)) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Emps)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Fatores) + ", " + ;
                                       IIF(xNensi.Flagincs, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Grupofins)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Grupofs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moedas)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moeds)) + ", " + ;
                                       IIF(xNensi.Nops <> loc_nOpDiv, "0", TRANSFORM(xNensi.Nenvs)) + ", " + ;
                                       FormatarNumeroSQL(loc_nOpDiv) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Numps) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Obss)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Pesos / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Qtds / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       IIF(xNensi.Servicos, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Tpops)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Locals)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Ntrans) + ", " + ;
                                       EscaparSQL(loc_cIds) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Nlotes) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Pesofixs) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Coefinfs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Cretrabs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Emps) + ALLTRIM(par_cDivisaoop) + ;
                                                  STR(xNensi.Numps, 10)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.EmpDopNums)) + ", " + ;
                                       IIF(xNensi.Chksubn, "1", "0") + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodCors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodNConfs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.CodTams)) + ", " + ;
                                       FormatarNumeroSQL(IIF(loc_nQOrigin = 0, 0, ;
                                           xNensi.Peso2s / loc_nQOrigin * loc_nQtDiv)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Custofs) + ", " + ;
                                       EscaparSQL(ALLTRIM(xNensi.Moecusfs)) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Estorno) + ", " + ;
                                       FormatarNumeroSQL(xNensi.Pvens) + ")"
                            SQLEXEC(gnConnHandle, loc_cSQL)
                            SELECT xNensi
                            SKIP
                        ENDDO

                        SELECT cursor_4c_TempDiv
                        SKIP
                    ENDDO
                    USE IN cursor_4c_TempDiv
                ENDIF
            ENDIF

            USE IN cursor_4c_LocalMfas
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarReinicio - Logica de reinicio de OP (operacao 'R')
    * Traduz Grupo_Salva.Click para operacao 'R' em nova arquitetura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarReinicio(par_nNop, par_nNovaOp, par_cDivisaoop)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cIds, loc_cEmpDnPs

        loc_lSucesso = .F.

        TRY
            *-- Carregar LocalMfas
            loc_cSQL = "SELECT * FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                       " ORDER BY Nops DESC, cIdChaves DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMfasR") <= 0
                MsgErro("Falha ao carregar SigPdMvf (R)", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_LocalMfasR
            IF RECCOUNT() = 0
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF
            GO TOP

            *-- Buscar configuracao SigCdOpd para a divisaoop
            loc_cSQL = "SELECT TOP 1 GruOrigs, ConOrigs, GruDests, ConDests, TpPadraos " + ;
                       "FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(par_cDivisaoop))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpd") > 0
                SELECT cursor_4c_SigOpd
                IF RECCOUNT() > 0
                    GO TOP
                    THIS.this_cGruOrigs = ALLTRIM(cursor_4c_SigOpd.GruOrigs)
                    THIS.this_cConOrigs = ALLTRIM(cursor_4c_SigOpd.ConOrigs)
                    THIS.this_cGruDests = ALLTRIM(cursor_4c_SigOpd.GruDests)
                    THIS.this_cConDests = ALLTRIM(cursor_4c_SigOpd.ConDests)
                ENDIF
                USE IN cursor_4c_SigOpd
            ENDIF

            *-- Atualizar SigCdNec: ChkSubn = 1 para EmpDnPs da OP original
            loc_cSQL = "UPDATE SigCdNec SET ChkSubn = 1 " + ;
                       "WHERE EmpDnPs = " + ;
                       EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(par_nNop, 10))
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Favor Reinicializar o Processo!!! (Update SigCdNec R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- INSERT INTO SigCdNec para nova OP (Reinicio)
            loc_cIds    = fUniqueIds()
            loc_cEmpDnPs = THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + STR(par_nNovaOp, 10)
            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "Emps, Dopps, Numps, Datas, Usuars, Datars, Grupoos, Contaos, " + ;
                       "Grupods, Contads, CidChaves, EmpDnPs, " + ;
                       "ChkSubn, Imprs, Lccs, TotPesos, GrvEnds, Procbals, ProcDbal, " + ;
                       "Naceites, Ntrans, Locals, NumBalDs, NumBals, CodObs, Empds, " + ;
                       "NConforms, Nlotes, Jobs, Pesolancs, Usulibs, ChkBaixa, Usuconfs, Retrabs, CodNConfs, Nops, Autos, LibProds, Vends, Docus) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE(), " + ;
                       EscaparSQL(THIS.this_cGruOrigs) + ", " + ;
                       EscaparSQL(THIS.this_cConOrigs) + ", " + ;
                       EscaparSQL(THIS.this_cGruDests) + ", " + ;
                       EscaparSQL(THIS.this_cConDests) + ", " + ;
                       EscaparSQL(loc_cIds) + ", " + ;
                       EscaparSQL(loc_cEmpDnPs) + ", " + ;
                       "0, 0, 0, 0, '', 0, 0, 0, 0, ' ', 0, 0, 0, ' ', 0, 0, 0, ' ', 0, ' ', 0, ' ', 0, ' ', 0, 0, ' ', ' ', ' ')"
            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                MsgErro("Favor Reinicializar o Processo!!! (SigCdNec R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- INSERT INTO SigPdMvf para nova OP (Reinicio)
            loc_cIds    = fUniqueIds()
            loc_cEmpDnPs = ALLTRIM(cursor_4c_LocalMfasR.Emps) + ;
                           ALLTRIM(par_cDivisaoop) + STR(par_nNovaOp, 10)
            loc_cSQL = "INSERT INTO SigPdMvf (" + ;
                       "Codpds, Contads, Contaos, Dataes, Dataps, Datars, Datas, " + ;
                       "Dopes, Dopps, Emps, Etiqs, Grupods, Grupoos, " + ;
                       "Nenvs, Nops, Numes, Numps, Opers, Ordems, Pesos, Qtds, " + ;
                       "Unids, Usuars, Locals, Ntrans, Cretrabs, CidChaves, EmpDnPs, " + ;
                       "EmpDopNums, ChkSubn, Ordemos, TmpMins) " + ;
                       "SELECT Codpds, Contads, " + ;
                       EscaparSQL(THIS.this_cConOrigs) + ", " + ;
                       "Dataes, Dataps, GETDATE(), Datas, Dopes, " + ;
                       EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", Emps, Etiqs, " + ;
                       EscaparSQL(THIS.this_cGruDests) + ", " + ;
                       EscaparSQL(THIS.this_cGruOrigs) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", Numes, " + ;
                       FormatarNumeroSQL(par_nNovaOp) + ", Opers, 1, 0, 0, " + ;
                       "Unids, Usuars, Locals, Ntrans, Cretrabs, " + ;
                       EscaparSQL(loc_cIds) + ", " + ;
                       EscaparSQL(loc_cEmpDnPs) + ", " + ;
                       "EmpDopNums, ChkSubn, Ordemos, TmpMins " + ;
                       "FROM SigPdMvf WHERE cIdChaves = " + ;
                       EscaparSQL(ALLTRIM(cursor_4c_LocalMfasR.cIdChaves))
            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                MsgErro("Favor Reinicializar o Processo!!! (SigPdMvf R)", "Erro")
                USE IN cursor_4c_LocalMfasR
                loc_lSucesso = .F.
            ENDIF

            *-- Para cada item em Temp_DivOp: copiar SigOpPic para nova OP
            SELECT Temp_DivOp
            GO TOP
            DO WHILE !EOF()
                *-- Buscar SigOpPic original para este item
                loc_cSQL = "SELECT CidChaves, Dopes, Numes, Qtds, Dataes, Obss, " + ;
                           "Cpros, CodCors, CodTams, Empds, Dpros, Notas, Citens, Pesos, " + ;
                           "EmpDopNums, SeqDivs " + ;
                           "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNop) + ;
                           " AND Dopes = " + EscaparSQL(ALLTRIM(Temp_DivOp.Dopes)) + ;
                           " AND Numes = " + FormatarNumeroSQL(Temp_DivOp.Numes)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpiOrigR") > 0
                    SELECT cursor_4c_OpiOrigR
                    GO TOP
                    DO WHILE !EOF()
                        loc_cIds    = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigOpPic (" + ;
                                   "Emps, Dopps, Numps, Nops, Dopes, Numes, Dataps, Dataes, Qtds, " + ;
                                   "Obss, SeqDivs, Cpros, Divs, CodCors, CodTams, Usuars, NopMaes, " + ;
                                   "Empds, CidChaves, EmpDopNums, EmpDNps, EmpDopNops, Dpros, Notas, " + ;
                                   "Citens, Pesos, Locals, Ntrans, CodBarras, QtdCpnts, QtdTubos, " + ;
                                   "IImprs, Moedas, Units, Nfunds, CodTgOps) " + ;
                                   "SELECT " + ;
                                   EscaparSQL(THIS.this_cEmps) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cDivisaoop)) + ", " + ;
                                   FormatarNumeroSQL(INT(par_nNovaOp / 10000)) + ", " + ;
                                   FormatarNumeroSQL(par_nNovaOp) + ", " + ;
                                   "Dopes, Numes, GETDATE(), Dataes, Qtds, Obss, SeqDivs, " + ;
                                   "Cpros, Divs, CodCors, CodTams, " + ;
                                   EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                                   FormatarNumeroSQL(par_nNop) + ", " + ;
                                   "Empds, " + EscaparSQL(loc_cIds) + ", " + ;
                                   "EmpDopNums, " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(INT(par_nNovaOp / 10000), 10)) + ", " + ;
                                   EscaparSQL(THIS.this_cEmps + ALLTRIM(par_cDivisaoop) + ;
                                              STR(par_nNovaOp, 10)) + ", " + ;
                                   "Dpros, Notas, Citens, Pesos, Locals, Ntrans, CodBarras, " + ;
                                   "QtdCpnts, QtdTubos, IImprs, Moedas, Units, Nfunds, CodTgOps " + ;
                                   "FROM SigOpPic WHERE CidChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_OpiOrigR.CidChaves))
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        SELECT cursor_4c_OpiOrigR
                        SKIP
                    ENDDO
                    USE IN cursor_4c_OpiOrigR
                ENDIF

                SELECT Temp_DivOp
                SKIP
            ENDDO

            USE IN cursor_4c_LocalMfasR
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterQtdTubos - Calcula quantidade de tubos/componentes para um produto
    * Equivalente ao bloco fwbuscaext SigCdPro + SigCdGrp + SigPrMtz do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterQtdTubos(par_cCpros)
        LOCAL loc_nQtdTb, loc_cSQL

        loc_nQtdTb = 0

        TRY
            *-- Buscar QtdCpnts e CGrus do produto
            loc_cSQL = "SELECT TOP 1 QtdCpnts, CGrus FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                IF RECCOUNT() > 0
                    GO TOP
                    LOCAL loc_nQtdCpnts, loc_cCGrus, loc_nGeraTubs
                    loc_nQtdCpnts = NVL(cursor_4c_TmpPro.QtdCpnts, 0)
                    loc_cCGrus    = ALLTRIM(NVL(cursor_4c_TmpPro.CGrus, ""))

                    *-- Buscar GeraTubs do grupo
                    loc_nGeraTubs = 0
                    IF !EMPTY(loc_cCGrus)
                        loc_cSQL = "SELECT TOP 1 GeraTubs FROM SigCdGrp"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGru") > 0
                            SELECT cursor_4c_TmpGru
                            IF RECCOUNT() > 0
                                GO TOP
                                loc_nGeraTubs = NVL(cursor_4c_TmpGru.GeraTubs, 0)
                            ENDIF
                            USE IN cursor_4c_TmpGru
                        ENDIF
                    ENDIF

                    IF loc_nGeraTubs <> 2
                        loc_nQtdTb = loc_nQtdCpnts
                    ELSE
                        *-- GeraTubs = 2: soma qtds de SigPrMtz
                        loc_cSQL = "SELECT SUM(qtds) AS Total FROM SigPrMtz WHERE Cpros = " + ;
                                   EscaparSQL(par_cCpros)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPrMtz") > 0
                            SELECT cursor_4c_SigPrMtz
                            IF RECCOUNT() > 0
                                GO TOP
                                loc_nQtdTb = NVL(cursor_4c_SigPrMtz.Total, 0)
                            ENDIF
                            USE IN cursor_4c_SigPrMtz
                        ENDIF
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN NVL(loc_nQtdTb, 0)
    ENDPROC

ENDDEFINE
