# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-ASPAS] Linha 345: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "update sigcdusu set senhas='" + loc_cNovaSenha + "'" + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMLICENCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LIC_STAT, LIC_MAQS, USUARIOS, SELBARRAS, GRUPOS, EMPLANCS, CARQICONES, CEMPS, MENUS, STATUS, TIPO, QTDE
- [TRANSACAO-AVULSA] Linha 349: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 352: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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
  ControlSource = "OPSENHA"
  SelectOnEntry = .F.
		Select ('crsigcdusu1')
		Select ('crEmpresa1')
		lcQuery = [If Exists(Select 1 From SigSyCtl where LIC_Stat = 'A' and Left(LIC_Usua,10) = '] + Padr(Usuar, 10) + [' and Lic_Maqs = ']+Sys(0)+[') ] + ;
						[select 1 as LicUsos else ] + ;
						[Select Count(1) as LicUsos From SigSyCtl Where LIC_Stat = 'A' ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocClsTmp]) < 1)
				Select ('crParam1')
				Select ('crParam2')
			m.lcMcrSql1 = [Select Distinct a.Dopes, a.Menus, a.SubMenus, a.CCentrals, a.NDopes, a.Ordes, a.EmpLancs, b.Opeinatvs, d.ConfigGers ] + ;
							[From SigCdOpe a ] + ;
					   [Left Join SigOpCdc b On a.Dopes = b.Dopes ] + ;
					   [Left Join SigOpCdd d On a.Dopes = d.Dopes ]
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1, 'crTmpOpe')
			Select crTmpOpe
			Update crTmpOpe Set ConfigGers = Nvl(ConfigGers, [])
			m.lcMcrSql1 = ([select a.programas,a.parametros,a.barraforms,b.descricaos,b.barrapict from SigCdAcB a]+;
			               [ left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros]+;
			               [ union all select a.programas,a.parametros,a.barraforms,b.descricaos,b.barrapict from SigCdAcB a]+;
			               [ left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros]+;
			               [ where a.selbarras=?m.pcselbarras and a.grupos in (select c.grupos from SigCdAcG c where c.usuarios=']+m.gcUsuar+[')])
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crTmpAcBarra1')
				Select Distinct a.programas, a.parametros, a.barraforms, ;
				  From crTmpAcBarra1 a ;
				Select crAcBarra1
					If Not Seek(Str(Val(CrAcBarra1.Programas), 10, 0), 'crTmpOpe', 'ndopes') Or ;
								Seek(Str(Val(CrAcBarra1.Programas), 10, 0), 'crTmpOpe', 'ndopes') And ;
							m.lcMcrSql1 = ([select a.marqicones from SigSyIco a where a.carqicones=']+AllTrim(crAcBarra1.barrapict)+['])
								m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crTmpIcone1')
							Select ('crTmpIcone1')
			m.lcMcrSql1 = ([select a.comiss,a.PPLinha1s,a.PPLinha2s,a.nEmps from SigCdEmp a where a.cemps=']+m.gcEmpr+['])
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigCdEmp')
				Select ('SigCdEmp')
			m.lcMcrSql1 = [select a.desmontas,a.habembs,a.habcors,a.habtams,a.habtifs,a.SisTef,a.NumIps from SigCdPam a]
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigCdPam')
			Select a.* From crTmpOpe a;
			m.lcMcrSql1 = [Select * From SigSyCcb Order By Tits]
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigSyCcb')
			m.lcMcrSql1 = [Select Distinct Dopps, Menus, Pccs, Ordes, NDopps, Emplancs ] + ;
							[From SigCdOpd ] + ;
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigCdOpd')
			m.lcMcrSql1 = [Select Distinct NGopes, DGopes, '   ' as EmpLancs ] + ;
							[From SigCdGpe ] + ;
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigCdGpe')
			m.lcMcrSql1 = [Select Distinct NDopes, Dopes ] + ;
							[From SigOpOpe ] + ;
				m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'SigOpOpe')
			Select ('SigCdOpd')
			Select ('SigCdOpe')
			Select ('SigCdGpe')
			Select ('SigOpOpe')
			Select ('SigSyCcb')
