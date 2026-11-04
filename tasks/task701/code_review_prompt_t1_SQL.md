# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, EMPS, CODIGOS, CPROS

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
  Column1.ControlSource = "Historico.cBars"
  Column2.ControlSource = "Historico.Localis"
  Column3.ControlSource = "Historico.Ocors"
  Column4.ControlSource = "Historico.Obs"
  Column5.ControlSource = "Historico.PesReals"
  ControlSource = "historico.cbars"
  ControlSource = "historico.localis"
  ControlSource = "historico.ocors"
  ControlSource = "Historico.Obs"
  ControlSource = "historico.pesreals"
	.Column1.ControlSource = 'CrInvH.CBars'
	.Column2.ControlSource = 'CrInvH.Localis'
	.Column3.ControlSource = 'CrInvH.Ocors'
	.Column4.ControlSource = 'CrInvH.Obs'  
	.Column5.ControlSource = 'CrInvH.PesReals'
Select * From Historico Where .F. Into Cursor CrInvH ReadWrite
Select CrInvH
Select Historico
Select CrInvH
	lStrQuery = [Select CBars,CPros,Pesos ]+;
				[From SigOpEtq ]+;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'TmpBar') < 1
	Select TmpBar
					Delete File (lcConsulta)
	If !Seek(This.Value,'CrInvH','CBars')
		If Seek(This.Value,'Historico','CBars')
			Select Historico
			Insert Into CrInvH From MemVar
			lStrQuery = [Select * From SigIvTrH ]+;
			If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CrInvH') < 1
			Select CrInvH
	Select CrInvH
	Update CrInvH Set Obs = Nvl(Obs,'')
	Select CrInvH
	lStrQuery = [Select a.CPros,a.Linhas,a.FigJpgs,b.Descs ]+;
				[From SigCdPro a ]+;
				[Left Join SigCdLin b On b.Linhas = a.Linhas ]+;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
	Select TmpPro
					Delete File (lcConsulta)
	If !Seek(This.Value,'CrInvH','CPros')
		Select * From Historico Where CPros = This.Value Into Cursor TmpHistorico
		Select TmpHistorico
				Insert Into CrInvH From MemVar
				Select TmpHistorico
			lStrQuery = [Select * From SigIvTrH ]+;
			If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CrInvH') < 1
			Select CrInvH
	Select CrInvH
	Update CrInvH Set Obs = Nvl(Obs,'')
	Select CrInvH
Select CrInvH
		Select Historico
		If !Seek(ThisForm.Get_Produto.Value,'Historico','CPros')
			Select CrInvH
			Insert Into Historico From MemVar
		Select Historico
		Delete From Historico Where CPros = ThisForm.Get_Produto.Value
		Select Historico
		Select CrInvH
		Delete From CrInvH
		If !Seek(CrInvH.CBars,'Historico','CBars')
			Select CrInvH
			Insert Into Historico From MemVar
		Select Historico
		Delete In Historico
		Select CrInvH
		Delete In CrInvH
Select CrInvH
Select Historico

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcim.prg) - TRECHOS RELEVANTES PARA PASS SQL (1674 linhas total):

*-- Linhas 37 a 55:
37: * (exibicao, ReadOnly - equivalente ao "When / Return(.F.)" do legado) com
38: * os respectivos labels (lbl_4c_Label5/lbl_4c_Lbl_produto/
39: * lbl_4c_Lbl_descricao). Get_Peso/Get_Linha, a imagem (ShpFigura/ImgJpg) e
40: * a logica de Valid/When/LostFocus (lookups fwBuscaExt/SqlExecute) entram
41: * na Fase 6.
42: *
43: * Fase 6/8 - CAMPOS RESTANTES E LOOKUPS: txt_4c_Peso/txt_4c_Linha (campos
44: * de EXIBICAO - "When / Return(.F.)" no legado, aqui .ReadOnly = .T.) e a
45: * imagem do produto (shp_4c_ShpFigura/img_4c_ImgJpg). BINDEVENT completo
46: * dos campos de entrada: txt_4c_Barra usa GotFocus (equivalente ao When -
47: * reposiciona cursor_4c_InvH e trata a leitora serial) e LostFocus
48: * (equivalente a Valid+LostFocus combinados - consulta SigOpEtq via
49: * sigopcimBO.ConsultarBarra/ConsultarProduto, atualiza cursor_4c_InvH a
50: * partir de cursor_4c_Historico/SigIvTrH, decodifica a foto e devolve o
51: * foco a grade). txt_4c_Produto usa LostFocus com o picker FormBuscaAuxiliar
52: * (equivalente ao CreateObject('fwBuscaExt',...) do legado, regra CLAUDE.md
53: * #37) e fica habilitado so quando Barra esta vazio (equivalente ao When
54: * "Return(Empty(ThisForm.Get_Barra.Value))"). Consolidacao final na Fase 8.
55: *

