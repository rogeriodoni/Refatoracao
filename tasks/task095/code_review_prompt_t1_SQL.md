# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ATIVAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MOEVS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'INICIAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, ESTOS, NUMS, EMPS, CPROS, MOECUSFS, NEMPS

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
Insert Into crCabecalho (Empresa, Titulo, SubTitulo, Faixa) Values (lcCep, lcTit, lcSub, lcFxa)
lcQuery = [Select CMoes, MoeQs, QtdEqs, 000000000000.00 as Valor, 000000000000.00 as ValCustos ] + ;
			[From SigCdMoe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdMoe') < 1)
Select crSigCdMoe
lcQuery = [Select Emps, CPros, Sum(Sqtds) as SQtds ] + ;
			[From SigMvEst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvEst') < 1)
Select crSigMvEst
lcQuery = [Select Cemps ] + ;
			[From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
Select crSigCdEmp
	Delete From crSigMvEst Where Emps = crSigCdEmp.Cemps
lcQuery = [Select CPros, PVens, Moevs, CustoFs, MoecusFs ] + ;
			[From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPro') < 1)
Select a.Emps, a.CPros, a.Sqtds * b.PVens * c.Valor * lnPct as PVens, ;
  From crSigMvEst a, crSigCdPro b, crSigCdMoe c ;
Select a.Emps, a.CPros, a.PVens, a.Moevs, a.Sqtds, a.CustoFs * b.ValCustos as CustoFs, a.MoecusFs ;
  From crVenda a, crSigCdMoe b ;
Select Emps, Sum(Sqtds) as Qtds, Sum(PVens) as Total, Sum(CustoFs) as TotalCusto ;
  From crProcessar ;
Select Emps, Sum(Sqtds) as Qtds, Sum(PVens) as Total, Sum(CustoFs) as TotalCusto ;
  From crProcessar ;
Select a.Emps, Val(Str(Nvl(b.Qtds, lnZer), 15, 2)) as QtdsFaixa, ;
  From crTotPorEmp a Left Join crTotPorFxa b ;
Select crImprimir
		Delete In crImprimir
Select Avg(PctFaixa) as MedFaixa, Avg(PctGeral) as MedGeral ;
  From crImprimir ;
Select crImprimir

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEVV.prg) - TRECHOS RELEVANTES PARA PASS SQL (1478 linhas total):

*-- Linhas 651 a 669:
651:         ENDIF
652: 
653:         IF loc_lSelecionou AND USED("cursor_4c_BuscaTab")
654:             SELECT cursor_4c_BuscaTab
655:             IF !EOF()
656:                 loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaTab.Codigos)
657:                 loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaTab.Descrs)
658:                 THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaTab.Descos
659:             ENDIF
660:         ENDIF
661: 
662:         IF USED("cursor_4c_BuscaTab")
663:             USE IN cursor_4c_BuscaTab
664:         ENDIF
665:         loc_oForm.Release()
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * ValidarTabela - Valida codigo digitado em txt_4c_Tabela (ENTER/TAB)

*-- Linhas 680 a 703:
680:                 THIS.this_oRelatorio.this_nPercentual = 0
681:                 RETURN
682:             ENDIF
683:             loc_nResult = SQLEXEC(gnConnHandle, ;
684:                 "SELECT Codigos, Descrs, Descos FROM SigOpTdz WHERE Codigos = " + ;
685:                 EscaparSQL(loc_cValor), ;
686:                 "cursor_4c_ValTab")
687:             IF loc_nResult > 0
688:                 SELECT cursor_4c_ValTab
689:                 IF !EOF()
690:                     loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_ValTab.Codigos)
691:                     loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_ValTab.Descrs)
692:                     THIS.this_oRelatorio.this_nPercentual = cursor_4c_ValTab.Descos
693:                     USE IN cursor_4c_ValTab
694:                     RETURN
695:                 ENDIF
696:                 USE IN cursor_4c_ValTab
697:             ENDIF
698:             THIS.AbrirBuscaTabela()
699:         CATCH TO loc_oErro
700:             MsgErro(loc_oErro.Message, "ValidarTabela")
701:         ENDTRY
702:     ENDPROC
703: 

