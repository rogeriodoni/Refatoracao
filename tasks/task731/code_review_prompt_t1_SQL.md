# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNCS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNCS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'JAMA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNCS, EMPDOPNUMS

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
  Column1.ControlSource = ""
  ControlSource = ""
lcQrySigOpMvv = [Select * ] + ;
				 [From SigOpMvv ] + ;
		.GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
		.GradeVenc.Column2.ControlSource = 'crSigOpMvv.Usuars'
	Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas) ;
		lcQuery = [Update SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - )')
		If Not ThisForm.poDataMgr.Update('crSigOpMvv')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpMvv)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEnt.prg) - TRECHOS RELEVANTES PARA PASS SQL (2133 linhas total):

*-- Linhas 39 a 57:
39: *   - CarregarLista(): funil UNICO de carga e repinte da grade, equivalente
40: *     ao bloco AddCursor + Requery + RecordSource + Refresh do Init legado
41: *   - no SigOpEntBO, as duas pecas de dados que faltavam para a grade:
42: *     CriarCursorHistorico() (CREATE CURSOR, fonte unica da estrutura) e
43: *     CarregarHistorico() (a consulta de SigOpMvv por EmpDopNcs)
44: *
45: * FASE 5/8 - CAMPOS DE DADOS E ORDEM DE TABULACAO. Entrega:
46: *   - ConfigurarCamposPrazo(): os QUATRO controles de dados que faltavam, que
47: *     sao TODOS os que o SCX tem fora da grade - lbl_4c_PrazoAtual (Say1),
48: *     txt_4c_PrazoAtual (getAtual), lbl_4c_PrazoNovo (Say2) e txt_4c_PrazoNovo
49: *     (getNova). O "Procedure When / Return .f." do getAtual legado vira
50: *     ReadOnly = .T. + TabStop = .F.
51: *   - SincronizarCamposPrazo(): funil UNICO de valores entre o BO e os dois
52: *     campos, reproduzindo o par que o legado repete no Init e no altera.Valid
53: *     (.getAtual.Value = .pPrz / .getNova.Value = Ctod(''))
54: *   - AplicarBloqueioAlteracao(): a metade "Enabled" do If ThisForm.Bloquear
55: *     do Init legado (getNova e Confirmar desligados quando pBlqAlt = .T.)
56: *   - Activate(): a outra metade daquele IF - o SetFocus inicial, que nesta
57: *     arquitetura nao pode ficar no InicializarForm porque ele roda DENTRO do

