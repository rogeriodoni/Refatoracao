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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg) - TRECHOS RELEVANTES PARA PASS SQL (1925 linhas total):

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

*-- Linhas 1051 a 1098:
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
1079:         WITH THIS.grd_4c_Dados
1080:             .RecordSource          = ""
1081:             .RecordSource          = "cursor_4c_Sequencias"
1082:             .Column1.ControlSource = "cursor_4c_Sequencias.cnivels"
1083:             .Column2.ControlSource = "cursor_4c_Sequencias.seqs"
1084: 
1085:             *-- Reaplicar o que o rebind acabou de resetar
1086:             .Column1.Width = 150
1087:             .Column2.Width = 25
1088: 
1089:             .Column1.Header1.Alignment = 2
1090:             .Column2.Header1.Alignment = 2
1091:             .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1092:             .Column2.Header1.Caption   = "Seq"
1093: 
1094:             .Column1.CurrentControl = "txt_4c_Nivel"
1095:             .Column2.CurrentControl = "txt_4c_Seq"
1096:             .Column1.Sparse         = .F.
1097:             .Column2.Sparse         = .F.
1098: 

*-- Linhas 1110 a 1129:
1110:     * a grade:
1111:     *
1112:     *   WITH SigCdOpe / With .poDatamgr / .ReQuery('crSigMvCxs')
1113:     *       SELECT crSigMvCxs / GO top
1114:     *   Select crSigMvCxs / Goto Top
1115:     *   With Thisform.GradeSubN ... .Refresh
1116:     *
1117:     * No migrado, quem produz o cursor eh SigOpSqnBO.ListarSequencias (mesma
1118:     * consulta que o form pai registra em AddCursor para crSigMvCxs, filtrada
1119:     * pela operacao-pai), e o Go Top + Refresh vem DEPOIS do bind - popular o
1120:     * cursor NAO repinta a grade sozinho (regra #21).
1121:     *
1122:     * Metodo PUBLIC: eh o funil de carga que o harness de teste automatizado
1123:     * e os Click dos botoes (CmdInserirClick/BtnSairClick) alcancam de fora -
1124:     * PROTECTED faria a chamada externa estourar em runtime (regra #3/#51).
1125:     *
1126:     * Devolve .F. sem estourar quando o BO ainda nao existe ou a consulta
1127:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1128:     * reportada por ListarSequencias.
1129:     *==========================================================================

*-- Linhas 1147 a 1167:
1147:                 IF THIS.this_oBusinessObject.ListarSequencias(THIS.this_cOperacaoPai)
1148:                     THIS.VincularGrade()
1149: 
1150:                     *-- Legado: Select crSigMvCxs / Goto Top
1151:                     IF USED("cursor_4c_Sequencias")
1152:                         SELECT cursor_4c_Sequencias
1153:                         GO TOP
1154:                     ENDIF
1155: 
1156:                     *-- Legado: Thisform.GradeSubN.Refresh
1157:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1158:                         THIS.grd_4c_Dados.Refresh()
1159:                     ENDIF
1160: 
1161:                     loc_lSucesso = .T.
1162:                 ENDIF
1163:             ENDIF
1164:         CATCH TO loc_oErro
1165:             MsgErro("Erro ao carregar as sequ" + CHR(234) + "ncias da opera" + ;
1166:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1167:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 1364 a 1561:
1364:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1365:     *
1366:     *   Thisform.lHouveIns = .T.
1367:     *   Select crSigMvCxs
1368:     *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
1369:     *   If Eof()
1370:     *       Insert Into crSigMvCxs (cDopes, CidChaves) ;
1371:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1372:     *   EndIf
1373:     *   Select crSigMvCxs
1374:     *   Thisform.GradeSubN.Column1.SetFocus
1375:     *
1376:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1377:     * da ultima vez ainda nao foi preenchida, o legado reaproveita ela em vez
1378:     * de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o foco
1379:     * vai parar).
1380:     *
1381:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre a view
1382:     * bufferizada do pai e so persiste no Encerrar (poDataMgr.UpDate +
1383:     * Commit -> PersistirSequencias). A PK vai ja preenchida com fUniqueIds()
1384:     * (regra #22: cidchaves NUNCA em branco, senao a 2a linha colide no
1385:     * indice unico) e entra em this_cCidChavesNovas, que eh como o funil de
1386:     * gravacao sabe que a linha eh INSERT e nao UPDATE.
1387:     *
1388:     * O "Select crSigMvCxs" final do legado nao precisa ser reproduzido como
1389:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1390:     * DataSession do PAI (DataSession = 1), onde deixar outro alias
1391:     * selecionado atrapalharia quem chamou - por isso o alias anterior eh
1392:     * restaurado.
1393:     *
1394:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1395:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) =
1396:     * .T.). NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1397:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1398:     * read-only") e derrubaria o handler.
1399:     *==========================================================================
1400:     PROCEDURE CmdInserirClick
1401:         LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro
1402: 
1403:         TRY
1404:             IF USED("cursor_4c_Sequencias")
1405:                 *-- Legado: Thisform.lHouveIns = .T.
1406:                 THIS.this_lHouveInclusao = .T.
1407: 
1408:                 loc_cAliasAnterior = ALIAS()
1409:                 SELECT cursor_4c_Sequencias
1410: 
1411:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
1412:                     AND EMPTY(cnivels)
1413: 
1414:                 IF !FOUND()
1415:                     loc_cCidChaves = ALLTRIM(fUniqueIds())
1416: 
1417:                     INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves) ;
1418:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1419: 
1420:                     THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + ;
1421:                         "|" + loc_cCidChaves
1422:                 ENDIF
1423: 
1424:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1425:                     SELECT (loc_cAliasAnterior)
1426:                 ENDIF
1427: 
1428:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1429:                     THIS.grd_4c_Dados.Refresh()
1430:                     THIS.grd_4c_Dados.Column1.SetFocus()
1431:                 ENDIF
1432:             ENDIF
1433:         CATCH TO loc_oErro
1434:             MsgErro(loc_oErro.Message + CHR(13) + ;
1435:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1436:                     "Procedure: " + loc_oErro.Procedure, ;
1437:                     "Erro em CmdInserirClick")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *==========================================================================
1442:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1443:     *
1444:     *   Select crSigMvCxs
1445:     *   If Not Eof() And ( crSigMvCxs.cDopes = crSigCdOpe.Dopes )
1446:     *       Thisform.lHouveExcl = .T.
1447:     *       Delete
1448:     *       Skip
1449:     *       Skip - 1
1450:     *   Endif
1451:     *   Thisform.GradeSubN.Refresh
1452:     *
1453:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1454:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1455:     * config.prg - a linha marcada desaparece da grade de imediato).
1456:     *
1457:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1458:     * Encerrar (PersistirSequencias) e SO para linha que ja existia no banco
1459:     * - linha nova excluida antes de gravar simplesmente desaparece, sem SQL
1460:     * nenhum.
1461:     *==========================================================================
1462:     PROCEDURE CmdExcluirClick
1463:         LOCAL loc_cAliasAnterior, loc_oErro
1464: 
1465:         TRY
1466:             IF USED("cursor_4c_Sequencias")
1467:                 loc_cAliasAnterior = ALIAS()
1468:                 SELECT cursor_4c_Sequencias
1469: 
1470:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
1471:                     *-- Legado: Thisform.lHouveExcl = .T.
1472:                     THIS.this_lHouveExclusao = .T.
1473:                     DELETE
1474:                     SKIP
1475:                     SKIP -1
1476:                 ENDIF
1477: 
1478:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1479:                     SELECT (loc_cAliasAnterior)
1480:                 ENDIF
1481:             ENDIF
1482: 
1483:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1484:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1485:                 THIS.grd_4c_Dados.Refresh()
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro(loc_oErro.Message + CHR(13) + ;
1489:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1490:                     "Procedure: " + loc_oErro.Procedure, ;
1491:                     "Erro em CmdExcluirClick")
1492:         ENDTRY
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1497:     * tambem dispara no ESC). Transcrito:
1498:     *
1499:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1500:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt )
1501:     *           Select CrSigMvCxs / Go Top / Go bottom
1502:     *           <validacao 1: cNivels duplicada>  -> MessageBox + Return .f.
1503:     *           <validacao 2: cNivels sem Seqs>   -> MessageBox + Return .f.
1504:     *           <UpDate('crSigMvCxs') + Commit(), com RollBack e MessageBox
1505:     *            'Erro na Gravacao dos Dados do Cadastro de Operacoes.'>
1506:     *       Endif
1507:     *   ENDIF
1508:     *   Thisform.ParentForm.Enabled = .T.
1509:     *   Thisform.mCtrlBotoes(.T.)
1510:     *   ThisForm.Release
1511:     *
1512:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO as duas validacoes
1513:     * abortam o fechamento (o "Return .f." do legado); a FALHA DE GRAVACAO
1514:     * exibe a mensagem e FECHA do mesmo jeito, porque no legado o RollBack ja
1515:     * desfez tudo. Manter o dialogo aberto nesse caso convidaria a um segundo
1516:     * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK) -
1517:     * ver tambem o acerto de this_cCidChavesNovas em PersistirSequencias.
1518:     *
1519:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR
1520:     * ou usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1521:     *
1522:     * "Go Top / Go bottom" do legado forcava a view remota bufferizada a
1523:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1524:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1525:     *
1526:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1527:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos
1528:     * do pai porque la o pai ficava com os controles desabilitados um a um -
1529:     * aqui o InicializarForm desabilita o FORM PAI INTEIRO, entao reabilitar
1530:     * o form basta e nao ha metodo equivalente a chamar.
1531:     *
1532:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1533:     *==========================================================================
1534:     PROCEDURE BtnSairClick
1535:         LOCAL loc_lPodeFechar, loc_oErro
1536: 
1537:         loc_lPodeFechar = .T.
1538: 
1539:         TRY
1540:             IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
1541:                 IF THIS.this_lHouveExclusao OR THIS.this_lHouveInclusao OR ;
1542:                    THIS.this_lHouveAlteracao
1543: 
1544:                     *-- Legado: Select CrSigMvCxs / Go Top / Go bottom
1545:                     IF USED("cursor_4c_Sequencias")
1546:                         SELECT cursor_4c_Sequencias
1547:                         GO TOP
1548:                         GO BOTTOM
1549:                     ENDIF
1550: 
1551:                     DO CASE
1552:                     CASE THIS.ExisteOperacaoDuplicada()
1553:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1554:                             "es Duplicadas!!!", ;
1555:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1556:                         loc_lPodeFechar = .F.
1557: 
1558:                     CASE THIS.ExisteSequenciaNaoInformada()
1559:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1560:                             "es sem Sequ" + CHR(234) + "ncia informada!!!", ;
1561:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")

