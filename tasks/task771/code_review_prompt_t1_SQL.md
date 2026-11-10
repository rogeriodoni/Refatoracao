# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUPF' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, NFEEVE, CEMPS, ICLIS, STATS, DOPES, LNRET, I, GEROPES, CPROS, 1, VARIAVE, V, NP
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, NFEEVE, CEMPS, ICLIS, STATS, DOPES, LNRET, I, GEROPES, CPROS, 1, VARIAVE, V, NP

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
  ControlSource = "crSigMvNfd.nfedesc"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQuery = [Select * From SigMvNfd Where empdopnums = '] + lcEDN + [' and nfeEve = '] + thisform.Evento + [' order by nfeseq desc]
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crSigMvNfd]) < 1)
SELECT crSigMvNfd
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2, c3, c4) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
INSERT into CFTags (c1, c24, c2) ;
SELECT CFTags
Select localOpe
lcQuery = [Select RazSocs, Razas, Endes, Numeros, Compls, Bairs, Cidas, Estas, Ceps, ] + ;
		    [From SigCdEmp ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
SELECT CFTags
	SELECT CFTags
	SELECT CFTags
SELECT CFTags
DELETE FILE &lcPed
	DELETE FILE &lcDest
	DELETE FILE &lcDest
		DELETE FILE &lcDest
		DELETE FILE &lcDest
If (ThisForm.ParentForm.poDataMgr.SqlExecute([Select * From SigMvCab Where empdopnums = '] + lcEDN + [' ], [crSigMvCab]) < 1)
lcQuery = [Select a.NFiscals, a.Parcs, b.ImpDFProNf, b.ImpDFObsNf, d.ImpdfRefNf, b.Distribs, ] + ;
		[From SigCdOpe a ] + ;
		[Left Join SigOpCdd b On a.Dopes = b.Dopes ] + ;
		[Left Join SigOpCdc c On a.Dopes = c.Dopes ] + ;
		[Left Join SigOpCdi d On a.Dopes = d.Dopes ] + ;
If (Thisform.Parentform.poDataMgr.SqlExecute(lcQuery, [LocalOpe]) < 1)
PRIVATE cTo, cAssunto, cAnexo, cCorpo, cFrom, cCC, cServer, cSenha, nPorta
			If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfi])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
			If Not ThisForm.ParentForm.poDataMgr.Update([crSigPrNfe])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
			If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvCab])
				=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigPrNfe])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvCab])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
Select localOpe
lcQuery = [Select * From SigCdEmp Where CEmps = '] + lcEmpEmi + [']
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
cFrom  = ALLTRIM(LocalEmp.emailnfe)
	DELETE FILE &lcArq
		DELETE FILE &lcDest
		DELETE FILE &lcDest		&& apaga arquivos validados anteriormente		
				DELETE FILE &lcDest
			DELETE file &lcDest
			DELETE FILE &lcArq
				DELETE FILE &lcDest
		lcQuery = [Select eMails From SigCdCli Where IClis = '] + crSigMvNfi.CliFors + [']
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalCliD]) < 1)
			IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigPrNfe])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfd])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfd)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvCab])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvCab)])
			Select a.*, lcDopenfs  As DopeAuts From crTpmMvItn a ;
			Select a.*, lcDopenfs As DopeAuts From crTpmMvItn a, csOpeTrf b ;
			Select Distinct DopeAuts As Dopes ;
				From csItemAut where 1=0 ;
			DELETE FILE &lcDest
	DELETE FILE &lcArq
		DELETE FILE &lcDest
			DELETE FILE &lcDest
				DELETE FILE &lcDest
			DELETE FILE &lcDest
		lcQuery = [Select eMails From SigCdCli Where IClis = '] + crSigMvNfi.CliFors + [']
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalCliD]) < 1)
			IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfd])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfd)])
			DELETE FILE &lcDest
	lcQuery = [Select * From SigMvNfd Where empdopnums = '] + lcEDN + [' and nfeEve = '] + thisform.Evento + [' order by nfeseq desc]
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [crSigMvNfd]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpNFd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1541 linhas total):

