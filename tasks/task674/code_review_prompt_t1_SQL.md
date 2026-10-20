# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CEMPS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, CEMPS, FPAGS

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
  ControlSource = "crSigPrSnd.operas"
  ControlSource = "crSigPrSnd.Valors"
  ControlSource = "crSigPrSnd.Solicits"
  ControlSource = "crSigPrSnd.Docs"
  ControlSource = "crSigPrSnd.Datas"
  ControlSource = "crSigPrSnd.Motivos"
  ControlSource = "crSigPrSnd.Fpags"
  ControlSource = "crSigPrSnd.Emps"
lcQrySend = [Select * From SigPrSnd Where cIdChaves = '] + pIds + [']
		Insert Into crSigPrSnd (Usuars, Datas, Tipos) Values (Usuar, Datetime(),Iif(ThisForm.Producao,1,0))
		lcSql = [Select SenhDEmps From SigCdPac ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CrParac')
	lcSql = [Select nemps From SigCdEmp Where cEmps = ']+CrSigPrSnd.Emps+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'CrEmp')
	lcSql = [Select nfpags From SigOpFp Where Fpags = ']+CrSigPrSnd.Fpags+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'CrfPagto')
ThisForm.poDataMgr.Update('crSigPrSnd')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1296 linhas total):

*-- Linhas 130 a 148:
130:     * Get_fpg), Data (Label4 + Get_Data, sempre Enabled=.F. - When do legado
131:     * retorna .F.), Valor (Label5 + Get_Valor, Enabled so fora de Producao -
132:     * When do legado retorna Not ThisForm.Producao), Motivo (Label6 +
133:     * Get_Motivo). ControlSource NAO e usado (arquitetura em
134:     * camadas: o valor vai e volta via FormParaBO/BOParaForm em fase
135:     * posterior) - aqui so estrutura visual, tipo e mascara (Format/
136:     * InputMask/MaxLength transcritos do SCX - regra #49 do CLAUDE.md).
137:     *==========================================================================
138:     PROTECTED PROCEDURE ConfigurarPaginaDados()
139:         LOCAL loc_oErro
140:         TRY
141:             *-- Solicitante : (Label1 + Get_Solic) ------------------------------
142:             THIS.AddObject("lbl_4c_Solicitante", "Label")
143:             WITH THIS.lbl_4c_Solicitante
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 8
146:                 .BackStyle = 0
147:                 .AutoSize  = .F.
148:                 .Alignment = 0

*-- Linhas 568 a 596:
568: 
569:         TRY
570:             IF THIS.this_lProducao
571:                 loc_nResult = SQLEXEC(gnConnHandle, ;
572:                     "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cVal), ;
573:                     "cursor_4c_OperVal")
574:             ELSE
575:                 loc_nResult = SQLEXEC(gnConnHandle, ;
576:                     "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cVal), ;
577:                     "cursor_4c_OperVal")
578:             ENDIF
579: 
580:             IF loc_nResult > 0 AND USED("cursor_4c_OperVal") AND !EOF("cursor_4c_OperVal")
581:                 SELECT cursor_4c_OperVal
582:                 IF THIS.this_lProducao
583:                     THIS.txt_4c_Operacao.Value = ALLTRIM(Dopps)
584:                 ELSE
585:                     THIS.txt_4c_Operacao.Value = ALLTRIM(Dopes)
586:                 ENDIF
587:             ELSE
588:                 THIS.AbrirBuscaOperacao()
589:             ENDIF
590:             IF USED("cursor_4c_OperVal")
591:                 USE IN cursor_4c_OperVal
592:             ENDIF
593:         CATCH TO loc_oErro
594:             MsgErro(loc_oErro.Message, "Erro")
595:         ENDTRY
596:         THIS.txt_4c_Operacao.Refresh

*-- Linhas 615 a 666:
615:         loc_lProsseguir = .T.
616:         TRY
617:             IF EMPTY(loc_cValor)
618:                 loc_cSQL = "SELECT " + loc_cCampo + " FROM " + loc_cTabela + ;
619:                            " ORDER BY " + loc_cCampo
620:             ELSE
621:                 loc_cSQL = "SELECT " + loc_cCampo + " FROM " + loc_cTabela + ;
622:                            " WHERE " + loc_cCampo + " LIKE " + EscaparSQL(loc_cValor + "%") + ;
623:                            " ORDER BY " + loc_cCampo
624:             ENDIF
625:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOper")
626: 
627:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaOper") OR RECCOUNT("cursor_4c_BuscaOper") = 0) ;
628:                     AND !EMPTY(loc_cValor)
629:                 IF USED("cursor_4c_BuscaOper")
630:                     USE IN cursor_4c_BuscaOper
631:                 ENDIF
632:                 loc_nResult = SQLEXEC(gnConnHandle, ;
633:                     "SELECT " + loc_cCampo + " FROM " + loc_cTabela + " ORDER BY " + loc_cCampo, ;
634:                     "cursor_4c_BuscaOper")
635:             ENDIF
636: 
637:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaOper") OR RECCOUNT("cursor_4c_BuscaOper") = 0
638:                 loc_lProsseguir = .F.
639:             ENDIF
640: 
641:             IF loc_lProsseguir
642:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
643:                 IF VARTYPE(loc_oBusca) = "O"
644:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOper"
645:                     loc_oBusca.this_cTitulo        = loc_cTitulo
646:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
647:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
648:                     loc_oBusca.mAddColuna(loc_cCampo, "", "Opera" + CHR(231) + CHR(227) + "o")
649:                     loc_oBusca.Show()
650:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
651:                         SELECT cursor_4c_BuscaOper
652:                         IF THIS.this_lProducao
653:                             THIS.txt_4c_Operacao.Value = ALLTRIM(Dopps)
654:                         ELSE
655:                             THIS.txt_4c_Operacao.Value = ALLTRIM(Dopes)
656:                         ENDIF
657:                     ENDIF
658:                     loc_oBusca.Release()
659:                 ENDIF
660:             ENDIF
661:         CATCH TO loc_oErro
662:             MsgErro(loc_oErro.Message, "Erro")
663:         ENDTRY
664: 
665:         IF USED("cursor_4c_BuscaOper")
666:             USE IN cursor_4c_BuscaOper

*-- Linhas 692 a 714:
692:         ENDIF
693: 
694:         TRY
695:             loc_nResult = SQLEXEC(gnConnHandle, ;
696:                 "SELECT TOP 1 Fpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cVal), ;
697:                 "cursor_4c_FpgVal")
698:             IF loc_nResult > 0 AND USED("cursor_4c_FpgVal") AND !EOF("cursor_4c_FpgVal")
699:                 SELECT cursor_4c_FpgVal
700:                 THIS.txt_4c_Fpg.Value = ALLTRIM(Fpags)
701:             ELSE
702:                 THIS.AbrirBuscaFpg()
703:             ENDIF
704:             IF USED("cursor_4c_FpgVal")
705:                 USE IN cursor_4c_FpgVal
706:             ENDIF
707:         CATCH TO loc_oErro
708:             MsgErro(loc_oErro.Message, "Erro")
709:         ENDTRY
710:         THIS.txt_4c_Fpg.Refresh
711:     ENDPROC
712: 
713:     *==========================================================================
714:     * AbrirBuscaFpg - picker de Forma de Pagamento (SigOpFp)

*-- Linhas 727 a 780:
727:         loc_lProsseguir = .T.
728:         TRY
729:             IF EMPTY(loc_cValor)
730:                 loc_cSQL = "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp ORDER BY Fpags"
731:             ELSE
732:                 loc_cSQL = "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp " + ;
733:                            "WHERE Fpags LIKE " + EscaparSQL(loc_cValor + "%") + ;
734:                            " ORDER BY Fpags"
735:             ENDIF
736:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaFpg")
737: 
738:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaFpg") OR RECCOUNT("cursor_4c_BuscaFpg") = 0) ;
739:                     AND !EMPTY(loc_cValor)
740:                 IF USED("cursor_4c_BuscaFpg")
741:                     USE IN cursor_4c_BuscaFpg
742:                 ENDIF
743:                 loc_nResult = SQLEXEC(gnConnHandle, ;
744:                     "SELECT Fpags, Descrs, MoeFPgs, FParcs FROM SigOpFp ORDER BY Fpags", ;
745:                     "cursor_4c_BuscaFpg")
746:             ENDIF
747: 
748:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaFpg") OR RECCOUNT("cursor_4c_BuscaFpg") = 0
749:                 loc_lProsseguir = .F.
750:             ENDIF
751: 
752:             IF loc_lProsseguir
753:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
754:                 IF VARTYPE(loc_oBusca) = "O"
755:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaFpg"
756:                     loc_oBusca.this_cTitulo        = loc_cTitulo
757:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
758:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
759:                     loc_oBusca.mAddColuna("FPags",   "",      "C" + CHR(243) + "digo")
760:                     loc_oBusca.mAddColuna("Descrs",  "",      "Descri" + CHR(231) + CHR(227) + "o")
761:                     loc_oBusca.mAddColuna("MoeFPgs", "XXXXX", "Moeda")
762:                     loc_oBusca.mAddColuna("FParcs",  "99",    " #")
763:                     loc_oBusca.Show()
764:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
765:                         SELECT cursor_4c_BuscaFpg
766:                         THIS.txt_4c_Fpg.Value = ALLTRIM(Fpags)
767:                     ENDIF
768:                     loc_oBusca.Release()
769:                 ENDIF
770:             ENDIF
771:         CATCH TO loc_oErro
772:             MsgErro(loc_oErro.Message, "Erro")
773:         ENDTRY
774: 
775:         IF USED("cursor_4c_BuscaFpg")
776:             USE IN cursor_4c_BuscaFpg
777:         ENDIF
778:         THIS.txt_4c_Fpg.Refresh
779:     ENDPROC
780: 

*-- Linhas 806 a 828:
806:         ENDIF
807: 
808:         TRY
809:             loc_nResult = SQLEXEC(gnConnHandle, ;
810:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cVal), ;
811:                 "cursor_4c_EmpVal")
812:             IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
813:                 SELECT cursor_4c_EmpVal
814:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
815:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
816:             ELSE
817:                 THIS.AbrirBuscaEmpresa()
818:             ENDIF
819:             IF USED("cursor_4c_EmpVal")
820:                 USE IN cursor_4c_EmpVal
821:             ENDIF
822:         CATCH TO loc_oErro
823:             MsgErro(loc_oErro.Message, "Erro")
824:         ENDTRY
825:         THIS.txt_4c_CdEmpresa.Refresh
826:         THIS.txt_4c_DsEmpresa.Refresh
827:     ENDPROC
828: 

*-- Linhas 858 a 880:
858:         ENDIF
859: 
860:         TRY
861:             loc_nResult = SQLEXEC(gnConnHandle, ;
862:                 "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE RTRIM(Razas) = " + EscaparSQL(loc_cVal), ;
863:                 "cursor_4c_EmpVal")
864:             IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND !EOF("cursor_4c_EmpVal")
865:                 SELECT cursor_4c_EmpVal
866:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Cemps)
867:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
868:             ELSE
869:                 THIS.AbrirBuscaEmpresa()
870:             ENDIF
871:             IF USED("cursor_4c_EmpVal")
872:                 USE IN cursor_4c_EmpVal
873:             ENDIF
874:         CATCH TO loc_oErro
875:             MsgErro(loc_oErro.Message, "Erro")
876:         ENDTRY
877:         THIS.txt_4c_CdEmpresa.Refresh
878:         THIS.txt_4c_DsEmpresa.Refresh
879:     ENDPROC
880: 

