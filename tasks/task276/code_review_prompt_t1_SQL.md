# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-ASPAS] Linha 112: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "' " + ;
- [SQL-ASPAS] Linha 182: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.CPros = '" + loc_cPro + "'"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IDIOMA, OBSCOMPRAS, DPROS

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
  DeleteMark = .F.
  Column1.ControlSource = "crProdutos.CPros"
  Column2.ControlSource = "crProdutos.Portugues"
  Column3.ControlSource = "crProdutos.Traduzido"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
Select crProdutos
	oProg.Update(.t.)
	lcQuery = [Update SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Update SigCdPro)])
	lcQuery = [Delete From SigPrPrt Where CPros = '] + lcPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Delete SigPrPrt)], 10000)
lcQuery = [Select CPros ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPrdTraduz]) < 1)
Select crPrdTraduz
	oProg.Update(.t.)
		lcQuery = [Select a.CPros, a.CGrus, a.CodCors, b.DGrus, b.Mercs, b.MontaGrDs, c.Descs ] + ;
				    [From SigCdPro a ] + ;
				    [Left Join SigCdGrp b On b.CGrus = a.CGrus ] + ;
				    [Left Join SigCdCor c On c.Cods = a.CodCors ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select crSigCdDic
			Insert Into crProdutos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
Select crProdutos
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1029 linhas total):

*-- Linhas 5 a 23:
5: *
6: * Pilares:
7: *   UX   -> layout identico ao legado (800->1000px proporcional)
8: *   BD   -> SigCdPro (UPDATE DscCompras/ObsCompras/DPros) + SigCdDic (dicionario)
9: *   CODE -> arquitetura em camadas (FormBase / SigPrDscBO)
10: *
11: * Layout original (800px) escalado para 1000px (fator 1.25)
12: * Estrutura flat:
13: *   cnt_4c_Cabecalho (Top=0, L=0, W=1000, H=80)
14: *   cmd_4c_Encerrar  (Top=3, L=910, W=75, H=75) - standalone sobre cabecalho
15: *   cmd_4c_Atualizar (Top=3, L=825, W=75, H=75) - standalone sobre cabecalho
16: *   Labels filtros + txt_4c_CProsI/F + txt_4c_CGrus + cmd_4c_Selecionar (Top=135)
17: *   grd_4c_Dados     (Top=164, L=15, W=960, H=343)
18: *==============================================================================
19: 
20: DEFINE CLASS FormSigPrDsc AS FormBase
21: 
22:     *--------------------------------------------------------------------------
23:     * Propriedades visuais (identicas ao legado, width escalado 800->1000)

*-- Linhas 71 a 89:
71:                     *-- Criar cursor placeholder para o grid
72:                     *-- Estrutura IDENTICA ao crProdutos do legado
73:                     SET NULL ON
74:                     CREATE CURSOR cursor_4c_Produtos (;
75:                         CPros       C(14)   NULL, ;
76:                         Portugues   C(254)  NULL, ;
77:                         Traduzido   C(254)  NULL, ;
78:                         DscCompras  M(10)   NULL, ;
79:                         ObsCompras  M(10)   NULL  ;
80:                     )
81:                     SET NULL OFF
82: 
83:                     *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
84:                     THIS.ConfigurarPageFrame()
85: 
86:                     *-- Configurar cabecalho cinza escuro (cntSombra do legado)
87:                     THIS.ConfigurarCabecalho()
88: 
89:                     *-- Configurar botoes de acao no canto superior direito

