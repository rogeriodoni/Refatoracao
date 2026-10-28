# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PROTOCOLOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BANCOS, AGENCIAS, NCONTAS, NCHEQUES, _BUSCA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLSOURCE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BANCOS, AGENCIAS, NCONTAS, NCHEQUES, _BUSCA
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BANCOS, AGENCIAS, NCONTAS, NCHEQUES, _BUSCA

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
  ControlSource = "_ProcBco"
  ControlSource = "_ProcAge"
  ControlSource = "_ProcCon"
  ControlSource = "_ProcChe"
  ControlSource = "_ProcVen"
  ControlSource = "_ProcVal"
  ControlSource = "_ProcControle"
  ControlSource = "_ProcProtocolo"
  ControlSource = "_ProcArquivo"
Select crSigChe
		llOk = Seek( _Busca )
		llOk = Seek( _Busca )
		llOk = Seek( _Busca )
		llOk = Seek( _Busca )
		llOk = Seek( _Busca )
		llOk = Seek( _Busca )
		llOk=Seek( _PROCCONTROLE )
			llOk=Seek( CrChm.Nums )
		llOk=Seek( Trans( _ProcArquivo, '@L 999999' ) )
	lnErro = ThisForm.ParentForm.podatamgr.SqlExecute([Select * From SigChe Where ]+lcWher,'CrCheque')
		Select CrCheque
			Insert Into CrSigChe From Array Memvar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChb.prg) - TRECHOS RELEVANTES PARA PASS SQL (1308 linhas total):

*-- Linhas 17 a 35:
17: *   par_lLeitor   - Thisform.Leitor do legado: .T. quando o ultimo Valid do
18: *                   GetBanco decodificou com sucesso uma leitura do leitor
19: *   par_oOldForm  - Thisform.ParentForm do legado: form chamador, usado para
20: *                   SqlExecute/CursorQuery via ParentForm.PoDataMgr e para
21: *                   inserir o registro encontrado no cursor local CrSigChe
22: *                   do chamador
23: *
24: * FASE 4/8 (Grid + botoes CRUD da Page1): NAO APLICAVEL a este form. O dump
25: * do legado (SigOpChb_form_codigo_fonte.txt) nao tem PageFrame (raiz Class:
26: * form, sem BaseClass: pageframe), nao tem Grid/AddCursor/pColuna/Grade
27: * (nenhuma lista de registros) e os 9 campos de entrada (GetBanco/GetAgencia/
28: * GetConta/GetCheque/GetVencimento/GetValor/GetControle/GetProtocolo/
29: * GetArquivo, todos BaseClass: textbox) NAO sao ReadOnly - sao campos de
30: * digitacao, resolvidos pelo unico fluxo de busca do legado (Procura.Click).
31: * Nao ha "lista" para paginar (Page1) nem para CRUD (Incluir/Visualizar/
32: * Alterar/Excluir/Buscar): inventar PageFrame Lista/Dados com 6 botoes CRUD
33: * (ramo paginado) ou uma grade (ramo flat) aqui violaria o PILAR 1
34: * (fidelidade ao legado) e a regra "NUNCA inventar" - o dialogo inteiro cabe
35: * na estrutura flat da Fase 3. Grid/botoes CRUD ficam de fora deste form; os

