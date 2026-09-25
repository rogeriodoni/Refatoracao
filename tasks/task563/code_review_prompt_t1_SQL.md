# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MOEDAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPEINATVS, VENDAS, COPERS, CAIXAS, EMPDOPNUMS, CONTAEDS, CONTAS, SCONTAS, GRUPOS, SGRUPOS, DATAS, EMPS, OPERACAOS, MARCAS, PCUSS, NOPERS, VISTIT, JO

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
  ControlSource = ""
  DeleteMark = .F.
select craltcc
select craltcc
Select CrAltCc
Select csMovimento
lcQuery = [select sigmvcab.valos, sigmvcab.Datas, sigmvcab.Emps, sigmvcab.dopes, sigmvcab.Numes, sigmvcab.empdopnums ] + ;
	[from sigmvcab ] + ;
	[join sigcdope on sigcdope.dopes = sigmvcab.Dopes ] + ;
	[join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes ] + ;
	[And empdopnums not in ( Select distinct a.empdopnums from sigmvccr a ] + ;
	[join sigcdope on sigcdope.dopes = a.Dopes ] + ;
	[join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes ] + ;
	[join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas ] + ;
	[from SigOpFin ] + ;
	[join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes ] + ;
If Thisform.Podatamgr.SqlExecute(lcQuery,[crTmpMov])<1
Select crTmpMov
Select crTmpMov.* ;
	From crTmpMov, csOperacaos ;
Select crMov
	lcQuery = [Select distinct a.Emps, a.dopes, a.numes, a.EmpDopnums, a.datas, sum(c.custofs) as custofs, ] + ;
		[From sigmvcab a ] + ;
		[join SigMvItn b on b.empdopnums = a.empdopnums ] + ;
		[join SigCdPro c on c.Cpros = b.Cpros ] + ;
		[join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas ] + ;
		[from SigOpFin ] + ;
		[join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes ] + ;
	If Thisform.Podatamgr.SqlExecute(lcQuery,[crMovIt])<1
	Select crMovIt
		Select csMovimento
		Select crMovIt
	Select crMov
Select csMovimento
Select Emps, Dopes, DataS, Sum(custofs) As custofs, Sum(pcuss) As pcuss, moecusfs, moedas, Sum(qtds) As qtds, ;
	From csMovimento ;
Select CrMvCCr
	Select CrAltCc
	Select CrMvCCr
Select CrAltCc
If Thisform.Podatamgr.Update('Craltcc')
	Select CrAltCc
		lnErro0 = Thisform.Podatamgr.SqlExecute([Select Cidchaves as nRecNo From SigMvCcr Where Nopers = ?lnNopers],'CsLog')
			Select csLog
Select csOperacaos
Select Dopes, VisTit from csOperacaos Where Marcas = .T. And VisTit = 1 into Cursor csVisTit Readwrite 
Select csVisTit
		.AddCursor('SigMvCcr', 'CidChaves',  'CrAltcc',    '', '', [Select * From SigMvCcr])
lcQuery = [select distinct SigOpFin.Dopes, convert(int,(substring(lbltxidCs,24,1))) as VisTit ] + ;
	[from SigOpFin ] + ;
	[join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes ] + ;
	[join SigOpCdi on SigOpCdi.dopes = SigOpFin.dopes ] + ;
Thisform.poDatamgr.SqlExecute(lcQuery,'crSigOpFin')
Select crSigOpFin
Select crSigCdCot
Select crSigCdMoe
Select crSigOpFin
	Insert Into csOperacaos (Marcas, Operacaos, VisTit) Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
Select csOperacaos
	.DeleteMark = .F.
	.Column1.ControlSource = 'csOperacaos.Marcas'
	.Column2.ControlSource = 'csOperacaos.Operacaos'
Select csOperacaos
	Select csOperacaos
Select csOperacaos
		Select csOperacaos
		Select csOperacaos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg) - TRECHOS RELEVANTES PARA PASS SQL (1332 linhas total):