*-- Linhas 98 a 128:
98:                     *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
99:                     THIS.TornarControlesVisiveis(THIS)
100: 
101:                     *-- Carrega dicionario de traducoes ao abrir
102:                     THIS.CarregarDados()
103: 
104:                     loc_lSucesso = .T.
105: 
106:                 ENDIF && gb_4c_ValidandoUI
107:             ELSE
108:                 MsgErro("Falha ao criar SigPrDscBO", "Erro")
109:             ENDIF && VARTYPE(this_oBusinessObject)
110: 
111:         CATCH TO loc_oErro
112:             MsgErro("Erro ao inicializar FormSigPrDsc: " + loc_oErro.Message + ;
113:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
114:                     " Proc=" + loc_oErro.Procedure, "Erro")
115:         ENDTRY
116: 
117:         RETURN loc_lSucesso
118:     ENDPROC
119: 
120:     *==========================================================================
121:     * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
122:     * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
123:     * Este metodo define propriedades visuais globais do form.
124:     *==========================================================================
125:     PROTECTED PROCEDURE ConfigurarPageFrame
126:         THIS.BackColor  = RGB(212, 208, 200)
127:         THIS.ScrollBars = 0
128:         THIS.ShowTips   = .T.

*-- Linhas 168 a 198:
168:                 .Width    = THIS.Width
169:                 .Height   = 46
170:                 .Caption  = loc_cCaption
171:                 .FontName = "Tahoma"
172:                 .FontSize = 18
173:                 .FontBold = .T.
174:                 .BackStyle = 0
175:                 .AutoSize  = .F.
176:                 .ForeColor = RGB(255, 255, 255)
177:             ENDWITH
178:         ENDWITH
179:     ENDPROC
180: 
181:     *==========================================================================
182:     PROTECTED PROCEDURE ConfigurarBotoes
183:     *==========================================================================
184:         *-- btnSair (Encerrar): Top=3, Left=725 no legado 800px -> Left=905 em 1000px
185:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
186:         WITH THIS.cmd_4c_Encerrar
187:             .Top             = 3
188:             .Left            = 905
189:             .Width           = 75
190:             .Height          = 75
191:             .Caption         = "Encerrar"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
193:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
194:             .Themes          = .T.
195:             .FontName        = "Comic Sans MS"
196:             .FontSize        = 8
197:             .FontBold        = .T.
198:             .FontItalic      = .T.

*-- Linhas 396 a 448:
396:             .ColumnCount       = 3
397:             .RecordSource      = "cursor_4c_Produtos"
398:             .RecordMark        = .F.
399:             .DeleteMark        = .F.
400:             .AllowHeaderSizing = .F.
401:             .AllowRowSizing    = .F.
402:             .RowHeight         = 17
403:             .HeaderHeight      = 17
404:             .ScrollBars        = 2
405:             .GridLineColor     = RGB(238, 238, 238)
406:             .HighlightBackColor = RGB(255, 255, 255)
407:             .HighlightForeColor = RGB(15, 41, 104)
408:             .HighlightStyle    = 2
409:             .FontName          = "Verdana"
410:             .FontSize          = 8
411: 
412:             WITH .Column1
413:                 .ControlSource = "cursor_4c_Produtos.CPros"
414:                 .Width         = 135
415:                 .Header1.Caption   = "C" + CHR(243) + "digo"
416:                 .Header1.FontName  = "Tahoma"
417:                 .Header1.FontSize  = 8
418:                 .Header1.Alignment = 2
419:                 .ReadOnly          = .T.
420:             ENDWITH
421: 
422:             WITH .Column2
423:                 .ControlSource = "cursor_4c_Produtos.Portugues"
424:                 .Width         = 363
425:                 .ReadOnly          = .T.
426:                 .Header1.Caption   = "Portugu" + CHR(234) + "s"
427:                 .Header1.FontName  = "Tahoma"
428:                 .Header1.FontSize  = 8
429:                 .Header1.Alignment = 2
430:             ENDWITH
431: 
432:             WITH .Column3
433:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
434:                 .Width         = 424
435:                 .ReadOnly          = .T.
436:                 .Header1.Caption   = "Traduzido"
437:                 .Header1.FontName  = "Tahoma"
438:                 .Header1.FontSize  = 8
439:                 .Header1.Alignment = 2
440:             ENDWITH
441:         ENDWITH
442:     ENDPROC
443: 
444:     *==========================================================================
445:     PROCEDURE CarregarDados
446:     *==========================================================================
447:         LOCAL loc_lSucesso, loc_oErro
448:         loc_lSucesso = .F.

