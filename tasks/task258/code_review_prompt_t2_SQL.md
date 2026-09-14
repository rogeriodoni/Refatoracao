# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS SQL (960 linhas total):

*-- Linhas 65 a 83:
65:                     USE IN (THIS.this_cCursorDivOp)
66:                 ENDIF
67:                 SET NULL ON
68:                 CREATE CURSOR cursor_4c_DivOp ;
69:                     (Dopes    C(20)    NULL, ;
70:                      Numes    N(6,0)   NULL, ;
71:                      Qtds     N(12,3)  NULL, ;
72:                      QtdDivs  N(12,3)  NULL, ;
73:                      Dataes   D        NULL, ;
74:                      Obss     M        NULL, ;
75:                      SeqDivs  N(3,0)   NULL, ;
76:                      Cpros    C(10)    NULL, ;
77:                      CodCors  C(4)     NULL, ;
78:                      CodTams  C(4)     NULL, ;
79:                      Citens   N(10,0)  NULL, ;
80:                      cIdChaves C(50)   NULL, ;
81:                      Nops     N(10,0)  NULL)
82:                 SET NULL OFF
83: 

*-- Linhas 225 a 322:
225:             .ColumnCount   = 5
226:             .FontName      = "Arial"
227:             .FontSize      = 8
228:             .DeleteMark    = .F.
229:             .RecordMark    = .F.
230:             .GridLines     = 3
231:             .GridLineWidth = 1
232:             .HeaderHeight  = 17
233:             .RowHeight     = 17
234:             .ScrollBars    = 2
235:             .RecordSource  = THIS.this_cCursorDivOp
236: 
237:             *-- Coluna 1: Pedido (expressao Dopes + Numes, ReadOnly)
238:             WITH .Column1
239:                 .ControlSource = "RTRIM(cursor_4c_DivOp.Dopes) + ' ' + LTRIM(STR(cursor_4c_DivOp.Numes, 6))"
240:                 .Width         = 280
241:                 .FontName      = "Arial"
242:                 .FontSize      = 8
243:                 .Alignment     = 0
244:                 .ForeColor     = RGB(0, 0, 0)
245:                 .Movable       = .F.
246:                 .Resizable     = .F.
247:                 .ReadOnly      = .T.
248:                 .Header1.Caption   = "Pedido"
249:                 .Header1.FontName  = "Arial"
250:                 .Header1.FontSize  = 8
251:                 .Header1.FontBold  = .F.
252:                 .Header1.Alignment = 2
253:             ENDWITH
254: 
255:             *-- Coluna 2: Cor (CodCors, ReadOnly)
256:             WITH .Column2
257:                 .ControlSource = "cursor_4c_DivOp.CodCors"
258:                 .Width         = 60
259:                 .FontName      = "Arial"
260:                 .FontSize      = 8
261:                 .Movable       = .F.
262:                 .Resizable     = .F.
263:                 .ReadOnly      = .T.
264:                 .Header1.Caption   = "Cor"
265:                 .Header1.FontName  = "Arial"
266:                 .Header1.FontSize  = 8
267:                 .Header1.FontBold  = .F.
268:                 .Header1.Alignment = 2
269:             ENDWITH
270: 
271:             *-- Coluna 3: Tam (CodTams, ReadOnly)
272:             WITH .Column3
273:                 .ControlSource = "cursor_4c_DivOp.CodTams"
274:                 .Width         = 60
275:                 .FontName      = "Arial"
276:                 .FontSize      = 8
277:                 .Movable       = .F.
278:                 .Resizable     = .F.
279:                 .ReadOnly      = .T.
280:                 .Header1.Caption   = "Tam"
281:                 .Header1.FontName  = "Arial"
282:                 .Header1.FontSize  = 8
283:                 .Header1.FontBold  = .F.
284:                 .Header1.Alignment = 2
285:             ENDWITH
286: 
287:             *-- Coluna 4: Quantidade planejada (Qtds, ReadOnly)
288:             WITH .Column4
289:                 .ControlSource = "cursor_4c_DivOp.Qtds"
290:                 .Width         = 130
291:                 .FontName      = "Arial"
292:                 .FontSize      = 8
293:                 .Alignment     = 1
294:                 .InputMask     = "999,999.999"
295:                 .Movable       = .F.
296:                 .Resizable     = .F.
297:                 .ReadOnly      = .T.
298:                 .Header1.Caption   = "Quantidade"
299:                 .Header1.FontName  = "Arial"
300:                 .Header1.FontSize  = 8
301:                 .Header1.FontBold  = .F.
302:                 .Header1.Alignment = 2
303:             ENDWITH
304: 
305:             *-- Coluna 5: Qtd.Atual (QtdDivs, editavel ? Format K preserva valor atual)
306:             WITH .Column5
307:                 .ControlSource = "cursor_4c_DivOp.QtdDivs"
308:                 .Width         = 130
309:                 .FontName      = "Arial"
310:                 .FontSize      = 8
311:                 .Alignment     = 1
312:                 .Format        = "K"
313:                 .Movable       = .F.
314:                 .Resizable     = .F.
315:                 .Header1.Caption   = "Qtd.Atual"
316:                 .Header1.FontName  = "Arial"
317:                 .Header1.FontSize  = 8
318:                 .Header1.FontBold  = .F.
319:                 .Header1.Alignment = 2
320:             ENDWITH
321:         ENDWITH
322: 

