# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, VALUE, FIXOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, VALUE, FIXOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'XNENS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, VALUE, FIXOS

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
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = "xNensin.descs"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column1.ControlSource = ""
Select xMfas
	.Column2.ControlSource = 'xmfas.nenvs'
	.Column1.ControlSource = 'xmfas.nops'
	.Column3.ControlSource = 'xmfas.qtds'
	.Column4.ControlSource = 'xmfas.codpds'
Select xNensiN
	.Column1.ControlSource   = 'xnensiN.Cods' 				
	.Column2.ControlSource   = 'xnensiN.Qtds'				
	.Column3.ControlSource   = 'xnensiN.Descs'				
	.Column4.ControlSource   = 'xnensiN.Conta2s'
Insert Into xNensiN (Nops,Qtds) Values (xMfas.Nops,xMfas.Qtds)
Select xNensiN
Delete
Select xNensiN
Select xMfas
Select xMfas
	lcSql = [Select * From SigCdNcf Where Emps = ']+_Empr+[' Or Emps = ' ' ]
	If Thisform.Podatamgr.Sqlexecute(lcSql,'CsSelecao') < 1
	Select CsSelecao
	If Not Seek(This.Value)
	Select xNensiN
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp8.prg) - TRECHOS RELEVANTES PARA PASS SQL (1489 linhas total):

*-- Linhas 273 a 323:
273:         *-- left=111->139, width=36->45 escalado
274:         loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
275:         WITH loc_oCnt.txt_4c_Empresa
276:             .ControlSource     = "tmpnens.emps"
277:             .Left              = 139
278:             .Top               = 10
279:             .Width             = 45
280:             .Height            = 23
281:             .ReadOnly          = .T.
282:             .SpecialEffect     = 2
283:             .ForeColor         = RGB(0,0,0)
284:             .DisabledBackColor = RGB(255,255,255)
285:             .BorderColor       = RGB(100,100,100)
286:         ENDWITH
287: 
288:         *-- txt_4c_Operacao: descricao da operacao (original GetOperacao, tmpnens.dopps)
289:         *-- left=149->186, width=156->195 escalado
290:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
291:         WITH loc_oCnt.txt_4c_Operacao
292:             .ControlSource     = "tmpnens.dopps"
293:             .Left              = 186
294:             .Top               = 10
295:             .Width             = 195
296:             .Height            = 23
297:             .ReadOnly          = .T.
298:             .SpecialEffect     = 2
299:             .ForeColor         = RGB(0,0,0)
300:             .DisabledBackColor = RGB(255,255,255)
301:             .BorderColor       = RGB(100,100,100)
302:         ENDWITH
303: 
304:         *-- txt_4c_NumOp: numero da OP (original GetCodigo, tmpnens.numps)
305:         *-- left=307->384, width=81->101 escalado
306:         loc_oCnt.AddObject("txt_4c_NumOp", "TextBox")
307:         WITH loc_oCnt.txt_4c_NumOp
308:             .ControlSource     = "tmpnens.numps"
309:             .Format            = "L"
310:             .InputMask         = "9999999999"
311:             .Left              = 384
312:             .Top               = 10
313:             .Width             = 101
314:             .Height            = 23
315:             .ReadOnly          = .T.
316:             .SpecialEffect     = 2
317:             .ForeColor         = RGB(0,0,0)
318:             .DisabledBackColor = RGB(255,255,255)
319:             .BorderColor       = RGB(100,100,100)
320:         ENDWITH
321: 
322:         loc_oCnt.Visible = .T.
323:     ENDPROC

*-- Linhas 392 a 410:
392:             .ColumnCount        = 4
393:             .ReadOnly           = .T.
394:             .RecordMark         = .F.
395:             .DeleteMark         = .F.
396:             .AllowHeaderSizing  = .F.
397:             .HeaderHeight       = 14
398:             .RowHeight          = 15
399:             .ScrollBars         = 2
400:             .GridLineColor      = RGB(238,238,238)
401:             .HighlightStyle     = 2
402:             .HighlightBackColor = RGB(255,255,255)
403:             .HighlightForeColor = RGB(15,41,104)
404: 
405:             *-- Column1: O. P. (ColumnOrder=2, nops, original w=75->94)
406:             .Column1.ColumnOrder = 2
407:             .Column1.Width       = 94
408:             .Column1.Movable     = .F.
409:             .Column1.Resizable   = .F.
410:             .Column1.ReadOnly    = .T.

