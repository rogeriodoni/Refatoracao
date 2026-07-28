# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdCfo.codigos"
  ControlSource = "crSigCdCfo.Ndigitos"
  ControlSource = "crSigCdCfo.descricaos"
  ControlSource = "crSigCdCfo.Desc2s"
  ControlSource = "crSigCdCfo.InclIPIs"
  ControlSource = "crSigCdCfo.tipos"
  ControlSource = "crSigCdCfo.AliqII"
  ControlSource = "crSigCdCfo.AliqISSQN"
  ControlSource = "crSigCdCfo.IcmsIncs"
  ControlSource = "crSigCdCfo.InclIcms"
  ControlSource = "crSigCdCfo.IpiNCreds"
  ControlSource = "crSigCdCfo.Transps"
  ControlSource = "crSigCdCfo.aliqipis"
  ControlSource = "crSigCdCfo.icmsdscs"
  ControlSource = "crSigCdCfo.cfost60s"
  ControlSource = "crSigCdCfo.pbcipis"
  ControlSource = "crSigCdCfo.Ipi_Icms"
  ControlSource = "crSigCdCfo.cgergia1s"
  ControlSource = "crSigCdCfo.ISSQNL"
  ControlSource = "crSigCdCfo.COFCST"
  ControlSource = "crSigCdCfo.PISCST"
  ControlSource = "crSigCdCfo.IPICST"
  ControlSource = "crSigCdCfo.aliqivcs"
  ControlSource = "crSigCdCfo.pbcsts"
  ControlSource = "crSigCdCfo.coddests"
  ControlSource = "crSigCdCfo.cfosts"
  ControlSource = "crSigCdCfo.sittribs"
  ControlSource = "crSigCdCfo.AliqPIS"
  ControlSource = "crSigCdCfo.AliqCOFINS"
  ControlSource = "crSigCdCfo.enqipi"
  ControlSource = "crSigCdCfo.situas"
  ControlSource = "crSigCdCfo.Frticms"
  ControlSource = "crSigCdCfo.SegIcms"
  ControlSource = "crSigCdCfo.DesIcms"
  ControlSource = "crSigCdCfo.FrtIpis"
  ControlSource = "crSigCdCfo.SegIpis"
  ControlSource = "crSigCdCfo.DesIpis"
  ControlSource = "crSigCdCfo.IncIcmNFs"
  ControlSource = "crSigCdCfo.CTISSQN"
  ControlSource = "crSigCdCfo.RetTribs"
  ControlSource = "crSigCdCfo.contipcs"
  ControlSource = "crSigCdCfo.contipds"
  ControlSource = "crSigCdCfo.PonteDescs"
  ControlSource = "crSigCdCfo.agrupas"
  ControlSource = "crSigCdCfo.zeradas"
  ControlSource = "crSigCdCfo.dtintfis"
  ControlSource = "crSigCdCfo.utilvars"
  ControlSource = "crSigCdCfo.contvcds"
  ControlSource = "crSigCdCfo.contvccs"
  ControlSource = "crSigCdCfo.conticds"
  ControlSource = "crSigCdCfo.contfrt"
  ControlSource = "crSigCdCfo.contseg"
  ControlSource = "crSigCdCfo.contda"
  ControlSource = "crSigCdCfo.conticcs"
  ControlSource = "crSigCdCfo.intvlrcont"
  ControlSource = "crSigCdCfo.intvlricms"
  ControlSource = "crSigCdCfo.intvlripi"
  ControlSource = "crSigCdCfo.IndMov"
  ControlSource = "crSigCdCfo.IndPagto"
Select CrSigCdCfo
select CrSigCdCfo
	Select crSigCdCfo
Select crSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS SQL (3903 linhas total):

