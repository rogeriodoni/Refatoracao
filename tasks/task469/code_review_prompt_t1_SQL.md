# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, TIPOS, GRUPOS

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
  ControlSource = "crSigIdPcp.tipos"
  ControlSource = "crSigIdPcp.descs"
  ControlSource = "crSigIdPcp.moedas"
  ControlSource = "crSigIdPcp.limites"
  ControlSource = "crSigIdPcp.fmaxs"
  ControlSource = "crSigIdPcp.valors"
  ControlSource = "crSigIdPcp.ganhos"
  ControlSource = "crSigIdPcp.GRUPOS"
Select crSigIdPcp
lcQryTpCp = [Select * From SigIdPcp ]
		lcQuery = [Select codigos,Descrs ] + ;
		    [ From SigCdGcr] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
		Select crSigIdPcp
Select crSigIdPcp
	lcQuery = [Select Tipos,Grupos ] + ;
		    [ From SigIdPcp] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crPesqSigIdPcp') < 1)
	Select crPesqSigIdPcp
Select crSigIdPcp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1507 linhas total):

*-- Linhas 356 a 374:
356:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
357:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
358:         loc_oGrid.HighlightStyle     = 2
359:         loc_oGrid.DeleteMark   = .F.
360:         loc_oGrid.RecordMark   = .F.
361:         loc_oGrid.ScrollBars   = 2
362:         loc_oGrid.Visible      = .T.
363: 
364:         WITH loc_oGrid.Column1
365:             .Width     = 80
366:             .Alignment = 0
367:         ENDWITH
368:         WITH loc_oGrid.Column1.Header1
369:             .Caption  = "C" + CHR(243) + "digo"
370:             .FontName = "Tahoma"
371:             .FontSize = 8
372:         ENDWITH
373: 
374:         WITH loc_oGrid.Column2

*-- Linhas 843 a 865:
843:                 IF THIS.this_oBusinessObject.Buscar("")
844:                     loc_oGrid.ColumnCount = 3
845:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
846:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
847:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
848:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.limites"
849: 
850:                     *-- Reconfigurar cabecalhos APOS ControlSource (VFP9 reseta ao alterar)
851:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
852:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                     loc_oGrid.Column3.Header1.Caption = "Prod. M" + CHR(237) + "nima"
854: 
855:                     THIS.FormatarGridLista(loc_oGrid)
856:                     loc_lResultado = .T.
857:                 ENDIF
858:             CATCH TO loException
859:                 MsgErro("Erro ao carregar lista:" + CHR(13) + ;
860:                     loException.Message, "FormMtp.CarregarLista")
861:             ENDTRY
862:         ENDIF
863: 
864:         RETURN loc_lResultado
865:     ENDPROC

*-- Linhas 904 a 945:
904:             RETURN
905:         ENDIF
906: 
907:         SELECT cursor_4c_Dados
908:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
909: 
910:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
911:             THIS.this_cModoAtual = "VISUALIZAR"
912:             THIS.BOParaForm()
913:             THIS.HabilitarCampos(.F.)
914:             THIS.AlternarPagina(2)
915:             THIS.AjustarBotoesPorModo()
916:         ENDIF
917:     ENDPROC
918: 
919:     *===========================================================================
920:     * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
921:     *===========================================================================
922:     PROCEDURE BtnAlterarClick()
923:         LOCAL loc_cChave
924: 
925:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
926:             MsgAviso("Nenhum registro selecionado.", "Alterar")
927:             RETURN
928:         ENDIF
929: 
930:         SELECT cursor_4c_Dados
931:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
932: 
933:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
934:             THIS.this_oBusinessObject.EditarRegistro()
935:             THIS.this_cModoAtual = "ALTERAR"
936:             THIS.BOParaForm()
937:             THIS.HabilitarCampos(.T.)
938:             THIS.AlternarPagina(2)
939:             THIS.AjustarBotoesPorModo()
940:         ENDIF
941:     ENDPROC
942: 
943:     *===========================================================================
944:     * BtnExcluirClick - Confirma e exclui registro selecionado
945:     *===========================================================================