*-- Linhas 900 a 952:
900:         loc_lProsseguir = .T.
901:         TRY
902:             IF EMPTY(loc_cValor)
903:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
904:             ELSE
905:                 loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp " + ;
906:                            "WHERE Cemps LIKE " + EscaparSQL(loc_cValor + "%") + ;
907:                            " OR RTRIM(Razas) LIKE " + EscaparSQL(loc_cValor + "%") + ;
908:                            " ORDER BY Cemps"
909:             ENDIF
910:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
911: 
912:             IF (loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0) ;
913:                     AND !EMPTY(loc_cValor)
914:                 IF USED("cursor_4c_BuscaEmp")
915:                     USE IN cursor_4c_BuscaEmp
916:                 ENDIF
917:                 loc_nResult = SQLEXEC(gnConnHandle, ;
918:                     "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
919:                     "cursor_4c_BuscaEmp")
920:             ENDIF
921: 
922:             IF loc_nResult < 1 OR !USED("cursor_4c_BuscaEmp") OR RECCOUNT("cursor_4c_BuscaEmp") = 0
923:                 loc_lProsseguir = .F.
924:             ENDIF
925: 
926:             IF loc_lProsseguir
927:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
928:                 IF VARTYPE(loc_oBusca) = "O"
929:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
930:                     loc_oBusca.this_cTitulo        = loc_cTitulo
931:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
932:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
933:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
934:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
935:                     loc_oBusca.Show()
936:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
937:                         SELECT cursor_4c_BuscaEmp
938:                         THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
939:                         THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
940:                     ENDIF
941:                     loc_oBusca.Release()
942:                 ENDIF
943:             ENDIF
944:         CATCH TO loc_oErro
945:             MsgErro(loc_oErro.Message, "Erro")
946:         ENDTRY
947: 
948:         IF USED("cursor_4c_BuscaEmp")
949:             USE IN cursor_4c_BuscaEmp
950:         ENDIF
951:         THIS.txt_4c_CdEmpresa.Refresh
952:         THIS.txt_4c_DsEmpresa.Refresh