*-- Linhas 493 a 511:
493:             .ColumnCount        = 4
494:             .ReadOnly           = .F.
495:             .RecordMark         = .F.
496:             .DeleteMark         = .F.
497:             .AllowHeaderSizing  = .F.
498:             .HeaderHeight       = 14
499:             .RowHeight          = 15
500:             .ScrollBars         = 2
501:             .GridLines          = 3
502:             .GridLineColor      = RGB(238,238,238)
503:             .HighlightStyle     = 2
504:             .HighlightBackColor = RGB(255,255,255)
505:             .HighlightForeColor = RGB(15,41,104)
506: 
507:             *-- Column1: Codigo NCF (ColumnOrder=1, Cods, original w=80->100)
508:             .Column1.ColumnOrder = 1
509:             .Column1.Width       = 100
510:             .Column1.Movable     = .F.
511:             .Column1.Resizable   = .F.

*-- Linhas 626 a 650:
626: 
627:     *==========================================================================
628:     * AdicionarTxtDescricao - Textbox que exibe descricao da NC selecionada
629:     * Ligado a xNensiN.descs (auto-atualiza ao navegar grd_4c_Inc via ControlSource)
630:     * Original Get_Descs: left=361 top=568 w=347 h=23 (800px) -> left=451 w=434
631:     *==========================================================================
632:     PROTECTED PROCEDURE AdicionarTxtDescricao()
633:         THIS.AddObject("txt_4c_Descricao", "TextBox")
634:         WITH THIS.txt_4c_Descricao
635:             .ControlSource = "xNensiN.descs"
636:             .Left          = 451
637:             .Top           = 568
638:             .Width         = 434
639:             .Height        = 23
640:             .FontName      = "Tahoma"
641:             .FontSize      = 8
642:             .BorderStyle   = 1
643:             .BackColor     = RGB(255,255,255)
644:             .ForeColor     = RGB(0,0,0)
645:         ENDWITH
646:     ENDPROC
647: 
648:     *==========================================================================
649:     * AdicionarBtnOk - Botao OK: habilita form pai e fecha este sub-dialog
650:     * Original ok: left=725 top=3 picture=cadastro_salvar_60.jpg (800px) -> left=906

*-- Linhas 678 a 743:
678:     * Chamado em InicializarForm apos todos os Configure* (datasession ja ativa)
679:     * grd_4c_Retrab -> xMfas  (OPs para retrabalho, read-only)
680:     * grd_4c_Inc    -> xNensiN (NC da OP corrente, editavel)
681:     * Headers DEVEM ser reconfigurados apos setar RecordSource/ControlSource
682:     *==========================================================================
683:     PROCEDURE CarregarGradeRetrab()
684:         LOCAL loc_oGrdR, loc_oGrdI
685: 
686:         IF !PEMSTATUS(THIS, "grd_4c_Retrab", 5) OR !PEMSTATUS(THIS, "grd_4c_Inc", 5)
687:             RETURN
688:         ENDIF
689: 
690:         loc_oGrdR = THIS.grd_4c_Retrab
691:         loc_oGrdI = THIS.grd_4c_Inc
692: 
693:         *-- Vincular grd_4c_Retrab ao cursor xMfas
694:         IF USED("xMfas")
695:             SELECT xMfas
696:             GO TOP
697: 
698:             loc_oGrdR.ColumnCount           = 4
699:             loc_oGrdR.RecordSource          = "xMfas"
700:             loc_oGrdR.Column1.ControlSource = "xmfas.nops"
701:             loc_oGrdR.Column2.ControlSource = "xmfas.nenvs"
702:             loc_oGrdR.Column3.ControlSource = "xmfas.qtds"
703:             loc_oGrdR.Column4.ControlSource = "xmfas.codpds"
704: 
705:             *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
706:             loc_oGrdR.Column1.Header1.Caption = "O. P."
707:             loc_oGrdR.Column2.Header1.Caption = "Envelope"
708:             loc_oGrdR.Column3.Header1.Caption = "Qtde"
709:             loc_oGrdR.Column4.Header1.Caption = "Produto"
710: 
711:             loc_oGrdR.Refresh
712:         ENDIF
713: 
714:         *-- Vincular grd_4c_Inc ao cursor xNensiN (ordenado por Nops)
715:         IF USED("xNensiN")
716:             SELECT xNensiN
717:             SET ORDER TO
718:             SET ORDER TO Nops
719:             GO TOP
720: 
721:             loc_oGrdI.ColumnCount           = 4
722:             loc_oGrdI.RecordSource          = "xNensiN"
723:             loc_oGrdI.Column1.ControlSource = "xnensiN.Cods"
724:             loc_oGrdI.Column2.ControlSource = "xnensiN.Qtds"
725:             loc_oGrdI.Column3.ControlSource = "xnensiN.Descs"
726:             loc_oGrdI.Column4.ControlSource = "xnensiN.Conta2s"
727: 
728:             *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
729:             loc_oGrdI.Column1.Header1.Caption = "C" + CHR(243) + "digo"
730:             loc_oGrdI.Column2.Header1.Caption = "Qtde"
731:             loc_oGrdI.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
732:             loc_oGrdI.Column4.Header1.Caption = "Funcion" + CHR(225) + "rio"
733: 
734:             loc_oGrdI.Refresh
735:         ENDIF
736: 
737:         *-- Foco inicial na coluna Envelope do grd_4c_Retrab (igual ao original)
738:         IF USED("xMfas")
739:             THIS.grd_4c_Retrab.Column2.SetFocus
740:         ENDIF
741:     ENDPROC
742: 
743:     *==========================================================================

