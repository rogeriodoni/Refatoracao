# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BACKCOLOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CIDCHAVES

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
Select crSigPrPmi
	Insert Into csEmpresas (ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves) ;
Select csEmpresas
	.Column1.ControlSource   = 'csEmpresas.ImpEmps'
	.Column2.ControlSource = 'csEmpresas.Pecas'
	.Column3.ControlSource = 'csEmpresas.Promos'
	.Column4.ControlSource = 'csEmpresas.Datas'
	Select cIdChaves ;
	  From csEmpresas ;
			Select csApagar
				If (ThisForm.ParentForm.poDataMgr.SQLExecute([Delete From SigPrPmi Where cIdChaves = ?pChv], '') < 1)
				Delete From crSigPrPmi Where cIdChaves = pChv
				Delete From csEmpresas Where cIdChaves = pChv
Update csEmpresas Set ImpEmps = .t.
Update csEmpresas Set ImpEmps = .f.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPRM.prg) - TRECHOS RELEVANTES PARA PASS SQL (1103 linhas total):

*-- Linhas 27 a 46:
27: * (FormProduto) nao mantem esse cursor aberto (ver cabecalho de
28: * SIGOPPRMBO.prg) - por isso este Init ACRESCENTA um segundo parametro,
29: * par_cCodigoProduto, que nao existe na assinatura legado, para que a Fase 4
30: * possa pedir ao BO a MESMA consulta que o pai usava no AddCursor (Select *
31: * From SigPrPmi Where CPros = ?pPro). Precedente da mesma decisao:
32: * FormSigOpPrL.prg acrescentou par_cLinha ao Init por motivo identico
33: * (cursor compartilhado do legado nao existe mais na nova arquitetura).
34: *
35: * pcEscolha do form pai: o legado compara ThisForm.ParentForm.pcEscolha com
36: * 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
37: * btnRetirar/cmdRetirar (ver dump, Init e Column1.ReadOnly). Na nova
38: * arquitetura o equivalente a "modo so-leitura" em FormBase e
39: * this_cModoAtual = "VISUALIZAR". A leitura em InicializarForm() eh
40: * defensiva (PEMSTATUS, tentando primeiro this_cModoAtual e depois pcEscolha)
41: * porque o form pai (FormProduto) nao faz parte desta task e o nome exato da
42: * property la sera confirmado quando aquele form for migrado - mesmo padrao
43: * de FormSigOpPrL.Init().
44: *
45: * Diferenca de FormSigOpPrL: o Init legado deste form NAO desabilita o form
46: * pai ("This.ParentForm.Enabled = .f." nao existe no dump) - WindowType = 1