*-- Linhas 79 a 119:
79: * legado JA TEM, espalhados e duplicados pelo migrador, viraram metodo unico
80: * - cada um deles e' a transcricao de um trecho que o SCX repete literalmente:
81: *
82: *   CarregarLista()        <- "Select CrInvH / Update CrInvH Set Obs =
83: *                             Nvl(Obs,'') / ThisForm.AcertaGrade() /
84: *                             Select CrInvH / Go Top", o rodape IDENTICO dos
85: *                             DOIS Valid (Get_Barra e Get_Produto). Popular o
86: *                             cursor NAO repinta a grade (regra CLAUDE.md
87: *                             #21a/#46) - por isso o funil unico, chamado em
88: *                             cada caminho que mexe no cursor da grade.
89: *   BOParaForm()           <- "Get_Produto.Value = TmpPro.CPros /
90: *                             Get_Descricao.Value = TmpPro.DPros /
91: *                             Get_Peso.Value = ... / Get_Linha.Value = ...",
92: *                             bloco que os dois Valid repetem.
93: *   FormParaBO()           <- a transferencia inversa (os dois campos de
94: *                             ENTRADA da tela para as properties do BO), que
95: *                             antes so existia como argumento solto de cada
96: *                             chamada.
97: *   AjustarBotoesPorModo() <- "ExcluiItem.Visible = Excluir / Shape2.Visible =
98: *                             Excluir / Shape3.Visible = !Excluir", as MESMAS
99: *                             tres linhas em TRES lugares do legado (Init,
100: *                             Valid de Get_Barra, Valid de Get_Produto).
101: *
102: * Mais tres consertos de fidelidade que a consolidacao expos:
103: *
104: *   (a) o FIM do Init legado nunca foi migrado - "Select Historico / Go Bottom
105: *       / Go Top" e a limpeza do campo Barra com o foco nele. O SetFocus vai
106: *       no Activate, nao no Init: antes de a tela estar visivel ele estoura
107: *       (padrao do projeto, ver FormSigMvMen).
108: *   (b) "ThisForm.Grade.RecordSource = ''" que o legado executa ANTES de
109: *       reconstruir CrInvH. O ramo de fallback FECHA e RECRIA esse cursor, e
110: *       derrubar um alias ligado ao Grid zera o ColumnCount dele (a grade vira
111: *       um retangulo branco, sem erro e sem log).
112: *   (c) a falha de CONEXAO das consultas de barra/produto era engolida. O
113: *       legado exibe "Favor reinicializar o processo !!!" e ABORTA o Valid
114: *       (Return(.F.)); o BO agora distingue "nao achei" (que NAO e erro) de
115: *       "a consulta falhou" com this_lFalhaConexao, e a tela aborta a leitura.
116: *       Pelo mesmo motivo a property do codigo de barras no BO passou a ser
117: *       NUMERICA (this_nBarra): cbars e numeric(14,0) no schema e o SCX declara
118: *       o TextBox com Value = 0 - guardar char exigiria STR/VAL nos dois
119: *       sentidos e qualquer SEEK no indice numerico com chave caractere

*-- Linhas 224 a 247:
224:                 THIS.AjustarBotoesPorModo()
225: 
226:                 *-- FIM do Init legado, que as fases anteriores descartaram:
227:                 *--   Select Historico / Go Bottom / Go Top
228:                 *--   ThisForm.Get_Barra.Value = ''
229:                 *-- (o SetFocus que fecha o Init legado esta no Activate -
230:                 *-- antes de a tela estar visivel ele estoura).
231:                 IF USED("cursor_4c_Historico")
232:                     SELECT cursor_4c_Historico
233:                     GO BOTTOM
234:                     GO TOP
235:                 ENDIF
236: 
237:                 *-- 0, nunca "": o controle e NUMERICO (ver CmdExcluiitemClick)
238:                 THIS.txt_4c_Barra.Value = 0
239:                 THIS.HabilitarCampos()
240: 
241:                 loc_lSucesso = .T.
242:             ENDIF
243:         CATCH TO loc_oErro
244:             MsgErro(loc_oErro.Message + CHR(13) + ;
245:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
246:                     "Procedure: " + loc_oErro.Procedure, ;
247:                     "Erro em InicializarForm")

*-- Linhas 530 a 548:
530:     *--------------------------------------------------------------------------
531:     * PrepararLeitoraParaFoco - equivalente ao PROCEDURE When de Get_Barra:
532:     * ao receber o foco, reposiciona cursor_4c_InvH no fim (equivalente a
533:     * "Select CrInvH / Go Bottom") e trata a leitora serial - se configurada
534:     * (THIS.this_oParentForm.TipoLeitora = "S"), garante a porta aberta; caso
535:     * contrario, "Set Confirm On" (comportamento padrao do legado quando nao
536:     * ha leitora serial). As properties TipoLeitora/LeituraSerial/ReadComm
537:     * pertencem ao form PAI (balanco/contagem de estoque) - guardas com
538:     * PEMSTATUS porque esse form pai pode nao existir fora do fluxo real
539:     * (modo teste/validacao de UI).
540:     *--------------------------------------------------------------------------
541:     PROTECTED PROCEDURE PrepararLeitoraParaFoco()
542:         IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "TipoLeitora", 5) ;
543:                 AND THIS.this_oParentForm.TipoLeitora = "S"
544:             IF PEMSTATUS(THIS.this_oParentForm, "LeituraSerial", 5) AND EMPTY(THIS.this_oParentForm.LeituraSerial)
545:                 THIS.AbrirPortaSerialSeNecessario()
546:             ENDIF
547:         ELSE
548:             SET CONFIRM ON

*-- Linhas 597 a 615:
597:     *--------------------------------------------------------------------------
598:     PROCEDURE ValidarAcessoBarra()
599:         IF USED("cursor_4c_InvH")
600:             SELECT cursor_4c_InvH
601:             GO BOTTOM
602:         ENDIF
603:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
604:             THIS.grd_4c_Dados.Refresh()
605:         ENDIF
606:         THIS.PrepararLeitoraParaFoco()
607:     ENDPROC
608: 
609:     *--------------------------------------------------------------------------
610:     * ValidarBarra - BINDEVENT "LostFocus" de txt_4c_Barra: combina o
611:     * PROCEDURE Valid (consulta SigOpEtq/SigCdPro/SigCdLin, atualiza
612:     * cursor_4c_InvH, decodifica a foto, limpa o campo para a proxima
613:     * leitura) com o PROCEDURE LostFocus separado do legado (devolve o foco
614:     * a grade). LASTKEY() = 27 reproduz o "If LastKey() # 27" do legado -
615:     * ESC cancela a leitura sem limpar o campo nem avancar.

*-- Linhas 631 a 649:
631:             TRY
632:                 THIS.this_oBusinessObject.ConsultarBarra(loc_nBarra)
633: 
634:                 *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1 / MessageBox(
635:                 *-- 'Favor reinicializar o processo !!!') / Return(.F.)" do
636:                 *-- legado. Sem RETURN aqui: regra CLAUDE.md #1 proibe RETURN
637:                 *-- dentro de TRY/CATCH - o early-exit vira flag.
638:                 IF THIS.this_oBusinessObject.this_lFalhaConexao
639:                     MostrarErro("Favor reinicializar o processo !!!", ;
640:                         "Falha na Conex" + CHR(227) + "o (TmpBar)")
641:                     loc_lProsseguir = .F.
642:                 ENDIF
643: 
644:                 IF loc_lProsseguir AND THIS.this_oBusinessObject.this_lBarraLocalizada
645:                     *-- O peso exibido e o da ETIQUETA (SigOpEtq.Pesos), e a
646:                     *-- consulta do produto logo abaixo ZERA this_nPeso (o
647:                     *-- legado faz igual: no Valid de Get_Produto o peso vai a
648:                     *-- 0). Guardar antes e repor depois mantem o
649:                     *-- "Get_Peso.Value = TmpBar.Pesos" do legado com UM unico

