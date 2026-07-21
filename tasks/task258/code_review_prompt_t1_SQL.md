# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SEQDIVS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS SQL (958 linhas total):

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

*-- Linhas 223 a 320:
223:             .ColumnCount   = 5
224:             .FontName      = "Arial"
225:             .FontSize      = 8
226:             .DeleteMark    = .F.
227:             .RecordMark    = .F.
228:             .GridLines     = 3
229:             .GridLineWidth = 1
230:             .HeaderHeight  = 17
231:             .RowHeight     = 17
232:             .ScrollBars    = 2
233:             .RecordSource  = THIS.this_cCursorDivOp
234: 
235:             *-- Coluna 1: Pedido (expressao Dopes + Numes, ReadOnly)
236:             WITH .Column1
237:                 .ControlSource = "RTRIM(cursor_4c_DivOp.Dopes) + ' ' + LTRIM(STR(cursor_4c_DivOp.Numes, 6))"
238:                 .Width         = 280
239:                 .FontName      = "Arial"
240:                 .FontSize      = 8
241:                 .Alignment     = 0
242:                 .ForeColor     = RGB(0, 0, 0)
243:                 .Movable       = .F.
244:                 .Resizable     = .F.
245:                 .ReadOnly      = .T.
246:                 .Header1.Caption   = "Pedido"
247:                 .Header1.FontName  = "Arial"
248:                 .Header1.FontSize  = 8
249:                 .Header1.FontBold  = .F.
250:                 .Header1.Alignment = 2
251:             ENDWITH
252: 
253:             *-- Coluna 2: Cor (CodCors, ReadOnly)
254:             WITH .Column2
255:                 .ControlSource = "cursor_4c_DivOp.CodCors"
256:                 .Width         = 60
257:                 .FontName      = "Arial"
258:                 .FontSize      = 8
259:                 .Movable       = .F.
260:                 .Resizable     = .F.
261:                 .ReadOnly      = .T.
262:                 .Header1.Caption   = "Cor"
263:                 .Header1.FontName  = "Arial"
264:                 .Header1.FontSize  = 8
265:                 .Header1.FontBold  = .F.
266:                 .Header1.Alignment = 2
267:             ENDWITH
268: 
269:             *-- Coluna 3: Tam (CodTams, ReadOnly)
270:             WITH .Column3
271:                 .ControlSource = "cursor_4c_DivOp.CodTams"
272:                 .Width         = 60
273:                 .FontName      = "Arial"
274:                 .FontSize      = 8
275:                 .Movable       = .F.
276:                 .Resizable     = .F.
277:                 .ReadOnly      = .T.
278:                 .Header1.Caption   = "Tam"
279:                 .Header1.FontName  = "Arial"
280:                 .Header1.FontSize  = 8
281:                 .Header1.FontBold  = .F.
282:                 .Header1.Alignment = 2
283:             ENDWITH
284: 
285:             *-- Coluna 4: Quantidade planejada (Qtds, ReadOnly)
286:             WITH .Column4
287:                 .ControlSource = "cursor_4c_DivOp.Qtds"
288:                 .Width         = 130
289:                 .FontName      = "Arial"
290:                 .FontSize      = 8
291:                 .Alignment     = 1
292:                 .InputMask     = "999,999.999"
293:                 .Movable       = .F.
294:                 .Resizable     = .F.
295:                 .ReadOnly      = .T.
296:                 .Header1.Caption   = "Quantidade"
297:                 .Header1.FontName  = "Arial"
298:                 .Header1.FontSize  = 8
299:                 .Header1.FontBold  = .F.
300:                 .Header1.Alignment = 2
301:             ENDWITH
302: 
303:             *-- Coluna 5: Qtd.Atual (QtdDivs, editavel ? Format K preserva valor atual)
304:             WITH .Column5
305:                 .ControlSource = "cursor_4c_DivOp.QtdDivs"
306:                 .Width         = 130
307:                 .FontName      = "Arial"
308:                 .FontSize      = 8
309:                 .Alignment     = 1
310:                 .Format        = "K"
311:                 .Movable       = .F.
312:                 .Resizable     = .F.
313:                 .Header1.Caption   = "Qtd.Atual"
314:                 .Header1.FontName  = "Arial"
315:                 .Header1.FontSize  = 8
316:                 .Header1.FontBold  = .F.
317:                 .Header1.Alignment = 2
318:             ENDWITH
319:         ENDWITH
320: 

