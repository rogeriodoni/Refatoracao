# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SEQDIVS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS

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
  Column1.ControlSource = "Alltrim( Temp_DivOp.Dopes ) + ' ' + Alltrim( fGerMascara( Numes ) )"
  Column2.ControlSource = "Temp_DivOp.Qtds"
  Column3.ControlSource = "Temp_DivOp.QtdDivs"
  Column4.ControlSource = "Temp_DivOp.CodCors"
  Column5.ControlSource = "Temp_DivOp.CodTams"
  ControlSource = "Temp_DivOp.Nrped"
  ControlSource = "Temp_DivOp.Qtdade"
  ControlSource = "Temp_DivOp.qtdetiqs"
  ControlSource = "Temp_DivOp.CodTams"
  ControlSource = "Temp_DivOp.Obss"
Select crSigOpPic
	lcQuery = [Update SigOpPic Set SeqDivs = 0 Where cIdChaves = '] + crSigOpPic.cIdChaves + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic 1)')
Select Temp_DivOp
	Select crSigOpPic
			lcQuery = [Update SigOpPic ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigOpPic 2)')
Select crSigOpPic
Select crSigPdMvf
If Seek(Str(lnOp, 10))
	lcQuery = [Update SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigPdMvf)')
Select crSigCdNec
	Select crSigPdMvf
	Select crSigOpPic
		Insert Into Temp_DivOp (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, SeqDivs, Cpros, CodCors, CodTams, Citens) ;
	Select Temp_DivOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS SQL (842 linhas total):

