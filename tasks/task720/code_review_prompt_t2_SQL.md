# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CHKOBRIG, CCARS, EMPDOPNUMS, CPROS, NTIPOS, CGRUS, CTITS

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
Select crSigMvFtc
Select LocalFtc 
Select Distinct cCars, Desccars From LocalFtc Where chkobrig = 1 Into Cursor CarsObrigs ReadWrite 
Select CarsObrigs
	Select crSigMvFtc
	Select CarsObrigs
	Delete From crSigMvFtc where Empty(CCars)
This.Grade.Column1.ControlSource = []
This.Grade.Column2.ControlSource = []
This.Grade.Column3.ControlSource = []
	lcQuery = [Select * from SigMvFtc where EmpDopNums = ']+ThisForm.pcEDN+[' And Cpros = ']+crProduto.Cpros+['] 
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvFtc]) < 1)
Select crSigMvFtc
lcQuery = [Select a.ccars, b.descrs as Desccars, a.cgrus as Dopes,a.ctits, b.chkobrig, b.cgrus, c.descrs, a.cselecaos, space(20) as Resps ] + ;
		[from SigCdFtc a ] + ;
		[join SigCrRap b on a.ccars = b.codigos ] + ;
		[join SigPrCpP c on a.ctits = c.codigos ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFtc]) < 1)
Select LocalFtc
Select crSigMvFtc
This.Grade.Column1.ControlSource = [crSigMvFtc.ccars]
This.Grade.Column2.ControlSource = [crSigMvFtc.ctits]
This.Grade.Column3.ControlSource = [crSigMvFtc.Resps]
Select LocalFtc
Select Distinct cCars, Desccars From LocalFtc Where chkobrig = 1 Into Cursor CarsObrigs ReadWrite 
Select CarsObrigs
	Select crSigMvFtc
		Insert Into crSigMvFtc (EmpDopNums, Cpros, cIdChaves, cCars) Values (ThisForm.pcEdn, ThisForm.pcPro, fUniqueIds(), CarsObrigs.cCars)
	Select CarsObrigs
Select crSigMvFtc
	Select LocalFtc
	Select Distinct cCars, Desccars From LocalFtc Into Cursor LocalCars ReadWrite 
	Select LocalCars
	Select LocalFtc
	Select Distinct ctits, Descrs From LocalFtc Where CCars = lcCCars Into Cursor LocalTits ReadWrite 
	Select LocalTits
	Select crSigMvFtc
		Insert Into crSigMvFtc (EmpDopNums, Cpros, cIdChaves) Values (ThisForm.pcEdn, ThisForm.pcPro, fUniqueIds())
	Select crSigMvFtc
		Insert Into crSigMvFtc (EmpDopNums, Cpros, cIdChaves) Values (ThisForm.pcEdn, ThisForm.pcPro, fUniqueIds())
	Select crSigMvFtc
		Insert Into crSigMvFtc (EmpDopNums, Cpros, cIdChaves) Values (ThisForm.pcEdn, ThisForm.pcPro, fUniqueIds())
	Select crSigMvFtc
		Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDet.prg) - TRECHOS RELEVANTES PARA PASS SQL (1359 linhas total):

