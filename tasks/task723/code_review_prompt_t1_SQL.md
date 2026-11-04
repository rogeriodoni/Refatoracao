# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FKCHAVES

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
  ControlSource = "crSigOpArq.ObsArqs"
  DeleteMark = .F.
  ControlSource = "crSigOpArq.Datas"
  ControlSource = "crSigOpArq.Usuars"
If Not ThisForm.poDataMgr.Update([crSigOpArq])
	=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigOpArq)])
lcQryOpArq = [Select * From SigOpArq Where fkChaves = '] + Padr(pKey, 30) + [']
		Select crSigOpArq
		Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])
			.DeleteMark             = .f.
			.Column1.ControlSource  = [crSigOpArq.Arquivos]
	Insert Into crSigOpArq (fkChaves, pkChaves, Arquivos, ObsArqs, Usuars, Datas) ;
	Delete In crSigOpArq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDoc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1417 linhas total):

*-- Linhas 39 a 81:
39: * SalvarDados(). O legado liga crSigOpArq a um cursor COM BUFFERING
40: * (.poDataMgr.AddCursor) - btnInsArqs/btnExcArqs so editam o buffer local, e
41: * salvardados() eh quem de fato grava tudo no SQL Server
42: * (.poDataMgr.Update/.Commit, com .RollBack() se falhar). Na arquitetura
43: * nova esse buffering nao existe: BtnInsArqsClick/BtnExcArqsClick ja gravam
44: * direto via BO.Inserir()/BO.Excluir() (fase 4). O que ainda exigia
45: * confirmacao explicita era a edicao do campo Observacao
46: * (obj_4c_GetObsArqs, ligado a cursor_4c_Dados - cursor LOCAL/desconectado
47: * do servidor): SalvarDados() varre esse cursor e empurra cada linha para
48: * SigOpArq via BO.Atualizar(), que eh o equivalente funcional do
49: * Update()/Commit() do legado para este form.
50: * FASE 8/8 - Consolidacao: os hooks de transferencia Form<->BO (FormParaBO/
51: * BOParaForm), o controle unico da superficie editavel (HabilitarCampos), a
52: * limpeza do painel de detalhe (LimparCampos) e o nome canonico do botao de
53: * cancelar (BtnCancelarClick, que eh o btnSair Cancel=.T. do SCX).
54: *
55: * Dois defeitos de parida de funcional foram corrigidos aqui, ambos silenciosos:
56: *
57: * 1) cursor_4c_Dados chegava SOMENTE-LEITURA. O EditBox de observacao
58: *    (obj_4c_GetObsArqs) esta ligado a ele por ControlSource, e cursor de
59: *    SQLEXEC nasce read-only - o campo nao aceitava uma tecla e SalvarDados
60: *    nunca teria o que gravar, sem erro nenhum na tela (medido no VFP9:
61: *    REPLACE em cursor assim estoura erro 111 "Cannot update the cursor ...,
62: *    since it is read-only"). O legado liga crSigOpArq por .AddCursor, cursor
63: *    COM buffering e gravavel - a prova esta no proprio Init legado, que faz
64: *    "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])". Conserto em
65: *    SigOpDocBO.Buscar: SQLEXEC vai para alias temporario e o alias da grade
66: *    eh recriado com SELECT ... INTO CURSOR ... READWRITE.
67: *
68: * 2) A normalizacao "Set ObsArqs = Nvl(ObsArqs, [])" do Init legado nao tinha
69: *    sido migrada: coluna TEXT nula chega ao EditBox como .NULL. e eh isso que
70: *    o usuario le na tela (mesma familia do mRetiraNull do legado). Agora
71: *    acontece no BO.Buscar (todas as linhas) e em BOParaForm (linha corrente).
72: *==============================================================================
73: 
74: DEFINE CLASS FormSigOpDoc AS FormBase
75: 
76:     *--------------------------------------------------------------------------
77:     * Propriedades visuais do form (copiadas do SIGOPDOC.SCX - PILAR 1)
78:     *--------------------------------------------------------------------------
79:     Width        = 1000
80:     Height       = 640
81:     AutoCenter   = .T.

