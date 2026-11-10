# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'INFOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, VALOR
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CHEQUES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, VALOR
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, VALOR
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, VALOR

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
  Column1.ControlSource = "csCheques.FPags"
  Column2.ControlSource = "csCheques.Bancos"
  Column3.ControlSource = "csCheques.Agencias"
  Column4.ControlSource = "csCheques.NContas"
  Column5.ControlSource = "csCheques.Cheques"
Select crSigOpFp
	  	Select crAutoriza
			Insert Into csCheques (FPags, Bancos, Agencias, NContas, Cheques) Values ;
			Insert Into csCheques (FPags, Bancos, Agencias, NContas, Cheques) Values ;
	Select crSigOpFp
Select csCheques
	Select csCheques
Select csCheques
		SELECT crAutoriza
			Insert Into crAutoriza (Valor, Conteudo) Values (lcChave, csCheques.Cheques-1)
	Select csCheques
SELECT crAutoriza
		m.lnErro1 = Iif(.poDataMgr.UpDate('crAutoriza'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpNch.prg) - TRECHOS RELEVANTES PARA PASS SQL (1534 linhas total):

*-- Linhas 84 a 102:
84: *       grava eh o Confirmar, ja entregue como BtnConfirmarClick
85: *
86: * poDataMgr do legado (CreateObject('fSqlConector',...) + AddCursor/Requery/
87: * UpDate/Commit/RollBack) NAO tem equivalente aqui de proposito (PILAR 3): o
88: * acesso a dados mora no SigOpNchBO / DataAccess.
89: *==============================================================================
90: 
91: DEFINE CLASS FormSigOpNch AS FormBase
92: 
93:     *--------------------------------------------------------------------------
94:     * Propriedades visuais TRANSCRITAS do dump (SECAO 2, "PROPRIEDADES DE:
95:     * SIGOPNCH"). Caption fica no Init porque leva acento e esta classe nao
96:     * pode ter literal acentuado (regra #4).
97:     *--------------------------------------------------------------------------
98:     this_cMensagemErro = ""
99:     Height       = 370
100:     Width        = 800
101:     AutoCenter   = .T.
102:     BorderStyle  = 2

*-- Linhas 223 a 241:
223:     * irrecuperavel, porque o metodo que escreve a propriedade nunca rodaria
224:     * durante a validacao. O bypass de SQL/rede fica onde o SQL esta - aqui,
225:     * nesta fase, nada depende de rede: o cabecalho eh AddObject puro e o
226:     * cursor da grade eh CREATE CURSOR local.
227:     *
228:     * O RETURN da guarda fica FORA de qualquer TRY (regra #1).
229:     *--------------------------------------------------------------------------
230:     PROTECTED PROCEDURE InicializarForm()
231:         LOCAL loc_lSucesso, loc_oErro
232:         loc_lSucesso = .F.
233: 
234:         IF !THIS.ValidarParametros()
235:             RETURN .F.
236:         ENDIF
237: 
238:         TRY
239:             *-- Equivalente a Thisform.nAntChqVal = 0 do Init legado
240:             THIS.this_nAntChqVal = 0
241: 

*-- Linhas 262 a 287:
262: 
263:                 *-- Equivalente ao PROCEDURE Load legado, que roda ANTES do
264:                 *-- Init e cria o cursor da grade:
265:                 *--   Create Cursor csCheques (FPags C(12), Bancos C(3),
266:                 *--       Agencias C(4), NContas C(10), Cheques N(6),
267:                 *--       Marcas L(1))
268:                 *--   Index On Fpags Tag FPags
269:                 *-- Mora no BO (SigOpNchBO.CriarCursorCheques, que transcreve
270:                 *-- essa estrutura campo a campo) e eh criado JA NESTA FASE
271:                 *-- porque a grade da fase seguinte liga ControlSource nele -
272:                 *-- e ControlSource de cursor inexistente derruba o Init
273:                 *-- inteiro com "Alias not found" (regra #41).
274:                 *--
275:                 *-- A outra metade do Load legado, =fConfigGeral(), nao se
276:                 *-- reproduz: na arquitetura nova a configuracao global ja
277:                 *-- aconteceu em config.prg/main.prg, e utils\fconfiggeral.prg
278:                 *-- eh um no-op que existe APENAS para o p-code dos VCX legado.
279:                 IF !THIS.this_oBusinessObject.CriarCursorCheques()
280:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
281:                             "vel preparar a grade de cheques.", ;
282:                             "Erro em InicializarForm")
283:                 ELSE
284:                     *-- Ordem dos AddObject = ordem dos objetos no dump
285:                     *-- (cntSombra -> Shape1 -> Grade -> btnAlterar ->
286:                     *-- btnCancelar). Nao eh estetica, sao duas regras de
287:                     *-- z-order: Shape1 eh BackStyle = 0 / BorderStyle = 0,

*-- Linhas 485 a 542:
485:     * FontSize = 8. As cinco larguras do dump (123 + 35 + 55 + 80 + 105)
486:     * somam 398 e cabem nos 434 do grid.
487:     *
488:     * SO a estrutura visual: RecordSource/ControlSource ficam em
489:     * CarregarGrade, unico ponto de vinculo. Nao eh preferencia de
490:     * organizacao - mexer em RecordSource RECRIA os objetos Column e devolve
491:     * Width ao default 90, zera Header1.Caption e faz o ReadOnly da coluna
492:     * voltar a herdar o do Grid (Problema 48 do FormCor), entao o que fosse
493:     * ligado aqui se perderia na primeira carga.
494:     *
495:     * O .ReadOnly do GRID vem ANTES do das colunas: o do grid PROPAGA e
496:     * sobrescreveria o delas. .F. aqui porque a Column5 (proximo cheque) eh
497:     * editavel no legado; as outras quatro recebem .ReadOnly = .T., que eh
498:     * como o dump as declara.
499:     *
500:     * Essas quatro trazem a MESMA intencao dita duas vezes no legado:
501:     * Column.ReadOnly = .T. no dump E um When devolvendo .f. no Text1.
502:     * Reproduzida pelo ReadOnly da coluna e do Text1 - nao ha metodo When a
503:     * portar, porque ele nao faz nada alem de recusar o foco.
504:     *
505:     * DeleteMark/RecordMark = .F. sao obrigatorios em grade de form
506:     * OPERACIONAL (sem eles aparecem as barras de marcacao na lateral
507:     * esquerda, que o legado nao tem). As cores e o HighlightStyle vem da
508:     * classe fwgrade, que NAO existe nesta arquitetura: aqui o objeto eh um
509:     * Grid puro, logo o que a classe dava de graca tem de ser escrito
510:     * (valores em docs/framework_frmcadastro_layout.md). Ja o FontName
511:     * "Tahoma" do dump PREVALECE sobre o "Verdana" canonico - eh override
512:     * explicito do proprio SCX.
513:     *--------------------------------------------------------------------------
514:     PROTECTED PROCEDURE ConfigurarGrade()
515:         THIS.AddObject("grd_4c_Dados", "Grid")
516: 
517:         WITH THIS.grd_4c_Dados
518:             .Top                = 104
519:             .Left               = 183
520:             .Width              = 434
521:             .Height             = 238
522:             .ColumnCount        = 5
523:             .FontName           = "Tahoma"
524:             .FontSize           = 8
525:             .RowHeight          = 16
526:             .ScrollBars         = 2
527:             .DeleteMark         = .F.
528:             .RecordMark         = .F.
529:             .BackColor          = RGB(255, 255, 255)
530:             .ForeColor          = RGB(90, 90, 90)
531:             .GridLineColor      = RGB(238, 238, 238)
532:             .HighlightStyle     = 2
533:             .HighlightBackColor = RGB(255, 255, 255)
534:             .HighlightForeColor = RGB(15, 41, 104)
535:             *-- ANTES das colunas: Grid.ReadOnly propaga para elas
536:             .ReadOnly           = .F.
537:         ENDWITH
538: 
539:         *-- Column1 "Forma de Pagamento" (csCheques.FPags -> SigOpFp.fpags,
540:         *-- char(12)) - travada no legado
541:         WITH THIS.grd_4c_Dados.Column1
542:             .Width     = 123

*-- Linhas 724 a 742:
724:     *
725:     * NOME PELA ACAO, nunca pelo Name do objeto legado. O SCX chama o primeiro
726:     * botao de "btnAlterar", mas o Caption que o usuario le eh "\<Confirmar" e
727:     * o corpo do Click GRAVA (UpDate + Commit em crAutoriza) e encerra a tela:
728:     * o Name legado MENTE, igual ao "btnSair" que gravava no SIGMVVDE. Por
729:     * isso os objetos sao cmd_4c_Confirmar / cmd_4c_Encerrar e os handlers
730:     * BtnConfirmarClick / BtnEncerrarClick - herdar o nome do legado violaria
731:     * o PILAR 3 (nomes do migrado obrigatoriamente diferentes) e esconderia de
732:     * quem le que este botao eh o UNICO ponto de gravacao da tela.
733:     *
734:     * E ele nao eh o "Alterar" da barra CRUD do frmcadastro: aquele troca o
735:     * form para o modo de edicao, este COMMITA e fecha. Esta tela nao tem modo
736:     * (o dump nao tem pcEscolha), nao tem par de paginas Lista/Dados e nao tem
737:     * irmao Incluir/Visualizar/Excluir algum.
738:     *
739:     * BINDEVENT so AGORA, com os dois handlers ja escritos mais abaixo: bind
740:     * apontando para metodo inexistente estoura no PROPRIO BINDEVENT, dentro
741:     * do Init, e a tela nao abriria. Os handlers sao PUBLIC (sem PROTECTED) -
742:     * com metodo PROTECTED o BINDEVENT falha em SILENCIO (regra #3).

*-- Linhas 802 a 850:
802:     * trecho final do Init legado:
803:     *
804:     *   (o Scan que monta csCheques - hoje SigOpNchBO.CarregarDados)
805:     *   Select csCheques
806:     *   Go Top
807:     *   With ThisForm.Grade
808:     *       .Refresh
809:     *       .Column5.SetFocus
810:     *   EndWith
811:     *
812:     * Ordem OBRIGATORIA: RecordSource -> ControlSource -> Width ->
813:     * Header1.Caption -> ReadOnly da coluna. Mexer em RecordSource RECRIA os
814:     * objetos Column: a Width volta ao default 90, o Header1.Caption eh
815:     * zerado e o ReadOnly da coluna volta a herdar o do Grid - por isso os
816:     * tres sao reaplicados AQUI, e nao apenas em ConfigurarGrade
817:     * (Problema 48 do FormCor). O InputMask da coluna editavel entra na
818:     * mesma lista por ser FUNCIONAL: perdido, o campo passaria a aceitar
819:     * mais de 6 digitos (regra #49).
820:     *
821:     * RecordSource fica FORA do WITH do grid: dentro do MESMO WITH que
822:     * acabou de atribui-lo, acessar .Column1 estoura "Unknown member
823:     * COLUMN1", porque os objetos acabaram de ser recriados.
824:     *
825:     * O SetFocus do legado NAO vem para ca: InicializarForm roda ANTES do
826:     * Show e o VFP recusa foco em controle de form que ainda nao apareceu.
827:     * Ele mora no Activate, guardado por this_lFocoInicialDado.
828:     *
829:     * PUBLIC de proposito (regras #3/#51): o harness de teste chama
830:     * CarregarLista/CarregarGrade de FORA da classe, e PEMSTATUS(...,5)
831:     * devolve .T. tambem para metodo PROTECTED - o teste entraria no branch
832:     * e a chamada falharia em runtime.
833:     *
834:     * Bypass de SQL em modo teste/ValidarUIFidelity: CarregarDados do BO faz
835:     * SQLEXEC em SigOpFp/SigSySeq, inalcancavel em instanciacao headless. A
836:     * grade fica com a estrutura montada e LIGADA ao cursor vazio que
837:     * InicializarForm criou - basta para a validacao de UI, e em nenhum
838:     * cenario a grade fica sem RecordSource (grade sem RecordSource vira um
839:     * retangulo branco, sem cabecalho e sem coluna).
840:     *--------------------------------------------------------------------------
841:     PROCEDURE CarregarGrade()
842:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_cCursor, loc_oErro
843: 
844:         loc_lSucesso = .F.
845: 
846:         TRY
847:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
848:                                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
849: 
850:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

*-- Linhas 862 a 884:
862:                 *-- reproduz a MESMA estrutura campo a campo
863:                 *-- (SigOpNchBO.CriarCursorCheques)
864:                 WITH THIS.grd_4c_Dados
865:                     .Column1.ControlSource = loc_cCursor + ".FPags"
866:                     .Column2.ControlSource = loc_cCursor + ".Bancos"
867:                     .Column3.ControlSource = loc_cCursor + ".Agencias"
868:                     .Column4.ControlSource = loc_cCursor + ".NContas"
869:                     .Column5.ControlSource = loc_cCursor + ".Cheques"
870:                 ENDWITH
871: 
872:                 *-- Marcas (L(1), 6o campo do cursor) NAO ganha coluna: o
873:                 *-- legado tem ColumnCount = 5 e usa Marcas apenas como flag
874:                 *-- interna de "linha tocada pelo usuario", lida pelo
875:                 *-- Confirmar. Uma 6a coluna exporia na tela um controle que
876:                 *-- o legado nao tem.
877: 
878:                 WITH THIS.grd_4c_Dados
879:                     .Column1.Width = 123
880:                     .Column2.Width = 35
881:                     .Column3.Width = 55
882:                     .Column4.Width = 80
883:                     .Column5.Width = 105
884: 

*-- Linhas 912 a 934:
912:                 *-- so no InicializarForm).
913:                 THIS.InstalarCelulaCheque(THIS.grd_4c_Dados)
914: 
915:                 *-- Legado: "Select csCheques / Go Top" ANTES do
916:                 *-- "Grade.Refresh" - popular o cursor nao repinta a grade
917:                 *-- sozinho (regra #21a), e sem o Go Top a linha corrente
918:                 *-- ficaria onde o Scan do BO a deixou
919:                 SELECT (loc_cCursor)
920:                 GO TOP
921:                 THIS.grd_4c_Dados.Refresh()
922: 
923:                 loc_lSucesso = .T.
924:             ENDIF
925: 
926:         CATCH TO loc_oErro
927:             THIS.this_cMensagemErro = loc_oErro.Message
928:             MsgErro(loc_oErro.Message + CHR(13) + ;
929:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
930:                     "Procedure: " + loc_oErro.Procedure, ;
931:                     "Erro em FormSigOpNch.CarregarGrade")
932:         ENDTRY
933: 
934:         RETURN loc_lSucesso

*-- Linhas 949 a 984:
949:     *
950:     * Legado, na ordem:
951:     *
952:     *   Select csCheques
953:     *   Scan For Marcas
954:     *       If !IsEmpty(csCheques.Cheques)
955:     *           lcChave = PADR(Bancos + Agencias + NContas, 25)
956:     *           Locate em crAutoriza For valor = lcChave
957:     *             achou     -> Replace Conteudo With csCheques.Cheques - 1
958:     *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
959:     *                          Values (lcChave, csCheques.Cheques - 1)
960:     *       Endif
961:     *   EndScan
962:     *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
963:     *   If Not m.lnErro1 > 0
964:     *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.', 48)
965:     *   EndIf
966:     *   ThisForm.Release
967:     *
968:     * O LACO, a chave POSICIONAL de 25 (regra #42), o "- 1", o
969:     * update-ou-insert e a transacao (UpDate/Commit/RollBack) vivem INTEIROS
970:     * em SigOpNchBO.GravarNumeracao - o poDataMgr do legado nao se reproduz
971:     * aqui de proposito (PILAR 3): o acesso a dados mora no BO/DataAccess.
972:     * Este handler eh o GATILHO, e isso eh tudo o que ele faz.
973:     *
974:     * NAO ha "Valid da celula" a chamar antes: ao clicar o botao (ou disparar
975:     * o ALT+C do Caption) o foco SAI da Column5, e o VFP roda o Valid dela
976:     * ANTES do Click - era assim que o legado contava com a linha ja marcada.
977:     * Forcar um SetFocus aqui seria inventar passo que o legado nao tem.
978:     *
979:     * A mensagem de erro eh a do legado, LITERAL, e so aparece quando o BO
980:     * ainda nao exibiu nada (regra #20: GravarNumeracao ja reporta a falha e
981:     * marca this_lErroExibido - sem a guarda o usuario levaria o mesmo erro
982:     * duas vezes).
983:     *
984:     * O Release eh INCONDICIONAL, como no legado: la o "ThisForm.Release" eh a

*-- Linhas 1078 a 1096:
1078:     * O .Value = 0 so na CRIACAO: nascido assim o controle eh NUMERICO desde o
1079:     * inicio (TextBox nasce com .Value = "" caractere, e o When compararia
1080:     * tipos diferentes). Na reinstalacao ele NAO se repete - ali o controle ja
1081:     * eh o CurrentControl da coluna, logo esta ligado ao ControlSource, e
1082:     * atribuir .Value sujaria o registro corrente do cursor.
1083:     *--------------------------------------------------------------------------
1084:     PROTECTED PROCEDURE InstalarCelulaCheque(par_oGrade)
1085:         LOCAL loc_lSucesso, loc_oColuna, loc_oErro
1086: 
1087:         loc_lSucesso = .F.
1088: 
1089:         IF VARTYPE(par_oGrade) != "O"
1090:             RETURN .F.
1091:         ENDIF
1092: 
1093:         TRY
1094:             IF par_oGrade.ColumnCount >= 5
1095:                 loc_oColuna = par_oGrade.Columns(5)
1096: 

*-- Linhas 1175 a 1202:
1175:     *   EndIf
1176:     *
1177:     *   If This.Value # Thisform.nAntChqVal
1178:     *       Select csCheques
1179:     *       Replace csCheques.Marcas With .T.
1180:     *   EndIf
1181:     *
1182:     * Este metodo FECHA O CIRCUITO da tela: Marcas eh a flag que o
1183:     * "Scan For Marcas" do Confirmar le, entao sem ele nenhuma linha seria
1184:     * gravada por mais que o usuario digitasse.
1185:     *
1186:     * O valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor - o
1187:     * ControlSource da coluna so escreve depois de o Valid passar (regra #46).
1188:     * Ler o cursor aqui validaria o valor ANTIGO; por isso FormParaBO recebe a
1189:     * celula e deixa que ela PREVALECA sobre o que esta gravado na linha.
1190:     *
1191:     * Quem decide se o numero presta eh o BO (ValidarNumeroCheque), nao a
1192:     * tela: a regra - e a mensagem - sao de negocio e tem fonte unica, a mesma
1193:     * que GravarNumeracao consulta antes de montar o lote. Duplicar o
1194:     * "If This.Value < 0" aqui criaria um segundo lugar para a regra divergir.
1195:     *
1196:     * MsgAviso, e nao MsgErro: o legado usa MessageBox com icone 48
1197:     * (exclamacao), que eh validacao de entrada do usuario - MsgErro abre o
1198:     * dialogo vermelho, reservado a excecao tecnica. O titulo vazio do legado
1199:     * vira o canonico "Atencao" do projeto (MsgAviso com titulo vazio).
1200:     *
1201:     * RETURN 0 (numerico) no caminho invalido eh o que PRENDE o foco na celula,
1202:     * obrigando o usuario a corrigir - exatamente o "Return 0" do legado. Nao

*-- Linhas 1228 a 1246:
1228:                     *-- "This.Value = Thisform.nAntChqVal": o BO volta ao
1229:                     *-- numero anterior e BOParaForm espelha na celula. O
1230:                     *-- CURSOR nao eh tocado - ele ainda tem o valor antigo,
1231:                     *-- porque o ControlSource so grava apos um Valid que
1232:                     *-- passe, e eh justamente esse que esta sendo recusado.
1233:                     loc_oBO.this_nProxCheque = THIS.this_nAntChqVal
1234:                     loc_oBO.this_nConteudo   = THIS.this_nAntChqVal - 1
1235: 
1236:                     THIS.BOParaForm(par_oTxt)
1237: 
1238:                     loc_uRetorno = 0
1239:                 ELSE
1240:                     *-- "If This.Value # Thisform.nAntChqVal": so a linha que
1241:                     *-- o usuario de fato mudou eh marcada. Sem a comparacao,
1242:                     *-- apenas passar o foco pela celula marcaria a linha e o
1243:                     *-- Confirmar regravaria contas que ninguem editou.
1244:                     IF loc_nDigitado != THIS.this_nAntChqVal
1245:                         loc_oBO.MarcarChequeAlterado(loc_oBO.this_cCursorCheques)
1246:                     ENDIF

*-- Linhas 1269 a 1287:
1269:     * A identidade vem de BO.CarregarChequeDoCursor, que ja monta a chave
1270:     * POSICIONAL de 25 (regra #42) e deriva this_nConteudo - fonte unica, a
1271:     * mesma que o Confirmar usa. O que este metodo acrescenta eh o valor
1272:     * DIGITADO: durante o Valid ele ainda nao chegou ao cursor (o ControlSource
1273:     * so grava depois), entao a celula PREVALECE sobre a coluna quando ela eh
1274:     * passada. Chamado sem a celula, fica valendo o que o cursor tem - que eh o
1275:     * estado ja confirmado da linha.
1276:     *
1277:     * NAO existem aqui os dezenas de campos de um FormParaBO de cadastro: o
1278:     * SCX nao declara TextBox/ComboBox/CheckBox nenhum fora da grade. Inventar
1279:     * campos para a tela "parecer" um CRUD violaria o PILAR 1.
1280:     *
1281:     * PROTECTED, e nao PUBLIC: FormBase declara este hook PROTECTED, e em VFP9
1282:     * o override NAO alarga o escopo - o metodo fica protegido mesmo escrito sem
1283:     * modificador (regra #51). Declarado assim explicitamente para o codigo
1284:     * dizer a verdade sobre o proprio escopo. O unico chamador eh o Valid da
1285:     * celula, que roda DENTRO da classe, entao nada quebra; um harness que
1286:     * precise exercita-lo tem de subclassar o form, como ja fazem os probes.
1287:     *--------------------------------------------------------------------------

*-- Linhas 1335 a 1353:
1335:     *
1336:     * NAO toca no cursor de proposito. O unico chamador real eh o caminho de
1337:     * recusa do Valid, onde o cursor AINDA tem o valor antigo e correto: o
1338:     * ControlSource so grava depois de um Valid que passe, e eh exatamente esse
1339:     * que esta sendo recusado. Escrever no cursor aqui gravaria o mesmo valor
1340:     * por dois caminhos diferentes.
1341:     *
1342:     * A celula pode vir por parametro (o caminho do Valid, que ja a tem em
1343:     * maos) ou ser resolvida na Column5 - assim o metodo tambem funciona
1344:     * chamado de fora, sem argumento. A resolucao eh guardada por PEMSTATUS
1345:     * porque a celula so existe depois de InstalarCelulaCheque, e esse so roda
1346:     * quando a grade tem cursor.
1347:     *
1348:     * PROTECTED pelo mesmo motivo do irmao: o hook eh PROTECTED em FormBase e o
1349:     * override nao alarga o escopo (regra #51).
1350:     *--------------------------------------------------------------------------
1351:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
1352:         LOCAL loc_lSucesso, loc_oBO, loc_oCelula, loc_oColuna, loc_oErro
1353: 


### BO (C:\4c\projeto\app\classes\SigOpNchBO.prg):
*==============================================================================
* SigOpNchBO.prg - Business Object para SigOpNch (Numeracao de Cheques)
*
* Form OPERACIONAL (SIGOPNCH.SCX, Caption "Numeracao de Cheques"). Nao eh
* cadastro CRUD: lista, numa unica grade editavel, todas as formas de
* pagamento (SigOpFp) do tipo cheque com conta bancaria configurada, mostra
* o PROXIMO numero de cheque de cada conta e grava apenas as linhas que o
* usuario alterou.
*
* Fluxo do legado (reproduzir em fases seguintes):
*   Init do form -> para cada linha de SigOpFp com Infos = 'C' And
*     EmiChqs = 1 And Bancos/Agencias/NContas preenchidos:
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza (SigSySeq) For valor = lcChave
*         achou  -> csCheques.Cheques = crAutoriza.Conteudo + 1
*         nao achou -> csCheques.Cheques = 1
*   btnAlterar.Click (Confirmar) -> Scan csCheques For Marcas (linhas
*     tocadas pelo usuario no Valid da coluna 5):
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza For valor = lcChave
*         achou     -> Replace Conteudo With Cheques - 1
*         nao achou -> Insert Into crAutoriza (Valor, Conteudo) Values
*                      (lcChave, Cheques - 1)
*     Grava tudo numa UNICA transacao (UpDate/Commit/RollBack do poDataMgr).
*
* Tabelas (nomes/colunas conferidos em docs/schema.sql - UTF-16, Get-Content
* -Raw, regra #14 do CLAUDE.md):
*   SigSySeq  valor char(25) PK, conteudo numeric(13,0), digchecks
*             numeric(1,0) NOT NULL. Guarda o ULTIMO numero de cheque
*             emitido (gravado = proximo numero - 1), chave por conta
*             bancaria. digchecks nao aparece em nenhum lugar do codigo
*             legado (nem Init, nem Click) - o Insert do legado so grava
*             Valor/Conteudo porque o cursor crAutoriza (AddCursor) ja tem
*             0 como valor de buffer para a coluna; a Fase 2 precisa gravar
*             esse 0 explicitamente no INSERT para nao violar o NOT NULL.
*   SigOpFp   fpags char(12) PK, bancos char(3), agencias char(4),
*             ncontas char(10), infos char(1), emichqs numeric(1,0).
*             infos = 'C' identifica forma de pagamento tipo Cheque.
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao real (Fase 2) sera um metodo proprio que resolve,
* por chave, update-ou-insert em SigSySeq para cada linha alterada da
* grade - por isso this_cTabela/this_cCampoChave apontam para SigSySeq.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNchBO AS BusinessBase

    *==========================================================================
    * Linha corrente de SigSySeq (crAutoriza no legado) - sequencia generica
    * de "proximo numero". Aqui guarda o ULTIMO cheque emitido por conta
    * bancaria (proximo numero exibido na grade = this_nConteudo + 1).
    *==========================================================================
    this_cValor     = ""   && SigSySeq.valor     char(25) PK - PADR(Bancos+Agencias+NContas,25)
    this_nConteudo  = 0    && SigSySeq.conteudo  numeric(13,0) - ultimo cheque emitido
    this_nDigChecks = 0    && SigSySeq.digchecks numeric(1,0) - nao exibido na tela; grava 0 (default do cursor legado)

    *==========================================================================
    * Linha corrente de SigOpFp (forma de pagamento associada a conta
    * bancaria) - usada para montar a chave acima e exibir Bco./Agencia/Conta
    *==========================================================================
    this_cFPags    = ""    && SigOpFp.fpags    char(12) - codigo da forma de pagamento
    this_cBancos   = ""    && SigOpFp.bancos   char(3)
    this_cAgencias = ""    && SigOpFp.agencias char(4)
    this_cNContas  = ""    && SigOpFp.ncontas  char(10)

    *==========================================================================
    * Proximo numero de cheque editado na grade (csCheques.Cheques no
    * legado) - valor exibido/editado pelo usuario antes de Confirmar.
    * Gravado em SigSySeq.conteudo como this_nProxCheque - 1.
    *==========================================================================
    this_nProxCheque = 0

    *==========================================================================
    * Nomes de cursor usados pelo form (mantidos como property para o Form
    * nao repetir literais - mesmo padrao de SigOpLimBO)
    *==========================================================================
    this_cCursorFormasPagto = "cursor_4c_FormasPagto"  && SigOpFp filtradas (Infos='C' And EmiChqs=1, com conta bancaria)
    this_cCursorAutoriza    = "cursor_4c_Autoriza"     && SigSySeq (crAutoriza no legado)
    this_cCursorCheques     = "cursor_4c_Cheques"      && csCheques no legado - grade editavel (FPags/Bancos/Agencias/NContas/Cheques/Marcas)

    *==========================================================================
    * Init - Configura tabela/chave principal (SigSySeq / crAutoriza)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal gravada por este BO: sequencia de proximo
            *-- numero de cheque por conta bancaria (crAutoriza no legado)
            THIS.this_cTabela     = "SigSySeq"
            THIS.this_cCampoChave = "valor"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNchBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarChaveConta - Monta a chave POSICIONAL de SigSySeq.valor char(25)
    *
    * Legado (Init e btnAlterar.Click, as DUAS montagens identicas):
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *
    * A chave eh POSICIONAL (regra #42 do CLAUDE.md): o padding de cada coluna
    * char FAZ PARTE da chave. No legado o padding vem de graca porque os
    * valores sao lidos CRUS do cursor (bancos char(3), agencias char(4),
    * ncontas char(10) - todos NOT NULL no schema, logo sempre na largura
    * cheia). Aqui as partes podem chegar de property/parametro JA com ALLTRIM,
    * entao o PADR de cada parte eh OBRIGATORIO - sem ele a chave encurta, o
    * WHERE nao casa e o UPDATE roda SEM ERRO afetando ZERO linha.
    *
    * CONFERENCIA de largura: 3 + 4 + 10 = 17, completado com PADR ate 25 =
    * exatamente a largura de SigSySeq.valor char(25).
    *==========================================================================
    PROCEDURE MontarChaveConta(par_cBancos, par_cAgencias, par_cNContas)
        LOCAL loc_cChave

        loc_cChave = PADR(IIF(VARTYPE(par_cBancos)   = "C", par_cBancos,   ""),  3) + ;
                     PADR(IIF(VARTYPE(par_cAgencias) = "C", par_cAgencias, ""),  4) + ;
                     PADR(IIF(VARTYPE(par_cNContas)  = "C", par_cNContas,  ""), 10)

        RETURN PADR(loc_cChave, 25)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigSySeq (crAutoriza no
    * legado) nas properties deste BO. Mapeia TODAS as colunas da tabela:
    * valor char(25), conteudo numeric(13,0), digchecks numeric(1,0).
    *
    * this_nProxCheque eh derivado aqui pela MESMA conta do Init legado
    * ("crAutoriza.Conteudo + 1"): SigSySeq guarda o ULTIMO cheque emitido e
    * a grade exibe o PROXIMO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cValor     = TratarNulo(valor, "")
                THIS.this_nConteudo  = TratarNulo(conteudo, 0)
                THIS.this_nDigChecks = TratarNulo(digchecks, 0)

                *-- Legado: Insert ... Values (..., crAutoriza.Conteudo + 1)
                THIS.this_nProxCheque = THIS.this_nConteudo + 1

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarChequeDoCursor - Carrega a linha corrente da GRADE
    * (cursor_4c_Cheques / csCheques no legado) nas properties, resolvendo a
    * chave de SigSySeq e o conteudo a gravar.
    *
    * Legado (btnAlterar.Click):
    *   lcChave  = PADR(csCheques.Bancos + csCheques.Agencias + csCheques.NContas, 25)
    *   Conteudo = csCheques.Cheques - 1
    *
    * As colunas sao lidas CRUAS (sem ALLTRIM) justamente porque alimentam a
    * chave posicional - ver MontarChaveConta.
    *==========================================================================
    PROCEDURE CarregarChequeDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cFPags    = TratarNulo(FPags, "")
                THIS.this_cBancos   = TratarNulo(Bancos, "")
                THIS.this_cAgencias = TratarNulo(Agencias, "")
                THIS.this_cNContas  = TratarNulo(NContas, "")

                THIS.this_nProxCheque = TratarNulo(Cheques, 0)

                THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                         THIS.this_cAgencias, ;
                                                         THIS.this_cNContas)

                *-- SigSySeq.conteudo = ULTIMO cheque emitido = proximo - 1
                THIS.this_nConteudo = THIS.this_nProxCheque - 1

                *-- digchecks nao aparece em NENHUM ponto do codigo legado (nem
                *-- no Init, nem no Click). O "Insert Into crAutoriza (Valor,
                *-- Conteudo)" grava 0 ali porque esse eh o valor de buffer do
                *-- cursor criado pelo AddCursor; como a coluna eh NOT NULL sem
                *-- DEFAULT, este BO grava o mesmo 0 EXPLICITAMENTE (regra #22).
                THIS.this_nDigChecks = 0

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigSySeq usada na auditoria
    *
    * ALLTRIM aqui eh INOFENSIVO e proposital: a chave JA esta montada (o
    * padding INTERIOR esta preservado) e este retorno so alimenta
    * LogAuditoria.ChaveRegistro - nunca volta a ser usado em WHERE.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cValor)
    ENDPROC

    *==========================================================================
    * ValidarNumeroCheque - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value < 0
    *       MessageBox('Numero do Cheque Invalido.', 48, '')
    *       This.Value = Thisform.nAntChqVal
    *       Return 0
    *   EndIf
    *
    * So devolve o veredito; quem exibe a mensagem e restaura o valor anterior
    * eh o Form (que eh quem guarda o nAntChqVal). NAO ha limite SUPERIOR no
    * legado - a largura N(6) do cursor da grade eh que limita, e inventar um
    * teto aqui violaria o PILAR 1.
    *==========================================================================
    PROCEDURE ValidarNumeroCheque(par_nValor)
        LOCAL loc_lValido

        loc_lValido = .T.

        IF VARTYPE(par_nValor) != "N"
            loc_lValido = .F.
        ELSE
            IF par_nValor < 0
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF !loc_lValido
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                      CHR(225) + "lido."
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ValidarDados - Chamado por BusinessBase.Salvar() e por GravarNumeracao
    * antes de incluir cada linha no lote.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cValor)
                THIS.this_cMensagemErro = "Conta banc" + CHR(225) + "ria n" + ;
                    CHR(227) + "o identificada (Banco / Ag" + CHR(234) + ;
                    "ncia / Conta)."

            CASE !THIS.ValidarNumeroCheque(THIS.this_nProxCheque)
                *-- ValidarNumeroCheque ja preencheu this_cMensagemErro

            CASE THIS.this_nConteudo < 0
                THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                          CHR(225) + "lido."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * MontarInsertSequencia / MontarUpdateSequencia
    *
    * FONTE UNICA do SQL de gravacao de SigSySeq: Inserir()/Atualizar() usam
    * esses textos para o caminho de UMA linha, e GravarNumeracao() usa os
    * MESMOS textos para montar o lote atomico de varias linhas. Sem a fonte
    * unica os dois caminhos divergiriam em silencio.
    *
    * SigSySeq tem TRES colunas e TODAS sao NOT NULL sem DEFAULT (conferido em
    * docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
    * valor, conteudo, digchecks. O INSERT cobre as tres - omitir digchecks
    * faria o SQL Server recusar a inclusao inteira (regra #22).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertSequencia()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigSySeq (valor, conteudo, digchecks) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cValor, 25)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nDigChecks, 0) + ")"

        RETURN loc_cSQL
    ENDPROC

    PROTECTED PROCEDURE MontarUpdateSequencia()
        LOCAL loc_cSQL

        *-- Legado (btnAlterar.Click): "Replace Conteudo With csCheques.Cheques - 1"
        *-- - so o conteudo muda; digchecks eh preservado no registro existente.
        loc_cSQL = "UPDATE SigSySeq SET conteudo = " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ;
                   " WHERE valor = " + EscaparSQL(LEFT(THIS.this_cValor, 25))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UMA sequencia em SigSySeq (caminho BusinessBase.Salvar)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarInsertSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE de UMA sequencia em SigSySeq
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarUpdateSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFormasPagtoCheque - Popula this_cCursorFormasPagto (crSigOpFp)
    *
    * Legado: .AddCursor('SigOpFp','FPags','crSigOpFp','FPags',.f.) + Requery
    * (traz SigOpFp inteira, ordenada por FPags) e o Scan do Init descarta
    * tudo que nao casa com:
    *   Infos = 'C' And EmiChqs = 1 And Not IsEmpty(Bancos) And
    *   Not IsEmpty(Agencias) And Not IsEmpty(NContas)
    *
    * O filtro vai para o WHERE (resultado identico, sem trafegar a tabela
    * inteira). Nomes de coluna conferidos em docs/schema.sql: fpags char(12),
    * bancos char(3), agencias char(4), ncontas char(10), infos char(1),
    * emichqs numeric(1,0).
    *
    * NAO ha filtro por empresa: o legado nao filtra (AddCursor sem query) e
    * inventar um WHERE emps mudaria o conteudo da grade (PILAR 1).
    *==========================================================================
    PROCEDURE CarregarFormasPagtoCheque()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorFormasPagto)
                    USE IN (THIS.this_cCursorFormasPagto)
                ENDIF

                loc_cSQL = "SELECT fpags, bancos, agencias, ncontas" + ;
                           " FROM SigOpFp" + ;
                           " WHERE infos = 'C'" + ;
                           "   AND emichqs = 1" + ;
                           "   AND RTRIM(bancos) <> ''" + ;
                           "   AND RTRIM(agencias) <> ''" + ;
                           "   AND RTRIM(ncontas) <> ''" + ;
                           " ORDER BY fpags"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagto)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorFormasPagto)
                    THIS.this_cMensagemErro = "Erro ao carregar as Formas de " + ;
                        "Pagamento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorFormasPagto)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarFormasPagtoCheque")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarAutoriza - Popula this_cCursorAutoriza (crAutoriza no legado)
    * com SigSySeq. Legado:
    *   .AddCursor('SigSySeq','Valor','crAutoriza','Valor',.f.) + Requery
    *
    * Traz as TRES colunas da tabela (valor/conteudo/digchecks) para que o
    * LOCATE do Init legado e a conferencia de existencia funcionem sem ida
    * extra ao banco.
    *==========================================================================
    PROCEDURE CarregarAutoriza()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorAutoriza)
                    USE IN (THIS.this_cCursorAutoriza)
                ENDIF

                loc_cSQL = "SELECT valor, conteudo, digchecks" + ;
                           " FROM SigSySeq" + ;
                           " ORDER BY valor"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorAutoriza)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorAutoriza)
                    THIS.this_cMensagemErro = "Erro ao carregar a numera" + CHR(231) + ;
                        CHR(227) + "o de cheques." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorAutoriza)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarAutoriza")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LocalizarSequencia - Legado (Init e Click, as duas vezes igual):
    *   Select crAutoriza
    *   LOCATE FOR valor = lcChave
    *   IF ! EOF() ...
    *
    * Deixa o cursor POSICIONADO na linha achada (o legado le
    * crAutoriza.Conteudo logo depois) e devolve .T./.F.
    *
    * Compara com "==" sobre as DUAS pontas padronizadas em 25 chars, nunca
    * com "=": o "=" depende de SET EXACT, e a datasession privada do form
    * (DataSession = 2) reseta os SETs para o default do VFP - o LOCATE do
    * legado casava por um comportamento de SET que aqui nao esta garantido.
    *==========================================================================
    PROCEDURE LocalizarSequencia(par_cChave)
        LOCAL loc_lAchou, loc_cChave

        loc_lAchou = .F.

        IF VARTYPE(par_cChave) = "C" AND USED(THIS.this_cCursorAutoriza)
            loc_cChave = PADR(par_cChave, 25)

            SELECT (THIS.this_cCursorAutoriza)
            LOCATE FOR PADR(valor, 25) == loc_cChave

            loc_lAchou = !EOF()
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * CriarCursorCheques - Cria o cursor da GRADE (csCheques no legado)
    *
    * Legado (PROCEDURE Load):
    *   Create Cursor csCheques ( FPags C(12), Bancos C(3), Agencias C(4),
    *                             NContas C(10), Cheques N(6), Marcas L(1) )
    *   Index On Fpags Tag FPags
    *
    * Esta eh a UNICA criacao do cursor no projeto (a recarga em MontarCheques
    * usa ZAP, nao CREATE) - assim a ordem/largura das colunas nao tem como
    * divergir entre dois pontos, e o RecordSource/ControlSource do Grid nao eh
    * destruido a cada carga.
    *
    * Idempotente: se o cursor ja existe, nao recria.
    *==========================================================================
    PROCEDURE CriarCursorCheques()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCheques)
                loc_lSucesso = .T.
            ELSE
                CREATE CURSOR (THIS.this_cCursorCheques) ( ;
                    FPags    C(12), ;
                    Bancos   C(3),  ;
                    Agencias C(4),  ;
                    NContas  C(10), ;
                    Cheques  N(6),  ;
                    Marcas   L(1))

                SELECT (THIS.this_cCursorCheques)
                INDEX ON FPags TAG FPags

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CriarCursorCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCheques - Reproduz o Scan do Init legado: para cada forma de
    * pagamento tipo cheque com conta bancaria, insere na grade o PROXIMO
    * numero de cheque.
    *
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *   Locate em crAutoriza For valor = lcChave
    *     achou     -> Cheques = crAutoriza.Conteudo + 1
    *     nao achou -> Cheques = 1
    *
    * Marcas nasce .F.: so o Valid da coluna 5 marca a linha, e o Confirmar
    * grava APENAS as marcadas.
    *
    * O ZAP vai GUARDADO por SET SAFETY: SAFETY eh escopado por data session e
    * o form eh DataSession = 2, onde ele volta a valer ON mesmo com o
    * SET SAFETY OFF do main.prg - com SAFETY ON o ZAP abre um dialogo modal
    * que ninguem ve e CONGELA a tela.
    *==========================================================================
    PROCEDURE MontarCheques()
        LOCAL loc_lSucesso, loc_cSafety, loc_nProx, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.CriarCursorCheques()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar a grade de cheques."
            ELSE
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                SELECT (THIS.this_cCursorCheques)
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                IF USED(THIS.this_cCursorFormasPagto)
                    SELECT (THIS.this_cCursorFormasPagto)
                    SCAN
                        *-- Valores lidos CRUS - alimentam a chave posicional
                        THIS.this_cFPags    = TratarNulo(fpags, "")
                        THIS.this_cBancos   = TratarNulo(bancos, "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas, "")

                        THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                                 THIS.this_cAgencias, ;
                                                                 THIS.this_cNContas)

                        IF THIS.LocalizarSequencia(THIS.this_cValor)
                            SELECT (THIS.this_cCursorAutoriza)
                            loc_nProx = TratarNulo(conteudo, 0) + 1
                        ELSE
                            loc_nProx = 1
                        ENDIF

                        INSERT INTO (THIS.this_cCursorCheques) ;
                            (FPags, Bancos, Agencias, NContas, Cheques, Marcas) ;
                            VALUES (THIS.this_cFPags, THIS.this_cBancos, ;
                                    THIS.this_cAgencias, THIS.this_cNContas, ;
                                    loc_nProx, .F.)

                        SELECT (THIS.this_cCursorFormasPagto)
                    ENDSCAN
                ENDIF

                *-- Legado: "Select csCheques / Go Top" antes do Grade.Refresh
                SELECT (THIS.this_cCursorCheques)
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.MontarCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDados - Funil UNICO de carga: formas de pagamento + sequencias +
    * montagem da grade. Equivale ao bloco de Requery/Scan do Init legado.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.CarregarFormasPagtoCheque()
            IF THIS.CarregarAutoriza()
                loc_lSucesso = THIS.MontarCheques()
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequeAlterado - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value # Thisform.nAntChqVal
    *       Select csCheques
    *       Replace csCheques.Marcas With .T.
    *   EndIf
    *
    * Marca a linha CORRENTE da grade. O Replace do legado roda sobre o
    * registro corrente de csCheques, nao sobre todos.
    *==========================================================================
    PROCEDURE MarcarChequeAlterado(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)

            IF !EOF()
                REPLACE Marcas WITH .T. IN (loc_cCursor)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarChequesAlterados - Quantas linhas da grade o usuario tocou
    * (o "Scan For Marcas" do legado com o "If !IsEmpty(csCheques.Cheques)"
    * que descarta numero zerado; Cheques eh N(6), logo IsEmpty equivale a = 0).
    *
    * Repoe o RECNO no fim: SCAN move o ponteiro e quem chama costuma estar no
    * meio da propria navegacao da grade.
    *==========================================================================
    PROCEDURE ContarChequesAlterados(par_cCursorCheques)
        LOCAL loc_cCursor, loc_nTotal, loc_nRecno

        loc_nTotal = 0
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_nRecno = IIF(EOF(), 0, RECNO())

            SCAN FOR Marcas AND Cheques <> 0
                loc_nTotal = loc_nTotal + 1
            ENDSCAN

            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT(loc_cCursor)
                GO (loc_nRecno) IN (loc_cCursor)
            ELSE
                GO TOP IN (loc_cCursor)
            ENDIF
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * GravarNumeracao - Legado: SIGOPNCH.btnAlterar.Click
    *
    *   Scan For Marcas
    *       If !IsEmpty(csCheques.Cheques)
    *           lcChave = PADR(Bancos + Agencias + NContas, 25)
    *           Locate em crAutoriza For valor = lcChave
    *             achou     -> Replace Conteudo With csCheques.Cheques - 1
    *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
    *                          Values (lcChave, csCheques.Cheques - 1)
    *       Endif
    *   EndScan
    *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
    *
    * ATOMICIDADE: o legado grava as N linhas numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    *
    * O "UPDATE ... IF @@ROWCOUNT = 0 INSERT ..." resolve no servidor o mesmo
    * update-ou-insert que o legado decidia pelo LOCATE no cursor - sem
    * depender de um cursor que pode estar desatualizado.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *==========================================================================
    PROCEDURE GravarNumeracao(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor, loc_cLote, loc_cStmts, loc_nLinhas, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        loc_lManual = .F.

        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.

            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "Grade de cheques n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
                    loc_cStmts  = ""
                    loc_nLinhas = 0

                    SELECT (loc_cCursor)
                    SCAN FOR Marcas AND Cheques <> 0
                        *-- Le a linha corrente da grade: monta a chave
                        *-- posicional e resolve conteudo = Cheques - 1
                        IF THIS.CarregarChequeDoCursor(loc_cCursor)
                            IF THIS.ValidarDados()
                                loc_nLinhas = loc_nLinhas + 1
                                DIMENSION loc_aChaves[loc_nLinhas]
                                loc_aChaves[loc_nLinhas] = THIS.this_cValor

                                loc_cStmts = loc_cStmts + ;
                                    THIS.MontarUpdateSequencia() + "; " + ;
                                    "IF @@ROWCOUNT = 0 " + ;
                                    THIS.MontarInsertSequencia() + "; "
                            ELSE
                                *-- ValidarDados preencheu this_cMensagemErro.
                                *-- Aborta o lote INTEIRO, como o RollBack do
                                *-- legado - gravar parte das linhas deixaria a
                                *-- numeracao de algumas contas certa e de
                                *-- outras nao, sem o usuario saber quais.
                                loc_nLinhas = 0
                                loc_cStmts  = ""
                                EXIT
                            ENDIF
                        ENDIF

                        SELECT (loc_cCursor)
                    ENDSCAN

                    DO CASE
                        CASE !EMPTY(THIS.this_cMensagemErro)
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.

                        CASE loc_nLinhas = 0
                            *-- Nada marcado: o legado tambem segue em frente
                            *-- (UpDate/Commit sem alteracao nenhuma) e encerra
                            *-- a tela sem reclamar. NAO inventar aviso aqui.
                            loc_lSucesso = .T.

                        OTHERWISE
                            loc_cLote = "SET NOCOUNT ON; " + ;
                                "DECLARE @nivel int = @@TRANCOUNT; " + ;
                                "IF @nivel = 0 BEGIN TRANSACTION " + ;
                                "ELSE SAVE TRANSACTION Nch4c; " + ;
                                "BEGIN TRY " + ;
                                loc_cStmts + ;
                                "IF @nivel = 0 COMMIT TRANSACTION; " + ;
                                "END TRY " + ;
                                "BEGIN CATCH " + ;
                                "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
                                "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Nch4c; END; " + ;
                                "THROW; " + ;
                                "END CATCH"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                            IF loc_nResultado < 0
                                loc_cErro = CapturarErroSQL()

                                IF loc_lManual
                                    = SQLROLLBACK(gnConnHandle)
                                ENDIF

                                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                                    CHR(227) + "o dos Dados do Cadastro de Opera" + ;
                                    CHR(231) + CHR(245) + "es." + CHR(13) + loc_cErro
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                THIS.this_lErroExibido = .T.
                            ELSE
                                *-- Commit do legado (.poDataMgr.Commit())
                                loc_lSucesso = .T.

                                IF loc_lManual
                                    IF SQLCOMMIT(gnConnHandle) < 1
                                        = SQLROLLBACK(gnConnHandle)
                                        THIS.this_cMensagemErro = "Erro na Grava" + ;
                                            CHR(231) + CHR(227) + "o dos Dados do " + ;
                                            "Cadastro de Opera" + CHR(231) + CHR(245) + ;
                                            "es." + CHR(13) + CapturarErroSQL()
                                        MsgErro(THIS.this_cMensagemErro, "Erro")
                                        THIS.this_lErroExibido = .T.
                                        loc_lSucesso = .F.
                                    ENDIF
                                ENDIF

                                IF loc_lSucesso
                                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                                    *-- O cursor de sequencias passa a divergir
                                    *-- do banco depois de gravar: recarregar
                                    *-- para um segundo Confirmar nao tentar
                                    *-- inserir chave que agora existe.
                                    THIS.CarregarAutoriza()
                                ENDIF
                            ENDIF
                    ENDCASE

                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.GravarNumeracao")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoriaLote - Grava em LogAuditoria uma linha por conta
    * bancaria afetada pelo lote de GravarNumeracao.
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SigSySeq e a auditoria nao pode poder derruba-lo.
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cValorAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cValorAnterior = THIS.this_cValor

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cValor = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("UPDATE")
            ENDFOR

            THIS.this_cValor = loc_cValorAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties (usado por BusinessBase.NovoRegistro)
    *==========================================================================
    PROCEDURE LimparDados()
        THIS.this_cValor      = ""
        THIS.this_nConteudo   = 0
        THIS.this_nDigChecks  = 0

        THIS.this_cFPags      = ""
        THIS.this_cBancos     = ""
        THIS.this_cAgencias   = ""
        THIS.this_cNContas    = ""

        THIS.this_nProxCheque = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores que este BO abriu
    *==========================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorFormasPagto)
            USE IN (THIS.this_cCursorFormasPagto)
        ENDIF

        IF USED(THIS.this_cCursorAutoriza)
            USE IN (THIS.this_cCursorAutoriza)
        ENDIF

        IF USED(THIS.this_cCursorCheques)
            USE IN (THIS.this_cCursorCheques)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

