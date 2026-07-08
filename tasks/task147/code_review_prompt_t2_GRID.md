# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1964: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS GRID (3945 linhas total):

*-- Linhas 639 a 670:
639: 
640:         *-- Grade principal de movimentos
641:         *-- Legado: Grade.Top=153+29=182, Left=12, Width=940, Height=442
642:         loc_oPagina.AddObject("grd_4c_Grade", "Grid")
643:         WITH loc_oPagina.grd_4c_Grade
644:             .Top          = 182
645:             .Left         = 12
646:             .Width        = 940
647:             .Height       = 442
648:             .RecordSource = ""
649:             .RecordMark   = .F.
650:             .DeleteMark   = .F.
651:             .ReadOnly     = .T.
652:             .GridLines    = 3
653:             .FontName     = "Verdana"
654:             .FontSize     = 8
655:             .ColumnCount  = 8
656:             .Visible      = .T.
657:         ENDWITH
658: 
659:         THIS.FormatarGridLista()
660: 
661:         *-- BINDEVENTs: botoes CRUD (handlers PUBLIC por regra CLAUDE.md #3)
662:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
663:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
664:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
665:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
666:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
667:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
668:         BINDEVENT(loc_oPagina.cmd_4c_Cmdfechalote,             "Click", THIS, "CmdFechaLoteClick")
669: 
670:         *-- BINDEVENTs: filtros de periodo

*-- Linhas 1629 a 1675:
1629:         *-- =====================================================================
1630:         *-- GRADE DE OPERACAO (GradeOperacao no legado)
1631:         *-- Legado: Top=50+29=79, Left=598, Width=171, Height=182, Visible=.F.
1632:         *-- ColumnCount=2: Column1=Codigos(OP), Column2=TmpMins(Temp/Min)
1633:         *-- =====================================================================
1634:         loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
1635:         WITH loc_oPagina.grd_4c_GradeOperacao
1636:             .Top         = 79
1637:             .Left        = 598
1638:             .Width       = 171
1639:             .Height      = 182
1640:             .ColumnCount = 2
1641:             .ReadOnly    = .T.
1642:             .Visible     = .F.
1643:             .RecordMark   = .F.
1644:             .DeleteMark   = .F.
1645:         ENDWITH
1646: 
1647:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1648:             .ControlSource   = "TmpOperacao.Codigos"
1649:             .FontName        = "Courier New"
1650:             .Width           = 94
1651:             .InputMask       = "999999999999"
1652:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1653:         ENDWITH
1654: 
1655:         WITH loc_oPagina.grd_4c_GradeOperacao.Column2
1656:             .ControlSource   = "TmpOperacao.TmpMins"
1657:             .FontName        = "Courier New"
1658:             .Width           = 45
1659:             .InputMask       = "99999"
1660:             .Header1.Caption = "Temp/Min"
1661:         ENDWITH
1662: 
1663:         *-- =====================================================================
1664:         *-- CAMPO CODIGO DE OBSERVACAO (get_codobs no legado)
1665:         *-- Legado: Top=234+29=263, Left=690, Width=32, Height=23, InputMask="999"
1666:         *-- Label: Top=238+29=267, Left=599 (Say3 no legado)
1667:         *-- BO: this_cCodObs
1668:         *-- =====================================================================
1669:         loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
1670:         WITH loc_oPagina.lbl_4c_LblObs
1671:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1672:             .Top       = 267
1673:             .Left      = 599
1674:             .AutoSize  = .T.
1675:             .FontBold  = .T.

*-- Linhas 1779 a 1797:
1779:         *-- Restaurar lblTotPeso para oculto (TornarControlesVisiveis seta .T. em tudo)
1780:         loc_oPagina.cnt_4c_Dados.lbl_4c_LblTotPeso.Visible = .F.
1781:         *-- GradeOperacao sempre oculta inicialmente (controle operacional)
1782:         loc_oPagina.grd_4c_GradeOperacao.Visible = .F.
1783:     ENDPROC
1784: 
1785:     *--------------------------------------------------------------------------
1786:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1787:     * Itera Pages de PageFrames e Controls de Containers
1788:     *--------------------------------------------------------------------------
1789:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1790:         LOCAL loc_nI, loc_oObjeto, loc_nP
1791: 
1792:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1793:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1794: 
1795:             IF VARTYPE(loc_oObjeto) = "O"
1796:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1797:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_ORIGEM")

*-- Linhas 1819 a 1932:
1819:     *--------------------------------------------------------------------------
1820:     PROTECTED PROCEDURE FormatarGridLista()
1821:         LOCAL loc_oGrade
1822:         loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
1823: 
1824:         WITH loc_oGrade.Column1
1825:             .ControlSource = "cursor_4c_Dados.numps"
1826:             .Width         = 70
1827:             .Resizable     = .F.
1828:             .Movable       = .F.
1829:             .Header1.Caption   = "N" + CHR(250) + "m."
1830:             .Header1.Alignment = 2
1831:             .Header1.FontName  = "Tahoma"
1832:             .Header1.FontBold  = .T.
1833:             .Header1.FontSize  = 8
1834:         ENDWITH
1835: 
1836:         WITH loc_oGrade.Column2
1837:             .ControlSource = "cursor_4c_Dados.datas"
1838:             .Width         = 82
1839:             .Resizable     = .F.
1840:             .Movable       = .F.
1841:             .Header1.Caption   = "Data"
1842:             .Header1.Alignment = 2
1843:             .Header1.FontName  = "Tahoma"
1844:             .Header1.FontBold  = .T.
1845:             .Header1.FontSize  = 8
1846:         ENDWITH
1847: 
1848:         WITH loc_oGrade.Column3
1849:             .ControlSource = "cursor_4c_Dados.dopps"
1850:             .Width         = 140
1851:             .Resizable     = .F.
1852:             .Movable       = .F.
1853:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1854:             .Header1.Alignment = 2
1855:             .Header1.FontName  = "Tahoma"
1856:             .Header1.FontBold  = .T.
1857:             .Header1.FontSize  = 8
1858:         ENDWITH
1859: 
1860:         WITH loc_oGrade.Column4
1861:             .ControlSource = "cursor_4c_Dados.nlotes"
1862:             .Width         = 70
1863:             .Resizable     = .F.
1864:             .Movable       = .F.
1865:             .Header1.Caption   = "Lote"
1866:             .Header1.Alignment = 2
1867:             .Header1.FontName  = "Tahoma"
1868:             .Header1.FontBold  = .T.
1869:             .Header1.FontSize  = 8
1870:         ENDWITH
1871: 
1872:         WITH loc_oGrade.Column5
1873:             .ControlSource = "cursor_4c_Dados.grupoos"
1874:             .Width         = 80
1875:             .Resizable     = .F.
1876:             .Movable       = .F.
1877:             .Header1.Caption   = "Gr. Orig."
1878:             .Header1.Alignment = 2
1879:             .Header1.FontName  = "Tahoma"
1880:             .Header1.FontBold  = .T.
1881:             .Header1.FontSize  = 8
1882:         ENDWITH
1883: 
1884:         WITH loc_oGrade.Column6
1885:             .ControlSource = "cursor_4c_Dados.contaos"
1886:             .Width         = 80
1887:             .Resizable     = .F.
1888:             .Movable       = .F.
1889:             .Header1.Caption   = "Ct. Orig."
1890:             .Header1.Alignment = 2
1891:             .Header1.FontName  = "Tahoma"
1892:             .Header1.FontBold  = .T.
1893:             .Header1.FontSize  = 8
1894:         ENDWITH
1895: 
1896:         WITH loc_oGrade.Column7
1897:             .ControlSource = "cursor_4c_Dados.grupods"
1898:             .Width         = 80
1899:             .Resizable     = .F.
1900:             .Movable       = .F.
1901:             .Header1.Caption   = "Gr. Dest."
1902:             .Header1.Alignment = 2
1903:             .Header1.FontName  = "Tahoma"
1904:             .Header1.FontBold  = .T.
1905:             .Header1.FontSize  = 8
1906:         ENDWITH
1907: 
1908:         WITH loc_oGrade.Column8
1909:             .ControlSource = "cursor_4c_Dados.contads"
1910:             .Width         = 80
1911:             .Resizable     = .F.
1912:             .Movable       = .F.
1913:             .Header1.Caption   = "Ct. Dest."
1914:             .Header1.Alignment = 2
1915:             .Header1.FontName  = "Tahoma"
1916:             .Header1.FontBold  = .T.
1917:             .Header1.FontSize  = 8
1918:         ENDWITH
1919:     ENDPROC
1920: 
1921:     *--------------------------------------------------------------------------
1922:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1923:     * par_nPagina: 1=Lista, 2=Dados
1924:     *--------------------------------------------------------------------------
1925:     PROCEDURE AlternarPagina(par_nPagina)
1926:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1927:         IF par_nPagina = 1
1928:             THIS.this_cModoAtual = "LISTA"
1929:             THIS.AjustarBotoesPorModo()
1930:             THIS.CarregarLista()
1931:         ELSE
1932:             THIS.this_cModoAtual = "DADOS"

*-- Linhas 1950 a 1980:
1950:         loc_lOk   = .F.
1951: 
1952:         TRY
1953:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1954:                 loc_cEmps = ALLTRIM(.txt_4c_Cd_empresa.Value)
1955:                 loc_dDtI  = .txt_4c_Dt_inicial.Value
1956:                 loc_dDtF  = .txt_4c_Dt_final.Value
1957:                 .Visible     = .T.
1958:             ENDWITH
1959: 
1960:             loc_lOk = THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, THIS.this_cDopp, loc_dDtI, loc_dDtF)
1961: 
1962:             IF loc_lOk
1963:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 8
1964:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1965:                 THIS.FormatarGridLista()
1966:             ENDIF
1967: 
1968:         CATCH TO loc_oErro
1969:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1970:         ENDTRY
1971:     ENDPROC
1972: 
1973:     *--------------------------------------------------------------------------
1974:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1975:     *--------------------------------------------------------------------------
1976:     PROCEDURE AjustarBotoesPorModo()
1977:         LOCAL loc_lEhLista, loc_lTemRegistro, loc_lPodeEditar
1978:         LOCAL loc_oPg1, loc_oPg2
1979: 
1980:         loc_lEhLista     = (THIS.this_cModoAtual = "LISTA")

