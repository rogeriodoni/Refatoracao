CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3347: Coluna 'lidos' NAO EXISTE na tabela 'sigivtrh' (referenciada como a.lidos)
- [SQL-SCHEMA] Linha ~3347: Coluna 'lidos2' NAO EXISTE na tabela 'sigivtrh' (referenciada como a.lidos2)
- [SQL-SCHEMA] Linha ~3989: INSERT coluna 'lidos' NAO EXISTE na tabela 'sigivtrh'
- [SQL-SCHEMA] Linha ~3989: INSERT coluna 'lidos2' NAO EXISTE na tabela 'sigivtrh'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigivtrh
CREATE TABLE [dbo].[SigIvTrh](
	[cbars] [numeric](14, 0) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[codigos] [numeric](4, 0) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[localis] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[obs] [text] NULL,
	[ocors] [char](10) NOT NULL,
	[pesreals] [numeric](8, 2) NOT NULL,
	[qtds] [numeric](11, 3) NOT NULL,
	[tipos] [numeric](1, 0) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[pesos] [numeric](12, 3) NOT NULL,
	[coletas] [char](1) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\FormBAL.prg):

--- Linhas 3328 a 3368 ---
3328:         ENDTRY
3329: 
3330:         RETURN loc_cLista
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3335:     *--------------------------------------------------------------------------
3336:     PROCEDURE CarregarGradeLeitura()
3337:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3338:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3339:         loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3340:         loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3341: 
3342:         TRY
3343:             IF USED("cursor_4c_HistoricoTemp")
3344:                 USE IN cursor_4c_HistoricoTemp
3345:             ENDIF
3346: 
3347:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3348:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3349:                        " FROM SigIvTrH a" + ;
3350:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3351:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3352:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3353:                        " ORDER BY a.cidchaves"
3354: 
3355:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
3356: 
3357:             IF loc_nRes >= 0
3358:                 IF USED("cursor_4c_Historico")
3359:                     SELECT cursor_4c_Historico
3360:                     ZAP
3361:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
3362:                     GO TOP
3363:                     loc_oGrd.Refresh()
3364:                 ELSE
3365:                     SELECT * FROM cursor_4c_HistoricoTemp INTO CURSOR cursor_4c_Historico READWRITE
3366:                     loc_oGrd.ColumnCount = 8
3367:                     loc_oGrd.RecordSource          = "cursor_4c_Historico"
3368:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"

--- Linhas 3970 a 4010 ---
3970: 
3971:             IF EMPTY(loc_cCidchaves)
3972:                 MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
3973:                 RETURN
3974:             ENDIF
3975: 
3976:             *-- Obter cbars do produto (codigo de barras)
3977:             LOCAL loc_cCbars, loc_nResCb
3978:             loc_cCbars = ""
3979:             loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
3980:                          EscaparSQL(loc_cProd), "cursor_4c_CBars")
3981:             IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
3982:                 SELECT cursor_4c_CBars
3983:                 loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
3984:             ENDIF
3985:             IF USED("cursor_4c_CBars")
3986:                 USE IN cursor_4c_CBars
3987:             ENDIF
3988: 
3989:             loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
3990:                        " codcors, codtams, lidos, lidos2, localis, obs)" + ;
3991:                        " VALUES (" + ;
3992:                        EscaparSQL(loc_cCidchaves) + "," + ;
3993:                        EscaparSQL(loc_cEmps) + "," + ;
3994:                        FormatarNumeroSQL(loc_nCodigos) + "," + ;
3995:                        EscaparSQL(loc_cCbars) + "," + ;
3996:                        EscaparSQL(loc_cProd) + "," + ;
3997:                        EscaparSQL(loc_cCodCor) + "," + ;
3998:                        EscaparSQL(loc_cCodTam) + "," + ;
3999:                        FormatarNumeroSQL(loc_nQtd) + "," + ;
4000:                        FormatarNumeroSQL(loc_nQtd2) + "," + ;
4001:                        EscaparSQL(loc_cLocal) + "," + ;
4002:                        EscaparSQL(loc_cObs) + ;
4003:                        ")"
4004: 
4005:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4006:             IF loc_nRes >= 0
4007:                 loc_lSucesso = .T.
4008:                 THIS.LimparCamposLeitura()
4009:                 THIS.CarregarGradeLeitura()
4010:             ELSE



## Trechos relevantes do BO (C:\4c\projeto\app\classes\BALBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\FormBAL.prg
- BO: C:\4c\projeto\app\classes\BALBO.prg