*-- Linhas 361 a 379:
361:             .HighlightBackColor = RGB(255, 255, 255)
362:             .HighlightForeColor = RGB(15, 41, 104)
363:             .HighlightStyle     = 2
364:             .DeleteMark         = .F.
365:             .RecordMark         = .F.
366:             .RowHeight          = 16
367:             .ScrollBars         = 2
368:             .GridLines          = 3
369:             .ReadOnly           = .T.
370:             .ColumnCount        = 2
371:             .Visible            = .T.
372:         ENDWITH
373: 
374:         *-- BINDEVENTs para botoes CRUD e auxiliares
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")

*-- Linhas 2991 a 3010:
2991:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
2992:                     loc_oGrid.ColumnCount  = 2
2993: 
2994:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
2995:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
2996: 
2997:                     loc_oGrid.Column1.Width = 80
2998:                     loc_oGrid.Column2.Width = 400
2999: 
3000:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3001:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3002: 
3003:                     *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
3004:                     loc_oGrid.SetAll("DynamicForeColor", ;
3005:                         "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")
3006: 
3007:                     THIS.FormatarGridLista(loc_oGrid)
3008:                     loc_oGrid.Refresh()
3009:                     loc_lResultado = .T.
3010:                 ENDIF

*-- Linhas 3065 a 3083:
3065:             MsgAviso("Nenhum registro selecionado.", "")
3066:             RETURN
3067:         ENDIF
3068:         SELECT cursor_4c_Dados
3069:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3070:         IF EMPTY(loc_cCodigo)
3071:             MsgAviso("Nenhum registro selecionado.", "")
3072:             RETURN
3073:         ENDIF
3074:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3075:             THIS.BOParaForm()
3076:             THIS.this_cModoAtual = "VISUALIZAR"
3077:             THIS.HabilitarCampos(.F.)
3078:             THIS.AjustarBotoesPorModo()
3079:             THIS.AlternarPagina(2)
3080:         ELSE
3081:             MsgErro("Erro ao carregar registro.", "Erro")
3082:         ENDIF
3083:     ENDPROC

*-- Linhas 3091 a 3109:
3091:             MsgAviso("Nenhum registro selecionado.", "")
3092:             RETURN
3093:         ENDIF
3094:         SELECT cursor_4c_Dados
3095:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3096:         IF EMPTY(loc_cCodigo)
3097:             MsgAviso("Nenhum registro selecionado.", "")
3098:             RETURN
3099:         ENDIF
3100:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3101:             THIS.this_oBusinessObject.EditarRegistro()
3102:             THIS.BOParaForm()
3103:             THIS.this_cModoAtual = "ALTERAR"
3104:             THIS.HabilitarCampos(.T.)
3105:             THIS.AjustarBotoesPorModo()
3106:             THIS.AlternarPagina(2)
3107:         ELSE
3108:             MsgErro("Erro ao carregar CFOP para altera" + CHR(231) + CHR(227) + "o.", "Erro")
3109:         ENDIF

*-- Linhas 3118 a 3136:
3118:             MsgAviso("Nenhum registro selecionado.", "")
3119:             RETURN
3120:         ENDIF
3121:         SELECT cursor_4c_Dados
3122:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3123:         IF EMPTY(loc_cCodigo)
3124:             MsgAviso("Nenhum registro selecionado.", "")
3125:             RETURN
3126:         ENDIF
3127:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do CFOP " + ;
3128:             loc_cCodigo + "?", "Confirmar Exclus" + CHR(227) + CHR(227) + "o")
3129:         IF loc_lConfirmado
3130:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3131:                 IF THIS.this_oBusinessObject.Excluir()
3132:                     MsgInfo("CFOP exclu" + CHR(237) + "do com sucesso!", "Sucesso")
3133:                     THIS.CarregarLista()
3134:                 ELSE
3135:                     MsgErro("Erro ao excluir CFOP.", "Erro")
3136:                 ENDIF

