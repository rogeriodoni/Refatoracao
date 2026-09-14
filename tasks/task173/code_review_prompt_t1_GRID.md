# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 450: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS GRID (1294 linhas total):

*-- Linhas 71 a 93:
71:             ENDIF
72: 
73:             *-- Cursor placeholder de produtos (sera populado pelo BtnSelecionarClick)
74:             SET NULL ON
75:             CREATE CURSOR cursor_4c_Produtos ;
76:                 (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
77:                  DscCompras M(4) NULL, ObsCompras M(4) NULL)
78:             SET NULL OFF
79: 
80:             *-- Configuracao base do form (Picture, dimensoes, Caption reforcados)
81:             *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
82:             *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
83:             THIS.ConfigurarPageFrame()
84: 
85:             *-- Configurar controles visuais
86:             THIS.ConfigurarCabecalho()
87:             THIS.ConfigurarPaginaLista()
88:             THIS.ConfigurarPaginaDados()
89:             THIS.VincularEventos()
90: 
91:             THIS.TornarControlesVisiveis()
92: 
93:             loc_lSucesso = .T.

*-- Linhas 426 a 498:
426:     *==========================================================================
427:     PROTECTED PROCEDURE ConfigurarGrade()
428:     *==========================================================================
429:         THIS.AddObject("grd_4c_Dados", "Grid")
430:         WITH THIS.grd_4c_Dados
431:             .Top                = 164
432:             .Left               = 19
433:             .Width              = 961
434:             .Height             = 343
435:             .ColumnCount        = 3
436:             .FontSize           = 8
437:             .FontName           = "Verdana"
438:             .AllowHeaderSizing  = .F.
439:             .AllowRowSizing     = .F.
440:             .DeleteMark         = .F.
441:             .RecordMark         = .F.
442:             .HeaderHeight       = 17
443:             .RowHeight          = 17
444:             .ScrollBars         = 2
445:             .ReadOnly           = .T.
446:             .HighlightStyle     = 2
447:             .HighlightBackColor = RGB(255,255,255)
448:             .HighlightForeColor = RGB(15,41,104)
449:             .GridLineColor      = RGB(238,238,238)
450:             .RecordSource       = "cursor_4c_Produtos"
451: 
452:             WITH .Column1
453:                 .Width         = 135
454:                 .FontSize      = 8
455:                 .ControlSource = "cursor_4c_Produtos.CPros"
456:                 .ReadOnly      = .T.
457:                 WITH .Header1
458:                     .Caption   = "C" + CHR(243) + "digo"
459:                     .FontName  = "Tahoma"
460:                     .FontSize  = 8
461:                     .Alignment = 2
462:                 ENDWITH
463:             ENDWITH
464: 
465:             WITH .Column2
466:                 .Width         = 363
467:                 .FontSize      = 8
468:                 .ControlSource = "cursor_4c_Produtos.Portugues"
469:                 .ReadOnly      = .T.
470:                 WITH .Header1
471:                     .Caption   = "Portugu" + CHR(234) + "s"
472:                     .FontName  = "Tahoma"
473:                     .FontSize  = 8
474:                     .Alignment = 2
475:                 ENDWITH
476:             ENDWITH
477: 
478:             WITH .Column3
479:                 .Width         = 427
480:                 .FontSize      = 8
481:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
482:                 .ReadOnly      = .T.
483:                 WITH .Header1
484:                     .Caption   = "Traduzido"
485:                     .FontName  = "Tahoma"
486:                     .FontSize  = 8
487:                     .Alignment = 2
488:                 ENDWITH
489:             ENDWITH
490: 
491:             .Visible = .T.
492:         ENDWITH
493:     ENDPROC
494: 
495:     *==========================================================================
496:     PROCEDURE VincularEventos()
497:     *==========================================================================
498:         BINDEVENT(THIS.txt_4c_CProsI,        "KeyPress", THIS, "TxtCProsIKeyPress")

*-- Linhas 603 a 623:
603:                     "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
604:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
605:                 IF VARTYPE(loc_oBusca) = "O"
606:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
607:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
608:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
609:                     loc_oBusca.Show()
610:                     IF USED("cursor_4c_BuscaPro") AND loc_oBusca.this_lSelecionou
611:                         SELECT cursor_4c_BuscaPro
612:                         loc_cCodigo    = ALLTRIM(CPros)
613:                         loc_lEncontrou = .T.
614:                     ENDIF
615:                     IF USED("cursor_4c_BuscaPro")
616:                         USE IN cursor_4c_BuscaPro
617:                     ENDIF
618:                 ENDIF
619:             CATCH TO loc_oErro
620:                 MsgErro("Erro na busca de produto: " + loc_oErro.Message, "Erro")
621:             ENDTRY
622:         ENDIF
623: 

*-- Linhas 682 a 701:
682:                     "SigCdGrp", "cursor_4c_BuscaGru", "CGrus", loc_cVal, ;
683:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
684:                 IF VARTYPE(loc_oBusca) = "O"
685:                     loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
686:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
687:                     loc_oBusca.Show()
688:                     IF USED("cursor_4c_BuscaGru") AND loc_oBusca.this_lSelecionou
689:                         SELECT cursor_4c_BuscaGru
690:                         loc_cCodigo    = ALLTRIM(CGrus)
691:                         loc_lEncontrou = .T.
692:                     ENDIF
693:                     IF USED("cursor_4c_BuscaGru")
694:                         USE IN cursor_4c_BuscaGru
695:                     ENDIF
696:                 ENDIF
697:             CATCH TO loc_oErro
698:                 MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
699:             ENDTRY
700:         ENDIF
701: 