*-- Linhas 232 a 262:
232:     *==========================================================================
233:     * ConfigurarGrid - Grade de arquivos vinculados (grdArquivos legado).
234:     * grd_4c_Dados: Top=96 Left=5 Width=810 Height=288, 1 coluna (Arquivos).
235:     * RecordMark/DeleteMark = .F. (regra de form OPERACIONAL). ControlSource/
236:     * Header1.Caption/Width sao definidos em CarregarLista() (DEPOIS do
237:     * RecordSource - Problema 2/48, RecordSource reseta ambos).
238:     *==========================================================================
239:     PROTECTED PROCEDURE ConfigurarGrid()
240:         THIS.AddObject("grd_4c_Dados", "Grid")
241:         WITH THIS.grd_4c_Dados
242:             .Top             = 96
243:             .Left            = 5
244:             .Width           = 810
245:             .Height          = 288
246:             .FontName        = "Arial"
247:             .DeleteMark      = .F.
248:             .RecordMark      = .F.
249:             .ReadOnly        = .T.
250:             .ScrollBars      = 2
251:             .ColumnCount     = 1
252:             .GridLineColor   = RGB(238, 238, 238)
253:             .HighlightBackColor = RGB(255, 255, 255)
254:             .HighlightForeColor = RGB(15, 41, 104)
255:             .HighlightStyle  = 2
256:             .Visible         = .T.
257:         ENDWITH
258: 
259:         WITH THIS.grd_4c_Dados.Column1
260:             .FontName   = "Verdana"
261:             .FontSize   = 8
262:             .Enabled    = .T.

