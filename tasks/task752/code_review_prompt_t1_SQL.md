# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LOCAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, PCTIPO, CPROS, OPERACAO, CODUTIL, DOPES, SELECAO

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
  Column2.ControlSource = ""
This.Grade.Column1.ControlSource = []
This.Grade.Column2.ControlSource = []
	lcQuery = [Select 0 as Selecao, Codigos, Observas, Descrs ] + ;
			    [From SigCdObs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalObs]) < 1)
		lcQuery = [Select Codigos From SigCdObs Where Codigos ] + lcWhere
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CrObs]) < 1)
		SELECT * from crSigOpFnl into cursor crObs 
		lcSql = [Select Cgrus From SigCdPro Where cpros = ']+crTpmMvItn.Cpros+[']
		ThisForm.PodataMgr.SqlExecute(lcSql,'crPro')
		lcQuery = [Select * From sigopFnl Where operacao = 'GRP' and codutil = '] +ALLTRIM(crPro.cgrus)+ [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CrGRP]) < 1)
		Select Distinct a.Selecao, a.Codigos, Left(a.Observas,100) as Observas, a.Descrs from localObs a, crGRP b where a.codigos = b.codigos into cursor localObs READWRITE
		Select * From crSigopFnl Where codutil = pcChv into cursor crObs
	SELECT crObs
		SELECT localObs
		SELECT crObs	
	lcQuery = [Select ObsPads, ObsInis, ObsFins ] + ;
				[From SigCdOpe ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalOpe]) < 1)
	lcQuery = [Select 0 as Selecao, Codigos, Observas, Descrs ] + ;
			    [From SigCdObs ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalObs]) < 1)
This.Grade.Column1.ControlSource = [LocalObs.Selecao]
This.Grade.Column2.ControlSource = [LocalObs.Descrs]
This.getObs.ControlSource = [LocalObs.Observas]
Select LocalObs
Update LocalObs Set Selecao = 1 Where Codigos = lcObsPads
Select LocalObs
	Select LocalObs
		Select LocalObs
		Select LocalObs
				Select crSigOpFnl
					Insert Into crSigOpFnl (operacao, codigos, codutil, cidchaves, empdopnums) Values ('GRP',LocalObs.codigos, Alltrim(crSigCdGrp.cgrus),lcIdChave,'')
				Select crSigOpFnl
					Delete
			Select LocalObs
		Select LocalObs
				Select crSigOpFnl
					Insert Into crSigOpFnl (operacao, codigos, codutil, cidchaves, empdopnums) Values ('ITN',LocalObs.codigos, pcChv,lcIdChave,pcEDN)
				Select crSigOpFnl
					Delete
			Select LocalObs
	Select LocalBusLin
		Update LocalObs Set Selecao = 0
		Update LocalObs Set Selecao = 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPins.prg) - TRECHOS RELEVANTES PARA PASS SQL (1598 linhas total):

*-- Linhas 201 a 219:
201:                 THIS.BOParaForm()
202: 
203:                 *-- Carga da lista: no legado isso esta DENTRO do Init e um
204:                 *-- SELECT que falha devolve .F., fechando a tela. Mesma
205:                 *-- semantica aqui.
206:                 IF THIS.CarregarLista()
207:                     loc_lSucesso = .T.
208:                 ELSE
209:                     loc_lSucesso = .F.
210:                 ENDIF
211: 
212:                 THIS.TornarControlesVisiveis()
213: 
214:                 *-- Legado, fim do Init: This.Refresh / Grade.Column1.SetFocus
215:                 *-- / Grade.Column1.fwcheckbox1.SetFocus / Grade.AfterRowColChange().
216:                 *-- So depois do TornarControlesVisiveis(): os controles criados
217:                 *-- por AddObject nascem Visible = .F., e SetFocus em controle
218:                 *-- invisivel estoura.
219:                 IF loc_lSucesso

*-- Linhas 458 a 478:
458:     * sao override VAZIO do Form Designer, nao mascara.
459:     *
460:     * Aqui ficam SO as propriedades que nao dependem de dado. O bind
461:     * (RecordSource / ControlSource / Width / Header1.Caption) fica em
462:     * VincularGrade(), chamado por CarregarLista() com o cursor ja
463:     * populado: Column.ControlSource de cursor inexistente derruba o Init.
464:     *
465:     * ColumnCount eh definido UMA vez, aqui - esta grade nunca troca de
466:     * numero de colunas, e reduzir ColumnCount depois destruiria o CheckBox
467:     * criado por AddObject na Column1.
468:     *==========================================================================
469:     PROTECTED PROCEDURE ConfigurarGradeObservacoes()
470:         LOCAL loc_oGrade
471: 
472:         THIS.AddObject("grd_4c_Dados", "Grid")
473: 
474:         loc_oGrade = THIS.grd_4c_Dados
475: 
476:         WITH loc_oGrade
477:             .ColumnCount  = 2
478:             .FontName     = "Tahoma"

*-- Linhas 490 a 512:
490:             *-- ReadOnly delas: tem de vir ANTES de Column<N>.ReadOnly.
491:             .ReadOnly     = .F.
492: 
493:             *-- RecordMark do dump; DeleteMark nao aparece no dump mas as
494:             *-- grades criadas por AddObject em form OPERACIONAL ficam com
495:             *-- as duas barras laterais desligadas.
496:             .RecordMark   = .F.
497:             .DeleteMark   = .F.
498: 
499:             .Visible      = .T.
500:         ENDWITH
501: 
502:         *----------------------------------------------------------------------
503:         * Column1 - marcacao (CheckBox)
504:         *
505:         * Column.AddObject CRIA o controle e NAO o exibe: sem
506:         * CurrentControl a coluna continua desenhando o Text1 dela e o
507:         * usuario ve 0/1 como texto, sem como marcar. Sparse = .F. eh o que
508:         * faz o CheckBox aparecer em TODAS as linhas, nao so na corrente.
509:         *
510:         * As 7 propriedades explicitas do CheckBox (Alignment/ReadOnly/
511:         * Visible/Top/Left/Height/Width) sao o padrao do projeto: sem elas o
512:         * controle desenha o estado certo mas a area clicavel nao coincide

*-- Linhas 593 a 611:
593:     *
594:     * Legado: objeto "getObs", Class = fwmemo, BaseClass = editbox, filho
595:     * DIRETO da Form (SIGOPINS nao tem PageFrame nem Page - layout FLAT), com
596:     * ControlSource = [LocalObs.Observas].
597:     *
598:     * Nao eh campo de digitacao: eh a VISTA do texto completo da observacao
599:     * da linha corrente da grade. Por isso o legado o liga ao MESMO cursor da
600:     * grade e manda "ThisForm.getObs.Refresh" no AfterRowColChange - andar na
601:     * grade troca o texto exibido aqui.
602:     *
603:     * Propriedades transcritas do dump, secao "PROPRIEDADES DE:
604:     * SIGOPINS.getObs" (tasks\task752\SIGOPins_form_codigo_fonte.txt):
605:     *   FontName = "Tahoma", Format = "K!", Height = 180, Left = 54,
606:     *   SpecialEffect = 1, TabIndex = 4, Top = 391, Width = 608,
607:     *   NullDisplay = "  "
608:     *
609:     * Top/Left sao transcritos CRUS, sem a compensacao +29 dos forms CRUD:
610:     * aqui nao ha PageFrame com Top = -29, o controle pendura direto na Form.
611:     * Confere com o form 800x600: 54+608 = 662 e 391+180 = 571.

*-- Linhas 619 a 639:
619:     * SCX nem a classe fwmemo os declaram, e inventar valor para eles seria
620:     * desviar do legado.
621:     *
622:     * O ControlSource NAO entra aqui: o cursor da lista ainda nao existe
623:     * quando este metodo roda (ConfigurarCampoObservacao vem antes de
624:     * CarregarLista) e ControlSource de alias inexistente derruba o Init com
625:     * "Alias not found". O bind fica em VincularGrade(), junto com o da grade,
626:     * exatamente como no Init legado.
627:     *==========================================================================
628:     PROTECTED PROCEDURE ConfigurarCampoObservacao()
629:         THIS.AddObject("obj_4c_GetObs", "EditBoxMemoSIGOPins_4c_")
630: 
631:         WITH THIS.obj_4c_GetObs
632:             .FontName          = "Tahoma"
633:             .FontSize          = 8
634:             .Top               = 391
635:             .Left              = 54
636:             .Width             = 608
637:             .Height            = 180
638:             .SpecialEffect     = 1
639:             .Format            = "K!"

*-- Linhas 658 a 676:
658:     * AddObject (fica no 100x17 do default), entao Width/Height vem
659:     * explicito para a legenda nao ficar cortada.
660:     *
661:     * Sem ControlSource: eh lido direto por valor em BtnConfirmarClick
662:     * (equivalente a "Thisform.chkPular.Value" do legado), nao precisa
663:     * de bind nem de conversao numerica (regra de CheckBox.Value
664:     * numerico vale para checkbox ligado a coluna - este eh toggle puro
665:     * de UI).
666:     *==========================================================================
667:     PROTECTED PROCEDURE ConfigurarCheckBoxPular()
668:         THIS.AddObject("chk_4c_Pular", "CheckBox")
669: 
670:         WITH THIS.chk_4c_Pular
671:             .Top       = 220
672:             .Left      = 671
673:             .Width     = 150
674:             .Height    = 17
675:             .Alignment = 0
676:             .Caption   = "Pular Linhas"