lcMcrSql1 = [Select cemps, razas, tipos From SigCdEmp]
	lnErro1 = .poDatamgr.SQLExecute(lcMcrSql1, 'crEmpresa1')
	lcQuery = [select Estas From SigCdEmp Where Cemps = ']+lcEmps+[']
	If (Thisform.poDatamgr.SqlExecute(lcQuery, [csEstEmp]) < 1)
	Select csEstEmp
	lcQuery = [Select * from Sigfipaf where status <> 'AUT']
	If (Thisform.poDatamgr.SqlExecute(lcQuery, [crSigfipaf]) < 1)
	Select crSigfipaf
		Select Count(cidchaves) As Qtde From crSigfipaf Where tipo = 'REDUCAOZ' And Status <> 'AUT' Into Cursor crPaf readwrite
		select datager from crSigfipaf where tipo = 'ESTOQUE' AND status <> 'AUT' into cursor crPaf readwrite
		m.lcMcrSql1 = ('select a.logos from SigCdPam a')
			m.lcMcrSql1 = ThisForm.poDataMgr.SQLExecute(m.lcMcrSql1,'crTmpLogo1')
			Delete File (m.lcArqImage1)
		m.lcMcrSql1 = [select a.ndocks,a.ntmpchks,a.ntmpapps from SigCdPam a order by 1]
			m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1, 'crParam1')
		m.lcMcrSql1 = [select a.ndiasenhas,a.nblosenhas, a.PafEcfs, a.Alertas from SigCdPac a order by 1]
			m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crParam2')
Select crParam2
		Select ('crsigcdusu1')
				m.lcMcrSql1 = [update sigcdusu set senhas='] + Sys(2015) + [' where usuarios='] + This.Parent.Usuario.Value + [']
					m.lnErro1 = ThisForm.poDataMgr.SQLExecute(m.lcMcrSql1)
	m.lcMcrSql1 = [select a.usuarios,a.senhas,a.supervis,a.tdtsenhas,a.ObrigSenhas from sigcdusu a where not a.cativos='N' and a.usuarios=?m.pcUsuario1 order by 1]
		m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crsigcdusu1')
		Select ('crsigcdusu1')
					m.lcMcrSql1 = [Select Distinct Programas, Parametros ] + ;
									[From sigcdprg ] + ;
						Select Distinct a.programas,a.parametros 
							From SigCdAcU a 
						Select Distinct a.programas,a.parametros 
							From SigCdAcU a 
							Left Outer Join SigCdAcG b On a.grupos = b.grupos 
					m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crSigCdAcU1')
				Select Distinct (a.Programas+a.Parametros);
				  From crSigCdAcU1 a;
	m.lcMcrSql1 = [select a.cemps,a.razas,a.tipos, a.Logos from SigCdEmp a order by a.cemps]
	m.lcMcrSql1 = [Select b.Cemps, b.Razas, b.Tipos, b.Logos ] + ;
					[From SigCdAcE a ] + ;
				   [Inner Join SigCdEmp b ] + ;
	m.lnErro1 = ThisForm.poDatamgr.SQLExecute(m.lcMcrSql1,'crEmpresa1')
	Select ('crEmpresa1')
		m.lcMcrSql1 = [select a.cemps,a.razas,a.tipos,a.logos from SigCdEmp a order by 1]
			m.lnErro1 = ThisForm.poDatamgr.SQLExecute(m.lcMcrSql1,'crEmpresa1')
		Select ('crEmpresa1')
				m.lcMcrSql1 = ('select a.logos from SigCdPam a')
					m.lcMcrSql1 =  ThisForm.poDatamgr.SQLExecute(m.lcMcrSql1,'crTmpLogo1')
		m.lcMcrSql1 = [select a.cemps,a.razas,a.tipos from SigCdEmp a order by 1]
			m.lnErro1 = ThisForm.poDatamgr.SQLExecute(m.lcMcrSql1,'crEmpresa1')
		Select ('crEmpresa1')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg) - TRECHOS RELEVANTES PARA PASS SQL (1558 linhas total):

