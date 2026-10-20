# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ATIVAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS

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
  ControlSource = "csOperacoes.Erros"
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select LocalNfS
	If Seek(LocalNfS.PrestServs, [LocalUfs], [Codigos])
Select LocalNfE
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select LocalNfS
lcQuery = [Select TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs ] + ;
		    [From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, a.Emis, b.Obses, a.Cancelas, ] + ;
		    [From SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d ] + ;
		   		 [In (Select o.EmpDopNums ] + ;
	 	  		  	   [From SigPcOoL o ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNotas]) < 1)
Select LocalNotas
Select LocalNotas
	Insert Into csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, Opers, Erros) ;
	lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, Datas, Usuars, ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Insert SigPcOoL)])
	lcQuery = [Select Distinct a.Codigos, a.Descs, b.Estados ] + ;
				[From SigCdMun a, SigCdUfs b ] + ;
	If (.poDataMgr.SqlExecute(lcQuery, [LocalUfs]) < 1)
	Select LocalUfs
		.DeleteMark   	   = .f.
		.Column1.ControlSource = [csOperacoes.SelImp]
		.Column2.ControlSource  = [csOperacoes.Numes]
		.Column3.ControlSource  = [csOperacoes.Datas]
		.Column4.ControlSource  = [csOperacoes.Valos]
		.Column5.ControlSource  = [csOperacoes.Notas]
		.Column6.ControlSource  = [csOperacoes.Usuars]
		.Column7.ControlSource  = [csOperacoes.ContaOs]
		.Column8.ControlSource  = [csOperacoes.ContaDs]
		.Column9.ControlSource  = [csOperacoes.Emps]
		.Column10.ControlSource = [csOperacoes.Opers]
		.Column11.ControlSource = [csOperacoes.Dopes]
		Select csOperacoes
		Select csOperacoes
Select csOperacoes
	Select csOperacoes
	Select SelImp, Count(1) as Selecionados ;
	  From csOperacoes ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg) - TRECHOS RELEVANTES PARA PASS SQL (2071 linhas total):

*-- Linhas 77 a 95:
77: 
78:                 *-- Cursores (cursor_4c_Operacoes/cursor_4c_Municipios) tem de
79:                 *-- existir ANTES do Grid ser configurado - regra #41
80:                 *-- (Column.ControlSource de cursor inexistente derruba Init)
81:                 THIS.this_oBusinessObject.CriarCursoresAuxiliares()
82: 
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
86:                 THIS.TornarControlesVisiveis(THIS)
87: 
88:                 *-- Defaults do Init legado:
89:                 *--     .getDtIni.Value   = Date()
90:                 *--     .getDtFin.Value   = Date()
91:                 *--     .cmbCidades.Value = [RJ - Rio de Janeiro]
92:                 *--     .getDirs.Value    = [C:\]
93:                 *-- carregados pelo par LimparCampos() -> BOParaForm(), com as
94:                 *-- properties do BO como FONTE UNICA dos criterios. Os mesmos
95:                 *-- valores aparecem no .Value de cada AddObject (o controle

*-- Linhas 574 a 592:
574:     *
575:     *   1) llBlq = SigCdPam.BlqmEmps -> ligado, so a empresa corrente entra na
576:     *      lista (_Empr do legado -> go_4c_Sistema.cCodEmpresa);
577:     *   2) lista base = SigCdEmp INNER JOIN SigCdAcE (acesso do usuario),
578:     *      "Where b.Usuarios = <usuario logado>";
579:     *   3) llRst = (Reccount([crAr3]) < 1 Or llTot) -> usuario SEM nenhuma
580:     *      linha de acesso, OU usuario 4CONTROL, cai para SigCdEmp inteira.
581:     *
582:     * O "And a.Ativas = 1" do legado depende do 7o argumento (pAtv); a chamada
583:     * deste form tem 6 argumentos, entao pAtv eh .F. e o filtro NAO entra aqui.
584:     *
585:     * Coluna de empresa conferida em docs/schema.sql (regra #48 - o prefixo da
586:     * tabela NAO decide): SigCdEmp usa cemps/razas e SIGCDACE usa cemps (SEM o
587:     * C inicial) - nao espelhar o nome de um lado no outro.
588:     *
589:     * Devolve "" quando nao ha restricao nenhuma a aplicar.
590:     *--------------------------------------------------------------------------
591:     PROTECTED FUNCTION ObterFiltroAcessoEmpresas()
592:         LOCAL loc_cUsuario, loc_cEmpAtual, loc_lBloqueia, loc_lTudo

*-- Linhas 612 a 683:
612:             IF USED("cursor_4c_EmpPam")
613:                 USE IN cursor_4c_EmpPam
614:             ENDIF
615:             loc_nResultado = SQLEXEC(gnConnHandle, ;
616:                 "SELECT blqmemps FROM SigCdPam", "cursor_4c_EmpPam")
617: 
618:             IF loc_nResultado > 0 AND USED("cursor_4c_EmpPam") AND RECCOUNT("cursor_4c_EmpPam") > 0
619:                 SELECT cursor_4c_EmpPam
620:                 GO TOP
621:                 DO CASE
622:                 CASE VARTYPE(cursor_4c_EmpPam.blqmemps) = "L"
623:                     loc_lBloqueia = NVL(cursor_4c_EmpPam.blqmemps, .F.)
624:                 CASE VARTYPE(cursor_4c_EmpPam.blqmemps) = "N"
625:                     loc_lBloqueia = (NVL(cursor_4c_EmpPam.blqmemps, 0) <> 0)
626:                 OTHERWISE
627:                     loc_lBloqueia = (UPPER(ALLTRIM(TRANSFORM(NVL(cursor_4c_EmpPam.blqmemps, "")))) == "S")
628:                 ENDCASE
629:             ENDIF
630:             IF USED("cursor_4c_EmpPam")
631:                 USE IN cursor_4c_EmpPam
632:             ENDIF
633: 
634:             *-- (3) llTot / llRst: 4CONTROL ou usuario sem linha em SIGCDACE
635:             *--     enxerga SigCdEmp inteira.
636:             loc_lTudo = (UPPER(loc_cUsuario) == "4CONTROL") OR EMPTY(loc_cUsuario)
637: 
638:             IF !loc_lTudo
639:                 IF USED("cursor_4c_EmpAce")
640:                     USE IN cursor_4c_EmpAce
641:                 ENDIF
642:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
643:                     "SELECT COUNT(*) AS nAcessos FROM SIGCDACE b" + ;
644:                     " WHERE b.usuarios = " + EscaparSQL(loc_cUsuario), "cursor_4c_EmpAce")
645: 
646:                 IF loc_nResultado > 0 AND USED("cursor_4c_EmpAce") AND RECCOUNT("cursor_4c_EmpAce") > 0
647:                     SELECT cursor_4c_EmpAce
648:                     GO TOP
649:                     loc_lTudo = (NVL(cursor_4c_EmpAce.nAcessos, 0) < 1)
650:                 ELSE
651:                     *-- Falha ao consultar o acesso: NAO liberar a lista inteira
652:                     *-- em silencio - mantem a restricao (fail-closed).
653:                     loc_lTudo = .F.
654:                 ENDIF
655:                 IF USED("cursor_4c_EmpAce")
656:                     USE IN cursor_4c_EmpAce
657:                 ENDIF
658:             ENDIF
659: 
660:             *-- (1) Bloqueio pela empresa corrente
661:             IF loc_lBloqueia AND !EMPTY(loc_cEmpAtual)
662:                 loc_cFiltro = "cemps = " + EscaparSQL(loc_cEmpAtual)
663:             ENDIF
664: 
665:             *-- (2) Restricao por SIGCDACE
666:             IF !loc_lTudo
667:                 loc_cRestricao = "cemps IN (SELECT b.emps FROM SIGCDACE b" + ;
668:                                  " WHERE b.usuarios = " + EscaparSQL(loc_cUsuario) + ")"
669:                 loc_cFiltro = IIF(EMPTY(loc_cFiltro), loc_cRestricao, ;
670:                                   loc_cFiltro + " AND " + loc_cRestricao)
671:             ENDIF
672:         CATCH TO loc_oErro
673:             MsgErro("Erro ao apurar o acesso " + CHR(224) + "s empresas:" + CHR(13) + ;
674:                     loc_oErro.Message + CHR(13) + ;
675:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
676:                     "Procedure: " + loc_oErro.Procedure, "Erro")
677:             loc_cFiltro = ""
678:         ENDTRY
679: 
680:         RETURN loc_cFiltro
681:     ENDFUNC
682: 
683:     *--------------------------------------------------------------------------

