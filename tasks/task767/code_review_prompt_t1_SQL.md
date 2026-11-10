# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, TOTA, CDOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, TOTA, CDOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, TOTA, CDOPES

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
  Column1.ControlSource = ""
lcSql = [Select Dopes, GerOpes, OpeInatvs From SigOpCdc ]
SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
Select LocalDcOpe
=Seek(CrSigCdOpe.Dopes)
		SELECT crSigCdMop
Select crSigCdMop
	.Column1.ControlSource = 'crSigCdMop.cNivels'
	.Column2.ControlSource = 'crSigCdMop.nDopes'
	.Column3.ControlSource = 'crSigCdMop.nCors'
	.Column4.ControlSource = 'crSigCdMop.Padraos'
	.Column5.ControlSource = 'crSigCdMop.Ordems'
	.Column6.ControlSource = 'crSigCdMop.Mercs'
	.Column7.ControlSource = 'crSigCdMop.EmpDs'
	=Seek(cpSigCdOpe.Dopes,'LocalDcOpe','Dopes')
Select CrSigCdMop
Select crSigCdMop
	Update crSigCdMop Set padraos = 0
	Update crSigCdMop Set padraos = 0 Where Recno() # lnRecno
	Update crSigCdMop Set padraos = 1 Where Recno() = lnRecno
	Select crSigCdMop
Select crSigCdMop
Select crSigCdMop
	Delete
		Select CrSigCdMop
		Select cNivels as Dopes,Mercs,EmpDs,sum(1) as TT From CrSigCdMop GROUP by 1,2,3 Into cursor Totais
		Select Totais
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
Select crSigCdMop
	Insert Into crSigCdMop (cDopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select crSigCdMop

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpMop.prg) - TRECHOS RELEVANTES PARA PASS SQL (2939 linhas total):