*-- Linhas 435 a 453:
435:             .ForeColor        = RGB(0, 0, 0)
436:             .ScrollBars       = 2
437:             .ReadOnly         = .T.
438:             .ControlSource    = "cursor_4c_DivOp.Obss"
439:             .ToolTipText      = "Observa" + CHR(231) + CHR(245) + "es do item selecionado no grid"
440:         ENDWITH
441:     ENDPROC
442: 
443:     *---------------------------------------------------------------------------
444:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
445:     *-- Form OPERACIONAL nao possui PageFrame (layout plano). Metodo mantido por
446:     *-- compatibilidade com padrao dos forms CRUD e para uso futuro caso o form
447:     *-- evolua para multi-pagina. Devolve foco ao campo O.P. quando invocado.
448:     *---------------------------------------------------------------------------
449:         LOCAL loc_nPagina
450:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
451: 
452:         DO CASE
453:             CASE loc_nPagina = 1

*-- Linhas 502 a 520:
502: 
503:         *-- Zerar cursor de trabalho antes de qualquer carga
504:         IF USED(THIS.this_cCursorDivOp)
505:             SELECT (THIS.this_cCursorDivOp)
506:             ZAP
507:         ENDIF
508: 
509:         *-- Desabilitar botao Confirmar enquanto O.P. nao for validada
510:         THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
511:         THIS.txt_4c_Produto.Value = ""
512: 
513:         loc_nOP = INT(NVL(THIS.txt_4c_OP.Value, 0))
514:         IF loc_nOP <= 0
515:             THIS.grd_4c_Dados.Refresh()
516:             RETURN
517:         ENDIF
518: 
519:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
520:             MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")

*-- Linhas 606 a 624:
606: 
607:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
608:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
609:                 SELECT (THIS.this_cCursorDivOp)
610:                 GO TOP
611:                 THIS.grd_4c_Dados.SetFocus()
612:             ENDIF
613:         ELSE
614:             THIS.txt_4c_OP.SetFocus()
615:         ENDIF
616:     ENDPROC
617: 
618:     *---------------------------------------------------------------------------
619:     PROCEDURE BtnSalvarClick()
620:     *-- Grava as alteracoes das divisoes da O.P. Alias semantico para o botao
621:     *-- Confirmar do CommandGroup ??? mesma logica de BtnConfirmarClick (o form
622:     *-- operacional SIGPRAOP usa "Confirmar" na UI, mas o pipeline de validacao
623:     *-- espera BtnSalvarClick por convencao dos forms CRUD).
624:     *---------------------------------------------------------------------------