*-- Linhas 555 a 573:
555:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
556:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
557:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
558:                 SELECT cursor_4c_Produtos
559:                 GO TOP
560:                 THIS.grd_4c_Dados.Refresh()
561: 
562:             ENDIF && filtros preenchidos
563: 
564:         CATCH TO loc_oErro
565:             MsgErro(loc_oErro.Message, "Erro")
566:         ENDTRY
567:     ENDPROC
568: 
569:     *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
570:     PROCEDURE TxtCProsIKeyPress
571:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
572:         LOCAL loc_cCPros, loc_cSQL, loc_oErro
573: 

*-- Linhas 582 a 604:
582:         ENDIF
583: 
584:         TRY
585:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
586:             IF USED("cursor_4c_ProBusca")
587:                 USE IN cursor_4c_ProBusca
588:             ENDIF
589:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
590:                RECCOUNT("cursor_4c_ProBusca") > 0
591:                 *-- Produto encontrado: copiar para CProsF se vazio + limpar CGrus (logica legado)
592:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
593:                     THIS.txt_4c_CProsF.Value = loc_cCPros
594:                     THIS.txt_4c_CProsF.Refresh()
595:                 ENDIF
596:                 THIS.txt_4c_CGrus.Value = ""
597:                 THIS.txt_4c_CGrus.Refresh()
598:             ELSE
599:                 *-- Produto nao encontrado: abrir picker
600:                 THIS.AbrirBuscaProduto("I")
601:             ENDIF
602:             IF USED("cursor_4c_ProBusca")
603:                 USE IN cursor_4c_ProBusca
604:             ENDIF

*-- Linhas 624 a 646:
624:         ENDIF
625: 
626:         TRY
627:             loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
628:             IF USED("cursor_4c_ProBusca")
629:                 USE IN cursor_4c_ProBusca
630:             ENDIF
631:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
632:                RECCOUNT("cursor_4c_ProBusca") > 0
633:                 *-- Produto encontrado: copiar para CProsI se vazio + limpar CGrus (logica legado)
634:                 IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
635:                     THIS.txt_4c_CProsI.Value = loc_cCPros
636:                     THIS.txt_4c_CProsI.Refresh()
637:                 ENDIF
638:                 THIS.txt_4c_CGrus.Value = ""
639:                 THIS.txt_4c_CGrus.Refresh()
640:             ELSE
641:                 *-- Produto nao encontrado: abrir picker
642:                 THIS.AbrirBuscaProduto("F")
643:             ENDIF
644:             IF USED("cursor_4c_ProBusca")
645:                 USE IN cursor_4c_ProBusca
646:             ENDIF

*-- Linhas 671 a 689:
671:                 loc_oLookup.mAddColuna("CGrus", "", "Grupo")
672:                 loc_oLookup.Show()
673:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupPro")
674:                     SELECT cursor_4c_LookupPro
675:                     loc_cCodSel = ALLTRIM(cursor_4c_LookupPro.CPros)
676:                     IF par_cCampo = "I"
677:                         THIS.txt_4c_CProsI.Value = loc_cCodSel
678:                         THIS.txt_4c_CProsI.Refresh()
679:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
680:                             THIS.txt_4c_CProsF.Value = loc_cCodSel
681:                             THIS.txt_4c_CProsF.Refresh()
682:                         ENDIF
683:                     ELSE
684:                         THIS.txt_4c_CProsF.Value = loc_cCodSel
685:                         THIS.txt_4c_CProsF.Refresh()
686:                         IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
687:                             THIS.txt_4c_CProsI.Value = loc_cCodSel
688:                             THIS.txt_4c_CProsI.Refresh()
689:                         ENDIF

