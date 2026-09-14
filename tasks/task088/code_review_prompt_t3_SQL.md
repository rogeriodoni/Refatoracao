# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, ESTOQUES, GRUPOS, INTERNOS, PCONEXAO, EMPS, SQTDS, CPROS, LINHAS, CGRUS, DATAS, MARCAS, CONTAS

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
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas From SigCdEmp Where cemps = ']+_Empr+[' ],'CrSigCdEmp')
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select codigos From SigCdGcr Where estoques = 1 ],'TmpGccr')
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select b.grupos,b.iclis From SigCdCli b, SigCdGcr c ]+;
	 Select 0 As marcas,codigos As grupos,'          ' As contas ;
	   From TmpGccr a ;
	 Select 0 As marcas,grupos,iclis As contas ;
	   From TmpCliGccr ;
Select Selecao
	.column1.ControlSource = 'Selecao.marcas'
	.column2.ControlSource = 'Selecao.grupos'
	.column3.ControlSource = 'Selecao.contas'
Insert Into dbCabecalho ( Titulo, SubTitulo, NomeEmpresa ) Value ( lcCbTitulo, lcCbGrupo, lcCbEmpresa )
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cpros,a.emps,a.grupos,a.estos,a.sqtds,a.sqtds As qtds, c.Dpros, c.Linhas, ]+;
		   [From SigMvEst a, SigCdPro c, SigCdLin d ]+;
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.grupos,a.estos,a.cpros,a.qtds,a.opers, ]+;
			        [From SigMvHst a Left Join SigCdPro c on a.cpros = c.Cpros Left Join SigCdLin f On c.Linhas = f.Linhas ]+;
		Select emps,grupos,estos,cpros,Sum(qtds * Iif(opers = 'E',1,-1)) As qtds, ;
		From TmpEstPro ;
		Select a.cpros,a.emps,a.grupos,a.estos,a.Dpros,a.Linhas,a.custofs,a.pvens,a.fvendas,;
		From CsTmpEst a, Selecao b ;
		Select a.Emps, a.grupos, a.Estos, a.cpros, Sum(a.Qtds * Iif(a.Opers='E',1,-1)) as Qtds, b.Dpros, b.Linhas, ;
		From SigMvHst a, TmpEst2 b;
	Select Distinct a.cpros,a.emps,a.grupos,a.estos,a.qtds,a.Dpros,a.Linhas,;
	From CsTmpEst a, Selecao b ;
Select TmpEst
Select TmpEst 
	loBarra.Update(.T.)
			lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cpros,cgrus,pcompos,qtds,moeds ]+;
				   [From SigPrCpo ]+;
		Select CrSigPrCpo
	Select CsTempoCp
	Select csTempoGr
	If !Seek(' '+m.grupos+m.contas+' '+m.linhas+m.moevenda+m.moecusto)
	Select TmpEst
Select '5' As tipos,PadR('Tot Linha',10) As grupos,Space(10) As contas,linhas,Sum(tpesos) As tpesos,;
	From CsTempoGr Group by 1,4,8,10 ;
Select '6' As tipos,PadR('Tot Geral',10) As grupos,Space(10) As contas,Space(10) As linhas,Sum(tpesos) As tpesos,;
	From CsTempoGr Group by 1,8,10 ;
Select ' ' As tipos,grupos,contas,Padr('Total',10) As linhas,Sum(tpesos) As tpesos,;
	From CsTempoGr Group by 1,2,3,8,10 ;
Select CsTempoGr
Select Tempo
	Select CsTempoGr
	Select CsTempoCp
Select CsTempoGr
Select Selecao
	Select Selecao
Select Selecao
Select Selecao
		Select Selecao
		Select Selecao
	Select Selecao
Select Selecao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEQR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1702 linhas total):