*-- Linhas 642 a 660:
642:     *-- semanticamente a "iniciar novo lote de alteracoes" no fluxo operacional.
643:     *---------------------------------------------------------------------------
644:         IF USED(THIS.this_cCursorDivOp)
645:             SELECT (THIS.this_cCursorDivOp)
646:             ZAP
647:         ENDIF
648: 
649:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
650:             THIS.txt_4c_OP.Value      = 0
651:             THIS.txt_4c_OP.Enabled    = .T.
652:             THIS.txt_4c_OP.ReadOnly   = .F.
653:             THIS.txt_4c_OP.BackColor  = RGB(255, 255, 255)
654:         ENDIF
655: 
656:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
657:             THIS.txt_4c_Produto.Value = ""
658:         ENDIF
659: 
660:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"

*-- Linhas 705 a 723:
705:         *-- Se carregou com sucesso (cursor com registros), foca no grid
706:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
707:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
708:                 SELECT (THIS.this_cCursorDivOp)
709:                 GO TOP
710:                 THIS.grd_4c_Dados.SetFocus()
711:             ENDIF
712:         ENDIF
713:     ENDPROC
714: 
715:     *---------------------------------------------------------------------------
716:     PROCEDURE BtnVisualizarClick()
717:     *-- Carrega as divisoes da O.P. em modo somente leitura (sem alteracao).
718:     *-- Torna a coluna Qtd.Atual read-only e desabilita o botao Confirmar
719:     *-- para impedir gravacao. Fluxo de consulta pura das quantidades atuais.
720:     *---------------------------------------------------------------------------
721:         IF !PEMSTATUS(THIS, "txt_4c_OP", 5) OR VARTYPE(THIS.txt_4c_OP) != "O"
722:             RETURN
723:         ENDIF

*-- Linhas 745 a 763:
745: 
746:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
747:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
748:                 SELECT (THIS.this_cCursorDivOp)
749:                 GO TOP
750:                 THIS.grd_4c_Dados.SetFocus()
751:             ENDIF
752:         ENDIF
753:     ENDPROC
754: 
755:     *---------------------------------------------------------------------------
756:     PROCEDURE BtnExcluirClick()
757:     *-- Descarta as alteracoes em andamento e retorna o form ao estado inicial.
758:     *-- Pede confirmacao ao usuario, executa TABLEREVERT no cursor de trabalho,
759:     *-- zera o cursor e limpa os campos. NUNCA exclui registros da tabela
760:     *-- SigOpPic (a exclusao definitiva nao faz parte deste fluxo operacional).
761:     *---------------------------------------------------------------------------
762:         LOCAL loc_lTemDados
763:         loc_lTemDados = USED(THIS.this_cCursorDivOp) AND ;

*-- Linhas 771 a 789:
771:             ENDIF
772: 
773:             *-- Descarta alteracoes em andamento no buffer do cursor
774:             SELECT (THIS.this_cCursorDivOp)
775:             TABLEREVERT(.T., THIS.this_cCursorDivOp)
776:             ZAP
777:         ENDIF
778: 
779:         *-- Reseta campos de identificacao
780:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
781:             THIS.txt_4c_OP.Value = 0
782:         ENDIF
783:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
784:             THIS.txt_4c_Produto.Value = ""
785:         ENDIF
786: 
787:         *-- Desabilita Confirmar e restaura coluna editavel
788:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
789:             THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.

*-- Linhas 853 a 871:
853:     *-- Limpa todos os campos do form e reseta o cursor de trabalho
854:     *---------------------------------------------------------------------------
855:         IF USED(THIS.this_cCursorDivOp)
856:             SELECT (THIS.this_cCursorDivOp)
857:             ZAP
858:         ENDIF
859: 
860:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
861:             THIS.txt_4c_OP.Value     = 0
862:             THIS.txt_4c_OP.Enabled   = .T.
863:             THIS.txt_4c_OP.ReadOnly  = .F.
864:             THIS.txt_4c_OP.BackColor = RGB(255, 255, 255)
865:         ENDIF
866: 
867:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
868:             THIS.txt_4c_Produto.Value = ""
869:         ENDIF
870: 
871:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"

