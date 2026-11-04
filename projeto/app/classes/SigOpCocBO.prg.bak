*==============================================================================
* SigOpCocBO.prg - Business Object para Carta de Operacoes de Cheques
* Origem: SigOpCoc.SCX (task705)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo filho modal, aberto por FormOpt / cmd_4c_BtnCarta)
* Tabela: SigCdOpt | PK: operacaos
* Gerado: Fase 1/8 - Propriedades e Init
*
* CONTRATO DO LEGADO (SIGOPCOC.SCX)
*   Init(pDatasession, pEscolha):
*       Set DataSession to pDatasession
*       ThisForm.pcEscolha = pEscolha
*       Select CrSigCdOpt
*       getCabs.Value = CrSigCdOpt.Cabs
*       getRods.Value = CrSigCdOpt.Rods
*       Se pcEscolha em (CONSULTAR, EXCLUIR, PROCURAR): oculta OK e deixa
*       os dois EditBox com ReadOnly = .T.
*   OK.Click:
*       Select CrSigCdOpt
*       Replace Cabs With getCabs.Value, Rods With getRods.Value
*       ThisForm.Release
*   Sair.Click:
*       ThisForm.Release   (descarta a edicao)
*
* CONSEQUENCIA PARA A MIGRACAO
*   O dialogo NAO grava direto no SQL Server: nao ha Insert Into / Update /
*   Delete From, nao ha TABLEUPDATE e nao ha .AddCursor no dump. A "gravacao"
*   dele, fiel ao legado, eh devolver Cabs/Rods ao registro em edicao do form
*   PAI (FormOpt / OptBO) via Replace - por isso Inserir()/Atualizar() abaixo
*   NAO montam SQL para SigCdOpt (isso inventaria operacao que o legado nao
*   tem): eles delegam para this_oBOOrigem (ou, na falta dele, fazem o Replace
*   direto no alias this_cCursorOrigem). Quem persiste de fato em SigCdOpt
*   continua sendo o OptBO do form pai, no Salvar() dele.
*   ExecutarExclusao() permanece NAO sobrescrito: o legado nao tem exclusao
*   nesta tela, e o comportamento herdado de BusinessBase (recusar e reportar
*   via ExibirFalha) ja eh o correto.
*
*   O cursor global CrSigCdOpt do Fortyus NAO existe nesta migracao (ver
*   FormSigOpChi.prg:3346). A ligacao com o registro em edicao eh feita por
*   this_oBOOrigem (referencia ao OptBO do form pai), com this_cCursorOrigem
*   como caminho alternativo quando o alias estiver aberto na sessao.
*==============================================================================

