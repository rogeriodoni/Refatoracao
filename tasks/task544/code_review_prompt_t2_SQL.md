# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPTRANS, EMPS, TPS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TPTRANS, EMPS, TPS, CIDCHAVES

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
lcQuery = [Select * From SigPrTra Where TPTrans = ']+pcCodigos+[']
Select crSigPrTrn
ThisForm.Grid1.Column1.ControlSource = 'crSigPrTrn.Emps'
ThisForm.Grid1.Column2.ControlSource = 'crSigPrTrn.TpTrans'
ThisForm.Grid1.Column3.ControlSource = 'crSigPrTrn.Tps'
	Select crSigPrTrn
	If Not Seek(This.Value, 'crSigPrTrn', 'Codigos')
	Select crSigPrTrn
	Select crSigPrTrn
Select crSigPrTrn
ThisForm.poDatamgr.Update('crSigPrTrn')
Select crSigPrTrn
Select crSigPrTrn
Select crSigPrTrn
Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormTPG.prg) - TRECHOS RELEVANTES PARA PASS SQL (902 linhas total):

*-- Linhas 10 a 56:
10: *   cmdinserir / cmdexcluir            -> cnt_4c_Botoes.cmd_4c_Incluir/Excluir
11: *   Commandgroup1.Command3 "Encerrar"  -> cnt_4c_Saida.cmd_4c_Encerrar
12: *     (no legado, o clique de Encerrar tambem valida a grade e grava tudo
13: *     via poDataMgr.Update+Commit antes de fechar - ver comportamento.json)
14: *
15: * Fase 3/8 - Estrutura base: propriedades, Init, InicializarForm, cabecalho
16: * Fase 4/8 - Grid editavel + botoes Incluir/Excluir/Encerrar
17: *   A grade legada eh editada linha-a-linha em memoria e so persiste tudo
18: *   no clique de Encerrar (poDataMgr.Update+Commit, modelo bufferizado).
19: *   BusinessBase/DataAccess desta arquitetura nao tem commit em lote, entao
20: *   a adaptacao persiste linha a linha (Salvar()/ExcluirPorChave() por
21: *   registro) preservando o MESMO resultado final que o usuario ve: a
22: *   validacao (Empty(Emps)/Empty(Tps)) roda ANTES de qualquer gravacao,
23: *   igual ao legado, e Excluir remove o registro na hora (nao bufferiza).
24: *   Sem AlternarPagina(): este form eh flat/single-page (sem PageFrame,
25: *   ver Fase 3) - nao existe segunda pagina para alternar. Criar um metodo
26: *   vazio so para "existir" seria um stub disfarcado (proibido).
27: * Fase 5/8 - N/A (ConfigurarPaginaDados / campos de Page2): o SIGCDTPG legado
28: *   nao tem segunda pagina de edicao (analise.json: campos=[], labels=[];
29: *   layout.json: 16 objetos, todos ja cobertos nas Fases 3-4). Os 3 unicos
30: *   dados (Emps/TpTrans/Tps) sao editados direto nas colunas do Grid1, ja
31: *   migradas em ConfigurarGrid()/ConfigurarGridDados() (Fase 4). Mesma
32: *   excecao que o CLAUDE.md ja documenta para FormFpd/FormGcp: form sem
33: *   pagina de dados real. Adicionar um ConfigurarPaginaDados() vazio so
34: *   para bater com o template das Fases 5-7 seria o mesmo stub disfarcado
35: *   vetado acima para AlternarPagina() - por isso a Fase 5 nao alterou
36: *   este arquivo.
37: * Fase 7/8 - N/A (BtnAlterarClick/BtnVisualizarClick): o SIGCDTPG legado
38: *   (SECAO 1 do dump) tem SOMENTE 3 CommandButtons - cmdinserir, cmdexcluir
39: *   e Command3 "Encerrar" dentro de Commandgroup1 (ButtonCount=1). NAO
40: *   existe Alterar nem Visualizar no original. A edicao dos dados eh feita
41: *   direto nas celulas do Grid1 (Column1/2/3.Text1.ControlSource ligado a
42: *   crSigPrTrn.Emps/TpTrans/Tps, com Valid por coluna) - ja migrada como
43: *   Col1EmpsKeyPress/Col2TpTransKeyPress/Col3TpsKeyPress na Fase 6.
44: *   BtnIncluirClick e BtnExcluirClick (os 2 unicos botoes CRUD do legado)
45: *   ja foram implementados na Fase 4, e BtnEncerrarClick (o Command3 -
46: *   equivalente ao "Salvar" deste form) tambem. Criar BtnAlterarClick/
47: *   BtnVisualizarClick vazios so para bater com o template das fases
48: *   seria tanto um stub disfarcado (proibido) quanto uma funcionalidade
49: *   inventada sem base no legado (viola o PILAR 1) - por isso a Fase 7
50: *   nao alterou os metodos de clique deste form.
51: * Fase 6/8 - Lookups das 3 colunas do Grid1 (fonte: SIGCDTPG_form_codigo_
52: *   fonte.txt, secao 3, Valid de Column1/Column2/Column3.Text1):
53: *   - Column1 (Emps): legado chama fAcessoEmpresa(Usuar,'C',...) - funcao
54: *     NAO portada (lesson feedback_facessoempresa_nao_portada). Substituida
55: *     pelo padrao canonico: valida existencia em SigCdEmp e abre
56: *     AbrirLookupCanonico("SigCdEmp","cemps","razas",...) quando nao acha

*-- Linhas 277 a 295:
277:             .ColumnCount   = 3
278:             .FontName      = "Tahoma"
279:             .FontSize      = 8
280:             .DeleteMark    = .F.
281:             .RecordMark    = .F.
282:             .RowHeight     = 16
283:             .ScrollBars    = 2
284:             .ForeColor     = RGB(90, 90, 90)
285:             .GridLineColor = RGB(238, 238, 238)
286:             .Visible       = .T.
287:         ENDWITH
288: 
289:         *-- Column1: Empresa (Emps) - alinhado a direita
290:         loc_oCol = loc_oGrid.Column1
291:         WITH loc_oCol
292:             .FontName  = "Tahoma"
293:             .FontSize  = 8
294:             .Alignment = 3
295:             .Width     = 56

*-- Linhas 361 a 381:
361: 
362:         IF USED("cursor_4c_Dados")
363:             loc_oGrid.RecordSource = "cursor_4c_Dados"
364:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
365:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tptrans"
366:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tps"
367:         ENDIF
368: 
369:         *-- RecordSource reseta Width/Header1.Caption (Problema 48) - reaplicar
370:         loc_oGrid.Column1.Width            = 56
371:         loc_oGrid.Column1.Header1.Caption  = "Empresa"
372:         loc_oGrid.Column2.Width            = 89
373:         loc_oGrid.Column2.Header1.Caption  = "Tipo de Transp."
374:         loc_oGrid.Column3.Width            = 56
375:         loc_oGrid.Column3.Header1.Caption  = "Tipo (T/R)"
376: 
377:         loc_oGrid.Refresh()
378:     ENDPROC
379: 
380:     *==========================================================================
381:     * ConfigurarBotoesCrud - cnt_4c_Botoes com cmd_4c_Incluir/cmd_4c_Excluir

*-- Linhas 535 a 554:
535:                             USE IN cursor_4c_LkpChk
536:                         ENDIF
537: 
538:                         IF SQLEXEC(gnConnHandle, ;
539:                                 "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cValor), ;
540:                                 "cursor_4c_LkpChk") > 0 AND ;
541:                            USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
542:                             loc_lAchou = .T.
543:                         ENDIF
544: 
545:                         IF USED("cursor_4c_LkpChk")
546:                             USE IN cursor_4c_LkpChk
547:                         ENDIF
548:                     CATCH TO loc_oErro
549:                         MsgErro(loc_oErro.Message, "FormTPG.Col1EmpsKeyPress")
550:                     ENDTRY
551: 
552:                     IF !loc_lAchou
553:                         THIS.AbrirLookupEmpresa(loc_oTxt)
554:                     ENDIF

*-- Linhas 586 a 605:
586:                             USE IN cursor_4c_LkpChk
587:                         ENDIF
588: 
589:                         IF SQLEXEC(gnConnHandle, ;
590:                                 "SELECT codigos FROM SigPrTrn WHERE codigos = " + EscaparSQL(loc_cValor), ;
591:                                 "cursor_4c_LkpChk") > 0 AND ;
592:                            USED("cursor_4c_LkpChk") AND RECCOUNT("cursor_4c_LkpChk") > 0
593:                             loc_lAchou = .T.
594:                         ENDIF
595: 
596:                         IF USED("cursor_4c_LkpChk")
597:                             USE IN cursor_4c_LkpChk
598:                         ENDIF
599:                     CATCH TO loc_oErro
600:                         MsgErro(loc_oErro.Message, "FormTPG.Col2TpTransKeyPress")
601:                     ENDTRY
602: 
603:                     IF !loc_lAchou
604:                         THIS.AbrirLookupTpTrans(loc_oTxt)
605:                     ENDIF