*-- Linhas 86 a 104:
86: *   - NotificarFormPai() e ObterPrazoConfirmado(): as duas vias de devolucao
87: *     do novo prazo ao form pai (a escrita direta do legado, guardada por
88: *     PEMSTATUS, e a leitura pos-Show desta arquitetura)
89: *   - no SigOpEntBO, GravarAlteracaoPrazo(): a cadeia INSERT + UPDATE +
90: *     Commit/RollBack que o legado controla com a flag llOks. O Commit eh
91: *     passo com caminho de falha proprio, nao detalhe de infra - a conexao
92: *     deste ambiente nasce em transacao MANUAL e sem ele o gravado nao
93: *     persiste
94: *
95: * FASE 8/8 - CONSOLIDACAO FINAL. Entrega os hooks CANONICOS da arquitetura
96: * que ainda faltavam, com conteudo REAL - nenhum deles eh invencao: o corpo
97: * de cada um SAIU de onde estava escrito em linha nas fases anteriores, de
98: * modo que nao existem duas copias da mesma transferencia para divergirem em
99: * silencio (CLAUDE.md #44, item 6 - fonte unica):
100: *   - FormParaBO(): as duas primeiras linhas de altera.Valid, que leem os
101: *     campos antes de gravar (ldAnt = getAtual.Value / ldNew =
102: *     getNova.Value). Saiu de dentro de BtnConfirmarClick, que agora o chama
103: *     e NAO grava se ele recusar
104: *   - BOParaForm(): a volta - o "getAtual.Value = pPrz" do legado mais os

*-- Linhas 347 a 365:
347:     *
348:     * As duas datas passam por ConverterParaData(): elas chegam ora como DATE
349:     * (TextBox do pai criado com .Value = {}), ora como DATETIME (coluna
350:     * datetime lida por SQLEXEC), ora como CHAR - e TTOD() com DATE dispara
351:     * erro 11 em runtime.
352:     *==========================================================================
353:     PROCEDURE Init(par_cEmps, par_cDopcs, par_nNoTitulos, par_dPrazoAtual, ;
354:                    par_oFormPai, par_nPrazoMinimo, par_dDataMovimento, ;
355:                    par_lBloquear, par_nPrazoMaximo)
356: 
357:         IF VARTYPE(par_cEmps) = "C"
358:             THIS.this_cParamEmps = ALLTRIM(par_cEmps)
359:         ENDIF
360: 
361:         IF VARTYPE(par_cDopcs) = "C"
362:             THIS.this_cParamDopcs = ALLTRIM(par_cDopcs)
363:         ENDIF
364: 
365:         IF VARTYPE(par_nNoTitulos) = "N"

*-- Linhas 511 a 529:
511:     * Depois deste metodo o BO e a fonte unica desses valores (ver comentario
512:     * das propriedades this_*Param*). LEFT() aplica a largura das colunas de
513:     * SigOpMvv no schema - emps char(3) e dopcs char(20) - para o valor nunca
514:     * chegar ao INSERT maior do que a coluna aceita.
515:     *==========================================================================
516:     PROTECTED PROCEDURE TransferirParametrosParaBO()
517:         WITH THIS.this_oBusinessObject
518:             .this_cEmps          = LEFT(THIS.this_cParamEmps, .this_nLarguraEmps)
519:             .this_cDopcs         = LEFT(THIS.this_cParamDopcs, .this_nLarguraDopcs)
520:             .this_nNoTitulos     = THIS.this_nParamNoTitulos
521:             .this_dPrazoAtual    = THIS.this_dParamPrazoAtual
522:             .this_nPrazoMinimo   = THIS.this_nParamPrazoMinimo
523:             .this_dDataMovimento = THIS.this_dParamDataMovimento
524:             .this_lBloquear      = THIS.this_lParamBloquear
525:             .this_nPrazoMaximo   = THIS.this_nParamPrazoMaximo
526:         ENDWITH
527:     ENDPROC
528: 
529:     *==========================================================================

*-- Linhas 617 a 727:
617:     * Movable .F., Resizable .F., ReadOnly .T. O que o dump NAO declara vem da
618:     * classe fwgrade do Framework (docs\FRAMEWORK_class_codigo_fonte.txt):
619:     * FontName Tahoma, FontSize 8, AllowHeaderSizing .F., AllowRowSizing .F.,
620:     * DeleteMark .F., RowHeight 16, ScrollBars 2, GridLineColor
621:     * RGB(238,238,238), HighlightBackColor RGB(90,90,90).
622:     *
623:     * RecordMark = .F. eh o UNICO desvio: a fwgrade nao declara essa
624:     * propriedade (logo o legado fica no default .T.), mas grade criada por
625:     * AddObject em form OPERACIONAL usa RecordMark e DeleteMark em .F. por
626:     * padrao do projeto, para nao aparecer a barra de marcacao na lateral
627:     * esquerda. As duas colunas de 70 mais a barra de rolagem continuam
628:     * cabendo nos 173 de largura do legado.
629:     *
630:     * ColumnCount e RecordSource ficam FORA do WITH e ANTES dele: com os dois
631:     * dentro do mesmo bloco que acessa .Column1, o VFP9 ainda nao recriou as
632:     * colunas no instante em que .Column1 eh referenciado e estoura "Unknown
633:     * member COLUMN1". Pelo mesmo motivo Width e Header1.Caption vem DEPOIS de
634:     * RecordSource/ControlSource - atribuir RecordSource RESETA a largura das
635:     * colunas para o default 90 e apaga as legendas.
636:     *
637:     * Grid.ReadOnly eh atribuido ANTES do ReadOnly das colunas: o do grid
638:     * propaga para as colunas e sobrescreveria o delas.
639:     *
640:     * Column1.ControlSource eh a EXPRESSAO do legado, transcrita literalmente:
641:     *   .GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
642:     * TTOD so aceita DATETIME, e aceita aqui porque a coluna vencs do cursor eh
643:     * T (datetime), igual a coluna do SQL Server - NUNCA trocar essa coluna
644:     * para DATE sem tirar o TTOD daqui, senao o grid dispara erro 11 em
645:     * runtime. A expressao deixa a coluna intrinsecamente somente-leitura, o
646:     * que casa com o ReadOnly = .T. que o legado declara.
647:     *
648:     * TabIndex do dump: Gradevenc = 3 (aplicado no passe da Fase 5, depois de
649:     * todos os AddObject do form).
650:     *==========================================================================
651:     PROTECTED PROCEDURE ConfigurarGradeHistorico()
652:         LOCAL loc_cCursor
653:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorHistorico
654: 
655:         *-- Cursor vazio ANTES do bind: ligar RecordSource/ControlSource a um
656:         *-- alias que ainda nao existe estoura "Alias ... is not found" DENTRO
657:         *-- do TRY do InicializarForm - o CREATEOBJECT devolve .F., o
658:         *-- VARTYPE(loForm) = "O" do chamador nao entra e a tela simplesmente
659:         *-- nao abre, sem erro visivel.
660:         *
661:         *-- A chamada eh INCONDICIONAL de proposito (CriarCursorHistorico faz
662:         *-- USE IN antes do CREATE CURSOR): garante que a estrutura ligada a
663:         *-- grade eh a NOSSA. O nome cursor_4c_Dados eh compartilhado por
664:         *-- muitos BOs do projeto, e ZAP preserva a estrutura de quem criou o
665:         *-- alias antes - aqui a DataSession = 2 ja isola o alias nesta sessao
666:         *-- privada, e recriar fecha o que sobrar de qualquer jeito.
667:         *
668:         *-- A estrutura mora SO no BO (CriarCursorHistorico), porque a recarga
669:         *-- eh por ZAP + APPEND FROM DBF(), que casa coluna por NOME: duas
670:         *-- declaracoes do mesmo cursor divergem em silencio.
671:         THIS.this_oBusinessObject.CriarCursorHistorico()
672: 
673:         THIS.AddObject("grd_4c_Dados", "Grid")
674: 
675:         THIS.grd_4c_Dados.ColumnCount  = 2
676:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
677: 
678:         WITH THIS.grd_4c_Dados
679:             .Top                = 99
680:             .Left               = 105
681:             .Width              = 173
682:             .Height             = 184
683:             .FontName           = "Tahoma"
684:             .FontSize           = 8
685:             .AllowHeaderSizing  = .F.
686:             .AllowRowSizing     = .F.
687:             .DeleteMark         = .F.
688:             .RecordMark         = .F.
689:             .RowHeight          = 16
690:             .ScrollBars         = 2
691:             .GridLineColor      = RGB(238, 238, 238)
692:             .HighlightBackColor = RGB(90, 90, 90)
693:             .ReadOnly           = .T.
694: 
695:             *-- Column1 "Historico" - a data de entrega arquivada
696:             .Column1.ControlSource     = "TTOD(" + loc_cCursor + ".vencs)"
697:             .Column1.Width             = 70
698:             .Column1.Movable           = .F.
699:             .Column1.Resizable         = .F.
700:             .Column1.ReadOnly          = .T.
701:             .Column1.Header1.Caption   = "Hist" + CHR(243) + "rico"
702:             .Column1.Header1.FontName  = "Tahoma"
703:             .Column1.Header1.FontSize  = 8
704:             .Column1.Header1.Alignment = 2
705:             .Column1.Text1.BorderStyle = 0
706:             .Column1.Text1.Margin      = 0
707:             .Column1.Text1.ReadOnly    = .T.
708:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
709:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
710: 
711:             *-- Column2 "Usuario" - quem fez a troca de prazo
712:             .Column2.ControlSource     = loc_cCursor + ".usuars"
713:             .Column2.Width             = 70
714:             .Column2.Movable           = .F.
715:             .Column2.Resizable         = .F.
716:             .Column2.ReadOnly          = .T.
717:             .Column2.Header1.Caption   = "Usu" + CHR(225) + "rio"
718:             .Column2.Header1.FontName  = "Tahoma"
719:             .Column2.Header1.FontSize  = 8
720:             .Column2.Header1.Alignment = 2
721:             .Column2.Text1.BorderStyle = 0
722:             .Column2.Text1.Margin      = 0
723:             .Column2.Text1.ReadOnly    = .T.
724:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
725:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
726: 
727:             .Visible = .T.

*-- Linhas 761 a 779:
761:     * ser aplicado, com os dois controles existindo.
762:     *
763:     * Os handlers dos dois Valid legado (sair -> ThisForm.Release; altera ->
764:     * INSERT + UPDATE + devolucao do novo prazo ao form pai) sao
765:     * BtnCancelarClick e BtnConfirmarClick, e os BINDEVENT("Click") que os
766:     * acionam ficam em VincularEventos - chamado pelo InicializarForm depois
767:     * de TODOS os AddObject, e nao aqui, porque o campo da data nova (que
768:     * tambem eh vinculado la) nasce em outro metodo.
769:     *
770:     * TabIndex do dump: altera = 2, sair = 7 (aplicados no passe da Fase 5,
771:     * depois de todos os AddObject do form).
772:     *==========================================================================
773:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
774:         LOCAL loc_lBloqueado
775:         loc_lBloqueado = THIS.this_oBusinessObject.this_lBloquear
776: 
777:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
778:         WITH THIS.cmd_4c_Confirmar
779:             .Top             = 3

*-- Linhas 869 a 887:
869:     *     SET CENTURY ON, que a DataSession = 2 deste form zera). Por isso NAO
870:     *     se declara Format nem InputMask: o dump nao os traz, e inventar
871:     *     mascara aqui mudaria o que o usuario digita.
872:     *   - ControlSource NAO eh transcrito: o dump traz ControlSource = "" em
873:     *     getAtual, que eh override VAZIO do Form Designer (o legado liga os
874:     *     dois campos por atribuicao de .Value no Init e no altera.Valid, nao
875:     *     por binding). O trafego de valores passa por SincronizarCamposPrazo().
876:     *
877:     * getAtual EH SOMENTE-LEITURA. O legado faz isso com
878:     *   PROCEDURE When / Return .f.
879:     * que impede o campo de receber foco - logo o usuario nem entra nele. Aqui
880:     * isso vira ReadOnly = .T. (nao da para digitar) + TabStop = .F. (o Tab nao
881:     * para nele), que eh o par de propriedades equivalente. NAO se usa
882:     * BINDEVENT em "When": BINDEVENT DESCARTA o retorno do delegate, entao um
883:     * When ligado por BINDEVENT nao bloquearia nada. Tambem NAO se usa
884:     * Enabled = .F.: isso pintaria o valor com a cor de desabilitado, enquanto
885:     * o legado exibe o prazo vigente em preto normal (ForeColor 0,0,0 do dump).
886:     *
887:     * TabIndex do dump (Say1 4, getAtual 5, Say2 6, getNova 1) eh aplicado em

