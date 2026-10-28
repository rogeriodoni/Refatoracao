# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_OOPORIGINA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, CFOPS, CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, DOPES, CFOPS, CODIGOS

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
lcSql = [Select * From SigCdOop where Dopes=']+CrSigCdOpe.Dopes+[']
SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCfoOp')
Select * From xCfoOp Into Cursor TmpCfoOp ReadWrite
Select TmpCfoOp
	.Column1.ControlSource = 'TmpCfoOp.Cfops'
	.Column2.ControlSource = 'TmpCfoOp.ObsPads'
	.Column3.ControlSource = 'TmpCfoOp.ObsInis'
	.Column4.ControlSource = 'TmpCfoOp.ObsFins'
ArqSel = Select()
Select int(arqsel)
		Select TmpCfoOp
		Delete For Cfops = Space(10)
		Select Cfops, sum(1) From TmpCfoOp Group by 1 having sum(1) > 1 Into Cursor SecondKey
		Select SecondKey
		Select CrSigCdOop
		Append From Dbf('TmpCfoOp')
		lcSql = [Delete From SigCdOop Where Dopes = ']+CrSigCdOpe.dopes+[']
				m.lnErro1 = SigCdOpe.PodataMgr.Sqlexecute(lcSql,'')
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdOop'),1,-1)
Select TmpCfoOp
	Insert Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select TmpCfoOp
Select TmpCfoOp
	Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCfp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1066 linhas total):

