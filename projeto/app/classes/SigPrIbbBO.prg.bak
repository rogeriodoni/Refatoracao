*============================================================================
* SigPrIbbBO.prg - Business Object para Impressao de Boleto Bancario (SIGPRIBB)
*
* Form OPERACIONAL (SIGPRIBB / FormSigPrIbb): tela de impressao aberta com a
* chave de negocio do documento de movimentacao ja resolvida pelo chamador
* (equivalente ao par_cEmpDopNum passado ao Init do legado - ver
* tasks/task622/SIGPRIBB_form_codigo_fonte.txt, Procedure Init(pEdn, pFrm)).
* A tela mostra:
*   - grd_4c_Dados (crGrade no legado) com as condicoes de pagamento do
*     documento que tem boleto habilitado (SigMvPar x SigCdOpe x SigOpCdc x
*     SigOpFp, filtrando ImpBols = 1 nos dois lados - operacao e forma de
*     pagamento);
*   - a parcela selecionada na grade, com o texto de local de pagamento e o
*     texto de responsabilidade do cedente (memos da linha corrente);
*   - os dados do cliente/endereco de cobranca usados para montar o layout
*     impresso do boleto (crDados no legado), resolvidos a partir de
*     SigMvCab/SigMvNfi (e do cadastro de cliente) no momento do Imprimir.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO/SigPrHprBO): o documento vem de SigMvCab resolvido
* pela chave de negocio EmpDopNums, e as parcelas vem de SigMvPar filtradas
* por essa mesma chave. this_cCampoChave aponta para "empdopnums"
* (SigMvCab.empdopnums / SigMvPar.empdopnums), que eh o campo usado para
* localizar o documento e suas parcelas.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de dominio (CarregarParcelas,
* CarregarDoCursor, CarregarDadosDocumento, AtualizarConfiguracaoBoleto,
* CarregarConfiguracaoLayout, VerificarImpressoraDisponivel,
* CarregarDadosImpressao, MontarLayoutImpressao, ExecutarImpressaoMatricial,
* ImprimirBoleto, ObterChavePrimaria)
*============================================================================