*-- Linhas 722 a 744:
722: 
723:         TRY
724:             *-- Verificar se grupo existe em SigCdGrp
725:             loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cCGrus)
726:             IF USED("cursor_4c_GruBusca")
727:                 USE IN cursor_4c_GruBusca
728:             ENDIF
729:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca") >= 1 AND ;
730:                RECCOUNT("cursor_4c_GruBusca") > 0
731:                 *-- Grupo encontrado: limpar intervalo de produto (logica legado)
732:                 THIS.txt_4c_CProsI.Value = ""
733:                 THIS.txt_4c_CProsF.Value = ""
734:                 THIS.txt_4c_CProsI.Refresh()
735:                 THIS.txt_4c_CProsF.Refresh()
736:             ELSE
737:                 *-- Grupo nao encontrado: abrir picker
738:                 THIS.AbrirBuscaGrupo()
739:             ENDIF
740:             IF USED("cursor_4c_GruBusca")
741:                 USE IN cursor_4c_GruBusca
742:             ENDIF
743:             THIS.AtualizarEstadoCampos()
744:         CATCH TO loc_oErro

*-- Linhas 759 a 777:
759:                 loc_oLookup.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
760:                 loc_oLookup.Show()
761:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupGru")
762:                     SELECT cursor_4c_LookupGru
763:                     THIS.txt_4c_CGrus.Value = ALLTRIM(cursor_4c_LookupGru.CGrus)
764:                     THIS.txt_4c_CGrus.Refresh()
765:                     THIS.txt_4c_CProsI.Value = ""
766:                     THIS.txt_4c_CProsF.Value = ""
767:                     THIS.txt_4c_CProsI.Refresh()
768:                     THIS.txt_4c_CProsF.Refresh()
769:                 ENDIF
770:                 IF USED("cursor_4c_LookupGru")
771:                     USE IN cursor_4c_LookupGru
772:                 ENDIF
773:             ENDIF
774: 
775:         CATCH TO loc_oErro
776:             MsgErro(loc_oErro.Message, "Erro")
777:         ENDTRY

*-- Linhas 822 a 840:
822: 
823:             *-- Zera o cursor do grid
824:             IF USED("cursor_4c_Produtos")
825:                 SELECT cursor_4c_Produtos
826:                 ZAP
827:                 THIS.grd_4c_Dados.Refresh()
828:             ENDIF
829: 
830:             THIS.cmd_4c_Atualizar.Enabled = .F.
831:             THIS.this_cModoAtual = "SELECIONAR"
832: 
833:             *-- Foca no primeiro campo de filtro
834:             THIS.txt_4c_CProsI.SetFocus()
835:         CATCH TO loc_oErro
836:             MsgErro(loc_oErro.Message, "Erro")
837:         ENDTRY
838:     ENDPROC
839: 
840:     PROCEDURE BtnAlterarClick

*-- Linhas 850 a 868:
850:             THIS.BtnSelecionarClick()
851: 
852:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
853:                 SELECT cursor_4c_Produtos
854:                 GO TOP
855:                 THIS.grd_4c_Dados.SetFocus()
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message, "Erro")
859:         ENDTRY
860:     ENDPROC
861: 
862:     PROCEDURE BtnExcluirClick
863:         LOCAL loc_lConfirma, loc_oErro
864:         TRY
865:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
866:                 MsgAviso("Nenhum produto selecionado para remover.", ;
867:                         "Aten" + CHR(231) + CHR(227) + "o")
868:                 RETURN

*-- Linhas 875 a 900:
875: 
876:             IF loc_lConfirma
877:                 LOCAL loc_nRestantes
878:                 SELECT cursor_4c_Produtos
879:                 DELETE
880:                 SET DELETED ON
881:                 THIS.grd_4c_Dados.Refresh()
882: 
883:                 *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
884:                 SELECT cursor_4c_Produtos
885:                 COUNT FOR NOT DELETED() TO loc_nRestantes
886:                 THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
887:             ENDIF
888:         CATCH TO loc_oErro
889:             MsgErro(loc_oErro.Message, "Erro")
890:         ENDTRY
891:     ENDPROC
892: 
893:     *==========================================================================
894:     * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
895:     * Implementacao especifica do form OPERACIONAL SigPrDsc.
896:     * Substituem stubs do FormBase com logica real do form.
897:     *==========================================================================
898: 
899:     *-- BtnBuscarClick: executa selecao de produtos (equivalente a Buscar em CRUD)
900:     PROCEDURE BtnBuscarClick