*-- Linhas 951 a 969:
951:             RETURN
952:         ENDIF
953: 
954:         SELECT cursor_4c_Dados
955:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
956: 
957:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
958:             "Excluir")
959: 
960:         IF loc_lConfirma
961:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
962:                 IF THIS.this_oBusinessObject.Excluir()
963:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
964:                         "Exclus" + CHR(227) + "o")
965:                     THIS.CarregarLista()
966:                 ENDIF
967:             ENDIF
968:         ENDIF
969:     ENDPROC

*-- Linhas 990 a 1008:
990:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
991:                     loc_cChave = ALLTRIM(cursor_4c_Busca.cidchaves)
992:                     IF !EMPTY(loc_cChave) AND USED("cursor_4c_Dados")
993:                         SELECT cursor_4c_Dados
994:                         LOCATE FOR ALLTRIM(cidchaves) == loc_cChave
995:                     ENDIF
996:                 ENDIF
997:                 loc_oBusca.Release()
998:             ENDIF
999:         CATCH TO loException
1000:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, ;
1001:                 "FormMtp.BtnBuscarClick")
1002:         ENDTRY
1003: 
1004:         IF USED("cursor_4c_Busca")
1005:             USE IN cursor_4c_Busca
1006:         ENDIF
1007:     ENDPROC
1008: 

*-- Linhas 1031 a 1052:
1031:             ENDIF
1032: 
1033:             *-- Verificar duplicidade de Tipos+Grupos
1034:             loc_cSQL = "SELECT Tipos, Grupos FROM SigIdPcp" + ;
1035:                 " WHERE Tipos=" + EscaparSQL(loc_cTipos) + ;
1036:                 " AND Grupos=" + EscaparSQL(loc_cGrupos)
1037:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesqDup")
1038:             IF loc_nResult >= 0 AND USED("cursor_4c_PesqDup") AND !EOF("cursor_4c_PesqDup")
1039:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...", "")
1040:                 loc_oPag2.txt_4c_Grupo.SetFocus()
1041:                 USE IN cursor_4c_PesqDup
1042:                 RETURN .F.
1043:             ENDIF
1044:             IF USED("cursor_4c_PesqDup")
1045:                 USE IN cursor_4c_PesqDup
1046:             ENDIF
1047:         ENDIF
1048: 
1049:         TRY
1050:             THIS.FormParaBO()
1051:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1052:             IF loc_lSucesso

*-- Linhas 1090 a 1108:
1090:                     loc_oBusca.Show()
1091: 
1092:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1093:                         SELECT cursor_4c_Gcr
1094:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1095:                     ELSE
1096:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
1097:                     ENDIF
1098:                 ENDIF
1099:                 loc_oBusca.Release()
1100:             ENDIF
1101:         CATCH TO loException
1102:             MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
1103:                 "FormMtp.ValidarGrupo")
1104:         ENDTRY
1105: 
1106:         IF USED("cursor_4c_Gcr")
1107:             USE IN cursor_4c_Gcr
1108:         ENDIF

*-- Linhas 1132 a 1160:
1132:             IF VARTYPE(loc_oBusca) = "O"
1133:                 IF loc_oBusca.this_lAchouRegistro
1134:                     IF USED("cursor_4c_Moe")
1135:                         SELECT cursor_4c_Moe
1136:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1137:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1138:                     ENDIF
1139:                 ELSE
1140:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1141:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1142:                     loc_oBusca.Show()
1143: 
1144:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1145:                         SELECT cursor_4c_Moe
1146:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1147:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1148:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1149:                     ELSE
1150:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1151:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1152:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1153:                     ENDIF
1154:                 ENDIF
1155:                 loc_oBusca.Release()
1156:             ENDIF
1157:         CATCH TO loException
1158:             MsgErro("Erro ao validar moeda:" + CHR(13) + loException.Message, ;
1159:                 "FormMtp.ValidarMoedaPorCodigo")
1160:         ENDTRY

