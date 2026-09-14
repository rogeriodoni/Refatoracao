CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1874: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~1874: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.CImps)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg):

--- Linhas 1855 a 1895 ---
1855:                 SELECT cursor_4c_SigCdPac
1856:                 GO TOP
1857:                 THIS.this_nAjDenss = IIF(cursor_4c_SigCdPac.AjDens < 10, 10, cursor_4c_SigCdPac.AjDens)
1858:                 THIS.this_nAjVelos = IIF(cursor_4c_SigCdPac.AjVelos < 1, 1, cursor_4c_SigCdPac.AjVelos)
1859:             ENDIF
1860:             IF USED("cursor_4c_SigCdPac")
1861:                 USE IN cursor_4c_SigCdPac
1862:             ENDIF
1863: 
1864:             *-- Lista de impressoras Windows (APRINTERS retorna array 2D: nome, porta)
1865:             loc_nPrinters = APRINTERS(loc_laPrinters)
1866:             IF loc_nPrinters > 0
1867:                 FOR loc_nI = 1 TO loc_nPrinters
1868:                     loc_laPrinters(loc_nI, 1) = UPPER(loc_laPrinters(loc_nI, 1))
1869:                 ENDFOR
1870:                 =ASORT(loc_laPrinters)
1871:             ENDIF
1872: 
1873:             *-- Impressoras termicas autorizadas para o usuario (SigSyImp+SigCdmp)
1874:             loc_cSQL = "SELECT b.Impres" + ;
1875:                        " FROM SigSyImp a, SigCdmp b" + ;
1876:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1877:                        " AND a.CImps = b.Impres AND b.nTpImpres = 2" + ;
1878:                        " UNION ALL" + ;
1879:                        " SELECT c.Impres" + ;
1880:                        " FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
1881:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1882:                        " AND a.Grupos = b.GrAcess" + ;
1883:                        " AND b.CImps = c.Impres AND c.nTpImpres = 2"
1884: 
1885:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCImp")
1886:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TmpCImp") > 0
1887:                 SELECT DISTINCT Impres FROM cursor_4c_TmpCImp ;
1888:                     ORDER BY Impres ;
1889:                     INTO CURSOR cursor_4c_SigCdmp READWRITE
1890:             ELSE
1891:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1892:                     "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres", ;
1893:                     "cursor_4c_SigCdmp")
1894:             ENDIF
1895:             IF USED("cursor_4c_TmpCImp")



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigreipeBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg
- BO: C:\4c\projeto\app\classes\sigreipeBO.prg