*-- Linhas 681 a 699:
681:             ENDCASE
682: 
683:             TRY
684:                 SELECT cursor_4c_Dados
685:                 loc_nRegAtual = RECNO()
686:                 loc_cEmp      = emps
687:                 loc_cTra      = tptrans
688:                 loc_cTps      = tps
689:                 loc_cChave    = cidchaves
690: 
691:                 LOCATE FOR emps = loc_cEmp AND tptrans = loc_cTra AND ;
692:                            tps = loc_cTps AND cidchaves <> loc_cChave
693: 
694:                 IF !EOF()
695:                     MsgAviso("Tipo de Transfer" + CHR(234) + "ncia Cadastrada", ;
696:                              "Aten" + CHR(231) + CHR(227) + "o")
697:                     GO loc_nRegAtual IN cursor_4c_Dados
698:                     THIS.grd_4c_Dados.Refresh()
699:                     IF VARTYPE(loc_oCol) = "O"

*-- Linhas 729 a 747:
729:             ENDIF
730: 
731:             IF loc_lProsseguir
732:                 SELECT cursor_4c_Dados
733:                 LOCATE FOR EMPTY(emps) AND EMPTY(tptrans) AND EMPTY(tps)
734:                 IF EOF()
735:                     APPEND BLANK
736:                     REPLACE cidchaves WITH fUniqueIds(), ;
737:                             flagnovo  WITH .T.
738:                     GO TOP
739:                 ENDIF
740: 
741:                 =fGravarLog("I", "SigPrTrnG", "INSERIR", "")
742: 
743:                 THIS.grd_4c_Dados.Refresh()
744:                 THIS.grd_4c_Dados.SetFocus()
745:                 THIS.grd_4c_Dados.Column1.SetFocus()
746:             ENDIF
747: 

*-- Linhas 770 a 788:
770:             ENDIF
771: 
772:             IF loc_lProsseguir
773:                 SELECT cursor_4c_Dados
774:                 IF EOF()
775:                     loc_lProsseguir = .F.
776:                 ENDIF
777:             ENDIF
778: 
779:             IF loc_lProsseguir
780:                 IF !MsgConfirmaExclusao()
781:                     loc_lProsseguir = .F.
782:                 ENDIF
783:             ENDIF
784: 
785:             IF loc_lProsseguir
786:                 loc_cCidChaves = cursor_4c_Dados.cidchaves
787:                 loc_lNovo      = cursor_4c_Dados.flagnovo
788:                 loc_cChave     = ALLTRIM(cursor_4c_Dados.emps) + " - " + ;

*-- Linhas 799 a 818:
799:             IF loc_lProsseguir
800:                 =fGravarLog("E", "SigPrTrnG", "EXCLUSAO", loc_cChave)
801: 
802:                 SELECT cursor_4c_Dados
803:                 DELETE
804:                 PACK
805:                 GO TOP
806: 
807:                 THIS.grd_4c_Dados.Refresh()
808:                 THIS.grd_4c_Dados.SetFocus()
809:                 THIS.grd_4c_Dados.Column1.SetFocus()
810:             ENDIF
811: 
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message + CHR(13) + ;
814:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
815:                     "Procedure: " + loc_oErro.Procedure, ;
816:                     "Erro em FormTPG.BtnExcluirClick")
817:         ENDTRY
818:     ENDPROC

*-- Linhas 830 a 871:
830: 
831:         TRY
832:             IF USED("cursor_4c_Dados")
833:                 SELECT cursor_4c_Dados
834:                 GO TOP
835:                 SCAN
836:                     IF EMPTY(cursor_4c_Dados.emps)
837:                         MsgAviso("Empresa Inv" + CHR(225) + "lida !!", ;
838:                                  "Aten" + CHR(231) + CHR(227) + "o")
839:                         THIS.grd_4c_Dados.SetFocus()
840:                         THIS.grd_4c_Dados.Column1.SetFocus()
841:                         loc_lValido = .F.
842:                         EXIT
843:                     ENDIF
844:                     IF EMPTY(cursor_4c_Dados.tps)
845:                         MsgAviso("Tipo Inv" + CHR(225) + "lido !!", ;
846:                                  "Aten" + CHR(231) + CHR(227) + "o")
847:                         THIS.grd_4c_Dados.SetFocus()
848:                         THIS.grd_4c_Dados.Column3.SetFocus()
849:                         loc_lValido = .F.
850:                         EXIT
851:                     ENDIF
852:                 ENDSCAN
853:             ENDIF
854: 
855:             IF loc_lValido AND USED("cursor_4c_Dados")
856:                 SELECT cursor_4c_Dados
857:                 GO TOP
858:                 SCAN
859:                     IF cursor_4c_Dados.flagnovo
860:                         THIS.this_oBusinessObject.NovoRegistro()
861:                     ELSE
862:                         IF !THIS.this_oBusinessObject.EditarRegistro()
863:                             loc_lSucesso = .F.
864:                             EXIT
865:                         ENDIF
866:                     ENDIF
867: 
868:                     THIS.this_oBusinessObject.this_cCidChaves = cursor_4c_Dados.cidchaves
869:                     THIS.this_oBusinessObject.this_cEmps      = cursor_4c_Dados.emps
870:                     THIS.this_oBusinessObject.this_cTpTrans   = cursor_4c_Dados.tptrans
871:                     THIS.this_oBusinessObject.this_cTps       = cursor_4c_Dados.tps


