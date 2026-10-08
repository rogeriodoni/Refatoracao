# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMBS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMBS

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
  DeleteMark = .F.
	lcQuery = [Select Cods, Multis From SigCdEmb]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdEmb]) < 1)
	Select crSigCdEmb
	loBarra.Update(.t., [Gerando Informações Para Lançamento])
	Select csCabec
	Insert Into crSigMvCab From Memvar
	Insert Into CrSigInBep From Memvar
	loBarra.Update(.t., [Gerando Informações Dos Itens])
	Select csItens
		Select csItens
		Insert Into crSigMvItn From Memvar
		=Seek(crTmpPro.cUnis, [crSigCdEmb], [Cods])
			Insert Into crSigMvIts From Memvar
	Select CsEstPe
		Insert Into CrSigMvPec From Memvar
	loBarra.Update(.t., [Preparando Gravação])
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvCab')
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvItn')
	If llOks And Not ThisForm.poDataMgr.UpDate('crSigMvIts')
	If llOks And Not ThisForm.poDataMgr.UpDate('CrSigMvPec')
	If llOks And Not ThisForm.poDataMgr.UpDate('CrSigInBep')
	Select csItens
	Select csCabec
Select CsCabec
Select CsItens
Select CsCabec
	.Column1.ControlSource = [csCabec.EmpDs]
	.Column7.ControlSource = [csCabec.Dopes]
	.Column2.ControlSource = [csCabec.GrupoOs]
	.Column3.ControlSource = [csCabec.ContaOs]
	.Column5.ControlSource = [csCabec.GrupoDs]
	.Column4.ControlSource = [csCabec.ContaDs]
	.Column6.ControlSource = [csCabec.Gerado]
	.Column1.ControlSource = [csItens.CItens]
	.Column2.ControlSource = [csItens.CPros]
	.Column3.ControlSource = [csItens.DPros]
	.Column4.ControlSource = [csItens.Moedas]
	.Column5.ControlSource = [csItens.Units]
	.Column6.ControlSource = [csItens.Qtds]
	.Column7.ControlSource = [csItens.Totas]
Select CsItens
Select Emps, Dopes, Numes ;
  From csCabec ;
Select csCabec

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg) - TRECHOS RELEVANTES PARA PASS SQL (1311 linhas total):

