# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, STATUS, TOTA

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
lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Status = b.cods ]
ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
Select LocalStats
	.Column1.ControlSource = 'LocalStats.status'
	.Column2.ControlSource = 'LocalStats.Descs'
Select LocalStats
Select LocalStats
	Delete
		Select LocalStats
		Select status,sum(1) as TT From LocalStats GROUP by 1 Into cursor Totais
		Select Totais
		Select CrSIGOPSTS
		Select LocalStats
			Insert Into CrSIGOPSTS (Dopes,status,CidChaves) Values ;
				lcDelete = [Delete From SIGOPSTS Where Dopes = ']+CrSigCdOpe.Dopes+[']
				m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGOPSTS'),1,-1)
Select LocalStats
	Insert Into LocalStats (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select LocalStats

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg) - TRECHOS RELEVANTES PARA PASS SQL (2193 linhas total):

*-- Linhas 9 a 49:
9: *           "Status das Operacoes <operacao>")
10: *   BD   -> SIGOPSTS/SigStats (via SigOpStsBO); a gravacao real so acontece
11: *           no clique de Encerrar (BtnSairClick), igual ao legado
12: *           (ParentForm.poDataMgr.UpDate('crSIGOPSTS') + Commit() so no
13: *           cmdSair.Click)
14: *   CODE -> arquitetura em camadas (FormBase / SigOpStsBO)
15: *
16: * O QUE ESTA TELA EH
17: *   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
18: *   abre para o usuario manter a lista de STATUS permitidos para uma
19: *   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
20: *   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
21: *   DataSession do pai (Set DataSession To pnDataSes) e popula um cursor
22: *   local com:
23: *
24: *     Select a.*, b.Descs From SIGOPSTS a, SigStats b
25: *      Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
26: *
27: *   A grade (GradeSubN) tem 2 colunas:
28: *     Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
29: *                When = Empty(LocalStats.status), ou seja so a linha NOVA,
30: *                ainda sem status, aceita digitacao)
31: *     Column2 -> Descs  (TextBox com When = .F. - somente leitura, a
32: *                descricao vem do lookup e nao eh digitada)
33: *   Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
34: *   Excluir (Delete da linha corrente) e Encerrar (valida duplicidade,
35: *   grava, reabilita os botoes do pai e fecha).
36: *
37: *   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
38: *   compartilhada com o pai), reproduzindo o mesmo efeito do "Set
39: *   DataSession To pnDataSes" sem a troca manual de sessao - mesmo padrao
40: *   ja adotado em FormSigOpSqn.prg/FormSigOpSlc.prg/FormSigOpSpr.prg.
41: *
42: * CHAMADA (equivale ao "Do Form SigOpSts With ThisForm, ThisForm.
43: * DataSessionId, ThisForm.PcEscolha" do legado, onde o proprio form pai eh
44: * "poForm"):
45: *   loForm = CREATEOBJECT("FormSigOpSts", THISFORM, loc_cOperacaoAtual, ;
46: *       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
47: *   IF VARTYPE(loForm) = "O"
48: *       loForm.Show()          && modal: so volta quando o dialogo fecha
49: *   ENDIF

*-- Linhas 124 a 159:
124: *     bypass em modo teste/validacao de UI, onde ele consulta SQL e nao ha
125: *     conexao).
126: *   - CarregarDados (funil UNICO de carga, PUBLIC) + VincularGrade: chamam
127: *     SigOpStsBO.ListarStatusOperacao (equivalente ao Sqlexecute('...',
128: *     'LocalStats') do legado), religam a grade ao cursor e repintam com
129: *     GO TOP + Refresh (regra #21 - popular cursor NAO repinta a grade).
130: *
131: * FASE 6 (esta fase): o LOOKUP da celula de status -
132: *   A tela nao tem campo nenhum fora da grade (o dump tem apenas os dois
133: *   labels do cabecalho, a GradeSubN, o Shape e os 3 botoes), entao esta
134: *   fase eh inteiramente a celula editavel da Column1 e o lookup dela.
135: *
136: *   - ConfigurarGrade passa a instalar TextBoxStatusSts_4c na Column1 com
137: *     Column.AddObject + CurrentControl + Sparse = .F. (regra #18 - sem o
138: *     CurrentControl a coluna continua desenhando o Text1 dela e o
139: *     controle novo nunca aparece; sem Sparse = .F. ele apareceria so na
140: *     linha ativa). A classe mora em classes\textboxgridlookup.PRG porque
141: *     BINDEVENT em When/Valid de celula de Grid NAO eh confiavel
142: *     (regra #46), e delega para os metodos PUBLIC abaixo.
143: *   - VincularGrade REAPLICA CurrentControl/Sparse: atribuir RecordSource/
144: *     ControlSource reseta as duas propriedades junto com Width/Caption
145: *     (Problema 48 / regra #41).
146: *   - CelulaStatusEditavel  - When  do Column1.Text1 legado
147: *                             (Return( Empty( LocalStats.status ) ): so a
148: *                             linha ainda sem status aceita digitacao).
149: *   - ValidarStatusGradeExec - Valid do Column1.Text1 legado (com valor
150: *                             digitado, resolve contra SigStats e grava a
151: *                             descricao na linha corrente).
152: *   - AbrirLookupStatusSts / AbrirLookupStatusStsExec - o
153: *                             CreateObject('fwbuscaext', ..., 'SigStats',
154: *                             'CrListaRemota', 'Cods', ...) do legado,
155: *                             migrado para FormBuscaAuxiliar seguindo o
156: *                             contrato this_lAchouRegistro/
157: *                             this_lSelecionou (regra #37). Funil UNICO
158: *                             das tres entradas (Valid, F4/F5 e duplo
159: *                             clique), com guarda de reentrancia.

*-- Linhas 174 a 192:
174: *   - CmdInserirClick      - cmdInserir.Click legado: acrescenta UMA linha
175: *                            em branco ao cursor da grade (reaproveitando a
176: *                            que ja estiver vazia) e foca a Column1.
177: *   - CmdExcluirClick      - cmdExcluir.Click legado: DELETE da linha
178: *                            corrente do cursor + reposicionamento.
179: *   - BtnSairClick         - cmdSair.Click legado ("Encerrar"): valida
180: *                            duplicidade, grava (REPLACE-ALL) e fecha. Eh o
181: *                            UNICO ponto de gravacao da tela, igual ao
182: *                            legado. A validacao e o REPLACE-ALL moram no
183: *                            BO (SigOpStsBO.ExisteStatusDuplicado /
184: *                            GravarStatus) - sao regra de negocio e acesso
185: *                            a dados, nao UI.
186: *
187: *   Os tres handlers sao PUBLIC (regra #3/#51): BINDEVENT falha em SILENCIO
188: *   com metodo PROTECTED, e o harness de teste os chama de fora da classe.
189: *
190: * FASE 8 (esta fase): o TRANSPORTE da linha da grade e a CONSOLIDACAO -
191: *   Esta tela nao tem campo nenhum fora da grade, entao a FICHA dela eh UMA
192: *   LINHA de cursor_4c_Status. Os dois hooks de transferencia transportam

*-- Linhas 202 a 220:
202: *                          campo status.
203: *   - BOParaForm         - properties do BO -> linha corrente + celula +
204: *                          Refresh. Eh a transcricao do "This.Value = ... /
205: *                          Replace Descs With ... / This.Refresh / Select
206: *                          LocalStats" do Valid legado. O metodo
207: *                          AbrirLookupStatusStsExec passou a usar estes dois
208: *                          hooks em vez de repetir o REPLACE.
209: *   - LimparCampos       - zera a ficha da linha no funil de carga, para a
210: *                          linha de uma sessao nunca vazar para a seguinte.
211: *
212: *   - HabilitarCampos    - ponto UNICO que aplica a editabilidade aos
213: *                          controles. Existe porque o rebind da grade reseta
214: *                          Column.ReadOnly (Problema 48 / regra #41) e quem
215: *                          desabilita tem de reabilitar no FUNIL (regra #40):
216: *                          VincularGrade e AplicarVisibilidadeBotoes o chamam.
217: *   - AjustarBotoesPorModo / CarregarLista - os nomes canonicos do projeto
218: *                          apontando para a logica real desta tela
219: *                          (AplicarVisibilidadeBotoes / CarregarDados), para
220: *                          o caminho canonico alcancar UM unico fluxo em vez

*-- Linhas 478 a 496:
478:                 *-- dispara e o usuario clica sem nada acontecer)
479:                 THIS.ConfigurarBINDEVENTs()
480: 
481:                 *-- Legado (fim do Init): Sqlexecute(...,'LocalStats') +
482:                 *-- Goto Top + bind da GradeSubN + .Refresh. Pulado em
483:                 *-- validacao de UI (sem gnConnHandle nao ha o que
484:                 *-- consultar) - a ausencia de dados nao impede a tela de
485:                 *-- abrir
486:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
487:                     IF !THIS.CarregarDados()
488:                         *-- Falha ja reportada por CarregarDados/BO
489:                     ENDIF
490:                 ENDIF
491: 
492:                 loc_lSucesso = .T.
493:             ENDIF
494: 
495:         CATCH TO loc_oErro
496:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 709 a 742:
709:     *
710:     * Transcricao do dump (SigOpSts_form_codigo_fonte.txt):
711:     *   GradeSubN  Top=94 Left=146 Width=307 Height=238 ColumnCount=2
712:     *              FontName="Tahoma" FontSize=8 DeleteMark=.F. RowHeight=16
713:     *              ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
714:     *   Column1    FontName="Tahoma" FontSize=8 Width=40 Movable=.F.
715:     *              Resizable=.F.  (ControlSource="" - override VAZIO do
716:     *              Form Designer, o bind real eh feito em VincularGrade:
717:     *              'cursor_4c_Status.status')
718:     *   Column1.Header1  Alignment=2 Caption="Status"
719:     *   Column1.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
720:     *                    BackColor=255,255,255
721:     *   Column2    FontName="Tahoma" FontSize=8 Width=235 Movable=.F.
722:     *              Resizable=.F.
723:     *   Column2.Header1  Alignment=2 Caption="Descricao"
724:     *   Column2.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
725:     *                    BackColor=255,255,255
726:     *
727:     * RecordMark = .F. (o dump so declara DeleteMark): canonico do projeto
728:     * para grade criada por AddObject em form OPERACIONAL - a barra lateral
729:     * de marcacao de registro nao faz parte do padrao visual do sistema
730:     * novo e a linha corrente continua identificada pelo realce do proprio
731:     * Grid. Mesmo padrao adotado em FormSigOpSqn.prg.
732:     *
733:     * Column1 (status) eh editavel SO quando a linha ainda nao tem status
734:     * (legado: When = Empty(LocalStats.status), textbox da Column1) - essa
735:     * condicao por LINHA e o lookup contra SigStats entram na Fase 6, via
736:     * TextBox subclasse instalada com Column.AddObject + CurrentControl +
737:     * Sparse = .F. (regra #18), porque BINDEVENT em evento de celula de
738:     * Grid nao eh confiavel (regra #46). Por ora, no nivel do Grid, a
739:     * coluna fica destravada (ReadOnly = .F.) - a restricao por linha vem
740:     * depois, da classe da Fase 6.
741:     *
742:     * Column2 (descs) eh SEMPRE somente leitura (legado: When = .F. no

*-- Linhas 759 a 777:
759:             .Height        = 238
760:             .FontName      = "Tahoma"
761:             .FontSize      = 8
762:             .DeleteMark    = .F.
763:             .RecordMark    = .F.
764:             .RowHeight     = 16
765:             .ScrollBars    = 2
766:             .TabIndex      = 1
767:             .GridLineColor = RGB(238, 238, 238)
768:             .ColumnCount   = 2
769:             .Visible       = .T.
770:         ENDWITH
771: 
772:         *-- Column1 - status (codigo, FK SigStats.cods). Celula com When/
773:         *-- Valid/LostFocus do legado e lookup contra SigStats: os eventos
774:         *-- moram na classe TextBoxStatusSts_4c (classes\
775:         *-- textboxgridlookup.PRG) porque BINDEVENT em evento de celula de
776:         *-- Grid nao eh confiavel (regra #18/#46)
777:         WITH THIS.grd_4c_Dados.Column1

*-- Linhas 1049 a 1098:
1049:     *==========================================================================
1050:     * VincularGrade - liga grd_4c_Dados ao cursor de status, transcrevendo o
1051:     * bloco final do Init legado (Thisform.GradeSubN): RecordSource recebe
1052:     * 'LocalStats', o ControlSource da Column1 vira 'LocalStats.status' e o
1053:     * da Column2 vira 'LocalStats.Descs', e por fim um Refresh da grade.
1054:     *
1055:     * O alias eh o literal cursor_4c_Status (valor de SigOpStsBO.
1056:     * this_cCursorStatus) - INTO CURSOR do BO e RecordSource daqui precisam
1057:     * casar, e um nome fixo nos dois lados nao tem como divergir.
1058:     *
1059:     * Width / Header1.Caption / Header1.Alignment / ReadOnly sao
1060:     * REAPLICADOS depois do bind: atribuir RecordSource/ControlSource
1061:     * reseta a largura das colunas para o default 90 e o cabecalho para
1062:     * "Column1"/"Column2" (Problema 48 / regra #41). Por isso este bloco
1063:     * repete os valores de ConfigurarGrade em vez de so configura-los la.
1064:     *==========================================================================
1065:     PROTECTED PROCEDURE VincularGrade
1066:         IF !USED("cursor_4c_Status")
1067:             RETURN .F.
1068:         ENDIF
1069: 
1070:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1071:             RETURN .F.
1072:         ENDIF
1073: 
1074:         *-- RecordSource FORA do WITH: colunas nao sao recriadas de
1075:         *-- imediato dentro de um WITH, e acessar .Column1/.Column2 no
1076:         *-- mesmo bloco pode estourar "Unknown member COLUMN1"
1077:         THIS.grd_4c_Dados.RecordSource = ""
1078:         THIS.grd_4c_Dados.ColumnCount = 2
1079:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Status"
1080: 
1081:         WITH THIS.grd_4c_Dados
1082:             .Column1.ControlSource = "cursor_4c_Status.status"
1083:             .Column2.ControlSource = "cursor_4c_Status.descs"
1084: 
1085:             *-- Reaplicar o que o rebind acabou de resetar
1086:             .Column1.Width = 40
1087:             .Column2.Width = 235
1088: 
1089:             .Column1.Header1.Alignment = 2
1090:             .Column2.Header1.Alignment = 2
1091:             .Column1.Header1.Caption   = "Status"
1092:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1093: 
1094:         ENDWITH
1095: 
1096:         *-- O rebind reseta CurrentControl/Sparse e, quando o ColumnCount
1097:         *-- acima RECRIOU as Columns, o proprio controle da celula deixou de
1098:         *-- existir: reinstalar num lugar so (regra #18/#41) - ver a medicao

*-- Linhas 1197 a 1218:
1197:     *
1198:     * Equivale ao bloco do Init legado que consulta e religa a grade:
1199:     *
1200:     *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
1201:     *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
1202:     *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
1203:     *   Select LocalStats / Goto Top
1204:     *   With Thisform.GradeSubN ... .Refresh
1205:     *
1206:     * No migrado, quem produz o cursor eh SigOpStsBO.ListarStatusOperacao
1207:     * (mesma consulta, filtrada pela operacao-pai), e o Go Top + Refresh vem
1208:     * DEPOIS do bind - popular o cursor NAO repinta a grade sozinho (regra
1209:     * #21).
1210:     *
1211:     * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
1212:     * e os Click dos botoes alcancam de fora - PROTECTED
1213:     * faria a chamada externa estourar em runtime (regra #3/#51).
1214:     *
1215:     * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
1216:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1217:     * reportada por ListarStatusOperacao.
1218:     *==========================================================================

*-- Linhas 1238 a 1258:
1238:                 IF THIS.this_oBusinessObject.ListarStatusOperacao(THIS.this_cOperacaoPai)
1239:                     THIS.VincularGrade()
1240: 
1241:                     *-- Legado: Select LocalStats / Goto Top
1242:                     IF USED("cursor_4c_Status")
1243:                         SELECT cursor_4c_Status
1244:                         GO TOP
1245:                     ENDIF
1246: 
1247:                     *-- Legado: Thisform.GradeSubN.Refresh
1248:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1249:                         THIS.grd_4c_Dados.Refresh()
1250:                     ENDIF
1251: 
1252:                     loc_lSucesso = .T.
1253:                 ENDIF
1254:             ENDIF
1255:         CATCH TO loc_oErro
1256:             MsgErro("Erro ao carregar os status da opera" + CHR(231) + CHR(227) + ;
1257:                 "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1258:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1311 a 1329:
1311:     *       Replace Descs With CrListaRemota.Descs in LocalStats
1312:     *       This.Refresh
1313:     *   EndIf
1314:     *   Select LocalStats
1315:     *   Return .t.
1316:     *
1317:     * O "lcDopes = crSigCdOpe.Dopes" do legado eh leitura morta (a variavel
1318:     * nunca eh usada depois) - nao ha o que transcrever dela.
1319:     *
1320:     * Celula VAZIA nao dispara nada, igual ao legado: o usuario pode
1321:     * atravessar a linha em branco com Tab sem levar dialogo nenhum.
1322:     *
1323:     * Dentro do Valid o valor digitado esta em par_oTxt.Value - o cursor da
1324:     * grade so o recebe DEPOIS que este metodo devolve .T. (regra #46), e
1325:     * por isso ler cursor_4c_Status.status aqui validaria o valor ANTIGO.
1326:     *
1327:     * RETURN .T. sempre, igual ao legado (o "Return .t." final) - o codigo
1328:     * invalido nao prende o foco na celula; quem resolve/limpa eh o picker.
1329:     *

*-- Linhas 1442 a 1460:
1442:             ENDIF
1443: 
1444:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1445:                 SELECT cursor_4c_Busca
1446:                 loc_cCodigo    = ALLTRIM(NVL(cursor_4c_Busca.cods,  ""))
1447:                 loc_cDescricao = ALLTRIM(NVL(cursor_4c_Busca.descs, ""))
1448:                 loc_lResolveu  = !EMPTY(loc_cCodigo)
1449:             ENDIF
1450: 
1451:             loc_oBusca.Release()
1452:         ENDIF
1453: 
1454:         IF USED("cursor_4c_Busca")
1455:             USE IN cursor_4c_Busca
1456:         ENDIF
1457: 
1458:         *-- O resultado do picker volta para a linha PELA FICHA (o BO), que eh
1459:         *-- o transporte desta tela (Fase 8): FormParaBO carrega a identidade
1460:         *-- da linha corrente, o resultado do lookup sobrescreve status/descs e

*-- Linhas 1470 a 1488:
1470:             THIS.this_oBusinessObject.this_cDescs  = IIF(loc_lResolveu, loc_cDescricao, "")
1471:         ENDIF
1472: 
1473:         *-- Legado: Select LocalStats / This.Refresh (+ a grade, para a Column2
1474:         *-- exibir a descricao que acabou de ser gravada no cursor - regra #21)
1475:         THIS.BOParaForm(par_oTxt)
1476:     ENDPROC
1477: 
1478:     *==========================================================================
1479:     * StatusGradeLostFocus - LostFocus do Column1.Text1 legado:
1480:     *
1481:     *   If IsEmpty(This.Value)
1482:     *       Thisform.cmdSair.SetFocus
1483:     *   EndIf
1484:     *
1485:     * Celula abandonada em branco devolve o foco ao botao Encerrar: com
1486:     * TitleBar = 0 e ControlBox = .F. ele eh a unica saida da tela, e o
1487:     * legado nao deixa o foco preso numa linha que nao vai ser gravada.
1488:     *

*-- Linhas 1528 a 1571:
1528:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1529:     *
1530:     *   Thisform.lHouveIns = .T.
1531:     *   Select LocalStats
1532:     *   Locate for Dopes = crSigCdOpe.Dopes And status = ' '
1533:     *   If Eof()
1534:     *       Insert Into LocalStats (Dopes, CidChaves) ;
1535:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1536:     *   EndIf
1537:     *   Select LocalStats
1538:     *   Thisform.GradeSubN.Column1.SetFocus
1539:     *
1540:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1541:     * criada na vez anterior ainda nao foi preenchida, o legado REAPROVEITA ela
1542:     * em vez de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o
1543:     * foco vai parar). Sem esse guard o usuario acumularia linhas em branco e
1544:     * seria barrado na gravacao pela validacao de duplicidade, que conta o
1545:     * status vazio junto com os demais (ver SigOpStsBO.ExisteStatusDuplicado).
1546:     *
1547:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre o cursor
1548:     * do pai e so persiste no Encerrar (Zap + Insert + UpDate + Commit ->
1549:     * BtnSairClick / SigOpStsBO.GravarStatus). A PK vai ja preenchida com
1550:     * fUniqueIds() (regra #22: cidchaves NUNCA em branco).
1551:     *
1552:     * O status fica vazio de proposito: eh justamente isso que faz o When da
1553:     * celula (CelulaStatusEditavel) liberar a digitacao NESTA linha e manter as
1554:     * demais travadas.
1555:     *
1556:     * O "Select LocalStats" final do legado nao precisa ser reproduzido como
1557:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1558:     * DataSession do PAI (DataSession = 1), onde deixar outro alias selecionado
1559:     * atrapalharia quem chamou - por isso o alias anterior eh restaurado.
1560:     *
1561:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1562:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) = .T.).
1563:     * NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1564:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1565:     * read-only") e derrubaria o handler.
1566:     *
1567:     * Repinta a grade antes de focar: inserir no cursor NAO repinta sozinho
1568:     * (regra #21a) e a linha nova so aparece depois do Refresh.
1569:     *
1570:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1571:     *==========================================================================

*-- Linhas 1581 a 1612:
1581:                 ENDIF
1582: 
1583:                 loc_cAliasAnterior = ALIAS()
1584:                 SELECT cursor_4c_Status
1585: 
1586:                 LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(THIS.this_cOperacaoPai) ;
1587:                     AND EMPTY(NVL(status, ""))
1588: 
1589:                 IF !FOUND()
1590:                     loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)
1591: 
1592:                     INSERT INTO cursor_4c_Status (dopes, cidchaves) ;
1593:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1594:                 ENDIF
1595: 
1596:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1597:                     SELECT (loc_cAliasAnterior)
1598:                 ENDIF
1599: 
1600:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1601:                     THIS.grd_4c_Dados.Refresh()
1602: 
1603:                     *-- Column1 so existe com a grade VINCULADA: medido no
1604:                     *-- VFP9 (ver GarantirCelulaStatus), grade que perdeu o
1605:                     *-- alias fica com ColumnCount = 0 e o SetFocus estoura
1606:                     *-- "Unknown member COLUMN1" - erro cru na cara do
1607:                     *-- usuario DEPOIS de a linha ja ter sido inserida
1608:                     IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
1609:                         THIS.grd_4c_Dados.Column1.SetFocus()
1610:                     ENDIF
1611:                 ENDIF
1612:             ENDIF

*-- Linhas 1621 a 1735:
1621:     *==========================================================================
1622:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1623:     *
1624:     *   Select LocalStats
1625:     *   If Not Eof()
1626:     *       Thisform.lHouveExcl = .T.
1627:     *       Delete
1628:     *       Skip
1629:     *       Skip - 1
1630:     *   Endif
1631:     *   Thisform.GradeSubN.Refresh
1632:     *
1633:     * O legado NAO confere a operacao-pai da linha aqui (diferente do dialogo
1634:     * irmao SIGOPSQN, que testa cDopes antes de apagar) - e nao precisa: o
1635:     * cursor desta tela ja vem filtrado pela operacao-pai
1636:     * (SigOpStsBO.ListarStatusOperacao) e as linhas novas nascem com a mesma
1637:     * operacao (CmdInserirClick). Transcrito como esta: acrescentar a condicao
1638:     * aqui seria inventar regra que o legado nao tem (regra #21b).
1639:     *
1640:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1641:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1642:     * config.prg - a linha marcada desaparece da grade de imediato).
1643:     *
1644:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1645:     * Encerrar, e la ele eh um DELETE do conjunto INTEIRO da operacao seguido
1646:     * da reinsercao do que sobrou na grade (REPLACE-ALL - ver
1647:     * SigOpStsBO.GravarStatus), e nao um DELETE por linha.
1648:     *
1649:     * O Refresh fica FORA do IF, como no dump.
1650:     *
1651:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1652:     *==========================================================================
1653:     PROCEDURE CmdExcluirClick
1654:         LOCAL loc_cAliasAnterior, loc_oErro
1655: 
1656:         TRY
1657:             IF USED("cursor_4c_Status")
1658:                 loc_cAliasAnterior = ALIAS()
1659:                 SELECT cursor_4c_Status
1660: 
1661:                 IF !EOF()
1662:                     *-- Legado: Thisform.lHouveExcl = .T. (dono unico da flag
1663:                     *-- eh o BO - ver cabecalho de SigOpStsBO.prg)
1664:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1665:                         THIS.this_oBusinessObject.this_lHouveExclusao = .T.
1666:                     ENDIF
1667: 
1668:                     DELETE
1669:                     SKIP
1670:                     SKIP -1
1671:                 ENDIF
1672: 
1673:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1674:                     SELECT (loc_cAliasAnterior)
1675:                 ENDIF
1676:             ENDIF
1677: 
1678:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1679:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1680:                 THIS.grd_4c_Dados.Refresh()
1681:             ENDIF
1682:         CATCH TO loc_oErro
1683:             MsgErro(loc_oErro.Message + CHR(13) + ;
1684:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1685:                     "Procedure: " + loc_oErro.Procedure, ;
1686:                     "Erro em CmdExcluirClick")
1687:         ENDTRY
1688:     ENDPROC
1689: 
1690:     *==========================================================================
1691:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1692:     * tambem dispara no ESC). Transcrito:
1693:     *
1694:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1695:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1696:     *           Select LocalStats / Go Bottom / Go Top
1697:     *           <validacao: status duplicado> -> MessageBox + Return .f.
1698:     *           <Zap + Insert + Delete + UpDate + Commit, com RollBack e
1699:     *            MessageBox 'Erro na Gravacao dos Dados do Cadastro de
1700:     *            Status.'>
1701:     *       EndIf
1702:     *   ENDIF
1703:     *   Thisform.ParentForm.Enabled = .T.
1704:     *   Thisform.mCtrlBotoes(.T.)
1705:     *   ThisForm.Release
1706:     *
1707:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO a validacao de
1708:     * duplicidade aborta o fechamento (o "Return .f." do legado, que esta
1709:     * dentro do Scan dos totais); a FALHA DE GRAVACAO exibe a mensagem e FECHA
1710:     * do mesmo jeito, porque no legado o RollBack ja desfez tudo. Manter o
1711:     * dialogo aberto nesse caso convidaria a um segundo Encerrar, que repetiria
1712:     * o Delete + Insert do conjunto inteiro.
1713:     *
1714:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR ou
1715:     * usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1716:     * Sessao sem inclusao nem exclusao: idem - este eh o guard que faz a tela
1717:     * nao reescrever o conjunto so por ter sido aberta.
1718:     *
1719:     * "Go Bottom / Go Top" do legado forcava o cursor remoto bufferizado a
1720:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1721:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1722:     *
1723:     * MsgAviso (nao MsgErro) na duplicidade: eh validacao de entrada do
1724:     * usuario, nao falha tecnica - o dialogo vermelho com "Fechar Aplicacao" do
1725:     * MsgErro/MostrarErro eh reservado a exception. A mensagem eh a do legado,
1726:     * ao pe da letra, inclusive os quatro pontos de exclamacao e o codigo do
1727:     * PRIMEIRO status repetido (this_cStatusDuplicado).
1728:     *
1729:     * A falha de gravacao NAO eh reanunciada aqui quando o BO ja a exibiu
1730:     * (this_lErroExibido - regra #20): o GravarStatus mostra o texto do legado
1731:     * junto com a mensagem real do SQL Server, que eh mais util.
1732:     *
1733:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1734:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos do
1735:     * pai porque la o pai ficava com os controles desabilitados um a um - aqui

*-- Linhas 1753 a 1773:
1753:                    (THIS.this_oBusinessObject.this_lHouveExclusao OR ;
1754:                     THIS.this_oBusinessObject.this_lHouveInclusao)
1755: 
1756:                     *-- Legado: Select LocalStats / Go Bottom / Go Top
1757:                     IF USED("cursor_4c_Status")
1758:                         SELECT cursor_4c_Status
1759:                         GO BOTTOM
1760:                         GO TOP
1761:                     ENDIF
1762: 
1763:                     IF THIS.this_oBusinessObject.ExisteStatusDuplicado()
1764:                         *-- Legado: 'Status '+Alltrim(Totais.status)+
1765:                         *-- ' Digitado em Duplicidade!!!!'
1766:                         MsgAviso("Status " + ;
1767:                             ALLTRIM(THIS.this_oBusinessObject.this_cStatusDuplicado) + ;
1768:                             " Digitado em Duplicidade!!!!", ;
1769:                             "Aten" + CHR(231) + CHR(227) + "o")
1770:                         loc_lPodeFechar = .F.
1771:                     ELSE
1772:                         IF !THIS.this_oBusinessObject.GravarStatus(THIS.this_cOperacaoPai)
1773:                             *-- A base/o BO ja exibiram a falha com o texto do

*-- Linhas 1798 a 1816:
1798:     * FASE 8 - TRANSPORTE DA LINHA DA GRADE <-> BO E CONSOLIDACAO
1799:     *
1800:     * Esta tela nao tem campo nenhum fora da grade: a FICHA dela eh UMA LINHA
1801:     * de cursor_4c_Status (cidchaves/dopes/status + descs do join com
1802:     * SigStats). Por isso FormParaBO/BOParaForm transportam a LINHA CORRENTE,
1803:     * e nao um bloco de TextBox de Page2 - que esta tela nao possui.
1804:     *==========================================================================
1805: 
1806:     *==========================================================================
1807:     * ModoEdicaoAtivo - a condicao que abre o cmdSair.Click legado:
1808:     *
1809:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1810:     *
1811:     * Eh o teste de "esta tela esta editavel nesta sessao": o Init legado
1812:     * esconde os dois botoes de linha quando o usuario nao tem acesso
1813:     * (fChecaAcesso) ou quando o pai esta em PROCURAR, e nesse caso o
1814:     * cmdSair.Click nao valida nem grava NADA - so fecha.
1815:     *
1816:     * Fonte UNICA dessa leitura (BtnSairClick e HabilitarCampos): a condicao

*-- Linhas 1839 a 1874:
1839:     * Equivale, nesta tela, ao que num form CRUD seria "ler os TextBox da
1840:     * Page2": a linha da grade EH a ficha. Preenche, na ordem do schema de
1841:     * SIGOPSTS (cidchaves char(20) / dopes char(20) / status char(1)) mais a
1842:     * descricao vinda do join (SigStats.descs char(20)):
1843:     *
1844:     *   this_cCidChaves  <- cursor_4c_Status.cidchaves   (PK gerada no Inserir)
1845:     *   this_cDopes      <- cursor_4c_Status.dopes       (operacao-pai)
1846:     *   this_cStatus     <- a CELULA, quando ela esta em edicao; senao o cursor
1847:     *   this_cDescs      <- cursor_4c_Status.descs       (exibicao, Column2)
1848:     *
1849:     * POR QUE A CELULA VENCE O CURSOR no status: dentro do Valid da celula o
1850:     * valor digitado esta em par_oTxt.Value e o cursor da grade so o recebe
1851:     * DEPOIS que o Valid devolve .T. (regra #46) - ler o cursor ali carregaria
1852:     * o valor ANTIGO. Chamado sem par_oTxt (fora de edicao), le o cursor.
1853:     *
1854:     * this_lNovoRegistro espelha a regra do When legado
1855:     * (Return( Empty( LocalStats.status ) )): linha ainda sem status eh a
1856:     * linha NOVA, criada pelo botao Inserir e nunca resolvida no lookup.
1857:     *
1858:     * Nao muda a area de trabalho corrente: le tudo qualificado pelo alias
1859:     * (cursor_4c_Status.<campo>), sem SELECT. Este form roda na DataSession do
1860:     * PAI (DataSession = 1), onde trocar o alias corrente sem necessidade
1861:     * atrapalha quem chamou.
1862:     *
1863:     * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
1864:     * PROTECTED PROCEDURE FormParaBO (formbase.prg:285), e em VFP9 a subclasse
1865:     * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
1866:     * nao o torna publico, so MENTE para quem le. Medido neste form em
1867:     * 2026-11-18: PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. (Protected) e a
1868:     * chamada de FORA estoura "Property FORMPARABO is not found." - por isso
1869:     * so eh chamado por THIS. de dentro da classe (regra #8), a partir de
1870:     * AbrirLookupStatusStsExec.
1871:     *
1872:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1873:     *==========================================================================
1874:     PROTECTED PROCEDURE FormParaBO(par_oTxt)

*-- Linhas 1891 a 1909:
1891:         THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Status.cidchaves, ""))
1892:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(cursor_4c_Status.dopes, ""))
1893: 
1894:         *-- descs so existe quando o cursor veio do join com SigStats; um
1895:         *-- cursor so com as colunas de SIGOPSTS nao tem esse campo (mesma
1896:         *-- guarda de SigOpStsBO.CarregarDoCursor)
1897:         IF TYPE("cursor_4c_Status.descs") != "U"
1898:             THIS.this_oBusinessObject.this_cDescs = ALLTRIM(NVL(cursor_4c_Status.descs, ""))
1899:         ELSE
1900:             THIS.this_oBusinessObject.this_cDescs = ""
1901:         ENDIF
1902: 
1903:         loc_cStatus = ALLTRIM(NVL(cursor_4c_Status.status, ""))
1904: 
1905:         IF VARTYPE(par_oTxt) = "O"
1906:             IF PEMSTATUS(par_oTxt, "Value", 5)
1907:                 loc_cStatus = ALLTRIM(NVL(par_oTxt.Value, ""))
1908:             ENDIF
1909:         ENDIF

*-- Linhas 1923 a 1981:
1923:     *   This.Value = CrListaRemota.Cods
1924:     *   Replace Descs With CrListaRemota.Descs in LocalStats
1925:     *   This.Refresh
1926:     *   Select LocalStats
1927:     *
1928:     * Grava SO no cursor LOCAL - igual ao legado, que persiste em SIGOPSTS
1929:     * apenas no Encerrar (BtnSairClick -> SigOpStsBO.GravarStatus).
1930:     *
1931:     * LEFT() pela largura da COLUNA no schema (status char(1), descs
1932:     * char(20)), nunca pelo Width em pixels do controle (regra #19): assim o
1933:     * que o cursor recebe eh exatamente o que cabe na coluna do SQL Server no
1934:     * INSERT do Encerrar.
1935:     *
1936:     * par_oTxt eh OPCIONAL: durante o lookup a celula precisa exibir o codigo
1937:     * escolhido (o "This.Value =" do legado); chamado sem ela, so o cursor e a
1938:     * grade sao atualizados.
1939:     *
1940:     * Repinta ao fim (regra #21): gravar no cursor NAO repinta a grade, e sem
1941:     * o Refresh a Column2 continuaria mostrando a descricao anterior.
1942:     *
1943:     * Deixa cursor_4c_Status como alias corrente, igual ao "Select LocalStats"
1944:     * com que o Valid legado termina.
1945:     *
1946:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
1947:     * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280): a subclasse
1948:     * nao alarga o escopo herdado, entao o metodo eh chamado por THIS. de
1949:     * dentro da classe - aqui, por AbrirLookupStatusStsExec.
1950:     *
1951:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1952:     *==========================================================================
1953:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
1954:         LOCAL loc_lSucesso, loc_cStatus, loc_cDescs
1955: 
1956:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1957:             RETURN .F.
1958:         ENDIF
1959: 
1960:         loc_lSucesso = .F.
1961:         loc_cStatus  = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cStatus, "")), 1)
1962:         loc_cDescs   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescs, "")), 20)
1963: 
1964:         IF USED("cursor_4c_Status")
1965:             *-- Legado: Select LocalStats (fica corrente no fim, como no dump)
1966:             SELECT cursor_4c_Status
1967: 
1968:             IF !EOF()
1969:                 *-- Legado: Replace Descs With CrListaRemota.Descs in LocalStats
1970:                 *-- (o status tambem entra aqui: no legado quem o grava eh o
1971:                 *-- bind da Column1 quando o Valid devolve .T., e gravar os
1972:                 *-- dois juntos impede que a linha fique com codigo de um
1973:                 *-- status e descricao de outro)
1974:                 REPLACE status WITH loc_cStatus, ;
1975:                         descs  WITH loc_cDescs
1976:                 loc_lSucesso = .T.
1977:             ENDIF
1978:         ENDIF
1979: 
1980:         *-- Legado: This.Value = CrListaRemota.Cods / This.Refresh
1981:         IF VARTYPE(par_oTxt) = "O"


### BO (C:\4c\projeto\app\classes\SigOpStsBO.prg):
*==============================================================================
* SigOpStsBO.prg - Business Object para "Status por Operacoes" (SIGOPSTS)
*
* Origem legado : SigOpSts.SCX  (tasks\task808)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes)
* Tabela base   : SIGOPSTS | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que mantem a lista de STATUS permitidos para UMA operacao-pai
* (crSigCdOpe.Dopes). O legado recebe no Init "poForm" (o form pai),
* "pnDataSes" (DataSession do pai) e "pcEscolha" (INSERIR/ALTERAR/PROCURAR),
* troca para a DataSession do pai, DESABILITA os botoes do pai
* (mCtrlBotoes(.F.)) e popula um cursor local com:
*
*   Select a.*, b.Descs From SIGOPSTS a, SigStats b
*    Where a.Dopes = '<operacao-pai>' And a.Status = b.cods
*
* A grade (GradeSubN) tem 2 colunas:
*   Column1 -> status (TextBox EDITAVEL com lookup em SigStats.Cods;
*              When = Empty(LocalStats.status), ou seja so a linha NOVA,
*              ainda sem status, aceita digitacao)
*   Column2 -> Descs  (TextBox com When = .F. - somente leitura, a descricao
*              vem do lookup e nao eh digitada)
* Botoes: Inserir (acrescenta UMA linha em branco e foca a Column1),
* Excluir (Delete da linha corrente do cursor) e Encerrar (valida duplicidade,
* grava, reabilita os botoes do pai e fecha).
*
* GRAVACAO - eh REPLACE-ALL, nao linha-a-linha (regra do legado, transcrita)
* ---------------------------------------------------------------------------
* O cmdSair.Click do legado so grava quando (a) Inserir OU Excluir estao
* visiveis (ou seja, o pai esta em INSERIR/ALTERAR) E (b) houve inclusao ou
* exclusao na sessao do dialogo (lHouveIns Or lHouveExcl). Nessa condicao ele:
*   1) valida duplicidade - "Select status, sum(1) as TT From LocalStats
*      Group By 1" e, achando TT > 1, avisa
*      "Status <X> Digitado em Duplicidade!!!!" e ABORTA a gravacao
*      (Return .f. - o dialogo NAO fecha);
*   2) reconstroi o conjunto inteiro: Zap no cursor remoto + um Insert por
*      linha do cursor local, PULANDO (Loop) as linhas com status em branco,
*      sempre com Dopes = <operacao-pai> e CidChaves = fUniqueIds();
*   3) persiste dentro de transacao: Delete From SIGOPSTS Where Dopes =
*      '<operacao-pai>' -> UpDate do cursor -> Commit, com RollBack em
*      qualquer falha e a mensagem
*      "Erro na Gravacao dos Dados do Cadastro de Status.".
* Quem faz os passos 1 a 3 eh ESTE BO (ExisteStatusDuplicado / GravarStatus):
* sao regra de negocio e acesso a dados, nao UI. O form so decide QUANDO
* chamar (clique do Encerrar) e exibe o que o BO devolver.
*
* ESTADO DA SESSAO - DONO UNICO EH ESTE BO
* ----------------------------------------
* lHouveIns / lHouveExcl do legado viram this_lHouveInclusao /
* this_lHouveExclusao AQUI, e nao no form. Motivo: quem decide se grava eh a
* regra de gravacao acima, que mora neste BO; duas copias (uma no form, uma
* no BO) divergem em silencio e o Encerrar passa a ler a copia errada - ou
* grava sem alteracao nenhuma, ou nao grava o que o usuario mexeu, sem erro
* na tela. O form ESCREVE nessas duas properties nos mesmos pontos do legado
* (BtnInserirClick / BtnExcluirClick) e NAO declara copias proprias.
*
* CONTROLE DE ACESSO FICA NO FORM
* -------------------------------
* fChecaAcesso('SIGOPSTS','INSERIR') / fChecaAcesso('SIGOPSTS','EXCLUIR') do
* Init legado decidem Visible/Enabled de cmdInserir/cmdExcluir - isso eh UI e
* fica no form (que tambem combina com this_cEscolha e redimensiona o Shape1,
* igual ao legado). O BO guarda apenas o CONTEXTO recebido do pai
* (this_cOperacaoPai / this_cEscolha / this_nDataSessionPai).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos controles,
* no LEFT() dos comandos SQL e no dimensionamento do cursor da grade
* ---------------------------------------------------------------------------
*   SIGOPSTS.cidchaves  char(20)      NOT NULL  (PK - fUniqueIds())
*   SIGOPSTS.dopes      char(20)      NOT NULL  (FK SigCdOpe.dopes)
*   SIGOPSTS.status     char(1)       NOT NULL  (FK SigStats.cods)
*   SigStats.cods       char(1)       NOT NULL  (codigo do status - lookup)
*   SigStats.descs      char(20)      NOT NULL  (descricao do status)
*   SigStats.chkvisivel numeric(1,0)  NOT NULL
*   SigCdOpe.dopes      char(20)      NOT NULL  (PK e descricao ao mesmo
*                        tempo - SigCdOpe eh single-column, NUNCA usar
*                        descrs/Descs nessa tabela)
*
* As TRES colunas de SIGOPSTS sao NOT NULL e a tabela nao tem outras colunas,
* portanto o INSERT desta entidade cobre a tabela inteira (regra #22).
*==============================================================================

DEFINE CLASS SigOpStsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - uma linha de status da operacao (SIGOPSTS)
    *--------------------------------------------------------------------------
    this_cCidChaves        = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cDopes            = ""   && dopes     char(20) NOT NULL - operacao-pai (FK SigCdOpe.dopes)
    this_cStatus           = ""   && status    char(1)  NOT NULL - codigo do status (FK SigStats.cods)

    *--------------------------------------------------------------------------
    * DESCRICAO DO STATUS - SigStats.descs char(20)
    *
    * NAO pertence a SIGOPSTS: vem do join com SigStats (b.Descs do SELECT do
    * Init legado) e alimenta a Column2 da grade, que eh somente leitura
    * (When = .F.). Entra no cursor da grade e nas properties para a tela
    * poder exibir, mas NUNCA no INSERT/UPDATE de SIGOPSTS.
    *--------------------------------------------------------------------------
    this_cDescs            = ""   && descs     char(20) NOT NULL em SigStats (exibicao)

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Legado: Init(poForm, pnDataSes, pcEscolha) + crSigCdOpe.Dopes
    *--------------------------------------------------------------------------
    this_cOperacaoPai      = ""   && crSigCdOpe.Dopes - operacao corrente na Lista do pai (char(20))
    this_cEscolha          = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_nDataSessionPai   = 0    && pnDataSes do legado (DataSessionId do form pai)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO (dono unico - ver cabecalho)
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSTS
    *--------------------------------------------------------------------------
    this_lHouveInclusao    = .F.  && lhouveins  - o usuario acrescentou linha nesta sessao
    this_lHouveExclusao    = .F.  && lhouveexcl - o usuario excluiu linha nesta sessao

    *--------------------------------------------------------------------------
    * RESULTADO DA VALIDACAO DE DUPLICIDADE
    *
    * Guarda o codigo de status repetido encontrado no cursor da grade, para o
    * form montar a mensagem do legado "Status <X> Digitado em Duplicidade!!!!"
    * com o MESMO codigo que o legado mostraria (Alltrim(Totais.status)).
    *--------------------------------------------------------------------------
    this_cStatusDuplicado  = ""   && codigo do status repetido (vazio = sem duplicidade)

    *--------------------------------------------------------------------------
    * QUANTAS LINHAS O ULTIMO LOTE DE GRAVACAO INSERE
    *
    * MontarLoteGravacao a preenche; GravarStatus a le para saber quantas
    * chaves de loc_aChaves sao validas (VFP nao devolve dois valores, e o
    * array ja eh o parametro por referencia). Zero eh resultado LEGITIMO: o
    * usuario apagou todas as linhas e o lote fica so com o DELETE.
    *--------------------------------------------------------------------------
    this_nLinhasLote       = 0

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - o PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorStatus     = "cursor_4c_Status"   && LocalStats    - linhas de SIGOPSTS da operacao-pai + Descs (grade, READWRITE)
    this_cCursorBusca      = "cursor_4c_Busca"    && CrListaRemota - universo do lookup da Column1 (SigStats: Cods/Descs)
    this_cCursorTotais     = "cursor_4c_Totais"   && Totais        - agrupamento por status usado na checagem de duplicidade

    *--------------------------------------------------------------------------
    * ListarStatusOperacao (Fase 4) - popula this_cCursorStatus
    * (cursor_4c_Status) com o join de SIGOPSTS x SigStats da operacao-pai,
    * equivalente ao Sqlexecute(lcSql, 'LocalStats') do Init legado. Eh o
    * que alimenta a grade do form (FormSigOpSts.CarregarDados). Ver o
    * metodo abaixo para o detalhamento completo.
    *
    * ExisteStatusDuplicado / GravarStatus (Fase 7) - os passos 1 a 3 do
    * cmdSair.Click legado descritos no cabecalho do arquivo: a validacao de
    * duplicidade sobre o cursor da grade e o REPLACE-ALL transacional em
    * SIGOPSTS. Chamados por FormSigOpSts.BtnSairClick ("Encerrar"), que eh o
    * unico ponto de gravacao desta tela. Ver os metodos abaixo.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SIGOPSTS.cidchaves) e repoe o
    * estado inicial da sessao do dialogo, que no legado eh o estado do form
    * recem-criado: nenhuma inclusao e nenhuma exclusao ainda ocorridas, e
    * nenhuma duplicidade detectada.
    *
    * NAO chama fChecaAcesso aqui: a permissao eh decidida no form (ver
    * cabecalho) e a funcao real do Framework legado abre conexao SQL, o que
    * tornaria a simples criacao do BO dependente de banco.
    *
    * NAO passa a tabela para o DODEFAULT(): BusinessBase.Init(pcTabela) so
    * usa o parametro para instanciar um DataAccess, e esta entidade eh
    * gravada por comandos SQL proprios (replace-all em transacao), igual ao
    * legado.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SIGOPSTS"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nDataSessionPai  = 0
        THIS.this_lHouveInclusao   = .F.
        THIS.this_lHouveExclusao   = .F.
        THIS.this_cStatusDuplicado = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de status
    * (SIGOPSTS) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Status, populado pelo join com SigStats, ou qualquer outro
    * cursor/SELECT que inclua as mesmas colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cDopes     = TratarNulo(dopes,     "C")
                THIS.this_cStatus    = TratarNulo(status,    "C")

                *-- Descs vem do JOIN com SigStats (b.Descs do Init legado),
                *-- nao de SIGOPSTS - so existe quando o cursor foi montado
                *-- com o join (cursor_4c_Status); um cursor so com as
                *-- colunas de SIGOPSTS nao tem esse campo.
                IF TYPE(par_cAliasCursor + ".descs") != "U"
                    THIS.this_cDescs = TratarNulo(descs, "C")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarStatusOperacao - Popula cursor_4c_Status com as linhas de
    * SIGOPSTS da operacao-pai, equivalente ao legado:
    *
    *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
    *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
    *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
    *
    * O join com SigStats (igualdade a.Status = b.cods) so traz linhas com
    * status JA preenchido e valido - igual ao legado, cujas linhas em
    * branco inseridas pelo botao Inserir NAO vem desta consulta: elas sao
    * criadas DIRETO no cursor local (CmdInserirClick), nunca
    * reconsultadas aqui.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): a Column1 da grade (status) eh editavel nas linhas sem
    * status ainda (regra do legado When = Empty(status)) e os botoes
    * Inserir/Excluir inserem e apagam linha direto no cursor
    * local, igual ao legado (Insert Into LocalStats / Delete). Sem
    * READWRITE a celula nem entra em edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarStatusOperacao(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg):
        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N"
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.dopes, a.status, b.descs" + ;
                       " FROM SIGOPSTS a" + ;
                       " INNER JOIN SigStats b ON a.status = b.cods" + ;
                       " WHERE a.dopes = " + EscaparSQL(loc_cOperacaoPai)

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_StatusTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Status")
                    USE IN cursor_4c_Status
                ENDIF

                SELECT * FROM cursor_4c_StatusTmp INTO CURSOR cursor_4c_Status READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar os status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_StatusTmp")
                USE IN cursor_4c_StatusTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.ListarStatusOperacao:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteStatusDuplicado - 1a validacao do cmdSair.Click legado:
    *
    *   Select status,sum(1) as TT From LocalStats GROUP by 1 Into cursor Totais
    *   Select Totais
    *   Scan
    *       If TT > 1
    *           MessageBox('Status '+Alltrim(Totais.status)+ ;
    *                      ' Digitado em Duplicidade!!!!',0+16,'Atencao')
    *           Return .f.
    *       EndIf
    *   EndScan
    *
    * Guarda em this_cStatusDuplicado o codigo do PRIMEIRO status repetido: o
    * "Return .f." do legado esta DENTRO do Scan, portanto ele para no primeiro
    * grupo com TT > 1 e eh esse codigo que aparece na mensagem. Guardar a
    * lista inteira mudaria a mensagem da tela.
    *
    * TRANSCRICAO LITERAL (regra #17): o "GROUP by 1" agrupa pela coluna 1
    * (status) SEM excluir o status em branco, logo DUAS linhas novas ainda sem
    * status tambem contam como duplicidade - e a mensagem sai com o codigo
    * vazio ("Status  Digitado em Duplicidade!!!!"). Esse eh o comportamento da
    * tela e NAO se "conserta" aqui: eh ele que impede o usuario de acumular
    * varias linhas em branco na grade.
    *
    * Linha marcada para exclusao NAO entra: SET DELETED ON (config.prg) a
    * esconde do SELECT, igual ao legado.
    *
    * O alias corrente eh salvo e restaurado: este dialogo roda na DataSession
    * do form pai (DataSession = 1), onde deixar outro alias selecionado
    * atrapalharia quem chamou.
    *
    * Metodo PUBLIC (regra #51): quem o chama eh o Encerrar do form, de fora
    * desta classe - PROTECTED faria a chamada estourar em runtime.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ExisteStatusDuplicado()
        LOCAL loc_cAliasAnterior, loc_lDuplicado

        THIS.this_cStatusDuplicado = ""

        IF !USED(THIS.this_cCursorStatus)
            RETURN .F.
        ENDIF

        loc_lDuplicado     = .F.
        loc_cAliasAnterior = ALIAS()

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        SELECT status, SUM(1) AS tt ;
            FROM (THIS.this_cCursorStatus) ;
            GROUP BY 1 ;
            INTO CURSOR (THIS.this_cCursorTotais) READWRITE

        *-- Legado: Scan / If TT > 1 -> mensagem com ESTE status e para
        SELECT (THIS.this_cCursorTotais)
        SCAN
            IF tt > 1
                THIS.this_cStatusDuplicado = ALLTRIM(NVL(status, ""))
                loc_lDuplicado = .T.
                EXIT
            ENDIF
        ENDSCAN

        IF USED(THIS.this_cCursorTotais)
            USE IN (THIS.this_cCursorTotais)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarLoteGravacao - monta o LOTE SQL unico do REPLACE-ALL de
    * GravarStatus (ver o comentario daquele metodo para o legado completo) e
    * devolve, em par_aChaves, as PKs que o lote insere; this_nLinhasLote diz
    * quantas posicoes do array sao validas.
    *
    * Transcreve duas coisas do legado, nesta ordem:
    *   1. "Delete From SIGOPSTS Where Dopes = '<op>'" - INCONDICIONAL, e
    *      ANTES dos inserts, para nao apagar o que acabou de entrar. Lote so
    *      com o DELETE eh resultado LEGITIMO: eh o usuario que apagou todas as
    *      linhas da grade.
    *   2. "Scan / Scatter Memvar / If Empty(m.status) -> Loop / Insert Into
    *      CrSIGOPSTS (Dopes,status,CidChaves)" - uma linha por status
    *      PREENCHIDO, descartando a linha em branco que o botao Inserir criou
    *      e o usuario nao completou (status eh char(1) NOT NULL - regra #22).
    *      Linha marcada para exclusao nao entra: SET DELETED ON a esconde do
    *      SCAN, igual ao legado.
    *
    * Envelope transacional em T-SQL, num SQLEXEC unico (nao em SQLEXEC
    * separados): a conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1,
    * entao BEGIN/COMMIT avulsos so ANINHAM e o COMMIT nao efetiva. SAVE
    * TRANSACTION cobre o caso (normal) de ja haver transacao aberta, e o THROW
    * faz o erro chegar ao SQLEXEC, que devolve -1 e deixa CapturarErroSQL()
    * com a mensagem real.
    *
    * EXTRAIDO de GravarStatus de proposito: assim o TEXTO do lote pode ser
    * conferido sem banco (o SQL Server deste projeto eh inalcancavel da
    * maquina do pipeline), e a montagem - que eh a regra do legado - fica
    * separada da execucao/transacao, que eh infraestrutura.
    *
    * PROTECTED: eh peca interna de GravarStatus, nao se chama de fora (regra
    * #51); o harness de teste a alcanca por SUBCLASSE.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarLoteGravacao(par_cOperacaoPai, par_aChaves)
        LOCAL loc_cStmts, loc_cStatus, loc_cCidChaves, loc_cOperacaoPai, ;
              loc_cAliasAnterior

        THIS.this_nLinhasLote = 0
        loc_cStmts            = ""
        loc_cOperacaoPai      = LEFT(IIF(VARTYPE(par_cOperacaoPai) = "C", ;
                                         par_cOperacaoPai, ""), 20)

        IF USED(THIS.this_cCursorStatus)
            loc_cAliasAnterior = ALIAS()
            SELECT (THIS.this_cCursorStatus)

            SCAN
                loc_cStatus = LEFT(ALLTRIM(NVL(status, "")), 1)

                IF !EMPTY(loc_cStatus)
                    *-- cidchaves eh a PK Fortyus (regra #22): SEMPRE gerada
                    *-- com fUniqueIds(), nunca em branco - o legado tambem a
                    *-- regera a cada linha do Zap/Insert
                    loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)

                    THIS.this_nLinhasLote = THIS.this_nLinhasLote + 1
                    DIMENSION par_aChaves[THIS.this_nLinhasLote]
                    par_aChaves[THIS.this_nLinhasLote] = loc_cCidChaves

                    loc_cStmts = loc_cStmts + ;
                        "INSERT INTO SIGOPSTS (cidchaves, dopes, status) VALUES (" + ;
                        EscaparSQL(loc_cCidChaves) + ", " + ;
                        EscaparSQL(loc_cOperacaoPai) + ", " + ;
                        EscaparSQL(loc_cStatus) + "); "
                ENDIF
            ENDSCAN

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF
        ENDIF

        RETURN "SET NOCOUNT ON; " + ;
            "DECLARE @nivel int = @@TRANCOUNT; " + ;
            "IF @nivel = 0 BEGIN TRANSACTION " + ;
            "ELSE SAVE TRANSACTION Sts4c; " + ;
            "BEGIN TRY " + ;
            "DELETE FROM SIGOPSTS WHERE dopes = " + ;
            EscaparSQL(loc_cOperacaoPai) + "; " + ;
            loc_cStmts + ;
            "IF @nivel = 0 COMMIT TRANSACTION; " + ;
            "END TRY " + ;
            "BEGIN CATCH " + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Sts4c; END; " + ;
            "THROW; " + ;
            "END CATCH"
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarStatus - persiste a lista de status da operacao-pai. Equivale ao
    * bloco de gravacao do cmdSair.Click legado, que eh um REPLACE-ALL:
    *
    *   Select CrSIGOPSTS
    *   Zap
    *   Select LocalStats
    *   Scan
    *       Scatter Memvar
    *       If Empty(m.status)
    *           Loop
    *       Endif
    *       Insert Into CrSIGOPSTS (Dopes,status,CidChaves) Values ;
    *           (CrSigCdOpe.Dopes,m.status,fUniqueIds())
    *   EndScan
    *   m.lnErro1 = ThisForm.ParentForm.poDatamgr.pnIdConn
    *   If m.lnErro1>0 : lcDelete = [Delete From SIGOPSTS Where Dopes = '<op>']
    *                    m.lnErro1 = Iif(.poDataMgr.SqlExecute(lcDelete,'')>0,1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSIGOPSTS'),1,-1)
    *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
    *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
    *   If Not m.lnErro1>0 : MessageBox('Erro na Gravacao dos Dados do
    *                                   Cadastro de Status.',48)
    *
    * O "Zap + Scan + Insert" enche a view remota com o conjunto NOVO INTEIRO
    * (toda linha fica nova, logo o UpDate manda INSERT) e o Delete apaga o
    * conjunto ANTIGO: o efeito liquido eh SUBSTITUIR todos os status da
    * operacao. Por isso o DELETE eh INCONDICIONAL e roda mesmo quando nao
    * sobrou nenhuma linha com status preenchido - o usuario que apagou todas
    * as linhas da grade quer a operacao sem status nenhum, e um "nada a
    * gravar" ali engoliria essa intencao em silencio.
    *
    * "If Empty(m.status) / Loop" eh o descarte da linha em branco: a linha que
    * o botao Inserir criou e o usuario nao preencheu NAO vai para o banco
    * (status eh char(1) NOT NULL - regra #22).
    *
    * ATOMICIDADE: o legado faz Delete + N Inserts numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    * Mesmo lote canonico de SigOpNchBO.GravarNumeracao.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *
    * As duas flags de sessao sao ZERADAS no sucesso: elas sao o guard que faz
    * o Encerrar gravar UMA vez ("If (lHouveExcl Or lHouveIns)" do legado). No
    * legado o dialogo fecha logo apos gravar e nao existe um segundo Encerrar;
    * zerar aqui garante o mesmo efeito - um segundo Encerrar com a grade
    * intacta nao repetiria Delete + Insert (que regravaria o MESMO conjunto
    * com cidchaves novas e poluiria a auditoria).
    *
    * A auditoria (LogAuditoria, exigencia do sistema novo - o legado nao a
    * tem) roda DEPOIS do commit, uma linha por status efetivamente gravado, e
    * nunca dentro do lote: o lote eh montado para ser atomico sobre SIGOPSTS e
    * a auditoria nao pode poder derruba-lo.
    *
    * Metodo PUBLIC (regra #51): chamado pelo Encerrar do form.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION GravarStatus(par_cOperacaoPai)
        LOCAL loc_cOperacaoPai, loc_cAliasAnterior, loc_nLinhas, loc_cLote, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_lSucesso, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        loc_lManual  = .F.
        loc_nLinhas  = 0
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        loc_cOperacaoPai = IIF(VARTYPE(par_cOperacaoPai) = "C" AND ;
                               !EMPTY(par_cOperacaoPai), par_cOperacaoPai, ;
                               THIS.this_cOperacaoPai)

        *-- Sem operacao-pai o DELETE apagaria o conjunto de OUTRA operacao (a
        *-- de codigo em branco): recusar eh o unico caminho seguro
        IF EMPTY(loc_cOperacaoPai)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informada."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        *-- SQLEXEC com handle invalido dispara excecao em vez de devolver -1
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                CHR(237) + "vel."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        TRY
            loc_lManual        = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            loc_cAliasAnterior = ALIAS()

            *-- Monta o lote e devolve em loc_aChaves as PKs que ele insere
            loc_cLote   = THIS.MontarLoteGravacao(loc_cOperacaoPai, @loc_aChaves)
            loc_nLinhas = THIS.this_nLinhasLote

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

            IF loc_nResultado < 0
                loc_cErro = CapturarErroSQL()

                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF

                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                    "o dos Dados do Cadastro de Status." + CHR(13) + loc_cErro
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Commit do legado (.poDataMgr.Commit())
                loc_lSucesso = .T.

                IF loc_lManual
                    IF SQLCOMMIT(gnConnHandle) < 1
                        = SQLROLLBACK(gnConnHandle)
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                            CHR(227) + "o dos Dados do Cadastro de Status." + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                    *-- O guard do Encerrar volta ao zero: o conjunto no banco
                    *-- passou a ser exatamente o da grade
                    THIS.this_lHouveInclusao = .F.
                    THIS.this_lHouveExclusao = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                SELECT (loc_cAliasAnterior)
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro em SigOpStsBO.GravarStatus:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoriaLote - grava em LogAuditoria uma linha por status
    * efetivamente gravado pelo lote de GravarStatus.
    *
    * RegistrarAuditoria do BusinessBase le a chave por ObterChavePrimaria(),
    * que devolve this_cCidChaves - por isso a property eh posicionada em cada
    * volta do laco e restaurada no fim (o chamador nao pode perceber que ela
    * foi usada como variavel de laco).
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SIGOPSTS e a auditoria nao pode poder derruba-lo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cCidChavesAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cCidChavesAnterior = THIS.this_cCidChaves

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cCidChaves = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("INSERT")
            ENDFOR

            THIS.this_cCidChaves = loc_cCidChavesAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de status (SIGOPSTS) no banco.
    * Equivalente ao trecho do legado cmdSair.Click que, dentro da transacao
    * de GravarStatus, faz "Insert Into SIGOPSTS (Dopes, Status, CidChaves)
    * Values (<operacao-pai>, <status>, fUniqueIds())" para cada linha do
    * cursor local com status preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- cidchaves eh a PK Fortyus (regra #22): gerar com fUniqueIds(),
            *-- NUNCA deixar vazia - senao o proximo registro colide no indice unico
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SIGOPSTS (cidchaves, dopes, status)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       EscaparSQL(THIS.this_cStatus) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSts")
                USE IN cursor_4c_InsSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de status (SIGOPSTS) ja existente.
    * As tres colunas da entidade sao NOT NULL (regra #22) - o UPDATE regrava
    * dopes e status pela chave cidchaves.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGOPSTS SET" + ;
                       " dopes  = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " status = " + EscaparSQL(THIS.this_cStatus) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSts")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar status da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSts")
                USE IN cursor_4c_UpdSts
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpStsBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

