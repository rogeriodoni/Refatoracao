# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, GRUPOS, ICLIS, LNCONTA, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, GRUPOS, ICLIS, LNCONTA, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, GRUPOS, ICLIS, LNCONTA, CODIGOS

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
		.AddCursor('SigCdPam','GrPadClis','crSigCdPam','GrPadClis',.f.,[Select GrPadClis, Logos from SigCdPam])
Thisform.podatamgr.SqlExecute([Select a.Codigos,a.Descrs From SigCdGcr a Where a.GerBals=1 Order By a.codigos],"cTmpGrupos")
Select cGrupos
lcSelecao=[Select a.Iclis,a.Rclis,a.Grupos From SigCdCli a Where a.GerBals=1]+lcSel
	.SqlExecute(lcSelecao,'cTmpContas')
SELECT cTmpContas
Select cContas
Select crSigCdPam
Select cIde
	Insert Into cIde From Memvar
Select cContas
= Seek(m.lcCgrupo+m.lcCconta,'cContas','Grcodigo')
	Insert Into cIde From Memvar
	Select cIde
	Select cContas
SELECT cContas
Select cIde
= Seek('','cIde','cContas')
		Select cIde
				Delete File (m.lcArqJpgs)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREIDC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1201 linhas total):

*-- Linhas 686 a 704:
686:             ENDIF
687:             loc_cArquivo = PUTFILE("Salvar como...", "SigReIdc", "XLS")
688:             IF !EMPTY(loc_cArquivo)
689:                 SELECT cIde
690:                 COPY TO (loc_cArquivo) TYPE XLS
691:                 MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
692:                     loc_cArquivo, "Excel")
693:             ENDIF
694:             THIS.this_oRelatorio.LimparArquivosTemporarios()
695:         CATCH TO loc_oErro
696:             MsgErro(loc_oErro.Message + CHR(13) + ;
697:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
698:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
699:         ENDTRY
700:     ENDPROC
701: 
702:     *--------------------------------------------------------------------------
703:     * BtnSairClick - Fecha o formul" + CHR(225) + "rio
704:     *--------------------------------------------------------------------------

*-- Linhas 859 a 881:
859:             THIS.AtualizarEstadoCamposDescricao()
860:             RETURN
861:         ENDIF
862:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
863:             " WHERE GerBals=1 AND Codigos = " + EscaparSQL(loc_cValor)
864:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
865:         IF loc_nResult > 0
866:             SELECT cursor_4c_GrpVal
867:             IF !EOF()
868:                 loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_GrpVal.Descrs)
869:             ELSE
870:                 loc_oPg.txt_4c_DsGrupo.Value = ""
871:                 THIS.AbrirBuscaCdGrupo()
872:             ENDIF
873:         ELSE
874:             loc_oPg.txt_4c_DsGrupo.Value = ""
875:             THIS.AbrirBuscaCdGrupo()
876:         ENDIF
877:         IF USED("cursor_4c_GrpVal")
878:             USE IN cursor_4c_GrpVal
879:         ENDIF
880:         THIS.AtualizarEstadoCamposDescricao()
881:     ENDPROC

*-- Linhas 892 a 914:
892:             THIS.AtualizarEstadoCamposDescricao()
893:             RETURN
894:         ENDIF
895:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
896:             " WHERE GerBals=1 AND Descrs LIKE " + EscaparSQL(loc_cValor + "%")
897:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal2")
898:         IF loc_nResult > 0
899:             SELECT cursor_4c_GrpVal2
900:             IF !EOF()
901:                 loc_oPg.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_GrpVal2.Codigos)
902:                 loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_GrpVal2.Descrs)
903:             ELSE
904:                 THIS.AbrirBuscaDsGrupo()
905:             ENDIF
906:         ELSE
907:             THIS.AbrirBuscaDsGrupo()
908:         ENDIF
909:         IF USED("cursor_4c_GrpVal2")
910:             USE IN cursor_4c_GrpVal2
911:         ENDIF
912:         THIS.AtualizarEstadoCamposDescricao()
913:     ENDPROC
914: 

*-- Linhas 926 a 944:
926:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
927:         loc_cWhere = "GerBals=1"
928:         IF !EMPTY(loc_cGrupo)
929:             loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(loc_cGrupo)
930:         ENDIF
931:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
932:             "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cValor, ;
933:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
934:             .F., .T., loc_cWhere)
935:         IF VARTYPE(loc_oBusca) = "O"
936:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
937:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
938:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
939:             ELSE
940:                 IF !loc_oBusca.this_lAchouRegistro
941:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
942:                     loc_oBusca.mAddColuna("Rclis", "", "Nome")
943:                     loc_oBusca.Show()
944:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")

