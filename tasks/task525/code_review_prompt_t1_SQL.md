# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CTIPOS, CODSERVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CTIPOS, CODSERVS

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
  ControlSource = "crSigCdSrv.vMinCslls"
  ControlSource = "crSigCdSrv.vMinInss"
  ControlSource = "crSigCdSrv.vMinIrrfs"
  ControlSource = "crSigCdSrv.vmincofins"
  ControlSource = "crSigCdSrv.descservs"
  ControlSource = "crSigCdSrv.vminpiss"
  ControlSource = "crSigCdSrv.aiss"
  ControlSource = "crSigCdSrv.CodServs"
  ControlSource = "crSigCdSrv.apiss"
  ControlSource = "crSigCdSrv.acofinss"
  ControlSource = "crSigCdSrv.airrfs"
  ControlSource = "crSigCdSrv.ainss"
  ControlSource = "crSigCdSrv.acslls"
  ControlSource = "crSigCdSrv.cGrupo"
  ControlSource = "crSigCdSrv.cContab"
  ControlSource = ""
  ControlSource = "crSigCdSrv.cOcorCofin"
  ControlSource = "crSigCdSrv.vMinbCslls"
  ControlSource = "crSigCdSrv.vMinbInss"
  ControlSource = "crSigCdSrv.vMinbIrrfs"
  ControlSource = "crSigCdSrv.vminbcofin"
  ControlSource = "crSigCdSrv.cOcorIrrfs"
  ControlSource = "crSigCdSrv.vminbpiss"
  ControlSource = "crSigCdSrv.cOcorinss"
  ControlSource = "crSigCdSrv.cOcorCslls"
  ControlSource = "crSigCdSrv.cOcoriSS"
  ControlSource = "crSigCdSrv.cOcorPiss"
  ControlSource = "crSigCdSrv.nLanFPiss"
  ControlSource = "crSigCdSrv.bpisms"
  ControlSource = "crSigCdSrv.bcofinms"
  ControlSource = "crSigCdSrv.bcsllms"
  ControlSource = "crSigCdSrv.birrfms"
  ControlSource = "crSigCdSrv.binssms"
  ControlSource = "crSigCdSrv.nLanFCofin"
  ControlSource = "crSigCdSrv.nLanFIrrfs"
  ControlSource = "crSigCdSrv.nLanFInss"
  ControlSource = "crSigCdSrv.nLanFIss"
  ControlSource = "crSigCdSrv.nLanFCslls"
  ControlSource = "crSigCdSrv.cCtaPiss"
  ControlSource = ""
  ControlSource = "crSigCdSrv.cGrpCofins"
  ControlSource = "crSigCdSrv.cCtaCofins"
  ControlSource = ""
  ControlSource = "crSigCdSrv.cGrpIrrfs"
  ControlSource = "crSigCdSrv.cCtaIrrfs"
  ControlSource = ""
  ControlSource = "crSigCdSrv.cGrpInss"
  ControlSource = "crSigCdSrv.cCtaInss"
  ControlSource = ""
  ControlSource = "crSigCdSrv.cGrpCslls"
  ControlSource = "crSigCdSrv.cCtaCslls"
  ControlSource = ""
  ControlSource = "crSigCdSrv.vcpis"
  ControlSource = "crSigCdSrv.vccofins"
  ControlSource = "crSigCdSrv.vcirrf"
  ControlSource = "crSigCdSrv.vcinss"
  ControlSource = "crSigCdSrv.vccsll"
  ControlSource = "crSigCdSrv.cGrpIss"
  ControlSource = "crSigCdSrv.cCtaIss"
  ControlSource = ""
  ControlSource = "crSigCdSrv.vciss"
  Picture = ..\vbmp\a_delete1.bmp
  DeleteMark = .F.
  Picture = ..\vbmp\a_insert1.bmp
  ControlSource = "crSigCdSrv.cgrppiss"
  ControlSource = "crSigCdSrv.nrpas"
  ControlSource = "crSigCdSrv.codreccof"
  ControlSource = "crSigCdSrv.codrecpis"
  ControlSource = "crSigCdSrv.codreccsll"
  ControlSource = "crSigCdSrv.maxretinss"
  ControlSource = "crSigCdSrv.codrecirrf"
  ControlSource = "crSigCdSrv.codcofinss"
  ControlSource = "crSigCdSrv.codpiss"
  ControlSource = "crSigCdSrv.codcslls"
Select crSigCdSrv
ThisForm.poDataMgr.Update([crSigSeRvp])
ThisForm.poDataMgr.Update([crSigSeRvp])
ThisForm.poDataMgr.Update([crSigSeRvp])
	m.lcQuery = [Select * from SigCdSrv where cTipos = ']+ThisForm.pcTipo+[']
		lcQuery = [Select a.*, b.dPros from SigSeRvp a inner Join SigCdPro b on b.cpros = a.cpros where a.CodServs = ?pcCodServ]
		lcQuery = [Select Codigos, Descrs from SigOpOco]
		If .poDataMgr.SQLExecute(lcQuery,[crSigOpOco]) < 1
		Select crSigOpOco
Select crSigCdSrv
	.grdProdutos.Column1.ControlSource = [crSigSeRvp.cPros]
	.grdProdutos.Column2.ControlSource = [crSigSeRvp.dPros]
Select crSigCdSrv
		lcQuery = [Select * ] + ;
				    [From SigCdSrv ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusca]) < 1)
		Select crBusca
	lcQuery = [Delete from SigSeRvp where CodServs = ']+crSigCdSrv.CodServs+[']
	ThisForm.poDataMgr.SQLExecute(lcQuery)
Select crSigCdSrv
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
	If Not Seek(This.Value, 'crSigOpOco', 'Codigos')
Select crSigSeRvp
Delete
	Insert into crSigSeRvp(CodServs,cPros,cIdChaves) Values(crSigCdSrv.CodServs,[],fUniqueIds())	

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSRV.prg) - TRECHOS RELEVANTES PARA PASS SQL (4068 linhas total):

