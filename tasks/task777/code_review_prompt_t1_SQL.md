# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ALTCOEF
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CANCEL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ALTCOEF

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
Select CsGrade
	.Column1.ControlSource = 'CsGrade.Cpros'
	.Column2.ControlSource = 'CsGrade.Dpros'
	.Column3.ControlSource = 'CsGrade.Totas'
	.Column4.ControlSource = 'CsGrade.Coefs'
	.Column5.ControlSource = 'CsGrade.Valos'
	.Column6.ControlSource = 'CsGrade.totalG'
	.Column7.ControlSource = 'CsGrade.Acumulas'
SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
Select CsGrade

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPcu.prg) - TRECHOS RELEVANTES PARA PASS SQL (1347 linhas total):

*-- Linhas 16 a 43:
16: *   DataSession dele - este dialogo apenas entra naquela DataSession
17: *   ("SET DATASESSION TO" no Init) e edita o mesmo cursor em memoria.
18: *   Consequencias de projeto:
19: *     - o bind (RecordSource + ControlSource) NAO pode acontecer em tempo de
20: *       construcao: o alias pode nem existir quando a tela se monta, e
21: *       Column.ControlSource de alias inexistente estoura "Alias is not found"
22: *       DENTRO do TRY de InicializarForm, matando a tela inteira (regra #41).
23: *       Por isso ConfigurarGrade() carrega SO o que nao depende de dado e o
24: *       bind mora em VincularGrade(), condicionado a USED(alias);
25: *     - Destroy NAO fecha csGrade: o cursor eh do chamador, que continua
26: *       precisando dele depois deste dialogo fechar. MEDIDO no dump do pai
27: *       (tasks/task003/sigcdpro_form_codigo_fonte.txt:20840): quem alimenta
28: *       o "Insert Into CrSigPrFtp" eh o SCAN do PROPRIO csGrade por
29: *       AltCoef = 1 - nao o crPrFtp que esta tela monta.
30: *
31: * Fase 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: ja entregues, e a ausencia dos
32: * quatro nomes CRUD foi MEDIDA no dump, nao presumida.
33: *
34: *   (a) O QUE O LEGADO TEM DE BOTAO - exatamente UM. Contado no dump
35: *       (tasks\task777\SigOpPcu_form_codigo_fonte.txt): 1 objeto com
36: *       "BaseClass: commandbutton" (cmdSair, classe fwbtng) e ZERO objeto com
37: *       "BaseClass: commandgroup". O dump declara 12 metodos com codigo
38: *       (rodape confirma), e um unico "PROCEDURE Click" - o do proprio
39: *       cmdSair.
40: *
41: *   (b) O QUE O LEGADO NAO TEM - zero evidencia de CRUD, nas tres vias
42: *       independentes, medidas sobre o mesmo dump:
43: *

*-- Linhas 102 a 132:
102: *   Btn<Salvar>Click e os   - nao ha o que GRAVAR aqui. Esta tela nao escreve em
103: *   irmaos Confirmar/       tabela nenhuma: as unicas escritas do dump sao
104: *   Gravar/Processa         REPLACE no cursor csGrade, que eh do CHAMADOR, e o
105: *                           "Select ... Into Cursor crPrFtp" do cmdSair. Quem
106: *                           persiste em sigprftp eh o form PAI, DEPOIS de ler
107: *                           crPrFtp. Criar um botao de gravar aqui inventaria
108: *                           superficie que o usuario do legado nunca teve.
109: *   FormPara<BO>            - sentido CAMPO -> BO. A unica celula digitavel
110: *                           (Column4, o coeficiente) escreve DIRETO no cursor
111: *                           csGrade pelo ControlSource, e o valor novo chega ao
112: *                           BO como ARGUMENTO de RecalcularCoeficiente(), nao
113: *                           por mapeamento generico de campos. O unico controle
114: *                           de dados fora da grade (txt_4c_Adicional) eh
115: *                           ReadOnly no proprio dump - nunca ha o que ler dele.
116: *   <BO>ParaForm            - sentido BO -> CAMPO. A grade le o cursor DIRETO
117: *                           (RecordSource + sete ControlSource, ver
118: *                           VincularGrade) e o unico campo que o codigo
119: *                           escreve eh o total do rodape, espelhado por
120: *                           AtualizarTotalAdicional() a partir de
121: *                           this_nTotalAdicional - fonte unica, no BO.
122: *   Carregar<Lista>         - a carga da grade EXISTE e eh obrigatoria; o que
123: *                           nao existe eh o NOME canonico de uma lista CRUD
124: *                           independente. Aqui ela eh o funil CarregarDados(),
125: *                           que reproduz o bloco final do Init legado
126: *                           (Set Key To / Sum Valos / Goto Top / bind /
127: *                           Refresh) e eh chamado em TODO caminho que mexe no
128: *                           cursor ou na chave. Manter o nome CarregarDados eh
129: *                           deliberado: TesteAutomatico.prg classifica como
130: *                           OPERACIONAL justamente o form que NAO tem
131: *                           Carregar<Lista> nem AlternarPagina, e batizar o funil
132: *                           com o nome CRUD jogaria esta tela no caminho de

*-- Linhas 393 a 436:
393:     *     grdGrade: Top=130 Left=5 Width=989 Height=442, ColumnCount=7,
394:     *               FontName="Tahoma" FontSize=8, HeaderHeight=16,
395:     *               RowHeight=16, ScrollBars=2, ReadOnly=.F.,
396:     *               DeleteMark=.F., AllowHeaderSizing=.T.,
397:     *               AllowRowSizing=.T., GridLineColor=(238,238,238)
398:     *     Column1 "Codigo"     Width=120  (csGrade.Cpros)
399:     *     Column2 "Descricao"  Width=280  (csGrade.Dpros)
400:     *     Column3 "Total (a)"  Width=90   InputMask="999,999.999"
401:     *     Column4 "Coef./(%)"  Width=73   InputMask="999.9999"   <- EDITAVEL
402:     *     Column5 "Valor (b)"  Width=90   InputMask="999,999.999"
403:     *     Column6 "Total (a+b)" Width=90  InputMask="999,999.999"
404:     *     Column7 "Acumulado"  Width=100  InputMask="99,999,999.999"
405:     *
406:     * Tres propriedades do dump NAO sao transcritas, de proposito:
407:     *   - ZOrderSet = 20: nao existe em runtime em classe nenhuma, eh
408:     *     bookkeeping do Form Designer gravado no SCX (regra #33);
409:     *   - TabIndex = 18: TabIndex fora da faixa 1..N eh descartado em
410:     *     silencio, entao a ordem de tabulacao so pode ser numerada depois do
411:     *     ULTIMO AddObject da tela, num metodo proprio;
412:     *   - Column3.ColumnOrder = 3: ja eh a posicao natural da coluna, logo
413:     *     atribui-la eh inerte e so arrisca reordenar a grade.
414:     *
415:     * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh regra do
416:     * projeto para Grid criado por AddObject em form OPERACIONAL (sem isso
417:     * aparece a barra de marcacao lateral que o legado nao tem).
418:     *
419:     * AQUI ficam SO as propriedades que NAO dependem de dado (regra #41):
420:     * geometria, ColumnCount, Movable/Resizable, fontes, cores e InputMask. O
421:     * bind - RecordSource, os sete ControlSource, as larguras, os
422:     * Header1.Caption e o DynamicForeColor - mora em VincularGrade(), porque
423:     * o alias eh do form CHAMADOR (ver "CONTRATO EXTERNO" no cabecalho) e
424:     * porque atribuir RecordSource RESETA Column.Width e Header1.Caption -
425:     * esses dois tem de ser reaplicados DEPOIS do bind, nunca antes.
426:     *
427:     * O ReadOnly = .F. de cada coluna eh o valor literal do dump; a trava de
428:     * verdade das colunas que o usuario nao digita vem do "When" delas (todas
429:     * fazem "RETURN .F.", menos a Column4) e eh aplicada por
430:     * AplicarTravasDeColuna(), chamado no fim de VincularGrade.
431:     *==========================================================================
432:     PROTECTED PROCEDURE ConfigurarGrade()
433:         LOCAL loc_oCnt
434: 
435:         loc_oCnt = THIS.cnt_4c__Planilha
436:         loc_oCnt.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 445 a 463:
445:             .RowHeight         = 16
446:             .ScrollBars        = 2
447:             .ReadOnly          = .F.
448:             .DeleteMark        = .F.
449:             .RecordMark        = .F.
450:             .AllowHeaderSizing = .T.
451:             .AllowRowSizing    = .T.
452:             .FontName          = "Tahoma"
453:             .FontSize          = 8
454:             .GridLineColor     = RGB(238, 238, 238)
455:             .Visible           = .T.
456:         ENDWITH
457: 
458:         *-- Column1 - "Codigo" (csGrade.Cpros). Sem InputMask no dump.
459:         WITH loc_oCnt.grd_4c_Dados.Column1
460:             .FontName           = "Tahoma"
461:             .FontSize           = 8
462:             .Movable            = .F.
463:             .Resizable          = .F.

*-- Linhas 626 a 665:
626:     *
627:     *     With Thisform.Cnt_Planilha.GrdGrade
628:     *         .RecordSource          = 'CsGrade'
629:     *         .Column1.ControlSource = 'CsGrade.Cpros'
630:     *         .Column2.ControlSource = 'CsGrade.Dpros'
631:     *         .Column3.ControlSource = 'CsGrade.Totas'
632:     *         .Column4.ControlSource = 'CsGrade.Coefs'
633:     *         .Column5.ControlSource = 'CsGrade.Valos'
634:     *         .Column6.ControlSource = 'CsGrade.totalG'
635:     *         .Column7.ControlSource = 'CsGrade.Acumulas'
636:     *     EndWith
637:     *     SetAll('DynamicForeColor',
638:     *            'Iif(csGrade.AltCoef=1, RGB(255,0,0), RGB(0,0,0))', 'Column')
639:     *
640:     * O DynamicForeColor eh o que pinta de VERMELHO a linha cujo coeficiente
641:     * foi alterado (AltCoef = 1) - eh o unico sinal visual que o usuario tem
642:     * de quais linhas vao ser gravadas pelo form pai, entao nao eh enfeite.
643:     *
644:     * O bind inteiro eh CONDICIONADO a USED(alias): o cursor eh do chamador
645:     * (ver "CONTRATO EXTERNO" no cabecalho) e pode nao estar aberto - no
646:     * harness de teste nunca esta. Column.ControlSource de alias inexistente
647:     * estoura "Alias is not found" e derrubaria o Init (regra #41).
648:     *
649:     * ORDEM OBRIGATORIA (regra #41 / Problema 48): ColumnCount -> RecordSource
650:     * -> ControlSource -> Width -> Header1.Caption. Atribuir RecordSource
651:     * RESETA Column.Width (para o default) e Header1.Caption (para "Column1"
652:     * ...), logo esses dois vem DEPOIS do bind - e vem SEMPRE, inclusive com o
653:     * alias fechado, para a grade nunca aparecer com cabecalho generico e
654:     * largura errada.
655:     *
656:     * ColumnCount = 7 antes do RecordSource eh obrigatorio: sem ele o VFP
657:     * expande a grade para TODAS as colunas do cursor (csGrade tem 13) e
658:     * duplica cabecalhos. Reatribuir o MESMO valor eh inofensivo - medido no
659:     * VFP9: so REDUZIR ColumnCount destroi o que foi posto nas Columns.
660:     *==========================================================================
661:     PROTECTED PROCEDURE VincularGrade()
662:         LOCAL loc_cAlias, loc_oGrade
663: 
664:         loc_cAlias = ""
665:         IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 671 a 699:
671:         *-- 1. ColumnCount ANTES do RecordSource
672:         loc_oGrade.ColumnCount = 7
673: 
674:         *-- 2. RecordSource + ControlSource - SO com o cursor do chamador aberto
675:         IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
676:             loc_oGrade.RecordSource = loc_cAlias
677: 
678:             loc_oGrade.Column1.ControlSource = loc_cAlias + ".Cpros"
679:             loc_oGrade.Column2.ControlSource = loc_cAlias + ".Dpros"
680:             loc_oGrade.Column3.ControlSource = loc_cAlias + ".Totas"
681:             loc_oGrade.Column4.ControlSource = loc_cAlias + ".Coefs"
682:             loc_oGrade.Column5.ControlSource = loc_cAlias + ".Valos"
683:             loc_oGrade.Column6.ControlSource = loc_cAlias + ".totalG"
684:             loc_oGrade.Column7.ControlSource = loc_cAlias + ".Acumulas"
685: 
686:             *-- Linha vermelha para coeficiente alterado (AltCoef = 1). A
687:             *-- expressao eh avaliada a cada repintura, entao so pode ser
688:             *-- instalada com o alias aberto.
689:             loc_oGrade.SetAll("DynamicForeColor", ;
690:                 "IIF(" + loc_cAlias + ".AltCoef = 1, RGB(255,0,0), RGB(0,0,0))", ;
691:                 "Column")
692:         ENDIF
693: 
694:         *-- 3. Width DEPOIS do bind (o bind acima zera as larguras)
695:         loc_oGrade.Column1.Width = 120
696:         loc_oGrade.Column2.Width = 280
697:         loc_oGrade.Column3.Width = 90
698:         loc_oGrade.Column4.Width = 73
699:         loc_oGrade.Column5.Width = 90

*-- Linhas 841 a 859:
841:     *
842:     * Reproduz, na MESMA ordem, o que o Init legado faz com os dados:
843:     *
844:     *     Select CsGrade
845:     *     Set Key To pTipo        && filtra a planilha pelo tipo recebido
846:     *     Sum Valos to _TTA       && total adicional exibido no rodape
847:     *     Goto Top
848:     *     ... bind da grade ...
849:     *     .Refresh
850:     *
851:     * O "Set Key To" FILTRA a visao do cursor - eh assim que a tela mostra so
852:     * as linhas da planilha de Fator OU de Venda, e nao a composicao inteira -
853:     * e trocar ordem/chave de um alias NAO repinta a grade ligada a ele. Sem o
854:     * Refresh do fim a grade continua desenhando o conteudo de antes do
855:     * filtro, sem erro e sem log, so com dado errado na tela (regra #21).
856:     *
857:     * Por que FUNIL: a carga tem de rodar INTEIRA em todo caminho que mexa no
858:     * cursor ou na chave - a abertura, aqui, e o recalculo do coeficiente
859:     * (Column4.Valid do legado, que faz "Replace ... In csGrade" e volta a

*-- Linhas 882 a 900:
882:             *--    reaplica largura, cabecalho e travas sempre).
883:             THIS.VincularGrade()
884: 
885:             *-- 2. "Select CsGrade / Set Key To pTipo / Sum Valos / Goto Top"
886:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
887:                 loc_lSucesso = THIS.this_oBusinessObject.FiltrarGrade(THIS.this_cTipo)
888:             ENDIF
889: 
890:             *-- 3. O "Get_Adicional.Value = _tta" do Init legado: espelha no
891:             *--    rodape o total que o passo 2 somou. Fica DENTRO do funil -
892:             *--    o passo 2 recalcula o total em toda carga, e sem isto o
893:             *--    campo exibiria 0 (ou o total anterior) para sempre.
894:             THIS.AtualizarTotalAdicional()
895: 
896:             *-- 4. O ".Refresh" do Init legado. Sem ele a grade nao mostra o
897:             *--    efeito do SET KEY aplicado no passo 2 (regra #21).
898:             THIS.Refresh()
899:             THIS.cnt_4c__Planilha.grd_4c_Dados.Refresh()
900:         CATCH TO loc_oErro

*-- Linhas 951 a 969:
951:     * codigo (AtualizarTotalAdicional), nunca da digitacao. NAO se acrescenta
952:     * TabStop = .F. - o legado nao tem "When -> RETURN .F." neste campo (so
953:     * nas colunas da grade), entao ele continua no ciclo do Tab, como no
954:     * original. E nao ha ControlSource porque o legado tambem nao tem: o Init
955:     * dele faz "Sum Valos to _TTA" e atribui "Get_Adicional.Value = _tta".
956:     *==========================================================================
957:     PROTECTED PROCEDURE ConfigurarPaginaDados()
958:         LOCAL loc_oCnt
959: 
960:         loc_oCnt = THIS.cnt_4c__Planilha
961: 
962:         *-- Subtitulo da planilha (legado: Label1). O Caption definitivo, com
963:         *-- o tipo entre parenteses, eh posto por AtualizarTitulos.
964:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
965:         WITH loc_oCnt.lbl_4c_Label1
966:             .Top       = 96
967:             .Left      = 67
968:             .Width     = 864
969:             .Height    = 21

*-- Linhas 1246 a 1265:
1246:     *==========================================================================
1247:     * FecharDialogo - funil unico de saida, transcrito do cmdSair.Click legado:
1248:     *
1249:     *     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
1250:     *     Select CsGrade
1251:     *     Set Key To
1252:     *     If (Type([ThisForm.ParentForm])=[O])
1253:     *         Thisform.ParentForm.Enabled = .T.
1254:     *     EndIf
1255:     *     Release lnCoef, pcTipo
1256:     *     ThisForm.Release
1257:     *
1258:     * As duas primeiras partes (montar crPrFtp com as linhas alteradas e
1259:     * DESFAZER o "Set Key To" aplicado na carga) sao dados e moram no BO, em
1260:     * MontarCursorAlterados(). Esse cursor eh o entregavel da tela, e o papel
1261:     * dele no pai foi MEDIDO no dump, nao presumido: a PERSISTENCIA em
1262:     * sigprftp sai do SCAN do proprio csGrade por AltCoef = 1
1263:     * (sigcdpro_form_codigo_fonte.txt:20840); crPrFtp eh lido quando o pai
1264:     * REMONTA a composicao, para reaplicar Coefs/cidchaves sobre as linhas
1265:     * correspondentes (linhas 14706-14715). Por isso ele tem de ser montado


### BO (C:\4c\projeto\app\classes\SigOpPcuBO.prg):
*====================================================================
* SigOpPcuBO.prg
*
* Business Object para SigOpPcu - Planilha de Custo
* Herda de: BusinessBase
*
* ORIGEM LEGADO: SigOpPcu.SCX (dialogo modal filho)
*   Chamado por SIGCDPRO (Cadastro de Produto), aba Composicao:
*     chkPlanCus.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [C]
*     chkPlanVen.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [V]
*   Parametros do Init legado: poForm (form pai), pnDataSes (DataSession
*   do pai), pTipo ("C" = planilha de Fator/Custo, "V" = planilha de Venda).
*
* NATUREZA DA TELA (importante para entender este BO):
*   A planilha opera sobre o CURSOR LOCAL "csGrade", que pertence ao form
*   PAI (SIGCDPRO) e vive na DataSession DELE - o dialogo faz
*   "Set DataSession to pnDataSes" e edita o mesmo cursor em memoria.
*   Estrutura do cursor, transcrita do Load do SIGCDPRO:
*     Create Cursor CsGrade (Tipos c(1), Ordem n(3), Cpros c(14),
*            Dpros c(30), Totas n(12,3), Coefs n(8,4), Valos n(12,3),
*            TotalG n(12,3), Acumulas n(12,3), cGrus c(3), cods c(2),
*            CidChaves c(20), AltCoef n(1,0))
*     Index On Tipos + Str(Ordem,3) + Cpros Tag Ordem
*   O dialogo filtra as linhas do tipo recebido com "Set Key To pTipo"
*   sobre essa TAG e permite editar apenas a coluna Coefs (Coef./(%)),
*   recalculando Valos / TotalG / Acumulas e o total adicional.
*
* PERSISTENCIA: este dialogo NAO grava em tabela nenhuma. Quem persiste
*   eh o form PAI, no Salvar dele, lendo as linhas marcadas pelo dialogo:
*     SELECT csGrade / SCAN / IF altcoef = 1
*         Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves)
*             Values (csGrade.cgrus, csGrade.cods, csGrade.coefs,
*                     crSigcdPro.cpros,
*                     IIF(EMPTY(csGrade.CidChaves), fUniqueIds(),
*                         csGrade.CidChaves))
*   Por isso o contrato de saida do dialogo sao as DUAS marcas que ele
*   grava na linha editada (AltCoef = 1 e CidChaves = fUniqueIds()) mais
*   o cursor crPrFtp que o botao Encerrar monta com as linhas alteradas:
*     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
*   O comportamento padrao herdado de BusinessBase para Inserir() /
*   Atualizar() / ExecutarExclusao() (recusar a operacao e reportar pelo
*   ExibirFalha do Salvar) ja eh o correto para esta tela.
*
* TABELA DE REFERENCIA (PILAR 2 - nomes EXATOS do schema):
*   sigprftp  - destino final do coeficiente alterado (gravado pelo pai)
*               cgrus char(3), cods char(2), coefs numeric(6,4),
*               cpros char(14), pkchaves char(20), valors numeric(10,2)
*   SigPrFto  - origem das linhas da planilha montadas pelo pai
*               cidchaves char(20), coefs numeric(7,4), cpros char(14)
*====================================================================

DEFINE CLASS SigOpPcuBO AS BusinessBase

    *----------------------------------------------------------------
    * PARAMETROS DE ABERTURA (legado: LParameters poForm, pnDataSes, pTipo)
    *----------------------------------------------------------------
    this_cTipo              = "C"    && pTipo: "C" = Fator (custo), "V" = Venda
    this_nDataSessionPai    = 0      && pnDataSes - DataSession do form pai

    *----------------------------------------------------------------
    * CURSORES COMPARTILHADOS COM O FORM PAI
    * Os nomes sao os do legado de proposito: estes cursores NAO sao
    * criados aqui, eles pertencem a DataSession do form pai e os nomes
    * sao o CONTRATO entre as duas telas (mesma pratica de FormFti,
    * que tambem preserva "csGrade").
    *----------------------------------------------------------------
    this_cCursorGrade       = "csGrade"      && linhas da planilha (cursor do pai)
    this_cCursorProduto     = "CrSigCdPro"   && produto em edicao no pai (Cpros/Dpros)
    this_cCursorAlterados   = "crPrFtp"      && saida: linhas com AltCoef = 1
    this_cTagOrdem          = "Ordem"        && TAG Tipos + Str(Ordem,3) + Cpros

    *----------------------------------------------------------------
    * LINHA DA PLANILHA (colunas do cursor csGrade)
    * Tipo e tamanho transcritos do Create Cursor do SIGCDPRO.
    *----------------------------------------------------------------
    this_cTipos             = ""     && Tipos     c(1)      - "C" ou "V"
    this_nOrdem             = 0      && Ordem     n(3,0)    - sequencia da linha
    this_cCpros             = ""     && Cpros     c(14)     - codigo (coluna "Codigo")
    this_cDpros             = ""     && Dpros     c(30)     - descricao (coluna "Descricao")
    this_nTotas             = 0      && Totas     n(12,3)   - coluna "Total (a)"
    this_nCoefs             = 0      && Coefs     n(8,4)    - coluna "Coef. / (%)" (EDITAVEL)
    this_nValos             = 0      && Valos     n(12,3)   - coluna "Valor (b)"
    this_nTotalG            = 0      && TotalG    n(12,3)   - coluna "Total (a+b)"
    this_nAcumulas          = 0      && Acumulas  n(12,3)   - coluna "Acumulado"
    this_cCgrus             = ""     && cGrus     c(3)      - grupo (-> sigprftp.cgrus)
    this_cCods              = ""     && cods      c(2)      - feitio (-> sigprftp.cods)
    this_cCidChaves         = ""     && CidChaves c(20)     - PK (-> sigprftp.pkchaves)
    this_nAltCoef           = 0      && AltCoef   n(1,0)    - 1 = coeficiente alterado

    *----------------------------------------------------------------
    * CABECALHO DA TELA
    * Legado: ThisForm.Caption = CrSigCdPro.Cpros + " - " + CrSigCdPro.Dpros
    *         Label1 = "Planilha de Custo (" + Iif(pTipo="C","Fator","Venda") + ")"
    *----------------------------------------------------------------
    this_cCodigoProduto     = ""     && CrSigCdPro.Cpros c(14)
    this_cDescricaoProduto  = ""     && CrSigCdPro.Dpros c(30)

    *----------------------------------------------------------------
    * ESTADO DE CALCULO
    * this_nTotalAdicional eh o _TTA do legado (Sum Valos), exibido no
    * TextBox Get_Adicional, e eh recalculado a cada edicao de Coefs.
    * this_nCoefAnterior eh o lnCoef que o legado guardava no GotFocus
    * da celula para descobrir se o coeficiente mudou de fato - so nesse
    * caso a linha recebe AltCoef = 1 e CidChaves nova.
    *----------------------------------------------------------------
    this_nTotalAdicional    = 0      && _TTA - soma de Valos do tipo corrente
    this_nCoefAnterior      = 0      && lnCoef - valor de Coefs ao entrar na celula

    *----------------------------------------------------------------
    * CONTROLE DE ACESSO
    * Legado (When da Column4): Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * Ou seja: a coluna do coeficiente so eh editavel com acesso ao
    * cadastro de Feitios E na planilha de VENDA. O default .T. acompanha
    * o fChecaAcesso portado (utils\functions.prg), que libera o acesso;
    * o valor eh reavaliado por fChecaAcesso na carga da planilha.
    *----------------------------------------------------------------
    this_lAcessoFeitio      = .T.    && fChecaAcesso("SIGCDFTI")

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * Nao recebe parametro obrigatorio: o harness de teste instancia com
    * CREATEOBJECT("SigOpPcuBO") sem argumento, e Init que devolve .F.
    * mata o form. O tipo da planilha ("C"/"V") e a DataSession do pai
    * sao atribuidos pelo form depois da instanciacao.
    *
    * this_cTabela / this_cCampoChave apontam para sigprftp / pkchaves,
    * que eh onde o coeficiente editado aqui termina gravado pelo form
    * pai (nomes EXATOS do schema - PILAR 2).
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprftp"
            THIS.this_cCampoChave = "pkchaves"

            *-- Estado inicial da planilha (equivalente ao Init legado
            *-- antes de "Set Key To pTipo" / "Sum Valos to _TTA")
            THIS.this_cTipo             = "C"
            THIS.this_nDataSessionPai   = 0
            THIS.this_nTotalAdicional   = 0
            THIS.this_nCoefAnterior     = 0
            THIS.this_lAcessoFeitio     = .T.

            THIS.this_cCodigoProduto    = ""
            THIS.this_cDescricaoProduto = ""

            THIS.this_cTipos      = ""
            THIS.this_nOrdem      = 0
            THIS.this_cCpros      = ""
            THIS.this_cDpros      = ""
            THIS.this_nTotas      = 0
            THIS.this_nCoefs      = 0
            THIS.this_nValos      = 0
            THIS.this_nTotalG     = 0
            THIS.this_nAcumulas   = 0
            THIS.this_cCgrus      = ""
            THIS.this_cCods       = ""
            THIS.this_cCidChaves  = ""
            THIS.this_nAltCoef    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SigOpPcuBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta linha a partir do
    * registro CORRENTE do cursor recebido (este dialogo nao usa SQLEXEC:
    * a "fonte de dados" eh o cursor local csGrade, compartilhado com o
    * form pai - ver cabecalho do arquivo).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cTipos     = TratarNulo(Tipos, "C")
            THIS.this_nOrdem     = TratarNulo(Ordem, "N")
            THIS.this_cCpros     = TratarNulo(Cpros, "C")
            THIS.this_cDpros     = TratarNulo(Dpros, "C")
            THIS.this_nTotas     = TratarNulo(Totas, "N")
            THIS.this_nCoefs     = TratarNulo(Coefs, "N")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_nTotalG    = TratarNulo(TotalG, "N")
            THIS.this_nAcumulas  = TratarNulo(Acumulas, "N")
            THIS.this_cCgrus     = TratarNulo(cGrus, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_nAltCoef   = TratarNulo(AltCoef, "N")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave desta linha no destino final (sigprftp.
    * pkchaves = csGrade.CidChaves). Mantido por consistencia com
    * BusinessBase; este dialogo NAO chama Salvar()/Excluir() (ver nota
    * de PERSISTENCIA no cabecalho do arquivo e Init() acima) - quem
    * grava em sigprftp eh o form PAI (SIGCDPRO), varrendo o proprio
    * csGrade pelas linhas com AltCoef = 1 que esta tela marcou.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN EscaparSQL(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * FiltrarGrade - Replica "Select CsGrade / Set Key To pTipo" do Init
    * legado: restringe o cursor compartilhado csGrade as linhas do tipo
    * recebido ("C" = Fator/Custo, "V" = Venda, Column4.When) e recalcula
    * o total adicional (_TTA do legado / TextBox Get_Adicional) somando
    * Valos das linhas visiveis.
    *
    * O "Set Key To pTipo" do legado NAO pode ser transcrito ao pe da letra
    * aqui - e o motivo nao se ve lendo o codigo, so MEDINDO. O TAG "Ordem"
    * do csGrade eh COMPOSTO ("Index On Tipos + Str(Ordem,3) + Cpros", dump
    * do SIGCDPRO), isto eh uma chave de 18 caracteres, e "V" eh um valor
    * PARCIAL dela. Medido no VFP9 em 2026-11-11 (automation\
    * MedirSetKeyRange777.prg, mesmo cursor e mesmo TAG):
    *
    *     SET EXACT OFF + SET KEY TO "V"                  -> 3 linhas
    *     SET EXACT ON  + SET KEY TO "V"                  -> 0 LINHAS
    *     SET EXACT ON  + SET KEY TO RANGE "V", "V"+CHR(255)...  -> 3 linhas
    *
    * E o projeto roda com EXACT ON: start\config.prg:242 faz "SET EXACT ON"
    * no nivel de cima, ao contrario do ambiente Fortyus. Transcrito
    * literalmente, portanto, o filtro casa ZERO linha e a planilha abre
    * VAZIA - sem erro, sem log e sem excecao, que eh o sintoma que manda o
    * diagnostico para o cursor ou para o form pai (a mesma familia da regra
    * #21 e da licao "INDEX composto + SEEK parcial com EXACT ON").
    *
    * SET KEY TO RANGE eh a forma que nao depende do SET EXACT: o limite
    * inferior eh o proprio tipo e o superior eh o tipo seguido de CHR(255),
    * que ordena acima de qualquer sufixo possivel da chave. Medido no mesmo
    * script: "V" -> 3, "C" -> 2, tipo inexistente -> 0, e o SUM Valos passa
    * a somar so as visiveis (250.000 contra 380.000 sem filtro). O sufixo
    * eh FOLGADO de proposito (250 chars, contra os 17 que faltariam para
    * completar a chave): limite superior maior que a chave foi medido e
    * funciona, e assim o codigo nao fica amarrado a largura exata do TAG,
    * que pertence ao form PAI e pode mudar la.
    *
    * NAO se usa "salvar e restaurar SET EXACT" no lugar disto: o SET eh
    * global, valeria para tudo que rodasse entre as duas linhas, e deixaria
    * o comportamento da tela dependendo de um estado de ambiente.
    *
    * Tipo vazio = sem filtro (o legado tambem limpa o filtro com
    * "Set Key To" sem argumento, em MontarCursorAlterados).
    *====================================================================
    PROCEDURE FiltrarGrade(par_cTipo)
        LOCAL loc_lSucesso, loc_nTotalAdicional, loc_cTipo
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            THIS.this_cTipo = par_cTipo
            loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", ALLTRIM(par_cTipo), "")

            SELECT (THIS.this_cCursorGrade)
            SET ORDER TO TAG (THIS.this_cTagOrdem)
            IF EMPTY(loc_cTipo)
                SET KEY TO
            ELSE
                SET KEY TO RANGE loc_cTipo, loc_cTipo + REPLICATE(CHR(255), 250)
            ENDIF
            GO TOP IN (THIS.this_cCursorGrade)

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO TOP IN (THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarAcessoCoeficiente - Replica Column4.When do legado:
    *   Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * A celula do coeficiente so eh editavel com acesso ao cadastro de
    * Feitios (SIGCDFTI) E na planilha de VENDA. Chamado pelo Form no
    * When/InteractiveChange da coluna de Coefs.
    *====================================================================
    PROCEDURE VerificarAcessoCoeficiente()
        THIS.this_lAcessoFeitio = (fChecaAcesso("SIGCDFTI") AND (THIS.this_cTipo == "V"))
        RETURN THIS.this_lAcessoFeitio
    ENDPROC

    *====================================================================
    * ArmazenarCoefAnterior - Replica Column4.GotFocus do legado
    * ("PUBLIC lnCoef / lnCoef = this.Value"): guarda o valor do
    * coeficiente ANTES da edicao, para THIS.RecalcularCoeficiente()
    * decidir se a linha deve ser marcada como alterada.
    *====================================================================
    PROCEDURE ArmazenarCoefAnterior(par_nCoefAtual)
        THIS.this_nCoefAnterior = TratarNulo(par_nCoefAtual, 0)
    ENDPROC

    *====================================================================
    * RecalcularCoeficiente - Replica Column4.Valid do legado (formula
    * transcrita LITERALMENTE, sem reescrever - regra de negocio):
    *   IF this.Value <> lnCoef
    *       replace altcoef with 1 in csGrade
    *       replace cidChaves with fUniqueIds() in csGrade
    *   ENDIF
    *   replace valos with Round((( totas * coefs ) - totas ),3) in csGrade
    *   replace totalg with totas + valos in csGrade
    *   GO top / SCAN / replace acumulas with lnVr + valos + totas / lnVr = acumulas
    *   Sum Valos to lnVr -> Get_Adicional.Value
    *
    * par_nNovoCoef - valor novo da celula (TextBox.Value no legado),
    * aplicado ao registro CORRENTE do cursor csGrade.
    *====================================================================
    PROCEDURE RecalcularCoeficiente(par_nNovoCoef)
        LOCAL loc_lSucesso, loc_nRegistroAtual, loc_nAcumulado, loc_nTotalAdicional
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade) AND !EOF(THIS.this_cCursorGrade)
            SELECT (THIS.this_cCursorGrade)

            IF par_nNovoCoef <> THIS.this_nCoefAnterior
                REPLACE AltCoef WITH 1 IN (THIS.this_cCursorGrade)
                REPLACE CidChaves WITH fUniqueIds() IN (THIS.this_cCursorGrade)
            ENDIF

            loc_nRegistroAtual = RECNO(THIS.this_cCursorGrade)

            REPLACE Coefs WITH par_nNovoCoef IN (THIS.this_cCursorGrade)
            REPLACE Valos WITH ROUND(((Totas * Coefs) - Totas), 3) IN (THIS.this_cCursorGrade)
            REPLACE TotalG WITH Totas + Valos IN (THIS.this_cCursorGrade)

            GO TOP IN (THIS.this_cCursorGrade)
            loc_nAcumulado = 0
            SCAN
                REPLACE Acumulas WITH loc_nAcumulado + Valos + Totas IN (THIS.this_cCursorGrade)
                loc_nAcumulado = Acumulas
            ENDSCAN

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO RECORD loc_nRegistroAtual IN (THIS.this_cCursorGrade)
            THIS.CarregarDoCursor(THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorAlterados - Replica a parte de dados do cmdSair.Click
    * do legado:
    *   SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
    *   Select CsGrade / Set Key To
    * (o restante do Click - ThisForm.ParentForm.Enabled = .T. e
    * ThisForm.Release - eh responsabilidade do Form, nao do BO). Chamado
    * pelo botao Encerrar antes de fechar o dialogo. MEDIDO no dump do pai:
    * o form PAI (SIGCDPRO) grava sigprftp a partir do SCAN do PROPRIO
    * csGrade por AltCoef = 1 (sigcdpro_form_codigo_fonte.txt:20840), e le
    * this_cCursorAlterados (crPrFtp) quando REMONTA a composicao, para
    * reaplicar Coefs/cidchaves (linhas 14706-14715).
    *====================================================================
    PROCEDURE MontarCursorAlterados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            IF USED(THIS.this_cCursorAlterados)
                USE IN (THIS.this_cCursorAlterados)
            ENDIF

            SELECT * FROM (THIS.this_cCursorGrade) WHERE AltCoef = 1 ;
                INTO CURSOR (THIS.this_cCursorAlterados) READWRITE

            SELECT (THIS.this_cCursorGrade)
            SET KEY TO

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

