# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, I, ORDEM
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'E' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, I, ORDEM

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
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  ControlSource = ""
		lcQuery = [Delete From SigOpFin Where Dopes = '] + ThisForm.Dopes + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Delete - crSigOpFin)])
	Select crGrdValores
			Select crSigOpFin
			Select crGrdValores
Select crGrdValores
	.Column1.ControlSource = [crGrdValores.Descrs]
ThisForm.getNotas.ControlSource    = [crGrdValores.Notas]
ThisForm.getComandos.ControlSource = [crGrdValores.Comandos]
ThisForm.getCMoes.ControlSource    = [crGrdValores.Moedas]
ThisForm.getTitBans.ControlSource  = [crGrdValores.TitBans]
ThisForm.getTipos.ControlSource    = [crGrdValores.Tipos]
ThisForm.getMovTits.ControlSource  = [crGrdValores.MovTits]
	&lcSub..ControlSource = lcSou
	&lcSub..ControlSource = lcSou
			Select crGrdValores
		Select crGrdValores
			Select crSigOpFin
				Insert Into crGrdValores From Memvar
				Insert Into crGrdValores (Ordem) Values (lnOrd)
	Select * From crGrdValores Where Not Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair
	Select LocalSair
	Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
	Select crLstTitBc
	If Not Seek(Padr(This.Value, 12), [crLstTitBc], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstMoeda
	If Not Seek(Padr(This.Value, 3), [crLstMoeda], [Codigos])
	If Seek(Padr(&lcSub..Value, 10), [crLstCdGcr], [Codigos])
	If Seek(Padr(&lcSub..Value, 10), [crLstCdCli], [Codigos])
If Seek(Padr(ThisForm.getTitBans.Value, 12), [crLstTitBc], [Codigos])
If Seek(Padr(ThisForm.getCMoes.Value, 3), [crLstMoeda], [Codigos])
			Select * From crGrdValores Where Empty(Codigos) Into Cursor LocalBus
				Select Max(Ordem) as Ordem From crGrdValores Into Cursor LocalBus
				Insert Into crGrdValores (Ordem) Values (LocalBus.Ordem + 1)	
	Select crTabOpFin
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Select crLstCdCli
	If Not Seek(Padr(This.Value, 10), [crLstCdCli], [Codigos])
	Select crLstCdGcr
	If Not Seek(Padr(This.Value, 10), [crLstCdGcr], [Codigos])
	Update crGrdValores Set Ordem = lnAtu Where Ordem = lnAtu - 1
	Update crGrdValores Set Ordem = lnAtu - 1 Where Ordem = 999
	Update crGrdValores Set Ordem = Ordem + 1 Where Ordem > lnAtu
	=Seek(lnAtu - 1, [crGrdValores])
	Update crGrdValores Set Ordem = lnAtu Where Ordem = lnAtu + 1
	Update crGrdValores Set Ordem = lnAtu + 1 Where Ordem = 999
	=Seek(lnAtu + 1, [crGrdValores])
		Delete In crGrdValores
		Update crGrdValores Set Ordem = Ordem - 1 Where Ordem > lnAtu
		=Seek(lnAtu, [crGrdValores])

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg) - TRECHOS RELEVANTES PARA PASS SQL (3702 linhas total):

*-- Linhas 70 a 90:
70: *                     SIGOPFIN.Sair.Click do legado (dump linhas 1606-1732):
71: *                     ValidarGradeValores() (validacao linha a linha da
72: *                     grade, so quando EmModoEdicao() e this_lAlterou -
73: *                     equivalente ao "Select ... Into Cursor LocalSair" +
74: *                     "Scan While Empty(lcMsg)"), GravarDados() (equivalente
75: *                     ao PROCEDURE gravardados do legado: em ALTERAR, DELETE
76: *                     de todas as linhas antigas de sigopfin por este Dopes
77: *                     e reinsercao completa via sigopfinBO.Inserir() por
78: *                     linha, renumerando Ordem) e
79: *                     AtualizarConfigFinanceiraOperacao() (equivalente ao
80: *                     "Replace CfgFinancs ... In crSigCdOpe" do fim do
81: *                     gravardados legado - grava os 2 CheckBox nos 2
82: *                     primeiros caracteres da coluna SigCdOpe.cfgfinancs
83: *                     char(20), preservando os 18 restantes). Consolidacao
84: *                     final do form.
85: *
86: * Nomes de objeto conforme tasks/task741/mapeamento.json.
87: *==============================================================================
88: 
89: DEFINE CLASS Formsigopfin AS FormBase
90: 

*-- Linhas 417 a 446:
417: 
418:     *--------------------------------------------------------------------------
419:     * CriarCursorGrdValores - cria o cursor local equivalente a crGrdValores
420:     * (CREATE CURSOR do Load legado, dump de sigopfin_form_codigo_fonte.txt
421:     * linhas 1556-1564): uma linha por origem de valores configurada para a
422:     * movimentacao (this_cDopes). A Fase 7/8 preenche o cursor (equivalente
423:     * ao Scan de crSigOpFin do Init legado) e grava via sigopfinBO.Inserir/
424:     * Atualizar (uma linha por vez). Ordem eh a chave de reordenacao (regra
425:     * CLAUDE.md "CREATE CURSOR: ordem dos campos IDENTICA em todo lugar que
426:     * recriar este cursor" - aqui so existe esta declaracao).
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE CriarCursorGrdValores()
429:         IF !USED("cursor_4c_GrdValores")
430:             SET NULL ON
431:             CREATE CURSOR cursor_4c_GrdValores ;
432:                 (Ordem N(3), Codigos C(10), Descrs C(100), Dopes C(20), ;
433:                  Notas M, Comandos M, Moedas C(3), Tipos C(1), TitBans C(12), ;
434:                  UsuIncs C(10), MovTits C(20), DatIncs T, UsuAlts C(10), ;
435:                  DatAlts T, GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ;
436:                  ContaECs C(11), GrupoPDs C(11), ContaPDs C(11), GrupoPCs C(11), ;
437:                  ContaPCs C(11), GrupoCDs C(11), ContaCDs C(11), GrupoCCs C(11), ;
438:                  ContaCCs C(11), GrupoADs C(11), ContaADs C(11), GrupoACs C(11), ;
439:                  ContaACs C(11))
440:             SET NULL OFF
441:             INDEX ON Ordem TAG Ordem
442:         ENDIF
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas

*-- Linhas 468 a 496:
468:                 .FontSize          = 8
469:                 .AllowHeaderSizing = .F.
470:                 .AllowRowSizing    = .F.
471:                 .DeleteMark        = .F.
472:                 .RecordMark        = .F.
473:                 .RowHeight         = 16
474:                 .ScrollBars        = 2
475:                 .Highlight         = .T.
476:                 .HighlightStyle    = 2
477:                 .TabIndex          = 1
478:                 .ColumnCount       = 1
479:                 .RecordSource      = "cursor_4c_GrdValores"
480: 
481:                 .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
482:                 .Column1.Width             = 700
483:                 .Column1.FontName          = "Tahoma"
484:                 .Column1.FontSize          = 8
485:                 .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
486:                     CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
487:                 .Column1.Header1.Alignment = 2
488:                 .Column1.Header1.FontBold  = .F.
489: 
490:                 .Visible = .T.
491:             ENDWITH
492: 
493:             *-- Celula de lookup da coluna Origem (TextBoxOrigemSigOpFin_4c).
494:             *-- Vem DEPOIS do ENDWITH que fixa ColumnCount/RecordSource:
495:             *-- atribuir ColumnCount recria os objetos Column e destruiria o
496:             *-- controle instalado aqui.

*-- Linhas 601 a 621:
601:                 loc_nAtu = cursor_4c_GrdValores.Ordem
602: 
603:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
604:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu - 1
605:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu - 1 WHERE Ordem = 999
606:                 UPDATE cursor_4c_GrdValores SET Ordem = Ordem + 1 WHERE Ordem > loc_nAtu
607: 
608:                 =SEEK(loc_nAtu - 1, "cursor_4c_GrdValores")
609: 
610:                 THIS.LockScreen    = .F.
611:                 THIS.this_lAlterou = .T.
612:             ENDIF
613: 
614:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
615:                 THIS.grd_4c_Dados.Refresh()
616:                 THIS.grd_4c_Dados.Column1.SetFocus()
617:                 THIS.grd_4c_Dados.Refresh()
618:             ENDIF
619:         CATCH TO loc_oErro
620:             THIS.LockScreen = .F.
621:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 639 a 658:
639:                 loc_nAtu = cursor_4c_GrdValores.Ordem
640: 
641:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
642:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu + 1
643:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu + 1 WHERE Ordem = 999
644: 
645:                 =SEEK(loc_nAtu + 1, "cursor_4c_GrdValores")
646: 
647:                 THIS.LockScreen    = .F.
648:                 THIS.this_lAlterou = .T.
649:             ENDIF
650: 
651:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
652:                 THIS.grd_4c_Dados.Refresh()
653:                 THIS.grd_4c_Dados.Column1.SetFocus()
654:                 THIS.grd_4c_Dados.Refresh()
655:             ENDIF
656:         CATCH TO loc_oErro
657:             THIS.LockScreen = .F.
658:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 678 a 697:
678:                     THIS.LockScreen = .T.
679:                     loc_nAtu = cursor_4c_GrdValores.Ordem
680: 
681:                     DELETE IN cursor_4c_GrdValores
682:                     UPDATE cursor_4c_GrdValores SET Ordem = Ordem - 1 WHERE Ordem > loc_nAtu
683: 
684:                     =SEEK(loc_nAtu, "cursor_4c_GrdValores")
685: 
686:                     THIS.LockScreen    = .F.
687:                     THIS.this_lAlterou = .T.
688:                 ENDIF
689:             ENDIF
690: 
691:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
692:                 THIS.grd_4c_Dados.Refresh()
693:                 THIS.grd_4c_Dados.Column1.SetFocus()
694:                 THIS.grd_4c_Dados.Refresh()
695:             ENDIF
696:         CATCH TO loc_oErro
697:             THIS.LockScreen = .F.

*-- Linhas 704 a 722:
704:     *--------------------------------------------------------------------------
705:     * AfterRowColChange - equivalente ao AfterRowColChange de grdValores no
706:     * legado (dump linhas 2484-2530): repinta os campos de detalhe da linha
707:     * corrente (ja ligados por ControlSource direto a cursor_4c_GrdValores,
708:     * que nao repintam sozinhos ao trocar de linha no grid) e recalcula o
709:     * ToolTipText de Grupo/Conta/TitBans/CMoes. PUBLIC por exigencia do
710:     * BINDEVENT (regra CLAUDE.md #3); tambem chamado diretamente por
711:     * MontaGrade() apos a carga inicial.
712:     *--------------------------------------------------------------------------
713:     PROCEDURE AfterRowColChange(par_nColIndex)
714:         LOCAL loc_oErro
715: 
716:         TRY
717:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
718:                 THIS.txt_4c_GrupoEDs.Refresh()
719:                 THIS.txt_4c_ContaEDs.Refresh()
720:                 THIS.txt_4c_GrupoECs.Refresh()
721:                 THIS.txt_4c_ContaECs.Refresh()
722:                 THIS.txt_4c_GrupoPDs.Refresh()

*-- Linhas 820 a 838:
820:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 12)
821: 
822:             IF !EMPTY(loc_cValor) AND THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
823:                 SELECT crLstTitBc
824:                 GO TOP IN crLstTitBc
825:                 LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == UPPER(loc_cValor)
826:                 IF !EOF("crLstTitBc")
827:                     loc_oTxt.ToolTipText = ALLTRIM(TratarNulo(crLstTitBc.Descrs, ""))
828:                 ENDIF
829:             ENDIF
830:         ENDIF
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * AtualizarTooltipMoeda - ToolTipText da Moeda de Conversao. Legado:
835:     * "Seek(Padr(Value,3), [crLstMoeda], [Codigos])" - tabela real SigCdMoe
836:     * (cmoes/dmoes), ja usada por AbrirLookupMoedaExec.
837:     *--------------------------------------------------------------------------
838:     PROTECTED PROCEDURE AtualizarTooltipMoeda()

*-- Linhas 853 a 889:
853:     ENDPROC
854: 
855:     *--------------------------------------------------------------------------
856:     * ObterDescricaoPorCodigo - SELECT TOP 1 pontual para ToolTipText (nao ha
857:     * cursor local cacheado para Grupo/Conta/Moeda, como havia no legado via
858:     * fSigOpFin_Tabs). Sem conexao (modo de teste/validacao de UI) devolve
859:     * "" em silencio - o ToolTipText fica no default "Campo Em Branco".
860:     *--------------------------------------------------------------------------
861:     PROTECTED FUNCTION ObterDescricaoPorCodigo(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cValor)
862:         LOCAL loc_cDescricao, loc_cSQL, loc_nResultado, loc_cCursorTmp
863:         loc_cDescricao = ""
864:         loc_cCursorTmp = "cursor_4c_TooltipTmp"
865: 
866:         IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor)) ;
867:                 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 ;
868:                 AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
869:             THIS.FecharCursorTemporario(loc_cCursorTmp)
870: 
871:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
872:                 " WHERE " + par_cCampoCod + " = " + EscaparSQL(ALLTRIM(par_cValor))
873: 
874:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)
875: 
876:             IF loc_nResultado > 0 AND USED(loc_cCursorTmp) AND RECCOUNT(loc_cCursorTmp) > 0
877:                 loc_cDescricao = ALLTRIM(TratarNulo( ;
878:                     EVALUATE(loc_cCursorTmp + "." + par_cCampoDesc), ""))
879:             ENDIF
880: 
881:             THIS.FecharCursorTemporario(loc_cCursorTmp)
882:         ENDIF
883: 
884:         RETURN loc_cDescricao
885:     ENDFUNC
886: 
887: 
888:     *--------------------------------------------------------------------------
889:     * ConfigurarCamposGrupoContaEmissorPortador - campos de detalhe da linha

*-- Linhas 896 a 916:
896:     * Say8 (Grupo/Conta), que no dump aparecem uma UNICA vez, acima das 4
897:     * linhas - por isso entram aqui e nao se repetem na Parte 2.
898:     *
899:     * Cada TextBox e ligado via ControlSource direto a
900:     * cursor_4c_GrdValores.<Campo> (mesmo padrao do montagrades legado -
901:     * ThisForm.getGrupoEDs.ControlSource = [crGrdValores.GrupoEDs] - dump em
902:     * comportamento.json, metodo "SIGOPFIN.Procedure"): como o TextBox fica
903:     * FORA do grid mas ligado ao MESMO alias, ele reflete e edita a mesma
904:     * linha corrente que o grid exibe (mestre-detalhe por cursor compartilhado,
905:     * nao FormParaBO/BOParaForm). O religamento e repetido em MontaGrade()
906:     * (ver comentario la) para o caso de o cursor ser recriado.
907:     *
908:     * Nomes de objeto: o mapeamento.json colide "txt_4c_Grupo" para TODOS os
909:     * getGrupo<X><D|C>s (06 controles diferentes gerando o mesmo nome) -
910:     * usar esse nome causaria "object already exists" a cada AddObject
911:     * seguinte. Usa-se aqui o nome com o sufixo completo do legado
912:     * (txt_4c_GrupoEDs, txt_4c_ContaEDs, ...), unico por controle.
913:     *
914:     * MaxLength = 11 vem do schema (grupoeds/contaeds/... char(11) - ver
915:     * comentarios de sigopfinBO.prg), nao do Width em pixels (regra #19).
916:     *--------------------------------------------------------------------------

*-- Linhas 1064 a 1182:
1064:                 .Height        = 23
1065:                 .MaxLength     = 11
1066:                 .TabIndex      = 5
1067:                 .ControlSource = "cursor_4c_GrdValores.GrupoEDs"
1068:                 .Visible       = .T.
1069:             ENDWITH
1070: 
1071:             THIS.AddObject("txt_4c_ContaEDs", "TextBox")
1072:             WITH THIS.txt_4c_ContaEDs
1073:                 .FontName      = "Tahoma"
1074:                 .FontSize      = 8
1075:                 .Top           = 488
1076:                 .Left          = 220
1077:                 .Width         = 77
1078:                 .Height        = 23
1079:                 .MaxLength     = 11
1080:                 .TabIndex      = 6
1081:                 .ControlSource = "cursor_4c_GrdValores.ContaEDs"
1082:                 .Visible       = .T.
1083:             ENDWITH
1084: 
1085:             THIS.AddObject("txt_4c_GrupoECs", "TextBox")
1086:             WITH THIS.txt_4c_GrupoECs
1087:                 .FontName      = "Tahoma"
1088:                 .FontSize      = 8
1089:                 .Top           = 488
1090:                 .Left          = 310
1091:                 .Width         = 77
1092:                 .Height        = 23
1093:                 .MaxLength     = 11
1094:                 .TabIndex      = 7
1095:                 .ControlSource = "cursor_4c_GrdValores.GrupoECs"
1096:                 .Visible       = .T.
1097:             ENDWITH
1098: 
1099:             THIS.AddObject("txt_4c_ContaECs", "TextBox")
1100:             WITH THIS.txt_4c_ContaECs
1101:                 .FontName      = "Tahoma"
1102:                 .FontSize      = 8
1103:                 .Top           = 488
1104:                 .Left          = 391
1105:                 .Width         = 77
1106:                 .Height        = 23
1107:                 .MaxLength     = 11
1108:                 .TabIndex      = 8
1109:                 .ControlSource = "cursor_4c_GrdValores.ContaECs"
1110:                 .Visible       = .T.
1111:             ENDWITH
1112: 
1113:             *-- Linha Portador (dump: getGrupoPDs/getContaPDs/getGrupoPCs/
1114:             *-- getContaPCs, Top=513).
1115:             THIS.AddObject("txt_4c_GrupoPDs", "TextBox")
1116:             WITH THIS.txt_4c_GrupoPDs
1117:                 .FontName      = "Tahoma"
1118:                 .FontSize      = 8
1119:                 .Top           = 513
1120:                 .Left          = 139
1121:                 .Width         = 77
1122:                 .Height        = 23
1123:                 .MaxLength     = 11
1124:                 .TabIndex      = 9
1125:                 .ControlSource = "cursor_4c_GrdValores.GrupoPDs"
1126:                 .Visible       = .T.
1127:             ENDWITH
1128: 
1129:             THIS.AddObject("txt_4c_ContaPDs", "TextBox")
1130:             WITH THIS.txt_4c_ContaPDs
1131:                 .FontName      = "Tahoma"
1132:                 .FontSize      = 8
1133:                 .Top           = 513
1134:                 .Left          = 220
1135:                 .Width         = 77
1136:                 .Height        = 23
1137:                 .MaxLength     = 11
1138:                 .TabIndex      = 10
1139:                 .ControlSource = "cursor_4c_GrdValores.ContaPDs"
1140:                 .Visible       = .T.
1141:             ENDWITH
1142: 
1143:             THIS.AddObject("txt_4c_GrupoPCs", "TextBox")
1144:             WITH THIS.txt_4c_GrupoPCs
1145:                 .FontName      = "Tahoma"
1146:                 .FontSize      = 8
1147:                 .Top           = 513
1148:                 .Left          = 310
1149:                 .Width         = 77
1150:                 .Height        = 23
1151:                 .MaxLength     = 11
1152:                 .TabIndex      = 11
1153:                 .ControlSource = "cursor_4c_GrdValores.GrupoPCs"
1154:                 .Visible       = .T.
1155:             ENDWITH
1156: 
1157:             THIS.AddObject("txt_4c_ContaPCs", "TextBox")
1158:             WITH THIS.txt_4c_ContaPCs
1159:                 .FontName      = "Tahoma"
1160:                 .FontSize      = 8
1161:                 .Top           = 513
1162:                 .Left          = 391
1163:                 .Width         = 77
1164:                 .Height        = 23
1165:                 .MaxLength     = 11
1166:                 .TabIndex      = 12
1167:                 .ControlSource = "cursor_4c_GrdValores.ContaPCs"
1168:                 .Visible       = .T.
1169:             ENDWITH
1170:         CATCH TO loc_oErro
1171:             MsgErro(loc_oErro.Message + CHR(13) + ;
1172:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1173:                 "Procedure: " + loc_oErro.Procedure, ;
1174:                 "Erro em ConfigurarCamposGrupoContaEmissorPortador")
1175:         ENDTRY
1176:     ENDPROC
1177: 
1178:     *--------------------------------------------------------------------------
1179:     * ConfigurarCamposCentroCustoAgenteCobrador - parte 2 (complementar a
1180:     * Fase 5) dos campos de detalhe da linha corrente da grade: linhas Centro de
1181:     * Custo (getGrupoCDs/getContaCDs/getGrupoCCs/getContaCCs, dump Top=538) e
1182:     * Agente Cobrador (getGrupoADs/getContaADs/getGrupoACs/getContaACs, dump

*-- Linhas 1235 a 1353:
1235:                 .Height        = 23
1236:                 .MaxLength     = 11
1237:                 .TabIndex      = 13
1238:                 .ControlSource = "cursor_4c_GrdValores.GrupoCDs"
1239:                 .Visible       = .T.
1240:             ENDWITH
1241: 
1242:             THIS.AddObject("txt_4c_ContaCDs", "TextBox")
1243:             WITH THIS.txt_4c_ContaCDs
1244:                 .FontName      = "Tahoma"
1245:                 .FontSize      = 8
1246:                 .Top           = 538
1247:                 .Left          = 220
1248:                 .Width         = 77
1249:                 .Height        = 23
1250:                 .MaxLength     = 11
1251:                 .TabIndex      = 14
1252:                 .ControlSource = "cursor_4c_GrdValores.ContaCDs"
1253:                 .Visible       = .T.
1254:             ENDWITH
1255: 
1256:             THIS.AddObject("txt_4c_GrupoCCs", "TextBox")
1257:             WITH THIS.txt_4c_GrupoCCs
1258:                 .FontName      = "Tahoma"
1259:                 .FontSize      = 8
1260:                 .Top           = 538
1261:                 .Left          = 310
1262:                 .Width         = 77
1263:                 .Height        = 23
1264:                 .MaxLength     = 11
1265:                 .TabIndex      = 15
1266:                 .ControlSource = "cursor_4c_GrdValores.GrupoCCs"
1267:                 .Visible       = .T.
1268:             ENDWITH
1269: 
1270:             THIS.AddObject("txt_4c_ContaCCs", "TextBox")
1271:             WITH THIS.txt_4c_ContaCCs
1272:                 .FontName      = "Tahoma"
1273:                 .FontSize      = 8
1274:                 .Top           = 538
1275:                 .Left          = 391
1276:                 .Width         = 77
1277:                 .Height        = 23
1278:                 .MaxLength     = 11
1279:                 .TabIndex      = 16
1280:                 .ControlSource = "cursor_4c_GrdValores.ContaCCs"
1281:                 .Visible       = .T.
1282:             ENDWITH
1283: 
1284:             *-- Linha Agente Cobrador (dump: getGrupoADs/getContaADs/
1285:             *-- getGrupoACs/getContaACs, Top=563).
1286:             THIS.AddObject("txt_4c_GrupoADs", "TextBox")
1287:             WITH THIS.txt_4c_GrupoADs
1288:                 .FontName      = "Tahoma"
1289:                 .FontSize      = 8
1290:                 .Top           = 563
1291:                 .Left          = 139
1292:                 .Width         = 77
1293:                 .Height        = 23
1294:                 .MaxLength     = 11
1295:                 .TabIndex      = 17
1296:                 .ControlSource = "cursor_4c_GrdValores.GrupoADs"
1297:                 .Visible       = .T.
1298:             ENDWITH
1299: 
1300:             THIS.AddObject("txt_4c_ContaADs", "TextBox")
1301:             WITH THIS.txt_4c_ContaADs
1302:                 .FontName      = "Tahoma"
1303:                 .FontSize      = 8
1304:                 .Top           = 563
1305:                 .Left          = 220
1306:                 .Width         = 77
1307:                 .Height        = 23
1308:                 .MaxLength     = 11
1309:                 .TabIndex      = 18
1310:                 .ControlSource = "cursor_4c_GrdValores.ContaADs"
1311:                 .Visible       = .T.
1312:             ENDWITH
1313: 
1314:             THIS.AddObject("txt_4c_GrupoACs", "TextBox")
1315:             WITH THIS.txt_4c_GrupoACs
1316:                 .FontName      = "Tahoma"
1317:                 .FontSize      = 8
1318:                 .Top           = 563
1319:                 .Left          = 310
1320:                 .Width         = 77
1321:                 .Height        = 23
1322:                 .MaxLength     = 11
1323:                 .TabIndex      = 19
1324:                 .ControlSource = "cursor_4c_GrdValores.GrupoACs"
1325:                 .Visible       = .T.
1326:             ENDWITH
1327: 
1328:             THIS.AddObject("txt_4c_ContaACs", "TextBox")
1329:             WITH THIS.txt_4c_ContaACs
1330:                 .FontName      = "Tahoma"
1331:                 .FontSize      = 8
1332:                 .Top           = 563
1333:                 .Left          = 391
1334:                 .Width         = 77
1335:                 .Height        = 23
1336:                 .MaxLength     = 11
1337:                 .TabIndex      = 20
1338:                 .ControlSource = "cursor_4c_GrdValores.ContaACs"
1339:                 .Visible       = .T.
1340:             ENDWITH
1341:         CATCH TO loc_oErro
1342:             MsgErro(loc_oErro.Message + CHR(13) + ;
1343:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1344:                 "Procedure: " + loc_oErro.Procedure, ;
1345:                 "Erro em ConfigurarCamposCentroCustoAgenteCobrador")
1346:         ENDTRY
1347:     ENDPROC
1348: 
1349:     *--------------------------------------------------------------------------
1350:     * ConfigurarCamposComplementares - os 4 campos restantes da coluna
1351:     * direita do dump (txt_4c_CMoes/TitBans/Tipos/MovTits, equivalentes a
1352:     * getCMoes/getTitBans/getTipos/getMovTits), com o mesmo padrao de
1353:     * ligacao direta a cursor_4c_GrdValores.<Campo> dos demais campos de

*-- Linhas 1400 a 1418:
1400:                 .Height        = 23
1401:                 .MaxLength     = 3
1402:                 .TabIndex      = 21
1403:                 .ControlSource = "cursor_4c_GrdValores.Moedas"
1404:                 .Visible       = .T.
1405:             ENDWITH
1406: 
1407:             THIS.AddObject("lbl_4c_Label13", "Label")
1408:             WITH THIS.lbl_4c_Label13
1409:                 .FontName  = "Tahoma"
1410:                 .FontSize  = 8
1411:                 .BackStyle = 0
1412:                 .Alignment = 0
1413:                 .AutoSize  = .F.
1414:                 .Top       = 355
1415:                 .Left      = 744
1416:                 .Width     = 57
1417:                 .Height    = 17
1418:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1446 a 1478:
1446:                 .Height        = 23
1447:                 .MaxLength     = 12
1448:                 .TabIndex      = 22
1449:                 .ControlSource = "cursor_4c_GrdValores.TitBans"
1450:                 .Visible       = .T.
1451:             ENDWITH
1452: 
1453:             THIS.AddObject("txt_4c_Tipos", "TextBox")
1454:             WITH THIS.txt_4c_Tipos
1455:                 .FontName      = "Tahoma"
1456:                 .FontSize      = 8
1457:                 .Top           = 370
1458:                 .Left          = 853
1459:                 .Width         = 17
1460:                 .Height        = 23
1461:                 .MaxLength     = 1
1462:                 .TabIndex      = 23
1463:                 .ControlSource = "cursor_4c_GrdValores.Tipos"
1464:                 .Visible       = .T.
1465:             ENDWITH
1466: 
1467:             THIS.AddObject("lbl_4c_Label17", "Label")
1468:             WITH THIS.lbl_4c_Label17
1469:                 .FontName  = "Tahoma"
1470:                 .FontSize  = 8
1471:                 .BackStyle = 0
1472:                 .Alignment = 0
1473:                 .AutoSize  = .F.
1474:                 .Top       = 404
1475:                 .Left      = 744
1476:                 .Width     = 144
1477:                 .Height    = 17
1478:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1490 a 1530:
1490:                 .Height        = 23
1491:                 .MaxLength     = 20
1492:                 .TabIndex      = 24
1493:                 .ControlSource = "cursor_4c_GrdValores.MovTits"
1494:                 .Visible       = .T.
1495:             ENDWITH
1496:         CATCH TO loc_oErro
1497:             MsgErro(loc_oErro.Message + CHR(13) + ;
1498:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1499:                 "Procedure: " + loc_oErro.Procedure, ;
1500:                 "Erro em ConfigurarCamposComplementares")
1501:         ENDTRY
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
1506:     * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
1507:     * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
1508:     * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
1509:     * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
1510:     *
1511:     * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
1512:     * declara Value="0" literal) e NAO ha coluna correspondente nem em
1513:     * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
1514:     * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
1515:     * corresponde) - ficam como estado de tela, sem ControlSource inventado
1516:     * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
1517:     * de dirty-tracking (This.Tag <-> This.Value, que so seta
1518:     * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
1519:     *--------------------------------------------------------------------------
1520:     PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
1521:         LOCAL loc_oErro
1522: 
1523:         TRY
1524:             THIS.AddObject("lbl_4c_Label1", "Label")
1525:             WITH THIS.lbl_4c_Label1
1526:                 .FontName  = "Tahoma"
1527:                 .FontSize  = 8
1528:                 .BackStyle = 0
1529:                 .Alignment = 0
1530:                 .AutoSize  = .F.

*-- Linhas 1549 a 1567:
1549:                 .Height        = 131
1550:                 .ScrollBars    = 2
1551:                 .TabIndex      = 25
1552:                 .ControlSource = "cursor_4c_GrdValores.Notas"
1553:                 .Visible       = .T.
1554:             ENDWITH
1555: 
1556:             THIS.AddObject("lbl_4c_Label2", "Label")
1557:             WITH THIS.lbl_4c_Label2
1558:                 .FontName  = "Tahoma"
1559:                 .FontSize  = 8
1560:                 .BackStyle = 0
1561:                 .Alignment = 0
1562:                 .AutoSize  = .F.
1563:                 .Top       = 455
1564:                 .Left      = 485
1565:                 .Width     = 157
1566:                 .Height    = 15
1567:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1579 a 1597:
1579:                 .Height        = 121
1580:                 .ScrollBars    = 2
1581:                 .TabIndex      = 26
1582:                 .ControlSource = "cursor_4c_GrdValores.Comandos"
1583:                 .Visible       = .T.
1584:             ENDWITH
1585: 
1586:             THIS.AddObject("chk_4c_Chk_P1_CMVS", "CheckBox")
1587:             WITH THIS.chk_4c_Chk_P1_CMVS
1588:                 .FontName  = "Tahoma"
1589:                 .FontSize  = 8
1590:                 .BackStyle = 0
1591:                 .Top       = 256
1592:                 .Left      = 744
1593:                 .Width     = 220
1594:                 .Height    = 17
1595:                 .ForeColor = RGB(90, 90, 90)
1596:                 .Caption   = "CMV de Grupos de Produtos"
1597:                 .Value     = 0

*-- Linhas 1903 a 1921:
1903:                         ENDIF
1904: 
1905:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1906:                             SELECT (loc_cCursor)
1907:                             IF !EOF(loc_cCursor)
1908:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1909:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.codigos, "")), 10) + " ", ;
1910:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.descrs, "")))
1911:                             ENDIF
1912:                         ENDIF
1913: 
1914:                         loc_oBusca.Release()
1915:                     ENDIF
1916: 
1917:                     THIS.FecharCursorTemporario(loc_cCursor)
1918:                 ENDIF
1919:             ENDIF
1920:         CATCH TO loc_oErro
1921:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1974 a 1992:
1974:                         ENDIF
1975: 
1976:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1977:                             SELECT (loc_cCursor)
1978:                             IF !EOF(loc_cCursor)
1979:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1980:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaConta.iclis, "")), 10) + " ", ;
1981:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaConta.rclis, "")))
1982:                             ENDIF
1983:                         ENDIF
1984: 
1985:                         loc_oBusca.Release()
1986:                     ENDIF
1987: 
1988:                     THIS.FecharCursorTemporario(loc_cCursor)
1989:                 ENDIF
1990:             ENDIF
1991:         CATCH TO loc_oErro
1992:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 2039 a 2057:
2039:                         ENDIF
2040: 
2041:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2042:                             SELECT (loc_cCursor)
2043:                             IF !EOF(loc_cCursor)
2044:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2045:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.cmoes, "")), ;
2046:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.dmoes, "")))
2047:                             ENDIF
2048:                         ENDIF
2049: 
2050:                         loc_oBusca.Release()
2051:                     ENDIF
2052: 
2053:                     THIS.FecharCursorTemporario(loc_cCursor)
2054:                 ENDIF
2055:             ENDIF
2056:         CATCH TO loc_oErro
2057:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 2111 a 2129:
2111:                         ENDIF
2112: 
2113:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2114:                             SELECT (loc_cCursor)
2115:                             IF !EOF(loc_cCursor)
2116:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2117:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMovTit.Dopes, "")), "")
2118:                             ENDIF
2119:                         ENDIF
2120: 
2121:                         loc_oBusca.Release()
2122:                     ENDIF
2123: 
2124:                     THIS.FecharCursorTemporario(loc_cCursor)
2125:                 ENDIF
2126:             ENDIF
2127:         CATCH TO loc_oErro
2128:             MsgErro(loc_oErro.Message + CHR(13) + ;
2129:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 2176 a 2194:
2176:                     IF THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
2177:                         *-- Legado: Seek(Padr(This.Value, 12), [crLstTitBc],
2178:                         *-- [Codigos]) - achando exato, nao abre o picker.
2179:                         SELECT crLstTitBc
2180:                         GO TOP IN crLstTitBc
2181:                         LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == ;
2182:                             UPPER(ALLTRIM(LEFT(loc_cValor, 12)))
2183: 
2184:                         IF EOF("crLstTitBc")
2185:                             THIS.MostrarPickerListaLocal("crLstTitBc", ;
2186:                                 "Codigos", "Descrs", ;
2187:                                 "T" + CHR(237) + "tulo Banco")
2188:                         ENDIF
2189: 
2190:                         IF USED("crLstTitBc") AND !EOF("crLstTitBc")
2191:                             THIS.AplicarValorLookup(loc_oTxt, ;
2192:                                 ALLTRIM(TratarNulo(crLstTitBc.Codigos, "")), ;
2193:                                 ALLTRIM(TratarNulo(crLstTitBc.Descrs, "")))
2194:                         ENDIF

*-- Linhas 2259 a 2287:
2259:                     IF THIS.ListaLocalDisponivel("crTabOpFin", "Descrs")
2260:                         loc_lCancelou = .F.
2261: 
2262:                         SELECT crTabOpFin
2263:                         GO TOP IN crTabOpFin
2264:                         LOCATE FOR UPPER(ALLTRIM(crTabOpFin.Descrs)) == ;
2265:                             UPPER(ALLTRIM(LEFT(loc_cValor, 100)))
2266: 
2267:                         IF EOF("crTabOpFin")
2268:                             loc_lCancelou = !THIS.MostrarPickerListaLocal( ;
2269:                                 "crTabOpFin", "Descrs", "Codigos", "Descritivos")
2270:                         ENDIF
2271: 
2272:                         SELECT cursor_4c_GrdValores
2273:                         IF loc_lCancelou OR !USED("crTabOpFin") OR EOF("crTabOpFin")
2274:                             *-- Legado: "If (LastKey() = 27) Replace Codigos
2275:                             *-- With [], Descrs With []".
2276:                             REPLACE Codigos WITH "", ;
2277:                                     Descrs  WITH "" IN cursor_4c_GrdValores
2278:                             par_oTxt.Value = ""
2279:                         ELSE
2280:                             REPLACE Codigos WITH ALLTRIM(TratarNulo(crTabOpFin.Codigos, "")), ;
2281:                                     Descrs  WITH ALLTRIM(TratarNulo(crTabOpFin.Descrs,  "")) ;
2282:                                 IN cursor_4c_GrdValores
2283:                             par_oTxt.Value = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2284:                         ENDIF
2285: 
2286:                         par_oTxt.Tag       = ALLTRIM(TRANSFORM(par_oTxt.Value))
2287:                         THIS.this_lAlterou = .T.

*-- Linhas 2347 a 2365:
2347:     * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
2348:     * marcando a tela como alterada (plAlterou do legado).
2349:     *
2350:     * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
2351:     * .Value grava na linha corrente do cursor, que e exatamente o que o
2352:     * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.
2353:     *--------------------------------------------------------------------------
2354:     PROTECTED PROCEDURE AplicarValorLookup(par_oTxt, par_cValor, par_cDescricao)
2355:         IF VARTYPE(par_oTxt) = "O" AND USED("cursor_4c_GrdValores") ;
2356:                 AND !EOF("cursor_4c_GrdValores")
2357:             par_oTxt.Value = par_cValor
2358: 
2359:             IF VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao)
2360:                 par_oTxt.ToolTipText = par_cDescricao
2361:             ENDIF
2362: 
2363:             par_oTxt.Refresh()
2364:             THIS.this_lAlterou = .T.
2365:         ENDIF

*-- Linhas 2371 a 2389:
2371:     *
2372:     * Conferir a COLUNA (e nao so USED()) evita abrir o picker sobre um alias
2373:     * homonimo de outra tela com estrutura diferente, caso em que o
2374:     * ControlSource da grade do picker estouraria em runtime. TYPE() e usado
2375:     * no lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento -
2376:     * com nome de cursor ele dispara o erro 11 do VFP9.
2377:     *--------------------------------------------------------------------------
2378:     PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
2379:         LOCAL loc_lOk
2380:         loc_lOk = .F.
2381: 
2382:         IF USED(par_cCursor)
2383:             IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
2384:                     AND RECCOUNT(par_cCursor) > 0
2385:                 loc_lOk = .T.
2386:             ENDIF
2387:         ENDIF
2388: 
2389:         RETURN loc_lOk

*-- Linhas 2395 a 2413:
2395:     *
2396:     * Usa a API manual do FormBuscaAuxiliar (CREATEOBJECT sem parametros +
2397:     * mAddColuna + Show) porque o cursor NAO vem de SQL: o Init com parametros
2398:     * dispararia um SELECT contra o SQL Server, que e o oposto do que o legado
2399:     * faz aqui. O cursor ja estar populado e pre-requisito - sem isso o
2400:     * ConfigurarGrid do picker retorna cedo e o dialogo abriria vazio; por
2401:     * isso o chamador sempre passa por ListaLocalDisponivel() antes.
2402:     *
2403:     * Devolve .T. quando o usuario selecionou. Ao selecionar, o ponteiro do
2404:     * cursor fica na linha escolhida (o grid do picker o posiciona), que e
2405:     * como o legado le o registro depois do Show.
2406:     *--------------------------------------------------------------------------
2407:     PROTECTED FUNCTION MostrarPickerListaLocal(par_cCursor, par_cCampoCod, ;
2408:             par_cCampoDesc, par_cTitulo)
2409:         LOCAL loc_oBusca, loc_lSelecionou
2410:         loc_lSelecionou = .F.
2411: 
2412:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2413: 

*-- Linhas 2474 a 2619:
2474:     *
2475:     * Equivalente ao trecho do Init legado (dump de
2476:     * sigopfin_form_codigo_fonte.txt, linhas 1483-1523):
2477:     *   =fSigOpFin_Cria()                        -> SELECT ... FROM sigopfin
2478:     *   Scan crSigOpFin / Scatter / Insert       -> DO WHILE sobre o cursor temp
2479:     *   Insert Into crGrdValores (Ordem) Values  -> linha em branco do fim
2480:     *   .MontaGrades()                           -> THIS.MontaGrade()
2481:     *
2482:     * fSigOpFin_Cria()/fSigOpFin_Tabs() vivem no SigOpFin.prg legado, que NAO
2483:     * veio no acervo; o que elas faziam de fato (abrir as linhas de sigopfin da
2484:     * movimentacao) esta reproduzido aqui com SQL direto sobre a tabela. O
2485:     * legado le crSigOpFin, cursor que o form PAI (cadastro de Operacoes) cria
2486:     * - aqui a consulta e propria, para o dialogo nao depender de cursor de
2487:     * terceiro.
2488:     *
2489:     * O SQLEXEC vai para um cursor TEMPORARIO: SQLEXEC sobre o alias ligado ao
2490:     * Grid fecha e recria o alias, zerando ColumnCount e deixando a grade um
2491:     * retangulo branco sem cabecalho. O alias da grade e recarregado com
2492:     * ZAP + insercao linha a linha, que preserva estrutura e binding.
2493:     *--------------------------------------------------------------------------
2494:     PROCEDURE CarregarDados()
2495:         LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado
2496:         LOCAL loc_nOrdem, loc_oErro
2497:         loc_lSucesso    = .F.
2498:         loc_lProsseguir = .T.
2499: 
2500:         TRY
2501:             THIS.CriarCursorGrdValores()
2502: 
2503:             IF !USED("cursor_4c_GrdValores")
2504:                 MsgErro("Cursor da grade n" + CHR(227) + "o foi criado.", ;
2505:                     "Erro em CarregarDados")
2506:                 loc_lProsseguir = .F.
2507:             ENDIF
2508: 
2509:             IF loc_lProsseguir
2510:                 SELECT cursor_4c_GrdValores
2511:                 ZAP
2512: 
2513:                 *-- Sem conexao (validacao de UI / modo de teste) a grade abre
2514:                 *-- vazia e o form continua funcionando - nao ha SQL a executar.
2515:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
2516:                         AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2517: 
2518:                     THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2519: 
2520:                     loc_cSQL = "SELECT codigos, dopes, ordem," + ;
2521:                                " moedas, tipos, titbans, movtits," + ;
2522:                                " notas, comandos," + ;
2523:                                " usuincs, datincs, usualts, datalts," + ;
2524:                                " grupoeds, contaeds, grupoecs, contaecs," + ;
2525:                                " grupopds, contapds, grupopcs, contapcs," + ;
2526:                                " grupocds, contacds, grupoccs, contaccs," + ;
2527:                                " grupoads, contaads, grupoacs, contaacs" + ;
2528:                                " FROM sigopfin" + ;
2529:                                " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
2530:                                " ORDER BY ordem"
2531: 
2532:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, ;
2533:                         "cursor_4c_GrdValoresTmp")
2534: 
2535:                     IF loc_nResultado < 0
2536:                         MsgErro("Erro ao carregar as configura" + CHR(231) + ;
2537:                             CHR(245) + "es de lan" + CHR(231) + "amento da " + ;
2538:                             "movimenta" + CHR(231) + CHR(227) + "o " + ;
2539:                             ALLTRIM(THIS.this_cDopes) + ":" + CHR(13) + ;
2540:                             CapturarErroSQL(), "Erro SQL")
2541:                         loc_lProsseguir = .F.
2542:                     ENDIF
2543:                 ENDIF
2544:             ENDIF
2545: 
2546:             IF loc_lProsseguir
2547:                 loc_nOrdem = 0
2548: 
2549:                 IF USED("cursor_4c_GrdValoresTmp")
2550:                     SELECT cursor_4c_GrdValoresTmp
2551:                     GO TOP
2552:                     DO WHILE !EOF("cursor_4c_GrdValoresTmp")
2553:                         loc_nOrdem = loc_nOrdem + 1
2554:                         THIS.InserirLinhaGrade(loc_nOrdem)
2555:                         SELECT cursor_4c_GrdValoresTmp
2556:                         SKIP
2557:                     ENDDO
2558:                 ENDIF
2559: 
2560:                 *-- Linha em branco do fim, so em modo de edicao - legado:
2561:                 *--   If InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
2562:                 *--       Insert Into crGrdValores (Ordem) Values (lnOrd)
2563:                 *-- Apenas Ordem e preenchida: Dopes/cIdChaves/UsuIncs sao
2564:                 *-- atribuidos na gravacao (gravardados legado, Fase 8).
2565:                 IF THIS.EmModoEdicao()
2566:                     loc_nOrdem = loc_nOrdem + 1
2567:                     INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nOrdem)
2568:                 ENDIF
2569: 
2570:                 THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2571: 
2572:                 THIS.MontaGrade()
2573: 
2574:                 loc_lSucesso = .T.
2575:             ENDIF
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message + CHR(13) + ;
2578:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2579:                 "Procedure: " + loc_oErro.Procedure, ;
2580:                 "Erro em Formsigopfin.CarregarDados")
2581:         ENDTRY
2582: 
2583:         RETURN loc_lSucesso
2584:     ENDPROC
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * InserirLinhaGrade - acrescenta a cursor_4c_GrdValores a linha corrente de
2588:     * cursor_4c_GrdValoresTmp, renumerando Ordem sequencialmente (par_nOrdem) e
2589:     * resolvendo a descricao da origem. Equivale ao corpo do Scan legado
2590:     * (Scatter Memvar Memo / m.Ordem / m.Descrs / Insert From Memvar).
2591:     *
2592:     * As colunas sao referenciadas com o alias explicito para a insercao nao
2593:     * depender da area de trabalho corrente. Descrs NAO existe na tabela
2594:     * sigopfin (so no cursor da grade) - vem da descricao da origem.
2595:     * DatIncs/DatAlts usam CTOT("") como default, igual ao Nvl(..., Ctot([]))
2596:     * do legado: campo T nao aceita o {} de um DATE vazio.
2597:     *--------------------------------------------------------------------------
2598:     PROTECTED PROCEDURE InserirLinhaGrade(par_nOrdem)
2599:         LOCAL loc_cCodigos, loc_cDescrs
2600: 
2601:         loc_cCodigos = TratarNulo(cursor_4c_GrdValoresTmp.codigos, "")
2602:         loc_cDescrs  = LEFT(THIS.ObterDescricaoOrigem(loc_cCodigos), 100)
2603: 
2604:         INSERT INTO cursor_4c_GrdValores ;
2605:             (Ordem,    Codigos,  Descrs,   Dopes, ;
2606:              Notas,    Comandos, Moedas,   Tipos,    TitBans, ;
2607:              UsuIncs,  MovTits,  DatIncs,  UsuAlts,  DatAlts, ;
2608:              GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
2609:              GrupoPDs, ContaPDs, GrupoPCs, ContaPCs, ;
2610:              GrupoCDs, ContaCDs, GrupoCCs, ContaCCs, ;
2611:              GrupoADs, ContaADs, GrupoACs, ContaACs) ;
2612:             VALUES ;
2613:             (par_nOrdem, ;
2614:              loc_cCodigos, ;
2615:              loc_cDescrs, ;
2616:              TratarNulo(cursor_4c_GrdValoresTmp.dopes,    ""), ;
2617:              TratarNulo(cursor_4c_GrdValoresTmp.notas,    ""), ;
2618:              TratarNulo(cursor_4c_GrdValoresTmp.comandos, ""), ;
2619:              TratarNulo(cursor_4c_GrdValoresTmp.moedas,   ""), ;

*-- Linhas 2665 a 2742:
2665:                 loc_cAliasAnterior = ALIAS()
2666:                 loc_nRegAnterior   = RECNO("crTabOpFin")
2667: 
2668:                 SELECT crTabOpFin
2669:                 LOCATE FOR ALLTRIM(crTabOpFin.Codigos) == ALLTRIM(par_cCodigo)
2670:                 IF !EOF("crTabOpFin")
2671:                     loc_cDescricao = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2672:                 ENDIF
2673: 
2674:                 IF BETWEEN(loc_nRegAnterior, 1, RECCOUNT("crTabOpFin"))
2675:                     GO loc_nRegAnterior IN crTabOpFin
2676:                 ENDIF
2677:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2678:                     SELECT (loc_cAliasAnterior)
2679:                 ENDIF
2680:             ENDIF
2681: 
2682:             IF EMPTY(loc_cDescricao)
2683:                 loc_cDescricao = ALLTRIM(par_cCodigo)
2684:             ENDIF
2685:         ENDIF
2686: 
2687:         RETURN loc_cDescricao
2688:     ENDFUNC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * MontaGrade - religa grd_4c_Dados a cursor_4c_GrdValores e repinta.
2692:     * Equivale ao montagrades legado (dump linhas 1417-1446).
2693:     *
2694:     * Metodo UNICO de repintura: todo caminho que popula, reordena ou exclui
2695:     * linha do cursor termina aqui. Popular o cursor NAO repinta a grade
2696:     * sozinho - o legado tambem fecha com Go Top + Refresh; sem isso a grade
2697:     * fica visualmente vazia com o cursor cheio.
2698:     *
2699:     * A ordem das atribuicoes e a canonica (ColumnCount -> RecordSource ->
2700:     * ControlSource -> Width -> Header1.Caption): RecordSource recalcula as
2701:     * larguras para o default 90 e apaga o caption, por isso os dois vem
2702:     * DEPOIS dele.
2703:     *
2704:     * O montagrades legado tambem religa os ControlSource dos campos de
2705:     * detalhe (getNotas/getComandos/getCMoes/getTitBans/getTipos/getMovTits e
2706:     * os 16 de Grupo/Conta) e chama AfterRowColChange - esses controles sao
2707:     * criados nas Fases 5 e 6, e o religamento deles entra NESTE metodo junto
2708:     * com eles.
2709:     *--------------------------------------------------------------------------
2710:     PROCEDURE MontaGrade()
2711:         LOCAL loc_oGrd, loc_oErro
2712: 
2713:         TRY
2714:             THIS.CriarCursorGrdValores()
2715: 
2716:             SELECT cursor_4c_GrdValores
2717:             SET ORDER TO TAG Ordem
2718:             GO TOP
2719: 
2720:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2721:                 loc_oGrd = THIS.grd_4c_Dados
2722: 
2723:                 WITH loc_oGrd
2724:                     .ColumnCount  = 1
2725:                     .RecordSource = "cursor_4c_GrdValores"
2726: 
2727:                     .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
2728:                     .Column1.Width             = 700
2729:                     .Column1.FontName          = "Tahoma"
2730:                     .Column1.FontSize          = 8
2731:                     .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
2732:                         CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
2733:                         "o Financeira"
2734:                     .Column1.Header1.Alignment = 2
2735:                     .Column1.Header1.FontBold  = .F.
2736: 
2737:                     .Refresh()
2738:                 ENDWITH
2739:             ENDIF
2740: 
2741:             *-- MontaGrade() reatribui ColumnCount, o que RECRIA os objetos
2742:             *-- Column e destroi o TextBox de lookup da celula - reinstalar

*-- Linhas 2752 a 2826:
2752:             *-- primeira passada (CarregarDados roda de novo depois, com
2753:             *-- os controles ja existindo).
2754:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
2755:                 THIS.txt_4c_GrupoEDs.ControlSource = "cursor_4c_GrdValores.GrupoEDs"
2756:                 THIS.txt_4c_ContaEDs.ControlSource = "cursor_4c_GrdValores.ContaEDs"
2757:                 THIS.txt_4c_GrupoECs.ControlSource = "cursor_4c_GrdValores.GrupoECs"
2758:                 THIS.txt_4c_ContaECs.ControlSource = "cursor_4c_GrdValores.ContaECs"
2759:                 THIS.txt_4c_GrupoPDs.ControlSource = "cursor_4c_GrdValores.GrupoPDs"
2760:                 THIS.txt_4c_ContaPDs.ControlSource = "cursor_4c_GrdValores.ContaPDs"
2761:                 THIS.txt_4c_GrupoPCs.ControlSource = "cursor_4c_GrdValores.GrupoPCs"
2762:                 THIS.txt_4c_ContaPCs.ControlSource = "cursor_4c_GrdValores.ContaPCs"
2763:                 THIS.txt_4c_GrupoEDs.Refresh()
2764:                 THIS.txt_4c_ContaEDs.Refresh()
2765:                 THIS.txt_4c_GrupoECs.Refresh()
2766:                 THIS.txt_4c_ContaECs.Refresh()
2767:                 THIS.txt_4c_GrupoPDs.Refresh()
2768:                 THIS.txt_4c_ContaPDs.Refresh()
2769:                 THIS.txt_4c_GrupoPCs.Refresh()
2770:                 THIS.txt_4c_ContaPCs.Refresh()
2771:             ENDIF
2772: 
2773:             *-- Religamento dos campos de detalhe criados nesta Fase 6
2774:             *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
2775:             *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
2776:             *-- Comandos - ConfigurarCamposComplementares/
2777:             *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
2778:             *-- Fase 5 parte 1, mesma razao.
2779:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
2780:                 THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
2781:                 THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
2782:                 THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"
2783:                 THIS.txt_4c_ContaCCs.ControlSource = "cursor_4c_GrdValores.ContaCCs"
2784:                 THIS.txt_4c_GrupoADs.ControlSource = "cursor_4c_GrdValores.GrupoADs"
2785:                 THIS.txt_4c_ContaADs.ControlSource = "cursor_4c_GrdValores.ContaADs"
2786:                 THIS.txt_4c_GrupoACs.ControlSource = "cursor_4c_GrdValores.GrupoACs"
2787:                 THIS.txt_4c_ContaACs.ControlSource = "cursor_4c_GrdValores.ContaACs"
2788:                 THIS.txt_4c_GrupoCDs.Refresh()
2789:                 THIS.txt_4c_ContaCDs.Refresh()
2790:                 THIS.txt_4c_GrupoCCs.Refresh()
2791:                 THIS.txt_4c_ContaCCs.Refresh()
2792:                 THIS.txt_4c_GrupoADs.Refresh()
2793:                 THIS.txt_4c_ContaADs.Refresh()
2794:                 THIS.txt_4c_GrupoACs.Refresh()
2795:                 THIS.txt_4c_ContaACs.Refresh()
2796:             ENDIF
2797: 
2798:             IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
2799:                 THIS.txt_4c_CMoes.ControlSource   = "cursor_4c_GrdValores.Moedas"
2800:                 THIS.txt_4c_TitBans.ControlSource = "cursor_4c_GrdValores.TitBans"
2801:                 THIS.txt_4c_Tipos.ControlSource    = "cursor_4c_GrdValores.Tipos"
2802:                 THIS.txt_4c_MovTits.ControlSource  = "cursor_4c_GrdValores.MovTits"
2803:                 THIS.txt_4c_CMoes.Refresh()
2804:                 THIS.txt_4c_TitBans.Refresh()
2805:                 THIS.txt_4c_Tipos.Refresh()
2806:                 THIS.txt_4c_MovTits.Refresh()
2807:             ENDIF
2808: 
2809:             IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
2810:                 THIS.obj_4c_GetNotas.ControlSource    = "cursor_4c_GrdValores.Notas"
2811:                 THIS.obj_4c_GetComandos.ControlSource = "cursor_4c_GrdValores.Comandos"
2812:                 THIS.obj_4c_GetNotas.Refresh()
2813:                 THIS.obj_4c_GetComandos.Refresh()
2814:             ENDIF
2815: 
2816:             *-- Legado: ".AfterRowColChange()" ao final do montagrades -
2817:             *-- recalcula os ToolTipText de Grupo/Conta/TitBans/CMoes para a
2818:             *-- linha corrente (Fase 7). Chamado por ultimo, com os campos ja
2819:             *-- religados acima.
2820:             THIS.AfterRowColChange()
2821:         CATCH TO loc_oErro
2822:             MsgErro(loc_oErro.Message + CHR(13) + ;
2823:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2824:                 "Procedure: " + loc_oErro.Procedure, ;
2825:                 "Erro em Formsigopfin.MontaGrade")
2826:         ENDTRY

*-- Linhas 2877 a 2895:
2877:     *--------------------------------------------------------------------------
2878:     * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
2879:     * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
2880:     * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
2881:     * dispara o erro 1586 "Function requires row or table buffering mode". Dai
2882:     * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo.
2883:     *--------------------------------------------------------------------------
2884:     PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
2885:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
2886:             IF CURSORGETPROP("Buffering", par_cAlias) > 1
2887:                 TABLEREVERT(.T., par_cAlias)
2888:             ENDIF
2889:             USE IN (par_cAlias)
2890:         ENDIF
2891:     ENDPROC
2892:     *--------------------------------------------------------------------------
2893:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
2894:     * padrao; percorre recursivamente Controls (containers/PageFrame) para
2895:     * garantir que tudo fique visivel apos a montagem.

*-- Linhas 2928 a 2960:
2928:             IF THIS.EmModoEdicao() AND USED("cursor_4c_GrdValores") ;
2929:                     AND LASTKEY() = 13 ;
2930:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
2931:                 SELECT cursor_4c_GrdValores
2932:                 SKIP
2933: 
2934:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2935:                     THIS.grd_4c_Dados.Refresh()
2936:                 ENDIF
2937: 
2938:                 IF EOF("cursor_4c_GrdValores")
2939:                     loc_nQtdeBranco = 0
2940:                     COUNT FOR EMPTY(Codigos) TO loc_nQtdeBranco
2941: 
2942:                     IF loc_nQtdeBranco = 0
2943:                         loc_nMaxOrdem = 0
2944:                         CALCULATE MAX(Ordem) TO loc_nMaxOrdem
2945:                         INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nMaxOrdem + 1)
2946:                     ENDIF
2947: 
2948:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2949:                         THIS.grd_4c_Dados.Refresh()
2950:                     ENDIF
2951:                 ENDIF
2952: 
2953:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2954:                     THIS.grd_4c_Dados.Column1.SetFocus()
2955:                 ENDIF
2956:                 KEYBOARD "{DNARROW}"
2957:             ENDIF
2958:         CATCH TO loc_oErro
2959:             MsgErro(loc_oErro.Message + CHR(13) + ;
2960:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 3267 a 3365:
3267:     *       EndIf
3268:     *   EndIf
3269:     *   If llOks
3270:     *       Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
3271:     *       If ThisForm.GravarDados() / ThisForm.Release() / Else llOks=.f.
3272:     *   EndIf
3273:     *--------------------------------------------------------------------------
3274:     PROCEDURE BtnSairClick()
3275:         LOCAL loc_cMsg, loc_lOk, loc_oErro
3276:         loc_cMsg = ""
3277:         loc_lOk  = .T.
3278: 
3279:         TRY
3280:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3281:                 loc_cMsg = THIS.ValidarGradeValores()
3282:             ENDIF
3283: 
3284:             IF !EMPTY(loc_cMsg)
3285:                 IF MsgConfirma(loc_cMsg + CHR(13) + "Deseja Sair da Tela e " + ;
3286:                         "Abandonar Todos os Dados Alterados?", ;
3287:                         "Erro: Dados Inconsistentes")
3288:                     IF USED("cursor_4c_GrdValores")
3289:                         SELECT cursor_4c_GrdValores
3290:                         ZAP
3291:                     ENDIF
3292:                     THIS.this_lAlterou = .F.
3293:                     loc_lOk = .T.
3294:                 ELSE
3295:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3296:                         THIS.grd_4c_Dados.Refresh()
3297:                         THIS.grd_4c_Dados.SetFocus()
3298:                     ENDIF
3299:                     THIS.AfterRowColChange()
3300:                     loc_lOk = .F.
3301:                 ENDIF
3302:             ENDIF
3303: 
3304:             IF loc_lOk
3305:                 IF USED("cursor_4c_GrdValores")
3306:                     DELETE FROM cursor_4c_GrdValores ;
3307:                         WHERE EMPTY(Codigos) OR EMPTY(Descrs)
3308:                 ENDIF
3309: 
3310:                 IF THIS.GravarDados()
3311:                     THIS.Release()
3312:                 ELSE
3313:                     loc_lOk = .F.
3314:                 ENDIF
3315:             ENDIF
3316:         CATCH TO loc_oErro
3317:             MsgErro(loc_oErro.Message + CHR(13) + ;
3318:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3319:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
3320:         ENDTRY
3321:     ENDPROC
3322: 
3323:     *--------------------------------------------------------------------------
3324:     * ValidarGradeValores - equivalente ao trecho de validacao do
3325:     * SIGOPFIN.Sair.Click legado: "Select * From crGrdValores Where Not
3326:     * Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair" + "Scan
3327:     * While Empty(lcMsg)". Devolve a mensagem de inconsistencia (vazia se
3328:     * tudo estiver OK).
3329:     *
3330:     * Fidelidade a uma peculiaridade do legado: dentro de UMA linha, todos os
3331:     * IFs rodam em sequencia (nenhum e guardado por "Empty(lcMsg)" entre si),
3332:     * entao se MAIS DE UM campo da MESMA linha estiver vazio, loc_cMsg fica
3333:     * com o ULTIMO que bateu (nao o primeiro) - e so DEPOIS de terminar a
3334:     * linha inteira o "Scan While Empty(lcMsg)" para de avancar para a
3335:     * proxima. Por isso o EXIT fica no TOPO do corpo do SCAN, nao substitui o
3336:     * SCAN por "SCAN WHILE".
3337:     *--------------------------------------------------------------------------
3338:     PROTECTED FUNCTION ValidarGradeValores()
3339:         LOCAL loc_cMsg, loc_oErro
3340:         loc_cMsg = ""
3341: 
3342:         TRY
3343:             IF USED("cursor_4c_GrdValores")
3344:                 THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3345: 
3346:                 SELECT * FROM cursor_4c_GrdValores ;
3347:                     WHERE !EMPTY(Codigos) AND !EMPTY(Descrs) ;
3348:                     INTO CURSOR cursor_4c_LocalSair READWRITE
3349: 
3350:                 SELECT cursor_4c_LocalSair
3351:                 GO TOP
3352:                 SCAN
3353:                     IF !EMPTY(loc_cMsg)
3354:                         EXIT
3355:                     ENDIF
3356: 
3357:                     IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LocalSair.Notas, "")))
3358:                         loc_cMsg = "O Campo " + CHR(34) + "Notas Sobre a " + ;
3359:                             "Configura" + CHR(231) + CHR(227) + "o" + CHR(34) + ;
3360:                             " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
3361:                             "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
3362:                         IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
3363:                             THIS.obj_4c_GetNotas.SetFocus()
3364:                         ENDIF
3365:                     ENDIF

*-- Linhas 3451 a 3507:
3451:     * fora do IF).
3452:     *
3453:     * Em ALTERAR, o legado apaga TODAS as linhas antigas de SigOpFin para
3454:     * este Dopes e reinsere TODAS as linhas validas da grade (delete-then-
3455:     * reinsert, nao um diff) - aqui reproduzido com DELETE via SQLEXEC +
3456:     * sigopfinBO.Inserir() por linha, renumerando Ordem sequencialmente.
3457:     *
3458:     * Desvio assumido (documentado, nao e regra de negocio visivel ao
3459:     * usuario): o legado preserva UsuIncs/DatIncs/UsuAlts/DatAlts das linhas
3460:     * pre-existentes no delete-then-reinsert (Iif(pcEscolha=INSERIR Or
3461:     * Empty(m.UsuIncs), Usuar, m.UsuIncs), e similar para os outros tres);
3462:     * sigopfinBO.Inserir() sempre estampa this_cUsuIncs=gc_4c_UsuarioLogado,
3463:     * datincs=GETDATE() e datalts=NULL (nao ha gancho para preservar os
3464:     * valores originais sem reescrever o BO), e this_cUsuAlts fica no
3465:     * default "" do BO (nenhuma linha reinserida e tratada como "alterada"
3466:     * por este fluxo). O rastro de quem/quando INCLUIU de fato fica no
3467:     * LogAuditoria via RegistrarAuditoria(), chamado dentro do proprio
3468:     * Inserir().
3469:     *--------------------------------------------------------------------------
3470:     PROTECTED FUNCTION GravarDados()
3471:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nOrdem, loc_oLinha, loc_oErro
3472:         loc_lSucesso = .T.
3473: 
3474:         TRY
3475:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3476: 
3477:                 IF UPPER(ALLTRIM(THIS.this_cModoAtual)) = "ALTERAR"
3478:                     loc_cSQL = "DELETE FROM sigopfin WHERE dopes = " + ;
3479:                         EscaparSQL(THIS.this_cDopes)
3480: 
3481:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3482:                     IF loc_nResultado < 0
3483:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3484:                             CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
3485:                         loc_lSucesso = .F.
3486:                     ENDIF
3487:                 ENDIF
3488: 
3489:                 IF loc_lSucesso AND USED("cursor_4c_GrdValores")
3490:                     loc_nOrdem = 0
3491: 
3492:                     SELECT cursor_4c_GrdValores
3493:                     GO TOP
3494:                     SCAN FOR !EMPTY(Codigos)
3495:                         loc_nOrdem = loc_nOrdem + 1
3496: 
3497:                         loc_oLinha = CREATEOBJECT("sigopfinBO")
3498:                         IF VARTYPE(loc_oLinha) = "O"
3499:                             *-- CarregarDoCursor() do BO NAO serve aqui: ele le
3500:                             *-- cidchaves/chkempds, colunas que NAO existem em
3501:                             *-- cursor_4c_GrdValores (CriarCursorGrdValores so
3502:                             *-- declara os campos que a grade/campos de
3503:                             *-- detalhe usam - cidchaves e gerado de novo a
3504:                             *-- cada Inserir() e chkempds nao tem controle na
3505:                             *-- tela). Chama-lo estouraria "Variable CIDCHAVES
3506:                             *-- is not found". Os campos sao copiados um a um.
3507:                             loc_oLinha.this_cCodigos  = TratarNulo(cursor_4c_GrdValores.Codigos,  "")

*-- Linhas 3566 a 3616:
3566:     * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
3567:     * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
3568:     * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
3569:     * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
3570:     * blank-padding ANSI do SQL Server.
3571:     *
3572:     * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
3573:     * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma
3574:     * inconsistencia que nao e deste form).
3575:     *--------------------------------------------------------------------------
3576:     PROTECTED FUNCTION AtualizarConfigFinanceiraOperacao()
3577:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCfgAtual, loc_cCfgNova, loc_oErro
3578:         loc_lSucesso = .T.
3579: 
3580:         TRY
3581:             THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3582: 
3583:             loc_cSQL = "SELECT cfgfinancs FROM SigCdOpe WHERE dopes = " + ;
3584:                 EscaparSQL(THIS.this_cDopes)
3585: 
3586:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgFinTmp")
3587: 
3588:             IF loc_nResultado >= 0 AND USED("cursor_4c_CfgFinTmp") ;
3589:                     AND RECCOUNT("cursor_4c_CfgFinTmp") > 0
3590:                 loc_cCfgAtual = PADR(TratarNulo(cursor_4c_CfgFinTmp.cfgfinancs, ""), 20)
3591: 
3592:                 loc_cCfgNova = PADR(IIF(THIS.chk_4c_Chk_P1_CMVS.Value = 1, "S", "N"), 1) + ;
3593:                                PADR(IIF(THIS.chk_4c_Chk_P2_MOBS.Value = 1, "S", "N"), 1) + ;
3594:                                SUBSTR(loc_cCfgAtual, 3, 18)
3595: 
3596:                 THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3597: 
3598:                 loc_cSQL = "UPDATE SigCdOpe SET cfgfinancs = " + EscaparSQL(loc_cCfgNova) + ;
3599:                     " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
3600: 
3601:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3602:                 IF loc_nResultado < 0
3603:                     MsgErro("Erro ao atualizar a configura" + CHR(231) + CHR(227) + ;
3604:                         "o financeira da opera" + CHR(231) + CHR(227) + "o:" + ;
3605:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
3606:                     loc_lSucesso = .F.
3607:                 ENDIF
3608:             ELSE
3609:                 THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3610:             ENDIF
3611:         CATCH TO loc_oErro
3612:             loc_lSucesso = .F.
3613:             MsgErro(loc_oErro.Message + CHR(13) + ;
3614:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3615:                 "Procedure: " + loc_oErro.Procedure, ;
3616:                 "Erro em AtualizarConfigFinanceiraOperacao")


### BO (C:\4c\projeto\app\classes\sigopfinBO.prg):
*====================================================================
* sigopfinBO.prg
*
* Business Object para Configuracao de Lancamentos Financeiros
* Tabela: sigopfin
* Herda de: BusinessBase
*
* Cada registro de sigopfin eh uma LINHA de configuracao (origem dos
* valores a serem lancados) associada a uma movimentacao (dopes, FK
* para SigOpOpe.Dopes). A tela (Formsigopfin) exibe/edita varias
* linhas simultaneamente num grid; este BO trata uma linha por vez.
*====================================================================

DEFINE CLASS sigopfinBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopfin)
    this_cCidChaves = ""    && cidchaves char(20) - PK (Fortyus)
    this_cCodigos   = ""    && codigos   char(10) - FK para origem (crTabOpFin.Codigos)
    this_cComandos  = ""    && comandos  text     - memo de comandos de programacao
    this_cContaAcs  = ""    && contaacs  char(11)
    this_cContaAds  = ""    && contaads  char(11)
    this_cContaCcs  = ""    && contaccs  char(11)
    this_cContaCds  = ""    && contacds  char(11)
    this_cContaEcs  = ""    && contaecs  char(11)
    this_cContaEds  = ""    && contaeds  char(11)
    this_cContaPcs  = ""    && contapcs  char(11)
    this_cContaPds  = ""    && contapds  char(11)
    this_dDatAlts   = {}    && datalts   datetime
    this_dDatIncs   = {}    && datincs   datetime
    this_cDopes     = ""    && dopes     char(20) - FK para SigOpOpe.Dopes (movimentacao)
    this_cGrupoAcs  = ""    && grupoacs  char(11)
    this_cGrupoAds  = ""    && grupoads  char(11)
    this_cGrupoCcs  = ""    && grupoccs  char(11)
    this_cGrupoCds  = ""    && grupocds  char(11)
    this_cGrupoEcs  = ""    && grupoecs  char(11)
    this_cGrupoEds  = ""    && grupoeds  char(11)
    this_cGrupoPcs  = ""    && grupopcs  char(11)
    this_cGrupoPds  = ""    && grupopds  char(11)
    this_cMoedas    = ""    && moedas    char(3)
    this_cMovTits   = ""    && movtits   char(20)
    this_cNotas     = ""    && notas     text     - memo de notas sobre a configuracao
    this_nOrdem     = 0     && ordem     numeric(3,0)
    this_cTipos     = ""    && tipos     char(1)
    this_cTitBans   = ""    && titbans   char(12)
    this_cUsuAlts   = ""    && usualts   char(10)
    this_cUsuIncs   = ""    && usuincs   char(10)
    this_nChkEmpds  = 0     && chkempds  numeric(1,0)

    *-- Propriedade NAO persistida: descricao exibida no grid (origem do
    *-- lookup contra crTabOpFin.Descrs, casada por this_cCodigos). Nao
    *-- existe coluna "descrs" em sigopfin - eh so exibicao.
    this_cDescricao = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopfin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopfinBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * da linha de configuracao (sigopfin). par_cAliasCursor eh o alias do
    * cursor posicionado no registro a carregar (ex.: resultado de um
    * SQLEXEC pela chave cidchaves, ou a linha corrente de crGrdValores).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCodigos   = TratarNulo(codigos,   "")
            THIS.this_cComandos  = TratarNulo(comandos,  "")
            THIS.this_cContaAcs  = TratarNulo(contaacs,  "")
            THIS.this_cContaAds  = TratarNulo(contaads,  "")
            THIS.this_cContaCcs  = TratarNulo(contaccs,  "")
            THIS.this_cContaCds  = TratarNulo(contacds,  "")
            THIS.this_cContaEcs  = TratarNulo(contaecs,  "")
            THIS.this_cContaEds  = TratarNulo(contaeds,  "")
            THIS.this_cContaPcs  = TratarNulo(contapcs,  "")
            THIS.this_cContaPds  = TratarNulo(contapds,  "")
            THIS.this_dDatAlts   = TratarNulo(datalts,   {})
            THIS.this_dDatIncs   = TratarNulo(datincs,   {})
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupoAcs  = TratarNulo(grupoacs,  "")
            THIS.this_cGrupoAds  = TratarNulo(grupoads,  "")
            THIS.this_cGrupoCcs  = TratarNulo(grupoccs,  "")
            THIS.this_cGrupoCds  = TratarNulo(grupocds,  "")
            THIS.this_cGrupoEcs  = TratarNulo(grupoecs,  "")
            THIS.this_cGrupoEds  = TratarNulo(grupoeds,  "")
            THIS.this_cGrupoPcs  = TratarNulo(grupopcs,  "")
            THIS.this_cGrupoPds  = TratarNulo(grupopds,  "")
            THIS.this_cMoedas    = TratarNulo(moedas,    "")
            THIS.this_cMovTits   = TratarNulo(movtits,   "")
            THIS.this_cNotas     = TratarNulo(notas,     "")
            THIS.this_nOrdem     = TratarNulo(ordem,     0)
            THIS.this_cTipos     = TratarNulo(tipos,     "")
            THIS.this_cTitBans   = TratarNulo(titbans,   "")
            THIS.this_cUsuAlts   = TratarNulo(usualts,   "")
            THIS.this_cUsuIncs   = TratarNulo(usuincs,   "")
            THIS.this_nChkEmpds  = TratarNulo(chkempds,  0)

            *-- descrs nao eh coluna de sigopfin: so chega quando o cursor de
            *-- origem for montado com JOIN contra crTabOpFin/SigOpOpe (lookup
            *-- da descricao exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricao = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricao = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cUsuIncs   = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO sigopfin (cidchaves, codigos, comandos, contaacs," + ;
                       " contaads, contaccs, contacds, contaecs, contaeds, contapcs," + ;
                       " contapds, datalts, datincs, dopes, grupoacs, grupoads," + ;
                       " grupoccs, grupocds, grupoecs, grupoeds, grupopcs, grupopds," + ;
                       " moedas, movtits, notas, ordem, tipos, titbans, usualts," + ;
                       " usuincs, chkempds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cComandos)  + "," + ;
                       EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       "NULL," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cDopes)     + "," + ;
                       EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       EscaparSQL(THIS.this_cNotas)     + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       EscaparSQL(THIS.this_cTipos)     + "," + ;
                       EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       EscaparSQL(THIS.this_cUsuIncs)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de uma linha de configuracao na tabela sigopfin
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsuAlts = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE sigopfin SET" + ;
                       " codigos   = " + EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       " comandos  = " + EscaparSQL(THIS.this_cComandos)  + "," + ;
                       " contaacs  = " + EscaparSQL(THIS.this_cContaAcs)  + "," + ;
                       " contaads  = " + EscaparSQL(THIS.this_cContaAds)  + "," + ;
                       " contaccs  = " + EscaparSQL(THIS.this_cContaCcs)  + "," + ;
                       " contacds  = " + EscaparSQL(THIS.this_cContaCds)  + "," + ;
                       " contaecs  = " + EscaparSQL(THIS.this_cContaEcs)  + "," + ;
                       " contaeds  = " + EscaparSQL(THIS.this_cContaEds)  + "," + ;
                       " contapcs  = " + EscaparSQL(THIS.this_cContaPcs)  + "," + ;
                       " contapds  = " + EscaparSQL(THIS.this_cContaPds)  + "," + ;
                       " datalts   = GETDATE()," + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)     + "," + ;
                       " grupoacs  = " + EscaparSQL(THIS.this_cGrupoAcs)  + "," + ;
                       " grupoads  = " + EscaparSQL(THIS.this_cGrupoAds)  + "," + ;
                       " grupoccs  = " + EscaparSQL(THIS.this_cGrupoCcs)  + "," + ;
                       " grupocds  = " + EscaparSQL(THIS.this_cGrupoCds)  + "," + ;
                       " grupoecs  = " + EscaparSQL(THIS.this_cGrupoEcs)  + "," + ;
                       " grupoeds  = " + EscaparSQL(THIS.this_cGrupoEds)  + "," + ;
                       " grupopcs  = " + EscaparSQL(THIS.this_cGrupoPcs)  + "," + ;
                       " grupopds  = " + EscaparSQL(THIS.this_cGrupoPds)  + "," + ;
                       " moedas    = " + EscaparSQL(THIS.this_cMoedas)    + "," + ;
                       " movtits   = " + EscaparSQL(THIS.this_cMovTits)   + "," + ;
                       " notas     = " + EscaparSQL(THIS.this_cNotas)     + "," + ;
                       " ordem     = " + FormatarNumeroSQL(THIS.this_nOrdem, 0) + "," + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + "," + ;
                       " titbans   = " + EscaparSQL(THIS.this_cTitBans)   + "," + ;
                       " usualts   = " + EscaparSQL(THIS.this_cUsuAlts)   + "," + ;
                       " chkempds  = " + FormatarNumeroSQL(THIS.this_nChkEmpds, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o financeira:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