*-- Linhas 707 a 737:
707:                 USE IN cursor_4c_EmpUniverso
708:             ENDIF
709: 
710:             loc_cSQL = "SELECT cemps AS Cemps, razas AS Razas" + ;
711:                        "  FROM SigCdEmp" + ;
712:                        " WHERE 1 = 1" + ;
713:                        IIF(EMPTY(loc_cFiltro), "", " AND (" + loc_cFiltro + ")") + ;
714:                        " ORDER BY cemps"
715: 
716:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpUniverso")
717: 
718:             loc_lSucesso = (loc_nResultado > 0 AND USED("cursor_4c_EmpUniverso") ;
719:                             AND RECCOUNT("cursor_4c_EmpUniverso") > 0)
720: 
721:             IF loc_lSucesso
722:                 SELECT cursor_4c_EmpUniverso
723:                 GO TOP
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro("Erro ao carregar as empresas dispon" + CHR(237) + "veis:" + CHR(13) + ;
727:                     loc_oErro.Message + CHR(13) + ;
728:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
729:                     "Procedure: " + loc_oErro.Procedure, "Erro")
730:             loc_lSucesso = .F.
731:         ENDTRY
732: 
733:         RETURN loc_lSucesso
734:     ENDFUNC
735: 
736:     *--------------------------------------------------------------------------
737:     * ValidarEmpresaCEmps - getCEmps.Valid do legado:

*-- Linhas 828 a 846:
828:         IF !loc_lForca
829:             TRY
830:                 IF THIS.CarregarUniversoEmpresas()
831:                     SELECT cursor_4c_EmpUniverso
832:                     IF loc_cModo == "D"
833:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_EmpUniverso.Razas)) == UPPER(loc_cValor)
834:                     ELSE
835:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_EmpUniverso.Cemps)) == UPPER(loc_cValor)
836:                     ENDIF
837: 
838:                     IF FOUND("cursor_4c_EmpUniverso")
839:                         THIS.txt_4c_CEmps.Value = ALLTRIM(cursor_4c_EmpUniverso.Cemps)
840:                         THIS.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_EmpUniverso.Razas)
841:                         loc_lAchou = .T.
842:                     ENDIF
843:                 ENDIF
844:             CATCH TO loc_oErro
845:                 MsgErro("Erro ao validar a empresa:" + CHR(13) + ;
846:                         loc_oErro.Message + CHR(13) + ;

*-- Linhas 993 a 1085:
993:     * ligada a cursor_4c_Operacoes - equivalente a csOperacoes) + o editbox
994:     * de erros (getErros) e o rotulo "Erros dos Dados" (Say6). Posicoes/
995:     * tamanhos/colunas EXATOS do dump (PILAR 1) - o pColuna do legado
996:     * (Init/With .grdOperacoes) eh quem define largura/ControlSource reais,
997:     * nao apenas os headers do SCX.
998:     *--------------------------------------------------------------------------
999:     PROTECTED PROCEDURE ConfigurarGrade()
1000:         THIS.AddObject("grd_4c_Dados", "Grid")
1001:         WITH THIS.grd_4c_Dados
1002:             .Top               = 230
1003:             .Left              = 21
1004:             .Width             = 929
1005:             .Height            = 346
1006:             .HeaderHeight      = 19
1007:             .DeleteMark        = .F.
1008:             .RecordMark        = .F.
1009:             .ReadOnly          = .F.
1010:             .ScrollBars        = 2
1011:             .AllowHeaderSizing = .F.
1012:             .AllowRowSizing    = .F.
1013:             .ColumnCount       = 11
1014:             .RecordSource      = "cursor_4c_Operacoes"
1015:             .Visible           = .T.
1016:         ENDWITH
1017: 
1018:         WITH THIS.grd_4c_Dados.Column1
1019:             .Movable   = .F.
1020:             .Resizable = .F.
1021:         ENDWITH
1022:         THIS.grd_4c_Dados.Column1.AddObject("Check1", "CheckBox")
1023:         WITH THIS.grd_4c_Dados.Column1.Check1
1024:             .Caption  = ""
1025:             .AutoSize = .T.
1026:         ENDWITH
1027:         THIS.grd_4c_Dados.Column1.CurrentControl  = "Check1"
1028:         THIS.grd_4c_Dados.Column1.Sparse          = .F.
1029:         THIS.grd_4c_Dados.Column1.ReadOnly        = .F.
1030:         THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Operacoes.SelImp"
1031:         THIS.grd_4c_Dados.Column1.Width           = 15
1032:         THIS.grd_4c_Dados.Column1.Header1.Caption = ""
1033: 
1034:         THIS.grd_4c_Dados.Column2.ControlSource  = "cursor_4c_Operacoes.Numes"
1035:         THIS.grd_4c_Dados.Column2.Width           = 52
1036:         THIS.grd_4c_Dados.Column2.Header1.Caption = "C" + CHR(243) + "digo"
1037: 
1038:         THIS.grd_4c_Dados.Column3.ControlSource  = "cursor_4c_Operacoes.Datas"
1039:         THIS.grd_4c_Dados.Column3.Width           = 80
1040:         THIS.grd_4c_Dados.Column3.Header1.Caption = "Data"
1041: 
1042:         THIS.grd_4c_Dados.Column4.ControlSource  = "cursor_4c_Operacoes.Valos"
1043:         THIS.grd_4c_Dados.Column4.Width           = 104
1044:         THIS.grd_4c_Dados.Column4.Header1.Caption = "Valor"
1045: 
1046:         THIS.grd_4c_Dados.Column5.ControlSource  = "cursor_4c_Operacoes.Notas"
1047:         THIS.grd_4c_Dados.Column5.Width           = 75
1048:         THIS.grd_4c_Dados.Column5.Header1.Caption = "Documento"
1049: 
1050:         THIS.grd_4c_Dados.Column6.ControlSource  = "cursor_4c_Operacoes.Usuars"
1051:         THIS.grd_4c_Dados.Column6.Width           = 85
1052:         THIS.grd_4c_Dados.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
1053: 
1054:         THIS.grd_4c_Dados.Column7.ControlSource  = "cursor_4c_Operacoes.ContaOs"
1055:         THIS.grd_4c_Dados.Column7.Width           = 85
1056:         THIS.grd_4c_Dados.Column7.Header1.Caption = "Origem"
1057: 
1058:         THIS.grd_4c_Dados.Column8.ControlSource  = "cursor_4c_Operacoes.ContaDs"
1059:         THIS.grd_4c_Dados.Column8.Width           = 85
1060:         THIS.grd_4c_Dados.Column8.Header1.Caption = "Destino"
1061: 
1062:         THIS.grd_4c_Dados.Column9.ControlSource  = "cursor_4c_Operacoes.Emps"
1063:         THIS.grd_4c_Dados.Column9.Width           = 37
1064:         THIS.grd_4c_Dados.Column9.Header1.Caption = "Emp"
1065: 
1066:         THIS.grd_4c_Dados.Column10.ControlSource  = "cursor_4c_Operacoes.Opers"
1067:         THIS.grd_4c_Dados.Column10.Width           = 37
1068:         THIS.grd_4c_Dados.Column10.Header1.Caption = "E / S"
1069: 
1070:         THIS.grd_4c_Dados.Column11.ControlSource  = "cursor_4c_Operacoes.Dopes"
1071:         THIS.grd_4c_Dados.Column11.Width           = 242
1072:         THIS.grd_4c_Dados.Column11.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1073: 
1074:         THIS.grd_4c_Dados.FontName = "Courier New"
1075:         THIS.grd_4c_Dados.SetAll("Movable", .F., "Column")
1076:         THIS.grd_4c_Dados.SetAll("Resizable", .F., "Column")
1077:         THIS.grd_4c_Dados.Column2.ReadOnly  = .T.
1078:         THIS.grd_4c_Dados.Column3.ReadOnly  = .T.
1079:         THIS.grd_4c_Dados.Column4.ReadOnly  = .T.
1080:         THIS.grd_4c_Dados.Column5.ReadOnly  = .T.
1081:         THIS.grd_4c_Dados.Column6.ReadOnly  = .T.
1082:         THIS.grd_4c_Dados.Column7.ReadOnly  = .T.
1083:         THIS.grd_4c_Dados.Column8.ReadOnly  = .T.
1084:         THIS.grd_4c_Dados.Column9.ReadOnly  = .T.
1085:         THIS.grd_4c_Dados.Column10.ReadOnly = .T.