*-- Linhas 433 a 451:
433:             .ForeColor        = RGB(0, 0, 0)
434:             .ScrollBars       = 2
435:             .ReadOnly         = .T.
436:             .ControlSource    = "cursor_4c_DivOp.Obss"
437:             .ToolTipText      = "Observa" + CHR(231) + CHR(245) + "es do item selecionado no grid"
438:         ENDWITH
439:     ENDPROC
440: 
441:     *---------------------------------------------------------------------------
442:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
443:     *-- Form OPERACIONAL nao possui PageFrame (layout plano). Metodo mantido por
444:     *-- compatibilidade com padrao dos forms CRUD e para uso futuro caso o form
445:     *-- evolua para multi-pagina. Devolve foco ao campo O.P. quando invocado.
446:     *---------------------------------------------------------------------------
447:         LOCAL loc_nPagina
448:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
449: 
450:         DO CASE
451:             CASE loc_nPagina = 1

*-- Linhas 500 a 518:
500: 
501:         *-- Zerar cursor de trabalho antes de qualquer carga
502:         IF USED(THIS.this_cCursorDivOp)
503:             SELECT (THIS.this_cCursorDivOp)
504:             ZAP
505:         ENDIF
506: 
507:         *-- Desabilitar botao Confirmar enquanto O.P. nao for validada
508:         THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
509:         THIS.txt_4c_Produto.Value = ""
510: 
511:         loc_nOP = INT(NVL(THIS.txt_4c_OP.Value, 0))
512:         IF loc_nOP <= 0
513:             THIS.grd_4c_Dados.Refresh()
514:             RETURN
515:         ENDIF
516: 
517:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
518:             MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")

*-- Linhas 604 a 622:
604: 
605:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
606:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
607:                 SELECT (THIS.this_cCursorDivOp)
608:                 GO TOP
609:                 THIS.grd_4c_Dados.SetFocus()
610:             ENDIF
611:         ELSE
612:             THIS.txt_4c_OP.SetFocus()
613:         ENDIF
614:     ENDPROC
615: 
616:     *---------------------------------------------------------------------------
617:     PROCEDURE BtnSalvarClick()
618:     *-- Grava as alteracoes das divisoes da O.P. Alias semantico para o botao
619:     *-- Confirmar do CommandGroup ??? mesma logica de BtnConfirmarClick (o form
620:     *-- operacional SIGPRAOP usa "Confirmar" na UI, mas o pipeline de validacao
621:     *-- espera BtnSalvarClick por convencao dos forms CRUD).
622:     *---------------------------------------------------------------------------

*-- Linhas 640 a 658:
640:     *-- semanticamente a "iniciar novo lote de alteracoes" no fluxo operacional.
641:     *---------------------------------------------------------------------------
642:         IF USED(THIS.this_cCursorDivOp)
643:             SELECT (THIS.this_cCursorDivOp)
644:             ZAP
645:         ENDIF
646: 
647:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
648:             THIS.txt_4c_OP.Value      = 0
649:             THIS.txt_4c_OP.Enabled    = .T.
650:             THIS.txt_4c_OP.ReadOnly   = .F.
651:             THIS.txt_4c_OP.BackColor  = RGB(255, 255, 255)
652:         ENDIF
653: 
654:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
655:             THIS.txt_4c_Produto.Value = ""
656:         ENDIF
657: 
658:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"

*-- Linhas 703 a 721:
703:         *-- Se carregou com sucesso (cursor com registros), foca no grid
704:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
705:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
706:                 SELECT (THIS.this_cCursorDivOp)
707:                 GO TOP
708:                 THIS.grd_4c_Dados.SetFocus()
709:             ENDIF
710:         ENDIF
711:     ENDPROC
712: 
713:     *---------------------------------------------------------------------------
714:     PROCEDURE BtnVisualizarClick()
715:     *-- Carrega as divisoes da O.P. em modo somente leitura (sem alteracao).
716:     *-- Torna a coluna Qtd.Atual read-only e desabilita o botao Confirmar
717:     *-- para impedir gravacao. Fluxo de consulta pura das quantidades atuais.
718:     *---------------------------------------------------------------------------
719:         IF !PEMSTATUS(THIS, "txt_4c_OP", 5) OR VARTYPE(THIS.txt_4c_OP) != "O"
720:             RETURN
721:         ENDIF