*-- Linhas 46 a 80:
46: *                          "Set DataSession to pDId" para que este dialogo
47: *                          veja os cursores do pai (crSigmvNfi, crSigCdOpe,
48: *                          LocalOpe, ...) na MESMA sessao. Nesta arquitetura
49: *                          o SigOpNFdBO le essas tabelas por SQLEXEC proprio
50: *                          (ver cabecalho do BO), entao o valor e armazenado
51: *                          so para fidelidade/diagnostico - nao ha
52: *                          "SET DATASESSION TO" neste form.
53: *   par_cEvento          - pEvento: 'CAN' (cancelamento) ou 'CAR' (carta de
54: *                          correcao)
55: *
56: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
57: * Init/InicializarForm, BO e o cabecalho). CONCLUIDA.
58: *
59: * FASE 4/8 - BOTOES DE ACAO (ramo FLAT, sem grid): cnt_4c_Botoes com os 2
60: * botoes reais do legado (Enviar = btnSelItens.Click, Cancelar = btnSair.
61: * Click). CONCLUIDA. BtnCancelarClick() reproduz o legado por completo
62: * (reabilita o form pai + Release). BtnEnviarClick() reproduz a guarda de
63: * descricao minima (regra #17 do CLAUDE.md - guard transcrito literalmente)
64: * e grava o evento via SigOpNFdBO.Salvar() (Inserir() ja implementado na
65: * Fase 2). O restante do fluxo legado (contexto da nota via SQLEXEC proprio,
66: * SAT.dll/DarumaFramework.dll, protocolo de arquivos da UniNFe, e-mail,
67: * Gerarnota) ainda NAO existe em nenhum ponto do projeto - documentado no
68: * cabecalho de BtnEnviarClick() e no cabecalho de SigOpNFdBO.prg
69: * ("fases seguintes"), nao e omissao silenciosa (regra fundamental do
70: * CLAUDE.md).
71: *
72: * FASE 5/8 - CAMPOS PRINCIPAIS (ramo FLAT, "Parte 1" dos campos restantes):
73: * cnt_4c_Observacao (descricao do evento - lbl_4c_LblEve + obj_4c_GetDesc),
74: * cnt_4c_NFe (numero da nota - lbl_4c_LblEmiss + txt_4c_Nfe, somente
75: * exibicao, When = .F. no dump) e cnt_4c_Data (data/hora do evento -
76: * lbl_4c_LblEntregas + txt_4c_Data, editavel, When = .T. no dump, valor
77: * inicial = DATETIME() como no Init legado - "thisform.cntData.getData.
78: * Value = ttoc(DATEtime())"). CONCLUIDA. BtnEnviarClick() agora le a
79: * descricao do CONTROLE real (obj_4c_GetDesc.Value) em vez de ler
80: * this_cNfedesc direto do BO (o container nao existia nas fases

*-- Linhas 99 a 119:
99: * que nao existem no original"). O que esta fase entrega no lugar sao os
100: * dois campos digitaveis do legado - os unicos cujo When devolve .T.:
101: *
102: *   ValidarDescricaoEvento() <- ControlSource = "crSigMvNfd.nfedesc" do
103: *     getDesc. Espelha o texto no BO a cada LostFocus, como o
104: *     ControlSource fazia continuamente; sem isso qualquer recarga
105: *     (ChkRefazerClick / AtualizarCursorEvento) reescreveria o EditBox a
106: *     partir de this_cNfedesc e apagaria o que o usuario digitou.
107: *
108: *   ValidarDataEvento() <- restricao de entrada da classe fweditdata
109: *     (framework.vcx) que o getData legado tinha. O migrado e TextBox
110: *     comum de valor CARACTERE, entao aceita qualquer texto, e o
111: *     CTOT(getData.Value) dos tres pontos de consumo do legado devolveria
112: *     DATETIME vazio em silencio. Aceita campo vazio (NullDisplay = "//"),
113: *     normaliza o que converte e repoe o ultimo valor valido no que nao
114: *     converte.
115: *
116: * Ambos em "LostFocus", nunca "KeyPress" (regra #47), e o de data com
117: * guarda de reentrancia (wrapper + Exec), porque MsgAviso e modal.
118: *
119: * Tambem adiciona o equivalente ao atucur() legado:

*-- Linhas 126 a 144:
126: * legado mexe apenas no cursor em memoria) e define o modo do BO -
127: * NovoRegistro no ramo de linha nova, EditarRegistro no ramo de reuso do
128: * evento 'CAN'. Quem grava e BtnEnviarClick, uma vez, com a descricao
129: * final - igual ao "replace nfedesc with lcdesc" + Update + Commit do
130: * Click legado.
131: *
132: * Estes metodos tem uma GUARDA explicita contra this_cNfiEmpDopNums
133: * vazio: a leitura do CONTEXTO da nota (SigMvNfi, via DataSession
134: * compartilhada no legado) ainda nao existe em nenhuma fase deste BO -
135: * mesma pendencia ja documentada em BtnEnviarClick() e no cabecalho de
136: * SigOpNFdBO.prg. Sem a chave da nota, gravar um evento deixaria
137: * empdopnums/emps/nfis em branco (pior que nao gravar nada) - por isso a
138: * guarda, e nao e omissao silenciosa: esta documentada nos tres lugares
139: * (aqui, no BO e em BtnEnviarClick).
140: *
141: * Refazer.Click legado (linhas 1759-1782 do dump) e reproduzido em
142: * ChkRefazerClick(): marcado, consulta o ultimo evento e so cria
143: * sequencia nova se nao achar nenhum; desmarcado, sempre atualiza (cria
144: * sequencia nova). Verao nao tem Click no legado - e lido direto no

*-- Linhas 234 a 252:
234: *
235: *   LimparCampos() - reset do "evento novo": e o "nfedesc with ''" do
236: *     atucur (linha 572), que no legado zera a COLUNA e, por tabela (o
237: *     getDesc tinha ControlSource), tambem o que esta na tela. Aqui zera
238: *     os dois - property e controle. NAO toca o campo de data/hora: o
239: *     legado tem exatamente essa linha COMENTADA nos dois pontos onde ela
240: *     caberia ("*!* nfedte with DATETIME()" no atucur, linha 562, e
241: *     "*!* thisform.cntData.getData.Value = ttoc(DATEtime())" no
242: *     Refazer.Click, linha 1772) - reinstalar o reset da data seria
243: *     reativar codigo que o autor do legado desligou.
244: *
245: * Alem dos hooks, esta fase fecha DUAS lacunas de comportamento:
246: *
247: *   1. btnSelItens.Click termina com "thisform.atucur()  && atualiza
248: *      cursor" (linha 1676), FORA de qualquer IF e antes do RETURN lOk -
249: *      depois de gravar, a tela se recarrega. BtnEnviarClick nao fazia
250: *      isso. O RETURN antecipado da guarda de descricao continua
251: *      PULANDO o atucur, igual ao "return" nu do legado (linha 1122).
252: *

*-- Linhas 544 a 562:
544:     * dump, filhos DIRETOS do form - ramo FLAT, sem Page1/Page2):
545:     *
546:     *   cnt_4c_Observacao <- cntObservacao (lblEve + getDesc - descricao do
547:     *     evento, ControlSource = "crSigMvNfd.nfedesc" no legado; aqui o
548:     *     valor eh sincronizado manualmente com SigOpNFdBO.this_cNfedesc em
549:     *     BtnEnviarClick, ja que este form nao tem FormParaBO/BOParaForm)
550:     *
551:     *   cnt_4c_NFe <- cntNFe (lblEmiss + txt_4c_Nfe - numero da nota/nfis;
552:     *     When do getNfe retorna .F. no dump -> campo NAO recebe foco,
553:     *     .Enabled = .F. aqui. Valor vem de crsigmvnfi.nfis via atucur() -
554:     *     ainda nao portado, ver cabecalho de SigOpNFdBO.prg)
555:     *
556:     *   cnt_4c_Data <- cntData (lblEntregas + txt_4c_Data - data/hora do
557:     *     evento; When do getData retorna .T. no dump -> campo RECEBE foco
558:     *     (editavel, ao contrario de getNfe/getSeq/GetEvento). Valor
559:     *     inicial = DATETIME(), reproduzindo o Init legado -
560:     *     "thisform.cntData.getData.Value = ttoc(DATEtime())" - que roda
561:     *     ANTES do atucur() e nao depende de nenhum cursor)
562:     *

*-- Linhas 885 a 921:
885: 
886:     *==========================================================================
887:     * ValidarDescricaoEvento - Equivalente, nesta arquitetura, ao
888:     * ControlSource do getDesc legado.
889:     *
890:     * No dump, getDesc declara ControlSource = "crSigMvNfd.nfedesc" (SECAO 2
891:     * - PROPRIEDADES DE SIGOPNFD.cntObservacao.getDesc): o texto digitado vai
892:     * para o cursor do evento CONTINUAMENTE, e e dali que todo o resto do
893:     * legado o le - "IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15" (linha 1120),
894:     * "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha 999) e
895:     * "lcDesc = ALLTRIM(fLimpaTexto(crSigMvNfd.nfedesc))" (linha 1209).
896:     *
897:     * Nesta arquitetura nao ha ControlSource (o BO le/grava por SQLEXEC), e
898:     * o controle eh a fonte UNICA do texto: sem este espelhamento, o valor
899:     * digitado so chegaria ao BO dentro de BtnEnviarClick - e qualquer
900:     * recarga anterior a isso (ChkRefazerClick no ramo "achou evento",
901:     * AtualizarCursorEvento) reescreve obj_4c_GetDesc.Value a partir de
902:     * this_cNfedesc e APAGA o que o usuario digitou, sem erro e sem log. No
903:     * legado isso nao acontece justamente porque o ControlSource ja havia
904:     * gravado o texto no cursor.
905:     *
906:     * NAO exibe mensagem: o ControlSource do legado nao avisa nada, e a
907:     * unica critica da descricao ("Descricao do evento invalida", LEN < 15)
908:     * mora no Click do botao Enviar - reproduzida em BtnEnviarClick. Avisar
909:     * aqui inventaria comportamento e, pior, atrapalharia quem esta no meio
910:     * da digitacao (regra #50 do CLAUDE.md).
911:     *
912:     * Fase 8: a atribuicao solta a this_cNfedesc deu lugar a FormParaBO(),
913:     * fonte unica da transferencia controles -> BO (CLAUDE.md #44, item 6).
914:     * Varrer os quatro controles em vez de um nao muda nada aqui: os outros
915:     * tres recebem o valor que ja esta neles.
916:     *==========================================================================
917:     PROCEDURE ValidarDescricaoEvento()
918:         THIS.FormParaBO()
919:     ENDPROC
920: 
921:     *==========================================================================

*-- Linhas 1153 a 1194:
1153:     *
1154:     * NAO ha grade neste form (layout.json nao declara um unico objeto
1155:     * baseClass=grid, e a SECAO 1 do dump confirma: nenhum grid/pageframe),
1156:     * logo nao ha RecordSource/ControlSource de coluna, GO TOP nem
1157:     * Grid.Refresh a fazer aqui - o repintar equivalente eh o
1158:     * "ThisForm.Refresh" com que o atucur termina, dentro de BOParaForm.
1159:     * Mesmo padrao de funil de FormSigOpNch.CarregarLista() ->
1160:     * CarregarGrade().
1161:     *
1162:     * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama
1163:     * oForm.CarregarLista() de FORA da classe, e metodo PROTECTED falha ali
1164:     * em runtime mesmo com PEMSTATUS(...,5) devolvendo .T. (regras #3 e #51
1165:     * do CLAUDE.md).
1166:     *==========================================================================
1167:     PROCEDURE CarregarLista()
1168:         RETURN THIS.AtualizarCursorEvento()
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * FormParaBO - Transferencia CONTROLES -> BO.
1173:     *
1174:     * Cobre os QUATRO controles que o legado le de volta, com todos os seus
1175:     * sites no dump:
1176:     *
1177:     *   cntObservacao.getDesc -> this_cNfedesc
1178:     *       "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha
1179:     *       999) e, via ControlSource, "LEN(ALLTRIM(crsigmvnfd.nfedesc))"
1180:     *       (linha 1120) e "fLimpaTexto(crSigMvNfd.nfedesc)" (linha 1209).
1181:     *
1182:     *   cntData.getData -> this_dNfedte
1183:     *       "CTOT(thisform.cntData.getData.Value)" (linhas 571, 1220 e
1184:     *       1469). CTOT de texto nao-convertivel devolve DATETIME VAZIO sem
1185:     *       erro, e eh exatamente esse o valor que o legado gravaria -
1186:     *       ValidarDataEvento eh quem impede o campo de chegar nesse estado.
1187:     *
1188:     *   Refazer -> this_lRefazer
1189:     *       "thisform.refazer.Value = 1" (linhas 1310 e 1519).
1190:     *
1191:     *   Verao -> this_lHorarioVerao / this_cFusoHorario
1192:     *       "lcVerao = IIF(thisform.verao.Value=1,'02:00','03:00')"
1193:     *       (linha 1142).
1194:     *

*-- Linhas 1386 a 1405:
1386:     * BLANK do atucur legado (linha 572).
1387:     *
1388:     * No legado aquele replace zera a COLUNA nfedesc do cursor e, porque o
1389:     * getDesc tem ControlSource = "crSigMvNfd.nfedesc", a tela acompanha
1390:     * sozinha. Aqui nao ha ControlSource, entao zerar os DOIS lados -
1391:     * property e controle - eh o que reproduz o efeito.
1392:     *
1393:     * NAO toca o campo de data/hora. O legado tem exatamente essa linha
1394:     * COMENTADA nos dois pontos onde ela caberia ("*!* nfedte with
1395:     * DATETIME()" no atucur, linha 562, e "*!* thisform.cntData.getData.
1396:     * Value = ttoc(DATEtime())" no Refazer.Click, linha 1772): reinstalar o
1397:     * reset da data seria reativar codigo que o autor do legado desligou, e
1398:     * apagaria a data/hora que o usuario tiver informado.
1399:     *
1400:     * Tambem nao toca Refazer/Verao: o legado nunca os desmarca por codigo.
1401:     *
1402:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO/BOParaForm
1403:     * (FormBase declara LimparCampos como PROTECTED e o VFP9 nao permite
1404:     * alargar o escopo de metodo herdado).
1405:     *==========================================================================

*-- Linhas 1461 a 1503:
1461:         loc_oBO = THIS.this_oBusinessObject
1462: 
1463:         *-- Legado (linhas 1406 e 1649): replace nfedesc with lcdesc in
1464:         *-- crSigMvNfd, imediatamente antes do Update/Commit -
1465:         *-- cnt_4c_Observacao.obj_4c_GetDesc (equivalente a getDesc, Fase 5)
1466:         *-- eh a fonte UNICA do texto digitado. ValidarDescricaoEvento ja
1467:         *-- espelha a cada LostFocus (equivalente ao ControlSource do
1468:         *-- legado); aqui o espelhamento eh repetido para cobrir o caso de o
1469:         *-- usuario clicar Enviar com o cursor AINDA dentro do EditBox, em
1470:         *-- que o LostFocus nao chegou a disparar. Fase 8: por FormParaBO,
1471:         *-- que faz o mesmo para os QUATRO controles que o legado le de
1472:         *-- volta - a descricao, a data/hora (os tres CTOT do dump) e os
1473:         *-- dois CheckBox, todos consumidos pelo fluxo de envio.
1474:         THIS.FormParaBO()
1475: 
1476:         *-- Legado (linha 1120): IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15
1477:         IF LEN(loc_oBO.this_cNfedesc) < loc_oBO.this_nTamMinDescricao
1478:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do evento inv" + ;
1479:                      CHR(225) + "lida", "Aten" + CHR(231) + CHR(227) + "o")
1480:             RETURN
1481:         ENDIF
1482: 
1483:         *-- O MODO de gravacao ja foi definido por AtualizarCursorEvento ->
1484:         *-- SigOpNFdBO.AtualizarUltimoEvento (equivalente ao atucur): linha
1485:         *-- nova -> NovoRegistro (Salvar roteia para Inserir); evento 'CAN'
1486:         *-- reaproveitado -> EditarRegistro (Salvar roteia para Atualizar).
1487:         *-- NAO chamar NovoRegistro() aqui: forcaria INSERT tambem no ramo de
1488:         *-- reuso, criando um registro duplicado onde o legado faz UPDATE.
1489:         *-- Salvar() ja exibe a propria falha quando devolve .F. (regra #20
1490:         *-- do CLAUDE.md - inclusive o caso "nao esta em modo de edicao",
1491:         *-- que e como a ausencia do contexto da nota se manifesta enquanto
1492:         *-- a leitura de SigMvNfi nao for portada).
1493:         loc_oBO.Salvar()
1494: 
1495:         *-- Legado (linha 1676, ULTIMA instrucao do Click antes do
1496:         *-- "RETURN lOk"): "thisform.atucur()  && atualiza cursor". Fica
1497:         *-- FORA de qualquer IF no legado - roda tanto no caminho de sucesso
1498:         *-- quanto nos de falha do envio -, e por isso tambem roda aqui sem
1499:         *-- condicionar ao retorno de Salvar(). Depois de gravar, a tela se
1500:         *-- recarrega: a consulta volta a buscar o ultimo evento da nota e a
1501:         *-- sequencia exibida avanca.
1502:         *--
1503:         *-- O RETURN antecipado da guarda de descricao, acima, PULA este


### BO (C:\4c\projeto\app\classes\SigOpNFdBO.prg):
*==============================================================================
* SigOpNFdBO.prg - Business Object para SigOpNFd (Eventos NFe)
*
* Form OPERACIONAL (SIGOPNFD.SCX, Caption "Eventos NFe"). NAO eh cadastro
* CRUD: eh um dialogo FILHO, aberto pelo form de movimentacao/nota fiscal
* (ParentForm) passando (pForm1, pForm2, pDId, pEvento), que registra na
* SEFAZ um EVENTO sobre uma NFe ja emitida:
*
*   pEvento = 'CAN' -> CANCELAMENTO       (tpEvento 110111)
*   pEvento = 'CAR' -> CARTA DE CORRECAO  (tpEvento 110110)
*
* Fluxo do legado (a reproduzir nas fases seguintes):
*
*   Init do form
*     - Evento := pEvento; rotulo do campo GetEvento conforme o evento
*     - getData.Value := ttoc(DATETIME())
*     - atucur()  -> le o ULTIMO evento desta operacao e, se for 'CAR' ou se
*                    nao houver linha, APPEND BLANK + Replace no cursor de
*                    SigMvNfd com nfeseq = ultimo + 1 (1 quando nao ha linha)
*     - le SigMvCab pela chave empdopnums da nota
*     - le a configuracao da operacao (SigCdOpe + SigOpCdd + SigOpCdc +
*       SigOpCdi) para o cursor LocalOpe
*
*   atucur (metodo do form legado)
*     Select * From SigMvNfd Where empdopnums = <chave> And nfeEve = <evento>
*       Order By nfeseq desc
*     lnUltSeq = IIF(EOF(), 1, nfeseq + 1)
*     Replace cidchaves With fUniqueIds(), nfis, dopes, numes, emps,
*             empdopnums, nfedte With CTOT(getData.Value), nfedesc With '',
*             nfeeve With Evento, nfeseq With lnUltSeq
*     Espelha nfis / nfeseq / nfedesc nos campos da tela
*
*   btnSelItens.Click ("Enviar") - tres caminhos, decididos por SigCdOpe.CupFis
*     CupFis = 5 -> NFCe emitida pelo Migrate: cancela pela DLL
*                   DarumaFramework (tCFCancelar_NFCe_Daruma), exigindo
*                   SigPrNfe.stats = 'EMI' e situacao '100' na consulta
*     CupFis = 6 -> CF-e do SAT: canccfe() monta o XML de cancelamento
*                   (cursor CFTags) e grava SigMvNfi.canxml
*     demais     -> NFe pela UniNFe: valida/envia o XML do evento, le o
*                   retorno (cStat/xMotivo), grava SigMvNfd.nfexml +
*                   nfedesc, marca SigMvNfi.cancelas / SigPrNfe.stats e
*                   envia o XML por e-mail ao cliente
*     Fecha SEMPRE com atucur() (repopula o cursor do evento)
*
*   conscan (metodo do form legado)
*     Monta consSitNFe versao 4.00, envia pela UniNFe e, com cStat 100/101,
*     grava SigPrNfe.stats = 'CAN' / statts = '0' / prots = <nProt>
*
*   Refazer.Click
*     Marcado    -> reusa o ULTIMO evento gravado (nao cria sequencia nova):
*                   reenvia o XML de cancelamento ou reimprime a carta
*     Desmarcado -> atucur() (volta a criar a proxima sequencia)
*
* TABELAS E COLUNAS - todos os nomes conferidos em docs/schema.sql lido com
* Get-Content -Raw (o arquivo eh UTF-16; grep/findstr devolvem ZERO em
* silencio - regra #14 do CLAUDE.md):
*
*   SigMvNfd (tabela principal deste BO - um registro por EVENTO da nota)
*     cidchaves  char(20)      NOT NULL  PK (fUniqueIds no legado)
*     dopes      char(20)      NOT NULL
*     empdopnums char(29)      NOT NULL  Emps(3) + Dopes(20) + Str(Numes,6)
*     emps       char(3)       NOT NULL
*     nfedesc    text          NULL      justificativa / texto da correcao
*     nfedte     datetime      NULL      data/hora do evento (dhEvento)
*     nfeeve     char(3)       NOT NULL  'CAN' ou 'CAR'
*     nfeprt     char(15)      NOT NULL  protocolo
*     nfeseq     numeric(2,0)  NOT NULL  nSeqEvento (1..99)
*     nfexml     text          NULL      XML do evento autorizado
*     nfis       char(6)       NOT NULL  numero da nota
*     numes      numeric(6,0)  NOT NULL
*     numeronota char(10)      NOT NULL
*
*   SigMvNfi (nota fiscal de origem - crSigMvNfi no legado; gravada pelo
*            form PAI, lida e marcada por este fluxo)
*     cidchaves char(20), empdopnums char(29), emps char(3), dopes char(20),
*     numes numeric(6,0), nfis char(6), series char(8), clifors char(20),
*     emis datetime NULL, nfechv char(44), nfeprt char(15),
*     nfexml text NULL, canxml text NULL, cancelas bit
*
*   SigPrNfe (situacao da NFe - crSigPrNfe no legado)
*     stats char(3), statts char(1), prots char(15), arquivos char(250)
*
*   SigMvCab (cabecalho do movimento - crSigMvCab no legado)
*     empdopnums char(29), dopes char(20), lcancelas bit
*
*   SigCdOpe  cupfis numeric(1,0), dopes char(20)   (5=NFCe Migrate, 6=SAT)
*   SigOpCdd  configgers char(250)  (posicao 239..241 = empresa emitente)
*   SigOpCdc  cncaixas char(3), geropes numeric(1,0), dopenfs char(20)
*   SigCdPac  direxpsdfs char(200) (pasta de backup do XML)
*   SigCdEmp  cemps char(3) PK, razas char(40), cgcs char(20),
*             pastas char(50), textonfe text, emailnfe char(250),
*             servs char(50), senhas char(30), portas numeric(3,0),
*             textopaf text
*             ATENCAO (regra #48): a coluna de empresa de SigCdEmp eh
*             CEMPS; em SigMvNfd/SigMvNfi/SigPrNfe/SigMvCab eh EMPS.
*   SigCdCli  iclis char(10) PK, emails char(50)
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao do evento (Fase 2) espelha o APPEND BLANK + Replace
* do legado sobre SigMvNfd, por isso this_cTabela/this_cCampoChave apontam
* para SigMvNfd/cidchaves.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNFdBO AS BusinessBase

    *==========================================================================
    * SigMvNfd - registro do EVENTO (tabela principal deste BO)
    *
    * nfedte eh declarada com {/:} (DATETIME vazio, VARTYPE "T") e NAO com {}
    * (DATE): a hora faz parte do dhEvento enviado a SEFAZ, e so com tipo "T"
    * o FormatarDataSQL() acrescenta " HH:MM:SS" ao literal. Pelo mesmo motivo
    * NUNCA aplicar TTOD() a esta property (regra #16) - o valor vem de
    * CTOT(<TextBox>.Value) no form e pode chegar como DATE quando o campo
    * esta vazio; normalizar com ConverterParaData() apenas onde se quiser a
    * DATA pura (nome da pasta de autorizados, por exemplo).
    *==========================================================================
    this_cCidchaves  = ""     && cidchaves  char(20) NOT NULL - PK (fUniqueIds)
    this_cDopes      = ""     && dopes      char(20) NOT NULL - documento da operacao
    this_cEmpDopNums = ""     && empdopnums char(29) NOT NULL - Emps+Dopes+Str(Numes,6)
    this_cEmps       = ""     && emps       char(3)  NOT NULL - empresa do movimento
    this_cNfedesc    = ""     && nfedesc    text     NULL     - justificativa / correcao
    this_dNfedte     = {/:}   && nfedte     datetime NULL     - data/hora do evento
    this_cNfeeve     = ""     && nfeeve     char(3)  NOT NULL - 'CAN' ou 'CAR'
    this_cNfeprt     = ""     && nfeprt     char(15) NOT NULL - protocolo do evento
    this_nNfeseq     = 0      && nfeseq     numeric(2,0) NOT NULL - nSeqEvento (1..99)
    this_cNfexml     = ""     && nfexml     text     NULL     - XML do evento autorizado
    this_cNfis       = ""     && nfis       char(6)  NOT NULL - numero da nota
    this_nNumes      = 0      && numes      numeric(6,0) NOT NULL
    this_cNumeroNota = ""     && numeronota char(10) NOT NULL

    *==========================================================================
    * SigMvNfi - nota fiscal de ORIGEM (crSigMvNfi no legado)
    *
    * Prefixo "Nfi" nos nomes porque SigMvNfi e SigMvNfd tem colunas
    * HOMONIMAS com conteudo diferente (nfis, nfeprt, nfexml, emps, dopes,
    * numes, empdopnums, cidchaves): sem o prefixo, o protocolo da NOTA
    * sobrescreveria o protocolo do EVENTO.
    *==========================================================================
    this_cNfiCidchaves  = ""     && cidchaves  char(20) - PK da nota
    this_cNfiEmpDopNums = ""     && empdopnums char(29) - liga nota, evento e cabecalho
    this_cNfiEmps       = ""     && emps       char(3)
    this_cNfiDopes      = ""     && dopes      char(20)
    this_nNfiNumes      = 0      && numes      numeric(6,0)
    this_cNfiNfis       = ""     && nfis       char(6)  - numero da nota (exibido na tela)
    this_cNfiSeries     = ""     && series     char(8)  - serie da nota
    this_cNfiCliFors    = ""     && clifors    char(20) - cliente/fornecedor (SigCdCli.IClis)
    this_dNfiEmis       = {/:}   && emis       datetime NULL - emissao (pasta de autorizados)
    this_cNfiNfechv     = ""     && nfechv     char(44) - chave de acesso da NFe (cId / chNFe)
    this_cNfiNfeprt     = ""     && nfeprt     char(15) - protocolo da AUTORIZACAO (nProt)
    this_cNfiNfexml     = ""     && nfexml     text NULL - XML de autorizacao (origem do tpAmb)
    this_cNfiCanxml     = ""     && canxml     text NULL - XML do cancelamento
    this_lNfiCancelas   = .F.    && cancelas   bit - nota cancelada

    *==========================================================================
    * SigPrNfe - situacao da NFe (crSigPrNfe no legado)
    *
    * stats = 'EMI' eh pre-requisito para os dois eventos; o cancelamento
    * tambem aceita 'CAN' (reenvio). Ao autorizar o cancelamento o legado
    * grava stats = 'CAN' + statts = '0' e, no conscan, prots = <nProt>.
    *==========================================================================
    this_cStats    = ""   && stats    char(3)   - 'EMI' / 'CAN'
    this_cStatts   = ""   && statts   char(1)   - '0' apos cancelar
    this_cProts    = ""   && prots    char(15)  - protocolo retornado pela consulta
    this_cArquivos = ""   && arquivos char(250) - justificativa gravada no cancelamento de NFCe

    *==========================================================================
    * SigMvCab - cabecalho do movimento (crSigMvCab no legado)
    *==========================================================================
    this_cCabDopes     = ""    && dopes     char(20) - operacao do movimento (le a config da operacao)
    this_lCabLCancelas = .F.   && lcancelas bit - marca a OPERACAO como cancelada

    *==========================================================================
    * Configuracao da OPERACAO (cursor LocalOpe do legado: SigCdOpe +
    * SigOpCdd + SigOpCdc + SigOpCdi) e parametros do sistema (SigCdPac)
    *==========================================================================
    this_nCupFis     = 0    && SigCdOpe.cupfis     numeric(1,0) - 5=NFCe Migrate, 6=CF-e SAT, outros=NFe
    this_cConfigGers = ""   && SigOpCdd.configgers char(250)    - 239..241 = empresa emitente
    this_cCnCaixas   = ""   && SigOpCdc.cncaixas   char(3)      - numero do caixa (SAT: numeroCaixa)
    this_nGeropes    = 0    && SigOpCdc.geropes    numeric(1,0) - 4 = gera operacao automatica
    this_cDopenfs    = ""   && SigOpCdc.dopenfs    char(20)     - operacao gerada automaticamente
    this_cDirExpSdfs = ""   && SigCdPac.direxpsdfs char(200)    - pasta de backup do XML

    *==========================================================================
    * Empresa EMITENTE (cursor LocalEmp do legado: SigCdEmp da empresa
    * resolvida em ConfigGers 239..241, com fallback na empresa da nota)
    *
    * textopaf guarda, em posicoes FIXAS, os dados do SAT:
    *   1..14    CNPJ da casa de software (CNPJ da AC)
    *   16..359  assinatura (signAC)
    *   361..370 fabricante do equipamento SAT
    *==========================================================================
    this_cEmpCemps    = ""   && SigCdEmp.cemps    char(3) PK - empresa emitente
    this_cEmpRazas    = ""   && SigCdEmp.razas    char(40)
    this_cEmpCgcs     = ""   && SigCdEmp.cgcs     char(20) - CNPJ (a pasta do XML usa so os digitos)
    this_cEmpPastas   = ""   && SigCdEmp.pastas   char(50) - pasta raiz da UniNFe (cPathUni)
    this_cEmpTextoNfe = ""   && SigCdEmp.textonfe text NULL - corpo do e-mail
    this_cEmpEmailNfe = ""   && SigCdEmp.emailnfe char(250) - remetente / copia
    this_cEmpServs    = ""   && SigCdEmp.servs    char(50) - servidor SMTP
    this_cEmpSenhas   = ""   && SigCdEmp.senhas   char(30) - senha SMTP
    this_nEmpPortas   = 0    && SigCdEmp.portas   numeric(3,0) - porta SMTP
    this_cEmpTextoPaf = ""   && SigCdEmp.textopaf text NULL - dados do SAT em posicoes fixas

    *==========================================================================
    * Destinatario (SigCdCli) - e-mail para onde vai o XML do evento
    *==========================================================================
    this_cEmailCliente = ""   && SigCdCli.emails char(50) - WHERE IClis = SigMvNfi.clifors

    *==========================================================================
    * Estado do EVENTO em edicao (campos da tela e parametro de abertura)
    *
    * this_cEvento eh o pEvento recebido pelo form; os rotulos exibidos no
    * campo GetEvento sao atribuidos no Init (precisam de CHR() para os
    * acentos, e declaracao de property nao aceita chamada de funcao).
    *==========================================================================
    this_cEvento             = ""    && 'CAN' (cancelamento) ou 'CAR' (carta de correcao)
    this_cRotuloEvento       = ""    && texto exibido no campo GetEvento
    this_cRotuloCancelamento = ""    && 'CANCELAMENTO'      (atribuido no Init)
    this_cRotuloCarta        = ""    && 'CARTA DE CORRECAO'  (atribuido no Init, com CHR())
    this_lRefazer            = .F.   && CheckBox Refazer: reusa o ULTIMO evento gravado
    this_lHorarioVerao       = .F.   && CheckBox Horario de Verao: fuso 02:00 em vez de 03:00
    this_cFusoHorario        = ""    && '02:00' / '03:00' - sufixo do dhEvento (vem do CheckBox)
    this_nUltimaSequencia    = 0     && lnUltSeq do atucur: ultimo nfeseq + 1 (1 se nao ha evento)

    *==========================================================================
    * Constantes do evento NFe (layout nacional) - transcritas do legado
    *==========================================================================
    this_cTpEventoCancelamento = "110111"   && tpEvento do cancelamento
    this_cTpEventoCarta        = "110110"   && tpEvento da carta de correcao
    this_cVersaoEvento         = "1.00"     && versao do envEvento / evento / detEvento
    this_cVersaoConsulta       = "4.00"     && versao do consSitNFe (conscan)
    this_nTamMinDescricao      = 15         && LEN(ALLTRIM(nfedesc)) < 15 recusa o envio
    this_nMaxSequencia         = 99         && nfeseq eh numeric(2,0): 1..99

    *==========================================================================
    * Retorno da SEFAZ / do SAT (lido do XML de retorno)
    *==========================================================================
    this_cTipoAmbiente     = ""   && tpAmb extraido do XML de autorizacao da nota
    this_cStatusRetorno    = ""   && cStat (135 / 'EVENTO REGISTRADO' no evento; 100/101 no conscan)
    this_cMotivoRetorno    = ""   && xMotivo
    this_cMensagemRetorno  = ""   && mensagem montada para o usuario (cCampo no legado)
    this_cProtocoloRetorno = ""   && nProt retornado pela consulta de situacao
    this_cConteudoXml      = ""   && conteudo do XML autorizado (gravado em nfexml / canxml)

    *==========================================================================
    * Caminhos de arquivo da UniNFe - a pasta raiz vem de SigCdEmp.pastas e as
    * subpastas sao FIXAS no legado (nomes transcritos literalmente, pois sao
    * os nomes que o UniNFe monitora em disco)
    *==========================================================================
    this_cPathUni      = ""   && cPathUni - SigCdEmp.pastas
    this_cPathNFe      = ""   && cPathUni + <CNPJ sem pontuacao> + "\"
    this_cPathBackup   = ""   && SigCdPac.direxpsdfs ou cPathUni + "BKP\"
    this_cCnpjEmitente = ""   && SigCdEmp.cgcs sem ponto, barra e hifen
    this_cChaveAcesso  = ""   && cId - SigMvNfi.nfechv (44 posicoes)

    this_cPastaEnvio       = "envio\"
    this_cPastaEnviado     = "Enviado\"
    this_cPastaEmProc      = "Enviado\EmProcessamento\"
    this_cPastaEnvioLote   = "EnvioEmLote\"
    this_cPastaErro        = "Erro\"
    this_cPastaRetorno     = "Retorno\"
    this_cPastaValidar     = "Validar\"
    this_cPastaBkEnviados  = "BKenviados\"
    this_cPastaAssinado    = "Assinado\"
    this_cPastaValidado    = "Validado\"
    this_cPastaAutorizados = "Enviado\Autorizados\"
    this_cPastaPdf         = "PDF\"
    this_cPastaTxt         = "TXT\"

    *==========================================================================
    * CF-e do SAT (canccfe do legado) - dados lidos de SigCdEmp.textopaf
    *==========================================================================
    this_cCnpjAC        = ""   && textopaf 1..14    - CNPJ da casa de software
    this_cAssinaturaAC  = ""   && textopaf 16..359  - signAC
    this_cFabricanteSat = ""   && textopaf 361..370 - SWEDA / BEMAT / outros
    this_nCodFabricante = 0    && 3=SWEDA, 2=BEMAT, 0=demais
    this_cXmlCancelaSat = ""   && XML de cancelamento devolvido pelo SAT (pcXml no legado)

    *==========================================================================
    * Nomes dos cursores usados pelo BO e pelo Form (mantidos em property
    * para o Form nao repetir literais - mesmo padrao do SigOpNchBO)
    *==========================================================================
    this_cCursorEventos    = "cursor_4c_Eventos"     && SigMvNfd (crSigMvNfd no legado)
    this_cCursorNota       = "cursor_4c_Nota"        && SigMvNfi (crSigMvNfi)
    this_cCursorSitNFe     = "cursor_4c_SitNFe"      && SigPrNfe (crSigPrNfe)
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"   && SigMvCab (crSigMvCab)
    this_cCursorOperacao   = "cursor_4c_Operacao"    && SigCdOpe + SigOpCdd/Cdc/Cdi (LocalOpe)
    this_cCursorEmpresa    = "cursor_4c_Empresa"     && SigCdEmp (LocalEmp)
    this_cCursorCliente    = "cursor_4c_Cliente"     && SigCdCli (LocalCliD)
    this_cCursorParametros = "cursor_4c_Parametros"  && SigCdPac (crSigCdPac)
    this_cCursorTagsCFe    = "cursor_4c_TagsCFe"     && CFTags - estrutura do XML do SAT

    *==========================================================================
    * Init - Configura tabela/chave principal (SigMvNfd) e os rotulos de
    *        evento que dependem de CHR() para os acentos.
    *
    * NAO faz acesso a banco: Init que retorna .F. mata o form, e o BO eh
    * instanciado tambem pelo harness de teste, sem gnConnHandle valido.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela gravada por este BO: um registro por evento da nota
            THIS.this_cTabela     = "SigMvNfd"
            THIS.this_cCampoChave = "cidchaves"

            *-- Rotulos exibidos no campo GetEvento (legado: Init do form)
            THIS.this_cRotuloCancelamento = "CANCELAMENTO"
            THIS.this_cRotuloCarta        = "CARTA DE CORRE" + CHR(199) + CHR(195) + "O"

            *-- Fuso default do dhEvento: sem horario de verao o legado usa
            *-- '03:00' (IIF(thisform.verao.Value = 1, '02:00', '03:00'))
            THIS.this_cFusoHorario = "03:00"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNFdBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Valor da PK de SigMvNfd para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigMvNfd (crSigMvNfd no
    * legado - par_cAliasCursor eh tipicamente THIS.this_cCursorEventos) nas
    * properties deste BO. Mapeia TODAS as 13 colunas da tabela, na ordem do
    * schema (regra #22 do CLAUDE.md - conferido em docs/schema.sql lido com
    * Get-Content -Raw, por ser UTF-16).
    *
    * SELECT (par_cAliasCursor) primeiro, depois campo sem alias (Problema 9
    * do FORMCOR_LICOES_APRENDIDAS.md - "campo" eh sintaxe invalida
    * em VFP9).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cNfedesc    = TratarNulo(nfedesc, "")
                THIS.this_dNfedte     = TratarNulo(nfedte, {/:})
                THIS.this_cNfeeve     = TratarNulo(nfeeve, "")
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_nNfeseq     = TratarNulo(nfeseq, 0)
                THIS.this_cNfexml     = TratarNulo(nfexml, "")
                THIS.this_cNfis       = TratarNulo(nfis, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cNumeroNota = TratarNulo(numeronota, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarInsertEvento - Fonte UNICA do SQL de INSERT em SigMvNfd. Espelha o
    * "APPEND BLANK + Replace" do atucur() legado (linhas 564-574 do dump):
    *
    *   replace cidchaves with fUniqueIds(), nfis with crsigmvnfi.nfis,
    *           dopes with crsigmvnfi.dopes, numes with crsigmvnfi.numes,
    *           emps with crsigmvnfi.emps, empdopnums with crsigmvnfi.empdopnums,
    *           nfedte with CTOT(thisform.cntData.getData.Value),
    *           nfedesc with '', nfeeve with thisform.Evento,
    *           nfeseq with lnUltSeq in crSigMvNfd
    *
    * nfis/dopes/numes/emps/empdopnums vem das properties "Nfi" (espelham
    * crSigMvNfi - a nota de ORIGEM), nao das properties homonimas da nota
    * (que sao colunas DIFERENTES, com conteudo do proprio EVENTO).
    *
    * nfeprt char(15) NOT NULL e numeronota char(10) NOT NULL NUNCA aparecem
    * no atucur() nem em nenhum outro ponto do dump legado contra crSigMvNfd -
    * exatamente a armadilha da regra #22 (coluna invisivel no dump porque so
    * existia no buffer em branco do AddCursor). Gravar EscaparSQL("") para
    * as duas explicitamente, para nao violar o NOT NULL.
    *
    * nfedesc e nfexml sao NULL no schema. nfedesc vai com this_cNfedesc (e
    * NAO com '' literal): o '' do APPEND legado e valor INICIAL do cursor em
    * memoria - quando a linha chega de fato ao banco, pelo
    * "poDataMgr.Update([crSigMvNfd])" do Click, ela ja passou pelo "replace
    * nfedesc with lcdesc" (linhas 1406 e 1649 do dump) e carrega a
    * justificativa digitada. Gravar '' aqui perderia a descricao em todo
    * evento novo - exatamente o campo que o fluxo existe para registrar.
    * nfexml fica NULL (o legado nunca o toca antes da autorizacao; quem
    * grava o XML autorizado e Atualizar()).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertEvento()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigMvNfd (cidchaves, dopes, empdopnums, emps, " + ;
                   "nfedesc, nfedte, nfeeve, nfeprt, nfeseq, nfexml, nfis, " + ;
                   "numes, numeronota) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                   EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   FormatarDataSQL(THIS.this_dNfedte) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeeve, 3)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNfeseq, 0) + ", " + ;
                   "NULL, " + ;
                   EscaparSQL(LEFT(THIS.this_cNfis, 6)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ")"

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * MontarUpdateEvento - Fonte UNICA do SQL de UPDATE em SigMvNfd. Espelha o
    * UNICO Update que o legado faz contra crSigMvNfd (btnSelItens.Click,
    * linhas 1405-1406 e 1648-1649 do dump, repetido nos tres caminhos de
    * envio - NFCe/Migrate nao atualiza SigMvNfd, so SAT e UniNFe):
    *
    *   replace nfexml with cConteudoxml in crSigMvNfd
    *   replace nfedesc with lcdesc in crSigMvNfd
    *
    * So essas DUAS colunas sao tocadas em algum ponto do fluxo legado depois
    * do INSERT inicial - o resto do registro (chave, nota de origem, sequencia)
    * nasce certo no atucur() e nunca muda. Atualizar nfedte/nfeprt/nfeseq aqui
    * seria regra de negocio inventada (regra #17 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE MontarUpdateEvento()
        LOCAL loc_cSQL

        loc_cSQL = "UPDATE SigMvNfd SET " + ;
                   "nfedesc = " + EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   "nfexml = " + IIF(EMPTY(THIS.this_cNfexml), "NULL", EscaparSQL(THIS.this_cNfexml)) + ;
                   " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UM evento em SigMvNfd (caminho BusinessBase.Salvar e
    * o equivalente, nesta arquitetura, do atucur()/APPEND BLANK legado).
    *
    * cidchaves eh gerado AQUI quando ainda vazio, reproduzindo
    * "replace cidchaves with fUniqueIds()" - NUNCA string vazia (regra #22:
    * colidiria no indice unico do segundo evento).
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
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cCidchaves = fUniqueIds()
                ENDIF

                loc_cSQL = THIS.MontarInsertEvento()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o do Evento da NFe." + CHR(13) + loc_cErro
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
                    "Erro em SigOpNFdBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarUltimoEvento - SELECT do atucur() legado (linhas 552-558 do
    * dump):
    *
    *   lcEDN = crSigmvNfi.empdopnums
    *   lcQuery = Select * From SigMvNfd Where empdopnums = <lcEDN>
    *             and nfeEve = <thisform.Evento> order by nfeseq desc
    *
    * Carrega a linha mais recente (se houver) nas properties deste BO via
    * CarregarDoCursor. NAO faz APPEND BLANK - isso fica em
    * AtualizarUltimoEvento(), que decide se cria linha nova ou reusa esta.
    *
    * GUARDA: this_cNfiEmpDopNums (chave da nota de origem) ainda nao e
    * populada em nenhuma fase deste BO - a leitura do contexto da nota via
    * SigMvNfi (que no legado chega pela DataSession compartilhada com o
    * form pai) e a mesma pendencia ja documentada em
    * FormSigOpNFd.BtnEnviarClick e no cabecalho desta classe ("Fluxo do
    * legado... fases seguintes"). Consultar com a chave vazia casaria
    * empdopnums = '' e corromperia o diagnostico de "encontrado"/"nao
    * encontrado" - por isso o metodo nao tenta a consulta nesse caso.
    *==========================================================================
    PROCEDURE ConsultarUltimoEvento()
        LOCAL loc_lEncontrado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lEncontrado = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorEventos)
                    USE IN (THIS.this_cCursorEventos)
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfd WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cNfiEmpDopNums, 29)) + ;
                           " AND nfeeve = " + EscaparSQL(LEFT(THIS.this_cEvento, 3)) + ;
                           " ORDER BY nfeseq DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEventos)

                IF loc_nResultado >= 0 AND USED(THIS.this_cCursorEventos) AND !EOF(THIS.this_cCursorEventos)
                    THIS.CarregarDoCursor(THIS.this_cCursorEventos)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.ConsultarUltimoEvento")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *==========================================================================
    * AtualizarUltimoEvento - Equivalente ao atucur() legado completo (linhas
    * 548-584 do dump): consulta o ultimo evento (ConsultarUltimoEvento) e,
    * quando o evento e 'CAR' (carta de correcao sempre gera sequencia nova)
    * OU nao ha nenhum evento anterior, PREPARA a linha nova (equivalente ao
    * "APPEND BLANK + Replace" do legado). Quando acha um evento 'CAN'
    * existente, apenas REUSA os dados ja carregados por
    * ConsultarUltimoEvento (igual ao legado, que nesse caso NAO cria linha
    * nova).
    *
    * NAO PERSISTE NADA - e isso e fidelidade ao legado, nao omissao. O
    * "APPEND BLANK + replace ... in crSigMvNfd" do atucur mexe apenas no
    * CURSOR em memoria; quem grava e o Click do botao Enviar, que faz
    * "replace nfedesc with lcdesc in crSigMvNfd" e so entao
    * "poDataMgr.Update([crSigMvNfd]) + Commit()" (linhas 1406-1430 e
    * 1649-1660 do dump). Chamar Salvar() aqui gravaria um evento de
    * descricao vazia a CADA abertura do dialogo (inclusive quando o usuario
    * desiste e clica Cancelar) e um SEGUNDO registro no Enviar.
    *
    * O que este metodo deixa pronto e o MODO de gravacao do BO:
    * NovoRegistro() no ramo da linha nova (Salvar -> Inserir) e
    * EditarRegistro() no ramo de reuso (Salvar -> Atualizar). Quem dispara
    * a gravacao e FormSigOpNFd.BtnEnviarClick, com a descricao final ja
    * lida do controle.
    *
    * par_dDataHora equivale a "CTOT(thisform.cntData.getData.Value)" do
    * legado - o Form passa o valor atual do campo de data/hora, porque esta
    * e uma leitura de CONTROLE da tela (camada de UI), nao de cursor.
    *
    * Mesma guarda de ConsultarUltimoEvento: sem this_cNfiEmpDopNums nao ha
    * como montar um registro valido (emps/dopes/numes/nfis viriam vazios),
    * entao o metodo nao grava nada e devolve .F.
    *==========================================================================
    PROCEDURE AtualizarUltimoEvento(par_dDataHora)
        LOCAL loc_lEncontrado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        loc_lEncontrado = THIS.ConsultarUltimoEvento()
        THIS.this_nUltimaSequencia = IIF(loc_lEncontrado, THIS.this_nNfeseq + 1, 1)

        IF THIS.this_cEvento = "CAR" OR !loc_lEncontrado
            THIS.NovoRegistro()

            THIS.this_cCidchaves  = ""
            THIS.this_cDopes      = THIS.this_cNfiDopes
            THIS.this_cEmpDopNums = THIS.this_cNfiEmpDopNums
            THIS.this_cEmps       = THIS.this_cNfiEmps
            THIS.this_nNumes      = THIS.this_nNfiNumes
            THIS.this_cNfis       = THIS.this_cNfiNfis
            THIS.this_cNfedesc    = ""
            THIS.this_dNfedte     = IIF(VARTYPE(par_dDataHora) = "T", par_dDataHora, {/:})
            THIS.this_cNfeeve     = THIS.this_cEvento
            THIS.this_nNfeseq     = THIS.this_nUltimaSequencia

            loc_lSucesso = .T.
        ELSE
            *-- Legado nao faz APPEND neste ramo: REUSA a linha que o SELECT
            *-- trouxe (this_cCidchaves/this_cNfedesc/this_nNfeseq/this_cNfis
            *-- ja vieram de ConsultarUltimoEvento via CarregarDoCursor), e o
            *-- "replace nfedesc ... in crSigMvNfd" do Click vira UPDATE.
            *-- EditarRegistro deixa this_lNovoRegistro = .F., que eh o que
            *-- faz BusinessBase.Salvar() rotear para Atualizar() em vez de
            *-- Inserir().
            *--
            *-- RESET do modo ANTES de EditarRegistro: BusinessBase.
            *-- EditarRegistro() RECUSA (devolve .F. com "Nao ha registro
            *-- para editar") quando this_lNovoRegistro ainda esta .T., e
            *-- este metodo eh um FUNIL que roda VARIAS vezes na mesma vida
            *-- do form - uma abertura em 'CAR'/sem evento anterior passa
            *-- pelo ramo de cima e deixa a flag ligada, e a chamada seguinte
            *-- (Refazer desmarcado, ou o atucur do fim do Enviar) cai aqui
            *-- com ela ainda ligada. Sem o reset, o ramo de reuso falharia e
            *-- o BO continuaria em modo INSERT: o Salvar seguinte gravaria
            *-- um registro DUPLICADO onde o legado faz UPDATE.
            *--
            *-- A flag eh zerada na mao, e NAO por CancelarEdicao(): aquele
            *-- chama LimparDados() quando this_lNovoRegistro esta .T., o que
            *-- apagaria as properties que ConsultarUltimoEvento acabou de
            *-- carregar do banco, logo acima.
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = THIS.EditarRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do evento existente em SigMvNfd (nfedesc/nfexml) -
    * caminho usado depois que a SEFAZ/SAT autoriza o evento e o XML/
    * justificativa definitivos sao conhecidos.
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
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cMensagemErro = "Evento da NFe n" + CHR(227) + ;
                        "o identificado para atualiza" + CHR(231) + CHR(227) + "o."
                ELSE
                    loc_cSQL = THIS.MontarUpdateEvento()
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_cErro = CapturarErroSQL()
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                            "o do Evento da NFe." + CHR(13) + loc_cErro
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