*-- Linhas 1124 a 1142:
1124:             .DisabledBackColor = RGB(255, 255, 255)
1125:             .DisabledForeColor = RGB(36, 84, 155)
1126:             .ReadOnly          = .T.
1127:             .ControlSource     = "cursor_4c_Operacoes.Erros"
1128:             .TabIndex          = 19
1129:             .Visible           = .T.
1130:         ENDWITH
1131:     ENDPROC
1132: 
1133:     *--------------------------------------------------------------------------
1134:     * GradeAfterRowColChange - AfterRowColChange legado do GrdOperacoes:
1135:     * reflete o Erros da linha corrente no editbox abaixo da grade.
1136:     *--------------------------------------------------------------------------
1137:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1138:         THIS.obj_4c_GetErros.Refresh
1139:     ENDPROC
1140: 
1141:     *--------------------------------------------------------------------------
1142:     * CheckSelImpKeyPress/MouseDown/MouseUp/Click - Check1 da Column1 do

*-- Linhas 1177 a 1195:
1177:             RETURN
1178:         ENDIF
1179: 
1180:         SELECT cursor_4c_Operacoes
1181:         REPLACE SelImp WITH !SelImp
1182:         THIS.grd_4c_Dados.Refresh
1183:     ENDPROC
1184: 
1185:     *--------------------------------------------------------------------------
1186:     * ConfigurarBotoesAcao - cmdBtnGrade (Marcar Tudo / Desmarcar /
1187:     * Documento) e cmdBtnForm (Limpar Sele" + CHR(231) + "ao / Gerar Arquivo
1188:     * / Sair do Processo). Posicoes/tamanhos/captions/icones EXATOS do dump
1189:     * (PILAR 1 + regra "Icone: TRANSCREVER, nunca inventar").
1190:     *--------------------------------------------------------------------------
1191:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
1192:         THIS.AddObject("obj_4c_CmdBtnGrade", "CommandGroup")
1193:         WITH THIS.obj_4c_CmdBtnGrade
1194:             .ButtonCount = 3
1195:             .BackStyle   = 0