*-- Linhas 735 a 753:
735:         ENDIF
736: 
737:         IF loc_lSelecionou AND USED("cursor_4c_BuscaDTab")
738:             SELECT cursor_4c_BuscaDTab
739:             IF !EOF()
740:                 loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaDTab.Codigos)
741:                 loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaDTab.Descrs)
742:                 THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaDTab.Descos
743:             ENDIF
744:         ENDIF
745: 
746:         IF USED("cursor_4c_BuscaDTab")
747:             USE IN cursor_4c_BuscaDTab
748:         ENDIF
749:         loc_oForm.Release()
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     * TeclaTabela - Handler KeyPress de txt_4c_Tabela

*-- Linhas 805 a 823:
805:         ENDIF
806: 
807:         IF loc_lSelecionou AND USED("cursor_4c_BuscaGrupo")
808:             SELECT cursor_4c_BuscaGrupo
809:             IF !EOF()
810:                 loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
811:                 loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
812:             ENDIF
813:         ENDIF
814: 
815:         IF USED("cursor_4c_BuscaGrupo")
816:             USE IN cursor_4c_BuscaGrupo
817:         ENDIF
818:         loc_oForm.Release()
819:     ENDPROC
820: 
821:     *--------------------------------------------------------------------------
822:     * ValidarGrupo - Valida codigo digitado em txt_4c_Grupo (ENTER/TAB)
823:     * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.

*-- Linhas 831 a 854:
831:                 loc_oPag.txt_4c_DGrupo.Value = ""
832:                 RETURN
833:             ENDIF
834:             loc_nResult = SQLEXEC(gnConnHandle, ;
835:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
836:                 EscaparSQL(loc_cValor), ;
837:                 "cursor_4c_ValGrupo")
838:             IF loc_nResult > 0
839:                 SELECT cursor_4c_ValGrupo
840:                 IF !EOF()
841:                     loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValGrupo.codigos)
842:                     loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValGrupo.descrs)
843:                     USE IN cursor_4c_ValGrupo
844:                     RETURN
845:                 ENDIF
846:                 USE IN cursor_4c_ValGrupo
847:             ENDIF
848:             THIS.AbrirBuscaGrupo()
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message, "ValidarGrupo")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------

*-- Linhas 897 a 915:
897:         ENDIF
898: 
899:         IF loc_lSelecionou AND USED("cursor_4c_BuscaConta")
900:             SELECT cursor_4c_BuscaConta
901:             IF !EOF()
902:                 loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.contas)
903:                 loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.descs)
904:             ENDIF
905:         ENDIF
906: 
907:         IF USED("cursor_4c_BuscaConta")
908:             USE IN cursor_4c_BuscaConta
909:         ENDIF
910:         loc_oForm.Release()
911:     ENDPROC
912: 
913:     *--------------------------------------------------------------------------
914:     * ValidarConta - Valida codigo digitado em txt_4c_Conta (ENTER/TAB)
915:     * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.

*-- Linhas 923 a 946:
923:                 loc_oPag.txt_4c_DConta.Value = ""
924:                 RETURN
925:             ENDIF
926:             loc_nResult = SQLEXEC(gnConnHandle, ;
927:                 "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
928:                 EscaparSQL(loc_cValor), ;
929:                 "cursor_4c_ValConta")
930:             IF loc_nResult > 0
931:                 SELECT cursor_4c_ValConta
932:                 IF !EOF()
933:                     loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValConta.contas)
934:                     loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValConta.descs)
935:                     USE IN cursor_4c_ValConta
936:                     RETURN
937:                 ENDIF
938:                 USE IN cursor_4c_ValConta
939:             ENDIF
940:             THIS.AbrirBuscaConta()
941:         CATCH TO loc_oErro
942:             MsgErro(loc_oErro.Message, "ValidarConta")
943:         ENDTRY
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------

