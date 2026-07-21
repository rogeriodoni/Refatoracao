# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, CPROS, CGRUS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, CPROS, CGRUS

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
  ControlSource = "llDatai"
  ControlSource = "llDataf"
  ControlSource = "pcProd"
  ControlSource = ""
  ControlSource = "pcGru"
Select crSigPrPre
lcQryPrPre  = 	[Select a.*, b.dpros, b.cgrus From SigPrPre a, SigcdPro b ] + ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprpre.prg) - TRECHOS RELEVANTES PARA PASS SQL (1500 linhas total):

*-- Linhas 459 a 477:
459:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
460:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
461:         loc_oGrid.HighlightStyle     = 2
462:         loc_oGrid.DeleteMark         = .F.
463:         loc_oGrid.RecordMark         = .F.
464:         loc_oGrid.RowHeight          = 16
465:         loc_oGrid.ScrollBars         = 2
466:         loc_oGrid.GridLines          = 3
467:         loc_oGrid.ReadOnly           = .T.
468:         WITH loc_oGrid
469:             .Column1.Width = 80
470:             .Column2.Width = 200
471:             .Column3.Width = 90
472:             .Column4.Width = 100
473:             .Column5.Width = 60
474:             .Column6.Width = 100
475:             .Column7.Width = 100
476:             .Column8.Width = 120
477:         ENDWITH

*-- Linhas 818 a 843:
818:             IF THIS.this_oBusinessObject.Buscar("")
819:                 *-- Vincular grid ao cursor (nome legado crSigPrPre)
820:                 loc_oGrid.RecordSource          = "crSigPrPre"
821:                 loc_oGrid.Column1.ControlSource = "crSigPrPre.cpros"
822:                 loc_oGrid.Column2.ControlSource = "crSigPrPre.dpros"
823:                 loc_oGrid.Column3.ControlSource = "crSigPrPre.cgrus"
824:                 loc_oGrid.Column4.ControlSource = "crSigPrPre.datas"
825:                 loc_oGrid.Column5.ControlSource = "crSigPrPre.moevs"
826:                 loc_oGrid.Column6.ControlSource = "crSigPrPre.pvensant"
827:                 loc_oGrid.Column7.ControlSource = "crSigPrPre.pvens"
828:                 loc_oGrid.Column8.ControlSource = "crSigPrPre.usuals"
829: 
830:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
831:                 loc_oGrid.Column1.Header1.Caption = "Produto"
832:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
833:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
834:                 loc_oGrid.Column4.Header1.Caption = "Data"
835:                 loc_oGrid.Column5.Header1.Caption = "Moeda"
836:                 loc_oGrid.Column6.Header1.Caption = "Pre" + CHR(231) + "o Ant."
837:                 loc_oGrid.Column7.Header1.Caption = "Pre" + CHR(231) + "o Atual"
838:                 loc_oGrid.Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
839: 
840:                 THIS.FormatarGridLista(loc_oGrid)
841:                 loc_oGrid.Refresh()
842:                 loc_lResultado = .T.
843:             ENDIF

*-- Linhas 889 a 946:
889:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
890:             RETURN
891:         ENDIF
892:         SELECT crSigPrPre
893:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
894:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
895:             THIS.this_cModoAtual = "VISUALIZAR"
896:             THIS.BOParaForm()
897:             THIS.HabilitarCampos(.F.)
898:             THIS.pgf_4c_Paginas.ActivePage = 2
899:         ENDIF
900:     ENDPROC
901: 
902:     *--------------------------------------------------------------------------
903:     * BtnAlterarClick - Alterar registro selecionado
904:     *--------------------------------------------------------------------------
905:     PROCEDURE BtnAlterarClick()
906:         LOCAL loc_cCidChaves
907:         IF !USED("crSigPrPre") OR EOF("crSigPrPre")
908:             MsgAviso("Nenhum registro selecionado.", "Alterar")
909:             RETURN
910:         ENDIF
911:         SELECT crSigPrPre
912:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
913:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
914:             THIS.this_oBusinessObject.EditarRegistro()
915:             THIS.this_cModoAtual = "ALTERAR"
916:             THIS.BOParaForm()
917:             THIS.HabilitarCampos(.T.)
918:             THIS.pgf_4c_Paginas.ActivePage = 2
919:         ENDIF
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * BtnExcluirClick - Excluir registro selecionado
924:     *--------------------------------------------------------------------------
925:     PROCEDURE BtnExcluirClick()
926:         LOCAL loc_cCidChaves, loc_lConfirma
927:         IF !USED("crSigPrPre") OR EOF("crSigPrPre")
928:             MsgAviso("Nenhum registro selecionado.", "Excluir")
929:             RETURN
930:         ENDIF
931:         SELECT crSigPrPre
932:         loc_cCidChaves = ALLTRIM(crSigPrPre.cidchaves)
933:         loc_lConfirma  = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
934:         IF loc_lConfirma
935:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
936:                 IF THIS.this_oBusinessObject.Excluir()
937:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
938:                     THIS.CarregarLista()
939:                 ENDIF
940:             ENDIF
941:         ENDIF
942:     ENDPROC
943: 
944:     *--------------------------------------------------------------------------
945:     * BtnBuscarClick - Atualiza lista com filtros atuais
946:     *--------------------------------------------------------------------------

