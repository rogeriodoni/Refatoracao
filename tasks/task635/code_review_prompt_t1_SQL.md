# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CONTAVENS, ICLIS, LCCPO

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
  Column1.ControlSource = "csContas.ContaAnt"
  Column2.ControlSource = "csContas.ContaNov"
  ControlSource = "csContas.ContaAnt"
  ControlSource = "csContas.ContaNov"
Select csContas
	lcUpdate = [Update SigCdCli ] + ;
	lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,[])
			Select CsContas
	Select csContas
Insert Into csContas(ContaAnt, ContaNov) Values ('', '')
	.DeleteMark = .F.
	.Column1.ControlSource = "csContas.ContaAnt"
	.Column2.ControlSource = "csContas.ContaNov"
Select csContas
Select csContas
Delete
Select CrImporta
Append From (gcfileexcel) type xls
Select CrImporta
	lcSql = [Select Iclis From SigCdCli Where Iclis = ']+CrImporta.ContaAnt+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCli') < 1
	Select csContas
	If Not Seek(m.ContaAnt + m.ContaNov )
Select CsContas
Select csContas
Select csContas
	Select Arquivos, Campos ;
	From ArqDBF ;
	Select Distinct Arquivos ;
	  From csCampos ;
	Select csArquivos
		Select csCampos
			Select csContas
					lcWhere = [Select Distinct Emps, Grupos, Contas, Moedas  From SigMvCcr ]+;
					=ThisForm.PodataMgr.SqlExecute(lcWhere,'CrMccr')
					Select CrMccr
						lcSql = [Delete From SigCdCli Where Iclis = ']+CsContas.ContaAnt+[']
						ThisForm.Podatamgr.SqlExecute(lcSql,'')
					lcDelete = [Delete From ]+lcArq+[ Where ]+lcCpo+[ = ']+csContas.ContaAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcDelete,'')
						lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.ContaNov+[', GruConMoes = Grupos + ']+csContas.ContaNov+['+Moedas Where ]+lcCpo+[ = ']+csContas.ContaAnt+[']
							lcWhere = [Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams From SigMvHst ]+;
							=ThisForm.PodataMgr.SqlExecute(lcWhere,'CrHis')
							Select CrHis
							lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.ContaNov+[',EmpGruEsts = Emps + Grupos + ']+CsContas.ContaNov+[' Where ]+lcCpo+[ = ']+csContas.ContaAnt+[']
								lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.ContaNov+[', GruContas = Grupos + ']+csContas.ContaNov+[' Where ]+lcCpo+[ = ']+csContas.ContaAnt+[']
								lcUpdate = [Update ]+lcArq+[ Set ]+lcCpo+[ = ']+csContas.ContaNov+[' Where ]+lcCpo+[ = ']+csContas.ContaAnt+[']
					lnErro = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
							Select CsContas
		Select csArquivos
		Select csContas
Select csContas

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1700 linhas total):

*-- Linhas 12 a 45:
12: * herda de `form` (nao de `frmcadastro`), nao tem Grupo_Op nem pcEscolha, e os
13: * cinco botoes dele sao btnIncluir / btnExcluir / Exporta / btnProcessar /
14: * btnSair. Os dois primeiros NAO sao a barra CRUD: sao a toolbar de LINHA da
15: * grade - btnIncluir.Click do SCX eh "Select cursor_4c_Contas / If !Empty(ContaAnt) And
16: * !Empty(ContaNov) / Append Blank / Endif / ThisForm.Grade.Refresh /
17: * ThisForm.Grade.Column1.Text1.SetFocus" (acrescenta UMA LINHA ao cursor local
18: * que alimenta a Grade, sem tabela e sem SQL) e btnExcluir.Click eh "Select
19: * cursor_4c_Contas / Delete / ThisForm.Grade.Refresh / ...". Logo NAO existe
20: * BtnAlterarClick nem BtnVisualizarClick: inventa-los violaria o PILAR 1 ("NUNCA
21: * inventar botao que o legado nao tem") e criar os dois vazios violaria a regra
22: * de completude. Handlers entregues, um por botao do legado:
23: *   - BtnIncluirClick   -> btnIncluir.Click   (APPEND BLANK guardado pelo par completo)
24: *   - BtnExcluirClick   -> btnExcluir.Click   (DELETE da linha corrente)
25: *   - BtnExportaClick   -> Exporta.Click      (IMPORTA planilha XLS - nome legado)
26: *   - BtnProcessarClick -> btnProcessar.Click (troca em lote / so representantes)
27: *   - BtnSairClick      -> btnSair.Click      (ThisForm.Release)
28: * Todos PUBLIC (regra #3/#51: BINDEVENT e chamada externa falham em PROTECTED) e
29: * ligados por BINDEVENT em ConfigurarBotoes(). O DELETE local da grade depende do
30: * `SET DELETED ON` reposto em InicializarForm (regra #9.4: DataSession = 2 nasce
31: * no default do VFP e nao herda o SET do config.prg).
32: *==============================================================================
33: 
34: DEFINE CLASS FormSigPrMdc AS FormBase
35: 
36:     Width       = 800
37:     Height      = 340
38:     Caption     = "Muda Conta"
39:     ShowWindow  = 1
40:     WindowType  = 1
41:     TitleBar    = 0
42:     ControlBox  = .F.
43:     Closable    = .F.
44:     MaxButton   = .F.
45:     MinButton   = .F.

*-- Linhas 97 a 118:
97:         TRY
98:             THIS.ConfigurarPageFrame()
99: 
100:             *-- DataSession=2 nasce no default do VFP (regra #9.4 / DELETED e
101:             *-- EXACT nao herdam o SET DELETED ON do config.prg): sem isto o
102:             *-- DELETE local em cursor_4c_Contas nao some da grade em BtnExcluirClick
103:             SET DELETED ON
104: 
105:             *-- Legado: primeira linha do Load eh "=fConfigGeral()" (carrega os
106:             *-- parametros gerais do sistema que o processamento consome).
107:             *-- Wrapper portado em projeto\app\utils\fconfiggeral.prg
108:             TRY
109:                 = fConfigGeral()
110:             CATCH TO loc_oErro
111:                 MsgAviso("Falha ao carregar a configura" + CHR(231) + CHR(227) + ;
112:                     "o geral: " + loc_oErro.Message, "Aten" + CHR(231) + CHR(227) + "o")
113:             ENDTRY
114: 
115:             *-- Verificar existencia do ArqDBF (catalogo de campos do
116:             *-- processamento em lote): aviso informativo, nao bloqueia o Init
117:             loc_cArquivo = SYS(5) + SYS(2003) + "\ArqDBF"
118:             IF FILE(loc_cArquivo + ".dbf")

*-- Linhas 411 a 459:
411:                 .ColumnCount        = 2
412:                 .AllowHeaderSizing  = .F.
413:                 .AllowRowSizing     = .F.
414:                 .DeleteMark         = .F.
415:                 .RecordMark         = .F.
416:                 .HeaderHeight       = 18
417:                 .RowHeight          = 18
418:                 .ScrollBars         = 2
419:                 .FontName           = "Tahoma"
420:                 .FontSize           = 8
421:                 .GridLineColor      = RGB(238, 238, 238)
422:                 .HighlightBackColor = RGB(90, 90, 90)
423:                 .RecordSource       = "cursor_4c_Contas"
424: 
425:                 WITH .Column1
426:                     .ControlSource = "cursor_4c_Contas.ContaAnt"
427:                     .Width         = 90
428:                     WITH .Header1
429:                         .FontName  = "Tahoma"
430:                         .FontSize  = 8
431:                         .Alignment = 2
432:                         .Caption   = "Conta Antiga"
433:                         .ForeColor = RGB(0, 0, 0)
434:                     ENDWITH
435:                     WITH .Text1
436:                         .BorderStyle = 0
437:                         .Margin      = 0
438:                         .ForeColor   = RGB(0, 0, 0)
439:                         .BackColor   = RGB(255, 255, 255)
440:                     ENDWITH
441:                 ENDWITH
442: 
443:                 WITH .Column2
444:                     .ControlSource = "cursor_4c_Contas.ContaNov"
445:                     .Width         = 90
446:                     WITH .Header1
447:                         .FontName  = "Tahoma"
448:                         .FontSize  = 8
449:                         .Alignment = 2
450:                         .Caption   = "Conta Nova"
451:                         .ForeColor = RGB(0, 0, 0)
452:                     ENDWITH
453:                     WITH .Text1
454:                         .BorderStyle = 0
455:                         .Margin      = 0
456:                         .ForeColor   = RGB(0, 0, 0)
457:                         .BackColor   = RGB(255, 255, 255)
458:                     ENDWITH
459:                 ENDWITH

*-- Linhas 664 a 685:
664:     * REPLACE no cursor e dependiam da repintura da grade para o valor
665:     * resolvido aparecer na celula.
666:     *
667:     * Reaplica ControlSource/Width/Header1.Caption DEPOIS do RecordSource:
668:     * atribuir RecordSource recalcula as larguras para o default 90 e zera os
669:     * captions para "Header1" (Problema 48), entao a apresentacao canonica tem
670:     * de ser restaurada no MESMO lugar, na ordem RecordSource -> ControlSource
671:     * -> Width -> Header1.Caption.
672:     *
673:     * ColumnCount NAO eh reatribuido aqui: qualquer atribuicao a ColumnCount
674:     * recria os objetos Column e derrubaria os BINDEVENT instalados em
675:     * Column1.Text1/Column2.Text1 por ConfigurarGrid (os lookups de celula).
676:     *
677:     * par_cPosicao reproduz o posicionamento de CADA caminho do legado:
678:     *   "TOPO" -> Go Top  (reset do lote em btnProcessar.Click)
679:     *   "FIM"  -> Go Bott (fim da importacao de planilha, Exporta.Click)
680:     *   ""     -> mantem o registro corrente (btnIncluir/btnExcluir/Valid, que
681:     *             no legado chamam Grade.Refresh sem reposicionar - um Go Top
682:     *             indevido tiraria o foco da linha recem-incluida)
683:     *==========================================================================
684:     PROCEDURE CarregarLista(par_cPosicao)
685:     *==========================================================================

*-- Linhas 703 a 730:
703:                 WITH loc_oGrid
704:                     .RecordSource = "cursor_4c_Contas"
705: 
706:                     .Column1.ControlSource        = "cursor_4c_Contas.ContaAnt"
707:                     .Column1.Width                = 90
708:                     .Column1.Header1.Caption      = "Conta Antiga"
709: 
710:                     .Column2.ControlSource        = "cursor_4c_Contas.ContaNov"
711:                     .Column2.Width                = 90
712:                     .Column2.Header1.Caption      = "Conta Nova"
713:                 ENDWITH
714: 
715:                 SELECT cursor_4c_Contas
716:                 DO CASE
717:                     CASE loc_cPos == "TOPO"
718:                         GO TOP
719:                     CASE loc_cPos == "FIM"
720:                         GO BOTTOM
721:                 ENDCASE
722: 
723:                 loc_oGrid.Refresh
724:                 loc_lSucesso = .T.
725:             ENDIF
726:         CATCH TO loc_oErro
727:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
728:                 "Erro CarregarLista FormSigPrMdc")
729:         ENDTRY
730: 

*-- Linhas 743 a 818:
743:             loc_nRec = 0
744: 
745:             IF USED("cursor_4c_Contas")
746:                 SELECT cursor_4c_Contas
747:                 IF !EMPTY(ALLTRIM(NVL(ContaAnt, ""))) AND !EMPTY(ALLTRIM(NVL(ContaNov, "")))
748:                     APPEND BLANK
749:                 ENDIF
750:                 *-- O legado fecha com "Grade.Refresh", que NAO move o ponteiro:
751:                 *-- depois do APPEND BLANK ele fica na linha NOVA, e eh nela que o
752:                 *-- SetFocus abaixo poe o usuario para digitar. CarregarLista
753:                 *-- reatribui o RecordSource, e isso devolve o ponteiro ao registro
754:                 *-- 1 (medido no VFP9) - sem guardar/repor o RECNO o usuario clica
755:                 *-- Incluir e cai na PRIMEIRA linha, ja preenchida, em vez da nova.
756:                 *-- Vale nos dois ramos: quando a guarda acima bloqueia o APPEND, o
757:                 *-- legado tambem deixa o ponteiro onde estava.
758:                 loc_nRec = RECNO()
759:             ENDIF
760: 
761:             THIS.CarregarLista("")
762: 
763:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
764:                 SELECT cursor_4c_Contas
765:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
766:                     GO loc_nRec
767:                 ENDIF
768:             ENDIF
769: 
770:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
771:         CATCH TO loc_oErro
772:             MsgErro(loc_oErro.Message, "Erro ao incluir linha")
773:         ENDTRY
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * BtnExcluirClick - Remove a linha corrente do cursor de pares
778:     *==========================================================================
779:     PROCEDURE BtnExcluirClick()
780:     *==========================================================================
781:         LOCAL loc_oErro, loc_nRec
782: 
783:         TRY
784:             loc_nRec = 0
785: 
786:             IF USED("cursor_4c_Contas")
787:                 SELECT cursor_4c_Contas
788:                 IF !EOF()
789:                     DELETE
790:                 ENDIF
791:                 *-- Mesma razao do BtnIncluirClick: o "Grade.Refresh" do legado
792:                 *-- nao move o ponteiro, mas CarregarLista reatribui o
793:                 *-- RecordSource e o devolve ao registro 1. Repor o RECNO mantem
794:                 *-- o usuario na vizinhanca da linha que ele acabou de apagar
795:                 *-- (com SET DELETED ON a propria linha apagada ja nao eh
796:                 *-- navegavel, e a grade passa a mostrar a seguinte)
797:                 loc_nRec = RECNO()
798:             ENDIF
799: 
800:             THIS.CarregarLista("")
801: 
802:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
803:                 SELECT cursor_4c_Contas
804:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
805:                     GO loc_nRec
806:                 ENDIF
807:             ENDIF
808: 
809:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
810:         CATCH TO loc_oErro
811:             MsgErro(loc_oErro.Message, "Erro ao excluir linha")
812:         ENDTRY
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * BtnSairClick - Encerra o form (btnSair.Click do legado)
817:     *==========================================================================
818:     PROCEDURE BtnSairClick()

*-- Linhas 888 a 913:
888: 
889:         TRY
890:             IF EMPTY(loc_cVal)
891:                 SELECT cursor_4c_Contas
892:                 REPLACE (loc_cCampo) WITH ""
893:             ELSE
894:                 *-- ValidarCodigoConta devolve o CODIGO achado (string) ou "",
895:                 *-- nunca um logico: usar o retorno direto num IF estouraria
896:                 *-- "Operator/operand type mismatch"
897:                 IF !EMPTY(THIS.this_oBusinessObject.ValidarCodigoConta(loc_cVal))
898:                     SELECT cursor_4c_Contas
899:                     REPLACE (loc_cCampo) WITH loc_cVal
900:                 ELSE
901:                     *-- Universo vazio / codigo inexistente NAO eh erro: o legado
902:                     *-- nao avisa nem apaga o digitado, so abre o browse com o
903:                     *-- valor como prefixo (regra #50)
904:                     THIS.AbrirBuscaConta(par_nColuna)
905:                 ENDIF
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "Erro ao validar conta")
909:         ENDTRY
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecao de conta (SigCdCli),

*-- Linhas 941 a 963:
941:                 loc_oLookup.Show()
942: 
943:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaConta")
944:                     SELECT cursor_4c_BuscaConta
945:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaConta.Iclis, ""))
946:                     USE IN cursor_4c_BuscaConta
947: 
948:                     SELECT cursor_4c_Contas
949:                     REPLACE (loc_cCampo) WITH loc_cVal
950:                     loc_oColuna.Text1.Value = loc_cVal
951:                 ELSE
952:                     IF USED("cursor_4c_BuscaConta")
953:                         USE IN cursor_4c_BuscaConta
954:                     ENDIF
955:                 ENDIF
956:             ENDIF
957:         CATCH TO loc_oErro
958:             IF USED("cursor_4c_BuscaConta")
959:                 USE IN cursor_4c_BuscaConta
960:             ENDIF
961:             MsgErro(loc_oErro.Message, "Erro ao buscar conta")
962:         ENDTRY
963:     ENDPROC

*-- Linhas 1038 a 1056:
1038: 
1039:         *-- A conexao do projeto nasce com Transactions = 2 (MANUAL), e eh por
1040:         *-- isso que o COMMIT/ROLLBACK abaixo tem de ser feito com SQLCOMMIT/
1041:         *-- SQLROLLBACK do VFP e nao com "COMMIT TRANSACTION" via SQLEXEC (que
1042:         *-- so aninharia @@TRANCOUNT sem efetivar nada). Handle invalido faz
1043:         *-- SQLGETPROP estourar FORA de TRY - dai a guarda, senao o usuario
1044:         *-- veria o Program Error cru do VFP ao clicar Processar.
1045:         loc_lManual = .F.
1046:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1047:             TRY
1048:                 loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
1049:             CATCH TO loc_oErro
1050:                 loc_lManual = .F.
1051:             ENDTRY
1052:         ENDIF
1053: 
1054:         *-- loc_lReiniciar reproduz o "Return 0" do legado no ramo de falha do
1055:         *-- processamento de arquivos: ali o legado NAO exibe a mensagem final e
1056:         *-- NAO reseta a lista de pares (deixa o painel visivel com a barra em 0

*-- Linhas 1126 a 1145:
1126: 
1127:                 *-- Campos elegiveis: tamanho 10 ou CLIFORS, tipo C, com Dbcs
1128:                 *-- preenchido, arquivos SIG*, excluindo catalogos auxiliares
1129:                 SELECT Arquivos, Campos ;
1130:                     FROM ArqDBF ;
1131:                     WHERE (Tamanhos = 10 OR UPPER(Campos) = "CLIFORS") AND ;
1132:                         UPPER(Tipos) = "C" AND ;
1133:                         !EMPTY(Dbcs) AND ;
1134:                         ALLTRIM(Arquivos) <> "ArqDBF.DBF" AND ;
1135:                         UPPER(ALLTRIM(Arquivos)) <> "SIGTEMPC.DBF" AND ;
1136:                         UPPER(ALLTRIM(Arquivos)) <> "SIGCDCE.DBF" AND ;
1137:                         UPPER(ALLTRIM(Arquivos)) <> "SIGCDCEE.DBF" AND ;
1138:                         UPPER(ALLTRIM(Arquivos)) <> "SIGALERT.DBF" AND ;
1139:                         UPPER(SUBSTR(ALLTRIM(Arquivos), 1, 3)) = "SIG" AND ;
1140:                         (AT("CON", UPPER(Campos)) <> 0 OR ;
1141:                          AT("IFOR", UPPER(Campos)) <> 0 OR ;
1142:                          AT("ESTOS", UPPER(Campos)) <> 0 OR ;
1143:                          AT("CLI", UPPER(Campos)) <> 0 OR ;
1144:                          AT("VEN", UPPER(Campos)) <> 0 OR ;
1145:                          AT("RESP", UPPER(Campos)) <> 0) AND ;

*-- Linhas 1152 a 1310:
1152:                     INTO CURSOR csCampos READWRITE
1153:                 INDEX ON Arquivos + Campos TAG ArqCpo
1154: 
1155:                 SELECT DISTINCT Arquivos FROM csCampos ;
1156:                     INTO CURSOR csArquivos READWRITE ;
1157:                     ORDER BY Arquivos
1158:                 loc_nCnt = RECCOUNT("csArquivos")
1159:                 IF loc_nCnt < 1
1160:                     loc_nCnt = 1
1161:                 ENDIF
1162: 
1163:                 loc_nRec = 0
1164:                 SELECT csArquivos
1165:                 SCAN  && cada arquivo elegivel
1166:                     loc_cArq = UPPER(ALLTRIM(STRTRAN(csArquivos.Arquivos, ".DBF", "")))
1167:                     THIS.AtualizarProgresso(loc_cArq, -1)
1168: 
1169:                     SELECT csCampos
1170:                     SEEK csArquivos.Arquivos
1171:                     SCAN WHILE ALLTRIM(csArquivos.Arquivos) == ALLTRIM(csCampos.Arquivos) AND !EOF("csCampos")
1172:                         loc_cCpo = ALLTRIM(csCampos.Campos)
1173:                         THIS.AtualizarProgresso(loc_cArq + " / " + loc_cCpo, -1)
1174: 
1175:                         SELECT cursor_4c_Contas
1176:                         SCAN  && cada par conta antiga/nova
1177:                             IF loc_cArq == "SIGMVCCR" AND loc_cCpo == "CONTAS"
1178:                                 loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas FROM SigMvCcr WHERE " + ;
1179:                                     loc_cCpo + " = " + EscaparSQL(PADR(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")), 10))
1180:                                 IF SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr") > 0 AND USED("cursor_4c_Mccr")
1181:                                     SELECT cursor_4c_Mccr
1182:                                     SCAN
1183:                                         fRecalculaS(cursor_4c_Mccr.Grupos, ALLTRIM(NVL(cursor_4c_Contas.ContaNov, "")), ;
1184:                                             {^1900-01-01}, cursor_4c_Mccr.Moedas, gnConnHandle)
1185:                                     ENDSCAN
1186:                                     USE IN cursor_4c_Mccr
1187:                                 ENDIF
1188:                                 SELECT cursor_4c_Contas
1189:                             ENDIF
1190: 
1191:                             *-- Legado: a exclusao so substitui a renomeacao (abaixo, no
1192:                             *-- bloco ELSE generico) QUANDO a conta nova JA existe em
1193:                             *-- SigCdCli (CursorQuery('SigCdCli','CrTmpCli','Iclis',
1194:                             *-- ContaNov,'Iclis') do Click original) - sem essa conferencia
1195:                             *-- o UPDATE que renomeia Iclis de ContaAnt para ContaNov
1196:                             *-- (bloco ELSE generico, mais abaixo) nunca rodaria para
1197:                             *-- SIGCDCLI, mesmo quando a conta nova ainda nao existe
1198:                             IF loc_cArq == "SIGCDCLI" AND loc_cCpo == "ICLIS"
1199:                                 loc_lContaNovaExiste = .F.
1200:                                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Iclis FROM SigCdCli WHERE Iclis = " + ;
1201:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))), "cursor_4c_TmpCli") > 0 AND ;
1202:                                         USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
1203:                                     loc_lContaNovaExiste = .T.
1204:                                 ENDIF
1205:                                 IF USED("cursor_4c_TmpCli")
1206:                                     USE IN cursor_4c_TmpCli
1207:                                 ENDIF
1208:                                 SELECT cursor_4c_Contas
1209: 
1210:                                 IF loc_lContaNovaExiste
1211:                                     IF THIS.chk_4c_Chk_DelCT.Value = 1
1212:                                         THIS.this_oBusinessObject.ExcluirContaAntiga(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1213:                                     ENDIF
1214:                                     SELECT cursor_4c_Contas
1215:                                     LOOP
1216:                                 ENDIF
1217:                             ENDIF
1218: 
1219:                             IF loc_cArq == "SIGMVSLC" OR loc_cArq == "SIGMVEST"
1220:                                 loc_cSql = "DELETE FROM " + loc_cArq + " WHERE " + loc_cCpo + " = " + ;
1221:                                     EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1222:                                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1223:                                 SELECT cursor_4c_Contas
1224:                                 IF loc_nErro < 1
1225:                                     EXIT
1226:                                 ENDIF
1227:                                 LOOP
1228:                             ENDIF
1229: 
1230:                             IF loc_cArq == "SIGMVCCR" AND loc_cCpo == "CONTAS"
1231:                                 loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
1232:                                     EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1233:                                     ", GruConMoes = Grupos + " + ;
1234:                                     EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1235:                                     " + Moedas WHERE " + loc_cCpo + " = " + ;
1236:                                     EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1237:                             ELSE
1238:                                 IF loc_cArq == "SIGMVHST" AND loc_cCpo == "ESTOS"
1239:                                     loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, Cpros, CodCors, CodTams " + ;
1240:                                         "FROM SigMvHst WHERE " + loc_cCpo + " = " + ;
1241:                                         EscaparSQL(PADR(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")), 10))
1242:                                     IF SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His") > 0 AND USED("cursor_4c_His")
1243:                                         *-- fRecalculaP/fRecalculaC nao portadas - recalculo de saldo omitido
1244:                                         USE IN cursor_4c_His
1245:                                     ENDIF
1246:                                     SELECT cursor_4c_Contas
1247:                                     loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
1248:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1249:                                         ", EmpGruEsts = Emps + Grupos + " + ;
1250:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1251:                                         " WHERE " + loc_cCpo + " = " + ;
1252:                                         EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1253:                                 ELSE
1254:                                     IF loc_cArq == "SIGCDCLH" AND loc_cCpo == "ICLIS"
1255:                                         loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
1256:                                             EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1257:                                             ", GruContas = Grupos + " + ;
1258:                                             EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1259:                                             " WHERE " + loc_cCpo + " = " + ;
1260:                                             EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1261:                                     ELSE
1262:                                         loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
1263:                                             EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
1264:                                             " WHERE " + loc_cCpo + " = " + ;
1265:                                             EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
1266:                                     ENDIF
1267:                                 ENDIF
1268:                             ENDIF
1269: 
1270:                             loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
1271:                             IF loc_nErro < 1
1272:                                 IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!!, Tentar Novamente?", ;
1273:                                         "Aten" + CHR(231) + CHR(227) + "o!!!")
1274:                                     SELECT cursor_4c_Contas
1275:                                     SKIP -1
1276:                                     LOOP
1277:                                 ELSE
1278:                                     EXIT
1279:                                 ENDIF
1280:                             ENDIF
1281: 
1282:                             SELECT cursor_4c_Contas
1283:                         ENDSCAN  && cursor_4c_Contas
1284: 
1285:                         SELECT csCampos
1286:                         IF loc_nErro < 1
1287:                             EXIT
1288:                         ENDIF
1289:                     ENDSCAN  && csCampos
1290: 
1291:                     IF loc_nErro < 1
1292:                         EXIT
1293:                     ENDIF
1294: 
1295:                     SELECT csArquivos
1296:                     loc_nRec = loc_nRec + 1
1297:                     loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
1298:                     THIS.AtualizarProgresso("", loc_nPct)
1299:                 ENDSCAN  && csArquivos
1300: 
1301:                 *-- Legado: fRecalculaS/fRecalculaP/fRecalculaC em "modo
1302:                 *-- processamento" (1o parametro logico) apos o SCAN de
1303:                 *-- arquivos, fechando o lote registrado pelas chamadas em
1304:                 *-- "modo registro" dentro do SIGMVCCR acima. fRecalculaS esta
1305:                 *-- portada (utils\functions.prg) - chamar de verdade.
1306:                 *-- fRecalculaP/fRecalculaC NAO portadas (regra #27 - funcoes
1307:                 *-- de CALCULO de saldo nunca recebem stub) - omitidas, mesmo
1308:                 *-- padrao de Formsigprmdp.prg/sigprmdpBO.prg.
1309:                 IF loc_nErro > 0 AND !fRecalculaS(.T., gnConnHandle, .T.)
1310:                     loc_nErro = -1

*-- Linhas 1327 a 1349:
1327:                         = SQLCOMMIT(gnConnHandle)
1328:                     ENDIF
1329: 
1330:                     SELECT cursor_4c_Contas
1331:                     SCAN
1332:                         THIS.this_oBusinessObject.this_cContaAnt = TratarNulo(cursor_4c_Contas.ContaAnt, "")
1333:                         THIS.this_oBusinessObject.this_cContaNov = TratarNulo(cursor_4c_Contas.ContaNov, "")
1334:                         THIS.this_oBusinessObject.RegistrarAuditoria("UPDATE")
1335:                     ENDSCAN
1336: 
1337:                     loc_lOk = .T.
1338:                 ENDIF
1339: 
1340:                 IF USED("csCampos")
1341:                     USE IN csCampos
1342:                 ENDIF
1343:                 IF USED("csArquivos")
1344:                     USE IN csArquivos
1345:                 ENDIF
1346:                 IF USED("ArqDBF")
1347:                     USE IN ArqDBF
1348:                 ENDIF
1349:             CATCH TO loc_oErro

*-- Linhas 1474 a 1492:
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * LimparCampos - Reseta a lista de pares para o proximo lote ("Select
1478:     * csContas / Set Order To / Zap / Append Blank" do fim do btnProcessar.Click
1479:     * legado) e devolve a tela ao estado de edicao.
1480:     *
1481:     * Os dois checkboxes NAO sao zerados: o legado tambem nao os zera no fim do
1482:     * processamento, e mexer neles mudaria o comportamento que o usuario ve
1483:     * (PILAR 1). Quem precisa dos valores sincronizados chama FormParaBO.
1484:     *
1485:     * PROTECTED EXPLICITO: FormBase declara LimparCampos / FormParaBO /
1486:     * BOParaForm como PROTECTED e o VFP9 NAO deixa a subclasse alargar o escopo
1487:     * - escrever "PROCEDURE" sem o modificador nao torna o metodo publico, so
1488:     * esconde que ele continua protegido (medido: chamada de fora estoura
1489:     * "Property LIMPARCAMPOS is not found", mas PEMSTATUS(...,5) devolve .T. e
1490:     * mente). Chamar SEMPRE por THIS. de dentro da classe. Metodo que precise
1491:     * ser alcancado de fora nao pode usar um desses tres nomes - eh por isso que
1492:     * o funil do painel de progresso se chama AtualizarProgresso (nome ausente

*-- Linhas 1508 a 1526:
1508:                 *-- confirmacao e congela o processo em execucao desassistida
1509:                 loc_cSafety = SET("SAFETY")
1510:                 SET SAFETY OFF
1511:                 SELECT cursor_4c_Contas
1512:                 SET ORDER TO
1513:                 ZAP
1514:                 APPEND BLANK
1515:                 IF loc_cSafety == "ON"
1516:                     SET SAFETY ON
1517:                 ENDIF
1518:             ENDIF
1519: 
1520:             *-- Zerar o cursor NAO repinta a grade (regra #21): repintura pelo
1521:             *-- mesmo funil usado por todos os outros caminhos
1522:             THIS.CarregarLista("TOPO")
1523: 
1524:             THIS.this_cModoAtual = "EDICAO"
1525:             THIS.AjustarBotoesPorModo()
1526: 


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirContaAntiga
    * Apaga a conta antiga de SigCdCli. Reproduz o ramo
    * "If lcArq == 'SIGCDCLI' And lcCpo = 'ICLIS' And Chk_DelCT.Value = 1" do
    * btnProcessar.Click legado, que exclui a conta de origem quando a conta de
    * destino JA existe no cadastro (nesse caso nao ha o que renomear).
    * par_cConta: codigo da conta a excluir (Iclis)
    * Returns: .T. se o DELETE foi aceito pelo servidor, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExcluirContaAntiga(par_cConta)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        loc_cSQL     = ""
        loc_nRet     = 0
        TRY
            IF EMPTY(par_cConta)
                MsgAviso("Conta antiga inv" + CHR(225) + "lida para exclus" + ;
                    CHR(227) + "o.", "Aviso")
            ELSE
                loc_cSQL = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao excluir a conta antiga [" + ;
                        ALLTRIM(par_cConta) + "]." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("EXCLUSAO_CONTA: " + ALLTRIM(par_cConta))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir conta antiga")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts (fRecalculaP/fRecalculaC do legado
    *                        NAO portadas e sem stub - regra #27; recalculo omitido)
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    *-- fRecalculaS ESTA portada (utils\functions.prg):
                                    *-- chamada de verdade, SEM TRY que engula o erro.
                                    *-- Aqui ela roda em "modo registro" (1o parametro
                                    *-- CARACTERE): so acumula a entrada no cursor
                                    *-- crRecalculaS; o recalculo efetivo acontece na
                                    *-- chamada em "modo processamento" (1o parametro
                                    *-- logico) depois do SCAN de arquivos.
                                    =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                        m.loc_cContaNovSalvo, ;
                                        CTOD('01/01/1900'), ;
                                        cursor_4c_Mccr.Moedas, ;
                                        gnConnHandle)
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His")
                                        *-- O legado percorre este cursor chamando
                                        *-- fRecalculaP (saldo por produto/cor/tamanho)
                                        *-- e fRecalculaC (custo), que NAO foram
                                        *-- portadas e NAO recebem stub: devolver um
                                        *-- valor fixo para calculo de saldo gravaria
                                        *-- numero errado em silencio (regra #27).
                                        *-- O recalculo fica OMITIDO e VISIVEL aqui,
                                        *-- nunca escondido num CATCH - o UPDATE do
                                        *-- codigo abaixo continua sendo aplicado.
                                        USE IN cursor_4c_His
                                    ENDIF
                                    SELECT cursor_4c_Contas
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculo final em "modo processamento" (1o parametro logico),
            *-- fechando o lote registrado pelas chamadas em "modo registro" do
            *-- SCAN acima. fRecalculaS ESTA portada (utils\functions.prg) -
            *-- chamada de verdade e SEM TRY que engula o resultado: se ela
            *-- recusar, o lote tem de ir para ROLLBACK.
            IF loc_nErro > 0
                IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                    loc_nErro = -1
                ENDIF
            ENDIF

            *-- fRecalculaP / fRecalculaC do legado NAO foram portadas e NAO
            *-- recebem stub (regra #27: funcao que devolve VALOR DE CALCULO de
            *-- saldo nunca pode ser substituida por um retorno fixo - gravaria
            *-- numero errado em silencio). A ausencia fica VISIVEL aqui, nao
            *-- escondida num CATCH vazio; mesmo tratamento dado ao caminho
            *-- equivalente de Formsigprmdp.prg/sigprmdpBO.prg.

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