*-- Linhas 3069 a 3088:
3069:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3070:                     ELSE
3071:                         IF !loc_oBusca.this_lAchouRegistro
3072:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3073:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3074:                         loc_oBusca.Show()
3075:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpOrig")
3076:                             GO TOP IN cursor_4c_GrpOrig
3077:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3078:                         ELSE
3079:                             loc_cGrupo = ""
3080:                         ENDIF
3081:                     ELSE
3082:                         loc_cGrupo = ""
3083:                         ENDIF
3084:                     ENDIF
3085:                     loc_oBusca.Release()
3086:                 ENDIF
3087: 
3088:                 IF USED("cursor_4c_GrpOrig")

*-- Linhas 3170 a 3189:
3170:                             loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3171:                         ELSE
3172:                             IF !loc_oBusca.this_lAchouRegistro
3173:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3174:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3175:                             loc_oBusca.Show()
3176:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliOrig")
3177:                                 GO TOP IN cursor_4c_CliOrig
3178:                                 loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3179:                                 loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3180:                             ELSE
3181:                                 loc_cConta = ""
3182:                                 loc_cNome  = ""
3183:                             ENDIF
3184:                         ELSE
3185:                             loc_cConta = ""
3186:                             loc_cNome  = ""
3187:                             ENDIF
3188:                         ENDIF
3189:                         loc_oBusca.Release()