*-- Linhas 280 a 298:
280:             .Height        = 25
281:             .Left          = 22
282:             .MaxLength     = 10
283:             .SelectOnEntry = .F.
284:             .SpecialEffect = 1
285:             .TabIndex      = 1
286:             .ToolTipText   = "Usu" + CHR(225) + "rio do Sistema"
287:             .Top           = 113
288:             .Width         = 119
289:             .ForeColor     = RGB(90,90,90)
290:             .BorderColor   = RGB(238,238,238)
291:             .Value         = ""
292:             .Visible       = .T.
293:         ENDWITH
294: 
295:         THIS.AddObject("txt_4c_SENHA", "TextBox")
296:         WITH THIS.txt_4c_SENHA
297:             .FontBold      = .T.
298:             .FontName      = "Comic Sans MS"

*-- Linhas 331 a 368:
331:             .TabIndex      = 3
332:             .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
333:             .Top           = 217
334:             .Width         = 45
335:             .ForeColor     = RGB(90,90,90)
336:             .BorderColor   = RGB(238,238,238)
337:             .Value         = ""
338:             .Visible       = .T.
339:         ENDWITH
340: 
341:         THIS.AddObject("txt_4c_Demp", "TextBox")
342:         WITH THIS.txt_4c_Demp
343:             .FontBold      = .T.
344:             .FontName      = "Comic Sans MS"
345:             .FontSize      = 11
346:             .BackStyle     = 1
347:             .BorderStyle   = 1
348:             .Format        = "K"
349:             .Height        = 26
350:             .Left          = 74
351:             .MaxLength     = 40
352:             .SpecialEffect = 1
353:             .TabIndex      = 4
354:             .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Empresa"
355:             .Top           = 217
356:             .Width         = 294
357:             .ForeColor     = RGB(90,90,90)
358:             .BorderColor   = RGB(238,238,238)
359:             .Value         = ""
360:             .Visible       = .T.
361:         ENDWITH
362:     ENDPROC
363: 
364:     *==========================================================================
365:     * CriarBotaoSaida - Adiciona CommandGroup SAIDA (botao de encerrar sistema)
366:     *==========================================================================
367:     PROTECTED PROCEDURE CriarBotaoSaida()
368:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")

*-- Linhas 480 a 498:
480:                 THIS.this_oBusinessObject.CarregarEmpresas(loc_cUsuario, loc_lSupervisor)
481: 
482:                 IF USED("crEmpresa1")
483:                     SELECT ("crEmpresa1")
484:                     GO TOP IN crEmpresa1
485: 
486:                     IF RECCOUNT("crEmpresa1") > 1
487:                         THIS.lbl_4c_LblEmpresa.Visible = .T.
488:                         THIS.txt_4c_EMP.Visible        = .T.
489:                         THIS.txt_4c_Demp.Visible       = .T.
490:                     ELSE
491:                         IF RECCOUNT("crEmpresa1") = 1
492:                             THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
493:                             THIS.txt_4c_Demp.Value = crEmpresa1.Razas
494:                         ENDIF
495:                     ENDIF
496:                 ENDIF
497:             ENDIF
498:         CATCH TO loc_oErro

