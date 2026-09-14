# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NGRUPOS, CIDCHAVES, GRUPOS, SPESOS, CTITS, CODIGOS, EMPS, MERCS, DATAS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NGRUPOS, CIDCHAVES, GRUPOS, SPESOS, CTITS, CODIGOS, EMPS, MERCS, DATAS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NGRUPOS, CIDCHAVES, GRUPOS, SPESOS, CTITS, CODIGOS, EMPS, MERCS, DATAS, CPROS

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
  DeleteMark = .F.
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Insert Into csCabecalho (nm_empresa, nm_titulo, nm_periodo,cb_empresa ) ;
lcSql = [Select a.codigos,b.descrs,b.faixafs,b.faixais from SigCdPpc a, SigCdPpi b ]+;
If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpProP') < 1
Select TmpProp
Select CsEstoque
		lcSql = [Select a.Cpros, 'E' as Opers, Sum(a.Sqtds) as Sqtds, Sum(a.sPesos) as sPesos, ] + ;
				  [From SigMvEst a, SigCdPro b, SigCdGrp c ] + ;
		lcSql = [Select a.Cpros, a.Opers, Sum(a.Qtds) as Sqtds, Sum(a.Pesos) as sPesos, ] + ;
				  [From SigMvHst a, SigCdPro b, SigCdGrp c ] + ;
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpEst') < 1
	Select TmpEst
		lcSql = [Select Resps From SigCdPft Where cTits = ']+Padr(Alltrim(lcCarac),20)+[' And ]+;
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpProft') < 1
		Select TmpProft
		Select TmpProP
			Select CsRelatorio
			If Not Seek(lcResp+m.Cgrus+Str(TmpProp.Faixais,12,2)+Str(TmpProp.FaixaFs,12,2)+Str(1,2)+Str(LnPVen,12,2)+m.Cunis+m.cUnips)
Select cTits, cResps, Cgrus, 9 as Ps, cUnis, Space(20) as Descrs, FaixaIs, FaixaFs, 0 as  Pvens, cUniPs, ;
		Sum(Qtds) as Qtds, sum(Pesos) as Pesos, sum(TotQtds) as TotQtds From CsRelatorio ;
Select cTits, Replicate(Chr(254),100) as cResps, Replicate(Chr(254),3) as Cgrus, 9 as Ps, cUnis, Padr('Total Geral',20) as Descrs, ;
		Sum(Qtds) as Qtds, sum(Pesos) as Pesos, sum(TotQtds) as TotQtds From CsRelatorio ;
Select CsRelatorio
Append From Dbf('DbTotal')
Select CsRelatorio
			.Column1.Controlsource = 'CsEstoque.Emps'
			.Column2.Controlsource = 'CsEstoque.Grupos'
		Select CsEstoque
	Select * From CsEstoque Into Cursor ChecDados where grupos+Emps <> ' ' ReadWrite
	Select ChecDados
Select CsEstoque

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREFXV.prg) - TRECHOS RELEVANTES PARA PASS SQL (1545 linhas total):

*-- Linhas 91 a 115:
91: 
92:             IF loc_lContinuar
93:                 *-- Criar cursor CsEstoque para o grid de pares Empresa/Grupo
94:                 *   (replica o Create Cursor CsEstoque do procedimento "fConfigGeral"
95:                 *    do form legado - cursor gerenciado pelo form, referenciado pelo BO)
96:                 IF USED("CsEstoque")
97:                     USE IN CsEstoque
98:                 ENDIF
99:                 CREATE CURSOR CsEstoque (Emps C(3), Grupos C(10))
100:                 INSERT INTO CsEstoque (Emps, Grupos) VALUES ("", "")
101: 
102:                 *-- Cabecalho escuro com titulo (equivalente ao cntSombra)
103:                 THIS.ConfigurarCabecalho()
104: 
105:                 *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
106:                 THIS.ConfigurarBotoes()
107: 
108:                 *-- PageFrame com pagina de filtros
109:                 THIS.ConfigurarPageFrame()
110: 
111:                 *-- Campos de filtro, grid e container Aguarde na Page1
112:                 THIS.ConfigurarCamposFiltro()
113: 
114:                 *-- Vincular eventos de validacao do grid CsEstoque (Empresa/Grupo)
115:                 THIS.ConfigurarPaginaDados()

