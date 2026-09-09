# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPNFS, EMPCODS, SERIES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ATIVAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPNFS, EMPCODS, SERIES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPNFS, EMPCODS, SERIES

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
  ControlSource = "crSigCdSer.cods"
  ControlSource = "crSigCdSer.descs"
  ControlSource = "crSigCdSer.tiponfs"
  ControlSource = "crSigCdSer.TpServicos"
  ControlSource = "crSigCdSer.impnfs"
  ControlSource = "crSigCdSer.mostecfs"
  ControlSource = "crSigCdSer.modelos"
  ControlSource = "crSigCdSer.ctiponfs"
  ControlSource = "crSigCdSer.Emps"
  ControlSource = "crSigCdSer.nnfobrigs"
  ControlSource = "crSigCdSer.inicials"
  ControlSource = "crSigCdSer.finals"
  ControlSource = "crSigCdSer.SeloTrans"
  ControlSource = "crSigCdSer.BlqInss"
Select CrSigCdSer
Select CrSigCdSer

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSre.prg) - TRECHOS RELEVANTES PARA PASS SQL (1944 linhas total):

*-- Linhas 362 a 380:
362:             .HighlightBackColor      = RGB(255, 255, 255)
363:             .HighlightForeColor      = RGB(15, 41, 104)
364:             .HighlightStyle          = 2
365:             .DeleteMark              = .F.
366:             .RecordMark              = .F.
367:             .RowHeight               = 16
368:             .ScrollBars              = 2
369:             .GridLines               = 3
370:             .ReadOnly                = .T.
371:             .Visible                 = .T.
372:             .Column1.Width           = 90
373:             .Column2.Width           = 140
374:             .Column3.Width           = 460
375:             .Column4.Width           = 170
376:             .Column1.ReadOnly        = .T.
377:             .Column2.ReadOnly        = .T.
378:             .Column3.ReadOnly        = .T.
379:             .Column4.ReadOnly        = .T.
380:             .Column1.Header1.Caption = "Emp"

*-- Linhas 1229 a 1251:
1229:             RETURN
1230:         ENDIF
1231: 
1232:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
1233:             " WHERE Cemps = " + EscaparSQL(loc_cCod) + " AND Ativas = 1"
1234: 
1235:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValid") >= 1 AND RECCOUNT("cursor_4c_EmpValid") > 0
1236:             SELECT cursor_4c_EmpValid
1237:             loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_EmpValid.Cemps)
1238:             loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpValid.Razas)
1239:             THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_EmpValid.Cemps)
1240:             THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_EmpValid.Razas)
1241:             IF USED("cursor_4c_EmpValid")
1242:                 USE IN cursor_4c_EmpValid
1243:             ENDIF
1244:         ELSE
1245:             IF USED("cursor_4c_EmpValid")
1246:                 USE IN cursor_4c_EmpValid
1247:             ENDIF
1248:             THIS.AbrirLookupEmpresa()
1249:         ENDIF
1250:     ENDPROC
1251: 

*-- Linhas 1274 a 1297:
1274:             RETURN
1275:         ENDIF
1276: 
1277:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp" + ;
1278:             " WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1279:             " AND Ativas = 1 ORDER BY Razas"
1280: 
1281:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DEmpValid") >= 1 AND RECCOUNT("cursor_4c_DEmpValid") > 0
1282:             SELECT cursor_4c_DEmpValid
1283:             loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
1284:             loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_DEmpValid.Razas)
1285:             THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_DEmpValid.Cemps)
1286:             THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_DEmpValid.Razas)
1287:             IF USED("cursor_4c_DEmpValid")
1288:                 USE IN cursor_4c_DEmpValid
1289:             ENDIF
1290:         ELSE
1291:             IF USED("cursor_4c_DEmpValid")
1292:                 USE IN cursor_4c_DEmpValid
1293:             ENDIF
1294:             THIS.AbrirLookupEmpresa()
1295:         ENDIF
1296:     ENDPROC
1297: 

*-- Linhas 1329 a 1347:
1329: 
1330:         IF loc_oBusca.this_lSelecionou
1331:             IF USED("cursor_4c_BuscaEmpresa")
1332:                 SELECT cursor_4c_BuscaEmpresa
1333:                 loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1334:                 loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1335:                 THIS.this_cUltimoEmpValidado  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
1336:                 THIS.this_cUltimoDEmpValidado = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
1337:             ENDIF
1338:         ELSE
1339:             loc_oPg2.txt_4c_Emps.Value    = ""
1340:             loc_oPg2.txt_4c_DEmps.Value   = ""
1341:             THIS.this_cUltimoEmpValidado  = ""
1342:             THIS.this_cUltimoDEmpValidado = ""
1343:         ENDIF
1344: 
1345:         IF USED("cursor_4c_BuscaEmpresa")
1346:             USE IN cursor_4c_BuscaEmpresa
1347:         ENDIF