*-- Linhas 821 a 869:
821:         ENDIF
822: 
823:         *-- Filtrar xNensiN pelo Nops da OP atual (Set Key To filtra cursor local)
824:         SELECT xNensiN
825:         SET KEY TO xMfas.Nops
826:         GO TOP
827: 
828:         IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
829:             THIS.grd_4c_Inc.Refresh
830:         ENDIF
831: 
832:         SELECT xMfas
833: 
834:         *-- Limpar imagem anterior
835:         IF PEMSTATUS(THIS, "img_4c_FigJpg", 5)
836:             CLEAR RESOURCES
837:             THIS.img_4c_FigJpg.Picture = ""
838:             THIS.img_4c_FigJpg.Visible = .F.
839:             IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
840:                 THIS.shp_4c_Shape4.Visible = .F.
841:             ENDIF
842:         ENDIF
843: 
844:         *-- Carregar imagem do produto via SQLEXEC (substitui poDataMgr.CursorQuery)
845:         TRY
846:             IF !EMPTY(xMfas.CodPds) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
847:                 loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
848:                            EscaparSQL(ALLTRIM(xMfas.CodPds))
849: 
850:                 IF USED("cursor_4c_ProdImg")
851:                     USE IN cursor_4c_ProdImg
852:                 ENDIF
853: 
854:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImg") > 0 AND ;
855:                    USED("cursor_4c_ProdImg")
856:                     IF !EMPTY(cursor_4c_ProdImg.FigJpgs) AND !ISNULL(cursor_4c_ProdImg.FigJpgs)
857:                         loc_cArquivo = SYS(2023) + "\SigPdMp5.Jpg"
858:                         loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
859:                             cursor_4c_ProdImg.FigJpgs, ;
860:                             "data:image/png;base64,",  ""), ;
861:                             "data:image/jpeg;base64,", ""), ;
862:                             "data:image/jpg;base64,",  ""), 14)
863: 
864:                         IF STRTOFILE(loc_lcFoto, loc_cArquivo) > 0 AND ;
865:                            PEMSTATUS(THIS, "img_4c_FigJpg", 5)
866:                             THIS.img_4c_FigJpg.Picture = loc_cArquivo
867:                             THIS.img_4c_FigJpg.Visible = .T.
868:                             IF PEMSTATUS(THIS, "shp_4c_Shape4", 5)
869:                                 THIS.shp_4c_Shape4.Visible = .T.

