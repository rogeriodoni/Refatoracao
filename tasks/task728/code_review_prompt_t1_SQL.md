# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATASESSION' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS

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
Select crSigMvIte
lcQuery = [Select Descs, Cods, Pesos as PesoEmbs From SigCdemb Order By Cods]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCdEmb]) < 1) 
Select a.Cods, a.Descs, a.PesoEmbs, Nvl(b.EmpDopNums,'') as EmpDopNums, Nvl(b.Emps,'') as Emps, Nvl(b.Dopes,'') as Dopes, Nvl(b.Numes,0) as Numes, ;
	From LocalCdEmb a Left Join crSigMvIte b On a.Cods = b.CodEmbs And b.Citens = crTpmMvItn.Citens Order By a.Cods Into Cursor LocalEmb ReadWrite
This.Grade.Column1.ControlSource = [LocalEmb.Qtds]
This.Grade.Column2.ControlSource = [LocalEmb.Descs]
This.Grade.Column3.ControlSource = [LocalEmb.PesoEmbs]
This.Grade.Column4.ControlSource = [LocalEmb.Pesos]
Select LocalEmb
This.Grade.Column1.ControlSource = []
This.Grade.Column2.ControlSource = []
Select LocalEmb
Select CrSigMvIte
Delete For cItens = crTpmMvItn.Citens in CrSigMvIte
Select LocalEmb
		Insert into crSigMvIte From Memvar
Select LocalEmb

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEmb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1299 linhas total):

*-- Linhas 59 a 77:
59: *       HabilitarCampos habilitar nem o que AjustarBotoesPorModo ajustar,
60: *       e LimparCampos (chamado por FormBase.Novo) nao tem registro novo
61: *       para limpar - a grade ja abre com as quantidades gravadas do item
62: *       (o LEFT JOIN do Init legado).
63: *     - FormParaBO/BOParaForm mapeiam CAMPO A CAMPO uma ficha de Page2.
64: *       Aqui nao ha campo fora da grade (medido na Fase 5, secao CAMPOS
65: *       abaixo) e a grade esta ligada DIRETO ao cursor que o BO cria e
66: *       possui, entao nao existe par tela<->property para espelhar: a
67: *       transferencia form -> BO acontece por ARGUMENTO
68: *       (ValidarQuantidadeGrade passa par_oTxt.Value a
69: *       SigOpEmbBO.AtualizarPesoLinha, e o Init passa o contexto
70: *       Citens/Emps/Dopes/Numes), e a volta BO -> tela eh o proprio
71: *       cursor, repintado por RepintarGrade. Preencher os dois hooks
72: *       aqui seria codigo MORTO: quem os chama eh FormBase.Salvar e
73: *       FormBase.Cancelar, e esta tela nao usa nenhum dos dois (grava por
74: *       BtnConfirmarClick -> SigOpEmbBO.GravarEmbalagensDoItem).
75: *
76: *     Criar os sete como stub violaria a regra de completude; criar como
77: *     logica real inventaria botao, modo e ficha que o legado nao tem,