*-- Linhas 1070 a 1088:
1070:     * exibido um valor que o BO nao tem mais.
1071:     *
1072:     * ConverterParaData eh aplicado nos dois: o valor pode chegar de coluna
1073:     * datetime (SQLEXEC) e atribuir DATETIME a um TextBox que nasceu com
1074:     * Value = {} TROCA o tipo do controle - dai a exibicao e qualquer TTOD a
1075:     * jusante divergem. Com DATE o resultado eh identico ao do valor cru, e
1076:     * TTOD() puro com DATE dispararia erro 11 em runtime (regra #16).
1077:     *
1078:     * Os dois Refresh do fim sao os do legado
1079:     * ("ThisForm.getAtual.Refresh / ThisForm.getNova.Refresh") e sao o que faz
1080:     * o valor novo APARECER - atribuir .Value nao repinta o controle.
1081:     *
1082:     * PROTECTED EXPLICITO pelo mesmo motivo de LimparCampos: o escopo vem da
1083:     * heranca de FormBase e nao da para alargar na subclasse.
1084:     *==========================================================================
1085:     PROTECTED PROCEDURE BOParaForm()
1086:         LOCAL loc_oBO
1087:         loc_oBO = THIS.this_oBusinessObject
1088: 

*-- Linhas 1562 a 1586:
1562:     *   .poDataMgr.AddCursor('SigOpMvv', 'cIdChaves', 'crSigOpMvv', '', '', lcQrySigOpMvv)
1563:     *   .poDataMgr.Requery('crSigOpMvv')
1564:     *   .GradeVenc.RecordSource = 'crSigOpMvv'
1565:     *   .GradeVenc.Column1.ControlSource = 'ttod(crSigOpMvv.Vencs)'
1566:     *   .GradeVenc.Column2.ControlSource = 'crSigOpMvv.Usuars'
1567:     *   .GradeVenc.Refresh
1568:     *
1569:     * O legado REBINDA a grade porque o AddCursor/Requery FECHA e RECRIA o
1570:     * cursor. Aqui nao se rebinda: o BO recarrega por ZAP + APPEND FROM DBF(),
1571:     * entao RecordSource, ControlSource, Width e Header1.Caption sobrevivem -
1572:     * repetir o bind mexeria em RecordSource sem necessidade e APAGARIA as
1573:     * larguras e as legendas postas em ConfigurarGradeHistorico.
1574:     *
1575:     * GO TOP + Refresh sao OBRIGATORIOS: popular o cursor NAO repinta a grade.
1576:     * Sem eles a grade fica visualmente vazia com o cursor cheio, e o sintoma
1577:     * ("a tela nao traz o historico") manda o diagnostico para SQL/permissao.
1578:     *
1579:     * Devolve o resultado do BO, nunca sucesso fabricado - mas ZERO LINHA eh
1580:     * resultado VALIDO (operacao que nunca teve troca de prazo), entao quem
1581:     * precisa aferir carga olha RECCOUNT do cursor, nao este retorno.
1582:     *
1583:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama os metodos
1584:     * de carga direto no objeto do form, de FORA da classe, e
1585:     * BtnConfirmarClick torna a chamar este metodo depois de gravar, para a
1586:     * linha nova aparecer no historico sem fechar a tela.

*-- Linhas 1602 a 1656:
1602:             loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico()
1603: 
1604:             IF USED(loc_cCursor)
1605:                 SELECT (loc_cCursor)
1606:                 GO TOP
1607:             ENDIF
1608: 
1609:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1610:                 THIS.grd_4c_Dados.Refresh()
1611:             ENDIF
1612:         CATCH TO loc_oErro
1613:             MsgErro(loc_oErro.Message + CHR(13) + ;
1614:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1615:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpEnt.CarregarLista")
1616:         ENDTRY
1617: 
1618:         RETURN loc_lSucesso
1619:     ENDPROC
1620: 
1621:     *==========================================================================
1622:     * SincronizarEscolhaPai - Le o modo de trabalho do form PAI e o repassa ao
1623:     * BO, que o usa para decidir se o UPDATE de SigMvCab.PrazoEnts acontece.
1624:     *
1625:     * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> [ALTERAR]) -
1626:     * em modo ALTERAR e o proprio pai que grava o cabecalho, e este dialogo
1627:     * so arquiva o historico.
1628:     *
1629:     * Este form nao DECIDE modo nenhum: ele apenas RECEBE/LE o do pai (nao ha
1630:     * Incluir/Alterar/Visualizar/Excluir aqui). Por isso o valor nao e
1631:     * cacheado na abertura e esquecido: este metodo e o FUNIL de leitura, e
1632:     * BtnConfirmarClick torna a chama-lo imediatamente antes de gravar, para
1633:     * o dialogo nunca gravar com um modo que o pai ja trocou - o form legado
1634:     * era modal e de vida curta, este pode ficar aberto enquanto o pai muda de
1635:     * estado.
1636:     *
1637:     * Duas grafias sao aceitas, nesta ordem de precedencia: pcEscolha (a do
1638:     * frmcadastro legado e dos forms wrapper de VCX) e, se ela nao existir,
1639:     * this_cModoAtual (a do FormBase nesta arquitetura). Sem pai, ou sem
1640:     * nenhuma das duas, o BO fica com string vazia - que e diferente de
1641:     * ALTERAR e portanto NAO suprime o UPDATE, exatamente como o legado se
1642:     * comporta quando o pai nao esta em ALTERAR.
1643:     *
1644:     * PUBLIC de proposito: quem chama eh BtnConfirmarClick, que roda fora
1645:     * desta classe quando acionado por BINDEVENT.
1646:     *==========================================================================
1647:     PROCEDURE SincronizarEscolhaPai()
1648:         LOCAL loc_cEscolha, loc_oErro
1649:         loc_cEscolha = ""
1650: 
1651:         TRY
1652:             IF VARTYPE(THIS.this_oFormPai) = "O"
1653:                 IF PEMSTATUS(THIS.this_oFormPai, "pcEscolha", 5)
1654:                     IF VARTYPE(THIS.this_oFormPai.pcEscolha) = "C"
1655:                         loc_cEscolha = UPPER(ALLTRIM(THIS.this_oFormPai.pcEscolha))
1656:                     ENDIF

*-- Linhas 1717 a 1757:
1717:     *   ldAnt = ThisForm.getAtual.Value
1718:     *   ldNew = ThisForm.getNova.Value
1719:     *   If Not Empty(ldNew)
1720:     *       Insert Into crSigOpMvv (...)  Values (..., fDtoSQL(ldAnt), ...)
1721:     *       llOks = .t.
1722:     *       pDtp = fDtoSQL(ldNew)
1723:     *       If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
1724:     *           Update SigMvCab Set PrazoEnts = ?pDtp Where EmpDopNums = ...
1725:     *       EndIf
1726:     *       If llOks ... poDataMgr.Update('crSigOpMvv')  ... EndIf
1727:     *       If llOks ... poDataMgr.Commit()              ... EndIf
1728:     *       If Not llOks
1729:     *           ThisForm.poDataMgr.RollBack()
1730:     *       Else
1731:     *           ThisForm.pPrz = ldNew
1732:     *           thisform.parentform.validOk = .t.
1733:     *           ThisForm.ParentForm.cntEntregas.getEntregas.Value = ThisForm.pPrz
1734:     *           ThisForm.getAtual.Value = ThisForm.pPrz
1735:     *           ThisForm.getNova.Value  = Ctod('')
1736:     *       EndIf
1737:     *       ThisForm.getAtual.Refresh
1738:     *       ThisForm.getNova.Refresh
1739:     *       ThisForm.GradeVenc.Refresh
1740:     *   EndIf
1741:     *
1742:     * A sequencia INSERT + UPDATE + Commit/RollBack mora no BO
1743:     * (GravarAlteracaoPrazo), que eh onde esta a regra; aqui fica o que eh de
1744:     * TELA: validar, levar os valores dos campos ao BO, reler o modo do pai,
1745:     * devolver o resultado e repintar.
1746:     *
1747:     * CINCO pontos que o legado determina e que nao se devem "melhorar":
1748:     *
1749:     * 1) A tela NAO fecha ao confirmar. O legado nao chama Release aqui: ele
1750:     *    repoe "Data Atual" com o prazo recem-gravado, limpa "Nova Data" e
1751:     *    repinta a grade, deixando o usuario ver o historico crescer. Quem
1752:     *    fecha eh so o Cancelar.
1753:     *
1754:     * 2) Campo "Nova Data" VAZIO nao faz nada - nem grava, nem avisa (o
1755:     *    "If Not Empty(ldNew)" embrulha o corpo inteiro). Quando a operacao
1756:     *    exige prazo (SigCdOpe.DtEntrs em 1/4/6) quem recusa o vazio eh a
1757:     *    validacao do campo, com a mensagem do legado.