*-- Linhas 30 a 48:
30: *             ja entregues na Fase 4 como TextBox subclasse. Fora deles o
31: *             dump tem so a faixa do cabecalho (cntSombra + 2 Label), os 2
32: *             CommandGroup e a Grade: ZERO campo/Label solto, nenhum
33: *             AddObject/AddProperty em runtime, e os unicos ControlSource
34: *             do legado sao os das 3 colunas. Criar um metodo de pagina
35: *             de Dados aqui seria metodo vazio (proibido pela regra de
36: *             completude) e inventar campo violaria o PILAR 1. O
37: *             MaxLength = 20 das 3 celulas foi conferido no schema
38: *             canonico (sigmvftc.ccars, .ctits e .resps sao char(20) -
39: *             regra #19).
40: *   Fase 6:   CAMPOS RESTANTES - nada a acrescentar, pela mesma razao da
41: *             Fase 5 (confirmado em tasks\task720\analise.json, onde
42: *             campos/lookups/labels sao arrays VAZIOS: toda a superficie
43: *             de dados do SCX sao as 3 Column da Grade, entregues na
44: *             Fase 4). Inventar campo aqui violaria o PILAR 1 e criar um
45: *             ConfigurarPaginaDados seria metodo vazio (proibido pela
46: *             regra de completude).
47: *             LOOKUPS - os 2 lookups do legado (fwbuscaint no Valid de
48: *             Column1.Text1 sobre LocalCars e de Column2.Text1 sobre

*-- Linhas 142 a 196:
142: *
143: *             Por que CarregarLista nao eh mero apelido de
144: *             CarregarDadosGrade: SigOpDetBO.CarregarItens() FECHA e
145: *             RECRIA o alias cursor_4c_Itens (USE IN + SELECT ... INTO
146: *             CURSOR ... READWRITE). Derrubar o alias sob uma grade JA
147: *             bindada zera o ColumnCount e destroi os TextBox que as
148: *             Column receberam por AddObject - a grade viraria um
149: *             retangulo branco, sem erro e sem log. Por isso o funil
150: *             reaplica o bind INTEIRO depois de recarregar
151: *             (VincularGradeDet) e so entao repinta. Na PRIMEIRA carga
152: *             (dentro de ConfigurarPageFrame) a grade ainda nao existe e
153: *             o funil apenas popula o cursor - que eh justamente a ordem
154: *             que a regra #41 exige, porque Column.ControlSource estoura
155: *             se o cursor nao existir.
156: *
157: *             O bind deixou de morar no ConfigurarGrade e passou a
158: *             VincularGradeDet/VincularColunaDet (FONTE UNICA - regra
159: *             #44, item 6): RecordSource reseta Column.Width,
160: *             Header1.Caption, Sparse e CurrentControl (regra #48), entao
161: *             as duas chamadas (criacao e recarga) tem de aplicar o MESMO
162: *             bloco, na ordem ColumnCount -> RecordSource -> ControlSource
163: *             -> Width -> Header1.Caption. ColumnCount so eh tocado quando
164: *             esta diferente de 3, e cada TextBox de celula so eh recriado
165: *             quando a Column o perdeu (guarda PEMSTATUS): reatribuir
166: *             ColumnCount DESTROI os objetos Column e com eles os
167: *             controles postos por AddObject.
168: *
169: *             FormParaBO/BOParaForm sao o par de transferencia da linha, e
170: *             passaram a ser o caminho UNICO pelo qual os dois Valid de
171: *             celula gravam no cursor - no lugar dos REPLACE soltos que a
172: *             Fase 6 tinha espalhado em ValidarCaracteristicaDetExec e
173: *             ValidarComplementoDetExec. O comportamento eh o MESMO do
174: *             legado ("Replace CCars With This.Value in crSigMvFtc",
175: *             "Replace cTits ..." e o "Replace Resps With []" quando o
176: *             Complemento nao fica vazio); o que muda eh haver um lugar so
177: *             que escreve a linha. FormParaBO REAFIRMA o contexto do
178: *             dialogo (empdopnums/cpros) depois do CarregarDoCursor: o
179: *             contexto eh do FORM, nao da linha, e uma linha em branco
180: *             (placeholder) zeraria no BO justamente as duas chaves que
181: *             SigOpDetBO.GravarItens() usa no DELETE/INSERT de SigMvFtc.
182: *
183: *             ESCOPO dos metodos desta fase, medido no VFP9 em 2026-10-31
184: *             e nao presumido (PEMSTATUS(oForm, <nome>, 2), 2 = Protected):
185: *               CarregarLista .F. | AjustarBotoesPorModo .F.  -> PUBLICOS
186: *               FormParaBO    .T. | BOParaForm           .T.  -> PROTEGIDOS
187: *             CarregarLista e AjustarBotoesPorModo NAO existem em FormBase,
188: *             logo ficam publicos de verdade - e tem de ficar, porque o
189: *             harness de teste automatico os chama de FORA da classe
190: *             (regra #3). FormParaBO/BOParaForm, ao contrario, sao hooks
191: *             que FormBase.prg declara PROTECTED (linhas 285 e 280) e o
192: *             VFP9 NAO deixa a subclasse alargar escopo herdado (regra
193: *             #51): aqui eles levam PROTECTED EXPLICITO, porque omitir o
194: *             modificador nao os tornaria publicos - so esconderia o fato.
195: *             Todos os call sites deles neste form sao por THIS., de dentro
196: *             da classe; chamada de fora estoura "Property FORMPARABO is

*-- Linhas 369 a 395:
369:     * modal aberto a partir de um item de movimento. Nome mantido por
370:     * convencao do orquestrador multi-fase. Cabecalho direto sobre o form;
371:     * dados da grade sao carregados ANTES do bind (regra #41: Column.
372:     * ControlSource exige o cursor ja existente), e so depois a Grade e os
373:     * CommandGroups sao montados.
374:     *--------------------------------------------------------------------------
375:     PROTECTED PROCEDURE ConfigurarPageFrame()
376:         THIS.ConfigurarCabecalho()
377: 
378:         *-- Carga pelo funil UNICO (CarregarLista). Aqui a grade ainda nao
379:         *-- existe, entao o funil so popula cursor_4c_Itens - e eh essa a
380:         *-- ordem correta: Column.ControlSource estoura se o cursor nao
381:         *-- existir (regra #41), e SigOpDetBO.CarregarItens() recria o
382:         *-- alias, o que derrubaria o bind se a grade ja estivesse pronta.
383:         THIS.CarregarLista()
384: 
385:         THIS.ConfigurarGrade()
386:         THIS.ConfigurarBotoesConfirmar()
387:         THIS.ConfigurarBotoesInserirExcluir()
388: 
389:         *-- Grade pronta: GO TOP + Refresh, senao o cursor fica cheio e a
390:         *-- grade aparece vazia (regra #21)
391:         THIS.RepintarGradeDet()
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * CarregarDadosGrade - Popula cursor_4c_Itens (e cursor_4c_LocalFtc, o

*-- Linhas 423 a 476:
423:     *--------------------------------------------------------------------------
424:     * CriarCursorItensPlaceholder - cursor_4c_Itens vazio, com a MESMA ordem
425:     * de campos usada em SigOpDetBO.CarregarItens()/GravarItens() (regra:
426:     * CREATE CURSOR com ordem identica em todos os locais)
427:     *--------------------------------------------------------------------------
428:     PROTECTED PROCEDURE CriarCursorItensPlaceholder()
429:         IF USED("cursor_4c_Itens")
430:             USE IN cursor_4c_Itens
431:         ENDIF
432: 
433:         SET NULL ON
434:         CREATE CURSOR cursor_4c_Itens ;
435:             (cidchaves C(20), empdopnums C(29), cpros C(14), ;
436:              ccars C(20), ctits C(20), resps C(20), ordens N(6,0))
437:         SET NULL OFF
438:     ENDPROC
439: 
440:     *--------------------------------------------------------------------------
441:     * ConfigurarGrade - Grade de Caracteristica/Complemento/Outros (SIGOPDET.
442:     * Grade do legado). Aqui ficam SO as propriedades que nao dependem de
443:     * dado; todo o bind (ColumnCount/RecordSource/ControlSource/Width/
444:     * Header1.Caption/CurrentControl/Sparse/ReadOnly) mora em
445:     * VincularGradeDet, que eh FONTE UNICA compartilhada com CarregarLista
446:     * (regra #44, item 6) - duas copias do bind divergiriam em silencio na
447:     * primeira coluna nova.
448:     *--------------------------------------------------------------------------
449:     PROTECTED PROCEDURE ConfigurarGrade()
450:         LOCAL loc_oGrade
451: 
452:         THIS.AddObject("grd_4c_Dados", "Grid")
453:         loc_oGrade = THIS.grd_4c_Dados
454:         WITH loc_oGrade
455:             .Top           = 88
456:             .Left          = 74
457:             .Width         = 600
458:             .Height        = 405
459:             .FontName      = "Tahoma"
460:             .FontSize      = 8
461:             .DeleteMark    = .F.
462:             .RecordMark    = .F.
463:             .RowHeight     = 16
464:             .ScrollBars    = 2
465:             .GridLineColor = RGB(238, 238, 238)
466:         ENDWITH
467: 
468:         THIS.VincularGradeDet()
469:     ENDPROC
470: 
471:     *--------------------------------------------------------------------------
472:     * VincularGradeDet - Bind COMPLETO da grade a cursor_4c_Itens. FONTE
473:     * UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
474:     * (recarga). Precisa ser reaplicado inteiro a cada recarga porque
475:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
476:     * CurrentControl (regra #48), e porque SigOpDetBO.CarregarItens() FECHA

*-- Linhas 525 a 577:
525:     * Text1 nativo e o controle nunca aparece (regra #18); e BINDEVENT em
526:     * Valid/When de Column.Text1 nao eh confiavel (regra #46).
527:     *
528:     * Ordem obrigatoria: ControlSource -> Width -> Header1.Caption (regra
529:     * #48 - mexer na fonte do dado reseta largura e cabecalho).
530:     *--------------------------------------------------------------------------
531:     PROTECTED PROCEDURE VincularColunaDet(par_oColuna, par_cNomeControle, ;
532:             par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption)
533: 
534:         IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
535:             par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
536:         ENDIF
537:         par_oColuna.CurrentControl = par_cNomeControle
538:         par_oColuna.Sparse         = .F.
539: 
540:         WITH par_oColuna
541:             .ControlSource     = par_cControlSource
542:             .FontName          = "Tahoma"
543:             .FontSize          = 8
544:             .Width             = par_nWidth
545:             .Movable           = .F.
546:             .Resizable         = .F.
547:             .Header1.Caption   = par_cCaption
548:             .Header1.Alignment = 2
549:             .Header1.FontName  = "Tahoma"
550:             .Header1.FontSize  = 8
551:         ENDWITH
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------
555:     * CarregarLista - FUNIL UNICO de carga da grade de detalhes: recarrega
556:     * cursor_4c_Itens, reaplica o bind e repinta. PUBLIC porque o harness
557:     * de teste automatico chama THIS.oForm.CarregarLista() de FORA da
558:     * classe (CLAUDE.md regra #3 - PROTECTED falharia em runtime com
559:     * "Property CARREGARLISTA is not found").
560:     *
561:     * O rebind depois da carga NAO eh zelo: SigOpDetBO.CarregarItens() faz
562:     * USE IN + SELECT ... INTO CURSOR ... READWRITE, isto eh FECHA e RECRIA
563:     * o alias que a grade usa como RecordSource. Com a grade ja bindada
564:     * isso zera o ColumnCount e destroi os TextBox das Column - a grade
565:     * vira um retangulo branco sem erro, sem log e para o RESTO da vida do
566:     * form. Na primeira chamada (ConfigurarPageFrame) a grade ainda nao
567:     * existe e o bloco de rebind eh pulado pela guarda do VincularGradeDet.
568:     *--------------------------------------------------------------------------
569:     PROCEDURE CarregarLista()
570:         LOCAL loc_lSucesso
571: 
572:         loc_lSucesso = THIS.CarregarDadosGrade()
573: 
574:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
575:             THIS.VincularGradeDet()
576:             THIS.RepintarGradeDet()
577:         ENDIF

*-- Linhas 596 a 614:
596:         loc_lSucesso = .F.
597: 
598:         IF USED("cursor_4c_Itens") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
599:             SELECT cursor_4c_Itens
600:             GO TOP
601:             THIS.grd_4c_Dados.Refresh()
602:             loc_lSucesso = .T.
603:         ENDIF
604: 
605:         RETURN loc_lSucesso
606:     ENDPROC
607: 
608:     *--------------------------------------------------------------------------
609:     * AjustarBotoesPorModo - Aplica o modo de operacao recebido do form
610:     * chamador (pcEscolha do legado) a superficie editavel da tela. PUBLIC
611:     * porque o harness de teste automatico tambem o chama de fora da classe
612:     * (CLAUDE.md regra #3).
613:     *
614:     * O legado trava a edicao pelo When de CADA celula (InList(pcEscolha,

*-- Linhas 674 a 701:
674:     * CarregarDoCursor: ele pertence ao FORM, nao a linha. Numa linha em
675:     * branco (placeholder criado sem conexao, ou linha recem-inserida ainda
676:     * sem dado) o cursor traria vazio e zeraria no BO justamente as duas
677:     * chaves que SigOpDetBO.GravarItens() usa no DELETE/INSERT de SigMvFtc
678:     * - o DELETE passaria a apontar para empdopnums vazio.
679:     *--------------------------------------------------------------------------
680:     PROTECTED PROCEDURE FormParaBO()
681:         LOCAL loc_lSucesso, loc_oErro
682:         loc_lSucesso = .F.
683: 
684:         TRY
685:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
686:                 SELECT cursor_4c_Itens
687:                 IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
688:                     loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Itens")
689: 
690:                     THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
691:                     THIS.this_oBusinessObject.this_cCpros      = THIS.this_cCpros
692:                 ENDIF
693:             ENDIF
694:         CATCH TO loc_oErro
695:             MsgErro(loc_oErro.Message + CHR(13) + ;
696:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
697:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpDet.FormParaBO")
698:         ENDTRY
699: 
700:         RETURN loc_lSucesso
701:     ENDPROC

*-- Linhas 730 a 748:
730: 
731:         TRY
732:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Itens")
733:                 SELECT cursor_4c_Itens
734:                 IF RECCOUNT("cursor_4c_Itens") > 0 AND !EOF("cursor_4c_Itens")
735:                     loc_cIdChave = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCIdChaves, "")), 20)
736:                     loc_cCCars   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCCars,     "")), 20)
737:                     loc_cCTits   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCTits,     "")), 20)
738:                     loc_cResps   = LEFT(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cResps,     "")), 20)
739:                     loc_nOrdens  = NVL(THIS.this_oBusinessObject.this_nOrdens, 0)
740: 
741:                     REPLACE cidchaves WITH loc_cIdChave, ;
742:                             ccars     WITH loc_cCCars,   ;
743:                             ctits     WITH loc_cCTits,   ;
744:                             resps     WITH loc_cResps,   ;
745:                             ordens    WITH loc_nOrdens   ;
746:                         IN cursor_4c_Itens
747: 
748:                     loc_lSucesso = .T.

*-- Linhas 964 a 982:
964:             ENDIF
965: 
966:             IF USED("cursor_4c_LocalFtc")
967:                 SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
968:                     INTO CURSOR cursor_4c_SigOpDetLocalCars READWRITE
969:             ENDIF
970: 
971:             par_oTxt.Value = THIS.AbrirLookupCaracteristicaDet(loc_cValor)
972:         ENDIF
973: 
974:         *-- Escrita na linha pelo par canonico de transferencia, no lugar do
975:         *-- REPLACE solto (legado: "Replace CCars With This.Value in
976:         *-- crSigMvFtc"). FormParaBO le a linha corrente, so a coluna desta
977:         *-- celula muda, e BOParaForm devolve a linha inteira ao cursor -
978:         *-- um lugar so escreve a linha (Fase 8).
979:         IF THIS.FormParaBO()
980:             THIS.this_oBusinessObject.this_cCCars = par_oTxt.Value
981:             THIS.BOParaForm()
982:         ENDIF

*-- Linhas 1001 a 1019:
1001:         loc_cResultado = par_cValor
1002: 
1003:         IF USED("cursor_4c_SigOpDetLocalCars")
1004:             SELECT cursor_4c_SigOpDetLocalCars
1005:             GO TOP
1006:             LOCATE FOR ccars = par_cValor
1007:             IF FOUND()
1008:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1009:             ELSE
1010:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalCars", "Caracteristicas")
1011:                 loc_oBusca.mAddColuna("ccars", "", "C" + CHR(243) + "digo")
1012:                 loc_oBusca.mAddColuna("desccars", "", "Descri" + CHR(231) + CHR(227) + "o")
1013:                 loc_oBusca.Show()
1014: 
1015:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalCars")
1016:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalCars.ccars)
1017:                 ELSE
1018:                     *-- Cancelou: celula VAZIA de proposito, NAO eh o defeito
1019:                     *-- da regra #50. O legado termina o Valid com

*-- Linhas 1055 a 1073:
1055:             ENDIF
1056: 
1057:             IF USED("cursor_4c_LocalFtc")
1058:                 SELECT DISTINCT ctits, descrs FROM cursor_4c_LocalFtc ;
1059:                     WHERE ccars = loc_cCCars INTO CURSOR cursor_4c_SigOpDetLocalTits READWRITE
1060:             ENDIF
1061: 
1062:             par_oTxt.Value = THIS.AbrirLookupComplementoDet(loc_cValor)
1063:         ENDIF
1064: 
1065:         *-- Mesmo par canonico do Caracteristica acima (legado: "Replace
1066:         *-- cTits With This.Value in crSigMvFtc" seguido de "If Not
1067:         *-- Empty(This.Value) / Replace Resps With [] in crSigMvFtc" -
1068:         *-- escolher Complemento ZERA a coluna Outros da linha, que eh a
1069:         *-- invariante do When de Column3: Outros so com a linha sem
1070:         *-- Complemento).
1071:         IF THIS.FormParaBO()
1072:             THIS.this_oBusinessObject.this_cCTits = par_oTxt.Value
1073:             IF !EMPTY(par_oTxt.Value)

*-- Linhas 1094 a 1112:
1094:         loc_cResultado = par_cValor
1095: 
1096:         IF USED("cursor_4c_SigOpDetLocalTits")
1097:             SELECT cursor_4c_SigOpDetLocalTits
1098:             GO TOP
1099:             LOCATE FOR ctits = par_cValor
1100:             IF FOUND()
1101:                 loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1102:             ELSE
1103:                 loc_oBusca = CREATEOBJECT("FormBuscaSimples", "cursor_4c_SigOpDetLocalTits", "Complementos")
1104:                 loc_oBusca.mAddColuna("ctits", "", "C" + CHR(243) + "digo")
1105:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1106:                 loc_oBusca.Show()
1107: 
1108:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SigOpDetLocalTits")
1109:                     loc_cResultado = ALLTRIM(cursor_4c_SigOpDetLocalTits.ctits)
1110:                 ELSE
1111:                     *-- Cancelou: celula VAZIA de proposito (mesma razao do
1112:                     *-- AbrirLookupCaracteristicaDet acima - o legado fecha o

*-- Linhas 1138 a 1156:
1138:             RETURN
1139:         ENDIF
1140: 
1141:         SELECT cursor_4c_Itens
1142:         LOCATE FOR EMPTY(ccars)
1143:         IF EOF()
1144:             THIS.this_oBusinessObject.InserirLinhaPadrao()
1145:         ENDIF
1146: 
1147:         KEYBOARD "{DNARROW}"
1148:         THIS.grd_4c_Dados.Refresh()
1149:         THIS.grd_4c_Dados.Column1.SetFocus()
1150:     ENDPROC
1151: 
1152:     *--------------------------------------------------------------------------
1153:     * BtnInserirDetClick - cmdInserir.Click do legado (guard de modo +
1154:     * garante linha em branco no fim + foca Column1)
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE BtnInserirDetClick()

*-- Linhas 1176 a 1194:
1176:         ENDIF
1177: 
1178:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1179:             *-- Carrega a linha no BO ANTES de remove-la: depois do DELETE o
1180:             *-- ponteiro muda e nao ha mais como saber qual cidchaves saiu -
1181:             *-- eh ele que ObterChavePrimaria()/RegistrarAuditoria usam.
1182:             THIS.FormParaBO()
1183:             THIS.this_oBusinessObject.ExcluirLinhaAtual()
1184:         ENDIF
1185: 
1186:         THIS.grd_4c_Dados.SetFocus()
1187:         THIS.grd_4c_Dados.Refresh()
1188:     ENDPROC
1189: 
1190:     *--------------------------------------------------------------------------
1191:     * BtnConfirmarClick / BtnCancelarClick - btnConfirmar.Click e
1192:     * btnSair.Click do legado. O dump tem o MESMO corpo nos dois (Validacao
1193:     * + Release) - os dois handlers delegam para o mesmo metodo. PUBLIC
1194:     * (BINDEVENT - regra #3).

*-- Linhas 1225 a 1243:
1225:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1226:                 *-- Sincroniza o BO com a linha corrente antes de validar e
1227:                 *-- gravar: o contexto (empdopnums/cpros) que GravarItens usa
1228:                 *-- no DELETE/INSERT de SigMvFtc sai daqui.
1229:                 THIS.FormParaBO()
1230: 
1231:                 IF THIS.this_oBusinessObject.Validacao()
1232:                     IF THIS.this_oBusinessObject.GravarItens()
1233:                         THIS.Release()
1234:                     ELSE
1235:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar os detalhes selecionados.", "Erro")
1236:                         *-- Validacao() ja apagou as linhas em branco do
1237:                         *-- cursor; o dialogo continua aberto, entao a grade
1238:                         *-- tem de ser repintada para refletir isso (regra
1239:                         *-- #21 - mexer no cursor nao repinta a grade)
1240:                         THIS.RepintarGradeDet()
1241:                     ENDIF
1242:                 ELSE
1243:                     *-- Falta Caracteristica obrigatoria: o BO ja avisou e o


### BO (C:\4c\projeto\app\classes\SigOpDetBO.prg):
*==============================================================================
* SigOpDetBO.prg - Business Object para o dialogo de Selecao de Detalhes
* (Caracteristicas/Complementos de Produto) - SIGOPDET
*
* Form OPERACIONAL de DIALOGO (WindowType = 1, TitleBar = 0, ControlBox = .F.,
* AutoCenter = .T., AlwaysOnTop = .T., Height = 500, Width = 800) aberto por um
* form PAI - o Init legado recebe "LParameters pCnx, pEscolha, pDopes, pProd,
* pEDN" (pCnx = ThisForm.poDataMgr, nao portado - este ambiente usa o handle
* global gnConnHandle).
*
* OBJETIVO DO DIALOGO
* --------------------
* Exibir, numa grade de 3 colunas (Caracteristica / Complemento / Outros), as
* linhas de SigMvFtc associadas a um item de movimento (par EmpDopNums+Cpros)
* e permitir ao usuario escolher, para cada linha, uma Caracteristica (coluna
* ccars, validada contra SigCrRap) e um Complemento (coluna ctits, validado
* contra SigPrCpP), alem de digitar uma observacao livre (coluna resps).
*
* O universo de Caracteristicas/Complementos permitido para o par
* Grupo (pDopes, equivale a SigCdFtc.cgrus) + Grande Grupo do produto
* (SigCdPro.Mercs) vem de SigCdFtc (filtrada por ntipos = 2), unida com
* SigCrRap (descricao + flag chkobrig - caracteristica obrigatoria) e
* SigPrCpP (descricao do complemento). Essa lista NAO tem tabela propria no
* dialogo - fica numa cursor de referencia (equivalente ao LocalFtc do
* legado), carregada por metodo a implementar na Fase 2.
*
* TABELA PRINCIPAL (persistida e editada por este dialogo): SigMvFtc
*   cidchaves  char(20) NOT NULL  - PK (fUniqueIds() por linha, regra #22)
*   empdopnums char(29) NOT NULL  - chave do movimento (par_cEmpDopNums)
*   cpros      char(14) NOT NULL  - codigo do produto (par_cCpros)
*   ccars      char(20) NOT NULL  - caracteristica selecionada na linha
*   ctits      char(20) NOT NULL  - complemento selecionado na linha
*   resps      char(20) NOT NULL  - observacao/resposta digitada na linha
*   ordens     numeric(6,0) NOT NULL - ordem da linha (sem DEFAULT no schema -
*                                      o legado nunca grava no INSERT da
*                                      cursor local; a Fase 2 precisa decidir
*                                      um valor antes do INSERT real na tabela
*                                      - regra #22)
*
* PARAMETROS RECEBIDOS DO FORM PAI (Init legado, sem o pCnx que nao existe
* mais neste ambiente):
*   this_cModoOperacao - pEscolha (INSERIR/ALTERAR/VISUALIZAR/etc) - decide se
*                        as colunas da grade aceitam edicao (When do legado:
*                        InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR'))
*   this_cGrupo        - pDopes (SigCdFtc.cgrus) - grupo de caracteristicas
*   this_cCpros        - pProd (SigCdPro.Cpros) - produto do item de movimento
*   this_cEmpDopNums   - pEDN (chave do item de movimento, SigMvCab/SigMvItn)
*
* DADO DE REFERENCIA CARREGADO A PARTIR DO PRODUTO (Fase 2):
*   this_cMercs - SigCdPro.Mercs (Grande Grupo do produto), obtido via
*                 CursorQuery/SQLEXEC em SigCdPro WHERE Cpros = this_cCpros.
*                 Usado para filtrar SigCrRap.cgrus = this_cMercs na consulta
*                 da lista de Caracteristicas/Complementos permitidos.
*
* PROPRIEDADES DA LINHA CORRENTE DA GRADE (SigMvFtc - uma linha por vez, no
* padrao de validacao de celula da grade - regra #46: Valid do TextBox da
* coluna, nunca AfterRowColChange):
*   this_cCIdChaves - cidchaves da linha corrente
*   this_cCCars     - ccars da linha corrente (Caracteristica)
*   this_cCTits     - ctits da linha corrente (Complemento)
*   this_cResps     - resps da linha corrente (observacao)
*   this_nOrdens    - ordens da linha corrente
*
* METODOS DE CARGA/PERSISTENCIA DA GRADE (Fase 4):
*   CarregarProduto()        - le SigCdPro para obter this_cMercs
*   CarregarListaReferencia() - popula cursor_4c_LocalFtc (equivalente ao
*                               LocalFtc do legado - join SigCdFtc+SigCrRap+
*                               SigPrCpP)
*   CarregarItens()          - orquestra CarregarProduto+CarregarListaReferencia
*                               e popula cursor_4c_Itens a partir de SigMvFtc
*                               (equivalente ao Init legado), garantindo uma
*                               linha para cada caracteristica obrigatoria
*   InserirLinhaPadrao()     - garante linha em branco no final da grade
*                               (cmdInserir.Click do legado)
*   ExcluirLinhaAtual()      - remove a linha corrente (cmdExcluir.Click)
*   Validacao()              - confere que toda Caracteristica obrigatoria
*                               (SigCrRap.chkobrig=1) tem linha preenchida;
*                               se ok, descarta as linhas em branco
*   GravarItens()            - persiste as linhas sobreviventes em SigMvFtc
*                               (Confirmar/Cancelar do legado - equivalente
*                               ao TABLEUPDATE automatico do cursor remoto
*                               buffered, que este ambiente nao possui)
*   ObterChavePrimaria()      - retorna this_cCIdChaves (ALLTRIM)
*
* Lookup de Caracteristica/Complemento (ValidarCaracteristica/
* ValidarComplemento, equivalentes ao fwbuscaint do legado) vivem no FORM
* (TextBoxGridLookup.prg - regra #46: Valid do TextBox da coluna), nao no BO,
* porque dependem diretamente do TextBox da celula.
*
* Este dialogo PERSISTE uma tabela propria (SigMvFtc, ao contrario de
* SigOpCtsBO/SigOpAutBO) via GravarItens()/Inserir().
*
* Fase 4/8 (atual): carga/persistencia completa da grade.
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDetBO AS BusinessBase

    *-- Parametros recebidos do form pai na abertura (Init legado: pEscolha,
    *-- pDopes, pProd, pEDN - sem pCnx, que nao existe mais neste ambiente)
    this_cModoOperacao = ""    && pEscolha - INSERIR/ALTERAR/VISUALIZAR/etc
    this_cGrupo        = ""    && pDopes - SigCdFtc.cgrus (grupo de caracteristicas)
    this_cCpros        = ""    && pProd - SigCdPro.Cpros (produto do item de movimento)
    this_cEmpDopNums   = ""    && pEDN - chave do item de movimento (SigMvCab/SigMvItn)

    *-- Dado de referencia obtido a partir do produto (Fase 2:
    *-- CarregarProduto) - usado para filtrar o universo de Caracteristicas/
    *-- Complementos permitidos (SigCrRap.cgrus = this_cMercs)
    this_cMercs = ""            && SigCdPro.Mercs - Grande Grupo do produto

    *-- Propriedades da entidade (mapeamento para tabela SigMvFtc - linha
    *-- corrente da grade, uma linha por vez)
    this_cCIdChaves = ""         && cidchaves char(20) NOT NULL - PK
    this_cCCars     = ""         && ccars char(20) NOT NULL - Caracteristica
    this_cCTits     = ""         && ctits char(20) NOT NULL - Complemento
    this_cResps     = ""         && resps char(20) NOT NULL - observacao da linha
    this_nOrdens    = 0          && ordens numeric(6,0) NOT NULL - ordem da linha

    *====================================================================
    * Init - Inicializa Business Object
    * par_cModoOperacao - pEscolha do legado (INSERIR/ALTERAR/VISUALIZAR)
    * par_cGrupo        - pDopes do legado (SigCdFtc.cgrus)
    * par_cCpros        - pProd do legado (SigCdPro.Cpros)
    * par_cEmpDopNums   - pEDN do legado (chave do item de movimento)
    *====================================================================
    PROCEDURE Init(par_cModoOperacao, par_cGrupo, par_cCpros, par_cEmpDopNums)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvFtc"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cModoOperacao = IIF(VARTYPE(par_cModoOperacao) = "C", ;
                ALLTRIM(par_cModoOperacao), "")
            THIS.this_cGrupo        = IIF(VARTYPE(par_cGrupo) = "C", ;
                ALLTRIM(par_cGrupo), "")
            THIS.this_cCpros        = IIF(VARTYPE(par_cCpros) = "C", ;
                ALLTRIM(par_cCpros), "")
            THIS.this_cEmpDopNums   = IIF(VARTYPE(par_cEmpDopNums) = "C", ;
                ALLTRIM(par_cEmpDopNums), "")

            THIS.this_cMercs = ""

            THIS.this_cCIdChaves = ""
            THIS.this_cCCars     = ""
            THIS.this_cCTits     = ""
            THIS.this_cResps     = ""
            THIS.this_nOrdens    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades da LINHA CORRENTE da grade
    * a partir de um cursor de SigMvFtc (regra #46: a validacao de celula
    * fica no Valid do TextBox da coluna, que le este metodo depois de
    * posicionar o cursor na linha da grade - nao em AfterRowColChange)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCIdChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCCars      = TratarNulo(ccars,      "C")
                THIS.this_cCTits      = TratarNulo(ctits,      "C")
                THIS.this_cResps      = TratarNulo(resps,      "C")
                THIS.this_nOrdens     = TratarNulo(ordens,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna cidchaves da linha corrente (PK de
    * SigMvFtc), usada por RegistrarAuditoria em Inserir/Atualizar
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *====================================================================
    * Inserir - Insere uma nova linha (Caracteristica/Complemento/Resposta)
    * em SigMvFtc para o item de movimento corrente (this_cEmpDopNums +
    * this_cCpros, fixos para o dialogo inteiro - regra #22: cidchaves
    * gerado por fUniqueIds(), nunca string vazia, para nao colidir no
    * indice unico quando a grade tiver mais de uma linha)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChaves)
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvFtc (cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens)
                VALUES (
                    <<EscaparSQL(THIS.this_cCIdChaves)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cCCars)>>,
                    <<EscaparSQL(THIS.this_cCTits)>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a linha corrente (ccars/ctits/resps/ordens) de
    * SigMvFtc pela chave cidchaves. Nao atualiza empdopnums/cpros (fixos
    * para o item de movimento corrente)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvFtc
                SET ccars  = <<EscaparSQL(THIS.this_cCCars)>>,
                    ctits  = <<EscaparSQL(THIS.this_cCTits)>>,
                    resps  = <<EscaparSQL(THIS.this_cResps)>>,
                    ordens = <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarProduto - Le SigCdPro para obter this_cMercs (Grande Grupo
    * do produto), usado para filtrar o universo de Caracteristicas/
    * Complementos permitidos (equivale ao CursorQuery('SigCdPro',
    * 'crProduto','Cpros',ThisForm.pcPro,'Mercs, Cpros') do Init legado)
    *====================================================================
    PROTECTED PROCEDURE CarregarProduto()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT mercs FROM SigCdPro WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetProd")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigOpDetProd") AND RECCOUNT("cursor_4c_SigOpDetProd") > 0
                    THIS.this_cMercs = TratarNulo(cursor_4c_SigOpDetProd.mercs, "C")
                ELSE
                    THIS.this_cMercs = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar o produto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarListaReferencia - Monta cursor_4c_LocalFtc (equivalente ao
    * LocalFtc do legado): universo de Caracteristicas/Complementos
    * permitidos para o par Grupo (this_cGrupo = SigCdFtc.cgrus) + Grande
    * Grupo do produto (this_cMercs), com a descricao da caracteristica
    * (SigCrRap.descrs AS Desccars) e do complemento (SigPrCpP.descrs, SEM
    * alias - os nomes finais tem de bater com os das sub-consultas feitas
    * pelo Form em cima deste cursor: "Desccars" e "descrs")
    *====================================================================
    PROTECTED PROCEDURE CarregarListaReferencia()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalFtc")
                USE IN cursor_4c_LocalFtc
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.ccars, b.descrs AS Desccars, a.ctits, b.chkobrig, c.descrs, a.cgrus AS Dopes
                FROM SigCdFtc a
                INNER JOIN SigCrRap b ON a.ccars = b.codigos
                INNER JOIN SigPrCpP c ON a.ctits = c.codigos
                WHERE a.ntipos = 2
                AND a.cgrus = <<EscaparSQL(THIS.this_cGrupo)>>
                AND b.cgrus = <<EscaparSQL(THIS.this_cMercs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFtc")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar a lista de caracter" + CHR(237) + "sticas/complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarListaReferencia")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - Orquestra a carga completa do dialogo (equivalente
    * ao Init legado, do CursorQuery do produto em diante): CarregarProduto,
    * CarregarListaReferencia, popula cursor_4c_Itens (equivalente a
    * crSigMvFtc) a partir de SigMvFtc filtrado por this_cEmpDopNums +
    * this_cCpros, e garante uma linha para CADA caracteristica obrigatoria
    * (SigCrRap.chkobrig = 1) que ainda nao esteja representada
    * (regra do legado: "Insert Into crSigMvFtc (...) Values (...)" dentro
    * do SCAN de CarsObrigs).
    *
    * cursor_4c_Itens nasce de um alias TEMPORARIO + SELECT INTO CURSOR
    * READWRITE (SQLEXEC() sozinho cria cursor so-leitura - a grade do Form
    * precisa editar celulas).
    *====================================================================
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCarObrig, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            IF !THIS.CarregarProduto()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.CarregarListaReferencia()
                    loc_lSucesso = .F.
                ELSE
                    IF USED("cursor_4c_SigOpDetItensTmp")
                        USE IN cursor_4c_SigOpDetItensTmp
                    ENDIF

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens
                        FROM SigMvFtc
                        WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                        AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetItensTmp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar os detalhes do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_Itens")
                            USE IN cursor_4c_Itens
                        ENDIF
                        SELECT * FROM cursor_4c_SigOpDetItensTmp INTO CURSOR cursor_4c_Itens READWRITE
                        IF USED("cursor_4c_SigOpDetItensTmp")
                            USE IN cursor_4c_SigOpDetItensTmp
                        ENDIF

                        *-- Garante uma linha para cada caracteristica obrigatoria
                        *-- ainda nao representada (legado: Insert dentro do Scan)
                        IF USED("cursor_4c_SigOpDetObrigs")
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF
                        SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                            WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                        loc_nOrdem = 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        LOCATE FOR !EMPTY(ccars)
                        IF !EOF()
                            loc_nOrdem = RECCOUNT("cursor_4c_Itens")
                        ENDIF

                        IF USED("cursor_4c_SigOpDetObrigs")
                            SELECT cursor_4c_SigOpDetObrigs
                            SCAN
                                loc_cCarObrig = ccars
                                SELECT cursor_4c_Itens
                                LOCATE FOR ccars = loc_cCarObrig
                                IF !FOUND()
                                    loc_nOrdem = loc_nOrdem + 1
                                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ccars, ordens) ;
                                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, loc_cCarObrig, loc_nOrdem)
                                ENDIF
                                SELECT cursor_4c_SigOpDetObrigs
                            ENDSCAN
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF

                        SELECT cursor_4c_Itens
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaPadrao - Garante que exista uma linha em branco no final
    * de cursor_4c_Itens para o usuario preencher (equivalente ao
    * cmdInserir.Click do legado: so cria se nao houver NENHUMA linha com
    * CCars vazio)
    *====================================================================
    PROCEDURE InserirLinhaPadrao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
                LOCATE FOR EMPTY(ccars)
                IF EOF()
                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ordens) ;
                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, RECCOUNT("cursor_4c_Itens") + 1)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.InserirLinhaPadrao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove a linha corrente de cursor_4c_Itens
    * (equivalente ao cmdExcluir.Click do legado)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.ExcluirLinhaAtual")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Validacao - Confere que toda Caracteristica obrigatoria (SigCrRap.
    * chkobrig = 1) para o par Grupo/Grande Grupo tem uma linha preenchida
    * em cursor_4c_Itens; se faltar alguma, avisa e devolve .F. (mesma
    * mensagem do legado). Se tudo ok, apaga as linhas em branco (Delete
    * From crSigMvFtc where Empty(CCars) do legado) e devolve .T.
    *====================================================================
    FUNCTION Validacao()
        LOCAL loc_lOk, loc_cCarObrig, loc_cDescObrig, loc_cMsg
        loc_lOk  = .T.
        loc_cMsg = ""

        TRY
            IF USED("cursor_4c_SigOpDetObrigs")
                USE IN cursor_4c_SigOpDetObrigs
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                    WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                IF USED("cursor_4c_SigOpDetObrigs")
                    SELECT cursor_4c_SigOpDetObrigs
                    SCAN
                        loc_cCarObrig  = ccars
                        loc_cDescObrig = desccars

                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                            LOCATE FOR ccars = loc_cCarObrig
                            IF !FOUND()
                                loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                                loc_lOk = .F.
                            ENDIF
                        ELSE
                            loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                            loc_lOk = .F.
                        ENDIF

                        IF !loc_lOk
                            EXIT
                        ENDIF
                        SELECT cursor_4c_SigOpDetObrigs
                    ENDSCAN
                    USE IN cursor_4c_SigOpDetObrigs
                ENDIF
            ENDIF

            IF !loc_lOk
                MsgAviso("Existem Caracteristicas Obrigat" + CHR(243) + "rias e n" + CHR(227) + "o Foram Informadas." + CHR(13) + CHR(10) + ;
                    CHR(13) + CHR(10) + loc_cMsg + CHR(13) + CHR(10) + "Verifique.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Itens")
                    DELETE FROM cursor_4c_Itens WHERE EMPTY(ccars)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Validacao")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * GravarItens - Persiste as linhas sobreviventes de cursor_4c_Itens
    * (apos Validacao() ja ter descartado as em branco) em SigMvFtc. O
    * item de movimento (this_cEmpDopNums + this_cCpros) e gravado por
    * completo: apaga tudo que ja existia na tabela para o item e regrava
    * cada linha corrente do cursor - equivalente, para esta tela, ao
    * TABLEUPDATE automatico do cursor remoto buffered do legado
    * (crSigMvFtc), que este ambiente nao possui.
    *====================================================================
    PROCEDURE GravarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvFtc
                WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao limpar os detalhes anteriores do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                loc_nOrdem = 0

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    SCAN FOR !DELETED() AND !EMPTY(ccars)
                        loc_nOrdem = loc_nOrdem + 1

                        THIS.this_cCIdChaves = TratarNulo(cidchaves, "C")
                        THIS.this_cCCars     = TratarNulo(ccars,     "C")
                        THIS.this_cCTits     = TratarNulo(ctits,     "C")
                        THIS.this_cResps     = TratarNulo(resps,     "C")
                        THIS.this_nOrdens    = loc_nOrdem

                        IF EMPTY(THIS.this_cCIdChaves)
                            THIS.this_cCIdChaves = fUniqueIds()
                        ENDIF

                        IF !THIS.Inserir()
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_Itens
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

