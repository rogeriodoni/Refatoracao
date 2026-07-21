CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~789: Tabela 'sys' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg):

--- Linhas 770 a 810 ---
770:                     UPPER(Tipos) = "C" AND ;
771:                     ALLTRIM(Arquivos) <> "ARQDBF.DBF" AND ;
772:                     ALLTRIM(Arquivos) <> "SIGTEMPD.DBF" AND ;
773:                     ALLTRIM(Arquivos) <> "SIGTEMPC.DBF" AND ;
774:                     ALLTRIM(Arquivos) <> "SIGTEMPR.DBF" AND ;
775:                     !EMPTY(Dbcs) AND ;
776:                     INLIST(ALLTRIM(Campos), "CMATS","CODCONPADS","CODPDS","CODPROPADS", ;
777:                         "CPROS","PRODUTO","PRODUTOS","CPROEQS","MATPRINCS", ;
778:                         "MATS","MATSUBS","CODGARRAS","OUROS","BRILHANTES") ;
779:                 ORDER BY Arquivos ;
780:                 INTO CURSOR csCampos READWRITE
781:             INDEX ON Arquivos + Campos TAG ArqCpo
782: 
783:             SELECT DISTINCT Arquivos FROM csCampos ;
784:                 INTO CURSOR csArquivos READWRITE ;
785:                 ORDER BY Arquivos
786:             loc_nTtArq = RECCOUNT("csArquivos")
787: 
788:             *-- Obter chaves primarias via catalogo SQL Server (substitui view legada vindsql)
789:             loc_cSql = "SELECT UPPER(t.name) AS Arquivos, c.name AS Indices " + ;
790:                        "FROM sys.tables t " + ;
791:                        "JOIN sys.indexes i ON i.object_id = t.object_id AND i.is_primary_key = 1 " + ;
792:                        "JOIN sys.index_columns ic ON ic.object_id = i.object_id " + ;
793:                        "  AND ic.index_id = i.index_id AND ic.key_ordinal = 1 " + ;
794:                        "JOIN sys.columns c ON c.object_id = ic.object_id AND c.column_id = ic.column_id"
795:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ChavePrim") > 0
796:                 SELECT cursor_4c_ChavePrim
797:                 INDEX ON UPPER(ALLTRIM(Arquivos)) TAG Arquivos
798:             ENDIF
799: 
800:             THIS.AlternarPagina(.T.)
801: 
802:             loc_nRec = 0
803:             SELECT csContas
804:             loc_nCnt = RECCOUNT("csContas") * loc_nTtArq
805:             IF loc_nCnt < 1
806:                 loc_nCnt = 1
807:             ENDIF
808: 
809:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
810:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg
- BO: C:\4c\projeto\app\classes\sigprmdpBO.prg