*-- Linhas 355 a 373:
355:             .HighlightBackColor      = RGB(255, 255, 255)
356:             .HighlightForeColor      = RGB(15, 41, 104)
357:             .HighlightStyle          = 2
358:             .DeleteMark              = .F.
359:             .RecordMark              = .F.
360:             .RowHeight               = 16
361:             .ScrollBars              = 2
362:             .GridLines               = 3
363:             .ReadOnly                = .T.
364:             .Visible                 = .T.
365:             .Column1.Width           = 100
366:             .Column2.Width           = 760
367:             .Column1.ReadOnly        = .T.
368:             .Column2.ReadOnly        = .T.
369:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
370:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
371:         ENDWITH
372: 
373:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 2049 a 2067:
2049:             .HighlightBackColor      = RGB(255, 255, 255)
2050:             .HighlightForeColor      = RGB(15, 41, 104)
2051:             .HighlightStyle          = 2
2052:             .DeleteMark              = .F.
2053:             .RecordMark              = .F.
2054:             .RowHeight               = 18
2055:             .ScrollBars              = 2
2056:             .GridLines               = 3
2057:             .Visible                 = .T.
2058:             .Column1.Width           = 100
2059:             .Column2.Width           = 320
2060:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
2061:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2062:         ENDWITH
2063: 
2064:         loc_oAba.AddObject("cmd_4c_CmdInserir", "CommandButton")
2065:         WITH loc_oAba.cmd_4c_CmdInserir
2066:             .Caption   = "Inserir"
2067:             .Top       = 234

*-- Linhas 2574 a 2616:
2574: 
2575:     *===========================================================================
2576:     * CarregarLista - Carrega servicos do tipo atual (this_cTipoServico) no
2577:     * Grid da Page1. Reconfigura ControlSource + Headers (RecordSource reseta
2578:     * cabecalhos em VFP9)
2579:     *===========================================================================
2580:     PROCEDURE CarregarLista()
2581:         LOCAL loc_lResultado, loc_oGrid
2582:         loc_lResultado = .F.
2583: 
2584:         TRY
2585:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2586:                 IF USED("cursor_4c_Dados")
2587:                     USE IN cursor_4c_Dados
2588:                 ENDIF
2589:                 SET NULL ON
2590:                 CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codservs C(10), descservs C(40), ctipos C(1))
2591:                 SET NULL OFF
2592:                 loc_lResultado = .T.
2593:             ELSE
2594:                 IF THIS.this_oBusinessObject.Buscar("")
2595:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2596:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2597: 
2598:                         loc_oGrid.ColumnCount  = 2
2599:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2600:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codservs"
2601:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descservs"
2602: 
2603:                         loc_oGrid.Column1.Width = 100
2604:                         loc_oGrid.Column2.Width = 760
2605: 
2606:                         loc_oGrid.Column1.ReadOnly = .T.
2607:                         loc_oGrid.Column2.ReadOnly = .T.
2608: 
2609:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2610:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2611: 
2612:                         THIS.FormatarGridLista(loc_oGrid)
2613:                     ENDIF
2614:                     loc_lResultado = .T.
2615:                 ENDIF
2616:             ENDIF

*-- Linhas 2781 a 2799:
2781:         loc_cFiltro = ""
2782:         loc_lMostrouGrid = .F.
2783:         IF !EMPTY(ALLTRIM(par_cGrupo))
2784:             loc_cFiltro = "grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))
2785:         ENDIF
2786: 
2787:         TRY
2788:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2789:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cValorAtual, ;
2790:                 "Conta Cont" + CHR(225) + "bil", .F., .F., loc_cFiltro)
2791: 
2792:             IF VARTYPE(loc_oBusca) = "O"
2793:                 IF !loc_oBusca.this_lAchouRegistro
2794:                     loc_lMostrouGrid = .T.
2795:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2796:                     loc_oBusca.mAddColuna("Rclis", "", "Nome")
2797:                     loc_oBusca.Show()
2798:                 ENDIF
2799: 

*-- Linhas 2892 a 2910:
2892:                 ENDIF
2893: 
2894:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
2895:                     SELECT cursor_4c_Produtos
2896:                     REPLACE CPros WITH ALLTRIM(cursor_4c_BuscaProduto.CPros), ;
2897:                             DPros WITH ALLTRIM(TratarNulo(cursor_4c_BuscaProduto.DPros, "C"))
2898:                     loc_oGrid.Refresh()
2899:                 ENDIF
2900: 
2901:                 loc_oBusca.Release()
2902:             ENDIF
2903:         CATCH TO loException
2904:             MsgErro(loException.Message, "FormSRV.AbrirLookupProdutoDoGrid")
2905:         ENDTRY
2906: 
2907:         IF USED("cursor_4c_BuscaProduto")
2908:             USE IN cursor_4c_BuscaProduto
2909:         ENDIF
2910:     ENDPROC

*-- Linhas 3288 a 3306:
3288:         ENDIF
3289: 
3290:         TRY
3291:             SELECT cursor_4c_Produtos
3292:             IF !EMPTY(ALLTRIM(NVL(CPros, ""))) OR EOF("cursor_4c_Produtos")
3293:                 APPEND BLANK IN cursor_4c_Produtos
3294:                 REPLACE CidChaves WITH fUniqueIds(), ;
3295:                         CodServs  WITH THIS.this_oBusinessObject.this_cCodigo ;
3296:                         IN cursor_4c_Produtos
3297:             ENDIF
3298: 
3299:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
3300:             GO BOTTOM IN cursor_4c_Produtos
3301:             loc_oGrid.Refresh()
3302:             loc_oGrid.SetFocus()
3303:         CATCH TO loException
3304:             MsgErro(loException.Message, "FormSRV.BtnInserirProdutoClick")
3305:         ENDTRY
3306:     ENDPROC

