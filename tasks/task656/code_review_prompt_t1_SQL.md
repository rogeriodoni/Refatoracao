# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, GRUPOOS, CONTADS, DOPES, CONTAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, GRUPOOS, CONTADS, DOPES, CONTAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, GRUPOOS, CONTADS, DOPES, CONTAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, GRUPOOS, CONTADS, DOPES, CONTAOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, GRUPOOS, CONTADS, DOPES, CONTAOS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQuery = [Select MoedaPs,MascNums ] + ;
		    [From SigCdPam ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Datas, a.Valos, b.CMoes ] + ;
		    [From SigMvCab a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
Select crSigMvCab
	Insert Into TmpOper (Emps, Dopes, MascNum, Tipo, Datas, Valos, Moeda) ;
lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Datas, a.Valos, b.CMoes ] + ;
		    [From SigMvCab a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
Select crSigMvCab
	Insert Into TmpOper (Emps, Dopes, MascNum, Tipo, Datas, Valos, Moeda) ;
Select TmpOper

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1154 linhas total):

*-- Linhas 84 a 102:
84: * fConfigGeral era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao
85: * veio no acervo; o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg
86: * existe so para o p-code dos VCX legado continuar resolvendo o nome, e em
87: * codigo NOSSO nunca se chama fConfigGeral. O "Create Cursor TmpOper" do
88: * mesmo Load esta reproduzido em SigOpCclBO.RecriarCursorOperacoes (mesma
89: * ordem de campos do dump), chamado por BuscarOperacoes - nao ha grade
90: * ligada a este cursor nesta tela (ele so e repassado ao SigOpClp), logo
91: * recria-lo so no 1o clique em Consultar, em vez de no Load/Init, nao muda
92: * nenhum comportamento visivel.
93: *==============================================================================
94: 
95: DEFINE CLASS FormSigOpCcl AS FormBase
96: 
97:     Height      = 300
98:     Width       = 720
99:     Caption     = ""
100:     TitleBar    = 0
101:     ShowWindow  = 1
102:     ControlBox  = .F.

*-- Linhas 584 a 602:
584:                 loc_oBusca.Show()
585: 
586:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
587:                     SELECT cursor_4c_BuscaGcr
588:                     THIS.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
589: 
590:                     THIS.this_oBusinessObject.ObterTipoCadastro(ALLTRIM(cursor_4c_BuscaGcr.codigos))
591:                     IF THIS.this_oBusinessObject.this_lGrupoEncontrado
592:                         THIS.AplicarLayoutTpCads(THIS.this_oBusinessObject.this_nTpCads)
593:                     ENDIF
594:                 ENDIF
595: 
596:                 loc_oBusca.Release()
597:             ENDIF
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupGrupo")
600:         ENDTRY
601: 
602:         IF USED("cursor_4c_BuscaGcr")

*-- Linhas 660 a 678:
660:                 loc_oBusca.Show()
661: 
662:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
663:                     SELECT cursor_4c_BuscaConta
664:                     IF THIS.this_oBusinessObject.CarregarContaPorCodigo(ALLTRIM(cursor_4c_BuscaConta.IClis))
665:                         THIS.BOParaForm(.T., .F.)
666:                     ENDIF
667:                 ENDIF
668: 
669:                 loc_oBusca.Release()
670:             ENDIF
671:         CATCH TO loc_oErro
672:             MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupConta")
673:         ENDTRY
674: 
675:         IF USED("cursor_4c_BuscaConta")
676:             USE IN cursor_4c_BuscaConta
677:         ENDIF
678:     ENDPROC

*-- Linhas 732 a 750:
732:                 loc_oBusca.Show()
733: 
734:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNome")
735:                     SELECT cursor_4c_BuscaNome
736:                     IF THIS.this_oBusinessObject.CarregarContaPorCodigo(ALLTRIM(cursor_4c_BuscaNome.IClis))
737:                         THIS.BOParaForm(.T., .T.)
738:                     ENDIF
739:                 ENDIF
740: 
741:                 loc_oBusca.Release()
742:             ENDIF
743:         CATCH TO loc_oErro
744:             MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupDConta")
745:         ENDTRY
746: 
747:         IF USED("cursor_4c_BuscaNome")
748:             USE IN cursor_4c_BuscaNome
749:         ENDIF
750:     ENDPROC