*-- Linhas 655 a 673:
655:                     *-- 'SigCdLin','TmpLinha',...) SEM NENHUM teste de
656:                     *-- resultado - o "Favor reinicializar o processo !!!
657:                     *-- (TmpPro)" so existe no Valid de Get_Produto, onde a
658:                     *-- consulta e um SqlExecute guardado por "< 1".
659:                     *-- Repetir a abortagem aqui seria INVENTAR regra: com a
660:                     *-- consulta do produto falhando, o legado segue adiante e
661:                     *-- ainda registra a barra lida na grade, e perder isso
662:                     *-- impediria a leitura de continuar.
663:                     THIS.this_oBusinessObject.ConsultarProduto( ;
664:                         THIS.this_oBusinessObject.this_cProduto)
665: 
666:                     THIS.this_oBusinessObject.this_nPeso = loc_nPeso
667:                     THIS.BOParaForm()
668:                 ENDIF
669: 
670:                 IF loc_lProsseguir
671:                     THIS.AtualizarCrInvHPorBarra(loc_nBarra)
672:                 ENDIF
673:             CATCH TO loc_oErro

*-- Linhas 775 a 793:
775:                     THIS.this_oBusinessObject.ConsultarProduto( ;
776:                         THIS.this_oBusinessObject.this_cProduto)
777: 
778:                     *-- "If ...SqlExecute(lStrQuery,'TmpPro') < 1 / MessageBox(
779:                     *-- 'Favor reinicializar o processo !!!') / Return(.F.)" do
780:                     *-- legado (flag em vez de RETURN - regra CLAUDE.md #1).
781:                     IF THIS.this_oBusinessObject.this_lFalhaConexao
782:                         MostrarErro("Favor reinicializar o processo !!!", ;
783:                             "Falha na Conex" + CHR(227) + "o (TmpPro)")
784:                         loc_lProsseguir = .F.
785:                     ENDIF
786: 
787:                     IF loc_lProsseguir AND THIS.this_oBusinessObject.this_lProdutoLocalizado
788:                         *-- ConsultarProduto deixa this_nPeso = 0, que e
789:                         *-- exatamente o "ThisForm.Get_Peso.Value = 0" do
790:                         *-- legado neste fluxo: o peso pertence a ETIQUETA, nao
791:                         *-- ao produto, e aqui nao houve leitura de barra.
792:                         THIS.BOParaForm()
793:                     ENDIF

*-- Linhas 846 a 864:
846:                 ENDIF
847: 
848:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
849:                     SELECT cursor_4c_BuscaProduto
850:                     THIS.txt_4c_Produto.Value   = ALLTRIM(cursor_4c_BuscaProduto.CPros)
851:                     THIS.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_BuscaProduto.DPros)
852:                 ELSE
853:                     THIS.txt_4c_Produto.Value   = ""
854:                     THIS.txt_4c_Descricao.Value = ""
855:                 ENDIF
856: 
857:                 IF USED("cursor_4c_BuscaProduto")
858:                     USE IN cursor_4c_BuscaProduto
859:                 ENDIF
860:                 loc_oBusca.Release()
861:             ENDIF
862:         CATCH TO loc_oErro
863:             MsgErro(loc_oErro.Message + CHR(13) + ;
864:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em AbrirBuscaProduto")

*-- Linhas 889 a 930:
889:         ENDIF
890: 
891:         IF FILE(loc_cArquivo)
892:             DELETE FILE (loc_cArquivo)
893:         ENDIF
894: 
895:         THIS.Refresh()
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * AtualizarCrInvHPorBarra - equivalente ao bloco final do Valid de
900:     * Get_Barra: garante que a barra lida esteja em cursor_4c_InvH, vinda de
901:     * cursor_4c_Historico (leituras anteriores desta sessao) ou, na
902:     * ausencia, do inventario em SigIvTrH (primeira leitura desta barra no
903:     * balanco ativo - CrSigCdBal e cursor GLOBAL do processo de balanco,
904:     * mantido pelo form pai).
905:     *--------------------------------------------------------------------------
906:     PROTECTED PROCEDURE AtualizarCrInvHPorBarra(par_nBarra)
907:         LOCAL loc_cEmpresa, loc_nCodBalanco, loc_nResultado
908: 
909:         THIS.DesvincularGrade()
910: 
911:         IF !SEEK(par_nBarra, "cursor_4c_InvH", "cbars")
912:             IF SEEK(par_nBarra, "cursor_4c_Historico", "cbars")
913:                 SELECT cursor_4c_Historico
914:                 SCATTER MEMVAR MEMO
915:                 INSERT INTO cursor_4c_InvH FROM MEMVAR
916:             ELSE
917:                 loc_cEmpresa    = ""
918:                 loc_nCodBalanco = 0
919:                 IF USED("crSigCdBal")
920:                     loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
921:                     loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)
922:                 ENDIF
923: 
924:                 loc_nResultado = THIS.this_oBusinessObject.ConsultarInventarioPorBarra( ;
925:                     loc_cEmpresa, loc_nCodBalanco, par_nBarra, "cursor_4c_InvHTmp")
926: 
927:                 IF loc_nResultado < 1
928:                     MostrarErro("Favor reinicializar o processo !!!", ;
929:                         "Falha na Conex" + CHR(227) + "o (CrInvH)")
930:                     IF USED("cursor_4c_InvHTmp")

