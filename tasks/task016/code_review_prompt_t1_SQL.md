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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3336 linhas total):

*-- Linhas 322 a 340:
322:             .Width             = 938
323:             .Height            = 470
324:             .ReadOnly          = .T.
325:             .DeleteMark        = .F.
326:             .RecordMark        = .F.
327:             .ScrollBars        = 3
328:             .GridLines         = 3
329:             .ColumnCount       = 5
330:             .AllowHeaderSizing = .T.
331:             .Visible           = .T.
332:         ENDWITH
333: 
334:         THIS.TornarControlesVisiveis(loc_oPagina)
335:     ENDPROC
336: 
337:     *--------------------------------------------------------------------------
338:     * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
339:     * Compensacao +29 aplicada nos Tops
340:     *--------------------------------------------------------------------------

*-- Linhas 1822 a 1844:
1822:             ELSE
1823:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1824: 
1825:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1826:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1827:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
1828:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
1829:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"
1830: 
1831:                 loc_oGrid.Column1.Width = 80
1832:                 loc_oGrid.Column2.Width = 300
1833:                 loc_oGrid.Column3.Width = 120
1834:                 loc_oGrid.Column4.Width = 60
1835:                 loc_oGrid.Column5.Width = 300
1836: 
1837:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1838:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1839:                 loc_oGrid.Column3.Header1.Caption = "Interno"
1840:                 loc_oGrid.Column4.Header1.Caption = "Tipo"
1841:                 loc_oGrid.Column5.Header1.Caption = "Classe"
1842: 
1843:                 THIS.FormatarGridLista(loc_oGrid)
1844:                 loc_lResultado = .T.

*-- Linhas 2705 a 2727:
2705: 
2706:         TRY
2707:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2708:                 SELECT Classes, Descrs FROM SigCdCss
2709:                 WHERE Classes = <<EscaparSQL(par_cClasses)>>
2710:             ENDTEXT
2711: 
2712:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")
2713: 
2714:             IF loc_nRes >= 0
2715:                 IF RECCOUNT("cursor_4c_CssVerif") > 0
2716:                     THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
2717:                         ALLTRIM(cursor_4c_CssVerif.Descrs)
2718:                     THIS.this_cUltClasses = par_cClasses
2719:                 ELSE
2720:                     *-- Codigo nao encontrado: abrir lookup
2721:                     THIS.AbrirLookupClasses()
2722:                 ENDIF
2723: 
2724:                 IF USED("cursor_4c_CssVerif")
2725:                     USE IN cursor_4c_CssVerif
2726:                 ENDIF
2727:             ENDIF

*-- Linhas 2814 a 2833:
2814:     PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
2815:         LOCAL loc_nRes
2816:         TRY
2817:             loc_nRes = SQLEXEC(gnConnHandle, ;
2818:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
2819:                 "cursor_4c_GcrVerif")
2820:             IF loc_nRes >= 0
2821:                 IF RECCOUNT("cursor_4c_GcrVerif") > 0
2822:                     IF VARTYPE(par_oTxtDesc) = "O"
2823:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
2824:                     ENDIF
2825:                 ELSE
2826:                     THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
2827:                 ENDIF
2828:                 IF USED("cursor_4c_GcrVerif")
2829:                     USE IN cursor_4c_GcrVerif
2830:                 ENDIF
2831:             ENDIF
2832:         CATCH TO loException
2833:             MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")

*-- Linhas 2922 a 2941:
2922:         LOCAL loc_nRes, loc_oAba
2923:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2924:         TRY
2925:             loc_nRes = SQLEXEC(gnConnHandle, ;
2926:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
2927:                 "cursor_4c_MoeVerif")
2928:             IF loc_nRes >= 0
2929:                 IF RECCOUNT("cursor_4c_MoeVerif") > 0
2930:                     loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
2931:                     THIS.this_cUltCdMoeda = par_cCodigo
2932:                 ELSE
2933:                     THIS.AbrirLookupMoeda()
2934:                 ENDIF
2935:                 IF USED("cursor_4c_MoeVerif")
2936:                     USE IN cursor_4c_MoeVerif
2937:                 ENDIF
2938:             ENDIF
2939:         CATCH TO loException
2940:             MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
2941:         ENDTRY

*-- Linhas 2994 a 3013:
2994:         LOCAL loc_nRes, loc_oAba
2995:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2996:         TRY
2997:             loc_nRes = SQLEXEC(gnConnHandle, ;
2998:                 "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
2999:                 "cursor_4c_CstVerif")
3000:             IF loc_nRes >= 0
3001:                 IF RECCOUNT("cursor_4c_CstVerif") > 0
3002:                     THIS.this_cUltSituas = par_cCodigo
3003:                 ELSE
3004:                     THIS.AbrirLookupSituas()
3005:                 ENDIF
3006:                 IF USED("cursor_4c_CstVerif")
3007:                     USE IN cursor_4c_CstVerif
3008:                 ENDIF
3009:             ENDIF
3010:         CATCH TO loException
3011:             MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
3012:         ENDTRY
3013:     ENDPROC