*-- Linhas 2101 a 2119:
2101:     *
2102:     * USE IN basta e nao precisa de TABLEREVERT antes: USE IN fecha o alias
2103:     * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering
2104:     * (que e como CREATE CURSOR e SQLEXEC os criam) dispara erro 1586.
2105:     *
2106:     * DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
2107:     * libera o Business Object e reconstroi os popups do menu principal.
2108:     *==========================================================================
2109:     PROCEDURE Destroy()
2110:         LOCAL loc_oErro
2111: 
2112:         TRY
2113:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2114:                 IF USED(THIS.this_oBusinessObject.this_cCursorHistorico)
2115:                     USE IN (THIS.this_oBusinessObject.this_cCursorHistorico)
2116:                 ENDIF
2117:                 IF USED(THIS.this_oBusinessObject.this_cCursorOperacao)
2118:                     USE IN (THIS.this_oBusinessObject.this_cCursorOperacao)
2119:                 ENDIF


### BO (C:\4c\projeto\app\classes\SigOpEntBO.prg):
*==============================================================================
* SigOpEntBO.prg
*
* Business Object para SigOpEnt - "Alteracao de Data de Entrega", dialogo
* filho aberto pela tela de movimentacao (form OPERACIONAL, WindowType = 1).
*
* Tabela principal: SigOpMvv - historico das datas de entrega de UMA
* movimentacao. Cada troca de prazo grava em SigOpMvv a data que esta SAINDO
* (coluna vencs) e atualiza SigMvCab.PrazoEnts com a data nova.
*
* Origem legado: tasks\task731\SigOpEnt_form_codigo_fonte.txt
*   SIGOPENT.Init          - recebe pEmp, pDop, pNum, pPrz, pFor, pMin, pDat,
*                            pBlqAlt, pMax do form pai e carrega 3 cursores
*                            (crSigOpMvv, crSigCdOpe, crSigOpCdd)
*   SIGOPENT.getNova.Valid - valida a data digitada contra pDat / pMin / pMax
*   SIGOPENT.altera.Valid  - grava o historico e atualiza SigMvCab
*
* Esta tela NAO eh um cadastro CRUD: nao tem lista com Incluir/Alterar/
* Excluir. O unico caminho de gravacao eh o botao Confirmar, que INSERE uma
* linha de historico em SigOpMvv e faz o UPDATE de SigMvCab.PrazoEnts.
*==============================================================================