*-- Linhas 63 a 81:
63:  *      arquivo idempotente perante o corretor.
64:  * Verificado: COMPILE sem .ERR nos dois arquivos, CREATEOBJECT + Show() OK em
65:  * VFP9 -T, grade com as 5 colunas/larguras/captions do pColuna legado, cursor
66:  * de 12 campos igual ao Create Cursor Temp_DivOp, e os handlers auxiliares
67:  * chamados de fora da classe sem erro.
68: *==============================================================================
69: DEFINE CLASS FormSigPrAop AS FormBase
70: 
71:     *-- Propriedades visuais (legado 702x436, escalado para o canonico 1000x600)
72:     Width       = 1000
73:     Height      = 600
74:     AutoCenter  = .T.
75:     BorderStyle = 2
76:     *-- ShowWindow/WindowType so podem ser definidos AQUI, na classe: medido no
77:     *-- VFP9 (2026-09-26, automation\vfp_helpers\medir_showwindow.prg) que
78:     *-- ShowWindow eh READ-ONLY em runtime - atribuir em qualquer ponto, inclusive
79:     *-- dentro do proprio Init, estoura "Property SHOWWINDOW is read-only", o
80:     *-- CREATEOBJECT devolve .F. e o menu nao abre a tela. WindowType, ao
81:     *-- contrario, aceita atribuicao em runtime (eh o que o TestFormWrapper faz

*-- Linhas 252 a 324:
252:             .HeaderHeight  = 17
253:             .RowHeight     = 17
254:             .ScrollBars    = 2
255:             .DeleteMark    = .F.
256:             .RecordMark    = .F.
257: 
258:             .Column1.ControlSource   = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + ALLTRIM(fGerMascara(cursor_4c_DivOp.Numes))"
259:             .Column1.Width           = 180
260:             .Column1.Alignment       = 0
261:             .Column1.ReadOnly        = .T.
262:             .Column1.Movable         = .F.
263:             .Column1.Resizable       = .F.
264:             .Column1.FontName        = "Arial"
265:             .Column1.FontSize        = 8
266:             .Column1.Header1.Caption = "Pedido"
267: 
268:             .Column2.ControlSource   = "cursor_4c_DivOp.CodCors"
269:             .Column2.Width           = 38
270:             .Column2.ReadOnly        = .T.
271:             .Column2.Movable         = .F.
272:             .Column2.Resizable       = .F.
273:             .Column2.FontName        = "Arial"
274:             .Column2.FontSize        = 8
275:             .Column2.Header1.Caption = "Cor"
276: 
277:             .Column3.ControlSource   = "cursor_4c_DivOp.CodTams"
278:             .Column3.Width           = 38
279:             .Column3.ReadOnly        = .T.
280:             .Column3.Movable         = .F.
281:             .Column3.Resizable       = .F.
282:             .Column3.FontName        = "Arial"
283:             .Column3.FontSize        = 8
284:             .Column3.Header1.Caption = "Tam"
285: 
286:             .Column4.ControlSource   = "cursor_4c_DivOp.Qtds"
287:             .Column4.Width           = 80
288:             .Column4.Alignment       = 1
289:             .Column4.InputMask       = "999,999.999"
290:             .Column4.ReadOnly        = .T.
291:             .Column4.Movable         = .F.
292:             .Column4.Resizable       = .F.
293:             .Column4.FontName        = "Arial"
294:             .Column4.FontSize        = 8
295:             .Column4.Header1.Caption = "Qtd.Atual"
296: 
297:             .Column5.ControlSource   = "cursor_4c_DivOp.QtdDivs"
298:             .Column5.Width           = 80
299:             .Column5.Format          = "K"
300:             .Column5.ReadOnly        = .F.
301:             .Column5.Movable         = .F.
302:             .Column5.Resizable       = .F.
303:             .Column5.FontName        = "Arial"
304:             .Column5.FontSize        = 8
305:             .Column5.Header1.Caption = "Quantidade"
306:         ENDWITH
307: 
308:         *-- Legado: Grade.AfterRowColChange -> ThisForm.Get_obss.Refresh
309:         *-- (o EditBox de observacoes eh ligado por ControlSource direto ao
310:         *-- cursor - so precisa ser avisado para redesenhar ao mudar de linha)
311:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
312:     ENDPROC
313: 
314:     *--------------------------------------------------------------------------
315:     * ConfigurarBotoes - cria o grupo Confirmar/Encerrar (SIGPRAOP.Grupo_Conf
316:     * do legado). Top=-2/Left=544 posiciona o grupo flutuando SOBRE a faixa
317:     * do cabecalho (cnt_4c_Cabecalho, Top=0..80, ja criado por
318:     * ConfigurarPageFrame ANTES deste metodo - regra da faixa ser o PRIMEIRO
319:     * AddObject da tela, senao ela cobriria estes botoes).
320:     *
321:     * Confirmar (Buttons(1)) grava a divisao de quantidade em SigOpPic/
322:     * SigPdMvf (equivalente a Grupo_Conf.Salva.Click); Encerrar (Buttons(2))
323:     * fecha o form (equivalente a Grupo_Conf.Conf_Sair.Click). BINDEVENT dos
324:     * Click fica para a Fase 7-8, junto com o resto dos eventos do form.

*-- Linhas 411 a 429:
411:     * sigacess() no codigo fonte original) - a "busca" da O.P. eh a propria
412:     * consulta SQL do Valid, ja implementada em CarregarDados (Fase 5).
413:     *
414:     * edt_4c_Obss (Get_obss): EditBox somente-leitura ligado por ControlSource
415:     * direto ao cursor da grade (cursor_4c_DivOp.Obss) - o VFP atualiza o
416:     * conteudo sozinho a cada mudanca de linha corrente, e AfterRowColChange
417:     * (Fase 7-8) so precisa dar THIS.edt_4c_Obss.Refresh() para redesenhar,
418:     * igual ao ThisForm.Get_obss.Refresh do legado.
419:     *--------------------------------------------------------------------------
420:     PROTECTED PROCEDURE ConfigurarCampos()
421:         THIS.AddObject("lbl_4c_Label1", "Label")
422:         WITH THIS.lbl_4c_Label1
423:             .Top       = 93
424:             .Left      = 70
425:             .Width     = 31
426:             .Height    = 15
427:             .AutoSize  = .F.
428:             .Alignment = 0
429:             .BackStyle = 0

*-- Linhas 476 a 494:
476:             .Width             = 443
477:             .Height            = 70
478:             .ReadOnly          = .T.
479:             .ControlSource     = "cursor_4c_DivOp.Obss"
480:             .DisabledBackColor = RGB(255, 255, 255)
481:         ENDWITH
482: 
483:         *-- Eventos do unico campo digitavel da tela (Get_OP do legado). Os
484:         *-- handlers sao PUBLIC de proposito: BINDEVENT com metodo PROTECTED
485:         *-- falha em silencio, e o harness de teste chama estes metodos de fora
486:         *-- da classe.
487:         *
488:         *-- Get_OP.Valid -> "KeyPress", NAO "LostFocus": BINDEVENT em "Valid"
489:         *-- nao dispara de forma confiavel em TextBox, e LostFocus dispara
490:         *-- SEMPRE (inclusive por SetFocus de outro controle), o que colocaria a
491:         *-- consulta SQL da O.P. em recursao. ENTER/TAB reproduzem o momento em
492:         *-- que o Valid do legado rodava (ao confirmar/sair do campo).
493:         BINDEVENT(THIS.txt_4c_OP, "KeyPress",  THIS, "TxtOPKeyPress")
494: 

*-- Linhas 556 a 574:
556:     *   EndIf
557:     *
558:     * O legado renomeia as colunas da grade: o objeto chamado "Column2" no SCX
559:     * eh a coluna DECLARADA em 3o lugar, ControlSource Temp_DivOp.QtdDivs,
560:     * ColumnOrder = 5 - a unica editavel (as demais tem ReadOnly = .T. e
561:     * When -> Return .f.). No migrado, que segue a ordem VISUAL, ela eh a
562:     * Column5. Conferido no dump: Column3.Name = "Column2" / .Format = "K" /
563:     * sem ReadOnly, e Grade.Column2.Text1.When = On Key Label 'ENTER'.
564:     *
565:     * Este handler NAO consulta nada (a consulta fica no KeyPress): LostFocus
566:     * dispara sempre, e chamar SQL daqui entraria em recursao.
567:     *--------------------------------------------------------------------------
568:     PROCEDURE PularParaGradeAposOP()
569:         LOCAL loc_oBO, loc_cCursor
570: 
571:         loc_oBO = THIS.this_oBusinessObject
572:         IF VARTYPE(loc_oBO) != "O"
573:             RETURN
574:         ENDIF

