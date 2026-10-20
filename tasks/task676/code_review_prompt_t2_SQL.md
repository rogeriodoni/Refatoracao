# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_TOTA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, NOPS, SERVICOS, CATS, EMPDNPS, CMATS, TPOPS, RCL

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
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = "TmpDistrib.Dpros"
  ControlSource = "TmpDistrib.DescOrig"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TmpDistrib.DescDest"
SELECT SUM(qtds) as qtds, SUM(qtds * fators) as vrtots, SUM(qtds * fators) as vrpags from tmpDistrib into cursor curt
SELECT tmpDistrib
lcQuery = [Select a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, b.CDescs, d.Dpros, ] +;
			[from SigPdMvf a inner join SigCdNei b on a.Empdnps = b.Empdnps ] +;
			[inner join SigCdNec c on a.Empdnps = c.Empdnps ] +;
			[inner join SigCdPro d on b.Cmats = d.Cpros ] +;
			[inner join SigCdCli e on c.Contaos = e.Iclis ] +;
			[inner join SigCdCli f on c.Contads = f.Iclis ] +;			
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpDistrib') < 1)
Select xMfas 
	lcQuery = [Select b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, b.CDescs, d.dpros, ] +;
				[from SigPdMvf a inner join SigCdNei b on a.Empdnps = b.Empdnps ] +;
				[inner join SigCdNec c on a.Empdnps = c.Empdnps ] +;
				[inner join SigCdPro d on b.Cmats = d.Cpros ] +;
				[inner join SigCdCli e on c.Contaos = e.Iclis ] +;
				[inner join SigCdCli f on c.Contads = f.Iclis ] +;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas4') < 1)
	Select LocalMfas4
			Insert into TmpDistrib from memvar
Select TmpDistrib
	.Column1.ControlSource   = 'TmpDistrib.Empdnps'
	.Column2.ControlSource   = 'TmpDistrib.Grupoos'
	.Column7.ControlSource   = 'TmpDistrib.Contaos'
	.Column8.ControlSource   = 'TmpDistrib.Grupods'
	.Column9.ControlSource   = 'TmpDistrib.Contads'			
	.Column3.ControlSource   = 'TmpDistrib.cMats'
	.Column4.ControlSource   = 'TmpDistrib.Qtds'
	.Column5.ControlSource   = 'TmpDistrib.Fators'
	.Column6.ControlSource   = 'TmpDistrib.Qtds * TmpDistrib.Fators'
Select xnensi
&&			lcSql = [Select nops From SigCdNei Where cmats = ']+TmpDistrib.cmats+[' and tpops = ']+TmpDistrib.tpOps +[']
&&			ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalNei')
&&			SELECT LocalNei

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg) - TRECHOS RELEVANTES PARA PASS SQL (1031 linhas total):

