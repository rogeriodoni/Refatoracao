# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 575: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS GRID (1091 linhas total):

*-- Linhas 181 a 210:
181:             USE IN cursor_4c_TmpBaixa
182:         ENDIF
183: 
184:         SET NULL ON
185:         CREATE CURSOR cursor_4c_TmpBaixa ;
186:             (CodBarra C(20) NULL, ;
187:              CPros    C(14) NULL, ;
188:              Dopes    C(20) NULL, ;
189:              Numes    N(6,0) NULL, ;
190:              Qtde     N(12,3) NULL, ;
191:              QtdeLido N(12,3) NULL, ;
192:              Nops     N(6,0) NULL, ;
193:              Grupods  C(10) NULL, ;
194:              Contads  C(10) NULL)
195:         SET NULL OFF
196: 
197:         INDEX ON CodBarra           TAG CodBarra
198:         INDEX ON ALLTRIM(Grupods) + ALLTRIM(Contads) TAG GruConta
199:     ENDPROC
200: 
201:     *--------------------------------------------------------------------------
202:     * ConfigurarCabecalho - Cria container cinza do header (equivalente cntSombra)
203:     * Width = 1000 (escala de 800 do legado)
204:     *--------------------------------------------------------------------------
205:     PROTECTED PROCEDURE ConfigurarCabecalho()
206:         LOCAL loc_oCab
207: 
208:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
209:         loc_oCab = THIS.cnt_4c_Cabecalho
210: 

*-- Linhas 363 a 381:
363:             IF VARTYPE(loc_oControl) = "O"
364:                 *-- Containers/controles que devem permanecer ocultos inicialmente
365:                 IF INLIST(UPPER(loc_oControl.Name), ;
366:                           "GRD_4C_DADOS", ;
367:                           "TXT_4C_LEITURA", ;
368:                           "LBL_4C_TXT_LEITURA", ;
369:                           "CNT_4C_CABECALHO")
370:                     *-- Recursao nos filhos mesmo com LOOP (filhos ficam .T.)
371:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
372:                         THIS.TornarControlesVisiveis(loc_oControl)
373:                     ENDIF
374:                     LOOP
375:                 ENDIF
376: 
377:                 loc_oControl.Visible = .T.
378: 
379:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
380:                     THIS.TornarControlesVisiveis(loc_oControl)
381:                 ENDIF

*-- Linhas 561 a 591:
561:                 .Height      = 23
562:                 .InputMask   = "99999999999999"
563:                 .Left        = 130
564:                 .Top         = 451
565:                 .Width       = 135
566:                 .Value       = 0
567:                 .BorderColor = RGB(100, 100, 100)
568:                 .Visible     = .F.
569:             ENDWITH
570: 
571:             *-- Grid de etiquetas (Visible=.F. inicial, torna visivel apos CarregarBaixas)
572:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
573:             loc_oGrd = loc_oPagina.grd_4c_Dados
574:             loc_oGrd.ColumnCount = 3
575:             loc_oGrd.RecordSource = "cursor_4c_TmpBaixa"
576:             loc_oGrd.ColumnCount  = 5
577:             WITH loc_oGrd
578:                 .FontName          = "Verdana"
579:                 .FontSize          = 8
580:                 .AllowHeaderSizing = .F.
581:                 .AllowRowSizing    = .F.
582:                 .DeleteMark        = .F.
583:                 .RecordMark        = .F.
584:                 .Height            = 336
585:                 .Left              = 12
586:                 .ReadOnly          = .T.
587:                 .RowHeight         = 17
588:                 .ScrollBars        = 2
589:                 .Top               = 98
590:                 .Width             = 940
591:                 .Panel             = 1

