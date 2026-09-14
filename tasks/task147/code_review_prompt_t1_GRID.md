# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1962: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS GRID (3943 linhas total):

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
1797:                     loc_oObjeto.Visible = .T.

*-- Linhas 1817 a 1930:
1817:     *--------------------------------------------------------------------------
1818:     PROTECTED PROCEDURE FormatarGridLista()
1819:         LOCAL loc_oGrade
1820:         loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
1821: 
1822:         WITH loc_oGrade.Column1
1823:             .ControlSource = "cursor_4c_Dados.numps"
1824:             .Width         = 70
1825:             .Resizable     = .F.
1826:             .Movable       = .F.
1827:             .Header1.Caption   = "N" + CHR(250) + "m."
1828:             .Header1.Alignment = 2
1829:             .Header1.FontName  = "Tahoma"
1830:             .Header1.FontBold  = .T.
1831:             .Header1.FontSize  = 8
1832:         ENDWITH
1833: 
1834:         WITH loc_oGrade.Column2
1835:             .ControlSource = "cursor_4c_Dados.datas"
1836:             .Width         = 82
1837:             .Resizable     = .F.
1838:             .Movable       = .F.
1839:             .Header1.Caption   = "Data"
1840:             .Header1.Alignment = 2
1841:             .Header1.FontName  = "Tahoma"
1842:             .Header1.FontBold  = .T.
1843:             .Header1.FontSize  = 8
1844:         ENDWITH
1845: 
1846:         WITH loc_oGrade.Column3
1847:             .ControlSource = "cursor_4c_Dados.dopps"
1848:             .Width         = 140
1849:             .Resizable     = .F.
1850:             .Movable       = .F.
1851:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1852:             .Header1.Alignment = 2
1853:             .Header1.FontName  = "Tahoma"
1854:             .Header1.FontBold  = .T.
1855:             .Header1.FontSize  = 8
1856:         ENDWITH
1857: 
1858:         WITH loc_oGrade.Column4
1859:             .ControlSource = "cursor_4c_Dados.nlotes"
1860:             .Width         = 70
1861:             .Resizable     = .F.
1862:             .Movable       = .F.
1863:             .Header1.Caption   = "Lote"
1864:             .Header1.Alignment = 2
1865:             .Header1.FontName  = "Tahoma"
1866:             .Header1.FontBold  = .T.
1867:             .Header1.FontSize  = 8
1868:         ENDWITH
1869: 
1870:         WITH loc_oGrade.Column5
1871:             .ControlSource = "cursor_4c_Dados.grupoos"
1872:             .Width         = 80
1873:             .Resizable     = .F.
1874:             .Movable       = .F.
1875:             .Header1.Caption   = "Gr. Orig."
1876:             .Header1.Alignment = 2
1877:             .Header1.FontName  = "Tahoma"
1878:             .Header1.FontBold  = .T.
1879:             .Header1.FontSize  = 8
1880:         ENDWITH
1881: 
1882:         WITH loc_oGrade.Column6
1883:             .ControlSource = "cursor_4c_Dados.contaos"
1884:             .Width         = 80
1885:             .Resizable     = .F.
1886:             .Movable       = .F.
1887:             .Header1.Caption   = "Ct. Orig."
1888:             .Header1.Alignment = 2
1889:             .Header1.FontName  = "Tahoma"
1890:             .Header1.FontBold  = .T.
1891:             .Header1.FontSize  = 8
1892:         ENDWITH
1893: 
1894:         WITH loc_oGrade.Column7
1895:             .ControlSource = "cursor_4c_Dados.grupods"
1896:             .Width         = 80
1897:             .Resizable     = .F.
1898:             .Movable       = .F.
1899:             .Header1.Caption   = "Gr. Dest."
1900:             .Header1.Alignment = 2
1901:             .Header1.FontName  = "Tahoma"
1902:             .Header1.FontBold  = .T.
1903:             .Header1.FontSize  = 8
1904:         ENDWITH
1905: 
1906:         WITH loc_oGrade.Column8
1907:             .ControlSource = "cursor_4c_Dados.contads"
1908:             .Width         = 80
1909:             .Resizable     = .F.
1910:             .Movable       = .F.
1911:             .Header1.Caption   = "Ct. Dest."
1912:             .Header1.Alignment = 2
1913:             .Header1.FontName  = "Tahoma"
1914:             .Header1.FontBold  = .T.
1915:             .Header1.FontSize  = 8
1916:         ENDWITH
1917:     ENDPROC
1918: 
1919:     *--------------------------------------------------------------------------
1920:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1921:     * par_nPagina: 1=Lista, 2=Dados
1922:     *--------------------------------------------------------------------------
1923:     PROCEDURE AlternarPagina(par_nPagina)
1924:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1925:         IF par_nPagina = 1
1926:             THIS.this_cModoAtual = "LISTA"
1927:             THIS.AjustarBotoesPorModo()
1928:             THIS.CarregarLista()
1929:         ELSE
1930:             THIS.this_cModoAtual = "DADOS"