*-- Linhas 92 a 110:
92: * do form (regra #47).
93: *
94: * Sem conexao (harness/validacao de UI) nenhum dos tres lookups roda e o valor
95: * digitado eh aceito como esta: SQLEXEC com handle invalido dispara excecao, e
96: * Show() de form MODAL em teste headless travaria o processo.
97: *
98: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: BtnInserirClick/BtnExcluirClick
99: * (cmd_4c_CmdInserir/cmd_4c_CmdExcluir, TRANSCRITOS do Click do legado) e
100: * BtnEncerrarClick (cmd_4c_CmdSair - nome CANONICO que TesteAutomatico.prg
101: * procura), mais a alternancia exclusiva do CheckBox "Padrao" (Column4),
102: * instalada em GarantirCheckBoxPadrao com os 4 handlers Click/MouseDown/
103: * MouseUp/KeyPress + NODEFAULT (checkbox em coluna de Grid NAO alterna pelo
104: * binding nativo), e ControlarBotoesFormPai - equivalente ao mCtrlBotoes do
105: * legado, chamado por HabilitarFormPai com o MESMO par_lHabilitar, que
106: * desliga/religa granularmente os botoes do form chamador (FormOPE: o grupo
107: * CRUD cnt_4c_Botoes, cmd_4c_MultiSubN e cnt_4c_Saida.cmd_4c_Encerrar, todos
108: * na Page1 - Lista).
109: *
110: * Fase 8/8 - CONSOLIDACAO FINAL (gravacao): o bloco interno do cmdSair.Click

*-- Linhas 116 a 186:
116: *       flags lHouveIns/lHouveExcl) e os DOIS desfechos distintos do legado:
117: *       duplicidade ABORTA o encerramento ("Return .f." de dentro do Click),
118: *       falha de gravacao apenas avisa e a tela fecha.
119: *   ValidarDuplicidadeGrade - o "Select ... GROUP by 1,2,3 Into cursor Totais"
120: *       + Scan por TT > 1, agrupando por cNivels + Mercs + EmpDs.
121: *   GravarGrade       - o "poDataMgr.UpDate('crSigCdMop')" + Commit/RollBack.
122: *       Como o cursor desta arquitetura nao tem buffer de view remota (regra
123: *       #52), o estado novo/alterado/apagado eh RECONSTRUIDO por
124: *       RECONCILIACAO contra o banco, com UMA consulta de chaves
125: *       (BO.CarregarChavesGravadas) - ver o comentario do metodo.
126: *   LocalizarChave    - a busca de chave usada pela reconciliacao, por LOCATE
127: *       com ALLTRIM (SET EXACT ON torna SEEK sobre char(20) dependente do
128: *       padding exato - regra #42) e preservando alias/RECNO do chamador.
129: *   FormParaBO / BOParaForm - transferencia linha-da-grade <-> BO. A "ficha"
130: *       desta tela eh a LINHA da grade, nao uma pagina de Dados: as nove
131: *       colunas do cursor sao as nove colunas de SigCdMop. Os dois sao
132: *       PROTECTED **EXPLICITO**: FormBase.prg declara os dois nomes como
133: *       PROTECTED e VFP9 NAO deixa a subclasse alargar esse escopo - omitir o
134: *       modificador nao os tornaria publicos, so esconderia o fato. Quem os
135: *       chama eh GravarGrade, por THIS., de dentro da classe.
136: *   CarregarLista     - entrada PUBLICA de recarga da superficie de lista (que
137: *       aqui eh a grade), preservando a linha corrente pela cidchaves.
138: *
139: * Tambem nesta fase, no BO: ExecutarExclusao (sem ele a linha apagada na grade
140: * ficava no banco), CarregarChavesGravadas, ConfirmarGravacao/DesfazerGravacao
141: * (o par Commit/RollBack, que eh passo com caminho de falha PROPRIO no legado e
142: * nao detalhe de infraestrutura) e a troca do INNER JOIN de CarregarGrade por
143: * LEFT JOIN - sem ela a linha de cnivels em branco, que o legado grava, nao
144: * voltava do banco e a reconciliacao a APAGARIA em silencio.
145: *
146: * O QUE A FASE 8 NAO ENTREGA, e por que (medido no dump, nao presumido):
147: *   - BtnSalvarClick / BtnCancelarClick / BtnBuscarClick: a SECAO 1 do dump
148: *     lista 25 objetos e os UNICOS CommandButton sao cmdInserir, cmdExcluir e
149: *     cmdSair, os tres com "Parent: SIGOPMOP". Nao ha Salvar, nao ha Cancelar e
150: *     nao ha Buscar - a gravacao mora no cmdSair ("Encerrar"), que eh quem roda
151: *     o UpDate/Commit, e nao existe edicao cancelavel: a grade escreve direto no
152: *     cursor. Criar esses handlers exigiria inventar botoes que o legado nao tem
153: *     (contra o PILAR 1) ou deixar metodos vazios (contra a regra de
154: *     completude).
155: *   - AjustarBotoesPorModo / HabilitarCampos / LimparCampos: convencao do
156: *     frmcadastro, que tem Page1(Lista)/Page2(Dados) e modos INCLUIR/ALTERAR/
157: *     VISUALIZAR/EXCLUIR. O SCX aqui herda de "form" PURO, nao declara
158: *     PageFrame nenhum e nao tem modo proprio - o unico "modo" eh o do form PAI
159: *     (PcEscolha), e ele ja eh aplicado por AplicarPermissoesBotoes
160: *     (visibilidade de Inserir/Excluir, transcrita do Init legado) e pelo When
161: *     das celulas. Em particular, travar a grade em PROCURAR seria DIVERGIR: o
162: *     legado deixa as celulas editaveis em consulta e impede a gravacao pelo
163: *     guard de visibilidade do cmdSair - e eh esse guard que BtnEncerrarClick
164: *     reproduz.
165: *
166: * NAO HA container de Salvar/Cancelar para esta fase entregar, e isso foi LIDO
167: * no dump: a SECAO 1 lista 25 objetos e os unicos CommandButton sao
168: * cmdInserir, cmdExcluir e cmdSair, os tres com "Parent: SIGOPMOP" e os tres
169: * JA criados na Fase 4. Esta tela nao eh um frmcadastro: nao tem pagina de
170: * Dados, nao tem Grupo_Salva e nao tem o par Confirmar/Cancelar. A gravacao
171: * mora no cmdSair ("Encerrar"), que eh quem roda o UpDate/Commit do legado -
172: * criar aqui um cnt_4c_BotoesAcao com Salvar/Cancelar inventaria interface que
173: * o legado nao possui, contra o PILAR 1.
174: *
175: * NENHUM metodo vazio foi criado para "cumprir fase": ConfigurarPageFrame()
176: * orquestra apenas o que esta entregue. Vincular BINDEVENT a metodo
177: * inexistente aborta a inicializacao do form, e metodo vazio viola a regra de
178: * completude - por isso os BINDEVENT dos botoes entram junto com os handlers
179: * que eles chamam, na Fase 7. Os botoes JA nascem com geometria, icone e a
180: * regra de permissao do legado: o que falta neles eh so a acao do clique.
181: *
182: * NAO existe barra de seis botoes de cadastro (inclusao/alteracao/consulta/
183: * remocao/busca) nesta tela, e isso foi LIDO no dump, nao presumido: a SECAO 1
184: * lista 25 objetos e os unicos CommandButton sao cmdExcluir, cmdSair e
185: * cmdInserir, todos com "Parent: SIGOPMOP". Nao ha CommandGroup, nao ha
186: * Grupo_Op nem Grupo_Saida, e o SCX nao declara a variavel de modo do

*-- Linhas 505 a 559:
505:     *
506:     *   GradeSubN  Top=99 Left=58 Width=483 Height=311  ColumnCount=7
507:     *              FontName="Tahoma" FontSize=8  RowHeight=16  ScrollBars=2
508:     *              DeleteMark=.F.  GridLineColor=238,238,238  TabIndex=1
509:     *
510:     * O que este metodo NAO faz, de proposito: NAO define ColumnCount nem
511:     * toca nas Columns. Medido no VFP9 - Grid cuja RecordSource ainda nao foi
512:     * atribuida se AUTO-LIGA ao alias CORRENTE no instante em que o
513:     * ColumnCount eh definido, e a Column cai na coluna que estiver naquela
514:     * posicao do alias. Se for coluna de TEXTO, o AddObject do CheckBox da
515:     * coluna "Padrao" estoura "Data type mismatch" DENTRO do AddObject (o
516:     * .Value do CheckBox nasce NUMERICO) - e o erro cai no TRY de
517:     * InicializarForm, que devolve .F., o CREATEOBJECT devolve o logico .F. e
518:     * o usuario aciona a opcao e NADA acontece, sem erro na tela e sem log.
519:     *
520:     * Por isso a sequencia INTEIRA (ColumnCount -> RecordSource ->
521:     * ControlSource de TODAS as colunas -> AddObject do CheckBox ->
522:     * CurrentControl -> largura/cabecalho) vive num funil unico, MontaGrade,
523:     * que roda em TODA repintura - nao aqui.
524:     *
525:     * RecordMark/DeleteMark em .F.: o dump declara so DeleteMark = .F. (a
526:     * classe eh "grid" cru, entao RecordMark ficava no default .T.), mas a
527:     * convencao do projeto para grade de form OPERACIONAL criada por
528:     * AddObject eh desligar as DUAS barras de marcacao. Nao ha perda
529:     * funcional - a linha corrente, que eh o que o botao Excluir consome,
530:     * tambem muda ao clicar em qualquer celula.
531:     *--------------------------------------------------------------------------
532:     PROTECTED PROCEDURE ConfigurarGrade()
533:         THIS.AddObject("grd_4c_Dados", "Grid")
534: 
535:         WITH THIS.grd_4c_Dados
536:             .Top           = 99
537:             .Left          = 58
538:             .Width         = 483
539:             .Height        = 311
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .RowHeight     = 16
543:             .ScrollBars    = 2
544:             .DeleteMark    = .F.
545:             .RecordMark    = .F.
546:             .GridLineColor = RGB(238, 238, 238)
547:             .ReadOnly      = .F.
548:             .Visible       = .T.
549:         ENDWITH
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * ConfigurarMoldura - Shape que emoldura a barra de botoes
554:     * (SIGOPMOP.Shape1), geometria TRANSCRITA do dump:
555:     *
556:     *   Shape1  Top=7 Left=229 Height=41 Width=59
557:     *           BackStyle=0  BorderStyle=0  BorderColor=136,189,188
558:     *
559:     * BackStyle = 0 (transparente) com BorderStyle = 0 (sem borda) significa

*-- Linhas 819 a 843:
819:     *
820:     * TRANSCRITO do legado (SIGOPMOP.cmdInserir.Click):
821:     *   Thisform.lHouveIns = .T.
822:     *   Select crSigCdMop
823:     *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
824:     *   If Eof()
825:     *       Insert Into crSigCdMop (cDopes, CidChaves) ;
826:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
827:     *   EndIf
828:     *   Select crSigCdMop
829:     *   Thisform.GradeSubN.Column1.SetFocus
830:     *
831:     * O LOCATE usa ALLTRIM + == (nao o "=" cru do legado) pela MESMA razao
832:     * do resto deste arquivo: o projeto roda com SET EXACT ON, e comparar
833:     * char(20) sem ALLTRIM exigiria o padding exato. cnivels = Space(20) do
834:     * legado equivale a EMPTY(ALLTRIM(cnivels)) - a linha NOVA, ainda sem
835:     * operacao filha escolhida.
836:     *
837:     * fUniqueIds() gera a PK (cidchaves) - mesma funcao que
838:     * InicializarValoresPadrao do BO usa, chamada aqui porque esta tela
839:     * insere a linha DIRETO no cursor da grade, igual ao legado, e nao via
840:     * NovoRegistro()/BO (regra #51 - BO nao eh chamado para isto).
841:     *
842:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
843:     *--------------------------------------------------------------------------

*-- Linhas 853 a 946:
853:             ELSE
854:                 THIS.this_lHouveInsercao = .T.
855: 
856:                 SELECT (loc_cCursor)
857:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) AND ;
858:                            EMPTY(ALLTRIM(cnivels))
859: 
860:                 IF EOF()
861:                     INSERT INTO (loc_cCursor) (cdopes, cidchaves) ;
862:                         VALUES (ALLTRIM(THIS.this_cOperacaoPai), fUniqueIds())
863:                 ENDIF
864: 
865:                 SELECT (loc_cCursor)
866:                 THIS.grd_4c_Dados.Refresh()
867:                 THIS.grd_4c_Dados.Column1.SetFocus()
868:             ENDIF
869:         CATCH TO loc_oErro
870:             MsgErro(loc_oErro.Message + CHR(13) + ;
871:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
872:                     "Procedure: " + loc_oErro.Procedure, ;
873:                     "Erro em BtnInserirClick")
874:         ENDTRY
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * BtnExcluirClick - Click de cmd_4c_CmdExcluir ("Excluir").
879:     *
880:     * TRANSCRITO do legado (SIGOPMOP.cmdExcluir.Click):
881:     *   Select crSigCdMop
882:     *   If Not Eof() And ( crSigCdMop.cDopes = crSigCdOpe.Dopes )
883:     *       Thisform.lHouveExcl = .T.
884:     *       Delete
885:     *       Skip
886:     *       Skip - 1
887:     *   Endif
888:     *   Thisform.GradeSubN.Refresh
889:     *
890:     * SET DELETED ON eh global (start\config.prg) - o DELETE some da grade
891:     * e do LOCATE/SCAN imediatamente, igual ao legado. A linha apagada pode
892:     * ja existir no SQL Server (cidchaves gravado numa sessao anterior) -
893:     * quem resolve isso no commit eh a Fase 8, que ainda nao existe aqui.
894:     *
895:     * PUBLIC (nao PROTECTED): alvo de BINDEVENT - regra CLAUDE.md #3.
896:     *--------------------------------------------------------------------------
897:     PROCEDURE BtnExcluirClick()
898:         LOCAL loc_cCursor, loc_oErro
899: 
900:         TRY
901:             loc_cCursor = THIS.this_cCursorDados
902: 
903:             IF USED(loc_cCursor)
904:                 SELECT (loc_cCursor)
905: 
906:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
907:                     THIS.this_lHouveExclusao = .T.
908:                     DELETE
909:                     SKIP
910:                     SKIP -1
911:                 ENDIF
912:             ENDIF
913: 
914:             THIS.grd_4c_Dados.Refresh()
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                     "Procedure: " + loc_oErro.Procedure, ;
919:                     "Erro em BtnExcluirClick")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * BtnEncerrarClick - Click de cmd_4c_CmdSair ("Encerrar"), ligado tambem
925:     * ao ESC (.Cancel = .T. em ConfigurarBotoes) - a UNICA saida desta tela,
926:     * que nao tem ControlBox nem TitleBar.
927:     *
928:     * TRANSCRITO do legado (SIGOPMOP.cmdSair.Click):
929:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
930:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
931:     *           <checagem de duplicidade + UpDate/Commit/RollBack do cursor>
932:     *       EndIf
933:     *   EndIf
934:     *   Thisform.ParentForm.Enabled = .T.
935:     *   Thisform.mCtrlBotoes(.T.)
936:     *   ThisForm.Release
937:     *
938:     * Os DOIS guards do legado sao regra, nao detalhe (regra #21b - "a condicao
939:     * que CERCA a validacao faz parte dela"):
940:     *
941:     *   1) "If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible"
942:     *      So grava quando a tela esta em modo de EDICAO. Em PROCURAR os dois
943:     *      botoes ficam invisiveis (AplicarPermissoesBotoes, transcrito do Init
944:     *      legado) e NADA eh persistido - mesmo que o usuario tenha digitado nas
945:     *      celulas, porque o legado nao trava a grade em consulta: quem impede a
946:     *      gravacao eh exatamente este teste. Trocar por um teste de modo

*-- Linhas 1001 a 1090:
1001:     * ValidarDuplicidadeGrade - checagem de duplicidade do cmdSair.Click.
1002:     *
1003:     * TRANSCRITA do legado:
1004:     *   Select CrSigCdMop
1005:     *   Go Bott
1006:     *   Go Top
1007:     *   Select cNivels as Dopes, Mercs, EmpDs, sum(1) as TT ;
1008:     *       From CrSigCdMop GROUP by 1,2,3 Into cursor Totais
1009:     *   Select Totais
1010:     *   Scan
1011:     *       If TT > 1
1012:     *           MessageBox('Operacao '+Alltrim(Totais.Dopes)+
1013:     *                      ' Digitada em Duplicidade!!!!',0+16,'Atencao')
1014:     *           Return .f.
1015:     *       EndIf
1016:     *   EndScan
1017:     *
1018:     * O trio de agrupamento eh cNivels + Mercs + EmpDs, NAO cNivels sozinho: a
1019:     * MESMA operacao filha pode repetir desde que o grande grupo ou a empresa de
1020:     * destino sejam diferentes. Reduzir a chave recusaria gravacao legitima.
1021:     *
1022:     * "Go Bott / Go Top" eh o idioma do legado para forcar a view remota a
1023:     * buscar TODAS as linhas antes de agrupar - num cursor LOCAL nao ha busca
1024:     * preguicosa e as duas linhas nao tem efeito, por isso nao foram
1025:     * transcritas. O que foi transcrito eh o que elas protegiam: o SELECT ve o
1026:     * cursor inteiro.
1027:     *
1028:     * MsgAviso, e nao MsgErro, apesar do icone 16 (Critical) do legado:
1029:     * duplicidade digitada eh validacao de ENTRADA do usuario, e a convencao do
1030:     * projeto reserva o dialogo vermelho (com "Fechar Aplicacao") para falha
1031:     * tecnica. A mensagem e o momento sao os mesmos.
1032:     *
1033:     * O RECNO corrente eh salvo e devolvido: o SELECT ... GROUP BY troca a area
1034:     * de trabalho e o usuario tem de voltar a encontrar a grade na linha em que
1035:     * estava para corrigir a duplicidade.
1036:     *
1037:     * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT, e util
1038:     * como ponto de verificacao de fora em teste.
1039:     *--------------------------------------------------------------------------
1040:     PROCEDURE ValidarDuplicidadeGrade()
1041:         LOCAL loc_lValido, loc_cCursor, loc_cTotais, loc_nRecno, loc_oErro
1042:         loc_lValido = .T.
1043:         loc_cCursor = THIS.this_cCursorDados
1044:         loc_cTotais = "cursor_4c_TotaisMop"
1045: 
1046:         TRY
1047:             IF USED(loc_cCursor)
1048:                 SELECT (loc_cCursor)
1049:                 loc_nRecno = RECNO()
1050: 
1051:                 IF USED(loc_cTotais)
1052:                     USE IN (loc_cTotais)
1053:                 ENDIF
1054: 
1055:                 SELECT cnivels AS dopes, mercs, empds, COUNT(*) AS tt ;
1056:                     FROM (loc_cCursor) ;
1057:                     GROUP BY 1, 2, 3 ;
1058:                     INTO CURSOR (loc_cTotais) READWRITE
1059: 
1060:                 SELECT (loc_cTotais)
1061:                 SCAN FOR tt > 1
1062:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o " + ;
1063:                              ALLTRIM(NVL(dopes, "")) + ;
1064:                              " Digitada em Duplicidade!!!!", ;
1065:                              "Aten" + CHR(231) + CHR(227) + "o")
1066:                     loc_lValido = .F.
1067:                     EXIT
1068:                 ENDSCAN
1069: 
1070:                 IF USED(loc_cTotais)
1071:                     USE IN (loc_cTotais)
1072:                 ENDIF
1073: 
1074:                 *-- Devolve o ponteiro da grade a linha em que o usuario estava.
1075:                 SELECT (loc_cCursor)
1076:                 IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1077:                     GO (loc_nRecno)
1078:                 ENDIF
1079:                 THIS.grd_4c_Dados.Refresh()
1080:             ENDIF
1081:         CATCH TO loc_oErro
1082:             loc_lValido = .F.
1083:             MsgErro(loc_oErro.Message + CHR(13) + ;
1084:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1085:                     "Procedure: " + loc_oErro.Procedure, ;
1086:                     "Erro em ValidarDuplicidadeGrade")
1087:         ENDTRY
1088: 
1089:         RETURN loc_lValido
1090:     ENDPROC