*-- Linhas 625 a 663:
625:                 .Column4.ControlSource = "cursor_4c_TmpBaixa.Numes"
626:                 .Column5.ControlSource = "cursor_4c_TmpBaixa.QtdeLido"
627: 
628:                 *-- Headers (reconfigurar apos RecordSource pois VFP9 os reseta)
629:                 .Column1.Header1.Caption   = "C" + CHR(243) + "d. Barra"
630:                 .Column1.Header1.FontName  = "Tahoma"
631:                 .Column1.Header1.FontSize  = 8
632:                 .Column1.Header1.Alignment = 2
633:                 .Column2.Header1.Caption   = "Produto"
634:                 .Column2.Header1.FontName  = "Tahoma"
635:                 .Column2.Header1.FontSize  = 8
636:                 .Column2.Header1.Alignment = 2
637:                 .Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
638:                 .Column3.Header1.FontName  = "Tahoma"
639:                 .Column3.Header1.FontSize  = 8
640:                 .Column3.Header1.Alignment = 2
641:                 .Column4.Header1.Caption   = "N" + CHR(250) + "mero"
642:                 .Column4.Header1.FontName  = "Tahoma"
643:                 .Column4.Header1.FontSize  = 8
644:                 .Column4.Header1.Alignment = 2
645:                 .Column5.Header1.Caption   = "Qtde."
646:                 .Column5.Header1.FontName  = "Tahoma"
647:                 .Column5.Header1.FontSize  = 8
648:                 .Column5.Header1.Alignment = 2
649:             ENDWITH
650: 
651:             *-- BINDEVENTs (metodos PUBLIC por default em DEFINE CLASS)
652:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia, "Click", THIS, "CmdConferenciaClick")
653:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
654:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
655:             BINDEVENT(loc_oPagina.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
656: 
657:         CATCH TO loc_oErro
658:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * AlternarPagina - Alterna a pagina ativa do PageFrame

*-- Linhas 686 a 732:
686: 
687:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
688: 
689:             loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
690:             loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
691:             loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
692:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
693:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
694: 
695:             IF loc_lTemDados
696:                 loc_oPagina.grd_4c_Dados.Refresh()
697:                 loc_oPagina.txt_4c_Leitura.SetFocus()
698:             ELSE
699:                 MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
700:                          CHR(231) + CHR(227) + "o!!!", "Aviso")
701:             ENDIF
702: 
703:         CATCH TO loc_oErro
704:             MsgErro(loc_oErro.Message, "Erro AtualizarGrade")
705:         ENDTRY
706:     ENDPROC
707: 
708:     *--------------------------------------------------------------------------
709:     * CmdConferenciaClick - Conf. Auto: marca todas etiquetas como lidas e
710:     * atualiza grid (equivalente ao legado Conferencia.Click)
711:     *--------------------------------------------------------------------------
712:     PROCEDURE CmdConferenciaClick()
713:         LOCAL loc_oErro
714: 
715:         TRY
716:             THIS.this_oBusinessObject.MarcarTodasLidas()
717:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
718:         CATCH TO loc_oErro
719:             MsgErro(loc_oErro.Message, "Erro CmdConferenciaClick")
720:         ENDTRY
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * CmdOkClick - Confirma conferencia, grava movimentacoes e encerra form
725:     * (equivalente ao legado Ok.Click)
726:     *--------------------------------------------------------------------------
727:     PROCEDURE CmdOkClick()
728:         LOCAL loc_lSucesso, loc_oErro
729: 
730:         TRY
731:             IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
732:                 THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()

*-- Linhas 789 a 807:
789: 
790:         TRY
791:             loc_oTxt      = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
792:             loc_oGrd      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
793:             loc_cCodBarra = ALLTRIM(TRANSFORM(loc_oTxt.Value))
794: 
795:             IF !EMPTY(loc_cCodBarra) AND loc_cCodBarra <> "0"
796:                 THIS.this_oBusinessObject.RegistrarLeitura(loc_cCodBarra)
797: 
798:                 *-- Posicionar cursor no registro lido para atualizar highlighting
799:                 IF USED("cursor_4c_TmpBaixa")
800:                     SELECT cursor_4c_TmpBaixa
801:                     SET ORDER TO TAG CodBarra
802:                     SEEK loc_cCodBarra
803:                 ENDIF
804:             ENDIF
805: 
806:             loc_oTxt.Value = 0
807:             loc_oGrd.Refresh()

*-- Linhas 842 a 875:
842:             ENDIF
843: 
844:             THIS.this_oBusinessObject.MarcarTodasLidas()
845:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
846:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     * BtnVisualizarClick - Atualiza visualizacao da grade
854:     * Form OPERACIONAL: "Visualizar" = refresh grade e reposicionar
855:     *--------------------------------------------------------------------------
856:     PROCEDURE BtnVisualizarClick()
857:         LOCAL loc_oGrd, loc_oErro
858: 
859:         TRY
860:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
861: 
862:             IF USED("cursor_4c_TmpBaixa")
863:                 SELECT cursor_4c_TmpBaixa
864:                 GO TOP
865:             ENDIF
866: 
867:             loc_oGrd.Refresh()
868:             loc_oGrd.SetFocus()
869:         CATCH TO loc_oErro
870:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
871:         ENDTRY
872:     ENDPROC
873: 
874:     *--------------------------------------------------------------------------
875:     * BtnExcluirClick - Limpa leituras da etiqueta corrente do grid

*-- Linhas 902 a 920:
902: 
903:             REPLACE QtdeLido WITH 0 IN cursor_4c_TmpBaixa
904: 
905:             THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
906:             THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
909:         ENDTRY
910:     ENDPROC
911: 
912:     *--------------------------------------------------------------------------
913:     * BtnBuscarClick - Recarrega etiquetas (refresh completo das baixas)
914:     * Form OPERACIONAL: "Buscar" = reprocessar etiquetas do cursor_4c_TmpEnc
915:     *--------------------------------------------------------------------------
916:     PROCEDURE BtnBuscarClick()
917:         LOCAL loc_oErro
918: 
919:         TRY
920:             THIS.CarregarBaixas()

*-- Linhas 1035 a 1056:
1035:                     ENDIF
1036:                 ENDIF
1037: 
1038:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1039:                     loc_oPagina.grd_4c_Dados.Visible = loc_lTemDados
1040:                     IF loc_lTemDados
1041:                         loc_oPagina.grd_4c_Dados.Refresh()
1042:                     ENDIF
1043:                 ENDIF
1044:             ENDIF
1045: 
1046:         CATCH TO loc_oErro
1047:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
1048:         ENDTRY
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * LimparCampos - Limpa campo de leitura de codigo de barras
1053:     * Form OPERACIONAL: reinicia leitura sem alterar dados da grade
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE LimparCampos()
1056:         LOCAL loc_oPagina, loc_oErro