*-- Linhas 941 a 1002:
941:                 IF USED("cursor_4c_InvH")
942:                     USE IN cursor_4c_InvH
943:                 ENDIF
944:                 SELECT * FROM cursor_4c_InvHTmp INTO CURSOR cursor_4c_InvH READWRITE
945:                 IF USED("cursor_4c_InvHTmp")
946:                     USE IN cursor_4c_InvHTmp
947:                 ENDIF
948: 
949:                 SELECT cursor_4c_InvH
950:                 INDEX ON cbars TAG cbars
951:                 INDEX ON cpros TAG cpros
952:                 GO TOP
953:             ENDIF
954:         ENDIF
955: 
956:         THIS.CarregarLista()
957:     ENDPROC
958: 
959:     *--------------------------------------------------------------------------
960:     * AtualizarCrInvHPorProduto - equivalente ao bloco final do Valid de
961:     * Get_Produto: garante que TODAS as leituras deste produto estejam em
962:     * cursor_4c_InvH (Scan sobre Historico filtrado por CPros - um produto
963:     * pode ter varias barras lidas), ou, na ausencia, consulta SigIvTrH.
964:     *--------------------------------------------------------------------------
965:     PROTECTED PROCEDURE AtualizarCrInvHPorProduto(par_cProduto)
966:         LOCAL loc_cEmpresa, loc_nCodBalanco, loc_nResultado, loc_cChave
967: 
968:         *-- SET EXACT ON (config.prg) faz o SEEK exigir a chave INTEIRA, e o
969:         *-- indice "cpros" eh char(14) (SigIvTrh.cpros) enquanto o chamador
970:         *-- passa o codigo TRIMADO - sem o PADR o SEEK falha SEMPRE e cada
971:         *-- LostFocus do campo Produto reinsere as mesmas leituras no cursor
972:         *-- da grade (linhas duplicadas). O WHERE do SELECT abaixo nao
973:         *-- precisa (SQL do VFP segue SET ANSI, que esta OFF).
974:         loc_cChave = PADR(ALLTRIM(par_cProduto), 14)
975: 
976:         THIS.DesvincularGrade()
977: 
978:         IF !SEEK(loc_cChave, "cursor_4c_InvH", "cpros")
979:             SELECT * FROM cursor_4c_Historico WHERE cpros = m.par_cProduto INTO CURSOR cursor_4c_TmpHistorico
980:             SELECT cursor_4c_TmpHistorico
981:             GO TOP
982: 
983:             IF !EOF()
984:                 SCAN
985:                     SCATTER MEMVAR MEMO
986:                     INSERT INTO cursor_4c_InvH FROM MEMVAR
987:                     SELECT cursor_4c_TmpHistorico
988:                 ENDSCAN
989:             ELSE
990:                 loc_cEmpresa    = ""
991:                 loc_nCodBalanco = 0
992:                 IF USED("crSigCdBal")
993:                     loc_cEmpresa    = TratarNulo(crSigCdBal.Emps, "")
994:                     loc_nCodBalanco = TratarNulo(crSigCdBal.Codigos, 0)
995:                 ENDIF
996: 
997:                 loc_nResultado = THIS.this_oBusinessObject.ConsultarInventarioPorProduto( ;
998:                     loc_cEmpresa, loc_nCodBalanco, par_cProduto, "cursor_4c_InvHTmp")
999: 
1000:                 IF loc_nResultado < 1
1001:                     MostrarErro("Favor reinicializar o processo !!!", ;
1002:                         "Falha na Conex" + CHR(227) + "o (CrInvH)")