*-- Linhas 885 a 928:
885:     *==========================================================================
886:     * GrdIncAfterRowColChange - Atualiza descricao ao navegar na grade de NCs
887:     * Equivalente a Gradeinc.AfterRowColChange do original
888:     * txt_4c_Descricao tem ControlSource=xNensiN.descs; Refresh e suficiente
889:     *==========================================================================
890:     PROCEDURE GrdIncAfterRowColChange(par_nColIndex)
891:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
892:             THIS.txt_4c_Descricao.Refresh
893:         ENDIF
894:     ENDPROC
895: 
896:     *==========================================================================
897:     * BtnIncluirClick - Insere nova linha de NC para a OP corrente
898:     * Equivalente a cmdgCompo.cmdSInserir.Click do original
899:     * INSERT INTO xNensiN: Nops e Qtds vindos da OP selecionada em xMfas
900:     *==========================================================================
901:     PROCEDURE BtnIncluirClick()
902:         LOCAL loc_oErro
903: 
904:         IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
905:             RETURN
906:         ENDIF
907: 
908:         IF !USED("xNensiN") OR !USED("xMfas")
909:             RETURN
910:         ENDIF
911: 
912:         TRY
913:             INSERT INTO xNensiN (Nops, Qtds) VALUES (xMfas.Nops, xMfas.Qtds)
914: 
915:             IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
916:                 THIS.grd_4c_Inc.Refresh
917:                 THIS.grd_4c_Inc.Column1.SetFocus
918:             ENDIF
919: 
920:         CATCH TO loc_oErro
921:             MsgErro("Erro ao incluir N" + CHR(227) + "o-Conformidade: " + ;
922:                     loc_oErro.Message, "FormSigPdMp8.BtnIncluirClick")
923:         ENDTRY
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * BtnAlterarClick - Alterna o sub-dialog para modo ALTERAR
928:     * Habilita os botoes de Inclusao/Exclusao de NCs e da foco a primeira

*-- Linhas 972 a 1005:
972:     *==========================================================================
973:     * BtnExcluirClick - Exclui NC selecionada; se grade ficar vazia insere nova
974:     * Equivalente a cmdgCompo.cmdSexcluir.Click do original
975:     * DELETE registro corrente de xNensiN; se COUNT = 0 chama BtnIncluirClick
976:     *==========================================================================
977:     PROCEDURE BtnExcluirClick()
978:         LOCAL loc_nContagem, loc_oErro
979: 
980:         IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
981:             RETURN
982:         ENDIF
983: 
984:         IF !USED("xNensiN")
985:             RETURN
986:         ENDIF
987: 
988:         TRY
989:             SELECT xNensiN
990:             DELETE
991: 
992:             COUNT TO loc_nContagem
993: 
994:             IF loc_nContagem = 0
995:                 THIS.BtnIncluirClick()
996:             ENDIF
997: 
998:             GO TOP
999: 
1000:             IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
1001:                 THIS.grd_4c_Inc.Refresh
1002:                 THIS.grd_4c_Inc.Column1.SetFocus
1003:             ENDIF
1004: 
1005:         CATCH TO loc_oErro

*-- Linhas 1072 a 1137:
1072:                 RETURN
1073:             ENDIF
1074: 
1075:             loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf WHERE (Emps = " + ;
1076:                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + " OR Emps = ' ')"
1077: 
1078:             IF USED("cursor_4c_NcfTemp")
1079:                 TABLEREVERT(.T., "cursor_4c_NcfTemp")
1080:                 USE IN cursor_4c_NcfTemp
1081:             ENDIF
1082: 
1083:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NcfTemp") > 0 AND USED("cursor_4c_NcfTemp")
1084:                 SELECT cursor_4c_NcfTemp
1085:                 INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods
1086: 
1087:                 IF SEEK(UPPER(ALLTRIM(loc_cValor)))
1088:                     *-- Encontrado: capturar valores e atualizar xNensiN
1089:                     loc_cCods  = ALLTRIM(cursor_4c_NcfTemp.Cods)
1090:                     loc_cDescs = ALLTRIM(cursor_4c_NcfTemp.Descs)
1091:                     loc_nFixos = NVL(cursor_4c_NcfTemp.Fixos, 0)
1092: 
1093:                     IF USED("xNensiN")
1094:                         SELECT xNensiN
1095:                         REPLACE Fixos WITH loc_nFixos, Descs WITH loc_cDescs
1096:                     ENDIF
1097: 
1098:                     USE IN cursor_4c_NcfTemp
1099:                 ELSE
1100:                     *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
1101:                     USE IN cursor_4c_NcfTemp
1102: 
1103:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1104:                         "SigCdNcf", ;
1105:                         "cursor_4c_NcfBusca", ;
1106:                         "Cods", ;
1107:                         loc_cValor, ;
1108:                         "N" + CHR(227) + "o Conformidade")
1109:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1110:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1111:                     loc_oBusca.Show()
1112: 
1113:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NcfBusca")
1114:                         SELECT cursor_4c_NcfBusca
1115:                         loc_cCods  = ALLTRIM(cursor_4c_NcfBusca.Cods)
1116:                         loc_cDescs = ALLTRIM(cursor_4c_NcfBusca.Descs)
1117:                         loc_nFixos = NVL(cursor_4c_NcfBusca.Fixos, 0)
1118: 
1119:                         THIS.grd_4c_Inc.Column1.Text1.Value = loc_cCods
1120: 
1121:                         IF USED("xNensiN")
1122:                             SELECT xNensiN
1123:                             REPLACE Fixos WITH loc_nFixos, Descs WITH loc_cDescs
1124:                         ENDIF
1125:                     ELSE
1126:                         THIS.grd_4c_Inc.Column1.Text1.Value = ""
1127:                     ENDIF
1128: 
1129:                     IF USED("cursor_4c_NcfBusca")
1130:                         USE IN cursor_4c_NcfBusca
1131:                     ENDIF
1132: 
1133:                     loc_oBusca.Release()
1134:                     loc_oBusca = .NULL.
1135:                 ENDIF
1136: 
1137:             ELSE

