# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FINANCEIRO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, ICLIS, GRUPOS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'INDUSTRIA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, ICLIS, GRUPOS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TPCODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, ICLIS, GRUPOS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, ICLIS, GRUPOS, CODIGOS

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
  ControlSource = "crSigCdGcr.complems"
  ControlSource = "crSigCdGcr.pessoais"
  ControlSource = "crSigCdGcr.refbancs"
  ControlSource = "crSigCdGcr.followups"
  ControlSource = "crSigCdGcr.fiscais"
  ControlSource = "crSigCdGcr.contabs"
  ControlSource = "crSigCdGcr.empresas"
  ControlSource = "crSigCdGcr.commoedas"
  ControlSource = "crSigCdGcr.molimcre"
  ControlSource = "crSigCdGcr.Caracteris"
  ControlSource = "crSigCdGcr.InfCads"
  ControlSource = "crSigCdGcr.FichaTecs"
  ControlSource = "crSigCdGcr.respos"
  ControlSource = "crSigCdGcr.limcres"
  ControlSource = "crSigCdGcr.comis"
  ControlSource = "crSigCdGcr.coletors"
  ControlSource = "crSigCdGcr.cargos"
  ControlSource = "crSigCdGcr.chklimcrds"
  ControlSource = "crSigCdGcr.grupolms"
  ControlSource = "crSigCdGcr.dadcoms"
  ControlSource = "crSigCdGcr.RodRelCC"
  ControlSource = "crSigCdGcr.vrlimcre"
  ControlSource = "crSigCdGcr.PreCad"
  ControlSource = "crSigCdGcr.contconts"
  ControlSource = "crSigCdGcr.cpfobrigs"
  ControlSource = "crSigCdGcr.cepobris"
  ControlSource = "crSigCdGcr.mfotos"
  ControlSource = "crSigCdGcr.Observas"
  ControlSource = "crSigCdGcr.rgobrigs"
  ControlSource = "crSigCdGcr.intconts"
  ControlSource = "crSigCdGcr.PadPgRecs"
  ControlSource = "crSigCdGcr.chkendds"
  ControlSource = "crSigCdGcr.chkendrs"
  ControlSource = "crSigCdGcr.CalcIMeds"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdGcr.TitBaixado"
  ControlSource = ""
  ControlSource = "crSigCdGcr.ccustotit"
  ControlSource = "crSigCdGcr.logalt"
  ControlSource = "crSigCdGcr.InfSenha"
  ControlSource = "crSigCdGcr.dtnascobr"
  ControlSource = "crSigCdGcr.fpublsobr"
  ControlSource = "crSigCdGcr.ctVinculas"
  ControlSource = "crSigCdGcr.tipoinvs"
  ControlSource = "crSigCdGcr.trfpesas"
  ControlSource = "crSigCdGcr.compagrus"
  ControlSource = "crSigCdGcr.Pqs"
  ControlSource = "crSigCdGcr.agrupas"
  ControlSource = "crSigCdGcr.ctrlotes"
  ControlSource = "crSigCdGcr.ddretros"
  ControlSource = "crSigCdGcr.ddfutus"
  ControlSource = "crSigCdGcr.difpesags"
  ControlSource = "crSigCdGcr.Sinals"
  ControlSource = "crSigCdGcr.ContaFalha"
  ControlSource = "crSigCdGcr.grufals"
  ControlSource = "crSigCdGcr.GrupoFalha"
  ControlSource = "crSigCdGcr.calcsalds"
  ControlSource = "crSigCdGcr.limestoqs"
  ControlSource = "crSigCdGcr.verests"
  ControlSource = "crSigCdGcr.estoques"
  ControlSource = "crSigCdGcr.ccustos"
  ControlSource = "crSigCdGcr.emprelevs"
  ControlSource = "crSigCdGcr.blqcongvs"
  ControlSource = "crSigCdGcr.ChkLimEsts"
  ControlSource = "crSigCdGcr.PatriEtqs"
  ControlSource = "crSigCdGcr.gerbals"
  ControlSource = "crSigCdGcr.unifbals"
  ControlSource = "crSigCdGcr.balfalpers"
  ControlSource = "crSigCdGcr.blqdivops"
  ControlSource = "crSigCdGcr.Chktits"
  ControlSource = "crSigCdGcr.OsPends"
  ControlSource = "crSigCdGcr.ContaPdr"
  ControlSource = "crSigCdGcr.dgcods"
  ControlSource = "crSigCdGcr.codigos"
  ControlSource = "crSigCdGcr.descrs"
  ControlSource = "crSigCdGcr.internos"
  ControlSource = "crSigCdGcr.Classes"
  ControlSource = "crSigCdGcr.DClasses"
  ControlSource = "crSigCdGcr.tpcods"
  ControlSource = "crSigCdGcr.tpemps"
  ControlSource = "crSigCdGcr.tpcads"
			lcQuery = [Select RClis From SigCdCli Where IClis = '] + Padr(loObj.getCdContas.Value, 10) + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
Select CrSigCdGcr
	lcQuery = [select a.*, b.Descrs as DClasses from SigCdGcr a ]+;
			  [Left Join SigCdCss B on a.Classes = b.Classes ]+;
Select CrSigCdGcr
ThisForm.pagina.lista.grade.column4.ControlSource = [Nvl(CrSigCdGcr.DClasses,'')]
&&=Seek(CrSigCdGcr.Classes,'CrSigCdCss','Classes')
Select CrSigCdGcr
	ThisForm.poDataMgr.SQLExecute([Update SigCdCli Set TpCads = ?lnTipo Where Grupos = ?lcCodigo], [])
lcQuery = [Select Codigos, Descrs ] + ;
		    [From SigCdCst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crListaRemota') < 1)
Select crListaRemota
	If Not Seek(This.Value, 'crListaRemota', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3654 linhas total):

*-- Linhas 321 a 339:
321:             .Width             = 938
322:             .Height            = 470
323:             .ReadOnly          = .T.
324:             .DeleteMark        = .F.
325:             .RecordMark        = .F.
326:             .ScrollBars        = 3
327:             .GridLines         = 3
328:             .ColumnCount       = 5
329:             .AllowHeaderSizing = .T.
330:             .Visible           = .T.
331:         ENDWITH
332: 
333:         THIS.TornarControlesVisiveis(loc_oPagina)
334:     ENDPROC
335: 
336:     *--------------------------------------------------------------------------
337:     * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
338:     * Compensacao +29 aplicada nos Tops
339:     *--------------------------------------------------------------------------

*-- Linhas 2131 a 2153:
2131:             ELSE
2132:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2133: 
2134:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2135:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2136:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
2137:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
2138:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"
2139: 
2140:                 loc_oGrid.Column1.Width = 80
2141:                 loc_oGrid.Column2.Width = 300
2142:                 loc_oGrid.Column3.Width = 120
2143:                 loc_oGrid.Column4.Width = 60
2144:                 loc_oGrid.Column5.Width = 300
2145: 
2146:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2147:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2148:                 loc_oGrid.Column3.Header1.Caption = "Interno"
2149:                 loc_oGrid.Column4.Header1.Caption = "Tipo"
2150:                 loc_oGrid.Column5.Header1.Caption = "Classe"
2151: 
2152:                 THIS.FormatarGridLista(loc_oGrid)
2153:                 loc_lResultado = .T.

*-- Linhas 3014 a 3036:
3014: 
3015:         TRY
3016:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
3017:                 SELECT Classes, Descrs FROM SigCdCss
3018:                 WHERE Classes = <<EscaparSQL(par_cClasses)>>
3019:             ENDTEXT
3020: 
3021:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")
3022: 
3023:             IF loc_nRes >= 0
3024:                 IF RECCOUNT("cursor_4c_CssVerif") > 0
3025:                     THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
3026:                         ALLTRIM(cursor_4c_CssVerif.Descrs)
3027:                     THIS.this_cUltClasses = par_cClasses
3028:                 ELSE
3029:                     *-- Codigo nao encontrado: abrir lookup
3030:                     THIS.AbrirLookupClasses()
3031:                 ENDIF
3032: 
3033:                 IF USED("cursor_4c_CssVerif")
3034:                     USE IN cursor_4c_CssVerif
3035:                 ENDIF
3036:             ENDIF

*-- Linhas 3132 a 3151:
3132:     PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
3133:         LOCAL loc_nRes
3134:         TRY
3135:             loc_nRes = SQLEXEC(gnConnHandle, ;
3136:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
3137:                 "cursor_4c_GcrVerif")
3138:             IF loc_nRes >= 0
3139:                 IF RECCOUNT("cursor_4c_GcrVerif") > 0
3140:                     IF VARTYPE(par_oTxtDesc) = "O"
3141:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
3142:                     ENDIF
3143:                 ELSE
3144:                     THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
3145:                 ENDIF
3146:                 IF USED("cursor_4c_GcrVerif")
3147:                     USE IN cursor_4c_GcrVerif
3148:                 ENDIF
3149:             ENDIF
3150:         CATCH TO loException
3151:             MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 3240 a 3259:
3240:         LOCAL loc_nRes, loc_oAba
3241:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
3242:         TRY
3243:             loc_nRes = SQLEXEC(gnConnHandle, ;
3244:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
3245:                 "cursor_4c_MoeVerif")
3246:             IF loc_nRes >= 0
3247:                 IF RECCOUNT("cursor_4c_MoeVerif") > 0
3248:                     loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
3249:                     THIS.this_cUltCdMoeda = par_cCodigo
3250:                 ELSE
3251:                     THIS.AbrirLookupMoeda()
3252:                 ENDIF
3253:                 IF USED("cursor_4c_MoeVerif")
3254:                     USE IN cursor_4c_MoeVerif
3255:                 ENDIF
3256:             ENDIF
3257:         CATCH TO loException
3258:             MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
3259:         ENDTRY

*-- Linhas 3312 a 3331:
3312:         LOCAL loc_nRes, loc_oAba
3313:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3314:         TRY
3315:             loc_nRes = SQLEXEC(gnConnHandle, ;
3316:                 "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
3317:                 "cursor_4c_CstVerif")
3318:             IF loc_nRes >= 0
3319:                 IF RECCOUNT("cursor_4c_CstVerif") > 0
3320:                     THIS.this_cUltSituas = par_cCodigo
3321:                 ELSE
3322:                     THIS.AbrirLookupSituas()
3323:                 ENDIF
3324:                 IF USED("cursor_4c_CstVerif")
3325:                     USE IN cursor_4c_CstVerif
3326:                 ENDIF
3327:             ENDIF
3328:         CATCH TO loException
3329:             MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
3330:         ENDTRY
3331:     ENDPROC

