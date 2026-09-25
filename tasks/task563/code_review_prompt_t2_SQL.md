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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCMV.prg) - TRECHOS RELEVANTES PARA PASS SQL (1333 linhas total):

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

*-- Linhas 584 a 721:
584: 
585:         WITH THIS.grd_4c_Dados
586:             .HeaderHeight      = 0
587:             .DeleteMark        = .F.
588:             .RecordMark        = .F.
589:             .ReadOnly          = .F.
590:             .Top               = 165
591:             .Left              = 154
592:             .Width             = 247
593:             .Height            = 148
594:             .FontName          = "Tahoma"
595:             .FontSize          = 8
596:             .RowHeight         = 18
597:             .ScrollBars        = 2
598:             .GridLineColor     = RGB(238, 238, 238)
599:             .AllowHeaderSizing = .F.
600:             .AllowRowSizing    = .F.
601:             .TabIndex          = 12
602: 
603:             .Column1.Width        = 15
604:             .Column1.ControlSource = loc_cCursor + ".Marcas"
605:             .Column1.FontName     = "Courier New"
606:             .Column1.Movable      = .F.
607:             .Column1.Resizable    = .F.
608: 
609:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
610:             WITH .Column1.chk_4c_Check1
611:                 .Top       = 9
612:                 .Left      = 2
613:                 .Height    = 17
614:                 .Width     = 22
615:                 .FontName  = "Tahoma"
616:                 .Alignment = 0
617:                 .Caption   = ""
618:                 .Visible   = .T.
619:                 .AutoSize  = .T.
620:             ENDWITH
621:             .Column1.CurrentControl = "chk_4c_Check1"
622:             .Column1.Sparse         = .F.
623:             .Column1.ReadOnly       = .F.
624: 
625:             .Column2.Width         = 210
626:             .Column2.ControlSource = loc_cCursor + ".Operacaos"
627:             .Column2.FontName      = "Courier New"
628:             .Column2.Movable       = .F.
629:             .Column2.Resizable     = .F.
630:             .Column2.ReadOnly      = .T.
631:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
632:             .Column2.Text1.BorderStyle = 1
633:             .Column2.Text1.Margin      = 0
634: 
635:             .Visible = .T.
636:         ENDWITH
637: 
638:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click", THIS, "ChkMarcasClick")
639:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress", THIS, "ChkMarcasKeyPress")
640:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseDown", THIS, "ChkMarcasMouseDown")
641:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "MouseUp", THIS, "ChkMarcasMouseUp")
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * CarregarLista - PUBLIC (o harness de teste chama direto no oForm, e o
646:     * metodo tambem e' acionado pela propria tela). Popula a grade de selecao de
647:     * operacoes, espelhando o bloco do PROCEDURE Init legado:
648:     *
649:     *   Select crSigOpFin
650:     *   Scan
651:     *       Insert Into csOperacaos (Marcas, Operacaos, VisTit) ;
652:     *           Values (.T., crSigOpFin.Dopes, crSigOpFin.VisTit)
653:     *   Endscan
654:     *   Select csOperacaos
655:     *   Go Top
656:     *
657:     * Todas as linhas nascem MARCADAS (.T.), exatamente como no legado - o
658:     * usuario desmarca o que nao quer processar. O cursor da grade e' ZAPado
659:     * (nunca fechado/recriado): fechar quebraria o RecordSource do grid e
660:     * resetaria Column.Width/CurrentControl/Sparse ja configurados.
661:     *==========================================================================
662:     PROCEDURE CarregarLista()
663:         LOCAL loc_cCursor, loc_cOrigem, loc_nArea, loc_cDopes, loc_nVisTit, loc_oErro
664: 
665:         TRY
666:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
667:             loc_cOrigem = THIS.this_oBusinessObject.this_cCursorSigOpFin
668:             loc_nArea   = SELECT()
669: 
670:             IF !USED(loc_cCursor)
671:                 THIS.CriarCursorOperacoes()
672:             ENDIF
673: 
674:             SELECT (loc_cCursor)
675:             ZAP
676: 
677:             *-- Sem conexao (modo de validacao de UI) a grade fica vazia, mas
678:             *-- o form abre normalmente - nao ha SQL para executar
679:             IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) ;
680:                     AND THIS.this_oBusinessObject.CarregarOperacoes() ;
681:                     AND USED(loc_cOrigem)
682: 
683:                 SELECT (loc_cOrigem)
684:                 GO TOP
685:                 DO WHILE !EOF(loc_cOrigem)
686:                     loc_cDopes  = EVALUATE(loc_cOrigem + ".Dopes")
687:                     loc_nVisTit = NVL(EVALUATE(loc_cOrigem + ".VisTit"), 0)
688: 
689:                     INSERT INTO (loc_cCursor) (Marcas, Operacaos, VisTit) ;
690:                         VALUES (.T., loc_cDopes, loc_nVisTit)
691: 
692:                     SELECT (loc_cOrigem)
693:                     SKIP
694:                 ENDDO
695:             ENDIF
696: 
697:             *-- Popular o cursor NAO repinta a grade: o legado sempre fecha com
698:             *-- "Select csOperacaos / Go Top" + Refresh (regra #21 CLAUDE.md)
699:             SELECT (loc_cCursor)
700:             GO TOP
701:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
702:                 THIS.grd_4c_Dados.Refresh()
703:             ENDIF
704: 
705:             IF loc_nArea > 0
706:                 SELECT (loc_nArea)
707:             ENDIF
708:         CATCH TO loc_oErro
709:             MsgErro(loc_oErro.Message + CHR(13) + ;
710:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
711:                 "Procedure: " + loc_oErro.Procedure, ;
712:                 "Erro CarregarLista")
713:         ENDTRY
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * ChkMarcasClick / ChkMarcasKeyPress / ChkMarcasMouseDown / ChkMarcasMouseUp
718:     * PUBLIC (BINDEVENT exige metodo publico - regra #3 CLAUDE.md). Espelham
719:     * SIGMVCMV.grdOperacaos.Column1.Check1 do legado: o toggle acontece no
720:     * KeyPress (Enter/Espaco) e no MouseDown; Click e MouseUp apenas suprimem
721:     * o comportamento nativo (NoDefault) para nao alternar em duplicidade.

*-- Linhas 735 a 812:
735:         IF INLIST(par_nKeyCode, 13, 32)
736:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
737:             IF USED(loc_cCursor)
738:                 loc_nAreaAnterior = SELECT()
739:                 SELECT (loc_cCursor)
740:                 IF !EOF()
741:                     REPLACE Marcas WITH !Marcas
742:                     THIS.grd_4c_Dados.Refresh()
743:                 ENDIF
744:                 SELECT (loc_nAreaAnterior)
745:             ENDIF
746:             NODEFAULT
747:         ENDIF
748:     ENDPROC
749: 
750:     PROCEDURE ChkMarcasMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
751:         LOCAL loc_cCursor, loc_nAreaAnterior
752: 
753:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
754:         IF USED(loc_cCursor)
755:             loc_nAreaAnterior = SELECT()
756:             SELECT (loc_cCursor)
757:             IF !EOF()
758:                 REPLACE Marcas WITH !Marcas
759:                 THIS.grd_4c_Dados.Refresh()
760:             ENDIF
761:             SELECT (loc_nAreaAnterior)
762:         ENDIF
763:         NODEFAULT
764:     ENDPROC
765: 
766:     PROCEDURE ChkMarcasMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
767:         NODEFAULT
768:     ENDPROC
769: 
770:     *==========================================================================
771:     * CmdBtnGradeClick - PUBLIC (BINDEVENT). Marca/desmarca TODAS as linhas
772:     * da grade (espelha SIGMVCMV.cmdBtnGrade.Click: Value=1 -> btnMarcaTudo,
773:     * Value=2 -> btnDesmarcar).
774:     *==========================================================================
775:     PROCEDURE CmdBtnGradeClick()
776:         LOCAL loc_cCursor, loc_nAreaAnterior
777: 
778:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOperacoes
779:         IF !USED(loc_cCursor)
780:             RETURN
781:         ENDIF
782: 
783:         loc_nAreaAnterior = SELECT()
784:         SELECT (loc_cCursor)
785: 
786:         DO CASE
787:             CASE THIS.obj_4c_CmdBtnGrade.Value = 1
788:                 REPLACE ALL Marcas WITH .T.
789:                 GO TOP
790:                 THIS.grd_4c_Dados.Refresh()
791:             CASE THIS.obj_4c_CmdBtnGrade.Value = 2
792:                 REPLACE ALL Marcas WITH .F.
793:                 GO TOP
794:                 THIS.grd_4c_Dados.Refresh()
795:         ENDCASE
796: 
797:         SELECT (loc_nAreaAnterior)
798:     ENDPROC
799: 
800:     *==========================================================================
801:     * BtnCancelarClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Cancela.Click
802:     * ("Thisform.Release").
803:     *==========================================================================
804:     PROCEDURE BtnCancelarClick()
805:         THIS.Release()
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * BtnProcessaClick - PUBLIC (BINDEVENT). Espelha SIGMVCMV.Processa.Click:
810:     * valida periodo informado + pelo menos uma operacao marcada + confirma,
811:     * depois delega para THIS.Processamento() e limpa a tela com
812:     * THIS.LimparTela(), na MESMA ordem do legado ("=ThisForm.Processamento()"

*-- Linhas 833 a 851:
833:             RETURN
834:         ENDIF
835: 
836:         SELECT (loc_cCursor)
837:         LOCATE FOR Marcas = .T.
838:         IF !FOUND()
839:             MsgAviso("Selecione uma Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
840:             THIS.grd_4c_Dados.Column1.SetFocus()
841:             RETURN
842:         ENDIF
843: 
844:         loc_lConfirmou = MsgConfirma("Confirma o Processamento?", "Aten" + CHR(231) + CHR(227) + "o")
845:         IF !loc_lConfirmou
846:             RETURN
847:         ENDIF
848: 
849:         THIS.HabilitarCampos(.F.)
850:         THIS.Processamento()
851:         THIS.HabilitarCampos(.T.)

*-- Linhas 953 a 972:
953:             USE IN cursor_4c_LkpMoeda
954:         ENDIF
955: 
956:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cValor)
957:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
958: 
959:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
960:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
961:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
962:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
963:             USE IN cursor_4c_LkpMoeda
964:         ELSE
965:             IF USED("cursor_4c_LkpMoeda")
966:                 USE IN cursor_4c_LkpMoeda
967:             ENDIF
968:             THIS.AbrirBuscaMoeda(loc_cValor)
969:         ENDIF
970: 
971:         THIS.txt_4c__cd_moeda.Refresh()
972:         THIS.txt_4c__ds_moeda.Refresh()

*-- Linhas 997 a 1016:
997:             USE IN cursor_4c_LkpMoeda
998:         ENDIF
999: 
1000:         loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe WHERE dmoes = " + EscaparSQL(loc_cValor)
1001:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpMoeda")
1002: 
1003:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpMoeda") AND ;
1004:                 RECCOUNT("cursor_4c_LkpMoeda") > 0
1005:             THIS.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.cmoes)
1006:             THIS.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_LkpMoeda.dmoes)
1007:             USE IN cursor_4c_LkpMoeda
1008:         ELSE
1009:             IF USED("cursor_4c_LkpMoeda")
1010:                 USE IN cursor_4c_LkpMoeda
1011:             ENDIF
1012:             THIS.AbrirBuscaMoeda(loc_cValor)
1013:         ENDIF
1014: 
1015:         THIS.txt_4c__cd_moeda.Refresh()
1016:         THIS.txt_4c__ds_moeda.Refresh()

*-- Linhas 1062 a 1081:
1062:             USE IN cursor_4c_LkpEmpresa
1063:         ENDIF
1064: 
1065:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor)
1066:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1067: 
1068:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1069:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1070:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1071:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1072:             USE IN cursor_4c_LkpEmpresa
1073:         ELSE
1074:             IF USED("cursor_4c_LkpEmpresa")
1075:                 USE IN cursor_4c_LkpEmpresa
1076:             ENDIF
1077:             THIS.AbrirBuscaEmpresa(loc_cValor)
1078:         ENDIF
1079: 
1080:         THIS.txt_4c_Empresa.Refresh()
1081:         THIS.txt_4c_DEmpresa.Refresh()

*-- Linhas 1110 a 1129:
1110:             USE IN cursor_4c_LkpEmpresa
1111:         ENDIF
1112: 
1113:         loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE razas = " + EscaparSQL(loc_cValor)
1114:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpEmpresa")
1115: 
1116:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpEmpresa") AND ;
1117:                 RECCOUNT("cursor_4c_LkpEmpresa") > 0
1118:             THIS.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_LkpEmpresa.cemps)
1119:             THIS.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_LkpEmpresa.razas)
1120:             USE IN cursor_4c_LkpEmpresa
1121:         ELSE
1122:             IF USED("cursor_4c_LkpEmpresa")
1123:                 USE IN cursor_4c_LkpEmpresa
1124:             ENDIF
1125:             THIS.AbrirBuscaEmpresa(loc_cValor)
1126:         ENDIF
1127: 
1128:         THIS.txt_4c_Empresa.Refresh()
1129:         THIS.txt_4c_DEmpresa.Refresh()