*-- Linhas 3156 a 3177:
3156:                 loc_oBusca.Show()
3157: 
3158:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
3159:                     SELECT cursor_4c_BuscaCfo
3160:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfo.codigos)
3161:                     IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
3162:                         SELECT cursor_4c_Dados
3163:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3164:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3165:                     ENDIF
3166:                 ENDIF
3167:                 loc_oBusca.Release()
3168:             ENDIF
3169:         CATCH TO loc_oErro
3170:             MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
3171:         ENDTRY
3172: 
3173:         IF USED("cursor_4c_BuscaCfo")
3174:             USE IN cursor_4c_BuscaCfo
3175:         ENDIF
3176:     ENDPROC
3177: 

*-- Linhas 3184 a 3234:
3184:             MsgAviso("Selecione um CFOP na lista.", "")
3185:             RETURN
3186:         ENDIF
3187:         SELECT cursor_4c_Dados
3188:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3189:         IF EMPTY(loc_cCodigo)
3190:             MsgAviso("Selecione um CFOP na lista.", "")
3191:             RETURN
3192:         ENDIF
3193:         TRY
3194:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
3195:             THIS.CarregarLista()
3196:             IF USED("cursor_4c_Dados")
3197:                 SELECT cursor_4c_Dados
3198:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3199:             ENDIF
3200:         CATCH TO loc_oErro
3201:             MsgErro("Erro ao exportar XML:" + CHR(13) + loc_oErro.Message, "Erro")
3202:         ENDTRY
3203:     ENDPROC
3204: 
3205:     *==========================================================================
3206:     * BtnImpXMLClick - Importa XML de CFOP (PUBLIC para BINDEVENT)
3207:     *==========================================================================
3208:     PROCEDURE BtnImpXMLClick()
3209:         LOCAL loc_cCodigo
3210:         loc_cCodigo = ""
3211:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3212:             SELECT cursor_4c_Dados
3213:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
3214:         ENDIF
3215:         TRY
3216:             DO FORM SigOpXml WITH THIS, "", "I", "CFOP", 10
3217:             THIS.CarregarLista()
3218:             IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodigo)
3219:                 SELECT cursor_4c_Dados
3220:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3221:             ENDIF
3222:         CATCH TO loc_oErro
3223:             MsgErro("Erro ao importar XML:" + CHR(13) + loc_oErro.Message, "Erro")
3224:         ENDTRY
3225:     ENDPROC
3226: 
3227:     *==========================================================================
3228:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
3229:     *==========================================================================
3230:     PROTECTED PROCEDURE FormParaBO()
3231:         LOCAL loc_oBO, loc_oPage1, loc_oPage2
3232:         TRY
3233:             loc_oBO    = THIS.this_oBusinessObject
3234:             loc_oPage1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

*-- Linhas 3458 a 3478:
3458:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
3459:         IF loc_lProsseguir AND THIS.this_cModoAtual = "INCLUIR"
3460:             TRY
3461:                 loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo WHERE codigos = " + ;
3462:                     EscaparSQL(loc_cCodigo)
3463:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCfo")
3464:                 IF loc_nRet >= 0 AND NVL(cursor_4c_DupCfo.nExiste, 0) > 0
3465:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "")
3466:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.txt_4c_Codigo.SetFocus()
3467:                     loc_lProsseguir = .F.
3468:                 ENDIF
3469:                 IF USED("cursor_4c_DupCfo")
3470:                     USE IN cursor_4c_DupCfo
3471:                 ENDIF
3472:             CATCH TO loc_oErro
3473:                 IF USED("cursor_4c_DupCfo")
3474:                     USE IN cursor_4c_DupCfo
3475:                 ENDIF
3476:                 MsgErro(loc_oErro.Message, "Erro ao verificar duplicidade")
3477:                 loc_lProsseguir = .F.
3478:             ENDTRY