*-- Linhas 48 a 71:
48: * Produto|Titulo>( - devolve ZERO ocorrencia: os nove criterios sao campos de
49: * DIGITACAO livre (numero de banco/agencia/conta/cheque, data, valor,
50: * controle, protocolo, arquivo), resolvidos pelo unico Procura.Click, que faz
51: * Seek no cursor local CrSigChe do chamador e, falhando, um Select em SigChe.
52: * Criar AbrirLookup*/AbrirBusca* aqui significaria INVENTAR tabela de lookup
53: * que o legado nunca consulta - proibido pelo PILAR 1 e pela regra "NUNCA
54: * inventar tabelas de lookup que nao existem no original" - e metodo vazio e
55: * proibido pela regra de completude. O que esta fase de fato entrega aqui:
56: * os 4 campos restantes (Valor/Controle/Protocolo/Arquivo), o ControlSource
57: * dos nove campos, os nove When() de exclusao mutua e os dois Valid do dump
58: * (GetBanco - leitor de codigo de barras; GetArquivo - reformatacao).
59: *
60: * FASE 8/8 (eventos auxiliares e consolidacao) - o que entra e o que NAO tem
61: * referente nesta tela.
62: *
63: * ENTREGUE nesta fase:
64: *   CarregarLista()    - executa a busca e popula cursor_4c_SigChe, o cursor
65: *                        de RESULTADO que o form chamador le (o CrSigChe do
66: *                        legado). PUBLIC: acionado por CmdProcuraClick e pelo
67: *                        harness TesteAutomatico.prg.
68: *   FormParaBO()       - le os nove criterios da tela para as propriedades de
69: *                        criterio do BO (os memvares _Proc* do legado).
70: *   BOParaForm()       - caminho inverso, fonte unica do sentido BO -> tela;
71: *                        usado por LimparCampos e pela decodificacao do

*-- Linhas 83 a 101:
83: *   BtnSalvarClick / BtnConfirmarClick - o dump NAO tem botao de gravar. Os
84: *       dois unicos CommandButton sao "Procura" (Picture
85: *       cadastro_procurar_60.jpg) e "btnCancela" (cadastro_cancelar_60.jpg);
86: *       nao existe Insert/Update/Delete contra tabela nenhuma - a unica
87: *       escrita do legado tem como alvo o CURSOR local CrSigChe. O botao de
88: *       acao desta tela e "Procurar", entregue em CmdProcuraClick().
89: *   BtnBuscarClick     - "Buscar" e o botao de filtro da pagina Lista do
90: *       frmcadastro. Esta tela INTEIRA e a busca; o verbo do legado e
91: *       "Procurar" e o handler leva esse nome.
92: *   BtnEncerrarClick   - nao ha botao "Encerrar"/"Sair" no dump; quem fecha e
93: *       o proprio Cancelar (Cancel = .T. responde ao ESC, como no legado).
94: *   HabilitarCampos    - os nove campos sao SEMPRE editaveis. A restricao que
95: *       o legado aplica e de FOCO, pelos nove When() (exclusao mutua entre os
96: *       grupos de criterio), ja transcritos em ValidarFocoCampo() - nenhum
97: *       Get* do dump declara ReadOnly ou Enabled = .F. Alternar .Enabled
98: *       acinzentaria campos que o legado mantem normais (PILAR 1).
99: *   AjustarBotoesPorModo / AlternarPagina - nao ha modo INCLUIR/ALTERAR/
100: *       VISUALIZAR/EXCLUIR nem PageFrame: o dump e um form flat (Class: form,
101: *       sem BaseClass: pageframe) sem pcEscolha, sem Grupo_Op e sem frmcadastro,

*-- Linhas 151 a 175:
151:     this_cOrdenar    = ""     && Thisform.Ordenar - propriedade customizada do legado (nao referenciada no codigo extraido)
152:     this_oParentForm = .NULL. && Thisform.ParentForm - form chamador (PoDataMgr + CrSigChe)
153: 
154:     *-- Criterios de busca. No legado cada Get* tem ControlSource apontando
155:     *-- para um memvar _Proc* criado pelo Store do Init (SIGOPCHB.Init:576-584)
156:     *-- e o Procura.Click LE EXCLUSIVAMENTE esses memvares (_ProcVen/_ProcVal/
157:     *-- _ProcBco/_ProcAge/_ProcCon/_ProcChe/_ProcControle/_ProcProtocolo/
158:     *-- _ProcArquivo) para montar a chave do Seek e o Where do SqlExecute.
159:     *-- Aqui os memvares viram propriedades do form (PILAR 3) e os TextBox
160:     *-- continuam ligados por ControlSource = "ThisForm.<prop>", preservando
161:     *-- a semantica do legado: digitar no campo atualiza a propriedade, e a
162:     *-- busca le a propriedade. O TIPO de cada uma reproduz o Store legado.
163:     this_cProcBco       = ""   && _ProcBco       - Space(03)
164:     this_cProcAge       = ""   && _ProcAge       - Space(04)
165:     this_cProcCon       = ""   && _ProcCon       - Space(10)
166:     this_cProcChe       = ""   && _ProcChe       - Space(06)
167:     this_dProcVen       = {}   && _ProcVen       - { / / }
168:     this_nProcVal       = 0    && _ProcVal       - 0
169:     this_cProcControle  = ""   && _ProcControle  - Space(08)
170:     this_cProcProtocolo = ""   && _ProcProtocolo - Space(08)
171:     this_cProcArquivo   = ""   && _ProcArquivo   - Space(06)
172: 
173:     *==================================================================
174:     * Init - Armazena parametros antes de DODEFAULT (que chama InicializarForm)
175:     *==================================================================

*-- Linhas 350 a 368:
350:     * recebe InputMask aqui.
351:     *
352:     * .Value reproduz o tipo que o Init do legado atribui a cada campo
353:     * (ThisForm.Get*.Value = ...) e o memvar do ControlSource:
354:     *   _ProcBco = Space(03) / _ProcAge = Space(04) / _ProcCon = Space(10)
355:     *   _ProcChe = Space(06) / _ProcVen = { / / }  (DATE)
356:     * MaxLength vem do tamanho desses mesmos memvares - nao ha coluna de
357:     * banco associada a estes campos de criterio de busca.
358:     *==================================================================
359:     PROTECTED PROCEDURE ConfigurarCamposBusca1()
360: 
361:         *-- Banco (Say "Banco :" + GetBanco, TabIndex 1/2 do legado)
362:         THIS.AddObject("lbl_4c_Banco", "Label")
363:         WITH THIS.lbl_4c_Banco
364:             .Top       = 110
365:             .Left      = 127
366:             .Width     = 38
367:             .Height    = 15
368:             .Alignment = 0

*-- Linhas 389 a 407:
389:             .FontSize      = 8
390:             .ForeColor     = RGB(0, 0, 0)
391:             .TabIndex      = 2
392:             .ControlSource  = "ThisForm.this_cProcBco"
393:             .this_cGrupoWhen = "BANCO"
394:             .Visible       = .T.
395:         ENDWITH
396: 
397:         *-- Agencia (Say "Agencia :" + GetAgencia, TabIndex 3/4 do legado)
398:         THIS.AddObject("lbl_4c_Agencia", "Label")
399:         WITH THIS.lbl_4c_Agencia
400:             .Top       = 134
401:             .Left      = 118
402:             .Width     = 47
403:             .Height    = 15
404:             .Alignment = 0
405:             .BackStyle = 0
406:             .AutoSize  = .F.
407:             .FontName  = "Tahoma"

*-- Linhas 425 a 443:
425:             .FontSize      = 8
426:             .ForeColor     = RGB(0, 0, 0)
427:             .TabIndex      = 4
428:             .ControlSource  = "ThisForm.this_cProcAge"
429:             .this_cGrupoWhen = "AGENCIA"
430:             .Visible       = .T.
431:         ENDWITH
432: 
433:         *-- Conta (Say "Conta :" + GetConta, TabIndex 5/6 do legado)
434:         THIS.AddObject("lbl_4c_Conta", "Label")
435:         WITH THIS.lbl_4c_Conta
436:             .Top       = 158
437:             .Left      = 127
438:             .Width     = 38
439:             .Height    = 15
440:             .Alignment = 0
441:             .BackStyle = 0
442:             .AutoSize  = .F.
443:             .FontName  = "Tahoma"

*-- Linhas 461 a 479:
461:             .FontSize      = 8
462:             .ForeColor     = RGB(0, 0, 0)
463:             .TabIndex      = 6
464:             .ControlSource  = "ThisForm.this_cProcCon"
465:             .this_cGrupoWhen = "CONTA"
466:             .Visible       = .T.
467:         ENDWITH
468: 
469:         *-- Cheque (Say "Cheque :" + GetCheque, TabIndex 7/8 do legado)
470:         THIS.AddObject("lbl_4c_Cheque", "Label")
471:         WITH THIS.lbl_4c_Cheque
472:             .Top       = 182
473:             .Left      = 119
474:             .Width     = 46
475:             .Height    = 15
476:             .Alignment = 0
477:             .BackStyle = 0
478:             .AutoSize  = .F.
479:             .FontName  = "Tahoma"

*-- Linhas 497 a 523:
497:             .FontSize      = 8
498:             .ForeColor     = RGB(0, 0, 0)
499:             .TabIndex      = 8
500:             .ControlSource  = "ThisForm.this_cProcChe"
501:             .this_cGrupoWhen = "CHEQUE"
502:             .Visible       = .T.
503:         ENDWITH
504: 
505:         *-- Vencimento (Say3 "Vencimento :" + GetVencimento, TabIndex 9/10
506:         *-- do legado). Campo DATE: o Init do legado faz
507:         *-- ThisForm.GetVencimento.Value = { / / } e o memvar do
508:         *-- ControlSource e' _ProcVen = { / / }. Sem InputMask (o dump
509:         *-- declara InputMask = "", override vazio) e sem MaxLength
510:         *-- (nao se aplica a campo de data).
511:         THIS.AddObject("lbl_4c_Label3", "Label")
512:         WITH THIS.lbl_4c_Label3
513:             .Top       = 110
514:             .Left      = 243
515:             .Width     = 64
516:             .Height    = 15
517:             .Alignment = 0
518:             .BackStyle = 0
519:             .AutoSize  = .F.
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .ForeColor = RGB(90, 90, 90)
523:             .Caption   = "Vencimento :"

