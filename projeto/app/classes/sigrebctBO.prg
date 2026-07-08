*==============================================================================
* SIGREBCTBO.PRG
* BO do Relatorio Balancete de Conta Corrente (SIGREBCT)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrebctBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial   = {}
    this_dDtSaldo     = {}

    *-- Filtros de moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros de empresa
    this_cCdEmpresa   = ""
    this_cDsEmpresa   = ""

    *-- Opcoes de geracao (optiongroups - valores default identicos ao original)
    *   this_nContaz:  1=Sim (exibe conta zerada), 2=Nao
    this_nContaz      = 1
    *   this_nTipoRel: 1=Analitico, 2=Sintetico
    this_nTipoRel     = 1
    *   this_nOptCli:  1=Analitico, 2=Sintetico
    this_nOptCli      = 1
    *   this_nOptCot:  1=Fechamento, 2=Movimentacao
    this_nOptCot      = 1
    *   this_nOptConc: 1=Sim (usar saldo conciliado), 2=Nao
    this_nOptConc     = 2
    *   this_nNrOpcao: 1=Sim (com NF), 2=Nao (sem NF), 3=Ambos
    this_nNrOpcao     = 3

    *-- Configuracao do relatorio
    this_cTitulo      = ""
    this_cCaminhoFRX  = ""
    this_cCursorDados = "cursor_4c_Balancete"

    *--------------------------------------------------------------------------
    * Init - Configura titulo e caminho do FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTitulo    = "Balancete"
            THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "RelSigrebct.frx"
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