*-- Linhas 128 a 146:
128: *     Column1.Text1.Valid e os quatro When das colunas - nenhum deles
129: *     abre browse de selecao. Os unicos dados de referencia da tela
130: *     (codigo, descricao e peso unitario da embalagem) chegam pela
131: *     CONSULTA que monta a grade (SELECT ... FROM SigCdEmb, no BO), e nao
132: *     por picker: o usuario nao escolhe embalagem, ele digita a
133: *     quantidade de cada uma das que ja estao listadas. Criar aqui um
134: *     FormBuscaAuxiliar seria inventar tabela de lookup que o legado
135: *     nunca consultou.
136: *
137: * "Load -> =fConfigGeral()" do legado: deliberadamente NAO reproduzido como
138: *     chamada. fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg /
139: *     SIGFUNCS.PRG) que nao veio no acervo; o projeto tem
140: *     utils\fconfiggeral.prg, mas esse arquivo e' um wrapper que existe
141: *     SO para o p-code dos VCX legado o alcancar pelo PATH, e o proprio
142: *     cabecalho dele manda nao chama-lo de codigo nosso. O que a funcao
143: *     fazia era configuracao GLOBAL, que nesta arquitetura acontece antes
144: *     e em outro lugar: SETs/paths/variaveis globais em config.prg,
145: *     conexao e empresa em main.prg, e os cursores desta tela em
146: *     SigOpEmbBO (CriarCursorEmbalagens/CarregarCadastroEmbalagens/

*-- Linhas 256 a 274:
256:     *-- (btnConfirmar) - ou seja esta tela nao tem como "desistir", e isso
257:     *-- e' comportamento do LEGADO, nao desvio. O efeito pratico e' menor
258:     *-- do que parece: a grade abre JA com as quantidades gravadas do item
259:     *-- (LEFT JOIN do Init legado), entao confirmar sem mexer em nada
260:     *-- regrava os mesmos valores e devolve o mesmo peso. Se o dump nao
261:     *-- declarasse esta propriedade, ela NAO poderia ser acrescentada por
262:     *-- coerencia com TitleBar/ControlBox, justamente porque o unico botao
263:     *-- commita.
264:     Closable     = .F.
265: 
266:     *--------------------------------------------------------------------------
267:     * Init - Armazena o contexto do item de movimento pai, cria o BO e
268:     * dispara FormBase.Init() (que chama THIS.InicializarForm() via
269:     * DODEFAULT()).
270:     *--------------------------------------------------------------------------
271:     PROCEDURE Init(par_oFormPai, par_nCitens, par_cEmps, par_cDopes, par_nNumes)
272:         LOCAL loc_lSucesso, loc_oErro
273:         loc_lSucesso = .F.
274: 

*-- Linhas 353 a 371:
353:     *   1. cabecalho PRIMEIRO - cmg_4c_Botoes fica em Top = -2, DENTRO da
354:     *      area da faixa (Top 0..80), e so desenha por cima dela se for
355:     *      criado DEPOIS (regra #11);
356:     *   2. CarregarLista ANTES da grade - Column.ControlSource estoura
357:     *      "Alias not found" se o cursor nao existir (regra #41), e
358:     *      SigOpEmbBO.CriarCursorEmbalagens() pode recriar o alias, o que
359:     *      derrubaria um bind ja feito;
360:     *   3. grade e botoes;
361:     *   4. RepintarGrade por ULTIMO - popular o cursor NAO repinta a grade
362:     *      (regra #21).
363:     *
364:     * NAO EXISTEM ConfigurarPaginaLista/AlternarPagina proprios nesta tela:
365:     * o SIGOEMB legado eh FLAT (a arvore do dump tem form + cntSombra +
366:     * cntBotoes + Grade, sem PageFrame nenhum), entao nao ha Page1/Lista
367:     * para configurar nem paginas para alternar. Criar os dois obrigaria a
368:     * INVENTAR um PageFrame e 6 botoes CRUD que o legado nao tem (viola o
369:     * PILAR 1) ou a deixar metodo vazio (proibido pela regra de
370:     * completude). O AlternarPagina herdado de FormBase ja eh inocuo
371:     * quando nao existe pgf_4c_Paginas, e por isso tambem nao eh

*-- Linhas 452 a 518:
452:     * NAO ha compensacao de Top aqui: este form eh FLAT, sem o PageFrame de
453:     * Top = -29 dos cadastros - os Tops do SCX ja sao absolutos no form.
454:     *
455:     * DeleteMark = .F. NAO esta no dump: a classe fwgrade do Framework
456:     * (docs/framework_frmcadastro_layout.md) ja nasce com as duas barras
457:     * desligadas e o SCX so precisou declarar RecordMark. Aqui a grade eh
458:     * Grid base do VFP, que nasce com DeleteMark = .T. - declarar .F. eh o
459:     * que REPRODUZ o legado, nao um desvio dele.
460:     *
461:     * Aqui ficam SO as propriedades que nao dependem de dado. Todo o bind
462:     * (ColumnCount/RecordSource/ControlSource/Width/Header1.Caption/
463:     * InputMask/CurrentControl/Sparse/ReadOnly) mora em VincularGrade, que
464:     * eh FONTE UNICA compartilhada com CarregarLista - duas copias do bind
465:     * divergiriam em silencio na primeira coluna nova (regra #44, item 6).
466:     *--------------------------------------------------------------------------
467:     PROTECTED PROCEDURE ConfigurarGrade()
468:         LOCAL loc_oGrade
469: 
470:         THIS.AddObject("grd_4c_Dados", "Grid")
471:         loc_oGrade = THIS.grd_4c_Dados
472:         WITH loc_oGrade
473:             .Top          = 84
474:             .Left         = 84
475:             .Width        = 380
476:             .Height       = 143
477:             .FontName     = "Verdana"
478:             .FontSize     = 8
479:             .HeaderHeight = 22
480:             .RowHeight    = 20
481:             .ScrollBars   = 2
482:             .Panel        = 1
483:             .TabIndex     = 1
484:             .RecordMark   = .F.
485:             .DeleteMark   = .F.
486:         ENDWITH
487: 
488:         THIS.VincularGrade()
489:     ENDPROC
490: 
491:     *--------------------------------------------------------------------------
492:     * VincularGrade - bind COMPLETO da grade ao cursor das embalagens.
493:     * FONTE UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
494:     * (recarga).
495:     *
496:     * Precisa ser reaplicado INTEIRO a cada recarga porque atribuir
497:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
498:     * CurrentControl (regra #48).
499:     *
500:     * ColumnCount so eh tocado quando esta diferente de 4: reatribui-lo
501:     * DESTROI os objetos Column e com eles os TextBox postos por AddObject.
502:     *
503:     * ControlSource das 4 colunas, transcrito do Init legado:
504:     *   Column1 -> LocalEmb.Qtds      (quantidade digitada - unica editavel)
505:     *   Column2 -> LocalEmb.Descs     (descricao da embalagem)
506:     *   Column3 -> LocalEmb.PesoEmbs  (peso unitario do cadastro)
507:     *   Column4 -> LocalEmb.Pesos     (Qtds * PesoEmbs)
508:     *
509:     * Movable/Resizable = .F. SO na Column1, porque eh so nela que o SCX
510:     * declara o par - as outras tres nao declaram e ficam no default .T.
511:     *
512:     * Grid.ReadOnly propaga para as colunas, por isso vem ANTES dos
513:     * Column.ReadOnly (regra #18) - e os Column.ReadOnly vem DEPOIS dele
514:     * justamente para nao serem sobrescritos pela propagacao.
515:     *
516:     * Column1 = .F. (o dump declara .F. e eh a unica celula que o usuario
517:     * digita). Columns 2/3/4 = .T.: o dump declara .F. nas quatro, mas e'
518:     * o "When -> Return .F." dos TextBox delas que BLOQUEIA as tres - e a

*-- Linhas 604 a 627:
604:     * mudaria o limite que o usuario enxerga. Vazio = o SCX nao declara, e
605:     * nada eh atribuido (regra #49: InputMask ausente nao se inventa).
606:     *
607:     * Ordem obrigatoria no fim: ControlSource -> InputMask -> Width ->
608:     * Header1.Caption. Mexer na fonte do dado reseta largura e cabecalho
609:     * (regra #48).
610:     *--------------------------------------------------------------------------
611:     PROTECTED PROCEDURE VincularColunaEmb(par_oColuna, par_cNomeControle, ;
612:             par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption, ;
613:             par_cInputMaskColuna, par_cInputMaskControle)
614: 
615:         IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
616:             par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
617:         ENDIF
618: 
619:         par_oColuna.CurrentControl = par_cNomeControle
620:         par_oColuna.Sparse         = .F.
621: 
622:         *-- Propriedades do TextBox da celula (Column<N>.Text1 do dump:
623:         *-- BorderStyle=0, Margin=0, ForeColor=0,0,0, BackColor=255,255,255)
624:         WITH EVALUATE("par_oColuna." + par_cNomeControle)
625:             .FontName    = "Verdana"
626:             .FontSize    = 8
627:             .BorderStyle = 0

*-- Linhas 636 a 654:
636:         ENDWITH
637: 
638:         WITH par_oColuna
639:             .ControlSource = par_cControlSource
640:             .FontName      = "Verdana"
641:             .FontSize      = 8
642: 
643:             IF !EMPTY(par_cInputMaskColuna)
644:                 .InputMask = par_cInputMaskColuna
645:             ENDIF
646: 
647:             .Width             = par_nWidth
648:             .Header1.Caption   = par_cCaption
649:             .Header1.Alignment = 2
650:             .Header1.FontName  = "Verdana"
651:             .Header1.FontSize  = 8
652:         ENDWITH
653:     ENDPROC
654: 

*-- Linhas 734 a 752:
734:     * ObterAliasGrade - nome do alias que alimenta a grade.
735:     *
736:     * Lido do BO (this_cCursorEmbalagens), que eh o DONO da estrutura e o
737:     * ponto UNICO de CREATE CURSOR desta tela - repetir o literal aqui
738:     * criaria uma segunda fonte de verdade para o nome, e um renomeio no BO
739:     * passaria a bindar a grade num alias que ninguem popula. O literal
740:     * entra SO como ultimo recurso (BO ausente), para o metodo nunca
741:     * devolver string vazia e fazer USED("") estourar.
742:     *--------------------------------------------------------------------------
743:     PROTECTED FUNCTION ObterAliasGrade()
744:         LOCAL loc_cAlias
745:         loc_cAlias = ""
746: 
747:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
748:             loc_cAlias = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCursorEmbalagens, ""))
749:         ENDIF
750: 
751:         IF EMPTY(loc_cAlias)
752:             loc_cAlias = "cursor_4c_Embalagens"

*-- Linhas 759 a 793:
759:     * CarregarDadosGrade - popula o cursor da grade ANTES de ela existir.
760:     *
761:     * Equivale ao trecho do Init legado que roda a consulta do cadastro
762:     * (LocalCdEmb) e monta o LEFT JOIN com as linhas do item (LocalEmb) -
763:     * aqui tudo isso mora em SigOpEmbBO.CarregarEmbalagensDoItem().
764:     *
765:     * Em validacao de UI / modo teste (gnConnHandle = -1) a carga real NAO
766:     * eh tentada: SigOpEmbBO.CarregarCadastroEmbalagens() exibe "Favor
767:     * Reinicializar o Processo!!!" sem conexao, e um MsgErro modal numa
768:     * instanciacao automatizada PENDURA o processo. Nesse caso so o cursor
769:     * VAZIO eh criado (CriarCursorEmbalagens), suficiente para a grade
770:     * bindar sem estourar.
771:     *
772:     * O cursor vazio tambem eh a rede da carga real que falha: sem alias
773:     * aberto, Column.ControlSource dispara "Alias not found" e derruba o
774:     * Init inteiro - a tela nao abriria (regra #41). Carga real falhando
775:     * NAO eh erro de fluxo: o BO ja exibiu a mensagem do SQL Server.
776:     *
777:     * NUNCA criar aqui um segundo CREATE CURSOR com a estrutura repetida:
778:     * APPEND FROM DBF() casa por NOME, e duas declaracoes com ordem ou
779:     * grafia diferentes eh o defeito classico dos forms OPERACIONAIS. A
780:     * estrutura mora so em SigOpEmbBO.CriarCursorEmbalagens().
781:     *--------------------------------------------------------------------------
782:     PROTECTED FUNCTION CarregarDadosGrade()
783:         LOCAL loc_lModoSemBanco, loc_cAlias
784: 
785:         loc_cAlias = THIS.ObterAliasGrade()
786: 
787:         loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
788:             OR (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
789: 
790:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
791:             IF loc_lModoSemBanco
792:                 THIS.this_oBusinessObject.CriarCursorEmbalagens()
793:             ELSE

*-- Linhas 832 a 865:
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * RepintarGrade - "Select LocalEmb / Go Top" + Refresh do fim do Init
836:     * legado.
837:     *
838:     * Popular o cursor NAO repinta a grade (regra #21): sem o GO TOP a
839:     * grade pode abrir posicionada em EOF e parecer VAZIA com o cursor
840:     * cheio, e o sintoma reportado ("a tela nao traz as embalagens") manda
841:     * o diagnostico para SQL/cursor/permissao, onde nao ha defeito nenhum.
842:     *--------------------------------------------------------------------------
843:     PROTECTED FUNCTION RepintarGrade()
844:         LOCAL loc_lSucesso, loc_cAlias
845: 
846:         loc_lSucesso = .F.
847:         loc_cAlias   = THIS.ObterAliasGrade()
848: 
849:         IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
850:             SELECT (loc_cAlias)
851:             GO TOP
852:             THIS.grd_4c_Dados.Refresh()
853:             loc_lSucesso = .T.
854:         ENDIF
855: 
856:         RETURN loc_lSucesso
857:     ENDFUNC
858: 
859:     *--------------------------------------------------------------------------
860:     * BtnConfirmarClick - alvo do BINDEVENT do unico botao da tela. PUBLIC:
861:     * BINDEVENT ignora metodo PROTECTED em silencio (regra #3).
862:     *--------------------------------------------------------------------------
863:     PROCEDURE BtnConfirmarClick()
864:         THIS.ConfirmarEmbalagensExec()
865:     ENDPROC

*-- Linhas 1006 a 1024:
1006: 
1007:     *--------------------------------------------------------------------------
1008:     * ValidarQuantidadeGrade - Grade.Column1.Text1.Valid do legado:
1009:     *     Select LocalEmb
1010:     *     Replace Qtds With This.Value,
1011:     *             Pesos with Localemb.Qtds * LocalEmb.PesoEmbs
1012:     *     thisform.grade.Refresh()
1013:     *
1014:     * A gravacao no cursor e o recalculo moram no BO (AtualizarPesoLinha);
1015:     * aqui fica so o Refresh, que eh da TELA.
1016:     *
1017:     * O valor digitado vem de par_oTxt.Value, NAO do cursor: dentro do Valid
1018:     * o cursor ainda tem o valor ANTIGO (regra #46) - ler dali recalcularia
1019:     * o peso com a quantidade anterior.
1020:     *
1021:     * Retorna SEMPRE .T.: o Valid legado nao tem RETURN (e procedure sem
1022:     * RETURN devolve .T. em VFP9), ou seja ele nunca prende o usuario na
1023:     * celula. Devolver .F. numa falha mudaria o comportamento da tela.
1024:     *

*-- Linhas 1116 a 1178:
1116:     * DesvincularGrade - as TRES primeiras linhas do PROCEDURE Release
1117:     * legado, que a migracao tinha deixado de fora:
1118:     *     This.Grade.RecordSource          = []
1119:     *     This.Grade.Column1.ControlSource = []
1120:     *     This.Grade.Column2.ControlSource = []
1121:     *
1122:     * O legado solta o bind ANTES do "Use In LocalEmb", e a ordem eh o
1123:     * ponto: fechar o alias com a grade ainda apontando para ele deixa o
1124:     * Grid com RecordSource/ControlSource para um alias morto. Nao estoura
1125:     * no encerramento (medido - o cursor fecha sem erro), mas um Refresh
1126:     * que ainda chegue a grade nesse intervalo - repaint da janela a
1127:     * caminho, Destroy do pai, Timer - pinta a partir de alias inexistente.
1128:     * Soltar o bind primeiro eh o que o legado faz e custa tres linhas.
1129:     *
1130:     * Aqui o laco cobre as QUATRO colunas, nao as duas do legado: o SCX
1131:     * declarava ControlSource nas quatro (Qtds/Descs/PesoEmbs/Pesos) e
1132:     * limpava so duas, o que eh descuido do proprio legado e nao regra -
1133:     * deixar Column3/Column4 ligadas reproduziria o descuido sem
1134:     * reproduzir nenhum comportamento observavel.
1135:     *
1136:     * Idempotente e silencioso de proposito: roda no caminho de
1137:     * encerramento, onde um dialogo de erro nao tem a quem avisar e
1138:     * impediria o Destroy de concluir.
1139:     *--------------------------------------------------------------------------
1140:     PROTECTED PROCEDURE DesvincularGrade()
1141:         LOCAL loc_nCol, loc_oErro
1142: 
1143:         TRY
1144:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1145:                 FOR loc_nCol = 1 TO THIS.grd_4c_Dados.ColumnCount
1146:                     STORE "" TO ("THIS.grd_4c_Dados.Column" + ;
1147:                         TRANSFORM(loc_nCol) + ".ControlSource")
1148:                 ENDFOR
1149: 
1150:                 THIS.grd_4c_Dados.RecordSource = ""
1151:             ENDIF
1152:         CATCH TO loc_oErro
1153:             *-- Encerramento: nao ha a quem reportar, e insistir abortaria o
1154:             *-- fechamento dos cursores logo abaixo.
1155:         ENDTRY
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * FecharCursoresDoDialogo - "Use In LocalEmb" do PROCEDURE Release
1160:     * legado, estendido aos cursores auxiliares que o BO abre.
1161:     *
1162:     * Os nomes vem das PROPERTIES do BO, nao de literais repetidos aqui:
1163:     * o BO eh o dono da estrutura e o ponto unico de CREATE CURSOR desta
1164:     * tela (mesmo argumento de ObterAliasGrade). Com os literais
1165:     * duplicados, renomear um cursor no BO deixava este metodo fechando
1166:     * alias que nao existe mais e VAZANDO o que passou a existir - sem
1167:     * erro, sem log, e o vazamento so apareceria na proxima abertura, na
1168:     * forma de estrutura antiga reaproveitada.
1169:     *
1170:     * NAO fecha this_cCursorItensMov (crSigMvIte) nem
1171:     * this_cCursorItemCorrente (crTpmMvItn): esses dois sao do form PAI e
1172:     * so estao visiveis aqui por DataSession = 1. Fecha-los mataria a
1173:     * movimentacao em edicao do chamador - exatamente o que o legado nao
1174:     * faz (o Release dele toca unicamente em LocalEmb).
1175:     *
1176:     * Os literais entram SO como ultimo recurso (BO ja liberado quando o
1177:     * Destroy roda), para o cursor nao ficar aberto nesse caminho.
1178:     *--------------------------------------------------------------------------