*-- Linhas 639 a 674:
639:             .ColumnCount       = 2
640:             .RecordSource      = "CsEstoque"
641:             .RecordMark        = .F.
642:             .DeleteMark        = .F.
643:             .ScrollBars        = 2
644:             .FontName          = "Verdana"
645:             .FontSize          = 8
646:             .GridLineColor     = RGB(238, 238, 238)
647:             .HighlightBackColor = RGB(255, 255, 255)
648:             .HighlightForeColor = RGB(15, 41, 104)
649:             .HighlightStyle    = 2
650:             .Visible           = .T.
651: 
652:             WITH .Column1
653:                 .ControlSource    = "CsEstoque.Emps"
654:                 .Width            = 80
655:                 .Header1.Caption  = "Empresa"
656:             ENDWITH
657: 
658:             WITH .Column2
659:                 .ControlSource    = "CsEstoque.Grupos"
660:                 .Width            = 100
661:                 .Header1.Caption  = "Grupo Estoque"
662:             ENDWITH
663:         ENDWITH
664:         BINDEVENT(par_oPg.grd_4c_Dados, "AfterRowColChange", THIS, ;
665:             "GrdEstoquesAfterRowColChange")
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * ConfigurarContainerAguarde - Container visivel durante processamento
670:     * Equivalente ao Aguarde do legado (top=190, left=261 no form original)
671:     *--------------------------------------------------------------------------
672:     PROTECTED PROCEDURE ConfigurarContainerAguarde(par_oPg)
673:         par_oPg.AddObject("cnt_4c_Aguarde", "Container")
674:         WITH par_oPg.cnt_4c_Aguarde

*-- Linhas 767 a 787:
767:         loc_oPg.txt_4c__ds_grupo.Value    = ""
768: 
769:         IF USED("CsEstoque")
770:             SELECT CsEstoque
771:             ZAP
772:             INSERT INTO CsEstoque (Emps, Grupos) VALUES ("", "")
773:             loc_oPg.grd_4c_Dados.Refresh()
774:         ENDIF
775:     ENDPROC
776: 
777:     *--------------------------------------------------------------------------
778:     * FormParaRelatorio - Transfere valores do form para as propriedades do BO
779:     *--------------------------------------------------------------------------
780:     PROTECTED PROCEDURE FormParaRelatorio()
781:         LOCAL loc_oPg
782:         loc_oPg = THIS.pgf_4c_Paginas.Page1
783: 
784:         WITH THIS.this_oRelatorio
785:             .this_nNrPeriodo = loc_oPg.obj_4c_OptRfEstoque.Value
786:             .this_dDataSaldo  = loc_oPg.txt_4c_DataSaldo.Value
787:             .this_cCdMoeda    = ALLTRIM(loc_oPg.txt_4c__cd_moeda.Value)

*-- Linhas 916 a 934:
916:                 IF USED("CsRelatorio")
917:                     loc_cArquivo = gc_4c_CaminhoBase + "reports\SigReFxv_" + ;
918:                                    STRTRAN(DTOC(DATE(), 1), "-", "") + ".xls"
919:                     SELECT CsRelatorio
920:                     COPY TO (loc_cArquivo) TYPE XL5
921:                     MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, "Excel")
922:                     loc_lSucesso = .T.
923:                 ELSE
924:                     MsgAviso("Nenhum dado para exportar.", "Aviso")
925:                 ENDIF
926:             ELSE
927:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
928:             ENDIF
929:         CATCH TO loc_oErro
930:             MsgErro(loc_oErro.Message, "Erro ao exportar Excel")
931:         ENDTRY
932: 
933:         loc_oPg.cnt_4c_Aguarde.Visible = .F.
934:     ENDPROC

*-- Linhas 1049 a 1067:
1049:         ENDIF
1050: 
1051:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Moeda")
1052:             SELECT cursor_4c_Moeda
1053:             IF !EOF()
1054:                 loc_oPg.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
1055:                 loc_oPg.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
1056:             ENDIF
1057:         ENDIF
1058: 
1059:         IF USED("cursor_4c_Moeda")
1060:             USE IN cursor_4c_Moeda
1061:         ENDIF
1062:         loc_oForm.Release()
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------
1066:     * AbrirBuscaMoedaDesc - Lookup SigCdMoe pela descricao (DMoes)
1067:     *--------------------------------------------------------------------------