*-- Linhas 1015 a 1128:
1015:                 IF USED("cursor_4c_InvH")
1016:                     USE IN cursor_4c_InvH
1017:                 ENDIF
1018:                 SELECT * FROM cursor_4c_InvHTmp INTO CURSOR cursor_4c_InvH READWRITE
1019:                 IF USED("cursor_4c_InvHTmp")
1020:                     USE IN cursor_4c_InvHTmp
1021:                 ENDIF
1022: 
1023:                 SELECT cursor_4c_InvH
1024:                 INDEX ON cbars TAG cbars
1025:                 INDEX ON cpros TAG cpros
1026:                 GO TOP
1027:             ENDIF
1028: 
1029:             IF USED("cursor_4c_TmpHistorico")
1030:                 USE IN cursor_4c_TmpHistorico
1031:             ENDIF
1032:         ENDIF
1033: 
1034:         THIS.CarregarLista()
1035:     ENDPROC
1036: 
1037:     *--------------------------------------------------------------------------
1038:     * ConfigurarCursorHistorico - "Historico" e cursor GLOBAL do processo de
1039:     * contagem/balanco de estoque (SigIvTrh), aberto pelo form PAI
1040:     * (THIS.this_oParentForm) ANTES de instanciar este dialogo - e o que o
1041:     * legado faz: "Select * From Historico Where .F. Into Cursor CrInvH
1042:     * ReadWrite" no Init clona a ESTRUTURA dele, nunca cria o cursor do zero.
1043:     * Fallback (modo teste/validacao de UI, sem form pai real): cria vazio
1044:     * com a estrutura de SigIvTrh e indexado, para o form instanciar sem
1045:     * erro mesmo fora do fluxo real de contagem.
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE ConfigurarCursorHistorico()
1048:         IF !USED("cursor_4c_Historico")
1049:             CREATE CURSOR cursor_4c_Historico ;
1050:                 (cbars N(14,0), cidchaves C(20), codcors C(4), codigos N(4,0), ;
1051:                  codtams C(4), contas C(10), cpros C(14), datas T, datatrans T, ;
1052:                  emps C(3), localis C(10), locals C(10), ntrans N(6,0), obs M, ;
1053:                  ocors C(10), pesreals N(8,2), qtds N(11,3), tipos N(1,0), ;
1054:                  usuars C(10), pesos N(12,3), coletas C(1))
1055:             SELECT cursor_4c_Historico
1056:             INDEX ON cbars TAG cbars
1057:             INDEX ON cpros TAG cpros
1058:             GO TOP
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * ConfigurarGrid - grd_4c_Dados (Grade do legado), com 5 colunas e a
1064:     * coluna Observacao usando EditBox (equivalente ao fwmemo1 do legado,
1065:     * regra CLAUDE.md #18 - Column.AddObject exige CurrentControl). O cursor
1066:     * cursor_4c_InvH (CrInvH) e clone VAZIO de cursor_4c_Historico - populado
1067:     * linha a linha nos Valid de Get_Barra/Get_Produto (Fase 6).
1068:     *--------------------------------------------------------------------------
1069:     PROTECTED PROCEDURE ConfigurarGrid()
1070:         IF USED("cursor_4c_InvH")
1071:             USE IN cursor_4c_InvH
1072:         ENDIF
1073:         SELECT * FROM cursor_4c_Historico WHERE .F. INTO CURSOR cursor_4c_InvH READWRITE
1074:         SELECT cursor_4c_InvH
1075:         INDEX ON cbars TAG cbars
1076:         INDEX ON cpros TAG cpros
1077:         GO TOP
1078: 
1079:         THIS.AddObject("grd_4c_Dados", "Grid")
1080:         WITH THIS.grd_4c_Dados
1081:             .Top               = 219
1082:             .Left              = 14
1083:             .Width             = 632
1084:             .Height            = 88
1085:             .ColumnCount       = 5
1086:             .FontName          = "Tahoma"
1087:             .FontSize          = 8
1088:             .AllowHeaderSizing = .F.
1089:             .AllowRowSizing    = .F.
1090:             .DeleteMark        = .F.
1091:             .RecordMark        = .F.
1092:             .ReadOnly          = .T.
1093:             .RowHeight         = 17
1094:             .ScrollBars        = 0
1095:             .GridLineColor     = RGB(238, 238, 238)
1096:         ENDWITH
1097: 
1098:         *-- O bind (RecordSource + ControlSource de cada Column) vem ANTES do
1099:         *-- AddObject do EditBox. Sem RecordSource explicito o Grid resolve a
1100:         *-- fonte pela AREA DE TRABALHO CORRENTE e auto-liga as 5 primeiras
1101:         *-- colunas do cursor na ordem do CREATE CURSOR - Column4 cai em
1102:         *-- "codigos N(4,0)". Acrescentar um EditBox (cujo .Value nasce
1103:         *-- CARACTERE) a uma coluna ligada a campo NUMERICO estoura
1104:         *-- "Error with EDT_4C_OBS - Value : Data type mismatch" dentro do
1105:         *-- TRY de InicializarForm: CREATEOBJECT devolve .F. e a tela NAO ABRE.
1106:         *-- Com o bind feito antes, Column4 ja esta em "cursor_4c_InvH.obs"
1107:         *-- (campo Memo) e o EditBox e compativel.
1108:         THIS.MontaGrade()
1109: 
1110:         WITH THIS.grd_4c_Dados.Column4
1111:             .AddObject("edt_4c_Obs", "EditBox")
1112:             *-- NUNCA definir .ControlSource no CONTROLE da coluna: quem
1113:             *-- manda e o ControlSource da Column (ja em "cursor_4c_InvH.obs"
1114:             *-- pelo MontaGrade acima). Duplicar aqui estoura "Parent object
1115:             *-- will not allow this property setting" e a tela nao abre
1116:             *-- (mesma regra do CheckBox em Column - erro 1767).
1117:             WITH .edt_4c_Obs
1118:                 .FontName    = "Tahoma"
1119:                 .FontSize    = 8
1120:                 .BorderStyle = 0
1121:                 .Left        = 7
1122:                 .Top         = 24
1123:                 .ReadOnly    = .T.
1124:             ENDWITH
1125:             *-- regra CLAUDE.md #18: sem CurrentControl a Column continua
1126:             *-- desenhando o Text1 dela; sem Sparse = .F. o EditBox so
1127:             *-- aparece na linha ativa.
1128:             .CurrentControl = "edt_4c_Obs"

*-- Linhas 1137 a 1167:
1137:     * grd_4c_Dados a cursor_4c_InvH. Chamado agora (bind inicial) e sera
1138:     * chamado de novo na Fase 6 depois de inserir linha nova no cursor.
1139:     * RecordSource reseta Width/Header1.Caption (CLAUDE.md "Grade perde
1140:     * cabecalhos apos RecordSource") - por isso ControlSource/Width/Header
1141:     * sao reaplicados NESTA ORDEM, sempre DEPOIS do RecordSource.
1142:     *--------------------------------------------------------------------------
1143:     PROTECTED PROCEDURE MontaGrade()
1144:         WITH THIS.grd_4c_Dados
1145:             .RecordSource = ""
1146:             .RecordSource = "cursor_4c_InvH"
1147: 
1148:             .Column1.ControlSource = "cursor_4c_InvH.cbars"
1149:             .Column2.ControlSource = "cursor_4c_InvH.localis"
1150:             .Column3.ControlSource = "cursor_4c_InvH.ocors"
1151:             .Column4.ControlSource = "cursor_4c_InvH.obs"
1152:             .Column5.ControlSource = "cursor_4c_InvH.pesreals"
1153: 
1154:             .Column1.ReadOnly  = .T.
1155:             .Column1.Movable   = .F.
1156:             .Column1.Resizable = .T.
1157:             .Column2.ReadOnly  = .T.
1158:             .Column3.ReadOnly  = .T.
1159:             .Column4.ReadOnly  = .T.
1160:             .Column4.Sparse    = .F.
1161:             .Column5.ReadOnly  = .T.
1162:             .Column5.InputMask = "9999.99"
1163: 
1164:             *-- RecordSource reseta CurrentControl (volta a "Text1"), entao o
1165:             *-- EditBox da coluna Observacao tem de ser REARMADO a cada
1166:             *-- rebind. PEMSTATUS porque a 1a chamada vem de ConfigurarGrid,
1167:             *-- ANTES de o EditBox existir (e ela que faz o bind inicial).

*-- Linhas 1214 a 1262:
1214:     *--------------------------------------------------------------------------
1215:     * CarregarLista - FUNIL unico de carga/repintura da grade. Transcreve o
1216:     * rodape IDENTICO dos dois Valid do legado:
1217:     *   Select CrInvH
1218:     *   Update CrInvH Set Obs = Nvl(Obs,'')
1219:     *   ThisForm.AcertaGrade()
1220:     *   Select CrInvH
1221:     *   Go Top
1222:     *
1223:     * Popular o cursor NAO repinta a grade (regra CLAUDE.md #21a): sem o
1224:     * GO TOP + Refresh no fim de TODO caminho que mexe no cursor, a grade fica
1225:     * visualmente vazia com o cursor cheio - e o sintoma ("a tela nao traz
1226:     * dados") manda o diagnostico para SQL/permissao. Por isso aqui, e nao
1227:     * copiado em cada chamador: os caminhos que mexem no cursor sao a leitura
1228:     * de barra, a consulta por produto, a exclusao de item e a abertura.
1229:     *
1230:     * O UPDATE do Obs vem junto porque e' a MESMA linha do legado: a coluna
1231:     * obs de SigIvTrh e "text NULL", e o EditBox da coluna Observacao da grade
1232:     * nao aceita .NULL. - trocar por string vazia e o que o legado faz.
1233:     *
1234:     * Devolve .T./.F. (houve cursor para carregar) - o chamador nao e obrigado
1235:     * a testar, mas o retorno existe para o teste automatizado.
1236:     *--------------------------------------------------------------------------
1237:     PROCEDURE CarregarLista()
1238:         LOCAL loc_lSucesso
1239:         loc_lSucesso = .F.
1240: 
1241:         IF USED("cursor_4c_InvH")
1242:             SELECT cursor_4c_InvH
1243:             UPDATE cursor_4c_InvH SET obs = NVL(obs, "")
1244: 
1245:             THIS.MontaGrade()
1246: 
1247:             SELECT cursor_4c_InvH
1248:             GO TOP
1249: 
1250:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1251:                 THIS.grd_4c_Dados.Refresh()
1252:             ENDIF
1253: 
1254:             loc_lSucesso = .T.
1255:         ENDIF
1256: 
1257:         RETURN loc_lSucesso
1258:     ENDPROC
1259: 
1260:     *--------------------------------------------------------------------------
1261:     * FormParaBO - transfere os dois campos de ENTRADA da tela para as
1262:     * properties do BO. Sao os dois unicos campos digitaveis do SCX: Get_Barra

*-- Linhas 1467 a 1538:
1467:         *-- INSERE uma copia duplicada no cursor GLOBAL Historico (que o form
1468:         *-- pai continua usando depois deste dialogo fechar). PADR para a
1469:         *-- largura da coluna reproduz o match que o legado tinha com
1470:         *-- EXACT OFF. O WHERE do DELETE abaixo nao precisa (SQL do VFP segue
1471:         *-- SET ANSI, que esta OFF), mas usa o mesmo valor por coerencia.
1472:         loc_cProduto = PADR(ALLTRIM(THIS.txt_4c_Produto.Value), 14)
1473: 
1474:         SELECT cursor_4c_InvH
1475: 
1476:         DO CASE
1477:             CASE EMPTY(THIS.txt_4c_Barra.Value) AND !EMPTY(THIS.txt_4c_Produto.Value)
1478:                 SELECT cursor_4c_Historico
1479:                 IF !SEEK(loc_cProduto, "cursor_4c_Historico", "cpros")
1480:                     SELECT cursor_4c_InvH
1481:                     SCATTER MEMVAR MEMO
1482:                     INSERT INTO cursor_4c_Historico FROM MEMVAR
1483:                 ENDIF
1484:                 SELECT cursor_4c_Historico
1485:                 GO TOP
1486:                 DELETE FROM cursor_4c_Historico WHERE cpros = m.loc_cProduto
1487:                 SELECT cursor_4c_Historico
1488:                 GO TOP
1489:                 SELECT cursor_4c_InvH
1490:                 DELETE FROM cursor_4c_InvH
1491: 
1492:             CASE !EMPTY(THIS.txt_4c_Barra.Value)
1493:                 IF !SEEK(cursor_4c_InvH.cbars, "cursor_4c_Historico", "cbars")
1494:                     SELECT cursor_4c_InvH
1495:                     SCATTER MEMVAR MEMO
1496:                     INSERT INTO cursor_4c_Historico FROM MEMVAR
1497:                 ENDIF
1498:                 SELECT cursor_4c_Historico
1499:                 loc_nRecno = RECNO("cursor_4c_Historico")
1500:                 GO TOP
1501:                 GO loc_nRecno
1502:                 DELETE IN cursor_4c_Historico
1503:                 SELECT cursor_4c_InvH
1504:                 DELETE IN cursor_4c_InvH
1505: 
1506:             OTHERWISE
1507:                 THIS.grd_4c_Dados.SetFocus()
1508:                 THIS.grd_4c_Dados.Refresh()
1509:                 THIS.Refresh()
1510:                 *-- txt_4c_Barra nasce NUMERICO (.Value = 0, transcrito do
1511:                 *-- dump: "Get_Barra / Value = 0 / InputMask =
1512:                 *-- 99999999999999"). O legado limpa com '' e por isso o
1513:                 *-- controle dele VIRA caractere no meio da sessao - aqui nao
1514:                 *-- da para copiar isso: cbars eh numeric(14,0) e o
1515:                 *-- AtualizarCrInvHPorBarra faz SEEK nesse indice, que estoura
1516:                 *-- "Operator/operand type mismatch" com chave caractere.
1517:                 *-- Zerar mantem o tipo e o mesmo EMPTY() do legado.
1518:                 THIS.txt_4c_Barra.Value = 0
1519:                 THIS.txt_4c_Barra.SetFocus()
1520:                 RETURN
1521:         ENDCASE
1522: 
1523:         SELECT cursor_4c_InvH
1524:         GO BOTTOM
1525:         THIS.grd_4c_Dados.SetFocus()
1526:         THIS.grd_4c_Dados.Refresh()
1527:         THIS.Refresh()
1528:         *-- mesma razao do bloco OTHERWISE: zerar, nunca "" (tipo NUMERICO)
1529:         THIS.txt_4c_Barra.Value = 0
1530:         *-- Barra zerado reabre o campo Produto (When do legado)
1531:         THIS.HabilitarCampos()
1532: 
1533:         IF EOF("cursor_4c_InvH")
1534:             *-- grade vazia: o legado esconde o botao de excluir e volta o
1535:             *-- quadro de consulta, INDEPENDENTE do modo - por isso as tres
1536:             *-- linhas literais aqui, e nao AjustarBotoesPorModo() (que
1537:             *-- reporia Visible = this_lExcluir e traria o botao de volta
1538:             *-- sobre uma grade sem nenhuma linha para excluir).

*-- Linhas 1549 a 1567:
1549:     *--------------------------------------------------------------------------
1550:     PROCEDURE CmdSaidaClick()
1551:         IF USED("cursor_4c_Historico")
1552:             SELECT cursor_4c_Historico
1553:             SET ORDER TO
1554:             GO BOTTOM
1555:         ENDIF
1556:         THIS.Release()
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
1561:     * labels de titulo sobrepostos (sombra preta + titulo branco).
1562:     * Geometria TRANSCRITA do dump: SIGOPCIM.cntSombra/lblSombra/lblTitulo.
1563:     *--------------------------------------------------------------------------
1564:     PROTECTED PROCEDURE ConfigurarCabecalho()
1565:         THIS.AddObject("cnt_4c_Sombra", "Container")
1566:         WITH THIS.cnt_4c_Sombra
1567:             .Top         = 0


### BO (C:\4c\projeto\app\classes\sigopcimBO.prg):
*==============================================================================
* sigopcimBO.prg - Business Object para Consulta/Exclusao de Imagem (Leitura de Barras)
* Tabela principal: Historico (cursor local de leitura de codigos de barras)
* Cursor de grade: CrInvH (Barras/Local/Ocorrencia/Observacao/Peso Real)
* Form original: SIGOPCIM.scx (Consulta Imagem / Exclusao de Barras)
*==============================================================================

DEFINE CLASS sigopcimBO AS BusinessBase

    *-- Codigo de barras lido/digitado (Get_Barra). NUMERICO: medido no
    *-- docs/schema.sql, SigOpEtq.cbars e SigIvTrh.cbars sao numeric(14,0), e o
    *-- proprio SCX declara "Get_Barra / Value = 0 / InputMask =
    *-- 99999999999999" - ou seja a tela tambem digita numero. Guardar como
    *-- char obrigaria a converter nos dois sentidos (STR na ida, VAL na volta)
    *-- numa chave de 14 digitos, e qualquer SEEK no indice "cbars" (que e
    *-- numerico) com chave caractere estoura "Operator/operand type
    *-- mismatch" - a MESMA armadilha que a Fase 7 corrigiu no TextBox.
    this_nBarra      = 0     && numeric(14,0)  SigOpEtq.cbars / SigIvTrh.cbars

    *-- Produto associado a barra (Get_Produto) - FK SigCdPro.CPros
    this_cProduto    = ""    && char(20)  Codigo do Produto (FK SigCdPro.CPros)

    *-- Descricao do produto (Get_Descricao) - somente exibicao, vem do lookup
    this_cDescricao  = ""    && char(60)  Descricao do Produto (FK SigCdPro.DPros)

    *-- Peso medio/real associado a barra (Get_Peso)
    this_nPeso       = 0     && numeric(10,3)  Peso do item

    *-- Linha de producao associada a barra (Get_Linha)
    this_cLinha      = ""    && char(40)  Linha / observacao associada ao item

    *-- Colunas do registro de Historico/CrInvH (cursor_4c_Dados da grade)
    this_cLocal        = ""    && char(10)  Historico.Localis - local da leitura
    this_cOcorrencia   = ""    && char(10)  Historico.Ocors   - ocorrencia do item
    this_mObs          = ""    && memo      Historico.Obs     - observacao do item
    this_nPesoReal     = 0     && numeric(8,2) Historico.PesReals - peso real lido

    *-- Foto do produto (SigCdPro.FigJpgs), usada so para gerar o arquivo .jpg
    *-- temporario exibido em ImgJpg - nunca persistida pelo BO.
    this_mFigJpgs      = ""

    *-- Flags de resultado das consultas (Valid de Get_Barra/Get_Produto)
    this_lBarraLocalizada    = .F.   && .T. quando SigOpEtq achou o CBars
    this_lProdutoLocalizado  = .F.   && .T. quando SigCdPro achou o CPros

    *-- .T. quando o SQLEXEC da consulta falhou (equivalente ao
    *-- "If ...SqlExecute(lStrQuery,'TmpBar') < 1" do legado, que exibe
    *-- "Favor reinicializar o processo !!!" e ABORTA o Valid com Return(.F.)).
    *-- Nao da para sinalizar isso pelo retorno da funcao: ela ja devolve .T.
    *-- tambem quando a consulta roda e nao acha nada, que NAO e erro (regra
    *-- CLAUDE.md #50 - universo vazio nao e erro). Zero linha e falha de
    *-- conexao sao resultados DIFERENTES e o legado os trata diferente.
    this_lFalhaConexao       = .F.   && .T. quando SQLEXEC devolveu < 1

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "Historico"
        THIS.this_cCampoChave = "CBars"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - CBars (Historico/CrInvH.CBars) e a chave logica do
    * item de leitura; na ausencia de barra (modo so-por-produto), a chave
    * passa a ser o codigo do produto (CPros), igual ao Case do Excluiitem.Click
    * legado (Empty(Get_Barra.Value) And !Empty(Get_Produto.Value)).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        *-- A chave da auditoria e CARACTERE (RegistrarAuditoria a concatena na
        *-- string do INSERT), por isso o STR aqui - a property segue numerica.
        IF THIS.this_nBarra != 0
            RETURN ALLTRIM(STR(THIS.this_nBarra, 14))
        ENDIF
        RETURN ALLTRIM(THIS.this_cProduto)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia uma linha de Historico/CrInvH (par_cAliasCursor)
    * para as properties do BO. E o shape da grade (Barras/Local/Ocorrencia/
    * Observacao/Peso Real), nao o shape dos lookups de Barra/Produto - esses
    * tem metodo proprio (ConsultarBarra/ConsultarProduto) porque vem de
    * tabelas diferentes (SigOpEtq/SigCdPro) com colunas diferentes.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * CBars e numeric(14,0) no schema e a property e numerica (ver
    * this_nBarra) - nada de converter para char no caminho.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nBarra      = TratarNulo(cbars, 0)
                THIS.this_cProduto    = TratarNulo(cpros, "")
                THIS.this_cLocal      = TratarNulo(localis, "")
                THIS.this_cOcorrencia = TratarNulo(ocors, "")
                THIS.this_mObs        = TratarNulo(obs, "")
                THIS.this_nPesoReal   = TratarNulo(pesreals, 0)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarBarra - replica o 1o SQLEXEC do Valid de Get_Barra: busca a
    * etiqueta em SigOpEtq pelo codigo de barras. Achando, preenche o Produto
    * e o Peso que a tela espelha; sem achar, so desliga o flag de localizacao
    * (o legado, nesse caso, simplesmente nao atualiza os campos - regra
    * CLAUDE.md #50, universo vazio nao e erro).
    *==========================================================================
    FUNCTION ConsultarBarra(par_nCbars)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lBarraLocalizada = .F.
        THIS.this_lFalhaConexao    = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT CBars, CPros, Pesos FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_CimEtq")

                *-- mesmo criterio do legado ("SqlExecute(...) < 1"). A
                *-- atribuicao fica DENTRO da guarda de conexao: sem handle o
                *-- loc_nResultado nunca e atribuido (nasce .F. logico) e
                *-- compara-lo com 1 estouraria "Operator/operand type
                *-- mismatch" justamente em modo teste/validacao de UI.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimEtq") AND RECCOUNT("cursor_4c_CimEtq") > 0
                    SELECT cursor_4c_CimEtq
                    GO TOP

                    THIS.this_lBarraLocalizada = .T.
                    THIS.this_nBarra   = TratarNulo(CBars, 0)
                    THIS.this_cProduto = TratarNulo(CPros, "")
                    THIS.this_nPeso    = TratarNulo(Pesos, 0)
                ENDIF

                IF USED("cursor_4c_CimEtq")
                    USE IN cursor_4c_CimEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarProduto - replica o SQLEXEC do Valid de Get_Produto: busca o
    * produto em SigCdPro, com a descricao da linha via Left Join SigCdLin
    * (mesma consulta do legado: a.CPros,a.Linhas,a.FigJpgs,b.Descs). Achando,
    * preenche Linha (Descs) e a foto (FigJpgs, para DecodificarEGravarFoto);
    * Peso fica zerado, igual ao legado (ThisForm.Get_Peso.Value = 0).
    *
    * this_cDescricao (a.DPros) tambem e preenchido aqui - e o mesmo SigCdPro
    * que o fluxo de Get_Barra.Valid consulta (lcConsulta = CursorQuery(
    * 'SigCdPro','TmpPro','CPros',...,'CPros,DPros,Linhas,FigJpgs')), so que
    * o legado faz isso em DUAS CursorQuery separadas (SigCdPro + SigCdLin);
    * aqui as duas foram unificadas num LEFT JOIN so. O Form (fluxo de
    * Get_Produto) e quem decide SE usa this_cDescricao - o legado nunca
    * atualiza Get_Descricao.Value no Valid de Get_Produto, so no de
    * Get_Barra.
    *==========================================================================
    FUNCTION ConsultarProduto(par_cCodProduto)
        LOCAL loc_lSucesso, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_lProdutoLocalizado = .F.
        THIS.this_lFalhaConexao      = .F.

        *-- Limpa o que esta consulta PRODUZ, antes de consultar. Nao e zelo:
        *-- no fluxo da BARRA o legado le TmpPro/TmpLinha SEM guarda de EOF
        *-- ("Get_Produto.Value = TmpPro.CPros / Get_Descricao.Value =
        *-- TmpPro.DPros / ..."), ou seja com o produto AUSENTE ele atribui o
        *-- valor vazio do cursor e a tela LIMPA. Sem este reset as properties
        *-- guardariam o resultado da leitura ANTERIOR, e o usuario veria a
        *-- descricao e a FOTO do produto antigo associadas a barra nova -
        *-- divergencia silenciosa, sem erro nenhum.
        THIS.this_cProduto   = ""
        THIS.this_cDescricao = ""
        THIS.this_nPeso      = 0
        THIS.this_cLinha     = ""
        THIS.this_mFigJpgs   = ""

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT a.CPros, a.DPros, a.Linhas, a.FigJpgs, b.Descs " + ;
                    "FROM SigCdPro a LEFT JOIN SigCdLin b ON b.Linhas = a.Linhas " + ;
                    "WHERE a.CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    "cursor_4c_CimPro")

                *-- mesmo criterio do legado ("SqlExecute(...,'TmpPro') < 1");
                *-- DENTRO da guarda de conexao pelo mesmo motivo de
                *-- ConsultarBarra.
                THIS.this_lFalhaConexao = (loc_nResultado < 1)

                IF loc_nResultado >= 0 AND USED("cursor_4c_CimPro") AND RECCOUNT("cursor_4c_CimPro") > 0
                    SELECT cursor_4c_CimPro
                    GO TOP

                    THIS.this_lProdutoLocalizado = .T.
                    THIS.this_cProduto   = TratarNulo(CPros, "")
                    THIS.this_cDescricao = TratarNulo(DPros, "")
                    THIS.this_nPeso      = 0
                    THIS.this_cLinha     = TratarNulo(Descs, "")
                    THIS.this_mFigJpgs   = TratarNulo(FigJpgs, "")
                ENDIF

                IF USED("cursor_4c_CimPro")
                    USE IN cursor_4c_CimPro
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorBarra - replica o fallback de SigIvTrH do Valid de
    * Get_Barra, usado quando o item nao esta em CrInvH nem em Historico:
    * Select * From SigIvTrH Where Emps = <emp> And Codigos = <balanco> And
    * CBars = <barra>. par_cCursorDestino recebe o resultado (0 ou 1 linha);
    * quem monta Emps/Codigos e o Form, a partir do cursor global do balanco
    * ativo (CrSigCdBal no legado) - este BO nao conhece esse cursor.
    *==========================================================================
    FUNCTION ConsultarInventarioPorBarra(par_cEmpresa, par_nCodigoBalanco, par_nCbars, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * ConsultarInventarioPorProduto - mesmo fallback do ConsultarInventarioPor
    * Barra, mas pelo CPros (Valid de Get_Produto quando !Seek(This.Value,
    * 'CrInvH','CPros')).
    *==========================================================================
    FUNCTION ConsultarInventarioPorProduto(par_cEmpresa, par_nCodigoBalanco, par_cCodProduto, par_cCursorDestino)
        LOCAL loc_nResultado

        loc_nResultado = -1

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigIvTrH WHERE Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                    " AND Codigos = " + FormatarNumeroSQL(par_nCodigoBalanco, 0) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(par_cCodProduto)), ;
                    par_cCursorDestino)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDFUNC

    *==========================================================================
    * DecodificarEGravarFoto - replica a decodificacao da foto do produto (bloco
    * dentro do With ThisForm do Valid de Get_Barra/Get_Produto): remove os tres
    * prefixos "data:image/..." e decodifica o Base64 restante UMA UNICA VEZ
    * (Strconv(...,14) - decodificar duas vezes corrompe o JPEG, o binario
    * resultante nao e base64). Grava o JPEG binario direto em par_cCaminho
    * Destino; quem exibe (Image.Picture) e apaga o arquivo depois e o Form.
    *==========================================================================
    FUNCTION DecodificarEGravarFoto(par_mFigJpgs, par_cCaminhoDestino)
        LOCAL loc_cFoto, loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_mFigJpgs) AND !ISNULL(par_mFigJpgs)
            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(par_mFigJpgs, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            IF STRTOFILE(loc_cFoto, par_cCaminhoDestino) > 0
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito. O
    * SIGOPCIM legado nunca grava em tabela SQL Server nenhuma: as unicas
    * escritas do form (Excluiitem.Click) sao Insert/Delete em cursores VFP
    * locais (Historico/CrInvH), que o Form ja recebe abertos do ParentForm -
    * nao ha chave SQL para gravar nem auditoria de banco para registrar.
    * O comportamento padrao herdado de BusinessBase (recusar a operacao com
    * mensagem) ja e o correto para esta entidade.
    *==========================================================================

ENDDEFINE