*-- Linhas 552 a 575:
552:             THIS.txt_4c_SENHA.Value, "'", " "), '"', " "), 10)
553: 
554:         IF USED("crParam2")
555:             SELECT crParam2
556:             LOCATE
557:         ENDIF
558: 
559:         IF USED("crsigcdusu1")
560:             SELECT ("crsigcdusu1")
561:             SET ORDER TO ("") IN ("crsigcdusu1")
562:             LOCATE
563: 
564:             IF UPPER(ALLTRIM(THIS.txt_4c_USUARIO.Value)) == "4CONTROL"
565:                 loc_cSenha4c = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
566:                 IF NOT ALLTRIM(THIS.txt_4c_SENHA.Value) == ALLTRIM(loc_cSenha4c)
567:                     loc_lcMsg            = "Usu" + CHR(225) + "rio / Senha Inv" + ;
568:                         CHR(225) + "lidos(1)."
569:                     THIS.this_lUsuarioOk = .F.
570:                 ELSE
571:                     THIS.this_lUsuarioOk = .T.
572:                 ENDIF
573:             ELSE
574:                 IF NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
575:                    NOT EOF("crsigcdusu1") AND ;

*-- Linhas 636 a 654:
636:             ENDIF
637: 
638:             IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
639:                 SELECT ("crEmpresa1")
640:                 LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) == ;
641:                     LOWER(ALLTRIM(THIS.txt_4c_EMP.Value))
642: 
643:                 IF EOF("crEmpresa1")
644:                     THIS.AbrirLookupEmpresaPorCodigo()
645:                 ENDIF
646: 
647:                 THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
648:                     SPACE(3), crEmpresa1.cemps)
649:                 THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
650:                     SPACE(40), crEmpresa1.Razas)
651: 
652:                 THIS.CarregarLogoEmpresa()
653:             ELSE
654:                 THIS.txt_4c_EMP.Value  = SPACE(3)

*-- Linhas 682 a 700:
682:             ENDIF
683: 
684:             IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
685:                 SELECT ("crEmpresa1")
686:                 LOCATE FOR LOWER(ALLTRIM(crEmpresa1.razas)) == ;
687:                     LOWER(ALLTRIM(THIS.txt_4c_Demp.Value))
688: 
689:                 IF EOF("crEmpresa1")
690:                     THIS.AbrirLookupEmpresaPorDesc()
691:                 ENDIF
692: 
693:                 THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
694:                     SPACE(3), crEmpresa1.cemps)
695:                 THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
696:                     SPACE(40), crEmpresa1.razas)
697:             ELSE
698:                 THIS.txt_4c_EMP.Value  = SPACE(3)
699:                 THIS.txt_4c_Demp.Value = SPACE(40)
700:             ENDIF

*-- Linhas 735 a 758:
735:                 loc_oLookup.Show()
736: 
737:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
738:                     SELECT cursor_4c_BuscaEmp
739:                     LOCATE
740:                     IF NOT EOF("cursor_4c_BuscaEmp")
741:                         loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
742:                         IF USED("crEmpresa1")
743:                             SELECT ("crEmpresa1")
744:                             LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
745:                         ENDIF
746:                     ENDIF
747:                 ENDIF
748: 
749:                 IF USED("cursor_4c_BuscaEmp")
750:                     USE IN cursor_4c_BuscaEmp
751:                 ENDIF
752:                 loc_oLookup.Release()
753:             ENDIF
754:         CATCH TO loc_oErro
755:             MsgErro(loc_oErro.Message, "Erro")
756:         ENDTRY
757:     ENDPROC
758: 

*-- Linhas 782 a 805:
782:                 loc_oLookup.Show()
783: 
784:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
785:                     SELECT cursor_4c_BuscaEmp
786:                     LOCATE
787:                     IF NOT EOF("cursor_4c_BuscaEmp")
788:                         loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
789:                         IF USED("crEmpresa1")
790:                             SELECT ("crEmpresa1")
791:                             LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
792:                         ENDIF
793:                     ENDIF
794:                 ENDIF
795: 
796:                 IF USED("cursor_4c_BuscaEmp")
797:                     USE IN cursor_4c_BuscaEmp
798:                 ENDIF
799:                 loc_oLookup.Release()
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message, "Erro")
803:         ENDTRY
804:     ENDPROC
805: 