*-- Linhas 668 a 708:
668:             .HighlightBackColor = RGB(255, 255, 255)
669:             .HighlightForeColor = RGB(15, 41, 104)
670:             .HighlightStyle     = 2
671:             .DeleteMark         = .F.
672:             .RecordMark         = .F.
673:             .RowHeight          = 16
674:             .ScrollBars         = 2
675:             .Visible            = .T.
676:         ENDWITH
677: 
678:         *-- Column1: CheckBox para marcar/desmarcar grupos e contas
679:         loc_oGrd.Column1.AddObject("Check1", "CheckBox")
680:         loc_oGrd.Column1.Check1.Caption  = ""
681:         loc_oGrd.Column1.CurrentControl  = "Check1"
682:         loc_oGrd.Column1.ControlSource   = "Selecao.marcas"
683:         loc_oGrd.Column1.Width           = 30
684:         loc_oGrd.Column1.Header1.Caption = ""
685: 
686:         *-- Column2: Grupo (somente leitura)
687:         loc_oGrd.Column2.ControlSource   = "Selecao.grupos"
688:         loc_oGrd.Column2.Width           = 107
689:         loc_oGrd.Column2.ReadOnly        = .T.
690:         loc_oGrd.Column2.Header1.Caption = "Grupo"
691: 
692:         *-- Column3: Conta (somente leitura)
693:         loc_oGrd.Column3.ControlSource   = "Selecao.contas"
694:         loc_oGrd.Column3.Width           = 107
695:         loc_oGrd.Column3.ReadOnly        = .T.
696:         loc_oGrd.Column3.Header1.Caption = "Conta"
697: 
698:         *-- RecordSource apenas se cursor Selecao foi populado
699:         IF USED("Selecao")
700:             loc_oGrd.RecordSource     = "Selecao"
701:             loc_oGrd.RecordSourceType = 1
702:         ENDIF
703: 
704:         BINDEVENT(loc_oGrd.Column1.Check1, "Click", THIS, "ChkGradeClick")
705:         TRY
706:             BINDEVENT(loc_oGrd.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarFoco")
707:         CATCH
708:         ENDTRY

*-- Linhas 820 a 842:
820:         loc_oPag.txt_4c_DsEmpresa.Value = ""
821: 
822:         IF !EMPTY(loc_cCodEmp) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
823:             loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
824:                        EscaparSQL(loc_cCodEmp)
825:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
826:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EmpInit") > 0
827:                 SELECT cursor_4c_EmpInit
828:                 loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
829:             ENDIF
830:             IF USED("cursor_4c_EmpInit")
831:                 USE IN cursor_4c_EmpInit
832:             ENDIF
833:         ENDIF
834: 
835:         loc_oPag.txt_4c_CdGrupo.Value     = ""
836:         loc_oPag.txt_4c_DsGrupo.Value     = ""
837:         loc_oPag.txt_4c_CdMoeda.Value     = ""
838:         loc_oPag.txt_4c_DsMoeda.Value     = ""
839:         loc_oPag.txt_4c_CdGrupoCalc.Value = ""
840:         loc_oPag.txt_4c_DsGrupoCalc.Value = ""
841:         loc_oPag.txt_4c_DataSaldo.Value   = {}
842: 

*-- Linhas 1034 a 1052:
1034:                 "es da grade?", "Confirmar")
1035:             RETURN
1036:         ENDIF
1037:         SELECT Selecao
1038:         REPLACE ALL marcas WITH 0
1039:         GO TOP
1040:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1041:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1042:         ENDIF
1043:     ENDPROC
1044: 
1045:     *==========================================================================
1046:     * HANDLERS: OptionGroups
1047:     *==========================================================================
1048: 
1049:     *--------------------------------------------------------------------------
1050:     * OptRfestoqueClick - Habilita/desabilita campo Data Saldo
1051:     *--------------------------------------------------------------------------
1052:     PROCEDURE OptRfestoqueClick()