*-- Linhas 843 a 861:
843:                 loc_oBusca.Show()
844: 
845:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
846:                     SELECT cursor_4c_BuscaCpf
847:                     THIS.cnt_4c_Origem.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCpf.Cpfs)
848:                     THIS.cnt_4c_Origem.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCpf.IClis)
849:                     THIS.cnt_4c_Origem.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCpf.RClis)
850:                 ENDIF
851: 
852:                 loc_oBusca.Release()
853:             ENDIF
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message, "FormSigOpCcl.AbrirLookupCpf")
856:         ENDTRY
857: 
858:         IF USED("cursor_4c_BuscaCpf")
859:             USE IN cursor_4c_BuscaCpf
860:         ENDIF
861:     ENDPROC

*-- Linhas 1026 a 1046:
1026:     * Legado:
1027:     *   ThisForm.Enabled = .f.
1028:     *   Zap In TmpOper
1029:     *   ... (SqlExecute de SigCdPam/SigMvCab, com Wait Window NoWait entre as
1030:     *        duas consultas - combinadas aqui numa unica BuscarOperacoes())
1031:     *   Select TmpOper / Set Order To Num / Go Top
1032:     *   If Eof()
1033:     *       MessageBox('Nenhuma Movimentacao Foi Encontrada!!!')
1034:     *       ThisForm.Enabled = .t.
1035:     *       ThisForm.Origem.Get_Grupo.SetFocus
1036:     *   Else
1037:     *       Do Form SigOpClp with ThisForm,ThisForm.datasessionid
1038:     *   EndIf
1039:     *
1040:     * SigOpClp fica FORA do escopo desta migracao (ver comentario no topo do
1041:     * arquivo) - a chamada DO FORM eh mantida literal, apontando para o form
1042:     * legado ainda nao migrado, no mesmo padrao do restante da familia SigOp*
1043:     * (Formsigopind.prg).
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnConsultaClick()
1046:         LOCAL loc_oErro

*-- Linhas 1095 a 1113:
1095:     * ("ThisForm.poDataMgr.Release"): fecha o que a tela abriu antes de
1096:     * devolver o controle ao menu.
1097:     *
1098:     * O cursor de movimentacoes (cursor_4c_Operacoes, o "Create Cursor TmpOper"
1099:     * que o legado faz no Load) vive na data session COMPARTILHADA - este form
1100:     * eh DataSession = 1, igual ao legado -, entao sem este fechamento ele
1101:     * sobrevive ao form, levando consigo os dois INDEX ON, e vaza para a tela
1102:     * seguinte. Os cursores de lookup (cursor_4c_Busca*) e os de consulta do BO
1103:     * (cursor_4c_Conta/ContaNome/Gcr/Pam/MvCabTemp) ja sao fechados nos
1104:     * proprios metodos que os abrem.
1105:     *
1106:     * O nome do cursor eh lido ANTES do DODEFAULT() porque FormBase.Destroy
1107:     * libera o Business Object (this_oBusinessObject = .NULL.) e depois dele a
1108:     * property nao esta mais alcancavel. Literal como alternativa: o nome eh
1109:     * fixado em SigOpCclBO.Init.
1110:     *
1111:     * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
1112:     * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
1113:     * os pads do menu principal depois de uma tela modal fechar - sem ele o


### BO (C:\4c\projeto\app\classes\SigOpCclBO.prg):
*==============================================================================
* SigOpCclBO.prg
*
* Business Object para SigOpCcl (Operacoes por Conta)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe Grupo/Conta/CPF-CNPJ da conta de origem (preenchidos com os
* lookups de SigCdGcr/SigCdCli), monta um cursor temporario de movimentacoes
* (TmpOper) cruzando SigMvCab (lado Destino e lado Origem) com SigCdOpe, e
* repassa o resultado para o form legado de selecao de destino (Do Form
* SigOpClp With ThisForm, ThisForm.datasessionid) - form que fica FORA do
* escopo desta migracao (nao foi fornecido fonte/task propria).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao com
* mensagem clara) ja eh o correto para este BO, porque nao ha NENHUMA
* tabela proprietaria para gravar (regra CLAUDE.md "BO somente-leitura").
* ObterChavePrimaria() tambem nao se aplica - o dialogo nao exibe/edita um
* registro de tabela, ele monta um cursor de consulta.
*
* Fase 2/8 - no lugar do CRUD generico, as operacoes de dados deste BO sao
* as quatro cargas que o legado executa, todas de LEITURA:
*
*   CarregarDoCursor(alias)      mapeia SigCdCli (IClis/RClis/Grupos/Cpfs/
*                                Inativas) para as propriedades do BO; eh o
*                                miolo compartilhado pelos tres pontos em
*                                que o legado le essa tabela.
*   CarregarContaPorCodigo(cod)  CursorQuery('SigCdCli','crSigCdCli',
*                                'IClis', ...) dos Valid de Get_conta e
*                                Get_dconta, com a condicao do legado de so
*                                herdar o Grupo quando ele esta vazio.
*   CarregarContaPorCpf(cpf)     match exato do Valid de Get_cpf, que o
*                                legado faz via fwBuscaExt sobre 'Cpfs'.
*   ObterTipoCadastro(grupo)     CursorQuery('SigCdGcr','crSigCdGcr',
*                                'Codigos', ...) do Valid de Get_grupo, cujo
*                                unico uso eh o TpCads que reposiciona
*                                Get_dConta e mostra/esconde Get_Cpf.
*   BuscarOperacoes()            SIGOPCCL.sair.consulta.Click: cruza
*                                SigMvCab (lado Destino e lado Origem) com
*                                SigCdOpe filtrado por Grupo/Conta e monta o
*                                cursor_4c_Operacoes, repassado depois ao
*                                form legado de selecao de destino (fora do
*                                escopo desta migracao).
*==============================================================================

