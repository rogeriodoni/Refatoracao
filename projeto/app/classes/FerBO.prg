*==============================================================================
* FerBO.prg - Business Object para Cadastro de Feriados
* Tabela: SigCdFer
* Arquitetura: 3 Camadas (Form -> BO -> DataAccess)
*==============================================================================

DEFINE CLASS FerBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas para SigCdFer)
    this_cCidChaves   = ""  && char(20)      - Chave primaria (cidchaves)
    this_dDatas       = {}  && datetime      - Data do feriado (datas)
    this_cDescrs      = ""  && char(30)      - Descricao (descrs)
    this_cEmps        = ""  && char(3)       - Empresa (emps)
    this_nChkTrbEsc   = 0   && numeric(1,0)  - Nao se Aplica ao Escritorio (chktrbesc)

    *-- Propriedades auxiliares (exibicao - nao gravadas na tabela principal)
    this_cNomeEmpresa = ""  && Razao social da empresa (SigCdEmp.razas)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFer"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

ENDDEFINE