*-- Linhas 536 a 554:
536:             .FontSize      = 8
537:             .ForeColor     = RGB(0, 0, 0)
538:             .TabIndex      = 10
539:             .ControlSource  = "ThisForm.this_dProcVen"
540:             .this_cGrupoWhen = "VENCIMENTO"
541:             .Visible       = .T.
542:         ENDWITH
543:     ENDPROC
544: 
545:     *==================================================================
546:     * ConfigurarCamposBusca2 - SEGUNDA METADE dos campos de busca (os 4
547:     * restantes, na ordem de TabIndex do SCX): GetValor (grupo da direita,
548:     * continuacao de shp_4c_Shape2) / GetControle / GetProtocolo /
549:     * GetArquivo (abaixo de shp_4c_Shape1/shp_4c_Shape2, soltos no form,
550:     * exatamente como no dump - Left=309 continua a coluna da direita).
551:     *
552:     * .Value reproduz o estado final que o Init do legado deixa em cada
553:     * campo (a ultima atribuicao ThisForm.Get*.Value = ... sobrescreve o
554:     * Store nos memvars _Proc*): GetValor.Value=0, GetControle.Value=''

*-- Linhas 588 a 606:
588:             .FontSize      = 8
589:             .ForeColor     = RGB(0, 0, 0)
590:             .TabIndex      = 12
591:             .ControlSource  = "ThisForm.this_nProcVal"
592:             .this_cGrupoWhen = "VALOR"
593:             .Visible       = .T.
594:         ENDWITH
595: 
596:         *-- Controle (Say1 "Controle :" + GetControle, TabIndex 13/14)
597:         THIS.AddObject("lbl_4c_Label1", "Label")
598:         WITH THIS.lbl_4c_Label1
599:             .Top       = 158
600:             .Left      = 257
601:             .Width     = 50
602:             .Height    = 15
603:             .Alignment = 0
604:             .BackStyle = 0
605:             .AutoSize  = .F.
606:             .FontName  = "Tahoma"