*-- Linhas 1549 a 1567:
1549: 
1550:         TRY
1551:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1552:                 SELECT cursor_4c_Dados
1553:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1554:             ENDIF
1555: 
1556:             IF EMPTY(loc_cEmpCods)
1557:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1558:             ELSE
1559:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1560:                     THIS.LimparCampos()
1561:                     THIS.BOParaForm()
1562:                     THIS.this_cModoAtual = "VISUALIZAR"
1563:                     THIS.HabilitarCampos(.F.)
1564:                     THIS.AlternarPagina(2)
1565:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1566:                 ENDIF
1567:             ENDIF

*-- Linhas 1579 a 1597:
1579: 
1580:         TRY
1581:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1582:                 SELECT cursor_4c_Dados
1583:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1584:             ENDIF
1585: 
1586:             IF EMPTY(loc_cEmpCods)
1587:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1588:             ELSE
1589:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1590:                     THIS.this_oBusinessObject.EditarRegistro()
1591:                     THIS.LimparCampos()
1592:                     THIS.BOParaForm()
1593:                     THIS.this_cModoAtual = "ALTERAR"
1594:                     THIS.HabilitarCampos(.T.)
1595:                     THIS.AlternarPagina(2)
1596:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
1597:                 ENDIF

*-- Linhas 1611 a 1629:
1611: 
1612:         TRY
1613:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1614:                 SELECT cursor_4c_Dados
1615:                 loc_cEmpCods = ALLTRIM(cursor_4c_Dados.empcods)
1616:             ENDIF
1617: 
1618:             IF EMPTY(loc_cEmpCods)
1619:                 MsgAviso("Selecione um registro na lista.", "Aviso")
1620:             ELSE
1621:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpCods)
1622:                     THIS.LimparCampos()
1623:                     THIS.BOParaForm()
1624:                     THIS.this_cModoAtual = "EXCLUIR"
1625:                     THIS.HabilitarCampos(.F.)
1626:                     THIS.AlternarPagina(2)
1627:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1628:                 ENDIF
1629:             ENDIF

*-- Linhas 1713 a 1731:
1713:                 THIS.AlternarPagina(1)
1714: 
1715:                 IF USED("cursor_4c_Dados")
1716:                     SELECT cursor_4c_Dados
1717:                     IF !EMPTY(loc_cCodBusca)
1718:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.cods) = loc_cCodBusca
1719:                     ELSE
1720:                         IF !EMPTY(loc_cDescBusca)
1721:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descs)) = UPPER(loc_cDescBusca)
1722:                         ENDIF
1723:                     ENDIF
1724:                     IF !FOUND()
1725:                         GO TOP IN cursor_4c_Dados
1726:                     ENDIF
1727:                 ENDIF
1728:                 loc_lResultado = .T.
1729:             CATCH TO loException
1730:                 MsgErro(loException.Message, "FormSre.BtnSalvarClick")
1731:             ENDTRY

*-- Linhas 1849 a 1880:
1849:         TRY
1850:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1851:                 SET NULL ON
1852:                 CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
1853:                 SET NULL OFF
1854:                 loc_lResultado = .T.
1855:             ELSE
1856:                 IF THIS.this_oBusinessObject.Buscar("")
1857:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1858:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1859: 
1860:                         loc_oGrid.ColumnCount  = 4
1861:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1862:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
1863:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.cods"
1864:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descs"
1865:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ctiponfs"
1866: 
1867:                         loc_oGrid.Column1.Width = 90
1868:                         loc_oGrid.Column2.Width = 140
1869:                         loc_oGrid.Column3.Width = 460
1870:                         loc_oGrid.Column4.Width = 170
1871: 
1872:                         loc_oGrid.Column1.ReadOnly = .T.
1873:                         loc_oGrid.Column2.ReadOnly = .T.
1874:                         loc_oGrid.Column3.ReadOnly = .T.
1875:                         loc_oGrid.Column4.ReadOnly = .T.
1876: 
1877:                         loc_oGrid.Column1.Header1.Caption = "Emp"
1878:                         loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1879:                         loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1880:                         loc_oGrid.Column4.Header1.Caption = "Tipo N.F."