*-- Linhas 1948 a 1978:
1948:         loc_lOk   = .F.
1949: 
1950:         TRY
1951:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1952:                 loc_cEmps = ALLTRIM(.txt_4c_Cd_empresa.Value)
1953:                 loc_dDtI  = .txt_4c_Dt_inicial.Value
1954:                 loc_dDtF  = .txt_4c_Dt_final.Value
1955:                 .Visible     = .T.
1956:             ENDWITH
1957: 
1958:             loc_lOk = THIS.this_oBusinessObject.BuscarPorPeriodo(loc_cEmps, THIS.this_cDopp, loc_dDtI, loc_dDtF)
1959: 
1960:             IF loc_lOk
1961:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 3
1962:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1963:                 THIS.FormatarGridLista()
1964:             ENDIF
1965: 
1966:         CATCH TO loc_oErro
1967:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
1968:         ENDTRY
1969:     ENDPROC
1970: 
1971:     *--------------------------------------------------------------------------
1972:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
1973:     *--------------------------------------------------------------------------
1974:     PROCEDURE AjustarBotoesPorModo()
1975:         LOCAL loc_lEhLista, loc_lTemRegistro, loc_lPodeEditar
1976:         LOCAL loc_oPg1, loc_oPg2
1977: 
1978:         loc_lEhLista     = (THIS.this_cModoAtual = "LISTA")

*-- Linhas 3067 a 3086:
3067:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3068:                     ELSE
3069:                         IF !loc_oBusca.this_lAchouRegistro
3070:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3071:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3072:                         loc_oBusca.Show()
3073:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpOrig")
3074:                             GO TOP IN cursor_4c_GrpOrig
3075:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpOrig.codigos)
3076:                         ELSE
3077:                             loc_cGrupo = ""
3078:                         ENDIF
3079:                     ELSE
3080:                         loc_cGrupo = ""
3081:                         ENDIF
3082:                     ENDIF
3083:                     loc_oBusca.Release()
3084:                 ENDIF
3085: 
3086:                 IF USED("cursor_4c_GrpOrig")

*-- Linhas 3168 a 3187:
3168:                             loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3169:                         ELSE
3170:                             IF !loc_oBusca.this_lAchouRegistro
3171:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3172:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3173:                             loc_oBusca.Show()
3174:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliOrig")
3175:                                 GO TOP IN cursor_4c_CliOrig
3176:                                 loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3177:                                 loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3178:                             ELSE
3179:                                 loc_cConta = ""
3180:                                 loc_cNome  = ""
3181:                             ENDIF
3182:                         ELSE
3183:                             loc_cConta = ""
3184:                             loc_cNome  = ""
3185:                             ENDIF
3186:                         ENDIF
3187:                         loc_oBusca.Release()

*-- Linhas 3254 a 3273:
3254:                         IF VARTYPE(loc_oBusca) = "O"
3255:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
3256:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3257:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3258:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3259:                             loc_oBusca.Show()
3260:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")
3261:                                 GO TOP IN cursor_4c_DCliOrig
3262:                                 loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3263:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3264:                             ELSE
3265:                                 loc_cConta = ""
3266:                                 loc_cNome  = ""
3267:                             ENDIF
3268:                             loc_oBusca.Release()
3269:                         ENDIF
3270:                     ENDIF
3271:                 ELSE
3272:                     loc_cConta = ""
3273:                     loc_cNome  = ""

*-- Linhas 3334 a 3353:
3334:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3335:                     ELSE
3336:                         IF !loc_oBusca.this_lAchouRegistro
3337:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3338:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3339:                         loc_oBusca.Show()
3340:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpDest")
3341:                             GO TOP IN cursor_4c_GrpDest
3342:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpDest.codigos)
3343:                         ELSE
3344:                             loc_cGrupo = ""
3345:                         ENDIF
3346:                     ELSE
3347:                         loc_cGrupo = ""
3348:                         ENDIF
3349:                     ENDIF
3350:                     loc_oBusca.Release()
3351:                 ENDIF
3352: 
3353:                 IF USED("cursor_4c_GrpDest")