DEFINE CLASS SigOpCocBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpt"
    this_cCampoChave  = "operacaos"

    *--------------------------------------------------------------------------
    * Dados editados pelo dialogo - colunas de SigCdOpt
    *--------------------------------------------------------------------------
    this_cOperacaos        = ""    && operacaos char(15) - PK do registro em edicao
    this_cCabs             = ""    && cabs      text     - getCabs: cabecalho da carta
    this_cRods             = ""    && rods      text     - getRods: rodape da carta

    *--------------------------------------------------------------------------
    * Valores de entrada - usados para Cancelar e para detectar alteracao
    * O Sair.Click do legado descarta a edicao; guardar o valor que chegou eh
    * o que permite restaurar sem reconsultar a origem.
    *--------------------------------------------------------------------------
    this_cCabsOriginal     = ""    && valor de cabs no momento em que o dialogo abriu
    this_cRodsOriginal     = ""    && valor de rods no momento em que o dialogo abriu

    *--------------------------------------------------------------------------
    * Protocolo do dialogo - parametros do Init legado
    *--------------------------------------------------------------------------
    this_cEscolha          = ""    && pcEscolha: INSERIR / ALTERAR / CONSULTAR / EXCLUIR / PROCURAR
    this_nDataSession      = 0     && pDatasession: id da sessao de dados do form pai
    this_lSomenteLeitura   = .F.   && .T. em CONSULTAR / EXCLUIR / PROCURAR (oculta OK, campos ReadOnly)
    this_lConfirmado       = .F.   && .T. somente quando o usuario acionou OK (nao Cancelar)

    *--------------------------------------------------------------------------
    * Ligacao com a origem dos dados (equivalente ao Select CrSigCdOpt legado)
    *--------------------------------------------------------------------------
    this_cCursorOrigem     = "CrSigCdOpt"   && alias do cursor do registro em edicao, quando aberto
    this_oBOOrigem         = .NULL.         && referencia ao OptBO do form pai (caminho canonico)

    *==========================================================================
    * Init - Configura tabela e campo chave
    * NUNCA devolver .F. daqui: BO.Init() falso mata o form (o CREATEOBJECT
    * do chamador recebe .F. e o dialogo nao abre).
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdOpt"
        THIS.this_cCampoChave = "operacaos"

        *-- O dialogo nasce sem confirmacao: somente o OK marca
        *-- this_lConfirmado. Reset explicito porque o BO pode ser
        *-- reaproveitado entre aberturas do dialogo no mesmo form pai.
        THIS.this_lConfirmado     = .F.
        THIS.this_lSomenteLeitura = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOperacaos)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega operacaos/cabs/rods do cursor em edicao
    * Equivalente ao Init legado: Select CrSigCdOpt / getCabs.Value = Cabs /
    * getRods.Value = Rods. NAO eh PROTECTED: o form chama de fora (THIS.
    * this_oBusinessObject.CarregarDoCursor(...)), igual aos demais BOs CRUD.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("Operacaos") != "U"
                    THIS.this_cOperacaos = TratarNulo(Operacaos, "")
                ENDIF
                IF TYPE("Cabs") != "U"
                    THIS.this_cCabs = TratarNulo(Cabs, "")
                ENDIF
                IF TYPE("Rods") != "U"
                    THIS.this_cRods = TratarNulo(Rods, "")
                ENDIF

                *-- guarda o valor de entrada para o Sair/Cancelar restaurar
                THIS.this_cCabsOriginal = THIS.this_cCabs
                THIS.this_cRodsOriginal = THIS.this_cRods

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "SigOpCocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarNaOrigem - Operacao REAL de gravacao deste dialogo: devolve Cabs/
    * Rods ao registro do form pai, igual ao OK.Click legado (Replace Cabs
    * With getCabs.Value, Rods With getRods.Value In CrSigCdOpt).
    * Chamada por Inserir()/Atualizar() - o legado nao distingue os dois
    * casos (o Click eh unico), por isso os dois delegam para aqui.
    *==========================================================================
    PROTECTED FUNCTION GravarNaOrigem(par_cOperacao)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBOOrigem) = "O"
                *-- caminho canonico: devolve os valores ao BO do form pai
                THIS.this_oBOOrigem.this_cCabs = THIS.this_cCabs
                THIS.this_oBOOrigem.this_cRods = THIS.this_cRods
                loc_lSucesso = .T.
            ELSE
                IF VARTYPE(THIS.this_cCursorOrigem) = "C" AND !EMPTY(THIS.this_cCursorOrigem) ;
                        AND USED(THIS.this_cCursorOrigem)
                    *-- caminho alternativo: Replace direto no alias aberto na sessao
                    SELECT (THIS.this_cCursorOrigem)
                    REPLACE Cabs WITH THIS.this_cCabs, ;
                            Rods WITH THIS.this_cRods
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel localizar o registro de origem para gravar Cabe" + CHR(231) + ;
                        "alho/Rodap" + CHR(233) + "."
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_lConfirmado = .T.
                THIS.RegistrarAuditoria(par_cOperacao)
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao gravar Cabe" + CHR(231) + "alho/Rodap" + CHR(233) + ;
                ": " + loException.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - delega para GravarNaOrigem (o legado nao distingue
    * INSERIR/ALTERAR no Click; os dois produzem o mesmo Replace)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN THIS.GravarNaOrigem("INSERT")
    ENDPROC

    *==========================================================================
    * Atualizar - delega para GravarNaOrigem (caso de uso real deste dialogo:
    * ele sempre edita um registro ja existente no form pai)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN THIS.GravarNaOrigem("UPDATE")
    ENDPROC

ENDDEFINE
