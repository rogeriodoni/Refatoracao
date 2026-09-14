CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~3560: WHERE coluna 'cbars' NAO EXISTE na tabela 'sigivtrt'
- [SQL-SCHEMA] Linha ~3860: WHERE coluna 'cbars' NAO EXISTE na tabela 'sigivtrt'


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigivtrt
CREATE TABLE [dbo].[SigIvTrt](
	[apurado] [numeric](11, 3) NOT NULL,
	[barra2s] [numeric](14, 0) NOT NULL,
	[barras] [numeric](14, 0) NOT NULL,
	[ccusto2s] [numeric](8, 2) NOT NULL,
	[ccustos] [numeric](8, 2) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[citens] [numeric](6, 0) NOT NULL,
	[codigos] [numeric](4, 0) NOT NULL,
	[datatrans] [datetime] NULL,
	[emps] [char](3) NOT NULL,
	[estoque] [numeric](11, 3) NOT NULL,
	[falta] [numeric](11, 3) NOT NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[obs] [text] NULL,
	[obs2s] [text] NULL,
	[ocor2s] [char](10) NOT NULL,
	[ocorrencia] [char](10) NOT NULL,
	[peso2s] [numeric](8, 2) NOT NULL,
	[pesreals] [numeric](8, 2) NOT NULL,
	[produto] [char](14) NOT NULL,
	[sobra] [numeric](11, 3) NOT NULL,
	[tipos] [char](1) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[faltapeso] [numeric](11, 3) NOT NULL,
	[sobrapeso] [numeric](11, 3) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\cadastros\Formint.prg):

--- Linhas 3541 a 3581 ---
3541:                     GO TOP
3542:                     SCAN
3543:                         IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
3544:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
3545:                            EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
3546:                             MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
3547:                                 "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
3548:                                 "Valida" + CHR(231) + CHR(227) + "o")
3549:                             THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
3550:                             loc_lValido = .F.
3551:                             EXIT
3552:                         ENDIF
3553:                     ENDSCAN
3554: 
3555:                     IF loc_lValido
3556:                         *-- Gravar cada linha na tabela SigIvTrT
3557:                         SELECT cursor_4c_Tratamento
3558:                         GO TOP
3559:                         SCAN
3560:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3561:                                 " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
3562:                                 ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
3563:                                 ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
3564:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3565:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3566:                                 " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
3567:                                 " AND CBars = " + TRANSFORM(cursor_4c_Tratamento.Barras)
3568:                             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3569:                             IF loc_nResult < 0
3570:                                 MostrarErro("Erro ao gravar item:" + CHR(13) + ;
3571:                                     CapturarErroSQL(), "Formint.BtnSairCntClick")
3572:                                 loc_lValido = .F.
3573:                                 EXIT
3574:                             ENDIF
3575:                         ENDSCAN
3576:                     ENDIF
3577: 
3578:                     IF loc_lValido
3579:                     *-- Marcar inventario como tratado
3580:                     loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3581:                         " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;

--- Linhas 3841 a 3881 ---
3841:                     *-- Verificar operacao da ocorrencia na SigBaOco
3842:                     loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
3843:                         " WHERE Tipos = 'O' AND Autos = 'S'" + ;
3844:                         " AND Codigos = " + EscaparSQL(loc_cOcor)
3845:                     SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")
3846: 
3847:                     IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
3848:                         SELECT cursor_4c_Tratamento
3849:                         GO TOP
3850:                         SCAN
3851:                             LOCAL loc_cCidChave, loc_cBarras
3852:                             loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
3853:                             loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))
3854: 
3855:                             *-- Aplicar ocorrencia no cursor local
3856:                             REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
3857:                             REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
3858: 
3859:                             *-- Gravar na tabela SigIvTrT
3860:                             loc_cSQL = "UPDATE SigIvTrT SET" + ;
3861:                                 " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
3862:                                 ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
3863:                                 " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3864:                                 " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
3865:                                 " AND CBars = " + TRANSFORM(cursor_4c_Tratamento.Barras)
3866:                             SQLEXEC(gnConnHandle, loc_cSQL)
3867:                         ENDSCAN
3868: 
3869:                         *-- Marcar inventario como tratado
3870:                         loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
3871:                             " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
3872:                             " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
3873:                         SQLEXEC(gnConnHandle, loc_cSQL)
3874: 
3875:                         IF USED("cursor_4c_Ocorr")
3876:                             USE IN cursor_4c_Ocorr
3877:                         ENDIF
3878: 
3879:                         MsgInfo("Baixa Autom" + CHR(225) + "tica aplicada com sucesso!", ;
3880:                             "Baixa Autom" + CHR(225) + "tica")
3881: 



## Trechos relevantes do BO (C:\4c\projeto\app\classes\intBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\cadastros\Formint.prg
- BO: C:\4c\projeto\app\classes\intBO.prg