*-- Linhas 965 a 983:
965:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
966:         loc_cWhere = "GerBals=1"
967:         IF !EMPTY(loc_cGrupo)
968:             loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(loc_cGrupo)
969:         ENDIF
970:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
971:             "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cValor, ;
972:             "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
973:             .F., .T., loc_cWhere)
974:         IF VARTYPE(loc_oBusca) = "O"
975:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
976:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
977:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
978:             ELSE
979:                 IF !loc_oBusca.this_lAchouRegistro
980:                     loc_oBusca.mAddColuna("Rclis", "", "Nome")
981:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
982:                     loc_oBusca.Show()
983:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")

*-- Linhas 1007 a 1032:
1007:             RETURN
1008:         ENDIF
1009:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
1010:         loc_cWhere = "GerBals=1 AND Iclis = " + EscaparSQL(loc_cValor)
1011:         IF !EMPTY(loc_cGrupo)
1012:             loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1013:         ENDIF
1014:         loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE " + loc_cWhere
1015:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
1016:         IF loc_nResult > 0
1017:             SELECT cursor_4c_ContaVal
1018:             IF !EOF()
1019:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal.Rclis)
1020:             ELSE
1021:                 loc_oPg.txt_4c_DsConta.Value = ""
1022:                 THIS.AbrirBuscaCdConta()
1023:             ENDIF
1024:         ELSE
1025:             loc_oPg.txt_4c_DsConta.Value = ""
1026:             THIS.AbrirBuscaCdConta()
1027:         ENDIF
1028:         IF USED("cursor_4c_ContaVal")
1029:             USE IN cursor_4c_ContaVal
1030:         ENDIF
1031:         THIS.AtualizarEstadoCamposDescricao()
1032:     ENDPROC

*-- Linhas 1044 a 1069:
1044:             RETURN
1045:         ENDIF
1046:         loc_cGrupo = ALLTRIM(loc_oPg.txt_4c_CdGrupo.Value)
1047:         loc_cWhere = "GerBals=1 AND Rclis LIKE " + EscaparSQL(loc_cValor + "%")
1048:         IF !EMPTY(loc_cGrupo)
1049:             loc_cWhere = loc_cWhere + " AND Grupos = " + EscaparSQL(loc_cGrupo)
1050:         ENDIF
1051:         loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE " + loc_cWhere
1052:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal2")
1053:         IF loc_nResult > 0
1054:             SELECT cursor_4c_ContaVal2
1055:             IF !EOF()
1056:                 loc_oPg.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_ContaVal2.Iclis)
1057:                 loc_oPg.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_ContaVal2.Rclis)
1058:             ELSE
1059:                 THIS.AbrirBuscaDsConta()
1060:             ENDIF
1061:         ELSE
1062:             THIS.AbrirBuscaDsConta()
1063:         ENDIF
1064:         IF USED("cursor_4c_ContaVal2")
1065:             USE IN cursor_4c_ContaVal2
1066:         ENDIF
1067:         THIS.AtualizarEstadoCamposDescricao()
1068:     ENDPROC
1069: 


### BO (C:\4c\projeto\app\classes\SIGREIDCBO.prg):
*==============================================================================
* SIGREIDCBO.PRG
* Business Object para Relatorio de Identificacao de Contas (SIGREIDC)
* Herda de RelatorioBase
*
* Filtros:
*   this_cCdGrupo  / this_cDsGrupo  - Grupo contabil (SigCdGcr)
*   this_cCdConta  / this_cDsConta  - Conta (SigCdCli)
*   this_nLinha    - Linha inicial (1-5)
*   this_nColuna   - Coluna inicial (1-2)
*   this_lImprimirLogo - Imprimir logotipo
*==============================================================================

