# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 3011: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS GRID (3909 linhas total):

*-- Linhas 352 a 390:
352:         ENDWITH
353: 
354:         *-- Grid de lista (Grade no legado) - top=127+29=156 com compensacao PageFrame
355:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:         WITH loc_oPagina.grd_4c_Lista
357:             .Top                = 156
358:             .Left               = 11
359:             .Width              = 972
360:             .Height             = 520
361:             .FontName           = "Verdana"
362:             .FontSize           = 8
363:             .ForeColor          = RGB(90, 90, 90)
364:             .BackColor          = RGB(255, 255, 255)
365:             .GridLineColor      = RGB(238, 238, 238)
366:             .HighlightBackColor = RGB(255, 255, 255)
367:             .HighlightForeColor = RGB(15, 41, 104)
368:             .HighlightStyle     = 2
369:             .DeleteMark         = .F.
370:             .RecordMark         = .F.
371:             .RowHeight          = 16
372:             .ScrollBars         = 2
373:             .GridLines          = 3
374:             .ReadOnly           = .T.
375:             .ColumnCount        = 2
376:             .Visible            = .T.
377:         ENDWITH
378: 
379:         *-- BINDEVENTs para botoes CRUD e auxiliares
380:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
386:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
387:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
388: 
389:         THIS.TornarControlesVisiveis(loc_oPagina)
390:     ENDPROC

*-- Linhas 2990 a 3027:
2990:                 loc_lResultado = .T.
2991:             ELSE
2992:                 IF THIS.this_oBusinessObject.Buscar("")
2993:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2994: 
2995:                     loc_oGrid.ColumnCount = 2
2996: 
2997:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
2998:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
2999: 
3000:                     loc_oGrid.Column1.Width = 80
3001:                     loc_oGrid.Column2.Width = 400
3002: 
3003:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3004:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3005: 
3006:                     *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
3007:                     loc_oGrid.SetAll("DynamicForeColor", ;
3008:                         "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")
3009: 
3010:                     loc_oGrid.ColumnCount = 3
3011:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
3012: 
3013:                     THIS.FormatarGridLista(loc_oGrid)
3014:                     loc_oGrid.Refresh()
3015:                     loc_lResultado = .T.
3016:                 ENDIF
3017:             ENDIF
3018:         CATCH TO loc_oErro
3019:             MsgErro(loc_oErro.Message, "Erro em CarregarLista")
3020:             loc_lResultado = .F.
3021:         ENDTRY
3022: 
3023:         RETURN loc_lResultado
3024:     ENDPROC
3025: 
3026:     *==========================================================================
3027:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)

*-- Linhas 3157 a 3185:
3157:                 "Buscar CFOP")
3158: 
3159:             IF VARTYPE(loc_oBusca) = "O"
3160:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3161:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3162:                 loc_oBusca.Show()
3163: 
3164:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
3165:                     SELECT cursor_4c_BuscaCfo
3166:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfo.codigos)
3167:                     IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
3168:                         SELECT cursor_4c_Dados
3169:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
3170:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3171:                     ENDIF
3172:                 ENDIF
3173:                 loc_oBusca.Release()
3174:             ENDIF
3175:         CATCH TO loc_oErro
3176:             MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
3177:         ENDTRY
3178: 
3179:         IF USED("cursor_4c_BuscaCfo")
3180:             USE IN cursor_4c_BuscaCfo
3181:         ENDIF
3182:     ENDPROC
3183: 
3184:     *==========================================================================
3185:     * BtnExpXMLClick - Exporta XML do CFOP selecionado (PUBLIC para BINDEVENT)

*-- Linhas 3635 a 3654:
3635:                 "SigCdCfo", "cursor_4c_BuscaCfoST60", "codigos", ;
3636:                 ALLTRIM(loc_oPagDados1.txt_4c_CfoST60.Value), "CFOP - ST Trib.")
3637:             IF VARTYPE(loc_oLookup) = "O"
3638:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3639:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3640:                 loc_oLookup.Show()
3641:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3642:                     SELECT cursor_4c_BuscaCfoST60
3643:                     loc_oPagDados1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3644:                 ENDIF
3645:                 loc_oLookup.Release()
3646:             ENDIF
3647:         CATCH TO loc_oErro
3648:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST60")
3649:         ENDTRY
3650:         IF USED("cursor_4c_BuscaCfoST60")
3651:             USE IN cursor_4c_BuscaCfoST60
3652:         ENDIF
3653:     ENDPROC
3654: 

*-- Linhas 3680 a 3699:
3680:                 ALLTRIM(loc_oPagDados1.txt_4c_CfoST.Value), ;
3681:                 "CFOP - Substitui" + CHR(231) + CHR(227) + "o Trib.")
3682:             IF VARTYPE(loc_oLookup) = "O"
3683:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3684:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3685:                 loc_oLookup.Show()
3686:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3687:                     SELECT cursor_4c_BuscaCfoST
3688:                     loc_oPagDados1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3689:                 ENDIF
3690:                 loc_oLookup.Release()
3691:             ENDIF
3692:         CATCH TO loc_oErro
3693:             MsgErro(loc_oErro.Message, "Erro no Lookup CfoST")
3694:         ENDTRY
3695:         IF USED("cursor_4c_BuscaCfoST")
3696:             USE IN cursor_4c_BuscaCfoST
3697:         ENDIF
3698:     ENDPROC
3699: 

*-- Linhas 3724 a 3743:
3724:                 "SigCdCfo", "cursor_4c_BuscaCfdest", "codigos", ;
3725:                 ALLTRIM(loc_oPagDados1.txt_4c_Cfdest.Value), "CFOP - Destino")
3726:             IF VARTYPE(loc_oLookup) = "O"
3727:                 loc_oLookup.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3728:                 loc_oLookup.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3729:                 loc_oLookup.Show()
3730:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3731:                     SELECT cursor_4c_BuscaCfdest
3732:                     loc_oPagDados1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3733:                 ENDIF
3734:                 loc_oLookup.Release()
3735:             ENDIF
3736:         CATCH TO loc_oErro
3737:             MsgErro(loc_oErro.Message, "Erro no Lookup Cfdest")
3738:         ENDTRY
3739:         IF USED("cursor_4c_BuscaCfdest")
3740:             USE IN cursor_4c_BuscaCfdest
3741:         ENDIF
3742:     ENDPROC
3743: 

*-- Linhas 3769 a 3788:
3769:                 ALLTRIM(loc_oPagDados1.txt_4c_Sittricm.Value), ;
3770:                 "Situa" + CHR(231) + CHR(227) + "o Trib. ICMS")
3771:             IF VARTYPE(loc_oLookup) = "O"
3772:                 loc_oLookup.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
3773:                 loc_oLookup.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3774:                 loc_oLookup.Show()
3775:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
3776:                     SELECT cursor_4c_BuscaSittricm
3777:                     loc_oPagDados1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
3778:                 ENDIF
3779:                 loc_oLookup.Release()
3780:             ENDIF
3781:         CATCH TO loc_oErro
3782:             MsgErro(loc_oErro.Message, "Erro no Lookup Sittricm")
3783:         ENDTRY
3784:         IF USED("cursor_4c_BuscaSittricm")
3785:             USE IN cursor_4c_BuscaSittricm
3786:         ENDIF
3787:     ENDPROC
3788: 