*-- Linhas 1085 a 1103:
1085:         ENDIF
1086: 
1087:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Moeda")
1088:             SELECT cursor_4c_Moeda
1089:             IF !EOF()
1090:                 loc_oPg.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
1091:                 loc_oPg.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
1092:             ENDIF
1093:         ENDIF
1094: 
1095:         IF USED("cursor_4c_Moeda")
1096:             USE IN cursor_4c_Moeda
1097:         ENDIF
1098:         loc_oForm.Release()
1099:     ENDPROC
1100: 
1101:     *--------------------------------------------------------------------------
1102:     * AbrirBuscaCaracteristica - Lookup SigPrCpP pelo codigo do titulo (Codigos)
1103:     *--------------------------------------------------------------------------

*-- Linhas 1121 a 1139:
1121:         ENDIF
1122: 
1123:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Carac")
1124:             SELECT cursor_4c_Carac
1125:             IF !EOF()
1126:                 loc_oPg.txt_4c_FichaT.Value = ALLTRIM(Codigos)
1127:             ENDIF
1128:         ENDIF
1129: 
1130:         IF USED("cursor_4c_Carac")
1131:             USE IN cursor_4c_Carac
1132:         ENDIF
1133:         loc_oForm.Release()
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * AbrirBuscaGrandeGrupoCodigo - Lookup SigCdGpr pelo codigo (Codigos)
1138:     *--------------------------------------------------------------------------
1139:     PROTECTED PROCEDURE AbrirBuscaGrandeGrupoCodigo()

*-- Linhas 1156 a 1174:
1156:         ENDIF
1157: 
1158:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GGrp")
1159:             SELECT cursor_4c_GGrp
1160:             IF !EOF()
1161:                 loc_oPg.txt_4c_GGrus.Value = ALLTRIM(Codigos)
1162:                 loc_oPg.txt_4c_DGRus.Value = ALLTRIM(Descs)
1163:             ENDIF
1164:         ENDIF
1165: 
1166:         IF USED("cursor_4c_GGrp")
1167:             USE IN cursor_4c_GGrp
1168:         ENDIF
1169:         loc_oForm.Release()
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * AbrirBuscaGrandeGrupoDesc - Lookup SigCdGpr pela descricao (Descs)
1174:     *--------------------------------------------------------------------------

*-- Linhas 1192 a 1210:
1192:         ENDIF
1193: 
1194:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GGrp")
1195:             SELECT cursor_4c_GGrp
1196:             IF !EOF()
1197:                 loc_oPg.txt_4c_GGrus.Value = ALLTRIM(Codigos)
1198:                 loc_oPg.txt_4c_DGRus.Value = ALLTRIM(Descs)
1199:             ENDIF
1200:         ENDIF
1201: 
1202:         IF USED("cursor_4c_GGrp")
1203:             USE IN cursor_4c_GGrp
1204:         ENDIF
1205:         loc_oForm.Release()
1206:     ENDPROC
1207: 
1208:     *--------------------------------------------------------------------------
1209:     * AbrirBuscaGrupoCodigo - Lookup SigCdGrp pelo codigo (CGrus)
1210:     *--------------------------------------------------------------------------

*-- Linhas 1228 a 1246:
1228:         ENDIF
1229: 
1230:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Grp")
1231:             SELECT cursor_4c_Grp
1232:             IF !EOF()
1233:                 loc_oPg.txt_4c__cd_grupo.Value = ALLTRIM(CGrus)
1234:                 loc_oPg.txt_4c__ds_grupo.Value = ALLTRIM(DGrus)
1235:             ENDIF
1236:         ENDIF
1237: 
1238:         IF USED("cursor_4c_Grp")
1239:             USE IN cursor_4c_Grp
1240:         ENDIF
1241:         loc_oForm.Release()
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * AbrirBuscaGrupoDesc - Lookup SigCdGrp pela descricao (DGrus)
1246:     *--------------------------------------------------------------------------

