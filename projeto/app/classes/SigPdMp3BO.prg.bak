*==============================================================================
* SigPdMp3BO.prg - Business Object para Emissao de Etiquetas (SIGPDMP9)
* Herda de: BusinessBase
* Form: FormSigPdMp3 (sub-form de emissao de etiquetas de pesagem)
* Legado: SigPdMp3.SCX / SIGPDMP9
*==============================================================================
DEFINE CLASS SigPdMp3BO AS BusinessBase

    *-- Contexto recebido do form pai
    this_cDopp      = ""    && _Dopp do form pai (operacao corrente)
    this_cEscolha   = ""    && pcEscolha do form pai (INSERIR/CONSULTAR)

    *-- Cabecalho da operacao (TmpNens)
    this_cEmps      = ""    && Empresa (TmpNens.emps)
    this_cDopps     = ""    && Codigo da operacao (TmpNens.dopps)
    this_nNumps     = 0     && Numero da operacao (TmpNens.numps)
    this_cGrupoOs   = ""    && Grupo origem (TmpNens.grupoos)
    this_cContaOs   = ""    && Conta origem (TmpNens.contaos)
    this_cDcontaOs  = ""    && Nome da conta origem (SigCdCli.RClis)
    this_cGrupoDs   = ""    && Grupo destino (TmpNens.grupods)
    this_cContaDs   = ""    && Conta destino (TmpNens.contads)
    this_cDcontaDs  = ""    && Nome da conta destino (SigCdCli.RClis)

    *-- Flags da operacao (crSigCdOpd)
    this_nOrigems   = 0     && Exibir container Origem (crSigCdOpd.Origems)
    this_nDestinos  = 0     && Exibir container Destino (crSigCdOpd.Destinos)
    this_nImagms    = 0     && Exibir imagem do produto (crSigCdOpd.Imagems)
    this_nEtiqs     = 0     && Tipo de etiquetas (crSigCdOpd.Etiqs)
    this_cDopesOpd  = ""    && Dopes de crSigCdOpd

    *-- Linha corrente do grid xOpi
    this_nNops      = 0     && Numero OP / Ordem Fabricacao (xOpi.nops) - Column1
    this_cOper      = ""    && Pedido/operacao (xOpi.oper) - Column2
    this_nQtds      = 0     && Quantidade (xOpi.qtds) - Column3
    this_cCPros     = ""    && Codigo do produto (xOpi.cpros) - Column4
    this_lIndiv     = .F.   && Flag individual (xOpi.indiv) - Column5 checkbox
    this_cConta     = ""    && Conta (xOpi.conta) - Column6
    this_lDivs      = .F.   && Flag divisao PM (xOpi.Divs) - Column7 checkbox
    this_cAmarra    = ""    && Codigo de amarracao (xOpi.amarra)
    this_nCbars     = 0     && Flag codigo de barras (xOpi.cbars)
    this_cCodCors   = ""    && Codigo da cor (xOpi.codcors)
    this_cCodTams   = ""    && Codigo do tamanho (xOpi.codtams)
    this_cEmpds     = ""    && Empresa destino (xOpi.empds)
    this_cDopes     = ""    && Data/operacao (xOpi.dopes)
    this_nNumes     = 0     && Numero (xOpi.numes)
    this_cCitens    = ""    && Codigo do item (xOpi.citens)
    this_nNenvs     = 0     && Numero do envelope (xOpi.nenvs)
    this_lObrigs    = .F.   && Flag obrigatorio (xOpi.obrigs)

    *-- Dados do produto (SigCdPro via CursorQuery)
    this_cDPros     = ""    && Descricao do produto (DPros)
    this_cFigJpgs   = ""    && Imagem base64 (FigJpgs)
    this_cMatPrincs = ""    && Material principal (SigCdPro.MatPrincs)
    this_cCgrus     = ""    && Grupo do produto (SigCdPro.Cgrus)
    this_nPesoms    = 0     && Peso medio (SigCdPro.Pesoms)

    *-- Dados do grupo (SigCdGrp via CursorQuery)
    this_cMercs     = ""    && Mercadoria (SigCdGrp.Mercs)

    *-- Dados do sub-grupo (SigCdGpr via CursorQuery)
    this_cMatPGpr   = ""    && Material do sub-grupo (SigCdGpr.MatPrincs)
    this_nCpQtds    = 0     && Qtde por unidade (SigCdGpr.cpqtds)

    *-- Material e flags calculados
    this_cMatP      = ""    && Material efetivo resolvido (_MatP)
    this_lEspecial  = .F.   && Flag especial (CadProds=3 ou Pesos=1)
    this_nCadProds  = 0     && Tipo de cadastro do produto (SigCdOpe.CadProds)
    this_nPesos     = 0     && Flag de peso (SigCdOpe.Pesos)

    *-- Exibicao e observacao
    this_cDescr     = ""    && Descricao exibida em Get_descr
    this_cObs       = ""    && Observacao (xmfas.obss)

    *-- Auxiliar para impressao de etiquetas (ok.Click)
    this_cPosicao   = ""    && Posicao para Seek crSigCdNec

    *-- Material fallback de CrSigCdPam.Ouros (preenchido pelo Form antes de Inserir)
    this_cOuros     = ""

    *==========================================================================
    * Init - Inicializa o BO
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades da linha corrente do cursor xOpi
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops    = NVL(nops, 0)
                THIS.this_cOper    = ALLTRIM(NVL(oper, ""))
                THIS.this_nQtds    = NVL(qtds, 0)
                THIS.this_cCPros   = ALLTRIM(NVL(cpros, ""))
                IF VARTYPE(indiv) = "L"
                    THIS.this_lIndiv = NVL(indiv, .F.)
                ELSE
                    THIS.this_lIndiv = IIF(NVL(indiv, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cConta   = ALLTRIM(NVL(conta, ""))
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    THIS.this_lDivs = IIF(NVL(Divs, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cAmarra  = ALLTRIM(NVL(amarra, ""))
                THIS.this_nCbars   = NVL(cbars, 0)
                THIS.this_cCodCors = ALLTRIM(NVL(codcors, ""))
                THIS.this_cCodTams = ALLTRIM(NVL(codtams, ""))
                THIS.this_cEmpds   = ALLTRIM(NVL(empds, ""))
                THIS.this_cDopes   = ALLTRIM(NVL(dopes, ""))
                THIS.this_nNumes   = NVL(numes, 0)
                THIS.this_cCitens  = ALLTRIM(NVL(citens, ""))
                THIS.this_nNenvs   = NVL(nenvs, 0)
                IF VARTYPE(obrigs) = "L"
                    THIS.this_lObrigs = NVL(obrigs, .F.)
                ELSE
                    THIS.this_lObrigs = IIF(NVL(obrigs, 0) = 1, .T., .F.)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosProduto - Consulta SigCdPro, SigCdGrp, SigCdGpr; resolve MatP
    *==========================================================================
    PROCEDURE ObterDadosProduto()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_cMatPrincs = ""
        THIS.this_cCgrus     = ""
        THIS.this_nPesoms    = 0
        THIS.this_cMercs     = ""
        THIS.this_cMatPGpr   = ""
        THIS.this_nCpQtds    = 0
        THIS.this_cMatP      = ""
        THIS.this_cDPros     = ""
        THIS.this_cFigJpgs   = ""
        TRY
            loc_cSQL = "SELECT MatPrincs, Cgrus, PesoMs, DPros, FigJpgs" + ;
                       " FROM SigCdPro" + ;
                       " WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalPro")
                SELECT cursor_4c_LocalPro
                THIS.this_cMatPrincs = ALLTRIM(NVL(MatPrincs, ""))
                THIS.this_cCgrus     = ALLTRIM(NVL(Cgrus, ""))
                THIS.this_nPesoms    = NVL(PesoMs, 0)
                THIS.this_cDPros     = ALLTRIM(NVL(DPros, ""))
                THIS.this_cFigJpgs   = NVL(FigJpgs, "")

                IF NOT EMPTY(THIS.this_cCgrus)
                    loc_cSQL = "SELECT Mercs FROM SigCdGrp WHERE CGrus = " + ;
                               EscaparSQL(ALLTRIM(THIS.this_cCgrus))
                    IF USED("cursor_4c_LocalGru")
                        USE IN cursor_4c_LocalGru
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")
                    IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGru")
                        SELECT cursor_4c_LocalGru
                        THIS.this_cMercs = ALLTRIM(NVL(Mercs, ""))

                        IF NOT EMPTY(THIS.this_cMercs)
                            loc_cSQL = "SELECT MatPrincs, cpqtds FROM SigCdGpr" + ;
                                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cMercs))
                            IF USED("cursor_4c_LocalGgrp")
                                USE IN cursor_4c_LocalGgrp
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGgrp")
                            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGgrp")
                                SELECT cursor_4c_LocalGgrp
                                THIS.this_cMatPGpr = ALLTRIM(NVL(MatPrincs, ""))
                                THIS.this_nCpQtds  = NVL(cpqtds, 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF NOT EMPTY(THIS.this_cMatPrincs)
                THIS.this_cMatP = THIS.this_cMatPrincs
            ELSE
                IF NOT EMPTY(THIS.this_cMatPGpr)
                    THIS.this_cMatP = THIS.this_cMatPGpr
                ELSE
                    THIS.this_cMatP = THIS.this_cOuros
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoConta - Retorna RClis do SigCdCli para o ICli informado
    *==========================================================================
    PROCEDURE ObterDescricaoConta(par_cICli)
        LOCAL loc_cResult, loc_cSQL, loc_nResult
        loc_cResult = ""
        TRY
            IF NOT EMPTY(ALLTRIM(par_cICli))
                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalCli")
                    SELECT cursor_4c_LocalCli
                    loc_cResult = ALLTRIM(NVL(RClis, ""))
                ENDIF
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cResult
    ENDPROC

    *==========================================================================
    * ObterDadosOpe - Busca CadProds e Pesos de SigCdOpe; define this_lEspecial
    *==========================================================================
    PROCEDURE ObterDadosOpe(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_nCadProds = 0
        THIS.this_nPesos    = 0
        THIS.this_lEspecial = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cDopes))
                loc_cSQL = "SELECT CadProds, Pesos FROM SigCdOpe" + ;
                           " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    THIS.this_nCadProds = NVL(CadProds, 0)
                    THIS.this_nPesos    = NVL(Pesos, 0)
                    THIS.this_lEspecial = (THIS.this_nCadProds = 3 OR THIS.this_nPesos = 1)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida contexto antes de processar pesagem
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cAmarra))
            MsgAviso("Amarra n" + CHR(227) + "o informada.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_nQtds <= 0
            MsgAviso("Quantidade inv" + CHR(225) + "lida.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Processa pesagem do item corrente (INSERT xPesa com Especial)
    * Equivalente a Grade.Column3.Text1.Valid do legado
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()
            THIS.ObterDadosOpe(THIS.this_cDopes)

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lEspecial, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lEspecial, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_lEspecial, THIS.this_cCitens)
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirPorCheckbox - Pesagem via checkbox indiv (INSERT xPesa com Divs)
    * Equivalente a Grade.Column5.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE InserirPorCheckbox()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lDivs, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza flag Divs no xPesa para o amarra corrente
    * Equivalente a Grade.Column7.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            UPDATE xPesa SET Divs = (THIS.this_lDivs) WHERE Amarra = THIS.this_cAmarra
            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarDivsTodas - Atualiza Divs em xPesa para todos os registros xOpi
    * Equivalente a Grade.Column7.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE AtualizarDivsTodas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
                SELECT xOpi
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarTodasOpi - Pesagem para todos os registros xOpi (marcar/desmarcar)
    * Equivalente a Grade.Column5.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE ProcessarTodasOpi()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                IF THIS.CarregarDoCursor("xOpi")
                    THIS.ObterDadosProduto()

                    SELECT xPesa
                    DELETE ALL FOR Amarra = THIS.this_cAmarra

                    IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                        loc_nCont = INT(THIS.this_nQtds)
                        loc_nQtde = 0
                        DO WHILE loc_nQtde < loc_nCont
                            loc_nQtde = loc_nQtde + 1
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                        THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                        ENDDO
                        IF (THIS.this_nQtds > loc_nQtde)
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                        loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                        THIS.this_lDivs, THIS.this_cCitens)
                        ENDIF
                    ELSE
                        loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                        INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                           Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                            VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                                    THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                                    THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                    THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                    THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
                    ENDIF

                    SELECT xOpi
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador do registro corrente (Amarra)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cAmarra)
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Override: form operacional opera em cursores locais
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF NOT EMPTY(THIS.this_cTabela)
            DODEFAULT(par_cOperacao)
        ENDIF
    ENDPROC

ENDDEFINE