*-- Linhas 1185 a 1214:
1185:             IF VARTYPE(loc_oBusca) = "O"
1186:                 IF loc_oBusca.this_lAchouRegistro
1187:                     IF USED("cursor_4c_Moe")
1188:                         SELECT cursor_4c_Moe
1189:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1190:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1191:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1192:                     ENDIF
1193:                 ELSE
1194:                     loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1195:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1196:                     loc_oBusca.Show()
1197: 
1198:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1199:                         SELECT cursor_4c_Moe
1200:                         loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
1201:                         loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
1202:                         loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1203:                     ELSE
1204:                         loc_oPag2.txt_4c_Moedas.Value  = ""
1205:                         loc_oPag2.txt_4c_DescMoe.Value = ""
1206:                     ENDIF
1207:                 ENDIF
1208:                 loc_oBusca.Release()
1209:             ENDIF
1210:         CATCH TO loException
1211:             MsgErro("Erro ao validar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1212:                 loException.Message, "FormMtp.ValidarMoedaPorDescricao")
1213:         ENDTRY
1214: 

*-- Linhas 1339 a 1357:
1339:                 loc_oBusca.Show()
1340: 
1341:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
1342:                     SELECT cursor_4c_Gcr
1343:                     loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
1344:                 ENDIF
1345:                 loc_oBusca.Release()
1346:             ENDIF
1347:         CATCH TO loException
1348:             MsgErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, ;
1349:                 "FormMtp.AbrirLookupGrupo")
1350:         ENDTRY
1351: 
1352:         IF USED("cursor_4c_Gcr")
1353:             USE IN cursor_4c_Gcr
1354:         ENDIF
1355:     ENDPROC
1356: 
1357:     *===========================================================================

*-- Linhas 1393 a 1411:
1393:                 loc_oBusca.Show()
1394: 
1395:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1396:                     SELECT cursor_4c_Moe
1397:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1398:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1399:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1400:                 ELSE
1401:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1402:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1403:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1404:                 ENDIF
1405:                 loc_oBusca.Release()
1406:             ENDIF
1407:         CATCH TO loException
1408:             MsgErro("Erro ao abrir lookup de moeda:" + CHR(13) + loException.Message, ;
1409:                 "FormMtp.AbrirLookupMoedaCodigo")
1410:         ENDTRY
1411: 