*-- Linhas 644 a 662:
644:     *   If Empty(This.Value) / Return          -> par_nNops = 0 apenas esvazia
645:     *   CursorQuery SigCdNec ... ChkSubn       -\
646:     *   CursorQuery SigPdMvf ... CodPds        -+-> BuscarItensPorOP (no BO)
647:     *   Scan SigOpPic / Insert Into Temp_DivOp -/
648:     *   ThisForm.Get_Produto.Value = CodPds    -> espelha this_cCodProduto
649:     *   Grupo_Conf.Salva.Enabled = .t.         -> Buttons(1).Enabled
650:     *   Messagebox 'O.P. Ja Foi Encerrada!!!'  -\
651:     *   Messagebox 'O.P. Nao Localizada!!!'    -+-> this_cMensagemErro do BO
652:     *   This.Value = ''                        -> limpa Get_OP no insucesso
653:     *   ThisForm.Grade.Refresh                 -> GO TOP + grd_4c_Dados.Refresh
654:     *
655:     * As duas mensagens do legado so aparecem com O.P. informada: digitar vazio
656:     * e sair apenas limpa a grade, sem avisar (mesmo comportamento do Valid).
657:     *
658:     * PUBLIC de proposito: o harness de teste chama CarregarDados() de fora da
659:     * classe, e metodo PROTECTED falharia em runtime mesmo passando no PEMSTATUS.
660:     *
661:     * Os acessos a txt_4c_Produto/txt_4c_OP/cmg_4c_Grupo_Conf/grd_4c_Dados
662:     * ficam sob PEMSTATUS defensivamente (o harness de teste pode chamar este

*-- Linhas 707 a 740:
707:             THIS.cmg_4c_Grupo_Conf.Buttons(1).Enabled = loc_oBO.this_lOPLocalizada
708:         ENDIF
709: 
710:         *-- Legado: Select Temp_DivOp / Go Top / ThisForm.Grade.Refresh
711:         *-- Popular o cursor NAO repinta a grade sozinho
712:         IF USED(loc_oBO.this_cCursorItens)
713:             SELECT (loc_oBO.this_cCursorItens)
714:             GO TOP
715:         ENDIF
716:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
717:             THIS.grd_4c_Dados.Refresh()
718:         ENDIF
719: 
720:         RETURN loc_lSucesso
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * BtnConfirmarClick - Transcreve o PROCEDURE Salva.Click do Grupo_Conf
725:     * legado. A parte de GRAVACAO (UPDATE SigOpPic/SigPdMvf + Commit,
726:     * inclusive o guard "lnOp = Val(Get_OP.Value) / If (lnOp = 0) / Return 0")
727:     * ja esta implementada em SigPrAopBO.Atualizar() desde a Fase 2 - este
728:     * metodo so precisa acionar o contrato BusinessBase (EditarRegistro() +
729:     * Salvar()) e replicar a limpeza feita no SUCESSO do Click legado:
730:     *
731:     *   ThisForm.Get_Op.SetFocus / ThisForm.Refresh                    -\
732:     *   ThisForm.Get_Op.Value = ' ' / ThisForm.Get_Produto.Value = ''  -+-> abaixo
733:     *   ThisForm.Grupo_Conf.Salva.Enabled = .f.                        -/
734:     *
735:     * BusinessBase.Salvar() exige this_lEmEdicao = .T. (senao recusa com
736:     * "Nao esta em modo de edicao" - regra do contrato da base); este form nao
737:     * tem Incluir/Alterar separados, entao EditarRegistro() eh chamado aqui,
738:     * imediatamente antes de Salvar() - a gravacao eh sempre uma redistribuicao
739:     * de linhas JA existentes em SigOpPic, nunca um novo registro.
740:     *

*-- Linhas 797 a 815:
797:     *--------------------------------------------------------------------------
798:     * GridAfterRowColChange - Transcreve o PROCEDURE AfterRowColChange da Grade
799:     * legada: ThisForm.Get_obss.Refresh. O EditBox edt_4c_Obss ja esta ligado
800:     * por ControlSource direto ao cursor da grade (cursor_4c_DivOp.Obss) - so
801:     * precisa ser avisado para redesenhar ao mudar de linha/coluna corrente.
802:     *--------------------------------------------------------------------------
803:     PROCEDURE GridAfterRowColChange(par_nColIndex)
804:         IF PEMSTATUS(THIS, "edt_4c_Obss", 5)
805:             THIS.edt_4c_Obss.Refresh()
806:         ENDIF
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
811:     * FILTRO: nenhum container flutuante neste form (sem Visible=.F. condicional
812:     * no legado - todos os controles de SIGPRAOP sao permanentes na tela)
813:     *--------------------------------------------------------------------------
814:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
815:         LOCAL loc_i, loc_oControl


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*============================================================================
* SigPrAopBO.prg - Business Object para Altera??o de Quantidade da O.P.
*
* Tabela principal : SigOpPic  (PK: cIdChaves char(20))
* Tabelas relacionadas:
*   - SigCdNec (EmpDNps = _Empr + DoppPads + Str(Nops,10)) -> ChkSubn (O.P. encerrada?)
*   - SigPdMvf (Nops, cIdChaves, CodPds, Qtds) -> produto e saldo total da O.P.
*   - SigCdPam (DoppPads, MascNums) -> parametros do sistema
*
* Form OPERACIONAL: permite dividir a quantidade de itens (Dopes+Numes) de
* uma Ordem de Producao ja liberada em novas sequencias (SeqDivs), gravando
* de volta em SigOpPic e atualizando o saldo total em SigPdMvf.
*
* O legado (Grupo_Conf.Salva.Click) NUNCA insere um novo registro em SigOpPic
* ou SigPdMvf - ele apenas redistribui a quantidade Qtds/SeqDivs entre linhas
* JA existentes (criadas em outro processo, fora deste form). Por isso este BO
* nao sobrescreve Inserir(): o comportamento padrao herdado de BusinessBase
* (recusar a operacao) ja eh o correto para esta entidade neste form.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) + carga de itens
*                da O.P. (BuscarItensPorOP, equivalente ao Get_OP.Valid legado)
*============================================================================

