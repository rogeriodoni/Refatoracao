# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES

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
Objeto: delete
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = ""
  Column2.SelectOnEntry = .F.
  Column3.ControlSource = ""
  ControlSource = ""
  Name = "delete"
Select * From CrSigCdCot Into Cursor TmpCot ReadWrite
This.fwgrade_Cotacao.Data.ControlSource = 'TmpCot.datas'
This.fwgrade_Cotacao.Cotacao.ControlSource = 'TmpCot.valos'
This.fwgrade_Cotacao.Hora.ControlSource = 'TmpCot.horas'
ThisForm.Delete.Visible  = fChecaAcesso('SIGPRCOT','EXCLUIR')
If ThisForm.Delete.Visible
	ThisForm.Delete.Left = lnLeft
	lnLeft = lnLeft + ThisForm.Delete.Width
Select TmpCot
Select TmpCot
If Seek(CrSigCdMoe.cmoes + Dtos(_data) + This.Value)
Select TmpCot
Seek(CrSigCdMoe.cmoes + Dtos({}))
	Insert Into TmpCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
	Insert Into CrSigCdCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
Select TmpCot
	If ThisForm.ThisParent.poDataMgr.SqlExecute([Delete From SigCdCot Where cidchaves = ']+lcIdChave+[' ],'') < 1
	Select TmpCot
	Delete
	If Seek(lcIdChave,'CrSigCdCot','CidChaves')
		Delete In CrSigCdCot
Select TmpCot
		Delete
		If Seek(TmpCot.cidchaves,'CrSigCdCot','CidChaves')
			Delete In CrSigCdCot
	Select TmpCot
Select CrSigCdCot
	If Seek(CrSigCdCot.cidchaves,'TmpCot','CidChaves')
ThisForm.ThisParent.poDataMgr.Update('CrSigCdCot')
Select CrSigCdMoe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS SQL (1136 linhas total):

*-- Linhas 36 a 57:
36: * cabecalho.
37: *
38: * FASE 4: grid de cotacoes (ConfigurarGrid - so estrutura, sem
39: * ControlSource) e os 3 botoes de acao (ConfigurarBotoes/
40: * AjustarBotoesPorAcesso), com CarregarLista e os handlers de Click
41: * (BtnIncluirClick/BtnExcluirClick/BtnSairClick) transcritos do
42: * inserir.Click/delete.Click/sair.Click legado.
43: *
44: * FASE 5: eventos de NIVEL DE GRADE (AfterRowColChange/When do proprio
45: * fwgrade_cotacao, nao das colunas) - controla this_nIncluir (espelho de
46: * ThisForm.Incluir), usado pelas 3 colunas para saber se a linha corrente
47: * pode receber novo valor.
48: *
49: * FASE 6: este form NAO tem Page2/lookups (SCX legado sem fwBuscaExt/
50: * fwBuscaSel/sigacess - os "campos" editaveis SAO as colunas da grade, ja
51: * vinculadas desde a Fase 5). A Fase 6 entregou os eventos de VALID de cada
52: * celula (data.Text1.Valid/cotacao.Text1.Valid/hora.Text1.Valid do legado -
53: * Data obrigatoria, refresh apos Cotacao, duplicidade de Hora), emulados
54: * via KeyPress (BINDEVENT em "Valid" nao dispara de forma confiavel em
55: * TextBox - regra #3).
56: *
57: * FASE 8 (CONSOLIDACAO): entrega os hooks canonicos de transferencia

*-- Linhas 68 a 87:
68: * pelo motivo errado - ver "Armadilha que apareceu ao medir" no historico
69: * do projeto):
70: *   Btn...Salvar/Confirmar...Click - o SCX legado NAO tem botao de gravar:
71: *       sao 3 botoes (inserir/delete/sair) e a gravacao vale na hora, por
72: *       linha. Quem persistia no legado era o TABLEUPDATE do form PAI sobre
73: *       o cursor compartilhado CrSigCdCot; aqui cada acao fala com o
74: *       SIGPRCOTBO na hora (Salvar/Excluir).
75: *   Btn...Cancelar...Click - nao ha Page2 de Dados nem modo de edicao
76: *       cancelavel. O unico caminho de saida e o Encerrar, e ele NAO
77: *       cancela: descarta as linhas nunca preenchidas (Data ou Cotacao
78: *       vazias, igual ao sair.Click legado) e grava as demais.
79: *   Habilitar...Campos / Limpar...Campos - nao ha campo fora da grade; o
80: *       equivalente real e o gate por celula (ValidarPermissaoCelula, que
81: *       espelha o When das 3 colunas do legado).
82: *   Ajustar...PorModo - este form nao tem modos (INCLUIR/ALTERAR/
83: *       VISUALIZAR): o que o legado ajusta e a VISIBILIDADE por permissao,
84: *       ja entregue em AjustarBotoesPorAcesso (fChecaAcesso + cascata de
85: *       Left), transcrita do bloco "Acesso dos Botoes" do Init legado.
86: *
87: * FASE 7 (eventos principais): eventos principais deste form OPERACIONAL sao

