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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSts.prg) - TRECHOS RELEVANTES PARA PASS SQL (2198 linhas total):

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

*-- Linhas 1052 a 1103:
1052:     *
1053:     *   With Thisform.GradeSubN
1054:     *       .RecordSource          = 'LocalStats'
1055:     *       .Column1.ControlSource = 'LocalStats.status'
1056:     *       .Column2.ControlSource = 'LocalStats.Descs'
1057:     *       .Refresh
1058:     *   EndWith
1059:     *
1060:     * O alias eh o literal cursor_4c_Status (valor de SigOpStsBO.
1061:     * this_cCursorStatus) - INTO CURSOR do BO e RecordSource daqui precisam
1062:     * casar, e um nome fixo nos dois lados nao tem como divergir.
1063:     *
1064:     * Width / Header1.Caption / Header1.Alignment / ReadOnly sao
1065:     * REAPLICADOS depois do bind: atribuir RecordSource/ControlSource
1066:     * reseta a largura das colunas para o default 90 e o cabecalho para
1067:     * "Column1"/"Column2" (Problema 48 / regra #41). Por isso este bloco
1068:     * repete os valores de ConfigurarGrade em vez de so configura-los la.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE VincularGrade
1071:         IF !USED("cursor_4c_Status")
1072:             RETURN .F.
1073:         ENDIF
1074: 
1075:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1076:             RETURN .F.
1077:         ENDIF
1078: 
1079:         *-- RecordSource FORA do WITH: colunas nao sao recriadas de
1080:         *-- imediato dentro de um WITH, e acessar .Column1/.Column2 no
1081:         *-- mesmo bloco pode estourar "Unknown member COLUMN1"
1082:         THIS.grd_4c_Dados.RecordSource = ""
1083:         THIS.grd_4c_Dados.ColumnCount = 2
1084:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Status"
1085: 
1086:         WITH THIS.grd_4c_Dados
1087:             .Column1.ControlSource = "cursor_4c_Status.status"
1088:             .Column2.ControlSource = "cursor_4c_Status.descs"
1089: 
1090:             *-- Reaplicar o que o rebind acabou de resetar
1091:             .Column1.Width = 40
1092:             .Column2.Width = 235
1093: 
1094:             .Column1.Header1.Alignment = 2
1095:             .Column2.Header1.Alignment = 2
1096:             .Column1.Header1.Caption   = "Status"
1097:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1098: 
1099:         ENDWITH
1100: 
1101:         *-- O rebind reseta CurrentControl/Sparse e, quando o ColumnCount
1102:         *-- acima RECRIOU as Columns, o proprio controle da celula deixou de
1103:         *-- existir: reinstalar num lugar so (regra #18/#41) - ver a medicao

*-- Linhas 1202 a 1223:
1202:     *
1203:     * Equivale ao bloco do Init legado que consulta e religa a grade:
1204:     *
1205:     *   lcSql = [Select a.*,b.Descs From SIGOPSTS a, SigStats b Where
1206:     *            a.Dopes = '<operacao-pai>' And a.Status = b.cods]
1207:     *   ThisForm.ParentForm.PodataMgr.Sqlexecute(lcsql,'LocalStats')
1208:     *   Select LocalStats / Goto Top
1209:     *   With Thisform.GradeSubN ... .Refresh
1210:     *
1211:     * No migrado, quem produz o cursor eh SigOpStsBO.ListarStatusOperacao
1212:     * (mesma consulta, filtrada pela operacao-pai), e o Go Top + Refresh vem
1213:     * DEPOIS do bind - popular o cursor NAO repinta a grade sozinho (regra
1214:     * #21).
1215:     *
1216:     * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
1217:     * e os Click dos botoes alcancam de fora - PROTECTED
1218:     * faria a chamada externa estourar em runtime (regra #3/#51).
1219:     *
1220:     * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
1221:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1222:     * reportada por ListarStatusOperacao.
1223:     *==========================================================================

*-- Linhas 1243 a 1263:
1243:                 IF THIS.this_oBusinessObject.ListarStatusOperacao(THIS.this_cOperacaoPai)
1244:                     THIS.VincularGrade()
1245: 
1246:                     *-- Legado: Select LocalStats / Goto Top
1247:                     IF USED("cursor_4c_Status")
1248:                         SELECT cursor_4c_Status
1249:                         GO TOP
1250:                     ENDIF
1251: 
1252:                     *-- Legado: Thisform.GradeSubN.Refresh
1253:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1254:                         THIS.grd_4c_Dados.Refresh()
1255:                     ENDIF
1256: 
1257:                     loc_lSucesso = .T.
1258:                 ENDIF
1259:             ENDIF
1260:         CATCH TO loc_oErro
1261:             MsgErro("Erro ao carregar os status da opera" + CHR(231) + CHR(227) + ;
1262:                 "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1263:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1316 a 1334:
1316:     *       Replace Descs With CrListaRemota.Descs in LocalStats
1317:     *       This.Refresh
1318:     *   EndIf
1319:     *   Select LocalStats
1320:     *   Return .t.
1321:     *
1322:     * O "lcDopes = crSigCdOpe.Dopes" do legado eh leitura morta (a variavel
1323:     * nunca eh usada depois) - nao ha o que transcrever dela.
1324:     *
1325:     * Celula VAZIA nao dispara nada, igual ao legado: o usuario pode
1326:     * atravessar a linha em branco com Tab sem levar dialogo nenhum.
1327:     *
1328:     * Dentro do Valid o valor digitado esta em par_oTxt.Value - o cursor da
1329:     * grade so o recebe DEPOIS que este metodo devolve .T. (regra #46), e
1330:     * por isso ler cursor_4c_Status.status aqui validaria o valor ANTIGO.
1331:     *
1332:     * RETURN .T. sempre, igual ao legado (o "Return .t." final) - o codigo
1333:     * invalido nao prende o foco na celula; quem resolve/limpa eh o picker.
1334:     *

*-- Linhas 1447 a 1465:
1447:             ENDIF
1448: 
1449:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1450:                 SELECT cursor_4c_Busca
1451:                 loc_cCodigo    = ALLTRIM(NVL(cursor_4c_Busca.cods,  ""))
1452:                 loc_cDescricao = ALLTRIM(NVL(cursor_4c_Busca.descs, ""))
1453:                 loc_lResolveu  = !EMPTY(loc_cCodigo)
1454:             ENDIF
1455: 
1456:             loc_oBusca.Release()
1457:         ENDIF
1458: 
1459:         IF USED("cursor_4c_Busca")
1460:             USE IN cursor_4c_Busca
1461:         ENDIF
1462: 
1463:         *-- O resultado do picker volta para a linha PELA FICHA (o BO), que eh
1464:         *-- o transporte desta tela (Fase 8): FormParaBO carrega a identidade
1465:         *-- da linha corrente, o resultado do lookup sobrescreve status/descs e

*-- Linhas 1475 a 1493:
1475:             THIS.this_oBusinessObject.this_cDescs  = IIF(loc_lResolveu, loc_cDescricao, "")
1476:         ENDIF
1477: 
1478:         *-- Legado: Select LocalStats / This.Refresh (+ a grade, para a Column2
1479:         *-- exibir a descricao que acabou de ser gravada no cursor - regra #21)
1480:         THIS.BOParaForm(par_oTxt)
1481:     ENDPROC
1482: 
1483:     *==========================================================================
1484:     * StatusGradeLostFocus - LostFocus do Column1.Text1 legado:
1485:     *
1486:     *   If IsEmpty(This.Value)
1487:     *       Thisform.cmdSair.SetFocus
1488:     *   EndIf
1489:     *
1490:     * Celula abandonada em branco devolve o foco ao botao Encerrar: com
1491:     * TitleBar = 0 e ControlBox = .F. ele eh a unica saida da tela, e o
1492:     * legado nao deixa o foco preso numa linha que nao vai ser gravada.
1493:     *

*-- Linhas 1533 a 1576:
1533:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1534:     *
1535:     *   Thisform.lHouveIns = .T.
1536:     *   Select LocalStats
1537:     *   Locate for Dopes = crSigCdOpe.Dopes And status = ' '
1538:     *   If Eof()
1539:     *       Insert Into LocalStats (Dopes, CidChaves) ;
1540:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1541:     *   EndIf
1542:     *   Select LocalStats
1543:     *   Thisform.GradeSubN.Column1.SetFocus
1544:     *
1545:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1546:     * criada na vez anterior ainda nao foi preenchida, o legado REAPROVEITA ela
1547:     * em vez de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o
1548:     * foco vai parar). Sem esse guard o usuario acumularia linhas em branco e
1549:     * seria barrado na gravacao pela validacao de duplicidade, que conta o
1550:     * status vazio junto com os demais (ver SigOpStsBO.ExisteStatusDuplicado).
1551:     *
1552:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre o cursor
1553:     * do pai e so persiste no Encerrar (Zap + Insert + UpDate + Commit ->
1554:     * BtnSairClick / SigOpStsBO.GravarStatus). A PK vai ja preenchida com
1555:     * fUniqueIds() (regra #22: cidchaves NUNCA em branco).
1556:     *
1557:     * O status fica vazio de proposito: eh justamente isso que faz o When da
1558:     * celula (CelulaStatusEditavel) liberar a digitacao NESTA linha e manter as
1559:     * demais travadas.
1560:     *
1561:     * O "Select LocalStats" final do legado nao precisa ser reproduzido como
1562:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1563:     * DataSession do PAI (DataSession = 1), onde deixar outro alias selecionado
1564:     * atrapalharia quem chamou - por isso o alias anterior eh restaurado.
1565:     *
1566:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1567:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) = .T.).
1568:     * NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1569:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1570:     * read-only") e derrubaria o handler.
1571:     *
1572:     * Repinta a grade antes de focar: inserir no cursor NAO repinta sozinho
1573:     * (regra #21a) e a linha nova so aparece depois do Refresh.
1574:     *
1575:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1576:     *==========================================================================

*-- Linhas 1586 a 1617:
1586:                 ENDIF
1587: 
1588:                 loc_cAliasAnterior = ALIAS()
1589:                 SELECT cursor_4c_Status
1590: 
1591:                 LOCATE FOR ALLTRIM(NVL(dopes, "")) == ALLTRIM(THIS.this_cOperacaoPai) ;
1592:                     AND EMPTY(NVL(status, ""))
1593: 
1594:                 IF !FOUND()
1595:                     loc_cCidChaves = LEFT(ALLTRIM(fUniqueIds()), 20)
1596: 
1597:                     INSERT INTO cursor_4c_Status (dopes, cidchaves) ;
1598:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1599:                 ENDIF
1600: 
1601:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1602:                     SELECT (loc_cAliasAnterior)
1603:                 ENDIF
1604: 
1605:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1606:                     THIS.grd_4c_Dados.Refresh()
1607: 
1608:                     *-- Column1 so existe com a grade VINCULADA: medido no
1609:                     *-- VFP9 (ver GarantirCelulaStatus), grade que perdeu o
1610:                     *-- alias fica com ColumnCount = 0 e o SetFocus estoura
1611:                     *-- "Unknown member COLUMN1" - erro cru na cara do
1612:                     *-- usuario DEPOIS de a linha ja ter sido inserida
1613:                     IF PEMSTATUS(THIS.grd_4c_Dados, "Column1", 5)
1614:                         THIS.grd_4c_Dados.Column1.SetFocus()
1615:                     ENDIF
1616:                 ENDIF
1617:             ENDIF

*-- Linhas 1626 a 1740:
1626:     *==========================================================================
1627:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1628:     *
1629:     *   Select LocalStats
1630:     *   If Not Eof()
1631:     *       Thisform.lHouveExcl = .T.
1632:     *       Delete
1633:     *       Skip
1634:     *       Skip - 1
1635:     *   Endif
1636:     *   Thisform.GradeSubN.Refresh
1637:     *
1638:     * O legado NAO confere a operacao-pai da linha aqui (diferente do dialogo
1639:     * irmao SIGOPSQN, que testa cDopes antes de apagar) - e nao precisa: o
1640:     * cursor desta tela ja vem filtrado pela operacao-pai
1641:     * (SigOpStsBO.ListarStatusOperacao) e as linhas novas nascem com a mesma
1642:     * operacao (CmdInserirClick). Transcrito como esta: acrescentar a condicao
1643:     * aqui seria inventar regra que o legado nao tem (regra #21b).
1644:     *
1645:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1646:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1647:     * config.prg - a linha marcada desaparece da grade de imediato).
1648:     *
1649:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1650:     * Encerrar, e la ele eh um DELETE do conjunto INTEIRO da operacao seguido
1651:     * da reinsercao do que sobrou na grade (REPLACE-ALL - ver
1652:     * SigOpStsBO.GravarStatus), e nao um DELETE por linha.
1653:     *
1654:     * O Refresh fica FORA do IF, como no dump.
1655:     *
1656:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1657:     *==========================================================================
1658:     PROCEDURE CmdExcluirClick
1659:         LOCAL loc_cAliasAnterior, loc_oErro
1660: 
1661:         TRY
1662:             IF USED("cursor_4c_Status")
1663:                 loc_cAliasAnterior = ALIAS()
1664:                 SELECT cursor_4c_Status
1665: 
1666:                 IF !EOF()
1667:                     *-- Legado: Thisform.lHouveExcl = .T. (dono unico da flag
1668:                     *-- eh o BO - ver cabecalho de SigOpStsBO.prg)
1669:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1670:                         THIS.this_oBusinessObject.this_lHouveExclusao = .T.
1671:                     ENDIF
1672: 
1673:                     DELETE
1674:                     SKIP
1675:                     SKIP -1
1676:                 ENDIF
1677: 
1678:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1679:                     SELECT (loc_cAliasAnterior)
1680:                 ENDIF
1681:             ENDIF
1682: 
1683:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1684:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1685:                 THIS.grd_4c_Dados.Refresh()
1686:             ENDIF
1687:         CATCH TO loc_oErro
1688:             MsgErro(loc_oErro.Message + CHR(13) + ;
1689:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1690:                     "Procedure: " + loc_oErro.Procedure, ;
1691:                     "Erro em CmdExcluirClick")
1692:         ENDTRY
1693:     ENDPROC
1694: 
1695:     *==========================================================================
1696:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1697:     * tambem dispara no ESC). Transcrito:
1698:     *
1699:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1700:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1701:     *           Select LocalStats / Go Bottom / Go Top
1702:     *           <validacao: status duplicado> -> MessageBox + Return .f.
1703:     *           <Zap + Insert + Delete + UpDate + Commit, com RollBack e
1704:     *            MessageBox 'Erro na Gravacao dos Dados do Cadastro de
1705:     *            Status.'>
1706:     *       EndIf
1707:     *   ENDIF
1708:     *   Thisform.ParentForm.Enabled = .T.
1709:     *   Thisform.mCtrlBotoes(.T.)
1710:     *   ThisForm.Release
1711:     *
1712:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO a validacao de
1713:     * duplicidade aborta o fechamento (o "Return .f." do legado, que esta
1714:     * dentro do Scan dos totais); a FALHA DE GRAVACAO exibe a mensagem e FECHA
1715:     * do mesmo jeito, porque no legado o RollBack ja desfez tudo. Manter o
1716:     * dialogo aberto nesse caso convidaria a um segundo Encerrar, que repetiria
1717:     * o Delete + Insert do conjunto inteiro.
1718:     *
1719:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR ou
1720:     * usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1721:     * Sessao sem inclusao nem exclusao: idem - este eh o guard que faz a tela
1722:     * nao reescrever o conjunto so por ter sido aberta.
1723:     *
1724:     * "Go Bottom / Go Top" do legado forcava o cursor remoto bufferizado a
1725:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1726:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1727:     *
1728:     * MsgAviso (nao MsgErro) na duplicidade: eh validacao de entrada do
1729:     * usuario, nao falha tecnica - o dialogo vermelho com "Fechar Aplicacao" do
1730:     * MsgErro/MostrarErro eh reservado a exception. A mensagem eh a do legado,
1731:     * ao pe da letra, inclusive os quatro pontos de exclamacao e o codigo do
1732:     * PRIMEIRO status repetido (this_cStatusDuplicado).
1733:     *
1734:     * A falha de gravacao NAO eh reanunciada aqui quando o BO ja a exibiu
1735:     * (this_lErroExibido - regra #20): o GravarStatus mostra o texto do legado
1736:     * junto com a mensagem real do SQL Server, que eh mais util.
1737:     *
1738:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1739:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos do
1740:     * pai porque la o pai ficava com os controles desabilitados um a um - aqui

*-- Linhas 1758 a 1778:
1758:                    (THIS.this_oBusinessObject.this_lHouveExclusao OR ;
1759:                     THIS.this_oBusinessObject.this_lHouveInclusao)
1760: 
1761:                     *-- Legado: Select LocalStats / Go Bottom / Go Top
1762:                     IF USED("cursor_4c_Status")
1763:                         SELECT cursor_4c_Status
1764:                         GO BOTTOM
1765:                         GO TOP
1766:                     ENDIF
1767: 
1768:                     IF THIS.this_oBusinessObject.ExisteStatusDuplicado()
1769:                         *-- Legado: 'Status '+Alltrim(Totais.status)+
1770:                         *-- ' Digitado em Duplicidade!!!!'
1771:                         MsgAviso("Status " + ;
1772:                             ALLTRIM(THIS.this_oBusinessObject.this_cStatusDuplicado) + ;
1773:                             " Digitado em Duplicidade!!!!", ;
1774:                             "Aten" + CHR(231) + CHR(227) + "o")
1775:                         loc_lPodeFechar = .F.
1776:                     ELSE
1777:                         IF !THIS.this_oBusinessObject.GravarStatus(THIS.this_cOperacaoPai)
1778:                             *-- A base/o BO ja exibiram a falha com o texto do

*-- Linhas 1803 a 1821:
1803:     * FASE 8 - TRANSPORTE DA LINHA DA GRADE <-> BO E CONSOLIDACAO
1804:     *
1805:     * Esta tela nao tem campo nenhum fora da grade: a FICHA dela eh UMA LINHA
1806:     * de cursor_4c_Status (cidchaves/dopes/status + descs do join com
1807:     * SigStats). Por isso FormParaBO/BOParaForm transportam a LINHA CORRENTE,
1808:     * e nao um bloco de TextBox de Page2 - que esta tela nao possui.
1809:     *==========================================================================
1810: 
1811:     *==========================================================================
1812:     * ModoEdicaoAtivo - a condicao que abre o cmdSair.Click legado:
1813:     *
1814:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1815:     *
1816:     * Eh o teste de "esta tela esta editavel nesta sessao": o Init legado
1817:     * esconde os dois botoes de linha quando o usuario nao tem acesso
1818:     * (fChecaAcesso) ou quando o pai esta em PROCURAR, e nesse caso o
1819:     * cmdSair.Click nao valida nem grava NADA - so fecha.
1820:     *
1821:     * Fonte UNICA dessa leitura (BtnSairClick e HabilitarCampos): a condicao

*-- Linhas 1844 a 1879:
1844:     * Equivale, nesta tela, ao que num form CRUD seria "ler os TextBox da
1845:     * Page2": a linha da grade EH a ficha. Preenche, na ordem do schema de
1846:     * SIGOPSTS (cidchaves char(20) / dopes char(20) / status char(1)) mais a
1847:     * descricao vinda do join (SigStats.descs char(20)):
1848:     *
1849:     *   this_cCidChaves  <- cursor_4c_Status.cidchaves   (PK gerada no Inserir)
1850:     *   this_cDopes      <- cursor_4c_Status.dopes       (operacao-pai)
1851:     *   this_cStatus     <- a CELULA, quando ela esta em edicao; senao o cursor
1852:     *   this_cDescs      <- cursor_4c_Status.descs       (exibicao, Column2)
1853:     *
1854:     * POR QUE A CELULA VENCE O CURSOR no status: dentro do Valid da celula o
1855:     * valor digitado esta em par_oTxt.Value e o cursor da grade so o recebe
1856:     * DEPOIS que o Valid devolve .T. (regra #46) - ler o cursor ali carregaria
1857:     * o valor ANTIGO. Chamado sem par_oTxt (fora de edicao), le o cursor.
1858:     *
1859:     * this_lNovoRegistro espelha a regra do When legado
1860:     * (Return( Empty( LocalStats.status ) )): linha ainda sem status eh a
1861:     * linha NOVA, criada pelo botao Inserir e nunca resolvida no lookup.
1862:     *
1863:     * Nao muda a area de trabalho corrente: le tudo qualificado pelo alias
1864:     * (cursor_4c_Status.<campo>), sem SELECT. Este form roda na DataSession do
1865:     * PAI (DataSession = 1), onde trocar o alias corrente sem necessidade
1866:     * atrapalha quem chamou.
1867:     *
1868:     * PROTECTED EXPLICITO, e nao por escolha de estilo: FormBase declara
1869:     * PROTECTED PROCEDURE FormParaBO (formbase.prg:285), e em VFP9 a subclasse
1870:     * NAO pode ALARGAR o escopo herdado - escrever o metodo sem o modificador
1871:     * nao o torna publico, so MENTE para quem le. Medido neste form em
1872:     * 2026-11-18: PEMSTATUS(oForm, "FormParaBO", 2) devolve .T. (Protected) e a
1873:     * chamada de FORA estoura "Property FORMPARABO is not found." - por isso
1874:     * so eh chamado por THIS. de dentro da classe (regra #8), a partir de
1875:     * AbrirLookupStatusStsExec.
1876:     *
1877:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1878:     *==========================================================================
1879:     PROTECTED PROCEDURE FormParaBO(par_oTxt)

*-- Linhas 1896 a 1914:
1896:         THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(cursor_4c_Status.cidchaves, ""))
1897:         THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(cursor_4c_Status.dopes, ""))
1898: 
1899:         *-- descs so existe quando o cursor veio do join com SigStats; um
1900:         *-- cursor so com as colunas de SIGOPSTS nao tem esse campo (mesma
1901:         *-- guarda de SigOpStsBO.CarregarDoCursor)
1902:         IF TYPE("cursor_4c_Status.descs") != "U"
1903:             THIS.this_oBusinessObject.this_cDescs = ALLTRIM(NVL(cursor_4c_Status.descs, ""))
1904:         ELSE
1905:             THIS.this_oBusinessObject.this_cDescs = ""
1906:         ENDIF
1907: 
1908:         loc_cStatus = ALLTRIM(NVL(cursor_4c_Status.status, ""))
1909: 
1910:         IF VARTYPE(par_oTxt) = "O"
1911:             IF PEMSTATUS(par_oTxt, "Value", 5)
1912:                 loc_cStatus = ALLTRIM(NVL(par_oTxt.Value, ""))
1913:             ENDIF
1914:         ENDIF

*-- Linhas 1928 a 1986:
1928:     *   This.Value = CrListaRemota.Cods
1929:     *   Replace Descs With CrListaRemota.Descs in LocalStats
1930:     *   This.Refresh
1931:     *   Select LocalStats
1932:     *
1933:     * Grava SO no cursor LOCAL - igual ao legado, que persiste em SIGOPSTS
1934:     * apenas no Encerrar (BtnSairClick -> SigOpStsBO.GravarStatus).
1935:     *
1936:     * LEFT() pela largura da COLUNA no schema (status char(1), descs
1937:     * char(20)), nunca pelo Width em pixels do controle (regra #19): assim o
1938:     * que o cursor recebe eh exatamente o que cabe na coluna do SQL Server no
1939:     * INSERT do Encerrar.
1940:     *
1941:     * par_oTxt eh OPCIONAL: durante o lookup a celula precisa exibir o codigo
1942:     * escolhido (o "This.Value =" do legado); chamado sem ela, so o cursor e a
1943:     * grade sao atualizados.
1944:     *
1945:     * Repinta ao fim (regra #21): gravar no cursor NAO repinta a grade, e sem
1946:     * o Refresh a Column2 continuaria mostrando a descricao anterior.
1947:     *
1948:     * Deixa cursor_4c_Status como alias corrente, igual ao "Select LocalStats"
1949:     * com que o Valid legado termina.
1950:     *
1951:     * PROTECTED EXPLICITO pela MESMA razao do FormParaBO acima (FormBase
1952:     * declara PROTECTED PROCEDURE BOParaForm em formbase.prg:280): a subclasse
1953:     * nao alarga o escopo herdado, entao o metodo eh chamado por THIS. de
1954:     * dentro da classe - aqui, por AbrirLookupStatusStsExec.
1955:     *
1956:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1957:     *==========================================================================
1958:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
1959:         LOCAL loc_lSucesso, loc_cStatus, loc_cDescs
1960: 
1961:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1962:             RETURN .F.
1963:         ENDIF
1964: 
1965:         loc_lSucesso = .F.
1966:         loc_cStatus  = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cStatus, "")), 1)
1967:         loc_cDescs   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescs, "")), 20)
1968: 
1969:         IF USED("cursor_4c_Status")
1970:             *-- Legado: Select LocalStats (fica corrente no fim, como no dump)
1971:             SELECT cursor_4c_Status
1972: 
1973:             IF !EOF()
1974:                 *-- Legado: Replace Descs With CrListaRemota.Descs in LocalStats
1975:                 *-- (o status tambem entra aqui: no legado quem o grava eh o
1976:                 *-- bind da Column1 quando o Valid devolve .T., e gravar os
1977:                 *-- dois juntos impede que a linha fique com codigo de um
1978:                 *-- status e descricao de outro)
1979:                 REPLACE status WITH loc_cStatus, ;
1980:                         descs  WITH loc_cDescs
1981:                 loc_lSucesso = .T.
1982:             ENDIF
1983:         ENDIF
1984: 
1985:         *-- Legado: This.Value = CrListaRemota.Cods / This.Refresh
1986:         IF VARTYPE(par_oTxt) = "O"


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