*-- Linhas 1136 a 1154:
1136:                 RETURN
1137:             ENDIF
1138: 
1139:             SELECT (loc_cAlias)
1140:             COPY TO (loc_cArquivo) TYPE XL5
1141:             MsgInfo("Arquivo exportado com sucesso para:" + CHR(13) + loc_cArquivo, "Excel")
1142:         CATCH TO loc_oErro
1143:             MsgErro(loc_oErro.Message, "BotaoExcelClick")
1144:         ENDTRY
1145:     ENDPROC
1146: 
1147:     *--------------------------------------------------------------------------
1148:     * BotaoEncerrarClick - Fecha o formul" + CHR(225) + "rio (equivale ao bot" + CHR(227) + "o Sair do legado)
1149:     * O cmg_4c_Botoes.Buttons(4) j" + CHR(225) + " tem .Cancel=.T., ent" + CHR(227) + "o ESC tamb" + CHR(233) + "m dispara aqui.
1150:     *--------------------------------------------------------------------------
1151:     PROCEDURE BotaoEncerrarClick()
1152:         THIS.Release()
1153:     ENDPROC
1154: 

*-- Linhas 1207 a 1225:
1207:             ENDIF
1208: 
1209:             IF loc_lSelecionou AND USED("cursor_4c_BuscaDGrupo")
1210:                 SELECT cursor_4c_BuscaDGrupo
1211:                 IF !EOF()
1212:                     loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.codigos)
1213:                     loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.descrs)
1214:                 ENDIF
1215:             ENDIF
1216: 
1217:             IF USED("cursor_4c_BuscaDGrupo")
1218:                 USE IN cursor_4c_BuscaDGrupo
1219:             ENDIF
1220:             loc_oForm.Release()
1221:         CATCH TO loc_oErro
1222:             MsgErro(loc_oErro.Message, "AbrirBuscaDGrupo")
1223:         ENDTRY
1224:     ENDPROC
1225: 


### BO (C:\4c\projeto\app\classes\SIGREEVVBO.prg):
*==============================================================================
* SIGREEVVBO.PRG
* Business Object para Relatorio - Estoque Por Valor de Venda (SIGREEVV)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvEst, SigCdPro, SigCdMoe, SigCdEmp
* Relatorio FRX: SigReEvv.frx
*
* Filtros:
*   - Tabela de desconto (codigo + descricao + percentual - SigOpTdz)
*   - Grupo contabil    (codigo + descricao)
*   - Conta contabil    (codigo + descricao)
*   - Faixa de valor    (valor inicial / valor final)
*   - Incluir Franquias (checkbox)
*   - Incluir Zerados   (checkbox)
*==============================================================================