*-- Linhas 125 a 143:
125:     Themes       = .F.
126: 
127:     *-- DataSession PRIVADA (2, igual ao SCX legado): o BO consulta SigCdCot
128:     *-- direto no SQL Server (SQLEXEC + cursor_4c_Dados proprio) e NAO precisa
129:     *-- de cursor compartilhado com o form pai (CrSigCdCot/CrSigCdMoe do
130:     *-- legado eram cursores da DataSession herdada via ThisForm.DataSessionId)
131:     DataSession  = 2
132: 
133:     *-- Referencia ao form pai (para reabilitar ao encerrar - legado:
134:     *-- ThisForm.ThisParent)
135:     par_oFormPai = .NULL.
136: 
137:     *-- Contexto recebido na abertura
138:     this_cMoeda  = ""    && SigCdMoe.cmoes da moeda corrente (legado: le de
139:                           && CrSigCdMoe.cmoes, cursor da DataSession do pai)
140: 
141:     *-- Espelha ThisForm.Incluir do legado: RECNO() da linha do cursor de
142:     *-- cotacoes que esta sendo incluida/editada (controla, via When das
143:     *-- celulas da grade, quais linhas ficam editaveis - Fase 7)

*-- Linhas 189 a 211:
189:             *-- para o Seek de duplicidade (Fase 7) casar so a chave inteira.
190:             SET EXACT ON
191: 
192:             *-- Sem SET DELETED ON, o DELETE local do BtnExcluirClick/
193:             *-- BtnSairClick continua aparecendo na grade e seria reprocessado
194:             *-- pelo SCAN de sincronizacao do BtnSairClick (mesma armadilha
195:             *-- documentada em FormSigPrCar.InicializarForm)
196:             SET DELETED ON
197: 
198:             *-- Moeda ausente eh erro de USO (o dialogo so existe para uma
199:             *-- moeda), mas NAO em modo validacao/teste: o ValidarUIFidelity
200:             *-- instancia o form SEM ARGUMENTO NENHUM e o MsgErro abriria um
201:             *-- modal de verdade que pendura o harness (mesma armadilha do
202:             *-- FormSigPrCar - regra #29/CorretorAutomatico).
203:             IF EMPTY(THIS.this_cMoeda) AND !loc_lModoValidacaoOuTeste
204:                 MsgErro("Moeda n" + CHR(227) + "o informada para gerenciar " + ;
205:                         "cota" + CHR(231) + CHR(227) + "oes.", "Erro SIGPRCOT")
206:             ELSE
207:                 *-- Criar Business Object
208:                 THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCOTBO")
209: 
210:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
211:                     MsgErro("Falha ao criar SIGPRCOTBO", "Erro SIGPRCOT")

*-- Linhas 223 a 246:
223:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
224: 
225:                     *-- Grade de cotacoes (Column1=Data, Column2=Cotacao,
226:                     *-- Column3=Hora) - so estrutura, sem ControlSource ainda
227:                     *-- (cursor_4c_Dados so existe depois do CarregarLista -
228:                     *-- regra #41)
229:                     THIS.ConfigurarGrid()
230: 
231:                     *-- Botoes de acao (cmd_4c_Incluir/cmd_4c_Delete/cmd_4c_Sair)
232:                     *-- - criados DEPOIS do cabecalho para desenhar por cima
233:                     *-- dele (Top=3, dentro da faixa Top=0..80 - regra #11)
234:                     THIS.ConfigurarBotoes()
235: 
236:                     *-- AddObject cria controles com Visible=.F. por padrao
237:                     THIS.TornarControlesVisiveis()
238: 
239:                     *-- Espelha o bloco "Acesso dos Botoes" do Init legado
240:                     *-- (fChecaAcesso + reposicionamento em cascata) - tem que
241:                     *-- rodar DEPOIS do TornarControlesVisiveis, senao a
242:                     *-- visibilidade generica sobrescreve o Visible calculado
243:                     *-- aqui
244:                     THIS.AjustarBotoesPorAcesso()
245: 
246:                     *-- Popula a grade (pulado em modo teste/validacao de UI -

*-- Linhas 353 a 400:
353:     *-- ColumnOrder segue o legado: Data(1) - Hora(2) - Cotacao(3), embora
354:     *-- as colunas sejam declaradas na ordem Data/Cotacao/Hora (Column1/2/3).
355:     *--
356:     *-- So estrutura aqui - SEM ControlSource (cursor_4c_Dados so existe
357:     *-- depois do CarregarLista - regra #41) e SEM os eventos de celula
358:     *-- (GotFocus/KeyPress/When das 3 colunas, que espelham os Valid/When do
359:     *-- legado): entram nas Fases 7-8, junto com os demais eventos da grade
360:     *-- e dos botoes (ver comentario no topo do arquivo).
361:         THIS.AddObject("grd_4c_Dados", "Grid")
362:         WITH THIS.grd_4c_Dados
363:             .Top               = 85
364:             .Left              = 133
365:             .Width             = 270
366:             .Height            = 283
367:             .TabIndex          = 4
368:             .FontName          = "Courier New"
369:             .FontSize          = 9
370:             .AllowHeaderSizing = .T.
371:             .DeleteMark        = .F.
372:             .RecordMark        = .F.
373:             .ReadOnly          = .F.
374:             .RowHeight         = 20
375:             .ScrollBars        = 2
376:             .ColumnCount       = 3
377: 
378:             *-- Column1 = Data (data.Header1/data.Text1 do legado)
379:             .Column1.FontName          = "Courier New"
380:             .Column1.FontSize          = 9
381:             .Column1.Width             = 80
382:             .Column1.Movable           = .F.
383:             .Column1.Resizable         = .F.
384:             .Column1.ReadOnly          = .F.
385:             .Column1.SelectOnEntry     = .F.
386:             .Column1.Format            = "K"
387:             .Column1.Header1.Alignment = 2
388:             .Column1.Header1.Caption   = "Data"
389:             .Column1.Text1.FontName    = "Courier New"
390:             .Column1.Text1.FontSize    = 9
391:             .Column1.Text1.BorderStyle = 0
392:             .Column1.Text1.Format      = "K"
393:             .Column1.Text1.Margin      = 0
394:             .Column1.Text1.ReadOnly    = .F.
395:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
396:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
397: 
398:             *-- Column3 = Hora (hora.Header1/hora.Text1 do legado) -
399:             *-- ColumnOrder=2: exibida ANTES da Cotacao (legado)
400:             .Column3.ColumnOrder       = 2

*-- Linhas 423 a 441:
423:             .Column2.Movable           = .F.
424:             .Column2.Resizable         = .F.
425:             .Column2.ReadOnly          = .F.
426:             .Column2.SelectOnEntry     = .F.
427:             .Column2.Format            = "K"
428:             .Column2.InputMask         = "99999.9999999"
429:             .Column2.Header1.Alignment = 2
430:             .Column2.Header1.Caption   = "Cota" + CHR(231) + CHR(227) + "o"
431:             .Column2.Text1.FontName    = "Courier New"
432:             .Column2.Text1.FontSize    = 9
433:             .Column2.Text1.BorderStyle = 0
434:             .Column2.Text1.Format      = "K"
435:             .Column2.Text1.Margin      = 0
436:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
437:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
438:         ENDWITH
439: 
440:         *-- Eventos de NIVEL DE GRADE do legado (fwgrade_cotacao.
441:         *-- AfterRowColChange/When - nao confundir com os Valid de CADA

*-- Linhas 489 a 507:
489:             RETURN
490:         ENDIF
491: 
492:         SELECT cursor_4c_Dados
493:         loc_lPermitido = EMPTY(EVALUATE(par_cCampo)) OR ;
494:                          RECNO("cursor_4c_Dados") == THIS.this_nIncluir
495: 
496:         IF !loc_lPermitido
497:             THIS.this_lNavegandoGrade = .T.
498:             IF THIS.this_nIncluir > 0 AND ;
499:                     BETWEEN(THIS.this_nIncluir, 1, RECCOUNT("cursor_4c_Dados"))
500:                 GO THIS.this_nIncluir IN cursor_4c_Dados
501:                 THIS.grd_4c_Dados.Column1.SetFocus()
502:             ELSE
503:                 *-- Nenhuma linha em inclusao/edicao - nao ha celula
504:                 *-- permitida na grade, entao o foco sai para o botao Incluir
505:                 THIS.cmd_4c_Incluir.SetFocus()
506:             ENDIF
507:             THIS.this_lNavegandoGrade = .F.

*-- Linhas 587 a 627:
587:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
588:     *==========================================================================
589:     *-- Espelha SIGPRCOT.fwgrade_cotacao.cotacao.Text1.Valid do legado:
590:     *--   Select TmpCot / Go Bottom / ThisForm.fwgrade_Cotacao.Refresh
591:     *-- So reposiciona no ultimo registro do cursor local e repinta a grade
592:     *-- (popular/alterar o cursor nao repinta sozinho - regra #21).
593:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
594:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
595: 
596:         IF !INLIST(par_nKeyCode, 13, 9, 5, 24)
597:             RETURN
598:         ENDIF
599: 
600:         IF USED("cursor_4c_Dados")
601:             SELECT cursor_4c_Dados
602:             GO BOTTOM
603:             THIS.grd_4c_Dados.Refresh()
604:         ENDIF
605:     ENDPROC
606: 
607:     *==========================================================================
608:     PROCEDURE ValidarCelulaHora
609:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
610:     *==========================================================================
611:     *-- Espelha SIGPRCOT.fwgrade_cotacao.hora.Text1.Valid do legado:
612:     *--   Select TmpCot / Set Order To Cotacaos
613:     *--   _Data = This.Parent.Parent.Data.Text1.Value
614:     *--   If Seek(CrSigCdMoe.cmoes + Dtos(_data) + This.Value) Then Skip
615:     *--   If cmoes+Dtos(datas)+horas = CrSigCdMoe.cmoes+Dtos(_data)+This.Value
616:     *--       Messagebox('Cotacao ja cadastrada !!!',0+48,'') / This.Value =
617:     *--       '  :  ' / Return 0
618:     *-- _Data (a data da MESMA linha que esta sendo editada) vem direto do
619:     *-- cursor local, ja que o RECNO() corrente ainda eh o da linha da
620:     *-- celula (o SEEK/SKIP abaixo move o ponteiro, por isso o RECNO original
621:     *-- eh guardado e restaurado no fim). O Skip do legado pula o PROPRIO
622:     *-- registro quando o SEEK encontra ele mesmo, para so acusar duplicidade
623:     *-- de um registro DIFERENTE.
624:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
625:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
626:         LOCAL loc_dData, loc_cHora, loc_nRecnoAtual, loc_cChave
627: 

*-- Linhas 633 a 651:
633:             RETURN
634:         ENDIF
635: 
636:         SELECT cursor_4c_Dados
637:         loc_nRecnoAtual = RECNO()
638:         loc_dData       = datas
639:         loc_cHora       = THIS.grd_4c_Dados.Column3.Text1.Value
640: 
641:         *-- Chave POSICIONAL - o padding FAZ PARTE da chave (CLAUDE.md #42).
642:         *-- O TAG Cotacaos eh "cmoes + DTOS(datas) + horas" e no schema cmoes
643:         *-- eh char(3) e horas eh char(8), logo a chave tem 3+8+8 = 19 chars.
644:         *-- O legado monta com as COLUNAS CRUAS (CrSigCdMoe.cmoes + Dtos(_data)
645:         *-- + This.Value), por isso PADR explicito nas duas pontas:
646:         *--   a) ALLTRIM na moeda desloca o DTOS e o SEEK nao casa - medido no
647:         *--      VFP9 com moeda de 2 chars ("R$"): SEEK .F. contra .T. do
648:         *--      legado (moeda de 3 chars mascarava o defeito);
649:         *--   b) a hora vem do TextBox com InputMask "99:99" (5 chars), entao
650:         *--      sem o PADR a chave fica com 16 e a comparacao == contra a
651:         *--      expressao da linha (19) eh SEMPRE .F. - o aviso de

*-- Linhas 677 a 695:
677:     *-- Botoes standalone (fwbtng do legado) - Themes=.T. + DisabledPicture
678:     *-- obrigatorios em CommandButton icone-only fora de CommandGroup (senao
679:     *-- o icone some quando Enabled=.F., mesmo estando ainda visivel). Left
680:     *-- aqui eh o valor de DESENHO do SCX (312/387/462); Incluir/Delete sao
681:     *-- reposicionados em cascata por AjustarBotoesPorAcesso, igual ao
682:     *-- legado - Sair NUNCA se move.
683:         LOCAL loc_cIcones
684: 
685:         *-- Mesmo cuidado de ConfigurarDecoracao: testar TYPE() antes de usar
686:         *-- a global (regra #26/#29 - ValidarUIFidelity nao roda config.prg)
687:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
688: 
689:         THIS.AddObject("cmd_4c_Incluir", "CommandButton")
690:         WITH THIS.cmd_4c_Incluir
691:             .Top             = 3
692:             .Left = 5
693:             .Width           = 75
694:             .Height          = 75
695:             .Caption         = "Inserir"

*-- Linhas 711 a 752:
711:         ENDWITH
712:         BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
713: 
714:         THIS.AddObject("cmd_4c_Delete", "CommandButton")
715:         WITH THIS.cmd_4c_Delete
716:             .Top             = 3
717:             .Left            = 387
718:             .Width           = 75
719:             .Height          = 75
720:             .Caption         = "Excluir"
721:             .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
722:             .DisabledPicture = loc_cIcones + "cadastro_excluir_60.jpg"
723:             .Themes          = .T.
724:             .TabIndex        = 2
725:             .FontName        = "Comic Sans MS"
726:             .FontBold        = .T.
727:             .FontItalic      = .T.
728:             .FontSize        = 8
729:             .ForeColor       = RGB(90, 90, 90)
730:             .BackColor       = RGB(255, 255, 255)
731:             .SpecialEffect   = 0
732:             .PicturePosition = 13
733:             .MousePointer    = 15
734:             .WordWrap        = .T.
735:             .AutoSize        = .F.
736:         ENDWITH
737:         BINDEVENT(THIS.cmd_4c_Delete, "Click", THIS, "BtnExcluirClick")
738: 
739:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
740:         WITH THIS.cmd_4c_Sair
741:             .Top             = 3
742:             .Left            = 462
743:             .Width           = 75
744:             .Height          = 75
745:             .Caption         = "Encerrar"
746:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
747:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
748:             .Themes          = .T.
749:             .Cancel          = .T.
750:             .TabIndex        = 5
751:             .FontName        = "Comic Sans MS"
752:             .FontBold        = .T.

*-- Linhas 768 a 831:
768:     *==========================================================================
769:     *-- Espelha o bloco "Acesso dos Botoes" do Init legado:
770:     *--   ThisForm.Inserir.Visible = fChecaAcesso('SIGPRCOT','INSERIR')
771:     *--   ThisForm.Delete.Visible  = fChecaAcesso('SIGPRCOT','EXCLUIR')
772:     *--   lnLeft = 13 / cascata de Left conforme quem estiver visivel
773:     *-- (Sair NAO participa da cascata no legado - fica sempre em Left=462).
774:     *-- Chamado DEPOIS de TornarControlesVisiveis, senao a visibilidade
775:     *-- generica sobrescreveria o Visible calculado aqui.
776:         LOCAL loc_nLeft
777: 
778:         THIS.cmd_4c_Incluir.Visible = fChecaAcesso("SIGPRCOT", "INSERIR")
779:         THIS.cmd_4c_Delete.Visible  = fChecaAcesso("SIGPRCOT", "EXCLUIR")
780: 
781:         loc_nLeft = 13
782:         IF THIS.cmd_4c_Incluir.Visible
783:             THIS.cmd_4c_Incluir.Left = loc_nLeft
784:             loc_nLeft = loc_nLeft + THIS.cmd_4c_Incluir.Width
785:         ENDIF
786:         IF THIS.cmd_4c_Delete.Visible
787:             THIS.cmd_4c_Delete.Left = loc_nLeft
788:             loc_nLeft = loc_nLeft + THIS.cmd_4c_Delete.Width
789:         ENDIF
790:     ENDPROC
791: 
792:     *==========================================================================
793:     PROTECTED PROCEDURE FormParaBO
794:     *==========================================================================
795:     *-- Transferencia LINHA DA GRADE -> Business Object.
796:     *--
797:     *-- Neste dialogo a "ficha" NAO e uma Page2 de campos soltos: e a LINHA
798:     *-- corrente da grade (o legado edita data/hora/valor direto na celula, e
799:     *-- o par cursor/tabela e o mesmo SigCdCot). Por isso o hook canonico de
800:     *-- transferencia le o registro corrente de cursor_4c_Dados, que e o
801:     *-- equivalente exato do "campo da tela" nas telas com Page de Dados.
802:     *--
803:     *-- Antes desta fase as mesmas 5 atribuicoes estavam repetidas inline em
804:     *-- BtnExcluirClick e nos DOIS Scan do BtnSairClick (transcricao direta do
805:     *-- delete.Click/sair.Click legado) - consolidadas aqui, com a chave
806:     *-- incluida (o legado tambem identifica a linha por cidchaves).
807:     *--
808:     *-- PROTECTED EXPLICITO: FormBase ja declara FormParaBO como PROTECTED e o
809:     *-- VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador nao
810:     *-- tornaria o metodo publico, so esconderia que ele continua protegido.
811:     *-- Chamar sempre por THIS. (regra #8).
812:         LOCAL loc_lSucesso
813:         loc_lSucesso = .F.
814: 
815:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
816:             SELECT cursor_4c_Dados
817: 
818:             IF !EOF("cursor_4c_Dados")
819:                 THIS.this_oBusinessObject.this_cCidChaves = ;
820:                     ALLTRIM(TratarNulo(cursor_4c_Dados.cidchaves, ""))
821:                 THIS.this_oBusinessObject.this_cMoeda = ;
822:                     ALLTRIM(TratarNulo(cursor_4c_Dados.cmoes, ""))
823:                 THIS.this_oBusinessObject.this_dData = ;
824:                     ConverterParaData(TratarNulo(cursor_4c_Dados.datas, {}))
825:                 THIS.this_oBusinessObject.this_cHora = ;
826:                     ALLTRIM(TratarNulo(cursor_4c_Dados.horas, ""))
827:                 THIS.this_oBusinessObject.this_nValor = ;
828:                     TratarNulo(cursor_4c_Dados.valos, 0)
829: 
830:                 loc_lSucesso = .T.
831:             ENDIF

*-- Linhas 842 a 1097:
842:     *-- BO acabou de persistir - inclusive dtalts/usuars, que o proprio BO
843:     *-- carimba em Inserir/Atualizar e que a tela nao tem como digitar.
844:     *--
845:     *-- Espelha o segundo Insert do inserir.Click legado (a linha que ia para
846:     *-- CrSigCdCot com os mesmos valores gravados na tabela), hoje chamado
847:     *-- pelo BtnIncluirClick logo depois do APPEND BLANK.
848:     *--
849:     *-- NAO repinta a grade de proposito: o Refresh e responsabilidade do
850:     *-- chamador (regra #21), que costuma encadear outras alteracoes antes de
851:     *-- repintar uma vez so.
852:     *--
853:     *-- PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO acima.
854:         LOCAL loc_lSucesso
855:         loc_lSucesso = .F.
856: 
857:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Dados")
858:             SELECT cursor_4c_Dados
859: 
860:             IF !EOF("cursor_4c_Dados")
861:                 REPLACE cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
862:                         cmoes     WITH THIS.this_oBusinessObject.this_cMoeda, ;
863:                         datas     WITH THIS.this_oBusinessObject.this_dData, ;
864:                         horas     WITH THIS.this_oBusinessObject.this_cHora, ;
865:                         valos     WITH THIS.this_oBusinessObject.this_nValor, ;
866:                         dtalts    WITH THIS.this_oBusinessObject.this_dDataAlteracao, ;
867:                         usuars    WITH THIS.this_oBusinessObject.this_cUsuario ;
868:                      IN cursor_4c_Dados
869: 
870:                 loc_lSucesso = .T.
871:             ENDIF
872:         ENDIF
873: 
874:         RETURN loc_lSucesso
875:     ENDPROC
876: 
877:     *==========================================================================
878:     PROCEDURE CarregarLista
879:     *==========================================================================
880:     *-- Busca as cotacoes da moeda corrente e vincula a grade. Espelha o
881:     *-- "This.fwgrade_Cotacao.RecordSource = 'TmpCot'" + os 3 ControlSource
882:     *-- do Init legado.
883:     *-- PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form
884:     *-- direto de fora da classe (regra #3/CLAUDE.md)
885:         LOCAL loc_lSucesso
886:         loc_lSucesso = .F.
887: 
888:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
889:             loc_lSucesso = THIS.this_oBusinessObject.Buscar(THIS.this_cMoeda)
890:         ENDIF
891: 
892:         IF USED("cursor_4c_Dados")
893:             SELECT cursor_4c_Dados
894:             SET ORDER TO Cotacaos
895:             GO BOTTOM
896: 
897:             *-- RecordSource com referencia EXPLICITA, FORA de WITH -
898:             *-- Column1/2/3 ja existem desde ConfigurarGrid (ColumnCount=3)
899:             THIS.grd_4c_Dados.RecordSource = ""
900:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
901:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.datas"
902:             THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.valos"
903:             THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Dados.horas"
904: 
905:             *-- RecordSource/ControlSource resetam Width e Header1.Caption -
906:             *-- reconfigurar SEMPRE depois de vincular (CLAUDE.md Problema 48)
907:             THIS.grd_4c_Dados.Column1.Width           = 80
908:             THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
909:             THIS.grd_4c_Dados.Column2.Width           = 101
910:             THIS.grd_4c_Dados.Column2.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
911:             THIS.grd_4c_Dados.Column3.Width           = 55
912:             THIS.grd_4c_Dados.Column3.Header1.Caption = "Hora"
913: 
914:             THIS.grd_4c_Dados.Refresh()
915:         ENDIF
916: 
917:         RETURN loc_lSucesso
918:     ENDPROC
919: 
920:     *==========================================================================
921:     PROCEDURE BtnIncluirClick
922:     *==========================================================================
923:     *-- Espelha SIGPRCOT.inserir.Click do legado. Legado: Seek(CrSigCdMoe.cmoes
924:     *-- + Dtos({})) em ordem Cotacaos - nenhuma cotacao real tem data vazia,
925:     *-- entao este guard NUNCA acha registro e o legado sempre segue para o
926:     *-- bloco de insercao (transcrito tal como esta, sem "consertar" a
927:     *-- aparente redundancia - CLAUDE.md regra #17). lcDatas/lcDtAlts do
928:     *-- legado (fDtoSQL) sao codigo morto - nunca usados nos INSERT - e por
929:     *-- isso nao tem equivalente aqui.
930:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
931:         LOCAL loc_cIdChave, loc_dData, loc_cHora
932: 
933:         IF !USED("cursor_4c_Dados")
934:             RETURN
935:         ENDIF
936: 
937:         SELECT cursor_4c_Dados
938:         SET ORDER TO Cotacaos
939:         SEEK(ALLTRIM(THIS.this_cMoeda) + DTOS({}))
940: 
941:         IF EOF()
942:             SET ORDER TO
943: 
944:             loc_dData    = DATE()
945:             loc_cHora    = TIME()
946:             loc_cIdChave = LEFT(fUniqueIds(), 20)
947: 
948:             *-- NovoRegistro() chama LimparDados() - preencher DEPOIS dele
949:             THIS.this_oBusinessObject.NovoRegistro()
950:             THIS.this_oBusinessObject.this_cCidChaves = loc_cIdChave
951:             THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(THIS.this_cMoeda)
952:             THIS.this_oBusinessObject.this_dData      = loc_dData
953:             THIS.this_oBusinessObject.this_cHora      = loc_cHora
954:             THIS.this_oBusinessObject.this_nValor     = 0
955: 
956:             *-- Grava em SigCdCot na hora (legado tambem grava no Insert Into
957:             *-- CrSigCdCot do Click, e nao no Encerrar) - assim a cotacao
958:             *-- sobrevive mesmo se o usuario fechar sem clicar Encerrar
959:             IF THIS.this_oBusinessObject.Salvar()
960:                 *-- APPEND BLANK deixa o registro NOVO como corrente em
961:                 *-- cursor_4c_Dados - e nele que o BOParaForm grava (espelha o
962:                 *-- segundo Insert do inserir.Click legado, que replicava em
963:                 *-- CrSigCdCot os mesmos valores que foram para a tabela)
964:                 APPEND BLANK IN cursor_4c_Dados
965:                 THIS.BOParaForm()
966: 
967:                 THIS.this_nIncluir = RECNO("cursor_4c_Dados")
968:             ELSE
969:                 IF !THIS.this_oBusinessObject.this_lErroExibido
970:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel inserir a " + ;
971:                             "cota" + CHR(231) + CHR(227) + "o.", "Erro")
972:                 ENDIF
973:             ENDIF
974:         ENDIF
975: 
976:         *-- Popular o cursor NAO repinta a grade (CLAUDE.md regra #21)
977:         THIS.grd_4c_Dados.Refresh()
978:         THIS.grd_4c_Dados.Column1.SetFocus()
979:     ENDPROC
980: 
981:     *==========================================================================
982:     PROCEDURE BtnExcluirClick
983:     *==========================================================================
984:     *-- Espelha SIGPRCOT.delete.Click do legado: exclui de verdade em
985:     *-- SigCdCot (gravacao/exclusao nunca eh muda - CLAUDE.md) a cotacao
986:     *-- corrente da grade, depois reposiciona no mesmo cmoes+data (Set Near +
987:     *-- Seek do legado).
988:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
989:         LOCAL loc_cIdChave
990: 
991:         IF !USED("cursor_4c_Dados")
992:             RETURN
993:         ENDIF
994: 
995:         SELECT cursor_4c_Dados
996:         IF !EOF()
997:             loc_cIdChave = ALLTRIM(cidchaves)
998: 
999:             *-- Legado: lcIdChave = TmpCot.cidchaves (a linha corrente E a
1000:             *-- ficha) - o hook carrega a linha inteira, nao so a chave
1001:             THIS.FormParaBO()
1002:             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1003: 
1004:             IF THIS.this_oBusinessObject.Excluir()
1005:                 SELECT cursor_4c_Dados
1006:                 LOCATE FOR ALLTRIM(cidchaves) == loc_cIdChave
1007:                 IF FOUND()
1008:                     DELETE
1009:                 ENDIF
1010: 
1011:                 SELECT cursor_4c_Dados
1012:                 SET ORDER TO Cotacaos
1013:                 SET NEAR ON
1014:                 SEEK cmoes + DTOS(datas)
1015:                 SET NEAR OFF
1016:             ELSE
1017:                 IF !THIS.this_oBusinessObject.this_lErroExibido
1018:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir a " + ;
1019:                             "cota" + CHR(231) + CHR(227) + "o.", "Erro")
1020:                 ENDIF
1021:             ENDIF
1022:         ENDIF
1023: 
1024:         THIS.grd_4c_Dados.Refresh()
1025:         THIS.grd_4c_Dados.Column1.SetFocus()
1026:     ENDPROC
1027: 
1028:     *==========================================================================
1029:     PROCEDURE BtnSairClick
1030:     *==========================================================================
1031:     *-- Espelha SIGPRCOT.sair.Click do legado: descarta linhas nunca
1032:     *-- preenchidas (Data ou Cotacao vazias) e sincroniza as demais com
1033:     *-- SigCdCot antes de encerrar. No legado essa sincronizacao final era o
1034:     *-- TABLEUPDATE do form pai sobre CrSigCdCot (cursor bufferizado); aqui o
1035:     *-- dialogo fala com o banco pelo proprio SIGPRCOTBO, entao a gravacao
1036:     *-- final acontece linha a linha (Atualizar), nao em lote.
1037:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
1038:         LOCAL loc_cIdChave
1039: 
1040:         IF USED("cursor_4c_Dados")
1041:             SELECT cursor_4c_Dados
1042:             SCAN
1043:                 IF EMPTY(datas) OR EMPTY(valos)
1044:                     loc_cIdChave = ALLTRIM(cidchaves)
1045: 
1046:                     THIS.FormParaBO()
1047:                     THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1048: 
1049:                     IF !THIS.this_oBusinessObject.Excluir()
1050:                         IF !THIS.this_oBusinessObject.this_lErroExibido
1051:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel " + ;
1052:                                     "descartar uma cota" + CHR(231) + CHR(227) + "o " + ;
1053:                                     "n" + CHR(227) + "o preenchida.", "Erro")
1054:                         ENDIF
1055:                     ENDIF
1056: 
1057:                     SELECT cursor_4c_Dados
1058:                     LOCATE FOR ALLTRIM(cidchaves) == loc_cIdChave
1059:                     IF FOUND()
1060:                         DELETE
1061:                     ENDIF
1062:                 ENDIF
1063:                 SELECT cursor_4c_Dados
1064:             ENDSCAN
1065: 
1066:             SELECT cursor_4c_Dados
1067:             GO TOP
1068:             SCAN
1069:                 *-- Espelha o "Replace CrSigCdCot.datas/horas/valos With
1070:                 *-- TmpCot..." do sair.Click legado: a linha corrente da grade
1071:                 *-- vira a ficha que o BO grava
1072:                 THIS.FormParaBO()
1073:                 THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1074: 
1075:                 THIS.this_oBusinessObject.EditarRegistro()
1076:                 IF !THIS.this_oBusinessObject.Salvar()
1077:                     IF !THIS.this_oBusinessObject.this_lErroExibido
1078:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar " + ;
1079:                                 "uma das cota" + CHR(231) + CHR(245) + "es.", "Erro")
1080:                     ENDIF
1081:                 ENDIF
1082:                 SELECT cursor_4c_Dados
1083:             ENDSCAN
1084:         ENDIF
1085: 
1086:         THIS.Release()
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     PROTECTED PROCEDURE TornarControlesVisiveis
1091:     *==========================================================================
1092:         LPARAMETERS par_oContainer
1093:         LOCAL loc_oContainer, loc_i, loc_oControl
1094: 
1095:         IF VARTYPE(par_oContainer) = "O"
1096:             loc_oContainer = par_oContainer
1097:         ELSE

*-- Linhas 1116 a 1134:
1116:     *==========================================================================
1117:     *-- Reabilita o form pai (legado: cmdSair.Click nao faz isso
1118:     *-- explicitamente porque o Cadastro de Moedas usa dialogo NAO-modal e
1119:     *-- sincroniza via Update(); no sistema novo o pai fica Enabled=.F.
1120:     *-- enquanto o filho modal esta aberto e precisa ser reabilitado aqui,
1121:     *-- para valer em QUALQUER caminho de fechamento, nao so no botao
1122:     *-- Encerrar)
1123:         IF VARTYPE(THIS.par_oFormPai) = "O"
1124:             THIS.par_oFormPai.Enabled = .T.
1125:         ENDIF
1126: 
1127:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1128:             THIS.this_oBusinessObject = .NULL.
1129:         ENDIF
1130: 
1131:         THIS.par_oFormPai = .NULL.
1132: 
1133:         DODEFAULT()
1134:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*====================================================================
* SIGPRCOTBO.prg
*
* Business Object para Cotacao de Moeda (grade de cotacoes por data/hora)
* Tabela: SigCdCot
* Herda de: BusinessBase
*
* Este BO atende um form OPERACIONAL do tipo dialogo modal filho: eh
* aberto a partir do cadastro de Moedas (FormMoe) para uma unica moeda
* (par_cMoeda), e gerencia uma grade de cotacoes (data + hora + valor)
* dessa moeda. Nao segue o padrao CRUD de registro unico.
*====================================================================

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCot)
    this_cCidChaves     = ""    && cidchaves char(20) - PK (fUniqueIds())
    this_cMoeda         = ""    && cmoes char(3) - codigo da moeda (FK SigCdMoe)
    this_dData          = {}    && datas datetime - data da cotacao
    this_cHora          = ""    && horas char(8) - hora da cotacao
    this_nValor         = 0     && valos numeric(11,6) - valor da cotacao
    this_dDataAlteracao = {}    && dtalts datetime - data da ultima alteracao
    this_cUsuario       = ""    && usuars char(10) - usuario que gravou

    *-- Contexto do dialogo (moeda para a qual as cotacoes sao filtradas)
    this_cMoedaFiltro   = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCot"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRCOTBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor de cotacoes (mesma estrutura de SigCdCot)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves     = ALLTRIM(TratarNulo(cidchaves, ""))
            THIS.this_cMoeda         = ALLTRIM(TratarNulo(cmoes, ""))
            THIS.this_dData          = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_cHora          = ALLTRIM(TratarNulo(horas, ""))
            THIS.this_nValor         = TratarNulo(valos, 0)
            THIS.this_dDataAlteracao = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_cUsuario       = ALLTRIM(TratarNulo(usuars, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Carrega as cotacoes de uma moeda em cursor_4c_Dados
    * Espelha "Select * From CrSigCdCot Into Cursor TmpCot ReadWrite" do
    * Init legado (a query que abastece a grade do dialogo), incluindo os
    * dois indices que o Init cria sobre o cursor de trabalho (CidChaves -
    * usado pelo Excluir/localizacao por linha - e Cotacaos - usado pelo
    * Incluir/Sair para checar duplicidade e ordenar a grade).
    *====================================================================
    PROCEDURE Buscar(par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cMoeda
        loc_lSucesso = .F.
        loc_cMoeda   = IIF(VARTYPE(par_cMoeda) = "C", ALLTRIM(par_cMoeda), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, cmoes, datas, horas, valos, dtalts, usuars
                FROM SigCdCot
                WHERE cmoes = <<EscaparSQL(loc_cMoeda)>>
                ORDER BY cmoes, datas, horas
            ENDTEXT

            *-- A grade tem 3 colunas EDITAVEIS (data/cotacao/hora) - SQLEXEC
            *-- cria cursor SOMENTE-LEITURA, entao o resultado eh copiado para
            *-- um cursor READWRITE (CLAUDE.md: "Grid com coluna editavel
            *-- exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON cidchaves TAG CidChaves
                INDEX ON cmoes + DTOS(datas) + horas TAG Cotacaos

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar cota" + CHR(231) + CHR(227) + "oes:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SIGPRCOTBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova cotacao na tabela SigCdCot
    * Espelha SIGPRCOT.inserir.Click do legado: gera cidchaves, grava
    * data/hora/usuario de alteracao no momento da inclusao.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_dDataAlteracao = DATE()
            THIS.this_cUsuario       = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuario)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCot (cmoes, datas, horas, valos, cidchaves, dtalts, usuars)
                VALUES (
                    <<EscaparSQL(ALLTRIM(THIS.this_cMoeda))>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<EscaparSQL(THIS.this_cHora)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 6)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    <<EscaparSQL(THIS.this_cUsuario)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRCOTBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza cotacao existente na tabela SigCdCot
    * Espelha SIGPRCOT.sair.Click do legado (sincronizacao datas/horas/
    * valos do cursor de edicao para a tabela), atualizando tambem o
    * carimbo de data/usuario da alteracao.
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDataAlteracao = DATE()
            THIS.this_cUsuario       = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuario)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCot
                SET datas  = <<FormatarDataSQL(THIS.this_dData)>>,
                    horas  = <<EscaparSQL(THIS.this_cHora)>>,
                    valos  = <<FormatarNumeroSQL(THIS.this_nValor, 6)>>,
                    dtalts = <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    usuars = <<EscaparSQL(THIS.this_cUsuario)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRCOTBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui cotacao da tabela SigCdCot
    * Espelha SIGPRCOT.delete.Click do legado (Delete From SigCdCot
    * Where cidchaves = ...).
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Registro sem chave para exclus" + CHR(227) + "o."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdCot
                    WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRCOTBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