*-- Linhas 3317 a 3336:
3317:         ENDIF
3318: 
3319:         TRY
3320:             SELECT cursor_4c_Produtos
3321:             DELETE IN cursor_4c_Produtos
3322:             SKIP IN cursor_4c_Produtos
3323:             SKIP -1 IN cursor_4c_Produtos
3324: 
3325:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
3326:             loc_oGrid.Refresh()
3327:         CATCH TO loException
3328:             MsgErro(loException.Message, "FormSRV.BtnExcluirProdutoClick")
3329:         ENDTRY
3330:     ENDPROC
3331: 
3332:     *===========================================================================
3333:     * ObterDescricaoConta - Consulta SigCdCli.Rclis pelo codigo da conta
3334:     * (Iclis). Usado para exibir os campos de descricao (Dcontao/DcontaPis/
3335:     * etc.) ao carregar um registro existente (legado: CursorQuery SigCdCli
3336:     * + Get_Dconta*.Value = crSigCdCli.rClis)

*-- Linhas 3344 a 3400:
3344:         ENDIF
3345: 
3346:         TRY
3347:             loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
3348:                        EscaparSQL(ALLTRIM(par_cConta))
3349: 
3350:             IF USED("cursor_4c_DescConta")
3351:                 USE IN cursor_4c_DescConta
3352:             ENDIF
3353: 
3354:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
3355:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
3356:                 loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_DescConta.Rclis, "C"))
3357:             ENDIF
3358:         CATCH TO loException
3359:             loc_cDescricao = ""
3360:         ENDTRY
3361: 
3362:         IF USED("cursor_4c_DescConta")
3363:             USE IN cursor_4c_DescConta
3364:         ENDIF
3365: 
3366:         RETURN loc_cDescricao
3367:     ENDFUNC
3368: 
3369:     *===========================================================================
3370:     * AtualizarGridProdutos - (Re)vincula o Grid de Produtos (aba Vencimentos)
3371:     * ao cursor_4c_Produtos gerenciado pelo SRVBO. Deve ser chamado sempre
3372:     * que o cursor for (re)criado (NovoRegistro/LimparCampos) ou recarregado
3373:     * (BOParaForm), pois RecordSource reseta ControlSource/Headers em VFP9
3374:     *===========================================================================
3375:     PROTECTED PROCEDURE AtualizarGridProdutos()
3376:         LOCAL loc_oGrid
3377: 
3378:         TRY
3379:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_1.Page2.grd_4c_Dados
3380: 
3381:             IF USED("cursor_4c_Produtos")
3382:                 loc_oGrid.ColumnCount = 2
3383:                 loc_oGrid.RecordSource = "cursor_4c_Produtos"
3384:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.CPros"
3385:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.DPros"
3386:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3387:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3388:                 loc_oGrid.Refresh()
3389:             ENDIF
3390:         CATCH TO loException
3391:             MsgErro(loException.Message, "FormSRV.AtualizarGridProdutos")
3392:         ENDTRY
3393:     ENDPROC
3394: 
3395:     *===========================================================================
3396:     * FormParaBO - Transfere TODOS os campos do Form (abas Impostos/
3397:     * Vencimentos/Retencao) para as propriedades this_* do SRVBO
3398:     *===========================================================================
3399:     PROTECTED FUNCTION FormParaBO()
3400:         LOCAL loc_oImp, loc_oVen, loc_oRet, loc_oBO, loc_lResultado

*-- Linhas 3866 a 3884:
3866:             RETURN .F.
3867:         ENDIF
3868: 
3869:         SELECT cursor_4c_Dados
3870:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)
3871: 
3872:         TRY
3873:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3874:                 THIS.BOParaForm()
3875:                 THIS.this_cModoAtual = "VISUALIZAR"
3876:                 THIS.HabilitarCampos(.F.)
3877:                 THIS.AjustarBotoesPorModo()
3878:                 THIS.AlternarPagina(2)
3879:                 loc_lResultado = .T.
3880:             ENDIF
3881:         CATCH TO loException
3882:             MsgErro(loException.Message, "FormSRV.BtnVisualizarClick")
3883:         ENDTRY
3884: 

*-- Linhas 3897 a 3915:
3897:             RETURN .F.
3898:         ENDIF
3899: 
3900:         SELECT cursor_4c_Dados
3901:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)
3902: 
3903:         TRY
3904:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3905:                 THIS.this_oBusinessObject.EditarRegistro()
3906:                 THIS.BOParaForm()
3907:                 THIS.this_cModoAtual = "ALTERAR"
3908:                 THIS.HabilitarCampos(.T.)
3909:                 THIS.AjustarBotoesPorModo()
3910:                 THIS.AlternarPagina(2)
3911:                 loc_lResultado = .T.
3912:             ENDIF
3913:         CATCH TO loException
3914:             MsgErro(loException.Message, "FormSRV.BtnAlterarClick")
3915:         ENDTRY

*-- Linhas 3929 a 3947:
3929:             RETURN .F.
3930:         ENDIF
3931: 
3932:         SELECT cursor_4c_Dados
3933:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codservs)
3934: 
3935:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3936:             RETURN .F.
3937:         ENDIF
3938: 
3939:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do servi" + CHR(231) + "o " + loc_cCodigo + "?", "Excluir")
3940:             RETURN .F.
3941:         ENDIF
3942: 
3943:         TRY
3944:             IF THIS.this_oBusinessObject.Excluir()
3945:                 MsgInfo("Servi" + CHR(231) + "o exclu" + CHR(237) + "do com sucesso!")
3946:                 THIS.CarregarLista()
3947:                 loc_lResultado = .T.