*-- Linhas 1166 a 1254:
1166:             RETURN
1167:         ENDIF
1168: 
1169:         SELECT Selecao
1170: 
1171:         IF Selecao.marcas = 1 AND EMPTY(ALLTRIM(Selecao.contas))
1172:             loc_cGrupo = Selecao.grupos
1173:             SCAN WHILE Selecao.grupos = loc_cGrupo
1174:                 REPLACE Selecao.marcas WITH 1
1175:                 loc_lGrupo = .T.
1176:             ENDSCAN
1177:         ENDIF
1178: 
1179:         IF loc_lGrupo AND !EMPTY(loc_cGrupo)
1180:             SELECT Selecao
1181:             GO TOP
1182:             LOCATE FOR Selecao.grupos = loc_cGrupo AND EMPTY(ALLTRIM(Selecao.contas))
1183:             IF !EOF("Selecao")
1184:                 REPLACE Selecao.marcas WITH 0
1185:             ENDIF
1186:         ENDIF
1187: 
1188:         SELECT Selecao
1189:         GO TOP
1190:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * CmdApagaClick - Desmarca todas as selecoes da grade
1195:     *--------------------------------------------------------------------------
1196:     PROCEDURE CmdApagaClick()
1197:         IF !USED("Selecao")
1198:             RETURN
1199:         ENDIF
1200:         SELECT Selecao
1201:         REPLACE ALL marcas WITH 0
1202:         GO TOP
1203:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1204:     ENDPROC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * CmdSelTudoClick - Marca todas as contas (nao os cabecalhos de grupo)
1208:     *   Logica original: para cada conta filha marcada, o cabecalho de grupo
1209:     *   correspondente e desmarcado (somente contas entram no relatorio)
1210:     *--------------------------------------------------------------------------
1211:     PROCEDURE CmdSelTudoClick()
1212:         LOCAL loc_cGrpSel, loc_cCntSel
1213:         IF !USED("Selecao")
1214:             RETURN
1215:         ENDIF
1216: 
1217:         SELECT Selecao
1218:         GO TOP
1219:         DO WHILE !EOF("Selecao")
1220:             REPLACE Selecao.marcas WITH 1
1221:             loc_cGrpSel = Selecao.grupos
1222:             loc_cCntSel = Selecao.contas
1223: 
1224:             IF !EMPTY(ALLTRIM(loc_cCntSel))
1225:                 SELECT Selecao
1226:                 GO TOP
1227:                 LOCATE FOR Selecao.grupos = loc_cGrpSel AND EMPTY(ALLTRIM(Selecao.contas))
1228:                 IF !EOF("Selecao")
1229:                     REPLACE Selecao.marcas WITH 0
1230:                 ENDIF
1231:             ENDIF
1232: 
1233:             SELECT Selecao
1234:             GO TOP
1235:             LOCATE FOR Selecao.grupos = loc_cGrpSel AND Selecao.contas = loc_cCntSel
1236:             SKIP
1237:         ENDDO
1238: 
1239:         SELECT Selecao
1240:         GO TOP
1241:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * GradeRedirecionarFoco - Redireciona foco da Column3 de volta para Column1
1246:     *--------------------------------------------------------------------------
1247:     PROCEDURE GradeRedirecionarFoco()
1248:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1249:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.SetFocus()
1250:         ENDIF
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * METODOS PROTEGIDOS: ajuste de visibilidade

*-- Linhas 1306 a 1409:
1306:             loc_oPag.txt_4c_DsEmpresa.Value = ""
1307:             RETURN
1308:         ENDIF
1309:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
1310:                    EscaparSQL(loc_cCod)
1311:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1312:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EmpVal") > 0
1313:             SELECT cursor_4c_EmpVal
1314:             loc_oPag.txt_4c_CdEmpresa.Value = ALLTRIM(cemps)
1315:             loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
1316:         ELSE
1317:             loc_oPag.txt_4c_DsEmpresa.Value = ""
1318:             THIS.AbrirBuscaEmpresa()
1319:         ENDIF
1320:         IF USED("cursor_4c_EmpVal")
1321:             USE IN cursor_4c_EmpVal
1322:         ENDIF
1323:     ENDPROC
1324: 
1325:     *--------------------------------------------------------------------------
1326:     * ValidarCdGrupo - Valida codigo de grupo de produto e preenche descricao
1327:     *--------------------------------------------------------------------------
1328:     PROTECTED PROCEDURE ValidarCdGrupo()
1329:         LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
1330:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1331:         loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
1332:         IF EMPTY(loc_cCod)
1333:             loc_oPag.txt_4c_DsGrupo.Value = ""
1334:             RETURN
1335:         ENDIF
1336:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + ;
1337:                    EscaparSQL(loc_cCod)
1338:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
1339:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruVal") > 0
1340:             SELECT cursor_4c_GruVal
1341:             loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cgrus)
1342:             loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(dgrus)
1343:         ELSE
1344:             loc_oPag.txt_4c_DsGrupo.Value = ""
1345:             THIS.AbrirBuscaGrupo("cgrus")
1346:         ENDIF
1347:         IF USED("cursor_4c_GruVal")
1348:             USE IN cursor_4c_GruVal
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *--------------------------------------------------------------------------
1353:     * ValidarCdMoeda - Valida codigo de moeda e preenche descricao
1354:     *--------------------------------------------------------------------------
1355:     PROTECTED PROCEDURE ValidarCdMoeda()
1356:         LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
1357:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1358:         loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
1359:         IF EMPTY(loc_cCod)
1360:             loc_oPag.txt_4c_DsMoeda.Value = ""
1361:             RETURN
1362:         ENDIF
1363:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + ;
1364:                    EscaparSQL(loc_cCod)
1365:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1366:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeVal") > 0
1367:             SELECT cursor_4c_MoeVal
1368:             loc_oPag.txt_4c_CdMoeda.Value = ALLTRIM(cmoes)
1369:             loc_oPag.txt_4c_DsMoeda.Value = ALLTRIM(dmoes)
1370:         ELSE
1371:             loc_oPag.txt_4c_DsMoeda.Value = ""
1372:             THIS.AbrirBuscaMoeda("cmoes")
1373:         ENDIF
1374:         IF USED("cursor_4c_MoeVal")
1375:             USE IN cursor_4c_MoeVal
1376:         ENDIF
1377:     ENDPROC
1378: 
1379:     *--------------------------------------------------------------------------
1380:     * ValidarCdGrupoCalc - Valida codigo de grupo de calculo e preenche descricao
1381:     *--------------------------------------------------------------------------
1382:     PROTECTED PROCEDURE ValidarCdGrupoCalc()
1383:         LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
1384:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1385:         loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value)
1386:         IF EMPTY(loc_cCod)
1387:             loc_oPag.txt_4c_DsGrupoCalc.Value = ""
1388:             RETURN
1389:         ENDIF
1390:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + ;
1391:                    EscaparSQL(loc_cCod)
1392:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrcVal")
1393:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GrcVal") > 0
1394:             SELECT cursor_4c_GrcVal
1395:             loc_oPag.txt_4c_CdGrupoCalc.Value = ALLTRIM(cgrus)
1396:             loc_oPag.txt_4c_DsGrupoCalc.Value = ALLTRIM(dgrus)
1397:         ELSE
1398:             loc_oPag.txt_4c_DsGrupoCalc.Value = ""
1399:             THIS.AbrirBuscaGrupoCalc("cgrus")
1400:         ENDIF
1401:         IF USED("cursor_4c_GrcVal")
1402:             USE IN cursor_4c_GrcVal
1403:         ENDIF
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * METODOS PROTEGIDOS: lookups via FormBuscaAuxiliar
1408:     *==========================================================================
1409: 