*-- Linhas 743 a 761:
743: 
744:         IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
745:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
746:                 SELECT (THIS.this_cCursorDivOp)
747:                 GO TOP
748:                 THIS.grd_4c_Dados.SetFocus()
749:             ENDIF
750:         ENDIF
751:     ENDPROC
752: 
753:     *---------------------------------------------------------------------------
754:     PROCEDURE BtnExcluirClick()
755:     *-- Descarta as alteracoes em andamento e retorna o form ao estado inicial.
756:     *-- Pede confirmacao ao usuario, executa TABLEREVERT no cursor de trabalho,
757:     *-- zera o cursor e limpa os campos. NUNCA exclui registros da tabela
758:     *-- SigOpPic (a exclusao definitiva nao faz parte deste fluxo operacional).
759:     *---------------------------------------------------------------------------
760:         LOCAL loc_lTemDados
761:         loc_lTemDados = USED(THIS.this_cCursorDivOp) AND ;

*-- Linhas 769 a 787:
769:             ENDIF
770: 
771:             *-- Descarta alteracoes em andamento no buffer do cursor
772:             SELECT (THIS.this_cCursorDivOp)
773:             TABLEREVERT(.T., THIS.this_cCursorDivOp)
774:             ZAP
775:         ENDIF
776: 
777:         *-- Reseta campos de identificacao
778:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
779:             THIS.txt_4c_OP.Value = 0
780:         ENDIF
781:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
782:             THIS.txt_4c_Produto.Value = ""
783:         ENDIF
784: 
785:         *-- Desabilita Confirmar e restaura coluna editavel
786:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"
787:             THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.

*-- Linhas 851 a 869:
851:     *-- Limpa todos os campos do form e reseta o cursor de trabalho
852:     *---------------------------------------------------------------------------
853:         IF USED(THIS.this_cCursorDivOp)
854:             SELECT (THIS.this_cCursorDivOp)
855:             ZAP
856:         ENDIF
857: 
858:         IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
859:             THIS.txt_4c_OP.Value     = 0
860:             THIS.txt_4c_OP.Enabled   = .T.
861:             THIS.txt_4c_OP.ReadOnly  = .F.
862:             THIS.txt_4c_OP.BackColor = RGB(255, 255, 255)
863:         ENDIF
864: 
865:         IF PEMSTATUS(THIS, "txt_4c_Produto", 5) AND VARTYPE(THIS.txt_4c_Produto) = "O"
866:             THIS.txt_4c_Produto.Value = ""
867:         ENDIF
868: 
869:         IF PEMSTATUS(THIS, "cmg_4c_BotoesConf", 5) AND VARTYPE(THIS.cmg_4c_BotoesConf) = "O"

*-- Linhas 896 a 914:
896:                       INT(NVL(THIS.txt_4c_OP.Value, 0)), 0)
897:         IF loc_nOP <= 0
898:             IF USED(THIS.this_cCursorDivOp)
899:                 SELECT (THIS.this_cCursorDivOp)
900:                 ZAP
901:             ENDIF
902:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
903:                 THIS.grd_4c_Dados.Refresh()
904:             ENDIF
905:             RETURN .F.
906:         ENDIF
907:         THIS.CarregarDivisoesOP()
908:         loc_lSucesso = USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
909:         RETURN loc_lSucesso
910:     ENDPROC
911: 
912:     *---------------------------------------------------------------------------
913:     PROCEDURE AjustarBotoesPorModo()
914:     *-- Ajusta estado dos botoes conforme presenca de dados no cursor de trabalho


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
                        SCAN FOR Nops = loc_nNops AND Citens = loc_nCitens AND SeqDivs = 0
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
                               "WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)
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