DEFINE CLASS SIGREEVVBO AS RelatorioBase

    *-- Filtro: tabela de desconto (SigOpTdz)
    this_cCodTab     = ""    && Codigo da tabela de desconto (getTabela no legado)
    this_cDsTab      = ""    && Descricao da tabela de desconto (getDTabela no legado)
    this_nPercentual = 0     && Percentual de desconto (Descos de SigOpTdz)

    *-- Filtro: grupo contabil
    this_cGrupo      = ""    && Codigo do grupo contabil (getGrupo no legado)
    this_cDGrupo     = ""    && Descricao do grupo contabil (getDGrupo no legado)

    *-- Filtro: conta contabil
    this_cConta      = ""    && Codigo da conta contabil (getConta no legado)
    this_cDConta     = ""    && Descricao da conta contabil (getDConta no legado)

    *-- Filtro: faixa de valor de venda
    this_nValorIni   = 0     && Valor inicial da faixa (getValorIni no legado)
    this_nValorFin   = 0     && Valor final da faixa (getValorFin no legado)

    *-- Filtro: opcoes de inclusao
    this_lFranquias  = .F.   && Incluir empresas franquias (chkFranquias no legado)
    this_lZerados    = .F.   && Incluir itens com quantidade zerada (chkZerados no legado)

    *-- Cursor de saida populado por PrepararDados() - usado pelo REPORT FORM SigReEvv
    this_cCursorDados = "crImprimir"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de estoque por valor de venda
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCotacao - Busca cotacao da moeda em SigCdCot (equivale a fBuscarCotacao)
    * par_cMoeda: codigo da moeda (3 chars)
    * Retorna: valor da cotacao (0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROCEDURE ObterCotacao(par_cMoeda)
        LOCAL loc_nValor, loc_nResult
        loc_nValor = 0
        IF !EMPTY(par_cMoeda)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " AND datas <= GETDATE() ORDER BY datas DESC, horas DESC", ;
                "cursor_4c_CotacaoTemp")
            IF loc_nResult > 0
                SELECT cursor_4c_CotacaoTemp
                IF !EOF()
                    loc_nValor = cursor_4c_CotacaoTemp.valos
                ENDIF
                USE IN cursor_4c_CotacaoTemp
            ENDIF
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio Estoque Por Valor de Venda
    * Replica logica do PROCEDURE processamento do SIGREEVV.SCX legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lOk, loc_oErro
        LOCAL loc_cTab, loc_cGru, loc_cCon, loc_cDtb
        LOCAL loc_nVlI, loc_nVlF, loc_nPct
        LOCAL loc_llFra, loc_llZer
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cSubTitulo, loc_cFaixa, loc_cEmpresa
        LOCAL loc_cEmpCod, loc_cEmpRaz
        LOCAL loc_nTot, loc_nOrd

        loc_lSucesso = .F.
        loc_lOk      = .T.

        TRY
            *-- Extrair filtros das propriedades do BO
            loc_cTab  = PADR(ALLTRIM(THIS.this_cCodTab), 10)
            loc_cGru  = PADR(ALLTRIM(THIS.this_cGrupo),  10)
            loc_cCon  = PADR(ALLTRIM(THIS.this_cConta),  10)
            loc_cDtb  = PADR(ALLTRIM(THIS.this_cDsTab),  30)
            loc_nVlI  = THIS.this_nValorIni
            loc_nVlF  = THIS.this_nValorFin
            loc_nPct  = 1 - (THIS.this_nPercentual / 100)
            loc_llFra = THIS.this_lFranquias
            loc_llZer = THIS.this_lZerados

            *-- Subtitulo e faixa de valor para cabecalho do relatorio
            loc_cSubTitulo = "Tabela : " + ALLTRIM(loc_cTab) + " - " + ALLTRIM(loc_cDtb) + ;
                IIF(EMPTY(ALLTRIM(loc_cGru)), "", " - Grupo : " + ALLTRIM(loc_cGru)) + ;
                IIF(EMPTY(ALLTRIM(loc_cCon)), "", " - Conta : " + ALLTRIM(loc_cCon))
            loc_cFaixa = ALLTRIM(STR(loc_nVlI, 10)) + " / " + ALLTRIM(STR(loc_nVlF, 10))

            *-- Buscar razao social da empresa atual
            loc_cEmpCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_cEmpRaz = ""
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmpCod), ;
                "cursor_4c_REVVEmpHead")
            IF loc_nResult > 0
                SELECT cursor_4c_REVVEmpHead
                IF !EOF()
                    loc_cEmpRaz = ALLTRIM(cursor_4c_REVVEmpHead.razas)
                ENDIF
                USE IN cursor_4c_REVVEmpHead
            ENDIF
            loc_cEmpresa = loc_cEmpCod + IIF(EMPTY(loc_cEmpRaz), "", " - " + loc_cEmpRaz)

            *-- Criar cursor de cabecalho do relatorio
            IF USED("crCabecalho")
                USE IN crCabecalho
            ENDIF
            CREATE CURSOR crCabecalho (Empresa c(80), Titulo c(80), SubTitulo c(80), ;
                Faixa c(80), MedFaixa n(10,2), MedGeral n(10,2))
            INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo, Faixa) ;
                VALUES (loc_cEmpresa, "Estoque Por Valor de Venda", loc_cSubTitulo, loc_cFaixa)

            *-- PASSO 1: Cotacoes de todas as moedas (Valor=cotacao propria, ValCustos=cotacao equivalente)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT cmoes, moeqs, qtdeqs, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS Valor, " + ;
                "CAST(0 AS NUMERIC(15,6)) AS ValCustos " + ;
                "FROM SigCdMoe ORDER BY cmoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar moedas (SigCdMoe)"
                loc_lOk = .F.
            ENDIF

            IF loc_lOk
                SELECT crSigCdMoe
                SCAN
                    IF !EMPTY(ALLTRIM(crSigCdMoe.moeqs))
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.moeqs)) * ;
                            crSigCdMoe.qtdeqs IN crSigCdMoe
                    ELSE
                        REPLACE ValCustos WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                    ENDIF
                    REPLACE Valor WITH THIS.ObterCotacao(ALLTRIM(crSigCdMoe.cmoes)) IN crSigCdMoe
                ENDSCAN
            ENDIF

            *-- PASSO 2: Estoque agrupado por empresa e produto (com filtros de grupo/conta)
            IF loc_lOk
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
                loc_cSQL = "SELECT emps, cpros, SUM(sqtds) AS SQtds " + ;
                    "FROM SigMvEst " + ;
                    "WHERE 0 = 0" + ;
                    IIF(EMPTY(ALLTRIM(loc_cGru)), "", " AND grupos = " + EscaparSQL(ALLTRIM(loc_cGru))) + ;
                    IIF(EMPTY(ALLTRIM(loc_cCon)), "", " AND estos = " + EscaparSQL(ALLTRIM(loc_cCon))) + ;
                    " GROUP BY emps, cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvEst")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoques (SigMvEst)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SELECT crSigMvEst
                INDEX ON cpros TAG cpros
            ENDIF

            *-- PASSO 3: Empresas a excluir (inativas, sem funcionarios, franquias se aplicavel)
            IF loc_lOk
                IF USED("crSigCdEmpExcl")
                    USE IN crSigCdEmpExcl
                ENDIF
                loc_cSQL = "SELECT cemps FROM SigCdEmp " + ;
                    "WHERE ativas <> 1 OR nemps < 1 " + ;
                    IIF(loc_llFra, "", " OR nums = '1' ") + ;
                    "ORDER BY cemps"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmpExcl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar empresas (SigCdEmp)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF loc_lOk
                SET DELETED ON
                SELECT crSigCdEmpExcl
                SCAN
                    DELETE FROM crSigMvEst WHERE emps = crSigCdEmpExcl.cemps
                ENDSCAN
                USE IN crSigCdEmpExcl
            ENDIF

            *-- PASSO 4: Dados dos produtos (preco venda, moeda, custo, moeda custo)
            IF loc_lOk
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                loc_cSQL = "SELECT cpros, pvens, moevs, custofs, moecusfs " + ;
                    "FROM SigCdPro ORDER BY cpros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar produtos (SigCdPro)"
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- PASSO 5: Calcular valor de venda (estoque x preco x cotacao x percentual desconto)
            IF loc_lOk
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                SELECT a.emps, a.cpros, ;
                    a.SQtds * b.pvens * c.Valor * loc_nPct AS PVens, ;
                    b.moevs, a.SQtds, a.SQtds * b.custofs AS CustoFs, b.moecusfs ;
                    FROM crSigMvEst a, crSigCdPro b, crSigCdMoe c ;
                    WHERE a.cpros = b.cpros AND b.moevs = c.cmoes ;
                    INTO CURSOR crVenda READWRITE
                IF USED("crSigMvEst")
                    USE IN crSigMvEst
                ENDIF
            ENDIF

            *-- PASSO 6: Converter custo para moeda base usando ValCustos da moeda
            IF loc_lOk
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
                SELECT a.emps, a.cpros, a.PVens, a.moevs, a.SQtds, ;
                    a.CustoFs * b.ValCustos AS CustoFs, a.moecusfs ;
                    FROM crVenda a, crSigCdMoe b ;
                    WHERE a.moecusfs = b.cmoes ;
                    ORDER BY a.emps, a.cpros ;
                    INTO CURSOR crProcessar READWRITE
                IF USED("crVenda")
                    USE IN crVenda
                ENDIF
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
            ENDIF

            *-- PASSO 7: Totalizar por empresa - todas as quantidades e valores
            IF loc_lOk
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorEmp READWRITE
            ENDIF

            *-- PASSO 8: Totalizar por empresa - apenas itens dentro da faixa de valor informada
            IF loc_lOk
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
                SELECT emps, SUM(SQtds) AS Qtds, SUM(PVens) AS Total, SUM(CustoFs) AS TotalCusto ;
                    FROM crProcessar ;
                    WHERE (PVens / SQtds) BETWEEN loc_nVlI AND loc_nVlF ;
                    GROUP BY emps ;
                    INTO CURSOR crTotPorFxa READWRITE
                IF USED("crProcessar")
                    USE IN crProcessar
                ENDIF
            ENDIF

            *-- PASSO 9: Montar cursor final crImprimir com LEFT JOIN faixa e geral por empresa
            IF loc_lOk
                IF USED("crImprimir")
                    USE IN crImprimir
                ENDIF
                SELECT a.emps, ;
                    VAL(STR(NVL(b.Qtds, 0), 15, 2)) AS QtdsFaixa, ;
                    VAL(STR(NVL(b.Total, 0), 15, 2)) AS TotalFaixa, ;
                    VAL(STR(a.Qtds, 15, 2)) AS QtdsGeral, ;
                    VAL(STR(a.Total, 15, 2)) AS TotalGeral, ;
                    0.00 AS PctFaixa, 0.00 AS PctGeral, ;
                    VAL(STR(a.TotalCusto, 15, 2)) AS TotCusGeral, ;
                    VAL(STR(NVL(b.TotalCusto, 0), 15, 2)) AS TotCusFaixa, ;
                    0 AS Ordem ;
                    FROM crTotPorEmp a LEFT JOIN crTotPorFxa b ON a.emps = b.emps ;
                    ORDER BY a.emps ;
                    INTO CURSOR crImprimir READWRITE
                IF USED("crTotPorEmp")
                    USE IN crTotPorEmp
                ENDIF
                IF USED("crTotPorFxa")
                    USE IN crTotPorFxa
                ENDIF
            ENDIF

            *-- PASSO 10: Calcular percentuais e marcar como excluidos os zerados (se !llZer)
            IF loc_lOk
                SELECT crImprimir
                SUM TotalFaixa TO loc_nTot
                loc_nOrd = 0
                GO TOP
                SCAN
                    IF crImprimir.TotalFaixa <> 0
                        REPLACE PctFaixa WITH (crImprimir.TotalFaixa / loc_nTot) * 100, ;
                            PctGeral WITH (crImprimir.TotalFaixa / crImprimir.TotalGeral) * 100 ;
                            IN crImprimir
                    ENDIF
                    IF !loc_llZer AND EMPTY(crImprimir.QtdsFaixa)
                        DELETE IN crImprimir
                    ELSE
                        loc_nOrd = loc_nOrd + 1
                        REPLACE Ordem WITH loc_nOrd IN crImprimir
                    ENDIF
                ENDSCAN
            ENDIF

            *-- PASSO 11: Calcular medias e atualizar cabecalho do relatorio
            IF loc_lOk
                IF USED("crMedias")
                    USE IN crMedias
                ENDIF
                SELECT AVG(PctFaixa) AS MedFaixa, AVG(PctGeral) AS MedGeral ;
                    FROM crImprimir ;
                    INTO CURSOR crMedias
                GO TOP IN crMedias
                REPLACE MedFaixa WITH NVL(crMedias.MedFaixa, 0), ;
                    MedGeral WITH NVL(crMedias.MedGeral, 0) IN crCabecalho
                USE IN crMedias
            ENDIF

            IF loc_lOk
                SELECT crImprimir
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Relat" + CHR(243) + "rio Estoque Por Valor de Venda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "SigReEvv") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de tabela
    * Retorna identificador composto dos filtros usado para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TAB=" + ALLTRIM(THIS.this_cCodTab) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cGrupo) + ;
                     ";CON=" + ALLTRIM(THIS.this_cConta) + ;
                     ";VLI=" + ALLTRIM(STR(THIS.this_nValorIni, 15, 2)) + ;
                     ";VLF=" + ALLTRIM(STR(THIS.this_nValorFin, 15, 2)) + ;
                     ";PCT=" + ALLTRIM(STR(THIS.this_nPercentual, 6, 2)) + ;
                     ";FRA=" + IIF(THIS.this_lFranquias, "S", "N") + ;
                     ";ZER=" + IIF(THIS.this_lZerados, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCodTab") = "C"
                        THIS.this_cCodTab = ALLTRIM(m.cCodTab)
                    ENDIF
                    IF TYPE("m.cDsTab") = "C"
                        THIS.this_cDsTab = ALLTRIM(m.cDsTab)
                    ENDIF
                    IF TYPE("m.nPercentual") = "N"
                        THIS.this_nPercentual = m.nPercentual
                    ENDIF
                    IF TYPE("m.cGrupo") = "C"
                        THIS.this_cGrupo = ALLTRIM(m.cGrupo)
                    ENDIF
                    IF TYPE("m.cDGrupo") = "C"
                        THIS.this_cDGrupo = ALLTRIM(m.cDGrupo)
                    ENDIF
                    IF TYPE("m.cConta") = "C"
                        THIS.this_cConta = ALLTRIM(m.cConta)
                    ENDIF
                    IF TYPE("m.cDConta") = "C"
                        THIS.this_cDConta = ALLTRIM(m.cDConta)
                    ENDIF
                    IF TYPE("m.nValorIni") = "N"
                        THIS.this_nValorIni = m.nValorIni
                    ENDIF
                    IF TYPE("m.nValorFin") = "N"
                        THIS.this_nValorFin = m.nValorFin
                    ENDIF
                    IF TYPE("m.lFranquias") = "L"
                        THIS.this_lFranquias = m.lFranquias
                    ENDIF
                    IF TYPE("m.lZerados") = "L"
                        THIS.this_lZerados = m.lZerados
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Aplica as mesmas validacoes do Click do legado
    * (Tabela obrigatoria, Valor Inicial >= 0, Valor Inicial <= Valor Final)
    * Retorna .T. se filtros estao validos, .F. caso contrario (mensagem em this_cMensagemErro)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodTab))
            THIS.this_cMensagemErro = "Tabela de Desconto Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni < 0
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nValorIni > THIS.this_nValorFin
            THIS.this_cMensagemErro = "Faixa Inicial de Valor Maior do Que a Final!!!"
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO, EXCEL)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReEvv") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursores criados pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(11), loc_nI
        loc_aCursores(1)  = "crCabecalho"
        loc_aCursores(2)  = "crSigCdMoe"
        loc_aCursores(3)  = "crSigMvEst"
        loc_aCursores(4)  = "crSigCdEmpExcl"
        loc_aCursores(5)  = "crSigCdPro"
        loc_aCursores(6)  = "crVenda"
        loc_aCursores(7)  = "crProcessar"
        loc_aCursores(8)  = "crTotPorEmp"
        loc_aCursores(9)  = "crTotPorFxa"
        loc_aCursores(10) = "crImprimir"
        loc_aCursores(11) = "crMedias"
        FOR loc_nI = 1 TO 11
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

ENDDEFINE

