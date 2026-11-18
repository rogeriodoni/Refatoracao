# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, CUPFIS, SEQS, CDOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LOCAL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, CUPFIS, SEQS, CDOPES

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
lcSql = [Select Dopes From SigCdOpe Where CupFis in (1,3)]
SigCdOpe.PodataMgr.Sqlexecute(lcsql,'TmpOper')
Select TmpOper
		SELECT crSigMvCxs
Select crSigMvCxs
	.Column1.ControlSource = 'crSigMvCxs.cNivels'
	.Column2.ControlSource = 'crSigMvCxs.Seqs'
		If Not Seek(This.Value, 'TmpOper', 'Dopes')
Select crSigMvCxs
	Delete
		Select CrSigMvCxs
		Select cNivels,sum(1) From CrSigMvCxs Into Cursor Selecao Group by cNivels having sum(1) > 1
		Select Selecao
		Select [ ] as Agrupar,Sum(1) From CrSigMvCxs Into Cursor Selecao where Not Empty(cNivels) And Seqs = 0 group by 1
		Select Selecao
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigMvCxs'),1,-1)
Select crSigMvCxs
	Insert Into crSigMvCxs (cDopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select crSigMvCxs

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg) - TRECHOS RELEVANTES PARA PASS SQL (1930 linhas total):