*-- Linhas 1453 a 1471:
1453:                 loc_oBusca.Show()
1454: 
1455:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
1456:                     SELECT cursor_4c_Moe
1457:                     loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
1458:                     loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
1459:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
1460:                 ELSE
1461:                     loc_oPag2.txt_4c_Moedas.Value  = ""
1462:                     loc_oPag2.txt_4c_DescMoe.Value = ""
1463:                     loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
1464:                 ENDIF
1465:                 loc_oBusca.Release()
1466:             ENDIF
1467:         CATCH TO loException
1468:             MsgErro("Erro ao abrir lookup de moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1469:                 loException.Message, "FormMtp.AbrirLookupMoedaDescricao")
1470:         ENDTRY
1471: 


### BO (C:\4c\projeto\app\classes\MtpBO.prg):
*==============================================================================
* MtpBO.prg - Business Object para Modelos de Trabalho de Producao
* Tabela: SigIdPcp
* Migrado de: SigCdMtp.SCX
*==============================================================================

DEFINE CLASS MtpBO AS BusinessBase

    *-- Chave primaria (gerada internamente no INSERT)
    this_cIdChaves = ""

    *-- Chave de negocio composta: Tipos + Grupos
    this_cTipos    = ""
    this_cGrupos   = ""

    *-- Dados principais
    this_cDescs    = ""
    this_nLimites  = 0
    this_nFmaxs    = 0
    this_nValors   = 0
    this_cMoedas   = ""
    this_lGanhos   = .F.

    *-- Exibicao (nao persistido na tabela SigIdPcp)
    this_cDescMoe  = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigIdPcp"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista registros de SigIdPcp com JOIN para descricao de moeda
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.tipos LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.tipos, a.grupos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar modelos de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorTipoGrupo - Carrega registro pela chave de negocio tipos+grupos
    *==========================================================================
    PROCEDURE CarregarPorTipoGrupo(par_cTipos, par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.tipos, a.grupos, a.descs," + ;
                       " a.limites, a.fmaxs, a.valors, a.moedas, a.ganhos," + ;
                       " ISNULL(b.dmoes, '') AS desc_moe" + ;
                       " FROM SigIdPcp a" + ;
                       " LEFT JOIN SigCdMoe b ON a.moedas = b.cmoes" + ;
                       " WHERE a.tipos = " + EscaparSQL(par_cTipos) + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar modelo por tipo/grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se ja existe registro com tipos+grupos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigIdPcp" + ;
                       " WHERE tipos = " + EscaparSQL(THIS.this_cTipos) + ;
                       " AND grupos = " + EscaparSQL(THIS.this_cGrupos)

            IF !EMPTY(ALLTRIM(THIS.this_cIdChaves))
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dupl")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dupl") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Dupl")
                USE IN cursor_4c_Dupl
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves = ALLTRIM(NVL(cidchaves, ""))
            THIS.this_cTipos    = ALLTRIM(NVL(tipos,     ""))
            THIS.this_cGrupos   = ALLTRIM(NVL(grupos,    ""))
            THIS.this_cDescs    = ALLTRIM(NVL(descs,     ""))
            THIS.this_nLimites  = NVL(limites, 0)
            THIS.this_nFmaxs    = NVL(fmaxs,   0)
            THIS.this_nValors   = NVL(valors,  0)
            THIS.this_cMoedas   = ALLTRIM(NVL(moedas,   ""))
            IF VARTYPE(ganhos) = "L"
                THIS.this_lGanhos = ganhos
            ELSE
                THIS.this_lGanhos = (NVL(ganhos, 0) = 1)
            ENDIF
            THIS.this_cDescMoe  = ALLTRIM(NVL(desc_moe, ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigIdPcp
    * Gera cidchaves via fUniqueIds()
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cTipos))
                MsgAviso("C" + CHR(243) + "digo do tipo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cGrupos))
                    MsgErro("Grupo obrigat" + CHR(243) + "rio!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF THIS.VerificarDuplicidade()
                        MsgErro("J" + CHR(225) + " existe registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
                    ELSE
                        THIS.this_cIdChaves = fUniqueIds()

                        loc_cSQL = "INSERT INTO SigIdPcp" + ;
                                   " (cidchaves, tipos, grupos, descs," + ;
                                   " limites, fmaxs, valors, moedas, ganhos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cIdChaves)           + ", " + ;
                                   EscaparSQL(THIS.this_cTipos)              + ", " + ;
                                   EscaparSQL(THIS.this_cGrupos)             + ", " + ;
                                   EscaparSQL(THIS.this_cDescs)              + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nLimites, 2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nFmaxs,   2)  + ", " + ;
                                   FormatarNumeroSQL(THIS.this_nValors,  2)  + ", " + ;
                                   EscaparSQL(THIS.this_cMoedas)             + ", " + ;
                                   IIF(THIS.this_lGanhos, "1", "0")          + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado >= 0
                            THIS.RegistrarAuditoria("INSERT")
                            loc_lSucesso = .T.
                        ELSE
                            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigIdPcp (cidchaves e chave, nao alterar)
    * tipos e grupos podem ser alterados (nao sao a PK tecnica)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("J" + CHR(225) + " existe outro registro com este Tipo e Grupo!", "Erro de valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "UPDATE SigIdPcp SET" + ;
                           " tipos   = " + EscaparSQL(THIS.this_cTipos)             + ", " + ;
                           " grupos  = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                           " descs   = " + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                           " limites = " + FormatarNumeroSQL(THIS.this_nLimites, 2) + ", " + ;
                           " fmaxs   = " + FormatarNumeroSQL(THIS.this_nFmaxs,   2) + ", " + ;
                           " valors  = " + FormatarNumeroSQL(THIS.this_nValors,  2) + ", " + ;
                           " moedas  = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                           " ganhos  = " + IIF(THIS.this_lGanhos, "1", "0") + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigIdPcp
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigIdPcp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir modelo de trabalho:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