*-- Linhas 1041 a 1059:
1041:                         loc_oBusca.Show()
1042:                     ENDIF
1043:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1044:                         SELECT cursor_4c_BuscaGrp
1045:                         loc_oCntProd.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1046:                     ELSE
1047:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1048:                         loc_oCntProd.txt_4c_Grupo.Value = ""
1049:                         ENDIF
1050:                     ENDIF
1051:                     loc_oBusca.Release()
1052:                 ENDIF
1053:                 IF USED("cursor_4c_BuscaGrp")
1054:                     USE IN cursor_4c_BuscaGrp
1055:                 ENDIF
1056:                 THIS.CarregarLista()
1057:             ENDIF
1058:         CATCH TO loc_oErro
1059:             MsgErro(loc_oErro.Message, "ValidarGrupo")

*-- Linhas 1087 a 1105:
1087:                         loc_oBusca.Show()
1088:                     ENDIF
1089:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
1090:                         SELECT cursor_4c_BuscaPro
1091:                         loc_oCntProd.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1092:                         loc_oCntProd.txt_4c_DProd.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1093:                     ELSE
1094:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1095:                         loc_oCntProd.txt_4c_Prod.Value  = ""
1096:                         loc_oCntProd.txt_4c_DProd.Value = ""
1097:                         ENDIF
1098:                     ENDIF
1099:                     loc_oBusca.Release()
1100:                 ENDIF
1101:                 IF USED("cursor_4c_BuscaPro")
1102:                     USE IN cursor_4c_BuscaPro
1103:                 ENDIF
1104:                 THIS.CarregarLista()
1105:             ENDIF

*-- Linhas 1137 a 1155:
1137:                         loc_oBusca.Show()
1138:                     ENDIF
1139:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro2")
1140:                         SELECT cursor_4c_BuscaPro2
1141:                         loc_oPagina.txt_4c_CPros.Value = ALLTRIM(cursor_4c_BuscaPro2.CPros)
1142:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1143:                             loc_oPagina.txt_4c_DPros.Value = ALLTRIM(cursor_4c_BuscaPro2.DPros)
1144:                         ENDIF
1145:                         THIS.this_oBusinessObject.this_cDPros = ALLTRIM(cursor_4c_BuscaPro2.DPros)
1146:                     ELSE
1147:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1148:                         loc_oPagina.txt_4c_CPros.Value = ""
1149:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DPros", 5)
1150:                             loc_oPagina.txt_4c_DPros.Value = ""
1151:                         ENDIF
1152:                         THIS.this_oBusinessObject.this_cDPros = ""
1153:                         ENDIF
1154:                     ENDIF
1155:                     loc_oBusca.Release()