### BO (C:\4c\projeto\app\classes\SreBO.prg):
*====================================================================
* SreBO.prg
*
* Business Object para Cadastro de Serie de Nota Fiscal
* Tabela: SigCdSer
* Chave Primaria: EmpCods (char(6) = Emps + Cods)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SreBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSer)
    this_cEmpCods    = ""    && empcods  char(6) - PK (concatenacao de Emps + Cods)
    this_cEmps       = ""    && cemps     char(3) - Empresa (FK SigCdEmp.CEmps)
    this_cDEmps      = ""    && Descricao da empresa (SigCdEmp.Razas) - somente exibicao, nao persistido
    this_cCodigo     = ""    && cods     char(3) - Codigo da serie
    this_cDescricao  = ""    && descs    char(20) - Descricao da serie
    this_nImpnfs     = 0     && impnfs   numeric(1,0) - Imprime NF: 1=Sim 2=Nao 3=Eletronica
    this_nTiponfs    = 0     && tiponfs  numeric(1,0) - Tipo NF: 1=Automatico 2=Manual 3=AutomaticoSemAlteracao 4=Documento
    this_cModelos    = ""    && modelos  char(2) - Modelo da nota fiscal
    this_cCtiponfs   = ""    && ctiponfs char(5) - Tipo N.F. (codigo complementar)
    this_nMostecfs   = 0     && mostecfs numeric(1,0) - Mostra Dados ECF Fiscal: 1=Sim 2=Nao
    this_nTpservicos = 0     && tpservicos numeric(1,0) - Servicos: 1=Sim 2=Nao 3=SimComItens
    this_nNnfobrigs  = 0     && nnfobrigs numeric(1,0) - Numeracao de NF: 1=Opcional 2=Obrigatoria
    this_nBlqinss    = 0     && blqinss  numeric(1,0) - Bloquear NF Caso Exista Anterior Nao Impressa
    this_nSelotrans  = 0     && selotrans numeric(1,0) - Selo Transporte: 1=Sim 2=Nao
    this_cInicials   = ""    && inicials char(2) - Selo Transporte Inicial
    this_cFinals     = ""    && finals   char(2) - Selo Transporte Final
    this_cCoddisp    = ""    && coddisp  char(2) - Codigo dispositivo (nao editado neste formulario, mantido por fidelidade de schema)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSer"
            THIS.this_cCampoChave = "EmpCods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SreBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (EmpCods) para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpCods)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpCods    = TratarNulo(empcods,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cCodigo     = TratarNulo(cods,       "C")
                THIS.this_cDescricao  = TratarNulo(descs,      "C")
                THIS.this_nImpnfs     = TratarNulo(impnfs,     "N")
                THIS.this_nTiponfs    = TratarNulo(tiponfs,    "N")
                THIS.this_cModelos    = TratarNulo(modelos,    "C")
                THIS.this_cCtiponfs   = TratarNulo(ctiponfs,   "C")
                THIS.this_nMostecfs   = TratarNulo(mostecfs,   "N")
                THIS.this_nTpservicos = TratarNulo(tpservicos, "N")
                THIS.this_nNnfobrigs  = TratarNulo(nnfobrigs,  "N")
                THIS.this_nBlqinss    = TratarNulo(blqinss,    "N")
                THIS.this_nSelotrans  = TratarNulo(selotrans,  "N")
                THIS.this_cInicials   = TratarNulo(inicials,   "C")
                THIS.this_cFinals     = TratarNulo(finals,     "C")
                THIS.this_cCoddisp    = TratarNulo(coddisp,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar (reproduz Grupo_Salva.Click)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("S" + CHR(233) + "rie inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)
            IF THIS.VerificarChaveExistente(THIS.this_cEmpCods)
                MsgAviso("S" + CHR(233) + "rie j" + CHR(225) + " cadastrada.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCtiponfs))
            MsgAviso("Tipo Nota Fiscal.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarChaveExistente - Verifica se EmpCods ja existe (equivalente
    * a ChkRegister('SigCdSer','EmpCods',lcKey) do legado)
    *====================================================================
    PROCEDURE VerificarChaveExistente(par_cEmpCods)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdSer" + ;
                " WHERE empcods = " + EscaparSQL(par_cEmpCods)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEmpCods")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEmpCods")
                SELECT cursor_4c_ChkEmpCods
                loc_lExiste = (cursor_4c_ChkEmpCods.qtd > 0)
                USE IN cursor_4c_ChkEmpCods
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar chave:" + CHR(13) + loException.Message, "SreBO.VerificarChaveExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdSer
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmpCods = PADR(ALLTRIM(THIS.this_cEmps), 3) + PADR(ALLTRIM(THIS.this_cCodigo), 3)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSer (empcods, emps, cods, descs, impnfs,
                    tiponfs, modelos, ctiponfs, mostecfs, tpservicos,
                    nnfobrigs, blqinss, selotrans, inicials, finals, coddisp)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmpCods)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    <<EscaparSQL(THIS.this_cModelos)>>,
                    <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    <<EscaparSQL(THIS.this_cInicials)>>,
                    <<EscaparSQL(THIS.this_cFinals)>>,
                    <<EscaparSQL(THIS.this_cCoddisp)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdSer
    * OBS: empcods/emps/cods sao a chave e nao sao alterados no UPDATE
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSer
                SET descs      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    impnfs     = <<FormatarNumeroSQL(THIS.this_nImpnfs, 0)>>,
                    tiponfs    = <<FormatarNumeroSQL(THIS.this_nTiponfs, 0)>>,
                    modelos    = <<EscaparSQL(THIS.this_cModelos)>>,
                    ctiponfs   = <<EscaparSQL(THIS.this_cCtiponfs)>>,
                    mostecfs   = <<FormatarNumeroSQL(THIS.this_nMostecfs, 0)>>,
                    tpservicos = <<FormatarNumeroSQL(THIS.this_nTpservicos, 0)>>,
                    nnfobrigs  = <<FormatarNumeroSQL(THIS.this_nNnfobrigs, 0)>>,
                    blqinss    = <<FormatarNumeroSQL(THIS.this_nBlqinss, 0)>>,
                    selotrans  = <<FormatarNumeroSQL(THIS.this_nSelotrans, 0)>>,
                    inicials   = <<EscaparSQL(THIS.this_cInicials)>>,
                    finals     = <<EscaparSQL(THIS.this_cFinals)>>,
                    coddisp    = <<EscaparSQL(THIS.this_cCoddisp)>>
                WHERE empcods = <<EscaparSQL(THIS.this_cEmpCods)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdSer
    * Verifica uso em Notas Fiscais (SigMvNfi.series) antes de excluir
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se a serie esta sendo usada em Notas Fiscais
            loc_cSQL = "SELECT COUNT(*) AS nNreg1s FROM SigMvNfi" + ;
                " WHERE series = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNfi")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkNfi")
                    SELECT cursor_4c_ChkNfi
                    loc_nUso = NVL(cursor_4c_ChkNfi.nNreg1s, 0)
                    USE IN cursor_4c_ChkNfi
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o pode ser excluida pois est" + CHR(225) + " sendo usada em Notas Fiscais!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdSer WHERE empcods = " + EscaparSQL(THIS.this_cEmpCods)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com empcods, emps, cods, descs, ctiponfs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (empcods C(6), emps C(3), cods C(3), descs C(20), ctiponfs C(5))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT empcods, emps, cods, descs, ctiponfs FROM SigCdSer"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY empcods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (EmpCods)
    * par_cCodigo eh o EmpCods completo (Emps + Cods, 6 caracteres)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT empcods, emps, cods, descs, impnfs, tiponfs," + ;
                " modelos, ctiponfs, mostecfs, tpservicos, nnfobrigs," + ;
                " blqinss, selotrans, inicials, finals, coddisp" + ;
                " FROM SigCdSer WHERE empcods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("S" + CHR(233) + "rie n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar s" + CHR(233) + "rie:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SreBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarDescricaoEmpresa - Retorna Razas (SigCdEmp) para exibicao
    * (equivalente a CursorQuery('SigCdEmp','crSigCdEmp','Cemps',Cemps) do legado)
    *====================================================================
    PROCEDURE BuscarDescricaoEmpresa(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cEmps))
                loc_cSQL = "SELECT razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(par_cEmps)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Emp")
                    SELECT cursor_4c_Emp
                    IF RECCOUNT() > 0
                        loc_cDescricao = TratarNulo(razas, "C")
                    ENDIF
                    USE IN cursor_4c_Emp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar empresa:" + CHR(13) + loException.Message, "SreBO.BuscarDescricaoEmpresa")
        ENDTRY

        RETURN loc_cDescricao
    ENDPROC

ENDDEFINE