*-- Linhas 622 a 640:
622:             .FontSize      = 8
623:             .ForeColor     = RGB(0, 0, 0)
624:             .TabIndex      = 14
625:             .ControlSource  = "ThisForm.this_cProcControle"
626:             .this_cGrupoWhen = "CONTROLE"
627:             .Visible       = .T.
628:         ENDWITH
629: 
630:         *-- Protocolo (Say2 "Protocolo :" + GetProtocolo, TabIndex 15/16)
631:         THIS.AddObject("lbl_4c_Label2", "Label")
632:         WITH THIS.lbl_4c_Label2
633:             .Top       = 182
634:             .Left      = 253
635:             .Width     = 54
636:             .Height    = 15
637:             .Alignment = 0
638:             .BackStyle = 0
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"

*-- Linhas 656 a 674:
656:             .FontSize      = 8
657:             .ForeColor     = RGB(0, 0, 0)
658:             .TabIndex      = 16
659:             .ControlSource  = "ThisForm.this_cProcProtocolo"
660:             .this_cGrupoWhen = "PROTOCOLO"
661:             .Visible       = .T.
662:         ENDWITH
663: 
664:         *-- Arquivo (Say5 "Arquivo :" + GetArquivo, TabIndex 17/18)
665:         THIS.AddObject("lbl_4c_Label5", "Label")
666:         WITH THIS.lbl_4c_Label5
667:             .Top       = 208
668:             .Left      = 261
669:             .Width     = 46
670:             .Height    = 15
671:             .Alignment = 0
672:             .BackStyle = 0
673:             .AutoSize  = .F.
674:             .FontName  = "Tahoma"