DEFINE CLASS SigOpCclBO AS BusinessBase

    *-- Propriedades da entidade (espelham os campos do container Origem
    *-- do form legado SIGOPCCL.Origem: Get_grupo/Get_conta/Get_dconta/Get_cpf)
    this_cGrupo = ""             && Get_grupo.Value - Codigo do Grupo de Contas
    this_cConta = ""             && Get_conta.Value - Codigo da Conta de Origem
    this_cDConta = ""            && Get_dconta.Value - Nome/Descricao da Conta
    this_cCpf = ""                && Get_cpf.Value - CPF/CNPJ do Cliente
    this_cCursorOperacoes = ""   && Nome do cursor de movimentacoes (TmpOper no legado)

    *-- Colunas que o legado tambem LE (nao sao campos digitaveis da tela,
    *-- mas governam exibicao e layout):
    *--   Inativas numeric(1,0) - crListaRemota.Inativas, usada pelo picker
    *--     do Get_cpf no DynamicForeColor (pinta de vermelho conta inativa);
    *--   TpCads   numeric(1,0) - crSigCdGcr.TpCads, lida no Get_grupo.Valid
    *--     para reposicionar Get_dConta/Say_dConta e mostrar/esconder o par
    *--     Get_Cpf/Say_Cpf.
    *-- As DUAS sao numeric(1,0), NAO bit: ficam em propriedade NUMERICA
    *-- (this_n*), nunca achatadas em logico com (col = 1) - coluna
    *-- numeric(1,0) de duas opcoes grava indice 1-based, nao booleano.
    this_nInativas = 0           && SigCdCli.Inativas
    this_nTpCads = 0             && SigCdGcr.TpCads do Grupo corrente
    this_lGrupoEncontrado = .F.  && .T. apos ObterTipoCadastro achar o Grupo

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cGrupo = ""
        THIS.this_cConta = ""
        THIS.this_cDConta = ""
        THIS.this_cCpf = ""
        THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
        THIS.this_nInativas = 0
        THIS.this_nTpCads = 0
        THIS.this_lGrupoEncontrado = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia as colunas de SigCdCli (par_cAliasCursor)
    * para as propriedades do BO.
    *
    * Esta eh a operacao de carga que o legado repete em TRES pontos, com
    * as MESMAS colunas: CursorQuery('SigCdCli', 'crSigCdCli', 'IClis',
    * This.Value) nos Valid de Get_conta e de Get_dconta, e fwBuscaExt
    * sobre 'Cpfs' no Valid de Get_cpf (que le crListaRemota.Cpfs /
    * .IClis / .RClis / .Inativas).
    *
    * Regra CLAUDE.md (Problema 9): SELECT (par_cAliasCursor) ANTES de
    * acessar os campos - a sintaxe campo NAO existe em VFP9.
    * Cada coluna eh conferida com TYPE(alias + ".<col>") != "U", porque o
    * metodo eh PUBLIC e pode receber cursor montado por outro SELECT;
    * PEMSTATUS NAO serve para cursor (exige objeto no 1o argumento).
    * O 2o argumento de TratarNulo() eh o VALOR PADRAO do tipo da coluna
    * ("" para char, 0 para numeric), nunca um codigo de tipo "C"/"N"/"D".
    *
    * Mapeamento COMPLETO (conferido em docs\schema.sql, tabela SigCdCli):
    *   IClis    char(10)      -> this_cConta   (Get_conta.Value)
    *   RClis    char(50)      -> this_cDConta  (Get_dconta.Value)
    *   Grupos   char(10)      -> this_cGrupo   (Get_grupo.Value)
    *   Cpfs     char(20)      -> this_cCpf     (Get_cpf.Value)
    *   Inativas numeric(1,0)  -> this_nInativas
    *
    * A coluna de CPF/CNPJ de SigCdCli eh "Cpfs" - NAO "Cgcs", que nao
    * existe nessa tabela (conferido no schema canonico, que eh UTF-16 e
    * por isso foi lido com Get-Content -Raw, nunca com grep).
    *
    * Grupo vazio no cursor NAO apaga um Grupo ja preenchido: o legado so
    * copia crSigCdCli.Grupos quando o campo Grupo esta vazio, e a
    * condicao completa (Grupo digitado prevalece) fica em
    * CarregarContaPorCodigo/CarregarContaPorCpf, que sao os callers.
    *
    * NAO leva PROTECTED: CarregarDoCursor eh PUBLIC na BusinessBase e o
    * Form chama este metodo de fora - PROTECTED em qualquer nivel da
    * heranca faz a chamada estourar "Property CARREGARDOCURSOR is not
    * found" em runtime (regra CLAUDE.md #51).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cGrupoCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(TratarNulo(par_cAliasCursor, ""))

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF TYPE(loc_cAlias + ".IClis") != "U"
                    THIS.this_cConta = ALLTRIM(TratarNulo(IClis, ""))
                ENDIF

                IF TYPE(loc_cAlias + ".RClis") != "U"
                    THIS.this_cDConta = ALLTRIM(TratarNulo(RClis, ""))
                ENDIF

                IF TYPE(loc_cAlias + ".Cpfs") != "U"
                    THIS.this_cCpf = ALLTRIM(TratarNulo(Cpfs, ""))
                ENDIF

                IF TYPE(loc_cAlias + ".Inativas") != "U"
                    *-- numeric(1,0) chega do driver como Numerico (caso
                    *-- normal); testar VARTYPE antes de usar, porque
                    *-- misturar Logico com numero estoura
                    *-- "Operator/operand type mismatch" (regra #13).
                    *-- O ramo Logico existe porque coluna de marcacao pode
                    *-- vir como Logico em outro driver; cada tipo eh tratado
                    *-- EXPLICITAMENTE, nunca entregue a um IIF (IIF exige
                    *-- Logico no 1o argumento e estoura erro 11 com
                    *-- Caractere/Numerico).
                    DO CASE
                        CASE VARTYPE(Inativas) = "N"
                            THIS.this_nInativas = TratarNulo(Inativas, 0)
                        CASE VARTYPE(Inativas) = "L"
                            THIS.this_nInativas = IIF(TratarNulo(Inativas, .F.), 1, 0)
                        OTHERWISE
                            THIS.this_nInativas = 0
                    ENDCASE
                ENDIF

                IF TYPE(loc_cAlias + ".Grupos") != "U"
                    loc_cGrupoCursor = ALLTRIM(TratarNulo(Grupos, ""))
                    IF !EMPTY(loc_cGrupoCursor)
                        THIS.this_cGrupo = loc_cGrupoCursor
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                                          "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarContaPorCodigo - equivalente ao
    * CursorQuery('SigCdCli', 'crSigCdCli', 'IClis', This.Value) que o
    * legado executa nos Valid de Get_conta e de Get_dconta depois do
    * fAcessoContas liberar o acesso.
    *
    * Reproduz a condicao do legado sobre o Grupo:
    *     If Empty(This.Parent.get_grupo.Value)
    *         This.Parent.get_grupo.Value = crSigCdCli.Grupos
    *     EndIf
    *     This.Parent.get_cpf.Value = crSigCdCli.Cpfs
    * ou seja, o Grupo do cursor so entra quando o Grupo corrente esta
    * VAZIO (Grupo digitado pelo usuario prevalece), enquanto o CPF eh
    * sempre sobrescrito.
    *
    * PADR(...,10) porque SigCdCli.IClis eh char(10) - o mesmo
    * preenchimento que o legado aplica no filtro de SigMvCab.
    *
    * Retorno: .T. quando achou a conta e carregou as propriedades; .F.
    * com this_cMensagemErro preenchido quando o codigo veio vazio, o SQL
    * falhou ou a conta nao existe. Nesse ultimo caso cabe ao Form abrir
    * o picker: universo vazio NAO eh erro e o codigo digitado pelo
    * usuario NAO deve ser apagado (regra CLAUDE.md #50).
    *====================================================================
    PROCEDURE CarregarContaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCodigo
        LOCAL loc_cGrupoAnterior, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_cCodigo = ALLTRIM(TratarNulo(par_cCodigo, ""))

        TRY
            IF EMPTY(loc_cCodigo)
                THIS.this_cMensagemErro = "Informe o c" + CHR(243) + "digo da conta."
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Grupos, Cpfs, Inativas" + ;
                           " FROM SigCdCli" + ;
                           " WHERE IClis = " + EscaparSQL(PADR(loc_cCodigo, 10))

                IF USED("cursor_4c_Conta")
                    USE IN cursor_4c_Conta
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Conta")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar a conta de origem." + ;
                                              CHR(13) + CapturarErroSQL()
                ELSE
                    IF RECCOUNT("cursor_4c_Conta") = 0
                        THIS.this_cMensagemErro = "Conta [" + loc_cCodigo + "] n" + ;
                                                  CHR(227) + "o cadastrada."
                    ELSE
                        *-- Grupo digitado prevalece sobre o do cursor
                        loc_cGrupoAnterior = ALLTRIM(THIS.this_cGrupo)

                        SELECT cursor_4c_Conta
                        GO TOP

                        IF THIS.CarregarDoCursor("cursor_4c_Conta")
                            IF !EMPTY(loc_cGrupoAnterior)
                                THIS.this_cGrupo = loc_cGrupoAnterior
                            ENDIF
                            loc_lSucesso = .T.
                        ELSE
                            IF EMPTY(THIS.this_cMensagemErro)
                                THIS.this_cMensagemErro = "Falha ao carregar os dados da conta."
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Conta")
                    USE IN cursor_4c_Conta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarContaPorDescricao - busca reversa por NOME (SigCdCli.RClis),
    * equivalente ao Valid de Get_dconta quando o usuario digita o nome em
    * vez do codigo (campo so eh alcancavel com Grupo preenchido e Conta/
    * Cpf vazios - When do legado).
    *
    * DIVERGENCIA CONSCIENTE, DOCUMENTADA: o Valid de Get_dconta do legado
    * chama fAcessoContas(Usuar, Grupo, 'D', This.Value, Parent.get_conta,
    * Parent.get_dconta) - a funcao resolve o codigo pelo NOME e preenche
    * Parent.get_conta.Value por EFEITO COLATERAL (ela recebe o objeto
    * TextBox, nao so o valor) - e so DEPOIS disso o codigo legado faz
    * "ThisForm.poDataMgr.CursorQuery('SigCdCli','crSigCdCli','IClis',
    * This.Value)", que filtra por IClis usando This.Value (a DESCRICAO
    * digitada, nao o codigo) - claramente um copy-paste do Valid de
    * Get_conta (que faz a MESMA linha fazendo sentido ali, porque ali
    * This.Value JA eh o codigo). Esse CursorQuery nunca acharia nada por
    * IClis = <descricao>, entao o bloco seguinte ("Get_grupo.Value =
    * crSigCdCli.Grupos" / "get_cpf.Value = crSigCdCli.Cpfs") rodaria
    * sobre um cursor VAZIO. fAcessoContas/fSqlConector/CursorQuery nao
    * foram portados (nao ha como reproduzir o efeito colateral do
    * parametro-objeto nem confirmar empiricamente o que o legado faz).
    * Em vez de reproduzir o que parece ser um bug de copy-paste, este
    * metodo implementa a busca por nome de forma SIMETRICA ao Get_conta
    * por codigo (CarregarContaPorCodigo) - mesma tabela, mesmo contrato,
    * so troca a coluna de filtro (RClis em vez de IClis) - e o Form
    * aplica o mesmo "Grupo digitado prevalece" + preenche Conta/Cpf, que
    * eh o unico comportamento que faz uma busca por nome ser util.
    *
    * SigCdCli.RClis eh char(50) - comparacao exata sem PADR, igual a
    * CarregarContaPorCpf (char no SQL Server compara com blank-padding
    * ANSI).
    *
    * Retorno: .T. achou e carregou; .F. com this_cMensagemErro quando
    * vazio, SQL falhou ou nao ha conta com esse nome - cabe ao Form abrir
    * o picker, SEM apagar o que o usuario digitou (regra CLAUDE.md #50).
    *====================================================================
    PROCEDURE CarregarContaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cDescricao
        LOCAL loc_cGrupoAnterior, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_cDescricao = ALLTRIM(TratarNulo(par_cDescricao, ""))

        TRY
            IF EMPTY(loc_cDescricao)
                THIS.this_cMensagemErro = "Informe o nome da conta."
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Grupos, Cpfs, Inativas" + ;
                           " FROM SigCdCli" + ;
                           " WHERE RClis = " + EscaparSQL(loc_cDescricao)

                IF USED("cursor_4c_ContaNome")
                    USE IN cursor_4c_ContaNome
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaNome")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar o nome da conta." + ;
                                              CHR(13) + CapturarErroSQL()
                ELSE
                    IF RECCOUNT("cursor_4c_ContaNome") = 0
                        THIS.this_cMensagemErro = "Nenhuma conta com o nome [" + ;
                                                  loc_cDescricao + "]."
                    ELSE
                        *-- Grupo digitado prevalece sobre o do cursor
                        loc_cGrupoAnterior = ALLTRIM(THIS.this_cGrupo)

                        SELECT cursor_4c_ContaNome
                        GO TOP

                        IF THIS.CarregarDoCursor("cursor_4c_ContaNome")
                            IF !EMPTY(loc_cGrupoAnterior)
                                THIS.this_cGrupo = loc_cGrupoAnterior
                            ENDIF
                            loc_lSucesso = .T.
                        ELSE
                            IF EMPTY(THIS.this_cMensagemErro)
                                THIS.this_cMensagemErro = "Falha ao carregar os dados da conta."
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ContaNome")
                    USE IN cursor_4c_ContaNome
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarContaPorCpf - equivalente ao caminho de match EXATO do
    * Valid de Get_cpf, onde o legado consulta SigCdCli pela coluna Cpfs
    * (CreateObject('fwBuscaExt', ..., 'SigCdCli', 'crListaRemota',
    * 'Cpfs', This.Value, ...)) e, achando o registro, transporta
    * crListaRemota.Cpfs / .IClis / .RClis para os campos da tela.
    *
    * par_cCpf chega JA formatado pelo Form: o legado aplica
    * TransForm(..., '@R 999.999.999-99') ou '@R 99.999.999/9999-99' e
    * valida com fValidarCPF/fValidarCNPJ ANTES de consultar, e a coluna
    * SigCdCli.Cpfs eh char(20) guardando o valor COM pontuacao.
    *
    * Sem PADR: comparacao de char no SQL Server usa blank-padding ANSI,
    * entao o valor sem preenchimento casa igual - e o legado tambem nao
    * preenche neste ponto (diferente do filtro de SigMvCab, que eh
    * posicional e por isso leva PADR).
    *
    * Retorno: .T. achou e carregou; .F. com this_cMensagemErro quando
    * vazio, SQL falhou ou nao existe conta com esse CPF/CNPJ - e ai cabe
    * ao Form abrir o picker, SEM apagar o que o usuario digitou.
    *====================================================================
    PROCEDURE CarregarContaPorCpf(par_cCpf)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCpf, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        loc_cCpf = ALLTRIM(TratarNulo(par_cCpf, ""))

        TRY
            IF EMPTY(loc_cCpf)
                THIS.this_cMensagemErro = "Informe o CPF / CNPJ."
            ELSE
                loc_cSQL = "SELECT IClis, RClis, Grupos, Cpfs, Inativas" + ;
                           " FROM SigCdCli" + ;
                           " WHERE Cpfs = " + EscaparSQL(loc_cCpf)

                IF USED("cursor_4c_ContaCpf")
                    USE IN cursor_4c_ContaCpf
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaCpf")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar o CPF / CNPJ." + ;
                                              CHR(13) + CapturarErroSQL()
                ELSE
                    IF RECCOUNT("cursor_4c_ContaCpf") = 0
                        THIS.this_cMensagemErro = "Nenhuma conta com o CPF / CNPJ [" + ;
                                                  loc_cCpf + "]."
                    ELSE
                        SELECT cursor_4c_ContaCpf
                        GO TOP

                        IF THIS.CarregarDoCursor("cursor_4c_ContaCpf")
                            loc_lSucesso = .T.
                        ELSE
                            IF EMPTY(THIS.this_cMensagemErro)
                                THIS.this_cMensagemErro = "Falha ao carregar os dados da conta."
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ContaCpf")
                    USE IN cursor_4c_ContaCpf
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterTipoCadastro - equivalente ao
    * CursorQuery('SigCdGcr', 'crSigCdGcr', 'Codigos', This.Value) do
    * Valid de Get_grupo, cujo unico uso eh ler crSigCdGcr.TpCads para
    * decidir o layout do bloco Origem:
    *     .Get_dConta.Left  = Iif(crSigCdGcr.TpCads = 1, 326, 177)
    *     .Get_dConta.Width = Iif(crSigCdGcr.TpCads = 1, 278, 427)
    *     .Say_dConta.Left  = Iif(crSigCdGcr.TpCads = 1, 329, 180)
    *     .Get_Cpf.Visible  = (crSigCdGcr.TpCads = 1)
    *     .Say_Cpf.Visible  = (crSigCdGcr.TpCads = 1)
    *
    * Devolve o TpCads CRU (numeric(1,0)) e tambem o guarda em
    * this_nTpCads, para o Form aplicar os Iif do legado sem reconsultar.
    * Grupo inexistente / SQL falhando devolve 0, que eh o ramo "diferente
    * de 1" - o mesmo efeito que o cursor vazio produz no legado.
    *
    * this_lGrupoEncontrado distingue "Grupo nao existe" (universo vazio,
    * regra CLAUDE.md #50 - o Form abre o FormBuscaAuxiliar, sem aviso) de
    * "Grupo existe com TpCads = 0" (this_nTpCads=0 eh valor de negocio
    * valido, nao ausencia) - o retorno numerico puro nao daria para
    * diferenciar os dois casos.
    *
    * SigCdGcr.Codigos eh char(10) -> PADR(...,10).
    *====================================================================
    PROCEDURE ObterTipoCadastro(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_cGrupo, loc_oErro

        THIS.this_nTpCads = 0
        THIS.this_lGrupoEncontrado = .F.
        loc_cGrupo = ALLTRIM(TratarNulo(par_cGrupo, ""))

        TRY
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT TpCads" + ;
                           " FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(PADR(loc_cGrupo, 10))

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar o Grupo de Contas." + ;
                                              CHR(13) + CapturarErroSQL()
                ELSE
                    IF RECCOUNT("cursor_4c_Gcr") > 0
                        THIS.this_lGrupoEncontrado = .T.

                        SELECT cursor_4c_Gcr
                        GO TOP

                        *-- numeric(1,0) chega Numerico; VARTYPE antes de
                        *-- usar, e cada tipo tratado EXPLICITAMENTE - IIF
                        *-- exige Logico no 1o argumento e estoura erro 11
                        *-- com Caractere/Numerico (regra #13).
                        DO CASE
                            CASE VARTYPE(cursor_4c_Gcr.TpCads) = "N"
                                THIS.this_nTpCads = TratarNulo(cursor_4c_Gcr.TpCads, 0)
                            CASE VARTYPE(cursor_4c_Gcr.TpCads) = "L"
                                THIS.this_nTpCads = IIF(TratarNulo(cursor_4c_Gcr.TpCads, .F.), 1, 0)
                            OTHERWISE
                                THIS.this_nTpCads = 0
                        ENDCASE
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN THIS.this_nTpCads
    ENDPROC

    *====================================================================
    * BuscarOperacoes - Monta o cursor de movimentacoes (Destino + Origem)
    * cruzando SigMvCab com SigCdOpe, filtrado pelo Grupo/Conta de origem
    * ja validados nos campos Get_grupo/Get_conta.
    *
    * Replica fielmente SIGOPCCL.sair.consulta.Click do legado: duas
    * consultas a SigMvCab (GrupoDs/ContaDs para o lado Destino,
    * GrupoOs/ContaOs para o lado Origem), cada linha recebe a mascara do
    * numero do titulo (fGerMascara) e a moeda (coluna do titulo ou, se
    * vazia, a moeda padrao do sistema em SigCdPam.MoedaPs).
    *
    * Retorno: .T. se encontrou ao menos uma movimentacao e preencheu
    * THIS.this_cCursorOperacoes; .F. com THIS.this_cMensagemErro
    * preenchido quando o filtro esta vazio, o SQL falha ou nao ha
    * nenhuma movimentacao (equivalente ao Eof() do legado).
    *====================================================================
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cMoedaPadrao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cGrupo)) OR EMPTY(ALLTRIM(THIS.this_cConta))
                THIS.this_cMensagemErro = "Informe o Grupo e a Conta de origem antes de consultar."
            ELSE
                *-- SigCdPam eh tabela de parametros com UMA UNICA linha; o
                *-- legado usa "Where Not cIdChaves = <id gerado>" para sempre
                *-- casar essa linha (fUniqueIds() nunca repete um cIdChaves
                *-- ja existente).
                loc_cSQL = "SELECT MoedaPs, MascNums" + ;
                           " FROM SigCdPam" + ;
                           " WHERE NOT cIdChaves = " + EscaparSQL(fUniqueIds())

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigCdPam)" + CHR(13) + CapturarErroSQL()
                ELSE
                    loc_cMoedaPadrao = TratarNulo(cursor_4c_Pam.MoedaPs, "")

                    IF USED("cursor_4c_Pam")
                        USE IN cursor_4c_Pam
                    ENDIF

                    THIS.RecriarCursorOperacoes()

                    loc_lSucesso = THIS.CarregarMovimentos("Destino", "GrupoDs", "ContaDs", loc_cMoedaPadrao)

                    IF loc_lSucesso
                        loc_lSucesso = THIS.CarregarMovimentos("Origem", "GrupoOs", "ContaOs", loc_cMoedaPadrao)
                    ENDIF

                    IF loc_lSucesso
                        IF USED(THIS.this_cCursorOperacoes)
                            SELECT (THIS.this_cCursorOperacoes)
                            SET ORDER TO TAG Num
                            GO TOP
                            IF EOF()
                                loc_lSucesso = .F.
                                THIS.this_cMensagemErro = "Nenhuma Movimenta" + CHR(231) + CHR(227) + "o Foi Encontrada!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * RecriarCursorOperacoes - (re)cria o cursor de movimentacoes vazio,
    * com a MESMA ordem de campos do "Create Cursor TmpOper" do legado
    * (CLAUDE.md exige estrutura IDENTICA em todos os pontos que criam o
    * mesmo cursor - o Form tambem recria esta mesma estrutura vazia no
    * Init, para a grade ter com que se ligar antes do primeiro clique em
    * Consultar).
    *
    * DESVIO DELIBERADO de largura: o SCX legado declara MascNum C(6),
    * mas docs/schema.sql mostra SigMvCab.mascnum como char(10) - e eh
    * esse valor de 10 digitos que fGerMascara() devolve (mesmo contrato
    * usado em SigOpBcbBO.this_cMascNum, BO irmao desta familia SigOp*).
    * Manter C(6) cortaria os 4 digitos finais da mascara em silencio;
    * usar C(10) preserva o valor real da coluna.
    *====================================================================
    PROTECTED PROCEDURE RecriarCursorOperacoes()
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF

        CREATE CURSOR (THIS.this_cCursorOperacoes) ;
            (Emps C(3), Dopes C(20), MascNum C(10), Tipo C(10), Moeda C(3), Valos N(12,2), Datas T NULL)

        INDEX ON Emps + Dopes + MascNum TAG Num
        INDEX ON Datas TAG Datas
    ENDPROC

    *====================================================================
    * CarregarMovimentos - consulta SigMvCab (lado Destino OU Origem,
    * conforme par_cCampoGrupo/par_cCampoConta) cruzado com SigCdOpe e
    * acrescenta as linhas encontradas ao cursor de operacoes.
    *
    * par_cTipo        - "Destino" ou "Origem" (grava na coluna Tipo)
    * par_cCampoGrupo  - "GrupoDs" ou "GrupoOs" (coluna de SigMvCab)
    * par_cCampoConta  - "ContaDs" ou "ContaOs" (coluna de SigMvCab)
    * par_cMoedaPadrao - SigCdPam.MoedaPs, usada quando SigMvCab.CMoes
    *                    estiver vazio
    *====================================================================
    PROTECTED PROCEDURE CarregarMovimentos(par_cTipo, par_cCampoGrupo, par_cCampoConta, par_cMoedaPadrao)
        LOCAL loc_cSQL, loc_nResultado, loc_cMoeda, loc_lSucesso

        loc_lSucesso = .T.

        loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, a.Valos, b.CMoes" + ;
                   " FROM SigMvCab a, SigCdOpe b" + ;
                   " WHERE a." + par_cCampoGrupo + " = " + EscaparSQL(PADR(THIS.this_cGrupo, 10)) + ;
                   " AND a." + par_cCampoConta + " = " + EscaparSQL(PADR(THIS.this_cConta, 10)) + ;
                   " AND a.Dopes = b.Dopes"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCabTemp")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvCab - " + par_cTipo + ")" + CHR(13) + CapturarErroSQL()
            loc_lSucesso = .F.
        ELSE
            SELECT cursor_4c_MvCabTemp
            SCAN
                loc_cMoeda = IIF(EMPTY(TratarNulo(cursor_4c_MvCabTemp.CMoes, "")), par_cMoedaPadrao, cursor_4c_MvCabTemp.CMoes)

                INSERT INTO (THIS.this_cCursorOperacoes) (Emps, Dopes, MascNum, Tipo, Datas, Valos, Moeda) ;
                    VALUES (cursor_4c_MvCabTemp.Emps, cursor_4c_MvCabTemp.Dopes, ;
                            ALLTRIM(fGerMascara(cursor_4c_MvCabTemp.Numes)), ;
                            par_cTipo, cursor_4c_MvCabTemp.Datas, cursor_4c_MvCabTemp.Valos, loc_cMoeda)
            ENDSCAN
        ENDIF

        IF USED("cursor_4c_MvCabTemp")
            USE IN cursor_4c_MvCabTemp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

