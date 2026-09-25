*====================================================================
* SigMvComBO.prg
*
* Business Object para Distribuicao de Comissoes por Grupo/Conta (C.C.)
* Tela modal chamada a partir de SigMvCab para editar as linhas de
* comissao (cursor TmpComiss, mantido pelo form pai) e validar as
* combinacoes Grupo/Conta contra SigCcCpe (grupos/contas cadastrados
* para a operacao corrente).
*
* Tabela de referencia (lookup): SigCcCpe
* Chave: cidchaves (PK Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigMvComBO AS BusinessBase

    *-- Contexto recebido do form pai (SigMvCab) ao abrir a tela modal
    this_cDopes        = ""    && dopes        char(20) - operacao (TprMvCab.Dopes)
    this_nValorTitulo  = 0     && valos        numeric(11,2) - TprMvCab.Valos (base do 1o lancamento)
    this_lEdicao       = .F.   && Thisform.Edicao - .T. permite editar a grade
    this_cAreaDados    = ""    && Thisform.Areadados - alias do cursor TmpComiss (do form pai)
    this_cCursorOpcoes = ""    && alias do cursor local com os grupos/contas validos (xCcOpe)

    *-- Linha corrente da grade (mapeamento para cursor TmpComiss)
    this_cGrupos       = ""    && grupos       char(10)
    this_cGruCads      = ""    && grucads      char(10)
    this_cContas       = ""    && contas       char(10)
    this_nCtFils       = 0     && ctfils       numeric(1,0)
    this_nBases        = 0     && bases        numeric(11,2)
    this_nComissaos    = 0     && comissaos    numeric(11,2)
    this_cMoedas       = ""    && moedas       char(3)
    this_cLinhas       = ""    && linhas       char(10)
    this_cDescricao    = ""    && descricao    char(60)
    this_nPercs        = 0     && percs        numeric(5,2)
    this_nJuros        = 0     && juros        numeric(5,2)
    this_nImpostos     = 0     && impostos     numeric(5,2)
    this_lFlags        = .F.   && flags        logical - marca linha valida/ativa

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCpe"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, "SigMvComBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