*-- Linhas 212 a 230:
212:     *                     fwBuscaExt/fwBuscaSel/mAddColuna/sigacess/Acesso* -
213:     *                     o unico CreateObject do form eh fwprogressbar, dentro
214:     *                     de gerarpedido. Inventar uma Page2 de Dados, um campo
215:     *                     com ControlSource ou um lookup para alguma tabela
216:     *                     auxiliar violaria o PILAR 1 e a regra explicita
217:     *                     "NUNCA inventar tabelas de lookup que nao existem no
218:     *                     original"; metodo de lookup vazio seria stub
219:     *                     disfarcado. O dado de ENTRADA desta tela eh a LINHA
220:     *                     selecionada em csCabec - e eh isso que a fase
221:     *                     entrega: SincronizarPedidoCorrente() (a linha
222:     *                     corrente alimentando as propriedades do BO, nos dois
223:     *                     caminhos que a mudam), ValidarPedidoSelecionado() e
224:     *                     ValidarSaidaSemConfirmar() (os dois guards
225:     *                     transcritos do topo de CmdGrava.Click e de
226:     *                     CmdCancela.Click, que a Fase 7 vai chamar), os
227:     *                     membros publicos pcEscolha/GrupoOper e o metodo de
228:     *                     contrato ProcessaPeriodo() (ClassInfo do SCX).
229:     *   Fase 7 (esta)  - BINDEVENT de Click em cmd_4c_CmdGrava/cmd_4c_CmdCancela
230:     *                     (BtnConfirmarClick: ValidarPedidoSelecionado() ->

*-- Linhas 246 a 267:
246:     *
247:     * ATENCAO ao mapear as colunas do dump: o SCX guarda a ORDEM FISICA dos
248:     * registros de coluna com "ColumnN.Name = ColumnM", e o legado referencia
249:     * as colunas pelo NOME (With ThisForm.GrdCab / .Column3.ControlSource),
250:     * exibindo-as na ordem de ColumnOrder. No GrdCab os dois nao coincidem:
251:     *
252:     *   ColumnOrder | objeto legado | Header          | Width | ControlSource
253:     *   ------------+---------------+-----------------+-------+---------------
254:     *        1      | Column1       | Emp             |    35 | csCabec.EmpDs
255:     *        2      | Column7       | Movimentacao    |   225 | csCabec.Dopes
256:     *        3      | Column2       | Grupo Origem    |   100 | csCabec.GrupoOs
257:     *        4      | Column3       | Conta Origem    |   100 | csCabec.ContaOs
258:     *        5      | Column5       | Grupo Destino   |   100 | csCabec.GrupoDs
259:     *        6      | Column4       | Conta Destino   |   100 | csCabec.ContaDs
260:     *        7      | Column6       | Confirmacao     |   100 | csCabec.Gerado
261:     *
262:     * (35+225+5*100 = 760, dentro do Width=798 da grade). Aqui as colunas sao
263:     * criadas por POSICAO (.Column1 .. .Column7 de um Grid com ColumnCount=7),
264:     * entao a posicao N recebe o que o legado exibe em ColumnOrder = N - e NAO
265:     * o registro N do dump. No GrdIte as duas ordens coincidem (ColumnOrder 1
266:     * a 7 = Column1 a Column7), mas as larguras tambem precisam vir por NOME:
267:     * 36 / 120 / 403 / 23 / 130 / 100 / 130 (soma 942, Width=980).

*-- Linhas 291 a 309:
291:                 .ColumnCount       = 7
292:                 .AllowHeaderSizing = .F.
293:                 .AllowRowSizing    = .F.
294:                 .DeleteMark        = .F.
295:                 .RecordMark        = .F.
296:                 .ReadOnly          = .T.
297:                 .HeaderHeight      = 15
298:                 .RowHeight         = 16
299:                 .ScrollBars        = 2
300:                 .TabStop           = .F.
301:                 .GridLineColor     = RGB(238, 238, 238)
302:                 .Visible           = .T.
303:             ENDWITH
304: 
305:             *-- Colunas/cabecalhos. O ReadOnly de cada coluna fica em
306:             *-- FormatarGridCabecalho porque tem de vir DEPOIS do
307:             *-- Grid.ReadOnly acima, que propaga para as colunas
308:             THIS.FormatarGridCabecalho()
309: 

*-- Linhas 324 a 375:
324:                 .ColumnCount       = 7
325:                 .AllowHeaderSizing = .F.
326:                 .AllowRowSizing    = .F.
327:                 .DeleteMark        = .F.
328:                 .RecordMark        = .F.
329:                 .ReadOnly          = .T.
330:                 .HeaderHeight      = 15
331:                 .RowHeight         = 16
332:                 .ScrollBars        = 2
333:                 .TabStop           = .F.
334:                 .GridLineColor     = RGB(238, 238, 238)
335:                 .Visible           = .T.
336:             ENDWITH
337: 
338:             THIS.FormatarGridItens()
339: 
340:             *-- Carga inicial: equivalente ao bloco final do Init legado
341:             *-- (Select CsCabec / Go Top / Select CsItens / Set Key To ... /
342:             *--  With ThisForm.GrdCab ... / With ThisForm.GrdIte ...)
343:             THIS.CarregarLista()
344:         CATCH TO loc_oErro
345:             MsgErro(loc_oErro.Message + CHR(13) + ;
346:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
347:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrids")
348:         ENDTRY
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------
352:     * FormatarGridCabecalho - Width / Header1.Caption / ReadOnly / Text1 de
353:     * TODAS as colunas de grd_4c_GrdCab.
354:     *
355:     * Metodo separado porque esse bloco precisa rodar DUAS vezes: na montagem
356:     * (ConfigurarGrids) e depois de CADA bind de RecordSource/ControlSource em
357:     * CarregarLista() - o VFP9 reseta Column.Width, Header1.Caption e
358:     * Column.ReadOnly para os defaults quando a fonte de dados da grade muda
359:     * (Problema 48 de FORMCOR_LICOES_APRENDIDAS.md; CLAUDE.md regra #43.1).
360:     * Por isso Width vem SEMPRE depois do ControlSource, nunca antes.
361:     *
362:     * Movable/Resizable: o dump declara .F. apenas nas colunas legado
363:     * Column1/Column2/Column4/Column5/Column6 - as legado Column3
364:     * (Conta Origem, posicao 4) e Column7 (Movimentacao, posicao 2) nao os
365:     * declaram e ficam no default .T. A assimetria eh do SCX legado, nao
366:     * descuido da migracao (AllowHeaderSizing = .F. no Grid ja bloqueia o
367:     * redimensionamento na pratica).
368:     *--------------------------------------------------------------------------
369:     PROTECTED PROCEDURE FormatarGridCabecalho()
370:         WITH THIS.grd_4c_GrdCab
371: 
372:             *-- Posicao 1 (legado Column1) - Emp
373:             WITH .Column1
374:                 .FontName  = "Tahoma"
375:                 .FontSize  = 8

*-- Linhas 620 a 689:
620:     * as duas no primeiro registro. Transcricao do bloco final do Init legado
621:     * (SigPrGst_form_codigo_fonte.txt, PROCEDURE Init):
622:     *
623:     *     Select CsCabec / Go Top
624:     *     Select CsItens / Set Key To CsCabec.EmpdopNums / Go Top
625:     *     Select CsCabec
626:     *     With ThisForm.GrdCab ... RecordSource + 7 ControlSource +
627:     *                             SetAll DynamicBackColor + Refresh
628:     *     With ThisForm.GrdIte ... RecordSource + 7 ControlSource + Refresh
629:     *
630:     * csCabec/csItens NAO sao abertos aqui: quem os popula eh o form que abre
631:     * esta tela (ver cabecalho do arquivo). O guard USED() existe porque
632:     * atribuir RecordSource/ControlSource a um alias inexistente derruba o
633:     * Init com "Alias ... is not found" e o form nunca abre (CLAUDE.md regra
634:     * #41) - eh o que aconteceria em ValidarUIFidelity/gb_4c_ModoTeste, que
635:     * instanciam o form sem form pai. Sem os cursores as grades ficam com as
636:     * colunas formatadas e RecordSource vazio, que eh o estado correto.
637:     *
638:     * PUBLIC (sem PROTECTED) de proposito: TesteAutomatico.prg chama
639:     * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS(...,5) devolve
640:     * .T. mesmo para metodo PROTECTED - o harness entraria no branch e a
641:     * chamada falharia em runtime (CLAUDE.md regra #3).
642:     *--------------------------------------------------------------------------
643:     FUNCTION CarregarLista()
644:         LOCAL loc_lSucesso, loc_oErro
645:         loc_lSucesso = .F.
646: 
647:         TRY
648:             IF USED("csCabec")
649:                 SELECT csCabec
650:                 GO TOP
651: 
652:                 WITH THIS.grd_4c_GrdCab
653:                     .RecordSourceType      = 1
654:                     .RecordSource          = "csCabec"
655:                     .Column1.ControlSource = "csCabec.EmpDs"
656:                     .Column2.ControlSource = "csCabec.Dopes"
657:                     .Column3.ControlSource = "csCabec.GrupoOs"
658:                     .Column4.ControlSource = "csCabec.ContaOs"
659:                     .Column5.ControlSource = "csCabec.GrupoDs"
660:                     .Column6.ControlSource = "csCabec.ContaDs"
661:                     .Column7.ControlSource = "csCabec.Gerado"
662: 
663:                     *-- Linha amarelada no pedido JA gerado (transcrito do
664:                     *-- SetAll do Init legado)
665:                     .SetAll("DynamicBackColor", ;
666:                         "IIF(EMPTY(csCabec.Gerado), RGB(255,255,255), RGB(255,255,204))", ;
667:                         "Column")
668:                 ENDWITH
669: 
670:                 *-- O bind acima reseta Width/Header1.Caption/ReadOnly das
671:                 *-- colunas: reaplicar ANTES do Refresh
672:                 THIS.FormatarGridCabecalho()
673: 
674:                 SELECT csCabec
675:                 GO TOP
676:                 THIS.grd_4c_GrdCab.Refresh()
677:             ENDIF
678: 
679:             *-- Pedido corrente (linha de csCabec) -> propriedades do BO
680:             THIS.SincronizarPedidoCorrente()
681: 
682:             *-- Grade de itens (escopada pelo pedido corrente de csCabec)
683:             THIS.CarregarItensPedido()
684: 
685:             loc_lSucesso = .T.
686:         CATCH TO loc_oErro
687:             MsgErro(loc_oErro.Message + CHR(13) + ;
688:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
689:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarLista")

*-- Linhas 700 a 755:
700:     * visualmente parada ao trocar de pedido (CLAUDE.md regra #21a).
701:     *
702:     * SET KEY TO depende da ordem ativa em csItens, criada pelo form pai junto
703:     * com o cursor (o legado conta com ela: "Select CsItens / Set Key To
704:     * CsCabec.EmpdopNums"). O teste de ORDER() nao existe no legado - ele
705:     * evita que a tela morra quando o form eh instanciado sem form pai
706:     * (ValidarUIFidelity/gb_4c_ModoTeste), caso em que nao ha o que escopar.
707:     *
708:     * PUBLIC: chamado pelo handler ligado por BINDEVENT (CLAUDE.md regra #3).
709:     *--------------------------------------------------------------------------
710:     FUNCTION CarregarItensPedido()
711:         LOCAL loc_lSucesso, loc_oErro
712:         loc_lSucesso = .F.
713: 
714:         TRY
715:             IF USED("csItens")
716:                 WITH THIS.grd_4c_GrdIte
717:                     .RecordSourceType      = 1
718:                     .RecordSource          = "csItens"
719:                     .Column1.ControlSource = "csItens.CItens"
720:                     .Column2.ControlSource = "csItens.CPros"
721:                     .Column3.ControlSource = "csItens.DPros"
722:                     .Column4.ControlSource = "csItens.Moedas"
723:                     .Column5.ControlSource = "csItens.Units"
724:                     .Column6.ControlSource = "csItens.Qtds"
725:                     .Column7.ControlSource = "csItens.Totas"
726:                 ENDWITH
727: 
728:                 *-- Reaplicar apos o bind (ver FormatarGridCabecalho)
729:                 THIS.FormatarGridItens()
730: 
731:                 SELECT csItens
732:                 IF USED("csCabec") AND !EMPTY(ORDER("csItens"))
733:                     SET KEY TO csCabec.EmpdopNums
734:                 ENDIF
735:                 GO TOP
736: 
737:                 *-- Devolve o alias corrente para a grade de cabecalho, como o
738:                 *-- legado faz ("Select CsCabec" antes de montar GrdCab)
739:                 IF USED("csCabec")
740:                     SELECT csCabec
741:                 ENDIF
742: 
743:                 THIS.grd_4c_GrdIte.Refresh()
744:             ENDIF
745: 
746:             loc_lSucesso = .T.
747:         CATCH TO loc_oErro
748:             MsgErro(loc_oErro.Message + CHR(13) + ;
749:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
750:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.CarregarItensPedido")
751:         ENDTRY
752: 
753:         RETURN loc_lSucesso
754:     ENDFUNC
755: 

*-- Linhas 784 a 802:
784:     * que o usuario informa" eh QUAL LINHA de csCabec esta selecionada, e eh
785:     * exatamente isso que o legado propaga quando escopa os itens:
786:     *
787:     *     Select CsItens
788:     *     Set Key To CsCabec.EmpdopNums
789:     *
790:     * Dai a chave do pedido corrente ser o dado de entrada deste form. O BO
791:     * declara as tres propriedades desde a Fase 1 e nada as alimentava; sem
792:     * este funil, ObterChavePrimaria() (usada pela auditoria de
793:     * BusinessBase) devolve a chave VAZIA e o registro de auditoria da
794:     * geracao sai sem identificar o pedido - falha silenciosa, sem erro na
795:     * tela. GerarPedido() le csCabec direto, como o legado, entao a geracao
796:     * em si nao depende disto - a auditoria sim.
797:     *
798:     * Chamado nos DOIS caminhos que mudam o pedido corrente: a carga inicial
799:     * (CarregarLista) e a troca de linha na grade (GrdCabAfterRowColChange) -
800:     * mesmo funil unico de CarregarItensPedido (CLAUDE.md regra #40: quem
801:     * muda estado repoe em CADA caminho, nunca so no primeiro).
802:     *

*-- Linhas 841 a 859:
841:     * ValidarPedidoSelecionado - guard do pedido corrente, transcrito do
842:     * TOPO de SIGPRGST.CmdGrava.Click (dump legado):
843:     *
844:     *     Select csCabec
845:     *     If Eof([csCabec])
846:     *         =MessageBox([Selecione Um Pedido a Ser Gerado Na Grade e Tente
847:     *                      Novamente], 16, [Atencao!!!])
848:     *         Return .f.
849:     *     EndIf
850:     *
851:     * Devolve .T. quando ha pedido corrente e a geracao pode prosseguir; .F.
852:     * depois de ja ter avisado o usuario. Quem chama eh o Click de
853:     * cmd_4c_CmdGrava (fase de eventos), ANTES de
854:     * this_oBusinessObject.GerarPedido().
855:     *
856:     * O texto da mensagem eh o do legado, palavra por palavra. Vai em
857:     * MsgAviso (dialogo amarelo) e nao em MsgErro: eh validacao de UI
858:     * ("Selecione um registro"), nao excecao tecnica - o legado usa icone 16
859:     * (critico), desvio consciente e documentado para seguir o padrao de

*-- Linhas 881 a 899:
881:                 MsgAviso("Nenhum pedido carregado para gera" + CHR(231) + CHR(227) + "o.", ;
882:                     "Aten" + CHR(231) + CHR(227) + "o")
883:             ELSE
884:                 SELECT csCabec
885: 
886:                 IF EOF("csCabec")
887:                     MsgAviso("Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente", ;
888:                         "Aten" + CHR(231) + CHR(227) + "o")
889:                 ELSE
890:                     *-- Pedido corrente valido: alinhar o BO com a linha antes
891:                     *-- de entregar o fluxo para GerarPedido()
892:                     THIS.SincronizarPedidoCorrente()
893:                     loc_lValido = .T.
894:                 ENDIF
895:             ENDIF
896:         CATCH TO loc_oErro
897:             MsgErro(loc_oErro.Message + CHR(13) + ;
898:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
899:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrGst.ValidarPedidoSelecionado")

*-- Linhas 906 a 924:
906:     * ValidarSaidaSemConfirmar - guard da saida, transcrito de
907:     * SIGPRGST.CmdCancela.Click (dump legado):
908:     *
909:     *     Select Emps, Dopes, Numes From csCabec Where Empty(Gerado) ;
910:     *       Into Cursor LocalGerado
911:     *     lnFal = Reccount([LocalGerado])
912:     *     If (lnFal > 0)
913:     *         If MessageBox([Existem ] + Alltrim(Str(lnFal,10)) +
914:     *                       [ Operacoes Nao Confirmadas!] + Chr(13) +
915:     *                       [Tem Certeza Que Nao Deseja Gerar Esses Pedidos?],
916:     *                       4+32+256, [Atencao!!!]) <> 6
917:     *             Return .f.
918:     *         Else
919:     *             fGravarLog([T], CrSigCdNec.Dopps, [AUTOMATICO],
920:     *                        [A Geracao de ] + Alltrim(Str(lnFal,10)) +
921:     *                        [ Operacao Foi Cancelada Sem Confirmacao])
922:     *         EndIf
923:     *     EndIf
924:     *     ThisForm.Release

*-- Linhas 955 a 984:
955:                     USE IN cursor_4c_NaoGerados
956:                 ENDIF
957: 
958:                 SELECT Emps, Dopes, Numes ;
959:                     FROM csCabec ;
960:                     WHERE EMPTY(Gerado) ;
961:                     INTO CURSOR cursor_4c_NaoGerados
962: 
963:                 loc_nFal = IIF(USED("cursor_4c_NaoGerados"), RECCOUNT("cursor_4c_NaoGerados"), 0)
964: 
965:                 IF USED("cursor_4c_NaoGerados")
966:                     USE IN cursor_4c_NaoGerados
967:                 ENDIF
968: 
969:                 SELECT csCabec
970: 
971:                 IF loc_nFal > 0
972:                     loc_cQtd = ALLTRIM(STR(loc_nFal, 10))
973: 
974:                     IF MsgConfirma("Existem " + loc_cQtd + " Opera" + CHR(231) + CHR(245) + "es N" + ;
975:                             CHR(227) + "o Confirmadas!" + CHR(13) + ;
976:                             "Tem Certeza Que N" + CHR(227) + "o Deseja Gerar Esses Pedidos?", ;
977:                             "Aten" + CHR(231) + CHR(227) + "o")
978: 
979:                         *-- Usuario confirmou abandonar: registrar o abandono,
980:                         *-- como o legado faz antes do Release
981:                         loc_cDopps = ""
982:                         IF USED("CrSigCdNec")
983:                             loc_cDopps = TratarNulo(CrSigCdNec.Dopps, "")
984:                         ENDIF

*-- Linhas 1125 a 1143:
1125:     *--------------------------------------------------------------------------
1126:     * BtnConfirmarClick - transcricao de SIGPRGST.CmdGrava.Click (dump legado):
1127:     *
1128:     *     Select csCabec
1129:     *     If Eof([csCabec])
1130:     *         =MessageBox([Selecione Um Pedido...], 16, [Atencao!!!])
1131:     *         Return .f.
1132:     *     EndIf
1133:     *     llRet = ThisForm.GerarPedido()
1134:     *     If llRet And Not Empty(csCabec.Gerado)
1135:     *         Do Form SigMvCab With csCabec.GerDopes, csCabec.GerNumes,
1136:     *                               csCabec.GerEmps, .t., 3, ThisForm, .f., .t.
1137:     *     EndIf
1138:     *
1139:     * O guard (Eof) ja esta em ValidarPedidoSelecionado() (Fase 6), que
1140:     * tambem alinha o BO com a linha corrente (SincronizarPedidoCorrente)
1141:     * antes de GerarPedido() ler csCabec. A decisao de abrir a tela de
1142:     * movimentacao usa o MESMO teste do legado - csCabec.Gerado preenchido
1143:     * DEPOIS da chamada, nao this_lGerado do BO - porque csCabec.Gerado fica


### BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):
*============================================================================
* SigPrGstBO.prg - Business Object para Geracao de Movimentacoes de Estoque
* (SIGPRGST)
*
* Form OPERACIONAL (SIGPRGST / FormSigPrGst): tela auxiliar aberta por um
* form pai que ja populou os cursores csCabec/csItens/csEstPe (pedidos de
* movimentacao ainda nao gerados) e CrSigCdNec/CrSigCdEmb (parametros de
* embalagem). O usuario confirma, na grade de csCabec, qual pedido deseja
* gerar; o botao Confirmar chama GerarPedido(), que grava os movimentos
* (SigMvCab/SigMvItn/SigMvIts/SigMvPec/SigInBep) e, com sucesso, abre o
* form SigMvCab (Do Form SigMvCab With csCabec.GerDopes, ...) para o
* usuario revisar a movimentacao recem-gerada.
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - os cursores csCabec/csItens/csEstPe/CrSigCdNec/
* CrSigCdEmb sao preparados por quem abre esta tela (conforme
* tasks/task620/SigPrGst_form_codigo_fonte.txt, Procedure gerarpedido) e o
* BO so os le/atualiza pelo nome, igual ao legado.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - GerarPedido() (gravacao real) + ObterChavePrimaria/
*                MontarChaveEmpDopNums + helpers de persistencia SQL Server
*============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *==========================================================================
    * Estado herdado do form pai (equivalente a ThisForm.PcEscolha e
    * ThisForm.GrupoOper do Init legado - GrupoOper e declarado no SCX mas
    * nao e lido em nenhum metodo com codigo; mantido por paridade)
    *==========================================================================
    this_cPcEscolha      = SPACE(10)  && ThisForm.ParentForm.pcEscolha
    this_cGrupoOper      = SPACE(10)  && ThisForm.GrupoOper (Space(10) no Init legado)

    *==========================================================================
    * Pedido corrente selecionado na grade csCabec (chave usada por
    * GerarPedido/AfterRowColChange para resolver csItens/csEstPe via
    * Set Key To csCabec.EmpdopNums)
    *==========================================================================
    this_cEmps           = SPACE(3)   && csCabec.Emps do registro corrente
    this_cDopes          = SPACE(20)  && csCabec.Dopes do registro corrente
    this_cEmpDopNums     = ""         && csCabec.EmpDopNums do registro corrente

    *==========================================================================
    * Resultado de GerarPedido() - espelha os campos que o legado grava de
    * volta em csCabec apos a geracao (Replace Gerado/GerEmps/GerDopes/
    * GerNumes In csCabec)
    *==========================================================================
    this_lGerado         = .F.        && .T. quando GerarPedido() concluiu com sucesso
    this_cGerEmps        = SPACE(3)   && crSigMvCab.Emps gravado
    this_cGerDopes       = SPACE(20)  && crSigMvCab.Dopes gravado
    this_nGerNumes       = 0          && crSigMvCab.Numes gravado

    *==========================================================================
    * Numeracao/mascara do movimento gerado (lnNum/lcMsk do Gerarpedido
    * legado - fGerUniqueKey/fGerMascara)
    *==========================================================================
    this_nNumeroGerado   = 0          && lnNum
    this_cMascaraNumero  = ""         && lcMsk

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (BO opera sobre os cursores csCabec/csItens/
    * csEstPe/CrSigCdNec/CrSigCdEmb preparados pelo form pai antes de abrir
    * esta tela) - mesmo padrao adotado em SigPrGlxBO.Init.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cPcEscolha  = SPACE(10)
            THIS.this_cGrupoOper  = SPACE(10)

            THIS.this_cEmps       = SPACE(3)
            THIS.this_cDopes      = SPACE(20)
            THIS.this_cEmpDopNums = ""

            THIS.this_lGerado     = .F.
            THIS.this_cGerEmps    = SPACE(3)
            THIS.this_cGerDopes   = SPACE(20)
            THIS.this_nGerNumes   = 0

            THIS.this_nNumeroGerado  = 0
            THIS.this_cMascaraNumero = ""

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() / CarregarDoCursor(): este
    * BO deliberadamente NAO sobrescreve esses metodos do BusinessBase.
    *
    * SIGPRGST nao eh um cadastro: nao existe uma unica tabela/registro que o
    * form carregue, edite e grave via Salvar()/Excluir(). O usuario escolhe,
    * na grade csCabec (preparada por quem abre esta tela - ver cabecalho do
    * arquivo), qual pedido confirmar; a gravacao real ocorre em
    * THIS.GerarPedido() - transcricao de SIGPRGST.gerarpedido (dump do SCX
    * legado, linhas 812-941) - que grava em CINCO tabelas (SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep) dentro de uma unica transacao e
    * chama THIS.RegistrarAuditoria() por conta propria ao concluir com
    * sucesso. Os stubs herdados de BusinessBase (que devolvem .F. com
    * mensagem de erro) permanecem corretos, pois Salvar()/Excluir() nunca
    * sao acionados por este form.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave do movimento efetivado por GerarPedido(),
    * usada por RegistrarAuditoria(). EmpDopNums (Emps+Dopes+Str(Numes,6)) eh
    * a mesma chave composta de SigMvCab.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDopNums(THIS.this_cGerEmps, THIS.this_cGerDopes, THIS.this_nGerNumes)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6) usada por SigMvCab/
    * SigMvItn/SigMvIts/SigMvPec/SigInBep.
    *
    * A chave eh POSICIONAL: o padding faz parte dela. As partes vao com
    * PADR na largura EXATA da coluna do schema, NUNCA com ALLTRIM - com
    * ALLTRIM nas partes a chave encurta e o SELECT que a compara devolve
    * ZERO linhas em silencio (CLAUDE.md regra #42 / Erro177).
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(NVL(par_cEmps, ""), 3) + ;
               PADR(NVL(par_cDopes, ""), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente (o
    * legado chama SqlExecute sem reselecionar depois - SQLEXEC() troca a
    * area selecionada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - SELECT * FROM tabela WHERE campo = valor (equivalente
    * a ThisForm.poDataMgr.Cursorquery do legado). Cursor fica ABERTO; com
    * zero linhas, leitura de campo devolve branco (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, par_uValorChave)
        LOCAL loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao consultar " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (vazio) um cursor READWRITE com a estrutura
    * COMPLETA da tabela informada - garante que PersistirCursor() cubra
    * TODA coluna NOT NULL da tabela destino (CLAUDE.md regra #22), mesmo
    * quando o cursor de origem (csCabec/csItens/csEstPe) nao tem todos os
    * campos da tabela de destino.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_GstEstrut")
            USE IN cursor_4c_GstEstrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_GstEstrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_GstEstrut")
            SELECT * FROM cursor_4c_GstEstrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_GstEstrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Falha ao preparar a estrutura de " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - grava em par_cTabela, linha a linha, TODAS as colunas
    * do cursor local (que AbrirCursorTabela criou com a estrutura completa
    * da tabela). Cursor vazio/inexistente = sucesso sem efeito (nada a
    * gravar) - equivalente a ThisForm.poDataMgr.UpDate('<cursor>').
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Falha ao gravar em " + par_cTabela + ":" + CHR(13) + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarPedido - transcricao de SIGPRGST.gerarpedido (dump do SCX legado,
    * linhas 812-941): efetiva, em SigMvCab/SigMvItn/SigMvIts/SigMvPec/
    * SigInBep, o movimento do pedido CORRENTE de csCabec (linha selecionada
    * na grade do form).
    *
    * csCabec/csItens/csEstPe/CrSigCdNec sao preparados por quem abre esta
    * tela (ver cabecalho do arquivo) - este metodo so os LE pelo nome, como
    * o legado. crSigCdEmb/crSigMvCab/crSigMvItn/crSigMvIts/CrSigMvPec/
    * CrSigInBep/crTmpPro/crTmpGru sao cursores de trabalho LOCAIS, criados
    * e fechados aqui.
    *
    * Se csCabec.Gerado JA estiver preenchido, o legado nao faz nada e
    * devolve sucesso ("If Empty(csCabec.Gerado) ... EndIf / Return llOks") -
    * reproduzido abaixo.
    *--------------------------------------------------------------------------
    FUNCTION GerarPedido()
        LOCAL loc_lOks, loc_oErro, loc_nNum, loc_cMsk, loc_cEmpr, loc_cGerEmps, loc_cGerDopes
        LOCAL loc_cCgrus, loc_cCunis, loc_nTipoEstos, loc_nEmbs, loc_lSub
        LOCAL loc_nMultis, loc_cCodEmbs, loc_cDopps

        loc_lOks = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lGerado       = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            RETURN .F.
        ENDIF

        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione Um Pedido a Ser Gerado Na Grade e Tente Novamente"
            RETURN .F.
        ENDIF

        *-- "If Empty(csCabec.Gerado) ... EndIf / Return llOks" - ja gerado:
        *-- nada a fazer, sucesso (o legado nunca entra no bloco de geracao)
        IF !EMPTY(TratarNulo(csCabec.Gerado, ""))
            RETURN .T.
        ENDIF

        loc_cEmpr = PADR(go_4c_Sistema.cCodEmpresa, 3)

        TRY
            *-- 1. Carrega SigCdEmb (Cods, Multis) - "Select Cods, Multis From SigCdEmb"
            loc_lOks = THIS.ExecutarSQL("SELECT Cods, Multis FROM SigCdEmb", "crSigCdEmb", "crSigCdEmb")

            IF loc_lOks AND USED("crSigCdEmb")
                SELECT crSigCdEmb
                INDEX ON Cods TAG Cods
                GO TOP
            ENDIF

            *-- 2. Cursores de gravacao, vazios, com a estrutura COMPLETA da
            *-- tabela destino (equivalente ao "Zap In crSigMvCab/..." do
            *-- legado - aqui nascem vazios em vez de serem zerados)
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.AbrirCursorTabela("CrSigInBep", "SigInBep")
            ENDIF

            *-- 3. Numeracao do movimento - "lnNum = fGerUniqueKey(...) / lcMsk = fGerMascara(lnNum)"
            IF loc_lOks
                loc_nNum = fGerUniqueKey(ALLTRIM(csCabec.Dopes) + loc_cEmpr)
                loc_cMsk = ALLTRIM(fGerMascara(loc_nNum))

                IF loc_nNum = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a numera" + ;
                        CHR(231) + CHR(227) + "o do movimento."
                    loc_lOks = .F.
                ENDIF
            ENDIF

            *-- 4. Cabecalho - "Select csCabec / Scatter Memvar / ... / Insert Into crSigMvCab From Memvar"
            IF loc_lOks
                SELECT csCabec
                SCATTER MEMVAR MEMO
                m.Numes      = loc_nNum
                m.MascNum    = loc_cMsk
                m.Datars     = DATE()
                m.cIdChaves  = fUniqueIds()
                m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                IF USED("CrSigCdNec")
                    m.EmpDnPs = TratarNulo(CrSigCdNec.EmpDnPs, "")
                ENDIF

                loc_cGerEmps  = PADR(m.Emps, 3)
                loc_cGerDopes = PADR(m.Dopes, 20)

                INSERT INTO crSigMvCab FROM MEMVAR
                INSERT INTO CrSigInBep FROM MEMVAR

                *-- 5. Itens - "Select csItens / Set Key To csCabec.EmpDopNums / Go Top / Scan ... EndScan"
                IF USED("csItens")
                    SELECT csItens
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SELECT csItens
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)

                        INSERT INTO crSigMvItn FROM MEMVAR

                        loc_cCgrus = ""
                        loc_cCunis = ""
                        IF THIS.ConsultarTabela("SigCdPro", "crTmpPro", "Cpros", ALLTRIM(m.Cpros))
                            IF USED("crTmpPro") AND !EOF("crTmpPro")
                                loc_cCgrus = TratarNulo(crTmpPro.Cgrus, "")
                                loc_cCunis = TratarNulo(crTmpPro.cUnis, "")
                            ENDIF
                        ENDIF

                        loc_nTipoEstos = 0
                        loc_nEmbs      = 0
                        IF !EMPTY(loc_cCgrus) AND ;
                                THIS.ConsultarTabela("SigCdGrp", "crTmpGru", "Cgrus", ALLTRIM(loc_cCgrus))
                            IF USED("crTmpGru") AND !EOF("crTmpGru")
                                loc_nTipoEstos = TratarNulo(crTmpGru.TipoEstos, 0)
                                loc_nEmbs      = TratarNulo(crTmpGru.Embs, 0)
                            ENDIF
                        ENDIF

                        loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)

                        IF loc_lSub AND !EMPTY(loc_cCunis)
                            loc_nMultis  = 0
                            loc_cCodEmbs = ""
                            IF USED("crSigCdEmb") AND SEEK(loc_cCunis, "crSigCdEmb", "Cods")
                                loc_nMultis  = TratarNulo(crSigCdEmb.Multis, 0)
                                loc_cCodEmbs = TratarNulo(crSigCdEmb.Cods, "")
                            ENDIF

                            SELECT csItens
                            m.Qtds    = m.Qtds / IIF(loc_nMultis = 0, 1, loc_nMultis)
                            m.CodEmbs = loc_cCodEmbs
                            m.QtdEmbs = loc_nMultis

                            INSERT INTO crSigMvIts FROM MEMVAR
                        ENDIF

                        SELECT csItens
                    ENDSCAN
                    SELECT csItens
                    SET KEY TO
                ENDIF

                *-- 6. Pecas/estoque reservado (CsEstPe) - mesmo padrao do item anterior
                IF USED("csEstPe")
                    SELECT csEstPe
                    SET KEY TO csCabec.EmpdopNums
                    GO TOP
                    SCAN
                        SCATTER MEMVAR MEMO
                        m.Numes      = loc_nNum
                        m.cIdChaves  = fUniqueIds()
                        m.EmpDopNums = THIS.MontarChaveEmpDopNums(m.Emps, m.Dopes, loc_nNum)
                        m.EmpSubNs   = loc_cEmpr

                        INSERT INTO CrSigMvPec FROM MEMVAR

                        SELECT csEstPe
                    ENDSCAN
                    SELECT csEstPe
                    SET KEY TO
                ENDIF

                SELECT csCabec

                *-- "fGravarLog('T', CrSigCdNec.Dopps, 'AUTOMATICO', Emps-Dopes-Numes)" -
                *-- wrapper no-op (ver utils\fgravarlog.prg) - transcrito por fidelidade
                loc_cDopps = IIF(USED("CrSigCdNec"), TratarNulo(CrSigCdNec.Dopps, ""), "")
                = fGravarLog("T", loc_cDopps, "AUTOMATICO", ;
                    ALLTRIM(csCabec.Emps) + "-" + ALLTRIM(csCabec.Dopes) + "-" + ALLTRIM(STR(loc_nNum, 6)))
            ENDIF

            *-- 7. Persiste no SQL Server, dentro da MESMA transacao (equivalente a
            *-- "poDataMgr.UpDate('crSigMvCab') / ... / poDataMgr.Commit()")
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigMvPec", "SigMvPec")
            ENDIF
            IF loc_lOks
                loc_lOks = THIS.PersistirCursor("CrSigInBep", "SigInBep")
            ENDIF

            IF loc_lOks
                IF SQLCOMMIT(gnConnHandle) < 1
                    THIS.this_cMensagemErro = "Falha ao confirmar a grava" + CHR(231) + CHR(227) + "o." + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOks = .F.
                ENDIF
            ENDIF

            IF !loc_lOks
                = SQLROLLBACK(gnConnHandle)
            ELSE
                *-- "Go Top In crSigMvCab / Replace Gerado With 'OK', GerEmps...,
                *-- GerDopes..., GerNumes... In csCabec"
                THIS.this_nNumeroGerado  = loc_nNum
                THIS.this_cMascaraNumero = loc_cMsk
                THIS.this_cGerEmps       = loc_cGerEmps
                THIS.this_cGerDopes      = loc_cGerDopes
                THIS.this_nGerNumes      = loc_nNum
                THIS.this_lGerado        = .T.

                SELECT csCabec
                REPLACE Gerado   WITH "OK", ;
                        GerEmps  WITH loc_cGerEmps, ;
                        GerDopes WITH loc_cGerDopes, ;
                        GerNumes WITH loc_nNum

                THIS.RegistrarAuditoria("GERAR")
            ENDIF

        CATCH TO loc_oErro
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            MsgErro(THIS.this_cMensagemErro, "SigPrGstBO.GerarPedido")
            loc_lOks = .F.
        ENDTRY

        *-- Fecha cursores de trabalho locais
        IF USED("crSigCdEmb")
            USE IN crSigCdEmb
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        IF USED("crSigMvItn")
            USE IN crSigMvItn
        ENDIF
        IF USED("crSigMvIts")
            USE IN crSigMvIts
        ENDIF
        IF USED("CrSigMvPec")
            USE IN CrSigMvPec
        ENDIF
        IF USED("CrSigInBep")
            USE IN CrSigInBep
        ENDIF
        IF USED("crTmpPro")
            USE IN crTmpPro
        ENDIF
        IF USED("crTmpGru")
            USE IN crTmpGru
        ENDIF

        RETURN loc_lOks
    ENDFUNC

ENDDEFINE

