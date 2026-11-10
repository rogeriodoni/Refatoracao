*==============================================================================
* SIGOPGVTBO.PRG
* Business Object - Verificacao de Status de Gaveta (Cadastro de Testes)
* Origem: SigOpGvt.SCX (Framework legado Fortyus)
*==============================================================================

DEFINE CLASS SigOpGvtBO AS BusinessBase

    *-- Propriedades (espelham as propriedades customizadas do form legado:
    *-- impressora, oformulario, portaserial)
    this_cImpressora = ""      && Tipo/modelo da impressora fiscal (DATAREGIS, SWEDA, BEMATECH, DARUMA, EPSON, ELGIN, "Gaveta Serial")
    this_oFormulario = .NULL.  && Referencia ao formulario chamador (usado pelas rotinas de status da impressora)
    this_nPortaSerial = 0      && Numero da porta serial (usado quando this_cImpressora = "Gaveta Serial")

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Este BO nao possui tabela associada (form operacional sem persistencia
    * em banco de dados - apenas verifica o status fisico da gaveta na
    * impressora fiscal)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cImpressora = ""
        THIS.this_oFormulario = .NULL.
        THIS.this_nPortaSerial = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO (Fase 2 - CRUD):
    * Este BO NAO possui CarregarDoCursor(), Inserir() nem Atualizar() porque
    * o form legado (SigOpGvt.SCX) nao le nem grava NENHUMA tabela - o unico
    * metodo com codigo real (ok.Click) apenas consulta o status FISICO da
    * gaveta de dinheiro na impressora fiscal configurada por quem abriu o
    * dialogo (Do Form SigOpGvt With _Imp, _oForm, _nPorta). O comportamento
    * padrao herdado de BusinessBase para Inserir()/Atualizar()/
    * ExecutarExclusao() ja eh o correto para este caso.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * VerificarStatusGaveta - Transcricao literal do PROCEDURE Click do botao
    * "ok" (SIGOPGVT.ok.Click no dump legado). Consulta o status da gaveta na
    * impressora fiscal apontada por this_cImpressora. Retorna .T. quando a
    * gaveta esta FECHADA (dialogo pode ser encerrado); .F. quando ainda esta
    * ABERTA (dialogo permanece aberto, mensagem de aviso continua visivel).
    *
    * RotStatus()/StatGaveta()/fChecarSerial() sao funcoes globais do legado
    * (sig.prg/SIGFUNCS.PRG) AUSENTES POR DESENHO (CLAUDE.md regra #27) - elas
    * conversam com o driver fisico da impressora fiscal/porta serial e
    * devolvem VALOR de hardware; um wrapper no-op gravaria status errado
    * (mesmo criterio ja adotado para RotStatus()/FinFimVinc() em
    * Formsigprtef.prg). Chamar essas funcoes direto, sem wrapper.
    *--------------------------------------------------------------------------
    FUNCTION VerificarStatusGaveta()
        LOCAL loc_lOk, loc_VerStatus

        loc_lOk = .T.

        DO CASE
            CASE INLIST(THIS.this_cImpressora, "DATAREGIS", "NDATAREGIS")
                loc_VerStatus = RotStatus(.T., THIS.this_oFormulario)
                IF VARTYPE(loc_VerStatus) != "L" AND SUBSTR(loc_VerStatus, 4, 1) = "S"
                    loc_lOk = .F.
                ENDIF

            CASE INLIST(THIS.this_cImpressora, "SWEDA", "NSWEDA")
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "0"
                    loc_lOk = .F.
                ENDIF

            CASE INLIST(THIS.this_cImpressora, "BEMATECH", "BEMA8501", "DARUMA", "EPSON")
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "00"
                    loc_lOk = .F.
                ENDIF

            CASE THIS.this_cImpressora = "ELGIN"
                loc_VerStatus = StatGaveta(THIS.this_oFormulario)
                IF loc_VerStatus = "0"
                    loc_lOk = .F.
                ENDIF

            CASE THIS.this_cImpressora = "Gaveta Serial"
                IF !fChecarSerial(THIS.this_nPortaSerial)
                    loc_lOk = .F.
                ENDIF
        ENDCASE

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE
