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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfin.prg) - TRECHOS RELEVANTES PARA PASS SQL (3700 linhas total):

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

*-- Linhas 417 a 445:
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
430:             CREATE CURSOR cursor_4c_GrdValores ;
431:                 (Ordem N(3), Codigos C(10), Descrs C(100), Dopes C(20), ;
432:                  Notas M, Comandos M, Moedas C(3), Tipos C(1), TitBans C(12), ;
433:                  UsuIncs C(10), MovTits C(20), DatIncs T, UsuAlts C(10), ;
434:                  DatAlts T, GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ;
435:                  ContaECs C(11), GrupoPDs C(11), ContaPDs C(11), GrupoPCs C(11), ;
436:                  ContaPCs C(11), GrupoCDs C(11), ContaCDs C(11), GrupoCCs C(11), ;
437:                  ContaCCs C(11), GrupoADs C(11), ContaADs C(11), GrupoACs C(11), ;
438:                  ContaACs C(11))
439:             INDEX ON Ordem TAG Ordem
440:         ENDIF
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     * ConfigurarGrid - grd_4c_Dados (equivalente a grdValores, dump linhas
445:     * 999-1023: ColumnCount=1, Column1.Width=700, Header1.Caption = titulo da

*-- Linhas 466 a 494:
466:                 .FontSize          = 8
467:                 .AllowHeaderSizing = .F.
468:                 .AllowRowSizing    = .F.
469:                 .DeleteMark        = .F.
470:                 .RecordMark        = .F.
471:                 .RowHeight         = 16
472:                 .ScrollBars        = 2
473:                 .Highlight         = .T.
474:                 .HighlightStyle    = 2
475:                 .TabIndex          = 1
476:                 .ColumnCount       = 1
477:                 .RecordSource      = "cursor_4c_GrdValores"
478: 
479:                 .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
480:                 .Column1.Width             = 700
481:                 .Column1.FontName          = "Tahoma"
482:                 .Column1.FontSize          = 8
483:                 .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
484:                     CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
485:                 .Column1.Header1.Alignment = 2
486:                 .Column1.Header1.FontBold  = .F.
487: 
488:                 .Visible = .T.
489:             ENDWITH
490: 
491:             *-- Celula de lookup da coluna Origem (TextBoxOrigemSigOpFin_4c).
492:             *-- Vem DEPOIS do ENDWITH que fixa ColumnCount/RecordSource:
493:             *-- atribuir ColumnCount recria os objetos Column e destruiria o
494:             *-- controle instalado aqui.

*-- Linhas 599 a 619:
599:                 loc_nAtu = cursor_4c_GrdValores.Ordem
600: 
601:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
602:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu - 1
603:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu - 1 WHERE Ordem = 999
604:                 UPDATE cursor_4c_GrdValores SET Ordem = Ordem + 1 WHERE Ordem > loc_nAtu
605: 
606:                 =SEEK(loc_nAtu - 1, "cursor_4c_GrdValores")
607: 
608:                 THIS.LockScreen    = .F.
609:                 THIS.this_lAlterou = .T.
610:             ENDIF
611: 
612:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
613:                 THIS.grd_4c_Dados.Refresh()
614:                 THIS.grd_4c_Dados.Column1.SetFocus()
615:                 THIS.grd_4c_Dados.Refresh()
616:             ENDIF
617:         CATCH TO loc_oErro
618:             THIS.LockScreen = .F.
619:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 637 a 656:
637:                 loc_nAtu = cursor_4c_GrdValores.Ordem
638: 
639:                 REPLACE Ordem WITH 999 IN cursor_4c_GrdValores
640:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu WHERE Ordem = loc_nAtu + 1
641:                 UPDATE cursor_4c_GrdValores SET Ordem = loc_nAtu + 1 WHERE Ordem = 999
642: 
643:                 =SEEK(loc_nAtu + 1, "cursor_4c_GrdValores")
644: 
645:                 THIS.LockScreen    = .F.
646:                 THIS.this_lAlterou = .T.
647:             ENDIF
648: 
649:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
650:                 THIS.grd_4c_Dados.Refresh()
651:                 THIS.grd_4c_Dados.Column1.SetFocus()
652:                 THIS.grd_4c_Dados.Refresh()
653:             ENDIF
654:         CATCH TO loc_oErro
655:             THIS.LockScreen = .F.
656:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 676 a 695:
676:                     THIS.LockScreen = .T.
677:                     loc_nAtu = cursor_4c_GrdValores.Ordem
678: 
679:                     DELETE IN cursor_4c_GrdValores
680:                     UPDATE cursor_4c_GrdValores SET Ordem = Ordem - 1 WHERE Ordem > loc_nAtu
681: 
682:                     =SEEK(loc_nAtu, "cursor_4c_GrdValores")
683: 
684:                     THIS.LockScreen    = .F.
685:                     THIS.this_lAlterou = .T.
686:                 ENDIF
687:             ENDIF
688: 
689:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
690:                 THIS.grd_4c_Dados.Refresh()
691:                 THIS.grd_4c_Dados.Column1.SetFocus()
692:                 THIS.grd_4c_Dados.Refresh()
693:             ENDIF
694:         CATCH TO loc_oErro
695:             THIS.LockScreen = .F.

*-- Linhas 702 a 720:
702:     *--------------------------------------------------------------------------
703:     * AfterRowColChange - equivalente ao AfterRowColChange de grdValores no
704:     * legado (dump linhas 2484-2530): repinta os campos de detalhe da linha
705:     * corrente (ja ligados por ControlSource direto a cursor_4c_GrdValores,
706:     * que nao repintam sozinhos ao trocar de linha no grid) e recalcula o
707:     * ToolTipText de Grupo/Conta/TitBans/CMoes. PUBLIC por exigencia do
708:     * BINDEVENT (regra CLAUDE.md #3); tambem chamado diretamente por
709:     * MontaGrade() apos a carga inicial.
710:     *--------------------------------------------------------------------------
711:     PROCEDURE AfterRowColChange(par_nColIndex)
712:         LOCAL loc_oErro
713: 
714:         TRY
715:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
716:                 THIS.txt_4c_GrupoEDs.Refresh()
717:                 THIS.txt_4c_ContaEDs.Refresh()
718:                 THIS.txt_4c_GrupoECs.Refresh()
719:                 THIS.txt_4c_ContaECs.Refresh()
720:                 THIS.txt_4c_GrupoPDs.Refresh()

*-- Linhas 818 a 836:
818:             loc_cValor = LEFT(ALLTRIM(TRANSFORM(loc_oTxt.Value)), 12)
819: 
820:             IF !EMPTY(loc_cValor) AND THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
821:                 SELECT crLstTitBc
822:                 GO TOP IN crLstTitBc
823:                 LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == UPPER(loc_cValor)
824:                 IF !EOF("crLstTitBc")
825:                     loc_oTxt.ToolTipText = ALLTRIM(TratarNulo(crLstTitBc.Descrs, ""))
826:                 ENDIF
827:             ENDIF
828:         ENDIF
829:     ENDPROC
830: 
831:     *--------------------------------------------------------------------------
832:     * AtualizarTooltipMoeda - ToolTipText da Moeda de Conversao. Legado:
833:     * "Seek(Padr(Value,3), [crLstMoeda], [Codigos])" - tabela real SigCdMoe
834:     * (cmoes/dmoes), ja usada por AbrirLookupMoedaExec.
835:     *--------------------------------------------------------------------------
836:     PROTECTED PROCEDURE AtualizarTooltipMoeda()

*-- Linhas 851 a 887:
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------
854:     * ObterDescricaoPorCodigo - SELECT TOP 1 pontual para ToolTipText (nao ha
855:     * cursor local cacheado para Grupo/Conta/Moeda, como havia no legado via
856:     * fSigOpFin_Tabs). Sem conexao (modo de teste/validacao de UI) devolve
857:     * "" em silencio - o ToolTipText fica no default "Campo Em Branco".
858:     *--------------------------------------------------------------------------
859:     PROTECTED FUNCTION ObterDescricaoPorCodigo(par_cTabela, par_cCampoCod, par_cCampoDesc, par_cValor)
860:         LOCAL loc_cDescricao, loc_cSQL, loc_nResultado, loc_cCursorTmp
861:         loc_cDescricao = ""
862:         loc_cCursorTmp = "cursor_4c_TooltipTmp"
863: 
864:         IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor)) ;
865:                 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 ;
866:                 AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
867:             THIS.FecharCursorTemporario(loc_cCursorTmp)
868: 
869:             loc_cSQL = "SELECT " + par_cCampoDesc + " FROM " + par_cTabela + ;
870:                 " WHERE " + par_cCampoCod + " = " + EscaparSQL(ALLTRIM(par_cValor))
871: 
872:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)
873: 
874:             IF loc_nResultado > 0 AND USED(loc_cCursorTmp) AND RECCOUNT(loc_cCursorTmp) > 0
875:                 loc_cDescricao = ALLTRIM(TratarNulo( ;
876:                     EVALUATE(loc_cCursorTmp + "." + par_cCampoDesc), ""))
877:             ENDIF
878: 
879:             THIS.FecharCursorTemporario(loc_cCursorTmp)
880:         ENDIF
881: 
882:         RETURN loc_cDescricao
883:     ENDFUNC
884: 
885: 
886:     *--------------------------------------------------------------------------
887:     * ConfigurarCamposGrupoContaEmissorPortador - campos de detalhe da linha