DEFINE CLASS SigOpEntBO AS BusinessBase

    *--------------------------------------------------------------------------
    * COLUNAS DE SigOpMvv - grafia EXATA do docs\schema.sql (PILAR 2)
    *
    *   cidchaves  char(20)      NOT NULL   PK (sigopmvv_cidchaves)
    *   emps       char(3)       NOT NULL
    *   dopcs      char(20)      NOT NULL
    *   notitulos  numeric(6,0)  NOT NULL
    *   empdopncs  char(29)      NOT NULL
    *   vencs      datetime      NULL
    *   datas      datetime      NULL
    *   usuars     char(10)      NOT NULL
    *
    * As 6 colunas NOT NULL tem propriedade propria aqui (regra #22): a PK
    * cidchaves vem de fUniqueIds() - NUNCA string vazia, senao a segunda
    * linha de historico colide no indice unico - e usuars vem de
    * gc_4c_UsuarioLogado. O legado grava exatamente estas 8 colunas
    * (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas),
    * ou seja a lista do schema e a do legado coincidem.
    *--------------------------------------------------------------------------
    this_cCidChaves = ""            && cidchaves  char(20)     - PK, fUniqueIds()
    this_cEmps = ""                 && emps       char(3)      - empresa (pEmp)
    this_cDopcs = ""                && dopcs      char(20)     - documento/operacao (pDop)
    this_nNoTitulos = 0             && notitulos  numeric(6,0) - numero da operacao (pNum)
    this_cEmpDopNcs = ""            && empdopncs  char(29)     - chave posicional
    this_dVencs = {}                && vencs      datetime     - data de entrega ARQUIVADA
    this_dDatas = {}                && datas      datetime     - data/hora do registro
    this_cUsuars = ""               && usuars     char(10)     - usuario que alterou

    *--------------------------------------------------------------------------
    * CHAVE POSICIONAL empdopncs char(29) - regra #42
    *
    * O legado monta a chave concatenando SEM ALLTRIM:
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * As larguras vem das COLUNAS: emps char(3) + dopcs char(20) + STR(,6)
    * = 29 = empdopncs char(29). O padding FAZ PARTE da chave: encurtar
    * qualquer parte com ALLTRIM devolve ZERO linha em silencio. A montagem
    * usa PADR explicito sobre as larguras do schema, porque as propriedades
    * deste BO recebem os valores do form pai ja com ALLTRIM.
    *
    * A MESMA chave de 29 caracteres eh o filtro do UPDATE de SigMvCab
    * (Where EmpDopNums = ...), por isso uma unica propriedade atende aos
    * dois usos.
    *--------------------------------------------------------------------------
    this_nLarguraEmps = 3           && largura de SigOpMvv.emps  no schema
    this_nLarguraDopcs = 20         && largura de SigOpMvv.dopcs no schema
    this_nLarguraNoTitulos = 6      && digitos de STR(notitulos, 6) na chave

    *--------------------------------------------------------------------------
    * PARAMETROS RECEBIDOS DO FORM PAI
    *
    * O legado guarda estes valores em propriedades do proprio form (pEmp,
    * pDop, pNum, pPrz, pMin, pMax, pDat, Bloquear - ver RESERVED3 ClassInfo
    * do dump). Aqui eles vivem no BO, porque sao o insumo da validacao e da
    * gravacao. pFor (a referencia ao form pai) NAO vem para o BO: continua
    * sendo assunto do Form.
    *
    * As datas sao declaradas como DATE ({}) porque chegam de TextBox e de
    * propriedade do form pai, nao de coluna datetime do SQL Server - por
    * isso toda normalizacao usa ConverterParaData(), nunca TTOD(), que com
    * DATE dispara erro 11 em runtime (regra #16).
    *--------------------------------------------------------------------------
    this_dPrazoAtual = {}           && pPrz    - data de entrega vigente (SigMvCab.PrazoEnts)
    this_dPrazoNovo = {}            && valor digitado em getNova
    this_dDataMovimento = {}        && pDat    - data da movimentacao
    this_nPrazoMinimo = 0           && pMin    - dias minimos contados de pDat
    this_nPrazoMaximo = 0           && pMax    - dias maximos contados de pDat
    this_lBloquear = .F.            && pBlqAlt - .T. bloqueia a alteracao (so consulta)

    *--------------------------------------------------------------------------
    * CONTEXTO DO FORM PAI QUE DECIDE O UPDATE DE SigMvCab
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR').
    * O UPDATE de SigMvCab.PrazoEnts SO acontece quando o pai NAO esta em
    * modo ALTERAR - nesse modo o proprio pai grava o cabecalho. O historico
    * em SigOpMvv, ao contrario, eh gravado nos dois casos.
    *--------------------------------------------------------------------------
    this_cEscolhaPai = ""           && ParentForm.pcEscolha ("INSERIR"/"ALTERAR"/...)
    this_cModoNaoAtualizaCabecalho = "ALTERAR"   && valor que SUPRIME o UPDATE de SigMvCab

    *--------------------------------------------------------------------------
    * CONFIGURACAO LIDA DOS CURSORES DE APOIO (CursorQuery do Init legado)
    *
    * Ambas sao numeric(1,0) NOT NULL no schema, portanto chegam ao VFP como
    * NUMERICO - propriedade this_n*, comparada com numero.
    *
    *   SigCdOpe.dtentrs  - regra de exigencia do prazo de entrega. O legado
    *                       so exige/valida a data quando InList(DtEntrs, 1, 4, 6).
    *   SigOpCdd.chkuteis - indica se a contagem de dias considera dias uteis.
    *--------------------------------------------------------------------------
    this_nDtEntrs = 0               && SigCdOpe.dtentrs  numeric(1,0)
    this_nChkUteis = 0              && SigOpCdd.chkuteis numeric(1,0)

    *--------------------------------------------------------------------------
    * ALIASES DOS CURSORES
    *
    * Equivalencia com o legado:
    *   crSigOpMvv  -> cursor_4c_Dados      (alimenta a grade Gradevenc)
    *   crSigCdOpe  -> cursor_4c_Operacao   (CursorQuery SigCdOpe / Dopes / DtEntrs)
    *   crSigOpCdd  -> cursor_4c_ConfigDoc  (CursorQuery SigOpCdd / Dopes / chkUteis)
    *--------------------------------------------------------------------------
    this_cCursorHistorico = "cursor_4c_Dados"
    this_cCursorOperacao = "cursor_4c_Operacao"
    this_cCursorConfigDoc = "cursor_4c_ConfigDoc"

    *--------------------------------------------------------------------------
    * LIBERACAO POR SENHA (Do Form SigOpSen With 'LIBPRZENT', ...)
    *
    * Quando a data digitada fica fora da faixa pMin..pMax, o legado pede
    * autorizacao pelo programa LIBPRZENT e, autorizado, registra a liberacao
    * com fGravarLog('T', pDop, 'LIBPRZENT', <transacao>, <usuario liberador>).
    * O codigo do programa eh constante no legado e fica aqui para o texto do
    * log e a chamada da autorizacao usarem a MESMA grafia.
    *--------------------------------------------------------------------------
    this_cProgramaLiberacao = "LIBPRZENT"
    this_cTituloLiberacao = "Libera Prazo de Entrega"
    this_cUsuarioLiberacao = ""     && usuario que autorizou (retorno do SigOpSen)
    this_lPrazoLiberado = .F.       && .T. quando a autorizacao foi concedida

    *--------------------------------------------------------------------------
    * ESTADO DA ULTIMA GRAVACAO
    *
    * O legado controla commit/rollback com a flag local llOks e avisa o pai
    * do sucesso com thisform.parentform.validOk = .t. - o Form le esta
    * propriedade para decidir se repassa o novo prazo ao pai.
    *--------------------------------------------------------------------------
    this_lGravouPrazo = .F.         && .T. quando historico e cabecalho gravaram

    *====================================================================
    * Init - Inicializa Business Object
    *
    * this_cCampoChave usa a grafia do schema (cidchaves), que eh a PK
    * declarada em CONSTRAINT [sigopmvv_cidchaves].
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigOpMvv"
        THIS.this_cCampoChave = "cidchaves"

        *-- usuars eh NOT NULL char(10): nasce com o usuario logado, o mesmo
        *-- Usuar global que o INSERT do legado usa. O guard de TYPE existe
        *-- porque probe/teste headless pode instanciar o BO antes do startup
        *-- ter definido a variavel publica.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
        ELSE
            THIS.this_cUsuars = ""
        ENDIF

        *-- Nenhuma gravacao nem liberacao aconteceu nesta instancia ainda.
        THIS.this_lGravouPrazo = .F.
        THIS.this_lPrazoLiberado = .F.
        THIS.this_cUsuarioLiberacao = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - PK da linha de historico gravada por Inserir()
    *
    * Fica PROTECTED pela heranca de BusinessBase (regra #51 do CLAUDE.md:
    * PROTECTED declarado em QUALQUER classe da cadeia prevalece) - quem
    * usa isto eh RegistrarAuditoria(), chamado de dentro do proprio BO.
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega uma linha de SigOpMvv (cursor_4c_Dados,
    * equivalente ao crSigOpMvv do legado) para as propriedades do BO.
    *
    * Esta tela NUNCA altera uma linha de historico existente - cada
    * confirmacao sempre INSERE uma linha nova (ver cabecalho da classe).
    * Este metodo serve para inspecionar uma linha ja gravada (detalhe da
    * grade Gradevenc), nao para reabrir edicao; this_lNovoRegistro = .F.
    * segue o padrao canonico do projeto (BlqBO.CarregarDoCursor e
    * similares), mesmo que esta tela nao tenha fluxo de ALTERAR.
    *
    * Uso de SELECT (par_cAliasCursor) + campo direto, nunca
    * campo (regra #9 - sintaxe invalida em VFP9).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cDopcs     = TratarNulo(dopcs, "C")
            THIS.this_nNoTitulos = TratarNulo(notitulos, 0)
            THIS.this_cEmpDopNcs = TratarNulo(empdopncs, "C")
            THIS.this_dVencs     = TratarNulo(vencs, {})
            THIS.this_dDatas     = TratarNulo(datas, {})
            THIS.this_cUsuars    = TratarNulo(usuars, "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres, usada
    * tanto no INSERT de SigOpMvv.empdopncs quanto no WHERE do UPDATE de
    * SigMvCab.empdopnums (mesmo VALOR, nomes de coluna diferentes - o
    * legado monta os dois com a mesma expressao).
    *
    * Regra #42: o legado monta SEM ALLTRIM -
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * - e o padding FAZ PARTE da chave: emps char(3) + dopcs char(20) +
    * STR(,6) = 29 caracteres = largura EXATA das colunas empdopncs e
    * empdopnums no schema. Usa PADR explicito sobre as larguras do
    * SCHEMA (this_nLarguraEmps/Dopcs/NoTitulos), porque this_cEmps e
    * this_cDopcs chegam a este BO ja com ALLTRIM (vindos do form pai) -
    * encurtar qualquer parte faz a chave NUNCA casar, sem erro nenhum.
    *====================================================================
    PROTECTED FUNCTION MontarChaveEmpDopNums()
        RETURN PADR(THIS.this_cEmps, THIS.this_nLarguraEmps) + ;
               PADR(THIS.this_cDopcs, THIS.this_nLarguraDopcs) + ;
               STR(THIS.this_nNoTitulos, THIS.this_nLarguraNoTitulos)
    ENDFUNC

    *====================================================================
    * CarregarConfiguracaoOperacao - Carrega as duas configuracoes de apoio
    * que o Init legado busca com CursorQuery, ANTES de liberar a tela:
    *
    *   .poDataMgr.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', .pDop, 'DtEntrs')
    *   If Not Used('crSigCdOpe')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *       Return .f.
    *   EndIf
    *   .poDataMgr.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', .pDop, 'chkUteis')
    *   If Not Used('crSigOpCdd')
    *       ... Return .f.
    *   EndIf
    *
    * As DUAS consultas sao requisito de ABERTURA no legado: falhando
    * qualquer uma, o Init devolve .f. e o "Do Form" inteiro nao chega a
    * abrir. Aqui o mesmo efeito vem do RETURN .F. deste metodo, que o
    * InicializarForm do Form usa para abortar o CREATEOBJECT.
    *
    * this_nDtEntrs eh o que ValidarPrazoNovo (Form) usa depois
    * (InList(DtEntrs,1,4,6) do getNova.Valid legado). this_nChkUteis eh
    * carregado pelo mesmo motivo do legado - a abertura da tela depende
    * das DUAS consultas terem sucesso -, mas nenhum dos 7 metodos com
    * codigo do dump chega a LER o valor depois de carregado: fica
    * disponivel sem logica adicional inventada (regra CLAUDE.md
    * REGRA FUNDAMENTAL - nao omitir, mas tambem nao inventar uso que o
    * legado nao tem).
    *
    * Sem conexao (gnConnHandle invalido - probe headless, validacao de UI)
    * os dois valores ficam no default 0 e o metodo devolve .T.: nao ha
    * banco para consultar, e abortar a tela nesse modo impediria qualquer
    * teste automatizado de instanciar o form.
    *
    * EVALUATE(<alias> + ".<campo>") para LEITURA eh seguro (regra #15) -
    * so a ATRIBUICAO com "=" dentro da string eh que nao funciona.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * InicializarForm() do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao: mesmo criterio de CarregarHistorico - nao
                *-- ha banco para consultar, e isso nao e falha.
                loc_lSucesso = .T.
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    USE IN (THIS.this_cCursorOperacao)
                ENDIF

                loc_cSQL = "SELECT DtEntrs FROM SigCdOpe" + ;
                    " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

                IF loc_nResult >= 0 AND USED(THIS.this_cCursorOperacao) ;
                        AND !EOF(THIS.this_cCursorOperacao)

                    THIS.this_nDtEntrs = NVL(EVALUATE(THIS.this_cCursorOperacao + ".DtEntrs"), 0)

                    IF USED(THIS.this_cCursorConfigDoc)
                        USE IN (THIS.this_cCursorConfigDoc)
                    ENDIF

                    loc_cSQL = "SELECT chkUteis FROM SigOpCdd" + ;
                        " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorConfigDoc)

                    IF loc_nResult >= 0 AND USED(THIS.this_cCursorConfigDoc) ;
                            AND !EOF(THIS.this_cCursorConfigDoc)
                        THIS.this_nChkUteis = NVL(EVALUATE(THIS.this_cCursorConfigDoc + ".chkUteis"), 0)
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                            "o (CursorQuery - SigOpCdd)")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                        "o (CursorQuery - SigCdOpe)")
                    THIS.this_lErroExibido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarConfiguracaoOperacao")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorHistorico - Cria o cursor VAZIO que alimenta a grade do
    * historico (this_cCursorHistorico, o crSigOpMvv do legado).
    *
    * Este metodo eh a FONTE UNICA da estrutura desse cursor: nomes, tipos e
    * ORDEM aqui tem de ser os MESMOS da lista do SELECT de
    * CarregarHistorico(), porque a recarga eh por ZAP + APPEND FROM DBF(),
    * que casa coluna por NOME. Por isso o Form CHAMA este metodo e NUNCA
    * declara a estrutura de novo - duas declaracoes com ordem ou grafia
    * diferentes eh o defeito classico dos forms OPERACIONAIS.
    *
    * Tipos conforme docs\schema.sql (SIGOPMVV): cidchaves char(20),
    * emps char(3), dopcs char(20), notitulos numeric(6,0),
    * empdopncs char(29), vencs datetime, datas datetime, usuars char(10).
    *
    * SET NULL ON em volta do CREATE CURSOR: vencs e datas sao NULL-aveis no
    * SQL Server, e sem campos NULL-aveis o APPEND FROM de uma linha com
    * NULL falha.
    *
    * O alias eh fechado com USE IN e SEM TABLEREVERT antes: USE IN fecha
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering -
    * que eh como CREATE CURSOR e SQLEXEC os criam - dispara erro 1586.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o Form, de FORA da
    * classe, antes de ligar a grade.
    *====================================================================
    PROCEDURE CriarCursorHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (cidchaves C(20), emps C(3), dopcs C(20), notitulos N(6, 0), ;
             empdopncs C(29), vencs T, datas T, usuars C(10))
        SET NULL OFF

        RETURN USED(loc_cCursor)
    ENDPROC

    *====================================================================
    * LimparCursorHistorico - Esvazia o cursor da grade PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource que o Form ligou no
    * InicializarForm. Eh o Zap In <cursor> do legado Fortyus.
    *
    * SET SAFETY OFF em volta do ZAP eh OBRIGATORIO, nao precaucao: o form
    * que consome este BO eh DataSession = 2, e SET SAFETY eh escopado por
    * DATA SESSION - medido no VFP9, dentro da datasession privada o SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg (mesmo mecanismo que
    * reseta SET DATE/CENTURY ali). Com SAFETY ON o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique que
    * ninguem ve - num teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro.
    *
    * SELECT antes do ZAP: ZAP IN nao muda a work area corrente, e quem
    * chama este metodo segue com APPEND FROM, que vai para a work area
    * CORRENTE.
    *====================================================================
    PROTECTED PROCEDURE LimparCursorHistorico()
        LOCAL loc_cCursor, loc_cSafety
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (loc_cCursor)
            ZAP IN (loc_cCursor)
            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * CarregarHistorico - Popula a grade com o historico de datas de entrega
    * desta operacao (uma linha por troca de prazo ja arquivada).
    *
    * Transcreve a consulta que o Init legado monta e manda ao AddCursor:
    *   lcQrySigOpMvv = [Select * ] + ;
    *                    [From SigOpMvv ] + ;
    *                   [Where EmpDopNcs = '] + pEmp + pDop + Str(pNum, 6) + [' ] + ;
    *                   [Order By Vencs]
    * As colunas sao listadas explicitamente no lugar do SELECT *, para a
    * lista do SELECT ser a MESMA do CREATE CURSOR de CriarCursorHistorico()
    * - APPEND FROM DBF() casa coluna por NOME.
    *
    * A chave vem de MontarChaveEmpDopNums(): 29 caracteres COM o padding,
    * porque empdopncs eh char(29) POSICIONAL (emps char(3) + dopcs char(20)
    * + STR(,6)) e encurtar qualquer parte com ALLTRIM faz o WHERE nunca
    * casar - devolvendo ZERO linha em SILENCIO, sem erro e sem log.
    *
    * Sem os parametros do form pai (probe headless, harness) a chave fica
    * em branco e o SELECT devolve ZERO linha: grade vazia, SEM erro - o
    * mesmo que o legado exibe para uma operacao que nunca teve troca de
    * prazo. Por isso zero linha NAO eh falha, e quem precisa aferir carga
    * tem de olhar RECCOUNT, nao o retorno deste metodo.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado por ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias
    * da grade FECHA e RECRIA o alias: o Grid perde RecordSource e
    * ControlSource e cai para ColumnCount = 0 - vira um retangulo branco
    * sem cabecalho e sem coluna, sem erro, sem log e sem excecao.
    *
    * O guard do TABLEREVERT olha o BUFFERING, nao o USED: TABLEREVERT em
    * cursor sem buffering (como SQLEXEC cria) dispara erro 1586.
    *
    * Sem conexao (gnConnHandle invalido - validacao de UI, probe headless)
    * a grade fica VAZIA e o metodo devolve .T.: nao houve falha, so nao
    * havia banco para consultar.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o CarregarLista()
    * do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cCursor, loc_cTmp, loc_cChave
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorHistorico
        loc_cTmp     = "cursor_4c_HistoricoTmp"

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorHistorico()
            ENDIF

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o cursor do hist" + CHR(243) + "rico (" + loc_cCursor + ")."
                MsgErro(THIS.this_cMensagemErro, "SigOpEntBO.CarregarHistorico")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao: grade vazia, mesmo resultado visual de uma
                    *-- operacao sem historico
                    THIS.LimparCursorHistorico()
                    loc_lSucesso = .T.
                ELSE
                    loc_cChave = THIS.MontarChaveEmpDopNums()

                    loc_cSQL = "SELECT cidchaves, emps, dopcs, notitulos," + ;
                        " empdopncs, vencs, datas, usuars" + ;
                        " FROM SigOpMvv" + ;
                        " WHERE EmpDopNcs = " + EscaparSQL(loc_cChave) + ;
                        " ORDER BY Vencs"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        THIS.LimparCursorHistorico()
                        SELECT (loc_cCursor)
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado nas falhas de carga deste form:
                        *-- MessageBox([Favor Reinicializar o Processo!!!], 16,
                        *--            [Falha na Conexao (...)])
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarHistorico")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de HISTORICO em SigOpMvv.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 550-553 do dump legado):
    *   Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs,
    *                           cIdChaves, Usuars, Datas)
    *          Values (pEmp, pDop, pNum, fDtoSQL(ldAnt),
    *                  pEmp + pDop + Str(pNum,6), fUniqueIds(), Usuar,
    *                  Datetime())
    *
    * ATENCAO (nao inverter): Vencs recebe this_dPrazoAtual - o prazo que
    * esta SAINDO (ldAnt no legado) - NUNCA this_dPrazoNovo. O historico
    * arquiva a data ANTIGA, a nova vai para SigMvCab em Atualizar().
    *
    * O legado so executa o bloco inteiro (insert+update+commit) quando a
    * data nova nao esta vazia (If Not Empty(ldNew)); com o campo vazio o
    * clique em Confirmar nao faz nada, sem erro nenhum - por isso aqui
    * tambem devolve .T. (nada a gravar) e nao falha.
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_lGravouPrazo = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpMvv" + ;
                       " (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs," + ;
                       "  cIdChaves, Usuars, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, THIS.this_nLarguraEmps)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopcs, THIS.this_nLarguraDopcs)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNoTitulos, 0) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoAtual) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNcs) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao gravar hist" + CHR(243) + "rico de entrega:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE de SigMvCab.PrazoEnts com a data NOVA.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 559-568 do dump legado):
    *   If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts = ?pDtp
    *       Where EmpDopNums = pEmp + pDop + Str(pNum,6)
    *   EndIf
    *
    * Quando o form pai esta em modo ALTERAR (this_cEscolhaPai igual a
    * this_cModoNaoAtualizaCabecalho), o PROPRIO pai grava o cabecalho e
    * este UPDATE tem de ser PULADO - essa condicao eh regra de negocio
    * do legado (CLAUDE.md regra #21b: a condicao que cerca a validacao
    * faz parte dela), por isso devolve .T. (nada a atualizar) em vez de
    * executar o UPDATE, exatamente como o legado nao executa a query.
    *
    * Depende de this_cEmpDopNcs e this_dPrazoNovo ja estarem calculados
    * - chamar DEPOIS de Inserir() ter devolvido .T., nunca isolado.
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        IF THIS.this_cEscolhaPai = THIS.this_cModoNaoAtualizaCabecalho
            *-- Modo ALTERAR: o form pai grava o proprio cabecalho - nada a
            *-- fazer aqui (fiel ao guard do legado em altera.Valid).
            THIS.this_lGravouPrazo = .T.
            RETURN .T.
        ENDIF

        TRY
            IF EMPTY(THIS.this_cEmpDopNcs)
                THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoNovo) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNcs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_lGravouPrazo = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar o prazo de entrega do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * GravarAlteracaoPrazo - UNICA via de gravacao desta tela: encadeia
    * Inserir() + Atualizar() e fecha a transacao, espelhando o corpo de
    * SIGOPENT.altera.Valid com a flag llOks do legado:
    *
    *   Insert Into crSigOpMvv (...)            -> Inserir()
    *   llOks = .t.
    *   If llOks And (pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts ...   -> Atualizar()
    *   EndIf
    *   If llOks
    *       If Not poDataMgr.Update('crSigOpMvv')  -> (ver nota abaixo)
    *   EndIf
    *   If llOks
    *       If (poDataMgr.Commit() < 1)
    *           =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                       'Falha na Conexao (Commit)')
    *           llOks = .f.
    *       EndIf
    *   EndIf
    *   If Not llOks
    *       poDataMgr.RollBack()
    *   EndIf
    *
    * O "poDataMgr.Update('crSigOpMvv')" do legado NAO tem linha propria
    * aqui: ele era o passo que mandava ao servidor as linhas em aberto do
    * cursor remoto do Fortyus (o INSERT legado grava no CURSOR, nao na
    * tabela). Nesta arquitetura Inserir() emite o INSERT direto em
    * SigOpMvv por SQLEXEC, de modo que o envio ja aconteceu - o passo
    * esta cumprido, nao descartado.
    *
    * O Commit(), ao contrario, NAO se descarta: medido neste ambiente,
    * SQLGETPROP(gnConnHandle, "Transactions") = 2 (MANUAL) e a conexao
    * nasce com @@TRANCOUNT = 1, isto eh o gravado fica preso na transacao
    * aberta e SOME se o processo cair - foi assim que um UPDATE migrado
    * sem o Commit do legado deixou de persistir sem erro na tela. O par
    * loc_lManual + SQLCOMMIT/SQLROLLBACK eh a forma segura usada no
    * projeto (SIGPRCNBBO): com a conexao em auto-commit o par fica
    * inerte, em vez de comitar a transacao de outra tela.
    *
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)": VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer jeito.
    *
    * Campo vazio devolve .F. sem mensagem nenhuma: o legado embrulha o
    * bloco inteiro em "If Not Empty(ldNew)", logo clicar Confirmar com a
    * data nova em branco nao faz nada - nem grava, nem avisa. Quem decide
    * se ha o que gravar eh o Form, que ja testa isso antes de chamar;
    * este guard existe para o metodo nunca gravar meia operacao se for
    * chamado isolado.
    *
    * this_lGravouPrazo (o "thisform.parentform.validOk = .t." do legado)
    * so permanece .T. quando TODA a cadeia passou - inclusive o commit.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9. Os dois RETURN antecipados ficam
    * FORA do bloco.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * BtnConfirmarClick() do Form, de FORA da classe - metodo que o Form
    * chama nunca pode ser PROTECTED em nenhum nivel da heranca
    * (regra #51).
    *====================================================================
    FUNCTION GravarAlteracaoPrazo()
        LOCAL loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .F.

        THIS.this_lGravouPrazo  = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .F.
        ENDIF

        *-- Conexao em transacao MANUAL (2) exige commit explicito; em
        *-- auto-commit (1) o par commit/rollback fica inerte.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        ENDIF

        TRY
            *-- Historico: arquiva a data que esta SAINDO (this_dPrazoAtual)
            loc_lSucesso = THIS.Inserir()

            *-- Cabecalho do movimento: recebe a data NOVA. Pulado quando o
            *-- form pai esta em ALTERAR - ali eh ele que grava SigMvCab
            *-- (guard do legado, ja dentro de Atualizar()).
            IF loc_lSucesso
                loc_lSucesso = THIS.Atualizar()
            ENDIF

            IF loc_lManual
                IF loc_lSucesso
                    IF SQLCOMMIT(gnConnHandle) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                        THIS.this_lErroExibido = .T.
                        = SQLROLLBACK(gnConnHandle)
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    *-- "If Not llOks / ThisForm.poDataMgr.RollBack()"
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDIF

            IF !loc_lSucesso
                THIS.this_lGravouPrazo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.GravarAlteracaoPrazo")
            THIS.this_lErroExibido = .T.
            THIS.this_lGravouPrazo = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