*-- Linhas 3256 a 3275:
3256:                         IF VARTYPE(loc_oBusca) = "O"
3257:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
3258:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3259:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3260:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3261:                             loc_oBusca.Show()
3262:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")
3263:                                 GO TOP IN cursor_4c_DCliOrig
3264:                                 loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3265:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3266:                             ELSE
3267:                                 loc_cConta = ""
3268:                                 loc_cNome  = ""
3269:                             ENDIF
3270:                             loc_oBusca.Release()
3271:                         ENDIF
3272:                     ENDIF
3273:                 ELSE
3274:                     loc_cConta = ""
3275:                     loc_cNome  = ""

*-- Linhas 3336 a 3355:
3336:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3337:                     ELSE
3338:                         IF !loc_oBusca.this_lAchouRegistro
3339:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3340:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3341:                         loc_oBusca.Show()
3342:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpDest")
3343:                             GO TOP IN cursor_4c_GrpDest
3344:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3345:                         ELSE
3346:                             loc_cGrupo = ""
3347:                         ENDIF
3348:                     ELSE
3349:                         loc_cGrupo = ""
3350:                         ENDIF
3351:                     ENDIF
3352:                     loc_oBusca.Release()
3353:                 ENDIF
3354: 
3355:                 IF USED("cursor_4c_GrpDest")