*-- Linhas 834 a 852:
834:     *
835:     * Legado (btnConfirmar.Click):
836:     *   Thisform.Grade.Refresh
837:     *   Select LocalObs / Go Top In LocalObs
838:     *   Thisform.Grade.Refresh
839:     *   If Vartype(pcLista) <> 'C'
840:     *       Locate For Selecao = 1
841:     *       If Eof([LocalObs])
842:     *           =Messagebox([Nenhuma Observac-cedilhaa-tildeo Foi Selecionada!], 0+48, [Atenc-cedilhaa-tildeo])
843:     *           Go Top In LocalObs
844:     *           Thisform.Grade.Column1.SetFocus
845:     *           Return .F.
846:     *       Endif
847:     *
848:     * A CONDICAO QUE CERCA A VALIDACAO EH PARTE DELA: o legado so exige linha
849:     * marcada no fluxo de OPERACAO (pLista AUSENTE, Vartype(pcLista) <> 'C').
850:     * No fluxo de FINALIDADES (GRP/ITN/SIGOPINF, pLista informado) nao ha
851:     * validacao nenhuma - zero linha marcada significa "remover todas as
852:     * associacoes", que eh exatamente o que ConfirmarFluxoGrupo /

*-- Linhas 879 a 961:
879:         ENDIF
880: 
881:         IF USED(loc_cCursor)
882:             SELECT (loc_cCursor)
883:             GO TOP
884:         ENDIF
885: 
886:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
887:             THIS.grd_4c_Dados.Refresh()
888:         ENDIF
889: 
890:         *-- Fluxo de FINALIDADES: o legado nao valida - nada a recusar.
891:         IF THIS.this_lParListaInformada
892:             RETURN .T.
893:         ENDIF
894: 
895:         *-- Sem o cursor da lista nao ha como afirmar que falta selecao: a
896:         *-- falha tecnica eh reportada por ConfirmarSelecao() do BO, que tem
897:         *-- a mensagem certa para cursor indisponivel.
898:         IF !USED(loc_cCursor)
899:             RETURN .T.
900:         ENDIF
901: 
902:         SELECT (loc_cCursor)
903:         LOCATE FOR selecao = 1
904:         loc_lTemSelecao = !EOF()
905: 
906:         IF loc_lTemSelecao
907:             RETURN .T.
908:         ENDIF
909: 
910:         MsgAviso("Nenhuma Observa" + CHR(231) + CHR(227) + "o Foi Selecionada!", ;
911:             "Aten" + CHR(231) + CHR(227) + "o")
912: 
913:         SELECT (loc_cCursor)
914:         GO TOP
915: 
916:         IF !THIS.EstaEmModoTeste() AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
917:             THIS.grd_4c_Dados.SetFocus()
918:         ENDIF
919: 
920:         RETURN .F.
921:     ENDPROC
922: 
923:     *==========================================================================
924:     * BtnConfirmarClick - Command2 do dump (btnConfirmar, "\<Confirmar")
925:     *
926:     * Legado:
927:     *   Thisform.Grade.Refresh / Select LocalObs / Go Top In LocalObs /
928:     *       Thisform.Grade.Refresh
929:     *   <toda a logica de gravacao, delegada a SIGOPinsBO.ConfirmarSelecao()>
930:     *   Thisform.Release
931:     *
932:     * this_lFalhaValidacao do BO distingue a UNICA validacao deste
933:     * dialogo ("Nenhuma Observacao Foi Selecionada!", MsgAviso no
934:     * legado) de falha tecnica (cursor do chamador indisponivel,
935:     * MsgErro) - regra do projeto sobre MsgAviso vs MsgErro.
936:     *
937:     * So libera o dialogo (Release) quando ConfirmarSelecao() devolve
938:     * .T.: em caso de falha o legado "Return .F." sem fechar a tela, e
939:     * o usuario corrige a selecao e tenta de novo.
940:     *==========================================================================
941:     PROCEDURE BtnConfirmarClick()
942:         LOCAL loc_oErro, loc_lSucesso, loc_cCursor
943: 
944:         *-- Guarda de tela do legado. Fica FORA do TRY porque RETURN dentro
945:         *-- de TRY/CATCH eh proibido (regra #1). ValidarSelecao() ja faz o
946:         *-- Grade.Refresh / Select / Go Top que abre o btnConfirmar.Click
947:         *-- legado, por isso o bloco nao se repete dentro do TRY.
948:         IF !THIS.ValidarSelecao()
949:             RETURN
950:         ENDIF
951: 
952:         *-- Transfere a opcao da tela para o BO ANTES de confirmar. Fica FORA
953:         *-- do TRY pelo mesmo motivo do ValidarSelecao(): o RETURN de guarda
954:         *-- nao pode morar dentro de TRY/CATCH (regra #1). Falhando aqui nao
955:         *-- se grava nada - o separador de linhas sairia errado no texto.
956:         IF !THIS.FormParaBO()
957:             RETURN
958:         ENDIF
959: 
960:         TRY
961:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

*-- Linhas 983 a 1001:
983: 
984:                 *-- Legado: "Go Top In LocalObs / Thisform.Grade.Column1.SetFocus"
985:                 IF USED(loc_cCursor)
986:                     SELECT (loc_cCursor)
987:                     GO TOP
988:                 ENDIF
989:                 THIS.grd_4c_Dados.SetFocus()
990:             ENDIF
991:         CATCH TO loc_oErro
992:             MsgErro("Erro ao confirmar a sele" + CHR(231) + CHR(227) + "o: " + ;
993:                 loc_oErro.Message + CHR(13) + ;
994:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
995:                 "Procedure: " + loc_oErro.Procedure, ;
996:                 "Aten" + CHR(231) + CHR(227) + "o")
997:         ENDTRY
998:     ENDPROC
999: 
1000:     *==========================================================================
1001:     * GrdDadosAfterRowColChange - Legado: "ThisForm.getObs.Refresh"

*-- Linhas 1012 a 1061:
1012:     *
1013:     * Legado:
1014:     *   If Used([LocalBusLin])
1015:     *       Select LocalBusLin
1016:     *       If (ThisForm.Grade.Seleciona.Header1.Tag = [X]) ...
1017:     *   EndIf
1018:     *   ThisForm.Grade.Refresh
1019:     *
1020:     * "LocalBusLin" e o membro "Seleciona" (a Grade so tem Column1/
1021:     * Column2) NUNCA sao criados em lugar nenhum deste SCX - e vestigio
1022:     * de outro template copiado para este form. O guard USED() sempre
1023:     * falha, entao o UNICO efeito observavel, nos dois sistemas, eh o
1024:     * Refresh final. Transcrito fielmente: nada alem dele executa.
1025:     *==========================================================================
1026:     PROCEDURE HeaderSelecaoClick()
1027:         THIS.grd_4c_Dados.Refresh()
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * ChkSelecaoKeyPress - Marca/desmarca a observacao da linha corrente
1032:     *
1033:     * Este eh o metodo que de fato grava a marcacao: o MouseUp delega a ele
1034:     * com a tecla 13, e MouseDown/Click so suprimem o toggle nativo.
1035:     *
1036:     * Alterna a coluna "selecao" (N(1,0)) do cursor da lista, que eh o
1037:     * "0 as Selecao" do SELECT legado e o campo que BtnConfirmarClick le
1038:     * depois em "Locate For Selecao = 1".
1039:     *
1040:     * 13 (Enter) e 32 (Espaco) sao as teclas que o VFP usa para acionar
1041:     * CheckBox; qualquer outra sai SEM NODEFAULT, para a navegacao normal
1042:     * da grade (setas, Tab, PgDn) continuar funcionando.
1043:     *
1044:     * O cursor eh READWRITE por construcao - SIGOPinsBO.CriarCursorLista()
1045:     * usa CREATE CURSOR e a recarga eh ZAP + APPEND FROM DBF(), nunca
1046:     * SQLEXEC sobre o alias da grade. Fosse cursor de SQLEXEC, o REPLACE
1047:     * estouraria.
1048:     *
1049:     * Sem TRY/CATCH de proposito: os RETURN de guarda sao early-exit, e
1050:     * RETURN dentro de TRY eh proibido (regra #1). Nao ha operacao que
1051:     * possa lancar - as tres pre-condicoes (cursor aberto, linha valida,
1052:     * tecla certa) ja estao cobertas pelos guards.
1053:     *==========================================================================
1054:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1055:         LOCAL loc_cCursor
1056: 
1057:         IF !INLIST(par_nKeyCode, 13, 32)
1058:             RETURN
1059:         ENDIF
1060: 
1061:         loc_cCursor = "cursor_4c_Lista"

*-- Linhas 1067 a 1085:
1067:             RETURN
1068:         ENDIF
1069: 
1070:         SELECT (loc_cCursor)
1071: 
1072:         IF EOF() OR BOF()
1073:             RETURN
1074:         ENDIF
1075: 
1076:         REPLACE selecao WITH IIF(NVL(selecao, 0) = 0, 1, 0)
1077: 
1078:         THIS.grd_4c_Dados.Refresh()
1079: 
1080:         NODEFAULT
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * ChkSelecaoMouseUp - Clique do mouse sobre o CheckBox da grade
1085:     * Delega ao KeyPress com a tecla 13 (mesma marcacao do teclado) e

*-- Linhas 1158 a 1176:
1158:     * Este dialogo tem UM unico controle de entrada que nao esta ligado ao
1159:     * cursor: o chk_4c_Pular ("Pular Linhas"). Tudo o mais que o usuario mexe
1160:     * - a marcacao de cada observacao - vai DIRETO para o cursor da lista pelo
1161:     * ControlSource da Column1, entao nao ha o que transferir dali: o BO le a
1162:     * coluna "selecao" do mesmo cursor em ConfirmarSelecao(). Por isso este
1163:     * hook eh curto, e nao porque esteja incompleto.
1164:     *
1165:     * Era um bloco inline no BtnConfirmarClick; passou a metodo proprio para
1166:     * haver UM ponto de leitura da tela, que eh o que o nome do hook promete.
1167:     *
1168:     * this_lPularLinhas eh LOGICO no BO porque ConfirmarFluxoOperacao() a usa
1169:     * como condicao de IIF, e IIF com numerico estoura erro 11. O chk_4c_Pular
1170:     * nasce com .Value = .T. (transcricao do dump), mas CheckBox criado por
1171:     * AddObject assume o TIPO do que lhe for atribuido: o teste de VARTYPE
1172:     * garante property logica nos dois casos, em vez de deixar o tipo do
1173:     * controle vazar para o BO.
1174:     *
1175:     * Devolve .F. sem gravar quando o BO ou o controle nao estao disponiveis -
1176:     * seguir adiante produziria o separador de linhas errado no texto final.

*-- Linhas 1206 a 1236:
1206:     * BOParaForm - Transfere para a TELA o que o BO resolveu
1207:     *
1208:     * Legado (Init), as duas transferencias que o bloco de dados NAO faz pelo
1209:     * ControlSource do cursor:
1210:     *   ThisForm.Caption = 'Selecao de ' + Iif(<pCaption>, pCaption, 'Finalidades')
1211:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
1212:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
1213:     *   chkPular com Value = .T. (declarado no SCX)
1214:     *
1215:     * O titulo continua sendo montado por AplicarTitulo(), que delega a
1216:     * SIGOPinsBO.ObterTituloDialogo() - este hook apenas passou a ser o ponto
1217:     * UNICO por onde o estado do BO chega aos controles, em vez de o
1218:     * InicializarForm chamar cada pedaco solto.
1219:     *
1220:     * A marcacao da grade e o texto do getObs NAO entram aqui: os dois estao
1221:     * ligados ao cursor da lista por ControlSource (ver VincularGrade), entao
1222:     * quem os atualiza eh o proprio cursor, nao uma atribuicao de property.
1223:     *
1224:     * Sobre o chk_4c_Pular: o .T. que ConfigurarCheckBoxPular() atribui eh a
1225:     * transcricao fiel do dump, e o default this_lPularLinhas = .T. do BO eh o
1226:     * MESMO valor - os dois concordam por construcao, nao se contradizem.
1227:     * Reaplicar a partir do BO aqui torna o BO a fonte depois da abertura:
1228:     * numa segunda tentativa de confirmar (a primeira recusada por
1229:     * ConfirmarSelecao) a tela volta exibindo a opcao que o BO carrega, em vez
1230:     * de reverter ao default do SCX.
1231:     *==========================================================================
1232:     PROTECTED PROCEDURE BOParaForm()
1233:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1234:             RETURN .F.
1235:         ENDIF
1236: 

*-- Linhas 1314 a 1336:
1314:     *
1315:     * Legado:
1316:     *   This.Grade.RecordSource          = [LocalObs]
1317:     *   This.Grade.Column1.ControlSource = [LocalObs.Selecao]
1318:     *   This.Grade.Column2.ControlSource = [LocalObs.Descrs]
1319:     *   Go Top In LocalObs
1320:     *
1321:     * Ordem obrigatoria: RecordSource -> ControlSource -> Header1.Caption ->
1322:     * Width. Trocar a fonte da grade faz o VFP recalcular as larguras para
1323:     * o default e devolver os headers a "Header1", entao caption e largura
1324:     * sao reaplicados DEPOIS do bind, com a largura por ultimo.
1325:     *
1326:     * Sparse e CurrentControl sao reafirmados aqui porque sem eles o
1327:     * CheckBox da Column1 deixa de ser desenhado (ou aparece so na linha
1328:     * corrente) - e a reafirmacao eh barata.
1329:     *
1330:     * Fecha com GO TOP + Refresh: popular o cursor NAO repinta a grade
1331:     * sozinho, e sem isso a tela abre visualmente vazia com o cursor cheio.
1332:     *==========================================================================
1333:     PROCEDURE VincularGrade()
1334:         LOCAL loc_oGrade, loc_cCursor, loc_lSucesso
1335: 
1336:         loc_lSucesso = .F.

*-- Linhas 1353 a 1394:
1353: 
1354:         loc_oGrade.RecordSource = loc_cCursor
1355: 
1356:         loc_oGrade.Column1.ControlSource = loc_cCursor + ".selecao"
1357:         loc_oGrade.Column2.ControlSource = loc_cCursor + ".descrs"
1358: 
1359:         loc_oGrade.Column1.Header1.Caption = ""
1360:         loc_oGrade.Column2.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"
1361: 
1362:         loc_oGrade.Column1.Sparse = .F.
1363:         IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
1364:             loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
1365:         ENDIF
1366: 
1367:         *-- Largura por ULTIMO (o bind acima a devolve para o default)
1368:         loc_oGrade.Column1.Width = 23
1369:         loc_oGrade.Column2.Width = 562
1370: 
1371:         *-- Legado: "This.getObs.ControlSource = [LocalObs.Observas]", na
1372:         *-- MESMA sequencia e no MESMO cursor da grade - eh o que faz o campo
1373:         *-- acompanhar a linha corrente. Fica aqui, e nao em
1374:         *-- ConfigurarCampoObservacao, porque ali o cursor ainda nao existe.
1375:         IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
1376:             THIS.obj_4c_GetObs.ControlSource = loc_cCursor + ".observas"
1377:         ENDIF
1378: 
1379:         SELECT (loc_cCursor)
1380:         GO TOP
1381:         loc_oGrade.Refresh()
1382: 
1383:         *-- Popular o cursor NAO repinta o campo ligado a ele: sem este
1384:         *-- Refresh o texto da 1a linha nao aparece ao abrir a tela. Eh o
1385:         *-- "This.Refresh" + "ThisForm.Grade.AfterRowColChange()" com que o
1386:         *-- Init legado fecha.
1387:         IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
1388:             THIS.obj_4c_GetObs.Refresh()
1389:         ENDIF
1390: 
1391:         loc_lSucesso = .T.
1392: 
1393:         RETURN loc_lSucesso
1394:     ENDPROC

*-- Linhas 1475 a 1494:
1475:     *==========================================================================
1476:     * Destroy - Equivalente ao Release do legado:
1477:     *   This.Grade.RecordSource          = []
1478:     *   This.Grade.Column1.ControlSource = []
1479:     *   This.Grade.Column2.ControlSource = []
1480:     *   Use In LocalObs
1481:     *
1482:     * Desliga o bind da grade ANTES de fechar o cursor da lista, para o VFP nao
1483:     * ficar com alias preso ao RecordSource. O PEMSTATUS cerca a grade porque o
1484:     * Destroy tambem roda quando o Init falhou antes de ela existir.
1485:     *
1486:     * Fecha SO os cursores deste dialogo. Os cursores do formulario CHAMADOR
1487:     * (crSigOpFnl, TprMvCab, crTpmMvItn) chegam abertos e continuam abertos -
1488:     * fecha-los aqui destruiria o trabalho de quem abriu a tela.
1489:     *
1490:     * USE IN fecha o alias mesmo com buffer sujo, entao nao ha TABLEREVERT:
1491:     * sem buffering ligado ele dispararia erro 1586.
1492:     *==========================================================================
1493:     PROCEDURE Destroy()
1494:         LOCAL loc_cLista, loc_cSelecionadas, loc_cGrupo, loc_cOperacao, loc_cProduto

*-- Linhas 1501 a 1519:
1501:         *-- o bind dele tambem sai ANTES do USE IN. O legado nao precisava
1502:         *-- disso porque a tela morria junto com a datasession do chamador.
1503:         IF PEMSTATUS(THIS, "obj_4c_GetObs", 5)
1504:             THIS.obj_4c_GetObs.ControlSource = ""
1505:         ENDIF
1506: 
1507:         loc_cLista        = "cursor_4c_Lista"
1508:         loc_cSelecionadas = "cursor_4c_Selecionadas"
1509:         loc_cGrupo        = "cursor_4c_Grupo"
1510:         loc_cOperacao     = "cursor_4c_Operacao"
1511:         loc_cProduto      = "cursor_4c_Produto"
1512: 
1513:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1514:             loc_cLista        = THIS.this_oBusinessObject.this_cCursorLista
1515:             loc_cSelecionadas = THIS.this_oBusinessObject.this_cCursorSelecionadas
1516:             loc_cGrupo        = THIS.this_oBusinessObject.this_cCursorGrupo
1517:             loc_cOperacao     = THIS.this_oBusinessObject.this_cCursorOperacao
1518:             loc_cProduto      = THIS.this_oBusinessObject.this_cCursorProduto
1519: 


### BO (C:\4c\projeto\app\classes\SIGOPinsBO.prg):
*====================================================================
* SIGOPinsBO.prg
*
* Business Object para FormSIGOPins
* Origem legado: SIGOPins.SCX - dialogo "Selecao de Finalidades"
* Tipo de formulario: OPERACIONAL (dialogo de selecao, WindowType = 1)
*
* Tabela principal   : SigCdObs (codigos numeric(3,0) = chave primaria)
* Tabelas auxiliares : SigOpFnl (finalidades do grupo/item)
*                      SigCdOpe (faixa de observacoes e padrao da operacao)
*                      SigCdPro (grupo do produto, no fluxo ITN)
*
* Arquitetura em camadas: FormSIGOPins -> SIGOPinsBO -> SQL Server
*
* FASE 1 DE 8: declaracao de TODAS as propriedades + Init()
*====================================================================

DEFINE CLASS SIGOPinsBO AS BusinessBase

	*-----------------------------------------------------------------
	* Colunas de SigCdObs (entidade principal)
	* codigos    numeric(3,0) NOT NULL - chave primaria
	* observas   text NULL
	* descrs     char(80) NOT NULL
	* comiss     numeric(1,0) NOT NULL
	* classifs   numeric(1,0) NOT NULL
	* grupos     char(10) NOT NULL
	* agrupas    char(10) NOT NULL
	* movautdop  char(20) NOT NULL
	*-----------------------------------------------------------------
	this_nCodigos    = 0
	this_cObservas   = ""
	this_cDescrs     = ""
	this_nComiss     = 0
	this_nClassifs   = 0
	this_cGrupos     = ""
	this_cAgrupas    = ""
	this_cMovautdop  = ""

	*-----------------------------------------------------------------
	* Coluna calculada da lista (legado: "Select 0 as Selecao, ...")
	* Marca de selecao da linha na grade - 1 = selecionada, 0 = nao
	*-----------------------------------------------------------------
	this_nSelecao    = 0

	*-----------------------------------------------------------------
	* Colunas de SigOpFnl (vinculo finalidade x grupo/item)
	* cidchaves   char(20) NOT NULL - chave primaria (fUniqueIds)
	* codigos     numeric(3,0) NOT NULL - aponta para SigCdObs.codigos
	* codutil     char(20) NOT NULL - grupo (GRP) ou item (ITN)
	* empdopnums  char(29) NOT NULL - chave posicional Emps+Dopes+Numes
	* operacao    char(3) NOT NULL - "GRP" ou "ITN"
	*-----------------------------------------------------------------
	this_cCidchaves  = ""
	this_cCodutil    = ""
	this_cEmpdopnums = ""
	this_cOperacao   = ""

	*-----------------------------------------------------------------
	* Colunas de SigCdOpe lidas no fluxo de operacao (sem lista)
	* dopes     char(20) NOT NULL - chave primaria da operacao
	* obspads   numeric(3,0) NOT NULL - observacao padrao
	* obsinis   numeric(3,0) NOT NULL - inicio da faixa
	* obsfins   numeric(3,0) NOT NULL - fim da faixa
	*-----------------------------------------------------------------
	this_cDopes      = ""
	this_nObspads    = 0
	this_nObsinis    = 0
	this_nObsfins    = 0

	*-----------------------------------------------------------------
	* Colunas de SigCdPro usadas no fluxo ITN (grupo do produto)
	* cgrus char(10) / cpros char(14)
	*-----------------------------------------------------------------
	this_cCgrus      = ""
	this_cCpros      = ""

	*-----------------------------------------------------------------
	* Parametros recebidos do formulario chamador
	* Legado: Init(pCnx, pLista, pTipo, pCaption, pEdn) que publicava
	* pcLista / pcTipo / pcChv / pcEDN como variaveis PUBLIC.
	* Aqui viram propriedades do BO (PILAR 3 - sem variavel global).
	*-----------------------------------------------------------------
	this_cLista      = ""
	this_cTipo       = ""
	this_cChave      = ""
	this_cEdn        = ""
	this_cTitulo     = ""

	*-----------------------------------------------------------------
	* Estado do dialogo
	* this_lModoFinalidades reproduz Vartype(pcLista) = "C" do legado:
	*   .T. = selecao de FINALIDADES (lista recebida do chamador)
	*   .F. = selecao de OBSERVACOES da operacao (faixa de SigCdOpe)
	* this_lListaInformada guarda se o parametro pLista chegou, porque
	* lista VAZIA ("") ainda eh modo FINALIDADES no legado.
	* this_lTipoInformado reproduz Vartype(pcTipo) = "C", que no legado
	* separa o fluxo SIGOPINF (sem tipo) dos fluxos GRP e ITN.
	*-----------------------------------------------------------------
	this_lModoFinalidades = .F.
	this_lListaInformada  = .F.
	this_lTipoInformado   = .F.

	*-----------------------------------------------------------------
	* Faixa de observacoes aplicada ao SELECT da lista
	* Legado: pIni / pFim (0..999 no modo finalidades; obsinis/obsfins
	* de SigCdOpe no modo operacao)
	*-----------------------------------------------------------------
	this_nFaixaInicial = 0
	this_nFaixaFinal   = 999

	*-----------------------------------------------------------------
	* Observacao padrao marcada automaticamente na abertura
	* Legado: lcObsPads (-1 no modo finalidades = nao marca nada;
	* LocalOpe.ObsPads no modo operacao)
	*-----------------------------------------------------------------
	this_nObsPadrao  = -1

	*-----------------------------------------------------------------
	* Resultado devolvido ao formulario chamador
	* this_cListaSelecionadas reproduz a PUBLIC listaObs do legado,
	* no formato ",1,7,23," consumido pelo SIGOPINF.
	* this_cTextoObservacoes acumula o texto gravado em TprMvCab.obses.
	*-----------------------------------------------------------------
	this_cListaSelecionadas = ""
	this_cTextoObservacoes  = ""
	this_lConfirmado        = .F.
	this_lPularLinhas       = .T.

	*-----------------------------------------------------------------
	* Cursores proprios do dialogo (nomenclatura nova - PILAR 3)
	* this_cCursorLista        <- LocalObs  (grade de observacoes)
	* this_cCursorSelecionadas <- CrObs     (ja associadas)
	* this_cCursorGrupo        <- CrGRP     (finalidades do grupo)
	* this_cCursorOperacao     <- LocalOpe  (faixa de SigCdOpe)
	* this_cCursorProduto      <- crPro     (grupo do produto)
	*-----------------------------------------------------------------
	this_cCursorLista        = "cursor_4c_Lista"
	this_cCursorSelecionadas = "cursor_4c_Selecionadas"
	this_cCursorGrupo        = "cursor_4c_Grupo"
	this_cCursorOperacao     = "cursor_4c_Operacao"
	this_cCursorProduto      = "cursor_4c_Produto"

	*-----------------------------------------------------------------
	* Cursores do formulario CHAMADOR - os nomes sao CONTRATO com o
	* legado e NAO podem ser renomeados: quem abre este dialogo ja os
	* tem abertos e espera que a gravacao aconteca neles.
	*-----------------------------------------------------------------
	this_cCursorFinalidades  = "crSigOpFnl"
	this_cCursorItemOperacao = "crTpmMvItn"
	this_cCursorCabecalho    = "TprMvCab"
	this_cCursorGrupoPai     = "crSigCdGrp"

	*-----------------------------------------------------------------
	* Mensagem da ultima falha de processamento deste BO
	* this_lFalhaValidacao distingue o UNICO caso de validacao deste BO
	* ("Nenhuma Observacao Foi Selecionada!", MsgAviso no legado) de uma
	* falha tecnica (cursor do chamador indisponivel), que o Form exibe
	* com MsgErro - mesma distincao da regra do projeto sobre MsgAviso
	* vs MsgErro.
	*-----------------------------------------------------------------
	this_cMensagemFalha  = ""
	this_lFalhaValidacao = .F.

	*====================================================================
	* Init - Inicializa o Business Object
	*
	* par_cLista  : lista de codigos ja selecionados (",1,7," ou "")
	*               quando CARACTERE, ativa o modo FINALIDADES
	* par_cTipo   : "GRP" (grupo), "ITN" (item) ou ausente (operacao)
	* par_cTitulo : complemento do titulo do dialogo
	* par_cEdn    : chave Emps+Dopes+Numes (char(29)) da operacao
	*
	* Os quatro parametros sao OPCIONAIS - o dialogo eh aberto tanto pelo
	* menu (sem argumento) quanto pelos formularios SIGOPINF/SIGOPPRO e
	* pelo cadastro de grupos. PCOUNT() distingue argumento AUSENTE de
	* argumento vazio, porque lista vazia continua sendo modo
	* FINALIDADES no legado (Vartype(pcLista) = "C" com pcLista = "").
	*
	* NUNCA retorna .F.: Init de BO que devolve falso mata a abertura do
	* formulario. Falha de parametro fica em this_cMensagemFalha para o
	* Form tratar.
	*====================================================================
	PROCEDURE Init(par_cLista, par_cTipo, par_cTitulo, par_cEdn)
		LOCAL loc_nArgumentos, loc_oErro

		DODEFAULT()

		*-- Nomes EXATOS do banco (PILAR 2) - nao renomear
		THIS.this_cTabela     = "SigCdObs"
		THIS.this_cCampoChave = "codigos"

		loc_nArgumentos = PCOUNT()

		TRY
			*-- Reproduz os PUBLIC pcLista / pcTipo / pcChv / pcEDN
			THIS.this_lListaInformada = (loc_nArgumentos >= 1 AND VARTYPE(par_cLista) = "C")
			THIS.this_cLista = IIF(THIS.this_lListaInformada, par_cLista, "")

			THIS.this_lTipoInformado = (loc_nArgumentos >= 2 AND VARTYPE(par_cTipo) = "C")
			THIS.this_cTipo = IIF(THIS.this_lTipoInformado, UPPER(ALLTRIM(par_cTipo)), "")

			*-- pcChv eh montado durante o processamento (item/grupo)
			THIS.this_cChave = ""

			*-- pcEDN = Iif(Type([pEdn]) = [C], pEdn, [])
			THIS.this_cEdn = IIF(loc_nArgumentos >= 4 AND VARTYPE(par_cEdn) = "C", par_cEdn, "")

			*-- Caption = "Selecao de " + Iif(<pCaption informado>, pCaption, "Finalidades")
			IF loc_nArgumentos >= 3 AND VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
				THIS.this_cTitulo = ALLTRIM(par_cTitulo)
			ELSE
				THIS.this_cTitulo = "Finalidades"
			ENDIF

			*-- Modo de operacao: lista informada = FINALIDADES
			THIS.this_lModoFinalidades = THIS.this_lListaInformada

			*-- Faixa e padrao conforme o modo
			IF THIS.this_lModoFinalidades
				*-- Legado: Where Codigos BetWeen 0 And 999 / lcObsPads = -1
				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = -1
			ELSE
				*-- No modo operacao a faixa real vem de SigCdOpe.obsinis /
				*-- obsfins na carga; estes sao os defaults do legado.
				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = 0
			ENDIF

			*-- Estado inicial dos campos da entidade
			THIS.this_nCodigos           = 0
			THIS.this_cObservas          = ""
			THIS.this_cDescrs            = ""
			THIS.this_nComiss            = 0
			THIS.this_nClassifs          = 0
			THIS.this_cGrupos            = ""
			THIS.this_cAgrupas           = ""
			THIS.this_cMovautdop         = ""
			THIS.this_nSelecao           = 0

			*-- Estado inicial do vinculo SigOpFnl
			THIS.this_cCidchaves         = ""
			THIS.this_cCodutil           = ""
			THIS.this_cEmpdopnums        = THIS.this_cEdn
			THIS.this_cOperacao          = THIS.this_cTipo

			*-- Estado inicial dos auxiliares
			THIS.this_cDopes             = ""
			THIS.this_nObspads           = 0
			THIS.this_nObsinis           = 0
			THIS.this_nObsfins           = 0
			THIS.this_cCgrus             = ""
			THIS.this_cCpros             = ""

			*-- Estado inicial do resultado
			THIS.this_cListaSelecionadas = ""
			THIS.this_cTextoObservacoes  = ""
			THIS.this_lConfirmado        = .F.
			THIS.this_lPularLinhas       = .T.
			THIS.this_cMensagemFalha     = ""
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao inicializar a sele" + CHR(231) + CHR(227) + ;
				"o de finalidades: " + loc_oErro.Message
			MsgAviso(THIS.this_cMensagemFalha, "Aten" + CHR(231) + CHR(227) + "o")
		ENDTRY

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterTituloDialogo - Monta o Caption do dialogo
	* Legado: "Selecao de " + Iif(<pCaption>, pCaption, "Finalidades")
	* Usado pelo Form no Caption e nos dois labels do cabecalho.
	*====================================================================
	PROCEDURE ObterTituloDialogo()
		RETURN "Sele" + CHR(231) + CHR(227) + "o de " + ;
			IIF(EMPTY(THIS.this_cTitulo), "Finalidades", ALLTRIM(THIS.this_cTitulo))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega uma linha de SigCdObs para as properties
	*
	* O legado nunca le SigCdObs registro a registro por fora da grade
	* (a propria SELECT do Init ja devolve Codigos/Observas/Descrs prontos
	* para o cursor LocalObs). Este metodo existe para o uso generico de
	* BusinessBase - uma futura consulta por codigo unico de observacao
	* (equivalente a "SELECT * FROM SigCdObs WHERE codigos = ?") - e por
	* isso mapeia TODAS as colunas da tabela, nao so as quatro da grade.
	*
	* par_cAliasCursor: alias de um cursor aberto com as colunas de
	* SigCdObs (codigos, observas, descrs, comiss, classifs, grupos,
	* agrupas, movautdop). "selecao" eh coluna calculada so na grade
	* LocalObs/cursor_4c_Lista - carregada apenas quando presente.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF !USED(par_cAliasCursor)
			RETURN loc_lResultado
		ENDIF

		SELECT (par_cAliasCursor)

		IF EOF()
			RETURN loc_lResultado
		ENDIF

		THIS.this_nCodigos   = TratarNulo(codigos, 0)
		THIS.this_cObservas  = TratarNulo(observas, "")
		THIS.this_cDescrs    = TratarNulo(descrs, "")
		THIS.this_nComiss    = TratarNulo(comiss, 0)
		THIS.this_nClassifs  = TratarNulo(classifs, 0)
		THIS.this_cGrupos    = TratarNulo(grupos, "")
		THIS.this_cAgrupas   = TratarNulo(agrupas, "")
		THIS.this_cMovautdop = TratarNulo(movautdop, "")

		IF TYPE(par_cAliasCursor + ".selecao") != "U"
			THIS.this_nSelecao = TratarNulo(selecao, 0)
		ENDIF

		loc_lResultado = .T.
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CriarCursorLista - Cria o cursor que a grade do dialogo exibe
	*
	* Equivalente estrutural do LocalObs do legado, que nasce da SELECT
	* "Select 0 as Selecao, Codigos, Observas, Descrs From SigCdObs".
	*
	* A estrutura mora AQUI, num lugar so, de proposito: o Form cria este
	* mesmo cursor ANTES de ligar a grade (sem cursor aberto,
	* Column.ControlSource derruba o Init) e o recarregamento eh feito com
	* ZAP + APPEND FROM DBF(), que casa as colunas por NOME - estrutura
	* mais estreita que a SELECT descartaria coluna em silencio.
	*
	* Tipos conferidos em docs\schema.sql (SigCdObs):
	*   codigos  numeric(3,0) NOT NULL -> N(3,0)
	*   observas text NULL             -> M  (pode chegar NULL: SET NULL ON)
	*   descrs   char(80) NOT NULL     -> C(80)
	* selecao eh coluna de TRABALHO da grade ("0 as Selecao" no legado),
	* nao existe em SigCdObs.
	*====================================================================
	PROCEDURE CriarCursorLista()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF !USED(THIS.this_cCursorLista)
				SET NULL ON
				CREATE CURSOR (THIS.this_cCursorLista) ;
					(selecao N(1,0), codigos N(3,0), observas M, descrs C(80))
				SET NULL OFF
			ENDIF

			loc_lSucesso = USED(THIS.this_cCursorLista)
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao criar a lista de observa" + ;
				CHR(231) + CHR(245) + "es: " + loc_oErro.Message
			MsgAviso(THIS.this_cMensagemFalha, "Aten" + CHR(231) + CHR(227) + "o")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarListaObservacoes - Reproduz TODO o carregamento do Init
	* legado (SIGOPINS.Init), que tem dois fluxos exclusivos:
	*
	*   Vartype(pcLista) = "C"  -> FINALIDADES: faixa fixa 0..999, mais a
	*       marcacao das observacoes ja associadas, cuja origem varia com
	*       pcTipo (ausente = SIGOPINF, "GRP" = cadastro de grupos,
	*       "ITN" = itens da operacao).
	*   senao -> OBSERVACOES DA OPERACAO: a faixa sai de SigCdOpe
	*       (ObsInis/ObsFins) e ObsPads vira a observacao marcada por
	*       padrao.
	*
	* Fecha com a marcacao do padrao, que no legado eh
	* "Update LocalObs Set Selecao = 1 Where Codigos = lcObsPads" - em
	* modo FINALIDADES lcObsPads vale -1 e nao casa com nada, por isso a
	* chamada eh incondicional nos dois fluxos.
	*
	* O GO TOP e o Refresh da grade NAO moram aqui: sao do Form, que eh
	* quem conhece a grade (e repintar grade eh obrigacao de quem exibe).
	*====================================================================
	PROCEDURE CarregarListaObservacoes()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemFalha = ""

		TRY
			IF !THIS.CriarCursorLista()
				THIS.this_cMensagemFalha = "Lista de observa" + CHR(231) + CHR(245) + ;
					"es indispon" + CHR(237) + "vel."
			ELSE
				IF THIS.this_lModoFinalidades
					loc_lSucesso = THIS.CarregarFluxoFinalidades()
				ELSE
					loc_lSucesso = THIS.CarregarFluxoOperacao()
				ENDIF

				IF loc_lSucesso
					THIS.MarcarObservacaoPadrao()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao carregar as observa" + CHR(231) + ;
				CHR(245) + "es: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarFluxoFinalidades - Ramo "Vartype(pcLista) = C" do Init
	*
	* 1) faixa fixa 0..999 de SigCdObs  -> cursor da grade
	* 2) cursor das JA ASSOCIADAS, conforme pcTipo
	* 3) marcacao (SCAN/LOCATE/REPLACE do legado)
	* 4) lcObsPads = -1 (nao marca padrao nenhum)
	*====================================================================
	PROTECTED PROCEDURE CarregarFluxoFinalidades()
		LOCAL loc_lSucesso

		loc_lSucesso = THIS.CarregarObservacoesFaixa(0, 999)

		IF loc_lSucesso
			DO CASE
				CASE !THIS.this_lTipoInformado
					*-- SIGOPINF: as associadas vem da propria lista recebida
					loc_lSucesso = THIS.CarregarSelecionadasDaLista()

				CASE THIS.this_cTipo == "GRP"
					*-- Cadastro de grupos: "Select * from crSigOpFnl into cursor crObs"
					loc_lSucesso = THIS.CarregarSelecionadasDoGrupo()

				CASE THIS.this_cTipo == "ITN"
					*-- Itens da operacao: restringe a lista ao grupo do produto
					*-- e le as associadas do item corrente
					loc_lSucesso = THIS.CarregarSelecionadasDoItem()

				OTHERWISE
					*-- pcTipo informado com valor fora de GRP/ITN: o legado nao
					*-- entra em nenhum dos tres IFs e segue sem cursor de
					*-- associadas, ou seja nada fica pre-marcado.
					loc_lSucesso = .T.
			ENDCASE
		ENDIF

		IF loc_lSucesso
			THIS.MarcarSelecionadas()
			THIS.this_nObsPadrao = -1
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarFluxoOperacao - Ramo ELSE do Init legado
	*
	* Le ObsPads/ObsInis/ObsFins de SigCdOpe pela operacao do cabecalho e
	* carrega SigCdObs dentro dessa faixa. ObsPads vira a observacao
	* marcada por padrao.
	*====================================================================
	PROTECTED PROCEDURE CarregarFluxoOperacao()
		LOCAL loc_lSucesso

		loc_lSucesso = THIS.CarregarFaixaOperacao()

		IF loc_lSucesso
			loc_lSucesso = THIS.CarregarObservacoesFaixa(THIS.this_nFaixaInicial, ;
				THIS.this_nFaixaFinal)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarObservacoesFaixa - SELECT de SigCdObs na faixa informada
	*
	* Legado: [Select 0 as Selecao, Codigos, Observas, Descrs ] +
	*         [From SigCdObs ] + [Where Codigos BetWeen ... ] +
	*         [Order By Codigos]
	*
	* O SQLEXEC vai para cursor TEMPORARIO e o cursor da grade eh
	* recarregado com ZAP + APPEND FROM DBF(): SQLEXEC sobre o alias
	* ligado a grade FECHA e RECRIA o alias, zerando o ColumnCount (a
	* grade viraria um retangulo branco) e perdendo o CurrentControl do
	* CheckBox da Column1.
	*====================================================================
	PROTECTED PROCEDURE CarregarObservacoesFaixa(par_nInicial, par_nFinal)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTemp

		loc_lSucesso = .F.
		loc_cTemp    = "cursor_4c_ListaTmp"

		loc_cSQL = "SELECT 0 AS selecao, codigos, observas, descrs" + ;
			" FROM SigCdObs" + ;
			" WHERE codigos BETWEEN " + FormatarNumeroSQL(par_nInicial, 0) + ;
			" AND " + FormatarNumeroSQL(par_nFinal, 0) + ;
			" ORDER BY codigos"

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
		ELSE
			THIS.LimparCursorLista()

			SELECT (THIS.this_cCursorLista)
			APPEND FROM DBF(loc_cTemp)

			loc_lSucesso = .T.
		ENDIF

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDaLista - Fluxo SIGOPINF (pcTipo ausente)
	*
	* Legado:
	*   lcLista = ALLTRIM(pcLista)
	*   lcWhere = IIF(EMPTY(lcLista),' < 0 ', 'in ('+SUBSTR(lclista,2,LEN(lclista)-2)+') ')
	*   [Select Codigos From SigCdObs Where Codigos ] + lcWhere
	*
	* A lista chega do form chamador no formato ",1,7," - o SUBSTR tira a
	* primeira e a ultima virgula. Lista vazia vira "< 0", que nao casa
	* com codigo nenhum (nada pre-marcado), e eh assim de proposito.
	*
	* O CHRTRAN confere que sobraram SO digitos, virgulas e espacos antes
	* de concatenar: a lista vem de outro formulario, e conteudo
	* inesperado produziria SQL invalido em vez de "nada selecionado".
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDaLista()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.
		loc_cWhere   = THIS.MontarWhereLista()

		loc_cSQL = "SELECT codigos FROM SigCdObs WHERE codigos" + loc_cWhere

		IF USED(THIS.this_cCursorSelecionadas)
			USE IN (THIS.this_cCursorSelecionadas)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSelecionadas)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
		ELSE
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarWhereLista - Monta o predicado do IN a partir da lista recebida
	*
	* Legado:
	*   lcLista = ALLTRIM(pcLista)
	*   lcWhere = IIF(EMPTY(lcLista),' < 0 ', 'in ('+SUBSTR(lclista,2,LEN(lclista)-2)+') ')
	*
	* Lista vazia (ou curta demais para ter conteudo entre as virgulas)
	* devolve " < 0 ", que nao casa com codigo nenhum: eh assim que o
	* legado representa "nada pre-selecionado".
	*
	* O CHRTRAN confere que sobraram SO digitos, virgulas e espacos antes
	* de concatenar. A lista vem de outro formulario; conteudo inesperado
	* geraria SQL invalido em vez de "nada selecionado".
	*====================================================================
	PROTECTED PROCEDURE MontarWhereLista()
		LOCAL loc_cLista, loc_cItens, loc_cWhere

		loc_cLista = ALLTRIM(THIS.this_cLista)
		loc_cWhere = " < 0 "

		IF !EMPTY(loc_cLista) AND LEN(loc_cLista) > 2
			loc_cItens = SUBSTR(loc_cLista, 2, LEN(loc_cLista) - 2)

			IF !EMPTY(ALLTRIM(loc_cItens)) AND EMPTY(CHRTRAN(loc_cItens, "0123456789, ", ""))
				loc_cWhere = " IN (" + loc_cItens + ") "
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDoGrupo - Fluxo pcTipo = "GRP"
	* Legado: SELECT * from crSigOpFnl into cursor crObs
	*
	* crSigOpFnl eh cursor do formulario CHAMADOR (property
	* this_cCursorFinalidades) e chega JA ABERTO - aqui so se copia o
	* conteudo dele, nunca se fecha nem se grava.
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDoGrupo()
		LOCAL loc_lSucesso, loc_cOrigem, loc_cDestino

		loc_lSucesso = .F.
		loc_cOrigem  = THIS.this_cCursorFinalidades
		loc_cDestino = THIS.this_cCursorSelecionadas

		IF !USED(loc_cOrigem)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cOrigem + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + ;
				CHR(225) + "rio chamador."
		ELSE
			IF USED(loc_cDestino)
				USE IN (loc_cDestino)
			ENDIF

			SELECT codigos FROM (loc_cOrigem) INTO CURSOR (loc_cDestino) READWRITE

			loc_lSucesso = USED(loc_cDestino)
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSelecionadasDoItem - Fluxo pcTipo = "ITN" (SIGOPPRO)
	*
	* Legado:
	*   pcEDN = crTpmMvItn.Emps + crTpmMvItn.Dopes + str(crTpmMvItn.Numes,6)
	*   pcChv = str(crTpmMvItn.citens,6)
	*   [Select Cgrus From SigCdPro Where cpros = '<cpros>']           -> crPro
	*   [Select * From sigopFnl Where operacao = 'GRP' and codutil = '<cgrus>'] -> CrGRP
	*   Select Distinct ... from localObs a, crGRP b where a.codigos = b.codigos
	*   Select * From crSigopFnl Where codutil = pcChv                 -> crObs
	*
	* EmpDopNums eh chave POSICIONAL char(29) = Emps char(3) + Dopes
	* char(20) + Str(Numes,6): o padding FAZ PARTE da chave, por isso
	* PADR explicito e NUNCA ALLTRIM nas partes.
	*====================================================================
	PROTECTED PROCEDURE CarregarSelecionadasDoItem()
		LOCAL loc_lSucesso, loc_cItem, loc_cSQL, loc_nResultado
		LOCAL loc_cCgrus, loc_cChave, loc_cOrigem, loc_cDestino

		loc_lSucesso = .F.
		loc_cItem    = THIS.this_cCursorItemOperacao
		loc_cOrigem  = THIS.this_cCursorFinalidades
		loc_cDestino = THIS.this_cCursorSelecionadas

		IF !USED(loc_cItem)
			THIS.this_cMensagemFalha = "Cursor de itens (" + loc_cItem + ") n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		IF !USED(loc_cOrigem)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cOrigem + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + ;
				CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (loc_cItem)

		THIS.this_cEdn = PADR(TratarNulo(Emps, ""), 3) + ;
			PADR(TratarNulo(Dopes, ""), 20) + ;
			STR(TratarNulo(Numes, 0), 6)
		THIS.this_cEmpdopnums = THIS.this_cEdn
		THIS.this_cChave      = STR(TratarNulo(citens, 0), 6)
		THIS.this_cCpros      = TratarNulo(Cpros, "")

		*-- Grupo do produto do item corrente
		loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + ;
			EscaparSQL(THIS.this_cCpros)

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				CapturarErroSQL()
			RETURN loc_lSucesso
		ENDIF

		SELECT (THIS.this_cCursorProduto)
		loc_cCgrus = IIF(EOF(), "", ALLTRIM(TratarNulo(cgrus, "")))
		THIS.this_cCgrus = loc_cCgrus

		*-- Finalidades cadastradas para o grupo do produto
		loc_cSQL = "SELECT cidchaves, codigos, codutil, empdopnums, operacao" + ;
			" FROM SigOpFnl" + ;
			" WHERE operacao = " + EscaparSQL("GRP") + ;
			" AND codutil = " + EscaparSQL(loc_cCgrus)

		IF USED(THIS.this_cCursorGrupo)
			USE IN (THIS.this_cCursorGrupo)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorGrupo)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				"(SigOpFnl)" + CHR(13) + CapturarErroSQL()
			RETURN loc_lSucesso
		ENDIF

		IF !THIS.RestringirListaAoGrupo()
			RETURN loc_lSucesso
		ENDIF

		*-- Finalidades ja associadas AO ITEM corrente
		loc_cChave = THIS.this_cChave

		IF USED(loc_cDestino)
			USE IN (loc_cDestino)
		ENDIF

		SELECT codigos FROM (loc_cOrigem) ;
			WHERE codutil = m.loc_cChave ;
			INTO CURSOR (loc_cDestino) READWRITE

		loc_lSucesso = USED(loc_cDestino)

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestringirListaAoGrupo - Mantem na grade so as observacoes que
	* pertencem ao grupo do produto (fluxo ITN).
	*
	* Legado: "Select Distinct a.Selecao, a.Codigos, Left(a.Observas,100)
	* as Observas, a.Descrs from localObs a, crGRP b where a.codigos =
	* b.codigos into cursor localObs READWRITE".
	*
	* Duas diferencas deliberadas, ambas sem efeito no resultado:
	* (a) o legado RECRIA o cursor; aqui ele eh repopulado com ZAP +
	*     APPEND FROM DBF() para o alias continuar VIVO - recriar o alias
	*     ligado a grade reseta Column.Width e Header1.Caption.
	* (b) o Left(...,100) do legado existe porque DISTINCT nao aceita
	*     campo memo; sem o DISTINCT (codigos eh chave de SigCdObs, logo
	*     uma linha por codigo ja eh unica) o texto completo eh
	*     preservado - que eh o que a caixa de observacao exibe.
	*====================================================================
	PROTECTED PROCEDURE RestringirListaAoGrupo()
		LOCAL loc_cTemp, loc_cLista, loc_cGrupo, loc_lSucesso
		LOCAL loc_nCodigo, loc_nSelecao, loc_cObservas, loc_cDescrs, loc_lAchou

		loc_lSucesso = .F.
		loc_cTemp    = "cursor_4c_ListaTmp"
		loc_cLista   = THIS.this_cCursorLista
		loc_cGrupo   = THIS.this_cCursorGrupo

		IF !USED(loc_cLista) OR !USED(loc_cGrupo)
			THIS.this_cMensagemFalha = "Cursores da sele" + CHR(231) + CHR(227) + ;
				"o por grupo indispon" + CHR(237) + "veis."
			RETURN loc_lSucesso
		ENDIF

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		SET NULL ON
		CREATE CURSOR (loc_cTemp) ;
			(selecao N(1,0), codigos N(3,0), observas M, descrs C(80))
		SET NULL OFF

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nSelecao  = selecao
			loc_nCodigo   = codigos
			loc_cObservas = observas
			loc_cDescrs   = descrs

			SELECT (loc_cGrupo)
			LOCATE FOR codigos = loc_nCodigo
			loc_lAchou = FOUND()

			IF loc_lAchou
				SELECT (loc_cTemp)
				APPEND BLANK
				REPLACE selecao  WITH loc_nSelecao, ;
						codigos  WITH loc_nCodigo, ;
						observas WITH loc_cObservas, ;
						descrs   WITH loc_cDescrs
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		THIS.LimparCursorLista()

		SELECT (loc_cLista)
		APPEND FROM DBF(loc_cTemp)

		IF USED(loc_cTemp)
			USE IN (loc_cTemp)
		ENDIF

		loc_lSucesso = .T.

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MarcarSelecionadas - Pre-marca na grade o que ja esta associado
	*
	* Legado:
	*   SELECT crObs / GO top / SCAN
	*       SELECT localObs / LOCATE for codigos = crObs.codigos
	*       IF FOUND() / replace selecao with 1 / ENDIF
	*       SELECT crObs
	*   ENDSCAN
	*
	* O SELECT do cursor de origem no FIM do corpo do SCAN eh o que faz o
	* ENDSCAN avancar o ponteiro certo - sem ele o laco nunca termina.
	*====================================================================
	PROTECTED PROCEDURE MarcarSelecionadas()
		LOCAL loc_cOrigem, loc_cLista, loc_nCodigo, loc_nMarcadas

		loc_cOrigem  = THIS.this_cCursorSelecionadas
		loc_cLista   = THIS.this_cCursorLista
		loc_nMarcadas = 0

		IF !USED(loc_cOrigem) OR !USED(loc_cLista)
			RETURN loc_nMarcadas
		ENDIF

		SELECT (loc_cOrigem)
		GO TOP
		SCAN
			loc_nCodigo = TratarNulo(codigos, -1)

			SELECT (loc_cLista)
			LOCATE FOR codigos = loc_nCodigo
			IF FOUND()
				REPLACE selecao WITH 1
				loc_nMarcadas = loc_nMarcadas + 1
			ENDIF

			SELECT (loc_cOrigem)
		ENDSCAN

		RETURN loc_nMarcadas
	ENDPROC

	*====================================================================
	* CarregarFaixaOperacao - Ramo ELSE do Init legado
	*
	* Legado:
	*   [Select ObsPads, ObsInis, ObsFins From SigCdOpe Where Dopes = '<TprMvCab.Dopes>']
	*   pIni = Iif(Not Eof() And Not Empty(ObsInis), ObsInis, 000)
	*   pFim = Iif(Not Eof() And Not Empty(ObsFins), ObsFins, 999)
	*   lcObsPads = LocalOpe.ObsPads
	*
	* TprMvCab eh cursor do formulario CHAMADOR (property
	* this_cCursorCabecalho) e so eh LIDO aqui.
	*====================================================================
	PROTECTED PROCEDURE CarregarFaixaOperacao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCabecalho

		loc_lSucesso   = .F.
		loc_cCabecalho = THIS.this_cCursorCabecalho

		IF !USED(loc_cCabecalho)
			THIS.this_cMensagemFalha = "Cursor de cabe" + CHR(231) + "alho (" + ;
				loc_cCabecalho + ") n" + CHR(227) + "o dispon" + CHR(237) + ;
				"vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (loc_cCabecalho)
		THIS.this_cDopes = TratarNulo(Dopes, "")

		loc_cSQL = "SELECT obspads, obsinis, obsfins" + ;
			" FROM SigCdOpe" + ;
			" WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

		IF USED(THIS.this_cCursorOperacao)
			USE IN (THIS.this_cCursorOperacao)
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

		IF loc_nResultado < 1
			THIS.this_cMensagemFalha = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
				"(SigCdOpe)" + CHR(13) + CapturarErroSQL()
		ELSE
			SELECT (THIS.this_cCursorOperacao)
			GO TOP

			IF EOF()
				THIS.this_nObspads = 0
				THIS.this_nObsinis = 0
				THIS.this_nObsfins = 0

				THIS.this_nFaixaInicial = 0
				THIS.this_nFaixaFinal   = 999
				THIS.this_nObsPadrao    = 0
			ELSE
				THIS.this_nObspads = TratarNulo(obspads, 0)
				THIS.this_nObsinis = TratarNulo(obsinis, 0)
				THIS.this_nObsfins = TratarNulo(obsfins, 0)

				THIS.this_nFaixaInicial = IIF(EMPTY(THIS.this_nObsinis), 0, THIS.this_nObsinis)
				THIS.this_nFaixaFinal   = IIF(EMPTY(THIS.this_nObsfins), 999, THIS.this_nObsfins)
				THIS.this_nObsPadrao    = THIS.this_nObspads
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MarcarObservacaoPadrao - "Update LocalObs Set Selecao = 1 Where
	* Codigos = lcObsPads" do legado.
	*
	* Em modo FINALIDADES this_nObsPadrao vale -1 e o SCAN FOR nao casa
	* com nenhuma linha - o legado roda a mesma instrucao nos dois
	* fluxos, por isso aqui nao ha IF sobre o modo.
	*====================================================================
	PROTECTED PROCEDURE MarcarObservacaoPadrao()
		LOCAL loc_nMarcadas

		loc_nMarcadas = 0

		IF !USED(THIS.this_cCursorLista)
			RETURN loc_nMarcadas
		ENDIF

		SELECT (THIS.this_cCursorLista)
		SCAN FOR codigos = THIS.this_nObsPadrao
			REPLACE selecao WITH 1
			loc_nMarcadas = loc_nMarcadas + 1
		ENDSCAN

		RETURN loc_nMarcadas
	ENDPROC

	*====================================================================
	* LimparCursorLista - Esvazia o cursor da grade preservando o ALIAS
	*
	* SET SAFETY eh escopado por DATA SESSION, e este dialogo tem
	* DataSession = 1 (sessao CORRENTE): chamado de um formulario com
	* datasession privada, o BO roda la dentro, onde SAFETY esta ON
	* mesmo com o SET SAFETY OFF do main.prg. Com SAFETY ON o ZAP abre
	* dialogo modal de confirmacao e CONGELA a tela - por isso o
	* salva/restaura em volta.
	*====================================================================
	PROTECTED PROCEDURE LimparCursorLista()
		LOCAL loc_cSafety, loc_lSucesso

		loc_lSucesso = .F.

		IF USED(THIS.this_cCursorLista)
			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			SELECT (THIS.this_cCursorLista)
			ZAP

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarSelecao - Reproduz TODO o btnConfirmar.Click legado
	*
	* Dois fluxos exclusivos, no MESMO criterio de this_lModoFinalidades
	* usado na carga (CarregarListaObservacoes):
	*   .F. (operacao, "If Vartype(pcLista) <> 'C'") -> acumula o texto
	*       das observacoes marcadas em TprMvCab.obses (cursor do
	*       formulario CHAMADOR).
	*   .T. (finalidades, ramo Else do legado) -> conforme this_cTipo:
	*       ausente = SIGOPINF (monta this_cListaSelecionadas), "GRP" ou
	*       "ITN" = sincroniza INSERT/DELETE em crSigOpFnl (idem cursor
	*       do CHAMADOR).
	*
	* this_lConfirmado fica .T. so quando a gravacao de fato aconteceu -
	* eh o que o Form usa para decidir entre liberar o dialogo (Release)
	* ou devolver o foco a grade sem fechar.
	*====================================================================
	PROCEDURE ConfirmarSelecao()
		LOCAL loc_lSucesso, loc_oErro

		loc_lSucesso = .F.
		THIS.this_cMensagemFalha  = ""
		THIS.this_lFalhaValidacao = .F.

		TRY
			IF !USED(THIS.this_cCursorLista)
				THIS.this_cMensagemFalha = "Lista de observa" + CHR(231) + CHR(245) + ;
					"es indispon" + CHR(237) + "vel."
			ELSE
				IF THIS.this_lModoFinalidades
					loc_lSucesso = THIS.ConfirmarFluxoFinalidades()
				ELSE
					loc_lSucesso = THIS.ConfirmarFluxoOperacao()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemFalha = "Falha ao confirmar a sele" + CHR(231) + CHR(227) + ;
				"o: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lSucesso = .F.
		ENDTRY

		THIS.this_lConfirmado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarFluxoOperacao - Ramo "If Vartype(pcLista) <> 'C'" do
	* btnConfirmar.Click legado
	*
	* Legado:
	*   Locate For Selecao = 1 / If Eof([LocalObs]) -> MessageBox +
	*       Go Top + SetFocus + Return .F.
	*   If Not IsEmpty(TprMvCab.obses) -> MessageBox(4+32+256) <> 6 ->
	*       Replace obses With [] / senao llPri = .F.
	*   Scan: Replace obses With obses + separador + Alltrim(Observas)
	*
	* MessageBox(...,0+48,...) = MsgAviso (validacao, nao erro tecnico) -
	* marca this_lFalhaValidacao para o Form escolher MsgAviso no lugar
	* de MsgErro. MessageBox(4+32+256,...) <> 6 (Nao) = !MsgConfirma().
	*====================================================================
	PROTECTED PROCEDURE ConfirmarFluxoOperacao()
		LOCAL loc_lSucesso, loc_lPrimeira, loc_cCabecalho, loc_cTexto

		loc_lSucesso   = .F.
		loc_cCabecalho = THIS.this_cCursorCabecalho

		IF !USED(loc_cCabecalho)
			THIS.this_cMensagemFalha = "Cursor de cabe" + CHR(231) + "alho (" + ;
				loc_cCabecalho + ") n" + CHR(227) + "o dispon" + CHR(237) + ;
				"vel no formul" + CHR(225) + "rio chamador."
			RETURN loc_lSucesso
		ENDIF

		SELECT (THIS.this_cCursorLista)
		LOCATE FOR selecao = 1

		IF EOF()
			THIS.this_cMensagemFalha  = "Nenhuma Observa" + CHR(231) + CHR(227) + ;
				"o Foi Selecionada!"
			THIS.this_lFalhaValidacao = .T.
			GO TOP
			RETURN loc_lSucesso
		ENDIF

		loc_lPrimeira = .T.

		SELECT (loc_cCabecalho)
		IF !EMPTY(TratarNulo(obses, ""))
			IF !MsgConfirma("J" + CHR(225) + " Existe Conte" + CHR(250) + "do Informado No " + ;
					"Campo de Observa" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
					"Deseja Manter o Conte" + CHR(250) + "do e Acrescentar as Observa" + ;
					CHR(231) + CHR(245) + "es" + CHR(13) + "Que Foram Selecionadas Agora?", ;
					"Aten" + CHR(231) + CHR(227) + "o!")
				REPLACE obses WITH ""
			ELSE
				loc_lPrimeira = .F.
			ENDIF
		ENDIF

		SELECT (THIS.this_cCursorLista)
		GO TOP
		SCAN
			IF selecao = 1
				loc_cTexto = ALLTRIM(TratarNulo(observas, ""))

				SELECT (loc_cCabecalho)
				REPLACE obses WITH obses + ;
					IIF(loc_lPrimeira, "", CHR(13) + IIF(THIS.this_lPularLinhas, CHR(13), "")) + ;
					loc_cTexto

				loc_lPrimeira = .F.

				SELECT (THIS.this_cCursorLista)
			ENDIF
		ENDSCAN

		loc_lSucesso = .T.

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConfirmarFluxoFinalidades - Ramo Else do btnConfirmar.Click legado
	* (Vartype(pcLista) = 'C'), com os TRES subcasos de this_cTipo.
	*====================================================================
	PROTECTED PROCEDURE ConfirmarFluxoFinalidades()
		LOCAL loc_lSucesso

		loc_lSucesso = .T.

		IF !THIS.this_lTipoInformado
			*-- SIGOPINF: monta a PUBLIC listaObs do legado
			THIS.MontarListaSelecionadas()
		ENDIF

		IF loc_lSucesso AND THIS.this_lTipoInformado AND THIS.this_cTipo == "GRP"
			loc_lSucesso = THIS.SincronizarFinalidadesGrupo()
		ENDIF

		IF loc_lSucesso AND THIS.this_lTipoInformado AND THIS.this_cTipo == "ITN"
			loc_lSucesso = THIS.SincronizarFinalidadesItem()
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* MontarListaSelecionadas - Ramo "Vartype(pcTipo) <> 'C'" do Else
	*
	* Legado:
	*   listaObs = Iif(llPri, ','+Alltrim(Str(codigos))+',',
	*       Alltrim(listaObs)+Alltrim(Str(codigos))+',')
	*
	* Resultado no formato ",1,7,23," - eh o que SIGOPINF le de volta em
	* this_cListaSelecionadas apos o Show() do dialogo.
	*====================================================================
	PROTECTED PROCEDURE MontarListaSelecionadas()
		LOCAL loc_cLista, loc_lPrimeira

		loc_cLista    = ""
		loc_lPrimeira = .T.

		SELECT (THIS.this_cCursorLista)
		GO TOP
		SCAN
			IF selecao = 1
				IF loc_lPrimeira
					loc_cLista = "," + ALLTRIM(STR(codigos)) + ","
				ELSE
					loc_cLista = ALLTRIM(loc_cLista) + ALLTRIM(STR(codigos)) + ","
				ENDIF
				loc_lPrimeira = .F.
			ENDIF
		ENDSCAN

		THIS.this_cListaSelecionadas = loc_cLista

		RETURN .T.
	ENDPROC

	*====================================================================
	* SincronizarFinalidadesGrupo - Ramo "Vartype(pcTipo) = 'C' And
	* pcTipo = 'GRP'" do Else
	*
	* Legado:
	*   Scan localObs: selecao=1 e nao existe em crSigOpFnl -> Insert
	*       (fUniqueIds() na chave); senao (existe e nao selecionado) ->
	*       Delete.
	*
	* crSigOpFnl e crSigCdGrp sao cursores do formulario CHAMADOR
	* (this_cCursorFinalidades / this_cCursorGrupoPai) - chegam JA
	* ABERTOS e bufferizados; o TABLEUPDATE() que persiste no SQL
	* Server roda no formulario pai, fora do alcance deste BO.
	*====================================================================
	PROTECTED PROCEDURE SincronizarFinalidadesGrupo()
		LOCAL loc_cLista, loc_cFinalidades, loc_cGrupoPai, loc_nCodigo, loc_cIdChave, loc_cCgrus

		loc_cLista       = THIS.this_cCursorLista
		loc_cFinalidades = THIS.this_cCursorFinalidades
		loc_cGrupoPai    = THIS.this_cCursorGrupoPai

		IF !USED(loc_cFinalidades)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cFinalidades + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + ;
				"rio chamador."
			RETURN .F.
		ENDIF

		IF !USED(loc_cGrupoPai)
			THIS.this_cMensagemFalha = "Cursor do grupo (" + loc_cGrupoPai + ") n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + "rio chamador."
			RETURN .F.
		ENDIF

		SELECT (loc_cGrupoPai)
		loc_cCgrus = ALLTRIM(TratarNulo(cgrus, ""))

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nCodigo = codigos

			IF selecao = 1
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo

				IF !FOUND()
					loc_cIdChave = fUniqueIds()
					INSERT INTO (loc_cFinalidades) (operacao, codigos, codutil, cidchaves, empdopnums) ;
						VALUES ("GRP", loc_nCodigo, loc_cCgrus, loc_cIdChave, "")
				ENDIF
			ELSE
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo

				IF FOUND()
					DELETE
				ENDIF
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		RETURN .T.
	ENDPROC

	*====================================================================
	* SincronizarFinalidadesItem - Ramo "Vartype(pcTipo) = 'C' And
	* pcTipo = 'ITN'" do Else
	*
	* Mesma logica da sincronizacao do grupo, mas filtrada por
	* codutil = pcChv (this_cChave) e gravando this_cEdn em empdopnums -
	* identico ao Insert Into do legado para o fluxo de item.
	*====================================================================
	PROTECTED PROCEDURE SincronizarFinalidadesItem()
		LOCAL loc_cLista, loc_cFinalidades, loc_cChave, loc_cEdn, loc_nCodigo, loc_cIdChave

		loc_cLista       = THIS.this_cCursorLista
		loc_cFinalidades = THIS.this_cCursorFinalidades
		loc_cChave       = THIS.this_cChave
		loc_cEdn         = THIS.this_cEdn

		IF !USED(loc_cFinalidades)
			THIS.this_cMensagemFalha = "Cursor de finalidades (" + loc_cFinalidades + ;
				") n" + CHR(227) + "o dispon" + CHR(237) + "vel no formul" + CHR(225) + ;
				"rio chamador."
			RETURN .F.
		ENDIF

		SELECT (loc_cLista)
		GO TOP
		SCAN
			loc_nCodigo = codigos

			IF selecao = 1
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo AND codutil = loc_cChave

				IF !FOUND()
					loc_cIdChave = fUniqueIds()
					INSERT INTO (loc_cFinalidades) (operacao, codigos, codutil, cidchaves, empdopnums) ;
						VALUES ("ITN", loc_nCodigo, loc_cChave, loc_cIdChave, loc_cEdn)
				ENDIF
			ELSE
				SELECT (loc_cFinalidades)
				LOCATE FOR codigos = loc_nCodigo AND codutil = loc_cChave

				IF FOUND()
					DELETE
				ENDIF
			ENDIF

			SELECT (loc_cLista)
		ENDSCAN

		RETURN .T.
	ENDPROC

	*====================================================================
	* DECISAO DE PROJETO - Inserir()/Atualizar()/ExecutarExclusao() NAO
	* sao sobrescritos neste BO: o comportamento herdado de BusinessBase
	* ja eh o correto, porque SigCdObs eh usada so para LEITURA por este
	* dialogo e nenhuma gravacao remota sobra para este BO executar.
	*
	* Evidencia no dump legado (SIGOPins_form_codigo_fonte.txt):
	* - SIGOPINS.Init: todo acesso a SigCdObs/SigCdOpe/SigCdPro eh
	*   ThisForm.poDataMgr.SqlExecute(<SELECT>, [<cursor local>]) - nunca
	*   Insert/Update/Delete, e sem nenhum .AddCursor() (que eh o bind
	*   remoto do frmcadastro que habilitaria CRUD).
	* - SIGOPINS.Grade.Column1.Header1.Click: "Update LocalObs Set
	*   Selecao = ..." atualiza o cursor LOCAL LocalObs (populado pela
	*   SELECT acima), nao a tabela SigCdObs.
	* - SIGOPINS.cntBotoes.btnConfirmar.Click: os unicos "Insert Into
	*   crSigOpFnl (...)" e "Delete" (apos Locate) tem como alvo
	*   crSigOpFnl - cursor do FORMULARIO CHAMADOR (property
	*   this_cCursorFinalidades), que chega JA ABERTO e bufferizado; o
	*   TABLEUPDATE() que persiste essas linhas no SQL Server roda no
	*   formulario pai, fora do alcance deste BO. "Replace obses With
	*   ... In TprMvCab" altera em MEMORIA outro cursor do chamador
	*   (property this_cCursorCabecalho) - tambem sem TABLEUPDATE().
	*
	* Nenhum SQLEXEC de INSERT/UPDATE/DELETE aparece em lugar nenhum
	* deste BO.
	*====================================================================

	*====================================================================
	* ObterChavePrimaria - Chave de SigCdObs para a auditoria
	* codigos eh numeric(3,0): a chave de auditoria eh a representacao
	* textual do codigo da observacao corrente.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(STR(THIS.this_nCodigos, 3))
	ENDPROC

ENDDEFINE