DEFINE CLASS SigPrAopBO AS BusinessBase

    *==========================================================================
    * Propriedades de cabecalho - digitadas/exibidas nos campos Get_OP/Get_Produto
    *==========================================================================
    this_nNops        = 0     && numeric(10) - Numero da O.P. (Get_OP.Value)
    this_cCodProduto  = ""    && char(10)    - Codigo do produto (SigPdMvf.CodPds, exibido em Get_Produto)

    *==========================================================================
    * Propriedades de estado - resultado da validacao da O.P. digitada
    *==========================================================================
    this_lOPLocalizada = .F.  && .T. quando a O.P. foi encontrada em SigCdNec e esta liberada
    this_lOPEncerrada  = .F.  && .T. quando SigCdNec.ChkSubn indica O.P. ja encerrada

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init
    *==========================================================================
    this_cDoppPads = ""       && char(20)     - Grupo/departamento padrao (SigCdPam.DoppPads), usado para montar EmpDNps
    this_nMascNums = 0        && numeric(1,0) - Tipo de mascara de numeracao (SigCdPam.MascNums), usado na formatacao do Pedido na grade

    *==========================================================================
    * Cursor de trabalho - grade de divisao de quantidade (equivalente ao
    * Temp_DivOp do legado). Criado/populado por BuscarItensPorOP().
    *==========================================================================
    this_cCursorItens = "cursor_4c_DivOp"

    *==========================================================================
    * Propriedades de item - espelham TODAS as colunas de SigOpPic usadas
    * neste form. Populadas por CarregarDoCursor() a partir de uma linha do
    * cursor (chave primaria = this_cIdChaves, casa com this_cCampoChave).
    *==========================================================================
    this_cIdChaves = ""       && char(20)     - SigOpPic.cIdChaves (PK)
    this_cDopes    = ""       && char(20)     - SigOpPic.Dopes
    this_nNumes    = 0        && numeric(6,0) - SigOpPic.Numes
    this_nQtds     = 0        && numeric(9,3) - SigOpPic.Qtds
    this_nSeqDivs  = 0        && numeric(3,0) - SigOpPic.SeqDivs
    this_dDataEs   = {}       && datetime     - SigOpPic.DataEs
    this_cObs      = ""       && text/memo    - SigOpPic.Obss
    this_cCpros    = ""       && char(14)     - SigOpPic.Cpros
    this_cCodCors  = ""       && char(4)      - SigOpPic.CodCors
    this_cCodTams  = ""       && char(4)      - SigOpPic.CodTams
    this_nCitens   = 0        && numeric(10,0)- SigOpPic.Citens

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela, chave primaria
    * e parametros do sistema (SigCdPam.DoppPads/MascNums), equivalente ao
    * ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crSigCdPam', ...) do legado.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "cIdChaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, "SELECT DoppPads, MascNums FROM SigCdPam", "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads = PADR(TratarNulo(cursor_4c_SigCdPam.DoppPads, ""), 20)
                    THIS.this_nMascNums = TratarNulo(cursor_4c_SigCdPam.MascNums, 0)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario digitar uma O.P. valida em BuscarItensPorOP)
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor local de divisao de
    * quantidade. Estrutura TRANSCRITA do legado (Create Cursor Temp_DivOp,
    * PROCEDURE Load do SIGPRAOP): mesma ordem, tipos e tamanhos de campo em
    * TODOS os lugares onde o cursor eh criado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado: o
    * legado tambem faz "Zap In Temp_DivOp" no inicio do Get_OP.Valid, e por um
    * motivo que vale igual aqui - fechar o alias DERRUBA o binding de quem
    * aponta para ele (grd_4c_Dados.RecordSource + as 5 Column.ControlSource +
    * edt_4c_Obss.ControlSource, todos ligados em InicializarForm). Recriando,
    * o usuario digitava a O.P. e a grade ficava permanentemente vazia mesmo
    * com o cursor cheio - sem erro e sem log, porque o CREATE CURSOR funciona.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_DivOp")
            *-- Legado: Zap In Temp_DivOp (preserva a estrutura e o binding).
            *
            *-- SET SAFETY OFF em volta eh OBRIGATORIO, nao precaucao: com
            *-- SAFETY ON o ZAP abre o dialogo modal "Zap ... Are you sure?" e
            *-- CONGELA a tela. O form eh DataSession = 2, e SET SAFETY eh
            *-- escopado por data session: medido no VFP9 (2026-09-26), dentro
            *-- da datasession privada o SAFETY vale ON mesmo com SET SAFETY OFF
            *-- no main.prg - mesmo mecanismo que reseta SET DATE/CENTURY ali.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_DivOp
            ZAP IN cursor_4c_DivOp
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_DivOp (Qtds N(12,3), QtdDivs N(12,3), Dopes C(20), Numes N(6), ;
                Dataes D NULL, Obss M NULL, Nops N(10), SeqDivs N(3), Cpros C(10), CodCors C(4), ;
                CodTams C(4), Citens N(10))
            SET NULL OFF
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarItensPorOP - Valida a O.P. digitada e carrega os itens no cursor
    * de trabalho. Equivalente ao PROCEDURE Valid do Get_OP no legado:
    *   - monta EmpDNps = _Empr + DoppPads + Str(Nops,10) (chave POSICIONAL:
    *     as partes NAO sao ALLTRIM'adas, o padding faz parte da chave)
    *   - consulta SigCdNec por EmpDNps: se nao achar ou estiver encerrada
    *     (ChkSubn), preenche mensagem de erro e retorna sem carregar nada
    *   - achando e nao encerrada, busca o produto em SigPdMvf e os itens
    *     da O.P. em SigOpPic, populando cursor_4c_DivOp com QtdDivs = Qtds
    *     (valor inicial igual ao atual) e SeqDivs sequencial (Citens local)
    *
    * Retorno: .T. quando a consulta foi executada sem erro tecnico (mesmo
    * que a O.P. nao exista ou esteja encerrada - nesses casos this_cMensagemErro
    * e this_lOPEncerrada/this_lOPLocalizada indicam o motivo); .F. em erro
    * tecnico (falha de conexao/SQL).
    *==========================================================================
    PROCEDURE BuscarItensPorOP(par_nNops)
        LOCAL loc_lSucesso, loc_cPEdn, loc_nResultado, loc_nCItem, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lOPLocalizada = .F.
        THIS.this_lOPEncerrada  = .F.
        THIS.this_cCodProduto   = ""
        THIS.this_nNops         = 0

        THIS.CriarCursorItens()

        IF VARTYPE(par_nNops) != "N" OR par_nNops = 0
            RETURN .T.
        ENDIF

        TRY
            loc_cPEdn = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(THIS.this_cDoppPads, 20) + STR(par_nNops, 10)

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                "cursor_4c_SigCdNec")

            IF loc_nResultado > 0 AND USED("cursor_4c_SigCdNec") AND !EOF("cursor_4c_SigCdNec")

                IF !cursor_4c_SigCdNec.ChkSubn
                    THIS.this_lOPLocalizada = .T.
                    THIS.this_nNops         = par_nNops

                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(loc_cPEdn), ;
                        "cursor_4c_SigPdMvfOp")
                    IF USED("cursor_4c_SigPdMvfOp") AND !EOF("cursor_4c_SigPdMvfOp")
                        THIS.this_cCodProduto = TratarNulo(cursor_4c_SigPdMvfOp.CodPds, "")
                    ENDIF
                    IF USED("cursor_4c_SigPdMvfOp")
                        USE IN cursor_4c_SigPdMvfOp
                    ENDIF

                    IF USED("cursor_4c_SigOpPicOp")
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Dopes, Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, Citens " + ;
                        "FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0), ;
                        "cursor_4c_SigOpPicOp")

                    loc_nCItem = 1
                    IF USED("cursor_4c_SigOpPicOp")
                        SELECT cursor_4c_SigOpPicOp
                        SCAN
                            INSERT INTO cursor_4c_DivOp ;
                                (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, Nops, SeqDivs, Cpros, CodCors, CodTams, Citens) ;
                                VALUES ( ;
                                    cursor_4c_SigOpPicOp.Dopes, cursor_4c_SigOpPicOp.Numes, cursor_4c_SigOpPicOp.Qtds, ;
                                    cursor_4c_SigOpPicOp.Qtds, cursor_4c_SigOpPicOp.DataEs, cursor_4c_SigOpPicOp.Obss, ;
                                    par_nNops, loc_nCItem, cursor_4c_SigOpPicOp.Cpros, cursor_4c_SigOpPicOp.CodCors, ;
                                    cursor_4c_SigOpPicOp.CodTams, cursor_4c_SigOpPicOp.Citens)
                            loc_nCItem = loc_nCItem + 1
                        ENDSCAN
                        USE IN cursor_4c_SigOpPicOp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_lOPEncerrada  = .T.
                    THIS.this_cMensagemErro = "O.P. J" + CHR(225) + " Foi Encerrada!!!"
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada!!!"
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpPic
    * (identificada por cIdChaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves = TratarNulo(cIdChaves, "")
        THIS.this_nNops     = TratarNulo(Nops, 0)
        THIS.this_cDopes    = TratarNulo(Dopes, "")
        THIS.this_nNumes    = TratarNulo(Numes, 0)
        THIS.this_nQtds     = TratarNulo(Qtds, 0)
        THIS.this_nSeqDivs  = TratarNulo(SeqDivs, 0)
        THIS.this_dDataEs   = ConverterParaData(DataEs)
        THIS.this_cObs      = TratarNulo(Obss, "")
        THIS.this_cCpros    = TratarNulo(Cpros, "")
        THIS.this_cCodCors  = TratarNulo(CodCors, "")
        THIS.this_cCodTams  = TratarNulo(CodTams, "")
        THIS.this_nCitens   = TratarNulo(Citens, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria.
    * Durante Atualizar(), this_cIdChaves eh reposicionado a cada UPDATE bem
    * sucedido (SigOpPic ou SigPdMvf), de forma que RegistrarAuditoria()
    * sempre registre a linha que acabou de ser gravada.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Atualizar - Confirma a divisao de quantidade (Grupo_Conf.Salva.Click do
    * legado). Passos, na mesma ordem do legado:
    *   1) Recarrega os itens ATUAIS da O.P. (cursor_4c_SigOpPicAtu)
    *   2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local)
    *   3) Para cada linha de cursor_4c_DivOp, localiza o primeiro item com
    *      mesmo Dopes+Numes e SeqDivs=0 e grava Qtds/SeqDivs nele
    *   4) Recalcula o saldo total (Sum Qtds) e grava em SigPdMvf
    *   5) Commit (ou Rollback se qualquer passo falhar) - transacao manual,
    *      equivalente ao ThisForm.poDataMgr.Commit() do legado
    *
    * SET EXACT OFF durante o processamento: os SEEKs usam apenas PARTE da
    * chave composta do indice local (Nops, ou Nops+Citens) - com SET EXACT
    * ON (config.prg) o SEEK exigiria a chave INTEIRA e nunca casaria.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_nOP, loc_cSQL, loc_oErro, loc_cSetExactAnt
        LOCAL loc_nQtdDivs, loc_nSeqDivs, loc_nCitens, loc_cDopes, loc_nNumes
        LOCAL loc_nQtdTotal, loc_cChaveAtual

        loc_lSucesso = .F.
        loc_lOk      = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_nNops = 0
            THIS.this_cMensagemErro = "O.P. n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_DivOp") OR RECCOUNT("cursor_4c_DivOp") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " itens para gravar."
            RETURN .F.
        ENDIF

        loc_nOP = THIS.this_nNops

        TRY
            loc_cSetExactAnt = SET("EXACT")
            SET EXACT OFF

            *-- 1) Recarrega os itens ATUAIS da O.P. direto do banco
            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens FROM SigOpPic " + ;
                "WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), "cursor_4c_SigOpPicAtu")

            IF !USED("cursor_4c_SigOpPicAtu")
                THIS.this_cMensagemErro = "Falha ao consultar os itens da O.P."
                loc_lOk = .F.
            ENDIF

            *-- 2) Zera SeqDivs de TODOS os itens da O.P. (banco + cursor local),
            *--    reproduzindo o Scan While Nops=lnOp / Replace SeqDivs With 0
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                INDEX ON STR(Nops, 10) + STR(Citens, 10) + cIdChaves TAG Nops
                SET ORDER TO Nops
                SEEK STR(loc_nOP, 10)
                SCAN WHILE loc_lOk AND Nops = loc_nOP
                    loc_cChaveAtual = cIdChaves
                    REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicAtu

                    loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 1)")
                        loc_lOk = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 3) Distribui a quantidade de cada linha do grid (cursor_4c_DivOp) no
            *--    primeiro item da O.P. com mesmo Dopes+Numes ainda com SeqDivs=0
            IF loc_lOk
                SELECT cursor_4c_DivOp
                SCAN WHILE loc_lOk
                    loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                    loc_nSeqDivs = cursor_4c_DivOp.SeqDivs
                    loc_nCitens  = cursor_4c_DivOp.Citens
                    loc_cDopes   = cursor_4c_DivOp.Dopes
                    loc_nNumes   = cursor_4c_DivOp.Numes
                    loc_cChaveAtual = ""

                    SELECT cursor_4c_SigOpPicAtu
                    SET ORDER TO Nops ASCENDING
                    SEEK STR(loc_nOP, 10) + STR(loc_nCitens, 10)
                    SCAN FOR Nops = loc_nOP AND Citens = loc_nCitens
                        IF (Dopes + STR(Numes, 6) = loc_cDopes + STR(loc_nNumes, 6)) AND SeqDivs = 0
                            REPLACE Qtds WITH loc_nQtdDivs, SeqDivs WITH loc_nSeqDivs IN cursor_4c_SigOpPicAtu
                            loc_cChaveAtual = cIdChaves
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !EMPTY(loc_cChaveAtual)
                        loc_cSQL = "UPDATE SigOpPic SET Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                   ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cChaveAtual)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigOpPic 2)")
                            loc_lOk = .F.
                        ELSE
                            THIS.this_cIdChaves = loc_cChaveAtual
                            THIS.RegistrarAuditoria("ATUALIZAR")
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_DivOp
                ENDSCAN
            ENDIF

            *-- 4) Recalcula o saldo total da O.P. (Sum Qtds To lnQtd do legado)
            *--    e grava em SigPdMvf
            IF loc_lOk
                SELECT cursor_4c_SigOpPicAtu
                SUM Qtds TO loc_nQtdTotal

                IF USED("cursor_4c_SigPdMvfAtu")
                    USE IN cursor_4c_SigPdMvfAtu
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT Nops, cIdChaves FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(loc_nOP, 0), ;
                    "cursor_4c_SigPdMvfAtu")

                IF USED("cursor_4c_SigPdMvfAtu")
                    SELECT cursor_4c_SigPdMvfAtu
                    INDEX ON STR(Nops, 10) + cIdChaves TAG Nops
                    SET ORDER TO Nops DESCENDING
                    IF SEEK(STR(loc_nOP, 10))
                        loc_cSQL = "UPDATE SigPdMvf SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal, 3) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(cursor_4c_SigPdMvfAtu.cIdChaves)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Grava" + CHR(231) + CHR(227) + "o (SigPdMvf)")
                            loc_lOk = .F.
                        ELSE
                            *-- Auditoria com a tabela correta (SigPdMvf), restaurando
                            *-- this_cTabela = "SigOpPic" logo em seguida
                            THIS.this_cTabela   = "SigPdMvf"
                            THIS.this_cIdChaves = cursor_4c_SigPdMvfAtu.cIdChaves
                            THIS.RegistrarAuditoria("ATUALIZAR")
                            THIS.this_cTabela   = "SigOpPic"
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- 5) Commit ou rollback da transacao manual
            IF loc_lOk
                SQLCOMMIT(gnConnHandle)
                ZAP IN cursor_4c_DivOp
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigOpPicAtu")
                USE IN cursor_4c_SigOpPicAtu
            ENDIF
            IF USED("cursor_4c_SigPdMvfAtu")
                USE IN cursor_4c_SigPdMvfAtu
            ENDIF

            SET EXACT &loc_cSetExactAnt.

        CATCH TO loc_oErro
            IF VARTYPE(loc_cSetExactAnt) = "C" AND !EMPTY(loc_cSetExactAnt)
                SET EXACT &loc_cSetExactAnt.
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_DivOp")
            USE IN cursor_4c_DivOp
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdNec")
            USE IN cursor_4c_SigCdNec
        ENDIF
        IF USED("cursor_4c_SigPdMvfOp")
            USE IN cursor_4c_SigPdMvfOp
        ENDIF
        IF USED("cursor_4c_SigOpPicOp")
            USE IN cursor_4c_SigOpPicOp
        ENDIF
        IF USED("cursor_4c_SigOpPicAtu")
            USE IN cursor_4c_SigOpPicAtu
        ENDIF
        IF USED("cursor_4c_SigPdMvfAtu")
            USE IN cursor_4c_SigPdMvfAtu
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