*-- Linhas 19 a 37:
19: * Diferente do legado, que precisa da DataSession compartilhada so para
20: * alcancar "crSigCdOpe.Dopes", o form migrado recebe o codigo da Operacao
21: * (Dopes) diretamente como parametro escalar - SigOpCfpBO acessa o banco via
22: * SQLEXEC proprio (gnConnHandle), sem cursor global nem DataSession
23: * compartilhada com o pai (memorias feedback_cursores_globais_fortyus e
24: * feedback_datasession_1_eh_sessao_corrente). this_oParentForm continua
25: * guardado (objeto, nao mais so o nome) para as duas outras finalidades do
26: * legado: habilitar/desabilitar o pai enquanto o dialogo esta aberto
27: * (AjustarBotoesFormPai - legado "mCtrlBotoes") e posicionar o dialogo perto
28: * da grade da Lista do pai (PosicionarJuntoAoFormPai).
29: *
30: * Nao segue o padrao PageFrame Page1=Lista/Page2=Dados do CRUD: e um dialogo
31: * OPERACIONAL com layout FLAT (cabecalho + grade + botoes soltos direto no
32: * form), igual ao legado - analise.json confirma formType=OPERACIONAL e o
33: * dump (SECAO 1) nao declara PageFrame nenhum (raiz "Class: form" generico).
34: *
35: * Fase 3/8 - Estrutura base: DEFINE CLASS, propriedades, Init() (recebe
36: * par_oFormPai/par_cDopes/par_cEscolha), InicializarForm() (cria o Business
37: * Object, aparencia do form, faixa do cabecalho, posicionamento junto ao pai

*-- Linhas 74 a 100:
74: * (BINDEVENT no Click dos 3 CommandButton de ConfigurarBotoes) transcrevem
75: * cmdInserir/cmdExcluir/cmdSair do legado; SigOpCfpBO.SalvarGrade() (nova)
76: * persiste as alteracoes linha a linha (Inserir/Atualizar/ExecutarExclusao
77: * ja existentes) com o MESMO resultado final do bulk Delete+Append do
78: * legado (PILAR 3 - arquitetura obrigatoriamente diferente). O When de
79: * cada coluna de Observacao (habilita so depois do CFOP preenchido) vai
80: * em CelulaObsGradeEditavel(), chamado por TextBoxObsGridCfp_4c.When().
81: *
82: * Fase 8/8 - Consolidacao final: Destroy() acrescenta a rede de seguranca
83: * que reabilita this_oParentForm/AjustarBotoesFormPai mesmo fora do caminho
84: * de sucesso de BtnSairClick, e fecha os cursores de trabalho deste dialogo
85: * (cursor_4c_Dados/this_cCursorGrade e cursor_4c_OopOriginais) antes de
86: * DODEFAULT() (CorretorAutomatico Pattern #145). Os metodos auxiliares do
87: * template generico de form CRUD (FormParaBO/BOParaForm, HabilitarCampos/
88: * LimparCampos, CarregarLista, AjustarBotoesPorModo, BtnSalvarClick/
89: * BtnCancelarClick/BtnBuscarClick/BtnEncerrarClick) NAO se aplicam a este
90: * form OPERACIONAL: nao ha Page1/Page2, a edicao eh direto nas celulas da
91: * grade (CarregarGrade/BtnInserirClick/BtnExcluirClick da fase 4/7 cobrem o
92: * equivalente de CarregarLista/Incluir/Excluir) e o "salvar" eh
93: * SalvarGrade(), chamado por BtnSairClick (fase 7) - o proprio botao
94: * "Encerrar" do legado (cmdSair). THIS.Release() em BtnSairClick eh seguro
95: * aqui (diferente de dialogo tipo FormBuscaAuxiliar/FormSigOpCbx): este
96: * dialogo nao devolve nenhum valor por property para o chamador ler depois
97: * do Show() - toda a persistencia ja aconteceu via SalvarGrade() antes do
98: * Release(), e o legado tambem nao expõe nenhum "Retorno" no Unload do
99: * SIGOPCFP original.
100: *

*-- Linhas 364 a 400:
364:     * ConfigurarGrade - Monta a grade de Cfops permitidos (legado GradeSubN,
365:     * 4 colunas: CFOP/Obs/De/Ate - equivalentes a Cfops/ObsPads/ObsInis/
366:     * ObsFins de SigCdOop). Aqui so a ESTRUTURA visual (Width/Header/estilo
367:     * de cada coluna) - RecordSource/ControlSource ficam em CarregarGrade(),
368:     * DEPOIS do Business Object (re)criar o cursor de trabalho, porque
369:     * vincular antes seria descartado quando o cursor for recriado (mesmo
370:     * padrao de FormFpN.ConfigurarPaginaLista/CarregarDados). As colunas 1
371:     * (lookup de CFOP) e 2/3/4 (lookup de Observacao) recebem BINDEVENT nas
372:     * fases 5/6.
373:     *--------------------------------------------------------------------------
374:     PROTECTED PROCEDURE ConfigurarGrade()
375:         THIS.AddObject("grd_4c_Dados", "Grid")
376: 
377:         WITH THIS.grd_4c_Dados
378:             .Top           = 120
379:             .Left          = 281
380:             .Width         = 237
381:             .Height        = 221
382:             .ColumnCount   = 4
383:             .FontName      = "Tahoma"
384:             .FontSize      = 8
385:             .DeleteMark    = .F.
386:             .RecordMark    = .F.
387:             .RowHeight     = 16
388:             .ScrollBars    = 2
389:             .TabIndex      = 1
390:             .GridLineColor = RGB(238, 238, 238)
391:         ENDWITH
392: 
393:         WITH THIS.grd_4c_Dados.Column1
394:             .Width     = 80
395:             .Movable   = .F.
396:             .Resizable = .F.
397:             .FontName  = "Tahoma"
398:             .FontSize  = 8
399:             WITH .Header1
400:                 .FontName  = "Tahoma"

*-- Linhas 619 a 704:
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnInserirClick - Inclui linha em branco na grade (legado:
622:     * cmdInserir.Click: "Locate for Cfops = Space(10) / If Eof() / Insert
623:     * Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes,
624:     * fUniqueIds()) / Endif", reaproveitando a linha vazia se ja existir
625:     * uma - nunca abre uma segunda). this_oBusinessObject.NovoRegistro()
626:     * gera a chave (InicializarValoresPadrao -> fUniqueIds(), regra #22 -
627:     * PK Fortyus nunca pode nascer vazia) e zera as demais propriedades
628:     * (LimparDados tambem zera this_cDopes - reposto abaixo, igual ao
629:     * padrao de SigOpCflBO.this_cNums).
630:     *--------------------------------------------------------------------------
631:     PROCEDURE BtnInserirClick()
632:         LOCAL loc_cCursor
633: 
634:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
635:             RETURN
636:         ENDIF
637: 
638:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
639: 
640:         IF !USED(loc_cCursor)
641:             RETURN
642:         ENDIF
643: 
644:         SELECT (loc_cCursor)
645:         LOCATE FOR EMPTY(ALLTRIM(NVL(cfops, "")))
646: 
647:         IF EOF()
648:             THIS.this_oBusinessObject.NovoRegistro()
649:             THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
650: 
651:             SELECT (loc_cCursor)
652:             APPEND BLANK
653:             REPLACE dopes     WITH THIS.this_oBusinessObject.this_cDopes, ;
654:                     cidchaves WITH THIS.this_oBusinessObject.this_cCidChaves, ;
655:                     cfops     WITH "", ;
656:                     cgrus     WITH "", ;
657:                     obspads   WITH 0, ;
658:                     obsinis   WITH 0, ;
659:                     obsfins   WITH 0
660:         ENDIF
661: 
662:         THIS.grd_4c_Dados.Refresh()
663:         THIS.grd_4c_Dados.Column1.SetFocus()
664:     ENDPROC
665: 
666:     *--------------------------------------------------------------------------
667:     * BtnExcluirClick - Remove a linha corrente da grade (legado:
668:     * cmdExcluir.Click: "If Not Eof() / Delete / Skip / Skip - 1 / Endif").
669:     * So marca a linha como deletada no cursor de trabalho - a exclusao
670:     * efetiva em SigCdOop (quando a linha ja existia la) acontece em
671:     * SalvarGrade(), no BtnSairClick, igual ao legado (que so regrava
672:     * SigCdOop ao sair do dialogo, nunca a cada clique em Excluir).
673:     *--------------------------------------------------------------------------
674:     PROCEDURE BtnExcluirClick()
675:         LOCAL loc_cCursor
676: 
677:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
678:             RETURN
679:         ENDIF
680: 
681:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
682: 
683:         IF !USED(loc_cCursor)
684:             RETURN
685:         ENDIF
686: 
687:         SELECT (loc_cCursor)
688:         IF !EOF()
689:             DELETE
690:             SKIP
691:             SKIP -1
692:         ENDIF
693: 
694:         THIS.grd_4c_Dados.Refresh()
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     * BtnSairClick - Fecha o dialogo (legado: cmdSair.Click). So tenta
699:     * gravar quando o dialogo estava em modo editavel (legado: "If
700:     * Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible") - em
701:     * VISUALIZAR (Inserir/Excluir ocultos pelo this_cEscolha) fecha direto,
702:     * sem tocar no banco. Falhando a gravacao (Cfop duplicado ou erro de
703:     * SQL - SigOpCfpBO.SalvarGrade ja exibiu o aviso/erro), o dialogo
704:     * PERMANECE aberto para o usuario corrigir, igual ao "Return .f." do

*-- Linhas 725 a 779:
725: 
726:     *--------------------------------------------------------------------------
727:     * CarregarGrade - Popula o cursor de trabalho do Business Object com os
728:     * Cfops ja permitidos para a Operacao corrente (legado Init: "Select *
729:     * From SigCdOop where Dopes=...") e vincula o grid a ele. RecordSource/
730:     * ControlSource ficam aqui (nao em ConfigurarGrade) porque o Business
731:     * Object RECRIA o cursor a cada chamada - vincular antes seria
732:     * descartado (mesmo padrao de FormFpN.CarregarDados). Reaplica
733:     * Header1.Caption depois do ControlSource, porque RecordSource reseta
734:     * os cabecalhos das colunas.
735:     *--------------------------------------------------------------------------
736:     PROCEDURE CarregarGrade()
737:         LOCAL loc_oGrid, loc_cCursor
738: 
739:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
740:             RETURN .F.
741:         ENDIF
742: 
743:         IF !THIS.this_oBusinessObject.CarregarCfopsPermitidos()
744:             RETURN .F.
745:         ENDIF
746: 
747:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
748:         loc_oGrid   = THIS.grd_4c_Dados
749: 
750:         loc_oGrid.ColumnCount  = 4
751:         loc_oGrid.RecordSource = loc_cCursor
752: 
753:         loc_oGrid.Column1.ControlSource = loc_cCursor + ".cfops"
754:         loc_oGrid.Column2.ControlSource = loc_cCursor + ".obspads"
755:         loc_oGrid.Column3.ControlSource = loc_cCursor + ".obsinis"
756:         loc_oGrid.Column4.ControlSource = loc_cCursor + ".obsfins"
757: 
758:         loc_oGrid.Column1.Header1.Caption = "CFOP"
759:         loc_oGrid.Column2.Header1.Caption = "Obs"
760:         loc_oGrid.Column3.Header1.Caption = "De"
761:         loc_oGrid.Column4.Header1.Caption = "At" + CHR(233)
762: 
763:         IF USED(loc_cCursor)
764:             SELECT (loc_cCursor)
765:             GO TOP
766:         ENDIF
767: 
768:         loc_oGrid.Refresh()
769: 
770:         RETURN .T.
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * ValidarCfopGridExec - Corpo do Valid da celula CFOP da grade (legado
775:     * SIGOPCFP.GradeSubN.Column1.Text1.Valid: "If Lastkey() == 27 / Return"
776:     * antes de qualquer coisa - ESC na celula aborta o Valid sem tentar o
777:     * lookup, preservando o valor atual). PUBLIC: chamado de FORA da classe
778:     * do form pela celula TextBoxCfopGridCfp_4c (THISFORM.<metodo>, mesma
779:     * exigencia de BINDEVENT da regra #3).

*-- Linhas 994 a 1014:
994:     * fora de TRY, RELEASE externo), o pai NAO pode ficar desabilitado para
995:     * sempre. Repetir aqui eh idempotente (reabilitar duas vezes nao tem
996:     * efeito colateral).
997:     *
998:     * Fecha tambem cursor_4c_Dados (grade de trabalho, this_cCursorGrade do
999:     * BO) e cursor_4c_OopOriginais (snapshot usado por SalvarGrade) - os
1000:     * demais cursores temporarios (cursor_4c_BuscaCfop/Obs,
1001:     * cursor_4c_OopTemp/Duplic/Removidas) ja se fecham inline nos proprios
1002:     * metodos. O nome do cursor de grade e lido ANTES do DODEFAULT() (abaixo)
1003:     * porque FormBase.Destroy() anula THIS.this_oBusinessObject.
1004:     *
1005:     * DODEFAULT() por ULTIMO (CorretorAutomatico Pattern #145) - sem isso
1006:     * FormBase.Destroy() nao roda e o menu principal fica com popups
1007:     * encolhidos apos este dialogo fechar.
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE Destroy()
1010:         LOCAL loc_cCursorGrade
1011: 
1012:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1013:             loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
1014:         ELSE

*-- Linhas 1022 a 1043:
1022: 
1023:         IF !EMPTY(loc_cCursorGrade) AND USED(loc_cCursorGrade)
1024:             USE IN (loc_cCursorGrade)
1025:         ENDIF
1026: 
1027:         IF USED("cursor_4c_OopOriginais")
1028:             USE IN cursor_4c_OopOriginais
1029:         ENDIF
1030: 
1031:         DODEFAULT()
1032:     ENDPROC
1033: 
1034:     *--------------------------------------------------------------------------
1035:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1036:     * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
1037:     * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
1038:     * metodo fica generico para reaproveitar nas fases seguintes).
1039:     *--------------------------------------------------------------------------
1040:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1041:         LOCAL loc_nI, loc_oControl, loc_nP
1042: 
1043:         IF VARTYPE(par_oContainer) != "O"


### BO (C:\4c\projeto\app\classes\SigOpCfpBO.prg):
*==============================================================================
* SigOpCfpBO.prg - Business Object para Cfop's Permitidas por Operacao
*
* Form OPERACIONAL (popup filho do Cadastro de Operacoes - SigCdOpe): mantem
* a lista de CFOPs permitidos para uma Operacao (Dopes), com os limites de
* Observacao (Padrao/Inicial/Final) de cada CFOP.
*
* Tabela: SigCdOop (cada registro = um CFOP permitido para uma Operacao)
*   cfops      char(10) NOT NULL - codigo do CFOP permitido
*   cidchaves  char(20) NOT NULL - chave primaria (PK Fortyus, gerada com fUniqueIds())
*   dopes      char(20) NOT NULL - codigo da Operacao (FK SigCdOpe.Dopes)
*   cgrus      char(3)  NOT NULL - grupo (nao exibido na grade, preservado do SELECT *)
*   obspads    numeric(3,0) NOT NULL - observacao padrao
*   obsinis    numeric(3,0) NOT NULL - observacao inicial
*   obsfins    numeric(3,0) NOT NULL - observacao final
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCfpBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade (mapeamento para a tabela SigCdOop)
    * Cada instancia representa UMA linha da grade de CFOPs permitidos.
    *==========================================================================
    this_cCidChaves  = ""   && cidchaves char(20) - PK Fortyus
    this_cDopes      = ""   && dopes char(20) - codigo da Operacao (FK SigCdOpe.Dopes)
    this_cCfop       = ""   && cfops char(10) - codigo do CFOP permitido
    this_cCgrupo     = ""   && cgrus char(3) - grupo (NOT NULL, nao exibido na grade)
    this_nObsPadrao  = 0    && obspads numeric(3,0) - observacao padrao da operacao
    this_nObsInicial = 0    && obsinis numeric(3,0) - observacao inicial permitida
    this_nObsFinal   = 0    && obsfins numeric(3,0) - observacao final permitida

    *-- Cursor de trabalho do grid (legado "TmpCfoOp") - editavel, recriado
    *-- a cada CarregarCfopsPermitidos(). Nome exposto para o Form vincular
    *-- RecordSource/ControlSource DEPOIS de (re)carregar (igual a FpNBO).
    this_cCursorGrade = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdOop"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/
    * CancelarEdicao). this_cDopes TAMBEM eh limpo - eh FK para a Operacao
    * (SigCdOpe.Dopes) que o Form (fase do layout) deve repor logo apos
    * THIS.NovoRegistro(), igual ao padrao de SigOpCflBO.this_cNums.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves  = ""
        THIS.this_cDopes      = ""
        THIS.this_cCfop       = ""
        THIS.this_cCgrupo     = ""
        THIS.this_nObsPadrao  = 0
        THIS.this_nObsInicial = 0
        THIS.this_nObsFinal   = 0
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Espelha o ramo do cmdInserir.Click legado:
    *     Insert Into TmpCfoOp (Dopes, CidChaves) Values (crSigCdOpe.Dopes, fUniqueIds())
    * A chave ja nasce com a linha em branco, antes do usuario preencher o
    * CFOP - exatamente como o legado gera a PK na hora de inserir a linha na
    * grade, nao na hora de salvar.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidChaves = fUniqueIds()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir de um cursor
    * de SigCdOop (cursor_4c_Dados ou o cursor temporario da grade).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar os campos -
    * campo nao eh sintaxe valida em VFP9.
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, ao
    * posicionar na linha da grade (ex.: BtnExcluirClick/AfterRowColChange).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes,     "")
                THIS.this_cCfop       = TratarNulo(cfops,     "")
                THIS.this_cCgrupo     = TratarNulo(cgrus,     "")
                THIS.this_nObsPadrao  = TratarNulo(obspads,   0)
                THIS.this_nObsInicial = TratarNulo(obsinis,   0)
                THIS.this_nObsFinal   = TratarNulo(obsfins,   0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursorGrade - (Re)cria o cursor de trabalho do grid, vazio,
    * com a mesma estrutura de SigCdOop usada na grade (legado "TmpCfoOp" -
    * "Select * From xCfoOp Into Cursor TmpCfoOp ReadWrite"). Chamado por
    * CarregarCfopsPermitidos() antes de popular - o Form so vincula
    * RecordSource/ControlSource DEPOIS dessa chamada (regra: Column.
    * ControlSource exige que o cursor ja exista).
    *==========================================================================
    PROCEDURE InicializarCursorGrade()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                USE IN (THIS.this_cCursorGrade)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorGrade) ;
                (cidchaves C(20) NULL, dopes C(20) NULL, cfops C(10) NULL, ;
                 cgrus C(3) NULL, obspads N(3,0) NULL, obsinis N(3,0) NULL, obsfins N(3,0) NULL)
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.InicializarCursorGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCfopsPermitidos - Carrega para THIS.this_cCursorGrade todos os
    * Cfops ja permitidos da Operacao corrente (THIS.this_cDopes), espelhando
    * a consulta do Init legado ("Select * From SigCdOop where Dopes=...").
    * SQLEXEC vai para um cursor TEMPORARIO - nunca direto no cursor do grid
    * (SQLEXEC sobre o alias ligado ao Grid zera o ColumnCount). PUBLIC: o
    * Form chama de fora, apos instanciar o BO (regra #51).
    *==========================================================================
    PROCEDURE CarregarCfopsPermitidos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = THIS.InicializarCursorGrade()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF

            loc_cSQL = "SELECT cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins" + ;
                " FROM SigCdOop WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OopTemp")

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorGrade)
                IF RECCOUNT("cursor_4c_OopTemp") > 0
                    APPEND FROM DBF("cursor_4c_OopTemp")
                ENDIF
                GO TOP

                *-- Snapshot das chaves JA existentes em SigCdOop ao abrir o
                *-- dialogo - usado por SalvarGrade() (fase 7/8) para decidir
                *-- Inserir() x Atualizar() x excluir por diferenca, sem
                *-- precisar do Delete+Append em massa do legado.
                IF USED("cursor_4c_OopOriginais")
                    USE IN cursor_4c_OopOriginais
                ENDIF
                SELECT cidchaves FROM (THIS.this_cCursorGrade) ;
                    INTO CURSOR cursor_4c_OopOriginais

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OopTemp")
                USE IN cursor_4c_OopTemp
            ENDIF
            MostrarErro("Erro ao carregar Cfops permitidos:" + CHR(13) + loException.Message, "SigOpCfpBO.CarregarCfopsPermitidos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Transcricao das validacoes do legado espalhadas pelos
    * Valid das colunas da grade (Column2/Column3/Column4): a Observacao
    * Inicial nao pode ser maior que a Padrao, e a Observacao Final nao pode
    * ser menor que a Padrao. Empty(0) = .T. em VFP9, entao a checagem so
    * entra em vigor quando os dois lados estao preenchidos - igual ao legado.
    * Chamado por BusinessBase.Salvar(), que exibe a falha via ExibirFalha()
    * quando este metodo devolve .F. (regra #20) - sem MsgAviso proprio aqui.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cCfop))
            THIS.this_cMensagemErro = "Cfop n" + CHR(227) + "o informado."
        CASE EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
        CASE !EMPTY(THIS.this_nObsInicial) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsInicial > THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Inicial N" + ;
                CHR(227) + "o Pode Ser Maior do Que a Padr" + CHR(227) + "o!!!"
        CASE !EMPTY(THIS.this_nObsFinal) AND !EMPTY(THIS.this_nObsPadrao) AND ;
             (THIS.this_nObsFinal < THIS.this_nObsPadrao)
            THIS.this_cMensagemErro = "A Observa" + CHR(231) + CHR(227) + "o Final N" + ;
                CHR(227) + "o Pode Ser Menor do Que a Padr" + CHR(227) + "o!!!"
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * Inserir - Inclui um CFOP permitido para a Operacao em SigCdOop.
    * Espelha o INSERT em massa do cmdSair.Click legado (Select * From
    * TmpCfoOp / Append From Dbf), aplicado linha a linha pela arquitetura
    * nova. cgrus eh NOT NULL e nao aparece na grade - vem preservado da
    * propriedade (this_cCgrupo), carregada do SELECT * do cursor de origem.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdOop (cidchaves, dopes, cfops, cgrus, obspads, obsinis, obsfins)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                    <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCfpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza um CFOP permitido existente em SigCdOop.
    * dopes e cidchaves sao a chave do registro e NAO sao regraveis; cfops e
    * as tres observacoes (padrao/inicial/final) espelham o que o usuario
    * edita nas colunas da grade. cgrus eh regravado com o mesmo valor
    * carregado (nunca editado na tela), preservando o grupo original.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdOop
                   SET cfops   = <<EscaparSQL(LEFT(THIS.this_cCfop, 10))>>,
                       cgrus   = <<EscaparSQL(LEFT(THIS.this_cCgrupo, 3))>>,
                       obspads = <<FormatarNumeroSQL(THIS.this_nObsPadrao, 0)>>,
                       obsinis = <<FormatarNumeroSQL(THIS.this_nObsInicial, 0)>>,
                       obsfins = <<FormatarNumeroSQL(THIS.this_nObsFinal, 0)>>
                 WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCfpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExisteChaveOriginal - .T. se par_cCidChaves ja existia em SigCdOop ao
    * abrir o dialogo (snapshot cursor_4c_OopOriginais, tirado em
    * CarregarCfopsPermitidos). Usado por SalvarGrade() para decidir entre
    * Inserir() e Atualizar() - sem indice em cursor_4c_OopOriginais, por
    * isso LOCATE (poucas linhas, nao precisa de SEEK).
    *==========================================================================
    PROTECTED FUNCTION ExisteChaveOriginal(par_cCidChaves)
        LOCAL loc_lAchou, loc_cAliasAtual

        loc_lAchou = .F.

        IF USED("cursor_4c_OopOriginais")
            loc_cAliasAtual = ALIAS()
            SELECT cursor_4c_OopOriginais
            LOCATE FOR ALLTRIM(cidchaves) == ALLTRIM(NVL(par_cCidChaves, ""))
            loc_lAchou = FOUND()
            IF !EMPTY(loc_cAliasAtual) AND USED(loc_cAliasAtual)
                SELECT (loc_cAliasAtual)
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * SalvarGrade - Persiste as alteracoes da grade de Cfops permitidos
    * (this_cCursorGrade): INSERT para linha nova, UPDATE para linha
    * existente, DELETE para linha removida pelo usuario - resultado final
    * equivalente ao cmdSair.Click legado (Delete From SigCdOop Where
    * Dopes=... seguido de reinsercao INTEGRAL de TmpCfoOp), aqui aplicado
    * linha a linha pelos metodos Inserir/Atualizar/ExecutarExclusao ja
    * existentes (PILAR 3 - arquitetura obrigatoriamente diferente do
    * legado, mesmo resultado final no banco).
    *
    * Validacoes na MESMA ordem do legado:
    *   1. Descarta as linhas em branco do cursor (legado: "Delete For
    *      Cfops = Space(10)") - cmdInserir.Click (fase 7/8) cria a linha
    *      vazia; se o usuario sair sem preencher o Cfop, ela e descartada
    *      em silencio, igual ao legado.
    *   2. Cfop duplicado entre as linhas remanescentes (legado: "Select
    *      Cfops, sum(1) From TmpCfoOp Group by 1 having sum(1) > 1") ->
    *      aborta com o MESMO aviso do legado e devolve .F. SEM alterar o
    *      banco - BtnSairClick (fase 7/8) mantem o dialogo aberto para o
    *      usuario corrigir (legado: "Return .f." no meio do Click).
    *
    * As linhas que existiam ao abrir o dialogo e que nao sobraram no
    * cursor apos a etapa 1 (porque o usuario excluiu, ou porque a linha
    * em branco por acaso reaproveitou uma chave existente - nunca ocorre,
    * cidchaves de linha nova sempre vem de fUniqueIds()) sao EXCLUIDAS do
    * banco.
    *
    * PUBLIC: chamado pelo form em BtnSairClick (regra #51 - Inserir/
    * Atualizar/ExecutarExclusao continuam PROTECTED, acessados so por
    * este metodo, da PROPRIA classe).
    *==========================================================================
    PROCEDURE SalvarGrade()
        LOCAL loc_lSucesso, loc_cCursor, loc_nDuplic

        loc_lSucesso = .T.
        loc_cCursor  = THIS.this_cCursorGrade

        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        TRY
            *-- 1) descarta linhas em branco (legado: Delete For Cfops = Space(10))
            SELECT (loc_cCursor)
            DELETE FOR EMPTY(ALLTRIM(NVL(cfops, "")))

            *-- 2) duplicidade de Cfop entre as linhas remanescentes
            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF
            SELECT cfops FROM (loc_cCursor) WHERE !DELETED() ;
                GROUP BY cfops HAVING COUNT(*) > 1 INTO CURSOR cursor_4c_OopDuplic

            loc_nDuplic = RECCOUNT("cursor_4c_OopDuplic")

            IF USED("cursor_4c_OopDuplic")
                USE IN cursor_4c_OopDuplic
            ENDIF

            IF loc_nDuplic > 0
                MsgAviso("Existem Cfops em Duplicidade. Favor Acertar!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- 3) INSERT/UPDATE das linhas remanescentes
            IF loc_lSucesso
                SELECT (loc_cCursor)
                SCAN FOR !DELETED()
                    THIS.CarregarDoCursor(loc_cCursor)

                    IF THIS.ExisteChaveOriginal(THIS.this_cCidChaves)
                        loc_lSucesso = THIS.Atualizar()
                    ELSE
                        loc_lSucesso = THIS.Inserir()
                    ENDIF

                    IF !loc_lSucesso
                        EXIT
                    ENDIF

                    SELECT (loc_cCursor)
                ENDSCAN
            ENDIF

            *-- 4) exclui as linhas que existiam antes e nao sobraram no cursor
            IF loc_lSucesso AND USED("cursor_4c_OopOriginais")
                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF

                SELECT cidchaves FROM cursor_4c_OopOriginais ;
                    WHERE cidchaves NOT IN ;
                        (SELECT cidchaves FROM (loc_cCursor) WHERE !DELETED()) ;
                    INTO CURSOR cursor_4c_OopRemovidas

                SELECT cursor_4c_OopRemovidas
                SCAN
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_lSucesso = THIS.ExecutarExclusao()
                    IF !loc_lSucesso
                        EXIT
                    ENDIF
                    SELECT cursor_4c_OopRemovidas
                ENDSCAN

                IF USED("cursor_4c_OopRemovidas")
                    USE IN cursor_4c_OopRemovidas
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                "Procedure: " + loException.Procedure, "SigOpCfpBO.SalvarGrade")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui o CFOP permitido de SigCdOop.
    * Espelha o cmdExcluir.Click legado (Delete na linha corrente da grade) -
    * aqui aplicado direto na tabela, chave por cidchaves.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdOop WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Cfop permitido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCfpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