*-- Linhas 1264 a 1304:
1264:         ENDIF
1265: 
1266:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Grp")
1267:             SELECT cursor_4c_Grp
1268:             IF !EOF()
1269:                 loc_oPg.txt_4c__cd_grupo.Value = ALLTRIM(CGrus)
1270:                 loc_oPg.txt_4c__ds_grupo.Value = ALLTRIM(DGrus)
1271:             ENDIF
1272:         ENDIF
1273: 
1274:         IF USED("cursor_4c_Grp")
1275:             USE IN cursor_4c_Grp
1276:         ENDIF
1277:         loc_oForm.Release()
1278:     ENDPROC
1279: 
1280:     *--------------------------------------------------------------------------
1281:     * GrdEstoquesAfterRowColChange - Mantem linha em branco ao final do grid
1282:     * Replica logica do LostFocus do Column2.Text1 do legado SIGREFXV
1283:     * par_nColIndex: indice da coluna que perdeu o foco
1284:     *--------------------------------------------------------------------------
1285:     PROCEDURE GrdEstoquesAfterRowColChange(par_nColIndex)
1286:         IF !USED("CsEstoque")
1287:             RETURN
1288:         ENDIF
1289:         SELECT CsEstoque
1290:         LOCATE FOR EMPTY(Emps) AND EMPTY(Grupos)
1291:         IF EOF()
1292:             APPEND BLANK
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     *-- FASE 5: Validacao do Grid CsEstoque (ConfigurarPaginaDados)
1298:     *==========================================================================
1299: 
1300:     *--------------------------------------------------------------------------
1301:     * ConfigurarPaginaDados - Vincula eventos de validacao dos Text1 do grid
1302:     *   Para forms REPORT (sem Page2 CRUD), este metodo configura os handlers
1303:     *   de teclado para os campos editaveis do grid CsEstoque:
1304:     *   - Column1.Text1: replica fAcessoEmpresa do legado (valida Emps)

*-- Linhas 1360 a 1380:
1360:         ENDIF
1361: 
1362:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Emp")
1363:             SELECT cursor_4c_Emp
1364:             IF !EOF() AND USED("CsEstoque")
1365:                 SELECT CsEstoque
1366:                 REPLACE Emps WITH ALLTRIM(Cemps)
1367:                 loc_oGrd.Refresh()
1368:             ENDIF
1369:         ENDIF
1370: 
1371:         IF USED("cursor_4c_Emp")
1372:             USE IN cursor_4c_Emp
1373:         ENDIF
1374:         loc_oForm.Release()
1375:     ENDPROC
1376: 
1377:     *--------------------------------------------------------------------------
1378:     * ValidarGrupoEstoqueGrid - Lookup de grupo de estoque para coluna Grupos
1379:     *   Replica fAcessoContab(Usuar, 'C', This.Value, This, '') do legado.
1380:     *   Valida CGrus em SigCdGrp; se nao encontrado, abre FormBuscaAuxiliar.

*-- Linhas 1389 a 1428:
1389:             RETURN
1390:         ENDIF
1391: 
1392:         loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cValor)
1393:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
1394: 
1395:         IF loc_nResult > 0
1396:             SELECT cursor_4c_GrpVal
1397:             IF EOF()
1398:                 *-- Codigo nao encontrado - abrir busca visual
1399:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1400:                     "SigCdGrp", "cursor_4c_GrpSel", "CGrus", loc_cValor, ;
1401:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo de Estoque")
1402: 
1403:                 IF !ISNULL(loc_oForm)
1404:                     IF !loc_oForm.this_lAchouRegistro
1405:                         loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1406:                         loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1407:                         loc_oForm.Show()
1408:                     ENDIF
1409: 
1410:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrpSel")
1411:                         SELECT cursor_4c_GrpSel
1412:                         IF !EOF() AND USED("CsEstoque")
1413:                             SELECT CsEstoque
1414:                             REPLACE Grupos WITH ALLTRIM(CGrus)
1415:                             loc_oGrd.Refresh()
1416:                         ENDIF
1417:                     ENDIF
1418: 
1419:                     IF USED("cursor_4c_GrpSel")
1420:                         USE IN cursor_4c_GrpSel
1421:                     ENDIF
1422:                     loc_oForm.Release()
1423:                 ENDIF
1424:             ENDIF
1425:             IF USED("cursor_4c_GrpVal")
1426:                 USE IN cursor_4c_GrpVal
1427:             ENDIF
1428:         ENDIF