*-- Linhas 733 a 753:
733:                 "SigCdPro", "cursor_4c_BuscaProDbl", "CPros", loc_cVal, ;
734:                 "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
735:             IF VARTYPE(loc_oBusca) = "O"
736:                 loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
737:                 loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
738:                 loc_oBusca.mAddColuna("CGrus", "", "Grupo")
739:                 loc_oBusca.Show()
740:                 IF USED("cursor_4c_BuscaProDbl") AND loc_oBusca.this_lSelecionou
741:                     SELECT cursor_4c_BuscaProDbl
742:                     loc_cCodigo = ALLTRIM(CPros)
743:                     DO CASE
744:                         CASE par_cCampo = "CProsI"
745:                             THIS.txt_4c_CProsI.Value = loc_cCodigo
746:                             THIS.txt_4c_CProsI.Refresh
747:                             IF EMPTY(THIS.txt_4c_CProsF.Value)
748:                                 THIS.txt_4c_CProsF.Value = loc_cCodigo
749:                                 THIS.txt_4c_CProsF.Refresh
750:                             ENDIF
751:                             THIS.txt_4c_CGrus.Value = ""
752:                             THIS.txt_4c_CGrus.Refresh
753:                         CASE par_cCampo = "CProsF"

*-- Linhas 785 a 804:
785:                 "SigCdGrp", "cursor_4c_BuscaGruDbl", "CGrus", loc_cVal, ;
786:                 "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
787:             IF VARTYPE(loc_oBusca) = "O"
788:                 loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
789:                 loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
790:                 loc_oBusca.Show()
791:                 IF USED("cursor_4c_BuscaGruDbl") AND loc_oBusca.this_lSelecionou
792:                     SELECT cursor_4c_BuscaGruDbl
793:                     loc_cCodigo = ALLTRIM(CGrus)
794:                     THIS.txt_4c_CGrus.Value = loc_cCodigo
795:                     THIS.txt_4c_CGrus.Refresh
796:                     THIS.txt_4c_CProsI.Value = ""
797:                     THIS.txt_4c_CProsI.Refresh
798:                     THIS.txt_4c_CProsF.Value = ""
799:                     THIS.txt_4c_CProsF.Refresh
800:                 ENDIF
801:                 IF USED("cursor_4c_BuscaGruDbl")
802:                     USE IN cursor_4c_BuscaGruDbl
803:                 ENDIF
804:             ENDIF

*-- Linhas 915 a 933:
915:                        "e limpar a lista de produtos?", ;
916:                        "Confirma" + CHR(231) + CHR(227) + "o")
917:             ZAP IN cursor_4c_Produtos
918:             THIS.grd_4c_Dados.Refresh
919:             THIS.cmd_4c_BtnAtualizar.Enabled = .F.
920:         ENDIF
921:     ENDPROC
922: 
923:     *==========================================================================
924:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
925:     *  Compatibilidade de API: form OPERACIONAL usa layout flat (sem PageFrame)
926:     *==========================================================================
927:         RETURN
928:     ENDPROC
929: 
930:     *==========================================================================
931:     PROCEDURE BtnBuscarClick()
932:     *  Compatibilidade de API: delega para BtnSelecionarClick (selecionar produtos)
933:     *==========================================================================

*-- Linhas 957 a 976:
957:         ENDIF
958:         THIS.LimparCampos()
959:         THIS.cmd_4c_BtnAtualizar.Enabled = .F.
960:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
961:             THIS.grd_4c_Dados.Refresh
962:         ENDIF
963:     ENDPROC
964: 
965:     *==========================================================================
966:     PROCEDURE FormParaBO()
967:     *  Transfere valores dos campos de filtro para as propriedades do BO
968:     *==========================================================================
969:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
970:             RETURN
971:         ENDIF
972:         THIS.this_oBusinessObject.this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
973:         THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
974:         THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)
975:     ENDPROC
976: 

*-- Linhas 1023 a 1042:
1023:     *  Compatibilidade de API: para OPERACIONAL o carregamento e disparado
1024:     *  manualmente via BtnSelecionarClick. Este metodo apenas atualiza o grid.
1025:     *==========================================================================
1026:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1027:             THIS.grd_4c_Dados.Refresh
1028:         ENDIF
1029:     ENDPROC
1030: 
1031:     *==========================================================================
1032:     PROCEDURE AjustarBotoesPorModo()
1033:     *  Compatibilidade de API: gerencia estado dos botoes conforme dados carregados.
1034:     *  Atualizar fica habilitado somente quando ha produtos processados no cursor.
1035:     *==========================================================================
1036:         LOCAL loc_lTemProdutos
1037:         loc_lTemProdutos = USED("cursor_4c_Produtos") AND ;
1038:                            RECCOUNT("cursor_4c_Produtos") > 0
1039: 
1040:         THIS.cmd_4c_BtnAtualizar.Enabled = loc_lTemProdutos
1041:     ENDPROC
1042: 

*-- Linhas 1166 a 1184:
1166: 
1167:             *-- Restaura contexto do SCAN externo
1168:             SELECT cursor_4c_PrdTraduz
1169:             THIS.grd_4c_Dados.Refresh
1170:         ENDSCAN
1171: 
1172:         IF USED("cursor_4c_PrdTraduz")
1173:             USE IN cursor_4c_PrdTraduz
1174:         ENDIF
1175: 
1176:         IF VARTYPE(loc_oProg) = "O"
1177:             loc_oProg.Complete
1178:         ENDIF
1179: 
1180:         SELECT cursor_4c_Produtos
1181:         GO TOP
1182:         IF !EOF("cursor_4c_Produtos")
1183:             THIS.cmd_4c_BtnAtualizar.Enabled = .T.
1184:         ENDIF