*-- Linhas 1332 a 1356:
1332:         DO CASE
1333:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1 AND THIS.obj_4c_CmdBtnGrade.Buttons(1).Enabled
1334:                 *-- Marca Tudo (so as linhas SEM erro de validacao)
1335:                 SELECT cursor_4c_Operacoes
1336:                 REPLACE ALL SelImp WITH .T. FOR EMPTY(ALLTRIM(Erros))
1337:                 THIS.AtualizarGrade()
1338: 
1339:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2 AND THIS.obj_4c_CmdBtnGrade.Buttons(2).Enabled
1340:                 *-- Desmarcar
1341:                 SELECT cursor_4c_Operacoes
1342:                 REPLACE ALL SelImp WITH .F.
1343:                 THIS.AtualizarGrade()
1344: 
1345:             CASE THIS.obj_4c_CmdBtnGrade.Value = 3 AND THIS.obj_4c_CmdBtnGrade.Buttons(3).Enabled
1346:                 *-- Documento: "Do Form SigMvExp With csOperacoes.Dopes, 'C',
1347:                 *-- csOperacoes.Numes, csOperacoes.Emps, .t." do legado
1348:                 IF !EOF("cursor_4c_Operacoes")
1349:                     loc_oForm = .NULL.
1350:                     TRY
1351:                         loc_oForm = CREATEOBJECT("FormSigMvExp", cursor_4c_Operacoes.Dopes, "C", ;
1352:                             cursor_4c_Operacoes.Numes, cursor_4c_Operacoes.Emps, .T.)
1353:                     CATCH TO loc_oErro
1354:                         MsgErro(loc_oErro.Message + CHR(13) + ;
1355:                                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1356:                                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 1512 a 1530:
1512: 
1513:         TRY
1514:             IF USED("cursor_4c_Operacoes")
1515:                 SELECT cursor_4c_Operacoes
1516:                 GO TOP IN cursor_4c_Operacoes
1517:             ENDIF
1518: 
1519:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1520:                 THIS.grd_4c_Dados.Column1.Refresh
1521:                 THIS.grd_4c_Dados.Refresh
1522:             ENDIF
1523: 
1524:             IF PEMSTATUS(THIS, "obj_4c_GetErros", 5)
1525:                 THIS.obj_4c_GetErros.Refresh
1526:             ENDIF
1527:         CATCH TO loc_oErro
1528:             MsgErro(loc_oErro.Message + CHR(13) + ;
1529:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1530:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 1554 a 1572:
1554: 
1555:         TRY
1556:             IF USED("cursor_4c_Operacoes")
1557:                 SELECT cursor_4c_Operacoes
1558:                 SET SAFETY OFF
1559:                 ZAP
1560:                 IF loc_cSafety = "ON"
1561:                     SET SAFETY ON
1562:                 ENDIF
1563:             ENDIF
1564: 
1565:             THIS.AjustarBotoesPorModo(.T.)
1566:             THIS.AtualizarGrade()
1567:         CATCH TO loc_oErro
1568:             IF loc_cSafety = "ON"
1569:                 SET SAFETY ON
1570:             ENDIF
1571: 
1572:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1671 a 1706:
1671:     * ContarSelecionados - Quantas linhas da grade estao marcadas para
1672:     * processamento. Transcreve a consulta do legado (cmdBtnForm.Click):
1673:     *
1674:     *     Select SelImp, Count(1) as Selecionados From csOperacoes
1675:     *      Where SelImp Group By SelImp Into Cursor csSeles
1676:     *
1677:     * Metodo proprio porque a contagem eh consultada em DOIS pontos (o guard do
1678:     * CommandGroup e o do botao de acao) - duplicar o SELECT faria as duas
1679:     * copias divergirem no primeiro ajuste de criterio.
1680:     *--------------------------------------------------------------------------
1681:     PROTECTED FUNCTION ContarSelecionados()
1682:         LOCAL loc_nSelecionados
1683: 
1684:         loc_nSelecionados = 0
1685: 
1686:         IF USED("cursor_4c_Operacoes")
1687:             IF USED("cursor_4c_Contagem")
1688:                 USE IN cursor_4c_Contagem
1689:             ENDIF
1690: 
1691:             SELECT SelImp, COUNT(1) AS Selecionados FROM cursor_4c_Operacoes ;
1692:                 WHERE SelImp GROUP BY SelImp INTO CURSOR cursor_4c_Contagem
1693: 
1694:             IF USED("cursor_4c_Contagem")
1695:                 loc_nSelecionados = TratarNulo(cursor_4c_Contagem.Selecionados, 0)
1696:                 USE IN cursor_4c_Contagem
1697:             ENDIF
1698:         ENDIF
1699: 
1700:         RETURN loc_nSelecionados
1701:     ENDPROC
1702: 
1703:     *--------------------------------------------------------------------------
1704:     * ValidarSelecaoParaGerar - Guard do "Gerar Arquivo": exige ao menos uma
1705:     * linha marcada na grade. Transcreve o bloco que abre o cmdBtnForm.Click
1706:     * legado:

*-- Linhas 1855 a 1873:
1855:         ENDCASE
1856: 
1857:         IF loc_lSucesso
1858:             *-- "If (poDataMgr.Commit() < 1)" do legado: efetiva os INSERT em
1859:             *-- SigPcOoL feitos durante a selecao
1860:             IF loc_lManual
1861:                 IF SQLCOMMIT(gnConnHandle) < 1
1862:                     MsgErro("Favor Reinicializar o Processo!!!", ;
1863:                             "Falha na Conex" + CHR(227) + "o (Commit)")
1864:                     loc_lSucesso = .F.
1865:                 ENDIF
1866:             ENDIF
1867: 
1868:             *-- O legado limpa a grade e reabre os criterios mesmo quando o
1869:             *-- Commit falha (as duas linhas ficam DEPOIS do If interno)
1870:             THIS.LimparSelecao()
1871:         ENDIF
1872: 
1873:         IF !loc_lSucesso


### BO (C:\4c\projeto\app\classes\SIGPRNSEBO.prg):
*====================================================================
* SIGPRNSEBO.prg
*
* Business Object para Integracao de NFS-e Municipal (SIGPRNSE)
* Form OPERACIONAL - selecao de notas de servico ainda nao enviadas
* e geracao de arquivo TXT para as prefeituras do Rio de Janeiro e
* de Sao Paulo
* Tabela principal: SigMvNfi (cidchaves PK, empdopnums char(29))
* Tabelas relacionadas: SigMvCab, SigCdCli, SigCdSer, SigCdEmp,
*                        SigCdMun, SigCdUfs, SigPcOoL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRNSEBO AS BusinessBase

    *-- Propriedades de filtro (controles do form)
    this_nProcessados = 0     && optProcessados.Value - 1=Nao Processadas / 2=Ja Processadas
    this_cEmps        = ""    && getCEmps.Value - codigo da empresa para filtro (char 3)
    this_cDescEmps    = ""    && getDEmps.Value - razao social da empresa (preenchido via fAcessoEmpresa)
    this_dDtIni       = {}    && getDtIni.Value - data inicial do periodo selecionado
    this_dDtFin       = {}    && getDtFin.Value - data final do periodo selecionado
    this_cCidade      = ""    && cmbCidades.Value - "RJ - Rio de Janeiro" ou "SP - Sao Paulo"
    this_cDiretorio   = ""    && getDirs.Value - pasta de gravacao do arquivo gerado

    *-- Dados da empresa, carregados em BuscarNotasPendentes a partir de
    *-- SigCdEmp (Select TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs)
    this_nTpEmps    = 0       && SigCdEmp.TpEmps - 1=CPF / 2=CNPJ da empresa
    this_cCgcs      = ""      && SigCdEmp.Cgcs - CPF/CNPJ da empresa (sem mascara)
    this_cIms       = ""      && SigCdEmp.IMs - Inscricao Municipal da empresa
    this_nEmpofs    = 0       && SigCdEmp.Empofs - Regime Especial de Tributacao
    this_cCodOpers  = ""      && SigCdEmp.CodOpers - Codigo do Servico Federal

    *-- Controle de resultado do processamento / geracao de arquivo
    this_cArquivoGerado    = ""    && caminho completo do arquivo TXT gerado
    this_nTotalLinhas20    = 0     && contador de linhas Tipo 20 (RJ - notas de saida)
    this_nTotalLinhas40    = 0     && contador de linhas Tipo 40 (SP - notas convencionais recebidas)
    this_cMensagemRetorno  = ""    && ultima mensagem de erro/retorno das operacoes SQL

    *-- Dados da operacao (nota fiscal candidata) carregados a partir da linha
    *-- corrente do cursor csOperacoes (populado pelo Form.Selecionar, a partir
    *-- de SigMvNfi + SigMvCab + SigCdCli + SigCdSer) - usados para montar o
    *-- registro de controle gravado em SigPcOoL via Inserir()/Atualizar()
    this_lSelImp     = .F.    && csOperacoes.SelImp - .T. = nota marcada para processamento
    this_cEmpsOp     = ""     && csOperacoes.Emps   - empresa da nota (SigMvNfi.emps)
    this_cDopesOp    = ""     && csOperacoes.Dopes  - documento da operacao (SigMvNfi.dopes)
    this_nNumesOp    = 0      && csOperacoes.Numes  - numero da operacao (SigMvNfi.numes)
    this_dDatasOp    = {}     && csOperacoes.Datas  - data de emissao da nota
    this_nValosOp    = 0      && csOperacoes.Valos  - valor total da nota
    this_cNotasOp    = ""     && csOperacoes.Notas  - numero da NF impressa
    this_cUsuarsOp   = ""     && csOperacoes.Usuars - usuario que gerou a operacao na origem
    this_cContaOsOp  = ""     && csOperacoes.ContaOs - conta de origem da operacao
    this_cContaDsOp  = ""     && csOperacoes.ContaDs - conta de destino da operacao
    this_cOpersOp    = ""     && csOperacoes.Opers  - tipo da operacao ('S'=Saida / 'E'=Entrada)
    this_cErrosOp    = ""     && csOperacoes.Erros  - mensagens de validacao acumuladas

    *-- Registro de controle gravado em SigPcOoL - tabela em que este BO
    *-- efetivamente grava (SigMvNfi so eh LIDA, nunca alterada por este form)
    this_cCidChaves        = ""    && SigPcOoL.cidchaves - PK, gerada via fUniqueIds() (regra #22)
    this_cEmpDopNumsOp     = ""    && SigPcOoL.empdopnums - Emps(3) + Dopes(20) + Str(Numes,6), POSICIONAL (regra #42)
    this_lReprocessamento  = .F.   && .T. quando optProcessados = 2 (Ja Processadas) - grava marca "LANCAMENTO REFEITO"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            *-- SigPcOoL eh a tabela de controle onde Inserir()/Atualizar()
            *-- efetivamente gravam (marca de nota ja enviada a integracao);
            *-- SigMvNfi (comentario de cabecalho do BO) eh so a origem lida.
            THIS.this_cTabela     = "SigPcOoL"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGPRNSEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a linha corrente do cursor csOperacoes
    * (populado pelo Form ao selecionar as notas ainda nao enviadas ou ja processadas)
    * para as propriedades this_*Op, usadas em Inserir()/Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_lSelImp    = SelImp
        THIS.this_cEmpsOp    = TratarNulo(Emps, "")
        THIS.this_cDopesOp   = TratarNulo(Dopes, "")
        THIS.this_nNumesOp   = TratarNulo(Numes, 0)
        THIS.this_dDatasOp   = TratarNulo(Datas, {})
        THIS.this_nValosOp   = TratarNulo(Valos, 0)
        THIS.this_cNotasOp   = TratarNulo(Notas, "")
        THIS.this_cUsuarsOp  = TratarNulo(Usuars, "")
        THIS.this_cContaOsOp = TratarNulo(ContaOs, "")
        THIS.this_cContaDsOp = TratarNulo(ContaDs, "")
        THIS.this_cOpersOp   = TratarNulo(Opers, "")
        THIS.this_cErrosOp   = TratarNulo(Erros, "")

        *-- chave concatenada POSICIONAL (regra #42) - NUNCA ALLTRIM nas partes
        THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava em SigPcOoL o registro de controle que marca a nota
    * (csOperacoes/SigMvNfi carregada em CarregarDoCursor) como enviada para a
    * integracao SIGPRNSE. Espelha o INSERT do legado (PROCEDURE selecionar):
    *   Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds,
    *     Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves    = fUniqueIds()
            THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

            loc_cSQL = "INSERT INTO SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, " + ;
                       "Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests) VALUES (" + ;
                       EscaparSQL("SIGPRNSE") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cEmpsOp, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopesOp, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumesOp, 0) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(PADR(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""), 10)) + ", " + ;
                       EscaparSQL(IIF(THIS.this_lReprocessamento, "LAN" + CHR(199) + "AMENTO REFEITO", "")) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNumsOp) + ", " + ;
                       EscaparSQL("") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar controle de integra" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar controle de integra" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro de controle em SigPcOoL identificado por
    * THIS.this_cCidChaves. O legado NUNCA atualiza SigPcOoL (cada selecao -
    * inclusive reprocessamento - grava um cIdChaves NOVO via fUniqueIds(),
    * regra #22); este metodo cobre o contrato padrao de
    * BusinessBase.Salvar()/EditarRegistro() para corrigir um registro ja
    * gravado, sem inventar regra de negocio que o legado nao tem.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "Registro de controle sem chave para atualizar"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cEmpDopNumsOp = PADR(THIS.this_cEmpsOp, 3) + PADR(THIS.this_cDopesOp, 20) + STR(THIS.this_nNumesOp, 6)

            loc_cSQL = "UPDATE SigPcOoL SET " + ;
                       "Emps = " + EscaparSQL(PADR(THIS.this_cEmpsOp, 3)) + ", " + ;
                       "Dopes = " + EscaparSQL(PADR(THIS.this_cDopesOp, 20)) + ", " + ;
                       "Numes = " + FormatarNumeroSQL(THIS.this_nNumesOp, 0) + ", " + ;
                       "Datas = GETDATE(), " + ;
                       "Usuars = " + EscaparSQL(PADR(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""), 10)) + ", " + ;
                       "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNumsOp) + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar controle de integra" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar controle de integra" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro de controle gravado em SigPcOoL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresAuxiliares - Cria os cursores locais que o Form precisa
    * ANTES de ligar o Grid (regra #41 - Column.ControlSource de cursor
    * inexistente derruba o Init):
    *   cursor_4c_Operacoes  - equivalente a csOperacoes do Load legado:
    *     grade de notas candidatas, com SelImp editavel pelo usuario.
    *   cursor_4c_Municipios - equivalente a LocalUfs do Init legado:
    *     Select Distinct a.Codigos, a.Descs, b.Estados From SigCdMun a,
    *     SigCdUfs b Where a.UFIBGEs = b.UFIBGEs - usado por GerarArquivoRJ
    *     para resolver Cidade/UF de Presta" + "cao do Servico.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresAuxiliares()
        LOCAL loc_lSucesso, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Operacoes")
                CREATE CURSOR cursor_4c_Operacoes (SelImp L, Emps C(3), ;
                    Dopes C(20), Numes N(6, 0), Datas D, Valos N(12, 2), ;
                    Notas C(10), Usuars C(10), ContaOs C(10), ContaDs C(10), ;
                    Opers C(1), Erros M)
                *-- Os CINCO tags do Load legado, na MESMA ordem: em VFP9 o
                *-- ultimo INDEX ON passa a ser a ordem CONTROLADORA, entao
                *-- criar so o primeiro deixaria a grade exibindo por
                *-- Emps+Dopes+Numes em vez de por ContaDs (Destino), que eh
                *-- a ordem em que o legado apresenta as notas.
                INDEX ON Emps + Dopes + STR(Numes, 6)                TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)  TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)        TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)      TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)      TAG Destino
            ENDIF

            IF !USED("cursor_4c_Municipios") AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT a.Codigos, a.Descs, b.Estados " + ;
                    "FROM SigCdMun a, SigCdUfs b " + ;
                    "WHERE a.UFIBGEs = b.UFIBGEs", "cursor_4c_Municipios")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Municipios")
                    SELECT cursor_4c_Municipios
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao criar cursores auxiliares")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNotasPendentes - Equivalente ao PROCEDURE selecionar do legado
    * (SIGPRNSE.SCX), a partir do ponto em que os filtros de tela JA foram
    * validados pelo Form (datas, empresa, diretorio, confirmacao de
    * reprocessamento). Carrega TpEmps/Cgcs/IMs/Empofs/CodOpers de SigCdEmp
    * (usados depois por GerarArquivoRJ/GerarArquivoSP), monta o universo de
    * notas candidatas (SigMvNfi + SigMvCab + SigCdCli + SigCdSer, excluindo
    * - ou so trazendo, se reprocessamento - as que ja tem controle gravado
    * em SigPcOoL para 'SIGPRNSE'), valida cada nota (mesmas checagens do
    * legado - preservadas LITERALMENTE, inclusive a reincidencia do campo
    * Ceps nas checagens de Endereco/Bairro/Cidade/UF, que e bug do legado e
    * nao desta migracao - regra #17) e grava o controle de selecao em
    * SigPcOoL via THIS.Inserir() (reaproveita o contrato ja usado pelo
    * Salvar do BO).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNotasPendentes(par_cEmps, par_dDtIni, par_dDtFin, par_lNaoProcessadas, par_cDiretorio)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado, loc_cErr, loc_oErro
        LOCAL loc_cSafety
        loc_lSucesso = .F.
        loc_cSafety  = SET("SAFETY")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        THIS.this_cEmps            = PADR(ALLTRIM(par_cEmps), 3)
        THIS.this_dDtIni           = par_dDtIni
        THIS.this_dDtFin           = par_dDtFin
        THIS.this_cDiretorio       = ALLTRIM(par_cDiretorio)
        THIS.this_lReprocessamento = !par_lNaoProcessadas

        loc_lProsseguir = .T.

        TRY
            THIS.CriarCursoresAuxiliares()

            *-- Dados da empresa (usados so por GerarArquivoRJ/GerarArquivoSP)
            loc_cSQL = "SELECT TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)

            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nResultado < 0 OR !USED("cursor_4c_Empresa") OR EOF("cursor_4c_Empresa")
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar os dados da empresa: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Empresa
                THIS.this_nTpEmps   = TratarNulo(cursor_4c_Empresa.TpEmps, 0)
                THIS.this_cCgcs     = TratarNulo(cursor_4c_Empresa.Cgcs, "")
                THIS.this_cIms      = TratarNulo(cursor_4c_Empresa.IMs, "")
                THIS.this_nEmpofs   = TratarNulo(cursor_4c_Empresa.Empofs, 0)
                THIS.this_cCodOpers = TratarNulo(cursor_4c_Empresa.CodOpers, "")
                USE IN cursor_4c_Empresa

                *-- Universo de notas candidatas (regra #22/#42 - EmpDopNums eh
                *-- chave POSICIONAL, Emps(3)+Dopes(20)+Str(Numes,6))
                loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, a.Emis, " + ;
                           "b.Obses, a.Cancelas, a.TotProds, a.VCofins, a.TpTribSers, a.PrestServs, " + ;
                           "a.CodBenefs, a.CodSrvFis, a.VDeducoes, a.VDscConds, a.VDscIConds, " + ;
                           "a.OutRetens, a.ISSRetidos, a.TipoNFs, a.VCsll, a.VInss, a.VIrf, a.VPis, " + ;
                           "a.VTotIss, b.Usuars, b.ContaOs, b.ContaDs, c.TpClis, c.Cpfs, c.InscMuns, " + ;
                           "c.Rgs, c.Razaos, c.RClis, c.Endes, c.Nums, c.Compls, c.Bairs, c.Cidas, " + ;
                           "c.Estas, c.Ceps, c.Tel1s, c.eMails, c.OptSimples " + ;
                           "FROM SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d " + ;
                           "WHERE a.Emis BETWEEN " + FormatarDataSQL(THIS.this_dDtIni) + ;
                           " AND " + FormatarDataSQL(DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), DAY(THIS.this_dDtFin), 23, 59, 59)) + ;
                           " AND a.Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                           " AND a.EmpDopNums = b.EmpDopNums" + ;
                           " AND b.ContaDs = c.IClis" + ;
                           " AND LEFT(a.Series, 3) = d.Cods" + ;
                           " AND d.TpServicos IN (1, 3)" + ;
                           " AND a.EmpDopNums " + IIF(par_lNaoProcessadas, "NOT ", "") + ;
                           "IN (SELECT o.EmpDopNums FROM SigPcOoL o WHERE o.Tipos = 'SIGPRNSE')"

                IF USED("cursor_4c_NotasOrigem")
                    USE IN cursor_4c_NotasOrigem
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NotasOrigem")
                IF loc_nResultado < 0 OR !USED("cursor_4c_NotasOrigem")
                    THIS.this_cMensagemErro = "Falha ao consultar as notas: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_NotasOrigem
                GO TOP
                IF EOF("cursor_4c_NotasOrigem")
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o Foram Encontrados Dados Com os Filtros Informados!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Sele" + CHR(231) + CHR(227) + "o de Notas")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("cursor_4c_Operacoes")
                    THIS.CriarCursoresAuxiliares()
                ENDIF
                *-- SET SAFETY eh ESCOPADO POR DATA SESSION e este BO roda
                *-- DENTRO da sessao privada do FormSIGPRNSE (DataSession = 2),
                *-- que nasce com SAFETY = ON apesar do SET SAFETY OFF do
                *-- main.prg (medido no VFP9: sessao 1 = OFF, privada = ON).
                *-- Sem o guard, este ZAP abre o dialogo modal "Zap ... Are you
                *-- sure?" e a tela CONGELA ao clicar "Selecionar Notas", sem
                *-- erro e sem log. O restore tambem vai no CATCH do metodo,
                *-- para o SET nao vazar na sessao privada.
                SELECT cursor_4c_Operacoes
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                SELECT cursor_4c_NotasOrigem
                SCAN WHILE loc_lProsseguir
                    loc_cErr = ""

                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Razaos)) AND EMPTY(ALLTRIM(cursor_4c_NotasOrigem.RClis))
                        loc_cErr = loc_cErr + "O Nome e a Raz" + CHR(227) + "o Social da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Series))
                        loc_cErr = loc_cErr + "A S" + CHR(233) + "rie da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Nfis))
                        loc_cErr = loc_cErr + "O N" + CHR(250) + "mero da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    *-- As 6 checagens abaixo repetem Ceps no legado (PROCEDURE
                    *-- selecionar, SIGPRNSE.SCX) para os rotulos de Endereco/
                    *-- Bairro/Cidade/UF - bug de copia-e-cola do legado,
                    *-- preservado por fidelidade (regra #17 - transcrever,
                    *-- nunca reescrever a regra de negocio).
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O CEP da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O Endere" + CHR(231) + "o da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "O Bairro da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "A Cidade da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(cursor_4c_NotasOrigem.Ceps))
                        loc_cErr = loc_cErr + "A UF da Conta " + CHR(34) + ALLTRIM(cursor_4c_NotasOrigem.ContaOs) + CHR(34) + " Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(cursor_4c_NotasOrigem.Emis)
                        loc_cErr = loc_cErr + "A Data de Emiss" + CHR(227) + "o da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(ALLTRIM(STRTRAN(cursor_4c_NotasOrigem.CodSrvFis, ".", "")))
                        loc_cErr = loc_cErr + "O C" + CHR(243) + "digo do Servi" + CHR(231) + "o Municipal da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                    ENDIF
                    IF EMPTY(cursor_4c_NotasOrigem.TotProds)
                        loc_cErr = loc_cErr + "O Valor dos Servi" + CHR(231) + "os da Nota Est" + CHR(225) + " Zerado;" + CHR(13)
                    ENDIF

                    INSERT INTO cursor_4c_Operacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                            Notas, Usuars, ContaOs, ContaDs, Opers, Erros) VALUES ;
                            (EMPTY(loc_cErr), cursor_4c_NotasOrigem.Emps, cursor_4c_NotasOrigem.Dopes, ;
                            cursor_4c_NotasOrigem.Numes, ConverterParaData(cursor_4c_NotasOrigem.Emis), ;
                            cursor_4c_NotasOrigem.TotProds, cursor_4c_NotasOrigem.Nfis, ;
                            cursor_4c_NotasOrigem.Usuars, cursor_4c_NotasOrigem.ContaOs, ;
                            cursor_4c_NotasOrigem.ContaDs, cursor_4c_NotasOrigem.Operas, loc_cErr)

                    SELECT cursor_4c_Operacoes
                    GO BOTTOM
                    THIS.CarregarDoCursor("cursor_4c_Operacoes")
                    IF !THIS.Inserir()
                        loc_lProsseguir = .F.
                    ENDIF
                    SELECT cursor_4c_NotasOrigem
                ENDSCAN
            ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            *-- Restaura a SAFETY tambem na falha: se o erro estourou entre o
            *-- SET SAFETY OFF e o restore do ZAP, o SET ficaria vazado na
            *-- data session privada do form
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao selecionar notas")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoRJ - Transcricao literal de PROCEDURE prcrjriodejaneiro
    * (SIGPRNSE.SCX) - leiaute TXT da NFS-e da Prefeitura do Rio de Janeiro,
    * versao 3.1 (27/05/2014). Le cursor_4c_NotasOrigem (LocalNotas) e
    * cursor_4c_Operacoes (csOperacoes, apenas SelImp = .T.), separadas por
    * Operas = Saida ('S' -> registro Tipo 20) e Entrada ('E' -> registro
    * Tipo 40), fechando com o rodape Tipo 90.
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoRJ()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cArq, loc_cDir, loc_nR20, loc_nR40, loc_nTsr, loc_nTdd, ;
              loc_nTdc, loc_nTdi, loc_cFim, loc_cTip, loc_cCpf, loc_cIms, loc_cDtI, loc_cDtF, ;
              loc_cStr, loc_cSer, loc_cNot, loc_cEmi, loc_cSts, loc_cTpT, loc_cCpW, loc_cImT, ;
              loc_cIeT, loc_cNmT, loc_cEdT, loc_cTeT, loc_cNeT, loc_cCeT, loc_cBaT, loc_cCdT, ;
              loc_cUfT, loc_cCcT, loc_cT1T, loc_cEmT, loc_cTts, loc_cCps, loc_cUps, loc_cRet, ;
              loc_cOSN, loc_cInC, loc_cCsF, loc_cCdB, loc_cCsM, loc_nAlq, loc_cAlq, loc_cVal, ;
              loc_cVde, loc_cVds, loc_cVdi, loc_cCof, loc_cCsl, loc_cIns, loc_cIrf, loc_cPis, ;
              loc_cOut, loc_cIss, loc_cRtd, loc_cObs, loc_cTpn, loc_cNdt, loc_oErro
        loc_lSucesso = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_NfS")
                USE IN cursor_4c_NfS
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "S" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfS READWRITE

            IF USED("cursor_4c_NfE")
                USE IN cursor_4c_NfE
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "E" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfE READWRITE

            loc_nR20 = 0
            loc_nR40 = 0
            loc_nTsr = 0
            loc_nTdd = 0
            loc_nTdc = 0
            loc_nTdi = 0
            loc_cFim = CHR(13) + CHR(10)

            loc_cTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_cCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_cIms = PADL(CHRTRAN(THIS.this_cIms, ".-/ ", ""), 15, "0")
            loc_cDtI = DTOS(THIS.this_dDtIni)
            loc_cDtF = DTOS(THIS.this_dDtFin)

            loc_cDir = ALLTRIM(THIS.this_cDiretorio)
            loc_cArq = loc_cDir + ALLTRIM(loc_cIms) + "_" + ;
                       LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            STRTOFILE("", loc_cArq, .F.)
            IF !FILE(loc_cArq)
                THIS.this_cMensagemErro = "O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!"
                MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                        "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + CHR(227) + "o e Tente Novamente!!!", ;
                        "Erro Na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lProsseguir = .F.
            ENDIF

        IF loc_lProsseguir
            *-- 3.2. Registro Tipo 10 - Cabecalho
            loc_cStr = "10" + "003" + loc_cTip + loc_cCpf + loc_cIms + loc_cDtI + loc_cDtF + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            *-- Notas de Saida -> Registro Tipo 20
            SELECT cursor_4c_NfS
            SCAN
                loc_cSer = PADR(ALLTRIM(cursor_4c_NfS.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfS.Nfis), 15, "0")
                loc_cEmi = DTOS(cursor_4c_NfS.Emis)
                loc_cSts = IIF(cursor_4c_NfS.Cancelas, "2", "1")

                loc_cTpT = PADL(cursor_4c_NfS.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfS.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfS.InscMuns, ".-/ ", ""), 15, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfS.Rgs, ".-/ ", ""), 15, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfS.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfS.RClis), loc_cNmT), 115)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfS.Endes), 125)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfS.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfS.Compls), 60)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfS.Bairs), 72)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfS.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfS.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfS.Ceps, "-", ""), 8, "0")
                loc_cT1T = PADR(CHRTRAN(cursor_4c_NfS.Tel1s, ".-", ""), 11)
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfS.eMails), 80)

                loc_cTts = PADL(cursor_4c_NfS.TpTribSers, 2, "0")
                loc_cCps = loc_cCdT
                loc_cUps = loc_cUfT
                IF SEEK(cursor_4c_NfS.PrestServs, "cursor_4c_Municipios", "Codigos")
                    loc_cCps = PADR(UPPER(ALLTRIM(cursor_4c_Municipios.Descs)), 50)
                    loc_cUps = PADR(UPPER(ALLTRIM(cursor_4c_Municipios.Estados)), 2)
                ENDIF

                loc_cRet = PADL(THIS.this_nEmpofs, 2, "0")
                loc_cOSN = IIF(cursor_4c_NfS.OptSimples == "S", "1", "0")
                loc_cInC = IIF(INLIST(loc_cTts, "03", "04"), "1", "0")
                loc_cCsF = PADR(THIS.this_cCodOpers, 4)
                loc_cCdB = PADL(ALLTRIM(cursor_4c_NfS.CodBenefs), 3, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfS.CodSrvFis, ".", ""), 6)

                loc_nAlq = (cursor_4c_NfS.VTotIss / cursor_4c_NfS.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 5, "0")
                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfS.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfS.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cVds = PADL(CHRTRAN(STR(cursor_4c_NfS.VDscConds, 20, 2), ". ", ""), 15, "0")
                loc_cVdi = PADL(CHRTRAN(STR(cursor_4c_NfS.VDscIConds, 20, 2), ". ", ""), 15, "0")
                loc_cCof = PADL(CHRTRAN(STR(cursor_4c_NfS.VCofins, 20, 2), ". ", ""), 15, "0")
                loc_cCsl = PADL(CHRTRAN(STR(cursor_4c_NfS.VCsll, 20, 2), ". ", ""), 15, "0")
                loc_cIns = PADL(CHRTRAN(STR(cursor_4c_NfS.VInss, 20, 2), ". ", ""), 15, "0")
                loc_cIrf = PADL(CHRTRAN(STR(cursor_4c_NfS.VIrf, 20, 2), ". ", ""), 15, "0")
                loc_cPis = PADL(CHRTRAN(STR(cursor_4c_NfS.VPis, 20, 2), ". ", ""), 15, "0")
                loc_cOut = PADL(CHRTRAN(STR(cursor_4c_NfS.OutRetens, 20, 2), ". ", ""), 15, "0")
                loc_cIss = PADL(CHRTRAN(STR(cursor_4c_NfS.VTotIss, 20, 2), ". ", ""), 15, "0")
                loc_cRtd = IIF(cursor_4c_NfS.ISSRetidos = 1, "1", "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfS.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfS.VDeducoes
                loc_nTdc = loc_nTdc + cursor_4c_NfS.VDscConds
                loc_nTdi = loc_nTdi + cursor_4c_NfS.VDscIConds

                *-- 3.3. Registro Tipo 20 - Detalhe
                loc_cStr = "20" + "0" + loc_cSer + loc_cNot + loc_cEmi + loc_cSts + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cT1T + loc_cEmT + loc_cTts + loc_cCps + loc_cUps + loc_cRet + ;
                           loc_cOSN + loc_cInC + loc_cCsF + SPACE(11) + loc_cCdB + loc_cCsM + ;
                           loc_cAlq + loc_cVal + loc_cVde + loc_cVds + loc_cVdi + loc_cCof + ;
                           loc_cCsl + loc_cIns + loc_cIrf + loc_cPis + loc_cOut + loc_cIss + ;
                           loc_cRtd + loc_cEmi + SPACE(15) + SPACE(15) + SPACE(5) + ;
                           PADL("", 15, "0") + SPACE(30) + loc_cObs + loc_cFim

                loc_nR20 = loc_nR20 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Notas de Entrada -> Registro Tipo 40
            SELECT cursor_4c_NfE
            SCAN
                loc_cTpn = PADL(ALLTRIM(cursor_4c_NfE.TipoNFs), 2, "0")

                loc_cSer = PADR(ALLTRIM(cursor_4c_NfE.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfE.Nfis), 15, "0")
                loc_cEmi = DTOS(cursor_4c_NfE.Emis)
                loc_cSts = IIF(cursor_4c_NfE.Cancelas, "2", "1")

                loc_cTpT = PADL(cursor_4c_NfE.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfE.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfE.InscMuns, ".-/ ", ""), 15, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfE.Rgs, ".-/ ", ""), 15, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfE.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfE.RClis), loc_cNmT), 115)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfE.Endes), 125)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfE.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfE.Compls), 60)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfE.Bairs), 72)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfE.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfE.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfE.Ceps, "-", ""), 8, "0")
                loc_cT1T = PADR(CHRTRAN(cursor_4c_NfE.Tel1s, ".-", ""), 11)
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfE.eMails), 80)

                loc_cTts = PADL(cursor_4c_NfE.TpTribSers, 2, "0")

                loc_cOSN = IIF(cursor_4c_NfE.OptSimples == "S", "1", "0")
                loc_cCsF = PADR(THIS.this_cCodOpers, 4)
                loc_cCdB = PADL(ALLTRIM(cursor_4c_NfE.CodBenefs), 3, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfE.CodSrvFis, ".", ""), 6)

                loc_nAlq = (cursor_4c_NfE.VTotIss / cursor_4c_NfE.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 5, "0")
                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfE.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfE.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cIss = PADL(CHRTRAN(STR(cursor_4c_NfE.VTotIss, 20, 2), ". ", ""), 15, "0")
                loc_cRtd = IIF(cursor_4c_NfE.ISSRetidos = 1, "1", "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfE.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfE.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfE.VDeducoes

                *-- 3.6. Registro Tipo 40 - Declaracao de Notas Convencionais Recebidas
                loc_cStr = "40" + loc_cTpn + loc_cSer + loc_cNot + loc_cEmi + loc_cSts + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cT1T + loc_cEmT + loc_cTts + SPACE(54) + loc_cOSN + loc_cCsF + ;
                           SPACE(11) + loc_cCdB + loc_cCsM + loc_cAlq + loc_cVal + loc_cVde + ;
                           SPACE(30) + loc_cIss + loc_cRtd + loc_cEmi + SPACE(15) + SPACE(15) + ;
                           loc_cObs + loc_cFim

                loc_nR40 = loc_nR40 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Registro Tipo 90 - Rodape
            loc_cNdt = PADL(CHRTRAN(STR(loc_nR20 + loc_nR40, 20, 0), ". ", ""), 8, "0")
            loc_cStr = "90" + loc_cNdt + ;
                       PADL(CHRTRAN(STR(loc_nTsr, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdd, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdc, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdi, 20, 2), ". ", ""), 15, "0") + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            THIS.this_cArquivoGerado = loc_cArq
            THIS.this_nTotalLinhas20 = loc_nR20
            THIS.this_nTotalLinhas40 = loc_nR40

            MsgInfo("O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_nR20, 10)) + CHR(13) + ;
                    "Notas de Entrada: " + ALLTRIM(STR(loc_nR40, 10)), "Processamento Finalizado")
        ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao gerar arquivo (Rio de Janeiro)")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_NfS")
            USE IN cursor_4c_NfS
        ENDIF
        IF USED("cursor_4c_NfE")
            USE IN cursor_4c_NfE
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoSP - Transcricao literal de PROCEDURE prcspsaopaulo
    * (SIGPRNSE.SCX) - leiaute TXT da NFS-e da Prefeitura de Sao Paulo,
    * versao 3.4 (10/07/2014). So processa Notas de Saida (Operas = 'S'),
    * fechando com o rodape Tipo 9.
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoSP()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cArq, loc_cDir, loc_nRg2, loc_nTsr, loc_nTdd, loc_cFim, ;
              loc_cTip, loc_cCpf, loc_cIms, loc_cDtI, loc_cDtF, loc_cStr, loc_cTpT, loc_cCpW, ;
              loc_cImT, loc_cIeT, loc_cNmT, loc_cEdT, loc_cTeT, loc_cNeT, loc_cCeT, loc_cBaT, ;
              loc_cCdT, loc_cUfT, loc_cCcT, loc_cEmT, loc_cSer, loc_cNot, loc_cEmi, loc_cTts, ;
              loc_cVal, loc_cVde, loc_cCsM, loc_cMps, loc_nAlq, loc_cAlq, loc_cRtd, loc_cPis, ;
              loc_cCof, loc_cIns, loc_cIrf, loc_cCsl, loc_cObs, loc_cNdt, loc_oErro
        loc_lSucesso = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_NfS")
                USE IN cursor_4c_NfS
            ENDIF
            SELECT a.* FROM cursor_4c_NotasOrigem a, cursor_4c_Operacoes b ;
                WHERE a.Operas = "S" AND ;
                      a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                      b.SelImp ;
                INTO CURSOR cursor_4c_NfS READWRITE

            loc_nRg2 = 0
            loc_nTsr = 0
            loc_nTdd = 0
            loc_cFim = CHR(13) + CHR(10)

            loc_cTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_cCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_cIms = PADL(CHRTRAN(THIS.this_cIms, ".-/ ", ""), 8, "0")
            loc_cDtI = DTOS(THIS.this_dDtIni)
            loc_cDtF = DTOS(THIS.this_dDtFin)

            loc_cDir = ALLTRIM(THIS.this_cDiretorio)
            loc_cArq = loc_cDir + ALLTRIM(loc_cIms) + "_" + ;
                       LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            STRTOFILE("", loc_cArq, .F.)
            IF !FILE(loc_cArq)
                THIS.this_cMensagemErro = "O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " N" + CHR(227) + "o Pode Ser Criado!!!"
                MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                        "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + CHR(227) + "o e Tente Novamente!!!", ;
                        "Erro Na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lProsseguir = .F.
            ENDIF

        IF loc_lProsseguir
            *-- 3.2. Registro Tipo 1 - Cabecalho
            loc_cStr = "1" + "002" + loc_cIms + loc_cDtI + loc_cDtF + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            *-- Notas de Saida -> Registro Tipo 6
            SELECT cursor_4c_NfS
            SCAN
                loc_cTpT = PADL(cursor_4c_NfS.TpClis, 1, "0")
                loc_cTpT = IIF(loc_cTpT == "0", "3", loc_cTpT)
                loc_cCpW = PADL(CHRTRAN(cursor_4c_NfS.Cpfs, ".-/ ", ""), 14, "0")
                IF loc_cCpW == "00000000000000"
                    loc_cTpT = "3"
                ENDIF
                loc_cImT = PADL(CHRTRAN(cursor_4c_NfS.InscMuns, ".-/ ", ""), 8, "0")
                loc_cIeT = PADL(CHRTRAN(cursor_4c_NfS.Rgs, ".-/ ", ""), 12, "0")
                loc_cNmT = ALLTRIM(cursor_4c_NfS.Razaos)
                loc_cNmT = PADR(IIF(EMPTY(loc_cNmT), ALLTRIM(cursor_4c_NfS.RClis), loc_cNmT), 75)
                loc_cEdT = PADR(ALLTRIM(cursor_4c_NfS.Endes), 50)
                loc_cTeT = ALLTRIM(LEFT(loc_cEdT, AT(" ", loc_cEdT)))
                loc_cTeT = PADR(IIF(EMPTY(loc_cTeT), "RUA", loc_cTeT), 3)
                loc_cNeT = PADR(ALLTRIM(cursor_4c_NfS.Nums), 10)
                loc_cCeT = PADR(ALLTRIM(cursor_4c_NfS.Compls), 30)
                loc_cBaT = PADR(ALLTRIM(cursor_4c_NfS.Bairs), 30)
                loc_cCdT = PADR(ALLTRIM(cursor_4c_NfS.Cidas), 50)
                loc_cUfT = PADR(ALLTRIM(cursor_4c_NfS.Estas), 2)
                loc_cCcT = PADL(CHRTRAN(cursor_4c_NfS.Ceps, "-", ""), 8, "0")
                loc_cEmT = PADR(ALLTRIM(cursor_4c_NfS.eMails), 75)

                loc_cSer = PADR(ALLTRIM(cursor_4c_NfS.Series), 5)
                loc_cNot = PADL(ALLTRIM(cursor_4c_NfS.Nfis), 12, "0")
                loc_cEmi = DTOS(cursor_4c_NfS.Emis)
                loc_cTts = IIF(cursor_4c_NfS.TpTribSers = 1, "T", ;
                            IIF(cursor_4c_NfS.TpTribSers = 2, "I", ;
                            IIF(cursor_4c_NfS.TpTribSers = 3, "F", ;
                            IIF(cursor_4c_NfS.TpTribSers = 4, "C", ;
                            IIF(cursor_4c_NfS.TpTribSers = 5, "E", ;
                            IIF(cursor_4c_NfS.TpTribSers = 6, "J", "T"))))))

                loc_cVal = PADL(CHRTRAN(STR(cursor_4c_NfS.TotProds, 20, 2), ". ", ""), 15, "0")
                loc_cVde = PADL(CHRTRAN(STR(cursor_4c_NfS.VDeducoes, 20, 2), ". ", ""), 15, "0")
                loc_cCsM = PADR(STRTRAN(cursor_4c_NfS.CodSrvFis, ".", ""), 5)
                loc_cMps = PADL(ALLTRIM(cursor_4c_NfS.PrestServs), 7, "0")

                loc_nAlq = (cursor_4c_NfS.VTotIss / cursor_4c_NfS.TotProds) * 100
                loc_cAlq = PADL(CHRTRAN(STR(loc_nAlq, 9, 2), ". ", ""), 4, "0")
                loc_cRtd = PADR(IIF(cursor_4c_NfS.ISSRetidos = 1, 2, 1), 1)
                loc_cPis = PADL(CHRTRAN(STR(cursor_4c_NfS.VPis, 20, 2), ". ", ""), 15, "0")
                loc_cCof = PADL(CHRTRAN(STR(cursor_4c_NfS.VCofins, 20, 2), ". ", ""), 15, "0")
                loc_cIns = PADL(CHRTRAN(STR(cursor_4c_NfS.VInss, 20, 2), ". ", ""), 15, "0")
                loc_cIrf = PADL(CHRTRAN(STR(cursor_4c_NfS.VIrf, 20, 2), ". ", ""), 15, "0")
                loc_cCsl = PADL(CHRTRAN(STR(cursor_4c_NfS.VCsll, 20, 2), ". ", ""), 15, "0")

                loc_cObs = ALLTRIM(STRTRAN(STRTRAN(TratarNulo(cursor_4c_NfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_cObs = IIF(EMPTY(loc_cObs), "Servi" + CHR(231) + "os Prestados", loc_cObs)

                loc_nTsr = loc_nTsr + cursor_4c_NfS.TotProds
                loc_nTdd = loc_nTdd + cursor_4c_NfS.VDeducoes

                *-- 3.3. Registro Tipo 6
                loc_cStr = "6" + "RPS  " + loc_cSer + loc_cNot + loc_cEmi + loc_cTts + ;
                           loc_cVal + loc_cVde + loc_cCsM + loc_cAlq + loc_cRtd + loc_cTpT + ;
                           loc_cCpW + loc_cImT + loc_cIeT + loc_cNmT + loc_cTeT + loc_cEdT + ;
                           loc_cNeT + loc_cCeT + loc_cBaT + loc_cCdT + loc_cUfT + loc_cCcT + ;
                           loc_cEmT + loc_cPis + loc_cCof + loc_cIns + loc_cIrf + loc_cCsl + ;
                           PADL(0, 15, "0") + PADL(0, 5, "0") + SPACE(10) + PADL(0, 12, "0") + ;
                           PADL(0, 12, "0") + loc_cMps + SPACE(200) + loc_cObs + loc_cFim

                loc_nRg2 = loc_nRg2 + 1
                STRTOFILE(loc_cStr, loc_cArq, .T.)
            ENDSCAN

            *-- Registro Tipo 9 - Rodape
            loc_cNdt = PADL(CHRTRAN(STR(loc_nRg2, 20, 0), ". ", ""), 7, "0")
            loc_cStr = "9" + loc_cNdt + ;
                       PADL(CHRTRAN(STR(loc_nTsr, 20, 2), ". ", ""), 15, "0") + ;
                       PADL(CHRTRAN(STR(loc_nTdd, 20, 2), ". ", ""), 15, "0") + loc_cFim
            STRTOFILE(loc_cStr, loc_cArq, .T.)

            THIS.this_cArquivoGerado = loc_cArq
            THIS.this_nTotalLinhas20 = loc_nRg2
            THIS.this_nTotalLinhas40 = 0

            MsgInfo("O Arquivo " + CHR(34) + loc_cArq + CHR(34) + " Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_nRg2, 10)), "Processamento Finalizado")
        ENDIF

            loc_lSucesso = loc_lProsseguir
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao gerar arquivo (S" + CHR(227) + "o Paulo)")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_NfS")
            USE IN cursor_4c_NfS
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