*-- Linhas 9 a 44:
9: *           Caption "Operacoes do Caixa : <operacao>")
10: *   BD   -> SigMvCxs/SigCdOpe (via SigOpSqnBO); a gravacao real so acontece
11: *           no clique de Encerrar (BtnSairClick), igual ao legado
12: *           (SigCdOpe.poDataMgr.UpDate('crSigMvCxs') + Commit() so no
13: *           cmdSair.Click)
14: *   CODE -> arquitetura em camadas (FormBase / SigOpSqnBO)
15: *
16: * O QUE ESTA TELA EH
17: *   Dialogo FILHO que o form pai SigCdOpe (Cadastro de Operacoes do Caixa)
18: *   abre para o usuario montar a SEQUENCIA de execucao das operacoes de uma
19: *   operacao-pai (crSigCdOpe.Dopes no legado). O legado recebe "poForm" (o
20: *   form pai) e "pnDataSes" (DataSession do pai) no Init, troca para a
21: *   DataSession do pai (Set DataSession To pnDataSes) e manipula um cursor
22: *   remoto bufferizado (crSigMvCxs) com 2 colunas editaveis:
23: *     Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes,
24: *                filtrado por CupFis IN (1,3) - so operacoes de "Cupom
25: *                Fiscal")
26: *     Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
27: *   Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
28: *   corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava
29: *   via poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o
30: *   dialogo).
31: *
32: *   No migrado, o form roda com DataSession = 1 (sessao CORRENTE,
33: *   compartilhada com o pai), reproduzindo o mesmo efeito do "Set
34: *   DataSession To pnDataSes" sem a troca manual de sessao - mesmo padrao
35: *   ja adotado em FormSigOpSlc.prg/FormSigOpSpr.prg.
36: *
37: * CHAMADA (equivale ao "Do Form SigOpSqn With ThisForm, ThisForm.
38: * DataSessionId" do legado, onde o proprio form pai eh "poForm"):
39: *   loForm = CREATEOBJECT("FormSigOpSqn", THISFORM, loc_cOperacaoAtual, ;
40: *       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
41: *   IF VARTYPE(loForm) = "O"
42: *       loForm.Show()          && modal: so volta quando o dialogo fecha
43: *   ENDIF
44: *

*-- Linhas 135 a 204:
135: * FASE 7 (esta fase): os eventos dos botoes -
136: *   - ConfigurarBINDEVENTs: liga o Click de cmd_4c_Inserir/cmd_4c_Excluir/
137: *     cmd_4c_Sair (AddObject cria botao SEM codigo de evento).
138: *   - CmdInserirClick (cmdInserir.Click: Locate da linha em branco + Insert
139: *     Into no cursor local com cidchaves = fUniqueIds() + foco na Column1).
140: *   - CmdExcluirClick (cmdExcluir.Click: Delete + Skip/Skip -1 + Refresh -
141: *     marca so no cursor local).
142: *   - BtnSairClick (cmdSair.Click: as DUAS validacoes do legado -
143: *     ExisteOperacaoDuplicada/ExisteSequenciaNaoInformada, que abortam o
144: *     fechamento - e a gravacao via PersistirSequencias, que substitui o
145: *     poDataMgr.UpDate("crSigMvCxs") + Commit() do legado pela gravacao
146: *     linha-a-linha no BO; depois Release(), cujo Destroy reabilita o pai).
147: *   - this_cCidChavesNovas: lista das linhas criadas na sessao, que faz o
148: *     papel do buffer da view remota (quem eh INSERT e quem eh UPDATE).
149: *
150: * FASE 8 (esta fase): eventos auxiliares e CONSOLIDACAO FINAL -
151: *   - FormParaBO (transporte LINHA DA GRADE -> BO) e BOParaForm (o inverso:
152: *     devolve a chave efetivamente gravada para a linha). Os dois nasceram
153: *     de codigo que JA existia INLINE em PersistirSequencias - a atribuicao
154: *     das 4 properties estava repetida nos dois lacos (exclusoes e
155: *     inclusoes/atualizacoes). Nao sao hooks decorativos: PersistirSequencias
156: *     passou a chamar os dois, e sem eles nada eh gravado.
157: *   - SigOpSqnBO.LimparDados (override): BusinessBase.LimparDados so limpa a
158: *     mensagem de erro e deixa para a subclasse zerar o que eh dela.
159: *     NovoRegistro() chama LimparDados ANTES do FormParaBO, entao sem o
160: *     override as 4 properties entravam na linha nova com o valor da linha
161: *     ANTERIOR do laco - e qualquer caminho que deixasse de atribuir uma
162: *     delas gravaria o dado da linha errada, sem erro nenhum.
163: *
164: *   AUDITORIA DE CONSOLIDACAO (o que foi MEDIDO, nao suposto)
165: *   - Legado x migrado, metodo a metodo (SECAO 3 do dump): Init, Load,
166: *     mctrlbotoes, Column1.Text1 When/Valid/LostFocus, Column2.Text1
167: *     When/Valid, cmdInserir.Click, cmdExcluir.Click, cmdSair.Click. Os dois
168: *     que NAO foram transcritos como codigo estao justificados abaixo.
169: *   - SigMvCxs tem EXATAMENTE 4 colunas, todas NOT NULL (cdopes/cidchaves/
170: *     cnivels/seqs, docs\schema.sql lido com Get-Content -Raw - regra #14) e
171: *     o INSERT de SigOpSqnBO cobre as 4 (regra #22).
172: *   - Todo THIS.<membro> do arquivo resolve no proprio form, no FormBase ou
173: *     em controle criado por AddObject; todo this_oBusinessObject.<membro>
174: *     resolve no SigOpSqnBO ou no BusinessBase (regra #34/#51). Os metodos do
175: *     BO chamados daqui sao os PUBLIC (Salvar/Excluir/NovoRegistro/
176: *     EditarRegistro/Listar*) - Inserir/Atualizar/ExecutarExclusao sao
177: *     PROTECTED e NUNCA se chamam de fora (regra #51).
178: *   - Medido no VFP9 em 2026-11-17 (automation\_probe_scan_sqn*.prg), para
179: *     descartar duas suspeitas que PARECIAM defeito e nao eram:
180: *       (a) INSERT INTO <cursor local> omitindo colunas preenche os campos
181: *           que faltam com BRANCO/ZERO, NUNCA com .NULL. - vale inclusive em
182: *           campo declarado NULL e em cursor vindo de SELECT ... INTO CURSOR
183: *           READWRITE. Logo o guard "EMPTY(cnivels)" do LOCATE em
184: *           CmdInserirClick funciona, e o INSERT de 2 colunas transcrito do
185: *           legado esta correto como esta (com .NULL. o guard falharia e cada
186: *           clique criaria outra linha em branco).
187: *       (b) SCAN/ENDSCAN NAO se perde quando o corpo troca a work area
188: *           corrente (3 voltas e ordem certa, inclusive deixando outro alias
189: *           selecionado) - os SQLEXEC que o BO faz dentro dos lacos de
190: *           PersistirSequencias nao quebram o percurso.
191: *
192: *   LEGADO DELIBERADAMENTE NAO TRANSCRITO COMO CODIGO (nao eh omissao)
193: *   - "PROCEDURE Load: =fConfigGeral()". fConfigGeral era funcao GLOBAL da
194: *     aplicacao legado (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo; o que
195: *     existe eh o wrapper utils\fconfiggeral.prg, um RETURN .T. criado
196: *     APENAS para o p-code dos VCX legado alcancar o nome. O proprio
197: *     cabecalho dele proibe o uso em codigo nosso ("em codigo NOSSO nunca se
198: *     chama fConfigGeral"), porque o que a funcao fazia no legado hoje esta
199: *     distribuido e JA aconteceu antes desta tela abrir: config.prg (SETs,
200: *     paths, variaveis globais), main.prg (conexao/empresa) e cada BO com os
201: *     proprios cursores. Chamar o wrapper aqui seria uma linha sem efeito.
202: *   - "PROCEDURE mctrlbotoes(plHabilita)", que no legado percorre
203: *     ParentForm.Pagina.Lista.Grupo_Op.Buttons + cmdFPOper + cmdMultiSubN +
204: *     Grupo_Saida.Sair ligando/desligando cada um. Esta tela desabilita o

*-- Linhas 266 a 285:
266:     this_nValorAnteriorSeq   = 0
267: 
268:     *-- cidchaves das linhas CRIADAS nesta sessao pelo botao Inserir, para o
269:     *-- funil de gravacao (PersistirSequencias) distinguir INSERT de UPDATE.
270:     *-- No legado essa distincao eh do buffer da view remota (TableUpdate sabe
271:     *-- quais linhas sao novas); sem buffer, a lista explicita faz o mesmo
272:     *-- papel. Formato "|<id>|<id>|..."
273:     this_cCidChavesNovas = ""
274: 
275:     *--------------------------------------------------------------------------
276:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
277:     *--------------------------------------------------------------------------
278: 
279:     *-- SIGOPSQN: BorderStyle = 2 / Top = 0 / Left = 0 / Height = 365 /
280:     *-- Width = 618 / DoCreate = .T. (default do Form, nao precisa declarar)
281:     BorderStyle = 2
282:     Top         = 0
283:     Left        = 0
284:     Height      = 365
285:     Width       = 618

*-- Linhas 708 a 773:
708:     *
709:     * Transcricao do dump (SIGOPSQN_form_codigo_fonte.txt):
710:     *   GradeSubN  Top=110 Left=147 Width=206 Height=221 ColumnCount=2
711:     *              FontName="Tahoma" FontSize=8 DeleteMark=.F. RowHeight=16
712:     *              ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
713:     *   Column1    FontName="Tahoma" FontSize=8 Width=150 Movable=.F.
714:     *              Resizable=.F.  (ControlSource="" - override VAZIO do Form
715:     *              Designer, o bind real eh feito no Init: 'crSigMvCxs.
716:     *              cNivels' -> ver VincularGrade)
717:     *   Column1.Header1  Alignment=2 Caption="Operacao"
718:     *   Column1.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
719:     *                    BackColor=255,255,255
720:     *   Column2    FontName="Tahoma" FontSize=8 Width=25 Movable=.F.
721:     *              InputMask="9"
722:     *   Column2.Header1  Alignment=2 Caption="Seq"
723:     *   Column2.Text1    BorderStyle=0 InputMask="9" Margin=0 MaxLength=1
724:     *                    ForeColor=0,0,0 BackColor=255,255,255
725:     *
726:     * Column2 NAO declara Resizable no dump (so Movable) - mantido o default
727:     * do VFP, sem inventar a propriedade que o legado nao tem.
728:     *
729:     * RecordMark = .F. (o dump so declara DeleteMark): canonico do projeto
730:     * para grade criada por AddObject em form OPERACIONAL - a barra lateral
731:     * de marcacao de registro nao faz parte do padrao visual do sistema novo
732:     * e a linha corrente continua identificada pelo realce do proprio Grid.
733:     *
734:     * As DUAS colunas sao editaveis (Column1 recebe o codigo da operacao,
735:     * Column2 a sequencia 1-8), logo ReadOnly = .F. explicito nas colunas -
736:     * sempre DEPOIS do Grid, porque o ReadOnly do Grid propaga para elas e
737:     * sobrescreveria o valor daqui (regra #46). O cursor que as alimenta eh
738:     * READWRITE (SigOpSqnBO.ListarSequencias) - cursor de SQLEXEC nasce
739:     * somente-leitura e a celula nunca entraria em edicao.
740:     *
741:     * Fase 6: as DUAS colunas instalam TextBox subclasse (Column.AddObject
742:     * + CurrentControl + Sparse = .F. - regra #18) no lugar do Text1 cru,
743:     * porque BINDEVENT em evento de celula de Grid nao eh confiavel (regra
744:     * #46) - os eventos When/Valid/LostFocus moram na classe
745:     * (TextBoxNivelSqn_4c/TextBoxSeqSqn_4c, em classes\
746:     * textboxgridlookup.PRG) e delegam para os metodos PUBLIC do form.
747:     *==========================================================================
748:     PROTECTED PROCEDURE ConfigurarGrade
749:         THIS.AddObject("grd_4c_Dados", "Grid")
750: 
751:         WITH THIS.grd_4c_Dados
752:             .Top           = 110
753:             .Left          = 147
754:             .Width         = 206
755:             .Height        = 221
756:             .FontName      = "Tahoma"
757:             .FontSize      = 8
758:             .DeleteMark    = .F.
759:             .RecordMark    = .F.
760:             .RowHeight     = 16
761:             .ScrollBars    = 2
762:             .TabIndex      = 1
763:             .GridLineColor = RGB(238, 238, 238)
764:             .ColumnCount   = 2
765:             .Visible       = .T.
766:         ENDWITH
767: 
768:         *-- Column1 - cnivels (operacao que compoe a sequencia). Celula com
769:         *-- lookup (When/Valid/LostFocus) - regra #18/#46
770:         THIS.grd_4c_Dados.Column1.AddObject("txt_4c_Nivel", "TextBoxNivelSqn_4c")
771:         WITH THIS.grd_4c_Dados.Column1
772:             .FontName       = "Tahoma"
773:             .FontSize       = 8

*-- Linhas 1051 a 1103:
1051:     *
1052:     *   With Thisform.GradeSubN
1053:     *       .RecordSource          = 'crSigMvCxs'
1054:     *       .Column1.ControlSource = 'crSigMvCxs.cNivels'
1055:     *       .Column2.ControlSource = 'crSigMvCxs.Seqs'
1056:     *       .Refresh
1057:     *   EndWith
1058:     *
1059:     * O alias eh o literal cursor_4c_Sequencias (valor de SigOpSqnBO.
1060:     * this_cCursorSequencias) - INTO CURSOR do BO e RecordSource daqui
1061:     * precisam casar, e um nome fixo nos dois lados nao tem como divergir.
1062:     *
1063:     * Width / Header1.Caption / Header1.Alignment / ReadOnly / CurrentControl
1064:     * / Sparse sao REAPLICADOS depois do bind: atribuir RecordSource/
1065:     * ControlSource reseta a largura das colunas para o default 90 e o
1066:     * cabecalho para "Column1"/"Column2" (Problema 48 / regra #41). Por isso
1067:     * este bloco repete os valores de ConfigurarGrade em vez de so
1068:     * configura-los la.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE VincularGrade
1071:         IF !USED("cursor_4c_Sequencias")
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
1083:         THIS.grd_4c_Dados.ColumnCount = 3
1084:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Sequencias"
1085: 
1086:         WITH THIS.grd_4c_Dados
1087:             .Column1.ControlSource = "cursor_4c_Sequencias.cnivels"
1088:             .Column2.ControlSource = "cursor_4c_Sequencias.seqs"
1089: 
1090:             *-- Reaplicar o que o rebind acabou de resetar
1091:             .Column1.Width = 150
1092:             .Column2.Width = 25
1093: 
1094:             .Column1.Header1.Alignment = 2
1095:             .Column2.Header1.Alignment = 2
1096:             .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1097:             .Column2.Header1.Caption   = "Seq"
1098: 
1099:             .Column1.CurrentControl = "txt_4c_Nivel"
1100:             .Column2.CurrentControl = "txt_4c_Seq"
1101:             .Column1.Sparse         = .F.
1102:             .Column2.Sparse         = .F.
1103: 

*-- Linhas 1115 a 1134:
1115:     * a grade:
1116:     *
1117:     *   WITH SigCdOpe / With .poDatamgr / .ReQuery('crSigMvCxs')
1118:     *       SELECT crSigMvCxs / GO top
1119:     *   Select crSigMvCxs / Goto Top
1120:     *   With Thisform.GradeSubN ... .Refresh
1121:     *
1122:     * No migrado, quem produz o cursor eh SigOpSqnBO.ListarSequencias (mesma
1123:     * consulta que o form pai registra em AddCursor para crSigMvCxs, filtrada
1124:     * pela operacao-pai), e o Go Top + Refresh vem DEPOIS do bind - popular o
1125:     * cursor NAO repinta a grade sozinho (regra #21).
1126:     *
1127:     * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
1128:     * e os Click dos botoes (CmdInserirClick/BtnSairClick) alcancam de fora -
1129:     * PROTECTED faria a chamada externa estourar em runtime (regra #3/#51).
1130:     *
1131:     * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
1132:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1133:     * reportada por ListarSequencias.
1134:     *==========================================================================

*-- Linhas 1152 a 1172:
1152:                 IF THIS.this_oBusinessObject.ListarSequencias(THIS.this_cOperacaoPai)
1153:                     THIS.VincularGrade()
1154: 
1155:                     *-- Legado: Select crSigMvCxs / Goto Top
1156:                     IF USED("cursor_4c_Sequencias")
1157:                         SELECT cursor_4c_Sequencias
1158:                         GO TOP
1159:                     ENDIF
1160: 
1161:                     *-- Legado: Thisform.GradeSubN.Refresh
1162:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1163:                         THIS.grd_4c_Dados.Refresh()
1164:                     ENDIF
1165: 
1166:                     loc_lSucesso = .T.
1167:                 ENDIF
1168:             ENDIF
1169:         CATCH TO loc_oErro
1170:             MsgErro("Erro ao carregar as sequ" + CHR(234) + "ncias da opera" + ;
1171:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1172:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1369 a 1566:
1369:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1370:     *
1371:     *   Thisform.lHouveIns = .T.
1372:     *   Select crSigMvCxs
1373:     *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
1374:     *   If Eof()
1375:     *       Insert Into crSigMvCxs (cDopes, CidChaves) ;
1376:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1377:     *   EndIf
1378:     *   Select crSigMvCxs
1379:     *   Thisform.GradeSubN.Column1.SetFocus
1380:     *
1381:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1382:     * da ultima vez ainda nao foi preenchida, o legado reaproveita ela em vez
1383:     * de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o foco
1384:     * vai parar).
1385:     *
1386:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre a view
1387:     * bufferizada do pai e so persiste no Encerrar (poDataMgr.UpDate +
1388:     * Commit -> PersistirSequencias). A PK vai ja preenchida com fUniqueIds()
1389:     * (regra #22: cidchaves NUNCA em branco, senao a 2a linha colide no
1390:     * indice unico) e entra em this_cCidChavesNovas, que eh como o funil de
1391:     * gravacao sabe que a linha eh INSERT e nao UPDATE.
1392:     *
1393:     * O "Select crSigMvCxs" final do legado nao precisa ser reproduzido como
1394:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1395:     * DataSession do PAI (DataSession = 1), onde deixar outro alias
1396:     * selecionado atrapalharia quem chamou - por isso o alias anterior eh
1397:     * restaurado.
1398:     *
1399:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1400:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) =
1401:     * .T.). NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1402:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1403:     * read-only") e derrubaria o handler.
1404:     *==========================================================================
1405:     PROCEDURE CmdInserirClick
1406:         LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro
1407: 
1408:         TRY
1409:             IF USED("cursor_4c_Sequencias")
1410:                 *-- Legado: Thisform.lHouveIns = .T.
1411:                 THIS.this_lHouveInclusao = .T.
1412: 
1413:                 loc_cAliasAnterior = ALIAS()
1414:                 SELECT cursor_4c_Sequencias
1415: 
1416:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
1417:                     AND EMPTY(cnivels)
1418: 
1419:                 IF !FOUND()
1420:                     loc_cCidChaves = ALLTRIM(fUniqueIds())
1421: 
1422:                     INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves) ;
1423:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1424: 
1425:                     THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + ;
1426:                         "|" + loc_cCidChaves
1427:                 ENDIF
1428: 
1429:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1430:                     SELECT (loc_cAliasAnterior)
1431:                 ENDIF
1432: 
1433:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1434:                     THIS.grd_4c_Dados.Refresh()
1435:                     THIS.grd_4c_Dados.Column1.SetFocus()
1436:                 ENDIF
1437:             ENDIF
1438:         CATCH TO loc_oErro
1439:             MsgErro(loc_oErro.Message + CHR(13) + ;
1440:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1441:                     "Procedure: " + loc_oErro.Procedure, ;
1442:                     "Erro em CmdInserirClick")
1443:         ENDTRY
1444:     ENDPROC
1445: 
1446:     *==========================================================================
1447:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1448:     *
1449:     *   Select crSigMvCxs
1450:     *   If Not Eof() And ( crSigMvCxs.cDopes = crSigCdOpe.Dopes )
1451:     *       Thisform.lHouveExcl = .T.
1452:     *       Delete
1453:     *       Skip
1454:     *       Skip - 1
1455:     *   Endif
1456:     *   Thisform.GradeSubN.Refresh
1457:     *
1458:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1459:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1460:     * config.prg - a linha marcada desaparece da grade de imediato).
1461:     *
1462:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1463:     * Encerrar (PersistirSequencias) e SO para linha que ja existia no banco
1464:     * - linha nova excluida antes de gravar simplesmente desaparece, sem SQL
1465:     * nenhum.
1466:     *==========================================================================
1467:     PROCEDURE CmdExcluirClick
1468:         LOCAL loc_cAliasAnterior, loc_oErro
1469: 
1470:         TRY
1471:             IF USED("cursor_4c_Sequencias")
1472:                 loc_cAliasAnterior = ALIAS()
1473:                 SELECT cursor_4c_Sequencias
1474: 
1475:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
1476:                     *-- Legado: Thisform.lHouveExcl = .T.
1477:                     THIS.this_lHouveExclusao = .T.
1478:                     DELETE
1479:                     SKIP
1480:                     SKIP -1
1481:                 ENDIF
1482: 
1483:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1484:                     SELECT (loc_cAliasAnterior)
1485:                 ENDIF
1486:             ENDIF
1487: 
1488:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1489:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1490:                 THIS.grd_4c_Dados.Refresh()
1491:             ENDIF
1492:         CATCH TO loc_oErro
1493:             MsgErro(loc_oErro.Message + CHR(13) + ;
1494:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1495:                     "Procedure: " + loc_oErro.Procedure, ;
1496:                     "Erro em CmdExcluirClick")
1497:         ENDTRY
1498:     ENDPROC
1499: 
1500:     *==========================================================================
1501:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1502:     * tambem dispara no ESC). Transcrito:
1503:     *
1504:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1505:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt )
1506:     *           Select CrSigMvCxs / Go Top / Go bottom
1507:     *           <validacao 1: cNivels duplicada>  -> MessageBox + Return .f.
1508:     *           <validacao 2: cNivels sem Seqs>   -> MessageBox + Return .f.
1509:     *           <UpDate('crSigMvCxs') + Commit(), com RollBack e MessageBox
1510:     *            'Erro na Gravacao dos Dados do Cadastro de Operacoes.'>
1511:     *       Endif
1512:     *   ENDIF
1513:     *   Thisform.ParentForm.Enabled = .T.
1514:     *   Thisform.mCtrlBotoes(.T.)
1515:     *   ThisForm.Release
1516:     *
1517:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO as duas validacoes
1518:     * abortam o fechamento (o "Return .f." do legado); a FALHA DE GRAVACAO
1519:     * exibe a mensagem e FECHA do mesmo jeito, porque no legado o RollBack ja
1520:     * desfez tudo. Manter o dialogo aberto nesse caso convidaria a um segundo
1521:     * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK) -
1522:     * ver tambem o acerto de this_cCidChavesNovas em PersistirSequencias.
1523:     *
1524:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR
1525:     * ou usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1526:     *
1527:     * "Go Top / Go bottom" do legado forcava a view remota bufferizada a
1528:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1529:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1530:     *
1531:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1532:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos
1533:     * do pai porque la o pai ficava com os controles desabilitados um a um -
1534:     * aqui o InicializarForm desabilita o FORM PAI INTEIRO, entao reabilitar
1535:     * o form basta e nao ha metodo equivalente a chamar.
1536:     *
1537:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1538:     *==========================================================================
1539:     PROCEDURE BtnSairClick
1540:         LOCAL loc_lPodeFechar, loc_oErro
1541: 
1542:         loc_lPodeFechar = .T.
1543: 
1544:         TRY
1545:             IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
1546:                 IF THIS.this_lHouveExclusao OR THIS.this_lHouveInclusao OR ;
1547:                    THIS.this_lHouveAlteracao
1548: 
1549:                     *-- Legado: Select CrSigMvCxs / Go Top / Go bottom
1550:                     IF USED("cursor_4c_Sequencias")
1551:                         SELECT cursor_4c_Sequencias
1552:                         GO TOP
1553:                         GO BOTTOM
1554:                     ENDIF
1555: 
1556:                     DO CASE
1557:                     CASE THIS.ExisteOperacaoDuplicada()
1558:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1559:                             "es Duplicadas!!!", ;
1560:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1561:                         loc_lPodeFechar = .F.
1562: 
1563:                     CASE THIS.ExisteSequenciaNaoInformada()
1564:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1565:                             "es sem Sequ" + CHR(234) + "ncia informada!!!", ;
1566:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")

*-- Linhas 1592 a 1777:
1592:     *==========================================================================
1593:     * ExisteOperacaoDuplicada - 1a validacao do cmdSair.Click legado:
1594:     *
1595:     *   Select cNivels,sum(1) From CrSigMvCxs Into Cursor Selecao ;
1596:     *       Group by cNivels having sum(1) > 1
1597:     *   Select Selecao
1598:     *   If Reccount() > 0 ... 'Existem Operacoes Duplicadas!!!'
1599:     *
1600:     * Transcricao LITERAL (regra #17): o legado NAO exclui a linha em branco
1601:     * do agrupamento, logo DUAS linhas novas sem operacao informada tambem
1602:     * contam como duplicadas - esse eh o comportamento da tela e nao se
1603:     * "conserta" aqui.
1604:     *
1605:     * A linha marcada para exclusao NAO entra: SET DELETED ON (config.prg)
1606:     * esconde do SELECT, igual ao legado.
1607:     *
1608:     * _TALLY no lugar do RECCOUNT() do legado: RECCOUNT conta tambem registro
1609:     * marcado como excluido, e _TALLY eh o numero de linhas que o SELECT
1610:     * acabou de produzir.
1611:     *
1612:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1613:     *==========================================================================
1614:     PROTECTED FUNCTION ExisteOperacaoDuplicada
1615:         LOCAL loc_cAliasAnterior, loc_nQuantas
1616: 
1617:         IF !USED("cursor_4c_Sequencias")
1618:             RETURN .F.
1619:         ENDIF
1620: 
1621:         loc_cAliasAnterior = ALIAS()
1622: 
1623:         IF USED("cursor_4c_SelecaoSqn")
1624:             USE IN cursor_4c_SelecaoSqn
1625:         ENDIF
1626: 
1627:         SELECT cnivels, SUM(1) AS nquantas ;
1628:             FROM cursor_4c_Sequencias ;
1629:             GROUP BY cnivels ;
1630:             HAVING SUM(1) > 1 ;
1631:             INTO CURSOR cursor_4c_SelecaoSqn READWRITE
1632: 
1633:         loc_nQuantas = _TALLY
1634: 
1635:         IF USED("cursor_4c_SelecaoSqn")
1636:             USE IN cursor_4c_SelecaoSqn
1637:         ENDIF
1638: 
1639:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1640:             SELECT (loc_cAliasAnterior)
1641:         ENDIF
1642: 
1643:         RETURN (loc_nQuantas > 0)
1644:     ENDFUNC
1645: 
1646:     *==========================================================================
1647:     * ExisteSequenciaNaoInformada - 2a validacao do cmdSair.Click legado:
1648:     *
1649:     *   Select [ ] as Agrupar,Sum(1) From CrSigMvCxs Into Cursor Selecao ;
1650:     *       where Not Empty(cNivels) And Seqs = 0 group by 1
1651:     *   Select Selecao
1652:     *   If Reccount() > 0 ... 'Existem Operacoes sem Sequencia informada!!!'
1653:     *
1654:     * O criterio que CERCA a validacao eh parte dela (regra #21b): o legado
1655:     * so reclama de linha COM operacao informada e sequencia zerada - linha
1656:     * totalmente em branco nao entra aqui (ela cai na validacao de
1657:     * duplicidade quando houver mais de uma).
1658:     *
1659:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1660:     *==========================================================================
1661:     PROTECTED FUNCTION ExisteSequenciaNaoInformada
1662:         LOCAL loc_cAliasAnterior, loc_nQuantas
1663: 
1664:         IF !USED("cursor_4c_Sequencias")
1665:             RETURN .F.
1666:         ENDIF
1667: 
1668:         loc_cAliasAnterior = ALIAS()
1669: 
1670:         IF USED("cursor_4c_SelecaoSqn")
1671:             USE IN cursor_4c_SelecaoSqn
1672:         ENDIF
1673: 
1674:         SELECT " " AS agrupar, SUM(1) AS nquantas ;
1675:             FROM cursor_4c_Sequencias ;
1676:             WHERE !EMPTY(cnivels) AND seqs = 0 ;
1677:             GROUP BY 1 ;
1678:             INTO CURSOR cursor_4c_SelecaoSqn READWRITE
1679: 
1680:         loc_nQuantas = _TALLY
1681: 
1682:         IF USED("cursor_4c_SelecaoSqn")
1683:             USE IN cursor_4c_SelecaoSqn
1684:         ENDIF
1685: 
1686:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1687:             SELECT (loc_cAliasAnterior)
1688:         ENDIF
1689: 
1690:         RETURN (loc_nQuantas > 0)
1691:     ENDFUNC
1692: 
1693:     *==========================================================================
1694:     * PersistirSequencias - grava no SQL Server o que a sessao mudou em
1695:     * cursor_4c_Sequencias (SigMvCxs). Equivale ao bloco de gravacao do
1696:     * cmdSair.Click legado:
1697:     *
1698:     *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
1699:     *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSigMvCxs'),1,-1)
1700:     *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
1701:     *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
1702:     *
1703:     * Sem a view bufferizada do Framework nao ha TableUpdate em bloco: a
1704:     * persistencia eh linha-a-linha via o BO (Salvar/Excluir, que sao os
1705:     * metodos PUBLIC - Inserir/Atualizar/ExecutarExclusao sao PROTECTED e
1706:     * NUNCA se chamam de fora, regra #51). Exclusoes primeiro, depois
1707:     * inclusoes/atualizacoes - a mesma ordem do TableUpdate.
1708:     *
1709:     * Linha marcada para exclusao que NUNCA foi gravada (esta em
1710:     * this_cCidChavesNovas) nao vira DELETE: no banco ela nao existe.
1711:     * Para alcancar as linhas marcadas eh preciso suspender o SET DELETED ON
1712:     * do config.prg - com ele ligado, o SCAN pula a linha excluida ANTES de
1713:     * avaliar o FOR.
1714:     *
1715:     * Transcricao fiel (regra #17): o Encerrar legado NAO descarta linha com
1716:     * cnivels em branco antes de gravar (quem faz isso, para OUTRA tabela, eh
1717:     * o dialogo irmao SIGOPSNO) - uma unica linha em branco passa as duas
1718:     * validacoes e eh gravada, igual ao TableUpdate do legado.
1719:     *
1720:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1721:     *==========================================================================
1722:     PROTECTED FUNCTION PersistirSequencias
1723:         LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_lNovo, ;
1724:               loc_cDeletedStatus
1725: 
1726:         loc_lSucesso = .T.
1727: 
1728:         IF !USED("cursor_4c_Sequencias")
1729:             RETURN .T.
1730:         ENDIF
1731: 
1732:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1733:             RETURN .F.
1734:         ENDIF
1735: 
1736:         loc_cAliasAnterior = ALIAS()
1737:         SELECT cursor_4c_Sequencias
1738: 
1739:         *-- Exclusoes das linhas que JA existiam no banco
1740:         loc_cDeletedStatus = SET("DELETED")
1741:         SET DELETED OFF
1742:         SCAN FOR DELETED()
1743:             loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1744: 
1745:             IF !EMPTY(loc_cCidChaves) AND ;
1746:                !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
1747:                 *-- Excluir() recusa registro marcado como novo; a linha
1748:                 *-- existe no banco, logo this_lNovoRegistro = .F.
1749:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1750: 
1751:                 *-- Fase 8: a linha corrente vai para o BO num lugar SO
1752:                 THIS.FormParaBO()
1753: 
1754:                 IF !THIS.this_oBusinessObject.Excluir()
1755:                     loc_lSucesso = .F.
1756:                 ENDIF
1757:             ENDIF
1758:         ENDSCAN
1759:         SET DELETED &loc_cDeletedStatus
1760: 
1761:         *-- Inclusoes / atualizacoes das linhas vivas
1762:         SCAN FOR !DELETED()
1763:             loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1764:             loc_lNovo      = ("|" + loc_cCidChaves + "|" $ ;
1765:                               ("|" + THIS.this_cCidChavesNovas + "|"))
1766: 
1767:             *-- Modo ANTES das properties: NovoRegistro() passa por
1768:             *-- LimparDados(), e EditarRegistro() recusa enquanto
1769:             *-- this_lNovoRegistro estiver ligado de uma linha anterior
1770:             IF loc_lNovo
1771:                 THIS.this_oBusinessObject.NovoRegistro()
1772:             ELSE
1773:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1774:                 THIS.this_oBusinessObject.EditarRegistro()
1775:             ENDIF
1776: 
1777:             *-- Fase 8: a linha corrente vai para o BO num lugar SO

*-- Linhas 1783 a 1813:
1783:                 THIS.BOParaForm()
1784: 
1785:                 *-- A linha passou a existir no banco: sai da lista de novas,
1786:                 *-- para um segundo Encerrar nao tentar INSERT de novo
1787:                 *-- (cidchaves eh PK)
1788:                 IF loc_lNovo
1789:                     THIS.this_cCidChavesNovas = STRTRAN(THIS.this_cCidChavesNovas, ;
1790:                         "|" + loc_cCidChaves, "")
1791:                 ENDIF
1792:             ELSE
1793:                 loc_lSucesso = .F.
1794:             ENDIF
1795:         ENDSCAN
1796: 
1797:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1798:             SELECT (loc_cAliasAnterior)
1799:         ENDIF
1800: 
1801:         RETURN loc_lSucesso
1802:     ENDFUNC
1803: 
1804:     *==========================================================================
1805:     * FormParaBO - transporte LINHA DA GRADE -> BO (Fase 8)
1806:     *
1807:     * A "ficha" desta tela eh a LINHA da grade: as duas celulas editaveis
1808:     * (cnivels/seqs) mais as duas colunas que o usuario nao ve (cdopes, que
1809:     * eh a operacao-pai, e cidchaves, a PK). Este metodo copia a linha
1810:     * CORRENTE de cursor_4c_Sequencias para as properties do BO - eh o
1811:     * equivalente, aqui, do FormParaBO de um form CRUD, que leva os
1812:     * TextBoxes da pagina Dados para o BO.
1813:     *

*-- Linhas 1853 a 1871:
1853:     * gravada. SigOpSqnBO.Inserir() gera a PK quando ela chega vazia
1854:     * ("IF EMPTY(this_cCidChaves) / this_cCidChaves = fUniqueIds()", regra
1855:     * #22), e nesse caso a linha do cursor continuaria com a chave antiga: um
1856:     * segundo Encerrar mandaria UPDATE/DELETE para um cidchaves que nao
1857:     * existe no banco, em silencio. Sincronizar aqui fecha esse buraco.
1858:     *
1859:     * As outras tres colunas NAO sao reescritas de proposito: elas acabaram
1860:     * de sair da propria linha (FormParaBO) e o BO nao as transforma -
1861:     * reescrever criaria um segundo dono para o que o usuario digitou.
1862:     *
1863:     * Repinta a grade no fim: alterar o cursor NAO repinta sozinho (regra
1864:     * #21a).
1865:     *
1866:     * PROTECTED PROCEDURE explicito: hook de FormBase, nao se chama de fora.
1867:     *==========================================================================
1868:     PROTECTED PROCEDURE BOParaForm
1869:         LOCAL loc_cCidChavesBO, loc_lSucesso
1870:         loc_lSucesso = .F.
1871: 


### BO (C:\4c\projeto\app\classes\SigOpSqnBO.prg):
*==============================================================================
* SigOpSqnBO.prg - Business Object para "Sequencia de Operacoes do Caixa" (SIGOPSQN)
*
* Origem legado : SigOpSqn.SCX  (tasks\task806)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes do Caixa)
* Tabela base   : SigMvCxs | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que grava a SEQUENCIA de execucao das operacoes de caixa de
* uma operacao-pai (crSigCdOpe.Dopes). O legado recebe "poForm" (o form pai)
* e "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do pai
* e manipula um cursor REMOTO bufferizado ("crSigMvCxs", requeried via
* SigCdOpe.poDataMgr) que lista as linhas de SigMvCxs filtradas pela operacao
* corrente. A grade (GradeSubN) tem 2 colunas editaveis:
*   Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes, filtrado
*              por CupFis IN (1,3) - so operacoes de "Cupom Fiscal")
*   Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
* Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
* corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava via
* poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o dialogo).
*
* GRAVACAO
* --------
* O legado grava via TableUpdate do cursor bufferizado inteiro (poDataMgr.
* UpDate('crSigMvCxs') + Commit()) so no clique de Sair/Encerrar - nao ha
* Inserir/Atualizar/Excluir linha-a-linha contra o SQL Server durante a
* edicao da grade (isso fica so no cursor local, igual ao padrao de
* SigOpSnoBO.ListarSubNiveis/ListarSubSubNiveis: cursor READWRITE editado
* pela grade, e o BO grava quando o Form decide persistir).
*
* METODOS DE DADOS (todos entregues)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia cidchaves/cdopes/cnivels/seqs
*       de uma linha de SigMvCxs para as properties deste BO (Fase 2).
*   ListarSequencias(par_cOperacaoPai)  - popula THIS.this_cCursorSequencias
*       com as linhas de SigMvCxs da operacao-pai, equivalente ao legado
*       ReQuery('crSigMvCxs') (cursor READWRITE - a grade insere/remove linha
*       por Append Blank/Delete direto no cursor local). Eh o que alimenta a
*       grade do form (FormSigOpSqn.CarregarDados).
*   ListarOperacoesCupFis()             - popula THIS.this_cCursorOperacoes
*       com "Select Dopes From SigCdOpe Where CupFis in (1,3)", equivalente
*       ao legado TmpOper (universo do lookup da coluna cNivels). Fase 6 -
*       carregado UMA VEZ no InicializarForm, igual ao legado (nao eh
*       re-executado a cada CarregarDados).
*   LimparDados()                       - override da Fase 8: zera as 4
*       properties da entidade. Quem chama eh NovoRegistro(), antes do
*       FormSigOpSqn.FormParaBO atribuir a linha nova.
*   Inserir / Atualizar / ExecutarExclusao - PROTECTED, uma LINHA por
*       chamada. De fora usa-se Salvar()/Excluir() (regra #51).
*
*   A persistencia do cursor INTEIRO (equivalente ao poDataMgr.UpDate
*   ('crSigMvCxs') + Commit() do legado) NAO ficou aqui: ela eh
*   FormSigOpSqn.PersistirSequencias, que percorre o cursor local e chama
*   Salvar()/Excluir() linha a linha. O motivo eh que quem sabe o que a
*   SESSAO do dialogo mudou eh o form - ele guarda as linhas criadas
*   (this_cCidChavesNovas) e as marcas de exclusao do cursor, que sao o que
*   distingue INSERT de UPDATE e de DELETE; o legado tirava isso do buffer
*   da view remota, que nao existe aqui. Um metodo neste BO recebendo o
*   alias do cursor duplicaria esse estado em dois donos.
*
* VALIDACOES DO LEGADO QUE PERTENCEM AO cmdSair.Click (regra de negocio
* transcrita LITERALMENTE em FormSigOpSqn.ExisteOperacaoDuplicada e
* ExisteSequenciaNaoInformada, NUNCA reescrita):
*   1) Nenhuma cNivels duplicada em crSigMvCxs (Group By cNivels Having
*      Sum(1) > 1 -> "Existem Operacoes Duplicadas!!!").
*   2) Nenhuma linha com cNivels preenchida e Seqs = 0 (Where Not Empty
*      (cNivels) And Seqs = 0 -> "Existem Operacoes sem Sequencia
*      informada!!!").
*   As duas SO valem quando cmdInserir.Visible Or cmdExcluir.Visible (ou
*   seja, quando o pai esta em INSERIR/ALTERAR) E quando houve alguma
*   alteracao na sessao (lHouveExcl/lHouveIns/lHouveAlt).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos
* controles e no dimensionamento das colunas do cursor
* -------------------------------------------------------------------
*   SigMvCxs.cdopes     char(20) NOT NULL  SigMvCxs.cidchaves char(20) NOT NULL (PK)
*   SigMvCxs.cnivels    char(20) NOT NULL  SigMvCxs.seqs      numeric(2,0) NOT NULL
*   SigCdOpe.dopes      char(20) NOT NULL  - PK/descricao (coluna unica, ver
*                        regra do pipeline "SigCdOpe eh single-column: NUNCA
*                        usar descrs/Descrs")
*==============================================================================

DEFINE CLASS SigOpSqnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de sequencia de operacao (SigMvCxs)
    *--------------------------------------------------------------------------
    this_cCidChaves          = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cCDopes             = ""   && cdopes    char(20) NOT NULL - FK SigCdOpe.dopes (operacao-pai, a do cadastro)
    this_cCNivels            = ""   && cnivels   char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada na sequencia)
    this_nSeqs               = 0    && seqs      numeric(2,0) NOT NULL - sequencia de execucao (1 a 8)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm / Set DataSession To pnDataSes / pcEscolha
    *--------------------------------------------------------------------------
    this_cEscolha            = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR (habilita Inserir/Excluir)
    this_nDataSessionPai     = 0    && DataSessionId do pai (poForm.DataSessionId / pnDataSes do legado)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouvealt / lhouveexcl / lhouveins do
    * SIGOPSQN - usadas pelo cmdSair.Click para decidir se valida e grava.
    *
    * DONO UNICO (Fase 8): no legado essas tres flags sao do FORM, e no
    * migrado continuam sendo - quem escreve e quem le eh FormSigOpSqn
    * (this_lHouveAlteracao/this_lHouveInclusao/this_lHouveExclusao), nos
    * mesmos pontos do legado (Valid das celulas, Click de Inserir/Excluir,
    * BtnSairClick). As copias aqui ficam ZERADAS e servem so de espelho
    * documental do legado: NAO ligar codigo novo nelas sem antes remover as
    * do form, senao a tela passa a ter dois donos do mesmo estado e eles
    * divergem em silencio (a gravacao do Encerrar le o dono errado e nao
    * grava nada, ou grava sem alteracao nenhuma).
    *--------------------------------------------------------------------------
    this_lHouveAlteracao     = .F.  && lhouvealt  - houve alteracao de cNivels/Seqs numa linha existente
    this_lHouveExclusao      = .F.  && lhouveexcl - houve exclusao de linha
    this_lHouveInclusao      = .F.  && lhouveins  - houve inclusao de linha

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorSequencias   = "cursor_4c_Sequencias"  && crSigMvCxs - linhas de SigMvCxs da operacao-pai (grade)
    this_cCursorOperacoes    = "cursor_4c_Operacoes"   && TmpOper    - universo do lookup (SigCdOpe.Dopes, CupFis IN (1,3))

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SigMvCxs.cidchaves) e repoe os
    * valores iniciais que o legado tem na propria sessao do dialogo
    * (nenhuma alteracao/inclusao/exclusao ainda ocorrida).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvCxs"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nSeqs           = 0
        THIS.this_nDataSessionPai = 0
        THIS.this_lHouveAlteracao = .F.
        THIS.this_lHouveExclusao  = .F.
        THIS.this_lHouveInclusao  = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - zera as properties da ENTIDADE (Fase 8)
    *
    * BusinessBase.LimparDados so limpa this_cMensagemErro e deixa dito que
    * "subclasses devem limpar suas propriedades especificas". Quem chama eh
    * NovoRegistro() (e CancelarEdicao()/Excluir()), ou seja: toda vez que o
    * form prepara uma linha NOVA para gravar.
    *
    * Sem este override, as 4 properties entravam na linha nova com o valor
    * da linha ANTERIOR do laco de FormSigOpSqn.PersistirSequencias - hoje
    * isso fica mascarado porque o FormParaBO logo em seguida atribui as
    * quatro, mas qualquer caminho que deixasse de atribuir uma delas
    * gravaria o dado da linha errada, sem erro nenhum na tela.
    *
    * NAO limpa this_cCursorSequencias/this_cCursorOperacoes (nomes de alias,
    * nao dado) nem this_cEscolha/this_nDataSessionPai (contexto do form pai,
    * valido por toda a sessao do dialogo) - zerar esses derrubaria a carga
    * da grade e o controle de acesso aos botoes.
    *
    * DODEFAULT() primeiro, para nao perder a limpeza da mensagem de erro
    * feita pela base.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCDopes    = ""
        THIS.this_cCNivels   = ""
        THIS.this_nSeqs      = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de sequencia
    * (SigMvCxs) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Sequencias, populado por ListarSequencias,
    * ou qualquer outro cursor/SELECT que inclua as mesmas 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCDopes    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivels   = TratarNulo(cnivels,   "C")
                THIS.this_nSeqs      = TratarNulo(seqs,      "N")

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSequencias - Popula cursor_4c_Sequencias com as linhas de SigMvCxs
    * da operacao-pai, equivalente ao legado "ReQuery('crSigMvCxs')".
    *
    * A consulta eh a MESMA que o form pai (SIGCDOPE) registra para esse
    * cursor no seu AddCursor:
    *
    *   Select a.* From SigMvCxs a inner join SigCdOpe b on a.cdopes = b.Dopes
    *   Where a.cDopes = ?crSigCdOpe.Dopes Order by a.cDopes, a.cnivels
    *
    * As 4 colunas sao listadas explicitamente no lugar de "a.*": SigMvCxs
    * tem exatamente cdopes/cidchaves/cnivels/seqs (docs\schema.sql), e a
    * lista explicita eh o que garante que o CREATE/SELECT INTO e os
    * ControlSource da grade casem por nome.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): as duas colunas da grade sao editaveis e os botoes Inserir/
    * Excluir inserem e apagam linha direto no cursor local, igual ao legado
    * (Insert Into crSigMvCxs / Delete). Sem READWRITE a celula nem entra em
    * edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarSequencias(par_cOperacaoPai)
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
            loc_cSQL = "SELECT a.cdopes, a.cidchaves, a.cnivels, a.seqs" + ;
                       " FROM SigMvCxs a" + ;
                       " INNER JOIN SigCdOpe b ON a.cdopes = b.dopes" + ;
                       " WHERE a.cdopes = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cdopes, a.cnivels"

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Sequencias")
                    USE IN cursor_4c_Sequencias
                ENDIF

                SELECT * FROM cursor_4c_SeqTmp INTO CURSOR cursor_4c_Sequencias READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar as sequ" + CHR(234) + "ncias da opera" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarSequencias:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarOperacoesCupFis - Popula cursor_4c_Operacoes com o universo do
    * lookup da Column1 (cnivels), equivalente ao legado TmpOper:
    *
    *   lcSql = [Select Dopes From SigCdOpe Where CupFis in (1,3)]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcsql,'TmpOper')
    *   Select TmpOper
    *   Index On Dopes Tag dopes
    *
    * Carregado UMA VEZ (igual ao legado, no Init) - diferente de
    * ListarSequencias, que eh re-executado a cada CarregarDados deste
    * dialogo. Chamado por FormSigOpSqn.InicializarForm, antes do usuario
    * poder editar a grade.
    *
    * SigCdOpe eh single-column (regra do pipeline "SigCdOpe eh
    * single-column: NUNCA usar descrs/Descrs"): a mesma coluna dopes serve
    * de PK E de descricao - nao ha coluna de descricao separada.
    *
    * INDEX ON dopes TAG dopes - para o Valid da celula localizar com SEEK,
    * igual ao legado (Seek(This.Value, 'TmpOper', 'Dopes')).
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarOperacoesCupFis()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe WHERE cupfis IN (1, 3)"

            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar o universo de opera" + CHR(231) + CHR(245) + ;
                    "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarOperacoesCupFis:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de sequencia (SigMvCxs) no banco.
    * Equivalente ao legado cmdInserir.Click (Insert Into crSigMvCxs) seguido
    * da persistencia feita no Sair/Encerrar (poDataMgr.UpDate + Commit) -
    * aqui a gravacao do INSERT ja eh direta contra o SQL Server, por linha.
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

            loc_cSQL = "INSERT INTO SigMvCxs (cdopes, cidchaves, cnivels, seqs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqs, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSqn")
                USE IN cursor_4c_InsSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de sequencia (SigMvCxs) ja existente.
    * Equivalente a legado editando cNivels/Seqs direto na grade (Column1/
    * Column2.Valid) e persistindo no Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCxs SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " seqs    = " + FormatarNumeroSQL(THIS.this_nSeqs, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSqn")
                USE IN cursor_4c_UpdSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma linha de sequencia (SigMvCxs) do banco.
    * Equivalente ao legado cmdExcluir.Click (Delete da linha corrente de
    * crSigMvCxs), com a persistencia feita diretamente contra o SQL Server.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCxs" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSqn")
                USE IN cursor_4c_DelSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