*-- Linhas 33 a 65:
33: * eh o botao OK, que fecha o dialogo - ver SigPrSerBO.prg).
34: * Fase 5/8: 1a metade dos campos restantes - ConfigurarPaginaDados() com
35: * Shape1 (decorativo), container cnt_4c_Operacao (cabecalho somente-leitura
36: * da movimentacao: txt_4c_Codigo/Empresa/Operacao ligados por ControlSource
37: * direto a tmpnens.numps/emps/dopps, cursor que o formulario PAI ja deixa na
38: * DataSession compartilhada - mesmo padrao de FormSigPrTar.prg) e o botao
39: * cmd_4c_Ok (BtnOkClick = THIS.Release(), fecha o dialogo via Destroy()).
40: * Fase 6/8: 2a metade dos campos - labels lbl_4c_Origem/lbl_4c_Destino/
41: * lbl_4c_Descricao (Say1/Say4/Say2 do dump, fora do container Operacao) e
42: * os TextBox somente-leitura txt_4c_Descr/DescOrig/DescDest (Get_descr/
43: * getDescOrig/getDescDest - ControlSource = TmpDistrib.Dpros/DescOrig/
44: * DescDest no legado) e txt_4c_QtdTot/txt_4c_Valtot (totalizadores). Nenhum
45: * desses campos tem lookup (comportamento.json: lookups=[]; todos os When
46: * do dump so fazem "Return .f.", ou seja, somente-leitura/auto-preenchidos -
47: * nao ha F4/F5/KeyPress/DblClick a implementar aqui). txt_4c_Descr/DescOrig/
48: * DescDest espelham a linha CORRENTE da grade (cursor_4c_Distrib, alias
49: * dinamico) - por isso o ControlSource delas eh atribuido em CarregarLista()
50: * (regra "ControlSource antes do cursor existir"), nao aqui, e recarregado
51: * em GradeAfterRowColChange(). txt_4c_QtdTot/txt_4c_Valtot sao preenchidos
52: * por AtualizarTotais() (ja existente desde a Fase 5, chamada por
53: * CarregarLista() apos Acumular()).
54: * Fase 7: SEM trabalho novo - conferido metodo a metodo contra
55: * comportamento.json (totalMetodos=13). SIGPRSER eh dialogo de CONFERENCIA
56: * (FLAT, sem frmcadastro/Grupo_Op/pcEscolha no dump), e o UNICO botao real do
57: * legado eh "ok" (Click), ja portado como BtnOkClick desde a Fase 5. Os 12
58: * metodos restantes sao Init/Procedure(acumula)/Procedure(fConfigGeral) +
59: * 9 "When" que so fazem "Return .t./.f." (campos somente-leitura e as duas
60: * celulas de grade testadas no dump) - todos ja cobertos nas fases
61: * anteriores (ver Fases 3-6 acima) ou documentados como NAO portados
62: * (fConfigGeral: ver utils\fconfiggeral.prg - wrapper de compatibilidade so
63: * para o p-code dos VCX legado, nunca chamado em codigo nosso; mesmo
64: * precedente de Formsigprsen.prg). Criar BtnIncluirClick/BtnAlterarClick/
65: * BtnVisualizarClick/BtnExcluirClick aqui violaria o PILAR 1 (o legado nao

*-- Linhas 191 a 209:
191:                 *-- Carga da grade de servicos lancados (bloco final do Init
192:                 *-- legado, dump 945-964). Em modo de teste/validacao de UI
193:                 *-- o cursor_4c_Operacoes (equivalente a xMfas) ainda nao foi
194:                 *-- preparado por nenhum form pai - pular evita SQLEXEC sem
195:                 *-- gnConnHandle valido num contexto sem usuario.
196:                 IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
197:                      (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
198:                     THIS.CarregarLista()
199:                 ENDIF
200: 
201:                 THIS.LockScreen = .F.
202: 
203:                 loc_lSucesso = .T.
204:             ELSE
205:                 MsgErro("Erro ao criar SigPrSerBO." + CHR(13) + ;
206:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
207:                         "Erro")
208:             ENDIF
209: 

*-- Linhas 282 a 320:
282:     * FLAT (sem PageFrame, regra #46 do CLAUDE.md para forms sem Page1/Page2):
283:     * a grade eh a vista principal do dialogo, criada direto sobre THIS, igual
284:     * ao cabecalho (Fase 3). So a estrutura/formatacao ESTATICA das colunas
285:     * entra aqui - RecordSource e Column.ControlSource (que dependem do cursor
286:     * populado) entram em CarregarLista().
287:     *
288:     * ColumnOrder reproduz a ordem VISUAL do dump (1,2,7,8,9,3,4,5,6), que
289:     * difere da ordem de criacao das Columns - Column7/8/9 (Conta/Grupo/Conta
290:     * do destino) aparecem visualmente ANTES de Column3/4/5 (Servico/Qtde/
291:     * Valor), exatamente como no SCX legado.
292:     *--------------------------------------------------------------------------
293:     PROTECTED PROCEDURE ConfigurarPaginaLista()
294:         THIS.AddObject("grd_4c_Dados", "Grid")
295:         WITH THIS.grd_4c_Dados
296:             .Top              = 197
297:             .Left             = 12
298:             .Width            = 976
299:             .Height           = 325
300:             .FontName         = "Courier New"
301:             .FontSize         = 8
302:             .RowHeight        = 17
303:             .ScrollBars       = 2
304:             .RecordSourceType = 1
305:             .DeleteMark       = .F.
306:             .RecordMark       = .F.
307:             .ReadOnly         = .F.
308:             .ColumnCount      = 9
309:             .Visible          = .T.
310: 
311:             *-- Column1 - Operacao (Empdnps) - ColumnOrder 1
312:             .Column1.ColumnOrder = 1
313:             .Column1.Width       = 241
314:             .Column1.Movable     = .F.
315:             .Column1.Resizable   = .F.
316:             .Column1.ReadOnly    = .T.
317:             .Column1.FontName    = "Courier New"
318:             .Column1.FontSize    = 8
319:             WITH .Column1.Header1
320:                 .FontName  = "Tahoma"

*-- Linhas 543 a 561:
543:     *       das colunas de descricao de origem/destino
544:     *     - lbl_4c_Descricao (Say2, dump 424-434)
545:     *     - txt_4c_DescOrig/txt_4c_DescDest/txt_4c_Descr (getDescOrig/
546:     *       getDescDest/Get_descr) - somente-leitura, ControlSource atribuido
547:     *       dinamicamente em CarregarLista() porque dependem do alias real de
548:     *       cursor_4c_Distrib (so existe apos CarregarDistribuicao() rodar)
549:     *     - txt_4c_QtdTot/txt_4c_Valtot (getQtdTot/getValtot, dump 798-833) -
550:     *       totalizadores, preenchidos por AtualizarTotais()
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDados()
553:         THIS.AddObject("shp_4c_Shape1", "Shape")
554:         WITH THIS.shp_4c_Shape1
555:             .Top         = 7
556:             .Left        = 898
557:             .Height      = 110
558:             .Width       = 90
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 593 a 639:
593: 
594:             .AddObject("txt_4c_Codigo", "TextBox")
595:             WITH .txt_4c_Codigo
596:                 .ControlSource = "tmpnens.numps"
597:                 .Format        = "L"
598:                 .InputMask     = "9999999999"
599:                 .Left          = 201
600:                 .Top           = 26
601:                 .Width         = 81
602:                 .Height        = 23
603:                 .ReadOnly      = .T.
604:                 .ForeColor     = RGB(0, 0, 0)
605:                 .DisabledBackColor = RGB(255, 255, 255)
606:                 .Visible       = .T.
607:             ENDWITH
608: 
609:             .AddObject("txt_4c_Empresa", "TextBox")
610:             WITH .txt_4c_Empresa
611:                 .ControlSource = "tmpnens.emps"
612:                 .Left          = 5
613:                 .Top           = 26
614:                 .Width         = 36
615:                 .Height        = 23
616:                 .ReadOnly      = .T.
617:                 .ForeColor     = RGB(0, 0, 0)
618:                 .DisabledBackColor = RGB(255, 255, 255)
619:                 .Visible       = .T.
620:             ENDWITH
621: 
622:             .AddObject("txt_4c_Operacao", "TextBox")
623:             WITH .txt_4c_Operacao
624:                 .ControlSource = "tmpnens.dopps"
625:                 .Left          = 43
626:                 .Top           = 26
627:                 .Width         = 156
628:                 .Height        = 23
629:                 .ReadOnly      = .T.
630:                 .ForeColor     = RGB(0, 0, 0)
631:                 .DisabledBackColor = RGB(255, 255, 255)
632:                 .Visible       = .T.
633:             ENDWITH
634: 
635:             .AddObject("lin_4c_Line1", "Line")
636:             WITH .lin_4c_Line1
637:                 .BorderWidth = 2
638:                 .Height      = 0
639:                 .Left        = 4

*-- Linhas 714 a 734:
714:             .Visible     = .T.
715:         ENDWITH
716: 
717:         *-- txt_4c_DescOrig (getDescOrig, dump 450-459) - ControlSource
718:         *-- atribuido em CarregarLista() (cursor_4c_Distrib ainda nao existe
719:         *-- aqui - regra "ControlSource antes do cursor existir")
720:         THIS.AddObject("txt_4c_DescOrig", "TextBox")
721:         WITH THIS.txt_4c_DescOrig
722:             .Top               = 541
723:             .Left              = 217
724:             .Width             = 150
725:             .Height            = 22
726:             .ReadOnly          = .T.
727:             .ForeColor         = RGB(0, 0, 0)
728:             .DisabledBackColor = RGB(255, 255, 255)
729:             .Visible           = .T.
730:         ENDWITH
731: 
732:         *-- txt_4c_DescDest (getDescDest, dump 836-845)
733:         THIS.AddObject("txt_4c_DescDest", "TextBox")
734:         WITH THIS.txt_4c_DescDest

*-- Linhas 761 a 779:
761:             .Visible   = .T.
762:         ENDWITH
763: 
764:         *-- txt_4c_Descr (Get_descr, dump 437-446) - ControlSource atribuido
765:         *-- em CarregarLista(), mesmo motivo de txt_4c_DescOrig/DescDest
766:         THIS.AddObject("txt_4c_Descr", "TextBox")
767:         WITH THIS.txt_4c_Descr
768:             .Top               = 540
769:             .Left              = 541
770:             .Width             = 241
771:             .Height            = 23
772:             .ReadOnly          = .T.
773:             .ForeColor         = RGB(0, 0, 0)
774:             .DisabledBackColor = RGB(255, 255, 255)
775:             .Visible           = .T.
776:         ENDWITH
777: 
778:         *-- txt_4c_QtdTot (getQtdTot, dump 798-813) - totalizador de
779:         *-- quantidade, preenchido por AtualizarTotais(); When = "Return .f."

*-- Linhas 832 a 879:
832:     *--------------------------------------------------------------------------
833:     * CarregarLista - Monta this_cCursorDistrib via SigPrSerBO.CarregarDistribuicao()
834:     * e liga a grade a ele (equivalente ao bloco final do Init legado, dump
835:     * 945-964: "Select TmpDistrib / Go Top / With ThisForm.Grade / ...").
836:     *
837:     * RecordSource/ControlSource RESETAM Column.Width e Header1.Caption em
838:     * VFP9 (CLAUDE.md - "Grade perdendo cabecalhos apos RecordSource") -
839:     * por isso Width/Caption sao reaplicados IMEDIATAMENTE depois do bind,
840:     * repetindo os mesmos valores de ConfigurarPaginaLista().
841:     *--------------------------------------------------------------------------
842:     PROCEDURE CarregarLista()
843:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
844:         loc_lSucesso = .F.
845: 
846:         TRY
847:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
848: 
849:                 IF THIS.this_oBusinessObject.CarregarDistribuicao()
850:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorDistrib
851: 
852:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
853:                         THIS.grd_4c_Dados.RecordSource = loc_cCursor
854: 
855:                         WITH THIS.grd_4c_Dados
856:                             .Column1.ControlSource = loc_cCursor + ".Empdnps"
857:                             .Column2.ControlSource = loc_cCursor + ".Grupoos"
858:                             .Column7.ControlSource = loc_cCursor + ".Contaos"
859:                             .Column8.ControlSource = loc_cCursor + ".Grupods"
860:                             .Column9.ControlSource = loc_cCursor + ".Contads"
861:                             .Column3.ControlSource = loc_cCursor + ".Cmats"
862:                             .Column4.ControlSource = loc_cCursor + ".Qtds"
863:                             .Column5.ControlSource = loc_cCursor + ".Fators"
864:                             .Column6.ControlSource = loc_cCursor + ".Qtds * " + loc_cCursor + ".Fators"
865: 
866:                             *-- Reaplica Width/Caption apos o bind (reset do VFP9)
867:                             .Column1.Width = 241
868:                             .Column2.Width = 80
869:                             .Column7.Width = 80
870:                             .Column8.Width = 80
871:                             .Column9.Width = 80
872:                             .Column3.Width = 108
873:                             .Column4.Width = 80
874:                             .Column5.Width = 80
875:                             .Column6.Width = 108
876: 
877:                             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
878:                             .Column2.Header1.Caption = "Grupo"
879:                             .Column7.Header1.Caption = "Conta"

*-- Linhas 902 a 933:
902: 
903:                     *-- txt_4c_Descr/DescOrig/DescDest espelham a linha
904:                     *-- corrente de cursor_4c_Distrib (Dpros/DescOrig/
905:                     *-- DescDest) - mesmo motivo do ControlSource da grade,
906:                     *-- so existe apos o cursor ser criado por
907:                     *-- CarregarDistribuicao(). PEMSTATUS porque esses
908:                     *-- TextBox so passam a existir a partir da Fase 6.
909:                     IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
910:                         THIS.txt_4c_Descr.ControlSource = loc_cCursor + ".Dpros"
911:                         THIS.txt_4c_Descr.Refresh()
912:                     ENDIF
913:                     IF PEMSTATUS(THIS, "txt_4c_DescOrig", 5)
914:                         THIS.txt_4c_DescOrig.ControlSource = loc_cCursor + ".DescOrig"
915:                         THIS.txt_4c_DescOrig.Refresh()
916:                     ENDIF
917:                     IF PEMSTATUS(THIS, "txt_4c_DescDest", 5)
918:                         THIS.txt_4c_DescDest.ControlSource = loc_cCursor + ".DescDest"
919:                         THIS.txt_4c_DescDest.Refresh()
920:                     ENDIF
921: 
922:                     THIS.this_oBusinessObject.Acumular()
923:                     THIS.AtualizarTotais()
924: 
925:                     loc_lSucesso = .T.
926:                 ELSE
927:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
928:                             "Erro ao Carregar Servi" + CHR(231) + "os Lan" + CHR(231) + "ados")
929:                 ENDIF
930:             ENDIF
931: 
932:         CATCH TO loc_oErro
933:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 970 a 988:
970:     * evento, CLAUDE.md regra #46): txt_4c_Descr/DescOrig/DescDest, que
971:     * espelham Dpros/DescOrig/DescDest da linha corrente de cursor_4c_Distrib.
972:     * O legado so refresca Get_Descr porque getDescOrig/getDescDest nao tinham
973:     * esse Refresh explicito no dump - mas como os tres sao ControlSource
974:     * direto sobre a MESMA linha corrente do cursor, repetir o Refresh nos
975:     * tres evita que origem/destino fiquem um passo atras do servico ao
976:     * navegar na grade. Metodo PUBLIC (sem PROTECTED) - exigencia do
977:     * BINDEVENT (CLAUDE.md regra #3), com o parametro do evento declarado.
978:     *--------------------------------------------------------------------------
979:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
980:         IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
981:             THIS.txt_4c_Descr.Refresh()
982:         ENDIF
983:         IF PEMSTATUS(THIS, "txt_4c_DescOrig", 5)
984:             THIS.txt_4c_DescOrig.Refresh()
985:         ENDIF
986:         IF PEMSTATUS(THIS, "txt_4c_DescDest", 5)
987:             THIS.txt_4c_DescDest.Refresh()
988:         ENDIF


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servicos Lancados (SIGPRSER)
*
* Form OPERACIONAL (SIGPRSER / FormSigPrSer): dialogo filho, aberto por um
* formulario pai durante a emissao de uma nota/movimentacao, que exibe os
* servicos ja lancados para o conjunto de operacoes de producao (Nops) em
* processamento - origem/destino de conta, quantidade, fator e valor - e
* totaliza quantidade/valor para conferencia antes de confirmar a nota.
*
* Origem legado (SIGPRSER.SCX): o Init monta o cursor TmpDistrib juntando
* SigPdMvf/SigCdNei/SigCdNec/SigCdPro/SigCdCli (origem e destino), uma
* consulta por Nops presente no cursor xMfas (que o formulario pai ja
* populava na DataSession antes de abrir este dialogo); a grade exibe
* TmpDistrib e o metodo acumula() soma Qtds e (Qtds*Fators) para os
* totalizadores. O bloco de gravacao do botao OK (transferencia para o
* cursor xnensi) esta COMENTADO no legado (*!*) - a acao realmente ativa
* e apenas reabilitar o formulario pai, atualiza-lo e fechar este dialogo.
*
* NAO existe uma unica "tabela principal" para este BO (this_cTabela
* permanece vazio) - ele opera sobre cursores temporarios (cursor_4c_
* Distrib, equivalente a TmpDistrib) montados a partir de varias tabelas,
* igual ao padrao ja adotado em SigPrGlxBO/SigPrGl2BO.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/calculo (CarregarDistribuicao/
*                Acumular/CarregarDoCursor)
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *==========================================================================
    * Cursores de trabalho (nomes) - equivalentes aos cursores do legado que
    * viviam na DataSession compartilhada entre o formulario pai e este
    * dialogo filho.
    *==========================================================================
    this_cCursorOperacoes = "cursor_4c_Operacoes" && Lista de Nops (operacoes de producao) a processar - equivalente ao cursor xMfas, populado pelo formulario pai antes de abrir este dialogo
    this_cCursorDistrib   = "cursor_4c_Distrib"   && Servicos lancados consolidados com origem/destino de conta - equivalente a TmpDistrib

    *==========================================================================
    * Dados do cabecalho da movimentacao atual, exibidos somente leitura na
    * tela (equivalentes ao cursor tmpnens.numps/emps/dopps do legado, que o
    * formulario pai tambem ja deixava preparado).
    *==========================================================================
    this_nNumMov  = 0  && tmpnens.numps - numero da movimentacao/nota em processamento
    this_cEmpMov  = "" && tmpnens.emps  - empresa da movimentacao
    this_cOperMov = "" && tmpnens.dopps - tipo/descricao da operacao da movimentacao

    *==========================================================================
    * Totalizadores calculados a partir de cursor_4c_Distrib (equivalente ao
    * PROCEDURE acumula() do legado, que soma Qtds e Qtds*Fators de
    * TmpDistrib e exibe em getQtdTot/getValtot).
    *==========================================================================
    this_nQtdTotal   = 0 && Soma de Qtds dos servicos lancados
    this_nValorTotal = 0 && Soma de (Qtds * Fators) dos servicos lancados

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *
    * Este BO nao opera sobre uma unica tabela SQL Server: o resultado
    * exibido (cursor_4c_Distrib) vem de um JOIN entre SigPdMvf, SigCdNei,
    * SigCdNec, SigCdPro e SigCdCli (origem e destino), montado por Nops -
    * por isso this_cTabela/this_cCampoChave ficam vazios, igual ao padrao
    * ja adotado em SigPrGlxBO/SigPrGl2BO para dialogos operacionais sem
    * entidade unica.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega os dados de cabecalho da movimentacao em
    * processamento (equivalente a tmpnens.numps/emps/dopps do legado, lidos
    * direto via ControlSource em GetCodigo/GetEmpresa/GetOperacao - Init,
    * dump 886-965). par_cCursor eh o alias do cursor de cabecalho que o
    * formulario PAI ja deixa preparado na DataSession compartilhada (Set
    * DataSession To pForm.DataSessionId) antes de abrir este dialogo - este
    * BO so LE esse cursor, nunca o popula.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF TYPE(par_cAliasCursor + ".numps") != "U"
            THIS.this_nNumMov = TratarNulo(EVALUATE(par_cAliasCursor + ".numps"), 0)
        ENDIF
        IF TYPE(par_cAliasCursor + ".emps") != "U"
            THIS.this_cEmpMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".emps"), ""))
        ENDIF
        IF TYPE(par_cAliasCursor + ".dopps") != "U"
            THIS.this_cOperMov = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".dopps"), ""))
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarDistribuicao - Monta this_cCursorDistrib (equivalente a
    * TmpDistrib) a partir da lista de operacoes de producao presente em
    * this_cCursorOperacoes (equivalente ao cursor xMfas, que o formulario
    * pai ja deixa populado na DataSession compartilhada antes de abrir este
    * dialogo - "Select xMfas / Scan / _nOperacao = xMfas.Nops" no Init
    * legado, dump 913-943).
    *
    * Para cada Nops, repete a mesma consulta (join SigPdMvf/SigCdNei/
    * SigCdNec/SigCdPro/SigCdCli origem e destino) que o legado fazia em
    * LocalMFas4, filtrando so os servicos (b.servicos = 1 and b.cats <> '')
    * e acumulando as linhas no cursor de distribuicao (equivalente ao
    * "Insert into TmpDistrib from memvar" do legado - o bloco alternativo,
    * que so inseria quando TmpDistrib ainda nao tinha aquele Empdnps, esta
    * COMENTADO no legado, *!* linhas 936-941 - por isso NAO reproduzir esse
    * filtro aqui, e acumular toda linha que a consulta devolver).
    *
    * O legado tambem roda essa mesma consulta uma unica vez, sem filtro de
    * Nops e com "where 0=1" (dump 900-911), so para definir a ESTRUTURA de
    * TmpDistrib antes do SCAN. Aqui a estrutura nasce da primeira consulta
    * que devolver linha, ou (se nenhuma operacao casar, ou a lista de
    * operacoes estiver vazia) de uma consulta equivalente com "WHERE 0 = 1"
    * - para que a grade sempre tenha RecordSource valido mesmo com zero
    * linhas, que eh resultado normal (nao erro).
    *==========================================================================
    FUNCTION CarregarDistribuicao()
        LOCAL loc_lSucesso, loc_cAliasAnt, loc_nNops, loc_cSQL, loc_cSQLBase, ;
            loc_nResultado, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso  = .F.
        loc_cAliasAnt = ""

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cSQLBase = "SELECT b.Empdnps, c.Grupoos, c.Contaos, c.Grupods, c.Contads, " + ;
            "b.Cmats, b.Fators, b.Qtds, b.Cretrabs, c.Retrabs, b.CDescs, d.Dpros, " + ;
            "e.Rclis AS DescOrig, f.Rclis AS DescDest " + ;
            "FROM SigPdMvf a " + ;
            "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
            "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
            "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
            "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
            "INNER JOIN SigCdCli f ON c.Contads = f.Iclis "

        TRY
            loc_cAliasAnt = ALIAS()

            IF USED(THIS.this_cCursorDistrib)
                USE IN (THIS.this_cCursorDistrib)
            ENDIF
            IF USED("cursor_4c_DistribTmp")
                USE IN cursor_4c_DistribTmp
            ENDIF

            IF USED(THIS.this_cCursorOperacoes) AND RECCOUNT(THIS.this_cCursorOperacoes) > 0

                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    loc_nNops = TratarNulo(EVALUATE(THIS.this_cCursorOperacoes + ".Nops"), 0)

                    loc_cSQL = loc_cSQLBase + ;
                        "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                        " AND b.Servicos = 1 AND b.Cats <> ''"

                    IF USED("cursor_4c_DistribTmp")
                        USE IN cursor_4c_DistribTmp
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DistribTmp")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(Text - LocalMFas4) " + CapturarErroSQL()
                        EXIT
                    ENDIF

                    IF USED("cursor_4c_DistribTmp") AND RECCOUNT("cursor_4c_DistribTmp") > 0
                        IF !USED(THIS.this_cCursorDistrib)
                            SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                                INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                        ENDIF
                        SELECT (THIS.this_cCursorDistrib)
                        APPEND FROM DBF("cursor_4c_DistribTmp")
                    ENDIF

                    SELECT (THIS.this_cCursorOperacoes)
                ENDSCAN

                IF USED("cursor_4c_DistribTmp")
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            IF EMPTY(THIS.this_cMensagemErro) AND !USED(THIS.this_cCursorDistrib)
                *-- Lista de operacoes vazia, ou nenhuma linha casou com o
                *-- filtro de servicos - cursor nasce vazio, com estrutura
                *-- valida (equivalente ao "where 0=1" do Init legado)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLBase + "WHERE 0 = 1", "cursor_4c_DistribTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "(Text - TmpDistrib) " + CapturarErroSQL()
                ELSE
                    SELECT * FROM cursor_4c_DistribTmp WHERE .F. ;
                        INTO CURSOR (THIS.this_cCursorDistrib) READWRITE
                    USE IN cursor_4c_DistribTmp
                ENDIF
            ENDIF

            loc_lSucesso = EMPTY(THIS.this_cMensagemErro) AND USED(THIS.this_cCursorDistrib)

            IF USED(THIS.this_cCursorDistrib)
                GO TOP IN (THIS.this_cCursorDistrib)
            ENDIF

            IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
                SELECT (loc_cAliasAnt)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Acumular - Recalcula os totalizadores exibidos no rodape da tela
    * (getQtdTot/getValtot) a partir de this_cCursorDistrib - transcricao do
    * PROCEDURE acumula() do legado (dump 871-881):
    *   Select Sum(qtds) as qtds, Sum(qtds * fators) as vrpags From
    *   tmpDistrib Into Cursor curt
    * Com o cursor de distribuicao vazio, SUM() devolve NULL (equivalente ao
    * .NULL. que o legado tambem gravaria no textbox) - TratarNulo normaliza
    * para 0, mantendo os totalizadores coerentes com uma lista vazia.
    *==========================================================================
    FUNCTION Acumular()
        LOCAL loc_lSucesso, loc_cAliasAnt

        THIS.this_nQtdTotal   = 0
        THIS.this_nValorTotal = 0
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorDistrib)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        IF USED("cursor_4c_Totais")
            USE IN cursor_4c_Totais
        ENDIF

        SELECT SUM(Qtds) AS Qtds, SUM(Qtds * Fators) AS VrPags ;
            FROM (THIS.this_cCursorDistrib) ;
            INTO CURSOR cursor_4c_Totais

        IF USED("cursor_4c_Totais")
            THIS.this_nQtdTotal   = TratarNulo(cursor_4c_Totais.Qtds, 0)
            THIS.this_nValorTotal = TratarNulo(cursor_4c_Totais.VrPags, 0)
            USE IN cursor_4c_Totais
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor() ja esta implementado acima (dados de cabecalho,
    * somente leitura). ObterChavePrimaria() / Inserir() / Atualizar() /
    * ExecutarExclusao(): este BO deliberadamente NAO sobrescreve esses
    * quatro metodos do BusinessBase.
    *
    * SIGPRSER eh um dialogo filho de PREVIA (conferencia de servicos ja
    * lancados antes de confirmar a nota do form pai) - nao um cadastro. No
    * legado, o bloco que de fato gravaria algo (OK.Click: transferencia de
    * TmpDistrib para o cursor xnensi, dump 1030-1072) esta INTEIRO dentro
    * de comentarios "*!*", ou seja, codigo morto, desativado pela propria
    * equipe Fortyus. A UNICA acao viva do botao OK eh:
    *   ThisForm.ParentForm.Enabled = .t.
    *   Select xnensi / Go Bott
    *   ThisForm.ParentForm.Refresh
    *   ThisForm.Release
    * ou seja: reabilitar e atualizar o formulario pai, e fechar este
    * dialogo - nenhuma gravacao em tabela acontece. Essa acao pertence ao
    * FORM (FormSigPrSer.BtnOkClick), nao ao BO: nao ha "registro desta
    * entidade" para Salvar()/Excluir() persistirem.
    *
    * Os stubs herdados de BusinessBase (que devolvem .F. com mensagem de
    * erro, e ObterChavePrimaria() devolvendo "") permanecem corretos, pois
    * Salvar()/Excluir() nunca sao acionados por este form - ver mesma
    * decisao, pelo mesmo motivo, em SigPrGlxBO.prg/SigPrGl2BO.prg.
    *==========================================================================

ENDDEFINE