*-- Linhas 1293 a 1338:
1293:         THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cEscolha
1294: 
1295:         IF USED("tmpnens") AND !EOF("tmpnens")
1296:             SELECT tmpnens
1297:             THIS.this_oBusinessObject.this_cNumps = ALLTRIM(NVL(numps, ""))
1298:             THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(emps,  ""))
1299:             THIS.this_oBusinessObject.this_cDopps = ALLTRIM(NVL(dopps, ""))
1300:         ENDIF
1301: 
1302:         IF USED("xMfas") AND !EOF("xMfas")
1303:             SELECT xMfas
1304:             THIS.this_oBusinessObject.this_nNopsMfa = NVL(Nops,   0)
1305:             THIS.this_oBusinessObject.this_nNenvs   = NVL(Nenvs,  0)
1306:             THIS.this_oBusinessObject.this_nQtdsMfa = NVL(Qtds,   0)
1307:             THIS.this_oBusinessObject.this_cCodpds  = ALLTRIM(NVL(CodPds, ""))
1308:         ENDIF
1309: 
1310:         IF USED("xNensiN") AND !EOF("xNensiN")
1311:             SELECT xNensiN
1312:             THIS.this_oBusinessObject.this_nNops    = NVL(Nops,    0)
1313:             THIS.this_oBusinessObject.this_cCods    = ALLTRIM(NVL(Cods,    ""))
1314:             THIS.this_oBusinessObject.this_nQtds    = NVL(Qtds,    0)
1315:             THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
1316:             THIS.this_oBusinessObject.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
1317:             THIS.this_oBusinessObject.this_nFixos   = NVL(Fixos,   0)
1318:         ENDIF
1319:     ENDPROC
1320: 
1321:     *==========================================================================
1322:     * BOParaForm - Atualiza controles de display com dados do BO
1323:     * Os campos de operacao (cnt_4c_Operacao) usam ControlSource nos cursores;
1324:     * basta um Refresh para sincronizar. Nenhuma atribuicao manual e necessaria.
1325:     *==========================================================================
1326:     PROCEDURE BOParaForm()
1327:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1328:             THIS.cnt_4c_Operacao.Refresh
1329:         ENDIF
1330:         IF PEMSTATUS(THIS, "grd_4c_Retrab", 5)
1331:             THIS.grd_4c_Retrab.Refresh
1332:         ENDIF
1333:         IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
1334:             THIS.grd_4c_Inc.Refresh
1335:         ENDIF
1336:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
1337:             THIS.txt_4c_Descricao.Refresh
1338:         ENDIF