*-- Linhas 204 a 236:
204: 
205:     *==========================================================================
206:     * CriarCursorOperacoes - Cria o cursor de trabalho da grade de selecao de
207:     * operacoes (espelha "Create Cursor csOperacaos (Marcas l(1), Operacaos
208:     * c(20), VisTit n(1))" + "Index on Operacaos Tag Operacaos" do PROCEDURE
209:     * Load do legado). Estrutura fixa, reaproveitada em todas as fases
210:     * seguintes que popularem o cursor - a ORDEM dos campos NUNCA muda.
211:     *==========================================================================
212:     PROTECTED PROCEDURE CriarCursorOperacoes()
213:         LOCAL loc_cCursor
214:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
215: 
216:         IF USED(loc_cCursor)
217:             USE IN (loc_cCursor)
218:         ENDIF
219: 
220:         CREATE CURSOR (loc_cCursor) (Marcas L(1), Operacaos C(20), VisTit N(1))
221:         SELECT (loc_cCursor)
222:         INDEX ON Operacaos TAG Operacaos
223:     ENDPROC
224: 
225:     *==========================================================================
226:     * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar,
227:     * posicionados diretamente no form (fora de container), EXATAMENTE como
228:     * no SIGMVCMV.SCX original (Shape1/Processa/Cancela).
229:     *==========================================================================
230:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
231:         THIS.AddObject("shp_4c_Shape1", "Shape")
232:         WITH THIS.shp_4c_Shape1
233:             .Top           = -2
234:             .Left          = 644
235:             .Height        = 37
236:             .Width         = 52