*-- Linhas 535 a 558:
535:     * img_4c_ImgArqJpg: Top=394 Left=10 Width=391 Height=227, Visible=.F. -
536:     * so aparece quando a linha corrente da grade aponta para .jpg/.ico/.bmp/
537:     * .jpeg (grdArquivos.AfterRowColChange legado, fase 7/8). Picture NAO eh
538:     * ControlSource - eh atribuido em codigo a cada troca de linha.
539:     * lbl_4c_Label31 (Say31): Top=391 Left=411 - classe say sem Width/
540:     * Alignment no dump -> AutoSize=.F. + ForeColor=RGB(90,90,90) (regra #12/
541:     * #23, NUNCA inventar Width+Alignment=1).
542:     * obj_4c_GetObsArqs (getObsArqs/fwmemo): Top=407 Left=411 Width=580
543:     * Height=181, ControlSource=cursor_4c_Dados.ObsArqs (coluna TEXT/memo).
544:     * ReadOnly inicial=.T., alternado em AjustarBotoesPorModo junto com os
545:     * botoes de manutencao (legado: getObsArqs.When = InList(pcEscolha,
546:     * "INSERIR","ALTERAR")).
547:     *==========================================================================
548:     PROTECTED PROCEDURE ConfigurarPainelObservacao()
549:         THIS.AddObject("shp_4c_Shape1", "Shape")
550:         WITH THIS.shp_4c_Shape1
551:             .Top           = 392
552:             .Left          = 8
553:             .Width         = 395
554:             .Height        = 231
555:             .BackStyle     = 0
556:             .BorderStyle   = 0
557:             .BorderWidth   = 1
558:             .SpecialEffect = 1

*-- Linhas 606 a 639:
606:             .ScrollBars   = 2
607:             .Visible      = .T.
608:         ENDWITH
609:         *-- ControlSource NAO vai aqui: este metodo roda ANTES de CarregarLista
610:         *-- criar cursor_4c_Dados, e ligar ControlSource a alias inexistente
611:         *-- estoura "Alias 'CURSOR_4C_DADOS' is not found" dentro do TRY do
612:         *-- InicializarForm - CREATEOBJECT devolveria .F. e a tela nunca
613:         *-- abriria (regra #41). O vinculo mora em VincularCamposDetalhe(),
614:         *-- chamado por CarregarLista com o cursor ja existente.
615:     ENDPROC
616: 
617:     *==========================================================================
618:     * ConfigurarCamposAuditoria - Campos somente-leitura de quem/quando o
619:     * vinculo foi incluido (getUsuars/getDatas legado). Enabled=.F. SEMPRE
620:     * (legado: getUsuars.When/getDatas.When = Return .f. - nao alterna por
621:     * modo como getObsArqs, por isso NAO entram em AjustarBotoesPorModo).
622:     * txt_4c_Usuars (getUsuars): Top=595 Left=535 Width=130, ControlSource=
623:     * cursor_4c_Dados.Usuars.
624:     * txt_4c_Datas (getDatas): Top=595 Left=772 Width=143, ControlSource=
625:     * cursor_4c_Dados.Datas.
626:     * lbl_4c_Label1 (Say1) / lbl_4c_Label2 (Say2): classes say com Width no
627:     * dump -> AutoSize=.F. + Alignment=0 (regra #23), ForeColor=RGB(90,90,90).
628:     *==========================================================================
629:     PROTECTED PROCEDURE ConfigurarCamposAuditoria()
630:         THIS.AddObject("lbl_4c_Label1", "Label")
631:         WITH THIS.lbl_4c_Label1
632:             .Top       = 599
633:             .Left      = 414
634:             .Width     = 119
635:             .Height    = 15
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .FontBold  = .T.
639:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 690 a 745:
690:             .Enabled           = .F.
691:             .Visible           = .T.
692:         ENDWITH
693:         *-- Mesma razao do painel de observacao: o ControlSource dos dois
694:         *-- campos vai em VincularCamposDetalhe(), com o cursor ja criado
695:         *-- (regra #41).
696:     ENDPROC
697: 
698:     *==========================================================================
699:     * VincularCamposDetalhe - Liga os tres campos de detalhe as colunas de
700:     * cursor_4c_Dados. Fica SEPARADO dos metodos Configurar*: estes rodam no
701:     * InicializarForm, ANTES de o cursor existir, e ControlSource de alias
702:     * ausente derruba o Init (medido no VFP9: "Alias 'CURSOR_4C_DADOS' is not
703:     * found" tanto em TextBox como em EditBox) - regra #41. Chamado por
704:     * CarregarLista, que eh o unico ponto onde o cursor esta garantido.
705:     * Idempotente: reatribuir o mesmo ControlSource nao tem efeito colateral.
706:     *==========================================================================
707:     PROTECTED PROCEDURE VincularCamposDetalhe()
708:         IF !USED("cursor_4c_Dados")
709:             RETURN
710:         ENDIF
711: 
712:         THIS.obj_4c_GetObsArqs.ControlSource = "cursor_4c_Dados.ObsArqs"
713:         THIS.txt_4c_Usuars.ControlSource     = "cursor_4c_Dados.Usuars"
714:         THIS.txt_4c_Datas.ControlSource      = "cursor_4c_Dados.Datas"
715:     ENDPROC
716: 
717:     *==========================================================================
718:     * ObterArquivoCorrente - Caminho do arquivo da linha corrente da grade.
719:     * Equivale ao "lcArq = Alltrim(crSigOpArq.Arquivos)" que o legado repete
720:     * em grdArquivos.AfterRowColChange, imgArqJpg.DblClick, btnOpnArqs.Click e
721:     * btnOpnDirs.Click. Devolve "" com o cursor ausente ou em EOF - no legado
722:     * a leitura em EOF trazia o registro em branco e caia no mesmo guard de
723:     * Empty(), entao o resultado eh o mesmo.
724:     *==========================================================================
725:     PROTECTED PROCEDURE ObterArquivoCorrente()
726:         LOCAL loc_cArquivo
727:         loc_cArquivo = ""
728: 
729:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
730:             SELECT cursor_4c_Dados
731:             loc_cArquivo = ALLTRIM(NVL(cursor_4c_Dados.Arquivos, ""))
732:         ENDIF
733: 
734:         RETURN loc_cArquivo
735:     ENDPROC
736: 
737:     *==========================================================================
738:     * ValidarArquivoSelecionado - Guard "Not Empty(lcArq) And File(lcArq)" que
739:     * o legado escreve IDENTICO em tres lugares (btnOpnArqs.Click,
740:     * btnOpnDirs.Click e imgArqJpg.DblClick). Como SigOpArq guarda apenas o
741:     * ENDERECO do arquivo (caminho de rede/mapeamento), o vinculo pode existir
742:     * em banco e o arquivo ja ter sido movido ou apagado - por isso o legado
743:     * testa File() antes de entregar o caminho ao Shell.
744:     *==========================================================================
745:     PROTECTED PROCEDURE ValidarArquivoSelecionado(par_cArquivo)

*-- Linhas 782 a 800:
782:     *==========================================================================
783:     * GradeAfterRowColChange - grdArquivos.AfterRowColChange do legado: ao
784:     * trocar de linha, repinta o preview da imagem e re-le os tres campos de
785:     * detalhe ligados por ControlSource (txt_4c_Usuars/txt_4c_Datas criados
786:     * nesta fase e obj_4c_GetObsArqs criado na fase 5). Sem este handler os
787:     * campos ficam parados no primeiro registro e o preview nunca aparece -
788:     * popular o cursor nao repinta controle vinculado sozinho (regra #21).
789:     *
790:     * par_nColIndex eh declarado porque BINDEVENT exige a assinatura do evento
791:     * (regra #3), e NAO eh usado como filtro de proposito: o legado tambem nao
792:     * filtra, e o uso correto de AfterRowColChange eh exatamente este - carregar
793:     * o detalhe da linha corrente (regra #46).
794:     *
795:     * O teste de exibicao eh so a extensao, sem File(), igual ao legado: o
796:     * legado reserva o File() para o DblClick do zoom. Picture apontando para
797:     * arquivo inexistente nao estoura em VFP9 - apenas nao desenha (regra #25).
798:     * PUBLIC porque eh alvo de BINDEVENT (regra #3).
799:     *==========================================================================
800:     PROCEDURE GradeAfterRowColChange(par_nColIndex)

*-- Linhas 873 a 917:
873: 
874:     *==========================================================================
875:     * CarregarLista - Popula cursor_4c_Dados via BO.Buscar(fkChaves) e
876:     * reconfigura RecordSource/ControlSource do grid. Width e Header1.Caption
877:     * sao reaplicados DEPOIS do RecordSource (Problema 2/48 - RecordSource
878:     * reseta ambos). GO TOP + Refresh no fim (regra #21/#48 - popular cursor
879:     * nao repinta a grade sozinho). PUBLIC - chamado direto pelo
880:     * TesteAutomatico (regra #3).
881:     *==========================================================================
882:     PROCEDURE CarregarLista()
883:         LOCAL loc_lSucesso
884:         loc_lSucesso = .F.
885: 
886:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
887:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cArqChaves)
888:         ENDIF
889: 
890:         IF loc_lSucesso AND USED("cursor_4c_Dados")
891:             THIS.grd_4c_Dados.RecordSource = ""
892:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
893:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.Arquivos"
894: 
895:             THIS.grd_4c_Dados.Column1.Width = 778
896:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Arquivos Relacionados [Incluindo " + ;
897:                 "Diret" + CHR(243) + "rio, Caminho de Rede, Mapeamento, etc]"
898: 
899:             *-- Vinculo dos campos de detalhe: aqui o cursor existe (regra #41)
900:             THIS.VincularCamposDetalhe()
901: 
902:             SELECT cursor_4c_Dados
903:             GO TOP
904:             THIS.grd_4c_Dados.Refresh()
905:         ENDIF
906: 
907:         RETURN loc_lSucesso
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * AjustarBotoesPorModo - Transcricao do guard do Init legado:
912:     *
913:     *   If Not InList(.pcEscolha, [INSERIR], [ALTERAR])
914:     *       .shpAlterar.Visible = .f.
915:     *       .btnInsArqs.Visible = .f.
916:     *       .btnExcArqs.Visible = .f.
917:     *       .cmdBtnForm.btnConfirmar.Enabled = .f.

*-- Linhas 970 a 996:
970: 
971:     *==========================================================================
972:     * LimparCampos - Zera o painel de detalhe (preview + os tres campos
973:     * ligados por ControlSource) quando NAO ha linha corrente na grade: lista
974:     * vazia na abertura, ou exclusao do ultimo vinculo. Sem isto o painel fica
975:     * parado no registro que acabou de sair da grade - o usuario exclui o
976:     * arquivo, ve a grade esvaziar e continua lendo a observacao e o preview
977:     * dele (nao ha erro, nao ha log: so o dado errado na tela).
978:     *
979:     * O preview eh apagado em codigo (Picture nao eh ControlSource - eh
980:     * atribuido a cada troca de linha, legado grdArquivos.AfterRowColChange).
981:     * Os tres campos de detalhe sao ligados por ControlSource, entao em EOF
982:     * basta o Refresh que o legado ja fazia - atribuir .Value neles escreveria
983:     * DE VOLTA no cursor.
984:     *
985:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE LimparCampos"
986:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever sem o
987:     * modificador nao torna o metodo publico, so esconde que ele continua
988:     * protegido (medido no VFP9: PEMSTATUS(oForm,"LimparCampos",2) = .T. mesmo
989:     * sem o PROTECTED escrito, e a chamada de fora estoura "Property
990:     * LIMPARCAMPOS is not found"). Chamado so por THIS., de dentro da classe.
991:     *==========================================================================
992:     PROTECTED PROCEDURE LimparCampos()
993:         *-- Legado: "Clear Resources" antes de trocar o Picture - libera a
994:         *-- imagem anterior do cache do VFP (sem isso o arquivo fica preso em
995:         *-- disco e uma troca de conteudo nao eh relida).
996:         CLEAR RESOURCES

*-- Linhas 1012 a 1053:
1012:     *
1013:     * O unico campo que o usuario edita eh a observacao (obj_4c_GetObsArqs):
1014:     * ele eh lido do CONTROLE, nao do cursor, para capturar tambem a digitacao
1015:     * que ainda nao foi descarregada pelo ControlSource (o clique em Confirmar
1016:     * costuma tirar o foco e descarregar, mas confirmar por tecla nao) - e o
1017:     * valor eh devolvido ao cursor com REPLACE, que eh o equivalente do
1018:     * .poDataMgr.Update([crSigOpArq]) do legado empurrando o buffer.
1019:     *
1020:     * pkChaves / fkChaves / Arquivos / Usuars / Datas vem do CURSOR, nao dos
1021:     * controles: sao somente-exibicao (o legado trava os tres com When->.f.) e
1022:     * ler Datas do TextBox devolveria o tipo do controle, nao o DATETIME da
1023:     * coluna - TTOD/comparacao com DATE estouraria erro 11 em runtime
1024:     * (regra #16). A coluna do cursor eh garantidamente datetime.
1025:     *
1026:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
1027:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
1028:     * LimparCampos, acima). Chamado so por THIS.SalvarDados, de dentro da
1029:     * classe - nada de fora precisa dele.
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE FormParaBO()
1032:         LOCAL loc_lSucesso, loc_cObs
1033:         loc_lSucesso = .F.
1034: 
1035:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados") ;
1036:            AND !EOF("cursor_4c_Dados")
1037: 
1038:             SELECT cursor_4c_Dados
1039:             loc_cObs = TratarNulo(THIS.obj_4c_GetObsArqs.Value, "")
1040: 
1041:             *-- Descarrega a observacao digitada no cursor. O guard de
1042:             *-- ReadOnly evita REPLACE em cursor nao gravavel (o BO ja entrega
1043:             *-- cursor_4c_Dados READWRITE) e o de diferenca evita marcar a
1044:             *-- linha quando nada mudou.
1045:             IF !ISREADONLY("cursor_4c_Dados") ;
1046:                AND TratarNulo(cursor_4c_Dados.ObsArqs, "") != loc_cObs
1047:                 REPLACE cursor_4c_Dados.ObsArqs WITH loc_cObs
1048:             ENDIF
1049: 
1050:             WITH THIS.this_oBusinessObject
1051:                 .this_cPkChaves = ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, ""))
1052:                 .this_cArquivos = ALLTRIM(TratarNulo(cursor_4c_Dados.Arquivos, ""))
1053:                 .this_cObsArqs  = loc_cObs

*-- Linhas 1075 a 1120:
1075:     * Direcao BO -> form, usada por GradeAfterRowColChange a cada troca de
1076:     * linha da grade e depois de incluir um vinculo novo.
1077:     *
1078:     * Os tres campos de detalhe sao ligados por ControlSource a
1079:     * cursor_4c_Dados: a forma CERTA de "por o BO na tela" eh garantir o valor
1080:     * no cursor e dar Refresh (atribuir .Value neles escreveria de volta no
1081:     * cursor pelo ControlSource, e em coluna datetime/memo isso acabaria em
1082:     * divergencia de tipo). O unico ajuste necessario eh o do legado -
1083:     * "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])": coluna TEXT nula
1084:     * chega ao EditBox como .NULL. e aparece assim para o usuario.
1085:     *
1086:     * O preview da imagem NAO tem ControlSource - eh atribuido em codigo, com
1087:     * o mesmo criterio do legado (so a extensao, SEM File(): o legado reserva
1088:     * o File() para o DblClick do zoom, e Picture apontando para arquivo
1089:     * inexistente nao estoura em VFP9, apenas nao desenha - regra #25).
1090:     *
1091:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE BOParaForm"
1092:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo (mesma razao de
1093:     * LimparCampos, acima). Chamado so por THIS.GradeAfterRowColChange, de
1094:     * dentro da classe - nada de fora precisa dele.
1095:     *==========================================================================
1096:     PROTECTED PROCEDURE BOParaForm()
1097:         LOCAL loc_lSucesso, loc_cArquivo
1098:         loc_lSucesso = .F.
1099: 
1100:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1101:             THIS.LimparCampos()
1102:         ELSE
1103:             SELECT cursor_4c_Dados
1104: 
1105:             *-- Legado: "Update crSigOpArq Set ObsArqs = Nvl(ObsArqs, [])"
1106:             IF ISNULL(cursor_4c_Dados.ObsArqs) ;
1107:                AND !ISREADONLY("cursor_4c_Dados")
1108:                 REPLACE cursor_4c_Dados.ObsArqs WITH ""
1109:             ENDIF
1110: 
1111:             *-- Preview: o caminho vem do BO quando ele esta carregado (fonte
1112:             *-- unica com a gravacao), e do cursor quando nao esta.
1113:             IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
1114:                AND !EMPTY(ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, "")))
1115:                 loc_cArquivo = ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cArquivos, ""))
1116:             ELSE
1117:                 loc_cArquivo = THIS.ObterArquivoCorrente()
1118:             ENDIF
1119: 
1120:             CLEAR RESOURCES

*-- Linhas 1143 a 1246:
1143:     *
1144:     *   Local llOks
1145:     *   llOks = .t.
1146:     *   If Not ThisForm.poDataMgr.Update([crSigOpArq])
1147:     *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
1148:     *       llOks = .f.
1149:     *   EndIf
1150:     *   If llOks And (ThisForm.poDataMgr.Commit() < 1)
1151:     *       =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
1152:     *       llOks = .f.
1153:     *   EndIf
1154:     *   If Not llOks
1155:     *       ThisForm.poDataMgr.RollBack()
1156:     *   EndIf
1157:     *   Return llOks
1158:     *
1159:     * O legado liga crSigOpArq a um cursor COM BUFFERING (.AddCursor): os
1160:     * Inserts/Deletes de btnInsArqs/btnExcArqs so editam o buffer local, e
1161:     * eh aqui - no clique de Confirmar - que .Update()/.Commit() de fato
1162:     * grava tudo no SQL Server (desfazendo com .RollBack() se falhar).
1163:     *
1164:     * Na arquitetura nova esse buffering nao existe: BtnInsArqsClick/
1165:     * BtnExcArqsClick ja gravam direto via BO.Inserir()/BO.Excluir() (fase
1166:     * 4 - "equivalente ao legado, mas gravando direto"). O que continua
1167:     * sujeito a confirmacao explicita eh a edicao do campo Observacao
1168:     * (obj_4c_GetObsArqs), ligado por ControlSource a cursor_4c_Dados - um
1169:     * cursor LOCAL (populado por SQLEXEC), desconectado do servidor: editar
1170:     * ali muda o cursor na memoria, nao a tabela. Varrer o cursor e
1171:     * empurrar cada linha para SigOpArq via BO.Atualizar() (que grava
1172:     * Arquivos/ObsArqs/Usuars/Datas - regra #41-like, cada UPDATE confirma
1173:     * por si so) eh o equivalente funcional do Update()/Commit() do legado.
1174:     *
1175:     * BO.Atualizar() ja exibe o proprio MsgErro com o texto do SQL Server em
1176:     * caso de falha (igual a Inserir/Excluir/ExecutarExclusao) - nao
1177:     * duplicar a mensagem aqui (regra #20: falha de gravacao ja eh
1178:     * reportada por quem grava).
1179:     *
1180:     * PUBLIC: chamado por BtnConfirmarClick (BINDEVENT) e pelo harness.
1181:     *==========================================================================
1182:     PROCEDURE SalvarDados()
1183:         LOCAL loc_lSucesso, loc_nRegistro
1184: 
1185:         loc_lSucesso = .T.
1186: 
1187:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
1188:             SELECT cursor_4c_Dados
1189: 
1190:             *-- FormParaBO primeiro, na linha CORRENTE: eh ele que descarrega
1191:             *-- no cursor a observacao que esta na tela e ainda pode nao ter
1192:             *-- passado pelo ControlSource (confirmar por tecla nao tira o foco
1193:             *-- do EditBox). Sem isto a ultima digitacao do usuario se perde
1194:             *-- SEM aviso - ele ve "salvo com sucesso" e o texto nao foi.
1195:             THIS.FormParaBO()
1196: 
1197:             *-- O SCAN mexe no ponteiro; guardar para devolver a grade a linha
1198:             *-- em que o usuario estava (COUNT/SCAN tem de repor o RECNO).
1199:             loc_nRegistro = IIF(EOF("cursor_4c_Dados"), 0, RECNO("cursor_4c_Dados"))
1200: 
1201:             SELECT cursor_4c_Dados
1202:             SCAN
1203:                 IF !(THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados") AND ;
1204:                      THIS.this_oBusinessObject.Atualizar())
1205:                     loc_lSucesso = .F.
1206:                 ENDIF
1207:             ENDSCAN
1208: 
1209:             SELECT cursor_4c_Dados
1210:             IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT("cursor_4c_Dados")
1211:                 GO loc_nRegistro
1212:             ELSE
1213:                 GO TOP
1214:             ENDIF
1215: 
1216:             *-- Repor o BO na linha corrente: o SCAN deixou nele o ULTIMO
1217:             *-- registro do cursor, e quem ler o BO depois disso (BOParaForm,
1218:             *-- auditoria) veria o registro errado.
1219:             THIS.FormParaBO()
1220:         ENDIF
1221: 
1222:         RETURN loc_lSucesso
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * BtnCancelarClick - btnSair.Click do legado ("ThisForm.Release"), que eh
1227:     * o CANCELAR desta tela: o botao tem Cancel=.T. no SCX (o ESC aciona este
1228:     * handler) e fecha SEM gravar a observacao digitada.
1229:     *
1230:     * NAO desfazer nada a mais: no legado crSigOpArq eh um cursor com
1231:     * buffering que simplesmente nunca sofre Update()/Commit() por este
1232:     * caminho; aqui cursor_4c_Dados eh local e eh liberado no Destroy, entao
1233:     * fechar a tela ja descarta as edicoes nao confirmadas - o mesmo efeito do
1234:     * .RollBack() do legado. As inclusoes e exclusoes de vinculo NAO sao
1235:     * desfeitas porque elas ja gravaram direto (BtnInsArqsClick/
1236:     * BtnExcArqsClick via BO.Inserir()/BO.Excluir()).
1237:     * PUBLIC: chamado por BINDEVENT (regra #3) e pelo harness.
1238:     *==========================================================================
1239:     PROCEDURE BtnCancelarClick()
1240:         THIS.Release()
1241:     ENDPROC
1242: 
1243:     *==========================================================================
1244:     * BtnSairClick - Nome do OBJETO no legado (btnSair). Mantido como ponto de
1245:     * entrada para quem referencia o nome do legado; a logica mora em
1246:     * BtnCancelarClick, que eh o nome canonico desta acao no sistema novo.

*-- Linhas 1272 a 1312:
1272: 
1273:     *==========================================================================
1274:     * BtnInsArqsClick - Seleciona um arquivo via GETFILE() e grava o vinculo
1275:     * (equivalente ao "Insert Into crSigOpArq" do legado, mas gravando direto
1276:     * via BO.Inserir()). Recarrega a grade e posiciona no registro incluido.
1277:     *==========================================================================
1278:     PROCEDURE BtnInsArqsClick()
1279:         LOCAL loc_cArquivo
1280:         loc_cArquivo = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
1281:             "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
1282: 
1283:         IF !EMPTY(loc_cArquivo)
1284:             THIS.this_oBusinessObject.this_cPkChaves = ""
1285:             THIS.this_oBusinessObject.this_cFkChaves = THIS.this_cArqChaves
1286:             THIS.this_oBusinessObject.this_cArquivos = UPPER(loc_cArquivo)
1287:             THIS.this_oBusinessObject.this_cObsArqs  = ""
1288:             THIS.this_oBusinessObject.this_cUsuars   = ""
1289:             THIS.this_oBusinessObject.this_dDatas    = {}
1290: 
1291:             IF THIS.this_oBusinessObject.Inserir()
1292:                 THIS.CarregarLista()
1293:                 IF USED("cursor_4c_Dados")
1294:                     *-- Posiciona na linha recem-incluida (pela PK que o BO
1295:                     *-- acabou de gerar), nao no fim do cursor: a lista nao
1296:                     *-- volta do banco necessariamente na ordem de inclusao.
1297:                     SELECT cursor_4c_Dados
1298:                     LOCATE FOR ALLTRIM(TratarNulo(cursor_4c_Dados.pkChaves, "")) == ;
1299:                         ALLTRIM(THIS.this_oBusinessObject.this_cPkChaves)
1300:                     IF !FOUND()
1301:                         GO BOTTOM
1302:                     ENDIF
1303:                     THIS.grd_4c_Dados.Refresh()
1304:                 ENDIF
1305:                 *-- Repintar o painel de detalhe TAMBEM aqui: a grade acabou de
1306:                 *-- ser reposicionada e Grid.Refresh nao dispara
1307:                 *-- AfterRowColChange (regra #21 - o metodo unico roda em todo
1308:                 *-- caminho que popula/reposiciona o cursor).
1309:                 THIS.GradeAfterRowColChange(1)
1310:                 THIS.grd_4c_Dados.SetFocus()
1311:                 THIS.grd_4c_Dados.Column1.SetFocus()
1312:             ENDIF

*-- Linhas 1332 a 1359:
1332:     *==========================================================================
1333:     * BtnExcArqsClick - Remove o vinculo do arquivo corrente (via BO.Excluir -
1334:     * PUBLIC, regra #51). NAO apaga o arquivo fisico, so o vinculo em
1335:     * SigOpArq (equivalente ao "Delete In crSigOpArq" do legado).
1336:     *==========================================================================
1337:     PROCEDURE BtnExcArqsClick()
1338:         LOCAL loc_lConfirma
1339: 
1340:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1341:             RETURN
1342:         ENDIF
1343: 
1344:         SELECT cursor_4c_Dados
1345:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do v" + ;
1346:             CHR(237) + "nculo deste arquivo?" + CHR(13) + ;
1347:             "(O arquivo f" + CHR(237) + "sico N" + CHR(227) + "O ser" + CHR(225) + ;
1348:             " apagado)", "Confirmar")
1349: 
1350:         IF loc_lConfirma
1351:             THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkChaves)
1352: 
1353:             IF THIS.this_oBusinessObject.Excluir()
1354:                 THIS.CarregarLista()
1355:                 *-- Mesma razao do BtnInsArqsClick: a linha que o painel de
1356:                 *-- detalhe exibia acabou de desaparecer (regra #21).
1357:                 THIS.GradeAfterRowColChange(1)
1358:                 THIS.grd_4c_Dados.SetFocus()
1359:                 THIS.grd_4c_Dados.Column1.SetFocus()


### BO (C:\4c\projeto\app\classes\SigOpDocBO.prg):
*==============================================================================
* SigOpDocBO.prg - Business Object para Relacao de Arquivos e Documentos
* Form OPERACIONAL - dialogo filho instanciado com DO FORM SigOpDoc WITH
* par_cChave, par_cEscolha (legado: Lparameters pKey, pEsc)
* Legado: SIGOPDOC.SCX
* Tabela principal: SigOpArq | PK: pkChaves (gerada por fUniqueIds())
* Chave de amarracao (fkChaves): recebida do form pai - EmpDopNums, CPros,
* IClis, etc., conforme a tela que abriu este dialogo
*==============================================================================

DEFINE CLASS SigOpDocBO AS BusinessBase

    *-- Propriedades de SigOpArq (registro corrente da grade de arquivos)
    this_cPkChaves = ""    && pkChaves  CHAR(20) NOT NULL - chave primaria (fUniqueIds)
    this_cFkChaves = ""    && fkChaves  CHAR(30)          - chave de amarracao ao registro pai
    this_cArquivos = ""    && Arquivos  CHAR(250) NOT NULL - caminho/nome do arquivo vinculado
    this_cObsArqs  = ""    && ObsArqs   TEXT             - observacao sobre o arquivo
    this_cUsuars   = ""    && Usuars    CHAR(10) NOT NULL - usuario que incluiu o vinculo
    this_dDatas    = {}    && Datas     DATETIME          - data/hora de inclusao do vinculo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigOpArq"
        THIS.this_cCampoChave = "pkChaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (pkChaves) para uso em
    * RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cPkChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas de SigOpArq (vindas do
    * cursor crSigOpArq/cursor_4c_Dados, uma linha = um arquivo vinculado)
    * para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #9 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cPkChaves = TratarNulo(pkChaves, "")
                THIS.this_cFkChaves = TratarNulo(fkChaves, "")
                THIS.this_cArquivos = TratarNulo(Arquivos, "")
                THIS.this_cObsArqs  = TratarNulo(ObsArqs, "")
                THIS.this_cUsuars   = TratarNulo(Usuars, "")
                THIS.this_dDatas    = TratarNulo(Datas, {})

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista os arquivos vinculados a chave de amarracao recebida do
    * form pai (fkChaves). Retorna cursor_4c_Dados com pkChaves/fkChaves/
    * Arquivos/ObsArqs/Usuars/Datas (regra #42 - chave char(30), PADR ao
    * montar o WHERE, nunca ALLTRIM nas partes). Equivalente a
    * "Select * From SigOpArq Where fkChaves = Padr(pKey, 30)" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), fkChaves C(30), ;
                        Arquivos C(250), ObsArqs M, Usuars C(10), Datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
                loc_cSQL = loc_cSQL + " FROM SigOpArq"
                loc_cSQL = loc_cSQL + " WHERE fkchaves = " + ;
                    EscaparSQL(PADR(ALLTRIM(NVL(par_cChave, "")), 30))

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    *-- Cursor de SQL pass-through nasce SOMENTE-LEITURA. O
                    *-- EditBox da observacao (getObsArqs) esta ligado a este
                    *-- cursor por ControlSource: sem READWRITE ele nao aceita
                    *-- uma tecla sequer e SalvarDados nunca teria o que gravar
                    *-- - e nao ha erro nenhum na tela, so o campo inerte.
                    *-- O legado liga crSigOpArq por .AddCursor (cursor COM
                    *-- buffering, gravavel - a prova esta no proprio Init,
                    *-- que faz "Update crSigOpArq Set ObsArqs = ..."), entao
                    *-- converter para READWRITE eh o que REPRODUZ o legado.
                    *-- SQLEXEC vai para alias TEMPORARIO porque derrubar o
                    *-- alias ligado ao Grid zera o ColumnCount.
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    *-- Legado, logo depois do Requery: "Update crSigOpArq Set
                    *-- ObsArqs = Nvl(ObsArqs, [])". Sem isto a coluna TEXT
                    *-- nula chega ao EditBox como .NULL. e eh isso que o
                    *-- usuario le na tela.
                    SELECT cursor_4c_Dados
                    SCAN FOR ISNULL(cursor_4c_Dados.ObsArqs)
                        REPLACE cursor_4c_Dados.ObsArqs WITH ""
                    ENDSCAN

                    *-- Legado: "Go Top In crSigOpArq"
                    SELECT cursor_4c_Dados
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar os arquivos vinculados:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo vinculo de arquivo em SigOpArq.
    * PK (pkChaves) gerada via fUniqueIds() se ainda nao preenchida -
    * equivalente a "fUniqueIds()" do btnInsArqs.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Usuars/Datas = usuario e data/hora da inclusao do vinculo
            *-- (equivalente a "Usuar, Datetime()" do legado)
            IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuars, "")))
                THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpArq ("
            loc_cSQL = loc_cSQL + "pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkChaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cFkChaves, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza vinculo de arquivo existente em SigOpArq
    * (por pkChaves). fkChaves nao muda depois de gravado - o UPDATE cobre
    * apenas os campos que a tela permite editar (Arquivos, ObsArqs).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpArq SET"
            loc_cSQL = loc_cSQL + " arquivos = " + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + " obsarqs = " + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas)
            loc_cSQL = loc_cSQL + " WHERE pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o vinculo de arquivo corrente de SigOpArq
    * (por pkChaves). PROTECTED (regra #51 - de fora sempre Excluir()).
    * Equivalente a "Delete In crSigOpArq" do btnExcArqs.Click legado, mas
    * gravando a exclusao direto no SQL Server (nao ha mais commit em lote).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                    " v" + CHR(237) + "nculo de arquivo selecionado para excluir."
            ELSE
                loc_cSQL = "DELETE FROM SigOpArq WHERE pkchaves = " + ;
                    EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

                IF USED("cursor_4c_Delete")
                    USE IN cursor_4c_Delete
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir o v" + CHR(237) + "nculo do arquivo:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

