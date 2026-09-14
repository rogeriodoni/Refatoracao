CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1517: Tabela 'sys' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormRPT.prg):

--- Linhas 1498 a 1538 ---
1498: 
1499:         TRY
1500:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "pgf_4c_Dados", 5) AND ;
1501:                PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1, "obj_4c_OleRTF_SqlCMD", 5)
1502: 
1503:                 loc_oSubPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1504:                 loc_cTabela = ALLTRIM(loc_oSubPg1.obj_4c_OleRTF_SqlCMD.OBJECT.SelText)
1505: 
1506:                 IF EMPTY(loc_cTabela)
1507:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1508:                     MsgAviso("Selecione o nome da tabela no editor SQL.")
1509:                 ELSE
1510:                     IF GETWORDCOUNT(loc_cTabela) > 1
1511:                     loc_oSubPg1.obj_4c_OleRTF_SqlCMD.SetFocus()
1512:                     MsgAviso("Selecione apenas o nome da tabela (sem espa" + CHR(231) + "os).")
1513:                 ELSE
1514:                     IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1515:                     MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.")
1516:                 ELSE
1517:                     loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, " + ;
1518:                         "c.Max_Length, " + ;
1519:                         "CASE WHEN c.Precision>0 THEN CAST(c.Precision AS CHAR(3)) ELSE '' END AS Precision, " + ;
1520:                         "CASE WHEN c.Scale>0 THEN CAST(c.Scale AS CHAR(3)) ELSE '' END AS Scale, " + ;
1521:                         "CASE WHEN c.Is_Nullable=1 THEN 'yes' ELSE 'no' END AS Is_Nullable " + ;
1522:                         "FROM sys.all_Columns c " + ;
1523:                         "JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID " + ;
1524:                         "WHERE object_id = object_id(" + EscaparSQL(loc_cTabela) + ") " + ;
1525:                         "ORDER BY c.Column_ID"
1526: 
1527:                     loc_oGrid = loc_oSubPg1.grd_4c_Resultado
1528:                     loc_oGrid.RecordSource = ""
1529:                     IF USED("cursor_4c_ResultadoTemp")
1530:                         USE IN cursor_4c_ResultadoTemp
1531:                     ENDIF
1532:                     IF USED("cursor_4c_Resultado")
1533:                         USE IN cursor_4c_Resultado
1534:                     ENDIF
1535: 
1536:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResultadoTemp")
1537: 
1538:                     IF loc_nRes >= 0 AND USED("cursor_4c_ResultadoTemp")



## Trechos relevantes do BO (C:\4c\projeto\app\classes\RPTBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormRPT.prg
- BO: C:\4c\projeto\app\classes\RPTBO.prg