*-- Linhas 1587 a 1772:
1587:     *==========================================================================
1588:     * ExisteOperacaoDuplicada - 1a validacao do cmdSair.Click legado:
1589:     *
1590:     *   Select cNivels,sum(1) From CrSigMvCxs Into Cursor Selecao ;
1591:     *       Group by cNivels having sum(1) > 1
1592:     *   Select Selecao
1593:     *   If Reccount() > 0 ... 'Existem Operacoes Duplicadas!!!'
1594:     *
1595:     * Transcricao LITERAL (regra #17): o legado NAO exclui a linha em branco
1596:     * do agrupamento, logo DUAS linhas novas sem operacao informada tambem
1597:     * contam como duplicadas - esse eh o comportamento da tela e nao se
1598:     * "conserta" aqui.
1599:     *
1600:     * A linha marcada para exclusao NAO entra: SET DELETED ON (config.prg)
1601:     * esconde do SELECT, igual ao legado.
1602:     *
1603:     * _TALLY no lugar do RECCOUNT() do legado: RECCOUNT conta tambem registro
1604:     * marcado como excluido, e _TALLY eh o numero de linhas que o SELECT
1605:     * acabou de produzir.
1606:     *
1607:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1608:     *==========================================================================
1609:     PROTECTED FUNCTION ExisteOperacaoDuplicada
1610:         LOCAL loc_cAliasAnterior, loc_nQuantas
1611: 
1612:         IF !USED("cursor_4c_Sequencias")
1613:             RETURN .F.
1614:         ENDIF
1615: 
1616:         loc_cAliasAnterior = ALIAS()
1617: 
1618:         IF USED("cursor_4c_SelecaoSqn")
1619:             USE IN cursor_4c_SelecaoSqn
1620:         ENDIF
1621: 
1622:         SELECT cnivels, SUM(1) AS nquantas ;
1623:             FROM cursor_4c_Sequencias ;
1624:             GROUP BY cnivels ;
1625:             HAVING SUM(1) > 1 ;
1626:             INTO CURSOR cursor_4c_SelecaoSqn READWRITE
1627: 
1628:         loc_nQuantas = _TALLY
1629: 
1630:         IF USED("cursor_4c_SelecaoSqn")
1631:             USE IN cursor_4c_SelecaoSqn
1632:         ENDIF
1633: 
1634:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1635:             SELECT (loc_cAliasAnterior)
1636:         ENDIF
1637: 
1638:         RETURN (loc_nQuantas > 0)
1639:     ENDFUNC
1640: 
1641:     *==========================================================================
1642:     * ExisteSequenciaNaoInformada - 2a validacao do cmdSair.Click legado:
1643:     *
1644:     *   Select [ ] as Agrupar,Sum(1) From CrSigMvCxs Into Cursor Selecao ;
1645:     *       where Not Empty(cNivels) And Seqs = 0 group by 1
1646:     *   Select Selecao
1647:     *   If Reccount() > 0 ... 'Existem Operacoes sem Sequencia informada!!!'
1648:     *
1649:     * O criterio que CERCA a validacao eh parte dela (regra #21b): o legado
1650:     * so reclama de linha COM operacao informada e sequencia zerada - linha
1651:     * totalmente em branco nao entra aqui (ela cai na validacao de
1652:     * duplicidade quando houver mais de uma).
1653:     *
1654:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1655:     *==========================================================================
1656:     PROTECTED FUNCTION ExisteSequenciaNaoInformada
1657:         LOCAL loc_cAliasAnterior, loc_nQuantas
1658: 
1659:         IF !USED("cursor_4c_Sequencias")
1660:             RETURN .F.
1661:         ENDIF
1662: 
1663:         loc_cAliasAnterior = ALIAS()
1664: 
1665:         IF USED("cursor_4c_SelecaoSqn")
1666:             USE IN cursor_4c_SelecaoSqn
1667:         ENDIF
1668: 
1669:         SELECT " " AS agrupar, SUM(1) AS nquantas ;
1670:             FROM cursor_4c_Sequencias ;
1671:             WHERE !EMPTY(cnivels) AND seqs = 0 ;
1672:             GROUP BY 1 ;
1673:             INTO CURSOR cursor_4c_SelecaoSqn READWRITE
1674: 
1675:         loc_nQuantas = _TALLY
1676: 
1677:         IF USED("cursor_4c_SelecaoSqn")
1678:             USE IN cursor_4c_SelecaoSqn
1679:         ENDIF
1680: 
1681:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1682:             SELECT (loc_cAliasAnterior)
1683:         ENDIF
1684: 
1685:         RETURN (loc_nQuantas > 0)
1686:     ENDFUNC
1687: 
1688:     *==========================================================================
1689:     * PersistirSequencias - grava no SQL Server o que a sessao mudou em
1690:     * cursor_4c_Sequencias (SigMvCxs). Equivale ao bloco de gravacao do
1691:     * cmdSair.Click legado:
1692:     *
1693:     *   m.lnErro1 = SigCdOpe.poDatamgr.pnIdConn
1694:     *   If m.lnErro1>0 : m.lnErro1 = Iif(.poDataMgr.UpDate('crSigMvCxs'),1,-1)
1695:     *   If m.lnErro1>0 : m.lnErro1 = .poDataMgr.Commit()
1696:     *   If Not m.lnErro1>0 : .poDataMgr.RollBack()
1697:     *
1698:     * Sem a view bufferizada do Framework nao ha TableUpdate em bloco: a
1699:     * persistencia eh linha-a-linha via o BO (Salvar/Excluir, que sao os
1700:     * metodos PUBLIC - Inserir/Atualizar/ExecutarExclusao sao PROTECTED e
1701:     * NUNCA se chamam de fora, regra #51). Exclusoes primeiro, depois
1702:     * inclusoes/atualizacoes - a mesma ordem do TableUpdate.
1703:     *
1704:     * Linha marcada para exclusao que NUNCA foi gravada (esta em
1705:     * this_cCidChavesNovas) nao vira DELETE: no banco ela nao existe.
1706:     * Para alcancar as linhas marcadas eh preciso suspender o SET DELETED ON
1707:     * do config.prg - com ele ligado, o SCAN pula a linha excluida ANTES de
1708:     * avaliar o FOR.
1709:     *
1710:     * Transcricao fiel (regra #17): o Encerrar legado NAO descarta linha com
1711:     * cnivels em branco antes de gravar (quem faz isso, para OUTRA tabela, eh
1712:     * o dialogo irmao SIGOPSNO) - uma unica linha em branco passa as duas
1713:     * validacoes e eh gravada, igual ao TableUpdate do legado.
1714:     *
1715:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1716:     *==========================================================================
1717:     PROTECTED FUNCTION PersistirSequencias
1718:         LOCAL loc_cAliasAnterior, loc_lSucesso, loc_cCidChaves, loc_lNovo, ;
1719:               loc_cDeletedStatus
1720: 
1721:         loc_lSucesso = .T.
1722: 
1723:         IF !USED("cursor_4c_Sequencias")
1724:             RETURN .T.
1725:         ENDIF
1726: 
1727:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1728:             RETURN .F.
1729:         ENDIF
1730: 
1731:         loc_cAliasAnterior = ALIAS()
1732:         SELECT cursor_4c_Sequencias
1733: 
1734:         *-- Exclusoes das linhas que JA existiam no banco
1735:         loc_cDeletedStatus = SET("DELETED")
1736:         SET DELETED OFF
1737:         SCAN FOR DELETED()
1738:             loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1739: 
1740:             IF !EMPTY(loc_cCidChaves) AND ;
1741:                !("|" + loc_cCidChaves + "|" $ ("|" + THIS.this_cCidChavesNovas + "|"))
1742:                 *-- Excluir() recusa registro marcado como novo; a linha
1743:                 *-- existe no banco, logo this_lNovoRegistro = .F.
1744:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1745: 
1746:                 *-- Fase 8: a linha corrente vai para o BO num lugar SO
1747:                 THIS.FormParaBO()
1748: 
1749:                 IF !THIS.this_oBusinessObject.Excluir()
1750:                     loc_lSucesso = .F.
1751:                 ENDIF
1752:             ENDIF
1753:         ENDSCAN
1754:         SET DELETED &loc_cDeletedStatus
1755: 
1756:         *-- Inclusoes / atualizacoes das linhas vivas
1757:         SCAN FOR !DELETED()
1758:             loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1759:             loc_lNovo      = ("|" + loc_cCidChaves + "|" $ ;
1760:                               ("|" + THIS.this_cCidChavesNovas + "|"))
1761: 
1762:             *-- Modo ANTES das properties: NovoRegistro() passa por
1763:             *-- LimparDados(), e EditarRegistro() recusa enquanto
1764:             *-- this_lNovoRegistro estiver ligado de uma linha anterior
1765:             IF loc_lNovo
1766:                 THIS.this_oBusinessObject.NovoRegistro()
1767:             ELSE
1768:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1769:                 THIS.this_oBusinessObject.EditarRegistro()
1770:             ENDIF
1771: 
1772:             *-- Fase 8: a linha corrente vai para o BO num lugar SO

*-- Linhas 1778 a 1808:
1778:                 THIS.BOParaForm()
1779: 
1780:                 *-- A linha passou a existir no banco: sai da lista de novas,
1781:                 *-- para um segundo Encerrar nao tentar INSERT de novo
1782:                 *-- (cidchaves eh PK)
1783:                 IF loc_lNovo
1784:                     THIS.this_cCidChavesNovas = STRTRAN(THIS.this_cCidChavesNovas, ;
1785:                         "|" + loc_cCidChaves, "")
1786:                 ENDIF
1787:             ELSE
1788:                 loc_lSucesso = .F.
1789:             ENDIF
1790:         ENDSCAN
1791: 
1792:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1793:             SELECT (loc_cAliasAnterior)
1794:         ENDIF
1795: 
1796:         RETURN loc_lSucesso
1797:     ENDFUNC
1798: 
1799:     *==========================================================================
1800:     * FormParaBO - transporte LINHA DA GRADE -> BO (Fase 8)
1801:     *
1802:     * A "ficha" desta tela eh a LINHA da grade: as duas celulas editaveis
1803:     * (cnivels/seqs) mais as duas colunas que o usuario nao ve (cdopes, que
1804:     * eh a operacao-pai, e cidchaves, a PK). Este metodo copia a linha
1805:     * CORRENTE de cursor_4c_Sequencias para as properties do BO - eh o
1806:     * equivalente, aqui, do FormParaBO de um form CRUD, que leva os
1807:     * TextBoxes da pagina Dados para o BO.
1808:     *

*-- Linhas 1848 a 1866:
1848:     * gravada. SigOpSqnBO.Inserir() gera a PK quando ela chega vazia
1849:     * ("IF EMPTY(this_cCidChaves) / this_cCidChaves = fUniqueIds()", regra
1850:     * #22), e nesse caso a linha do cursor continuaria com a chave antiga: um
1851:     * segundo Encerrar mandaria UPDATE/DELETE para um cidchaves que nao
1852:     * existe no banco, em silencio. Sincronizar aqui fecha esse buraco.
1853:     *
1854:     * As outras tres colunas NAO sao reescritas de proposito: elas acabaram
1855:     * de sair da propria linha (FormParaBO) e o BO nao as transforma -
1856:     * reescrever criaria um segundo dono para o que o usuario digitou.
1857:     *
1858:     * Repinta a grade no fim: alterar o cursor NAO repinta sozinho (regra
1859:     * #21a).
1860:     *
1861:     * PROTECTED PROCEDURE explicito: hook de FormBase, nao se chama de fora.
1862:     *==========================================================================
1863:     PROTECTED PROCEDURE BOParaForm
1864:         LOCAL loc_cCidChavesBO, loc_lSucesso
1865:         loc_lSucesso = .F.
1866: 


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