*-- Linhas 3435 a 3454:
3435:                             loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3436:                         ELSE
3437:                             IF !loc_oBusca.this_lAchouRegistro
3438:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3439:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3440:                             loc_oBusca.Show()
3441:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliDest")
3442:                                 GO TOP IN cursor_4c_CliDest
3443:                                 loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3444:                                 loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3445:                             ELSE
3446:                                 loc_cConta = ""
3447:                                 loc_cNome  = ""
3448:                             ENDIF
3449:                         ELSE
3450:                             loc_cConta = ""
3451:                             loc_cNome  = ""
3452:                             ENDIF
3453:                         ENDIF
3454:                         loc_oBusca.Release()

*-- Linhas 3521 a 3540:
3521:                         IF VARTYPE(loc_oBusca) = "O"
3522:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
3523:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3524:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3525:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3526:                             loc_oBusca.Show()
3527:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")
3528:                                 GO TOP IN cursor_4c_DCliDest
3529:                                 loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3530:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3531:                             ELSE
3532:                                 loc_cConta = ""
3533:                                 loc_cNome  = ""
3534:                             ENDIF
3535:                             loc_oBusca.Release()
3536:                         ENDIF
3537:                     ENDIF
3538:                 ELSE
3539:                     loc_cConta = ""
3540:                     loc_cNome  = ""

*-- Linhas 3601 a 3620:
3601:                         loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3602:                     ELSE
3603:                         IF !loc_oBusca.this_lAchouRegistro
3604:                         loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX",                    "C" + CHR(243) + "digo")
3605:                         loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3606:                         loc_oBusca.Show()
3607:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrpResp")
3608:                             GO TOP IN cursor_4c_GrpResp
3609:                             loc_cGrupo = ALLTRIM(cursor_4c_GrpResp.codigos)
3610:                         ELSE
3611:                             loc_cGrupo = ""
3612:                         ENDIF
3613:                     ELSE
3614:                         loc_cGrupo = ""
3615:                         ENDIF
3616:                     ENDIF
3617:                     loc_oBusca.Release()
3618:                 ENDIF
3619: 
3620:                 IF USED("cursor_4c_GrpResp")

*-- Linhas 3702 a 3721:
3702:                             loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3703:                         ELSE
3704:                             IF !loc_oBusca.this_lAchouRegistro
3705:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3706:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3707:                             loc_oBusca.Show()
3708:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliResp")
3709:                                 GO TOP IN cursor_4c_CliResp
3710:                                 loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3711:                                 loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3712:                             ELSE
3713:                                 loc_cConta = ""
3714:                                 loc_cNome  = ""
3715:                             ENDIF
3716:                         ELSE
3717:                             loc_cConta = ""
3718:                             loc_cNome  = ""
3719:                             ENDIF
3720:                         ENDIF
3721:                         loc_oBusca.Release()

*-- Linhas 3788 a 3807:
3788:                         IF VARTYPE(loc_oBusca) = "O"
3789:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
3790:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3791:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3792:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3793:                             loc_oBusca.Show()
3794:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")
3795:                                 GO TOP IN cursor_4c_DCliResp
3796:                                 loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3797:                                 loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3798:                             ELSE
3799:                                 loc_cConta = ""
3800:                                 loc_cNome  = ""
3801:                             ENDIF
3802:                             loc_oBusca.Release()
3803:                         ENDIF
3804:                     ENDIF
3805:                 ELSE
3806:                     loc_cConta = ""
3807:                     loc_cNome  = ""

*-- Linhas 3876 a 3895:
3876:                         IF VARTYPE(loc_oBusca) = "O"
3877:                             loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
3878:                             loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
3879:                             loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
3880:                             loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3881:                             loc_oBusca.Show()
3882:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
3883:                                 GO TOP IN cursor_4c_ObsBusca
3884:                                 loc_nCod = cursor_4c_ObsBusca.codigos
3885:                                 loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3886:                             ELSE
3887:                                 loc_nCod = 0
3888:                                 loc_cObs = ""
3889:                             ENDIF
3890:                             loc_oBusca.Release()
3891:                         ENDIF
3892:                     ENDIF
3893:                 ELSE
3894:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") > 0
3895:                     GO TOP IN cursor_4c_ObsBusca

