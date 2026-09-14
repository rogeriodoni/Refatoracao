# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS

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
		lcQuery = [Select MoedaPs ] + ;
				    [From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
Insert Into csCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
	lcQuery = [Select Emps, Dopes, Numes, Datas, MoeFpgs, Valos ] + ;
			    [From SigMvPar ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvPar') < 1)
	Select Emps, Dopes, lcMoeda as lcMoeda, lnValVars as mValVars, lnValDevs as mValDevs, ;
	  From crSigMvPar ;
	lcQuery = [Select Emps, Dopes, Numes, Datas, ValVars, ValDevs, Valos ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
	Select Emps, Dopes, lcMoeda as lcMoeda, ;
	  From crSigMvCab ;
Select csRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrevto.prg) - TRECHOS RELEVANTES PARA PASS SQL (1310 linhas total):

*-- Linhas 903 a 924:
903:         IF EMPTY(loc_cValor)
904:             RETURN
905:         ENDIF
906:         loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cValor)
907:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
908:         IF loc_nResult > 0
909:             SELECT cursor_4c_OpeVal
910:             IF EOF()
911:                 loc_oPg.txt_4c_Dopes.Value = ""
912:                 THIS.AbrirBuscaOperacao()
913:             ENDIF
914:         ELSE
915:             loc_oPg.txt_4c_Dopes.Value = ""
916:             THIS.AbrirBuscaOperacao()
917:         ENDIF
918:         IF USED("cursor_4c_OpeVal")
919:             USE IN cursor_4c_OpeVal
920:         ENDIF
921:     ENDPROC
922: 
923:     *==========================================================================
924:     * LOOKUP - MOEDA pelo codigo (SigCdMoe.CMoes)

*-- Linhas 965 a 987:
965:             THIS.AtualizarEstadoMoedaDesc()
966:             RETURN
967:         ENDIF
968:         loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
969:                    EscaparSQL(loc_cValor)
970:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
971:         IF loc_nResult > 0
972:             SELECT cursor_4c_MoeVal
973:             IF !EOF()
974:                 loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
975:             ELSE
976:                 loc_oPg.txt_4c_MoedaDesc.Value = ""
977:                 THIS.AbrirBuscaMoeda()
978:             ENDIF
979:         ELSE
980:             loc_oPg.txt_4c_MoedaDesc.Value = ""
981:             THIS.AbrirBuscaMoeda()
982:         ENDIF
983:         IF USED("cursor_4c_MoeVal")
984:             USE IN cursor_4c_MoeVal
985:         ENDIF
986:         THIS.AtualizarEstadoMoedaDesc()
987:     ENDPROC

*-- Linhas 1031 a 1053:
1031:             THIS.AtualizarEstadoMoedaDesc()
1032:             RETURN
1033:         ENDIF
1034:         loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + ;
1035:                    EscaparSQL(loc_cValor + "%")
1036:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
1037:         IF loc_nResult > 0
1038:             SELECT cursor_4c_MoeDescVal
1039:             IF !EOF()
1040:                 loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(CMoes)
1041:                 loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(DMoes)
1042:             ELSE
1043:                 THIS.AbrirBuscaMoedaDesc()
1044:             ENDIF
1045:         ELSE
1046:             THIS.AbrirBuscaMoedaDesc()
1047:         ENDIF
1048:         IF USED("cursor_4c_MoeDescVal")
1049:             USE IN cursor_4c_MoeDescVal
1050:         ENDIF
1051:         THIS.AtualizarEstadoMoedaDesc()
1052:     ENDPROC
1053: 

*-- Linhas 1096 a 1118:
1096:             THIS.AtualizarEstadoDesEmpresa()
1097:             RETURN
1098:         ENDIF
1099:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1100:                    EscaparSQL(loc_cValor)
1101:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1102:         IF loc_nResult > 0
1103:             SELECT cursor_4c_EmpVal
1104:             IF !EOF()
1105:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
1106:             ELSE
1107:                 loc_oPg.txt_4c_DesEmpresa.Value = ""
1108:                 THIS.AbrirBuscaEmpresa()
1109:             ENDIF
1110:         ELSE
1111:             loc_oPg.txt_4c_DesEmpresa.Value = ""
1112:             THIS.AbrirBuscaEmpresa()
1113:         ENDIF
1114:         IF USED("cursor_4c_EmpVal")
1115:             USE IN cursor_4c_EmpVal
1116:         ENDIF
1117:         THIS.AtualizarEstadoDesEmpresa()
1118:     ENDPROC

*-- Linhas 1162 a 1184:
1162:             THIS.AtualizarEstadoDesEmpresa()
1163:             RETURN
1164:         ENDIF
1165:         loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1166:                    EscaparSQL(loc_cValor + "%")
1167:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
1168:         IF loc_nResult > 0
1169:             SELECT cursor_4c_EmpDescVal
1170:             IF !EOF()
1171:                 loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(Cemps)
1172:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
1173:             ELSE
1174:                 THIS.AbrirBuscaDesEmpresa()
1175:             ENDIF
1176:         ELSE
1177:             THIS.AbrirBuscaDesEmpresa()
1178:         ENDIF
1179:         IF USED("cursor_4c_EmpDescVal")
1180:             USE IN cursor_4c_EmpDescVal
1181:         ENDIF
1182:         THIS.AtualizarEstadoDesEmpresa()
1183:     ENDPROC
1184: 


### BO (C:\4c\projeto\app\classes\sigrevtoBO.prg):
*==============================================================================
* SIGREVTOBO.PRG
* Business Object para Relatorio Total Por Operacao (SIGREVTO)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvPar (sem moeda de operacao)
*                     SigMvCab (com moeda de operacao via SigCdOpe.CMoes)
*
* Filtros:
*   - Operacao  (codigo da operacao - campo Dopes de SigMvPar/SigMvCab)
*   - Periodo   (data inicial / data final)
*   - Moeda     (codigo + descricao - CMoes/DMoes de SigCdMoe)
*   - Empresa   (codigo + descricao - Cemps/Razas de SigCdEmp, opcional)
*==============================================================================

DEFINE CLASS sigrevtoBO AS RelatorioBase

    *-- Filtro: operacao (get_dopes do legado - Dopes C(20))
    this_cDopes         = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: moeda (get_moeda/get_moeda_desc do legado)
    this_cMoeda         = ""
    this_cMoedaDesc     = ""

    *-- Filtro: empresa (getEmpresa/getDesEmpresa do legado, opcional)
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Dados derivados - preenchidos em InicializarFiltros() e PrepararDados()
    this_cMoedaOpe      = ""   && CMoes de SigCdOpe para a operacao (vazio = usa SigMvPar)
    this_cNomeEmpresa   = ""   && Razas de SigCdEmp para cabecalho

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de totais por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega valores padrao de moeda e define datas
    * Chamado pelo Form em InicializarForm() apos instanciar o BO
    * Equivalente ao SELECT MoedaPs FROM SigCdPam no Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Datas padrao = hoje
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Busca moeda padrao em SigCdPam
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT MoedaPs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    THIS.this_cMoeda = ALLTRIM(MoedaPs)
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            *-- Busca descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                IF USED("cursor_4c_MoePad")
                    USE IN cursor_4c_MoePad
                ENDIF
                loc_cSQL = "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + ;
                           EscaparSQL(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePad")
                IF loc_nResult > 0
                    SELECT cursor_4c_MoePad
                    GO TOP
                    IF !EOF()
                        THIS.this_cMoedaDesc = ALLTRIM(DMoes)
                    ENDIF
                    USE IN cursor_4c_MoePad
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor_4c_Relatorio + CsCabecalho
    * Equivalente ao PROCEDURE processamento do legado SIGREVTO
    *
    * Logica dual:
    *   Branch A (EMPTY CMoes): usa SigMvPar + converte MoeFpgs -> this_cMoeda
    *   Branch B (!EMPTY CMoes): usa SigMvCab + converte CMoes da ope -> this_cMoeda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_cDopes, loc_cMoeda, loc_cEmpresa, loc_cMoeOpe
        LOCAL loc_cDtIni, loc_cDtFin, loc_cWEmp
        LOCAL loc_cRazas, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cDopes   = PADR(ALLTRIM(THIS.this_cDopes), 20)
            loc_cMoeda   = ALLTRIM(THIS.this_cMoeda)
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cMoeOpe  = ""

            *-- Validacao obrigatoria
            IF EMPTY(ALLTRIM(loc_cDopes))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                    "o obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(loc_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo obrigat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Formata datas para SQL DATETIME (coluna datas = DATETIME no banco)
            loc_cDtIni = "'" + PADL(YEAR(THIS.this_dDtInicial),4,"0")  + "-" + ;
                               PADL(MONTH(THIS.this_dDtInicial),2,"0") + "-" + ;
                               PADL(DAY(THIS.this_dDtInicial),2,"0")   + " 00:00:00'"
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDtFinal),4,"0")    + "-" + ;
                               PADL(MONTH(THIS.this_dDtFinal),2,"0")   + "-" + ;
                               PADL(DAY(THIS.this_dDtFinal),2,"0")     + " 23:59:59'"

            *-- 1. Nome da empresa para o cabecalho do relatorio
            loc_cRazas = ""
            IF USED("cursor_4c_EmpCab")
                USE IN cursor_4c_EmpCab
            ENDIF
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpCab
                GO TOP
                IF !EOF()
                    loc_cRazas = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            *-- 2. Textos do cabecalho
            loc_cTitulo = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                          CHR(231) + CHR(227) + "o - " + ;
                          PROPER(ALLTRIM(loc_cDopes)) + ;
                          IIF(EMPTY(loc_cEmpresa), "", ;
                              " - Empresa : " + loc_cEmpresa)
            loc_cPeriodo = "Per" + CHR(237) + "odo de " + ;
                           DTOC(THIS.this_dDtInicial) + " " + ;
                           CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- 3. Cria cursor de cabecalho para uso no FRX
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                             VALUES (loc_cRazas,  loc_cTitulo, loc_cPeriodo)

            *-- 4. Busca moeda da operacao em SigCdOpe (CMoes)
            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF
            loc_cSQL = "SELECT CMoes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(loc_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
            IF loc_nResult > 0
                SELECT cursor_4c_Ope
                GO TOP
                IF !EOF()
                    loc_cMoeOpe = ALLTRIM(CMoes)
                ENDIF
                USE IN cursor_4c_Ope
            ENDIF
            THIS.this_cMoedaOpe = loc_cMoeOpe

            *-- 5. WHERE de empresa (opcional - filtra por empresa especifica)
            loc_cWEmp = IIF(EMPTY(loc_cEmpresa), "", ;
                            "Emps = " + EscaparSQL(loc_cEmpresa) + " AND ")

            *-- 6. Fecha cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(loc_cMoeOpe)
                *-- Branch A: SigMvPar (operacao sem moeda de referencia definida)
                *-- Converte MoeFpgs -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, MoeFpgs, Valos " + ;
                           "FROM SigMvPar " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvPar")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvPar"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
                       loc_cMoeda AS cMoeda, ;
                       0 AS mValVars, 0 AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = MoeFpgs, Valos, ;
                           Valos * fBuscarCotacao(MoeFpgs, Datas, gnConnHandle) / ;
                                  fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvPar ;
                  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, loc_cMoeda, 4, 5 ;
                  ORDER BY crSigMvPar.Emps, crSigMvPar.Dopes ;
                  INTO CURSOR cursor_4c_Relatorio READWRITE

                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
            ELSE
                *-- Branch B: SigMvCab (operacao com moeda de referencia)
                *-- Converte CMoes da operacao -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, ValVars, ValDevs, Valos " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvCab"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvCab.Emps, crSigMvCab.Dopes, ;
                       loc_cMoeda AS cMoeda, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValVars, ;
                           ValVars * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValVars, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValDevs, ;
                           ValDevs * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, Valos, ;
                           Valos   * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvCab ;
                  GROUP BY crSigMvCab.Emps, crSigMvCab.Dopes, loc_cMoeda ;
                  ORDER BY crSigMvCab.Emps, crSigMvCab.Dopes ;
                  INTO CURSOR cursor_4c_Relatorio READWRITE

                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
            ENDIF

            *-- Posiciona no inicio do cursor de resultado
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa PrepararDados e exibe relatorio em preview
    * Equivalente ao PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa PrepararDados e envia para impressora (com prompt)
    * Equivalente ao PROCEDURE impressao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Executa PrepararDados e imprime direto sem prompt
    * Equivalente ao PROCEDURE documento do legado
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cRelPath, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
                loc_lSucesso = .F.
            ENDIF
            loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                               gc_4c_CaminhoReports, "") + "SigReVto"
            REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_Relatorio,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir()/Documento().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Relatorios sao somente-leitura.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_MoePad")
            USE IN cursor_4c_MoePad
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("crSigMvPar")
            USE IN crSigMvPar
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