*-- Linhas 692 a 748:
692:             .FontSize      = 8
693:             .ForeColor     = RGB(0, 0, 0)
694:             .TabIndex      = 18
695:             .ControlSource  = "ThisForm.this_cProcArquivo"
696:             .this_cGrupoWhen = "ARQUIVO"
697:             .Visible       = .T.
698:         ENDWITH
699:     ENDPROC
700: 
701:     *==================================================================
702:     * InicializarCriteriosBusca - Transcricao literal do bloco Store do
703:     * Init legado (SIGOPCHB.Init:576-584), que CRIA os memvares ligados
704:     * por ControlSource aos nove Get*. Aqui eles sao propriedades do
705:     * form, entao o Store vira atribuicao - os TAMANHOS e os TIPOS sao
706:     * os do legado, nao estimativa:
707:     *
708:     *   Store Space(03) To _ProcBco        Store Space(04) To _ProcAge
709:     *   Store Space(10) To _ProcCon        Store Space(06) To _ProcChe
710:     *   Store { / / }   To _ProcVen        Store 0         To _ProcVal
711:     *   Store Space(08) To _ProcControle   Store Space(08) To _ProcProtocolo
712:     *   Store Space(6)  To _ProcArquivo
713:     *
714:     * Roda ANTES de ConfigurarCamposBusca1/2 porque o ControlSource de
715:     * cada TextBox exige a propriedade ja existente e com o tipo certo.
716:     *==================================================================
717:     PROTECTED PROCEDURE InicializarCriteriosBusca()
718:         THIS.this_cProcBco       = SPACE(3)
719:         THIS.this_cProcAge       = SPACE(4)
720:         THIS.this_cProcCon       = SPACE(10)
721:         THIS.this_cProcChe       = SPACE(6)
722:         THIS.this_dProcVen       = {}
723:         THIS.this_nProcVal       = 0
724:         THIS.this_cProcControle  = SPACE(8)
725:         THIS.this_cProcProtocolo = SPACE(8)
726:         THIS.this_cProcArquivo   = SPACE(6)
727:     ENDPROC
728: 
729:     *==================================================================
730:     * AplicarValoresIniciaisBusca - Transcricao literal das NOVE ultimas
731:     * atribuicoes do Init legado (SIGOPCHB.Init:586-594), que rodam
732:     * DEPOIS do Store e sobrescrevem os memvares atraves do
733:     * ControlSource de cada campo:
734:     *
735:     *   ThisForm.GetBanco.Value      = ''   GetAgencia.Value   = ''
736:     *   ThisForm.GetConta.Value      = ''   GetCheque.Value    = ''
737:     *   ThisForm.GetVencimento.Value = { / / }
738:     *   ThisForm.GetValor.Value      = 0    GetControle.Value  = ''
739:     *   ThisForm.GetProtocolo.Value  = ''   GetArquivo.Value   = Space(6)
740:     *
741:     * A ORDEM importa e e a do legado: Store primeiro, campos depois -
742:     * por isso Banco/Agencia/Conta/Cheque/Controle/Protocolo terminam
743:     * VAZIOS (e nao com o Space(N) do Store) e so Arquivo fica com
744:     * Space(6). Reproduzir so o Store deixaria o estado inicial errado.
745:     *
746:     * O corpo mora em LimparCampos() porque o estado inicial do legado E o
747:     * estado "limpo" desta tela sao o MESMO estado, e existe um segundo
748:     * caminho que precisa dele: o legado criava um form NOVO a cada

