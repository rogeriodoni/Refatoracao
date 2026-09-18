*==============================================================================
* RELATORIOPLANOCONTAS.PRG
* Classe de relatorio para Plano de Contas
*
* Herda de: RelatorioBase
* Arquivo FRX: RelPlanoContas.frx
*
* REGRAS APLICADAS:
* - Nomenclatura: loc_ para locais, par_ para parametros, this_ para classe
* - Cursores: cursor_4c_Nome
*==============================================================================

DEFINE CLASS RelatorioPlanoContas AS RelatorioBase

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_cArquivoFRX

        * Definir caminho do arquivo FRX
        loc_cArquivoFRX = gcCaminhoReports + "RelPlanoContas.frx"

        * Chamar construtor da classe base
        DODEFAULT(loc_cArquivoFRX, "Relatorio do Plano de Contas")

        * Nome do cursor que sera usado pelo relatorio
        * IMPORTANTE: O FRX original espera cursor chamado "cPlConta"
        THIS.this_cCursorDados = "cPlConta"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara os dados para o relatorio
    * Nota: Os dados ja foram preparados pelo BO e passados via this_cCursorDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        * Verificar se o cursor de dados existe
        IF EMPTY(THIS.this_cCursorDados)
            THIS.this_cMensagemErro = "Cursor de dados nao definido"
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorDados)
            THIS.this_cMensagemErro = "Cursor de dados nao encontrado: " + THIS.this_cCursorDados
            RETURN .F.
        ENDIF

        IF RECCOUNT(THIS.this_cCursorDados) = 0
            THIS.this_cMensagemErro = "Nenhum registro para imprimir"
            RETURN .F.
        ENDIF

        * Selecionar o cursor e posicionar no inicio
        SELECT (THIS.this_cCursorDados)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Sobrescreve para NAO fechar o cursor
    * O cursor sera fechado pelo BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        * Nao fecha o cursor aqui, pois ele foi criado pelo BO
        * e sera gerenciado por ele
    ENDPROC

ENDDEFINE