*-- Linhas 1127 a 1145:
1127:     * HabilitarCampos/AjustarBotoesPorModo, e sem Confirmar/Cancelar de
1128:     * formulario CRUD (o par real do legado e Gerar Senha/Encerrar, ja
1129:     * implementado). BOParaForm tambem nao se aplica: o dialogo nunca carrega
1130:     * um registro existente para edicao - e sempre um INSERT novo.
1131:     *==========================================================================
1132:     PROCEDURE BtnGerarSenhaClick
1133:         LOCAL loc_cSolic, loc_cEmp, loc_cOperacao, loc_nDoc, loc_cFpg, ;
1134:               loc_nValor, loc_cMotivo, loc_lSenhDEmps, loc_nNum, ;
1135:               loc_nResult, loc_cSenha, loc_lSucesso, loc_oErro
1136: 
1137:         loc_cSolic    = ALLTRIM(THIS.txt_4c_Solic.Value)
1138:         loc_cEmp      = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
1139:         loc_cOperacao = ALLTRIM(THIS.txt_4c_Operacao.Value)
1140:         loc_nDoc      = THIS.txt_4c_Doc.Value
1141:         loc_cFpg      = ALLTRIM(THIS.txt_4c_Fpg.Value)
1142:         loc_nValor    = THIS.txt_4c_Valor.Value
1143:         loc_cMotivo   = ALLTRIM(THIS.txt_4c_Motivo.Value)
1144: 
1145:         IF EMPTY(loc_cSolic)