*-- Linhas 1364 a 1382:
1364:     *==========================================================================
1365:     PROCEDURE LimparCampos()
1366:         IF USED("xNensiN")
1367:             SELECT xNensiN
1368:             GO TOP
1369:         ENDIF
1370: 
1371:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
1372:             THIS.txt_4c_Descricao.Refresh
1373:         ENDIF
1374: 
1375:         IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
1376:             THIS.grd_4c_Inc.Refresh
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * CarregarLista - Recarrega/atualiza ambos os grids (alias de CarregarGradeRetrab)
1382:     * Chamado quando e necessario recarregar o estado visual dos grids.

*-- Linhas 1414 a 1444:
1414:             RETURN
1415:         ENDIF
1416: 
1417:         SELECT xNensiN
1418:         SET KEY TO xMfas.Nops
1419:         GO TOP
1420: 
1421:         IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
1422:             THIS.grd_4c_Inc.Refresh
1423:         ENDIF
1424: 
1425:         IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
1426:             THIS.txt_4c_Descricao.Refresh
1427:         ENDIF
1428: 
1429:         SELECT xMfas
1430:         THIS.Refresh
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * BtnEncerrarClick - Habilita o form pai e encerra este sub-dialog
1435:     * Identico a BtnOkClick - forma padronizada de saida do sub-dialog.
1436:     *==========================================================================
1437:     PROCEDURE BtnEncerrarClick()
1438:         IF VARTYPE(THIS.this_oFormPai) = "O"
1439:             THIS.this_oFormPai.Enabled = .T.
1440:         ENDIF
1441:         THIS.Release
1442:     ENDPROC
1443: 
1444:     *==========================================================================

