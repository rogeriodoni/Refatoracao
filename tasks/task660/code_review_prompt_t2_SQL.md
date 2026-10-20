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