*-- Linhas 1180 a 1233:
1180: 
1181:         loc_lSucesso = .F.
1182:         TRY
1183:             *-- "Select SenhDEmps From SigCdPac" do Init legado - replicado aqui
1184:             *-- (so e usado neste metodo e precisa de gnConnHandle vivo, que o
1185:             *-- InicializarForm nao garante durante gb_4c_ValidandoUI)
1186:             loc_lSenhDEmps = .F.
1187:             IF USED("cursor_4c_Parac")
1188:                 USE IN cursor_4c_Parac
1189:             ENDIF
1190:             loc_nResult = SQLEXEC(gnConnHandle, "SELECT TOP 1 SenhDEmps FROM SigCdPac", "cursor_4c_Parac")
1191:             IF loc_nResult > 0 AND USED("cursor_4c_Parac") AND !EOF("cursor_4c_Parac")
1192:                 loc_lSenhDEmps = cursor_4c_Parac.SenhDEmps
1193:             ENDIF
1194:             IF USED("cursor_4c_Parac")
1195:                 USE IN cursor_4c_Parac
1196:             ENDIF
1197: 
1198:             *-- "If CrParac.SenhDEmps ... lnNum = nemps + nfpags + (Valors*100)"
1199:             loc_nNum = 0
1200:             IF loc_lSenhDEmps
1201:                 IF USED("cursor_4c_EmpNum")
1202:                     USE IN cursor_4c_EmpNum
1203:                 ENDIF
1204:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1205:                     "SELECT TOP 1 nemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
1206:                     "cursor_4c_EmpNum")
1207:                 IF loc_nResult > 0 AND USED("cursor_4c_EmpNum") AND !EOF("cursor_4c_EmpNum")
1208:                     loc_nNum = NVL(cursor_4c_EmpNum.nemps, 0)
1209:                 ENDIF
1210:                 IF USED("cursor_4c_EmpNum")
1211:                     USE IN cursor_4c_EmpNum
1212:                 ENDIF
1213: 
1214:                 IF USED("cursor_4c_FpgNum")
1215:                     USE IN cursor_4c_FpgNum
1216:                 ENDIF
1217:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1218:                     "SELECT TOP 1 nfpags FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cFpg), ;
1219:                     "cursor_4c_FpgNum")
1220:                 IF loc_nResult > 0 AND USED("cursor_4c_FpgNum") AND !EOF("cursor_4c_FpgNum")
1221:                     loc_nNum = loc_nNum + NVL(cursor_4c_FpgNum.nfpags, 0) + (loc_nValor * 100)
1222:                 ENDIF
1223:                 IF USED("cursor_4c_FpgNum")
1224:                     USE IN cursor_4c_FpgNum
1225:                 ENDIF
1226:             ENDIF
1227: 
1228:             *-- "lcSenha = fGerPswDiario(crSigPrSnd.Docs, crSigPrSnd.Datas, lnNum)"
1229:             *-- fGerPswDiario e funcao global Fortyus (SIGFUNCS.PRG) FORA do
1230:             *-- acervo - mesmo gap ja presente (sem wrapper em utils\) em
1231:             *-- sigtosenBO.prg, sigprsenBO.prg e Formsigtosen.prg; nao
1232:             *-- inventado aqui, so TRANSCRITO (regra CLAUDE.md #27 - valor de
1233:             *-- CALCULO nunca se chuta, fica ausente/visivel ate um wrapper


### BO (C:\4c\projeto\app\classes\SigPrSddBO.prg):
*====================================================================
* SigPrSddBO.prg
*
* Business Object para Senha do Dia
* Tabela: SigPrSnd
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

	*-- Propriedades da entidade (SigPrSnd)
	this_cCidChaves = ""   && cidchaves char(20) - PK (gerada via fUniqueIds())
	this_cUsuars    = ""   && usuars    char(10) - Usuario que gerou a senha
	this_dDatas     = {}   && datas     datetime - Data/hora da solicitacao
	this_nTipos     = 0    && tipos     numeric(1,0) - 1=Producao / 0=Nao-Producao
	this_cOperas    = ""   && operas    char(20) - Codigo da operacao (SigCdOpe/SigCdOpd)
	this_nDocs      = 0    && docs      numeric(10,0) - Numero do documento
	this_nValors    = 0    && valors    numeric(11,2) - Valor (campo so usado fora de Producao)
	this_cMotivos   = ""   && motivos   char(40) - Motivo da solicitacao
	this_cFpags     = ""   && fpags     char(12) - Forma de pagamento (SigOpFp)
	this_cEmps      = ""   && cemps      char(3) - Codigo da empresa (SigCdEmp)
	this_cSenhads   = ""   && senhads   char(6) - Senha do dia gerada (fGerPswDiario)
	this_cHoras     = ""   && horas     char(8) - Hora da geracao da senha
	this_cSolicits  = ""   && solicits  char(10) - Codigo do solicitante

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigPrSnd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves = TratarNulo(cidchaves, "")
				THIS.this_cUsuars    = TratarNulo(usuars,    "")
				THIS.this_dDatas     = ConverterParaData(TratarNulo(datas, {}))
				THIS.this_nTipos     = TratarNulo(tipos,     0)
				THIS.this_cOperas    = TratarNulo(operas,    "")
				THIS.this_nDocs      = TratarNulo(docs,      0)
				THIS.this_nValors    = TratarNulo(valors,    0)
				THIS.this_cMotivos   = TratarNulo(motivos,   "")
				THIS.this_cFpags     = TratarNulo(fpags,     "")
				THIS.this_cEmps      = TratarNulo(emps,      "")
				THIS.this_cSenhads   = TratarNulo(senhads,   "")
				THIS.this_cHoras     = TratarNulo(horas,     "")
				THIS.this_cSolicits  = TratarNulo(solicits,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrSddBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere a Senha do Dia gerada na tabela SigPrSnd
	*
	* Colunas empdopnums (char(29)) e perlimite (numeric(5,2)) sao NOT NULL
	* no schema mas NAO existem no form/BO original (nenhum controle, nenhuma
	* referencia no codigo legado) - recebem o default do tipo (regra #22 do
	* CLAUDE.md: coluna NOT NULL sem property usa EscaparSQL("")/
	* FormatarNumeroSQL(0,<dec>), nunca a string vazia direto no SQL).
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigPrSnd (cidchaves, usuars, datas, tipos, operas, docs, valors, motivos, fpags, emps, senhads, horas, solicits, empdopnums, perlimite)
				VALUES (
					<<EscaparSQL(THIS.this_cCidChaves)>>,
					<<EscaparSQL(THIS.this_cUsuars)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					<<EscaparSQL(THIS.this_cOperas)>>,
					<<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
					<<EscaparSQL(THIS.this_cMotivos)>>,
					<<EscaparSQL(THIS.this_cFpags)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cSenhads)>>,
					<<EscaparSQL(THIS.this_cHoras)>>,
					<<EscaparSQL(THIS.this_cSolicits)>>,
					<<EscaparSQL("")>>,
					<<FormatarNumeroSQL(0, 2)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao gravar a senha do dia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrSddBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigPrSnd
	* (o legado so grava a Senha do Dia uma vez por chamada - este metodo
	* existe para completar a arquitetura em camadas, caso algum fluxo
	* futuro precise corrigir um registro ja gravado pela chave cidchaves)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigPrSnd
				SET usuars   = <<EscaparSQL(THIS.this_cUsuars)>>,
					datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
					tipos    = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
					operas   = <<EscaparSQL(THIS.this_cOperas)>>,
					docs     = <<FormatarNumeroSQL(THIS.this_nDocs, 0)>>,
					valors   = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
					motivos  = <<EscaparSQL(THIS.this_cMotivos)>>,
					fpags    = <<EscaparSQL(THIS.this_cFpags)>>,
					emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					senhads  = <<EscaparSQL(THIS.this_cSenhads)>>,
					horas    = <<EscaparSQL(THIS.this_cHoras)>>,
					solicits = <<EscaparSQL(THIS.this_cSolicits)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar a senha do dia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrSddBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