*-- Linhas 3633 a 3651:
3633:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3634:                 loc_oLookup.Show()
3635:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3636:                     SELECT cursor_4c_BuscaCfoST60
3637:                     loc_oPagDados1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3638:                 ENDIF
3639:                 loc_oLookup.Release()
3640:             ENDIF
3641:         CATCH TO loc_oErro
3642:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST60")
3643:         ENDTRY
3644:         IF USED("cursor_4c_BuscaCfoST60")
3645:             USE IN cursor_4c_BuscaCfoST60
3646:         ENDIF
3647:     ENDPROC
3648: 
3649:     *==========================================================================
3650:     * CfoSTLookupKeyPress - F4/F5 abre lookup para txt_4c_CfoST (PUBLIC BINDEVENT)
3651:     *==========================================================================

*-- Linhas 3678 a 3696:
3678:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3679:                 loc_oLookup.Show()
3680:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3681:                     SELECT cursor_4c_BuscaCfoST
3682:                     loc_oPagDados1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3683:                 ENDIF
3684:                 loc_oLookup.Release()
3685:             ENDIF
3686:         CATCH TO loc_oErro
3687:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST")
3688:         ENDTRY
3689:         IF USED("cursor_4c_BuscaCfoST")
3690:             USE IN cursor_4c_BuscaCfoST
3691:         ENDIF
3692:     ENDPROC
3693: 
3694:     *==========================================================================
3695:     * CfdestLookupKeyPress - F4/F5 abre lookup para txt_4c_Cfdest (PUBLIC BINDEVENT)
3696:     *==========================================================================

*-- Linhas 3722 a 3740:
3722:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3723:                 loc_oLookup.Show()
3724:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3725:                     SELECT cursor_4c_BuscaCfdest
3726:                     loc_oPagDados1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3727:                 ENDIF
3728:                 loc_oLookup.Release()
3729:             ENDIF
3730:         CATCH TO loc_oErro
3731:             MsgErro(loc_oErro.Message, "Erro no Lookup Cfdest")
3732:         ENDTRY
3733:         IF USED("cursor_4c_BuscaCfdest")
3734:             USE IN cursor_4c_BuscaCfdest
3735:         ENDIF
3736:     ENDPROC
3737: 
3738:     *==========================================================================
3739:     * SittricmLookupKeyPress - F4/F5 abre lookup para txt_4c_Sittricm (PUBLIC BINDEVENT)
3740:     *==========================================================================

*-- Linhas 3767 a 3785:
3767:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3768:                 loc_oLookup.Show()
3769:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
3770:                     SELECT cursor_4c_BuscaSittricm
3771:                     loc_oPagDados1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
3772:                 ENDIF
3773:                 loc_oLookup.Release()
3774:             ENDIF
3775:         CATCH TO loc_oErro
3776:             MsgErro(loc_oErro.Message, "Erro no Lookup Sittricm")
3777:         ENDTRY
3778:         IF USED("cursor_4c_BuscaSittricm")
3779:             USE IN cursor_4c_BuscaSittricm
3780:         ENDIF
3781:     ENDPROC
3782: 
3783:     *==========================================================================
3784:     * FormatarGridLista - Formata visual do Grid da lista
3785:     *==========================================================================

*-- Linhas 3815 a 3834:
3815:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContFrt.Value)
3816:         IF !EMPTY(loc_cConta)
3817:             TRY
3818:                 loc_cSQL = "SELECT TOP 1 iClis FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta)
3819:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContFrtVal")
3820:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContFrtVal") OR EOF("cursor_4c_ContFrtVal")
3821:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3822:                     loc_oPg2.txt_4c_ContFrt.Value = ""
3823:                 ENDIF
3824:                 IF USED("cursor_4c_ContFrtVal")
3825:                     USE IN cursor_4c_ContFrtVal
3826:                 ENDIF
3827:             CATCH TO loc_oErro
3828:                 IF USED("cursor_4c_ContFrtVal")
3829:                     USE IN cursor_4c_ContFrtVal
3830:                 ENDIF
3831:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Frete")
3832:             ENDTRY
3833:         ENDIF
3834:     ENDPROC