*-- Linhas 3437 a 3456:
3437:                             loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3438:                         ELSE
3439:                             IF !loc_oBusca.this_lAchouRegistro
3440:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3441:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3442:                             loc_oBusca.Show()
3443:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliDest")
3444:                                 GO TOP IN cursor_4c_CliDest
3445:                                 loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3446:                                 loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3447:                             ELSE
3448:                                 loc_cConta = ""
3449:                                 loc_cNome  = ""
3450:                             ENDIF
3451:                         ELSE
3452:                             loc_cConta = ""
3453:                             loc_cNome  = ""
3454:                             ENDIF
3455:                         ENDIF
3456:                         loc_oBusca.Release()

*-- Linhas 3523 a 3542:
3523:                         IF VARTYPE(loc_oBusca) = "O"
3524:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
3525:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3526:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3527:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3528:                             loc_oBusca.Show()
3529:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")
3530:                                 GO TOP IN cursor_4c_DCliDest
3531:                                 loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3532:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3533:                             ELSE
3534:                                 loc_cConta = ""
3535:                                 loc_cNome  = ""
3536:                             ENDIF
3537:                             loc_oBusca.Release()
3538:                         ENDIF
3539:                     ENDIF
3540:                 ELSE
3541:                     loc_cConta = ""
3542:                     loc_cNome  = ""

*-- Linhas 3603 a 3622:
3603:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3604:                     ELSE
3605:                         IF !loc_oBusca.this_lAchouRegistro
3606:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3607:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3608:                         loc_oBusca.Show()
3609:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpResp")
3610:                             GO TOP IN cursor_4c_GrpResp
3611:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3612:                         ELSE
3613:                             loc_cGrupo = ""
3614:                         ENDIF
3615:                     ELSE
3616:                         loc_cGrupo = ""
3617:                         ENDIF
3618:                     ENDIF
3619:                     loc_oBusca.Release()
3620:                 ENDIF
3621: 
3622:                 IF USED("cursor_4c_GrpResp")

*-- Linhas 3704 a 3723:
3704:                             loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3705:                         ELSE
3706:                             IF !loc_oBusca.this_lAchouRegistro
3707:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3708:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3709:                             loc_oBusca.Show()
3710:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliResp")
3711:                                 GO TOP IN cursor_4c_CliResp
3712:                                 loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3713:                                 loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3714:                             ELSE
3715:                                 loc_cConta = ""
3716:                                 loc_cNome  = ""
3717:                             ENDIF
3718:                         ELSE
3719:                             loc_cConta = ""
3720:                             loc_cNome  = ""
3721:                             ENDIF
3722:                         ENDIF
3723:                         loc_oBusca.Release()

*-- Linhas 3790 a 3809:
3790:                         IF VARTYPE(loc_oBusca) = "O"
3791:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
3792:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3793:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3794:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3795:                             loc_oBusca.Show()
3796:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")
3797:                                 GO TOP IN cursor_4c_DCliResp
3798:                                 loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3799:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3800:                             ELSE
3801:                                 loc_cConta = ""
3802:                                 loc_cNome  = ""
3803:                             ENDIF
3804:                             loc_oBusca.Release()
3805:                         ENDIF
3806:                     ENDIF
3807:                 ELSE
3808:                     loc_cConta = ""
3809:                     loc_cNome  = ""

*-- Linhas 3878 a 3897:
3878:                         IF VARTYPE(loc_oBusca) = "O"
3879:                             loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
3880:                             loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
3881:                             loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
3882:                             loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3883:                             loc_oBusca.Show()
3884:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
3885:                                 GO TOP IN cursor_4c_ObsBusca
3886:                                 loc_nCod = cursor_4c_ObsBusca.codigos
3887:                                 loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3888:                             ELSE
3889:                                 loc_nCod = 0
3890:                                 loc_cObs = ""
3891:                             ENDIF
3892:                             loc_oBusca.Release()
3893:                         ENDIF
3894:                     ENDIF
3895:                 ELSE
3896:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") > 0
3897:                     GO TOP IN cursor_4c_ObsBusca