DEFINE CLASS SIGREIDCBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""
    this_cCdConta       = ""
    this_cDsConta       = ""
    this_nLinha         = 1
    this_nColuna        = 1
    this_lImprimirLogo  = .F.

    *-- Configuracao do relatorio
    this_cNomeRelatorio = "SigReIdc"
    this_cCursorDados   = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela     = "SigCdCli"
            THIS.this_cCampoChave = "Iclis"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega parametros iniciais do sistema.
    * Chamado pelo form em InicializarForm() apos instanciar o BO.
    * Equivalente ao bloco do Init() legado que carrega SigCdPam e SigCdGcr.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Logo da empresa (Logos de SigCdPam) - usado em PrepararDados
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GrPadClis, Logos FROM SigCdPam", ;
                "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + ;
                    "metros do sistema (SigCdPam)"
            ENDIF

            *-- Grupos contabeis GerBals=1 para lookup do campo Grupo no form
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.Codigos, a.Descrs FROM SigCdGcr a " + ;
                "WHERE a.GerBals=1 ORDER BY a.Codigos", ;
                "cursor_4c_Grupos")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar grupos cont" + CHR(225) + "beis"
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor local cIde com dados para SigReIdc.frx.
    * Equivalente ao metodo 'processamento' do form legado SIGREIDC.
    *
    * Fluxo:
    *   1. Obtem razao social em SigCdEmp
    *   2. Busca contas em SigCdCli (filtros Grupos/Iclis + GerBals=1)
    *   3. Cria cursor local cIde com estrutura exata esperada pelo FRX
    *   4. Insere linhas em branco de offset (calculo Linha/Coluna)
    *   5. Para cada conta: insere linha, processa logo e foto
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmpresas, loc_nNregi, loc_nI
        LOCAL loc_lcCgrupo, loc_lcCconta, loc_nLinha, loc_nColuna
        LOCAL loc_cArqJpg, loc_cDirTemp
        loc_lSucesso = .F.
        TRY
            *-- Razao social da empresa
            loc_cEmpresas = ""
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE Emps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpIdc")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpIdc
                IF !EOF()
                    loc_cEmpresas = ALLTRIM(cursor_4c_EmpIdc.Razas)
                ENDIF
                USE IN cursor_4c_EmpIdc
            ENDIF

            *-- Garantir que cursor de logo esta aberto
            IF !USED("cursor_4c_Pam")
                SQLEXEC(gnConnHandle, ;
                    "SELECT GrPadClis, Logos FROM SigCdPam", ;
                    "cursor_4c_Pam")
            ENDIF

            *-- Capturar filtros
            loc_lcCgrupo = ALLTRIM(THIS.this_cCdGrupo)
            loc_lcCconta = ALLTRIM(THIS.this_cCdConta)
            loc_nLinha   = THIS.this_nLinha
            loc_nColuna  = THIS.this_nColuna

            *-- Montar WHERE: replicar logica do original (conta sobrescreve grupo)
            *   Original: se ambos informados, lcSel = IClis filter (sobreescrito)
            *   O SCAN adicionalmente filtra por grupo - aqui unificado no SQL
            loc_cWhere = "a.GerBals = 1"
            IF !EMPTY(loc_lcCgrupo)
                loc_cWhere = loc_cWhere + " AND a.Grupos = " + EscaparSQL(loc_lcCgrupo)
            ENDIF
            IF !EMPTY(loc_lcCconta)
                loc_cWhere = loc_cWhere + " AND a.Iclis = " + EscaparSQL(loc_lcCconta)
            ENDIF

            *-- Query principal: contas filtradas com campos de foto
            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Figuras, a.FigJpgs " + ;
                "FROM SigCdCli a " + ;
                "WHERE " + loc_cWhere + ;
                " ORDER BY a.Grupos, a.Iclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasIdc")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar contas para o relat" + ;
                    CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursor de saida anterior se existir
            IF USED("cIde")
                USE IN cIde
            ENDIF

            *-- Criar cursor local com estrutura exata esperada pelo FRX SigReIdc
            CREATE CURSOR cIde ( ;
                cEmpresas C(50), ;
                cTitulo1s C(50), ;
                cGrupos   C(10), ;
                cContas   C(10), ;
                cDcontas  C(50), ;
                gLogos    C(64), ;
                gFotos    G(4) NULL, ;
                cArqJpgs  C(254), ;
                lBrancos  L(1))

            *-- Calcular offset de linhas em branco: ((Linha-1)+(Coluna-1))*5
            loc_nNregi = ((loc_nLinha - 1) + (loc_nColuna - 1)) * 5
            FOR loc_nI = 1 TO loc_nNregi
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ("", "", "", "", "", "", "", .T.)
            ENDFOR

            *-- Diretorio temporario para arquivos JPG de logo/foto
            loc_cDirTemp = ALLTRIM(SYS(2023))
            IF RIGHT(loc_cDirTemp, 1) != "\"
                loc_cDirTemp = loc_cDirTemp + "\"
            ENDIF

            *-- Processar cada conta
            SELECT cursor_4c_ContasIdc
            SCAN
                loc_cArqJpg = ""

                *-- Logo da empresa: copiar memo para JPG temporario
                IF THIS.this_lImprimirLogo
                    SELECT cursor_4c_Pam
                    IF !EOF() AND !ISNULL(cursor_4c_Pam.Logos) AND ;
                       !EMPTY(cursor_4c_Pam.Logos)
                        loc_cArqJpg = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_Pam.Logos TO (loc_cArqJpg)
                    ENDIF
                    SELECT cursor_4c_ContasIdc
                ENDIF

                *-- Inserir linha de dados no cursor cIde
                INSERT INTO cIde ;
                    (cEmpresas, cTitulo1s, cGrupos, cContas, cDcontas, ;
                     gLogos, cArqJpgs, lBrancos) ;
                    VALUES ( ;
                        loc_cEmpresas, ;
                        "IDENTIFICA" + CHR(199) + CHR(195) + "O", ;
                        ALLTRIM(cursor_4c_ContasIdc.Grupos), ;
                        ALLTRIM(cursor_4c_ContasIdc.Iclis), ;
                        ALLTRIM(cursor_4c_ContasIdc.Rclis), ;
                        loc_cArqJpg, ;
                        loc_cArqJpg, ;
                        .F.)

                *-- Foto do cliente: Figuras (blob) tem prioridade sobre FigJpgs (memo)
                IF !ISNULL(cursor_4c_ContasIdc.Figuras)
                    SELECT cIde
                    GO BOTTOM
                    REPLACE gFotos WITH cursor_4c_ContasIdc.Figuras
                    SELECT cursor_4c_ContasIdc
                ELSE
                    IF !EMPTY(cursor_4c_ContasIdc.FigJpgs)
                        LOCAL loc_cArqFoto
                        loc_cArqFoto = loc_cDirTemp + SYS(3) + ".Jpg"
                        COPY MEMO cursor_4c_ContasIdc.FigJpgs TO (loc_cArqFoto)
                        SELECT cIde
                        GO BOTTOM
                        REPLACE cArqJpgs WITH loc_cArqFoto
                        SELECT cursor_4c_ContasIdc
                    ENDIF
                ENDIF

            ENDSCAN

            IF USED("cursor_4c_ContasIdc")
                USE IN cursor_4c_ContasIdc
            ENDIF

            SELECT cIde
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica filtros antes da impressao.
    * Equivalente as validacoes em btnReport.Click do legado SIGREIDC.
    *
    * Valida: existencia de Grupo em SigCdGcr, Conta em SigCdCli,
    * Linha entre 1-5, Coluna entre 1-2.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lValido, loc_cSQL, loc_nResult, loc_nExiste
        loc_lValido = .T.
        TRY
            *-- Validar Grupo (se informado, deve existir em SigCdGcr)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr " + ;
                    "WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrupo")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValGrupo
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValGrupo.nExiste, 0)
                    USE IN cursor_4c_ValGrupo
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Conta (se informada, deve existir em SigCdCli)
            IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cCdConta))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                    "WHERE Iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdConta))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValConta")
                IF loc_nResult > 0
                    SELECT cursor_4c_ValConta
                    loc_nExiste = IIF(!EOF(), cursor_4c_ValConta.nExiste, 0)
                    USE IN cursor_4c_ValConta
                    IF loc_nExiste = 0
                        THIS.this_cMensagemErro = "Conta Inv" + CHR(225) + "lida."
                        loc_lValido = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar Linha inicial (1 a 5)
            IF loc_lValido AND !BETWEEN(THIS.this_nLinha, 1, 5)
                THIS.this_cMensagemErro = "Linha Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

            *-- Validar Coluna inicial (1 a 2)
            IF loc_lValido AND !BETWEEN(THIS.this_nColuna, 1, 2)
                THIS.this_cMensagemErro = "Coluna Inicial Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREIDCBO.ValidarFiltros")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosTemporarios - Remove arquivos JPG temporarios de logos e
    * fotos criados em PrepararDados. Deve ser chamado pelo form apos
    * REPORT FORM (impressao ou preview).
    * Equivalente ao bloco de limpeza em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparArquivosTemporarios()
        LOCAL loc_cArqJpgs, loc_cGLogos
        TRY
            IF USED("cIde")
                SELECT cIde
                SCAN
                    loc_cArqJpgs = ALLTRIM(cIde.cArqJpgs)
                    loc_cGLogos  = ALLTRIM(cIde.gLogos)
                    IF !EMPTY(loc_cArqJpgs) AND FILE(loc_cArqJpgs)
                        DELETE FILE (loc_cArqJpgs)
                    ENDIF
                    IF !EMPTY(loc_cGLogos) AND loc_cGLogos != loc_cArqJpgs ;
                       AND FILE(loc_cGLogos)
                        DELETE FILE (loc_cGLogos)
                    ENDIF
                ENDSCAN
                USE IN cIde
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREIDCBO.LimparArquivosTemporarios")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de identifica" + CHR(231) + CHR(227) + ;
            "o de contas n" + CHR(227) + "o altera registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_ContasIdc")
            USE IN cursor_4c_ContasIdc
        ENDIF
        IF USED("cursor_4c_EmpIdc")
            USE IN cursor_4c_EmpIdc
        ENDIF
        IF USED("cIde")
            USE IN cIde
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

