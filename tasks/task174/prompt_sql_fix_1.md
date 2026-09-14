CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~1077: INSERT coluna 'datas' NAO EXISTE na tabela 'sigoplog'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigoplog
CREATE TABLE [dbo].[SigOpLog](
	[usuaredes] [char](20) NOT NULL,
	[datars] [datetime] NULL,
	[horas] [char](8) NOT NULL,
	[progs] [char](20) NOT NULL,
	[opers] [char](1) NOT NULL,
	[usuasis] [char](20) NOT NULL,
	[parametros] [char](10) NOT NULL,
	[transacaos] [char](100) NOT NULL,
	[cversaos] [char](70) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[copias] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SigOpLso]    Script Date: 08/12/2025 10:07:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg):

--- Linhas 1058 a 1098 ---
1058: 
1059:         CATCH TO loc_oErro
1060:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro EnviarEmail")
1061:             loc_lOk = .F.
1062:         ENDTRY
1063: 
1064:         loc_oEmail = .NULL.
1065:         RETURN loc_lOk
1066:     ENDPROC
1067: 
1068:     *--------------------------------------------------------------------------
1069:     * GravarLog - Registra envio no log do sistema (sigoplog)
1070:     * Adaptado de: fGravarLog('T', SIGPREMA, '', EmpDopNums)
1071:     *--------------------------------------------------------------------------
1072:     PROCEDURE GravarLog(par_cEmpDopNums)
1073:         LOCAL loc_lSucesso, loc_cSQL, loc_oErro
1074:         loc_lSucesso = .F.
1075: 
1076:         TRY
1077:             loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datas, Horas) " + ;
1078:                        "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
1079:                        EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
1080:                        FormatarDataSQL(DATE()) + ", " + ;
1081:                        EscaparSQL(TIME()) + ")"
1082:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1083:                 loc_lSucesso = .T.
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             *-- Falha no log nao impede o fluxo principal
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1092:     * FormBase declara este metodo; retorna .F. para indicar nao-suporte
1093:     *--------------------------------------------------------------------------
1094:     PROCEDURE BtnIncluirClick()
1095:         RETURN .F.
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigpremaBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigprema.prg
- BO: C:\4c\projeto\app\classes\sigpremaBO.prg