### BO (C:\4c\projeto\app\classes\SIGREFXVBO.prg):
*==============================================================================
* SIGREFXVBO.PRG
* Business Object para Relatorio de Posicao de Estoque por Grupo/Faixa de Valor
* Herda de RelatorioBase
*
* Tabela principal: SigMvEst / SigMvHst (movimentos de estoque)
* Relatorio FRX: SigReFxv.frx
*
* Filtros:
*   - Posicao: Atual (SigMvEst) ou Retroativa (SigMvHst ate data informada)
*   - Moeda: codigo + descricao (SigCdMoe)
*   - Complemento Caracteristica: codigo do titulo da ficha (SigPrCpP)
*   - Grande Grupo: codigo + descricao (SigCdGpr.Codigos/Descs)
*   - Grupo de Produto: codigo + descricao (SigCdGrp.CGrus/DGrus) - opcional
*   - Grid de Estoques: pares Empresa/Grupo alimentados pelo usuario (cursor CsEstoque)
*==============================================================================

DEFINE CLASS SIGREFXVBO AS RelatorioBase

    *-- Filtro: tipo de periodo (1=Atual / 2=Retroativa - espelha OptRfEstoque.Value)
    this_nNrPeriodo     = 1

    *-- Filtro: data da posicao retroativa (usado quando this_nNrPeriodo = 2)
    this_dDataSaldo     = {}

    *-- Filtro: moeda (CMoes / DMoes de SigCdMoe)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtro: complemento caracteristica (Codigos de SigPrCpP)
    this_cFichaT        = ""

    *-- Filtro: grande grupo (Codigos / Descs de SigCdGpr)
    this_cGGrus         = ""
    this_cDGRus         = ""

    *-- Filtro: grupo de produto opcional (CGrus / DGrus de SigCdGrp)
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Nome do cursor com pares Empresa/Grupo alimentados pelo grid do form
    *   O form mantem o cursor CsEstoque; PrepararDados() le a partir dele
    this_cCursorEstoque = "CsEstoque"

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "CsRelatorio"

    *-- Caminho do arquivo FRX para REPORT FORM
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de posicao de estoque
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvEst"
        THIS.this_cCampoChave = ""
        THIS.this_cArquivoFRX = gc_4c_CaminhoBase + "reports\SigReFxv.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                                 "o de Estoque por Grupo de Produto/Faixa de Valor"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados para o relatorio
    * Replica logica do procedimento "processamento" do form legado SIGREFXV
    * Popula cursores: csCabecalho, CsRelatorio (this_cCursorDados)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nCotMoe
        LOCAL loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo
        LOCAL loc_cGrupo, loc_cDsGrupo, loc_cGde, loc_cCarac
        LOCAL loc_cResp, loc_nPVen, loc_nCota, loc_cChaveBusca
        LOCAL loc_cAlias
        LOCAL pDat

        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF EMPTY(ALLTRIM(THIS.this_cGGrus))
                THIS.this_cMensagemErro = "Grande Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!"
                MsgAviso(THIS.this_cMensagemErro)
            ELSE
            IF !USED(THIS.this_cCursorEstoque)
                THIS.this_cMensagemErro = "Cursor de estoques n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
            IF !THIS.ValidarGridEstoque()
                *-- ValidarGridEstoque ja exibe mensagem e define this_cMensagemErro
            ELSE
                *-- Inicializar variaveis locais de filtro
                loc_cGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_cDsGrupo = ALLTRIM(THIS.this_cDsGrupo)
                loc_cGde     = ALLTRIM(THIS.this_cGGrus)
                loc_cCarac   = ALLTRIM(THIS.this_cFichaT)

                *-- Obter cotacao da moeda de referencia
                loc_nCotMoe = fBuscarCotacao(THIS.this_cCdMoeda, DATE())
                IF loc_nCotMoe = 0
                    loc_nCotMoe = 1
                ENDIF

                *-- Obter nome da empresa atual
                loc_cNmEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

                *-- Montar strings de titulo e periodo
                loc_cNmTitulo  = "Estoque Por Faixa de Pre" + CHR(231) + "o " + ;
                                 IIF(!EMPTY(loc_cGrupo), ;
                                     "Grupo:" + loc_cGrupo + "-" + loc_cDsGrupo, ;
                                     "")
                loc_cNmPeriodo = "Em " + ;
                                 IIF(THIS.this_nNrPeriodo = 1, ;
                                     DTOC(DATE()), DTOC(THIS.this_dDataSaldo)) + ;
                                 "  Moeda:" + THIS.this_cCdMoeda

                *-- Criar cursor csCabecalho para o FRX
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF
                CREATE CURSOR csCabecalho ;
                    (nm_empresa C(80), nm_titulo C(80), nm_periodo C(80), cb_empresa C(80))
                INSERT INTO csCabecalho (nm_empresa, nm_titulo, nm_periodo, cb_empresa) ;
                       VALUES (loc_cNmEmpresa, loc_cNmTitulo, loc_cNmPeriodo, "")

                *-- Criar cursor CsRelatorio (nome exato referenciado pelo FRX)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                CREATE CURSOR CsRelatorio ;
                    (cTits C(20), cResps C(100), Cgrus C(3), ps N(2), cUnis C(3), ;
                     Descrs C(20), FaixaIs N(12,2), FaixaFs N(12,2), Pvens N(12,2), ;
                     Qtds N(12,3), Pesos N(12,3), TotQtds N(12,2), TotPesos N(12,3), ;
                     cUnips C(3))
                INDEX ON cResps + Cgrus + ;
                         STR(FaixaIs,12,2) + STR(FaixaFs,12,2) + ;
                         STR(Ps,2) + STR(Pvens,12,2) + ;
                         cUnis + cUnips TAG Quebra

                *-- Buscar faixas de preco em SigCdPpc/SigCdPpi
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                loc_cSQL = "SELECT a.codigos, b.descrs, b.faixafs, b.faixais " + ;
                           "FROM SigCdPpc a, SigCdPpi b " + ;
                           "WHERE a.ngrupos = 1 AND a.cidchaves = b.fkchaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProP") < 1
                    THIS.this_cMensagemErro = "Falha ao buscar faixas de pre" + ;
                                             CHR(231) + CHR(227) + "o (TmpProp)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    SELECT cursor_4c_TmpProP
                    INDEX ON Codigos + STR(Faixais,12,2) + STR(FaixaFs,12,2) TAG Codigos

                    *-- Preparar datetime para posicao retroativa (?pDat em SQLEXEC)
                    pDat = fDtoSQL(THIS.this_dDataSaldo, "23:59:59")

                    *-- Loop pelos pares Empresa/Grupo do cursor CsEstoque
                    loc_lSucesso = .T.
                    loc_cAlias   = THIS.this_cCursorEstoque
                    SELECT (loc_cAlias)
                    SCAN
                        IF EMPTY(Grupos) AND EMPTY(Emps)
                            LOOP
                        ENDIF
                        SCATTER MEMVAR

                        *-- Montar SQL de movimentos (Atual ou Retroativo)
                        IF THIS.this_nNrPeriodo = 1
                            loc_cSQL = "SELECT a.Cpros, 'E' AS Opers, " + ;
                                       "SUM(a.Sqtds) AS Sqtds, SUM(a.sPesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvEst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ELSE
                            loc_cSQL = "SELECT a.Cpros, a.Opers, " + ;
                                       "SUM(a.Qtds) AS Sqtds, SUM(a.Pesos) AS sPesos, " + ;
                                       "b.cUnis, b.pVens, b.Moevs, b.Cgrus, b.cUniPs " + ;
                                       "FROM SigMvHst a, SigCdPro b, SigCdGrp c " + ;
                                       "WHERE a.Grupos = " + EscaparSQL(m.Grupos) + ;
                                       " AND a.Datas <= ?pDat" + ;
                                       IIF(EMPTY(m.Emps), "", ;
                                           " AND a.Emps = " + EscaparSQL(m.Emps)) + ;
                                       " AND a.Cpros = b.Cpros" + ;
                                       " AND a.Grupos = c.CGrus" + ;
                                       " AND c.Mercs = " + EscaparSQL(loc_cGde) + ;
                                       " GROUP BY a.Cpros, a.Opers, b.cUnis, b.pVens, " + ;
                                       "b.Moevs, b.Cgrus, b.cUniPs"
                        ENDIF

                        IF USED("cursor_4c_TmpEst")
                            USE IN cursor_4c_TmpEst
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                            THIS.this_cMensagemErro = "Falha ao buscar movimentos de estoque (TmpEst)"
                            MsgErro(THIS.this_cMensagemErro, "Erro")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_TmpEst
                        SCAN
                            IF cursor_4c_TmpEst.Sqtds = 0 AND cursor_4c_TmpEst.sPesos = 0
                                LOOP
                            ENDIF
                            SCATTER MEMVAR

                            *-- Buscar caracteristica do produto em SigCdPft
                            IF USED("cursor_4c_TmpProft")
                                USE IN cursor_4c_TmpProft
                            ENDIF
                            loc_cSQL = "SELECT Resps FROM SigCdPft " + ;
                                       "WHERE cTits = " + EscaparSQL(PADR(ALLTRIM(loc_cCarac), 20)) + ;
                                       " AND Cpros = " + EscaparSQL(m.Cpros)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProft") < 1
                                THIS.this_cMensagemErro = "Falha ao buscar caracter" + ;
                                                         CHR(237) + "sticas (TmpProft)"
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                loc_lSucesso = .F.
                                EXIT
                            ENDIF

                            *-- Extrair resposta da caracteristica
                            SELECT cursor_4c_TmpProft
                            GO TOP
                            loc_cResp = ""
                            IF !EOF("cursor_4c_TmpProft")
                                loc_cResp = STRTRAN(cursor_4c_TmpProft.Resps, CHR(13), "")
                                loc_cResp = STRTRAN(loc_cResp, CHR(10), "")
                                loc_cResp = LEFT(loc_cResp, 100)
                            ENDIF
                            loc_cResp = PADR(IIF(EMPTY(loc_cResp), " ", loc_cResp), 100)

                            *-- Converter preco para moeda de referencia
                            loc_nPVen = m.pVens
                            IF m.Moevs <> THIS.this_cCdMoeda
                                loc_nCota = fBuscarCotacao(m.Moevs, DATE())
                                IF loc_nCota = 0
                                    loc_nCota = 1
                                ENDIF
                                loc_nPVen = ROUND(m.pVens * loc_nCota / loc_nCotMoe, 2)
                            ENDIF

                            *-- Localizar faixa de preco no TmpProP
                            SELECT cursor_4c_TmpProP
                            LOCATE FOR cursor_4c_TmpProP.Codigos = m.Cgrus AND ;
                                       BETWEEN(loc_nPVen, ;
                                               cursor_4c_TmpProP.FaixaIs, ;
                                               cursor_4c_TmpProP.FaixaFs)
                            IF !EOF("cursor_4c_TmpProP")
                                loc_cChaveBusca = loc_cResp + m.Cgrus + ;
                                                 STR(cursor_4c_TmpProP.Faixais, 12, 2) + ;
                                                 STR(cursor_4c_TmpProP.FaixaFs, 12, 2) + ;
                                                 STR(1, 2) + ;
                                                 STR(loc_nPVen, 12, 2) + ;
                                                 m.cUnis + m.cUniPs
                                SELECT CsRelatorio
                                IF !SEEK(loc_cChaveBusca)
                                    APPEND BLANK
                                    REPLACE cResps   WITH loc_cResp, ;
                                            Cgrus    WITH m.Cgrus, ;
                                            cUnis    WITH m.cUnis, ;
                                            Descrs   WITH cursor_4c_TmpProP.Descrs, ;
                                            FaixaIs  WITH cursor_4c_TmpProP.FaixaIs, ;
                                            FaixaFs  WITH cursor_4c_TmpProP.FaixaFs, ;
                                            Pvens    WITH loc_nPVen, ;
                                            cUnips   WITH m.cUniPs, ;
                                            ps       WITH 1, ;
                                            cTits    WITH loc_cCarac
                                ENDIF
                                REPLACE Qtds     WITH Qtds + ;
                                                     (m.Sqtds * IIF(m.Opers = "E", 1, -1)), ;
                                        Pesos    WITH Pesos + ;
                                                     (m.sPesos * IIF(m.Opers = "E", 1, -1)), ;
                                        TotQtds  WITH ROUND(Qtds * Pvens, 2), ;
                                        TotPesos WITH ROUND(Pesos * Pvens, 2)
                            ENDIF
                        ENDSCAN

                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN

                    *-- Gerar linhas de subtotal e total geral via VFP UNION ALL local
                    IF loc_lSucesso AND RECCOUNT("CsRelatorio") > 0
                        SELECT cTits, cResps, Cgrus, 9 AS Ps, cUnis, ;
                               SPACE(20) AS Descrs, FaixaIs, FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cResps, Cgrus, cUnis, FaixaIs, FaixaFs, cUnips ;
                        UNION ALL ;
                        SELECT cTits, REPLICATE(CHR(254), 100) AS cResps, ;
                               REPLICATE(CHR(254), 3) AS Cgrus, ;
                               9 AS Ps, cUnis, ;
                               PADR("Total Geral", 20) AS Descrs, ;
                               00000000.00 AS FaixaIs, 000000000.00 AS FaixaFs, ;
                               0 AS Pvens, cUnips, ;
                               SUM(Qtds) AS Qtds, SUM(Pesos) AS Pesos, ;
                               SUM(TotQtds) AS TotQtds ;
                               FROM CsRelatorio ;
                               GROUP BY cTits, cUnis, cUnips ;
                        INTO CURSOR cursor_4c_DbTotal

                        SELECT CsRelatorio
                        APPEND FROM DBF("cursor_4c_DbTotal")

                        IF USED("cursor_4c_DbTotal")
                            USE IN cursor_4c_DbTotal
                        ENDIF
                    ENDIF

                    IF loc_lSucesso
                        SELECT CsRelatorio
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                *-- Limpar cursores temporarios
                IF USED("cursor_4c_TmpProP")
                    USE IN cursor_4c_TmpProP
                ENDIF
                IF USED("cursor_4c_TmpEst")
                    USE IN cursor_4c_TmpEst
                ENDIF
                IF USED("cursor_4c_TmpProft")
                    USE IN cursor_4c_TmpProft
                ENDIF
            ENDIF
            ENDIF
            ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGridEstoque - Verifica duplicidades e inconsistencias no CsEstoque
    * Retorna .T. se valido, .F. se ha problemas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGridEstoque()
        LOCAL loc_lValido, loc_cGrupo, loc_cEmp, loc_cAlias

        loc_lValido  = .T.
        loc_cAlias   = THIS.this_cCursorEstoque

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF

        SELECT * FROM (loc_cAlias) INTO CURSOR cursor_4c_ChecDados READWRITE ;
               WHERE !EMPTY(Grupos) OR !EMPTY(Emps)

        IF RECCOUNT("cursor_4c_ChecDados") = 0
            IF USED("cursor_4c_ChecDados")
                USE IN cursor_4c_ChecDados
            ENDIF
            RETURN .T.
        ENDIF

        SELECT cursor_4c_ChecDados
        INDEX ON Grupos + Emps TAG Grupos
        GO TOP

        SCAN
            loc_cGrupo = cursor_4c_ChecDados.Grupos
            loc_cEmp   = cursor_4c_ChecDados.Emps
            SKIP
            IF !EOF("cursor_4c_ChecDados")
                IF cursor_4c_ChecDados.Grupos = loc_cGrupo AND ;
                   cursor_4c_ChecDados.Emps = loc_cEmp
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + "ncia na grade de Estoque: " + ;
                                             ALLTRIM(loc_cEmp) + "/" + ALLTRIM(loc_cGrupo) + ;
                                             " est" + CHR(225) + " duplicado"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                IF ALLTRIM(loc_cEmp) = "" AND ;
                   cursor_4c_ChecDados.Grupos = loc_cGrupo
                    THIS.this_cMensagemErro = "Inconsist" + CHR(234) + ;
                                             "ncia na grade de Estoque: Grupo:" + ;
                                             ALLTRIM(loc_cGrupo) + ;
                                             " com empresa em branco " + ;
                                             "n" + CHR(227) + "o pode estar relacionado " + ;
                                             "com outra empresa"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lValido = .F.
                    EXIT
                ENDIF
                SKIP -1
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_ChecDados")
            USE IN cursor_4c_ChecDados
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel a relatorios
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