*-- Linhas 793 a 821:
793:     * propriedades de criterio do BO (this_cBanco/this_cAgencia/
794:     * this_cConta/this_cCheque/this_dVencimento/this_nValor/
795:     * this_cControle/this_cProtocolo/this_cArquivo). No legado esse papel
796:     * era dos memvares _Proc* ligados por ControlSource, lidos
797:     * diretamente pelo Procura.Click; aqui a leitura da tela acontece
798:     * UMA vez, neste metodo, e a busca (CarregarLista) le exclusivamente
799:     * o BO - assim nao ha duas fontes para o mesmo criterio.
800:     *
801:     * Vencimento passa por ConverterParaData porque o .Value do TextBox
802:     * nasce DATE (atribuido {} no LimparCampos) e um registro carregado
803:     * do SQL Server chega DATETIME - TTOD() nao aceita DATE (regra #16).
804:     * Valor confere o VARTYPE antes de atribuir: TextBox com InputMask
805:     * numerica pode devolver Caractere se algo escrever texto nele, e
806:     * this_nValor alimenta FormatarNumeroSQL no BO.
807:     *==================================================================
808:     PROTECTED FUNCTION FormParaBO()
809:         LOCAL loc_lSucesso, loc_oBO
810:         loc_lSucesso = .F.
811: 
812:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
813:             MsgErro("Business Object indispon" + CHR(237) + "vel - n" + CHR(227) + ;
814:                 "o foi poss" + CHR(237) + "vel ler os crit" + CHR(233) + "rios da tela.", ;
815:                 "FormSigOpChb.FormParaBO")
816:         ELSE
817:             loc_oBO = THIS.this_oBusinessObject
818: 
819:             loc_oBO.this_cBanco      = THIS.txt_4c_Banco.Value
820:             loc_oBO.this_cAgencia    = THIS.txt_4c_Agencia.Value
821:             loc_oBO.this_cConta      = THIS.txt_4c_Conta.Value

*-- Linhas 988 a 1043:
988:     * chamador. No legado essa lista e o cursor CrSigChe do form PAI,
989:     * alimentado pelo proprio Procura.Click:
990:     *
991:     *   lnErro = ThisForm.ParentForm.podatamgr.SqlExecute(
992:     *                [Select * From SigChe Where ]+lcWher,'CrCheque')
993:     *   If lnErro > 0
994:     *       Select CrCheque
995:     *       Scan
996:     *           Scatter to Memvar Memo
997:     *           Insert Into CrSigChe From Array Memvar
998:     *       EndScan
999:     *   Endif
1000:     *
1001:     * Nao ha Grid nesta tela (o dump do legado nao tem BaseClass: grid
1002:     * nem AddCursor/pColuna/RecordSource) - a "lista" e o conjunto de
1003:     * registros de SigChe, e quem a exibe e a grade do form chamador,
1004:     * que le cursor_4c_SigChe depois que o dialogo fecha (ver
1005:     * FecharDialogo, que usa Hide() justamente para o cursor sobreviver).
1006:     *
1007:     * Divergencias deliberadas em relacao ao literal do legado, as duas
1008:     * documentadas no proprio BO (SigOpChbBO.BuscarCheque):
1009:     *   - o SELECT roda pela conexao do sistema novo (gnConnHandle,
1010:     *     dentro do BO) e nao por ParentForm.podatamgr.SqlExecute;
1011:     *   - a insercao descarta duplicata pela PK (Nums) no lugar do Seek
1012:     *     local que o legado fazia em CrSigChe antes de ir ao banco - o
1013:     *     conjunto final de cheques na lista e o mesmo.
1014:     *
1015:     * Retorna .T. quando a busca pode ser executada (inclusive com ZERO
1016:     * linhas - criterio sem nenhum cheque e resposta valida, nao erro) e
1017:     * .F. so quando o SQL falhou ou a leitura da tela nao foi possivel.
1018:     *==================================================================
1019:     PROCEDURE CarregarLista()
1020:         LOCAL loc_lSucesso, loc_nResultado, loc_cNums, loc_oBO, loc_oErro
1021:         loc_lSucesso = .F.
1022: 
1023:         TRY
1024:             IF !THIS.FormParaBO()
1025:                 *-- FormParaBO ja exibiu o motivo
1026:             ELSE
1027:                 *-- Fecha o cursor temporario de uma busca anterior ANTES do
1028:                 *-- SQLEXEC do BO. O guard pelo Buffering e obrigatorio:
1029:                 *-- TABLEREVERT sobre cursor sem buffering dispara erro 1586
1030:                 *-- (regra #52), e USE IN fecha o alias mesmo com buffer sujo.
1031:                 IF USED("cursor_4c_SigCheTmp")
1032:                     IF CURSORGETPROP("Buffering", "cursor_4c_SigCheTmp") > 1
1033:                         TABLEREVERT(.T., "cursor_4c_SigCheTmp")
1034:                     ENDIF
1035:                     USE IN cursor_4c_SigCheTmp
1036:                 ENDIF
1037: 
1038:                 loc_oBO = THIS.this_oBusinessObject
1039: 
1040:                 loc_nResultado = loc_oBO.BuscarCheque( ;
1041:                     ALLTRIM(loc_oBO.this_cBanco), ALLTRIM(loc_oBO.this_cAgencia), ;
1042:                     ALLTRIM(loc_oBO.this_cConta), ALLTRIM(loc_oBO.this_cCheque), ;
1043:                     loc_oBO.this_dVencimento, loc_oBO.this_nValor, ;

*-- Linhas 1050 a 1087:
1050:                 ELSE
1051:                     IF loc_nResultado > 0 AND USED("cursor_4c_SigCheTmp")
1052:                         IF !USED("cursor_4c_SigChe")
1053:                             SELECT * FROM cursor_4c_SigCheTmp ;
1054:                                 INTO CURSOR cursor_4c_SigChe READWRITE
1055:                         ELSE
1056:                             SELECT cursor_4c_SigCheTmp
1057:                             SCAN
1058:                                 loc_cNums = Nums
1059:                                 SELECT cursor_4c_SigChe
1060:                                 LOCATE FOR Nums = loc_cNums
1061:                                 IF !FOUND()
1062:                                     SELECT cursor_4c_SigCheTmp
1063:                                     SCATTER MEMVAR MEMO
1064:                                     INSERT INTO cursor_4c_SigChe FROM MEMVAR
1065:                                 ENDIF
1066:                                 SELECT cursor_4c_SigCheTmp
1067:                             ENDSCAN
1068:                         ENDIF
1069:                     ENDIF
1070: 
1071:                     IF USED("cursor_4c_SigChe")
1072:                         SELECT cursor_4c_SigChe
1073:                         GO TOP
1074:                     ENDIF
1075: 
1076:                     loc_lSucesso = .T.
1077:                 ENDIF
1078: 
1079:                 IF USED("cursor_4c_SigCheTmp")
1080:                     USE IN cursor_4c_SigCheTmp
1081:                 ENDIF
1082:             ENDIF
1083:         CATCH TO loc_oErro
1084:             MsgErro(loc_oErro.Message + CHR(13) + ;
1085:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1086:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpChb.CarregarLista")
1087:         ENDTRY


### BO (C:\4c\projeto\app\classes\SigOpChbBO.prg):
*====================================================================
* SigOpChbBO.prg
*
* Business Object para o dialogo "Procurar Cheque" (SIGOPCHB)
* Tabela pesquisada: SigChe (busca por Vencimento/Banco/Agencia/
* Conta/Cheque/Controle/Protocolo/Arquivo - PK: nums)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpChbBO AS BusinessBase

    *-- Propriedades de criterio de busca (mapeamento para tabela SigChe)
    this_cBanco       = ""    && bancos    char(3)  - criterio Banco
    this_cAgencia     = ""    && agencias  char(4)  - criterio Agencia
    this_cConta       = ""    && ncontas   char(10) - criterio Conta (legado usa nContas no WHERE, nao contas)
    this_cCheque      = ""    && ncheques  char(6)  - criterio N. Cheque
    this_dVencimento  = {}    && vencs     datetime - criterio Vencimento
    this_nValor       = 0     && valors    numeric(11,2) - criterio Valor
    this_cControle    = ""    && nums      char(8)  - criterio Controle (chave unica)
    this_cProtocolo   = ""    && protocolos char(8) - criterio Protocolo (via SigCqChm)
    this_cArquivo     = ""    && numeros   char(6)  - criterio Arquivo (numero sequencial de leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChe"
            THIS.this_cCampoChave = "nums"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpChbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega os criterios de busca a partir de um
    * registro de SigChe (usado ao reabrir o dialogo com um cheque ja
    * localizado, para repopular os campos de pesquisa)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cBanco      = TratarNulo(bancos, "")
        THIS.this_cAgencia    = TratarNulo(agencias, "")
        THIS.this_cConta      = TratarNulo(ncontas, "")
        THIS.this_cCheque     = TratarNulo(ncheques, "")
        THIS.this_dVencimento = ConverterParaData(vencs)
        THIS.this_nValor      = TratarNulo(valors, 0)
        THIS.this_cControle   = TratarNulo(nums, "")
        THIS.this_cProtocolo  = TratarNulo(protocolos, "")
        THIS.this_cArquivo    = TratarNulo(numeros, "")

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna o valor da chave primaria (nums)
    * para uso em RegistrarAuditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cControle
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * O dialogo legado SIGOPCHB (Procura.Click) so executa SEEK no cursor
    * local crSigChe e, na falha, um SELECT via SqlExecute cujo resultado
    * eh copiado (Insert Into CrSigChe From Array Memvar) para o CURSOR
    * local do form pai - nunca ha INSERT/UPDATE/DELETE contra a tabela
    * SigChe no legado. O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto para este BO somente-leitura.
    *====================================================================

    *====================================================================
    * BuscarCheque - Transcricao da logica de busca do Procura.Click do
    * legado (SIGOPCHB.Procura.Click): monta o WHERE pela PRIMEIRA
    * condicao preenchida, na MESMA ordem de prioridade do Do Case legado
    * (Vencimento > Valor > Banco > Agencia > Conta > Cheque > Controle >
    * Protocolo > Arquivo), e devolve em par_cCursorDestino as linhas de
    * SigChe que casam (equivalente ao "Select * From SigChe Where
    * <lcWher>" seguido do Scan/Insert Into CrSigChe do legado - aqui o
    * Scatter/Insert fica a cargo do form, que mescla o resultado em
    * cursor_4c_SigChe).
    *
    * O legado faz Seek LOCAL em crSigChe antes de ir ao banco (evita
    * reconsultar o que ja estava no cursor do form pai). Esta migracao
    * nao reproduz esse Seek: o form nao tem como compartilhar o cursor
    * do chamador por nome (THIS dialogo fecha com Hide(), nao Release() -
    * ver FormSigOpChb.FecharDialogo - e devolve o resultado so pelo
    * cursor_4c_SigChe que ele mesmo mantem). O form, ao mesclar o
    * resultado desta busca em cursor_4c_SigChe, descarta duplicata pela
    * PK (Nums) - o estado final (quais cheques entram na lista) eh o
    * mesmo; muda so que uma nova busca pode reconsultar o banco por um
    * cheque ja encontrado antes, dentro do MESMO dialogo aberto.
    *
    * Retorna o numero de linhas encontradas (>=0) ou -1 em erro SQL. Se
    * TODOS os criterios estiverem vazios, retorna 0 sem consultar o
    * banco (fiel ao Do Case sem Case casado do legado, que nao executa
    * SqlExecute nenhum).
    *====================================================================
    PROCEDURE BuscarCheque(par_cBanco, par_cAgencia, par_cConta, par_cCheque, ;
            par_dVencimento, par_nValor, par_cControle, par_cProtocolo, ;
            par_cArquivo, par_cCursorDestino)
        LOCAL loc_cWhere, loc_nResultado, loc_cNumsProtocolo

        loc_cWhere     = ""
        loc_nResultado = 0

        DO CASE
        CASE !EMPTY(par_dVencimento)
            loc_cWhere = "Vencs = " + FormatarDataSQL(par_dVencimento)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_nValor)
            loc_cWhere = "Valors = " + FormatarNumeroSQL(par_nValor, 2)
            IF !EMPTY(par_cBanco)
                loc_cWhere = loc_cWhere + " AND Bancos = " + EscaparSQL(par_cBanco)
            ENDIF
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cBanco)
            loc_cWhere = "Bancos = " + EscaparSQL(par_cBanco)
            IF !EMPTY(par_cAgencia)
                loc_cWhere = loc_cWhere + " AND Agencias = " + EscaparSQL(par_cAgencia)
            ENDIF
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cAgencia)
            loc_cWhere = "Agencias = " + EscaparSQL(par_cAgencia)
            IF !EMPTY(par_cConta)
                loc_cWhere = loc_cWhere + " AND nContas = " + EscaparSQL(par_cConta)
            ENDIF
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cConta)
            loc_cWhere = "nContas = " + EscaparSQL(par_cConta)
            IF !EMPTY(par_cCheque)
                loc_cWhere = loc_cWhere + " AND nCheques = " + EscaparSQL(par_cCheque)
            ENDIF

        CASE !EMPTY(par_cCheque)
            loc_cWhere = "nCheques = " + EscaparSQL(par_cCheque)

        CASE !EMPTY(par_cControle)
            loc_cWhere = "Nums = " + EscaparSQL(par_cControle)

        CASE !EMPTY(par_cProtocolo)
            loc_cNumsProtocolo = THIS.BuscarNumsPorProtocolo(par_cProtocolo)
            IF !EMPTY(loc_cNumsProtocolo)
                loc_cWhere = "Nums = " + EscaparSQL(loc_cNumsProtocolo)
            ENDIF

        CASE !EMPTY(par_cArquivo)
            loc_cWhere = "Numeros = " + EscaparSQL(TRANSFORM(VAL(par_cArquivo), "@L 999999"))
        ENDCASE

        IF !EMPTY(loc_cWhere)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigChe WHERE " + loc_cWhere, par_cCursorDestino)
            IF loc_nResultado < 0
                MsgErro(CapturarErroSQL(), "SigOpChbBO.BuscarCheque")
                RETURN -1
            ENDIF
        ENDIF

        RETURN loc_nResultado
    ENDPROC

    *====================================================================
    * BuscarNumsPorProtocolo - Transcricao do trecho do criterio Protocolo
    * no Procura.Click legado: ThisForm.Parentform.Podatamgr.CursorQuery(
    * 'SigCqChm','CrChm','Protocolos', Trans(Val(_ProcProtocolo),
    * '@L 99999999')) - localiza, em SigCqChm, o Nums do cheque associado
    * aquele protocolo formatado.
    *====================================================================
    PROTECTED PROCEDURE BuscarNumsPorProtocolo(par_cProtocolo)
        LOCAL loc_cProtocoloFmt, loc_nResultado, loc_cNums

        loc_cProtocoloFmt = TRANSFORM(VAL(par_cProtocolo), "@L 99999999")
        loc_cNums         = ""

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Nums FROM SigCqChm WHERE Protocolos = " + EscaparSQL(loc_cProtocoloFmt), ;
            "cursor_4c_SigCqChmTmp")

        IF loc_nResultado > 0
            SELECT cursor_4c_SigCqChmTmp
            GO TOP
            loc_cNums = TratarNulo(Nums, "")
        ENDIF

        IF USED("cursor_4c_SigCqChmTmp")
            USE IN cursor_4c_SigCqChmTmp
        ENDIF

        RETURN loc_cNums
    ENDPROC

ENDDEFINE

