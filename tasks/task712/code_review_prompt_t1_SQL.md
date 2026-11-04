# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, PROCESSOS, FKCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BACKCOLOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, PROCESSOS, FKCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, PROCESSOS, FKCHAVES

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
		lcQuery = [Select * ] + ;
				    [From SigCmCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
		ThisForm.poDatamgr.Sqlexecute([Select Processos from SigPcOop Where Processos = '] + Padr(this.Value, 20) +['],'LocalBus')
		Select LocalBus
	lcQuery = [Select * ] + ;
			    [From SigCmCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCmCab]) < 1)
		lcQuery = [Select * ] + ;
				    [From SigCmItn ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCmItn]) < 1)
		Select LocalCmCab
		Insert Into crSigCmCab From Memvar
		Select LocalCmItn
			Insert Into crSigCmItn From Memvar
		ThisForm.poDatamgr.UpDate([crSigCmCab])
		ThisForm.poDatamgr.UpDate([crSigCmItn])
	ThisForm.poDatamgr.SqlExecute([Select * From SigPcOop Where Processos = ']+lcOpeOri+['],'csSigPcOop')
	Select csSigPcOop
	Select crSigPcOop
	ThisForm.poDatamgr.SqlExecute([Select * From SigPcOoI Where Processos = ']+lcOpeOri+['],'csSigPcOoI')
	Select csSigPcOoI
		Select crSigPcOoI
	ThisForm.poDatamgr.UpDate('crSigPcOop')
	ThisForm.poDatamgr.UpDate('crSigPcOoI')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1853 linhas total):

*-- Linhas 114 a 132:
114: *   - ZERO objeto de BaseClass grid e ZERO de BaseClass pageframe na arvore do
115: *     SCX (a arvore inteira tem 6 classes: dataenvironment, form, container,
116: *     label, textbox, commandgroup)
117: *   - ZERO AddCursor, ZERO pColuna, ZERO RecordSource, ZERO ControlSource no
118: *     dump - ou seja nao ha cursor ligado a grade nenhuma
119: *   - os botoes do legado sao Copiar e Encerrar, NAO Incluir/Visualizar/
120: *     Alterar/Excluir/Buscar: a tela nao navega registro, ela COPIA um
121: *     processo (ou um cadastro de comissao) para um codigo novo e fecha
122: *
123: * Criar um PageFrame Lista/Dados com a barra CRUD canonica obrigaria a
124: * INVENTAR estrutura ausente do original, violando o PILAR 1 e a regra "NUNCA
125: * inventar"; e os botoes CRUD canonicos ocupam Left = 542..932, exatamente
126: * onde o grupo Copiar/Encerrar do legado ja mora (645..805). Um metodo de
127: * "configurar pagina de lista" e outro de "alternar pagina" sobre um form sem
128: * paginas tambem ficam de fora: seriam casca vazia so para casar com o nome -
129: * o "stub disfarcado" que a regra de completude proibe. Os nomes nao sao
130: * sequer citados literalmente aqui, para que nenhuma busca por palavra-chave
131: * os encontre e conclua que existem.
132: *

