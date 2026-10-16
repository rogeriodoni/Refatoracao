# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATA_TYPE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHARACTER_MAXIMUM_LENGTH' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'X' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BARRAANT, CPROS, CGRUS, CESTOQS, TAMANHOS, NPRIMARYS, LCARQ, LCCPO, CIDCHAVES

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
  Column1.ControlSource = "csContas.CprosAnt"
  Column2.ControlSource = "csContas.CprosNov"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
lcQuery = [Select CalcCustos ] + ;
		    [From SigCdPaC ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrSigCdPac') < 1)
	.DeleteMark = .F.
	.Column1.ControlSource = "csContas.CprosAnt"
	.Column2.ControlSource = "csContas.CprosNov"
Insert Into csContas(cprosAnt, cprosNov) Values ('', '')
Select csContas
Select csContas
	lcSql = [Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+CsContas.CprosNov+[' And a.Cgrus = b.Cgrus ]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
		lcSql = [Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+CsContas.CprosAnt+[' And a.Cgrus = b.Cgrus ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro2')
Select Arquivos, Campos ;
From ArqDBF ;
Select Distinct Arquivos From csCampos ;
Select Upper(Arquivos) as Arquivos, Indices  from vindsql where nprimarys = 1 ;
Select ChavePrim
Select CrSigOpClP
Select csContas
	Select CsArquivos
		Select csCampos
				lcWhere = [Select Emps, Grupos, Estos, Cpros, CodCors, CodTams, Min(Datas) as Datas From SigMvHst ]+;
				=ThisForm.PodataMgr.SqlExecute(lcWhere,'CrHis')
				Select CrHis
					lcUpdate = [Update SigCdPro Set Cbars = ]+Str(csContas.BarraAnt)+[ Where Cpros = ']+csContas.CprosNOv+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					lcUpdate = [Update SigCdPro Set Cbars = 0 Where Cpros = ']+CsContas.CprosAnt+[']
					lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpDate,'')
				lcSql = [Select Cpros From SigCdPro Where Cpros = ']+CsContas.CProsAnt+[']
				ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro')
				Select LocalPro
				lcSql = [Select * From SigMvEst Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
				lnErro = ThisForm.PodataMgr.SqlExecute(lcSql,'LocalEst')
				Select LocalEst
					lcDelete = [Delete From SigMvEst Where Cidchaves = ']+LocalEst.CidChaves+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcDelete,'')
				Select ChavePrim
				If Seek(lcArq)
					lcSql = [Select ]+lcChave+[ From ]+lcArq+[ Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcSql,'LocalArq')
					Select LocalArq
						lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[' Where ]+lcChave+[ = ']+KeyPry+[']
							lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[', ProCarTits = ']+csContas.CprosNov+[']+;
						lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.CprosNov+[' Where ]+lcCpo+[ = ']+csContas.CprosAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
	Select CrSigOpClP
	Select CrSigOpClC
		Select TmpCustPro
			Insert Into CrSigOpClC (Emps, CPros, EmpCPros, Datas, Usuars, CidChaves ) Values ;
		If Not ThisForm.PodataMgr.Update('CrSigOpClC')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigOpClC)')
	Select csContas
	Delete For flag
	Select csContas
Select csContas
Delete
Select csContas
Select CrImporta
Append From (gcfileexcel) type xls
Select CrImporta
	lcSql = [Select Cpros From SigCdPro Where Cpros = ']+CrImporta.CprosAnt+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro') < 1
	Select csContas
	If Not Seek(m.CprosAnt + m.CprosNov )
Select CsContas

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprmdp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1140 linhas total):

*-- Linhas 118 a 165:
118:                 THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
119:                 THIS.this_oBusinessObject.this_lManterBarra = THIS.this_lManterBarra
120: 
121:                 *-- Legado (Load): "lcQuery = Select CalcCustos From SigCdPaC
122:                 *-- Order By CalcCustos" + "Thisform.CalculaCusto =
123:                 *-- (CrSigCdPac.CalcCustos <> 3)".
124:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
125:                     IF USED("cursor_4c_Pac")
126:                         USE IN cursor_4c_Pac
127:                     ENDIF
128:                     IF SQLEXEC(gnConnHandle, "SELECT CalcCustos FROM SigCdPaC ORDER BY CalcCustos", "cursor_4c_Pac") > 0 ;
129:                        AND USED("cursor_4c_Pac") AND RECCOUNT("cursor_4c_Pac") > 0
130:                         THIS.this_lCalculaCusto = (TratarNulo(cursor_4c_Pac.CalcCustos, 0) != 3)
131:                     ENDIF
132:                     IF USED("cursor_4c_Pac")
133:                         USE IN cursor_4c_Pac
134:                     ENDIF
135:                 ENDIF
136:                 THIS.this_oBusinessObject.this_lCalculaCusto = THIS.this_lCalculaCusto
137: 
138:                 *-- Cursor local da grade de edicao (equivalente a csContas do
139:                 *-- Load legado) - tem de existir ANTES de ConfigurarPageFrame
140:                 *-- montar o Grid (regra #41: ControlSource de cursor
141:                 *-- inexistente derruba o Init).
142:                 IF USED("cursor_4c_Dados")
143:                     USE IN cursor_4c_Dados
144:                 ENDIF
145:                 CREATE CURSOR cursor_4c_Dados (CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
146:                 INDEX ON CprosAnt + CprosNov TAG Duplica
147:                 INDEX ON CprosAnt TAG CprosAnt
148:                 INDEX ON CprosNov TAG CprosNov
149:                 SET ORDER TO
150:                 INSERT INTO cursor_4c_Dados (CprosAnt, CprosNov) VALUES ("", "")
151: 
152:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
153: 
154:                 THIS.ConfigurarPageFrame()
155: 
156:                 THIS.TornarControlesVisiveis(THIS)
157:                 THIS.RegistrarEventos()
158: 
159:                 loc_lSucesso = .T.
160:             ENDIF
161:         CATCH TO loc_oErro
162:             MsgErro(loc_oErro.Message + CHR(13) + ;
163:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
164:                     "Procedure: " + loc_oErro.Procedure, ;
165:                     "Erro em InicializarForm")

*-- Linhas 385 a 438:
385:             .FontSize          = 8
386:             .AllowHeaderSizing = .F.
387:             .AllowRowSizing    = .F.
388:             .DeleteMark        = .F.
389:             .RecordMark        = .F.
390:             .HeaderHeight      = 18
391:             .RowHeight         = 18
392:             .ScrollBars        = 2
393:             .ReadOnly          = .F.
394:             .Visible           = .T.
395:         ENDWITH
396: 
397:         WITH loc_oGrid.Column1
398:             .Width             = 118
399:             .ReadOnly          = .F.
400:             .Header1.Caption   = "C" + CHR(243) + "digo Original"
401:             .Header1.Alignment = 2
402:             .Header1.FontName  = "Tahoma"
403:             .Header1.FontSize  = 8
404:             .ControlSource     = "cursor_4c_Dados.CprosAnt"
405:         ENDWITH
406: 
407:         *-- Lookup de produto (legado: Column1.Text1.Valid, com Checkcadpro=.F.
408:         *-- chama fwBuscaExt contra SigCdPro). Column.AddObject sozinho NAO
409:         *-- exibe o controle - precisa de CurrentControl + Sparse (regra #18);
410:         *-- a validacao mora no Valid do TextBox da coluna (regra #46), NUNCA
411:         *-- em AfterRowColChange.
412:         loc_oGrid.Column1.AddObject("txt_4c_CelCprosAnt", "TextBoxProdutoAntMdp_4c")
413:         loc_oGrid.Column1.CurrentControl = "txt_4c_CelCprosAnt"
414:         loc_oGrid.Column1.Sparse         = .F.
415: 
416:         WITH loc_oGrid.Column2
417:             .Width             = 118
418:             .ReadOnly          = .F.
419:             .Header1.Caption   = "Novo C" + CHR(243) + "digo"
420:             .Header1.Alignment = 2
421:             .Header1.FontName  = "Tahoma"
422:             .Header1.FontSize  = 8
423:             .ControlSource     = "cursor_4c_Dados.CprosNov"
424:         ENDWITH
425:         IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
426:             WITH loc_oGrid.Column2.Text1
427:                 .BorderStyle = 0
428:                 .Margin      = 0
429:                 .ForeColor   = RGB(0, 0, 0)
430:                 .BackColor   = RGB(255, 255, 255)
431:             ENDWITH
432:         ENDIF
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * ConfigurarCampos - cnt_4c_Result (cntResult do legado): painel que
437:     * exibe o produto/arquivo em processamento durante btnProcessar.Click.
438:     * Fica OCULTO por padrao (replica ThisForm.cntResult.Visible = .f. do

*-- Linhas 594 a 635:
594:             IF VARTYPE(par_oTxt) = "O"
595:                 par_oTxt.Value = ""
596:             ENDIF
597:             SELECT cursor_4c_Dados
598:             REPLACE CprosAnt WITH "" IN cursor_4c_Dados
599:             RETURN .T.
600:         ENDIF
601: 
602:         TRY
603:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
604:                 "SigCdPro", "cursor_4c_BuscaProdMdp", "Cpros", loc_cCpros, ;
605:                 "Sele" + CHR(231) + CHR(227) + "o")
606: 
607:             IF VARTYPE(loc_oBusca) = "O"
608:                 *-- Init ja resolveu o match exato; so abre o picker se nao achou
609:                 *-- (regra #37) - sem MsgAviso nem clear do digitado (regra #50)
610:                 IF !loc_oBusca.this_lAchouRegistro
611:                     loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
612:                     loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
613:                     loc_oBusca.Show()
614:                 ENDIF
615: 
616:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdMdp")
617:                     IF RECCOUNT("cursor_4c_BuscaProdMdp") > 0
618:                         SELECT cursor_4c_BuscaProdMdp
619:                         loc_cCpros = ALLTRIM(cursor_4c_BuscaProdMdp.Cpros)
620:                         SELECT cursor_4c_Dados
621:                         REPLACE CprosAnt WITH loc_cCpros IN cursor_4c_Dados
622:                         *-- O codigo escolhido tem de voltar para a CELULA tambem,
623:                         *-- senao o texto digitado sobrescreve o cursor (regra #46)
624:                         IF VARTYPE(par_oTxt) = "O"
625:                             par_oTxt.Value = loc_cCpros
626:                         ENDIF
627:                     ENDIF
628:                 ENDIF
629: 
630:                 loc_oBusca.Release()
631:             ENDIF
632:         CATCH TO loc_oErro
633:             MsgErro(loc_oErro.Message, "Formsigprmdp.ValidarCProsAntGridExec")
634:         ENDTRY
635: 

*-- Linhas 738 a 756:
738:             RETURN
739:         ENDIF
740: 
741:         SELECT cursor_4c_Dados
742:         IF !EMPTY(CprosAnt) AND !EMPTY(CprosNov)
743:             APPEND BLANK
744:         ENDIF
745: 
746:         THIS.grd_4c_Dados.Refresh()
747:         THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * BtnAlterarClick - nao ha botao Alterar no layout do SCX legado.
752:     *--------------------------------------------------------------------------
753:     PROCEDURE BtnAlterarClick()
754:         RETURN
755:     ENDPROC
756: 

*-- Linhas 762 a 789:
762:     ENDPROC
763: 
764:     *--------------------------------------------------------------------------
765:     * BtnExcluirClick - Delete na linha corrente de cursor_4c_Dados (legado:
766:     * btnExcluir.Click). Sem confirmacao e sem PACK, igual ao legado.
767:     *--------------------------------------------------------------------------
768:     PROCEDURE BtnExcluirClick()
769:         IF !USED("cursor_4c_Dados")
770:             RETURN
771:         ENDIF
772: 
773:         SELECT cursor_4c_Dados
774:         DELETE
775: 
776:         THIS.grd_4c_Dados.Refresh()
777:         THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
778:     ENDPROC
779: 
780:     *--------------------------------------------------------------------------
781:     * BtnBuscarClick - nao ha botao Buscar no layout do SCX legado.
782:     *--------------------------------------------------------------------------
783:     PROCEDURE BtnBuscarClick()
784:         RETURN
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * BtnSalvarClick - nao ha botao "Salvar" no SCX legado; a acao principal
789:     * deste form e "Processar" (btnProcessar.Click -> BtnProcessarClick(),

*-- Linhas 829 a 859:
829:             RETURN
830:         ENDIF
831: 
832:         SELECT cursor_4c_Dados
833:         GO TOP
834:         IF EOF()
835:             MsgAviso("N" + CHR(227) + "o Existem Contas a Serem Processadas!!!", ;
836:                 "Aten" + CHR(231) + CHR(227) + "o!!!")
837:             THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
838:             RETURN
839:         ENDIF
840: 
841:         *-- Validacao de TODOS os pares antes de perguntar confirmacao
842:         *-- (legado: primeiro Scan do btnProcessar.Click so valida e sai com
843:         *-- Return no primeiro erro, sem perguntar nada ainda).
844:         SELECT cursor_4c_Dados
845:         SCAN
846:             loc_nErro = THIS.this_oBusinessObject.ValidarParSubstituicao( ;
847:                 cursor_4c_Dados.CprosAnt, cursor_4c_Dados.CprosNov)
848: 
849:             DO CASE
850:             CASE loc_nErro = 1
851:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antiga Inv" + CHR(225) + "lida!!!", ;
852:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
853:                 THIS.grd_4c_Dados.Column1.txt_4c_CelCprosAnt.SetFocus()
854:                 RETURN
855:             CASE loc_nErro = 2
856:                 MsgAviso("Existe Uma Refer" + CHR(234) + "ncia Antigo Sem Barra !!!", ;
857:                     "Aten" + CHR(231) + CHR(227) + "o!!!")
858:                 THIS.grd_4c_Dados.SetFocus()
859:                 RETURN

*-- Linhas 890 a 908:
890:         THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width = 0
891:         THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = "0 %"
892: 
893:         SELECT cursor_4c_Dados
894:         GO TOP
895:         loc_nTotal  = RECCOUNT()
896:         loc_nFeito  = 0
897:         loc_lTudoOk = .T.
898: 
899:         SCAN
900:             loc_cProsAnt = cursor_4c_Dados.CprosAnt
901:             loc_cProsNov = cursor_4c_Dados.CprosNov
902: 
903:             THIS.cnt_4c_Result.txt_4c_Cpros.Value = ALLTRIM(loc_cProsAnt)
904:             THIS.cnt_4c_Result.Refresh()
905: 
906:             IF THIS.this_oBusinessObject.ProcessarPar(loc_cProsAnt, loc_cProsNov)
907:                 REPLACE Flag WITH .T. IN cursor_4c_Dados
908:                 =fGravarLog("C", THIS.Name, "INSERIR", ;

*-- Linhas 930 a 961:
930:             THIS.LimparCampos()
931:             MsgInfo("Todos Os Produtos Foram Alterados!!!", "Processamento Encerrado!!!")
932:         ELSE
933:             *-- legado: "Delete For flag" (remove so as linhas JA processadas,
934:             *-- mantendo as ainda nao processadas para reprocessar). Reconstrucao via
935:             *-- array em vez de DELETE+SET DELETED (DataSession=2 nasce com
936:             *-- SET DELETED OFF e nao herda o SET global - regra #9.4).
937:             loc_nI = 0
938:             SELECT cursor_4c_Dados
939:             SCAN FOR !Flag
940:                 loc_nI = loc_nI + 1
941:                 DIMENSION loc_aPendAnt[loc_nI], loc_aPendNov[loc_nI]
942:                 loc_aPendAnt[loc_nI] = cursor_4c_Dados.CprosAnt
943:                 loc_aPendNov[loc_nI] = cursor_4c_Dados.CprosNov
944:             ENDSCAN
945: 
946:             SELECT cursor_4c_Dados
947:             ZAP
948:             IF loc_nI = 0
949:                 APPEND BLANK
950:             ELSE
951:                 FOR loc_nI = 1 TO ALEN(loc_aPendAnt, 1)
952:                     APPEND BLANK
953:                     REPLACE CprosAnt WITH loc_aPendAnt[loc_nI], ;
954:                             CprosNov WITH loc_aPendNov[loc_nI] IN cursor_4c_Dados
955:                 ENDFOR
956:             ENDIF
957:             GO TOP
958: 
959:             MsgAviso("Existem Produtos que n" + CHR(227) + "o Foram Alterados!!!", "Reprocessar!!!")
960:         ENDIF
961: 

*-- Linhas 997 a 1060:
997:         IF USED("cursor_4c_Importa")
998:             USE IN cursor_4c_Importa
999:         ENDIF
1000:         CREATE CURSOR cursor_4c_Importa (CprosAnt C(14), CprosNov C(14))
1001:         INDEX ON CprosAnt TAG CprosAnt
1002: 
1003:         SELECT cursor_4c_Importa
1004:         APPEND FROM (loc_cArquivo) TYPE XLS
1005: 
1006:         loc_nTotal = RECCOUNT("cursor_4c_Importa")
1007:         loc_nFeito = 0
1008: 
1009:         SELECT cursor_4c_Importa
1010:         SCAN
1011:             loc_nFeito = loc_nFeito + 1
1012:             WAIT WINDOW "Aguarde Importando Produtos !" + STR(loc_nTotal - loc_nFeito) NOWAIT
1013: 
1014:             loc_cProsAnt = TratarNulo(cursor_4c_Importa.CprosAnt, "")
1015:             loc_cProsNov = TratarNulo(cursor_4c_Importa.CprosNov, "")
1016: 
1017:             IF EMPTY(loc_cProsAnt) OR EMPTY(loc_cProsNov) OR ;
1018:                UPPER(ALLTRIM(loc_cProsAnt)) == UPPER(ALLTRIM(loc_cProsNov))
1019:                 LOOP
1020:             ENDIF
1021: 
1022:             IF !THIS.this_lCheckCadPro
1023:                 loc_cSQL = "SELECT TOP 1 Cpros FROM SigCdPro WHERE Cpros = " + ;
1024:                     EscaparSQL(LEFT(ALLTRIM(loc_cProsAnt), 14))
1025:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTmpPro")
1026:                 IF loc_nResultado < 1 OR !USED("cursor_4c_ImpTmpPro") OR RECCOUNT("cursor_4c_ImpTmpPro") = 0
1027:                     IF USED("cursor_4c_ImpTmpPro")
1028:                         USE IN cursor_4c_ImpTmpPro
1029:                     ENDIF
1030:                     LOOP
1031:                 ENDIF
1032:                 USE IN cursor_4c_ImpTmpPro
1033:             ENDIF
1034: 
1035:             *-- Duplicata eh checada pela chave POSICIONAL (CprosAnt+CprosNov,
1036:             *-- os dois C(14)) - NUNCA ALLTRIM aqui, senao o SEEK nunca casa
1037:             *-- (regra #42).
1038:             IF !SEEK(loc_cProsAnt + loc_cProsNov, "cursor_4c_Dados", "Duplica")
1039:                 SELECT cursor_4c_Dados
1040:                 APPEND BLANK
1041:                 REPLACE CprosAnt WITH loc_cProsAnt, CprosNov WITH loc_cProsNov IN cursor_4c_Dados
1042:             ENDIF
1043:         ENDSCAN
1044: 
1045:         SELECT cursor_4c_Dados
1046:         GO BOTTOM
1047:         THIS.grd_4c_Dados.Refresh()
1048:         WAIT CLEAR
1049: 
1050:         USE IN cursor_4c_Importa
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * FormParaBO - copia o par da linha CORRENTE de cursor_4c_Dados para
1055:     * this_oBusinessObject (usado antes de validar/processar o par).
1056:     *--------------------------------------------------------------------------
1057:     PROTECTED PROCEDURE FormParaBO()
1058:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1059:             RETURN
1060:         ENDIF

*-- Linhas 1107 a 1125:
1107:             RETURN
1108:         ENDIF
1109: 
1110:         SELECT cursor_4c_Dados
1111:         ZAP
1112:         APPEND BLANK
1113:         GO TOP
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * Destroy - libera recursos ao fechar o form. cursor_4c_Dados eh a grade
1118:     * de edicao (vive por toda a sessao do form); cursor_4c_Importa eh
1119:     * aberto/fechado dentro de ExportaClick() e cursor_4c_Campos dentro de
1120:     * sigprmdpBO.ProcessarPar() - os guards aqui so cobrem o caso de o form
1121:     * ser fechado no meio de uma dessas operacoes (TRY/CATCH quebrado a
1122:     * meio-caminho).
1123:     *--------------------------------------------------------------------------
1124:     PROCEDURE Destroy()
1125:         IF VARTYPE(THIS.this_oBusinessObject) = "O"


### BO (C:\4c\projeto\app\classes\sigprmdpBO.prg):
*==============================================================================
* Classe  : sigprmdpBO
* Herda de: BusinessBase
* Descricao: BO para substituicao de referencias (codigos) de produtos.
*            Valida pares CprosAnt/CprosNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF, alem de
*            registrar controle de recalculo de custo em SigOpClC.
*            Form OPERACIONAL - sem Lista/Page1/Buscar(); this_cTabela so
*            identifica SigOpClC, unica tabela gravada por Inserir/Atualizar.
*==============================================================================
DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Flags de configuracao do processamento (legado: checkcadpro/manterbarra/calculacusto)
    this_lCheckCadPro   = .F.   && Pula a validacao do codigo de produto contra SigCdPro
    this_lManterBarra   = .F.   && Mantem o codigo de barras do produto antigo no produto novo
    this_lCalculaCusto  = .T.   && Recalcula custo (legado le de SigCdPaC.CalcCustos <> 3)

    *-- Estado do progresso (lido pelo Form para atualizar UI - cntResult/cntBarra)
    this_cArquivoAtual  = ""    && Arquivo/campo em processamento (getArquivo.Value)
    this_cProdutoAtual  = ""    && Produto em processamento (Get_Cpros.Value)
    this_nProgresso     = 0     && Progresso 0-100 (lblPorcento.Caption / shpBarra.Width)

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath    = ""

    *-- Par corrente de produtos (usado por CarregarDoCursor - espelha o cursor
    *-- da grade csContas: CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
    this_cProsAnt       = ""    && Codigo de referencia antigo (SigCdPro.Cpros, char(14))
    this_cProsNov       = ""    && Codigo de referencia novo (SigCdPro.Cpros, char(14))
    this_lFlag          = .F.   && Linha ja processada com sucesso (csContas.Flag)
    this_nBarraAnt      = 0     && Codigo de barras do produto antigo (SigCdPro.Cbars)

    *-- Dados do registro de controle de custo gerado no processamento (tabela
    *-- SigOpClC, unica tabela gravada diretamente por este BO - Inserir/Atualizar)
    this_cCidChaves     = ""    && Chave unica do registro (SigOpClC.cidchaves, PK)
    this_cCpros         = ""    && Codigo do produto enfileirado p/ recalculo (SigOpClC.cpros)
    this_cEmps          = ""    && Empresa do registro de custo (SigOpClC.emps)
    this_cEmpCpros      = ""    && Empresa + codigo do produto (SigOpClC.empcpros)
    this_dDatas         = {}    && Data base do recalculo de custo (SigOpClC.datas)
    this_cUsuars        = ""    && Usuario que gerou o registro (SigOpClC.usuars)

    *-- .T. quando o par processado tinha linha(s) em SigMvEst referenciando
    *-- o codigo antigo (ver ProcessarPar - regra #27: fRecalculaP/fRecalculaC
    *-- nao vieram no acervo, e SigMvEst nao e tocado sem elas). O Form usa
    *-- esta flag para avisar o usuario que o saldo precisa de revisao manual.
    this_lSigMvEstPendente = .F.

    *--------------------------------------------------------------------------
    * Init - sem Buscar()/this_oDataAccess (form OPERACIONAL, sem Lista/Page1).
    * this_cTabela/this_cCampoChave apontam para SigOpClC so porque e a UNICA
    * tabela que Inserir()/Atualizar() gravam diretamente (fila de recalculo
    * de custo) - usados por RegistrarAuditoria() para montar o log.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor da
    * grade de pares de substituicao (equivalente a csContas do legado).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProsAnt  = TratarNulo(CprosAnt,  "")
                THIS.this_cProsNov  = TratarNulo(CprosNov,  "")
                THIS.this_lFlag     = TratarNulo(Flag,      .F.)
                THIS.this_nBarraAnt = TratarNulo(BarraAnt,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigprmdpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava na fila de recalculo de custo (tabela SigOpClC), um
    * registro por produto/empresa cujo custo precisa ser reprocessado apos a
    * substituicao de referencia (legado: Insert Into CrSigOpClC no btnProcessar).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpClC (cidchaves, cpros, datas, empcpros, emps, usuars)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigprmdpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente da fila de recalculo de custo
    * (SigOpClC), localizado pela chave unica this_cCidChaves.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpClC
                SET cpros    = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    empcpros = <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    emps     = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprmdpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave real do registro gravado por Inserir/Atualizar
    * (SigOpClC.cidchaves), usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParSubstituicao - replica as 4 validacoes do SCAN csContas do
    * btnProcessar.Click legado, na MESMA ordem. Devolve um codigo em vez de
    * exibir a mensagem/posicionar o foco - isso e decisao do FORM (camadas).
    * Grava THIS.this_nBarraAnt quando acha o produto antigo em SigCdPro
    * (equivalente a "Replace BarraAnt With CrTmpPro.Cbars in CsContas").
    *
    * Retorno:
    *   0 = par valido
    *   1 = codigo antigo vazio, ou nao cadastrado em SigCdPro (e
    *       this_lCheckCadPro = .F.)
    *   2 = produto antigo sem codigo de barras (so quando this_lManterBarra)
    *   3 = codigo novo vazio
    *   4 = codigo antigo e novo iguais
    *   5 = grupos do produto antigo/novo com controle de estoque (Cestoqs)
    *       diferentes
    *--------------------------------------------------------------------------
    FUNCTION ValidarParSubstituicao(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado, loc_nRetorno, loc_lProsseguir
        loc_nRetorno = 0
        loc_lProsseguir = .T.
        THIS.this_nBarraAnt = 0

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            IF EMPTY(par_cProsAnt)
                loc_nRetorno = 1
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ValPro") OR RECCOUNT("cursor_4c_ValPro") = 0
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    loc_nRetorno = 1
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_nBarraAnt = TratarNulo(cursor_4c_ValPro.Cbars, 0)
                    USE IN cursor_4c_ValPro
                ENDIF
            ENDIF

            IF loc_lProsseguir AND THIS.this_lManterBarra AND THIS.this_nBarraAnt = 0
                loc_nRetorno = 2
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(par_cProsNov)
                loc_nRetorno = 3
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND UPPER(ALLTRIM(par_cProsAnt)) == UPPER(ALLTRIM(par_cProsNov))
                loc_nRetorno = 4
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Grupos com controle de estoque (Cestoqs) diferentes entre o
                *-- produto novo e o antigo bloqueiam a troca (legado: LocalPro/
                *-- LocalPro2, Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b)
                loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                    loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2")
                    IF USED("cursor_4c_LocalPro2")
                        IF RECCOUNT("cursor_4c_LocalPro2") > 0 AND ;
                           cursor_4c_LocalPro2.Cestoqs != cursor_4c_LocalPro.Cestoqs
                            loc_nRetorno = 5
                        ENDIF
                        USE IN cursor_4c_LocalPro2
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar par de refer" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ValidarParSubstituicao")
            loc_nRetorno = 1
        ENDTRY

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * MapearTabelasAlvo - Equivalente ao
    *     Select Arquivos, Campos From ArqDBF
    *     Where (Tamanhos=10 Or Tamanhos=14) And Upper(Tipos)='C' And
    *           Arquivos not in (...) And InList(Alltrim(Campos), <14 nomes>)
    * do btnProcessar.Click legado. ArqDBF.DBF era um CATALOGO LOCAL do FoxPro
    * (Sys(5)+Sys(2003)+'\ArqDBF.dbf') - nao existe no SQL Server (regra #14:
    * so o schema.sql/INFORMATION_SCHEMA decide, nunca arquivo local). A MESMA
    * lista de nomes de coluna e o MESMO filtro de tamanho sao aplicados aqui
    * contra o metadado REAL e ATUAL do banco, em vez de um catalogo que podia
    * estar desatualizado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MapearTabelasAlvo()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        TEXT TO loc_cSQL NOSHOW
            SELECT TABLE_NAME AS Arquivos, COLUMN_NAME AS Campos
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE DATA_TYPE IN ('char', 'varchar')
              AND CHARACTER_MAXIMUM_LENGTH IN (10, 14)
              AND UPPER(COLUMN_NAME) IN ('CMATS','CODCONPADS','CODPDS','CODPROPADS',
                  'CPROS','PRODUTO','PRODUTOS','CPROEQS','MATPRINCS','MATS',
                  'MATSUBS','CODGARRAS','OUROS','BRILHANTES')
              AND UPPER(TABLE_NAME) NOT IN ('SIGTEMPD','SIGTEMPC','SIGTEMPR')
            ORDER BY TABLE_NAME
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Campos")
        IF loc_nResultado < 0
            MostrarErro("Erro ao mapear tabelas com refer" + CHR(234) + "ncia a produto:" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteReferencia - .T. se existe ao menos 1 linha de par_cTabela com
    * par_cColuna = par_cValor. Equivalente ao
    *     ThisForm.PodataMgr.CursorQuery('SigCdPro','CrTmpPro','Cpros', ... )
    * e ao padrao "Select X From Y Where Y.X = 'valor' / Reccount(...) > 0"
    * repetido no btnProcessar.Click legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteReferencia(par_cTabela, par_cColuna, par_cValor)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        loc_cSQL = "SELECT TOP 1 " + par_cColuna + " FROM " + par_cTabela + ;
            " WHERE " + par_cColuna + " = " + EscaparSQL(LEFT(ALLTRIM(par_cValor), 14))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Existe")
        IF loc_nResultado > 0 AND USED("cursor_4c_Existe")
            loc_lExiste = (RECCOUNT("cursor_4c_Existe") > 0)
        ENDIF
        IF USED("cursor_4c_Existe")
            USE IN cursor_4c_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnfileirarRecalculoPorPar - Equivalente ao bloco final do legado
    * ("If Used('TmpCustPro') And Thisform.Calculacusto / Scan / Insert Into
    * CrSigOpClC (...) "). TmpCustPro era populado DENTRO de fRecalculaC
    * (funcao global do Fortyus que nao veio no acervo - regra #27); como nao
    * ha como reproduzir o calculo em si, enfileiramos para recalculo externo
    * TODA empresa que tem movimento historico (SigMvHst) para o codigo
    * antigo OU o novo - e' o mesmo universo (Emps) que o legado varria via
    * fRecalculaP/fRecalculaC para montar TmpCustPro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado

        IF !THIS.this_lCalculaCusto
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT Emps FROM SigMvHst WHERE Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14)) + " OR Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsRecalc")
            IF loc_nResultado > 0 AND USED("cursor_4c_EmpsRecalc")
                SELECT cursor_4c_EmpsRecalc
                SCAN
                    THIS.this_cEmps   = TratarNulo(cursor_4c_EmpsRecalc.Emps, "")
                    THIS.this_dDatas  = DATE()
                    THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsAnt)
                    THIS.Inserir()

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsNov)
                    THIS.Inserir()
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao enfileirar recalculo de custo:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.EnfileirarRecalculoPorPar")
        ENDTRY

        IF USED("cursor_4c_EmpsRecalc")
            USE IN cursor_4c_EmpsRecalc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPar - substitui par_cProsAnt por par_cProsNov em todas as
    * tabelas mapeadas por MapearTabelasAlvo() (equivalente ao "Select
    * Arquivos,Campos" + Scan do btnProcessar.Click legado).
    *
    * Casos especiais transcritos literalmente do legado:
    *   SIGPRPRT          -> nunca atualizado (Loop incondicional).
    *   SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT -> quando o codigo NOVO ja existe
    *     como produto cadastrado em SigCdPro: se for SigCdPro.Cpros e
    *     this_lManterBarra, transfere o codigo de barras (Cbars) do antigo
    *     para o novo em vez de renomear; senao, se o codigo ANTIGO tambem
    *     existir como produto distinto, pula a troca (preserva os dois
    *     registros); caso contrario segue para o UPDATE generico.
    *   SIGMVHST/SIGMVEST -> NAO recebem UPDATE/DELETE aqui. O legado dispara
    *     fRecalculaP()/fRecalculaC() (recalculo de custo/estoque) e, so para
    *     SIGMVEST, exclui as linhas do saldo antigo (a recriacao sob o
    *     codigo novo acontecia DENTRO de fRecalculaP). Essas duas funcoes
    *     globais do Fortyus NAO vieram no acervo (regra #27) - excluir
    *     SIGMVEST sem a recriacao destruiria saldo de estoque em SILENCIO,
    *     o que e pior que nao fazer nada. Em vez disso: SigMvHst participa
    *     do UPDATE generico (o legado tambem faz isso - o bloco SIGMVHST
    *     cai no Else por nao ter "Loop"); SigMvEst e so verificado (seta a
    *     flag de alerta correspondente) para o FORM avisar o usuario.
    *
    * Toda a troca das demais tabelas vai num UNICO SQLEXEC (lote T-SQL com
    * SAVE TRANSACTION) - BEGIN/COMMIT em chamadas SEPARADAS de SQLEXEC NAO
    * dao atomicidade nesta conexao (Transactions=2, @@TRANCOUNT ja nasce 1,
    * ver Erro188/ProdutoBO.CopiarProduto).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cProsAntSQL, loc_cProsNovSQL, loc_cLote, loc_cSQL, ;
              loc_cTabela, loc_cColuna, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        loc_cProsAntSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
        loc_cProsNovSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
        THIS.this_lSigMvEstPendente = .F.
        THIS.this_cMensagemErro = ""

        IF !THIS.MapearTabelasAlvo()
            RETURN .F.
        ENDIF

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            loc_cLote = ""

            SELECT cursor_4c_Campos
            SCAN
                loc_cTabela = ALLTRIM(cursor_4c_Campos.Arquivos)
                loc_cColuna = ALLTRIM(cursor_4c_Campos.Campos)

                IF UPPER(loc_cTabela) == "SIGPRPRT"
                    LOOP
                ENDIF

                IF UPPER(loc_cTabela) == "SIGMVEST"
                    THIS.this_lSigMvEstPendente = THIS.this_lSigMvEstPendente OR ;
                        THIS.ExisteReferencia(loc_cTabela, loc_cColuna, par_cProsAnt)
                    LOOP
                ENDIF

                IF INLIST(UPPER(loc_cTabela), "SIGCDPRO", "SIGPRCPO", "SIGCDPRF", "SIGCDPFT") ;
                   AND THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsNov)

                    IF UPPER(loc_cTabela) == "SIGCDPRO" AND UPPER(loc_cColuna) == "CPROS" ;
                       AND THIS.this_lManterBarra
                        loc_cLote = loc_cLote + ;
                            "UPDATE SigCdPro SET Cbars = " + FormatarNumeroSQL(THIS.this_nBarraAnt, 0) + ;
                            " WHERE Cpros = " + loc_cProsNovSQL + "; " + ;
                            "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + loc_cProsAntSQL + "; "
                        LOOP
                    ENDIF

                    IF THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsAnt)
                        *-- codigo antigo TAMBEM existe como produto distinto -
                        *-- preserva os dois, nao mexe nesta coluna
                        LOOP
                    ENDIF
                ENDIF

                *-- UPDATE generico (legado: Update <tabela> Set <coluna> =
                *-- 'novo' Where <coluna> = 'antigo' - com ou sem chave
                *-- primaria o resultado final e o mesmo conjunto de linhas)
                loc_cLote = loc_cLote + ;
                    "UPDATE " + loc_cTabela + " SET " + loc_cColuna + " = " + loc_cProsNovSQL + ;
                    " WHERE " + loc_cColuna + " = " + loc_cProsAntSQL + "; "
            ENDSCAN

            IF !EMPTY(loc_cLote)
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SET NOCOUNT ON;
                    DECLARE @nivel4c int = @@TRANCOUNT;
                    IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Mdp4c;
                    BEGIN TRY
                        <<loc_cLote>>
                        IF @nivel4c = 0 COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        IF @nivel4c = 0
                            BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION END
                        ELSE
                            BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Mdp4c END;
                        THROW;
                    END CATCH
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar refer" + CHR(234) + "ncias de produto:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao processar substitui" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ProcessarPar")
        ENDTRY

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