### BO (C:\4c\projeto\app\classes\TPGBO.prg):
*==============================================================================
* TPGBO.prg - Business Object para Tipos de Transporte Automatico
*==============================================================================
* Tabela   : SigPrTra
* PK real  : cidchaves (CHAR 20, gerado por fUniqueIds)
* Chave neg: emps + tptrans + tps
* Herda de : BusinessBase (app\classes\businessbase.prg)
*
* Fase 1/8 - Propriedades e Init
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS TPGBO AS BusinessBase

    *==========================================================================
    *-- PROPRIEDADES DA TABELA SigPrTra (schema exato)
    *==========================================================================

    *-- Chave primaria real (gerada por fUniqueIds)
    this_cCidChaves = ""    && cidchaves CHAR(20) - PK

    *-- Chave de negocio composta: Emps + TpTrans + Tps
    this_cEmps      = ""    && emps      CHAR(3)  - Codigo da Empresa
    this_cTpTrans   = ""    && tptrans   CHAR(6)  - Codigo do Tipo de Transporte (FK SigPrTrn.codigos)
    this_cTps       = ""    && tps       CHAR(1)  - Tipo (T=Transporte / R=Recepcao)

    *-- Coluna NOT NULL sem campo na tela original (regra #22 CLAUDE.md)
    this_cModulos   = ""    && modulos   CHAR(1)  - Modulo (nao exibido no legado)

    *==========================================================================
    *-- INICIALIZACAO
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTra"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "TPGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- AUDITORIA: retorna PK real para RegistrarAuditoria()
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    *-- CarregarDoCursor - Carrega propriedades a partir de uma linha do
    *-- cursor de dados (crSigPrTrn no legado / cursor_4c_Dados no migrado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cTpTrans   = TratarNulo(TpTrans,   "C")
                THIS.this_cTps       = TratarNulo(Tps,       "C")
                THIS.this_cModulos   = TratarNulo(Modulos,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPGBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Inserir - Grava novo registro na tabela SigPrTra
    *-- Cobre TODAS as colunas NOT NULL (emps, tptrans, tps, cidchaves, modulos)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTra (emps, tptrans, tps, cidchaves, modulos)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cModulos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPGBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Atualizar - Atualiza registro existente na tabela SigPrTra
    *-- Chave de localizacao: cidchaves (PK real, imutavel)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTra
                SET emps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    tptrans = <<EscaparSQL(THIS.this_cTpTrans)>>,
                    tps     = <<EscaparSQL(THIS.this_cTps)>>,
                    modulos = <<EscaparSQL(THIS.this_cModulos)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPGBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- CarregarLista - Popula cursor_4c_Dados (READWRITE) com todos os
    *-- registros de SigPrTra, na ordem Emps+TpTrans+Tps (Index EmpTp legado)
    *-- Cursor precisa ser READWRITE porque a grade do form eh EDITAVEL
    *-- diretamente sobre as celulas (regra: grid editavel + cursor de
    *-- SQLEXEC = somente leitura)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, emps, tptrans, tps
                FROM SigPrTra
                ORDER BY emps, tptrans, tps
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT cidchaves, emps, tptrans, tps, .F. AS flagnovo ;
                    FROM cursor_4c_DadosTmp ;
                    INTO CURSOR cursor_4c_Dados READWRITE

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON emps + tptrans + tps TAG EmpTp
                SET ORDER TO TAG EmpTp
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "TPGBO.CarregarLista")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                        "TPGBO.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- ExcluirPorChave - Exclui diretamente um registro ja persistido de
    *-- SigPrTra pela PK real (cidchaves). Usado pela grade editavel do form,
    *-- que grava/exclui linha a linha (NUNCA chamar ExecutarExclusao() daqui
    *-- - este metodo eh o caminho publico equivalente para exclusao por
    *-- linha de grade, fora do fluxo de registro unico de BusinessBase)
    *==========================================================================
    FUNCTION ExcluirPorChave(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cCidChaves, "")))
            RETURN .F.
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigPrTra
                WHERE cidchaves = <<EscaparSQL(par_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                        "TPGBO.ExcluirPorChave")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