DEFINE CLASS SigPrIbbBO AS BusinessBase

    *==========================================================================
    * Chave de negocio do documento recebida na abertura (equivalente ao
    * par_cEmpDopNum/pEdn do legado - PADR(pEdn, 29) antes de ser repassado)
    *==========================================================================
    this_cEmpDopNum   = SPACE(29)  && empdopnums CHAR(29) - Emps(3)+Dopes(20)+Numes(6)
    this_cEmps        = SPACE(3)   && emps       CHAR(3)  - Empresa (Substr(EmpDopNum,1,3))
    this_cDopes       = SPACE(20)  && dopes      CHAR(20) - Tipo de Operacao/Documento (Substr(EmpDopNum,4,20))
    this_nNumes       = 0          && numes      NUM(6,0) - Numero sequencial do documento (Substr(EmpDopNum,24,6))

    *==========================================================================
    * Dados do documento de movimentacao (SigMvCab - equivalente a
    * crTprMvCab no legado, resolvido via CursorQuery por EmpDopNums)
    *==========================================================================
    this_cContaOs     = SPACE(10)  && contaos CHAR(10) - Conta de origem do documento
    this_cContaDs     = SPACE(10)  && contads CHAR(10) - Conta de destino do documento

    *==========================================================================
    * Parcela selecionada na grade (equivalente a crGrade na linha ativa -
    * usado por grdItens.AfterRowColChange/btnImprimir.Click do legado)
    *==========================================================================
    this_cFPagsAtual      = SPACE(12)  && crGrade.FPags   (SigMvPar.fpags  CHAR(12)) - Forma de pagamento
    this_nParcsAtual      = 0          && crGrade.Parcs   (SigMvPar.parcs NUM(2,0)) - Numero da parcela
    this_dVencsAtual      = {}         && crGrade.Vencs   (SigMvPar.vencs DATETIME) - Vencimento da parcela
    this_dDatasAtual      = {}         && crGrade.Datas   (SigMvPar.datas DATETIME) - Data de emissao da parcela
    this_nValosAtual      = 0          && crGrade.Valos   (SigMvPar.valos NUM(11,2)) - Valor da parcela
    this_cLocalPgtoAtual  = ""         && crGrade.CLocals (texto livre - local de pagamento da condicao)
    this_cTextoCedenteAtual = ""       && crGrade.CTxtCds (memo - texto de responsabilidade do cedente)

    *==========================================================================
    * Dados para montagem do layout impresso do boleto (equivalente a
    * crDados no legado, populado pelo metodo Imprimir a partir de
    * SigMvCab/SigMvNfi e do cadastro de cliente da movimentacao)
    *==========================================================================
    this_cLocalPgtoImpressao = ""        && crDados.CLocals - Local de pagamento (texto impresso)
    this_cVencimentoImpresso = SPACE(12) && crDados.Vencs   - Vencimento formatado para impressao
    this_dDataDocumento      = {}        && crDados.DatDoc  - Data do documento
    this_cNumeroDocumento    = SPACE(8)  && crDados.NumDoc  - Numero do documento/nota fiscal
    this_nValorImpressao     = 0         && crDados.Valor   - Valor total a imprimir
    this_cRazaoSocial        = ""        && crDados.Razaos  - Razao social/nome do cliente
    this_cCpfCnpj            = SPACE(20) && crDados.Cpfs    - CPF/CNPJ do cliente
    this_cEndereco           = ""        && crDados.EndCobs - Endereco de cobranca
    this_cBairro             = SPACE(20) && crDados.BaiCobs - Bairro de cobranca
    this_cCidade             = SPACE(20) && crDados.CidCobs - Cidade de cobranca
    this_cEstado             = SPACE(2)  && crDados.EstCobs - Estado (UF) de cobranca
    this_cCep                = SPACE(9)  && crDados.CepCobs - CEP de cobranca
    this_cTextoComplementar  = ""        && crDados.Texto   - Texto livre complementar do boleto

    *==========================================================================
    * Total das parcelas boleto-habilitadas da grade (equivalente a
    * ThisForm.getTotal.Value do legado - soma de crGrade.Valos)
    *==========================================================================
    this_nTotalParcelas = 0

    *==========================================================================
    * Forma de pagamento da parcela atual (equivalente a crTmpFpag.ImpNotas -
    * decide, em CarregarDadosImpressao, se o vencimento impresso eh a data
    * (Dtoc(Vencs)) ou a propria condicao de pagamento (FPags))
    *==========================================================================
    this_nImpNotasAtual = 0

    *==========================================================================
    * Configuracao de impressao do boleto (SigCnFBl) para o FPags atual -
    * equivalente a LocalCfgBl no legado. Reusa SIGPRIBLBO (mesma tabela,
    * ja migrada - classes/SIGPRIBLBO.prg/forms/operacionais/FormSIGPRIBL.prg)
    * em vez de duplicar as ~30 propriedades de posicao de impressao.
    *==========================================================================
    this_oConfigBoleto = .NULL.

    *==========================================================================
    * Controle de processamento
    *==========================================================================
    this_lResultadoOk  = .F.   && Resultado da ultima operacao (carga/impressao)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de impressao (o documento vem de SigMvCab e
    * as parcelas vem de SigMvPar, ambos filtrados por EmpDopNums recebido
    * do chamador) - mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init/
    * SigPrHprBO.Init. this_cCampoChave fica com "empdopnums", unico campo
    * usado para localizar o documento e suas parcelas.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "empdopnums"

            THIS.this_cEmpDopNum = SPACE(29)
            THIS.this_cEmps      = SPACE(3)
            THIS.this_cDopes     = SPACE(20)
            THIS.this_nNumes     = 0

            THIS.this_cContaOs   = SPACE(10)
            THIS.this_cContaDs   = SPACE(10)

            THIS.this_cFPagsAtual         = SPACE(12)
            THIS.this_nParcsAtual         = 0
            THIS.this_dVencsAtual         = {}
            THIS.this_dDatasAtual         = {}
            THIS.this_nValosAtual         = 0
            THIS.this_cLocalPgtoAtual     = ""
            THIS.this_cTextoCedenteAtual  = ""

            THIS.this_cLocalPgtoImpressao = ""
            THIS.this_cVencimentoImpresso = SPACE(12)
            THIS.this_dDataDocumento      = {}
            THIS.this_cNumeroDocumento    = SPACE(8)
            THIS.this_nValorImpressao     = 0
            THIS.this_cRazaoSocial        = ""
            THIS.this_cCpfCnpj            = SPACE(20)
            THIS.this_cEndereco           = ""
            THIS.this_cBairro             = SPACE(20)
            THIS.this_cCidade             = SPACE(20)
            THIS.this_cEstado             = SPACE(2)
            THIS.this_cCep                = SPACE(9)
            THIS.this_cTextoComplementar  = ""

            THIS.this_nTotalParcelas  = 0
            THIS.this_nImpNotasAtual  = 0
            THIS.this_oConfigBoleto   = .NULL.

            THIS.this_lResultadoOk = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos a
    * atualizacao de SigCnFBl (AtualizarConfiguracaoBoleto) - FPags da
    * parcela/condicao de pagamento atual, que eh o campo de negocio usado
    * pelo legado no "Update SigCnFBl ... Where FPags = ...".
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPagsAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh uma tela de IMPRESSAO (sem cadastro
    * generico de uma entidade), sem INSERT/UPDATE/DELETE genericos no
    * legado nem fluxo de EditarRegistro()/NovoRegistro() + Salvar(). A
    * UNICA escrita real do legado (dentro de Procedure imprimir) eh o
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito ANTES de imprimir - tem semantica propria e esta implementado
    * em AtualizarConfiguracaoBoleto(), mais abaixo, que chama
    * RegistrarAuditoria("UPDATE") no sucesso. O comportamento padrao
    * herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao ja eh
    * o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute/CursorQuery do legado, que
    * nao reselecionam a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarParcelas - equivalente a SelecionaDados() do legado: popula
    * cursor_4c_Dados (crGrade) com as condicoes de pagamento do documento
    * (par_cEmpDopNum) que tem boleto habilitado nos dois lados - operacao
    * (SigOpCdc.ImpBols = 1) e forma de pagamento (SigOpFp.ImpBols = 1) -
    * enriquecidas com o local/texto de cobranca configurados em SigCnFBl
    * (com fallback para a linha de config em branco, FPags = Space(12),
    * igual ao legado). Deixa o cursor posicionado no PRIMEIRO registro
    * (Go Top legado) e THIS.this_nTotalParcelas com a soma de Valos.
    *==========================================================================
    FUNCTION CarregarParcelas(par_cEmpDopNum)
        LOCAL loc_lResultado, loc_cSQL, loc_nTotal, loc_oErro

        loc_lResultado = .F.
        loc_nTotal     = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cEmpDopNum = PADR(TratarNulo(par_cEmpDopNum, ""), 29)
        THIS.this_cEmps      = SUBSTR(THIS.this_cEmpDopNum, 01, 03)
        THIS.this_cDopes     = SUBSTR(THIS.this_cEmpDopNum, 04, 20)
        THIS.this_nNumes     = VAL(SUBSTR(THIS.this_cEmpDopNum, 24, 06))

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (FPags C(12), Parcs N(2,0), CLocals C(100), Vencs D, Datas D, Valos N(12,2), CTxtCds M)
            SET NULL OFF

            loc_cSQL = "SELECT b.fpags, b.parcs, b.vencs, b.datas, b.valos " + ;
                "FROM SigMvCab a, SigMvPar b, SigCdOpe c, SigOpCdc d, SigOpFp e " + ;
                "WHERE a.empdopnums = " + EscaparSQL(THIS.this_cEmpDopNum) + " " + ;
                "AND a.empdopnums = b.empdopnums " + ;
                "AND b.dopes = c.dopes " + ;
                "AND c.dopes = d.dopes " + ;
                "AND d.impbols = 1 " + ;
                "AND b.fpags = e.fpags " + ;
                "AND e.impbols = 1 " + ;
                "ORDER BY b.fpags, b.parcs"

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Selecao", "Selecao")
                IF USED("cursor_4c_Selecao")
                    SELECT cursor_4c_Selecao
                    SCAN
                        IF !THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(PADR(cursor_4c_Selecao.fpags, 12)), "cursor_4c_CfgBoleto", "ConfigBoleto") ;
                                OR !USED("cursor_4c_CfgBoleto") OR RECCOUNT("cursor_4c_CfgBoleto") = 0
                            THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(SPACE(12)), "cursor_4c_CfgBoleto", "ConfigBoleto")
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto") AND RECCOUNT("cursor_4c_CfgBoleto") > 0
                            SELECT cursor_4c_CfgBoleto
                            GO TOP

                            INSERT INTO cursor_4c_Dados (FPags, Parcs, Vencs, Datas, Valos, CLocals, CTxtCds) ;
                                VALUES (cursor_4c_Selecao.fpags, cursor_4c_Selecao.parcs, ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.vencs, {})), ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.datas, {})), ;
                                    cursor_4c_Selecao.valos, cursor_4c_CfgBoleto.clocals, ;
                                    TratarNulo(cursor_4c_CfgBoleto.ctxtcds, ""))

                            loc_nTotal = loc_nTotal + cursor_4c_Selecao.valos
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto")
                            USE IN cursor_4c_CfgBoleto
                        ENDIF

                        SELECT cursor_4c_Selecao
                    ENDSCAN
                    USE IN cursor_4c_Selecao
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_Dados")
                GO TOP IN cursor_4c_Dados
            ENDIF

            THIS.this_nTotalParcelas = loc_nTotal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao selecionar condi" + CHR(231) + CHR(245) + "es de pagamento: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do grdItens
    * legado: le o registro CORRENTE de cursor_4c_Dados (a linha selecionada
    * na grade) para as propriedades *Atual usadas pelo restante do fluxo
    * de impressao.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cFPagsAtual        = PADR(TratarNulo(FPags, ""), 12)
            THIS.this_nParcsAtual        = TratarNulo(Parcs, 0)
            THIS.this_dVencsAtual        = TratarNulo(Vencs, {})
            THIS.this_dDatasAtual        = TratarNulo(Datas, {})
            THIS.this_nValosAtual        = TratarNulo(Valos, 0)
            THIS.this_cLocalPgtoAtual    = TratarNulo(CLocals, "")
            THIS.this_cTextoCedenteAtual = TratarNulo(CTxtCds, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosDocumento - equivalente aos passos 1 a 5 de Procedure
    * imprimir() do legado (ANTES da atualizacao de SigCnFBl): resolve o
    * documento (SigMvCab), o numero/parcela impresso (SigMvNfi, com
    * fallback "Parc.: NN"), a operacao (SigCdOpe.Nfiscals, que decide se a
    * conta a cobrar eh a origem ou o destino do movimento), o cliente
    * (SigCdCli, com fallback Cobranca->Normal em endereco/bairro/cidade/
    * estado/cep) e a forma de pagamento (SigOpFp.ImpNotas). Requer que
    * CarregarDoCursor() ja tenha resolvido a parcela atual.
    *==========================================================================
    FUNCTION CarregarDadosDocumento()
        LOCAL loc_cCliente

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        *-- 1) SigMvCab - documento do movimento (Dopes, ContaOs, ContaDs)
        IF !THIS.ExecutarSQL("SELECT dopes, contaos, contads FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Documento", "Documento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Documento") OR RECCOUNT("cursor_4c_Documento") = 0
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
            THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Documento
        GO TOP
        THIS.this_cDopes   = PADR(TratarNulo(dopes, ""), 20)
        THIS.this_cContaOs = PADR(TratarNulo(contaos, ""), 10)
        THIS.this_cContaDs = PADR(TratarNulo(contads, ""), 10)
        USE IN cursor_4c_Documento

        *-- 2) SigMvNfi - numero do documento impresso (fallback: "Parc.: NN")
        THIS.this_cNumeroDocumento = LEFT("Parc.: " + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
        IF THIS.ExecutarSQL("SELECT nfis FROM SigMvNfi WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Nfis", "NotaFiscal")
            IF USED("cursor_4c_Nfis") AND RECCOUNT("cursor_4c_Nfis") > 0
                SELECT cursor_4c_Nfis
                GO TOP
                THIS.this_cNumeroDocumento = LEFT(ALLTRIM(TratarNulo(nfis, "")) + "-" + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
            ENDIF
            IF USED("cursor_4c_Nfis")
                USE IN cursor_4c_Nfis
            ENDIF
        ENDIF

        *-- 3) SigCdOpe - Nfiscals decide se a conta a cobrar eh origem ou destino
        IF !THIS.ExecutarSQL("SELECT nfiscals FROM SigCdOpe WHERE dopes = " + ;
                EscaparSQL(THIS.this_cDopes), "cursor_4c_Operacao", "Operacao")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Operacao
        GO TOP
        loc_cCliente = IIF(NVL(nfiscals, 0) = 1, THIS.this_cContaOs, THIS.this_cContaDs)
        USE IN cursor_4c_Operacao

        *-- 4) SigCdCli - cliente a cobrar, com fallback Cobranca -> Normal
        IF !THIS.ExecutarSQL("SELECT razaos, cpfs, endcobs, endes, baicobs, bairs, cidcobs, cidas, " + ;
                "estcobs, estas, cepcobs, ceps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCliente), ;
                "cursor_4c_Cliente", "Cliente")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Cliente") OR RECCOUNT("cursor_4c_Cliente") = 0
            IF USED("cursor_4c_Cliente")
                USE IN cursor_4c_Cliente
            ENDIF
            THIS.this_cMensagemErro = 'Conta "' + ALLTRIM(loc_cCliente) + '" N' + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Cliente
        GO TOP
        THIS.this_cRazaoSocial = ALLTRIM(TratarNulo(razaos, ""))
        THIS.this_cCpfCnpj     = PADR(TratarNulo(cpfs, ""), 20)
        THIS.this_cEndereco    = IIF(!EMPTY(TratarNulo(endcobs, "")), ALLTRIM(endcobs), ALLTRIM(TratarNulo(endes, "")))
        THIS.this_cBairro      = PADR(IIF(!EMPTY(TratarNulo(baicobs, "")), ALLTRIM(baicobs), ALLTRIM(TratarNulo(bairs, ""))), 20)
        THIS.this_cCidade      = PADR(IIF(!EMPTY(TratarNulo(cidcobs, "")), ALLTRIM(cidcobs), ALLTRIM(TratarNulo(cidas, ""))), 20)
        THIS.this_cEstado      = PADR(IIF(!EMPTY(TratarNulo(estcobs, "")), ALLTRIM(estcobs), ALLTRIM(TratarNulo(estas, ""))), 2)
        THIS.this_cCep         = PADR(IIF(!EMPTY(TratarNulo(cepcobs, "")), ALLTRIM(cepcobs), ALLTRIM(TratarNulo(ceps, ""))), 9)
        USE IN cursor_4c_Cliente

        *-- 5) SigOpFp - ImpNotas decide (em CarregarDadosImpressao) o vencimento impresso
        IF !THIS.ExecutarSQL("SELECT impbols, impnotas FROM SigOpFp WHERE fpags = " + ;
                EscaparSQL(PADR(THIS.this_cFPagsAtual, 12)), "cursor_4c_FormaPgto", "FormaPagamento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_FormaPgto") OR RECCOUNT("cursor_4c_FormaPgto") = 0
            IF USED("cursor_4c_FormaPgto")
                USE IN cursor_4c_FormaPgto
            ENDIF
            THIS.this_cMensagemErro = "Forma de Pagamento N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_FormaPgto
        GO TOP
        THIS.this_nImpNotasAtual = NVL(impnotas, 0)
        USE IN cursor_4c_FormaPgto

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AtualizarConfiguracaoBoleto - equivalente ao
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito dentro de Procedure imprimir() do legado (ANTES de montar o
    * layout de impressao - grava o local de pagamento/texto de cedente
    * eventualmente editados pelo usuario nos getLocals/getTxtCds, que no
    * legado estao ligados direto a crGrade.CLocals/CTxtCds). Chama
    * RegistrarAuditoria("UPDATE") no sucesso (ver ObterChavePrimaria acima).
    *
    * O legado NAO para no UPDATE: logo depois dele vem um SEGUNDO teste,
    * "If (ThisForm.poDataMgr.Commit() < 1)", com a MESMA mensagem de falha -
    * porque o fSqlConector do Framework abre a conexao em transacao MANUAL
    * (cOpenConn.Init seta Transactions = 2 de proposito) e sem o Commit o
    * UPDATE nao eh efetivado. Neste ambiente a premissa se mantem: medido em
    * 2026-09-18 num VFP9 virgem, SQLGETPROP(0, "Transactions") ja vale 2, de
    * modo que gnConnHandle tambem nasce manual. Sem este Commit, a edicao do
    * local de pagamento / texto do cedente ficaria presa na transacao aberta
    * e SUMIRIA se o processo morresse - sem erro nenhum na tela, porque o
    * SELECT de conferencia na MESMA conexao enxerga a propria transacao.
    * Commit/Rollback so quando a conexao esta de fato em modo manual (mesmo
    * criterio de SIGPRCNBBO.prg:471) - em auto-commit o par seria inerte.
    *==========================================================================
    FUNCTION AtualizarConfiguracaoBoleto()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_lManual, loc_cFalha

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cFPagsAtual))
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        loc_cSQL = "UPDATE SigCnFBl SET " + ;
            "clocals = " + EscaparSQL(THIS.this_cLocalPgtoAtual) + ", " + ;
            "ctxtcds = " + EscaparSQL(THIS.this_cTextoCedenteAtual) + " " + ;
            "WHERE fpags = " + EscaparSQL(PADR(THIS.this_cFPagsAtual, 12))

        *-- Mensagem UNICA para as duas falhas, como no legado (UPDATE e
        *-- Commit exibem o mesmo texto, com o mesmo titulo).
        loc_cFalha = "A Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Pode Ser Atualizada!!!" + ;
            CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_nRet    = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nRet < 0
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
        ELSE
            loc_lResultado = .T.

            *-- Equivalente ao "If (ThisForm.poDataMgr.Commit() < 1)" do
            *-- legado: SQLCOMMIT devolve 1 no sucesso e -1 no erro. IF
            *-- ANINHADO, nao "loc_lManual AND SQLCOMMIT(...)": o VFP9 NAO faz
            *-- curto-circuito em AND/OR e chamaria SQLCOMMIT tambem com a
            *-- conexao em auto-commit.
            IF loc_lManual
                IF SQLCOMMIT(gnConnHandle) <= 0
                    = SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria("UPDATE")
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoLayout - equivalente a
    * "If Not CursorQuery(SigCnFBl, LocalCfgBl, FPags, crGrade.FPags) Then
    *  CursorQuery(..., FPags, Space(12))" do legado: carrega a configuracao
    * de posicoes de impressao para o FPags atual, com fallback para a
    * configuracao em branco. Reusa SIGPRIBLBO (mesma tabela SigCnFBl, ja
    * migrada) em vez de duplicar as propriedades de posicao.
    *==========================================================================
    FUNCTION CarregarConfiguracaoLayout()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        THIS.this_oConfigBoleto = CREATEOBJECT("SIGPRIBLBO")

        IF !THIS.this_oConfigBoleto.BuscarConfiguracao(PADR(THIS.this_cFPagsAtual, 12))
            THIS.this_oConfigBoleto.BuscarConfiguracao(SPACE(12))
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_oConfigBoleto.this_cIdChaves))
            THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ELSE
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarImpressoraDisponivel - equivalente ao bloco
    * "Declare laPrn(1) / If (APrinters(laPrn) > 0) ..." do legado: confirma
    * que a impressora configurada em SigCnFBl.CNomeImps esta instalada no
    * Windows. Requer que CarregarConfiguracaoLayout() ja tenha resolvido
    * THIS.this_oConfigBoleto.
    *==========================================================================
    FUNCTION VerificarImpressoraDisponivel()
        LOCAL loc_lResultado, loc_nQtd, loc_nI
        LOCAL ARRAY loc_aImpressoras(1)

        loc_lResultado = .F.

        loc_nQtd = APRINTERS(loc_aImpressoras)
        IF loc_nQtd > 0
            FOR loc_nI = 1 TO loc_nQtd
                IF UPPER(ALLTRIM(loc_aImpressoras(loc_nI, 1))) == UPPER(ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
                    loc_lResultado = .T.
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Impressora de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosImpressao - equivalente ao bloco final de dados de
    * Procedure imprimir() do legado: resolve o vencimento impresso
    * (ldVct = Iif(ImpNotas = 1, Dtoc(Vencs), FPags)) e monta
    * cursor_4c_Impressao (crDados) com os dados ja resolvidos por
    * CarregarDadosDocumento()/CarregarDoCursor().
    *==========================================================================
    FUNCTION CarregarDadosImpressao()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        THIS.this_cLocalPgtoImpressao = THIS.this_cLocalPgtoAtual
        THIS.this_cVencimentoImpresso = PADR(IIF(THIS.this_nImpNotasAtual = 1, DTOC(THIS.this_dVencsAtual), THIS.this_cFPagsAtual), 12)
        THIS.this_dDataDocumento      = THIS.this_dDatasAtual
        THIS.this_nValorImpressao     = THIS.this_nValosAtual
        THIS.this_cTextoComplementar  = THIS.this_cTextoCedenteAtual

        TRY
            IF USED("cursor_4c_Impressao")
                USE IN cursor_4c_Impressao
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Impressao (CLocals C(100), Vencs C(12), DatDoc D, NumDoc C(8), Valor N(14,2), ;
                Razaos C(50), Cpfs C(20), EndCobs C(80), BaiCobs C(20), CidCobs C(20), EstCobs C(2), CepCobs C(9), Texto M)
            SET NULL OFF

            INSERT INTO cursor_4c_Impressao (CLocals, Vencs, DatDoc, NumDoc, Valor, Razaos, Cpfs, Texto, ;
                EndCobs, BaiCobs, CidCobs, EstCobs, CepCobs) ;
                VALUES (THIS.this_cLocalPgtoImpressao, THIS.this_cVencimentoImpresso, THIS.this_dDataDocumento, ;
                    THIS.this_cNumeroDocumento, THIS.this_nValorImpressao, THIS.this_cRazaoSocial, THIS.this_cCpfCnpj, ;
                    THIS.this_cTextoComplementar, THIS.this_cEndereco, THIS.this_cBairro, THIS.this_cCidade, ;
                    THIS.this_cEstado, THIS.this_cCep)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar dados de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InserirLinhaImpressao - equivalente a ThisForm.Detalhe(...) do legado:
    * insere uma linha em cursor_4c_LayoutImpressao (TmpImprime) SOMENTE
    * quando a posicao esta configurada (Linha<>0 Or Coluna<>0) - posicao
    * zerada em SigCnFBl significa "este campo nao imprime neste layout".
    * Todas as 13 chamadas do legado omitem o 4o parametro (lcEst), que cai
    * no default "X" - por isso o estilo nao eh exposto aqui.
    *==========================================================================
    PROTECTED PROCEDURE InserirLinhaImpressao(par_nLinha, par_nColuna, par_cConteudo, par_nTamanho, par_nAltura)
        LOCAL loc_nLinha, loc_nColuna, loc_cConteudo

        loc_nLinha    = TratarNulo(par_nLinha, 0)
        loc_nColuna   = TratarNulo(par_nColuna, 0)
        loc_cConteudo = TratarNulo(par_cConteudo, "")

        IF loc_nColuna <> 0 OR loc_nLinha <> 0
            INSERT INTO cursor_4c_LayoutImpressao (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                VALUES (loc_nLinha, loc_nColuna, loc_cConteudo, "X", TratarNulo(par_nTamanho, 0), TratarNulo(par_nAltura, 0))
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarLayoutImpressao - equivalente aos 13 ThisForm.Detalhe(...) de
    * Procedure imprimir() do legado: monta cursor_4c_LayoutImpressao
    * (TmpImprime) com cada campo do boleto na posicao (Linha/Coluna)
    * configurada em THIS.this_oConfigBoleto. Requer que
    * CarregarConfiguracaoLayout() e CarregarDadosImpressao() ja tenham
    * rodado.
    *==========================================================================
    FUNCTION MontarLayoutImpressao()
        LOCAL loc_lResultado, loc_oCfg, loc_oErro

        loc_lResultado = .F.
        loc_oCfg = THIS.this_oConfigBoleto

        TRY
            IF USED("cursor_4c_LayoutImpressao")
                USE IN cursor_4c_LayoutImpressao
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_LayoutImpressao (Linha N(6,2), Coluna N(6,2), Conteudo C(100), Style C(3), LineSize N(6,2), NHeight N(6,2))
            SET NULL OFF
            INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem

            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnLocals,  loc_oCfg.this_nClLocals,  THIS.this_cLocalPgtoImpressao,   60, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtVencs, loc_oCfg.this_nClDtVencs, THIS.this_cVencimentoImpresso,    9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtDocs,  loc_oCfg.this_nClDtDocs,  DTOC(THIS.this_dDataDocumento),   9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnNrDocs,  loc_oCfg.this_nClNrDocs,  THIS.this_cNumeroDocumento,       9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnVlDocs,  loc_oCfg.this_nClVlDocs,  TRANSFORM(THIS.this_nValorImpressao, "@Z 999,999,999.99"), 15, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnRazClis, loc_oCfg.this_nClRazClis, ALLTRIM(THIS.this_cRazaoSocial),  50, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCgcClis, loc_oCfg.this_nClCgcClis, ALLTRIM(THIS.this_cCpfCnpj),      20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEndCobs, loc_oCfg.this_nClEndCobs, ALLTRIM(THIS.this_cEndereco),     80, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnBaiCobs, loc_oCfg.this_nClBaiCobs, ALLTRIM(THIS.this_cBairro),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCidCobs, loc_oCfg.this_nClCidCobs, ALLTRIM(THIS.this_cCidade),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEstCobs, loc_oCfg.this_nClEstCobs, ALLTRIM(THIS.this_cEstado),        2, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCepCobs, loc_oCfg.this_nClCepCobs, ALLTRIM(THIS.this_cCep),           9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnTxtCds,  loc_oCfg.this_nClTxtCds,  THIS.this_cTextoComplementar,     60, 6)

            IF USED("cursor_4c_LayoutImpressao")
                GO TOP IN cursor_4c_LayoutImpressao
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar layout de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTamanhoFolha - equivalente ao parse de LocalCfgBl.CTamFolha do
    * legado (formato "A/largura/B" - extrai o 2o segmento, separado por
    * "/", como tamanho numerico da folha/pagina).
    *==========================================================================
    PROTECTED FUNCTION ObterTamanhoFolha()
        LOCAL loc_cTamFolha, loc_nPos1, loc_nPos2

        loc_cTamFolha = TratarNulo(THIS.this_oConfigBoleto.this_cTamFolha, "")
        loc_nPos1 = AT("/", loc_cTamFolha, 1) + 1
        loc_nPos2 = AT("/", loc_cTamFolha, 2) - (AT("/", loc_cTamFolha, 1) + 1)

        IF loc_nPos2 <= 0
            RETURN 0
        ENDIF

        RETURN VAL(ALLTRIM(SUBSTR(loc_cTamFolha, loc_nPos1, loc_nPos2)))
    ENDFUNC

    *==========================================================================
    * ExecutarImpressaoMatricial - equivalente a
    * "Do SigPrIbl With [TmpImprime], CNomeImps, [To Printer NoConsole], ...,
    * [crDados], 17" do legado: envia cursor_4c_LayoutImpressao para a
    * impressora configurada, posicionando cada linha por Linha/Coluna. A
    * rotina generica de impressao matricial do legado (p-code de
    * SIGFUNCS.PRG, fora do acervo) nao existe para ser chamada - a
    * reproducao fiel usa os comandos nativos de impressora do VFP9 sobre
    * os MESMOS dados (mesmas posicoes, mesmo conteudo) preparados acima.
    * Suprimida em gb_4c_ModoTeste para nao depender de impressora real
    * durante os testes automatizados.
    *==========================================================================
    PROTECTED FUNCTION ExecutarImpressaoMatricial()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF !USED("cursor_4c_LayoutImpressao")
            THIS.this_cMensagemErro = "Layout de impress" + CHR(227) + "o n" + CHR(227) + "o gerado."
            RETURN .F.
        ENDIF

        TRY
            SET PRINTER TO NAME (ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
            SET DEVICE TO PRINTER

            SELECT cursor_4c_LayoutImpressao
            SCAN
                @ INT(Linha), INT(Coluna) SAY ALLTRIM(Conteudo)
            ENDSCAN

            EJECT
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT

            loc_lResultado = .T.
        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            THIS.this_cMensagemErro = "Erro ao imprimir boleto banc" + CHR(225) + "rio: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ImprimirBoleto - equivalente a Procedure imprimir() do legado completa
    * (chamada por btnImprimir.Click apos a confirmacao do usuario): exige
    * que CarregarDoCursor() ja tenha resolvido a parcela selecionada, e
    * encadeia resolucao de documento/cliente, atualizacao da configuracao
    * de boleto, carga do layout, checagem de impressora, montagem dos
    * dados e do layout de impressao, e o disparo da impressao em si.
    *==========================================================================
    FUNCTION ImprimirBoleto()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosDocumento()
            RETURN .F.
        ENDIF

        IF !THIS.AtualizarConfiguracaoBoleto()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarConfiguracaoLayout()
            RETURN .F.
        ENDIF

        IF !THIS.VerificarImpressoraDisponivel()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosImpressao()
            RETURN .F.
        ENDIF

        IF !THIS.MontarLayoutImpressao()
            RETURN .F.
        ENDIF

        loc_lResultado = THIS.ExecutarImpressaoMatricial()

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