*-- Linhas 898 a 916:
898:                       INT(NVL(THIS.txt_4c_OP.Value, 0)), 0)
899:         IF loc_nOP <= 0
900:             IF USED(THIS.this_cCursorDivOp)
901:                 SELECT (THIS.this_cCursorDivOp)
902:                 ZAP
903:             ENDIF
904:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
905:                 THIS.grd_4c_Dados.Refresh()
906:             ENDIF
907:             RETURN .F.
908:         ENDIF
909:         THIS.CarregarDivisoesOP()
910:         loc_lSucesso = USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
911:         RETURN loc_lSucesso
912:     ENDPROC
913: 
914:     *---------------------------------------------------------------------------
915:     PROCEDURE AjustarBotoesPorModo()
916:     *-- Ajusta estado dos botoes conforme presenca de dados no cursor de trabalho


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*******************************************************************************
* SigPrAopBO.prg - Business Object: Alteracao de Quantidade da O.P.
* Herda de BusinessBase
* Tabela principal: SigOpPic
*******************************************************************************

DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpPic"
    this_cCampoChave = "Nops"

    *-- Numero da Ordem de Producao atual
    this_nNops     = 0

    *-- Codigo do produto da OP
    this_cCodPds   = ""

    *-- Chave composta: cCodEmpresa + DoppPads + Str(Nops,10)
    this_cEmpDNps  = ""

    *-- Parametros carregados de SigCdPam
    this_cDoppPads = ""
    this_cMascNums = ""

    *-- Nome do cursor de trabalho da divisao de OP (equivalente a Temp_DivOp)
    this_cCursorDivOp = "cursor_4c_DivOp"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "SigOpPic"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            loc_cSql = "SELECT TOP 1 DoppPads, MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_cDoppPads = NVL(ALLTRIM(DoppPads), "")
                    THIS.this_cMascNums = NVL(ALLTRIM(MascNums), "")
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_SigCdPam
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarDivOp(par_nNops, par_cCursorDestino)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cEmpDNps
        LOCAL loc_nItem, loc_cCodPds, loc_lChkSubn, loc_lOPValida
        LOCAL loc_cDopes, loc_nNumes, loc_nQtds, loc_dDataes
        LOCAL loc_mObss, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nCitens, loc_cIdChaves

        loc_lSucesso  = .F.
        loc_lOPValida = .F.
        loc_nItem     = 0
        loc_cCodPds   = ""
        loc_lChkSubn  = .F.

        IF par_nNops = 0
            RETURN .F.
        ENDIF

        TRY
            *-- Monta chave EmpDNps: cCodEmpresa + DoppPads + Str(Nops,10)
            loc_cEmpDNps = go_4c_Sistema.cCodEmpresa + THIS.this_cDoppPads + STR(par_nNops, 10)
            THIS.this_cEmpDNps = loc_cEmpDNps
            THIS.this_nNops    = par_nNops

            *-- Valida OP em SigCdNec (verifica existencia e se nao foi encerrada)
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_cSql = "SELECT TOP 1 EmpDNps, ChkSubn FROM SigCdNec " + ;
                       "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdNec") > 0
                IF !EOF("cursor_4c_SigCdNec")
                    SELECT cursor_4c_SigCdNec
                    loc_lChkSubn  = NVL(cursor_4c_SigCdNec.ChkSubn, .F.)
                    loc_lOPValida = .T.
                ENDIF
                USE IN cursor_4c_SigCdNec

                IF loc_lOPValida AND loc_lChkSubn
                    MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                    loc_lOPValida = .F.
                ENDIF

                IF !loc_lOPValida AND !loc_lChkSubn AND par_nNops > 0
                    MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
                ENDIF
            ELSE
                MsgErro("Erro ao validar O.P.", "Erro")
            ENDIF

            IF loc_lOPValida
                *-- Obtem codigo do produto via SigPdMvf
                IF USED("cursor_4c_SigPdMvfLoad")
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                loc_cSql = "SELECT TOP 1 CodPds FROM SigPdMvf " + ;
                           "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfLoad") > 0
                    IF !EOF("cursor_4c_SigPdMvfLoad")
                        SELECT cursor_4c_SigPdMvfLoad
                        loc_cCodPds = NVL(ALLTRIM(cursor_4c_SigPdMvfLoad.CodPds), "")
                    ENDIF
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                THIS.this_cCodPds = loc_cCodPds

                *-- Carrega itens de SigOpPic para o cursor de trabalho
                IF USED("cursor_4c_SigOpPicLoad")
                    USE IN cursor_4c_SigOpPicLoad
                ENDIF
                loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "Cpros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicLoad") > 0
                    SELECT (par_cCursorDestino)
                    ZAP

                    SELECT cursor_4c_SigOpPicLoad
                    GO TOP
                    loc_nItem = 0
                    SCAN
                        loc_nItem     = loc_nItem + 1
                        loc_cDopes    = NVL(cursor_4c_SigOpPicLoad.Dopes, "")
                        loc_nNumes    = NVL(cursor_4c_SigOpPicLoad.Numes, 0)
                        loc_nQtds     = NVL(cursor_4c_SigOpPicLoad.Qtds, 0)
                        loc_dDataes   = cursor_4c_SigOpPicLoad.DataEs
                        loc_mObss     = NVL(cursor_4c_SigOpPicLoad.Obss, "")
                        loc_cCpros    = NVL(cursor_4c_SigOpPicLoad.Cpros, "")
                        loc_cCodCors  = NVL(cursor_4c_SigOpPicLoad.CodCors, "")
                        loc_cCodTams  = NVL(cursor_4c_SigOpPicLoad.CodTams, "")
                        loc_nCitens   = NVL(cursor_4c_SigOpPicLoad.Citens, 0)
                        loc_cIdChaves = NVL(ALLTRIM(cursor_4c_SigOpPicLoad.cIdChaves), "")

                        INSERT INTO (par_cCursorDestino) ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, SeqDivs, ;
                             Cpros, CodCors, CodTams, Citens, cIdChaves, Nops) ;
                            VALUES (loc_cDopes, loc_nNumes, loc_nQtds, loc_nQtds, ;
                                    loc_dDataes, loc_mObss, loc_nItem, ;
                                    loc_cCpros, loc_cCodCors, loc_cCodTams, ;
                                    loc_nCitens, loc_cIdChaves, par_nNops)
                    ENDSCAN

                    USE IN cursor_4c_SigOpPicLoad

                    SELECT (par_cCursorDestino)
                    IF RECCOUNT() > 0
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens de SigOpPic.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            IF USED("cursor_4c_SigPdMvfLoad")
                USE IN cursor_4c_SigPdMvfLoad
            ENDIF
            IF USED("cursor_4c_SigOpPicLoad")
                USE IN cursor_4c_SigOpPicLoad
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nNops = 0
            RETURN .F.
        ENDIF
        IF !USED(THIS.this_cCursorDivOp) OR RECCOUNT(THIS.this_cCursorDivOp) = 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_lErroInLoop
        LOCAL loc_nTotalQtds, loc_cCursorDiv, loc_nNops, loc_cChave
        LOCAL loc_nCitens, loc_cDopes, loc_nNumes, loc_nQtdDivs, loc_nSeqDivs

        loc_lSucesso    = .F.
        loc_lErroInLoop = .F.
        loc_nTotalQtds  = 0
        loc_cCursorDiv  = THIS.this_cCursorDivOp
        loc_nNops       = THIS.this_nNops

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Carrega SigOpPic fresco para esta OP (sera o espelho local das operacoes)
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                       "FROM SigOpPic " + ;
                       "WHERE Nops = " + FormatarNumeroSQL(loc_nNops, 0)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicSave") <= 0
                MsgErro("Falha ao carregar SigOpPic para gravacao.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ELSE
                *-- Passo 1: Zera SeqDivs de todos os itens da OP
                SELECT cursor_4c_SigOpPicSave
                GO TOP
                SCAN WHILE !loc_lErroInLoop
                    loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                    loc_cSql   = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                                 "WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                    IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                        MsgErro("Falha ao reinicializar O.P. Favor tentar novamente.", "Erro")
                        loc_lErroInLoop = .T.
                    ELSE
                        REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicSave
                    ENDIF
                ENDSCAN

                *-- Passo 2: Atualiza Qtds/SeqDivs conforme cursor de trabalho
                IF !loc_lErroInLoop AND USED(loc_cCursorDiv) AND RECCOUNT(loc_cCursorDiv) > 0
                    SELECT (loc_cCursorDiv)
                    GO TOP
                    SCAN WHILE !loc_lErroInLoop
                        loc_nCitens  = NVL(EVALUATE(loc_cCursorDiv + ".Citens"), 0)
                        loc_cDopes   = NVL(ALLTRIM(EVALUATE(loc_cCursorDiv + ".Dopes")), "")
                        loc_nNumes   = NVL(EVALUATE(loc_cCursorDiv + ".Numes"), 0)
                        loc_nQtdDivs = NVL(EVALUATE(loc_cCursorDiv + ".QtdDivs"), 0)
                        loc_nSeqDivs = NVL(EVALUATE(loc_cCursorDiv + ".SeqDivs"), 0)

                        *-- Localiza linha correspondente em SigOpPicSave por Citens+Dopes+Numes
                        SELECT cursor_4c_SigOpPicSave
                        GO TOP
                        SCAN FOR Nops = loc_nNops AND Citens = loc_nCitens
                            IF NVL(ALLTRIM(Dopes), "") + STR(NVL(Numes, 0), 6) = ;
                               loc_cDopes + STR(loc_nNumes, 6)
                                loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                                loc_cSql   = "UPDATE SigOpPic SET " + ;
                                             "Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                             ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                             " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                                IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                    MsgErro("Falha ao atualizar SigOpPic. Favor reinicializar.", "Erro")
                                    loc_lErroInLoop = .T.
                                ELSE
                                    REPLACE Qtds    WITH loc_nQtdDivs, ;
                                            SeqDivs WITH loc_nSeqDivs ;
                                            IN cursor_4c_SigOpPicSave
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                        SELECT (loc_cCursorDiv)
                    ENDSCAN
                ENDIF

                *-- Passo 3: Soma Qtds atualizadas e grava total em SigPdMvf
                IF !loc_lErroInLoop
                    SELECT cursor_4c_SigOpPicSave
                    loc_nTotalQtds = 0
                    SUM Qtds TO loc_nTotalQtds

                    IF USED("cursor_4c_SigPdMvfSave")
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                    loc_cSql = "SELECT TOP 1 cIdChaves FROM SigPdMvf " + ;
                               "WHERE Nops = " + FormatarNumeroSQL(loc_nNops, 0)
                    IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfSave") > 0
                        SELECT cursor_4c_SigPdMvfSave
                        IF !EOF("cursor_4c_SigPdMvfSave")
                            loc_cChave = NVL(ALLTRIM(cursor_4c_SigPdMvfSave.cIdChaves), "")
                            loc_cSql   = "UPDATE SigPdMvf SET " + ;
                                         "Qtds = " + FormatarNumeroSQL(loc_nTotalQtds, 3) + ;
                                         " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                MsgErro("Falha ao atualizar total em SigPdMvf.", "Erro")
                                loc_lErroInLoop = .T.
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                ENDIF

                IF loc_lErroInLoop
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_SigOpPicSave")
                    USE IN cursor_4c_SigOpPicSave
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            IF USED("cursor_4c_SigPdMvfSave")
                USE IN cursor_4c_SigPdMvfSave
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        RETURN THIS.Inserir()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops = NVL(Nops, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN TRANSFORM(THIS.this_nNops)
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
    *---------------------------------------------------------------------------
        LOCAL loc_cSql, loc_oErro
        TRY
            loc_cSql = "INSERT INTO LogAuditoria (Tabela, Chave, Operacao, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpPic") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar auditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

