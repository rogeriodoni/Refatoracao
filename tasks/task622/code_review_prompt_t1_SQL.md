# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLIN, FPAGS, LNCNT, I, EMPDOPNUMS, CTXTCDS, DOPES, IMPBOLS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUNA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNLIN, FPAGS, LNCNT, I, EMPDOPNUMS, CTXTCDS, DOPES, IMPBOLS

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
  ControlSource = "crGrade.CTxtCds"
  ControlSource = "crGrade.CLocals"
	Insert Into TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
lcQuery = [Update SigCnFBl ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Insert Into crDados (CLocals, Vencs, DatDoc, NumDoc, Valor, Razaos, Cpfs, Texto, ;
		.DeleteMark 	   = .f.
		.Column1.ControlSource  = [crGrade.FPags]
		.Column2.ControlSource  = [crGrade.Parcs]
		.Column3.ControlSource  = [crGrade.Vencs]
		.Column4.ControlSource  = [crGrade.Valos]
lcQuery = [Select b.FPags, b.Parcs, b.Vencs, b.Datas, b.Valos ] + ;
		    [From SigMvCab a, SigMvPar b, SigCdOpe c, SigOpCdc d, SigOpFp e ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSelecao') < 1)
Select crSelecao
		Insert Into crGrade (FPags, Parcs, Vencs, Datas, Valos, CLocals, CTxtCds) ;
Select crGrade

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIbb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1131 linhas total):

*-- Linhas 53 a 90:
53: *                     nenhuma tabela auxiliar a consultar. Inventar um lookup
54: *                     aqui violaria o PILAR 1.
55: *                     Alem disso: GridDadosAfterRowColChange (equivalente ao
56: *                     grdItens.AfterRowColChange do legado: Select crGrade +
57: *                     Refresh em cascata - aqui alimentado por
58: *                     SigPrIbbBO.CarregarDoCursor(), que o legado dispensa
59: *                     porque crGrade/getLocals/getTxtCds sao ligados DIRETO
60: *                     por ControlSource); BtnImprimirClick (equivalente a
61: *                     btnImprimir.Click: confirmacao + ThisForm.Imprimir) e
62: *                     THIS.Imprimir() (encadeia SigPrIbbBO.ImprimirBoleto());
63: *                     BtnEncerrarClick (equivalente a ok.Click: ThisForm.Release).
64: *   Fase 7 (feita)  - eventos principais; ver Fase 8 para o veredito sobre CRUD.
65: *   Fase 8 (esta)   - consolidacao final. DUAS mudancas, nenhuma cosmetica:
66: *                     (a) os dois handlers de botao passaram a se chamar pela
67: *                     ACAO que executam - BtnImprimirClick (era
68: *                     "CmdBtnImprimirClick", que carregava o NOME DO OBJETO
69: *                     legado "btnImprimir" dentro do nome do metodo, com o
70: *                     "Btn" no meio) e BtnEncerrarClick (era "CmdOkClick", do
71: *                     objeto "ok", cujo Caption no SCX eh justamente
72: *                     "Encerrar"). O verbo do handler tem de ser o verbo da
73: *                     acao, nao o nome do objeto do legado;
74: *                     (b) SigPrIbbBO.AtualizarConfiguracaoBoleto() ganhou o
75: *                     Commit que o legado faz logo depois do UPDATE em
76: *                     SigCnFBl - ver o comentario do metodo no BO: sem ele a
77: *                     edicao do local de pagamento / texto do cedente ficava
78: *                     presa numa transacao manual aberta e sumia em silencio.
79: *                     Revisao do escopo: o dump do legado (SigPrIbb_form_codigo_
80: *                     fonte.txt, SECAO 3/4 - "Total de metodos/eventos com
81: *                     codigo: 10") tem SOMENTE: Init/Load/Release/Detalhe/
82: *                     Imprimir/MontaGrades/SelecionaDados (metodos do form),
83: *                     ok.Click e btnImprimir.Click (os DOIS UNICOS botoes -
84: *                     CommandButton standalone, sem CommandGroup) e
85: *                     grdItens.AfterRowColChange. NAO EXISTE Incluir/Alterar/
86: *                     Visualizar/Excluir em lugar nenhum do dump - nem
87: *                     frmcadastro, nem Grupo_Op, nem pcEscolha: eh tela de
88: *                     IMPRESSAO (Encerrar + Imprimir), nao cadastro. Os 10
89: *                     metodos do legado ja tem equivalente 1-para-1 no
90: *                     migrado (BtnEncerrarClick/BtnImprimirClick/

*-- Linhas 270 a 288:
270:     *                    cmd_4c_Ok chama THIS.Release()). CarregarDados()
271:     *                    dispara a primeira sincronizacao (equivalente ao
272:     *                    Column1.Setfocus do Init legado, que no legado ja
273:     *                    bastava por causa do ControlSource direto).
274:     *==========================================================================
275:     PROTECTED PROCEDURE ConfigurarPageFrame()
276:         THIS.ConfigurarCabecalho()
277:         THIS.ConfigurarShape()
278:         THIS.ConfigurarCamposChave()
279:         THIS.ConfigurarGrid()
280:         THIS.ConfigurarCamposParcela()
281:         THIS.ConfigurarBotoes()
282:         THIS.ConfigurarOrdemTabulacao()
283:     ENDPROC
284: 
285:     *--------------------------------------------------------------------------
286:     * ConfigurarCabecalho - Container cinza escuro com titulo do form.
287:     * Original (dump legado): cntSombra Top=0, Left=0, Width=1008, Height=80,
288:     * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do

*-- Linhas 454 a 494:
454: 
455:     *--------------------------------------------------------------------------
456:     * ConfigurarGrid - grd_4c_Dados (grdItens no legado): so a geometria e as
457:     * propriedades que NAO dependem do cursor. RecordSource/ControlSource de
458:     * cada Column ficam em CarregarDados, chamado DEPOIS que
459:     * SigPrIbbBO.CarregarParcelas() cria cursor_4c_Dados (CLAUDE.md regra
460:     * #41 - Column.ControlSource antes do cursor existir derruba o Init).
461:     * ColumnCount=4 e o ReadOnly geral (grdItens.ReadOnly=.T. no dump) sao
462:     * fixados aqui; o ReadOnly de cada Column (regra #18 - tem de vir DEPOIS
463:     * do Grid) e o restante de cada coluna ficam em CarregarDados.
464:     *--------------------------------------------------------------------------
465:     PROTECTED PROCEDURE ConfigurarGrid()
466:         LOCAL loc_oErro
467: 
468:         TRY
469:             THIS.AddObject("grd_4c_Dados", "Grid")
470:             WITH THIS.grd_4c_Dados
471:                 .Top               = 138
472:                 .Left              = 7
473:                 .Width             = 425
474:                 .Height            = 520
475:                 .FontName          = "Tahoma"
476:                 .FontSize          = 8
477:                 .AllowHeaderSizing = .F.
478:                 .AllowRowSizing    = .F.
479:                 .DeleteMark        = .F.
480:                 .RecordMark        = .F.
481:                 .HeaderHeight      = 22
482:                 .RowHeight         = 16
483:                 .ScrollBars        = 2
484:                 .GridLineColor     = RGB(238, 238, 238)
485:                 .ReadOnly          = .T.
486:                 .ColumnCount       = 4
487:                 .Visible           = .T.
488:             ENDWITH
489: 
490:             *-- grdItens.AfterRowColChange do legado (LParameters nColIndex) -
491:             *-- handler PUBLIC (CLAUDE.md regra #3), declarando o parametro
492:             *-- do evento.
493:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
494:         CATCH TO loc_oErro

*-- Linhas 503 a 521:
503:     * de Responsabilidade do Cedente ") e os EditBox obj_4c_GetLocals/
504:     * obj_4c_GetTxtCds (getLocals/getTxtCds no legado - EDITAVEIS, ligados a
505:     * crGrade.CLocals/CTxtCds, a linha corrente da grade) + txt_4c_Total
506:     * (getTotal, Enabled=.F., soma das parcelas). ControlSource dos dois
507:     * EditBox e o .Value de txt_4c_Total ficam em CarregarDados - dependem do
508:     * cursor (mesma regra #41 de ConfigurarGrid).
509:     *
510:     * AutoSize=.T. do dump eh NO-OP em Label criado por AddObject (CLAUDE.md
511:     * regra #23) - .AutoSize=.F. aqui com Width/Height explicitos reproduz
512:     * os numeros que o Form Designer legado ja tinha calculado.
513:     *--------------------------------------------------------------------------
514:     PROTECTED PROCEDURE ConfigurarCamposParcela()
515:         LOCAL loc_oErro
516: 
517:         TRY
518:             THIS.AddObject("lbl_4c_Label3", "Label")
519:             WITH THIS.lbl_4c_Label3
520:                 .AutoSize  = .F.
521:                 .FontBold  = .T.

*-- Linhas 544 a 564:
544:                 *-- MaxLength vem da LARGURA DA COLUNA no schema, nunca do
545:                 *-- Width em pixels (CLAUDE.md regra #19): o valor digitado
546:                 *-- aqui vai para SigCnFBl.clocals CHAR(100) NOT NULL, no
547:                 *-- UPDATE de SigPrIbbBO.AtualizarConfiguracaoBoleto(). Sem o
548:                 *-- limite, o excedente seria cortado EM SILENCIO pelo
549:                 *-- ControlSource (cursor_4c_Dados.CLocals eh C(100)) e o
550:                 *-- usuario nao perceberia a perda.
551:                 .MaxLength     = 100
552:                 .Visible       = .T.
553:             ENDWITH
554: 
555:             THIS.AddObject("lbl_4c_Label31", "Label")
556:             WITH THIS.lbl_4c_Label31
557:                 .AutoSize  = .F.
558:                 .FontBold  = .T.
559:                 .FontName  = "Tahoma"
560:                 .FontSize  = 8
561:                 .BackStyle = 0
562:                 .Alignment = 0
563:                 .Caption   = "Texto de Responsabilidade do Cedente "
564:                 .Left      = 444

*-- Linhas 604 a 622:
604: 
605:             *-- Os DOIS unicos controles digitaveis da tela (todo o resto eh
606:             *-- Enabled=.F. ou ReadOnly=.T. no dump). No legado eles sao
607:             *-- ligados DIRETO por ControlSource a crGrade.CLocals/CTxtCds e
608:             *-- "Procedure imprimir" le crGrade.* na hora de gravar/imprimir -
609:             *-- ou seja, o que esta na tela ja ERA o que ia para o boleto.
610:             *-- Aqui SigPrIbbBO.AtualizarConfiguracaoBoleto()/
611:             *-- CarregarDadosImpressao() leem as propriedades *Atual do BO, e
612:             *-- por isso a edicao precisa de um ponto explicito de
613:             *-- sincronizacao - este handler.
614:             *--
615:             *-- LostFocus (nao "Valid"): BINDEVENT em "Valid" nao dispara de
616:             *-- forma confiavel em controle de entrada (CLAUDE.md regra #3 /
617:             *-- lookups). Eh seguro aqui porque o handler NAO executa SQL,
618:             *-- NAO remonta grade e NAO chama SetFocus - a recursao que o
619:             *-- CLAUDE.md adverte fica coberta pela guarda
620:             *-- this_lSincronizandoParcela.
621:             BINDEVENT(THIS.obj_4c_GetLocals, "LostFocus", THIS, "ValidarLocalPagamento")
622:             BINDEVENT(THIS.obj_4c_GetTxtCds, "LostFocus", THIS, "ValidarTextoCedente")

*-- Linhas 765 a 802:
765:     * legado: chama SigPrIbbBO.CarregarParcelas() (cria/popula
766:     * cursor_4c_Dados a partir de THIS.this_cEmpDopNum) e SO DEPOIS rebinda
767:     * grd_4c_Dados e os dois EditBox editaveis - CLAUDE.md regra #41
768:     * (Column.ControlSource antes do cursor existir derruba o Init).
769:     * Width/Header1.Caption/ReadOnly de cada coluna sao refeitos aqui (nao em
770:     * ConfigurarGrid) porque trocar RecordSource reseta os tres ("Problema 2"
771:     * / regra #43.1 do CLAUDE.md).
772:     *--------------------------------------------------------------------------
773:     PROTECTED PROCEDURE CarregarDados()
774:         LOCAL loc_oGrid, loc_oErro
775: 
776:         TRY
777:             IF THIS.this_oBusinessObject.CarregarParcelas(THIS.this_cEmpDopNum)
778:                 loc_oGrid = THIS.grd_4c_Dados
779: 
780:                 loc_oGrid.RecordSource = ""
781:                 loc_oGrid.ColumnCount  = 4
782:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
783: 
784:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
785:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Parcs"
786:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Vencs"
787:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Valos"
788: 
789:                 WITH loc_oGrid.Column1
790:                     .FontName  = "Courier New"
791:                     .FontSize  = 8
792:                     .Width     = 120
793:                     .Movable   = .F.
794:                     .Resizable = .F.
795:                     .ReadOnly  = .T.
796:                     .BackColor = RGB(245, 251, 136)
797:                     .Header1.FontName  = "Tahoma"
798:                     .Header1.FontSize  = 8
799:                     .Header1.Alignment = 2
800:                     .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto."
801:                     .Header1.ForeColor = RGB(90, 90, 90)
802:                     .Header1.BackColor = RGB(255, 255, 223)

*-- Linhas 879 a 909:
879:                     .Text1.BackColor   = RGB(255, 255, 255)
880:                 ENDWITH
881: 
882:                 THIS.obj_4c_GetLocals.ControlSource = "cursor_4c_Dados.CLocals"
883:                 THIS.obj_4c_GetTxtCds.ControlSource  = "cursor_4c_Dados.CTxtCds"
884:                 THIS.txt_4c_Total.Value = THIS.this_oBusinessObject.this_nTotalParcelas
885: 
886:                 IF USED("cursor_4c_Dados")
887:                     GO TOP IN cursor_4c_Dados
888:                 ENDIF
889:                 loc_oGrid.Refresh()
890:                 THIS.obj_4c_GetLocals.Refresh()
891:                 THIS.obj_4c_GetTxtCds.Refresh()
892: 
893:                 *-- Equivalente ao .grdItens.Column1.Setfocus do Init legado:
894:                 *-- no legado o proprio SetFocus/ControlSource direto ja
895:                 *-- bastava para crGrade.FPags/CLocals/CTxtCds aparecerem
896:                 *-- corretos; aqui THIS.this_oBusinessObject.this_cFPagsAtual
897:                 *-- (e demais *Atual, usados por ImprimirBoleto) so existem
898:                 *-- apos CarregarDoCursor - sincronizar com a 1a linha agora
899:                 *-- evita imprimir com a parcela errada quando o usuario
900:                 *-- nunca navega na grade (ex.: so uma condicao de pagamento).
901:                 IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
902:                     THIS.GridDadosAfterRowColChange(1)
903:                 ENDIF
904:             ELSE
905:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
906:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
907:                 ENDIF
908:             ENDIF
909:         CATCH TO loc_oErro

*-- Linhas 915 a 936:
915: 
916:     *--------------------------------------------------------------------------
917:     * GridDadosAfterRowColChange - equivalente a grdItens.AfterRowColChange
918:     * do legado (LParameters nColIndex / Select crGrade / This.Refresh /
919:     * ThisForm.Refresh / ThisForm.getLocals.Refresh / ThisForm.getTxtCds.
920:     * Refresh). La, crGrade/getLocals/getTxtCds sao ligados DIRETO por
921:     * ControlSource, entao o Select+Refresh ja bastava para a tela refletir
922:     * a linha corrente. Aqui, alem do refresh visual, sincroniza as
923:     * propriedades *Atual do BO (this_cFPagsAtual/this_nParcsAtual/etc, via
924:     * CarregarDoCursor) - sao elas que SigPrIbbBO.ImprimirBoleto() usa, e sem
925:     * esta sincronizacao a impressao sairia sempre com os dados da PRIMEIRA
926:     * linha carregada, mesmo apos o usuario navegar/selecionar outra parcela.
927:     *
928:     * PUBLIC (nao PROTECTED) porque esta ligado via BINDEVENT - CLAUDE.md
929:     * regra #3 - e declara o parametro do evento (par_nColIndex), mesmo sem
930:     * uso direto aqui (o legado tambem recebe e nao usa nColIndex).
931:     *--------------------------------------------------------------------------
932:     PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
933:         LOCAL loc_oErro
934: 
935:         TRY
936:             IF USED("cursor_4c_Dados")

*-- Linhas 981 a 1030:
981: 
982:     *--------------------------------------------------------------------------
983:     * ValidarLocalPagamento - handler de LostFocus de obj_4c_GetLocals
984:     * (getLocals no legado, ControlSource = crGrade.CLocals). O campo alimenta
985:     * SigCnFBl.clocals CHAR(100) NOT NULL (UPDATE em
986:     * SigPrIbbBO.AtualizarConfiguracaoBoleto) e tambem eh impresso como
987:     * "Local de Pagamento" do boleto (crDados.CLocals em Procedure imprimir).
988:     * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
989:     *--------------------------------------------------------------------------
990:     PROCEDURE ValidarLocalPagamento()
991:         THIS.SincronizarCampoParcela(THIS.obj_4c_GetLocals, 100)
992:     ENDPROC
993: 
994:     *--------------------------------------------------------------------------
995:     * ValidarTextoCedente - handler de LostFocus de obj_4c_GetTxtCds
996:     * (getTxtCds no legado, ControlSource = crGrade.CTxtCds). Alimenta
997:     * SigCnFBl.ctxtcds (TEXT, sem limite de largura - por isso largura 0) e eh
998:     * impresso como "Texto de Cobranca" (crDados.Texto).
999:     * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
1000:     *--------------------------------------------------------------------------
1001:     PROCEDURE ValidarTextoCedente()
1002:         THIS.SincronizarCampoParcela(THIS.obj_4c_GetTxtCds, 0)
1003:     ENDPROC
1004: 
1005:     *--------------------------------------------------------------------------
1006:     * SincronizarCampoParcela - corpo comum aos dois handlers acima.
1007:     *
1008:     * par_nLargura = largura da coluna DESTINO no schema (0 = sem limite).
1009:     * O corte eh defensivo: .MaxLength ja impede a digitacao alem do limite,
1010:     * mas valor colado/atribuido por programa passaria direto e seria cortado
1011:     * em silencio mais adiante - aqui o corte acontece com o valor ja visivel
1012:     * de volta no controle, e nunca chega truncado ao UPDATE.
1013:     *
1014:     * Depois do ajuste, propaga o estado da TELA para o BO: o legado lia
1015:     * crGrade.CLocals/CTxtCds direto (ControlSource mantinha cursor e tela
1016:     * iguais), enquanto aqui quem grava e imprime sao as propriedades *Atual.
1017:     *--------------------------------------------------------------------------
1018:     PROTECTED PROCEDURE SincronizarCampoParcela(par_oCampo, par_nLargura)
1019:         LOCAL loc_cValor, loc_oErro
1020: 
1021:         *-- RETURN de guarda FORA do TRY/CATCH (CLAUDE.md regra #1).
1022:         IF THIS.this_lSincronizandoParcela
1023:             RETURN
1024:         ENDIF
1025: 
1026:         THIS.this_lSincronizandoParcela = .T.
1027: 
1028:         TRY
1029:             IF VARTYPE(par_oCampo) = "O" AND VARTYPE(par_oCampo.Value) = "C"
1030:                 loc_cValor = par_oCampo.Value

*-- Linhas 1053 a 1090:
1053:     * partir do registro corrente; em seguida this_cLocalPgtoAtual/
1054:     * this_cTextoCedenteAtual sao reafirmados a partir dos CONTROLES, que sao
1055:     * a fonte do que o usuario de fato ve - sem depender do instante em que o
1056:     * ControlSource descarrega o valor editado no cursor.
1057:     *--------------------------------------------------------------------------
1058:     PROTECTED PROCEDURE SincronizarBOComTela()
1059:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1060:             RETURN
1061:         ENDIF
1062: 
1063:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1064: 
1065:         *-- So sobrepoe o valor lido do cursor quando o EditBox esta de fato
1066:         *-- LIGADO a coluna (ControlSource atribuido em CarregarDados). Sem
1067:         *-- esta condicao, um caminho em que a ligacao nao ocorreu - cursor
1068:         *-- populado mas CarregarDados interrompido - faria o ""  do controle
1069:         *-- apagar o valor que CarregarDoCursor acabou de trazer do cursor.
1070:         IF UPPER(ALLTRIM(THIS.obj_4c_GetLocals.ControlSource)) == "CURSOR_4C_DADOS.CLOCALS" AND ;
1071:                 VARTYPE(THIS.obj_4c_GetLocals.Value) = "C"
1072:             THIS.this_oBusinessObject.this_cLocalPgtoAtual = THIS.obj_4c_GetLocals.Value
1073:         ENDIF
1074: 
1075:         IF UPPER(ALLTRIM(THIS.obj_4c_GetTxtCds.ControlSource)) == "CURSOR_4C_DADOS.CTXTCDS" AND ;
1076:                 VARTYPE(THIS.obj_4c_GetTxtCds.Value) = "C"
1077:             THIS.this_oBusinessObject.this_cTextoCedenteAtual = THIS.obj_4c_GetTxtCds.Value
1078:         ENDIF
1079:     ENDPROC
1080: 
1081:     *--------------------------------------------------------------------------
1082:     * Imprimir - equivalente a Procedure imprimir() do legado (chamada apos
1083:     * a confirmacao em btnImprimir.Click). Antes de delegar a
1084:     * SigPrIbbBO.ImprimirBoleto(), chama SincronizarBOComTela() - o mesmo
1085:     * ponto de sincronizacao usado pelos handlers de LostFocus dos dois
1086:     * EditBox editaveis. Necessario porque o botao Imprimir pode ser acionado
1087:     * por ENTER/atalho sem que o campo editado tenha perdido o foco, e porque
1088:     * ImprimirBoleto() le as propriedades *Atual do BO, nao o cursor.
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE Imprimir()


### BO (C:\4c\projeto\app\classes\SigPrIbbBO.prg):
*============================================================================
* SigPrIbbBO.prg - Business Object para Impressao de Boleto Bancario (SIGPRIBB)
*
* Form OPERACIONAL (SIGPRIBB / FormSigPrIbb): tela de impressao aberta com a
* chave de negocio do documento de movimentacao ja resolvida pelo chamador
* (equivalente ao par_cEmpDopNum passado ao Init do legado - ver
* tasks/task622/SIGPRIBB_form_codigo_fonte.txt, Procedure Init(pEdn, pFrm)).
* A tela mostra:
*   - grd_4c_Dados (crGrade no legado) com as condicoes de pagamento do
*     documento que tem boleto habilitado (SigMvPar x SigCdOpe x SigOpCdc x
*     SigOpFp, filtrando ImpBols = 1 nos dois lados - operacao e forma de
*     pagamento);
*   - a parcela selecionada na grade, com o texto de local de pagamento e o
*     texto de responsabilidade do cedente (memos da linha corrente);
*   - os dados do cliente/endereco de cobranca usados para montar o layout
*     impresso do boleto (crDados no legado), resolvidos a partir de
*     SigMvCab/SigMvNfi (e do cadastro de cliente) no momento do Imprimir.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO/SigPrHprBO): o documento vem de SigMvCab resolvido
* pela chave de negocio EmpDopNums, e as parcelas vem de SigMvPar filtradas
* por essa mesma chave. this_cCampoChave aponta para "empdopnums"
* (SigMvCab.empdopnums / SigMvPar.empdopnums), que eh o campo usado para
* localizar o documento e suas parcelas.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de dominio (CarregarParcelas,
* CarregarDoCursor, CarregarDadosDocumento, AtualizarConfiguracaoBoleto,
* CarregarConfiguracaoLayout, VerificarImpressoraDisponivel,
* CarregarDadosImpressao, MontarLayoutImpressao, ExecutarImpressaoMatricial,
* ImprimirBoleto, ObterChavePrimaria)
*============================================================================

DEFINE CLASS SigPrIbbBO AS BusinessBase

    *==========================================================================
    * Chave de negocio do documento recebida na abertura (equivalente ao
    * par_cEmpDopNum/pEdn do legado - PADR(pEdn, 29) antes de ser repassado)
    *==========================================================================
    this_cEmpDopNum   = SPACE(29)  && empdopnums CHAR(29) - Emps(3)+Dopes(20)+Numes(6)
    this_cEmps        = SPACE(3)   && emps       CHAR(3)  - Empresa (Substr(EmpDopNum,1,3))
    this_cDopes       = SPACE(20)  && dopes      CHAR(20) - Tipo de Operacao/Documento (Substr(EmpDopNum,4,20))
    this_nNumes       = 0          && numes      NUM(6,0) - Numero sequencial do documento (Substr(EmpDopNum,24,6))

    *==========================================================================
    * Dados do documento de movimentacao (SigMvCab - equivalente a
    * crTprMvCab no legado, resolvido via CursorQuery por EmpDopNums)
    *==========================================================================
    this_cContaOs     = SPACE(10)  && contaos CHAR(10) - Conta de origem do documento
    this_cContaDs     = SPACE(10)  && contads CHAR(10) - Conta de destino do documento

    *==========================================================================
    * Parcela selecionada na grade (equivalente a crGrade na linha ativa -
    * usado por grdItens.AfterRowColChange/btnImprimir.Click do legado)
    *==========================================================================
    this_cFPagsAtual      = SPACE(12)  && crGrade.FPags   (SigMvPar.fpags  CHAR(12)) - Forma de pagamento
    this_nParcsAtual      = 0          && crGrade.Parcs   (SigMvPar.parcs NUM(2,0)) - Numero da parcela
    this_dVencsAtual      = {}         && crGrade.Vencs   (SigMvPar.vencs DATETIME) - Vencimento da parcela
    this_dDatasAtual      = {}         && crGrade.Datas   (SigMvPar.datas DATETIME) - Data de emissao da parcela
    this_nValosAtual      = 0          && crGrade.Valos   (SigMvPar.valos NUM(11,2)) - Valor da parcela
    this_cLocalPgtoAtual  = ""         && crGrade.CLocals (texto livre - local de pagamento da condicao)
    this_cTextoCedenteAtual = ""       && crGrade.CTxtCds (memo - texto de responsabilidade do cedente)

    *==========================================================================
    * Dados para montagem do layout impresso do boleto (equivalente a
    * crDados no legado, populado pelo metodo Imprimir a partir de
    * SigMvCab/SigMvNfi e do cadastro de cliente da movimentacao)
    *==========================================================================
    this_cLocalPgtoImpressao = ""        && crDados.CLocals - Local de pagamento (texto impresso)
    this_cVencimentoImpresso = SPACE(12) && crDados.Vencs   - Vencimento formatado para impressao
    this_dDataDocumento      = {}        && crDados.DatDoc  - Data do documento
    this_cNumeroDocumento    = SPACE(8)  && crDados.NumDoc  - Numero do documento/nota fiscal
    this_nValorImpressao     = 0         && crDados.Valor   - Valor total a imprimir
    this_cRazaoSocial        = ""        && crDados.Razaos  - Razao social/nome do cliente
    this_cCpfCnpj            = SPACE(20) && crDados.Cpfs    - CPF/CNPJ do cliente
    this_cEndereco           = ""        && crDados.EndCobs - Endereco de cobranca
    this_cBairro             = SPACE(20) && crDados.BaiCobs - Bairro de cobranca
    this_cCidade             = SPACE(20) && crDados.CidCobs - Cidade de cobranca
    this_cEstado             = SPACE(2)  && crDados.EstCobs - Estado (UF) de cobranca
    this_cCep                = SPACE(9)  && crDados.CepCobs - CEP de cobranca
    this_cTextoComplementar  = ""        && crDados.Texto   - Texto livre complementar do boleto

    *==========================================================================
    * Total das parcelas boleto-habilitadas da grade (equivalente a
    * ThisForm.getTotal.Value do legado - soma de crGrade.Valos)
    *==========================================================================
    this_nTotalParcelas = 0

    *==========================================================================
    * Forma de pagamento da parcela atual (equivalente a crTmpFpag.ImpNotas -
    * decide, em CarregarDadosImpressao, se o vencimento impresso eh a data
    * (Dtoc(Vencs)) ou a propria condicao de pagamento (FPags))
    *==========================================================================
    this_nImpNotasAtual = 0

    *==========================================================================
    * Configuracao de impressao do boleto (SigCnFBl) para o FPags atual -
    * equivalente a LocalCfgBl no legado. Reusa SIGPRIBLBO (mesma tabela,
    * ja migrada - classes/SIGPRIBLBO.prg/forms/operacionais/FormSIGPRIBL.prg)
    * em vez de duplicar as ~30 propriedades de posicao de impressao.
    *==========================================================================
    this_oConfigBoleto = .NULL.

    *==========================================================================
    * Controle de processamento
    *==========================================================================
    this_lResultadoOk  = .F.   && Resultado da ultima operacao (carga/impressao)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de impressao (o documento vem de SigMvCab e
    * as parcelas vem de SigMvPar, ambos filtrados por EmpDopNums recebido
    * do chamador) - mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init/
    * SigPrHprBO.Init. this_cCampoChave fica com "empdopnums", unico campo
    * usado para localizar o documento e suas parcelas.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "empdopnums"

            THIS.this_cEmpDopNum = SPACE(29)
            THIS.this_cEmps      = SPACE(3)
            THIS.this_cDopes     = SPACE(20)
            THIS.this_nNumes     = 0

            THIS.this_cContaOs   = SPACE(10)
            THIS.this_cContaDs   = SPACE(10)

            THIS.this_cFPagsAtual         = SPACE(12)
            THIS.this_nParcsAtual         = 0
            THIS.this_dVencsAtual         = {}
            THIS.this_dDatasAtual         = {}
            THIS.this_nValosAtual         = 0
            THIS.this_cLocalPgtoAtual     = ""
            THIS.this_cTextoCedenteAtual  = ""

            THIS.this_cLocalPgtoImpressao = ""
            THIS.this_cVencimentoImpresso = SPACE(12)
            THIS.this_dDataDocumento      = {}
            THIS.this_cNumeroDocumento    = SPACE(8)
            THIS.this_nValorImpressao     = 0
            THIS.this_cRazaoSocial        = ""
            THIS.this_cCpfCnpj            = SPACE(20)
            THIS.this_cEndereco           = ""
            THIS.this_cBairro             = SPACE(20)
            THIS.this_cCidade             = SPACE(20)
            THIS.this_cEstado             = SPACE(2)
            THIS.this_cCep                = SPACE(9)
            THIS.this_cTextoComplementar  = ""

            THIS.this_nTotalParcelas  = 0
            THIS.this_nImpNotasAtual  = 0
            THIS.this_oConfigBoleto   = .NULL.

            THIS.this_lResultadoOk = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos a
    * atualizacao de SigCnFBl (AtualizarConfiguracaoBoleto) - FPags da
    * parcela/condicao de pagamento atual, que eh o campo de negocio usado
    * pelo legado no "Update SigCnFBl ... Where FPags = ...".
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cFPagsAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh uma tela de IMPRESSAO (sem cadastro
    * generico de uma entidade), sem INSERT/UPDATE/DELETE genericos no
    * legado nem fluxo de EditarRegistro()/NovoRegistro() + Salvar(). A
    * UNICA escrita real do legado (dentro de Procedure imprimir) eh o
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito ANTES de imprimir - tem semantica propria e esta implementado
    * em AtualizarConfiguracaoBoleto(), mais abaixo, que chama
    * RegistrarAuditoria("UPDATE") no sucesso. O comportamento padrao
    * herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao ja eh
    * o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute/CursorQuery do legado, que
    * nao reselecionam a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
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
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarParcelas - equivalente a SelecionaDados() do legado: popula
    * cursor_4c_Dados (crGrade) com as condicoes de pagamento do documento
    * (par_cEmpDopNum) que tem boleto habilitado nos dois lados - operacao
    * (SigOpCdc.ImpBols = 1) e forma de pagamento (SigOpFp.ImpBols = 1) -
    * enriquecidas com o local/texto de cobranca configurados em SigCnFBl
    * (com fallback para a linha de config em branco, FPags = Space(12),
    * igual ao legado). Deixa o cursor posicionado no PRIMEIRO registro
    * (Go Top legado) e THIS.this_nTotalParcelas com a soma de Valos.
    *==========================================================================
    FUNCTION CarregarParcelas(par_cEmpDopNum)
        LOCAL loc_lResultado, loc_cSQL, loc_nTotal, loc_oErro

        loc_lResultado = .F.
        loc_nTotal     = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cEmpDopNum = PADR(TratarNulo(par_cEmpDopNum, ""), 29)
        THIS.this_cEmps      = SUBSTR(THIS.this_cEmpDopNum, 01, 03)
        THIS.this_cDopes     = SUBSTR(THIS.this_cEmpDopNum, 04, 20)
        THIS.this_nNumes     = VAL(SUBSTR(THIS.this_cEmpDopNum, 24, 06))

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (FPags C(12), Parcs N(2,0), CLocals C(100), Vencs D, Datas D, Valos N(12,2), CTxtCds M)
            SET NULL OFF

            loc_cSQL = "SELECT b.fpags, b.parcs, b.vencs, b.datas, b.valos " + ;
                "FROM SigMvCab a, SigMvPar b, SigCdOpe c, SigOpCdc d, SigOpFp e " + ;
                "WHERE a.empdopnums = " + EscaparSQL(THIS.this_cEmpDopNum) + " " + ;
                "AND a.empdopnums = b.empdopnums " + ;
                "AND b.dopes = c.dopes " + ;
                "AND c.dopes = d.dopes " + ;
                "AND d.impbols = 1 " + ;
                "AND b.fpags = e.fpags " + ;
                "AND e.impbols = 1 " + ;
                "ORDER BY b.fpags, b.parcs"

            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Selecao", "Selecao")
                IF USED("cursor_4c_Selecao")
                    SELECT cursor_4c_Selecao
                    SCAN
                        IF !THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(PADR(cursor_4c_Selecao.fpags, 12)), "cursor_4c_CfgBoleto", "ConfigBoleto") ;
                                OR !USED("cursor_4c_CfgBoleto") OR RECCOUNT("cursor_4c_CfgBoleto") = 0
                            THIS.ExecutarSQL("SELECT clocals, ctxtcds FROM SigCnFBl WHERE fpags = " + ;
                                EscaparSQL(SPACE(12)), "cursor_4c_CfgBoleto", "ConfigBoleto")
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto") AND RECCOUNT("cursor_4c_CfgBoleto") > 0
                            SELECT cursor_4c_CfgBoleto
                            GO TOP

                            INSERT INTO cursor_4c_Dados (FPags, Parcs, Vencs, Datas, Valos, CLocals, CTxtCds) ;
                                VALUES (cursor_4c_Selecao.fpags, cursor_4c_Selecao.parcs, ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.vencs, {})), ;
                                    ConverterParaData(TratarNulo(cursor_4c_Selecao.datas, {})), ;
                                    cursor_4c_Selecao.valos, cursor_4c_CfgBoleto.clocals, ;
                                    TratarNulo(cursor_4c_CfgBoleto.ctxtcds, ""))

                            loc_nTotal = loc_nTotal + cursor_4c_Selecao.valos
                        ENDIF

                        IF USED("cursor_4c_CfgBoleto")
                            USE IN cursor_4c_CfgBoleto
                        ENDIF

                        SELECT cursor_4c_Selecao
                    ENDSCAN
                    USE IN cursor_4c_Selecao
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("cursor_4c_Dados")
                GO TOP IN cursor_4c_Dados
            ENDIF

            THIS.this_nTotalParcelas = loc_nTotal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao selecionar condi" + CHR(231) + CHR(245) + "es de pagamento: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do grdItens
    * legado: le o registro CORRENTE de cursor_4c_Dados (a linha selecionada
    * na grade) para as propriedades *Atual usadas pelo restante do fluxo
    * de impressao.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cFPagsAtual        = PADR(TratarNulo(FPags, ""), 12)
            THIS.this_nParcsAtual        = TratarNulo(Parcs, 0)
            THIS.this_dVencsAtual        = TratarNulo(Vencs, {})
            THIS.this_dDatasAtual        = TratarNulo(Datas, {})
            THIS.this_nValosAtual        = TratarNulo(Valos, 0)
            THIS.this_cLocalPgtoAtual    = TratarNulo(CLocals, "")
            THIS.this_cTextoCedenteAtual = TratarNulo(CTxtCds, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosDocumento - equivalente aos passos 1 a 5 de Procedure
    * imprimir() do legado (ANTES da atualizacao de SigCnFBl): resolve o
    * documento (SigMvCab), o numero/parcela impresso (SigMvNfi, com
    * fallback "Parc.: NN"), a operacao (SigCdOpe.Nfiscals, que decide se a
    * conta a cobrar eh a origem ou o destino do movimento), o cliente
    * (SigCdCli, com fallback Cobranca->Normal em endereco/bairro/cidade/
    * estado/cep) e a forma de pagamento (SigOpFp.ImpNotas). Requer que
    * CarregarDoCursor() ja tenha resolvido a parcela atual.
    *==========================================================================
    FUNCTION CarregarDadosDocumento()
        LOCAL loc_cCliente

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        *-- 1) SigMvCab - documento do movimento (Dopes, ContaOs, ContaDs)
        IF !THIS.ExecutarSQL("SELECT dopes, contaos, contads FROM SigMvCab WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Documento", "Documento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Documento") OR RECCOUNT("cursor_4c_Documento") = 0
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
            THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Documento
        GO TOP
        THIS.this_cDopes   = PADR(TratarNulo(dopes, ""), 20)
        THIS.this_cContaOs = PADR(TratarNulo(contaos, ""), 10)
        THIS.this_cContaDs = PADR(TratarNulo(contads, ""), 10)
        USE IN cursor_4c_Documento

        *-- 2) SigMvNfi - numero do documento impresso (fallback: "Parc.: NN")
        THIS.this_cNumeroDocumento = LEFT("Parc.: " + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
        IF THIS.ExecutarSQL("SELECT nfis FROM SigMvNfi WHERE empdopnums = " + ;
                EscaparSQL(THIS.this_cEmpDopNum), "cursor_4c_Nfis", "NotaFiscal")
            IF USED("cursor_4c_Nfis") AND RECCOUNT("cursor_4c_Nfis") > 0
                SELECT cursor_4c_Nfis
                GO TOP
                THIS.this_cNumeroDocumento = LEFT(ALLTRIM(TratarNulo(nfis, "")) + "-" + ALLTRIM(STR(THIS.this_nParcsAtual, 2)), 8)
            ENDIF
            IF USED("cursor_4c_Nfis")
                USE IN cursor_4c_Nfis
            ENDIF
        ENDIF

        *-- 3) SigCdOpe - Nfiscals decide se a conta a cobrar eh origem ou destino
        IF !THIS.ExecutarSQL("SELECT nfiscals FROM SigCdOpe WHERE dopes = " + ;
                EscaparSQL(THIS.this_cDopes), "cursor_4c_Operacao", "Operacao")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Operacao
        GO TOP
        loc_cCliente = IIF(NVL(nfiscals, 0) = 1, THIS.this_cContaOs, THIS.this_cContaDs)
        USE IN cursor_4c_Operacao

        *-- 4) SigCdCli - cliente a cobrar, com fallback Cobranca -> Normal
        IF !THIS.ExecutarSQL("SELECT razaos, cpfs, endcobs, endes, baicobs, bairs, cidcobs, cidas, " + ;
                "estcobs, estas, cepcobs, ceps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCliente), ;
                "cursor_4c_Cliente", "Cliente")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_Cliente") OR RECCOUNT("cursor_4c_Cliente") = 0
            IF USED("cursor_4c_Cliente")
                USE IN cursor_4c_Cliente
            ENDIF
            THIS.this_cMensagemErro = 'Conta "' + ALLTRIM(loc_cCliente) + '" N' + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Cliente
        GO TOP
        THIS.this_cRazaoSocial = ALLTRIM(TratarNulo(razaos, ""))
        THIS.this_cCpfCnpj     = PADR(TratarNulo(cpfs, ""), 20)
        THIS.this_cEndereco    = IIF(!EMPTY(TratarNulo(endcobs, "")), ALLTRIM(endcobs), ALLTRIM(TratarNulo(endes, "")))
        THIS.this_cBairro      = PADR(IIF(!EMPTY(TratarNulo(baicobs, "")), ALLTRIM(baicobs), ALLTRIM(TratarNulo(bairs, ""))), 20)
        THIS.this_cCidade      = PADR(IIF(!EMPTY(TratarNulo(cidcobs, "")), ALLTRIM(cidcobs), ALLTRIM(TratarNulo(cidas, ""))), 20)
        THIS.this_cEstado      = PADR(IIF(!EMPTY(TratarNulo(estcobs, "")), ALLTRIM(estcobs), ALLTRIM(TratarNulo(estas, ""))), 2)
        THIS.this_cCep         = PADR(IIF(!EMPTY(TratarNulo(cepcobs, "")), ALLTRIM(cepcobs), ALLTRIM(TratarNulo(ceps, ""))), 9)
        USE IN cursor_4c_Cliente

        *-- 5) SigOpFp - ImpNotas decide (em CarregarDadosImpressao) o vencimento impresso
        IF !THIS.ExecutarSQL("SELECT impbols, impnotas FROM SigOpFp WHERE fpags = " + ;
                EscaparSQL(PADR(THIS.this_cFPagsAtual, 12)), "cursor_4c_FormaPgto", "FormaPagamento")
            RETURN .F.
        ENDIF
        IF !USED("cursor_4c_FormaPgto") OR RECCOUNT("cursor_4c_FormaPgto") = 0
            IF USED("cursor_4c_FormaPgto")
                USE IN cursor_4c_FormaPgto
            ENDIF
            THIS.this_cMensagemErro = "Forma de Pagamento N" + CHR(227) + "o Encontrada!!!"
            RETURN .F.
        ENDIF
        SELECT cursor_4c_FormaPgto
        GO TOP
        THIS.this_nImpNotasAtual = NVL(impnotas, 0)
        USE IN cursor_4c_FormaPgto

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * AtualizarConfiguracaoBoleto - equivalente ao
    * "Update SigCnFBl Set CLocals = ..., CTxtCds = ... Where FPags = ..."
    * feito dentro de Procedure imprimir() do legado (ANTES de montar o
    * layout de impressao - grava o local de pagamento/texto de cedente
    * eventualmente editados pelo usuario nos getLocals/getTxtCds, que no
    * legado estao ligados direto a crGrade.CLocals/CTxtCds). Chama
    * RegistrarAuditoria("UPDATE") no sucesso (ver ObterChavePrimaria acima).
    *
    * O legado NAO para no UPDATE: logo depois dele vem um SEGUNDO teste,
    * "If (ThisForm.poDataMgr.Commit() < 1)", com a MESMA mensagem de falha -
    * porque o fSqlConector do Framework abre a conexao em transacao MANUAL
    * (cOpenConn.Init seta Transactions = 2 de proposito) e sem o Commit o
    * UPDATE nao eh efetivado. Neste ambiente a premissa se mantem: medido em
    * 2026-09-18 num VFP9 virgem, SQLGETPROP(0, "Transactions") ja vale 2, de
    * modo que gnConnHandle tambem nasce manual. Sem este Commit, a edicao do
    * local de pagamento / texto do cedente ficaria presa na transacao aberta
    * e SUMIRIA se o processo morresse - sem erro nenhum na tela, porque o
    * SELECT de conferencia na MESMA conexao enxerga a propria transacao.
    * Commit/Rollback so quando a conexao esta de fato em modo manual (mesmo
    * criterio de SIGPRCNBBO.prg:471) - em auto-commit o par seria inerte.
    *==========================================================================
    FUNCTION AtualizarConfiguracaoBoleto()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_lManual, loc_cFalha

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cFPagsAtual))
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        loc_cSQL = "UPDATE SigCnFBl SET " + ;
            "clocals = " + EscaparSQL(THIS.this_cLocalPgtoAtual) + ", " + ;
            "ctxtcds = " + EscaparSQL(THIS.this_cTextoCedenteAtual) + " " + ;
            "WHERE fpags = " + EscaparSQL(PADR(THIS.this_cFPagsAtual, 12))

        *-- Mensagem UNICA para as duas falhas, como no legado (UPDATE e
        *-- Commit exibem o mesmo texto, com o mesmo titulo).
        loc_cFalha = "A Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Pode Ser Atualizada!!!" + ;
            CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_nRet    = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nRet < 0
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
        ELSE
            loc_lResultado = .T.

            *-- Equivalente ao "If (ThisForm.poDataMgr.Commit() < 1)" do
            *-- legado: SQLCOMMIT devolve 1 no sucesso e -1 no erro. IF
            *-- ANINHADO, nao "loc_lManual AND SQLCOMMIT(...)": o VFP9 NAO faz
            *-- curto-circuito em AND/OR e chamaria SQLCOMMIT tambem com a
            *-- conexao em auto-commit.
            IF loc_lManual
                IF SQLCOMMIT(gnConnHandle) <= 0
                    = SQLROLLBACK(gnConnHandle)
                    THIS.this_cMensagemErro = loc_cFalha + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado
                THIS.RegistrarAuditoria("UPDATE")
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarConfiguracaoLayout - equivalente a
    * "If Not CursorQuery(SigCnFBl, LocalCfgBl, FPags, crGrade.FPags) Then
    *  CursorQuery(..., FPags, Space(12))" do legado: carrega a configuracao
    * de posicoes de impressao para o FPags atual, com fallback para a
    * configuracao em branco. Reusa SIGPRIBLBO (mesma tabela SigCnFBl, ja
    * migrada) em vez de duplicar as propriedades de posicao.
    *==========================================================================
    FUNCTION CarregarConfiguracaoLayout()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        THIS.this_oConfigBoleto = CREATEOBJECT("SIGPRIBLBO")

        IF !THIS.this_oConfigBoleto.BuscarConfiguracao(PADR(THIS.this_cFPagsAtual, 12))
            THIS.this_oConfigBoleto.BuscarConfiguracao(SPACE(12))
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_oConfigBoleto.this_cIdChaves))
            THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ELSE
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarImpressoraDisponivel - equivalente ao bloco
    * "Declare laPrn(1) / If (APrinters(laPrn) > 0) ..." do legado: confirma
    * que a impressora configurada em SigCnFBl.CNomeImps esta instalada no
    * Windows. Requer que CarregarConfiguracaoLayout() ja tenha resolvido
    * THIS.this_oConfigBoleto.
    *==========================================================================
    FUNCTION VerificarImpressoraDisponivel()
        LOCAL loc_lResultado, loc_nQtd, loc_nI
        LOCAL ARRAY loc_aImpressoras(1)

        loc_lResultado = .F.

        loc_nQtd = APRINTERS(loc_aImpressoras)
        IF loc_nQtd > 0
            FOR loc_nI = 1 TO loc_nQtd
                IF UPPER(ALLTRIM(loc_aImpressoras(loc_nI, 1))) == UPPER(ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
                    loc_lResultado = .T.
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Impressora de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + "o Encontrada!!!" + ;
                CHR(13) + "Condi" + CHR(231) + CHR(227) + "o de Pagamento: " + ALLTRIM(THIS.this_cFPagsAtual)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDadosImpressao - equivalente ao bloco final de dados de
    * Procedure imprimir() do legado: resolve o vencimento impresso
    * (ldVct = Iif(ImpNotas = 1, Dtoc(Vencs), FPags)) e monta
    * cursor_4c_Impressao (crDados) com os dados ja resolvidos por
    * CarregarDadosDocumento()/CarregarDoCursor().
    *==========================================================================
    FUNCTION CarregarDadosImpressao()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        THIS.this_cLocalPgtoImpressao = THIS.this_cLocalPgtoAtual
        THIS.this_cVencimentoImpresso = PADR(IIF(THIS.this_nImpNotasAtual = 1, DTOC(THIS.this_dVencsAtual), THIS.this_cFPagsAtual), 12)
        THIS.this_dDataDocumento      = THIS.this_dDatasAtual
        THIS.this_nValorImpressao     = THIS.this_nValosAtual
        THIS.this_cTextoComplementar  = THIS.this_cTextoCedenteAtual

        TRY
            IF USED("cursor_4c_Impressao")
                USE IN cursor_4c_Impressao
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Impressao (CLocals C(100), Vencs C(12), DatDoc D, NumDoc C(8), Valor N(14,2), ;
                Razaos C(50), Cpfs C(20), EndCobs C(80), BaiCobs C(20), CidCobs C(20), EstCobs C(2), CepCobs C(9), Texto M)
            SET NULL OFF

            INSERT INTO cursor_4c_Impressao (CLocals, Vencs, DatDoc, NumDoc, Valor, Razaos, Cpfs, Texto, ;
                EndCobs, BaiCobs, CidCobs, EstCobs, CepCobs) ;
                VALUES (THIS.this_cLocalPgtoImpressao, THIS.this_cVencimentoImpresso, THIS.this_dDataDocumento, ;
                    THIS.this_cNumeroDocumento, THIS.this_nValorImpressao, THIS.this_cRazaoSocial, THIS.this_cCpfCnpj, ;
                    THIS.this_cTextoComplementar, THIS.this_cEndereco, THIS.this_cBairro, THIS.this_cCidade, ;
                    THIS.this_cEstado, THIS.this_cCep)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar dados de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * InserirLinhaImpressao - equivalente a ThisForm.Detalhe(...) do legado:
    * insere uma linha em cursor_4c_LayoutImpressao (TmpImprime) SOMENTE
    * quando a posicao esta configurada (Linha<>0 Or Coluna<>0) - posicao
    * zerada em SigCnFBl significa "este campo nao imprime neste layout".
    * Todas as 13 chamadas do legado omitem o 4o parametro (lcEst), que cai
    * no default "X" - por isso o estilo nao eh exposto aqui.
    *==========================================================================
    PROTECTED PROCEDURE InserirLinhaImpressao(par_nLinha, par_nColuna, par_cConteudo, par_nTamanho, par_nAltura)
        LOCAL loc_nLinha, loc_nColuna, loc_cConteudo

        loc_nLinha    = TratarNulo(par_nLinha, 0)
        loc_nColuna   = TratarNulo(par_nColuna, 0)
        loc_cConteudo = TratarNulo(par_cConteudo, "")

        IF loc_nColuna <> 0 OR loc_nLinha <> 0
            INSERT INTO cursor_4c_LayoutImpressao (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                VALUES (loc_nLinha, loc_nColuna, loc_cConteudo, "X", TratarNulo(par_nTamanho, 0), TratarNulo(par_nAltura, 0))
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarLayoutImpressao - equivalente aos 13 ThisForm.Detalhe(...) de
    * Procedure imprimir() do legado: monta cursor_4c_LayoutImpressao
    * (TmpImprime) com cada campo do boleto na posicao (Linha/Coluna)
    * configurada em THIS.this_oConfigBoleto. Requer que
    * CarregarConfiguracaoLayout() e CarregarDadosImpressao() ja tenham
    * rodado.
    *==========================================================================
    FUNCTION MontarLayoutImpressao()
        LOCAL loc_lResultado, loc_oCfg, loc_oErro

        loc_lResultado = .F.
        loc_oCfg = THIS.this_oConfigBoleto

        TRY
            IF USED("cursor_4c_LayoutImpressao")
                USE IN cursor_4c_LayoutImpressao
            ENDIF
            CREATE CURSOR cursor_4c_LayoutImpressao (Linha N(6,2), Coluna N(6,2), Conteudo C(100), Style C(3), LineSize N(6,2), NHeight N(6,2))
            INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem

            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnLocals,  loc_oCfg.this_nClLocals,  THIS.this_cLocalPgtoImpressao,   60, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtVencs, loc_oCfg.this_nClDtVencs, THIS.this_cVencimentoImpresso,    9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnDtDocs,  loc_oCfg.this_nClDtDocs,  DTOC(THIS.this_dDataDocumento),   9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnNrDocs,  loc_oCfg.this_nClNrDocs,  THIS.this_cNumeroDocumento,       9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnVlDocs,  loc_oCfg.this_nClVlDocs,  TRANSFORM(THIS.this_nValorImpressao, "@Z 999,999,999.99"), 15, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnRazClis, loc_oCfg.this_nClRazClis, ALLTRIM(THIS.this_cRazaoSocial),  50, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCgcClis, loc_oCfg.this_nClCgcClis, ALLTRIM(THIS.this_cCpfCnpj),      20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEndCobs, loc_oCfg.this_nClEndCobs, ALLTRIM(THIS.this_cEndereco),     80, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnBaiCobs, loc_oCfg.this_nClBaiCobs, ALLTRIM(THIS.this_cBairro),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCidCobs, loc_oCfg.this_nClCidCobs, ALLTRIM(THIS.this_cCidade),       20, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnEstCobs, loc_oCfg.this_nClEstCobs, ALLTRIM(THIS.this_cEstado),        2, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnCepCobs, loc_oCfg.this_nClCepCobs, ALLTRIM(THIS.this_cCep),           9, 1)
            THIS.InserirLinhaImpressao(loc_oCfg.this_nLnTxtCds,  loc_oCfg.this_nClTxtCds,  THIS.this_cTextoComplementar,     60, 6)

            IF USED("cursor_4c_LayoutImpressao")
                GO TOP IN cursor_4c_LayoutImpressao
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar layout de impress" + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTamanhoFolha - equivalente ao parse de LocalCfgBl.CTamFolha do
    * legado (formato "A/largura/B" - extrai o 2o segmento, separado por
    * "/", como tamanho numerico da folha/pagina).
    *==========================================================================
    PROTECTED FUNCTION ObterTamanhoFolha()
        LOCAL loc_cTamFolha, loc_nPos1, loc_nPos2

        loc_cTamFolha = TratarNulo(THIS.this_oConfigBoleto.this_cTamFolha, "")
        loc_nPos1 = AT("/", loc_cTamFolha, 1) + 1
        loc_nPos2 = AT("/", loc_cTamFolha, 2) - (AT("/", loc_cTamFolha, 1) + 1)

        IF loc_nPos2 <= 0
            RETURN 0
        ENDIF

        RETURN VAL(ALLTRIM(SUBSTR(loc_cTamFolha, loc_nPos1, loc_nPos2)))
    ENDFUNC

    *==========================================================================
    * ExecutarImpressaoMatricial - equivalente a
    * "Do SigPrIbl With [TmpImprime], CNomeImps, [To Printer NoConsole], ...,
    * [crDados], 17" do legado: envia cursor_4c_LayoutImpressao para a
    * impressora configurada, posicionando cada linha por Linha/Coluna. A
    * rotina generica de impressao matricial do legado (p-code de
    * SIGFUNCS.PRG, fora do acervo) nao existe para ser chamada - a
    * reproducao fiel usa os comandos nativos de impressora do VFP9 sobre
    * os MESMOS dados (mesmas posicoes, mesmo conteudo) preparados acima.
    * Suprimida em gb_4c_ModoTeste para nao depender de impressora real
    * durante os testes automatizados.
    *==========================================================================
    PROTECTED FUNCTION ExecutarImpressaoMatricial()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        IF !USED("cursor_4c_LayoutImpressao")
            THIS.this_cMensagemErro = "Layout de impress" + CHR(227) + "o n" + CHR(227) + "o gerado."
            RETURN .F.
        ENDIF

        TRY
            SET PRINTER TO NAME (ALLTRIM(THIS.this_oConfigBoleto.this_cNomeImps))
            SET DEVICE TO PRINTER

            SELECT cursor_4c_LayoutImpressao
            SCAN
                @ INT(Linha), INT(Coluna) SAY ALLTRIM(Conteudo)
            ENDSCAN

            EJECT
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT

            loc_lResultado = .T.
        CATCH TO loc_oErro
            SET DEVICE TO SCREEN
            SET PRINTER TO DEFAULT
            THIS.this_cMensagemErro = "Erro ao imprimir boleto banc" + CHR(225) + "rio: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ImprimirBoleto - equivalente a Procedure imprimir() do legado completa
    * (chamada por btnImprimir.Click apos a confirmacao do usuario): exige
    * que CarregarDoCursor() ja tenha resolvido a parcela selecionada, e
    * encadeia resolucao de documento/cliente, atualizacao da configuracao
    * de boleto, carga do layout, checagem de impressora, montagem dos
    * dados e do layout de impressao, e o disparo da impressao em si.
    *==========================================================================
    FUNCTION ImprimirBoleto()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            THIS.this_cMensagemErro = "Nenhuma condi" + CHR(231) + CHR(227) + "o de pagamento selecionada."
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosDocumento()
            RETURN .F.
        ENDIF

        IF !THIS.AtualizarConfiguracaoBoleto()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarConfiguracaoLayout()
            RETURN .F.
        ENDIF

        IF !THIS.VerificarImpressoraDisponivel()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarDadosImpressao()
            RETURN .F.
        ENDIF

        IF !THIS.MontarLayoutImpressao()
            RETURN .F.
        ENDIF

        loc_lResultado = THIS.ExecutarImpressaoMatricial()

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