*-- Linhas 872 a 902:
872:         ENDIF
873: 
874:         IF USED("crsigcdusu1")
875:             SELECT ("crsigcdusu1")
876:             SET ORDER TO ("") IN ("crsigcdusu1")
877:             LOCATE FOR crsigcdusu1.usuarios == THIS.txt_4c_USUARIO.Value
878: 
879:             loc_llChkUsuario = (loc_llChkUsuario OR ;
880:                 (NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
881:                  NOT EOF("crsigcdusu1") AND ;
882:                  THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)))
883:             loc_llSupervis = (UPPER(ALLTRIM(usuar)) == "4CONTROL")
884:         ENDIF
885: 
886:         IF USED("crEmpresa1")
887:             SELECT ("crEmpresa1")
888:             SET ORDER TO ("") IN ("crEmpresa1")
889:             LOCATE FOR crEmpresa1.cemps == THIS.txt_4c_EMP.Value
890: 
891:             loc_llChkEmpresa = (loc_llChkEmpresa OR ;
892:                 (NOT EMPTY(THIS.txt_4c_EMP.Value) AND ;
893:                  NOT EOF("crEmpresa1")))
894:         ENDIF
895: 
896:         IF TYPE("goSistema") = "O" AND goSistema.NumLicencas <> 9999 AND ;
897:            UPPER(ALLTRIM(usuar)) <> "4CONTROL"
898:             LOCAL loc_nLicUsadas
899:             loc_nLicUsadas = THIS.this_oBusinessObject.VerificarLicencas( ;
900:                 ALLTRIM(THIS.txt_4c_USUARIO.Value))
901: 
902:             IF loc_nLicUsadas >= goSistema.NumLicencas

*-- Linhas 1040 a 1058:
1040:             loc_llNbr     = .F.
1041: 
1042:             IF USED("crsigcdusu1")
1043:                 SELECT ("crsigcdusu1")
1044:                 LOCATE
1045:                 IF NOT EOF("crsigcdusu1")
1046:                     loc_llNbr = (NVL(crsigcdusu1.ObrigSenhas, 0) = 1 AND ;
1047:                         EMPTY(ALLTRIM(crsigcdusu1.senhas)))
1048:                     IF NOT ISNULL(crsigcdusu1.tDtSenhas)
1049:                         loc_ldUltData = TTOD(crsigcdusu1.tDtSenhas)
1050:                     ENDIF
1051:                 ENDIF
1052:             ENDIF
1053: 
1054:             IF loc_llNbr OR (loc_lnDias > 0 AND ;
1055:                (loc_ldHoje - loc_ldUltData) >= loc_lnDias)
1056:                 DO FORM SigMOSen WITH "2", .F., THIS.DataSessionId
1057:             ELSE
1058:                 SET SYSMENU ON