*-- Linhas 1096 a 1155:
1096:     *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
1097:     *   With SigCdOpe
1098:     *       If m.lnErro1>0
1099:     *           m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
1100:     *       EndIf
1101:     *       If m.lnErro1>0
1102:     *           m.lnErro1 = .poDataMgr.Commit()
1103:     *       EndIf
1104:     *       If Not m.lnErro1>0
1105:     *           .poDataMgr.RollBack()
1106:     *       EndIf
1107:     *   EndWith
1108:     *   If Not m.lnErro1>0
1109:     *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1110:     *   EndIf
1111:     *
1112:     * O "UpDate('crSigCdMop')" do legado eh um TABLEUPDATE de VIEW REMOTA: o
1113:     * buffer sabia, registro por registro, quem era novo, alterado ou apagado.
1114:     * O cursor desta arquitetura NAO guarda esse estado - ele nasce de um
1115:     * "SELECT ... INTO CURSOR ... READWRITE", cujo Buffering eh 1 (regra #52),
1116:     * entao INSERT/DELETE no cursor nao esperam em buffer nenhum.
1117:     *
1118:     * O estado eh portanto RECONSTRUIDO por RECONCILIACAO contra o banco, numa
1119:     * unica consulta (BO.CarregarChavesGravadas):
1120:     *
1121:     *   chave na grade   E   no banco -> UPDATE  (BO.Salvar com registro existente)
1122:     *   chave na grade e NAO no banco -> INSERT  (BO.Salvar com registro novo)
1123:     *   chave no banco e NAO na grade -> DELETE  (BO.Excluir)
1124:     *
1125:     * A terceira linha eh o que substitui o DELETE do TABLEUPDATE: linha que o
1126:     * usuario apagou com o botao Excluir saiu da grade (DELETE + SET DELETED ON
1127:     * global), logo nao tem chave na grade e eh apagada no banco. Isto EXIGE que
1128:     * o cursor seja a imagem FIEL de "SigCdMop WHERE cdopes = <operacao pai>" -
1129:     * por isso a Fase 8 trocou o INNER JOIN de BO.CarregarGrade por LEFT JOIN
1130:     * (com INNER, a linha de cnivels em branco nao voltava do banco e esta
1131:     * reconciliacao a APAGARIA; ver o comentario do metodo no BO).
1132:     *
1133:     * Atomicidade: todos os statements vao na MESMA conexao, que neste ambiente
1134:     * nasce com Transactions = 2 (manual), entao o par ConfirmarGravacao/
1135:     * DesfazerGravacao do BO (SQLCOMMIT/SQLROLLBACK) tem o mesmo efeito do
1136:     * Commit/RollBack do legado. NAO se usa "BEGIN/COMMIT TRANSACTION" por
1137:     * SQLEXEC: com @@TRANCOUNT ja em 1 esse par so aninha e nao efetiva nada.
1138:     *
1139:     * A primeira falha ABORTA o laco (EXIT) e desfaz tudo - igual ao legado, que
1140:     * nao continua depois de um UpDate recusado.
1141:     *
1142:     * Nao se repete a mensagem quando o BO ja a exibiu (regra #20): Salvar/
1143:     * Excluir de BusinessBase mostram o erro do SQL Server e marcam
1144:     * this_lErroExibido.
1145:     *
1146:     * As DUAS chamadas que de fato PERSISTEM (Salvar e Excluir) sao escritas por
1147:     * THIS.this_oBusinessObject, e nao pelo apelido local loc_oBO usado no
1148:     * resto do metodo: eh o idioma do projeto para gravacao e deixa as duas
1149:     * unicas linhas que escrevem no banco visiveis numa busca pelo nome do BO.
1150:     *
1151:     * PUBLIC: chamado por BtnEncerrarClick, que eh alvo de BINDEVENT.
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE GravarGrade()
1154:         LOCAL loc_lSucesso, loc_lFalhou, loc_oBO, loc_cCursor, loc_cChaves
1155:         LOCAL loc_nRecno, loc_nLinha, loc_cChave, loc_lNovo, loc_cMensagem

*-- Linhas 1175 a 1225:
1175: 
1176:                 CASE !loc_oBO.ConexaoAtiva()
1177:                     *-- Equivale ao "If m.lnErro1>0" do legado, que testa
1178:                     *-- poDataMgr.pnIdConn antes de tentar o UpDate.
1179:                     MsgErro("Sem conex" + CHR(227) + "o com o banco: as altera" + ;
1180:                             CHR(231) + CHR(245) + "es da grade N" + CHR(195) + "O foram " + ;
1181:                             "gravadas.", "Erro em GravarGrade")
1182: 
1183:                 CASE !loc_oBO.CarregarChavesGravadas()
1184:                     loc_cMensagem = ALLTRIM(NVL(loc_oBO.this_cMensagemErro, ""))
1185:                     IF EMPTY(loc_cMensagem)
1186:                         loc_cMensagem = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
1187:                             "vel ler as opera" + CHR(231) + CHR(245) + "es j" + CHR(225) + ;
1188:                             " gravadas."
1189:                     ENDIF
1190:                     MsgErro(loc_cMensagem, "Erro em GravarGrade")
1191: 
1192:                 OTHERWISE
1193:                     loc_cChaves = loc_oBO.this_cCursorChaves
1194: 
1195:                     SELECT (loc_cCursor)
1196:                     loc_nRecno = RECNO()
1197: 
1198:                     *----------------------------------------------------------
1199:                     * 1) INSERT/UPDATE de cada linha VIVA da grade.
1200:                     *
1201:                     * Laco com RECNO explicito (e nao SCAN): o corpo chama o BO,
1202:                     * que troca a area de trabalho corrente, e SCAN nao sobrevive
1203:                     * a isso. A linha apagada pelo botao Excluir nao aparece aqui
1204:                     * (SET DELETED ON global) - ela eh tratada no passo 2.
1205:                     *----------------------------------------------------------
1206:                     SELECT (loc_cCursor)
1207:                     GO TOP
1208: 
1209:                     DO WHILE .T.
1210:                         SELECT (loc_cCursor)
1211:                         IF EOF()
1212:                             EXIT
1213:                         ENDIF
1214: 
1215:                         loc_nLinha = RECNO()
1216:                         loc_cChave = ALLTRIM(NVL(cidchaves, ""))
1217:                         loc_lNovo  = EMPTY(loc_cChave) OR ;
1218:                                      !THIS.LocalizarChave(loc_cChaves, loc_cChave)
1219: 
1220:                         *-- Estado do BO: CancelarEdicao zera o que sobrou da
1221:                         *-- linha anterior (sem isso, EditarRegistro recusaria o
1222:                         *-- registro com "Nao ha registro para editar" quando a
1223:                         *-- linha anterior era nova).
1224:                         loc_oBO.CancelarEdicao()
1225: 

*-- Linhas 1233 a 1322:
1233:                             loc_oBO.EditarRegistro()
1234:                         ENDIF
1235: 
1236:                         SELECT (loc_cCursor)
1237:                         GO (loc_nLinha)
1238: 
1239:                         IF THIS.FormParaBO()
1240:                             *-- Linha sem PK (dado legado com cidchaves em
1241:                             *-- branco): gera a chave e DEVOLVE ao cursor, senao
1242:                             *-- a reconciliacao da proxima gravacao nao
1243:                             *-- encontraria a linha e inseriria de novo.
1244:                             IF EMPTY(ALLTRIM(loc_oBO.this_cCidChaves))
1245:                                 loc_oBO.this_cCidChaves = fUniqueIds()
1246: 
1247:                                 SELECT (loc_cCursor)
1248:                                 GO (loc_nLinha)
1249:                                 THIS.BOParaForm()
1250:                             ENDIF
1251: 
1252:                             IF !THIS.this_oBusinessObject.Salvar()
1253:                                 loc_lFalhou = .T.
1254:                             ENDIF
1255:                         ELSE
1256:                             loc_lFalhou = .T.
1257:                             loc_oBO.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
1258:                                 CHR(237) + "vel ler a linha " + TRANSFORM(loc_nLinha) + ;
1259:                                 " da grade."
1260:                         ENDIF
1261: 
1262:                         IF loc_lFalhou
1263:                             EXIT
1264:                         ENDIF
1265: 
1266:                         SELECT (loc_cCursor)
1267:                         GO (loc_nLinha)
1268:                         SKIP
1269:                     ENDDO
1270: 
1271:                     *----------------------------------------------------------
1272:                     * 2) DELETE das chaves que estao no banco e nao na grade.
1273:                     *----------------------------------------------------------
1274:                     IF !loc_lFalhou AND USED(loc_cChaves)
1275:                         SELECT (loc_cChaves)
1276:                         GO TOP
1277: 
1278:                         DO WHILE .T.
1279:                             SELECT (loc_cChaves)
1280:                             IF EOF()
1281:                                 EXIT
1282:                             ENDIF
1283: 
1284:                             loc_nLinha = RECNO()
1285:                             loc_cChave = ALLTRIM(NVL(cidchaves, ""))
1286: 
1287:                             *-- Chave VAZIA nunca gera DELETE: "WHERE cidchaves
1288:                             *-- = ''" casaria com toda linha de chave em branco
1289:                             *-- da tabela. O BO tambem recusa (ExecutarExclusao),
1290:                             *-- e aqui nem se tenta.
1291:                             IF !EMPTY(loc_cChave)
1292:                                 IF !THIS.LocalizarChave(loc_cCursor, loc_cChave)
1293:                                     loc_oBO.CancelarEdicao()
1294:                                     loc_oBO.this_cCidChaves = loc_cChave
1295:                                     loc_oBO.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)
1296: 
1297:                                     IF !THIS.this_oBusinessObject.Excluir()
1298:                                         loc_lFalhou = .T.
1299:                                     ENDIF
1300:                                 ENDIF
1301:                             ENDIF
1302: 
1303:                             IF loc_lFalhou
1304:                                 EXIT
1305:                             ENDIF
1306: 
1307:                             SELECT (loc_cChaves)
1308:                             GO (loc_nLinha)
1309:                             SKIP
1310:                         ENDDO
1311:                     ENDIF
1312: 
1313:                     *----------------------------------------------------------
1314:                     * 3) Commit / RollBack - o passo PROPRIO do legado.
1315:                     *----------------------------------------------------------
1316:                     IF loc_lFalhou
1317:                         loc_oBO.DesfazerGravacao()
1318:                     ELSE
1319:                         IF loc_oBO.ConfirmarGravacao()
1320:                             loc_lSucesso = .T.
1321: 
1322:                             *-- Nada mais a gravar: zerar as flags evita que uma

