CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~789: Tabela 'vindsql' NAO EXISTE no banco. Verificar nome correto no schema.sql ou codigo original.


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
788:             *-- Obter chaves primarias dos arquivos via vindsql (view legada)
789:             loc_cSql = "SELECT UPPER(Arquivos) AS Arquivos, Indices FROM vindsql WHERE nprimarys = 1"
790:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ChavePrim") > 0
791:                 SELECT cursor_4c_ChavePrim
792:                 INDEX ON UPPER(ALLTRIM(Arquivos)) TAG Arquivos
793:             ENDIF
794: 
795:             THIS.AlternarPagina(.T.)
796: 
797:             loc_nRec = 0
798:             SELECT csContas
799:             loc_nCnt = RECCOUNT("csContas") * loc_nTtArq
800:             IF loc_nCnt < 1
801:                 loc_nCnt = 1
802:             ENDIF
803: 
804:             THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
805:             THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = 0
806: 
807:             SELECT csContas
808:             SCAN
809:                 THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(NVL(csContas.CprosAnt, ""))
810:                 THIS.cnt_4c_Result.Refresh



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