*-- Linhas 583 a 720:
583:             .ColumnCount       = 3
584:             .RecordSource      = loc_cCursor
585:             .HeaderHeight      = 0
586:             .DeleteMark        = .F.
587:             .RecordMark        = .F.
588:             .ReadOnly          = .F.
589:             .Top               = 165
590:             .Left              = 154
591:             .Width             = 247
592:             .Height            = 148
593:             .FontName          = "Tahoma"
594:             .FontSize          = 8
595:             .RowHeight         = 18
596:             .ScrollBars        = 2
597:             .GridLineColor     = RGB(238, 238, 238)
598:             .AllowHeaderSizing = .F.
599:             .AllowRowSizing    = .F.
600:             .TabIndex          = 12
601: 
602:             .Column1.Width        = 15
603:             .Column1.ControlSource = loc_cCursor + ".Marcas"
604:             .Column1.FontName     = "Courier New"
605:             .Column1.Movable      = .F.
606:             .Column1.Resizable    = .F.
607: 
608:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
609:             WITH .Column1.chk_4c_Check1
610:                 .Top       = 9
611:                 .Left      = 2
612:                 .Height    = 17
613:                 .Width     = 22
614:                 .FontName  = "Tahoma"
615:                 .Alignment = 0
616:                 .Caption   = ""
617:                 .Visible   = .T.
618:                 .AutoSize  = .T.
619:             ENDWITH
620:             .Column1.CurrentControl = "chk_4c_Check1"
621:             .Column1.Sparse         = .F.
622:             .Column1.ReadOnly       = .F.
623: 
624:             .Column2.Width         = 210
625:             .Column2.ControlSource = loc_cCursor + ".Operacaos"
626:             .Column2.FontName      = "Courier New"
627:             .Column2.Movable       = .F.
628:             .Column2.Resizable     = .F.
629:             .Column2.ReadOnly      = .T.
630:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
631:             .Column2.Text1.BorderStyle = 1
632:             .Column2.Text1.Margin      = 0
633: 
634:             .Visible = .T.
635:         ENDWITH
636: 
637:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "ChkMarcasClick")
638:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "ChkMarcasKeyPress")
639:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
640:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "ChkMarcasMouseUp")
641:     ENDPROC
642: 
643:     *==========================================================================
644:     * CarregarLista - PUBLIC (o harness de teste chama direto no oForm, e o
645:     * metodo tambem e' acionado pela propria tela). Popula a grade de selecao de
646:     * operacoes, espelhando o bloco do PROCEDURE Init legado:
647:     *
648:     *   Select crSigOpFin
649:     *   Scan
650:     *       Insert Into csOperacaos (Marcas, Operacaos, VisTit) ;
651:     *           Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
652:     *   Endscan
653:     *   Select csOperacaos
654:     *   Go Top
655:     *
656:     * Todas as linhas nascem MARCADAS (.T.), exatamente como no legado - o
657:     * usuario desmarca o que nao quer processar. O cursor da grade e' ZAPado
658:     * (nunca fechado/recriado): fechar quebraria o RecordSource do grid e
659:     * resetaria Column.Width/CurrentControl/Sparse ja configurados.
660:     *==========================================================================
661:     PROCEDURE CarregarLista()
662:         LOCAL loc_cCursor, loc_cOrigem, loc_nArea, loc_cDopes, loc_nVisTit, loc_oErro
663: 
664:         TRY
665:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
666:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
667:             loc_nArea   = SELECT()
668: 
669:             IF !USED(loc_cCursor)
670:                 THIS.CriarCursorOperacoes()
671:             ENDIF
672: 
673:             SELECT (loc_cCursor)
674:             ZAP
675: 
676:             *-- Sem conexao (modo de validacao de UI) a grade fica vazia, mas
677:             *-- o form abre normalmente - nao ha SQL para executar
678:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
679:                     AND THIS.this_oBusinessObject.CarregarOperacoes() ;
680:                     AND USED(loc_cOrigem)
681: 
682:                 SELECT (loc_cOrigem)
683:                 GO TOP
684:                 DO WHILE !EOF(loc_cOrigem)
685:                     loc_cDopes  = EVALUATE(loc_cOrigem + ".Dopes")
686:                     loc_nVisTit = NVL(EVALUATE(loc_cOrigem + ".VisTit"), 0)
687: 
688:                     INSERT INTO (loc_cCursor) (Marcas, Operacaos, VisTit) ;
689:                         VALUES (.T., loc_cDopes, loc_nVisTit)
690: 
691:                     SELECT (loc_cOrigem)
692:                     SKIP
693:                 ENDDO
694:             ENDIF
695: 
696:             *-- Popular o cursor NAO repinta a grade: o legado sempre fecha com
697:             *-- "Select csOperacaos / Go Top" + Refresh (regra #21 CLAUDE.md)
698:             SELECT (loc_cCursor)
699:             GO TOP
700:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
701:                 THIS.grd_4c_Dados.Refresh()
702:             ENDIF
703: 
704:             IF loc_nArea > 0
705:                 SELECT (loc_nArea)
706:             ENDIF
707:         CATCH TO loc_oErro
708:             MsgErro(loc_oErro.Message + CHR(13) + ;
709:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
710:                 "Procedure: " + loc_oErro.Procedure, ;
711:                 "Erro CarregarLista")
712:         ENDTRY
713:     ENDPROC
714: 
715:     *==========================================================================
716:     * ChkMarcasClick / ChkMarcasKeyPress / ChkMarcasMouseDown / ChkMarcasMouseUp
717:     * PUBLIC (BINDEVENT exige metodo publico - regra #3 CLAUDE.md). Espelham
718:     * SIGMVCMV.grdOperacaos.Column1.Check1 do legado: o toggle acontece no
719:     * KeyPress (Enter/Espaco) e no MouseDown; Click e MouseUp apenas suprimem
720:     * o comportamento nativo (NoDefault) para nao alternar em duplicidade.

*-- Linhas 734 a 811:
734:         IF INLIST(par_nKeyCode, 13, 32)
735:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
736:             IF USED(loc_cCursor)
737:                 loc_nAreaAnterior = SELECT()
738:                 SELECT (loc_cCursor)
739:                 IF !EOF()
740:                     REPLACE Marcas WITH !Marcas
741:                     THIS.grd_4c_Dados.Refresh()
742:                 ENDIF
743:                 SELECT (loc_nAreaAnterior)
744:             ENDIF
745:             NODEFAULT
746:         ENDIF
747:     ENDPROC
748: 
749:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
750:         LOCAL loc_cCursor, loc_nAreaAnterior
751: 
752:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
753:         IF USED(loc_cCursor)
754:             loc_nAreaAnterior = SELECT()
755:             SELECT (loc_cCursor)
756:             IF !EOF()
757:                 REPLACE Marcas WITH !Marcas
758:                 THIS.grd_4c_Dados.Refresh()
759:             ENDIF
760:             SELECT (loc_nAreaAnterior)
761:         ENDIF
762:         NODEFAULT
763:     ENDPROC
764: 
765:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
766:         NODEFAULT
767:     ENDPROC
768: 
769:     *==========================================================================
770:     * CmdBtnGradeClick - PUBLIC (BINDEVENT). Marca/desmarca TODAS as linhas
771:     * da grade (espelha SIGMVCMV.cmdBtnGrade.Click: Value=1 -> btnMarcaTudo,
772:     * Value=2 -> btnDesmarcar).
773:     *==========================================================================
774:     PROCEDURE CmdBtnGradeClick()
775:         LOCAL loc_cCursor, loc_nAreaAnterior
776: 
777:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
778:         IF !USED(loc_cCursor)
779:             RETURN
780:         ENDIF
781: 
782:         loc_nAreaAnterior = SELECT()
783:         SELECT (loc_cCursor)
784: 
785:         DO CASE
786:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1
787:                 REPLACE ALL Marcas WITH .T.
788:                 GO TOP
789:                 THIS.grd_4c_Dados.Refresh()
790:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2
791:                 REPLACE ALL Marcas WITH .F.
792:                 GO TOP
793:                 THIS.grd_4c_Dados.Refresh()
794:         ENDCASE
795: 
796:         SELECT (loc_nAreaAnterior)
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * BtnCancelarClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Cancela.Click
801:     * ("Thisform.Release").
802:     *==========================================================================
803:     PROCEDURE BtnCancelarClick()
804:         THIS.Release()
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * BtnProcessaClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Processa.Click:
809:     * valida periodo informado + pelo menos uma operacao marcada + confirma,
810:     * depois delega para THIS.Processamento() e limpa a tela com
811:     * THIS.LimparTela(), na MESMA ordem do legado ("=ThisForm.Processamento()"

*-- Linhas 832 a 850:
832:             RETURN
833:         ENDIF
834: 
835:         SELECT (loc_cCursor)
836:         LOCATE FOR Marcas = .T.
837:         IF !FOUND()
838:             MsgAviso("Selecione uma Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
839:             THIS.grd_4c_Dados.Column1.SetFocus()
840:             RETURN
841:         ENDIF
842: 
843:         loc_lConfirmou = MsgConfirma("Confirma o Processamento?", "Aten" + CHR(231) + CHR(227) + "o")
844:         IF !loc_lConfirmou
845:             RETURN
846:         ENDIF
847: 
848:         THIS.HabilitarCampos(.F.)
849:         THIS.Processamento()
850:         THIS.HabilitarCampos(.T.)

*-- Linhas 952 a 971:
952:             USE IN cursor_4c_LkpMoeda
953:         ENDIF
954: 
955:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
956:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
957: 
958:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
959:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
960:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
961:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
962:             USE IN cursor_4c_LkpMoeda
963:         ELSE
964:             IF USED("cursor_4c_LkpMoeda")
965:                 USE IN cursor_4c_LkpMoeda
966:             ENDIF
967:             THIS.AbrirBuscaMoeda(loc_cValor)
968:         ENDIF
969: 
970:         THIS.txt_4c__cd_moeda.Refresh()
971:         THIS.txt_4c__ds_moeda.Refresh()

*-- Linhas 996 a 1015:
996:             USE IN cursor_4c_LkpMoeda
997:         ENDIF
998: 
999:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes = " + EscaparSQL(loc_cValor)
1000:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
1001: 
1002:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
1003:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
1004:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
1005:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
1006:             USE IN cursor_4c_LkpMoeda
1007:         ELSE
1008:             IF USED("cursor_4c_LkpMoeda")
1009:                 USE IN cursor_4c_LkpMoeda
1010:             ENDIF
1011:             THIS.AbrirBuscaMoeda(loc_cValor)
1012:         ENDIF
1013: 
1014:         THIS.txt_4c__cd_moeda.Refresh()
1015:         THIS.txt_4c__ds_moeda.Refresh()

*-- Linhas 1061 a 1080:
1061:             USE IN cursor_4c_LkpEmpresa
1062:         ENDIF
1063: 
1064:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
1065:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1066: 
1067:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1068:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1069:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1070:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1071:             USE IN cursor_4c_LkpEmpresa
1072:         ELSE
1073:             IF USED("cursor_4c_LkpEmpresa")
1074:                 USE IN cursor_4c_LkpEmpresa
1075:             ENDIF
1076:             THIS.AbrirBuscaEmpresa(loc_cValor)
1077:         ENDIF
1078: 
1079:         THIS.txt_4c_Empresa.Refresh()
1080:         THIS.txt_4c_DEmpresa.Refresh()

*-- Linhas 1109 a 1128:
1109:             USE IN cursor_4c_LkpEmpresa
1110:         ENDIF
1111: 
1112:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE razas = " + EscaparSQL(loc_cValor)
1113:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1114: 
1115:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1116:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1117:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1118:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1119:             USE IN cursor_4c_LkpEmpresa
1120:         ELSE
1121:             IF USED("cursor_4c_LkpEmpresa")
1122:                 USE IN cursor_4c_LkpEmpresa
1123:             ENDIF
1124:             THIS.AbrirBuscaEmpresa(loc_cValor)
1125:         ENDIF
1126: 
1127:         THIS.txt_4c_Empresa.Refresh()
1128:         THIS.txt_4c_DEmpresa.Refresh()