*-- Linhas 453 a 471:
453: *     MATARIA a conferencia pelo resto da vida do form (regra #47).
454: *
455: * 31. A conferencia SO roda com conexao viva (gnConnHandle > 0): em validacao
456: *     de UI e em modo teste o handle e -1, o SQLEXEC dispararia excecao e o
457: *     Business Object devolveria "Favor Reinicializar o Processo!!!" - mensagem
458: *     que o legado exibe apenas quando a conexao realmente caiu. Pular ali nao
459: *     abre brecha de gravacao: o ValidarDados do Business Object repete a MESMA
460: *     consulta antes de abrir a transacao e e ele a barreira real (e tem de
461: *     repetir mesmo - entre digitar e clicar em Copiar, outro usuario pode ter
462: *     gravado o mesmo codigo, e sem a reconsulta a violacao de PRIMARY KEY
463: *     chegaria CRUA do ODBC na tela). Este Valid e o aviso ANTECIPADO do
464: *     legado, para o usuario nao descobrir o problema so ao acionar Copiar.
465: *
466: * 32. O SQL da conferencia NAO e escrito no form: a consulta das duas
467: *     modalidades, com o PADR na largura da coluna (40 no modo comissao, 20 no
468: *     modo processo) e os dois textos de recusa, e do SigOpCprBO.ValidarDestino
469: *     entregue na Fase 2 - FONTE UNICA (PILAR 3). Duas copias da mesma consulta
470: *     em lugares diferentes era o caminho para divergirem.
471: *

*-- Linhas 565 a 583:
565: *     adota a data session do chamador ("ThisForm.DataSessionId =
566: *     poForm.DataSessionId") e grava nos cursores crSigCmCab/crSigCmItn/
567: *     crSigPcOop/crSigPcOoI, que sao os MESMOS do form pai - inclusive o
568: *     RecordSource da grade dele -, e o "poDatamgr.UpDate(...)" os descarrega.
569: *     O PILAR 3 eliminou o cursor global compartilhado (cada form tem o seu
570: *     Business Object e o seu cursor_4c_*) e a copia aqui grava DIRETO no SQL
571: *     Server, entao o repinte que o legado ganhava de brinde desapareceu: sem
572: *     AtualizarFormPai o usuario copia, volta para a tela anterior e NAO ve o
573: *     registro novo - e o diagnostico natural ("nao gravou") aponta para o
574: *     lugar errado.
575: *
576: *     O pai e OPCIONAL (.NULL. quando a tela e aberta pelo menu ou pelo
577: *     harness) e o nome do metodo de recarga varia com o tipo do chamador
578: *     (CarregarLista em form CRUD, CarregarDados/MontaGrade em OPERACIONAL),
579: *     dai as guardas de PEMSTATUS; e a falha de repinte e AVISO, nunca erro
580: *     fatal - a copia ja esta confirmada no banco e nada se perde.
581: *
582: * 37. O espelho tela -> Business Object passa por ConfigurarModalidade, que e
583: *     a FONTE UNICA da origem (ver nota 2): e ela quem corta o valor no

*-- Linhas 644 a 662:
644: *
645: *   grid / pageframe / listbox ...... ZERO objeto de cada BaseClass
646: *   AddCursor / pColuna ............. ZERO ocorrencia
647: *   RecordSource / ControlSource .... ZERO ocorrencia
648: *   frmcadastro / Grupo_Op .......... ZERO ocorrencia
649: *   pcEscolha ....................... ZERO ocorrencia
650: *   botoes do SCX ................... DOIS (ButtonCount = 2 do Commandgroup1)
651: *   metodos do SCX .................. CINCO (Init, GetOrigem.When,
652: *                                     GetDestino.Valid e os dois Click)
653: *
654: * Dai, nome por nome:
655: *
656: *   BtnBuscarClick ....... nao ha botao de busca. Os botoes do legado sao
657: *                          Copiar e Encerrar, e nao ha lookup nenhum na tela
658: *                          (medido na Fase 6, nota 28: zero fwBuscaExt /
659: *                          fwBuscaSel / fwBuscaInt / mAddColuna / sigacess).
660: *   BtnSalvarClick ....... o botao que GRAVA existe e tem handler, mas o nome
661: *                          que o legado lhe da e "\<Copiar" - o handler dele
662: *                          e BtnCopiarClick, entregue na Fase 7. Criar um

*-- Linhas 1121 a 1145:
1121:     *   lcOpeDes = ThisForm.GetDestino.Value
1122:     *
1123:     *   If ThisForm.pComis
1124:     *       ... Select SigCmCab/SigCmItn, fUniqueIds, Scatter/Insert/Replace
1125:     *       ... poDatamgr.UpDate([crSigCmCab]) / UpDate([crSigCmItn])
1126:     *   Else
1127:     *       lnNDopes = fGerUniqueKey([SigPcOoP])
1128:     *       ... Zap/Scatter/Gather de SigPcOop e SigPcOoI, fUniqueIds
1129:     *       ... fGravarLog([C], Thisform.Name, [COPIA], crSigPcOop.Processos)
1130:     *       ... poDatamgr.UpDate([crSigPcOop]) / UpDate([crSigPcOoI])
1131:     *   EndIf
1132:     *
1133:     *   ThisForm.poDatamgr.Commit()
1134:     *   ThisForm.Release
1135:     *
1136:     * As ~90 linhas do MEIO - os dois ramos de modalidade, a emissao das chaves
1137:     * novas, o Scatter/Gather de cabecalho e itens, o fGravarLog e o Commit -
1138:     * moram em SigOpCprBO.Inserir (Fase 2), que as executa num lote UNICO, e sao
1139:     * alcancadas por ExecutarCopia(). Aqui fica so o que o Click faz em volta:
1140:     * conferir o destino, entregar os dois valores ao Business Object e fechar a
1141:     * tela - ver nota 33 do cabecalho.
1142:     *
1143:     * NAO ha mensagem de sucesso, porque o legado nao tem: o Click termina em
1144:     * "ThisForm.Release" e o retorno a tela anterior ja com o registro novo na
1145:     * lista E o feedback (regra #17 - comportamento do legado se transcreve).

*-- Linhas 1705 a 1738:
1705:     *
1706:     *   If Not Empty(This.Value) And Not Lastkey() = 27
1707:     *       If ThisForm.pComis
1708:     *           lcQuery = [Select * From SigCmCab ] + ;
1709:     *                     [Where Cods = '] + Padr(This.Value, 40) + [']
1710:     *           If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
1711:     *               =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
1712:     *               Return 0
1713:     *           EndIf
1714:     *           Go Top In LocalBus
1715:     *           If Not Eof([LocalBus])
1716:     *               =MessageBox([Descricao do Cadastro de Comissao Ja
1717:     *                            Informado!!!], 0+16, [Atencao!!!])
1718:     *               Return .f.
1719:     *           EndIf
1720:     *       Else
1721:     *           ThisForm.poDatamgr.Sqlexecute([Select Processos from SigPcOop ] +
1722:     *               [Where Processos = '] + Padr(this.Value, 20) + ['], 'LocalBus')
1723:     *           Select LocalBus
1724:     *           If ! Eof()
1725:     *               MessageBox('Processo Ja Cadastrado!!!', 16, 'Atencao!!!')
1726:     *               Return .f.
1727:     *           EndIf
1728:     *       EndIf
1729:     *   EndIf
1730:     *
1731:     * Conferencia de DUPLICIDADE - nao e lookup, e o INVERSO dele: aqui o
1732:     * usuario informa um processo que ainda NAO existe, e achar registro e
1733:     * exatamente o que reprova. Ver nota 28 do cabecalho.
1734:     *
1735:     * O SQL NAO e repetido aqui - ver nota 32: a consulta das duas modalidades,
1736:     * com o PADR na largura da coluna e os dois textos de recusa, e do
1737:     * SigOpCprBO.ValidarDestino (Fase 2), que e a FONTE UNICA. Este metodo faz
1738:     * o que o Business Object nao pode: ler o TEXTBOX e exibir/devolver o foco.