*-- Linhas 1471 a 1489:
1471: 
1472:         TRY
1473:             IF INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR") AND USED("xNensiN")
1474:                 SELECT xNensiN
1475:                 TABLEREVERT(.T., "xNensiN")
1476:             ENDIF
1477:         CATCH TO loc_oErro
1478:             MsgErro("Erro ao cancelar edi" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, ;
1479:                     "FormSigPdMp8.BtnCancelarClick")
1480:         ENDTRY
1481: 
1482:         IF VARTYPE(THIS.this_oFormPai) = "O"
1483:             THIS.this_oFormPai.Enabled = .T.
1484:         ENDIF
1485: 
1486:         THIS.Release
1487:     ENDPROC
1488: 
1489: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp8BO.prg):
*==============================================================================
* SigPdMp8BO.prg - Business Object para Relacao de OPs com Nao-Conformidades
* Subformulario para vincular nao-conformidades (SigCdNcf) a OPs de retrabalho
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPdMp8BO AS BusinessBase

    *-- Dados da Operacao selecionada no pai (cursor tmpnens)
    this_cNumps    = ""   && OP number (tmpnens.numps, mask 9999999999)
    this_cEmps     = ""   && Empresa (tmpnens.emps)
    this_cDopps    = ""   && Descricao da operacao (tmpnens.dopps)

    *-- Dados da OP de Retrabalho selecionada (cursor xMfas)
    this_nNopsMfa  = 0    && Numero da OP (xMfas.Nops)
    this_nNenvs    = 0    && Numero do envelope (xMfas.nenvs)
    this_nQtdsMfa  = 0    && Quantidade da OP (xMfas.Qtds)
    this_cCodpds   = ""   && Codigo do produto (xMfas.CodPds)
    this_cDpros    = ""   && Descricao do produto (SigCdPro.DPros)
    this_cFigJpgs  = ""   && Imagem base64 do produto (SigCdPro.FigJpgs)

    *-- Dados da Nao-Conformidade atual (cursor xNensiN)
    this_nNops     = 0    && Numero da OP vinculada (xNensiN.Nops)
    this_cCods     = ""   && Codigo da nao-conformidade (xNensiN.Cods)
    this_nQtds     = 0    && Quantidade com nao-conformidade (xNensiN.Qtds)
    this_cDescs    = ""   && Descricao da nao-conformidade (xNensiN.Descs)
    this_cConta2s  = ""   && Codigo do funcionario responsavel (xNensiN.Conta2s)
    this_nFixos    = 0    && Flag fixo: 2=editavel descricao (xNensiN.Fixos)

    *-- Estado interno do subformulario
    this_cAntValue  = ""   && Valor anterior do campo Cods (anti-loop Valid)
    this_cPcEscolha = ""   && Modo do form pai: INSERIR ou ALTERAR

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensiN"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna Nops do registro corrente de xNensiN
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED("xNensiN")
            SELECT xNensiN
            loc_cChave = TRANSFORM(NVL(Nops, 0))
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de alias de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops    = NVL(Nops,    0)
            THIS.this_cCods    = ALLTRIM(NVL(Cods,    ""))
            THIS.this_nQtds    = NVL(Qtds,    0)
            THIS.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
            THIS.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
            THIS.this_nFixos   = NVL(Fixos,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados minimos antes de inserir/atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF THIS.this_nNops <= 0
            MsgAviso("O n" + CHR(250) + "mero da OP deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT no cursor VFP xNensiN (replica cmdSInserir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                INSERT INTO xNensiN (Nops, Qtds) VALUES (THIS.this_nNops, THIS.this_nQtdsMfa)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - REPLACE completo no cursor VFP xNensiN
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Cods    WITH THIS.this_cCods,    ;
                        Qtds    WITH THIS.this_nQtds,    ;
                        Fixos   WITH THIS.this_nFixos,   ;
                        Descs   WITH THIS.this_cDescs,   ;
                        Conta2s WITH THIS.this_cConta2s  ;
                        IN xNensiN
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE no cursor VFP xNensiN (replica cmdSexcluir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                DELETE
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarNcf - Busca NCs em SigCdNcf via SQL Server, indexa cursor por Cods
    * Retorna .T. se par_cCods encontrado (carrega this_cDescs e this_nFixos)
    *         .F. se nao encontrado (form deve abrir FormBuscaAuxiliar)
    *==========================================================================
    FUNCTION BuscarNcf(par_cCods, par_cEmps)
        LOCAL loc_lEncontrado, loc_cSQL, loc_nRet, loc_oErro
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " OR Emps = ' '"

            IF USED("cursor_4c_Ncf")
                TABLEREVERT(.T., "cursor_4c_Ncf")
                USE IN cursor_4c_Ncf
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ncf")
            IF loc_nRet < 1
                MsgErro("Falha ao buscar N" + CHR(227) + "o-Conformidades (SigCdNcf)", "Erro")
            ELSE
                SELECT cursor_4c_Ncf
                INDEX ON Cods TAG Cods
                IF !EMPTY(par_cCods) AND SEEK(par_cCods)
                    THIS.this_cCods  = ALLTRIM(NVL(cursor_4c_Ncf.Cods,  ""))
                    THIS.this_cDescs = ALLTRIM(NVL(cursor_4c_Ncf.Descs, ""))
                    THIS.this_nFixos = NVL(cursor_4c_Ncf.Fixos, 0)
                    loc_lEncontrado  = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar N" + CHR(227) + "o-Conformidade")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *==========================================================================
    * BuscarProduto - Consulta SigCdPro para descricao e imagem do produto
    * Resultado em this_cDpros e this_cFigJpgs
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodPds)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        THIS.this_cDpros   = ""
        THIS.this_cFigJpgs = ""
        TRY
            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                       EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_Produto")
                TABLEREVERT(.T., "cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
            IF loc_nRet > 0 AND !EOF("cursor_4c_Produto")
                SELECT cursor_4c_Produto
                THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                THIS.this_cFigJpgs = NVL(FigJpgs, "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarNcfNoCursor - REPLACE Fixos e Descs no registro corrente de xNensiN
    * Chamado apos selecao/validacao de NC para sincronizar campos relacionados
    *==========================================================================
    PROCEDURE AtualizarNcfNoCursor(par_cCods, par_nFixos, par_cDescs)
        LOCAL loc_oErro
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Fixos WITH par_nFixos, ;
                        Descs WITH par_cDescs  ;
                        IN xNensiN
                THIS.this_nFixos = par_nFixos
                THIS.this_cDescs = par_cDescs
                THIS.this_cCods  = par_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC no cursor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContarNcsPorNops - Conta registros NC nao-deletados para a OP par_nNops
    * Retorna 0 se nenhuma NC restante (gatilho para auto-inserir apos Excluir)
    *==========================================================================
    FUNCTION ContarNcsPorNops(par_nNops)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                SET ORDER TO Nops
                SET KEY TO par_nNops
                COUNT TO loc_nTotal
                SET KEY TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao contar NCs")
        ENDTRY
        RETURN loc_nTotal
    ENDFUNC

ENDDEFINE