*-- Linhas 894 a 914:
894:     * Say8 (Grupo/Conta), que no dump aparecem uma UNICA vez, acima das 4
895:     * linhas - por isso entram aqui e nao se repetem na Parte 2.
896:     *
897:     * Cada TextBox e ligado via ControlSource direto a
898:     * cursor_4c_GrdValores.<Campo> (mesmo padrao do montagrades legado -
899:     * ThisForm.getGrupoEDs.ControlSource = [crGrdValores.GrupoEDs] - dump em
900:     * comportamento.json, metodo "SIGOPFIN.Procedure"): como o TextBox fica
901:     * FORA do grid mas ligado ao MESMO alias, ele reflete e edita a mesma
902:     * linha corrente que o grid exibe (mestre-detalhe por cursor compartilhado,
903:     * nao FormParaBO/BOParaForm). O religamento e repetido em MontaGrade()
904:     * (ver comentario la) para o caso de o cursor ser recriado.
905:     *
906:     * Nomes de objeto: o mapeamento.json colide "txt_4c_Grupo" para TODOS os
907:     * getGrupo<X><D|C>s (06 controles diferentes gerando o mesmo nome) -
908:     * usar esse nome causaria "object already exists" a cada AddObject
909:     * seguinte. Usa-se aqui o nome com o sufixo completo do legado
910:     * (txt_4c_GrupoEDs, txt_4c_ContaEDs, ...), unico por controle.
911:     *
912:     * MaxLength = 11 vem do schema (grupoeds/contaeds/... char(11) - ver
913:     * comentarios de sigopfinBO.prg), nao do Width em pixels (regra #19).
914:     *--------------------------------------------------------------------------

*-- Linhas 1062 a 1180:
1062:                 .Height        = 23
1063:                 .MaxLength     = 11
1064:                 .TabIndex      = 5
1065:                 .ControlSource = "cursor_4c_GrdValores.GrupoEDs"
1066:                 .Visible       = .T.
1067:             ENDWITH
1068: 
1069:             THIS.AddObject("txt_4c_ContaEDs", "TextBox")
1070:             WITH THIS.txt_4c_ContaEDs
1071:                 .FontName      = "Tahoma"
1072:                 .FontSize      = 8
1073:                 .Top           = 488
1074:                 .Left          = 220
1075:                 .Width         = 77
1076:                 .Height        = 23
1077:                 .MaxLength     = 11
1078:                 .TabIndex      = 6
1079:                 .ControlSource = "cursor_4c_GrdValores.ContaEDs"
1080:                 .Visible       = .T.
1081:             ENDWITH
1082: 
1083:             THIS.AddObject("txt_4c_GrupoECs", "TextBox")
1084:             WITH THIS.txt_4c_GrupoECs
1085:                 .FontName      = "Tahoma"
1086:                 .FontSize      = 8
1087:                 .Top           = 488
1088:                 .Left          = 310
1089:                 .Width         = 77
1090:                 .Height        = 23
1091:                 .MaxLength     = 11
1092:                 .TabIndex      = 7
1093:                 .ControlSource = "cursor_4c_GrdValores.GrupoECs"
1094:                 .Visible       = .T.
1095:             ENDWITH
1096: 
1097:             THIS.AddObject("txt_4c_ContaECs", "TextBox")
1098:             WITH THIS.txt_4c_ContaECs
1099:                 .FontName      = "Tahoma"
1100:                 .FontSize      = 8
1101:                 .Top           = 488
1102:                 .Left          = 391
1103:                 .Width         = 77
1104:                 .Height        = 23
1105:                 .MaxLength     = 11
1106:                 .TabIndex      = 8
1107:                 .ControlSource = "cursor_4c_GrdValores.ContaECs"
1108:                 .Visible       = .T.
1109:             ENDWITH
1110: 
1111:             *-- Linha Portador (dump: getGrupoPDs/getContaPDs/getGrupoPCs/
1112:             *-- getContaPCs, Top=513).
1113:             THIS.AddObject("txt_4c_GrupoPDs", "TextBox")
1114:             WITH THIS.txt_4c_GrupoPDs
1115:                 .FontName      = "Tahoma"
1116:                 .FontSize      = 8
1117:                 .Top           = 513
1118:                 .Left          = 139
1119:                 .Width         = 77
1120:                 .Height        = 23
1121:                 .MaxLength     = 11
1122:                 .TabIndex      = 9
1123:                 .ControlSource = "cursor_4c_GrdValores.GrupoPDs"
1124:                 .Visible       = .T.
1125:             ENDWITH
1126: 
1127:             THIS.AddObject("txt_4c_ContaPDs", "TextBox")
1128:             WITH THIS.txt_4c_ContaPDs
1129:                 .FontName      = "Tahoma"
1130:                 .FontSize      = 8
1131:                 .Top           = 513
1132:                 .Left          = 220
1133:                 .Width         = 77
1134:                 .Height        = 23
1135:                 .MaxLength     = 11
1136:                 .TabIndex      = 10
1137:                 .ControlSource = "cursor_4c_GrdValores.ContaPDs"
1138:                 .Visible       = .T.
1139:             ENDWITH
1140: 
1141:             THIS.AddObject("txt_4c_GrupoPCs", "TextBox")
1142:             WITH THIS.txt_4c_GrupoPCs
1143:                 .FontName      = "Tahoma"
1144:                 .FontSize      = 8
1145:                 .Top           = 513
1146:                 .Left          = 310
1147:                 .Width         = 77
1148:                 .Height        = 23
1149:                 .MaxLength     = 11
1150:                 .TabIndex      = 11
1151:                 .ControlSource = "cursor_4c_GrdValores.GrupoPCs"
1152:                 .Visible       = .T.
1153:             ENDWITH
1154: 
1155:             THIS.AddObject("txt_4c_ContaPCs", "TextBox")
1156:             WITH THIS.txt_4c_ContaPCs
1157:                 .FontName      = "Tahoma"
1158:                 .FontSize      = 8
1159:                 .Top           = 513
1160:                 .Left          = 391
1161:                 .Width         = 77
1162:                 .Height        = 23
1163:                 .MaxLength     = 11
1164:                 .TabIndex      = 12
1165:                 .ControlSource = "cursor_4c_GrdValores.ContaPCs"
1166:                 .Visible       = .T.
1167:             ENDWITH
1168:         CATCH TO loc_oErro
1169:             MsgErro(loc_oErro.Message + CHR(13) + ;
1170:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1171:                 "Procedure: " + loc_oErro.Procedure, ;
1172:                 "Erro em ConfigurarCamposGrupoContaEmissorPortador")
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * ConfigurarCamposCentroCustoAgenteCobrador - parte 2 (complementar a
1178:     * Fase 5) dos campos de detalhe da linha corrente da grade: linhas Centro de
1179:     * Custo (getGrupoCDs/getContaCDs/getGrupoCCs/getContaCCs, dump Top=538) e
1180:     * Agente Cobrador (getGrupoADs/getContaADs/getGrupoACs/getContaACs, dump

*-- Linhas 1233 a 1351:
1233:                 .Height        = 23
1234:                 .MaxLength     = 11
1235:                 .TabIndex      = 13
1236:                 .ControlSource = "cursor_4c_GrdValores.GrupoCDs"
1237:                 .Visible       = .T.
1238:             ENDWITH
1239: 
1240:             THIS.AddObject("txt_4c_ContaCDs", "TextBox")
1241:             WITH THIS.txt_4c_ContaCDs
1242:                 .FontName      = "Tahoma"
1243:                 .FontSize      = 8
1244:                 .Top           = 538
1245:                 .Left          = 220
1246:                 .Width         = 77
1247:                 .Height        = 23
1248:                 .MaxLength     = 11
1249:                 .TabIndex      = 14
1250:                 .ControlSource = "cursor_4c_GrdValores.ContaCDs"
1251:                 .Visible       = .T.
1252:             ENDWITH
1253: 
1254:             THIS.AddObject("txt_4c_GrupoCCs", "TextBox")
1255:             WITH THIS.txt_4c_GrupoCCs
1256:                 .FontName      = "Tahoma"
1257:                 .FontSize      = 8
1258:                 .Top           = 538
1259:                 .Left          = 310
1260:                 .Width         = 77
1261:                 .Height        = 23
1262:                 .MaxLength     = 11
1263:                 .TabIndex      = 15
1264:                 .ControlSource = "cursor_4c_GrdValores.GrupoCCs"
1265:                 .Visible       = .T.
1266:             ENDWITH
1267: 
1268:             THIS.AddObject("txt_4c_ContaCCs", "TextBox")
1269:             WITH THIS.txt_4c_ContaCCs
1270:                 .FontName      = "Tahoma"
1271:                 .FontSize      = 8
1272:                 .Top           = 538
1273:                 .Left          = 391
1274:                 .Width         = 77
1275:                 .Height        = 23
1276:                 .MaxLength     = 11
1277:                 .TabIndex      = 16
1278:                 .ControlSource = "cursor_4c_GrdValores.ContaCCs"
1279:                 .Visible       = .T.
1280:             ENDWITH
1281: 
1282:             *-- Linha Agente Cobrador (dump: getGrupoADs/getContaADs/
1283:             *-- getGrupoACs/getContaACs, Top=563).
1284:             THIS.AddObject("txt_4c_GrupoADs", "TextBox")
1285:             WITH THIS.txt_4c_GrupoADs
1286:                 .FontName      = "Tahoma"
1287:                 .FontSize      = 8
1288:                 .Top           = 563
1289:                 .Left          = 139
1290:                 .Width         = 77
1291:                 .Height        = 23
1292:                 .MaxLength     = 11
1293:                 .TabIndex      = 17
1294:                 .ControlSource = "cursor_4c_GrdValores.GrupoADs"
1295:                 .Visible       = .T.
1296:             ENDWITH
1297: 
1298:             THIS.AddObject("txt_4c_ContaADs", "TextBox")
1299:             WITH THIS.txt_4c_ContaADs
1300:                 .FontName      = "Tahoma"
1301:                 .FontSize      = 8
1302:                 .Top           = 563
1303:                 .Left          = 220
1304:                 .Width         = 77
1305:                 .Height        = 23
1306:                 .MaxLength     = 11
1307:                 .TabIndex      = 18
1308:                 .ControlSource = "cursor_4c_GrdValores.ContaADs"
1309:                 .Visible       = .T.
1310:             ENDWITH
1311: 
1312:             THIS.AddObject("txt_4c_GrupoACs", "TextBox")
1313:             WITH THIS.txt_4c_GrupoACs
1314:                 .FontName      = "Tahoma"
1315:                 .FontSize      = 8
1316:                 .Top           = 563
1317:                 .Left          = 310
1318:                 .Width         = 77
1319:                 .Height        = 23
1320:                 .MaxLength     = 11
1321:                 .TabIndex      = 19
1322:                 .ControlSource = "cursor_4c_GrdValores.GrupoACs"
1323:                 .Visible       = .T.
1324:             ENDWITH
1325: 
1326:             THIS.AddObject("txt_4c_ContaACs", "TextBox")
1327:             WITH THIS.txt_4c_ContaACs
1328:                 .FontName      = "Tahoma"
1329:                 .FontSize      = 8
1330:                 .Top           = 563
1331:                 .Left          = 391
1332:                 .Width         = 77
1333:                 .Height        = 23
1334:                 .MaxLength     = 11
1335:                 .TabIndex      = 20
1336:                 .ControlSource = "cursor_4c_GrdValores.ContaACs"
1337:                 .Visible       = .T.
1338:             ENDWITH
1339:         CATCH TO loc_oErro
1340:             MsgErro(loc_oErro.Message + CHR(13) + ;
1341:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1342:                 "Procedure: " + loc_oErro.Procedure, ;
1343:                 "Erro em ConfigurarCamposCentroCustoAgenteCobrador")
1344:         ENDTRY
1345:     ENDPROC
1346: 
1347:     *--------------------------------------------------------------------------
1348:     * ConfigurarCamposComplementares - os 4 campos restantes da coluna
1349:     * direita do dump (txt_4c_CMoes/TitBans/Tipos/MovTits, equivalentes a
1350:     * getCMoes/getTitBans/getTipos/getMovTits), com o mesmo padrao de
1351:     * ligacao direta a cursor_4c_GrdValores.<Campo> dos demais campos de

*-- Linhas 1398 a 1416:
1398:                 .Height        = 23
1399:                 .MaxLength     = 3
1400:                 .TabIndex      = 21
1401:                 .ControlSource = "cursor_4c_GrdValores.Moedas"
1402:                 .Visible       = .T.
1403:             ENDWITH
1404: 
1405:             THIS.AddObject("lbl_4c_Label13", "Label")
1406:             WITH THIS.lbl_4c_Label13
1407:                 .FontName  = "Tahoma"
1408:                 .FontSize  = 8
1409:                 .BackStyle = 0
1410:                 .Alignment = 0
1411:                 .AutoSize  = .F.
1412:                 .Top       = 355
1413:                 .Left      = 744
1414:                 .Width     = 57
1415:                 .Height    = 17
1416:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1444 a 1476:
1444:                 .Height        = 23
1445:                 .MaxLength     = 12
1446:                 .TabIndex      = 22
1447:                 .ControlSource = "cursor_4c_GrdValores.TitBans"
1448:                 .Visible       = .T.
1449:             ENDWITH
1450: 
1451:             THIS.AddObject("txt_4c_Tipos", "TextBox")
1452:             WITH THIS.txt_4c_Tipos
1453:                 .FontName      = "Tahoma"
1454:                 .FontSize      = 8
1455:                 .Top           = 370
1456:                 .Left          = 853
1457:                 .Width         = 17
1458:                 .Height        = 23
1459:                 .MaxLength     = 1
1460:                 .TabIndex      = 23
1461:                 .ControlSource = "cursor_4c_GrdValores.Tipos"
1462:                 .Visible       = .T.
1463:             ENDWITH
1464: 
1465:             THIS.AddObject("lbl_4c_Label17", "Label")
1466:             WITH THIS.lbl_4c_Label17
1467:                 .FontName  = "Tahoma"
1468:                 .FontSize  = 8
1469:                 .BackStyle = 0
1470:                 .Alignment = 0
1471:                 .AutoSize  = .F.
1472:                 .Top       = 404
1473:                 .Left      = 744
1474:                 .Width     = 144
1475:                 .Height    = 17
1476:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1488 a 1528:
1488:                 .Height        = 23
1489:                 .MaxLength     = 20
1490:                 .TabIndex      = 24
1491:                 .ControlSource = "cursor_4c_GrdValores.MovTits"
1492:                 .Visible       = .T.
1493:             ENDWITH
1494:         CATCH TO loc_oErro
1495:             MsgErro(loc_oErro.Message + CHR(13) + ;
1496:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1497:                 "Procedure: " + loc_oErro.Procedure, ;
1498:                 "Erro em ConfigurarCamposComplementares")
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *--------------------------------------------------------------------------
1503:     * ConfigurarMemosEcheckboxes - obj_4c_GetNotas/obj_4c_GetComandos
1504:     * (EditBox memo, equivalentes a getNotas/getComandos, ligados a
1505:     * cursor_4c_GrdValores.Notas/Comandos no mesmo padrao mestre-detalhe dos
1506:     * demais campos de linha) e os 2 CheckBox do bloco "Inibir Lancamentos
1507:     * de:" (chk_4c_Chk_P1_CMVS/chk_4c_Chk_P2_MOBS).
1508:     *
1509:     * chk_P1_CMVS/chk_P2_MOBS NAO tem ControlSource no dump (layout.json so
1510:     * declara Value="0" literal) e NAO ha coluna correspondente nem em
1511:     * SigOpFin (CREATE CURSOR crGrdValores do legado nao as lista) nem em
1512:     * SigOpOpe (conferido no schema.sql - nenhuma coluna *cmv*/*mob*
1513:     * corresponde) - ficam como estado de tela, sem ControlSource inventado
1514:     * (regra "NUNCA inventar tabela/coluna de lookup"). O GotFocus/LostFocus
1515:     * de dirty-tracking (This.Tag <-> This.Value, que so seta
1516:     * this_lAlterou) fica para a Fase 7, junto com os demais BINDEVENT.
1517:     *--------------------------------------------------------------------------
1518:     PROTECTED PROCEDURE ConfigurarMemosEcheckboxes()
1519:         LOCAL loc_oErro
1520: 
1521:         TRY
1522:             THIS.AddObject("lbl_4c_Label1", "Label")
1523:             WITH THIS.lbl_4c_Label1
1524:                 .FontName  = "Tahoma"
1525:                 .FontSize  = 8
1526:                 .BackStyle = 0
1527:                 .Alignment = 0
1528:                 .AutoSize  = .F.

*-- Linhas 1547 a 1565:
1547:                 .Height        = 131
1548:                 .ScrollBars    = 2
1549:                 .TabIndex      = 25
1550:                 .ControlSource = "cursor_4c_GrdValores.Notas"
1551:                 .Visible       = .T.
1552:             ENDWITH
1553: 
1554:             THIS.AddObject("lbl_4c_Label2", "Label")
1555:             WITH THIS.lbl_4c_Label2
1556:                 .FontName  = "Tahoma"
1557:                 .FontSize  = 8
1558:                 .BackStyle = 0
1559:                 .Alignment = 0
1560:                 .AutoSize  = .F.
1561:                 .Top       = 455
1562:                 .Left      = 485
1563:                 .Width     = 157
1564:                 .Height    = 15
1565:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1577 a 1595:
1577:                 .Height        = 121
1578:                 .ScrollBars    = 2
1579:                 .TabIndex      = 26
1580:                 .ControlSource = "cursor_4c_GrdValores.Comandos"
1581:                 .Visible       = .T.
1582:             ENDWITH
1583: 
1584:             THIS.AddObject("chk_4c_Chk_P1_CMVS", "CheckBox")
1585:             WITH THIS.chk_4c_Chk_P1_CMVS
1586:                 .FontName  = "Tahoma"
1587:                 .FontSize  = 8
1588:                 .BackStyle = 0
1589:                 .Top       = 256
1590:                 .Left      = 744
1591:                 .Width     = 220
1592:                 .Height    = 17
1593:                 .ForeColor = RGB(90, 90, 90)
1594:                 .Caption   = "CMV de Grupos de Produtos"
1595:                 .Value     = 0

*-- Linhas 1901 a 1919:
1901:                         ENDIF
1902: 
1903:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1904:                             SELECT (loc_cCursor)
1905:                             IF !EOF(loc_cCursor)
1906:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1907:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.codigos, "")), 10) + " ", ;
1908:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaGrupo.descrs, "")))
1909:                             ENDIF
1910:                         ENDIF
1911: 
1912:                         loc_oBusca.Release()
1913:                     ENDIF
1914: 
1915:                     THIS.FecharCursorTemporario(loc_cCursor)
1916:                 ENDIF
1917:             ENDIF
1918:         CATCH TO loc_oErro
1919:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1972 a 1990:
1972:                         ENDIF
1973: 
1974:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1975:                             SELECT (loc_cCursor)
1976:                             IF !EOF(loc_cCursor)
1977:                                 THIS.AplicarValorLookup(loc_oTxt, ;
1978:                                     PADR(ALLTRIM(TratarNulo(cursor_4c_BuscaConta.iclis, "")), 10) + " ", ;
1979:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaConta.rclis, "")))
1980:                             ENDIF
1981:                         ENDIF
1982: 
1983:                         loc_oBusca.Release()
1984:                     ENDIF
1985: 
1986:                     THIS.FecharCursorTemporario(loc_cCursor)
1987:                 ENDIF
1988:             ENDIF
1989:         CATCH TO loc_oErro
1990:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 2037 a 2055:
2037:                         ENDIF
2038: 
2039:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2040:                             SELECT (loc_cCursor)
2041:                             IF !EOF(loc_cCursor)
2042:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2043:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.cmoes, "")), ;
2044:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMoeda.dmoes, "")))
2045:                             ENDIF
2046:                         ENDIF
2047: 
2048:                         loc_oBusca.Release()
2049:                     ENDIF
2050: 
2051:                     THIS.FecharCursorTemporario(loc_cCursor)
2052:                 ENDIF
2053:             ENDIF
2054:         CATCH TO loc_oErro
2055:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 2109 a 2127:
2109:                         ENDIF
2110: 
2111:                         IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
2112:                             SELECT (loc_cCursor)
2113:                             IF !EOF(loc_cCursor)
2114:                                 THIS.AplicarValorLookup(loc_oTxt, ;
2115:                                     ALLTRIM(TratarNulo(cursor_4c_BuscaMovTit.Dopes, "")), "")
2116:                             ENDIF
2117:                         ENDIF
2118: 
2119:                         loc_oBusca.Release()
2120:                     ENDIF
2121: 
2122:                     THIS.FecharCursorTemporario(loc_cCursor)
2123:                 ENDIF
2124:             ENDIF
2125:         CATCH TO loc_oErro
2126:             MsgErro(loc_oErro.Message + CHR(13) + ;
2127:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 2174 a 2192:
2174:                     IF THIS.ListaLocalDisponivel("crLstTitBc", "Codigos")
2175:                         *-- Legado: Seek(Padr(This.Value, 12), [crLstTitBc],
2176:                         *-- [Codigos]) - achando exato, nao abre o picker.
2177:                         SELECT crLstTitBc
2178:                         GO TOP IN crLstTitBc
2179:                         LOCATE FOR UPPER(ALLTRIM(crLstTitBc.Codigos)) == ;
2180:                             UPPER(ALLTRIM(LEFT(loc_cValor, 12)))
2181: 
2182:                         IF EOF("crLstTitBc")
2183:                             THIS.MostrarPickerListaLocal("crLstTitBc", ;
2184:                                 "Codigos", "Descrs", ;
2185:                                 "T" + CHR(237) + "tulo Banco")
2186:                         ENDIF
2187: 
2188:                         IF USED("crLstTitBc") AND !EOF("crLstTitBc")
2189:                             THIS.AplicarValorLookup(loc_oTxt, ;
2190:                                 ALLTRIM(TratarNulo(crLstTitBc.Codigos, "")), ;
2191:                                 ALLTRIM(TratarNulo(crLstTitBc.Descrs, "")))
2192:                         ENDIF

*-- Linhas 2257 a 2285:
2257:                     IF THIS.ListaLocalDisponivel("crTabOpFin", "Descrs")
2258:                         loc_lCancelou = .F.
2259: 
2260:                         SELECT crTabOpFin
2261:                         GO TOP IN crTabOpFin
2262:                         LOCATE FOR UPPER(ALLTRIM(crTabOpFin.Descrs)) == ;
2263:                             UPPER(ALLTRIM(LEFT(loc_cValor, 100)))
2264: 
2265:                         IF EOF("crTabOpFin")
2266:                             loc_lCancelou = !THIS.MostrarPickerListaLocal( ;
2267:                                 "crTabOpFin", "Descrs", "Codigos", "Descritivos")
2268:                         ENDIF
2269: 
2270:                         SELECT cursor_4c_GrdValores
2271:                         IF loc_lCancelou OR !USED("crTabOpFin") OR EOF("crTabOpFin")
2272:                             *-- Legado: "If (LastKey() = 27) Replace Codigos
2273:                             *-- With [], Descrs With []".
2274:                             REPLACE Codigos WITH "", ;
2275:                                     Descrs  WITH "" IN cursor_4c_GrdValores
2276:                             par_oTxt.Value = ""
2277:                         ELSE
2278:                             REPLACE Codigos WITH ALLTRIM(TratarNulo(crTabOpFin.Codigos, "")), ;
2279:                                     Descrs  WITH ALLTRIM(TratarNulo(crTabOpFin.Descrs,  "")) ;
2280:                                 IN cursor_4c_GrdValores
2281:                             par_oTxt.Value = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2282:                         ENDIF
2283: 
2284:                         par_oTxt.Tag       = ALLTRIM(TRANSFORM(par_oTxt.Value))
2285:                         THIS.this_lAlterou = .T.

*-- Linhas 2345 a 2363:
2345:     * ToolTipText (o legado faz This.Value = ... / This.ToolTipText = Descrs),
2346:     * marcando a tela como alterada (plAlterou do legado).
2347:     *
2348:     * Todos esses TextBox tem ControlSource em cursor_4c_GrdValores: atribuir
2349:     * .Value grava na linha corrente do cursor, que e exatamente o que o
2350:     * legado faz. Sem linha corrente nao ha onde gravar - dai a guarda.
2351:     *--------------------------------------------------------------------------
2352:     PROTECTED PROCEDURE AplicarValorLookup(par_oTxt, par_cValor, par_cDescricao)
2353:         IF VARTYPE(par_oTxt) = "O" AND USED("cursor_4c_GrdValores") ;
2354:                 AND !EOF("cursor_4c_GrdValores")
2355:             par_oTxt.Value = par_cValor
2356: 
2357:             IF VARTYPE(par_cDescricao) = "C" AND !EMPTY(par_cDescricao)
2358:                 par_oTxt.ToolTipText = par_cDescricao
2359:             ENDIF
2360: 
2361:             par_oTxt.Refresh()
2362:             THIS.this_lAlterou = .T.
2363:         ENDIF

*-- Linhas 2369 a 2387:
2369:     *
2370:     * Conferir a COLUNA (e nao so USED()) evita abrir o picker sobre um alias
2371:     * homonimo de outra tela com estrutura diferente, caso em que o
2372:     * ControlSource da grade do picker estouraria em runtime. TYPE() e usado
2373:     * no lugar de PEMSTATUS porque PEMSTATUS exige OBJETO no 1o argumento -
2374:     * com nome de cursor ele dispara o erro 11 do VFP9.
2375:     *--------------------------------------------------------------------------
2376:     PROTECTED FUNCTION ListaLocalDisponivel(par_cCursor, par_cCampo)
2377:         LOCAL loc_lOk
2378:         loc_lOk = .F.
2379: 
2380:         IF USED(par_cCursor)
2381:             IF TYPE(par_cCursor + "." + par_cCampo) != "U" ;
2382:                     AND RECCOUNT(par_cCursor) > 0
2383:                 loc_lOk = .T.
2384:             ENDIF
2385:         ENDIF
2386: 
2387:         RETURN loc_lOk

*-- Linhas 2393 a 2411:
2393:     *
2394:     * Usa a API manual do FormBuscaAuxiliar (CREATEOBJECT sem parametros +
2395:     * mAddColuna + Show) porque o cursor NAO vem de SQL: o Init com parametros
2396:     * dispararia um SELECT contra o SQL Server, que e o oposto do que o legado
2397:     * faz aqui. O cursor ja estar populado e pre-requisito - sem isso o
2398:     * ConfigurarGrid do picker retorna cedo e o dialogo abriria vazio; por
2399:     * isso o chamador sempre passa por ListaLocalDisponivel() antes.
2400:     *
2401:     * Devolve .T. quando o usuario selecionou. Ao selecionar, o ponteiro do
2402:     * cursor fica na linha escolhida (o grid do picker o posiciona), que e
2403:     * como o legado le o registro depois do Show.
2404:     *--------------------------------------------------------------------------
2405:     PROTECTED FUNCTION MostrarPickerListaLocal(par_cCursor, par_cCampoCod, ;
2406:             par_cCampoDesc, par_cTitulo)
2407:         LOCAL loc_oBusca, loc_lSelecionou
2408:         loc_lSelecionou = .F.
2409: 
2410:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2411: 

*-- Linhas 2472 a 2617:
2472:     *
2473:     * Equivalente ao trecho do Init legado (dump de
2474:     * sigopfin_form_codigo_fonte.txt, linhas 1483-1523):
2475:     *   =fSigOpFin_Cria()                        -> SELECT ... FROM sigopfin
2476:     *   Scan crSigOpFin / Scatter / Insert       -> DO WHILE sobre o cursor temp
2477:     *   Insert Into crGrdValores (Ordem) Values  -> linha em branco do fim
2478:     *   .MontaGrades()                           -> THIS.MontaGrade()
2479:     *
2480:     * fSigOpFin_Cria()/fSigOpFin_Tabs() vivem no SigOpFin.prg legado, que NAO
2481:     * veio no acervo; o que elas faziam de fato (abrir as linhas de sigopfin da
2482:     * movimentacao) esta reproduzido aqui com SQL direto sobre a tabela. O
2483:     * legado le crSigOpFin, cursor que o form PAI (cadastro de Operacoes) cria
2484:     * - aqui a consulta e propria, para o dialogo nao depender de cursor de
2485:     * terceiro.
2486:     *
2487:     * O SQLEXEC vai para um cursor TEMPORARIO: SQLEXEC sobre o alias ligado ao
2488:     * Grid fecha e recria o alias, zerando ColumnCount e deixando a grade um
2489:     * retangulo branco sem cabecalho. O alias da grade e recarregado com
2490:     * ZAP + insercao linha a linha, que preserva estrutura e binding.
2491:     *--------------------------------------------------------------------------
2492:     PROCEDURE CarregarDados()
2493:         LOCAL loc_lSucesso, loc_lProsseguir, loc_cSQL, loc_nResultado
2494:         LOCAL loc_nOrdem, loc_oErro
2495:         loc_lSucesso    = .F.
2496:         loc_lProsseguir = .T.
2497: 
2498:         TRY
2499:             THIS.CriarCursorGrdValores()
2500: 
2501:             IF !USED("cursor_4c_GrdValores")
2502:                 MsgErro("Cursor da grade n" + CHR(227) + "o foi criado.", ;
2503:                     "Erro em CarregarDados")
2504:                 loc_lProsseguir = .F.
2505:             ENDIF
2506: 
2507:             IF loc_lProsseguir
2508:                 SELECT cursor_4c_GrdValores
2509:                 ZAP
2510: 
2511:                 *-- Sem conexao (validacao de UI / modo de teste) a grade abre
2512:                 *-- vazia e o form continua funcionando - nao ha SQL a executar.
2513:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
2514:                         AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2515: 
2516:                     THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2517: 
2518:                     loc_cSQL = "SELECT codigos, dopes, ordem," + ;
2519:                                " moedas, tipos, titbans, movtits," + ;
2520:                                " notas, comandos," + ;
2521:                                " usuincs, datincs, usualts, datalts," + ;
2522:                                " grupoeds, contaeds, grupoecs, contaecs," + ;
2523:                                " grupopds, contapds, grupopcs, contapcs," + ;
2524:                                " grupocds, contacds, grupoccs, contaccs," + ;
2525:                                " grupoads, contaads, grupoacs, contaacs" + ;
2526:                                " FROM sigopfin" + ;
2527:                                " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
2528:                                " ORDER BY ordem"
2529: 
2530:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, ;
2531:                         "cursor_4c_GrdValoresTmp")
2532: 
2533:                     IF loc_nResultado < 0
2534:                         MsgErro("Erro ao carregar as configura" + CHR(231) + ;
2535:                             CHR(245) + "es de lan" + CHR(231) + "amento da " + ;
2536:                             "movimenta" + CHR(231) + CHR(227) + "o " + ;
2537:                             ALLTRIM(THIS.this_cDopes) + ":" + CHR(13) + ;
2538:                             CapturarErroSQL(), "Erro SQL")
2539:                         loc_lProsseguir = .F.
2540:                     ENDIF
2541:                 ENDIF
2542:             ENDIF
2543: 
2544:             IF loc_lProsseguir
2545:                 loc_nOrdem = 0
2546: 
2547:                 IF USED("cursor_4c_GrdValoresTmp")
2548:                     SELECT cursor_4c_GrdValoresTmp
2549:                     GO TOP
2550:                     DO WHILE !EOF("cursor_4c_GrdValoresTmp")
2551:                         loc_nOrdem = loc_nOrdem + 1
2552:                         THIS.InserirLinhaGrade(loc_nOrdem)
2553:                         SELECT cursor_4c_GrdValoresTmp
2554:                         SKIP
2555:                     ENDDO
2556:                 ENDIF
2557: 
2558:                 *-- Linha em branco do fim, so em modo de edicao - legado:
2559:                 *--   If InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
2560:                 *--       Insert Into crGrdValores (Ordem) Values (lnOrd)
2561:                 *-- Apenas Ordem e preenchida: Dopes/cIdChaves/UsuIncs sao
2562:                 *-- atribuidos na gravacao (gravardados legado, Fase 8).
2563:                 IF THIS.EmModoEdicao()
2564:                     loc_nOrdem = loc_nOrdem + 1
2565:                     INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nOrdem)
2566:                 ENDIF
2567: 
2568:                 THIS.FecharCursorTemporario("cursor_4c_GrdValoresTmp")
2569: 
2570:                 THIS.MontaGrade()
2571: 
2572:                 loc_lSucesso = .T.
2573:             ENDIF
2574:         CATCH TO loc_oErro
2575:             MsgErro(loc_oErro.Message + CHR(13) + ;
2576:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2577:                 "Procedure: " + loc_oErro.Procedure, ;
2578:                 "Erro em Formsigopfin.CarregarDados")
2579:         ENDTRY
2580: 
2581:         RETURN loc_lSucesso
2582:     ENDPROC
2583: 
2584:     *--------------------------------------------------------------------------
2585:     * InserirLinhaGrade - acrescenta a cursor_4c_GrdValores a linha corrente de
2586:     * cursor_4c_GrdValoresTmp, renumerando Ordem sequencialmente (par_nOrdem) e
2587:     * resolvendo a descricao da origem. Equivale ao corpo do Scan legado
2588:     * (Scatter Memvar Memo / m.Ordem / m.Descrs / Insert From Memvar).
2589:     *
2590:     * As colunas sao referenciadas com o alias explicito para a insercao nao
2591:     * depender da area de trabalho corrente. Descrs NAO existe na tabela
2592:     * sigopfin (so no cursor da grade) - vem da descricao da origem.
2593:     * DatIncs/DatAlts usam CTOT("") como default, igual ao Nvl(..., Ctot([]))
2594:     * do legado: campo T nao aceita o {} de um DATE vazio.
2595:     *--------------------------------------------------------------------------
2596:     PROTECTED PROCEDURE InserirLinhaGrade(par_nOrdem)
2597:         LOCAL loc_cCodigos, loc_cDescrs
2598: 
2599:         loc_cCodigos = TratarNulo(cursor_4c_GrdValoresTmp.codigos, "")
2600:         loc_cDescrs  = LEFT(THIS.ObterDescricaoOrigem(loc_cCodigos), 100)
2601: 
2602:         INSERT INTO cursor_4c_GrdValores ;
2603:             (Ordem,    Codigos,  Descrs,   Dopes, ;
2604:              Notas,    Comandos, Moedas,   Tipos,    TitBans, ;
2605:              UsuIncs,  MovTits,  DatIncs,  UsuAlts,  DatAlts, ;
2606:              GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
2607:              GrupoPDs, ContaPDs, GrupoPCs, ContaPCs, ;
2608:              GrupoCDs, ContaCDs, GrupoCCs, ContaCCs, ;
2609:              GrupoADs, ContaADs, GrupoACs, ContaACs) ;
2610:             VALUES ;
2611:             (par_nOrdem, ;
2612:              loc_cCodigos, ;
2613:              loc_cDescrs, ;
2614:              TratarNulo(cursor_4c_GrdValoresTmp.dopes,    ""), ;
2615:              TratarNulo(cursor_4c_GrdValoresTmp.notas,    ""), ;
2616:              TratarNulo(cursor_4c_GrdValoresTmp.comandos, ""), ;
2617:              TratarNulo(cursor_4c_GrdValoresTmp.moedas,   ""), ;

*-- Linhas 2663 a 2740:
2663:                 loc_cAliasAnterior = ALIAS()
2664:                 loc_nRegAnterior   = RECNO("crTabOpFin")
2665: 
2666:                 SELECT crTabOpFin
2667:                 LOCATE FOR ALLTRIM(crTabOpFin.Codigos) == ALLTRIM(par_cCodigo)
2668:                 IF !EOF("crTabOpFin")
2669:                     loc_cDescricao = ALLTRIM(TratarNulo(crTabOpFin.Descrs, ""))
2670:                 ENDIF
2671: 
2672:                 IF BETWEEN(loc_nRegAnterior, 1, RECCOUNT("crTabOpFin"))
2673:                     GO loc_nRegAnterior IN crTabOpFin
2674:                 ENDIF
2675:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
2676:                     SELECT (loc_cAliasAnterior)
2677:                 ENDIF
2678:             ENDIF
2679: 
2680:             IF EMPTY(loc_cDescricao)
2681:                 loc_cDescricao = ALLTRIM(par_cCodigo)
2682:             ENDIF
2683:         ENDIF
2684: 
2685:         RETURN loc_cDescricao
2686:     ENDFUNC
2687: 
2688:     *--------------------------------------------------------------------------
2689:     * MontaGrade - religa grd_4c_Dados a cursor_4c_GrdValores e repinta.
2690:     * Equivale ao montagrades legado (dump linhas 1417-1446).
2691:     *
2692:     * Metodo UNICO de repintura: todo caminho que popula, reordena ou exclui
2693:     * linha do cursor termina aqui. Popular o cursor NAO repinta a grade
2694:     * sozinho - o legado tambem fecha com Go Top + Refresh; sem isso a grade
2695:     * fica visualmente vazia com o cursor cheio.
2696:     *
2697:     * A ordem das atribuicoes e a canonica (ColumnCount -> RecordSource ->
2698:     * ControlSource -> Width -> Header1.Caption): RecordSource recalcula as
2699:     * larguras para o default 90 e apaga o caption, por isso os dois vem
2700:     * DEPOIS dele.
2701:     *
2702:     * O montagrades legado tambem religa os ControlSource dos campos de
2703:     * detalhe (getNotas/getComandos/getCMoes/getTitBans/getTipos/getMovTits e
2704:     * os 16 de Grupo/Conta) e chama AfterRowColChange - esses controles sao
2705:     * criados nas Fases 5 e 6, e o religamento deles entra NESTE metodo junto
2706:     * com eles.
2707:     *--------------------------------------------------------------------------
2708:     PROCEDURE MontaGrade()
2709:         LOCAL loc_oGrd, loc_oErro
2710: 
2711:         TRY
2712:             THIS.CriarCursorGrdValores()
2713: 
2714:             SELECT cursor_4c_GrdValores
2715:             SET ORDER TO TAG Ordem
2716:             GO TOP
2717: 
2718:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2719:                 loc_oGrd = THIS.grd_4c_Dados
2720: 
2721:                 WITH loc_oGrd
2722:                     .ColumnCount  = 1
2723:                     .RecordSource = "cursor_4c_GrdValores"
2724: 
2725:                     .Column1.ControlSource     = "cursor_4c_GrdValores.Descrs"
2726:                     .Column1.Width             = 700
2727:                     .Column1.FontName          = "Tahoma"
2728:                     .Column1.FontSize          = 8
2729:                     .Column1.Header1.Caption   = "Origem dos Valores a Serem Lan" + ;
2730:                         CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + ;
2731:                         "o Financeira"
2732:                     .Column1.Header1.Alignment = 2
2733:                     .Column1.Header1.FontBold  = .F.
2734: 
2735:                     .Refresh()
2736:                 ENDWITH
2737:             ENDIF
2738: 
2739:             *-- MontaGrade() reatribui ColumnCount, o que RECRIA os objetos
2740:             *-- Column e destroi o TextBox de lookup da celula - reinstalar

*-- Linhas 2750 a 2824:
2750:             *-- primeira passada (CarregarDados roda de novo depois, com
2751:             *-- os controles ja existindo).
2752:             IF PEMSTATUS(THIS, "txt_4c_GrupoEDs", 5)
2753:                 THIS.txt_4c_GrupoEDs.ControlSource = "cursor_4c_GrdValores.GrupoEDs"
2754:                 THIS.txt_4c_ContaEDs.ControlSource = "cursor_4c_GrdValores.ContaEDs"
2755:                 THIS.txt_4c_GrupoECs.ControlSource = "cursor_4c_GrdValores.GrupoECs"
2756:                 THIS.txt_4c_ContaECs.ControlSource = "cursor_4c_GrdValores.ContaECs"
2757:                 THIS.txt_4c_GrupoPDs.ControlSource = "cursor_4c_GrdValores.GrupoPDs"
2758:                 THIS.txt_4c_ContaPDs.ControlSource = "cursor_4c_GrdValores.ContaPDs"
2759:                 THIS.txt_4c_GrupoPCs.ControlSource = "cursor_4c_GrdValores.GrupoPCs"
2760:                 THIS.txt_4c_ContaPCs.ControlSource = "cursor_4c_GrdValores.ContaPCs"
2761:                 THIS.txt_4c_GrupoEDs.Refresh()
2762:                 THIS.txt_4c_ContaEDs.Refresh()
2763:                 THIS.txt_4c_GrupoECs.Refresh()
2764:                 THIS.txt_4c_ContaECs.Refresh()
2765:                 THIS.txt_4c_GrupoPDs.Refresh()
2766:                 THIS.txt_4c_ContaPDs.Refresh()
2767:                 THIS.txt_4c_GrupoPCs.Refresh()
2768:                 THIS.txt_4c_ContaPCs.Refresh()
2769:             ENDIF
2770: 
2771:             *-- Religamento dos campos de detalhe criados nesta Fase 6
2772:             *-- (Centro de Custo/Agente Cobrador - ConfigurarCamposCentro-
2773:             *-- CustoAgenteCobrador - e CMoes/TitBans/Tipos/MovTits/Notas/
2774:             *-- Comandos - ConfigurarCamposComplementares/
2775:             *-- ConfigurarMemosEcheckboxes). Mesmo guard por PEMSTATUS da
2776:             *-- Fase 5 parte 1, mesma razao.
2777:             IF PEMSTATUS(THIS, "txt_4c_GrupoCDs", 5)
2778:                 THIS.txt_4c_GrupoCDs.ControlSource = "cursor_4c_GrdValores.GrupoCDs"
2779:                 THIS.txt_4c_ContaCDs.ControlSource = "cursor_4c_GrdValores.ContaCDs"
2780:                 THIS.txt_4c_GrupoCCs.ControlSource = "cursor_4c_GrdValores.GrupoCCs"
2781:                 THIS.txt_4c_ContaCCs.ControlSource = "cursor_4c_GrdValores.ContaCCs"
2782:                 THIS.txt_4c_GrupoADs.ControlSource = "cursor_4c_GrdValores.GrupoADs"
2783:                 THIS.txt_4c_ContaADs.ControlSource = "cursor_4c_GrdValores.ContaADs"
2784:                 THIS.txt_4c_GrupoACs.ControlSource = "cursor_4c_GrdValores.GrupoACs"
2785:                 THIS.txt_4c_ContaACs.ControlSource = "cursor_4c_GrdValores.ContaACs"
2786:                 THIS.txt_4c_GrupoCDs.Refresh()
2787:                 THIS.txt_4c_ContaCDs.Refresh()
2788:                 THIS.txt_4c_GrupoCCs.Refresh()
2789:                 THIS.txt_4c_ContaCCs.Refresh()
2790:                 THIS.txt_4c_GrupoADs.Refresh()
2791:                 THIS.txt_4c_ContaADs.Refresh()
2792:                 THIS.txt_4c_GrupoACs.Refresh()
2793:                 THIS.txt_4c_ContaACs.Refresh()
2794:             ENDIF
2795: 
2796:             IF PEMSTATUS(THIS, "txt_4c_CMoes", 5)
2797:                 THIS.txt_4c_CMoes.ControlSource   = "cursor_4c_GrdValores.Moedas"
2798:                 THIS.txt_4c_TitBans.ControlSource = "cursor_4c_GrdValores.TitBans"
2799:                 THIS.txt_4c_Tipos.ControlSource    = "cursor_4c_GrdValores.Tipos"
2800:                 THIS.txt_4c_MovTits.ControlSource  = "cursor_4c_GrdValores.MovTits"
2801:                 THIS.txt_4c_CMoes.Refresh()
2802:                 THIS.txt_4c_TitBans.Refresh()
2803:                 THIS.txt_4c_Tipos.Refresh()
2804:                 THIS.txt_4c_MovTits.Refresh()
2805:             ENDIF
2806: 
2807:             IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
2808:                 THIS.obj_4c_GetNotas.ControlSource    = "cursor_4c_GrdValores.Notas"
2809:                 THIS.obj_4c_GetComandos.ControlSource = "cursor_4c_GrdValores.Comandos"
2810:                 THIS.obj_4c_GetNotas.Refresh()
2811:                 THIS.obj_4c_GetComandos.Refresh()
2812:             ENDIF
2813: 
2814:             *-- Legado: ".AfterRowColChange()" ao final do montagrades -
2815:             *-- recalcula os ToolTipText de Grupo/Conta/TitBans/CMoes para a
2816:             *-- linha corrente (Fase 7). Chamado por ultimo, com os campos ja
2817:             *-- religados acima.
2818:             THIS.AfterRowColChange()
2819:         CATCH TO loc_oErro
2820:             MsgErro(loc_oErro.Message + CHR(13) + ;
2821:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2822:                 "Procedure: " + loc_oErro.Procedure, ;
2823:                 "Erro em Formsigopfin.MontaGrade")
2824:         ENDTRY

*-- Linhas 2875 a 2893:
2875:     *--------------------------------------------------------------------------
2876:     * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
2877:     * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
2878:     * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
2879:     * dispara o erro 1586 "Function requires row or table buffering mode". Dai
2880:     * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo.
2881:     *--------------------------------------------------------------------------
2882:     PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
2883:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
2884:             IF CURSORGETPROP("Buffering", par_cAlias) > 1
2885:                 TABLEREVERT(.T., par_cAlias)
2886:             ENDIF
2887:             USE IN (par_cAlias)
2888:         ENDIF
2889:     ENDPROC
2890:     *--------------------------------------------------------------------------
2891:     * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
2892:     * padrao; percorre recursivamente Controls (containers/PageFrame) para
2893:     * garantir que tudo fique visivel apos a montagem.

*-- Linhas 2926 a 2958:
2926:             IF THIS.EmModoEdicao() AND USED("cursor_4c_GrdValores") ;
2927:                     AND LASTKEY() = 13 ;
2928:                     AND !EMPTY(cursor_4c_GrdValores.Codigos)
2929:                 SELECT cursor_4c_GrdValores
2930:                 SKIP
2931: 
2932:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2933:                     THIS.grd_4c_Dados.Refresh()
2934:                 ENDIF
2935: 
2936:                 IF EOF("cursor_4c_GrdValores")
2937:                     loc_nQtdeBranco = 0
2938:                     COUNT FOR EMPTY(Codigos) TO loc_nQtdeBranco
2939: 
2940:                     IF loc_nQtdeBranco = 0
2941:                         loc_nMaxOrdem = 0
2942:                         CALCULATE MAX(Ordem) TO loc_nMaxOrdem
2943:                         INSERT INTO cursor_4c_GrdValores (Ordem) VALUES (loc_nMaxOrdem + 1)
2944:                     ENDIF
2945: 
2946:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2947:                         THIS.grd_4c_Dados.Refresh()
2948:                     ENDIF
2949:                 ENDIF
2950: 
2951:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2952:                     THIS.grd_4c_Dados.Column1.SetFocus()
2953:                 ENDIF
2954:                 KEYBOARD "{DNARROW}"
2955:             ENDIF
2956:         CATCH TO loc_oErro
2957:             MsgErro(loc_oErro.Message + CHR(13) + ;
2958:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 3265 a 3363:
3265:     *       EndIf
3266:     *   EndIf
3267:     *   If llOks
3268:     *       Delete From crGrdValores Where Empty(Codigos) Or Empty(Descrs)
3269:     *       If ThisForm.GravarDados() / ThisForm.Release() / Else llOks=.f.
3270:     *   EndIf
3271:     *--------------------------------------------------------------------------
3272:     PROCEDURE BtnSairClick()
3273:         LOCAL loc_cMsg, loc_lOk, loc_oErro
3274:         loc_cMsg = ""
3275:         loc_lOk  = .T.
3276: 
3277:         TRY
3278:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3279:                 loc_cMsg = THIS.ValidarGradeValores()
3280:             ENDIF
3281: 
3282:             IF !EMPTY(loc_cMsg)
3283:                 IF MsgConfirma(loc_cMsg + CHR(13) + "Deseja Sair da Tela e " + ;
3284:                         "Abandonar Todos os Dados Alterados?", ;
3285:                         "Erro: Dados Inconsistentes")
3286:                     IF USED("cursor_4c_GrdValores")
3287:                         SELECT cursor_4c_GrdValores
3288:                         ZAP
3289:                     ENDIF
3290:                     THIS.this_lAlterou = .F.
3291:                     loc_lOk = .T.
3292:                 ELSE
3293:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
3294:                         THIS.grd_4c_Dados.Refresh()
3295:                         THIS.grd_4c_Dados.SetFocus()
3296:                     ENDIF
3297:                     THIS.AfterRowColChange()
3298:                     loc_lOk = .F.
3299:                 ENDIF
3300:             ENDIF
3301: 
3302:             IF loc_lOk
3303:                 IF USED("cursor_4c_GrdValores")
3304:                     DELETE FROM cursor_4c_GrdValores ;
3305:                         WHERE EMPTY(Codigos) OR EMPTY(Descrs)
3306:                 ENDIF
3307: 
3308:                 IF THIS.GravarDados()
3309:                     THIS.Release()
3310:                 ELSE
3311:                     loc_lOk = .F.
3312:                 ENDIF
3313:             ENDIF
3314:         CATCH TO loc_oErro
3315:             MsgErro(loc_oErro.Message + CHR(13) + ;
3316:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3317:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnSairClick")
3318:         ENDTRY
3319:     ENDPROC
3320: 
3321:     *--------------------------------------------------------------------------
3322:     * ValidarGradeValores - equivalente ao trecho de validacao do
3323:     * SIGOPFIN.Sair.Click legado: "Select * From crGrdValores Where Not
3324:     * Empty(Codigos) And Not Empty(Descrs) Into Cursor LocalSair" + "Scan
3325:     * While Empty(lcMsg)". Devolve a mensagem de inconsistencia (vazia se
3326:     * tudo estiver OK).
3327:     *
3328:     * Fidelidade a uma peculiaridade do legado: dentro de UMA linha, todos os
3329:     * IFs rodam em sequencia (nenhum e guardado por "Empty(lcMsg)" entre si),
3330:     * entao se MAIS DE UM campo da MESMA linha estiver vazio, loc_cMsg fica
3331:     * com o ULTIMO que bateu (nao o primeiro) - e so DEPOIS de terminar a
3332:     * linha inteira o "Scan While Empty(lcMsg)" para de avancar para a
3333:     * proxima. Por isso o EXIT fica no TOPO do corpo do SCAN, nao substitui o
3334:     * SCAN por "SCAN WHILE".
3335:     *--------------------------------------------------------------------------
3336:     PROTECTED FUNCTION ValidarGradeValores()
3337:         LOCAL loc_cMsg, loc_oErro
3338:         loc_cMsg = ""
3339: 
3340:         TRY
3341:             IF USED("cursor_4c_GrdValores")
3342:                 THIS.FecharCursorTemporario("cursor_4c_LocalSair")
3343: 
3344:                 SELECT * FROM cursor_4c_GrdValores ;
3345:                     WHERE !EMPTY(Codigos) AND !EMPTY(Descrs) ;
3346:                     INTO CURSOR cursor_4c_LocalSair READWRITE
3347: 
3348:                 SELECT cursor_4c_LocalSair
3349:                 GO TOP
3350:                 SCAN
3351:                     IF !EMPTY(loc_cMsg)
3352:                         EXIT
3353:                     ENDIF
3354: 
3355:                     IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_LocalSair.Notas, "")))
3356:                         loc_cMsg = "O Campo " + CHR(34) + "Notas Sobre a " + ;
3357:                             "Configura" + CHR(231) + CHR(227) + "o" + CHR(34) + ;
3358:                             " N" + CHR(227) + "o Foi Preenchido!!!" + CHR(13) + ;
3359:                             "Origem: " + ALLTRIM(cursor_4c_LocalSair.Descrs)
3360:                         IF PEMSTATUS(THIS, "obj_4c_GetNotas", 5)
3361:                             THIS.obj_4c_GetNotas.SetFocus()
3362:                         ENDIF
3363:                     ENDIF

*-- Linhas 3449 a 3505:
3449:     * fora do IF).
3450:     *
3451:     * Em ALTERAR, o legado apaga TODAS as linhas antigas de SigOpFin para
3452:     * este Dopes e reinsere TODAS as linhas validas da grade (delete-then-
3453:     * reinsert, nao um diff) - aqui reproduzido com DELETE via SQLEXEC +
3454:     * sigopfinBO.Inserir() por linha, renumerando Ordem sequencialmente.
3455:     *
3456:     * Desvio assumido (documentado, nao e regra de negocio visivel ao
3457:     * usuario): o legado preserva UsuIncs/DatIncs/UsuAlts/DatAlts das linhas
3458:     * pre-existentes no delete-then-reinsert (Iif(pcEscolha=INSERIR Or
3459:     * Empty(m.UsuIncs), Usuar, m.UsuIncs), e similar para os outros tres);
3460:     * sigopfinBO.Inserir() sempre estampa this_cUsuIncs=gc_4c_UsuarioLogado,
3461:     * datincs=GETDATE() e datalts=NULL (nao ha gancho para preservar os
3462:     * valores originais sem reescrever o BO), e this_cUsuAlts fica no
3463:     * default "" do BO (nenhuma linha reinserida e tratada como "alterada"
3464:     * por este fluxo). O rastro de quem/quando INCLUIU de fato fica no
3465:     * LogAuditoria via RegistrarAuditoria(), chamado dentro do proprio
3466:     * Inserir().
3467:     *--------------------------------------------------------------------------
3468:     PROTECTED FUNCTION GravarDados()
3469:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nOrdem, loc_oLinha, loc_oErro
3470:         loc_lSucesso = .T.
3471: 
3472:         TRY
3473:             IF THIS.EmModoEdicao() AND THIS.this_lAlterou
3474: 
3475:                 IF UPPER(ALLTRIM(THIS.this_cModoAtual)) = "ALTERAR"
3476:                     loc_cSQL = "DELETE FROM sigopfin WHERE dopes = " + ;
3477:                         EscaparSQL(THIS.this_cDopes)
3478: 
3479:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3480:                     IF loc_nResultado < 0
3481:                         MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
3482:                             CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
3483:                         loc_lSucesso = .F.
3484:                     ENDIF
3485:                 ENDIF
3486: 
3487:                 IF loc_lSucesso AND USED("cursor_4c_GrdValores")
3488:                     loc_nOrdem = 0
3489: 
3490:                     SELECT cursor_4c_GrdValores
3491:                     GO TOP
3492:                     SCAN FOR !EMPTY(Codigos)
3493:                         loc_nOrdem = loc_nOrdem + 1
3494: 
3495:                         loc_oLinha = CREATEOBJECT("sigopfinBO")
3496:                         IF VARTYPE(loc_oLinha) = "O"
3497:                             *-- CarregarDoCursor() do BO NAO serve aqui: ele le
3498:                             *-- cidchaves/chkempds, colunas que NAO existem em
3499:                             *-- cursor_4c_GrdValores (CriarCursorGrdValores so
3500:                             *-- declara os campos que a grade/campos de
3501:                             *-- detalhe usam - cidchaves e gerado de novo a
3502:                             *-- cada Inserir() e chkempds nao tem controle na
3503:                             *-- tela). Chama-lo estouraria "Variable CIDCHAVES
3504:                             *-- is not found". Os campos sao copiados um a um.
3505:                             loc_oLinha.this_cCodigos  = TratarNulo(cursor_4c_GrdValores.Codigos,  "")

*-- Linhas 3564 a 3614:
3564:     * dopes) ja aberto pelo form PAI - aqui le-se e grava-se via SQL direto,
3565:     * ja que este dialogo nao tem esse cursor. "S"/"N" (convencao Fortyus de
3566:     * flag char) no lugar do valor logico do CheckBox legado - this_cDopes
3567:     * ja vem com o padding de 20 (PADR no Init), EscaparSQL compara com
3568:     * blank-padding ANSI do SQL Server.
3569:     *
3570:     * Sem registro de SigCdOpe para este Dopes: devolve .T. em silencio (nao
3571:     * ha o que atualizar, e nao deve bloquear o fechamento do dialogo por uma
3572:     * inconsistencia que nao e deste form).
3573:     *--------------------------------------------------------------------------
3574:     PROTECTED FUNCTION AtualizarConfigFinanceiraOperacao()
3575:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCfgAtual, loc_cCfgNova, loc_oErro
3576:         loc_lSucesso = .T.
3577: 
3578:         TRY
3579:             THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3580: 
3581:             loc_cSQL = "SELECT cfgfinancs FROM SigCdOpe WHERE dopes = " + ;
3582:                 EscaparSQL(THIS.this_cDopes)
3583: 
3584:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgFinTmp")
3585: 
3586:             IF loc_nResultado >= 0 AND USED("cursor_4c_CfgFinTmp") ;
3587:                     AND RECCOUNT("cursor_4c_CfgFinTmp") > 0
3588:                 loc_cCfgAtual = PADR(TratarNulo(cursor_4c_CfgFinTmp.cfgfinancs, ""), 20)
3589: 
3590:                 loc_cCfgNova = PADR(IIF(THIS.chk_4c_Chk_P1_CMVS.Value = 1, "S", "N"), 1) + ;
3591:                                PADR(IIF(THIS.chk_4c_Chk_P2_MOBS.Value = 1, "S", "N"), 1) + ;
3592:                                SUBSTR(loc_cCfgAtual, 3, 18)
3593: 
3594:                 THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3595: 
3596:                 loc_cSQL = "UPDATE SigCdOpe SET cfgfinancs = " + EscaparSQL(loc_cCfgNova) + ;
3597:                     " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
3598: 
3599:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
3600:                 IF loc_nResultado < 0
3601:                     MsgErro("Erro ao atualizar a configura" + CHR(231) + CHR(227) + ;
3602:                         "o financeira da opera" + CHR(231) + CHR(227) + "o:" + ;
3603:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
3604:                     loc_lSucesso = .F.
3605:                 ENDIF
3606:             ELSE
3607:                 THIS.FecharCursorTemporario("cursor_4c_CfgFinTmp")
3608:             ENDIF
3609:         CATCH TO loc_oErro
3610:             loc_lSucesso = .F.
3611:             MsgErro(loc_oErro.Message + CHR(13) + ;
3612:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3613:                 "Procedure: " + loc_oErro.Procedure, ;
3614:                 "Erro em AtualizarConfigFinanceiraOperacao")


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