*-- Linhas 4010 a 4028:
4010:                 THIS.this_cModoAtual = "LISTA"
4011:                 THIS.AlternarPagina(1)
4012:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
4013:                     SELECT cursor_4c_Dados
4014:                     LOCATE FOR ALLTRIM(cursor_4c_Dados.codservs) = loc_cCodBusca
4015:                     IF !FOUND()
4016:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descservs)) = UPPER(loc_cCodBusca)
4017:                     ENDIF
4018:                 ENDIF
4019:                 loc_lResultado = .T.
4020:             ELSE
4021:                 IF THIS.FormParaBO()
4022:                     IF THIS.this_oBusinessObject.Salvar()
4023:                         MsgInfo("Servi" + CHR(231) + "o salvo com sucesso!")
4024:                         THIS.this_cModoAtual = "LISTA"
4025:                         THIS.AlternarPagina(1)
4026:                         loc_lResultado = .T.
4027:                     ENDIF
4028:                 ENDIF


### BO (C:\4c\projeto\app\classes\SRVBO.prg):
*====================================================================
* SRVBO.prg
*
* Business Object para Cadastro de Servicos (Entradas/Saidas)
* Tabela: SigCdSrv (mestre) / SigSeRvp (detalhe - produtos do servico)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SRVBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSrv)
    this_cCidChaves     = ""    && cidchaves char(20) - PK
    this_cCodigo        = ""    && codservs char(10)
    this_cDescricao     = ""    && descservs char(40)
    this_cTipo          = "S"   && ctipos char(1) - S=Saidas / E=Entradas

    *-- Aliquotas (%)
    this_nAliquotaPis     = 0   && apiss numeric(4,2)
    this_nAliquotaCofins  = 0   && acofinss numeric(4,2)
    this_nAliquotaIrrf    = 0   && airrfs numeric(4,2)
    this_nAliquotaInss    = 0   && ainss numeric(4,2)
    this_nAliquotaCsll    = 0   && acslls numeric(4,2)
    this_nAliquotaIss     = 0   && aiss numeric(4,2)

    *-- Valores minimos a recolher
    this_nValorMinimoPis     = 0   && vminpiss numeric(11,2)
    this_nValorMinimoCofins  = 0   && vmincofins numeric(11,2)
    this_nValorMinimoIrrf    = 0   && vminirrfs numeric(11,2)
    this_nValorMinimoInss    = 0   && vmininss numeric(11,2)
    this_nValorMinimoCsll    = 0   && vmincslls numeric(11,2)

    *-- Base de calculo minima
    this_nBaseMinimaPis     = 0   && vminbpiss numeric(11,2)
    this_nBaseMinimaCofins  = 0   && vminbcofin numeric(11,2)
    this_nBaseMinimaIrrf    = 0   && vminbirrfs numeric(11,2)
    this_nBaseMinimaInss    = 0   && vminbinss numeric(11,2)
    this_nBaseMinimaCsll    = 0   && vminbcslls numeric(11,2)

    *-- Recolhimento Mensal (checkboxes)
    this_lMensalPis     = .F.   && bpisms numeric(1,0)
    this_lMensalCofins  = .F.   && bcofinms numeric(1,0)
    this_lMensalIrrf    = .F.   && birrfms numeric(1,0)
    this_lMensalInss    = .F.   && binssms numeric(1,0)
    this_lMensalCsll    = .F.   && bcsllms numeric(1,0)

    *-- Lancamento Financeiro (checkboxes)
    this_lLancFinPis     = .F.   && nlanfpiss numeric(1,0)
    this_lLancFinCofins  = .F.   && nlanfcofin numeric(1,0)
    this_lLancFinIrrf    = .F.   && nlanfirrfs numeric(1,0)
    this_lLancFinInss    = .F.   && nlanfinss numeric(1,0)
    this_lLancFinCsll    = .F.   && nlanfcslls numeric(1,0)
    this_lLancFinIss     = .F.   && nlanfiss numeric(1,0)

    *-- Codigos de Ocorrencia (F4 - crSigOpOco)
    this_cCodOcorPis     = ""   && cocorpiss char(10)
    this_cCodOcorCofins  = ""   && cocorcofin char(10)
    this_cCodOcorIrrf    = ""   && cocorirrfs char(10)
    this_cCodOcorInss    = ""   && cocorinss char(10)
    this_cCodOcorCsll    = ""   && cocorcslls char(10)
    this_cCodOcorIss     = ""   && cocoriss char(10)

    *-- Codigos reduzidos de imposto (nao exibidos no form legado, mas fazem parte da tabela)
    this_cCodCofins  = ""   && codcofinss char(5)
    this_cCodCsll    = ""   && codcslls char(5)
    this_cCodPis     = ""   && codpiss char(5)

    *-- Conta contabil principal (Get_grupoo / Get_contao / Get_dcontao)
    this_cGrupoContab  = ""   && cgrupo char(10)
    this_cContaContab  = ""   && ccontab char(10)

    *-- Grupo/Conta contabil por imposto (aba Vencimentos)
    this_cGrupoPis      = ""   && cgrppiss char(10)
    this_cContaPis      = ""   && cctapiss char(10)
    this_cGrupoCofins   = ""   && cgrpcofins char(10)
    this_cContaCofins   = ""   && cctacofins char(10)
    this_cGrupoIrrf     = ""   && cgrpirrfs char(10)
    this_cContaIrrf     = ""   && cctairrfs char(10)
    this_cGrupoInss     = ""   && cgrpinss char(10)
    this_cContaInss     = ""   && cctainss char(10)
    this_cGrupoCsll     = ""   && cgrpcslls char(10)
    this_cContaCsll     = ""   && cctacslls char(10)
    this_cGrupoIss      = ""   && cgrpiss char(10)
    this_cContaIss      = ""   && cctaiss char(10)

    *-- Opcao de vencimento por imposto (OptionGroup 1/2/3)
    this_nVencimentoPis      = 0   && vcpis numeric(1,0)
    this_nVencimentoCofins   = 0   && vccofins numeric(1,0)
    this_nVencimentoIrrf     = 0   && vcirrf numeric(1,0)
    this_nVencimentoInss     = 0   && vcinss numeric(1,0)
    this_nVencimentoCsll     = 0   && vccsll numeric(1,0)
    this_nVencimentoIss      = 0   && vciss numeric(1,0)

    *-- RPA (Recibo de Pagamento Autonomo)
    this_nRPA                     = 0   && nrpas numeric(1,0) - OptionGroup S/N
    this_nValorMaximoRetencaoInss = 0   && maxretinss numeric(11,2)
    this_cCodRecCofins            = ""   && codreccof char(5)
    this_cCodRecPis               = ""   && codrecpis char(5)
    this_cCodRecCsll              = ""   && codreccsll char(5)
    this_cCodRecIrrf              = ""   && codrecirrf char(5)

    *-- Detalhe: produtos do servico (SigSeRvp) - gerenciado via cursor proprio
    this_cCursorProdutos = "cursor_4c_Produtos"   && cursor local do grid de produtos (codservs, cpros)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSrv"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SRVBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna PK para auditoria (RegistrarAuditoria)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta todas as propriedades para novo registro
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        *-- this_cTipo NAO eh resetado: contexto Saidas/Entradas definido pelo Form

        THIS.this_nAliquotaPis    = 0
        THIS.this_nAliquotaCofins = 0
        THIS.this_nAliquotaIrrf   = 0
        THIS.this_nAliquotaInss   = 0
        THIS.this_nAliquotaCsll   = 0
        THIS.this_nAliquotaIss    = 0

        THIS.this_nValorMinimoPis    = 0
        THIS.this_nValorMinimoCofins = 0
        THIS.this_nValorMinimoIrrf   = 0
        THIS.this_nValorMinimoInss   = 0
        THIS.this_nValorMinimoCsll   = 0

        THIS.this_nBaseMinimaPis    = 0
        THIS.this_nBaseMinimaCofins = 0
        THIS.this_nBaseMinimaIrrf   = 0
        THIS.this_nBaseMinimaInss   = 0
        THIS.this_nBaseMinimaCsll   = 0

        THIS.this_lMensalPis    = .F.
        THIS.this_lMensalCofins = .F.
        THIS.this_lMensalIrrf   = .F.
        THIS.this_lMensalInss   = .F.
        THIS.this_lMensalCsll   = .F.

        THIS.this_lLancFinPis    = .F.
        THIS.this_lLancFinCofins = .F.
        THIS.this_lLancFinIrrf   = .F.
        THIS.this_lLancFinInss   = .F.
        THIS.this_lLancFinCsll   = .F.
        THIS.this_lLancFinIss    = .F.

        THIS.this_cCodOcorPis    = ""
        THIS.this_cCodOcorCofins = ""
        THIS.this_cCodOcorIrrf   = ""
        THIS.this_cCodOcorInss   = ""
        THIS.this_cCodOcorCsll   = ""
        THIS.this_cCodOcorIss    = ""

        THIS.this_cCodCofins = ""
        THIS.this_cCodCsll   = ""
        THIS.this_cCodPis    = ""

        THIS.this_cGrupoContab = ""
        THIS.this_cContaContab = ""

        THIS.this_cGrupoPis    = ""
        THIS.this_cContaPis    = ""
        THIS.this_cGrupoCofins = ""
        THIS.this_cContaCofins = ""
        THIS.this_cGrupoIrrf   = ""
        THIS.this_cContaIrrf   = ""
        THIS.this_cGrupoInss   = ""
        THIS.this_cContaInss   = ""
        THIS.this_cGrupoCsll   = ""
        THIS.this_cContaCsll   = ""
        THIS.this_cGrupoIss    = ""
        THIS.this_cContaIss    = ""

        THIS.this_nVencimentoPis    = 0
        THIS.this_nVencimentoCofins = 0
        THIS.this_nVencimentoIrrf   = 0
        THIS.this_nVencimentoInss   = 0
        THIS.this_nVencimentoCsll   = 0
        THIS.this_nVencimentoIss    = 0

        THIS.this_nRPA                     = 0
        THIS.this_nValorMaximoRetencaoInss = 0
        THIS.this_cCodRecCofins            = ""
        THIS.this_cCodRecPis               = ""
        THIS.this_cCodRecCsll              = ""
        THIS.this_cCodRecIrrf              = ""

        IF USED(THIS.this_cCursorProdutos)
            USE IN (THIS.this_cCursorProdutos)
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
        SET NULL OFF
    ENDPROC

    *====================================================================
    * Buscar - SELECT servicos do tipo atual (this_cTipo), filtro opcional
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos" + ;
                       " FROM SigCdSrv" + ;
                       " WHERE ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " AND (UPPER(codservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")" + ;
                    " OR UPPER(descservs) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + "))"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codservs"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar servicos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - SELECT registro por codigo (+ tipo atual) e produtos
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf" + ;
                " FROM SigCdSrv" + ;
                " WHERE codservs = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND ctipos = " + EscaparSQL(THIS.this_cTipo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                    THIS.CarregarProdutos(THIS.this_cCodigo)
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor para as
    * propriedades this_* (chamado por CarregarPorCodigo)
    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, "C"))
                THIS.this_cCodigo    = ALLTRIM(TratarNulo(codservs, "C"))
                THIS.this_cDescricao = ALLTRIM(TratarNulo(descservs, "C"))
                THIS.this_cTipo      = ALLTRIM(TratarNulo(ctipos, "C"))

                THIS.this_nAliquotaPis    = TratarNulo(apiss, "N")
                THIS.this_nAliquotaCofins = TratarNulo(acofinss, "N")
                THIS.this_nAliquotaIrrf   = TratarNulo(airrfs, "N")
                THIS.this_nAliquotaInss   = TratarNulo(ainss, "N")
                THIS.this_nAliquotaCsll   = TratarNulo(acslls, "N")
                THIS.this_nAliquotaIss    = TratarNulo(aiss, "N")

                THIS.this_nValorMinimoPis    = TratarNulo(vminpiss, "N")
                THIS.this_nValorMinimoCofins = TratarNulo(vmincofins, "N")
                THIS.this_nValorMinimoIrrf   = TratarNulo(vminirrfs, "N")
                THIS.this_nValorMinimoInss   = TratarNulo(vmininss, "N")
                THIS.this_nValorMinimoCsll   = TratarNulo(vmincslls, "N")

                THIS.this_nBaseMinimaPis    = TratarNulo(vminbpiss, "N")
                THIS.this_nBaseMinimaCofins = TratarNulo(vminbcofin, "N")
                THIS.this_nBaseMinimaIrrf   = TratarNulo(vminbirrfs, "N")
                THIS.this_nBaseMinimaInss   = TratarNulo(vminbinss, "N")
                THIS.this_nBaseMinimaCsll   = TratarNulo(vminbcslls, "N")

                THIS.this_lMensalPis    = (TratarNulo(bpisms, "N") = 1)
                THIS.this_lMensalCofins = (TratarNulo(bcofinms, "N") = 1)
                THIS.this_lMensalIrrf   = (TratarNulo(birrfms, "N") = 1)
                THIS.this_lMensalInss   = (TratarNulo(binssms, "N") = 1)
                THIS.this_lMensalCsll   = (TratarNulo(bcsllms, "N") = 1)

                THIS.this_lLancFinPis    = (TratarNulo(nlanfpiss, "N") = 1)
                THIS.this_lLancFinCofins = (TratarNulo(nlanfcofin, "N") = 1)
                THIS.this_lLancFinIrrf   = (TratarNulo(nlanfirrfs, "N") = 1)
                THIS.this_lLancFinInss   = (TratarNulo(nlanfinss, "N") = 1)
                THIS.this_lLancFinCsll   = (TratarNulo(nlanfcslls, "N") = 1)
                THIS.this_lLancFinIss    = (TratarNulo(nlanfiss, "N") = 1)

                THIS.this_cCodOcorPis    = ALLTRIM(TratarNulo(cocorpiss, "C"))
                THIS.this_cCodOcorCofins = ALLTRIM(TratarNulo(cocorcofin, "C"))
                THIS.this_cCodOcorIrrf   = ALLTRIM(TratarNulo(cocorirrfs, "C"))
                THIS.this_cCodOcorInss   = ALLTRIM(TratarNulo(cocorinss, "C"))
                THIS.this_cCodOcorCsll   = ALLTRIM(TratarNulo(cocorcslls, "C"))
                THIS.this_cCodOcorIss    = ALLTRIM(TratarNulo(cocoriss, "C"))

                THIS.this_cCodCofins = ALLTRIM(TratarNulo(codcofinss, "C"))
                THIS.this_cCodCsll   = ALLTRIM(TratarNulo(codcslls, "C"))
                THIS.this_cCodPis    = ALLTRIM(TratarNulo(codpiss, "C"))

                THIS.this_cGrupoContab = ALLTRIM(TratarNulo(cgrupo, "C"))
                THIS.this_cContaContab = ALLTRIM(TratarNulo(ccontab, "C"))

                THIS.this_cGrupoPis    = ALLTRIM(TratarNulo(cgrppiss, "C"))
                THIS.this_cContaPis    = ALLTRIM(TratarNulo(cctapiss, "C"))
                THIS.this_cGrupoCofins = ALLTRIM(TratarNulo(cgrpcofins, "C"))
                THIS.this_cContaCofins = ALLTRIM(TratarNulo(cctacofins, "C"))
                THIS.this_cGrupoIrrf   = ALLTRIM(TratarNulo(cgrpirrfs, "C"))
                THIS.this_cContaIrrf   = ALLTRIM(TratarNulo(cctairrfs, "C"))
                THIS.this_cGrupoInss   = ALLTRIM(TratarNulo(cgrpinss, "C"))
                THIS.this_cContaInss   = ALLTRIM(TratarNulo(cctainss, "C"))
                THIS.this_cGrupoCsll   = ALLTRIM(TratarNulo(cgrpcslls, "C"))
                THIS.this_cContaCsll   = ALLTRIM(TratarNulo(cctacslls, "C"))
                THIS.this_cGrupoIss    = ALLTRIM(TratarNulo(cgrpiss, "C"))
                THIS.this_cContaIss    = ALLTRIM(TratarNulo(cctaiss, "C"))

                THIS.this_nVencimentoPis    = TratarNulo(vcpis, "N")
                THIS.this_nVencimentoCofins = TratarNulo(vccofins, "N")
                THIS.this_nVencimentoIrrf   = TratarNulo(vcirrf, "N")
                THIS.this_nVencimentoInss   = TratarNulo(vcinss, "N")
                THIS.this_nVencimentoCsll   = TratarNulo(vccsll, "N")
                THIS.this_nVencimentoIss    = TratarNulo(vciss, "N")

                THIS.this_nRPA                     = TratarNulo(nrpas, "N")
                THIS.this_nValorMaximoRetencaoInss = TratarNulo(maxretinss, "N")
                THIS.this_cCodRecCofins            = ALLTRIM(TratarNulo(codreccof, "C"))
                THIS.this_cCodRecPis               = ALLTRIM(TratarNulo(codrecpis, "C"))
                THIS.this_cCodRecCsll              = ALLTRIM(TratarNulo(codreccsll, "C"))
                THIS.this_cCodRecIrrf              = ALLTRIM(TratarNulo(codrecirrf, "C"))

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Inserir - INSERT INTO SigCdSrv (todas as colunas) + produtos
    *====================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdSrv" + ;
                " (cidchaves, codservs, descservs, ctipos," + ;
                " apiss, acofinss, airrfs, ainss, aiss, acslls," + ;
                " vminpiss, vmincofins, vminirrfs, vmininss, vmincslls," + ;
                " vminbpiss, vminbcofin, vminbirrfs, vminbinss, vminbcslls," + ;
                " bpisms, bcofinms, birrfms, binssms, bcsllms," + ;
                " nlanfpiss, nlanfcofin, nlanfirrfs, nlanfinss, nlanfcslls, nlanfiss," + ;
                " cocorpiss, cocorcofin, cocorirrfs, cocorinss, cocorcslls, cocoriss," + ;
                " codpiss, codcslls, codcofinss, cgrupo, ccontab," + ;
                " cgrppiss, cctapiss, cgrpcofins, cctacofins, cgrpirrfs, cctairrfs," + ;
                " cgrpinss, cctainss, cgrpcslls, cctacslls, cgrpiss, cctaiss," + ;
                " vcpis, vccofins, vcirrf, vcinss, vccsll, vciss," + ;
                " nrpas, maxretinss, codreccof, codrecpis, codreccsll, codrecirrf)"

            loc_cSQL = loc_cSQL + " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cCodigo) + ", " + ;
                EscaparSQL(THIS.this_cDescricao) + ", " + ;
                EscaparSQL(THIS.this_cTipo) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nAliquotaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaIss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMinimoCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + ", " + ;
                FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodOcorPis) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIrrf) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorInss) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodOcorIss) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodPis) + ", " + ;
                EscaparSQL(THIS.this_cCodCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoContab) + ", " + ;
                EscaparSQL(THIS.this_cContaContab) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoPis) + ", " + ;
                EscaparSQL(THIS.this_cContaPis) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCofins) + ", " + ;
                EscaparSQL(THIS.this_cContaCofins) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIrrf) + ", " + ;
                EscaparSQL(THIS.this_cContaIrrf) + ","

            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupoInss) + ", " + ;
                EscaparSQL(THIS.this_cContaInss) + ", " + ;
                EscaparSQL(THIS.this_cGrupoCsll) + ", " + ;
                EscaparSQL(THIS.this_cContaCsll) + ", " + ;
                EscaparSQL(THIS.this_cGrupoIss) + ", " + ;
                EscaparSQL(THIS.this_cContaIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVencimentoPis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCofins) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoInss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoCsll) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVencimentoIss) + ","

            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nRPA) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCofins) + ", " + ;
                EscaparSQL(THIS.this_cCodRecPis) + ", " + ;
                EscaparSQL(THIS.this_cCodRecCsll) + ", " + ;
                EscaparSQL(THIS.this_cCodRecIrrf) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico inserido mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE SigCdSrv (todas as colunas editaveis) + produtos
    *====================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdSrv SET" + ;
                " descservs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " apiss = " + FormatarNumeroSQL(THIS.this_nAliquotaPis) + "," + ;
                " acofinss = " + FormatarNumeroSQL(THIS.this_nAliquotaCofins) + "," + ;
                " airrfs = " + FormatarNumeroSQL(THIS.this_nAliquotaIrrf) + "," + ;
                " ainss = " + FormatarNumeroSQL(THIS.this_nAliquotaInss) + "," + ;
                " aiss = " + FormatarNumeroSQL(THIS.this_nAliquotaIss) + "," + ;
                " acslls = " + FormatarNumeroSQL(THIS.this_nAliquotaCsll) + "," + ;
                " vminpiss = " + FormatarNumeroSQL(THIS.this_nValorMinimoPis) + "," + ;
                " vmincofins = " + FormatarNumeroSQL(THIS.this_nValorMinimoCofins) + "," + ;
                " vminirrfs = " + FormatarNumeroSQL(THIS.this_nValorMinimoIrrf) + "," + ;
                " vmininss = " + FormatarNumeroSQL(THIS.this_nValorMinimoInss) + "," + ;
                " vmincslls = " + FormatarNumeroSQL(THIS.this_nValorMinimoCsll)

            loc_cSQL = loc_cSQL + "," + ;
                " vminbpiss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaPis) + "," + ;
                " vminbcofin = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCofins) + "," + ;
                " vminbirrfs = " + FormatarNumeroSQL(THIS.this_nBaseMinimaIrrf) + "," + ;
                " vminbinss = " + FormatarNumeroSQL(THIS.this_nBaseMinimaInss) + "," + ;
                " vminbcslls = " + FormatarNumeroSQL(THIS.this_nBaseMinimaCsll) + "," + ;
                " bpisms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalPis, 1, 0)) + "," + ;
                " bcofinms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCofins, 1, 0)) + "," + ;
                " birrfms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalIrrf, 1, 0)) + "," + ;
                " binssms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalInss, 1, 0)) + "," + ;
                " bcsllms = " + FormatarNumeroSQL(IIF(THIS.this_lMensalCsll, 1, 0))

            loc_cSQL = loc_cSQL + "," + ;
                " nlanfpiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinPis, 1, 0)) + "," + ;
                " nlanfcofin = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCofins, 1, 0)) + "," + ;
                " nlanfirrfs = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIrrf, 1, 0)) + "," + ;
                " nlanfinss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinInss, 1, 0)) + "," + ;
                " nlanfcslls = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinCsll, 1, 0)) + "," + ;
                " nlanfiss = " + FormatarNumeroSQL(IIF(THIS.this_lLancFinIss, 1, 0)) + "," + ;
                " cocorpiss = " + EscaparSQL(THIS.this_cCodOcorPis) + "," + ;
                " cocorcofin = " + EscaparSQL(THIS.this_cCodOcorCofins) + "," + ;
                " cocorirrfs = " + EscaparSQL(THIS.this_cCodOcorIrrf) + "," + ;
                " cocorinss = " + EscaparSQL(THIS.this_cCodOcorInss)

            loc_cSQL = loc_cSQL + "," + ;
                " cocorcslls = " + EscaparSQL(THIS.this_cCodOcorCsll) + "," + ;
                " cocoriss = " + EscaparSQL(THIS.this_cCodOcorIss) + "," + ;
                " codpiss = " + EscaparSQL(THIS.this_cCodPis) + "," + ;
                " codcslls = " + EscaparSQL(THIS.this_cCodCsll) + "," + ;
                " codcofinss = " + EscaparSQL(THIS.this_cCodCofins) + "," + ;
                " cgrupo = " + EscaparSQL(THIS.this_cGrupoContab) + "," + ;
                " ccontab = " + EscaparSQL(THIS.this_cContaContab) + "," + ;
                " cgrppiss = " + EscaparSQL(THIS.this_cGrupoPis) + "," + ;
                " cctapiss = " + EscaparSQL(THIS.this_cContaPis) + "," + ;
                " cgrpcofins = " + EscaparSQL(THIS.this_cGrupoCofins)

            loc_cSQL = loc_cSQL + "," + ;
                " cctacofins = " + EscaparSQL(THIS.this_cContaCofins) + "," + ;
                " cgrpirrfs = " + EscaparSQL(THIS.this_cGrupoIrrf) + "," + ;
                " cctairrfs = " + EscaparSQL(THIS.this_cContaIrrf) + "," + ;
                " cgrpinss = " + EscaparSQL(THIS.this_cGrupoInss) + "," + ;
                " cctainss = " + EscaparSQL(THIS.this_cContaInss) + "," + ;
                " cgrpcslls = " + EscaparSQL(THIS.this_cGrupoCsll) + "," + ;
                " cctacslls = " + EscaparSQL(THIS.this_cContaCsll) + "," + ;
                " cgrpiss = " + EscaparSQL(THIS.this_cGrupoIss) + "," + ;
                " cctaiss = " + EscaparSQL(THIS.this_cContaIss) + "," + ;
                " vcpis = " + FormatarNumeroSQL(THIS.this_nVencimentoPis)

            loc_cSQL = loc_cSQL + "," + ;
                " vccofins = " + FormatarNumeroSQL(THIS.this_nVencimentoCofins) + "," + ;
                " vcirrf = " + FormatarNumeroSQL(THIS.this_nVencimentoIrrf) + "," + ;
                " vcinss = " + FormatarNumeroSQL(THIS.this_nVencimentoInss) + "," + ;
                " vccsll = " + FormatarNumeroSQL(THIS.this_nVencimentoCsll) + "," + ;
                " vciss = " + FormatarNumeroSQL(THIS.this_nVencimentoIss) + "," + ;
                " nrpas = " + FormatarNumeroSQL(THIS.this_nRPA) + "," + ;
                " maxretinss = " + FormatarNumeroSQL(THIS.this_nValorMaximoRetencaoInss) + "," + ;
                " codreccof = " + EscaparSQL(THIS.this_cCodRecCofins) + "," + ;
                " codrecpis = " + EscaparSQL(THIS.this_cCodRecPis) + "," + ;
                " codreccsll = " + EscaparSQL(THIS.this_cCodRecCsll) + "," + ;
                " codrecirrf = " + EscaparSQL(THIS.this_cCodRecIrrf)

            loc_cSQL = loc_cSQL + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarProdutos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Servico atualizado mas erro ao salvar produtos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar servico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE SigSeRvp (produtos) + DELETE SigCdSrv
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove produtos relacionados primeiro
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(THIS.this_cCodigo)

            IF USED("cursor_4c_DelProd")
                TABLEREVERT(.T., "cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProd")
            IF USED("cursor_4c_DelProd")
                USE IN cursor_4c_DelProd
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdSrv WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)

                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * CarregarProdutos - Carrega produtos do servico (SigSeRvp) no cursor
    * do grid (this_cCursorProdutos), com descricao via JOIN SigCdPro
    *====================================================================
    FUNCTION CarregarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorProdutos)
                USE IN (THIS.this_cCursorProdutos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (CidChaves C(20), CodServs C(10), CPros C(14), DPros C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves AS CidChaves, a.codservs AS CodServs," + ;
                           " a.cpros AS CPros, b.dpros AS DPros" + ;
                           " FROM SigSeRvp a" + ;
                           " LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                           " WHERE a.codservs = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_ProdTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdTmp")
                    USE IN cursor_4c_ProdTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Produtos
                    APPEND FROM DBF("cursor_4c_ProdTmp")
                    IF USED("cursor_4c_ProdTmp")
                        USE IN cursor_4c_ProdTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar produtos do servico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            GO TOP IN cursor_4c_Produtos
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.CarregarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * SalvarProdutos - Persiste cursor_4c_Produtos em SigSeRvp
    * (remove todos os produtos do servico e reinsere os atuais)
    *====================================================================
    PROTECTED FUNCTION SalvarProdutos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aProdutos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os produtos existentes para este servico
            loc_cSQL = "DELETE FROM SigSeRvp WHERE codservs = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_DelProdSalvar")
                TABLEREVERT(.T., "cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelProdSalvar")
            IF USED("cursor_4c_DelProdSalvar")
                USE IN cursor_4c_DelProdSalvar
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar produtos do servico:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta codigos de produto nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorProdutos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorProdutos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aProdutos[loc_nTotal]
                        SELECT (THIS.this_cCursorProdutos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aProdutos[loc_nI] = ALLTRIM(cursor_4c_Produtos.CPros)
                            IF !EOF(THIS.this_cCursorProdutos)
                                SKIP IN (THIS.this_cCursorProdutos)
                            ENDIF
                        ENDFOR

                        *-- Insere os produtos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aProdutos[loc_nI])
                                loc_cSQL = "INSERT INTO SigSeRvp (cidchaves, codservs, cpros)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(fUniqueIds()) + ", " + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + ", " + ;
                                           EscaparSQL(loc_aProdutos[loc_nI]) + ")"

                                IF USED("cursor_4c_InsProd")
                                    TABLEREVERT(.T., "cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsProd")
                                IF USED("cursor_4c_InsProd")
                                    USE IN cursor_4c_InsProd
                                ENDIF

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir produto " + loc_aProdutos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SRVBO.SalvarProdutos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