*-- Linhas 1357 a 1375:
1357: 
1358:         *-- Devolve o ponteiro da grade a linha em que o usuario estava.
1359:         IF USED(THIS.this_cCursorDados) AND loc_nRecno > 0
1360:             SELECT (THIS.this_cCursorDados)
1361:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorDados))
1362:                 GO (loc_nRecno)
1363:             ENDIF
1364:         ENDIF
1365: 
1366:         RETURN loc_lSucesso
1367:     ENDPROC
1368: 
1369:     *--------------------------------------------------------------------------
1370:     * LocalizarChave - devolve .T. quando par_cChave existe em par_cAlias.
1371:     *
1372:     * LOCATE com ALLTRIM e "==", e nao SEEK sobre indice, de proposito: o
1373:     * projeto roda com SET EXACT ON (start\config.prg), e sob EXACT ON o SEEK
1374:     * exige a chave COMPLETA do indice - comparar char(20) exigiria reproduzir o
1375:     * padding exato dos dois lados, que eh justamente a armadilha da regra #42.

*-- Linhas 1403 a 1465:
1403: 
1404:         loc_cAliasAnterior = ALIAS()
1405: 
1406:         SELECT (par_cAlias)
1407:         loc_nRecno = RECNO()
1408: 
1409:         LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChave
1410:         loc_lAchou = FOUND()
1411: 
1412:         *-- RECNO() em EOF devolve RECCOUNT()+1, e "GO <esse numero>" estoura
1413:         *-- "Record is out of range" - por isso o BETWEEN.
1414:         IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
1415:             GO (loc_nRecno)
1416:         ELSE
1417:             GO BOTTOM
1418:             IF !EOF()
1419:                 SKIP
1420:             ENDIF
1421:         ENDIF
1422: 
1423:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1424:             SELECT (loc_cAliasAnterior)
1425:         ENDIF
1426: 
1427:         RETURN loc_lAchou
1428:     ENDPROC
1429: 
1430:     *--------------------------------------------------------------------------
1431:     * FormParaBO - transfere a LINHA CORRENTE da grade para o objeto de negocio.
1432:     *
1433:     * Nesta tela a "ficha" nao eh uma pagina de Dados com TextBox: eh a LINHA da
1434:     * grade. Cada uma delas eh um registro de SigCdMop, e as nove colunas do
1435:     * cursor sao exatamente as nove colunas da tabela (mais ndopes, que eh de
1436:     * exibicao). Por isso os dois hooks de transferencia leem e escrevem o
1437:     * CURSOR, e nao controles.
1438:     *
1439:     * NAO se usa o CarregarDoCursor do BO para isto, e nao eh escolha de estilo:
1440:     * ele esta PROTECTED no BO, e metodo protegido chamado de fora compila limpo
1441:     * e estoura em runtime com "Property CARREGARDOCURSOR is not found"
1442:     * (regra #51).
1443:     *
1444:     * cdopes cai na operacao PAI quando a coluna vem vazia: no legado toda linha
1445:     * nasce amarrada a ela ("Insert Into crSigCdMop (cDopes, CidChaves) Values
1446:     * (crSigCdOpe.Dopes, fUniqueIds())"), e cdopes eh NOT NULL e entra no WHERE
1447:     * do DELETE.
1448:     *
1449:     * ALLTRIM nos campos char: as colunas do cursor vem com padding de char(N) e
1450:     * EscaparSQL/LEFT do BO trabalham sobre o valor util. Isto NAO eh a
1451:     * armadilha da regra #42 (ALLTRIM em PARTE de chave posicional concatenada):
1452:     * aqui cada valor eh um campo independente, e a comparacao de char no SQL
1453:     * Server eh blank-padded ANSI.
1454:     *
1455:     * PROTECTED **EXPLICITO**, e nao por estilo: FormBase.prg declara
1456:     * "PROTECTED PROCEDURE FormParaBO" (eh um hook que FormBase.Salvar chama por
1457:     * THIS.), e em VFP9 a subclasse NAO ALARGA escopo herdado - escrever
1458:     * "PROCEDURE FormParaBO" aqui deixaria o metodo protegido do mesmo jeito e
1459:     * MENTIRIA para quem le. Medido nesta tela em 2026-11-09: com a declaracao
1460:     * sem modificador, "loForm.FormParaBO()" de fora da classe estourou
1461:     * "Property FORMPARABO is not found." (erro 1734) - e num vfp9.exe -T esse
1462:     * Program Error eh um dialogo que ninguem fecha, ou seja o processo PENDURA
1463:     * sem log nenhum. Chamar sempre por THIS., de dentro da classe (GravarGrade).
1464:     * O mesmo vale para BOParaForm. CarregarLista NAO existe em FormBase, logo
1465:     * aquele sim eh publico de verdade.

*-- Linhas 1473 a 1511:
1473:             loc_oBO     = THIS.this_oBusinessObject
1474: 
1475:             IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
1476:                 SELECT (loc_cCursor)
1477: 
1478:                 IF !EOF()
1479:                     loc_cCdopes = ALLTRIM(TratarNulo(cdopes, ""))
1480: 
1481:                     IF EMPTY(loc_cCdopes)
1482:                         loc_cCdopes = ALLTRIM(THIS.this_cOperacaoPai)
1483:                     ENDIF
1484: 
1485:                     loc_oBO.this_cCdopes    = loc_cCdopes
1486:                     loc_oBO.this_cCidChaves = ALLTRIM(TratarNulo(cidchaves, ""))
1487:                     loc_oBO.this_cCnivels   = ALLTRIM(TratarNulo(cnivels, ""))
1488:                     loc_oBO.this_nNcors     = TratarNulo(ncors,   0)
1489:                     loc_oBO.this_nPadraos   = TratarNulo(padraos, 0)
1490:                     loc_oBO.this_nOrdems    = TratarNulo(ordems,  0)
1491:                     loc_oBO.this_cMercs     = ALLTRIM(TratarNulo(mercs, ""))
1492:                     loc_oBO.this_cEmpds     = ALLTRIM(TratarNulo(empds, ""))
1493:                     loc_oBO.this_cOpers     = ALLTRIM(TratarNulo(opers, ""))
1494: 
1495:                     *-- Coluna de EXIBICAO (vem do LEFT JOIN com SigCdOpe) - nao
1496:                     *-- existe em SigCdMop e nunca entra no INSERT/UPDATE.
1497:                     IF TYPE(loc_cCursor + ".ndopes") != "U"
1498:                         loc_oBO.this_nNdopes = TratarNulo(ndopes, 0)
1499:                     ENDIF
1500: 
1501:                     loc_lSucesso = .T.
1502:                 ENDIF
1503:             ENDIF
1504: 
1505:         CATCH TO loc_oErro
1506:             MsgErro(loc_oErro.Message + CHR(13) + ;
1507:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1508:                     "Procedure: " + loc_oErro.Procedure, ;
1509:                     "Erro em FormParaBO")
1510:         ENDTRY
1511: 

*-- Linhas 1522 a 1560:
1522:     * inseriria o MESMO registro outra vez.
1523:     *
1524:     * REPLACE num cursor exige que ele seja READWRITE - e eh
1525:     * (BO.CarregarGrade usa "SELECT ... INTO CURSOR ... READWRITE", e o
1526:     * cursor vazio inicial vem de CREATE CURSOR).
1527:     *
1528:     * Os char vao com ALLTRIM e o proprio VFP completa com espacos ate a largura
1529:     * da coluna; valor mais longo que a coluna eh truncado pelo VFP, igual ao
1530:     * LEFT() que o BO aplica no SQL.
1531:     *
1532:     * PROTECTED EXPLICITO pela MESMA razao de FormParaBO (ver o comentario
1533:     * dele): FormBase declara os dois como PROTECTED e VFP9 nao deixa a
1534:     * subclasse alargar o escopo.
1535:     *--------------------------------------------------------------------------
1536:     PROTECTED PROCEDURE BOParaForm()
1537:         LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_oErro
1538:         loc_lSucesso = .F.
1539: 
1540:         TRY
1541:             loc_cCursor = THIS.this_cCursorDados
1542:             loc_oBO     = THIS.this_oBusinessObject
1543: 
1544:             IF VARTYPE(loc_oBO) = "O" AND USED(loc_cCursor)
1545:                 SELECT (loc_cCursor)
1546: 
1547:                 IF !EOF()
1548:                     REPLACE cdopes    WITH ALLTRIM(loc_oBO.this_cCdopes),    ;
1549:                             cidchaves WITH ALLTRIM(loc_oBO.this_cCidChaves), ;
1550:                             cnivels   WITH ALLTRIM(loc_oBO.this_cCnivels),   ;
1551:                             ncors     WITH loc_oBO.this_nNcors,              ;
1552:                             padraos   WITH loc_oBO.this_nPadraos,            ;
1553:                             ordems    WITH loc_oBO.this_nOrdems,             ;
1554:                             mercs     WITH ALLTRIM(loc_oBO.this_cMercs),     ;
1555:                             empds     WITH ALLTRIM(loc_oBO.this_cEmpds),     ;
1556:                             opers     WITH ALLTRIM(loc_oBO.this_cOpers)
1557: 
1558:                     IF TYPE(loc_cCursor + ".ndopes") != "U"
1559:                         REPLACE ndopes WITH loc_oBO.this_nNdopes
1560:                     ENDIF

*-- Linhas 1599 a 1630:
1599:             loc_cCursor = THIS.this_cCursorDados
1600: 
1601:             IF USED(loc_cCursor)
1602:                 SELECT (loc_cCursor)
1603:                 IF !EOF()
1604:                     loc_cChaveAtual = ALLTRIM(NVL(cidchaves, ""))
1605:                 ENDIF
1606:             ENDIF
1607: 
1608:             loc_lSucesso = THIS.CarregarDados()
1609: 
1610:             *-- Reler a property: CarregarDados a sincroniza com o BO.
1611:             loc_cCursor = THIS.this_cCursorDados
1612: 
1613:             IF loc_lSucesso AND !EMPTY(loc_cChaveAtual) AND USED(loc_cCursor)
1614:                 IF THIS.LocalizarChave(loc_cCursor, loc_cChaveAtual)
1615:                     SELECT (loc_cCursor)
1616:                     LOCATE FOR ALLTRIM(NVL(cidchaves, "")) == m.loc_cChaveAtual
1617:                     THIS.grd_4c_Dados.Refresh()
1618:                 ENDIF
1619:             ENDIF
1620: 
1621:         CATCH TO loc_oErro
1622:             MsgErro(loc_oErro.Message + CHR(13) + ;
1623:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1624:                     "Procedure: " + loc_oErro.Procedure, ;
1625:                     "Erro em CarregarLista")
1626:         ENDTRY
1627: 
1628:         RETURN loc_lSucesso
1629:     ENDPROC
1630: 

*-- Linhas 1786 a 1875:
1786:     *
1787:     * Mapa de colunas TRANSCRITO do Init legado:
1788:     *   .RecordSource          = 'crSigCdMop'
1789:     *   .Column1.ControlSource = 'crSigCdMop.cNivels'   "Movimentacao"  150
1790:     *   .Column2.ControlSource = 'crSigCdMop.nDopes'    "  #  "          38  ReadOnly
1791:     *   .Column3.ControlSource = 'crSigCdMop.nCors'     "Cores"          80
1792:     *   .Column4.ControlSource = 'crSigCdMop.Padraos'   "Padrao"         50  CheckBox
1793:     *   .Column5.ControlSource = 'crSigCdMop.Ordems'    "Ordem"          45
1794:     *   .Column6.ControlSource = 'crSigCdMop.Mercs'     "G.Grp"          42
1795:     *   .Column7.ControlSource = 'crSigCdMop.EmpDs'     "Emp."           40
1796:     *
1797:     * A SEQUENCIA abaixo eh medida, nao estilistica:
1798:     *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
1799:     *   Column4.AddObject(CheckBox) -> CurrentControl/Sparse -> larguras e
1800:     *   cabecalhos -> ReadOnly das colunas.
1801:     * Inverter os dois primeiros blocos faz o Grid se auto-ligar ao alias
1802:     * CORRENTE no instante do ColumnCount e o AddObject do CheckBox estourar
1803:     * "Data type mismatch" se a coluna 4 daquele alias for texto.
1804:     * Largura e cabecalho vem POR ULTIMO porque atribuir RecordSource/
1805:     * ControlSource os reseta (a largura volta ao default 90 e o Caption volta
1806:     * a "Header1").
1807:     *
1808:     * Este metodo eh IDEMPOTENTE e eh o funil de TODA repintura - nao da
1809:     * inicializacao apenas.
1810:     *--------------------------------------------------------------------------
1811:     PROCEDURE MontaGrade()
1812:         LOCAL loc_lSucesso, loc_oErro, loc_oGrade, loc_cCursor
1813:         loc_lSucesso = .F.
1814: 
1815:         TRY
1816:             loc_cCursor = THIS.this_cCursorDados
1817: 
1818:             IF !USED(loc_cCursor)
1819:                 *-- Sem cursor nao ha o que ligar; sair sem mexer na grade eh
1820:                 *-- melhor que ligar em alias inexistente, que derruba o Init.
1821:                 MsgAviso("Cursor da grade n" + CHR(227) + "o dispon" + CHR(237) + ;
1822:                          "vel: " + loc_cCursor, "Aten" + CHR(231) + CHR(227) + "o")
1823:             ELSE
1824:                 loc_oGrade = THIS.grd_4c_Dados
1825: 
1826:                 SELECT (loc_cCursor)
1827: 
1828:                 WITH loc_oGrade
1829:                     .ColumnCount      = 7
1830:                     .RecordSourceType = 1
1831:                     .RecordSource     = loc_cCursor
1832: 
1833:                     .Column1.ControlSource = loc_cCursor + ".cnivels"
1834:                     .Column2.ControlSource = loc_cCursor + ".ndopes"
1835:                     .Column3.ControlSource = loc_cCursor + ".ncors"
1836:                     .Column4.ControlSource = loc_cCursor + ".padraos"
1837:                     .Column5.ControlSource = loc_cCursor + ".ordems"
1838:                     .Column6.ControlSource = loc_cCursor + ".mercs"
1839:                     .Column7.ControlSource = loc_cCursor + ".empds"
1840:                 ENDWITH
1841: 
1842:                 *-- CheckBox da coluna "Padrao" so DEPOIS do bind, e de forma
1843:                 *-- idempotente (AddObject repetido num objeto vivo estoura).
1844:                 THIS.GarantirCheckBoxPadrao()
1845: 
1846:                 *-- Celulas customizadas de Movimentacao/Cores (Fase 5) -
1847:                 *-- mesma idempotencia: o bind acima recria as Columns.
1848:                 THIS.GarantirCelulasEditaveisGrade()
1849: 
1850:                 *-- Fonte das Columns e dos controles internos (dump: Tahoma 8
1851:                 *-- em todas as 7 colunas e em todos os Text1)
1852:                 loc_oGrade.FontName = "Tahoma"
1853:                 loc_oGrade.FontSize = 8
1854: 
1855:                 *-- Larguras, cabecalhos e travas, coluna a coluna
1856:                 THIS.ConfigurarColunasGrade()
1857: 
1858:                 *-- "Go Top In <cursor>" + Refresh do legado: popular o cursor
1859:                 *-- NAO repinta a grade sozinho.
1860:                 SELECT (loc_cCursor)
1861:                 GO TOP
1862:                 loc_oGrade.Refresh()
1863: 
1864:                 loc_lSucesso = .T.
1865:             ENDIF
1866:         CATCH TO loc_oErro
1867:             MsgErro(loc_oErro.Message + CHR(13) + ;
1868:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1869:                     "Procedure: " + loc_oErro.Procedure, ;
1870:                     "Erro em MontaGrade")
1871:         ENDTRY
1872: 
1873:         RETURN loc_lSucesso
1874:     ENDPROC
1875: 

*-- Linhas 1972 a 2014:
1972:     * legado le "This.Value"/"crSigCdMop.padraos" JA TROCADO pelo toggle
1973:     * nativo do CheckBox; aqui o toggle eh calculado a mao, porque os
1974:     * handlers acima suprimem o nativo):
1975:     *   Select crSigCdMop
1976:     *   lnRecno = Recno('crSigCdMop')
1977:     *   If crSigCdMop.padraos = 0
1978:     *       Update crSigCdMop Set padraos = 0
1979:     *       Go lnRecno
1980:     *   Else
1981:     *       Update crSigCdMop Set padraos = 0 Where Recno() # lnRecno
1982:     *       Update crSigCdMop Set padraos = 1 Where Recno() = lnRecno
1983:     *       Select crSigCdMop
1984:     *       Go lnRecno
1985:     *   EndIf
1986:     *   Select crSigCdMop
1987:     *   ThisForm.GradeSubN.Refresh
1988:     *
1989:     * Disparado so em Enter(13) ou Espaco(32), igual ao padrao do projeto
1990:     * para CheckBox de Grid (BINDEVENT KeyPress nao distingue tecla sozinho
1991:     * - o filtro fica dentro do handler).
1992:     *--------------------------------------------------------------------------
1993:     PROCEDURE PadraoMopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1994:         LOCAL loc_cCursor, loc_nRecno, loc_nNovoValor
1995: 
1996:         loc_cCursor = THIS.this_cCursorDados
1997: 
1998:         IF INLIST(NVL(par_nKeyCode, 0), 13, 32) AND USED(loc_cCursor) AND !EOF(loc_cCursor)
1999:             SELECT (loc_cCursor)
2000: 
2001:             loc_nRecno     = RECNO()
2002:             loc_nNovoValor = IIF(padraos = 0, 1, 0)
2003: 
2004:             REPLACE padraos WITH 0 ALL
2005: 
2006:             IF loc_nNovoValor = 1
2007:                 GOTO loc_nRecno
2008:                 REPLACE padraos WITH 1
2009:             ENDIF
2010: 
2011:             GOTO loc_nRecno
2012:             THIS.this_lHouveInsercao = .T.
2013:             THIS.grd_4c_Dados.Refresh()
2014:             NODEFAULT

*-- Linhas 2068 a 2086:
2068:     * ConfigurarColunasGrade - largura, cabecalho, mascara e travas das 7
2069:     * colunas, TRANSCRITAS do dump (SECAO 2).
2070:     *
2071:     * Roda sempre DEPOIS do bind: atribuir RecordSource/ControlSource reseta
2072:     * Column.Width para o default 90 e Header1.Caption para "Header1".
2073:     *
2074:     * Column.ReadOnly vem DEPOIS de Grid.ReadOnly (definido em ConfigurarGrade):
2075:     * o do grid propaga para as colunas e sobrescreveria estas travas.
2076:     *
2077:     * A coluna "Cores" segue a configuracao da operacao, igual ao legado:
2078:     *   If LocalDcOpe.GerOpes <> 2
2079:     *       .Column3.ReadOnly = .t.
2080:     *   Else
2081:     *       .SetAll('DynamicForeColor','iif(CrSigCdMop.ncors>0,nCors,0)','Column')
2082:     *   Endif
2083:     * Isto eh, so quando geropes = 2 a cor eh digitavel - e nesse caso o texto de
2084:     * TODAS as colunas passa a ser pintado com a cor gravada na linha.
2085:     *--------------------------------------------------------------------------
2086:     PROTECTED PROCEDURE ConfigurarColunasGrade()

*-- Linhas 2102 a 2120:
2102:             .Header1.FontSize  = 8
2103:         ENDWITH
2104: 
2105:         *-- Column2 "  #  " - numero da operacao, vem do JOIN e NAO eh editavel
2106:         WITH loc_oGrade.Column2
2107:             .Width     = 38
2108:             .Movable   = .F.
2109:             .InputMask = "9999"
2110:             .Header1.Caption   = "  #  "
2111:             .Header1.Alignment = 2
2112:             .Header1.FontName  = "Tahoma"
2113:             .Header1.FontSize  = 8
2114:             .Text1.BorderStyle = 0
2115:             .Text1.Margin      = 0
2116:             .Text1.ForeColor   = RGB(0, 0, 0)
2117:             .Text1.BackColor   = RGB(255, 255, 255)
2118:             .Text1.ReadOnly    = .T.
2119:             .ReadOnly          = .T.
2120:         ENDWITH

*-- Linhas 2290 a 2362:
2290:     *       Replace nDopes With CpSigCdOpe.nDopes in CrSigCdMop
2291:     *       This.Refresh
2292:     *   EndIf
2293:     *   Select CrSigCdMop
2294:     *   Return .t.
2295:     *
2296:     * O "LocalDcOpe" do legado eh o cursor de SigOpCdc que o Init carrega
2297:     * (Select Dopes, GerOpes, OpeInatvs From SigOpCdc + Index On Dopes) - aqui
2298:     * ele eh this_oBusinessObject.this_cCursorConfig, populado por
2299:     * CarregarConfiguracaoOperacao. A consulta de inatividade esta em
2300:     * ObterOperacaoInativa, que usa LOCATE e nao SEEK: o projeto roda com
2301:     * SET EXACT ON e, nesse modo, o SEEK exigiria a chave com o padding exato
2302:     * de char(20) (mesma razao ja documentada no BO).
2303:     *
2304:     * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
2305:     * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
2306:     * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
2307:     *
2308:     * DUAS divergencias deliberadas em relacao ao legado, as duas pelo mesmo
2309:     * motivo (regras #37 e #50):
2310:     *
2311:     *   1. O legado le cpSigCdOpe.Dopes mesmo quando o usuario ABANDONA o
2312:     *      picker (ESC) - e nesse caso o cursor esta posicionado na primeira
2313:     *      linha da busca parcial, de modo que a celula recebe um valor que
2314:     *      ninguem escolheu. Aqui a atribuicao fica DENTRO da guarda
2315:     *      this_lSelecionou e o valor DIGITADO eh preservado.
2316:     *   2. Universo vazio NAO gera aviso nem apaga o que foi digitado: o
2317:     *      proprio picker eh o feedback, e limpar o campo impediria o usuario
2318:     *      de terminar de preencher o codigo.
2319:     *
2320:     * O "This.Value = ' '" da operacao INATIVA, por outro lado, eh TRANSCRITO:
2321:     * ali o registro EXISTE e foi escolhido, e eh o legado que o recusa
2322:     * explicitamente, com mensagem e com Return .f. para o foco nao sair da
2323:     * celula.
2324:     *
2325:     * Sem conexao (harness/validacao de UI) o lookup nao roda e o valor
2326:     * digitado eh aceito como esta: SQLEXEC com handle invalido dispara
2327:     * excecao, e abrir picker MODAL em teste headless travaria o processo.
2328:     *--------------------------------------------------------------------------
2329:     PROCEDURE ValidarMovimentacaoMopCorpo(par_oTxt)
2330:         LOCAL loc_lAceita, loc_cCursor, loc_cDigitado
2331: 
2332:         loc_lAceita   = .T.
2333:         loc_cCursor   = THIS.this_cCursorDados
2334:         loc_cDigitado = ALLTRIM(NVL(par_oTxt.Value, ""))
2335: 
2336:         *-- Sem conexao (harness/validacao de UI) o picker nao roda e o valor
2337:         *-- digitado eh aceito como esta: SQLEXEC com handle invalido dispara
2338:         *-- excecao, e abrir picker MODAL em teste headless travaria o processo.
2339:         IF !EMPTY(loc_cDigitado) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2340:             loc_lAceita = THIS.AbrirBuscaMovimentacaoMop(par_oTxt)
2341:         ENDIF
2342: 
2343:         *-- "Select CrSigCdMop" do fim do Valid legado: o picker e o cursor de
2344:         *-- configuracao mexem na area de trabalho corrente, e a grade continua
2345:         *-- operando sobre o cursor dela.
2346:         IF USED(loc_cCursor)
2347:             SELECT (loc_cCursor)
2348:         ENDIF
2349: 
2350:         RETURN loc_lAceita
2351:     ENDPROC
2352: 
2353:     *--------------------------------------------------------------------------
2354:     * AbrirBuscaMovimentacaoMop - picker de SigCdOpe da celula "Movimentacao".
2355:     *
2356:     * Equivale ao bloco fwBuscaExt do Valid legado:
2357:     *   xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'cpSigCdOpe',
2358:     *             'Dopes', This.Value, 'Cadastro de Operacoes', .t., 'Dopes')
2359:     *   If Not xBrox.plAchouRegistro
2360:     *       xBrox.mAddColuna('Dopes',  '',     'Operacao', .t.)
2361:     *       xBrox.mAddColuna('nDopes', '9999', ' # ',      .f.)
2362:     *       xBrox.Show()

*-- Linhas 2368 a 2386:
2368:     * .T.: nao achar nada NAO eh erro (regra #50).
2369:     *
2370:     * O REPLACE de ndopes eh o que preenche a coluna "  #  " da grade: ela NAO
2371:     * existe em SigCdMop, vem do JOIN com SigCdOpe, e por isso tem de ser
2372:     * gravada no cursor a mao quando o usuario escolhe a operacao FILHA.
2373:     *--------------------------------------------------------------------------
2374:     PROCEDURE AbrirBuscaMovimentacaoMop(par_oTxt)
2375:         LOCAL loc_lAceita, loc_cCursor, loc_cCursorBusca, loc_cDigitado
2376:         LOCAL loc_oBusca, loc_oErro, loc_cEscolhida, loc_nNdopes, loc_nInativa
2377: 
2378:         loc_lAceita      = .T.
2379:         loc_cCursor      = THIS.this_cCursorDados
2380:         loc_cCursorBusca = "cursor_4c_BuscaOpe"
2381:         loc_cDigitado    = ALLTRIM(NVL(par_oTxt.Value, ""))
2382: 
2383:         TRY
2384:             IF USED(loc_cCursorBusca)
2385:                 USE IN (loc_cCursorBusca)
2386:             ENDIF

*-- Linhas 2474 a 2509:
2474: 
2475:         loc_cAreaAnterior = ALIAS()
2476: 
2477:         SELECT (loc_cCursorConfig)
2478:         LOCATE FOR ALLTRIM(dopes) == ALLTRIM(par_cOperacao)
2479: 
2480:         IF FOUND()
2481:             loc_uValor = TratarNulo(opeinatvs, 0)
2482: 
2483:             DO CASE
2484:                 CASE VARTYPE(loc_uValor) = "N"
2485:                     loc_nInativa = loc_uValor
2486:                 CASE VARTYPE(loc_uValor) = "L"
2487:                     loc_nInativa = IIF(loc_uValor, 1, 0)
2488:                 OTHERWISE
2489:                     loc_nInativa = 0
2490:             ENDCASE
2491:         ENDIF
2492: 
2493:         IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
2494:             SELECT (loc_cAreaAnterior)
2495:         ENDIF
2496: 
2497:         RETURN loc_nInativa
2498:     ENDPROC
2499: 
2500:     *--------------------------------------------------------------------------
2501:     * CelulaCoresMopEditavel - When da celula "Cores"
2502:     * (grd_4c_Dados.Column3.txt_4c_Cores).
2503:     *
2504:     * TRANSCRITO do legado (Column3.Text1.When):
2505:     *   ThisForm.Antvalue = This.Value
2506:     *   Return( ( crSigCdMop.cDopes = crSigCdOpe.Dopes ) And
2507:     *            Not IsEmpty( crSigCdMop.cNivels ) )
2508:     * O snapshot do valor anterior (this_nValorAnterior) vai ANTES do teste
2509:     * de editabilidade, na MESMA ordem do legado - eh dele que o Valid

*-- Linhas 2658 a 2676:
2658:         ENDIF
2659: 
2660:         IF USED(loc_cCursor)
2661:             SELECT (loc_cCursor)
2662:         ENDIF
2663: 
2664:         *-- O Refresh final fica FORA do IF, igual ao legado.
2665:         par_oTxt.Refresh()
2666: 
2667:         RETURN .T.
2668:     ENDPROC
2669: 
2670:     *--------------------------------------------------------------------------
2671:     * AbrirBuscaGrandeGrupoMop - picker de SigCdGpr da celula "G.Grp".
2672:     *
2673:     * Equivale ao bloco fwBuscaExt do Valid legado (Column6.Text1.Valid):
2674:     *   loLista = CreateObject([fwBuscaExt], <conn>, [SigCdGpr],
2675:     *               [crListaRemota], [Codigos], This.Value, [Selecao], .t.)
2676:     *   If Not loLista.plAchouRegistro

*-- Linhas 2805 a 2823:
2805:         ENDIF
2806: 
2807:         IF USED(loc_cCursor)
2808:             SELECT (loc_cCursor)
2809:         ENDIF
2810: 
2811:         RETURN .T.
2812:     ENDPROC
2813: 
2814:     *--------------------------------------------------------------------------
2815:     * AbrirBuscaEmpresaMop - picker de SigCdEmp da celula "Emp.".
2816:     *
2817:     * Equivale ao bloco fwBuscaExt do Valid legado (Column7.Text1.Valid):
2818:     *   xBrox = CreateObject('fwbuscaext', <conn>, 'SigCdEmp', 'crSigCdEmp',
2819:     *             'cEmps', This.Value, 'Empresas', .t., 'cEmps')
2820:     *   If Not xBrox.plAchouRegistro
2821:     *       xBrox.mAddColuna('CEmps', 'XXXXXX', 'Codigo',    .t.)
2822:     *       xBrox.mAddColuna('Razas', '',       'Descricao', .t.)
2823:     *       xBrox.Show()


### BO (C:\4c\projeto\app\classes\SigOpMopBO.prg):
*====================================================================
* SigOpMopBO.prg
*
* Business Object para Geracao de Multiplas Operacoes
* Origem legado: SIGOPMOP.SCX (form OPERACIONAL - dialogo filho de SIGCDOPE)
* Tabela: SigCdMop
* Herda de: BusinessBase
*
* A tela eh um dialogo filho aberto pelo Cadastro de Operacoes (SigCdOpe).
* Cada linha da grade eh um registro de SigCdMop que amarra a operacao PAI
* (cdopes) a uma operacao FILHA (cnivels), com cor, ordem, grande grupo e
* empresa de destino.
*
* Colunas de SigCdMop (TODAS NOT NULL - ver docs\schema.sql):
*   cdopes    char(20)        - operacao PAI  (crSigCdOpe.Dopes no legado)
*   cidchaves char(20)        - PK, gerada por fUniqueIds()
*   cnivels   char(20)        - operacao FILHA ("Movimentacao" na grade)
*   ncors     numeric(10,0)   - cor RGB ("Cores")
*   padraos   numeric(1,0)    - marca de linha padrao ("Padrao")
*   ordems    numeric(3,0)    - ordem de execucao ("Ordem")
*   mercs     char(3)         - grande grupo ("G.Grp")
*   empds     char(3)         - empresa de destino ("Emp.") - DEFAULT ('')
*   opers     char(1)         - sem controle na tela      - DEFAULT ('')
*
* ATENCAO: ndopes NAO existe em SigCdMop. Eh coluna de EXIBICAO da grade,
* lida de SigCdOpe.ndopes pelo legado ("Replace nDopes With CpSigCdOpe.nDopes
* in CrSigCdMop") e por isso NUNCA entra no INSERT/UPDATE desta tabela.
*====================================================================

DEFINE CLASS SigOpMopBO AS BusinessBase

    *----------------------------------------------------------------
    * Propriedades da entidade (mapeamento 1-para-1 com SigCdMop)
    *----------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves char(20)      - PK (fUniqueIds)
    this_cCdopes      = ""    && cdopes    char(20)      - operacao PAI
    this_cCnivels     = ""    && cnivels   char(20)      - operacao FILHA
    this_nNcors       = 0     && ncors     numeric(10,0) - cor RGB
    this_nPadraos     = 0     && padraos   numeric(1,0)  - linha padrao
    this_nOrdems      = 0     && ordems    numeric(3,0)  - ordem
    this_cMercs       = ""    && mercs     char(3)       - grande grupo
    this_cEmpds       = ""    && empds     char(3)       - empresa destino
    this_cOpers       = ""    && opers     char(1)       - sem UI (NOT NULL)

    *----------------------------------------------------------------
    * Propriedade de EXIBICAO - vem de SigCdOpe.ndopes, NAO de SigCdMop.
    * Fica no cursor da grade (coluna " # ") e nao eh persistida aqui.
    *----------------------------------------------------------------
    this_nNdopes      = 0     && ndopes    numeric(4,0)  - numero da operacao

    *----------------------------------------------------------------
    * Contexto recebido do form PAI (SigCdOpe) ao abrir o dialogo
    *----------------------------------------------------------------
    this_cOperacaoPai = ""    && Dopes da operacao corrente no form pai
    this_cEscolha     = ""    && Modo do pai: INSERIR / ALTERAR / PROCURAR

    *----------------------------------------------------------------
    * Configuracao da operacao (SigOpCdc) - decide o comportamento da grade
    *   geropes   <> 2 trava a coluna "Cores" (legado: Column3.ReadOnly = .T.)
    *   opeinatvs  = 1 recusa a operacao digitada em "Movimentacao"
    *----------------------------------------------------------------
    this_nGerOpes     = 0     && SigOpCdc.geropes   numeric(1,0)
    this_nOpeInatvs   = 0     && SigOpCdc.opeinatvs numeric(1,0)

    *----------------------------------------------------------------
    * Nomes de cursores (centralizados para a grade nao perder o bind)
    *----------------------------------------------------------------
    this_cCursorDados  = "cursor_4c_Dados"       && cursor da grade (crSigCdMop)
    this_cCursorTemp   = "cursor_4c_DadosTmp"    && destino dos SQLEXEC
    this_cCursorConfig = "cursor_4c_ConfigOpe"   && LocalDcOpe do legado
    this_cCursorBusca  = "cursor_4c_Busca"       && reserva (os lookups da grade usam um cursor por tabela)
    this_cCursorChaves = "cursor_4c_ChavesMop"   && cidchaves JA gravadas (reconciliacao da gravacao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdMop"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cCursorDados  = "cursor_4c_Dados"
            THIS.this_cCursorTemp   = "cursor_4c_DadosTmp"
            THIS.this_cCursorConfig = "cursor_4c_ConfigOpe"
            THIS.this_cCursorBusca  = "cursor_4c_Busca"
            THIS.this_cCursorChaves = "cursor_4c_ChavesMop"

            THIS.this_lEmEdicao     = .F.
            THIS.this_lNovoRegistro = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpMopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria para a auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha
    * do cursor da grade (cursor_4c_Dados / crSigCdMop no legado).
    *
    * this_nNdopes NAO vem de SigCdMop - eh lido do mesmo cursor porque a
    * grade de SigOpMopBO.Buscar() ja traz essa coluna de exibicao vinda
    * do JOIN com SigCdOpe (ver comentario no cabecalho do arquivo).
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCdopes    = TratarNulo(cdopes,    "")
                THIS.this_cCnivels   = TratarNulo(cnivels,   "")
                THIS.this_nNcors     = TratarNulo(ncors,      0)
                THIS.this_nPadraos   = TratarNulo(padraos,    0)
                THIS.this_nOrdems    = TratarNulo(ordems,     0)
                THIS.this_cMercs     = TratarNulo(mercs,     "")
                THIS.this_cEmpds     = TratarNulo(empds,     "")
                THIS.this_cOpers     = TratarNulo(opers,     "")

                IF TYPE(par_cAliasCursor + ".ndopes") != "U"
                    THIS.this_nNdopes = TratarNulo(ndopes,  0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova linha na tabela SigCdMop
    *
    * Transcreve o cmdInserir.Click do legado (ver InicializarValoresPadrao):
    * todas as colunas sao NOT NULL, entao TODAS entram no INSERT - inclusive
    * empds/opers, que nao tem controle visivel na grade (regra #22).
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdMop (cidchaves, cdopes, cnivels, ncors, padraos, ordems, mercs, empds, opers)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCdopes)>>,
                    <<EscaparSQL(THIS.this_cCnivels)>>,
                    <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cMercs)>>,
                    <<EscaparSQL(THIS.this_cEmpds)>>,
                    <<EscaparSQL(THIS.this_cOpers)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza linha existente na tabela SigCdMop
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdMop
                SET cdopes  = <<EscaparSQL(THIS.this_cCdopes)>>,
                    cnivels = <<EscaparSQL(THIS.this_cCnivels)>>,
                    ncors   = <<FormatarNumeroSQL(THIS.this_nNcors, 0)>>,
                    padraos = <<FormatarNumeroSQL(THIS.this_nPadraos, 0)>>,
                    ordems  = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    mercs   = <<EscaparSQL(THIS.this_cMercs)>>,
                    empds   = <<EscaparSQL(THIS.this_cEmpds)>>,
                    opers   = <<EscaparSQL(THIS.this_cOpers)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Zera as propriedades da entidade
    *
    * Mantem o CONTEXTO (operacao pai, modo e configuracao da operacao):
    * ele vem do form pai na abertura do dialogo e vale para todas as
    * linhas, nao para uma linha so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCdopes    = ""
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults da linha NOVA
    *
    * Transcreve o cmdInserir.Click do legado:
    *   Insert Into crSigCdMop (cDopes, CidChaves) ;
    *       Values (crSigCdOpe.Dopes, fUniqueIds())
    * Ou seja: a linha nova nasce amarrada a operacao PAI, com PK propria,
    * e o restante em branco/zero (as colunas sao NOT NULL, por isso
    * precisam de valor explicito - nunca NULL).
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
        THIS.this_cCdopes    = ALLTRIM(THIS.this_cOperacaoPai)
        THIS.this_cCnivels   = ""
        THIS.this_nNcors     = 0
        THIS.this_nPadraos   = 0
        THIS.this_nOrdems    = 0
        THIS.this_cMercs     = ""
        THIS.this_cEmpds     = ""
        THIS.this_cOpers     = ""
        THIS.this_nNdopes    = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - popula o cursor de configuracao das
    * operacoes (SigOpCdc) e resolve geropes/opeinatvs da operacao PAI.
    *
    * TRANSCRITO do Init legado:
    *   lcSql = [Select Dopes, GerOpes, OpeInatvs From SigOpCdc ]
    *   SigCdOpe.Podatamgr.Sqlexecute(lcSql,'LocalDcOpe')
    *   Select LocalDcOpe
    *   Index On Dopes Tag dopes
    *   =Seek(CrSigCdOpe.Dopes)
    *
    * O cursor carrega TODAS as operacoes de proposito, e NAO so a corrente:
    * o Valid da coluna "Movimentacao" reconsulta este mesmo cursor para
    * recusar a operacao digitada quando ela esta inativa ("=Seek(
    * cpSigCdOpe.Dopes,'LocalDcOpe','Dopes') / If LocalDcOpe.OpeInatvs = 1").
    * Filtrar aqui pela operacao PAI deixaria aquela checagem sem base.
    *
    * geropes decide se a coluna "Cores" aceita digitacao (<> 2 trava), e eh
    * por isso que esta carga roda ANTES da montagem da grade.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        THIS.this_nGerOpes   = 0
        THIS.this_nOpeInatvs = 0

        TRY
            IF USED(THIS.this_cCursorConfig)
                USE IN (THIS.this_cCursorConfig)
            ENDIF

            loc_cSQL = "SELECT dopes, geropes, opeinatvs FROM SigOpCdc"

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorConfig) READWRITE
                USE IN (THIS.this_cCursorTemp)
            ELSE
                *-- Sem conexao (harness/validacao de UI) ou consulta recusada:
                *-- cursor VAZIO com a MESMA estrutura, para a grade continuar
                *-- montavel e a checagem de operacao inativa nao estourar.
                CREATE CURSOR (THIS.this_cCursorConfig) ( ;
                    dopes     C(20), ;
                    geropes   N(1, 0), ;
                    opeinatvs N(1, 0) )
            ENDIF

            *-- "Index On Dopes Tag dopes" do legado
            SELECT (THIS.this_cCursorConfig)
            INDEX ON dopes TAG dopes

            *-- Equivalente ao "=Seek(CrSigCdOpe.Dopes)". LOCATE em vez de SEEK
            *-- porque o projeto roda com SET EXACT ON, e nesse modo o SEEK
            *-- exigiria a chave com o padding exato de char(20) - ver a regra
            *-- do indice composto/SEEK parcial no CLAUDE.md.
            IF !EMPTY(ALLTRIM(THIS.this_cOperacaoPai))
                LOCATE FOR ALLTRIM(dopes) == ALLTRIM(THIS.this_cOperacaoPai)
                IF FOUND()
                    THIS.this_nGerOpes   = TratarNulo(geropes,    0)
                    THIS.this_nOpeInatvs = TratarNulo(opeinatvs,  0)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarConfiguracaoOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrade - popula o cursor da grade com as linhas de SigCdMop
    * da operacao PAI.
    *
    * A consulta eh a MESMA que o form chamador (SIGCDOPE) registra no
    * AddCursor de 'crSigCdMop' - transcrita de
    * tasks\task483\SIGCDOPE_form_codigo_fonte.txt:54214:
    *
    *   Select a.*, b.nDopes
    *     From SigCdMop a
    *     inner join SigCdOpe b on a.cnivels = b.Dopes
    *    Where a.cDopes = ?crSigCdOpe.Dopes
    *    Order by a.cDopes, a.cNivels
    *
    * O JOIN eh quem traz "ndopes" (o numero da operacao FILHA, coluna " # "
    * da grade), que NAO existe em SigCdMop.
    *
    * O JOIN eh LEFT, e NAO inner (corrigido na Fase 8). No legado o cursor da
    * grade nao eh um JOIN: eh o "crSigCdMop" do form PAI (SigCdOpe.poDataMgr),
    * que eh "SigCdMop" inteiro MAIS uma coluna LOCAL nDopes, preenchida a mao
    * pelo Valid da celula Movimentacao ("Replace nDopes With CpSigCdOpe.nDopes
    * in CrSigCdMop"). Ou seja: no legado a linha com cnivels em BRANCO - a que
    * o botao Inserir cria e o usuario pode deixar sem preencher - esta no
    * cursor e eh gravada pelo UpDate/Commit do cmdSair.
    *
    * Com INNER essa linha, uma vez gravada, NAO voltava do banco (nao ha
    * SigCdOpe com Dopes em branco): ela desaparecia da tela sem erro nenhum e,
    * pior, a reconciliacao da Fase 8 (GravarGrade) a leria como "existe no
    * banco e nao esta mais na grade" e a EXCLUIRIA - perda silenciosa de dado.
    * LEFT + ISNULL(b.ndopes, 0) deixa o cursor ser a imagem FIEL de
    * "SigCdMop WHERE cdopes = <operacao pai>", que eh o que a reconciliacao
    * pressupoe, e ISNULL mantem a coluna numeric(4,0) SEM nulo (CheckBox e
    * REPLACE sobre coluna anulavel estouram em runtime).
    *
    * O cursor tem de ser READWRITE: as colunas Movimentacao/Cores/Padrao/
    * Ordem/G.Grp/Emp. sao editaveis na grade, e cursor de SQLEXEC nasce
    * SOMENTE-LEITURA (a celula renderiza e nunca entra em edicao). Por isso
    * o SQLEXEC vai para um cursor TEMPORARIO e o cursor da grade sai de um
    * "SELECT * ... INTO CURSOR ... READWRITE".
    *
    * ATENCAO: este metodo DERRUBA o alias da grade, e fechar o alias de um
    * Grid destroi o controle posto por Column.AddObject (o CheckBox da
    * coluna Padrao) - perda PARCIAL e silenciosa, porque Width/Header
    * sobrevivem e so o CheckBox volta a desenhar o Text1. Quem chama este
    * metodo TEM de remontar a grade pelo funil (FormSigOpMop.MontaGrade).
    *====================================================================
    PROCEDURE CarregarGrade()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            TEXT TO loc_cSQL NOSHOW TEXTMERGE
                SELECT a.cdopes, a.cidchaves, a.cnivels, a.ncors,
                       a.padraos, a.ordems, a.mercs, a.empds, a.opers,
                       ISNULL(b.ndopes, 0) AS ndopes
                  FROM SigCdMop a
                  LEFT JOIN SigCdOpe b ON a.cnivels = b.dopes
                 WHERE a.cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
                 ORDER BY a.cdopes, a.cnivels
            ENDTEXT

            loc_nResultado = -1
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)
            ENDIF

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorTemp)
                SELECT * FROM (THIS.this_cCursorTemp) ;
                    INTO CURSOR (THIS.this_cCursorDados) READWRITE
                USE IN (THIS.this_cCursorTemp)
                loc_lSucesso = .T.
            ELSE
                *-- Sem conexao ou consulta recusada: cursor vazio com a MESMA
                *-- estrutura da consulta, na MESMA ordem de colunas (o APPEND
                *-- de uma recarga futura casa por NOME, e a grade liga por
                *-- ControlSource - estrutura divergente quebraria os dois).
                THIS.CriarCursorGradeVazio()

                IF loc_nResultado <= 0 AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    MsgErro("Erro ao carregar as opera" + CHR(231) + CHR(245) + "es m" + ;
                            CHR(250) + "ltiplas." + CHR(13) + CapturarErroSQL(), ;
                            "Erro SQL")
                ELSE
                    *-- Ausencia de conexao nao eh falha de carga: eh o cenario
                    *-- do harness, e a grade abre vazia e montavel.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorGradeVazio - estrutura do cursor da grade.
    *
    * Os tipos vem de docs\schema.sql (SigCdMop, todas NOT NULL) mais a
    * coluna de exibicao ndopes, que eh SigCdOpe.ndopes numeric(4,0).
    * A ordem eh a MESMA do SELECT de CarregarGrade - placeholder com
    * estrutura divergente do cursor real quebra o bind da grade.
    *
    * SEM "SET NULL ON" de proposito: a grade EDITA estas colunas, e NULL em
    * coluna numerica ligada a CheckBox/REPLACE estoura em runtime. Todas as
    * colunas de origem sao NOT NULL e o JOIN eh INNER, logo o resultado real
    * tambem nunca traz nulo.
    *====================================================================
    PROTECTED PROCEDURE CriarCursorGradeVazio()
        CREATE CURSOR (THIS.this_cCursorDados) ( ;
            cdopes    C(20), ;
            cidchaves C(20), ;
            cnivels   C(20), ;
            ncors     N(10, 0), ;
            padraos   N(1, 0), ;
            ordems    N(3, 0), ;
            mercs     C(3), ;
            empds     C(3), ;
            opers     C(1), ;
            ndopes    N(4, 0) )

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConexaoAtiva - .T. quando gnConnHandle existe E eh um handle valido.
    *
    * Existe para que o teste nao seja escrito como
    *   IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
    * que eh o padrao dominante no projeto e tem um defeito latente: VFP9 NAO
    * faz curto-circuito em OR (nem em AND), entao "gnConnHandle <= 0" eh
    * avaliado AINDA QUE o TYPE tenha dado "U" - e comparar variavel
    * inexistente com 0 estoura "Variable GNCONNHANDLE is not found". Com IF
    * ANINHADO o segundo teste so acontece quando o primeiro garantiu o tipo.
    *
    * PUBLIC (sem PROTECTED) porque o FORM tambem pergunta, antes de comecar a
    * gravar a grade: metodo do BO chamado de fora nao pode ser PROTECTED em
    * nenhum nivel da heranca (regra #51), e BusinessBase nao declara este nome.
    *====================================================================
    FUNCTION ConexaoAtiva()
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        RETURN (gnConnHandle > 0)
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - DELETE de UMA linha de SigCdMop.
    *
    * Chamado SO por BusinessBase.Excluir() (PROTECTED - de fora, sempre
    * Excluir(); regra #51). Sem este override a base devolveria .F. com
    * "Metodo ExecutarExclusao() sem override na subclasse" e a linha que o
    * usuario apagou na grade continuaria no banco.
    *
    * Equivale a parte de DELETE do "poDataMgr.UpDate('crSigCdMop')" do legado:
    * la o TABLEUPDATE da view enviava um DELETE por registro marcado; aqui
    * quem decide QUAIS linhas sumiram eh a reconciliacao do form
    * (FormSigOpMop.GravarGrade), e este metodo executa UMA delas.
    *
    * DUAS guardas, as duas deliberadas:
    *   1) chave VAZIA recusa a exclusao. "DELETE ... WHERE cidchaves = ''"
    *      casaria com TODA linha de chave em branco da tabela (comparacao de
    *      char no SQL Server eh blank-padded ANSI) - apagaria registro de
    *      outra operacao. Recusar deixa a linha no banco, que eh a falha
    *      SEGURA: ela reaparece na proxima abertura.
    *   2) "AND cdopes" junto da PK. cidchaves JA eh a primary key
    *      (sigcdmop_cidchaves), entao o filtro eh redundante no caminho
    *      normal - ele existe para que um defeito futuro na reconciliacao nao
    *      consiga apagar linha de OUTRA operacao pai. Se divergir, o DELETE
    *      nao afeta nenhuma linha e o registro sobrevive (falha segura).
    *
    * RegistrarAuditoria roda ANTES de a base chamar LimparDados(), porque
    * ObterChavePrimaria() le this_cCidChaves - zerada, a auditoria sairia sem
    * chave e BusinessBase.RegistrarAuditoria descartaria o log.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_oErro

        loc_lSucesso = .F.
        loc_cChave   = ALLTRIM(THIS.this_cCidChaves)

        TRY
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Linha sem chave prim" + CHR(225) + ;
                    "ria (cidchaves): exclus" + CHR(227) + "o recusada."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdMop
                     WHERE cidchaves = <<EscaparSQL(loc_cChave)>>
                       AND cdopes    = <<EscaparSQL(ALLTRIM(THIS.this_cCdopes))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir a opera" + CHR(231) + CHR(227) + ;
                        "o m" + CHR(250) + "ltipla:" + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpMopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarChavesGravadas - popula this_cCursorChaves com as cidchaves que
    * JA existem em SigCdMop para a operacao PAI.
    *
    * Eh a base da reconciliacao que substitui o "poDataMgr.UpDate(
    * 'crSigCdMop')" do legado. A view remota do legado sabia, pelo proprio
    * buffer, quais registros eram novos, alterados ou apagados; o cursor local
    * desta arquitetura NAO guarda esse estado (CURSORGETPROP("Buffering") = 1
    * num "SELECT ... INTO CURSOR ... READWRITE" - regra #52), entao o estado
    * eh RECONSTRUIDO comparando a grade com a imagem do banco:
    *
    *   chave na grade E no banco   -> UPDATE
    *   chave na grade e NAO no banco -> INSERT
    *   chave no banco e NAO na grade -> DELETE
    *
    * UMA consulta resolve as tres decisoes para todas as linhas. A alternativa
    * (um "SELECT COUNT(*)" por linha) daria N+1 idas ao servidor para o mesmo
    * resultado.
    *
    * O cursor fica SOMENTE-LEITURA de proposito: ele so eh lido por LOCATE.
    *====================================================================
    PROCEDURE CarregarChavesGravadas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorChaves)
                USE IN (THIS.this_cCursorChaves)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves
                  FROM SigCdMop
                 WHERE cdopes = <<EscaparSQL(ALLTRIM(THIS.this_cOperacaoPai))>>
            ENDTEXT

            IF !THIS.ConexaoAtiva()
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco: " + ;
                    "n" + CHR(227) + "o foi poss" + CHR(237) + "vel ler as opera" + ;
                    CHR(231) + CHR(245) + "es j" + CHR(225) + " gravadas."
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorChaves)

                IF loc_nResultado > 0 AND USED(THIS.this_cCursorChaves)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao ler as opera" + CHR(231) + ;
                        CHR(245) + "es j" + CHR(225) + " gravadas:" + CHR(13) + ;
                        CapturarErroSQL()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SigOpMopBO.CarregarChavesGravadas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarGravacao / DesfazerGravacao - o par Commit/RollBack que o
    * cmdSair.Click do legado executa sobre a conexao:
    *
    *   If m.lnErro1>0
    *       m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMop'),1,-1)
    *   EndIf
    *   If m.lnErro1>0
    *       m.lnErro1 = .poDataMgr.Commit()      && <- passo PROPRIO, com
    *   EndIf                                    &&    caminho de falha proprio
    *   If Not m.lnErro1>0
    *       .poDataMgr.RollBack()
    *   EndIf
    *
    * O Commit NAO eh detalhe de infraestrutura: neste ambiente a conexao nasce
    * com SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
    * INSERT/UPDATE/DELETE fica preso na transacao aberta e SOME se o processo
    * morrer - defeito mudo que ja aconteceu no projeto por descartar
    * exatamente este passo do legado.
    *
    * O par eh INERTE quando a conexao esta em auto-commit (Transactions = 1):
    * cada statement ja foi efetivado e nao ha transacao para confirmar ou
    * desfazer. O teste vem num IF ANINHADO, nunca "IF loc_lManual AND
    * SQLCOMMIT(...)": VFP9 nao faz curto-circuito em AND e chamaria o
    * SQLCOMMIT de qualquer jeito.
    *
    * ATENCAO (fiel ao legado, e por isso mantido): SQLROLLBACK desfaz a
    * transacao da CONEXAO, nao apenas o que este dialogo escreveu - igual ao
    * ".poDataMgr.RollBack()" do legado, que atua no mesmo DataMgr do form pai.
    * Como esta tela grava em UM lote e fecha, nao ha outra escrita em aberto.
    *====================================================================
    PROCEDURE ConfirmarGravacao()
        LOCAL loc_lSucesso, loc_lManual, loc_nResultado
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco."
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_nResultado = SQLCOMMIT(gnConnHandle)

            IF loc_nResultado = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao confirmar a transa" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        ELSE
            *-- Auto-commit: cada statement ja esta efetivado, nada a confirmar.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE DesfazerGravacao()
        LOCAL loc_lSucesso, loc_lManual
        loc_lSucesso = .F.

        IF !THIS.ConexaoAtiva()
            RETURN .F.
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF loc_lManual
            loc_lSucesso = (SQLROLLBACK(gnConnHandle) = 1)
        ELSE
            *-- Auto-commit: nao ha transacao aberta para desfazer. Devolve .F.
            *-- porque NADA foi desfeito - o chamador precisa saber que o que
            *-- gravou antes do erro ficou gravado.
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