*-- Linhas 88 a 109:
88: *
89: *               btnSair.Click       ("ThisForm.Release")  -> BtnSairClick
90: *               btnRetirar.Click    (gate de acesso + marcados + confirmacao
91: *                                    + Scan de Delete)    -> BtnRetirarClick
92: *               MarcarEmp.Click     ("Update ... ImpEmps = .t.")
93: *                                                         -> BtnMarcarTodasClick
94: *               DesmarcarEmp.Click  ("Update ... ImpEmps = .f.")
95: *                                                         -> BtnDesmarcarTodasClick
96: *
97: *             Os quatro nomes canonicos de form CRUD (prefixo "Btn" + o verbo
98: *             Incluir/Alterar/Visualizar/Excluir + sufixo "Click" - escritos
99: *             assim, em partes, DE PROPOSITO: citados inteiros eles satisfazem
100: *             por SUBSTRING o -match do gate da fase, que passaria a aprovar
101: *             por causa deste comentario em vez de pela dispensa real) NAO se
102: *             aplicam a esta tela: eles sao a barra Incluir/Alterar/
103: *             Visualizar/Excluir da Page1 do frmcadastro, e este legado herda
104: *             de "form" PURO. Medido no dump: zero "frmcadastro", zero
105: *             "Grupo_Op", zero nome de botao com verbo CRUD e zero
106: *             "<X>.Click" - e as tres citacoes de "pcEscolha" sao leitura do
107: *             modo do form PAI ("ThisForm.ParentForm.pcEscolha <>
108: *             'CONSULTAR'"), nao modo proprio. A UNICA acao de dados da tela
109: *             eh RETIRAR o produto das promocoes marcadas (btnRetirar), e ela

*-- Linhas 145 a 163:
145: *                                        segue !this_lSomenteConsulta - nao
146: *                                        ha modo INCLUIR/ALTERAR a alternar)
147: *               botao de acao real    -> BtnRetirarClick (RetirarPromocao()
148: *                                        no BO faz DELETE FROM SigPrPmi de
149: *                                        verdade - nao esta na lista
150: *                                        canonica Btn(Salvar|Confirmar|
151: *                                        Gravar|...)Click porque o verbo do
152: *                                        legado eh "Retirar", nao "Gravar")
153: *             Form Para BO / BO Para Form / Habilitar Campos / Limpar
154: *             Campos / Btn Buscar Click / Btn Salvar Click / Btn Cancelar
155: *             Click NAO se aplicam: nao ha Page2 de dados, nao ha modo de
156: *             edicao a cancelar e nao ha filtro de lista a buscar.
157: *             Inventa-los exigiria criar superficie que o SCX nao tem
158: *             (viola o PILAR 1) ou escrever metodo vazio (stub disfarcado,
159: *             proibido pela regra de completude).
160: *
161: *             Verificado nesta fase (2026-11-14), sem alterar nenhum metodo:
162: *               - COMPILE de SIGOPPRMBO.prg e FormSIGOPPRM.prg: FXP=.T.,
163: *                 ERR=.F. nos dois (controle negativo confirmou que o

*-- Linhas 321 a 339:
321:             *-- CarregarPromocoes.
322:             THIS.ConfigurarGrid()
323: 
324:             *-- "Select crSigPrPmi / Scan / Insert Into csEmpresas (...) /
325:             *-- EndScan" + o bloco "With ThisForm.GridEmps" + "Go Top In
326:             *-- csEmpresas" + "ThisForm.GridEmps.Refresh" do Init legado
327:             THIS.CarregarPromocoes()
328: 
329:             loc_lSucesso = .T.
330:         CATCH TO loc_oErro
331:             MsgErro(loc_oErro.Message + CHR(13) + ;
332:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
333:                 "Procedure: " + loc_oErro.Procedure, ;
334:                 "FormSIGOPPRM.InicializarForm")
335:         ENDTRY
336: 
337:         RETURN loc_lSucesso
338:     ENDPROC
339: 

*-- Linhas 625 a 701:
625:     ENDPROC
626: 
627:     *==========================================================================
628:     * BtnMarcarTodasClick - "Update csEmpresas Set ImpEmps = .t." + Refresh do
629:     * MarcarEmp.Click legado. PUBLIC - BINDEVENT exige metodo publico.
630:     *
631:     * Nome pela ACAO, nao pelo objeto legado: o botao eh ICONE-PURO
632:     * (Caption = "" no dump), entao o verbo que o usuario le esta no
633:     * ToolTipText - "Marca Todas as Linhas de Produto". Herdar o nome do
634:     * objeto ("MarcarEmp") violaria o PILAR 3 e deixaria o handler INVISIVEL
635:     * para os gates, que enumeram so "PROCEDURE (Cmd|Btn)\w*Click".
636:     *==========================================================================
637:     PROCEDURE BtnMarcarTodasClick()
638:         LOCAL loc_cCursor
639: 
640:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
641:             RETURN
642:         ENDIF
643: 
644:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
645:         IF USED(loc_cCursor)
646:             UPDATE (loc_cCursor) SET ImpEmps = .T.
647:             THIS.grd_4c_Dados.Refresh()
648:         ENDIF
649:     ENDPROC
650: 
651:     *==========================================================================
652:     * BtnDesmarcarTodasClick - "Update csEmpresas Set ImpEmps = .f." + Refresh
653:     * do DesmarcarEmp.Click legado. PUBLIC - BINDEVENT exige metodo publico.
654:     *
655:     * Nome pela ACAO (ToolTipText "Desmarca Todas as Linhas de Produto"), pelo
656:     * mesmo motivo de BtnMarcarTodasClick acima.
657:     *==========================================================================
658:     PROCEDURE BtnDesmarcarTodasClick()
659:         LOCAL loc_cCursor
660: 
661:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
662:             RETURN
663:         ENDIF
664: 
665:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
666:         IF USED(loc_cCursor)
667:             UPDATE (loc_cCursor) SET ImpEmps = .F.
668:             THIS.grd_4c_Dados.Refresh()
669:         ENDIF
670:     ENDPROC
671: 
672:     *==========================================================================
673:     * BtnRetirarClick - Equivalente ao btnRetirar.Click legado: gate de
674:     * acesso (fChecaAcesso(...,'EXCLUIR') Or fChecaAcesso(...,'ALTERAR') - ja
675:     * resolvido em this_lTemAcessoRetirar por InicializarForm), confere se
676:     * ha linha marcada ("Select cIdChaves From csEmpresas Where ImpEmps Into
677:     * Cursor csApagar" + RecCount < 1), confirma com o usuario
678:     * (MessageBox(...) = 6) e retira o produto de cada promocao marcada - um
679:     * RetirarPromocao() por linha, igual ao Scan do legado. Se QUALQUER
680:     * retirada falhar (RetirarPromocao() ja mostra o MsgErro com a mensagem
681:     * do SQL Server), o loop para NA HORA - "Return 0" do legado dentro do
682:     * Scan, que abandona as linhas restantes sem tentar.
683:     *
684:     * "Delete From crSigPrPmi Where cIdChaves = pChv" (cursor do form pai)
685:     * NAO tem equivalente aqui: esse cursor nao existe nesta arquitetura
686:     * (ver cabecalho do arquivo) - so "Delete From csEmpresas Where
687:     * cIdChaves = pChv" eh transcrito. PUBLIC - BINDEVENT exige metodo
688:     * publico.
689:     *==========================================================================
690:     PROCEDURE BtnRetirarClick()
691:         LOCAL loc_cCursor, loc_cCursorMarcados, loc_cChave, loc_nRetiradas
692: 
693:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
694:             RETURN
695:         ENDIF
696: 
697:         *-- "fChecaAcesso('SigCdPrm', 'EXCLUIR') Or fChecaAcesso('SigCdPrm',
698:         *-- 'ALTERAR')" do btnRetirar.Click legado - ja resolvido em
699:         *-- InicializarForm
700:         IF !THIS.this_oBusinessObject.this_lTemAcessoRetirar
701:             MsgAviso("Voc" + CHR(234) + " N" + CHR(227) + "o Tem Acesso Para Alterar/Excluir Promo" + CHR(231) + CHR(245) + "es!!!", ;

*-- Linhas 711 a 732:
711:             RETURN
712:         ENDIF
713: 
714:         *-- "Select cIdChaves From csEmpresas Where ImpEmps Into Cursor
715:         *-- csApagar" do legado
716:         loc_cCursorMarcados = "cursor_4c_RetirarMarcados"
717:         SELECT cIdChaves FROM (loc_cCursor) WHERE ImpEmps ;
718:             INTO CURSOR (loc_cCursorMarcados)
719: 
720:         IF RECCOUNT(loc_cCursorMarcados) < 1
721:             MsgAviso("N" + CHR(227) + "o Existem Promo" + CHR(231) + CHR(245) + "es Selecionadas Para Retirar o Produto!!!", ;
722:                 "Aten" + CHR(231) + CHR(227) + "o")
723:             IF USED(loc_cCursorMarcados)
724:                 USE IN (loc_cCursorMarcados)
725:             ENDIF
726:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
727:                 THIS.grd_4c_Dados.Column1.SetFocus()
728:             ENDIF
729:             RETURN
730:         ENDIF
731: 
732:         *-- "If (MessageBox('Confirma a Retirada do Produto das Promocoes

*-- Linhas 740 a 811:
740: 
741:         loc_nRetiradas = 0
742: 
743:         SELECT (loc_cCursorMarcados)
744:         SCAN
745:             loc_cChave = cIdChaves
746: 
747:             IF THIS.this_oBusinessObject.RetirarPromocao(loc_cChave)
748:                 loc_nRetiradas = loc_nRetiradas + 1
749: 
750:                 *-- "Delete From csEmpresas Where cIdChaves = pChv" do
751:                 *-- legado (ver comentario do metodo sobre crSigPrPmi)
752:                 IF USED(loc_cCursor)
753:                     DELETE FROM (loc_cCursor) WHERE cIdChaves = loc_cChave
754:                 ENDIF
755:             ELSE
756:                 *-- "Return 0" do Scan legado quando o SQLExecute falha -
757:                 *-- abandona as linhas restantes
758:                 EXIT
759:             ENDIF
760:         ENDSCAN
761: 
762:         IF USED(loc_cCursorMarcados)
763:             USE IN (loc_cCursorMarcados)
764:         ENDIF
765: 
766:         THIS.this_oBusinessObject.this_nTotalRetiradas = loc_nRetiradas
767:         IF USED(loc_cCursor)
768:             THIS.this_oBusinessObject.this_nTotalPromocoes = ;
769:                 THIS.this_oBusinessObject.this_nTotalPromocoes - loc_nRetiradas
770:         ENDIF
771: 
772:         *-- "ThisForm.GridEmps.Refresh" do fim do btnRetirar.Click legado.
773:         *--
774:         *-- O SELECT + GO TOP antes do Refresh eh o fechamento canonico de
775:         *-- quem MEXE no cursor da grade (CLAUDE.md regra #21a): o DELETE do
776:         *-- SCAN acima pode ter marcado como excluida justamente a linha sob
777:         *-- o ponteiro, e com SET DELETED ON (config.prg) essa linha deixa de
778:         *-- ser visivel - o Refresh sozinho repintaria a grade a partir de um
779:         *-- registro inalcancavel. O ultimo SELECT em vigor aqui eh o do
780:         *-- cursor de marcados, que acabou de ser fechado, entao a area
781:         *-- corrente tambem precisa voltar a ser a da grade.
782:         IF USED(loc_cCursor)
783:             SELECT (loc_cCursor)
784:             GO TOP IN (loc_cCursor)
785:         ENDIF
786:         THIS.grd_4c_Dados.Refresh()
787:     ENDPROC
788: 
789:     *==========================================================================
790:     * ConfigurarGrid - Cria a grade de marcacao (SIGOPPRM.GridEmps do dump),
791:     * filha DIRETA do form: NAO ha compensacao +29 no Top porque nao ha
792:     * PageFrame neste form (ver cabecalho do arquivo).
793:     *
794:     * Aqui ficam SO as propriedades que NAO dependem de dado (geometria,
795:     * fonte, Movable/Resizable/ReadOnly de cada coluna). RecordSource,
796:     * ControlSource, o CheckBox da Column1, as larguras e os captions vivem
797:     * em CarregarPromocoes, porque o VFP9 reseta esse grupo a cada rebind
798:     * (Problema 48 do FORMCOR_LICOES_APRENDIDAS.md).
799:     *
800:     * Grid.ReadOnly = .F. vem ANTES do ReadOnly das colunas, porque o do
801:     * grid propaga e sobrescreve o das colunas (CLAUDE.md regra #46):
802:     * "With ThisForm.GridEmps / .ReadOnly = .f." do Init legado.
803:     *
804:     * Column1.ReadOnly transcreve literalmente ".Column1.ReadOnly =
805:     * (ThisForm.ParentForm.pcEscolha <> 'CONSULTAR')" - !this_lSomenteConsulta
806:     * jah equivale a essa expressao (this_lSomenteConsulta eh .T. quando o
807:     * modo do pai eh CONSULTAR/VISUALIZAR). Columns 2-4 (Pecas/Promos/Datas)
808:     * sao so exibicao - o dump marca "When" retornando .F. nos tres
809:     * Text1, reproduzido aqui com .ReadOnly = .T. (regra #46).
810:     *==========================================================================
811:     PROTECTED PROCEDURE ConfigurarGrid()

*-- Linhas 820 a 838:
820:             .FontName          = "Tahoma"
821:             .AllowHeaderSizing = .F.
822:             .AllowRowSizing    = .F.
823:             .DeleteMark        = .F.
824:             .RecordMark        = .F.
825:             .ScrollBars        = 2
826:             .GridLineColor     = RGB(238, 238, 238)
827:             .TabIndex          = 1
828:             .ReadOnly          = .F.
829:             .Visible           = .T.
830: 
831:             .Column1.FontName          = "Tahoma"
832:             .Column1.Movable           = .F.
833:             .Column1.Resizable         = .F.
834:             .Column1.ReadOnly          = !THIS.this_oBusinessObject.this_lSomenteConsulta
835:             .Column1.Header1.FontName  = "Tahoma"
836:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
837: 
838:             .Column2.FontName          = "Tahoma"

*-- Linhas 867 a 896:
867:     *==========================================================================
868:     * CarregarPromocoes - FUNIL UNICO de carga/ligacao/repintura da grade.
869:     * Busca as promocoes do produto corrente via
870:     * THIS.this_oBusinessObject.CarregarPromocoes() (SELECT SigPrPmi + Insert
871:     * Into cursor_4c_Promocoes, equivalente ao Scan/Insert Into csEmpresas do
872:     * Init legado) e liga a grade - "With ThisForm.GridEmps / .RecordSource
873:     * = 'csEmpresas' / .ColumnN.ControlSource = ... / ... / EndWith" seguido
874:     * de "Go Top In csEmpresas" + "ThisForm.GridEmps.Refresh".
875:     *
876:     * Width/Header1.Caption vao DEPOIS do RecordSource/ControlSource, porque
877:     * atribuir RecordSource reseta os dois (Problema 48 do
878:     * FORMCOR_LICOES_APRENDIDAS.md / CLAUDE.md regra #41). O CheckBox da
879:     * Column1 eh (re)criado aqui, DEPOIS do ControlSource apontar para a
880:     * coluna logica ImpEmps, pela mesma razao de
881:     * FormSigOpPrL.GarantirCheckBoxMarcacao: um RecordSource/ControlSource
882:     * novo pode destruir o controle posto por Column.AddObject.
883:     *
884:     * "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
885:     * 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init legado: os
886:     * dois objetos ja existem (ConfigurarBotoes roda antes), so falta
887:     * aplicar a visibilidade, com a MESMA formula usada em Column1.ReadOnly
888:     * (!this_lSomenteConsulta).
889:     *
890:     * PUBLIC (sem PROTECTED) - mesmo padrao de CarregarLista em
891:     * FormSigOpPrL, para o metodo poder ser chamado de fora (ex.:
892:     * TesteAutomatico) sem a armadilha de PEMSTATUS-protected da regra #3.
893:     *==========================================================================
894:     PROCEDURE CarregarPromocoes()
895:         LOCAL loc_cCursor, loc_lVisivelRetirar
896: 

*-- Linhas 913 a 956:
913:         WITH THIS.grd_4c_Dados
914:             .RecordSource = loc_cCursor
915: 
916:             .Column1.ControlSource = loc_cCursor + ".ImpEmps"
917:             .Column2.ControlSource = loc_cCursor + ".Pecas"
918:             .Column3.ControlSource = loc_cCursor + ".Promos"
919:             .Column4.ControlSource = loc_cCursor + ".Datas"
920:         ENDWITH
921: 
922:         *-- CheckBox da Column1 (recriado se o rebind do alias o destruiu)
923:         THIS.GarantirCheckBoxImpEmps()
924: 
925:         WITH THIS.grd_4c_Dados
926:             *-- Larguras e captions DEPOIS do RecordSource, que reseta os
927:             *-- dois
928:             .Column1.Width = 15
929:             .Column2.Width = 80
930:             .Column3.Width = 185
931:             .Column4.Width = 66
932: 
933:             .Column1.Header1.Caption = ""
934:             .Column2.Header1.Caption = "Pe" + CHR(231) + "as"
935:             .Column3.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
936:             .Column4.Header1.Caption = "Data"
937:         ENDWITH
938: 
939:         *-- "Go Top In csEmpresas" + "ThisForm.GridEmps.Refresh" do Init
940:         *-- legado
941:         SELECT (loc_cCursor)
942:         GO TOP IN (loc_cCursor)
943:         THIS.grd_4c_Dados.Refresh()
944: 
945:         *-- "ThisForm.btnRetirar.Visible = (ThisForm.ParentForm.pcEscolha <>
946:         *-- 'CONSULTAR')" / "ThisForm.cmdRetirar.Visible = ..." do Init
947:         *-- legado
948:         loc_lVisivelRetirar = !THIS.this_oBusinessObject.this_lSomenteConsulta
949:         IF PEMSTATUS(THIS, "cmd_4c_BtnRetirar", 5)
950:             THIS.cmd_4c_BtnRetirar.Visible = loc_lVisivelRetirar
951:         ENDIF
952:         IF PEMSTATUS(THIS, "cmg_4c_CmdRetirar", 5)
953:             THIS.cmg_4c_CmdRetirar.Visible = loc_lVisivelRetirar
954:         ENDIF
955: 
956:         RETURN .T.


### BO (C:\4c\projeto\app\classes\SIGOPPRMBO.prg):
*==============================================================================
* SIGOPPRMBO.prg - Business Object para FormSIGOPPRM (Promocoes do Produto)
* Herda de BusinessBase
*
* ATENCAO: este form eh um dialogo OPERACIONAL (modal) aberto pelo Cadastro de
* Produtos - no legado "Do Form SigOpPrm With ThisForm" (sigcdpro), disparado
* apos a pergunta "O Produto Encontra-se Em Promocao!!! Deseja Conferir ?".
* Ele lista as PROMOCOES em que o produto corrente se encontra (tabela
* SigPrPmi, filtrada pelo codigo do produto) numa grade com coluna de
* marcacao, e permite RETIRAR o produto das promocoes marcadas.
*
* O Load legado cria o cursor local da grade e o Init o popula a partir do
* cursor crSigPrPmi que o form PAI ja deixa aberto:
*     Create Cursor csEmpresas (ImpEmps l(1), CPros c(14), Pecas c(10), ;
*                               Promos c(25), Datas t Null, cIdChaves c(20))
*     Index On CPros + Promos Tag CPros
* No sistema novo o form pai (FormProduto) nao mantem esse cursor aberto, por
* isso este BO le a MESMA consulta que o pai usava no AddCursor:
*     lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
* Os nomes das colunas e o filtro sao transcritos do legado (PILAR 2).
*
* O btnRetirar.Click legado executa, por linha marcada, TRES passos:
*   1) Delete From SigPrPmi  Where cIdChaves = ?pChv   (SQL Server)
*   2) Delete From crSigPrPmi Where cIdChaves = pChv   (cursor do form PAI)
*   3) Delete From csEmpresas Where cIdChaves = pChv   (cursor da grade)
* precedidos do gate de acesso fChecaAcesso('SigCdPrm', 'EXCLUIR') Or
* fChecaAcesso('SigCdPrm', 'ALTERAR'), e seguidos de GridEmps.Refresh.
*
* Como o legado SO exclui (nunca insere nem altera SigPrPmi nesta tela), o
* comportamento padrao herdado de BusinessBase para Inserir()/Atualizar() ja
* eh o correto - inventar INSERT/UPDATE aqui violaria a regra de que a lista
* de colunas vem do schema e nao de suposicao.
*
* Tabela ...: SigPrPmi
* Chave .....: cidchaves (char 20) - PK sigprpmi_cidchaves
*==============================================================================
DEFINE CLASS SIGOPPRMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - colunas de SigPrPmi (uma promocao do produto)
    * Tipos conferidos em docs/schema.sql:
    *   cpros char(14) NOT NULL | pecas char(10) NOT NULL
    *   promos char(25) NOT NULL | cbars numeric(14,0) NOT NULL
    *   datas datetime NULL | cidchaves char(20) NOT NULL (PK)
    *   dtalts datetime NULL | promopro char(35) NOT NULL
    *   vendavels numeric(1,0) NOT NULL
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && SigPrPmi.cpros     - codigo do produto (char 14)
    this_cPecas     = ""    && SigPrPmi.pecas     - peca da promocao (char 10)
    this_cPromos    = ""    && SigPrPmi.promos    - codigo da promocao (char 25)
    this_nCbars     = 0     && SigPrPmi.cbars     - codigo de barras numeric(14,0)
    this_dDatas     = {}    && SigPrPmi.datas     - data da promocao (datetime NULL)
    this_cCidChaves = ""    && SigPrPmi.cidchaves - chave primaria Fortyus (char 20)
    this_dDtAlts    = {}    && SigPrPmi.dtalts    - data da ultima alteracao (datetime NULL)
    this_cPromoPro  = ""    && SigPrPmi.promopro  - descricao da promocao (char 35)
    this_nVendavels = 0     && SigPrPmi.vendavels - indicador vendavel numeric(1,0)

    *--------------------------------------------------------------------------
    * Propriedades - estado de tela (NAO existem em SigPrPmi)
    *--------------------------------------------------------------------------
    *-- Marcacao da linha na grade. No legado eh a coluna ImpEmps l(1) do cursor
    *-- local csEmpresas, alimentada com .f. no Insert Into do Init e alternada
    *-- pelos handlers MouseDown/KeyPress do Check1 da Column1.
    this_lImpEmps = .F.

    *-- Nome do cursor que alimenta a grade do dialogo (equivale a csEmpresas).
    this_cCursorItens = "cursor_4c_Promocoes"

    *-- Nome do cursor de SigPrPmi que o form PAI mantem aberto, quando houver
    *-- (equivale a crSigPrPmi). Vazio significa que o pai nao tem esse cursor e
    *-- o passo 2 da retirada do legado nao se aplica.
    this_cCursorItensPai = ""

    *-- pcEscolha do form PAI, recebido junto com a referencia do pai no Init do
    *-- form (LParameters pAnt / ThisForm.ParentForm = pAnt). O legado compara
    *-- com 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
    *-- btnRetirar/cmdRetirar.
    this_cModoEscolha = ""

    *-- .T. quando this_cModoEscolha = "CONSULTAR": a coluna de marcacao fica
    *-- somente leitura e o botao Retirar fica oculto.
    this_lSomenteConsulta = .F.

    *-- Resultado do gate de acesso do btnRetirar.Click legado
    *-- (fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm','ALTERAR')).
    this_lTemAcessoRetirar = .F.

    *-- Programa consultado no gate de acesso (1o argumento do fChecaAcesso).
    this_cProgramaAcesso = "SigCdPrm"

    *-- Contadores do dialogo: promocoes carregadas, marcadas e efetivamente
    *-- retiradas na ultima execucao da retirada.
    this_nTotalPromocoes    = 0
    this_nTotalSelecionadas = 0
    this_nTotalRetiradas    = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave e zera o estado do dialogo.
    * DODEFAULT() sem argumento segue o padrao dos BOs de dialogo OPERACIONAL
    * (SigOpPrLBO): a tabela eh atribuida direto, sem instanciar DataAccess,
    * porque o acesso desta tela eh Select/Delete via SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigPrPmi"
                THIS.this_cCampoChave = "cidchaves"

                *-- Estado inicial do dialogo
                THIS.this_cCursorItens       = "cursor_4c_Promocoes"
                THIS.this_cCursorItensPai    = ""
                THIS.this_cModoEscolha       = ""
                THIS.this_lSomenteConsulta   = .F.
                THIS.this_lTemAcessoRetirar  = .F.
                THIS.this_cProgramaAcesso    = "SigCdPrm"
                THIS.this_nTotalPromocoes    = 0
                THIS.this_nTotalSelecionadas = 0
                THIS.this_nTotalRetiradas    = 0

                *-- Colunas de SigPrPmi da linha corrente
                THIS.this_cCPros     = ""
                THIS.this_cPecas     = ""
                THIS.this_cPromos    = ""
                THIS.this_nCbars     = 0
                THIS.this_dDatas     = {}
                THIS.this_cCidChaves = ""
                THIS.this_dDtAlts    = {}
                THIS.this_cPromoPro  = ""
                THIS.this_nVendavels = 0
                THIS.this_lImpEmps   = .F.

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro("Erro ao inicializar SIGOPPRMBO: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades desta promocao a partir da
    * linha CORRENTE de um cursor aberto.
    *
    * Aceita DOIS formatos de cursor, porque sao os dois usados por este
    * dialogo (regra #9 - sempre SELECT (alias) antes de ler os campos, nunca
    * campo):
    *   1) a MESMA consulta que o form pai usa no AddCursor - Select * From
    *      SigPrPmi Where cpros = ?pPro - com TODAS as colunas da tabela
    *      (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro,
    *      vendavels);
    *   2) o cursor local da grade (equivalente a csEmpresas do legado), que
    *      tem so ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves.
    * Por isso as colunas exclusivas de SigPrPmi (cbars/dtalts/promopro/
    * vendavels) e a marcacao exclusiva da grade (ImpEmps) sao lidas so
    * quando TYPE() confirma que existem no alias recebido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de promo" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF()
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente no cursor de promo" + CHR(231) + CHR(245) + "es"
            RETURN .F.
        ENDIF

        THIS.this_cCPros     = TratarNulo(cpros, "")
        THIS.this_cPecas     = TratarNulo(pecas, "")
        THIS.this_cPromos    = TratarNulo(promos, "")
        THIS.this_dDatas     = TratarNulo(datas, {})
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")

        IF TYPE(par_cAliasCursor + ".cbars") != "U"
            THIS.this_nCbars = TratarNulo(cbars, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".dtalts") != "U"
            THIS.this_dDtAlts = TratarNulo(dtalts, {})
        ENDIF

        IF TYPE(par_cAliasCursor + ".promopro") != "U"
            THIS.this_cPromoPro = TratarNulo(promopro, "")
        ENDIF

        IF TYPE(par_cAliasCursor + ".vendavels") != "U"
            THIS.this_nVendavels = TratarNulo(vendavels, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".ImpEmps") != "U"
            THIS.this_lImpEmps = TratarNulo(ImpEmps, .F.)
        ENDIF

        THIS.this_cMensagemErro = ""
        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria Fortyus da promocao corrente
    * (sigprpmi_cidchaves). Usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * RetirarPromocao - Remove o produto de UMA promocao: Delete From SigPrPmi
    * Where cidchaves = <chave>, exatamente o passo 1 do btnRetirar.Click do
    * legado. O legado roda esse DELETE dentro de um Scan por linha marcada,
    * precedido do gate fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso(
    * 'SigCdPrm','ALTERAR') e de uma confirmacao do usuario, e seguido de DOIS
    * deletes em cursor LOCAL (crSigPrPmi do pai e csEmpresas da grade) - o
    * loop, a confirmacao, o gate de acesso e a manutencao dos cursores da
    * tela sao orquestracao de UI e ficam no Form; este metodo cobre so a
    * operacao de dados de UMA linha (chamada uma vez por cidchaves marcada).
    *
    * Como o legado SO exclui (nunca insere/altera SigPrPmi nesta tela - ver
    * cabecalho da classe), Inserir()/Atualizar() continuam com o
    * comportamento herdado de BusinessBase e este eh o UNICO metodo de
    * gravacao real do BO.
    *--------------------------------------------------------------------------
    PROCEDURE RetirarPromocao(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCidChaves) != "C" OR EMPTY(ALLTRIM(par_cCidChaves))
            MsgErro("Chave da promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada", "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves = ALLTRIM(par_cCidChaves)
            loc_cCursorTemp = "cursor_4c_DelPmi"

            loc_cSQL = "DELETE FROM SigPrPmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            DO CASE
            CASE loc_nResultado < 0
                *-- Equivale ao "Favor Reinicializar o Processo!!!" / "Falha na
                *-- Conexao (Excluindo Promocao)" do legado
                MsgErro("Favor Reinicializar o Processo (Excluindo Promo" + CHR(231) + CHR(227) + "o)" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
            CASE loc_nResultado = 0
                MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada (j" + CHR(225) + ;
                    " havia sido retirada).", "Aten" + CHR(231) + CHR(227) + "o")
            OTHERWISE
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPromocoes - Popula o cursor da grade (this_cCursorItens,
    * equivalente a csEmpresas) com as promocoes do produto informado.
    *
    * No legado quem roda esta consulta eh o form PAI (Cadastro de Produtos),
    * no AddCursor que deixa crSigPrPmi aberto ANTES de abrir este dialogo
    * ("Select * From SigPrPmi Where CPros = ?pPro"); o Init deste dialogo so
    * faz Scan nesse cursor e:
    *     Insert Into csEmpresas (ImpEmps, CPros, Pecas, Promos, Datas, ;
    *                             cIdChaves) ;
    *         Values (.f., crSigPrPmi.CPros, crSigPrPmi.Pecas, ;
    *                 crSigPrPmi.Promos, Nvl(crSigPrPmi.Datas, Ctod('')), ;
    *                 crSigPrPmi.cIdChaves)
    * com ImpEmps = .f. em TODA linha (marcacao comeca desmarcada). Como o
    * form pai desta arquitetura nao mantem esse cursor aberto (ver
    * cabecalho do Form), este metodo faz as DUAS coisas de uma vez: busca
    * SigPrPmi pelo codigo do produto (a MESMA consulta do AddCursor do pai)
    * e monta this_cCursorItens com a MESMA estrutura/ordem de colunas de
    * "Create Cursor csEmpresas (...)" do Load legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPromocoes(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalPromocoes = 0

        *-- VFP9 nao faz short-circuit em OR - os dois testes ficam em IFs
        *-- separados para o ALLTRIM() nunca rodar sobre valor que nao seja
        *-- Character (CLAUDE.md regra sobre ISNULL(x) OR EMPTY(x))
        IF VARTYPE(par_cCodigoProduto) != "C"
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigoProduto))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorTemp = "cursor_4c_PromocoesTmp"

            *-- "Select * From SigPrPmi Where CPros = ?pPro" do AddCursor do
            *-- form pai (sigcdpro) - a MESMA consulta, transcrita aqui
            *-- porque o form pai desta arquitetura nao mantem o cursor
            *-- aberto (ver cabecalho do Form).
            loc_cSQL = "SELECT * FROM SigPrPmi WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigoProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo (Buscando Promo" + CHR(231) + CHR(245) + "es)" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF

                *-- "Create Cursor csEmpresas (ImpEmps l(1), CPros c(14),
                *-- Pecas c(10), Promos c(25), Datas t Null, cIdChaves c(20))
                *-- / Index On CPros + Promos Tag CPros" do Load legado -
                *-- mesma estrutura, mesma ordem de colunas.
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (ImpEmps L, CPros C(14), Pecas C(10), Promos C(25), ;
                     Datas T, cIdChaves C(20))
                INDEX ON CPros + Promos TAG CPros

                IF loc_nResultado > 0
                    SELECT (loc_cCursorTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) ;
                            (ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves) ;
                            VALUES (.F., cpros, pecas, promos, ;
                                TratarNulo(datas, {}), cidchaves)
                    ENDSCAN
                ENDIF

                IF USED(loc_cCursorTemp)
                    USE IN (loc_cCursorTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                GO TOP

                THIS.this_nTotalPromocoes = RECCOUNT(THIS.this_cCursorItens)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPPRMBO.CarregarPromocoes")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