*-- Linhas 963 a 981:
963:             THIS.txt_4c_CGrus.Refresh()
964:         ENDIF
965:         IF USED("cursor_4c_Produtos")
966:             SELECT cursor_4c_Produtos
967:             ZAP
968:         ENDIF
969:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
970:             THIS.grd_4c_Dados.Refresh()
971:         ENDIF
972:         IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
973:             THIS.cmd_4c_Atualizar.Enabled = .F.
974:         ENDIF
975:         THIS.HabilitarCampos(.T.)
976:         THIS.this_cModoAtual = "SELECIONAR"
977:     ENDPROC
978: 
979:     *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
980:     *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
981:     *-- apenas ao acionar Selecionar.


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SigPrDscBO.prg - Business Object para Montagem de Descricao de Produtos
* Herda de BusinessBase
* Tabela principal: SigCdPro (atualiza DscCompras/ObsCompras/DPros)
* Tabelas auxiliares: SigCdDic (dicionario), SigCdGrp, SigCdCor, SigPrPrt
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "CPros"

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cCProsI = ""  && produto inicial do intervalo C(14)
    this_cCProsF = ""  && produto final do intervalo   C(14)
    this_cCGrus  = ""  && grupo de produto (filtro alternativo) C(3)

    *--------------------------------------------------------------------------
    * Controle de processamento e gravacao
    *--------------------------------------------------------------------------
    this_nTotalProcessados = 0
    this_nTotalGravados    = 0
    this_lGravadoOk        = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCProsI + "-" + THIS.this_cCProsF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    * Cursor esperado: alias de SigCdPro com ao menos CPros/CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCProsI = TratarNulo(CPros, "C")
                THIS.this_cCProsF = TratarNulo(CPros, "C")
                THIS.this_cCGrus  = TratarNulo(CGrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDicionario - carrega dicionario de traducoes de SigCdDic
    * Popula cursor_4c_Dicionario (Expressao/Traducao, ordenado por tamanho desc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDicionario()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio de tradu" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - SELECT de produtos baseado nos filtros do BO
    * Popula cursor_4c_ProdTemp (CPros apenas - lista de codigos)
    * Pre-requisito: this_cCProsI/F e this_cCGrus ja setados pelo form
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPrI, loc_cPrF, loc_cGru, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cPrI = PADR(THIS.this_cCProsI, 14)
            loc_cPrF = PADR(THIS.this_cCProsF, 14)
            loc_cGru = PADR(THIS.this_cCGrus, 3)

            IF !EMPTY(ALLTRIM(loc_cGru))
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CGrus = " + EscaparSQL(ALLTRIM(loc_cGru)) + " " + ;
                           "ORDER BY CPros"
            ELSE
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "' " + ;
                           "ORDER BY CPros"
            ENDIF

            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp") < 1
                MsgErro("Falha ao buscar produtos.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTraducoes - processa produtos e preenche cursor_4c_Produtos
    * Equivalente ao PROCEDURE processamento do legado (SIGPRDSC.processamento)
    * Pre-requisito: cursor_4c_Dicionario carregado via BuscarDicionario()
    * Pre-requisito: cursor_4c_Produtos criado pelo form (CREATE CURSOR)
    * Pos-execucao: cursor_4c_Produtos contem (CPros/Portugues/Traduzido/DscCompras/ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarTraducoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPro, loc_cDes, loc_cIni
        LOCAL loc_cIng, loc_nGrD, loc_oProg, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Busca lista de produtos no SQL Server
            IF !THIS.BuscarProdutos()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_ProdTemp") OR RECCOUNT("cursor_4c_ProdTemp") = 0
                MsgAviso("Nenhum produto encontrado para os filtros informados.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Zera cursor de resultado do form
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            THIS.this_nTotalProcessados = 0

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_ProdTemp"))
            loc_oProg.Show

            SELECT cursor_4c_ProdTemp
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_ProdTemp.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    *-- Busca dados complementares: grupo + cor do produto
                    loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                               "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                               "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                               "WHERE a.CPros = '" + loc_cPro + "'"

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") >= 1
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_nGrD = NVL(cursor_4c_LocalPro.MontaGrDs, 0)
                        IF loc_nGrD = 1
                            *-- MontaGrDs=1: incluir descricao do grupo (DGrus) + cor (Descs)
                            loc_cDes = ALLTRIM(;
                                ALLTRIM(NVL(cursor_4c_LocalPro.DGrus, "")) + " " + ;
                                ALLTRIM(NVL(cursor_4c_LocalPro.Descs, "")))
                        ELSE
                            *-- MontaGrDs=0: apenas descricao de cor (Descs)
                            loc_cDes = ALLTRIM(NVL(cursor_4c_LocalPro.Descs, ""))
                        ENDIF

                        IF !EMPTY(loc_cDes)
                            loc_cIng = loc_cDes

                            *-- Aplica substituicoes do dicionario portugues->ingles
                            IF USED("cursor_4c_Dicionario")
                                SELECT cursor_4c_Dicionario
                                GO TOP
                                SCAN
                                    loc_cIng = STRTRAN(loc_cIng, ;
                                        ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                        ALLTRIM(cursor_4c_Dicionario.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Remove aspas simples e duplas (protecao SQL)
                            loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                            loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                            *-- Insere no cursor de produtos (DscCompras=traduzido, ObsCompras=portugues)
                            SELECT cursor_4c_Produtos
                            INSERT INTO cursor_4c_Produtos ;
                                (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                                VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                            THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
                        ENDIF

                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            SELECT cursor_4c_Produtos
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - grava descricoes nos produtos (UPDATE SigCdPro)
    * Equivalente ao PROCEDURE gravacao do legado (SIGPRDSC.gravacao)
    * Pre-requisito: cursor_4c_Produtos populado por ProcessarTraducoes()
    * Cada produto: UPDATE SigCdPro + DELETE SigPrPrt com commit individual
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes()
        LOCAL loc_lSucesso, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_oProg, loc_nTotal, loc_oErro
        loc_lSucesso = .F.
        loc_lOks     = .T.
        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_nTotal = RECCOUNT("cursor_4c_Produtos")
            IF loc_nTotal = 0
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_nTotalGravados = 0
            THIS.this_lGravadoOk     = .F.

            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOks
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(cursor_4c_Produtos.DscCompras) + ", " + ;
                               "ObsCompras = " + EscaparSQL(cursor_4c_Produtos.ObsCompras) + ", " + ;
                               "DPros = " + EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + " " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao atualizar produto " + loc_cPro + " em SigCdPro.", "Erro")
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE FROM SigPrPrt: remove produto enviado
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao excluir produto " + loc_cPro + " de SigPrPrt.", "Erro")
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_nTotalGravados = THIS.this_nTotalGravados + 1
                ELSE
                    SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            IF loc_lOks
                THIS.this_lGravadoOk = .T.
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - grava as descricoes traduzidas (equivalente a UPDATE em lote)
    * Form OPERACIONAL: unico caminho de persistencia disponivel.
    * Espelha o botao btnAtualizar do legado -> chama gravacao/GravarDescricoes.
    * RegistrarAuditoria eh disparada dentro de GravarDescricoes ao final do lote.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.GravarDescricoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - nao aplicavel a este form OPERACIONAL (nao cria produtos novos)
    * O form atualiza descricoes de produtos ja existentes em SigCdPro.
    * Delegamos a Atualizar para manter contrato de BusinessBase e evitar
    * insercao acidental de registros pelo fluxo padrao Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.Atualizar()
    ENDPROC

ENDDEFINE