*-- Linhas 1187 a 1205:
1187:                         loc_oBusca.Show()
1188:                     ENDIF
1189:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1190:                         SELECT cursor_4c_BuscaMoe
1191:                         loc_oPagina.txt_4c_Moevs.Value = ALLTRIM(cursor_4c_BuscaMoe.moevs)
1192:                     ELSE
1193:                         IF !loc_oBusca.this_lAchouRegistro AND !loc_oBusca.this_lSelecionou
1194:                         loc_oPagina.txt_4c_Moevs.Value = ""
1195:                         ENDIF
1196:                     ENDIF
1197:                     loc_oBusca.Release()
1198:                 ENDIF
1199:                 IF USED("cursor_4c_BuscaMoe")
1200:                     USE IN cursor_4c_BuscaMoe
1201:                 ENDIF
1202:             ENDIF
1203:         CATCH TO loc_oErro
1204:             MsgErro(loc_oErro.Message, "ValidarMoeda")
1205:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigprpreBO.prg):
*=============================================================================
* sigprpreBO.prg - Business Object para Alteracao de Precos
* Herda de: BusinessBase
* Tabela: sigprpre (PK: cidchaves)
* Campos: cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant,
*         usuals, ckatusite
* JOIN display: dpros, cgrus (de SigCdPro)
*=============================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Campos da tabela sigprpre
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCPros      = ""   && cpros char(14) NOT NULL - Codigo do produto
    this_dDatas      = {}   && datas datetime NULL - Data da alteracao
    this_cMoevs      = ""   && moevs char(3) NOT NULL - Moeda atual
    this_cMoevsAnt   = ""   && moevsant char(3) NOT NULL - Moeda anterior
    this_nPVens      = 0    && pvens numeric(11,5) NOT NULL - Preco de venda atual
    this_nPVensAnt   = 0    && pvensant numeric(11,5) NOT NULL - Preco de venda anterior
    this_cUsuals     = ""   && usuals nvarchar(20) NULL - Usuario
    this_nCKAtuSite  = 0    && ckatusite numeric(1,0) NOT NULL - Flag atualizacao site

    *-- Campos auxiliares de exibicao (JOIN com SigCdPro)
    this_cDPros      = ""   && dpros - Descricao do produto
    this_cCGrus      = ""   && cgrus - Codigo do grupo do produto

    *-- Filtros de consulta (usados em Buscar)
    this_dDataInicio = {}   && Data de inicio do periodo
    this_dDataFim    = {}   && Data de fim do periodo
    this_cFiltroCPro = ""   && Filtro por codigo de produto
    this_cFiltroGru  = ""   && Filtro por codigo de grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprpre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCPros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cMoevs      = TratarNulo(moevs,      "C")
            THIS.this_cMoevsAnt   = TratarNulo(moevsant,   "C")
            THIS.this_nPVens      = TratarNulo(pvens,      "N")
            THIS.this_nPVensAnt   = TratarNulo(pvensant,   "N")
            THIS.this_cUsuals     = TratarNulo(usuals,     "C")
            THIS.this_nCKAtuSite  = TratarNulo(ckatusite,  "N")
            IF TYPE("dpros") != "U"
                THIS.this_cDPros  = TratarNulo(dpros,      "C")
            ENDIF
            IF TYPE("cgrus") != "U"
                THIS.this_cCGrus  = TratarNulo(cgrus,      "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtros de periodo, produto e grupo
    * Cursor resultante: crSigPrPre (nome legado preservado para binding do grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFim
        LOCAL loc_cProdF, loc_cGruF, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Calcular limites para filtros "entre" (padrao do legado)
            IF EMPTY(THIS.this_cFiltroCPro)
                loc_cProdF = "zzzzzzzzzzzzzz"
            ELSE
                loc_cProdF = ALLTRIM(THIS.this_cFiltroCPro)
            ENDIF
            IF EMPTY(THIS.this_cFiltroGru)
                loc_cGruF = "zzz"
            ELSE
                loc_cGruF = ALLTRIM(THIS.this_cFiltroGru)
            ENDIF

            *-- Formatar datas
            IF EMPTY(THIS.this_dDataInicio)
                loc_cDataIni = FormatarDataSQL(DATE())
            ELSE
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicio)
            ENDIF
            IF EMPTY(THIS.this_dDataFim)
                loc_cDataFim = "'" + LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()),5,2) + "-" + RIGHT(DTOS(DATE()),2) + " 23:59:59'"
            ELSE
                loc_cDataFim = "'" + LEFT(DTOS(THIS.this_dDataFim), 4) + "-" + SUBSTR(DTOS(THIS.this_dDataFim),5,2) + "-" + RIGHT(DTOS(THIS.this_dDataFim),2) + " 23:59:59'"
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.cpros BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroCPro)) + ;
                       " AND " + EscaparSQL(loc_cProdF) + ;
                       " AND b.cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroGru)) + ;
                       " AND " + EscaparSQL(loc_cGruF) + ;
                       " ORDER BY a.datas DESC, a.cpros"

            IF USED("crSigPrPre")
                USE IN crSigPrPre
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrPre") > 0
                IF USED("crSigPrPre")
                    SELECT crSigPrPre
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar registro."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cChaveNova
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica para cidchaves (char 20)
            IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChaveNova = LEFT(ALLTRIM(nid), 20)
                USE IN cursor_4c_NewId
            ELSE
                loc_cChaveNova = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF
            THIS.this_cCidChaves = loc_cChaveNova

            loc_cSQL = "INSERT INTO sigprpre" + ;
                       " (cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant, usuals, ckatusite)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCPros)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs)     + ", " + ;
                       EscaparSQL(THIS.this_cMoevsAnt)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVens)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVensAnt) + ", " + ;
                       EscaparSQL(THIS.this_cUsuals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCKAtuSite) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprpre SET" + ;
                       " cpros    = " + EscaparSQL(THIS.this_cCPros)          + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " moevs    = " + EscaparSQL(THIS.this_cMoevs)          + ", " + ;
                       " moevsant = " + EscaparSQL(THIS.this_cMoevsAnt)       + ", " + ;
                       " pvens    = " + FormatarNumeroSQL(THIS.this_nPVens)   + ", " + ;
                       " pvensant = " + FormatarNumeroSQL(THIS.this_nPVensAnt)+ ", " + ;
                       " usuals   = " + EscaparSQL(THIS.this_cUsuals)         + ", " + ;
                       " ckatusite= " + FormatarNumeroSQL(THIS.this_nCKAtuSite) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprpre WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