*-- Linhas 1194 a 1271:
1194:             goSistema.BarraAtalho.Dock(loc_nDock)
1195: 
1196:             *-- Carrega atalhos do usuario e de seus grupos
1197:             loc_cSQL = "select a.programas,a.parametros,a.barraforms," + ;
1198:                        " b.descricaos,b.barrapict" + ;
1199:                        " from SigCdAcB a" + ;
1200:                        " left join sigcdprg b" + ;
1201:                        " on b.programas+b.parametros=a.programas+a.parametros" + ;
1202:                        " where a.usuarios='" + ALLTRIM(par_cUsuario) + "'" + ;
1203:                        " and a.selbarras=1" + ;
1204:                        " union all" + ;
1205:                        " select a.programas,a.parametros,a.barraforms," + ;
1206:                        " b.descricaos,b.barrapict" + ;
1207:                        " from SigCdAcB a" + ;
1208:                        " left join sigcdprg b" + ;
1209:                        " on b.programas+b.parametros=a.programas+a.parametros" + ;
1210:                        " where a.selbarras=1" + ;
1211:                        " and a.grupos in" + ;
1212:                        " (select c.grupos from SigCdAcG c" + ;
1213:                        " where c.usuarios='" + ALLTRIM(par_cUsuario) + "')"
1214: 
1215:             IF USED("crTmpAcBarra1")
1216:                 USE IN ("crTmpAcBarra1")
1217:             ENDIF
1218: 
1219:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcBarra1") > 0
1220:                 IF USED("crAcBarra1")
1221:                     USE IN ("crAcBarra1")
1222:                 ENDIF
1223:                 SELECT DISTINCT a.programas, a.parametros, a.barraforms, ;
1224:                        PADR(NVL(a.descricaos, ""), 100) AS descricaos, ;
1225:                        PADR(NVL(a.barrapict, ""), 50) AS barrapict ;
1226:                   FROM crTmpAcBarra1 a ;
1227:                  ORDER BY 1, 2 ;
1228:                   INTO CURSOR crAcBarra1 READWRITE
1229:             ENDIF
1230: 
1231:             IF NOT USED("crAcBarra1")
1232:                 RETURN
1233:             ENDIF
1234: 
1235:             SELECT crAcBarra1
1236:             SET ORDER TO ("") IN crAcBarra1
1237:             LOCATE
1238: 
1239:             SCAN WHILE gnConnHandle > 0
1240:                 loc_cArqIcone = ""
1241:                 loc_nTamIcone = 0
1242: 
1243:                 IF NOT EMPTY(ALLTRIM(crAcBarra1.barrapict))
1244:                     loc_cExtIcone = JUSTEXT(ALLTRIM(crAcBarra1.barrapict))
1245:                     IF EMPTY(loc_cExtIcone)
1246:                         loc_cExtIcone = "ico"
1247:                     ENDIF
1248: 
1249:                     loc_cSQL = "select a.marqicones from SigSyIco a" + ;
1250:                                " where a.carqicones='" + ;
1251:                                ALLTRIM(crAcBarra1.barrapict) + "'"
1252:                     IF USED("crTmpIcone1")
1253:                         USE IN ("crTmpIcone1")
1254:                     ENDIF
1255:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpIcone1") > 0
1256:                         SELECT ("crTmpIcone1")
1257:                         LOCATE
1258:                         IF NOT EOF("crTmpIcone1") AND ;
1259:                            NOT ISNULL(crTmpIcone1.marqicones) AND ;
1260:                            NOT EMPTY(crTmpIcone1.marqicones)
1261:                             loc_cArqIcone = loc_cDirTmp + ;
1262:                                 goSistema.Sys2015Tmp + SYS(2015) + ;
1263:                                 "." + loc_cExtIcone
1264:                             loc_nTamIcone = STRTOFILE(crTmpIcone1.marqicones, loc_cArqIcone)
1265:                             IF loc_nTamIcone = 0
1266:                                 loc_cArqIcone = ""
1267:                             ENDIF
1268:                         ENDIF
1269:                         IF USED("crTmpIcone1")
1270:                             USE IN ("crTmpIcone1")
1271:                         ENDIF

*-- Linhas 1329 a 1347:
1329:                 ALLTRIM(THIS.txt_4c_USUARIO.Value), loc_lSupervisor)
1330: 
1331:             IF USED("crEmpresa1")
1332:                 SELECT ("crEmpresa1")
1333:                 SET ORDER TO ("") IN ("crEmpresa1")
1334:                 LOCATE
1335: 
1336:                 IF RECCOUNT("crEmpresa1") = 1
1337:                     THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
1338:                     THIS.txt_4c_Demp.Value = crEmpresa1.Razas
1339:                 ELSE
1340:                     THIS.txt_4c_EMP.Value  = SPACE(3)
1341:                     THIS.txt_4c_Demp.Value = SPACE(40)
1342:                 ENDIF
1343: 
1344:                 THIS.txt_4c_EMP.Refresh()
1345:                 THIS.txt_4c_Demp.Refresh()
1346:             ENDIF
1347:         CATCH TO loc_oErro