*-- Linhas 3842 a 3861:
3842:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContSeg.Value)
3843:         IF !EMPTY(loc_cConta)
3844:             TRY
3845:                 loc_cSQL = "SELECT TOP 1 iClis FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta)
3846:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContSegVal")
3847:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContSegVal") OR EOF("cursor_4c_ContSegVal")
3848:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3849:                     loc_oPg2.txt_4c_ContSeg.Value = ""
3850:                 ENDIF
3851:                 IF USED("cursor_4c_ContSegVal")
3852:                     USE IN cursor_4c_ContSegVal
3853:                 ENDIF
3854:             CATCH TO loc_oErro
3855:                 IF USED("cursor_4c_ContSegVal")
3856:                     USE IN cursor_4c_ContSegVal
3857:                 ENDIF
3858:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Seguro")
3859:             ENDTRY
3860:         ENDIF
3861:     ENDPROC

*-- Linhas 3869 a 3888:
3869:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_ContDa.Value)
3870:         IF !EMPTY(loc_cConta)
3871:             TRY
3872:                 loc_cSQL = "SELECT TOP 1 iClis FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta)
3873:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContDaVal")
3874:                 IF loc_nRet < 0 OR !USED("cursor_4c_ContDaVal") OR EOF("cursor_4c_ContDaVal")
3875:                     MsgAviso("Conta n" + CHR(227) + "o cadastrada.", "")
3876:                     loc_oPg2.txt_4c_ContDa.Value = ""
3877:                 ENDIF
3878:                 IF USED("cursor_4c_ContDaVal")
3879:                     USE IN cursor_4c_ContDaVal
3880:                 ENDIF
3881:             CATCH TO loc_oErro
3882:                 IF USED("cursor_4c_ContDaVal")
3883:                     USE IN cursor_4c_ContDaVal
3884:                 ENDIF
3885:                 MsgErro(loc_oErro.Message, "Erro ao validar Conta Despesas")
3886:             ENDTRY
3887:         ENDIF
3888:     ENDPROC


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para Cadastro de CFOP
* Tabela: SigCdCfo
* Chave: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdCfo (mapeados diretamente do schema)
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCodigos    = ""    && codigos     char(10)  PK
    this_cDescricaos = ""    && descricaos  char(60)  Descricao nota fiscal
    this_cDesc2s     = ""    && desc2s      char(60)  Descricao consulta

    *-- Operacao e tipo
    this_cOperacaos  = ""    && operacaos   char(1)   E=Entrada S=Saida
    this_nTipos      = 0     && tipos       numeric(1,0)
    this_nNdigitos   = 0     && ndigitos    numeric(2,0)  Digitos para NF

    *-- ICMS
    this_cIcms       = ""    && icms        char(1)   T=Tributado I=Isento O=Outros N=N.Tributa
    this_cSittribs   = ""    && sittribs    char(3)   Situacao tributaria ICMS
    this_nAliqivcs   = 0     && aliqivcs    numeric(4,2)  Aliquota venda consumidor
    this_nInclicms   = 0     && inclicms    numeric(1,0)  Incluir ICMS na base
    this_nIcmsdscs   = 0     && icmsdscs    numeric(1,0)  ICMS incluso no preco
    this_nIcmsincs   = 0     && icmsincs    numeric(1,0)  Integrar valores ICMS
    this_nIncicmnfs  = 0     && incicmnfs   numeric(1,0)  Incluir ICMS no total da NF
    this_cCgergia1s  = ""    && cgergia1s   char(1)   Destaca ICMS na NF S/N
    this_nFrticms    = 0     && frticms     numeric(1,0)  Frete compoe base ICMS
    this_nSegicms    = 0     && segicms     numeric(1,0)  Seguro compoe base ICMS
    this_nDesicms    = 0     && desicms     numeric(1,0)  Despesas compoe base ICMS

    *-- Substituicao tributaria ICMS
    this_cSubtribs   = ""    && subtribs    char(1)   Substituicao tributaria S/N
    this_nPbcsts     = 0     && pbcsts      numeric(5,2)  % base ST
    this_cCfosts     = ""    && cfosts      char(10)  CFOP subst. tributaria
    this_cCoddests   = ""    && coddests    char(10)  CFOP destino
    this_nTransps    = 0     && transps     numeric(1,0)  CFOP transporte

    *-- IPI
    this_cIpis       = ""    && ipis        char(1)   T=Tributado I=Isento O=Outros
    this_cIpi_icms   = ""    && ipi_icms    char(1)   IPI sobre ICMS
    this_nInclipis   = 0     && inclipis    numeric(1,0)  Incluir IPI na base
    this_nPbcipis    = 0     && pbcipis     numeric(5,2)  % base IPI
    this_cBcipis     = ""    && bcipis      char(1)   Base de calculo IPI
    this_nAliqipis   = 0     && aliqipis    numeric(4,2)  Aliquota IPI
    this_cAcresipis  = ""    && acresipis   char(1)   Acrescenta na base
    this_cIpiimpors  = ""    && ipiimpors   char(1)   IPI importacao
    this_cIpiom2s    = ""    && ipiom2s     char(1)   IPI calc. p/ origem mercadoria=2
    this_nFrtipis    = 0     && frtipis     numeric(1,0)  Frete compoe base IPI
    this_nSegipis    = 0     && segipis     numeric(1,0)  Seguro compoe base IPI
    this_nDesipis    = 0     && desipis     numeric(1,0)  Despesas compoe base IPI
    this_nIpincreds  = 0     && ipincreds   numeric(1,0)  IPI nao creditado
    this_nPontedescs = 0     && pontedescs  numeric(1,0)  Retira IPI do valor
    this_cIpicst     = ""    && ipicst      char(2)   Codigo IPI sit. tributaria NF-e
    this_cIpienq     = ""    && ipienq      char(3)   Enquadramento IPI
    this_cUnitimps   = ""    && unitimps    char(1)   Inibe valor unitario NF importacao

    *-- PIS / COFINS / ISSQN / II
    this_cPiscst     = ""    && piscst      char(2)   Codigo PIS sit. tributaria
    this_cCofcst     = ""    && cofcst      char(2)   Codigo COFINS sit. tributaria
    this_cIssqnl     = ""    && issqnl      char(5)   Codigo ISSQN lista servicos
    this_nAliqpis    = 0     && aliqpis     numeric(5,2)  Aliquota PIS
    this_nAliqcofins = 0     && aliqcofins  numeric(5,2)  Aliquota COFINS
    this_nAliqissqn  = 0     && aliqissqn   numeric(5,2)  Aliquota ISSQN
    this_nAliqii     = 0     && aliqii      numeric(5,2)  Aliquota II
    this_nCtissqn    = 0     && ctissqn     numeric(1,0)  Codigo tributacao ISSQN
    this_nRettribs   = 0     && rettribs    numeric(1,0)  Informa retencao de tributos

    *-- Contribuinte / Situacao
    this_cContribs   = ""    && contribs    char(1)   S=Sim N=Nao O=Outros
    this_nSituas     = 0     && situas      numeric(1,0)  0=Ativo 1=Inativo
    this_cCfost60s   = ""    && cfost60s    char(10)  CFOP ST60
    this_nSomaicmfrete = 0   && somaicmfrete numeric(1,0)
    this_cMotdeson   = ""    && motdeson    char(2)   Motivo desoneracao ICMS

    *-- Integracao Contabil - Contas DB/CR
    this_cContconts  = ""    && contconts   char(1)   Pega conta contabil da NF
    this_cContvcds   = ""    && contvcds    char(9)   Conta valor contabil DB
    this_cContvccs   = ""    && contvccs    char(9)   Conta valor contabil CR
    this_cContipds   = ""    && contipds    char(9)   Conta IPI DB
    this_cContipcs   = ""    && contipcs    char(9)   Conta IPI CR
    this_cConticds   = ""    && conticds    char(9)   Conta ICMS DB
    this_cConticcs   = ""    && conticcs    char(9)   Conta ICMS CR
    this_cContfrt    = ""    && contfrt     char(9)   Conta frete
    this_cContseg    = ""    && contseg     char(9)   Conta seguro
    this_cContda     = ""    && contda      char(9)   Conta despesas acessorias

    *-- Integracao Contabil - Opcoes
    this_nAgrupas    = 0     && agrupas     numeric(1,0)  Agrupa CFO na integracao
    this_nZeradas    = 0     && zeradas     numeric(1,0)  Integracao zerada
    this_nIntvlrcont = 0     && intvlrcont  numeric(1,0)  Integrar valor contabil
    this_nIntvlricms = 0     && intvlricms  numeric(1,0)  Integrar valores ICMS
    this_nIntvlripi  = 0     && intvlripi   numeric(1,0)  Integrar valores IPI
    this_nUtilvars   = 0     && utilvars    numeric(1,0)  Utilizar variacao CFOP
    this_nIndmov     = 0     && indmov      numeric(1,0)  Movimentacao fisica estoque
    this_nIndpagto   = 0     && indpagto    numeric(1,0)  Indicacao pagamento
    this_nTiporecs   = 0     && tiporecs    numeric(1,0)  Data lancamento contabil
    this_nObspads    = 0     && obspads     numeric(3,0)  Observacao padrao
    this_nDtintfis   = 0     && dtintfis    numeric(1,0)  Integracao fiscal

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cIpi_icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCols, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCols = "codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis"

            loc_cVals = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "INSERT INTO SigCdCfo (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSet, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSet = "descricaos = "  + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s = "             + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "operacaos = "          + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "tipos = "              + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "ndigitos = "           + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms = "               + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "sittribs = "           + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "aliqivcs = "           + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "inclicms = "           + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsdscs = "           + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "icmsincs = "           + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "incicmnfs = "          + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "cgergia1s = "          + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "frticms = "            + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms = "            + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "desicms = "            + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "subtribs = "           + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "pbcsts = "             + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "cfosts = "             + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests = "           + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "transps = "            + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "ipis = "               + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "ipi_icms = "           + EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                "inclipis = "           + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "pbcipis = "            + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "bcipis = "             + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "aliqipis = "           + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "acresipis = "          + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors = "          + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s = "            + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "frtipis = "            + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis = "            + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "desipis = "            + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "ipincreds = "          + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "pontedescs = "         + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "ipicst = "             + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "ipienq = "             + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "unitimps = "           + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "piscst = "             + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst = "             + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl = "             + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis = "            + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins = "         + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn = "          + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "aliqii = "             + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ctissqn = "            + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs = "           + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "contribs = "           + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "situas = "             + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "cfost60s = "           + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "somaicmfrete = "       + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "motdeson = "           + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "contconts = "          + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "contvcds = "           + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs = "           + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "contipds = "           + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs = "           + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "conticds = "           + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs = "           + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contfrt = "            + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg = "            + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda = "             + EscaparSQL(THIS.this_cContda) + ", " + ;
                "agrupas = "            + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas = "            + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "intvlrcont = "         + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms = "         + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi = "          + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "utilvars = "           + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "indmov = "             + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto = "           + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "tiporecs = "           + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads = "            + FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                "dtintfis = "           + FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "UPDATE SigCdCfo SET " + loc_cSet + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCfo WHERE codigos = " + ;
                EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, desc2s, operacaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, situas" + ;
                " FROM SigCdCfo"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                " FROM SigCdCfo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da nota fiscal obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

