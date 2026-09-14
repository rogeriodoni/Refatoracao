CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~2923: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.Impres)
- [SQL-SCHEMA] Linha ~2923: Coluna 'cimps' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.CImps)
- [SQL-SCHEMA] Linha ~2923: Coluna 'impres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.Impres)
- [SQL-SCHEMA] Linha ~2923: Coluna 'usuacess' NAO EXISTE na tabela 'sigcdacg' (referenciada como a.UsuAcess)
- [SQL-SCHEMA] Linha ~2923: Coluna 'ntpimpres' NAO EXISTE na tabela 'sigsyimp' (referenciada como b.nTpImpres)


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigcdacg
CREATE TABLE [dbo].[sigcdacg](
	[grupos] [char](10) NOT NULL,
	[usuarios] [char](10) NOT NULL,
	[pkchaves] [char](20) NOT NULL,
 

-- Tabela: sigsyimp
CREATE TABLE [dbo].[SIGSYIMP](
	[cidchaves] [char](20) NOT NULL,
	[cimps] [char](30) NOT NULL,
	[gracess] [char](10) NOT NULL,
	[usuacess] [char](10) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg):



## Trechos relevantes do BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):

--- BO Linhas 50 a 60 ---
50:     this_nTpImp        = 1    && Tipo impressora (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
51:     this_nAjVertsPrint = 0    && Ajuste vertical para impressao (Spn_AjVerts.Value)
52:     this_nAjHorzsPrint = 0    && Ajuste horizontal para impressao (Spn_AjHorzs.Value)
53:     this_nAjDensPrint  = 20   && Densidade para impressao (Spn_AjDenss.Value)
54:     this_nAjVelosPrint = 1    && Velocidade para impressao (spn_AjVelos.Value)
55:     this_cNomeImp      = ""   && Nome da impressora selecionada (crImpreV.impres)
56:     this_nImpres       = 0    && Numero de registro da impressora (RECNO crImpreV)
57:     this_cLp1          = ""   && Lista de precos 1 (passada ao SigOpEtq)
58:     this_cLp2          = ""   && Lista de precos 2 (passada ao SigOpEtq)
59:     this_nOrdem        = 1    && Ordem de impressao (1=Produto, 2=Nenhuma)
60: 

--- BO Linhas 194 a 204 ---
194:         RETURN loc_nTipos
195:     ENDPROC
196: 
197:     *--------------------------------------------------------------------------
198:     * CarregarImpressoras - Carrega impressoras disponiveis para o usuario
199:     * Popula cursor_4c_ImpTemp com campo Impres C(50)
200:     * Retorna: .T. se carregado com sucesso
201:     *--------------------------------------------------------------------------
202:     PROCEDURE CarregarImpressoras()
203:         LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
204: 

--- BO Linhas 205 a 215 ---
205:         loc_lSucesso = .F.
206: 
207:         TRY
208:             loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)
209: 
210:             loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
211:                        "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;

--- BO Linhas 206 a 216 ---
206: 
207:         TRY
208:             loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)
209: 
210:             loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
211:                        "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;

--- BO Linhas 207 a 217 ---
207:         TRY
208:             loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)
209: 
210:             loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
211:                        "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;

--- BO Linhas 208 a 218 ---
208:             loc_cUsuario = EscaparSQL(gc_4c_UsuarioLogado)
209: 
210:             loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
211:                        "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;

--- BO Linhas 210 a 220 ---
210:             loc_cSQL = "SELECT b.Impres FROM SigSyImp a " + ;
211:                        "INNER JOIN SigCdmp b ON a.CImps = b.Impres " + ;
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;
219:                        " AND c.nTpImpres = 2"
220: 

--- BO Linhas 212 a 222 ---
212:                        "WHERE a.UsuAcess = " + loc_cUsuario + ;
213:                        " AND b.nTpImpres = 2 " + ;
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;
219:                        " AND c.nTpImpres = 2"
220: 
221:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
222:                 loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;

--- BO Linhas 214 a 224 ---
214:                        "UNION ALL " + ;
215:                        "SELECT c.Impres FROM SigCdAcG a " + ;
216:                        "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;
219:                        " AND c.nTpImpres = 2"
220: 
221:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
222:                 loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
223:                            "WHERE nTpImpres = 2 ORDER BY Impres"
224:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0

--- BO Linhas 217 a 227 ---
217:                        "INNER JOIN SigCdmp c ON b.CImps = c.Impres " + ;
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;
219:                        " AND c.nTpImpres = 2"
220: 
221:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
222:                 loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
223:                            "WHERE nTpImpres = 2 ORDER BY Impres"
224:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
225:                     loc_lSucesso = .T.
226:                 ENDIF
227:             ELSE

--- BO Linhas 218 a 228 ---
218:                        "WHERE a.Usuarios = " + loc_cUsuario + ;
219:                        " AND c.nTpImpres = 2"
220: 
221:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") <= 0
222:                 loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
223:                            "WHERE nTpImpres = 2 ORDER BY Impres"
224:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
225:                     loc_lSucesso = .T.
226:                 ENDIF
227:             ELSE
228:                 loc_lSucesso = .T.


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg
- BO: C:\4c\projeto\app\classes\SigPrEtqBO.prg