### BO (C:\4c\projeto\app\classes\SIGREEQRBO.prg):
*==============================================================================
* SIGREEQRBO.PRG
* Business Object para Relatorio de Posicao de Estoque Retroativo
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS SIGREEQRBO AS RelatorioBase

    *-- Filtros: Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: Grupo de Produto
    this_cCdGrupo       = ""
    this_cDsGrupo       = ""

    *-- Filtros: Data de Saldo (usada quando this_nRfEstoque = 2)
    this_dDataSaldo     = {}

    *-- Filtros: Moeda para Conversao
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: Grupo de Calculo de Custo (visivel quando this_nCalcusto = 2)
    this_cCdGrupoCalc   = ""
    this_cDsGrupoCalc   = ""

    *-- Opcao de referencia de estoque: 1=Atual, 2=em data especifica
    this_nRfEstoque     = 1

    *-- Opcao de calculo de custo: 1=Total, 2=por Grupo
    this_nCalcusto      = 1

    *-- Nomes dos cursores de resultado produzidos pelo processamento
    this_cCursorGrupos      = "csTempoGr"
    this_cCursorProdutos    = "CsTempoCp"
    this_cCursorCabecalho   = "dbCabecalho"
    this_cCursorSelecao     = "Selecao"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarSelecao - Cria cursor Selecao com grupos/contas de estoque
    * Chamado pelo Form no Init para popular o grid de selecao interativa
    *--------------------------------------------------------------------------
    PROCEDURE InicializarSelecao()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                *-- Grupos de estoque ativos (estoques = 1)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos FROM SigCdGcr WHERE estoques = 1", ;
                    "TmpGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de estoque"
                    EXIT
                ENDIF

                *-- Clientes vinculados aos grupos de estoque
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT b.grupos, b.iclis" + ;
                    " FROM SigCdCli b INNER JOIN SigCdGcr c ON b.grupos = c.codigos" + ;
                    " WHERE c.internos = '                    '" + ;
                    " AND c.estoques = 1", ;
                    "TmpCliGccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes por grupo"
                    EXIT
                ENDIF

                *-- Combina grupos (linhas pai) e contas (linhas filhas) em Selecao
                IF USED("Selecao")
                    USE IN Selecao
                ENDIF

                SELECT 0 AS marcas, codigos AS grupos, SPACE(10) AS contas ;
                    FROM TmpGccr ;
                UNION ALL ;
                SELECT 0 AS marcas, grupos, iclis AS contas ;
                    FROM TmpCliGccr ;
                INTO CURSOR Selecao READWRITE

                IF !USED("Selecao")
                    CREATE CURSOR Selecao (marcas n(1), grupos c(10), contas c(10))
                ENDIF

                SELECT Selecao
                GO TOP
                INDEX ON grupos + contas TAG grucon

                IF USED("TmpGccr")
                    USE IN TmpGccr
                ENDIF
                IF USED("TmpCliGccr")
                    USE IN TmpCliGccr
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de posicao de estoque retroativo
    * Usa: cursor Selecao (populado e marcado pelo usuario no form)
    * Produz: cursors csTempoGr, CsTempoCp, dbCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cCdEmpresa, loc_cCdGrupo, loc_nImpCusto, loc_nRfEstoque
        LOCAL loc_dDataSaldo, loc_cMoeda, loc_cGrpCalc
        LOCAL loc_cDatas, loc_dDataConv
        LOCAL loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa
        LOCAL loc_lcCpro, loc_mValGr
        LOCAL loc_cAno, loc_cMes, loc_cDia

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
                loc_cCdGrupo   = ALLTRIM(THIS.this_cCdGrupo)
                loc_nImpCusto  = THIS.this_nCalcusto
                loc_nRfEstoque = THIS.this_nRfEstoque
                loc_dDataSaldo = THIS.this_dDataSaldo
                loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
                loc_cGrpCalc   = ALLTRIM(THIS.this_cCdGrupoCalc)

                *-- Formata data para SQL Server: YYYY-MM-DD HH:MM:SS
                IF EMPTY(loc_dDataSaldo)
                    loc_dDataSaldo = DATE()
                ENDIF
                loc_dDataSaldo = MAX(loc_dDataSaldo, CTOD("01/01/1900"))
                loc_cAno   = PADL(TRANSFORM(YEAR(loc_dDataSaldo)),  4, "0")
                loc_cMes   = PADL(TRANSFORM(MONTH(loc_dDataSaldo)), 2, "0")
                loc_cDia   = PADL(TRANSFORM(DAY(loc_dDataSaldo)),   2, "0")
                loc_cDatas = loc_cAno + "-" + loc_cMes + "-" + loc_cDia + " 23:59:59"

                *-- Cursor de cabecalho para o relatorio
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
                loc_cCbEmpresa = ALLTRIM(THIS.this_cDsEmpresa)
                loc_cCbTitulo  = "Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo " + ;
                    IIF(loc_nRfEstoque = 1, "Atual", "em " + DTOC(loc_dDataSaldo))
                loc_cCbGrupo   = "Grupo p/Calculo de Custo : " + ;
                    IIF(EMPTY(loc_cGrpCalc), "Geral", loc_cGrpCalc) + ;
                    "  Grupo de Produto: " + ;
                    IIF(EMPTY(loc_cCdGrupo), "Geral", ;
                        loc_cCdGrupo + " - " + ALLTRIM(THIS.this_cDsGrupo))
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                    VALUES (loc_cCbTitulo, loc_cCbGrupo, loc_cCbEmpresa)

                *-- Cursor de agrupamentos (totais por grupo/conta/linha)
                IF USED("csTempoGr")
                    USE IN csTempoGr
                ENDIF
                CREATE CURSOR csTempoGr ( ;
                    grupos c(10), contas c(10), linhas c(10), ;
                    tpesos n(12,2), tqtds n(12,3), vlvenda n(12,2), ;
                    moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), Quebra c(1))
                INDEX ON tipos + grupos + contas + Quebra + linhas + ;
                    moevenda + moecusto TAG Imprimir

                *-- Cursor de produtos (detalhe por produto)
                IF USED("CsTempoCp")
                    USE IN CsTempoCp
                ENDIF
                CREATE CURSOR CsTempoCp ( ;
                    cpros c(14), dpros c(40), tpesos n(12,2), tqtds n(12,3), ;
                    vlvenda n(12,2), moevenda c(3), vlcusto n(12,2), moecusto c(3), ;
                    tipos c(1), grupos c(10), contas c(10), linhas c(10), Quebra c(1))
                INDEX ON Tipos + grupos + contas + Quebra + linhas + cpros TAG Imprimir
                INDEX ON Grupos + Contas + Linhas + Cpros TAG visualizar

                *-- Busca movimentacoes conforme modo: estoque atual ou retroativo
                IF loc_nRfEstoque = 1
                    *-- Estoque atual: saldo corrente em SigMvEst
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.cpros, a.emps, a.grupos, a.estos," + ;
                        " a.sqtds, a.sqtds AS qtds, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, d.tpcustos, d.tpvendas" + ;
                        " FROM SigMvEst a" + ;
                        " INNER JOIN SigCdPro c ON a.cpros = c.cpros" + ;
                        " INNER JOIN SigCdLin d ON c.Linhas = d.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.sqtds <> 0" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), "") + ;
                        " ORDER BY a.cpros, a.emps, a.grupos, a.estos", ;
                        "CsTmpEst")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar estoque atual"
                        EXIT
                    ENDIF
                    loc_dDataConv = DATE()
                ELSE
                    *-- Estoque retroativo: historico SigMvHst ate a data informada
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT a.emps, a.grupos, a.estos, a.cpros," + ;
                        " a.qtds, a.opers, c.Dpros, c.Linhas," + ;
                        " c.custofs, c.pvens, c.fvendas, c.moepvs," + ;
                        " c.pesoms, c.moecusfs, c.moevs, f.tpcustos, f.tpvendas" + ;
                        " FROM SigMvHst a" + ;
                        " LEFT JOIN SigCdPro c ON a.cpros = c.Cpros" + ;
                        " LEFT JOIN SigCdLin f ON c.Linhas = f.Linhas" + ;
                        " WHERE a.emps = " + EscaparSQL(loc_cCdEmpresa) + ;
                        " AND a.datas <= '" + loc_cDatas + "'" + ;
                        IIF(!EMPTY(loc_cCdGrupo), ;
                            " AND c.cgrus = " + EscaparSQL(loc_cCdGrupo), ""), ;
                        "TmpEstPro")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar historico de estoque"
                        EXIT
                    ENDIF

                    *-- Calcula saldo: soma entradas (E=+1) e saidas (S=-1)
                    SELECT emps, grupos, estos, cpros, ;
                        SUM(qtds * IIF(opers = "E", 1, -1)) AS qtds, ;
                        Dpros, Linhas, custofs, pvens, fvendas, moepvs, ;
                        pesoms, moecusfs, moevs, tpcustos, tpvendas ;
                    FROM TmpEstPro ;
                    GROUP BY emps, grupos, estos, cpros, Dpros, Linhas, ;
                        custofs, pvens, fvendas, moepvs, pesoms, ;
                        moecusfs, moevs, tpcustos, tpvendas ;
                    HAVING SUM(qtds * IIF(opers = "E", 1, -1)) <> 0 ;
                    INTO CURSOR CsTmpEst

                    IF USED("TmpEstPro")
                        USE IN TmpEstPro
                    ENDIF
                    loc_dDataConv = loc_dDataSaldo
                ENDIF

                *-- Filtra pelos grupos/contas marcados no grid Selecao
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF
                SELECT DISTINCT ;
                    a.cpros, a.emps, a.grupos, a.estos, a.qtds, ;
                    a.Dpros, a.Linhas, a.custofs, a.pvens, a.fvendas, ;
                    a.moepvs, a.pesoms, a.moecusfs, a.moevs, ;
                    a.tpcustos, a.tpvendas ;
                FROM CsTmpEst a, Selecao b ;
                WHERE a.grupos = b.grupos ;
                    AND IIF(!EMPTY(b.contas), a.estos = b.contas, .T.) ;
                    AND b.marcas = 1 ;
                INTO CURSOR TmpEst ;
                ORDER BY a.cpros

                IF USED("CsTmpEst")
                    USE IN CsTmpEst
                ENDIF

                *-- Processa produtos: calcula custos, converte moeda, acumula por grupo
                SELECT TmpEst
                GO TOP
                loc_lcCpro = SPACE(14)

                SCAN
                    SCATTER MEMVAR
                    m.vlCusto  = m.custofs
                    m.vlvenda  = ROUND(m.pvens * ;
                        IIF(m.fvendas <> 0 .AND. !EMPTY(m.moepvs), m.fvendas, 1), 2)
                    m.moecusto = m.moecusfs
                    m.moevenda = m.moevs
                    m.tqtds    = m.qtds
                    m.tpesos   = m.pesoms * m.qtds
                    m.contas   = m.estos
                    m.tipos    = " "
                    m.Quebra   = " "

                    IF m.tpcustos = "2"
                        m.vlCusto = m.pesoms * m.vlCusto
                    ENDIF
                    IF m.tpvendas = "2"
                        m.vlvenda = m.pesoms * m.vlvenda
                    ENDIF

                    *-- Custo por composicao (quando opt_calcusto = 2 = por grupo)
                    IF loc_nImpCusto = 2
                        IF m.cpros <> loc_lcCpro
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT cpros, cgrus, pcompos, qtds, moeds" + ;
                                " FROM SigPrCpo" + ;
                                " WHERE cpros = " + EscaparSQL(m.cpros) + ;
                                " AND cgrus = " + EscaparSQL(loc_cGrpCalc), ;
                                "CrSigPrCpo")
                        ENDIF
                        IF loc_nResult >= 0
                            loc_mValGr = 0
                            SELECT CrSigPrCpo
                            SCAN
                                loc_mValGr = loc_mValGr + ;
                                    ((CrSigPrCpo.pcompos * CrSigPrCpo.qtds) * ;
                                    fBuscarCotacao(CrSigPrCpo.moeds, loc_dDataConv, gnConnHandle) / ;
                                    fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle))
                            ENDSCAN
                            m.vlcusto = loc_mValGr
                            IF USED("CrSigPrCpo")
                                USE IN CrSigPrCpo
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Converte valores para moeda solicitada (quando informada)
                    IF !EMPTY(loc_cMoeda)
                        m.vlcusto  = m.vlcusto * ;
                            fBuscarCotacao(m.moecusto, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.vlvenda  = m.vlvenda * ;
                            fBuscarCotacao(m.moevenda, loc_dDataConv, gnConnHandle) / ;
                            fBuscarCotacao(loc_cMoeda,  loc_dDataConv, gnConnHandle)
                        m.moecusto = loc_cMoeda
                        m.moevenda = loc_cMoeda
                    ENDIF

                    m.vlvenda = m.vlvenda * m.qtds
                    m.vlcusto = m.vlcusto * m.qtds

                    *-- Registra detalhe do produto em CsTempoCp
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- Acumula totais por grupo em csTempoGr (usa index Imprimir)
                    SELECT csTempoGr
                    IF !SEEK(" " + m.grupos + m.contas + " " + m.linhas + ;
                            m.moevenda + m.moecusto)
                        APPEND BLANK
                        GATHER MEMVAR
                        REPLACE csTempoGr.tqtds   WITH 0
                        REPLACE csTempoGr.tpesos  WITH 0
                        REPLACE csTempoGr.vlvenda WITH 0
                        REPLACE csTempoGr.vlCusto WITH 0
                    ENDIF
                    REPLACE csTempoGr.tqtds   WITH csTempoGr.tqtds   + m.tqtds
                    REPLACE csTempoGr.tpesos  WITH csTempoGr.tpesos  + m.tpesos
                    REPLACE csTempoGr.vlVenda WITH csTempoGr.vlVenda + m.vlvenda
                    REPLACE csTempoGr.vlcusto WITH csTempoGr.vlcusto + m.vlcusto

                    IF m.cpros <> loc_lcCpro
                        loc_lcCpro = m.cpros
                    ENDIF
                    SELECT TmpEst
                ENDSCAN

                *-- Calcula totais: por linha (tipo 5), geral (tipo 6), subtotal por grupo
                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                SELECT "5" AS tipos, PADR("Tot Linha", 10) AS grupos, ;
                    SPACE(10) AS contas, linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 4, 8, 10 ;
                UNION ALL ;
                SELECT "6" AS tipos, PADR("Tot Geral", 10) AS grupos, ;
                    SPACE(10) AS contas, SPACE(10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, " " AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 8, 10 ;
                UNION ALL ;
                SELECT " " AS tipos, grupos, contas, PADR("Total", 10) AS linhas, ;
                    SUM(tpesos) AS tpesos, SUM(tqtds) AS tqtds, ;
                    SUM(vlvenda) AS vlvenda, moevenda, ;
                    SUM(vlcusto) AS vlcusto, moecusto, ;
                    SPACE(14) AS Cpros, SPACE(40) AS Dpros, "1" AS Quebra ;
                    FROM csTempoGr GROUP BY 1, 2, 3, 8, 10 ;
                INTO CURSOR Tempo

                *-- Linha separadora no cursor de grupos
                SELECT csTempoGr
                APPEND BLANK
                REPLACE csTempoGr.Tipos    WITH "2"
                REPLACE csTempoGr.Grupos   WITH "----------"
                REPLACE csTempoGr.Contas   WITH "----------"
                REPLACE csTempoGr.Linhas   WITH "----------"
                REPLACE csTempoGr.moevenda WITH "---"
                REPLACE csTempoGr.moecusto WITH "---"

                *-- Mescla totais calculados nos cursores de saida
                SELECT Tempo
                SCAN
                    SCATTER MEMVAR
                    SELECT csTempoGr
                    APPEND BLANK
                    GATHER MEMVAR
                    SELECT CsTempoCp
                    APPEND BLANK
                    GATHER MEMVAR
                ENDSCAN

                IF USED("Tempo")
                    USE IN Tempo
                ENDIF
                IF USED("TmpEst")
                    USE IN TmpEst
                ENDIF

                SELECT csTempoGr
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                REPORT FORM (gc_4c_CaminhoReports + "SigReEqr") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Retorna identificador composto dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cData
        loc_cData = IIF(EMPTY(THIS.this_dDataSaldo), "", DTOC(THIS.this_dDataSaldo))
        loc_cChave = "EMP=" + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";GRU=" + ALLTRIM(THIS.this_cCdGrupo) + ;
                     ";RFE=" + TRANSFORM(THIS.this_nRfEstoque) + ;
                     ";DTS=" + loc_cData + ;
                     ";MOE=" + ALLTRIM(THIS.this_cCdMoeda) + ;
                     ";CUS=" + TRANSFORM(THIS.this_nCalcusto) + ;
                     ";GCC=" + ALLTRIM(THIS.this_cCdGrupoCalc)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Permite restaurar parametros previamente salvos para reexecucao
    * par_cAliasCursor: cursor com colunas no formato preset
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + ;
                                          CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                    loc_lSucesso = .F.
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.cCdGrupo") = "C"
                        THIS.this_cCdGrupo = ALLTRIM(m.cCdGrupo)
                    ENDIF
                    IF TYPE("m.cDsGrupo") = "C"
                        THIS.this_cDsGrupo = ALLTRIM(m.cDsGrupo)
                    ENDIF
                    IF TYPE("m.dDataSaldo") = "D"
                        THIS.this_dDataSaldo = m.dDataSaldo
                    ENDIF
                    IF TYPE("m.cCdMoeda") = "C"
                        THIS.this_cCdMoeda = ALLTRIM(m.cCdMoeda)
                    ENDIF
                    IF TYPE("m.cDsMoeda") = "C"
                        THIS.this_cDsMoeda = ALLTRIM(m.cDsMoeda)
                    ENDIF
                    IF TYPE("m.cCdGrupoCalc") = "C"
                        THIS.this_cCdGrupoCalc = ALLTRIM(m.cCdGrupoCalc)
                    ENDIF
                    IF TYPE("m.cDsGrupoCalc") = "C"
                        THIS.this_cDsGrupoCalc = ALLTRIM(m.cDsGrupoCalc)
                    ENDIF
                    IF TYPE("m.nRfEstoque") = "N"
                        THIS.this_nRfEstoque = m.nRfEstoque
                    ENDIF
                    IF TYPE("m.nCalcusto") = "N"
                        THIS.this_nCalcusto = m.nCalcusto
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
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
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
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        loc_lValido = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida."
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nCalcusto = 2 .AND. ;
               EMPTY(ALLTRIM(THIS.this_cCdGrupoCalc))
                THIS.this_cMensagemErro = "Grupo de C" + CHR(225) + "lculo Obrigat" + ;
                                          CHR(243) + "rio"
                loc_lValido = .F.
            ENDIF
            IF loc_lValido .AND. THIS.this_nRfEstoque = 2 .AND. ;
               EMPTY(THIS.this_dDataSaldo)
                THIS.this_cMensagemErro = "Data do Saldo obrigat" + CHR(243) + ;
                                          "ria para estoque retroativo"
                loc_lValido = .F.
            ENDIF

            IF loc_lValido
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
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
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
                       EscaparSQL("SigReEqr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("Selecao")
            USE IN Selecao
        ENDIF
        IF USED("csTempoGr")
            USE IN csTempoGr
        ENDIF
        IF USED("CsTempoCp")
            USE IN CsTempoCp
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("TmpGccr")
            USE IN TmpGccr
        ENDIF
        IF USED("TmpCliGccr")
            USE IN TmpCliGccr
        ENDIF
        IF USED("CsTmpEst")
            USE IN CsTmpEst
        ENDIF
        IF USED("TmpEstPro")
            USE IN TmpEstPro
        ENDIF
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        IF USED("Tempo")
            USE IN Tempo
        ENDIF
        IF USED("CrSigPrCpo")
            USE IN CrSigPrCpo
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

